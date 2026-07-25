# Routing congestion report. Per-direction "Max Cong" values are also emitted to
# vivado.log by this command; the congestion.txt file is written alongside.
#
# Optional report: not part of the default implementation reports. Source it via
# VivadoImpl's extra_reports interface. Writes congestion.txt in the run's working
# directory (the impl build directory).
report_design_analysis -congestion -file congestion.txt
