/*
* mctrl top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module mctrl_random(
    input logic clk,
    input logic reset,
    input logic memi,
    output logic memo,
    input logic ahbsi,
    output logic ahbso,
    input logic apbi,
    output logic apbo,
    input logic wpo,
    output logic sdo
    );

mctrl mctrl (
    .clk(clk),
    .rst(reset),
    .memi(memi),
    .memo(memo),
    .ahbsi(ahbsi),
    .ahbso(ahbso),
    .apbi(apbi),
    .apbo(apbo),
    .wpo(wpo),
    .sdo(sdo)
);

endmodule