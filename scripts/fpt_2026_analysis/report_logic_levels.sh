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
#
# Vivado occasionally crashes part-way through a large batch. Because the Tcl
# skips already-finished designs, we just relaunch it until a pass completes:
# the loop restarts whenever Vivado dies before printing its final "Done." line,
# and stops once a full pass finishes. Set RETRY_DELAY to change the pause
# between attempts (default 10s); Ctrl-C to stop.
set -eo pipefail

VIVADO="${VIVADO:-/tools/Xilinx/Vivado/2024.2/bin/vivado}"
BUILD_DIR="${1:-/data/jgoeders/fpt2026/build/rand_soc}"
MAX_PATHS="${2:-100000}"
RETRY_DELAY="${RETRY_DELAY:-10}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

LOG="$(mktemp)"
trap 'rm -f "$LOG"' EXIT

attempt=0
while true; do
    attempt=$((attempt + 1))
    echo "===== report_logic_levels run #$attempt ($(date '+%Y-%m-%d %H:%M:%S')) ====="

    rc=0
    "$VIVADO" -mode batch -nojournal -nolog \
        -source "$HERE/report_logic_levels.tcl" \
        -tclargs "$BUILD_DIR" "$MAX_PATHS" 2>&1 | tee "$LOG" || rc=$?

    # The Tcl prints "Done." only after iterating every design, so its presence
    # means the pass finished (even with per-design failures). Anything else is a
    # crash mid-pass -> relaunch and resume the remaining designs.
    if grep -q '^Done\.' "$LOG"; then
        echo "===== completed a full pass on attempt #$attempt; stopping ====="
        break
    fi

    echo "!! Vivado exited (rc=$rc) before finishing -- restarting in ${RETRY_DELAY}s ..." >&2
    sleep "$RETRY_DELAY"
done
