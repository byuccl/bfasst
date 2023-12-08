VIVADO_PATH := "/tools/Xilinx/Vivado/2022.2/bin/vivado"
IN_ENV = if [ -e .venv/bin/activate ]; then . .venv/bin/activate; fi;
CAPNPJ := $(shell which capnpc-java)
PYTHON311 := $(shell which python3.11)

PUBLIC_SUBMODULES = \
	third_party/fasm2bels \
	third_party/RapidWright \
	third_party/yosys \
	third_party/WaFoVe

PRIVATE_SUBMODULES = \
	third_party/gmt_tools

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

rapidwright:
	cd third_party/RapidWright && ./gradlew compileJava
	cd third_party/RapidWright/interchange/ && make
	$(IN_ENV) cd third_party/RapidWright ; export PATH=`pwd`/bin:$$PATH ; \
	rapidwright jython -c 'FileTools.ensureDataFilesAreStaticInstallFriendly("xc7a200t")'

install_fasm2bels:
	$(IN_ENV) cd third_party/fasm2bels && make env
	$(IN_ENV) cd third_party/fasm2bels && make build
	$(IN_ENV) cd third_party/fasm2bels && make test-py

# Run a simple design through fasm2bels to generate the database.
	$(IN_ENV) python scripts/scripts_legacy/run_design.py designs/basic/and3/ xilinx_and_reversed

install_wafove:
	$(IN_ENV) python -m pip install -e third_party/WaFoVe
	$(IN_ENV) cd third_party/WaFoVe && make build

env: venv python_packages rapidwright 
	echo >> ".venv/bin/activate"
	echo "if [ -f \"`pwd`/third_party/rapidwright.sh\" ];then" >> ".venv/bin/activate" 	
	echo ". `pwd`/third_party/rapidwright.sh" >> ".venv/bin/activate"
	echo "fi" >> ".venv/bin/activate"
	echo "export INTERCHANGE_SCHEMA_PATH=`pwd`/third_party/RapidWright/interchange/fpga-interchange-schema/interchange" >> ".venv/bin/activate"
	echo "export VIVADO_PATH=$(VIVADO_PATH)" >> ".venv/bin/activate"
	echo "unset VIVADO_PATH" > ".venv/bin/deactivate"
	echo "unset INTERCHANGE_SCHEMA_PATH" >> ".venv/bin/deactivate"
	echo "export PYTHONNOUSERSITE=1" >> ".venv/bin/activate"
	echo "unset PYTHONNOUSERSITE" >> ".venv/bin/deactivate"

install_yosys:
	# Yosys
	cd third_party/yosys && make -j8


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