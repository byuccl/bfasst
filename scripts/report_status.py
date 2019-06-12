#!/usr/bin/python3

import sys
import re
import os

def handle_conformal_log(log_path):
    text = open(log_path).read()

    m = re.search("^6\. Compare Results:\s+(.*)$", text, re.M)
    if m:
        sys.stdout.write("Equivalence: " + m.group(1))
    else:
        sys.stdout.write("***Conformal error***")

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

    # Invalid primitives
    m = re.search("^Error: (Module.*?is not a valid primitive.)", text, re.M)
    if (m):
        err_str += m.group(1)

    if (err_str):
        sys.stdout.write(err_str)
        return True


    return False

def synth_error_exists(design_name, log_path, ic2_dir):
    text = open(log_path).read()

    err_str = ""


    m = re.search("^compiler exited with errors$", text, re.M)
    if m:
        synth_file = os.path.join(ic2_dir, "synlog", design_name + "_compiler.srr")
        text = open(synth_file).read()

        m = re.search("^@E:(.*?)$", text, re.M)
        if m: 
            err_str += m.group(1)
        else:
            err_str += "***Synthesis compiler error***"
    
    m = re.search("^fpga_mapper exited with errors$", text, re.M)
    if m:

        mapper_file = os.path.join(ic2_dir, "synlog", design_name + "_fpga_mapper.srr")
        text = open(mapper_file).read()

        m = re.search("^@E:.*?\|(.*?)$", text, re.M)
        if m:
            err_str += m.group(1)
        else:
            err_str += "***Mapper compiler error***"

    if (err_str):
        sys.stdout.write(err_str)
        return True
    
    return False

def main():

    design_dir = sys.argv[1]
    design_name = sys.argv[2]
    design_dir = os.path.abspath(design_dir)
    build_dir = os.getcwd()
    # print(design_dir)   

    temp_dir = os.path.join(build_dir, "temp")
    ic2_dir = os.path.join(build_dir, "ic2")
    conformal_log = os.path.join(temp_dir, "conformal.log")
    impl_log = os.path.join(ic2_dir, "impl.log" )
    synth_log = os.path.join(ic2_dir, "synth.log")


    if os.path.isfile(conformal_log):
        print(conformal_log, " is a file")
        handle_conformal_log(conformal_log)
    elif os.path.isfile(impl_log) and impl_error_exists(impl_log):
        pass
    elif os.path.isfile(synth_log) and synth_error_exists(design_name, synth_log, ic2_dir):
        pass
     

        
if __name__ == "__main__":
    main()
