`timescale 1ns / 1ps

// IP that controls the LEDs using the switches

module int_mul_8(
    input clk,
    input reset,
    input [7:0] num1,
    input [7:0] num2,
    output [15:0] result
    );
    
    reg [7:0] num1_buf;
    reg [7:0] num2_buf;
    
    always @(posedge clk)
        if (!reset) begin
            num1_buf <= 0;
            num2_buf <= 0;
        end else begin
            num1_buf <= num1;
            num2_buf <= num2;
        end
    
    reg [15:0] result_buf;
    
    assign result = result_buf;
    
    always @(posedge clk)
        if (!reset)
            result_buf <= 0;
        else
            result_buf <= num1_buf * num2_buf;
endmodule
