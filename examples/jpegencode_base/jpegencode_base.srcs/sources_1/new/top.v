`timescale 1ns / 1ps


module top(
        input clk,
        input rst,
        input [15:0] switches,
        output [7:0] LEDs
    );

    // Inputs to module
    wire end_of_file_signal;
    wire enable;
    wire [23:0] data_in;
    
    // Outputs from module
    wire [31:0] JPEG_bitsream;
    wire data_ready;
    wire [4:0] end_of_file_bitstream_count;
    wire eof_data_partial_ready; 
    
    assign end_of_file_signal = switches[15];
    assign enable = switches[14];
    assign data_in = {2{switches[11:0]}};
    
    jpegencode jpegencode_0(
        clk,
        1'b0,
        end_of_file_signal,
        enable,
        data_in,
        JPEG_bitstream,
        data_ready,
        endo_of_file_bitstream_count,
        eof_data_partial_ready);
    
    assign LEDs[0] = ^JPEG_bitsream;
    assign LEDs[1] = ~data_ready;
    assign LEDs[6:2] = end_of_file_bitstream_count;
    assign LEDs[7] = eof_data_partial_ready; 

endmodule
