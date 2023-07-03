/*
* apbctrl top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module apbctrl_random(
    input logic clk,
    input logic reset,
    input logic ahbi,
    output logic ahbo,
    output logic apbi
    );

logic [31:0] apbo;

RandomNumberGenerator #(32, 3) rng_apbo (
  .clk(clk),
  .reset(reset),
  .random_number(apbo[31:0])
);

apbctrl apbctrl (
    .clk(clk),
    .rst(reset),
    .ahbi(ahbi),
    .ahbo(ahbo),
    .apbi(apbi),
    .apbo(apbo[31:0])
);

endmodule