/*
* sv_chip2_hierarchy_no_mem top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module sv_chip2_hierarchy_no_mem_random(
    input logic clk,
    input logic reset,
    output logic [1:0]offchip_sram_oe,
    input logic tm3_clk_v0,
    output logic tm3_sram_adsp,
    input logic vidin_new_data,
    input logic svid_comp_switch,
    output logic [2:0] counter_out_2to1,
    output logic vidin_new_data_fifo,
    output logic [3:0] vidin_addr_reg_2to0,
    input logic v_nd_s1_left_2to0,
    input logic v_nd_s2_left_2to0,
    input logic v_nd_s4_left_2to0,
    input logic v_nd_s1_right_2to0,
    input logic v_nd_s2_right_2to0,
    input logic v_nd_s4_right_2to0
    );

logic [18:0]offchip_sram_addr;
logic [63:0]offchip_sram_data_out;
logic [7:0]offchip_sram_we;
logic [15:0] bus_word_3_2to1;
logic [15:0] bus_word_4_2to1;
logic [15:0] bus_word_5_2to1;
logic [15:0] bus_word_6_2to1;
logic [7:0] vidin_rgb_reg_fifo_left;
logic [7:0] vidin_rgb_reg_fifo_right;

logic [63:0]offchip_sram_data_in;
logic [7:0] vidin_rgb_reg;
logic [18:0] vidin_addr_reg;
logic [7:0] v_d_reg_s1_left_2to0;
logic [7:0] v_d_reg_s2_left_2to0;
logic [7:0] v_d_reg_s4_left_2to0;
logic [7:0] v_d_reg_s1_right_2to0;
logic [7:0] v_d_reg_s2_right_2to0;
logic [7:0] v_d_reg_s4_right_2to0;

RandomNumberGenerator #(64, 3) rng_offchip_sram_data_in (
  .clk(clk),
  .reset(reset),
  .random_number(offchip_sram_data_in[63:0])
);

RandomNumberGenerator #(8, 5) rng_vidin_rgb_reg (
  .clk(clk),
  .reset(reset),
  .random_number(vidin_rgb_reg[7:0])
);

RandomNumberGenerator #(19, 7) rng_vidin_addr_reg (
  .clk(clk),
  .reset(reset),
  .random_number(vidin_addr_reg[18:0])
);

RandomNumberGenerator #(8, 9) rng_v_d_reg_s1_left_2to0 (
  .clk(clk),
  .reset(reset),
  .random_number(v_d_reg_s1_left_2to0[7:0])
);

RandomNumberGenerator #(8, 11) rng_v_d_reg_s2_left_2to0 (
  .clk(clk),
  .reset(reset),
  .random_number(v_d_reg_s2_left_2to0[7:0])
);

RandomNumberGenerator #(8, 13) rng_v_d_reg_s4_left_2to0 (
  .clk(clk),
  .reset(reset),
  .random_number(v_d_reg_s4_left_2to0[7:0])
);

RandomNumberGenerator #(8, 15) rng_v_d_reg_s1_right_2to0 (
  .clk(clk),
  .reset(reset),
  .random_number(v_d_reg_s1_right_2to0[7:0])
);

RandomNumberGenerator #(8, 17) rng_v_d_reg_s2_right_2to0 (
  .clk(clk),
  .reset(reset),
  .random_number(v_d_reg_s2_right_2to0[7:0])
);

RandomNumberGenerator #(8, 19) rng_v_d_reg_s4_right_2to0 (
  .clk(clk),
  .reset(reset),
  .random_number(v_d_reg_s4_right_2to0[7:0])
);

sv_chip2_hierarchy_no_mem sv_chip2_hierarchy_no_mem (
    .reset(reset),
    .offchip_sram_data_in(offchip_sram_data_in[63:0]),
    .offchip_sram_addr(offchip_sram_addr[18:0]),
    .offchip_sram_data_out(offchip_sram_data_out[63:0]),
    .offchip_sram_we(offchip_sram_we[7:0]),
    .offchip_sram_oe(offchip_sram_oe[1:0]),
    .tm3_clk_v0(tm3_clk_v0),
    .tm3_sram_adsp(tm3_sram_adsp),
    .vidin_new_data(vidin_new_data),
    .vidin_rgb_reg(vidin_rgb_reg[7:0]),
    .vidin_addr_reg(vidin_addr_reg[18:0]),
    .svid_comp_switch(svid_comp_switch),
    .counter_out_2to1(counter_out_2to1[2:0]),
    .bus_word_3_2to1(bus_word_3_2to1[15:0]),
    .bus_word_4_2to1(bus_word_4_2to1[15:0]),
    .bus_word_5_2to1(bus_word_5_2to1[15:0]),
    .bus_word_6_2to1(bus_word_6_2to1[15:0]),
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
    .v_d_reg_s4_right_2to0(v_d_reg_s4_right_2to0[7:0])
    );

endmodule