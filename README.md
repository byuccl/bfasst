# BFASST (BYU FPGA Assurance Tool)

The BFASST tool is a Python package located at `scripts/bfasst`.  The tool can be used to compose custom FPGA CAD flows.  Many of these flows are already defined and can be found in `flows.py`.

Example designs are located in the `examples` directory.

To run an example design, use `./scripts/run_design.py design_path flow`:

```
usage: run_design.py [-h] [--quiet] [--error_flow {cross_wires,tap_signal,single_bit_flip}]
                     design_path {IC2_lse_conformal,IC2_synplify_conformal,synplify_IC2_icestorm_onespin,yosys_tech_lse_conformal,yosys_tech_synplify_conformal,yosys_tech_synplify_onespin,yosys_synplify_error_onespin,xilinx_conformal,xilinx_conformal_impl,gather_impl_data,conformal_only}
run_design.py: error: the following arguments are required: design_path, flow
```

There are also several pre-configured *experiments*, which allow you to run a large set of designs and collect results.  These configurations are located within the `experiments` directory, and can be run using `./scripts/run_experiment.py`:
```
usage: run_experiment.py [-h] [-j THREADS] experiment_yaml
run_experiment.py: error: the following arguments are required: experiment_yaml
```

