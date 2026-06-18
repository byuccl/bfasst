BUILD_DIR  ?= /nvme/jgoeders/bfasst/build/rand_soc
OUT_DIR    ?= output
DATASET    ?= $(OUT_DIR)/dataset.csv
# Generated plot PDFs are copied here for the paper after each plot target.
IMAGES_DIR ?= /home/jgoeders/papers/2026_FPT_randsoc/images

# Use the repo venv's interpreter, resolved relative to this Makefile so it
# works regardless of the directory make is invoked from.
REPO_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))../..)
PYTHON    ?= $(REPO_ROOT)/.venv/bin/python

.PHONY: all utilization timing congestion runtime csv remote-csv join

# --- Aggregation pipeline (run in order) ---------------------------------- #
#   make remote-csv   # Step 1: generate CSVs on remote machines, fetch locally
#   make join         # Step 2: merge per-machine CSVs into $(DATASET)
#   make all          # Step 3: generate all plots from $(DATASET)

# Step 1: generate per-machine CSVs on the remotes and copy them back.
remote-csv:
	$(PYTHON) remote_csv.py --out-dir $(OUT_DIR)

# Step 2: merge output/raw/*.csv into a single dataset.csv.
join:
	$(PYTHON) join_csv.py --raw-dir $(OUT_DIR)/raw --out $(DATASET)

# Step 3: plots/analysis, all driven purely by the joined CSV.
all: utilization timing congestion runtime

utilization:
	$(PYTHON) utilization.py --csv $(DATASET) --out-dir $(OUT_DIR)
	mkdir -p $(IMAGES_DIR) && cp $(OUT_DIR)/utilization_*.pdf $(IMAGES_DIR)/

timing:
	$(PYTHON) timing.py --csv $(DATASET) --out-dir $(OUT_DIR)
	mkdir -p $(IMAGES_DIR) && cp $(OUT_DIR)/timing_*.pdf $(IMAGES_DIR)/

congestion:
	$(PYTHON) congestion.py --csv $(DATASET) --out-dir $(OUT_DIR)
	mkdir -p $(IMAGES_DIR) && cp $(OUT_DIR)/congestion_*.pdf $(IMAGES_DIR)/

runtime:
	$(PYTHON) runtime.py --csv $(DATASET) --out-dir $(OUT_DIR)
	mkdir -p $(IMAGES_DIR) && cp $(OUT_DIR)/runtime_*.pdf $(IMAGES_DIR)/

# Build the combined CSV from a single LOCAL build directory (no remotes).
csv:
	$(PYTHON) dataset.py $(BUILD_DIR) --out-dir $(OUT_DIR)
