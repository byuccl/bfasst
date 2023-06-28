/*
* sap top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module sap_random(
    input logic clk,
    input logic reset,
    output logic hlt,
    output logic [7:0] q3
    );

sap sap (
    .clk(clk),
    .clr(reset),
    .hlt(hlt),
    .q3(q3[7:0])
);

endmodule