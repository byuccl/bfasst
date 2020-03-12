#!/usr/bin/python

import subprocess
import re

def main():

  # Do I still use these?
  equiv = 0
  not_equiv = 0
  error = 0

  # Create list of flow names here
  # flow_names = ["rtl", "yosys", "single_bit_flip"]

  for name in flow_names:
    timeout = False
    log_file = "onespin_" + name + ".log"
    with open(log_file, 'w') as fp:
      onespin_tcl = "run_onespin_" + name + ".tcl"
      print(onespin_tcl)
      cmd = ["onespin", onespin_tcl] 
      try:
	p = subprocess.Popen(cmd, stdout = fp, stderr = subprocess.STDOUT)
        p.communicate(timeout = 5*60)
      except subprocess.TimeoutExpired:
        timeout = True

    if timeout:
      print("Timeout")
      error += 1
    else:
      text = open(log_file, 'r').read()
      m = re.search("^-R- The designs are equivalent.$", text, re.M)
      if m:
        print("Equivalent")
	equiv += 1
      else:
        m = re.search("^-R- The designs are not .*? equivalent.$", text, re.M)
	if m:
          print("Not equivalent")
	  not_equiv += 1
	else:
          print("Error")
	  error += 1

  #print(str(equiv) +  " of " + str(len(designs)) + " are equivalent (golden --> revised)")
  #print(str(not_equiv) +  " of " + str(len(designs)) + " are NOT equivalent (golden --> revised)")
  #print(str(error) +  " of " + str(len(designs)) + " couldn't compare (golden --> revised)")


if __name__ == "__main__":
  main()
