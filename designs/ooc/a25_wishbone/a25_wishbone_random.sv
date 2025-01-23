/*
* a25_wishbone top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../../random_number_generator.sv"

module a25_wishbone_random(
    input logic clk,
    input logic reset,
    input logic i_port0_req,
    output logic o_port0_ack,
    input logic i_port0_write,
    output logic [127:0] o_port0_rdata,
    input logic i_port1_req,
    output logic o_port1_ack,
    input logic i_port1_write,
    // output logic [127:0] o_port1_rdata,
    input logic i_port2_req,
    output logic o_port2_ack,
    input logic i_port2_write,
    // output logic [127:0] o_port2_rdata,
    output reg  [31:0] o_wb_adr,
    output reg  [15:0] o_wb_sel,
    output reg  o_wb_we,
    // output reg  [127:0] o_wb_dat,
    output reg  o_wb_cyc,
    output reg  o_wb_stb,
    input logic i_wb_ack,
    input logic i_wb_err
    );

logic [127:0] o_port1_rdata;
logic [127:0] o_port2_rdata;
logic [127:0] o_wb_dat;

logic [127:0] i_port0_wdata;
logic [15:0] i_port0_be;
logic [31:0] i_port0_addr;
logic [127:0] i_port1_wdata;
logic [15:0] i_port1_be;
logic [31:0] i_port1_addr;
logic [127:0] i_port2_wdata;
logic [15:0] i_port2_be;
logic [31:0] i_port2_addr;
logic [127:0] i_wb_dat;

RandomNumberGenerator #(128, 3) rng_i_port0_wdata (
  .clk(clk),
  .reset(reset),
  .random_number(i_port0_wdata[127:0])
);

RandomNumberGenerator #(16, 6) rng_i_port0_be (
  .clk(clk),
  .reset(reset),
  .random_number(i_port0_be[15:0])
);

RandomNumberGenerator #(32, 9) rng_i_port0_addr (
  .clk(clk),
  .reset(reset),
  .random_number(i_port0_addr[31:0])
);

RandomNumberGenerator #(128, 11) rng_i_port1_wdata (
  .clk(clk),
  .reset(reset),
  .random_number(i_port1_wdata[127:0])
);

RandomNumberGenerator #(16, 13) rng_i_port1_be (
  .clk(clk),
  .reset(reset),
  .random_number(i_port1_be[15:0])
);

RandomNumberGenerator #(32, 15) rng_i_port1_addr (
  .clk(clk),
  .reset(reset),
  .random_number(i_port1_addr[31:0])
);

RandomNumberGenerator #(128, 17) rng_i_port2_wdata (
  .clk(clk),
  .reset(reset),
  .random_number(i_port2_wdata[127:0])
);

RandomNumberGenerator #(16, 19) rng_i_port2_be (
  .clk(clk),
  .reset(reset),
  .random_number(i_port2_be[15:0])
);

RandomNumberGenerator #(32, 21) rng_i_port2_addr (
  .clk(clk),
  .reset(reset),
  .random_number(i_port2_addr[31:0])
);

RandomNumberGenerator #(128, 23) rng_i_wb_dat (
  .clk(clk),
  .reset(reset),
  .random_number(i_wb_dat[127:0])
);


a25_wishbone wishbone (
    .i_clk(clk),
    .i_port0_req(i_port0_req),
    .o_port0_ack(o_port0_ack),
    .i_port0_write(i_port0_write),
    .i_port0_wdata(i_port0_wdata[127:0]),
    .i_port0_be(i_port0_be[15:0]),
    .i_port0_addr(i_port0_addr[31:0]),
    .o_port0_rdata(o_port0_rdata[127:0]),
    .i_port1_req(i_port1_req),
    .o_port1_ack(o_port1_ack),
    .i_port1_write(i_port1_write),
    .i_port1_wdata(i_port1_wdata[127:0]),
    .i_port1_be(i_port1_be[15:0]),
    .i_port1_addr(i_port1_addr[31:0]),
    .o_port1_rdata(o_port1_rdata[127:0]),
    .i_port2_req(i_port2_req),
    .o_port2_ack(o_port2_ack),
    .i_port2_write(i_port2_write),
    .i_port2_wdata(i_port2_wdata[127:0]),
    .i_port2_be(i_port2_be[15:0]),
    .i_port2_addr(i_port2_addr[31:0]),
    .o_port2_rdata(o_port2_rdata[127:0]),
    .o_wb_adr(o_wb_adr[31:0]),
    .o_wb_sel(o_wb_sel[15:0]),
    .o_wb_we(o_wb_we),
    .o_wb_dat(o_wb_dat[127:0]),
    .o_wb_cyc(o_wb_cyc),
    .o_wb_stb(o_wb_stb),
    .i_wb_dat(i_wb_dat[127:0]),
    .i_wb_ack(i_wb_ack),
    .i_wb_err(i_wb_err)
);

endmodule