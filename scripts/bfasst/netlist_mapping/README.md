# ccl_netlist_mapping
* The [structural_mapping.py](./structural_mapping.py) script will map two different netlists based on the structure of each block and its connections.
* The [functional_mapping.py](./functional_mapping.py) script will map two different netlists based on the trees generated from the functions of the LUTs before each flipflop.
* The [ccl_mapping.py](./ccl_mapping.py) script will map two different netlists using structural algorithms for the flipflops connected to carry-chains and shift-registers, 
and a functional algorithm for the rest of the flipflops.

* Here is an example of how to run one of the scripts:  
$ python ccl_mapping.py netlist_examples/tx_impl.v netlist_examples/tx_reversed.v > mapped_points.txt

* The [mapped_points.txt](./mapped_points.txt) file generated can be used in Conformal Equivalence Checker by adding the following lines to the compare.do file:  
set system mode lec -nomap  
REAd MApped Points mapped_points.txt
