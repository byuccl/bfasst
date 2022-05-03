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

**How to Install BFASST** 

* Clone the github repository into your home directory in linux. Repository is found at https://github.com/byuccl/bfasst. Use ```git clone https://github.com/byuccl/bfasst.git.``` (Note: if Git is not installed on your device, use ```sudo apt install git``` first.) 

* Confirm that the version of Vivado in _/bfasst/scripts/bfasst/config.py_ is the version installed on your computer. If not, change it to the version you have.

* Use ```make capnproto_java``` 

* Use ```make rapidwright```

* Use ```make env```

* Use ```source env.sh```

* Use ```make install``` 

* Use ```ssh caedm```. From the home directory of your caedm, use ```mkdir bfasst_libs && mkdir bfasst_libs/xilinx && touch bfasst_libs/xilinx/cells_sim.v```

* From the home directory of your caedm, use ```mkdir bfasst_work && touch bfasst_work/compare.do```


Finally, test to confirm that everything worked correctly! Run ```source env.sh``` and ```./scripts/run_experiment.py experiments/verify_fasm_to_bels.yaml``` from the bfasst directory to check if everything works correctly.

**For those using CAEDM Servers**
* Set up your SSH with caedm. You'll know if you set it up correctly when you can use ```ssh caedm``` and log in without having to enter your password. Follow the guide at https://byu-cpe.github.io/ComputingBootCamp/tutorials/linux/ .

* Open _scripts/bfasst/config.py_. Change _fsj/squallz_ to your caedm login info. For instance, if you connect to caedm and enter ```pwd``` and your info is _/hij/username_, change _fsj/squallz_ to _hij/username_.



