""" Structural Comparison and Mapping tool """

from bidict import bidict
import spydrnet as sdn
from bfasst import jpype_jvm
from bfasst.compare.base import CompareTool
import bfasst.rw_helpers as rw
from bfasst.status import CompareStatus, Status
from bfasst.utils import TermColor, error, properties_are_equal


class StructuralCompareTool(CompareTool):
    """Structural compare and map"""

    TOOL_WORK_DIR = "struct_cmp"

    def __init__(self, cwd, design, gold_netlist, rev_netlist, flow_args="") -> None:
        super().__init__(cwd, design, gold_netlist, rev_netlist, flow_args)
        self.remove_logs()

        self.named_netlist = None
        self.reversed_netlist = None

        self.block_mapping = bidict()
        self.net_mapping = bidict()

        self.run_num = None

        jpype_jvm.start()

    def reset_mappings(self):
        self.block_mapping = bidict()
        self.net_mapping = bidict()

    def check_log_path(self):
        if self.run_num is not None:
            self.log_path = self.work_dir / f"compare_log_{self.run_num}.txt"

    def compare_netlists(self):
        """Map the golden and reversed netlists through automated block mapping"""

        impl_netlist = self.gold_netlist
        netlist_b = self.rev_netlist

        self.check_log_path()
        self.open_new_log()

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

        # for instance in self.named_netlist.instances:
        #     print(instance.instance.name)
        #     if instance.instance.name.strip() == r"\count_i_reg[12]_i_6":
        #         for pin in instance.pins:
        #             print(
        #                 pin.pin.inner_pin.port.name,
        #                 pin.index,
        #                 pin.pin.wire,
        #                 pin.pin.wire.index() if pin.pin.wire else "",
        #             )
        #         raise NotImplementedError

        # raise NotImplementedError

        # Structurally map the rest of the netlists
        self.perform_mapping()

        self.log_title("Mapping (Instances)")
        for key, val in self.block_mapping.items():
            self.log(f"{key.name} -> {val.name}")
        self.log()
        self.log_title("Mapping (Nets)")
        for key, val in self.net_mapping.items():
            self.log(f"{key.name} -> {val.name}")

        self.log_title("Finalizing")
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

        num_mapped_nets = len([net for net in self.net_mapping if net.is_connected()])
        num_total_nets = len(self.named_netlist.get_connected_nets())
        self.log("Number of mapped nets:", num_mapped_nets, "of", num_total_nets)

        self.log("  Unmapped nets:")
        for net in [
            net for net in self.named_netlist.get_connected_nets() if net not in self.net_mapping
        ]:
            self.log(f"    {net.name}")

        if len(self.block_mapping) != len(self.named_netlist.instances_to_map):
            return Status(CompareStatus.COULD_NOT_MAP)
        if num_mapped_nets != num_total_nets:
            return Status(CompareStatus.COULD_NOT_MAP)

        # TODO: After establishing mapping, verify equivalence
        # Basically make sure all outputs are mapped, and then everything is identical
        # Maybe this will already be guaranteed by the mapping algorithm? ...good to
        # double check.

        return self.success_status

    def perform_mapping(self):
        """Maps netlists based on their cells and nets"""

        # First map top-level nets
        self.log_title("Mapping top-level ports")
        for pin in self.named_netlist.pins:
            assert isinstance(pin, Pin)
            self.log(
                "Mapping port",
                f"{pin.name}[{pin.index}] to",
                f"{pin.name}[{pin.index}]",
            )
            self.add_net_mapping(
                pin.net,
                self.reversed_netlist.get_pin(pin.name, pin.index).net,
            )

        self.log_title("Starting mapping iterations")
        progress = True

        # Loop until all blocks have been mapped or there is no more progress

        iteration = 0
        while len(self.block_mapping) < len(self.named_netlist.instances_to_map):
            if not progress:
                self.log_color(
                    TermColor.RED, f"No more progress can be made. Failed at iteration {iteration}."
                )
                break
            progress = False

            self.log_color(TermColor.BLUE, f"===== Mapping Iteration {iteration} =====")

            # Loop through reversed netlist blocks
            for instance in self.named_netlist.instances_to_map:
                if instance not in self.block_mapping:
                    # Skip assign statements (named netlist shouldn't have them)
                    assert not instance.cell_type.startswith("SDN_VERILOG_ASSIGNMENT")

                    self.log(f"Considering {instance.name} ({instance.cell_type})")

                    # Get the implemented potential instance to map
                    instances_matching = self.check_for_potential_mapping(instance)

                    # self.log(f"  {instances_matching} matches")

                    if not instances_matching:
                        return Status(
                            CompareStatus.NOT_EQUIVALENT,
                            f"{instance.name} has no possible match in netlist",
                        )

                    if len(instances_matching) > 1:
                        self.log(f"  {len(instances_matching)} matches, skipping for now:")
                        for matched_instance in instances_matching:
                            self.log(f"    {matched_instance.name}")
                        continue

                    assert len(instances_matching) == 1
                    matched_instance = instances_matching[0]

                    self.log(f"  Mapped to {matched_instance.name}")

                    self.add_block_mapping(instance, matched_instance)

                    progress = True
                    continue

            iteration += 1
        return self.success_status

    def add_block_mapping(self, instance, matched_instance):
        """Add mapping point between two Instances"""
        assert isinstance(instance, Instance)
        assert isinstance(matched_instance, Instance)

        self.block_mapping[instance] = matched_instance

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

            net_b = matched_instance.get_pin(pin.name, pin.index).net
            assert isinstance(net_b, Net)

            if net_a in self.net_mapping:
                assert net_b == self.net_mapping[net_a]
                continue

            self.log(
                "    Net",
                net_a.name.strip(),
                "mapped to",
                net_b.name,
                f"(from {pin.name})",
            )
            # self.log(pin.ignore_net_equivalency)
            # self.log(pin.net.is_gnd)
            # self.log(pin.net.driver_pin)
            self.add_net_mapping(net_a, net_b)

        # TODO: Update net mappings

    def add_net_mapping(self, net1, net2):
        assert isinstance(net1, Net)
        assert isinstance(net2, Net)

        assert net1 not in self.net_mapping
        assert net2 not in self.net_mapping.inverse
        self.net_mapping[net1] = net2

    def check_for_potential_mapping(self, named_instance):
        """Returns cells that could map to the named_instance"""
        all_instances = self.reversed_netlist.instances

        ###############################################################
        # First find all instances of the same type that are unmapped
        ###############################################################
        instances_matching_cell_type = [
            i
            for i in all_instances
            if i.cell_type == named_instance.cell_type and i not in self.block_mapping.inverse
        ]

        if not instances_matching_cell_type:
            self.log_color(TermColor.RED, "No unmapped instances of type", named_instance.cell_type)
            return instances_matching_cell_type
        self.log(
            f"  {len(instances_matching_cell_type)} unmapped {named_instance.cell_type} instance(s)"
        )

        ###############################################################
        # Now look at properties
        ###############################################################
        properties_to_match = self.get_properties_for_type(named_instance.cell_type)

        properties = named_instance.properties

        instances_matching_props = instances_matching_cell_type[:]
        for prop in properties_to_match:
            if properties is None or prop not in properties:
                error(prop, "not in properties:", properties)
            assert prop in properties

            # Filter by properties match (case insensitive)
            instances_matching_props = [
                i
                for i in instances_matching_cell_type
                if i not in self.block_mapping.inverse
                and prop in i.properties
                and properties_are_equal(properties[prop], i.properties[prop])
            ]
        if not instances_matching_props:
            self.log_color(
                TermColor.RED,
                f"No unmapped instances of {named_instance.cell_type} with matching properties",
                ",".join(p + "=" + properties[p] for p in properties_to_match),
                "\n  "
                + "\n  ".join(
                    str(i.name) + " " + str(i.properties) for i in instances_matching_cell_type
                ),
            )
            return instances_matching_props
        self.log(f"  {len(instances_matching_props)} instance(s) after filtering on properties")

        ###############################################################
        # Now look at connections
        ###############################################################

        instances_matching_connections = instances_matching_props[:]

        for pin in named_instance.pins:
            assert isinstance(pin, Pin)

            # Skip pin that is not yet mapped
            if pin.net not in self.net_mapping:
                continue

            # Otherwise pin connected to a mapped net, and filter based on instances that are
            # connected to the corresponding mapped net.
            other_net = self.net_mapping[pin.net]

            self.log(f"  Filtering on pin {pin.name_with_index}, {other_net.name}")

            # for instance in instances_matching_connections:
            #     self.log(
            #         instance.get_pin(pin.name, pin.index).name_with_index,
            #         instance.get_pin(pin.name, pin.index).net.name,
            #     )
            instances_matching_connections = [
                instance
                for instance in instances_matching_connections
                if instance.get_pin(pin.name, pin.index).net == other_net
            ]
            self.log(
                f"    {len(instances_matching_connections)} remaining:",
                ",".join(i.name for i in instances_matching_connections),
            )

        self.log(
            f"  {len(instances_matching_connections)} instance(s) after filtering on connections"
        )

        return instances_matching_connections

    def get_properties_for_type(self, cell_type):
        """Return the list of properties that must match for a given cell type
        for the cell to be considered equivalent."""

        prims = [
            "LUT6_2",
            "FDSE",
            "FDRE",
            "FDCE",
            "FDPE",
            "RAM32X1S",
            "RAM32X1D",
            "RAM32X1S_1",
            "RAM32X1D_1",
            "RAM32M",
            "RAMB36E1",
            "BUFGCTRL",
            "IBUF",
            "OBUF",
            "OBUFT",
            "MUXF7",
            "MUXF8",
            "CARRY4",
        ]

        if cell_type == "LUT6_2":
            return ("INIT",)
        if cell_type in ("FDSE", "FDRE", "FDCE", "FDPE"):
            return ("INIT",)
        if cell_type in ("RAM32X1S", "RAM32X1D", "RAM32X1S_1", "RAM32X1D_1"):
            return ("INIT",)
        if cell_type in ("RAM32M",):
            return ("INIT_A", "INIT_B", "INIT_C", "INIT_D")
        if cell_type == "RAMB36E1":
            props = [f"INIT_{i:02X}" for i in range(int("0x80", base=16))]
            return tuple(props)
        if cell_type == "BUFGCTRL":
            return (
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
        if cell_type in ("IBUF", "OBUF", "OBUFT", "MUXF7", "MUXF8", "CARRY4"):
            return ()

        raise KeyError(f"Unhandled properties for type {cell_type}")

    def get_netlist(self, library):
        return Netlist(library, self)


class Netlist:
    """Wrapper class around spydernet top level library"""

    def __init__(self, library, tool) -> None:
        self.library = library
        self.tool = tool

        # Nets
        self.wire_to_net = {}
        self.build_nets()

        # Instances
        instances = [Instance(i, self) for i in library.get_instances()]
        # instances = [i for i in instances if i.cell_type not in ("VCC", "GND")]
        self.instances = instances

        self.instances_to_map = [i for i in self.instances if i.cell_type not in ("GND", "VCC")]

        # Top-level IO pins
        self.pins = [Pin(pin, None, self) for pin in library.get_pins()]

        self.pins_by_name_and_idx = {}
        for pin in self.pins:
            assert isinstance(pin, Pin)
            key = (pin.name, pin.index)
            assert key not in self.pins_by_name_and_idx
            self.pins_by_name_and_idx[key] = pin

    def get_pin(self, name, index):
        return self.pins_by_name_and_idx[(name, index)]

    def num_wires(self):
        return len(list(self.library.get_wires()))

    def build_nets(self):
        """Setup Net objects"""
        # First construct net objects for each wire, skipping alias wires
        non_alias_wires = [wire for wire in self.library.get_wires() if not Net.wire_is_alias(wire)]
        for wire in non_alias_wires:
            net = Net(wire, self.tool)
            self.tool.log(f"New Net for wire {wire.cable.name}[{wire.index()}]")
            self.wire_to_net[wire] = net

        # Now add alias wires iteratively until they are all added
        alias_wires = [wire for wire in self.library.get_wires() if Net.wire_is_alias(wire)]

        self.tool.log("Processing alias wires (derived from assign statements)")

        progress = True
        while alias_wires and progress:
            progress = False
            processed_alias_wires = []
            for wire in alias_wires:
                driver_wire = Net.wire_derived_from(wire)
                if driver_wire not in self.wire_to_net:
                    continue

                net = self.wire_to_net[driver_wire]
                self.tool.log(
                    f"Adding alias wire {wire.cable.name}[{wire.index()}]",
                    f"to net {net.name}[{net.wire.index()}]",
                )
                net.add_alias_wire(wire)
                self.wire_to_net[wire] = net
                processed_alias_wires.append(wire)

            # Remove wires we processed
            old_len = len(alias_wires)
            alias_wires = [wire for wire in alias_wires if wire not in processed_alias_wires]
            if len(alias_wires) != old_len:
                progress = True

        if alias_wires and not progress:
            self.tool.log("Failed to process all alias wires:", [w.cable.name for w in alias_wires])
            raise RuntimeError("Failed to process all alias wires")

        # Now determine the driver for each net
        for net in self.nets:
            net.find_driver()

    @property
    def nets(self):
        return set(self.wire_to_net.values())

    def get_connected_nets(self):
        """Return a list of nets that are connected to something"""
        return [net for net in self.nets if net.is_connected()]


class Pin:
    """Wrapper class around spydernet InnerPin/OuterPin to add some helper properties"""

    def __init__(self, pin, instance, netlist):
        self.pin = pin
        self.instance = instance
        self.netlist = netlist
        if isinstance(pin, sdn.OuterPin):
            self.name = self.pin.inner_pin.port.name
            self.index = self.pin.inner_pin.port.pins.index(self.pin.inner_pin)
            self.ignore_net_equivalency = self._ignore_net_equivalency(instance)
        else:
            self.name = self.pin.port.name
            self.index = self.pin.port.pins.index(self.pin)
            self.ignore_net_equivalency = False

    def _ignore_net_equivalency(self, instance):
        """Determines whether the net equivalency should be ignored on this pin."""
        # Ignore net equivalency on constant LUT inputs
        # The logic function PROBABLY doesn't depend on this LUT input
        # TODO: Verify this by looking at the LUT INIT
        if instance.cell_type == "LUT6_2" and self.net and (self.net.is_vdd or self.net.is_gnd):
            return True
        return False

        # This didn't work unfortunately
        # if instance.cell_type == "LUT6_2":
        #     eqn = LUTTools.getLUTEquation(instance.properties["INIT"])
        #     print(instance.properties["INIT"])
        #     # print(eqn)
        #     return self.name not in eqn
        # return False

    @property
    def net(self):
        # print(self.instance.name, self.name, self.pin.wire)
        return self.netlist.wire_to_net.get(self.pin.wire)

    @property
    def name_with_index(self):
        return f"{self.name}[{self.index}]"


class Net:
    """Wrapper class around spydernet Wire to add some helper properties"""

    def __init__(self, wire, tool):
        self.wire = wire
        self.tool = tool
        self.alias_wires = []
        self.driver_pin = None
        self.is_vdd = None
        self.is_gnd = None

    def add_alias_wire(self, wire):
        assert wire not in self.alias_wires
        self.alias_wires.append(wire)

    def is_connected(self):
        """Determine if this net drives anything"""
        if len(self.wire.pins) == 1:
            assert self.wire.pins[0] == self.driver_pin
            return False
        if not self.wire.pins:
            return False
        return True

    def find_driver(self):
        """Determine the pin that drives this wire"""

        # If wire is not connected to any pins, just return
        if not self.wire.pins:
            return

        # Find the pin that drives this wire
        for pin in self.wire.pins:
            # If connected to top-level input
            if isinstance(pin, sdn.ir.InnerPin):
                if pin.port.direction == sdn.ir.Port.Direction.IN:
                    self.set_driver_pin(pin)
            else:
                pin_direction = self.get_direction_for_unisim(
                    pin.instance.reference.name, pin.inner_pin.port.name
                )
                if pin_direction == sdn.ir.Port.Direction.OUT:
                    self.set_driver_pin(pin)

        # if self.driver_pin is None:
        #     print(self.name)
        # assert self.driver_pin is not None

    def set_driver_pin(self, pin):
        """Set the driver pin"""
        assert self.driver_pin is None
        self.driver_pin = pin

        # Check for constant GND/VDD.  Top-level I/O will not be GND/VDD
        if isinstance(pin, sdn.OuterPin) and self.driver_pin.instance.reference.name == "GND":
            self.is_gnd = True
        else:
            self.is_gnd = False
        if isinstance(pin, sdn.OuterPin) and self.driver_pin.instance.reference.name == "VDD":
            self.is_vdd = True
        else:
            self.is_vdd = False

    @property
    def name(self):
        if len(self.wire.cable.wires) > 1:
            return f"{self.wire.cable.name}[{self.wire.index()}]"
        return self.wire.cable.name

    @staticmethod
    def get_direction_for_unisim(cell_type_name, port_name):
        """Get a pin direction for a UNISIM cell"""

        if cell_type_name.startswith("SDN_VERILOG_ASSIGNMENT"):
            if port_name == "i":
                return sdn.ir.Port.Direction.IN
            # Shouldn't be possible to get here.  The way the code is set up, this function
            # is never called on alias wires (wires driven by assign statement)
            assert False

        return rw.get_sdn_direction_for_unisim(cell_type_name, port_name)

    # @staticmethod
    # def get_assign_statement(wire):
    #     """Check if a wire is connected to an assign statement and return the pin"""

    #     return None

    @staticmethod
    def wire_is_alias(wire):
        """Return whether wire is an alias of another wire (ie derived from assign statement)"""
        for pin in wire.pins:
            # assign statements don't have InnerPins
            if isinstance(pin, sdn.InnerPin):
                continue

            if (
                pin.instance.reference.name.startswith("SDN_VERILOG_ASSIGNMENT")
                and pin.inner_pin.port.name == "o"
            ):
                return True
        return False

    @staticmethod
    def wire_derived_from(wire):
        """If a wire is derived from another wire via assign statement, return the driver wire"""
        for pin in wire.pins:
            # assign statements don't have InnerPins
            if isinstance(pin, sdn.InnerPin):
                continue

            if (
                pin.instance.reference.name.startswith("SDN_VERILOG_ASSIGNMENT")
                and pin.inner_pin.port.name == "o"
            ):
                # Get the wire driving the assign statement
                if pin.inner_pin.port.name == list(pin.instance.pins)[0].inner_pin.port.name:
                    return list(pin.instance.pins)[1].wire
                return list(pin.instance.pins)[0].wire

        return None


class Instance:
    """Wrapper class around spydernet Instance to add some helper properties"""

    def __init__(self, instance, netlist):
        self.instance = instance
        self.netlist = netlist

        self.pins = []
        self.pins_by_name_and_index = {}

        for pin_spydernet in self.instance.pins:
            pin = Pin(pin_spydernet, self, self.netlist)
            self.pins.append(pin)
            self.pins_by_name_and_index[
                (
                    pin_spydernet.inner_pin.port.name,
                    pin_spydernet.inner_pin.port.pins.index(pin_spydernet.inner_pin),
                )
            ] = pin
            # print(pin.name, pin.ignore_net_equivalency)

        # if self.name == "Sout_i_3_phys":
        #     raise NotImplementedError

    @property
    def name(self):
        return self.instance.name

    @property
    def cell_type(self):
        return self.instance.reference.name

    @property
    def properties(self):
        return self.instance.data.get("VERILOG.Parameters")

    def get_pin(self, name, index):
        return self.pins_by_name_and_index[(name, index)]
