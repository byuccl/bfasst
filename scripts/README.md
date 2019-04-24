# Scripts #

## fork ##

+ runs the iCEcube2 flow with Synopsis Synplify Pro
+ Builds designs from the ipassureance_designs directory in icemachine/examples

+ Call from ipassureance_designs/ooc or /base directory.

+ Call with the icemachine base directory and directory to target
+ ```fork.sh <target dir tree> <iCEcube2 install dir>```
+ note this spins up a new process for each directory it finds
+ and takes *_FOREVER_* to run 
+ creates a file called ```out.txt``` that lists successful design runs(successfully generated a bitstream)

## extract ##

+ runs the icestorm flow (extracts the bitstreams to a Verilog netlist)
+ ```usage: extract <ooc directory> <design list> <failure file>```
+ ooc directory is root directory of all the target designs
+ the design list comes from the ```fork``` script

## gather_all_sources ##
+ Cadence Conformal *_UGH_* only runs on Red Hat.
+ This script copies all icestorm outputs to a remote host
+ ```gather_all_sources <list-of-successful-designs> <path-to-ooc-directory> <remote-host>```
+ remove any designs that failed the IceStorm flow from the list of resutls to copy to the remote host

## gendo ##
+ generates dofiles for consumption by Conformal
+ 




  


