#!/usr/bin/env tclsh


# require 5 arguments
if { $argc != 3 } {

	puts "expected 3 arguments, got $argc"
	exit
}

puts "hello from cMonster"

set device [lindex $argv 0]
set top_module [lindex $argv 1]
set proj_dir [pwd]
set output_dir [lindex $argv 2]
set edif_file [lindex $argv 3]
set tool_options [lindex $argv 4]

#############################################
#Tool Interface
#############################################

set sbt_root $::env(SBT_DIR)
append sbt_tcl $sbt_root "/tcl/sbt_backend_synpl.tcl"
source $sbt_tcl

run_sbt_backend_auto $device $top_module $proj_dir $output_dir $tool_options $edif_file

exit
