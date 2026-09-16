# All implementation lives in new_approach; command-line variables propagate.
.DEFAULT_GOAL := build
TARGETS := build list doctor new check project gui build-all clean test docs docs-local docs-assets-local netlist netlist-local sim sim-image sim-container test-container docs-container
.PHONY: $(TARGETS) forward
# One sub-make shares prerequisites across all requested targets, even with -j.
$(TARGETS): forward
forward:
	$(MAKE) -C new_approach $(if $(MAKECMDGOALS),$(filter $(TARGETS),$(MAKECMDGOALS)),build)
