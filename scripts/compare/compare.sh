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

# prepare do file 
netlistName="verilog_netlist.v" #TODO refactor
dofile="flow.do"
sed "s:<GOLDEN>:${golden}:" 'template.do' > meta
sed "s:<REVISED>:${netlistName}:" meta > $dofile 
rm meta

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
mv $lse $tcl $constraints $dofile $wkdir
cd $wkdir

# run iCEcube2 flow
lse -f $lse
tclsh $tcl

# unset LD_LIBRARY_PATH ...ugh
unset LD_LIBRARY_PATH

# unpack bitstream
asciiRep="${icedir}/unpacked_bitstream.asc"
iceunpack $bitstream > $asciiRep

# extract netlist
netlist="${icedir}/${netlistName}"
icebox_vlog -p $constraints -s $asciiRep > $netlist

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



