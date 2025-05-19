`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: BYU
// Engineer: Eddie Rydell
// 
// Create Date: 05/19/2025 04:04:48 PM
// Design Name: 
// Module Name: dsp
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

module dsp (
    input  logic        clk,
    input  logic        rst,
    input  logic        ce,

    input  logic [24:0] preadd1_1,
    input  logic [24:0] preadd2_1,
    input  logic [17:0] mult1,

    input  logic [24:0] preadd1_2,
    input  logic [24:0] preadd2_2,
    input  logic [17:0] mult2,

    input  logic [24:0] preadd1_3,
    input  logic [24:0] preadd2_3,
    input  logic [17:0] mult3,

    output logic [47:0] final_out
);

    logic [47:0] p1, p2, p3;

    // DSP 1
    ADDMACC_MACRO #(
        .DEVICE("7SERIES"),
        .LATENCY(4),
        .WIDTH_PREADD(25),
        .WIDTH_MULTIPLIER(18),
        .WIDTH_PRODUCT(48)
    ) macc1 (
        .PRODUCT(p1),
        .CARRYIN(1'b0),
        .CLK(clk),
        .CE(ce),
        .LOAD(1'b0),
        .LOAD_DATA(48'd0),
        .MULTIPLIER(mult1),
        .PREADD1(preadd1_1),
        .PREADD2(preadd2_1),
        .RST(rst)
    );

    // DSP 2
    ADDMACC_MACRO #(
        .DEVICE("7SERIES"),
        .LATENCY(3),
        .WIDTH_PREADD(25),
        .WIDTH_MULTIPLIER(18),
        .WIDTH_PRODUCT(48)
    ) macc2 (
        .PRODUCT(p2),
        .CARRYIN(1'b0),
        .CLK(clk),
        .CE(ce),
        .LOAD(1'b0),
        .LOAD_DATA(48'd0),
        .MULTIPLIER(mult2),
        .PREADD1(preadd1_2),
        .PREADD2(preadd2_2),
        .RST(rst)
    );

    // DSP 3
    ADDMACC_MACRO #(
        .DEVICE("7SERIES"),
        .LATENCY(2),
        .WIDTH_PREADD(25),
        .WIDTH_MULTIPLIER(18),
        .WIDTH_PRODUCT(48)
    ) macc3 (
        .PRODUCT(p3),
        .CARRYIN(1'b0),
        .CLK(clk),
        .CE(ce),
        .LOAD(1'b0),
        .LOAD_DATA(48'd0),
        .MULTIPLIER(mult3),
        .PREADD1(preadd1_3),
        .PREADD2(preadd2_3),
        .RST(rst)
    );

    // External logic to combine results
    assign final_out = p1 + p2 + p3;

endmodule
