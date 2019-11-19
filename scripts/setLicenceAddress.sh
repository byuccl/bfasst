# Sets up an eth0 connection with the address expected by the license file,
# modify the mac address as needed
modprobe dummy
ip link set name eth0 dev dummy0
ifconfig eth0 hw ether d8:9e:f3:14:a0:0a
