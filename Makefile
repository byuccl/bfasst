VIVADO_PATH := "/tools/Xilinx/Vivado/2021.1/bin/vivado"
IN_ENV = if [ -e .venv/bin/activate ]; then . .venv/bin/activate; fi;
CAPNPJ := $(shell which capnpc-java)
PYTHON311 := $(shell which python3.11)

PUBLIC_SUBMODULES = \
	third_party/fasm2bels \
	third_party/RapidWright \
	third_party/yosys \
	third_party/WaFoVe

PRIVATE_SUBMODULES = \
	third_party/gmt_tools \
	third_party/encrypted_ip

include external_tools.mk

install: submodules venv python_packages rapidwright env install_fasm2bels install_yosys install_wafove

venv:
ifneq "$(PYTHON311)" ""
	python3.11 -m venv .venv
else
	python3.10 -m venv .venv
endif
	$(IN_ENV) python -m pip install -U pip

packages:
	apt-get update
	apt-get install -y \
		bison \
		build-essential \
		capnproto \
		clang \
		default-jre-headless \
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
		libncurses5 \
		libreadline-dev \
		libstdc++-12-dev \
		ninja-build \
		openjdk-18-jdk \
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
		zlib1g-dev \
	
python_packages:
	$(IN_ENV) python -m pip install -r requirements.txt
	$(IN_ENV) python -m pip install -e .
	if [ -f third_party/gmt_tools/requirements.txt ]; then \
		$(IN_ENV) cd third_party/gmt_tools && python -m pip install -r requirements.txt; \
	fi

capnproto_java:
ifeq "$(CAPNPJ)" ""
	$(eval TEMP_DIR := $(shell mktemp -d))
	cd $(TEMP_DIR) && git clone https://github.com/capnproto/capnproto-java
	cd $(TEMP_DIR)/capnproto-java && make
	cd $(TEMP_DIR)/capnproto-java && make install
	rm -rf $(TEMP_DIR)
endif

submodules:
	$(foreach submodule,$(PUBLIC_SUBMODULES),git submodule init $(submodule); git submodule update $(submodule);)
	$(foreach submodule,$(PRIVATE_SUBMODULES),git submodule init $(submodule); git submodule update $(submodule) || echo "Ignoring failed clone of private submodule ($(submodule))";)


env: venv python_packages 
	echo >> ".venv/bin/activate"
	echo "export VIVADO_PATH=$(VIVADO_PATH)" >> ".venv/bin/activate"
	echo "unset VIVADO_PATH" > ".venv/bin/deactivate"
	echo "export PYTHONNOUSERSITE=1" >> ".venv/bin/activate"
	echo "unset PYTHONNOUSERSITE" >> ".venv/bin/deactivate"


format:
	find ./scripts ./bfasst -iname "*.py" -exec black -q -l 100 {} \;


pylint: format
	git fetch
	pylint --errors-only $$(git ls-files --directory scripts --directory bfasst | grep -e ".py$$")
	pylint $$(git diff --name-only | grep -e ".py$$")


doctest:
	find bfasst -iname "*.py" -exec python -m doctest {} \;

unittest:
	$(IN_ENV) python -m unittest

unittest_failfast:
	$(IN_ENV) python -m unittest -f