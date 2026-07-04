# Hierarchical (per-instance) utilization report, giving resource usage broken
# down by module/instance.
#
# Optional report: not part of the default implementation reports. Source it via
# VivadoImpl's extra_reports interface. Writes utilization_hier.txt in the run's
# working directory (the impl build directory).
report_utilization -hierarchical -file utilization_hier.txt
