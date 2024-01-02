#!/bin/bash -x

set -e #exit on error

python scripts/run.py RandSocDumped --flow_arguments="{'num_designs': 1}"
python scripts/run.py RandSoc --flow_arguments="{'num_designs': 1}"
python scripts/run.py Vivado designs/basic/and3
python scripts/run.py VivadoBitToNetlist designs/basic/and3
python scripts/run.py VivadoBitAnalysis designs/basic/and3
python scripts/run.py VivadoConformal designs/basic/and3
python scripts/run.py VivadoOoc designs/basic/and3
python scripts/run.py VivadoPhysNetlist designs/basic/and3
python scripts/run.py VivadoPhysNetlistCmp designs/basic/and3
python scripts/run.py VivadoStructuralErrorInjection designs/basic/and3 --flow_arguments="{'num_runs': 5}"
python scripts/run.py VivadoYosysImpl designs/basic/and3