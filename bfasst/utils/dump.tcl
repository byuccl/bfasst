proc get_ips {} {
	set ips {}
	foreach path [get_cells -hierarchical -regex {[^/]*/[^/]*}] {
		set ip [lindex [split $path /] 1]
		puts $ip
		if [regex {[IO]BUFT?} $ip] {continue}
		lappend ips $ip
	}
	return $ips
}

proc ip {c out} {
	if { $c == "" } {
		puts -nonewline $out "\"\" "
		return
	}
	set ip [lindex [split [get_property NAME $c] /] 1]
	puts -nonewline $out "\""
	if {! [regex {[IO]BUFT?} $ip]} {
		puts -nonewline $out $ip
	}
	puts -nonewline $out "\" "
}

proc property {b p prefix out} {
	if {[string first "CONFIG." $p] == -1} { return }
	if {[string first ".VALUES" $p] != -1} { return }
	if {[string last ".DEFAULT" $p] != -1} { return }

	set val [get_property $p $b]
	puts -nonewline $out "\"$prefix$p:$val\" "
}
	
proc common_properties {b out} {

	foreach p [list_property $b] {
		property $b $p "" $out
	}
}

proc match {c ref b type} {
	return [expr \
		{[regexp $ref [get_property ORIG_REF_NAME $c]] \
		&& [regexp $type [get_property TYPE $b]]}]
}

proc special_properties {c b out} {
	set specials {
		{"FDRE" "REG_INIT"} {FFINIT FFSR SYNC_ATTR}
		{"RAM.32" "LUT_OR_MEM."} {RAMMODE}
		{"SRL16E" "LUT_OR_MEM."} {RAMMODE}
		{"LUT.*" "LUT_OR_MEM."} {EQN}}

	foreach {pattern props} $specials {
		if {![match $c [lindex $pattern 0] $b [lindex $pattern 1]]} { continue }
		foreach p $props {
			property $b CONFIG.$p "" $out
		}
		return 1
	}
	return 0
}

proc properties {c b out} {
	if { $b == ""} { return }
	if { $c == "" } {
		common_properties $b $out
		return
	}

	# if {[special_properties $c $b $out]} { return }
	common_properties $b $out
}

proc locate {b out} {
	puts -nonewline $out "\"$b\" " 
}

proc bel {c b out} {
	puts -nonewline $out "("
	if $::tree {
		set parent [get_property PARENT $c]
		puts -nonewline $out "\"/$parent/$c\" "
	}

	locate $b $out
	set name [lindex [split $b "/"] 1]
	puts -nonewline $out "\"$name\" "
	ip $c $out

	properties $c $b $out
	puts $out ")"
}

proc cell {c out} {
 	set ref_name [get_property ORIG_REF_NAME $c]
 	if {($ref_name == "GND") || ($ref_name=="VCC")} {
		puts $out "(\"$ref_name\" \"$ref_name\")"
		return
	}
	foreach b [get_bels -of_objects $c] {
		bel $c $b $out
	}
}

proc bels {out} {
	set bs [get_bels -filter {IS_USED}]
	puts -nonewline $out "("
	foreach b $bs {
		set c [get_cell -of_object $b]
		bel $c $b $out
	}
	puts $out ")"
}

proc pin {p out} {
        set belname [string range $p 0 [expr [string last "/" $p] - 1]]
	set b [get_bels $belname]
	set c [get_cells -of_objects $b]
	if {$c == ""} {
		locate $b $out
		return
	}
  	set ref_name [get_property ORIG_REF_NAME $c]
 	if {($ref_name == "GND") || ($ref_name=="VCC")} {
		puts -nonewline $out "\"$ref_name\" "
		return
	}
	locate $b $out
 
}

proc net {n out} {
	set pso [get_bel_pins -filter {DIRECTION == OUT} -of_objects $n]
	set psi [get_bel_pins -filter {DIRECTION == IN} -of_objects $n]

	if {$pso == "" || $psi == ""} { return }

	if {[llength $pso] > 1} {error "net is multiply driven"}

	foreach pi $psi {
		puts -nonewline $out "("
		pin $pso $out
		pin $pi $out
		puts $out ")"
	}
}

proc nets {out} {
	puts -nonewline $out "("

	foreach n [get_nets -hierarchical -segments -top_net_of_hierarchical_group ] {
		net $n $out
	}

	puts $out ")"
}

proc dump {out} {
	bels $out
	nets $out
}
