`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2017 02:08:22 PM
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


module top(clk_i, rst_i, sw_i, blink_o_top);
    input clk_i;
    input rst_i;
    input [7:0] sw_i;
    output blink_o_top;

    ///////////////////////////////////////////////////////////////////
	//
	// Local Wires and Registers
	//
    reg     [7:0] count = 0;
    reg 	counter_en = 0;

	always @(posedge clk_i)
	begin
		if(sw_i[7] == 1'b1) begin
			if(count == 7'b0)
				counter_en = 1;
			else
				counter_en = 0;
		end else if(sw_i[6] == 1'b1) begin
			if(count == 6'b0)
				counter_en = 1;
			else
				counter_en = 0;
		end else if(sw_i[5] == 1'b1) begin
			if(count == 5'b0)
				counter_en = 1;
			else
				counter_en = 0;
		end else if(sw_i[4] == 1'b1) begin
			if(count == 4'b0)
				counter_en = 1;
			else
				counter_en = 0;
		end else if(sw_i[3] == 1'b1) begin
			if(count == 3'b0)
				counter_en = 1;
			else
				counter_en = 0;
		end else if(sw_i[2] == 1'b1) begin
			if(count == 2'b0)
				counter_en = 1;
			else
				counter_en = 0;
		end else if(sw_i[1] == 1'b1) begin
			if(count == 1'b0)
				counter_en = 1;
			else
				counter_en = 0;
		end else if(sw_i[0] == 1'b1) begin
			counter_en = 1;
		end else
			counter_en = 0;

		count = count + 1;
	end


    ///////////////////////////////////////////////////////////////////
	//
	// Module Instantiations
	//
    counter counter_0(.clk_i(clk_i), .rst_i(rst_i), .en_i(counter_en), .blink_o(blink_o_top));
    
endmodule
