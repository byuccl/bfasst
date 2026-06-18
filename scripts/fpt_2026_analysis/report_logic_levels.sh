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
set -euo pipefail

BUILD_DIR="${1:-/data/jgoeders/fpt2026/build/rand_soc}"
MAX_PATHS="${2:-100000}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# The DCPs were built with Vivado 2024.2, so open_checkpoint needs that version.
# Source its settings if vivado isn't already on PATH. Override with
# VIVADO_SETTINGS=/path/to/settings64.sh if your install lives elsewhere.
VIVADO_SETTINGS="${VIVADO_SETTINGS:-/tools/Xilinx/Vivado/2024.2/settings64.sh}"
if ! command -v vivado >/dev/null 2>&1; then
    if [[ -f "$VIVADO_SETTINGS" ]]; then
        # shellcheck disable=SC1090
        source "$VIVADO_SETTINGS"
    else
        echo "ERROR: vivado not on PATH and $VIVADO_SETTINGS not found." >&2
        echo "       Set VIVADO_SETTINGS to your Vivado 2024.2 settings64.sh." >&2
        exit 1
    fi
fi

exec vivado -mode batch -nojournal -nolog \
    -source "$HERE/report_logic_levels.tcl" \
    -tclargs "$BUILD_DIR" "$MAX_PATHS"
