#!/usr/bin/python3

import sys
import re

log_path = sys.argv[1]

for line in open(log_path).readlines():    
    if re.match("Error: Design Feasibility Failed", line):
        sys.exit(1)
    