/*
* grethm top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module grethm_random(
    input logic clk,
    input logic reset,
    input logic ahbmi,
    output logic ahbmo,
    input logic apbi,
    output logic apbo,
    input logic ethi,
    output logic etho
    );

grethm grethm (
    .clk(clk),
    .rst(reset),
    .ahbmi(ahbmi),
    .ahbmo(ahbmo),
    .apbi(apbi),
    .apbo(apbo),
    .ethi(ethi),
    .etho(etho)
);

endmodule