/*
* a25_mem top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../../random_number_generator.sv"

module a25_mem_random(
    input logic clk,
    input logic reset,
    input logic 
        i_fetch_stall,
        i_exec_stall,
        i_daddress_valid,
        i_write_enable,
        i_exclusive,
        i_cache_enable,
        i_cache_flush,
        i_wb_cached_ready,
        i_wb_uncached_ready,
    output logic o_mem_stall,
    output logic [31:0] o_mem_read_data,
    output logic o_mem_read_data_valid,
    output logic [10:0] o_mem_load_rd, 
    output logic o_wb_cached_req,
    output logic o_wb_uncached_req,
    output logic o_wb_write,
    output logic [15:0] o_wb_byte_enable,
    output logic [127:0] o_wb_write_data,
    output logic [31:0] o_wb_address   
);

logic [31:0] i_daddress;
logic [31:0] i_daddress_nxt;
logic [31:0] i_write_data;
logic [3:0] i_byte_enable;
logic [8:0] i_exec_load_rd;
logic [31:0] i_cacheable_area;
logic [127:0] i_wb_uncached_rdata;
logic [127:0] i_wb_cached_rdata;

RandomNumberGenerator #(32, 3) rng_i_daddress (
  .clk(clk),
  .reset(reset),
  .random_number(i_daddress[31:0])
);

RandomNumberGenerator #(32, 5) rng_i_daddress_nxt(
  .clk(clk),
  .reset(reset),
  .random_number(i_daddress_nxt[31:0])
);

RandomNumberGenerator #(32, 7) rng_i_write_data(
  .clk(clk),
  .reset(reset),
  .random_number(i_write_data[31:0])
);

RandomNumberGenerator #(4, 9) rng_i_byte_enable(
  .clk(clk),
  .reset(reset),
  .random_number(i_byte_enable[3:0])
);

RandomNumberGenerator #(9, 11) rng_i_exec_load_rd(
  .clk(clk),
  .reset(reset),
  .random_number(i_exec_load_rd[8:0])
);

RandomNumberGenerator #(32, 13) rng_i_cacheable_area(
  .clk(clk),
  .reset(reset),
  .random_number(i_cacheable_area[31:0])
);

RandomNumberGenerator #(128, 15) rng_i_wb_uncached_rdata(
  .clk(clk),
  .reset(reset),
  .random_number(i_wb_uncached_rdata[127:0])
);

RandomNumberGenerator #(128, 17) rng_i_wb_cached_rdata(
  .clk(clk),
  .reset(reset),
  .random_number(i_wb_cached_rdata[127:0])
);

a25_mem mem(
    .i_clk(clk),
    .i_fetch_stall(i_fetch_stall),
    .i_exec_stall(i_exec_stall),
    .i_daddress(i_daddress[31:0]),
    .i_daddress_valid(i_daddress_valid),
    .i_daddress_nxt(i_daddress_nxt[31:0]),
    .i_write_data(i_write_data[31:0]),
    .i_write_enable(i_write_enable),
    .i_exclusive(i_exclusive),
    .i_byte_enable(i_byte_enable[3:0]),
    .i_exec_load_rd(i_exec_load_rd[8:0]),
    .i_cache_enable(i_cache_enable),
    .i_cache_flush(i_cache_flush),
    .i_cacheable_area(i_cacheable_area[31:0]),
    .i_wb_uncached_rdata(i_wb_uncached_rdata[127:0]),
    .i_wb_cached_rdata(i_wb_cached_rdata[127:0]),
    .i_wb_cached_ready(i_wb_cached_ready),
    .i_wb_uncached_ready(i_wb_uncached_ready),
    .o_mem_stall(o_mem_stall),
    .o_mem_read_data(o_mem_read_data[31:0]),
    .o_mem_read_data_valid(o_mem_read_data_valid),
    .o_mem_load_rd(o_mem_load_rd[10:0]), 
    .o_wb_cached_req(o_wb_cached_req),
    .o_wb_uncached_req(o_wb_uncached_req),
    .o_wb_write(o_wb_write),
    .o_wb_byte_enable(o_wb_byte_enable[15:0]),
    .o_wb_write_data(o_wb_write_data[127:0]),
    .o_wb_address(o_wb_address[31:0])  
);

endmodule