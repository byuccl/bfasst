# read_verilog and3_compare.v
# read_verilog cells_sim.v
# opt_clean purge
# equiv_make and3 top equiv
# hierarchy -top equiv
# clean -purge; show
# equiv_simple
# equiv_status -assert
