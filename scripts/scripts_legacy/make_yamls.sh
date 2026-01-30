#!/bin/bash

YAML="design.yaml"

DIRS=$(ls -d */)

for d in $DIRS; do
		pushd $d

		# Make a fresh empty yaml file
		if [ -f $YAML ]; then
				rm $YAML
		fi
		touch $YAML

		# The top file is either called top.v or testbench.vhd
		# Should we use the testbench as a top? It might not have IO...
		if [ -f "top.v" ]; then
				echo "top: top" >> $YAML
		elif [ -f "testbench.vhd" ]; then
				echo "top: testbench" >> $YAML
		fi
		echo "" >> $YAML

		# If there's library files, add a path to vhdl_libs for each subdir
		# Some libraries aren't in vhdl. Do we automatically find non-vhdl libs?
		if [ -d "lib" ]; then
				echo "vhdl_libs:" >> $YAML
				LIBDIRS=$(ls -d lib/*)
				for l_d in $LIBDIRS; do
						echo "  - $l_d" >> $YAML
				done
				echo "" >> $YAML
		fi

		# If there's vhdl files, set include_all_vhdl_files
		# Do I just do this for top-level files, or for all files?
		if $(ls *.vhd 1> /dev/null 2>&1); then
				echo "include_all_vhdl_files: True" >> $YAML
				echo "" >> $YAML
		fi

		# if there's verilog files, set include_all_verilog_files
		if $(ls *.v 1> /dev/null 2>&1); then
				echo "include_all_verilog_files: True" >> $YAML
				echo "" >> $YAML
		fi

		popd
done
