/*
* aes128 top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../../random_number_generator.sv"

module aes128_random(
    input logic clk,
    input logic reset,
    output logic [127:0] out
);

logic [127:0] a1; 
logic [127:0] a2;

RandomNumberGenerator #(128, 3) rng1(
  .clk(clk),
  .reset(reset),
  .random_number(a1)
);

RandomNumberGenerator #(128, 17) rng2(
  .clk(clk),
  .reset(reset),
  .random_number(a2)
);

aes128 aes(
  .clk(clk),
  .state(a1),
  .key(a2),
  .out(out)
);

endmodule