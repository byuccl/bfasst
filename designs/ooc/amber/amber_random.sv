/*
* amber top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module amber_random (
    input logic clk,
    input logic reset,
    input logic i_irq,
    input logic i_firq,
    input logic i_system_rdy,
    output logic [31:0] o_wb_adr,
    output logic [15:0] o_wb_sel,
    output logic o_wb_we,
    output logic [127:0] o_wb_dat,
    output logic o_wb_cyc,
    output logic o_wb_stb,
    input logic i_wb_ack,
    input logic i_wb_err
    );

logic [127:0] i_wb_dat;

RandomNumberGenerator #(128, 3) rng (
  .clk(clk),
  .reset(reset),
  .random_number(i_wb_dat[127:0])
);

amber amb (
    .i_clk(clk),
    .i_irq(i_irq),
    .i_firq(i_firq),
    .i_system_rdy(i_system_rdy),
    .o_wb_adr(o_wb_adr[31:0]),
    .o_wb_sel(o_wb_sel[15:0]),
    .o_wb_we(o_wb_we),
    .i_wb_dat(i_wb_dat[127:0]),
    .o_wb_dat(o_wb_dat[127:0]),
    .o_wb_cyc(o_wb_cyc),
    .o_wb_stb(o_wb_stb),
    .i_wb_ack(i_wb_ack),
    .i_wb_err(i_wb_err)
);

endmodule