`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:08:46 03/22/2011 
// Design Name: 
// Module Name:    ts_driver 
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
module ts_driver ( din, dout, ctrl ); 
input [15:0] din;
input ctrl;
output [15:0] dout;

assign dout = (ctrl)? din:(16'bZZZZZZZZZZZZZZZZ);


endmodule 