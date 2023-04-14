`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Brigham Young University
// Engineer: Sean Jensen
// 
// Create Date: 06/8/2017 01:24:80 PM
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
    input [15:0] userInput_o;
    output [15:0] designOutput_i;

    ///////////////////////////////////////////////////////////////////
	//
	// Local wires and registers
	//
    wire [255:0] aes128_i;
    wire [127:0] aes128_o;
    wire [1:0] viterbi0_i, viterbi1_i, viterbi2_i, viterbi3_i, viterbi4_i, viterbi5_i, viterbi6_i, viterbi7_i, viterbi8_i, viterbi9_i, viterbi10_i, viterbi11_i, viterbi12_i, viterbi13_i, viterbi14_i, viterbi15_i;
    wire viterbi0_o, viterbi1_o, viterbi2_o, viterbi3_o, viterbi4_o, viterbi5_o, viterbi6_o, viterbi7_o, viterbi8_o, viterbi9_o, viterbi10_o, viterbi11_o, viterbi12_o, viterbi13_o, viterbi14_o, viterbi15_o;

    // 2 bits
    assign viterbi0_i = {userInput_o[0], viterbi14_o};
    assign viterbi1_i = {userInput_o[1], viterbi15_o};
    assign viterbi2_i = {userInput_o[2], viterbi0_o};
    assign viterbi3_i = {userInput_o[3], viterbi1_o};
    assign viterbi4_i = {userInput_o[4], viterbi2_o};
    assign viterbi5_i = {userInput_o[5], viterbi3_o};
    assign viterbi6_i = {userInput_o[6], viterbi4_o};
    assign viterbi7_i = {userInput_o[7], viterbi5_o};
    assign viterbi8_i = {userInput_o[8], viterbi6_o};
    assign viterbi9_i = {userInput_o[9], viterbi7_o};
    assign viterbi10_i = {userInput_o[10], viterbi8_o};
    assign viterbi11_i = {userInput_o[11], viterbi9_o};
    assign viterbi12_i = {userInput_o[12], viterbi10_o};
    assign viterbi13_i = {userInput_o[13], viterbi11_o};
    assign viterbi14_i = {userInput_o[14], viterbi12_o};
    assign viterbi15_i = {userInput_o[15], viterbi13_o};
        
    // 16 bits
    assign designOutput_i = {&aes128_o[127:120], &aes128_o[119:112],
                            &aes128_o[111:104], &aes128_o[103:96],
                            &aes128_o[95:88], &aes128_o[87:80],
                            &aes128_o[79:72], &aes128_o[71:64],
                            &aes128_o[63:56], &aes128_o[55:48],
                            &aes128_o[47:40], &aes128_o[39:32],
                            &aes128_o[31:24], &aes128_o[23:16],
                            &aes128_o[15:8], &aes128_o[7:0]};

    //256 bits = 8*16 + 128
    assign aes128_i = {{8{viterbi0_o, viterbi1_o, viterbi2_o, viterbi3_o, 
                    viterbi4_o, viterbi5_o, viterbi6_o, viterbi7_o, 
                    viterbi8_o, viterbi9_o, viterbi10_o, viterbi11_o, 
                    viterbi12_o, viterbi13_o, viterbi14_o, viterbi15_o}},
                    128'h0123456789ABCDEF};
    
    ///////////////////////////////////////////////////////////////////
    //
    // Module Instantiations
    //
    aes128 aes128_0(.clk(clk_o), .state(aes128_i[127:0]), .key(aes128_i[255:128]), .out(aes128_o));
    
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