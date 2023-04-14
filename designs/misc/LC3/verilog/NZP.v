`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:08:03 03/22/2011 
// Design Name: 
// Module Name:    NZP 
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
module NZP(clk,reset,flagWE,Buss,N,Z,P);
input clk,flagWE,reset;
input[15:0] Buss;
output N,Z,P;

wire Nlogic,Zlogic,Plogic;

assign Nlogic = Buss[15] 					? 1'b1 : 1'b0;
assign Zlogic = Buss 						? 1'b0 : 1'b1;
assign Plogic = (~Buss[15] && ~Zlogic)	? 1'b1 : 1'b0;

//module register1bit(dout, clk, din, reset, load);
register1bit Nreg(N,clk,Nlogic,reset,flagWE);
register1bit Zreg(Z,clk,Zlogic,reset,flagWE);
register1bit Preg(P,clk,Plogic,reset,flagWE);

endmodule
