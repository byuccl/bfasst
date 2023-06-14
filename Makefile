VIVADO_PATH := "/tools/Xilinx/Vivado/2022.2/bin/vivado"
IN_ENV = if [ -e .venv/bin/activate ]; then . .venv/bin/activate; fi;
CAPNPJ := $(shell which capnpc-java)

install: submodules venv python_packages rapidwright env install_fasm2bels install_yosys install_wafove

venv:
	python3 -m venv .venv
	$(IN_ENV) python3 -m pip install -U pip

packages:
	apt-get update
	apt-get install -y \
		python3-dev \
		python3-venv \
		python3-pip \
		virtualenv \
		libncurses5 \
		swig \
		python3-venv \
		default-jre-headless \
		uuid-dev \
		libantlr4-runtime-dev \
		openjdk-18-jdk \
		capnproto \
		libcapnp-dev \
		jq \
		iverilog \
		gtkwave \
		build-essential \
		clang \
		bison \
		flex \
		libreadline-dev \
		gawk \
		tcl-dev \
		libffi-dev \
		graphviz \
		xdot \
		pkg-config \
		libboost-system-dev \
		libboost-python-dev \
		libboost-filesystem-dev \
		zlib1g-dev
	
python_packages:
	$(IN_ENV) python3 -m pip install -r requirements.txt
	$(IN_ENV) python3 -m pip install -e .

capnproto_java:
ifeq "$(CAPNPJ)" ""
	$(eval TEMP_DIR := $(shell mktemp -d))
	cd $(TEMP_DIR) && git clone https://github.com/capnproto/capnproto-java
	cd $(TEMP_DIR)/capnproto-java && make
	cd $(TEMP_DIR)/capnproto-java && make install
	rm -rf $(TEMP_DIR)
endif

submodules:
	git submodule update --init --recursive

rapidwright: submodules
	cd third_party/RapidWright && ./gradlew compileJava
	cd third_party/RapidWright/interchange/ && make
	$(IN_ENV) cd third_party/RapidWright ; export PATH=`pwd`/bin:$$PATH ; \
	rapidwright jython -c 'FileTools.ensureDataFilesAreStaticInstallFriendly("xc7a200t")'

install_fasm2bels: submodules
	$(IN_ENV) cd third_party/fasm2bels && make env
	$(IN_ENV) cd third_party/fasm2bels && make build
	$(IN_ENV) cd third_party/fasm2bels && make test-py

# Run a simple design through fasm2bels to generate the database.
	$(IN_ENV) python scripts/run_design.py designs/basic/and3/ xilinx_and_reversed

install_wafove: submodules
	$(IN_ENV) python3 -m pip install -e third_party/WaFoVe
	$(IN_ENV) cd third_party/WaFoVe && make build

env: venv rapidwright 
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
	pylint $$(git diff --name-only $$(git merge-base origin/main HEAD) | grep -e ".py$$")


doctest:
	find bfasst -iname "*.py" -exec python -m doctest {} \;
