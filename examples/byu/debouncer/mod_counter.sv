`timescale 1ns / 1ps
`default_nettype none
/***************************************************************************
*
* Module: mod_counter.sv
*
* Author: Samuel Reynolds
* Class: ECEN 220, Section 3, Winter 2021
* Date: 3/10/21
*
* Description: This is my mod_counter module for Lab 7 where we are making a
stopwatch on our board.
*
*
****************************************************************************/

module mod_counter #(parameter MOD_VALUE = 10, WIDTH = 4)(
    output logic [WIDTH - 1:0] count,
    output logic rolling_over,
    input wire logic clk, reset, increment
);

always_ff @ (posedge clk) begin
    if (reset)
        count <= 0;
    else if ((count == MOD_VALUE - 1) && (increment))
        count <= 0;
    else if (increment)
        count <= count + 1;
end

assign rolling_over = (increment && (count == MOD_VALUE - 1));

endmodule