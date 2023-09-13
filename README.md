![example workflow](https://github.com/byuccl/bfasst/actions/workflows/python.yml/badge.svg)
![example workflow](https://github.com/byuccl/bfasst/actions/workflows/unittests.yml/badge.svg)
![example workflow](https://github.com/byuccl/bfasst/actions/workflows/weeklytests.yml/badge.svg)


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

*Note* : Conformal flows can only be run on a single thread.

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

## The Ninja Transition -- Bfasster 2.0
This branch serves as the transition point to a new version of bfasst, which makes the following changes:
* It takes advantage of the ninja build tool to automatically handle job creation, up-to-date checking of dependencies, parallel processing, and io redirection. 
* It uses chevron, the python implementation of the mustache templating engine to template the scripts used for common operations such as synthesis and implementation of designs.
* It keeps python as its base language, rather than switching to bash in order to minimize the learning curve and maximize portability in transitioning to the new architecture.
* It provides unit tests for all new code, that can be run with `python -m unittest`

### Usage:

There are two steps to running any flow with any design(s): a ninja generation step and a run step. For convenience, a script is included to execute both steps sequentially with a single command:

<pre>Usage:<code>
    python scripts/bfasster.py [--yaml YAML] [--design DESIGN] [--flow FLOW]

options:
    --yaml YAML         The yaml experiment to run, same as with bfasst
    --design DESIGN     The design to run
    --flow FLOW         The flow to use for the specified design

NOTE: You must specify <em>either</em> a yaml file or <em>both</em> a design and flow.
</code></pre>

Alternatively, you can execute the ninja generation step entirely separate from the run step for one or more designs:

<pre>Usage:<code>
    python bfasst/ninja_flows/ninja_flow_manager.py [--flow FLOW] [--designs DESIGN(S)]
    ninja

options:
    --flow FLOW           The flow to use for for the run.
    --designs DESIGN(S)   One or more designs to run the flow on, separated by spaces.
</code></pre>
In either use case, the design should be specified as a subdirectory of the included designs directory in this repo (e.g. 'byu/alu').

Currently supported flows:
* `vivado`
* `vivado_ooc`
* `vivado_and_reversed`
* `vivado_phys_netlist`
* `vivado_phys_netlist_xrev`
* `vivado_phys_netlist_cmp`
* `vivado_structural_error_injection`