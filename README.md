![example workflow](https://github.com/byuccl/bfasst/actions/workflows/python.yml/badge.svg)
![example workflow](https://github.com/byuccl/bfasst/actions/workflows/unittests.yml/badge.svg)
![example workflow](https://github.com/byuccl/bfasst/actions/workflows/weeklytests.yml/badge.svg)


# BFASST (BYU FPGA Assurance Tool)

The BFASST tool is a Python package located at `bfasst/`.  The tool can be used to compose custom FPGA CAD flows.  Many of these flows are already defined and can be found in `bfasst/flows/flow_descriptions.yaml`.

Example designs are located in the `designs/` directory.

Before running any bfasst flows, always make sure you have activated the BFASST environment:
```. .venv/bin/activate``` (ran in the bfasst root directory).

Also, make sure to run `source ~/.bashrc` after installation

To run bfasst, use `run_flow` as follows:

```
Usage: 
  run_flow [-h] [--flow_arguments FLOW_ARGUMENTS] flow_name_or_yaml_path [design ...]

positional arguments:
  flow_name_or_yaml_path              Name of the desired flow or path to a yaml file with a list of designs and the flow.
  design                              Design(s) to run the flow on (e.g. byu/alu byu/counter byu/uart to run all three designs through the flow)

options:
  -h, --help                          Show this help message and exit
  --flow_arguments FLOW_ARGUMENTS     Arguments to pass to the flow, as python dict (e.g. "{'num_runs': 10}" for error_injection flow)
  -j --jobs INT                       Specifies the number of jobs ninja can run in parallel (e.g. "run_flow basic/and3 -j 4")
```

Note that if a yaml file is specified, neither a design nor flow should be specified. Flow arguments and the jobs argument are optional; flows will always run with valid default arguments.

## Install
### Prerequisites
* Install Vivado 2022.2
* Clone this github repository. 
  * Update the first line of the Makefile and make sure the path points to your Vivado installation. 
* Install necessary packages:
  * ```sudo make packages```
* Install Capnproto Java
  * ```sudo make capnproto_java```
### Install BFASST
* Install the Python virtual environment, activate, and install packages:
  * `make install`
  * Remember to restart your terminal or run `source ~/.bashrc` so autocompletion works correctly

## Tools
BFASST can be used to compose different CAD flows from severals tools.  These tools are installed with BFASST.

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
  * Open _bfasst/config.py_. Change the `CONFORMAL_REMOTE_MACHINE_USER`, `CONFORMAL_REMOTE_WORK_DIR`, and `CONFORMAL_REMOTE_LIBS_DIR` to your caedm login info. For instance, if you connect to caedm and enter ```pwd``` and your info is _/hij/username_, change _fsj/jgoeders_ to _hij/username_ and the machine user to _username_.
Finally, test to confirm that everything worked correctly! Run the following:
1. Activate the virual environment: ```. .venv/bin/activate```
2. Run the flow:  ```python scripts/run_design.py designs/basic/add4/ xilinx_conformal_impl```

## Project Structure
The project makes extensive use of the ninja_build_tool and chevron python package to accomplish the following:
* It takes advantage of the ninja build tool to automatically handle job creation, up-to-date checking of dependencies, parallel processing, and io redirection. 
* It uses chevron, the python implementation of the mustache templating engine to template the scripts used for common operations such as synthesis and implementation of designs.
* It provides unit tests that can be run with `python -m unittest`. These largely serve as a sanity check for new developers on the project, and should help to maintain minimum requirements around the implementation of new flows.

For additional information about creating your own flows using ninja and chevron, see [the project structure page](project_structure.md).
