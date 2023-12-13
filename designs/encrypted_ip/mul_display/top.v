`timescale 1ns / 1ps

// Top level user-space module that instantiates IP

module top(
    input clk,
    input reset,
    input [15:0] sw,
    input [4:0] btn,
    output [15:0] led,
    output [6:0] seg,
    output dp,
    output [7:0] an
    );
    
    int_mul_8 int_mul_inst (
        .clk(clk),
        .reset(reset),
        .num1(sw[7:0]),
        .num2(sw[15:8]),
        .result(led[15:0])
    );
    
    configurable_display display_inst (
        .clk(clk),
        .reset(reset),
        .buttons(btn),
        .segments(seg),
        .dot_point(dp),
        .anodes(an)
    );
    
endmodule
