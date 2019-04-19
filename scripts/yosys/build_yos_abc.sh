#!/bin/bash

# Runs yosys and ABC on designs in the target directory, placing resulting
#   netlists in a similarly-structured output directory. This then runs the
#   build_ipassurance script on the netlisted designs to generate bitstreams
#   from them.

if [ $# != 5 ]; then
		echo "Got $# args"
    echo "Usage: build_yos_abc.sh <icemachine base dir> <yosys base dir> <target dir tree> <output dir tree> <iCEcube2 dir>"
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

# The mips_16 does appear to compile (it isn't hanging completely), but
#   it is really slow. Consider removing from blacklist later
#   Ditto with sha3_low_throughput
blacklist="ooc_aes128 ooc_des3_perf ooc_fm_3d_core ooc_mips_16 ooc_sha3_high_throughput ooc_sha3_low_throughput"

for d in $( ls $TARG_DIR ); do
    echo "Running $d through Yosys"
		if [[ $blacklist =~ $d ]]; then
				echo "Skipping $d"
				continue
		fi
		
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
    python3 $SCRIPTS_DIR/yosys/createYosScript.py -s "$srcs" -o "$yosys_proj_dir/script.yos"  -i "$SCRIPTS_DIR/yosys/ex_yos_abc_1.yos"
		# Also copy the other needed scripts to the right directory
		cp $SCRIPTS_DIR/yosys/ex_yos_abc_2.yos $yosys_proj_dir/script2.yos
		cp $SCRIPTS_DIR/yosys/ex_abc.abc $yosys_proj_dir/script.abc
done
    
# Loop through the created yosys directory and run yosys with the generated
#   script files
for yos_d in $( ls $OUT_DIR ); do
    cd $OUT_DIR/$yos_d
    echo "Synthesizing design $OUT_DIR/$yos_d"
		echo "Starting synth at time $(date)"
    $YOSYS_DIR/yosys -m vhdl -s script.yos -l yosys.log
		
		yos_exit_stat=$?
		if [ $yos_exit_stat != 0 ]; then
				echo "Yosys exit status is nonzero, skipping the rest of this step"
				continue
		fi
		
		echo "Calling ABC"
		$YOSYS_DIR/yosys-abc -f script.abc
		echo "Adding clock to ABC output"
		python3 $SCRIPTS_DIR/yosys/add_blif_clock.py yosys_out.blif abc_out.blif
		echo "Using Yosys to write verilog"
		$YOSYS_DIR/yosys -s script2.yos -q -l yosys.log.tmp
		# Just put the yosys logs together
		cat yosys.log.tmp >> yosys.log
		rm yosys.log.tmp
done

# Now call the normal build_ipassurance script on the yosys dir tree
bash $SCRIPTS_DIR/iCEcube2/build_ipassurance.sh $ICEMACHINE_DIR $OUT_DIR $ICECUBE2_DIR

