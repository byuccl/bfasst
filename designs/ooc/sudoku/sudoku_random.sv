/*
* sudoku top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../../random_number_generator.sv"

module sudoku_random(
    input logic clk,
    input logic reset,
    input logic clr,
    input logic start,
    // output logic [728:0] outGrid,
    output logic [6:0] unsolvedCells,
    output logic timeOut,
    output logic allDone,
    output logic anyChanged,
    output logic anyError,
    output logic [6:0] minIdx,
    output logic [3:0] minPoss
    );

logic [728:0] inGrid;
logic [728:0] outGrid;

// RandomNumberGenerator #(729, 3) rng_inGrid (
//   .clk(clk),
//   .reset(reset),
//   .random_number(inGrid[728:0])
// );

RandomNumberGenerator #(729, 5) rng_outGrid (
  .clk(clk),
  .reset(reset),
  .random_number(outGrid[728:0])
);

sudoku sudoku (
    .clk(clk),
    .rst(reset),
    .clr(clr),
    .start(start),
    .inGrid(inGrid[728:0]),
    .outGrid(outGrid[728:0]),
    .unsolvedCells(unsolvedCells[6:0]),
    .timeOut(timeOut),
    .allDone(allDone),
    .anyChanged(anyChanged),
    .anyError(anyError),
    .minIdx(minIdx[6:0]),
    .minPoss(minPoss[3:0])
);

endmodule