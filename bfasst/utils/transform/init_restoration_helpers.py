"""
Robust INIT transformation + restoration utilities.

Supported ops:
  - FixPin(pin,val): clamp a pin, shrink LUT
  - InsertPin(pin,val): inverse of FixPin, grow LUT
  - PartialPermute(ids, perm): permute only specific logical pins
  - InvertInputPins(ids): XOR selected input pins (by logical ID)
  - BitReverse(): reverse address bit order (rare in practice)
  - InvertOutput(): invert all output bits

Public API:
  derive_init_transform(orig: int, derived: int, nbits: int | None = None) -> list[INITTransform] | None
      • If nbits is None, the function auto-infers BOTH widths (n_orig, n_derived) and returns a valid chain.
      • If nbits is provided, it derives an equal-width chain at that width.
  apply_transforms(word: int, transforms: list[INITTransform] | None, nbits: int) -> int
"""

from __future__ import annotations
from dataclasses import dataclass
from itertools import permutations
from typing import List, Optional, Tuple

# ---------------- Context ---------------- #

@dataclass(frozen=True)
class PinTag:
    id: int
    inverted: bool = False  # reserved

@dataclass(frozen=True)
class Ctx:
    word: int
    pins: Tuple[PinTag, ...]
    @property
    def nbits(self) -> int: return len(self.pins)
    @property
    def size(self) -> int: return 1 << self.nbits  # number of table entries

MAX_N = 6  # Xilinx LUT max

def _mask_for_n(nbits: int) -> int:
    return (1 << (1 << nbits)) - 1

def _ctx_from_word(word: int, nbits: int) -> Ctx:
    return Ctx(word & _mask_for_n(nbits), tuple(PinTag(i) for i in range(nbits)))

def _fits_exact_width(word: int, n: int) -> bool:
    """True iff no bits beyond 2^n entries are set."""
    return (word >> (1 << n)) == 0

def _candidate_widths(word: int) -> List[int]:
    """All n in [1..MAX_N] such that word fits exactly at width n."""
    return [n for n in range(1, MAX_N + 1) if _fits_exact_width(word, n)]

# ---------------- Base transform interface ---------------- #

class INITTransform:
    def apply(self, ctx: Ctx) -> Ctx: raise NotImplementedError
    def inverse(self) -> "INITTransform": raise NotImplementedError

# ---------------- Primitive transforms ---------------- #

class InvertOutput(INITTransform):
    def __repr__(self): return "InvertOutput()"
    def apply(self, ctx: Ctx) -> Ctx:
        return Ctx((~ctx.word) & _mask_for_n(ctx.nbits), ctx.pins)
    def inverse(self) -> "InvertOutput": return InvertOutput()

class InvertInputPins(INITTransform):
    """XOR selected input pins (by logical ID) with 1."""
    def __init__(self, ids: List[int]): self.ids = tuple(ids)
    def __repr__(self): return f"InvertInputPins(ids={self.ids})"
    def apply(self, ctx: Ctx) -> Ctx:
        if not self.ids: return ctx
        id2idx = {p.id: i for i, p in enumerate(ctx.pins)}
        mask = 0
        for pid in self.ids:
            idx = id2idx.get(pid)
            if idx is not None: mask |= 1 << idx
        if mask == 0: return ctx
        out = 0
        for old_addr in range(ctx.size):
            bit = (ctx.word >> old_addr) & 1
            out |= bit << (old_addr ^ mask)
        return Ctx(out, ctx.pins)
    def inverse(self) -> "InvertInputPins": return InvertInputPins(list(self.ids))

class FixPin(INITTransform):
    """Clamp pin index `pin` to `val`, drop half table (shrink LUT)."""
    def __init__(self, pin: int, val: int):
        self.pin, self.val = pin, (val & 1)
    def __repr__(self): return f"FixPin(pin={self.pin}, val={self.val})"
    def apply(self, ctx: Ctx) -> Ctx:
        if not (0 <= self.pin < ctx.nbits): raise ValueError("bad pin index")
        out = 0
        for old_addr in range(ctx.size):
            if ((old_addr >> self.pin) & 1) != self.val: continue
            bit = (ctx.word >> old_addr) & 1
            lower = old_addr & ((1 << self.pin) - 1)
            upper = old_addr >> (self.pin + 1)
            out |= bit << (lower | (upper << self.pin))
        new_pins = tuple(p for i, p in enumerate(ctx.pins) if i != self.pin)
        return Ctx(out, new_pins)
    def inverse(self) -> "InsertPin": return InsertPin(self.pin, self.val)

class InsertPin(INITTransform):
    """Inverse of FixPin: duplicate rows inserting a fixed bit at `pin`."""
    def __init__(self, pin: int, val: int):
        self.pin, self.val = pin, (val & 1)
    def __repr__(self): return f"InsertPin(pin={self.pin}, val={self.val})"
    def apply(self, ctx: Ctx) -> Ctx:
        out = 0
        for old_addr in range(ctx.size):
            bit = (ctx.word >> old_addr) & 1
            lower = old_addr & ((1 << self.pin) - 1)
            upper = old_addr >> self.pin
            addr0 = lower | (upper << (self.pin + 1))        # inserted bit = 0
            addr1 = addr0 | (1 << self.pin)                  # inserted bit = 1
            out |= bit << (addr1 if self.val else addr0)
        new_id = max((p.id for p in ctx.pins), default=-1) + 1
        new_pins = ctx.pins[: self.pin] + (PinTag(new_id),) + ctx.pins[self.pin :]
        return Ctx(out, new_pins)
    def inverse(self) -> "FixPin": return FixPin(self.pin, self.val)

class PartialPermute(INITTransform):
    """
    Permute only a specified set of logical pin IDs (ids).
    perm[new_idx] = old_idx over that list (order is in "ids" space).
    Pins not listed keep relative order.
    """
    def __init__(self, ids: List[int], perm: List[int]):
        self.ids, self.perm = tuple(ids), tuple(perm)
    def __repr__(self): return f"PartialPermute(ids={self.ids}, perm={self.perm})"
    def apply(self, ctx: Ctx) -> Ctx:
        id2idx = {p.id: i for i, p in enumerate(ctx.pins)}
        present_ids = [pid for pid in self.ids if pid in id2idx]
        if len(present_ids) <= 1:
            return ctx
        curr_indices = [id2idx[pid] for pid in present_ids]
        present_locs = [i for i, pid in enumerate(self.ids) if pid in id2idx]
        shrink_to_present = {sh: pr for pr, sh in enumerate(present_locs)}
        reduced = []
        for new_loc_present, shrink_loc in enumerate(present_locs):
            old_loc_shrink = self.perm[shrink_loc]
            reduced.append(shrink_to_present.get(old_loc_shrink, new_loc_present))
        new_order = list(range(ctx.nbits))
        for new_loc_present, old_loc_present in enumerate(reduced):
            dst_idx = curr_indices[new_loc_present]
            src_idx = curr_indices[old_loc_present]
            new_order[dst_idx] = src_idx
        out = 0
        for old_addr in range(ctx.size):
            bit = (ctx.word >> old_addr) & 1
            new_addr = 0
            for new_bit_pos, old_bit_pos in enumerate(new_order):
                new_addr |= ((old_addr >> old_bit_pos) & 1) << new_bit_pos
            out |= bit << new_addr
        new_pins = tuple(ctx.pins[i] for i in new_order)
        return Ctx(out, new_pins)
    def inverse(self) -> "PartialPermute":
        inv = [self.perm.index(i) for i in range(len(self.perm))]
        return PartialPermute(list(self.ids), inv)

class BitReverse(INITTransform):
    """Reverse address bit order (endianness) without changing pin order."""
    def __repr__(self): return "BitReverse()"
    def apply(self, ctx: Ctx) -> Ctx:
        n, out = ctx.nbits, 0
        for old_addr in range(ctx.size):
            bit = (ctx.word >> old_addr) & 1
            rev = 0; x = old_addr
            for _ in range(n):
                rev = (rev << 1) | (x & 1); x >>= 1
            out |= bit << rev
        return Ctx(out, ctx.pins)
    def inverse(self) -> "BitReverse": return BitReverse()

# ---------------- Chain helpers ---------------- #

def apply_chain_with_ctx(ctx: Ctx, chain: List[INITTransform]) -> Ctx:
    for t in chain: ctx = t.apply(ctx)
    return ctx

def invert_chain(chain: List[INITTransform]) -> List[INITTransform]:
    return [t.inverse() for t in reversed(chain)]

def _width_delta(chain: List[INITTransform]) -> int:
    d = 0
    for t in chain:
        if isinstance(t, InsertPin): d += 1
        elif isinstance(t, FixPin):  d -= 1
    return d

# ---------------- Derivation (strict, but with auto width inference) ---------------- #

def _derive_equal_width_from_ctx(ctx: Ctx, target_word: int) -> Optional[List[INITTransform]]:
    """Strict equal-width derivation: refuses if target doesn't fit width."""
    n = ctx.nbits
    if not _fits_exact_width(target_word, n):
        return None

    mask = _mask_for_n(n)
    a = ctx.word & mask
    b = target_word & mask
    if a == b:
        return []

    # Invariant: perms + input-inverts preserve ones; output-invert flips it.
    ones_a = a.bit_count()
    ones_b = b.bit_count()
    full = 1 << n
    if ones_b != ones_a and ones_b != (full - ones_a):
        return None

    present_ids = [p.id for p in ctx.pins]

    # Bias for tiny LUTs: try single-pin inversions first (common downstream fix to an upstream output invert)
    if n <= 3:
        for i in range(n):
            inv = [InvertInputPins([present_ids[i]])]
            out = apply_chain_with_ctx(ctx, inv).word
            if out == b: return inv
            if (out ^ mask) == b: return inv + [InvertOutput()]

    # General search: all permutations; for each, try all input inversion masks (+ optional output invert)
    for perm_idx in permutations(range(n)):
        base = [PartialPermute(present_ids, list(perm_idx))]
        out0 = apply_chain_with_ctx(ctx, base).word
        if out0 == b: return base
        if (out0 ^ mask) == b: return base + [InvertOutput()]
        for inv_mask in range(1 << n):
            inv_ids = [present_ids[i] for i in range(n) if (inv_mask >> i) & 1]
            chain = [InvertInputPins(inv_ids)] + base
            out = apply_chain_with_ctx(ctx, chain).word
            if out == b: return chain
            if (out ^ mask) == b: return chain + [InvertOutput()]
    return None

def _derive_init_transform_shrink_ctx(orig: int, derived: int, n_o: int, n_d: int) -> Optional[List[INITTransform]]:
    """n_o > n_d. DFS over FixPin choices, then equal-width resolve."""
    steps = n_o - n_d
    ctx0 = _ctx_from_word(orig, n_o)

    def dfs(ctx: Ctx, steps_left: int, chain: List[INITTransform]) -> Optional[List[INITTransform]]:
        if steps_left == 0:
            eq = _derive_equal_width_from_ctx(ctx, derived)
            return (chain + eq) if eq is not None else None
        # Heuristic: deterministic order
        for pin in range(ctx.nbits):
            for val in (0, 1):
                nxt = FixPin(pin, val).apply(ctx)
                r = dfs(nxt, steps_left - 1, chain + [FixPin(pin, val)])
                if r is not None: return r
        return None

    return dfs(ctx0, steps, [])

def _derive_init_transform_grow_ctx(orig: int, derived: int, n_o: int, n_d: int) -> Optional[List[INITTransform]]:
    """n_o < n_d. Directly grow by InsertPin DFS, then equal-width resolve.
       This avoids corner cases the invert-of-shrink route can miss on tiny LUTs."""
    steps = n_d - n_o
    ctx0 = _ctx_from_word(orig, n_o)

    def dfs(ctx: Ctx, steps_left: int, chain: List[INITTransform]) -> Optional[List[INITTransform]]:
        if steps_left == 0:
            eq = _derive_equal_width_from_ctx(ctx, derived)
            return (chain + eq) if eq is not None else None

        cur_n = ctx.nbits
        # Heuristics: deterministic order; try positions 0..cur_n and both tie-off values
        for pin in range(cur_n + 1):
            for val in (0, 1):
                nxt = InsertPin(pin, val).apply(ctx)
                r = dfs(nxt, steps_left - 1, chain + [InsertPin(pin, val)])
                if r is not None:
                    return r
        return None

    return dfs(ctx0, steps, [])

def _validate_chain(orig_word: int, target_word: int, n_orig: int, n_target: int, chain: List[INITTransform]) -> bool:
    # Width delta must match exactly:
    if _width_delta(chain) != (n_target - n_orig):
        return False
    # Apply starting from n_orig and require exact equality to target at n_target:
    if not _fits_exact_width(target_word, n_target):
        return False
    out = apply_chain_with_ctx(_ctx_from_word(orig_word, n_orig), chain).word
    return out == (target_word & _mask_for_n(n_target))

def _derive_exact(orig: int, derived: int, n_orig: int, n_derived: int) -> Optional[List[INITTransform]]:
    if n_orig == n_derived:
        ctx0 = _ctx_from_word(orig, n_orig)
        chain = _derive_equal_width_from_ctx(ctx0, derived)
        if chain is None: return None
        if _width_delta(chain) != 0: return None
        return chain

    if n_orig > n_derived:
        chain = _derive_init_transform_shrink_ctx(orig, derived, n_orig, n_derived)
    else:
        chain = _derive_init_transform_grow_ctx(orig, derived, n_orig, n_derived)

    if chain is None: return None
    return chain if _validate_chain(orig, derived, n_orig, n_derived, chain) else None

# ---------------- Public API (auto width inference supported) ---------------- #

def derive_init_transform(orig: int, derived: int, nbits: Optional[int] = None) -> Optional[List[INITTransform]]:
    """
    If nbits is provided: derive an equal-width chain at that width.
    If nbits is None: auto-infer BOTH widths and return a valid chain.
    Search order prefers minimal |width delta|, then shorter chains.
    """
    # Equal-width request:
    if nbits is not None:
        return _derive_exact(orig, derived, nbits, nbits)

    # Auto width inference:
    o_cands = _candidate_widths(orig)
    d_cands = _candidate_widths(derived)
    if not o_cands or not d_cands:
        return None

    # Try combinations in increasing |delta|, then increasing (n_orig, n_derived)
    best: Tuple[int, int, List[INITTransform]] | None = None  # (delta_abs, chain_len, chain)
    for delta_abs in range(0, MAX_N):  # minimal change first
        for n_o in o_cands:
            for n_d in d_cands:
                if abs(n_o - n_d) != delta_abs:
                    continue
                chain = _derive_exact(orig, derived, n_o, n_d)
                if chain is None:
                    continue
                score = (delta_abs, len(chain))
                if best is None or score < (best[0], best[1]):
                    best = (delta_abs, len(chain), chain)
        if best is not None:
            break

    return None if best is None else best[2]

def apply_transforms(word: int, transforms: Optional[List[INITTransform]], nbits: int | None) -> int:
    """
    Apply a chain. If `nbits` is None, infer the smallest valid starting width
    from `word` and the transform sequence (ensuring all referenced pins/IDs exist
    at each step). Otherwise, start from the provided `nbits`.
    """
    if not transforms:
        return word

    def _fits_exact_width(word: int, n: int) -> bool:
        return (word >> (1 << n)) == 0

    delta = _width_delta(transforms)

    # Simulate only pin/ID availability over the chain for a given starting width.
    def _can_apply_from_start_n(start_n: int) -> bool:
        # current logical IDs in order (match _ctx_from_word)
        ids = list(range(start_n))
        cur_n = start_n
        for t in transforms:
            if isinstance(t, FixPin):
                if not (0 <= t.pin < cur_n):
                    return False
                # remove the pin at that positional index; logical IDs of others persist
                ids.pop(t.pin)
                cur_n -= 1
            elif isinstance(t, InsertPin):
                if not (0 <= t.pin <= cur_n):
                    return False
                new_id = (max(ids) + 1) if ids else 0
                ids.insert(t.pin, new_id)
                cur_n += 1
            elif isinstance(t, InvertInputPins):
                # require all referenced IDs to exist at this step
                if not set(t.ids).issubset(set(ids)):
                    return False
            elif isinstance(t, PartialPermute):
                if not set(t.ids).issubset(set(ids)):
                    return False
            else:
                # InvertOutput / BitReverse don't reference pins/IDs
                pass
        # Final width must match start_n + delta
        return (cur_n == start_n + delta)

    # Build candidate starting widths.
    if nbits is not None:
        candidate_ns = [nbits]
    else:
        candidate_ns = [n for n in range(1, MAX_N + 1) if _fits_exact_width(word, n)]
        # If word is 0 or full, it "fits" many widths; we'll pick the smallest that satisfies the chain.

    # Pick the smallest start width that can legally apply the whole chain.
    start_n = None
    for n in sorted(candidate_ns):
        if _can_apply_from_start_n(n):
            start_n = n
            break

    if start_n is None:
        # As a last resort, try any width where the final width is in range.
        for n in range(1, MAX_N + 1):
            if 1 <= n + delta <= MAX_N and _can_apply_from_start_n(n):
                start_n = n
                break

    if start_n is None:
        # Give up: cannot reconcile widths/IDs with this chain.
        # Return the word unchanged (caller can decide how to handle).
        return word

    # Apply for real from the chosen starting width.
    ctx0 = _ctx_from_word(word, start_n)
    out_ctx = apply_chain_with_ctx(ctx0, transforms)
    # Sanity: resulting width must be start_n + delta
    assert out_ctx.nbits == start_n + delta
    return out_ctx.word


