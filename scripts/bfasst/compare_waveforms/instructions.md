***WaFoVe***
*WaveForm Verification*

**Waveform Comparison Tool Installation Instructions**

Use `make` while in the WaFoVe directory.

**How To Run**

`usage: compare_waveforms.py [--base BasePath] [--tech TechLib] [-f] [--newTests] [--testBench TBLocation] [-t TESTS] [--vivado VIVADO] [--waveform] File1 File2`

positional arguments:
  File1: Path to first verilog netlist.
  File2: Path to second verilog netlist.

optional arguments:
  -h, --help            show this help message and exit
  --base BasePath       Base path to store files (defaults to the out folder).
  --tech TechLib        Path to tech library (defaults to cells_sim.v in templates).
  -f, --fullScreen      Specifies if graphs should be viewed in fullscreen.
  --newTests            Location of the testbench template file (defaults to sample_tb.v in templates).
  --testBench TBLocation
                        Location of the testbench template file (defaults to sample_tb.v in templates).
  -t TESTS, --tests TESTS
                        The number of tests to run. If not set, defaults to 100.
  --vivado VIVADO       Additional argument for waveform, specifies the Vivado Bin Path to launch Vivado.
  --waveform            Run gtkwave at the end of the verification process or on a previously ran test.

**Limitations**
A few things need to be in place in order for it to work properly:
* Two verilog netlists being compared must have the same IO ports.
* The verilog files must be netlists, they cannot be a regular design.
* A tech-library is required for IVerilog to properly implement their testbenches. (Note: A defualt library is pulled from Yosys during the Make process.)
* Clocks must be named "clk" at this point. Future implementations for this will be made.
* The effectiveness of the testbenches is not considered at this time. In the future, tests will be made to show their effectiveness.
