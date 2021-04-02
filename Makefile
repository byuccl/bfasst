install: install_fasm2bels install_yosys
	sudo apt install -y \
		make \
		python3.8-dev \
		python3-pip \
		virtualenv \
		libncurses5 \
		swig \
		python3-venv
	
	sudo python3 -m pip install -r requirements.txt


install_fasm2bels:
	git submodule init
	git submodule update
	cd third_party/fasm2bels && make env
	cd third_party/fasm2bels && make build
	cd third_party/fasm2bels && make test-py


install_yosys:
	# Yosys
	sudo apt install -y \
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

	cd third_party/yosys && make -j8


format:
	find ./scripts -iname "*.py" -exec black -l 100 {} \;


