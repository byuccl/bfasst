#!/bin/bash

DIRS=$(ls -d */)

echo $DIRS

for d in $DIRS
do
		pushd $d

		echo "Moving sources in $d"
		pwd

		if [ -d "constrs_1" ]; then
				rm -r "constrs_1"
		fi
		if [ -d "sim_1" ]; then
				rm -r "sim_1"
		fi

		# First grab the lib folder and move it up here, if it exists
		find -name "lib" -type d -exec mv {} . \;
		# Now search the rest of the sources folder and move any remaining
		#  remaining sources up here
		find "sources_1" -name "*.v" -exec mv {} . \;
		find "sources_1" -name "*.vhd" -exec mv {} . \;
		find "sources_1" -name "*.vh" -exec mv {} . \;
		
		if [ -d "sources_1" ]; then
				rm -r "sources_1"
		fi

		popd
done
