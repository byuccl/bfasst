#!/bin/bash -x

set -e #exit on error

python scripts/run.py rand_soc --flow_arguments="{'num_designs': 3}"
python scripts/run.py vivado_bit_analysis designs/basic/and3
python scripts/run.py vivado_conformal designs/basic/and3
python scripts/run.py vivado_ooc designs/basic/and3
python scripts/run.py vivado_phys_netlist_cmp designs/basic/and3
python scripts/run.py vivado_phys_netlist designs/basic/and3
python scripts/run.py vivado_structural_error_injection designs/basic/and3 --flow_arguments="{'num_runs': 5}"
python scripts/run.py vivado_yosys_impl designs/basic/and3
python scripts/run.py vivado designs/basic/and3