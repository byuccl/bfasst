/*
* sv_chip0_hierarchy_no_mem top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../../random_number_generator.sv"

module sv_chip0_hierarchy_no_mem_random(
    input clk,
    input reset,
    input logic tm3_clk_v0,
    output logic [1:0]offchip_sram_oe,
    input logic [2:0] counter_out_1to0,
    input logic vidin_new_data_fifo,
    input logic [7:0] vidin_rgb_reg_fifo_left,
    input logic [7:0] vidin_rgb_reg_fifo_right,
    input logic [3:0] vidin_addr_reg_2to0,
    output logic v_nd_s1_left_2to0,
    output logic v_nd_s2_left_2to0,
    output logic v_nd_s4_left_2to0,
    output logic [7:0] v_d_reg_s1_left_2to0,
    output logic [7:0] v_d_reg_s2_left_2to0,
    output logic [7:0] v_d_reg_s4_left_2to0,
    output logic v_nd_s1_right_2to0,
    output logic v_nd_s2_right_2to0,
    output logic v_nd_s4_right_2to0,
    output logic tm3_vidout_clock,
    output logic tm3_vidout_hsync,
    output logic tm3_vidout_vsync,
    output logic tm3_vidout_blank
    );


logic [18:0] offchip_sram_addr;
logic [63:0] offchip_sram_data_out;
logic [7:0] offchip_sram_we;
logic [7:0] v_d_reg_s1_right_2to0;
logic [7:0] v_d_reg_s2_right_2to0;
logic [7:0] v_d_reg_s4_right_2to0;
logic [9:0] tm3_vidout_red;
logic [9:0] tm3_vidout_green;
logic [9:0] tm3_vidout_blue;
logic [15:0] depth_out;

logic [63:0] offchip_sram_data_in;
logic [15:0] x_in;
logic [15:0] y_in;
logic [7:0] bus_word_1_1to0;
logic [7:0] bus_word_2_1to0;
logic [7:0] bus_word_3_1to0;
logic [7:0] bus_word_4_1to0;
logic [7:0] bus_word_5_1to0;
logic [7:0] bus_word_6_1to0;

RandomNumberGenerator #(64, 3) rng_offchip_sram_data_in (
  .clk(clk),
  .reset(reset),
  .random_number(offchip_sram_data_in[63:0])
);

RandomNumberGenerator #(16, 5) rng_x_in (
  .clk(clk),
  .reset(reset),
  .random_number(x_in[15:0])
);

RandomNumberGenerator #(16, 7) rng_y_in (
  .clk(clk),
  .reset(reset),
  .random_number(y_in[15:0])
);

RandomNumberGenerator #(8, 9) rng_bus_word_1_1to0 (
  .clk(clk),
  .reset(reset),
  .random_number(bus_word_1_1to0[7:0])
);

RandomNumberGenerator #(8, 11) rng_bus_word_2_1to0 (
  .clk(clk),
  .reset(reset),
  .random_number(bus_word_2_1to0[7:0])
);

RandomNumberGenerator #(8, 13) rng_bus_word_3_1to0 (
  .clk(clk),
  .reset(reset),
  .random_number(bus_word_3_1to0[7:0])
);

RandomNumberGenerator #(8, 15) rng_bus_word_4_1to0 (
  .clk(clk),
  .reset(reset),
  .random_number(bus_word_4_1to0[7:0])
);

RandomNumberGenerator #(8, 17) rng_bus_word_5_1to0 (
  .clk(clk),
  .reset(reset),
  .random_number(bus_word_5_1to0[7:0])
);

RandomNumberGenerator #(8, 19) rng_bus_word_6_1to0 (
  .clk(clk),
  .reset(reset),
  .random_number(bus_word_6_1to0[7:0])
);

sv_chip0_hierarchy_no_mem sv_chip0_hierarchy_no_mem (
    .tm3_clk_v0(tm3_clk_v0),
    .offchip_sram_data_in(offchip_sram_data_in[63:0]),
    .offchip_sram_addr(offchip_sram_addr[18:0]),
    .offchip_sram_data_out(offchip_sram_data_out[63:0]),
    .offchip_sram_we(offchip_sram_we[7:0]),
    .offchip_sram_oe(offchip_sram_oe[1:0]),
    .bus_word_1_1to0(bus_word_1_1to0[7:0]),
    .bus_word_2_1to0(bus_word_2_1to0[7:0]),
    .bus_word_3_1to0(bus_word_3_1to0[7:0]),
    .bus_word_4_1to0(bus_word_4_1to0[7:0]),
    .bus_word_5_1to0(bus_word_5_1to0[7:0]),
    .bus_word_6_1to0(bus_word_6_1to0[7:0]),
    .counter_out_1to0(counter_out_1to0[2:0]),
    .vidin_new_data_fifo(vidin_new_data_fifo),
    .vidin_rgb_reg_fifo_left(vidin_rgb_reg_fifo_left[7:0]),
    .vidin_rgb_reg_fifo_right(vidin_rgb_reg_fifo_right[7:0]),
    .vidin_addr_reg_2to0(vidin_addr_reg_2to0[3:0]),
    .v_nd_s1_left_2to0(v_nd_s1_left_2to0),
    .v_nd_s2_left_2to0(v_nd_s2_left_2to0),
    .v_nd_s4_left_2to0(v_nd_s4_left_2to0),
    .v_d_reg_s1_left_2to0(v_d_reg_s1_left_2to0[7:0]),
    .v_d_reg_s2_left_2to0(v_d_reg_s2_left_2to0[7:0]),
    .v_d_reg_s4_left_2to0(v_d_reg_s4_left_2to0[7:0]),
    .v_nd_s1_right_2to0(v_nd_s1_right_2to0),
    .v_nd_s2_right_2to0(v_nd_s2_right_2to0),
    .v_nd_s4_right_2to0(v_nd_s4_right_2to0),
    .v_d_reg_s1_right_2to0(v_d_reg_s1_right_2to0[7:0]),
    .v_d_reg_s2_right_2to0(v_d_reg_s2_right_2to0[7:0]),
    .v_d_reg_s4_right_2to0(v_d_reg_s4_right_2to0[7:0]),
    .tm3_vidout_red(tm3_vidout_red[9:0]),
    .tm3_vidout_green(tm3_vidout_green[9:0]),
    .tm3_vidout_blue(tm3_vidout_blue[9:0]),
    .tm3_vidout_clock(tm3_vidout_clock),
    .tm3_vidout_hsync(tm3_vidout_hsync),
    .tm3_vidout_vsync(tm3_vidout_vsync),
    .tm3_vidout_blank(tm3_vidout_blank),
    .x_in(x_in[15:0]),
    .y_in(y_in[15:0]),
    .depth_out(depth_out[15:0])
    );

endmodule