/*
* mkPktMerge top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module mkPktMerge_random(
    input logic clk,
	input logic reset,
	input logic EN_iport0_put,
	output logic RDY_iport0_put,
	input logic EN_iport1_put,
	output logic RDY_iport1_put,
	input logic EN_oport_get,
	output logic RDY_oport_get
    );

logic [152:0] iport0_put;
logic [152:0] iport1_put; 
logic [152:0] oport_get; //doesn't need rng


RandomNumberGenerator #(153, 3) rng_iport0_put (
  .clk(clk),
  .reset(reset),
  .random_number(iport0_put[152:0])
);

RandomNumberGenerator #(153, 5) rng_iport1_put (
  .clk(clk),
  .reset(reset),
  .random_number(iport1_put[152:0])
);

mkPktMerge mkPktMerge (
    .CLK(clk),
	.RST_N(reset),
	.iport0_put(iport0_put[152:0]),
	.EN_iport0_put(EN_iport0_put),
	.RDY_iport0_put(RDY_iport0_put),
	.iport1_put(iport1_put[152:0]),
	.EN_iport1_put(EN_iport1_put),
	.RDY_iport1_put(RDY_iport1_put),
	.EN_oport_get(EN_oport_get),
	.oport_get(oport_get[152:0]),
	.RDY_oport_get(RDY_oport_get)
    );

endmodule