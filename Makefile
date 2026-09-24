.DEFAULT_GOAL := build
python ?= python3
target ?= uz_dslot_xo2
template ?= tx30
backend ?= diamond
ifneq ($(backend),diamond)
ifneq ($(backend),foss)
$(error backend must be diamond or foss)
endif
endif
# Quote values as single shell arguments, including embedded apostrophes.
quote = '$(subst ','"'"',$(1))'
args = --target $(call quote,$(target)) $(if $(program),--program $(call quote,$(program))) --backend $(call quote,$(backend))
.PHONY: build list doctor new check project gui build-all clean clean-all test docs docs-local docs-assets-local netlist netlist-local sim sim-image test-container _sim
list check:
	$(python) -m toolchain.buildsystem $@ $(args)
# FOSS firmware commands use the same container dispatch as simulation on hosts.
ifeq ($(backend)$(filter 1,$(CPLD_TOOLCHAIN_CONTAINER)),foss)
build doctor project gui build-all: sim-image
	$(container_run) make $@ backend=foss $(if $(program),program=$(call quote,$(program))) target=$(call quote,$(target))
else
build doctor project gui build-all:
	$(python) -m toolchain.buildsystem $@ $(args)
endif
new:
	$(python) -m toolchain.buildsystem new $(args) --name $(call quote,$(name)) --template $(call quote,$(template))
clean:
	$(python) -m toolchain.buildsystem clean $(args) $(if $(filter 1,$(discard_project_changes)),--discard-project-changes)
clean-all:
	$(python) -m toolchain.buildsystem clean-all
test:
	$(python) -m unittest discover -s toolchain/tests -v
container_engine ?= docker
container_platform ?= linux/amd64
container_userns = $(if $(filter podman,$(notdir $(container_engine))),--userns=keep-id)
sim_image ?= uz-cpld-toolchain
# Bind source for commands run from the host.
sim_workspace ?= $(CURDIR)
seed ?= 1
wave_format ?= vcd
container_run = $(container_engine) run --rm --platform $(call quote,$(container_platform)) $(container_userns) --user "$$(id -u):$$(id -g)" --mount $(call quote,type=bind$(comma)source=$(sim_workspace)$(comma)target=/work) -w /work $(call quote,$(sim_image))
comma := ,
sim-image:
	@command -v $(container_engine) >/dev/null 2>&1 || { echo "Container engine missing. Install Docker on the host or reopen in the unified Dev Container." >&2; exit 1; }
	$(container_engine) build --platform $(call quote,$(container_platform)) --target toolchain -f .devcontainer/Dockerfile -t $(call quote,$(sim_image)) .
ifeq ($(CPLD_TOOLCHAIN_CONTAINER),1)
sim: _sim
test-container: test
docs: docs-local
netlist: netlist-local
else
sim: sim-image
	$(container_run) make _sim $(if $(program),program=$(call quote,$(program))) seed=$(call quote,$(seed)) wave_format=$(call quote,$(wave_format))
test-container: sim-image
	$(container_run) make test
netlist: sim-image
	$(container_run) make netlist-local $(if $(program),program=$(call quote,$(program))) target=$(call quote,$(target))
docs: sim-image
	$(container_run) make docs-local
endif
# Image-internal entry point. Never creates or selects a host virtual environment.
_sim:
	@test "$(CPLD_TOOLCHAIN_CONTAINER)" = "1" || { echo "Use 'make sim' to run in the simulation container." >&2; exit 1; }
	python3 -m pytest toolchain/simulation/test_simulation.py -v --junitxml=toolchain/build/simulation/junit.xml $(if $(program),--program $(call quote,$(program))) --seed $(call quote,$(seed)) --wave-format $(call quote,$(wave_format))
netlist-local:
	$(python) -m toolchain.analysis.netlist --target $(call quote,$(target)) $(if $(program),--program $(call quote,$(program)))
docs-assets-local:
	$(python) -m toolchain.analysis.documentation
docs-local: docs-assets-local
	$(python) -m toolchain.analysis.sitecheck --clean docs/_build/html
	$(python) -m sphinx -W --keep-going -b html docs docs/_build/html
	$(python) -m toolchain.analysis.sitecheck docs/_build/html
