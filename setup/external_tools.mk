################################################################################
# Vivado
################################################################################

install_vivado:
	@echo "Vivado is not installed by this Makefile. Please install Vivado 2022.2"
	@echo "and set the VIVADO_PATH variable in the Makefile to point to the"
	@echo "vivado binary."


################################################################################
# Capnproto Java
################################################################################
capnproto_java:
ifeq "$(CAPNPJ)" ""
	$(eval TEMP_DIR := $(shell mktemp -d))
	git clone https://github.com/capnproto/capnproto-java $(TEMP_DIR)/capnproto-java
	make -C $(TEMP_DIR)/capnproto-java
	make -C $(TEMP_DIR)/capnproto-java install
	rm -rf $(TEMP_DIR)
endif


################################################################################
# Rapidwright
################################################################################

install_rapidwright: capnproto_java
# 	git submodule init third_party/RapidWright
# 	git submodule update --init --recursive third_party/RapidWright

    # Find proper Java version. Currently 18 or 17.
	if [ -z "$$JAVA_HOME" ]; then \
		if type /usr/lib/jvm/java-18-openjdk-amd64/bin/java >/dev/null 2>&1; then \
			JAVA_HOME=/usr/lib/jvm/java-18-openjdk-amd64; \
		elif type /usr/lib/jvm/java-17-openjdk-amd64/bin/java >/dev/null 2>&1; then \
			JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64; \
		else \
			echo "Java 17 or 18 is required to build RapidWright. Please run 'sudo make packages' to install it." ; \
			exit 1; \
		fi; \
	fi; \

	echo "\n# Make sure the correct java binary is available for RapidWright">> ".venv/bin/activate"
	echo "export JAVA_HOME=$$JAVA_HOME" >> ".venv/bin/activate"
	echo "\nunset JAVA_HOME" >> ".venv/bin/deactivate"
	echo "export PATH=$$JAVA_HOME/bin:\$$PATH" >> ".venv/bin/activate"
	parent_path=$(shell pwd)/third_party/RapidWright
# 	$(IN_ENV) cd $parent_path && ./gradlew compileJava
# 	$(IN_ENV) make -C $parent_path/interchange/ || {\
# 		@echo "Interchange build failed. The error could possibly be related to apt upgrading capnproto, but capnproto-java requires manual upgrade. Rerun 'sudo make capnproto_java'"; \
# 		exit 1; \
# 	}
	echo "\n# Add RapidWright/Interchange environment setup" >> ".venv/bin/activate"
	echo "export PATH=$parent_path/bin:$$PATH" >> ".venv/bin/activate"
	echo "export CLASSPATH=$parent_path/bin:$parent_path/jars/*" >> ".venv/bin/activate"
	echo "export CAPNP_PATH=$parent_path/interchange/schema" >> ".venv/bin/activate"
	echo "export INTERCHANGE_SCHEMA_PATH=$parent_path/interchange/fpga-interchange-schema/interchange" >> ".venv/bin/activate"

	echo "\n# Unset RapidWright/Interchange environment setup" >> ".venv/bin/deactivate"
	echo "unset INTERCHANGE_SCHEMA_PATH" >> ".venv/bin/deactivate"

# 	$(IN_ENV) cd third_party/RapidWright; rapidwright jython -c 'FileTools.ensureDataFilesAreStaticInstallFriendly("xc7a200t")'

update_rapidwright:
	git submodule update --remote third_party/RapidWright
	./gradlew updateJars
	./gradlew compileJava


################################################################################
# Fasm2bels
################################################################################

install_fasm2bels: install_rapidwright
	./scripts/install-fasm2bels.sh

################################################################################
# rand_soc
################################################################################

install_rand_soc:
	git submodule init third_party/rand_soc
	git submodule update third_party/rand_soc

	$(IN_ENV) cd third_party/rand_soc && pip install -r requirements.txt


################################################################################
# Conformal
################################################################################

install_conformal:
	@echo "Conformal is not installed by this Makefile. The conformal tool is"
	@echo "expected to be installed on a remote computer. Please set the"
	@echo "necessary variables in config.py to point to the remote computer."


################################################################################
# Yosys
################################################################################

install_yosys:
	git submodule init third_party/yosys
	git submodule update --init --recursive third_party/yosys
	cd third_party/yosys && make -j8

################################################################################
# Wafove
################################################################################

install_wafove:
	git submodule init third_party/WaFoVe
	git submodule update --init --recursive third_party/WaFoVe
	$(IN_ENV) cd third_party/WaFoVe && python setup.py install && make yosys_cells_sim

################################################################################
# IceStorm
################################################################################

install_icestorm:
	git submodule init third_party/icestorm
	git submodule update --init --recursive third_party/icestorm
	cd third_party/icestorm && make -j$(nproc) && make install PREFIX=../


################################################################################
# OpenTitan
# PRE-REQUISITES:
# - If fusesoc fails, I just used the latest version: pip install fusesoc
# - I needed a rust compiler: https://rustup.rs/
################################################################################
install_opentitan:
	git submodule update --init --recursive designs/opentitan
	cd designs/opentitan
	sudo sed '/^#/d' ./apt-requirements.txt | xargs sudo apt install -y
	pip install -U pip "setuptools<66.0.0"
	pip install -r designs/opentitan/python-requirements.txt
	./designs/opentitan/util/get-toolchain.py --update
	fusesoc --cores-root . run --build-root build/opentitan --flag=fileset_top --target=synth --no-export --setup lowrisc:systems:chip_earlgrey_cw310
	mv build/opentitan/synth-vivado build/opentitan/vivado_synth
	echo "launch_runs impl_1" >> build/opentitan/vivado_synth/lowrisc_systems_chip_earlgrey_cw310_0.1.tcl

################################################################################
# CMake
################################################################################
CMAKE_VERSION ?= 3.27.7
install_cmake:
	@bash scripts/install-cmake.sh $(CMAKE_VERSION)
