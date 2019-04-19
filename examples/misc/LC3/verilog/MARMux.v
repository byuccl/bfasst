`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:14 03/22/2011 
// Design Name: 
// Module Name:    MARMux 
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
module MARMux(IR,eabOut,selMAR,MARMuxOut);
input selMAR;
input[15:0] eabOut;
input[7:0] IR;
output[15:0] MARMuxOut;

assign MARMuxOut = selMAR ? {{8{1'b0}},IR} : eabOut;

endmodule
