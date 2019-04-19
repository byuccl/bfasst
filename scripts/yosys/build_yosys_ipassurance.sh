#!/bin/bash

# Runs yosys on designs in the target directory, placing resulting netlists in
#   a similarly-structured output directory. This then runs the build_ipassurance
#   script on the netlisted designs to generate bitstreams from them.

if [ $# != 6 ]; then
    echo "Usage: build_yosys_ipassurance.sh <icemachine base dir> <yosys base dir> <target dir tree> <output dir tree> <iCEcube2 dir>"
    exit
fi

# The first thing we'll do is create a new directory tree we can run everything
#   in.
# We'll then create appropriate yosys scripts and use yosys to generate netlists
#   in these directories.
# Then we can call build_ipassurance.sh on this structure to have it compiled
#   by iCEcube2

ICEMACHINE_DIR=$1
SCRIPTS_DIR=$1"/scripts"
YOSYS_DIR=$2
TARG_DIR=$3
OUT_DIR=$4
ICECUBE2_DIR=$5

mkdir $OUT_DIR

for d in $( ls $TARG_DIR -d */ ); do
    echo "Running $d through Yosys"
    subdir=$TARG_DIR/$d
    proj_name=$(echo $d | cut -d '.' -f 1)
    # Create a directory in the yosys dir for this project
    yosys_proj_dir="$OUT_DIR/$proj_name"
    # Remove the directory if it already exists (for clean build)
    rm -rf $yosys_proj_dir
    echo "Made proj dir $yosys_proj_dir"
    mkdir $yosys_proj_dir

    # Gather the names of the source files
    srcs=$(find $subdir -name "*.v")
    # include the "verilog header" files
    srcs=$(printf "$srcs\n$(find $subdir -name "*.vh")")
    srcs=$(printf "$srcs\n$(find $subdir -name "*.vhd")")
    
    # If there's any VHDL files, just move on; we can't compile VHDL yet
    #if [ "$(find $subdir -name "*.vhd")" ]
    #then
#	echo "Skipping project $proj_name: cannot compile VHDL"
#	rm -rf $yosys_proj_dir
#	continue
 #   fi
    
    # Make the yosys script file
    python3 $SCRIPTS_DIR/yosys/createYosScript.py -s "$srcs" -o "$yosys_proj_dir/script.yos" -i "$SCRIPTS_DIR/yosys/example_yosys.yos"
done
    
# Loop through the created yosys directory and run yosys with the generated
#   script files
for yos_d in $( ls $OUT_DIR ); do
    cd $OUT_DIR/$yos_d
    echo "Synthesizing design $OUT_DIR/$yos_d"
    $YOSYS_DIR/yosys -m vhdl -s script.yos -q -l yosys.log
done

# Now call the normal build_ipassurance script on the yosys dir tree
bash $SCRIPTS_DIR/iCEcube2/build_ipassurance.sh $ICEMACHINE_DIR $OUT_DIR $ICECUBE2_DIR

