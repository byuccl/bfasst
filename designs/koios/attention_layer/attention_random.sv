/*
* attention_random top level module that incorporates the random number generator
* to allow bitstream generation without Vivado optimizing wrapped inputs
*/
`include "../../random_number_generator.sv"

`define VECTOR_DEPTH 64 //Q,K,V vector size
`define DATA_WIDTH 16
`define VECTOR_BITS 1024 // 16 bit each (16x64)
`define NUM_WORDS 32   //num of words in the sentence
`define BUF_AWIDTH 4 //16 entries in each buffer ram
`define BUF_LOC_SIZE 4 //4 words in each addr location
`define OUT_RAM_DEPTH 512 //512 entries in output bram
`define LOG_OUT_RAM_DEPTH 9 //512 entries in output bram

module attention_random(
    input logic clk,
    input logic reset,
    input logic start,			
    input [4:0] q_rd_addr, 
    input [4:0] k_rd_addr,
    input [4:0] v_rd_addr,
    input [2:0] wren_qkv_ext, 
    input [4:0] address_ext, 
    input [`LOG_OUT_RAM_DEPTH-1:0] out_rd_addr,
    output [`DATA_WIDTH-1:0] out_part1, 
    output [`DATA_WIDTH-1:0] out_part2
);

logic [`VECTOR_BITS-1:0] data_in; 

RandomNumberGenerator #(`VECTOR_BITS, `VECTOR_BITS) rng1(
  .clk(clk),
  .reset(reset),
  .random_number(data_in)
);

attention_layer attn(
    .clk(clk),
    .rst(reset),
    .start(start),			
    .q_rd_addr(q_rd_addr), //start address of q
    .k_rd_addr(k_rd_addr), //start address of k
    .v_rd_addr(v_rd_addr), //start address of v
    .wren_qkv_ext(wren_qkv_ext), //To write data into Q,K,V BRAMs externally
    .address_ext(address_ext),  //External write address
    .data_ext(data_in),  //Data to be written
    .out_rd_addr(out_rd_addr),	//To read stored outputs from outside
    .out_part1(out_part1),  //16 bit output from out bram
    .out_part2(out_part2)  //16 bit output from out bram
);

endmodule