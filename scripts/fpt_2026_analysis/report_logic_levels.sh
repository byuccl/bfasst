#!/usr/bin/env bash
#
# Drive report_logic_levels.tcl over a RandSoC build directory with Vivado in
# batch mode. Resumable: designs that already have vivado_impl/logic_levels.txt
# are skipped, so re-run it as more designs finish implementation.
#
# Run this ON a build machine (where the DCPs and Vivado live), e.g. CCL1 or
# serenity.
#
# Usage: ./report_logic_levels.sh [build_dir] [max_paths]
#
# The DCPs were built with Vivado 2024.2, so open_checkpoint needs that version.
# Override the binary with VIVADO=/path/to/vivado if it lives elsewhere.
set -eo pipefail

VIVADO="${VIVADO:-/tools/Xilinx/Vitis/2024.2/bin/vivado}"
BUILD_DIR="${1:-/data/jgoeders/fpt2026/build/rand_soc}"
MAX_PATHS="${2:-100000}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

exec "$VIVADO" -mode batch -nojournal -nolog \
    -source "$HERE/report_logic_levels.tcl" \
    -tclargs "$BUILD_DIR" "$MAX_PATHS"
