foreach name $argv {
open_checkpoint "$name.dcp"
dump [open "$name.dump" w]
close_design
}
