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
    input reset, // Not used
    input [15:0] sw,
    input [4:0] btn, // Not used
    output [15:0] led,
    output [6:0] seg, // Not used
    output dp,
    output [7:0] an // Not used
    );

    assign seg = {btn, reset, 1'b0};
    assign an = 8'b00000000;
    
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
        .line_reset_n(concat[0]),
        .line_clk(clk),
        .cfg_tx_enable(concat[0]),
        .cfg_rx_enable(concat[1]),
        .cfg_stop_bit(concat[2]),
        .cfg_pri_mod(concat[4:3]),
        .cfg_baud_16x(concat[16:5]),
        .frm_error(frm_error),
        .par_error(par_error),
        .baud_clk_16x(baud_clk_16x),
        .rxd(concat[16]),
        .txd(txd),
        .sck(sck),
        .so(so),
        .si(concat[17]),
        .cs_n(cs_n)
    );
    wire red;
    assign red = top_valid_out ^ frm_error ^ par_error ^ baud_clk_16x ^ txd ^ sck ^ so  ^ (^cs_n);
    assign dp = red;
    
endmodule
