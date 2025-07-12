#!/bin/bash

BASHRC="$HOME/.bashrc"
AUTOCOMP_SCRIPT="$HOME/.bfasst_autocomplete.sh"

# Only add line if it's not already in bashrc
add_if_missing() {
    local line="$1"
    grep -Fxq "$line" "$BASHRC" || echo "$line" >> "$BASHRC"
}

# Write everything into the autocomplete file
cat > "$AUTOCOMP_SCRIPT" << 'EOF'
function run_flow {
    python ~/bfasst/scripts/run.py "$@"
}

_bfasst_run_autocomplete() {
    local cur prev
    _get_comp_words_by_ref -n =: cur prev

    # ---------- list of flow names ----------
    local flows
    flows=$(python ~/bfasst/scripts/run.py --list-flows 2>/dev/null)

    # ---------- have we already seen a real flow name? ----------
    local seen_flow=0
    local w
    for w in "${COMP_WORDS[@]:1:$COMP_CWORD-1}"; do
        [[ " $flows " == *" $w "* ]] && { seen_flow=1; break; }
    done

    # ---------- if we have NOT seen a flow yet -> suggest flows ----------
    if (( ! seen_flow )); then
        COMPREPLY=( $(compgen -W "$flows" -- "$cur") )
        return
    fi

    # ---------- otherwise normal path completion ----------
    compopt -o default          # fallback to builtin completion
}

complete -F _bfasst_run_autocomplete run_flow
EOF

# Add source line to bashrc if not already there
add_if_missing ""
add_if_missing "# bfasst run_flow autocomplete"
add_if_missing "source ~/.bfasst_autocomplete.sh"

echo "Added run_flow function and autocompletion to $BASHRC"
echo "Run 'source ~/.bashrc' or restart your terminal to activate."

