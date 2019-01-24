#!/usr/bin/env tclsh

set numArgs 6

if { $argc != $numArgs } {

	puts "expected $numArgs arguments, got $argc"
	exit -1
}

puts "hello from cMonster"

set device iCE40HX1K-TQ144
set top_module [lindex $argv 0]
set proj_dir [pwd]
set output_dir [lindex $argv 1]
set edif_file [lindex $argv 2]
set tool_options [lindex $argv 3]

#############################################
#Tool Interface
#############################################

set sbt_root $::env(SBT_DIR)
append sbt_tcl $sbt_root "/tcl/sbt_backend_synpl.tcl"
source $sbt_tcl

run_sbt_backend_auto $device $top_module $proj_dir $output_dir $tool_options $edif_file

exit
