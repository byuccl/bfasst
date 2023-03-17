`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:03:41 03/22/2011 
// Design Name: 
// Module Name:    IR 
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
module IR(clk,ldIR,reset,Buss,IR);
input clk,ldIR,reset;
input[15:0] Buss;
output[15:0] IR;

//module register(dout, clk, din, clear, writeEn);
register PCreg(IR,clk,Buss,reset,ldIR);

endmodule
