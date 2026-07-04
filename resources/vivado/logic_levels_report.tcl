# Logic-level distribution over the worst setup path per endpoint (up to max_paths
# endpoints): the highest populated column is the design's max combinational depth,
# independent of the worst-slack path that timing_summary reports. Guarded so a
# design with no constrained setup paths produces an empty report instead of
# failing the whole implementation.
#
# Optional report: not part of the default implementation reports. Source it via
# VivadoImpl's extra_reports interface. Writes logic_levels.txt in the run's
# working directory (the impl build directory).
if {[catch {
    set ll_paths [get_timing_paths -setup -max_paths 100000 -nworst 1]
    report_design_analysis -logic_level_distribution -of_timing_paths $ll_paths -file logic_levels.txt
} ll_err]} {
    puts "WARNING: logic-level distribution report failed: $ll_err"
    set fh [open logic_levels.txt w]
    puts $fh "logic-level distribution report unavailable: $ll_err"
    close $fh
}
