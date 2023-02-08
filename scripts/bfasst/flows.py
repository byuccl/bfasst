# pylint: disable=W0613
"""
Script to define CAD flows.
Create your own flow and add it to the Flows class and the flow_fcn_map.
Helper functions for vendor tools are defined.
"""

from enum import Enum
from enum import unique as enum_unique
import pathlib
import shutil

import bfasst
from bfasst.design import Design
from bfasst.transform.xilinx_phys_netlist import XilinxPhysNetlist
from bfasst.utils import error
from bfasst.synth.ic2_lse import Ic2LseSynthesisTool
from bfasst.synth.ic2_synplify import IC2_Synplify_SynthesisTool
from bfasst.synth.vivado import VivadoSynthesisTool
from bfasst.synth.yosys import Yosys_Tech_SynthTool
from bfasst.opt.ic2_lse import Ic2LseOptTool
from bfasst.opt.ic2_synplify import IC2_Synplify_OptTool
from bfasst.impl.ic2 import IC2_ImplementationTool
from bfasst.impl.vivado import VivadoImplementationTool
from bfasst.reverse_bit.xray import XRay_ReverseBitTool
from bfasst.reverse_bit.icestorm import Icestorm_ReverseBitTool
from bfasst.compare.conformal import Conformal_CompareTool
from bfasst.compare.yosys import Yosys_CompareTool
from bfasst.compare.waveform import WaveformCompareTool
from bfasst.compare.onespin import OneSpin_CompareTool
from bfasst.error_injection.error_injector import ErrorInjector_ErrorInjectionTool


class FlowArgs(Enum):
    """An enum describing the different places arguments go"""

    SYNTH = 0
    IMPL = 1
    MAP = 2
    CMP = 3  # Currently only accepts "XILINX" or "LATTICE" for Conformal Comparison
    ERR = 4


@enum_unique
class Flows(Enum):
    """An enum describing the different flows"""

    IC2_LSE_CONFORMAL = "IC2_lse_conformal"
    IC2_SYNPLIFY_CONFORMAL = "IC2_synplify_conformal"
    SYNPLIFY_IC2_ONESPIN = "synplify_IC2_icestorm_onespin"
    YOSYS_TECH_LSE_CONFORMAL = "yosys_tech_lse_conformal"
    YOSYS_TECH_SYNPLIFY_CONFORMAL = "yosys_tech_synplify_conformal"
    YOSYS_TECH_SYNPLIFY_ONESPIN = "yosys_tech_synplify_onespin"
    YOSYS_SYNPLIFY_ERROR_ONESPIN = "yosys_synplify_error_onespin"
    XILINX_CONFORMAL_RTL = "xilinx_conformal"
    XILINX_CONFORMAL_IMPL = "xilinx_conformal_impl"
    XILINX_YOSYS_IMPL = "xilinx_yosys_impl"
    XILINX_YOSYS_WAVEFORM_GRAPH = "xilinx_yosys_waveform_graph"
    XILINX_YOSYS_WAVEFORM_TESTS = "xilinx_yosys_waveform_tests"
    GATHER_IMPL_DATA = "gather_impl_data"
    CONFORMAL_ONLY = "conformal_only"
    XILINX = "xilinx"
    XILINX_PHYS_NETLIST = "xilinx_phys_netlist"


# This uses a lambda so that I don't have to define all of the functions before this point
flow_fcn_map = {
    Flows.IC2_LSE_CONFORMAL: lambda: flow_ic2_lse_conformal,
    Flows.IC2_SYNPLIFY_CONFORMAL: lambda: flow_ic2_synplify_conformal,
    Flows.YOSYS_TECH_LSE_CONFORMAL: lambda: flow_yosys_tech_lse_conformal,
    Flows.YOSYS_TECH_SYNPLIFY_CONFORMAL: lambda: flow_yosys_tech_synplify_conformal,
    Flows.SYNPLIFY_IC2_ONESPIN: lambda: flow_synplify_ic2_icestorm_onespin,
    Flows.YOSYS_TECH_SYNPLIFY_ONESPIN: lambda: flow_yosys_tech_synplify_onespin,
    Flows.YOSYS_SYNPLIFY_ERROR_ONESPIN: lambda: flow_yosys_synplify_error_onespin,
    Flows.XILINX_CONFORMAL_RTL: lambda: flow_xilinx_conformal,
    Flows.XILINX_CONFORMAL_IMPL: lambda: flow_xilinx_conformal_impl,
    Flows.XILINX_YOSYS_IMPL: lambda: flow_xilinx_yosys_impl,
    Flows.XILINX_YOSYS_WAVEFORM_GRAPH: lambda: flow_xilinx_yosys_waveform_graph,
    Flows.XILINX_YOSYS_WAVEFORM_TESTS: lambda: flow_xilinx_yosys_waveform_tests,
    Flows.GATHER_IMPL_DATA: lambda: flow_gather_impl_data,
    Flows.CONFORMAL_ONLY: lambda: flow_conformal_only,
    Flows.XILINX: lambda: flow_xilinx,
    Flows.XILINX_PHYS_NETLIST: lambda: flow_xilinx_phys_netlist,
}


class Vendor(Enum):
    """Enum differentiating between different fpga vendors"""

    LATTICE = 1
    XILINX = 2


def get_flow_fcn_by_name(flow_name):
    """Takes a string representing the flow_name, and returns a function implementing that flow"""
    try:
        flow_enum = Flows(flow_name)
    except ValueError:
        error(flow_name, "is not a valid flow name")

    fcn = flow_fcn_map[flow_enum]()
    return fcn


def run_flow(design, flow_type, flow_args, build_dir):
    """Takes a design object, flow string, flow arguments, and a build directory, and runs it"""
    assert isinstance(design, Design)

    flow_fcn = get_flow_fcn_by_name(flow_type)
    return flow_fcn(design, flow_args, build_dir)


def ic2_lse_synth(design, build_dir, flow_args):
    """Run Icecube2 LSE synthesis"""
    synth_tool = Ic2LseSynthesisTool(build_dir, flow_args)
    return synth_tool.create_netlist(design)


def ic2_synplify_synth(design, build_dir, flow_args):
    """Run Icecube2 Synplify synthesis"""
    synth_tool = IC2_Synplify_SynthesisTool(build_dir)
    return synth_tool.create_netlist(design)


def ic2_impl(design, build_dir, flow_args):
    """Run Icecube2 implementation"""
    impl_tool = IC2_ImplementationTool(build_dir, flow_args)
    return impl_tool.implement_bitstream(design)


# TODO determine flow_args
def icestorm_rev_bit(design, build_dir, flow_args):
    """Reverse bitstream using icestorm"""
    reverse_bit_tool = Icestorm_ReverseBitTool(build_dir, flow_args)
    return reverse_bit_tool.reverse_bitstream(design)


def conformal_cmp(design, build_dir, flow_args):
    """Compare netlists using Conformal"""
    vendor = Vendor.XILINX if not flow_args else Vendor[flow_args.upper()]
    compare_tool = Conformal_CompareTool(build_dir, vendor)
    with bfasst.conformal_lock:
        return compare_tool.compare_netlists(design)


def vivado_synth(design, build_dir, flow_args):
    """Synthesize using Vivado"""
    synth_tool = VivadoSynthesisTool(build_dir, flow_args)
    return synth_tool.create_netlist(design)


def vivado_impl(design, build_dir, flow_args, ooc=False):
    """Implement using Vivado"""
    impl_tool = VivadoImplementationTool(build_dir, flow_args, ooc)
    return impl_tool.implement_bitstream(design)


def yosys_synth(design, build_dir, flow_args):
    """Synthesize using Yosys"""
    synth_tool = Yosys_Tech_SynthTool(build_dir)
    return synth_tool.create_netlist(design)


def yosys_cmp(design, build_dir, flow_args):
    """Compare netlists using yosys"""
    compare_tool = Yosys_CompareTool(build_dir)
    return compare_tool.compare_netlists(design)


def wave_cmp(design, build_dir, run_waveform, tests, vivado):
    """Compare netlists via waveforms"""
    tool = WaveformCompareTool(build_dir)
    return tool.compare_netlists(design, run_waveform, tests, vivado)


def onespin_cmp(design, build_dir, flow_args):
    """Compare netlists using Onespin"""
    compare_tool = OneSpin_CompareTool(build_dir)
    with bfasst.onespin_lock:
        return compare_tool.compare_netlists(design)


def ic2_lse_opt(design, build_dir, flow_args, in_files, lib_files=None):
    """Optimize design using IceCube2 LSE"""
    lse_opt_tool = Ic2LseOptTool(build_dir)
    status = lse_opt_tool.create_netlist(design, in_files, lib_files)
    # Try fixing the netlist LUT inits (there's some issue with how LSE
    #   generates them)
    lse_opt_tool.fix_lut_inits(design)
    return status


def ic2_synplify_opt(design, build_dir, flow_args, in_files, lib_files=None):
    """Optimize design using Icecube2 Synplify"""
    synp_opt_tool = IC2_Synplify_OptTool(build_dir)
    return synp_opt_tool.create_netlist(design, in_files, lib_files)


# TODO determine flow_args
def xray_rev(design, build_dir, flow_args):
    """Reverse bitstream using Xray"""
    reverse_bit_tool = XRay_ReverseBitTool(build_dir)
    return reverse_bit_tool.reverse_bitstream(design)


def flow_ic2_lse_conformal(design, flow_args, build_dir):
    """Synthesize and implement using Icecube2 lse, and compare with Conformal"""
    status = ic2_lse_synth(design, build_dir, flow_args[FlowArgs.SYNTH])

    status = ic2_impl(design, build_dir, flow_args[FlowArgs.IMPL])

    # Run icestorm bitstream reversal
    status = icestorm_rev_bit(design, build_dir, flow_args)

    # Run conformal
    design.compare_golden_files.append(design.top_file)
    design.compare_golden_files.extend(design.get_support_files())
    design.compare_golden_files_paths.append(design.path / design.top_file)
    design.compare_golden_files_paths.extend([design.path / f for f in design.get_support_files()])
    design.golden_is_verilog = design.top_is_verilog()
    status = conformal_cmp(design, build_dir, flow_args[FlowArgs.CMP])
    return status


def flow_conformal_only(design, flow_args, build_dir):
    """Run Conformal in isolation"""
    assert design.netlist_path is not None
    assert design.reversed_netlist_path is not None

    design.golden_sources = [
        design.netlist_path,
    ]
    status = conformal_cmp(design, build_dir, flow_args[FlowArgs.CMP])
    return status


def flow_xilinx(design, flow_args, build_dir):
    """Run Xilinx synthesis and implementation"""
    status = vivado_synth(design, build_dir, flow_args[FlowArgs.SYNTH])
    ooc = "out_of_context" in flow_args[FlowArgs.SYNTH]
    status = vivado_impl(design, build_dir, flow_args[FlowArgs.IMPL], ooc)
    return status


def flow_xilinx_phys_netlist(design, flow_args, build_dir):
    """Run Xilinx synthesis and implementation"""
    status = vivado_synth(design, build_dir, flow_args[FlowArgs.SYNTH])
    ooc = "out_of_context" in flow_args[FlowArgs.SYNTH]
    status = vivado_impl(design, build_dir, flow_args[FlowArgs.IMPL], ooc)

    phy_netlist_tool = XilinxPhysNetlist(build_dir)
    phy_netlist_tool.run(design)
    return status


def flow_xilinx_conformal(design, flow_args, build_dir):
    """Run Xilinx synthesis and implementation and compare with conformal"""
    status = vivado_synth(design, build_dir, flow_args[FlowArgs.SYNTH])
    status = vivado_impl(design, build_dir, flow_args[FlowArgs.IMPL])
    status = xray_rev(design, build_dir, flow_args)
    status = conformal_cmp(design, build_dir, flow_args[FlowArgs.CMP])
    return status


def flow_xilinx_conformal_impl(design, flow_args, build_dir):
    """Vivado synthesis and implementation, reverse with xray, compare with conformal"""
    # Run Xilinx synthesis and implementation
    status = vivado_synth(design, build_dir, flow_args[FlowArgs.SYNTH])
    status = vivado_impl(design, build_dir, flow_args[FlowArgs.IMPL])

    # Run X-ray and fasm2bel
    status = xray_rev(design, build_dir, flow_args)

    # Use conformal to compare against IMPL netlist
    design.golden_sources = [
        design.impl_netlist_path,
    ]

    # TODO Conformal_CompareTool.compare_netlists does not take a mapping arg

    # compare_tool = bfasst.compare.conformal.Conformal_CompareTool(
    #    build_dir, Vendor.XILINX
    # )
    # with bfasst.conformal_lock:
    #    status = compare_tool.compare_netlists(
    #        design, args[FlowArgs.MAP_STAGE.value]
    #    )

    status = conformal_cmp(design, build_dir, flow_args[FlowArgs.CMP])
    return status


def flow_xilinx_yosys_impl(design, flow_args, build_dir):
    """Vivado synthesis and implementation, reverse with xray, compare with yosys"""
    status = vivado_synth(design, build_dir, flow_args[FlowArgs.SYNTH])
    status = vivado_impl(design, build_dir, flow_args[FlowArgs.IMPL])

    # Run X-ray and fasm2bel
    status = xray_rev(design, build_dir, flow_args)

    status = yosys_cmp(design, build_dir, flow_args[FlowArgs.CMP])
    return status


def flow_xilinx_yosys_waveform_graph(design, flow_args, build_dir):
    """Vivado synthesis and implementation, reverse with xray, compare via waveforms"""
    status = vivado_synth(design, build_dir, flow_args[FlowArgs.SYNTH])
    status = vivado_impl(design, build_dir, flow_args[FlowArgs.IMPL])

    # Run X-ray and fasm2bel
    status = xray_rev(design, build_dir, flow_args)
    # Runs WaFoVe with the intent to view graphs of equivalent designs.
    status = wave_cmp(design, build_dir, True, 100, False)

    return status


def flow_xilinx_yosys_waveform_tests(design, flow_args, build_dir):
    """Vivado synthesis and implementation, reverse with xray,
    compare via waveforms (no prompts)"""
    status = vivado_synth(design, build_dir, flow_args[FlowArgs.SYNTH])
    status = vivado_impl(design, build_dir, flow_args[FlowArgs.IMPL])

    # Run X-ray and fasm2bel
    status = xray_rev(design, build_dir, flow_args)
    # Runs WaFoVe with the intent of generating new tests.
    status = wave_cmp(design, build_dir, False, 100, False)

    return status


def flow_ic2_synplify_conformal(design, flow_args, build_dir):
    """Icecube2 Synplify synthesis and implementation, reverse with icestorm,
    compare with Conformal"""
    # Run Icecube2 Synplify synthesis
    status = ic2_synplify_synth(design, build_dir, flow_args[FlowArgs.SYNTH])
    # Run Icecube2 implementations
    status = ic2_impl(design, build_dir, flow_args[FlowArgs.IMPL])

    # Run icestorm bitstream reversal
    status = icestorm_rev_bit(design, build_dir, flow_args)

    # Run conformal
    design.compare_golden_files.append(design.top_file)
    design.compare_golden_files.extend(design.get_support_files())
    design.compare_golden_files_paths.append(design.path / design.top_file)
    design.compare_golden_files_paths.extend([design.path / f for f in design.get_support_files()])
    design.golden_is_verilog = design.top_is_verilog()

    # TODO no vendor was originally specified here
    status = conformal_cmp(design, build_dir, flow_args[FlowArgs.CMP])

    return status


def flow_synplify_ic2_icestorm_onespin(design, flow_args, build_dir):
    """Icecube2 Synplify synthesis and implementation, reverse with icestorm,
    compare with onespin"""
    status = ic2_synplify_synth(design, build_dir, flow_args[FlowArgs.SYNTH])
    # Run Icecube2 implementations
    status = ic2_impl(design, build_dir, flow_args[FlowArgs.IMPL])

    # Run icestorm bitstream reversal
    status = icestorm_rev_bit(design, build_dir, flow_args)

    # Run conformal
    design.compare_golden_files.append(design.top_file)
    design.compare_golden_files.extend(design.get_support_files())
    design.compare_golden_files_paths.append(design.path / design.top_file)
    design.compare_golden_files_paths.extend([design.path / f for f in design.get_support_files()])
    design.golden_is_verilog = design.top_is_verilog()

    status = onespin_cmp(design, build_dir, flow_args[FlowArgs.CMP])

    return status


def flow_yosys_tech_lse_conformal(design, flow_args, build_dir):
    """Synthesize with yosys, optimize and implement with icecube2
    LSE, reverse with icestorm, and compare with conformal"""
    # Run the Yosys synthesizer
    status = yosys_synth(design, build_dir, flow_args[FlowArgs.SYNTH])

    # Now run the LSE synthesizer on the Yosys output
    yosys_netlist_path = design.netlist_path
    design.compare_golden_files.append(yosys_netlist_path.name)
    design.compare_golden_files_paths.append(yosys_netlist_path)
    design.golden_is_verilog = True
    status = ic2_lse_opt(design, build_dir, flow_args, [str(yosys_netlist_path)])

    # Run IC2 Implementation
    status = ic2_impl(design, build_dir, flow_args[FlowArgs.IMPL])

    # Run icestorm bitstream reversal
    status = icestorm_rev_bit(design, build_dir, flow_args)

    # Run conformal
    # TODO no vendor was originally specified here
    status = conformal_cmp(design, build_dir, flow_args[FlowArgs.CMP])

    return status


def flow_yosys_tech_synplify_conformal(design, flow_args, build_dir):
    """Synthesize with yosys, optimize and implement with icecube2
    Synplify, reverse with icestorm, and compare with conformal"""
    # Run the Yosys synthesizer
    status = yosys_synth(design, build_dir, flow_args[FlowArgs.SYNTH])

    # Now run the Synplify synthesizer on the Yosys output
    yosys_netlist_path = design.netlist_path
    design.compare_golden_files.append(yosys_netlist_path.name)
    design.compare_golden_files_paths.append(yosys_netlist_path)
    design.golden_is_verilog = True
    status = ic2_synplify_opt(design, build_dir, flow_args, [str(yosys_netlist_path)])

    # Run IC2 Implementation
    status = ic2_impl(design, build_dir, flow_args[FlowArgs.IMPL])

    # Run icestorm bitstream reversal
    status = icestorm_rev_bit(design, build_dir, flow_args)

    # Run conformal
    # TODO No Vendor was originally specified
    status = conformal_cmp(design, build_dir, flow_args[FlowArgs.CMP])

    return status


def flow_yosys_tech_synplify_onespin(design, flow_args, build_dir):
    """Synthesize with yosys, optimize and implement with icecube2
    Synplify, reverse with icestorm, and compare with Onespin"""
    # Run the Yosys synthesizer
    status = yosys_synth(design, build_dir, flow_args[FlowArgs.SYNTH])

    # Now run the Synplify synthesizer on the Yosys output
    yosys_netlist_path = design.netlist_path
    design.compare_golden_files.append(yosys_netlist_path.name)
    design.compare_golden_files_paths.append(yosys_netlist_path)
    design.golden_is_verilog = True
    status = ic2_synplify_opt(design, build_dir, flow_args, [str(yosys_netlist_path)])

    # Run IC2 Implementation
    status = ic2_impl(design, build_dir, flow_args[FlowArgs.IMPL])

    # Run icestorm bitstream reversal
    status = icestorm_rev_bit(design, build_dir, flow_args)

    design.compare_revised_file = design.reversed_netlist_filename()
    status = onespin_cmp(design, build_dir, flow_args[FlowArgs.CMP])
    return status


def flow_yosys_synplify_error_onespin(design, flow_args, build_dir):
    """Synthesize with yosys, inject errors, optimize and implement
    with icecube2 Synplify, reverse with icestorm, and compare
    with Onespin"""
    # Set the results file path so it can be used in the different tools
    design.results_summary_path = build_dir / "results_summary.txt"

    # Run the Yosys synthesizer
    status = yosys_synth(design, build_dir, flow_args[FlowArgs.SYNTH])

    # Run error injection
    error_inj_tool = ErrorInjector_ErrorInjectionTool(build_dir)
    ret = error_inj_tool.run_error_flows(design)
    status = ret[0]

    # Run Synth, impl, and icestorm on the original netlist
    # Now run the Synplify synthesizer on the Yosys output
    yosys_netlist_path = design.netlist_path
    design.compare_golden_files.append(yosys_netlist_path.name)
    design.compare_golden_files_paths.append(yosys_netlist_path)
    design.golden_is_verilog = True
    status = ic2_synplify_opt(design, build_dir, flow_args, [str(yosys_netlist_path)])

    # Run IC2 Implementation
    status = ic2_impl(design, build_dir, flow_args[FlowArgs.IMPL])

    # Run icestorm bitstream reversal
    status = icestorm_rev_bit(design, build_dir, flow_args)

    design.compare_revised_file = design.reversed_netlist_filename()
    status = onespin_cmp(design, build_dir, flow_args[FlowArgs.CMP])

    # Also use the compare tool to make a compare script for rtl to yosys
    design.compare_revised_file = yosys_netlist_path.name
    design.compare_golden_files = design.get_support_files()
    design.compare_golden_files.append(pathlib.Path(design.top_path()).name)
    status = onespin_cmp(design, build_dir, flow_args[FlowArgs.CMP])

    # Run synth, impl, icestorm, and onespin on each corrupted netlist
    design.compare_golden_files = [yosys_netlist_path.name]
    design.compare_golden_files_paths = [yosys_netlist_path]
    for netlist_name_tuple in ret[1]:
        netlist = netlist_name_tuple[0]
        error_flow_name = netlist_name_tuple[1]
        design.cur_error_flow_name = error_flow_name

        # Now run the Synplify synthesizer on the Yosys output
        design.golden_is_verilog = True
        # Blow away the opt dir so we know we're getting a fresh build
        shutil.rmtree(build_dir / IC2_Synplify_OptTool.TOOL_WORK_DIR)
        status = ic2_synplify_opt(design, build_dir, flow_args, [str(netlist)])

        # Run IC2 Implementation
        shutil.rmtree(build_dir / IC2_ImplementationTool.TOOL_WORK_DIR)
        status = ic2_impl(design, build_dir, flow_args[FlowArgs.IMPL])

        # Run icestorm bitstream reversal
        shutil.rmtree(build_dir / Icestorm_ReverseBitTool.TOOL_WORK_DIR)
        status = icestorm_rev_bit(design, build_dir, flow_args)

        # Run compare to create a onespin tcl for yosys->corrupt reversed netlist
        design.compare_revised_file = design.reversed_netlist_filename()
        compare_tool = OneSpin_CompareTool(build_dir)
        with bfasst.onespin_lock:
            status = compare_tool.compare_netlists(design)

        # Run compare again so we can check yosys netlist -> corrupt yosys
        #   netlist
        # This lets us make sure that any compare errors are because of the
        #   netlist corruption, and not some other issue
        design.compare_revised_file = netlist.name
        with bfasst.onespin_lock:
            status = compare_tool.compare_netlists(design)

    # Write the python script to run all of the compare tcl scripts
    compare_tool.write_compare_script(design)

    return status


def flow_gather_impl_data(design, flow_args, build_dir):
    """This flow is mainly to try running the tools with different
    synthesis/ implementation (e.g. synplify vs yosys, etc.) options to
    compare their physical results (e.g. LUT counts, FF counts, etc)"""

    # Set the results file path so it can be used in the different tools
    design.results_summary_path = build_dir / "results_summary.txt"

    # Start with an RTL->Synplify->IC2->Icestorm flow
    # Run Icecube2 Synplify synthesis
    status = ic2_synplify_synth(design, build_dir, flow_args[FlowArgs.SYNTH])

    # Run Icecube2 implementations
    status = ic2_impl(design, build_dir, flow_args[FlowArgs.IMPL])

    # Run icestorm bitstream reversal
    status = icestorm_rev_bit(design, build_dir, flow_args)

    # Clean up project directories so we get fresh results later
    if (build_dir / IC2_Synplify_OptTool.TOOL_WORK_DIR).exists():
        shutil.rmtree(build_dir / IC2_Synplify_OptTool.TOOL_WORK_DIR)
    shutil.rmtree(build_dir / IC2_Synplify_SynthesisTool.TOOL_WORK_DIR)
    shutil.rmtree(build_dir / IC2_ImplementationTool.TOOL_WORK_DIR)
    shutil.rmtree(build_dir / Icestorm_ReverseBitTool.TOOL_WORK_DIR)
    # Now do RTL->LSE->IC2->Icestorm
    # Run Icecube2 LSE synthesis
    status = ic2_lse_synth(design, build_dir, flow_args[FlowArgs.SYNTH])

    # Run Icecube2 implementations
    status = ic2_impl(design, build_dir, flow_args[FlowArgs.IMPL])

    # Run icestorm bitstream reversal
    status = icestorm_rev_bit(design, build_dir, flow_args)

    # Clean up project directories so we get fresh results later
    if (build_dir / Ic2LseOptTool.TOOL_WORK_DIR).exists():
        shutil.rmtree(build_dir / Ic2LseOptTool.TOOL_WORK_DIR)
    shutil.rmtree(build_dir / Ic2LseSynthesisTool.TOOL_WORK_DIR)
    shutil.rmtree(build_dir / IC2_ImplementationTool.TOOL_WORK_DIR)
    shutil.rmtree(build_dir / Icestorm_ReverseBitTool.TOOL_WORK_DIR)

    # Now do Yosys->Synplify->IC2->Icestorm
    # Run the Yosys synthesizer
    status = yosys_synth(design, build_dir, flow_args[FlowArgs.SYNTH])
    # Now run the Synplify synthesizer on the Yosys output
    yosys_netlist_path = design.netlist_path
    status = ic2_synplify_opt(design, build_dir, flow_args, [str(yosys_netlist_path)])

    # Run IC2 Implementation
    status = ic2_impl(design, build_dir, flow_args[FlowArgs.IMPL])

    # Run icestorm bitstream reversal
    status = icestorm_rev_bit(design, build_dir, flow_args)

    # Clean up project directories so we get fresh results later
    shutil.rmtree(build_dir / Yosys_Tech_SynthTool.TOOL_WORK_DIR)

    # TODO check that this line should be added.
    shutil.rmtree(build_dir / IC2_Synplify_OptTool.TOOL_WORK_DIR)

    shutil.rmtree(build_dir / IC2_ImplementationTool.TOOL_WORK_DIR)
    shutil.rmtree(build_dir / Icestorm_ReverseBitTool.TOOL_WORK_DIR)

    # Now do Yosys->LSE->IC2->Icestorm
    # Run the Yosys synthesizer
    status = yosys_synth(design, build_dir, flow_args[FlowArgs.SYNTH])

    # Now run the LSE synthesizer on the Yosys output
    yosys_netlist_path = design.netlist_path
    status = ic2_lse_opt(design, build_dir, flow_args, [str(yosys_netlist_path)])

    # Run IC2 Implementation
    status = ic2_impl(design, build_dir, flow_args[FlowArgs.IMPL])

    # Run icestorm bitstream reversal
    status = icestorm_rev_bit(design, build_dir, flow_args)

    return status
