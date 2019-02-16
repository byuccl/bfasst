#! /usr/bin/env bash
# Builds designs from the ipassureance_designs directory in icemachine/examples

# Call from ipassureance_designs/ooc or /base directory.

# Call with the icemachine base directory and directory to target
# ex

# TODO: Consider adding a text file that can track compilation statuses

if [ $# != 2 ]; then
	echo "Usage: build_ipassurance.sh <target dir tree> <iCEcube2 install dir>"
	exit
fi

# enable job management
set -m

OUTFILE="out.txt"
ICECUBE2_DIR=$2
WORKDIR=$1 

# don't duplicate output file
if [ -f "$OUTFILE" ]; then

	rm $OUTFILE
fi

build_design () {

	d=$1

	echo "building $d"
	local proj_name=$(echo $d | cut -d '.' -f 1)
	echo "Got design name $proj_name"

	# remove the build directory if its there
	if [ -d "${WORKDIR}/${d}/build" ]; then
		rm -rf "${WORKDIR}/${d}/build"
	fi

	# Adam's OOC directory
	#OOC_DIR="${WORKDIR}/${d}"
	local OOC_DIR="${WORKDIR}${d}"

	# directory for iCEcube
	local PRJ_DIR="${OOC_DIR}/build"

	# make design directory
	mkdir $PRJ_DIR
	echo $WORKDIR
	echo $PRJ_DIR

	# gather RTL sources 
	bash gather_sources $OOC_DIR
	srcs=$(cat "${OOC_DIR}/source_list")

	# appy syn_preserve to sources
	python constrainOptimizer.py $srcs

	# set up the .prj file
	echo "Creating .prj file"
	local synlog=$proj_name"_syn.log"
	python3 createPrjFile.py -s "$srcs" -o "$PRJ_DIR/$proj_name.prj" -n "$proj_name"

	# synthesize design with Synplify Pro
	echo "Starting Synthesis"
	source synp_config.sh $ICECUBE2_DIR
	$ICECUBE2_DIR/sbt_backend/bin/linux/opt/synpwrap/synpwrap -prj "$PRJ_DIR/$proj_name.prj" -log "${PRJ_DIR}/${synlog}"

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
	local impl_dir="${PRJ_DIR}/${proj_name}_Implmnt/"
	local topmod=$(head -n 1 "${impl_dir}/${proj_name}.edf" | cut -d " " -f 2)
	local result=$(tclsh run_backend.tcl $proj_name $PRJ_DIR "iCE40HX8K-CT256" $topmod $ICECUBE2_DIR | tail -1)
	
	# report successes
	if [[ $result != *"failed"* ]]; then
		echo $d >> $OUTFILE
	fi

}

for d in $( ls $WORKDIR ); do
	build_design $d &
done

# wait for parallel jobs to finish
while [ 1 ]; do fg 2> /dev/null; [ $? == 1 ] && break; done
