set file [lindex $::tclargs 1]
set ips [get_ips]

set fp [open $file "w"]
foreach ip $ips {
    puts $fp $ip
}
close $fp
