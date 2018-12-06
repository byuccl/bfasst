# /usr/bin/env bash

numArgs=2

if [ "$#" -ne $numArgs ]; then
	
	echo "usage: rtl constraints (top module must match rtl file name"
	exit
fi

# capture arguments
rtl=$1 # RTL code in question
constraints=$2 # design constraints file

# create subdirectory for results
designName=$(basename -- "$rtl")
designName="${designName%.*}"

if [ -d "$designName" ]; then

	echo "${designName} directory already exists"
	exit -1
fi

mkdir $designName

# extract project settings and netlist file names
lse="${designName}_lse.prj"
golden="${designName}_prim.v"

# move rtl into place
mkdir "${designName}/rtl"
cp $rtl "${designName}/rtl/"

# make project settings file and move into directory
projectRtl="rtl/${rtl}"
projectDir="$(pwd)/${designName}"
lseOutDir="lse"
sed "s:<RTL>:${projectRtl}:; s:<WKDIR>:${projectDir}:; s:<EDIF>:${lseOutDir}/${designName}.edf:; s:<LOG>:${lseOutDir}/${designName}.log:;" template.prj > $lse
mv $lse $designName

# move tcl flow and constraints into place
tcl="flow.tcl"
if [ ! -f "$tcl" ]; then
	
	echo "missing ${tcl}"
	exit -1
fi

cp $tcl $constraints $designName

# set up iCEcube2 project
cd $designName
lse -f $lse

# run iCEcube2 flow
toolOptions=":edifparser -y ${constraints}"
tclsh $tcl $designName $lseOutDir $toolOptions
	
# make dofile

# make directory for icestorm and copy bitstream
icedir="icestorm"
bitstream="${designName}_bitmap.bin"
mkdir $icedir
cp "${lseOutDir}/sbt/outputs/bitmap/${bitstream}" $icedir

# unset LD_LIBRARY_PATH ...ugh
unset LD_LIBRARY_PATH

# unpack bitstream
asciiRep="${icedir}/unpacked_bitstream.asc"
iceunpack "${icedir}/${bitstream}" > $asciiRep

# extract netlist
netlistName="verilog_netlist.v"
netlist="${icedir}/${netlistName}"
icebox_vlog -p $constraints -s $asciiRep > $netlist

# prepare do file
dofile="flow.do"
golden="${designName}_prim.v"
sed "s:<GOLDEN>:${golden}:; s:<REVISED>:${netlistName}:;" "../template.do" > $dofile

## move files to caedm
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
#
#
#
