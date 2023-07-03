/*
* leon3s top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module leon3s_random(
    input logic clk,
    input logic reset,
    input logic ahbi,
    output logic ahbo,
    input logic ahbsi,
    input logic irqi,
    output logic irqo,
    input logic dbgi,
    output logic dbgo
    );

logic [31:0] ahbso;

RandomNumberGenerator #(32, 3) rng_ahbso (
  .clk(clk),
  .reset(reset),
  .random_number(ahbso[31:0])
);

leon3s leon3s (
    .clk(clk),
    .rstn(reset),
    .ahbi(ahbi),
    .ahbo(ahbo),
    .ahbsi(ahbsi),
    .ahbso(ahbso[31:0]),
    .irqi(irqi),
    .irqo(irqo),
    .dbgi(dbgi),
    .dbgo(dbgo)
);

endmodule