#!/bin/bash

# This script goes through the target dir tree and looks for iCE40 binaries
#   (.bin files), copies them to the target dir tree, and runs the icestorm
#   flow for converting them to verilog netlists.

if [ $# != 3 ]; then
    echo "Usage: reverse_bins.sh <target dir tree> <output dir tree> <icestorm base dir>"
    exit
fi

TARG_DIR=$1
OUT_DIR=$2
ICESTORM_DIR=$3

if [ -d "$OUT_DIR" ]; then
		rm -r $OUT_DIR
fi
mkdir $OUT_DIR

find $TARG_DIR -name "*.bin" -exec cp {} $OUT_DIR \;

for bin in $( ls $OUT_DIR ); do
		# Try to figure out the project name from this
		proj_name=$(echo $bin | rev | cut -d '_' -f 2- | rev)
		echo $proj_name

		# make a directory and move related stuff into it
		mkdir $OUT_DIR/$proj_name
		mv $OUT_DIR/$bin $OUT_DIR/$proj_name
		# Also grab the .pcf file from the build directory
		pcf_file="${proj_name}_sbt.pcf"
		echo $pcf_file
		find $TARG_DIR -name $pcf_file -exec cp {} $OUT_DIR/$proj_name \;

		# Copy the original .v file here so we can easily export and compare them
		find $TARG_DIR -wholename "*$proj_name*yosys_out.v" -exec cp {} $OUT_DIR/$proj_name \;

		pushd $OUT_DIR/$proj_name

		# Start by sanitizing the pcf file. icecube adds a lot of junk that isn't
		#   needed for what we're doing, as well as modifies signal names
		grep "set_io" $pcf_file | sed s/_ibuf//g | sed s/ibuf_//g | sed s/_obuf//g | sed s/obuf_//g | sed s/_gb_io//g > new_pcf.pcf

		# Make the asc file
		$ICESTORM_DIR/icepack/iceunpack $bin > $proj_name.asc

		# Make the .v file
		python3 $ICESTORM_DIR/icebox/icebox_vlog.py -s -S -P new_pcf.pcf -c $proj_name.asc > ${proj_name}_vlog.v

		popd
done

