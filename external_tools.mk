################################################################################
# Vivado
################################################################################

install_vivado:
	@echo "Vivado is not installed by this Makefile. Please install Vivado 2022.2"
	@echo "and set the VIVADO_PATH variable in the Makefile to point to the"
	@echo "vivado binary."


################################################################################
# Fasm2bels
################################################################################

install_fasm2bels:
	./scripts/install-fasm2bels.sh

################################################################################
# GMT Tools
################################################################################

install_gmt_tools:
	git submodule init third_party/gmt_tools
	git submodule update third_party/gmt_tools

	$(IN_ENV) cd third_party/gmt_tools && pip install -r requirements.txt


################################################################################
# Conformal
################################################################################

install_conformal:
	@echo "Conformal is not installed by this Makefile. The conformal tool is"
	@echo "expected to be installed on a remote computer. Please set the"
	@echo "necessary variables in config.py to point to the remote computer."


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
	$(IN_ENV) python -m pip install -e third_party/WaFoVe
	$(IN_ENV) cd third_party/WaFoVe && make build

################################################################################
# Isoblaize
################################################################################

install_isoblaze:
	git submodule init third_party/isoblaze
	git submodule update third_party/isoblaze