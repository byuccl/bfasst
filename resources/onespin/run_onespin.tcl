load_settings ec_fpga
read_verilog -revised -cell -library ice /home/jgoeders/bfasst_tss/sb_ice_syn.v
read_verilog -golden -cell -library ice /home/jgoeders/bfasst_tss/sb_ice_syn.v

# Read golden here
# read_verilog -golden -pragma_ignore {} -version 2001 {/home/jgoeders/temp/wb_lcd/wb_lcd_yosys_tech.v}

# Read revised here
# read_verilog -revised -pragma_ignore {} -version 2001 {/home/jgoeders/temp/wb_lcd/wb_lcd_reversed.v}

# Set top module in elaborate options
# set_elaborate_option -golden -top {Verilog!work.wb_lcd}

elaborate -both
set_compile_option -both -dontcare_handling any
compile -both
set_mode ec
map
reset_initial_state -both hdl
compute_initial_state
compare

# Save results
# save_result_file /home/jgoeders/temp/wb_lcd/results.log
