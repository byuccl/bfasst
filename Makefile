VIVADO_PATH := "/tools/Xilinx/Vivado/2024.2/bin/vivado"
IN_ENV = if [ -e .venv/bin/activate ]; then . .venv/bin/activate; fi;
CAPNPJ := $(shell which capnpc-java)
PYTHON311 := $(shell which python3.11)
PYTHON312 := $(shell which python3.12)

PUBLIC_SUBMODULES = \
	third_party/fasm2bels \
	third_party/RapidWright \
	third_party/yosys \
	third_party/WaFoVe \
	third_party/icestorm \
	third_party/rand_soc

include external_tools.mk

install: submodules venv install_cmake python_packages install_rapidwright env install_fasm2bels install_yosys install_wafove setup_autocomplete

venv:
ifneq "$(PYTHON312)" ""
	python3.12 -m venv .venv
else ifneq "$(PYTHON311)" ""
	python3.11 -m venv .venv
else
	python3.10 -m venv .venv
endif
	$(IN_ENV) python -m pip install -U pip

packages:
	./install_packages.sh
	
python_packages:
	$(IN_ENV) python -m pip install -r requirements.txt
	$(IN_ENV) python -m pip install -e .

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

setup_autocomplete:
	./scripts/setup_autocomplete.sh 
