`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:13:15 03/22/2011 
// Design Name: 
// Module Name:    ALU 
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
module ALU(IR,aluControl,Rb,Ra,aluOut);
input[1:0] aluControl;
input[5:0] IR;
input[15:0] Ra,Rb;
output[15:0] aluOut;

wire[15:0] sr2MuxOut;

assign sr2MuxOut = IR[5] ? {{11{IR[4]}},{IR[4:0]}} : Rb;

// NOTE: Made modification here: removed (* S = "TRUE" *) (* KEEP = "TRUE" *) 
assign aluOut = 	aluControl == 2'b00 ? Ra				 	:
						aluControl == 2'b01 ? Ra + sr2MuxOut 	:
						aluControl == 2'b10 ? Ra & sr2MuxOut		:
						~Ra;

endmodule
