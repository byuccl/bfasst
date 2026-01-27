#!/bin/bash
# Generates a static submodule rule file for a single submodule
# Called lazily when a submodule is first requested
#
# Arguments:
#   $1 = Output file (setup/build/rules/<submodule>.mk)
#   $2 = STAMP_DIR
#   $3 = BFASST_ROOT
#   $4 = submodule mapping in format "rel_path=configured_path"

set -e

OUTPUT_FILE="$1"
STAMP_DIR="$2"
BFASST_ROOT="$3"
MAPPING="$4"

# Parse "rel_path=configured_path" format
rel_path="${MAPPING%%=*}"
configured_path="${MAPPING#*=}"
submod_name=$(basename "$rel_path")
submod_default_path="$BFASST_ROOT/$rel_path"

# Function to get git dependency files for a path
get_git_deps() {
    local configured_path="$1"
    local git_dir
    git_dir=$(git -C "$configured_path" rev-parse --git-dir 2>/dev/null) || return 0
    
    if [ -z "$git_dir" ]; then
        return 0
    fi
    
    local head_file="$git_dir/HEAD"
    if [ ! -f "$head_file" ]; then
        return 0
    fi
    
    local deps="$head_file"
    local head_content
    head_content=$(cat "$head_file" 2>/dev/null)
    
    # If HEAD points to a ref, add that ref file
    if [[ "$head_content" == ref:* ]]; then
        local ref_path="${head_content#ref: }"
        if [ -f "$git_dir/$ref_path" ]; then
            deps="$deps $git_dir/$ref_path"
        fi
    fi
    
    # Add packed-refs if it exists
    if [ -f "$git_dir/packed-refs" ]; then
        deps="$deps $git_dir/packed-refs"
    fi
    
    echo "$deps"
}

git_deps=$(get_git_deps "$configured_path")

# Generate the rule file
cat > "$OUTPUT_FILE" << EOF
# Auto-generated static rules for $submod_name
# Do not edit - regenerate by removing this file and rebuilding

# Static checkout rule with git dependencies for automatic rebuild detection
$STAMP_DIR/${submod_name}_checkout: $git_deps
EOF

if [ "$configured_path" = "$submod_default_path" ]; then
    # Standard submodule location - use git submodule update
    cat >> "$OUTPUT_FILE" << 'RULE_EOF'
	@EXPECTED="$$(git ls-tree HEAD RELPATH 2>/dev/null | awk '{print $$3}')"; \
	ACTUAL=$$(git -C "CONFIGURED" rev-parse HEAD 2>/dev/null || echo ""); \
	if [ "$$ACTUAL" != "$$EXPECTED" ]; then \
		echo "Updating SUBMOD_NAME to $$EXPECTED..."; \
		git submodule update --init --recursive --merge RELPATH; \
        rm -f "CONFIGURED/.bfasst_installed"; \
	fi
	@touch $@
RULE_EOF
else
    # Custom submodule location - use git fetch + checkout
    cat >> "$OUTPUT_FILE" << 'RULE_EOF'
	@EXPECTED="$$(git ls-tree HEAD RELPATH 2>/dev/null | awk '{print $$3}')"; \
	ACTUAL=$$(git -C "CONFIGURED" rev-parse HEAD 2>/dev/null || echo ""); \
	if [ "$$ACTUAL" != "$$EXPECTED" ]; then \
		echo "Updating SUBMOD_NAME to $$EXPECTED..."; \
		git -C "CONFIGURED" fetch --all; \
		git -C "CONFIGURED" checkout --recurse-submodules --force "$$EXPECTED"; \
        rm -f "CONFIGURED/.bfasst_installed"; \
	fi
	@touch $@
RULE_EOF
fi

# Apply substitutions
sed -i -e "s|RELPATH|$rel_path|g" \
       -e "s|CONFIGURED|$configured_path|g" \
       -e "s|SUBMOD_NAME|$submod_name|g" "$OUTPUT_FILE"

# Add dependency rules that link install/update to checkout
cat >> "$OUTPUT_FILE" << EOF

# Install depends on checkout being done.
$STAMP_DIR/${submod_name}_installed: | $STAMP_DIR/${submod_name}_checkout ${configured_path}/.bfasst_installed

# Update depends on checkout with git deps, and install being done
update_${submod_name}: $STAMP_DIR/${submod_name}_updated
$STAMP_DIR/${submod_name}_updated: $STAMP_DIR/${submod_name}_checkout | $STAMP_DIR/${submod_name}_installed
EOF

echo "Generated rule file: $OUTPUT_FILE"
