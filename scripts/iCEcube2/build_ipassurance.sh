#! /usr/bin/env bash
# Builds designs from the ipassureance_designs directory in icemachine/examples

# Call from ipassureance_designs/ooc or /base directory.

# Call with the icemachine base directory and directory to target
# ex

# TODO: Consider adding a text file that can track compilation statuses

if [ $# != 2 ]; then
	echo "Usage: build_ipassurance.sh <target dir tree> <iCEcube2 dir>"
	exit
fi

#SCRIPTS_DIR=$1"scripts"
ICECUBE2_DIR=$2
WORKDIR=$1 


for d in $( ls $WORKDIR ); do

	echo "building $d"
	proj_name=$(echo $d | cut -d '.' -f 1)
	echo "Got design name $proj_name"

	# remove the build directory if its there
	if [ -d "${WORKDIR}/${d}/build" ]; then
		rm -rf "${WORKDIR}/${d}/build"
	fi

	# Adam's OOC directory
	#OOC_DIR="${WORKDIR}/${d}"
	OOC_DIR="${WORKDIR}${d}"

	# directory for iCEcube
	PRJ_DIR="${OOC_DIR}/build"

	# make design directory
	mkdir $PRJ_DIR
	echo $WORKDIR
	echo $PRJ_DIR

	# gather RTL sources
	srcs=$( find $OOC_DIR -name "*.v" )
	srcs=$( printf "$srcs\n$( find $OOC_DIR -name "*.vhd" )" )

	# set up the .prj file
	echo "Creating .prj file"
	synlog=$proj_name"_syn.log"
	#python3 $SCRIPTS_DIR/iCEcube2/createPrjFile.py -s "$srcs" -o "$PRJ_DIR/$proj_name.prj" -n "$proj_name"
	python3 createPrjFile.py -s "$srcs" -o "$PRJ_DIR/$proj_name.prj" -n "$proj_name"

	# synthesize design with Synplify Pro
	echo "Starting Synthesis"
	source synp_config.sh $ICECUBE2_DIR
	$ICECUBE2_DIR/sbt_backend/bin/linux/opt/synpwrap/synpwrap -prj "$PRJ_DIR/$proj_name.prj" -log "$PRJ_DIR/$proj_name_syn.log"

	# don't try to do implementation if we failed synthesis
	if [ $? != 0 ]; then
		echo "Synthesis failed. Aborting..."
		continue
	fi

	# implement design
	echo "Starting Implementation"
	
	# Start by setting variables that can be used by the tcl script
	# We can scrape the top-level module name from the generated edif file
	# For now we'll just use some other defaults to make this come together faster
	impl_dir="${PRJ_DIR}/${proj_name}_Implmnt/"
	topmod=$(head -n 1 "${impl_dir}/${proj_name}.edf" | cut -d " " -f 2)
	tclsh run_backend.tcl $proj_name $PRJ_DIR "iCE40HX8K-CT256" $topmod $ICECUBE2_DIR
	echo ""

done

