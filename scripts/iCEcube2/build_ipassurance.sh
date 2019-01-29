#!/bin/bash
# Builds designs from the ipassureance_designs directory in icemachine/examples

# Call from ipassureance_designs directory.

# TODO: Consider adding a text file that can track compilation statuses

SCRIPTS_DIR=../../../../../scripts
ICECUBE2_DIR=$HOME/lscc/iCEcube2.2017.08/



for d in $( ls ); do
    echo "building $d"
    cd $d
    proj_name=$(echo $d | cut -d '.' -f 1)
    echo "Got project name $proj_name"
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
done

