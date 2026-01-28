#!/bin/bash
# Generates bootstrap rules file for all submodules
# Called when .gitmodules changes to regenerate the cached bootstrap rules
#
# Arguments:
#   $1 = Output file (bootstrap.mk)
#   $2 = STAMP_DIR
#   $3 = BFASST_ROOT
#   $4 = SUBMODULE_RULES_DIR
#   $5 = BFASST_SETUP
#   $6+ = submodule mappings in format "rel_path=configured_path"

set -e

OUTPUT_FILE="$1"
STAMP_DIR="$2"
BFASST_ROOT="$3"
SUBMODULE_RULES_DIR="$4"
BFASST_SETUP="$5"
shift 5

cat > "$OUTPUT_FILE" << 'HEADER'
# Auto-generated bootstrap rules for submodules
# Regenerated when .gitmodules changes - do not edit manually. See ${BFASST_SETUP}/generate_bootstrap_rules.sh

HEADER

# Generate bootstrap rules for each submodule
for mapping in "$@"; do
    rel_path="${mapping%%=*}"
    configured_path="${mapping#*=}"
    submod_name=$(basename "$rel_path")
    upper_name=$(echo "$submod_name" | tr '[:lower:]' '[:upper:]')
    cat >> "$OUTPUT_FILE" << EOF
${upper_name}_PATH ?= ${configured_path}
${upper_name}_BUILT := ${configured_path}/.bfasst_installed
${upper_name}_INSTALLED := ${STAMP_DIR}/${submod_name}_installed
${upper_name}_UPDATED := ${STAMP_DIR}/${submod_name}_updated
.PHONY: ${submod_name} update_${submod_name} ${submod_name}_post_install

${submod_name}_post_install: \$(${upper_name}_INSTALLED)
${submod_name}_post_install:	;

# Main install target - lazy: generate rule file if needed, then build
ifeq (\$(realpath ${SUBMODULE_RULES_DIR}/${submod_name}.mk),)
${submod_name}: | ${SUBMODULE_RULES_DIR}/${submod_name}.mk
	\$(MAKE) --no-print-directory ${submod_name}_post_install 
else
${submod_name}: ${submod_name}_post_install | ${SUBMODULE_RULES_DIR}/${submod_name}.mk
endif

# Internal target to generate rule file (triggers checkout if needed)
${SUBMODULE_RULES_DIR}/${submod_name}.mk: | ${configured_path}/.git
	@${BFASST_SETUP}/generate_submodule_rules.sh "${SUBMODULE_RULES_DIR}/${submod_name}.mk" "${STAMP_DIR}" "${BFASST_ROOT}" "${rel_path}=${configured_path}"

# Initial .git presence target - ensures submodule is checked out
${configured_path}/.git:
	@CONFIGURED_PATH="${configured_path}"; \\
	SUBMODULE_PATH="${BFASST_ROOT}/${rel_path}"; \\
	EXPECTED="\$\$(git ls-tree HEAD ${rel_path} 2>/dev/null | awk '{print \$\$3}')"; \\
	if [ -z "\$\$EXPECTED" ]; then \\
		echo "Error: No expected commit for ${submod_name}"; exit 1; \\
	fi; \\
	if [ "\$\$CONFIGURED_PATH" = "\$\$SUBMODULE_PATH" ]; then \\
		echo "Initial submodule checkout for ${submod_name}"; \\
		git submodule update --init --recursive --merge ${rel_path}; \\
	else \\
		echo "Cached submodule location detected for ${submod_name} at \$\$CONFIGURED_PATH"; \\
		URL=\$\$(git config --file .gitmodules --get-regexp submodule.${rel_path}.url | awk '{print \$\$2}'); \\
		if [ -z "\$\$URL" ]; then echo "Error: URL not found for ${rel_path}"; exit 1; fi; \\
		git clone --recurse-submodules "\$\$URL" "\$\$CONFIGURED_PATH"; \\
		git -C "\$\$CONFIGURED_PATH" checkout --recurse-submodules --force "\$\$EXPECTED"; \\
	fi
	touch ${STAMP_DIR}/${submod_name}_checkout

EOF
done

echo "Generated bootstrap rules: $OUTPUT_FILE"
