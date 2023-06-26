/*
* bubblesort top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module bubblesort_random(
    input   logic clk,
    input   logic clk2,
    input   logic rst,
    input   logic reset,
    input   logic start_i,
    output  logic done_o,
    output  logic interrupt_o,
    input   logic abort_i
    );

logic [48:0] load_i;
logic [391:0] writedata_i;
logic [391:0] readdata_o;

RandomNumberGenerator #(49, 3) rng_load_i (
  .clk(clk),
  .reset(reset),
  .random_number(load_i[48:0])
);

RandomNumberGenerator #(392, 5) rng_writedata_i (
  .clk(clk),
  .reset(reset),
  .random_number(writedata_i[391:0])
);

// RandomNumberGenerator #(392, 7) rng_readdata_o (
//   .clk(clk),
//   .reset(reset),
//   .random_number(readdata_o[391:0])
// );

bubblesort sort (
    .clk(clk2),
    .rst(rst),
    .load_i(load_i[48:0]), 
    .writedata_i(writedata_i[391:0]),
    .readdata_o(readdata_o[391:0]),
    .start_i(start_i),
    .done_o(done_o),
    .interrupt_o(interrupt_o),
    .abort_i(abort_i)
);

endmodule