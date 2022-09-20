IN_ENV = if [ -e .venv/bin/activate ]; then . .venv/bin/activate; fi;


install: packages venv python_packages install_fasm2bels install_yosys

venv:
	python3 -m venv .venv
	$(IN_ENV) python3 -m pip install -U pip

packages:
	sudo apt-get install -y \
		make \
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
		openjdk-8-jdk \
		capnproto \
		libcapnp-dev
	
python_packages:
	$(IN_ENV) python3 -m pip install -r requirements.txt

capnproto_java:
	cd /tmp && git clone https://github.com/capnproto/capnproto-java
	cd /tmp/capnproto-java && make
	cd /tmp/capnproto-java && sudo make install


rapidwright:
	cd third_party && wget http://www.rapidwright.io/docs/_downloads/rapidwright-installer.jar
	cd third_party && java -jar rapidwright-installer.jar -t
	cd third_party/RapidWright && git submodule init
	cd third_party/RapidWright && git submodule update
	cd third_party/RapidWright/interchange && make
	cd third_party/RapidWright && make

install_fasm2bels:
	git submodule init
	git submodule update
	cd third_party/fasm2bels && make env
	$(IN_ENV) cd third_party/fasm2bels && make build
	cd third_party/fasm2bels && make test-py

env:
	echo ". `pwd`/third_party/rapidwright.sh" > "env.sh"
	echo "export INTERCHANGE_SCHEMA_PATH=`pwd`/third_party/RapidWright/interchange/fpga-interchange-schema/interchange" >> "env.sh"

install_yosys:
	# Yosys
	sudo apt-get install -y \
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


