"""Sphinx configuration; API imports do not invoke Diamond."""
from pathlib import Path
import sys
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
project = 'UltraZohm CPLD build and simulation'
author = 'UltraZohm contributors'
release = '0.1'
extensions = ['sphinx.ext.autodoc', 'sphinx.ext.viewcode', 'sphinx.ext.githubpages',
              'sphinxcontrib.mermaid']
master_doc = 'index'
exclude_patterns = ['_build', '_generated/static', 'logs/hardware-test-20261007/files']
html_extra_path = ['_generated/static']
html_theme = 'furo'
autodoc_member_order = 'bysource'

# Document the pytest runner without requiring a simulator installation.
autodoc_mock_imports = ["cocotb_tools"]
