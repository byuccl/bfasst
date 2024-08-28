// ==============================================================
// denoise top level module that uses the random number generator
// to allow bitstream generation
// ===========================================================

`timescale 1 ns / 1 ps 

`include "../random_number_generator.sv"

module denoise_random(
    input  logic  ap_clk,
    input  logic  ap_rst,
    input  logic  ap_start,
    output logic   ap_done,
    output logic   ap_idle,
    output logic   uReadBus_req_din,
    input  logic  uReadBus_req_full_n,
    output logic   uReadBus_req_write,
    input  logic  uReadBus_rsp_dout,
    input  logic  uReadBus_rsp_empty_n,
    output logic   uReadBus_rsp_read,
    output logic  [31:0] uReadBus_address,
    output logic  [127:0] uReadBus_dataout,
    output logic  [31:0] uReadBus_size,
    output logic   fReadBus_req_din,
    input  logic  fReadBus_req_full_n,
    output logic   fReadBus_req_write,
    input  logic  fReadBus_rsp_dout,
    input  logic  fReadBus_rsp_empty_n,
    output logic   fReadBus_rsp_read,
    output logic   writeBus_req_din,
    input  logic  writeBus_req_full_n,
    output logic   writeBus_req_write,
    input  logic  writeBus_rsp_dout,
    input  logic  writeBus_rsp_empty_n,
    output logic   writeBus_rsp_read,
    output logic  [0:0] ap_return
);


logic [127:0] rng_out1, rng_out2, rng_out3;

RandomNumberGenerator #(128, 7) rng1(
    .clk(ap_clk),
    .reset(ap_rst),
    .random_number(rng_out1)
);

RandomNumberGenerator #(128, 4) rng2(
    .clk(ap_clk),
    .reset(ap_rst),
    .random_number(rng_out2)
);

RandomNumberGenerator #(128, 15) rng3(
    .clk(ap_clk),
    .reset(ap_rst),
    .random_number(rng_out3)
);

RandomNumberGenerator #(32, 8) rng4(
    .clk(ap_clk),
    .reset(ap_rst),
    .random_number(rng_out4)
);

RandomNumberGenerator #(128, 1) rng5(
    .clk(ap_clk),
    .reset(ap_rst),
    .random_number(rng_out5)
);

RandomNumberGenerator #(32, 25) rng6(
    .clk(ap_clk),
    .reset(ap_rst),
    .random_number(rng_out6)
);

RandomNumberGenerator #(32, 2) rng7(
    .clk(ap_clk),
    .reset(ap_rst),
    .random_number(rng_out7)
);

RandomNumberGenerator #(128, 10) rng8(
    .clk(ap_clk),
    .reset(ap_rst),
    .random_number(rng_out8)
);

RandomNumberGenerator #(32, 9) rng9(
    .clk(ap_clk),
    .reset(ap_rst),
    .random_number(rng_out9)
);


denoise denoise_inst(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_done(ap_done),
    .ap_idle(ap_idle),
    .uReadBus_req_din(uReadBus_req_din),
    .uReadBus_req_full_n(uReadBus_req_full_n),
    .uReadBus_req_write(uReadBus_req_write),
    .uReadBus_rsp_dout(uReadBus_rsp_dout),
    .uReadBus_rsp_empty_n(uReadBus_rsp_empty_n),
    .uReadBus_rsp_read(uReadBus_rsp_read),
    .uReadBus_address(uReadBus_address),
    .uReadBus_datain(rng_out1),
    .uReadBus_dataout(uReadBus_dataout),
    .uReadBus_size(uReadBus_size),
    .fReadBus_req_din(fReadBus_req_din),
    .fReadBus_req_full_n(fReadBus_req_full_n),
    .fReadBus_req_write(fReadBus_req_write),
    .fReadBus_rsp_dout(fReadBus_rsp_dout),
    .fReadBus_rsp_empty_n(fReadBus_rsp_empty_n),
    .fReadBus_rsp_read(fReadBus_rsp_read),
    .fReadBus_address(rng_out7),
    .fReadBus_datain(rng_out2),
    .fReadBus_dataout(rng_out8),
    .fReadBus_size(rng_out9),
    .writeBus_req_din(writeBus_req_din),
    .writeBus_req_full_n(writeBus_req_full_n),
    .writeBus_req_write(writeBus_req_write),
    .writeBus_rsp_dout(writeBus_rsp_dout),
    .writeBus_rsp_empty_n(writeBus_rsp_empty_n),
    .writeBus_rsp_read(writeBus_rsp_read),
    .writeBus_address(rng_out4),
    .writeBus_datain(rng_out3),
    .writeBus_dataout(rng_out5),
    .writeBus_size(rng_out6),
    .ap_return(ap_return)
);

endmodule