gunzip -c $1 | capnp convert binary:text third_party/RapidWright/interchange/fpga-interchange-schema/interchange/LogicalNetlist.capnp Netlist > "${1%.*}.txt"
