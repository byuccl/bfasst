# report_logic_levels.tcl
#
# Generate a logic-level distribution report for every completed RandSoC design
# so the *maximum combinational logic depth* of each design can be extracted --
# independent of which path is the worst-slack / longest-delay path (that single
# number is all timing_summary.txt gives us).
#
# For each <build_dir>/design_*/vivado_impl/impl.dcp this writes
#   <build_dir>/design_*/vivado_impl/logic_levels.txt
# The highest populated logic-level column in that report is the design's max
# logic depth. Designs whose report already exists are skipped, so it is safe to
# re-run as more designs finish implementation.
#
# All design checkpoints are processed in a single Vivado session (open ->
# report -> close), so the Vivado start-up cost is paid once rather than per
# design.
#
# Usage:
#   vivado -mode batch -source report_logic_levels.tcl -tclargs <build_dir> [max_paths]
#
#   build_dir  Root rand_soc build directory containing design_* subdirs.
#   max_paths  Endpoints to analyze (worst setup path each); default 100000.
#              The report footnote states how many paths it actually covered; if
#              that equals max_paths the design has more endpoints than the cap
#              and a deeper path could in principle be missed -- raise this if so.

if {$argc < 1} {
    puts "ERROR: usage: vivado -mode batch -source report_logic_levels.tcl \
-tclargs <build_dir> \[max_paths\]"
    exit 1
}
set build_dir [lindex $argv 0]
set max_paths [expr {$argc >= 2 ? [lindex $argv 1] : 100000}]

set designs [lsort [glob -nocomplain -directory $build_dir -type d design_*]]
puts "Found [llength $designs] design directories under $build_dir"

set generated 0
set skipped 0
set failed 0
foreach ddir $designs {
    set dcp [file join $ddir vivado_impl impl.dcp]
    set out [file join $ddir vivado_impl logic_levels.txt]
    set tmp $out.tmp
    set name [file tail $ddir]

    # Only completed designs have an implementation checkpoint; already-reported
    # designs are skipped so the run is resumable.
    if {![file exists $dcp]} { incr skipped; continue }
    if {[file exists $out]}  { incr skipped; continue }

    puts "==> $name : generating logic-level report"
    if {[catch {
        open_checkpoint $dcp
        # Worst setup path per endpoint, across up to max_paths endpoints. The
        # logic-level distribution over this set reaches the deepest path even
        # when that path is not the global worst-slack one.
        set paths [get_timing_paths -setup -max_paths $max_paths -nworst 1]
        report_design_analysis -logic_level_distribution \
            -of_timing_paths $paths -file $tmp
        close_design
        # Rename only on success so an interrupted run never leaves a partial
        # report that would be mistaken for "done" on the next pass.
        file rename -force $tmp $out
    } err]} {
        puts "  ! FAILED $name: $err"
        catch { close_design }
        catch { file delete -force $tmp }
        incr failed
        continue
    }
    incr generated
}

puts "Done. generated=$generated skipped=$skipped failed=$failed"
exit 0
