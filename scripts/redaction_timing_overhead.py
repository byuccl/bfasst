"""Parse Vivado and RapidWright logs to collect timing data for redaction overhead analysis."""

import re
import csv
import json
from pathlib import Path
from typing import Dict, Optional, Tuple, List


# =============================================================================
# ---------- Configuration: put your build roots here ----------
# Each entry should point to the top-level design directory that contains
# vivado_synth/, vivado_impl/ (or vivado_reimpl/), netlist_obfuscate/, etc.
# =============================================================================
BUILD_ROOTS: List[Path] = [
    Path("../build/byu/alu"),
    Path("../build/byu/buttoncount"),
    Path("../build/koios/tpu_like.large.os"),
    Path("../build/byu/calc"),
    Path("../build/byu/counter"),
    Path("../build/byu/counters"),
    Path("../build/byu/debouncer"),
    Path("../build/byu/lightWave"),
    Path("../build/byu/mux8to1"),
    Path("../build/byu/oneshot"),
    Path("../build/byu/regfile"),
    Path("../build/byu/riscvSimpleDatapath"),
    Path("../build/byu/riscv_final"),
    Path("../build/byu/rx"),
    Path("../build/byu/seven_segment"),
    Path("../build/byu/shiftReg"),
    Path("../build/byu/Sout_reg"),
    Path("../build/byu/stopwatch"),
    Path("../build/byu/tx"),
    Path("../build/byu/uart"),
    Path("../build/byu/uart_debouncer"),
    Path("../build/byu/uart_rx"),
    Path("../build/byu/uart_ssc"),
    Path("../build/byu/uart_tx"),
    Path("../build/byu/UpDownButtonCount"),
    Path("../build/ooc/aes128"),
    Path("../build/ooc/EX_stage"),
    Path("../build/ooc/ID_stage"),
    Path("../build/ooc/IF_stage"),
    Path("../build/ooc/MEM_stage"),
    Path("../build/ooc/WB_stage"),
    Path("../build/ooc/a25_coprocessor"),
    Path("../build/ooc/a25_decode"),
    Path("../build/ooc/a25_write_back"),
    Path("../build/ooc/a25_wishbone"),
    Path("../build/ooc/basicrsa"),
    Path("../build/ooc/bcd_adder"),
    Path("../build/ooc/bubblesort"),
    Path("../build/ooc/control_unit"),
    Path("../build/ooc/cpu8080"),
    Path("../build/ooc/data_path"),
    Path("../build/ooc/hight"),
    Path("../build/ooc/jpegencode"),
    Path("../build/ooc/median"),
    Path("../build/ooc/mips_16"),
    Path("../build/ooc/natalius_processor"),
    Path("../build/ooc/pci_mini"),
    Path("../build/ooc/pic"),
    Path("../build/ooc/pid"),
    Path("../build/ooc/quadratic_func"),
    Path("../build/ooc/random_pulse_generator"),
    Path("../build/ooc/simon_core"),
    Path("../build/ooc/tiny_encryption_algorithm"),
    Path("../build/ooc/uart2spi"),
    Path("../build/ooc/wb_lcd"),
    Path("../build/vtr_benchmarks/mkPktMerge"),
    Path("../build/vtr_benchmarks/mkSMAdapter4B"),
    Path("../build/vtr_benchmarks/raygentop"),
    Path("../build/vtr_benchmarks/sha"),
    Path("../build/vtr_benchmarks/stereovision1"),
    Path("../build/vtr_benchmarks/stereovision2"),
    Path("../build/vtr_benchmarks/stereovision3"),
]


# =============================================================================
# ---------------------- Vivado log parsing (per-command) ---------------------
# Delimiter: lines starting with "Command:"
# Also attributes explicit "<cmd>: Time (s): ... elapsed = ..." lines
# =============================================================================

_ELAPSED_RE = re.compile(r"elapsed\s*=\s*([0-9:.]+)")
_CMD_HEADER_RE = re.compile(r"^\s*Command:\s+(.+)$")
_TIMELINE_WITH_CMD_RE = re.compile(
    r"^\s*([A-Za-z0-9_./:-]+)\s*:\s*Time\s*\(s\):.*?elapsed\s*=\s*([0-9:.]+)"
)


def _parse_hms_to_seconds(s: str) -> float:
    if ":" not in s:
        return float(s)
    hh, mm, ss = s.split(":")
    return int(hh) * 3600 + int(mm) * 60 + float(ss)


def _normalize_cmd_name(raw: str) -> str:
    return raw.strip().split()[0]


def parse_vivado_log_to_dict(log_path: Path) -> Dict[str, float]:
    """Parse a Vivado log file and return command execution times in seconds."""
    results: Dict[str, float] = {}
    current_cmd: Optional[str] = None
    current_accum = 0.0

    if not log_path.exists():
        return {}

    with log_path.open("r", encoding="utf-8", errors="ignore") as f:
        for line in f:
            m_explicit = _TIMELINE_WITH_CMD_RE.match(line)
            if m_explicit:
                cmd = _normalize_cmd_name(m_explicit.group(1))
                secs = _parse_hms_to_seconds(m_explicit.group(2))
                results[cmd] = results.get(cmd, 0.0) + secs
                continue

            m_hdr = _CMD_HEADER_RE.match(line)
            if m_hdr:
                if current_cmd is not None:
                    results[current_cmd] = results.get(current_cmd, 0.0) + current_accum
                current_cmd = _normalize_cmd_name(m_hdr.group(1))
                current_accum = 0.0
                results.setdefault(current_cmd, 0.0)
                continue

            if current_cmd:
                m_elapsed = _ELAPSED_RE.search(line)
                if m_elapsed:
                    secs = _parse_hms_to_seconds(m_elapsed.group(1))
                    current_accum += secs

        if current_cmd is not None:
            results[current_cmd] = results.get(current_cmd, 0.0) + current_accum

    return results


# =============================================================================
# ---------------------- RapidWright log parsing (robust) ---------------------
# We key sections off ANY line containing "Reading DCP:" or "Writing DCP:"
# Totals are pulled from ANY "*Total*: <num>s" line.
# =============================================================================

_RW_SECTION_KIND_RE = re.compile(r"(Reading|Writing)\s+DCP:\s*(.+)", re.IGNORECASE)
_RW_TOTAL_ANY_RE = re.compile(r"\*Total\*:\s*([0-9]+(?:\.[0-9]+)?)s", re.IGNORECASE)
_RW_OBFUSCATION_RE = re.compile(
    r"Finished cell property obfuscation in\s+([0-9.]+)\s*s", re.IGNORECASE
)
_RW_RESTORATION_RE = re.compile(r"Restoration complete in\s+([0-9.]+)\s*s", re.IGNORECASE)


def _ms(sec: float) -> int:
    return int(round(sec * 1000))


def _match_section(line: str) -> Optional[Tuple[str, str]]:
    # Strip decorative framing "==== ==  Writing DCP: foo  == ===="
    core = line.strip().strip("=").strip()
    m = _RW_SECTION_KIND_RE.search(core) or _RW_SECTION_KIND_RE.search(line)
    if m:
        kind = "read" if m.group(1).lower().startswith("reading") else "write"
        return kind, m.group(2).strip()
    return None


def _match_total_seconds(line: str) -> Optional[float]:
    m = _RW_TOTAL_ANY_RE.search(line)
    return float(m.group(1)) if m else None


def parse_rw_obfuscate_breakdown_ms(log_path: Path) -> Tuple[Dict[str, int], Dict[str, int]]:
    """
    netlist_obfuscate.log -> (golden_dict, test_dict) with:
      - netlist_obfuscate.rapidwright_read_dcp      (use FIRST Reading DCP total for both)
      - netlist_obfuscate.rapidwright_write_dcp
            (untransformed_* -> golden, transformed_* -> test)
      - netlist_obfuscate.obfuscation_time
            (from "Finished cell property obfuscation ..."; test only)
    """
    golden: Dict[str, int] = {}
    test: Dict[str, int] = {}
    if not log_path.exists():
        return golden, test

    current_kind: Optional[str] = None
    current_section_text: Optional[str] = None
    first_read_total_sec: Optional[float] = None
    write_totals: Dict[str, float] = {"golden": 0.0, "test": 0.0}
    obfuscation_time_sec: float = 0.0

    with log_path.open("r", encoding="utf-8", errors="ignore") as f:
        for raw in f:
            line = raw.rstrip("\r\n")

            sect = _match_section(line)
            if sect:
                current_kind, current_section_text = sect
                continue

            tot = _match_total_seconds(line)
            if tot is not None and current_kind is not None:
                if current_kind == "read":
                    if first_read_total_sec is None:
                        first_read_total_sec = tot
                elif current_kind == "write" and current_section_text:
                    # IMPORTANT: match golden first to avoid substring overlap
                    if "untransformed_" in current_section_text.lower():
                        write_totals["golden"] += tot
                    elif "transformed_" in current_section_text.lower():
                        write_totals["test"] += tot
                continue

            m_obf = _RW_OBFUSCATION_RE.search(line)
            if m_obf:
                obfuscation_time_sec += float(m_obf.group(1))

    golden["netlist_obfuscate.rapidwright_read_dcp"] = (
        _ms(first_read_total_sec) if first_read_total_sec is not None else 0
    )
    test["netlist_obfuscate.rapidwright_read_dcp"] = golden[
        "netlist_obfuscate.rapidwright_read_dcp"
    ]

    golden["netlist_obfuscate.rapidwright_write_dcp"] = _ms(write_totals["golden"])
    test["netlist_obfuscate.rapidwright_write_dcp"] = _ms(write_totals["test"])

    golden["netlist_obfuscate.obfuscation_time"] = 0
    test["netlist_obfuscate.obfuscation_time"] = _ms(obfuscation_time_sec)

    return golden, test


def parse_rw_deobfuscate_breakdown_ms(log_path: Path) -> Tuple[Dict[str, int], Dict[str, int]]:
    """
    netlist_deobfuscate.log -> (golden_dict, test_dict) with:
      - netlist_deobfuscate.rapidwright_read_dcp   (first Reading total -> test; second -> golden)
      - netlist_deobfuscate.rapidwright_write_dcp
            (unmodified_impl_deobf.dcp -> golden; impl_deobf.dcp -> test)
      - netlist_deobfuscate.deobfuscation_time     (from 'Restoration complete in X s'; test only)
    """
    golden: Dict[str, int] = {}
    test: Dict[str, int] = {}
    if not log_path.exists():
        return golden, test

    current_kind: Optional[str] = None
    current_section_text: Optional[str] = None
    read_totals: List[float] = []
    write_totals: Dict[str, float] = {"golden": 0.0, "test": 0.0}
    deobf_time_sec: float = 0.0

    with log_path.open("r", encoding="utf-8", errors="ignore") as f:
        for raw in f:
            line = raw.rstrip("\r\n")

            sect = _match_section(line)
            if sect:
                current_kind, current_section_text = sect
                continue

            tot = _match_total_seconds(line)
            if tot is not None and current_kind is not None:
                if current_kind == "read":
                    read_totals.append(tot)
                elif current_kind == "write" and current_section_text:
                    lower = current_section_text.lower()
                    # IMPORTANT: match golden first to avoid substring overlap
                    if "unmodified_impl_deobf.dcp" in lower:
                        write_totals["golden"] += tot
                    elif "impl_deobf.dcp" in lower:
                        write_totals["test"] += tot
                continue

            m_rest = _RW_RESTORATION_RE.search(line)
            if m_rest:
                deobf_time_sec += float(m_rest.group(1))

    test["netlist_deobfuscate.rapidwright_read_dcp"] = (
        _ms(read_totals[0]) if len(read_totals) >= 1 else 0
    )
    golden["netlist_deobfuscate.rapidwright_read_dcp"] = (
        _ms(read_totals[1]) if len(read_totals) >= 2 else 0
    )

    test["netlist_deobfuscate.rapidwright_write_dcp"] = _ms(write_totals["test"])
    golden["netlist_deobfuscate.rapidwright_write_dcp"] = _ms(write_totals["golden"])

    test["netlist_deobfuscate.deobfuscation_time"] = (
        _ms(deobf_time_sec) if deobf_time_sec > 0 else 0
    )
    golden["netlist_deobfuscate.deobfuscation_time"] = 0

    return golden, test


# =============================================================================
# ------------------------------ Stage wrappers ------------------------------
# =============================================================================


def _namespace(prefix: str, breakdown_ms: Dict[str, int]) -> Dict[str, int]:
    return {f"{prefix}.{cmd}": ms for cmd, ms in breakdown_ms.items()}


def _merge_add(dst: Dict[str, int], src: Dict[str, int]) -> None:
    for k, v in src.items():
        dst[k] = dst.get(k, 0) + v


def _vivado_stage_breakdown_ms(log_path: Path) -> Dict[str, int]:
    cmd_secs = parse_vivado_log_to_dict(log_path)
    return {cmd: int(round(sec * 1000)) for cmd, sec in cmd_secs.items()}


def collect_flow_stage_times(build_root: Path) -> Tuple[Dict[str, int], Dict[str, int]]:
    """
    For one design root produce (golden_ms_dict, test_ms_dict) with only per-entry keys.
    Keys are namespaced as '<stage>.<entry>'.
    """
    # Vivado logs
    vivado_synth_log = build_root / "vivado_synth" / "vivado.log"
    vivado_impl_log = build_root / "vivado_impl" / "vivado.log"
    vivado_reimpl_log = build_root / "vivado_reimpl" / "vivado.log"
    impl_reports_orig_log = build_root / "impl_detailed_reports_orig" / "vivado.log"
    impl_reports_transform_log = build_root / "impl_detailed_reports_transform" / "vivado.log"

    # RapidWright logs
    obf_log = build_root / "netlist_obfuscate" / "netlist_obfuscate.log"
    deobf_log = build_root / "netlist_deobfuscate" / "netlist_deobfuscate.log"

    golden: Dict[str, int] = {}
    test: Dict[str, int] = {}

    # Vivado: synth (shared)
    synth_ns = _namespace("vivado_synth", _vivado_stage_breakdown_ms(vivado_synth_log))
    _merge_add(golden, synth_ns)
    _merge_add(test, synth_ns)

    # Vivado: golden impl / reports
    _merge_add(golden, _namespace("vivado_impl", _vivado_stage_breakdown_ms(vivado_impl_log)))
    _merge_add(
        golden,
        _namespace("impl_detailed_reports_orig", _vivado_stage_breakdown_ms(impl_reports_orig_log)),
    )

    # Vivado: test reimpl / reports
    _merge_add(test, _namespace("vivado_reimpl", _vivado_stage_breakdown_ms(vivado_reimpl_log)))
    _merge_add(
        test,
        _namespace(
            "impl_detailed_reports_transform",
            _vivado_stage_breakdown_ms(impl_reports_transform_log),
        ),
    )

    # RapidWright: obfuscate per-design
    obf_golden, obf_test = parse_rw_obfuscate_breakdown_ms(obf_log)
    _merge_add(golden, obf_golden)
    _merge_add(test, obf_test)

    # RapidWright: deobfuscate per-design
    deobf_golden, deobf_test = parse_rw_deobfuscate_breakdown_ms(deobf_log)
    _merge_add(golden, deobf_golden)
    _merge_add(test, deobf_test)

    return golden, test


# =============================================================================
# ------------------------------ Batch utilities -----------------------------
# =============================================================================


def collect_many(
    build_roots: List[Path],
) -> Tuple[List[str], List[Dict[str, int]], List[Dict[str, int]]]:
    """
    Run collection over many designs.
    Returns (design_names, golden_dicts, test_dicts)
    """
    names: List[str] = []
    g_list: List[Dict[str, int]] = []
    t_list: List[Dict[str, int]] = []

    for root in build_roots:
        name = str(root)
        g, t = collect_flow_stage_times(root)
        names.append(name)
        g_list.append(g)
        t_list.append(t)

    return names, g_list, t_list


def _all_keys(dicts: List[Dict[str, int]]) -> List[str]:
    s = set()
    for d in dicts:
        s.update(d.keys())
    return sorted(s)


def normalize_and_warn(
    kind: str, names: List[str], dicts: List[Dict[str, int]]
) -> Tuple[List[Dict[str, int]], List[str]]:
    """
    Ensure all dicts share the same keys by inserting 0 for missing entries.
    Returns (normalized_dicts, warnings).
    """
    warnings: List[str] = []
    keys = _all_keys(dicts)
    for name, d in zip(names, dicts):
        missing = [k for k in keys if k not in d]
        if missing:
            warnings.append(
                f"[WARN] {kind} '{name}' missing {len(missing)} entries: "
                f"{missing[:6]}{' ...' if len(missing) > 6 else ''}"
            )
            for k in missing:
                d[k] = 0
    # Keep column order stable:
    dicts_norm = [{k: d[k] for k in keys} for d in dicts]
    return dicts_norm, warnings


def _percentize(d: Dict[str, int]) -> Dict[str, float]:
    total = float(sum(d.values()))
    if total <= 0:
        return {k: 0.0 for k in d.keys()}
    return {k: (v / total) * 100.0 for k, v in d.items()}


def compute_percentages(dicts: List[Dict[str, int]]) -> List[Dict[str, float]]:
    return [_percentize(d) for d in dicts]


def write_csv(path: Path, names: List[str], dicts: List[Dict[str, float]]) -> None:
    if not dicts:
        return
    keys = list(dicts[0].keys())
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(["design"] + keys)
        for name, d in zip(names, dicts):
            row = [name] + [f"{d[k]:.4f}" for k in keys]
            writer.writerow(row)


def mean_percentages(dicts: List[Dict[str, float]]) -> Dict[str, float]:
    if not dicts:
        return {}
    keys = dicts[0].keys()
    acc = {k: 0.0 for k in keys}
    for d in dicts:
        for k in keys:
            acc[k] += d[k]
    n = float(len(dicts))
    return {k: acc[k] / n for k in keys}


def write_overhead_csv(
    path: Path, names: List[str], golden_ms: List[Dict[str, int]], test_ms: List[Dict[str, int]]
) -> None:
    """
    Overhead is defined as the sum of all netlist_obfuscate.* and netlist_deobfuscate.* entries.
    We report: overhead_ms and overhead_pct (of total per design), for golden and test.
    """
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(
            [
                "design",
                "golden_total_ms",
                "golden_overhead_ms",
                "golden_overhead_pct",
                "test_total_ms",
                "test_overhead_ms",
                "test_overhead_pct",
            ]
        )

        for name, g, t in zip(names, golden_ms, test_ms):
            g_total = sum(g.values())
            t_total = sum(t.values())
            g_over = sum(
                v
                for k, v in g.items()
                if k.startswith("netlist_obfuscate.") or k.startswith("netlist_deobfuscate.")
            )
            t_over = sum(
                v
                for k, v in t.items()
                if k.startswith("netlist_obfuscate.") or k.startswith("netlist_deobfuscate.")
            )
            g_pct = (g_over / g_total * 100.0) if g_total > 0 else 0.0
            t_pct = (t_over / t_total * 100.0) if t_total > 0 else 0.0
            writer.writerow(
                [name, g_total, g_over, f"{g_pct:.4f}", t_total, t_over, f"{t_pct:.4f}"]
            )


# =============================================================================
# ------------------------------------ CLI -----------------------------------
# =============================================================================


def _as_json(obj) -> str:
    return json.dumps(obj, indent=2, sort_keys=True)


def run_and_emit(build_roots: List[Path], out_dir: Path) -> Dict[str, object]:
    """Collect timing data from all designs and write CSV reports."""
    names, golden_ms, test_ms = collect_many(build_roots)

    # Normalize and warn if inconsistent keys across designs
    golden_ms_norm, warn_g = normalize_and_warn("golden", names, golden_ms)
    test_ms_norm, warn_t = normalize_and_warn("test", names, test_ms)
    warnings = warn_g + warn_t

    # Percentages
    golden_pct = compute_percentages(golden_ms_norm)
    test_pct = compute_percentages(test_ms_norm)

    # Write CSVs (percent per entry, by design)
    write_csv(out_dir / "golden_percent.csv", names, golden_pct)
    write_csv(out_dir / "test_percent.csv", names, test_pct)

    # Write average rows for convenience
    golden_avg = mean_percentages(golden_pct)
    test_avg = mean_percentages(test_pct)
    write_csv(out_dir / "golden_percent_avg.csv", ["AVERAGE"], [golden_avg] if golden_avg else [])
    write_csv(out_dir / "test_percent_avg.csv", ["AVERAGE"], [test_avg] if test_avg else [])

    # Write overhead summary
    write_overhead_csv(out_dir / "obfuscation_overhead.csv", names, golden_ms_norm, test_ms_norm)

    return {
        "designs": names,
        "warnings": warnings,
        "golden_ms": golden_ms_norm,
        "test_ms": test_ms_norm,
        "golden_pct": golden_pct,
        "test_pct": test_pct,
        "averages": {"golden_pct": golden_avg, "test_pct": test_avg},
        "csv_dir": str(out_dir),
    }


if __name__ == "__main__":
    import argparse

    p = argparse.ArgumentParser(
        description=(
            "Collect per-entry times (ms) for golden/test across many designs, "
            "and emit CSV artifacts."
        )
    )
    p.add_argument("--out", type=str, default="timing_artifacts", help="Output directory for CSVs")
    p.add_argument(
        "--pretty", default=True, action="store_true", help="Pretty-print a JSON summary to stdout"
    )
    args = p.parse_args()

    summary = run_and_emit(BUILD_ROOTS, Path(args.out))
    if args.pretty:
        print(_as_json(summary))
    else:
        print(json.dumps({"csv_dir": summary["csv_dir"], "warnings": summary["warnings"]}))
