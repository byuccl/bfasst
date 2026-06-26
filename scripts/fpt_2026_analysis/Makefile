# RandSoC FPT-2026 analysis pipeline.
#
# Run the targets in this order:
#   1. make remote-csv   Generate per-machine CSVs on the build machines and copy
#                        them back: per-design -> $(OUT_DIR)/raw/, per-IP sizes ->
#                        $(OUT_DIR)/raw_ip/.
#   2. make join         Merge $(OUT_DIR)/raw/*.csv into $(DATASET).
#   3. make all          Generate every plot (utilization, timing, congestion,
#                        runtime, ip-sizes) and copy the PDFs into $(IMAGES_DIR).
#
# Individual plot targets can be run on their own once their inputs exist. The
# per-IP plots (ip-sizes) read $(OUT_DIR)/raw_ip/*.csv directly -- no join step.
# `make csv` builds $(DATASET) from a single LOCAL build dir, skipping steps 1-2.

BUILD_DIR  ?= /nvme/jgoeders/bfasst/build/rand_soc
OUT_DIR    ?= output
DATASET    ?= $(OUT_DIR)/dataset.csv
# Generated plot PDFs are copied here for the paper after each plot target.
IMAGES_DIR ?= /home/jgoeders/papers/2026_FPT_randsoc/images

# IP types shown in the reduced per-IP size plot (ip_sizes_*_subset.pdf).
IP_TYPES   ?= microblaze,fft,axi_dma,emc,complex_multiplier,cordic,axi_cdma,quad_spi,axi_iic,floating_point
# Size metric for the per-IP plots. luts_ffs (LUTs+FFs) is the closest proxy to
# slice usage available; set METRIC=total_luts (or ffs, dsp, ...) to change.
METRIC     ?= luts_ffs

# Use the repo venv's interpreter, resolved relative to this Makefile so it
# works regardless of the directory make is invoked from.
REPO_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))../..)
PYTHON    ?= $(REPO_ROOT)/.venv/bin/python

# Run recipes under bash with pipefail so a plot script failing through a `tee`
# pipe still stops make instead of being masked by tee's exit status.
SHELL      := /bin/bash
.SHELLFLAGS := -e -o pipefail -c

.PHONY: all utilization timing congestion runtime ip-sizes csv remote-csv join

# Step 1: generate per-machine CSVs on the remotes and copy them back.
remote-csv:
	$(PYTHON) remote_csv.py --out-dir $(OUT_DIR)

# Step 2: merge output/raw/*.csv into a single dataset.csv.
join:
	$(PYTHON) join_csv.py --raw-dir $(OUT_DIR)/raw --out $(DATASET)

# Step 3: plots/analysis, all driven purely by the joined CSV.
# Each plot target tees its stdout to $(OUT_DIR)/<name>.log; the `all` recipe then
# collects every "N outliers not shown" line into one summary for paper captions.
all: utilization timing congestion runtime ip-sizes
	@echo
	@echo "===== Outliers excluded from plots (for LaTeX captions) ====="
	@grep -h -i "not shown" $(OUT_DIR)/*.log 2>/dev/null | sed 's/^ *//' | sort -u \
		|| echo "  (no clipped outliers reported)"
	@echo "============================================================="

utilization:
	$(PYTHON) utilization.py --csv $(DATASET) --out-dir $(OUT_DIR) 2>&1 | tee $(OUT_DIR)/utilization.log
	mkdir -p $(IMAGES_DIR) && cp $(OUT_DIR)/utilization_*.pdf $(IMAGES_DIR)/

timing:
	$(PYTHON) timing.py --csv $(DATASET) --out-dir $(OUT_DIR) 2>&1 | tee $(OUT_DIR)/timing.log
	mkdir -p $(IMAGES_DIR) && cp $(OUT_DIR)/timing_*.pdf $(IMAGES_DIR)/

congestion:
	$(PYTHON) congestion.py --csv $(DATASET) --out-dir $(OUT_DIR) 2>&1 | tee $(OUT_DIR)/congestion.log
	mkdir -p $(IMAGES_DIR) && cp $(OUT_DIR)/congestion_*.pdf $(IMAGES_DIR)/

runtime:
	$(PYTHON) runtime.py --csv $(DATASET) --out-dir $(OUT_DIR) 2>&1 | tee $(OUT_DIR)/runtime.log
	mkdir -p $(IMAGES_DIR) && cp $(OUT_DIR)/runtime_*.pdf $(IMAGES_DIR)/

# Per-IP size box plots (full + reduced subset) from the per-machine raw_ip CSVs.
# Reads $(OUT_DIR)/raw_ip/*.csv directly (no join). Skips gracefully if those
# don't exist yet, so `make all` doesn't fail before `make remote-csv` has run.
ip-sizes:
	@if ! ls $(OUT_DIR)/raw_ip/*.csv >/dev/null 2>&1; then \
		echo "ip-sizes: no $(OUT_DIR)/raw_ip/*.csv yet -- run 'make remote-csv' first; skipping"; \
	else \
		$(PYTHON) ip_sizes.py $(OUT_DIR)/raw_ip/*.csv --out-dir $(OUT_DIR) --metric $(METRIC) 2>&1 | tee $(OUT_DIR)/ip_sizes.log; \
		$(PYTHON) ip_sizes.py $(OUT_DIR)/raw_ip/*.csv --out-dir $(OUT_DIR) --metric $(METRIC) --types $(IP_TYPES); \
		mkdir -p $(IMAGES_DIR) && cp $(OUT_DIR)/ip_sizes_*.pdf $(IMAGES_DIR)/; \
	fi

# Build the combined CSV from a single LOCAL build directory (no remotes).
csv:
	$(PYTHON) dataset.py $(BUILD_DIR) --out-dir $(OUT_DIR)
