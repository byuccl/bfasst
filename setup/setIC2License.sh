# Sets up an eth0 connection with the address expected by the license file,
# modify the mac address as needed

# modprobe dummy
# ip link set name eth0 dev dummy0
# ifconfig eth0 hw ether d8:9e:f3:14:a0:0a


# New method for Ubuntu 18
sudo modprobe dummy
sudo ip link add eth0 type dummy
sudo ifconfig eth0 hw ether 54:bf:64:5f:81:d3
cp /opt/lscc/iCEcube2.2017.08/license.dat ~/Downloads/