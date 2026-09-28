.DEFAULT_GOAL := $(if $(program),build,help)
python ?= python3
target ?=
template ?= tx30
backend ?= diamond
ifneq ($(backend),diamond)
ifneq ($(backend),foss)
$(error backend must be diamond or foss)
endif
endif
# Quote values as single shell arguments, including embedded apostrophes.
quote = '$(subst ','"'"',$(1))'
release_args = $(if $(release_cycle),--release-cycle $(call quote,$(release_cycle)))
release_make = $(if $(release_cycle),release_cycle=$(call quote,$(release_cycle)))
args = $(release_args) $(if $(target),--target $(call quote,$(target))) $(if $(program),--program $(call quote,$(program))) --backend $(call quote,$(backend))
.PHONY: release-list release-new release-current help build list doctor new generate check project gui build-all report programmer-project clean clean-all test docs docs-local docs-assets-local netlist netlist-local sim image test-container _sim
help:
	@printf '%-31s %s\n' \
	  'make [help]' 'Show all commands (default without program)' \
	  'make program=NAME' 'Build one program (default with program)' \
	  'make build program=NAME' 'Build one program' \
	  'make build-all' 'Build the program catalog' \
	  'make report' 'Summarize existing catalog build evidence' \
	  'make programmer-project selection=FILE' 'Generate D-slot and S3C XCF files' \
	  'make list' 'List catalog programs in the selected cycle' \
	  'make release-list' 'List release cycles and the current selection' \
	  'make release-new name=NAME [from=CYCLE]' 'Create a cycle and make it current' \
	  'make release-current release_cycle=NAME' 'Select the default cycle' \
	  'make check program=NAME' 'Validate one program' \
	  'make doctor' 'Check the selected firmware tools' \
	  'make new name=NAME' 'Clone a program and add it to the catalog' \
	  'make new name=NAME template=generator' 'Create editable routing and generator configuration' \
	  'make generate program=NAME' 'Generate project files and register the program' \
	  'make project program=NAME' 'Prepare a firmware project' \
	  'make gui program=NAME' 'Open the Diamond project GUI' \
	  'make sim [program=NAME]' 'Run HDL simulations' \
	  'make netlist [program=NAME]' 'Export RTL diagrams' \
	  'make docs' 'Generate and build documentation' \
	  'make test' 'Run tooling tests with installed tools' \
	  'make test-container' 'Run tooling tests in the container' \
	  'make clean program=NAME' 'Remove one firmware build' \
	  'make clean-all' 'Remove generated files and caches' \
	  'make image' 'Build the toolchain container image' \
	  'make netlist-local' 'Export diagrams with installed tools' \
	  'make docs-assets-local' 'Generate program documentation assets' \
	  'make docs-local' 'Build documentation with installed tools'
	@printf '%s\n' '' 'Options: release_cycle=NAME template_release_cycle=NAME backend=diamond|foss target=uz_dslot_xo2|uz_s3c_xo2 template=tx30 selection=FILE rebuild=1 seed=1 wave_format=vcd|ghw|fst jobs=4'
release-list release-current:
	$(python) -m toolchain.buildsystem $@ $(release_args)
release-new:
	$(python) -m toolchain.buildsystem $@ --name $(call quote,$(name)) $(if $(from),--from $(call quote,$(from)))
list check report generate:
	$(python) -m toolchain.buildsystem $@ $(args)
programmer-project:
	$(python) -m programmer_helper $(release_args) $(if $(selection),--selection $(call quote,$(selection)),--slot $(call quote,1=$(slot1)) --slot $(call quote,2=$(slot2)) --slot $(call quote,3=$(slot3)) --slot $(call quote,4=$(slot4)) --slot $(call quote,5=$(slot5)) --s3c $(call quote,$(s3c))) $(if $(filter 1,$(rebuild)),--build)
# FOSS firmware commands use the same container dispatch as simulation on hosts.
ifeq ($(backend)$(filter 1,$(CPLD_TOOLCHAIN_CONTAINER)),foss)
build doctor project gui build-all: image
	$(container_run) make $@ $(release_make) backend=foss $(if $(program),program=$(call quote,$(program))) target=$(call quote,$(target))
else
build doctor project gui build-all:
	$(python) -m toolchain.buildsystem $@ $(args)
endif
new:
	$(python) -m toolchain.buildsystem new $(args) --name $(call quote,$(name)) --template $(call quote,$(template)) $(if $(template_release_cycle),--template-release-cycle $(call quote,$(template_release_cycle)))
clean:
	$(python) -m toolchain.buildsystem clean $(args) $(if $(filter 1,$(discard_project_changes)),--discard-project-changes)
clean-all:
	$(python) -m toolchain.buildsystem clean-all
test:
	$(python) -m unittest discover -s cpld_vhdl_generator/tests -v
	$(python) -m unittest discover -s toolchain/tests -v
	$(python) -m unittest discover -s programmer_helper/tests -v
container_engine ?= docker
container_platform ?= linux/amd64
container_userns = $(if $(filter podman,$(notdir $(container_engine))),--userns=keep-id)
toolchain_image ?= uz-cpld-toolchain
# Bind source for commands run from the host.
sim_workspace ?= $(CURDIR)
seed ?= 1
wave_format ?= vcd
jobs ?= 4
container_run = $(container_engine) run --rm --platform $(call quote,$(container_platform)) $(container_userns) --user "$$(id -u):$$(id -g)" --mount $(call quote,type=bind$(comma)source=$(sim_workspace)$(comma)target=/work) -w /work $(call quote,$(toolchain_image))
comma := ,
image:
	@command -v $(container_engine) >/dev/null 2>&1 || { echo "Container engine missing. Install Docker on the host or reopen in the unified Dev Container." >&2; exit 1; }
	$(container_engine) build --platform $(call quote,$(container_platform)) --target toolchain -f .devcontainer/Dockerfile -t $(call quote,$(toolchain_image)) .
ifeq ($(CPLD_TOOLCHAIN_CONTAINER),1)
sim: _sim
test-container: test
docs: docs-local
netlist: netlist-local
else
sim: image
	$(container_run) make _sim $(release_make) $(if $(program),program=$(call quote,$(program))) seed=$(call quote,$(seed)) wave_format=$(call quote,$(wave_format)) jobs=$(call quote,$(jobs))
test-container: image
	$(container_run) make test
netlist: image
	$(container_run) make netlist-local $(release_make) $(if $(program),program=$(call quote,$(program))) target=$(call quote,$(target))
docs: image
	$(container_run) make docs-local $(release_make) jobs=$(call quote,$(jobs))
endif
# Image-internal entry point. Never creates or selects a host virtual environment.
_sim:
	@test "$(CPLD_TOOLCHAIN_CONTAINER)" = "1" || { echo "Use 'make sim' to run in the simulation container." >&2; exit 1; }
	@cycle="$$( $(python) -c 'from pathlib import Path; import sys; from toolchain.buildsystem.model import resolve_release; print(resolve_release(Path.cwd(), sys.argv[1] or None))' $(call quote,$(release_cycle)))" && \
	$(python) -m pytest toolchain/simulation/test_simulation.py -v -n $(call quote,$(jobs)) --junitxml="toolchain/build/simulation/$$cycle/junit.xml" $(if $(program),--program $(call quote,$(program))) --release-cycle "$$cycle" --seed $(call quote,$(seed)) --wave-format $(call quote,$(wave_format))
netlist-local:
	$(python) -m toolchain.analysis.netlist $(release_args) $(if $(target),--target $(call quote,$(target))) $(if $(program),--program $(call quote,$(program)))
docs-assets-local:
	$(python) -m toolchain.analysis.documentation $(release_args) --jobs $(call quote,$(jobs))
docs-local: docs-assets-local
	$(python) -m toolchain.analysis.sitecheck --clean docs/_build/html
	LC_ALL=C.UTF-8 $(python) -m sphinx -W --keep-going -b html docs docs/_build/html
	$(python) -m toolchain.analysis.sitecheck docs/_build/html
