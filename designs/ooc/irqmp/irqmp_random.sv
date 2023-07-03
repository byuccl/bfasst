/*
* irqmp top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module irqmp_random(
    input logic clk,
    input logic reset,
    input logic apbi,
    output logic apbo,
    output logic [31:0] irqo
    );

logic [31:0] irqi;

RandomNumberGenerator #(32, 3) rng_irqi (
  .clk(clk),
  .reset(reset),
  .random_number(irqi[31:0])
);

irqmp irqmp (
    .clk(clk),
    .rst(reset),
    .apbi(apbi),
    .apbo(apbo),
    .irqi(irqi[31:0]),
    .irqo(irqo[31:0])
);

endmodule