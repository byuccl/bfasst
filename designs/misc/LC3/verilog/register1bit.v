`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:06:44 03/22/2011 
// Design Name: 
// Module Name:    register1bit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module register1bit(dout, clk, din, reset, load);

input clk, reset, load; 
input din;
output reg dout;

always @(posedge clk)

if (reset) dout <= 1'b0;
else if (load) dout <= din;

endmodule