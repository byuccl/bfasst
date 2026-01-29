SHELL := /bin/bash
.SHELLFLAGS := -e -o pipefail -c

BFASST_ROOT := $(realpath .)
BFASST_EXTERNAL_TOOLS := $(BFASST_ROOT)/third_party
BFASST_SETUP := $(BFASST_ROOT)/setup
VENV_VARS := $(BFASST_ROOT)/bfasst.env
INITIAL_VARS := $(BFASST_SETUP)/env
PYTHON := $(or $(shell command -v python3.12), $(shell command -v python3.11), python3.10)
VENV_DIR := $(BFASST_ROOT)/.venv
VENV_BIN := $(VENV_DIR)/bin
VENV_ACTIVATE := $(VENV_BIN)/activate

# Create a place to store timestamp files for build recipes
SETUP_BUILD := $(BFASST_SETUP)/build
STAMP_DIR := $(SETUP_BUILD)/stamps
$(shell mkdir -p $(STAMP_DIR))

PY_STUBS := $(BFASST_ROOT)/bfasst/config_stubs.py $(BFASST_ROOT)/bfasst/paths_stubs.py

export BASH_ENV=$(VENV_ACTIVATE)

# Below also includes setup/helper_macros.mk
include $(BFASST_SETUP)/external_tools.mk

################################### Installation and Setup #########################################
.DEFAULT_GOAL: install
.PHONY: apt_packages install venv init_venv python_packages setup_autocomplete env_vars enable_pre_commit_hook
install: venv setup_autocomplete all_submodules

apt_packages:
	$(BFASST_SETUP)/install_packages.sh

clean:
	$(foreach installed, $(subst _updated, ,$(notdir $(SUBMOD_UPDATE_TARGETS))), \
		rm -f $($(call TO_UPPER, $(installed))_PATH)/.bfasst_installed; \
	)
	rm -rf $(VENV_DIR) $(VENV_VARS) $(PRE_COMMIT_HOOK) $(SETUP_BUILD)
	rm -rf $(JAVA_STUBS)
	git submodule deinit -f --all
	@echo "Environment removed. Please run 'deactivate' in your shell before rebuilding the virtual environment."

.NOTPARALLEL: $(VENV_ACTIVATE) $(VENV_VARS)

init_venv: $(VENV_ACTIVATE)
$(VENV_ACTIVATE) $(VENV_BIN) &:
	$(PYTHON) -m venv $(VENV_DIR) --prompt bfasst

python_packages: $(VENV_BIN)/cmake pyproject.toml
	python -m pip install -U pip
	python -m pip install -e .
	$(foreach stub,$(PY_STUBS),touch $(stub);)

MAKEFILE_ROOT := $(BFASST_ROOT)
env_vars: $(VENV_VARS)
$(VENV_VARS): $(VENV_ACTIVATE)
	export MAKEFILE_ROOT=$(MAKEFILE_ROOT); \
	envsubst '$$MAKEFILE_ROOT' < $(INITIAL_VARS)/general.env > $(VENV_VARS)
ifndef _load_project_env_vars
	echo 'BFASST_ENV_VARS=$(VENV_VARS)' > $(VENV_ACTIVATE).tmp
	echo 'source $(BFASST_SETUP)/env_vars.sh' >> $(VENV_ACTIVATE).tmp
	sed 's/^deactivate () {/deactivate () {\n    _restore_project_env_vars "$${1:-}"/' $(VENV_ACTIVATE) >> $(VENV_ACTIVATE).tmp
	echo -e '\n_load_project_env_vars "$(VENV_VARS)"' >> $(VENV_ACTIVATE).tmp
	mv $(VENV_ACTIVATE).tmp $(VENV_ACTIVATE)
endif

venv: $(VENV_ACTIVATE) $(VENV_VARS) python_packages

AUTO_COMPLETE := source $(BFASST_SETUP)/flow_autocomplete.sh
setup_autocomplete: $(VENV_ACTIVATE)
ifeq ($(shell grep -Fx "$(AUTO_COMPLETE)" "$(VENV_ACTIVATE)" 2>/dev/null),)
	flock $(VENV_VARS) -c 'echo -e "\n$(AUTO_COMPLETE)" >> "$(VENV_ACTIVATE)"'
endif

PRE_COMMIT_HOOK = "$(BFASST_ROOT)/.git/hooks/pre-commit"
enable_pre_commit_hook: $(PRE_COMMIT_HOOK)
$(PRE_COMMIT_HOOK):
	echo "#!/bin/bash" > $(PRE_COMMIT_HOOK)
	echo "make pre_commit" >> $(PRE_COMMIT_HOOK)
	chmod +x $(PRE_COMMIT_HOOK)
	@echo "Enabled pre-commit hook at $(PRE_COMMIT_HOOK)"

$(PY_STUBS) &: $(INITIAL_VARS)/*.env $(BFASST_SETUP)/generate_stubs.py
	python $(BFASST_SETUP)/generate_stubs.py --bfasst $(BFASST_ROOT)/bfasst
	git add $(PY_STUBS)

################################## Linting and Testing #############################################
.PHONY: pre_commit format pylint doctest unittest unittest_failfast

pre_commit: format doctest pylint

format:
	find ./scripts ./bfasst -iname "*.py" -exec black -q -l 100 {} +

pylint: format $(JAVA_STUBS) $(PY_STUBS)
	git fetch --no-recurse-submodules origin main
	pylint --errors-only $$(git ls-files --directory scripts --directory bfasst | grep -e ".py$$")
	pylint $$(git diff origin/main --diff-filter=AM --name-only | grep -e ".py$$")

doctest:
	find ./bfasst ./scripts -iname "*.py" -exec python -m doctest {} +

unittest:
	python -m unittest

unittest_failfast:
	python -m unittest -f

debug:
	@echo "MAKEFLAGS: $(MAKEFLAGS)"
	@echo "MAKECMDGOALS: $(MAKECMDGOALS)"
