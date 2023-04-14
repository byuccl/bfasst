`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2017 04:11:09 PM
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
    
    wire [15:0] adr_in = sw[15:0];
    wire [31:0] data_in = {2{sw[15:0]}};
    
    wire wb_ack_top, valid_top;
    wire [31:0] wb_data_top, un_top;
    
    pid_simple pid_simple_0(.i_clk(clk),
        .i_rst(sw[0]),
        .i_wb_cyc(sw[1]),
        .i_wb_stb(sw[2]),
        .i_wb_we(sw[3]),
        .i_wb_adr(adr_in),
        .i_wb_data(data_in),
        .o_wb_ack(wb_ack_top),
        .o_wb_data(wb_data_top),
        .o_un(un_top),
        .o_valid(valid_top));
        
    assign led = {16{wb_ack_top ^ valid_top ^ ^{wb_data_top} ^ ^{un_top}}};
    
endmodule
