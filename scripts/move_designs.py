#!/usr/bin/python3

import os
import sys
import re
import shutil

def main():
    designs_dir = sys.argv[1]
    new_designs_dir = sys.argv[2]

    designs_dir_list = os.listdir(designs_dir)

    for design_dir_name in designs_dir_list:
        design_dir = os.path.join(designs_dir, design_dir_name)
        # print(design_dir)

        design_name = re.match("ooc_(.*)", design_dir_name).group(1)
        # print(design_name)

        new_design_dir = os.path.join(new_designs_dir, design_name)
        try:
            os.mkdir(new_design_dir)
        except FileExistsError:
            pass

        # Copy source files
        design_src_dir = os.path.join(design_dir, "Sources", "hdl")
        assert os.path.isdir(design_src_dir)

        hierarchy = False
        for f in os.listdir(design_src_dir):
            if not os.path.isfile(os.path.join(design_src_dir, f)):
                hierarchy = True
                # print(os.path.join(design_src_dir, f)) 


        if not hierarchy:
            for f in os.listdir(design_src_dir):
                pass
                #shutil.copyfile(os.path.join(design_src_dir, f), os.path.join(new_design_dir, f))
        else:
            print(design_name)
                
        create_makefile(design_name, os.path.join(new_design_dir, "Makefile"))



def create_makefile(name, file_path):
    print("Creating makefile", file_path)
    with open(file_path, 'w') as fp:
        fp.write("NAME=" + name + "\n")
        # fp.write("LEVEL=../..\n")
        fp.write("\n")
        fp.write("DESIGN_DIR=$(dir $(abspath $(firstword $(MAKEFILE_LIST))))\n")
        fp.write("include $(DESIGN_DIR)/../Makefile.inc\n")



if __name__ == "__main__":
    main()
