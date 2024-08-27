This is a design of high radix switch fabric with 10 gb/s ports
The top level design file is './gsm/gsm_sys.v'

For implementation purpose, a wrapper './gsm/gsm_imple.v' is added
so that the tool will not fail due to I/O pin limit. 

For simulation, the top level testbench wrapper is './test/gsm_test.v'

Major parameters of the design are:
-MWIDTH: multicast width, which is the number of port of each sub-switch
-GSIZE: group size, number of sub-switch in each tile
-DWIDTH: the data width of the data bus
-AWIDTH: the depth of packet buffer for each port in the sub-switch

The capacity of the switch is determined by 'MWIDTH' and 'GSIZE', where
the total number of ports in the switch 'N = MWIDTH * GSIZE'.

The 'DWIDTH' determines the data bus width, clock frequency of the system
and the routing resource cost. 

The system has two clocks: clk_80M and clk_320M.
For 'DWIDTH=128', clk_80M should be exactly 80MHz and clk_320M should be
320MHz. However, the design can not meet timing with this configuration.
Therefore, 'DWIDTH' is set to be 256, and the clk_80M now requires 40MHz
and clk_320M requires only 160MHz.

Since the current design doesn't use array port technique, it is not feasible
right now to scale the design directly by modifying the parameters of 'MWIDTH'
and "GSIZE'. This feature will be available in the next version of the design.

any question can be directed to Zefu Dai (zdai@eecg.toronto.edu)

Dec. 12th 2012
