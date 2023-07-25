'''
To be called by compile_designs.sh ONLY
'''

from pathlib import Path
import shutil

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("FILE", help="Verilog file to make output directories for")

    args = parser.parse_args()

    if args.FILE:
        # Make output directories
        name = args.FILE[:-2]
        dest = Path.cwd() / "results" / name
        if dest.is_dir():
            shutil.rmtree(dest)
        dest.mkdir()
        dest = dest / "original_design"
        if dest.is_dir():
            shutil.rmtree(dest)
        dest.mkdir()

        # Remove format that causes DANA verilog parse error (HAL issue #459)
        # Expects verilog file from tcl write_verilog command. 
        # Runs under the assumption that comments only start at the beginning
        # of a line
        f = open("vivado_tmp_verilog.v", "r")
        nf = open("fixed_file.v", "w")
        line = f.readline()
        while line:
            if not line.startswith("//"):
                line = line.replace("//", "--")
            nf.write(line)
            line = f.readline()

        f.close()
        nf.close()
        Path("vivado_tmp_verilog.v").unlink()

        # Organize output files
        shutil.move("vivado_tmp_edif.edif", f"results/{name}/{name}.edif")
        shutil.copy("fixed_file.v", f"results/{name}/original_design/{name}.v")
        shutil.move("fixed_file.v", f"results/{name}/{name}.v")
        shutil.move("vivado_tmp_checkpt.dcp", f"results/{name}/original_design/{name}.dcp")
        shutil.move("utilization_report.txt", f"results/{name}/original_design")


    