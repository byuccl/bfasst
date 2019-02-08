#!/bin/bash
# Builds designs from a target directory tree in icemachine/examples

# Call with the icemachine base directory and directory to target
# ex: build_ipassurance.sh ~/icemachine ~/icemachine/examples/oop ~/iCEcube2

# TODO: Consider adding a text file that can track compilation statuses
#       and a way to extract desired build outputs (netlists, bitstreams, etc)

ICECUBE2_DIR=$HOME/lscc/iCEcube2.2017.08/

if [ $# != 3 ]; then
    echo "Usage: build_ipassurance.sh <icemachine base dir> <target dir tree> <iCEcube2 dir>"
    exit
fi

SCRIPTS_DIR=$1"/scripts/"
ICECUBE2_DIR=$3
cd $2

for d in $( ls ); do
    echo "building $d"
    cd $d
    proj_name=$(echo $d | cut -d '.' -f 1)
    echo "Got project name $proj_name"
    # Remove the build directory if its there
    if [ $(ls | grep "build") == "build" ]; then
	rm -rf build
    fi
    mkdir build
    srcs=$( find -name "*.v" -exec echo ".{}" \;)
    srcs=$(printf "$srcs\n$( find -name "*.vhd" -exec echo ".{}" \;)")
    cd build
    # Try to set up the prj file
    echo "Creating .prj file"
    synlog=$proj_name"_syn.log"
    python3 $SCRIPTS_DIR/iCEcube2/createPrjFile.py -s "$srcs" -o "$proj_name.prj" -n "$proj_name"
    # Try running synplify pro to synthesize the project
    echo "Starting Synthesis"
    source $SCRIPTS_DIR/iCEcube2/synp_config.sh
    $ICECUBE2_DIR/sbt_backend/bin/linux/opt/synpwrap/synpwrap -prj "$proj_name.prj" -log "$proj_name_syn.log"
    echo "Exit status $?"
    # Don't try to do implementation if we failed synthesis
    if [ $? != 0 ]; then
	echo "Aborting before implementation"
	cd ../
	#rm -rf build
	cd ../
	continue
    fi

    # Now try doing implementation
    echo "Starting Implementation"
    # Start by setting variables that can be used by the tcl script
    # We can scrape the top-level module name from the generated edif file
    # For now we'll just use some other defaults to make this come together faster
    impl_dir=$proj_name"_Implmnt/"
    topmod=$(head -n 1 $impl_dir"$proj_name.edf" | cut -d " " -f 2)
    tclsh $SCRIPTS_DIR/iCEcube2/run_backend.tcl $proj_name . iCE40HX8K-CT256 $topmod $ICECUBE2_DIR
    
    cd ../
    #rm -rf build
    cd ../

    echo ""
done

