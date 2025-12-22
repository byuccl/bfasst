#!/usr/bin/env bash

RUN_PY="$BFASST_SCRIPTS/run.py"
VENV_PY="$BFASST_ROOT/.venv/bin/python"

bfasst() { "$VENV_PY" "$RUN_PY" "$@"; }

_bfasst_ac() {
    local cur; _get_comp_words_by_ref -n =: cur
    local flows; flows=$("$VENV_PY" "$RUN_PY" --list-flows 2>/dev/null | tr '\n' ' ')
    [[ -z $flows ]] && { compopt -o default; return; }

    local seen=0 w
    for w in "${COMP_WORDS[@]:1:$COMP_CWORD-1}"; do
        [[ " $flows " == *" $w "* ]] && { seen=1; break; }
    done

    if (( ! seen )); then
        # Combine flows and file paths, handle directories
        local files
        files=$(compgen -f -- "$cur")
        local suggestions=()
        for f in $files; do
            if [[ -d $f ]]; then
                suggestions+=("$f/")
            else
                suggestions+=("$f")
            fi
        done
        COMPREPLY=( $(compgen -W "$flows" -- "$cur") "${suggestions[@]}" )
        # Prevent space after directory completion
        compopt -o nospace
    else
        compopt -o default
    fi
}
complete -F _bfasst_ac bfasst
