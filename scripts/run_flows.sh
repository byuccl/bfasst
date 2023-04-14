# This runs the experiments used to create the HTML file used on github webpage
# These flows use conformal to perform the comparisons

# This flow compares the files before and after yosys synthesis
# Original files -----> Yosys Synth -----> Vivado Impl ----->  fasm2bels reversed bitstream
#      ^---Flow Comparison---^ 
python scripts/run_experiment.py experiments/yosys_only.yaml;

# This flow compares the files after yosys synthesis with the files from vivado implementation
# Original files -----> Yosys Synth -----> Vivado Impl ----->  fasm2bels reversed bitstream
#                           ^---Flow Comparison---^ 
python scripts/run_experiment.py experiments/yosys_synth_vivado_impl.yaml;

# This flow compares the files after implementation in vivado with the files that are reversed from the bitstream
# Original files --> Yosys Synth --> Vivado Impl -->  fasm2bels reversed bitstream
#                                          ^---Flow Comparison---^ 
python scripts/run_experiment.py experiments/vivado_impl_fasm_bit.yaml; 

# This flow compares the original files with the ones made by reversing the bitstream
# Original files --> Yosys Synth --> Vivado Impl -->  fasm2bels reversed bitstream
#       ^----------------------Flow Comparison----------------------^ 
python scripts/run_experiment.py experiments/full_flow.yaml; 