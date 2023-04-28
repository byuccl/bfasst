# BFASST Designs HTML Table (BYU FPGA Assurance Tool)

Over the course of the BFASST tools' development, it was necessary to display ongoing results of the custom FPGA CAD flows and their design experiment runs. The most up-to-date version of this table can be viewed at [this link here](https://byuccl.github.io/bfasst/) or as code in the `index.html` file.

Example designs are located in the `examples` directory.

To run an experiment of flows and update the table, source the following two bash scripts one after the other:

`run_flows.sh`

* If you want to create a new custom flow for testing, ensure the proper code is located in `scripts/bfasst/flows.py` along with an associated `.yaml` file in the `experiments` directory.
* Add your new flow to the `flows_list` variable within the main function of `scripts/run_experiment.py` (this will add a new column to the table).
* Modify the script to add the commands for running the new experiment in `run_flows.sh` before sourcing.

`update_pages.sh`

* Make sure lines 9 and 12 are modified with the branch you're working from.

After these two scripts are run and the experiment concludes, the latest version of the HTML table can be viewed in code form or at the webpage linked above.