import argparse
import pathlib
import re


def main(verilog_in, verilog_out, module_name):
    assert verilog_in.is_file()

    with open(verilog_in, "r") as fp:
        text = fp.read()

    match = re.match("(.*)^(\w*module " + module_name + ".*)", text, re.M | re.DOTALL)
    assert match

    new_text = match.group(1) + '(* DONT_TOUCH = "yes" *)\n' + match.group(2)
    with open(verilog_out, "w") as fp:
        fp.write(new_text)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("verilog_in", type=pathlib.Path)
    parser.add_argument("verilog_out", type=pathlib.Path)
    parser.add_argument("module_name", type=str)
    args = parser.parse_args()

    main(args.verilog_in, args.verilog_out, args.module_name)
