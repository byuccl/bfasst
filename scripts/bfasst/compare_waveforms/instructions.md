**Waveform Comparison Tool Installation Instructions**

This tool will require installing `iverilog`, `gtkwave`, and `spydrnet`.

You can install iverilog and gtkwave by using the command `sudo apt install ____`

To use spydrnet and numpy, you must use the command `pip install _____`

This tool also supports Vivado. If you want to use Vivado, use the command --vivado alongside the path to your bin/vivado file.

**How To Run**

To run the tool, use the command `./scripts/run_design.py (DESIGN_PATH) xilinx_yosys_waveform`

To run this tool directly, use a command similar to `python3 -m bfasst.compare_waveforms.compare_waveforms ../build/xilinx_yosys_waveform/byu/alu/alu_impl.v ../build/xilinx_yosys_waveform/byu/alu/alu_reversed.v --vivado /tools/Xilinx/Vivado/2019.2/bin/vivado --quick --waveform`

The tool will provide prompts in certain cases such as if the test has already been run or if the current file-type is unsupported.
In these cases, it will ask the user to input either a `1` or a `0` to determine what to do next.

**Current State Of Program**
This program has proven effectiveness in several scenarios. A few things need to be in place in order for it to work properly:
* Two verilog netlists being compared must have the same IO ports.


**Currently supported features**
* Parsing designs that only have 1 verilog file as a source.
* Re-analyzing designs that have come back equivalent or unequivalent.
* Creating random test-benches and TCL scripts for any netlist generated with Vivado or F4PGA.
* Multi-verilog file design files.
* Linking to Vivado to compare waveforms with gtkwave.
* Parsing of diff.txt files to make them easier to read.




