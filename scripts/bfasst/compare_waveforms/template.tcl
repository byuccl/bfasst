create_project temp temp -part xc7a35tcpg236-1
add_files -norecurse { PATH FILE_T}
set_property top TB [get_filesets sim_1]
launch_simulation