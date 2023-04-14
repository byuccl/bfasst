`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:06:46 04/05/2011 
// Design Name: 
// Module Name:    register 
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
module register(dout, clk, din, reset, load);

input clk, reset, load; 
input [15:0] din;
output reg [15:0] dout;

always @(posedge clk)

if (reset) dout <= 15'd1; //state 000000000000001 is fetch1
else if (load) dout <= din;

endmodule 