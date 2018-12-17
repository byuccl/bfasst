`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2017 11:44:35 AM
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

module top(
        input wire [7:0] sw, JA, JB, JC, JD,
        input wire btnCpuReset, clk,
        output wire [15:0] led
    );
    
    wire [31:0] o_wb_adr;
    wire [15:0] o_wb_sel;
    wire o_wb_we, o_wb_cyc, o_wb_stb;
    
    wire [127:0] i_wb_dat, o_wb_dat;
    
    
    assign i_wb_dat = 128'h0123456789ABCDEF0123456789ABCDEF;

	// type datablock is array(3 downto 0, 3 downto 0) of std_logic_vector(7 downto 0);	    
    // datablock plaintext_i, keyblock_i, ciphertext_o;
    wire [7:0] plaintext_i [3:0][3:0], keyblock_i[3:0][3:0], ciphertext_o[3:0][3:0];
    
    amber amber_0(
        .i_clk(clk),
        .i_irq(sw[0]),
        .i_firq(sw[1]),
        .i_system_rdy(sw[1]),
        .o_wb_adr(o_wb_adr),
        .o_wb_sel(o_wb_sel),
        .o_wb_we(o_wb_we),
        .i_wb_dat(i_wb_dat),
        .o_wb_dat(o_wb_dat),
        .o_wb_cyc(o_wb_cyc),
        .o_wb_stb(o_wb_stb),
        .i_wb_ack(sw[2]),
        .i_wb_err(sw[3])
    );
        
//    aes_pipe aes_pipe_0(
//        .clk_i(clk),
//        .rst_i(btnCpuReset),
//        .plaintext_i(plaintext_i),
//        .keyblock_i(keyblock_i),
//        .ciphertext_o(ciphertext_o)
//    );

    wire [31:0] cypher;
    wire ready;

    basicrsa basicrsa_0(
          .indata(o_wb_dat[31:0]),
          .inExp(o_wb_dat[63:32]),
          .inMod(o_wb_dat[95:64]),
          .cypher(cypher),
          .clk(clk),
          .ds(sw[4]),
          .reset(btnCpuReset),
          .ready(ready)
    );
    
    assign led[0] = ^cypher;
    assign led[1] = ready;
    assign led[2] = ^o_wb_adr;
    assign led[3] = ^o_wb_sel;
    assign led[4] = o_wb_we;
    assign led[5] = ^(o_wb_dat[127:96]);
    assign led[6] = o_wb_cyc;
    assign led[7] = o_wb_stb;

    
    
    
endmodule
