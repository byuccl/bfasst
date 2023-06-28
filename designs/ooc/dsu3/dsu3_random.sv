/*
* dsu3 top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module dsu3_random(
    input logic clk,
    input logic reset,
    input logic ahbmi,
    input logic ahbsi,
    output logic ahbso,
    output logic [31:0] dbgo,
    input logic dsui,
    output logic dsuo
    );

logic [31:0] dbgi;

RandomNumberGenerator #(32, 3) rng_dbgi (
  .clk(clk),
  .reset(reset),
  .random_number(dbgi[31:0])
);

dsu3 dsu3 (
    .clk(clk),
    .rst(reset),
    .ahbmi(ahbmi),
    .ahbsi(ahbsi),
    .ahbso(ahbso),
    .dbgi(dbgi[31:0]),
    .dbgo(dbgo[31:0]),
    .dsui(dsui),
    .dsuo(dsuo)
);

endmodule