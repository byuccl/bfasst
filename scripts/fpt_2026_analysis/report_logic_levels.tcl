# report_logic_levels.tcl
#
# Generate extra per-design reports from each completed RandSoC implementation
# checkpoint:
#
#   logic_levels.txt      report_design_analysis -logic_level_distribution
#                         The highest populated logic-level column is the
#                         design's max combinational depth -- independent of the
#                         worst-slack / longest-delay path (all timing_summary.txt
#                         gives us).
#
#   utilization_hier.txt  report_utilization -hierarchical
#                         Resource usage (LUT/FF/BRAM/DSP/...) broken down per
#                         instance in the hierarchy, i.e. size by IP -- which the
#                         flat utilization.txt does not provide.
#
# Both land in <build_dir>/design_*/vivado_impl/. Each report is generated only
# if its own file does not already exist, and a checkpoint is opened only when at
# least one of its reports is missing -- so the run is resumable and re-running
# after adding a new report backfills it without redoing the others.
#
# All checkpoints are processed in a single Vivado session (open -> report ->
# close), so the Vivado start-up cost is paid once rather than per design.
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
    set dcp      [file join $ddir vivado_impl impl.dcp]
    set ll_out   [file join $ddir vivado_impl logic_levels.txt]
    set util_out [file join $ddir vivado_impl utilization_hier.txt]
    set name     [file tail $ddir]

    # Only completed designs have an implementation checkpoint.
    if {![file exists $dcp]} { incr skipped; continue }

    # Generate each report only if its file is missing; open the checkpoint only
    # when at least one report is needed.
    set need_ll   [expr {![file exists $ll_out]}]
    set need_util [expr {![file exists $util_out]}]
    if {!$need_ll && !$need_util} { incr skipped; continue }

    set what {}
    if {$need_ll}   { lappend what "logic-levels" }
    if {$need_util} { lappend what "hierarchical-utilization" }
    puts "==> $name : generating [join $what {, }]"
    if {[catch {
        open_checkpoint $dcp
        if {$need_ll} {
            # Worst setup path per endpoint, across up to max_paths endpoints. The
            # logic-level distribution over this set reaches the deepest path even
            # when that path is not the global worst-slack one.
            set paths [get_timing_paths -setup -max_paths $max_paths -nworst 1]
            report_design_analysis -logic_level_distribution \
                -of_timing_paths $paths -file $ll_out.tmp
        }
        if {$need_util} {
            report_utilization -hierarchical -file $util_out.tmp
        }
        close_design
        # Rename only on success so an interrupted run never leaves a partial
        # report that would be mistaken for "done" on the next pass.
        if {$need_ll}   { file rename -force $ll_out.tmp $ll_out }
        if {$need_util} { file rename -force $util_out.tmp $util_out }
    } err]} {
        puts "  ! FAILED $name: $err"
        catch { close_design }
        catch { file delete -force $ll_out.tmp }
        catch { file delete -force $util_out.tmp }
        incr failed
        continue
    }
    incr generated
}

puts "Done. generated=$generated skipped=$skipped failed=$failed"
exit 0
