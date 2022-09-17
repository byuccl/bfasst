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

## Install

* Clone this github repository. 
* Install necessary packages:
  * ```make packages```
* Install the Python virtual environment, activate, and install packages:
  * ```make venv```
  * ```. .venv/bin/activate```
  * ```pip install -r requirements.txt```

BFASST can be used to compose different CAD flows from severals tools.  You may want to install these tools:

### Vivado

1. Install Vivado
1. Update _scripts/bfasst/config.py_ and make sure the path points to your Vivado installation. 

### Fasm2Bels
1. Install capnproto_java:
    * ```make capnproto_java```
1. Install Rapidwright
   * ```make rapidwright```
   * ```make env```
   * ```. ./env.sh```
1. Install fasm2bels
   * ```make install_fasm2bels```

### Yosys
1. Install Yosys
    * ```make install_yosys```

### Conformal
The conformal plugin is currently designed to run conformal on a remote machine (CAEDM machine at BYU).
  * Set up your SSH with caedm. You'll know if you set it up correctly when you can use ```ssh caedm``` and log in without having to enter your password. Follow the guide at https://byu-cpe.github.io/ComputingBootCamp/tutorials/linux/ .
  * Open _scripts/bfasst/config.py_. Change _fsj/squallz_ to your caedm login info. For instance, if you connect to caedm and enter ```pwd``` and your info is _/hij/username_, change _fsj/squallz_ to _hij/username_.


### Check Installation
Finally, test to confirm that everything worked correctly! Run the following:
1. Add rapidwright to your path: ```. ./env.sh```
1. Activate the virual environment: ```. .venv/bin/activate```
1. Run the flow: ```python scripts/run_design.py examples/basic/add4/ xilinx_conformal_impl```




