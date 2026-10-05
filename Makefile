# Public command definitions and help live in cpld_toolchain/toolchain/commands.py.
.DEFAULT_GOAL := $(if $(program),build,help)
python ?= python3
command_root := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
quote = '$(subst ','"'"',$(1))'
# Forward explicit options, including unknown names, so typos cannot be ignored.
command_options = $(filter-out python,$(foreach key,$(.VARIABLES),$(if $(filter command line,$(origin $(key))),$(key))))
command_cli = PYTHONPATH=$(call quote,$(command_root))"$${PYTHONPATH:+:$$PYTHONPATH}" $(python) -m cpld_toolchain --make-help
ifneq ($(word 2,$(MAKECMDGOALS)),)
$(error Use one action per invocation: make ACTION key=value. Use make scan, make identify, make program, or make programmer-project instead of grouped programmer commands)
endif
commands := help image setup venv doctor list build-all report init programmer-project scan identify program new generate check build compare project gui sim netlist docs docs-assets test release-list release-new release-select usercodes usercodes-assign flasher-build clean clean-all
# Single-action aliases preserve existing automation while help shows canonical names.
aliases := programmer lattice_xcf release-current flasher docs-local docs-assets-local netlist-local _sim
.PHONY: $(commands) $(aliases)
$(commands) $(aliases):
	@$(command_cli) $@ $(foreach key,$(command_options),--option $(call quote,$(key)=$($(key))))
.DEFAULT:
	@$(command_cli) $(call quote,$@) $(foreach key,$(command_options),--option $(call quote,$(key)=$($(key))))
