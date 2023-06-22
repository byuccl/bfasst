/*
* mpeg2fpga top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"
`include "mpeg2fpga.v"

module mpeg2fpga_random(
    input logic clk,
    input logic reset,
    input logic stream_valid,
    output logic [7:0] r,
    output logic [7:0] g,
    output logic [7:0] b,
    output logic [7:0] y,
    output logic [7:0] u,
    output logic [7:0] v,
    output logic pixel_en,
    output logic h_sync,
    output logic v_sync,
    output logic c_sync,
    input logic reg_wr_en,
    output logic [31:0] reg_dta_out,
    input logic reg_rd_en,
    output reg busy,
    output logic error,
    output logic interrupt,
    output logic [1:0] mem_req_rd_cmd,
    output logic [21:0] mem_req_rd_addr,
    output logic [63:0] mem_req_rd_dta,
    input logic mem_req_rd_en,
    output logic mem_req_rd_valid,
    input logic mem_res_wr_en,
    output logic mem_res_wr_almost_full,
    input logic testpoint_dip_en,
    output logic [33:0] testpoint,
    output logic watchdog_rst
    );

logic [7:0] stream_data;
logic [3:0] reg_addr;
logic [31:0] reg_dta_in;
logic [63:0] mem_res_wr_dta;
logic [3:0] testpoint_dip;

RandomNumberGenerator #(8, 3) rng_stream_data (
  .clk(clk),
  .reset(reset),
  .random_number(stream_data[7:0])
);

RandomNumberGenerator #(4, 5) rng_reg_addr(
  .clk(clk),
  .reset(reset),
  .random_number(reg_addr[3:0])
);

RandomNumberGenerator #(32, 7) rng_reg_dta_in (
  .clk(clk),
  .reset(reset),
  .random_number(reg_dta_in[31:0])
);

RandomNumberGenerator #(64, 9) rng_mem_res_wr_dta (
  .clk(clk),
  .reset(reset),
  .random_number(mem_res_wr_dta[63:0])
);

RandomNumberGenerator #(4, 11) rng_testpoint_dip (
  .clk(clk),
  .reset(reset),
  .random_number(testpoint_dip[3:0])
);

mpeg2fpga mpeg (
    .clk(clk),
    .mem_clk(clk),
    .dot_clk(clk),
    .rst(reset),
    .stream_data(stream_data[7:0]),
    .stream_valid(stream_valid),
    .reg_addr(reg_addr[3:0]),
    .reg_wr_en(reg_wr_en),
    .reg_dta_in(reg_dta_in[31:0]),
    .reg_rd_en(reg_rd_en),
    .reg_dta_out(reg_dta_out[31:0]),
    .busy(busy),
    .error(error),
    .interrupt(interrupt),
    .watchdog_rst(watchdog_rst),
    .r(r[7:0]),
    .g(g[7:0]),
    .b(b[7:0]),
    .y(y[7:0]),
    .u(u[7:0]),
    .v(v[7:0]),
    .pixel_en(pixel_en),
    .h_sync(h_sync),
    .v_sync(v_sync),
    .c_sync(c_sync),
    .mem_req_rd_cmd(mem_req_rd_cmd[1:0]),
    .mem_req_rd_addr(mem_req_rd_addr[21:0]),
    .mem_req_rd_dta(mem_req_rd_dta[63:0]),
    .mem_req_rd_en(mem_req_rd_en),
    .mem_req_rd_valid(mem_req_rd_valid),
    .mem_res_wr_dta(mem_res_wr_dta[63:0]),
    .mem_res_wr_en(mem_res_wr_en),
    .mem_res_wr_almost_full(mem_res_wr_almost_full),
    .testpoint_dip_en(testpoint_dip_en),
    .testpoint_dip(testpoint_dip[3:0]),
    .testpoint(testpoint[33:0])
);

endmodule