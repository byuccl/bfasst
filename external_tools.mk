################################################################################
# Vivado
################################################################################

install_vivado:
	@echo "Vivado is not installed by this Makefile. Please install Vivado 2022.2"
	@echo "and set the VIVADO_PATH variable in the Makefile to point to the"
	@echo "vivado binary."


################################################################################
# Rapidwright
################################################################################

install_rapidwright:
	git submodule init third_party/RapidWright
	git submodule update --init --recursive third_party/RapidWright

	cd third_party/RapidWright && ./gradlew compileJava
	cd third_party/RapidWright/interchange/ && make
	$(IN_ENV) cd third_party/RapidWright ; export PATH=`pwd`/bin:$$PATH ; \
	rapidwright jython -c 'FileTools.ensureDataFilesAreStaticInstallFriendly("xc7a200t")'
	echo >> ".venv/bin/activate"
	echo "if [ -f \"`pwd`/third_party/rapidwright.sh\" ];then" >> ".venv/bin/activate" 	
	echo ". `pwd`/third_party/rapidwright.sh" >> ".venv/bin/activate"
	echo "fi" >> ".venv/bin/activate"
	echo "export INTERCHANGE_SCHEMA_PATH=`pwd`/third_party/RapidWright/interchange/fpga-interchange-schema/interchange" >> ".venv/bin/activate"
	echo "unset INTERCHANGE_SCHEMA_PATH" >> ".venv/bin/deactivate"


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
