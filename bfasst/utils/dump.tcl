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

	# LUT6_2 returns two bels for the single cell C
	if {[llength $b] > 1} {
		foreach b $b {
			set bel_name [lindex [split $b "/"] 1]
			set bel_name [string map [list "A" "" "B" "" "C" "" "D" ""] $bel_name]

			foreach P [list_property $b] {
				property $b $P "$bel_name." $out
			}
		}
		return
	}

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

proc properties {c out} {
	set b [get_bels -of_objects $c]
	if { $b == ""} { return }

	if {[special_properties $c $b $out]} { return }
	common_properties $b $out
}

proc locate {c out} {
	set ref_name [get_property ORIG_REF_NAME $c]
	set location [get_property LOC $c]
	set bel [get_property BEL $c]

	if {($ref_name == "GND") || ($ref_name=="VCC")} {
		puts -nonewline $out "\"$ref_name\" "
		return
	}

	puts -nonewline $out "\"$location.$bel\" " 
}

proc cell {c out} {
	puts -nonewline $out "("
	if $::tree {
		set parent [get_property PARENT $c]
		puts -nonewline $out "\"/$parent\" "
	}

	locate $c $out

	set ref_name [get_property ORIG_REF_NAME $c]
	puts -nonewline $out "\"$ref_name\" "
	
	ip $c $out
	properties $c $out
	puts $out ")"
}

proc cells {out} {
	set cs [get_cells -hierarchical -filter {IS_PRIMITIVE && PRIMITIVE_LEVEL != "MACRO"}]

	# nonsensically changes the properties...
	foreach c $cs {
		catch {list_property -quiet $c }
	}

	puts -nonewline $out "("

	foreach c $cs {
		cell $c $out
	}

	puts $out ")"
}

proc pin {p out} {
	set c [get_cells -of_objects $p]
	locate $c $out
}

proc net {n out} {
	set pso [get_pins -leaf -filter {DIRECTION == OUT} -of_objects $n]
	set psi [get_pins -leaf -filter {DIRECTION == IN} -of_objects $n]

	if {[llength $pso] < 1 || [llength $psi] < 1} { return }

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
	set ::tree 0
	cells $out
	nets $out
}

proc treedump {out} {
	set ::tree 1
	cells $out
	nets $out
}