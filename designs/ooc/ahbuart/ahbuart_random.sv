/*
* ahbuart top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../../random_number_generator.sv"

module ahbuart_random(
    input logic clk,
    input logic reset,
    input logic uarti,
    output logic uarto,
    input logic apbi,
    output logic apbo,
    input logic ahbi,
    output logic ahbo
    );

ahbuart ahbuart (
    .clk(clk),
    .rst(reset),
    .uarti(uarti),
    .uarto(uarto),
    .apbi(apbi),
    .apbo(apbo),
    .ahbi(ahbi),
    .ahbo(ahbo)
);

endmodule