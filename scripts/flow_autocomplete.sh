#!/usr/bin/env bash

SCRIPT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd -P)"
RUN_PY="$REPO_ROOT/scripts/run.py"
VENV_PY="$REPO_ROOT/.venv/bin/python"

flow_run() { "$VENV_PY" "$RUN_PY" "$@"; }

_bfasst_ac() {
    local cur; _get_comp_words_by_ref -n =: cur
    local flows; flows=$("$VENV_PY" "$RUN_PY" --list-flows 2>/dev/null | tr '\n' ' ')
    [[ -z $flows ]] && { compopt -o default; return; }

    local seen=0 w
    for w in "${COMP_WORDS[@]:1:$COMP_CWORD-1}"; do
        [[ " $flows " == *" $w "* ]] && { seen=1; break; }
    done

    if (( ! seen )); then
        COMPREPLY=( $(compgen -W "$flows" -- "$cur") )
    else
        compopt -o default
    fi
}
complete -F _bfasst_ac flow_run

