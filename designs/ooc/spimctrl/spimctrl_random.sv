/*
* spimctrl top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../../random_number_generator.sv"

module spimctrl_random(
    input logic clk,
    input logic reset,
    input logic ahbsi,
    output logic ahbso,
    input logic spii,
    output logic spio
    );

spimctrl spimctrl (
    .clk(clk),
    .rstn(reset),
    .ahbsi(ahbsi),
    .ahbso(ahbso),
    .spii(spii),
    .spio(spio)
);

endmodule