
read library -Golden -Replace -sensitive -Verilog /auto/fsh/crg3710/research/lattice_libraries/sb_ice_syn.v -nooptimize

read design <GOLDEN> -Verilog -Golden -sensitive -continuousassignment Bidirectional -nokeep_unreach -nosupply

read design <REVISED> -Verilog -Revised -sensitive -continuousassignment Bidirectional -nokeep_unreach -nosupply

set system mode lec

add compared points -all

compare

exit -Force


