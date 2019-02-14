# Creates the .yos script that is used by yosys to compile the project
import sys
import getopt
import os

example_yos = os.path.join(os.path.dirname(os.path.realpath(__file__)),
                           "example_yosys.yos")

usage_str = "createPrjFile.py -s <source files> -o <yos file>\n\
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
    try:
        opts, args = getopt.getopt(sys.argv[1:], "-hs:o:",["help"])
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
        else:
            assert False, "unhandled option"
            
    # Read the example yos file and replicate most of it. Replace the
    #   project files with our source files
    of = None
    if outfile != None:
        try:
            of = open(outfile, 'w')
        except IOError:
            print("Could not open output file!")
            sys.exit(2)
            
    with open(example_yos) as prj_file:
        for line in prj_file:
            print_or_write(of, line)
            if line.strip() == "# Read verilog input files":
                for src in srcs:
                    if src[-4:] == ".vhd":
                        # Yosys doesn't natively support VHDL. 
                        #print("Ignoring VHDL file", src, " -- VHDL not supported")
                        print_or_write(of, "read_vhdl " + src + '\n')
                    elif src[-2:] == ".v":
                        print_or_write(of, "read_verilog " + src + '\n')
                    else:
                        print("Unrecognized file type", src)
    print_or_write(of, '\n');

if __name__ == "__main__":
    main()
