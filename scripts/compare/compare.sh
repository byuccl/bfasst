#! /usr/bin/env bash

numArgs=5

if [ "$#" -ne $numArgs ]; then
	
	echo "Usage: bitstream rtl constraints tcl wkdir"
	exit
fi

# capture arguments
bitstream=$1 # bitstream in question
rtl=$2 # RTL code in question
constraints=$3 # design constraints file
tcl=$4 # iCEcube2 project flow
wkdir=$5 # where the user wants the results

# create subdirectory for results
mkdir $wkdir

# extract project settings file name
filename=$(basename -- "$rtl")
lse="${filename%.*}"
lse="${lse}_lse.prj"

# extract golden netlist file name
golden="${filename%.*}"
golden="${golden}_prim.v"

# move rtl into place
mkdir "${wkdir}/rtl"
mv $rtl "${wkdir}/rtl/"
rtl="rtl/${rtl}"

# make project settings file

sed "s:<RTL>:${rtl}:" template.prj > $lse

# move bitstream into place
icedir='icestorm'
mkdir "${wkdir}/${icedir}"
mv $bitstream "${wkdir}/${icedir}/"
bitstream="${icedir}/${bitstream}"

# move project project file, tcl flow, into place
dofileTemplate="template.do"
mv $lse $tcl $constraints $dofileTemplate $wkdir

# run iCEcube2 flow
cd $wkdir
lse -f $lse
tclsh $tcl

# unset LD_LIBRARY_PATH ...ugh
unset LD_LIBRARY_PATH

# unpack bitstream
asciiRep="${icedir}/unpacked_bitstream.asc"
iceunpack $bitstream > $asciiRep

# extract netlist
netlistName="verilog_netlist.v"
netlist="${icedir}/${netlistName}"
icebox_vlog -p $constraints -s $asciiRep > $netlist

# prepare do file TODO make this cleaner
dofile="flow.do"
sed "s/<GOLDEN>/${golden}/" $dofileTemplate > meta
sed "s/<REVISED>/${netlistName}/" meta > $dofile 
rm meta

# move files to caedm
remote="caedm:~"
path="research/automation"
scp $dofile "${remote}/${path}"
scp $netlist "${remote}/${path}"
scp $golden "${remote}/${path}"

# run the comparison
comparison="comparison.log"
ssh caedm "source .system && cd ${path} && lec -Dofile ${dofile} -LOGfile ${comparison} -NOGui" &> $comparison # this needs to change ...ugh

# look for the word "Equivalent"
result=$(tail -3 $comparison) 
if [[ $result == *"Equivalent"* ]]; then
	echo equivalent
else
	echo "not equivalent"
fi



