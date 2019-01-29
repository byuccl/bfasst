# This python script is used to generate the prj files used by the iCEcube2 flow
#   (especially synplify). It mostly just prints a generic prj file, but can be
#   used to add design files to the project or change other project parameters

# TODO: All of that stuff.
# For now, let's just set it up to accept project file names

import sys
import getopt

example_prj = "../../../../../scripts/iCEcube2/example.prj"

usage_str = "createPrjFile.py -s <source files> -o <prj file> -n <project name>\n\
Multiple source files must be enclosed in quotes \n\
  ex createPrjFile.py -s \"src1.v src2.v\"\
If -o is not specified, prints to stdout"

def print_or_write(outfile, string):
    if outfile != None:
        outfile.write(string)
    else:
        print(string, end='')

def main():
    # Read and parse args
    outfile = None
    srcs = None
    name = "proj" # Default name for project
    try:
        opts, args = getopt.getopt(sys.argv[1:], "-hs:o:n:",["help"])
    except getopt.GetoptError as err:
        print(err)
        print(usage_str)
        sys.exit(2)
    for o, a in opts:
        if o in ("-h", "--help"):
            print(usage_str)
        elif o == '-s':
            srcs = a.split()
        elif o == '-o':
            outfile = a
        elif o == '-n':
            name = a
        else:
            assert False, "unhandled option"

    # Read the example prj file and replicate most of it. Replace the
    #   project files with our source files
    of = None
    if outfile != None:
        try:
            of = open(outfile, 'w')
        except IOError:
            print("Could not open output file!")
            sys.exit(2)

    with open(example_prj) as prj_file:
        for line in prj_file:
            print_or_write(of, line)
            if line.strip() == "#project files":
                for src in srcs:
                    filetype = None
                    if src[-2:] == ".v":
                        filetype = "-verilog"
                    elif src[-4:] == ".vhd":
                        filetype = "-vhdl"
                    outstr = "add_file " + filetype + " -lib work " + src + '\n'
                    print_or_write(of, outstr)
            elif line.strip() == '#implementation: "test_Implmnt"':
                outstr = "impl -add " + name + "_Implmnt -type fpga\n"
                print_or_write(of, outstr)
            elif line.strip() == '#set result format/file last':
                print_or_write(of, 'project -result_format "edif"\n')
                outstr = 'project -result_file ./' + name + '_Implmnt/' \
                         + name + '.edf\n'
                print_or_write(of, outstr)
                outstr = 'project -log_file ./' + name + '_Implmnt/' \
                         + name + '.srr\n'
                print_or_write(of, outstr)
                outstr = 'impl -active "' + name + '_Implmnt"\n'
                print_or_write(of, outstr)
                print_or_write(of, "project -run synthesis -clean\n")
                
                
            
    
if __name__ == "__main__":
    main()
