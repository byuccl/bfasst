BUILD_DIR ?= /nvme/jgoeders/bfasst/build/rand_soc
OUT_DIR   ?= output
DATASET   ?= $(OUT_DIR)/dataset.csv

.PHONY: all utilization timing congestion runtime csv remote-csv join

# --- Aggregation pipeline (run in order) ---------------------------------- #
#   make remote-csv   # Step 1: generate CSVs on remote machines, fetch locally
#   make join         # Step 2: merge per-machine CSVs into $(DATASET)
#   make all          # Step 3: generate all plots from $(DATASET)

# Step 1: generate per-machine CSVs on the remotes and copy them back.
remote-csv:
	python remote_csv.py --out-dir $(OUT_DIR)

# Step 2: merge output/raw/*.csv into a single dataset.csv.
join:
	python join_csv.py --raw-dir $(OUT_DIR)/raw --out $(DATASET)

# Step 3: plots/analysis, all driven purely by the joined CSV.
all: utilization timing congestion runtime

utilization:
	python utilization.py --csv $(DATASET) --out-dir $(OUT_DIR)

timing:
	python timing.py --csv $(DATASET) --out-dir $(OUT_DIR)

congestion:
	python congestion.py --csv $(DATASET) --out-dir $(OUT_DIR)

runtime:
	python runtime.py --csv $(DATASET) --out-dir $(OUT_DIR)

# Build the combined CSV from a single LOCAL build directory (no remotes).
csv:
	python dataset.py $(BUILD_DIR) --out-dir $(OUT_DIR)
