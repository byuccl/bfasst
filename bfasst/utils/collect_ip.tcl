set file [lindex $argv 0]
set ips [get_cells -hierarchical -regex {[^/]*/[^/]*}]

set fp [open $file "w"]
foreach ip $ips {
    puts $fp $ip
}
close $fp
