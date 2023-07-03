/*
* sha3_high_throughput top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module sha3_high_throughput_random(
    input logic clk,
    input logic reset,
    input logic in_ready, is_last,
    output logic buffer_full,
    // output logic [511:0] out,
    output reg out_ready
    );

logic [511:0] out;

logic [63:0] in;
logic [2:0] byte_num;

RandomNumberGenerator #(64, 3) rng_in (
  .clk(clk),
  .reset(reset),
  .random_number(in[63:0])
);

RandomNumberGenerator #(3, 5) rng_byte_num (
  .clk(clk),
  .reset(reset),
  .random_number(byte_num[2:0])
);

sha3_high_throughput sha3_high_throughput (
    .clk(clk), 
    .reset(reset),
    .in(in[63:0]),
    .in_ready(in_ready), 
    .is_last(is_last),
    .byte_num(byte_num[2:0]),
    .buffer_full(buffer_full),
    .out(out[511:0]),
    .out_ready(out_ready)
);

endmodule