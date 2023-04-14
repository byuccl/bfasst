//////////////////////////////////////////////////////////////////////////////////
// Company: Brigham Young University
// Engineer: Samuel Reynolds
// 
// Create Date: 05/02/2022 03:43:12 PM
// Design Name: Mod Counter
// Module Name: mod_counter
// Project Name: 
// Target Devices: xc7a200tsbg484-1
// Tool Versions: 
// Description: This is the Mod Counter module used in the Stopwatch module from Lab 7 of the BYU ECEn 220 course.
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

module mod_counter #(parameter MOD_VALUE = 10, WIDTH = 4)(
    output reg [WIDTH - 1:0] count,
    output rolling_over,
    input clk, reset, increment
);

always @ (posedge clk) begin

    if (reset)
        count <= 0;
        
    else if ((count == MOD_VALUE - 1) && (increment))
        count <= 0;

    else if (increment)
        count <= count + 1;
end

assign rolling_over = (increment && (count == MOD_VALUE - 1));

endmodule