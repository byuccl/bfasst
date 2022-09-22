#!/usr/bin/python

import subprocess
import re
import glob


def main():

    # Do I still use these?
    equiv = 0
    not_equiv = 0 
    error = 0

    # Create list of flow names here
    # flow_names = ["rtl", "yosys", "single_bit_flip"]

    tcl_list = glob.glob("*.tcl")

    for tcl in tcl_list:
        timeout = False
        # log_file = "onespin_" + name + ".log"
        log_file = tcl[4:-4] + ".log"
        with open(log_file, "w") as fp:
            print(tcl)
            cmd = ["onespin", tcl]
        try:
            p = subprocess.Popen(cmd, stdout=fp, stderr=subprocess.STDOUT)
            p.communicate(timeout=5 * 60)
        except subprocess.TimeoutExpired:
            timeout = True

        if timeout:
            print("Timeout")
            error += 1
        else:
            text = open(log_file, "r").read()
            m1 = re.search("^-R- The designs are equivalent.$", text, re.M)
            m2 = re.search("^-R- The designs are not.*? equivalent.*.$", text, re.M)
            m3 = re.search(
                "^-E- Constraints and mapping are not satisfiable in initial state!$",
                text,
                re.M,
            )
            m4 = re.search(
                "^-R- Outputs: OPEN=[1-9][0-9]*\n[^\n]*$\n\Z", text, re.M
            )  # try to match an open statement one line before EOF
            m5 = re.search(
                "^-R- Internal: HOLD=[0-9]* OPEN=[1-9][0-9]*$\n\Z", text, re.M
            )
            m6 = re.search(
                "^-R- The designs are not fully equivalent as there are unmapped outputs in the revised design.$",
                text,
                re.M,
            )
            if m1:
                print("Equivalent")
            elif m2:
                print("Not equivalent")
            elif m3:
                print("Not equivalent (mapping not satisifable in initial state)")
            elif m4 or m5:
                print("Error -- open compare points")
            elif m6:
                print("Not fully equivalent -- unmapped outputs in revised")
            else:
                print("Error")

    # print(str(equiv) +  " of " + str(len(designs)) + " are equivalent (golden --> revised)")
    # print(str(not_equiv) +  " of " + str(len(designs)) + " are NOT equivalent (golden --> revised)")
    # print(str(error) +  " of " + str(len(designs)) + " couldn't compare (golden --> revised)")


if __name__ == "__main__":
    main()
