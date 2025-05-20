""" Structural Comparison and Mapping tool """

from argparse import ArgumentParser
from collections import defaultdict
import logging
import pickle
import sys
import time
import os
import difflib
from bidict import bidict
import spydrnet as sdn


from bfasst import jpype_jvm
from bfasst.utils import convert_verilog_literal_to_int
from bfasst.utils.structural_helpers import create_cell_props, count_num_const
from bfasst.utils.general import log_with_banner
from bfasst.utils.sdn_helpers import SdnNetlistWrapper, SdnInstanceWrapper, SdnNet, SdnPinWrapper

# pylint: disable=wrong-import-order
from com.xilinx.rapidwright.design import Design

# pylint: enable=wrong-import-order


class StructuralCompareError(Exception):
    """Exception for structural comparison errors"""


class StructuralCompare:
    """Structural compare and map"""

    def __init__(
        self,
        named_netlist_path,
        reversed_netlist_path,
        log_path,
        *,
        debug=False,
        logging_level="INFO",
    ) -> None:
        self.reversed_netlist_path = reversed_netlist_path
        self.named_netlist_path = named_netlist_path
        self.named_netlist = None
        self.named_instance_map = None
        self.reversed_netlist = None
        self.grouped_by_cell_type = defaultdict(list)
        self.debug = debug
        self.logging_level = logging_level

        self.log_path = log_path
        logging.basicConfig(
            filename=self.log_path,
            filemode="w",
            format="%(asctime)s %(message)s",
            level=self.logging_level,
            datefmt="%Y%m%d%H%M%S",
        )
        assert str(log_path).endswith("_cmp.log")

        self.possible_matches_cache_path = os.path.join(
            os.path.dirname(self.log_path), "possible_matches.pkl"
        )

        if self.debug:
            build_folder = os.path.dirname(os.path.dirname(self.log_path))
            dcp_path = os.path.join(build_folder, "vivado_impl/impl.dcp")
            edf_path = os.path.join(build_folder, "vivado_impl/viv_impl.edf")
            self.design = Design.readCheckpoint(
                dcp_path,
                edf_path,
            )

        self.block_mapping_pkl = (
            str(log_path).split("_cmp.log", maxsplit=1)[0] + "_block_mapping.pkl"
        )
        self.net_mapping_pkl = str(log_path).split("_cmp.log", maxsplit=1)[0] + "_net_mapping.pkl"
        self.comparison_time_log = (
            str(log_path).split("_cmp.log", maxsplit=1)[0] + "_comparison_time.txt"
        )

        self.block_mapping = bidict()
        self.net_mapping = bidict()

        self._cell_props = create_cell_props()
        self.possible_matches = {}
        self.gnd_mappings = set()
        self.vcc_mappings = set()

        self.start_time = 0
        self.end_time = 0

        jpype_jvm.start()

    def reset_mappings(self) -> None:
        self.block_mapping = bidict()
        self.net_mapping = bidict()

    def load_mappings(self) -> None:
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

    def init_netlists(self) -> None:
        """Load both netlists from spydrnet and build wrapper objects"""
        log_with_banner(f"Building reversed netlist {self.reversed_netlist_path}")

        # Loads the first netlist as intermediate representation (ir1)
        ir_a = sdn.parse(str(self.reversed_netlist_path))
        library_a = ir_a.libraries[0]
        netlist_a = self.get_netlist(library_a)
        logging.info("Netlist A size:  %s", len(netlist_a.instances))

        log_with_banner(f"Building named netlist B {self.named_netlist_path}")

        # Loads the second netlist as intermediate representation (ir2)
        ir_b = sdn.parse(str(self.named_netlist_path))
        library_b = ir_b.libraries[0]
        netlist_b = self.get_netlist(library_b)
        logging.info("Netlist B size: %s", len(netlist_b.instances))

        # golden_netlist = [i for i in golden_netlist if i.name not in ("GND")]

        self.reversed_netlist = netlist_a
        self.named_netlist = netlist_b
        self.named_netlist.instances_to_map = set()
        self.named_instance_map = {
            instance.name: instance for instance in self.named_netlist.instances
        }

    def compare_netlists(self) -> None:
        """Map the golden and reversed netlists through automated block mapping"""
        self.start_time = time.time()

        t_begin = time.perf_counter()
        self.init_netlists()

        logging.info("Time after init_netlists: %s".ljust(35), str(time.perf_counter() - t_begin))

        # a set of tuples with the first element being the instance name
        # and second element being which mapping function to use
        for i in self.named_netlist.instances:
            if i.cell_type in ("GND", "VCC"):
                continue
            if i.cell_type not in {"RAMB36E1", "RAMB18E1"}:
                self.named_netlist.instances_to_map.add((i.name, self.check_for_potential_mapping))
            else:
                self.named_netlist.instances_to_map.add(
                    (i.name, self.check_for_potential_bram_mapping)
                )

        # Structurally map the netlists
        self.perform_mapping()

        log_with_banner("Mapping (Instances)")
        for key, val in self.block_mapping.items():
            logging.debug("%s -> %s", key, val)
        log_with_banner("Mapping (Nets)")
        net_map = {k.name: v.name for k, v in self.net_mapping.items()}
        for key, val in self.net_mapping.items():
            logging.debug("%s -> %s", key.name, val.name)

        log_with_banner("Finalizing")

        should_be_mapped = {
            instance.name
            for instance in self.named_netlist.instances
            if instance.cell_type not in ("GND", "VCC")
        }

        logging.info(
            "Number of mapped blocks: %s of %s",
            len(self.block_mapping),
            len(should_be_mapped),
        )
        logging.error("  Unmapped blocks:")

        for block in [block for block in should_be_mapped if block not in self.block_mapping]:
            logging.error("    %s", block)

        num_mapped_nets = (
            len([net for net in self.net_mapping if net.is_connected])
            + len(self.vcc_mappings)
            + len(self.gnd_mappings)
        )
        num_total_nets = len(self.named_netlist.get_connected_nets())
        logging.info("Number of mapped nets: %s of %s", num_mapped_nets, num_total_nets)

        logging.error("  Unmapped nets:")
        for net in [
            net
            for net in self.named_netlist.get_connected_nets()
            if net not in self.net_mapping
            and net.name not in self.vcc_mappings
            and net.name not in self.gnd_mappings
        ]:

            logging.error("    %s", net.name)

        if len(self.block_mapping) != len(should_be_mapped):
            raise StructuralCompareError("Could not map all blocks")
        if num_mapped_nets != num_total_nets:
            raise StructuralCompareError("Could not map all nets")

        logging.info(
            "Dumping mapping pkls to %s and %s",
            str(self.block_mapping_pkl),
            str(self.net_mapping_pkl),
        )
        with open(self.block_mapping_pkl, "wb") as f:
            pickle.dump(dict(self.block_mapping.items()), f)

        with open(self.net_mapping_pkl, "wb") as f:
            pickle.dump(net_map, f)

        mtime = round(time.perf_counter() - t_begin, 1)
        logging.info("Mapping time: %s seconds", mtime)

        # After establishing mapping, verify equivalence
        t_begin = time.perf_counter()
        self.verify_equivalence()
        vtime = round(time.perf_counter() - t_begin, 1)
        logging.info("Equivalence verification time: %s seconds", vtime)
        logging.info("Total time: %s seconds", mtime + vtime)

        self.end_time = time.time()
        total_time_msg = "Total time: ".ljust(35) + str(self.end_time - self.start_time)
        logging.info(total_time_msg)
        with open(self.comparison_time_log, "w") as f:
            f.write(f"{self.end_time - self.start_time}\n")

    def map_ports(self) -> None:
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

    # def init_matching_instances(self) -> None:
    #     """Init possible_matches dict with all instances that match by cell type and properties"""

    #     if self.debug and os.path.exists(self.possible_matches_cache_path):
    #         log_with_banner("Loading possible matches from cache")
    #         with open(self.possible_matches_cache_path, "rb") as f:
    #             self.possible_matches = pickle.load(f)

    #     else:
    #         log_with_banner("Initializing possible matches based on cell type and properties")

    #         grouped_by_cell_type = defaultdict(list)
    #         grouped_by_cell_type_and_const = defaultdict(list)
    #         for instance in self.reversed_netlist.instances:
    #             if instance.cell_type.startswith("SD"):
    #                 continue

    #             num_const = count_num_const(instance.pins)
    #             properties = set()
    #             for prop in self.get_properties_for_type(instance.cell_type):
    #                 properties.add(
    #                     f"{prop}{convert_verilog_literal_to_int(instance.properties[prop])}"
    #                 )

    #             grouped_by_cell_type_and_const[
    #                 (instance.cell_type, hash(frozenset(properties)), num_const)
    #             ].append(self.reversed_netlist.instances.index(instance))

    #             grouped_by_cell_type[(instance.cell_type, hash(frozenset(properties)))].append(
    #                 self.reversed_netlist.instances.index(instance)
    #             )

    #         for instance_name, _ in self.named_netlist.instances_to_map:
    #             ###############################################################
    #             # First find all instances of the same type and same properties
    #             ###############################################################

    #             # Compute a hash of this instance's properties
    #             instance = self.named_instance_map[instance_name]
    #             num_const = count_num_const(instance.pins)
    #             properties = set()
    #             for prop in self.get_properties_for_type(instance.cell_type):
    #                 properties.add(
    #                     f"{prop}{convert_verilog_literal_to_int(instance.properties[prop])}"
    #                 )
    #             my_hash = hash(frozenset(properties))

    #             instances_matching = grouped_by_cell_type_and_const[
    #                 (instance.cell_type, my_hash, num_const)
    #             ]

    #             if not instances_matching:
    #                 instances_matching = grouped_by_cell_type[(instance.cell_type, my_hash)]
    #                 if not instances_matching:
    #                     logging.error(
    #                         "No property matches for cell %s of type %s. Properties:",
    #                         instance_name,
    #                         instance.cell_type,
    #                     )
    #                     for prop in self.get_properties_for_type(instance.cell_type):
    #                         logging.error("  %s: %s", prop, instance.properties[prop])
    #                     raise StructuralCompareError(
    #                         f"Not equivalent. {instance_name} \
    #                         has no possible match in the netlist."
    #                     )

    #             self.possible_matches[instance_name] = set(instances_matching)
    #         with open(self.possible_matches_cache_path, "wb") as f:
    #             pickle.dump(self.possible_matches, f)

    
       

    def potential_mapping_wrapper(self, instance_tuple: tuple) -> bool:
        """Wrap check_for_potential_mapping some inital checks/postprocessing"""
        instance = self.named_instance_map[instance_tuple[0]]
        logging.info("Considering %s (%s)", instance_tuple[0], instance.cell_type)
        instances_matching = instance_tuple[1](instance_tuple[0])

        if not instances_matching:
            if not self.debug:
                raise StructuralCompareError(
                    f"Not equivalent. {instance_tuple[0]} has no possible match in the netlist."
                )
            try:
                cell = self.design.getCell(instance_tuple[0])
                if not cell:
                    # often, the cell name in vivado is a little bit different than in the netlist,
                    # so if it's not an exact match, I used difflib to get the closest match
                    # this has worked for me for the most part, but it might not always
                    cells = list(self.design.getCells())
                    actual_cell_name = str(
                        difflib.get_close_matches(
                            instance_tuple[0], [cell.getName() for cell in cells], n=1
                        )[0]
                    )
                    cell = [cell for cell in cells if cell.getName() == actual_cell_name][0]

                logging.error(
                    "%s should map to %s_%s_%s, but has no possible match in the netlist",
                    instance_tuple[0],
                    cell.getTile(),
                    cell.getSite(),
                    cell.getType(),
                )
            except IndexError:
                logging.error("%s has no possible match in the netlist", instance_tuple[0])
            self.named_netlist.instances_to_map.remove(instance_tuple)
            return False

        if len(instances_matching) > 1:
            logging.info("  %s matches, skipping for now:", len(instances_matching))
            return False

        assert len(instances_matching) == 1
        matched_instance = instances_matching.pop()

        logging.info("  Mapped to %s", self.reversed_netlist.instances[matched_instance].name)

        self.add_block_mapping(instance_tuple, matched_instance)
        # Remove the matched instance from the master prop dict
        for prop_list in self.grouped_by_cell_type.values():
            try:
                prop_list.remove(matched_instance)
                # The instance should only be in one of the lists so we can break once we've found it
                # Probably a more efficient way of doing this but this should work for now
                break
            except ValueError:
                pass
        
        return True

    def perform_mapping(self) -> None:
        """Maps netlists based on their cells and nets"""

        # First map top-level nets
        self.map_ports()

        # Init possible_matches dict with all instances that match by cell type and properties
        # self.init_matching_instances()
        
        # Sort all of the reversed instances by their cell type and properties to allow
        # for easier matching later
        self.get_grouped_instances()
        
        logging.info("Time after initial cache: %s".ljust(35), str(time.time() - self.start_time))

        log_with_banner("Starting mapping iterations")

        # Loop until all blocks have been mapped or there is no more progress
        overall_progress = True
        iteration = 0
        while self.named_netlist.instances_to_map:
            if not overall_progress:
                num_mapped_nets = (
                    len([net for net in self.net_mapping if net.is_connected])
                    + len(self.vcc_mappings)
                    + len(self.gnd_mappings)
                )
                num_total_nets = len(self.named_netlist.get_connected_nets())
                cell_type = {
                    self.named_instance_map[i].cell_type
                    for i, _ in self.named_netlist.instances_to_map
                }
                if len(cell_type) == 1 and num_mapped_nets == num_total_nets:
                    reversed_remaining = [
                        self.possible_matches[i] for i, _ in self.named_netlist.instances_to_map
                    ]
                    remaining = set()
                    for i in reversed_remaining:
                        for j in i:
                            remaining.add(j)
                    if len(remaining) == len(reversed_remaining[0]):
                        for named_tuple, rev in zip(
                            set(self.named_netlist.instances_to_map), reversed_remaining[0]
                        ):  # Make a copy of instances_to_map since python won't let you
                            # change the size of a set during iteration
                            self.add_block_mapping(named_tuple, rev)
                        break

                logging.info("No more progress can be made. Failed at iteration %s.", iteration)
                break
            overall_progress = False

            logging.info("===== Mapping Iteration %s =====", iteration)

            # Loop through reversed netlist blocks
            # Sort the instances based on the length of their possible matches list
            # sorted_instances = sorted(
            #     set(self.named_netlist.instances_to_map),
            #     key=lambda instance_tuple: len(self.possible_matches[instance_tuple[0]]),
            # )
            # Create an iterator from the sorted instances
            # instance_iter = iter(sorted_instances)
            instance_iter = iter(self.named_netlist.instances_to_map.copy())
            try:
                while not overall_progress:
                    overall_progress = self.potential_mapping_wrapper(next(instance_iter))
                while True:
                    self.potential_mapping_wrapper(next(instance_iter))
            except StopIteration:
                pass
            iteration += 1

    def verify_equivalence(self) -> None:
        """Verify equivalence by looping through all mapped instances and
        checking that for each pin, the connected nets are also mapped
        to each other."""

        # Loop through all instances and check for equivalence
        log_with_banner("Verifying equivalence")
        warnings = []
        for instance, _ in self.named_netlist.instances_to_map:
            mapped_instance = self.reversed_netlist.instances[self.block_mapping.get(instance)]
            if mapped_instance is None:
                raise StructuralCompareError(
                    f"Not equivalent. Instance {instance} is not mapped to anything."
                )

            # Loop through all pins on instance and compare nets
            for pin_a in self.named_instance_map[instance].pins:
                if pin_a.ignore_net_equivalency:
                    continue
                pin_b = mapped_instance.get_pin(pin_a.name, pin_a.index)

                net_a = pin_a.net
                net_b = None if pin_b is None else pin_b.net
                net_a_empty = net_a is None or not net_a.is_connected
                net_b_empty = net_b is None or not net_b.is_connected

                if net_a_empty != net_b_empty:
                    warnings.append(
                        (
                            f"Not equivalent. Pin "
                            f"{pin_a.name_with_index if not net_a_empty else pin_b.name_with_index}"
                            f" of {instance if not net_a_empty else mapped_instance.name}"
                            f" is connected to net {net_a.name if not net_a_empty else net_b.name},"
                            f" but no connection on mapped instance "
                            f"{mapped_instance.name if net_a_empty else instance}."
                        )
                    )
                    continue

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
            for warning in warnings:
                logging.warning("  %s", warning)
            raise StructuralCompareError("Warnings during equivalence verification")

    def add_block_mapping(self, instance_tuple: tuple, matched_instance_index: int) -> None:
        """Add mapping point between two Instances"""

        instance = self.named_instance_map[instance_tuple[0]]
        matched_instance = self.reversed_netlist.instances[matched_instance_index]
        self.block_mapping[instance_tuple[0]] = matched_instance_index
        self.named_netlist.instances_to_map.remove(instance_tuple)

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

    def add_net_mapping(self, net1, net2) -> None:
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
                raise StructuralCompareError(
                    f"{net2.name} in net_mapping.inverse already. net1: {net1.name}"
                )
            return

        self.net_mapping[net1] = net2

    # def eliminate_redundant_matches(self, instance_name: str) -> set[str]:
    #     return self.possible_matches[instance_name] - set(self.block_mapping.inverse)

    def make_matches_by_nets(
        self, instances_matching_connections, mapped_net, pin_name, pin_index
    ) -> set[str]:
        """Helper function for creating matches based off of net equivalence"""
        matches = {
            instance
            for instance in instances_matching_connections
            if self.reversed_netlist.instances[instance].get_pin(pin_name, pin_index).net
            == mapped_net
        }

        if not matches:
            if mapped_net.is_gnd:
                matches = {
                    instance
                    for instance in instances_matching_connections
                    if self.reversed_netlist.instances[instance]
                    .get_pin(pin_name, pin_index)
                    .net.is_gnd
                }
            elif mapped_net.is_vdd:
                matches = {
                    instance
                    for instance in instances_matching_connections
                    if self.reversed_netlist.instances[instance]
                    .get_pin(pin_name, pin_index)
                    .net.is_vdd
                }

        return matches

    def check_for_potential_bram_mapping(self, instance_name: str) -> set[str]:
        """Special mapping checker for BRAMs"""
        named_instance = self.named_instance_map[instance_name]
        bram_do = False
        bram_a_only = False
        bram_do = named_instance.properties["DOA_REG"] == "0"
        if bram_do:
            assert named_instance.properties["DOB_REG"] == "0"

        bram_a_only = named_instance.properties["RAM_MODE"] == '"TDP"' and {
            None,
            SdnInstanceWrapper.GND_PIN.net,
        } >= {named_instance.get_pin("DOBDO", i).net for i in range(32)}

        if named_instance.cell_type.startswith("RAMB36E1"):
            # A15 is only connected to a non-const net when cascade is enabled
            # Right now, it seems vivado will connect to vcc, although unconnected is valid
            expected_properties = (
                named_instance.properties["RAM_EXTENSION_A"] == '"NONE"'
                and named_instance.properties["RAM_EXTENSION_B"] == '"NONE"'
                and named_instance.get_pin("ADDRARDADDR", 15).net.is_vdd
                and named_instance.get_pin("ADDRBWRADDR", 15).net.is_vdd
                and named_instance.get_pin("CASCADEINA", 0).net.is_vdd
                and named_instance.get_pin("CASCADEINB", 0).net.is_vdd
                and named_instance.get_pin("CASCADEOUTA", 0).net.is_gnd
                and named_instance.get_pin("CASCADEOUTB", 0).net.is_gnd
            )

            if not expected_properties:
                if not self.debug:
                    raise StructuralCompareError("Unexpected BRAM CASCADE Configuration")
                logging.error("Unexpected BRAM CASCADE Configuration for %s", instance_name)

        instances_matching_connections = self.get_possible_matches(named_instance)

        for pin in named_instance.pins:
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
                "CASCADEINA",
                "CASCADEINB",
                "CASCADEOUTA",
                "CASCADEOUTB",
                "CLKBWRCLK",
                "ENBWREN",
            }:
                pin.ignore_net_equivalency = True
                continue

            if pin.net not in self.net_mapping:
                continue

            # Otherwise pin connected to a mapped net, and filter based on instances that are
            # connected to the corresponding mapped net.
            other_net = self.net_mapping[pin.net]

            logging.info("  Filtering on pin %s, %s", pin.name_with_index, other_net.name)

            temp_matches = self.make_matches_by_nets(
                instances_matching_connections, other_net, pin.name, pin.index
            )

            instances_matching_connections = temp_matches
            num_instances = len(instances_matching_connections)
            info = (
                ": "
                + ",".join(
                    self.reversed_netlist.instances[i].name for i in instances_matching_connections
                )
                if num_instances <= 10
                else ""
            )
            logging.info("    %s remaining%s", num_instances, info)

        logging.info(
            "  %s instance(s) after filtering on connections", len(instances_matching_connections)
        )
        self.possible_matches[named_instance] = instances_matching_connections
        return instances_matching_connections

    def get_grouped_instances(self) -> None:
        for instance in self.reversed_netlist.instances:
            if instance.cell_type.startswith("SD"):
                continue

            properties = set()
            for prop in self.get_properties_for_type(instance.cell_type):
                properties.add(
                    f"{prop}{convert_verilog_literal_to_int(instance.properties[prop])}"
                )
            self.grouped_by_cell_type[(instance.cell_type, hash(frozenset(properties)))].append(
                self.reversed_netlist.instances.index(instance)
            )
    
    def get_possible_matches(self, instance) -> set[int]:
        """
        Get all of the possible matches for a signal instance
        """
        cell_type = instance.cell_type
        properties = set()
        for prop in self.get_properties_for_type(cell_type):
            properties.add(
                f"{prop}{convert_verilog_literal_to_int(instance.properties[prop])}"
            )
        my_hash = hash(frozenset(properties))
        return set(self.grouped_by_cell_type[(cell_type, my_hash)])
    
    def check_for_potential_mapping(self, instance_name: str) -> set[str]:
        """Returns cells that could map to the named_instance"""

        ###############################################################
        # Now look at connections
        ###############################################################

        instance = self.named_instance_map[instance_name]

        instances_matching_connections = self.get_possible_matches(instance)

        for pin in instance.pins:
            if pin.net not in self.net_mapping:
                continue

            # Otherwise pin connected to a mapped net, and filter based on instances that are
            # connected to the corresponding mapped net.
            other_net = self.net_mapping[pin.net]

            logging.info("  Filtering on pin %s, %s", pin.name_with_index, other_net.name)

            name = pin.name

            # Extra step for LUTRAMS
            if instance.cell_type != "RAM32M" or not name.startswith("D"):
                # for some reason RW sets DI* to the wrong bit, and SDN reads
                # DO* from the wrong bit for f2b netlist
                idx = pin.index
            else:
                idx = 0 if pin.index == 1 else 1

                if pin.ignore_net_equivalency:
                    continue

            temp_matches = self.make_matches_by_nets(
                instances_matching_connections, other_net, name, idx
            )

            if not temp_matches and instance.cell_type == "BUFGCTRL" and name[0] == "I":
                # sometimes f2b routes the clk net to both inputs
                other_pin = f"I{'1' if name[1] == '0' else '0'}"
                temp_matches = {
                    inst
                    for inst in instances_matching_connections
                    if self.reversed_netlist.instances[inst].get_pin(name, idx).net
                    == instance.get_pin(other_pin, idx).net
                }
                pin.ignore_net_equivalency = True

            if (
                not temp_matches
                and instance.cell_type == "DSP48E1"
                and name
                in {
                    "ALUMODE",
                    "OPMODE",
                    "INMODE",
                    "CLK",
                    "CARRYIN",
                }
            ):
                for inst in instances_matching_connections:
                    instance = self.reversed_netlist.instances[inst]
                    # [3:]   : gets rid of the "{# of bits}'b" at the beginning of the prop
                    # [::-1] : reverses the string since the pins index the opposite as strings
                    reversed_prop = instance.properties[f"IS_{name}_INVERTED"][3:][::-1]
                    if int(reversed_prop[idx]) == 1 and (
                        (other_net.is_gnd and instance.get_pin(name, idx).net.is_vdd)
                        or (other_net.is_vdd and instance.get_pin(name, idx).net.is_gnd)
                    ):
                        pin.ignore_net_equivalency = True
                        break

                if pin.ignore_net_equivalency:
                    continue

            instances_matching_connections = temp_matches
            num_instances = len(instances_matching_connections)
            info = (
                ": "
                + ",".join(
                    self.reversed_netlist.instances[i].name for i in instances_matching_connections
                )
                if num_instances <= 10
                else ""
            )
            logging.info("    %s remaining%s", num_instances, info)

        logging.info(
            "  %s instance(s) after filtering on connections", len(instances_matching_connections)
        )
        return instances_matching_connections

    def get_properties_for_type(self, cell_type) -> tuple[str]:
        """Return the list of properties that must match for a given cell type
        for the cell to be considered equivalent."""
        try:
            return self._cell_props[cell_type]
        except KeyError as err:
            raise StructuralCompareError(f"Unhandled properties for type {cell_type}") from err

    def get_netlist(self, library) -> SdnNetlistWrapper:
        return SdnNetlistWrapper(library)


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument(
        "--netlists",
        type=str,
        nargs=2,
        help="The full path for the first netlist for comparison",
    )
    parser.add_argument("--log_path", type=str, help="The log file path to use as output")
    parser.add_argument("--expect_fail", action="store_true", help="Expect the comparison to fail")
    parser.add_argument("--debug", action="store_true", help="Utilize debugging functionality")
    parser.add_argument("--logging_level", help="Decides what levels of logs to display")
    args = parser.parse_args()
    struct_cmp = StructuralCompare(
        named_netlist_path=args.netlists[0],
        reversed_netlist_path=args.netlists[1],
        log_path=args.log_path,
        debug=args.debug,
        logging_level=args.logging_level,
    )
    try:
        struct_cmp.compare_netlists()
        if args.expect_fail:
            logging.error("FAIL: Expected mismatch, but comparison succeeded")
            sys.exit(1)
        logging.info("SUCCESS: Structural comparison found equivalence")

    except StructuralCompareError as e:
        if not args.expect_fail:
            logging.error("FAIL: %s", e)
            sys.exit(1)
        else:
            logging.info("SUCCESS: Structural comparison found mismatch as expected")
