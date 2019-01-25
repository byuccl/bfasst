read library -Both -Replace  -sensitive    -Verilog /auto/fsh/crg3710/research/lattice_libraries/sb_ice_syn.v -nooptimize   
read library -Both -Append  -sensitive    -Verilog /auto/fsh/crg3710/research/lattice_libraries/sb_ice_lc.v -nooptimize   
read design /auto/fsh/crg3710/research/big_counter/big_counter_sbt.v -Verilog -Golden   -sensitive         -continuousassignment Bidirectional   -nokeep_unreach   -nosupply 
read design /auto/fsh/crg3710/research/big_counter/big_counter_extracted.v -Verilog -Revised   -sensitive         -continuousassignment Bidirectional   -nokeep_unreach   -nosupply 
set mapping method -name guide
set system mode lec
add compared points -all
compare
