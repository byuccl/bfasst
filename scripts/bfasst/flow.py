import enum
import abc
import os

import bfasst


@enum.unique
class Flows(enum.Enum):
    IC2_LSE_CONFORMAL = "IC2_lse_conformal"
    IC2_SYNPLIFY_CONFORMAL = "IC2_synplify_conformal"
    SYNPLIFY_IC2_ONESPIN = "synplify_IC2_icestorm_onespin"
    YOSYS_TECH_LSE_CONFORMAL = "yosys_tech_lse_conformal"
    YOSYS_TECH_SYNPLIFY_CONFORMAL = "yosys_tech_synplify_conformal"
    YOSYS_TECH_SYNPLIFY_ONESPIN = "yosys_tech_synplify_onespin"
    YOSYS_SYNPLIFY_ERROR_ONESPIN = "yosys_synplify_error_onespin"


# This uses a lambda so that I don't have to define all of the functions before this point
flow_fcn_map = {
    Flows.IC2_LSE_CONFORMAL: lambda: flow_ic2_lse_conformal,
    Flows.IC2_SYNPLIFY_CONFORMAL: lambda: flow_ic2_synplify_conformal,
    Flows.YOSYS_TECH_LSE_CONFORMAL: lambda: flow_yosys_tech_lse_conformal,
    Flows.YOSYS_TECH_SYNPLIFY_CONFORMAL: lambda: flow_yosys_tech_synplify_conformal,
    Flows.SYNPLIFY_IC2_ONESPIN: lambda: flow_synplify_ic2_icestorm_onespin,
    Flows.YOSYS_TECH_SYNPLIFY_ONESPIN: lambda: flow_yosys_tech_synplify_onespin,
    Flows.YOSYS_SYNPLIFY_ERROR_ONESPIN: lambda: flow_yosys_synplify_error_onespin
}

def get_flow_fcn_by_name(flow_name):
    invalid_flow = False

    try:
        flow_enum = Flows(flow_name)
    except ValueError:
        invalid_flow = True
        
    if invalid_flow:
        bfasst.utils.error(flow_name, "is not a valid flow name")

    fcn = flow_fcn_map[flow_enum]()
    return fcn



class Tool(abc.ABC):
    def __init__(self, cwd):
        super().__init__()
        self.cwd = cwd

        self.work_dir = self.make_work_dir()

    @property
    @classmethod
    @abc.abstractclassmethod
    def TOOL_WORK_DIR(self):
        raise NotImplementedError

    def make_work_dir(self):
        work_dir = self.cwd / self.TOOL_WORK_DIR

        if not work_dir.is_dir():
            work_dir.mkdir()
        return work_dir

def run_flow(design, flow_type, build_dir):
    assert type(design) is bfasst.design.Design

    flow_fcn = bfasst.flow.get_flow_fcn_by_name(flow_type)
    return flow_fcn(design, build_dir)


def flow_ic2_lse_conformal(design, build_dir):
    # Run Icecube2 LSE synthesis
    synth_tool = bfasst.synth.ic2_lse.IC2_LSE_SynthesisTool(build_dir)
    status = synth_tool.create_netlist(design)
    if status.error:
        return status

    # Run Icecube2 implementations
    impl_tool = bfasst.impl.ic2.IC2_ImplementationTool(build_dir)
    status = impl_tool.implement_bitstream(design)
    if status.error:
        return status

    # Run icestorm bitstream reversal
    reverse_bit_tool = bfasst.reverse_bit.icestorm.Icestorm_ReverseBitTool(
        build_dir)
    status = reverse_bit_tool.reverse_bitstream(design)
    if status.error:
        return status

    # Run conformal
    design.compare_golden_files.append(design.top_file)
    design.compare_golden_files.extend(design.get_support_files())
    design.compare_golden_files_paths.append(design.full_path / design.top_file)
    design.compare_golden_files_paths.extend([design.full_path / f for f in design.get_support_files()])
    design.golden_is_verilog = design.top_is_verilog()
    compare_tool = bfasst.compare.conformal.Conformal_CompareTool(build_dir)
    status = None
    with bfasst.conformal_lock:
        status = compare_tool.compare_netlists(design)
    if status.error:
        return status

    return status

def flow_ic2_synplify_conformal(design, build_dir):
    # Run Icecube2 Synplify synthesis
    synth_tool = bfasst.synth.ic2_synplify.IC2_Synplify_SynthesisTool(build_dir)
    status = synth_tool.create_netlist(design)
    if status.error:
        return status

    # Run Icecube2 implementations
    impl_tool = bfasst.impl.ic2.IC2_ImplementationTool(build_dir)
    status = impl_tool.implement_bitstream(design)
    if status.error:
        return status

    # Run icestorm bitstream reversal
    reverse_bit_tool = bfasst.reverse_bit.icestorm.Icestorm_ReverseBitTool(
        build_dir)
    status = reverse_bit_tool.reverse_bitstream(design)
    if status.error:
        return status

    # Run conformal
    design.compare_golden_files.append(design.top_file)
    design.compare_golden_files.extend(design.get_support_files())
    design.compare_golden_files_paths.append(design.full_path / design.top_file)
    design.compare_golden_files_paths.extend([design.full_path / f for f in design.get_support_files()])
    design.golden_is_verilog = design.top_is_verilog()
    compare_tool = bfasst.compare.conformal.Conformal_CompareTool(build_dir)
    with bfasst.conformal_lock:
        status = compare_tool.compare_netlists(design)
    if status.error:
        return status

    return status

def flow_synplify_ic2_icestorm_onespin(design, build_dir):
    # Run Icecube2 Synplify synthesis
    synth_tool = bfasst.synth.ic2_synplify.IC2_Synplify_SynthesisTool(build_dir)
    status = synth_tool.create_netlist(design)
    if status.error:
        return status

    # Run Icecube2 implementations
    impl_tool = bfasst.impl.ic2.IC2_ImplementationTool(build_dir)
    status = impl_tool.implement_bitstream(design)
    if status.error:
        return status

    # Run icestorm bitstream reversal
    reverse_bit_tool = bfasst.reverse_bit.icestorm.Icestorm_ReverseBitTool(
        build_dir)
    status = reverse_bit_tool.reverse_bitstream(design)
    if status.error:
        return status

    # Run conformal
    design.compare_golden_files.append(design.top_file)
    design.compare_golden_files.extend(design.get_support_files())
    design.compare_golden_files_paths.append(design.full_path / design.top_file)
    design.compare_golden_files_paths.extend([design.full_path / f for f in design.get_support_files()])
    design.golden_is_verilog = design.top_is_verilog()

    compare_tool = bfasst.compare.onespin.OneSpin_CompareTool(build_dir)
    with bfasst.onespin_lock:
        status = compare_tool.compare_netlists(design)
    if status.error:
        return status

    return status


def flow_yosys_tech_lse_conformal(design, build_dir):
    # Run the Yosys synthesizer
    yosys_synth_tool = bfasst.synth.yosys.Yosys_Tech_SynthTool(build_dir)
    status = yosys_synth_tool.create_netlist(design)
    if status.error:
        return status

    # Now run the LSE synthesizer on the Yosys output
    yosys_netlist_path = design.netlist_path
    design.compare_golden_files.append(yosys_netlist_path.name)
    design.compare_golden_files_paths.append(yosys_netlist_path)
    design.golden_is_verilog = True
    lse_opt_tool = bfasst.opt.ic2_lse.IC2_LSE_OptTool(build_dir)
    status = lse_opt_tool.create_netlist(design, [str(yosys_netlist_path)], [])
    if (status.error):
        return status

    # Try fixing the netlist LUT inits (there's some issue with how LSE
    #   generates them)
    lse_opt_tool.fix_lut_inits(design)
    
    # Run IC2 Implementation
    impl_tool = bfasst.impl.ic2.IC2_ImplementationTool(build_dir)
    status = impl_tool.implement_bitstream(design)
    if status.error:
        return status

    # Run icestorm bitstream reversal
    reverse_bit_tool = bfasst.reverse_bit.icestorm.Icestorm_ReverseBitTool(
        build_dir)
    status = reverse_bit_tool.reverse_bitstream(design)
    if status.error:
        return status

    # Run conformal
    compare_tool = bfasst.compare.conformal.Conformal_CompareTool(build_dir)
    with bfasst.conformal_lock:
        status = compare_tool.compare_netlists(design)
    if status.error:
        return status

    return status
    
    print(build_dir)

def flow_yosys_tech_synplify_conformal(design, build_dir):
    # Run the Yosys synthesizer
    yosys_synth_tool = bfasst.synth.yosys.Yosys_Tech_SynthTool(build_dir)
    status = yosys_synth_tool.create_netlist(design)
    if status.error:
        return status

    # Now run the Synplify synthesizer on the Yosys output
    yosys_netlist_path = design.netlist_path
    design.compare_golden_files.append(yosys_netlist_path.name)
    design.compare_golden_files_paths.append(yosys_netlist_path)
    design.golden_is_verilog = True
    synp_opt_tool = bfasst.opt.ic2_synplify.IC2_Synplify_OptTool(build_dir)
    status = synp_opt_tool.create_netlist(design, [str(yosys_netlist_path)], [])
    if (status.error):
        return status
    
    # Run IC2 Implementation
    impl_tool = bfasst.impl.ic2.IC2_ImplementationTool(build_dir)
    status = impl_tool.implement_bitstream(design)
    if status.error:
        return status

    # Run icestorm bitstream reversal
    reverse_bit_tool = bfasst.reverse_bit.icestorm.Icestorm_ReverseBitTool(
        build_dir)
    # Now actually reverse the bitstream
    status = reverse_bit_tool.reverse_bitstream(design)
    if status.error:
        return status

    # Run conformal
    compare_tool = bfasst.compare.conformal.Conformal_CompareTool(build_dir)
    with bfasst.conformal_lock:
        status = compare_tool.compare_netlists(design)
    if status.error:
        return status

    return status
    
    print(build_dir)

def flow_yosys_tech_synplify_onespin(design, build_dir):
    # Run the Yosys synthesizer
    yosys_synth_tool = bfasst.synth.yosys.Yosys_Tech_SynthTool(build_dir)
    status = yosys_synth_tool.create_netlist(design)
    if status.error:
        return status

    # Now run the Synplify synthesizer on the Yosys output
    yosys_netlist_path = design.netlist_path
    design.compare_golden_files.append(yosys_netlist_path.name)
    design.compare_golden_files_paths.append(yosys_netlist_path)
    design.golden_is_verilog = True
    synp_opt_tool = bfasst.opt.ic2_synplify.IC2_Synplify_OptTool(build_dir)
    status = synp_opt_tool.create_netlist(design, [str(yosys_netlist_path)], [])
    if (status.error):
        return status
    
    # Run IC2 Implementation
    impl_tool = bfasst.impl.ic2.IC2_ImplementationTool(build_dir)
    status = impl_tool.implement_bitstream(design)
    if status.error:
        return status

    # Run icestorm bitstream reversal
    reverse_bit_tool = bfasst.reverse_bit.icestorm.Icestorm_ReverseBitTool(
        build_dir)
    # Now actually reverse the bitstream
    status = reverse_bit_tool.reverse_bitstream(design)
    if status.error:
        return status
    
    compare_tool = bfasst.compare.onespin.OneSpin_CompareTool(build_dir)
    with bfasst.onespin_lock:
        status = compare_tool.compare_netlists(design)
    if status.error:
        return status

    return status

def flow_yosys_synplify_error_onespin(design, build_dir):
    # Run the Yosys synthesizer
    yosys_synth_tool = bfasst.synth.yosys.Yosys_Tech_SynthTool(build_dir)
    status = yosys_synth_tool.create_netlist(design)
    if status.error:
        return status

    # Run error injection
    error_inj_tool = bfasst.error_injection.error_injector.ErrorInjector_ErrorInjectionTool(build_dir)
    ret = error_inj_tool.run_error_flows(design)
    status = ret[0]
    if status.error:
        return status

    # Run Synth, impl, and icestorm on the original netlist
    # Now run the Synplify synthesizer on the Yosys output
    yosys_netlist_path = design.netlist_path
    design.compare_golden_files.append(yosys_netlist_path.name)
    design.compare_golden_files_paths.append(yosys_netlist_path)
    design.golden_is_verilog = True
    synp_opt_tool = bfasst.opt.ic2_synplify.IC2_Synplify_OptTool(build_dir)
    status = synp_opt_tool.create_netlist(design, [str(yosys_netlist_path)], [])
    if status.error:
        return status
    
    # Run IC2 Implementation
    impl_tool = bfasst.impl.ic2.IC2_ImplementationTool(build_dir)
    status = impl_tool.implement_bitstream(design)
    if status.error:
        return status

    # Run icestorm bitstream reversal
    reverse_bit_tool = bfasst.reverse_bit.icestorm.Icestorm_ReverseBitTool(
        build_dir)
    # Now actually reverse the bitstream
    status = reverse_bit_tool.reverse_bitstream(design)
    if status.error:
        return status
    
    # Run synth, impl, icestorm, and onespin on each corrupted netlist
    for netlist_name_tuple in ret[1]:
        netlist = netlist_name_tuple[0]
        error_flow_name = netlist_name_tuple[1]
        design.cur_error_flow_name = error_flow_name

        # Now run the Synplify synthesizer on the Yosys output
        design.golden_is_verilog = True
        synp_opt_tool = bfasst.opt.ic2_synplify.IC2_Synplify_OptTool(build_dir)
        status = synp_opt_tool.create_netlist(design, [str(netlist)], [])
        if status.error:
            return status
    
        # Run IC2 Implementation
        impl_tool = bfasst.impl.ic2.IC2_ImplementationTool(build_dir)
        status = impl_tool.implement_bitstream(design)
        if status.error:
            return status

        # Run icestorm bitstream reversal
        reverse_bit_tool = bfasst.reverse_bit.icestorm.Icestorm_ReverseBitTool(
            build_dir)
        # Now actually reverse the bitstream
        status = reverse_bit_tool.reverse_bitstream(design)
        if status.error:
            return status
    
        compare_tool = bfasst.compare.onespin.OneSpin_CompareTool(build_dir)
        with bfasst.onespin_lock:
            status = compare_tool.compare_netlists(design)
        if status.error:
            print("Error status in compare tool!")
            # return status

    return status
    
