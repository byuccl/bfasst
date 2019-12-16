#!/usr/bin/python3

import sys
import re

file_path = sys.argv[1]

lines = open(file_path).readlines()

for l in lines:
    line = l.strip()

    m = re.match("6\. Compare Results:\s+(.*)$", line)
    if m:
        sys.stdout.write(m.group(1))
    

