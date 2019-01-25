read library -Both -Replace  -sensitive    -Verilog /auto/fsh/crg3710/research/lattice_libraries/sb_ice_syn.v -nooptimize   
read library -Both -Append  -sensitive    -Verilog /auto/fsh/crg3710/research/lattice_libraries/sb_ice_lc.v -nooptimize   
read design /auto/fsh/crg3710/research/bcd_adder/bcd_adder_sbt.v -Verilog -Golden   -sensitive         -continuousassignment Bidirectional   -nokeep_unreach   -nosupply 
read design /auto/fsh/crg3710/research/bcd_adder/bcd_adder_extracted.v -Verilog -Revised   -sensitive         -continuousassignment Bidirectional   -nokeep_unreach   -nosupply 
report black box
set mapping method -name guide
set system mode lec
add compared points -all
compare
