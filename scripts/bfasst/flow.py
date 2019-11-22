import enum

import bfasst

@enum.unique
class Flows(enum.Enum):
    IC2_LSE_CONFORMAL = "IC2_lse_conformal"


# This uses a lambda so that I don't have to define all of the functions before this point
flow_fcn_map = {
    Flows.IC2_LSE_CONFORMAL: lambda design, build_dir: flow_ic2_lse_conformal(design, build_dir),
}


def run_flow(design, flow_type, build_dir):
    assert type(design) is bfasst.design.Design
    return flow_fcn_map[flow_type](design, build_dir)

def flow_ic2_lse_conformal(design, build_dir):
    synth_tool = bfasst.synth.ic2_lse.IC2_LSE_SynthesisTool()
    (netlist_path, status) = synth_tool.create_netlist(design, build_dir)
    if status.error:
        return status

    impl_tool = bfasst.impl.ic2.IC2_ImplementationTool()
    (bitstream, status) = impl_tool.implement_bitstream(design, netlist_path, build_dir)
    if status.error:
        return status

    # Still need to implement the icestorm + conformal part of my original makefile
    
    return status