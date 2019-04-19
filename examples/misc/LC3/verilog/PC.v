`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:49:53 03/22/2011 
// Design Name: 
// Module Name:    PC 
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
module PC(clk,reset,ldPC,eabOut,selPC,Buss,PC);
input clk,reset,ldPC;
input[15:0] eabOut,Buss;
input[1:0] selPC;
output[15:0] PC;

wire[15:0] PCMuxOut;

assign PCMuxOut = selPC == 2'b11 ? 16'b0000000000000000 	: // Though selPC shouldn't equal 11 ever.
						selPC == 2'b10 ? Buss 						:
						selPC == 2'b01 ? eabOut 					:
						PC + 1;						
						
//module register(dout, clk, din, clear, writeEn);
register PCreg(PC,clk,PCMuxOut,reset,ldPC);

endmodule
