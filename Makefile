# Public command definitions and help live in cpld_toolchain/toolchain/commands.py.
.DEFAULT_GOAL := $(if $(program),build,help)
python ?= python3
command_root := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
quote = '$(subst ','"'"',$(1))'
# Forward explicit options, including unknown names, so typos cannot be ignored.
command_options = $(filter-out python,$(foreach key,$(.VARIABLES),$(if $(filter command line,$(origin $(key))),$(key))))
command_cli = PYTHONPATH=$(call quote,$(command_root))"$${PYTHONPATH:+:$$PYTHONPATH}" $(python) -m cpld_toolchain --make-help
ifneq ($(word 2,$(MAKECMDGOALS)),)
$(error Use one action per invocation: make ACTION key=value. Use make scan, make identify, make program, or make diamond_xcf_programming_chain instead of grouped programmer commands)
endif
commands := help image setup venv doctor list build_all build_selection report init_programmer diamond_xcf_programming_chain scan identify program new generate check build compare project gui sim netlist docs docs_assets test release_list release_new release_select usercodes usercodes_assign flasher_build clean clean_all
# Single-action aliases preserve existing automation while help shows canonical names.
aliases := programmer lattice_xcf release_current flasher docs_local docs_assets_local netlist_local _sim
.PHONY: $(commands) $(aliases)
$(commands) $(aliases):
	@$(command_cli) $@ $(foreach key,$(command_options),--option $(call quote,$(key)=$($(key))))
.DEFAULT:
	@$(command_cli) $(call quote,$@) $(foreach key,$(command_options),--option $(call quote,$(key)=$($(key))))
