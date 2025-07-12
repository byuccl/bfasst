gunzip -c $1 | capnp convert binary:text third_party/RapidWright/interchange/fpga-interchange-schema/interchange/PhysicalNetlist.capnp PhysNetlist > "${1%.*}.txt"
