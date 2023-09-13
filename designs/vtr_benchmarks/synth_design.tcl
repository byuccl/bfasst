puts [lindex $argv 0]
add_files includes [lindex $argv 0]
set top_mod [find_top -files [lindex $argv 0]]
synth_design -top $top_mod -flatten_hierarchy full -quiet -part xc7a100tcsg324-1
write_edif -force vivado_tmp_edif.edif
write_verilog -force vivado_tmp_verilog.v
write_checkpoint -force vivado_tmp_checkpt.dcp
report_utilization -force -file utilization_report.txt
exit