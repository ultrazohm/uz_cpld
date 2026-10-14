"""Standalone, deterministic VHDL generation with no build-tool dependencies."""

__version__ = "0.5.0"

from .generator import GeneratorError, check, generate, load_config, render, source_entries

__all__ = ['GeneratorError', 'check', 'generate', 'load_config', 'render', 'source_entries']
