#!/usr/bin/env bash
# scripts/setup_autocomplete.sh

REPO_ROOT="$(cd -- "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
VENV_ACTIVATE="$REPO_ROOT/.venv/bin/activate"
HELPER="$REPO_ROOT/scripts/flow_autocomplete.sh"

[[ -f $HELPER ]] || { echo "Missing $HELPER" >&2; exit 1; }
[[ -f $VENV_ACTIVATE ]] || { echo "Create the venv first: python -m venv .venv" >&2; exit 1; }

LINE="source \"$HELPER\"  # bfasst autocomplete"
grep -Fxq "$LINE" "$VENV_ACTIVATE" || echo "$LINE" >> "$VENV_ACTIVATE"

echo "Added autocomplete hook to .venv. Activate with: source .venv/bin/activate"

