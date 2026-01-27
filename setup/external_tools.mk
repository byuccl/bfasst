# DO NOT DIRECTLY CALL THIS FILE. Depends on vars in top level Makefile.
# When adding new tools, make PATH variable ajustments to $(ACTIVATE_SCRIPT) and append environment variables to $(VENV_VARS)
# Tool location paths here, other tool varialbes group with tool recipe or in setup/tools_vars/*.env
# The environment is activated with every shell line, so variables added to $(VENV_VARS) are available for all future shell lines.
# Keep tool recipes multithreading safe by using APPEND_MT macro or flock command when writing to shared files like $(VENV_VARS) and $(VENV_ACTIVATE)
TOOL_VARS := $(INITIAL_VARS)
include $(BFASST_SETUP)/helper_macros.mk
########################## Non-submodule Tools #####################################################
CONFORMAL_PATH ?= $(or $(shell command -v conformal), "conformal_is_missing")
VIVADO_BIN ?= $(or $(shell command -v vivado), "vivado_is_missing")
IC2_PATH ?= /tools/lscc/iCEcube2.2020.12

########################## Bulk Submodule Build Recipes ############################################
.PHONY: all_submodules update_all_submodules reset_submodules

# Automated Submodule Variables and Rules:
# Helper macros has imported <SUBMODULE>_PATH, <SUBMODULE>_INSTALLED, <SUBMODULE>_UPDATED for each submodule
# Helper macros has linked dependency rules to make sure the repo is cloned and checked out, and $(VENV_ACTIVATE) and $(VENV_VARS) exists
# Dependency chain: (auto generated)
#    PHONY COMMAND                ACTUAL TARGET             	DEPENDENCIES
#  update_<submodule>	$(STAMP_DIR)/<submodule>_updated		$(STAMP_DIR)/<submodule>_checkout | $(STAMP_DIR)/<submodule>_installed
#         <submodule>	$(STAMP_DIR)/<submodule>_installed		<none> | $(SUBMODULE_RULES_DIR)/<submodule>.mk $(STAMP_DIR)/<submodule>_checkout $(<SUBMODULE>_PATH)/.bfasst_installed
#						$(STAMP_DIR)/<submodule>_checkout		.git metadata files that change when submodule commit changes or bfasst expects a new commit | <none>
#			            $(SUBMODULE_RULES_DIR)/<submodule>.mk	<none> | $(<SUBMODULE>_PATH)/.git
#
# To avoid repeat work, and solve chicken/egg dependencies for cached submodules: 
# 1) *.git rules CREATE $(STAMP_DIR)/<submodule>_checkout target files
# 2) *_checkout rules DELETE the .bfasst_installed file. (only if an actual checkout was done)
# 3) *_installed rules CREATE _updated target file -> but it must be MANUALLY implemented in the rules below
#
# ADDING NEW SUBMODULES:
# 1) Add the submodule using git submodule add <repo_url> <path
# 2) Optionally create a $(SUBMODULE_PATH)/.bfasst_installed: rule to perfom any build steps done INSIDE the submodule repo.
# 3) Optionally create a $(SUBMODULE_INSTALLED): rule to perfom any build steps done in the BFASST repo (edit $(VENV_VARS), etc)
# 4) Optionally create a $(SUBMODULE_UPDATED): rule to perform any rebuild steps when a new commit is checked out.
# No-op rules are predefined to fill in for any you do not need.


MODULE_INIT := git submodule init
# if you do not include init, then recursive update will not operate as expected
MODULE_UPDATE := git submodule update --init --recursive

# On fresh clone: bootstrap rules handle checkout + rule file generation lazily per-submodule
# Each submodule target generates its rule file on first request, then rule file provides git deps
# Batch build makefiles, then install targets to minimize redundant makefile parsing
all_submodules: .gitmodules
	$(MAKE) $(SUBMOD_MAKEFILES)
	$(MAKE) $(SUBMOD_INSTALL_TARGETS)

# Installed submodules are outdated if their current commit does not match the project's expected commit
update_all_submodules: .gitmodules
	$(MAKE) $(SUBMOD_UPDATE_TARGETS)

RESET_BRANCH ?= main
reset_submodules:
	@echo "Force resetting all submodules to match origin/$(RESET_BRANCH)"
	@echo "Run $make reset_submodules RESET_BRANCH=<branch> to reset to a different branch."
	git submodule deinit -f --all
	git fetch origin $(RESET_BRANCH)
	git checkout $(RESET_BRANCH) -- .gitmodules
	@$(foreach submodule,$(ALL_SUBMODULES), git checkout $(RESET_BRANCH) -- $(submodule);)

####################################################################################################
# Vivado
####################################################################################################
.PHONY: vivado
vivado: $(VIVADO_BIN)
$(VIVADO_BIN):
	@echo "Vivado is not installed by this Makefile. Please install Vivado 2025.1"
	@echo "Then, set the VIVADO_BIN variable in bfasst.env to point to the vivado binary."
	exit 1

####################################################################################################
# CMake
####################################################################################################
CMAKE_VERSION ?= 3.27.7
CMAKE_DIR := cmake-${CMAKE_VERSION}-linux-x86_64
CMAKE_URL := https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/$(CMAKE_DIR).tar.gz
.PHONY: cmake update_cmake
update_cmake:
ifneq ($(shell cmake --version 2>/dev/null | grep $(CMAKE_VERSION)),)
	$(MAKE) -B $(VENV_BIN)/cmake
else
	@echo "make: Nothing to be done for 'update_cmake'. $(VENV_BIN)/cmake is already at the environment specified version ($(CMAKE_VERSION))"
endif

cmake: $(VENV_BIN)/cmake
$(VENV_BIN)/cmake: | $(VENV_BIN)
	curl -Ls "${CMAKE_URL}" | tar -xz --strip-components=2 -C $(VENV_BIN) $(CMAKE_DIR)/bin/

####################################################################################################
# Capnproto Java
####################################################################################################
CAPNP_JAVA := $(or $(shell command -v capnpc-java), capnpc-java)
PREFIX ?= /usr/local
.PHONY: capnproto_java
capnproto_java: $(CAPNP_JAVA)
# Auto rebuild capnproto-java if capnproto is updated by apt
$(CAPNP_JAVA): $(shell command -v capnproto) 
	$(eval TEMP_DIR := $(shell mktemp -d))
	git clone https://github.com/capnproto/capnproto-java $(TEMP_DIR)
	$(MAKE) -C $(TEMP_DIR)
	$(MAKE) -C $(TEMP_DIR) install || \
	  @echo "Did you run with sudo? To install to local environment, run 'make capnproto_java PREFIX=$(VENV_DIR)'""; \
	  exit 1;
	@rm -rf $(TEMP_DIR)
#   Update env variable for capnp schema, if it not already present
	ifeq ($(shell grep -Fx "export JAVA_SCHEMA=$(PREFIX)/include/capnp/" "$(VENV_VARS)" 2>/dev/null),)
		flock $(VENV_VARS) -c 'printf "\n%s\n" "# Capnproto Java Schema Path\nJAVA_SCHEMA=$(PREFIX)/include/capnp/" >> "$(VENV_VARS)"'
	endif

####################################################################################################
# Rapidwright
####################################################################################################
.PHONY: cache_rw_part inject_interchange
# Find proper Java version. Currently 18 or 17.
ifndef JAVA_HOME
  ifneq ($(wildcard /usr/lib/jvm/java-18-openjdk-amd64/bin/java), )
    JAVA_HOME := /usr/lib/jvm/java-18-openjdk-amd64
  else ifneq ($(wildcard /usr/lib/jvm/java-17-openjdk-amd64/bin/java), )
    JAVA_HOME := /usr/lib/jvm/java-17-openjdk-amd64
  endif
endif
export JAVA_HOME

RW_PART ?= $(DEFAULT_PART)
PART_CSV := $(RAPIDWRIGHT_PATH)/data/partdump.csv
# Infer family from part using $(RAPIDWRIGHT_PATH)/data/partdump.csv, if it exists
ifeq ($(real_path $(PART_CSV)),)
  # Partdump.csv does not exist, no parts have been cached.
  RW_PART_CACHE := $(PART_CSV)
else
  RW_FAMILY := $(shell awk -F, -v p="$(RW_PART)" '$$1 == p || $$5 == p {print $$4; exit}' $(PART_CSV))
  RW_PART_CACHE := $(RAPIDWRIGHT_PATH)/data/devices/$(RW_FAMILY)/$(RW_PART)_db_cache.dat
endif

rapidwright: $(RW_PART_CACHE)
cache_rw_part: $(RW_PART_CACHE)
$(RW_PART_CACHE): $(RAPIDWRIGHT_INSTALLED)
	cd $(RAPIDWRIGHT_PATH); rapidwright jython -c 'FileTools.ensureDataFilesAreStaticInstallFriendly("$(RW_PART)")'
	@echo "Cached RapidWright database for part $(RW_PART). To cache other parts, run make cache_rw_part RW_PART=<part>"

RW_PATH := $(RAPIDWRIGHT_PATH)
CLASSPATH = $(RAPIDWRIGHT_PATH)/bin:$$(echo $(RAPIDWRIGHT_PATH)/jars/*.jar | tr ' ' ':')
$(RAPIDWRIGHT_INSTALLED): | $(CAPNP_JAVA) $(VIVADO_BIN)
ifndef JAVA_HOME
	@echo "Java 17 or 18 is required to build RapidWright. Please run 'sudo make packages' to install it."
	@exit 1
else
	cd $(RAPIDWRIGHT_PATH) && JAVA_HOME=$(JAVA_HOME) ./gradlew compileJava
	@$(call ADD_ENV_VARS,rapidwright,$(INITIAL_VARS)/rapidwright.env,$(VENV_VARS),RW_PATH JAVA_HOME CLASSPATH)
	@$(call ADD_ENV_VARS,rapidwright,$(INITIAL_VARS)/rapidwright.paths,$(VENV_ACTIVATE))
	@mkdir -p $(RAPIDWRIGHT_PATH)/stubs
	@echo "Generating Java stubs for RapidWright at $(RAPIDWRIGHT_PATH)/stubs"
	@python $(BFASST_SETUP)/generate_java_stubs.py $(RAPIDWRIGHT_PATH)/stubs > /dev/null 2>&1 &
	touch $@
	touch $(RAPIDWRIGHT_UPDATED)
endif

# Inject interchange is only needed if custom modifications have been made.
# RW installs with the generated files matching its interchange submodule by default.
inject_interchange: $(RAPIDWRIGHT_INSTALLED) $(CAPNP_JAVA)
ifneq ($(wildcard $(RAPIDWRIGHT_PATH)/interchange/fpga-interchange-schema/),)
  ifneq ($(shell cd $(RAPIDWRIGHT_PATH)/interchange/fpga-interchange-schema/ && git status --porcelain),)
	@echo "Injecting updated FPGA Interchange schema into RapidWright"
	$(MAKE) -C $(RAPIDWRIGHT_PATH)/interchange/
	cd $(RAPIDWRIGHT_PATH) && ./gradlew compileJava
	touch $(RAPIDWRIGHT_UPDATED)
  endif
endif


JAVA_STUBS := $(SETUP_BUILD)/stubs
ifneq ($(realpath $(RAPIDWRIGHT_PATH)/bin/com),)
  $(shell rm -rf $(JAVA_STUBS))
  JAVA_STUBS := $(RAPIDWRIGHT_PATH)/stubs
  $(JAVA_STUBS): $(RAPIDWRIGHT_INSTALLED) $(RAPIDWRIGHT_UPDATED)
endif

$(JAVA_STUBS):
	@rm -rf $(JAVA_STUBS)
	@mkdir -p $(JAVA_STUBS)
	@echo "Generating Java stubs for RapidWright at $(JAVA_STUBS)"
	@python $(BFASST_SETUP)/generate_java_stubs.py $(JAVA_STUBS) > /dev/null 2>&1
	touch $@
	
update_rapidwright: $(JAVA_STUBS)
$(RAPIDWRIGHT_UPDATED):
	cd $(RAPIDWRIGHT_PATH) && ./gradlew updateJars
	cd $(RAPIDWRIGHT_PATH) && ./gradlew compileJava
	touch $@

####################################################################################################
# Fasm2bels
####################################################################################################
.PHONY: init_f2b_db
fasm2bels: init_f2b_db

# f2b env is NOT parallel friendly, so for now do not use $(MAKE) for env target
define F2B_BUILD
	make -C $(FASM2BELS_PATH) env & $(MAKE) -C $(FASM2BELS_PATH) build ; wait
	$(MAKE) -C $(FASM2BELS_PATH) test-py
	touch $1
endef

export VIVADO_PATH ?= $(VIVADO_BIN)
F2B_PATH := $(FASM2BELS_PATH)
$(FASM2BELS_INSTALLED): $(RAPIDWRIGHT_INSTALLED) $(VIVADO_BIN)
	$(call ADD_ENV_VARS,fasm2bels,$(INITIAL_VARS)/fasm2bels.env,$(VENV_VARS),F2B_PATH)
	$(call F2B_BUILD,$@)
	touch $(FASM2BELS_UPDATED)

$(FASM2BELS_UPDATED):
	$(call F2B_BUILD,$@)

F2B_PART ?= $(DEFAULT_PART)
F2B_FAMILY ?= $(DEFAULT_PART_FAMILY)
FASM2BELS_PYTHON ?= $(FASM2BELS_PATH)/env/conda/envs/f4pga_xc_fasm2bels/bin/python3
init_f2b_db: $(FASM2BELS_PATH)/$(F2B_PART)_db
$(FASM2BELS_PATH)/$(F2B_PART)_db: $(FASM2BELS_INSTALLED)
	@echo "Generating fasm2bels database for family $(F2B_FAMILY), part $(F2B_PART)"
	$(FASM2BELS_PYTHON) $(FASM2BELS_PATH)/fasm2bels/database/create_channels.py \
		--db-root $(FASM2BELS_PATH)/third_party/prjxray-db/$(F2B_FAMILY) \
		--part $(F2B_PART) \
		--connection-database-output $(FASM2BELS_PATH)/$(F2B_PART)_db
	@echo "$(F2B_PART) Database generated. Pregenerate any other database by running F2B_PART=<part	F2B_FAMILY=<family	make init_f2b_db"

#####################################################################################################
# rand_soc
#####################################################################################################
$(RAND_SOC_INSTALLED):
	cd $(RAND_SOC_PATH) && pip install -r requirements.txt
	touch $@
	touch $(RAND_SOC_UPDATED)

$(RAND_SOC_UPDATED):
	cd $(RAND_SOC_PATH) && pip install -r requirements.txt
	touch $@

#####################################################################################################
# Conformal
#####################################################################################################
.PHONY: conformal
conformal: $(CONFROMAL_BIN)
$(CONFROMAL_BIN):
	@echo "Conformal is not installed by this Makefile. The conformal tool is"
	@echo "expected to be installed on a remote computer. Please set the"
	@echo "necessary variables in config.py to point to the remote computer."
	@echo "Then, rerun make conformal to setup project environment variables."
	exit 1

#####################################################################################################
# Yosys
#####################################################################################################
define YOSYS_BUILD
	make -C $(YOSYS_PATH)
	touch $1
endef

YO_PATH := $(YOSYS_PATH)
$(YOSYS_INSTALLED): 
	$(call ADD_ENV_VARS,yosys,$(INITIAL_VARS)/yosys.env,$(VENV_VARS),YO_PATH)
	$(call YOSYS_BUILD,$@)
	touch $(YOSYS_UPDATED)

$(YOSYS_UPDATED):
	$(call YOSYS_BUILD,$@)

#####################################################################################################
# Wafove
#####################################################################################################
$(WAFOVE_INSTALLED):
	python $(WAFOVE_PATH)/setup.py install
	$(MAKE) -C $(WAFOVE_PATH) yosys_cells_sim
	touch $@
	touch $(WAFOVE_UPDATED)

$(WAFOVE_UPDATED):
	python $(WAFOVE_PATH)/setup.py install
	$(MAKE) -C $(WAFOVE_PATH) yosys_cells_sim
	touch $@

#####################################################################################################
# IceStorm
#####################################################################################################
# we used to also install archane pnr, but for some reason it did not get migrated here from legacy flows.
# https://github.com/cseed/arachne-pnr.git
# The following packages are not installed by make apt_packages, and may be needed: python-xdot mercurial

ICESTORM_HOME := $(ISCESTORM_PATH)
$(ICESTORM_INSTALLED): 
	$(MAKE) -C $(ICESTORM_PATH) && $(MAKE) install PREFIX=../; exit 1;
	$(call ADD_ENV_VARS,icestorm,$(INITIAL_VARS)/icestorm.env,$(VENV_VARS),ICESTORM_HOME)
	touch $@
	touch $(ICESTORM_UPDATED)

$(ICESTORM_UPDATED):
	$(MAKE) -C $(ICESTORM_PATH) && $(MAKE) install PREFIX=../; exit 1;
	touch $@

#####################################################################################################
# OpenTitan
#####################################################################################################
FUSESOC_CMD := --cores-root . run --build-root $(BFASST_BUILD)/opentitan --flag=fileset_top --target=synth --no-export --setup lowrisc:systems:chip_earlgrey_cw310
FINAL_TCL := $(BFASST_BUILD)/opentitan/synth-vivado/lowrisc_systems_chip_earlgrey_cw310_0.1.tcl
$(OPENTITAN_INSTALLED): | vivado
ifeq ($(shell command -v rustc),)
	@echo "Rust compiler is required to build OpenTitan. https://rustup.rs/"; exit 1;
endif
	$(MODULE_UPDATE) $(OPENTITAN_PATH)
	sed '/^#/d' $(OPENTITAN_PATH)/apt-requirements.txt | xargs sudo apt install -y
	pip install -U pip "setuptools<66.0.0"
	pip install -r $(OPENTITAN_PATH)/python-requirements.txt
	$(OPENTITAN_PATH)/util/get-toolchain.py --update
#   If fusesoc fails, retry with latest version.
	cd $(OPENTITAN_PATH) && fusesoc $(FUSESOC_CMD) || pip install fusesoc && fusesoc $(FUSESOC_CMD)
	echo "\nlaunch_runs impl_1" >> $(FINAL_TCL)
	touch $@
	touch $(OPENTITAN_UPDATED)

$(OPENTITAN_UPDATED):
# 	$(MODULE_UPDATE) $(OPENTITAN_PATH)
# 	pip install -r $(OPENTITAN_PATH)/python-requirements.txt
# 	$(OPENTITAN_PATH)/util/get-toolchain.py --update
# 	cd $(OPENTITAN_PATH) && fusesoc $(FUSESOC_CMD)
# 	echo "\nlaunch_runs impl_1" >> $(FINAL_TCL)



#####################################################################################################
# iCEcube2
#####################################################################################################
.PHONY: icecube2
icecube2: $(IC2_PATH)
	$(call APPEND_MT, \
		printf "\n%s\n" "# iCEcube2 Environment Variables"; \
		echo "IC2_PATH=$(IC2_PATH)"; \
		cat $(TOOL_VARS)/iCEcube2.env; \
	, $(VENV_VARS) )

$(IC2_PATH):
	@echo "iCEcube2 is not currently supported in the ninja build."
	@echo "Checkout the project tag legacy_flows for the last probable support point: https://github.com/byuccl/bfasst/releases/tag/legacy_flows"
	@echo "This tag would be useful for porting iCEcube2 to the current build system."
	@echo "iCEcube2 installation remnants in setup/: setIC2License.sh, install-icecube2.sh, env/iCEcube2.env"
	@exit 1
