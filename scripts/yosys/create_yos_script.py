''' Creates the .yos script that is used by yosys to compile the project'''
import sys
import getopt
# import os # pylint says os is never used
import pathlib

USAGE_STR = 'createPrjFile.py -s <source files> -o <yos file> -i<input yos file>\
 -v <output netlist name>\n\
Multiple source files must be enclosed in quotes \n\
  ex createPrjFile.py -s "src1.v src2.v"\
If -o is not specified, prints to stdout'


def print_or_write(outfile, string):
    if outfile is not None:
        outfile.write(string)
    else:
        print(string, end="")


def main():
    ''' Read and parse args '''
    outfile = None
    srcs = None
    inyos = None
    out_netlist = None
    try:
        opts = getopt.getopt(sys.argv[1:], "-hs:o:i:v:", ["help"]) # pylint says args is never used
    except getopt.GetoptError as err:
        print(err)
        print(USAGE_STR)
        sys.exit(2)
    for o_arg, a_arg in opts:
        if o_arg in ("-h", "--help"):
            print(USAGE_STR)
        elif o_arg == "-s":
            srcs = a_arg.split()
        elif o_arg == "-o":
            outfile = a_arg
        elif o_arg == "-i":
            inyos = a_arg
        elif o_arg == "-v":
            out_netlist = a_arg
        else:
            assert False, "unhandled option"

    # Read the example yos file and replicate most of it. Replace the
    #   project files with our source files
    out_file = None
    if outfile is not None:
        try:
            out_file = open(outfile, "w")
        except IOError:
            print("Could not open output file!")
            sys.exit(2)

    with open(inyos) as prj_file:
        for line in prj_file:
            print_or_write(out_file, line)
            if line.strip() == "# Read verilog input files":
                done = []
                for src in reversed(range(len(srcs))):
                    if str(pathlib.Path(srcs[0]).stem) + ".v" in srcs[src]:
                        continue
                    if srcs[src] not in done:
                        done.append(srcs[src])
                        if srcs[src][-4:] == ".vhd":
                            # Yosys doesn't natively support VHDL.
                            print("Ignoring VHDL file", srcs[src], " -- VHDL not supported")
                            # print_or_write(of, "read_vhdl " + src + "\n")
                            # print_or_write(of, "verific -vhdl " + src + "\n")
                        elif srcs[src][-2:] == ".v" or srcs[src][-3:] == ".vh":
                            print_or_write(out_file, "read_verilog " + srcs[src] + "\n")
                        else:
                            print("Unrecognized file type", srcs[src])
                print_or_write(out_file, "read_verilog " + srcs[src] + "\n")
            if line.strip() == "# Run xilinx synthesis passes":
                # print_or_write(of, "synth_xilinx -edif " + "yosys.edif" + "\n")
                print_or_write(out_file, "synth_xilinx -edif " + pathlib.Path(srcs[src]).stem +
                ".edf" + " -top " + pathlib.Path(srcs[src]).stem + "\n")
            if line.strip() == "# Now write the verilog output":
                print_or_write(out_file, "write_verilog " + out_netlist + "\n")
    print_or_write(out_file, "\n")


if __name__ == "__main__":
    main()
