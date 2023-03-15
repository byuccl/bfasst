`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Brigham Young University
// Engineer: Sean Jensen
// 
// Create Date: 01/27/2017 04:04:06 PM
// Design Name: 
// Module Name: counter
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

module counter(clk_i, rst_i, en_i, blink_o);
    parameter width = 32;
    output  blink_o;
    input   clk_i;
    input   en_i;
    input   rst_i;

    ///////////////////////////////////////////////////////////////////
    //
    // Local Wires and Registers
    //
    reg     [width-1:0] count = 0;

    //Output Buffers
    reg       blink_o;
    
    always @(posedge clk_i) 
    begin
        if (rst_i == 1'b1) 
            count = 0;
        else if (en_i == 1'b1)
            count = count + 1;

        if (count[width-1] == 1'b1)
            blink_o = 1'b1;
        else
            blink_o = 1'b0;
    end
endmodule