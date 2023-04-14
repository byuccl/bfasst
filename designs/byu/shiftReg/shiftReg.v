`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: BYU (Brigham Young University)
// Engineer: Jake Edvenson
// 
// Create Date: 05/4/2022 
// Design Name: shiftReg
// Project Name: bfasst testing
// Description:A simple register to shift values
// 
// Dependencies: None
// 
// LUT: 41
// FF: 16
// IO: 36
// BUFG: 1
//
//////////////////////////////////////////////////////////////////////////////////

//Works correctly

module shiftReg(clk,start,rst,data,shift,left, out);
input clk, start, rst, left;
input [7:0] data, shift;
output reg[15:0] out;

always@(posedge clk) begin
    if(rst)
        out <= 8'b0;
    else if(start)
        if(left)
            out <= data << shift;
        else
            out <= data >> shift;
 end
        
endmodule
