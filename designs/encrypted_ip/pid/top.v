`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2017 12:13:08 PM
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
    input reset,
    input [15:0] sw, // Not used
    input [4:0] btn, // Not used
    output [15:0] led, // Not used
    output [6:0] seg, // Not used
    output reg dp,
    output [7:0] an // Not used
    );


    
    parameter   wb_nb=32;
    parameter   adr_wb_nb=32;
    wire    i_wb_cyc;
    wire    i_wb_stb;
    wire    i_wb_we;
    wire    [adr_wb_nb-1:0]i_wb_adr;
    wire    [wb_nb-1:0]i_wb_data;
    wire    o_wb_ack;
    wire    [wb_nb-1:0]o_wb_data;
    
    //u(n) output
    wire    [31:0]o_un;
    wire    o_valid;
    
    
/*    module    divider_dshift(
    input    i_clk,
    input    i_rst,
    input    [31:0]i_dividend,
    input    [31:0]i_divisor,
    input    i_start,
    output    o_ready,
    output    reg    [31:0]o_quotient,
    output    reg    [31:0]o_remainder
    );*/

    wire [31:0] d0_q;
    wire [31:0] d0_r;
    
    wire [31:0] d1_q;
    wire [31:0] d1_r;
  
    wire [31:0] d2_q;
    wire [31:0] d2_r;
        
    wire [31:0] d3_q;
    wire [31:0] d3_r;
    
    wire [31:0] d4_q;
    wire [31:0] d4_r;
   
    
    wire d0_done;
    wire d1_done;
    wire d2_done;
    wire d3_done;
    wire d4_done;

    
    assign d0_q = 32'hDEADBEEF;
    assign d0_r = 32'hDEADBEEF;
    assign d0_done = 1'b1;
    assign i_wb_cyc = ^d2_r;
    assign i_wb_we = ^d2_q;

    divider_dshift divider_dshift_1(.i_clk(clk), .i_rst(reset), .i_dividend(d0_q), .i_divisor(d0_r), .i_start(d0_done), .o_ready(d1_done), .o_quotient(d1_q), .o_remainder(d1_r));
    divider_dshift divider_dshift_2(.i_clk(clk), .i_rst(reset), .i_dividend(d1_q), .i_divisor(d1_r), .i_start(d1_done), .o_ready(d2_done), .o_quotient(d2_q), .o_remainder(d2_r));
    divider_dshift divider_dshift_3(.i_clk(clk), .i_rst(reset), .i_dividend(d2_q), .i_divisor(d2_r), .i_start(d2_done), .o_ready(d3_done), .o_quotient(d3_q), .o_remainder(d3_r));
    
    
    pid pid_0(.i_clk(clk),
    .i_rst(reset),
    .i_wb_cyc(i_wb_cyc),
    .i_wb_stb(d3_done),
    .i_wb_we(i_wb_we),
    .i_wb_adr(d3_r),
    .i_wb_data(d3_q),
    .o_wb_ack(o_wb_ack),
    .o_wb_data(o_wb_data),
    .o_un(o_un),
    .o_valid(o_valid));
    
    always @(posedge clk)
    begin
        if (o_un == 0) begin
            dp = 1;
        end else 
            dp = 0;
    end
    
endmodule
