apt-get update

# Install Ubuntu 22.04 packages
if [ "$(lsb_release -rs)" = "22.04" ]; then
    apt-get install -y \
        libelf-dev:i386 \
        libncurses5 \
        openjdk-18-jdk
# Install Ubuntu 24.04 packages
elif [ "$(lsb_release -rs)" = "24.04" ]; then
    apt-get install -y \
        libncurses6 \
        openjdk-17-jdk
    dpkg --add-architecture i386
fi

# Install common packages
apt-get install -y \
    bison \
    build-essential \
    capnproto \
    clang \
    flex \
    gawk \
    graphviz \
    gtkwave \
    iverilog \
    jq \
    libantlr4-runtime-dev \
    libboost-filesystem-dev \
    libboost-python-dev \
    libboost-system-dev \
    libc++-dev \
    libcapnp-dev \
    libffi-dev \
    libftdi-dev \
    libreadline-dev \
    libstdc++-12-dev \
    ninja-build \
    pkg-config \
    python3-dev \
    python3-pip \
    python3-venv \
    python3-venv \
    swig \
    tcl-dev \
    uuid-dev \
    virtualenv \
    xdot \
    zlib1g-dev

# Install Opentitan Packages
opentitan_commit=$(git ls-tree HEAD designs/opentitan | awk '{print $3}')
curl https://raw.githubusercontent.com/lowRISC/opentitan/${opentitan_commit}/apt-requirements.txt | sed '/^#/d' | sed '/^python/d' | xargs sudo apt install -y