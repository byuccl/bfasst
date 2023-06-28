/*
* ahbctrl top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module ahbctrl_random(
    input logic clk,
    input logic reset,
    output logic msti,
    input logic msto,
    output logic slvi,
    input logic slvo,
    input logic testen,
    input logic testrst,
    input logic scanen,
    input logic testoen
    );

logic [31:0] testsig;

RandomNumberGenerator #(32, 3) rng_testsig (
  .clk(clk),
  .reset(reset),
  .random_number(testsig[31:0])
);

ahbctrl ahbctrl (
    .clk(clk),
    .rst(reset),
    .msti(msti),
    .msto(msto),
    .slvi(slvi),
    .slvo(slvo),
    .testen(testen),
    .testrst(testrst),
    .scanen(scanen),
    .testoen(testoen),
    .testsig(testsig[31:0])
);

endmodule