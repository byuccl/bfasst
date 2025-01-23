/*
* sha3_low_throughput top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../../random_number_generator.sv"

module sha3_low_throughput_random(
    input logic clk,
    input logic reset,
    input logic in_ready,
    input logic is_last,
    output logic buffer_full,
    // output logic [511:0] out,
    output reg out_ready
    );

logic [511:0] out;

logic [31:0] in;
logic [1:0] byte_num;

RandomNumberGenerator #(32, 3) rng_in (
  .clk(clk),
  .reset(reset),
  .random_number(in[31:0])
);

RandomNumberGenerator #(2, 5) rng_byte_num (
  .clk(clk),
  .reset(reset),
  .random_number(byte_num[1:0])
);

sha3_low_throughput sha3_low_throughput (
    .clk(clk),
    .reset(reset),
    .in(in[31:0]),
    .in_ready(in_ready), 
    .is_last(is_last),
    .byte_num(byte_num[1:0]),
    .buffer_full(buffer_full),
    .out(out[511:0]),
    .out_ready(out_ready)
);

endmodule