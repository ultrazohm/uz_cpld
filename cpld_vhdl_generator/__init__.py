"""Standalone, deterministic VHDL generation with no build-tool dependencies."""

__version__ = "0.1.0"

from .generator import GeneratorError, check, generate, load_config, render

__all__ = ['GeneratorError', 'check', 'generate', 'load_config', 'render']
