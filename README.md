![Pylint Status](https://github.com/byuccl/bfasst/actions/workflows/python.yml/badge.svg)
![Unittest Status](https://github.com/byuccl/bfasst/actions/workflows/unittests.yml/badge.svg)
![Weekly Test Status](https://github.com/byuccl/bfasst/actions/workflows/weeklytests.yml/badge.svg)


# BFASST (BYU FPGA Assurance Tool)

The BFASST tool is a Python package located at `bfasst/`.  The tool can be used to compose custom FPGA CAD flows.  Many of these flows are already defined and can be found in `bfasst/flows/flow_descriptions.yaml`.

Example designs are located in the `designs/` directory.

Before running any bfasst flows, always make sure you have activated the BFASST environment:
```. .venv/bin/activate``` (ran in the bfasst root directory).

To run bfasst, use `bfasst` as follows:

```
Usage: 
  bfasst [-h] [--flow_arguments FLOW_ARGUMENTS] flow_name_or_yaml_path [design ...]

positional arguments:
  flow_name_or_yaml_path              Name of the desired flow or path to a yaml file with a list of designs and the flow.
  design                              Design(s) to run the flow on (e.g. byu/alu byu/counter byu/uart to run all three designs through the flow)

options:
  -h, --help                          Show this help message and exit
  --flow_arguments FLOW_ARGUMENTS     Arguments to pass to the flow, as python dict (e.g. "{'num_runs': 10}" for error_injection flow)
  -j --jobs INT                       Specifies the number of jobs ninja can run in parallel
```

Note that if a yaml file is specified, neither a design nor flow should be specified. Flow arguments and the jobs argument are optional; flows will always run with valid default arguments.

## Install
### Prerequisites
* Install Vivado. Currently, flows should be supported with Vivado version 2025.1, although 2022 releases and onward have been extensively used, they may not have been tested with the latest bfasst iteration.
* Clone this github repository. 
* Install necessary packages:
  * ```sudo make packages```
* Install Capnproto Java
  * ```sudo make capnproto_java```
### Install BFASST
* Setup can be customized with the variables at the top of the [Makefile](Makefile)
* Private submodules can be enabled by removing "active=false" in .gitmodules
* External tool setup can be customized with the variables in [setup/external_tools.mk](setup/external_tools.mk). Variables are grouped with the tool recipes.
* Install the Python virtual environment\*\*, activate, and install project submodules:
  * `make install`

\*\* If you see yourself re-installing the virtual environment (unlikely unless you are debugging the installation itself), then you may want your project configurations to persist. See next section.

### Updating
* Update the project to match remote and update all installed submodules to match bfasst remote's commit versions:
  * ```git pull && make update_all_submodules```
* This script also does any necessary recompiling of submodules.

### Configure BFASST
All configuration variables for running the tools are in bfasst.env. These can be changed at any time. Warning: rerunning make recipes that regenerate the bfasst virtual environment may overwrite this file. If this is a concern, setup/env_vars.mk should be altered to maintain variable state.

Variables in bfasst.env are loaded into the shell when sourcing the virtual environment: `export BFASST_VAR=VALUE`. However, any overwritten values will be restored and new variables will be unset when the environment is deactivated. Adjust bfasst.env to your preferences. Your first check should be to confirm VIVADO correctly points to your installation.

Installing external tools through the Makefile may append additional variables without checking if they are already there. 

## Contributing
We welcome contributions. We have a [python coding standard](docs/codingstandard.md) enforced with [pylint](.pylintrc)
Optionally, activate the precommit hook to auto format and lint your python code:
  * `make enable_pre_commit_hook`
Github automatically checks formatting, docs, and pylint on pull requests. The pre-commit hook can save you from immediately failing these checks.
Pull requests also get automatically tested with the python unittests and the test files in tests/ci. Longer comprehensive tests are ran weekly. These are found in tests/weekly.

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
Rapidwright can cache data files for commonly used parts. Run `make cache_rw_part RW_PART=<part>` to do this. If you write a github action unittest with a different part, make sure to update the test caches the part, or else it may run unreliably. 

### FPGA Interchange
Interchange is installed with RapidWright and is a third-party format used to store FPGA objects in a binary, language-agnostic format. With interchange, you could create an object describing an FPGA netlist in Java, and then write a Python script that updates it, without having to worry about how to hand off between the two. The binary format means that disk utilization for the objects is reduced and there is no text parsing when reading or writing the file. Interchange uses [CapnProto](https://capnproto.org/) to facilitate this. 

With Interchange, you can represent logical and physical netlists, and available resources on FPGA devices. Object interaction is similar to C structs. The binary storage structure is useful, but sometimes for debugging a text representation can be more helpful. We have example routines that can take a [logical](scripts/print_capnp_log.sh) or [physical](scripts/print_capnp_phys.sh) interchange capnp file and output an expanded text file.

RapidWright facilitates reading and writing interchange files. This means you can use RapidWright to export Vivado .dcp files to interchange and vice versa. 

If you decide to implement a custom version of the interchange capnproto formats (by modifying the files in the RapidWright/interchange submodule ), and you want those changes to be recognized by RapidWright, then rebuild interchange with `make inject_interchange`.

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

For additional information about creating your own flows using ninja and chevron, see [the project structure page](docs/project_structure.md).
