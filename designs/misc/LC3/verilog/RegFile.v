`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:32:12 03/22/2011 
// Design Name: 
// Module Name:    RegFile 
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
module RegFile(clk,regWE,reset,DR,SR1,SR2,Buss,Rb,Ra);
input clk,regWE,reset;
input[2:0] DR,SR1,SR2;
input[15:0] Buss;
output[15:0] Rb,Ra;

(* S = "TRUE" *) (* KEEP = "TRUE" *) wire[15:0] reg0d,reg1d,reg2d,reg3d,reg4d,reg5d,reg6d,reg7d;
wire[7:0] regDecode;

//module register(dout, clk, din, clear, writeEn);
register reg0(reg0d,clk,Buss,reset,regWE & regDecode[0]);
register reg1(reg1d,clk,Buss,reset,regWE & regDecode[1]);
register reg2(reg2d,clk,Buss,reset,regWE & regDecode[2]);
register reg3(reg3d,clk,Buss,reset,regWE & regDecode[3]);
register reg4(reg4d,clk,Buss,reset,regWE & regDecode[4]);
register reg5(reg5d,clk,Buss,reset,regWE & regDecode[5]);
register reg6(reg6d,clk,Buss,reset,regWE & regDecode[6]);
register reg7(reg7d,clk,Buss,reset,regWE & regDecode[7]);

assign regDecode = 	DR == 3'd0 ? 8'd1		:
							DR == 3'd1 ? 8'd2		:
							DR == 3'd2 ? 8'd4		:
							DR == 3'd3 ? 8'd8		:
							DR == 3'd4 ? 8'd16	:
							DR == 3'd5 ? 8'd32	:
							DR == 3'd6 ? 8'd64	: 
							8'd128;
							
assign Ra = SR1 == 3'd0 ? reg0d	:
				SR1 == 3'd1	? reg1d	:
				SR1 == 3'd2	? reg2d	:
				SR1 == 3'd3	? reg3d	:
				SR1 == 3'd4	? reg4d	:
				SR1 == 3'd5	? reg5d	:
				SR1 == 3'd6	? reg6d	:
				reg7d;
				
assign Rb = SR2 == 3'd0 ? reg0d	:
				SR2 == 3'd1	? reg1d	:
				SR2 == 3'd2	? reg2d	:
				SR2 == 3'd3	? reg3d	:
				SR2 == 3'd4	? reg4d	:
				SR2 == 3'd5	? reg5d	:
				SR2 == 3'd6	? reg6d	:
				reg7d;

endmodule
