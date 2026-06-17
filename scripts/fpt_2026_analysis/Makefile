BUILD_DIR ?= /nvme/jgoeders/bfasst/build/rand_soc
OUT_DIR   ?= output

.PHONY: all utilization

all: utilization

utilization:
	python utilization.py $(BUILD_DIR) --out-dir $(OUT_DIR)
