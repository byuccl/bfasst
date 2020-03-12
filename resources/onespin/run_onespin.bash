#!/bin/bash

# This script is used to call all of the run_onespin.py scripts used in an experiment
# This is in bash because it's really easy to navigate directories and call scripts
#   in bash.

TEMP_DIR="/home/jgoeders/temp"

pushd $TEMP_DIR

for d in $(ls */ -d); do
		pushd $d
		python run_onespin.py
		popd
done

popd
