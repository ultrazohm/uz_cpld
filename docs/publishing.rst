Build and publish documentation
===============================

Local build
-----------

::

   make docs release_cycle=all

Run this command inside the configured Dev Container or a native environment with simulation, analysis and Sphinx dependencies installed.
Documentation commands use the calling environment and do not start a container.
Dependencies come from ``pyproject.toml`` and ``uv.lock`` in both the image and native setup.

The complete site is ``docs/_build/html/``; it includes SVGs, PDFs, VCD downloads and self-contained waveform HTML.
Relative links support repository subpaths such as ``/uz_cpld/``.
The Actions deployment serves prebuilt HTML directly, including underscore-prefixed assets.
Sphinx also writes ``.nojekyll`` for manual branch-based publishing; the preview artifact preserves this marker, while the Pages upload action excludes dotfiles.
Each build clears the HTML output to ensure the published site contains only the generated pages and assets.
The build checks local page, image, iframe and download links for missing files and paths that escape the project site.

GitHub Pages
------------

The repository workflow ``.github/workflows/toolchain.yml`` builds the image and
runs ``bash ci.sh`` inside it for tooling tests, FOSS firmware, simulations and
documentation. The same command runs the Linux CI checks locally.
Pull requests and pushes to other branches produce documentation review artifacts without deploying Pages.
Successful Linux checks on pushes or manual runs on ``master`` upload a Pages artifact; deployment through the ``github-pages`` environment also requires successful Windows checks.
Both the artifact upload and deployment conditions select this branch explicitly.
See :doc:`builds` for the complete CI and firmware pipeline task inventory.
See :doc:`developer/ci-review` for known CI gaps, log explanations and suggested fixes.

Enable **Settings → Pages → Build and deployment → Source: GitHub Actions** once in the GitHub repository.
Allow ``master`` in the ``github-pages`` environment deployment branch rules and satisfy any repository approval rules.
The deployment job uses ``pages: write`` and ``id-token: write``; the build job needs only read access to repository contents.
The deployment URL appears in the workflow's environment result, with ``https://ultrazohm.github.io/uz_cpld/`` as the standard project-site address unless repository settings specify a custom domain.

The workflow uploads only the generated HTML site for deployment, retaining build diagnostics separately.
FOSS firmware and reports are retained as workflow artifacts and excluded from the Pages site.
The diagnostics artifact includes the updated ``programs/usercodes.json`` registry so CI-allocated identities can be resolved alongside the firmware.
CI does not commit allocations back to Git or coordinate counters between independent runs.
Reconcile CI allocations with the shared branch to maintain globally unique revisions; artifact retention alone does not guarantee uniqueness.
ZIP programming uses the archive's registry for that run and reports conflicts with the local registry.
A configured workflow is not evidence of a successful hosted deployment; verify the GitHub Actions run after pushing the workflow to the deployment branch.

Firmware downloads
------------------

Branch pushes, including feature branches, request publication of ``uz-cpld-firmware.zip`` through GitHub Releases after Diamond, Linux and Windows checks succeed. Tag pushes do not publish testing releases.
The release is marked as a testing prerelease, never as the latest stable release.
Its tag is ``firmware-ci-<run_id>-<run_attempt>`` and points to the pushed commit; reruns receive a new tag rather than replacing a previous archive.
The workflow uses ``GITHUB_TOKEN`` with ``contents: write`` for publication; the private Diamond image still requires ``DIAMOND_GHCR_TOKEN``.
Tags created by this token do not recursively trigger push workflows.
Manual runs retain the archive as an Actions artifact but do not publish it.

The ZIP contains ``<release>/<program>/<target>/*.bit``, matching ``.jed`` files, and ``manifest.json``.
Local ``build``, ``build_all`` and ``build_selection`` use the same exporter and manifest schema,
writing firmware directly to ``build/<backend>/<release>/<program>/<target>/``
and updating ``build/<backend>/manifest.json`` without a second firmware copy.
CI writes its combined archive to ``build/uz-cpld-firmware.zip``.
See :doc:`builds` for manifest indexing and the unified output layout.
The manifest records the source commit, all selected releases, firmware checksums, build provenance and a snapshot of the existing identity registry.
Packaging rejects missing, failed or stale builds, mismatched firmware hashes, and builds from another commit.
An incomplete catalog never produces a published archive.
All release catalogs share one Diamond image build and one checkout, so identity allocations from that run are retained together.

Use ``uz_cpld program --target s3c --source zip --firmware PATH.zip`` to program directly from a verified archive, using the assignments in ``selection.toml``.
This validates the archive's provenance and identity registry without matching local sources or builds; the default ``source=local`` retains local-build validation.
See :doc:`programmer` for release selection, backend compatibility and run records.
Registry counters are not coordinated across independent CI runs, and prerelease firmware has no established hardware or board timing acceptance.
The 14-day retention period applies to Actions diagnostics and preview artifacts; GitHub Release archives are separate downloads.
The publication job also waits for native standalone CLI builds, then attaches tool-only and tool-plus-firmware archives for Windows and Ubuntu alongside the unchanged firmware-only ZIP and checksums.
See :doc:`standalone` for the application downloads and persistent configuration.

Downloading branch firmware
---------------------------

In the repository CLI, ``uz_cpld firmware_download`` downloads the newest published CI firmware for the
current Git branch. It reads the configured tracking remote and upstream branch,
or defaults to ``origin`` and the local branch name. ``--remote NAME`` selects a
different GitHub remote; ``--output FILE`` overrides the ZIP destination.
GitHub HTTPS and SSH repository URLs are supported.
Git is required when repository or branch information must be discovered from the checkout; Diamond, the GitHub CLI and programmer tools are not required.
The standalone application instead defaults to ``ultrazohm/uz_cpld`` on ``master`` and never needs Git; its repository and branch overrides are optional and independent.

Supply both overrides to download without Git or a checkout::

   make firmware_download git_url=https://github.com/ultrazohm/uz_cpld.git branch=master
   uz_cpld firmware_download --git-url https://github.com/ultrazohm/uz_cpld.git --branch master

``git_url`` replaces the remote URL and cannot be combined with ``remote``.
``branch`` overrides branch selection and accepts either a branch name or ``refs/heads/NAME``; tags are not accepted.
When only one override is supplied, checkout discovery supplies the other value.
Existing root discovery and output locations are unchanged; ``output=PATH`` can select the destination explicitly.

The command searches all release pages, includes prereleases, excludes drafts and
requires the uploaded ``uz-cpld-firmware.zip`` asset. Only releases whose CI notes
record the exact matching ``Source ref: refs/heads/<branch>`` are considered.
The newest is selected by publication time. A local branch may be ahead of its
last published build; the selected release tag and source commit are printed.
A detached HEAD without an explicit branch, or a branch without published firmware, produces an error.

Public repositories can be accessed without authentication. Set ``GH_TOKEN`` or
``GITHUB_TOKEN`` for private repositories or authenticated API access, with repository
Contents read permission. Tokens are not passed to Git or forwarded to asset storage
hosts on redirects. The implementation uses the `GitHub Releases API
<https://docs.github.com/en/rest/releases/releases#list-releases>`_.

By default the ZIP is saved to ``build/downloads/<release-tag>/uz-cpld-firmware.zip``.
The download is staged and checked before replacing the destination: asset size,
GitHub SHA-256 digest when supplied, manifest schema/source commit, and every firmware
checksum must match. Failed downloads preserve any existing destination file.
The ZIP is not extracted; local builds, selections and ``programs/usercodes.json`` are
not modified. Programming from that ZIP is a separate explicit ``program --source zip --firmware PATH.zip`` command.

Maintenance
-----------

Document the tool's current commands, behavior, inputs, outputs and limits.
Keep change history, migration notes and development progress out of user guides.
Keep prose concise and factual; :doc:`architecture` describes the implementation.
Use one sentence per RST source line with no manual wrapping; code blocks and directive/table syntax retain their required structure.
README files point to this Sphinx project rather than duplicating instructions.
OS packages and the base image tag are mutable environmental inputs.

References
----------

* `GitHub Pages custom workflows <https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages>`_
* `Sphinx GitHub Pages extension <https://www.sphinx-doc.org/en/master/usage/extensions/githubpages.html>`_
