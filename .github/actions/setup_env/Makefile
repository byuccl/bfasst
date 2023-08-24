FASM2BELS_COMMIT ?= master

install_fasm2bels: 
	rm -rf ${BFASST_PATH_FASM2BELS}
	git clone ${FASM2BELS_URL} ${BFASST_PATH_FASM2BELS}
	cd ${BFASST_PATH_FASM2BELS} && git reset --hard ${FASM2BELS_COMMIT}
	cd ${BFASST_PATH_FASM2BELS} && make env
	cd ${BFASST_PATH_FASM2BELS} && make build
	cd ${BFASST_PATH_FASM2BELS} && make test-py

	cd ../../.. && python scripts/run_design.py designs/basic/and3/ xilinx_and_reversed



