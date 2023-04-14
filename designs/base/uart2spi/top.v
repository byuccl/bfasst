`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2017 10:59:08 AM
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
    output [15:0] led,
    output RGB1_Red
    );
    
    wire [63:0] concat;
    assign concat = {sw, sw, sw, sw};
    
    wire top_valid_out;
    wire [15:0] top_data_out;
    
    gng gng_0(
        .INIT_Z1(concat),
        .INIT_Z2(concat),
        .INIT_Z3(concat),
        .clk(clk),
        .rstn(sw[0]),
        .ce(sw[1]),
        .valid_out(top_valid_out),
        .data_out(top_data_out)
    );
    
    assign led = top_data_out;
    
    
    wire frm_error, par_error, baud_clk_16x;
    wire txd, sck, so;
    wire [3:0] cs_n;
    
    uart2spi uart2spi_0 (
        concat[0],
        clk,
        concat[0],
        concat[1],
        concat[2],
        concat[4:3],
        concat[16:5],
        frm_error,
        par_error,
        baud_clk_16x,
        concat[16],
        txd,
        sck,
        so,
        concat[17],
        cs_n
    );
    wire red;
    assign red = top_valid_out ^ frm_error ^ par_error ^ baud_clk_16x ^ txd ^ sck ^ so  ^ (^cs_n);
    assign RGB1_Red = red;
    
endmodule
