#!/usr/bin/python

# /ee2/Cadence/CONFRML152/bin/lec -Dofile compare.do -Logfile log.txt -NOGui"


from __future__ import print_function # Only Python 2.x
import subprocess
import sys
import re

def execute(cmd):
    popen = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, universal_newlines=True)
    for stdout_line in iter(popen.stdout.readline, ""):
        yield stdout_line 
        
    popen.stdout.close()
    return_code = popen.wait()
    if return_code:
        raise subprocess.CalledProcessError(return_code, cmd)

for line in execute(["/ee2/Cadence/CONFRML152/bin/lec", "-Dofile", "compare.do", "-Logfile", "log.txt", "-NOGui"]):
    sys.stdout.write(line)
    sys.stdout.flush()
    if re.search("'dofile .*compare.do' is aborted", line):
        sys.exit(1)
    if re.match("// Command: exit", line):
        sys.exit(0)
