/*
* a25_fetch top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../../random_number_generator.sv"

module a25_fetch_random(
    input logic clk,
    input logic reset,
    input logic i_mem_stall,
    input logic i_exec_stall,
    input logic i_conflict,
    input logic i_system_rdy,
    input logic i_iaddress_valid,
    input logic i_cache_enable,
    input logic i_cache_flush,
    input logic i_wb_ready,
    output logic o_fetch_stall,
    output logic o_wb_req,
    output logic [31:0] o_fetch_instruction,
    output logic [31:0] o_wb_address
    );

logic [31:0] i_iaddress;
logic [31:0] i_iaddress_nxt;
logic [31:0] i_cacheable_area;
logic [127:0] i_wb_read_data;

RandomNumberGenerator #(32, 3) rng_i_iaddress (
  .clk(clk),
  .reset(reset),
  .random_number(i_iaddress[31:0])
);

RandomNumberGenerator #(32, 5) rng_i_iaddress_nxt (
  .clk(clk),
  .reset(reset),
  .random_number(i_iaddress_nxt[31:0])
);

RandomNumberGenerator #(32, 7) rng_i_cacheable_area (
  .clk(clk),
  .reset(reset),
  .random_number(i_cacheable_area[31:0])
);

RandomNumberGenerator #(32, 9) rng_i_wb_read_data (
  .clk(clk),
  .reset(reset),
  .random_number(i_wb_read_data[31:0])
);

a25_fetch fetch (
    .i_clk(clk),
    .i_mem_stall(i_mem_stall),
    .i_exec_stall(i_exec_stall),
    .i_conflict(i_conflict),
    .i_system_rdy(i_system_rdy),
    .i_iaddress_valid(i_iaddress_valid),
    .i_iaddress(i_iaddress[31:0]),
    .i_iaddress_nxt(i_iaddress_nxt[31:0]),
    .i_cacheable_area(i_cacheable_area[31:0]),
    .i_cache_enable(i_cache_enable),
    .i_cache_flush(i_cache_flush),
    .i_wb_ready(i_wb_ready),
    .i_wb_read_data(i_wb_read_data[127:0]),
    .o_fetch_stall(o_fetch_stall),
    .o_wb_req(o_wb_req),
    .o_fetch_instruction(o_fetch_instruction[31:0]),
    .o_wb_address(o_wb_address[31:0])
);

endmodule