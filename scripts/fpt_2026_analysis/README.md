# FPT 2026 Analysis

Scripts for analyzing the RandSoC dataset generated for the FPT 2026 paper.
The main result strategy is to generate a large dataset and report statistics
that demonstrate the diverse nature of the designs.

## Aggregating data across machines

The dataset is built on multiple remote machines (see `progress.py` for the
current list). The raw Vivado build output is far too large to copy locally, so
the pipeline generates a small per-design CSV **on each remote machine**, copies
just those CSVs back, joins them, and runs all plotting **purely from the joined
CSV** — no raw build directory is needed locally.

```
make remote-csv   # Step 1: generate CSVs on remotes (stdlib-only), fetch to output/raw/
make join         # Step 2: merge output/raw/*.csv -> output/dataset.csv
make all          # Step 3: generate all plots from output/dataset.csv
```

Key design point: **the remote step depends only on the Python standard
library**. `dataset.py` and its parsing helpers live in `parsers.py`, which
imports nothing beyond `re`/`csv`/`pathlib`, so they run on the remotes (which
have no numpy/matplotlib and may have no bfasst checkout) with zero setup. Only
the local plotting scripts use numpy/matplotlib.

Every row carries a `machine` column, so design identity is `(machine, seed)`
and seed ranges across machines never collide.

- **Configure machines** in `remote_csv.py` (`DEFAULT_MACHINES`: label, ssh
  host, build dir, python interpreter), or override per-run with
  `--machine LABEL:HOST:BUILD_DIR[:INTERP]` (repeatable). `python remote_csv.py
  --machine CCL1:CCL1:/data/jgoeders/fpt2026/build/rand_soc:python`.
- The plotting scripts also accept a positional `build_dir` instead of `--csv`
  to parse a single local build directory directly (the original behavior).

## Scripts

### `utilization.py`

Parses Vivado `utilization.txt` reports from a RandSoC build directory and produces two figures:

- **`utilization_histograms.png`** — 2×3 grid of histograms showing the distribution of LUT, FF, Slice (slice/CLB occupancy), BRAM, DSP, and IO utilization (as % of device capacity) across all designs.

All utilization metrics are read from the **post-implementation** report (`vivado_impl/utilization.txt`).
- **`utilization_radar.png`** — Radar chart overlaying the median design against the most extreme design for each resource type, highlighting the diversity of resource profiles.

Also prints a summary table (min, median, mean, max, std) for each resource to stdout.

**Usage:**
```
make utilization                          # plots from output/dataset.csv
python utilization.py --csv path/to/dataset.csv --out-dir output
python utilization.py /path/to/rand_soc   # parse a local build dir directly
```

Output is written to `output/` by default; override with `OUT_DIR=`.

### `congestion.py`

Parses peak routing segment utilization percentages from `vivado.log` (the `Max Cong = XX%` lines emitted during placement) and produces:

- **`congestion.png`** — Three-panel figure: box plots of peak utilization per direction (N/S/E/W), a histogram of the overall maximum congestion per design colored by whether a hotspot was detected, and a clean vs. hotspot count bar.

Vivado flags a region as a congestion hotspot when routing segment utilization exceeds ~85%. Also prints a per-direction summary table and hotspot count to stdout.

**Usage:**
```
make congestion                          # plots from output/dataset.csv
python congestion.py --csv path/to/dataset.csv --out-dir output
python congestion.py /path/to/rand_soc   # parse a local build dir directly
```

### `timing.py`

Parses Vivado `timing_summary.txt` reports from a RandSoC build directory and produces:

- **`timing.png`** — 2×3 grid of histograms: WNS distribution (pass/fail colored), achieved **Fmax**, TNS, failing endpoint count, worst-case logic level depth, and worst-case data path delay. Each panel clips its extreme tail(s) to a percentile (noting how many outliers are hidden) so a few pathological designs don't flatten the distribution.

Achieved Fmax is computed as `1000 / (clk_period_ns - WNS_ns)`, using the target clock period parsed from the report's Clock Summary (so it adapts if the target frequency varies across designs).

Also prints a timing closure summary (designs meeting vs. failing timing) and a statistics table (incl. Fmax) to stdout. Skips designs with no clock constraint.

**Usage:**
```
make timing                          # plots from output/dataset.csv
python timing.py --csv path/to/dataset.csv --out-dir output
python timing.py /path/to/rand_soc   # parse a local build dir directly
```

### `runtime.py`

Parses wall-clock elapsed times for each Vivado phase from `vivado_synth/vivado.log` and `vivado_impl/vivado.log` and produces:

- **`runtime.png`** — Two-panel figure: stacked bar chart showing synth/opt/place/route breakdown per design (sorted by total), and a histogram of total elapsed time across designs.

Also prints a summary table (min, median, mean, max) per phase to stdout.

**Usage:**
```
make runtime                          # plots from output/dataset.csv
python runtime.py --csv path/to/dataset.csv --out-dir output
python runtime.py /path/to/rand_soc   # parse a local build dir directly
```

### `parsers.py`

Stdlib-only (no numpy/matplotlib) module holding the four `parse_*` functions,
`collect_all(build_dir, machine)`, the canonical `COLUMNS` list, `write_csv`, and
`read_dataset_csv` (reads a joined CSV back into typed rows). Shared by both the
remote generator (`dataset.py`) and the local plotting scripts. Not run directly.

### `dataset.py`

Aggregates all per-design metrics into a single CSV file: **`dataset.csv`**. One
row per design, keyed by `(machine, seed)`. Imports only `parsers.py`, so it runs
on the remote machines. `--machine LABEL` stamps the `machine` column.

**Columns:** `machine`, `seed` | post-impl utilization (LUT/FF/Slice/BRAM/DSP/IO %) | post-synth utilization | timing (WNS, TNS, failing endpoints, logic levels, data path delay, target clock period) | congestion (N/S/E/W %, max %, hotspot flag) | runtime (synth, opt, place, route, impl, total — all in seconds)

Missing data (e.g. a design that hasn't finished impl yet) is written as empty cells.

**Usage (single local build dir):**
```
make csv                      # uses default BUILD_DIR
make csv BUILD_DIR=/path/to/rand_soc/build
```

### `remote_csv.py`

**Step 1** of the aggregation pipeline. For each configured machine: copies the
stdlib-only generator (`parsers.py` + `dataset.py`) into a remote temp dir, runs
it against the remote build directory, and copies the resulting CSV back to
`output/raw/<label>.csv`. Machines are configured in `DEFAULT_MACHINES` or
overridden with `--machine LABEL:HOST:BUILD_DIR[:INTERP]`.

**Usage:**
```
make remote-csv
python remote_csv.py --out-dir output --machine serenity:serenity:/data/.../rand_soc:python3
```

### `join_csv.py`

**Step 2** of the aggregation pipeline. Merges every `output/raw/*.csv` into a
single `output/dataset.csv`, validating headers and flagging any duplicate
`(machine, seed)` keys.

**Usage:**
```
make join
python join_csv.py --raw-dir output/raw --out output/dataset.csv
```

## Possible Ideas

### Suggested Metrics

### From the design generator (no Vivado required)

Report as distributions (histograms or box plots):

- **IP count per design** — the config allows 2–20; show the actual distribution
- **IP type composition** — frequency each IP class appears across designs; diversity score per design (e.g. entropy or unique-type count)
- **AXI interconnect type** — fraction of designs using SmartConnect vs. Interconnect
- **AXI master strategy** — fraction using external port vs. JTAG master
- **AXI-Stream topology** — number of broadcasters, combiners, and width converters inserted per design; stream fan-out distribution

### From Vivado implementation results

These are the most compelling evidence of design diversity:

- **Resource utilization** — LUT, FF, DSP, BRAM, and IO counts (and % of device); show as distributions across the dataset. Available post-implementation (`utilization.txt`) and post-synthesis (`synth_utilization.txt`).
- **Synthesis vs. implementation delta** — difference in LUT count between post-synthesis and post-implementation; high deltas indicate complex packing behavior interesting to the CAD tools community.
- **WNS / timing slack** — shows the dataset spans easy-to-hard implementation territory (requires `clock_period` set in the run YAML)
- **Critical path logic depth** — number of logic levels on the worst timing path; extractable from `timing_summary.txt` even without a clock constraint. A structural measure of design hardness independent of target frequency.
- **Routing congestion** — worst congestion level (0–8 Vivado scale) and histogram of congested regions per design; level ≥5 indicates router pressure. Reported via `report_design_analysis -congestion` in `congestion.txt`.
- **Power** — total, dynamic, and static power from `report_power` in `power.txt`; another axis of design diversity relevant to power optimization research.
- **Implementation runtime** — wall-clock time per design through Vivado

## Other Quantitative Results

- **Implementation success rate** — fraction of generated designs that successfully synthesize and implement without errors; validates that the tool produces legal designs
- **Scaling study** — LUT/DSP/BRAM utilization vs. IP count; demonstrates the tool's parameter knobs produce predictable scaling behavior
- **Comparison to existing benchmarks** — plot resource utilization and timing distributions against Rosetta, Koios, ISPD 2016/2017, and/or VTR benchmarks to show the dataset covers broader and different territory (directly answers reviewer question: "diverse compared to what?")
- **ML readiness** — the dataset's primary intended use is ML-for-CAD research, the dominant growth area at all F conferences. Key properties to highlight: (a) dataset size scalability — show generation time vs. N designs to demonstrate thousands are practical; (b) reproducibility — fixed seeds guarantee identical designs for stable train/test splits; (c) ground truth richness — each design has timing, utilization, congestion, and power labels from full Vivado implementation. A simple baseline result (e.g. predicting post-implementation LUT count from IP composition) validates that the dataset has learnable structure.
- **Generation throughput** — wall-clock time to generate N designs, separating TCL generation time from Vivado runtime; relevant to researchers wanting to reproduce or extend the dataset
