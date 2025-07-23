"""
Robust INIT transformation + restoration utilities.

Supported ops:
  - FixPin(pin,val): clamp a pin, shrink LUT
  - InsertPin(pin,val): inverse of FixPin, grow LUT
  - PartialPermute(ids, perm): permute only specific logical pins
  - InvertInputPins(ids): XOR selected input pins (per-pin inversion)
  - BitReverse(): reverse bit order
  - InvertOutput(): invert all output bits

Public API:
  derive_init_transform(orig: int, derived: int) -> list[INITTransform] | None
  apply_transforms(word: int, transforms: list[INITTransform] | None) -> int
"""

from __future__ import annotations
import logging
from dataclasses import dataclass
from itertools import permutations, combinations, product
from typing import List, Optional

# ---------------- Core data ---------------- #

@dataclass(frozen=True)
class PinTag:
    id: int          # stable logical ID
    survivor: bool   # True if it existed AFTER all FixPins (on shrink side)

@dataclass
class Ctx:
    word: int
    pins: tuple[PinTag, ...]  # LSB address bit = index 0

    @property
    def nbits(self) -> int:
        return len(self.pins)

    @property
    def size(self) -> int:
        return 1 << self.nbits


def _init_ctx(word: int) -> Ctx:
    if word == 0:
        raise ValueError("INIT is zero; cannot infer LUT size")
    # infer width once
    b = word.bit_length()
    size = 1 << (b - 1).bit_length()
    if word >> size:
        raise ValueError("INIT width must be power-of-two")
    nbits = size.bit_length() - 1
    return Ctx(word, tuple(PinTag(i, True) for i in range(nbits)))


# ---------------- Base class ---------------- #

class INITTransform:
    def apply(self, ctx: Ctx) -> Ctx: raise NotImplementedError
    def inverse(self) -> "INITTransform": raise NotImplementedError


# ---------------- Primitive transforms ---------------- #

class InvertOutput(INITTransform):
    def __repr__(self): return "InvertOutput()"
    def apply(self, ctx: Ctx) -> Ctx:
        mask = (1 << ctx.size) - 1
        return Ctx((~ctx.word) & mask, ctx.pins)
    def inverse(self) -> "InvertOutput": return InvertOutput()


class BitReverse(INITTransform):
    def __repr__(self): return "BitReverse()"
    def apply(self, ctx: Ctx) -> Ctx:
        s = f"{ctx.word:0{ctx.size}b}"
        return Ctx(int(s[::-1], 2), ctx.pins)
    def inverse(self) -> "BitReverse": return BitReverse()


class InvertInputPins(INITTransform):
    """
    XOR selected input pins (by logical ID) with 1.
    ids: logical pin IDs to invert.
    """
    def __init__(self, ids: List[int]):
        self.ids = tuple(ids)

    def __repr__(self): return f"InvertInputPins(ids={self.ids})"

    def apply(self, ctx: Ctx) -> Ctx:
        if not self.ids:
            return ctx
        # map IDs to current bit positions
        id2idx = {p.id: i for i, p in enumerate(ctx.pins)}
        mask = 0
        for pid in self.ids:
            if pid in id2idx:
                mask |= 1 << id2idx[pid]
        if mask == 0:
            return ctx  # none present
        out = 0
        for old_addr in range(ctx.size):
            bit = (ctx.word >> old_addr) & 1
            out |= bit << (old_addr ^ mask)
        return Ctx(out, ctx.pins)

    def inverse(self) -> "InvertInputPins":
        return InvertInputPins(list(self.ids))  # self-inverse


class FixPin(INITTransform):
    """Clamp pin, keep rows where pin==val, shrink by 1 bit."""
    def __init__(self, pin: int, val: int):
        self.pin = pin
        self.val = val & 1
    def __repr__(self): return f"FixPin(pin={self.pin}, val={self.val})"

    def apply(self, ctx: Ctx) -> Ctx:
        if not (0 <= self.pin < ctx.nbits):
            raise ValueError("bad pin index")
        out = 0
        new_addr = 0
        for old_addr in range(ctx.size):
            if ((old_addr >> self.pin) & 1) != self.val:
                continue
            bit = (ctx.word >> old_addr) & 1
            lower = old_addr & ((1 << self.pin) - 1)
            upper = old_addr >> (self.pin + 1)
            out |= bit << (lower | (upper << self.pin))
            new_addr += 1
        if out == 0:
            raise ValueError(f"FixPin collapsed INIT to 0 (pin={self.pin}, val={self.val})")
        new_pins = tuple(p for i, p in enumerate(ctx.pins) if i != self.pin)
        return Ctx(out, new_pins)

    def inverse(self) -> "InsertPin":
        return InsertPin(self.pin, self.val)


class InsertPin(INITTransform):
    """Inverse of FixPin: duplicate rows inserting a fixed bit."""
    def __init__(self, pin: int, val: int):
        self.pin = pin
        self.val = val & 1
    def __repr__(self): return f"InsertPin(pin={self.pin}, val={self.val})"

    def apply(self, ctx: Ctx) -> Ctx:
        out = 0
        for old_addr in range(ctx.size):
            bit = (ctx.word >> old_addr) & 1
            lower = old_addr & ((1 << self.pin) - 1)
            upper = old_addr >> self.pin
            addr0 = lower | (upper << (self.pin + 1))          # inserted bit = 0
            addr1 = addr0 | (1 << self.pin)                    # inserted bit = 1
            out |= bit << (addr1 if self.val else addr0)
        new_id = (max((p.id for p in ctx.pins), default=-1) + 1)
        new_pin = PinTag(new_id, False)
        new_pins = ctx.pins[:self.pin] + (new_pin,) + ctx.pins[self.pin:]
        return Ctx(out, new_pins)

    def inverse(self) -> "FixPin":
        return FixPin(self.pin, self.val)


class PartialPermute(INITTransform):
    """
    Permute only a specified list of logical pin IDs (ids).
    perm[new_idx] = old_idx over that list (shrink-side order).
    Pins not listed keep their relative order.
    Missing pins are dropped from perm automatically (no-op for them).
    """
    def __init__(self, ids: List[int], perm: List[int]):
        self.ids  = tuple(ids)
        self.perm = tuple(perm)

    def __repr__(self):
        return f"PartialPermute(ids={self.ids}, perm={self.perm})"

    def apply(self, ctx: Ctx) -> Ctx:
        id2idx = {p.id: i for i, p in enumerate(ctx.pins)}

        # Which IDs are present now?
        present_ids  = [pid for pid in self.ids if pid in id2idx]
        if len(present_ids) <= 2:
            return ctx  # nothing to permute

        curr_indices = [id2idx[pid] for pid in present_ids]

        # Map shrink-local -> present-local
        shrink_to_present = {}
        present_order_ids = [pid for pid in self.ids if pid in id2idx]
        for present_loc, shrink_loc in enumerate(
                [i for i, pid in enumerate(self.ids) if pid in id2idx]):
            shrink_to_present[shrink_loc] = present_loc

        # Build reduced perm over the survivors
        reduced = []
        for new_loc_present, shrink_loc in enumerate(
                [i for i, pid in enumerate(self.ids) if pid in id2idx]):
            old_loc_shrink = self.perm[shrink_loc]
            if old_loc_shrink in shrink_to_present:
                reduced.append(shrink_to_present[old_loc_shrink])
            else:
                # source vanished, keep identity
                reduced.append(new_loc_present)

        # Build full permutation over all pins
        full_len = ctx.nbits
        new_order = list(range(full_len))
        for new_loc_present, old_loc_present in enumerate(reduced):
            dst_idx = curr_indices[new_loc_present]
            src_idx = curr_indices[old_loc_present]
            new_order[dst_idx] = src_idx

        # Apply to INIT
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


# ---------------- Chain helpers ---------------- #

def apply_chain(word: int, chain: List[INITTransform]) -> int:
    ctx = _init_ctx(word)
    for t in chain:
        ctx = t.apply(ctx)
    return ctx.word


def invert_chain(chain: List[INITTransform]) -> List[INITTransform]:
    """Grow first, then reorder/inverts. Size-changing ops must align."""
    inv_inv  : List[INITTransform] = []
    inv_rev  : List[INITTransform] = []
    inv_ins  : List[INITTransform] = []
    inv_perm : Optional[INITTransform] = None
    inv_inpins : List[INITTransform] = []

    for t in reversed(chain):
        if isinstance(t, InvertOutput):
            inv_inv.append(InvertOutput())
        elif isinstance(t, BitReverse):
            inv_rev.append(BitReverse())
        elif isinstance(t, FixPin):
            inv_ins.append(InsertPin(t.pin, t.val))
        elif isinstance(t, InsertPin):
            inv_ins.append(FixPin(t.pin, t.val))
        elif isinstance(t, PartialPermute):
            inv_perm = t.inverse()
        elif isinstance(t, InvertInputPins):
            inv_inpins.append(t.inverse())
        else:
            raise TypeError(t)

    out: List[INITTransform] = []
    out.extend(inv_inv)
    out.extend(inv_rev)
    out.extend(inv_ins)          # grow first
    if inv_perm:
        out.append(inv_perm)
    out.extend(inv_inpins)       # input inversions don't change size/order
    return out


# ---------------- Derivation ---------------- #

def _derive_init_transform_shrink(orig: int, derived: int):
    """
    Try to map orig(>bits) -> derived(<bits) with:
      FixPins (k pins), PartialPermute, optional InvertInputPins, BitReverse, InvertOutput
    """
    ctx_o = _init_ctx(orig)
    ctx_d = _init_ctx(derived)
    n = ctx_o.nbits
    m = ctx_d.nbits
    k = n - m
    if k <= 0:
        return None

    # brute but small (n<=6): iterate fixed pin sets/perms/val combos
    for fixed_set in combinations(range(n), k):
        free = [p for p in range(n) if p not in fixed_set]

        for perm_orig in permutations(free):
            for fixed_vals in range(1 << k):

                # Build chain: FixPin(s) + PartialPermute (survivors)
                current_order = list(range(n))   # logical ids
                chain: List[INITTransform] = []
                survivors = [True] * n

                for idx, pin_orig in enumerate(fixed_set):
                    cur_idx = current_order.index(pin_orig)
                    val = (fixed_vals >> idx) & 1
                    chain.append(FixPin(cur_idx, val))
                    current_order.pop(cur_idx)
                    survivors.pop(cur_idx)

                survivor_ids = current_order[:]  # logical ids in order
                perm_comp = [current_order.index(op) for op in perm_orig]
                chain.append(PartialPermute(survivor_ids, perm_comp))

                # optional input invert masks over current survivors (small set)
                # survivors count = m, try all masks up to 2^m
                for inv_mask_bits in range(1 << m):
                    inv_ids = [survivor_ids[i] for i in range(m) if (inv_mask_bits >> i) & 1]
                    chain2 = chain.copy()
                    if inv_ids:
                        chain2.append(InvertInputPins(inv_ids))

                    for rev, inv_out in product((False, True), (False, True)):
                        full = chain2.copy()
                        if rev:     full.append(BitReverse())
                        if inv_out: full.append(InvertOutput())
                        try:
                            if apply_chain(orig, full) == derived:
                                return full
                        except Exception:
                            pass
    return None


def _derive_init_transform_grow(orig: int, derived: int):
    # orig has m bits, derived has n bits, n = m+1 assumed here
    ctx_o = _init_ctx(orig); ctx_d = _init_ctx(derived)
    if ctx_d.nbits - ctx_o.nbits != 1:  # handle multiple too if needed
        return None

    m, n = ctx_o.nbits, ctx_d.nbits
    for pin in range(n):          # where inserted
        for val in (0, 1):
            # Try to shrink derived back
            try_chain = [FixPin(pin, val)]
            shrunk = apply_chain(derived, try_chain)
            # Now solve width-equal affine mapping:
            chain_eq = _derive_equal_width(shrunk, orig)
            if chain_eq is not None:
                # combine: grow = inverse(FixPin) is InsertPin
                return chain_eq_inverse(chain_eq)  # not needed if you want forward
    return None


def _derive_equal_width(a: int, b: int):
    n = _init_ctx(a).nbits
    ids = list(range(n))
    for perm in permutations(ids):
        for mask in range(1 << n):
            for inv_out in (0,1):
                for rev in (0,1):
                    chain = [PartialPermute(ids, list(perm))]
                    if mask:
                        inv_ids = [ids[i] for i in range(n) if (mask>>i)&1]
                        chain.append(InvertInputPins(inv_ids))
                    if rev:  chain.append(BitReverse())
                    if inv_out: chain.append(InvertOutput())
                    try:
                        if apply_chain(a, chain) == b:
                            return chain
                    except Exception:
                        pass
    return None


def derive_init_transform(orig: int, derived: int):
    ctx_o = _init_ctx(orig)
    ctx_d = _init_ctx(derived)
    n, m = ctx_o.nbits, ctx_d.nbits

    if n == m:
        return _derive_equal_width(orig, derived)

    if n < m:
        # grow case: derive shrink for reversed pair, then invert
        shrink = _derive_init_transform_shrink(derived, orig)
        if not shrink:
            return None
        return invert_chain(shrink)

    # n > m: shrink
    return _derive_init_transform_grow(orig, derived)


# ---------------- Public wrapper ---------------- #

def apply_transforms(word: int, transforms: Optional[List[INITTransform]]) -> int:
    if not transforms:
        return word
    return apply_chain(word, transforms)


