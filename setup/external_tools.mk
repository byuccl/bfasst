# DO NOT DIRECTLY CALL THIS FILE. Depends on vars in top level Makefile.
# When adding new tools, append PATH variable $(ACTIVATE_SCRIPT) and append environment variables to $(VENV_VARS)
# Tool location paths here, other tool varialbes group with tool recipe or in setup/tools_vars/*.env
TOOL_VARS := $($(BFASST_SETUP))/tool_vars
RAPIDWRIGHT_PATH := $(BFASST_EXTERNAL_TOOLS)/RapidWright
YOSYS_PATH := $(BFASST_EXTERNAL_TOOLS)/yosys
FASM2BELS_PATH ?= $(BFASST_EXTERNAL_TOOLS)/fasm2bels
FASM2BELS_SUBMODULE := $(BFASST_EXTERNAL_TOOLS)/fasm2bels # Actual f2b may be cached elsewhere
YOSYS_PATH := $(BFASST_EXTERNAL_TOOLS)/yosys
RAND_SOC_PATH := $(BFASST_EXTERNAL_TOOLS)/rand_soc
ICESTORM_PATH := $(BFASST_EXTERNAL_TOOLS)/icestorm
CONFORMAL_PATH := $(or $(shell command -v conformal), "conformal_is_missing")
WAFOVE_PATH := $(BFASST_EXTERNAL_TOOLS)/WaFoVe
OPENTITAN_PATH := $(BFASST_ROOT)/designs/opentitan
IC2_PATH := /tools/lscc/iCEcube2.2020.12
PUBLIC_SUBMODULES := \
	$(FASM2BELS_SUBMODULE) \
	$(RAPIDWRIGHT_PATH) \
	$(YOSYS_PATH) \
	$(WAFOVE_PATH) \
	$(ICESTORM_PATH) \
	$(RAND_SOC_PATH) 

.PHONY: all_submodules

MODULE_INIT := git submodule init
MODULE_UPDATE := git submodule update --recursive
MODULE_INIT_UPDATE := git submodule update --init --recursive
all_submodules: .gitmodules
	@$(foreach submodule,$(PUBLIC_SUBMODULES), $(MODULE_INIT) $(submodule);)
	@$(foreach submodule,$(PUBLIC_SUBMODULES), $(MODULE_UPDATE) $(submodule) &) wait

################################################################################
# Vivado
################################################################################
.PHONY: install_vivado
install_vivado: $(VIVADO_BIN)
$(VIVADO_BIN):
	@echo "Vivado is not installed by this Makefile. Please install Vivado 2025.1"
	@echo "Then, set the VIVADO_BIN variable in bfasst.env to point to the vivado binary."

################################################################################
# CMake
################################################################################
CMAKE_VERSION ?= 3.27.7
CMAKE_DIR := cmake-${CMAKE_VERSION}-linux-x86_64
CMAKE_URL := https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/$(CMAKE_DIR).tar.gz
.PHONY: install_cmake update_cmake
install_cmake: $(VENV_BIN)/cmake

update_cmake:
ifneq ($(shell cmake --version 2>/dev/null | grep $(CMAKE_VERSION)),)
	$(MAKE) -B $(VENV_BIN)/cmake
else
	@echo "CMake is already at the environment specified version ($(CMAKE_VERSION))"
endif

$(VENV_BIN)/cmake:
	curl -Ls "${CMAKE_URL}" | tar -xz --strip-components=2 -C $(VENV_BIN) $(CMAKE_DIR)/bin/

################################################################################
# Capnproto Java
################################################################################
CAPNP_JAVA := $(or $(shell command -v capnpc-java), capnpc-java)
.PHONY: capnproto_java
capnproto_java: ${CAPNP_JAVA}
# Auto rebuild capnproto-java if capnproto is updated by apt
${CAPNP_JAVA}: $(shell command -v capnproto)
	$(eval TEMP_DIR := $(shell mktemp -d))
	git clone https://github.com/capnproto/capnproto-java $(TEMP_DIR)/capnproto-java
	$(MAKE) -C $(TEMP_DIR)/capnproto-java
	$(MAKE) -C $(TEMP_DIR)/capnproto-java install || \
	  @echo "Did you run with sudo? To install to local environment, run 'PREFIX=$(VENV_DIR) make capnproto_java'""; \
	  exit 1;
	rm -rf $(TEMP_DIR)

################################################################################
# Rapidwright
################################################################################
.PHONY: install_rapidwright update_rapidwright
# Find proper Java version. Currently 18 or 17.
ifndef JAVA_HOME
  ifneq ($(shell type /usr/lib/jvm/java-18-openjdk-amd64/bin/java 2>/dev/null), "")
    JAVA_HOME := /usr/lib/jvm/java-18-openjdk-amd64
  else ifneq ($(shell type /usr/lib/jvm/java-17-openjdk-amd64/bin/java 2>/dev/null), "")
    JAVA_HOME := /usr/lib/jvm/java-17-openjdk-amd64
  endif
endif
install_rapidwright: $(RAPIDWRIGHT_PATH)/bin/rapidwright 

$(RAPIDWRIGHT_PATH)/bin/rapidwright: capnproto_java install_vivado
	@if [ -z "$(JAVA_HOME)" ]; then \
		echo "Java 17 or 18 is required to build RapidWright. Please run 'sudo make packages' to install it."; \
		exit 1; \
	fi
	$(MODULE_INIT_UPDATE) $(RAPIDWRIGHT_PATH)
	echo "\n# RapidWright Environment Variables" >> $(VENV_VARS)
	echo "RAPIDWRIGHT_PATH=$(RAPIDWRIGHT_PATH)" >> $(VENV_VARS)
	cat $(TOOL_VARS)/rapidwright.env >> $(VENV_VARS)
	echo "JAVA_HOME=$(JAVA_HOME)" >> $(VENV_VARS)
	echo "\n# Make sure the correct java binary is available for RapidWright">	".venv/bin/activate"
	echo "export PATH=$(JAVA_HOME)/bin:$$PATH" >> ".venv/bin/activate"
	cd $(RAPIDWRIGHT_PATH) && ./gradlew compileJava
	$(MAKE) -C $(RAPIDWRIGHT_PATH)/interchange/ 
	echo "\n# Add RapidWright binaries to PATH" >> ".venv/bin/activate"
	echo "export PATH=$(RAPIDWRIGHT_PATH)/bin:$$PATH" >> ".venv/bin/activate"
	cd $(RAPIDWRIGHT_PATH); rapidwright jython -c 'FileTools.ensureDataFilesAreStaticInstallFriendly("xc7a200t")'

update_rapidwright:
	git submodule update --remote third_party/RapidWright
	./gradlew updateJars
	./gradlew compileJava


################################################################################
# Fasm2bels
################################################################################
.PHONY: install_fasm2bels init_f2b_db
install_fasm2bels: $(FASM2BELS_PATH)/fasm2bels_commit.txt init_f2b_db

FASM2BELS_COMMIT := $(shell git submodule status third_party/fasm2bels/ | awk '{print $1}')
ifeq ($(word 1, $(FASM2BELS_COMMIT)),"-")
  FASM2BELS_COMMIT := $(wordlist 2, 45, $(FASM2BELS_COMMIT))
endif
FASM2BELS_URL := $(shell git config --file .gitmodules submodule.third_party/fasm2bels.url)
FASM2BELS_CACHE := $(shell cat $(FASM2BELS_PATH)/fasm2bels_commit.txt 2>/dev/null || echo "")

$(FASM2BELS_PATH)/fasm2bels_commit.txt: install_rapidwright install_vivado
	@echo "Need fasm2bels version: ${FASM2BELS_URL} ${FASM2BELS_COMMIT}"
	./scripts/install-fasm2bels.sh
	echo "\n# Fasm2bels Environment Variables" >> $(VENV_VARS)
	echo "FASM2BELS_PATH=$(FASM2BELS_PATH)" >> $(VENV_VARS)
	cat $(TOOL_VARS)/fasm2bels.env >> $(VENV_VARS)

F2B_PART ?= $(DEFAULT_PART)
F2B_FAMILY ?= $(DEFAULT_PART_FAMILY)
init_f2b_db: $(FASM2BELS_PATH)/$(F2B_PART)_db

$(FASM2BELS_PATH)/$(F2B_PART)_db: $(FASM2BELS_PATH)/fasm2bels_commit.txt
	@echo "Generating fasm2bels database for family $(F2B_FAMILY), part $(F2B_PART)"
	$(FASM2BELS_PYTHON) $(FASM2BELS_PATH)/fasm2bels/database/create_channels.py \
		--db-root $(FASM2BELS_PATH)/third_party/prjxray-db/$(F2B_FAMILY) \
		--part $(F2B_PART) \
		--connection-database-output $(FASM2BELS_PATH)/$(F2B_PART)_db
	@echo "$(F2B_PART) Database generated. Pregenerate any other database by running F2B_PART=<part	F2B_FAMILY=<family	make init_f2b_db"


################################################################################
# rand_soc
################################################################################
.PHONY: install_rand_soc
install_rand_soc:
	$(MODULE_INIT_UPDATE) $(RAND_SOC_PATH)
	cd pip install -r $(RAND_SOC_PATH)/requirements.txt
	echo "\n# RandSoc Variables\nRAND_SOC_PATH=$(RAND_SOC_PATH)\nRAND_SOC_INSTALLED=1" >> $(VENV_VARS)


################################################################################
# Conformal
################################################################################
.PHONY: install_conformal
install_conformal: $(CONFROMAL_BIN)
	echo "\n# Conformal Environment Variables" >> $(VENV_VARS)
	echo "CONFORMAL_PATH=$(CONFORMAL_PATH)" >> $(VENV_VARS)
	cat $(TOOL_VARS)/conformal.env >> $(VENV_VARS)

$(CONFROMAL_BIN):
	@echo "Conformal is not installed by this Makefile. The conformal tool is"
	@echo "expected to be installed on a remote computer. Please set the"
	@echo "necessary variables in config.py to point to the remote computer."
	@echo "Then, rerun make install_conformal to setup project environment variables."
	exit 1


################################################################################
# Yosys
################################################################################

install_yosys:
	$(MODULE_INIT_UPDATE) $(YOSYS_PATH)
	$(MAKE) -C $(YOSYS_PATH) -j8
	echo "\n# Yosys Environment Variables" >> $(VENV_VARS)
	echo "YOSYS_PATH=$(YOSYS_PATH)" >> $(VENV_VARS)
	cat $(TOOL_VARS)/yosys.env >> $(VENV_VARS)

################################################################################
# Wafove
################################################################################

install_wafove:
	$(MODULE_INIT_UPDATE) $(WAFOVE_PATH)
	cd $(WAFOVE_PATH) && python setup.py install && $(MAKE) yosys_cells_sim

################################################################################
# IceStorm
################################################################################

install_icestorm:
	$(MODULE_INIT_UPDATE) $(ICESTORM_PATH)
	$(MAKE) -C $(ICESTORM_PATH) -j$(nproc) && $(MAKE) install PREFIX=../
	echo "\n# IceStorm Environment Variables" >> $(VENV_VARS)
	echo "ICESTORM_PATH=$(ICESTORM_PATH)" >> $(VENV_VARS)
	cat $(TOOL_VARS)/icestorm.env >> $(VENV_VARS)


################################################################################
# OpenTitan
################################################################################
FUSESOC_CMD := --cores-root . run --build-root $(BUILD_PATH)/opentitan --flag=fileset_top --target=synth --no-export --setup lowrisc:systems:chip_earlgrey_cw310
FINAL_TCL := $(BUILD_PATH)/opentitan/synth-vivado/lowrisc_systems_chip_earlgrey_cw310_0.1.tcl
.PHONY: install_opentitan
install_opentitan: $(FINAL_TCL)

$(FINAL_TCL): install_vivado
ifeq ($(shell command -v rustc), "")
	@echo "Rust compiler is required to build OpenTitan. https://rustup.rs/"; exit 1;
endif
	$(MODULE_INIT_UPDATE) $(OPENTITAN_PATH)
	sed '/^#/d' $(OPENTITAN_PATH)/apt-requirements.txt | xargs sudo apt install -y
	pip install -U pip "setuptools<66.0.0"
	pip install -r $(OPENTITAN_PATH)/python-requirements.txt
	$(OPENTITAN_PATH)/util/get-toolchain.py --update
#   If fusesoc fails, retry with latest version.
	cd $(OPENTITAN_PATH) && fusesoc $(FUSESOC_CMD) || pip install fusesoc && fusesoc $(FUSESOC_CMD)
	echo "\nlaunch_runs impl_1" >> $(FINAL_TCL)


################################################################################
# iCEcube2
################################################################################
.PHONY: install_icecube2
install_icecube2: $(IC2_PATH)
	echo "\n# iCEcube2 Environment Variables" >> $(VENV_VARS)
	echo "IC2_PATH=$(IC2_PATH)" >> $(VENV_VARS)
	cat $(TOOL_VARS)/iCEcube2.env >> $(VENV_VARS)

$(IC2_PATH):
	@echo "iCEcube2 is not currently supported in the ninja build. Checkout the project tag legacy_flows for the last probable support"
	@echo "https://github.com/byuccl/bfasst/releases/tag/legacy_flows"
	@echo "This tag would be useful for porting iCEcube2 to the current build system."
	@echo "iCEcube2 remnants in this project are in setup/setIC2License.sh and setup/tool_vars/iCEcube2.env"