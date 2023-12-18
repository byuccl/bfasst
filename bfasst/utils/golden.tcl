proc locate {c out} {
    set ref_name [get_property ORIG_REF_NAME $c]
    set location [get_property LOC $c]
    set bel [get_property BEL $c]

    if {($ref_name == "GND") || ($ref_name=="VCC")} {
        puts $out $ref_name
        return
	}

    puts $out $location.$bel 
}

set ip [lindex $argv 0]
set f [open golden.$ip w]
foreach c [get_cells -leaf -hierarchical -filter {IS_PRIMITIVE && PRIMITIVE_LEVEL != "MACRO"} $ip] {
	locate $c $f
}
