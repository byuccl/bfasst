BUILD_DIR ?= /nvme/jgoeders/bfasst/build/rand_soc
OUT_DIR   ?= output

.PHONY: all utilization timing congestion runtime csv

all: utilization timing congestion runtime csv

utilization:
	python utilization.py $(BUILD_DIR) --out-dir $(OUT_DIR)

timing:
	python timing.py $(BUILD_DIR) --out-dir $(OUT_DIR)

congestion:
	python congestion.py $(BUILD_DIR) --out-dir $(OUT_DIR)

runtime:
	python runtime.py $(BUILD_DIR) --out-dir $(OUT_DIR)

csv:
	python dataset.py $(BUILD_DIR) --out-dir $(OUT_DIR)
