`timescale 1ns / 1ps

/***************************************************************************
*
* Module: stopwatch_top.v
*
* Author: Samuel Reynolds
* Class: ECEN 220, Section 3, Winter 2021
* Date: 3/10/21
*
* Description: This is my stopwatch top module for Lab 7 where we are making a
stopwatch on our board.
*
*
****************************************************************************/
module stopwatch_top(
    output [7:0] segment,
    output [3:0] anode,
    input clk, btnc, sw
);

wire [15:0] in;
wire [3:0] digit0, digit1, digit2, digit3, display, point;

stopwatch SW0 (digit0, digit1, digit2, digit3, clk, btnc, sw);
SevenSegmentControl SSC0 (clk, btnc, in, point, display, anode, segment);

assign point = 4'b1111;
assign display = 4'b0100;

assign in = ({digit3, digit2, digit1, digit0});
endmodule