`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2017 02:08:02 PM
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
    input [15:0] sw,
    input [4:0] btn, // Not used
    output [15:0] led,
    output [6:0] seg, // Not used
    output dp, // Not used
    output [7:0] an // Not used
    );
    
    wire [31:0] Z; 
    wire btnCpuReset;
    wire [7:0] sw2, JA, JB, JC, JD;

    assign btnCpuReset = reset;
    assign sw2 = sw[7:0];
    assign JA = sw[15:8];
    assign JB = {btn, sw[15:13]};
    assign JC = {btn ^ sw[12:8], btn[2:0] & sw[2:0]};
    assign JD = {sw[15:8] ^ sw[7:0]};

    
    
    fixed_point_sqrt fixed_point_sqrt_0(
        .clk(clk),
        .res(btnCpuReset),
        .ARG({JA, JB, JC, JD}),
        .Z(Z)
    );
    
    wire [15:0] my_output;
    wire framereset, en_bild, readmem;
    
    graphiti graphiti_0(
        .clk(clk),
        .clk15M(clk),
        .reset(btnCpuReset),
        .\output (my_output),
        .in_r(JA[3:0]),
        .in_g(JB[3:0]),
        .in_b(JC[3:0]),
        .framereset(framereset),
        .en_bild(en_bild),
        .readmem(readmem)
    );
    
    wire o_text_done, o_rdy;
    wire [63:0] o_text_out;
    
    hight hight_0(
        .rstn(btnCpuReset),
        .clk(clk),
        .i_mk_rdy(sw2[0]),
        .i_mk({16{JA}}),
        .i_post_rdy(sw2[1]),
        .i_op(sw2[2]),
        .i_text_val(sw2[3]),
        .i_text_in({2{Z}}),
        .o_text_done(o_text_done),
        .o_text_out(o_text_out),
        .o_rdy(o_rdy)
    );
    
    wire [3:0] rand_out;
    
    lfsr_randgen lfsr_randgen_0(
        .clk(clk),
        .set_seed(o_rdy),
        .seed({4{o_text_done}}),
        .rand_out(rand_out)
    );
    
    wire [15:0] addr;
    wire readmem_cpu, writemem, readio, writeio, inta;
    wire [7:0] data;
    
    cpu8080 cpu8080_0(
        .addr(addr),
        .data(data),
        .readmem(readmem_cpu),
        .writemem(writemem),
        .readio(readio),
        .writeio(writeio),
        .intr(framereset ^ en_bild ^ readmem),
        .inta(inta),
        .waitr(^rand_out[3:0]),
        .reset(btnCpuReset),
        .clock(clk)
    );
    
    assign led[4:0] = {readmem_cpu, writemem, readio, writeio, inta};
    assign led[5] = ^addr;
    assign led[6] = ^my_output;
    assign led[7] = o_text_out ^ readmem;
    assign led[15:8] =  data;

    
endmodule
