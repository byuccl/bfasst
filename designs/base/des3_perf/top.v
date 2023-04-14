`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2017 04:14:44 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk,
    input [15:0] sw,
    output [15:0] led
    );
    
    // This is a very simple top module that instantiates a des3_perf module.
    // I anticipate that we may find a perfect match with this simple design
    // In the future, I hope to add viterbi modules to the top module and
    // will inspect if and how much this changes the instantiated des3_perf.
    
    wire	[63:0]	desOut;
    wire    [63:0]    desIn;
    wire    [55:0]    key1;
    wire    [55:0]    key2;
    wire    [55:0]    key3;
    wire        decrypt;
    
    assign desIn = {4{sw[15:0]}};
    assign key1 = desIn[63:8];
    assign key2 = desIn[60:5];
    assign key3 = desIn[55:0];
    assign decrypt = desIn[23];
    
    des3_perf des3_perf_0(desOut, desIn, key1, key2, key3, decrypt, clk);
    
    assign led[15:0] = {16{^desOut}};
    
endmodule
