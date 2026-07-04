# Post-synthesis resource utilization report.
#
# Optional report: not part of the default synthesis reports. Source it via
# VivadoSynth's extra_reports interface. Writes synth_utilization.txt in the run's
# working directory (the synth build directory).
report_utilization -file synth_utilization.txt
