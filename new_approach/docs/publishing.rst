Build and publish documentation
===============================

Local build
-----------

::

   make docs

The host command builds the ``toolchain`` image and runs simulation, netlist analysis and Sphinx inside it without Diamond, license mounts, host networking or developer CLI installation.
Inside a Dev Container, the command uses installed tools directly.
``make docs-container`` is an alias, and ``make docs-local`` explicitly selects native tools.
Dependencies come from ``docs/requirements.txt`` and its referenced files in both the image and native setup.

The complete site is ``docs/_build/html/``; it includes SVGs, PDFs, VCD downloads and self-contained waveform HTML.
Relative links support repository subpaths such as ``/uz_cpld/``.
The Actions deployment serves prebuilt HTML directly, including underscore-prefixed assets.
Sphinx also writes ``.nojekyll`` for manual branch-based publishing; the preview artifact preserves this marker, while the Pages upload action excludes dotfiles.
Each build clears the HTML output to prevent removed pages or archived transcripts from remaining in a published site.
The build checks local page, image, iframe and download links for missing files and paths that escape the project site.

GitHub Pages
------------

The repository workflow ``.github/workflows/toolchain.yml`` builds the image, runs tooling tests and generates documentation in separate steps.
Pull requests and branch pushes produce review artifacts without publishing.
Successful pushes or manual runs on the repository's default branch upload a Pages artifact and deploy through the ``github-pages`` environment.
The default-branch condition follows repository metadata rather than assuming a branch name.

Enable **Settings → Pages → Build and deployment → Source: GitHub Actions** once in the GitHub repository.
Allow the default branch in the ``github-pages`` environment and satisfy any repository approval rules.
The deployment job uses ``pages: write`` and ``id-token: write``; the build job needs only read access to repository contents.
The deployment URL appears in the workflow's environment result, with ``https://ultrazohm.github.io/uz_cpld/`` as the standard project-site address unless repository settings specify a custom domain.

The workflow uploads only the generated HTML site for deployment, retaining build diagnostics separately.
It does not compile or publish firmware.
A configured workflow is not evidence of a successful hosted deployment; verify the GitHub Actions run after merging it.

Maintenance
-----------

Keep prose concise and factual, with tradeoffs in :doc:`architecture` and open work in :doc:`roadmap`.
Use one sentence per RST source line with no manual wrapping; code blocks and directive/table syntax retain their required structure.
README files point to this Sphinx project rather than duplicating instructions.
OS packages and the base image tag are mutable; pinning image digests and package snapshots improves reproducibility at the cost of an explicit update process.

References
----------

* `GitHub Pages custom workflows <https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages>`_
* `Sphinx GitHub Pages extension <https://www.sphinx-doc.org/en/master/usage/extensions/githubpages.html>`_
