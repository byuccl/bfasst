#!/bin/bash
### Load vars provided in ${1}, preserving previous var state
_load_project_env_vars() {
    declare -gA _OLD_VARS
    declare -ga _UNSET_VARS
    if [ -f "${1:-}" ]; then
        while IFS= read -r line || [ -n "$line" ]; do
            # key is everything before the first '='
            key="${line%%=*}"
            # check if key exists in the current environment
            if [[ -v $key ]]; then
                _OLD_VARS[$key]="${!key}"
            else
                _UNSET_VARS+=("$key")
            fi
            eval "$line"
            export "$key"
        done < <(egrep -v '^([[:space:]]*#|[[:space:]]*$)' "${1}")
    fi
}

# Restore vars to state before call to _load_project_env_vars.
# Optionally unload vars in this script with "nondestructive" argument
_restore_project_env_vars() {
    if [ -n "${_OLD_VARS:-}" ] ; then
        for key in "${!_OLD_VARS[@]}"; do
            export "$key=${_OLD_VARS[$key]}"
        done
        unset _OLD_VARS[@]
    fi
    if [ -n "${_UNSET_VARS:-}" ] ; then
        for key in "${_UNSET_VARS[@]}"; do
            unset "$key"
        done
        _UNSET_VARS=()
    fi
    if [ ! "${1:-}" = "nondestructive" ] ; then
        unset -f _load_project_env_vars
        unset -f _restore_project_env_vars
        unset _OLD_VARS
        unset _UNSET_VARS
        unset BFASST_ENV_VARS
    fi
}