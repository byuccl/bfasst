####################################################################################################
# Helper Macros for build recipes and submodule management
####################################################################################################
############################################ General ###############################################
# Auto enable parallel make
ifeq ($(MAKELEVEL),0)
  PARALLEL := $(or $(findstring j,$(firstword -$(MAKEFLAGS))),$(filter -j%,$(MAKEFLAGS)))
  ifeq ($(PARALLEL),)
    CORES := $(shell echo $$(($$(nproc 2>/dev/null) / 2 )) || echo 1)
    ifeq ($(CORES),0)
	  CORES := 1
    endif
    MAKEFLAGS += -j$(CORES)  --output-sync
  endif
endif

# Macro to convert to uppercase
define TO_UPPER
$(shell echo $(1) | tr '[:lower:]' '[:upper:]')
endef

# Macro to convert to lowercase
define TO_LOWER
$(shell echo $(1) | tr '[:upper:]' '[:lower:]')
endef

########################################### Multi-threaded File Ops ################################
# Macro for multi-threaded safe file appending. Uses a temp file to aggregate writes so only one file lock is needed.
# Usage: $(call APPEND_MT, \
			echo "#Writing new vars"; \
			cat "$(SOME_FILE)"; \
			<more commands>; \
			, $(FILE_TO_APPEND_TO) )
# Does not support commas in the commands. (perceived as function argument separator)
define APPEND_MT
	tmp=$$(mktemp); \
	{ \
		$(1) \
	} >> $$tmp; \
	flock $(2) -c "cat $$tmp >> $(2)"; \
	rm -f $$tmp
endef

# Expansion for auto-formatted header/footer for tool sections
define TOOL_HEADER
# $(call TO_UPPER,$(1)) ENV VARS
endef

define TOOL_FOOTER
# END $(call TO_UPPER,$(1)) ENV VARS
endef

# Macro for removing env vars
# Usage: $(call REMOVE_ENV_VARS,tool_name,var_file) - Avoid spaces between the commas
# Finds # tool_name ENV VARS section and removes it from var_file (section ends with # END tool_name ENV VARS)
define REMOVE_ENV_VARS
	tmp=$$(mktemp); \
	sed '/$(call TOOL_HEADER,$(1))/,/$(call TOOL_FOOTER,$(1))/d' $(2) > $$tmp; \
	flock $(2) -c "mv $$tmp $(2)"
endef

# Macro for adding env vars from file.
# Usage: $(call ADD_ENV_VARS,tool_name,template_file,dest_file,var_list) - Avoid spaces between the commas
# Any references '$VAR_NAME' in file will be replaced with the Make variable value of VAR_NAME
# Safe to run multiple times; existing sections will be replaced.
define ADD_ENV_VARS
	$(foreach cmd, $(4), export $(cmd)=$($(cmd));) \
	tmp=$$(mktemp); \
	sed '/$(call TOOL_HEADER,$(1))/,/$(call TOOL_FOOTER,$(1))/d' $(3) > $$tmp; \
	{ \
		printf "\n%s\n" "$(call TOOL_HEADER,$(1))"; \
		envsubst '$(addprefix $$,$(4))' < $(2) ; \
		echo "$(call TOOL_FOOTER,$(1))"; \
	} >> $$tmp; \
	flock $(3) -c "cat $$tmp > $(3)"; \
	rm -f $$tmp
endef

########################## Submodule Tools & Git Helpers ###########################################
READ_GITMODULES = git config --file .gitmodules --get-regexp
# Infer submodule variables and their targets, default to .gitmodules, but allow environment variable overrides.
ALL_SUBMODULES := $(shell $(READ_GITMODULES) path | awk '{print $$2}')
PRIVATE_SUBMODULES := $(shell $(READ_GITMODULES) active | grep "false" | awk -F . '{print $$2}')
SUBMODULES := $(filter-out $(PRIVATE_SUBMODULES),$(ALL_SUBMODULES))
# Submodules is now a list of relative paths to each active submodule from the project root.

# Directory for per-submodule rule files (lazy generated)
SUBMODULE_RULES_DIR := $(SETUP_BUILD)/submodule_rules
# Cached bootstrap rules file - regenerated when .gitmodules changes
BOOTSTRAP_RULES_FILE := $(SETUP_BUILD)/bootstrap.mk

# _PATH -> location of submodule (allows environment override)
# _INSTALLED -> timestamp file indicating installation is complete
# _UPDATED -> timestamp file indicating last update is complete
# Create install and update rules for each submodule
ifeq ($(wildcard $(BOOTSTRAP_RULES_FILE)),)
$(foreach submodule,$(ALL_SUBMODULES),\
  $(eval $(call TO_UPPER, $(notdir $(submodule))_PATH) ?= $(BFASST_ROOT)/$(submodule)) \
  $(eval $(call TO_UPPER, $(notdir $(submodule))_INSTALLED) := $(STAMP_DIR)/$(notdir $(submodule))_installed) \
  $(eval $(call TO_UPPER, $(notdir $(submodule))_UPDATED) := $(STAMP_DIR)/$(notdir $(submodule))_updated))
endif

# Generate bootstrap rules for all submodules (cached - regenerates when .gitmodules changes)
# Bootstrap rules file provides the lazy targets; per-submodule rules generated on demand
$(BOOTSTRAP_RULES_FILE): .gitmodules
	@mkdir -p $(SUBMODULE_RULES_DIR)
	@$(BFASST_SETUP)/generate_bootstrap_rules.sh "$@" "$(STAMP_DIR)" "$(BFASST_ROOT)" "$(SUBMODULE_RULES_DIR)" "$(BFASST_SETUP)" $(foreach sm,$(ALL_SUBMODULES),"$(sm)=$($(call TO_UPPER,$(notdir $(sm)))_PATH)")

# Include bootstrap rules (generates if missing/outdated)
include $(BOOTSTRAP_RULES_FILE)

# Default rule to show a submodule external to bfasst was configured by bfasst or for no install steps after clone
%_installed: 
	touch $@

# Default rule for no rebuild steps after submodule update
%_updated: 
	touch $@

clean_%:
	$(info Removing all generated files for submodule $* and removing any tool additions to VENV_VARS and VENV_ACTIVATE)
	@$(call REMOVE_ENV_VARS,$*,$(VENV_VARS))
	@$(call REMOVE_ENV_VARS,$*,$(VENV_ACTIVATE))
	rm -f $(STAMP_DIR)/$**
	rm -f $(SUBMODULE_RULES_DIR)/$*.mk
	git submodule deinit -f $$($(READ_GITMODULES) $*.path | awk '{print $$2}')

# Include per-submodule auto-generated rules, if existing
-include $(SUBMODULE_RULES_DIR)/*.mk

INSTALL_RECIPES := $(notdir $(SUBMODULES))
SUBMOD_MAKEFILES := $(foreach submodule,$(SUBMODULES),$(SUBMODULE_RULES_DIR)/$(notdir $(submodule)).mk)
SUBMOD_INSTALL_TARGETS := $(foreach submodule,$(SUBMODULES), $(STAMP_DIR)/$(notdir $(submodule))_installed)
SUBMOD_UPDATE_TARGETS := $(foreach target,$(SUBMOD_INSTALL_TARGETS),$(patsubst %_installed,%_updated, $(wildcard $(target))))
