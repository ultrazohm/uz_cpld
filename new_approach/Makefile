.DEFAULT_GOAL := build
PYTHON ?= python3
TARGET ?= uz_dslot_xo2
TEMPLATE ?= tx30
# Quote values as single shell arguments, including embedded apostrophes.
quote = '$(subst ','"'"',$(1))'
ARGS = --target $(call quote,$(TARGET)) $(if $(PROGRAM),--program $(call quote,$(PROGRAM))) $(if $(TOOLCHAIN),--toolchain $(call quote,$(TOOLCHAIN)))
.PHONY: build list doctor new check project gui build-all clean test docs docs-local docs-assets-local netlist netlist-local sim sim-image sim-container test-container docs-container _sim
build list doctor check project gui build-all:
	$(PYTHON) -m toolchain.buildsystem $@ $(ARGS)
new:
	$(PYTHON) -m toolchain.buildsystem new $(ARGS) --name $(call quote,$(NAME)) --template $(call quote,$(TEMPLATE))
clean:
	$(PYTHON) -m toolchain.buildsystem clean $(ARGS) $(if $(filter 1,$(DISCARD_PROJECT_CHANGES)),--discard-project-changes)
test:
	$(PYTHON) -m unittest discover -s toolchain/tests -v
CONTAINER_ENGINE ?= docker
CONTAINER_PLATFORM ?= linux/amd64
CONTAINER_USERNS = $(if $(filter podman,$(notdir $(CONTAINER_ENGINE))),--userns=keep-id)
SIM_IMAGE ?= uz-cpld-toolchain
# Bind source for commands run from the host.
SIM_WORKSPACE ?= $(CURDIR)
SEED ?= 1
WAVE_FORMAT ?= vcd
CONTAINER_RUN = $(CONTAINER_ENGINE) run --rm --platform $(call quote,$(CONTAINER_PLATFORM)) $(CONTAINER_USERNS) --user "$$(id -u):$$(id -g)" --mount $(call quote,type=bind$(comma)source=$(SIM_WORKSPACE)$(comma)target=/work) -w /work $(call quote,$(SIM_IMAGE))
comma := ,
sim-image:
	@command -v $(CONTAINER_ENGINE) >/dev/null 2>&1 || { echo "Container engine missing. Install Docker on the host or reopen in the unified Dev Container." >&2; exit 1; }
	$(CONTAINER_ENGINE) build --platform $(call quote,$(CONTAINER_PLATFORM)) --target toolchain -f .devcontainer/Dockerfile -t $(call quote,$(SIM_IMAGE)) .
ifeq ($(CPLD_TOOLCHAIN_CONTAINER),1)
sim: _sim
test-container: test
docs: docs-local
netlist: netlist-local
else
sim: sim-image
	$(CONTAINER_RUN) make _sim $(if $(PROGRAM),PROGRAM=$(call quote,$(PROGRAM))) SEED=$(call quote,$(SEED)) WAVE_FORMAT=$(call quote,$(WAVE_FORMAT))
test-container: sim-image
	$(CONTAINER_RUN) make test
netlist: sim-image
	$(CONTAINER_RUN) make netlist-local $(if $(PROGRAM),PROGRAM=$(call quote,$(PROGRAM))) TARGET=$(call quote,$(TARGET))
docs: sim-image
	$(CONTAINER_RUN) make docs-local
endif
# Compatibility alias.
sim-container: sim
docs-container: docs
# Image-internal entry point. Never creates or selects a host virtual environment.
_sim:
	@test "$(CPLD_TOOLCHAIN_CONTAINER)" = "1" || { echo "Use 'make sim' to run in the simulation container." >&2; exit 1; }
	python3 -m pytest toolchain/simulation/test_simulation.py -v --junitxml=toolchain/build/simulation/junit.xml $(if $(PROGRAM),--program $(call quote,$(PROGRAM))) --seed $(call quote,$(SEED)) --wave-format $(call quote,$(WAVE_FORMAT))
netlist-local:
	$(PYTHON) -m toolchain.analysis.netlist --target $(call quote,$(TARGET)) $(if $(PROGRAM),--program $(call quote,$(PROGRAM)))
docs-assets-local:
	$(PYTHON) -m toolchain.analysis.documentation
docs-local: docs-assets-local
	$(PYTHON) -m toolchain.analysis.sitecheck --clean docs/_build/html
	$(PYTHON) -m sphinx -W --keep-going -b html docs docs/_build/html
	$(PYTHON) -m toolchain.analysis.sitecheck docs/_build/html
