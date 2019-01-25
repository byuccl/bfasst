read library -Both -Replace  -sensitive    -Verilog /auto/fsh/crg3710/research/lattice_libraries/sb_ice_syn.v -nooptimize   
read design /auto/fsh/crg3710/research/uart2/uart_prim.v -Verilog -Golden -Replace  -sensitive         -continuousassignment Bidirectional   -nokeep_unreach   -nosupply 
read design /auto/fsh/crg3710/research/uart2/uart_bitmap.v -Verilog -Revised   -sensitive         -continuousassignment Bidirectional   -nokeep_unreach   -nosupply 
set system mode lec
add compared points -all
compare
exit -f
