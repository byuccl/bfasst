#!/bin/sh

# Based on the instructions found at http://www.clifford.at/icestorm/

################################################################################
# Warning for installation location
################################################################################
echo "This will install the IceStorm tools in this directory ($(dirname "$0"))."
echo "If this is not what you want, press Ctrl-C now."
read -r _ >> /dev/null

################################################################################
# Determine OS platform
################################################################################
# https://askubuntu.com/a/459425
UNAME=$(uname | tr "[:upper:]" "[:lower:]")
# If Linux, try to determine specific distribution
if [ "$UNAME" = "linux" ]; then
    if [ -f /etc/lsb-release ] || [ -d /etc/lsb-release.d ]; then
        # If available, use LSB to identify distribution
        DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
    else
        # Otherwise, use release info file
        DISTRO=$(echo /etc/[A-Za-z]*[_-][rv]e[lr]*/ \
                     | grep -v "lsb" \
                     | cut -d'/' -f3 \
                     | cut -d'-' -f1 \
                     | cut -d'_' -f1)
    fi
fi
# For everything else (or if above failed), just use generic identifier
[ "$DISTRO" = "" ] && export DISTRO="$UNAME"
unset UNAME

################################################################################
# Install prerequisites depending on platform
################################################################################
if [ "$DISTRO" = "Ubuntu" ]; then
    sudo apt-get install build-essential clang bison flex libreadline-dev \
         gawk tcl-dev libffi-dev git mercurial graphviz   \
         xdot pkg-config python python3 libftdi-dev
elif [ "$DISTRO" = "Fedora" ]; then
    sudo dnf install make automake gcc gcc-c++ kernel-devel clang bison \
         flex readline-devel gawk tcl-devel libffi-devel git mercurial \
         graphviz python-xdot pkgconfig python python3 libftdi-devel

elif [ "$DISTRO" = "archlinux" ]; then
    # This is untested; I don't know what the result for the above script is for
    # Arch Linux
    :
else
    echo "This platform is not supported." 1>&2
    exit 1
fi

################################################################################
# Install tools depending on platform
################################################################################
# Arch Linux
if [ "$DISTRO" != "Ubuntu" ] && [ "$DISTRO" != "Fedora" ]; then
    pacman -S icestorm-git arachne-pnr-git yosys-git
    exit 0
fi

# We assume it's Ubuntu or Fedora from now on

# From "Notes for Linux"
echo 'ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="0660",' \
     'GROUP="plugdev", TAG+="uaccess"' \
    | sudo tee /etc/udev/rules.d/53-lattice-ftdi.rules >> /dev/null

echo "============ Installing IceStorm Tools ============"
echo "(icepack, icebox, iceprog, icetime, chip databases)"
(git clone https://github.com/cliffordwolf/icestorm.git icestorm \
     && cd icestorm \
     && make -j"$(nproc)" \
     && sudo make install)


echo "============ Installing Arachne-PNR ============"
echo "(the place&route tool)"
(git clone https://github.com/cseed/arachne-pnr.git arachne-pnr \
     && cd arachne-pnr \
     && make -j"$(nproc)" \
     && sudo make install)


echo "============ Installing Yosys ============"
echo "(Verilog synthesis)"
(git clone https://github.com/cliffordwolf/yosys.git yosys \
     && cd yosys \
     && make -j"$(nproc)" \
     && sudo make install)

echo "============ Installation complete ============"
