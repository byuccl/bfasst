`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:26:08 03/22/2011 
// Design Name: 
// Module Name:    EAB 
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
module EAB(IR,Ra,PC,selEAB1,selEAB2,eabOut);
input[10:0] IR;
input[15:0] Ra,PC;
input selEAB1;
input[1:0]selEAB2;
output[15:0] eabOut;

wire[15:0] addr2muxOut,addr1muxOut;

assign addr2muxOut  = 	selEAB2 == 2'b11 ? {{5{IR[10]}},IR[10:0]}	:	
								selEAB2 == 2'b10 ? {{7{IR[8]}},IR[8:0]}	:
								selEAB2 == 2'b01 ? {{10{IR[5]}},IR[5:0]}	:
								16'b0000000000000000;
													
assign addr1muxOut  =   selEAB1 ? Ra : PC;

assign eabOut = addr2muxOut + addr1muxOut;

endmodule
