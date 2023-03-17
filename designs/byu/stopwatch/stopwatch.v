//////////////////////////////////////////////////////////////////////////////////
// Company: Brigham Young University
// Engineer: Samuel Reynolds
// 
// Create Date: 05/02/2022 03:41:22 PM
// Design Name: Stopwatch
// Module Name: stopwatch
// Project Name: 
// Target Devices: xc7a200tsbg484-1
// Tool Versions: 
// Description: This is the Stopwatch module from Lab 7 of the BYU ECEn 220 course.
// Once completed, it will be used on the FPGA board to turn the SSD into a stopwatch.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Originally created 3/10/21.
// 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module stopwatch(
    output [3:0] digit0, digit1, digit2, digit3,
    input wire clk, reset, run
);

wire newIncrement, newIncrement1, newIncrement2, rolling, newRun;
wire [19:0] out;

mod_counter MC0 (digit0, newIncrement, clk, reset, newRun);
mod_counter MC1 (digit1, newIncrement1, clk, reset, newIncrement);
mod_counter MC2 (digit2, newIncrement2, clk, reset, newIncrement1);
mod_counter #(6, 3) MC3 (digit3, rolling, clk, reset, newIncrement2);
mod_counter #(1000000, 20) MC4 (out, newRun, clk, reset, run);

endmodule