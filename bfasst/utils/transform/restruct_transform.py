"""
RESTRUCT_OPT Transformation Tracking and INIT Restoration

This module handles the complex case where Vivado's phys_opt_design RESTRUCT_OPT
optimization transforms the circuit topology, creating new _comp cells with
sentinel-derived INITs that need to be recomputed from original cell functions.

Key concepts:
- Parse incremental phys_opt checkpoints to track transformations
- Build dependency graph: new _comp cells -> original cells they derive from
- Use Ashenhurst-Curtis Decomposition (ACD) to compute correct INITs

Algorithm:
1. Parse pre-phys_opt and all post-phys_opt EDIFs using RapidWright
2. Diff consecutive netlists to find RESTRUCT_OPT changes
3. Build transitive dependency graph to original cells
4. For each _comp cell group, compute correct INITs from original functions
"""
# pylint: disable=too-many-lines

import json
import re
import logging
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, List, Set, Optional, Tuple

logger = logging.getLogger(__name__)


# =============================================================================
# Data Structures
# =============================================================================


@dataclass
class CellInfo:
    """Information about a single cell in the netlist."""

    name: str
    cell_type: str  # LUT2, LUT3, LUT4, LUT5, LUT6, FDRE, etc.
    init: Optional[int]  # INIT value as integer, None if not a LUT
    init_width: int  # Number of bits in INIT (4, 8, 16, 32, 64)
    inputs: Dict[str, str] = field(default_factory=dict)  # pin -> net_name
    output_net: Optional[str] = None  # Output net name
    redact_tag: Optional[str] = None
    phys_opt_modified: Optional[str] = None
    orig_cell_name: Optional[str] = None


@dataclass
class RestructTransform:
    """A single RESTRUCT_OPT transformation between two netlists."""

    pass_number: int
    deleted_cells: List[str]  # Cells that existed before, gone after (had REDACT_TAG)
    created_cells: List[str]  # Cells created with RESTRUCT_OPT (no REDACT_TAG)


@dataclass
class DependencyNode:
    """Tracks what original cells a _comp cell depends on."""

    cell_name: str
    original_cells: Set[str] = field(default_factory=set)  # Transitive closure
    direct_parents: Set[str] = field(default_factory=set)  # Immediate predecessors


@dataclass
class RestructureGroup:
    """A group of _comp cells that form a single restructured unit."""

    output_cell: str  # The final output cell (e.g., h)
    intermediate_cells: List[str]  # Helper cells (e.g., comp, comp_1)
    original_cells: Set[str]  # All original cells this group derives from
    primary_inputs: Set[str]  # Signal names that are inputs to this group


@dataclass
class ACDContext:
    """Context for Ashenhurst-Curtis Decomposition INIT computation."""

    cells_info: Dict[str, "CellInfo"]
    primary_inputs: List[str]
    truth_table: Dict[tuple, int]
    output_to_cell: Dict[str, str]
    cell_free_vars: Dict[str, List[str]]
    h_sees: Set[str]  # Primary inputs seen by output cell


# =============================================================================
# EDIF Parsing using RapidWright
# =============================================================================


def parse_init_string(init_str: str) -> Tuple[int, int]:
    """
    Parse INIT string like "64'hD7314A6E96B3C58A" or "4'hD" into (value, width).
    Returns (init_value, bit_width).
    """
    if not init_str:
        return 0, 0

    # Match patterns like 64'hXXX, 32'hXXX, 4'hX, 1'b0, etc.
    match = re.match(r"(\d+)'([hbHB])([0-9a-fA-F]+)", init_str)
    if match:
        width = int(match.group(1))
        base = match.group(2).lower()
        value_str = match.group(3)

        if base == "h":
            value = int(value_str, 16)
        else:  # binary
            value = int(value_str, 2)

        return value, width

    return 0, 0


def _get_property_value(props_map, key: str) -> Optional[str]:
    """Get a property value from RapidWright property map."""
    try:
        prop = props_map.get(key)
        if prop is None:
            return None
        try:
            return str(prop.getValue())
        except AttributeError:
            return str(prop)
    except (AttributeError, TypeError):
        return None


def _build_cell_info_from_inst(cell_inst) -> CellInfo:
    """Build CellInfo from a RapidWright cell instance."""
    name = str(cell_inst.getName())
    props_map = cell_inst.getPropertiesMap()

    init_str = _get_property_value(props_map, "INIT")
    init_val, init_width = parse_init_string(init_str) if init_str else (None, 0)

    cell_info = CellInfo(
        name=name,
        cell_type=str(cell_inst.getCellType().getName()),
        init=init_val,
        init_width=init_width,
        redact_tag=_get_property_value(props_map, "REDACT_TAG"),
        phys_opt_modified=_get_property_value(props_map, "PHYS_OPT_MODIFIED"),
        orig_cell_name=_get_property_value(props_map, "ORIG_CELL_NAME"),
    )

    # Get input/output connectivity
    for port_inst in cell_inst.getPortInsts():
        port_name = str(port_inst.getName())
        net = port_inst.getNet()
        if net:
            net_name = str(net.getName())
            if port_name == "O":
                cell_info.output_net = net_name
            elif port_name.startswith("I"):
                cell_info.inputs[port_name] = net_name

    return cell_info


def parse_edif_cells_rapidwright(dcp_path: Path, edf_path: Path = None) -> Dict[str, CellInfo]:
    """
    Parse a design using RapidWright and extract cell information.

    Args:
        dcp_path: Path to DCP file
        edf_path: Optional path to EDF file (if None, tries to find one)

    Returns dict mapping cell_name -> CellInfo.
    """
    # pylint: disable=import-outside-toplevel
    from com.xilinx.rapidwright.design import Design
    from com.xilinx.rapidwright.edif import EDIFTools

    cells = {}

    # Derive EDF path if not provided
    if edf_path is None:
        edf_path = dcp_path.with_suffix(".edf")

    # Load design using RapidWright
    design = Design.readCheckpoint(str(dcp_path), str(edf_path))
    netlist = design.getNetlist()

    # Use EDIFTools to get hierarchical cell instance map
    hier_map = EDIFTools.createCellInstanceMap(netlist)

    for lib_map in hier_map.values():
        for inst_list in lib_map.values():
            for h_inst in inst_list:
                cell_info = _build_cell_info_from_inst(h_inst.getInst())
                cells[cell_info.name] = cell_info

    return cells


# =============================================================================
# Transformation Detection
# =============================================================================


def diff_netlists(
    before: Dict[str, CellInfo], after: Dict[str, CellInfo], pass_number: int
) -> RestructTransform:
    """
    Find RESTRUCT_OPT changes between consecutive netlists.

    - deleted_cells: Had REDACT_TAG in 'before', missing in 'after'
    - created_cells: Have RESTRUCT_OPT in 'after', didn't exist in 'before'
    """
    deleted = []
    created = []

    # Find deleted cells (had REDACT_TAG, now gone)
    for name, cell in before.items():
        if name not in after:
            if cell.redact_tag:
                deleted.append(name)
                logger.debug("Pass %d: Deleted cell %s (had REDACT_TAG)", pass_number, name)

    # Find created cells (new with RESTRUCT_OPT, no REDACT_TAG)
    for name, cell in after.items():
        if name not in before:
            phys_opt = cell.phys_opt_modified or ""
            if "RESTRUCT_OPT" in phys_opt and not cell.redact_tag:
                created.append(name)
                logger.debug("Pass %d: Created cell %s (RESTRUCT_OPT)", pass_number, name)

    return RestructTransform(pass_number=pass_number, deleted_cells=deleted, created_cells=created)


# =============================================================================
# Dependency Graph Building
# =============================================================================

# Suffix patterns for name matching
# Be careful: _[0-9]+$ can match parts of original names like _i_5
# So we only use specific known suffixes
_SUFFIX_PATTERNS = [
    r"_comp_\d+$",  # _comp_1, _comp_2, etc.
    r"_comp$",  # _comp
    r"_replica_\d+$",  # _replica_1, etc.
    r"_replica$",  # _replica
    r"_repN_\d+$",  # _repN_1, etc.
    r"_repN$",  # _repN
]
_SUFFIX_RE = re.compile("|".join(_SUFFIX_PATTERNS))


def strip_comp_suffix(name: str) -> str:
    """
    Strip _comp, _comp_1, _replica, etc. suffixes to find base name.
    e.g., "INTR_O_i_1_comp" -> "INTR_O_i_1"
    e.g., "cell_comp_1" -> "cell"
    """
    result = name
    for _ in range(10):  # Guard against infinite loops
        new_result = _SUFFIX_RE.sub("", result)
        if new_result == result:
            break
        result = new_result
    return result


def find_parent_cells(
    created_cell: str, deleted_cells: List[str], before_cells: Dict[str, CellInfo]
) -> Set[str]:
    """
    Determine which original cells a created cell derives from.

    Uses name pattern matching as primary method.
    Also looks for "absorbed" cells - cells that still exist but whose
    function was incorporated into the restructuring.
    """
    parents = set()

    # Primary method: name pattern matching
    base_name = strip_comp_suffix(created_cell)

    for deleted in deleted_cells:
        # Direct match
        if deleted == base_name:
            parents.add(deleted)
            continue

        # Check if deleted cell's base name matches
        deleted_base = strip_comp_suffix(deleted)
        if deleted_base == base_name:
            parents.add(deleted)

    # If no match found in deleted cells, check for "absorbed" cells
    # These are cells that still exist but have the same base name
    if not parents:
        # Check if base_name exists in before_cells with REDACT_TAG
        if base_name in before_cells:
            cell = before_cells[base_name]
            if cell.redact_tag:
                parents.add(base_name)

    # Also check for helper cells (_comp_1) pattern
    if not parents:
        # INTR_O_i_1_comp_1 -> INTR_O_i_1
        base_without_number = re.sub(r"_comp_\d+$", "_comp", created_cell)
        base_without_number = strip_comp_suffix(base_without_number)

        for deleted in deleted_cells:
            if strip_comp_suffix(deleted) == base_without_number:
                parents.add(deleted)

        # Also check absorbed cells
        if base_without_number in before_cells:
            cell = before_cells[base_without_number]
            if cell.redact_tag:
                parents.add(base_without_number)

    return parents


def build_dependency_graph(
    transforms: List[RestructTransform], all_netlists: List[Dict[str, CellInfo]]
) -> Dict[str, DependencyNode]:
    """
    Build a dependency graph mapping each _comp cell to its original cells.

    Handles multi-level restructuring by computing transitive closure.
    """
    dependencies: Dict[str, DependencyNode] = {}

    for i, transform in enumerate(transforms):
        if not transform.created_cells:
            continue

        # Get the 'before' netlist for this transform
        before_cells = all_netlists[i] if i < len(all_netlists) else {}

        for created in transform.created_cells:
            parents = find_parent_cells(created, transform.deleted_cells, before_cells)

            # Resolve to original cells (transitive closure)
            original_cells = set()
            for parent in parents:
                if parent in dependencies:
                    # Parent was itself created by restructuring - use its originals
                    original_cells |= dependencies[parent].original_cells
                else:
                    # Parent is an original cell
                    original_cells.add(parent)

            dependencies[created] = DependencyNode(
                cell_name=created, original_cells=original_cells, direct_parents=parents
            )

            logger.debug("Cell %s depends on originals: %s", created, original_cells)

    return dependencies


# =============================================================================
# Restructure Group Identification
# =============================================================================


def identify_restructure_groups(
    final_netlist: Dict[str, CellInfo], dependencies: Dict[str, DependencyNode]
) -> List[RestructureGroup]:
    """
    Group related _comp cells that form a single restructured unit.

    Uses connectivity analysis: cells form a group if one's output feeds another's input.
    """
    # pylint: disable=too-many-locals,too-many-branches
    groups = []
    processed = set()

    # Find all _comp cells (cells in dependencies that exist in final netlist)
    comp_cells = [name for name in dependencies if name in final_netlist]

    # Build connectivity graph among _comp cells
    # Map output_net -> cell_name for _comp cells
    output_to_cell = {}
    for name in comp_cells:
        cell = final_netlist[name]
        if cell.output_net:
            output_to_cell[cell.output_net] = name

    # Find which _comp cells consume outputs of other _comp cells
    # consumers[cell] = set of _comp cells whose outputs this cell consumes
    consumers = {name: set() for name in comp_cells}
    for name in comp_cells:
        cell = final_netlist[name]
        for input_net in cell.inputs.values():
            if input_net in output_to_cell:
                producer = output_to_cell[input_net]
                if producer != name:  # Don't count self
                    consumers[name].add(producer)

    # Group cells by connectivity (transitive closure)
    def find_connected_group(start: str) -> Set[str]:
        """Find all cells connected to start via producer/consumer relationships."""
        group = {start}
        frontier = [start]
        while frontier:
            current = frontier.pop()
            # Add producers (cells whose output this cell consumes)
            for producer in consumers[current]:
                if producer not in group:
                    group.add(producer)
                    frontier.append(producer)
            # Add consumers (cells that consume this cell's output)
            for other, prods in consumers.items():
                if current in prods and other not in group:
                    group.add(other)
                    frontier.append(other)
        return group

    for cell in comp_cells:
        if cell in processed:
            continue

        group_cells = find_connected_group(cell)

        # Determine output cell (the one whose output is NOT consumed by other group cells)
        group_input_nets = set()
        for c in group_cells:
            group_input_nets |= set(final_netlist[c].inputs.values())

        # Output cell's output net is not consumed by any other group cell
        output_cell = None
        for c in group_cells:
            out_net = final_netlist[c].output_net
            if out_net and out_net not in group_input_nets:
                output_cell = c
                break

        # Fallback: smallest LUT or one with plain _comp suffix
        if not output_cell:
            sorted_cells = sorted(
                group_cells, key=lambda c: final_netlist[c].init_width if c in final_netlist else 64
            )
            for c in sorted_cells:
                if re.search(r"_comp$", c) and not re.search(r"_comp_\d+$", c):
                    output_cell = c
                    break
            if not output_cell:
                output_cell = sorted_cells[0]

        intermediates = [c for c in group_cells if c != output_cell]

        # Collect all original cells from the group
        all_originals = set()
        for c in group_cells:
            all_originals |= dependencies[c].original_cells

        group = RestructureGroup(
            output_cell=output_cell,
            intermediate_cells=intermediates,
            original_cells=all_originals,
            primary_inputs=set(),  # Will be computed later
        )
        groups.append(group)
        processed |= group_cells

        logger.info(
            "Restructure group: output=%s, intermediates=%s, originals=%s",
            output_cell,
            intermediates,
            all_originals,
        )

    return groups


# =============================================================================
# Primary Input Identification
# =============================================================================


def identify_primary_inputs(
    group: RestructureGroup, final_netlist: Dict[str, CellInfo]
) -> Set[str]:
    """
    Identify the primary input signals to a restructure group.

    These are signals that feed into the group from outside (not from
    other cells in the group).
    """
    all_group_cells = {group.output_cell} | set(group.intermediate_cells)

    # Get output nets of all cells in the group
    group_output_nets = set()
    for cell_name in all_group_cells:
        if cell_name in final_netlist:
            cell = final_netlist[cell_name]
            if cell.output_net:
                group_output_nets.add(cell.output_net)

    # Get all input nets to cells in the group
    all_input_nets = set()
    for cell_name in all_group_cells:
        if cell_name in final_netlist:
            cell = final_netlist[cell_name]
            all_input_nets |= set(cell.inputs.values())

    # Primary inputs = input nets that aren't outputs of group cells
    primary_inputs = all_input_nets - group_output_nets

    return primary_inputs


# =============================================================================
# INIT Computation for Restructured Cells
# =============================================================================


def load_original_cell_props(json_path: Path) -> Dict[str, dict]:
    """Load original cell properties from JSON file."""
    with open(json_path, encoding="utf-8") as f:
        return json.load(f)


def _extract_init_from_entry(cell_data: dict) -> Optional[Tuple[int, int]]:
    """Extract INIT value from a cell's JSON entry."""
    baseline = cell_data.get("baseline_properties", [])
    for prop in baseline:
        if prop.get("identifier") == "INIT":
            return parse_init_string(prop.get("value", ""))
    return None


def get_original_init(cell_name: str, original_props: Dict[str, dict]) -> Optional[Tuple[int, int]]:
    """
    Get the original INIT value for a cell from original_cell_props.json.
    Returns (init_value, bit_width) or None if not found.

    Uses suffix stripping to handle cells created by other optimizations
    (e.g., REPLICATE_OPT creates _replica cells from original cells).
    """
    # Try exact match first
    if cell_name in original_props:
        return _extract_init_from_entry(original_props[cell_name])

    # Try with suffix stripping (handles _replica, _repN, etc.)
    base_name = strip_comp_suffix(cell_name)
    if base_name != cell_name and base_name in original_props:
        logger.debug("Resolved %s -> %s via suffix stripping", cell_name, base_name)
        return _extract_init_from_entry(original_props[base_name])

    return None


def evaluate_lut(init: int, inputs: List[int], num_inputs: int) -> int:
    """
    Evaluate a LUT given its INIT and input values.

    Args:
        init: The LUT INIT value as integer
        inputs: List of input values [I0, I1, I2, ...] (each 0 or 1)
        num_inputs: Number of inputs to the LUT

    Returns:
        Output value (0 or 1)
    """
    # Build the address from inputs: I0 is LSB, I(n-1) is MSB
    addr = 0
    for i, val in enumerate(inputs[:num_inputs]):
        addr |= val << i
    return (init >> addr) & 1


# =============================================================================
# ACD Helper Functions
# =============================================================================


def _get_cell_input_nets(cell: CellInfo) -> List[str]:
    """Get input nets for a cell in order I0, I1, I2..."""
    return [cell.inputs.get(f"I{i}", "") for i in range(len(cell.inputs))]


def _compute_cell_addr(cell: CellInfo, values: Dict[str, int]) -> int:
    """Compute the LUT address for a cell given signal values."""
    nets = _get_cell_input_nets(cell)
    addr = 0
    for i, net in enumerate(nets):
        if net in values:
            addr |= values[net] << i
    return addr


def _build_truth_table(
    primary_inputs: List[str], composite_func: callable
) -> Dict[tuple, int]:
    """Build truth table mapping input combinations to outputs."""
    truth_table = {}
    for primary_addr in range(1 << len(primary_inputs)):
        values = {}
        for i, net in enumerate(primary_inputs):
            values[net] = (primary_addr >> i) & 1
        key = tuple(sorted(values.items()))
        truth_table[key] = composite_func(values)
    return truth_table


def _compute_intermediate_init(ctx: ACDContext, cell_name: str) -> int:
    """Compute INIT for a single intermediate cell using ACD rules."""
    cell = ctx.cells_info[cell_name]
    free_vars = ctx.cell_free_vars[cell_name]
    init_width = 1 << len(cell.inputs)
    nets = _get_cell_input_nets(cell)

    free_seen_by_h = [v for v in free_vars if v in ctx.h_sees]
    free_not_seen_by_h = [v for v in free_vars if v not in ctx.h_sees]

    logger.debug(
        "Cell %s: free_seen_by_h=%s, free_not_seen=%s",
        cell_name, free_seen_by_h, free_not_seen_by_h,
    )

    new_init = 0
    for addr in range(init_width):
        # Decode bound variable values from address
        bound_values = {}
        for i, net in enumerate(nets):
            if net in ctx.primary_inputs:
                bound_values[net] = (addr >> i) & 1

        if free_not_seen_by_h:
            # Use "ANY" rule - set bit if any free var combo produces output=1
            if _check_any_produces_one(
                bound_values, free_seen_by_h, free_not_seen_by_h, ctx.truth_table
            ):
                new_init |= 1 << addr
        else:
            # Use "differs" rule - set bit if outputs differ across free vars
            if _check_outputs_differ(bound_values, free_vars, ctx.truth_table):
                new_init |= 1 << addr

    return new_init


def _check_any_produces_one(
    bound_values: Dict[str, int],
    free_seen_by_h: List[str],
    free_not_seen_by_h: List[str],
    truth_table: Dict[tuple, int],
) -> bool:
    """Check if ANY free variable combination produces output=1."""
    for h_seen_addr in range(1 << len(free_seen_by_h)):
        for unseen_addr in range(1 << len(free_not_seen_by_h)):
            test_values = dict(bound_values)
            for j, net in enumerate(free_seen_by_h):
                test_values[net] = (h_seen_addr >> j) & 1
            for j, net in enumerate(free_not_seen_by_h):
                test_values[net] = (unseen_addr >> j) & 1

            key = tuple(sorted(test_values.items()))
            if truth_table[key] == 1:
                return True
    return False


def _check_outputs_differ(
    bound_values: Dict[str, int],
    free_vars: List[str],
    truth_table: Dict[tuple, int],
) -> bool:
    """Check if outputs differ across free variable combinations."""
    outputs = set()
    for free_addr in range(1 << len(free_vars)):
        test_values = dict(bound_values)
        for j, net in enumerate(free_vars):
            test_values[net] = (free_addr >> j) & 1
        key = tuple(sorted(test_values.items()))
        outputs.add(truth_table[key])
        if len(outputs) > 1:
            return True
    return False


def _compute_output_cell_init(
    ctx: ACDContext,
    group: RestructureGroup,
    result_inits: Dict[str, int],
) -> Tuple[int, int]:
    """Compute INIT for the output cell. Returns (init_value, inconsistency_count)."""
    # pylint: disable=too-many-locals
    output_cell = group.output_cell
    output_cell_info = ctx.cells_info[output_cell]
    output_nets = _get_cell_input_nets(output_cell_info)
    output_init_width = 1 << len(output_cell_info.inputs)

    # Build constraints: for each output cell address, collect required outputs
    h_constraints: Dict[int, Set[int]] = {}

    for primary_addr in range(1 << len(ctx.primary_inputs)):
        values = {net: (primary_addr >> i) & 1 for i, net in enumerate(ctx.primary_inputs)}

        # Compute intermediate outputs
        inter_outputs = {}
        for cell_name in group.intermediate_cells:
            cell = ctx.cells_info[cell_name]
            cell_addr = _compute_cell_addr(cell, values)
            inter_outputs[cell.output_net] = (result_inits[cell_name] >> cell_addr) & 1

        # Compute output cell address
        output_addr = 0
        for i, net in enumerate(output_nets):
            if net in inter_outputs:
                output_addr |= inter_outputs[net] << i
            elif net in values:
                output_addr |= values[net] << i

        # Record required output
        key = tuple(sorted(values.items()))
        required = ctx.truth_table[key]
        if output_addr not in h_constraints:
            h_constraints[output_addr] = set()
        h_constraints[output_addr].add(required)

    # Build INIT from constraints
    output_init = 0
    inconsistent = 0
    for addr in range(output_init_width):
        if addr in h_constraints:
            outputs = h_constraints[addr]
            if len(outputs) == 1:
                if 1 in outputs:
                    output_init |= 1 << addr
            else:
                logger.warning("Inconsistent at output addr %d: %s", addr, outputs)
                inconsistent += 1

    return output_init, inconsistent


def build_composite_function(
    group: RestructureGroup, original_props: Dict[str, dict], pre_netlist: Dict[str, CellInfo]
) -> Optional[callable]:
    """
    Build the original composite function for a restructure group.

    The composite function evaluates what the original circuit would output
    given a set of primary input values.

    Returns a function that takes a dict of {net_name: value} and returns the output.
    """
    # Get original cells and their INITs
    original_inits = {}
    for cell_name in group.original_cells:
        init_data = get_original_init(cell_name, original_props)
        if init_data is None:
            logger.warning("Could not find original INIT for %s", cell_name)
            return None
        original_inits[cell_name] = init_data

    # Get cell info from pre-netlist for connectivity
    original_cells_info = {}
    for cell_name in group.original_cells:
        if cell_name not in pre_netlist:
            logger.warning("Cell %s not in pre-netlist", cell_name)
            return None
        original_cells_info[cell_name] = pre_netlist[cell_name]

    # Build a function that evaluates the original circuit
    def evaluate(signal_values: Dict[str, int]) -> int:
        """
        Evaluate the original composite function.
        signal_values maps net names to their values (0 or 1).
        """
        # Cache for evaluated nets
        evaluated = dict(signal_values)

        def get_signal(net_name: str) -> int:
            if net_name in evaluated:
                return evaluated[net_name]

            # Find the cell that produces this net
            for cell_name, cell_info in original_cells_info.items():
                if cell_info.output_net == net_name:
                    # Evaluate this cell
                    init_val, num_bits = original_inits[cell_name]
                    num_inputs = {4: 2, 8: 3, 16: 4, 32: 5, 64: 6}.get(num_bits, 6)

                    inputs = []
                    for i in range(num_inputs):
                        pin = f"I{i}"
                        if pin in cell_info.inputs:
                            input_net = cell_info.inputs[pin]
                            inputs.append(get_signal(input_net))
                        else:
                            inputs.append(0)

                    result = evaluate_lut(init_val, inputs, num_inputs)
                    evaluated[net_name] = result
                    return result

            # If we get here, the net should be a primary input
            logger.warning("Could not resolve signal: %s", net_name)
            return 0

        # Find the output cell - it's the one whose output is NOT consumed by other original cells
        original_input_nets = set()
        for c in original_cells_info.values():
            original_input_nets |= set(c.inputs.values())

        # The output cell's output is not consumed by other original cells
        for cell_name in group.original_cells:
            cell_info = original_cells_info[cell_name]
            if cell_info.output_net and cell_info.output_net not in original_input_nets:
                return get_signal(cell_info.output_net)

        # Fallback: return the first cell's output
        for cell_name in group.original_cells:
            cell_info = original_cells_info[cell_name]
            if cell_info.output_net:
                return get_signal(cell_info.output_net)

        return 0

    return evaluate


def _build_acd_context(
    group: RestructureGroup, final_netlist: Dict[str, CellInfo], composite_func: callable
) -> ACDContext:
    """Build the ACD computation context from group and netlist."""
    # pylint: disable=too-many-locals
    all_cells = [group.output_cell] + group.intermediate_cells
    cells_info = {name: final_netlist[name] for name in all_cells}

    # Map intermediate cell output nets to cell names
    output_to_cell = {}
    for name, cell in cells_info.items():
        if cell.output_net:
            output_to_cell[cell.output_net] = name

    # Identify primary inputs (from outside the group)
    all_inputs: Set[str] = set()
    for cell in cells_info.values():
        all_inputs |= set(cell.inputs.values())
    group_outputs = set(output_to_cell.keys())
    primary_inputs = sorted(all_inputs - group_outputs)

    # Build truth table
    truth_table = _build_truth_table(primary_inputs, composite_func)

    # Identify output cell's primary inputs (h_sees)
    output_cell_info = cells_info[group.output_cell]
    output_nets = _get_cell_input_nets(output_cell_info)
    output_primary_nets = [net for net in output_nets if net in primary_inputs]
    h_sees = set(output_primary_nets)

    # Compute free variables for each intermediate cell
    cell_free_vars = {}
    for cell_name in group.intermediate_cells:
        cell = cells_info[cell_name]
        bound = set(_get_cell_input_nets(cell)) & set(primary_inputs)
        cell_free_vars[cell_name] = sorted(set(primary_inputs) - bound)

    return ACDContext(
        cells_info=cells_info,
        primary_inputs=primary_inputs,
        truth_table=truth_table,
        output_to_cell=output_to_cell,
        cell_free_vars=cell_free_vars,
        h_sees=h_sees,
    )


def compute_restruct_inits(
    group: RestructureGroup, final_netlist: Dict[str, CellInfo], composite_func: callable
) -> Dict[str, int]:
    """
    Compute correct INITs for all cells in a restructure group.

    Uses Ashenhurst-Curtis Decomposition (ACD) with constraint propagation.
    Returns dict mapping cell_name -> new_init.
    """
    ctx = _build_acd_context(group, final_netlist, composite_func)

    logger.info(
        "Computing INITs: %d primary inputs, %d cells",
        len(ctx.primary_inputs), len(group.intermediate_cells) + 1
    )

    # Sort intermediate cells by number of free variables (fewest first)
    sorted_inter = sorted(
        group.intermediate_cells, key=lambda c: len(ctx.cell_free_vars[c])
    )

    result_inits = {}

    # Process intermediate cells
    for cell_name in sorted_inter:
        new_init = _compute_intermediate_init(ctx, cell_name)
        result_inits[cell_name] = new_init
        cell = ctx.cells_info[cell_name]
        init_width = 1 << len(cell.inputs)
        logger.info("Cell %s: INIT = %d'h%X", cell_name, init_width, new_init)

    # Compute output cell INIT
    output_init, inconsistent = _compute_output_cell_init(ctx, group, result_inits)
    result_inits[group.output_cell] = output_init
    output_cell_info = ctx.cells_info[group.output_cell]
    output_init_width = 1 << len(output_cell_info.inputs)
    logger.info(
        "Output cell %s: INIT = %d'h%X (inconsistencies: %d)",
        group.output_cell, output_init_width, output_init, inconsistent,
    )

    return result_inits


# =============================================================================
# Main Tracking Function
# =============================================================================


def track_restruct_transforms(
    pre_phys_opt_dcp: Path, pre_phys_opt_edf: Path, post_phys_opt_dcps: List[Path]
) -> Tuple[
    List[RestructTransform], Dict[str, DependencyNode], List[RestructureGroup], Dict[str, CellInfo]
]:
    """
    Main entry point: track all RESTRUCT_OPT transformations across phys_opt passes.

    Args:
        pre_phys_opt_dcp: DCP before any phys_opt
        pre_phys_opt_edf: EDF before any phys_opt
        post_phys_opt_dcps: List of DCPs after each phys_opt pass (000.dcp, 001.dcp, ...)

    Returns:
        - transforms: List of RestructTransform for each pass
        - dependencies: Dependency graph mapping _comp cells to original cells
        - groups: List of RestructureGroup for INIT computation
        - final_netlist: The final netlist (last checkpoint)
    """
    logger.info(
        "Tracking RESTRUCT_OPT transforms across %d phys_opt passes", len(post_phys_opt_dcps)
    )

    # Parse all netlists using RapidWright
    all_netlists = []

    logger.info("Parsing pre-phys_opt: DCP=%s, EDF=%s", pre_phys_opt_dcp, pre_phys_opt_edf)
    pre_cells = parse_edif_cells_rapidwright(pre_phys_opt_dcp, pre_phys_opt_edf)
    all_netlists.append(pre_cells)
    logger.info("  Found %d cells", len(pre_cells))

    for dcp in post_phys_opt_dcps:
        logger.info("Parsing post-phys_opt DCP: %s", dcp)
        cells = parse_edif_cells_rapidwright(dcp)  # EDF derived from DCP name
        all_netlists.append(cells)
        logger.info("  Found %d cells", len(cells))

    # Diff consecutive netlists
    transforms = []
    for i in range(len(all_netlists) - 1):
        transform = diff_netlists(all_netlists[i], all_netlists[i + 1], i)
        transforms.append(transform)

        if transform.deleted_cells or transform.created_cells:
            logger.info(
                "Pass %d: %d deleted, %d created",
                i,
                len(transform.deleted_cells),
                len(transform.created_cells),
            )

    # Build dependency graph
    dependencies = build_dependency_graph(transforms, all_netlists)
    logger.info("Built dependency graph with %d entries", len(dependencies))

    # Identify restructure groups
    final_netlist = all_netlists[-1]
    groups = identify_restructure_groups(final_netlist, dependencies)

    # Compute primary inputs for each group
    for group in groups:
        group.primary_inputs = identify_primary_inputs(group, final_netlist)
        logger.info("Group %s has %d primary inputs", group.output_cell, len(group.primary_inputs))

    return transforms, dependencies, groups, final_netlist


# =============================================================================
# Testing / CLI
# =============================================================================


def main():
    """Test the transformation tracking on a design."""
    # pylint: disable=import-outside-toplevel
    import argparse
    import sys

    # Add bfasst to path if running standalone
    bfasst_root = Path(__file__).parent.parent.parent.parent
    if str(bfasst_root) not in sys.path:
        sys.path.insert(0, str(bfasst_root))

    # Initialize JVM for RapidWright
    from bfasst import jpype_jvm

    jpype_jvm.start()

    parser = argparse.ArgumentParser(description="Track RESTRUCT_OPT transformations")
    parser.add_argument("--pre-dcp", required=True, type=Path, help="Pre-phys_opt DCP")
    parser.add_argument("--pre-edf", required=True, type=Path, help="Pre-phys_opt EDF")
    parser.add_argument(
        "--post",
        required=True,
        type=Path,
        nargs="+",
        help="Post-phys_opt DCPs (EDF assumed same name)",
    )
    parser.add_argument("-v", "--verbose", action="store_true", help="Verbose output")

    args = parser.parse_args()

    logging.basicConfig(
        level=logging.DEBUG if args.verbose else logging.INFO, format="%(levelname)s: %(message)s"
    )

    transforms, dependencies, groups, _ = track_restruct_transforms(
        args.pre_dcp, args.pre_edf, args.post
    )

    print(f"\nFound {len(transforms)} transformation passes")
    print(f"Found {len(dependencies)} _comp cells with dependencies")
    print(f"Found {len(groups)} restructure groups")

    for group in groups:
        print(f"\nGroup: output={group.output_cell}")
        print(f"  Intermediates: {group.intermediate_cells}")
        print(f"  Original cells: {group.original_cells}")
        print(f"  Primary inputs: {group.primary_inputs}")


if __name__ == "__main__":
    main()
