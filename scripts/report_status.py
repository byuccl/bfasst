#!/usr/bin/python3

import sys
import re
import os

def handle_conformal_log(log_path):
    lines = open(log_path).readlines()

    for l in lines:
        line = l.strip()

        m = re.match("6\. Compare Results:\s+(.*)$", line)
        if m:
            sys.stdout.write("Equivalence: " + m.group(1))
            return

def impl_error_exists(log_path):
    text = open(log_path).read()

    err_str = ""
    
    # Design too large    
    too_large_str = ""

    m = re.search("^Design LUT Count \((\d+)\) exceeded Device LUT Count \((\d+)\)$", text, re.M)
    if (m):
        too_large_str += "LUTs (" + m.group(1) + "/" + m.group(2) + ") "
    m = re.search("^Design FF Count \((\d+)\) exceeded Device FF Count \((\d+)\)$", text, re.M)
    if (m):
        too_large_str += "FFs (" + m.group(1) + "/" + m.group(2) + ") "

    # Too many I/Os
    m = re.search("Unable to fit the design into the selected device/package$\n^DEVICE IO Count:.*?Regular IOs.*?(\d+).*?DESIGN IO Count:.*?Regular IOs.*?(\d+)", text, re.M | re.S)
    if (m):
        too_large_str += "IOs (" + m.group(2) + "/" + m.group(1) + ") "
    
    if too_large_str:            
        err_str += "Design does not fit. " + too_large_str

    if (err_str):
        sys.stdout.write(err_str)
        return True


def main():

    design_dir = sys.argv[1]

    temp_dir = os.path.join(design_dir, "temp")
    conformal_log = os.path.join(temp_dir, "conformal.log")
    impl_log = os.path.join(design_dir, "ic2", "impl_log.txt" )

    if os.path.isfile(conformal_log):
        handle_conformal_log(conformal_log)
    elif os.path.isfile(impl_log) and impl_error_exists(impl_log):
        pass

        
if __name__ == "__main__":
    main()
