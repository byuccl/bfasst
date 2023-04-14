`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2017 01:44:07 PM
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
        input wire [15:0] sw,
        input wire [7:0] JA, JB, JC, JD,
        input wire btnCpuReset, clk,
        output wire [15:0] led
    );
    
    wire [15:0] sum_o;
    wire cout_o;
    
    bcd_adder bcd_adder_0(
        .clk_i(clk),
        .a_i(sw),
        .b_i({8'hAB, JD}),
        .sum_o(sum_o),
        .cin_i(sw[0]),
        .cout_o(cout_o)   
    );
    
    wire [199:0] rco;
    
    big_counter big_counter_0(
        .clk(clk),
        .en_in(sw[1]),
        .rco(rco)
    );
    
    wire [49*8-1:0] readdata_o;
    wire done_o, interrupt_o; 
    
    bubblesort bubblesort_0(
        .clk(clk),
        .rst(btnCpuReset),
        .load_i({JA, JB, JC, JD, JA, JB, sw[2]}),
        .writedata_i({2{rco}}[49*8-1:0]),
        .readdata_o(readdata_o),
        .start_i(cout_o),
        .done_o(done_o),
        .interrupt_o(interrupt_o),
        .abort_i(^sum_o)
    );
    
    assign led[0] = ^readdata_o;
    assign led[1] = done_o;
    assign led[2] = interrupt_o;
    assign led[3] = sum_o[0] & sum_o[1];
    assign led[4] = sum_o[2] & sum_o[3];
    assign led[5] = sum_o[4] & sum_o[5];
    assign led[6] = sum_o[6] & sum_o[7];
    assign led[7] = sum_o[8] & sum_o[9];
    assign led[8] = sum_o[10] & sum_o[11];
    assign led[9] = sum_o[12] & sum_o[13];
    assign led[10] = sum_o[14] & sum_o[15];
    
endmodule
