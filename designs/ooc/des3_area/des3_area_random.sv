/*
* des3_area top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../../random_number_generator.sv"

module des3_area_random(
    input logic clk,
    input logic reset,
    output logic [63:0]	desOut,
    input logic decrypt
);

logic [63:0] desIn;
logic [55:0] key1;
logic [55:0] key2;
logic [55:0] key3;
logic [5:0] roundSel;

RandomNumberGenerator #(64, 3) rng_desIn (
  .clk(clk),
  .reset(reset),
  .random_number(desIn[63:0])
);

RandomNumberGenerator #(56, 5) rng_key1 (
  .clk(clk),
  .reset(reset),
  .random_number(key1[55:0])
);

RandomNumberGenerator #(56, 7) rng_key2 (
  .clk(clk),
  .reset(reset),
  .random_number(key2[55:0])
);

RandomNumberGenerator #(56, 9) rng_key3 (
  .clk(clk),
  .reset(reset),
  .random_number(key3[55:0])
);

RandomNumberGenerator #(6, 11) rng_roundSel (
  .clk(clk),
  .reset(reset),
  .random_number(roundSel[5:0])
);

des3_area des3_area (
    .clk(clk),
    .desOut(desOut[63:0]),
    .desIn(desIn[63:0]),
    .key1(key1[55:0]),
    .key2(key2[55:0]),
    .key3(key3[55:0]),
    .decrypt(decrypt),
    .roundSel(roundSel[5:0])
);

endmodule