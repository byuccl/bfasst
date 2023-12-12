// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
// Date        : Fri May 26 10:15:05 2023
// Host        : goeders1 running 64-bit Ubuntu 20.04.3 LTS
// Command     : write_verilog ./mc_top_synthed.v -force
// Design      : mc_top
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7a100tcsg324-3
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* STRUCTURAL_NETLIST = "yes" *)
module mc_top
   (clk_i,
    rst_i,
    wb_data_i,
    wb_data_o,
    wb_addr_i,
    wb_sel_i,
    wb_we_i,
    wb_cyc_i,
    wb_stb_i,
    wb_ack_o,
    wb_err_o,
    susp_req_i,
    resume_req_i,
    suspended_o,
    poc_o,
    mc_clk_i,
    mc_br_pad_i,
    mc_bg_pad_o,
    mc_ack_pad_i,
    mc_addr_pad_o,
    mc_data_pad_i,
    mc_data_pad_o,
    mc_dp_pad_i,
    mc_dp_pad_o,
    mc_doe_pad_doe_o,
    mc_dqm_pad_o,
    mc_oe_pad_o_,
    mc_we_pad_o_,
    mc_cas_pad_o_,
    mc_ras_pad_o_,
    mc_cke_pad_o_,
    mc_cs_pad_o_,
    mc_sts_pad_i,
    mc_rp_pad_o_,
    mc_vpen_pad_o,
    mc_adsc_pad_o_,
    mc_adv_pad_o_,
    mc_zz_pad_o,
    mc_coe_pad_coe_o);
  input clk_i;
  input rst_i;
  input [31:0]wb_data_i;
  output [31:0]wb_data_o;
  input [31:0]wb_addr_i;
  input [3:0]wb_sel_i;
  input wb_we_i;
  input wb_cyc_i;
  input wb_stb_i;
  output wb_ack_o;
  output wb_err_o;
  input susp_req_i;
  input resume_req_i;
  output suspended_o;
  output [31:0]poc_o;
  input mc_clk_i;
  input mc_br_pad_i;
  output mc_bg_pad_o;
  input mc_ack_pad_i;
  output [23:0]mc_addr_pad_o;
  input [31:0]mc_data_pad_i;
  output [31:0]mc_data_pad_o;
  input [3:0]mc_dp_pad_i;
  output [3:0]mc_dp_pad_o;
  output mc_doe_pad_doe_o;
  output [3:0]mc_dqm_pad_o;
  output mc_oe_pad_o_;
  output mc_we_pad_o_;
  output mc_cas_pad_o_;
  output mc_ras_pad_o_;
  output mc_cke_pad_o_;
  output [7:0]mc_cs_pad_o_;
  input mc_sts_pad_i;
  output mc_rp_pad_o_;
  output mc_vpen_pad_o;
  output mc_adsc_pad_o_;
  output mc_adv_pad_o_;
  output mc_zz_pad_o;
  output mc_coe_pad_coe_o;

  wire \<const0> ;
  wire \<const1> ;
  wire \FSM_sequential_state[0]_i_10_n_0 ;
  wire \FSM_sequential_state[0]_i_11_n_0 ;
  wire \FSM_sequential_state[0]_i_12_n_0 ;
  wire \FSM_sequential_state[0]_i_13_n_0 ;
  wire \FSM_sequential_state[0]_i_14_n_0 ;
  wire \FSM_sequential_state[0]_i_15_n_0 ;
  wire \FSM_sequential_state[0]_i_16_n_0 ;
  wire \FSM_sequential_state[0]_i_17_n_0 ;
  wire \FSM_sequential_state[0]_i_18_n_0 ;
  wire \FSM_sequential_state[0]_i_1_n_0 ;
  wire \FSM_sequential_state[0]_i_2_n_0 ;
  wire \FSM_sequential_state[0]_i_3_n_0 ;
  wire \FSM_sequential_state[0]_i_4_n_0 ;
  wire \FSM_sequential_state[0]_i_5_n_0 ;
  wire \FSM_sequential_state[0]_i_6_n_0 ;
  wire \FSM_sequential_state[0]_i_7_n_0 ;
  wire \FSM_sequential_state[0]_i_8_n_0 ;
  wire \FSM_sequential_state[0]_i_9_n_0 ;
  wire \FSM_sequential_state[1]_i_10_n_0 ;
  wire \FSM_sequential_state[1]_i_11_n_0 ;
  wire \FSM_sequential_state[1]_i_12_n_0 ;
  wire \FSM_sequential_state[1]_i_13_n_0 ;
  wire \FSM_sequential_state[1]_i_14_n_0 ;
  wire \FSM_sequential_state[1]_i_15_n_0 ;
  wire \FSM_sequential_state[1]_i_16_n_0 ;
  wire \FSM_sequential_state[1]_i_17_n_0 ;
  wire \FSM_sequential_state[1]_i_18_n_0 ;
  wire \FSM_sequential_state[1]_i_19_n_0 ;
  wire \FSM_sequential_state[1]_i_1_n_0 ;
  wire \FSM_sequential_state[1]_i_20_n_0 ;
  wire \FSM_sequential_state[1]_i_21_n_0 ;
  wire \FSM_sequential_state[1]_i_2_n_0 ;
  wire \FSM_sequential_state[1]_i_3_n_0 ;
  wire \FSM_sequential_state[1]_i_4_n_0 ;
  wire \FSM_sequential_state[1]_i_5_n_0 ;
  wire \FSM_sequential_state[1]_i_6_n_0 ;
  wire \FSM_sequential_state[1]_i_7_n_0 ;
  wire \FSM_sequential_state[1]_i_8_n_0 ;
  wire \FSM_sequential_state[1]_i_9_n_0 ;
  wire \FSM_sequential_state[2]_i_10_n_0 ;
  wire \FSM_sequential_state[2]_i_11_n_0 ;
  wire \FSM_sequential_state[2]_i_12_n_0 ;
  wire \FSM_sequential_state[2]_i_13_n_0 ;
  wire \FSM_sequential_state[2]_i_14_n_0 ;
  wire \FSM_sequential_state[2]_i_15_n_0 ;
  wire \FSM_sequential_state[2]_i_16_n_0 ;
  wire \FSM_sequential_state[2]_i_17_n_0 ;
  wire \FSM_sequential_state[2]_i_18_n_0 ;
  wire \FSM_sequential_state[2]_i_19_n_0 ;
  wire \FSM_sequential_state[2]_i_1_n_0 ;
  wire \FSM_sequential_state[2]_i_20_n_0 ;
  wire \FSM_sequential_state[2]_i_21_n_0 ;
  wire \FSM_sequential_state[2]_i_22_n_0 ;
  wire \FSM_sequential_state[2]_i_2_n_0 ;
  wire \FSM_sequential_state[2]_i_3_n_0 ;
  wire \FSM_sequential_state[2]_i_4_n_0 ;
  wire \FSM_sequential_state[2]_i_5_n_0 ;
  wire \FSM_sequential_state[2]_i_6_n_0 ;
  wire \FSM_sequential_state[2]_i_7_n_0 ;
  wire \FSM_sequential_state[2]_i_8_n_0 ;
  wire \FSM_sequential_state[2]_i_9_n_0 ;
  wire \FSM_sequential_state[3]_i_10_n_0 ;
  wire \FSM_sequential_state[3]_i_11_n_0 ;
  wire \FSM_sequential_state[3]_i_12_n_0 ;
  wire \FSM_sequential_state[3]_i_1_n_0 ;
  wire \FSM_sequential_state[3]_i_2_n_0 ;
  wire \FSM_sequential_state[3]_i_3_n_0 ;
  wire \FSM_sequential_state[3]_i_4_n_0 ;
  wire \FSM_sequential_state[3]_i_5_n_0 ;
  wire \FSM_sequential_state[3]_i_6_n_0 ;
  wire \FSM_sequential_state[3]_i_7_n_0 ;
  wire \FSM_sequential_state[3]_i_8_n_0 ;
  wire \FSM_sequential_state[3]_i_9_n_0 ;
  wire \FSM_sequential_state[4]_i_10_n_0 ;
  wire \FSM_sequential_state[4]_i_11_n_0 ;
  wire \FSM_sequential_state[4]_i_1_n_0 ;
  wire \FSM_sequential_state[4]_i_2_n_0 ;
  wire \FSM_sequential_state[4]_i_3_n_0 ;
  wire \FSM_sequential_state[4]_i_4_n_0 ;
  wire \FSM_sequential_state[4]_i_5_n_0 ;
  wire \FSM_sequential_state[4]_i_6_n_0 ;
  wire \FSM_sequential_state[4]_i_7_n_0 ;
  wire \FSM_sequential_state[4]_i_8_n_0 ;
  wire \FSM_sequential_state[4]_i_9_n_0 ;
  wire \FSM_sequential_state[5]_i_1_n_0 ;
  wire \FSM_sequential_state[5]_i_2_n_0 ;
  wire \FSM_sequential_state[5]_i_3_n_0 ;
  wire \FSM_sequential_state[5]_i_4_n_0 ;
  wire \FSM_sequential_state[5]_i_5_n_0 ;
  wire \FSM_sequential_state[5]_i_6_n_0 ;
  wire \FSM_sequential_state[5]_i_7_n_0 ;
  wire \FSM_sequential_state[5]_i_8_n_0 ;
  wire \FSM_sequential_state[5]_i_9_n_0 ;
  wire \FSM_sequential_state[6]_i_10_n_0 ;
  wire \FSM_sequential_state[6]_i_11_n_0 ;
  wire \FSM_sequential_state[6]_i_12_n_0 ;
  wire \FSM_sequential_state[6]_i_13_n_0 ;
  wire \FSM_sequential_state[6]_i_14_n_0 ;
  wire \FSM_sequential_state[6]_i_15_n_0 ;
  wire \FSM_sequential_state[6]_i_16_n_0 ;
  wire \FSM_sequential_state[6]_i_17_n_0 ;
  wire \FSM_sequential_state[6]_i_18_n_0 ;
  wire \FSM_sequential_state[6]_i_19_n_0 ;
  wire \FSM_sequential_state[6]_i_1_n_0 ;
  wire \FSM_sequential_state[6]_i_20_n_0 ;
  wire \FSM_sequential_state[6]_i_21_n_0 ;
  wire \FSM_sequential_state[6]_i_22_n_0 ;
  wire \FSM_sequential_state[6]_i_23_n_0 ;
  wire \FSM_sequential_state[6]_i_24_n_0 ;
  wire \FSM_sequential_state[6]_i_25_n_0 ;
  wire \FSM_sequential_state[6]_i_26_n_0 ;
  wire \FSM_sequential_state[6]_i_27_n_0 ;
  wire \FSM_sequential_state[6]_i_28_n_0 ;
  wire \FSM_sequential_state[6]_i_29_n_0 ;
  wire \FSM_sequential_state[6]_i_2_n_0 ;
  wire \FSM_sequential_state[6]_i_30_n_0 ;
  wire \FSM_sequential_state[6]_i_31_n_0 ;
  wire \FSM_sequential_state[6]_i_32_n_0 ;
  wire \FSM_sequential_state[6]_i_33_n_0 ;
  wire \FSM_sequential_state[6]_i_34_n_0 ;
  wire \FSM_sequential_state[6]_i_35_n_0 ;
  wire \FSM_sequential_state[6]_i_36_n_0 ;
  wire \FSM_sequential_state[6]_i_37_n_0 ;
  wire \FSM_sequential_state[6]_i_38_n_0 ;
  wire \FSM_sequential_state[6]_i_39_n_0 ;
  wire \FSM_sequential_state[6]_i_3_n_0 ;
  wire \FSM_sequential_state[6]_i_40_n_0 ;
  wire \FSM_sequential_state[6]_i_41_n_0 ;
  wire \FSM_sequential_state[6]_i_42_n_0 ;
  wire \FSM_sequential_state[6]_i_43_n_0 ;
  wire \FSM_sequential_state[6]_i_44_n_0 ;
  wire \FSM_sequential_state[6]_i_45_n_0 ;
  wire \FSM_sequential_state[6]_i_46_n_0 ;
  wire \FSM_sequential_state[6]_i_47_n_0 ;
  wire \FSM_sequential_state[6]_i_48_n_0 ;
  wire \FSM_sequential_state[6]_i_4_n_0 ;
  wire \FSM_sequential_state[6]_i_5_n_0 ;
  wire \FSM_sequential_state[6]_i_6_n_0 ;
  wire \FSM_sequential_state[6]_i_7_n_0 ;
  wire \FSM_sequential_state[6]_i_8_n_0 ;
  wire \FSM_sequential_state[6]_i_9_n_0 ;
  wire \ack_cnt[1]_i_1_n_0 ;
  wire \ack_cnt[2]_i_1_n_0 ;
  wire \ack_cnt[3]_i_1_n_0 ;
  wire \ack_cnt[3]_i_3_n_0 ;
  wire [23:0]acs_addr;
  wire \acs_addr[0]_i_1_n_0 ;
  wire \acs_addr[0]_i_2_n_0 ;
  wire \acs_addr[10]_i_1_n_0 ;
  wire \acs_addr[10]_i_2_n_0 ;
  wire \acs_addr[11]_i_1_n_0 ;
  wire \acs_addr[11]_i_2_n_0 ;
  wire \acs_addr[12]_i_1_n_0 ;
  wire \acs_addr[12]_i_2_n_0 ;
  wire \acs_addr[13]_i_1_n_0 ;
  wire \acs_addr[13]_i_2_n_0 ;
  wire \acs_addr[14]_i_1_n_0 ;
  wire \acs_addr[14]_i_2_n_0 ;
  wire \acs_addr[15]_i_1_n_0 ;
  wire \acs_addr[15]_i_3_n_0 ;
  wire \acs_addr[15]_i_4_n_0 ;
  wire \acs_addr[16]_i_1_n_0 ;
  wire \acs_addr[16]_i_2_n_0 ;
  wire \acs_addr[17]_i_1_n_0 ;
  wire \acs_addr[17]_i_2_n_0 ;
  wire \acs_addr[18]_i_1_n_0 ;
  wire \acs_addr[18]_i_2_n_0 ;
  wire \acs_addr[19]_i_1_n_0 ;
  wire \acs_addr[19]_i_3_n_0 ;
  wire \acs_addr[1]_i_1_n_0 ;
  wire \acs_addr[1]_i_2_n_0 ;
  wire \acs_addr[20]_i_1_n_0 ;
  wire \acs_addr[20]_i_2_n_0 ;
  wire \acs_addr[21]_i_1_n_0 ;
  wire \acs_addr[21]_i_2_n_0 ;
  wire \acs_addr[22]_i_1_n_0 ;
  wire \acs_addr[22]_i_2_n_0 ;
  wire \acs_addr[23]_i_1_n_0 ;
  wire \acs_addr[23]_i_2_n_0 ;
  wire \acs_addr[23]_i_3_n_0 ;
  wire \acs_addr[23]_i_4_n_0 ;
  wire \acs_addr[23]_i_6_n_0 ;
  wire \acs_addr[2]_i_1_n_0 ;
  wire \acs_addr[2]_i_2_n_0 ;
  wire \acs_addr[3]_i_1_n_0 ;
  wire \acs_addr[3]_i_2_n_0 ;
  wire \acs_addr[4]_i_1_n_0 ;
  wire \acs_addr[4]_i_2_n_0 ;
  wire \acs_addr[5]_i_1_n_0 ;
  wire \acs_addr[5]_i_2_n_0 ;
  wire \acs_addr[6]_i_1_n_0 ;
  wire \acs_addr[6]_i_2_n_0 ;
  wire \acs_addr[7]_i_1_n_0 ;
  wire \acs_addr[7]_i_2_n_0 ;
  wire \acs_addr[8]_i_1_n_0 ;
  wire \acs_addr[8]_i_2_n_0 ;
  wire \acs_addr[9]_i_1_n_0 ;
  wire \acs_addr[9]_i_2_n_0 ;
  wire \acs_addr_reg[15]_i_2_n_0 ;
  wire \acs_addr_reg[15]_i_2_n_1 ;
  wire \acs_addr_reg[15]_i_2_n_2 ;
  wire \acs_addr_reg[15]_i_2_n_3 ;
  wire \acs_addr_reg[19]_i_2_n_0 ;
  wire \acs_addr_reg[19]_i_2_n_1 ;
  wire \acs_addr_reg[19]_i_2_n_2 ;
  wire \acs_addr_reg[19]_i_2_n_3 ;
  wire \acs_addr_reg[23]_i_5_n_1 ;
  wire \acs_addr_reg[23]_i_5_n_2 ;
  wire \acs_addr_reg[23]_i_5_n_3 ;
  wire ap_en_i_1_n_0;
  wire ap_en_i_2_n_0;
  wire [12:0]b0_last_row;
  wire \b0_last_row[12]_i_1_n_0 ;
  wire [12:0]b1_last_row;
  wire \b1_last_row[12]_i_1_n_0 ;
  wire [12:0]b2_last_row;
  wire \b2_last_row[12]_i_1_n_0 ;
  wire [12:0]b3_last_row;
  wire \b3_last_row[12]_i_1_n_0 ;
  wire \b3_last_row[12]_i_2__0_n_0 ;
  wire \b3_last_row[12]_i_2_n_0 ;
  wire \b3_last_row[12]_i_3_n_0 ;
  wire \b3_last_row[12]_i_4_n_0 ;
  wire bank0_open_i_1__0_n_0;
  wire bank0_open_i_1_n_0;
  wire bank1_open_i_1__0_n_0;
  wire bank1_open_i_1_n_0;
  wire bank2_open_i_1__0_n_0;
  wire bank2_open_i_1_n_0;
  wire bank3_open_i_1__0_n_0;
  wire bank3_open_i_1_n_0;
  wire bank3_open_i_2__0_n_0;
  wire bank3_open_i_2_n_0;
  wire bank3_open_i_3__0_n_0;
  wire bank3_open_i_3_n_0;
  wire bank3_open_i_4_n_0;
  wire bank3_open_i_5_n_0;
  wire bank3_open_i_6_n_0;
  wire bank3_open_i_7_n_0;
  wire [1:0]bank_adr;
  wire \bank_adr[0]_i_1_n_0 ;
  wire \bank_adr[0]_i_2_n_0 ;
  wire \bank_adr[0]_i_3_n_0 ;
  wire \bank_adr[0]_i_4_n_0 ;
  wire \bank_adr[1]_i_1_n_0 ;
  wire \bank_adr[1]_i_2_n_0 ;
  wire \bank_adr[1]_i_3_n_0 ;
  wire \bank_adr[1]_i_4_n_0 ;
  wire \bank_adr[1]_i_5_n_0 ;
  wire \bank_adr[1]_i_6_n_0 ;
  wire bank_open;
  wire bank_open_i_2_n_0;
  wire bank_open_i_3_n_0;
  wire burst_act_rd_i_2_n_0;
  wire burst_act_rd_i_3_n_0;
  wire \burst_cnt[10]_i_10_n_0 ;
  wire \burst_cnt[10]_i_2_n_0 ;
  wire \burst_cnt[10]_i_4_n_0 ;
  wire \burst_cnt[10]_i_5_n_0 ;
  wire \burst_cnt[10]_i_7_n_0 ;
  wire \burst_cnt[10]_i_8_n_0 ;
  wire \burst_cnt[10]_i_9_n_0 ;
  wire \burst_cnt[3]_i_2_n_0 ;
  wire \burst_cnt[3]_i_3_n_0 ;
  wire \burst_cnt[3]_i_4_n_0 ;
  wire \burst_cnt[6]_i_2_n_0 ;
  wire \burst_cnt[7]_i_2_n_0 ;
  wire \burst_cnt[8]_i_2_n_0 ;
  wire \burst_cnt[8]_i_3_n_0 ;
  wire \burst_cnt[8]_i_4_n_0 ;
  wire \burst_cnt[9]_i_2_n_0 ;
  wire [7:0]byte0;
  wire [7:0]byte1;
  wire \byte1[0]_i_1_n_0 ;
  wire \byte1[1]_i_1_n_0 ;
  wire \byte1[2]_i_1_n_0 ;
  wire \byte1[3]_i_1_n_0 ;
  wire \byte1[4]_i_1_n_0 ;
  wire \byte1[5]_i_1_n_0 ;
  wire \byte1[6]_i_1_n_0 ;
  wire \byte1[7]_i_1_n_0 ;
  wire \byte1[7]_i_2_n_0 ;
  wire [7:0]byte2;
  wire cas_;
  wire cke__i_2_n_0;
  wire cke__i_3_n_0;
  wire cke__i_4_n_0;
  wire cke__i_5_n_0;
  wire cke_r_i_1_n_0;
  wire cke_r_i_2_n_0;
  wire cke_r_i_3_n_0;
  wire cke_r_i_4_n_0;
  wire cke_r_i_5_n_0;
  wire clk_i;
  wire cmd_a10;
  wire cmd_a10_r_i_10_n_0;
  wire cmd_a10_r_i_11_n_0;
  wire cmd_a10_r_i_12_n_0;
  wire cmd_a10_r_i_2_n_0;
  wire cmd_a10_r_i_3_n_0;
  wire cmd_a10_r_i_4_n_0;
  wire cmd_a10_r_i_5_n_0;
  wire cmd_a10_r_i_6_n_0;
  wire cmd_a10_r_i_7_n_0;
  wire cmd_a10_r_i_8_n_0;
  wire cmd_a10_r_i_9_n_0;
  wire cmd_asserted_i_10_n_0;
  wire cmd_asserted_i_1_n_0;
  wire cmd_asserted_i_2_n_0;
  wire cmd_asserted_i_3_n_0;
  wire cmd_asserted_i_4_n_0;
  wire cmd_asserted_i_5_n_0;
  wire cmd_asserted_i_6_n_0;
  wire cmd_asserted_i_7_n_0;
  wire cmd_asserted_i_8_n_0;
  wire cmd_asserted_i_9_n_0;
  wire \cmd_r[0]_i_10_n_0 ;
  wire \cmd_r[0]_i_11_n_0 ;
  wire \cmd_r[0]_i_12_n_0 ;
  wire \cmd_r[0]_i_13_n_0 ;
  wire \cmd_r[0]_i_2_n_0 ;
  wire \cmd_r[0]_i_3_n_0 ;
  wire \cmd_r[0]_i_4_n_0 ;
  wire \cmd_r[0]_i_5_n_0 ;
  wire \cmd_r[0]_i_6_n_0 ;
  wire \cmd_r[0]_i_7_n_0 ;
  wire \cmd_r[0]_i_8_n_0 ;
  wire \cmd_r[0]_i_9_n_0 ;
  wire \cmd_r[1]_i_2_n_0 ;
  wire \cmd_r[1]_i_3_n_0 ;
  wire \cmd_r[1]_i_4_n_0 ;
  wire \cmd_r[1]_i_5_n_0 ;
  wire \cmd_r[2]_i_2_n_0 ;
  wire \cmd_r[2]_i_3_n_0 ;
  wire \cmd_r[2]_i_4_n_0 ;
  wire cnt_i_2_n_0;
  wire [9:0]col_adr;
  wire \col_adr[9]_i_1_n_0 ;
  wire \col_adr[9]_i_3_n_0 ;
  wire [1:0]cs;
  wire \cs[0]_i_1_n_0 ;
  wire cs_le;
  wire cs_le_d;
  wire cs_le_i_10_n_0;
  wire cs_le_i_11_n_0;
  wire cs_le_i_12_n_0;
  wire cs_le_i_13_n_0;
  wire cs_le_i_14_n_0;
  wire cs_le_i_2_n_0;
  wire cs_le_i_3_n_0;
  wire cs_le_i_4_n_0;
  wire cs_le_i_5_n_0;
  wire cs_le_i_6_n_0;
  wire cs_le_i_7_n_0;
  wire cs_le_i_8_n_0;
  wire cs_le_i_9_n_0;
  wire [11:1]csc;
  wire \csc[0]_i_1_n_0 ;
  wire \csc[10]_i_1_n_0 ;
  wire \csc[11]_i_10_n_0 ;
  wire \csc[11]_i_11_n_0 ;
  wire \csc[11]_i_12_n_0 ;
  wire \csc[11]_i_13_n_0 ;
  wire \csc[11]_i_1_n_0 ;
  wire \csc[11]_i_2_n_0 ;
  wire \csc[11]_i_3_n_0 ;
  wire \csc[11]_i_5_n_0 ;
  wire \csc[11]_i_6_n_0 ;
  wire \csc[11]_i_7_n_0 ;
  wire \csc[11]_i_8_n_0 ;
  wire \csc[11]_i_9_n_0 ;
  wire \csc[1]_i_1__0_n_0 ;
  wire \csc[1]_i_1_n_0 ;
  wire \csc[2]_i_1__0_n_0 ;
  wire \csc[2]_i_1_n_0 ;
  wire \csc[31]_i_1_n_0 ;
  wire \csc[3]_i_1_n_0 ;
  wire \csc[4]_i_1__0_n_0 ;
  wire \csc[4]_i_1_n_0 ;
  wire \csc[5]_i_1__0_n_0 ;
  wire \csc[5]_i_1_n_0 ;
  wire \csc[5]_i_2_n_0 ;
  wire \csc[6]_i_1_n_0 ;
  wire \csc[7]_i_1_n_0 ;
  wire \csc[9]_i_1_n_0 ;
  wire [10:6]csc__0;
  wire data_oe;
  wire data_oe_i_1_n_0;
  wire data_oe_i_2_n_0;
  wire data_oe_i_3_n_0;
  wire data_oe_r_i_1_n_0;
  wire data_oe_r_i_2_n_0;
  wire data_oe_r_i_3_n_0;
  wire data_oe_r_i_4_n_0;
  wire data_oe_r_i_5_n_0;
  wire data_oe_r_i_6_n_0;
  wire data_oe_r_i_7_n_0;
  wire dv;
  wire dv_r_i_2_n_0;
  wire dv_r_i_3_n_0;
  wire fs;
  wire inc_next;
  wire [11:0]inc_out0;
  wire init_ack;
  wire init_req;
  wire init_req_i_1__0_n_0;
  wire init_req_i_1__1_n_0;
  wire init_req_i_2__0_n_0;
  wire init_req_i_2_n_0;
  wire init_req_we_i_1_n_0;
  wire inited_i_1__0_n_0;
  wire inited_i_1_n_0;
  wire [3:0]ir_cnt0;
  wire \ir_cnt[1]_i_1_n_0 ;
  wire \ir_cnt[3]_i_4_n_0 ;
  wire ir_cnt_done_i_1_n_0;
  wire lmr_ack;
  wire lmr_ack_i_2_n_0;
  wire lmr_ack_i_3_n_0;
  wire lmr_req;
  wire lmr_req_i_1__0_n_0;
  wire lmr_req_i_1__1_n_0;
  wire lmr_req_i_2__0_n_0;
  wire lmr_req_i_2_n_0;
  wire lmr_req_we_i_1__0_n_0;
  wire mc_ack_pad_i;
  wire mc_ack_r;
  wire \mc_addr[0]_i_2_n_0 ;
  wire \mc_addr[0]_i_3_n_0 ;
  wire \mc_addr[10]_i_2_n_0 ;
  wire \mc_addr[10]_i_3_n_0 ;
  wire \mc_addr[10]_i_4_n_0 ;
  wire \mc_addr[11]_i_2_n_0 ;
  wire \mc_addr[11]_i_3_n_0 ;
  wire \mc_addr[12]_i_2_n_0 ;
  wire \mc_addr[12]_i_3_n_0 ;
  wire \mc_addr[12]_i_4_n_0 ;
  wire \mc_addr[12]_i_5_n_0 ;
  wire \mc_addr[13]_i_2_n_0 ;
  wire \mc_addr[14]_i_2_n_0 ;
  wire \mc_addr[14]_i_3_n_0 ;
  wire \mc_addr[14]_i_4_n_0 ;
  wire \mc_addr[1]_i_2_n_0 ;
  wire \mc_addr[1]_i_3_n_0 ;
  wire \mc_addr[23]_i_2_n_0 ;
  wire \mc_addr[23]_i_3_n_0 ;
  wire \mc_addr[23]_i_4_n_0 ;
  wire \mc_addr[2]_i_2_n_0 ;
  wire \mc_addr[2]_i_3_n_0 ;
  wire \mc_addr[2]_i_4_n_0 ;
  wire \mc_addr[3]_i_2_n_0 ;
  wire \mc_addr[3]_i_3_n_0 ;
  wire \mc_addr[3]_i_4_n_0 ;
  wire \mc_addr[4]_i_2_n_0 ;
  wire \mc_addr[4]_i_3_n_0 ;
  wire \mc_addr[4]_i_4_n_0 ;
  wire \mc_addr[5]_i_2_n_0 ;
  wire \mc_addr[5]_i_3_n_0 ;
  wire \mc_addr[5]_i_4_n_0 ;
  wire \mc_addr[6]_i_2_n_0 ;
  wire \mc_addr[6]_i_3_n_0 ;
  wire \mc_addr[6]_i_4_n_0 ;
  wire \mc_addr[7]_i_2_n_0 ;
  wire \mc_addr[7]_i_3_n_0 ;
  wire \mc_addr[7]_i_4_n_0 ;
  wire \mc_addr[8]_i_2_n_0 ;
  wire \mc_addr[8]_i_3_n_0 ;
  wire \mc_addr[8]_i_4_n_0 ;
  wire \mc_addr[9]_i_2_n_0 ;
  wire \mc_addr[9]_i_3_n_0 ;
  wire \mc_addr[9]_i_4_n_0 ;
  wire [23:0]mc_addr_d;
  wire [23:0]mc_addr_pad_o;
  wire mc_adsc__i_1_n_0;
  wire mc_adsc__i_2_n_0;
  wire mc_adsc__i_3_n_0;
  wire mc_adsc__i_4_n_0;
  wire mc_adsc__i_5_n_0;
  wire mc_adsc_pad_o_;
  wire mc_adv__i_1_n_0;
  wire mc_adv__i_2_n_0;
  wire mc_adv__i_3_n_0;
  wire mc_adv_d;
  wire mc_adv_pad_o_;
  wire mc_bg_d;
  wire mc_bg_i_2_n_0;
  wire mc_bg_i_3_n_0;
  wire mc_bg_i_4_n_0;
  wire mc_bg_i_5_n_0;
  wire mc_bg_pad_o;
  wire mc_br_pad_i;
  wire mc_br_r;
  wire mc_c_oe_d;
  wire mc_c_oe_i_2_n_0;
  wire mc_c_oe_i_3_n_0;
  wire mc_c_oe_i_4_n_0;
  wire mc_c_oe_i_5_n_0;
  wire mc_cas_pad_o_;
  wire mc_cke_pad_o_;
  wire mc_clk_i;
  wire mc_coe_pad_coe_o;
  wire \mc_cs_[0]_i_1_n_0 ;
  wire \mc_cs_[0]_i_2_n_0 ;
  wire \mc_cs_[1]_i_1_n_0 ;
  wire \mc_cs_[1]_i_2_n_0 ;
  wire \mc_cs_[1]_i_3_n_0 ;
  wire \mc_cs_[1]_i_4_n_0 ;
  wire \mc_cs_[1]_i_5_n_0 ;
  wire [1:0]\^mc_cs_pad_o_ ;
  wire [35:0]mc_data_ir;
  wire [31:0]mc_data_o;
  wire [31:0]mc_data_pad_i;
  wire [31:0]mc_data_pad_o;
  wire mc_doe_pad_doe_o;
  wire [3:0]mc_dp_o;
  wire mc_dp_o0;
  wire \mc_dp_o[0]_i_1_n_0 ;
  wire \mc_dp_o[0]_i_2_n_0 ;
  wire \mc_dp_o[1]_i_1_n_0 ;
  wire \mc_dp_o[1]_i_2_n_0 ;
  wire \mc_dp_o[2]_i_1_n_0 ;
  wire \mc_dp_o[2]_i_2_n_0 ;
  wire \mc_dp_o[3]_i_2_n_0 ;
  wire [3:0]mc_dp_pad_i;
  wire [3:0]mc_dp_pad_o;
  wire \mc_dqm[0]_i_1_n_0 ;
  wire \mc_dqm[1]_i_1_n_0 ;
  wire \mc_dqm[2]_i_1_n_0 ;
  wire \mc_dqm[3]_i_1_n_0 ;
  wire [3:0]mc_dqm_pad_o;
  wire [3:0]mc_dqm_r;
  wire [3:0]mc_dqm_r2;
  wire mc_le_i_1_n_0;
  wire mc_oe_pad_o_;
  wire mc_ras_pad_o_;
  wire mc_rp_pad_o_;
  wire mc_sts_ir;
  wire mc_sts_pad_i;
  wire mc_vpen_pad_o;
  wire mc_we_pad_o_;
  wire mc_zz_pad_o;
  wire mem_ack;
  wire mem_ack_r;
  wire mem_ack_r_i_10_n_0;
  wire mem_ack_r_i_11_n_0;
  wire mem_ack_r_i_12_n_0;
  wire mem_ack_r_i_13_n_0;
  wire mem_ack_r_i_14_n_0;
  wire mem_ack_r_i_2_n_0;
  wire mem_ack_r_i_3_n_0;
  wire mem_ack_r_i_4_n_0;
  wire mem_ack_r_i_5_n_0;
  wire mem_ack_r_i_6_n_0;
  wire mem_ack_r_i_7_n_0;
  wire mem_ack_r_i_8_n_0;
  wire mem_ack_r_i_9_n_0;
  wire no_wb_cycle_i_2_n_0;
  wire oe_;
  wire oe__i_1_n_0;
  wire oe__i_3_n_0;
  wire oe__i_4_n_0;
  wire oe__i_5_n_0;
  wire oe__reg_i_2_n_0;
  wire \out_r[0]_i_1_n_0 ;
  wire [10:0]p_0_in;
  wire [3:0]p_0_in__0;
  wire [7:0]p_0_in__1;
  wire [7:0]p_0_in__2;
  wire pack_le0;
  wire pack_le0_i_2_n_0;
  wire pack_le0_i_3_n_0;
  wire pack_le1;
  wire pack_le2;
  wire pack_le2_i_2_n_0;
  wire [31:0]poc_o;
  wire \ps_cnt[5]_i_2_n_0 ;
  wire \ps_cnt[7]_i_1_n_0 ;
  wire \ps_cnt[7]_i_3_n_0 ;
  wire [35:0]r0;
  wire [35:0]r1;
  wire [35:0]r2;
  wire [35:0]r3;
  wire ras_;
  wire \rd_adr[0]_i_1_n_0 ;
  wire \rd_adr[1]_i_1_n_0 ;
  wire \rd_adr[2]_i_1_n_0 ;
  wire \rd_adr[3]_i_1_n_0 ;
  wire \rd_adr[3]_i_2_n_0 ;
  wire resume_req_i;
  wire rfr_ack;
  wire rfr_ack_r_i_1_n_0;
  wire rfr_ack_r_i_2_n_0;
  wire rfr_ack_r_i_3_n_0;
  wire rfr_ack_r_i_4_n_0;
  wire rfr_ack_r_i_5_n_0;
  wire rfr_ack_r_i_6_n_0;
  wire rfr_ack_r_i_7_n_0;
  wire rfr_ce_i_2_n_0;
  wire rfr_clr_i_2_n_0;
  wire rfr_clr_i_3_n_0;
  wire rfr_clr_i_4_n_0;
  wire \rfr_cnt[2]_i_1_n_0 ;
  wire \rfr_cnt[4]_i_1_n_0 ;
  wire \rfr_cnt[6]_i_1_n_0 ;
  wire \rfr_cnt[7]_i_1_n_0 ;
  wire \rfr_cnt[7]_i_3_n_0 ;
  wire rfr_early_i_2_n_0;
  wire rfr_early_i_3_n_0;
  wire rfr_en_i_1_n_0;
  wire rfr_en_i_2_n_0;
  wire [7:0]rfr_ps_val;
  wire rfr_req;
  wire rfr_req_i_1_n_0;
  wire rmw_en_i_1_n_0;
  wire row0_same_carry__0_i_1__0_n_0;
  wire row0_same_carry__0_i_1_n_0;
  wire row0_same_carry_i_1__0_n_0;
  wire row0_same_carry_i_1_n_0;
  wire row0_same_carry_i_2__0_n_0;
  wire row0_same_carry_i_2_n_0;
  wire row0_same_carry_i_3__0_n_0;
  wire row0_same_carry_i_3_n_0;
  wire row0_same_carry_i_4__0_n_0;
  wire row0_same_carry_i_4_n_0;
  wire row1_same_carry__0_i_1__0_n_0;
  wire row1_same_carry__0_i_1_n_0;
  wire row1_same_carry_i_1__0_n_0;
  wire row1_same_carry_i_1_n_0;
  wire row1_same_carry_i_2__0_n_0;
  wire row1_same_carry_i_2_n_0;
  wire row1_same_carry_i_3__0_n_0;
  wire row1_same_carry_i_3_n_0;
  wire row1_same_carry_i_4__0_n_0;
  wire row1_same_carry_i_4_n_0;
  wire row2_same_carry__0_i_1__0_n_0;
  wire row2_same_carry__0_i_1_n_0;
  wire row2_same_carry_i_1__0_n_0;
  wire row2_same_carry_i_1_n_0;
  wire row2_same_carry_i_2__0_n_0;
  wire row2_same_carry_i_2_n_0;
  wire row2_same_carry_i_3__0_n_0;
  wire row2_same_carry_i_3_n_0;
  wire row2_same_carry_i_4__0_n_0;
  wire row2_same_carry_i_4_n_0;
  wire row3_same_carry__0_i_1__0_n_0;
  wire row3_same_carry__0_i_1_n_0;
  wire row3_same_carry_i_1__0_n_0;
  wire row3_same_carry_i_1_n_0;
  wire row3_same_carry_i_2__0_n_0;
  wire row3_same_carry_i_2_n_0;
  wire row3_same_carry_i_3__0_n_0;
  wire row3_same_carry_i_3_n_0;
  wire row3_same_carry_i_4__0_n_0;
  wire row3_same_carry_i_4_n_0;
  wire [12:0]row_adr;
  wire \row_adr[0]_i_1_n_0 ;
  wire \row_adr[10]_i_1_n_0 ;
  wire \row_adr[10]_i_2_n_0 ;
  wire \row_adr[10]_i_3_n_0 ;
  wire \row_adr[11]_i_2_n_0 ;
  wire \row_adr[11]_i_3_n_0 ;
  wire \row_adr[12]_i_2_n_0 ;
  wire \row_adr[12]_i_3_n_0 ;
  wire \row_adr[12]_i_4_n_0 ;
  wire \row_adr[12]_i_5_n_0 ;
  wire \row_adr[1]_i_1_n_0 ;
  wire \row_adr[2]_i_1_n_0 ;
  wire \row_adr[2]_i_2_n_0 ;
  wire \row_adr[3]_i_1_n_0 ;
  wire \row_adr[3]_i_2_n_0 ;
  wire \row_adr[4]_i_1_n_0 ;
  wire \row_adr[4]_i_2_n_0 ;
  wire \row_adr[5]_i_1_n_0 ;
  wire \row_adr[5]_i_2_n_0 ;
  wire \row_adr[6]_i_1_n_0 ;
  wire \row_adr[6]_i_2_n_0 ;
  wire \row_adr[7]_i_1_n_0 ;
  wire \row_adr[7]_i_2_n_0 ;
  wire \row_adr[8]_i_1_n_0 ;
  wire \row_adr[8]_i_2_n_0 ;
  wire \row_adr[9]_i_1_n_0 ;
  wire \row_adr[9]_i_2_n_0 ;
  wire \row_adr[9]_i_3_n_0 ;
  wire \row_adr_reg[11]_i_1_n_0 ;
  wire \row_adr_reg[12]_i_1_n_0 ;
  wire row_same;
  wire row_same_i_2_n_0;
  wire row_same_i_3_n_0;
  wire rst_i;
  wire rst_r1;
  wire rst_r3;
  wire [2:0]sel0;
  wire [10:1]sp_csc;
  wire \sp_csc[10]_i_1_n_0 ;
  wire \sp_csc[1]_i_1_n_0 ;
  wire \sp_csc[2]_i_1_n_0 ;
  wire \sp_csc[3]_i_1_n_0 ;
  wire \sp_csc[4]_i_1_n_0 ;
  wire \sp_csc[5]_i_1_n_0 ;
  wire \sp_csc[6]_i_1_n_0 ;
  wire \sp_csc[7]_i_1_n_0 ;
  wire \sp_csc[9]_i_1_n_0 ;
  wire [27:0]sp_tms;
  wire \sp_tms[0]_i_1_n_0 ;
  wire \sp_tms[10]_i_1_n_0 ;
  wire \sp_tms[11]_i_1_n_0 ;
  wire \sp_tms[12]_i_1_n_0 ;
  wire \sp_tms[13]_i_1_n_0 ;
  wire \sp_tms[14]_i_1_n_0 ;
  wire \sp_tms[15]_i_1_n_0 ;
  wire \sp_tms[16]_i_1_n_0 ;
  wire \sp_tms[17]_i_1_n_0 ;
  wire \sp_tms[18]_i_1_n_0 ;
  wire \sp_tms[19]_i_1_n_0 ;
  wire \sp_tms[1]_i_1_n_0 ;
  wire \sp_tms[20]_i_1_n_0 ;
  wire \sp_tms[21]_i_1_n_0 ;
  wire \sp_tms[22]_i_1_n_0 ;
  wire \sp_tms[23]_i_1_n_0 ;
  wire \sp_tms[24]_i_1_n_0 ;
  wire \sp_tms[25]_i_1_n_0 ;
  wire \sp_tms[26]_i_1_n_0 ;
  wire \sp_tms[27]_i_1_n_0 ;
  wire \sp_tms[2]_i_1_n_0 ;
  wire \sp_tms[3]_i_1_n_0 ;
  wire \sp_tms[4]_i_1_n_0 ;
  wire \sp_tms[5]_i_1_n_0 ;
  wire \sp_tms[6]_i_1_n_0 ;
  wire \sp_tms[7]_i_1_n_0 ;
  wire \sp_tms[8]_i_1_n_0 ;
  wire \sp_tms[9]_i_1_n_0 ;
  wire [1:0]spec_req_cs;
  wire [23:0]sram_addr;
  wire sreq_cs_le;
  wire susp_req_i;
  wire susp_sel;
  wire susp_sel_r_i_1_n_0;
  wire susp_sel_r_i_2_n_0;
  wire suspended_i_2_n_0;
  wire suspended_o;
  wire \timer2[0]_i_1_n_0 ;
  wire \timer2[0]_i_2_n_0 ;
  wire \timer2[0]_i_3_n_0 ;
  wire \timer2[0]_i_4_n_0 ;
  wire \timer2[1]_i_1_n_0 ;
  wire \timer2[1]_i_2_n_0 ;
  wire \timer2[1]_i_3_n_0 ;
  wire \timer2[1]_i_4_n_0 ;
  wire \timer2[1]_i_5_n_0 ;
  wire \timer2[2]_i_1_n_0 ;
  wire \timer2[2]_i_2_n_0 ;
  wire \timer2[2]_i_3_n_0 ;
  wire \timer2[2]_i_4_n_0 ;
  wire \timer2[2]_i_5_n_0 ;
  wire \timer2[3]_i_1_n_0 ;
  wire \timer2[3]_i_2_n_0 ;
  wire \timer2[3]_i_3_n_0 ;
  wire \timer2[3]_i_4_n_0 ;
  wire \timer2[3]_i_5_n_0 ;
  wire \timer2[3]_i_6_n_0 ;
  wire \timer2[3]_i_7_n_0 ;
  wire \timer2[4]_i_1_n_0 ;
  wire \timer2[4]_i_2_n_0 ;
  wire \timer2[4]_i_3_n_0 ;
  wire \timer2[4]_i_4_n_0 ;
  wire \timer2[4]_i_5_n_0 ;
  wire \timer2[4]_i_6_n_0 ;
  wire \timer2[5]_i_1_n_0 ;
  wire \timer2[5]_i_2_n_0 ;
  wire \timer2[5]_i_3_n_0 ;
  wire \timer2[5]_i_4_n_0 ;
  wire \timer2[5]_i_5_n_0 ;
  wire \timer2[5]_i_6_n_0 ;
  wire \timer2[6]_i_1_n_0 ;
  wire \timer2[6]_i_2_n_0 ;
  wire \timer2[6]_i_3_n_0 ;
  wire \timer2[6]_i_4_n_0 ;
  wire \timer2[6]_i_5_n_0 ;
  wire \timer2[6]_i_6_n_0 ;
  wire \timer2[7]_i_1_n_0 ;
  wire \timer2[7]_i_2_n_0 ;
  wire \timer2[7]_i_3_n_0 ;
  wire \timer2[7]_i_4_n_0 ;
  wire \timer2[7]_i_5_n_0 ;
  wire \timer2[7]_i_6_n_0 ;
  wire \timer2[7]_i_7_n_0 ;
  wire \timer2[7]_i_8_n_0 ;
  wire \timer2[8]_i_10_n_0 ;
  wire \timer2[8]_i_11_n_0 ;
  wire \timer2[8]_i_12_n_0 ;
  wire \timer2[8]_i_2_n_0 ;
  wire \timer2[8]_i_3_n_0 ;
  wire \timer2[8]_i_4_n_0 ;
  wire \timer2[8]_i_5_n_0 ;
  wire \timer2[8]_i_6_n_0 ;
  wire \timer2[8]_i_7_n_0 ;
  wire \timer2[8]_i_8_n_0 ;
  wire \timer2[8]_i_9_n_0 ;
  wire \timer[0]_i_1_n_0 ;
  wire \timer[0]_i_2_n_0 ;
  wire \timer[0]_i_3_n_0 ;
  wire \timer[0]_i_4_n_0 ;
  wire \timer[0]_i_5_n_0 ;
  wire \timer[0]_i_6_n_0 ;
  wire \timer[0]_i_7_n_0 ;
  wire \timer[0]_i_8_n_0 ;
  wire \timer[0]_i_9_n_0 ;
  wire \timer[1]_i_1_n_0 ;
  wire \timer[1]_i_2_n_0 ;
  wire \timer[1]_i_3_n_0 ;
  wire \timer[1]_i_4_n_0 ;
  wire \timer[1]_i_5_n_0 ;
  wire \timer[1]_i_6_n_0 ;
  wire \timer[1]_i_7_n_0 ;
  wire \timer[1]_i_8_n_0 ;
  wire \timer[1]_i_9_n_0 ;
  wire \timer[2]_i_10_n_0 ;
  wire \timer[2]_i_11_n_0 ;
  wire \timer[2]_i_12_n_0 ;
  wire \timer[2]_i_13_n_0 ;
  wire \timer[2]_i_14_n_0 ;
  wire \timer[2]_i_15_n_0 ;
  wire \timer[2]_i_16_n_0 ;
  wire \timer[2]_i_17_n_0 ;
  wire \timer[2]_i_18_n_0 ;
  wire \timer[2]_i_19_n_0 ;
  wire \timer[2]_i_1_n_0 ;
  wire \timer[2]_i_2_n_0 ;
  wire \timer[2]_i_3_n_0 ;
  wire \timer[2]_i_4_n_0 ;
  wire \timer[2]_i_5_n_0 ;
  wire \timer[2]_i_6_n_0 ;
  wire \timer[2]_i_7_n_0 ;
  wire \timer[2]_i_8_n_0 ;
  wire \timer[2]_i_9_n_0 ;
  wire \timer[3]_i_10_n_0 ;
  wire \timer[3]_i_11_n_0 ;
  wire \timer[3]_i_12_n_0 ;
  wire \timer[3]_i_13_n_0 ;
  wire \timer[3]_i_1_n_0 ;
  wire \timer[3]_i_2_n_0 ;
  wire \timer[3]_i_3_n_0 ;
  wire \timer[3]_i_4_n_0 ;
  wire \timer[3]_i_5_n_0 ;
  wire \timer[3]_i_6_n_0 ;
  wire \timer[3]_i_7_n_0 ;
  wire \timer[3]_i_8_n_0 ;
  wire \timer[3]_i_9_n_0 ;
  wire \timer[4]_i_1_n_0 ;
  wire \timer[4]_i_2_n_0 ;
  wire \timer[4]_i_3_n_0 ;
  wire \timer[5]_i_1_n_0 ;
  wire \timer[5]_i_2_n_0 ;
  wire \timer[5]_i_3_n_0 ;
  wire \timer[6]_i_1_n_0 ;
  wire \timer[6]_i_2_n_0 ;
  wire \timer[7]_i_10_n_0 ;
  wire \timer[7]_i_11_n_0 ;
  wire \timer[7]_i_12_n_0 ;
  wire \timer[7]_i_13_n_0 ;
  wire \timer[7]_i_14_n_0 ;
  wire \timer[7]_i_15_n_0 ;
  wire \timer[7]_i_16_n_0 ;
  wire \timer[7]_i_17_n_0 ;
  wire \timer[7]_i_18_n_0 ;
  wire \timer[7]_i_1_n_0 ;
  wire \timer[7]_i_2_n_0 ;
  wire \timer[7]_i_3_n_0 ;
  wire \timer[7]_i_4_n_0 ;
  wire \timer[7]_i_5_n_0 ;
  wire \timer[7]_i_6_n_0 ;
  wire \timer[7]_i_7_n_0 ;
  wire \timer[7]_i_8_n_0 ;
  wire \timer[7]_i_9_n_0 ;
  wire [31:0]tms;
  wire \tms[0]_i_1_n_0 ;
  wire \tms[10]_i_1_n_0 ;
  wire \tms[11]_i_1_n_0 ;
  wire \tms[12]_i_1_n_0 ;
  wire \tms[13]_i_1_n_0 ;
  wire \tms[14]_i_1_n_0 ;
  wire \tms[15]_i_1_n_0 ;
  wire \tms[16]_i_1_n_0 ;
  wire \tms[17]_i_1_n_0 ;
  wire \tms[18]_i_1_n_0 ;
  wire \tms[19]_i_1_n_0 ;
  wire \tms[1]_i_1_n_0 ;
  wire \tms[20]_i_1_n_0 ;
  wire \tms[21]_i_1_n_0 ;
  wire \tms[22]_i_1_n_0 ;
  wire \tms[23]_i_1_n_0 ;
  wire \tms[24]_i_1_n_0 ;
  wire \tms[25]_i_1_n_0 ;
  wire \tms[26]_i_1_n_0 ;
  wire \tms[27]_i_1_n_0 ;
  wire \tms[27]_i_2_n_0 ;
  wire \tms[2]_i_1_n_0 ;
  wire \tms[3]_i_1_n_0 ;
  wire \tms[4]_i_1_n_0 ;
  wire \tms[5]_i_1_n_0 ;
  wire \tms[6]_i_1_n_0 ;
  wire \tms[7]_i_1_n_0 ;
  wire \tms[8]_i_1_n_0 ;
  wire \tms[9]_i_1_n_0 ;
  wire \u0/cs[1]_i_1_n_0 ;
  wire [7:0]\u0/csc_mask ;
  wire \u0/csc_mask_r0 ;
  wire \u0/csc_mask_r_reg_n_0_[10] ;
  wire \u0/csc_mask_r_reg_n_0_[8] ;
  wire \u0/csc_mask_r_reg_n_0_[9] ;
  wire \u0/csr_r20 ;
  wire \u0/csr_r_reg_n_0_[0] ;
  wire \u0/csr_r_reg_n_0_[3] ;
  wire \u0/csr_r_reg_n_0_[4] ;
  wire \u0/csr_r_reg_n_0_[5] ;
  wire \u0/csr_r_reg_n_0_[6] ;
  wire \u0/csr_r_reg_n_0_[7] ;
  wire \u0/init_ack_r ;
  wire \u0/init_req01_out ;
  wire \u0/init_req_we ;
  wire \u0/inited ;
  wire \u0/lmr_ack_r ;
  wire \u0/lmr_req00_out ;
  wire \u0/lmr_req_we ;
  wire [3:0]\u0/p_0_in ;
  wire \u0/p_0_in1_in ;
  wire \u0/rf_we ;
  wire \u0/rf_we0 ;
  wire \u0/rst_r2 ;
  wire [5:5]\u0/sel0 ;
  wire \u0/spec_req_cs[0]_i_1_n_0 ;
  wire \u0/spec_req_cs[1]_i_1_n_0 ;
  wire [0:0]\u0/spec_req_cs_t ;
  wire \u0/sreq_cs_le0 ;
  wire \u0/tms0 ;
  wire \u0/tms_reg_n_0_[0] ;
  wire \u0/tms_reg_n_0_[10] ;
  wire \u0/tms_reg_n_0_[11] ;
  wire \u0/tms_reg_n_0_[12] ;
  wire \u0/tms_reg_n_0_[13] ;
  wire \u0/tms_reg_n_0_[14] ;
  wire \u0/tms_reg_n_0_[15] ;
  wire \u0/tms_reg_n_0_[16] ;
  wire \u0/tms_reg_n_0_[17] ;
  wire \u0/tms_reg_n_0_[18] ;
  wire \u0/tms_reg_n_0_[19] ;
  wire \u0/tms_reg_n_0_[1] ;
  wire \u0/tms_reg_n_0_[20] ;
  wire \u0/tms_reg_n_0_[21] ;
  wire \u0/tms_reg_n_0_[22] ;
  wire \u0/tms_reg_n_0_[23] ;
  wire \u0/tms_reg_n_0_[24] ;
  wire \u0/tms_reg_n_0_[25] ;
  wire \u0/tms_reg_n_0_[26] ;
  wire \u0/tms_reg_n_0_[27] ;
  wire \u0/tms_reg_n_0_[2] ;
  wire \u0/tms_reg_n_0_[3] ;
  wire \u0/tms_reg_n_0_[4] ;
  wire \u0/tms_reg_n_0_[5] ;
  wire \u0/tms_reg_n_0_[6] ;
  wire \u0/tms_reg_n_0_[7] ;
  wire \u0/tms_reg_n_0_[8] ;
  wire \u0/tms_reg_n_0_[9] ;
  wire \u0/u0/csc_reg_n_0_[0] ;
  wire \u0/u0/csc_reg_n_0_[10] ;
  wire \u0/u0/csc_reg_n_0_[11] ;
  wire \u0/u0/csc_reg_n_0_[12] ;
  wire \u0/u0/csc_reg_n_0_[13] ;
  wire \u0/u0/csc_reg_n_0_[14] ;
  wire \u0/u0/csc_reg_n_0_[15] ;
  wire \u0/u0/csc_reg_n_0_[16] ;
  wire \u0/u0/csc_reg_n_0_[17] ;
  wire \u0/u0/csc_reg_n_0_[18] ;
  wire \u0/u0/csc_reg_n_0_[19] ;
  wire \u0/u0/csc_reg_n_0_[1] ;
  wire \u0/u0/csc_reg_n_0_[20] ;
  wire \u0/u0/csc_reg_n_0_[21] ;
  wire \u0/u0/csc_reg_n_0_[22] ;
  wire \u0/u0/csc_reg_n_0_[23] ;
  wire \u0/u0/csc_reg_n_0_[24] ;
  wire \u0/u0/csc_reg_n_0_[25] ;
  wire \u0/u0/csc_reg_n_0_[26] ;
  wire \u0/u0/csc_reg_n_0_[27] ;
  wire \u0/u0/csc_reg_n_0_[28] ;
  wire \u0/u0/csc_reg_n_0_[29] ;
  wire \u0/u0/csc_reg_n_0_[2] ;
  wire \u0/u0/csc_reg_n_0_[30] ;
  wire \u0/u0/csc_reg_n_0_[31] ;
  wire \u0/u0/csc_reg_n_0_[3] ;
  wire \u0/u0/csc_reg_n_0_[4] ;
  wire \u0/u0/csc_reg_n_0_[5] ;
  wire \u0/u0/csc_reg_n_0_[6] ;
  wire \u0/u0/csc_reg_n_0_[7] ;
  wire \u0/u0/csc_reg_n_0_[8] ;
  wire \u0/u0/csc_reg_n_0_[9] ;
  wire \u0/u0/init_req_reg_n_0 ;
  wire \u0/u0/lmr_req_reg_n_0 ;
  wire \u0/u1/csc_reg_n_0_[0] ;
  wire \u0/u1/csc_reg_n_0_[10] ;
  wire \u0/u1/csc_reg_n_0_[11] ;
  wire \u0/u1/csc_reg_n_0_[12] ;
  wire \u0/u1/csc_reg_n_0_[13] ;
  wire \u0/u1/csc_reg_n_0_[14] ;
  wire \u0/u1/csc_reg_n_0_[15] ;
  wire \u0/u1/csc_reg_n_0_[16] ;
  wire \u0/u1/csc_reg_n_0_[17] ;
  wire \u0/u1/csc_reg_n_0_[18] ;
  wire \u0/u1/csc_reg_n_0_[19] ;
  wire \u0/u1/csc_reg_n_0_[1] ;
  wire \u0/u1/csc_reg_n_0_[20] ;
  wire \u0/u1/csc_reg_n_0_[21] ;
  wire \u0/u1/csc_reg_n_0_[22] ;
  wire \u0/u1/csc_reg_n_0_[23] ;
  wire \u0/u1/csc_reg_n_0_[24] ;
  wire \u0/u1/csc_reg_n_0_[25] ;
  wire \u0/u1/csc_reg_n_0_[26] ;
  wire \u0/u1/csc_reg_n_0_[27] ;
  wire \u0/u1/csc_reg_n_0_[28] ;
  wire \u0/u1/csc_reg_n_0_[29] ;
  wire \u0/u1/csc_reg_n_0_[2] ;
  wire \u0/u1/csc_reg_n_0_[30] ;
  wire \u0/u1/csc_reg_n_0_[31] ;
  wire \u0/u1/csc_reg_n_0_[3] ;
  wire \u0/u1/csc_reg_n_0_[4] ;
  wire \u0/u1/csc_reg_n_0_[5] ;
  wire \u0/u1/csc_reg_n_0_[6] ;
  wire \u0/u1/csc_reg_n_0_[7] ;
  wire \u0/u1/csc_reg_n_0_[8] ;
  wire \u0/u1/csc_reg_n_0_[9] ;
  wire \u0/u1/init_req_reg_n_0 ;
  wire \u0/u1/init_req_we_reg_n_0 ;
  wire \u0/u1/inited_reg_n_0 ;
  wire \u0/u1/lmr_req_reg_n_0 ;
  wire \u0/u1/lmr_req_we_reg_n_0 ;
  wire \u0/u1/tms_reg_n_0_[0] ;
  wire \u0/u1/tms_reg_n_0_[10] ;
  wire \u0/u1/tms_reg_n_0_[11] ;
  wire \u0/u1/tms_reg_n_0_[12] ;
  wire \u0/u1/tms_reg_n_0_[13] ;
  wire \u0/u1/tms_reg_n_0_[14] ;
  wire \u0/u1/tms_reg_n_0_[15] ;
  wire \u0/u1/tms_reg_n_0_[16] ;
  wire \u0/u1/tms_reg_n_0_[17] ;
  wire \u0/u1/tms_reg_n_0_[18] ;
  wire \u0/u1/tms_reg_n_0_[19] ;
  wire \u0/u1/tms_reg_n_0_[1] ;
  wire \u0/u1/tms_reg_n_0_[20] ;
  wire \u0/u1/tms_reg_n_0_[21] ;
  wire \u0/u1/tms_reg_n_0_[22] ;
  wire \u0/u1/tms_reg_n_0_[23] ;
  wire \u0/u1/tms_reg_n_0_[24] ;
  wire \u0/u1/tms_reg_n_0_[25] ;
  wire \u0/u1/tms_reg_n_0_[26] ;
  wire \u0/u1/tms_reg_n_0_[27] ;
  wire \u0/u1/tms_reg_n_0_[28] ;
  wire \u0/u1/tms_reg_n_0_[29] ;
  wire \u0/u1/tms_reg_n_0_[2] ;
  wire \u0/u1/tms_reg_n_0_[30] ;
  wire \u0/u1/tms_reg_n_0_[31] ;
  wire \u0/u1/tms_reg_n_0_[3] ;
  wire \u0/u1/tms_reg_n_0_[4] ;
  wire \u0/u1/tms_reg_n_0_[5] ;
  wire \u0/u1/tms_reg_n_0_[6] ;
  wire \u0/u1/tms_reg_n_0_[7] ;
  wire \u0/u1/tms_reg_n_0_[8] ;
  wire \u0/u1/tms_reg_n_0_[9] ;
  wire [9:8]\u1/col_adr ;
  wire \u1/u0/out_r0_carry__0_n_0 ;
  wire \u1/u0/out_r0_carry__0_n_1 ;
  wire \u1/u0/out_r0_carry__0_n_2 ;
  wire \u1/u0/out_r0_carry__0_n_3 ;
  wire \u1/u0/out_r0_carry__0_n_4 ;
  wire \u1/u0/out_r0_carry__0_n_5 ;
  wire \u1/u0/out_r0_carry__0_n_6 ;
  wire \u1/u0/out_r0_carry__0_n_7 ;
  wire \u1/u0/out_r0_carry__1_n_0 ;
  wire \u1/u0/out_r0_carry__1_n_2 ;
  wire \u1/u0/out_r0_carry__1_n_3 ;
  wire \u1/u0/out_r0_carry__1_n_5 ;
  wire \u1/u0/out_r0_carry__1_n_6 ;
  wire \u1/u0/out_r0_carry__1_n_7 ;
  wire \u1/u0/out_r0_carry_n_0 ;
  wire \u1/u0/out_r0_carry_n_1 ;
  wire \u1/u0/out_r0_carry_n_2 ;
  wire \u1/u0/out_r0_carry_n_3 ;
  wire \u1/u0/out_r0_carry_n_4 ;
  wire \u1/u0/out_r0_carry_n_5 ;
  wire \u1/u0/out_r0_carry_n_6 ;
  wire \u1/u0/out_r0_carry_n_7 ;
  wire \u1/u0/out_r_reg_n_0_[0] ;
  wire \u1/u0/out_r_reg_n_0_[10] ;
  wire \u1/u0/out_r_reg_n_0_[11] ;
  wire \u1/u0/out_r_reg_n_0_[1] ;
  wire \u1/u0/out_r_reg_n_0_[2] ;
  wire \u1/u0/out_r_reg_n_0_[3] ;
  wire \u1/u0/out_r_reg_n_0_[4] ;
  wire \u1/u0/out_r_reg_n_0_[5] ;
  wire \u1/u0/out_r_reg_n_0_[6] ;
  wire \u1/u0/out_r_reg_n_0_[7] ;
  wire \u1/u0/out_r_reg_n_0_[8] ;
  wire \u1/u0/out_r_reg_n_0_[9] ;
  wire \u2/bank0_open ;
  wire \u2/bank0_open0 ;
  wire \u2/bank1_open ;
  wire \u2/bank1_open0 ;
  wire \u2/bank2_open ;
  wire \u2/bank2_open0 ;
  wire \u2/bank3_open ;
  wire \u2/bank3_open0 ;
  wire \u2/bank_open0 ;
  wire \u2/row0_same ;
  wire \u2/row1_same ;
  wire \u2/row2_same ;
  wire \u2/row3_same ;
  wire \u2/row_same0 ;
  wire \u2/u0/b0_last_row_reg_n_0_[0] ;
  wire \u2/u0/b0_last_row_reg_n_0_[10] ;
  wire \u2/u0/b0_last_row_reg_n_0_[11] ;
  wire \u2/u0/b0_last_row_reg_n_0_[12] ;
  wire \u2/u0/b0_last_row_reg_n_0_[1] ;
  wire \u2/u0/b0_last_row_reg_n_0_[2] ;
  wire \u2/u0/b0_last_row_reg_n_0_[3] ;
  wire \u2/u0/b0_last_row_reg_n_0_[4] ;
  wire \u2/u0/b0_last_row_reg_n_0_[5] ;
  wire \u2/u0/b0_last_row_reg_n_0_[6] ;
  wire \u2/u0/b0_last_row_reg_n_0_[7] ;
  wire \u2/u0/b0_last_row_reg_n_0_[8] ;
  wire \u2/u0/b0_last_row_reg_n_0_[9] ;
  wire \u2/u0/b1_last_row_reg_n_0_[0] ;
  wire \u2/u0/b1_last_row_reg_n_0_[10] ;
  wire \u2/u0/b1_last_row_reg_n_0_[11] ;
  wire \u2/u0/b1_last_row_reg_n_0_[12] ;
  wire \u2/u0/b1_last_row_reg_n_0_[1] ;
  wire \u2/u0/b1_last_row_reg_n_0_[2] ;
  wire \u2/u0/b1_last_row_reg_n_0_[3] ;
  wire \u2/u0/b1_last_row_reg_n_0_[4] ;
  wire \u2/u0/b1_last_row_reg_n_0_[5] ;
  wire \u2/u0/b1_last_row_reg_n_0_[6] ;
  wire \u2/u0/b1_last_row_reg_n_0_[7] ;
  wire \u2/u0/b1_last_row_reg_n_0_[8] ;
  wire \u2/u0/b1_last_row_reg_n_0_[9] ;
  wire \u2/u0/b2_last_row_reg_n_0_[0] ;
  wire \u2/u0/b2_last_row_reg_n_0_[10] ;
  wire \u2/u0/b2_last_row_reg_n_0_[11] ;
  wire \u2/u0/b2_last_row_reg_n_0_[12] ;
  wire \u2/u0/b2_last_row_reg_n_0_[1] ;
  wire \u2/u0/b2_last_row_reg_n_0_[2] ;
  wire \u2/u0/b2_last_row_reg_n_0_[3] ;
  wire \u2/u0/b2_last_row_reg_n_0_[4] ;
  wire \u2/u0/b2_last_row_reg_n_0_[5] ;
  wire \u2/u0/b2_last_row_reg_n_0_[6] ;
  wire \u2/u0/b2_last_row_reg_n_0_[7] ;
  wire \u2/u0/b2_last_row_reg_n_0_[8] ;
  wire \u2/u0/b2_last_row_reg_n_0_[9] ;
  wire \u2/u0/b3_last_row_reg_n_0_[0] ;
  wire \u2/u0/b3_last_row_reg_n_0_[10] ;
  wire \u2/u0/b3_last_row_reg_n_0_[11] ;
  wire \u2/u0/b3_last_row_reg_n_0_[12] ;
  wire \u2/u0/b3_last_row_reg_n_0_[1] ;
  wire \u2/u0/b3_last_row_reg_n_0_[2] ;
  wire \u2/u0/b3_last_row_reg_n_0_[3] ;
  wire \u2/u0/b3_last_row_reg_n_0_[4] ;
  wire \u2/u0/b3_last_row_reg_n_0_[5] ;
  wire \u2/u0/b3_last_row_reg_n_0_[6] ;
  wire \u2/u0/b3_last_row_reg_n_0_[7] ;
  wire \u2/u0/b3_last_row_reg_n_0_[8] ;
  wire \u2/u0/b3_last_row_reg_n_0_[9] ;
  wire \u2/u0/row0_same_carry_n_0 ;
  wire \u2/u0/row0_same_carry_n_1 ;
  wire \u2/u0/row0_same_carry_n_2 ;
  wire \u2/u0/row0_same_carry_n_3 ;
  wire \u2/u0/row1_same_carry_n_0 ;
  wire \u2/u0/row1_same_carry_n_1 ;
  wire \u2/u0/row1_same_carry_n_2 ;
  wire \u2/u0/row1_same_carry_n_3 ;
  wire \u2/u0/row2_same_carry_n_0 ;
  wire \u2/u0/row2_same_carry_n_1 ;
  wire \u2/u0/row2_same_carry_n_2 ;
  wire \u2/u0/row2_same_carry_n_3 ;
  wire \u2/u0/row3_same_carry_n_0 ;
  wire \u2/u0/row3_same_carry_n_1 ;
  wire \u2/u0/row3_same_carry_n_2 ;
  wire \u2/u0/row3_same_carry_n_3 ;
  wire \u2/u1/bank0_open_reg_n_0 ;
  wire \u2/u1/bank1_open_reg_n_0 ;
  wire \u2/u1/bank2_open_reg_n_0 ;
  wire \u2/u1/bank3_open_reg_n_0 ;
  wire \u2/u1/row0_same_carry__0_n_3 ;
  wire \u2/u1/row0_same_carry_n_0 ;
  wire \u2/u1/row0_same_carry_n_1 ;
  wire \u2/u1/row0_same_carry_n_2 ;
  wire \u2/u1/row0_same_carry_n_3 ;
  wire \u2/u1/row1_same_carry__0_n_3 ;
  wire \u2/u1/row1_same_carry_n_0 ;
  wire \u2/u1/row1_same_carry_n_1 ;
  wire \u2/u1/row1_same_carry_n_2 ;
  wire \u2/u1/row1_same_carry_n_3 ;
  wire \u2/u1/row2_same_carry__0_n_3 ;
  wire \u2/u1/row2_same_carry_n_0 ;
  wire \u2/u1/row2_same_carry_n_1 ;
  wire \u2/u1/row2_same_carry_n_2 ;
  wire \u2/u1/row2_same_carry_n_3 ;
  wire \u2/u1/row3_same_carry__0_n_3 ;
  wire \u2/u1/row3_same_carry_n_0 ;
  wire \u2/u1/row3_same_carry_n_1 ;
  wire \u2/u1/row3_same_carry_n_2 ;
  wire \u2/u1/row3_same_carry_n_3 ;
  wire \u3/mc_data_o0 ;
  wire \u3/u0/p_0_in ;
  wire \u3/u0/p_0_in0_in ;
  wire \u3/u0/p_0_in1_in ;
  wire \u3/u0/r00 ;
  wire \u3/u0/r10 ;
  wire \u3/u0/r20 ;
  wire \u3/u0/r30 ;
  wire [3:0]\u3/u0/rd_adr ;
  wire \u3/u0/wr_adr_reg_n_0_[0] ;
  wire \u4/ps_cnt_clr ;
  wire \u4/ps_cnt_clr01_in ;
  wire [7:0]\u4/ps_cnt_reg ;
  wire \u4/rfr_ce ;
  wire \u4/rfr_clr ;
  wire \u4/rfr_clr_reg_n_0 ;
  wire [0:0]\u4/rfr_cnt_reg ;
  wire [7:1]\u4/rfr_cnt_reg__0 ;
  wire \u4/rfr_early ;
  wire \u4/rfr_en ;
  wire [3:0]\u5/ack_cnt_reg ;
  wire \u5/ap_en ;
  wire \u5/burst_act077_in ;
  wire \u5/burst_act_rd ;
  wire \u5/burst_cnt_ld ;
  wire \u5/burst_cnt_ld_4 ;
  wire [10:0]\u5/burst_cnt_reg ;
  wire \u5/cke_0 ;
  wire \u5/cke_o_del ;
  wire \u5/cke_o_r2_reg_srl2_n_0 ;
  wire \u5/cke_r ;
  wire [2:0]\u5/cmd ;
  wire \u5/cmd_a10_r ;
  wire \u5/cmd_asserted ;
  wire \u5/cmd_asserted2 ;
  wire [3:0]\u5/cmd_del ;
  wire [3:0]\u5/cmd_r ;
  wire \u5/cnt ;
  wire \u5/cnt_next ;
  wire \u5/cs_le_r ;
  wire \u5/cs_le_r1 ;
  wire \u5/data_oe_r ;
  wire \u5/data_oe_r2 ;
  wire \u5/dv_r ;
  wire \u5/ir_cnt_dec ;
  wire \u5/ir_cnt_done ;
  wire \u5/ir_cnt_ld ;
  wire [3:0]\u5/ir_cnt_reg ;
  wire \u5/lmr_ack_d ;
  wire \u5/lookup_ready1 ;
  wire \u5/lookup_ready10 ;
  wire \u5/lookup_ready2 ;
  wire \u5/lookup_ready20 ;
  wire \u5/mc_adv_r ;
  wire \u5/mc_adv_r1 ;
  wire \u5/mc_c_oe_d ;
  wire \u5/mc_le ;
  wire \u5/mem_ack_r ;
  wire \u5/no_wb_cycle ;
  wire \u5/p_65_in ;
  wire \u5/pack_le0_d ;
  wire \u5/pack_le1_d ;
  wire \u5/pack_le2_d ;
  wire \u5/resume_req_r ;
  wire \u5/rsts ;
  wire \u5/rsts1 ;
  wire [6:0]\u5/state ;
  wire \u5/susp_req_r ;
  wire \u5/suspended_d ;
  wire [7:0]\u5/timer ;
  wire [8:0]\u5/timer2 ;
  wire \u5/timer20 ;
  wire \u5/timer_is_zero ;
  wire \u5/tmr2_done ;
  wire \u5/tmr2_done0 ;
  wire \u5/tmr_done ;
  wire \u5/wb_cycle_set ;
  wire \u5/wb_stb_first_reg_n_0 ;
  wire \u5/wb_wait_r ;
  wire \u5/wb_wait_r2 ;
  wire \u5/wb_write_go_r ;
  wire \u5/wr_set ;
  wire \u6/read_go_r ;
  wire \u6/read_go_r0 ;
  wire \u6/read_go_r1 ;
  wire \u6/read_go_r10 ;
  wire \u6/rmw_en ;
  wire \u6/rmw_r ;
  wire \u6/rmw_r0 ;
  wire \u6/wb_err0 ;
  wire \u6/wb_first_r ;
  wire \u6/wb_first_set ;
  wire \u6/wr_hold0 ;
  wire \u6/write_go_r ;
  wire \u6/write_go_r0 ;
  wire \u6/write_go_r1 ;
  wire \u6/write_go_r10 ;
  wire \u7/mc_data_oe0 ;
  wire \u7/mc_oe_0 ;
  wire \u7/mc_rp0 ;
  wire wb_ack_o;
  wire wb_ack_o_i_10_n_0;
  wire wb_ack_o_i_11_n_0;
  wire wb_ack_o_i_12_n_0;
  wire wb_ack_o_i_13_n_0;
  wire wb_ack_o_i_14_n_0;
  wire wb_ack_o_i_15_n_0;
  wire wb_ack_o_i_16_n_0;
  wire wb_ack_o_i_17_n_0;
  wire wb_ack_o_i_18_n_0;
  wire wb_ack_o_i_19_n_0;
  wire wb_ack_o_i_1_n_0;
  wire wb_ack_o_i_20_n_0;
  wire wb_ack_o_i_21_n_0;
  wire wb_ack_o_i_22_n_0;
  wire wb_ack_o_i_23_n_0;
  wire wb_ack_o_i_2_n_0;
  wire wb_ack_o_i_3_n_0;
  wire wb_ack_o_i_4_n_0;
  wire wb_ack_o_i_5_n_0;
  wire wb_ack_o_i_6_n_0;
  wire wb_ack_o_i_7_n_0;
  wire wb_ack_o_i_8_n_0;
  wire wb_ack_o_i_9_n_0;
  wire [31:0]wb_addr_i;
  wire wb_cyc_i;
  wire wb_cycle;
  wire wb_cycle_i_1_n_0;
  wire [31:0]wb_data_i;
  wire [31:0]wb_data_o;
  wire \wb_data_o[0]_i_1_n_0 ;
  wire \wb_data_o[0]_i_2_n_0 ;
  wire \wb_data_o[0]_i_3_n_0 ;
  wire \wb_data_o[0]_i_4_n_0 ;
  wire \wb_data_o[0]_i_5_n_0 ;
  wire \wb_data_o[0]_i_6_n_0 ;
  wire \wb_data_o[10]_i_1_n_0 ;
  wire \wb_data_o[10]_i_2_n_0 ;
  wire \wb_data_o[10]_i_3_n_0 ;
  wire \wb_data_o[10]_i_4_n_0 ;
  wire \wb_data_o[10]_i_5_n_0 ;
  wire \wb_data_o[10]_i_6_n_0 ;
  wire \wb_data_o[10]_i_7_n_0 ;
  wire \wb_data_o[10]_i_8_n_0 ;
  wire \wb_data_o[11]_i_1_n_0 ;
  wire \wb_data_o[11]_i_2_n_0 ;
  wire \wb_data_o[11]_i_3_n_0 ;
  wire \wb_data_o[11]_i_4_n_0 ;
  wire \wb_data_o[11]_i_5_n_0 ;
  wire \wb_data_o[12]_i_1_n_0 ;
  wire \wb_data_o[12]_i_2_n_0 ;
  wire \wb_data_o[12]_i_3_n_0 ;
  wire \wb_data_o[12]_i_4_n_0 ;
  wire \wb_data_o[12]_i_5_n_0 ;
  wire \wb_data_o[13]_i_1_n_0 ;
  wire \wb_data_o[13]_i_2_n_0 ;
  wire \wb_data_o[13]_i_3_n_0 ;
  wire \wb_data_o[13]_i_4_n_0 ;
  wire \wb_data_o[13]_i_5_n_0 ;
  wire \wb_data_o[14]_i_1_n_0 ;
  wire \wb_data_o[14]_i_2_n_0 ;
  wire \wb_data_o[14]_i_3_n_0 ;
  wire \wb_data_o[14]_i_4_n_0 ;
  wire \wb_data_o[14]_i_5_n_0 ;
  wire \wb_data_o[15]_i_1_n_0 ;
  wire \wb_data_o[15]_i_2_n_0 ;
  wire \wb_data_o[15]_i_3_n_0 ;
  wire \wb_data_o[15]_i_4_n_0 ;
  wire \wb_data_o[15]_i_5_n_0 ;
  wire \wb_data_o[15]_i_6_n_0 ;
  wire \wb_data_o[16]_i_1_n_0 ;
  wire \wb_data_o[16]_i_2_n_0 ;
  wire \wb_data_o[16]_i_3_n_0 ;
  wire \wb_data_o[16]_i_4_n_0 ;
  wire \wb_data_o[16]_i_5_n_0 ;
  wire \wb_data_o[16]_i_6_n_0 ;
  wire \wb_data_o[17]_i_1_n_0 ;
  wire \wb_data_o[17]_i_2_n_0 ;
  wire \wb_data_o[17]_i_3_n_0 ;
  wire \wb_data_o[17]_i_4_n_0 ;
  wire \wb_data_o[17]_i_5_n_0 ;
  wire \wb_data_o[17]_i_6_n_0 ;
  wire \wb_data_o[18]_i_1_n_0 ;
  wire \wb_data_o[18]_i_2_n_0 ;
  wire \wb_data_o[18]_i_3_n_0 ;
  wire \wb_data_o[18]_i_4_n_0 ;
  wire \wb_data_o[18]_i_5_n_0 ;
  wire \wb_data_o[18]_i_6_n_0 ;
  wire \wb_data_o[19]_i_1_n_0 ;
  wire \wb_data_o[19]_i_2_n_0 ;
  wire \wb_data_o[19]_i_3_n_0 ;
  wire \wb_data_o[19]_i_4_n_0 ;
  wire \wb_data_o[19]_i_5_n_0 ;
  wire \wb_data_o[19]_i_6_n_0 ;
  wire \wb_data_o[1]_i_1_n_0 ;
  wire \wb_data_o[1]_i_2_n_0 ;
  wire \wb_data_o[1]_i_3_n_0 ;
  wire \wb_data_o[1]_i_4_n_0 ;
  wire \wb_data_o[1]_i_5_n_0 ;
  wire \wb_data_o[1]_i_6_n_0 ;
  wire \wb_data_o[20]_i_1_n_0 ;
  wire \wb_data_o[20]_i_2_n_0 ;
  wire \wb_data_o[20]_i_3_n_0 ;
  wire \wb_data_o[20]_i_4_n_0 ;
  wire \wb_data_o[20]_i_5_n_0 ;
  wire \wb_data_o[20]_i_6_n_0 ;
  wire \wb_data_o[21]_i_1_n_0 ;
  wire \wb_data_o[21]_i_2_n_0 ;
  wire \wb_data_o[21]_i_3_n_0 ;
  wire \wb_data_o[21]_i_4_n_0 ;
  wire \wb_data_o[21]_i_5_n_0 ;
  wire \wb_data_o[21]_i_6_n_0 ;
  wire \wb_data_o[22]_i_1_n_0 ;
  wire \wb_data_o[22]_i_2_n_0 ;
  wire \wb_data_o[22]_i_3_n_0 ;
  wire \wb_data_o[22]_i_4_n_0 ;
  wire \wb_data_o[22]_i_5_n_0 ;
  wire \wb_data_o[22]_i_6_n_0 ;
  wire \wb_data_o[23]_i_1_n_0 ;
  wire \wb_data_o[23]_i_2_n_0 ;
  wire \wb_data_o[23]_i_3_n_0 ;
  wire \wb_data_o[23]_i_4_n_0 ;
  wire \wb_data_o[23]_i_5_n_0 ;
  wire \wb_data_o[23]_i_6_n_0 ;
  wire \wb_data_o[24]_i_1_n_0 ;
  wire \wb_data_o[24]_i_2_n_0 ;
  wire \wb_data_o[24]_i_3_n_0 ;
  wire \wb_data_o[24]_i_4_n_0 ;
  wire \wb_data_o[24]_i_5_n_0 ;
  wire \wb_data_o[24]_i_6_n_0 ;
  wire \wb_data_o[25]_i_1_n_0 ;
  wire \wb_data_o[25]_i_2_n_0 ;
  wire \wb_data_o[25]_i_3_n_0 ;
  wire \wb_data_o[25]_i_4_n_0 ;
  wire \wb_data_o[25]_i_5_n_0 ;
  wire \wb_data_o[25]_i_6_n_0 ;
  wire \wb_data_o[26]_i_1_n_0 ;
  wire \wb_data_o[26]_i_2_n_0 ;
  wire \wb_data_o[26]_i_3_n_0 ;
  wire \wb_data_o[26]_i_4_n_0 ;
  wire \wb_data_o[26]_i_5_n_0 ;
  wire \wb_data_o[26]_i_6_n_0 ;
  wire \wb_data_o[27]_i_1_n_0 ;
  wire \wb_data_o[27]_i_2_n_0 ;
  wire \wb_data_o[27]_i_3_n_0 ;
  wire \wb_data_o[27]_i_4_n_0 ;
  wire \wb_data_o[27]_i_5_n_0 ;
  wire \wb_data_o[27]_i_6_n_0 ;
  wire \wb_data_o[28]_i_1_n_0 ;
  wire \wb_data_o[28]_i_2_n_0 ;
  wire \wb_data_o[28]_i_3_n_0 ;
  wire \wb_data_o[28]_i_4_n_0 ;
  wire \wb_data_o[28]_i_5_n_0 ;
  wire \wb_data_o[28]_i_6_n_0 ;
  wire \wb_data_o[29]_i_1_n_0 ;
  wire \wb_data_o[29]_i_2_n_0 ;
  wire \wb_data_o[29]_i_3_n_0 ;
  wire \wb_data_o[29]_i_4_n_0 ;
  wire \wb_data_o[29]_i_5_n_0 ;
  wire \wb_data_o[29]_i_6_n_0 ;
  wire \wb_data_o[2]_i_1_n_0 ;
  wire \wb_data_o[2]_i_2_n_0 ;
  wire \wb_data_o[2]_i_3_n_0 ;
  wire \wb_data_o[2]_i_4_n_0 ;
  wire \wb_data_o[2]_i_5_n_0 ;
  wire \wb_data_o[2]_i_6_n_0 ;
  wire \wb_data_o[30]_i_1_n_0 ;
  wire \wb_data_o[30]_i_2_n_0 ;
  wire \wb_data_o[30]_i_3_n_0 ;
  wire \wb_data_o[30]_i_4_n_0 ;
  wire \wb_data_o[30]_i_5_n_0 ;
  wire \wb_data_o[30]_i_6_n_0 ;
  wire \wb_data_o[31]_i_1_n_0 ;
  wire \wb_data_o[31]_i_2_n_0 ;
  wire \wb_data_o[31]_i_3_n_0 ;
  wire \wb_data_o[31]_i_4_n_0 ;
  wire \wb_data_o[31]_i_5_n_0 ;
  wire \wb_data_o[31]_i_6_n_0 ;
  wire \wb_data_o[31]_i_7_n_0 ;
  wire \wb_data_o[31]_i_8_n_0 ;
  wire \wb_data_o[31]_i_9_n_0 ;
  wire \wb_data_o[3]_i_1_n_0 ;
  wire \wb_data_o[3]_i_2_n_0 ;
  wire \wb_data_o[3]_i_3_n_0 ;
  wire \wb_data_o[3]_i_4_n_0 ;
  wire \wb_data_o[3]_i_5_n_0 ;
  wire \wb_data_o[3]_i_6_n_0 ;
  wire \wb_data_o[4]_i_1_n_0 ;
  wire \wb_data_o[4]_i_2_n_0 ;
  wire \wb_data_o[4]_i_3_n_0 ;
  wire \wb_data_o[4]_i_4_n_0 ;
  wire \wb_data_o[4]_i_5_n_0 ;
  wire \wb_data_o[4]_i_6_n_0 ;
  wire \wb_data_o[5]_i_1_n_0 ;
  wire \wb_data_o[5]_i_2_n_0 ;
  wire \wb_data_o[5]_i_3_n_0 ;
  wire \wb_data_o[5]_i_4_n_0 ;
  wire \wb_data_o[5]_i_5_n_0 ;
  wire \wb_data_o[5]_i_6_n_0 ;
  wire \wb_data_o[6]_i_1_n_0 ;
  wire \wb_data_o[6]_i_2_n_0 ;
  wire \wb_data_o[6]_i_3_n_0 ;
  wire \wb_data_o[6]_i_4_n_0 ;
  wire \wb_data_o[6]_i_5_n_0 ;
  wire \wb_data_o[6]_i_6_n_0 ;
  wire \wb_data_o[7]_i_1_n_0 ;
  wire \wb_data_o[7]_i_2_n_0 ;
  wire \wb_data_o[7]_i_3_n_0 ;
  wire \wb_data_o[7]_i_4_n_0 ;
  wire \wb_data_o[7]_i_5_n_0 ;
  wire \wb_data_o[7]_i_6_n_0 ;
  wire \wb_data_o[8]_i_1_n_0 ;
  wire \wb_data_o[8]_i_2_n_0 ;
  wire \wb_data_o[8]_i_3_n_0 ;
  wire \wb_data_o[8]_i_4_n_0 ;
  wire \wb_data_o[8]_i_5_n_0 ;
  wire \wb_data_o[8]_i_6_n_0 ;
  wire \wb_data_o[9]_i_1_n_0 ;
  wire \wb_data_o[9]_i_2_n_0 ;
  wire \wb_data_o[9]_i_3_n_0 ;
  wire \wb_data_o[9]_i_4_n_0 ;
  wire \wb_data_o[9]_i_5_n_0 ;
  wire \wb_data_o[9]_i_6_n_0 ;
  wire wb_err_o;
  wire wb_first_r_i_1_n_0;
  wire [3:0]wb_sel_i;
  wire wb_stb_first_i_1_n_0;
  wire wb_stb_first_i_2_n_0;
  wire wb_stb_i;
  wire wb_wait;
  wire wb_we_i;
  wire wb_write_go;
  wire wb_write_go_r_i_2_n_0;
  wire we_;
  wire wp_err;
  wire wp_err_i_1_n_0;
  wire wp_err_i_2_n_0;
  wire \wr_adr[0]_i_1_n_0 ;
  wire \wr_adr[1]_i_1_n_0 ;
  wire \wr_adr[2]_i_1_n_0 ;
  wire \wr_adr[3]_i_1_n_0 ;
  wire \wr_adr[3]_i_2_n_0 ;
  wire wr_cycle;
  wire wr_cycle_i_1_n_0;
  wire wr_cycle_i_3_n_0;
  wire wr_cycle_i_4_n_0;
  wire wr_hold;
  wire wr_hold_i_1_n_0;
  wire [3:0]\NLW_u1/u0/out_r0_carry__1_CO_UNCONNECTED ;

  assign mc_cs_pad_o_[7] = \<const1> ;
  assign mc_cs_pad_o_[6] = \<const1> ;
  assign mc_cs_pad_o_[5] = \<const1> ;
  assign mc_cs_pad_o_[4] = \<const1> ;
  assign mc_cs_pad_o_[3] = \<const1> ;
  assign mc_cs_pad_o_[2] = \<const1> ;
  assign mc_cs_pad_o_[1:0] = \^mc_cs_pad_o_ [1:0];
  LUT6 #(
    .INIT(64'h00000000FFFFFFF4)) 
    \FSM_sequential_state[0]_i_1 
       (.I0(\FSM_sequential_state[0]_i_2_n_0 ),
        .I1(\FSM_sequential_state[0]_i_3_n_0 ),
        .I2(\FSM_sequential_state[0]_i_4_n_0 ),
        .I3(\FSM_sequential_state[0]_i_5_n_0 ),
        .I4(\FSM_sequential_state[0]_i_6_n_0 ),
        .I5(\FSM_sequential_state[0]_i_7_n_0 ),
        .O(\FSM_sequential_state[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000F000D000F)) 
    \FSM_sequential_state[0]_i_10 
       (.I0(\FSM_sequential_state[0]_i_14_n_0 ),
        .I1(\FSM_sequential_state[5]_i_9_n_0 ),
        .I2(\u5/state [3]),
        .I3(\u5/state [1]),
        .I4(\FSM_sequential_state[0]_i_15_n_0 ),
        .I5(\FSM_sequential_state[0]_i_16_n_0 ),
        .O(\FSM_sequential_state[0]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000008088)) 
    \FSM_sequential_state[0]_i_11 
       (.I0(ap_en_i_2_n_0),
        .I1(bank_open),
        .I2(wb_cycle),
        .I3(\u5/susp_req_r ),
        .I4(\FSM_sequential_state[0]_i_17_n_0 ),
        .I5(\mc_addr[23]_i_3_n_0 ),
        .O(\FSM_sequential_state[0]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h0FFFFFFF0FFDFFFF)) 
    \FSM_sequential_state[0]_i_12 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(\FSM_sequential_state[0]_i_16_n_0 ),
        .I2(wb_write_go),
        .I3(\u5/state [1]),
        .I4(\FSM_sequential_state[0]_i_18_n_0 ),
        .I5(\mc_addr[14]_i_4_n_0 ),
        .O(\FSM_sequential_state[0]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT4 #(
    .INIT(16'h0C44)) 
    \FSM_sequential_state[0]_i_13 
       (.I0(cke__i_5_n_0),
        .I1(\u5/state [4]),
        .I2(wb_write_go),
        .I3(wb_cycle),
        .O(\FSM_sequential_state[0]_i_13_n_0 ));
  LUT5 #(
    .INIT(32'hAAAABFFF)) 
    \FSM_sequential_state[0]_i_14 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(row_same),
        .I2(ap_en_i_2_n_0),
        .I3(bank_open),
        .I4(\mc_addr[14]_i_4_n_0 ),
        .O(\FSM_sequential_state[0]_i_14_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT4 #(
    .INIT(16'h0007)) 
    \FSM_sequential_state[0]_i_15 
       (.I0(lmr_req),
        .I1(\u5/lookup_ready2 ),
        .I2(init_req),
        .I3(rfr_req),
        .O(\FSM_sequential_state[0]_i_15_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_state[0]_i_16 
       (.I0(\u5/susp_req_r ),
        .I1(wb_cycle),
        .O(\FSM_sequential_state[0]_i_16_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFD)) 
    \FSM_sequential_state[0]_i_17 
       (.I0(\u5/state [0]),
        .I1(\u5/state [1]),
        .I2(\u5/state [3]),
        .I3(\u5/state [2]),
        .I4(\u5/state [6]),
        .O(\FSM_sequential_state[0]_i_17_n_0 ));
  LUT6 #(
    .INIT(64'h0404000400000004)) 
    \FSM_sequential_state[0]_i_18 
       (.I0(\u5/state [6]),
        .I1(\u5/state [0]),
        .I2(\u5/state [3]),
        .I3(\u5/state [5]),
        .I4(\u5/state [1]),
        .I5(\u5/state [2]),
        .O(\FSM_sequential_state[0]_i_18_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair112" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_state[0]_i_2 
       (.I0(\FSM_sequential_state[6]_i_22_n_0 ),
        .I1(\u5/state [5]),
        .O(\FSM_sequential_state[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \FSM_sequential_state[0]_i_3 
       (.I0(\u5/state [2]),
        .I1(\u5/state [0]),
        .O(\FSM_sequential_state[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00800000)) 
    \FSM_sequential_state[0]_i_4 
       (.I0(\u5/state [4]),
        .I1(\u5/state [2]),
        .I2(\u5/state [0]),
        .I3(\u5/state [1]),
        .I4(\FSM_sequential_state[2]_i_11_n_0 ),
        .I5(\FSM_sequential_state[0]_i_8_n_0 ),
        .O(\FSM_sequential_state[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000FF00D000FF00)) 
    \FSM_sequential_state[0]_i_5 
       (.I0(\FSM_sequential_state[2]_i_13_n_0 ),
        .I1(\u5/state [5]),
        .I2(\u5/state [4]),
        .I3(\u5/state [1]),
        .I4(\u5/state [0]),
        .I5(\u5/state [3]),
        .O(\FSM_sequential_state[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000A000A2)) 
    \FSM_sequential_state[0]_i_6 
       (.I0(\FSM_sequential_state[0]_i_9_n_0 ),
        .I1(\u5/state [5]),
        .I2(\u5/state [1]),
        .I3(\u5/state [2]),
        .I4(\u5/state [4]),
        .I5(\FSM_sequential_state[0]_i_10_n_0 ),
        .O(\FSM_sequential_state[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hBBBAAABABBBBBBBB)) 
    \FSM_sequential_state[0]_i_7 
       (.I0(\FSM_sequential_state[0]_i_11_n_0 ),
        .I1(\FSM_sequential_state[0]_i_12_n_0 ),
        .I2(\FSM_sequential_state[1]_i_9_n_0 ),
        .I3(\u5/state [5]),
        .I4(mc_adv__i_3_n_0),
        .I5(\u5/state [1]),
        .O(\FSM_sequential_state[0]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCFFDFCCCCDFDF)) 
    \FSM_sequential_state[0]_i_8 
       (.I0(\u5/state [4]),
        .I1(\u5/state [6]),
        .I2(\u5/state [3]),
        .I3(no_wb_cycle_i_2_n_0),
        .I4(\u5/state [0]),
        .I5(\u5/state [5]),
        .O(\FSM_sequential_state[0]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hEE2EEEEEFFFFFFFF)) 
    \FSM_sequential_state[0]_i_9 
       (.I0(\FSM_sequential_state[0]_i_13_n_0 ),
        .I1(\u5/state [5]),
        .I2(\u5/state [4]),
        .I3(no_wb_cycle_i_2_n_0),
        .I4(mem_ack_r_i_7_n_0),
        .I5(rfr_ack_r_i_2_n_0),
        .O(\FSM_sequential_state[0]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h8AAA8A00AAAAAAAA)) 
    \FSM_sequential_state[1]_i_1 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(\FSM_sequential_state[1]_i_3_n_0 ),
        .I2(\FSM_sequential_state[1]_i_4_n_0 ),
        .I3(\u5/state [0]),
        .I4(\FSM_sequential_state[1]_i_5_n_0 ),
        .I5(\FSM_sequential_state[1]_i_6_n_0 ),
        .O(\FSM_sequential_state[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h1010101010001010)) 
    \FSM_sequential_state[1]_i_10 
       (.I0(\u5/state [2]),
        .I1(\u5/state [1]),
        .I2(\u5/state [5]),
        .I3(mc_ack_r),
        .I4(\u5/state [4]),
        .I5(\u5/state [3]),
        .O(\FSM_sequential_state[1]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hBBBBBBB0BBB0BBB0)) 
    \FSM_sequential_state[1]_i_11 
       (.I0(wb_cycle),
        .I1(\u5/susp_req_r ),
        .I2(\FSM_sequential_state[5]_i_9_n_0 ),
        .I3(\FSM_sequential_state[2]_i_18_n_0 ),
        .I4(cs_le_i_7_n_0),
        .I5(wb_write_go),
        .O(\FSM_sequential_state[1]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT3 #(
    .INIT(8'hEA)) 
    \FSM_sequential_state[1]_i_12 
       (.I0(rfr_req),
        .I1(lmr_req),
        .I2(\u5/lookup_ready2 ),
        .O(\FSM_sequential_state[1]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \FSM_sequential_state[1]_i_13 
       (.I0(\u5/state [2]),
        .I1(\u5/state [4]),
        .O(\FSM_sequential_state[1]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h4F4FCFCF4F4FFFCF)) 
    \FSM_sequential_state[1]_i_14 
       (.I0(\FSM_sequential_state[6]_i_25_n_0 ),
        .I1(\u5/state [3]),
        .I2(rfr_ack_r_i_7_n_0),
        .I3(\FSM_sequential_state[1]_i_19_n_0 ),
        .I4(\u5/state [4]),
        .I5(\u5/state [2]),
        .O(\FSM_sequential_state[1]_i_14_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT4 #(
    .INIT(16'hC3FB)) 
    \FSM_sequential_state[1]_i_15 
       (.I0(pack_le0_i_3_n_0),
        .I1(\u5/state [2]),
        .I2(\u5/state [4]),
        .I3(\u5/state [3]),
        .O(\FSM_sequential_state[1]_i_15_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF01000000)) 
    \FSM_sequential_state[1]_i_16 
       (.I0(data_oe_r_i_7_n_0),
        .I1(\u5/state [1]),
        .I2(\u5/state [5]),
        .I3(\u5/state [4]),
        .I4(\u5/state [2]),
        .I5(\FSM_sequential_state[1]_i_20_n_0 ),
        .O(\FSM_sequential_state[1]_i_16_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT5 #(
    .INIT(32'h5A5A5A58)) 
    \FSM_sequential_state[1]_i_17 
       (.I0(\u5/state [4]),
        .I1(\FSM_sequential_state[1]_i_21_n_0 ),
        .I2(\u5/state [2]),
        .I3(cke__i_5_n_0),
        .I4(\u5/ap_en ),
        .O(\FSM_sequential_state[1]_i_17_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair120" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_state[1]_i_18 
       (.I0(\u5/state [1]),
        .I1(\u5/state [3]),
        .O(\FSM_sequential_state[1]_i_18_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair115" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_state[1]_i_19 
       (.I0(init_req),
        .I1(rfr_req),
        .O(\FSM_sequential_state[1]_i_19_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFB)) 
    \FSM_sequential_state[1]_i_2 
       (.I0(\u5/state [1]),
        .I1(\u5/ir_cnt_done ),
        .I2(\u5/state [4]),
        .I3(\u5/state [2]),
        .I4(\u5/state [0]),
        .O(\FSM_sequential_state[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h054FFFFF00000000)) 
    \FSM_sequential_state[1]_i_20 
       (.I0(\u5/state [3]),
        .I1(wb_write_go),
        .I2(\u5/state [4]),
        .I3(\u5/state [5]),
        .I4(\u5/state [2]),
        .I5(\u5/state [1]),
        .O(\FSM_sequential_state[1]_i_20_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT4 #(
    .INIT(16'h0535)) 
    \FSM_sequential_state[1]_i_21 
       (.I0(wb_cycle),
        .I1(\u5/wb_write_go_r ),
        .I2(\cmd_r[0]_i_5_n_0 ),
        .I3(burst_act_rd_i_2_n_0),
        .O(\FSM_sequential_state[1]_i_21_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFF10FF10FF10)) 
    \FSM_sequential_state[1]_i_3 
       (.I0(\FSM_sequential_state[1]_i_7_n_0 ),
        .I1(\FSM_sequential_state[1]_i_8_n_0 ),
        .I2(\FSM_sequential_state[1]_i_9_n_0 ),
        .I3(\FSM_sequential_state[1]_i_10_n_0 ),
        .I4(wb_write_go),
        .I5(\FSM_sequential_state[2]_i_9_n_0 ),
        .O(\FSM_sequential_state[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFABAAAAAAAAAA)) 
    \FSM_sequential_state[1]_i_4 
       (.I0(\u5/state [1]),
        .I1(\FSM_sequential_state[1]_i_11_n_0 ),
        .I2(\FSM_sequential_state[1]_i_12_n_0 ),
        .I3(\FSM_sequential_state[1]_i_13_n_0 ),
        .I4(\FSM_sequential_state[1]_i_14_n_0 ),
        .I5(\FSM_sequential_state[1]_i_15_n_0 ),
        .O(\FSM_sequential_state[1]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hAAAAEAAE)) 
    \FSM_sequential_state[1]_i_5 
       (.I0(\FSM_sequential_state[1]_i_16_n_0 ),
        .I1(\u5/state [3]),
        .I2(\u5/state [1]),
        .I3(\u5/state [5]),
        .I4(\FSM_sequential_state[1]_i_17_n_0 ),
        .O(\FSM_sequential_state[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hBBFFFFFFFFFFFF3F)) 
    \FSM_sequential_state[1]_i_6 
       (.I0(mc_adv__i_3_n_0),
        .I1(\FSM_sequential_state[1]_i_18_n_0 ),
        .I2(rfr_ack),
        .I3(\u5/state [2]),
        .I4(\u5/state [4]),
        .I5(\u5/state [5]),
        .O(\FSM_sequential_state[1]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_state[1]_i_7 
       (.I0(\cmd_r[0]_i_5_n_0 ),
        .I1(burst_act_rd_i_2_n_0),
        .O(\FSM_sequential_state[1]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFEFFFFF)) 
    \FSM_sequential_state[1]_i_8 
       (.I0(wb_write_go),
        .I1(\u5/state [5]),
        .I2(\u5/state [2]),
        .I3(\u5/state [3]),
        .I4(\u5/state [4]),
        .I5(\u5/ap_en ),
        .O(\FSM_sequential_state[1]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \FSM_sequential_state[1]_i_9 
       (.I0(cke__i_5_n_0),
        .I1(wb_cycle),
        .O(\FSM_sequential_state[1]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h8A8A8A888A8A8A8A)) 
    \FSM_sequential_state[2]_i_1 
       (.I0(\FSM_sequential_state[2]_i_2_n_0 ),
        .I1(\FSM_sequential_state[2]_i_3_n_0 ),
        .I2(\FSM_sequential_state[2]_i_4_n_0 ),
        .I3(\FSM_sequential_state[2]_i_5_n_0 ),
        .I4(\FSM_sequential_state[2]_i_6_n_0 ),
        .I5(\FSM_sequential_state[2]_i_7_n_0 ),
        .O(\FSM_sequential_state[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEAEEE)) 
    \FSM_sequential_state[2]_i_10 
       (.I0(\FSM_sequential_state[2]_i_20_n_0 ),
        .I1(\FSM_sequential_state[2]_i_21_n_0 ),
        .I2(\u5/state [4]),
        .I3(\u5/state [3]),
        .I4(\u5/state [5]),
        .I5(\u5/state [0]),
        .O(\FSM_sequential_state[2]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hEEEEEEECECECEEEC)) 
    \FSM_sequential_state[2]_i_11 
       (.I0(\u5/state [3]),
        .I1(\u5/state [5]),
        .I2(\u5/ap_en ),
        .I3(sp_csc[10]),
        .I4(\timer2[6]_i_4_n_0 ),
        .I5(csc__0[10]),
        .O(\FSM_sequential_state[2]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \FSM_sequential_state[2]_i_12 
       (.I0(\u5/state [5]),
        .I1(rfr_ack),
        .O(\FSM_sequential_state[2]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \FSM_sequential_state[2]_i_13 
       (.I0(\FSM_sequential_state[1]_i_9_n_0 ),
        .I1(\FSM_sequential_state[1]_i_7_n_0 ),
        .I2(\u5/ap_en ),
        .O(\FSM_sequential_state[2]_i_13_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \FSM_sequential_state[2]_i_14 
       (.I0(\u5/state [2]),
        .I1(\u5/state [1]),
        .O(\FSM_sequential_state[2]_i_14_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT4 #(
    .INIT(16'hF1FF)) 
    \FSM_sequential_state[2]_i_15 
       (.I0(\u5/state [5]),
        .I1(\u5/state [2]),
        .I2(\u5/state [3]),
        .I3(\u5/state [4]),
        .O(\FSM_sequential_state[2]_i_15_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \FSM_sequential_state[2]_i_16 
       (.I0(\u5/state [1]),
        .I1(\u5/state [4]),
        .I2(\u5/state [5]),
        .O(\FSM_sequential_state[2]_i_16_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT5 #(
    .INIT(32'h04050505)) 
    \FSM_sequential_state[2]_i_17 
       (.I0(\u5/state [3]),
        .I1(init_req),
        .I2(rfr_req),
        .I3(lmr_req),
        .I4(\u5/lookup_ready2 ),
        .O(\FSM_sequential_state[2]_i_17_n_0 ));
  LUT6 #(
    .INIT(64'h000000000000B800)) 
    \FSM_sequential_state[2]_i_18 
       (.I0(csc__0[10]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_csc[10]),
        .I3(bank_open),
        .I4(cs_le_i_7_n_0),
        .I5(row_same),
        .O(\FSM_sequential_state[2]_i_18_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT4 #(
    .INIT(16'h000D)) 
    \FSM_sequential_state[2]_i_19 
       (.I0(\u5/susp_req_r ),
        .I1(wb_cycle),
        .I2(init_req),
        .I3(\FSM_sequential_state[5]_i_9_n_0 ),
        .O(\FSM_sequential_state[2]_i_19_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'hFEFF)) 
    \FSM_sequential_state[2]_i_2 
       (.I0(\u5/state [0]),
        .I1(\u5/state [2]),
        .I2(\u5/state [4]),
        .I3(\u5/ir_cnt_done ),
        .O(\FSM_sequential_state[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFBFF0000FAFFFAFF)) 
    \FSM_sequential_state[2]_i_20 
       (.I0(\u5/state [1]),
        .I1(\u5/state [4]),
        .I2(\u5/state [5]),
        .I3(\u5/state [3]),
        .I4(\FSM_sequential_state[2]_i_22_n_0 ),
        .I5(\u5/state [2]),
        .O(\FSM_sequential_state[2]_i_20_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT4 #(
    .INIT(16'h0400)) 
    \FSM_sequential_state[2]_i_21 
       (.I0(\u5/state [1]),
        .I1(\u5/state [2]),
        .I2(no_wb_cycle_i_2_n_0),
        .I3(\u5/state [3]),
        .O(\FSM_sequential_state[2]_i_21_n_0 ));
  LUT6 #(
    .INIT(64'h4444555500445055)) 
    \FSM_sequential_state[2]_i_22 
       (.I0(\u5/state [5]),
        .I1(\u5/state [4]),
        .I2(\FSM_sequential_state[6]_i_40_n_0 ),
        .I3(wb_write_go),
        .I4(\u5/state [1]),
        .I5(\u5/state [3]),
        .O(\FSM_sequential_state[2]_i_22_n_0 ));
  LUT6 #(
    .INIT(64'hCFCFCFCCEFEFCFCF)) 
    \FSM_sequential_state[2]_i_3 
       (.I0(\FSM_sequential_state[2]_i_8_n_0 ),
        .I1(\FSM_sequential_state[2]_i_9_n_0 ),
        .I2(\FSM_sequential_state[2]_i_10_n_0 ),
        .I3(\FSM_sequential_state[6]_i_22_n_0 ),
        .I4(\u5/state [2]),
        .I5(\u5/state [4]),
        .O(\FSM_sequential_state[2]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair116" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \FSM_sequential_state[2]_i_4 
       (.I0(\u5/state [6]),
        .I1(\u5/state [0]),
        .O(\FSM_sequential_state[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h05F005F0050005C0)) 
    \FSM_sequential_state[2]_i_5 
       (.I0(\FSM_sequential_state[2]_i_11_n_0 ),
        .I1(\FSM_sequential_state[2]_i_12_n_0 ),
        .I2(\u5/state [1]),
        .I3(\u5/state [2]),
        .I4(\u5/state [4]),
        .I5(\u5/state [3]),
        .O(\FSM_sequential_state[2]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000022720000)) 
    \FSM_sequential_state[2]_i_6 
       (.I0(\u5/state [5]),
        .I1(mc_ack_r),
        .I2(\FSM_sequential_state[2]_i_13_n_0 ),
        .I3(wb_write_go),
        .I4(\FSM_sequential_state[2]_i_14_n_0 ),
        .I5(\FSM_sequential_state[2]_i_15_n_0 ),
        .O(\FSM_sequential_state[2]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAFFFBBBBB)) 
    \FSM_sequential_state[2]_i_7 
       (.I0(\FSM_sequential_state[2]_i_16_n_0 ),
        .I1(\FSM_sequential_state[2]_i_17_n_0 ),
        .I2(mc_adsc__i_5_n_0),
        .I3(\FSM_sequential_state[2]_i_18_n_0 ),
        .I4(\FSM_sequential_state[2]_i_19_n_0 ),
        .I5(\u5/state [2]),
        .O(\FSM_sequential_state[2]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h7033700370337033)) 
    \FSM_sequential_state[2]_i_8 
       (.I0(mc_ack_r),
        .I1(\u5/state [1]),
        .I2(\u5/state [5]),
        .I3(\u5/state [3]),
        .I4(pack_le0_i_3_n_0),
        .I5(pack_le0_i_2_n_0),
        .O(\FSM_sequential_state[2]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT5 #(
    .INIT(32'h00800000)) 
    \FSM_sequential_state[2]_i_9 
       (.I0(\u5/state [2]),
        .I1(\u5/state [4]),
        .I2(\u5/state [5]),
        .I3(\u5/state [3]),
        .I4(\u5/state [1]),
        .O(\FSM_sequential_state[2]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h00000000F4F4F4F7)) 
    \FSM_sequential_state[3]_i_1 
       (.I0(\FSM_sequential_state[3]_i_2_n_0 ),
        .I1(\u5/state [2]),
        .I2(\FSM_sequential_state[3]_i_3_n_0 ),
        .I3(\u5/state [6]),
        .I4(\FSM_sequential_state[3]_i_4_n_0 ),
        .I5(\FSM_sequential_state[3]_i_5_n_0 ),
        .O(\FSM_sequential_state[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFF4F)) 
    \FSM_sequential_state[3]_i_10 
       (.I0(\FSM_sequential_state[5]_i_9_n_0 ),
        .I1(\FSM_sequential_state[3]_i_12_n_0 ),
        .I2(\u5/state [0]),
        .I3(\u5/state [3]),
        .I4(rfr_req),
        .I5(init_req),
        .O(\FSM_sequential_state[3]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h11F111F111F11111)) 
    \FSM_sequential_state[3]_i_11 
       (.I0(\burst_cnt[8]_i_3_n_0 ),
        .I1(\u5/state [4]),
        .I2(\u5/state [1]),
        .I3(wb_write_go),
        .I4(no_wb_cycle_i_2_n_0),
        .I5(wb_stb_i),
        .O(\FSM_sequential_state[3]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h0000303330331011)) 
    \FSM_sequential_state[3]_i_12 
       (.I0(\mc_addr[14]_i_4_n_0 ),
        .I1(lmr_req),
        .I2(wb_cycle),
        .I3(\u5/susp_req_r ),
        .I4(wb_write_go),
        .I5(\mc_addr[23]_i_3_n_0 ),
        .O(\FSM_sequential_state[3]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h0000707777777077)) 
    \FSM_sequential_state[3]_i_2 
       (.I0(\FSM_sequential_state[3]_i_6_n_0 ),
        .I1(\FSM_sequential_state[6]_i_24_n_0 ),
        .I2(\FSM_sequential_state[3]_i_7_n_0 ),
        .I3(\u5/state [4]),
        .I4(\u5/state [0]),
        .I5(\FSM_sequential_state[3]_i_8_n_0 ),
        .O(\FSM_sequential_state[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT5 #(
    .INIT(32'h40400440)) 
    \FSM_sequential_state[3]_i_3 
       (.I0(\u5/state [0]),
        .I1(\u5/state [3]),
        .I2(\u5/state [5]),
        .I3(\u5/state [1]),
        .I4(\u5/state [4]),
        .O(\FSM_sequential_state[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h5D7D555551415555)) 
    \FSM_sequential_state[3]_i_4 
       (.I0(\u5/state [3]),
        .I1(\u5/state [0]),
        .I2(\u5/state [4]),
        .I3(\FSM_sequential_state[6]_i_22_n_0 ),
        .I4(\FSM_sequential_state[3]_i_9_n_0 ),
        .I5(\FSM_sequential_state[3]_i_10_n_0 ),
        .O(\FSM_sequential_state[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \FSM_sequential_state[3]_i_5 
       (.I0(\u5/state [2]),
        .I1(\u5/state [4]),
        .I2(\u5/state [5]),
        .I3(\u5/state [1]),
        .I4(\u5/ir_cnt_done ),
        .I5(\u5/state [0]),
        .O(\FSM_sequential_state[3]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT4 #(
    .INIT(16'h0400)) 
    \FSM_sequential_state[3]_i_6 
       (.I0(\u5/state [3]),
        .I1(\u5/state [0]),
        .I2(\u5/state [5]),
        .I3(\u5/state [1]),
        .O(\FSM_sequential_state[3]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFF30CCDDFFFCCCDD)) 
    \FSM_sequential_state[3]_i_7 
       (.I0(data_oe_r_i_7_n_0),
        .I1(\u5/state [5]),
        .I2(wb_write_go),
        .I3(\u5/state [3]),
        .I4(\u5/state [1]),
        .I5(mc_adv__i_3_n_0),
        .O(\FSM_sequential_state[3]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h03032323FF0C0C0C)) 
    \FSM_sequential_state[3]_i_8 
       (.I0(\FSM_sequential_state[6]_i_25_n_0 ),
        .I1(\u5/state [1]),
        .I2(\u5/state [4]),
        .I3(\FSM_sequential_state[3]_i_11_n_0 ),
        .I4(\u5/state [5]),
        .I5(\u5/state [3]),
        .O(\FSM_sequential_state[3]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \FSM_sequential_state[3]_i_9 
       (.I0(\u5/state [5]),
        .I1(\u5/state [1]),
        .O(\FSM_sequential_state[3]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAEAAAAAAAAAA)) 
    \FSM_sequential_state[4]_i_1 
       (.I0(\FSM_sequential_state[4]_i_2_n_0 ),
        .I1(suspended_i_2_n_0),
        .I2(\FSM_sequential_state[4]_i_3_n_0 ),
        .I3(\FSM_sequential_state[4]_i_4_n_0 ),
        .I4(\FSM_sequential_state[4]_i_5_n_0 ),
        .I5(\FSM_sequential_state[4]_i_6_n_0 ),
        .O(\FSM_sequential_state[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888A8A8A8A8A888A)) 
    \FSM_sequential_state[4]_i_10 
       (.I0(\FSM_sequential_state[4]_i_11_n_0 ),
        .I1(\FSM_sequential_state[5]_i_9_n_0 ),
        .I2(\FSM_sequential_state[2]_i_18_n_0 ),
        .I3(\mc_addr[23]_i_3_n_0 ),
        .I4(wb_write_go),
        .I5(\mc_addr[14]_i_4_n_0 ),
        .O(\FSM_sequential_state[4]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \FSM_sequential_state[4]_i_11 
       (.I0(\FSM_sequential_state[5]_i_8_n_0 ),
        .I1(\u5/state [1]),
        .I2(\u5/state [5]),
        .O(\FSM_sequential_state[4]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h4040400055555555)) 
    \FSM_sequential_state[4]_i_2 
       (.I0(\u5/state [6]),
        .I1(\FSM_sequential_state[4]_i_7_n_0 ),
        .I2(\u5/state [3]),
        .I3(\u5/state [4]),
        .I4(\FSM_sequential_state[4]_i_8_n_0 ),
        .I5(\FSM_sequential_state[4]_i_9_n_0 ),
        .O(\FSM_sequential_state[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \FSM_sequential_state[4]_i_3 
       (.I0(\u5/state [2]),
        .I1(\u5/state [4]),
        .O(\FSM_sequential_state[4]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair112" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_sequential_state[4]_i_4 
       (.I0(\u5/state [5]),
        .I1(\FSM_sequential_state[6]_i_24_n_0 ),
        .O(\FSM_sequential_state[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0404C4C4FF3CC4C4)) 
    \FSM_sequential_state[4]_i_5 
       (.I0(\u5/state [5]),
        .I1(\u5/state [4]),
        .I2(\u5/state [1]),
        .I3(\FSM_sequential_state[4]_i_10_n_0 ),
        .I4(\u5/state [0]),
        .I5(\u5/state [2]),
        .O(\FSM_sequential_state[4]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair122" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \FSM_sequential_state[4]_i_6 
       (.I0(\u5/state [3]),
        .I1(\u5/state [6]),
        .O(\FSM_sequential_state[4]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT5 #(
    .INIT(32'h0CFCFEFE)) 
    \FSM_sequential_state[4]_i_7 
       (.I0(\FSM_sequential_state[6]_i_22_n_0 ),
        .I1(\u5/state [5]),
        .I2(\u5/state [0]),
        .I3(\u5/state [4]),
        .I4(\u5/state [2]),
        .O(\FSM_sequential_state[4]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair113" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_sequential_state[4]_i_8 
       (.I0(\u5/state [2]),
        .I1(\u5/state [1]),
        .O(\FSM_sequential_state[4]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFDF0FFFFFF0FFFFF)) 
    \FSM_sequential_state[4]_i_9 
       (.I0(\FSM_sequential_state[6]_i_25_n_0 ),
        .I1(\u5/state [5]),
        .I2(\u5/state [1]),
        .I3(\u5/state [0]),
        .I4(\u5/state [4]),
        .I5(\u5/state [2]),
        .O(\FSM_sequential_state[4]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h4544444445454545)) 
    \FSM_sequential_state[5]_i_1 
       (.I0(\u5/state [6]),
        .I1(\FSM_sequential_state[5]_i_2_n_0 ),
        .I2(\FSM_sequential_state[5]_i_3_n_0 ),
        .I3(\FSM_sequential_state[5]_i_4_n_0 ),
        .I4(\FSM_sequential_state[5]_i_5_n_0 ),
        .I5(\FSM_sequential_state[5]_i_6_n_0 ),
        .O(\FSM_sequential_state[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h4AFE0000FFFF0000)) 
    \FSM_sequential_state[5]_i_2 
       (.I0(\u5/state [3]),
        .I1(\u5/state [1]),
        .I2(\u5/state [2]),
        .I3(\u5/state [0]),
        .I4(\u5/state [5]),
        .I5(\u5/state [4]),
        .O(\FSM_sequential_state[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT4 #(
    .INIT(16'h7EFF)) 
    \FSM_sequential_state[5]_i_3 
       (.I0(\u5/state [2]),
        .I1(\u5/state [3]),
        .I2(\u5/state [1]),
        .I3(\u5/state [0]),
        .O(\FSM_sequential_state[5]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_sequential_state[5]_i_4 
       (.I0(\u5/state [5]),
        .I1(\u5/state [4]),
        .O(\FSM_sequential_state[5]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair119" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \FSM_sequential_state[5]_i_5 
       (.I0(\u5/state [5]),
        .I1(\u5/state [3]),
        .O(\FSM_sequential_state[5]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h777F7777777F777F)) 
    \FSM_sequential_state[5]_i_6 
       (.I0(\FSM_sequential_state[5]_i_7_n_0 ),
        .I1(\FSM_sequential_state[5]_i_8_n_0 ),
        .I2(\FSM_sequential_state[5]_i_9_n_0 ),
        .I3(\mc_addr[14]_i_4_n_0 ),
        .I4(wb_write_go),
        .I5(\mc_addr[23]_i_3_n_0 ),
        .O(\FSM_sequential_state[5]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair121" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \FSM_sequential_state[5]_i_7 
       (.I0(\u5/state [3]),
        .I1(\u5/state [4]),
        .O(\FSM_sequential_state[5]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0111000001110111)) 
    \FSM_sequential_state[5]_i_8 
       (.I0(rfr_req),
        .I1(init_req),
        .I2(\u5/lookup_ready2 ),
        .I3(lmr_req),
        .I4(wb_cycle),
        .I5(\u5/susp_req_r ),
        .O(\FSM_sequential_state[5]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'h4F4FFF4F)) 
    \FSM_sequential_state[5]_i_9 
       (.I0(wb_write_go),
        .I1(no_wb_cycle_i_2_n_0),
        .I2(\u5/lookup_ready2 ),
        .I3(\mc_cs_[1]_i_2_n_0 ),
        .I4(\mc_cs_[0]_i_2_n_0 ),
        .O(\FSM_sequential_state[5]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF1311)) 
    \FSM_sequential_state[6]_i_1 
       (.I0(\FSM_sequential_state[6]_i_3_n_0 ),
        .I1(\u5/state [6]),
        .I2(\FSM_sequential_state[6]_i_4_n_0 ),
        .I3(\FSM_sequential_state[6]_i_5_n_0 ),
        .I4(\FSM_sequential_state[6]_i_6_n_0 ),
        .I5(\FSM_sequential_state[6]_i_7_n_0 ),
        .O(\FSM_sequential_state[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT4 #(
    .INIT(16'hFFFD)) 
    \FSM_sequential_state[6]_i_10 
       (.I0(\u5/state [3]),
        .I1(\u5/state [1]),
        .I2(\u5/state [5]),
        .I3(\u5/state [2]),
        .O(\FSM_sequential_state[6]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h3FCFFF8F3FCFF38F)) 
    \FSM_sequential_state[6]_i_11 
       (.I0(\FSM_sequential_state[6]_i_24_n_0 ),
        .I1(\u5/state [2]),
        .I2(\u5/state [1]),
        .I3(\u5/state [3]),
        .I4(\u5/state [5]),
        .I5(\FSM_sequential_state[6]_i_25_n_0 ),
        .O(\FSM_sequential_state[6]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h0D0D0F0F0D0D0F00)) 
    \FSM_sequential_state[6]_i_12 
       (.I0(\u5/tmr2_done ),
        .I1(\u5/state [4]),
        .I2(\FSM_sequential_state[6]_i_26_n_0 ),
        .I3(\u5/state [1]),
        .I4(\u5/state [0]),
        .I5(\FSM_sequential_state[6]_i_27_n_0 ),
        .O(\FSM_sequential_state[6]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h000000000000AA02)) 
    \FSM_sequential_state[6]_i_13 
       (.I0(\FSM_sequential_state[6]_i_28_n_0 ),
        .I1(wb_stb_i),
        .I2(no_wb_cycle_i_2_n_0),
        .I3(\FSM_sequential_state[6]_i_29_n_0 ),
        .I4(\FSM_sequential_state[6]_i_30_n_0 ),
        .I5(\FSM_sequential_state[6]_i_31_n_0 ),
        .O(\FSM_sequential_state[6]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hFEFEFEFE0E0EFE0E)) 
    \FSM_sequential_state[6]_i_14 
       (.I0(\FSM_sequential_state[6]_i_32_n_0 ),
        .I1(\cmd_r[0]_i_2_n_0 ),
        .I2(\u5/state [4]),
        .I3(\b3_last_row[12]_i_3_n_0 ),
        .I4(\FSM_sequential_state[6]_i_33_n_0 ),
        .I5(\FSM_sequential_state[6]_i_34_n_0 ),
        .O(\FSM_sequential_state[6]_i_14_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFFF00FE)) 
    \FSM_sequential_state[6]_i_15 
       (.I0(\cmd_r[0]_i_6_n_0 ),
        .I1(\FSM_sequential_state[6]_i_35_n_0 ),
        .I2(\FSM_sequential_state[6]_i_36_n_0 ),
        .I3(\FSM_sequential_state[6]_i_37_n_0 ),
        .I4(\u5/state [1]),
        .I5(\FSM_sequential_state[6]_i_38_n_0 ),
        .O(\FSM_sequential_state[6]_i_15_n_0 ));
  LUT6 #(
    .INIT(64'hE000000000000000)) 
    \FSM_sequential_state[6]_i_16 
       (.I0(ap_en_i_2_n_0),
        .I1(\u5/cmd_asserted ),
        .I2(\u5/tmr_done ),
        .I3(\u5/state [4]),
        .I4(\u5/state [3]),
        .I5(\u5/state [1]),
        .O(\FSM_sequential_state[6]_i_16_n_0 ));
  LUT6 #(
    .INIT(64'h0002000233030003)) 
    \FSM_sequential_state[6]_i_17 
       (.I0(\FSM_sequential_state[6]_i_39_n_0 ),
        .I1(\u5/state [0]),
        .I2(\u5/state [3]),
        .I3(\u5/state [1]),
        .I4(\u5/tmr_done ),
        .I5(\u5/state [4]),
        .O(\FSM_sequential_state[6]_i_17_n_0 ));
  LUT6 #(
    .INIT(64'hFEFEFEFEAAFEAAAA)) 
    \FSM_sequential_state[6]_i_18 
       (.I0(\u5/state [1]),
        .I1(mem_ack_r_i_7_n_0),
        .I2(wb_write_go),
        .I3(\u5/mem_ack_r ),
        .I4(mc_adv__i_3_n_0),
        .I5(\FSM_sequential_state[6]_i_25_n_0 ),
        .O(\FSM_sequential_state[6]_i_18_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair124" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_sequential_state[6]_i_19 
       (.I0(\u5/state [0]),
        .I1(\u5/state [4]),
        .O(\FSM_sequential_state[6]_i_19_n_0 ));
  LUT6 #(
    .INIT(64'h020202A2A2A202A2)) 
    \FSM_sequential_state[6]_i_2 
       (.I0(\FSM_sequential_state[6]_i_8_n_0 ),
        .I1(\FSM_sequential_state[6]_i_9_n_0 ),
        .I2(\u5/state [0]),
        .I3(\FSM_sequential_state[6]_i_10_n_0 ),
        .I4(\u5/state [4]),
        .I5(\FSM_sequential_state[6]_i_11_n_0 ),
        .O(\FSM_sequential_state[6]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hA808A8A8)) 
    \FSM_sequential_state[6]_i_20 
       (.I0(\FSM_sequential_state[5]_i_8_n_0 ),
        .I1(\FSM_sequential_state[6]_i_40_n_0 ),
        .I2(\FSM_sequential_state[5]_i_9_n_0 ),
        .I3(\u5/cmd_asserted2 ),
        .I4(mc_br_r),
        .O(\FSM_sequential_state[6]_i_20_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair123" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \FSM_sequential_state[6]_i_21 
       (.I0(\u5/state [4]),
        .I1(\u5/state [0]),
        .O(\FSM_sequential_state[6]_i_21_n_0 ));
  LUT6 #(
    .INIT(64'h003000300030FAFA)) 
    \FSM_sequential_state[6]_i_22 
       (.I0(wb_cycle),
        .I1(burst_act_rd_i_2_n_0),
        .I2(\cmd_r[0]_i_5_n_0 ),
        .I3(\u5/wb_write_go_r ),
        .I4(\u5/ap_en ),
        .I5(cke__i_5_n_0),
        .O(\FSM_sequential_state[6]_i_22_n_0 ));
  LUT6 #(
    .INIT(64'hBAAAAAAAAAAABAAA)) 
    \FSM_sequential_state[6]_i_23 
       (.I0(\u5/state [6]),
        .I1(\u5/state [5]),
        .I2(\u5/state [3]),
        .I3(\u5/state [2]),
        .I4(\u5/state [1]),
        .I5(\u5/state [4]),
        .O(\FSM_sequential_state[6]_i_23_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT4 #(
    .INIT(16'hF0D0)) 
    \FSM_sequential_state[6]_i_24 
       (.I0(\u5/ap_en ),
        .I1(\FSM_sequential_state[1]_i_7_n_0 ),
        .I2(\FSM_sequential_state[1]_i_9_n_0 ),
        .I3(wb_write_go),
        .O(\FSM_sequential_state[6]_i_24_n_0 ));
  LUT4 #(
    .INIT(16'h0151)) 
    \FSM_sequential_state[6]_i_25 
       (.I0(\u5/ap_en ),
        .I1(sp_csc[10]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(csc__0[10]),
        .O(\FSM_sequential_state[6]_i_25_n_0 ));
  LUT6 #(
    .INIT(64'h5454541450505010)) 
    \FSM_sequential_state[6]_i_26 
       (.I0(\u5/state [3]),
        .I1(\u5/state [4]),
        .I2(\u5/state [0]),
        .I3(mc_ack_r),
        .I4(\u5/tmr2_done ),
        .I5(\u5/tmr_done ),
        .O(\FSM_sequential_state[6]_i_26_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \FSM_sequential_state[6]_i_27 
       (.I0(\u5/cmd_asserted ),
        .I1(\u5/state [3]),
        .O(\FSM_sequential_state[6]_i_27_n_0 ));
  LUT6 #(
    .INIT(64'h7F33FFFFFFFFFFFF)) 
    \FSM_sequential_state[6]_i_28 
       (.I0(mc_adv__i_3_n_0),
        .I1(\u5/tmr2_done ),
        .I2(\u5/cs_le_r ),
        .I3(wb_cycle),
        .I4(\u5/state [0]),
        .I5(\u5/state [4]),
        .O(\FSM_sequential_state[6]_i_28_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \FSM_sequential_state[6]_i_29 
       (.I0(\u5/state [1]),
        .I1(\u5/state [3]),
        .O(\FSM_sequential_state[6]_i_29_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \FSM_sequential_state[6]_i_3 
       (.I0(\FSM_sequential_state[6]_i_12_n_0 ),
        .I1(\u5/state [2]),
        .I2(\FSM_sequential_state[6]_i_13_n_0 ),
        .I3(\FSM_sequential_state[6]_i_14_n_0 ),
        .I4(\u5/state [5]),
        .I5(\FSM_sequential_state[6]_i_15_n_0 ),
        .O(\FSM_sequential_state[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hEE00F000EF0FFF0F)) 
    \FSM_sequential_state[6]_i_30 
       (.I0(\u5/tmr2_done ),
        .I1(mc_ack_r),
        .I2(\u5/state [0]),
        .I3(\u5/state [3]),
        .I4(\u5/state [1]),
        .I5(\u5/state [4]),
        .O(\FSM_sequential_state[6]_i_30_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT5 #(
    .INIT(32'h55400055)) 
    \FSM_sequential_state[6]_i_31 
       (.I0(\u5/state [0]),
        .I1(data_oe_r_i_7_n_0),
        .I2(\u5/cmd_asserted ),
        .I3(\u5/state [3]),
        .I4(\u5/state [1]),
        .O(\FSM_sequential_state[6]_i_31_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair117" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_state[6]_i_32 
       (.I0(\u5/tmr2_done ),
        .I1(\u5/state [3]),
        .O(\FSM_sequential_state[6]_i_32_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \FSM_sequential_state[6]_i_33 
       (.I0(no_wb_cycle_i_2_n_0),
        .I1(cke__i_5_n_0),
        .I2(\u5/state [3]),
        .O(\FSM_sequential_state[6]_i_33_n_0 ));
  LUT6 #(
    .INIT(64'hEE00FF00F0000000)) 
    \FSM_sequential_state[6]_i_34 
       (.I0(no_wb_cycle_i_2_n_0),
        .I1(mem_ack_r_i_7_n_0),
        .I2(\u5/tmr2_done ),
        .I3(\u5/state [0]),
        .I4(\u5/state [3]),
        .I5(\u5/state [1]),
        .O(\FSM_sequential_state[6]_i_34_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT4 #(
    .INIT(16'hFBFF)) 
    \FSM_sequential_state[6]_i_35 
       (.I0(\u5/state [2]),
        .I1(\u5/state [3]),
        .I2(\u5/state [0]),
        .I3(\u5/state [4]),
        .O(\FSM_sequential_state[6]_i_35_n_0 ));
  LUT6 #(
    .INIT(64'hCCCC8088CC008000)) 
    \FSM_sequential_state[6]_i_36 
       (.I0(no_wb_cycle_i_2_n_0),
        .I1(cke__i_5_n_0),
        .I2(burst_act_rd_i_2_n_0),
        .I3(\cmd_r[0]_i_5_n_0 ),
        .I4(\u5/wb_write_go_r ),
        .I5(wb_cycle),
        .O(\FSM_sequential_state[6]_i_36_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT5 #(
    .INIT(32'hFFFF0880)) 
    \FSM_sequential_state[6]_i_37 
       (.I0(\u5/cmd_asserted ),
        .I1(\u5/state [3]),
        .I2(\u5/state [2]),
        .I3(\u5/state [0]),
        .I4(\FSM_sequential_state[6]_i_41_n_0 ),
        .O(\FSM_sequential_state[6]_i_37_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFA820A8A8)) 
    \FSM_sequential_state[6]_i_38 
       (.I0(\FSM_sequential_state[6]_i_42_n_0 ),
        .I1(\u5/state [4]),
        .I2(\u5/tmr_done ),
        .I3(wb_write_go),
        .I4(\FSM_sequential_state[6]_i_43_n_0 ),
        .I5(\FSM_sequential_state[6]_i_44_n_0 ),
        .O(\FSM_sequential_state[6]_i_38_n_0 ));
  LUT6 #(
    .INIT(64'h8AAA8A8A8AAAAAAA)) 
    \FSM_sequential_state[6]_i_39 
       (.I0(mc_adv__i_3_n_0),
        .I1(wb_write_go),
        .I2(\u5/wb_wait_r ),
        .I3(csc__0[10]),
        .I4(\timer2[6]_i_4_n_0 ),
        .I5(sp_csc[10]),
        .O(\FSM_sequential_state[6]_i_39_n_0 ));
  LUT6 #(
    .INIT(64'h0002020202020202)) 
    \FSM_sequential_state[6]_i_4 
       (.I0(\u5/state [2]),
        .I1(\FSM_sequential_state[6]_i_16_n_0 ),
        .I2(\FSM_sequential_state[6]_i_17_n_0 ),
        .I3(\FSM_sequential_state[6]_i_18_n_0 ),
        .I4(\FSM_sequential_state[6]_i_19_n_0 ),
        .I5(\u5/state [3]),
        .O(\FSM_sequential_state[6]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_state[6]_i_40 
       (.I0(wb_cyc_i),
        .I1(wb_stb_i),
        .O(\FSM_sequential_state[6]_i_40_n_0 ));
  LUT6 #(
    .INIT(64'h1010150510101000)) 
    \FSM_sequential_state[6]_i_41 
       (.I0(\u5/state [2]),
        .I1(\u5/state [3]),
        .I2(\u5/state [4]),
        .I3(\u5/resume_req_r ),
        .I4(\u5/state [0]),
        .I5(\u5/tmr_done ),
        .O(\FSM_sequential_state[6]_i_41_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \FSM_sequential_state[6]_i_42 
       (.I0(\u5/state [2]),
        .I1(\u5/state [0]),
        .I2(\u5/state [1]),
        .I3(\u5/state [3]),
        .O(\FSM_sequential_state[6]_i_42_n_0 ));
  LUT6 #(
    .INIT(64'h0000FFFD00000000)) 
    \FSM_sequential_state[6]_i_43 
       (.I0(\burst_cnt[3]_i_2_n_0 ),
        .I1(\mc_addr[2]_i_4_n_0 ),
        .I2(\timer2[6]_i_3_n_0 ),
        .I3(\burst_cnt[3]_i_3_n_0 ),
        .I4(burst_act_rd_i_2_n_0),
        .I5(wb_cycle),
        .O(\FSM_sequential_state[6]_i_43_n_0 ));
  LUT6 #(
    .INIT(64'hAEAAAAAAAEAAAEAA)) 
    \FSM_sequential_state[6]_i_44 
       (.I0(\FSM_sequential_state[6]_i_45_n_0 ),
        .I1(\FSM_sequential_state[6]_i_46_n_0 ),
        .I2(\b3_last_row[12]_i_4_n_0 ),
        .I3(\b3_last_row[12]_i_3_n_0 ),
        .I4(wb_write_go),
        .I5(\u5/wb_wait_r ),
        .O(\FSM_sequential_state[6]_i_44_n_0 ));
  LUT6 #(
    .INIT(64'hFFF080F080808080)) 
    \FSM_sequential_state[6]_i_45 
       (.I0(\u5/state [0]),
        .I1(\FSM_sequential_state[6]_i_47_n_0 ),
        .I2(\u5/cmd_asserted ),
        .I3(\u5/state [4]),
        .I4(\u5/tmr_done ),
        .I5(\FSM_sequential_state[6]_i_48_n_0 ),
        .O(\FSM_sequential_state[6]_i_45_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair124" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_sequential_state[6]_i_46 
       (.I0(\u5/tmr_done ),
        .I1(\u5/state [4]),
        .O(\FSM_sequential_state[6]_i_46_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT3 #(
    .INIT(8'h2A)) 
    \FSM_sequential_state[6]_i_47 
       (.I0(\u5/state [2]),
        .I1(\u5/state [4]),
        .I2(\u5/state [3]),
        .O(\FSM_sequential_state[6]_i_47_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \FSM_sequential_state[6]_i_48 
       (.I0(\u5/state [0]),
        .I1(\u5/state [1]),
        .I2(\u5/state [2]),
        .O(\FSM_sequential_state[6]_i_48_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAEAEF)) 
    \FSM_sequential_state[6]_i_5 
       (.I0(\u5/state [2]),
        .I1(\u5/tmr_done ),
        .I2(\u5/state [1]),
        .I3(\FSM_sequential_state[6]_i_20_n_0 ),
        .I4(\u5/state [3]),
        .I5(\FSM_sequential_state[6]_i_21_n_0 ),
        .O(\FSM_sequential_state[6]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'h80008088)) 
    \FSM_sequential_state[6]_i_6 
       (.I0(\u5/state [6]),
        .I1(cke__i_2_n_0),
        .I2(\u5/tmr_done ),
        .I3(\u5/state [0]),
        .I4(mc_br_r),
        .O(\FSM_sequential_state[6]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h1000000000000000)) 
    \FSM_sequential_state[6]_i_7 
       (.I0(\u5/state [6]),
        .I1(\u5/state [3]),
        .I2(\u5/state [1]),
        .I3(\u5/state [4]),
        .I4(\u5/cmd_asserted ),
        .I5(\u5/state [0]),
        .O(\FSM_sequential_state[6]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF757FFFFFFFFF)) 
    \FSM_sequential_state[6]_i_8 
       (.I0(\u5/tmr_done ),
        .I1(csc__0[10]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_csc[10]),
        .I4(\u5/state [0]),
        .I5(\u5/state [1]),
        .O(\FSM_sequential_state[6]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFE3FFFF)) 
    \FSM_sequential_state[6]_i_9 
       (.I0(\FSM_sequential_state[6]_i_22_n_0 ),
        .I1(\u5/state [5]),
        .I2(\u5/state [3]),
        .I3(\u5/state [1]),
        .I4(\burst_cnt[10]_i_4_n_0 ),
        .I5(\FSM_sequential_state[6]_i_23_n_0 ),
        .O(\FSM_sequential_state[6]_i_9_n_0 ));
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \ack_cnt[0]_i_1 
       (.I0(\u5/ack_cnt_reg [0]),
        .I1(\u5/no_wb_cycle ),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT4 #(
    .INIT(16'h1441)) 
    \ack_cnt[1]_i_1 
       (.I0(\u5/no_wb_cycle ),
        .I1(\u5/ack_cnt_reg [1]),
        .I2(\ack_cnt[3]_i_3_n_0 ),
        .I3(\u5/ack_cnt_reg [0]),
        .O(\ack_cnt[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT5 #(
    .INIT(32'h14505041)) 
    \ack_cnt[2]_i_1 
       (.I0(\u5/no_wb_cycle ),
        .I1(\u5/ack_cnt_reg [1]),
        .I2(\u5/ack_cnt_reg [2]),
        .I3(\ack_cnt[3]_i_3_n_0 ),
        .I4(\u5/ack_cnt_reg [0]),
        .O(\ack_cnt[2]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hBE)) 
    \ack_cnt[3]_i_1 
       (.I0(\u5/no_wb_cycle ),
        .I1(mem_ack_r_i_2_n_0),
        .I2(dv),
        .O(\ack_cnt[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000000007FFE8001)) 
    \ack_cnt[3]_i_2 
       (.I0(\u5/ack_cnt_reg [2]),
        .I1(\u5/ack_cnt_reg [1]),
        .I2(\ack_cnt[3]_i_3_n_0 ),
        .I3(\u5/ack_cnt_reg [0]),
        .I4(\u5/ack_cnt_reg [3]),
        .I5(\u5/no_wb_cycle ),
        .O(p_0_in__0[3]));
  LUT2 #(
    .INIT(4'h2)) 
    \ack_cnt[3]_i_3 
       (.I0(dv),
        .I1(mem_ack_r_i_2_n_0),
        .O(\ack_cnt[3]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[0]_i_1 
       (.I0(\u1/u0/out_r_reg_n_0_[0] ),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[0]_i_2_n_0 ),
        .O(\acs_addr[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[0]_i_2 
       (.I0(wb_addr_i[2]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[1]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[0]),
        .O(\acs_addr[0]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[10]_i_1 
       (.I0(\u1/u0/out_r_reg_n_0_[10] ),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[10]_i_2_n_0 ),
        .O(\acs_addr[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[10]_i_2 
       (.I0(wb_addr_i[12]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[11]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[10]),
        .O(\acs_addr[10]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[11]_i_1 
       (.I0(\u1/u0/out_r_reg_n_0_[11] ),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[11]_i_2_n_0 ),
        .O(\acs_addr[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[11]_i_2 
       (.I0(wb_addr_i[13]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[12]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[11]),
        .O(\acs_addr[11]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[12]_i_1 
       (.I0(inc_out0[0]),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[12]_i_2_n_0 ),
        .O(\acs_addr[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[12]_i_2 
       (.I0(wb_addr_i[14]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[13]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[12]),
        .O(\acs_addr[12]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[13]_i_1 
       (.I0(inc_out0[1]),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[13]_i_2_n_0 ),
        .O(\acs_addr[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[13]_i_2 
       (.I0(wb_addr_i[15]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[14]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[13]),
        .O(\acs_addr[13]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[14]_i_1 
       (.I0(inc_out0[2]),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[14]_i_2_n_0 ),
        .O(\acs_addr[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[14]_i_2 
       (.I0(wb_addr_i[16]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[15]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[14]),
        .O(\acs_addr[14]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[15]_i_1 
       (.I0(inc_out0[3]),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[15]_i_3_n_0 ),
        .O(\acs_addr[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[15]_i_3 
       (.I0(wb_addr_i[17]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[16]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[15]),
        .O(\acs_addr[15]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acs_addr[15]_i_4 
       (.I0(acs_addr[12]),
        .I1(inc_next),
        .O(\acs_addr[15]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[16]_i_1 
       (.I0(inc_out0[4]),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[16]_i_2_n_0 ),
        .O(\acs_addr[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[16]_i_2 
       (.I0(wb_addr_i[18]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[17]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[16]),
        .O(\acs_addr[16]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[17]_i_1 
       (.I0(inc_out0[5]),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[17]_i_2_n_0 ),
        .O(\acs_addr[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[17]_i_2 
       (.I0(wb_addr_i[19]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[18]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[17]),
        .O(\acs_addr[17]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[18]_i_1 
       (.I0(inc_out0[6]),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[18]_i_2_n_0 ),
        .O(\acs_addr[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[18]_i_2 
       (.I0(wb_addr_i[20]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[19]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[18]),
        .O(\acs_addr[18]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[19]_i_1 
       (.I0(inc_out0[7]),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[19]_i_3_n_0 ),
        .O(\acs_addr[19]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[19]_i_3 
       (.I0(wb_addr_i[21]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[20]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[19]),
        .O(\acs_addr[19]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[1]_i_1 
       (.I0(\u1/u0/out_r_reg_n_0_[1] ),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[1]_i_2_n_0 ),
        .O(\acs_addr[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[1]_i_2 
       (.I0(wb_addr_i[3]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[2]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[1]),
        .O(\acs_addr[1]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[20]_i_1 
       (.I0(inc_out0[8]),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[20]_i_2_n_0 ),
        .O(\acs_addr[20]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[20]_i_2 
       (.I0(wb_addr_i[22]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[21]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[20]),
        .O(\acs_addr[20]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[21]_i_1 
       (.I0(inc_out0[9]),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[21]_i_2_n_0 ),
        .O(\acs_addr[21]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[21]_i_2 
       (.I0(wb_addr_i[23]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[22]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[21]),
        .O(\acs_addr[21]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[22]_i_1 
       (.I0(inc_out0[10]),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[22]_i_2_n_0 ),
        .O(\acs_addr[22]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[22]_i_2 
       (.I0(wb_addr_i[24]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[23]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[22]),
        .O(\acs_addr[22]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h555555D555555555)) 
    \acs_addr[23]_i_1 
       (.I0(\acs_addr[23]_i_3_n_0 ),
        .I1(\acs_addr[23]_i_4_n_0 ),
        .I2(\u5/state [0]),
        .I3(\u5/state [6]),
        .I4(\u5/state [4]),
        .I5(\u5/state [5]),
        .O(\acs_addr[23]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[23]_i_2 
       (.I0(inc_out0[11]),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[23]_i_6_n_0 ),
        .O(\acs_addr[23]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \acs_addr[23]_i_3 
       (.I0(cs_le),
        .I1(wb_we_i),
        .O(\acs_addr[23]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT5 #(
    .INIT(32'h0D003000)) 
    \acs_addr[23]_i_4 
       (.I0(pack_le0_i_3_n_0),
        .I1(\u5/state [1]),
        .I2(\u5/state [3]),
        .I3(\u5/tmr2_done ),
        .I4(\u5/state [2]),
        .O(\acs_addr[23]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[23]_i_6 
       (.I0(wb_addr_i[25]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[24]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[23]),
        .O(\acs_addr[23]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[2]_i_1 
       (.I0(\u1/u0/out_r_reg_n_0_[2] ),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[2]_i_2_n_0 ),
        .O(\acs_addr[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[2]_i_2 
       (.I0(wb_addr_i[4]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[3]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[2]),
        .O(\acs_addr[2]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[3]_i_1 
       (.I0(\u1/u0/out_r_reg_n_0_[3] ),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[3]_i_2_n_0 ),
        .O(\acs_addr[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[3]_i_2 
       (.I0(wb_addr_i[5]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[4]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[3]),
        .O(\acs_addr[3]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[4]_i_1 
       (.I0(\u1/u0/out_r_reg_n_0_[4] ),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[4]_i_2_n_0 ),
        .O(\acs_addr[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[4]_i_2 
       (.I0(wb_addr_i[6]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[5]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[4]),
        .O(\acs_addr[4]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[5]_i_1 
       (.I0(\u1/u0/out_r_reg_n_0_[5] ),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[5]_i_2_n_0 ),
        .O(\acs_addr[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[5]_i_2 
       (.I0(wb_addr_i[7]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[6]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[5]),
        .O(\acs_addr[5]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[6]_i_1 
       (.I0(\u1/u0/out_r_reg_n_0_[6] ),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[6]_i_2_n_0 ),
        .O(\acs_addr[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[6]_i_2 
       (.I0(wb_addr_i[8]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[7]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[6]),
        .O(\acs_addr[6]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[7]_i_1 
       (.I0(\u1/u0/out_r_reg_n_0_[7] ),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[7]_i_2_n_0 ),
        .O(\acs_addr[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[7]_i_2 
       (.I0(wb_addr_i[9]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[8]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[7]),
        .O(\acs_addr[7]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[8]_i_1 
       (.I0(\u1/u0/out_r_reg_n_0_[8] ),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[8]_i_2_n_0 ),
        .O(\acs_addr[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[8]_i_2 
       (.I0(wb_addr_i[10]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[9]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[8]),
        .O(\acs_addr[8]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \acs_addr[9]_i_1 
       (.I0(\u1/u0/out_r_reg_n_0_[9] ),
        .I1(cs_le),
        .I2(wb_we_i),
        .I3(\acs_addr[9]_i_2_n_0 ),
        .O(\acs_addr[9]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \acs_addr[9]_i_2 
       (.I0(wb_addr_i[11]),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[10]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[9]),
        .O(\acs_addr[9]_i_2_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \acs_addr_reg[15]_i_2 
       (.CI(\<const0> ),
        .CO({\acs_addr_reg[15]_i_2_n_0 ,\acs_addr_reg[15]_i_2_n_1 ,\acs_addr_reg[15]_i_2_n_2 ,\acs_addr_reg[15]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,acs_addr[12]}),
        .O(inc_out0[3:0]),
        .S({acs_addr[15:13],\acs_addr[15]_i_4_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \acs_addr_reg[19]_i_2 
       (.CI(\acs_addr_reg[15]_i_2_n_0 ),
        .CO({\acs_addr_reg[19]_i_2_n_0 ,\acs_addr_reg[19]_i_2_n_1 ,\acs_addr_reg[19]_i_2_n_2 ,\acs_addr_reg[19]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(inc_out0[7:4]),
        .S(acs_addr[19:16]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \acs_addr_reg[23]_i_5 
       (.CI(\acs_addr_reg[19]_i_2_n_0 ),
        .CO({\acs_addr_reg[23]_i_5_n_1 ,\acs_addr_reg[23]_i_5_n_2 ,\acs_addr_reg[23]_i_5_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(inc_out0[11:8]),
        .S(acs_addr[23:20]));
  LUT6 #(
    .INIT(64'h0001FFFF00010000)) 
    ap_en_i_1
       (.I0(\timer[1]_i_2_n_0 ),
        .I1(\timer[2]_i_2_n_0 ),
        .I2(\timer[0]_i_3_n_0 ),
        .I3(ap_en_i_2_n_0),
        .I4(\u5/burst_cnt_ld ),
        .I5(\u5/ap_en ),
        .O(ap_en_i_1_n_0));
  LUT6 #(
    .INIT(64'hEEEFEEEE22202222)) 
    ap_en_i_2
       (.I0(csc__0[10]),
        .I1(lmr_ack),
        .I2(\u5/state [6]),
        .I3(\FSM_sequential_state[5]_i_4_n_0 ),
        .I4(\burst_cnt[3]_i_4_n_0 ),
        .I5(sp_csc[10]),
        .O(ap_en_i_2_n_0));
  LUT3 #(
    .INIT(8'h02)) 
    \b0_last_row[12]_i_1 
       (.I0(\b3_last_row[12]_i_2_n_0 ),
        .I1(bank_adr[1]),
        .I2(bank_adr[0]),
        .O(\b0_last_row[12]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h01)) 
    \b0_last_row[12]_i_1__0 
       (.I0(bank_adr[1]),
        .I1(bank_adr[0]),
        .I2(\b3_last_row[12]_i_2__0_n_0 ),
        .O(\u2/bank0_open0 ));
  LUT3 #(
    .INIT(8'h20)) 
    \b1_last_row[12]_i_1 
       (.I0(\b3_last_row[12]_i_2_n_0 ),
        .I1(bank_adr[1]),
        .I2(bank_adr[0]),
        .O(\b1_last_row[12]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \b1_last_row[12]_i_1__0 
       (.I0(bank_adr[1]),
        .I1(bank_adr[0]),
        .I2(\b3_last_row[12]_i_2__0_n_0 ),
        .O(\u2/bank1_open0 ));
  LUT3 #(
    .INIT(8'h20)) 
    \b2_last_row[12]_i_1 
       (.I0(\b3_last_row[12]_i_2_n_0 ),
        .I1(bank_adr[0]),
        .I2(bank_adr[1]),
        .O(\b2_last_row[12]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \b2_last_row[12]_i_1__0 
       (.I0(bank_adr[0]),
        .I1(bank_adr[1]),
        .I2(\b3_last_row[12]_i_2__0_n_0 ),
        .O(\u2/bank2_open0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \b3_last_row[12]_i_1 
       (.I0(\b3_last_row[12]_i_2_n_0 ),
        .I1(bank_adr[1]),
        .I2(bank_adr[0]),
        .O(\b3_last_row[12]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h08)) 
    \b3_last_row[12]_i_1__0 
       (.I0(bank_adr[1]),
        .I1(bank_adr[0]),
        .I2(\b3_last_row[12]_i_2__0_n_0 ),
        .O(\u2/bank3_open0 ));
  LUT6 #(
    .INIT(64'h0040000000000000)) 
    \b3_last_row[12]_i_2 
       (.I0(\mc_cs_[1]_i_2_n_0 ),
        .I1(\b3_last_row[12]_i_3_n_0 ),
        .I2(rfr_ack_r_i_7_n_0),
        .I3(\b3_last_row[12]_i_4_n_0 ),
        .I4(\u5/state [4]),
        .I5(ap_en_i_2_n_0),
        .O(\b3_last_row[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hF7FFFFFFFFFFFFFF)) 
    \b3_last_row[12]_i_2__0 
       (.I0(\b3_last_row[12]_i_3_n_0 ),
        .I1(rfr_ack_r_i_7_n_0),
        .I2(\b3_last_row[12]_i_4_n_0 ),
        .I3(\u5/state [4]),
        .I4(ap_en_i_2_n_0),
        .I5(\mc_cs_[0]_i_2_n_0 ),
        .O(\b3_last_row[12]_i_2__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \b3_last_row[12]_i_3 
       (.I0(\u5/state [1]),
        .I1(\u5/state [0]),
        .O(\b3_last_row[12]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \b3_last_row[12]_i_4 
       (.I0(\u5/state [3]),
        .I1(\u5/state [2]),
        .O(\b3_last_row[12]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0202FFFE02020202)) 
    bank0_open_i_1
       (.I0(\b3_last_row[12]_i_2_n_0 ),
        .I1(bank_adr[1]),
        .I2(bank_adr[0]),
        .I3(bank3_open_i_2__0_n_0),
        .I4(bank3_open_i_3__0_n_0),
        .I5(\u2/u1/bank0_open_reg_n_0 ),
        .O(bank0_open_i_1_n_0));
  LUT6 #(
    .INIT(64'h0101FFEF01010101)) 
    bank0_open_i_1__0
       (.I0(bank_adr[1]),
        .I1(bank_adr[0]),
        .I2(\b3_last_row[12]_i_2__0_n_0 ),
        .I3(bank3_open_i_2_n_0),
        .I4(bank3_open_i_3_n_0),
        .I5(\u2/bank0_open ),
        .O(bank0_open_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h2020FFEF20202020)) 
    bank1_open_i_1
       (.I0(\b3_last_row[12]_i_2_n_0 ),
        .I1(bank_adr[1]),
        .I2(bank_adr[0]),
        .I3(bank3_open_i_2__0_n_0),
        .I4(bank3_open_i_3__0_n_0),
        .I5(\u2/u1/bank1_open_reg_n_0 ),
        .O(bank1_open_i_1_n_0));
  LUT6 #(
    .INIT(64'h0404FFBF04040404)) 
    bank1_open_i_1__0
       (.I0(bank_adr[1]),
        .I1(bank_adr[0]),
        .I2(\b3_last_row[12]_i_2__0_n_0 ),
        .I3(bank3_open_i_2_n_0),
        .I4(bank3_open_i_3_n_0),
        .I5(\u2/bank1_open ),
        .O(bank1_open_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h2020FFEF20202020)) 
    bank2_open_i_1
       (.I0(\b3_last_row[12]_i_2_n_0 ),
        .I1(bank_adr[0]),
        .I2(bank_adr[1]),
        .I3(bank3_open_i_2__0_n_0),
        .I4(bank3_open_i_3__0_n_0),
        .I5(\u2/u1/bank2_open_reg_n_0 ),
        .O(bank2_open_i_1_n_0));
  LUT6 #(
    .INIT(64'h0404FFBF04040404)) 
    bank2_open_i_1__0
       (.I0(bank_adr[0]),
        .I1(bank_adr[1]),
        .I2(\b3_last_row[12]_i_2__0_n_0 ),
        .I3(bank3_open_i_2_n_0),
        .I4(bank3_open_i_3_n_0),
        .I5(\u2/bank2_open ),
        .O(bank2_open_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h8080FFBF80808080)) 
    bank3_open_i_1
       (.I0(\b3_last_row[12]_i_2_n_0 ),
        .I1(bank_adr[1]),
        .I2(bank_adr[0]),
        .I3(bank3_open_i_2__0_n_0),
        .I4(bank3_open_i_3__0_n_0),
        .I5(\u2/u1/bank3_open_reg_n_0 ),
        .O(bank3_open_i_1_n_0));
  LUT6 #(
    .INIT(64'h0808FF7F08080808)) 
    bank3_open_i_1__0
       (.I0(bank_adr[1]),
        .I1(bank_adr[0]),
        .I2(\b3_last_row[12]_i_2__0_n_0 ),
        .I3(bank3_open_i_2_n_0),
        .I4(bank3_open_i_3_n_0),
        .I5(\u2/bank3_open ),
        .O(bank3_open_i_1__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT2 #(
    .INIT(4'hB)) 
    bank3_open_i_2
       (.I0(bank3_open_i_4_n_0),
        .I1(\mc_cs_[0]_i_2_n_0 ),
        .O(bank3_open_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT2 #(
    .INIT(4'hE)) 
    bank3_open_i_2__0
       (.I0(\mc_cs_[1]_i_2_n_0 ),
        .I1(bank3_open_i_4_n_0),
        .O(bank3_open_i_2__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    bank3_open_i_3
       (.I0(rfr_ack),
        .I1(bank3_open_i_5_n_0),
        .I2(\mc_cs_[0]_i_2_n_0 ),
        .O(bank3_open_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT3 #(
    .INIT(8'hAB)) 
    bank3_open_i_3__0
       (.I0(rfr_ack),
        .I1(bank3_open_i_5_n_0),
        .I2(\mc_cs_[1]_i_2_n_0 ),
        .O(bank3_open_i_3__0_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF2EFFFFFF)) 
    bank3_open_i_4
       (.I0(rfr_ack),
        .I1(\u5/state [4]),
        .I2(bank3_open_i_6_n_0),
        .I3(cs_le_i_12_n_0),
        .I4(bank3_open_i_7_n_0),
        .I5(mc_bg_i_4_n_0),
        .O(bank3_open_i_4_n_0));
  LUT6 #(
    .INIT(64'hFEFEABBFFEFFABBF)) 
    bank3_open_i_5
       (.I0(lmr_ack_i_3_n_0),
        .I1(\u5/state [0]),
        .I2(\u5/state [2]),
        .I3(\u5/state [3]),
        .I4(\u5/state [1]),
        .I5(rfr_ack),
        .O(bank3_open_i_5_n_0));
  LUT6 #(
    .INIT(64'h222200202222AA2A)) 
    bank3_open_i_6
       (.I0(\u5/tmr_done ),
        .I1(sp_csc[10]),
        .I2(\burst_cnt[3]_i_4_n_0 ),
        .I3(lmr_ack_i_3_n_0),
        .I4(lmr_ack),
        .I5(csc__0[10]),
        .O(bank3_open_i_6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT2 #(
    .INIT(4'h2)) 
    bank3_open_i_7
       (.I0(\u5/state [1]),
        .I1(\u5/state [5]),
        .O(bank3_open_i_7_n_0));
  LUT5 #(
    .INIT(32'hBABF8A80)) 
    \bank_adr[0]_i_1 
       (.I0(\bank_adr[0]_i_2_n_0 ),
        .I1(csc__0[9]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_csc[9]),
        .I4(\bank_adr[0]_i_3_n_0 ),
        .O(\bank_adr[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAACCAACCF000F0FF)) 
    \bank_adr[0]_i_2 
       (.I0(wb_addr_i[22]),
        .I1(wb_addr_i[21]),
        .I2(wb_addr_i[23]),
        .I3(\bank_adr[1]_i_5_n_0 ),
        .I4(\bank_adr[0]_i_4_n_0 ),
        .I5(\bank_adr[1]_i_4_n_0 ),
        .O(\bank_adr[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFF03FE32FC00CE02)) 
    \bank_adr[0]_i_3 
       (.I0(wb_addr_i[12]),
        .I1(pack_le0_i_3_n_0),
        .I2(\col_adr[9]_i_3_n_0 ),
        .I3(wb_addr_i[10]),
        .I4(pack_le0_i_2_n_0),
        .I5(wb_addr_i[11]),
        .O(\bank_adr[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h01515404FD5D57F7)) 
    \bank_adr[0]_i_4 
       (.I0(wb_addr_i[24]),
        .I1(sp_csc[6]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(csc__0[6]),
        .I4(pack_le0_i_2_n_0),
        .I5(wb_addr_i[25]),
        .O(\bank_adr[0]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hBABF8A80)) 
    \bank_adr[1]_i_1 
       (.I0(\bank_adr[1]_i_2_n_0 ),
        .I1(csc__0[9]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_csc[9]),
        .I4(\bank_adr[1]_i_3_n_0 ),
        .O(\bank_adr[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \bank_adr[1]_i_2 
       (.I0(wb_addr_i[23]),
        .I1(wb_addr_i[22]),
        .I2(\bank_adr[1]_i_4_n_0 ),
        .I3(wb_addr_i[24]),
        .I4(\bank_adr[1]_i_5_n_0 ),
        .I5(\bank_adr[1]_i_6_n_0 ),
        .O(\bank_adr[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFCFECE03003202)) 
    \bank_adr[1]_i_3 
       (.I0(wb_addr_i[13]),
        .I1(pack_le0_i_3_n_0),
        .I2(\col_adr[9]_i_3_n_0 ),
        .I3(wb_addr_i[12]),
        .I4(pack_le0_i_2_n_0),
        .I5(wb_addr_i[11]),
        .O(\bank_adr[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h5555555500044404)) 
    \bank_adr[1]_i_4 
       (.I0(\row_adr[12]_i_5_n_0 ),
        .I1(pack_le0_i_2_n_0),
        .I2(sp_csc[6]),
        .I3(\timer2[6]_i_4_n_0 ),
        .I4(csc__0[6]),
        .I5(pack_le0_i_3_n_0),
        .O(\bank_adr[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF1DE20000FF1D)) 
    \bank_adr[1]_i_5 
       (.I0(sp_csc[6]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(csc__0[6]),
        .I3(pack_le0_i_2_n_0),
        .I4(\row_adr[12]_i_5_n_0 ),
        .I5(pack_le0_i_3_n_0),
        .O(\bank_adr[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFEAEABFB02A2A808)) 
    \bank_adr[1]_i_6 
       (.I0(wb_addr_i[25]),
        .I1(sp_csc[6]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(csc__0[6]),
        .I4(pack_le0_i_2_n_0),
        .I5(wb_addr_i[26]),
        .O(\bank_adr[1]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT4 #(
    .INIT(16'h4F44)) 
    bank_open_i_1
       (.I0(\mc_cs_[1]_i_2_n_0 ),
        .I1(bank_open_i_2_n_0),
        .I2(bank_open_i_3_n_0),
        .I3(\mc_cs_[0]_i_2_n_0 ),
        .O(\u2/bank_open0 ));
  LUT6 #(
    .INIT(64'hCCF0FFAACCF000AA)) 
    bank_open_i_2
       (.I0(\u2/u1/bank0_open_reg_n_0 ),
        .I1(\u2/u1/bank3_open_reg_n_0 ),
        .I2(\u2/u1/bank1_open_reg_n_0 ),
        .I3(bank_adr[1]),
        .I4(bank_adr[0]),
        .I5(\u2/u1/bank2_open_reg_n_0 ),
        .O(bank_open_i_2_n_0));
  LUT6 #(
    .INIT(64'h3355000F3355FF0F)) 
    bank_open_i_3
       (.I0(\u2/bank1_open ),
        .I1(\u2/bank3_open ),
        .I2(\u2/bank0_open ),
        .I3(bank_adr[1]),
        .I4(bank_adr[0]),
        .I5(\u2/bank2_open ),
        .O(bank_open_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT1 #(
    .INIT(2'h1)) 
    burst_act_rd_i_1
       (.I0(burst_act_rd_i_2_n_0),
        .O(\u5/burst_act077_in ));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    burst_act_rd_i_2
       (.I0(\u5/burst_cnt_reg [4]),
        .I1(\burst_cnt[6]_i_2_n_0 ),
        .I2(\u5/burst_cnt_reg [3]),
        .I3(\u5/burst_cnt_reg [9]),
        .I4(\u5/burst_cnt_reg [6]),
        .I5(burst_act_rd_i_3_n_0),
        .O(burst_act_rd_i_2_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    burst_act_rd_i_3
       (.I0(\u5/burst_cnt_reg [10]),
        .I1(\u5/burst_cnt_reg [8]),
        .I2(\u5/burst_cnt_reg [7]),
        .I3(\u5/burst_cnt_reg [5]),
        .O(burst_act_rd_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'h101F)) 
    \burst_cnt[0]_i_1 
       (.I0(\timer[0]_i_3_n_0 ),
        .I1(\timer[1]_i_2_n_0 ),
        .I2(\u5/burst_cnt_ld ),
        .I3(\u5/burst_cnt_reg [0]),
        .O(p_0_in[0]));
  LUT6 #(
    .INIT(64'h0000000000004000)) 
    \burst_cnt[10]_i_1 
       (.I0(\u5/state [6]),
        .I1(\burst_cnt[10]_i_4_n_0 ),
        .I2(\u5/state [5]),
        .I3(\u5/state [3]),
        .I4(\u5/state [0]),
        .I5(\u5/state [1]),
        .O(\u5/burst_cnt_ld_4 ));
  (* SOFT_HLUTNM = "soft_lutpair121" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \burst_cnt[10]_i_10 
       (.I0(\u5/state [4]),
        .I1(\u5/state [3]),
        .O(\burst_cnt[10]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'hFF5C)) 
    \burst_cnt[10]_i_2 
       (.I0(\burst_cnt[10]_i_5_n_0 ),
        .I1(dv),
        .I2(wr_cycle),
        .I3(\u5/burst_cnt_ld ),
        .O(\burst_cnt[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0002FFFF00020000)) 
    \burst_cnt[10]_i_3 
       (.I0(\timer[2]_i_2_n_0 ),
        .I1(\col_adr[9]_i_3_n_0 ),
        .I2(pack_le0_i_3_n_0),
        .I3(pack_le0_i_2_n_0),
        .I4(\u5/burst_cnt_ld ),
        .I5(\burst_cnt[10]_i_7_n_0 ),
        .O(p_0_in[10]));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \burst_cnt[10]_i_4 
       (.I0(\u5/state [4]),
        .I1(\u5/state [2]),
        .O(\burst_cnt[10]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00FE000000FE00FE)) 
    \burst_cnt[10]_i_5 
       (.I0(\u5/state [6]),
        .I1(\u5/state [0]),
        .I2(\burst_cnt[10]_i_8_n_0 ),
        .I3(mem_ack_r_i_4_n_0),
        .I4(mem_ack_r_i_5_n_0),
        .I5(mem_ack_r_i_6_n_0),
        .O(\burst_cnt[10]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \burst_cnt[10]_i_6 
       (.I0(\burst_cnt[10]_i_9_n_0 ),
        .I1(\u5/state [3]),
        .I2(\u5/state [4]),
        .I3(\u5/state [6]),
        .I4(\u5/state [0]),
        .I5(\u5/state [5]),
        .O(\u5/burst_cnt_ld ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAA9AA)) 
    \burst_cnt[10]_i_7 
       (.I0(\u5/burst_cnt_reg [10]),
        .I1(\u5/burst_cnt_reg [9]),
        .I2(\u5/burst_cnt_reg [7]),
        .I3(\burst_cnt[7]_i_2_n_0 ),
        .I4(\u5/burst_cnt_reg [6]),
        .I5(\u5/burst_cnt_reg [8]),
        .O(\burst_cnt[10]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFFF373F)) 
    \burst_cnt[10]_i_8 
       (.I0(\u5/tmr_done ),
        .I1(\burst_cnt[10]_i_10_n_0 ),
        .I2(\u5/state [2]),
        .I3(\u5/state [5]),
        .I4(mem_ack_r_i_9_n_0),
        .I5(mem_ack_r_i_8_n_0),
        .O(\burst_cnt[10]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair114" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \burst_cnt[10]_i_9 
       (.I0(\u5/state [2]),
        .I1(\u5/state [1]),
        .O(\burst_cnt[10]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT5 #(
    .INIT(32'h2F20202F)) 
    \burst_cnt[1]_i_1 
       (.I0(\timer[0]_i_3_n_0 ),
        .I1(\timer[1]_i_2_n_0 ),
        .I2(\u5/burst_cnt_ld ),
        .I3(\u5/burst_cnt_reg [0]),
        .I4(\u5/burst_cnt_reg [1]),
        .O(p_0_in[1]));
  LUT6 #(
    .INIT(64'h0000A9A9FF00A9A9)) 
    \burst_cnt[2]_i_1 
       (.I0(\u5/burst_cnt_reg [2]),
        .I1(\u5/burst_cnt_reg [1]),
        .I2(\u5/burst_cnt_reg [0]),
        .I3(\burst_cnt[3]_i_3_n_0 ),
        .I4(\u5/burst_cnt_ld ),
        .I5(\timer[0]_i_3_n_0 ),
        .O(p_0_in[2]));
  LUT6 #(
    .INIT(64'h000F666600006666)) 
    \burst_cnt[3]_i_1 
       (.I0(\u5/burst_cnt_reg [3]),
        .I1(\burst_cnt[6]_i_2_n_0 ),
        .I2(\timer[2]_i_2_n_0 ),
        .I3(\burst_cnt[3]_i_2_n_0 ),
        .I4(\u5/burst_cnt_ld ),
        .I5(\burst_cnt[3]_i_3_n_0 ),
        .O(p_0_in[3]));
  LUT6 #(
    .INIT(64'h11101111DDDFDDDD)) 
    \burst_cnt[3]_i_2 
       (.I0(\u0/tms_reg_n_0_[0] ),
        .I1(lmr_ack),
        .I2(\u5/state [6]),
        .I3(\FSM_sequential_state[5]_i_4_n_0 ),
        .I4(\burst_cnt[3]_i_4_n_0 ),
        .I5(sp_tms[0]),
        .O(\burst_cnt[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEEEFEEEE22202222)) 
    \burst_cnt[3]_i_3 
       (.I0(\u0/tms_reg_n_0_[1] ),
        .I1(lmr_ack),
        .I2(\u5/state [6]),
        .I3(\FSM_sequential_state[5]_i_4_n_0 ),
        .I4(\burst_cnt[3]_i_4_n_0 ),
        .I5(sp_tms[1]),
        .O(\burst_cnt[3]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT4 #(
    .INIT(16'h0E30)) 
    \burst_cnt[3]_i_4 
       (.I0(\u5/state [0]),
        .I1(\u5/state [1]),
        .I2(\u5/state [3]),
        .I3(\u5/state [2]),
        .O(\burst_cnt[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFFE0001)) 
    \burst_cnt[4]_i_1 
       (.I0(\u5/burst_cnt_reg [2]),
        .I1(\u5/burst_cnt_reg [0]),
        .I2(\u5/burst_cnt_reg [1]),
        .I3(\u5/burst_cnt_reg [3]),
        .I4(\u5/burst_cnt_reg [4]),
        .I5(\u5/burst_cnt_ld ),
        .O(p_0_in[4]));
  LUT5 #(
    .INIT(32'h0000FB04)) 
    \burst_cnt[5]_i_1 
       (.I0(\u5/burst_cnt_reg [3]),
        .I1(\burst_cnt[6]_i_2_n_0 ),
        .I2(\u5/burst_cnt_reg [4]),
        .I3(\u5/burst_cnt_reg [5]),
        .I4(\u5/burst_cnt_ld ),
        .O(p_0_in[5]));
  LUT6 #(
    .INIT(64'h00000000FFFB0004)) 
    \burst_cnt[6]_i_1 
       (.I0(\u5/burst_cnt_reg [4]),
        .I1(\burst_cnt[6]_i_2_n_0 ),
        .I2(\u5/burst_cnt_reg [3]),
        .I3(\u5/burst_cnt_reg [5]),
        .I4(\u5/burst_cnt_reg [6]),
        .I5(\u5/burst_cnt_ld ),
        .O(p_0_in[6]));
  LUT3 #(
    .INIT(8'h01)) 
    \burst_cnt[6]_i_2 
       (.I0(\u5/burst_cnt_reg [1]),
        .I1(\u5/burst_cnt_reg [0]),
        .I2(\u5/burst_cnt_reg [2]),
        .O(\burst_cnt[6]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h00D2)) 
    \burst_cnt[7]_i_1 
       (.I0(\burst_cnt[7]_i_2_n_0 ),
        .I1(\u5/burst_cnt_reg [6]),
        .I2(\u5/burst_cnt_reg [7]),
        .I3(\u5/burst_cnt_ld ),
        .O(p_0_in[7]));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \burst_cnt[7]_i_2 
       (.I0(\u5/burst_cnt_reg [4]),
        .I1(\u5/burst_cnt_reg [2]),
        .I2(\u5/burst_cnt_reg [0]),
        .I3(\u5/burst_cnt_reg [1]),
        .I4(\u5/burst_cnt_reg [3]),
        .I5(\u5/burst_cnt_reg [5]),
        .O(\burst_cnt[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h020002FF02FF0200)) 
    \burst_cnt[8]_i_1 
       (.I0(\timer[2]_i_2_n_0 ),
        .I1(\burst_cnt[8]_i_2_n_0 ),
        .I2(\burst_cnt[8]_i_3_n_0 ),
        .I3(\u5/burst_cnt_ld ),
        .I4(\u5/burst_cnt_reg [8]),
        .I5(\burst_cnt[8]_i_4_n_0 ),
        .O(p_0_in[8]));
  LUT6 #(
    .INIT(64'h5555454555504540)) 
    \burst_cnt[8]_i_2 
       (.I0(pack_le0_i_3_n_0),
        .I1(csc__0[7]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_csc[7]),
        .I4(csc__0[6]),
        .I5(sp_csc[6]),
        .O(\burst_cnt[8]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00053305)) 
    \burst_cnt[8]_i_3 
       (.I0(sp_csc[5]),
        .I1(csc[5]),
        .I2(sp_csc[4]),
        .I3(\timer2[6]_i_4_n_0 ),
        .I4(csc[4]),
        .O(\burst_cnt[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000010)) 
    \burst_cnt[8]_i_4 
       (.I0(\u5/burst_cnt_reg [6]),
        .I1(\u5/burst_cnt_reg [4]),
        .I2(\burst_cnt[6]_i_2_n_0 ),
        .I3(\u5/burst_cnt_reg [3]),
        .I4(\u5/burst_cnt_reg [5]),
        .I5(\u5/burst_cnt_reg [7]),
        .O(\burst_cnt[8]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0828FFFF08280000)) 
    \burst_cnt[9]_i_1 
       (.I0(\timer[2]_i_2_n_0 ),
        .I1(pack_le0_i_2_n_0),
        .I2(\col_adr[9]_i_3_n_0 ),
        .I3(pack_le0_i_3_n_0),
        .I4(\u5/burst_cnt_ld ),
        .I5(\burst_cnt[9]_i_2_n_0 ),
        .O(p_0_in[9]));
  LUT5 #(
    .INIT(32'hAAAAA9AA)) 
    \burst_cnt[9]_i_2 
       (.I0(\u5/burst_cnt_reg [9]),
        .I1(\u5/burst_cnt_reg [8]),
        .I2(\u5/burst_cnt_reg [6]),
        .I3(\burst_cnt[7]_i_2_n_0 ),
        .I4(\u5/burst_cnt_reg [7]),
        .O(\burst_cnt[9]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \byte1[0]_i_1 
       (.I0(mc_data_ir[0]),
        .I1(pack_le1),
        .I2(csc[4]),
        .I3(mc_data_ir[8]),
        .O(\byte1[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \byte1[1]_i_1 
       (.I0(mc_data_ir[1]),
        .I1(pack_le1),
        .I2(csc[4]),
        .I3(mc_data_ir[9]),
        .O(\byte1[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \byte1[2]_i_1 
       (.I0(mc_data_ir[2]),
        .I1(pack_le1),
        .I2(csc[4]),
        .I3(mc_data_ir[10]),
        .O(\byte1[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \byte1[3]_i_1 
       (.I0(mc_data_ir[3]),
        .I1(pack_le1),
        .I2(csc[4]),
        .I3(mc_data_ir[11]),
        .O(\byte1[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \byte1[4]_i_1 
       (.I0(mc_data_ir[4]),
        .I1(pack_le1),
        .I2(csc[4]),
        .I3(mc_data_ir[12]),
        .O(\byte1[4]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \byte1[5]_i_1 
       (.I0(mc_data_ir[5]),
        .I1(pack_le1),
        .I2(csc[4]),
        .I3(mc_data_ir[13]),
        .O(\byte1[5]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \byte1[6]_i_1 
       (.I0(mc_data_ir[6]),
        .I1(pack_le1),
        .I2(csc[4]),
        .I3(mc_data_ir[14]),
        .O(\byte1[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2320)) 
    \byte1[7]_i_1 
       (.I0(pack_le0),
        .I1(csc[5]),
        .I2(csc[4]),
        .I3(pack_le1),
        .O(\byte1[7]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \byte1[7]_i_2 
       (.I0(mc_data_ir[7]),
        .I1(pack_le1),
        .I2(csc[4]),
        .I3(mc_data_ir[15]),
        .O(\byte1[7]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h8A888A8A)) 
    cke__i_1
       (.I0(\u5/cke_r ),
        .I1(cke__i_2_n_0),
        .I2(\u5/state [6]),
        .I3(cke__i_3_n_0),
        .I4(cke__i_4_n_0),
        .O(\u5/cke_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    cke__i_2
       (.I0(\u5/state [1]),
        .I1(\u5/state [5]),
        .I2(\u5/state [2]),
        .I3(\u5/state [4]),
        .I4(\u5/state [3]),
        .O(cke__i_2_n_0));
  LUT6 #(
    .INIT(64'hFBFFFFFFFFFFFFFB)) 
    cke__i_3
       (.I0(\u5/state [5]),
        .I1(\u5/state [4]),
        .I2(\u5/state [2]),
        .I3(\u5/state [3]),
        .I4(\u5/state [1]),
        .I5(\u5/state [0]),
        .O(cke__i_3_n_0));
  LUT6 #(
    .INIT(64'h755555557FFFFFFF)) 
    cke__i_4
       (.I0(\u5/state [3]),
        .I1(mc_adv__i_3_n_0),
        .I2(cke__i_5_n_0),
        .I3(wb_cycle),
        .I4(\u5/cnt ),
        .I5(mc_cke_pad_o_),
        .O(cke__i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT5 #(
    .INIT(32'h55545555)) 
    cke__i_5
       (.I0(burst_act_rd_i_2_n_0),
        .I1(\burst_cnt[3]_i_3_n_0 ),
        .I2(\timer2[6]_i_3_n_0 ),
        .I3(\mc_addr[2]_i_4_n_0 ),
        .I4(\burst_cnt[3]_i_2_n_0 ),
        .O(cke__i_5_n_0));
  LUT6 #(
    .INIT(64'hFFFF3735FFFF0405)) 
    cke_r_i_1
       (.I0(cke_r_i_2_n_0),
        .I1(cke_r_i_3_n_0),
        .I2(\u5/state [6]),
        .I3(cke_r_i_4_n_0),
        .I4(cke__i_2_n_0),
        .I5(\u5/cke_r ),
        .O(cke_r_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000003101000)) 
    cke_r_i_2
       (.I0(mc_adv__i_3_n_0),
        .I1(\u5/state [5]),
        .I2(\u5/state [4]),
        .I3(\u5/state [2]),
        .I4(\u5/state [3]),
        .I5(cke_r_i_5_n_0),
        .O(cke_r_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT5 #(
    .INIT(32'h11111000)) 
    cke_r_i_3
       (.I0(\u5/state [6]),
        .I1(\u5/cnt ),
        .I2(cke__i_5_n_0),
        .I3(wb_cycle),
        .I4(\u5/state [3]),
        .O(cke_r_i_3_n_0));
  LUT6 #(
    .INIT(64'h0400000000000008)) 
    cke_r_i_4
       (.I0(\u5/state [3]),
        .I1(\u5/state [4]),
        .I2(\u5/state [5]),
        .I3(\u5/state [2]),
        .I4(\u5/state [1]),
        .I5(\u5/state [0]),
        .O(cke_r_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT3 #(
    .INIT(8'h7E)) 
    cke_r_i_5
       (.I0(\u5/state [0]),
        .I1(\u5/state [1]),
        .I2(\u5/state [2]),
        .O(cke_r_i_5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT1 #(
    .INIT(2'h1)) 
    cmd_a10_r_i_1
       (.I0(cmd_a10_r_i_2_n_0),
        .O(cmd_a10));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAA8AA)) 
    cmd_a10_r_i_10
       (.I0(\u5/state [6]),
        .I1(\u5/state [1]),
        .I2(\u5/state [5]),
        .I3(\FSM_sequential_state[1]_i_13_n_0 ),
        .I4(\u5/state [3]),
        .I5(\u5/state [0]),
        .O(cmd_a10_r_i_10_n_0));
  LUT6 #(
    .INIT(64'h000000000000000D)) 
    cmd_a10_r_i_11
       (.I0(\u5/ap_en ),
        .I1(\b3_last_row[12]_i_3_n_0 ),
        .I2(rfr_ack),
        .I3(\u5/state [3]),
        .I4(\u5/state [2]),
        .I5(\u5/state [5]),
        .O(cmd_a10_r_i_11_n_0));
  LUT6 #(
    .INIT(64'h0A0A0B0A0A0B0A0A)) 
    cmd_a10_r_i_12
       (.I0(\u5/ap_en ),
        .I1(\u5/state [5]),
        .I2(\u5/state [4]),
        .I3(\u5/state [2]),
        .I4(\u5/state [1]),
        .I5(\u5/state [0]),
        .O(cmd_a10_r_i_12_n_0));
  LUT6 #(
    .INIT(64'h00000000DDDDFFFD)) 
    cmd_a10_r_i_2
       (.I0(\u5/state [4]),
        .I1(\u5/state [6]),
        .I2(cmd_a10_r_i_3_n_0),
        .I3(cmd_a10_r_i_4_n_0),
        .I4(cmd_a10_r_i_5_n_0),
        .I5(cmd_a10_r_i_6_n_0),
        .O(cmd_a10_r_i_2_n_0));
  LUT6 #(
    .INIT(64'h5555555555555455)) 
    cmd_a10_r_i_3
       (.I0(\u5/ap_en ),
        .I1(\b3_last_row[12]_i_4_n_0 ),
        .I2(\u5/state [5]),
        .I3(\u5/state [1]),
        .I4(ap_en_i_2_n_0),
        .I5(\cmd_r[0]_i_5_n_0 ),
        .O(cmd_a10_r_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT5 #(
    .INIT(32'h10110100)) 
    cmd_a10_r_i_4
       (.I0(\u5/state [0]),
        .I1(\u5/state [5]),
        .I2(\u5/state [1]),
        .I3(\u5/state [3]),
        .I4(\u5/state [2]),
        .O(cmd_a10_r_i_4_n_0));
  LUT6 #(
    .INIT(64'h00000000EEEEEEEF)) 
    cmd_a10_r_i_5
       (.I0(\u5/ap_en ),
        .I1(cmd_a10_r_i_7_n_0),
        .I2(\cmd_r[0]_i_5_n_0 ),
        .I3(ap_en_i_2_n_0),
        .I4(cmd_a10_r_i_8_n_0),
        .I5(cmd_a10_r_i_9_n_0),
        .O(cmd_a10_r_i_5_n_0));
  LUT6 #(
    .INIT(64'h040004FF04000400)) 
    cmd_a10_r_i_6
       (.I0(\FSM_sequential_state[2]_i_16_n_0 ),
        .I1(\u5/cmd_a10_r ),
        .I2(rfr_ack_r_i_5_n_0),
        .I3(cmd_a10_r_i_10_n_0),
        .I4(cmd_a10_r_i_11_n_0),
        .I5(cmd_a10_r_i_12_n_0),
        .O(cmd_a10_r_i_6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair118" *) 
  LUT2 #(
    .INIT(4'h8)) 
    cmd_a10_r_i_7
       (.I0(\u5/state [2]),
        .I1(\u5/state [3]),
        .O(cmd_a10_r_i_7_n_0));
  LUT6 #(
    .INIT(64'h000000000F2FFF2F)) 
    cmd_a10_r_i_8
       (.I0(wb_cyc_i),
        .I1(wb_stb_i),
        .I2(wb_write_go),
        .I3(\u5/state [1]),
        .I4(\u5/tmr_done ),
        .I5(mc_adv__i_2_n_0),
        .O(cmd_a10_r_i_8_n_0));
  LUT6 #(
    .INIT(64'hF7FFBBBB3333FFFF)) 
    cmd_a10_r_i_9
       (.I0(\u5/state [1]),
        .I1(\timer[2]_i_17_n_0 ),
        .I2(bank3_open_i_6_n_0),
        .I3(\u5/cmd_a10_r ),
        .I4(\u5/state [2]),
        .I5(\u5/state [3]),
        .O(cmd_a10_r_i_9_n_0));
  LUT6 #(
    .INIT(64'h5555005155555555)) 
    cmd_asserted_i_1
       (.I0(\u5/state [6]),
        .I1(cmd_asserted_i_2_n_0),
        .I2(cmd_asserted_i_3_n_0),
        .I3(\u5/state [5]),
        .I4(cmd_asserted_i_4_n_0),
        .I5(\mc_cs_[1]_i_3_n_0 ),
        .O(cmd_asserted_i_1_n_0));
  LUT5 #(
    .INIT(32'hFFFACCFA)) 
    cmd_asserted_i_10
       (.I0(sp_tms[16]),
        .I1(\u0/tms_reg_n_0_[16] ),
        .I2(sp_tms[17]),
        .I3(\timer2[6]_i_4_n_0 ),
        .I4(\u0/tms_reg_n_0_[17] ),
        .O(cmd_asserted_i_10_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFDD0D)) 
    cmd_asserted_i_2
       (.I0(oe__i_3_n_0),
        .I1(cmd_asserted_i_5_n_0),
        .I2(\u5/state [1]),
        .I3(\u5/state [0]),
        .I4(\u5/state [4]),
        .I5(\u5/state [2]),
        .O(cmd_asserted_i_2_n_0));
  LUT6 #(
    .INIT(64'hFAFAAFBAAAAAFAAA)) 
    cmd_asserted_i_3
       (.I0(cmd_asserted_i_6_n_0),
        .I1(\u5/wb_wait_r ),
        .I2(\u5/state [2]),
        .I3(\u5/state [3]),
        .I4(\u5/state [1]),
        .I5(\u5/state [0]),
        .O(cmd_asserted_i_3_n_0));
  LUT6 #(
    .INIT(64'hDDDDDDDD5555555D)) 
    cmd_asserted_i_4
       (.I0(rfr_ack_r_i_3_n_0),
        .I1(\u5/state [5]),
        .I2(cmd_asserted_i_7_n_0),
        .I3(\u5/state [1]),
        .I4(\u5/state [4]),
        .I5(cmd_asserted_i_8_n_0),
        .O(cmd_asserted_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'hFF4FFFFF)) 
    cmd_asserted_i_5
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(wb_write_go),
        .I2(\mc_addr[14]_i_4_n_0 ),
        .I3(\u5/state [1]),
        .I4(\u5/state [0]),
        .O(cmd_asserted_i_5_n_0));
  LUT6 #(
    .INIT(64'h22F0000000F00000)) 
    cmd_asserted_i_6
       (.I0(\u5/tmr_done ),
        .I1(ap_en_i_2_n_0),
        .I2(\u5/state [0]),
        .I3(\u5/state [3]),
        .I4(cmd_asserted_i_9_n_0),
        .I5(\u5/state [2]),
        .O(cmd_asserted_i_6_n_0));
  LUT6 #(
    .INIT(64'h0002220200000000)) 
    cmd_asserted_i_7
       (.I0(\timer2[3]_i_4_n_0 ),
        .I1(cmd_asserted_i_10_n_0),
        .I2(sp_tms[18]),
        .I3(\timer2[6]_i_4_n_0 ),
        .I4(\u0/tms_reg_n_0_[18] ),
        .I5(\u5/state [0]),
        .O(cmd_asserted_i_7_n_0));
  LUT6 #(
    .INIT(64'h000FF00A0551FAA2)) 
    cmd_asserted_i_8
       (.I0(\u5/state [2]),
        .I1(\u5/tmr_done ),
        .I2(\u5/state [3]),
        .I3(\u5/state [0]),
        .I4(\u5/state [4]),
        .I5(\u5/state [1]),
        .O(cmd_asserted_i_8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h8)) 
    cmd_asserted_i_9
       (.I0(\u5/state [1]),
        .I1(\u5/state [4]),
        .O(cmd_asserted_i_9_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF01000000)) 
    \cmd_r[0]_i_1 
       (.I0(\u5/state [2]),
        .I1(\u5/state [1]),
        .I2(\u5/state [6]),
        .I3(\cmd_r[0]_i_2_n_0 ),
        .I4(\cmd_r[0]_i_3_n_0 ),
        .I5(\cmd_r[0]_i_4_n_0 ),
        .O(\u5/cmd [0]));
  LUT6 #(
    .INIT(64'h00FFFFFFFFFF08FF)) 
    \cmd_r[0]_i_10 
       (.I0(\u5/state [3]),
        .I1(\u5/tmr_done ),
        .I2(ap_en_i_2_n_0),
        .I3(cmd_asserted_i_9_n_0),
        .I4(\u5/state [5]),
        .I5(\u5/state [0]),
        .O(\cmd_r[0]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h00CC00CC330F0008)) 
    \cmd_r[0]_i_11 
       (.I0(\u5/tmr_done ),
        .I1(\u5/state [4]),
        .I2(\u5/state [3]),
        .I3(\u5/state [1]),
        .I4(\u5/state [2]),
        .I5(\u5/state [0]),
        .O(\cmd_r[0]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h007A0000FFFA0000)) 
    \cmd_r[0]_i_12 
       (.I0(\u5/state [5]),
        .I1(\u5/state [3]),
        .I2(\u5/state [0]),
        .I3(\u5/state [4]),
        .I4(\u5/state [1]),
        .I5(\u5/state [2]),
        .O(\cmd_r[0]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h003F003000002203)) 
    \cmd_r[0]_i_13 
       (.I0(\FSM_sequential_state[1]_i_13_n_0 ),
        .I1(\u5/state [1]),
        .I2(\u5/state [0]),
        .I3(\u5/state [6]),
        .I4(\u5/state [3]),
        .I5(\u5/state [5]),
        .O(\cmd_r[0]_i_13_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \cmd_r[0]_i_2 
       (.I0(\u5/state [3]),
        .I1(\u5/state [0]),
        .O(\cmd_r[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCCC8FFFBFFFFFFFF)) 
    \cmd_r[0]_i_3 
       (.I0(\u5/wb_write_go_r ),
        .I1(\cmd_r[0]_i_5_n_0 ),
        .I2(burst_act_rd_i_2_n_0),
        .I3(\cmd_r[0]_i_6_n_0 ),
        .I4(wb_cycle),
        .I5(\u5/state [4]),
        .O(\cmd_r[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFDF0000)) 
    \cmd_r[0]_i_4 
       (.I0(\FSM_sequential_state[5]_i_8_n_0 ),
        .I1(data_oe_r_i_7_n_0),
        .I2(\cmd_r[0]_i_7_n_0 ),
        .I3(\cmd_r[0]_i_8_n_0 ),
        .I4(cke__i_2_n_0),
        .I5(\cmd_r[0]_i_9_n_0 ),
        .O(\cmd_r[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFFDDDFD)) 
    \cmd_r[0]_i_5 
       (.I0(\burst_cnt[3]_i_2_n_0 ),
        .I1(\burst_cnt[3]_i_3_n_0 ),
        .I2(sp_tms[2]),
        .I3(\timer2[6]_i_4_n_0 ),
        .I4(\u0/tms_reg_n_0_[2] ),
        .I5(\mc_addr[9]_i_4_n_0 ),
        .O(\cmd_r[0]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT4 #(
    .INIT(16'h3533)) 
    \cmd_r[0]_i_6 
       (.I0(mc_adv__i_3_n_0),
        .I1(\u5/cke_r ),
        .I2(\u5/cnt ),
        .I3(\cmd_r[0]_i_5_n_0 ),
        .O(\cmd_r[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h000080800A008A80)) 
    \cmd_r[0]_i_7 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(csc[1]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_csc[1]),
        .I4(csc[3]),
        .I5(sp_csc[3]),
        .O(\cmd_r[0]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \cmd_r[0]_i_8 
       (.I0(\mc_cs_[0]_i_2_n_0 ),
        .I1(\mc_cs_[1]_i_2_n_0 ),
        .I2(\u5/lookup_ready2 ),
        .O(\cmd_r[0]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF00FD)) 
    \cmd_r[0]_i_9 
       (.I0(\cmd_r[0]_i_10_n_0 ),
        .I1(\cmd_r[0]_i_11_n_0 ),
        .I2(\cmd_r[0]_i_12_n_0 ),
        .I3(\u5/state [6]),
        .I4(\cmd_r[0]_i_13_n_0 ),
        .O(\cmd_r[0]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAFFFFBBAB)) 
    \cmd_r[1]_i_1 
       (.I0(cke__i_2_n_0),
        .I1(\cmd_r[1]_i_2_n_0 ),
        .I2(\cmd_r[1]_i_3_n_0 ),
        .I3(\cmd_r[1]_i_4_n_0 ),
        .I4(\cmd_r[1]_i_5_n_0 ),
        .I5(\u5/state [6]),
        .O(\u5/cmd [1]));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \cmd_r[1]_i_2 
       (.I0(\u5/state [0]),
        .I1(\u5/state [1]),
        .I2(\u5/state [2]),
        .O(\cmd_r[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \cmd_r[1]_i_3 
       (.I0(\u5/state [4]),
        .I1(\u5/state [1]),
        .O(\cmd_r[1]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h5455FFFF)) 
    \cmd_r[1]_i_4 
       (.I0(\mc_addr[9]_i_4_n_0 ),
        .I1(\mc_addr[2]_i_4_n_0 ),
        .I2(\burst_cnt[3]_i_3_n_0 ),
        .I3(\burst_cnt[3]_i_2_n_0 ),
        .I4(wb_cycle),
        .O(\cmd_r[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFF3FCF3F2F3FCFF)) 
    \cmd_r[1]_i_5 
       (.I0(\u5/state [0]),
        .I1(\u5/state [1]),
        .I2(\u5/state [5]),
        .I3(\u5/state [3]),
        .I4(\u5/state [2]),
        .I5(\u5/state [4]),
        .O(\cmd_r[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAFFFFAAAE)) 
    \cmd_r[2]_i_1 
       (.I0(cke__i_2_n_0),
        .I1(\u5/state [3]),
        .I2(\u5/state [0]),
        .I3(\cmd_r[2]_i_2_n_0 ),
        .I4(\cmd_r[2]_i_3_n_0 ),
        .I5(\u5/state [6]),
        .O(\u5/cmd [2]));
  LUT6 #(
    .INIT(64'h02A2FFFFFFFF0000)) 
    \cmd_r[2]_i_2 
       (.I0(\u5/tmr_done ),
        .I1(sp_csc[10]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(csc__0[10]),
        .I4(\u5/state [2]),
        .I5(\u5/state [1]),
        .O(\cmd_r[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF4022)) 
    \cmd_r[2]_i_3 
       (.I0(\u5/state [2]),
        .I1(\u5/state [0]),
        .I2(\u5/state [1]),
        .I3(\u5/state [3]),
        .I4(\cmd_r[2]_i_4_n_0 ),
        .I5(\u5/state [5]),
        .O(\cmd_r[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h9F609F609F609360)) 
    \cmd_r[2]_i_4 
       (.I0(\u5/state [0]),
        .I1(\u5/state [2]),
        .I2(\u5/state [1]),
        .I3(\u5/state [4]),
        .I4(\u5/wb_wait_r ),
        .I5(\u5/state [3]),
        .O(\cmd_r[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000008800000002)) 
    cnt_i_1
       (.I0(cnt_i_2_n_0),
        .I1(\u5/state [0]),
        .I2(\u5/state [2]),
        .I3(\u5/state [6]),
        .I4(\u5/cnt ),
        .I5(\u5/state [1]),
        .O(\u5/cnt_next ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT4 #(
    .INIT(16'h0440)) 
    cnt_i_2
       (.I0(\u5/state [5]),
        .I1(\u5/state [4]),
        .I2(\u5/state [3]),
        .I3(\u5/state [2]),
        .O(cnt_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT4 #(
    .INIT(16'h0222)) 
    \col_adr[8]_i_1 
       (.I0(wb_addr_i[10]),
        .I1(pack_le0_i_3_n_0),
        .I2(\col_adr[9]_i_3_n_0 ),
        .I3(pack_le0_i_2_n_0),
        .O(\u1/col_adr [8]));
  LUT3 #(
    .INIT(8'hB8)) 
    \col_adr[9]_i_1 
       (.I0(mem_ack_r),
        .I1(wr_cycle),
        .I2(wb_stb_i),
        .O(\col_adr[9]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT4 #(
    .INIT(16'h0010)) 
    \col_adr[9]_i_2 
       (.I0(\col_adr[9]_i_3_n_0 ),
        .I1(pack_le0_i_3_n_0),
        .I2(wb_addr_i[11]),
        .I3(pack_le0_i_2_n_0),
        .O(\u1/col_adr [9]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT5 #(
    .INIT(32'h00053305)) 
    \col_adr[9]_i_3 
       (.I0(sp_csc[6]),
        .I1(csc__0[6]),
        .I2(sp_csc[7]),
        .I3(\timer2[6]_i_4_n_0 ),
        .I4(csc__0[7]),
        .O(\col_adr[9]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT5 #(
    .INIT(32'h07FF0700)) 
    \cs[0]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(cs_le),
        .I4(cs[0]),
        .O(\cs[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0000FF51)) 
    cs_le_i_1
       (.I0(cs_le_i_2_n_0),
        .I1(cs_le_i_3_n_0),
        .I2(cs_le_i_4_n_0),
        .I3(cs_le_i_5_n_0),
        .I4(\FSM_sequential_state[2]_i_4_n_0 ),
        .I5(cs_le_i_6_n_0),
        .O(cs_le_d));
  LUT6 #(
    .INIT(64'h55CF55FF55FF55FF)) 
    cs_le_i_10
       (.I0(\FSM_sequential_state[2]_i_21_n_0 ),
        .I1(\u5/p_65_in ),
        .I2(cs_le_i_14_n_0),
        .I3(\u5/state [5]),
        .I4(ap_en_i_2_n_0),
        .I5(\u5/tmr_done ),
        .O(cs_le_i_10_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    cs_le_i_11
       (.I0(mc_adv__i_3_n_0),
        .I1(\u5/state [4]),
        .O(cs_le_i_11_n_0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h1)) 
    cs_le_i_12
       (.I0(\u5/state [0]),
        .I1(\u5/state [6]),
        .O(cs_le_i_12_n_0));
  LUT6 #(
    .INIT(64'h8000000088888888)) 
    cs_le_i_13
       (.I0(\u5/state [6]),
        .I1(cke__i_2_n_0),
        .I2(mc_adv__i_3_n_0),
        .I3(wb_cycle),
        .I4(\u5/tmr_done ),
        .I5(\u5/state [0]),
        .O(cs_le_i_13_n_0));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'h80)) 
    cs_le_i_14
       (.I0(\u5/state [1]),
        .I1(\u5/state [2]),
        .I2(\u5/state [3]),
        .O(cs_le_i_14_n_0));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'hFEFFFFFE)) 
    cs_le_i_2
       (.I0(\u5/state [3]),
        .I1(\u5/state [2]),
        .I2(\u5/state [5]),
        .I3(\u5/state [4]),
        .I4(\u5/state [1]),
        .O(cs_le_i_2_n_0));
  LUT6 #(
    .INIT(64'hEAEEEAEEEEEEEAEE)) 
    cs_le_i_3
       (.I0(rfr_req),
        .I1(\FSM_sequential_state[5]_i_8_n_0 ),
        .I2(\FSM_sequential_state[5]_i_9_n_0 ),
        .I3(cs_le_i_7_n_0),
        .I4(wb_cyc_i),
        .I5(wb_stb_i),
        .O(cs_le_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT2 #(
    .INIT(4'hE)) 
    cs_le_i_4
       (.I0(\u5/state [1]),
        .I1(\u5/wb_stb_first_reg_n_0 ),
        .O(cs_le_i_4_n_0));
  LUT6 #(
    .INIT(64'hF000F080F0000000)) 
    cs_le_i_5
       (.I0(\u5/tmr2_done ),
        .I1(mc_adv__i_3_n_0),
        .I2(wb_ack_o_i_9_n_0),
        .I3(\u5/state [3]),
        .I4(\u5/state [1]),
        .I5(wb_cycle),
        .O(cs_le_i_5_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF8F880000)) 
    cs_le_i_6
       (.I0(cs_le_i_8_n_0),
        .I1(cs_le_i_9_n_0),
        .I2(cs_le_i_10_n_0),
        .I3(cs_le_i_11_n_0),
        .I4(cs_le_i_12_n_0),
        .I5(cs_le_i_13_n_0),
        .O(cs_le_i_6_n_0));
  LUT5 #(
    .INIT(32'hFFFACCFA)) 
    cs_le_i_7
       (.I0(sp_csc[2]),
        .I1(csc[2]),
        .I2(sp_csc[1]),
        .I3(\timer2[6]_i_4_n_0 ),
        .I4(csc[1]),
        .O(cs_le_i_7_n_0));
  (* SOFT_HLUTNM = "soft_lutpair113" *) 
  LUT2 #(
    .INIT(4'h2)) 
    cs_le_i_8
       (.I0(\u5/state [2]),
        .I1(\u5/state [1]),
        .O(cs_le_i_8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT3 #(
    .INIT(8'h01)) 
    cs_le_i_9
       (.I0(\u5/state [3]),
        .I1(\u5/state [4]),
        .I2(\u5/state [5]),
        .O(cs_le_i_9_n_0));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT4 #(
    .INIT(16'hEFE0)) 
    \csc[0]_i_1 
       (.I0(poc_o[3]),
        .I1(poc_o[2]),
        .I2(\u0/rst_r2 ),
        .I3(wb_data_i[0]),
        .O(\csc[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \csc[10]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(\u0/u0/csc_reg_n_0_[10] ),
        .I4(\u0/u1/csc_reg_n_0_[10] ),
        .I5(\u0/sel0 ),
        .O(\csc[10]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \csc[11]_i_1 
       (.I0(cs_le_d),
        .I1(wb_cyc_i),
        .I2(wb_stb_i),
        .O(\csc[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h48FF4848FF484848)) 
    \csc[11]_i_10 
       (.I0(wb_addr_i[21]),
        .I1(\u0/csc_mask [0]),
        .I2(\u0/u1/csc_reg_n_0_[16] ),
        .I3(wb_addr_i[22]),
        .I4(\u0/csc_mask [1]),
        .I5(\u0/u1/csc_reg_n_0_[17] ),
        .O(\csc[11]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF60FF)) 
    \csc[11]_i_11 
       (.I0(\u0/u1/csc_reg_n_0_[23] ),
        .I1(wb_addr_i[28]),
        .I2(\u0/csc_mask [7]),
        .I3(\u0/u1/csc_reg_n_0_[0] ),
        .I4(\csc[11]_i_12_n_0 ),
        .I5(\csc[11]_i_13_n_0 ),
        .O(\csc[11]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h4848FF48FF484848)) 
    \csc[11]_i_12 
       (.I0(wb_addr_i[24]),
        .I1(\u0/csc_mask [3]),
        .I2(\u0/u1/csc_reg_n_0_[19] ),
        .I3(\u0/csc_mask [4]),
        .I4(wb_addr_i[25]),
        .I5(\u0/u1/csc_reg_n_0_[20] ),
        .O(\csc[11]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h4848FF48FF484848)) 
    \csc[11]_i_13 
       (.I0(wb_addr_i[23]),
        .I1(\u0/csc_mask [2]),
        .I2(\u0/u1/csc_reg_n_0_[18] ),
        .I3(\u0/csc_mask [6]),
        .I4(wb_addr_i[27]),
        .I5(\u0/u1/csc_reg_n_0_[22] ),
        .O(\csc[11]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \csc[11]_i_2 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(\u0/u0/csc_reg_n_0_[11] ),
        .I4(\u0/u1/csc_reg_n_0_[11] ),
        .I5(\u0/sel0 ),
        .O(\csc[11]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFBEAA)) 
    \csc[11]_i_3 
       (.I0(\csc[11]_i_5_n_0 ),
        .I1(wb_addr_i[24]),
        .I2(\u0/u0/csc_reg_n_0_[19] ),
        .I3(\u0/csc_mask [3]),
        .I4(\csc[11]_i_6_n_0 ),
        .O(\csc[11]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h07)) 
    \csc[11]_i_4 
       (.I0(wb_we_i),
        .I1(\u0/u1/csc_reg_n_0_[8] ),
        .I2(\csc[11]_i_7_n_0 ),
        .O(\u0/sel0 ));
  LUT6 #(
    .INIT(64'h2828FF28FF282828)) 
    \csc[11]_i_5 
       (.I0(\u0/csc_mask [0]),
        .I1(\u0/u0/csc_reg_n_0_[16] ),
        .I2(wb_addr_i[21]),
        .I3(\u0/csc_mask [1]),
        .I4(\u0/u0/csc_reg_n_0_[17] ),
        .I5(wb_addr_i[22]),
        .O(\csc[11]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF7D55)) 
    \csc[11]_i_6 
       (.I0(\u0/u0/csc_reg_n_0_[0] ),
        .I1(wb_addr_i[28]),
        .I2(\u0/u0/csc_reg_n_0_[23] ),
        .I3(\u0/csc_mask [7]),
        .I4(\csc[11]_i_8_n_0 ),
        .I5(\csc[11]_i_9_n_0 ),
        .O(\csc[11]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFBEAA)) 
    \csc[11]_i_7 
       (.I0(\csc[11]_i_10_n_0 ),
        .I1(\u0/u1/csc_reg_n_0_[21] ),
        .I2(wb_addr_i[26]),
        .I3(\u0/csc_mask [5]),
        .I4(\csc[11]_i_11_n_0 ),
        .O(\csc[11]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h2828FF28FF282828)) 
    \csc[11]_i_8 
       (.I0(\u0/csc_mask [2]),
        .I1(\u0/u0/csc_reg_n_0_[18] ),
        .I2(wb_addr_i[23]),
        .I3(\u0/csc_mask [6]),
        .I4(\u0/u0/csc_reg_n_0_[22] ),
        .I5(wb_addr_i[27]),
        .O(\csc[11]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h2828FF28FF282828)) 
    \csc[11]_i_9 
       (.I0(\u0/csc_mask [4]),
        .I1(\u0/u0/csc_reg_n_0_[20] ),
        .I2(wb_addr_i[25]),
        .I3(\u0/csc_mask [5]),
        .I4(\u0/u0/csc_reg_n_0_[21] ),
        .I5(wb_addr_i[26]),
        .O(\csc[11]_i_9_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \csc[1]_i_1 
       (.I0(poc_o[2]),
        .I1(\u0/rst_r2 ),
        .I2(wb_data_i[1]),
        .O(\csc[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \csc[1]_i_1__0 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(\u0/u0/csc_reg_n_0_[1] ),
        .I4(\u0/u1/csc_reg_n_0_[1] ),
        .I5(\u0/sel0 ),
        .O(\csc[1]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \csc[2]_i_1 
       (.I0(poc_o[3]),
        .I1(\u0/rst_r2 ),
        .I2(wb_data_i[2]),
        .O(\csc[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \csc[2]_i_1__0 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(\u0/u0/csc_reg_n_0_[2] ),
        .I4(\u0/u1/csc_reg_n_0_[2] ),
        .I5(\u0/sel0 ),
        .O(\csc[2]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000004000000000)) 
    \csc[31]_i_1 
       (.I0(\u0/p_0_in1_in ),
        .I1(\u0/rf_we ),
        .I2(\u0/p_0_in [0]),
        .I3(\u0/p_0_in [2]),
        .I4(\u0/p_0_in [3]),
        .I5(\u0/p_0_in [1]),
        .O(\csc[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \csc[3]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(\u0/u0/csc_reg_n_0_[3] ),
        .I4(\u0/u1/csc_reg_n_0_[3] ),
        .I5(\u0/sel0 ),
        .O(\csc[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \csc[4]_i_1 
       (.I0(poc_o[0]),
        .I1(\u0/rst_r2 ),
        .I2(wb_data_i[4]),
        .O(\csc[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \csc[4]_i_1__0 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(\u0/u0/csc_reg_n_0_[4] ),
        .I4(\u0/u1/csc_reg_n_0_[4] ),
        .I5(\u0/sel0 ),
        .O(\csc[4]_i_1__0_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \csc[5]_i_1 
       (.I0(\u0/rst_r2 ),
        .I1(init_req_we_i_1_n_0),
        .O(\csc[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \csc[5]_i_1__0 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(\u0/u0/csc_reg_n_0_[5] ),
        .I4(\u0/u1/csc_reg_n_0_[5] ),
        .I5(\u0/sel0 ),
        .O(\csc[5]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \csc[5]_i_2 
       (.I0(poc_o[1]),
        .I1(\u0/rst_r2 ),
        .I2(wb_data_i[5]),
        .O(\csc[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \csc[6]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(\u0/u0/csc_reg_n_0_[6] ),
        .I4(\u0/u1/csc_reg_n_0_[6] ),
        .I5(\u0/sel0 ),
        .O(\csc[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \csc[7]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(\u0/u0/csc_reg_n_0_[7] ),
        .I4(\u0/u1/csc_reg_n_0_[7] ),
        .I5(\u0/sel0 ),
        .O(\csc[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \csc[9]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(\u0/u0/csc_reg_n_0_[9] ),
        .I4(\u0/u1/csc_reg_n_0_[9] ),
        .I5(\u0/sel0 ),
        .O(\csc[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000008)) 
    \csc_mask_r[10]_i_1 
       (.I0(\u0/p_0_in [0]),
        .I1(\u0/rf_we ),
        .I2(\u0/p_0_in1_in ),
        .I3(\u0/p_0_in [1]),
        .I4(\u0/p_0_in [3]),
        .I5(\u0/p_0_in [2]),
        .O(\u0/csc_mask_r0 ));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    \csr_r[1]_i_1 
       (.I0(\u0/p_0_in [0]),
        .I1(\u0/rf_we ),
        .I2(\u0/p_0_in1_in ),
        .I3(\u0/p_0_in [1]),
        .I4(\u0/p_0_in [3]),
        .I5(\u0/p_0_in [2]),
        .O(\u0/csr_r20 ));
  LUT6 #(
    .INIT(64'h8888888B8B8B888B)) 
    data_oe_i_1
       (.I0(\u5/data_oe_r2 ),
        .I1(wr_cycle),
        .I2(\u5/state [6]),
        .I3(data_oe_i_2_n_0),
        .I4(\u5/state [1]),
        .I5(data_oe_r_i_4_n_0),
        .O(data_oe_i_1_n_0));
  LUT6 #(
    .INIT(64'hBBB8BBB8B8B8BBB8)) 
    data_oe_i_2
       (.I0(data_oe_r_i_3_n_0),
        .I1(\u5/state [3]),
        .I2(data_oe_r_i_5_n_0),
        .I3(mc_c_oe_i_5_n_0),
        .I4(data_oe_i_3_n_0),
        .I5(data_oe_r_i_6_n_0),
        .O(data_oe_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT4 #(
    .INIT(16'h0800)) 
    data_oe_i_3
       (.I0(wb_write_go),
        .I1(\FSM_sequential_state[5]_i_8_n_0 ),
        .I2(\u5/state [4]),
        .I3(\u5/state [0]),
        .O(data_oe_i_3_n_0));
  LUT6 #(
    .INIT(64'h0000015155550151)) 
    data_oe_r_i_1
       (.I0(\u5/state [6]),
        .I1(data_oe_r_i_2_n_0),
        .I2(\u5/state [3]),
        .I3(data_oe_r_i_3_n_0),
        .I4(\u5/state [1]),
        .I5(data_oe_r_i_4_n_0),
        .O(data_oe_r_i_1_n_0));
  LUT6 #(
    .INIT(64'hEEEEEEEEEAEEEEEE)) 
    data_oe_r_i_2
       (.I0(data_oe_r_i_5_n_0),
        .I1(mc_c_oe_i_5_n_0),
        .I2(\FSM_sequential_state[6]_i_21_n_0 ),
        .I3(\FSM_sequential_state[5]_i_8_n_0 ),
        .I4(wb_write_go),
        .I5(data_oe_r_i_6_n_0),
        .O(data_oe_r_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'hFEFF)) 
    data_oe_r_i_3
       (.I0(\u5/state [0]),
        .I1(\u5/state [5]),
        .I2(\u5/state [2]),
        .I3(\u5/state [4]),
        .O(data_oe_r_i_3_n_0));
  LUT6 #(
    .INIT(64'hFD7F77FFF57F77FF)) 
    data_oe_r_i_4
       (.I0(\u5/state [2]),
        .I1(\u5/state [0]),
        .I2(\u5/state [3]),
        .I3(\u5/state [4]),
        .I4(\u5/state [5]),
        .I5(data_oe_r_i_7_n_0),
        .O(data_oe_r_i_4_n_0));
  LUT6 #(
    .INIT(64'hFCFCF8FCFCCCC8CC)) 
    data_oe_r_i_5
       (.I0(data_oe_r_i_7_n_0),
        .I1(\u5/state [2]),
        .I2(\u5/state [5]),
        .I3(\u5/state [4]),
        .I4(\u5/state [0]),
        .I5(cmd_asserted_i_7_n_0),
        .O(data_oe_r_i_5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'hABABFFAB)) 
    data_oe_r_i_6
       (.I0(\FSM_sequential_state[5]_i_9_n_0 ),
        .I1(\mc_addr[23]_i_3_n_0 ),
        .I2(\mc_addr[14]_i_4_n_0 ),
        .I3(wb_cyc_i),
        .I4(wb_stb_i),
        .O(data_oe_r_i_6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    data_oe_r_i_7
       (.I0(wb_stb_i),
        .I1(wb_cyc_i),
        .I2(wb_write_go),
        .O(data_oe_r_i_7_n_0));
  LUT6 #(
    .INIT(64'h00000000FFFF0040)) 
    dv_r_i_1
       (.I0(\u5/state [0]),
        .I1(\u5/state [5]),
        .I2(\u5/mc_adv_r ),
        .I3(\u5/dv_r ),
        .I4(dv_r_i_2_n_0),
        .I5(dv_r_i_3_n_0),
        .O(dv));
  LUT6 #(
    .INIT(64'h0000400000000000)) 
    dv_r_i_2
       (.I0(\u5/state [5]),
        .I1(\u5/state [0]),
        .I2(wb_cycle),
        .I3(\u5/cke_o_del ),
        .I4(\u5/cnt ),
        .I5(\u5/burst_act_rd ),
        .O(dv_r_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT5 #(
    .INIT(32'hFFFFF7FF)) 
    dv_r_i_3
       (.I0(\u5/state [1]),
        .I1(\u5/state [3]),
        .I2(\u5/state [6]),
        .I3(\u5/state [4]),
        .I4(\u5/state [2]),
        .O(dv_r_i_3_n_0));
  LUT6 #(
    .INIT(64'h0000000000002624)) 
    init_ack_r_i_1
       (.I0(\u5/state [2]),
        .I1(\u5/state [3]),
        .I2(\u5/state [1]),
        .I3(\u5/state [0]),
        .I4(\FSM_sequential_state[5]_i_4_n_0 ),
        .I5(\u5/state [6]),
        .O(init_ack));
  LUT2 #(
    .INIT(4'hE)) 
    init_req_i_1
       (.I0(\u0/u1/init_req_reg_n_0 ),
        .I1(\u0/u0/init_req_reg_n_0 ),
        .O(\u0/init_req01_out ));
  LUT6 #(
    .INIT(64'hBFBBBBBB0F000000)) 
    init_req_i_1__0
       (.I0(init_req_i_2_n_0),
        .I1(spec_req_cs[0]),
        .I2(\u0/inited ),
        .I3(\u0/init_req_we ),
        .I4(rfr_en_i_2_n_0),
        .I5(\u0/u0/init_req_reg_n_0 ),
        .O(init_req_i_1__0_n_0));
  LUT6 #(
    .INIT(64'hBFBBBBBB0F000000)) 
    init_req_i_1__1
       (.I0(init_req_i_2_n_0),
        .I1(spec_req_cs[1]),
        .I2(\u0/u1/inited_reg_n_0 ),
        .I3(\u0/u1/init_req_we_reg_n_0 ),
        .I4(init_req_i_2__0_n_0),
        .I5(\u0/u1/init_req_reg_n_0 ),
        .O(init_req_i_1__1_n_0));
  LUT6 #(
    .INIT(64'h00540500FFFFFFFF)) 
    init_req_i_2
       (.I0(lmr_ack_i_3_n_0),
        .I1(\u5/state [0]),
        .I2(\u5/state [1]),
        .I3(\u5/state [3]),
        .I4(\u5/state [2]),
        .I5(\u0/init_ack_r ),
        .O(init_req_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT4 #(
    .INIT(16'h0002)) 
    init_req_i_2__0
       (.I0(\u0/u1/csc_reg_n_0_[0] ),
        .I1(\u0/u1/csc_reg_n_0_[1] ),
        .I2(\u0/u1/csc_reg_n_0_[3] ),
        .I3(\u0/u1/csc_reg_n_0_[2] ),
        .O(init_req_i_2__0_n_0));
  LUT6 #(
    .INIT(64'h0000000400000000)) 
    init_req_we_i_1
       (.I0(\u0/p_0_in1_in ),
        .I1(\u0/rf_we ),
        .I2(\u0/p_0_in [0]),
        .I3(\u0/p_0_in [2]),
        .I4(\u0/p_0_in [3]),
        .I5(\u0/p_0_in [1]),
        .O(init_req_we_i_1_n_0));
  LUT4 #(
    .INIT(16'hFF40)) 
    inited_i_1
       (.I0(init_ack),
        .I1(\u0/init_ack_r ),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/inited_reg_n_0 ),
        .O(inited_i_1_n_0));
  LUT4 #(
    .INIT(16'hFF40)) 
    inited_i_1__0
       (.I0(init_ack),
        .I1(\u0/init_ack_r ),
        .I2(spec_req_cs[0]),
        .I3(\u0/inited ),
        .O(inited_i_1__0_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    \ir_cnt[0]_i_1 
       (.I0(\u5/ir_cnt_reg [0]),
        .O(ir_cnt0[0]));
  LUT2 #(
    .INIT(4'h9)) 
    \ir_cnt[1]_i_1 
       (.I0(\u5/ir_cnt_reg [0]),
        .I1(\u5/ir_cnt_reg [1]),
        .O(\ir_cnt[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT3 #(
    .INIT(8'hA9)) 
    \ir_cnt[2]_i_1 
       (.I0(\u5/ir_cnt_reg [2]),
        .I1(\u5/ir_cnt_reg [1]),
        .I2(\u5/ir_cnt_reg [0]),
        .O(ir_cnt0[2]));
  LUT6 #(
    .INIT(64'h0000000000080000)) 
    \ir_cnt[3]_i_1 
       (.I0(\FSM_sequential_state[4]_i_6_n_0 ),
        .I1(\u5/state [0]),
        .I2(\u5/state [5]),
        .I3(\u5/state [4]),
        .I4(\u5/state [2]),
        .I5(\u5/state [1]),
        .O(\u5/ir_cnt_ld ));
  LUT5 #(
    .INIT(32'h00800000)) 
    \ir_cnt[3]_i_2 
       (.I0(\ir_cnt[3]_i_4_n_0 ),
        .I1(\u5/state [2]),
        .I2(\u5/state [1]),
        .I3(\u5/state [4]),
        .I4(\u5/cmd_asserted ),
        .O(\u5/ir_cnt_dec ));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT4 #(
    .INIT(16'hAAA9)) 
    \ir_cnt[3]_i_3 
       (.I0(\u5/ir_cnt_reg [3]),
        .I1(\u5/ir_cnt_reg [2]),
        .I2(\u5/ir_cnt_reg [0]),
        .I3(\u5/ir_cnt_reg [1]),
        .O(ir_cnt0[3]));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \ir_cnt[3]_i_4 
       (.I0(\u5/state [5]),
        .I1(\u5/state [0]),
        .I2(\u5/state [6]),
        .I3(\u5/state [3]),
        .O(\ir_cnt[3]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    ir_cnt_done_i_1
       (.I0(\u5/ir_cnt_reg [2]),
        .I1(\u5/ir_cnt_reg [0]),
        .I2(\u5/ir_cnt_reg [1]),
        .I3(\u5/ir_cnt_reg [3]),
        .O(ir_cnt_done_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000000004148)) 
    lmr_ack_i_1
       (.I0(\u5/state [2]),
        .I1(\u5/state [3]),
        .I2(\u5/state [1]),
        .I3(\u5/state [0]),
        .I4(lmr_ack_i_2_n_0),
        .I5(lmr_ack_i_3_n_0),
        .O(\u5/lmr_ack_d ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT5 #(
    .INIT(32'h54555555)) 
    lmr_ack_i_2
       (.I0(\u5/state [3]),
        .I1(rfr_req),
        .I2(init_req),
        .I3(\u5/lookup_ready2 ),
        .I4(lmr_req),
        .O(lmr_ack_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    lmr_ack_i_3
       (.I0(\u5/state [6]),
        .I1(\u5/state [4]),
        .I2(\u5/state [5]),
        .O(lmr_ack_i_3_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    lmr_req_i_1
       (.I0(\u0/u1/lmr_req_reg_n_0 ),
        .I1(\u0/u0/lmr_req_reg_n_0 ),
        .O(\u0/lmr_req00_out ));
  LUT6 #(
    .INIT(64'hBBBB8BBB88888888)) 
    lmr_req_i_1__0
       (.I0(\u0/u1/inited_reg_n_0 ),
        .I1(lmr_req_i_2__0_n_0),
        .I2(spec_req_cs[1]),
        .I3(\u0/lmr_ack_r ),
        .I4(lmr_ack),
        .I5(\u0/u1/lmr_req_reg_n_0 ),
        .O(lmr_req_i_1__0_n_0));
  LUT6 #(
    .INIT(64'hBB8BBBBB88888888)) 
    lmr_req_i_1__1
       (.I0(\u0/inited ),
        .I1(lmr_req_i_2_n_0),
        .I2(\u0/lmr_ack_r ),
        .I3(lmr_ack),
        .I4(spec_req_cs[0]),
        .I5(\u0/u0/lmr_req_reg_n_0 ),
        .O(lmr_req_i_1__1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT4 #(
    .INIT(16'h0002)) 
    lmr_req_i_2
       (.I0(\u0/lmr_req_we ),
        .I1(\u0/u0/csc_reg_n_0_[1] ),
        .I2(\u0/u0/csc_reg_n_0_[3] ),
        .I3(\u0/u0/csc_reg_n_0_[2] ),
        .O(lmr_req_i_2_n_0));
  LUT4 #(
    .INIT(16'h0002)) 
    lmr_req_i_2__0
       (.I0(\u0/u1/lmr_req_we_reg_n_0 ),
        .I1(\u0/u1/csc_reg_n_0_[1] ),
        .I2(\u0/u1/csc_reg_n_0_[3] ),
        .I3(\u0/u1/csc_reg_n_0_[2] ),
        .O(lmr_req_i_2__0_n_0));
  LUT6 #(
    .INIT(64'h0000000800000000)) 
    lmr_req_we_i_1
       (.I0(\u0/p_0_in1_in ),
        .I1(\u0/rf_we ),
        .I2(\u0/p_0_in [0]),
        .I3(\u0/p_0_in [2]),
        .I4(\u0/p_0_in [3]),
        .I5(\u0/p_0_in [1]),
        .O(\u0/tms0 ));
  LUT6 #(
    .INIT(64'h0000008000000000)) 
    lmr_req_we_i_1__0
       (.I0(\u0/p_0_in1_in ),
        .I1(\u0/rf_we ),
        .I2(\u0/p_0_in [0]),
        .I3(\u0/p_0_in [2]),
        .I4(\u0/p_0_in [3]),
        .I5(\u0/p_0_in [1]),
        .O(lmr_req_we_i_1__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'h80)) 
    lookup_ready1_i_1
       (.I0(cs_le),
        .I1(wb_cyc_i),
        .I2(wb_stb_i),
        .O(\u5/lookup_ready10 ));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT3 #(
    .INIT(8'h80)) 
    lookup_ready2_i_1
       (.I0(\u5/lookup_ready1 ),
        .I1(wb_cyc_i),
        .I2(wb_stb_i),
        .O(\u5/lookup_ready20 ));
  LUT5 #(
    .INIT(32'h8D8DFF00)) 
    \mc_addr[0]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[0]),
        .I2(\mc_addr[0]_i_2_n_0 ),
        .I3(\mc_addr[0]_i_3_n_0 ),
        .I4(\mc_addr[23]_i_4_n_0 ),
        .O(mc_addr_d[0]));
  LUT5 #(
    .INIT(32'h8B888BBB)) 
    \mc_addr[0]_i_2 
       (.I0(\burst_cnt[3]_i_2_n_0 ),
        .I1(\mc_addr[12]_i_4_n_0 ),
        .I2(row_adr[0]),
        .I3(\mc_addr[12]_i_5_n_0 ),
        .I4(col_adr[0]),
        .O(\mc_addr[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[0]_i_3 
       (.I0(sram_addr[0]),
        .I1(\mc_addr[23]_i_2_n_0 ),
        .I2(wb_addr_i[2]),
        .O(\mc_addr[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFEFEBABABAFEBAFE)) 
    \mc_addr[10]_i_1 
       (.I0(rfr_ack),
        .I1(\mc_addr[23]_i_4_n_0 ),
        .I2(\mc_addr[10]_i_2_n_0 ),
        .I3(\mc_addr[10]_i_3_n_0 ),
        .I4(acs_addr[10]),
        .I5(\mc_addr[23]_i_3_n_0 ),
        .O(mc_addr_d[10]));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[10]_i_2 
       (.I0(sram_addr[10]),
        .I1(\mc_addr[23]_i_2_n_0 ),
        .I2(wb_addr_i[12]),
        .O(\mc_addr[10]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h47774744)) 
    \mc_addr[10]_i_3 
       (.I0(\mc_addr[10]_i_4_n_0 ),
        .I1(\mc_addr[12]_i_4_n_0 ),
        .I2(row_adr[10]),
        .I3(\mc_addr[12]_i_5_n_0 ),
        .I4(cmd_a10_r_i_2_n_0),
        .O(\mc_addr[10]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[10]_i_4 
       (.I0(\u0/tms_reg_n_0_[10] ),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_tms[10]),
        .O(\mc_addr[10]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h0000D5F7)) 
    \mc_addr[11]_i_1 
       (.I0(\mc_addr[23]_i_4_n_0 ),
        .I1(\mc_addr[23]_i_3_n_0 ),
        .I2(acs_addr[11]),
        .I3(\mc_addr[11]_i_2_n_0 ),
        .I4(\mc_addr[11]_i_3_n_0 ),
        .O(mc_addr_d[11]));
  LUT6 #(
    .INIT(64'h1D001DFF1DFF1DFF)) 
    \mc_addr[11]_i_2 
       (.I0(sp_tms[11]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(\u0/tms_reg_n_0_[11] ),
        .I3(\mc_addr[12]_i_4_n_0 ),
        .I4(row_adr[11]),
        .I5(\mc_addr[12]_i_5_n_0 ),
        .O(\mc_addr[11]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0053)) 
    \mc_addr[11]_i_3 
       (.I0(sram_addr[11]),
        .I1(wb_addr_i[13]),
        .I2(\mc_addr[23]_i_2_n_0 ),
        .I3(\mc_addr[23]_i_4_n_0 ),
        .O(\mc_addr[11]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h0000D5F7)) 
    \mc_addr[12]_i_1 
       (.I0(\mc_addr[23]_i_4_n_0 ),
        .I1(\mc_addr[23]_i_3_n_0 ),
        .I2(acs_addr[12]),
        .I3(\mc_addr[12]_i_2_n_0 ),
        .I4(\mc_addr[12]_i_3_n_0 ),
        .O(mc_addr_d[12]));
  LUT6 #(
    .INIT(64'h1D001DFF1DFF1DFF)) 
    \mc_addr[12]_i_2 
       (.I0(sp_tms[12]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(\u0/tms_reg_n_0_[12] ),
        .I3(\mc_addr[12]_i_4_n_0 ),
        .I4(row_adr[12]),
        .I5(\mc_addr[12]_i_5_n_0 ),
        .O(\mc_addr[12]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0053)) 
    \mc_addr[12]_i_3 
       (.I0(sram_addr[12]),
        .I1(wb_addr_i[14]),
        .I2(\mc_addr[23]_i_2_n_0 ),
        .I3(\mc_addr[23]_i_4_n_0 ),
        .O(\mc_addr[12]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT4 #(
    .INIT(16'h0151)) 
    \mc_addr[12]_i_4 
       (.I0(\timer2[6]_i_4_n_0 ),
        .I1(\u5/cmd [1]),
        .I2(wr_cycle),
        .I3(\u5/cmd_del [1]),
        .O(\mc_addr[12]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000340000000000)) 
    \mc_addr[12]_i_5 
       (.I0(\u5/wb_wait_r ),
        .I1(\u5/state [0]),
        .I2(\u5/state [1]),
        .I3(rfr_ack_r_i_7_n_0),
        .I4(\b3_last_row[12]_i_4_n_0 ),
        .I5(\u5/state [4]),
        .O(\mc_addr[12]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hCDC8CDCDCDC8C8C8)) 
    \mc_addr[13]_i_1 
       (.I0(\mc_addr[14]_i_2_n_0 ),
        .I1(\mc_addr[13]_i_2_n_0 ),
        .I2(\mc_addr[14]_i_4_n_0 ),
        .I3(acs_addr[13]),
        .I4(\mc_addr[23]_i_3_n_0 ),
        .I5(bank_adr[0]),
        .O(mc_addr_d[13]));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[13]_i_2 
       (.I0(sram_addr[13]),
        .I1(\mc_addr[23]_i_2_n_0 ),
        .I2(wb_addr_i[15]),
        .O(\mc_addr[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCDC8CDCDCDC8C8C8)) 
    \mc_addr[14]_i_1 
       (.I0(\mc_addr[14]_i_2_n_0 ),
        .I1(\mc_addr[14]_i_3_n_0 ),
        .I2(\mc_addr[14]_i_4_n_0 ),
        .I3(acs_addr[14]),
        .I4(\mc_addr[23]_i_3_n_0 ),
        .I5(bank_adr[1]),
        .O(mc_addr_d[14]));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[14]_i_2 
       (.I0(csc[3]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_csc[3]),
        .O(\mc_addr[14]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[14]_i_3 
       (.I0(sram_addr[14]),
        .I1(\mc_addr[23]_i_2_n_0 ),
        .I2(wb_addr_i[16]),
        .O(\mc_addr[14]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[14]_i_4 
       (.I0(csc[1]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_csc[1]),
        .O(\mc_addr[14]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h8F808F8F8F808080)) 
    \mc_addr[15]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[15]),
        .I2(\mc_addr[23]_i_4_n_0 ),
        .I3(sram_addr[15]),
        .I4(\mc_addr[23]_i_2_n_0 ),
        .I5(wb_addr_i[17]),
        .O(mc_addr_d[15]));
  LUT6 #(
    .INIT(64'h8F808F8F8F808080)) 
    \mc_addr[16]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[16]),
        .I2(\mc_addr[23]_i_4_n_0 ),
        .I3(sram_addr[16]),
        .I4(\mc_addr[23]_i_2_n_0 ),
        .I5(wb_addr_i[18]),
        .O(mc_addr_d[16]));
  LUT6 #(
    .INIT(64'h8F808F8F8F808080)) 
    \mc_addr[17]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[17]),
        .I2(\mc_addr[23]_i_4_n_0 ),
        .I3(sram_addr[17]),
        .I4(\mc_addr[23]_i_2_n_0 ),
        .I5(wb_addr_i[19]),
        .O(mc_addr_d[17]));
  LUT6 #(
    .INIT(64'h8F808F8F8F808080)) 
    \mc_addr[18]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[18]),
        .I2(\mc_addr[23]_i_4_n_0 ),
        .I3(sram_addr[18]),
        .I4(\mc_addr[23]_i_2_n_0 ),
        .I5(wb_addr_i[20]),
        .O(mc_addr_d[18]));
  LUT6 #(
    .INIT(64'h8F808F8F8F808080)) 
    \mc_addr[19]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[19]),
        .I2(\mc_addr[23]_i_4_n_0 ),
        .I3(sram_addr[19]),
        .I4(\mc_addr[23]_i_2_n_0 ),
        .I5(wb_addr_i[21]),
        .O(mc_addr_d[19]));
  LUT5 #(
    .INIT(32'h8D8DFF00)) 
    \mc_addr[1]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[1]),
        .I2(\mc_addr[1]_i_2_n_0 ),
        .I3(\mc_addr[1]_i_3_n_0 ),
        .I4(\mc_addr[23]_i_4_n_0 ),
        .O(mc_addr_d[1]));
  LUT5 #(
    .INIT(32'h5555303F)) 
    \mc_addr[1]_i_2 
       (.I0(\burst_cnt[3]_i_3_n_0 ),
        .I1(row_adr[1]),
        .I2(\mc_addr[12]_i_5_n_0 ),
        .I3(col_adr[1]),
        .I4(\mc_addr[12]_i_4_n_0 ),
        .O(\mc_addr[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[1]_i_3 
       (.I0(sram_addr[1]),
        .I1(\mc_addr[23]_i_2_n_0 ),
        .I2(wb_addr_i[3]),
        .O(\mc_addr[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h8F808F8F8F808080)) 
    \mc_addr[20]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[20]),
        .I2(\mc_addr[23]_i_4_n_0 ),
        .I3(sram_addr[20]),
        .I4(\mc_addr[23]_i_2_n_0 ),
        .I5(wb_addr_i[22]),
        .O(mc_addr_d[20]));
  LUT6 #(
    .INIT(64'h8F808F8F8F808080)) 
    \mc_addr[21]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[21]),
        .I2(\mc_addr[23]_i_4_n_0 ),
        .I3(sram_addr[21]),
        .I4(\mc_addr[23]_i_2_n_0 ),
        .I5(wb_addr_i[23]),
        .O(mc_addr_d[21]));
  LUT6 #(
    .INIT(64'hFF00B8B80000B8B8)) 
    \mc_addr[22]_i_1 
       (.I0(sram_addr[22]),
        .I1(\mc_addr[23]_i_2_n_0 ),
        .I2(wb_addr_i[24]),
        .I3(\mc_addr[23]_i_3_n_0 ),
        .I4(\mc_addr[23]_i_4_n_0 ),
        .I5(acs_addr[22]),
        .O(mc_addr_d[22]));
  LUT6 #(
    .INIT(64'hFF000000B8B8B8B8)) 
    \mc_addr[23]_i_1 
       (.I0(sram_addr[23]),
        .I1(\mc_addr[23]_i_2_n_0 ),
        .I2(wb_addr_i[25]),
        .I3(acs_addr[23]),
        .I4(\mc_addr[23]_i_3_n_0 ),
        .I5(\mc_addr[23]_i_4_n_0 ),
        .O(mc_addr_d[23]));
  LUT6 #(
    .INIT(64'h0000000002A20000)) 
    \mc_addr[23]_i_2 
       (.I0(wr_hold),
        .I1(sp_csc[3]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(csc[3]),
        .I4(\mc_addr[14]_i_4_n_0 ),
        .I5(\mc_addr[23]_i_3_n_0 ),
        .O(\mc_addr[23]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[23]_i_3 
       (.I0(csc[2]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_csc[2]),
        .O(\mc_addr[23]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT5 #(
    .INIT(32'h00053305)) 
    \mc_addr[23]_i_4 
       (.I0(sp_csc[1]),
        .I1(csc[1]),
        .I2(sp_csc[3]),
        .I3(\timer2[6]_i_4_n_0 ),
        .I4(csc[3]),
        .O(\mc_addr[23]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h8D8DFF00)) 
    \mc_addr[2]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[2]),
        .I2(\mc_addr[2]_i_2_n_0 ),
        .I3(\mc_addr[2]_i_3_n_0 ),
        .I4(\mc_addr[23]_i_4_n_0 ),
        .O(mc_addr_d[2]));
  LUT5 #(
    .INIT(32'h00FF4747)) 
    \mc_addr[2]_i_2 
       (.I0(row_adr[2]),
        .I1(\mc_addr[12]_i_5_n_0 ),
        .I2(col_adr[2]),
        .I3(\mc_addr[2]_i_4_n_0 ),
        .I4(\mc_addr[12]_i_4_n_0 ),
        .O(\mc_addr[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[2]_i_3 
       (.I0(sram_addr[2]),
        .I1(\mc_addr[23]_i_2_n_0 ),
        .I2(wb_addr_i[4]),
        .O(\mc_addr[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hEEEFEEEE22202222)) 
    \mc_addr[2]_i_4 
       (.I0(\u0/tms_reg_n_0_[2] ),
        .I1(lmr_ack),
        .I2(\u5/state [6]),
        .I3(\FSM_sequential_state[5]_i_4_n_0 ),
        .I4(\burst_cnt[3]_i_4_n_0 ),
        .I5(sp_tms[2]),
        .O(\mc_addr[2]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hD8D8FF00)) 
    \mc_addr[3]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[3]),
        .I2(\mc_addr[3]_i_2_n_0 ),
        .I3(\mc_addr[3]_i_3_n_0 ),
        .I4(\mc_addr[23]_i_4_n_0 ),
        .O(mc_addr_d[3]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \mc_addr[3]_i_2 
       (.I0(\mc_addr[3]_i_4_n_0 ),
        .I1(\mc_addr[12]_i_4_n_0 ),
        .I2(row_adr[3]),
        .I3(\mc_addr[12]_i_5_n_0 ),
        .I4(col_adr[3]),
        .O(\mc_addr[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[3]_i_3 
       (.I0(sram_addr[3]),
        .I1(\mc_addr[23]_i_2_n_0 ),
        .I2(wb_addr_i[5]),
        .O(\mc_addr[3]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[3]_i_4 
       (.I0(\u0/tms_reg_n_0_[3] ),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_tms[3]),
        .O(\mc_addr[3]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h8D8DFF00)) 
    \mc_addr[4]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[4]),
        .I2(\mc_addr[4]_i_2_n_0 ),
        .I3(\mc_addr[4]_i_3_n_0 ),
        .I4(\mc_addr[23]_i_4_n_0 ),
        .O(mc_addr_d[4]));
  LUT5 #(
    .INIT(32'h47444777)) 
    \mc_addr[4]_i_2 
       (.I0(\mc_addr[4]_i_4_n_0 ),
        .I1(\mc_addr[12]_i_4_n_0 ),
        .I2(row_adr[4]),
        .I3(\mc_addr[12]_i_5_n_0 ),
        .I4(col_adr[4]),
        .O(\mc_addr[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[4]_i_3 
       (.I0(sram_addr[4]),
        .I1(\mc_addr[23]_i_2_n_0 ),
        .I2(wb_addr_i[6]),
        .O(\mc_addr[4]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[4]_i_4 
       (.I0(\u0/tms_reg_n_0_[4] ),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_tms[4]),
        .O(\mc_addr[4]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hD8D8FF00)) 
    \mc_addr[5]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[5]),
        .I2(\mc_addr[5]_i_2_n_0 ),
        .I3(\mc_addr[5]_i_3_n_0 ),
        .I4(\mc_addr[23]_i_4_n_0 ),
        .O(mc_addr_d[5]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \mc_addr[5]_i_2 
       (.I0(\mc_addr[5]_i_4_n_0 ),
        .I1(\mc_addr[12]_i_4_n_0 ),
        .I2(row_adr[5]),
        .I3(\mc_addr[12]_i_5_n_0 ),
        .I4(col_adr[5]),
        .O(\mc_addr[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[5]_i_3 
       (.I0(sram_addr[5]),
        .I1(\mc_addr[23]_i_2_n_0 ),
        .I2(wb_addr_i[7]),
        .O(\mc_addr[5]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[5]_i_4 
       (.I0(\u0/tms_reg_n_0_[5] ),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_tms[5]),
        .O(\mc_addr[5]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hD8D8FF00)) 
    \mc_addr[6]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[6]),
        .I2(\mc_addr[6]_i_2_n_0 ),
        .I3(\mc_addr[6]_i_3_n_0 ),
        .I4(\mc_addr[23]_i_4_n_0 ),
        .O(mc_addr_d[6]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \mc_addr[6]_i_2 
       (.I0(\mc_addr[6]_i_4_n_0 ),
        .I1(\mc_addr[12]_i_4_n_0 ),
        .I2(row_adr[6]),
        .I3(\mc_addr[12]_i_5_n_0 ),
        .I4(col_adr[6]),
        .O(\mc_addr[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[6]_i_3 
       (.I0(sram_addr[6]),
        .I1(\mc_addr[23]_i_2_n_0 ),
        .I2(wb_addr_i[8]),
        .O(\mc_addr[6]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[6]_i_4 
       (.I0(\u0/tms_reg_n_0_[6] ),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_tms[6]),
        .O(\mc_addr[6]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h8D8DFF00)) 
    \mc_addr[7]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[7]),
        .I2(\mc_addr[7]_i_2_n_0 ),
        .I3(\mc_addr[7]_i_3_n_0 ),
        .I4(\mc_addr[23]_i_4_n_0 ),
        .O(mc_addr_d[7]));
  LUT5 #(
    .INIT(32'h47444777)) 
    \mc_addr[7]_i_2 
       (.I0(\mc_addr[7]_i_4_n_0 ),
        .I1(\mc_addr[12]_i_4_n_0 ),
        .I2(row_adr[7]),
        .I3(\mc_addr[12]_i_5_n_0 ),
        .I4(col_adr[7]),
        .O(\mc_addr[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[7]_i_3 
       (.I0(sram_addr[7]),
        .I1(\mc_addr[23]_i_2_n_0 ),
        .I2(wb_addr_i[9]),
        .O(\mc_addr[7]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[7]_i_4 
       (.I0(\u0/tms_reg_n_0_[7] ),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_tms[7]),
        .O(\mc_addr[7]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hD8D8FF00)) 
    \mc_addr[8]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[8]),
        .I2(\mc_addr[8]_i_2_n_0 ),
        .I3(\mc_addr[8]_i_3_n_0 ),
        .I4(\mc_addr[23]_i_4_n_0 ),
        .O(mc_addr_d[8]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \mc_addr[8]_i_2 
       (.I0(\mc_addr[8]_i_4_n_0 ),
        .I1(\mc_addr[12]_i_4_n_0 ),
        .I2(row_adr[8]),
        .I3(\mc_addr[12]_i_5_n_0 ),
        .I4(col_adr[8]),
        .O(\mc_addr[8]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[8]_i_3 
       (.I0(sram_addr[8]),
        .I1(\mc_addr[23]_i_2_n_0 ),
        .I2(wb_addr_i[10]),
        .O(\mc_addr[8]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[8]_i_4 
       (.I0(\u0/tms_reg_n_0_[8] ),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_tms[8]),
        .O(\mc_addr[8]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hD8D8FF00)) 
    \mc_addr[9]_i_1 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(acs_addr[9]),
        .I2(\mc_addr[9]_i_2_n_0 ),
        .I3(\mc_addr[9]_i_3_n_0 ),
        .I4(\mc_addr[23]_i_4_n_0 ),
        .O(mc_addr_d[9]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \mc_addr[9]_i_2 
       (.I0(\mc_addr[9]_i_4_n_0 ),
        .I1(\mc_addr[12]_i_4_n_0 ),
        .I2(row_adr[9]),
        .I3(\mc_addr[12]_i_5_n_0 ),
        .I4(col_adr[9]),
        .O(\mc_addr[9]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \mc_addr[9]_i_3 
       (.I0(sram_addr[9]),
        .I1(\mc_addr[23]_i_2_n_0 ),
        .I2(wb_addr_i[11]),
        .O(\mc_addr[9]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hEEEFEEEE22202222)) 
    \mc_addr[9]_i_4 
       (.I0(\u0/tms_reg_n_0_[9] ),
        .I1(lmr_ack),
        .I2(\u5/state [6]),
        .I3(\FSM_sequential_state[5]_i_4_n_0 ),
        .I4(\burst_cnt[3]_i_4_n_0 ),
        .I5(sp_tms[9]),
        .O(\mc_addr[9]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'hFFFF1555)) 
    mc_adsc__i_1
       (.I0(mc_adsc__i_2_n_0),
        .I1(\u5/state [4]),
        .I2(\u5/state [1]),
        .I3(mc_adsc__i_3_n_0),
        .I4(mc_adsc__i_4_n_0),
        .O(mc_adsc__i_1_n_0));
  LUT6 #(
    .INIT(64'h00C80000000C0030)) 
    mc_adsc__i_2
       (.I0(no_wb_cycle_i_2_n_0),
        .I1(\u5/state [4]),
        .I2(\u5/state [0]),
        .I3(\u5/state [1]),
        .I4(\u5/state [3]),
        .I5(\u5/state [2]),
        .O(mc_adsc__i_2_n_0));
  LUT6 #(
    .INIT(64'h00000EFFCC000000)) 
    mc_adsc__i_3
       (.I0(wb_stb_i),
        .I1(no_wb_cycle_i_2_n_0),
        .I2(wb_write_go),
        .I3(\u5/state [0]),
        .I4(\u5/state [3]),
        .I5(\u5/state [2]),
        .O(mc_adsc__i_3_n_0));
  LUT6 #(
    .INIT(64'hFF00FFFFFFFFFFDF)) 
    mc_adsc__i_4
       (.I0(oe__i_3_n_0),
        .I1(\mc_addr[23]_i_3_n_0 ),
        .I2(mc_adsc__i_5_n_0),
        .I3(\u5/state [6]),
        .I4(\u5/state [5]),
        .I5(\u5/state [4]),
        .O(mc_adsc__i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT4 #(
    .INIT(16'h00E2)) 
    mc_adsc__i_5
       (.I0(sp_csc[1]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(csc[1]),
        .I3(wb_write_go),
        .O(mc_adsc__i_5_n_0));
  LUT6 #(
    .INIT(64'hD7FFFFFFD7FFF7FF)) 
    mc_adv__i_1
       (.I0(mc_bg_i_3_n_0),
        .I1(\u5/state [0]),
        .I2(\u5/state [1]),
        .I3(mc_adv__i_2_n_0),
        .I4(mc_adv__i_3_n_0),
        .I5(\u5/tmr2_done ),
        .O(mc_adv__i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair118" *) 
  LUT2 #(
    .INIT(4'h2)) 
    mc_adv__i_2
       (.I0(\u5/state [3]),
        .I1(\u5/state [2]),
        .O(mc_adv__i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    mc_adv__i_3
       (.I0(wb_stb_i),
        .I1(wb_write_go),
        .I2(no_wb_cycle_i_2_n_0),
        .O(mc_adv__i_3_n_0));
  LUT6 #(
    .INIT(64'h00D0C00000000000)) 
    mc_adv_r1_i_1
       (.I0(\u5/tmr2_done ),
        .I1(mc_adv__i_3_n_0),
        .I2(mc_adv__i_2_n_0),
        .I3(\u5/state [1]),
        .I4(\u5/state [0]),
        .I5(mc_bg_i_3_n_0),
        .O(mc_adv_d));
  LUT6 #(
    .INIT(64'h00000000EE00000E)) 
    mc_bg_i_1
       (.I0(mc_bg_i_2_n_0),
        .I1(mc_bg_i_3_n_0),
        .I2(\u5/state [0]),
        .I3(\u5/state [1]),
        .I4(\u5/state [2]),
        .I5(mc_bg_i_4_n_0),
        .O(mc_bg_d));
  LUT6 #(
    .INIT(64'h0000000000020000)) 
    mc_bg_i_2
       (.I0(\u5/p_65_in ),
        .I1(\FSM_sequential_state[5]_i_4_n_0 ),
        .I2(mc_bg_i_5_n_0),
        .I3(\u5/susp_req_r ),
        .I4(\u5/state [6]),
        .I5(lmr_req),
        .O(mc_bg_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'h08)) 
    mc_bg_i_3
       (.I0(\u5/state [4]),
        .I1(\u5/state [5]),
        .I2(\u5/state [6]),
        .O(mc_bg_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT3 #(
    .INIT(8'h7E)) 
    mc_bg_i_4
       (.I0(\u5/state [4]),
        .I1(\u5/state [2]),
        .I2(\u5/state [3]),
        .O(mc_bg_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair115" *) 
  LUT2 #(
    .INIT(4'hE)) 
    mc_bg_i_5
       (.I0(rfr_req),
        .I1(init_req),
        .O(mc_bg_i_5_n_0));
  LUT6 #(
    .INIT(64'hABBBBBBBAAAAAAAA)) 
    mc_c_oe_i_1
       (.I0(mc_c_oe_i_2_n_0),
        .I1(\u5/state [6]),
        .I2(\u5/state [4]),
        .I3(\u5/state [2]),
        .I4(\u5/state [3]),
        .I5(mc_c_oe_i_3_n_0),
        .O(\u5/mc_c_oe_d ));
  LUT6 #(
    .INIT(64'h0000000C00010F0C)) 
    mc_c_oe_i_2
       (.I0(\u5/state [4]),
        .I1(\u5/state [3]),
        .I2(mc_c_oe_i_4_n_0),
        .I3(\u5/state [1]),
        .I4(\u5/state [6]),
        .I5(\u5/state [5]),
        .O(mc_c_oe_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFDFFFFFFFFFFFFF)) 
    mc_c_oe_i_3
       (.I0(mc_br_r),
        .I1(\u5/cmd_asserted2 ),
        .I2(\FSM_sequential_state[5]_i_9_n_0 ),
        .I3(\FSM_sequential_state[6]_i_21_n_0 ),
        .I4(\FSM_sequential_state[5]_i_8_n_0 ),
        .I5(mc_c_oe_i_5_n_0),
        .O(mc_c_oe_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT4 #(
    .INIT(16'h01F1)) 
    mc_c_oe_i_4
       (.I0(mc_br_r),
        .I1(\u5/state [0]),
        .I2(\u5/state [2]),
        .I3(\u5/state [3]),
        .O(mc_c_oe_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair114" *) 
  LUT2 #(
    .INIT(4'h1)) 
    mc_c_oe_i_5
       (.I0(\u5/state [2]),
        .I1(\u5/state [5]),
        .O(mc_c_oe_i_5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    mc_cas__i_1
       (.I0(\u5/cmd_del [1]),
        .I1(wr_cycle),
        .I2(\u5/cmd [1]),
        .O(cas_));
  LUT6 #(
    .INIT(64'h77772272FFFFFFFF)) 
    \mc_cs_[0]_i_1 
       (.I0(wr_cycle),
        .I1(\u5/cmd_del [3]),
        .I2(\mc_cs_[1]_i_3_n_0 ),
        .I3(\mc_cs_[1]_i_4_n_0 ),
        .I4(\u5/state [6]),
        .I5(\mc_cs_[0]_i_2_n_0 ),
        .O(\mc_cs_[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hABA8ABABABA8A8A8)) 
    \mc_cs_[0]_i_2 
       (.I0(rfr_en_i_2_n_0),
        .I1(rfr_ack),
        .I2(susp_sel),
        .I3(cs[0]),
        .I4(\timer2[6]_i_4_n_0 ),
        .I5(spec_req_cs[0]),
        .O(\mc_cs_[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hBFBFBFBFAEAEBFAE)) 
    \mc_cs_[1]_i_1 
       (.I0(\mc_cs_[1]_i_2_n_0 ),
        .I1(wr_cycle),
        .I2(\u5/cmd_del [3]),
        .I3(\mc_cs_[1]_i_3_n_0 ),
        .I4(\mc_cs_[1]_i_4_n_0 ),
        .I5(\u5/state [6]),
        .O(\mc_cs_[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00FF00FF00FF1D1D)) 
    \mc_cs_[1]_i_2 
       (.I0(spec_req_cs[1]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(cs[1]),
        .I3(init_req_i_2__0_n_0),
        .I4(rfr_ack),
        .I5(susp_sel),
        .O(\mc_cs_[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFF75FFFFFF757777)) 
    \mc_cs_[1]_i_3 
       (.I0(\FSM_sequential_state[0]_i_3_n_0 ),
        .I1(\u5/state [3]),
        .I2(\u5/tmr2_done ),
        .I3(\u5/state [4]),
        .I4(\u5/state [1]),
        .I5(\cmd_r[0]_i_3_n_0 ),
        .O(\mc_cs_[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0000FF01)) 
    \mc_cs_[1]_i_4 
       (.I0(\u5/state [2]),
        .I1(\u5/state [4]),
        .I2(\mc_cs_[1]_i_5_n_0 ),
        .I3(cmd_asserted_i_3_n_0),
        .I4(\u5/state [5]),
        .I5(cmd_asserted_i_4_n_0),
        .O(\mc_cs_[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h5545554555555545)) 
    \mc_cs_[1]_i_5 
       (.I0(\b3_last_row[12]_i_3_n_0 ),
        .I1(cmd_asserted_i_5_n_0),
        .I2(\FSM_sequential_state[5]_i_8_n_0 ),
        .I3(\FSM_sequential_state[5]_i_9_n_0 ),
        .I4(wb_cyc_i),
        .I5(wb_stb_i),
        .O(\mc_cs_[1]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \mc_data_o[31]_i_1 
       (.I0(csc[2]),
        .I1(csc[3]),
        .I2(csc[1]),
        .I3(mem_ack_r),
        .O(\u3/mc_data_o0 ));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT3 #(
    .INIT(8'h08)) 
    mc_data_oe_i_1
       (.I0(data_oe),
        .I1(mc_c_oe_d),
        .I2(susp_sel),
        .O(\u7/mc_data_oe0 ));
  LUT5 #(
    .INIT(32'h96696996)) 
    \mc_dp_o[0]_i_1 
       (.I0(wb_data_i[4]),
        .I1(wb_data_i[5]),
        .I2(wb_data_i[0]),
        .I3(wb_data_i[1]),
        .I4(\mc_dp_o[0]_i_2_n_0 ),
        .O(\mc_dp_o[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \mc_dp_o[0]_i_2 
       (.I0(wb_data_i[3]),
        .I1(wb_data_i[2]),
        .I2(wb_data_i[6]),
        .I3(wb_data_i[7]),
        .O(\mc_dp_o[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h96696996)) 
    \mc_dp_o[1]_i_1 
       (.I0(wb_data_i[13]),
        .I1(wb_data_i[12]),
        .I2(wb_data_i[11]),
        .I3(wb_data_i[10]),
        .I4(\mc_dp_o[1]_i_2_n_0 ),
        .O(\mc_dp_o[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \mc_dp_o[1]_i_2 
       (.I0(wb_data_i[14]),
        .I1(wb_data_i[15]),
        .I2(wb_data_i[8]),
        .I3(wb_data_i[9]),
        .O(\mc_dp_o[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h96696996)) 
    \mc_dp_o[2]_i_1 
       (.I0(wb_data_i[21]),
        .I1(wb_data_i[20]),
        .I2(wb_data_i[19]),
        .I3(wb_data_i[18]),
        .I4(\mc_dp_o[2]_i_2_n_0 ),
        .O(\mc_dp_o[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \mc_dp_o[2]_i_2 
       (.I0(wb_data_i[22]),
        .I1(wb_data_i[23]),
        .I2(wb_data_i[16]),
        .I3(wb_data_i[17]),
        .O(\mc_dp_o[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h96696996)) 
    \mc_dp_o[3]_i_1 
       (.I0(wb_data_i[29]),
        .I1(wb_data_i[28]),
        .I2(wb_data_i[27]),
        .I3(wb_data_i[26]),
        .I4(\mc_dp_o[3]_i_2_n_0 ),
        .O(mc_dp_o0));
  LUT4 #(
    .INIT(16'h6996)) 
    \mc_dp_o[3]_i_2 
       (.I0(wb_data_i[30]),
        .I1(wb_data_i[31]),
        .I2(wb_data_i[24]),
        .I3(wb_data_i[25]),
        .O(\mc_dp_o[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT4 #(
    .INIT(16'h0FBB)) 
    \mc_dqm[0]_i_1 
       (.I0(wr_cycle),
        .I1(wb_cycle),
        .I2(mc_dqm_r2[0]),
        .I3(data_oe),
        .O(\mc_dqm[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT4 #(
    .INIT(16'h0FBB)) 
    \mc_dqm[1]_i_1 
       (.I0(wr_cycle),
        .I1(wb_cycle),
        .I2(mc_dqm_r2[1]),
        .I3(data_oe),
        .O(\mc_dqm[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT4 #(
    .INIT(16'h0FBB)) 
    \mc_dqm[2]_i_1 
       (.I0(wr_cycle),
        .I1(wb_cycle),
        .I2(mc_dqm_r2[2]),
        .I3(data_oe),
        .O(\mc_dqm[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT4 #(
    .INIT(16'h0FBB)) 
    \mc_dqm[3]_i_1 
       (.I0(wr_cycle),
        .I1(wb_cycle),
        .I2(mc_dqm_r2[3]),
        .I3(data_oe),
        .O(\mc_dqm[3]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \mc_dqm_r[3]_i_1 
       (.I0(wb_cyc_i),
        .I1(wb_stb_i),
        .O(\u6/wr_hold0 ));
  LUT1 #(
    .INIT(2'h1)) 
    mc_le_i_1
       (.I0(\u5/mc_le ),
        .O(mc_le_i_1_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    mc_oe__i_1
       (.I0(susp_sel),
        .I1(oe_),
        .O(\u7/mc_oe_0 ));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    mc_ras__i_1
       (.I0(\u5/cmd_del [2]),
        .I1(wr_cycle),
        .I2(\u5/cmd [2]),
        .O(ras_));
  LUT2 #(
    .INIT(4'h1)) 
    mc_rp_i_1
       (.I0(fs),
        .I1(suspended_o),
        .O(\u7/mc_rp0 ));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    mc_we__i_1
       (.I0(\u5/cmd_del [0]),
        .I1(wr_cycle),
        .I2(\u5/cmd [0]),
        .O(we_));
  LUT6 #(
    .INIT(64'h5554555555545554)) 
    mem_ack_r_i_1
       (.I0(\u5/p_65_in ),
        .I1(mem_ack_r_i_2_n_0),
        .I2(mem_ack_r_i_3_n_0),
        .I3(mem_ack_r_i_4_n_0),
        .I4(mem_ack_r_i_5_n_0),
        .I5(mem_ack_r_i_6_n_0),
        .O(mem_ack));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT2 #(
    .INIT(4'h1)) 
    mem_ack_r_i_10
       (.I0(\u5/state [0]),
        .I1(\u5/state [4]),
        .O(mem_ack_r_i_10_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'hFF4FFFFF)) 
    mem_ack_r_i_11
       (.I0(wb_stb_i),
        .I1(wb_cyc_i),
        .I2(wb_write_go),
        .I3(\u5/mem_ack_r ),
        .I4(\u5/cmd_asserted ),
        .O(mem_ack_r_i_11_n_0));
  LUT6 #(
    .INIT(64'h0000000020000000)) 
    mem_ack_r_i_12
       (.I0(\mc_addr[14]_i_4_n_0 ),
        .I1(data_oe_r_i_7_n_0),
        .I2(\FSM_sequential_state[1]_i_13_n_0 ),
        .I3(\FSM_sequential_state[3]_i_9_n_0 ),
        .I4(\FSM_sequential_state[5]_i_8_n_0 ),
        .I5(\mc_addr[23]_i_3_n_0 ),
        .O(mem_ack_r_i_12_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hBBFB)) 
    mem_ack_r_i_13
       (.I0(\u5/mem_ack_r ),
        .I1(wb_write_go),
        .I2(wb_cyc_i),
        .I3(wb_stb_i),
        .O(mem_ack_r_i_13_n_0));
  LUT6 #(
    .INIT(64'h00FF40FFFFFF00FF)) 
    mem_ack_r_i_14
       (.I0(\u5/mem_ack_r ),
        .I1(wb_write_go),
        .I2(\u5/tmr_done ),
        .I3(\u5/state [2]),
        .I4(\u5/state [5]),
        .I5(\u5/state [1]),
        .O(mem_ack_r_i_14_n_0));
  LUT5 #(
    .INIT(32'h00000004)) 
    mem_ack_r_i_2
       (.I0(\u5/mem_ack_r ),
        .I1(wb_stb_i),
        .I2(wb_we_i),
        .I3(mem_ack_r_i_7_n_0),
        .I4(no_wb_cycle_i_2_n_0),
        .O(mem_ack_r_i_2_n_0));
  LUT6 #(
    .INIT(64'h888A888A888A8888)) 
    mem_ack_r_i_3
       (.I0(cs_le_i_12_n_0),
        .I1(mem_ack_r_i_8_n_0),
        .I2(mem_ack_r_i_9_n_0),
        .I3(\FSM_sequential_state[2]_i_15_n_0 ),
        .I4(\u5/tmr_done ),
        .I5(\u5/state [2]),
        .O(mem_ack_r_i_3_n_0));
  LUT6 #(
    .INIT(64'h0080000000000000)) 
    mem_ack_r_i_4
       (.I0(\u5/state [3]),
        .I1(\u5/state [2]),
        .I2(\u5/state [1]),
        .I3(\u5/state [6]),
        .I4(\u5/state [5]),
        .I5(mem_ack_r_i_10_n_0),
        .O(mem_ack_r_i_4_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFF700)) 
    mem_ack_r_i_5
       (.I0(wb_cycle),
        .I1(cke__i_5_n_0),
        .I2(mem_ack_r_i_11_n_0),
        .I3(\u5/state [4]),
        .I4(\FSM_sequential_state[2]_i_4_n_0 ),
        .I5(\u5/state [3]),
        .O(mem_ack_r_i_5_n_0));
  LUT6 #(
    .INIT(64'h0820FFFF08200820)) 
    mem_ack_r_i_6
       (.I0(\u5/state [1]),
        .I1(\u5/state [2]),
        .I2(\u5/state [5]),
        .I3(\u5/state [4]),
        .I4(\FSM_sequential_state[5]_i_9_n_0 ),
        .I5(mem_ack_r_i_12_n_0),
        .O(mem_ack_r_i_6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    mem_ack_r_i_7
       (.I0(\u5/ack_cnt_reg [0]),
        .I1(\u5/ack_cnt_reg [1]),
        .I2(\u5/ack_cnt_reg [3]),
        .I3(\u5/ack_cnt_reg [2]),
        .O(mem_ack_r_i_7_n_0));
  LUT6 #(
    .INIT(64'h0000000000200000)) 
    mem_ack_r_i_8
       (.I0(cke__i_5_n_0),
        .I1(\u5/state [5]),
        .I2(\burst_cnt[10]_i_4_n_0 ),
        .I3(\FSM_sequential_state[6]_i_29_n_0 ),
        .I4(wr_cycle),
        .I5(mem_ack_r_i_13_n_0),
        .O(mem_ack_r_i_8_n_0));
  LUT6 #(
    .INIT(64'h0F0F0F0F0F0F0700)) 
    mem_ack_r_i_9
       (.I0(\u5/state [5]),
        .I1(\u5/cmd_asserted ),
        .I2(mem_ack_r_i_14_n_0),
        .I3(\u5/state [1]),
        .I4(data_oe_r_i_7_n_0),
        .I5(\u5/mem_ack_r ),
        .O(mem_ack_r_i_9_n_0));
  FDRE mem_ack_r_reg
       (.C(clk_i),
        .CE(\<const1> ),
        .D(mem_ack),
        .Q(mem_ack_r),
        .R(\<const0> ));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT2 #(
    .INIT(4'h2)) 
    no_wb_cycle_i_1
       (.I0(no_wb_cycle_i_2_n_0),
        .I1(wb_write_go),
        .O(\u5/p_65_in ));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT3 #(
    .INIT(8'hBF)) 
    no_wb_cycle_i_2
       (.I0(wb_write_go_r_i_2_n_0),
        .I1(\u6/read_go_r1 ),
        .I2(wb_cyc_i),
        .O(no_wb_cycle_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFAAAAFFBF)) 
    oe__i_1
       (.I0(oe__reg_i_2_n_0),
        .I1(oe__i_3_n_0),
        .I2(\mc_addr[14]_i_4_n_0 ),
        .I3(wb_write_go),
        .I4(\u5/state [5]),
        .I5(\u5/state [6]),
        .O(oe__i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT4 #(
    .INIT(16'h2202)) 
    oe__i_3
       (.I0(\FSM_sequential_state[5]_i_8_n_0 ),
        .I1(\FSM_sequential_state[5]_i_9_n_0 ),
        .I2(wb_cyc_i),
        .I3(wb_stb_i),
        .O(oe__i_3_n_0));
  LUT6 #(
    .INIT(64'hF3F3737F33FC33FF)) 
    oe__i_4
       (.I0(\FSM_sequential_state[6]_i_33_n_0 ),
        .I1(\u5/state [5]),
        .I2(\u5/state [1]),
        .I3(\u5/state [3]),
        .I4(\u5/state [0]),
        .I5(\u5/state [4]),
        .O(oe__i_4_n_0));
  LUT5 #(
    .INIT(32'hFFFBBBBB)) 
    oe__i_5
       (.I0(\u5/state [4]),
        .I1(\u5/state [5]),
        .I2(\u5/state [1]),
        .I3(\u5/state [0]),
        .I4(\u5/state [3]),
        .O(oe__i_5_n_0));
  MUXF7 oe__reg_i_2
       (.I0(oe__i_4_n_0),
        .I1(oe__i_5_n_0),
        .O(oe__reg_i_2_n_0),
        .S(\u5/state [2]));
  LUT1 #(
    .INIT(2'h1)) 
    \out_r[0]_i_1 
       (.I0(acs_addr[0]),
        .O(\out_r[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h44F4000000000000)) 
    pack_le0_i_1
       (.I0(\u5/state [3]),
        .I1(\u5/state [2]),
        .I2(pack_le0_i_2_n_0),
        .I3(pack_le0_i_3_n_0),
        .I4(\timer2[8]_i_5_n_0 ),
        .I5(\u5/state [1]),
        .O(\u5/pack_le0_d ));
  LUT3 #(
    .INIT(8'hB8)) 
    pack_le0_i_2
       (.I0(csc[4]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_csc[4]),
        .O(pack_le0_i_2_n_0));
  LUT3 #(
    .INIT(8'hB8)) 
    pack_le0_i_3
       (.I0(csc[5]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_csc[5]),
        .O(pack_le0_i_3_n_0));
  LUT6 #(
    .INIT(64'h0000000000002000)) 
    pack_le1_i_1
       (.I0(\u5/state [3]),
        .I1(\u5/state [4]),
        .I2(\u5/state [5]),
        .I3(\FSM_sequential_state[0]_i_3_n_0 ),
        .I4(\u5/state [6]),
        .I5(\u5/state [1]),
        .O(\u5/pack_le1_d ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT5 #(
    .INIT(32'h00000010)) 
    pack_le2_i_1
       (.I0(pack_le0_i_2_n_0),
        .I1(pack_le0_i_3_n_0),
        .I2(\u5/state [3]),
        .I3(\u5/state [0]),
        .I4(pack_le2_i_2_n_0),
        .O(\u5/pack_le2_d ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT5 #(
    .INIT(32'hFFFBFFFF)) 
    pack_le2_i_2
       (.I0(\u5/state [6]),
        .I1(\u5/state [5]),
        .I2(\u5/state [4]),
        .I3(\u5/state [2]),
        .I4(\u5/state [1]),
        .O(pack_le2_i_2_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    \ps_cnt[0]_i_1 
       (.I0(\u4/ps_cnt_reg [0]),
        .I1(\u4/ps_cnt_clr ),
        .O(p_0_in__1[0]));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \ps_cnt[1]_i_1 
       (.I0(\u4/ps_cnt_reg [1]),
        .I1(\u4/ps_cnt_reg [0]),
        .I2(\u4/ps_cnt_clr ),
        .O(p_0_in__1[1]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT4 #(
    .INIT(16'h0078)) 
    \ps_cnt[2]_i_1 
       (.I0(\u4/ps_cnt_reg [0]),
        .I1(\u4/ps_cnt_reg [1]),
        .I2(\u4/ps_cnt_reg [2]),
        .I3(\u4/ps_cnt_clr ),
        .O(p_0_in__1[2]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT5 #(
    .INIT(32'h00007F80)) 
    \ps_cnt[3]_i_1 
       (.I0(\u4/ps_cnt_reg [2]),
        .I1(\u4/ps_cnt_reg [1]),
        .I2(\u4/ps_cnt_reg [0]),
        .I3(\u4/ps_cnt_reg [3]),
        .I4(\u4/ps_cnt_clr ),
        .O(p_0_in__1[3]));
  LUT6 #(
    .INIT(64'h000000007FFF8000)) 
    \ps_cnt[4]_i_1 
       (.I0(\u4/ps_cnt_reg [3]),
        .I1(\u4/ps_cnt_reg [0]),
        .I2(\u4/ps_cnt_reg [1]),
        .I3(\u4/ps_cnt_reg [2]),
        .I4(\u4/ps_cnt_reg [4]),
        .I5(\u4/ps_cnt_clr ),
        .O(p_0_in__1[4]));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \ps_cnt[5]_i_1 
       (.I0(\ps_cnt[5]_i_2_n_0 ),
        .I1(\u4/ps_cnt_reg [5]),
        .I2(\u4/ps_cnt_clr ),
        .O(p_0_in__1[5]));
  LUT5 #(
    .INIT(32'h80000000)) 
    \ps_cnt[5]_i_2 
       (.I0(\u4/ps_cnt_reg [4]),
        .I1(\u4/ps_cnt_reg [2]),
        .I2(\u4/ps_cnt_reg [1]),
        .I3(\u4/ps_cnt_reg [0]),
        .I4(\u4/ps_cnt_reg [3]),
        .O(\ps_cnt[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \ps_cnt[6]_i_1 
       (.I0(\ps_cnt[7]_i_3_n_0 ),
        .I1(\u4/ps_cnt_reg [6]),
        .I2(\u4/ps_cnt_clr ),
        .O(p_0_in__1[6]));
  LUT2 #(
    .INIT(4'hE)) 
    \ps_cnt[7]_i_1 
       (.I0(\u4/rfr_en ),
        .I1(\u4/ps_cnt_clr ),
        .O(\ps_cnt[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT4 #(
    .INIT(16'h0078)) 
    \ps_cnt[7]_i_2 
       (.I0(\u4/ps_cnt_reg [6]),
        .I1(\ps_cnt[7]_i_3_n_0 ),
        .I2(\u4/ps_cnt_reg [7]),
        .I3(\u4/ps_cnt_clr ),
        .O(p_0_in__1[7]));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \ps_cnt[7]_i_3 
       (.I0(\u4/ps_cnt_reg [5]),
        .I1(\u4/ps_cnt_reg [3]),
        .I2(\u4/ps_cnt_reg [0]),
        .I3(\u4/ps_cnt_reg [1]),
        .I4(\u4/ps_cnt_reg [2]),
        .I5(\u4/ps_cnt_reg [4]),
        .O(\ps_cnt[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \r0[35]_i_1 
       (.I0(\u3/u0/wr_adr_reg_n_0_[0] ),
        .I1(dv),
        .O(\u3/u0/r00 ));
  LUT2 #(
    .INIT(4'h8)) 
    \r1[35]_i_1 
       (.I0(\u3/u0/p_0_in1_in ),
        .I1(dv),
        .O(\u3/u0/r10 ));
  LUT2 #(
    .INIT(4'h8)) 
    \r2[35]_i_1 
       (.I0(\u3/u0/p_0_in0_in ),
        .I1(dv),
        .O(\u3/u0/r20 ));
  LUT2 #(
    .INIT(4'h8)) 
    \r3[35]_i_1 
       (.I0(\u3/u0/p_0_in ),
        .I1(dv),
        .O(\u3/u0/r30 ));
  LUT4 #(
    .INIT(16'hFBBB)) 
    \rd_adr[0]_i_1 
       (.I0(\u3/u0/rd_adr [3]),
        .I1(wb_cyc_i),
        .I2(wb_we_i),
        .I3(wb_stb_i),
        .O(\rd_adr[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0888)) 
    \rd_adr[1]_i_1 
       (.I0(\u3/u0/rd_adr [0]),
        .I1(wb_cyc_i),
        .I2(wb_we_i),
        .I3(wb_stb_i),
        .O(\rd_adr[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT4 #(
    .INIT(16'h0888)) 
    \rd_adr[2]_i_1 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(wb_cyc_i),
        .I2(wb_we_i),
        .I3(wb_stb_i),
        .O(\rd_adr[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hD5FFD5D5)) 
    \rd_adr[3]_i_1 
       (.I0(wb_cyc_i),
        .I1(wb_we_i),
        .I2(wb_stb_i),
        .I3(no_wb_cycle_i_2_n_0),
        .I4(mem_ack_r),
        .O(\rd_adr[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT4 #(
    .INIT(16'h0888)) 
    \rd_adr[3]_i_2 
       (.I0(\u3/u0/rd_adr [2]),
        .I1(wb_cyc_i),
        .I2(wb_we_i),
        .I3(wb_stb_i),
        .O(\rd_adr[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FF400000)) 
    read_go_r1_i_1
       (.I0(wb_we_i),
        .I1(\wb_data_o[31]_i_4_n_0 ),
        .I2(wb_stb_i),
        .I3(\u6/read_go_r ),
        .I4(wb_cyc_i),
        .I5(wb_write_go_r_i_2_n_0),
        .O(\u6/read_go_r10 ));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT2 #(
    .INIT(4'h8)) 
    read_go_r_i_1
       (.I0(\u6/read_go_r1 ),
        .I1(wb_cyc_i),
        .O(\u6/read_go_r0 ));
  LUT6 #(
    .INIT(64'h0000000004000000)) 
    rf_we_i_1
       (.I0(wb_ack_o_i_3_n_0),
        .I1(wb_we_i),
        .I2(wb_addr_i[31]),
        .I3(wb_addr_i[29]),
        .I4(wb_addr_i[30]),
        .I5(\u0/rf_we ),
        .O(\u0/rf_we0 ));
  LUT6 #(
    .INIT(64'h222222F200000000)) 
    rfr_ack_r_i_1
       (.I0(rfr_ack_r_i_2_n_0),
        .I1(rfr_ack_r_i_3_n_0),
        .I2(rfr_ack_r_i_4_n_0),
        .I3(rfr_ack_r_i_5_n_0),
        .I4(rfr_ack_r_i_6_n_0),
        .I5(rfr_ack_r_i_7_n_0),
        .O(rfr_ack_r_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair117" *) 
  LUT2 #(
    .INIT(4'h8)) 
    rfr_ack_r_i_2
       (.I0(\u5/state [3]),
        .I1(\u5/state [1]),
        .O(rfr_ack_r_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    rfr_ack_r_i_3
       (.I0(\u5/state [2]),
        .I1(\u5/state [4]),
        .I2(\u5/state [0]),
        .O(rfr_ack_r_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'h8F)) 
    rfr_ack_r_i_4
       (.I0(\u5/state [1]),
        .I1(\u5/state [0]),
        .I2(\u5/state [4]),
        .O(rfr_ack_r_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair122" *) 
  LUT2 #(
    .INIT(4'hE)) 
    rfr_ack_r_i_5
       (.I0(\u5/state [2]),
        .I1(\u5/state [3]),
        .O(rfr_ack_r_i_5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT5 #(
    .INIT(32'h000F0077)) 
    rfr_ack_r_i_6
       (.I0(rfr_req),
        .I1(\u5/state [0]),
        .I2(rfr_ack),
        .I3(\u5/state [4]),
        .I4(\u5/state [1]),
        .O(rfr_ack_r_i_6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair116" *) 
  LUT2 #(
    .INIT(4'h1)) 
    rfr_ack_r_i_7
       (.I0(\u5/state [5]),
        .I1(\u5/state [6]),
        .O(rfr_ack_r_i_7_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    rfr_ce_i_1
       (.I0(\u4/ps_cnt_clr01_in ),
        .I1(rfr_ce_i_2_n_0),
        .I2(rfr_ps_val[6]),
        .I3(rfr_ps_val[5]),
        .I4(rfr_ps_val[3]),
        .I5(rfr_ps_val[1]),
        .O(\u4/ps_cnt_clr ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    rfr_ce_i_2
       (.I0(rfr_ps_val[7]),
        .I1(rfr_ps_val[4]),
        .I2(rfr_ps_val[2]),
        .I3(rfr_ps_val[0]),
        .O(rfr_ce_i_2_n_0));
  LUT4 #(
    .INIT(16'h7000)) 
    rfr_clr_i_1
       (.I0(rfr_clr_i_2_n_0),
        .I1(sel0[2]),
        .I2(rfr_clr_i_3_n_0),
        .I3(\u4/rfr_early ),
        .O(\u4/rfr_clr ));
  LUT6 #(
    .INIT(64'h7050FFFFFFF0FFFF)) 
    rfr_clr_i_2
       (.I0(\u4/rfr_cnt_reg__0 [6]),
        .I1(\u4/rfr_cnt_reg__0 [7]),
        .I2(sel0[1]),
        .I3(sel0[0]),
        .I4(\rfr_cnt[7]_i_3_n_0 ),
        .I5(\u4/rfr_cnt_reg__0 [5]),
        .O(rfr_clr_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFF4044FFFFFFFF)) 
    rfr_clr_i_3
       (.I0(sel0[1]),
        .I1(\u4/rfr_cnt_reg ),
        .I2(\u4/rfr_cnt_reg__0 [1]),
        .I3(sel0[0]),
        .I4(sel0[2]),
        .I5(rfr_clr_i_4_n_0),
        .O(rfr_clr_i_3_n_0));
  LUT6 #(
    .INIT(64'h7F7FFF7FFFFFFFFF)) 
    rfr_clr_i_4
       (.I0(\u4/rfr_cnt_reg__0 [2]),
        .I1(\u4/rfr_cnt_reg ),
        .I2(\u4/rfr_cnt_reg__0 [1]),
        .I3(sel0[0]),
        .I4(\u4/rfr_cnt_reg__0 [3]),
        .I5(sel0[1]),
        .O(rfr_clr_i_4_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    \rfr_cnt[0]_i_1 
       (.I0(rfr_ack),
        .I1(\u4/rfr_cnt_reg ),
        .O(p_0_in__2[0]));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \rfr_cnt[1]_i_1 
       (.I0(\u4/rfr_cnt_reg__0 [1]),
        .I1(\u4/rfr_cnt_reg ),
        .I2(rfr_ack),
        .O(p_0_in__2[1]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT4 #(
    .INIT(16'h1540)) 
    \rfr_cnt[2]_i_1 
       (.I0(rfr_ack),
        .I1(\u4/rfr_cnt_reg ),
        .I2(\u4/rfr_cnt_reg__0 [1]),
        .I3(\u4/rfr_cnt_reg__0 [2]),
        .O(\rfr_cnt[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT5 #(
    .INIT(32'h00007F80)) 
    \rfr_cnt[3]_i_1 
       (.I0(\u4/rfr_cnt_reg__0 [1]),
        .I1(\u4/rfr_cnt_reg ),
        .I2(\u4/rfr_cnt_reg__0 [2]),
        .I3(\u4/rfr_cnt_reg__0 [3]),
        .I4(rfr_ack),
        .O(p_0_in__2[3]));
  LUT6 #(
    .INIT(64'h1555555540000000)) 
    \rfr_cnt[4]_i_1 
       (.I0(rfr_ack),
        .I1(\u4/rfr_cnt_reg__0 [3]),
        .I2(\u4/rfr_cnt_reg__0 [2]),
        .I3(\u4/rfr_cnt_reg ),
        .I4(\u4/rfr_cnt_reg__0 [1]),
        .I5(\u4/rfr_cnt_reg__0 [4]),
        .O(\rfr_cnt[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \rfr_cnt[5]_i_1 
       (.I0(\rfr_cnt[7]_i_3_n_0 ),
        .I1(\u4/rfr_cnt_reg__0 [5]),
        .I2(rfr_ack),
        .O(p_0_in__2[5]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT4 #(
    .INIT(16'h1540)) 
    \rfr_cnt[6]_i_1 
       (.I0(rfr_ack),
        .I1(\u4/rfr_cnt_reg__0 [5]),
        .I2(\rfr_cnt[7]_i_3_n_0 ),
        .I3(\u4/rfr_cnt_reg__0 [6]),
        .O(\rfr_cnt[6]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \rfr_cnt[7]_i_1 
       (.I0(\u4/rfr_ce ),
        .I1(rfr_ack),
        .O(\rfr_cnt[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT5 #(
    .INIT(32'h00007F80)) 
    \rfr_cnt[7]_i_2 
       (.I0(\rfr_cnt[7]_i_3_n_0 ),
        .I1(\u4/rfr_cnt_reg__0 [6]),
        .I2(\u4/rfr_cnt_reg__0 [5]),
        .I3(\u4/rfr_cnt_reg__0 [7]),
        .I4(rfr_ack),
        .O(p_0_in__2[7]));
  LUT5 #(
    .INIT(32'h80000000)) 
    \rfr_cnt[7]_i_3 
       (.I0(\u4/rfr_cnt_reg__0 [4]),
        .I1(\u4/rfr_cnt_reg__0 [1]),
        .I2(\u4/rfr_cnt_reg ),
        .I3(\u4/rfr_cnt_reg__0 [2]),
        .I4(\u4/rfr_cnt_reg__0 [3]),
        .O(\rfr_cnt[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000009009)) 
    rfr_early_i_1
       (.I0(\u4/ps_cnt_reg [7]),
        .I1(rfr_ps_val[7]),
        .I2(\u4/ps_cnt_reg [6]),
        .I3(rfr_ps_val[6]),
        .I4(rfr_early_i_2_n_0),
        .I5(rfr_early_i_3_n_0),
        .O(\u4/ps_cnt_clr01_in ));
  LUT6 #(
    .INIT(64'h6FF6FFFFFFFF6FF6)) 
    rfr_early_i_2
       (.I0(rfr_ps_val[0]),
        .I1(\u4/ps_cnt_reg [0]),
        .I2(\u4/ps_cnt_reg [2]),
        .I3(rfr_ps_val[2]),
        .I4(\u4/ps_cnt_reg [1]),
        .I5(rfr_ps_val[1]),
        .O(rfr_early_i_2_n_0));
  LUT6 #(
    .INIT(64'h6FF6FFFFFFFF6FF6)) 
    rfr_early_i_3
       (.I0(rfr_ps_val[3]),
        .I1(\u4/ps_cnt_reg [3]),
        .I2(\u4/ps_cnt_reg [4]),
        .I3(rfr_ps_val[4]),
        .I4(\u4/ps_cnt_reg [5]),
        .I5(rfr_ps_val[5]),
        .O(rfr_early_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    rfr_en_i_1
       (.I0(\u0/u1/csc_reg_n_0_[2] ),
        .I1(\u0/u1/csc_reg_n_0_[3] ),
        .I2(\u0/u1/csc_reg_n_0_[1] ),
        .I3(\u0/u1/csc_reg_n_0_[0] ),
        .I4(rfr_en_i_2_n_0),
        .O(rfr_en_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT4 #(
    .INIT(16'h0002)) 
    rfr_en_i_2
       (.I0(\u0/u0/csc_reg_n_0_[0] ),
        .I1(\u0/u0/csc_reg_n_0_[1] ),
        .I2(\u0/u0/csc_reg_n_0_[3] ),
        .I3(\u0/u0/csc_reg_n_0_[2] ),
        .O(rfr_en_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT3 #(
    .INIT(8'h54)) 
    rfr_req_i_1
       (.I0(rfr_ack),
        .I1(\u4/rfr_clr_reg_n_0 ),
        .I2(rfr_req),
        .O(rfr_req_i_1_n_0));
  LUT3 #(
    .INIT(8'hEA)) 
    rmw_en_i_1
       (.I0(wb_ack_o),
        .I1(wb_cyc_i),
        .I2(\u6/rmw_en ),
        .O(rmw_en_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h00008000)) 
    rmw_r_i_1
       (.I0(wb_stb_i),
        .I1(wb_cyc_i),
        .I2(wb_we_i),
        .I3(\u6/rmw_en ),
        .I4(wr_hold),
        .O(\u6/rmw_r0 ));
  LUT2 #(
    .INIT(4'h9)) 
    row0_same_carry__0_i_1
       (.I0(row_adr[12]),
        .I1(\u2/u0/b0_last_row_reg_n_0_[12] ),
        .O(row0_same_carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    row0_same_carry__0_i_1__0
       (.I0(row_adr[12]),
        .I1(b0_last_row[12]),
        .O(row0_same_carry__0_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row0_same_carry_i_1
       (.I0(b0_last_row[11]),
        .I1(row_adr[11]),
        .I2(b0_last_row[10]),
        .I3(row_adr[10]),
        .I4(row_adr[9]),
        .I5(b0_last_row[9]),
        .O(row0_same_carry_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row0_same_carry_i_1__0
       (.I0(row_adr[10]),
        .I1(\u2/u0/b0_last_row_reg_n_0_[10] ),
        .I2(\u2/u0/b0_last_row_reg_n_0_[11] ),
        .I3(row_adr[11]),
        .I4(\u2/u0/b0_last_row_reg_n_0_[9] ),
        .I5(row_adr[9]),
        .O(row0_same_carry_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row0_same_carry_i_2
       (.I0(row_adr[7]),
        .I1(b0_last_row[7]),
        .I2(b0_last_row[8]),
        .I3(row_adr[8]),
        .I4(b0_last_row[6]),
        .I5(row_adr[6]),
        .O(row0_same_carry_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row0_same_carry_i_2__0
       (.I0(row_adr[7]),
        .I1(\u2/u0/b0_last_row_reg_n_0_[7] ),
        .I2(\u2/u0/b0_last_row_reg_n_0_[8] ),
        .I3(row_adr[8]),
        .I4(\u2/u0/b0_last_row_reg_n_0_[6] ),
        .I5(row_adr[6]),
        .O(row0_same_carry_i_2__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row0_same_carry_i_3
       (.I0(row_adr[4]),
        .I1(b0_last_row[4]),
        .I2(b0_last_row[5]),
        .I3(row_adr[5]),
        .I4(b0_last_row[3]),
        .I5(row_adr[3]),
        .O(row0_same_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row0_same_carry_i_3__0
       (.I0(\u2/u0/b0_last_row_reg_n_0_[5] ),
        .I1(row_adr[5]),
        .I2(\u2/u0/b0_last_row_reg_n_0_[4] ),
        .I3(row_adr[4]),
        .I4(row_adr[3]),
        .I5(\u2/u0/b0_last_row_reg_n_0_[3] ),
        .O(row0_same_carry_i_3__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row0_same_carry_i_4
       (.I0(b0_last_row[2]),
        .I1(row_adr[2]),
        .I2(b0_last_row[1]),
        .I3(row_adr[1]),
        .I4(row_adr[0]),
        .I5(b0_last_row[0]),
        .O(row0_same_carry_i_4_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row0_same_carry_i_4__0
       (.I0(\u2/u0/b0_last_row_reg_n_0_[2] ),
        .I1(row_adr[2]),
        .I2(\u2/u0/b0_last_row_reg_n_0_[0] ),
        .I3(row_adr[0]),
        .I4(row_adr[1]),
        .I5(\u2/u0/b0_last_row_reg_n_0_[1] ),
        .O(row0_same_carry_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    row1_same_carry__0_i_1
       (.I0(row_adr[12]),
        .I1(b1_last_row[12]),
        .O(row1_same_carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    row1_same_carry__0_i_1__0
       (.I0(row_adr[12]),
        .I1(\u2/u0/b1_last_row_reg_n_0_[12] ),
        .O(row1_same_carry__0_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row1_same_carry_i_1
       (.I0(b1_last_row[11]),
        .I1(row_adr[11]),
        .I2(b1_last_row[10]),
        .I3(row_adr[10]),
        .I4(row_adr[9]),
        .I5(b1_last_row[9]),
        .O(row1_same_carry_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row1_same_carry_i_1__0
       (.I0(\u2/u0/b1_last_row_reg_n_0_[11] ),
        .I1(row_adr[11]),
        .I2(\u2/u0/b1_last_row_reg_n_0_[10] ),
        .I3(row_adr[10]),
        .I4(row_adr[9]),
        .I5(\u2/u0/b1_last_row_reg_n_0_[9] ),
        .O(row1_same_carry_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row1_same_carry_i_2
       (.I0(row_adr[7]),
        .I1(b1_last_row[7]),
        .I2(b1_last_row[8]),
        .I3(row_adr[8]),
        .I4(b1_last_row[6]),
        .I5(row_adr[6]),
        .O(row1_same_carry_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row1_same_carry_i_2__0
       (.I0(row_adr[7]),
        .I1(\u2/u0/b1_last_row_reg_n_0_[7] ),
        .I2(\u2/u0/b1_last_row_reg_n_0_[8] ),
        .I3(row_adr[8]),
        .I4(\u2/u0/b1_last_row_reg_n_0_[6] ),
        .I5(row_adr[6]),
        .O(row1_same_carry_i_2__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row1_same_carry_i_3
       (.I0(b1_last_row[5]),
        .I1(row_adr[5]),
        .I2(b1_last_row[4]),
        .I3(row_adr[4]),
        .I4(row_adr[3]),
        .I5(b1_last_row[3]),
        .O(row1_same_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row1_same_carry_i_3__0
       (.I0(row_adr[4]),
        .I1(\u2/u0/b1_last_row_reg_n_0_[4] ),
        .I2(\u2/u0/b1_last_row_reg_n_0_[5] ),
        .I3(row_adr[5]),
        .I4(\u2/u0/b1_last_row_reg_n_0_[3] ),
        .I5(row_adr[3]),
        .O(row1_same_carry_i_3__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row1_same_carry_i_4
       (.I0(b1_last_row[2]),
        .I1(row_adr[2]),
        .I2(b1_last_row[0]),
        .I3(row_adr[0]),
        .I4(row_adr[1]),
        .I5(b1_last_row[1]),
        .O(row1_same_carry_i_4_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row1_same_carry_i_4__0
       (.I0(\u2/u0/b1_last_row_reg_n_0_[2] ),
        .I1(row_adr[2]),
        .I2(\u2/u0/b1_last_row_reg_n_0_[0] ),
        .I3(row_adr[0]),
        .I4(row_adr[1]),
        .I5(\u2/u0/b1_last_row_reg_n_0_[1] ),
        .O(row1_same_carry_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    row2_same_carry__0_i_1
       (.I0(row_adr[12]),
        .I1(b2_last_row[12]),
        .O(row2_same_carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    row2_same_carry__0_i_1__0
       (.I0(row_adr[12]),
        .I1(\u2/u0/b2_last_row_reg_n_0_[12] ),
        .O(row2_same_carry__0_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row2_same_carry_i_1
       (.I0(b2_last_row[11]),
        .I1(row_adr[11]),
        .I2(b2_last_row[10]),
        .I3(row_adr[10]),
        .I4(row_adr[9]),
        .I5(b2_last_row[9]),
        .O(row2_same_carry_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row2_same_carry_i_1__0
       (.I0(row_adr[10]),
        .I1(\u2/u0/b2_last_row_reg_n_0_[10] ),
        .I2(\u2/u0/b2_last_row_reg_n_0_[11] ),
        .I3(row_adr[11]),
        .I4(\u2/u0/b2_last_row_reg_n_0_[9] ),
        .I5(row_adr[9]),
        .O(row2_same_carry_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row2_same_carry_i_2
       (.I0(b2_last_row[8]),
        .I1(row_adr[8]),
        .I2(b2_last_row[7]),
        .I3(row_adr[7]),
        .I4(row_adr[6]),
        .I5(b2_last_row[6]),
        .O(row2_same_carry_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row2_same_carry_i_2__0
       (.I0(row_adr[7]),
        .I1(\u2/u0/b2_last_row_reg_n_0_[7] ),
        .I2(\u2/u0/b2_last_row_reg_n_0_[8] ),
        .I3(row_adr[8]),
        .I4(\u2/u0/b2_last_row_reg_n_0_[6] ),
        .I5(row_adr[6]),
        .O(row2_same_carry_i_2__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row2_same_carry_i_3
       (.I0(b2_last_row[5]),
        .I1(row_adr[5]),
        .I2(b2_last_row[4]),
        .I3(row_adr[4]),
        .I4(row_adr[3]),
        .I5(b2_last_row[3]),
        .O(row2_same_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row2_same_carry_i_3__0
       (.I0(row_adr[4]),
        .I1(\u2/u0/b2_last_row_reg_n_0_[4] ),
        .I2(\u2/u0/b2_last_row_reg_n_0_[5] ),
        .I3(row_adr[5]),
        .I4(\u2/u0/b2_last_row_reg_n_0_[3] ),
        .I5(row_adr[3]),
        .O(row2_same_carry_i_3__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row2_same_carry_i_4
       (.I0(b2_last_row[2]),
        .I1(row_adr[2]),
        .I2(b2_last_row[1]),
        .I3(row_adr[1]),
        .I4(row_adr[0]),
        .I5(b2_last_row[0]),
        .O(row2_same_carry_i_4_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row2_same_carry_i_4__0
       (.I0(\u2/u0/b2_last_row_reg_n_0_[2] ),
        .I1(row_adr[2]),
        .I2(\u2/u0/b2_last_row_reg_n_0_[1] ),
        .I3(row_adr[1]),
        .I4(row_adr[0]),
        .I5(\u2/u0/b2_last_row_reg_n_0_[0] ),
        .O(row2_same_carry_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    row3_same_carry__0_i_1
       (.I0(row_adr[12]),
        .I1(b3_last_row[12]),
        .O(row3_same_carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    row3_same_carry__0_i_1__0
       (.I0(row_adr[12]),
        .I1(\u2/u0/b3_last_row_reg_n_0_[12] ),
        .O(row3_same_carry__0_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row3_same_carry_i_1
       (.I0(row_adr[10]),
        .I1(b3_last_row[10]),
        .I2(b3_last_row[11]),
        .I3(row_adr[11]),
        .I4(b3_last_row[9]),
        .I5(row_adr[9]),
        .O(row3_same_carry_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row3_same_carry_i_1__0
       (.I0(\u2/u0/b3_last_row_reg_n_0_[11] ),
        .I1(row_adr[11]),
        .I2(\u2/u0/b3_last_row_reg_n_0_[10] ),
        .I3(row_adr[10]),
        .I4(row_adr[9]),
        .I5(\u2/u0/b3_last_row_reg_n_0_[9] ),
        .O(row3_same_carry_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row3_same_carry_i_2
       (.I0(row_adr[7]),
        .I1(b3_last_row[7]),
        .I2(b3_last_row[8]),
        .I3(row_adr[8]),
        .I4(b3_last_row[6]),
        .I5(row_adr[6]),
        .O(row3_same_carry_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row3_same_carry_i_2__0
       (.I0(\u2/u0/b3_last_row_reg_n_0_[8] ),
        .I1(row_adr[8]),
        .I2(\u2/u0/b3_last_row_reg_n_0_[7] ),
        .I3(row_adr[7]),
        .I4(row_adr[6]),
        .I5(\u2/u0/b3_last_row_reg_n_0_[6] ),
        .O(row3_same_carry_i_2__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row3_same_carry_i_3
       (.I0(b3_last_row[5]),
        .I1(row_adr[5]),
        .I2(b3_last_row[4]),
        .I3(row_adr[4]),
        .I4(row_adr[3]),
        .I5(b3_last_row[3]),
        .O(row3_same_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row3_same_carry_i_3__0
       (.I0(row_adr[4]),
        .I1(\u2/u0/b3_last_row_reg_n_0_[4] ),
        .I2(\u2/u0/b3_last_row_reg_n_0_[5] ),
        .I3(row_adr[5]),
        .I4(\u2/u0/b3_last_row_reg_n_0_[3] ),
        .I5(row_adr[3]),
        .O(row3_same_carry_i_3__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row3_same_carry_i_4
       (.I0(b3_last_row[2]),
        .I1(row_adr[2]),
        .I2(b3_last_row[0]),
        .I3(row_adr[0]),
        .I4(row_adr[1]),
        .I5(b3_last_row[1]),
        .O(row3_same_carry_i_4_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    row3_same_carry_i_4__0
       (.I0(\u2/u0/b3_last_row_reg_n_0_[2] ),
        .I1(row_adr[2]),
        .I2(\u2/u0/b3_last_row_reg_n_0_[1] ),
        .I3(row_adr[1]),
        .I4(row_adr[0]),
        .I5(\u2/u0/b3_last_row_reg_n_0_[0] ),
        .O(row3_same_carry_i_4__0_n_0));
  LUT5 #(
    .INIT(32'hBABF8A80)) 
    \row_adr[0]_i_1 
       (.I0(\bank_adr[0]_i_3_n_0 ),
        .I1(csc__0[9]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_csc[9]),
        .I4(\row_adr[2]_i_2_n_0 ),
        .O(\row_adr[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hBABF8A80)) 
    \row_adr[10]_i_1 
       (.I0(\row_adr[10]_i_2_n_0 ),
        .I1(csc__0[9]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_csc[9]),
        .I4(\row_adr[10]_i_3_n_0 ),
        .O(\row_adr[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFCFECE03003202)) 
    \row_adr[10]_i_2 
       (.I0(wb_addr_i[22]),
        .I1(pack_le0_i_3_n_0),
        .I2(\col_adr[9]_i_3_n_0 ),
        .I3(wb_addr_i[21]),
        .I4(pack_le0_i_2_n_0),
        .I5(wb_addr_i[20]),
        .O(\row_adr[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFEFB1051FEEA1040)) 
    \row_adr[10]_i_3 
       (.I0(pack_le0_i_3_n_0),
        .I1(\col_adr[9]_i_3_n_0 ),
        .I2(wb_addr_i[23]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[22]),
        .I5(wb_addr_i[24]),
        .O(\row_adr[10]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00FFEEB8000022B8)) 
    \row_adr[11]_i_2 
       (.I0(wb_addr_i[24]),
        .I1(pack_le0_i_2_n_0),
        .I2(wb_addr_i[25]),
        .I3(\col_adr[9]_i_3_n_0 ),
        .I4(pack_le0_i_3_n_0),
        .I5(wb_addr_i[23]),
        .O(\row_adr[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h22222222B8F3B8C0)) 
    \row_adr[11]_i_3 
       (.I0(wb_addr_i[21]),
        .I1(\col_adr[9]_i_3_n_0 ),
        .I2(wb_addr_i[22]),
        .I3(pack_le0_i_2_n_0),
        .I4(wb_addr_i[23]),
        .I5(pack_le0_i_3_n_0),
        .O(\row_adr[11]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \row_adr[12]_i_2 
       (.I0(csc__0[9]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_csc[9]),
        .O(\row_adr[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAA8080000A808)) 
    \row_adr[12]_i_3 
       (.I0(\row_adr[12]_i_5_n_0 ),
        .I1(wb_addr_i[26]),
        .I2(pack_le0_i_2_n_0),
        .I3(wb_addr_i[25]),
        .I4(pack_le0_i_3_n_0),
        .I5(wb_addr_i[24]),
        .O(\row_adr[12]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAA8080000A808)) 
    \row_adr[12]_i_4 
       (.I0(\row_adr[12]_i_5_n_0 ),
        .I1(wb_addr_i[24]),
        .I2(pack_le0_i_2_n_0),
        .I3(wb_addr_i[23]),
        .I4(pack_le0_i_3_n_0),
        .I5(wb_addr_i[22]),
        .O(\row_adr[12]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \row_adr[12]_i_5 
       (.I0(csc__0[7]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_csc[7]),
        .O(\row_adr[12]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hBABF8A80)) 
    \row_adr[1]_i_1 
       (.I0(\bank_adr[1]_i_3_n_0 ),
        .I1(csc__0[9]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_csc[9]),
        .I4(\row_adr[3]_i_2_n_0 ),
        .O(\row_adr[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hBABF8A80)) 
    \row_adr[2]_i_1 
       (.I0(\row_adr[2]_i_2_n_0 ),
        .I1(csc__0[9]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_csc[9]),
        .I4(\row_adr[4]_i_2_n_0 ),
        .O(\row_adr[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFCFECE03003202)) 
    \row_adr[2]_i_2 
       (.I0(wb_addr_i[14]),
        .I1(pack_le0_i_3_n_0),
        .I2(\col_adr[9]_i_3_n_0 ),
        .I3(wb_addr_i[13]),
        .I4(pack_le0_i_2_n_0),
        .I5(wb_addr_i[12]),
        .O(\row_adr[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hBABF8A80)) 
    \row_adr[3]_i_1 
       (.I0(\row_adr[3]_i_2_n_0 ),
        .I1(csc__0[9]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_csc[9]),
        .I4(\row_adr[5]_i_2_n_0 ),
        .O(\row_adr[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCDC8DD8DCDC8D888)) 
    \row_adr[3]_i_2 
       (.I0(pack_le0_i_3_n_0),
        .I1(wb_addr_i[13]),
        .I2(\col_adr[9]_i_3_n_0 ),
        .I3(wb_addr_i[14]),
        .I4(pack_le0_i_2_n_0),
        .I5(wb_addr_i[15]),
        .O(\row_adr[3]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hBABF8A80)) 
    \row_adr[4]_i_1 
       (.I0(\row_adr[4]_i_2_n_0 ),
        .I1(csc__0[9]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_csc[9]),
        .I4(\row_adr[6]_i_2_n_0 ),
        .O(\row_adr[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCDC8DD8DCDC8D888)) 
    \row_adr[4]_i_2 
       (.I0(pack_le0_i_3_n_0),
        .I1(wb_addr_i[14]),
        .I2(\col_adr[9]_i_3_n_0 ),
        .I3(wb_addr_i[15]),
        .I4(pack_le0_i_2_n_0),
        .I5(wb_addr_i[16]),
        .O(\row_adr[4]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hBABF8A80)) 
    \row_adr[5]_i_1 
       (.I0(\row_adr[5]_i_2_n_0 ),
        .I1(csc__0[9]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_csc[9]),
        .I4(\row_adr[7]_i_2_n_0 ),
        .O(\row_adr[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCDC8DD8DCDC8D888)) 
    \row_adr[5]_i_2 
       (.I0(pack_le0_i_3_n_0),
        .I1(wb_addr_i[15]),
        .I2(\col_adr[9]_i_3_n_0 ),
        .I3(wb_addr_i[16]),
        .I4(pack_le0_i_2_n_0),
        .I5(wb_addr_i[17]),
        .O(\row_adr[5]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hBABF8A80)) 
    \row_adr[6]_i_1 
       (.I0(\row_adr[6]_i_2_n_0 ),
        .I1(csc__0[9]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_csc[9]),
        .I4(\row_adr[8]_i_2_n_0 ),
        .O(\row_adr[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCDC8DD8DCDC8D888)) 
    \row_adr[6]_i_2 
       (.I0(pack_le0_i_3_n_0),
        .I1(wb_addr_i[16]),
        .I2(\col_adr[9]_i_3_n_0 ),
        .I3(wb_addr_i[17]),
        .I4(pack_le0_i_2_n_0),
        .I5(wb_addr_i[18]),
        .O(\row_adr[6]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hBABF8A80)) 
    \row_adr[7]_i_1 
       (.I0(\row_adr[7]_i_2_n_0 ),
        .I1(csc__0[9]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_csc[9]),
        .I4(\row_adr[9]_i_2_n_0 ),
        .O(\row_adr[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCDC8DD8DCDC8D888)) 
    \row_adr[7]_i_2 
       (.I0(pack_le0_i_3_n_0),
        .I1(wb_addr_i[17]),
        .I2(\col_adr[9]_i_3_n_0 ),
        .I3(wb_addr_i[18]),
        .I4(pack_le0_i_2_n_0),
        .I5(wb_addr_i[19]),
        .O(\row_adr[7]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hBABF8A80)) 
    \row_adr[8]_i_1 
       (.I0(\row_adr[8]_i_2_n_0 ),
        .I1(csc__0[9]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_csc[9]),
        .I4(\row_adr[10]_i_2_n_0 ),
        .O(\row_adr[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCDC8DD8DCDC8D888)) 
    \row_adr[8]_i_2 
       (.I0(pack_le0_i_3_n_0),
        .I1(wb_addr_i[18]),
        .I2(\col_adr[9]_i_3_n_0 ),
        .I3(wb_addr_i[19]),
        .I4(pack_le0_i_2_n_0),
        .I5(wb_addr_i[20]),
        .O(\row_adr[8]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB888BBBB)) 
    \row_adr[9]_i_1 
       (.I0(\row_adr[9]_i_2_n_0 ),
        .I1(\row_adr[12]_i_2_n_0 ),
        .I2(wb_addr_i[21]),
        .I3(pack_le0_i_3_n_0),
        .I4(\row_adr[9]_i_3_n_0 ),
        .O(\row_adr[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCDC8DD8DCDC8D888)) 
    \row_adr[9]_i_2 
       (.I0(pack_le0_i_3_n_0),
        .I1(wb_addr_i[19]),
        .I2(\col_adr[9]_i_3_n_0 ),
        .I3(wb_addr_i[20]),
        .I4(pack_le0_i_2_n_0),
        .I5(wb_addr_i[21]),
        .O(\row_adr[9]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAAFABFBFAFFABFB)) 
    \row_adr[9]_i_3 
       (.I0(pack_le0_i_3_n_0),
        .I1(wb_addr_i[23]),
        .I2(pack_le0_i_2_n_0),
        .I3(wb_addr_i[22]),
        .I4(\col_adr[9]_i_3_n_0 ),
        .I5(wb_addr_i[21]),
        .O(\row_adr[9]_i_3_n_0 ));
  MUXF7 \row_adr_reg[11]_i_1 
       (.I0(\row_adr[11]_i_2_n_0 ),
        .I1(\row_adr[11]_i_3_n_0 ),
        .O(\row_adr_reg[11]_i_1_n_0 ),
        .S(\row_adr[12]_i_2_n_0 ));
  MUXF7 \row_adr_reg[12]_i_1 
       (.I0(\row_adr[12]_i_3_n_0 ),
        .I1(\row_adr[12]_i_4_n_0 ),
        .O(\row_adr_reg[12]_i_1_n_0 ),
        .S(\row_adr[12]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT4 #(
    .INIT(16'h4F44)) 
    row_same_i_1
       (.I0(\mc_cs_[1]_i_2_n_0 ),
        .I1(row_same_i_2_n_0),
        .I2(row_same_i_3_n_0),
        .I3(\mc_cs_[0]_i_2_n_0 ),
        .O(\u2/row_same0 ));
  LUT6 #(
    .INIT(64'hCCF0FFAACCF000AA)) 
    row_same_i_2
       (.I0(\u2/u1/row0_same_carry__0_n_3 ),
        .I1(\u2/u1/row3_same_carry__0_n_3 ),
        .I2(\u2/u1/row1_same_carry__0_n_3 ),
        .I3(bank_adr[1]),
        .I4(bank_adr[0]),
        .I5(\u2/u1/row2_same_carry__0_n_3 ),
        .O(row_same_i_2_n_0));
  LUT6 #(
    .INIT(64'h000F3355FF0F3355)) 
    row_same_i_3
       (.I0(\u2/row0_same ),
        .I1(\u2/row1_same ),
        .I2(\u2/row2_same ),
        .I3(bank_adr[0]),
        .I4(bank_adr[1]),
        .I5(\u2/row3_same ),
        .O(row_same_i_3_n_0));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_csc[10]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[10] ),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/csc_reg_n_0_[10] ),
        .O(\sp_csc[10]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_csc[1]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[1] ),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/csc_reg_n_0_[1] ),
        .O(\sp_csc[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_csc[2]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[2] ),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/csc_reg_n_0_[2] ),
        .O(\sp_csc[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_csc[3]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[3] ),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/csc_reg_n_0_[3] ),
        .O(\sp_csc[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_csc[4]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[4] ),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/csc_reg_n_0_[4] ),
        .O(\sp_csc[4]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_csc[5]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[5] ),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/csc_reg_n_0_[5] ),
        .O(\sp_csc[5]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_csc[6]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[6] ),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/csc_reg_n_0_[6] ),
        .O(\sp_csc[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_csc[7]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[7] ),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/csc_reg_n_0_[7] ),
        .O(\sp_csc[7]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_csc[9]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[9] ),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/csc_reg_n_0_[9] ),
        .O(\sp_csc[9]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[0]_i_1 
       (.I0(tms[0]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[0] ),
        .O(\sp_tms[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[10]_i_1 
       (.I0(tms[10]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[10] ),
        .O(\sp_tms[10]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[11]_i_1 
       (.I0(tms[11]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[11] ),
        .O(\sp_tms[11]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[12]_i_1 
       (.I0(tms[12]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[12] ),
        .O(\sp_tms[12]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[13]_i_1 
       (.I0(tms[13]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[13] ),
        .O(\sp_tms[13]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[14]_i_1 
       (.I0(tms[14]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[14] ),
        .O(\sp_tms[14]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[15]_i_1 
       (.I0(tms[15]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[15] ),
        .O(\sp_tms[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[16]_i_1 
       (.I0(tms[16]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[16] ),
        .O(\sp_tms[16]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[17]_i_1 
       (.I0(tms[17]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[17] ),
        .O(\sp_tms[17]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[18]_i_1 
       (.I0(tms[18]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[18] ),
        .O(\sp_tms[18]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[19]_i_1 
       (.I0(tms[19]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[19] ),
        .O(\sp_tms[19]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[1]_i_1 
       (.I0(tms[1]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[1] ),
        .O(\sp_tms[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[20]_i_1 
       (.I0(tms[20]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[20] ),
        .O(\sp_tms[20]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[21]_i_1 
       (.I0(tms[21]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[21] ),
        .O(\sp_tms[21]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[22]_i_1 
       (.I0(tms[22]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[22] ),
        .O(\sp_tms[22]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[23]_i_1 
       (.I0(tms[23]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[23] ),
        .O(\sp_tms[23]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[24]_i_1 
       (.I0(tms[24]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[24] ),
        .O(\sp_tms[24]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[25]_i_1 
       (.I0(tms[25]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[25] ),
        .O(\sp_tms[25]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[26]_i_1 
       (.I0(tms[26]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[26] ),
        .O(\sp_tms[26]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[27]_i_1 
       (.I0(tms[27]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[27] ),
        .O(\sp_tms[27]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[2]_i_1 
       (.I0(tms[2]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[2] ),
        .O(\sp_tms[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[3]_i_1 
       (.I0(tms[3]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[3] ),
        .O(\sp_tms[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[4]_i_1 
       (.I0(tms[4]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[4] ),
        .O(\sp_tms[4]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[5]_i_1 
       (.I0(tms[5]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[5] ),
        .O(\sp_tms[5]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[6]_i_1 
       (.I0(tms[6]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[6] ),
        .O(\sp_tms[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[7]_i_1 
       (.I0(tms[7]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[7] ),
        .O(\sp_tms[7]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[8]_i_1 
       (.I0(tms[8]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[8] ),
        .O(\sp_tms[8]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \sp_tms[9]_i_1 
       (.I0(tms[9]),
        .I1(spec_req_cs[0]),
        .I2(spec_req_cs[1]),
        .I3(\u0/u1/tms_reg_n_0_[9] ),
        .O(\sp_tms[9]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spec_req_cs[1]_i_2 
       (.I0(\u0/u0/init_req_reg_n_0 ),
        .I1(init_req),
        .I2(\u0/u0/lmr_req_reg_n_0 ),
        .O(\u0/spec_req_cs_t ));
  LUT6 #(
    .INIT(64'h11F111F1FFFF11F1)) 
    sreq_cs_le_i_1
       (.I0(lmr_req),
        .I1(init_req),
        .I2(\u0/lmr_ack_r ),
        .I3(lmr_ack),
        .I4(\u0/init_ack_r ),
        .I5(init_ack),
        .O(\u0/sreq_cs_le0 ));
  LUT6 #(
    .INIT(64'hFFEFEFEFFF000000)) 
    susp_sel_r_i_1
       (.I0(\u5/state [2]),
        .I1(\u5/state [5]),
        .I2(\FSM_sequential_state[6]_i_7_n_0 ),
        .I3(\u5/burst_cnt_ld ),
        .I4(susp_sel_r_i_2_n_0),
        .I5(susp_sel),
        .O(susp_sel_r_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000011100000000)) 
    susp_sel_r_i_2
       (.I0(rfr_req),
        .I1(init_req),
        .I2(\u5/lookup_ready2 ),
        .I3(lmr_req),
        .I4(wb_cycle),
        .I5(\u5/susp_req_r ),
        .O(susp_sel_r_i_2_n_0));
  LUT6 #(
    .INIT(64'h0000000000000100)) 
    suspended_i_1
       (.I0(\u5/state [3]),
        .I1(\u5/state [2]),
        .I2(\u5/state [6]),
        .I3(\u5/state [4]),
        .I4(\u5/state [5]),
        .I5(suspended_i_2_n_0),
        .O(\u5/suspended_d ));
  (* SOFT_HLUTNM = "soft_lutpair123" *) 
  LUT2 #(
    .INIT(4'h8)) 
    suspended_i_2
       (.I0(\u5/state [0]),
        .I1(\u5/state [1]),
        .O(suspended_i_2_n_0));
  LUT6 #(
    .INIT(64'h0B00FFFF0B000B00)) 
    \timer2[0]_i_1 
       (.I0(\timer2[0]_i_2_n_0 ),
        .I1(\u5/timer2 [0]),
        .I2(\timer2[0]_i_3_n_0 ),
        .I3(\timer2[8]_i_4_n_0 ),
        .I4(\timer2[0]_i_4_n_0 ),
        .I5(\timer2[8]_i_9_n_0 ),
        .O(\timer2[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h7)) 
    \timer2[0]_i_2 
       (.I0(\timer2[8]_i_11_n_0 ),
        .I1(\timer2[7]_i_3_n_0 ),
        .O(\timer2[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h51510051)) 
    \timer2[0]_i_3 
       (.I0(\timer2[7]_i_3_n_0 ),
        .I1(\timer2[5]_i_3_n_0 ),
        .I2(\timer2[4]_i_4_n_0 ),
        .I3(\timer2[3]_i_6_n_0 ),
        .I4(\timer[0]_i_8_n_0 ),
        .O(\timer2[0]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0151)) 
    \timer2[0]_i_4 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[16]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[16] ),
        .O(\timer2[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0B00FFFF0B000B00)) 
    \timer2[1]_i_1 
       (.I0(\timer2[1]_i_2_n_0 ),
        .I1(\timer2[1]_i_3_n_0 ),
        .I2(\timer2[1]_i_4_n_0 ),
        .I3(\timer2[8]_i_4_n_0 ),
        .I4(\timer2[1]_i_5_n_0 ),
        .I5(\timer2[8]_i_9_n_0 ),
        .O(\timer2[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF88888F8FFFFFFFF)) 
    \timer2[1]_i_2 
       (.I0(\timer2[8]_i_5_n_0 ),
        .I1(\timer[0]_i_3_n_0 ),
        .I2(\timer2[8]_i_11_n_0 ),
        .I3(\u5/timer2 [0]),
        .I4(\u5/timer2 [1]),
        .I5(\timer2[7]_i_3_n_0 ),
        .O(\timer2[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT5 #(
    .INIT(32'h0047FFFF)) 
    \timer2[1]_i_3 
       (.I0(\u0/tms_reg_n_0_[8] ),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_tms[8]),
        .I3(\timer2[6]_i_3_n_0 ),
        .I4(mem_ack_r_i_4_n_0),
        .O(\timer2[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h2323202323202020)) 
    \timer2[1]_i_4 
       (.I0(\timer[1]_i_8_n_0 ),
        .I1(\timer2[7]_i_3_n_0 ),
        .I2(\timer2[3]_i_6_n_0 ),
        .I3(\timer2[3]_i_7_n_0 ),
        .I4(\timer2[5]_i_5_n_0 ),
        .I5(\timer2[0]_i_4_n_0 ),
        .O(\timer2[1]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h0151)) 
    \timer2[1]_i_5 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[17]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[17] ),
        .O(\timer2[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hD0DDD000DDDDDDDD)) 
    \timer2[2]_i_1 
       (.I0(\timer2[8]_i_9_n_0 ),
        .I1(\timer2[2]_i_2_n_0 ),
        .I2(\timer2[2]_i_3_n_0 ),
        .I3(\timer2[7]_i_3_n_0 ),
        .I4(\timer2[2]_i_4_n_0 ),
        .I5(\timer2[8]_i_4_n_0 ),
        .O(\timer2[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFEAE)) 
    \timer2[2]_i_2 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[18]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[18] ),
        .O(\timer2[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888BB8FFFF8BB8)) 
    \timer2[2]_i_3 
       (.I0(\timer[1]_i_2_n_0 ),
        .I1(\timer2[8]_i_5_n_0 ),
        .I2(\timer2[2]_i_5_n_0 ),
        .I3(\u5/timer2 [2]),
        .I4(mem_ack_r_i_4_n_0),
        .I5(\timer[1]_i_7_n_0 ),
        .O(\timer2[2]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h3530353F)) 
    \timer2[2]_i_4 
       (.I0(\timer[2]_i_8_n_0 ),
        .I1(\timer[2]_i_15_n_0 ),
        .I2(\timer2[3]_i_6_n_0 ),
        .I3(\timer2[3]_i_7_n_0 ),
        .I4(\timer2[1]_i_5_n_0 ),
        .O(\timer2[2]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \timer2[2]_i_5 
       (.I0(\u5/timer2 [1]),
        .I1(\u5/timer2 [0]),
        .O(\timer2[2]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h10FF1010)) 
    \timer2[3]_i_1 
       (.I0(\timer2[3]_i_2_n_0 ),
        .I1(\timer2[3]_i_3_n_0 ),
        .I2(\timer2[8]_i_4_n_0 ),
        .I3(\timer2[3]_i_4_n_0 ),
        .I4(\timer2[8]_i_9_n_0 ),
        .O(\timer2[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000880C88CC880C)) 
    \timer2[3]_i_2 
       (.I0(\timer[2]_i_14_n_0 ),
        .I1(\timer2[7]_i_3_n_0 ),
        .I2(\timer2[3]_i_5_n_0 ),
        .I3(mem_ack_r_i_4_n_0),
        .I4(\timer2[8]_i_5_n_0 ),
        .I5(\timer[2]_i_2_n_0 ),
        .O(\timer2[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h3331303103010001)) 
    \timer2[3]_i_3 
       (.I0(\timer2[2]_i_2_n_0 ),
        .I1(\timer2[7]_i_3_n_0 ),
        .I2(\timer2[3]_i_6_n_0 ),
        .I3(\timer2[3]_i_7_n_0 ),
        .I4(\timer2[7]_i_4_n_0 ),
        .I5(\timer[3]_i_10_n_0 ),
        .O(\timer2[3]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0151)) 
    \timer2[3]_i_4 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[19]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[19] ),
        .O(\timer2[3]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT4 #(
    .INIT(16'hAAA9)) 
    \timer2[3]_i_5 
       (.I0(\u5/timer2 [3]),
        .I1(\u5/timer2 [2]),
        .I2(\u5/timer2 [1]),
        .I3(\u5/timer2 [0]),
        .O(\timer2[3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000001014)) 
    \timer2[3]_i_6 
       (.I0(cke_r_i_5_n_0),
        .I1(\u5/state [5]),
        .I2(\u5/state [4]),
        .I3(\u5/cmd_asserted ),
        .I4(\u5/state [6]),
        .I5(mc_bg_i_4_n_0),
        .O(\timer2[3]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFBFFFFFFFFF)) 
    \timer2[3]_i_7 
       (.I0(\u5/state [4]),
        .I1(\u5/state [5]),
        .I2(\FSM_sequential_state[0]_i_3_n_0 ),
        .I3(\u5/state [6]),
        .I4(\u5/state [1]),
        .I5(\FSM_sequential_state[6]_i_32_n_0 ),
        .O(\timer2[3]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h10FF1010)) 
    \timer2[4]_i_1 
       (.I0(\timer2[4]_i_2_n_0 ),
        .I1(\timer2[4]_i_3_n_0 ),
        .I2(\timer2[8]_i_4_n_0 ),
        .I3(\timer2[4]_i_4_n_0 ),
        .I4(\timer2[8]_i_9_n_0 ),
        .O(\timer2[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h0000DDD0)) 
    \timer2[4]_i_2 
       (.I0(\timer2[7]_i_5_n_0 ),
        .I1(\timer2[8]_i_8_n_0 ),
        .I2(\timer2[3]_i_4_n_0 ),
        .I3(\timer2[4]_i_5_n_0 ),
        .I4(\timer2[7]_i_3_n_0 ),
        .O(\timer2[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8C8C8C80008C0080)) 
    \timer2[4]_i_3 
       (.I0(\timer[3]_i_9_n_0 ),
        .I1(\timer2[7]_i_3_n_0 ),
        .I2(mem_ack_r_i_4_n_0),
        .I3(\timer2[8]_i_5_n_0 ),
        .I4(\timer2[4]_i_6_n_0 ),
        .I5(\timer[3]_i_7_n_0 ),
        .O(\timer2[4]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0151)) 
    \timer2[4]_i_4 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[20]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[20] ),
        .O(\timer2[4]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT4 #(
    .INIT(16'hFFFB)) 
    \timer2[4]_i_5 
       (.I0(\timer2[3]_i_6_n_0 ),
        .I1(\u5/tmr2_done ),
        .I2(\u5/state [3]),
        .I3(\timer2[7]_i_8_n_0 ),
        .O(\timer2[4]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT5 #(
    .INIT(32'h55555556)) 
    \timer2[4]_i_6 
       (.I0(\u5/timer2 [4]),
        .I1(\u5/timer2 [3]),
        .I2(\u5/timer2 [0]),
        .I3(\u5/timer2 [1]),
        .I4(\u5/timer2 [2]),
        .O(\timer2[4]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h22F2FFFF22F222F2)) 
    \timer2[5]_i_1 
       (.I0(\timer2[8]_i_4_n_0 ),
        .I1(\timer2[5]_i_2_n_0 ),
        .I2(\timer2[5]_i_3_n_0 ),
        .I3(\timer2[5]_i_4_n_0 ),
        .I4(\timer2[5]_i_5_n_0 ),
        .I5(\timer2[8]_i_9_n_0 ),
        .O(\timer2[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7D007D7DFFFFFFFF)) 
    \timer2[5]_i_2 
       (.I0(\timer2[8]_i_11_n_0 ),
        .I1(\timer2[5]_i_6_n_0 ),
        .I2(\u5/timer2 [5]),
        .I3(\timer[4]_i_3_n_0 ),
        .I4(\timer2[8]_i_5_n_0 ),
        .I5(\timer2[7]_i_3_n_0 ),
        .O(\timer2[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000008000000000)) 
    \timer2[5]_i_3 
       (.I0(\u5/state [5]),
        .I1(\u5/state [1]),
        .I2(\FSM_sequential_state[5]_i_7_n_0 ),
        .I3(\u5/state [2]),
        .I4(\u5/state [6]),
        .I5(\u5/state [0]),
        .O(\timer2[5]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0151)) 
    \timer2[5]_i_4 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[25]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[25] ),
        .O(\timer2[5]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h0151)) 
    \timer2[5]_i_5 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[21]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[21] ),
        .O(\timer2[5]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \timer2[5]_i_6 
       (.I0(\u5/timer2 [4]),
        .I1(\u5/timer2 [3]),
        .I2(\u5/timer2 [0]),
        .I3(\u5/timer2 [1]),
        .I4(\u5/timer2 [2]),
        .O(\timer2[5]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFEEEFEAAAAAAAA)) 
    \timer2[6]_i_1 
       (.I0(\timer2[6]_i_2_n_0 ),
        .I1(\timer2[6]_i_3_n_0 ),
        .I2(sp_tms[22]),
        .I3(\timer2[6]_i_4_n_0 ),
        .I4(\u0/tms_reg_n_0_[22] ),
        .I5(\timer2[8]_i_9_n_0 ),
        .O(\timer2[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0880AAAA08800880)) 
    \timer2[6]_i_2 
       (.I0(\timer2[8]_i_7_n_0 ),
        .I1(\timer2[8]_i_11_n_0 ),
        .I2(\timer2[8]_i_10_n_0 ),
        .I3(\u5/timer2 [6]),
        .I4(\timer[5]_i_3_n_0 ),
        .I5(\timer2[8]_i_5_n_0 ),
        .O(\timer2[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFAAAA0200)) 
    \timer2[6]_i_3 
       (.I0(rfr_ack_r_i_7_n_0),
        .I1(rfr_ack_r_i_6_n_0),
        .I2(rfr_ack_r_i_5_n_0),
        .I3(rfr_ack_r_i_4_n_0),
        .I4(\timer2[6]_i_5_n_0 ),
        .I5(\timer2[6]_i_6_n_0 ),
        .O(\timer2[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h5555444555445555)) 
    \timer2[6]_i_4 
       (.I0(lmr_ack),
        .I1(lmr_ack_i_3_n_0),
        .I2(\u5/state [0]),
        .I3(\u5/state [1]),
        .I4(\u5/state [3]),
        .I5(\u5/state [2]),
        .O(\timer2[6]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT5 #(
    .INIT(32'h00800000)) 
    \timer2[6]_i_5 
       (.I0(\u5/state [1]),
        .I1(\u5/state [3]),
        .I2(\u5/state [0]),
        .I3(\u5/state [4]),
        .I4(\u5/state [2]),
        .O(\timer2[6]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT3 #(
    .INIT(8'hEF)) 
    \timer2[6]_i_6 
       (.I0(susp_sel),
        .I1(rfr_ack),
        .I2(mc_c_oe_d),
        .O(\timer2[6]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'h40FF4040)) 
    \timer2[7]_i_1 
       (.I0(\timer2[7]_i_2_n_0 ),
        .I1(\timer2[8]_i_4_n_0 ),
        .I2(\timer2[7]_i_3_n_0 ),
        .I3(\timer2[7]_i_4_n_0 ),
        .I4(\timer2[8]_i_9_n_0 ),
        .O(\timer2[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0DD00D0DDDDDDDDD)) 
    \timer2[7]_i_2 
       (.I0(\timer2[8]_i_5_n_0 ),
        .I1(\timer[6]_i_2_n_0 ),
        .I2(\u5/timer2 [7]),
        .I3(\u5/timer2 [6]),
        .I4(\timer2[8]_i_10_n_0 ),
        .I5(\timer2[8]_i_11_n_0 ),
        .O(\timer2[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAA8AAAAAAAAAAAAA)) 
    \timer2[7]_i_3 
       (.I0(\timer2[7]_i_5_n_0 ),
        .I1(\u5/state [6]),
        .I2(\u5/state [5]),
        .I3(\u5/state [4]),
        .I4(\timer2[7]_i_6_n_0 ),
        .I5(\timer2[7]_i_7_n_0 ),
        .O(\timer2[7]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0151)) 
    \timer2[7]_i_4 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[23]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[23] ),
        .O(\timer2[7]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT4 #(
    .INIT(16'h00FD)) 
    \timer2[7]_i_5 
       (.I0(\u5/tmr2_done ),
        .I1(\u5/state [3]),
        .I2(\timer2[7]_i_8_n_0 ),
        .I3(\timer2[3]_i_6_n_0 ),
        .O(\timer2[7]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair120" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \timer2[7]_i_6 
       (.I0(\u5/state [1]),
        .I1(\u5/state [2]),
        .O(\timer2[7]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \timer2[7]_i_7 
       (.I0(\u5/state [0]),
        .I1(\u5/state [3]),
        .O(\timer2[7]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFEFFFF)) 
    \timer2[7]_i_8 
       (.I0(\u5/state [1]),
        .I1(\u5/state [6]),
        .I2(\u5/state [2]),
        .I3(\u5/state [0]),
        .I4(\u5/state [5]),
        .I5(\u5/state [4]),
        .O(\timer2[7]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \timer2[8]_i_1 
       (.I0(\timer2[8]_i_3_n_0 ),
        .I1(\timer2[8]_i_4_n_0 ),
        .O(\u5/timer20 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \timer2[8]_i_10 
       (.I0(\u5/timer2 [5]),
        .I1(\u5/timer2 [2]),
        .I2(\u5/timer2 [1]),
        .I3(\u5/timer2 [0]),
        .I4(\u5/timer2 [3]),
        .I5(\u5/timer2 [4]),
        .O(\timer2[8]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF43FFFFFF)) 
    \timer2[8]_i_11 
       (.I0(\u5/state [1]),
        .I1(\u5/state [2]),
        .I2(\u5/state [3]),
        .I3(mem_ack_r_i_10_n_0),
        .I4(\u5/state [5]),
        .I5(\u5/state [6]),
        .O(\timer2[8]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hFEFFFFFFFFFFFFEF)) 
    \timer2[8]_i_12 
       (.I0(\u5/state [6]),
        .I1(\burst_cnt[10]_i_9_n_0 ),
        .I2(\u5/state [0]),
        .I3(\u5/state [3]),
        .I4(\u5/state [4]),
        .I5(\u5/state [5]),
        .O(\timer2[8]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hF200FFFFF200F200)) 
    \timer2[8]_i_2 
       (.I0(\timer2[8]_i_5_n_0 ),
        .I1(\timer[7]_i_8_n_0 ),
        .I2(\timer2[8]_i_6_n_0 ),
        .I3(\timer2[8]_i_7_n_0 ),
        .I4(\timer2[8]_i_8_n_0 ),
        .I5(\timer2[8]_i_9_n_0 ),
        .O(\timer2[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBFFFFFFFFFFFF)) 
    \timer2[8]_i_3 
       (.I0(\u5/timer2 [6]),
        .I1(\timer2[8]_i_10_n_0 ),
        .I2(\u5/timer2 [7]),
        .I3(\u5/timer2 [8]),
        .I4(\timer2[7]_i_3_n_0 ),
        .I5(\timer2[8]_i_11_n_0 ),
        .O(\timer2[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hDDDDDDDD0DCCDDDD)) 
    \timer2[8]_i_4 
       (.I0(\u5/state [4]),
        .I1(\timer2[8]_i_12_n_0 ),
        .I2(\u5/burst_cnt_ld ),
        .I3(\mc_addr[23]_i_3_n_0 ),
        .I4(\mc_addr[14]_i_4_n_0 ),
        .I5(\mc_addr[14]_i_2_n_0 ),
        .O(\timer2[8]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000400040000)) 
    \timer2[8]_i_5 
       (.I0(\u5/state [6]),
        .I1(\u5/state [5]),
        .I2(\u5/state [0]),
        .I3(\u5/state [4]),
        .I4(\u5/state [3]),
        .I5(\u5/state [2]),
        .O(\timer2[8]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hAA8A0020)) 
    \timer2[8]_i_6 
       (.I0(\timer2[8]_i_11_n_0 ),
        .I1(\u5/timer2 [6]),
        .I2(\timer2[8]_i_10_n_0 ),
        .I3(\u5/timer2 [7]),
        .I4(\u5/timer2 [8]),
        .O(\timer2[8]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \timer2[8]_i_7 
       (.I0(\timer2[8]_i_4_n_0 ),
        .I1(\timer2[7]_i_3_n_0 ),
        .O(\timer2[8]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h0151)) 
    \timer2[8]_i_8 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[24]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[24] ),
        .O(\timer2[8]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h1D00000000000000)) 
    \timer2[8]_i_9 
       (.I0(sp_csc[3]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(csc[3]),
        .I3(\mc_addr[14]_i_4_n_0 ),
        .I4(\mc_addr[23]_i_3_n_0 ),
        .I5(\u5/burst_cnt_ld ),
        .O(\timer2[8]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFB080)) 
    \timer[0]_i_1 
       (.I0(\timer[0]_i_2_n_0 ),
        .I1(\timer[7]_i_7_n_0 ),
        .I2(\timer[7]_i_5_n_0 ),
        .I3(\timer[0]_i_3_n_0 ),
        .I4(\timer[0]_i_4_n_0 ),
        .O(\timer[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h07FF0700)) 
    \timer[0]_i_2 
       (.I0(\timer[7]_i_11_n_0 ),
        .I1(\u5/timer [0]),
        .I2(\timer[0]_i_5_n_0 ),
        .I3(\timer[2]_i_4_n_0 ),
        .I4(\timer[0]_i_6_n_0 ),
        .O(\timer[0]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFEAE)) 
    \timer[0]_i_3 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[0]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[0] ),
        .O(\timer[0]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h4F44)) 
    \timer[0]_i_4 
       (.I0(\timer[0]_i_7_n_0 ),
        .I1(\timer[7]_i_12_n_0 ),
        .I2(\timer[0]_i_8_n_0 ),
        .I3(\timer[3]_i_11_n_0 ),
        .O(\timer[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hDDD088D0000088D0)) 
    \timer[0]_i_5 
       (.I0(\timer[0]_i_9_n_0 ),
        .I1(\timer[4]_i_3_n_0 ),
        .I2(\timer2[1]_i_5_n_0 ),
        .I3(\timer[2]_i_18_n_0 ),
        .I4(\timer[3]_i_8_n_0 ),
        .I5(\timer2[8]_i_8_n_0 ),
        .O(\timer[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800000047FFFF)) 
    \timer[0]_i_6 
       (.I0(\u0/tms_reg_n_0_[15] ),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(sp_tms[15]),
        .I3(\timer2[6]_i_3_n_0 ),
        .I4(\timer[2]_i_10_n_0 ),
        .I5(\timer2[4]_i_4_n_0 ),
        .O(\timer[0]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT4 #(
    .INIT(16'h0151)) 
    \timer[0]_i_7 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[8]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[8] ),
        .O(\timer[0]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h001D)) 
    \timer[0]_i_8 
       (.I0(sp_tms[12]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(\u0/tms_reg_n_0_[12] ),
        .I3(\timer2[6]_i_3_n_0 ),
        .O(\timer[0]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h0000000004000000)) 
    \timer[0]_i_9 
       (.I0(\u5/state [6]),
        .I1(\u5/state [0]),
        .I2(\u5/state [5]),
        .I3(\u5/state [3]),
        .I4(\u5/state [4]),
        .I5(\burst_cnt[10]_i_9_n_0 ),
        .O(\timer[0]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFA820)) 
    \timer[1]_i_1 
       (.I0(\timer[7]_i_5_n_0 ),
        .I1(\timer[7]_i_7_n_0 ),
        .I2(\timer[1]_i_2_n_0 ),
        .I3(\timer[1]_i_3_n_0 ),
        .I4(\timer[1]_i_4_n_0 ),
        .O(\timer[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFFE2)) 
    \timer[1]_i_2 
       (.I0(sp_tms[1]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(\u0/tms_reg_n_0_[1] ),
        .I3(\timer2[6]_i_3_n_0 ),
        .O(\timer[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h9999F0006666FF0F)) 
    \timer[1]_i_3 
       (.I0(\timer[1]_i_5_n_0 ),
        .I1(\timer2[0]_i_4_n_0 ),
        .I2(\timer[2]_i_9_n_0 ),
        .I3(\timer[1]_i_6_n_0 ),
        .I4(\timer[2]_i_10_n_0 ),
        .I5(\timer2[5]_i_5_n_0 ),
        .O(\timer[1]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h4F44)) 
    \timer[1]_i_4 
       (.I0(\timer[1]_i_7_n_0 ),
        .I1(\timer[7]_i_12_n_0 ),
        .I2(\timer[1]_i_8_n_0 ),
        .I3(\timer[3]_i_11_n_0 ),
        .O(\timer[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFA0CCA000)) 
    \timer[1]_i_5 
       (.I0(\u0/tms_reg_n_0_[15] ),
        .I1(sp_tms[15]),
        .I2(\u0/tms_reg_n_0_[20] ),
        .I3(\timer2[6]_i_4_n_0 ),
        .I4(sp_tms[20]),
        .I5(\timer2[6]_i_3_n_0 ),
        .O(\timer[1]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h82AA)) 
    \timer[1]_i_6 
       (.I0(\timer[1]_i_9_n_0 ),
        .I1(\u5/timer [1]),
        .I2(\u5/timer [0]),
        .I3(\timer[7]_i_11_n_0 ),
        .O(\timer[1]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h001D)) 
    \timer[1]_i_7 
       (.I0(sp_tms[9]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(\u0/tms_reg_n_0_[9] ),
        .I3(\timer2[6]_i_3_n_0 ),
        .O(\timer[1]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h0151)) 
    \timer[1]_i_8 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[13]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[13] ),
        .O(\timer[1]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h27F727F7FFFF22F2)) 
    \timer[1]_i_9 
       (.I0(\timer[0]_i_9_n_0 ),
        .I1(\timer[5]_i_3_n_0 ),
        .I2(\timer[3]_i_8_n_0 ),
        .I3(\timer2[5]_i_4_n_0 ),
        .I4(\timer2[2]_i_2_n_0 ),
        .I5(\timer[2]_i_18_n_0 ),
        .O(\timer[1]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF040E0E0E)) 
    \timer[2]_i_1 
       (.I0(\timer[7]_i_7_n_0 ),
        .I1(\timer[2]_i_2_n_0 ),
        .I2(\timer[2]_i_3_n_0 ),
        .I3(\timer[2]_i_4_n_0 ),
        .I4(\timer[2]_i_5_n_0 ),
        .I5(\timer[2]_i_6_n_0 ),
        .O(\timer[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000101000)) 
    \timer[2]_i_10 
       (.I0(cke_r_i_5_n_0),
        .I1(\u5/state [5]),
        .I2(\u5/state [4]),
        .I3(\u5/state [3]),
        .I4(\u5/state [2]),
        .I5(\u5/state [6]),
        .O(\timer[2]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    \timer[2]_i_11 
       (.I0(\u5/state [2]),
        .I1(\u5/state [4]),
        .I2(\u5/state [3]),
        .I3(\u5/state [6]),
        .I4(\u5/state [5]),
        .I5(\u5/state [1]),
        .O(\timer[2]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h01000000FFFFFFFF)) 
    \timer[2]_i_12 
       (.I0(\u5/state [4]),
        .I1(\u5/state [3]),
        .I2(\burst_cnt[10]_i_9_n_0 ),
        .I3(\u5/state [6]),
        .I4(\timer[2]_i_17_n_0 ),
        .I5(\timer[7]_i_17_n_0 ),
        .O(\timer[2]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF55544454)) 
    \timer[2]_i_13 
       (.I0(\timer[2]_i_18_n_0 ),
        .I1(\timer2[6]_i_3_n_0 ),
        .I2(sp_tms[19]),
        .I3(\timer2[6]_i_4_n_0 ),
        .I4(\u0/tms_reg_n_0_[19] ),
        .I5(\timer[2]_i_19_n_0 ),
        .O(\timer[2]_i_13_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT4 #(
    .INIT(16'h001D)) 
    \timer[2]_i_14 
       (.I0(sp_tms[10]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(\u0/tms_reg_n_0_[10] ),
        .I3(\timer2[6]_i_3_n_0 ),
        .O(\timer[2]_i_14_n_0 ));
  LUT4 #(
    .INIT(16'h0151)) 
    \timer[2]_i_15 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[14]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[14] ),
        .O(\timer[2]_i_15_n_0 ));
  LUT6 #(
    .INIT(64'hF7AF77AFF7AFF7AF)) 
    \timer[2]_i_16 
       (.I0(\u5/state [4]),
        .I1(\u5/state [3]),
        .I2(\u5/state [1]),
        .I3(\u5/state [2]),
        .I4(ap_en_i_2_n_0),
        .I5(\u5/tmr_done ),
        .O(\timer[2]_i_16_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \timer[2]_i_17 
       (.I0(\u5/state [5]),
        .I1(\u5/state [0]),
        .O(\timer[2]_i_17_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT5 #(
    .INIT(32'hFDFFFFFF)) 
    \timer[2]_i_18 
       (.I0(\u5/state [4]),
        .I1(\u5/state [1]),
        .I2(\u5/wb_wait_r ),
        .I3(\u5/state [2]),
        .I4(\ir_cnt[3]_i_4_n_0 ),
        .O(\timer[2]_i_18_n_0 ));
  LUT5 #(
    .INIT(32'hAAAA8A80)) 
    \timer[2]_i_19 
       (.I0(\timer[3]_i_8_n_0 ),
        .I1(\u0/tms_reg_n_0_[26] ),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_tms[26]),
        .I4(\timer2[6]_i_3_n_0 ),
        .O(\timer[2]_i_19_n_0 ));
  LUT4 #(
    .INIT(16'hFFE2)) 
    \timer[2]_i_2 
       (.I0(sp_tms[2]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(\u0/tms_reg_n_0_[2] ),
        .I3(\timer2[6]_i_3_n_0 ),
        .O(\timer[2]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h5D7D)) 
    \timer[2]_i_3 
       (.I0(\timer[7]_i_5_n_0 ),
        .I1(\timer[2]_i_7_n_0 ),
        .I2(\timer[2]_i_8_n_0 ),
        .I3(\timer[2]_i_4_n_0 ),
        .O(\timer[2]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \timer[2]_i_4 
       (.I0(\timer[2]_i_9_n_0 ),
        .I1(\timer[2]_i_10_n_0 ),
        .O(\timer[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFFF0154)) 
    \timer[2]_i_5 
       (.I0(\timer[2]_i_11_n_0 ),
        .I1(\u5/timer [1]),
        .I2(\u5/timer [0]),
        .I3(\u5/timer [2]),
        .I4(\timer[2]_i_12_n_0 ),
        .I5(\timer[2]_i_13_n_0 ),
        .O(\timer[2]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h4F44)) 
    \timer[2]_i_6 
       (.I0(\timer[2]_i_14_n_0 ),
        .I1(\timer[7]_i_12_n_0 ),
        .I2(\timer[2]_i_15_n_0 ),
        .I3(\timer[3]_i_11_n_0 ),
        .O(\timer[2]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h088A)) 
    \timer[2]_i_7 
       (.I0(\timer[2]_i_10_n_0 ),
        .I1(\timer[1]_i_5_n_0 ),
        .I2(\timer2[0]_i_4_n_0 ),
        .I3(\timer2[5]_i_5_n_0 ),
        .O(\timer[2]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h0151)) 
    \timer[2]_i_8 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[22]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[22] ),
        .O(\timer[2]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hEEEEE2EEFFFFFFFF)) 
    \timer[2]_i_9 
       (.I0(\timer[2]_i_16_n_0 ),
        .I1(\u5/state [0]),
        .I2(\u5/state [4]),
        .I3(\u5/state [2]),
        .I4(\u5/state [1]),
        .I5(rfr_ack_r_i_7_n_0),
        .O(\timer[2]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFD50000)) 
    \timer[3]_i_1 
       (.I0(\timer[3]_i_2_n_0 ),
        .I1(\timer[7]_i_3_n_0 ),
        .I2(\timer[3]_i_3_n_0 ),
        .I3(\timer[3]_i_4_n_0 ),
        .I4(\timer[7]_i_5_n_0 ),
        .I5(\timer[3]_i_5_n_0 ),
        .O(\timer[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0151)) 
    \timer[3]_i_10 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[15]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[15] ),
        .O(\timer[3]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFFF0008)) 
    \timer[3]_i_11 
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(\FSM_sequential_state[5]_i_8_n_0 ),
        .I2(\timer[3]_i_12_n_0 ),
        .I3(\FSM_sequential_state[5]_i_9_n_0 ),
        .I4(\timer[3]_i_13_n_0 ),
        .I5(\timer[7]_i_13_n_0 ),
        .O(\timer[3]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h5D5D5DFFFFFF5DFF)) 
    \timer[3]_i_12 
       (.I0(wb_write_go),
        .I1(wb_cyc_i),
        .I2(wb_stb_i),
        .I3(sp_csc[1]),
        .I4(\timer2[6]_i_4_n_0 ),
        .I5(csc[1]),
        .O(\timer[3]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair119" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \timer[3]_i_13 
       (.I0(\u5/state [5]),
        .I1(\u5/state [3]),
        .O(\timer[3]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hBBBBAABA8888AA8A)) 
    \timer[3]_i_2 
       (.I0(\timer[3]_i_6_n_0 ),
        .I1(\timer[7]_i_9_n_0 ),
        .I2(\mc_addr[23]_i_3_n_0 ),
        .I3(\timer[7]_i_10_n_0 ),
        .I4(\u5/state [4]),
        .I5(\timer[3]_i_7_n_0 ),
        .O(\timer[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'hAAA9)) 
    \timer[3]_i_3 
       (.I0(\u5/timer [3]),
        .I1(\u5/timer [2]),
        .I2(\u5/timer [1]),
        .I3(\u5/timer [0]),
        .O(\timer[3]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hAAAA8A80)) 
    \timer[3]_i_4 
       (.I0(\timer[3]_i_8_n_0 ),
        .I1(\u0/tms_reg_n_0_[27] ),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(sp_tms[27]),
        .I4(\timer2[6]_i_3_n_0 ),
        .O(\timer[3]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h4F44)) 
    \timer[3]_i_5 
       (.I0(\timer[3]_i_9_n_0 ),
        .I1(\timer[7]_i_12_n_0 ),
        .I2(\timer[3]_i_10_n_0 ),
        .I3(\timer[3]_i_11_n_0 ),
        .O(\timer[3]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT5 #(
    .INIT(32'hF4F40FF4)) 
    \timer[3]_i_6 
       (.I0(\timer[2]_i_10_n_0 ),
        .I1(\timer[2]_i_9_n_0 ),
        .I2(\timer2[7]_i_4_n_0 ),
        .I3(\timer[2]_i_7_n_0 ),
        .I4(\timer[2]_i_8_n_0 ),
        .O(\timer[3]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT4 #(
    .INIT(16'h0151)) 
    \timer[3]_i_7 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[3]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[3] ),
        .O(\timer[3]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0000080012008000)) 
    \timer[3]_i_8 
       (.I0(\u5/state [0]),
        .I1(\u5/state [1]),
        .I2(\u5/state [2]),
        .I3(rfr_ack_r_i_7_n_0),
        .I4(\u5/state [3]),
        .I5(\u5/state [4]),
        .O(\timer[3]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'h001D)) 
    \timer[3]_i_9 
       (.I0(sp_tms[11]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(\u0/tms_reg_n_0_[11] ),
        .I3(\timer2[6]_i_3_n_0 ),
        .O(\timer[3]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h088008800880AAAA)) 
    \timer[4]_i_1 
       (.I0(\timer[7]_i_5_n_0 ),
        .I1(\timer[7]_i_3_n_0 ),
        .I2(\timer[4]_i_2_n_0 ),
        .I3(\u5/timer [4]),
        .I4(\timer[7]_i_7_n_0 ),
        .I5(\timer[4]_i_3_n_0 ),
        .O(\timer[4]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \timer[4]_i_2 
       (.I0(\u5/timer [2]),
        .I1(\u5/timer [1]),
        .I2(\u5/timer [0]),
        .I3(\u5/timer [3]),
        .O(\timer[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT4 #(
    .INIT(16'h001D)) 
    \timer[4]_i_3 
       (.I0(sp_tms[4]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(\u0/tms_reg_n_0_[4] ),
        .I3(\timer2[6]_i_3_n_0 ),
        .O(\timer[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h088008800880AAAA)) 
    \timer[5]_i_1 
       (.I0(\timer[7]_i_5_n_0 ),
        .I1(\timer[7]_i_3_n_0 ),
        .I2(\timer[5]_i_2_n_0 ),
        .I3(\u5/timer [5]),
        .I4(\timer[7]_i_7_n_0 ),
        .I5(\timer[5]_i_3_n_0 ),
        .O(\timer[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    \timer[5]_i_2 
       (.I0(\u5/timer [3]),
        .I1(\u5/timer [0]),
        .I2(\u5/timer [1]),
        .I3(\u5/timer [2]),
        .I4(\u5/timer [4]),
        .O(\timer[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT4 #(
    .INIT(16'h0151)) 
    \timer[5]_i_3 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[5]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[5] ),
        .O(\timer[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h088008800880AAAA)) 
    \timer[6]_i_1 
       (.I0(\timer[7]_i_5_n_0 ),
        .I1(\timer[7]_i_3_n_0 ),
        .I2(\timer[7]_i_4_n_0 ),
        .I3(\u5/timer [6]),
        .I4(\timer[7]_i_7_n_0 ),
        .I5(\timer[6]_i_2_n_0 ),
        .O(\timer[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT4 #(
    .INIT(16'h0151)) 
    \timer[6]_i_2 
       (.I0(\timer2[6]_i_3_n_0 ),
        .I1(sp_tms[6]),
        .I2(\timer2[6]_i_4_n_0 ),
        .I3(\u0/tms_reg_n_0_[6] ),
        .O(\timer[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h77777577FFFFFFFF)) 
    \timer[7]_i_1 
       (.I0(\timer[7]_i_3_n_0 ),
        .I1(\u5/mc_le ),
        .I2(\u5/timer [7]),
        .I3(\timer[7]_i_4_n_0 ),
        .I4(\u5/timer [6]),
        .I5(\timer[7]_i_5_n_0 ),
        .O(\timer[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFBFBBFFFFFFFF)) 
    \timer[7]_i_10 
       (.I0(wb_write_go),
        .I1(\mc_addr[14]_i_4_n_0 ),
        .I2(wb_stb_i),
        .I3(wb_cyc_i),
        .I4(\FSM_sequential_state[5]_i_9_n_0 ),
        .I5(\FSM_sequential_state[5]_i_8_n_0 ),
        .O(\timer[7]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h4440444444444444)) 
    \timer[7]_i_11 
       (.I0(\timer[2]_i_11_n_0 ),
        .I1(\timer[7]_i_17_n_0 ),
        .I2(\u5/state [5]),
        .I3(\u5/state [0]),
        .I4(\u5/state [6]),
        .I5(\timer[7]_i_18_n_0 ),
        .O(\timer[7]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h8000800080000000)) 
    \timer[7]_i_12 
       (.I0(\timer[7]_i_16_n_0 ),
        .I1(\u5/state [5]),
        .I2(\u5/state [4]),
        .I3(\u5/state [1]),
        .I4(\u5/tmr_done ),
        .I5(\u5/state [0]),
        .O(\timer[7]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT5 #(
    .INIT(32'hFFFFFFBE)) 
    \timer[7]_i_13 
       (.I0(\FSM_sequential_state[5]_i_3_n_0 ),
        .I1(\u5/state [5]),
        .I2(\u5/state [3]),
        .I3(\u5/state [6]),
        .I4(\u5/state [4]),
        .O(\timer[7]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h8A00000000000000)) 
    \timer[7]_i_14 
       (.I0(\mc_addr[14]_i_4_n_0 ),
        .I1(wb_stb_i),
        .I2(wb_cyc_i),
        .I3(wb_write_go),
        .I4(\FSM_sequential_state[5]_i_8_n_0 ),
        .I5(\mc_addr[23]_i_3_n_0 ),
        .O(\timer[7]_i_14_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \timer[7]_i_15 
       (.I0(\u5/state [1]),
        .I1(\u5/state [0]),
        .O(\timer[7]_i_15_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \timer[7]_i_16 
       (.I0(\u5/state [6]),
        .I1(\u5/state [2]),
        .I2(\u5/state [3]),
        .O(\timer[7]_i_16_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \timer[7]_i_17 
       (.I0(\timer[0]_i_9_n_0 ),
        .I1(\timer[2]_i_18_n_0 ),
        .I2(\timer[3]_i_8_n_0 ),
        .O(\timer[7]_i_17_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \timer[7]_i_18 
       (.I0(\u5/state [4]),
        .I1(\u5/state [3]),
        .I2(\u5/state [1]),
        .I3(\u5/state [2]),
        .O(\timer[7]_i_18_n_0 ));
  LUT6 #(
    .INIT(64'h088008800880AAAA)) 
    \timer[7]_i_2 
       (.I0(\timer[7]_i_5_n_0 ),
        .I1(\timer[7]_i_3_n_0 ),
        .I2(\timer[7]_i_6_n_0 ),
        .I3(\u5/timer [7]),
        .I4(\timer[7]_i_7_n_0 ),
        .I5(\timer[7]_i_8_n_0 ),
        .O(\timer[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8888AA8A00000000)) 
    \timer[7]_i_3 
       (.I0(\timer[2]_i_4_n_0 ),
        .I1(\timer[7]_i_9_n_0 ),
        .I2(\mc_addr[23]_i_3_n_0 ),
        .I3(\timer[7]_i_10_n_0 ),
        .I4(\u5/state [4]),
        .I5(\timer[7]_i_11_n_0 ),
        .O(\timer[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \timer[7]_i_4 
       (.I0(\u5/timer [4]),
        .I1(\u5/timer [2]),
        .I2(\u5/timer [1]),
        .I3(\u5/timer [0]),
        .I4(\u5/timer [3]),
        .I5(\u5/timer [5]),
        .O(\timer[7]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h4555444445554555)) 
    \timer[7]_i_5 
       (.I0(\timer[7]_i_12_n_0 ),
        .I1(\timer[7]_i_13_n_0 ),
        .I2(\u5/state [3]),
        .I3(\u5/state [5]),
        .I4(\FSM_sequential_state[5]_i_9_n_0 ),
        .I5(\timer[7]_i_14_n_0 ),
        .O(\timer[7]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \timer[7]_i_6 
       (.I0(\timer[7]_i_4_n_0 ),
        .I1(\u5/timer [6]),
        .O(\timer[7]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hDFDFDFDFFFFFEFFF)) 
    \timer[7]_i_7 
       (.I0(\u5/state [5]),
        .I1(\timer[7]_i_15_n_0 ),
        .I2(\timer[7]_i_16_n_0 ),
        .I3(\mc_addr[23]_i_3_n_0 ),
        .I4(\timer[7]_i_10_n_0 ),
        .I5(\u5/state [4]),
        .O(\timer[7]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT4 #(
    .INIT(16'h001D)) 
    \timer[7]_i_8 
       (.I0(sp_tms[7]),
        .I1(\timer2[6]_i_4_n_0 ),
        .I2(\u0/tms_reg_n_0_[7] ),
        .I3(\timer2[6]_i_3_n_0 ),
        .O(\timer[7]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFFFEFFFFFFFFFFFE)) 
    \timer[7]_i_9 
       (.I0(\u5/state [6]),
        .I1(\u5/state [2]),
        .I2(\u5/state [3]),
        .I3(\timer[7]_i_15_n_0 ),
        .I4(\u5/state [4]),
        .I5(\u5/state [5]),
        .O(\timer[7]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    tmr2_done_i_1
       (.I0(\timer2[8]_i_9_n_0 ),
        .I1(\timer2[8]_i_3_n_0 ),
        .O(\u5/tmr2_done0 ));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT3 #(
    .INIT(8'h04)) 
    tmr_done_i_1
       (.I0(\u5/timer [6]),
        .I1(\timer[7]_i_4_n_0 ),
        .I2(\u5/timer [7]),
        .O(\u5/timer_is_zero ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[0]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[0]),
        .I4(\u0/u1/tms_reg_n_0_[0] ),
        .I5(\u0/sel0 ),
        .O(\tms[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[10]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[10]),
        .I4(\u0/u1/tms_reg_n_0_[10] ),
        .I5(\u0/sel0 ),
        .O(\tms[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[11]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[11]),
        .I4(\u0/u1/tms_reg_n_0_[11] ),
        .I5(\u0/sel0 ),
        .O(\tms[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[12]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[12]),
        .I4(\u0/u1/tms_reg_n_0_[12] ),
        .I5(\u0/sel0 ),
        .O(\tms[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[13]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[13]),
        .I4(\u0/u1/tms_reg_n_0_[13] ),
        .I5(\u0/sel0 ),
        .O(\tms[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[14]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[14]),
        .I4(\u0/u1/tms_reg_n_0_[14] ),
        .I5(\u0/sel0 ),
        .O(\tms[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[15]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[15]),
        .I4(\u0/u1/tms_reg_n_0_[15] ),
        .I5(\u0/sel0 ),
        .O(\tms[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[16]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[16]),
        .I4(\u0/u1/tms_reg_n_0_[16] ),
        .I5(\u0/sel0 ),
        .O(\tms[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[17]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[17]),
        .I4(\u0/u1/tms_reg_n_0_[17] ),
        .I5(\u0/sel0 ),
        .O(\tms[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[18]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[18]),
        .I4(\u0/u1/tms_reg_n_0_[18] ),
        .I5(\u0/sel0 ),
        .O(\tms[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[19]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[19]),
        .I4(\u0/u1/tms_reg_n_0_[19] ),
        .I5(\u0/sel0 ),
        .O(\tms[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[1]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[1]),
        .I4(\u0/u1/tms_reg_n_0_[1] ),
        .I5(\u0/sel0 ),
        .O(\tms[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[20]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[20]),
        .I4(\u0/u1/tms_reg_n_0_[20] ),
        .I5(\u0/sel0 ),
        .O(\tms[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[21]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[21]),
        .I4(\u0/u1/tms_reg_n_0_[21] ),
        .I5(\u0/sel0 ),
        .O(\tms[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[22]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[22]),
        .I4(\u0/u1/tms_reg_n_0_[22] ),
        .I5(\u0/sel0 ),
        .O(\tms[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[23]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[23]),
        .I4(\u0/u1/tms_reg_n_0_[23] ),
        .I5(\u0/sel0 ),
        .O(\tms[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[24]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[24]),
        .I4(\u0/u1/tms_reg_n_0_[24] ),
        .I5(\u0/sel0 ),
        .O(\tms[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[25]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[25]),
        .I4(\u0/u1/tms_reg_n_0_[25] ),
        .I5(\u0/sel0 ),
        .O(\tms[25]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[26]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[26]),
        .I4(\u0/u1/tms_reg_n_0_[26] ),
        .I5(\u0/sel0 ),
        .O(\tms[26]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h8880)) 
    \tms[27]_i_1 
       (.I0(wb_cyc_i),
        .I1(wb_stb_i),
        .I2(cs_le_d),
        .I3(\u0/rf_we ),
        .O(\tms[27]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[27]_i_2 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[27]),
        .I4(\u0/u1/tms_reg_n_0_[27] ),
        .I5(\u0/sel0 ),
        .O(\tms[27]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[2]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[2]),
        .I4(\u0/u1/tms_reg_n_0_[2] ),
        .I5(\u0/sel0 ),
        .O(\tms[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[3]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[3]),
        .I4(\u0/u1/tms_reg_n_0_[3] ),
        .I5(\u0/sel0 ),
        .O(\tms[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[4]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[4]),
        .I4(\u0/u1/tms_reg_n_0_[4] ),
        .I5(\u0/sel0 ),
        .O(\tms[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[5]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[5]),
        .I4(\u0/u1/tms_reg_n_0_[5] ),
        .I5(\u0/sel0 ),
        .O(\tms[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[6]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[6]),
        .I4(\u0/u1/tms_reg_n_0_[6] ),
        .I5(\u0/sel0 ),
        .O(\tms[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[7]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[7]),
        .I4(\u0/u1/tms_reg_n_0_[7] ),
        .I5(\u0/sel0 ),
        .O(\tms[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[8]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[8]),
        .I4(\u0/u1/tms_reg_n_0_[8] ),
        .I5(\u0/sel0 ),
        .O(\tms[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8070007000700)) 
    \tms[9]_i_1 
       (.I0(\u0/u0/csc_reg_n_0_[8] ),
        .I1(wb_we_i),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(tms[9]),
        .I4(\u0/u1/tms_reg_n_0_[9] ),
        .I5(\u0/sel0 ),
        .O(\tms[9]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \u0/cs[1]_i_1 
       (.I0(\u0/sel0 ),
        .I1(cs_le),
        .I2(cs[1]),
        .O(\u0/cs[1]_i_1_n_0 ));
  FDCE \u0/cs_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\cs[0]_i_1_n_0 ),
        .Q(cs[0]));
  FDCE \u0/cs_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u0/cs[1]_i_1_n_0 ),
        .Q(cs[1]));
  FDPE \u0/csc_mask_r_reg[0] 
       (.C(clk_i),
        .CE(\u0/csc_mask_r0 ),
        .D(wb_data_i[0]),
        .PRE(rst_i),
        .Q(\u0/csc_mask [0]));
  FDPE \u0/csc_mask_r_reg[10] 
       (.C(clk_i),
        .CE(\u0/csc_mask_r0 ),
        .D(wb_data_i[10]),
        .PRE(rst_i),
        .Q(\u0/csc_mask_r_reg_n_0_[10] ));
  FDPE \u0/csc_mask_r_reg[1] 
       (.C(clk_i),
        .CE(\u0/csc_mask_r0 ),
        .D(wb_data_i[1]),
        .PRE(rst_i),
        .Q(\u0/csc_mask [1]));
  FDPE \u0/csc_mask_r_reg[2] 
       (.C(clk_i),
        .CE(\u0/csc_mask_r0 ),
        .D(wb_data_i[2]),
        .PRE(rst_i),
        .Q(\u0/csc_mask [2]));
  FDPE \u0/csc_mask_r_reg[3] 
       (.C(clk_i),
        .CE(\u0/csc_mask_r0 ),
        .D(wb_data_i[3]),
        .PRE(rst_i),
        .Q(\u0/csc_mask [3]));
  FDPE \u0/csc_mask_r_reg[4] 
       (.C(clk_i),
        .CE(\u0/csc_mask_r0 ),
        .D(wb_data_i[4]),
        .PRE(rst_i),
        .Q(\u0/csc_mask [4]));
  FDPE \u0/csc_mask_r_reg[5] 
       (.C(clk_i),
        .CE(\u0/csc_mask_r0 ),
        .D(wb_data_i[5]),
        .PRE(rst_i),
        .Q(\u0/csc_mask [5]));
  FDPE \u0/csc_mask_r_reg[6] 
       (.C(clk_i),
        .CE(\u0/csc_mask_r0 ),
        .D(wb_data_i[6]),
        .PRE(rst_i),
        .Q(\u0/csc_mask [6]));
  FDPE \u0/csc_mask_r_reg[7] 
       (.C(clk_i),
        .CE(\u0/csc_mask_r0 ),
        .D(wb_data_i[7]),
        .PRE(rst_i),
        .Q(\u0/csc_mask [7]));
  FDPE \u0/csc_mask_r_reg[8] 
       (.C(clk_i),
        .CE(\u0/csc_mask_r0 ),
        .D(wb_data_i[8]),
        .PRE(rst_i),
        .Q(\u0/csc_mask_r_reg_n_0_[8] ));
  FDPE \u0/csc_mask_r_reg[9] 
       (.C(clk_i),
        .CE(\u0/csc_mask_r0 ),
        .D(wb_data_i[9]),
        .PRE(rst_i),
        .Q(\u0/csc_mask_r_reg_n_0_[9] ));
  FDCE \u0/csc_reg[10] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\csc[10]_i_1_n_0 ),
        .Q(csc__0[10]));
  FDCE \u0/csc_reg[11] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\csc[11]_i_2_n_0 ),
        .Q(csc[11]));
  FDCE \u0/csc_reg[1] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\csc[1]_i_1__0_n_0 ),
        .Q(csc[1]));
  FDCE \u0/csc_reg[2] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\csc[2]_i_1__0_n_0 ),
        .Q(csc[2]));
  FDCE \u0/csc_reg[3] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\csc[3]_i_1_n_0 ),
        .Q(csc[3]));
  FDCE \u0/csc_reg[4] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\csc[4]_i_1__0_n_0 ),
        .Q(csc[4]));
  FDCE \u0/csc_reg[5] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\csc[5]_i_1__0_n_0 ),
        .Q(csc[5]));
  FDCE \u0/csc_reg[6] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\csc[6]_i_1_n_0 ),
        .Q(csc__0[6]));
  FDCE \u0/csc_reg[7] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\csc[7]_i_1_n_0 ),
        .Q(csc__0[7]));
  FDCE \u0/csc_reg[9] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\csc[9]_i_1_n_0 ),
        .Q(csc__0[9]));
  FDCE \u0/csr_r2_reg[0] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[24]),
        .Q(rfr_ps_val[0]));
  FDCE \u0/csr_r2_reg[1] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[25]),
        .Q(rfr_ps_val[1]));
  FDCE \u0/csr_r2_reg[2] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[26]),
        .Q(rfr_ps_val[2]));
  FDCE \u0/csr_r2_reg[3] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[27]),
        .Q(rfr_ps_val[3]));
  FDCE \u0/csr_r2_reg[4] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[28]),
        .Q(rfr_ps_val[4]));
  FDCE \u0/csr_r2_reg[5] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[29]),
        .Q(rfr_ps_val[5]));
  FDCE \u0/csr_r2_reg[6] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[30]),
        .Q(rfr_ps_val[6]));
  FDCE \u0/csr_r2_reg[7] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[31]),
        .Q(rfr_ps_val[7]));
  FDRE \u0/csr_r_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(mc_sts_ir),
        .Q(\u0/csr_r_reg_n_0_[0] ),
        .R(\<const0> ));
  FDCE \u0/csr_r_reg[10] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[10]),
        .Q(sel0[2]));
  FDCE \u0/csr_r_reg[1] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[1]),
        .Q(mc_vpen_pad_o));
  FDCE \u0/csr_r_reg[2] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[2]),
        .Q(fs));
  FDCE \u0/csr_r_reg[3] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[3]),
        .Q(\u0/csr_r_reg_n_0_[3] ));
  FDCE \u0/csr_r_reg[4] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[4]),
        .Q(\u0/csr_r_reg_n_0_[4] ));
  FDCE \u0/csr_r_reg[5] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[5]),
        .Q(\u0/csr_r_reg_n_0_[5] ));
  FDCE \u0/csr_r_reg[6] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[6]),
        .Q(\u0/csr_r_reg_n_0_[6] ));
  FDCE \u0/csr_r_reg[7] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[7]),
        .Q(\u0/csr_r_reg_n_0_[7] ));
  FDCE \u0/csr_r_reg[8] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[8]),
        .Q(sel0[0]));
  FDCE \u0/csr_r_reg[9] 
       (.C(clk_i),
        .CE(\u0/csr_r20 ),
        .CLR(rst_i),
        .D(wb_data_i[9]),
        .Q(sel0[1]));
  FDRE \u0/init_ack_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(init_ack),
        .Q(\u0/init_ack_r ),
        .R(\<const0> ));
  FDCE \u0/init_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u0/init_req01_out ),
        .Q(init_req));
  FDRE \u0/lmr_ack_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(lmr_ack),
        .Q(\u0/lmr_ack_r ),
        .R(\<const0> ));
  FDCE \u0/lmr_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u0/lmr_req00_out ),
        .Q(lmr_req));
  FDRE \u0/poc_reg[0] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[0]),
        .Q(poc_o[0]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[10] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[10]),
        .Q(poc_o[10]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[11] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[11]),
        .Q(poc_o[11]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[12] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[12]),
        .Q(poc_o[12]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[13] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[13]),
        .Q(poc_o[13]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[14] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[14]),
        .Q(poc_o[14]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[15] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[15]),
        .Q(poc_o[15]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[16] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[16]),
        .Q(poc_o[16]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[17] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[17]),
        .Q(poc_o[17]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[18] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[18]),
        .Q(poc_o[18]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[19] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[19]),
        .Q(poc_o[19]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[1] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[1]),
        .Q(poc_o[1]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[20] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[20]),
        .Q(poc_o[20]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[21] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[21]),
        .Q(poc_o[21]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[22] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[22]),
        .Q(poc_o[22]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[23] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[23]),
        .Q(poc_o[23]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[24] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[24]),
        .Q(poc_o[24]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[25] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[25]),
        .Q(poc_o[25]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[26] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[26]),
        .Q(poc_o[26]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[27] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[27]),
        .Q(poc_o[27]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[28] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[28]),
        .Q(poc_o[28]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[29] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[29]),
        .Q(poc_o[29]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[2] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[2]),
        .Q(poc_o[2]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[30] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[30]),
        .Q(poc_o[30]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[31] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[31]),
        .Q(poc_o[31]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[3] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[3]),
        .Q(poc_o[3]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[4] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[4]),
        .Q(poc_o[4]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[5] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[5]),
        .Q(poc_o[5]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[6] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[6]),
        .Q(poc_o[6]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[7] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[7]),
        .Q(poc_o[7]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[8] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[8]),
        .Q(poc_o[8]),
        .R(\<const0> ));
  FDRE \u0/poc_reg[9] 
       (.C(clk_i),
        .CE(rst_r3),
        .D(mc_data_ir[9]),
        .Q(poc_o[9]),
        .R(\<const0> ));
  FDCE \u0/rf_we_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u0/rf_we0 ),
        .Q(\u0/rf_we ));
  FDPE \u0/rst_r3_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u0/rst_r2 ),
        .PRE(rst_i),
        .Q(rst_r3));
  FDCE \u0/sp_csc_reg[10] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\sp_csc[10]_i_1_n_0 ),
        .Q(sp_csc[10]));
  FDCE \u0/sp_csc_reg[1] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\sp_csc[1]_i_1_n_0 ),
        .Q(sp_csc[1]));
  FDCE \u0/sp_csc_reg[2] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\sp_csc[2]_i_1_n_0 ),
        .Q(sp_csc[2]));
  FDCE \u0/sp_csc_reg[3] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\sp_csc[3]_i_1_n_0 ),
        .Q(sp_csc[3]));
  FDCE \u0/sp_csc_reg[4] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\sp_csc[4]_i_1_n_0 ),
        .Q(sp_csc[4]));
  FDCE \u0/sp_csc_reg[5] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\sp_csc[5]_i_1_n_0 ),
        .Q(sp_csc[5]));
  FDCE \u0/sp_csc_reg[6] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\sp_csc[6]_i_1_n_0 ),
        .Q(sp_csc[6]));
  FDCE \u0/sp_csc_reg[7] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\sp_csc[7]_i_1_n_0 ),
        .Q(sp_csc[7]));
  FDCE \u0/sp_csc_reg[9] 
       (.C(clk_i),
        .CE(\csc[11]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\sp_csc[9]_i_1_n_0 ),
        .Q(sp_csc[9]));
  FDPE \u0/sp_tms_reg[0] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[0]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[0]));
  FDPE \u0/sp_tms_reg[10] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[10]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[10]));
  FDPE \u0/sp_tms_reg[11] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[11]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[11]));
  FDPE \u0/sp_tms_reg[12] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[12]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[12]));
  FDPE \u0/sp_tms_reg[13] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[13]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[13]));
  FDPE \u0/sp_tms_reg[14] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[14]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[14]));
  FDPE \u0/sp_tms_reg[15] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[15]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[15]));
  FDPE \u0/sp_tms_reg[16] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[16]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[16]));
  FDPE \u0/sp_tms_reg[17] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[17]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[17]));
  FDPE \u0/sp_tms_reg[18] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[18]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[18]));
  FDPE \u0/sp_tms_reg[19] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[19]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[19]));
  FDPE \u0/sp_tms_reg[1] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[1]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[1]));
  FDPE \u0/sp_tms_reg[20] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[20]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[20]));
  FDPE \u0/sp_tms_reg[21] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[21]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[21]));
  FDPE \u0/sp_tms_reg[22] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[22]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[22]));
  FDPE \u0/sp_tms_reg[23] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[23]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[23]));
  FDPE \u0/sp_tms_reg[24] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[24]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[24]));
  FDPE \u0/sp_tms_reg[25] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[25]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[25]));
  FDPE \u0/sp_tms_reg[26] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[26]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[26]));
  FDPE \u0/sp_tms_reg[27] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[27]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[27]));
  FDPE \u0/sp_tms_reg[2] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[2]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[2]));
  FDPE \u0/sp_tms_reg[3] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[3]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[3]));
  FDPE \u0/sp_tms_reg[4] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[4]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[4]));
  FDPE \u0/sp_tms_reg[5] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[5]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[5]));
  FDPE \u0/sp_tms_reg[6] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[6]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[6]));
  FDPE \u0/sp_tms_reg[7] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[7]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[7]));
  FDPE \u0/sp_tms_reg[8] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[8]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[8]));
  FDPE \u0/sp_tms_reg[9] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\sp_tms[9]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(sp_tms[9]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \u0/spec_req_cs[0]_i_1 
       (.I0(\u0/u0/init_req_reg_n_0 ),
        .I1(init_req),
        .I2(\u0/u0/lmr_req_reg_n_0 ),
        .I3(sreq_cs_le),
        .I4(spec_req_cs[0]),
        .O(\u0/spec_req_cs[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \u0/spec_req_cs[1]_i_1 
       (.I0(\u0/u1/lmr_req_reg_n_0 ),
        .I1(init_req),
        .I2(\u0/u1/init_req_reg_n_0 ),
        .I3(\u0/spec_req_cs_t ),
        .I4(sreq_cs_le),
        .I5(spec_req_cs[1]),
        .O(\u0/spec_req_cs[1]_i_1_n_0 ));
  FDCE \u0/spec_req_cs_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u0/spec_req_cs[0]_i_1_n_0 ),
        .Q(spec_req_cs[0]));
  FDCE \u0/spec_req_cs_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u0/spec_req_cs[1]_i_1_n_0 ),
        .Q(spec_req_cs[1]));
  FDCE \u0/sreq_cs_le_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u0/sreq_cs_le0 ),
        .Q(sreq_cs_le));
  FDPE \u0/tms_reg[0] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[0]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[0] ));
  FDPE \u0/tms_reg[10] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[10]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[10] ));
  FDPE \u0/tms_reg[11] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[11]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[11] ));
  FDPE \u0/tms_reg[12] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[12]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[12] ));
  FDPE \u0/tms_reg[13] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[13]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[13] ));
  FDPE \u0/tms_reg[14] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[14]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[14] ));
  FDPE \u0/tms_reg[15] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[15]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[15] ));
  FDPE \u0/tms_reg[16] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[16]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[16] ));
  FDPE \u0/tms_reg[17] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[17]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[17] ));
  FDPE \u0/tms_reg[18] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[18]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[18] ));
  FDPE \u0/tms_reg[19] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[19]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[19] ));
  FDPE \u0/tms_reg[1] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[1]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[1] ));
  FDPE \u0/tms_reg[20] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[20]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[20] ));
  FDPE \u0/tms_reg[21] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[21]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[21] ));
  FDPE \u0/tms_reg[22] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[22]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[22] ));
  FDPE \u0/tms_reg[23] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[23]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[23] ));
  FDPE \u0/tms_reg[24] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[24]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[24] ));
  FDPE \u0/tms_reg[25] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[25]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[25] ));
  FDPE \u0/tms_reg[26] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[26]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[26] ));
  FDPE \u0/tms_reg[27] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[27]_i_2_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[27] ));
  FDPE \u0/tms_reg[2] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[2]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[2] ));
  FDPE \u0/tms_reg[3] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[3]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[3] ));
  FDPE \u0/tms_reg[4] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[4]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[4] ));
  FDPE \u0/tms_reg[5] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[5]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[5] ));
  FDPE \u0/tms_reg[6] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[6]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[6] ));
  FDPE \u0/tms_reg[7] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[7]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[7] ));
  FDPE \u0/tms_reg[8] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[8]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[8] ));
  FDPE \u0/tms_reg[9] 
       (.C(clk_i),
        .CE(\tms[27]_i_1_n_0 ),
        .D(\tms[9]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u0/tms_reg_n_0_[9] ));
  FDRE \u0/u0/addr_r_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_addr_i[2]),
        .Q(\u0/p_0_in1_in ),
        .R(\<const0> ));
  FDRE \u0/u0/addr_r_reg[3] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_addr_i[3]),
        .Q(\u0/p_0_in [0]),
        .R(\<const0> ));
  FDRE \u0/u0/addr_r_reg[4] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_addr_i[4]),
        .Q(\u0/p_0_in [1]),
        .R(\<const0> ));
  FDRE \u0/u0/addr_r_reg[5] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_addr_i[5]),
        .Q(\u0/p_0_in [2]),
        .R(\<const0> ));
  FDRE \u0/u0/addr_r_reg[6] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_addr_i[6]),
        .Q(\u0/p_0_in [3]),
        .R(\<const0> ));
  FDRE \u0/u0/csc_reg[0] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(\csc[0]_i_1_n_0 ),
        .Q(\u0/u0/csc_reg_n_0_[0] ),
        .R(\<const0> ));
  FDRE \u0/u0/csc_reg[10] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[10]),
        .Q(\u0/u0/csc_reg_n_0_[10] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[11] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[11]),
        .Q(\u0/u0/csc_reg_n_0_[11] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[12] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[12]),
        .Q(\u0/u0/csc_reg_n_0_[12] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[13] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[13]),
        .Q(\u0/u0/csc_reg_n_0_[13] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[14] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[14]),
        .Q(\u0/u0/csc_reg_n_0_[14] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[15] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[15]),
        .Q(\u0/u0/csc_reg_n_0_[15] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[16] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[16]),
        .Q(\u0/u0/csc_reg_n_0_[16] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[17] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[17]),
        .Q(\u0/u0/csc_reg_n_0_[17] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[18] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[18]),
        .Q(\u0/u0/csc_reg_n_0_[18] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[19] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[19]),
        .Q(\u0/u0/csc_reg_n_0_[19] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[1] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(\csc[1]_i_1_n_0 ),
        .Q(\u0/u0/csc_reg_n_0_[1] ),
        .R(\<const0> ));
  FDRE \u0/u0/csc_reg[20] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[20]),
        .Q(\u0/u0/csc_reg_n_0_[20] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[21] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[21]),
        .Q(\u0/u0/csc_reg_n_0_[21] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[22] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[22]),
        .Q(\u0/u0/csc_reg_n_0_[22] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[23] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[23]),
        .Q(\u0/u0/csc_reg_n_0_[23] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[24] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[24]),
        .Q(\u0/u0/csc_reg_n_0_[24] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[25] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[25]),
        .Q(\u0/u0/csc_reg_n_0_[25] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[26] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[26]),
        .Q(\u0/u0/csc_reg_n_0_[26] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[27] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[27]),
        .Q(\u0/u0/csc_reg_n_0_[27] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[28] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[28]),
        .Q(\u0/u0/csc_reg_n_0_[28] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[29] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[29]),
        .Q(\u0/u0/csc_reg_n_0_[29] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[2] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(\csc[2]_i_1_n_0 ),
        .Q(\u0/u0/csc_reg_n_0_[2] ),
        .R(\<const0> ));
  FDRE \u0/u0/csc_reg[30] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[30]),
        .Q(\u0/u0/csc_reg_n_0_[30] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[31] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[31]),
        .Q(\u0/u0/csc_reg_n_0_[31] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[3] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[3]),
        .Q(\u0/u0/csc_reg_n_0_[3] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[4] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(\csc[4]_i_1_n_0 ),
        .Q(\u0/u0/csc_reg_n_0_[4] ),
        .R(\<const0> ));
  FDRE \u0/u0/csc_reg[5] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(\csc[5]_i_2_n_0 ),
        .Q(\u0/u0/csc_reg_n_0_[5] ),
        .R(\<const0> ));
  FDRE \u0/u0/csc_reg[6] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[6]),
        .Q(\u0/u0/csc_reg_n_0_[6] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[7] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[7]),
        .Q(\u0/u0/csc_reg_n_0_[7] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[8] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[8]),
        .Q(\u0/u0/csc_reg_n_0_[8] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u0/csc_reg[9] 
       (.C(clk_i),
        .CE(\csc[5]_i_1_n_0 ),
        .D(wb_data_i[9]),
        .Q(\u0/u0/csc_reg_n_0_[9] ),
        .R(\u0/rst_r2 ));
  FDCE \u0/u0/init_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(init_req_i_1__0_n_0),
        .Q(\u0/u0/init_req_reg_n_0 ));
  FDCE \u0/u0/init_req_we_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(init_req_we_i_1_n_0),
        .Q(\u0/init_req_we ));
  FDCE \u0/u0/inited_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(inited_i_1__0_n_0),
        .Q(\u0/inited ));
  FDCE \u0/u0/lmr_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(lmr_req_i_1__1_n_0),
        .Q(\u0/u0/lmr_req_reg_n_0 ));
  FDCE \u0/u0/lmr_req_we_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u0/tms0 ),
        .Q(\u0/lmr_req_we ));
  FDPE \u0/u0/rst_r1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\<const0> ),
        .PRE(rst_i),
        .Q(rst_r1));
  FDPE \u0/u0/rst_r2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(rst_r1),
        .PRE(rst_i),
        .Q(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[0] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[0]),
        .Q(tms[0]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[10] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[10]),
        .Q(tms[10]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[11] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[11]),
        .Q(tms[11]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[12] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[12]),
        .Q(tms[12]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[13] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[13]),
        .Q(tms[13]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[14] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[14]),
        .Q(tms[14]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[15] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[15]),
        .Q(tms[15]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[16] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[16]),
        .Q(tms[16]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[17] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[17]),
        .Q(tms[17]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[18] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[18]),
        .Q(tms[18]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[19] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[19]),
        .Q(tms[19]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[1] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[1]),
        .Q(tms[1]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[20] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[20]),
        .Q(tms[20]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[21] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[21]),
        .Q(tms[21]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[22] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[22]),
        .Q(tms[22]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[23] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[23]),
        .Q(tms[23]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[24] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[24]),
        .Q(tms[24]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[25] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[25]),
        .Q(tms[25]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[26] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[26]),
        .Q(tms[26]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[27] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[27]),
        .Q(tms[27]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[28] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[28]),
        .Q(tms[28]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[29] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[29]),
        .Q(tms[29]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[2] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[2]),
        .Q(tms[2]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[30] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[30]),
        .Q(tms[30]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[31] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[31]),
        .Q(tms[31]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[3] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[3]),
        .Q(tms[3]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[4] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[4]),
        .Q(tms[4]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[5] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[5]),
        .Q(tms[5]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[6] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[6]),
        .Q(tms[6]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[7] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[7]),
        .Q(tms[7]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[8] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[8]),
        .Q(tms[8]),
        .S(\u0/rst_r2 ));
  FDSE \u0/u0/tms_reg[9] 
       (.C(clk_i),
        .CE(\u0/tms0 ),
        .D(wb_data_i[9]),
        .Q(tms[9]),
        .S(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[0] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[0]),
        .Q(\u0/u1/csc_reg_n_0_[0] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[10] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[10]),
        .Q(\u0/u1/csc_reg_n_0_[10] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[11] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[11]),
        .Q(\u0/u1/csc_reg_n_0_[11] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[12] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[12]),
        .Q(\u0/u1/csc_reg_n_0_[12] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[13] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[13]),
        .Q(\u0/u1/csc_reg_n_0_[13] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[14] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[14]),
        .Q(\u0/u1/csc_reg_n_0_[14] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[15] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[15]),
        .Q(\u0/u1/csc_reg_n_0_[15] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[16] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[16]),
        .Q(\u0/u1/csc_reg_n_0_[16] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[17] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[17]),
        .Q(\u0/u1/csc_reg_n_0_[17] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[18] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[18]),
        .Q(\u0/u1/csc_reg_n_0_[18] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[19] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[19]),
        .Q(\u0/u1/csc_reg_n_0_[19] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[1] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[1]),
        .Q(\u0/u1/csc_reg_n_0_[1] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[20] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[20]),
        .Q(\u0/u1/csc_reg_n_0_[20] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[21] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[21]),
        .Q(\u0/u1/csc_reg_n_0_[21] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[22] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[22]),
        .Q(\u0/u1/csc_reg_n_0_[22] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[23] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[23]),
        .Q(\u0/u1/csc_reg_n_0_[23] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[24] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[24]),
        .Q(\u0/u1/csc_reg_n_0_[24] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[25] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[25]),
        .Q(\u0/u1/csc_reg_n_0_[25] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[26] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[26]),
        .Q(\u0/u1/csc_reg_n_0_[26] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[27] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[27]),
        .Q(\u0/u1/csc_reg_n_0_[27] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[28] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[28]),
        .Q(\u0/u1/csc_reg_n_0_[28] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[29] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[29]),
        .Q(\u0/u1/csc_reg_n_0_[29] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[2] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[2]),
        .Q(\u0/u1/csc_reg_n_0_[2] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[30] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[30]),
        .Q(\u0/u1/csc_reg_n_0_[30] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[31] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[31]),
        .Q(\u0/u1/csc_reg_n_0_[31] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[3] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[3]),
        .Q(\u0/u1/csc_reg_n_0_[3] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[4] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[4]),
        .Q(\u0/u1/csc_reg_n_0_[4] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[5] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[5]),
        .Q(\u0/u1/csc_reg_n_0_[5] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[6] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[6]),
        .Q(\u0/u1/csc_reg_n_0_[6] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[7] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[7]),
        .Q(\u0/u1/csc_reg_n_0_[7] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[8] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[8]),
        .Q(\u0/u1/csc_reg_n_0_[8] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/csc_reg[9] 
       (.C(clk_i),
        .CE(\csc[31]_i_1_n_0 ),
        .D(wb_data_i[9]),
        .Q(\u0/u1/csc_reg_n_0_[9] ),
        .R(\u0/rst_r2 ));
  FDCE \u0/u1/init_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(init_req_i_1__1_n_0),
        .Q(\u0/u1/init_req_reg_n_0 ));
  FDCE \u0/u1/init_req_we_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\csc[31]_i_1_n_0 ),
        .Q(\u0/u1/init_req_we_reg_n_0 ));
  FDCE \u0/u1/inited_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(inited_i_1_n_0),
        .Q(\u0/u1/inited_reg_n_0 ));
  FDCE \u0/u1/lmr_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(lmr_req_i_1__0_n_0),
        .Q(\u0/u1/lmr_req_reg_n_0 ));
  FDCE \u0/u1/lmr_req_we_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(lmr_req_we_i_1__0_n_0),
        .Q(\u0/u1/lmr_req_we_reg_n_0 ));
  FDRE \u0/u1/tms_reg[0] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[0]),
        .Q(\u0/u1/tms_reg_n_0_[0] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[10] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[10]),
        .Q(\u0/u1/tms_reg_n_0_[10] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[11] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[11]),
        .Q(\u0/u1/tms_reg_n_0_[11] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[12] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[12]),
        .Q(\u0/u1/tms_reg_n_0_[12] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[13] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[13]),
        .Q(\u0/u1/tms_reg_n_0_[13] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[14] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[14]),
        .Q(\u0/u1/tms_reg_n_0_[14] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[15] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[15]),
        .Q(\u0/u1/tms_reg_n_0_[15] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[16] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[16]),
        .Q(\u0/u1/tms_reg_n_0_[16] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[17] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[17]),
        .Q(\u0/u1/tms_reg_n_0_[17] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[18] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[18]),
        .Q(\u0/u1/tms_reg_n_0_[18] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[19] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[19]),
        .Q(\u0/u1/tms_reg_n_0_[19] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[1] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[1]),
        .Q(\u0/u1/tms_reg_n_0_[1] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[20] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[20]),
        .Q(\u0/u1/tms_reg_n_0_[20] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[21] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[21]),
        .Q(\u0/u1/tms_reg_n_0_[21] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[22] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[22]),
        .Q(\u0/u1/tms_reg_n_0_[22] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[23] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[23]),
        .Q(\u0/u1/tms_reg_n_0_[23] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[24] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[24]),
        .Q(\u0/u1/tms_reg_n_0_[24] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[25] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[25]),
        .Q(\u0/u1/tms_reg_n_0_[25] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[26] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[26]),
        .Q(\u0/u1/tms_reg_n_0_[26] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[27] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[27]),
        .Q(\u0/u1/tms_reg_n_0_[27] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[28] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[28]),
        .Q(\u0/u1/tms_reg_n_0_[28] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[29] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[29]),
        .Q(\u0/u1/tms_reg_n_0_[29] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[2] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[2]),
        .Q(\u0/u1/tms_reg_n_0_[2] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[30] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[30]),
        .Q(\u0/u1/tms_reg_n_0_[30] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[31] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[31]),
        .Q(\u0/u1/tms_reg_n_0_[31] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[3] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[3]),
        .Q(\u0/u1/tms_reg_n_0_[3] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[4] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[4]),
        .Q(\u0/u1/tms_reg_n_0_[4] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[5] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[5]),
        .Q(\u0/u1/tms_reg_n_0_[5] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[6] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[6]),
        .Q(\u0/u1/tms_reg_n_0_[6] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[7] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[7]),
        .Q(\u0/u1/tms_reg_n_0_[7] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[8] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[8]),
        .Q(\u0/u1/tms_reg_n_0_[8] ),
        .R(\u0/rst_r2 ));
  FDRE \u0/u1/tms_reg[9] 
       (.C(clk_i),
        .CE(lmr_req_we_i_1__0_n_0),
        .D(wb_data_i[9]),
        .Q(\u0/u1/tms_reg_n_0_[9] ),
        .R(\u0/rst_r2 ));
  FDCE \u0/wp_err_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(wp_err_i_1_n_0),
        .Q(wp_err));
  FDRE \u1/acs_addr_reg[0] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[0]_i_1_n_0 ),
        .Q(acs_addr[0]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[10] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[10]_i_1_n_0 ),
        .Q(acs_addr[10]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[11] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[11]_i_1_n_0 ),
        .Q(acs_addr[11]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[12] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[12]_i_1_n_0 ),
        .Q(acs_addr[12]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[13] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[13]_i_1_n_0 ),
        .Q(acs_addr[13]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[14] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[14]_i_1_n_0 ),
        .Q(acs_addr[14]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[15] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[15]_i_1_n_0 ),
        .Q(acs_addr[15]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[16] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[16]_i_1_n_0 ),
        .Q(acs_addr[16]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[17] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[17]_i_1_n_0 ),
        .Q(acs_addr[17]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[18] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[18]_i_1_n_0 ),
        .Q(acs_addr[18]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[19] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[19]_i_1_n_0 ),
        .Q(acs_addr[19]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[1] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[1]_i_1_n_0 ),
        .Q(acs_addr[1]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[20] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[20]_i_1_n_0 ),
        .Q(acs_addr[20]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[21] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[21]_i_1_n_0 ),
        .Q(acs_addr[21]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[22] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[22]_i_1_n_0 ),
        .Q(acs_addr[22]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[23] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[23]_i_2_n_0 ),
        .Q(acs_addr[23]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[2] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[2]_i_1_n_0 ),
        .Q(acs_addr[2]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[3] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[3]_i_1_n_0 ),
        .Q(acs_addr[3]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[4] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[4]_i_1_n_0 ),
        .Q(acs_addr[4]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[5] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[5]_i_1_n_0 ),
        .Q(acs_addr[5]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[6] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[6]_i_1_n_0 ),
        .Q(acs_addr[6]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[7] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[7]_i_1_n_0 ),
        .Q(acs_addr[7]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[8] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[8]_i_1_n_0 ),
        .Q(acs_addr[8]),
        .R(\<const0> ));
  FDRE \u1/acs_addr_reg[9] 
       (.C(clk_i),
        .CE(\acs_addr[23]_i_1_n_0 ),
        .D(\acs_addr[9]_i_1_n_0 ),
        .Q(acs_addr[9]),
        .R(\<const0> ));
  FDRE \u1/bank_adr_reg[0] 
       (.C(clk_i),
        .CE(cs_le),
        .D(\bank_adr[0]_i_1_n_0 ),
        .Q(bank_adr[0]),
        .R(\<const0> ));
  FDRE \u1/bank_adr_reg[1] 
       (.C(clk_i),
        .CE(cs_le),
        .D(\bank_adr[1]_i_1_n_0 ),
        .Q(bank_adr[1]),
        .R(\<const0> ));
  FDRE \u1/col_adr_reg[0] 
       (.C(clk_i),
        .CE(\col_adr[9]_i_1_n_0 ),
        .D(wb_addr_i[2]),
        .Q(col_adr[0]),
        .R(\<const0> ));
  FDRE \u1/col_adr_reg[1] 
       (.C(clk_i),
        .CE(\col_adr[9]_i_1_n_0 ),
        .D(wb_addr_i[3]),
        .Q(col_adr[1]),
        .R(\<const0> ));
  FDRE \u1/col_adr_reg[2] 
       (.C(clk_i),
        .CE(\col_adr[9]_i_1_n_0 ),
        .D(wb_addr_i[4]),
        .Q(col_adr[2]),
        .R(\<const0> ));
  FDRE \u1/col_adr_reg[3] 
       (.C(clk_i),
        .CE(\col_adr[9]_i_1_n_0 ),
        .D(wb_addr_i[5]),
        .Q(col_adr[3]),
        .R(\<const0> ));
  FDRE \u1/col_adr_reg[4] 
       (.C(clk_i),
        .CE(\col_adr[9]_i_1_n_0 ),
        .D(wb_addr_i[6]),
        .Q(col_adr[4]),
        .R(\<const0> ));
  FDRE \u1/col_adr_reg[5] 
       (.C(clk_i),
        .CE(\col_adr[9]_i_1_n_0 ),
        .D(wb_addr_i[7]),
        .Q(col_adr[5]),
        .R(\<const0> ));
  FDRE \u1/col_adr_reg[6] 
       (.C(clk_i),
        .CE(\col_adr[9]_i_1_n_0 ),
        .D(wb_addr_i[8]),
        .Q(col_adr[6]),
        .R(\<const0> ));
  FDRE \u1/col_adr_reg[7] 
       (.C(clk_i),
        .CE(\col_adr[9]_i_1_n_0 ),
        .D(wb_addr_i[9]),
        .Q(col_adr[7]),
        .R(\<const0> ));
  FDRE \u1/col_adr_reg[8] 
       (.C(clk_i),
        .CE(\col_adr[9]_i_1_n_0 ),
        .D(\u1/col_adr [8]),
        .Q(col_adr[8]),
        .R(\<const0> ));
  FDRE \u1/col_adr_reg[9] 
       (.C(clk_i),
        .CE(\col_adr[9]_i_1_n_0 ),
        .D(\u1/col_adr [9]),
        .Q(col_adr[9]),
        .R(\<const0> ));
  FDRE \u1/row_adr_reg[0] 
       (.C(clk_i),
        .CE(cs_le),
        .D(\row_adr[0]_i_1_n_0 ),
        .Q(row_adr[0]),
        .R(\<const0> ));
  FDRE \u1/row_adr_reg[10] 
       (.C(clk_i),
        .CE(cs_le),
        .D(\row_adr[10]_i_1_n_0 ),
        .Q(row_adr[10]),
        .R(\<const0> ));
  FDRE \u1/row_adr_reg[11] 
       (.C(clk_i),
        .CE(cs_le),
        .D(\row_adr_reg[11]_i_1_n_0 ),
        .Q(row_adr[11]),
        .R(\<const0> ));
  FDRE \u1/row_adr_reg[12] 
       (.C(clk_i),
        .CE(cs_le),
        .D(\row_adr_reg[12]_i_1_n_0 ),
        .Q(row_adr[12]),
        .R(\<const0> ));
  FDRE \u1/row_adr_reg[1] 
       (.C(clk_i),
        .CE(cs_le),
        .D(\row_adr[1]_i_1_n_0 ),
        .Q(row_adr[1]),
        .R(\<const0> ));
  FDRE \u1/row_adr_reg[2] 
       (.C(clk_i),
        .CE(cs_le),
        .D(\row_adr[2]_i_1_n_0 ),
        .Q(row_adr[2]),
        .R(\<const0> ));
  FDRE \u1/row_adr_reg[3] 
       (.C(clk_i),
        .CE(cs_le),
        .D(\row_adr[3]_i_1_n_0 ),
        .Q(row_adr[3]),
        .R(\<const0> ));
  FDRE \u1/row_adr_reg[4] 
       (.C(clk_i),
        .CE(cs_le),
        .D(\row_adr[4]_i_1_n_0 ),
        .Q(row_adr[4]),
        .R(\<const0> ));
  FDRE \u1/row_adr_reg[5] 
       (.C(clk_i),
        .CE(cs_le),
        .D(\row_adr[5]_i_1_n_0 ),
        .Q(row_adr[5]),
        .R(\<const0> ));
  FDRE \u1/row_adr_reg[6] 
       (.C(clk_i),
        .CE(cs_le),
        .D(\row_adr[6]_i_1_n_0 ),
        .Q(row_adr[6]),
        .R(\<const0> ));
  FDRE \u1/row_adr_reg[7] 
       (.C(clk_i),
        .CE(cs_le),
        .D(\row_adr[7]_i_1_n_0 ),
        .Q(row_adr[7]),
        .R(\<const0> ));
  FDRE \u1/row_adr_reg[8] 
       (.C(clk_i),
        .CE(cs_le),
        .D(\row_adr[8]_i_1_n_0 ),
        .Q(row_adr[8]),
        .R(\<const0> ));
  FDRE \u1/row_adr_reg[9] 
       (.C(clk_i),
        .CE(cs_le),
        .D(\row_adr[9]_i_1_n_0 ),
        .Q(row_adr[9]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[0] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[2]),
        .Q(sram_addr[0]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[10] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[12]),
        .Q(sram_addr[10]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[11] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[13]),
        .Q(sram_addr[11]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[12] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[14]),
        .Q(sram_addr[12]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[13] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[15]),
        .Q(sram_addr[13]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[14] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[16]),
        .Q(sram_addr[14]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[15] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[17]),
        .Q(sram_addr[15]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[16] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[18]),
        .Q(sram_addr[16]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[17] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[19]),
        .Q(sram_addr[17]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[18] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[20]),
        .Q(sram_addr[18]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[19] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[21]),
        .Q(sram_addr[19]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[1] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[3]),
        .Q(sram_addr[1]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[20] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[22]),
        .Q(sram_addr[20]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[21] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[23]),
        .Q(sram_addr[21]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[22] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[24]),
        .Q(sram_addr[22]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[23] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[25]),
        .Q(sram_addr[23]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[2] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[4]),
        .Q(sram_addr[2]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[3] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[5]),
        .Q(sram_addr[3]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[4] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[6]),
        .Q(sram_addr[4]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[5] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[7]),
        .Q(sram_addr[5]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[6] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[8]),
        .Q(sram_addr[6]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[7] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[9]),
        .Q(sram_addr[7]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[8] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[10]),
        .Q(sram_addr[8]),
        .R(\<const0> ));
  FDRE \u1/sram_addr_reg[9] 
       (.C(clk_i),
        .CE(wb_stb_i),
        .D(wb_addr_i[11]),
        .Q(sram_addr[9]),
        .R(\<const0> ));
  CARRY4 \u1/u0/out_r0_carry 
       (.CI(\<const0> ),
        .CO({\u1/u0/out_r0_carry_n_0 ,\u1/u0/out_r0_carry_n_1 ,\u1/u0/out_r0_carry_n_2 ,\u1/u0/out_r0_carry_n_3 }),
        .CYINIT(acs_addr[0]),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\u1/u0/out_r0_carry_n_4 ,\u1/u0/out_r0_carry_n_5 ,\u1/u0/out_r0_carry_n_6 ,\u1/u0/out_r0_carry_n_7 }),
        .S(acs_addr[4:1]));
  CARRY4 \u1/u0/out_r0_carry__0 
       (.CI(\u1/u0/out_r0_carry_n_0 ),
        .CO({\u1/u0/out_r0_carry__0_n_0 ,\u1/u0/out_r0_carry__0_n_1 ,\u1/u0/out_r0_carry__0_n_2 ,\u1/u0/out_r0_carry__0_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\u1/u0/out_r0_carry__0_n_4 ,\u1/u0/out_r0_carry__0_n_5 ,\u1/u0/out_r0_carry__0_n_6 ,\u1/u0/out_r0_carry__0_n_7 }),
        .S(acs_addr[8:5]));
  CARRY4 \u1/u0/out_r0_carry__1 
       (.CI(\u1/u0/out_r0_carry__0_n_0 ),
        .CO({\u1/u0/out_r0_carry__1_n_0 ,\NLW_u1/u0/out_r0_carry__1_CO_UNCONNECTED [2],\u1/u0/out_r0_carry__1_n_2 ,\u1/u0/out_r0_carry__1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\u1/u0/out_r0_carry__1_n_5 ,\u1/u0/out_r0_carry__1_n_6 ,\u1/u0/out_r0_carry__1_n_7 }),
        .S({\<const1> ,acs_addr[11:9]}));
  FDRE \u1/u0/out_r_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\out_r[0]_i_1_n_0 ),
        .Q(\u1/u0/out_r_reg_n_0_[0] ),
        .R(\<const0> ));
  FDRE \u1/u0/out_r_reg[10] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u1/u0/out_r0_carry__1_n_6 ),
        .Q(\u1/u0/out_r_reg_n_0_[10] ),
        .R(\<const0> ));
  FDRE \u1/u0/out_r_reg[11] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u1/u0/out_r0_carry__1_n_5 ),
        .Q(\u1/u0/out_r_reg_n_0_[11] ),
        .R(\<const0> ));
  FDRE \u1/u0/out_r_reg[12] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u1/u0/out_r0_carry__1_n_0 ),
        .Q(inc_next),
        .R(\<const0> ));
  FDRE \u1/u0/out_r_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u1/u0/out_r0_carry_n_7 ),
        .Q(\u1/u0/out_r_reg_n_0_[1] ),
        .R(\<const0> ));
  FDRE \u1/u0/out_r_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u1/u0/out_r0_carry_n_6 ),
        .Q(\u1/u0/out_r_reg_n_0_[2] ),
        .R(\<const0> ));
  FDRE \u1/u0/out_r_reg[3] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u1/u0/out_r0_carry_n_5 ),
        .Q(\u1/u0/out_r_reg_n_0_[3] ),
        .R(\<const0> ));
  FDRE \u1/u0/out_r_reg[4] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u1/u0/out_r0_carry_n_4 ),
        .Q(\u1/u0/out_r_reg_n_0_[4] ),
        .R(\<const0> ));
  FDRE \u1/u0/out_r_reg[5] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u1/u0/out_r0_carry__0_n_7 ),
        .Q(\u1/u0/out_r_reg_n_0_[5] ),
        .R(\<const0> ));
  FDRE \u1/u0/out_r_reg[6] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u1/u0/out_r0_carry__0_n_6 ),
        .Q(\u1/u0/out_r_reg_n_0_[6] ),
        .R(\<const0> ));
  FDRE \u1/u0/out_r_reg[7] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u1/u0/out_r0_carry__0_n_5 ),
        .Q(\u1/u0/out_r_reg_n_0_[7] ),
        .R(\<const0> ));
  FDRE \u1/u0/out_r_reg[8] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u1/u0/out_r0_carry__0_n_4 ),
        .Q(\u1/u0/out_r_reg_n_0_[8] ),
        .R(\<const0> ));
  FDRE \u1/u0/out_r_reg[9] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u1/u0/out_r0_carry__1_n_7 ),
        .Q(\u1/u0/out_r_reg_n_0_[9] ),
        .R(\<const0> ));
  FDRE \u2/bank_open_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u2/bank_open0 ),
        .Q(bank_open),
        .R(\<const0> ));
  FDRE \u2/row_same_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u2/row_same0 ),
        .Q(row_same),
        .R(\<const0> ));
  FDRE \u2/u0/b0_last_row_reg[0] 
       (.C(clk_i),
        .CE(\u2/bank0_open0 ),
        .D(row_adr[0]),
        .Q(\u2/u0/b0_last_row_reg_n_0_[0] ),
        .R(\<const0> ));
  FDRE \u2/u0/b0_last_row_reg[10] 
       (.C(clk_i),
        .CE(\u2/bank0_open0 ),
        .D(row_adr[10]),
        .Q(\u2/u0/b0_last_row_reg_n_0_[10] ),
        .R(\<const0> ));
  FDRE \u2/u0/b0_last_row_reg[11] 
       (.C(clk_i),
        .CE(\u2/bank0_open0 ),
        .D(row_adr[11]),
        .Q(\u2/u0/b0_last_row_reg_n_0_[11] ),
        .R(\<const0> ));
  FDRE \u2/u0/b0_last_row_reg[12] 
       (.C(clk_i),
        .CE(\u2/bank0_open0 ),
        .D(row_adr[12]),
        .Q(\u2/u0/b0_last_row_reg_n_0_[12] ),
        .R(\<const0> ));
  FDRE \u2/u0/b0_last_row_reg[1] 
       (.C(clk_i),
        .CE(\u2/bank0_open0 ),
        .D(row_adr[1]),
        .Q(\u2/u0/b0_last_row_reg_n_0_[1] ),
        .R(\<const0> ));
  FDRE \u2/u0/b0_last_row_reg[2] 
       (.C(clk_i),
        .CE(\u2/bank0_open0 ),
        .D(row_adr[2]),
        .Q(\u2/u0/b0_last_row_reg_n_0_[2] ),
        .R(\<const0> ));
  FDRE \u2/u0/b0_last_row_reg[3] 
       (.C(clk_i),
        .CE(\u2/bank0_open0 ),
        .D(row_adr[3]),
        .Q(\u2/u0/b0_last_row_reg_n_0_[3] ),
        .R(\<const0> ));
  FDRE \u2/u0/b0_last_row_reg[4] 
       (.C(clk_i),
        .CE(\u2/bank0_open0 ),
        .D(row_adr[4]),
        .Q(\u2/u0/b0_last_row_reg_n_0_[4] ),
        .R(\<const0> ));
  FDRE \u2/u0/b0_last_row_reg[5] 
       (.C(clk_i),
        .CE(\u2/bank0_open0 ),
        .D(row_adr[5]),
        .Q(\u2/u0/b0_last_row_reg_n_0_[5] ),
        .R(\<const0> ));
  FDRE \u2/u0/b0_last_row_reg[6] 
       (.C(clk_i),
        .CE(\u2/bank0_open0 ),
        .D(row_adr[6]),
        .Q(\u2/u0/b0_last_row_reg_n_0_[6] ),
        .R(\<const0> ));
  FDRE \u2/u0/b0_last_row_reg[7] 
       (.C(clk_i),
        .CE(\u2/bank0_open0 ),
        .D(row_adr[7]),
        .Q(\u2/u0/b0_last_row_reg_n_0_[7] ),
        .R(\<const0> ));
  FDRE \u2/u0/b0_last_row_reg[8] 
       (.C(clk_i),
        .CE(\u2/bank0_open0 ),
        .D(row_adr[8]),
        .Q(\u2/u0/b0_last_row_reg_n_0_[8] ),
        .R(\<const0> ));
  FDRE \u2/u0/b0_last_row_reg[9] 
       (.C(clk_i),
        .CE(\u2/bank0_open0 ),
        .D(row_adr[9]),
        .Q(\u2/u0/b0_last_row_reg_n_0_[9] ),
        .R(\<const0> ));
  FDRE \u2/u0/b1_last_row_reg[0] 
       (.C(clk_i),
        .CE(\u2/bank1_open0 ),
        .D(row_adr[0]),
        .Q(\u2/u0/b1_last_row_reg_n_0_[0] ),
        .R(\<const0> ));
  FDRE \u2/u0/b1_last_row_reg[10] 
       (.C(clk_i),
        .CE(\u2/bank1_open0 ),
        .D(row_adr[10]),
        .Q(\u2/u0/b1_last_row_reg_n_0_[10] ),
        .R(\<const0> ));
  FDRE \u2/u0/b1_last_row_reg[11] 
       (.C(clk_i),
        .CE(\u2/bank1_open0 ),
        .D(row_adr[11]),
        .Q(\u2/u0/b1_last_row_reg_n_0_[11] ),
        .R(\<const0> ));
  FDRE \u2/u0/b1_last_row_reg[12] 
       (.C(clk_i),
        .CE(\u2/bank1_open0 ),
        .D(row_adr[12]),
        .Q(\u2/u0/b1_last_row_reg_n_0_[12] ),
        .R(\<const0> ));
  FDRE \u2/u0/b1_last_row_reg[1] 
       (.C(clk_i),
        .CE(\u2/bank1_open0 ),
        .D(row_adr[1]),
        .Q(\u2/u0/b1_last_row_reg_n_0_[1] ),
        .R(\<const0> ));
  FDRE \u2/u0/b1_last_row_reg[2] 
       (.C(clk_i),
        .CE(\u2/bank1_open0 ),
        .D(row_adr[2]),
        .Q(\u2/u0/b1_last_row_reg_n_0_[2] ),
        .R(\<const0> ));
  FDRE \u2/u0/b1_last_row_reg[3] 
       (.C(clk_i),
        .CE(\u2/bank1_open0 ),
        .D(row_adr[3]),
        .Q(\u2/u0/b1_last_row_reg_n_0_[3] ),
        .R(\<const0> ));
  FDRE \u2/u0/b1_last_row_reg[4] 
       (.C(clk_i),
        .CE(\u2/bank1_open0 ),
        .D(row_adr[4]),
        .Q(\u2/u0/b1_last_row_reg_n_0_[4] ),
        .R(\<const0> ));
  FDRE \u2/u0/b1_last_row_reg[5] 
       (.C(clk_i),
        .CE(\u2/bank1_open0 ),
        .D(row_adr[5]),
        .Q(\u2/u0/b1_last_row_reg_n_0_[5] ),
        .R(\<const0> ));
  FDRE \u2/u0/b1_last_row_reg[6] 
       (.C(clk_i),
        .CE(\u2/bank1_open0 ),
        .D(row_adr[6]),
        .Q(\u2/u0/b1_last_row_reg_n_0_[6] ),
        .R(\<const0> ));
  FDRE \u2/u0/b1_last_row_reg[7] 
       (.C(clk_i),
        .CE(\u2/bank1_open0 ),
        .D(row_adr[7]),
        .Q(\u2/u0/b1_last_row_reg_n_0_[7] ),
        .R(\<const0> ));
  FDRE \u2/u0/b1_last_row_reg[8] 
       (.C(clk_i),
        .CE(\u2/bank1_open0 ),
        .D(row_adr[8]),
        .Q(\u2/u0/b1_last_row_reg_n_0_[8] ),
        .R(\<const0> ));
  FDRE \u2/u0/b1_last_row_reg[9] 
       (.C(clk_i),
        .CE(\u2/bank1_open0 ),
        .D(row_adr[9]),
        .Q(\u2/u0/b1_last_row_reg_n_0_[9] ),
        .R(\<const0> ));
  FDRE \u2/u0/b2_last_row_reg[0] 
       (.C(clk_i),
        .CE(\u2/bank2_open0 ),
        .D(row_adr[0]),
        .Q(\u2/u0/b2_last_row_reg_n_0_[0] ),
        .R(\<const0> ));
  FDRE \u2/u0/b2_last_row_reg[10] 
       (.C(clk_i),
        .CE(\u2/bank2_open0 ),
        .D(row_adr[10]),
        .Q(\u2/u0/b2_last_row_reg_n_0_[10] ),
        .R(\<const0> ));
  FDRE \u2/u0/b2_last_row_reg[11] 
       (.C(clk_i),
        .CE(\u2/bank2_open0 ),
        .D(row_adr[11]),
        .Q(\u2/u0/b2_last_row_reg_n_0_[11] ),
        .R(\<const0> ));
  FDRE \u2/u0/b2_last_row_reg[12] 
       (.C(clk_i),
        .CE(\u2/bank2_open0 ),
        .D(row_adr[12]),
        .Q(\u2/u0/b2_last_row_reg_n_0_[12] ),
        .R(\<const0> ));
  FDRE \u2/u0/b2_last_row_reg[1] 
       (.C(clk_i),
        .CE(\u2/bank2_open0 ),
        .D(row_adr[1]),
        .Q(\u2/u0/b2_last_row_reg_n_0_[1] ),
        .R(\<const0> ));
  FDRE \u2/u0/b2_last_row_reg[2] 
       (.C(clk_i),
        .CE(\u2/bank2_open0 ),
        .D(row_adr[2]),
        .Q(\u2/u0/b2_last_row_reg_n_0_[2] ),
        .R(\<const0> ));
  FDRE \u2/u0/b2_last_row_reg[3] 
       (.C(clk_i),
        .CE(\u2/bank2_open0 ),
        .D(row_adr[3]),
        .Q(\u2/u0/b2_last_row_reg_n_0_[3] ),
        .R(\<const0> ));
  FDRE \u2/u0/b2_last_row_reg[4] 
       (.C(clk_i),
        .CE(\u2/bank2_open0 ),
        .D(row_adr[4]),
        .Q(\u2/u0/b2_last_row_reg_n_0_[4] ),
        .R(\<const0> ));
  FDRE \u2/u0/b2_last_row_reg[5] 
       (.C(clk_i),
        .CE(\u2/bank2_open0 ),
        .D(row_adr[5]),
        .Q(\u2/u0/b2_last_row_reg_n_0_[5] ),
        .R(\<const0> ));
  FDRE \u2/u0/b2_last_row_reg[6] 
       (.C(clk_i),
        .CE(\u2/bank2_open0 ),
        .D(row_adr[6]),
        .Q(\u2/u0/b2_last_row_reg_n_0_[6] ),
        .R(\<const0> ));
  FDRE \u2/u0/b2_last_row_reg[7] 
       (.C(clk_i),
        .CE(\u2/bank2_open0 ),
        .D(row_adr[7]),
        .Q(\u2/u0/b2_last_row_reg_n_0_[7] ),
        .R(\<const0> ));
  FDRE \u2/u0/b2_last_row_reg[8] 
       (.C(clk_i),
        .CE(\u2/bank2_open0 ),
        .D(row_adr[8]),
        .Q(\u2/u0/b2_last_row_reg_n_0_[8] ),
        .R(\<const0> ));
  FDRE \u2/u0/b2_last_row_reg[9] 
       (.C(clk_i),
        .CE(\u2/bank2_open0 ),
        .D(row_adr[9]),
        .Q(\u2/u0/b2_last_row_reg_n_0_[9] ),
        .R(\<const0> ));
  FDRE \u2/u0/b3_last_row_reg[0] 
       (.C(clk_i),
        .CE(\u2/bank3_open0 ),
        .D(row_adr[0]),
        .Q(\u2/u0/b3_last_row_reg_n_0_[0] ),
        .R(\<const0> ));
  FDRE \u2/u0/b3_last_row_reg[10] 
       (.C(clk_i),
        .CE(\u2/bank3_open0 ),
        .D(row_adr[10]),
        .Q(\u2/u0/b3_last_row_reg_n_0_[10] ),
        .R(\<const0> ));
  FDRE \u2/u0/b3_last_row_reg[11] 
       (.C(clk_i),
        .CE(\u2/bank3_open0 ),
        .D(row_adr[11]),
        .Q(\u2/u0/b3_last_row_reg_n_0_[11] ),
        .R(\<const0> ));
  FDRE \u2/u0/b3_last_row_reg[12] 
       (.C(clk_i),
        .CE(\u2/bank3_open0 ),
        .D(row_adr[12]),
        .Q(\u2/u0/b3_last_row_reg_n_0_[12] ),
        .R(\<const0> ));
  FDRE \u2/u0/b3_last_row_reg[1] 
       (.C(clk_i),
        .CE(\u2/bank3_open0 ),
        .D(row_adr[1]),
        .Q(\u2/u0/b3_last_row_reg_n_0_[1] ),
        .R(\<const0> ));
  FDRE \u2/u0/b3_last_row_reg[2] 
       (.C(clk_i),
        .CE(\u2/bank3_open0 ),
        .D(row_adr[2]),
        .Q(\u2/u0/b3_last_row_reg_n_0_[2] ),
        .R(\<const0> ));
  FDRE \u2/u0/b3_last_row_reg[3] 
       (.C(clk_i),
        .CE(\u2/bank3_open0 ),
        .D(row_adr[3]),
        .Q(\u2/u0/b3_last_row_reg_n_0_[3] ),
        .R(\<const0> ));
  FDRE \u2/u0/b3_last_row_reg[4] 
       (.C(clk_i),
        .CE(\u2/bank3_open0 ),
        .D(row_adr[4]),
        .Q(\u2/u0/b3_last_row_reg_n_0_[4] ),
        .R(\<const0> ));
  FDRE \u2/u0/b3_last_row_reg[5] 
       (.C(clk_i),
        .CE(\u2/bank3_open0 ),
        .D(row_adr[5]),
        .Q(\u2/u0/b3_last_row_reg_n_0_[5] ),
        .R(\<const0> ));
  FDRE \u2/u0/b3_last_row_reg[6] 
       (.C(clk_i),
        .CE(\u2/bank3_open0 ),
        .D(row_adr[6]),
        .Q(\u2/u0/b3_last_row_reg_n_0_[6] ),
        .R(\<const0> ));
  FDRE \u2/u0/b3_last_row_reg[7] 
       (.C(clk_i),
        .CE(\u2/bank3_open0 ),
        .D(row_adr[7]),
        .Q(\u2/u0/b3_last_row_reg_n_0_[7] ),
        .R(\<const0> ));
  FDRE \u2/u0/b3_last_row_reg[8] 
       (.C(clk_i),
        .CE(\u2/bank3_open0 ),
        .D(row_adr[8]),
        .Q(\u2/u0/b3_last_row_reg_n_0_[8] ),
        .R(\<const0> ));
  FDRE \u2/u0/b3_last_row_reg[9] 
       (.C(clk_i),
        .CE(\u2/bank3_open0 ),
        .D(row_adr[9]),
        .Q(\u2/u0/b3_last_row_reg_n_0_[9] ),
        .R(\<const0> ));
  FDCE \u2/u0/bank0_open_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(bank0_open_i_1__0_n_0),
        .Q(\u2/bank0_open ));
  FDCE \u2/u0/bank1_open_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(bank1_open_i_1__0_n_0),
        .Q(\u2/bank1_open ));
  FDCE \u2/u0/bank2_open_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(bank2_open_i_1__0_n_0),
        .Q(\u2/bank2_open ));
  FDCE \u2/u0/bank3_open_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(bank3_open_i_1__0_n_0),
        .Q(\u2/bank3_open ));
  CARRY4 \u2/u0/row0_same_carry 
       (.CI(\<const0> ),
        .CO({\u2/u0/row0_same_carry_n_0 ,\u2/u0/row0_same_carry_n_1 ,\u2/u0/row0_same_carry_n_2 ,\u2/u0/row0_same_carry_n_3 }),
        .CYINIT(\<const1> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({row0_same_carry_i_1__0_n_0,row0_same_carry_i_2__0_n_0,row0_same_carry_i_3__0_n_0,row0_same_carry_i_4__0_n_0}));
  CARRY4 \u2/u0/row0_same_carry__0 
       (.CI(\u2/u0/row0_same_carry_n_0 ),
        .CO(\u2/row0_same ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({\<const0> ,\<const0> ,\<const0> ,row0_same_carry__0_i_1_n_0}));
  CARRY4 \u2/u0/row1_same_carry 
       (.CI(\<const0> ),
        .CO({\u2/u0/row1_same_carry_n_0 ,\u2/u0/row1_same_carry_n_1 ,\u2/u0/row1_same_carry_n_2 ,\u2/u0/row1_same_carry_n_3 }),
        .CYINIT(\<const1> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({row1_same_carry_i_1__0_n_0,row1_same_carry_i_2__0_n_0,row1_same_carry_i_3__0_n_0,row1_same_carry_i_4__0_n_0}));
  CARRY4 \u2/u0/row1_same_carry__0 
       (.CI(\u2/u0/row1_same_carry_n_0 ),
        .CO(\u2/row1_same ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({\<const0> ,\<const0> ,\<const0> ,row1_same_carry__0_i_1__0_n_0}));
  CARRY4 \u2/u0/row2_same_carry 
       (.CI(\<const0> ),
        .CO({\u2/u0/row2_same_carry_n_0 ,\u2/u0/row2_same_carry_n_1 ,\u2/u0/row2_same_carry_n_2 ,\u2/u0/row2_same_carry_n_3 }),
        .CYINIT(\<const1> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({row2_same_carry_i_1__0_n_0,row2_same_carry_i_2__0_n_0,row2_same_carry_i_3__0_n_0,row2_same_carry_i_4__0_n_0}));
  CARRY4 \u2/u0/row2_same_carry__0 
       (.CI(\u2/u0/row2_same_carry_n_0 ),
        .CO(\u2/row2_same ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({\<const0> ,\<const0> ,\<const0> ,row2_same_carry__0_i_1__0_n_0}));
  CARRY4 \u2/u0/row3_same_carry 
       (.CI(\<const0> ),
        .CO({\u2/u0/row3_same_carry_n_0 ,\u2/u0/row3_same_carry_n_1 ,\u2/u0/row3_same_carry_n_2 ,\u2/u0/row3_same_carry_n_3 }),
        .CYINIT(\<const1> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({row3_same_carry_i_1__0_n_0,row3_same_carry_i_2__0_n_0,row3_same_carry_i_3__0_n_0,row3_same_carry_i_4__0_n_0}));
  CARRY4 \u2/u0/row3_same_carry__0 
       (.CI(\u2/u0/row3_same_carry_n_0 ),
        .CO(\u2/row3_same ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({\<const0> ,\<const0> ,\<const0> ,row3_same_carry__0_i_1__0_n_0}));
  FDRE \u2/u1/b0_last_row_reg[0] 
       (.C(clk_i),
        .CE(\b0_last_row[12]_i_1_n_0 ),
        .D(row_adr[0]),
        .Q(b0_last_row[0]),
        .R(\<const0> ));
  FDRE \u2/u1/b0_last_row_reg[10] 
       (.C(clk_i),
        .CE(\b0_last_row[12]_i_1_n_0 ),
        .D(row_adr[10]),
        .Q(b0_last_row[10]),
        .R(\<const0> ));
  FDRE \u2/u1/b0_last_row_reg[11] 
       (.C(clk_i),
        .CE(\b0_last_row[12]_i_1_n_0 ),
        .D(row_adr[11]),
        .Q(b0_last_row[11]),
        .R(\<const0> ));
  FDRE \u2/u1/b0_last_row_reg[12] 
       (.C(clk_i),
        .CE(\b0_last_row[12]_i_1_n_0 ),
        .D(row_adr[12]),
        .Q(b0_last_row[12]),
        .R(\<const0> ));
  FDRE \u2/u1/b0_last_row_reg[1] 
       (.C(clk_i),
        .CE(\b0_last_row[12]_i_1_n_0 ),
        .D(row_adr[1]),
        .Q(b0_last_row[1]),
        .R(\<const0> ));
  FDRE \u2/u1/b0_last_row_reg[2] 
       (.C(clk_i),
        .CE(\b0_last_row[12]_i_1_n_0 ),
        .D(row_adr[2]),
        .Q(b0_last_row[2]),
        .R(\<const0> ));
  FDRE \u2/u1/b0_last_row_reg[3] 
       (.C(clk_i),
        .CE(\b0_last_row[12]_i_1_n_0 ),
        .D(row_adr[3]),
        .Q(b0_last_row[3]),
        .R(\<const0> ));
  FDRE \u2/u1/b0_last_row_reg[4] 
       (.C(clk_i),
        .CE(\b0_last_row[12]_i_1_n_0 ),
        .D(row_adr[4]),
        .Q(b0_last_row[4]),
        .R(\<const0> ));
  FDRE \u2/u1/b0_last_row_reg[5] 
       (.C(clk_i),
        .CE(\b0_last_row[12]_i_1_n_0 ),
        .D(row_adr[5]),
        .Q(b0_last_row[5]),
        .R(\<const0> ));
  FDRE \u2/u1/b0_last_row_reg[6] 
       (.C(clk_i),
        .CE(\b0_last_row[12]_i_1_n_0 ),
        .D(row_adr[6]),
        .Q(b0_last_row[6]),
        .R(\<const0> ));
  FDRE \u2/u1/b0_last_row_reg[7] 
       (.C(clk_i),
        .CE(\b0_last_row[12]_i_1_n_0 ),
        .D(row_adr[7]),
        .Q(b0_last_row[7]),
        .R(\<const0> ));
  FDRE \u2/u1/b0_last_row_reg[8] 
       (.C(clk_i),
        .CE(\b0_last_row[12]_i_1_n_0 ),
        .D(row_adr[8]),
        .Q(b0_last_row[8]),
        .R(\<const0> ));
  FDRE \u2/u1/b0_last_row_reg[9] 
       (.C(clk_i),
        .CE(\b0_last_row[12]_i_1_n_0 ),
        .D(row_adr[9]),
        .Q(b0_last_row[9]),
        .R(\<const0> ));
  FDRE \u2/u1/b1_last_row_reg[0] 
       (.C(clk_i),
        .CE(\b1_last_row[12]_i_1_n_0 ),
        .D(row_adr[0]),
        .Q(b1_last_row[0]),
        .R(\<const0> ));
  FDRE \u2/u1/b1_last_row_reg[10] 
       (.C(clk_i),
        .CE(\b1_last_row[12]_i_1_n_0 ),
        .D(row_adr[10]),
        .Q(b1_last_row[10]),
        .R(\<const0> ));
  FDRE \u2/u1/b1_last_row_reg[11] 
       (.C(clk_i),
        .CE(\b1_last_row[12]_i_1_n_0 ),
        .D(row_adr[11]),
        .Q(b1_last_row[11]),
        .R(\<const0> ));
  FDRE \u2/u1/b1_last_row_reg[12] 
       (.C(clk_i),
        .CE(\b1_last_row[12]_i_1_n_0 ),
        .D(row_adr[12]),
        .Q(b1_last_row[12]),
        .R(\<const0> ));
  FDRE \u2/u1/b1_last_row_reg[1] 
       (.C(clk_i),
        .CE(\b1_last_row[12]_i_1_n_0 ),
        .D(row_adr[1]),
        .Q(b1_last_row[1]),
        .R(\<const0> ));
  FDRE \u2/u1/b1_last_row_reg[2] 
       (.C(clk_i),
        .CE(\b1_last_row[12]_i_1_n_0 ),
        .D(row_adr[2]),
        .Q(b1_last_row[2]),
        .R(\<const0> ));
  FDRE \u2/u1/b1_last_row_reg[3] 
       (.C(clk_i),
        .CE(\b1_last_row[12]_i_1_n_0 ),
        .D(row_adr[3]),
        .Q(b1_last_row[3]),
        .R(\<const0> ));
  FDRE \u2/u1/b1_last_row_reg[4] 
       (.C(clk_i),
        .CE(\b1_last_row[12]_i_1_n_0 ),
        .D(row_adr[4]),
        .Q(b1_last_row[4]),
        .R(\<const0> ));
  FDRE \u2/u1/b1_last_row_reg[5] 
       (.C(clk_i),
        .CE(\b1_last_row[12]_i_1_n_0 ),
        .D(row_adr[5]),
        .Q(b1_last_row[5]),
        .R(\<const0> ));
  FDRE \u2/u1/b1_last_row_reg[6] 
       (.C(clk_i),
        .CE(\b1_last_row[12]_i_1_n_0 ),
        .D(row_adr[6]),
        .Q(b1_last_row[6]),
        .R(\<const0> ));
  FDRE \u2/u1/b1_last_row_reg[7] 
       (.C(clk_i),
        .CE(\b1_last_row[12]_i_1_n_0 ),
        .D(row_adr[7]),
        .Q(b1_last_row[7]),
        .R(\<const0> ));
  FDRE \u2/u1/b1_last_row_reg[8] 
       (.C(clk_i),
        .CE(\b1_last_row[12]_i_1_n_0 ),
        .D(row_adr[8]),
        .Q(b1_last_row[8]),
        .R(\<const0> ));
  FDRE \u2/u1/b1_last_row_reg[9] 
       (.C(clk_i),
        .CE(\b1_last_row[12]_i_1_n_0 ),
        .D(row_adr[9]),
        .Q(b1_last_row[9]),
        .R(\<const0> ));
  FDRE \u2/u1/b2_last_row_reg[0] 
       (.C(clk_i),
        .CE(\b2_last_row[12]_i_1_n_0 ),
        .D(row_adr[0]),
        .Q(b2_last_row[0]),
        .R(\<const0> ));
  FDRE \u2/u1/b2_last_row_reg[10] 
       (.C(clk_i),
        .CE(\b2_last_row[12]_i_1_n_0 ),
        .D(row_adr[10]),
        .Q(b2_last_row[10]),
        .R(\<const0> ));
  FDRE \u2/u1/b2_last_row_reg[11] 
       (.C(clk_i),
        .CE(\b2_last_row[12]_i_1_n_0 ),
        .D(row_adr[11]),
        .Q(b2_last_row[11]),
        .R(\<const0> ));
  FDRE \u2/u1/b2_last_row_reg[12] 
       (.C(clk_i),
        .CE(\b2_last_row[12]_i_1_n_0 ),
        .D(row_adr[12]),
        .Q(b2_last_row[12]),
        .R(\<const0> ));
  FDRE \u2/u1/b2_last_row_reg[1] 
       (.C(clk_i),
        .CE(\b2_last_row[12]_i_1_n_0 ),
        .D(row_adr[1]),
        .Q(b2_last_row[1]),
        .R(\<const0> ));
  FDRE \u2/u1/b2_last_row_reg[2] 
       (.C(clk_i),
        .CE(\b2_last_row[12]_i_1_n_0 ),
        .D(row_adr[2]),
        .Q(b2_last_row[2]),
        .R(\<const0> ));
  FDRE \u2/u1/b2_last_row_reg[3] 
       (.C(clk_i),
        .CE(\b2_last_row[12]_i_1_n_0 ),
        .D(row_adr[3]),
        .Q(b2_last_row[3]),
        .R(\<const0> ));
  FDRE \u2/u1/b2_last_row_reg[4] 
       (.C(clk_i),
        .CE(\b2_last_row[12]_i_1_n_0 ),
        .D(row_adr[4]),
        .Q(b2_last_row[4]),
        .R(\<const0> ));
  FDRE \u2/u1/b2_last_row_reg[5] 
       (.C(clk_i),
        .CE(\b2_last_row[12]_i_1_n_0 ),
        .D(row_adr[5]),
        .Q(b2_last_row[5]),
        .R(\<const0> ));
  FDRE \u2/u1/b2_last_row_reg[6] 
       (.C(clk_i),
        .CE(\b2_last_row[12]_i_1_n_0 ),
        .D(row_adr[6]),
        .Q(b2_last_row[6]),
        .R(\<const0> ));
  FDRE \u2/u1/b2_last_row_reg[7] 
       (.C(clk_i),
        .CE(\b2_last_row[12]_i_1_n_0 ),
        .D(row_adr[7]),
        .Q(b2_last_row[7]),
        .R(\<const0> ));
  FDRE \u2/u1/b2_last_row_reg[8] 
       (.C(clk_i),
        .CE(\b2_last_row[12]_i_1_n_0 ),
        .D(row_adr[8]),
        .Q(b2_last_row[8]),
        .R(\<const0> ));
  FDRE \u2/u1/b2_last_row_reg[9] 
       (.C(clk_i),
        .CE(\b2_last_row[12]_i_1_n_0 ),
        .D(row_adr[9]),
        .Q(b2_last_row[9]),
        .R(\<const0> ));
  FDRE \u2/u1/b3_last_row_reg[0] 
       (.C(clk_i),
        .CE(\b3_last_row[12]_i_1_n_0 ),
        .D(row_adr[0]),
        .Q(b3_last_row[0]),
        .R(\<const0> ));
  FDRE \u2/u1/b3_last_row_reg[10] 
       (.C(clk_i),
        .CE(\b3_last_row[12]_i_1_n_0 ),
        .D(row_adr[10]),
        .Q(b3_last_row[10]),
        .R(\<const0> ));
  FDRE \u2/u1/b3_last_row_reg[11] 
       (.C(clk_i),
        .CE(\b3_last_row[12]_i_1_n_0 ),
        .D(row_adr[11]),
        .Q(b3_last_row[11]),
        .R(\<const0> ));
  FDRE \u2/u1/b3_last_row_reg[12] 
       (.C(clk_i),
        .CE(\b3_last_row[12]_i_1_n_0 ),
        .D(row_adr[12]),
        .Q(b3_last_row[12]),
        .R(\<const0> ));
  FDRE \u2/u1/b3_last_row_reg[1] 
       (.C(clk_i),
        .CE(\b3_last_row[12]_i_1_n_0 ),
        .D(row_adr[1]),
        .Q(b3_last_row[1]),
        .R(\<const0> ));
  FDRE \u2/u1/b3_last_row_reg[2] 
       (.C(clk_i),
        .CE(\b3_last_row[12]_i_1_n_0 ),
        .D(row_adr[2]),
        .Q(b3_last_row[2]),
        .R(\<const0> ));
  FDRE \u2/u1/b3_last_row_reg[3] 
       (.C(clk_i),
        .CE(\b3_last_row[12]_i_1_n_0 ),
        .D(row_adr[3]),
        .Q(b3_last_row[3]),
        .R(\<const0> ));
  FDRE \u2/u1/b3_last_row_reg[4] 
       (.C(clk_i),
        .CE(\b3_last_row[12]_i_1_n_0 ),
        .D(row_adr[4]),
        .Q(b3_last_row[4]),
        .R(\<const0> ));
  FDRE \u2/u1/b3_last_row_reg[5] 
       (.C(clk_i),
        .CE(\b3_last_row[12]_i_1_n_0 ),
        .D(row_adr[5]),
        .Q(b3_last_row[5]),
        .R(\<const0> ));
  FDRE \u2/u1/b3_last_row_reg[6] 
       (.C(clk_i),
        .CE(\b3_last_row[12]_i_1_n_0 ),
        .D(row_adr[6]),
        .Q(b3_last_row[6]),
        .R(\<const0> ));
  FDRE \u2/u1/b3_last_row_reg[7] 
       (.C(clk_i),
        .CE(\b3_last_row[12]_i_1_n_0 ),
        .D(row_adr[7]),
        .Q(b3_last_row[7]),
        .R(\<const0> ));
  FDRE \u2/u1/b3_last_row_reg[8] 
       (.C(clk_i),
        .CE(\b3_last_row[12]_i_1_n_0 ),
        .D(row_adr[8]),
        .Q(b3_last_row[8]),
        .R(\<const0> ));
  FDRE \u2/u1/b3_last_row_reg[9] 
       (.C(clk_i),
        .CE(\b3_last_row[12]_i_1_n_0 ),
        .D(row_adr[9]),
        .Q(b3_last_row[9]),
        .R(\<const0> ));
  FDCE \u2/u1/bank0_open_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(bank0_open_i_1_n_0),
        .Q(\u2/u1/bank0_open_reg_n_0 ));
  FDCE \u2/u1/bank1_open_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(bank1_open_i_1_n_0),
        .Q(\u2/u1/bank1_open_reg_n_0 ));
  FDCE \u2/u1/bank2_open_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(bank2_open_i_1_n_0),
        .Q(\u2/u1/bank2_open_reg_n_0 ));
  FDCE \u2/u1/bank3_open_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(bank3_open_i_1_n_0),
        .Q(\u2/u1/bank3_open_reg_n_0 ));
  CARRY4 \u2/u1/row0_same_carry 
       (.CI(\<const0> ),
        .CO({\u2/u1/row0_same_carry_n_0 ,\u2/u1/row0_same_carry_n_1 ,\u2/u1/row0_same_carry_n_2 ,\u2/u1/row0_same_carry_n_3 }),
        .CYINIT(\<const1> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({row0_same_carry_i_1_n_0,row0_same_carry_i_2_n_0,row0_same_carry_i_3_n_0,row0_same_carry_i_4_n_0}));
  CARRY4 \u2/u1/row0_same_carry__0 
       (.CI(\u2/u1/row0_same_carry_n_0 ),
        .CO(\u2/u1/row0_same_carry__0_n_3 ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({\<const0> ,\<const0> ,\<const0> ,row0_same_carry__0_i_1__0_n_0}));
  CARRY4 \u2/u1/row1_same_carry 
       (.CI(\<const0> ),
        .CO({\u2/u1/row1_same_carry_n_0 ,\u2/u1/row1_same_carry_n_1 ,\u2/u1/row1_same_carry_n_2 ,\u2/u1/row1_same_carry_n_3 }),
        .CYINIT(\<const1> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({row1_same_carry_i_1_n_0,row1_same_carry_i_2_n_0,row1_same_carry_i_3_n_0,row1_same_carry_i_4_n_0}));
  CARRY4 \u2/u1/row1_same_carry__0 
       (.CI(\u2/u1/row1_same_carry_n_0 ),
        .CO(\u2/u1/row1_same_carry__0_n_3 ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({\<const0> ,\<const0> ,\<const0> ,row1_same_carry__0_i_1_n_0}));
  CARRY4 \u2/u1/row2_same_carry 
       (.CI(\<const0> ),
        .CO({\u2/u1/row2_same_carry_n_0 ,\u2/u1/row2_same_carry_n_1 ,\u2/u1/row2_same_carry_n_2 ,\u2/u1/row2_same_carry_n_3 }),
        .CYINIT(\<const1> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({row2_same_carry_i_1_n_0,row2_same_carry_i_2_n_0,row2_same_carry_i_3_n_0,row2_same_carry_i_4_n_0}));
  CARRY4 \u2/u1/row2_same_carry__0 
       (.CI(\u2/u1/row2_same_carry_n_0 ),
        .CO(\u2/u1/row2_same_carry__0_n_3 ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({\<const0> ,\<const0> ,\<const0> ,row2_same_carry__0_i_1_n_0}));
  CARRY4 \u2/u1/row3_same_carry 
       (.CI(\<const0> ),
        .CO({\u2/u1/row3_same_carry_n_0 ,\u2/u1/row3_same_carry_n_1 ,\u2/u1/row3_same_carry_n_2 ,\u2/u1/row3_same_carry_n_3 }),
        .CYINIT(\<const1> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({row3_same_carry_i_1_n_0,row3_same_carry_i_2_n_0,row3_same_carry_i_3_n_0,row3_same_carry_i_4_n_0}));
  CARRY4 \u2/u1/row3_same_carry__0 
       (.CI(\u2/u1/row3_same_carry_n_0 ),
        .CO(\u2/u1/row3_same_carry__0_n_3 ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({\<const0> ,\<const0> ,\<const0> ,row3_same_carry__0_i_1_n_0}));
  FDRE \u3/byte0_reg[0] 
       (.C(clk_i),
        .CE(pack_le0),
        .D(mc_data_ir[0]),
        .Q(byte0[0]),
        .R(\<const0> ));
  FDRE \u3/byte0_reg[1] 
       (.C(clk_i),
        .CE(pack_le0),
        .D(mc_data_ir[1]),
        .Q(byte0[1]),
        .R(\<const0> ));
  FDRE \u3/byte0_reg[2] 
       (.C(clk_i),
        .CE(pack_le0),
        .D(mc_data_ir[2]),
        .Q(byte0[2]),
        .R(\<const0> ));
  FDRE \u3/byte0_reg[3] 
       (.C(clk_i),
        .CE(pack_le0),
        .D(mc_data_ir[3]),
        .Q(byte0[3]),
        .R(\<const0> ));
  FDRE \u3/byte0_reg[4] 
       (.C(clk_i),
        .CE(pack_le0),
        .D(mc_data_ir[4]),
        .Q(byte0[4]),
        .R(\<const0> ));
  FDRE \u3/byte0_reg[5] 
       (.C(clk_i),
        .CE(pack_le0),
        .D(mc_data_ir[5]),
        .Q(byte0[5]),
        .R(\<const0> ));
  FDRE \u3/byte0_reg[6] 
       (.C(clk_i),
        .CE(pack_le0),
        .D(mc_data_ir[6]),
        .Q(byte0[6]),
        .R(\<const0> ));
  FDRE \u3/byte0_reg[7] 
       (.C(clk_i),
        .CE(pack_le0),
        .D(mc_data_ir[7]),
        .Q(byte0[7]),
        .R(\<const0> ));
  FDRE \u3/byte1_reg[0] 
       (.C(clk_i),
        .CE(\byte1[7]_i_1_n_0 ),
        .D(\byte1[0]_i_1_n_0 ),
        .Q(byte1[0]),
        .R(\<const0> ));
  FDRE \u3/byte1_reg[1] 
       (.C(clk_i),
        .CE(\byte1[7]_i_1_n_0 ),
        .D(\byte1[1]_i_1_n_0 ),
        .Q(byte1[1]),
        .R(\<const0> ));
  FDRE \u3/byte1_reg[2] 
       (.C(clk_i),
        .CE(\byte1[7]_i_1_n_0 ),
        .D(\byte1[2]_i_1_n_0 ),
        .Q(byte1[2]),
        .R(\<const0> ));
  FDRE \u3/byte1_reg[3] 
       (.C(clk_i),
        .CE(\byte1[7]_i_1_n_0 ),
        .D(\byte1[3]_i_1_n_0 ),
        .Q(byte1[3]),
        .R(\<const0> ));
  FDRE \u3/byte1_reg[4] 
       (.C(clk_i),
        .CE(\byte1[7]_i_1_n_0 ),
        .D(\byte1[4]_i_1_n_0 ),
        .Q(byte1[4]),
        .R(\<const0> ));
  FDRE \u3/byte1_reg[5] 
       (.C(clk_i),
        .CE(\byte1[7]_i_1_n_0 ),
        .D(\byte1[5]_i_1_n_0 ),
        .Q(byte1[5]),
        .R(\<const0> ));
  FDRE \u3/byte1_reg[6] 
       (.C(clk_i),
        .CE(\byte1[7]_i_1_n_0 ),
        .D(\byte1[6]_i_1_n_0 ),
        .Q(byte1[6]),
        .R(\<const0> ));
  FDRE \u3/byte1_reg[7] 
       (.C(clk_i),
        .CE(\byte1[7]_i_1_n_0 ),
        .D(\byte1[7]_i_2_n_0 ),
        .Q(byte1[7]),
        .R(\<const0> ));
  FDRE \u3/byte2_reg[0] 
       (.C(clk_i),
        .CE(pack_le2),
        .D(mc_data_ir[0]),
        .Q(byte2[0]),
        .R(\<const0> ));
  FDRE \u3/byte2_reg[1] 
       (.C(clk_i),
        .CE(pack_le2),
        .D(mc_data_ir[1]),
        .Q(byte2[1]),
        .R(\<const0> ));
  FDRE \u3/byte2_reg[2] 
       (.C(clk_i),
        .CE(pack_le2),
        .D(mc_data_ir[2]),
        .Q(byte2[2]),
        .R(\<const0> ));
  FDRE \u3/byte2_reg[3] 
       (.C(clk_i),
        .CE(pack_le2),
        .D(mc_data_ir[3]),
        .Q(byte2[3]),
        .R(\<const0> ));
  FDRE \u3/byte2_reg[4] 
       (.C(clk_i),
        .CE(pack_le2),
        .D(mc_data_ir[4]),
        .Q(byte2[4]),
        .R(\<const0> ));
  FDRE \u3/byte2_reg[5] 
       (.C(clk_i),
        .CE(pack_le2),
        .D(mc_data_ir[5]),
        .Q(byte2[5]),
        .R(\<const0> ));
  FDRE \u3/byte2_reg[6] 
       (.C(clk_i),
        .CE(pack_le2),
        .D(mc_data_ir[6]),
        .Q(byte2[6]),
        .R(\<const0> ));
  FDRE \u3/byte2_reg[7] 
       (.C(clk_i),
        .CE(pack_le2),
        .D(mc_data_ir[7]),
        .Q(byte2[7]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[0] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[0]),
        .Q(mc_data_o[0]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[10] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[10]),
        .Q(mc_data_o[10]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[11] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[11]),
        .Q(mc_data_o[11]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[12] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[12]),
        .Q(mc_data_o[12]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[13] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[13]),
        .Q(mc_data_o[13]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[14] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[14]),
        .Q(mc_data_o[14]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[15] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[15]),
        .Q(mc_data_o[15]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[16] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[16]),
        .Q(mc_data_o[16]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[17] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[17]),
        .Q(mc_data_o[17]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[18] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[18]),
        .Q(mc_data_o[18]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[19] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[19]),
        .Q(mc_data_o[19]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[1] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[1]),
        .Q(mc_data_o[1]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[20] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[20]),
        .Q(mc_data_o[20]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[21] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[21]),
        .Q(mc_data_o[21]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[22] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[22]),
        .Q(mc_data_o[22]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[23] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[23]),
        .Q(mc_data_o[23]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[24] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[24]),
        .Q(mc_data_o[24]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[25] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[25]),
        .Q(mc_data_o[25]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[26] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[26]),
        .Q(mc_data_o[26]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[27] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[27]),
        .Q(mc_data_o[27]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[28] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[28]),
        .Q(mc_data_o[28]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[29] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[29]),
        .Q(mc_data_o[29]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[2] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[2]),
        .Q(mc_data_o[2]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[30] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[30]),
        .Q(mc_data_o[30]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[31] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[31]),
        .Q(mc_data_o[31]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[3] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[3]),
        .Q(mc_data_o[3]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[4] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[4]),
        .Q(mc_data_o[4]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[5] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[5]),
        .Q(mc_data_o[5]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[6] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[6]),
        .Q(mc_data_o[6]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[7] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[7]),
        .Q(mc_data_o[7]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[8] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[8]),
        .Q(mc_data_o[8]),
        .R(\<const0> ));
  FDRE \u3/mc_data_o_reg[9] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(wb_data_i[9]),
        .Q(mc_data_o[9]),
        .R(\<const0> ));
  FDRE \u3/mc_dp_o_reg[0] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(\mc_dp_o[0]_i_1_n_0 ),
        .Q(mc_dp_o[0]),
        .R(\<const0> ));
  FDRE \u3/mc_dp_o_reg[1] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(\mc_dp_o[1]_i_1_n_0 ),
        .Q(mc_dp_o[1]),
        .R(\<const0> ));
  FDRE \u3/mc_dp_o_reg[2] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(\mc_dp_o[2]_i_1_n_0 ),
        .Q(mc_dp_o[2]),
        .R(\<const0> ));
  FDRE \u3/mc_dp_o_reg[3] 
       (.C(clk_i),
        .CE(\u3/mc_data_o0 ),
        .D(mc_dp_o0),
        .Q(mc_dp_o[3]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[0] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[0]),
        .Q(r0[0]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[10] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[10]),
        .Q(r0[10]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[11] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[11]),
        .Q(r0[11]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[12] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[12]),
        .Q(r0[12]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[13] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[13]),
        .Q(r0[13]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[14] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[14]),
        .Q(r0[14]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[15] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[15]),
        .Q(r0[15]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[16] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[16]),
        .Q(r0[16]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[17] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[17]),
        .Q(r0[17]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[18] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[18]),
        .Q(r0[18]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[19] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[19]),
        .Q(r0[19]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[1] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[1]),
        .Q(r0[1]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[20] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[20]),
        .Q(r0[20]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[21] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[21]),
        .Q(r0[21]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[22] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[22]),
        .Q(r0[22]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[23] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[23]),
        .Q(r0[23]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[24] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[24]),
        .Q(r0[24]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[25] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[25]),
        .Q(r0[25]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[26] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[26]),
        .Q(r0[26]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[27] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[27]),
        .Q(r0[27]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[28] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[28]),
        .Q(r0[28]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[29] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[29]),
        .Q(r0[29]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[2] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[2]),
        .Q(r0[2]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[30] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[30]),
        .Q(r0[30]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[31] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[31]),
        .Q(r0[31]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[32] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[32]),
        .Q(r0[32]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[33] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[33]),
        .Q(r0[33]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[34] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[34]),
        .Q(r0[34]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[35] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[35]),
        .Q(r0[35]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[3] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[3]),
        .Q(r0[3]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[4] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[4]),
        .Q(r0[4]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[5] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[5]),
        .Q(r0[5]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[6] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[6]),
        .Q(r0[6]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[7] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[7]),
        .Q(r0[7]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[8] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[8]),
        .Q(r0[8]),
        .R(\<const0> ));
  FDRE \u3/u0/r0_reg[9] 
       (.C(clk_i),
        .CE(\u3/u0/r00 ),
        .D(mc_data_ir[9]),
        .Q(r0[9]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[0] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[0]),
        .Q(r1[0]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[10] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[10]),
        .Q(r1[10]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[11] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[11]),
        .Q(r1[11]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[12] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[12]),
        .Q(r1[12]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[13] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[13]),
        .Q(r1[13]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[14] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[14]),
        .Q(r1[14]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[15] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[15]),
        .Q(r1[15]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[16] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[16]),
        .Q(r1[16]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[17] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[17]),
        .Q(r1[17]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[18] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[18]),
        .Q(r1[18]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[19] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[19]),
        .Q(r1[19]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[1] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[1]),
        .Q(r1[1]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[20] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[20]),
        .Q(r1[20]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[21] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[21]),
        .Q(r1[21]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[22] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[22]),
        .Q(r1[22]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[23] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[23]),
        .Q(r1[23]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[24] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[24]),
        .Q(r1[24]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[25] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[25]),
        .Q(r1[25]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[26] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[26]),
        .Q(r1[26]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[27] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[27]),
        .Q(r1[27]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[28] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[28]),
        .Q(r1[28]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[29] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[29]),
        .Q(r1[29]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[2] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[2]),
        .Q(r1[2]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[30] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[30]),
        .Q(r1[30]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[31] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[31]),
        .Q(r1[31]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[32] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[32]),
        .Q(r1[32]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[33] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[33]),
        .Q(r1[33]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[34] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[34]),
        .Q(r1[34]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[35] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[35]),
        .Q(r1[35]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[3] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[3]),
        .Q(r1[3]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[4] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[4]),
        .Q(r1[4]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[5] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[5]),
        .Q(r1[5]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[6] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[6]),
        .Q(r1[6]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[7] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[7]),
        .Q(r1[7]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[8] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[8]),
        .Q(r1[8]),
        .R(\<const0> ));
  FDRE \u3/u0/r1_reg[9] 
       (.C(clk_i),
        .CE(\u3/u0/r10 ),
        .D(mc_data_ir[9]),
        .Q(r1[9]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[0] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[0]),
        .Q(r2[0]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[10] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[10]),
        .Q(r2[10]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[11] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[11]),
        .Q(r2[11]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[12] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[12]),
        .Q(r2[12]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[13] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[13]),
        .Q(r2[13]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[14] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[14]),
        .Q(r2[14]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[15] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[15]),
        .Q(r2[15]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[16] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[16]),
        .Q(r2[16]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[17] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[17]),
        .Q(r2[17]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[18] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[18]),
        .Q(r2[18]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[19] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[19]),
        .Q(r2[19]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[1] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[1]),
        .Q(r2[1]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[20] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[20]),
        .Q(r2[20]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[21] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[21]),
        .Q(r2[21]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[22] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[22]),
        .Q(r2[22]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[23] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[23]),
        .Q(r2[23]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[24] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[24]),
        .Q(r2[24]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[25] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[25]),
        .Q(r2[25]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[26] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[26]),
        .Q(r2[26]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[27] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[27]),
        .Q(r2[27]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[28] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[28]),
        .Q(r2[28]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[29] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[29]),
        .Q(r2[29]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[2] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[2]),
        .Q(r2[2]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[30] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[30]),
        .Q(r2[30]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[31] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[31]),
        .Q(r2[31]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[32] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[32]),
        .Q(r2[32]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[33] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[33]),
        .Q(r2[33]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[34] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[34]),
        .Q(r2[34]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[35] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[35]),
        .Q(r2[35]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[3] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[3]),
        .Q(r2[3]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[4] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[4]),
        .Q(r2[4]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[5] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[5]),
        .Q(r2[5]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[6] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[6]),
        .Q(r2[6]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[7] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[7]),
        .Q(r2[7]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[8] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[8]),
        .Q(r2[8]),
        .R(\<const0> ));
  FDRE \u3/u0/r2_reg[9] 
       (.C(clk_i),
        .CE(\u3/u0/r20 ),
        .D(mc_data_ir[9]),
        .Q(r2[9]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[0] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[0]),
        .Q(r3[0]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[10] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[10]),
        .Q(r3[10]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[11] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[11]),
        .Q(r3[11]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[12] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[12]),
        .Q(r3[12]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[13] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[13]),
        .Q(r3[13]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[14] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[14]),
        .Q(r3[14]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[15] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[15]),
        .Q(r3[15]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[16] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[16]),
        .Q(r3[16]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[17] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[17]),
        .Q(r3[17]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[18] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[18]),
        .Q(r3[18]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[19] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[19]),
        .Q(r3[19]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[1] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[1]),
        .Q(r3[1]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[20] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[20]),
        .Q(r3[20]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[21] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[21]),
        .Q(r3[21]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[22] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[22]),
        .Q(r3[22]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[23] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[23]),
        .Q(r3[23]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[24] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[24]),
        .Q(r3[24]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[25] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[25]),
        .Q(r3[25]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[26] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[26]),
        .Q(r3[26]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[27] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[27]),
        .Q(r3[27]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[28] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[28]),
        .Q(r3[28]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[29] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[29]),
        .Q(r3[29]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[2] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[2]),
        .Q(r3[2]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[30] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[30]),
        .Q(r3[30]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[31] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[31]),
        .Q(r3[31]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[32] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[32]),
        .Q(r3[32]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[33] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[33]),
        .Q(r3[33]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[34] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[34]),
        .Q(r3[34]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[35] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[35]),
        .Q(r3[35]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[3] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[3]),
        .Q(r3[3]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[4] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[4]),
        .Q(r3[4]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[5] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[5]),
        .Q(r3[5]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[6] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[6]),
        .Q(r3[6]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[7] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[7]),
        .Q(r3[7]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[8] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[8]),
        .Q(r3[8]),
        .R(\<const0> ));
  FDRE \u3/u0/r3_reg[9] 
       (.C(clk_i),
        .CE(\u3/u0/r30 ),
        .D(mc_data_ir[9]),
        .Q(r3[9]),
        .R(\<const0> ));
  FDPE \u3/u0/rd_adr_reg[0] 
       (.C(clk_i),
        .CE(\rd_adr[3]_i_1_n_0 ),
        .D(\rd_adr[0]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u3/u0/rd_adr [0]));
  FDCE \u3/u0/rd_adr_reg[1] 
       (.C(clk_i),
        .CE(\rd_adr[3]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\rd_adr[1]_i_1_n_0 ),
        .Q(\u3/u0/rd_adr [1]));
  FDCE \u3/u0/rd_adr_reg[2] 
       (.C(clk_i),
        .CE(\rd_adr[3]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\rd_adr[2]_i_1_n_0 ),
        .Q(\u3/u0/rd_adr [2]));
  FDCE \u3/u0/rd_adr_reg[3] 
       (.C(clk_i),
        .CE(\rd_adr[3]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\rd_adr[3]_i_2_n_0 ),
        .Q(\u3/u0/rd_adr [3]));
  FDPE \u3/u0/wr_adr_reg[0] 
       (.C(clk_i),
        .CE(\wr_adr[3]_i_1_n_0 ),
        .D(\wr_adr[0]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u3/u0/wr_adr_reg_n_0_[0] ));
  FDCE \u3/u0/wr_adr_reg[1] 
       (.C(clk_i),
        .CE(\wr_adr[3]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\wr_adr[1]_i_1_n_0 ),
        .Q(\u3/u0/p_0_in1_in ));
  FDCE \u3/u0/wr_adr_reg[2] 
       (.C(clk_i),
        .CE(\wr_adr[3]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\wr_adr[2]_i_1_n_0 ),
        .Q(\u3/u0/p_0_in0_in ));
  FDCE \u3/u0/wr_adr_reg[3] 
       (.C(clk_i),
        .CE(\wr_adr[3]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\wr_adr[3]_i_2_n_0 ),
        .Q(\u3/u0/p_0_in ));
  FDCE \u4/ps_cnt_reg[0] 
       (.C(clk_i),
        .CE(\ps_cnt[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(p_0_in__1[0]),
        .Q(\u4/ps_cnt_reg [0]));
  FDCE \u4/ps_cnt_reg[1] 
       (.C(clk_i),
        .CE(\ps_cnt[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(p_0_in__1[1]),
        .Q(\u4/ps_cnt_reg [1]));
  FDCE \u4/ps_cnt_reg[2] 
       (.C(clk_i),
        .CE(\ps_cnt[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(p_0_in__1[2]),
        .Q(\u4/ps_cnt_reg [2]));
  FDCE \u4/ps_cnt_reg[3] 
       (.C(clk_i),
        .CE(\ps_cnt[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(p_0_in__1[3]),
        .Q(\u4/ps_cnt_reg [3]));
  FDCE \u4/ps_cnt_reg[4] 
       (.C(clk_i),
        .CE(\ps_cnt[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(p_0_in__1[4]),
        .Q(\u4/ps_cnt_reg [4]));
  FDCE \u4/ps_cnt_reg[5] 
       (.C(clk_i),
        .CE(\ps_cnt[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(p_0_in__1[5]),
        .Q(\u4/ps_cnt_reg [5]));
  FDCE \u4/ps_cnt_reg[6] 
       (.C(clk_i),
        .CE(\ps_cnt[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(p_0_in__1[6]),
        .Q(\u4/ps_cnt_reg [6]));
  FDCE \u4/ps_cnt_reg[7] 
       (.C(clk_i),
        .CE(\ps_cnt[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(p_0_in__1[7]),
        .Q(\u4/ps_cnt_reg [7]));
  FDCE \u4/rfr_ce_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u4/ps_cnt_clr ),
        .Q(\u4/rfr_ce ));
  FDRE \u4/rfr_clr_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u4/rfr_clr ),
        .Q(\u4/rfr_clr_reg_n_0 ),
        .R(\<const0> ));
  FDCE \u4/rfr_cnt_reg[0] 
       (.C(clk_i),
        .CE(\rfr_cnt[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(p_0_in__2[0]),
        .Q(\u4/rfr_cnt_reg ));
  FDCE \u4/rfr_cnt_reg[1] 
       (.C(clk_i),
        .CE(\rfr_cnt[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(p_0_in__2[1]),
        .Q(\u4/rfr_cnt_reg__0 [1]));
  FDCE \u4/rfr_cnt_reg[2] 
       (.C(clk_i),
        .CE(\rfr_cnt[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\rfr_cnt[2]_i_1_n_0 ),
        .Q(\u4/rfr_cnt_reg__0 [2]));
  FDCE \u4/rfr_cnt_reg[3] 
       (.C(clk_i),
        .CE(\rfr_cnt[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(p_0_in__2[3]),
        .Q(\u4/rfr_cnt_reg__0 [3]));
  FDCE \u4/rfr_cnt_reg[4] 
       (.C(clk_i),
        .CE(\rfr_cnt[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\rfr_cnt[4]_i_1_n_0 ),
        .Q(\u4/rfr_cnt_reg__0 [4]));
  FDCE \u4/rfr_cnt_reg[5] 
       (.C(clk_i),
        .CE(\rfr_cnt[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(p_0_in__2[5]),
        .Q(\u4/rfr_cnt_reg__0 [5]));
  FDCE \u4/rfr_cnt_reg[6] 
       (.C(clk_i),
        .CE(\rfr_cnt[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\rfr_cnt[6]_i_1_n_0 ),
        .Q(\u4/rfr_cnt_reg__0 [6]));
  FDCE \u4/rfr_cnt_reg[7] 
       (.C(clk_i),
        .CE(\rfr_cnt[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(p_0_in__2[7]),
        .Q(\u4/rfr_cnt_reg__0 [7]));
  FDCE \u4/rfr_early_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u4/ps_cnt_clr01_in ),
        .Q(\u4/rfr_early ));
  FDCE \u4/rfr_en_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(rfr_en_i_1_n_0),
        .Q(\u4/rfr_en ));
  FDCE \u4/rfr_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(rfr_req_i_1_n_0),
        .Q(rfr_req));
  (* FSM_ENCODED_STATES = "ACTIVATE_W:0010110,ACS_RD2:0101101,SUSP4:0010000,SCS_RD2:0110011,ACS_WR3:0100010,LMR0:0001010,SCS_ERR:0110100,BG0:0111110,IDLE:0000001,RESUME2:0010010,SCS_WR1:0110000,POR:0000000,BG1:0111111,INIT_REFR1_W:0001000,SRAM_RD4:0111101,IDLE_T:1000001,ACS_RD_8_6:0101011,SD_WR_W:0011000,SRAM_RD2:0111011,INIT_W:0000110,BG2:1000000,IDLE_T2:0110101,SRAM_WR:0110110,INIT_LMR:0001001,ACS_RD_8_4:0101001,SD_RD_W2:0011101,ACS_RD3:0101110,RESUME1:0010001,SD_RD_WR:0010100,SCS_WR:0101111,ACS_WR:0011111,BT:0011100,SRAM_RD0:0111001,INIT0:0000100,INIT_REFR1:0000111,SRAM_RD3:0111100,LMR2:0001100,SRAM_RD:0111000,ACS_RD:0100100,PRECHARGE:0000010,SUSP1:0001101,SRAM_WR0:0110111,PRECHARGE_W:0000011,ACS_RD1:0100101,SUSP2:0001110,SCS_RD:0110001,SD_RD_W:0011010,ACS_RD_8_2:0100111,SUSP3:0001111,ACTIVATE:0010101,ACS_RD2A:0101100,SCS_RD1:0110010,ACS_RD_8_5:0101010,SD_WR:0010111,SD_RD_LOOP:0011011,ACS_RD_8_3:0101000,ACS_WR4:0100011,LMR1:0001011,ACS_RD_8_1:0100110,SD_RD:0011001,ACS_WR1:0100000,BT_W:0011110,ACS_WR2:0100001,REFR:0010011,SRAM_RD1:0111010,INIT:0000101" *) 
  FDCE \u5/FSM_sequential_state_reg[0] 
       (.C(clk_i),
        .CE(\FSM_sequential_state[6]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\FSM_sequential_state[0]_i_1_n_0 ),
        .Q(\u5/state [0]));
  (* FSM_ENCODED_STATES = "ACTIVATE_W:0010110,ACS_RD2:0101101,SUSP4:0010000,SCS_RD2:0110011,ACS_WR3:0100010,LMR0:0001010,SCS_ERR:0110100,BG0:0111110,IDLE:0000001,RESUME2:0010010,SCS_WR1:0110000,POR:0000000,BG1:0111111,INIT_REFR1_W:0001000,SRAM_RD4:0111101,IDLE_T:1000001,ACS_RD_8_6:0101011,SD_WR_W:0011000,SRAM_RD2:0111011,INIT_W:0000110,BG2:1000000,IDLE_T2:0110101,SRAM_WR:0110110,INIT_LMR:0001001,ACS_RD_8_4:0101001,SD_RD_W2:0011101,ACS_RD3:0101110,RESUME1:0010001,SD_RD_WR:0010100,SCS_WR:0101111,ACS_WR:0011111,BT:0011100,SRAM_RD0:0111001,INIT0:0000100,INIT_REFR1:0000111,SRAM_RD3:0111100,LMR2:0001100,SRAM_RD:0111000,ACS_RD:0100100,PRECHARGE:0000010,SUSP1:0001101,SRAM_WR0:0110111,PRECHARGE_W:0000011,ACS_RD1:0100101,SUSP2:0001110,SCS_RD:0110001,SD_RD_W:0011010,ACS_RD_8_2:0100111,SUSP3:0001111,ACTIVATE:0010101,ACS_RD2A:0101100,SCS_RD1:0110010,ACS_RD_8_5:0101010,SD_WR:0010111,SD_RD_LOOP:0011011,ACS_RD_8_3:0101000,ACS_WR4:0100011,LMR1:0001011,ACS_RD_8_1:0100110,SD_RD:0011001,ACS_WR1:0100000,BT_W:0011110,ACS_WR2:0100001,REFR:0010011,SRAM_RD1:0111010,INIT:0000101" *) 
  FDCE \u5/FSM_sequential_state_reg[1] 
       (.C(clk_i),
        .CE(\FSM_sequential_state[6]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\FSM_sequential_state[1]_i_1_n_0 ),
        .Q(\u5/state [1]));
  (* FSM_ENCODED_STATES = "ACTIVATE_W:0010110,ACS_RD2:0101101,SUSP4:0010000,SCS_RD2:0110011,ACS_WR3:0100010,LMR0:0001010,SCS_ERR:0110100,BG0:0111110,IDLE:0000001,RESUME2:0010010,SCS_WR1:0110000,POR:0000000,BG1:0111111,INIT_REFR1_W:0001000,SRAM_RD4:0111101,IDLE_T:1000001,ACS_RD_8_6:0101011,SD_WR_W:0011000,SRAM_RD2:0111011,INIT_W:0000110,BG2:1000000,IDLE_T2:0110101,SRAM_WR:0110110,INIT_LMR:0001001,ACS_RD_8_4:0101001,SD_RD_W2:0011101,ACS_RD3:0101110,RESUME1:0010001,SD_RD_WR:0010100,SCS_WR:0101111,ACS_WR:0011111,BT:0011100,SRAM_RD0:0111001,INIT0:0000100,INIT_REFR1:0000111,SRAM_RD3:0111100,LMR2:0001100,SRAM_RD:0111000,ACS_RD:0100100,PRECHARGE:0000010,SUSP1:0001101,SRAM_WR0:0110111,PRECHARGE_W:0000011,ACS_RD1:0100101,SUSP2:0001110,SCS_RD:0110001,SD_RD_W:0011010,ACS_RD_8_2:0100111,SUSP3:0001111,ACTIVATE:0010101,ACS_RD2A:0101100,SCS_RD1:0110010,ACS_RD_8_5:0101010,SD_WR:0010111,SD_RD_LOOP:0011011,ACS_RD_8_3:0101000,ACS_WR4:0100011,LMR1:0001011,ACS_RD_8_1:0100110,SD_RD:0011001,ACS_WR1:0100000,BT_W:0011110,ACS_WR2:0100001,REFR:0010011,SRAM_RD1:0111010,INIT:0000101" *) 
  FDCE \u5/FSM_sequential_state_reg[2] 
       (.C(clk_i),
        .CE(\FSM_sequential_state[6]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\FSM_sequential_state[2]_i_1_n_0 ),
        .Q(\u5/state [2]));
  (* FSM_ENCODED_STATES = "ACTIVATE_W:0010110,ACS_RD2:0101101,SUSP4:0010000,SCS_RD2:0110011,ACS_WR3:0100010,LMR0:0001010,SCS_ERR:0110100,BG0:0111110,IDLE:0000001,RESUME2:0010010,SCS_WR1:0110000,POR:0000000,BG1:0111111,INIT_REFR1_W:0001000,SRAM_RD4:0111101,IDLE_T:1000001,ACS_RD_8_6:0101011,SD_WR_W:0011000,SRAM_RD2:0111011,INIT_W:0000110,BG2:1000000,IDLE_T2:0110101,SRAM_WR:0110110,INIT_LMR:0001001,ACS_RD_8_4:0101001,SD_RD_W2:0011101,ACS_RD3:0101110,RESUME1:0010001,SD_RD_WR:0010100,SCS_WR:0101111,ACS_WR:0011111,BT:0011100,SRAM_RD0:0111001,INIT0:0000100,INIT_REFR1:0000111,SRAM_RD3:0111100,LMR2:0001100,SRAM_RD:0111000,ACS_RD:0100100,PRECHARGE:0000010,SUSP1:0001101,SRAM_WR0:0110111,PRECHARGE_W:0000011,ACS_RD1:0100101,SUSP2:0001110,SCS_RD:0110001,SD_RD_W:0011010,ACS_RD_8_2:0100111,SUSP3:0001111,ACTIVATE:0010101,ACS_RD2A:0101100,SCS_RD1:0110010,ACS_RD_8_5:0101010,SD_WR:0010111,SD_RD_LOOP:0011011,ACS_RD_8_3:0101000,ACS_WR4:0100011,LMR1:0001011,ACS_RD_8_1:0100110,SD_RD:0011001,ACS_WR1:0100000,BT_W:0011110,ACS_WR2:0100001,REFR:0010011,SRAM_RD1:0111010,INIT:0000101" *) 
  FDCE \u5/FSM_sequential_state_reg[3] 
       (.C(clk_i),
        .CE(\FSM_sequential_state[6]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\FSM_sequential_state[3]_i_1_n_0 ),
        .Q(\u5/state [3]));
  (* FSM_ENCODED_STATES = "ACTIVATE_W:0010110,ACS_RD2:0101101,SUSP4:0010000,SCS_RD2:0110011,ACS_WR3:0100010,LMR0:0001010,SCS_ERR:0110100,BG0:0111110,IDLE:0000001,RESUME2:0010010,SCS_WR1:0110000,POR:0000000,BG1:0111111,INIT_REFR1_W:0001000,SRAM_RD4:0111101,IDLE_T:1000001,ACS_RD_8_6:0101011,SD_WR_W:0011000,SRAM_RD2:0111011,INIT_W:0000110,BG2:1000000,IDLE_T2:0110101,SRAM_WR:0110110,INIT_LMR:0001001,ACS_RD_8_4:0101001,SD_RD_W2:0011101,ACS_RD3:0101110,RESUME1:0010001,SD_RD_WR:0010100,SCS_WR:0101111,ACS_WR:0011111,BT:0011100,SRAM_RD0:0111001,INIT0:0000100,INIT_REFR1:0000111,SRAM_RD3:0111100,LMR2:0001100,SRAM_RD:0111000,ACS_RD:0100100,PRECHARGE:0000010,SUSP1:0001101,SRAM_WR0:0110111,PRECHARGE_W:0000011,ACS_RD1:0100101,SUSP2:0001110,SCS_RD:0110001,SD_RD_W:0011010,ACS_RD_8_2:0100111,SUSP3:0001111,ACTIVATE:0010101,ACS_RD2A:0101100,SCS_RD1:0110010,ACS_RD_8_5:0101010,SD_WR:0010111,SD_RD_LOOP:0011011,ACS_RD_8_3:0101000,ACS_WR4:0100011,LMR1:0001011,ACS_RD_8_1:0100110,SD_RD:0011001,ACS_WR1:0100000,BT_W:0011110,ACS_WR2:0100001,REFR:0010011,SRAM_RD1:0111010,INIT:0000101" *) 
  FDCE \u5/FSM_sequential_state_reg[4] 
       (.C(clk_i),
        .CE(\FSM_sequential_state[6]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\FSM_sequential_state[4]_i_1_n_0 ),
        .Q(\u5/state [4]));
  (* FSM_ENCODED_STATES = "ACTIVATE_W:0010110,ACS_RD2:0101101,SUSP4:0010000,SCS_RD2:0110011,ACS_WR3:0100010,LMR0:0001010,SCS_ERR:0110100,BG0:0111110,IDLE:0000001,RESUME2:0010010,SCS_WR1:0110000,POR:0000000,BG1:0111111,INIT_REFR1_W:0001000,SRAM_RD4:0111101,IDLE_T:1000001,ACS_RD_8_6:0101011,SD_WR_W:0011000,SRAM_RD2:0111011,INIT_W:0000110,BG2:1000000,IDLE_T2:0110101,SRAM_WR:0110110,INIT_LMR:0001001,ACS_RD_8_4:0101001,SD_RD_W2:0011101,ACS_RD3:0101110,RESUME1:0010001,SD_RD_WR:0010100,SCS_WR:0101111,ACS_WR:0011111,BT:0011100,SRAM_RD0:0111001,INIT0:0000100,INIT_REFR1:0000111,SRAM_RD3:0111100,LMR2:0001100,SRAM_RD:0111000,ACS_RD:0100100,PRECHARGE:0000010,SUSP1:0001101,SRAM_WR0:0110111,PRECHARGE_W:0000011,ACS_RD1:0100101,SUSP2:0001110,SCS_RD:0110001,SD_RD_W:0011010,ACS_RD_8_2:0100111,SUSP3:0001111,ACTIVATE:0010101,ACS_RD2A:0101100,SCS_RD1:0110010,ACS_RD_8_5:0101010,SD_WR:0010111,SD_RD_LOOP:0011011,ACS_RD_8_3:0101000,ACS_WR4:0100011,LMR1:0001011,ACS_RD_8_1:0100110,SD_RD:0011001,ACS_WR1:0100000,BT_W:0011110,ACS_WR2:0100001,REFR:0010011,SRAM_RD1:0111010,INIT:0000101" *) 
  FDCE \u5/FSM_sequential_state_reg[5] 
       (.C(clk_i),
        .CE(\FSM_sequential_state[6]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\FSM_sequential_state[5]_i_1_n_0 ),
        .Q(\u5/state [5]));
  (* FSM_ENCODED_STATES = "ACTIVATE_W:0010110,ACS_RD2:0101101,SUSP4:0010000,SCS_RD2:0110011,ACS_WR3:0100010,LMR0:0001010,SCS_ERR:0110100,BG0:0111110,IDLE:0000001,RESUME2:0010010,SCS_WR1:0110000,POR:0000000,BG1:0111111,INIT_REFR1_W:0001000,SRAM_RD4:0111101,IDLE_T:1000001,ACS_RD_8_6:0101011,SD_WR_W:0011000,SRAM_RD2:0111011,INIT_W:0000110,BG2:1000000,IDLE_T2:0110101,SRAM_WR:0110110,INIT_LMR:0001001,ACS_RD_8_4:0101001,SD_RD_W2:0011101,ACS_RD3:0101110,RESUME1:0010001,SD_RD_WR:0010100,SCS_WR:0101111,ACS_WR:0011111,BT:0011100,SRAM_RD0:0111001,INIT0:0000100,INIT_REFR1:0000111,SRAM_RD3:0111100,LMR2:0001100,SRAM_RD:0111000,ACS_RD:0100100,PRECHARGE:0000010,SUSP1:0001101,SRAM_WR0:0110111,PRECHARGE_W:0000011,ACS_RD1:0100101,SUSP2:0001110,SCS_RD:0110001,SD_RD_W:0011010,ACS_RD_8_2:0100111,SUSP3:0001111,ACTIVATE:0010101,ACS_RD2A:0101100,SCS_RD1:0110010,ACS_RD_8_5:0101010,SD_WR:0010111,SD_RD_LOOP:0011011,ACS_RD_8_3:0101000,ACS_WR4:0100011,LMR1:0001011,ACS_RD_8_1:0100110,SD_RD:0011001,ACS_WR1:0100000,BT_W:0011110,ACS_WR2:0100001,REFR:0010011,SRAM_RD1:0111010,INIT:0000101" *) 
  FDCE \u5/FSM_sequential_state_reg[6] 
       (.C(clk_i),
        .CE(\FSM_sequential_state[6]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\FSM_sequential_state[6]_i_2_n_0 ),
        .Q(\u5/state [6]));
  FDCE \u5/ack_cnt_reg[0] 
       (.C(clk_i),
        .CE(\ack_cnt[3]_i_1_n_0 ),
        .CLR(rst_i),
        .D(p_0_in__0[0]),
        .Q(\u5/ack_cnt_reg [0]));
  FDCE \u5/ack_cnt_reg[1] 
       (.C(clk_i),
        .CE(\ack_cnt[3]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\ack_cnt[1]_i_1_n_0 ),
        .Q(\u5/ack_cnt_reg [1]));
  FDCE \u5/ack_cnt_reg[2] 
       (.C(clk_i),
        .CE(\ack_cnt[3]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\ack_cnt[2]_i_1_n_0 ),
        .Q(\u5/ack_cnt_reg [2]));
  FDCE \u5/ack_cnt_reg[3] 
       (.C(clk_i),
        .CE(\ack_cnt[3]_i_1_n_0 ),
        .CLR(rst_i),
        .D(p_0_in__0[3]),
        .Q(\u5/ack_cnt_reg [3]));
  FDCE \u5/ap_en_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(ap_en_i_1_n_0),
        .Q(\u5/ap_en ));
  FDRE \u5/burst_act_rd_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/burst_act077_in ),
        .Q(\u5/burst_act_rd ),
        .R(\<const0> ));
  FDRE \u5/burst_cnt_reg[0] 
       (.C(clk_i),
        .CE(\burst_cnt[10]_i_2_n_0 ),
        .D(p_0_in[0]),
        .Q(\u5/burst_cnt_reg [0]),
        .R(\u5/burst_cnt_ld_4 ));
  FDRE \u5/burst_cnt_reg[10] 
       (.C(clk_i),
        .CE(\burst_cnt[10]_i_2_n_0 ),
        .D(p_0_in[10]),
        .Q(\u5/burst_cnt_reg [10]),
        .R(\u5/burst_cnt_ld_4 ));
  FDRE \u5/burst_cnt_reg[1] 
       (.C(clk_i),
        .CE(\burst_cnt[10]_i_2_n_0 ),
        .D(p_0_in[1]),
        .Q(\u5/burst_cnt_reg [1]),
        .R(\u5/burst_cnt_ld_4 ));
  FDSE \u5/burst_cnt_reg[2] 
       (.C(clk_i),
        .CE(\burst_cnt[10]_i_2_n_0 ),
        .D(p_0_in[2]),
        .Q(\u5/burst_cnt_reg [2]),
        .S(\u5/burst_cnt_ld_4 ));
  FDRE \u5/burst_cnt_reg[3] 
       (.C(clk_i),
        .CE(\burst_cnt[10]_i_2_n_0 ),
        .D(p_0_in[3]),
        .Q(\u5/burst_cnt_reg [3]),
        .R(\u5/burst_cnt_ld_4 ));
  FDRE \u5/burst_cnt_reg[4] 
       (.C(clk_i),
        .CE(\burst_cnt[10]_i_2_n_0 ),
        .D(p_0_in[4]),
        .Q(\u5/burst_cnt_reg [4]),
        .R(\u5/burst_cnt_ld_4 ));
  FDRE \u5/burst_cnt_reg[5] 
       (.C(clk_i),
        .CE(\burst_cnt[10]_i_2_n_0 ),
        .D(p_0_in[5]),
        .Q(\u5/burst_cnt_reg [5]),
        .R(\u5/burst_cnt_ld_4 ));
  FDRE \u5/burst_cnt_reg[6] 
       (.C(clk_i),
        .CE(\burst_cnt[10]_i_2_n_0 ),
        .D(p_0_in[6]),
        .Q(\u5/burst_cnt_reg [6]),
        .R(\u5/burst_cnt_ld_4 ));
  FDRE \u5/burst_cnt_reg[7] 
       (.C(clk_i),
        .CE(\burst_cnt[10]_i_2_n_0 ),
        .D(p_0_in[7]),
        .Q(\u5/burst_cnt_reg [7]),
        .R(\u5/burst_cnt_ld_4 ));
  FDRE \u5/burst_cnt_reg[8] 
       (.C(clk_i),
        .CE(\burst_cnt[10]_i_2_n_0 ),
        .D(p_0_in[8]),
        .Q(\u5/burst_cnt_reg [8]),
        .R(\u5/burst_cnt_ld_4 ));
  FDRE \u5/burst_cnt_reg[9] 
       (.C(clk_i),
        .CE(\burst_cnt[10]_i_2_n_0 ),
        .D(p_0_in[9]),
        .Q(\u5/burst_cnt_reg [9]),
        .R(\u5/burst_cnt_ld_4 ));
  FDRE \u5/cke__reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/cke_0 ),
        .Q(mc_cke_pad_o_),
        .R(\<const0> ));
  FDRE \u5/cke_o_del_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/cke_o_r2_reg_srl2_n_0 ),
        .Q(\u5/cke_o_del ),
        .R(\<const0> ));
  (* srl_name = "\u5/cke_o_r2_reg_srl2 " *) 
  SRL16E \u5/cke_o_r2_reg_srl2 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(\<const1> ),
        .CLK(clk_i),
        .D(mc_cke_pad_o_),
        .Q(\u5/cke_o_r2_reg_srl2_n_0 ));
  FDRE \u5/cke_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(cke_r_i_1_n_0),
        .Q(\u5/cke_r ),
        .R(\<const0> ));
  FDRE \u5/cmd_a10_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(cmd_a10),
        .Q(\u5/cmd_a10_r ),
        .R(\<const0> ));
  FDCE \u5/cmd_asserted2_reg 
       (.C(clk_i),
        .CE(mc_le_i_1_n_0),
        .CLR(rst_i),
        .D(\u5/cmd_asserted ),
        .Q(\u5/cmd_asserted2 ));
  FDCE \u5/cmd_asserted_reg 
       (.C(clk_i),
        .CE(mc_le_i_1_n_0),
        .CLR(rst_i),
        .D(cmd_asserted_i_1_n_0),
        .Q(\u5/cmd_asserted ));
  FDPE \u5/cmd_del_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/cmd_r [0]),
        .PRE(rst_i),
        .Q(\u5/cmd_del [0]));
  FDPE \u5/cmd_del_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/cmd_r [1]),
        .PRE(rst_i),
        .Q(\u5/cmd_del [1]));
  FDPE \u5/cmd_del_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/cmd_r [2]),
        .PRE(rst_i),
        .Q(\u5/cmd_del [2]));
  FDCE \u5/cmd_del_reg[3] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u5/cmd_r [3]),
        .Q(\u5/cmd_del [3]));
  FDPE \u5/cmd_r_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/cmd [0]),
        .PRE(rst_i),
        .Q(\u5/cmd_r [0]));
  FDPE \u5/cmd_r_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/cmd [1]),
        .PRE(rst_i),
        .Q(\u5/cmd_r [1]));
  FDPE \u5/cmd_r_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/cmd [2]),
        .PRE(rst_i),
        .Q(\u5/cmd_r [2]));
  FDCE \u5/cmd_r_reg[3] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(cmd_asserted_i_1_n_0),
        .Q(\u5/cmd_r [3]));
  FDRE \u5/cnt_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/cnt_next ),
        .Q(\u5/cnt ),
        .R(\<const0> ));
  FDRE \u5/cs_le_r1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(cs_le),
        .Q(\u5/cs_le_r1 ),
        .R(\<const0> ));
  FDRE \u5/cs_le_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/cs_le_r1 ),
        .Q(\u5/cs_le_r ),
        .R(\<const0> ));
  FDRE \u5/cs_le_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(cs_le_d),
        .Q(cs_le),
        .R(\<const0> ));
  FDCE \u5/data_oe_r2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u5/data_oe_r ),
        .Q(\u5/data_oe_r2 ));
  FDCE \u5/data_oe_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(data_oe_r_i_1_n_0),
        .Q(\u5/data_oe_r ));
  FDCE \u5/data_oe_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(data_oe_i_1_n_0),
        .Q(data_oe));
  FDCE \u5/dv_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(dv),
        .Q(\u5/dv_r ));
  FDRE \u5/ir_cnt_done_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(ir_cnt_done_i_1_n_0),
        .Q(\u5/ir_cnt_done ),
        .R(\<const0> ));
  FDRE \u5/ir_cnt_reg[0] 
       (.C(clk_i),
        .CE(\u5/ir_cnt_dec ),
        .D(ir_cnt0[0]),
        .Q(\u5/ir_cnt_reg [0]),
        .R(\u5/ir_cnt_ld ));
  FDSE \u5/ir_cnt_reg[1] 
       (.C(clk_i),
        .CE(\u5/ir_cnt_dec ),
        .D(\ir_cnt[1]_i_1_n_0 ),
        .Q(\u5/ir_cnt_reg [1]),
        .S(\u5/ir_cnt_ld ));
  FDRE \u5/ir_cnt_reg[2] 
       (.C(clk_i),
        .CE(\u5/ir_cnt_dec ),
        .D(ir_cnt0[2]),
        .Q(\u5/ir_cnt_reg [2]),
        .R(\u5/ir_cnt_ld ));
  FDRE \u5/ir_cnt_reg[3] 
       (.C(clk_i),
        .CE(\u5/ir_cnt_dec ),
        .D(ir_cnt0[3]),
        .Q(\u5/ir_cnt_reg [3]),
        .R(\u5/ir_cnt_ld ));
  FDRE \u5/lmr_ack_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/lmr_ack_d ),
        .Q(lmr_ack),
        .R(\<const0> ));
  FDCE \u5/lookup_ready1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u5/lookup_ready10 ),
        .Q(\u5/lookup_ready1 ));
  FDCE \u5/lookup_ready2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u5/lookup_ready20 ),
        .Q(\u5/lookup_ready2 ));
  FDCE \u5/mc_adv_r1_reg 
       (.C(clk_i),
        .CE(mc_le_i_1_n_0),
        .CLR(rst_i),
        .D(mc_adv_d),
        .Q(\u5/mc_adv_r1 ));
  FDCE \u5/mc_adv_r_reg 
       (.C(clk_i),
        .CE(mc_le_i_1_n_0),
        .CLR(rst_i),
        .D(\u5/mc_adv_r1 ),
        .Q(\u5/mc_adv_r ));
  FDCE \u5/mc_c_oe_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u5/mc_c_oe_d ),
        .Q(mc_c_oe_d));
  FDCE \u5/mc_le_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(\u5/rsts ),
        .D(mc_le_i_1_n_0),
        .Q(\u5/mc_le ));
  FDCE \u5/mem_ack_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(mem_ack),
        .Q(\u5/mem_ack_r ));
  FDCE \u5/no_wb_cycle_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u5/p_65_in ),
        .Q(\u5/no_wb_cycle ));
  FDPE \u5/oe__reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(oe__i_1_n_0),
        .PRE(rst_i),
        .Q(oe_));
  FDRE \u5/pack_le0_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/pack_le0_d ),
        .Q(pack_le0),
        .R(\<const0> ));
  FDRE \u5/pack_le1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/pack_le1_d ),
        .Q(pack_le1),
        .R(\<const0> ));
  FDRE \u5/pack_le2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/pack_le2_d ),
        .Q(pack_le2),
        .R(\<const0> ));
  FDCE \u5/resume_req_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(resume_req_i),
        .Q(\u5/resume_req_r ));
  FDCE \u5/rfr_ack_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(rfr_ack_r_i_1_n_0),
        .Q(rfr_ack));
  FDPE \u5/rsts1_reg 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(\<const0> ),
        .PRE(rst_i),
        .Q(\u5/rsts1 ));
  FDPE \u5/rsts_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/rsts1 ),
        .PRE(rst_i),
        .Q(\u5/rsts ));
  FDCE \u5/susp_req_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(susp_req_i),
        .Q(\u5/susp_req_r ));
  FDCE \u5/susp_sel_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(susp_sel_r_i_1_n_0),
        .Q(susp_sel));
  FDCE \u5/suspended_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u5/suspended_d ),
        .Q(suspended_o));
  FDRE \u5/timer2_reg[0] 
       (.C(clk_i),
        .CE(\u5/timer20 ),
        .D(\timer2[0]_i_1_n_0 ),
        .Q(\u5/timer2 [0]),
        .R(\<const0> ));
  FDRE \u5/timer2_reg[1] 
       (.C(clk_i),
        .CE(\u5/timer20 ),
        .D(\timer2[1]_i_1_n_0 ),
        .Q(\u5/timer2 [1]),
        .R(\<const0> ));
  FDRE \u5/timer2_reg[2] 
       (.C(clk_i),
        .CE(\u5/timer20 ),
        .D(\timer2[2]_i_1_n_0 ),
        .Q(\u5/timer2 [2]),
        .R(\<const0> ));
  FDRE \u5/timer2_reg[3] 
       (.C(clk_i),
        .CE(\u5/timer20 ),
        .D(\timer2[3]_i_1_n_0 ),
        .Q(\u5/timer2 [3]),
        .R(\<const0> ));
  FDRE \u5/timer2_reg[4] 
       (.C(clk_i),
        .CE(\u5/timer20 ),
        .D(\timer2[4]_i_1_n_0 ),
        .Q(\u5/timer2 [4]),
        .R(\<const0> ));
  FDRE \u5/timer2_reg[5] 
       (.C(clk_i),
        .CE(\u5/timer20 ),
        .D(\timer2[5]_i_1_n_0 ),
        .Q(\u5/timer2 [5]),
        .R(\<const0> ));
  FDRE \u5/timer2_reg[6] 
       (.C(clk_i),
        .CE(\u5/timer20 ),
        .D(\timer2[6]_i_1_n_0 ),
        .Q(\u5/timer2 [6]),
        .R(\<const0> ));
  FDRE \u5/timer2_reg[7] 
       (.C(clk_i),
        .CE(\u5/timer20 ),
        .D(\timer2[7]_i_1_n_0 ),
        .Q(\u5/timer2 [7]),
        .R(\<const0> ));
  FDRE \u5/timer2_reg[8] 
       (.C(clk_i),
        .CE(\u5/timer20 ),
        .D(\timer2[8]_i_2_n_0 ),
        .Q(\u5/timer2 [8]),
        .R(\<const0> ));
  FDCE \u5/timer_reg[0] 
       (.C(clk_i),
        .CE(\timer[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\timer[0]_i_1_n_0 ),
        .Q(\u5/timer [0]));
  FDPE \u5/timer_reg[1] 
       (.C(clk_i),
        .CE(\timer[7]_i_1_n_0 ),
        .D(\timer[1]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u5/timer [1]));
  FDCE \u5/timer_reg[2] 
       (.C(clk_i),
        .CE(\timer[7]_i_1_n_0 ),
        .CLR(rst_i),
        .D(\timer[2]_i_1_n_0 ),
        .Q(\u5/timer [2]));
  FDPE \u5/timer_reg[3] 
       (.C(clk_i),
        .CE(\timer[7]_i_1_n_0 ),
        .D(\timer[3]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u5/timer [3]));
  FDPE \u5/timer_reg[4] 
       (.C(clk_i),
        .CE(\timer[7]_i_1_n_0 ),
        .D(\timer[4]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u5/timer [4]));
  FDPE \u5/timer_reg[5] 
       (.C(clk_i),
        .CE(\timer[7]_i_1_n_0 ),
        .D(\timer[5]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u5/timer [5]));
  FDPE \u5/timer_reg[6] 
       (.C(clk_i),
        .CE(\timer[7]_i_1_n_0 ),
        .D(\timer[6]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\u5/timer [6]));
  FDPE \u5/timer_reg[7] 
       (.C(clk_i),
        .CE(\timer[7]_i_1_n_0 ),
        .D(\timer[7]_i_2_n_0 ),
        .PRE(rst_i),
        .Q(\u5/timer [7]));
  FDCE \u5/tmr2_done_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u5/tmr2_done0 ),
        .Q(\u5/tmr2_done ));
  FDCE \u5/tmr_done_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u5/timer_is_zero ),
        .Q(\u5/tmr_done ));
  FDCE \u5/wb_cycle_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(wb_cycle_i_1_n_0),
        .Q(wb_cycle));
  FDCE \u5/wb_stb_first_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(wb_stb_first_i_1_n_0),
        .Q(\u5/wb_stb_first_reg_n_0 ));
  FDRE \u5/wb_wait_r2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_wait),
        .Q(\u5/wb_wait_r2 ),
        .R(\<const0> ));
  FDRE \u5/wb_wait_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/wb_wait_r2 ),
        .Q(\u5/wb_wait_r ),
        .R(\<const0> ));
  FDRE \u5/wb_write_go_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_write_go),
        .Q(\u5/wb_write_go_r ),
        .R(\<const0> ));
  FDCE \u5/wr_cycle_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(wr_cycle_i_1_n_0),
        .Q(wr_cycle));
  FDCE \u6/read_go_r1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u6/read_go_r10 ),
        .Q(\u6/read_go_r1 ));
  FDCE \u6/read_go_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u6/read_go_r0 ),
        .Q(\u6/read_go_r ));
  FDCE \u6/rmw_en_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(rmw_en_i_1_n_0),
        .Q(\u6/rmw_en ));
  FDCE \u6/rmw_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u6/rmw_r0 ),
        .Q(\u6/rmw_r ));
  FDCE \u6/wb_ack_o_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(wb_ack_o_i_1_n_0),
        .Q(wb_ack_o));
  FDRE \u6/wb_data_o_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[0]_i_1_n_0 ),
        .Q(wb_data_o[0]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[10] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[10]_i_1_n_0 ),
        .Q(wb_data_o[10]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[11] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[11]_i_1_n_0 ),
        .Q(wb_data_o[11]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[12] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[12]_i_1_n_0 ),
        .Q(wb_data_o[12]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[13] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[13]_i_1_n_0 ),
        .Q(wb_data_o[13]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[14] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[14]_i_1_n_0 ),
        .Q(wb_data_o[14]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[15] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[15]_i_1_n_0 ),
        .Q(wb_data_o[15]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[16] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[16]_i_1_n_0 ),
        .Q(wb_data_o[16]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[17] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[17]_i_1_n_0 ),
        .Q(wb_data_o[17]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[18] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[18]_i_1_n_0 ),
        .Q(wb_data_o[18]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[19] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[19]_i_1_n_0 ),
        .Q(wb_data_o[19]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[1]_i_1_n_0 ),
        .Q(wb_data_o[1]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[20] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[20]_i_1_n_0 ),
        .Q(wb_data_o[20]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[21] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[21]_i_1_n_0 ),
        .Q(wb_data_o[21]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[22] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[22]_i_1_n_0 ),
        .Q(wb_data_o[22]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[23] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[23]_i_1_n_0 ),
        .Q(wb_data_o[23]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[24] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[24]_i_1_n_0 ),
        .Q(wb_data_o[24]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[25] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[25]_i_1_n_0 ),
        .Q(wb_data_o[25]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[26] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[26]_i_1_n_0 ),
        .Q(wb_data_o[26]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[27] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[27]_i_1_n_0 ),
        .Q(wb_data_o[27]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[28] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[28]_i_1_n_0 ),
        .Q(wb_data_o[28]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[29] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[29]_i_1_n_0 ),
        .Q(wb_data_o[29]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[2]_i_1_n_0 ),
        .Q(wb_data_o[2]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[30] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[30]_i_1_n_0 ),
        .Q(wb_data_o[30]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[31] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[31]_i_1_n_0 ),
        .Q(wb_data_o[31]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[3] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[3]_i_1_n_0 ),
        .Q(wb_data_o[3]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[4] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[4]_i_1_n_0 ),
        .Q(wb_data_o[4]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[5] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[5]_i_1_n_0 ),
        .Q(wb_data_o[5]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[6] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[6]_i_1_n_0 ),
        .Q(wb_data_o[6]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[7] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[7]_i_1_n_0 ),
        .Q(wb_data_o[7]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[8] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[8]_i_1_n_0 ),
        .Q(wb_data_o[8]),
        .R(\<const0> ));
  FDRE \u6/wb_data_o_reg[9] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[9]_i_1_n_0 ),
        .Q(wb_data_o[9]),
        .R(\<const0> ));
  FDCE \u6/wb_err_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u6/wb_err0 ),
        .Q(wb_err_o));
  FDCE \u6/wb_first_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(wb_first_r_i_1_n_0),
        .Q(\u6/wb_first_r ));
  FDCE \u6/wr_hold_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(wr_hold_i_1_n_0),
        .Q(wr_hold));
  FDCE \u6/write_go_r1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u6/write_go_r10 ),
        .Q(\u6/write_go_r1 ));
  FDCE \u6/write_go_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u6/write_go_r0 ),
        .Q(\u6/write_go_r ));
  FDRE \u7/mc_ack_r_reg 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_ack_pad_i),
        .Q(mc_ack_r),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[0] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[0]),
        .Q(mc_addr_pad_o[0]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[10] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[10]),
        .Q(mc_addr_pad_o[10]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[11] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[11]),
        .Q(mc_addr_pad_o[11]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[12] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[12]),
        .Q(mc_addr_pad_o[12]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[13] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[13]),
        .Q(mc_addr_pad_o[13]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[14] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[14]),
        .Q(mc_addr_pad_o[14]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[15] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[15]),
        .Q(mc_addr_pad_o[15]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[16] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[16]),
        .Q(mc_addr_pad_o[16]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[17] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[17]),
        .Q(mc_addr_pad_o[17]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[18] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[18]),
        .Q(mc_addr_pad_o[18]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[19] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[19]),
        .Q(mc_addr_pad_o[19]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[1] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[1]),
        .Q(mc_addr_pad_o[1]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[20] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[20]),
        .Q(mc_addr_pad_o[20]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[21] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[21]),
        .Q(mc_addr_pad_o[21]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[22] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[22]),
        .Q(mc_addr_pad_o[22]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[23] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[23]),
        .Q(mc_addr_pad_o[23]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[2] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[2]),
        .Q(mc_addr_pad_o[2]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[3] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[3]),
        .Q(mc_addr_pad_o[3]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[4] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[4]),
        .Q(mc_addr_pad_o[4]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[5] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[5]),
        .Q(mc_addr_pad_o[5]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[6] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[6]),
        .Q(mc_addr_pad_o[6]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[7] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[7]),
        .Q(mc_addr_pad_o[7]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[8] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[8]),
        .Q(mc_addr_pad_o[8]),
        .R(\<const0> ));
  FDRE \u7/mc_addr_reg[9] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_addr_d[9]),
        .Q(mc_addr_pad_o[9]),
        .R(\<const0> ));
  FDRE \u7/mc_adsc__reg 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_adsc__i_1_n_0),
        .Q(mc_adsc_pad_o_),
        .R(\<const0> ));
  FDRE \u7/mc_adv__reg 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_adv__i_1_n_0),
        .Q(mc_adv_pad_o_),
        .R(\<const0> ));
  FDRE \u7/mc_bg_reg 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_bg_d),
        .Q(mc_bg_pad_o),
        .R(\<const0> ));
  FDRE \u7/mc_br_r_reg 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_br_pad_i),
        .Q(mc_br_r),
        .R(\<const0> ));
  FDRE \u7/mc_c_oe_reg 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_c_oe_d),
        .Q(mc_coe_pad_coe_o),
        .R(\<const0> ));
  FDRE \u7/mc_cas__reg 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(cas_),
        .Q(mc_cas_pad_o_),
        .R(\<const0> ));
  FDPE \u7/mc_cs__reg[0] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(\mc_cs_[0]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\^mc_cs_pad_o_ [0]));
  FDPE \u7/mc_cs__reg[1] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(\mc_cs_[1]_i_1_n_0 ),
        .PRE(rst_i),
        .Q(\^mc_cs_pad_o_ [1]));
  FDRE \u7/mc_data_ir_reg[0] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[0]),
        .Q(mc_data_ir[0]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[10] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[10]),
        .Q(mc_data_ir[10]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[11] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[11]),
        .Q(mc_data_ir[11]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[12] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[12]),
        .Q(mc_data_ir[12]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[13] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[13]),
        .Q(mc_data_ir[13]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[14] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[14]),
        .Q(mc_data_ir[14]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[15] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[15]),
        .Q(mc_data_ir[15]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[16] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[16]),
        .Q(mc_data_ir[16]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[17] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[17]),
        .Q(mc_data_ir[17]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[18] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[18]),
        .Q(mc_data_ir[18]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[19] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[19]),
        .Q(mc_data_ir[19]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[1] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[1]),
        .Q(mc_data_ir[1]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[20] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[20]),
        .Q(mc_data_ir[20]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[21] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[21]),
        .Q(mc_data_ir[21]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[22] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[22]),
        .Q(mc_data_ir[22]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[23] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[23]),
        .Q(mc_data_ir[23]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[24] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[24]),
        .Q(mc_data_ir[24]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[25] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[25]),
        .Q(mc_data_ir[25]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[26] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[26]),
        .Q(mc_data_ir[26]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[27] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[27]),
        .Q(mc_data_ir[27]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[28] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[28]),
        .Q(mc_data_ir[28]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[29] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[29]),
        .Q(mc_data_ir[29]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[2] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[2]),
        .Q(mc_data_ir[2]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[30] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[30]),
        .Q(mc_data_ir[30]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[31] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[31]),
        .Q(mc_data_ir[31]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[32] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_dp_pad_i[0]),
        .Q(mc_data_ir[32]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[33] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_dp_pad_i[1]),
        .Q(mc_data_ir[33]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[34] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_dp_pad_i[2]),
        .Q(mc_data_ir[34]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[35] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_dp_pad_i[3]),
        .Q(mc_data_ir[35]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[3] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[3]),
        .Q(mc_data_ir[3]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[4] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[4]),
        .Q(mc_data_ir[4]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[5] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[5]),
        .Q(mc_data_ir[5]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[6] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[6]),
        .Q(mc_data_ir[6]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[7] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[7]),
        .Q(mc_data_ir[7]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[8] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[8]),
        .Q(mc_data_ir[8]),
        .R(\<const0> ));
  FDRE \u7/mc_data_ir_reg[9] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_pad_i[9]),
        .Q(mc_data_ir[9]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[0] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[0]),
        .Q(mc_data_pad_o[0]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[10] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[10]),
        .Q(mc_data_pad_o[10]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[11] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[11]),
        .Q(mc_data_pad_o[11]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[12] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[12]),
        .Q(mc_data_pad_o[12]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[13] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[13]),
        .Q(mc_data_pad_o[13]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[14] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[14]),
        .Q(mc_data_pad_o[14]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[15] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[15]),
        .Q(mc_data_pad_o[15]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[16] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[16]),
        .Q(mc_data_pad_o[16]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[17] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[17]),
        .Q(mc_data_pad_o[17]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[18] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[18]),
        .Q(mc_data_pad_o[18]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[19] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[19]),
        .Q(mc_data_pad_o[19]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[1] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[1]),
        .Q(mc_data_pad_o[1]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[20] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[20]),
        .Q(mc_data_pad_o[20]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[21] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[21]),
        .Q(mc_data_pad_o[21]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[22] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[22]),
        .Q(mc_data_pad_o[22]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[23] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[23]),
        .Q(mc_data_pad_o[23]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[24] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[24]),
        .Q(mc_data_pad_o[24]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[25] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[25]),
        .Q(mc_data_pad_o[25]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[26] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[26]),
        .Q(mc_data_pad_o[26]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[27] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[27]),
        .Q(mc_data_pad_o[27]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[28] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[28]),
        .Q(mc_data_pad_o[28]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[29] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[29]),
        .Q(mc_data_pad_o[29]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[2] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[2]),
        .Q(mc_data_pad_o[2]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[30] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[30]),
        .Q(mc_data_pad_o[30]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[31] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[31]),
        .Q(mc_data_pad_o[31]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[3] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[3]),
        .Q(mc_data_pad_o[3]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[4] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[4]),
        .Q(mc_data_pad_o[4]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[5] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[5]),
        .Q(mc_data_pad_o[5]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[6] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[6]),
        .Q(mc_data_pad_o[6]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[7] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[7]),
        .Q(mc_data_pad_o[7]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[8] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[8]),
        .Q(mc_data_pad_o[8]),
        .R(\<const0> ));
  FDRE \u7/mc_data_o_reg[9] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_data_o[9]),
        .Q(mc_data_pad_o[9]),
        .R(\<const0> ));
  FDCE \u7/mc_data_oe_reg 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .CLR(rst_i),
        .D(\u7/mc_data_oe0 ),
        .Q(mc_doe_pad_doe_o));
  FDRE \u7/mc_dp_o_reg[0] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_dp_o[0]),
        .Q(mc_dp_pad_o[0]),
        .R(\<const0> ));
  FDRE \u7/mc_dp_o_reg[1] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_dp_o[1]),
        .Q(mc_dp_pad_o[1]),
        .R(\<const0> ));
  FDRE \u7/mc_dp_o_reg[2] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_dp_o[2]),
        .Q(mc_dp_pad_o[2]),
        .R(\<const0> ));
  FDRE \u7/mc_dp_o_reg[3] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_dp_o[3]),
        .Q(mc_dp_pad_o[3]),
        .R(\<const0> ));
  FDRE \u7/mc_dqm_r2_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(mc_dqm_r[0]),
        .Q(mc_dqm_r2[0]),
        .R(\<const0> ));
  FDRE \u7/mc_dqm_r2_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(mc_dqm_r[1]),
        .Q(mc_dqm_r2[1]),
        .R(\<const0> ));
  FDRE \u7/mc_dqm_r2_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(mc_dqm_r[2]),
        .Q(mc_dqm_r2[2]),
        .R(\<const0> ));
  FDRE \u7/mc_dqm_r2_reg[3] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(mc_dqm_r[3]),
        .Q(mc_dqm_r2[3]),
        .R(\<const0> ));
  FDRE \u7/mc_dqm_r_reg[0] 
       (.C(clk_i),
        .CE(\u6/wr_hold0 ),
        .D(wb_sel_i[0]),
        .Q(mc_dqm_r[0]),
        .R(\<const0> ));
  FDRE \u7/mc_dqm_r_reg[1] 
       (.C(clk_i),
        .CE(\u6/wr_hold0 ),
        .D(wb_sel_i[1]),
        .Q(mc_dqm_r[1]),
        .R(\<const0> ));
  FDRE \u7/mc_dqm_r_reg[2] 
       (.C(clk_i),
        .CE(\u6/wr_hold0 ),
        .D(wb_sel_i[2]),
        .Q(mc_dqm_r[2]),
        .R(\<const0> ));
  FDRE \u7/mc_dqm_r_reg[3] 
       (.C(clk_i),
        .CE(\u6/wr_hold0 ),
        .D(wb_sel_i[3]),
        .Q(mc_dqm_r[3]),
        .R(\<const0> ));
  FDSE \u7/mc_dqm_reg[0] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(\mc_dqm[0]_i_1_n_0 ),
        .Q(mc_dqm_pad_o[0]),
        .S(susp_sel));
  FDSE \u7/mc_dqm_reg[1] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(\mc_dqm[1]_i_1_n_0 ),
        .Q(mc_dqm_pad_o[1]),
        .S(susp_sel));
  FDSE \u7/mc_dqm_reg[2] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(\mc_dqm[2]_i_1_n_0 ),
        .Q(mc_dqm_pad_o[2]),
        .S(susp_sel));
  FDSE \u7/mc_dqm_reg[3] 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(\mc_dqm[3]_i_1_n_0 ),
        .Q(mc_dqm_pad_o[3]),
        .S(susp_sel));
  FDPE \u7/mc_oe__reg 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(\u7/mc_oe_0 ),
        .PRE(rst_i),
        .Q(mc_oe_pad_o_));
  FDRE \u7/mc_ras__reg 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(ras_),
        .Q(mc_ras_pad_o_),
        .R(\<const0> ));
  FDRE \u7/mc_rp_reg 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(\u7/mc_rp0 ),
        .Q(mc_rp_pad_o_),
        .R(\<const0> ));
  FDRE \u7/mc_sts_ir_reg 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(mc_sts_pad_i),
        .Q(mc_sts_ir),
        .R(\<const0> ));
  FDRE \u7/mc_we__reg 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(we_),
        .Q(mc_we_pad_o_),
        .R(\<const0> ));
  FDRE \u7/mc_zz_o_reg 
       (.C(mc_clk_i),
        .CE(\<const1> ),
        .D(suspended_o),
        .Q(mc_zz_pad_o),
        .R(\<const0> ));
  LUT6 #(
    .INIT(64'hEAEAEAAAEAAAEAAA)) 
    wb_ack_o_i_1
       (.I0(wb_ack_o_i_2_n_0),
        .I1(\wb_data_o[31]_i_4_n_0 ),
        .I2(mem_ack),
        .I3(wb_ack_o_i_3_n_0),
        .I4(wb_ack_o_i_4_n_0),
        .I5(wb_ack_o_i_5_n_0),
        .O(wb_ack_o_i_1_n_0));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    wb_ack_o_i_10
       (.I0(wb_ack_o_i_15_n_0),
        .I1(wb_ack_o_i_16_n_0),
        .I2(\wb_data_o[9]_i_5_n_0 ),
        .I3(\wb_data_o[8]_i_5_n_0 ),
        .I4(\wb_data_o[11]_i_4_n_0 ),
        .I5(\wb_data_o[10]_i_7_n_0 ),
        .O(wb_ack_o_i_10_n_0));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    wb_ack_o_i_11
       (.I0(wb_ack_o_i_17_n_0),
        .I1(wb_ack_o_i_18_n_0),
        .I2(\wb_data_o[19]_i_4_n_0 ),
        .I3(\wb_data_o[18]_i_4_n_0 ),
        .I4(\wb_data_o[17]_i_4_n_0 ),
        .I5(\wb_data_o[16]_i_3_n_0 ),
        .O(wb_ack_o_i_11_n_0));
  LUT5 #(
    .INIT(32'h96696996)) 
    wb_ack_o_i_12
       (.I0(wb_ack_o_i_19_n_0),
        .I1(\wb_data_o[27]_i_3_n_0 ),
        .I2(\wb_data_o[26]_i_4_n_0 ),
        .I3(\wb_data_o[25]_i_3_n_0 ),
        .I4(\wb_data_o[24]_i_4_n_0 ),
        .O(wb_ack_o_i_12_n_0));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    wb_ack_o_i_13
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[32]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[32]),
        .I4(wb_ack_o_i_20_n_0),
        .O(wb_ack_o_i_13_n_0));
  LUT4 #(
    .INIT(16'h6996)) 
    wb_ack_o_i_14
       (.I0(\wb_data_o[3]_i_5_n_0 ),
        .I1(\wb_data_o[2]_i_5_n_0 ),
        .I2(\wb_data_o[1]_i_5_n_0 ),
        .I3(\wb_data_o[0]_i_5_n_0 ),
        .O(wb_ack_o_i_14_n_0));
  LUT5 #(
    .INIT(32'h00000777)) 
    wb_ack_o_i_15
       (.I0(\u3/u0/rd_adr [0]),
        .I1(r0[33]),
        .I2(\u3/u0/rd_adr [1]),
        .I3(r1[33]),
        .I4(wb_ack_o_i_21_n_0),
        .O(wb_ack_o_i_15_n_0));
  LUT4 #(
    .INIT(16'h6996)) 
    wb_ack_o_i_16
       (.I0(\wb_data_o[15]_i_5_n_0 ),
        .I1(\wb_data_o[14]_i_4_n_0 ),
        .I2(\wb_data_o[13]_i_4_n_0 ),
        .I3(\wb_data_o[12]_i_4_n_0 ),
        .O(wb_ack_o_i_16_n_0));
  LUT5 #(
    .INIT(32'h00000777)) 
    wb_ack_o_i_17
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[34]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[34]),
        .I4(wb_ack_o_i_22_n_0),
        .O(wb_ack_o_i_17_n_0));
  LUT4 #(
    .INIT(16'h6996)) 
    wb_ack_o_i_18
       (.I0(\wb_data_o[21]_i_4_n_0 ),
        .I1(\wb_data_o[20]_i_3_n_0 ),
        .I2(\wb_data_o[22]_i_4_n_0 ),
        .I3(\wb_data_o[23]_i_4_n_0 ),
        .O(wb_ack_o_i_18_n_0));
  LUT5 #(
    .INIT(32'h00000777)) 
    wb_ack_o_i_19
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[35]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[35]),
        .I4(wb_ack_o_i_23_n_0),
        .O(wb_ack_o_i_19_n_0));
  LUT6 #(
    .INIT(64'h0000000008000000)) 
    wb_ack_o_i_2
       (.I0(wb_cyc_i),
        .I1(wb_stb_i),
        .I2(wb_addr_i[31]),
        .I3(wb_addr_i[29]),
        .I4(wb_addr_i[30]),
        .I5(wb_ack_o),
        .O(wb_ack_o_i_2_n_0));
  LUT4 #(
    .INIT(16'hF888)) 
    wb_ack_o_i_20
       (.I0(r3[32]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[32]),
        .I3(\u3/u0/rd_adr [2]),
        .O(wb_ack_o_i_20_n_0));
  LUT4 #(
    .INIT(16'hF888)) 
    wb_ack_o_i_21
       (.I0(r2[33]),
        .I1(\u3/u0/rd_adr [2]),
        .I2(r3[33]),
        .I3(\u3/u0/rd_adr [3]),
        .O(wb_ack_o_i_21_n_0));
  LUT4 #(
    .INIT(16'hF888)) 
    wb_ack_o_i_22
       (.I0(r3[34]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[34]),
        .I3(\u3/u0/rd_adr [2]),
        .O(wb_ack_o_i_22_n_0));
  LUT4 #(
    .INIT(16'hF888)) 
    wb_ack_o_i_23
       (.I0(r3[35]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[35]),
        .I3(\u3/u0/rd_adr [2]),
        .O(wb_ack_o_i_23_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h7)) 
    wb_ack_o_i_3
       (.I0(wb_stb_i),
        .I1(wb_cyc_i),
        .O(wb_ack_o_i_3_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF4044FFFF)) 
    wb_ack_o_i_4
       (.I0(wb_ack_o_i_6_n_0),
        .I1(wb_ack_o_i_7_n_0),
        .I2(wb_ack_o_i_8_n_0),
        .I3(wb_sel_i[0]),
        .I4(csc[11]),
        .I5(wb_we_i),
        .O(wb_ack_o_i_4_n_0));
  LUT6 #(
    .INIT(64'h00000000FFFFFFFD)) 
    wb_ack_o_i_5
       (.I0(wb_ack_o_i_9_n_0),
        .I1(\u5/state [1]),
        .I2(\u5/state [6]),
        .I3(\u5/state [0]),
        .I4(\u5/state [3]),
        .I5(wp_err),
        .O(wb_ack_o_i_5_n_0));
  LUT4 #(
    .INIT(16'h4F44)) 
    wb_ack_o_i_6
       (.I0(wb_ack_o_i_10_n_0),
        .I1(wb_sel_i[1]),
        .I2(wb_ack_o_i_11_n_0),
        .I3(wb_sel_i[2]),
        .O(wb_ack_o_i_6_n_0));
  LUT6 #(
    .INIT(64'hD77D7DD77DD7D77D)) 
    wb_ack_o_i_7
       (.I0(wb_sel_i[3]),
        .I1(wb_ack_o_i_12_n_0),
        .I2(\wb_data_o[31]_i_5_n_0 ),
        .I3(\wb_data_o[30]_i_3_n_0 ),
        .I4(\wb_data_o[29]_i_4_n_0 ),
        .I5(\wb_data_o[28]_i_3_n_0 ),
        .O(wb_ack_o_i_7_n_0));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    wb_ack_o_i_8
       (.I0(wb_ack_o_i_13_n_0),
        .I1(wb_ack_o_i_14_n_0),
        .I2(\wb_data_o[7]_i_5_n_0 ),
        .I3(\wb_data_o[6]_i_5_n_0 ),
        .I4(\wb_data_o[5]_i_5_n_0 ),
        .I5(\wb_data_o[4]_i_5_n_0 ),
        .O(wb_ack_o_i_8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT3 #(
    .INIT(8'h80)) 
    wb_ack_o_i_9
       (.I0(\u5/state [5]),
        .I1(\u5/state [4]),
        .I2(\u5/state [2]),
        .O(wb_ack_o_i_9_n_0));
  LUT5 #(
    .INIT(32'hFFA2FF00)) 
    wb_cycle_i_1
       (.I0(wb_cyc_i),
        .I1(wb_stb_i),
        .I2(\wb_data_o[31]_i_4_n_0 ),
        .I3(\u5/wb_cycle_set ),
        .I4(wb_cycle),
        .O(wb_cycle_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000010110000)) 
    wb_cycle_i_2
       (.I0(\FSM_sequential_state[5]_i_9_n_0 ),
        .I1(init_req),
        .I2(wb_cycle),
        .I3(\u5/susp_req_r ),
        .I4(\u5/burst_cnt_ld ),
        .I5(\FSM_sequential_state[1]_i_12_n_0 ),
        .O(\u5/wb_cycle_set ));
  LUT5 #(
    .INIT(32'hFF100010)) 
    \wb_data_o[0]_i_1 
       (.I0(wb_addr_i[6]),
        .I1(wb_addr_i[5]),
        .I2(\wb_data_o[0]_i_2_n_0 ),
        .I3(\wb_data_o[31]_i_4_n_0 ),
        .I4(\wb_data_o[0]_i_3_n_0 ),
        .O(\wb_data_o[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[0]_i_2 
       (.I0(\u0/csr_r_reg_n_0_[0] ),
        .I1(poc_o[0]),
        .I2(\wb_data_o[10]_i_4_n_0 ),
        .I3(\u0/csc_mask [0]),
        .I4(\wb_data_o[10]_i_5_n_0 ),
        .I5(\wb_data_o[0]_i_4_n_0 ),
        .O(\wb_data_o[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \wb_data_o[0]_i_3 
       (.I0(\wb_data_o[0]_i_5_n_0 ),
        .I1(csc[3]),
        .I2(csc[2]),
        .I3(mc_data_ir[0]),
        .I4(csc[5]),
        .I5(byte0[0]),
        .O(\wb_data_o[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[0]_i_4 
       (.I0(\u0/u1/tms_reg_n_0_[0] ),
        .I1(\u0/u1/csc_reg_n_0_[0] ),
        .I2(wb_addr_i[3]),
        .I3(tms[0]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[0] ),
        .O(\wb_data_o[0]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \wb_data_o[0]_i_5 
       (.I0(\u3/u0/rd_adr [0]),
        .I1(r0[0]),
        .I2(\u3/u0/rd_adr [1]),
        .I3(r1[0]),
        .I4(\wb_data_o[0]_i_6_n_0 ),
        .O(\wb_data_o[0]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[0]_i_6 
       (.I0(r2[0]),
        .I1(\u3/u0/rd_adr [2]),
        .I2(r3[0]),
        .I3(\u3/u0/rd_adr [3]),
        .O(\wb_data_o[0]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFF100010)) 
    \wb_data_o[10]_i_1 
       (.I0(wb_addr_i[6]),
        .I1(wb_addr_i[5]),
        .I2(\wb_data_o[10]_i_2_n_0 ),
        .I3(\wb_data_o[31]_i_4_n_0 ),
        .I4(\wb_data_o[10]_i_3_n_0 ),
        .O(\wb_data_o[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[10]_i_2 
       (.I0(sel0[2]),
        .I1(poc_o[10]),
        .I2(\wb_data_o[10]_i_4_n_0 ),
        .I3(\u0/csc_mask_r_reg_n_0_[10] ),
        .I4(\wb_data_o[10]_i_5_n_0 ),
        .I5(\wb_data_o[10]_i_6_n_0 ),
        .O(\wb_data_o[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \wb_data_o[10]_i_3 
       (.I0(\wb_data_o[10]_i_7_n_0 ),
        .I1(csc[3]),
        .I2(csc[2]),
        .I3(mc_data_ir[10]),
        .I4(csc[5]),
        .I5(byte1[2]),
        .O(\wb_data_o[10]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \wb_data_o[10]_i_4 
       (.I0(wb_addr_i[3]),
        .I1(wb_addr_i[4]),
        .O(\wb_data_o[10]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'h45)) 
    \wb_data_o[10]_i_5 
       (.I0(wb_addr_i[4]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[2]),
        .O(\wb_data_o[10]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[10]_i_6 
       (.I0(\u0/u1/tms_reg_n_0_[10] ),
        .I1(\u0/u1/csc_reg_n_0_[10] ),
        .I2(wb_addr_i[3]),
        .I3(tms[10]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[10] ),
        .O(\wb_data_o[10]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \wb_data_o[10]_i_7 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[10]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[10]),
        .I4(\wb_data_o[10]_i_8_n_0 ),
        .O(\wb_data_o[10]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[10]_i_8 
       (.I0(r3[10]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[10]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[10]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF54540004)) 
    \wb_data_o[11]_i_1 
       (.I0(\wb_data_o[15]_i_3_n_0 ),
        .I1(poc_o[11]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[3]),
        .I4(\wb_data_o[11]_i_2_n_0 ),
        .I5(\wb_data_o[11]_i_3_n_0 ),
        .O(\wb_data_o[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[11]_i_2 
       (.I0(\u0/u1/tms_reg_n_0_[11] ),
        .I1(\u0/u1/csc_reg_n_0_[11] ),
        .I2(wb_addr_i[3]),
        .I3(tms[11]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[11] ),
        .O(\wb_data_o[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7774447400000000)) 
    \wb_data_o[11]_i_3 
       (.I0(\wb_data_o[11]_i_4_n_0 ),
        .I1(\wb_data_o[31]_i_6_n_0 ),
        .I2(byte1[3]),
        .I3(csc[5]),
        .I4(mc_data_ir[11]),
        .I5(\wb_data_o[31]_i_4_n_0 ),
        .O(\wb_data_o[11]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[11]_i_4 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[11]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[11]),
        .I4(\wb_data_o[11]_i_5_n_0 ),
        .O(\wb_data_o[11]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[11]_i_5 
       (.I0(r3[11]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[11]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[11]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF54540004)) 
    \wb_data_o[12]_i_1 
       (.I0(\wb_data_o[15]_i_3_n_0 ),
        .I1(poc_o[12]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[3]),
        .I4(\wb_data_o[12]_i_2_n_0 ),
        .I5(\wb_data_o[12]_i_3_n_0 ),
        .O(\wb_data_o[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[12]_i_2 
       (.I0(\u0/u1/tms_reg_n_0_[12] ),
        .I1(\u0/u1/csc_reg_n_0_[12] ),
        .I2(wb_addr_i[3]),
        .I3(tms[12]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[12] ),
        .O(\wb_data_o[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7774447400000000)) 
    \wb_data_o[12]_i_3 
       (.I0(\wb_data_o[12]_i_4_n_0 ),
        .I1(\wb_data_o[31]_i_6_n_0 ),
        .I2(byte1[4]),
        .I3(csc[5]),
        .I4(mc_data_ir[12]),
        .I5(\wb_data_o[31]_i_4_n_0 ),
        .O(\wb_data_o[12]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[12]_i_4 
       (.I0(\u3/u0/rd_adr [0]),
        .I1(r0[12]),
        .I2(\u3/u0/rd_adr [1]),
        .I3(r1[12]),
        .I4(\wb_data_o[12]_i_5_n_0 ),
        .O(\wb_data_o[12]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[12]_i_5 
       (.I0(r2[12]),
        .I1(\u3/u0/rd_adr [2]),
        .I2(r3[12]),
        .I3(\u3/u0/rd_adr [3]),
        .O(\wb_data_o[12]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hBBBABBBAAAAAAABA)) 
    \wb_data_o[13]_i_1 
       (.I0(\wb_data_o[13]_i_2_n_0 ),
        .I1(\wb_data_o[15]_i_3_n_0 ),
        .I2(poc_o[13]),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(\wb_data_o[13]_i_3_n_0 ),
        .O(\wb_data_o[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7774447400000000)) 
    \wb_data_o[13]_i_2 
       (.I0(\wb_data_o[13]_i_4_n_0 ),
        .I1(\wb_data_o[31]_i_6_n_0 ),
        .I2(byte1[5]),
        .I3(csc[5]),
        .I4(mc_data_ir[13]),
        .I5(\wb_data_o[31]_i_4_n_0 ),
        .O(\wb_data_o[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[13]_i_3 
       (.I0(\u0/u1/tms_reg_n_0_[13] ),
        .I1(\u0/u1/csc_reg_n_0_[13] ),
        .I2(wb_addr_i[3]),
        .I3(tms[13]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[13] ),
        .O(\wb_data_o[13]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[13]_i_4 
       (.I0(\u3/u0/rd_adr [0]),
        .I1(r0[13]),
        .I2(\u3/u0/rd_adr [1]),
        .I3(r1[13]),
        .I4(\wb_data_o[13]_i_5_n_0 ),
        .O(\wb_data_o[13]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[13]_i_5 
       (.I0(r2[13]),
        .I1(\u3/u0/rd_adr [2]),
        .I2(r3[13]),
        .I3(\u3/u0/rd_adr [3]),
        .O(\wb_data_o[13]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF54540004)) 
    \wb_data_o[14]_i_1 
       (.I0(\wb_data_o[15]_i_3_n_0 ),
        .I1(poc_o[14]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[3]),
        .I4(\wb_data_o[14]_i_2_n_0 ),
        .I5(\wb_data_o[14]_i_3_n_0 ),
        .O(\wb_data_o[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[14]_i_2 
       (.I0(\u0/u1/tms_reg_n_0_[14] ),
        .I1(\u0/u1/csc_reg_n_0_[14] ),
        .I2(wb_addr_i[3]),
        .I3(tms[14]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[14] ),
        .O(\wb_data_o[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7774447400000000)) 
    \wb_data_o[14]_i_3 
       (.I0(\wb_data_o[14]_i_4_n_0 ),
        .I1(\wb_data_o[31]_i_6_n_0 ),
        .I2(byte1[6]),
        .I3(csc[5]),
        .I4(mc_data_ir[14]),
        .I5(\wb_data_o[31]_i_4_n_0 ),
        .O(\wb_data_o[14]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[14]_i_4 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[14]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[14]),
        .I4(\wb_data_o[14]_i_5_n_0 ),
        .O(\wb_data_o[14]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[14]_i_5 
       (.I0(r3[14]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[14]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[14]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hBBBABBBAAAAAAABA)) 
    \wb_data_o[15]_i_1 
       (.I0(\wb_data_o[15]_i_2_n_0 ),
        .I1(\wb_data_o[15]_i_3_n_0 ),
        .I2(poc_o[15]),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(\wb_data_o[15]_i_4_n_0 ),
        .O(\wb_data_o[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7774447400000000)) 
    \wb_data_o[15]_i_2 
       (.I0(\wb_data_o[15]_i_5_n_0 ),
        .I1(\wb_data_o[31]_i_6_n_0 ),
        .I2(byte1[7]),
        .I3(csc[5]),
        .I4(mc_data_ir[15]),
        .I5(\wb_data_o[31]_i_4_n_0 ),
        .O(\wb_data_o[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFF0D)) 
    \wb_data_o[15]_i_3 
       (.I0(wb_addr_i[2]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[5]),
        .I4(wb_addr_i[6]),
        .I5(\wb_data_o[31]_i_4_n_0 ),
        .O(\wb_data_o[15]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[15]_i_4 
       (.I0(\u0/u1/tms_reg_n_0_[15] ),
        .I1(\u0/u1/csc_reg_n_0_[15] ),
        .I2(wb_addr_i[3]),
        .I3(tms[15]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[15] ),
        .O(\wb_data_o[15]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[15]_i_5 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[15]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[15]),
        .I4(\wb_data_o[15]_i_6_n_0 ),
        .O(\wb_data_o[15]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[15]_i_6 
       (.I0(r3[15]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[15]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[15]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hEEEEEEEAAAAAAAEA)) 
    \wb_data_o[16]_i_1 
       (.I0(\wb_data_o[16]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_4_n_0 ),
        .I2(\wb_data_o[16]_i_3_n_0 ),
        .I3(csc[3]),
        .I4(csc[2]),
        .I5(\wb_data_o[16]_i_4_n_0 ),
        .O(\wb_data_o[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h4444744400000000)) 
    \wb_data_o[16]_i_2 
       (.I0(\wb_data_o[16]_i_5_n_0 ),
        .I1(wb_addr_i[4]),
        .I2(poc_o[16]),
        .I3(wb_addr_i[2]),
        .I4(wb_addr_i[3]),
        .I5(\wb_data_o[31]_i_2_n_0 ),
        .O(\wb_data_o[16]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \wb_data_o[16]_i_3 
       (.I0(\u3/u0/rd_adr [0]),
        .I1(r0[16]),
        .I2(\u3/u0/rd_adr [1]),
        .I3(r1[16]),
        .I4(\wb_data_o[16]_i_6_n_0 ),
        .O(\wb_data_o[16]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \wb_data_o[16]_i_4 
       (.I0(mc_data_ir[16]),
        .I1(csc[5]),
        .I2(mc_data_ir[0]),
        .I3(csc[4]),
        .I4(byte2[0]),
        .O(\wb_data_o[16]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h505F3030505F3F3F)) 
    \wb_data_o[16]_i_5 
       (.I0(\u0/u1/tms_reg_n_0_[16] ),
        .I1(\u0/u1/csc_reg_n_0_[16] ),
        .I2(wb_addr_i[3]),
        .I3(tms[16]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[16] ),
        .O(\wb_data_o[16]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[16]_i_6 
       (.I0(r2[16]),
        .I1(\u3/u0/rd_adr [2]),
        .I2(r3[16]),
        .I3(\u3/u0/rd_adr [3]),
        .O(\wb_data_o[16]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hEAEAEAEAEAEAAAEE)) 
    \wb_data_o[17]_i_1 
       (.I0(\wb_data_o[17]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_4_n_0 ),
        .I2(\wb_data_o[17]_i_3_n_0 ),
        .I3(\wb_data_o[17]_i_4_n_0 ),
        .I4(csc[3]),
        .I5(csc[2]),
        .O(\wb_data_o[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8888B88800000000)) 
    \wb_data_o[17]_i_2 
       (.I0(\wb_data_o[17]_i_5_n_0 ),
        .I1(wb_addr_i[4]),
        .I2(poc_o[17]),
        .I3(wb_addr_i[2]),
        .I4(wb_addr_i[3]),
        .I5(\wb_data_o[31]_i_2_n_0 ),
        .O(\wb_data_o[17]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \wb_data_o[17]_i_3 
       (.I0(mc_data_ir[17]),
        .I1(csc[5]),
        .I2(mc_data_ir[1]),
        .I3(csc[4]),
        .I4(byte2[1]),
        .O(\wb_data_o[17]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[17]_i_4 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[17]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[17]),
        .I4(\wb_data_o[17]_i_6_n_0 ),
        .O(\wb_data_o[17]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[17]_i_5 
       (.I0(\u0/u1/tms_reg_n_0_[17] ),
        .I1(\u0/u1/csc_reg_n_0_[17] ),
        .I2(wb_addr_i[3]),
        .I3(tms[17]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[17] ),
        .O(\wb_data_o[17]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[17]_i_6 
       (.I0(r3[17]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[17]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[17]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hEAEAEAEAEAEAAAEE)) 
    \wb_data_o[18]_i_1 
       (.I0(\wb_data_o[18]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_4_n_0 ),
        .I2(\wb_data_o[18]_i_3_n_0 ),
        .I3(\wb_data_o[18]_i_4_n_0 ),
        .I4(csc[3]),
        .I5(csc[2]),
        .O(\wb_data_o[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8888B88800000000)) 
    \wb_data_o[18]_i_2 
       (.I0(\wb_data_o[18]_i_5_n_0 ),
        .I1(wb_addr_i[4]),
        .I2(poc_o[18]),
        .I3(wb_addr_i[2]),
        .I4(wb_addr_i[3]),
        .I5(\wb_data_o[31]_i_2_n_0 ),
        .O(\wb_data_o[18]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \wb_data_o[18]_i_3 
       (.I0(mc_data_ir[18]),
        .I1(csc[5]),
        .I2(mc_data_ir[2]),
        .I3(csc[4]),
        .I4(byte2[2]),
        .O(\wb_data_o[18]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[18]_i_4 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[18]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[18]),
        .I4(\wb_data_o[18]_i_6_n_0 ),
        .O(\wb_data_o[18]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[18]_i_5 
       (.I0(\u0/u1/tms_reg_n_0_[18] ),
        .I1(\u0/u1/csc_reg_n_0_[18] ),
        .I2(wb_addr_i[3]),
        .I3(tms[18]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[18] ),
        .O(\wb_data_o[18]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[18]_i_6 
       (.I0(r3[18]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[18]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[18]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hEAEAEAEAEAEAAAEE)) 
    \wb_data_o[19]_i_1 
       (.I0(\wb_data_o[19]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_4_n_0 ),
        .I2(\wb_data_o[19]_i_3_n_0 ),
        .I3(\wb_data_o[19]_i_4_n_0 ),
        .I4(csc[3]),
        .I5(csc[2]),
        .O(\wb_data_o[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h4444744400000000)) 
    \wb_data_o[19]_i_2 
       (.I0(\wb_data_o[19]_i_5_n_0 ),
        .I1(wb_addr_i[4]),
        .I2(poc_o[19]),
        .I3(wb_addr_i[2]),
        .I4(wb_addr_i[3]),
        .I5(\wb_data_o[31]_i_2_n_0 ),
        .O(\wb_data_o[19]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \wb_data_o[19]_i_3 
       (.I0(mc_data_ir[19]),
        .I1(csc[5]),
        .I2(mc_data_ir[3]),
        .I3(csc[4]),
        .I4(byte2[3]),
        .O(\wb_data_o[19]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[19]_i_4 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[19]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[19]),
        .I4(\wb_data_o[19]_i_6_n_0 ),
        .O(\wb_data_o[19]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h505F3030505F3F3F)) 
    \wb_data_o[19]_i_5 
       (.I0(\u0/u1/tms_reg_n_0_[19] ),
        .I1(\u0/u1/csc_reg_n_0_[19] ),
        .I2(wb_addr_i[3]),
        .I3(tms[19]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[19] ),
        .O(\wb_data_o[19]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[19]_i_6 
       (.I0(r3[19]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[19]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[19]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \wb_data_o[1]_i_1 
       (.I0(\wb_data_o[31]_i_4_n_0 ),
        .I1(wb_addr_i[6]),
        .I2(wb_addr_i[5]),
        .I3(\wb_data_o[1]_i_2_n_0 ),
        .I4(\wb_data_o[1]_i_3_n_0 ),
        .O(\wb_data_o[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[1]_i_2 
       (.I0(mc_vpen_pad_o),
        .I1(poc_o[1]),
        .I2(\wb_data_o[10]_i_4_n_0 ),
        .I3(\u0/csc_mask [1]),
        .I4(\wb_data_o[10]_i_5_n_0 ),
        .I5(\wb_data_o[1]_i_4_n_0 ),
        .O(\wb_data_o[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7774447400000000)) 
    \wb_data_o[1]_i_3 
       (.I0(\wb_data_o[1]_i_5_n_0 ),
        .I1(\wb_data_o[31]_i_6_n_0 ),
        .I2(byte0[1]),
        .I3(csc[5]),
        .I4(mc_data_ir[1]),
        .I5(\wb_data_o[31]_i_4_n_0 ),
        .O(\wb_data_o[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[1]_i_4 
       (.I0(\u0/u1/tms_reg_n_0_[1] ),
        .I1(\u0/u1/csc_reg_n_0_[1] ),
        .I2(wb_addr_i[3]),
        .I3(tms[1]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[1] ),
        .O(\wb_data_o[1]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[1]_i_5 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[1]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[1]),
        .I4(\wb_data_o[1]_i_6_n_0 ),
        .O(\wb_data_o[1]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[1]_i_6 
       (.I0(r3[1]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[1]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[1]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hEEEEEEEAAAAAAAEA)) 
    \wb_data_o[20]_i_1 
       (.I0(\wb_data_o[20]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_4_n_0 ),
        .I2(\wb_data_o[20]_i_3_n_0 ),
        .I3(csc[3]),
        .I4(csc[2]),
        .I5(\wb_data_o[20]_i_4_n_0 ),
        .O(\wb_data_o[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h4444744400000000)) 
    \wb_data_o[20]_i_2 
       (.I0(\wb_data_o[20]_i_5_n_0 ),
        .I1(wb_addr_i[4]),
        .I2(poc_o[20]),
        .I3(wb_addr_i[2]),
        .I4(wb_addr_i[3]),
        .I5(\wb_data_o[31]_i_2_n_0 ),
        .O(\wb_data_o[20]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \wb_data_o[20]_i_3 
       (.I0(\u3/u0/rd_adr [0]),
        .I1(r0[20]),
        .I2(\u3/u0/rd_adr [1]),
        .I3(r1[20]),
        .I4(\wb_data_o[20]_i_6_n_0 ),
        .O(\wb_data_o[20]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \wb_data_o[20]_i_4 
       (.I0(mc_data_ir[20]),
        .I1(csc[5]),
        .I2(mc_data_ir[4]),
        .I3(csc[4]),
        .I4(byte2[4]),
        .O(\wb_data_o[20]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h505F3030505F3F3F)) 
    \wb_data_o[20]_i_5 
       (.I0(\u0/u1/tms_reg_n_0_[20] ),
        .I1(\u0/u1/csc_reg_n_0_[20] ),
        .I2(wb_addr_i[3]),
        .I3(tms[20]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[20] ),
        .O(\wb_data_o[20]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[20]_i_6 
       (.I0(r2[20]),
        .I1(\u3/u0/rd_adr [2]),
        .I2(r3[20]),
        .I3(\u3/u0/rd_adr [3]),
        .O(\wb_data_o[20]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hEAEAEAEAEAEAAAEE)) 
    \wb_data_o[21]_i_1 
       (.I0(\wb_data_o[21]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_4_n_0 ),
        .I2(\wb_data_o[21]_i_3_n_0 ),
        .I3(\wb_data_o[21]_i_4_n_0 ),
        .I4(csc[3]),
        .I5(csc[2]),
        .O(\wb_data_o[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8888B88800000000)) 
    \wb_data_o[21]_i_2 
       (.I0(\wb_data_o[21]_i_5_n_0 ),
        .I1(wb_addr_i[4]),
        .I2(poc_o[21]),
        .I3(wb_addr_i[2]),
        .I4(wb_addr_i[3]),
        .I5(\wb_data_o[31]_i_2_n_0 ),
        .O(\wb_data_o[21]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \wb_data_o[21]_i_3 
       (.I0(mc_data_ir[21]),
        .I1(csc[5]),
        .I2(mc_data_ir[5]),
        .I3(csc[4]),
        .I4(byte2[5]),
        .O(\wb_data_o[21]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[21]_i_4 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[21]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[21]),
        .I4(\wb_data_o[21]_i_6_n_0 ),
        .O(\wb_data_o[21]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[21]_i_5 
       (.I0(\u0/u1/tms_reg_n_0_[21] ),
        .I1(\u0/u1/csc_reg_n_0_[21] ),
        .I2(wb_addr_i[3]),
        .I3(tms[21]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[21] ),
        .O(\wb_data_o[21]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[21]_i_6 
       (.I0(r3[21]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[21]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[21]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hEAEAEAEAEAEAAAEE)) 
    \wb_data_o[22]_i_1 
       (.I0(\wb_data_o[22]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_4_n_0 ),
        .I2(\wb_data_o[22]_i_3_n_0 ),
        .I3(\wb_data_o[22]_i_4_n_0 ),
        .I4(csc[3]),
        .I5(csc[2]),
        .O(\wb_data_o[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8888B88800000000)) 
    \wb_data_o[22]_i_2 
       (.I0(\wb_data_o[22]_i_5_n_0 ),
        .I1(wb_addr_i[4]),
        .I2(poc_o[22]),
        .I3(wb_addr_i[2]),
        .I4(wb_addr_i[3]),
        .I5(\wb_data_o[31]_i_2_n_0 ),
        .O(\wb_data_o[22]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \wb_data_o[22]_i_3 
       (.I0(mc_data_ir[22]),
        .I1(csc[5]),
        .I2(mc_data_ir[6]),
        .I3(csc[4]),
        .I4(byte2[6]),
        .O(\wb_data_o[22]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[22]_i_4 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[22]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[22]),
        .I4(\wb_data_o[22]_i_6_n_0 ),
        .O(\wb_data_o[22]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[22]_i_5 
       (.I0(\u0/u1/tms_reg_n_0_[22] ),
        .I1(\u0/u1/csc_reg_n_0_[22] ),
        .I2(wb_addr_i[3]),
        .I3(tms[22]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[22] ),
        .O(\wb_data_o[22]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[22]_i_6 
       (.I0(r3[22]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[22]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[22]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hEAEAEAEAEAEAAAEE)) 
    \wb_data_o[23]_i_1 
       (.I0(\wb_data_o[23]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_4_n_0 ),
        .I2(\wb_data_o[23]_i_3_n_0 ),
        .I3(\wb_data_o[23]_i_4_n_0 ),
        .I4(csc[3]),
        .I5(csc[2]),
        .O(\wb_data_o[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h550C000055000000)) 
    \wb_data_o[23]_i_2 
       (.I0(\wb_data_o[23]_i_5_n_0 ),
        .I1(wb_addr_i[2]),
        .I2(wb_addr_i[3]),
        .I3(wb_addr_i[4]),
        .I4(\wb_data_o[31]_i_2_n_0 ),
        .I5(poc_o[23]),
        .O(\wb_data_o[23]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \wb_data_o[23]_i_3 
       (.I0(mc_data_ir[23]),
        .I1(csc[5]),
        .I2(mc_data_ir[7]),
        .I3(csc[4]),
        .I4(byte2[7]),
        .O(\wb_data_o[23]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[23]_i_4 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[23]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[23]),
        .I4(\wb_data_o[23]_i_6_n_0 ),
        .O(\wb_data_o[23]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h505F3030505F3F3F)) 
    \wb_data_o[23]_i_5 
       (.I0(\u0/u1/tms_reg_n_0_[23] ),
        .I1(\u0/u1/csc_reg_n_0_[23] ),
        .I2(wb_addr_i[3]),
        .I3(tms[23]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[23] ),
        .O(\wb_data_o[23]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[23]_i_6 
       (.I0(r3[23]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[23]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[23]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h4444F4F4F444F444)) 
    \wb_data_o[24]_i_1 
       (.I0(\wb_data_o[24]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_2_n_0 ),
        .I2(\wb_data_o[31]_i_4_n_0 ),
        .I3(\wb_data_o[24]_i_3_n_0 ),
        .I4(\wb_data_o[24]_i_4_n_0 ),
        .I5(\wb_data_o[31]_i_6_n_0 ),
        .O(\wb_data_o[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h5C5C5C5F5F5F5C5F)) 
    \wb_data_o[24]_i_2 
       (.I0(\wb_data_o[24]_i_5_n_0 ),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(rfr_ps_val[0]),
        .I4(wb_addr_i[2]),
        .I5(poc_o[24]),
        .O(\wb_data_o[24]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \wb_data_o[24]_i_3 
       (.I0(mc_data_ir[24]),
        .I1(csc[5]),
        .I2(mc_data_ir[8]),
        .I3(csc[4]),
        .I4(mc_data_ir[0]),
        .O(\wb_data_o[24]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[24]_i_4 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[24]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[24]),
        .I4(\wb_data_o[24]_i_6_n_0 ),
        .O(\wb_data_o[24]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[24]_i_5 
       (.I0(\u0/u1/tms_reg_n_0_[24] ),
        .I1(\u0/u1/csc_reg_n_0_[24] ),
        .I2(wb_addr_i[3]),
        .I3(tms[24]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[24] ),
        .O(\wb_data_o[24]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[24]_i_6 
       (.I0(r3[24]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[24]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[24]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hF444F4F4F4444444)) 
    \wb_data_o[25]_i_1 
       (.I0(\wb_data_o[25]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_2_n_0 ),
        .I2(\wb_data_o[31]_i_4_n_0 ),
        .I3(\wb_data_o[25]_i_3_n_0 ),
        .I4(\wb_data_o[31]_i_6_n_0 ),
        .I5(\wb_data_o[25]_i_4_n_0 ),
        .O(\wb_data_o[25]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h5C5C5C5F5F5F5C5F)) 
    \wb_data_o[25]_i_2 
       (.I0(\wb_data_o[25]_i_5_n_0 ),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(rfr_ps_val[1]),
        .I4(wb_addr_i[2]),
        .I5(poc_o[25]),
        .O(\wb_data_o[25]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \wb_data_o[25]_i_3 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[25]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[25]),
        .I4(\wb_data_o[25]_i_6_n_0 ),
        .O(\wb_data_o[25]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \wb_data_o[25]_i_4 
       (.I0(mc_data_ir[25]),
        .I1(csc[5]),
        .I2(mc_data_ir[9]),
        .I3(csc[4]),
        .I4(mc_data_ir[1]),
        .O(\wb_data_o[25]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[25]_i_5 
       (.I0(\u0/u1/tms_reg_n_0_[25] ),
        .I1(\u0/u1/csc_reg_n_0_[25] ),
        .I2(wb_addr_i[3]),
        .I3(tms[25]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[25] ),
        .O(\wb_data_o[25]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[25]_i_6 
       (.I0(r3[25]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[25]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[25]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h4444F4F4F444F444)) 
    \wb_data_o[26]_i_1 
       (.I0(\wb_data_o[26]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_2_n_0 ),
        .I2(\wb_data_o[31]_i_4_n_0 ),
        .I3(\wb_data_o[26]_i_3_n_0 ),
        .I4(\wb_data_o[26]_i_4_n_0 ),
        .I5(\wb_data_o[31]_i_6_n_0 ),
        .O(\wb_data_o[26]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h5C5C5C5F5F5F5C5F)) 
    \wb_data_o[26]_i_2 
       (.I0(\wb_data_o[26]_i_5_n_0 ),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(rfr_ps_val[2]),
        .I4(wb_addr_i[2]),
        .I5(poc_o[26]),
        .O(\wb_data_o[26]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \wb_data_o[26]_i_3 
       (.I0(mc_data_ir[26]),
        .I1(csc[5]),
        .I2(mc_data_ir[10]),
        .I3(csc[4]),
        .I4(mc_data_ir[2]),
        .O(\wb_data_o[26]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[26]_i_4 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[26]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[26]),
        .I4(\wb_data_o[26]_i_6_n_0 ),
        .O(\wb_data_o[26]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[26]_i_5 
       (.I0(\u0/u1/tms_reg_n_0_[26] ),
        .I1(\u0/u1/csc_reg_n_0_[26] ),
        .I2(wb_addr_i[3]),
        .I3(tms[26]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[26] ),
        .O(\wb_data_o[26]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[26]_i_6 
       (.I0(r3[26]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[26]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[26]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hF444F4F4F4444444)) 
    \wb_data_o[27]_i_1 
       (.I0(\wb_data_o[27]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_2_n_0 ),
        .I2(\wb_data_o[31]_i_4_n_0 ),
        .I3(\wb_data_o[27]_i_3_n_0 ),
        .I4(\wb_data_o[31]_i_6_n_0 ),
        .I5(\wb_data_o[27]_i_4_n_0 ),
        .O(\wb_data_o[27]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h5C5C5C5F5F5F5C5F)) 
    \wb_data_o[27]_i_2 
       (.I0(\wb_data_o[27]_i_5_n_0 ),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(rfr_ps_val[3]),
        .I4(wb_addr_i[2]),
        .I5(poc_o[27]),
        .O(\wb_data_o[27]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \wb_data_o[27]_i_3 
       (.I0(\u3/u0/rd_adr [0]),
        .I1(r0[27]),
        .I2(\u3/u0/rd_adr [1]),
        .I3(r1[27]),
        .I4(\wb_data_o[27]_i_6_n_0 ),
        .O(\wb_data_o[27]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \wb_data_o[27]_i_4 
       (.I0(mc_data_ir[27]),
        .I1(csc[5]),
        .I2(mc_data_ir[11]),
        .I3(csc[4]),
        .I4(mc_data_ir[3]),
        .O(\wb_data_o[27]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[27]_i_5 
       (.I0(\u0/u1/tms_reg_n_0_[27] ),
        .I1(\u0/u1/csc_reg_n_0_[27] ),
        .I2(wb_addr_i[3]),
        .I3(tms[27]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[27] ),
        .O(\wb_data_o[27]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[27]_i_6 
       (.I0(r2[27]),
        .I1(\u3/u0/rd_adr [2]),
        .I2(r3[27]),
        .I3(\u3/u0/rd_adr [3]),
        .O(\wb_data_o[27]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hF444F4F4F4444444)) 
    \wb_data_o[28]_i_1 
       (.I0(\wb_data_o[28]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_2_n_0 ),
        .I2(\wb_data_o[31]_i_4_n_0 ),
        .I3(\wb_data_o[28]_i_3_n_0 ),
        .I4(\wb_data_o[31]_i_6_n_0 ),
        .I5(\wb_data_o[28]_i_4_n_0 ),
        .O(\wb_data_o[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h5C5C5C5F5F5F5C5F)) 
    \wb_data_o[28]_i_2 
       (.I0(\wb_data_o[28]_i_5_n_0 ),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(rfr_ps_val[4]),
        .I4(wb_addr_i[2]),
        .I5(poc_o[28]),
        .O(\wb_data_o[28]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \wb_data_o[28]_i_3 
       (.I0(\u3/u0/rd_adr [0]),
        .I1(r0[28]),
        .I2(\u3/u0/rd_adr [1]),
        .I3(r1[28]),
        .I4(\wb_data_o[28]_i_6_n_0 ),
        .O(\wb_data_o[28]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \wb_data_o[28]_i_4 
       (.I0(mc_data_ir[28]),
        .I1(csc[5]),
        .I2(mc_data_ir[12]),
        .I3(csc[4]),
        .I4(mc_data_ir[4]),
        .O(\wb_data_o[28]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[28]_i_5 
       (.I0(\u0/u1/tms_reg_n_0_[28] ),
        .I1(\u0/u1/csc_reg_n_0_[28] ),
        .I2(wb_addr_i[3]),
        .I3(tms[28]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[28] ),
        .O(\wb_data_o[28]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[28]_i_6 
       (.I0(r2[28]),
        .I1(\u3/u0/rd_adr [2]),
        .I2(r3[28]),
        .I3(\u3/u0/rd_adr [3]),
        .O(\wb_data_o[28]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h4444F4F4F444F444)) 
    \wb_data_o[29]_i_1 
       (.I0(\wb_data_o[29]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_2_n_0 ),
        .I2(\wb_data_o[31]_i_4_n_0 ),
        .I3(\wb_data_o[29]_i_3_n_0 ),
        .I4(\wb_data_o[29]_i_4_n_0 ),
        .I5(\wb_data_o[31]_i_6_n_0 ),
        .O(\wb_data_o[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h5C5C5C5F5F5F5C5F)) 
    \wb_data_o[29]_i_2 
       (.I0(\wb_data_o[29]_i_5_n_0 ),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(rfr_ps_val[5]),
        .I4(wb_addr_i[2]),
        .I5(poc_o[29]),
        .O(\wb_data_o[29]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \wb_data_o[29]_i_3 
       (.I0(mc_data_ir[29]),
        .I1(csc[5]),
        .I2(mc_data_ir[13]),
        .I3(csc[4]),
        .I4(mc_data_ir[5]),
        .O(\wb_data_o[29]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[29]_i_4 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[29]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[29]),
        .I4(\wb_data_o[29]_i_6_n_0 ),
        .O(\wb_data_o[29]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[29]_i_5 
       (.I0(\u0/u1/tms_reg_n_0_[29] ),
        .I1(\u0/u1/csc_reg_n_0_[29] ),
        .I2(wb_addr_i[3]),
        .I3(tms[29]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[29] ),
        .O(\wb_data_o[29]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[29]_i_6 
       (.I0(r3[29]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[29]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[29]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFF100010)) 
    \wb_data_o[2]_i_1 
       (.I0(wb_addr_i[6]),
        .I1(wb_addr_i[5]),
        .I2(\wb_data_o[2]_i_2_n_0 ),
        .I3(\wb_data_o[31]_i_4_n_0 ),
        .I4(\wb_data_o[2]_i_3_n_0 ),
        .O(\wb_data_o[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[2]_i_2 
       (.I0(fs),
        .I1(poc_o[2]),
        .I2(\wb_data_o[10]_i_4_n_0 ),
        .I3(\u0/csc_mask [2]),
        .I4(\wb_data_o[10]_i_5_n_0 ),
        .I5(\wb_data_o[2]_i_4_n_0 ),
        .O(\wb_data_o[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \wb_data_o[2]_i_3 
       (.I0(\wb_data_o[2]_i_5_n_0 ),
        .I1(csc[3]),
        .I2(csc[2]),
        .I3(mc_data_ir[2]),
        .I4(csc[5]),
        .I5(byte0[2]),
        .O(\wb_data_o[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[2]_i_4 
       (.I0(\u0/u1/tms_reg_n_0_[2] ),
        .I1(\u0/u1/csc_reg_n_0_[2] ),
        .I2(wb_addr_i[3]),
        .I3(tms[2]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[2] ),
        .O(\wb_data_o[2]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \wb_data_o[2]_i_5 
       (.I0(\u3/u0/rd_adr [0]),
        .I1(r0[2]),
        .I2(\u3/u0/rd_adr [1]),
        .I3(r1[2]),
        .I4(\wb_data_o[2]_i_6_n_0 ),
        .O(\wb_data_o[2]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[2]_i_6 
       (.I0(r2[2]),
        .I1(\u3/u0/rd_adr [2]),
        .I2(r3[2]),
        .I3(\u3/u0/rd_adr [3]),
        .O(\wb_data_o[2]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hF444F4F4F4444444)) 
    \wb_data_o[30]_i_1 
       (.I0(\wb_data_o[30]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_2_n_0 ),
        .I2(\wb_data_o[31]_i_4_n_0 ),
        .I3(\wb_data_o[30]_i_3_n_0 ),
        .I4(\wb_data_o[31]_i_6_n_0 ),
        .I5(\wb_data_o[30]_i_4_n_0 ),
        .O(\wb_data_o[30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h5C5C5C5F5F5F5C5F)) 
    \wb_data_o[30]_i_2 
       (.I0(\wb_data_o[30]_i_5_n_0 ),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(rfr_ps_val[6]),
        .I4(wb_addr_i[2]),
        .I5(poc_o[30]),
        .O(\wb_data_o[30]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \wb_data_o[30]_i_3 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[30]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[30]),
        .I4(\wb_data_o[30]_i_6_n_0 ),
        .O(\wb_data_o[30]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \wb_data_o[30]_i_4 
       (.I0(mc_data_ir[30]),
        .I1(csc[5]),
        .I2(mc_data_ir[14]),
        .I3(csc[4]),
        .I4(mc_data_ir[6]),
        .O(\wb_data_o[30]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[30]_i_5 
       (.I0(\u0/u1/tms_reg_n_0_[30] ),
        .I1(\u0/u1/csc_reg_n_0_[30] ),
        .I2(wb_addr_i[3]),
        .I3(tms[30]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[30] ),
        .O(\wb_data_o[30]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[30]_i_6 
       (.I0(r3[30]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[30]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[30]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h88F8F8F888F88888)) 
    \wb_data_o[31]_i_1 
       (.I0(\wb_data_o[31]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_3_n_0 ),
        .I2(\wb_data_o[31]_i_4_n_0 ),
        .I3(\wb_data_o[31]_i_5_n_0 ),
        .I4(\wb_data_o[31]_i_6_n_0 ),
        .I5(\wb_data_o[31]_i_7_n_0 ),
        .O(\wb_data_o[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h000000FE)) 
    \wb_data_o[31]_i_2 
       (.I0(wb_addr_i[31]),
        .I1(wb_addr_i[30]),
        .I2(wb_addr_i[29]),
        .I3(wb_addr_i[6]),
        .I4(wb_addr_i[5]),
        .O(\wb_data_o[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hA3A3A3A0A0A0A3A0)) 
    \wb_data_o[31]_i_3 
       (.I0(\wb_data_o[31]_i_8_n_0 ),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(rfr_ps_val[7]),
        .I4(wb_addr_i[2]),
        .I5(poc_o[31]),
        .O(\wb_data_o[31]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h01)) 
    \wb_data_o[31]_i_4 
       (.I0(wb_addr_i[29]),
        .I1(wb_addr_i[30]),
        .I2(wb_addr_i[31]),
        .O(\wb_data_o[31]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[31]_i_5 
       (.I0(\u3/u0/rd_adr [0]),
        .I1(r0[31]),
        .I2(\u3/u0/rd_adr [1]),
        .I3(r1[31]),
        .I4(\wb_data_o[31]_i_9_n_0 ),
        .O(\wb_data_o[31]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \wb_data_o[31]_i_6 
       (.I0(csc[3]),
        .I1(csc[2]),
        .O(\wb_data_o[31]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \wb_data_o[31]_i_7 
       (.I0(mc_data_ir[31]),
        .I1(csc[5]),
        .I2(mc_data_ir[15]),
        .I3(csc[4]),
        .I4(mc_data_ir[7]),
        .O(\wb_data_o[31]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[31]_i_8 
       (.I0(\u0/u1/tms_reg_n_0_[31] ),
        .I1(\u0/u1/csc_reg_n_0_[31] ),
        .I2(wb_addr_i[3]),
        .I3(tms[31]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[31] ),
        .O(\wb_data_o[31]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[31]_i_9 
       (.I0(r2[31]),
        .I1(\u3/u0/rd_adr [2]),
        .I2(r3[31]),
        .I3(\u3/u0/rd_adr [3]),
        .O(\wb_data_o[31]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \wb_data_o[3]_i_1 
       (.I0(\wb_data_o[31]_i_4_n_0 ),
        .I1(wb_addr_i[6]),
        .I2(wb_addr_i[5]),
        .I3(\wb_data_o[3]_i_2_n_0 ),
        .I4(\wb_data_o[3]_i_3_n_0 ),
        .O(\wb_data_o[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[3]_i_2 
       (.I0(\u0/csr_r_reg_n_0_[3] ),
        .I1(poc_o[3]),
        .I2(\wb_data_o[10]_i_4_n_0 ),
        .I3(\u0/csc_mask [3]),
        .I4(\wb_data_o[10]_i_5_n_0 ),
        .I5(\wb_data_o[3]_i_4_n_0 ),
        .O(\wb_data_o[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7774447400000000)) 
    \wb_data_o[3]_i_3 
       (.I0(\wb_data_o[3]_i_5_n_0 ),
        .I1(\wb_data_o[31]_i_6_n_0 ),
        .I2(byte0[3]),
        .I3(csc[5]),
        .I4(mc_data_ir[3]),
        .I5(\wb_data_o[31]_i_4_n_0 ),
        .O(\wb_data_o[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[3]_i_4 
       (.I0(\u0/u1/tms_reg_n_0_[3] ),
        .I1(\u0/u1/csc_reg_n_0_[3] ),
        .I2(wb_addr_i[3]),
        .I3(tms[3]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[3] ),
        .O(\wb_data_o[3]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[3]_i_5 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[3]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[3]),
        .I4(\wb_data_o[3]_i_6_n_0 ),
        .O(\wb_data_o[3]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[3]_i_6 
       (.I0(r3[3]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[3]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[3]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFF100010)) 
    \wb_data_o[4]_i_1 
       (.I0(wb_addr_i[6]),
        .I1(wb_addr_i[5]),
        .I2(\wb_data_o[4]_i_2_n_0 ),
        .I3(\wb_data_o[31]_i_4_n_0 ),
        .I4(\wb_data_o[4]_i_3_n_0 ),
        .O(\wb_data_o[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[4]_i_2 
       (.I0(\u0/csr_r_reg_n_0_[4] ),
        .I1(poc_o[4]),
        .I2(\wb_data_o[10]_i_4_n_0 ),
        .I3(\u0/csc_mask [4]),
        .I4(\wb_data_o[10]_i_5_n_0 ),
        .I5(\wb_data_o[4]_i_4_n_0 ),
        .O(\wb_data_o[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \wb_data_o[4]_i_3 
       (.I0(\wb_data_o[4]_i_5_n_0 ),
        .I1(csc[3]),
        .I2(csc[2]),
        .I3(mc_data_ir[4]),
        .I4(csc[5]),
        .I5(byte0[4]),
        .O(\wb_data_o[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[4]_i_4 
       (.I0(\u0/u1/tms_reg_n_0_[4] ),
        .I1(\u0/u1/csc_reg_n_0_[4] ),
        .I2(wb_addr_i[3]),
        .I3(tms[4]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[4] ),
        .O(\wb_data_o[4]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \wb_data_o[4]_i_5 
       (.I0(\u3/u0/rd_adr [0]),
        .I1(r0[4]),
        .I2(\u3/u0/rd_adr [1]),
        .I3(r1[4]),
        .I4(\wb_data_o[4]_i_6_n_0 ),
        .O(\wb_data_o[4]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[4]_i_6 
       (.I0(r2[4]),
        .I1(\u3/u0/rd_adr [2]),
        .I2(r3[4]),
        .I3(\u3/u0/rd_adr [3]),
        .O(\wb_data_o[4]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \wb_data_o[5]_i_1 
       (.I0(\wb_data_o[31]_i_4_n_0 ),
        .I1(wb_addr_i[6]),
        .I2(wb_addr_i[5]),
        .I3(\wb_data_o[5]_i_2_n_0 ),
        .I4(\wb_data_o[5]_i_3_n_0 ),
        .O(\wb_data_o[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[5]_i_2 
       (.I0(\u0/csr_r_reg_n_0_[5] ),
        .I1(poc_o[5]),
        .I2(\wb_data_o[10]_i_4_n_0 ),
        .I3(\u0/csc_mask [5]),
        .I4(\wb_data_o[10]_i_5_n_0 ),
        .I5(\wb_data_o[5]_i_4_n_0 ),
        .O(\wb_data_o[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7774447400000000)) 
    \wb_data_o[5]_i_3 
       (.I0(\wb_data_o[5]_i_5_n_0 ),
        .I1(\wb_data_o[31]_i_6_n_0 ),
        .I2(byte0[5]),
        .I3(csc[5]),
        .I4(mc_data_ir[5]),
        .I5(\wb_data_o[31]_i_4_n_0 ),
        .O(\wb_data_o[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[5]_i_4 
       (.I0(\u0/u1/tms_reg_n_0_[5] ),
        .I1(\u0/u1/csc_reg_n_0_[5] ),
        .I2(wb_addr_i[3]),
        .I3(tms[5]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[5] ),
        .O(\wb_data_o[5]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[5]_i_5 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[5]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[5]),
        .I4(\wb_data_o[5]_i_6_n_0 ),
        .O(\wb_data_o[5]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[5]_i_6 
       (.I0(r3[5]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[5]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[5]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \wb_data_o[6]_i_1 
       (.I0(\wb_data_o[31]_i_4_n_0 ),
        .I1(wb_addr_i[6]),
        .I2(wb_addr_i[5]),
        .I3(\wb_data_o[6]_i_2_n_0 ),
        .I4(\wb_data_o[6]_i_3_n_0 ),
        .O(\wb_data_o[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[6]_i_2 
       (.I0(\u0/csr_r_reg_n_0_[6] ),
        .I1(poc_o[6]),
        .I2(\wb_data_o[10]_i_4_n_0 ),
        .I3(\u0/csc_mask [6]),
        .I4(\wb_data_o[10]_i_5_n_0 ),
        .I5(\wb_data_o[6]_i_4_n_0 ),
        .O(\wb_data_o[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7774447400000000)) 
    \wb_data_o[6]_i_3 
       (.I0(\wb_data_o[6]_i_5_n_0 ),
        .I1(\wb_data_o[31]_i_6_n_0 ),
        .I2(byte0[6]),
        .I3(csc[5]),
        .I4(mc_data_ir[6]),
        .I5(\wb_data_o[31]_i_4_n_0 ),
        .O(\wb_data_o[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[6]_i_4 
       (.I0(\u0/u1/tms_reg_n_0_[6] ),
        .I1(\u0/u1/csc_reg_n_0_[6] ),
        .I2(wb_addr_i[3]),
        .I3(tms[6]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[6] ),
        .O(\wb_data_o[6]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[6]_i_5 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[6]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[6]),
        .I4(\wb_data_o[6]_i_6_n_0 ),
        .O(\wb_data_o[6]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[6]_i_6 
       (.I0(r3[6]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[6]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[6]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \wb_data_o[7]_i_1 
       (.I0(\wb_data_o[31]_i_4_n_0 ),
        .I1(wb_addr_i[6]),
        .I2(wb_addr_i[5]),
        .I3(\wb_data_o[7]_i_2_n_0 ),
        .I4(\wb_data_o[7]_i_3_n_0 ),
        .O(\wb_data_o[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[7]_i_2 
       (.I0(\u0/csr_r_reg_n_0_[7] ),
        .I1(poc_o[7]),
        .I2(\wb_data_o[10]_i_4_n_0 ),
        .I3(\u0/csc_mask [7]),
        .I4(\wb_data_o[10]_i_5_n_0 ),
        .I5(\wb_data_o[7]_i_4_n_0 ),
        .O(\wb_data_o[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7774447400000000)) 
    \wb_data_o[7]_i_3 
       (.I0(\wb_data_o[7]_i_5_n_0 ),
        .I1(\wb_data_o[31]_i_6_n_0 ),
        .I2(byte0[7]),
        .I3(csc[5]),
        .I4(mc_data_ir[7]),
        .I5(\wb_data_o[31]_i_4_n_0 ),
        .O(\wb_data_o[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[7]_i_4 
       (.I0(\u0/u1/tms_reg_n_0_[7] ),
        .I1(\u0/u1/csc_reg_n_0_[7] ),
        .I2(wb_addr_i[3]),
        .I3(tms[7]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[7] ),
        .O(\wb_data_o[7]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[7]_i_5 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[7]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[7]),
        .I4(\wb_data_o[7]_i_6_n_0 ),
        .O(\wb_data_o[7]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[7]_i_6 
       (.I0(r3[7]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[7]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[7]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFF100010)) 
    \wb_data_o[8]_i_1 
       (.I0(wb_addr_i[6]),
        .I1(wb_addr_i[5]),
        .I2(\wb_data_o[8]_i_2_n_0 ),
        .I3(\wb_data_o[31]_i_4_n_0 ),
        .I4(\wb_data_o[8]_i_3_n_0 ),
        .O(\wb_data_o[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[8]_i_2 
       (.I0(sel0[0]),
        .I1(poc_o[8]),
        .I2(\wb_data_o[10]_i_4_n_0 ),
        .I3(\u0/csc_mask_r_reg_n_0_[8] ),
        .I4(\wb_data_o[10]_i_5_n_0 ),
        .I5(\wb_data_o[8]_i_4_n_0 ),
        .O(\wb_data_o[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \wb_data_o[8]_i_3 
       (.I0(\wb_data_o[8]_i_5_n_0 ),
        .I1(csc[3]),
        .I2(csc[2]),
        .I3(mc_data_ir[8]),
        .I4(csc[5]),
        .I5(byte1[0]),
        .O(\wb_data_o[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[8]_i_4 
       (.I0(\u0/u1/tms_reg_n_0_[8] ),
        .I1(\u0/u1/csc_reg_n_0_[8] ),
        .I2(wb_addr_i[3]),
        .I3(tms[8]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[8] ),
        .O(\wb_data_o[8]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \wb_data_o[8]_i_5 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[8]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[8]),
        .I4(\wb_data_o[8]_i_6_n_0 ),
        .O(\wb_data_o[8]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[8]_i_6 
       (.I0(r3[8]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[8]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[8]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \wb_data_o[9]_i_1 
       (.I0(\wb_data_o[31]_i_4_n_0 ),
        .I1(wb_addr_i[6]),
        .I2(wb_addr_i[5]),
        .I3(\wb_data_o[9]_i_2_n_0 ),
        .I4(\wb_data_o[9]_i_3_n_0 ),
        .O(\wb_data_o[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[9]_i_2 
       (.I0(sel0[1]),
        .I1(poc_o[9]),
        .I2(\wb_data_o[10]_i_4_n_0 ),
        .I3(\u0/csc_mask_r_reg_n_0_[9] ),
        .I4(\wb_data_o[10]_i_5_n_0 ),
        .I5(\wb_data_o[9]_i_4_n_0 ),
        .O(\wb_data_o[9]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7774447400000000)) 
    \wb_data_o[9]_i_3 
       (.I0(\wb_data_o[9]_i_5_n_0 ),
        .I1(\wb_data_o[31]_i_6_n_0 ),
        .I2(byte1[1]),
        .I3(csc[5]),
        .I4(mc_data_ir[9]),
        .I5(\wb_data_o[31]_i_4_n_0 ),
        .O(\wb_data_o[9]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wb_data_o[9]_i_4 
       (.I0(\u0/u1/tms_reg_n_0_[9] ),
        .I1(\u0/u1/csc_reg_n_0_[9] ),
        .I2(wb_addr_i[3]),
        .I3(tms[9]),
        .I4(wb_addr_i[2]),
        .I5(\u0/u0/csc_reg_n_0_[9] ),
        .O(\wb_data_o[9]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00000777)) 
    \wb_data_o[9]_i_5 
       (.I0(\u3/u0/rd_adr [1]),
        .I1(r1[9]),
        .I2(\u3/u0/rd_adr [0]),
        .I3(r0[9]),
        .I4(\wb_data_o[9]_i_6_n_0 ),
        .O(\wb_data_o[9]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \wb_data_o[9]_i_6 
       (.I0(r3[9]),
        .I1(\u3/u0/rd_adr [3]),
        .I2(r2[9]),
        .I3(\u3/u0/rd_adr [2]),
        .O(\wb_data_o[9]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000000004440404)) 
    wb_err_i_1
       (.I0(wb_err_o),
        .I1(\wb_data_o[31]_i_4_n_0 ),
        .I2(wb_ack_o_i_5_n_0),
        .I3(wb_ack_o_i_4_n_0),
        .I4(mem_ack),
        .I5(wb_ack_o_i_3_n_0),
        .O(\u6/wb_err0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hF1F0)) 
    wb_first_r_i_1
       (.I0(wb_err_o),
        .I1(wb_ack_o),
        .I2(\u6/wb_first_set ),
        .I3(\u6/wb_first_r ),
        .O(wb_first_r_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h02000000)) 
    wb_first_r_i_2
       (.I0(\wb_data_o[31]_i_4_n_0 ),
        .I1(\u6/read_go_r ),
        .I2(\u6/write_go_r ),
        .I3(wb_stb_i),
        .I4(wb_cyc_i),
        .O(\u6/wb_first_set ));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT3 #(
    .INIT(8'h32)) 
    wb_stb_first_i_1
       (.I0(wb_stb_first_i_2_n_0),
        .I1(mem_ack),
        .I2(\u5/wb_stb_first_reg_n_0 ),
        .O(wb_stb_first_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h888A8888)) 
    wb_stb_first_i_2
       (.I0(wb_stb_i),
        .I1(\u6/wb_first_set ),
        .I2(wb_err_o),
        .I3(wb_ack_o),
        .I4(\u6/wb_first_r ),
        .O(wb_stb_first_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT1 #(
    .INIT(2'h1)) 
    wb_wait_r2_i_1
       (.I0(mc_adv__i_3_n_0),
        .O(wb_wait));
  LUT5 #(
    .INIT(32'h44000400)) 
    wb_write_go_r_i_1
       (.I0(wb_write_go_r_i_2_n_0),
        .I1(\u6/write_go_r1 ),
        .I2(wb_stb_i),
        .I3(wb_cyc_i),
        .I4(wb_we_i),
        .O(wb_write_go));
  LUT6 #(
    .INIT(64'hBAAAAAAAAAAAAAAA)) 
    wb_write_go_r_i_2
       (.I0(\u6/rmw_r ),
        .I1(wr_hold),
        .I2(\u6/rmw_en ),
        .I3(wb_we_i),
        .I4(wb_cyc_i),
        .I5(wb_stb_i),
        .O(wb_write_go_r_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT5 #(
    .INIT(32'hBF008000)) 
    wp_err_i_1
       (.I0(wp_err_i_2_n_0),
        .I1(wb_stb_i),
        .I2(cs_le),
        .I3(wb_cyc_i),
        .I4(wp_err),
        .O(wp_err_i_1_n_0));
  LUT5 #(
    .INIT(32'h4F004400)) 
    wp_err_i_2
       (.I0(\csc[11]_i_7_n_0 ),
        .I1(\u0/u1/csc_reg_n_0_[8] ),
        .I2(\csc[11]_i_3_n_0 ),
        .I3(wb_we_i),
        .I4(\u0/u0/csc_reg_n_0_[8] ),
        .O(wp_err_i_2_n_0));
  LUT4 #(
    .INIT(16'hFBBB)) 
    \wr_adr[0]_i_1 
       (.I0(\u3/u0/p_0_in ),
        .I1(wb_cyc_i),
        .I2(wb_we_i),
        .I3(wb_stb_i),
        .O(\wr_adr[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0888)) 
    \wr_adr[1]_i_1 
       (.I0(\u3/u0/wr_adr_reg_n_0_[0] ),
        .I1(wb_cyc_i),
        .I2(wb_we_i),
        .I3(wb_stb_i),
        .O(\wr_adr[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT4 #(
    .INIT(16'h0888)) 
    \wr_adr[2]_i_1 
       (.I0(\u3/u0/p_0_in1_in ),
        .I1(wb_cyc_i),
        .I2(wb_we_i),
        .I3(wb_stb_i),
        .O(\wr_adr[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFBBB)) 
    \wr_adr[3]_i_1 
       (.I0(dv),
        .I1(wb_cyc_i),
        .I2(wb_we_i),
        .I3(wb_stb_i),
        .O(\wr_adr[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT4 #(
    .INIT(16'h0888)) 
    \wr_adr[3]_i_2 
       (.I0(\u3/u0/p_0_in0_in ),
        .I1(wb_cyc_i),
        .I2(wb_we_i),
        .I3(wb_stb_i),
        .O(\wr_adr[3]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hBA)) 
    wr_cycle_i_1
       (.I0(\u5/wr_set ),
        .I1(\u5/burst_cnt_ld ),
        .I2(wr_cycle),
        .O(wr_cycle_i_1_n_0));
  LUT6 #(
    .INIT(64'h0E0E0E0E0E000000)) 
    wr_cycle_i_2
       (.I0(wr_cycle_i_3_n_0),
        .I1(\u5/state [4]),
        .I2(wr_cycle_i_4_n_0),
        .I3(wb_stb_i),
        .I4(wb_we_i),
        .I5(wb_write_go),
        .O(\u5/wr_set ));
  LUT6 #(
    .INIT(64'h0100000000000000)) 
    wr_cycle_i_3
       (.I0(\mc_addr[23]_i_3_n_0 ),
        .I1(\mc_addr[14]_i_4_n_0 ),
        .I2(\FSM_sequential_state[5]_i_9_n_0 ),
        .I3(\FSM_sequential_state[5]_i_8_n_0 ),
        .I4(\u5/lookup_ready2 ),
        .I5(mc_adv__i_3_n_0),
        .O(wr_cycle_i_3_n_0));
  LUT6 #(
    .INIT(64'hFFFFFF5FFFEFFFFF)) 
    wr_cycle_i_4
       (.I0(\u5/state [4]),
        .I1(\u5/state [1]),
        .I2(rfr_ack_r_i_7_n_0),
        .I3(\u5/state [3]),
        .I4(\u5/state [0]),
        .I5(\u5/state [2]),
        .O(wr_cycle_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'hBF80)) 
    wr_hold_i_1
       (.I0(wb_we_i),
        .I1(wb_cyc_i),
        .I2(wb_stb_i),
        .I3(wr_hold),
        .O(wr_hold_i_1_n_0));
  LUT5 #(
    .INIT(32'hA8888888)) 
    write_go_r1_i_1
       (.I0(wb_cyc_i),
        .I1(\u6/write_go_r ),
        .I2(\wb_data_o[31]_i_4_n_0 ),
        .I3(wb_stb_i),
        .I4(wb_we_i),
        .O(\u6/write_go_r10 ));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT4 #(
    .INIT(16'hA020)) 
    write_go_r_i_1
       (.I0(\u6/write_go_r1 ),
        .I1(wb_stb_i),
        .I2(wb_cyc_i),
        .I3(wb_we_i),
        .O(\u6/write_go_r0 ));
endmodule
