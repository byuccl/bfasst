/*
* md5_pipelined top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"
`include "md5_pipelined.v"

module md5_pipelined_random(
    input logic clk,
    input logic reset,
    output reg [31:0] a64, 
    output reg [31:0] b64, 
    output reg [31:0] c64, 
    output reg [31:0] d64
    );

wire [511:0] wb; 
wire [31:0] a0;
wire [31:0] b0; 
wire [31:0] c0; 
wire [31:0] d0; 

RandomNumberGenerator #(512, 3) rng_wb (
  .clk(clk),
  .reset(reset),
  .random_number(wb[511:0])
);

RandomNumberGenerator #(32, 5) rng_a0 (
  .clk(clk),
  .reset(reset),
  .random_number(a0[31:0])
);

RandomNumberGenerator #(32, 7) rng_b0 (
  .clk(clk),
  .reset(reset),
  .random_number(b0[31:0])
);

RandomNumberGenerator #(32, 9) rng_c0 (
  .clk(clk),
  .reset(reset),
  .random_number(c0[31:0])
);

RandomNumberGenerator #(32, 11) rng_d0 (
  .clk(clk),
  .reset(reset),
  .random_number(d0[31:0])
);

md5_pipelined md5_pipelined (
    .clk(clk),
    .wb(wb[511:0]), 
    .a0(a0[31:0]),
    .b0(b0[31:0]), 
    .c0(c0[31:0]), 
    .d0(d0[31:0]), 
    .a64(a64[31:0]), 
    .b64(b64[31:0]), 
    .c64(c64[31:0]), 
    .d64(d64[31:0])
);

endmodule