""" Structural Comparison and Mapping tool """

from collections import defaultdict
import pickle
import time
from bidict import bidict
import spydrnet as sdn
from bfasst import jpype_jvm
from bfasst.compare.base import CompareTool, CompareException
from bfasst.utils import convert_verilog_literal_to_int
from bfasst.utils.sdn_helpers import Netlist, Instance, Net, Pin


class StructuralCompareTool(CompareTool):
    """Structural compare and map"""

    TOOL_WORK_DIR = "struct_cmp"

    def __init__(
        self, cwd, design, gold_netlist, rev_netlist, log_prefix="", flow_args="", rm_net=False
    ) -> None:
        super().__init__(cwd, design, gold_netlist, rev_netlist, flow_args)
        self.log_path = self.work_dir / f"{log_prefix}log.txt"
        self.remove_logs()
        self.rm_net = rm_net

        self.named_netlist = None
        self.reversed_netlist = None

        self.block_mapping = bidict()
        self.net_mapping = bidict()

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
        no_props = ("IBUF", "OBUF", "OBUFT", "MUXF7", "MUXF8", "CARRY4", "IOBUF")

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

        self.run_num = None
        self.possible_matches = {}
        self.gnd_mappings = set()
        self.vcc_mappings = set()

        self.start_time = 0
        self.end_time = 0

        jpype_jvm.start()

    def reset_mappings(self):
        self.block_mapping = bidict()
        self.net_mapping = bidict()

    def load_mappings(self):
        """Init mapping data structures from pkl files"""
        with open(self.work_dir / "block_mapping.pkl", "rb") as f:
            block_map = pickle.load(f)
        with open(self.work_dir / "net_mapping.pkl", "rb") as f:
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
        self.launch()
        impl_netlist = self.gold_netlist
        netlist_b = self.rev_netlist

        self.check_log_path()

        self.log_title("Building netlist A", impl_netlist)

        # Loads the first netlist as intermediate representation (ir1)
        ir_a = sdn.parse(str(impl_netlist))
        library_a = ir_a.libraries[0]
        netlist_a = self.get_netlist(library_a)
        self.log(f"Golden netlist size: {len(netlist_a.instances)}")

        self.log_title("Building netlist B", netlist_b)

        # Loads the second netlist as intermediate representation (ir2)
        ir_b = sdn.parse(str(netlist_b))
        library_b = ir_b.libraries[0]
        netlist_b = self.get_netlist(library_b)
        self.log(f"Reversed netlist size: {len(netlist_b.instances)}")

        # golden_netlist = [i for i in golden_netlist if i.name not in ("GND")]

        self.named_netlist = netlist_a
        self.reversed_netlist = netlist_b

    def check_log_path(self):
        if self.run_num is not None:
            self.log_path = self.work_dir / f"compare_log_{self.run_num}.txt"

    def compare_netlists(self):
        """Map the golden and reversed netlists through automated block mapping"""
        self.start_time = time.time()

        t_begin = time.perf_counter()
        self.init_netlists()

        self.log("Time after init_netlists:".ljust(35), time.perf_counter() - t_begin)

        # self.load_mappings()
        # Structurally map the rest of the netlists
        self.perform_mapping()
        t_end = time.perf_counter()

        self.log_title("Mapping (Instances)")
        block_map = {k.name: v.name for k, v in self.block_mapping.items()}
        for key, val in self.block_mapping.items():
            self.log(f"{key.name} -> {val.name}")
        self.log()
        # self.log_title("Mapping (Nets)")
        net_map = {k.name: v.name for k, v in self.net_mapping.items()}
        for key, val in self.net_mapping.items():
            self.log(f"{key.name} -> {val.name}")

        self.log_title("Finalizing")
        self.named_netlist.instances_to_map = {
            i for i in self.named_netlist.instances if i.cell_type not in ("GND", "VCC")
        }
        self.log(
            "Number of mapped blocks: ",
            f"{len(self.block_mapping)} of {len(self.named_netlist.instances_to_map)}",
        )
        self.log("  Unmapped blocks:")
        for block in [
            block
            for block in self.named_netlist.instances_to_map
            if block not in self.block_mapping
        ]:
            self.log(f"    {block.name}")

        num_mapped_nets = (
            len([net for net in self.net_mapping if net.is_connected])
            + len(self.vcc_mappings)
            + len(self.gnd_mappings)
        )
        num_total_nets = len(self.named_netlist.get_connected_nets())
        self.log("Number of mapped nets:", num_mapped_nets, "of", num_total_nets)

        self.log("  Unmapped nets:")
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
            self.log(f"    {net.name}")

        if len(self.block_mapping) != len(self.named_netlist.instances_to_map):
            raise CompareException("Could not map all blocks")
        if num_mapped_nets != num_total_nets:
            raise CompareException("Could not map all nets")

        with open(self.work_dir / "block_mapping.pkl", "wb") as f:
            self.log(f"Dumping pkl to {self.work_dir / 'block_mapping.pkl'}")
            pickle.dump(block_map, f)

        with open(self.work_dir / "net_mapping.pkl", "wb") as f:
            pickle.dump(net_map, f)

        mtime = round(t_end - t_begin, 1)
        self.log(f"Mapping time: {mtime} seconds")

        # After establishing mapping, verify equivalence
        t_begin = time.perf_counter()
        self.verify_equivalence()
        t_end = time.perf_counter()
        vtime = round(t_end - t_begin, 1)
        self.log(f"Equivalence verification time: {vtime} seconds")
        self.log(f"Total time: {mtime + vtime} seconds")
        if self.rm_net:
            self.rev_netlist.unlink()
        self.cleanup()

        self.end_time = time.time()
        self.log("Total time:".ljust(35), self.end_time - self.start_time)
        with open(self.work_dir / "comparison_time.txt", "w") as f:
            f.write(f"{self.end_time - self.start_time}\n")

    def map_ports(self):
        """Map top-level ports"""
        self.log_title("Mapping top-level ports")
        for pin in self.named_netlist.pins:
            assert isinstance(pin, Pin)
            self.log(
                "Mapping port",
                f"{pin.name}[{pin.index}] to",
                f"{pin.name}[{pin.index}]",
            )
            try:
                self.add_net_mapping(
                    pin.net,
                    self.reversed_netlist.get_pin(pin.name, pin.index).net,
                )
            except KeyError as e:
                raise CompareException(
                    f"KeyError during port mapping, is the I/O {pin.name} "
                    + "signal a reserved HDL keyword?"
                ) from e

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
                self.log(
                    f"No property matches for cell {named_instance.name} of type "
                    + f"{named_instance.cell_type}. Properties:"
                )
                for prop in self.get_properties_for_type(named_instance.cell_type):
                    self.log(f"  {prop}: {named_instance.properties[prop]}")
                raise CompareException(
                    f"Not equivalent. {named_instance.name} has no possible match in the netlist."
                )

            self.possible_matches[named_instance] = instances_matching.copy()

    def potential_mapping_wrapper(self, instance):
        """Wrap check_for_potential_mapping some inital checks/postprocessing"""

        # Skip assign statements (named netlist shouldn't have them)
        # Update: just let the code break if this happens
        # assert not instance.cell_type.startswith("SDN_VERILOG_ASSIGNMENT")

        self.log(f"Considering {instance.name} ({instance.cell_type})")

        # Get the implemented potential instance to map
        if not instance.cell_type.startswith("RAMB"):
            instances_matching = self.check_for_potential_mapping(instance)
        else:
            instances_matching = self.check_for_potential_bram_mapping(instance)

        # self.log(f"  {instances_matching} matches")

        if not instances_matching:
            raise CompareException(
                f"Not equivalent. {instance.name} has no possible match in the netlist."
            )

        if len(instances_matching) > 1:
            self.log(f"  {len(instances_matching)} matches, skipping for now:")
            if len(instances_matching) < 10:
                for matched_instance in instances_matching:
                    self.log(f"    {matched_instance.name}")
            return False

        assert len(instances_matching) == 1
        matched_instance = instances_matching[0]

        self.log(f"  Mapped to {matched_instance.name}")

        self.add_block_mapping(instance, matched_instance)
        return True

    def perform_mapping(self):
        """Maps netlists based on their cells and nets"""

        # First map top-level nets
        self.map_ports()

        # Init possible_matches dict with all instances that match by cell type and properties
        self.init_matching_instances()
        self.log("Time after initial cache:".ljust(35), time.time() - self.start_time)

        self.log_title("Starting mapping iterations")

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

                self.log(f"No more progress can be made. Failed at iteration {iteration}.")
                break
            overall_progress = False

            self.log(f"===== Mapping Iteration {iteration} =====")

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
        self.log_title("Verifying equivalence")
        warnings = []
        for instance in self.named_netlist.instances_to_map:
            mapped_instance = self.block_mapping.get(instance)
            if mapped_instance is None:
                raise CompareException(
                    f"Not equivalent. Instance {instance.name} is not mapped to anything."
                )

            # Loop through all pins on instance and compare nets
            for pin_a in instance.pins:
                if pin_a.ignore_net_equivalency:
                    continue
                pin_b = mapped_instance.get_pin(pin_a.name, pin_a.index)

                net_a = pin_a.net
                net_b = pin_b.net
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
            self.log("Equivalence verified")
        else:
            self.log("Equivalence questionable")
            raise CompareException("Warnings during equivalence verification")

    def add_block_mapping(self, instance, matched_instance):
        """Add mapping point between two Instances"""

        self.block_mapping[instance] = matched_instance
        self.named_netlist.instances_to_map.remove(instance)

        for pin in instance.pins:
            # Some pins should not be used to establish net mapping
            if pin.ignore_net_equivalency:
                continue

            net_a = pin.net

            if net_a is None:
                # Disconnected pin
                continue

            assert isinstance(net_a, Net)
            if net_a in self.net_mapping:
                continue

            if instance.cell_type != "RAM32M" or not pin.name.startswith("D"):
                # for some reason RW sets DI* to the wrong bit, and SDN reads
                # DO* from the wrong bit for f2b netlist
                idx = pin.index
            else:
                idx = 0 if pin.index == 1 else 1

            net_b = matched_instance.get_pin(pin.name, idx).net
            if net_b is None and net_a.is_gnd:
                continue
            assert isinstance(net_b, Net)

            if net_a in self.net_mapping:
                assert net_b == self.net_mapping[net_a]
                continue

            if instance.cell_type == "RAM32M" and pin.name.startswith("DI"):
                # DI* doesn't matter if the corresponding output bit is not used
                out_net = matched_instance.get_pin(f"DO{pin.name[2]}", idx).net
                if out_net is None or out_net.is_gnd or len(out_net.wire.pins) <= 1:
                    continue

            self.log(
                "    Net",
                net_a.name.strip(),
                "mapped to",
                net_b.name,
                f"(from {pin.name})",
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
            Instance.GND_PIN.net,
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
                raise CompareException("Unexpected BRAM CASCADE Configuration")

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

            self.log(f"  Filtering on pin {pin.name_with_index}, {other_net.name}")

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
            self.log(f"    {num_instances} remaining{info}")

        self.log(
            f"  {len(instances_matching_connections)} instance(s) after filtering on connections"
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

            self.log(f"  Filtering on pin {pin.name_with_index}, {other_net.name}")

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
            self.log(f"    {num_instances} remaining{info}")

        self.log(
            f"  {len(instances_matching_connections)} instance(s) after filtering on connections"
        )
        self.possible_matches[named_instance] = instances_matching_connections
        return instances_matching_connections

    def get_properties_for_type(self, cell_type):
        """Return the list of properties that must match for a given cell type
        for the cell to be considered equivalent."""
        try:
            return self._cell_props[cell_type]
        except KeyError as e:
            raise CompareException(f"Unhandled properties for type {cell_type}") from e

    def get_netlist(self, library):
        return Netlist(library, self)
