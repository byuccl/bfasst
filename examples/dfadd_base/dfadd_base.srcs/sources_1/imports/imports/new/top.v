`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Brigham Young University
// Engineer: Sean Jensen
// 
// Create Date: 02/20/2017 02:41:22 PM
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
`default_nettype wire

module top(clk_o, rst_o, userInput_o, designOutput_i);
	input clk_o;
	input rst_o;
	input [7:0] userInput_o;
	output [7:0] designOutput_i;

	///////////////////////////////////////////////////////////////////
	//
	// Module Instantiations
	//
	wire [1:0] dfadd0_i;
	wire [32:0] dfadd0_o;
	wire [1:0] viterbi0_i, viterbi1_i, viterbi2_i, viterbi3_i, viterbi4_i, viterbi5_i, viterbi6_i, viterbi7_i, viterbi8_i, viterbi9_i, viterbi10_i, viterbi11_i, viterbi12_i, viterbi13_i, viterbi14_i, viterbi15_i;
	wire viterbi0_o, viterbi1_o, viterbi2_o, viterbi3_o, viterbi4_o, viterbi5_o, viterbi6_o, viterbi7_o, viterbi8_o, viterbi9_o, viterbi10_o, viterbi11_o, viterbi12_o, viterbi13_o, viterbi14_o, viterbi15_o;
	wire viterbi_outs;

	// 2 bits
	assign viterbi0_i = dfadd0_o[1:0];
	assign viterbi1_i = dfadd0_o[3:2];
	assign viterbi2_i = dfadd0_o[5:4];
	assign viterbi3_i = dfadd0_o[7:6];
	assign viterbi4_i = dfadd0_o[9:8];
	assign viterbi5_i = dfadd0_o[11:10];
	assign viterbi6_i = dfadd0_o[13:12];
	assign viterbi7_i = dfadd0_o[15:14];
	assign viterbi8_i = dfadd0_o[17:16];
	assign viterbi9_i = dfadd0_o[19:18];
	assign viterbi10_i = dfadd0_o[21:20];
	assign viterbi11_i = dfadd0_o[23:22];
	assign viterbi12_i = dfadd0_o[25:24];
	assign viterbi13_i = dfadd0_o[27:26];
	assign viterbi14_i = dfadd0_o[29:28];
	assign viterbi15_i = dfadd0_o[31:30];
		
	// 8 bits
	assign designOutput_i = {viterbi0_o & viterbi1_o & dfadd0_o[32],
							 viterbi2_o & viterbi3_o,
							 viterbi4_o & viterbi5_o,
							 viterbi6_o & viterbi7_o,
							 viterbi8_o & viterbi9_o,
							 viterbi10_o & viterbi11_o,
							 viterbi12_o & viterbi13_o,
							 viterbi14_o & viterbi15_o};

	// 2 bits
	assign dfadd0_i = {1'b0,
						&userInput_o[7:0]};
	
	
	dfadd dfadd_0(.clk(clk_o), .reset(rst_o), .start(dfadd0_i[0]), .finish(dfadd0_o[32]), //1, 1, 1, 1
			.waitrequest(dfadd0_i[1]), .return_val(dfadd0_o[31:0]));                      //1, 32
	
	
	viterbi_tx_rx viterbi0(.clk(clk_o), .rst(rst_o), .encoder_i(viterbi0_i[0]), 
		   .enable_encoder_i(viterbi0_i[1]), .decoder_o(viterbi0_o));
	viterbi_tx_rx viterbi1(.clk(clk_o), .rst(rst_o), .encoder_i(viterbi1_i[0]), 
		   .enable_encoder_i(viterbi1_i[1]), .decoder_o(viterbi1_o));
	viterbi_tx_rx viterbi2(.clk(clk_o), .rst(rst_o), .encoder_i(viterbi2_i[0]), 
		   .enable_encoder_i(viterbi2_i[1]), .decoder_o(viterbi2_o));
	viterbi_tx_rx viterbi3(.clk(clk_o), .rst(rst_o), .encoder_i(viterbi3_i[0]), 
		   .enable_encoder_i(viterbi3_i[1]), .decoder_o(viterbi3_o));
	viterbi_tx_rx viterbi4(.clk(clk_o), .rst(rst_o), .encoder_i(viterbi4_i[0]), 
		   .enable_encoder_i(viterbi4_i[1]), .decoder_o(viterbi4_o));
	viterbi_tx_rx viterbi5(.clk(clk_o), .rst(rst_o), .encoder_i(viterbi5_i[0]), 
		   .enable_encoder_i(viterbi5_i[1]), .decoder_o(viterbi5_o));
	viterbi_tx_rx viterbi6(.clk(clk_o), .rst(rst_o), .encoder_i(viterbi6_i[0]), 
		   .enable_encoder_i(viterbi6_i[1]), .decoder_o(viterbi6_o));
	viterbi_tx_rx viterbi7(.clk(clk_o), .rst(rst_o), .encoder_i(viterbi7_i[0]), 
		   .enable_encoder_i(viterbi7_i[1]), .decoder_o(viterbi7_o));
	viterbi_tx_rx viterbi8(.clk(clk_o), .rst(rst_o), .encoder_i(viterbi8_i[0]), 
		   .enable_encoder_i(viterbi8_i[1]), .decoder_o(viterbi8_o));
	viterbi_tx_rx viterbi9(.clk(clk_o), .rst(rst_o), .encoder_i(viterbi9_i[0]), 
		   .enable_encoder_i(viterbi9_i[1]), .decoder_o(viterbi9_o));
	viterbi_tx_rx viterbi10(.clk(clk_o), .rst(rst_o), .encoder_i(viterbi10_i[0]), 
		   .enable_encoder_i(viterbi10_i[1]), .decoder_o(viterbi10_o));
	viterbi_tx_rx viterbi11(.clk(clk_o), .rst(rst_o), .encoder_i(viterbi11_i[0]), 
		   .enable_encoder_i(viterbi11_i[1]), .decoder_o(viterbi11_o));
	viterbi_tx_rx viterbi12(.clk(clk_o), .rst(rst_o), .encoder_i(viterbi12_i[0]), 
		   .enable_encoder_i(viterbi12_i[1]), .decoder_o(viterbi12_o));
	viterbi_tx_rx viterbi13(.clk(clk_o), .rst(rst_o), .encoder_i(viterbi13_i[0]), 
		   .enable_encoder_i(viterbi13_i[1]), .decoder_o(viterbi13_o));
	viterbi_tx_rx viterbi14(.clk(clk_o), .rst(rst_o), .encoder_i(viterbi14_i[0]), 
		   .enable_encoder_i(viterbi14_i[1]), .decoder_o(viterbi14_o));
	viterbi_tx_rx viterbi15(.clk(clk_o), .rst(rst_o), .encoder_i(viterbi15_i[0]), 
		   .enable_encoder_i(viterbi15_i[1]), .decoder_o(viterbi15_o));
endmodule