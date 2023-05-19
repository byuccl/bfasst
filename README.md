![example workflow](https://github.com/byuccl/bfasst/actions/workflows/python.yml/badge.svg)
![example workflow](https://github.com/byuccl/bfasst/actions/workflows/unittests.yml/badge.svg)


# BFASST (BYU FPGA Assurance Tool)

The BFASST tool is a Python package located at `bfasst/`.  The tool can be used to compose custom FPGA CAD flows.  Many of these flows are already defined and can be found in `flows.py`.

Example designs are located in the `designs` directory.

To run an example design, use `python scripts/run_design.py design_path flow`:

```
usage: run_design.py [-h] [--synth SYNTH] [--impl IMPL] [--map MAP] [--cmp CMP] [--reverse REVERSE] [--err ERR] [--quiet] [--error_flow {single_bit_flip,tap_signal,cross_wires}]
                     design_path
                     {IC2_lse_conformal,IC2_synplify_conformal,ccl_map,conformal_only,gather_impl_data,structural_map,synplify_IC2_icestorm_onespin,xilinx,xilinx_and_reversed,xilinx_conformal,xilinx_conformal_impl,xilinx_ooc,xilinx_phys_netlist,xilinx_phys_netlist_cmp,xilinx_yosys_impl,xilinx_yosys_wafove,yosys_synplify_error_onespin,yosys_tech_lse_conformal,yosys_tech_synplify_conformal,yosys_tech_synplify_onespin}

positional arguments:
  design_path           Path to design in examples directory.
  {IC2_lse_conformal,IC2_synplify_conformal,ccl_map,conformal_only,gather_impl_data,structural_map,synplify_IC2_icestorm_onespin,xilinx,xilinx_and_reversed,xilinx_conformal,xilinx_conformal_impl,xilinx_ooc,xilinx_phys_netlist,xilinx_phys_netlist_cmp,xilinx_yosys_impl,xilinx_yosys_wafove,yosys_synplify_error_onespin,yosys_tech_lse_conformal,yosys_tech_synplify_conformal,yosys_tech_synplify_onespin}

options:
  -h, --help            show this help message and exit
  --synth SYNTH         Synthesis args
  --impl IMPL           Implementation args
  --map MAP             Mapping args
  --cmp CMP             Comparison args
  --reverse REVERSE     Reverse args
  --err ERR             Error flow args
  --quiet
  --error_flow {single_bit_flip,tap_signal,cross_wires}
                        YAML file describing errors to inject for testing.Only works with flows designed for error injection
```

There are also several pre-configured *experiments*, which allow you to run a large set of designs and collect results.  These configurations are located within the `experiments` directory, and can be run using `python ./scripts/run_experiment.py`:
```
usage: run_experiment.py [-h] [-j THREADS] [--print_period PRINT_PERIOD] experiment_yaml

positional arguments:
  experiment_yaml       Experiment yaml file.

options:
  -h, --help            show this help message and exit
  -j THREADS, --threads THREADS
                        Number of threads
  --print_period PRINT_PERIOD
```

## Install
### Prerequisites
* Install Vivado 2022.2
  * Update the first line of the Makefile and make sure the path points to your Vivado installation. 
* Clone this github repository. 
* Install necessary packages:
  * ```sudo make packages```
* Install Capnproto Java
  * ```sudo make capnproto_java```
### Install BFASST
* Install the Python virtual environment, activate, and install packages:
  * `make install`

## Tools
BFASST can be used to compose different CAD flows from severals tools.  These tools are installed with BFASST.
Before running any bfasst flows, always make sure you have activated the BFASST environment:
```. .venv/bin/activate``` (ran in the bfasst root directory).

### WaFoVe
A Waveform Verification tool. In other words, a tool used to confirm that two Verilog designs are equivalent through analyzing their waveforms.
  * See <https://github.com/byuccl/WaFoVe/blob/master/documentation/README.md> for more details

### Fasm2Bels
Information found here: <https://github.com/chipsalliance/f4pga-xc-fasm2bels/blob/master/README.md>
  * This tool depends on Project X-Ray (installed automatically with Fasm2Bels): <https://github.com/f4pga/prjxray/blob/master/README.md>

### RapidWright
Information found here: <https://github.com/Xilinx/RapidWright/blob/master/README.md>

### Yosys
An open source synthesis tool. <https://github.com/YosysHQ/yosys/blob/master/README.md>

### Conformal
The conformal plugin is currently designed to run conformal on a remote machine (CAEDM machine at BYU).
  * Set up your SSH with caedm. You'll know if you set it up correctly when you can use ```ssh caedm``` and log in without having to enter your password. Follow the guide at <https://byu-cpe.github.io/ComputingBootCamp/tutorials/linux/> .
  * Open _bfasst/config.py_. Change _fsj/squallz_ to your caedm login info. For instance, if you connect to caedm and enter ```pwd``` and your info is _/hij/username_, change _fsj/squallz_ to _hij/username_.
Finally, test to confirm that everything worked correctly! Run the following:
1. Activate the virual environment: ```. .venv/bin/activate```
2. Run the flow:  ```python scripts/run_design.py designs/basic/add4/ xilinx_conformal_impl```

