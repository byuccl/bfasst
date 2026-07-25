"""Shared plotting helpers for the FPT 2026 analysis scripts."""

from contextlib import contextmanager

import matplotlib.pyplot as plt


@contextmanager
def figure(out_path, figsize=(8, 4), subplot_kw=None, savefig_kw=None):
    """Create a single-axes figure, yield (fig, ax), then save it as its own PDF.

    Each graph is written to a separate PDF file at ``out_path`` (one graph per
    file). ``subplot_kw`` is forwarded to plt.subplots (e.g. ``dict(polar=True)``);
    ``savefig_kw`` is forwarded to ``fig.savefig`` (e.g. ``dict(bbox_inches="tight")``).
    """
    fig, ax = plt.subplots(figsize=figsize, subplot_kw=subplot_kw)
    yield fig, ax
    fig.tight_layout()
    fig.savefig(out_path, **(savefig_kw or {}))
    plt.close(fig)
    print(f"Saved {out_path}")
