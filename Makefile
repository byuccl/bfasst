install:
	sudo apt install -y \
		make \
		python3.8-dev \
		python3-pip \
		virtualenv
	
	sudo python3 -m pip install -r requirements.txt

	git submodule init
	git submodule update
	cd third_party/fasm2bels && make env
	cd third_party/fasm2bels && make build
	cd third_party/fasm2bels && make test-py