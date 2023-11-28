""" Structural Comparison and Mapping tool """

from argparse import ArgumentParser
from collections import defaultdict
import logging
from pathlib import Path
import pickle
import sys
import time
from bidict import bidict

import spydrnet as sdn

from bfasst import jpype_jvm
from bfasst.utils import convert_verilog_literal_to_int
from bfasst.utils.general import log_with_banner
from bfasst.utils.sdn_helpers import SdnNetlistWrapper, SdnInstanceWrapper, SdnNet, SdnPinWrapper


class StructuralCompareError(Exception):
    """Exception for structural comparison errors"""


class StructuralCompare:
    """Structural compare and map"""

    def __init__(self, build_dir, netlist_a_path, netlist_b_path, log_path) -> None:
        self.build_dir = Path(build_dir)
        self.stage_dir = self.build_dir / "struct_cmp"

        self.netlist_a_path = netlist_a_path
        self.netlist_b_path = netlist_b_path
        self.named_netlist = None
        self.reversed_netlist = None

        self.log_path = log_path
        logging.basicConfig(
            filename=self.log_path,
            filemode="w",
            format="%(asctime)s %(message)s",
            level=logging.DEBUG,
            datefmt="%Y%m%d%H%M%S",
        )
        assert str(log_path).endswith("_cmp.log")

        self.block_mapping_pkl = (
            str(log_path).split("_cmp.log", maxsplit=1)[0] + "_block_mapping.pkl"
        )
        self.net_mapping_pkl = str(log_path).split("_cmp.log", maxsplit=1)[0] + "_net_mapping.pkl"
        self.comparison_time_log = (
            str(log_path).split("_cmp.log", maxsplit=1)[0] + "_comparison_time.txt"
        )

        self.block_mapping = bidict()
        self.net_mapping = bidict()

        self._cell_props = None
        self.__set_cell_props()

        self.possible_matches = {}
        self.gnd_mappings = set()
        self.vcc_mappings = set()

        self.start_time = 0
        self.end_time = 0

        jpype_jvm.start()

    def __set_cell_props(self):
        init_only = (
            "LUT6_2",
            "FDSE",
            "FDRE",
            "FDCE",
            "FDPE",
            "RAM32X1S",
            "RAM32X1D",
            "RAM32X1S_1",
            "RAM32X1D_1",
            "RAM256X1S",
            "SRL16E",
            "SRLC32E",
            "LDCE",
        )
        no_props = ("IBUF", "OBUF", "OBUFT", "MUXF7", "MUXF8", "CARRY4", "IOBUF", "GND", "VCC")

        _cell_props = {x: ("INIT",) for x in init_only}
        _cell_props.update({x: () for x in no_props})
        _cell_props["RAM32M"] = ("INIT_A", "INIT_B", "INIT_C", "INIT_D")
        _cell_props["RAM64M"] = ("INIT_A", "INIT_B", "INIT_C", "INIT_D")
        _cell_props["RAMB36E1"] = tuple(
            [f"INIT_{i:02X}" for i in range(int("0x80", base=16))]
            + ["DOA_REG", "DOB_REG", "RAM_MODE"]
        )
        # TODO add INIT_A, INIT_B, INITP_00 - INITP_0F
        _cell_props["RAMB18E1"] = tuple(
            f"INIT_{i:02X}" for i in range(int("0x40", base=16))
        )  # TODO add INIT_A, INIT_B, INITP_00 - INITP_07
        _cell_props["BUFGCTRL"] = (
            "INIT_OUT",
            "IS_CE0_INVERTED",
            "IS_CE1_INVERTED",
            "IS_IGNORE0_INVERTED",
            "IS_IGNORE1_INVERTED",
            "IS_S0_INVERTED",
            "IS_S1_INVERTED",
            "PRESELECT_I0",
            "PRESELECT_I1",
        )

        self._cell_props = _cell_props

    def reset_mappings(self):
        self.block_mapping = bidict()
        self.net_mapping = bidict()

    def load_mappings(self):
        """Init mapping data structures from pkl files"""
        with open(self.block_mapping_pkl, "rb") as f:
            block_map = pickle.load(f)
        with open(self.net_mapping_pkl, "rb") as f:
            net_map = pickle.load(f)

        self.map_ports()
        for lh, rh in block_map.items():
            lh_instance = [i for i in self.named_netlist.instances if i.name == lh][0]
            rh_instance = [i for i in self.reversed_netlist.instances if i.name == rh][0]
            self.block_mapping[lh_instance] = rh_instance
        for lh, rh in net_map.items():
            # Sometimes multiple net objects have the same name, like gnd nets,
            # so this is not guaranteed to recreate the exact same data
            # structure.  But, as far as I know, only this only occurs with
            # const nets, so result should be functionally the same.
            # Also, manually added pin.ignore_net_equivalency for brams are
            # not updated here, so it will trigger failures in equivalence
            # checking that must be manually reviewed.
            lh_net = [n for n in self.named_netlist.nets if n.name == lh][0]
            rh_net = [n for n in self.reversed_netlist.nets if n.name == rh][0]
            self.net_mapping[lh_net] = rh_net

    def init_netlists(self):
        """Load both netlists from spydrnet and build wrapper objects"""
        log_with_banner("Building netlist A %s", self.netlist_a_path)

        # Loads the first netlist as intermediate representation (ir1)
        ir_a = sdn.parse(str(self.netlist_a_path))
        library_a = ir_a.libraries[0]
        netlist_a = self.get_netlist(library_a)
        logging.info("Netlist A size:  %s", len(netlist_a.instances))

        log_with_banner("Building netlist B %s", self.netlist_b_path)

        # Loads the second netlist as intermediate representation (ir2)
        ir_b = sdn.parse(str(self.netlist_b_path))
        library_b = ir_b.libraries[0]
        netlist_b = self.get_netlist(library_b)
        logging.info("Netlist B size: %s", len(netlist_b.instances))

        # golden_netlist = [i for i in golden_netlist if i.name not in ("GND")]

        self.named_netlist = netlist_a
        self.reversed_netlist = netlist_b

    def compare_netlists(self):
        """Map the golden and reversed netlists through automated block mapping"""
        self.start_time = time.time()

        t_begin = time.perf_counter()
        self.init_netlists()

        logging.info("Time after init_netlists: %s".ljust(35), str(time.perf_counter() - t_begin))

        # self.load_mappings()
        # Structurally map the rest of the netlists
        self.perform_mapping()
        t_end = time.perf_counter()

        log_with_banner("Mapping (Instances)")
        block_map = {k.name: v.name for k, v in self.block_mapping.items()}
        for key, val in self.block_mapping.items():
            logging.info("%s -> %s", key.name, val.name)
        logging.info("")
        # log_with_banner("Mapping (Nets)")
        net_map = {k.name: v.name for k, v in self.net_mapping.items()}
        for key, val in self.net_mapping.items():
            logging.info("%s -> %s", key.name, val.name)

        log_with_banner("Finalizing")
        self.named_netlist.instances_to_map = {
            i for i in self.named_netlist.instances if i.cell_type not in ("GND", "VCC")
        }
        logging.info(
            "Number of mapped blocks: %s of %s",
            len(self.block_mapping),
            len(self.named_netlist.instances_to_map),
        )
        logging.info("  Unmapped blocks:")
        for block in [
            block
            for block in self.named_netlist.instances_to_map
            if block not in self.block_mapping
        ]:
            logging.info("    %s", block.name)

        num_mapped_nets = (
            len([net for net in self.net_mapping if net.is_connected])
            + len(self.vcc_mappings)
            + len(self.gnd_mappings)
        )
        num_total_nets = len(self.named_netlist.get_connected_nets())
        logging.info("Number of mapped nets: %s of %s", num_mapped_nets, num_total_nets)

        logging.info("  Unmapped nets:")
        for net in [
            net
            for net in self.named_netlist.get_connected_nets()
            if net not in self.net_mapping
            and net.name not in self.vcc_mappings
            and net.name not in self.gnd_mappings
        ]:
            # if net.is_vdd or net.is_gnd:
            #     num_total_nets -= 1
            #     continue
            logging.info("    %s", net.name)

        if len(self.block_mapping) != len(self.named_netlist.instances_to_map):
            raise StructuralCompareError("Could not map all blocks")
        if num_mapped_nets != num_total_nets:
            raise StructuralCompareError("Could not map all nets")

        logging.info(
            "Dumping mapping pkls to %s and %s",
            str(self.block_mapping_pkl),
            str(self.net_mapping_pkl),
        )
        with open(self.block_mapping_pkl, "wb") as f:
            pickle.dump(block_map, f)

        with open(self.net_mapping_pkl, "wb") as f:
            pickle.dump(net_map, f)

        mtime = round(t_end - t_begin, 1)
        logging.info("Mapping time: %s seconds", mtime)

        # After establishing mapping, verify equivalence
        t_begin = time.perf_counter()
        self.verify_equivalence()
        t_end = time.perf_counter()
        vtime = round(t_end - t_begin, 1)
        logging.info("Equivalence verification time: %s seconds", vtime)
        logging.info("Total time: %s seconds", mtime + vtime)

        self.end_time = time.time()
        total_time_msg = "Total time: ".ljust(35) + str(self.end_time - self.start_time)
        logging.info(total_time_msg)
        with open(self.comparison_time_log, "w") as f:
            f.write(f"{self.end_time - self.start_time}\n")

    def map_ports(self):
        """Map top-level ports"""
        log_with_banner("Mapping top-level ports")
        for pin in self.named_netlist.pins:
            assert isinstance(pin, SdnPinWrapper)
            reversed_pin = self.reversed_netlist.get_pin(pin.name, pin.index)
            logging.info(
                "Mapping port %s[%s] to %s[%s]",
                pin.name,
                pin.index,
                reversed_pin.name,
                reversed_pin.index,
            )
            try:
                self.add_net_mapping(
                    pin.net,
                    reversed_pin.net,
                )
            except KeyError as err:
                raise StructuralCompareError(
                    f"KeyError during port mapping, is the I/O {pin.name} "
                    + "signal a reserved HDL keyword?"
                ) from err

    def init_matching_instances(self):
        """Init possible_matches dict with all instances that match by cell type and properties"""
        all_instances = [
            i for i in self.reversed_netlist.instances if not i.cell_type.startswith("SDN_VERILOG")
        ]

        grouped_by_cell_type = defaultdict(list)
        for instance in all_instances:
            properties = set()
            for prop in self.get_properties_for_type(instance.cell_type):
                properties.add(f"{prop}{convert_verilog_literal_to_int(instance.properties[prop])}")
                # properties[prop] = convert_verilog_literal_to_int(instance.properties[prop])

            grouped_by_cell_type[(instance.cell_type, hash(frozenset(properties)))].append(instance)

        for named_instance in self.named_netlist.instances_to_map:
            ###############################################################
            # First find all instances of the same type and same properties
            ###############################################################

            # Compute a hash of this instance's properties
            properties = set()
            for prop in self.get_properties_for_type(named_instance.cell_type):
                properties.add(
                    f"{prop}{convert_verilog_literal_to_int(named_instance.properties[prop])}"
                )
            my_hash = hash(frozenset(properties))

            instances_matching = grouped_by_cell_type[(named_instance.cell_type, my_hash)]

            if not instances_matching:
                logging.info(
                    "No property matches for cell %s of type %s. Properties:",
                    named_instance.name,
                    named_instance.cell_type,
                )
                for prop in self.get_properties_for_type(named_instance.cell_type):
                    logging.info("  %s: %s", prop, named_instance.properties[prop])
                raise StructuralCompareError(
                    f"Not equivalent. {named_instance.name} has no possible match in the netlist."
                )

            self.possible_matches[named_instance] = instances_matching.copy()

    def potential_mapping_wrapper(self, instance):
        """Wrap check_for_potential_mapping some inital checks/postprocessing"""

        # Skip assign statements (named netlist shouldn't have them)
        # Update: just let the code break if this happens
        # assert not instance.cell_type.startswith("SDN_VERILOG_ASSIGNMENT")

        logging.info("Considering %s (%s)", instance.name, instance.cell_type)

        # Get the implemented potential instance to map
        if not instance.cell_type.startswith("RAMB"):
            instances_matching = self.check_for_potential_mapping(instance)
        else:
            instances_matching = self.check_for_potential_bram_mapping(instance)

        # self.log(f"  {instances_matching} matches")

        if not instances_matching:
            raise StructuralCompareError(
                f"Not equivalent. {instance.name} has no possible match in the netlist."
            )

        if len(instances_matching) > 1:
            logging.info("  %s matches, skipping for now:", len(instances_matching))
            if len(instances_matching) < 10:
                for matched_instance in instances_matching:
                    logging.info("    %s", matched_instance.name)
            return False

        assert len(instances_matching) == 1
        matched_instance = instances_matching[0]

        logging.info("  Mapped to %s", matched_instance.name)

        self.add_block_mapping(instance, matched_instance)
        return True

    def perform_mapping(self):
        """Maps netlists based on their cells and nets"""

        # First map top-level nets
        self.map_ports()

        # Init possible_matches dict with all instances that match by cell type and properties
        self.init_matching_instances()
        logging.info("Time after initial cache: %s".ljust(35), str(time.time() - self.start_time))

        log_with_banner("Starting mapping iterations")

        # Loop until all blocks have been mapped or there is no more progress
        overall_progress = True
        iteration = 0
        while self.named_netlist.instances_to_map:
            if not overall_progress:
                num_mapped_nets = (
                    len([net for net in self.net_mapping if net.is_connected()])
                    + len(self.vcc_mappings)
                    + len(self.gnd_mappings)
                )
                num_total_nets = len(self.named_netlist.get_connected_nets())
                cell_type = {i.cell_type for i in self.named_netlist.instances_to_map}
                if len(cell_type) == 1 and num_mapped_nets == num_total_nets:
                    reversed_remaining = [
                        self.possible_matches[i] for i in self.named_netlist.instances_to_map
                    ]
                    remaining = set()
                    for i in reversed_remaining:
                        for j in i:
                            remaining.add(j.name)
                    if len(remaining) == len(reversed_remaining[0]):
                        for named, rev in zip(
                            self.named_netlist.instances_to_map, reversed_remaining[0]
                        ):
                            self.add_block_mapping(named, rev)
                        break

                logging.info("No more progress can be made. Failed at iteration %s.", iteration)
                break
            overall_progress = False

            logging.info("===== Mapping Iteration %s =====", iteration)

            # Loop through reversed netlist blocks
            instance_iter = iter(set(self.named_netlist.instances_to_map))
            try:
                while not overall_progress:
                    overall_progress = self.potential_mapping_wrapper(next(instance_iter))
                while True:
                    self.potential_mapping_wrapper(next(instance_iter))
            except StopIteration:
                pass
            iteration += 1

    def verify_equivalence(self):
        """Verify equivalence by looping through all mapped instances and
        checking that for each pin, the connected nets are also mapped
        to each other."""

        # Loop through all instances and check for equivalence
        log_with_banner("Verifying equivalence")
        warnings = []
        for instance in self.named_netlist.instances_to_map:
            mapped_instance = self.block_mapping.get(instance)
            if mapped_instance is None:
                raise StructuralCompareError(
                    f"Not equivalent. Instance {instance.name} is not mapped to anything."
                )

            # Loop through all pins on instance and compare nets
            for pin_a in instance.pins:
                if pin_a.ignore_net_equivalency or not pin_a.net.is_connected:
                    continue
                pin_b = mapped_instance.get_pin(pin_a.name, pin_a.index)

                net_a = pin_a.net
                net_b = None if pin_b is None else pin_b.net
                net_a_empty = net_a is None or not net_a.is_connected
                net_b_empty = net_b is None or not net_b.is_connected

                if net_a_empty and not net_b_empty:
                    warnings.append(
                        (
                            f"Not equivalent. Pin {pin_b.name_with_index} of "
                            f"{mapped_instance.name} is connected to net {net_b.name},"
                            f" but no connection on mapped instance {instance.name}."
                        )
                    )

                if net_b_empty and not net_a_empty:
                    warnings.append(
                        (
                            f"Not equivalent. Pin {pin_a.name_with_index} of {instance.name}"
                            f" is connected to net {net_a.name},"
                            f" but no connection on mapped instance {mapped_instance.name}."
                        )
                    )

                if not net_a_empty:
                    if (net_a.name in self.vcc_mappings and net_b.is_vdd) or (
                        net_a.name in self.gnd_mappings and net_b.is_gnd
                    ):
                        continue
                    if (self.net_mapping[net_a].is_gnd and net_b.is_gnd) or (
                        self.net_mapping[net_a].is_vdd and net_b.is_vdd
                    ):
                        continue
                    if self.net_mapping[net_a] != net_b:
                        pin_str = f"{pin_a.name}[{pin_a.index}]"
                        warnings.append(
                            (
                                f"Not equivalent. Net {net_a.name} on {pin_str} is mapped to "
                                f"{self.net_mapping[net_a].name} but should be {net_b.name}"
                            )
                        )
        if not warnings:
            logging.info("Equivalence verified")
        else:
            logging.info("Equivalence questionable")
            raise StructuralCompareError("Warnings during equivalence verification")

    def add_block_mapping(self, instance, matched_instance):
        """Add mapping point between two Instances"""

        self.block_mapping[instance] = matched_instance
        self.named_netlist.instances_to_map.remove(instance)

        for pin in instance.pins:
            # Some pins should not be used to establish net mapping
            if pin.ignore_net_equivalency:
                continue

            net_a = pin.net

            if net_a is None or not net_a.is_connected:
                # Disconnected pin
                continue

            assert isinstance(net_a, SdnNet)
            if net_a in self.net_mapping:
                continue

            if instance.cell_type != "RAM32M" or not pin.name.startswith("D"):
                # for some reason RW sets DI* to the wrong bit, and SDN reads
                # DO* from the wrong bit for f2b netlist
                idx = pin.index
            else:
                idx = 0 if pin.index == 1 else 1

            pin_b = matched_instance.get_pin(pin.name, idx)
            if pin_b is None:
                continue
            net_b = pin_b.net
            assert net_b, f"{pin_b.name} of {matched_instance.name} is not connected"
            if net_b is None and net_a.is_gnd:
                continue
            assert isinstance(net_b, SdnNet), f"{net_b} is not a net"

            if net_a in self.net_mapping:
                assert net_b == self.net_mapping[net_a]
                continue

            if instance.cell_type == "RAM32M" and pin.name.startswith("DI"):
                # DI* doesn't matter if the corresponding output bit is not used
                out_net = matched_instance.get_pin(f"DO{pin.name[2]}", idx).net
                if out_net is None or out_net.is_gnd or len(out_net.wire.pins) <= 1:
                    continue

            logging.info(
                "    Net %s mapped to %s (from %s)",
                net_a.name.strip(),
                net_b.name,
                pin.name,
            )
            self.add_net_mapping(net_a, net_b)

    def add_net_mapping(self, net1, net2):
        """Add mapping point between two Nets"""
        assert net1 not in self.net_mapping
        if net2 in self.net_mapping.inverse:
            if net2.is_gnd:
                assert net1.name not in self.vcc_mappings
                self.gnd_mappings.add(net1.name)
            elif net2.is_vdd:
                assert net1.name not in self.gnd_mappings
                self.vcc_mappings.add(net1.name)
            else:
                raise AssertionError(
                    f"{net2.name} in net_mapping.inverse already. net1: {net1.name}"
                )
            return

        self.net_mapping[net1] = net2

    def check_for_potential_bram_mapping(self, named_instance):
        """Special mapping checker for BRAMs"""
        bram_do = False
        bram_a_only = False
        bram_do = named_instance.properties["DOA_REG"] == "0"
        if bram_do:
            assert named_instance.properties["DOB_REG"] == "0"

        bram_a_only = named_instance.properties["RAM_MODE"] == '"TDP"' and {
            None,
            SdnInstanceWrapper.GND_PIN.net,
        } >= {
            named_instance.get_pin("DOBDO", i).net
            for i in range(32)
            if named_instance.get_pin("DOBDO", i) is not None
        }

        if named_instance.cell_type.startswith("RAMB36E1"):
            # A15 is only connected to a non-const net when cascade is enabled
            # Right now, it seems vivado will connect to vcc, although unconnected is valid
            expected_properties = (
                named_instance.properties["RAM_EXTENSION_A"] == '"NONE"'
                and named_instance.properties["RAM_EXTENSION_B"] == '"NONE"'
                and named_instance.get_pin("ADDRARDADDR", 15).net.is_vdd
                and named_instance.get_pin("ADDRBWRADDR", 15).net.is_vdd
            )
            if not expected_properties:
                raise StructuralCompareError("Unexpected BRAM CASCADE Configuration")

        instances_matching_connections = [
            i for i in self.possible_matches[named_instance] if i not in self.block_mapping.inverse
        ]

        for pin in named_instance.pins:
            # Skip pin that is not yet mapped
            if pin.net not in self.net_mapping:
                continue

            # For RAMB18E1, "REGCEAREGCE" and "REGCEB" only depend on DOA_REG and DOB_REG
            # This should be revisited where the DO* assertion fails
            if bram_do and pin.name in {
                "RSTREGARSTREG",
                "RSTREGB",
                "REGCEAREGCE",
                "REGCEB",
            }:
                pin.ignore_net_equivalency = True
                continue  # These pins are ignored when DO_REG is 0
            if pin.name in {"RSTRAMARSTRAM", "RSTRAMB"}:
                # FASM2BELS ties these to vcc which doesn't make sense. Should be gnd.
                pin.ignore_net_equivalency = True
                continue
            # These pins can be vdd or gnd when cascade is off
            if bram_a_only and pin.name in {
                "CASCADEINB",
                "CASCADEOUTB",
                "CLKBWRCLK",
                "ENBWREN",
                "RSTRAMB",
            }:
                pin.ignore_net_equivalency = True
                continue

            # Otherwise pin connected to a mapped net, and filter based on instances that are
            # connected to the corresponding mapped net.
            other_net = self.net_mapping[pin.net]

            logging.info("  Filtering on pin %s, %s", pin.name_with_index, other_net.name)

            idx = pin.index

            tmp = [
                instance
                for instance in instances_matching_connections
                if instance.get_pin(pin.name, idx).net == other_net
            ]

            if not tmp:
                if other_net.is_gnd:
                    tmp = [
                        instance
                        for instance in instances_matching_connections
                        if instance.get_pin(pin.name, idx).net is None
                        or instance.get_pin(pin.name, idx).net.is_gnd
                    ]
                elif other_net.is_vdd:
                    tmp = [
                        instance
                        for instance in instances_matching_connections
                        if instance.get_pin(pin.name, idx).net.is_vdd
                    ]
            instances_matching_connections = tmp

            num_instances = len(instances_matching_connections)
            info = (
                ": " + ",".join(i.name for i in instances_matching_connections)
                if num_instances <= 10
                else ""
            )
            logging.info("    %s remaining%s", num_instances, info)

        logging.info(
            "  %s instance(s) after filtering on connections", len(instances_matching_connections)
        )
        self.possible_matches[named_instance] = instances_matching_connections
        return instances_matching_connections

    def check_for_potential_mapping(self, named_instance):
        """Returns cells that could map to the named_instance"""

        ###############################################################
        # Now look at connections
        ###############################################################

        instances_matching_connections = [
            i for i in self.possible_matches[named_instance] if i not in self.block_mapping.inverse
        ]

        for pin in named_instance.pins:
            # Skip pin that is not yet mapped
            if pin.net not in self.net_mapping:
                continue

            # Otherwise pin connected to a mapped net, and filter based on instances that are
            # connected to the corresponding mapped net.
            other_net = self.net_mapping[pin.net]

            logging.info("  Filtering on pin %s, %s", pin.name_with_index, other_net.name)

            # Extra step for LUTRAMS
            if named_instance.cell_type != "RAM32M" or not pin.name.startswith("D"):
                # for some reason RW sets DI* to the wrong bit, and SDN reads
                # DO* from the wrong bit for f2b netlist
                idx = pin.index
            else:
                idx = 0 if pin.index == 1 else 1

            tmp = [
                instance
                for instance in instances_matching_connections
                if instance.get_pin(pin.name, idx).net == other_net
            ]

            if named_instance.cell_type == "BUFGCTRL" and pin.name[0] == "I" and not tmp:
                # sometimes f2b routes the clk net to both inputs
                other_pin = f"I{'1' if pin.name[1] == '0' else '0'}"
                tmp = [
                    inst
                    for inst in instances_matching_connections
                    if inst.get_pin(pin.name, idx).net == inst.get_pin(other_pin, idx).net
                ]
                pin.ignore_net_equivalency = True

            if not tmp:
                if other_net.is_gnd:
                    tmp = [
                        instance
                        for instance in instances_matching_connections
                        if instance.get_pin(pin.name, idx).net is None
                        or instance.get_pin(pin.name, idx).net.is_gnd
                    ]
                elif other_net.is_vdd:
                    tmp = [
                        instance
                        for instance in instances_matching_connections
                        if instance.get_pin(pin.name, idx).net.is_vdd
                    ]
            instances_matching_connections = tmp

            num_instances = len(instances_matching_connections)
            info = (
                ": " + ",".join(i.name for i in instances_matching_connections)
                if num_instances <= 10
                else ""
            )
            logging.info("    %s remaining%s", num_instances, info)

        logging.info(
            "  %s instance(s) after filtering on connections", len(instances_matching_connections)
        )
        self.possible_matches[named_instance] = instances_matching_connections
        return instances_matching_connections

    def get_properties_for_type(self, cell_type):
        """Return the list of properties that must match for a given cell type
        for the cell to be considered equivalent."""
        try:
            return self._cell_props[cell_type]
        except KeyError as err:
            raise StructuralCompareError(f"Unhandled properties for type {cell_type}") from err

    def get_netlist(self, library):
        return SdnNetlistWrapper(library)


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument(
        "--build_dir",
        type=str,
        help="The design build directory (e.g. build/byu/alu)",
    )
    parser.add_argument(
        "--netlists",
        type=str,
        nargs=2,
        help="The full path for the first netlist for comparison",
    )
    parser.add_argument("--log_path", type=str, help="The log file path to use as output")
    args = parser.parse_args()
    struct_cmp = StructuralCompare(
        args.build_dir, args.netlists[0], args.netlists[1], args.log_path
    )
    try:
        struct_cmp.compare_netlists()
        logging.info("SUCCESS")
    except StructuralCompareError as e:
        logging.error("FAIL: %s", e)
        sys.exit(1)
