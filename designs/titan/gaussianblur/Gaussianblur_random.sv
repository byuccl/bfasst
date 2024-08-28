// ==============================================================
// Gaussianblur top level module that uses the random number generator
// to allow bitstream generation
// ===========================================================

`timescale 1 ns / 1 ps 

`include "../random_number_generator.sv"

module Gaussianblur_random(
    input logic ap_clk,
    input logic ap_rst,
    input logic ap_start,
    output logic ap_done,
    output logic ap_idle,
    input  logic V1_bus_rsp_dout,
    input  logic V1_bus_rsp_empty_n,
    output logic V1_bus_rsp_read,
    output logic [31:0] V1_bus_address,
    output logic [127:0] V1_bus_dataout,
    output logic [31:0] V1_bus_size,
    input  logic V1_bus_req_full_n,
    output logic V1_bus_req_write,
    output logic V1_bus_req_din,
    input  logic V2_bus_rsp_dout,
    input  logic V2_bus_rsp_empty_n,
    output logic V2_bus_rsp_read,
    output logic [31:0] V2_bus_address,
    output logic [127:0] V2_bus_dataout,
    output logic [31:0] V2_bus_size,
    output logic V2_bus_req_write,
    output logic V2_bus_req_din
);

logic [127:0] rng_out1, rng_out2;

RandomNumberGenerator #(128, 5) rng1(
    .clk(ap_clk),
    .reset(ap_rst),
    .random_number(rng_out1)
);

RandomNumberGenerator #(128, 13) rng2(
    .clk(ap_clk),
    .reset(ap_rst),
    .random_number(rng_out2)
);

// Instantiate the Gaussianblur module
Gaussianblur Gaussianblur_inst(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_done(ap_done),
    .ap_idle(ap_idle),
    .V1_bus_req_din(V1_bus_req_din),
    .V1_bus_req_full_n(V1_bus_req_full_n),
    .V1_bus_req_write(V1_bus_req_write),
    .V1_bus_rsp_dout(V1_bus_rsp_dout),
    .V1_bus_rsp_empty_n(V1_bus_rsp_empty_n),
    .V1_bus_rsp_read(V1_bus_rsp_read),
    .V1_bus_address(V1_bus_address),
    .V1_bus_datain(rng_out1),
    .V1_bus_dataout(V1_bus_dataout),
    .V1_bus_size(V1_bus_size),
    .V2_bus_req_din(V2_bus_req_din),
    .V2_bus_req_full_n(V2_bus_req_full_n),
    .V2_bus_req_write(V2_bus_req_write),
    .V2_bus_rsp_dout(V2_bus_rsp_dout),
    .V2_bus_rsp_empty_n(V2_bus_rsp_empty_n),
    .V2_bus_rsp_read(V2_bus_rsp_read),
    .V2_bus_address(V2_bus_address),
    .V2_bus_datain(rng_out2),
    .V2_bus_dataout(V2_bus_dataout),
    .V2_bus_size(V2_bus_size),
    .std()  // Assuming this is provided elsewhere or will be connected as needed
);

endmodule
