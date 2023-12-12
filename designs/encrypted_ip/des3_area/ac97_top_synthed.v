// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
// Date        : Fri May 26 10:14:45 2023
// Host        : goeders1 running 64-bit Ubuntu 20.04.3 LTS
// Command     : write_verilog ./ac97_top_synthed.v -force
// Design      : ac97_top
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7a100tcsg324-3
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* STRUCTURAL_NETLIST = "yes" *)
module ac97_top
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
    .wb_err_o(\<const0> ),
    int_o,
    dma_req_o,
    dma_ack_i,
    suspended_o,
    bit_clk_pad_i,
    sync_pad_o,
    sdata_pad_o,
    sdata_pad_i,
    ac97_reset_pad_o_);
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
  output int_o;
  output [8:0]dma_req_o;
  input [8:0]dma_ack_i;
  output suspended_o;
  input bit_clk_pad_i;
  output sync_pad_o;
  output sdata_pad_o;
  input sdata_pad_i;
  output ac97_reset_pad_o_;
  output \<const0> ;

  wire \<const0> ;
  wire \<const1> ;
  wire ac97_reset_pad_o_;
  wire ac97_rst__i_1_n_0;
  wire ac97_rst_force;
  wire ac97_rst_force_i_1_n_0;
  wire bit_clk_pad_i;
  wire clk_i;
  wire \cnt[0]_i_1__0_n_0 ;
  wire \cnt[0]_i_1_n_0 ;
  wire \cnt[1]_i_1_n_0 ;
  wire \cnt[2]_i_1_n_0 ;
  wire \cnt[2]_i_2_n_0 ;
  wire \cnt[7]_i_2_n_0 ;
  wire [15:0]crac_din;
  wire [31:0]crac_out;
  wire crac_rd_done;
  wire crac_rd_i_1_n_0;
  wire crac_valid_r_i_1_n_0;
  wire crac_we;
  wire crac_wr;
  wire crac_wr_i_1_n_0;
  wire crac_wr_r_i_1_n_0;
  wire [8:0]dma_ack_i;
  wire dma_req_i_1__0_n_0;
  wire dma_req_i_1__1_n_0;
  wire dma_req_i_1__2_n_0;
  wire dma_req_i_1__3_n_0;
  wire dma_req_i_1__4_n_0;
  wire dma_req_i_1__5_n_0;
  wire dma_req_i_1__6_n_0;
  wire dma_req_i_1__7_n_0;
  wire dma_req_i_1_n_0;
  wire dma_req_i_2_n_0;
  wire [8:0]dma_req_o;
  wire [31:0]dout0;
  wire [31:0]dout0__0;
  wire [31:0]dout0__1;
  wire \dout[19]_i_1__0_n_0 ;
  wire \dout[19]_i_1__1_n_0 ;
  wire \dout[19]_i_1__2_n_0 ;
  wire \dout[19]_i_1__3_n_0 ;
  wire \dout[19]_i_1__4_n_0 ;
  wire \dout[19]_i_1_n_0 ;
  wire [31:0]dout_tmp;
  wire [31:0]dout_tmp__0;
  wire [31:0]dout_tmp__1;
  wire [31:0]dout_tmp__2;
  wire [31:0]dout_tmp__3;
  wire [31:0]dout_tmp__4;
  wire empty_i_2__0_n_0;
  wire empty_i_2__1_n_0;
  wire empty_i_2__2_n_0;
  wire empty_i_2__3_n_0;
  wire empty_i_2__4_n_0;
  wire empty_i_2__5_n_0;
  wire empty_i_2__6_n_0;
  wire empty_i_2__7_n_0;
  wire empty_i_2_n_0;
  wire en_out_l_i_1__0_n_0;
  wire en_out_l_i_1__1_n_0;
  wire en_out_l_i_1__2_n_0;
  wire en_out_l_i_1__3_n_0;
  wire en_out_l_i_1__4_n_0;
  wire en_out_l_i_1__5_n_0;
  wire en_out_l_i_1__6_n_0;
  wire en_out_l_i_1__7_n_0;
  wire en_out_l_i_1_n_0;
  wire en_out_l_i_2__0_n_0;
  wire en_out_l_i_2__1_n_0;
  wire en_out_l_i_2__2_n_0;
  wire en_out_l_i_2__3_n_0;
  wire en_out_l_i_2__4_n_0;
  wire en_out_l_i_2__5_n_0;
  wire en_out_l_i_2__6_n_0;
  wire en_out_l_i_2__7_n_0;
  wire en_out_l_i_2_n_0;
  wire full_empty_r_i_1__0_n_0;
  wire full_empty_r_i_1__1_n_0;
  wire full_empty_r_i_1__2_n_0;
  wire [31:0]i3_dout;
  wire i3_empty;
  wire i3_full;
  wire [1:0]i3_mode;
  wire i3_re;
  wire [1:0]i3_status;
  wire i3_we;
  wire [31:0]i4_dout;
  wire i4_empty;
  wire i4_full;
  wire [1:0]i4_mode;
  wire i4_re;
  wire [1:0]i4_status;
  wire i4_we;
  wire [31:0]i6_dout;
  wire i6_empty;
  wire i6_full;
  wire [1:0]i6_mode;
  wire i6_re;
  wire [1:0]i6_status;
  wire i6_we;
  wire [2:0]ic0_int_set;
  wire [2:0]ic1_int_set;
  wire [2:0]ic2_int_set;
  wire [15:9]in_slt0;
  wire [11:5]in_slt1;
  wire [19:4]in_slt2;
  wire [19:0]in_slt3;
  wire [19:0]in_slt4;
  wire [19:0]in_slt6;
  wire [2:0]in_valid;
  wire \in_valid[1]_i_1_n_0 ;
  wire \in_valid[2]_i_1_n_0 ;
  wire [2:0]in_valid_s;
  wire [2:0]in_valid_s1;
  wire int_i_10_n_0;
  wire int_i_11_n_0;
  wire int_i_12_n_0;
  wire int_i_1_n_0;
  wire int_i_2_n_0;
  wire int_i_3_n_0;
  wire int_i_4_n_0;
  wire int_i_5_n_0;
  wire int_i_6_n_0;
  wire int_i_7_n_0;
  wire int_i_8_n_0;
  wire int_i_9_n_0;
  wire int_o;
  wire \int_set[0]_i_1__0_n_0 ;
  wire \int_set[0]_i_1__1_n_0 ;
  wire \int_set[0]_i_1__2_n_0 ;
  wire \int_set[0]_i_1__3_n_0 ;
  wire \int_set[0]_i_1__4_n_0 ;
  wire \int_set[0]_i_1__5_n_0 ;
  wire \int_set[0]_i_1__6_n_0 ;
  wire \int_set[0]_i_1__7_n_0 ;
  wire \int_set[0]_i_1_n_0 ;
  wire \ints_r[0]_i_1_n_0 ;
  wire \ints_r[10]_i_1_n_0 ;
  wire \ints_r[11]_i_1_n_0 ;
  wire \ints_r[12]_i_1_n_0 ;
  wire \ints_r[13]_i_1_n_0 ;
  wire \ints_r[14]_i_1_n_0 ;
  wire \ints_r[15]_i_1_n_0 ;
  wire \ints_r[16]_i_1_n_0 ;
  wire \ints_r[17]_i_1_n_0 ;
  wire \ints_r[18]_i_1_n_0 ;
  wire \ints_r[19]_i_1_n_0 ;
  wire \ints_r[1]_i_1_n_0 ;
  wire \ints_r[20]_i_1_n_0 ;
  wire \ints_r[21]_i_1_n_0 ;
  wire \ints_r[22]_i_1_n_0 ;
  wire \ints_r[23]_i_1_n_0 ;
  wire \ints_r[24]_i_1_n_0 ;
  wire \ints_r[25]_i_1_n_0 ;
  wire \ints_r[26]_i_1_n_0 ;
  wire \ints_r[27]_i_1_n_0 ;
  wire \ints_r[28]_i_1_n_0 ;
  wire \ints_r[28]_i_2_n_0 ;
  wire \ints_r[2]_i_1_n_0 ;
  wire \ints_r[3]_i_1_n_0 ;
  wire \ints_r[4]_i_1_n_0 ;
  wire \ints_r[5]_i_1_n_0 ;
  wire \ints_r[6]_i_1_n_0 ;
  wire \ints_r[7]_i_1_n_0 ;
  wire \ints_r[8]_i_1_n_0 ;
  wire \ints_r[9]_i_1_n_0 ;
  wire ld;
  wire ld_i_1_n_0;
  wire o3_empty;
  wire [1:0]o3_mode;
  wire o3_re;
  wire [1:0]o3_status;
  wire o3_we;
  wire o3_we_i_1_n_0;
  wire o3_we_i_2_n_0;
  wire o3_we_i_3_n_0;
  wire o4_empty;
  wire [1:0]o4_mode;
  wire o4_re;
  wire [1:0]o4_status;
  wire o4_we;
  wire o4_we_i_1_n_0;
  wire o6_empty;
  wire [1:0]o6_mode;
  wire o6_re;
  wire [1:0]o6_status;
  wire o6_we;
  wire o6_we_i_1_n_0;
  wire o7_empty;
  wire [1:0]o7_mode;
  wire o7_re;
  wire [1:0]o7_status;
  wire o7_we;
  wire o7_we_i_1_n_0;
  wire o8_empty;
  wire [1:0]o8_mode;
  wire o8_re;
  wire [1:0]o8_status;
  wire o8_we;
  wire o8_we_i_1_n_0;
  wire o9_empty;
  wire [1:0]o9_mode;
  wire o9_re;
  wire [1:0]o9_status;
  wire o9_we;
  wire o9_we_i_1_n_0;
  wire [2:0]oc0_int_set;
  wire [2:0]oc1_int_set;
  wire [2:0]oc2_int_set;
  wire [2:0]oc3_int_set;
  wire [2:0]oc4_int_set;
  wire [2:0]oc5_int_set;
  wire [5:0]out_le;
  wire \out_le[0]_i_1_n_0 ;
  wire \out_le[0]_i_2_n_0 ;
  wire \out_le[1]_i_1_n_0 ;
  wire \out_le[1]_i_2_n_0 ;
  wire \out_le[1]_i_3_n_0 ;
  wire \out_le[2]_i_1_n_0 ;
  wire \out_le[2]_i_2_n_0 ;
  wire \out_le[3]_i_1_n_0 ;
  wire \out_le[3]_i_2_n_0 ;
  wire \out_le[4]_i_1_n_0 ;
  wire \out_le[5]_i_1_n_0 ;
  wire [14:6]out_slt0;
  wire [19:0]out_slt3;
  wire [19:0]out_slt4;
  wire [19:0]out_slt6;
  wire [19:0]out_slt7;
  wire [19:0]out_slt8;
  wire [19:0]out_slt9;
  wire [19:0]p_0_in;
  wire p_0_in__0;
  wire [3:0]p_0_in__0__0;
  wire p_0_in__1;
  wire [7:1]p_0_in__1__0;
  wire p_0_in__2;
  wire [3:1]p_0_in__2__0;
  wire [5:1]p_0_in__3;
  wire [3:1]p_0_in__3__0;
  wire [3:1]p_0_in__4;
  wire [3:1]p_0_in__5;
  wire [3:1]p_0_in__6;
  wire [3:1]p_0_in__7;
  wire [5:1]p_0_in__8;
  wire ps_ce;
  wire \ps_cnt[0]_i_1_n_0 ;
  wire \ps_cnt[4]_i_2_n_0 ;
  wire \ps_cnt[5]_i_2_n_0 ;
  wire rdd1_i_1_n_0;
  wire rdd2_i_1_n_0;
  wire rdd3_i_1_n_0;
  wire re1_i_2_n_0;
  wire resume_req;
  wire resume_req_i_1_n_0;
  wire rf_we;
  wire \rp[0]_i_1__0_n_0 ;
  wire \rp[0]_i_1__1_n_0 ;
  wire \rp[0]_i_1__2_n_0 ;
  wire \rp[0]_i_1__3_n_0 ;
  wire \rp[0]_i_1__4_n_0 ;
  wire \rp[0]_i_1__5_n_0 ;
  wire \rp[0]_i_1__6_n_0 ;
  wire \rp[0]_i_1__7_n_0 ;
  wire \rp[0]_i_1_n_0 ;
  wire \rp[1]_i_1__0_n_0 ;
  wire \rp[1]_i_1__1_n_0 ;
  wire \rp[1]_i_1_n_0 ;
  wire \rp[2]_i_1__0_n_0 ;
  wire \rp[2]_i_1__1_n_0 ;
  wire \rp[2]_i_1_n_0 ;
  wire \rp[3]_i_2__0_n_0 ;
  wire \rp[3]_i_2__1_n_0 ;
  wire \rp[3]_i_2__2_n_0 ;
  wire \rp[3]_i_2__3_n_0 ;
  wire \rp[3]_i_2__4_n_0 ;
  wire \rp[3]_i_2_n_0 ;
  wire rst_i;
  wire sdata_pad_i;
  wire sdata_pad_o;
  wire \slt0_r[11]_i_1_n_0 ;
  wire \slt0_r[12]_i_1_n_0 ;
  wire \slt0_r[13]_i_1_n_0 ;
  wire \slt0_r[14]_i_1_n_0 ;
  wire \slt0_r[15]_i_1_n_0 ;
  wire \slt0_r[15]_i_2_n_0 ;
  wire \slt0_r[6]_i_1_n_0 ;
  wire \slt0_r[7]_i_1_n_0 ;
  wire \slt0_r[8]_i_1_n_0 ;
  wire \slt0_r[9]_i_1_n_0 ;
  wire \slt1_r[12]_i_1_n_0 ;
  wire \slt1_r[13]_i_1_n_0 ;
  wire \slt1_r[14]_i_1_n_0 ;
  wire \slt1_r[15]_i_1_n_0 ;
  wire \slt1_r[16]_i_1_n_0 ;
  wire \slt1_r[17]_i_1_n_0 ;
  wire \slt1_r[18]_i_1_n_0 ;
  wire \slt1_r[19]_i_1_n_0 ;
  wire \slt2_r[10]_i_1_n_0 ;
  wire \slt2_r[11]_i_1_n_0 ;
  wire \slt2_r[12]_i_1_n_0 ;
  wire \slt2_r[13]_i_1_n_0 ;
  wire \slt2_r[14]_i_1_n_0 ;
  wire \slt2_r[15]_i_1_n_0 ;
  wire \slt2_r[16]_i_1_n_0 ;
  wire \slt2_r[17]_i_1_n_0 ;
  wire \slt2_r[18]_i_1_n_0 ;
  wire \slt2_r[19]_i_1_n_0 ;
  wire \slt2_r[4]_i_1_n_0 ;
  wire \slt2_r[5]_i_1_n_0 ;
  wire \slt2_r[6]_i_1_n_0 ;
  wire \slt2_r[7]_i_1_n_0 ;
  wire \slt2_r[8]_i_1_n_0 ;
  wire \slt2_r[9]_i_1_n_0 ;
  wire \slt3_r[0]_i_1_n_0 ;
  wire \slt3_r[10]_i_1_n_0 ;
  wire \slt3_r[11]_i_1_n_0 ;
  wire \slt3_r[12]_i_1_n_0 ;
  wire \slt3_r[13]_i_1_n_0 ;
  wire \slt3_r[14]_i_1_n_0 ;
  wire \slt3_r[15]_i_1_n_0 ;
  wire \slt3_r[16]_i_1_n_0 ;
  wire \slt3_r[17]_i_1_n_0 ;
  wire \slt3_r[18]_i_1_n_0 ;
  wire \slt3_r[19]_i_1_n_0 ;
  wire \slt3_r[1]_i_1_n_0 ;
  wire \slt3_r[2]_i_1_n_0 ;
  wire \slt3_r[3]_i_1_n_0 ;
  wire \slt3_r[4]_i_1_n_0 ;
  wire \slt3_r[5]_i_1_n_0 ;
  wire \slt3_r[6]_i_1_n_0 ;
  wire \slt3_r[7]_i_1_n_0 ;
  wire \slt3_r[8]_i_1_n_0 ;
  wire \slt3_r[9]_i_1_n_0 ;
  wire \slt4_r[0]_i_1_n_0 ;
  wire \slt4_r[10]_i_1_n_0 ;
  wire \slt4_r[11]_i_1_n_0 ;
  wire \slt4_r[12]_i_1_n_0 ;
  wire \slt4_r[13]_i_1_n_0 ;
  wire \slt4_r[14]_i_1_n_0 ;
  wire \slt4_r[15]_i_1_n_0 ;
  wire \slt4_r[16]_i_1_n_0 ;
  wire \slt4_r[17]_i_1_n_0 ;
  wire \slt4_r[18]_i_1_n_0 ;
  wire \slt4_r[19]_i_1_n_0 ;
  wire \slt4_r[1]_i_1_n_0 ;
  wire \slt4_r[2]_i_1_n_0 ;
  wire \slt4_r[3]_i_1_n_0 ;
  wire \slt4_r[4]_i_1_n_0 ;
  wire \slt4_r[5]_i_1_n_0 ;
  wire \slt4_r[6]_i_1_n_0 ;
  wire \slt4_r[7]_i_1_n_0 ;
  wire \slt4_r[8]_i_1_n_0 ;
  wire \slt4_r[9]_i_1_n_0 ;
  wire \slt6_r[0]_i_1_n_0 ;
  wire \slt6_r[10]_i_1_n_0 ;
  wire \slt6_r[11]_i_1_n_0 ;
  wire \slt6_r[12]_i_1_n_0 ;
  wire \slt6_r[13]_i_1_n_0 ;
  wire \slt6_r[14]_i_1_n_0 ;
  wire \slt6_r[15]_i_1_n_0 ;
  wire \slt6_r[16]_i_1_n_0 ;
  wire \slt6_r[17]_i_1_n_0 ;
  wire \slt6_r[18]_i_1_n_0 ;
  wire \slt6_r[19]_i_1_n_0 ;
  wire \slt6_r[1]_i_1_n_0 ;
  wire \slt6_r[2]_i_1_n_0 ;
  wire \slt6_r[3]_i_1_n_0 ;
  wire \slt6_r[4]_i_1_n_0 ;
  wire \slt6_r[5]_i_1_n_0 ;
  wire \slt6_r[6]_i_1_n_0 ;
  wire \slt6_r[7]_i_1_n_0 ;
  wire \slt6_r[8]_i_1_n_0 ;
  wire \slt6_r[9]_i_1_n_0 ;
  wire \slt7_r[0]_i_1_n_0 ;
  wire \slt7_r[10]_i_1_n_0 ;
  wire \slt7_r[11]_i_1_n_0 ;
  wire \slt7_r[12]_i_1_n_0 ;
  wire \slt7_r[13]_i_1_n_0 ;
  wire \slt7_r[14]_i_1_n_0 ;
  wire \slt7_r[15]_i_1_n_0 ;
  wire \slt7_r[16]_i_1_n_0 ;
  wire \slt7_r[17]_i_1_n_0 ;
  wire \slt7_r[18]_i_1_n_0 ;
  wire \slt7_r[19]_i_1_n_0 ;
  wire \slt7_r[1]_i_1_n_0 ;
  wire \slt7_r[2]_i_1_n_0 ;
  wire \slt7_r[3]_i_1_n_0 ;
  wire \slt7_r[4]_i_1_n_0 ;
  wire \slt7_r[5]_i_1_n_0 ;
  wire \slt7_r[6]_i_1_n_0 ;
  wire \slt7_r[7]_i_1_n_0 ;
  wire \slt7_r[8]_i_1_n_0 ;
  wire \slt7_r[9]_i_1_n_0 ;
  wire \slt8_r[0]_i_1_n_0 ;
  wire \slt8_r[10]_i_1_n_0 ;
  wire \slt8_r[11]_i_1_n_0 ;
  wire \slt8_r[12]_i_1_n_0 ;
  wire \slt8_r[13]_i_1_n_0 ;
  wire \slt8_r[14]_i_1_n_0 ;
  wire \slt8_r[15]_i_1_n_0 ;
  wire \slt8_r[16]_i_1_n_0 ;
  wire \slt8_r[17]_i_1_n_0 ;
  wire \slt8_r[18]_i_1_n_0 ;
  wire \slt8_r[19]_i_1_n_0 ;
  wire \slt8_r[1]_i_1_n_0 ;
  wire \slt8_r[2]_i_1_n_0 ;
  wire \slt8_r[3]_i_1_n_0 ;
  wire \slt8_r[4]_i_1_n_0 ;
  wire \slt8_r[5]_i_1_n_0 ;
  wire \slt8_r[6]_i_1_n_0 ;
  wire \slt8_r[7]_i_1_n_0 ;
  wire \slt8_r[8]_i_1_n_0 ;
  wire \slt8_r[9]_i_1_n_0 ;
  wire \slt9_r[0]_i_1_n_0 ;
  wire \status[0]_i_1__0_n_0 ;
  wire \status[0]_i_1__1_n_0 ;
  wire \status[0]_i_1__2_n_0 ;
  wire \status[0]_i_1__3_n_0 ;
  wire \status[0]_i_1__4_n_0 ;
  wire \status[0]_i_1__5_n_0 ;
  wire \status[0]_i_1__6_n_0 ;
  wire \status[0]_i_1__7_n_0 ;
  wire \status[0]_i_1_n_0 ;
  wire suspended_o;
  wire sync_pad_o;
  wire sync_resume_i_1_n_0;
  wire sync_resume_i_2_n_0;
  wire \to_cnt[0]_i_1_n_0 ;
  wire \to_cnt[5]_i_1_n_0 ;
  wire \to_cnt[5]_i_3_n_0 ;
  wire \to_cnt[5]_i_4_n_0 ;
  wire [19:1]\u0/p_0_in ;
  wire [14:5]\u0/slt0_r ;
  wire \u0/slt0_r_reg[3]_srl4___u0_slt5_r_reg_r_2_n_0 ;
  wire \u0/slt0_r_reg[4]_u0_slt5_r_reg_r_3_n_0 ;
  wire \u0/slt0_r_reg_gate_n_0 ;
  wire [19:11]\u0/slt1_r ;
  wire \u0/slt1_r_reg[10]_u0_slt5_r_reg_r_9_n_0 ;
  wire \u0/slt1_r_reg[9]_srl10___u0_slt5_r_reg_r_8_n_0 ;
  wire \u0/slt1_r_reg_gate_n_0 ;
  wire [19:3]\u0/slt2_r ;
  wire \u0/slt2_r_reg[1]_srl2___u0_slt5_r_reg_r_0_n_0 ;
  wire \u0/slt2_r_reg[2]_u0_slt5_r_reg_r_1_n_0 ;
  wire \u0/slt2_r_reg_gate_n_0 ;
  wire [19:0]\u0/slt3_r ;
  wire [19:0]\u0/slt4_r ;
  wire [19:19]\u0/slt5_r ;
  wire \u0/slt5_r_reg[17]_srl18___u0_slt5_r_reg_r_16_n_0 ;
  wire \u0/slt5_r_reg[18]_u0_slt5_r_reg_r_17_n_0 ;
  wire \u0/slt5_r_reg_gate_n_0 ;
  wire \u0/slt5_r_reg_r_0_n_0 ;
  wire \u0/slt5_r_reg_r_10_n_0 ;
  wire \u0/slt5_r_reg_r_11_n_0 ;
  wire \u0/slt5_r_reg_r_12_n_0 ;
  wire \u0/slt5_r_reg_r_13_n_0 ;
  wire \u0/slt5_r_reg_r_14_n_0 ;
  wire \u0/slt5_r_reg_r_15_n_0 ;
  wire \u0/slt5_r_reg_r_16_n_0 ;
  wire \u0/slt5_r_reg_r_17_n_0 ;
  wire \u0/slt5_r_reg_r_1_n_0 ;
  wire \u0/slt5_r_reg_r_2_n_0 ;
  wire \u0/slt5_r_reg_r_3_n_0 ;
  wire \u0/slt5_r_reg_r_4_n_0 ;
  wire \u0/slt5_r_reg_r_5_n_0 ;
  wire \u0/slt5_r_reg_r_6_n_0 ;
  wire \u0/slt5_r_reg_r_7_n_0 ;
  wire \u0/slt5_r_reg_r_8_n_0 ;
  wire \u0/slt5_r_reg_r_9_n_0 ;
  wire \u0/slt5_r_reg_r_n_0 ;
  wire [19:0]\u0/slt6_r ;
  wire [19:0]\u0/slt7_r ;
  wire [19:0]\u0/slt8_r ;
  wire [19:0]\u0/slt9_r ;
  wire \u1/sr_reg_n_0_[19] ;
  wire [31:0]\u10/din_tmp ;
  wire [15:0]\u10/din_tmp1 ;
  wire \u10/din_tmp10 ;
  wire \u10/empty0 ;
  wire \u10/full0 ;
  wire [1:0]\u10/p_1_in ;
  wire \u10/rp_reg_n_0_[0] ;
  wire \u10/rp_reg_n_0_[1] ;
  wire \u10/rp_reg_n_0_[2] ;
  wire [1:1]\u10/status0 ;
  wire \u10/wp_reg_n_0_[0] ;
  wire \u10/wp_reg_n_0_[3] ;
  wire [31:0]\u11/din_tmp ;
  wire [15:0]\u11/din_tmp1 ;
  wire \u11/din_tmp10 ;
  wire \u11/empty0 ;
  wire \u11/full0 ;
  wire [1:0]\u11/p_1_in ;
  wire \u11/rp_reg_n_0_[0] ;
  wire \u11/rp_reg_n_0_[1] ;
  wire \u11/rp_reg_n_0_[2] ;
  wire [1:1]\u11/status0 ;
  wire \u11/wp_reg_n_0_[0] ;
  wire \u11/wp_reg_n_0_[3] ;
  wire \u12/i3_re0 ;
  wire \u12/i4_re0 ;
  wire \u12/i6_re0 ;
  wire \u12/re1 ;
  wire \u12/re10 ;
  wire \u12/re2 ;
  wire \u12/re20 ;
  wire \u12/rf_we0 ;
  wire \u12/wb_ack_o0 ;
  wire \u12/we1 ;
  wire \u12/we10 ;
  wire \u12/we2 ;
  wire \u12/we20 ;
  wire \u13/icc_r0 ;
  wire \u13/icc_r_reg_n_0_[0] ;
  wire \u13/icc_r_reg_n_0_[12] ;
  wire \u13/icc_r_reg_n_0_[13] ;
  wire \u13/icc_r_reg_n_0_[14] ;
  wire \u13/icc_r_reg_n_0_[15] ;
  wire \u13/icc_r_reg_n_0_[16] ;
  wire \u13/icc_r_reg_n_0_[17] ;
  wire \u13/icc_r_reg_n_0_[1] ;
  wire \u13/icc_r_reg_n_0_[20] ;
  wire \u13/icc_r_reg_n_0_[21] ;
  wire \u13/icc_r_reg_n_0_[22] ;
  wire \u13/icc_r_reg_n_0_[23] ;
  wire \u13/icc_r_reg_n_0_[4] ;
  wire \u13/icc_r_reg_n_0_[5] ;
  wire \u13/icc_r_reg_n_0_[6] ;
  wire \u13/icc_r_reg_n_0_[7] ;
  wire \u13/icc_r_reg_n_0_[8] ;
  wire \u13/icc_r_reg_n_0_[9] ;
  wire [28:0]\u13/intm ;
  wire \u13/intm_r0 ;
  wire [28:0]\u13/ints ;
  wire \u13/occ00 ;
  wire \u13/occ0_r_reg_n_0_[0] ;
  wire \u13/occ0_r_reg_n_0_[12] ;
  wire \u13/occ0_r_reg_n_0_[13] ;
  wire \u13/occ0_r_reg_n_0_[14] ;
  wire \u13/occ0_r_reg_n_0_[15] ;
  wire \u13/occ0_r_reg_n_0_[16] ;
  wire \u13/occ0_r_reg_n_0_[17] ;
  wire \u13/occ0_r_reg_n_0_[1] ;
  wire \u13/occ0_r_reg_n_0_[20] ;
  wire \u13/occ0_r_reg_n_0_[21] ;
  wire \u13/occ0_r_reg_n_0_[22] ;
  wire \u13/occ0_r_reg_n_0_[23] ;
  wire \u13/occ0_r_reg_n_0_[24] ;
  wire \u13/occ0_r_reg_n_0_[25] ;
  wire \u13/occ0_r_reg_n_0_[28] ;
  wire \u13/occ0_r_reg_n_0_[29] ;
  wire \u13/occ0_r_reg_n_0_[30] ;
  wire \u13/occ0_r_reg_n_0_[31] ;
  wire \u13/occ0_r_reg_n_0_[4] ;
  wire \u13/occ0_r_reg_n_0_[5] ;
  wire \u13/occ0_r_reg_n_0_[6] ;
  wire \u13/occ0_r_reg_n_0_[7] ;
  wire \u13/occ0_r_reg_n_0_[8] ;
  wire \u13/occ0_r_reg_n_0_[9] ;
  wire \u13/occ1_r0 ;
  wire \u13/occ1_r_reg_n_0_[0] ;
  wire \u13/occ1_r_reg_n_0_[12] ;
  wire \u13/occ1_r_reg_n_0_[13] ;
  wire \u13/occ1_r_reg_n_0_[14] ;
  wire \u13/occ1_r_reg_n_0_[15] ;
  wire \u13/occ1_r_reg_n_0_[1] ;
  wire \u13/occ1_r_reg_n_0_[4] ;
  wire \u13/occ1_r_reg_n_0_[5] ;
  wire \u13/occ1_r_reg_n_0_[6] ;
  wire \u13/occ1_r_reg_n_0_[7] ;
  wire \u13/occ1_r_reg_n_0_[8] ;
  wire \u13/occ1_r_reg_n_0_[9] ;
  wire \u14/p_0_in ;
  wire \u14/u0/en_out_l20 ;
  wire \u14/u0/en_out_l2_reg_n_0 ;
  wire \u14/u0/full_empty_r ;
  wire \u14/u1/en_out_l20 ;
  wire \u14/u1/en_out_l2_reg_n_0 ;
  wire \u14/u1/full_empty_r ;
  wire \u14/u2/en_out_l20 ;
  wire \u14/u2/en_out_l2_reg_n_0 ;
  wire \u14/u2/full_empty_r ;
  wire \u14/u3/en_out_l20 ;
  wire \u14/u3/en_out_l2_reg_n_0 ;
  wire \u14/u3/full_empty_r ;
  wire \u14/u4/en_out_l20 ;
  wire \u14/u4/en_out_l2_reg_n_0 ;
  wire \u14/u4/full_empty_r ;
  wire \u14/u5/en_out_l20 ;
  wire \u14/u5/en_out_l2_reg_n_0 ;
  wire \u14/u5/full_empty_r ;
  wire \u14/u6/en_out_l20 ;
  wire \u14/u6/en_out_l2_reg_n_0 ;
  wire \u14/u6/en_out_l_reg_n_0 ;
  wire \u14/u6/full_empty_r ;
  wire \u14/u7/en_out_l20 ;
  wire \u14/u7/en_out_l2_reg_n_0 ;
  wire \u14/u7/en_out_l_reg_n_0 ;
  wire \u14/u7/full_empty_r ;
  wire \u14/u8/en_out_l20 ;
  wire \u14/u8/en_out_l2_reg_n_0 ;
  wire \u14/u8/en_out_l_reg_n_0 ;
  wire \u14/u8/full_empty_r ;
  wire \u15/crac_rd ;
  wire \u15/crac_rd_done0 ;
  wire \u15/crac_we_r ;
  wire \u15/rdd1 ;
  wire \u15/rdd2 ;
  wire \u15/rdd3 ;
  wire \u15/valid_r ;
  wire \u16/u0/dma_req_r1 ;
  wire \u16/u0/dma_req_r10 ;
  wire \u16/u1/dma_req_r1 ;
  wire \u16/u1/dma_req_r10 ;
  wire \u16/u2/dma_req_r1 ;
  wire \u16/u2/dma_req_r10 ;
  wire \u16/u3/dma_req_r1 ;
  wire \u16/u3/dma_req_r10 ;
  wire \u16/u4/dma_req_r1 ;
  wire \u16/u4/dma_req_r10 ;
  wire \u16/u5/dma_req_r1 ;
  wire \u16/u5/dma_req_r10 ;
  wire \u16/u6/dma_req_r1 ;
  wire \u16/u6/dma_req_r10 ;
  wire \u16/u7/dma_req_r1 ;
  wire \u16/u7/dma_req_r10 ;
  wire \u16/u8/dma_req_r1 ;
  wire \u16/u8/dma_req_r10 ;
  wire \u17/int_set_reg0 ;
  wire \u17/int_set_reg00_out ;
  wire \u18/int_set_reg0 ;
  wire \u18/int_set_reg00_out ;
  wire \u19/int_set_reg0 ;
  wire \u19/int_set_reg00_out ;
  wire \u2/bit_clk_e ;
  wire \u2/bit_clk_e0 ;
  wire \u2/bit_clk_r ;
  wire \u2/bit_clk_r1 ;
  wire \u2/clear ;
  wire [7:0]\u2/cnt_reg ;
  wire \u2/p_0_in ;
  wire [3:0]\u2/res_cnt_reg ;
  wire \u2/sync_beat ;
  wire \u2/sync_beat0 ;
  wire \u2/sync_resume_reg_n_0 ;
  wire \u2/to ;
  wire [5:0]\u2/to_cnt_reg ;
  wire \u20/int_set_reg0 ;
  wire \u20/int_set_reg00_out ;
  wire \u21/int_set_reg0 ;
  wire \u21/int_set_reg00_out ;
  wire \u22/int_set_reg0 ;
  wire \u22/int_set_reg00_out ;
  wire \u23/int_set_reg0 ;
  wire \u23/int_set_reg00_out ;
  wire \u24/int_set_reg0 ;
  wire \u24/int_set_reg00_out ;
  wire \u25/int_set_reg0 ;
  wire \u25/int_set_reg00_out ;
  wire [2:0]\u26/cnt ;
  wire [5:0]\u26/ps_cnt_reg ;
  wire \u3/dout[0]_i_1_n_0 ;
  wire \u3/dout[10]_i_1_n_0 ;
  wire \u3/dout[10]_i_2_n_0 ;
  wire \u3/dout[11]_i_1_n_0 ;
  wire \u3/dout[11]_i_2_n_0 ;
  wire \u3/dout[12]_i_1_n_0 ;
  wire \u3/dout[12]_i_2_n_0 ;
  wire \u3/dout[13]_i_1_n_0 ;
  wire \u3/dout[13]_i_2_n_0 ;
  wire \u3/dout[14]_i_1_n_0 ;
  wire \u3/dout[14]_i_2_n_0 ;
  wire \u3/dout[15]_i_1_n_0 ;
  wire \u3/dout[15]_i_2_n_0 ;
  wire \u3/dout[16]_i_1_n_0 ;
  wire \u3/dout[16]_i_2_n_0 ;
  wire \u3/dout[17]_i_1_n_0 ;
  wire \u3/dout[17]_i_2_n_0 ;
  wire \u3/dout[18]_i_1_n_0 ;
  wire \u3/dout[18]_i_2_n_0 ;
  wire \u3/dout[19]_i_3_n_0 ;
  wire \u3/dout[19]_i_4_n_0 ;
  wire \u3/dout[1]_i_1_n_0 ;
  wire \u3/dout[2]_i_1_n_0 ;
  wire \u3/dout[3]_i_1_n_0 ;
  wire \u3/dout[4]_i_1_n_0 ;
  wire \u3/dout[4]_i_2_n_0 ;
  wire \u3/dout[5]_i_1_n_0 ;
  wire \u3/dout[5]_i_2_n_0 ;
  wire \u3/dout[6]_i_1_n_0 ;
  wire \u3/dout[6]_i_2_n_0 ;
  wire \u3/dout[7]_i_1_n_0 ;
  wire \u3/dout[7]_i_2_n_0 ;
  wire \u3/dout[8]_i_1_n_0 ;
  wire \u3/dout[8]_i_2_n_0 ;
  wire \u3/dout[9]_i_1_n_0 ;
  wire \u3/dout[9]_i_2_n_0 ;
  wire \u3/empty0 ;
  wire [1:0]\u3/p_0_in ;
  wire \u3/p_1_in ;
  wire \u3/rp_reg_n_0_[0] ;
  wire \u3/rp_reg_n_0_[3] ;
  wire [1:1]\u3/status0 ;
  wire \u3/wp_reg_n_0_[0] ;
  wire \u3/wp_reg_n_0_[1] ;
  wire \u4/dout[0]_i_1_n_0 ;
  wire \u4/dout[10]_i_1_n_0 ;
  wire \u4/dout[10]_i_2_n_0 ;
  wire \u4/dout[11]_i_1_n_0 ;
  wire \u4/dout[11]_i_2_n_0 ;
  wire \u4/dout[12]_i_1_n_0 ;
  wire \u4/dout[12]_i_2_n_0 ;
  wire \u4/dout[13]_i_1_n_0 ;
  wire \u4/dout[13]_i_2_n_0 ;
  wire \u4/dout[14]_i_1_n_0 ;
  wire \u4/dout[14]_i_2_n_0 ;
  wire \u4/dout[15]_i_1_n_0 ;
  wire \u4/dout[15]_i_2_n_0 ;
  wire \u4/dout[16]_i_1_n_0 ;
  wire \u4/dout[16]_i_2_n_0 ;
  wire \u4/dout[17]_i_1_n_0 ;
  wire \u4/dout[17]_i_2_n_0 ;
  wire \u4/dout[18]_i_1_n_0 ;
  wire \u4/dout[18]_i_2_n_0 ;
  wire \u4/dout[19]_i_3_n_0 ;
  wire \u4/dout[19]_i_4_n_0 ;
  wire \u4/dout[1]_i_1_n_0 ;
  wire \u4/dout[2]_i_1_n_0 ;
  wire \u4/dout[3]_i_1_n_0 ;
  wire \u4/dout[4]_i_1_n_0 ;
  wire \u4/dout[4]_i_2_n_0 ;
  wire \u4/dout[5]_i_1_n_0 ;
  wire \u4/dout[5]_i_2_n_0 ;
  wire \u4/dout[6]_i_1_n_0 ;
  wire \u4/dout[6]_i_2_n_0 ;
  wire \u4/dout[7]_i_1_n_0 ;
  wire \u4/dout[7]_i_2_n_0 ;
  wire \u4/dout[8]_i_1_n_0 ;
  wire \u4/dout[8]_i_2_n_0 ;
  wire \u4/dout[9]_i_1_n_0 ;
  wire \u4/dout[9]_i_2_n_0 ;
  wire \u4/empty0 ;
  wire [1:0]\u4/p_0_in ;
  wire \u4/p_1_in ;
  wire \u4/rp_reg_n_0_[0] ;
  wire \u4/rp_reg_n_0_[3] ;
  wire [1:1]\u4/status0 ;
  wire \u4/wp_reg_n_0_[0] ;
  wire \u4/wp_reg_n_0_[1] ;
  wire \u5/dout[0]_i_1_n_0 ;
  wire \u5/dout[10]_i_1_n_0 ;
  wire \u5/dout[10]_i_2_n_0 ;
  wire \u5/dout[11]_i_1_n_0 ;
  wire \u5/dout[11]_i_2_n_0 ;
  wire \u5/dout[12]_i_1_n_0 ;
  wire \u5/dout[12]_i_2_n_0 ;
  wire \u5/dout[13]_i_1_n_0 ;
  wire \u5/dout[13]_i_2_n_0 ;
  wire \u5/dout[14]_i_1_n_0 ;
  wire \u5/dout[14]_i_2_n_0 ;
  wire \u5/dout[15]_i_1_n_0 ;
  wire \u5/dout[15]_i_2_n_0 ;
  wire \u5/dout[16]_i_1_n_0 ;
  wire \u5/dout[16]_i_2_n_0 ;
  wire \u5/dout[17]_i_1_n_0 ;
  wire \u5/dout[17]_i_2_n_0 ;
  wire \u5/dout[18]_i_1_n_0 ;
  wire \u5/dout[18]_i_2_n_0 ;
  wire \u5/dout[19]_i_3_n_0 ;
  wire \u5/dout[19]_i_4_n_0 ;
  wire \u5/dout[1]_i_1_n_0 ;
  wire \u5/dout[2]_i_1_n_0 ;
  wire \u5/dout[3]_i_1_n_0 ;
  wire \u5/dout[4]_i_1_n_0 ;
  wire \u5/dout[4]_i_2_n_0 ;
  wire \u5/dout[5]_i_1_n_0 ;
  wire \u5/dout[5]_i_2_n_0 ;
  wire \u5/dout[6]_i_1_n_0 ;
  wire \u5/dout[6]_i_2_n_0 ;
  wire \u5/dout[7]_i_1_n_0 ;
  wire \u5/dout[7]_i_2_n_0 ;
  wire \u5/dout[8]_i_1_n_0 ;
  wire \u5/dout[8]_i_2_n_0 ;
  wire \u5/dout[9]_i_1_n_0 ;
  wire \u5/dout[9]_i_2_n_0 ;
  wire \u5/empty0 ;
  wire [1:0]\u5/p_0_in ;
  wire \u5/p_1_in ;
  wire \u5/rp_reg_n_0_[0] ;
  wire \u5/rp_reg_n_0_[3] ;
  wire [1:1]\u5/status0 ;
  wire \u5/wp_reg_n_0_[0] ;
  wire \u5/wp_reg_n_0_[1] ;
  wire \u6/dout[0]_i_1_n_0 ;
  wire \u6/dout[10]_i_1_n_0 ;
  wire \u6/dout[10]_i_2_n_0 ;
  wire \u6/dout[11]_i_1_n_0 ;
  wire \u6/dout[11]_i_2_n_0 ;
  wire \u6/dout[12]_i_1_n_0 ;
  wire \u6/dout[12]_i_2_n_0 ;
  wire \u6/dout[13]_i_1_n_0 ;
  wire \u6/dout[13]_i_2_n_0 ;
  wire \u6/dout[14]_i_1_n_0 ;
  wire \u6/dout[14]_i_2_n_0 ;
  wire \u6/dout[15]_i_1_n_0 ;
  wire \u6/dout[15]_i_2_n_0 ;
  wire \u6/dout[16]_i_1_n_0 ;
  wire \u6/dout[16]_i_2_n_0 ;
  wire \u6/dout[17]_i_1_n_0 ;
  wire \u6/dout[17]_i_2_n_0 ;
  wire \u6/dout[18]_i_1_n_0 ;
  wire \u6/dout[18]_i_2_n_0 ;
  wire \u6/dout[19]_i_3_n_0 ;
  wire \u6/dout[19]_i_4_n_0 ;
  wire \u6/dout[1]_i_1_n_0 ;
  wire \u6/dout[2]_i_1_n_0 ;
  wire \u6/dout[3]_i_1_n_0 ;
  wire \u6/dout[4]_i_1_n_0 ;
  wire \u6/dout[4]_i_2_n_0 ;
  wire \u6/dout[5]_i_1_n_0 ;
  wire \u6/dout[5]_i_2_n_0 ;
  wire \u6/dout[6]_i_1_n_0 ;
  wire \u6/dout[6]_i_2_n_0 ;
  wire \u6/dout[7]_i_1_n_0 ;
  wire \u6/dout[7]_i_2_n_0 ;
  wire \u6/dout[8]_i_1_n_0 ;
  wire \u6/dout[8]_i_2_n_0 ;
  wire \u6/dout[9]_i_1_n_0 ;
  wire \u6/dout[9]_i_2_n_0 ;
  wire \u6/empty0 ;
  wire [1:0]\u6/p_0_in ;
  wire \u6/p_1_in ;
  wire \u6/rp_reg_n_0_[0] ;
  wire \u6/rp_reg_n_0_[3] ;
  wire [1:1]\u6/status0 ;
  wire \u6/wp_reg_n_0_[0] ;
  wire \u6/wp_reg_n_0_[1] ;
  wire \u7/dout[0]_i_1_n_0 ;
  wire \u7/dout[10]_i_1_n_0 ;
  wire \u7/dout[10]_i_2_n_0 ;
  wire \u7/dout[11]_i_1_n_0 ;
  wire \u7/dout[11]_i_2_n_0 ;
  wire \u7/dout[12]_i_1_n_0 ;
  wire \u7/dout[12]_i_2_n_0 ;
  wire \u7/dout[13]_i_1_n_0 ;
  wire \u7/dout[13]_i_2_n_0 ;
  wire \u7/dout[14]_i_1_n_0 ;
  wire \u7/dout[14]_i_2_n_0 ;
  wire \u7/dout[15]_i_1_n_0 ;
  wire \u7/dout[15]_i_2_n_0 ;
  wire \u7/dout[16]_i_1_n_0 ;
  wire \u7/dout[16]_i_2_n_0 ;
  wire \u7/dout[17]_i_1_n_0 ;
  wire \u7/dout[17]_i_2_n_0 ;
  wire \u7/dout[18]_i_1_n_0 ;
  wire \u7/dout[18]_i_2_n_0 ;
  wire \u7/dout[19]_i_3_n_0 ;
  wire \u7/dout[19]_i_4_n_0 ;
  wire \u7/dout[1]_i_1_n_0 ;
  wire \u7/dout[2]_i_1_n_0 ;
  wire \u7/dout[3]_i_1_n_0 ;
  wire \u7/dout[4]_i_1_n_0 ;
  wire \u7/dout[4]_i_2_n_0 ;
  wire \u7/dout[5]_i_1_n_0 ;
  wire \u7/dout[5]_i_2_n_0 ;
  wire \u7/dout[6]_i_1_n_0 ;
  wire \u7/dout[6]_i_2_n_0 ;
  wire \u7/dout[7]_i_1_n_0 ;
  wire \u7/dout[7]_i_2_n_0 ;
  wire \u7/dout[8]_i_1_n_0 ;
  wire \u7/dout[8]_i_2_n_0 ;
  wire \u7/dout[9]_i_1_n_0 ;
  wire \u7/dout[9]_i_2_n_0 ;
  wire \u7/empty0 ;
  wire [1:0]\u7/p_0_in ;
  wire \u7/p_1_in ;
  wire \u7/rp_reg_n_0_[0] ;
  wire \u7/rp_reg_n_0_[3] ;
  wire [1:1]\u7/status0 ;
  wire \u7/wp_reg_n_0_[0] ;
  wire \u7/wp_reg_n_0_[1] ;
  wire \u8/dout[0]_i_1_n_0 ;
  wire \u8/dout[10]_i_1_n_0 ;
  wire \u8/dout[10]_i_2_n_0 ;
  wire \u8/dout[11]_i_1_n_0 ;
  wire \u8/dout[11]_i_2_n_0 ;
  wire \u8/dout[12]_i_1_n_0 ;
  wire \u8/dout[12]_i_2_n_0 ;
  wire \u8/dout[13]_i_1_n_0 ;
  wire \u8/dout[13]_i_2_n_0 ;
  wire \u8/dout[14]_i_1_n_0 ;
  wire \u8/dout[14]_i_2_n_0 ;
  wire \u8/dout[15]_i_1_n_0 ;
  wire \u8/dout[15]_i_2_n_0 ;
  wire \u8/dout[16]_i_1_n_0 ;
  wire \u8/dout[16]_i_2_n_0 ;
  wire \u8/dout[17]_i_1_n_0 ;
  wire \u8/dout[17]_i_2_n_0 ;
  wire \u8/dout[18]_i_1_n_0 ;
  wire \u8/dout[18]_i_2_n_0 ;
  wire \u8/dout[19]_i_3_n_0 ;
  wire \u8/dout[19]_i_4_n_0 ;
  wire \u8/dout[1]_i_1_n_0 ;
  wire \u8/dout[2]_i_1_n_0 ;
  wire \u8/dout[3]_i_1_n_0 ;
  wire \u8/dout[4]_i_1_n_0 ;
  wire \u8/dout[4]_i_2_n_0 ;
  wire \u8/dout[5]_i_1_n_0 ;
  wire \u8/dout[5]_i_2_n_0 ;
  wire \u8/dout[6]_i_1_n_0 ;
  wire \u8/dout[6]_i_2_n_0 ;
  wire \u8/dout[7]_i_1_n_0 ;
  wire \u8/dout[7]_i_2_n_0 ;
  wire \u8/dout[8]_i_1_n_0 ;
  wire \u8/dout[8]_i_2_n_0 ;
  wire \u8/dout[9]_i_1_n_0 ;
  wire \u8/dout[9]_i_2_n_0 ;
  wire \u8/empty0 ;
  wire [1:0]\u8/p_0_in ;
  wire \u8/p_1_in ;
  wire \u8/rp_reg_n_0_[0] ;
  wire \u8/rp_reg_n_0_[3] ;
  wire [1:1]\u8/status0 ;
  wire \u8/wp_reg_n_0_[0] ;
  wire \u8/wp_reg_n_0_[1] ;
  wire [31:0]\u9/din_tmp ;
  wire [15:0]\u9/din_tmp1 ;
  wire \u9/din_tmp10 ;
  wire \u9/empty0 ;
  wire \u9/full0 ;
  wire [1:0]\u9/p_1_in ;
  wire \u9/rp_reg_n_0_[0] ;
  wire \u9/rp_reg_n_0_[1] ;
  wire \u9/rp_reg_n_0_[2] ;
  wire [1:1]\u9/status0 ;
  wire \u9/wp_reg_n_0_[0] ;
  wire \u9/wp_reg_n_0_[3] ;
  wire valid;
  wire valid_i_1_n_0;
  wire valid_s;
  wire valid_s1;
  wire wb_ack_o;
  wire wb_ack_o_i_2_n_0;
  wire wb_ack_o_i_3_n_0;
  wire [31:0]wb_addr_i;
  wire wb_cyc_i;
  wire [31:0]wb_data_i;
  wire [31:0]wb_data_o;
  wire \wb_data_o[0]_i_1_n_0 ;
  wire \wb_data_o[0]_i_2_n_0 ;
  wire \wb_data_o[0]_i_3_n_0 ;
  wire \wb_data_o[0]_i_4_n_0 ;
  wire \wb_data_o[10]_i_1_n_0 ;
  wire \wb_data_o[10]_i_2_n_0 ;
  wire \wb_data_o[10]_i_3_n_0 ;
  wire \wb_data_o[10]_i_4_n_0 ;
  wire \wb_data_o[11]_i_1_n_0 ;
  wire \wb_data_o[11]_i_2_n_0 ;
  wire \wb_data_o[11]_i_3_n_0 ;
  wire \wb_data_o[11]_i_4_n_0 ;
  wire \wb_data_o[12]_i_1_n_0 ;
  wire \wb_data_o[12]_i_2_n_0 ;
  wire \wb_data_o[12]_i_3_n_0 ;
  wire \wb_data_o[12]_i_4_n_0 ;
  wire \wb_data_o[13]_i_1_n_0 ;
  wire \wb_data_o[13]_i_2_n_0 ;
  wire \wb_data_o[13]_i_3_n_0 ;
  wire \wb_data_o[13]_i_4_n_0 ;
  wire \wb_data_o[14]_i_1_n_0 ;
  wire \wb_data_o[14]_i_2_n_0 ;
  wire \wb_data_o[14]_i_3_n_0 ;
  wire \wb_data_o[14]_i_4_n_0 ;
  wire \wb_data_o[15]_i_1_n_0 ;
  wire \wb_data_o[15]_i_2_n_0 ;
  wire \wb_data_o[15]_i_3_n_0 ;
  wire \wb_data_o[15]_i_4_n_0 ;
  wire \wb_data_o[16]_i_1_n_0 ;
  wire \wb_data_o[16]_i_2_n_0 ;
  wire \wb_data_o[16]_i_3_n_0 ;
  wire \wb_data_o[17]_i_1_n_0 ;
  wire \wb_data_o[17]_i_2_n_0 ;
  wire \wb_data_o[17]_i_3_n_0 ;
  wire \wb_data_o[18]_i_1_n_0 ;
  wire \wb_data_o[18]_i_2_n_0 ;
  wire \wb_data_o[18]_i_3_n_0 ;
  wire \wb_data_o[19]_i_1_n_0 ;
  wire \wb_data_o[19]_i_2_n_0 ;
  wire \wb_data_o[19]_i_3_n_0 ;
  wire \wb_data_o[1]_i_1_n_0 ;
  wire \wb_data_o[1]_i_2_n_0 ;
  wire \wb_data_o[1]_i_3_n_0 ;
  wire \wb_data_o[1]_i_4_n_0 ;
  wire \wb_data_o[1]_i_5_n_0 ;
  wire \wb_data_o[20]_i_1_n_0 ;
  wire \wb_data_o[20]_i_2_n_0 ;
  wire \wb_data_o[20]_i_3_n_0 ;
  wire \wb_data_o[21]_i_1_n_0 ;
  wire \wb_data_o[21]_i_2_n_0 ;
  wire \wb_data_o[21]_i_3_n_0 ;
  wire \wb_data_o[22]_i_1_n_0 ;
  wire \wb_data_o[22]_i_2_n_0 ;
  wire \wb_data_o[22]_i_3_n_0 ;
  wire \wb_data_o[23]_i_1_n_0 ;
  wire \wb_data_o[23]_i_2_n_0 ;
  wire \wb_data_o[23]_i_3_n_0 ;
  wire \wb_data_o[23]_i_4_n_0 ;
  wire \wb_data_o[23]_i_5_n_0 ;
  wire \wb_data_o[24]_i_1_n_0 ;
  wire \wb_data_o[24]_i_2_n_0 ;
  wire \wb_data_o[24]_i_3_n_0 ;
  wire \wb_data_o[25]_i_1_n_0 ;
  wire \wb_data_o[25]_i_2_n_0 ;
  wire \wb_data_o[25]_i_3_n_0 ;
  wire \wb_data_o[26]_i_1_n_0 ;
  wire \wb_data_o[26]_i_2_n_0 ;
  wire \wb_data_o[26]_i_3_n_0 ;
  wire \wb_data_o[27]_i_1_n_0 ;
  wire \wb_data_o[27]_i_2_n_0 ;
  wire \wb_data_o[27]_i_3_n_0 ;
  wire \wb_data_o[28]_i_1_n_0 ;
  wire \wb_data_o[28]_i_2_n_0 ;
  wire \wb_data_o[28]_i_3_n_0 ;
  wire \wb_data_o[29]_i_1_n_0 ;
  wire \wb_data_o[29]_i_2_n_0 ;
  wire \wb_data_o[2]_i_1_n_0 ;
  wire \wb_data_o[2]_i_2_n_0 ;
  wire \wb_data_o[2]_i_3_n_0 ;
  wire \wb_data_o[2]_i_4_n_0 ;
  wire \wb_data_o[30]_i_1_n_0 ;
  wire \wb_data_o[30]_i_2_n_0 ;
  wire \wb_data_o[30]_i_3_n_0 ;
  wire \wb_data_o[31]_i_1_n_0 ;
  wire \wb_data_o[31]_i_2_n_0 ;
  wire \wb_data_o[31]_i_3_n_0 ;
  wire \wb_data_o[3]_i_1_n_0 ;
  wire \wb_data_o[3]_i_2_n_0 ;
  wire \wb_data_o[3]_i_3_n_0 ;
  wire \wb_data_o[3]_i_4_n_0 ;
  wire \wb_data_o[4]_i_1_n_0 ;
  wire \wb_data_o[4]_i_2_n_0 ;
  wire \wb_data_o[4]_i_3_n_0 ;
  wire \wb_data_o[4]_i_4_n_0 ;
  wire \wb_data_o[5]_i_1_n_0 ;
  wire \wb_data_o[5]_i_2_n_0 ;
  wire \wb_data_o[5]_i_3_n_0 ;
  wire \wb_data_o[5]_i_4_n_0 ;
  wire \wb_data_o[6]_i_1_n_0 ;
  wire \wb_data_o[6]_i_2_n_0 ;
  wire \wb_data_o[6]_i_3_n_0 ;
  wire \wb_data_o[6]_i_4_n_0 ;
  wire \wb_data_o[7]_i_1_n_0 ;
  wire \wb_data_o[7]_i_2_n_0 ;
  wire \wb_data_o[7]_i_3_n_0 ;
  wire \wb_data_o[7]_i_4_n_0 ;
  wire \wb_data_o[8]_i_1_n_0 ;
  wire \wb_data_o[8]_i_2_n_0 ;
  wire \wb_data_o[8]_i_3_n_0 ;
  wire \wb_data_o[8]_i_4_n_0 ;
  wire \wb_data_o[9]_i_1_n_0 ;
  wire \wb_data_o[9]_i_2_n_0 ;
  wire \wb_data_o[9]_i_3_n_0 ;
  wire \wb_data_o[9]_i_4_n_0 ;
  wire [31:0]wb_din;
  wire wb_stb_i;
  wire wb_we_i;
  wire we1_i_2_n_0;
  wire \wp[0]_i_1__0_n_0 ;
  wire \wp[0]_i_1__1_n_0 ;
  wire \wp[0]_i_1__2_n_0 ;
  wire \wp[0]_i_1__3_n_0 ;
  wire \wp[0]_i_1__4_n_0 ;
  wire \wp[0]_i_1__5_n_0 ;
  wire \wp[0]_i_1__6_n_0 ;
  wire \wp[0]_i_1__7_n_0 ;
  wire \wp[0]_i_1_n_0 ;
  wire \wp[1]_i_1__0_n_0 ;
  wire \wp[1]_i_1__1_n_0 ;
  wire \wp[1]_i_1__2_n_0 ;
  wire \wp[1]_i_1__3_n_0 ;
  wire \wp[1]_i_1__4_n_0 ;
  wire \wp[1]_i_1_n_0 ;
  wire \wp[2]_i_1__0_n_0 ;
  wire \wp[2]_i_1__1_n_0 ;
  wire \wp[2]_i_1__2_n_0 ;
  wire \wp[2]_i_1__3_n_0 ;
  wire \wp[2]_i_1__4_n_0 ;
  wire \wp[2]_i_1_n_0 ;
  wire \wp[3]_i_1__0_n_0 ;
  wire \wp[3]_i_1__1_n_0 ;
  wire \wp[3]_i_1_n_0 ;
  wire [3:1]wp_p1;
  wire [3:1]wp_p1__0;
  wire [3:1]wp_p1__1;

  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  LUT5 #(
    .INIT(32'h55550100)) 
    ac97_rst__i_1
       (.I0(ac97_rst_force),
        .I1(\u26/cnt [0]),
        .I2(\u26/cnt [1]),
        .I3(\u26/cnt [2]),
        .I4(ac97_reset_pad_o_),
        .O(ac97_rst__i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT5 #(
    .INIT(32'h00000008)) 
    ac97_rst_force_i_1
       (.I0(wb_din[0]),
        .I1(rf_we),
        .I2(wb_addr_i[2]),
        .I3(wb_addr_i[3]),
        .I4(wb_addr_i[4]),
        .O(ac97_rst_force_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    bit_clk_e_i_1
       (.I0(\u2/bit_clk_r1 ),
        .I1(\u2/bit_clk_r ),
        .O(\u2/bit_clk_e0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h0000AA51)) 
    \cnt[0]_i_1 
       (.I0(\cnt[2]_i_2_n_0 ),
        .I1(\u26/cnt [2]),
        .I2(\u26/cnt [1]),
        .I3(\u26/cnt [0]),
        .I4(ac97_rst_force),
        .O(\cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair219" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \cnt[0]_i_1__0 
       (.I0(suspended_o),
        .I1(\u2/cnt_reg [0]),
        .O(\cnt[0]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT4 #(
    .INIT(16'h009C)) 
    \cnt[1]_i_1 
       (.I0(\cnt[2]_i_2_n_0 ),
        .I1(\u26/cnt [1]),
        .I2(\u26/cnt [0]),
        .I3(ac97_rst_force),
        .O(\cnt[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT3 #(
    .INIT(8'hF6)) 
    \cnt[1]_i_1__0 
       (.I0(\u2/cnt_reg [1]),
        .I1(\u2/cnt_reg [0]),
        .I2(suspended_o),
        .O(p_0_in__1__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h00009CCC)) 
    \cnt[2]_i_1 
       (.I0(\cnt[2]_i_2_n_0 ),
        .I1(\u26/cnt [2]),
        .I2(\u26/cnt [1]),
        .I3(\u26/cnt [0]),
        .I4(ac97_rst_force),
        .O(\cnt[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT4 #(
    .INIT(16'hFF6A)) 
    \cnt[2]_i_1__0 
       (.I0(\u2/cnt_reg [2]),
        .I1(\u2/cnt_reg [1]),
        .I2(\u2/cnt_reg [0]),
        .I3(suspended_o),
        .O(p_0_in__1__0[2]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFF7FF)) 
    \cnt[2]_i_2 
       (.I0(\u26/ps_cnt_reg [0]),
        .I1(\u26/ps_cnt_reg [4]),
        .I2(\u26/ps_cnt_reg [3]),
        .I3(\u26/ps_cnt_reg [5]),
        .I4(\u26/ps_cnt_reg [2]),
        .I5(\u26/ps_cnt_reg [1]),
        .O(\cnt[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'hFFFF6AAA)) 
    \cnt[3]_i_1 
       (.I0(\u2/cnt_reg [3]),
        .I1(\u2/cnt_reg [2]),
        .I2(\u2/cnt_reg [0]),
        .I3(\u2/cnt_reg [1]),
        .I4(suspended_o),
        .O(p_0_in__1__0[3]));
  LUT6 #(
    .INIT(64'hFFFFFFFF6AAAAAAA)) 
    \cnt[4]_i_1 
       (.I0(\u2/cnt_reg [4]),
        .I1(\u2/cnt_reg [3]),
        .I2(\u2/cnt_reg [1]),
        .I3(\u2/cnt_reg [2]),
        .I4(\u2/cnt_reg [0]),
        .I5(suspended_o),
        .O(p_0_in__1__0[4]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'hFF6A)) 
    \cnt[5]_i_1 
       (.I0(\u2/cnt_reg [5]),
        .I1(\cnt[7]_i_2_n_0 ),
        .I2(\u2/cnt_reg [4]),
        .I3(suspended_o),
        .O(p_0_in__1__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'hFFFF6AAA)) 
    \cnt[6]_i_1 
       (.I0(\u2/cnt_reg [6]),
        .I1(\cnt[7]_i_2_n_0 ),
        .I2(\u2/cnt_reg [5]),
        .I3(\u2/cnt_reg [4]),
        .I4(suspended_o),
        .O(p_0_in__1__0[6]));
  LUT6 #(
    .INIT(64'hFFFFFFFF6AAAAAAA)) 
    \cnt[7]_i_1 
       (.I0(\u2/cnt_reg [7]),
        .I1(\u2/cnt_reg [6]),
        .I2(\u2/cnt_reg [4]),
        .I3(\u2/cnt_reg [5]),
        .I4(\cnt[7]_i_2_n_0 ),
        .I5(suspended_o),
        .O(p_0_in__1__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \cnt[7]_i_2 
       (.I0(\u2/cnt_reg [3]),
        .I1(\u2/cnt_reg [1]),
        .I2(\u2/cnt_reg [2]),
        .I3(\u2/cnt_reg [0]),
        .O(\cnt[7]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0400)) 
    \crac_dout_r[15]_i_1 
       (.I0(wb_addr_i[2]),
        .I1(wb_addr_i[4]),
        .I2(wb_addr_i[3]),
        .I3(rf_we),
        .O(crac_we));
  LUT3 #(
    .INIT(8'h40)) 
    crac_rd_done_i_1
       (.I0(\u15/valid_r ),
        .I1(valid_s),
        .I2(\u15/rdd3 ),
        .O(\u15/crac_rd_done0 ));
  LUT6 #(
    .INIT(64'hFFFF8FFF88888888)) 
    crac_rd_i_1
       (.I0(crac_out[31]),
        .I1(\u15/crac_we_r ),
        .I2(\u15/rdd1 ),
        .I3(valid_s),
        .I4(\u15/valid_r ),
        .I5(\u15/crac_rd ),
        .O(crac_rd_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT4 #(
    .INIT(16'hEFE0)) 
    crac_valid_r_i_1
       (.I0(\u15/crac_rd ),
        .I1(crac_wr),
        .I2(valid_s),
        .I3(out_slt0[14]),
        .O(crac_valid_r_i_1_n_0));
  LUT5 #(
    .INIT(32'hF4FF4444)) 
    crac_wr_i_1
       (.I0(crac_out[31]),
        .I1(\u15/crac_we_r ),
        .I2(valid_s),
        .I3(\u15/valid_r ),
        .I4(crac_wr),
        .O(crac_wr_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    crac_wr_r_i_1
       (.I0(crac_wr),
        .I1(valid_s),
        .I2(out_slt0[13]),
        .O(crac_wr_r_i_1_n_0));
  LUT4 #(
    .INIT(16'h0040)) 
    \din_tmp1[15]_i_1 
       (.I0(\u14/u6/en_out_l2_reg_n_0 ),
        .I1(\u14/u6/en_out_l_reg_n_0 ),
        .I2(in_valid_s[0]),
        .I3(\u9/wp_reg_n_0_[0] ),
        .O(\u9/din_tmp10 ));
  LUT4 #(
    .INIT(16'h0040)) 
    \din_tmp1[15]_i_1__0 
       (.I0(\u14/u7/en_out_l2_reg_n_0 ),
        .I1(\u14/u7/en_out_l_reg_n_0 ),
        .I2(in_valid_s[1]),
        .I3(\u10/wp_reg_n_0_[0] ),
        .O(\u10/din_tmp10 ));
  LUT4 #(
    .INIT(16'h0040)) 
    \din_tmp1[15]_i_1__1 
       (.I0(\u14/u8/en_out_l2_reg_n_0 ),
        .I1(\u14/u8/en_out_l_reg_n_0 ),
        .I2(in_valid_s[2]),
        .I3(\u11/wp_reg_n_0_[0] ),
        .O(\u11/din_tmp10 ));
  LUT5 #(
    .INIT(32'h00FF0080)) 
    dma_req_i_1
       (.I0(\int_set[0]_i_1_n_0 ),
        .I1(\u16/u0/dma_req_r1 ),
        .I2(\u13/occ0_r_reg_n_0_[6] ),
        .I3(dma_ack_i[0]),
        .I4(dma_req_o[0]),
        .O(dma_req_i_1_n_0));
  LUT5 #(
    .INIT(32'h00FF0080)) 
    dma_req_i_1__0
       (.I0(\int_set[0]_i_1__0_n_0 ),
        .I1(\u16/u1/dma_req_r1 ),
        .I2(\u13/occ0_r_reg_n_0_[14] ),
        .I3(dma_ack_i[1]),
        .I4(dma_req_o[1]),
        .O(dma_req_i_1__0_n_0));
  LUT5 #(
    .INIT(32'h00FF0080)) 
    dma_req_i_1__1
       (.I0(\int_set[0]_i_1__1_n_0 ),
        .I1(\u16/u2/dma_req_r1 ),
        .I2(\u13/occ0_r_reg_n_0_[22] ),
        .I3(dma_ack_i[2]),
        .I4(dma_req_o[2]),
        .O(dma_req_i_1__1_n_0));
  LUT5 #(
    .INIT(32'h00FF0080)) 
    dma_req_i_1__2
       (.I0(\int_set[0]_i_1__2_n_0 ),
        .I1(\u16/u3/dma_req_r1 ),
        .I2(\u13/occ0_r_reg_n_0_[30] ),
        .I3(dma_ack_i[3]),
        .I4(dma_req_o[3]),
        .O(dma_req_i_1__2_n_0));
  LUT5 #(
    .INIT(32'h00FF0080)) 
    dma_req_i_1__3
       (.I0(\int_set[0]_i_1__3_n_0 ),
        .I1(\u16/u4/dma_req_r1 ),
        .I2(\u13/occ1_r_reg_n_0_[6] ),
        .I3(dma_ack_i[4]),
        .I4(dma_req_o[4]),
        .O(dma_req_i_1__3_n_0));
  LUT5 #(
    .INIT(32'h00FF0080)) 
    dma_req_i_1__4
       (.I0(\int_set[0]_i_1__4_n_0 ),
        .I1(\u16/u5/dma_req_r1 ),
        .I2(\u13/occ1_r_reg_n_0_[14] ),
        .I3(dma_ack_i[5]),
        .I4(dma_req_o[5]),
        .O(dma_req_i_1__4_n_0));
  LUT5 #(
    .INIT(32'h00FF0080)) 
    dma_req_i_1__5
       (.I0(\int_set[0]_i_1__5_n_0 ),
        .I1(\u16/u6/dma_req_r1 ),
        .I2(\u13/icc_r_reg_n_0_[6] ),
        .I3(dma_ack_i[6]),
        .I4(dma_req_o[6]),
        .O(dma_req_i_1__5_n_0));
  LUT5 #(
    .INIT(32'h00FF0080)) 
    dma_req_i_1__6
       (.I0(\int_set[0]_i_1__6_n_0 ),
        .I1(\u16/u7/dma_req_r1 ),
        .I2(\u13/icc_r_reg_n_0_[14] ),
        .I3(dma_ack_i[7]),
        .I4(dma_req_o[7]),
        .O(dma_req_i_1__6_n_0));
  LUT5 #(
    .INIT(32'h00FF0080)) 
    dma_req_i_1__7
       (.I0(\int_set[0]_i_1__7_n_0 ),
        .I1(\u16/u8/dma_req_r1 ),
        .I2(\u13/icc_r_reg_n_0_[22] ),
        .I3(dma_ack_i[8]),
        .I4(dma_req_o[8]),
        .O(dma_req_i_1__7_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    dma_req_i_2
       (.I0(rst_i),
        .O(dma_req_i_2_n_0));
  LUT3 #(
    .INIT(8'h40)) 
    dma_req_r1_i_1
       (.I0(dma_ack_i[0]),
        .I1(\u13/occ0_r_reg_n_0_[6] ),
        .I2(\int_set[0]_i_1_n_0 ),
        .O(\u16/u0/dma_req_r10 ));
  LUT3 #(
    .INIT(8'h40)) 
    dma_req_r1_i_1__0
       (.I0(dma_ack_i[1]),
        .I1(\u13/occ0_r_reg_n_0_[14] ),
        .I2(\int_set[0]_i_1__0_n_0 ),
        .O(\u16/u1/dma_req_r10 ));
  LUT3 #(
    .INIT(8'h40)) 
    dma_req_r1_i_1__1
       (.I0(dma_ack_i[2]),
        .I1(\u13/occ0_r_reg_n_0_[22] ),
        .I2(\int_set[0]_i_1__1_n_0 ),
        .O(\u16/u2/dma_req_r10 ));
  LUT3 #(
    .INIT(8'h40)) 
    dma_req_r1_i_1__2
       (.I0(dma_ack_i[3]),
        .I1(\u13/occ0_r_reg_n_0_[30] ),
        .I2(\int_set[0]_i_1__2_n_0 ),
        .O(\u16/u3/dma_req_r10 ));
  LUT3 #(
    .INIT(8'h40)) 
    dma_req_r1_i_1__3
       (.I0(dma_ack_i[4]),
        .I1(\u13/occ1_r_reg_n_0_[6] ),
        .I2(\int_set[0]_i_1__3_n_0 ),
        .O(\u16/u4/dma_req_r10 ));
  LUT3 #(
    .INIT(8'h40)) 
    dma_req_r1_i_1__4
       (.I0(dma_ack_i[5]),
        .I1(\u13/occ1_r_reg_n_0_[14] ),
        .I2(\int_set[0]_i_1__4_n_0 ),
        .O(\u16/u5/dma_req_r10 ));
  LUT3 #(
    .INIT(8'h40)) 
    dma_req_r1_i_1__5
       (.I0(dma_ack_i[6]),
        .I1(\u13/icc_r_reg_n_0_[6] ),
        .I2(\int_set[0]_i_1__5_n_0 ),
        .O(\u16/u6/dma_req_r10 ));
  LUT3 #(
    .INIT(8'h40)) 
    dma_req_r1_i_1__6
       (.I0(dma_ack_i[7]),
        .I1(\u13/icc_r_reg_n_0_[14] ),
        .I2(\int_set[0]_i_1__6_n_0 ),
        .O(\u16/u7/dma_req_r10 ));
  LUT3 #(
    .INIT(8'h40)) 
    dma_req_r1_i_1__7
       (.I0(dma_ack_i[8]),
        .I1(\u13/icc_r_reg_n_0_[22] ),
        .I2(\int_set[0]_i_1__7_n_0 ),
        .O(\u16/u8/dma_req_r10 ));
  LUT1 #(
    .INIT(2'h1)) 
    \dout[19]_i_1 
       (.I0(\u13/occ0_r_reg_n_0_[0] ),
        .O(\dout[19]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \dout[19]_i_1__0 
       (.I0(\u13/occ0_r_reg_n_0_[8] ),
        .O(\dout[19]_i_1__0_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \dout[19]_i_1__1 
       (.I0(\u13/occ0_r_reg_n_0_[16] ),
        .O(\dout[19]_i_1__1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \dout[19]_i_1__2 
       (.I0(\u13/occ0_r_reg_n_0_[24] ),
        .O(\dout[19]_i_1__2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \dout[19]_i_1__3 
       (.I0(\u13/occ1_r_reg_n_0_[0] ),
        .O(\dout[19]_i_1__3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \dout[19]_i_1__4 
       (.I0(\u13/occ1_r_reg_n_0_[8] ),
        .O(\dout[19]_i_1__4_n_0 ));
  LUT3 #(
    .INIT(8'h40)) 
    \dout[19]_i_2 
       (.I0(\u14/u0/en_out_l2_reg_n_0 ),
        .I1(out_slt0[12]),
        .I2(valid_s),
        .O(o3_re));
  LUT3 #(
    .INIT(8'h40)) 
    \dout[19]_i_2__0 
       (.I0(\u14/u1/en_out_l2_reg_n_0 ),
        .I1(out_slt0[11]),
        .I2(valid_s),
        .O(o4_re));
  LUT3 #(
    .INIT(8'h40)) 
    \dout[19]_i_2__1 
       (.I0(\u14/u2/en_out_l2_reg_n_0 ),
        .I1(out_slt0[9]),
        .I2(valid_s),
        .O(o6_re));
  LUT3 #(
    .INIT(8'h40)) 
    \dout[19]_i_2__2 
       (.I0(\u14/u3/en_out_l2_reg_n_0 ),
        .I1(out_slt0[8]),
        .I2(valid_s),
        .O(o7_re));
  LUT3 #(
    .INIT(8'h40)) 
    \dout[19]_i_2__3 
       (.I0(\u14/u4/en_out_l2_reg_n_0 ),
        .I1(out_slt0[7]),
        .I2(valid_s),
        .O(o8_re));
  LUT3 #(
    .INIT(8'h40)) 
    \dout[19]_i_2__4 
       (.I0(\u14/u5/en_out_l2_reg_n_0 ),
        .I1(out_slt0[6]),
        .I2(valid_s),
        .O(o9_re));
  LUT6 #(
    .INIT(64'h6090609060900090)) 
    empty_i_1
       (.I0(\u3/wp_reg_n_0_[0] ),
        .I1(\u3/p_0_in [0]),
        .I2(empty_i_2_n_0),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(o3_mode[0]),
        .I5(o3_mode[1]),
        .O(\u3/empty0 ));
  LUT6 #(
    .INIT(64'h6090609060900090)) 
    empty_i_1__0
       (.I0(\u4/wp_reg_n_0_[0] ),
        .I1(\u4/p_0_in [0]),
        .I2(empty_i_2__0_n_0),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(o4_mode[0]),
        .I5(o4_mode[1]),
        .O(\u4/empty0 ));
  LUT6 #(
    .INIT(64'h6090609060900090)) 
    empty_i_1__1
       (.I0(\u5/wp_reg_n_0_[0] ),
        .I1(\u5/p_0_in [0]),
        .I2(empty_i_2__1_n_0),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(o6_mode[0]),
        .I5(o6_mode[1]),
        .O(\u5/empty0 ));
  LUT6 #(
    .INIT(64'h6090609060900090)) 
    empty_i_1__2
       (.I0(\u6/wp_reg_n_0_[0] ),
        .I1(\u6/p_0_in [0]),
        .I2(empty_i_2__2_n_0),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(o7_mode[0]),
        .I5(o7_mode[1]),
        .O(\u6/empty0 ));
  LUT6 #(
    .INIT(64'h6090609060900090)) 
    empty_i_1__3
       (.I0(\u7/wp_reg_n_0_[0] ),
        .I1(\u7/p_0_in [0]),
        .I2(empty_i_2__3_n_0),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(o8_mode[0]),
        .I5(o8_mode[1]),
        .O(\u7/empty0 ));
  LUT6 #(
    .INIT(64'h6090609060900090)) 
    empty_i_1__4
       (.I0(\u8/wp_reg_n_0_[0] ),
        .I1(\u8/p_0_in [0]),
        .I2(empty_i_2__4_n_0),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(o9_mode[0]),
        .I5(o9_mode[1]),
        .O(\u8/empty0 ));
  LUT6 #(
    .INIT(64'h0000000082000082)) 
    empty_i_1__5
       (.I0(\status[0]_i_1__7_n_0 ),
        .I1(\u9/p_1_in [1]),
        .I2(\u9/rp_reg_n_0_[1] ),
        .I3(\u9/wp_reg_n_0_[3] ),
        .I4(\u9/rp_reg_n_0_[2] ),
        .I5(empty_i_2__5_n_0),
        .O(\u9/empty0 ));
  LUT6 #(
    .INIT(64'h0000000082000082)) 
    empty_i_1__6
       (.I0(\status[0]_i_1__6_n_0 ),
        .I1(\u10/p_1_in [1]),
        .I2(\u10/rp_reg_n_0_[1] ),
        .I3(\u10/wp_reg_n_0_[3] ),
        .I4(\u10/rp_reg_n_0_[2] ),
        .I5(empty_i_2__6_n_0),
        .O(\u10/empty0 ));
  LUT6 #(
    .INIT(64'h0000000082000082)) 
    empty_i_1__7
       (.I0(\status[0]_i_1__5_n_0 ),
        .I1(\u11/p_1_in [1]),
        .I2(\u11/rp_reg_n_0_[1] ),
        .I3(\u11/wp_reg_n_0_[3] ),
        .I4(\u11/rp_reg_n_0_[2] ),
        .I5(empty_i_2__7_n_0),
        .O(\u11/empty0 ));
  LUT6 #(
    .INIT(64'h2A95400040002A95)) 
    empty_i_2
       (.I0(\u3/wp_reg_n_0_[1] ),
        .I1(\u3/rp_reg_n_0_[0] ),
        .I2(\u3/p_0_in [0]),
        .I3(\u3/p_0_in [1]),
        .I4(\u3/rp_reg_n_0_[3] ),
        .I5(\u3/p_1_in ),
        .O(empty_i_2_n_0));
  LUT6 #(
    .INIT(64'h2A95400040002A95)) 
    empty_i_2__0
       (.I0(\u4/wp_reg_n_0_[1] ),
        .I1(\u4/rp_reg_n_0_[0] ),
        .I2(\u4/p_0_in [0]),
        .I3(\u4/p_0_in [1]),
        .I4(\u4/rp_reg_n_0_[3] ),
        .I5(\u4/p_1_in ),
        .O(empty_i_2__0_n_0));
  LUT6 #(
    .INIT(64'h2A95400040002A95)) 
    empty_i_2__1
       (.I0(\u5/wp_reg_n_0_[1] ),
        .I1(\u5/rp_reg_n_0_[0] ),
        .I2(\u5/p_0_in [0]),
        .I3(\u5/p_0_in [1]),
        .I4(\u5/rp_reg_n_0_[3] ),
        .I5(\u5/p_1_in ),
        .O(empty_i_2__1_n_0));
  LUT6 #(
    .INIT(64'h2A95400040002A95)) 
    empty_i_2__2
       (.I0(\u6/wp_reg_n_0_[1] ),
        .I1(\u6/rp_reg_n_0_[0] ),
        .I2(\u6/p_0_in [0]),
        .I3(\u6/p_0_in [1]),
        .I4(\u6/rp_reg_n_0_[3] ),
        .I5(\u6/p_1_in ),
        .O(empty_i_2__2_n_0));
  LUT6 #(
    .INIT(64'h2A95400040002A95)) 
    empty_i_2__3
       (.I0(\u7/wp_reg_n_0_[1] ),
        .I1(\u7/rp_reg_n_0_[0] ),
        .I2(\u7/p_0_in [0]),
        .I3(\u7/p_0_in [1]),
        .I4(\u7/rp_reg_n_0_[3] ),
        .I5(\u7/p_1_in ),
        .O(empty_i_2__3_n_0));
  LUT6 #(
    .INIT(64'h2A95400040002A95)) 
    empty_i_2__4
       (.I0(\u8/wp_reg_n_0_[1] ),
        .I1(\u8/rp_reg_n_0_[0] ),
        .I2(\u8/p_0_in [0]),
        .I3(\u8/p_0_in [1]),
        .I4(\u8/rp_reg_n_0_[3] ),
        .I5(\u8/p_1_in ),
        .O(empty_i_2__4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair133" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    empty_i_2__5
       (.I0(i3_mode[1]),
        .I1(i3_mode[0]),
        .I2(\u9/wp_reg_n_0_[0] ),
        .O(empty_i_2__5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair134" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    empty_i_2__6
       (.I0(i4_mode[1]),
        .I1(i4_mode[0]),
        .I2(\u10/wp_reg_n_0_[0] ),
        .O(empty_i_2__6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair135" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    empty_i_2__7
       (.I0(i6_mode[1]),
        .I1(i6_mode[0]),
        .I2(\u11/wp_reg_n_0_[0] ),
        .O(empty_i_2__7_n_0));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h8)) 
    en_out_l2_i_1
       (.I0(valid_s),
        .I1(out_slt0[12]),
        .O(\u14/u0/en_out_l20 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h8)) 
    en_out_l2_i_1__0
       (.I0(valid_s),
        .I1(out_slt0[11]),
        .O(\u14/u1/en_out_l20 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h8)) 
    en_out_l2_i_1__1
       (.I0(valid_s),
        .I1(out_slt0[9]),
        .O(\u14/u2/en_out_l20 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h8)) 
    en_out_l2_i_1__2
       (.I0(valid_s),
        .I1(out_slt0[8]),
        .O(\u14/u3/en_out_l20 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h8)) 
    en_out_l2_i_1__3
       (.I0(valid_s),
        .I1(out_slt0[7]),
        .O(\u14/u4/en_out_l20 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h8)) 
    en_out_l2_i_1__4
       (.I0(valid_s),
        .I1(out_slt0[6]),
        .O(\u14/u5/en_out_l20 ));
  (* SOFT_HLUTNM = "soft_lutpair138" *) 
  LUT2 #(
    .INIT(4'h8)) 
    en_out_l2_i_1__5
       (.I0(\u14/u6/en_out_l_reg_n_0 ),
        .I1(in_valid_s[0]),
        .O(\u14/u6/en_out_l20 ));
  (* SOFT_HLUTNM = "soft_lutpair139" *) 
  LUT2 #(
    .INIT(4'h8)) 
    en_out_l2_i_1__6
       (.I0(\u14/u7/en_out_l_reg_n_0 ),
        .I1(in_valid_s[1]),
        .O(\u14/u7/en_out_l20 ));
  (* SOFT_HLUTNM = "soft_lutpair140" *) 
  LUT2 #(
    .INIT(4'h8)) 
    en_out_l2_i_1__7
       (.I0(\u14/u8/en_out_l_reg_n_0 ),
        .I1(in_valid_s[2]),
        .O(\u14/u8/en_out_l20 ));
  LUT4 #(
    .INIT(16'hDC40)) 
    en_out_l_i_1
       (.I0(en_out_l_i_2__4_n_0),
        .I1(valid_s),
        .I2(in_slt0[15]),
        .I3(out_slt0[6]),
        .O(en_out_l_i_1_n_0));
  LUT4 #(
    .INIT(16'hDC40)) 
    en_out_l_i_1__0
       (.I0(en_out_l_i_2__3_n_0),
        .I1(valid_s),
        .I2(in_slt0[15]),
        .I3(out_slt0[7]),
        .O(en_out_l_i_1__0_n_0));
  LUT4 #(
    .INIT(16'hDC40)) 
    en_out_l_i_1__1
       (.I0(en_out_l_i_2__2_n_0),
        .I1(valid_s),
        .I2(in_slt0[15]),
        .I3(out_slt0[8]),
        .O(en_out_l_i_1__1_n_0));
  LUT4 #(
    .INIT(16'hDC40)) 
    en_out_l_i_1__2
       (.I0(en_out_l_i_2__1_n_0),
        .I1(valid_s),
        .I2(in_slt0[15]),
        .I3(out_slt0[9]),
        .O(en_out_l_i_1__2_n_0));
  LUT4 #(
    .INIT(16'hDC40)) 
    en_out_l_i_1__3
       (.I0(en_out_l_i_2__0_n_0),
        .I1(valid_s),
        .I2(in_slt0[15]),
        .I3(out_slt0[11]),
        .O(en_out_l_i_1__3_n_0));
  LUT4 #(
    .INIT(16'hDC40)) 
    en_out_l_i_1__4
       (.I0(en_out_l_i_2_n_0),
        .I1(valid_s),
        .I2(in_slt0[15]),
        .I3(out_slt0[12]),
        .O(en_out_l_i_1__4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair138" *) 
  LUT3 #(
    .INIT(8'hD4)) 
    en_out_l_i_1__5
       (.I0(en_out_l_i_2__5_n_0),
        .I1(in_valid_s[0]),
        .I2(\u14/u6/en_out_l_reg_n_0 ),
        .O(en_out_l_i_1__5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair139" *) 
  LUT3 #(
    .INIT(8'hD4)) 
    en_out_l_i_1__6
       (.I0(en_out_l_i_2__6_n_0),
        .I1(in_valid_s[1]),
        .I2(\u14/u7/en_out_l_reg_n_0 ),
        .O(en_out_l_i_1__6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair140" *) 
  LUT3 #(
    .INIT(8'hD4)) 
    en_out_l_i_1__7
       (.I0(en_out_l_i_2__7_n_0),
        .I1(in_valid_s[2]),
        .I2(\u14/u8/en_out_l_reg_n_0 ),
        .O(en_out_l_i_1__7_n_0));
  LUT4 #(
    .INIT(16'hFDDD)) 
    en_out_l_i_2
       (.I0(\u13/occ0_r_reg_n_0_[0] ),
        .I1(\u14/u0/full_empty_r ),
        .I2(\u13/occ0_r_reg_n_0_[1] ),
        .I3(in_slt1[11]),
        .O(en_out_l_i_2_n_0));
  LUT4 #(
    .INIT(16'hFDDD)) 
    en_out_l_i_2__0
       (.I0(\u13/occ0_r_reg_n_0_[8] ),
        .I1(\u14/u1/full_empty_r ),
        .I2(\u13/occ0_r_reg_n_0_[9] ),
        .I3(in_slt1[10]),
        .O(en_out_l_i_2__0_n_0));
  LUT4 #(
    .INIT(16'hFDDD)) 
    en_out_l_i_2__1
       (.I0(\u13/occ0_r_reg_n_0_[16] ),
        .I1(\u14/u2/full_empty_r ),
        .I2(\u13/occ0_r_reg_n_0_[17] ),
        .I3(in_slt1[8]),
        .O(en_out_l_i_2__1_n_0));
  LUT4 #(
    .INIT(16'hFDDD)) 
    en_out_l_i_2__2
       (.I0(\u13/occ0_r_reg_n_0_[24] ),
        .I1(\u14/u3/full_empty_r ),
        .I2(\u13/occ0_r_reg_n_0_[25] ),
        .I3(in_slt1[7]),
        .O(en_out_l_i_2__2_n_0));
  LUT4 #(
    .INIT(16'hFDDD)) 
    en_out_l_i_2__3
       (.I0(\u13/occ1_r_reg_n_0_[0] ),
        .I1(\u14/u4/full_empty_r ),
        .I2(\u13/occ1_r_reg_n_0_[1] ),
        .I3(in_slt1[6]),
        .O(en_out_l_i_2__3_n_0));
  LUT4 #(
    .INIT(16'hFDDD)) 
    en_out_l_i_2__4
       (.I0(\u13/occ1_r_reg_n_0_[8] ),
        .I1(\u14/u5/full_empty_r ),
        .I2(\u13/occ1_r_reg_n_0_[9] ),
        .I3(in_slt1[5]),
        .O(en_out_l_i_2__4_n_0));
  LUT5 #(
    .INIT(32'hF4FFFFFF)) 
    en_out_l_i_2__5
       (.I0(in_slt0[12]),
        .I1(\u13/icc_r_reg_n_0_[1] ),
        .I2(\u14/u6/full_empty_r ),
        .I3(\u13/icc_r_reg_n_0_[0] ),
        .I4(in_slt0[15]),
        .O(en_out_l_i_2__5_n_0));
  LUT5 #(
    .INIT(32'hF4FFFFFF)) 
    en_out_l_i_2__6
       (.I0(in_slt0[11]),
        .I1(\u13/icc_r_reg_n_0_[9] ),
        .I2(\u14/u7/full_empty_r ),
        .I3(\u13/icc_r_reg_n_0_[8] ),
        .I4(in_slt0[15]),
        .O(en_out_l_i_2__6_n_0));
  LUT5 #(
    .INIT(32'hF4FFFFFF)) 
    en_out_l_i_2__7
       (.I0(in_slt0[9]),
        .I1(\u13/icc_r_reg_n_0_[17] ),
        .I2(\u14/u8/full_empty_r ),
        .I3(\u13/icc_r_reg_n_0_[16] ),
        .I4(in_slt0[15]),
        .O(en_out_l_i_2__7_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    full_empty_r_i_1
       (.I0(valid_s),
        .O(\u14/p_0_in ));
  LUT3 #(
    .INIT(8'hB8)) 
    full_empty_r_i_1__0
       (.I0(\u14/u6/full_empty_r ),
        .I1(in_valid_s[0]),
        .I2(i3_full),
        .O(full_empty_r_i_1__0_n_0));
  LUT3 #(
    .INIT(8'hB8)) 
    full_empty_r_i_1__1
       (.I0(\u14/u7/full_empty_r ),
        .I1(in_valid_s[1]),
        .I2(i4_full),
        .O(full_empty_r_i_1__1_n_0));
  LUT3 #(
    .INIT(8'hB8)) 
    full_empty_r_i_1__2
       (.I0(\u14/u8/full_empty_r ),
        .I1(in_valid_s[2]),
        .I2(i6_full),
        .O(full_empty_r_i_1__2_n_0));
  LUT6 #(
    .INIT(64'h6006000000006006)) 
    full_i_1
       (.I0(\u9/rp_reg_n_0_[2] ),
        .I1(\u9/wp_reg_n_0_[3] ),
        .I2(\u9/rp_reg_n_0_[1] ),
        .I3(\u9/p_1_in [1]),
        .I4(\u9/p_1_in [0]),
        .I5(\u9/rp_reg_n_0_[0] ),
        .O(\u9/full0 ));
  LUT6 #(
    .INIT(64'h6006000000006006)) 
    full_i_1__0
       (.I0(\u10/rp_reg_n_0_[2] ),
        .I1(\u10/wp_reg_n_0_[3] ),
        .I2(\u10/rp_reg_n_0_[1] ),
        .I3(\u10/p_1_in [1]),
        .I4(\u10/p_1_in [0]),
        .I5(\u10/rp_reg_n_0_[0] ),
        .O(\u10/full0 ));
  LUT6 #(
    .INIT(64'h6006000000006006)) 
    full_i_1__1
       (.I0(\u11/rp_reg_n_0_[2] ),
        .I1(\u11/wp_reg_n_0_[3] ),
        .I2(\u11/rp_reg_n_0_[1] ),
        .I3(\u11/p_1_in [1]),
        .I4(\u11/p_1_in [0]),
        .I5(\u11/rp_reg_n_0_[0] ),
        .O(\u11/full0 ));
  LUT6 #(
    .INIT(64'h0000000010000000)) 
    i3_re_i_1
       (.I0(wb_addr_i[2]),
        .I1(wb_addr_i[6]),
        .I2(wb_addr_i[5]),
        .I3(wb_addr_i[3]),
        .I4(wb_addr_i[4]),
        .I5(wb_ack_o_i_3_n_0),
        .O(\u12/i3_re0 ));
  LUT6 #(
    .INIT(64'h0000000040000000)) 
    i4_re_i_1
       (.I0(wb_addr_i[6]),
        .I1(wb_addr_i[5]),
        .I2(wb_addr_i[2]),
        .I3(wb_addr_i[3]),
        .I4(wb_addr_i[4]),
        .I5(wb_ack_o_i_3_n_0),
        .O(\u12/i4_re0 ));
  LUT6 #(
    .INIT(64'h0008000000000000)) 
    i6_re_i_1
       (.I0(\wb_data_o[31]_i_3_n_0 ),
        .I1(\u12/re1 ),
        .I2(wb_we_i),
        .I3(\u12/re2 ),
        .I4(wb_stb_i),
        .I5(wb_cyc_i),
        .O(\u12/i6_re0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \icc_r[23]_i_1 
       (.I0(wb_addr_i[2]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(rf_we),
        .O(\u13/icc_r0 ));
  LUT6 #(
    .INIT(64'hFEEEAAAAEEEEAAAA)) 
    \in_valid[0]_i_1 
       (.I0(\u2/cnt_reg [7]),
        .I1(\out_le[3]_i_2_n_0 ),
        .I2(\u2/cnt_reg [1]),
        .I3(\u2/cnt_reg [3]),
        .I4(\u2/cnt_reg [6]),
        .I5(\u2/cnt_reg [2]),
        .O(\u2/p_0_in ));
  LUT6 #(
    .INIT(64'hFFFEAAAAAAAAAAAA)) 
    \in_valid[1]_i_1 
       (.I0(\u2/cnt_reg [7]),
        .I1(\u2/cnt_reg [4]),
        .I2(\out_le[2]_i_2_n_0 ),
        .I3(\u2/cnt_reg [3]),
        .I4(\u2/cnt_reg [6]),
        .I5(\u2/cnt_reg [5]),
        .O(\in_valid[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFF00FF00FF00E000)) 
    \in_valid[2]_i_1 
       (.I0(\u2/cnt_reg [1]),
        .I1(\u2/cnt_reg [2]),
        .I2(\u2/cnt_reg [3]),
        .I3(\u2/cnt_reg [7]),
        .I4(\out_le[3]_i_2_n_0 ),
        .I5(\u2/cnt_reg [6]),
        .O(\in_valid[2]_i_1_n_0 ));
  FDRE \in_valid_s1_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(in_valid[0]),
        .Q(in_valid_s1[0]),
        .R(\<const0> ));
  FDRE \in_valid_s1_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(in_valid[1]),
        .Q(in_valid_s1[1]),
        .R(\<const0> ));
  FDRE \in_valid_s1_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(in_valid[2]),
        .Q(in_valid_s1[2]),
        .R(\<const0> ));
  FDRE \in_valid_s_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(in_valid_s1[0]),
        .Q(in_valid_s[0]),
        .R(\<const0> ));
  FDRE \in_valid_s_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(in_valid_s1[1]),
        .Q(in_valid_s[1]),
        .R(\<const0> ));
  FDRE \in_valid_s_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(in_valid_s1[2]),
        .Q(in_valid_s[2]),
        .R(\<const0> ));
  LUT3 #(
    .INIT(8'hFE)) 
    int_i_1
       (.I0(int_i_2_n_0),
        .I1(int_i_3_n_0),
        .I2(int_i_4_n_0),
        .O(int_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    int_i_10
       (.I0(\u13/intm [16]),
        .I1(\u13/ints [16]),
        .I2(\u13/intm [15]),
        .I3(\u13/ints [15]),
        .I4(\u13/ints [14]),
        .I5(\u13/intm [14]),
        .O(int_i_10_n_0));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    int_i_11
       (.I0(\u13/intm [10]),
        .I1(\u13/ints [10]),
        .I2(\u13/intm [9]),
        .I3(\u13/ints [9]),
        .I4(\u13/ints [8]),
        .I5(\u13/intm [8]),
        .O(int_i_11_n_0));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    int_i_12
       (.I0(\u13/intm [7]),
        .I1(\u13/ints [7]),
        .I2(\u13/intm [6]),
        .I3(\u13/ints [6]),
        .I4(\u13/ints [5]),
        .I5(\u13/intm [5]),
        .O(int_i_12_n_0));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    int_i_2
       (.I0(\u13/intm [4]),
        .I1(\u13/ints [4]),
        .I2(\u13/intm [3]),
        .I3(\u13/ints [3]),
        .I4(\u13/ints [2]),
        .I5(\u13/intm [2]),
        .O(int_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFF888)) 
    int_i_3
       (.I0(\u13/intm [1]),
        .I1(\u13/ints [1]),
        .I2(\u13/intm [0]),
        .I3(\u13/ints [0]),
        .I4(int_i_5_n_0),
        .I5(int_i_6_n_0),
        .O(int_i_3_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    int_i_4
       (.I0(int_i_7_n_0),
        .I1(int_i_8_n_0),
        .I2(int_i_9_n_0),
        .I3(int_i_10_n_0),
        .I4(int_i_11_n_0),
        .I5(int_i_12_n_0),
        .O(int_i_4_n_0));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    int_i_5
       (.I0(\u13/intm [28]),
        .I1(\u13/ints [28]),
        .I2(\u13/intm [27]),
        .I3(\u13/ints [27]),
        .I4(\u13/ints [26]),
        .I5(\u13/intm [26]),
        .O(int_i_5_n_0));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    int_i_6
       (.I0(\u13/intm [25]),
        .I1(\u13/ints [25]),
        .I2(\u13/intm [24]),
        .I3(\u13/ints [24]),
        .I4(\u13/ints [23]),
        .I5(\u13/intm [23]),
        .O(int_i_6_n_0));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    int_i_7
       (.I0(\u13/intm [19]),
        .I1(\u13/ints [19]),
        .I2(\u13/intm [18]),
        .I3(\u13/ints [18]),
        .I4(\u13/ints [17]),
        .I5(\u13/intm [17]),
        .O(int_i_7_n_0));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    int_i_8
       (.I0(\u13/intm [22]),
        .I1(\u13/ints [22]),
        .I2(\u13/intm [21]),
        .I3(\u13/ints [21]),
        .I4(\u13/ints [20]),
        .I5(\u13/intm [20]),
        .O(int_i_8_n_0));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    int_i_9
       (.I0(\u13/intm [13]),
        .I1(\u13/ints [13]),
        .I2(\u13/intm [12]),
        .I3(\u13/ints [12]),
        .I4(\u13/ints [11]),
        .I5(\u13/intm [11]),
        .O(int_i_9_n_0));
  LUT6 #(
    .INIT(64'hFFFF111700000000)) 
    \int_set[0]_i_1 
       (.I0(o3_status[1]),
        .I1(\u13/occ0_r_reg_n_0_[5] ),
        .I2(o3_status[0]),
        .I3(\u13/occ0_r_reg_n_0_[4] ),
        .I4(o3_empty),
        .I5(\u13/occ0_r_reg_n_0_[0] ),
        .O(\int_set[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAABABFF00000000)) 
    \int_set[0]_i_1__0 
       (.I0(o4_empty),
        .I1(o4_status[0]),
        .I2(\u13/occ0_r_reg_n_0_[12] ),
        .I3(\u13/occ0_r_reg_n_0_[13] ),
        .I4(o4_status[1]),
        .I5(\u13/occ0_r_reg_n_0_[8] ),
        .O(\int_set[0]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'hAAABABFF00000000)) 
    \int_set[0]_i_1__1 
       (.I0(o6_empty),
        .I1(o6_status[0]),
        .I2(\u13/occ0_r_reg_n_0_[20] ),
        .I3(\u13/occ0_r_reg_n_0_[21] ),
        .I4(o6_status[1]),
        .I5(\u13/occ0_r_reg_n_0_[16] ),
        .O(\int_set[0]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'hAAABABFF00000000)) 
    \int_set[0]_i_1__2 
       (.I0(o7_empty),
        .I1(o7_status[0]),
        .I2(\u13/occ0_r_reg_n_0_[28] ),
        .I3(\u13/occ0_r_reg_n_0_[29] ),
        .I4(o7_status[1]),
        .I5(\u13/occ0_r_reg_n_0_[24] ),
        .O(\int_set[0]_i_1__2_n_0 ));
  LUT6 #(
    .INIT(64'hAAABABFF00000000)) 
    \int_set[0]_i_1__3 
       (.I0(o8_empty),
        .I1(o8_status[0]),
        .I2(\u13/occ1_r_reg_n_0_[4] ),
        .I3(\u13/occ1_r_reg_n_0_[5] ),
        .I4(o8_status[1]),
        .I5(\u13/occ1_r_reg_n_0_[0] ),
        .O(\int_set[0]_i_1__3_n_0 ));
  LUT6 #(
    .INIT(64'hAAABABFF00000000)) 
    \int_set[0]_i_1__4 
       (.I0(o9_empty),
        .I1(o9_status[0]),
        .I2(\u13/occ1_r_reg_n_0_[12] ),
        .I3(\u13/occ1_r_reg_n_0_[13] ),
        .I4(o9_status[1]),
        .I5(\u13/occ1_r_reg_n_0_[8] ),
        .O(\int_set[0]_i_1__4_n_0 ));
  LUT6 #(
    .INIT(64'hAAABABFF00000000)) 
    \int_set[0]_i_1__5 
       (.I0(i3_full),
        .I1(i3_status[0]),
        .I2(\u13/icc_r_reg_n_0_[4] ),
        .I3(\u13/icc_r_reg_n_0_[5] ),
        .I4(i3_status[1]),
        .I5(\u13/icc_r_reg_n_0_[0] ),
        .O(\int_set[0]_i_1__5_n_0 ));
  LUT6 #(
    .INIT(64'hAAABABFF00000000)) 
    \int_set[0]_i_1__6 
       (.I0(i4_full),
        .I1(i4_status[0]),
        .I2(\u13/icc_r_reg_n_0_[12] ),
        .I3(\u13/icc_r_reg_n_0_[13] ),
        .I4(i4_status[1]),
        .I5(\u13/icc_r_reg_n_0_[8] ),
        .O(\int_set[0]_i_1__6_n_0 ));
  LUT6 #(
    .INIT(64'hAAABABFF00000000)) 
    \int_set[0]_i_1__7 
       (.I0(i6_full),
        .I1(i6_status[0]),
        .I2(\u13/icc_r_reg_n_0_[20] ),
        .I3(\u13/icc_r_reg_n_0_[21] ),
        .I4(i6_status[1]),
        .I5(\u13/icc_r_reg_n_0_[16] ),
        .O(\int_set[0]_i_1__7_n_0 ));
  LUT4 #(
    .INIT(16'h2000)) 
    \int_set[1]_i_1 
       (.I0(o3_empty),
        .I1(\u14/u0/en_out_l2_reg_n_0 ),
        .I2(out_slt0[12]),
        .I3(valid_s),
        .O(\u17/int_set_reg00_out ));
  LUT4 #(
    .INIT(16'h2000)) 
    \int_set[1]_i_1__0 
       (.I0(o4_empty),
        .I1(\u14/u1/en_out_l2_reg_n_0 ),
        .I2(out_slt0[11]),
        .I3(valid_s),
        .O(\u18/int_set_reg00_out ));
  LUT4 #(
    .INIT(16'h2000)) 
    \int_set[1]_i_1__1 
       (.I0(o6_empty),
        .I1(\u14/u2/en_out_l2_reg_n_0 ),
        .I2(out_slt0[9]),
        .I3(valid_s),
        .O(\u19/int_set_reg00_out ));
  LUT4 #(
    .INIT(16'h2000)) 
    \int_set[1]_i_1__2 
       (.I0(o7_empty),
        .I1(\u14/u3/en_out_l2_reg_n_0 ),
        .I2(out_slt0[8]),
        .I3(valid_s),
        .O(\u20/int_set_reg00_out ));
  LUT4 #(
    .INIT(16'h2000)) 
    \int_set[1]_i_1__3 
       (.I0(o8_empty),
        .I1(\u14/u4/en_out_l2_reg_n_0 ),
        .I2(out_slt0[7]),
        .I3(valid_s),
        .O(\u21/int_set_reg00_out ));
  LUT4 #(
    .INIT(16'h2000)) 
    \int_set[1]_i_1__4 
       (.I0(o9_empty),
        .I1(\u14/u5/en_out_l2_reg_n_0 ),
        .I2(out_slt0[6]),
        .I3(valid_s),
        .O(\u22/int_set_reg00_out ));
  LUT2 #(
    .INIT(4'h8)) 
    \int_set[1]_i_1__5 
       (.I0(i3_empty),
        .I1(i3_re),
        .O(\u23/int_set_reg00_out ));
  LUT2 #(
    .INIT(4'h8)) 
    \int_set[1]_i_1__6 
       (.I0(i4_empty),
        .I1(i4_re),
        .O(\u24/int_set_reg00_out ));
  LUT2 #(
    .INIT(4'h8)) 
    \int_set[1]_i_1__7 
       (.I0(i6_empty),
        .I1(i6_re),
        .O(\u25/int_set_reg00_out ));
  LUT4 #(
    .INIT(16'h4000)) 
    \int_set[2]_i_1 
       (.I0(\u14/u6/en_out_l2_reg_n_0 ),
        .I1(\u14/u6/en_out_l_reg_n_0 ),
        .I2(in_valid_s[0]),
        .I3(i3_full),
        .O(\u23/int_set_reg0 ));
  LUT4 #(
    .INIT(16'h4000)) 
    \int_set[2]_i_1__0 
       (.I0(\u14/u7/en_out_l2_reg_n_0 ),
        .I1(\u14/u7/en_out_l_reg_n_0 ),
        .I2(in_valid_s[1]),
        .I3(i4_full),
        .O(\u24/int_set_reg0 ));
  LUT4 #(
    .INIT(16'h4000)) 
    \int_set[2]_i_1__1 
       (.I0(\u14/u8/en_out_l2_reg_n_0 ),
        .I1(\u14/u8/en_out_l_reg_n_0 ),
        .I2(in_valid_s[2]),
        .I3(i6_full),
        .O(\u25/int_set_reg0 ));
  LUT6 #(
    .INIT(64'h0090900000000000)) 
    \int_set[2]_i_1__2 
       (.I0(\u3/wp_reg_n_0_[1] ),
        .I1(\u3/p_0_in [1]),
        .I2(o3_we),
        .I3(\u3/p_1_in ),
        .I4(\u3/rp_reg_n_0_[3] ),
        .I5(\status[0]_i_1_n_0 ),
        .O(\u17/int_set_reg0 ));
  LUT6 #(
    .INIT(64'h0090900000000000)) 
    \int_set[2]_i_1__3 
       (.I0(\u4/wp_reg_n_0_[1] ),
        .I1(\u4/p_0_in [1]),
        .I2(o4_we),
        .I3(\u4/p_1_in ),
        .I4(\u4/rp_reg_n_0_[3] ),
        .I5(\status[0]_i_1__0_n_0 ),
        .O(\u18/int_set_reg0 ));
  LUT6 #(
    .INIT(64'h0090900000000000)) 
    \int_set[2]_i_1__4 
       (.I0(\u5/wp_reg_n_0_[1] ),
        .I1(\u5/p_0_in [1]),
        .I2(o6_we),
        .I3(\u5/p_1_in ),
        .I4(\u5/rp_reg_n_0_[3] ),
        .I5(\status[0]_i_1__1_n_0 ),
        .O(\u19/int_set_reg0 ));
  LUT6 #(
    .INIT(64'h0090900000000000)) 
    \int_set[2]_i_1__5 
       (.I0(\u6/wp_reg_n_0_[1] ),
        .I1(\u6/p_0_in [1]),
        .I2(o7_we),
        .I3(\u6/p_1_in ),
        .I4(\u6/rp_reg_n_0_[3] ),
        .I5(\status[0]_i_1__2_n_0 ),
        .O(\u20/int_set_reg0 ));
  LUT6 #(
    .INIT(64'h0090900000000000)) 
    \int_set[2]_i_1__6 
       (.I0(\u7/wp_reg_n_0_[1] ),
        .I1(\u7/p_0_in [1]),
        .I2(o8_we),
        .I3(\u7/p_1_in ),
        .I4(\u7/rp_reg_n_0_[3] ),
        .I5(\status[0]_i_1__3_n_0 ),
        .O(\u21/int_set_reg0 ));
  LUT6 #(
    .INIT(64'h0090900000000000)) 
    \int_set[2]_i_1__7 
       (.I0(\u8/wp_reg_n_0_[1] ),
        .I1(\u8/p_0_in [1]),
        .I2(o9_we),
        .I3(\u8/p_1_in ),
        .I4(\u8/rp_reg_n_0_[3] ),
        .I5(\status[0]_i_1__4_n_0 ),
        .O(\u22/int_set_reg0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \intm_r[28]_i_1 
       (.I0(wb_addr_i[2]),
        .I1(wb_addr_i[4]),
        .I2(wb_addr_i[3]),
        .I3(rf_we),
        .O(\u13/intm_r0 ));
  (* SOFT_HLUTNM = "soft_lutpair124" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[0]_i_1 
       (.I0(crac_rd_done),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [0]),
        .O(\ints_r[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair120" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[10]_i_1 
       (.I0(oc2_int_set[2]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [10]),
        .O(\ints_r[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair119" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[11]_i_1 
       (.I0(oc3_int_set[0]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [11]),
        .O(\ints_r[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair119" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[12]_i_1 
       (.I0(oc3_int_set[1]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [12]),
        .O(\ints_r[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair118" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[13]_i_1 
       (.I0(oc3_int_set[2]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [13]),
        .O(\ints_r[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair118" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[14]_i_1 
       (.I0(oc4_int_set[0]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [14]),
        .O(\ints_r[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair117" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[15]_i_1 
       (.I0(oc4_int_set[1]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [15]),
        .O(\ints_r[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair117" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[16]_i_1 
       (.I0(oc4_int_set[2]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [16]),
        .O(\ints_r[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair116" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[17]_i_1 
       (.I0(oc5_int_set[0]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [17]),
        .O(\ints_r[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair116" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[18]_i_1 
       (.I0(oc5_int_set[1]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [18]),
        .O(\ints_r[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair115" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[19]_i_1 
       (.I0(oc5_int_set[2]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [19]),
        .O(\ints_r[19]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFF000800)) 
    \ints_r[1]_i_1 
       (.I0(crac_wr),
        .I1(\u15/valid_r ),
        .I2(valid_s),
        .I3(\ints_r[28]_i_2_n_0 ),
        .I4(\u13/ints [1]),
        .O(\ints_r[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair115" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[20]_i_1 
       (.I0(ic0_int_set[0]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [20]),
        .O(\ints_r[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair114" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[21]_i_1 
       (.I0(ic0_int_set[1]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [21]),
        .O(\ints_r[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair114" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[22]_i_1 
       (.I0(ic0_int_set[2]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [22]),
        .O(\ints_r[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair113" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[23]_i_1 
       (.I0(ic1_int_set[0]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [23]),
        .O(\ints_r[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair113" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[24]_i_1 
       (.I0(ic1_int_set[1]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [24]),
        .O(\ints_r[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair112" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[25]_i_1 
       (.I0(ic1_int_set[2]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [25]),
        .O(\ints_r[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair112" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[26]_i_1 
       (.I0(ic2_int_set[0]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [26]),
        .O(\ints_r[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[27]_i_1 
       (.I0(ic2_int_set[1]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [27]),
        .O(\ints_r[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[28]_i_1 
       (.I0(ic2_int_set[2]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [28]),
        .O(\ints_r[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFEFFFFFF)) 
    \ints_r[28]_i_2 
       (.I0(wb_addr_i[6]),
        .I1(wb_addr_i[2]),
        .I2(wb_addr_i[5]),
        .I3(wb_addr_i[3]),
        .I4(wb_addr_i[4]),
        .I5(wb_ack_o_i_3_n_0),
        .O(\ints_r[28]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair124" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[2]_i_1 
       (.I0(oc0_int_set[0]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [2]),
        .O(\ints_r[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair123" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[3]_i_1 
       (.I0(oc0_int_set[1]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [3]),
        .O(\ints_r[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair123" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[4]_i_1 
       (.I0(oc0_int_set[2]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [4]),
        .O(\ints_r[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair122" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[5]_i_1 
       (.I0(oc1_int_set[0]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [5]),
        .O(\ints_r[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair122" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[6]_i_1 
       (.I0(oc1_int_set[1]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [6]),
        .O(\ints_r[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair121" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[7]_i_1 
       (.I0(oc1_int_set[2]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [7]),
        .O(\ints_r[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair121" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[8]_i_1 
       (.I0(oc2_int_set[0]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [8]),
        .O(\ints_r[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair120" *) 
  LUT3 #(
    .INIT(8'hC8)) 
    \ints_r[9]_i_1 
       (.I0(oc2_int_set[1]),
        .I1(\ints_r[28]_i_2_n_0 ),
        .I2(\u13/ints [9]),
        .O(\ints_r[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    ld_i_1
       (.I0(\u2/cnt_reg [6]),
        .I1(\u2/cnt_reg [7]),
        .I2(\u2/cnt_reg [5]),
        .I3(\u2/cnt_reg [4]),
        .I4(\u2/cnt_reg [0]),
        .I5(\out_le[0]_i_2_n_0 ),
        .O(ld_i_1_n_0));
  LUT6 #(
    .INIT(64'h4040404040404000)) 
    mem_reg_0_3_0_5_i_1
       (.I0(\u14/u6/en_out_l2_reg_n_0 ),
        .I1(\u14/u6/en_out_l_reg_n_0 ),
        .I2(in_valid_s[0]),
        .I3(\u9/wp_reg_n_0_[0] ),
        .I4(i3_mode[0]),
        .I5(i3_mode[1]),
        .O(p_0_in__0));
  LUT6 #(
    .INIT(64'h4040404040404000)) 
    mem_reg_0_3_0_5_i_1__0
       (.I0(\u14/u7/en_out_l2_reg_n_0 ),
        .I1(\u14/u7/en_out_l_reg_n_0 ),
        .I2(in_valid_s[1]),
        .I3(\u10/wp_reg_n_0_[0] ),
        .I4(i4_mode[0]),
        .I5(i4_mode[1]),
        .O(p_0_in__1));
  LUT6 #(
    .INIT(64'h4040404040404000)) 
    mem_reg_0_3_0_5_i_1__1
       (.I0(\u14/u8/en_out_l2_reg_n_0 ),
        .I1(\u14/u8/en_out_l_reg_n_0 ),
        .I2(in_valid_s[2]),
        .I3(\u11/wp_reg_n_0_[0] ),
        .I4(i6_mode[0]),
        .I5(i6_mode[1]),
        .O(p_0_in__2));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_2
       (.I0(\u9/din_tmp1 [1]),
        .I1(i3_mode[0]),
        .I2(in_slt3[3]),
        .I3(i3_mode[1]),
        .I4(in_slt3[1]),
        .O(\u9/din_tmp [1]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_2__0
       (.I0(\u10/din_tmp1 [1]),
        .I1(i4_mode[0]),
        .I2(in_slt4[3]),
        .I3(i4_mode[1]),
        .I4(in_slt4[1]),
        .O(\u10/din_tmp [1]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_2__1
       (.I0(\u11/din_tmp1 [1]),
        .I1(i6_mode[0]),
        .I2(in_slt6[3]),
        .I3(i6_mode[1]),
        .I4(in_slt6[1]),
        .O(\u11/din_tmp [1]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_3
       (.I0(\u9/din_tmp1 [0]),
        .I1(i3_mode[0]),
        .I2(in_slt3[2]),
        .I3(i3_mode[1]),
        .I4(in_slt3[0]),
        .O(\u9/din_tmp [0]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_3__0
       (.I0(\u10/din_tmp1 [0]),
        .I1(i4_mode[0]),
        .I2(in_slt4[2]),
        .I3(i4_mode[1]),
        .I4(in_slt4[0]),
        .O(\u10/din_tmp [0]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_3__1
       (.I0(\u11/din_tmp1 [0]),
        .I1(i6_mode[0]),
        .I2(in_slt6[2]),
        .I3(i6_mode[1]),
        .I4(in_slt6[0]),
        .O(\u11/din_tmp [0]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_4
       (.I0(\u9/din_tmp1 [3]),
        .I1(i3_mode[0]),
        .I2(in_slt3[5]),
        .I3(i3_mode[1]),
        .I4(in_slt3[3]),
        .O(\u9/din_tmp [3]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_4__0
       (.I0(\u10/din_tmp1 [3]),
        .I1(i4_mode[0]),
        .I2(in_slt4[5]),
        .I3(i4_mode[1]),
        .I4(in_slt4[3]),
        .O(\u10/din_tmp [3]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_4__1
       (.I0(\u11/din_tmp1 [3]),
        .I1(i6_mode[0]),
        .I2(in_slt6[5]),
        .I3(i6_mode[1]),
        .I4(in_slt6[3]),
        .O(\u11/din_tmp [3]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_5
       (.I0(\u9/din_tmp1 [2]),
        .I1(i3_mode[0]),
        .I2(in_slt3[4]),
        .I3(i3_mode[1]),
        .I4(in_slt3[2]),
        .O(\u9/din_tmp [2]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_5__0
       (.I0(\u10/din_tmp1 [2]),
        .I1(i4_mode[0]),
        .I2(in_slt4[4]),
        .I3(i4_mode[1]),
        .I4(in_slt4[2]),
        .O(\u10/din_tmp [2]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_5__1
       (.I0(\u11/din_tmp1 [2]),
        .I1(i6_mode[0]),
        .I2(in_slt6[4]),
        .I3(i6_mode[1]),
        .I4(in_slt6[2]),
        .O(\u11/din_tmp [2]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_6
       (.I0(\u9/din_tmp1 [5]),
        .I1(i3_mode[0]),
        .I2(in_slt3[7]),
        .I3(i3_mode[1]),
        .I4(in_slt3[5]),
        .O(\u9/din_tmp [5]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_6__0
       (.I0(\u10/din_tmp1 [5]),
        .I1(i4_mode[0]),
        .I2(in_slt4[7]),
        .I3(i4_mode[1]),
        .I4(in_slt4[5]),
        .O(\u10/din_tmp [5]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_6__1
       (.I0(\u11/din_tmp1 [5]),
        .I1(i6_mode[0]),
        .I2(in_slt6[7]),
        .I3(i6_mode[1]),
        .I4(in_slt6[5]),
        .O(\u11/din_tmp [5]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_7
       (.I0(\u9/din_tmp1 [4]),
        .I1(i3_mode[0]),
        .I2(in_slt3[6]),
        .I3(i3_mode[1]),
        .I4(in_slt3[4]),
        .O(\u9/din_tmp [4]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_7__0
       (.I0(\u10/din_tmp1 [4]),
        .I1(i4_mode[0]),
        .I2(in_slt4[6]),
        .I3(i4_mode[1]),
        .I4(in_slt4[4]),
        .O(\u10/din_tmp [4]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_0_5_i_7__1
       (.I0(\u11/din_tmp1 [4]),
        .I1(i6_mode[0]),
        .I2(in_slt6[6]),
        .I3(i6_mode[1]),
        .I4(in_slt6[4]),
        .O(\u11/din_tmp [4]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_1
       (.I0(\u9/din_tmp1 [13]),
        .I1(i3_mode[0]),
        .I2(in_slt3[15]),
        .I3(i3_mode[1]),
        .I4(in_slt3[13]),
        .O(\u9/din_tmp [13]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_1__0
       (.I0(\u10/din_tmp1 [13]),
        .I1(i4_mode[0]),
        .I2(in_slt4[15]),
        .I3(i4_mode[1]),
        .I4(in_slt4[13]),
        .O(\u10/din_tmp [13]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_1__1
       (.I0(\u11/din_tmp1 [13]),
        .I1(i6_mode[0]),
        .I2(in_slt6[15]),
        .I3(i6_mode[1]),
        .I4(in_slt6[13]),
        .O(\u11/din_tmp [13]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_2
       (.I0(\u9/din_tmp1 [12]),
        .I1(i3_mode[0]),
        .I2(in_slt3[14]),
        .I3(i3_mode[1]),
        .I4(in_slt3[12]),
        .O(\u9/din_tmp [12]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_2__0
       (.I0(\u10/din_tmp1 [12]),
        .I1(i4_mode[0]),
        .I2(in_slt4[14]),
        .I3(i4_mode[1]),
        .I4(in_slt4[12]),
        .O(\u10/din_tmp [12]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_2__1
       (.I0(\u11/din_tmp1 [12]),
        .I1(i6_mode[0]),
        .I2(in_slt6[14]),
        .I3(i6_mode[1]),
        .I4(in_slt6[12]),
        .O(\u11/din_tmp [12]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_3
       (.I0(\u9/din_tmp1 [15]),
        .I1(i3_mode[0]),
        .I2(in_slt3[17]),
        .I3(i3_mode[1]),
        .I4(in_slt3[15]),
        .O(\u9/din_tmp [15]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_3__0
       (.I0(\u10/din_tmp1 [15]),
        .I1(i4_mode[0]),
        .I2(in_slt4[17]),
        .I3(i4_mode[1]),
        .I4(in_slt4[15]),
        .O(\u10/din_tmp [15]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_3__1
       (.I0(\u11/din_tmp1 [15]),
        .I1(i6_mode[0]),
        .I2(in_slt6[17]),
        .I3(i6_mode[1]),
        .I4(in_slt6[15]),
        .O(\u11/din_tmp [15]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_4
       (.I0(\u9/din_tmp1 [14]),
        .I1(i3_mode[0]),
        .I2(in_slt3[16]),
        .I3(i3_mode[1]),
        .I4(in_slt3[14]),
        .O(\u9/din_tmp [14]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_4__0
       (.I0(\u10/din_tmp1 [14]),
        .I1(i4_mode[0]),
        .I2(in_slt4[16]),
        .I3(i4_mode[1]),
        .I4(in_slt4[14]),
        .O(\u10/din_tmp [14]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_4__1
       (.I0(\u11/din_tmp1 [14]),
        .I1(i6_mode[0]),
        .I2(in_slt6[16]),
        .I3(i6_mode[1]),
        .I4(in_slt6[14]),
        .O(\u11/din_tmp [14]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_5
       (.I0(in_slt3[5]),
        .I1(i3_mode[0]),
        .I2(in_slt3[19]),
        .I3(i3_mode[1]),
        .I4(in_slt3[17]),
        .O(\u9/din_tmp [17]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_5__0
       (.I0(in_slt4[5]),
        .I1(i4_mode[0]),
        .I2(in_slt4[19]),
        .I3(i4_mode[1]),
        .I4(in_slt4[17]),
        .O(\u10/din_tmp [17]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_5__1
       (.I0(in_slt6[5]),
        .I1(i6_mode[0]),
        .I2(in_slt6[19]),
        .I3(i6_mode[1]),
        .I4(in_slt6[17]),
        .O(\u11/din_tmp [17]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_6
       (.I0(in_slt3[4]),
        .I1(i3_mode[0]),
        .I2(in_slt3[18]),
        .I3(i3_mode[1]),
        .I4(in_slt3[16]),
        .O(\u9/din_tmp [16]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_6__0
       (.I0(in_slt4[4]),
        .I1(i4_mode[0]),
        .I2(in_slt4[18]),
        .I3(i4_mode[1]),
        .I4(in_slt4[16]),
        .O(\u10/din_tmp [16]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_12_17_i_6__1
       (.I0(in_slt6[4]),
        .I1(i6_mode[0]),
        .I2(in_slt6[18]),
        .I3(i6_mode[1]),
        .I4(in_slt6[16]),
        .O(\u11/din_tmp [16]));
  LUT4 #(
    .INIT(16'h2320)) 
    mem_reg_0_3_18_23_i_1
       (.I0(in_slt3[19]),
        .I1(i3_mode[0]),
        .I2(i3_mode[1]),
        .I3(in_slt3[7]),
        .O(\u9/din_tmp [19]));
  LUT4 #(
    .INIT(16'h2320)) 
    mem_reg_0_3_18_23_i_1__0
       (.I0(in_slt4[19]),
        .I1(i4_mode[0]),
        .I2(i4_mode[1]),
        .I3(in_slt4[7]),
        .O(\u10/din_tmp [19]));
  LUT4 #(
    .INIT(16'h2320)) 
    mem_reg_0_3_18_23_i_1__1
       (.I0(in_slt6[19]),
        .I1(i6_mode[0]),
        .I2(i6_mode[1]),
        .I3(in_slt6[7]),
        .O(\u11/din_tmp [19]));
  LUT4 #(
    .INIT(16'h2320)) 
    mem_reg_0_3_18_23_i_2
       (.I0(in_slt3[18]),
        .I1(i3_mode[0]),
        .I2(i3_mode[1]),
        .I3(in_slt3[6]),
        .O(\u9/din_tmp [18]));
  LUT4 #(
    .INIT(16'h2320)) 
    mem_reg_0_3_18_23_i_2__0
       (.I0(in_slt4[18]),
        .I1(i4_mode[0]),
        .I2(i4_mode[1]),
        .I3(in_slt4[6]),
        .O(\u10/din_tmp [18]));
  LUT4 #(
    .INIT(16'h2320)) 
    mem_reg_0_3_18_23_i_2__1
       (.I0(in_slt6[18]),
        .I1(i6_mode[0]),
        .I2(i6_mode[1]),
        .I3(in_slt6[6]),
        .O(\u11/din_tmp [18]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_18_23_i_3
       (.I0(in_slt3[9]),
        .I1(i3_mode[1]),
        .I2(i3_mode[0]),
        .O(\u9/din_tmp [21]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_18_23_i_3__0
       (.I0(in_slt4[9]),
        .I1(i4_mode[1]),
        .I2(i4_mode[0]),
        .O(\u10/din_tmp [21]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_18_23_i_3__1
       (.I0(in_slt6[9]),
        .I1(i6_mode[1]),
        .I2(i6_mode[0]),
        .O(\u11/din_tmp [21]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_18_23_i_4
       (.I0(in_slt3[8]),
        .I1(i3_mode[1]),
        .I2(i3_mode[0]),
        .O(\u9/din_tmp [20]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_18_23_i_4__0
       (.I0(in_slt4[8]),
        .I1(i4_mode[1]),
        .I2(i4_mode[0]),
        .O(\u10/din_tmp [20]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_18_23_i_4__1
       (.I0(in_slt6[8]),
        .I1(i6_mode[1]),
        .I2(i6_mode[0]),
        .O(\u11/din_tmp [20]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_18_23_i_5
       (.I0(in_slt3[11]),
        .I1(i3_mode[1]),
        .I2(i3_mode[0]),
        .O(\u9/din_tmp [23]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_18_23_i_5__0
       (.I0(in_slt4[11]),
        .I1(i4_mode[1]),
        .I2(i4_mode[0]),
        .O(\u10/din_tmp [23]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_18_23_i_5__1
       (.I0(in_slt6[11]),
        .I1(i6_mode[1]),
        .I2(i6_mode[0]),
        .O(\u11/din_tmp [23]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_18_23_i_6
       (.I0(in_slt3[10]),
        .I1(i3_mode[1]),
        .I2(i3_mode[0]),
        .O(\u9/din_tmp [22]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_18_23_i_6__0
       (.I0(in_slt4[10]),
        .I1(i4_mode[1]),
        .I2(i4_mode[0]),
        .O(\u10/din_tmp [22]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_18_23_i_6__1
       (.I0(in_slt6[10]),
        .I1(i6_mode[1]),
        .I2(i6_mode[0]),
        .O(\u11/din_tmp [22]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_1
       (.I0(in_slt3[13]),
        .I1(i3_mode[1]),
        .I2(i3_mode[0]),
        .O(\u9/din_tmp [25]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_1__0
       (.I0(in_slt4[13]),
        .I1(i4_mode[1]),
        .I2(i4_mode[0]),
        .O(\u10/din_tmp [25]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_1__1
       (.I0(in_slt6[13]),
        .I1(i6_mode[1]),
        .I2(i6_mode[0]),
        .O(\u11/din_tmp [25]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_2
       (.I0(in_slt3[12]),
        .I1(i3_mode[1]),
        .I2(i3_mode[0]),
        .O(\u9/din_tmp [24]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_2__0
       (.I0(in_slt4[12]),
        .I1(i4_mode[1]),
        .I2(i4_mode[0]),
        .O(\u10/din_tmp [24]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_2__1
       (.I0(in_slt6[12]),
        .I1(i6_mode[1]),
        .I2(i6_mode[0]),
        .O(\u11/din_tmp [24]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_3
       (.I0(in_slt3[15]),
        .I1(i3_mode[1]),
        .I2(i3_mode[0]),
        .O(\u9/din_tmp [27]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_3__0
       (.I0(in_slt4[15]),
        .I1(i4_mode[1]),
        .I2(i4_mode[0]),
        .O(\u10/din_tmp [27]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_3__1
       (.I0(in_slt6[15]),
        .I1(i6_mode[1]),
        .I2(i6_mode[0]),
        .O(\u11/din_tmp [27]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_4
       (.I0(in_slt3[14]),
        .I1(i3_mode[1]),
        .I2(i3_mode[0]),
        .O(\u9/din_tmp [26]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_4__0
       (.I0(in_slt4[14]),
        .I1(i4_mode[1]),
        .I2(i4_mode[0]),
        .O(\u10/din_tmp [26]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_4__1
       (.I0(in_slt6[14]),
        .I1(i6_mode[1]),
        .I2(i6_mode[0]),
        .O(\u11/din_tmp [26]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_5
       (.I0(in_slt3[17]),
        .I1(i3_mode[1]),
        .I2(i3_mode[0]),
        .O(\u9/din_tmp [29]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_5__0
       (.I0(in_slt4[17]),
        .I1(i4_mode[1]),
        .I2(i4_mode[0]),
        .O(\u10/din_tmp [29]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_5__1
       (.I0(in_slt6[17]),
        .I1(i6_mode[1]),
        .I2(i6_mode[0]),
        .O(\u11/din_tmp [29]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_6
       (.I0(in_slt3[16]),
        .I1(i3_mode[1]),
        .I2(i3_mode[0]),
        .O(\u9/din_tmp [28]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_6__0
       (.I0(in_slt4[16]),
        .I1(i4_mode[1]),
        .I2(i4_mode[0]),
        .O(\u10/din_tmp [28]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_24_29_i_6__1
       (.I0(in_slt6[16]),
        .I1(i6_mode[1]),
        .I2(i6_mode[0]),
        .O(\u11/din_tmp [28]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_30_31__0_i_1
       (.I0(in_slt3[19]),
        .I1(i3_mode[1]),
        .I2(i3_mode[0]),
        .O(\u9/din_tmp [31]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_30_31__0_i_1__0
       (.I0(in_slt4[19]),
        .I1(i4_mode[1]),
        .I2(i4_mode[0]),
        .O(\u10/din_tmp [31]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_30_31_i_1
       (.I0(in_slt3[18]),
        .I1(i3_mode[1]),
        .I2(i3_mode[0]),
        .O(\u9/din_tmp [30]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_30_31_i_1__0
       (.I0(in_slt4[18]),
        .I1(i4_mode[1]),
        .I2(i4_mode[0]),
        .O(\u10/din_tmp [30]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_30_31_i_1__1
       (.I0(in_slt6[19]),
        .I1(i6_mode[1]),
        .I2(i6_mode[0]),
        .O(\u11/din_tmp [31]));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_0_3_30_31_i_1__2
       (.I0(in_slt6[18]),
        .I1(i6_mode[1]),
        .I2(i6_mode[0]),
        .O(\u11/din_tmp [30]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_1
       (.I0(\u9/din_tmp1 [7]),
        .I1(i3_mode[0]),
        .I2(in_slt3[9]),
        .I3(i3_mode[1]),
        .I4(in_slt3[7]),
        .O(\u9/din_tmp [7]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_1__0
       (.I0(\u10/din_tmp1 [7]),
        .I1(i4_mode[0]),
        .I2(in_slt4[9]),
        .I3(i4_mode[1]),
        .I4(in_slt4[7]),
        .O(\u10/din_tmp [7]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_1__1
       (.I0(\u11/din_tmp1 [7]),
        .I1(i6_mode[0]),
        .I2(in_slt6[9]),
        .I3(i6_mode[1]),
        .I4(in_slt6[7]),
        .O(\u11/din_tmp [7]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_2
       (.I0(\u9/din_tmp1 [6]),
        .I1(i3_mode[0]),
        .I2(in_slt3[8]),
        .I3(i3_mode[1]),
        .I4(in_slt3[6]),
        .O(\u9/din_tmp [6]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_2__0
       (.I0(\u10/din_tmp1 [6]),
        .I1(i4_mode[0]),
        .I2(in_slt4[8]),
        .I3(i4_mode[1]),
        .I4(in_slt4[6]),
        .O(\u10/din_tmp [6]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_2__1
       (.I0(\u11/din_tmp1 [6]),
        .I1(i6_mode[0]),
        .I2(in_slt6[8]),
        .I3(i6_mode[1]),
        .I4(in_slt6[6]),
        .O(\u11/din_tmp [6]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_3
       (.I0(\u9/din_tmp1 [9]),
        .I1(i3_mode[0]),
        .I2(in_slt3[11]),
        .I3(i3_mode[1]),
        .I4(in_slt3[9]),
        .O(\u9/din_tmp [9]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_3__0
       (.I0(\u10/din_tmp1 [9]),
        .I1(i4_mode[0]),
        .I2(in_slt4[11]),
        .I3(i4_mode[1]),
        .I4(in_slt4[9]),
        .O(\u10/din_tmp [9]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_3__1
       (.I0(\u11/din_tmp1 [9]),
        .I1(i6_mode[0]),
        .I2(in_slt6[11]),
        .I3(i6_mode[1]),
        .I4(in_slt6[9]),
        .O(\u11/din_tmp [9]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_4
       (.I0(\u9/din_tmp1 [8]),
        .I1(i3_mode[0]),
        .I2(in_slt3[10]),
        .I3(i3_mode[1]),
        .I4(in_slt3[8]),
        .O(\u9/din_tmp [8]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_4__0
       (.I0(\u10/din_tmp1 [8]),
        .I1(i4_mode[0]),
        .I2(in_slt4[10]),
        .I3(i4_mode[1]),
        .I4(in_slt4[8]),
        .O(\u10/din_tmp [8]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_4__1
       (.I0(\u11/din_tmp1 [8]),
        .I1(i6_mode[0]),
        .I2(in_slt6[10]),
        .I3(i6_mode[1]),
        .I4(in_slt6[8]),
        .O(\u11/din_tmp [8]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_5
       (.I0(\u9/din_tmp1 [11]),
        .I1(i3_mode[0]),
        .I2(in_slt3[13]),
        .I3(i3_mode[1]),
        .I4(in_slt3[11]),
        .O(\u9/din_tmp [11]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_5__0
       (.I0(\u10/din_tmp1 [11]),
        .I1(i4_mode[0]),
        .I2(in_slt4[13]),
        .I3(i4_mode[1]),
        .I4(in_slt4[11]),
        .O(\u10/din_tmp [11]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_5__1
       (.I0(\u11/din_tmp1 [11]),
        .I1(i6_mode[0]),
        .I2(in_slt6[13]),
        .I3(i6_mode[1]),
        .I4(in_slt6[11]),
        .O(\u11/din_tmp [11]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_6
       (.I0(\u9/din_tmp1 [10]),
        .I1(i3_mode[0]),
        .I2(in_slt3[12]),
        .I3(i3_mode[1]),
        .I4(in_slt3[10]),
        .O(\u9/din_tmp [10]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_6__0
       (.I0(\u10/din_tmp1 [10]),
        .I1(i4_mode[0]),
        .I2(in_slt4[12]),
        .I3(i4_mode[1]),
        .I4(in_slt4[10]),
        .O(\u10/din_tmp [10]));
  LUT5 #(
    .INIT(32'hFFE200E2)) 
    mem_reg_0_3_6_11_i_6__1
       (.I0(\u11/din_tmp1 [10]),
        .I1(i6_mode[0]),
        .I2(in_slt6[12]),
        .I3(i6_mode[1]),
        .I4(in_slt6[10]),
        .O(\u11/din_tmp [10]));
  LUT6 #(
    .INIT(64'hEFFFFFFFFFFFFFFF)) 
    o3_we_i_1
       (.I0(o3_we_i_3_n_0),
        .I1(\u12/we2 ),
        .I2(\u12/we1 ),
        .I3(wb_we_i),
        .I4(wb_stb_i),
        .I5(wb_cyc_i),
        .O(o3_we_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair137" *) 
  LUT3 #(
    .INIT(8'h01)) 
    o3_we_i_2
       (.I0(wb_addr_i[4]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[2]),
        .O(o3_we_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'hB)) 
    o3_we_i_3
       (.I0(wb_addr_i[6]),
        .I1(wb_addr_i[5]),
        .O(o3_we_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'h10)) 
    o4_we_i_1
       (.I0(wb_addr_i[4]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[2]),
        .O(o4_we_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'h04)) 
    o6_we_i_1
       (.I0(wb_addr_i[4]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[2]),
        .O(o6_we_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'h40)) 
    o7_we_i_1
       (.I0(wb_addr_i[4]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[2]),
        .O(o7_we_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair137" *) 
  LUT3 #(
    .INIT(8'h04)) 
    o8_we_i_1
       (.I0(wb_addr_i[3]),
        .I1(wb_addr_i[4]),
        .I2(wb_addr_i[2]),
        .O(o8_we_i_1_n_0));
  LUT3 #(
    .INIT(8'h40)) 
    o9_we_i_1
       (.I0(wb_addr_i[3]),
        .I1(wb_addr_i[4]),
        .I2(wb_addr_i[2]),
        .O(o9_we_i_1_n_0));
  LUT4 #(
    .INIT(16'h0200)) 
    \occ0_r[31]_i_1 
       (.I0(wb_addr_i[2]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(rf_we),
        .O(\u13/occ00 ));
  LUT4 #(
    .INIT(16'h0400)) 
    \occ1_r[15]_i_1 
       (.I0(wb_addr_i[2]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(rf_we),
        .O(\u13/occ1_r0 ));
  LUT6 #(
    .INIT(64'h0000000001000000)) 
    \out_le[0]_i_1 
       (.I0(\u2/cnt_reg [6]),
        .I1(\u2/cnt_reg [7]),
        .I2(\u2/cnt_reg [5]),
        .I3(\u2/cnt_reg [4]),
        .I4(\u2/cnt_reg [0]),
        .I5(\out_le[0]_i_2_n_0 ),
        .O(\out_le[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair218" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \out_le[0]_i_2 
       (.I0(\u2/cnt_reg [2]),
        .I1(\u2/cnt_reg [1]),
        .I2(\u2/cnt_reg [3]),
        .O(\out_le[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000040)) 
    \out_le[1]_i_1 
       (.I0(\out_le[1]_i_2_n_0 ),
        .I1(\out_le[1]_i_3_n_0 ),
        .I2(\u2/cnt_reg [5]),
        .I3(\u2/cnt_reg [4]),
        .I4(\u2/cnt_reg [1]),
        .I5(\u2/cnt_reg [3]),
        .O(\out_le[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \out_le[1]_i_2 
       (.I0(\u2/cnt_reg [6]),
        .I1(\u2/cnt_reg [7]),
        .O(\out_le[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair219" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \out_le[1]_i_3 
       (.I0(\u2/cnt_reg [0]),
        .I1(\u2/cnt_reg [2]),
        .O(\out_le[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h1000000000000000)) 
    \out_le[2]_i_1 
       (.I0(\out_le[2]_i_2_n_0 ),
        .I1(\out_le[1]_i_2_n_0 ),
        .I2(\u2/cnt_reg [4]),
        .I3(\u2/cnt_reg [5]),
        .I4(\u2/cnt_reg [0]),
        .I5(\u2/cnt_reg [3]),
        .O(\out_le[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair218" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \out_le[2]_i_2 
       (.I0(\u2/cnt_reg [1]),
        .I1(\u2/cnt_reg [2]),
        .O(\out_le[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000400000)) 
    \out_le[3]_i_1 
       (.I0(\out_le[3]_i_2_n_0 ),
        .I1(\out_le[1]_i_3_n_0 ),
        .I2(\u2/cnt_reg [6]),
        .I3(\u2/cnt_reg [7]),
        .I4(\u2/cnt_reg [3]),
        .I5(\u2/cnt_reg [1]),
        .O(\out_le[3]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \out_le[3]_i_2 
       (.I0(\u2/cnt_reg [4]),
        .I1(\u2/cnt_reg [5]),
        .O(\out_le[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000002000000)) 
    \out_le[4]_i_1 
       (.I0(\u2/cnt_reg [6]),
        .I1(\u2/cnt_reg [7]),
        .I2(\u2/cnt_reg [4]),
        .I3(\u2/cnt_reg [5]),
        .I4(\u2/cnt_reg [0]),
        .I5(\out_le[0]_i_2_n_0 ),
        .O(\out_le[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000004000)) 
    \out_le[5]_i_1 
       (.I0(\out_le[2]_i_2_n_0 ),
        .I1(\u2/cnt_reg [7]),
        .I2(\u2/cnt_reg [3]),
        .I3(\u2/cnt_reg [0]),
        .I4(\u2/cnt_reg [6]),
        .I5(\out_le[3]_i_2_n_0 ),
        .O(\out_le[5]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \ps_cnt[0]_i_1 
       (.I0(\u26/ps_cnt_reg [0]),
        .I1(ac97_rst_force),
        .O(\ps_cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair141" *) 
  LUT3 #(
    .INIT(8'h28)) 
    \ps_cnt[1]_i_1 
       (.I0(\ps_cnt[4]_i_2_n_0 ),
        .I1(\u26/ps_cnt_reg [1]),
        .I2(\u26/ps_cnt_reg [0]),
        .O(p_0_in__8[1]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT4 #(
    .INIT(16'h2888)) 
    \ps_cnt[2]_i_1 
       (.I0(\ps_cnt[4]_i_2_n_0 ),
        .I1(\u26/ps_cnt_reg [2]),
        .I2(\u26/ps_cnt_reg [0]),
        .I3(\u26/ps_cnt_reg [1]),
        .O(p_0_in__8[2]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT5 #(
    .INIT(32'h28888888)) 
    \ps_cnt[3]_i_1 
       (.I0(\ps_cnt[4]_i_2_n_0 ),
        .I1(\u26/ps_cnt_reg [3]),
        .I2(\u26/ps_cnt_reg [2]),
        .I3(\u26/ps_cnt_reg [1]),
        .I4(\u26/ps_cnt_reg [0]),
        .O(p_0_in__8[3]));
  LUT6 #(
    .INIT(64'h2888888888888888)) 
    \ps_cnt[4]_i_1 
       (.I0(\ps_cnt[4]_i_2_n_0 ),
        .I1(\u26/ps_cnt_reg [4]),
        .I2(\u26/ps_cnt_reg [1]),
        .I3(\u26/ps_cnt_reg [0]),
        .I4(\u26/ps_cnt_reg [3]),
        .I5(\u26/ps_cnt_reg [2]),
        .O(p_0_in__8[4]));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \ps_cnt[4]_i_2 
       (.I0(\cnt[2]_i_2_n_0 ),
        .I1(ac97_rst_force),
        .O(\ps_cnt[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h4444444414444440)) 
    \ps_cnt[5]_i_1 
       (.I0(ac97_rst_force),
        .I1(\u26/ps_cnt_reg [5]),
        .I2(\u26/ps_cnt_reg [1]),
        .I3(\u26/ps_cnt_reg [2]),
        .I4(\u26/ps_cnt_reg [3]),
        .I5(\ps_cnt[5]_i_2_n_0 ),
        .O(p_0_in__8[5]));
  (* SOFT_HLUTNM = "soft_lutpair141" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \ps_cnt[5]_i_2 
       (.I0(\u26/ps_cnt_reg [0]),
        .I1(\u26/ps_cnt_reg [4]),
        .O(\ps_cnt[5]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hF040)) 
    rdd1_i_1
       (.I0(valid_s),
        .I1(\u15/valid_r ),
        .I2(\u15/crac_rd ),
        .I3(\u15/rdd1 ),
        .O(rdd1_i_1_n_0));
  LUT6 #(
    .INIT(64'h4040FF40FF40FF40)) 
    rdd2_i_1
       (.I0(valid_s),
        .I1(\u15/valid_r ),
        .I2(\u15/crac_rd ),
        .I3(\u15/rdd2 ),
        .I4(\u15/rdd3 ),
        .I5(crac_rd_done),
        .O(rdd2_i_1_n_0));
  LUT5 #(
    .INIT(32'h08FF0808)) 
    rdd3_i_1
       (.I0(\u15/rdd2 ),
        .I1(valid_s),
        .I2(\u15/valid_r ),
        .I3(crac_rd_done),
        .I4(\u15/rdd3 ),
        .O(rdd3_i_1_n_0));
  LUT4 #(
    .INIT(16'h0001)) 
    re1_i_1
       (.I0(wb_addr_i[29]),
        .I1(wb_addr_i[30]),
        .I2(wb_addr_i[31]),
        .I3(re1_i_2_n_0),
        .O(\u12/re10 ));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT4 #(
    .INIT(16'hEFFF)) 
    re1_i_2
       (.I0(wb_we_i),
        .I1(\u12/re2 ),
        .I2(wb_stb_i),
        .I3(wb_cyc_i),
        .O(re1_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT5 #(
    .INIT(32'h02000000)) 
    re2_i_1
       (.I0(\u12/re1 ),
        .I1(wb_we_i),
        .I2(\u12/re2 ),
        .I3(wb_stb_i),
        .I4(wb_cyc_i),
        .O(\u12/re20 ));
  LUT1 #(
    .INIT(2'h1)) 
    \res_cnt[0]_i_1 
       (.I0(\u2/res_cnt_reg [0]),
        .O(p_0_in__0__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair126" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \res_cnt[1]_i_1 
       (.I0(\u2/res_cnt_reg [0]),
        .I1(\u2/res_cnt_reg [1]),
        .O(p_0_in__0__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair126" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \res_cnt[2]_i_1 
       (.I0(\u2/res_cnt_reg [1]),
        .I1(\u2/res_cnt_reg [0]),
        .I2(\u2/res_cnt_reg [2]),
        .O(p_0_in__0__0[2]));
  LUT1 #(
    .INIT(2'h1)) 
    \res_cnt[3]_i_1 
       (.I0(\u2/sync_resume_reg_n_0 ),
        .O(\u2/clear ));
  LUT6 #(
    .INIT(64'h0010000000000000)) 
    \res_cnt[3]_i_2 
       (.I0(\u26/ps_cnt_reg [1]),
        .I1(\u26/ps_cnt_reg [2]),
        .I2(\u26/ps_cnt_reg [5]),
        .I3(\u26/ps_cnt_reg [3]),
        .I4(\u26/ps_cnt_reg [4]),
        .I5(\u26/ps_cnt_reg [0]),
        .O(ps_ce));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \res_cnt[3]_i_3 
       (.I0(\u2/res_cnt_reg [0]),
        .I1(\u2/res_cnt_reg [2]),
        .I2(\u2/res_cnt_reg [1]),
        .I3(\u2/res_cnt_reg [3]),
        .O(p_0_in__0__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT5 #(
    .INIT(32'h00000008)) 
    resume_req_i_1
       (.I0(wb_din[1]),
        .I1(rf_we),
        .I2(wb_addr_i[2]),
        .I3(wb_addr_i[3]),
        .I4(wb_addr_i[4]),
        .O(resume_req_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair136" *) 
  LUT3 #(
    .INIT(8'h10)) 
    rf_we_i_1
       (.I0(wb_addr_i[6]),
        .I1(wb_addr_i[5]),
        .I2(wb_ack_o_i_2_n_0),
        .O(\u12/rf_we0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \rp[0]_i_1 
       (.I0(\u9/rp_reg_n_0_[0] ),
        .I1(i3_re),
        .I2(\u13/icc_r_reg_n_0_[0] ),
        .O(\rp[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \rp[0]_i_1__0 
       (.I0(\u10/rp_reg_n_0_[0] ),
        .I1(i4_re),
        .I2(\u13/icc_r_reg_n_0_[8] ),
        .O(\rp[0]_i_1__0_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \rp[0]_i_1__1 
       (.I0(\u11/rp_reg_n_0_[0] ),
        .I1(i6_re),
        .I2(\u13/icc_r_reg_n_0_[16] ),
        .O(\rp[0]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair127" *) 
  LUT3 #(
    .INIT(8'hE1)) 
    \rp[0]_i_1__2 
       (.I0(o3_mode[0]),
        .I1(o3_mode[1]),
        .I2(\u3/rp_reg_n_0_[0] ),
        .O(\rp[0]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair128" *) 
  LUT3 #(
    .INIT(8'hE1)) 
    \rp[0]_i_1__3 
       (.I0(o4_mode[0]),
        .I1(o4_mode[1]),
        .I2(\u4/rp_reg_n_0_[0] ),
        .O(\rp[0]_i_1__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair129" *) 
  LUT3 #(
    .INIT(8'hE1)) 
    \rp[0]_i_1__4 
       (.I0(o6_mode[0]),
        .I1(o6_mode[1]),
        .I2(\u5/rp_reg_n_0_[0] ),
        .O(\rp[0]_i_1__4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair130" *) 
  LUT3 #(
    .INIT(8'hE1)) 
    \rp[0]_i_1__5 
       (.I0(o7_mode[0]),
        .I1(o7_mode[1]),
        .I2(\u6/rp_reg_n_0_[0] ),
        .O(\rp[0]_i_1__5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair131" *) 
  LUT3 #(
    .INIT(8'hE1)) 
    \rp[0]_i_1__6 
       (.I0(o8_mode[0]),
        .I1(o8_mode[1]),
        .I2(\u7/rp_reg_n_0_[0] ),
        .O(\rp[0]_i_1__6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair132" *) 
  LUT3 #(
    .INIT(8'hE1)) 
    \rp[0]_i_1__7 
       (.I0(o9_mode[0]),
        .I1(o9_mode[1]),
        .I2(\u8/rp_reg_n_0_[0] ),
        .O(\rp[0]_i_1__7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h6A00)) 
    \rp[1]_i_1 
       (.I0(\u9/rp_reg_n_0_[1] ),
        .I1(i3_re),
        .I2(\u9/rp_reg_n_0_[0] ),
        .I3(\u13/icc_r_reg_n_0_[0] ),
        .O(\rp[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h6A00)) 
    \rp[1]_i_1__0 
       (.I0(\u10/rp_reg_n_0_[1] ),
        .I1(i4_re),
        .I2(\u10/rp_reg_n_0_[0] ),
        .I3(\u13/icc_r_reg_n_0_[8] ),
        .O(\rp[1]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h6A00)) 
    \rp[1]_i_1__1 
       (.I0(\u11/rp_reg_n_0_[1] ),
        .I1(i6_re),
        .I2(\u11/rp_reg_n_0_[0] ),
        .I3(\u13/icc_r_reg_n_0_[16] ),
        .O(\rp[1]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair127" *) 
  LUT3 #(
    .INIT(8'h1E)) 
    \rp[1]_i_1__2 
       (.I0(\rp[3]_i_2_n_0 ),
        .I1(\u3/rp_reg_n_0_[0] ),
        .I2(\u3/p_0_in [0]),
        .O(p_0_in__2__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair128" *) 
  LUT3 #(
    .INIT(8'h1E)) 
    \rp[1]_i_1__3 
       (.I0(\rp[3]_i_2__0_n_0 ),
        .I1(\u4/rp_reg_n_0_[0] ),
        .I2(\u4/p_0_in [0]),
        .O(p_0_in__3__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair129" *) 
  LUT3 #(
    .INIT(8'h1E)) 
    \rp[1]_i_1__4 
       (.I0(\rp[3]_i_2__1_n_0 ),
        .I1(\u5/rp_reg_n_0_[0] ),
        .I2(\u5/p_0_in [0]),
        .O(p_0_in__4[1]));
  (* SOFT_HLUTNM = "soft_lutpair130" *) 
  LUT3 #(
    .INIT(8'h1E)) 
    \rp[1]_i_1__5 
       (.I0(\rp[3]_i_2__2_n_0 ),
        .I1(\u6/rp_reg_n_0_[0] ),
        .I2(\u6/p_0_in [0]),
        .O(p_0_in__5[1]));
  (* SOFT_HLUTNM = "soft_lutpair131" *) 
  LUT3 #(
    .INIT(8'h1E)) 
    \rp[1]_i_1__6 
       (.I0(\rp[3]_i_2__3_n_0 ),
        .I1(\u7/rp_reg_n_0_[0] ),
        .I2(\u7/p_0_in [0]),
        .O(p_0_in__6[1]));
  (* SOFT_HLUTNM = "soft_lutpair132" *) 
  LUT3 #(
    .INIT(8'h1E)) 
    \rp[1]_i_1__7 
       (.I0(\rp[3]_i_2__4_n_0 ),
        .I1(\u8/rp_reg_n_0_[0] ),
        .I2(\u8/p_0_in [0]),
        .O(p_0_in__7[1]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h6AAA0000)) 
    \rp[2]_i_1 
       (.I0(\u9/rp_reg_n_0_[2] ),
        .I1(i3_re),
        .I2(\u9/rp_reg_n_0_[0] ),
        .I3(\u9/rp_reg_n_0_[1] ),
        .I4(\u13/icc_r_reg_n_0_[0] ),
        .O(\rp[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'h6AAA0000)) 
    \rp[2]_i_1__0 
       (.I0(\u10/rp_reg_n_0_[2] ),
        .I1(i4_re),
        .I2(\u10/rp_reg_n_0_[0] ),
        .I3(\u10/rp_reg_n_0_[1] ),
        .I4(\u13/icc_r_reg_n_0_[8] ),
        .O(\rp[2]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'h6AAA0000)) 
    \rp[2]_i_1__1 
       (.I0(\u11/rp_reg_n_0_[2] ),
        .I1(i6_re),
        .I2(\u11/rp_reg_n_0_[0] ),
        .I3(\u11/rp_reg_n_0_[1] ),
        .I4(\u13/icc_r_reg_n_0_[16] ),
        .O(\rp[2]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h1FE0)) 
    \rp[2]_i_1__2 
       (.I0(\rp[3]_i_2_n_0 ),
        .I1(\u3/rp_reg_n_0_[0] ),
        .I2(\u3/p_0_in [0]),
        .I3(\u3/p_0_in [1]),
        .O(p_0_in__2__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'h1FE0)) 
    \rp[2]_i_1__3 
       (.I0(\rp[3]_i_2__0_n_0 ),
        .I1(\u4/rp_reg_n_0_[0] ),
        .I2(\u4/p_0_in [0]),
        .I3(\u4/p_0_in [1]),
        .O(p_0_in__3__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'h37C8)) 
    \rp[2]_i_1__4 
       (.I0(\rp[3]_i_2__1_n_0 ),
        .I1(\u5/p_0_in [0]),
        .I2(\u5/rp_reg_n_0_[0] ),
        .I3(\u5/p_0_in [1]),
        .O(p_0_in__4[2]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'h37C8)) 
    \rp[2]_i_1__5 
       (.I0(\rp[3]_i_2__2_n_0 ),
        .I1(\u6/p_0_in [0]),
        .I2(\u6/rp_reg_n_0_[0] ),
        .I3(\u6/p_0_in [1]),
        .O(p_0_in__5[2]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'h37C8)) 
    \rp[2]_i_1__6 
       (.I0(\rp[3]_i_2__3_n_0 ),
        .I1(\u7/p_0_in [0]),
        .I2(\u7/rp_reg_n_0_[0] ),
        .I3(\u7/p_0_in [1]),
        .O(p_0_in__6[2]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT4 #(
    .INIT(16'h37C8)) 
    \rp[2]_i_1__7 
       (.I0(\rp[3]_i_2__4_n_0 ),
        .I1(\u8/p_0_in [0]),
        .I2(\u8/rp_reg_n_0_[0] ),
        .I3(\u8/p_0_in [1]),
        .O(p_0_in__7[2]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'h1FFFE000)) 
    \rp[3]_i_1 
       (.I0(\rp[3]_i_2_n_0 ),
        .I1(\u3/rp_reg_n_0_[0] ),
        .I2(\u3/p_0_in [0]),
        .I3(\u3/p_0_in [1]),
        .I4(\u3/rp_reg_n_0_[3] ),
        .O(p_0_in__2__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT5 #(
    .INIT(32'h1FFFE000)) 
    \rp[3]_i_1__0 
       (.I0(\rp[3]_i_2__0_n_0 ),
        .I1(\u4/rp_reg_n_0_[0] ),
        .I2(\u4/p_0_in [0]),
        .I3(\u4/p_0_in [1]),
        .I4(\u4/rp_reg_n_0_[3] ),
        .O(p_0_in__3__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT5 #(
    .INIT(32'h1FFFE000)) 
    \rp[3]_i_1__1 
       (.I0(\rp[3]_i_2__1_n_0 ),
        .I1(\u5/rp_reg_n_0_[0] ),
        .I2(\u5/p_0_in [0]),
        .I3(\u5/p_0_in [1]),
        .I4(\u5/rp_reg_n_0_[3] ),
        .O(p_0_in__4[3]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT5 #(
    .INIT(32'h1FFFE000)) 
    \rp[3]_i_1__2 
       (.I0(\rp[3]_i_2__2_n_0 ),
        .I1(\u6/rp_reg_n_0_[0] ),
        .I2(\u6/p_0_in [0]),
        .I3(\u6/p_0_in [1]),
        .I4(\u6/rp_reg_n_0_[3] ),
        .O(p_0_in__5[3]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT5 #(
    .INIT(32'h1FFFE000)) 
    \rp[3]_i_1__3 
       (.I0(\rp[3]_i_2__3_n_0 ),
        .I1(\u7/rp_reg_n_0_[0] ),
        .I2(\u7/p_0_in [0]),
        .I3(\u7/p_0_in [1]),
        .I4(\u7/rp_reg_n_0_[3] ),
        .O(p_0_in__6[3]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT5 #(
    .INIT(32'h1FFFE000)) 
    \rp[3]_i_1__4 
       (.I0(\rp[3]_i_2__4_n_0 ),
        .I1(\u8/rp_reg_n_0_[0] ),
        .I2(\u8/p_0_in [0]),
        .I3(\u8/p_0_in [1]),
        .I4(\u8/rp_reg_n_0_[3] ),
        .O(p_0_in__7[3]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT5 #(
    .INIT(32'hFFFFFFBF)) 
    \rp[3]_i_2 
       (.I0(\u14/u0/en_out_l2_reg_n_0 ),
        .I1(out_slt0[12]),
        .I2(valid_s),
        .I3(o3_mode[1]),
        .I4(o3_mode[0]),
        .O(\rp[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT5 #(
    .INIT(32'hFFFFFFBF)) 
    \rp[3]_i_2__0 
       (.I0(\u14/u1/en_out_l2_reg_n_0 ),
        .I1(out_slt0[11]),
        .I2(valid_s),
        .I3(o4_mode[1]),
        .I4(o4_mode[0]),
        .O(\rp[3]_i_2__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT5 #(
    .INIT(32'hFFFFFFBF)) 
    \rp[3]_i_2__1 
       (.I0(\u14/u2/en_out_l2_reg_n_0 ),
        .I1(out_slt0[9]),
        .I2(valid_s),
        .I3(o6_mode[1]),
        .I4(o6_mode[0]),
        .O(\rp[3]_i_2__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT5 #(
    .INIT(32'hFFFFFFBF)) 
    \rp[3]_i_2__2 
       (.I0(\u14/u3/en_out_l2_reg_n_0 ),
        .I1(out_slt0[8]),
        .I2(valid_s),
        .I3(o7_mode[1]),
        .I4(o7_mode[0]),
        .O(\rp[3]_i_2__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT5 #(
    .INIT(32'hFFFFFFBF)) 
    \rp[3]_i_2__3 
       (.I0(\u14/u4/en_out_l2_reg_n_0 ),
        .I1(out_slt0[7]),
        .I2(valid_s),
        .I3(o8_mode[1]),
        .I4(o8_mode[0]),
        .O(\rp[3]_i_2__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT5 #(
    .INIT(32'hFFFFFFBF)) 
    \rp[3]_i_2__4 
       (.I0(\u14/u5/en_out_l2_reg_n_0 ),
        .I1(out_slt0[6]),
        .I2(valid_s),
        .I3(o9_mode[1]),
        .I4(o9_mode[0]),
        .O(\rp[3]_i_2__4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair215" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt0_r[11]_i_1 
       (.I0(out_slt0[11]),
        .I1(ld),
        .I2(\u0/slt0_r [10]),
        .O(\slt0_r[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair215" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt0_r[12]_i_1 
       (.I0(out_slt0[12]),
        .I1(ld),
        .I2(\u0/slt0_r [11]),
        .O(\slt0_r[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair214" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt0_r[13]_i_1 
       (.I0(out_slt0[13]),
        .I1(ld),
        .I2(\u0/slt0_r [12]),
        .O(\slt0_r[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair214" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt0_r[14]_i_1 
       (.I0(out_slt0[14]),
        .I1(ld),
        .I2(\u0/slt0_r [13]),
        .O(\slt0_r[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFAAFFFCFFAA)) 
    \slt0_r[15]_i_1 
       (.I0(\u0/slt0_r [14]),
        .I1(out_slt0[6]),
        .I2(out_slt0[7]),
        .I3(\slt0_r[15]_i_2_n_0 ),
        .I4(ld),
        .I5(out_slt0[8]),
        .O(\slt0_r[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF0000FFFE0000)) 
    \slt0_r[15]_i_2 
       (.I0(out_slt0[9]),
        .I1(out_slt0[13]),
        .I2(out_slt0[14]),
        .I3(out_slt0[12]),
        .I4(ld),
        .I5(out_slt0[11]),
        .O(\slt0_r[15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair217" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt0_r[6]_i_1 
       (.I0(out_slt0[6]),
        .I1(ld),
        .I2(\u0/slt0_r [5]),
        .O(\slt0_r[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair217" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt0_r[7]_i_1 
       (.I0(out_slt0[7]),
        .I1(ld),
        .I2(\u0/slt0_r [6]),
        .O(\slt0_r[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair216" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt0_r[8]_i_1 
       (.I0(out_slt0[8]),
        .I1(ld),
        .I2(\u0/slt0_r [7]),
        .O(\slt0_r[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair216" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt0_r[9]_i_1 
       (.I0(out_slt0[9]),
        .I1(ld),
        .I2(\u0/slt0_r [8]),
        .O(\slt0_r[9]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair213" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt1_r[12]_i_1 
       (.I0(crac_out[16]),
        .I1(ld),
        .I2(\u0/slt1_r [11]),
        .O(\slt1_r[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair213" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt1_r[13]_i_1 
       (.I0(crac_out[17]),
        .I1(ld),
        .I2(\u0/slt1_r [12]),
        .O(\slt1_r[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair212" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt1_r[14]_i_1 
       (.I0(crac_out[18]),
        .I1(ld),
        .I2(\u0/slt1_r [13]),
        .O(\slt1_r[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair212" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt1_r[15]_i_1 
       (.I0(crac_out[19]),
        .I1(ld),
        .I2(\u0/slt1_r [14]),
        .O(\slt1_r[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair211" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt1_r[16]_i_1 
       (.I0(crac_out[20]),
        .I1(ld),
        .I2(\u0/slt1_r [15]),
        .O(\slt1_r[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair211" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt1_r[17]_i_1 
       (.I0(crac_out[21]),
        .I1(ld),
        .I2(\u0/slt1_r [16]),
        .O(\slt1_r[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair210" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt1_r[18]_i_1 
       (.I0(crac_out[22]),
        .I1(ld),
        .I2(\u0/slt1_r [17]),
        .O(\slt1_r[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair210" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt1_r[19]_i_1 
       (.I0(crac_out[31]),
        .I1(ld),
        .I2(\u0/slt1_r [18]),
        .O(\slt1_r[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair206" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt2_r[10]_i_1 
       (.I0(crac_out[6]),
        .I1(ld),
        .I2(\u0/slt2_r [9]),
        .O(\slt2_r[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair206" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt2_r[11]_i_1 
       (.I0(crac_out[7]),
        .I1(ld),
        .I2(\u0/slt2_r [10]),
        .O(\slt2_r[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair205" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt2_r[12]_i_1 
       (.I0(crac_out[8]),
        .I1(ld),
        .I2(\u0/slt2_r [11]),
        .O(\slt2_r[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair205" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt2_r[13]_i_1 
       (.I0(crac_out[9]),
        .I1(ld),
        .I2(\u0/slt2_r [12]),
        .O(\slt2_r[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair204" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt2_r[14]_i_1 
       (.I0(crac_out[10]),
        .I1(ld),
        .I2(\u0/slt2_r [13]),
        .O(\slt2_r[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair204" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt2_r[15]_i_1 
       (.I0(crac_out[11]),
        .I1(ld),
        .I2(\u0/slt2_r [14]),
        .O(\slt2_r[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair203" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt2_r[16]_i_1 
       (.I0(crac_out[12]),
        .I1(ld),
        .I2(\u0/slt2_r [15]),
        .O(\slt2_r[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair203" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt2_r[17]_i_1 
       (.I0(crac_out[13]),
        .I1(ld),
        .I2(\u0/slt2_r [16]),
        .O(\slt2_r[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair202" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt2_r[18]_i_1 
       (.I0(crac_out[14]),
        .I1(ld),
        .I2(\u0/slt2_r [17]),
        .O(\slt2_r[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair202" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt2_r[19]_i_1 
       (.I0(crac_out[15]),
        .I1(ld),
        .I2(\u0/slt2_r [18]),
        .O(\slt2_r[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair209" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt2_r[4]_i_1 
       (.I0(crac_out[0]),
        .I1(ld),
        .I2(\u0/slt2_r [3]),
        .O(\slt2_r[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair209" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt2_r[5]_i_1 
       (.I0(crac_out[1]),
        .I1(ld),
        .I2(\u0/slt2_r [4]),
        .O(\slt2_r[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair208" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt2_r[6]_i_1 
       (.I0(crac_out[2]),
        .I1(ld),
        .I2(\u0/slt2_r [5]),
        .O(\slt2_r[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair208" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt2_r[7]_i_1 
       (.I0(crac_out[3]),
        .I1(ld),
        .I2(\u0/slt2_r [6]),
        .O(\slt2_r[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair207" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt2_r[8]_i_1 
       (.I0(crac_out[4]),
        .I1(ld),
        .I2(\u0/slt2_r [7]),
        .O(\slt2_r[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair207" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt2_r[9]_i_1 
       (.I0(crac_out[5]),
        .I1(ld),
        .I2(\u0/slt2_r [8]),
        .O(\slt2_r[9]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair201" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[0]_i_1 
       (.I0(out_slt3[0]),
        .I1(ld),
        .I2(\u0/slt4_r [19]),
        .O(\slt3_r[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair196" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[10]_i_1 
       (.I0(out_slt3[10]),
        .I1(ld),
        .I2(\u0/slt3_r [9]),
        .O(\slt3_r[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair196" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[11]_i_1 
       (.I0(out_slt3[11]),
        .I1(ld),
        .I2(\u0/slt3_r [10]),
        .O(\slt3_r[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair195" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[12]_i_1 
       (.I0(out_slt3[12]),
        .I1(ld),
        .I2(\u0/slt3_r [11]),
        .O(\slt3_r[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair195" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[13]_i_1 
       (.I0(out_slt3[13]),
        .I1(ld),
        .I2(\u0/slt3_r [12]),
        .O(\slt3_r[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair194" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[14]_i_1 
       (.I0(out_slt3[14]),
        .I1(ld),
        .I2(\u0/slt3_r [13]),
        .O(\slt3_r[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair194" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[15]_i_1 
       (.I0(out_slt3[15]),
        .I1(ld),
        .I2(\u0/slt3_r [14]),
        .O(\slt3_r[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair193" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[16]_i_1 
       (.I0(out_slt3[16]),
        .I1(ld),
        .I2(\u0/slt3_r [15]),
        .O(\slt3_r[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair193" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[17]_i_1 
       (.I0(out_slt3[17]),
        .I1(ld),
        .I2(\u0/slt3_r [16]),
        .O(\slt3_r[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair192" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[18]_i_1 
       (.I0(out_slt3[18]),
        .I1(ld),
        .I2(\u0/slt3_r [17]),
        .O(\slt3_r[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair192" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[19]_i_1 
       (.I0(out_slt3[19]),
        .I1(ld),
        .I2(\u0/slt3_r [18]),
        .O(\slt3_r[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair201" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[1]_i_1 
       (.I0(out_slt3[1]),
        .I1(ld),
        .I2(\u0/slt3_r [0]),
        .O(\slt3_r[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair200" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[2]_i_1 
       (.I0(out_slt3[2]),
        .I1(ld),
        .I2(\u0/slt3_r [1]),
        .O(\slt3_r[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair200" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[3]_i_1 
       (.I0(out_slt3[3]),
        .I1(ld),
        .I2(\u0/slt3_r [2]),
        .O(\slt3_r[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair199" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[4]_i_1 
       (.I0(out_slt3[4]),
        .I1(ld),
        .I2(\u0/slt3_r [3]),
        .O(\slt3_r[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair199" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[5]_i_1 
       (.I0(out_slt3[5]),
        .I1(ld),
        .I2(\u0/slt3_r [4]),
        .O(\slt3_r[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair198" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[6]_i_1 
       (.I0(out_slt3[6]),
        .I1(ld),
        .I2(\u0/slt3_r [5]),
        .O(\slt3_r[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair198" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[7]_i_1 
       (.I0(out_slt3[7]),
        .I1(ld),
        .I2(\u0/slt3_r [6]),
        .O(\slt3_r[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair197" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[8]_i_1 
       (.I0(out_slt3[8]),
        .I1(ld),
        .I2(\u0/slt3_r [7]),
        .O(\slt3_r[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair197" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt3_r[9]_i_1 
       (.I0(out_slt3[9]),
        .I1(ld),
        .I2(\u0/slt3_r [8]),
        .O(\slt3_r[9]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair191" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[0]_i_1 
       (.I0(out_slt4[0]),
        .I1(ld),
        .I2(\u0/slt5_r ),
        .O(\slt4_r[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair186" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[10]_i_1 
       (.I0(out_slt4[10]),
        .I1(ld),
        .I2(\u0/slt4_r [9]),
        .O(\slt4_r[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair186" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[11]_i_1 
       (.I0(out_slt4[11]),
        .I1(ld),
        .I2(\u0/slt4_r [10]),
        .O(\slt4_r[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair185" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[12]_i_1 
       (.I0(out_slt4[12]),
        .I1(ld),
        .I2(\u0/slt4_r [11]),
        .O(\slt4_r[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair185" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[13]_i_1 
       (.I0(out_slt4[13]),
        .I1(ld),
        .I2(\u0/slt4_r [12]),
        .O(\slt4_r[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair184" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[14]_i_1 
       (.I0(out_slt4[14]),
        .I1(ld),
        .I2(\u0/slt4_r [13]),
        .O(\slt4_r[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair184" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[15]_i_1 
       (.I0(out_slt4[15]),
        .I1(ld),
        .I2(\u0/slt4_r [14]),
        .O(\slt4_r[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair183" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[16]_i_1 
       (.I0(out_slt4[16]),
        .I1(ld),
        .I2(\u0/slt4_r [15]),
        .O(\slt4_r[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair183" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[17]_i_1 
       (.I0(out_slt4[17]),
        .I1(ld),
        .I2(\u0/slt4_r [16]),
        .O(\slt4_r[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair182" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[18]_i_1 
       (.I0(out_slt4[18]),
        .I1(ld),
        .I2(\u0/slt4_r [17]),
        .O(\slt4_r[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair182" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[19]_i_1 
       (.I0(out_slt4[19]),
        .I1(ld),
        .I2(\u0/slt4_r [18]),
        .O(\slt4_r[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair191" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[1]_i_1 
       (.I0(out_slt4[1]),
        .I1(ld),
        .I2(\u0/slt4_r [0]),
        .O(\slt4_r[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair190" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[2]_i_1 
       (.I0(out_slt4[2]),
        .I1(ld),
        .I2(\u0/slt4_r [1]),
        .O(\slt4_r[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair190" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[3]_i_1 
       (.I0(out_slt4[3]),
        .I1(ld),
        .I2(\u0/slt4_r [2]),
        .O(\slt4_r[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair189" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[4]_i_1 
       (.I0(out_slt4[4]),
        .I1(ld),
        .I2(\u0/slt4_r [3]),
        .O(\slt4_r[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair189" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[5]_i_1 
       (.I0(out_slt4[5]),
        .I1(ld),
        .I2(\u0/slt4_r [4]),
        .O(\slt4_r[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair188" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[6]_i_1 
       (.I0(out_slt4[6]),
        .I1(ld),
        .I2(\u0/slt4_r [5]),
        .O(\slt4_r[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair188" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[7]_i_1 
       (.I0(out_slt4[7]),
        .I1(ld),
        .I2(\u0/slt4_r [6]),
        .O(\slt4_r[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair187" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[8]_i_1 
       (.I0(out_slt4[8]),
        .I1(ld),
        .I2(\u0/slt4_r [7]),
        .O(\slt4_r[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair187" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt4_r[9]_i_1 
       (.I0(out_slt4[9]),
        .I1(ld),
        .I2(\u0/slt4_r [8]),
        .O(\slt4_r[9]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair181" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[0]_i_1 
       (.I0(out_slt6[0]),
        .I1(ld),
        .I2(\u0/slt7_r [19]),
        .O(\slt6_r[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair176" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[10]_i_1 
       (.I0(out_slt6[10]),
        .I1(ld),
        .I2(\u0/slt6_r [9]),
        .O(\slt6_r[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair176" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[11]_i_1 
       (.I0(out_slt6[11]),
        .I1(ld),
        .I2(\u0/slt6_r [10]),
        .O(\slt6_r[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair175" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[12]_i_1 
       (.I0(out_slt6[12]),
        .I1(ld),
        .I2(\u0/slt6_r [11]),
        .O(\slt6_r[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair175" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[13]_i_1 
       (.I0(out_slt6[13]),
        .I1(ld),
        .I2(\u0/slt6_r [12]),
        .O(\slt6_r[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair174" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[14]_i_1 
       (.I0(out_slt6[14]),
        .I1(ld),
        .I2(\u0/slt6_r [13]),
        .O(\slt6_r[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair174" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[15]_i_1 
       (.I0(out_slt6[15]),
        .I1(ld),
        .I2(\u0/slt6_r [14]),
        .O(\slt6_r[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair173" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[16]_i_1 
       (.I0(out_slt6[16]),
        .I1(ld),
        .I2(\u0/slt6_r [15]),
        .O(\slt6_r[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair173" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[17]_i_1 
       (.I0(out_slt6[17]),
        .I1(ld),
        .I2(\u0/slt6_r [16]),
        .O(\slt6_r[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair172" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[18]_i_1 
       (.I0(out_slt6[18]),
        .I1(ld),
        .I2(\u0/slt6_r [17]),
        .O(\slt6_r[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair172" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[19]_i_1 
       (.I0(out_slt6[19]),
        .I1(ld),
        .I2(\u0/slt6_r [18]),
        .O(\slt6_r[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair181" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[1]_i_1 
       (.I0(out_slt6[1]),
        .I1(ld),
        .I2(\u0/slt6_r [0]),
        .O(\slt6_r[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair180" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[2]_i_1 
       (.I0(out_slt6[2]),
        .I1(ld),
        .I2(\u0/slt6_r [1]),
        .O(\slt6_r[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair180" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[3]_i_1 
       (.I0(out_slt6[3]),
        .I1(ld),
        .I2(\u0/slt6_r [2]),
        .O(\slt6_r[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair179" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[4]_i_1 
       (.I0(out_slt6[4]),
        .I1(ld),
        .I2(\u0/slt6_r [3]),
        .O(\slt6_r[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair179" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[5]_i_1 
       (.I0(out_slt6[5]),
        .I1(ld),
        .I2(\u0/slt6_r [4]),
        .O(\slt6_r[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair178" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[6]_i_1 
       (.I0(out_slt6[6]),
        .I1(ld),
        .I2(\u0/slt6_r [5]),
        .O(\slt6_r[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair178" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[7]_i_1 
       (.I0(out_slt6[7]),
        .I1(ld),
        .I2(\u0/slt6_r [6]),
        .O(\slt6_r[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair177" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[8]_i_1 
       (.I0(out_slt6[8]),
        .I1(ld),
        .I2(\u0/slt6_r [7]),
        .O(\slt6_r[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair177" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt6_r[9]_i_1 
       (.I0(out_slt6[9]),
        .I1(ld),
        .I2(\u0/slt6_r [8]),
        .O(\slt6_r[9]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair171" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[0]_i_1 
       (.I0(out_slt7[0]),
        .I1(ld),
        .I2(\u0/slt8_r [19]),
        .O(\slt7_r[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair166" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[10]_i_1 
       (.I0(out_slt7[10]),
        .I1(ld),
        .I2(\u0/slt7_r [9]),
        .O(\slt7_r[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair166" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[11]_i_1 
       (.I0(out_slt7[11]),
        .I1(ld),
        .I2(\u0/slt7_r [10]),
        .O(\slt7_r[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair165" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[12]_i_1 
       (.I0(out_slt7[12]),
        .I1(ld),
        .I2(\u0/slt7_r [11]),
        .O(\slt7_r[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair165" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[13]_i_1 
       (.I0(out_slt7[13]),
        .I1(ld),
        .I2(\u0/slt7_r [12]),
        .O(\slt7_r[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair164" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[14]_i_1 
       (.I0(out_slt7[14]),
        .I1(ld),
        .I2(\u0/slt7_r [13]),
        .O(\slt7_r[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair164" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[15]_i_1 
       (.I0(out_slt7[15]),
        .I1(ld),
        .I2(\u0/slt7_r [14]),
        .O(\slt7_r[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair163" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[16]_i_1 
       (.I0(out_slt7[16]),
        .I1(ld),
        .I2(\u0/slt7_r [15]),
        .O(\slt7_r[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair163" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[17]_i_1 
       (.I0(out_slt7[17]),
        .I1(ld),
        .I2(\u0/slt7_r [16]),
        .O(\slt7_r[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair162" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[18]_i_1 
       (.I0(out_slt7[18]),
        .I1(ld),
        .I2(\u0/slt7_r [17]),
        .O(\slt7_r[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair162" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[19]_i_1 
       (.I0(out_slt7[19]),
        .I1(ld),
        .I2(\u0/slt7_r [18]),
        .O(\slt7_r[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair171" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[1]_i_1 
       (.I0(out_slt7[1]),
        .I1(ld),
        .I2(\u0/slt7_r [0]),
        .O(\slt7_r[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair170" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[2]_i_1 
       (.I0(out_slt7[2]),
        .I1(ld),
        .I2(\u0/slt7_r [1]),
        .O(\slt7_r[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair170" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[3]_i_1 
       (.I0(out_slt7[3]),
        .I1(ld),
        .I2(\u0/slt7_r [2]),
        .O(\slt7_r[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair169" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[4]_i_1 
       (.I0(out_slt7[4]),
        .I1(ld),
        .I2(\u0/slt7_r [3]),
        .O(\slt7_r[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair169" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[5]_i_1 
       (.I0(out_slt7[5]),
        .I1(ld),
        .I2(\u0/slt7_r [4]),
        .O(\slt7_r[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair168" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[6]_i_1 
       (.I0(out_slt7[6]),
        .I1(ld),
        .I2(\u0/slt7_r [5]),
        .O(\slt7_r[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair168" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[7]_i_1 
       (.I0(out_slt7[7]),
        .I1(ld),
        .I2(\u0/slt7_r [6]),
        .O(\slt7_r[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair167" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[8]_i_1 
       (.I0(out_slt7[8]),
        .I1(ld),
        .I2(\u0/slt7_r [7]),
        .O(\slt7_r[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair167" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt7_r[9]_i_1 
       (.I0(out_slt7[9]),
        .I1(ld),
        .I2(\u0/slt7_r [8]),
        .O(\slt7_r[9]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair161" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[0]_i_1 
       (.I0(out_slt8[0]),
        .I1(ld),
        .I2(\u0/slt9_r [19]),
        .O(\slt8_r[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair156" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[10]_i_1 
       (.I0(out_slt8[10]),
        .I1(ld),
        .I2(\u0/slt8_r [9]),
        .O(\slt8_r[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair156" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[11]_i_1 
       (.I0(out_slt8[11]),
        .I1(ld),
        .I2(\u0/slt8_r [10]),
        .O(\slt8_r[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair155" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[12]_i_1 
       (.I0(out_slt8[12]),
        .I1(ld),
        .I2(\u0/slt8_r [11]),
        .O(\slt8_r[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair155" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[13]_i_1 
       (.I0(out_slt8[13]),
        .I1(ld),
        .I2(\u0/slt8_r [12]),
        .O(\slt8_r[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair154" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[14]_i_1 
       (.I0(out_slt8[14]),
        .I1(ld),
        .I2(\u0/slt8_r [13]),
        .O(\slt8_r[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair154" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[15]_i_1 
       (.I0(out_slt8[15]),
        .I1(ld),
        .I2(\u0/slt8_r [14]),
        .O(\slt8_r[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair153" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[16]_i_1 
       (.I0(out_slt8[16]),
        .I1(ld),
        .I2(\u0/slt8_r [15]),
        .O(\slt8_r[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair153" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[17]_i_1 
       (.I0(out_slt8[17]),
        .I1(ld),
        .I2(\u0/slt8_r [16]),
        .O(\slt8_r[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair152" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[18]_i_1 
       (.I0(out_slt8[18]),
        .I1(ld),
        .I2(\u0/slt8_r [17]),
        .O(\slt8_r[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair152" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[19]_i_1 
       (.I0(out_slt8[19]),
        .I1(ld),
        .I2(\u0/slt8_r [18]),
        .O(\slt8_r[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair161" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[1]_i_1 
       (.I0(out_slt8[1]),
        .I1(ld),
        .I2(\u0/slt8_r [0]),
        .O(\slt8_r[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair160" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[2]_i_1 
       (.I0(out_slt8[2]),
        .I1(ld),
        .I2(\u0/slt8_r [1]),
        .O(\slt8_r[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair160" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[3]_i_1 
       (.I0(out_slt8[3]),
        .I1(ld),
        .I2(\u0/slt8_r [2]),
        .O(\slt8_r[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair159" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[4]_i_1 
       (.I0(out_slt8[4]),
        .I1(ld),
        .I2(\u0/slt8_r [3]),
        .O(\slt8_r[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair159" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[5]_i_1 
       (.I0(out_slt8[5]),
        .I1(ld),
        .I2(\u0/slt8_r [4]),
        .O(\slt8_r[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair158" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[6]_i_1 
       (.I0(out_slt8[6]),
        .I1(ld),
        .I2(\u0/slt8_r [5]),
        .O(\slt8_r[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair158" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[7]_i_1 
       (.I0(out_slt8[7]),
        .I1(ld),
        .I2(\u0/slt8_r [6]),
        .O(\slt8_r[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair157" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[8]_i_1 
       (.I0(out_slt8[8]),
        .I1(ld),
        .I2(\u0/slt8_r [7]),
        .O(\slt8_r[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair157" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt8_r[9]_i_1 
       (.I0(out_slt8[9]),
        .I1(ld),
        .I2(\u0/slt8_r [8]),
        .O(\slt8_r[9]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair142" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \slt9_r[0]_i_1 
       (.I0(out_slt9[0]),
        .I1(ld),
        .O(\slt9_r[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair147" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[10]_i_1 
       (.I0(out_slt9[10]),
        .I1(ld),
        .I2(\u0/slt9_r [9]),
        .O(\u0/p_0_in [10]));
  (* SOFT_HLUTNM = "soft_lutpair146" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[11]_i_1 
       (.I0(out_slt9[11]),
        .I1(ld),
        .I2(\u0/slt9_r [10]),
        .O(\u0/p_0_in [11]));
  (* SOFT_HLUTNM = "soft_lutpair146" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[12]_i_1 
       (.I0(out_slt9[12]),
        .I1(ld),
        .I2(\u0/slt9_r [11]),
        .O(\u0/p_0_in [12]));
  (* SOFT_HLUTNM = "soft_lutpair145" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[13]_i_1 
       (.I0(out_slt9[13]),
        .I1(ld),
        .I2(\u0/slt9_r [12]),
        .O(\u0/p_0_in [13]));
  (* SOFT_HLUTNM = "soft_lutpair145" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[14]_i_1 
       (.I0(out_slt9[14]),
        .I1(ld),
        .I2(\u0/slt9_r [13]),
        .O(\u0/p_0_in [14]));
  (* SOFT_HLUTNM = "soft_lutpair144" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[15]_i_1 
       (.I0(out_slt9[15]),
        .I1(ld),
        .I2(\u0/slt9_r [14]),
        .O(\u0/p_0_in [15]));
  (* SOFT_HLUTNM = "soft_lutpair144" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[16]_i_1 
       (.I0(out_slt9[16]),
        .I1(ld),
        .I2(\u0/slt9_r [15]),
        .O(\u0/p_0_in [16]));
  (* SOFT_HLUTNM = "soft_lutpair143" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[17]_i_1 
       (.I0(out_slt9[17]),
        .I1(ld),
        .I2(\u0/slt9_r [16]),
        .O(\u0/p_0_in [17]));
  (* SOFT_HLUTNM = "soft_lutpair143" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[18]_i_1 
       (.I0(out_slt9[18]),
        .I1(ld),
        .I2(\u0/slt9_r [17]),
        .O(\u0/p_0_in [18]));
  (* SOFT_HLUTNM = "soft_lutpair142" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[19]_i_1 
       (.I0(out_slt9[19]),
        .I1(ld),
        .I2(\u0/slt9_r [18]),
        .O(\u0/p_0_in [19]));
  (* SOFT_HLUTNM = "soft_lutpair151" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[1]_i_1 
       (.I0(out_slt9[1]),
        .I1(ld),
        .I2(\u0/slt9_r [0]),
        .O(\u0/p_0_in [1]));
  (* SOFT_HLUTNM = "soft_lutpair151" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[2]_i_1 
       (.I0(out_slt9[2]),
        .I1(ld),
        .I2(\u0/slt9_r [1]),
        .O(\u0/p_0_in [2]));
  (* SOFT_HLUTNM = "soft_lutpair150" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[3]_i_1 
       (.I0(out_slt9[3]),
        .I1(ld),
        .I2(\u0/slt9_r [2]),
        .O(\u0/p_0_in [3]));
  (* SOFT_HLUTNM = "soft_lutpair150" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[4]_i_1 
       (.I0(out_slt9[4]),
        .I1(ld),
        .I2(\u0/slt9_r [3]),
        .O(\u0/p_0_in [4]));
  (* SOFT_HLUTNM = "soft_lutpair149" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[5]_i_1 
       (.I0(out_slt9[5]),
        .I1(ld),
        .I2(\u0/slt9_r [4]),
        .O(\u0/p_0_in [5]));
  (* SOFT_HLUTNM = "soft_lutpair149" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[6]_i_1 
       (.I0(out_slt9[6]),
        .I1(ld),
        .I2(\u0/slt9_r [5]),
        .O(\u0/p_0_in [6]));
  (* SOFT_HLUTNM = "soft_lutpair148" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[7]_i_1 
       (.I0(out_slt9[7]),
        .I1(ld),
        .I2(\u0/slt9_r [6]),
        .O(\u0/p_0_in [7]));
  (* SOFT_HLUTNM = "soft_lutpair148" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[8]_i_1 
       (.I0(out_slt9[8]),
        .I1(ld),
        .I2(\u0/slt9_r [7]),
        .O(\u0/p_0_in [8]));
  (* SOFT_HLUTNM = "soft_lutpair147" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slt9_r[9]_i_1 
       (.I0(out_slt9[9]),
        .I1(ld),
        .I2(\u0/slt9_r [8]),
        .O(\u0/p_0_in [9]));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \status[0]_i_1 
       (.I0(\u3/wp_reg_n_0_[0] ),
        .I1(\u3/p_0_in [0]),
        .O(\status[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \status[0]_i_1__0 
       (.I0(\u4/wp_reg_n_0_[0] ),
        .I1(\u4/p_0_in [0]),
        .O(\status[0]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \status[0]_i_1__1 
       (.I0(\u5/wp_reg_n_0_[0] ),
        .I1(\u5/p_0_in [0]),
        .O(\status[0]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \status[0]_i_1__2 
       (.I0(\u6/wp_reg_n_0_[0] ),
        .I1(\u6/p_0_in [0]),
        .O(\status[0]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \status[0]_i_1__3 
       (.I0(\u7/wp_reg_n_0_[0] ),
        .I1(\u7/p_0_in [0]),
        .O(\status[0]_i_1__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \status[0]_i_1__4 
       (.I0(\u8/wp_reg_n_0_[0] ),
        .I1(\u8/p_0_in [0]),
        .O(\status[0]_i_1__4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \status[0]_i_1__5 
       (.I0(\u11/rp_reg_n_0_[0] ),
        .I1(\u11/p_1_in [0]),
        .O(\status[0]_i_1__5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \status[0]_i_1__6 
       (.I0(\u10/rp_reg_n_0_[0] ),
        .I1(\u10/p_1_in [0]),
        .O(\status[0]_i_1__6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \status[0]_i_1__7 
       (.I0(\u9/rp_reg_n_0_[0] ),
        .I1(\u9/p_1_in [0]),
        .O(\status[0]_i_1__7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT4 #(
    .INIT(16'hB44B)) 
    \status[1]_i_1 
       (.I0(\u3/p_0_in [0]),
        .I1(\u3/wp_reg_n_0_[0] ),
        .I2(\u3/p_0_in [1]),
        .I3(\u3/wp_reg_n_0_[1] ),
        .O(\u3/status0 ));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT4 #(
    .INIT(16'hB44B)) 
    \status[1]_i_1__0 
       (.I0(\u4/p_0_in [0]),
        .I1(\u4/wp_reg_n_0_[0] ),
        .I2(\u4/p_0_in [1]),
        .I3(\u4/wp_reg_n_0_[1] ),
        .O(\u4/status0 ));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT4 #(
    .INIT(16'hB44B)) 
    \status[1]_i_1__1 
       (.I0(\u5/p_0_in [0]),
        .I1(\u5/wp_reg_n_0_[0] ),
        .I2(\u5/p_0_in [1]),
        .I3(\u5/wp_reg_n_0_[1] ),
        .O(\u5/status0 ));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT4 #(
    .INIT(16'hB44B)) 
    \status[1]_i_1__2 
       (.I0(\u6/p_0_in [0]),
        .I1(\u6/wp_reg_n_0_[0] ),
        .I2(\u6/p_0_in [1]),
        .I3(\u6/wp_reg_n_0_[1] ),
        .O(\u6/status0 ));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT4 #(
    .INIT(16'hB44B)) 
    \status[1]_i_1__3 
       (.I0(\u7/p_0_in [0]),
        .I1(\u7/wp_reg_n_0_[0] ),
        .I2(\u7/p_0_in [1]),
        .I3(\u7/wp_reg_n_0_[1] ),
        .O(\u7/status0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT4 #(
    .INIT(16'hB44B)) 
    \status[1]_i_1__4 
       (.I0(\u8/p_0_in [0]),
        .I1(\u8/wp_reg_n_0_[0] ),
        .I2(\u8/p_0_in [1]),
        .I3(\u8/wp_reg_n_0_[1] ),
        .O(\u8/status0 ));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT4 #(
    .INIT(16'hB44B)) 
    \status[1]_i_1__5 
       (.I0(\u9/p_1_in [0]),
        .I1(\u9/rp_reg_n_0_[0] ),
        .I2(\u9/p_1_in [1]),
        .I3(\u9/rp_reg_n_0_[1] ),
        .O(\u9/status0 ));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT4 #(
    .INIT(16'hB44B)) 
    \status[1]_i_1__6 
       (.I0(\u10/p_1_in [0]),
        .I1(\u10/rp_reg_n_0_[0] ),
        .I2(\u10/p_1_in [1]),
        .I3(\u10/rp_reg_n_0_[1] ),
        .O(\u10/status0 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT4 #(
    .INIT(16'hB44B)) 
    \status[1]_i_1__7 
       (.I0(\u11/p_1_in [0]),
        .I1(\u11/rp_reg_n_0_[0] ),
        .I2(\u11/p_1_in [1]),
        .I3(\u11/rp_reg_n_0_[1] ),
        .O(\u11/status0 ));
  LUT6 #(
    .INIT(64'h0000001000000000)) 
    suspended_i_1
       (.I0(\u2/to_cnt_reg [2]),
        .I1(\u2/to_cnt_reg [3]),
        .I2(\u2/to_cnt_reg [0]),
        .I3(\u2/to_cnt_reg [1]),
        .I4(\u2/to_cnt_reg [4]),
        .I5(\u2/to_cnt_reg [5]),
        .O(\u2/to ));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    sync_beat_i_1
       (.I0(\u2/cnt_reg [7]),
        .I1(\u2/cnt_reg [6]),
        .I2(\u2/cnt_reg [5]),
        .I3(\u2/cnt_reg [4]),
        .O(\u2/sync_beat0 ));
  LUT2 #(
    .INIT(4'hE)) 
    sync_pad_o_INST_0
       (.I0(\u2/sync_beat ),
        .I1(\u2/sync_resume_reg_n_0 ),
        .O(sync_pad_o));
  LUT4 #(
    .INIT(16'hF080)) 
    sync_resume_i_1
       (.I0(resume_req),
        .I1(suspended_o),
        .I2(sync_resume_i_2_n_0),
        .I3(\u2/sync_resume_reg_n_0 ),
        .O(sync_resume_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT4 #(
    .INIT(16'hEFFF)) 
    sync_resume_i_2
       (.I0(\u2/res_cnt_reg [3]),
        .I1(\u2/res_cnt_reg [1]),
        .I2(\u2/res_cnt_reg [2]),
        .I3(\u2/res_cnt_reg [0]),
        .O(sync_resume_i_2_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    \to_cnt[0]_i_1 
       (.I0(\u2/to_cnt_reg [0]),
        .I1(\u2/bit_clk_e ),
        .O(\to_cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair125" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \to_cnt[1]_i_1 
       (.I0(\u2/to_cnt_reg [1]),
        .I1(\u2/to_cnt_reg [0]),
        .I2(\u2/bit_clk_e ),
        .O(p_0_in__3[1]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'h006A)) 
    \to_cnt[2]_i_1 
       (.I0(\u2/to_cnt_reg [2]),
        .I1(\u2/to_cnt_reg [0]),
        .I2(\u2/to_cnt_reg [1]),
        .I3(\u2/bit_clk_e ),
        .O(p_0_in__3[2]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h00006AAA)) 
    \to_cnt[3]_i_1 
       (.I0(\u2/to_cnt_reg [3]),
        .I1(\u2/to_cnt_reg [1]),
        .I2(\u2/to_cnt_reg [0]),
        .I3(\u2/to_cnt_reg [2]),
        .I4(\u2/bit_clk_e ),
        .O(p_0_in__3[3]));
  LUT6 #(
    .INIT(64'h000000006AAAAAAA)) 
    \to_cnt[4]_i_1 
       (.I0(\u2/to_cnt_reg [4]),
        .I1(\u2/to_cnt_reg [3]),
        .I2(\u2/to_cnt_reg [2]),
        .I3(\u2/to_cnt_reg [1]),
        .I4(\u2/to_cnt_reg [0]),
        .I5(\u2/bit_clk_e ),
        .O(p_0_in__3[4]));
  LUT2 #(
    .INIT(4'hB)) 
    \to_cnt[5]_i_1 
       (.I0(\to_cnt[5]_i_3_n_0 ),
        .I1(\u2/to_cnt_reg [0]),
        .O(\to_cnt[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000000006AAAAAAA)) 
    \to_cnt[5]_i_2 
       (.I0(\u2/to_cnt_reg [5]),
        .I1(\u2/to_cnt_reg [2]),
        .I2(\u2/to_cnt_reg [3]),
        .I3(\u2/to_cnt_reg [4]),
        .I4(\to_cnt[5]_i_4_n_0 ),
        .I5(\u2/bit_clk_e ),
        .O(p_0_in__3[5]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFB)) 
    \to_cnt[5]_i_3 
       (.I0(\u2/bit_clk_e ),
        .I1(\u2/to_cnt_reg [5]),
        .I2(\u2/to_cnt_reg [3]),
        .I3(\u2/to_cnt_reg [4]),
        .I4(\u2/to_cnt_reg [2]),
        .I5(\u2/to_cnt_reg [1]),
        .O(\to_cnt[5]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair125" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \to_cnt[5]_i_4 
       (.I0(\u2/to_cnt_reg [0]),
        .I1(\u2/to_cnt_reg [1]),
        .O(\to_cnt[5]_i_4_n_0 ));
  FDRE \u0/slt0_r_reg[10] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt0_r [9]),
        .Q(\u0/slt0_r [10]),
        .R(ld));
  FDRE \u0/slt0_r_reg[11] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt0_r[11]_i_1_n_0 ),
        .Q(\u0/slt0_r [11]),
        .R(\<const0> ));
  FDRE \u0/slt0_r_reg[12] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt0_r[12]_i_1_n_0 ),
        .Q(\u0/slt0_r [12]),
        .R(\<const0> ));
  FDRE \u0/slt0_r_reg[13] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt0_r[13]_i_1_n_0 ),
        .Q(\u0/slt0_r [13]),
        .R(\<const0> ));
  FDRE \u0/slt0_r_reg[14] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt0_r[14]_i_1_n_0 ),
        .Q(\u0/slt0_r [14]),
        .R(\<const0> ));
  FDRE \u0/slt0_r_reg[15] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt0_r[15]_i_1_n_0 ),
        .Q(sdata_pad_o),
        .R(\<const0> ));
  (* srl_bus_name = "\u0/slt0_r_reg " *) 
  (* srl_name = "\u0/slt0_r_reg[3]_srl4___u0_slt5_r_reg_r_2 " *) 
  SRL16E \u0/slt0_r_reg[3]_srl4___u0_slt5_r_reg_r_2 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(\<const1> ),
        .CLK(bit_clk_pad_i),
        .D(\u0/slt1_r [19]),
        .Q(\u0/slt0_r_reg[3]_srl4___u0_slt5_r_reg_r_2_n_0 ));
  FDRE \u0/slt0_r_reg[4]_u0_slt5_r_reg_r_3 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt0_r_reg[3]_srl4___u0_slt5_r_reg_r_2_n_0 ),
        .Q(\u0/slt0_r_reg[4]_u0_slt5_r_reg_r_3_n_0 ),
        .R(\<const0> ));
  FDRE \u0/slt0_r_reg[5] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt0_r_reg_gate_n_0 ),
        .Q(\u0/slt0_r [5]),
        .R(ld));
  FDRE \u0/slt0_r_reg[6] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt0_r[6]_i_1_n_0 ),
        .Q(\u0/slt0_r [6]),
        .R(\<const0> ));
  FDRE \u0/slt0_r_reg[7] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt0_r[7]_i_1_n_0 ),
        .Q(\u0/slt0_r [7]),
        .R(\<const0> ));
  FDRE \u0/slt0_r_reg[8] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt0_r[8]_i_1_n_0 ),
        .Q(\u0/slt0_r [8]),
        .R(\<const0> ));
  FDRE \u0/slt0_r_reg[9] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt0_r[9]_i_1_n_0 ),
        .Q(\u0/slt0_r [9]),
        .R(\<const0> ));
  LUT2 #(
    .INIT(4'h8)) 
    \u0/slt0_r_reg_gate 
       (.I0(\u0/slt0_r_reg[4]_u0_slt5_r_reg_r_3_n_0 ),
        .I1(\u0/slt5_r_reg_r_3_n_0 ),
        .O(\u0/slt0_r_reg_gate_n_0 ));
  FDRE \u0/slt1_r_reg[10]_u0_slt5_r_reg_r_9 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt1_r_reg[9]_srl10___u0_slt5_r_reg_r_8_n_0 ),
        .Q(\u0/slt1_r_reg[10]_u0_slt5_r_reg_r_9_n_0 ),
        .R(\<const0> ));
  FDRE \u0/slt1_r_reg[11] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt1_r_reg_gate_n_0 ),
        .Q(\u0/slt1_r [11]),
        .R(ld));
  FDRE \u0/slt1_r_reg[12] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt1_r[12]_i_1_n_0 ),
        .Q(\u0/slt1_r [12]),
        .R(\<const0> ));
  FDRE \u0/slt1_r_reg[13] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt1_r[13]_i_1_n_0 ),
        .Q(\u0/slt1_r [13]),
        .R(\<const0> ));
  FDRE \u0/slt1_r_reg[14] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt1_r[14]_i_1_n_0 ),
        .Q(\u0/slt1_r [14]),
        .R(\<const0> ));
  FDRE \u0/slt1_r_reg[15] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt1_r[15]_i_1_n_0 ),
        .Q(\u0/slt1_r [15]),
        .R(\<const0> ));
  FDRE \u0/slt1_r_reg[16] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt1_r[16]_i_1_n_0 ),
        .Q(\u0/slt1_r [16]),
        .R(\<const0> ));
  FDRE \u0/slt1_r_reg[17] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt1_r[17]_i_1_n_0 ),
        .Q(\u0/slt1_r [17]),
        .R(\<const0> ));
  FDRE \u0/slt1_r_reg[18] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt1_r[18]_i_1_n_0 ),
        .Q(\u0/slt1_r [18]),
        .R(\<const0> ));
  FDRE \u0/slt1_r_reg[19] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt1_r[19]_i_1_n_0 ),
        .Q(\u0/slt1_r [19]),
        .R(\<const0> ));
  (* srl_bus_name = "\u0/slt1_r_reg " *) 
  (* srl_name = "\u0/slt1_r_reg[9]_srl10___u0_slt5_r_reg_r_8 " *) 
  SRL16E \u0/slt1_r_reg[9]_srl10___u0_slt5_r_reg_r_8 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const1> ),
        .CE(\<const1> ),
        .CLK(bit_clk_pad_i),
        .D(\u0/slt2_r [19]),
        .Q(\u0/slt1_r_reg[9]_srl10___u0_slt5_r_reg_r_8_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \u0/slt1_r_reg_gate 
       (.I0(\u0/slt1_r_reg[10]_u0_slt5_r_reg_r_9_n_0 ),
        .I1(\u0/slt5_r_reg_r_9_n_0 ),
        .O(\u0/slt1_r_reg_gate_n_0 ));
  FDRE \u0/slt2_r_reg[10] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt2_r[10]_i_1_n_0 ),
        .Q(\u0/slt2_r [10]),
        .R(\<const0> ));
  FDRE \u0/slt2_r_reg[11] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt2_r[11]_i_1_n_0 ),
        .Q(\u0/slt2_r [11]),
        .R(\<const0> ));
  FDRE \u0/slt2_r_reg[12] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt2_r[12]_i_1_n_0 ),
        .Q(\u0/slt2_r [12]),
        .R(\<const0> ));
  FDRE \u0/slt2_r_reg[13] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt2_r[13]_i_1_n_0 ),
        .Q(\u0/slt2_r [13]),
        .R(\<const0> ));
  FDRE \u0/slt2_r_reg[14] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt2_r[14]_i_1_n_0 ),
        .Q(\u0/slt2_r [14]),
        .R(\<const0> ));
  FDRE \u0/slt2_r_reg[15] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt2_r[15]_i_1_n_0 ),
        .Q(\u0/slt2_r [15]),
        .R(\<const0> ));
  FDRE \u0/slt2_r_reg[16] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt2_r[16]_i_1_n_0 ),
        .Q(\u0/slt2_r [16]),
        .R(\<const0> ));
  FDRE \u0/slt2_r_reg[17] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt2_r[17]_i_1_n_0 ),
        .Q(\u0/slt2_r [17]),
        .R(\<const0> ));
  FDRE \u0/slt2_r_reg[18] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt2_r[18]_i_1_n_0 ),
        .Q(\u0/slt2_r [18]),
        .R(\<const0> ));
  FDRE \u0/slt2_r_reg[19] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt2_r[19]_i_1_n_0 ),
        .Q(\u0/slt2_r [19]),
        .R(\<const0> ));
  (* srl_bus_name = "\u0/slt2_r_reg " *) 
  (* srl_name = "\u0/slt2_r_reg[1]_srl2___u0_slt5_r_reg_r_0 " *) 
  SRL16E \u0/slt2_r_reg[1]_srl2___u0_slt5_r_reg_r_0 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(\<const1> ),
        .CLK(bit_clk_pad_i),
        .D(\u0/slt3_r [19]),
        .Q(\u0/slt2_r_reg[1]_srl2___u0_slt5_r_reg_r_0_n_0 ));
  FDRE \u0/slt2_r_reg[2]_u0_slt5_r_reg_r_1 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt2_r_reg[1]_srl2___u0_slt5_r_reg_r_0_n_0 ),
        .Q(\u0/slt2_r_reg[2]_u0_slt5_r_reg_r_1_n_0 ),
        .R(\<const0> ));
  FDRE \u0/slt2_r_reg[3] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt2_r_reg_gate_n_0 ),
        .Q(\u0/slt2_r [3]),
        .R(ld));
  FDRE \u0/slt2_r_reg[4] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt2_r[4]_i_1_n_0 ),
        .Q(\u0/slt2_r [4]),
        .R(\<const0> ));
  FDRE \u0/slt2_r_reg[5] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt2_r[5]_i_1_n_0 ),
        .Q(\u0/slt2_r [5]),
        .R(\<const0> ));
  FDRE \u0/slt2_r_reg[6] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt2_r[6]_i_1_n_0 ),
        .Q(\u0/slt2_r [6]),
        .R(\<const0> ));
  FDRE \u0/slt2_r_reg[7] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt2_r[7]_i_1_n_0 ),
        .Q(\u0/slt2_r [7]),
        .R(\<const0> ));
  FDRE \u0/slt2_r_reg[8] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt2_r[8]_i_1_n_0 ),
        .Q(\u0/slt2_r [8]),
        .R(\<const0> ));
  FDRE \u0/slt2_r_reg[9] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt2_r[9]_i_1_n_0 ),
        .Q(\u0/slt2_r [9]),
        .R(\<const0> ));
  LUT2 #(
    .INIT(4'h8)) 
    \u0/slt2_r_reg_gate 
       (.I0(\u0/slt2_r_reg[2]_u0_slt5_r_reg_r_1_n_0 ),
        .I1(\u0/slt5_r_reg_r_1_n_0 ),
        .O(\u0/slt2_r_reg_gate_n_0 ));
  FDRE \u0/slt3_r_reg[0] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[0]_i_1_n_0 ),
        .Q(\u0/slt3_r [0]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[10] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[10]_i_1_n_0 ),
        .Q(\u0/slt3_r [10]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[11] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[11]_i_1_n_0 ),
        .Q(\u0/slt3_r [11]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[12] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[12]_i_1_n_0 ),
        .Q(\u0/slt3_r [12]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[13] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[13]_i_1_n_0 ),
        .Q(\u0/slt3_r [13]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[14] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[14]_i_1_n_0 ),
        .Q(\u0/slt3_r [14]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[15] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[15]_i_1_n_0 ),
        .Q(\u0/slt3_r [15]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[16] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[16]_i_1_n_0 ),
        .Q(\u0/slt3_r [16]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[17] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[17]_i_1_n_0 ),
        .Q(\u0/slt3_r [17]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[18] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[18]_i_1_n_0 ),
        .Q(\u0/slt3_r [18]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[19] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[19]_i_1_n_0 ),
        .Q(\u0/slt3_r [19]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[1] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[1]_i_1_n_0 ),
        .Q(\u0/slt3_r [1]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[2] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[2]_i_1_n_0 ),
        .Q(\u0/slt3_r [2]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[3] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[3]_i_1_n_0 ),
        .Q(\u0/slt3_r [3]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[4] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[4]_i_1_n_0 ),
        .Q(\u0/slt3_r [4]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[5] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[5]_i_1_n_0 ),
        .Q(\u0/slt3_r [5]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[6] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[6]_i_1_n_0 ),
        .Q(\u0/slt3_r [6]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[7] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[7]_i_1_n_0 ),
        .Q(\u0/slt3_r [7]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[8] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[8]_i_1_n_0 ),
        .Q(\u0/slt3_r [8]),
        .R(\<const0> ));
  FDRE \u0/slt3_r_reg[9] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt3_r[9]_i_1_n_0 ),
        .Q(\u0/slt3_r [9]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[0] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[0]_i_1_n_0 ),
        .Q(\u0/slt4_r [0]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[10] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[10]_i_1_n_0 ),
        .Q(\u0/slt4_r [10]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[11] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[11]_i_1_n_0 ),
        .Q(\u0/slt4_r [11]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[12] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[12]_i_1_n_0 ),
        .Q(\u0/slt4_r [12]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[13] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[13]_i_1_n_0 ),
        .Q(\u0/slt4_r [13]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[14] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[14]_i_1_n_0 ),
        .Q(\u0/slt4_r [14]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[15] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[15]_i_1_n_0 ),
        .Q(\u0/slt4_r [15]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[16] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[16]_i_1_n_0 ),
        .Q(\u0/slt4_r [16]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[17] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[17]_i_1_n_0 ),
        .Q(\u0/slt4_r [17]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[18] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[18]_i_1_n_0 ),
        .Q(\u0/slt4_r [18]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[19] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[19]_i_1_n_0 ),
        .Q(\u0/slt4_r [19]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[1] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[1]_i_1_n_0 ),
        .Q(\u0/slt4_r [1]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[2] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[2]_i_1_n_0 ),
        .Q(\u0/slt4_r [2]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[3] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[3]_i_1_n_0 ),
        .Q(\u0/slt4_r [3]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[4] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[4]_i_1_n_0 ),
        .Q(\u0/slt4_r [4]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[5] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[5]_i_1_n_0 ),
        .Q(\u0/slt4_r [5]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[6] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[6]_i_1_n_0 ),
        .Q(\u0/slt4_r [6]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[7] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[7]_i_1_n_0 ),
        .Q(\u0/slt4_r [7]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[8] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[8]_i_1_n_0 ),
        .Q(\u0/slt4_r [8]),
        .R(\<const0> ));
  FDRE \u0/slt4_r_reg[9] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt4_r[9]_i_1_n_0 ),
        .Q(\u0/slt4_r [9]),
        .R(\<const0> ));
  (* srl_bus_name = "\u0/slt5_r_reg " *) 
  (* srl_name = "\u0/slt5_r_reg[17]_srl18___u0_slt5_r_reg_r_16 " *) 
  SRLC32E \u0/slt5_r_reg[17]_srl18___u0_slt5_r_reg_r_16 
       (.A({\<const1> ,\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .CE(\<const1> ),
        .CLK(bit_clk_pad_i),
        .D(\u0/slt6_r [19]),
        .Q(\u0/slt5_r_reg[17]_srl18___u0_slt5_r_reg_r_16_n_0 ));
  FDRE \u0/slt5_r_reg[18]_u0_slt5_r_reg_r_17 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg[17]_srl18___u0_slt5_r_reg_r_16_n_0 ),
        .Q(\u0/slt5_r_reg[18]_u0_slt5_r_reg_r_17_n_0 ),
        .R(\<const0> ));
  FDRE \u0/slt5_r_reg[19] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_gate_n_0 ),
        .Q(\u0/slt5_r ),
        .R(ld));
  LUT2 #(
    .INIT(4'h8)) 
    \u0/slt5_r_reg_gate 
       (.I0(\u0/slt5_r_reg[18]_u0_slt5_r_reg_r_17_n_0 ),
        .I1(\u0/slt5_r_reg_r_17_n_0 ),
        .O(\u0/slt5_r_reg_gate_n_0 ));
  FDRE \u0/slt5_r_reg_r 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\<const1> ),
        .Q(\u0/slt5_r_reg_r_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_0 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_n_0 ),
        .Q(\u0/slt5_r_reg_r_0_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_1 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_0_n_0 ),
        .Q(\u0/slt5_r_reg_r_1_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_10 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_9_n_0 ),
        .Q(\u0/slt5_r_reg_r_10_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_11 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_10_n_0 ),
        .Q(\u0/slt5_r_reg_r_11_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_12 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_11_n_0 ),
        .Q(\u0/slt5_r_reg_r_12_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_13 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_12_n_0 ),
        .Q(\u0/slt5_r_reg_r_13_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_14 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_13_n_0 ),
        .Q(\u0/slt5_r_reg_r_14_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_15 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_14_n_0 ),
        .Q(\u0/slt5_r_reg_r_15_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_16 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_15_n_0 ),
        .Q(\u0/slt5_r_reg_r_16_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_17 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_16_n_0 ),
        .Q(\u0/slt5_r_reg_r_17_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_2 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_1_n_0 ),
        .Q(\u0/slt5_r_reg_r_2_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_3 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_2_n_0 ),
        .Q(\u0/slt5_r_reg_r_3_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_4 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_3_n_0 ),
        .Q(\u0/slt5_r_reg_r_4_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_5 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_4_n_0 ),
        .Q(\u0/slt5_r_reg_r_5_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_6 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_5_n_0 ),
        .Q(\u0/slt5_r_reg_r_6_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_7 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_6_n_0 ),
        .Q(\u0/slt5_r_reg_r_7_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_8 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_7_n_0 ),
        .Q(\u0/slt5_r_reg_r_8_n_0 ),
        .R(ld));
  FDRE \u0/slt5_r_reg_r_9 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/slt5_r_reg_r_8_n_0 ),
        .Q(\u0/slt5_r_reg_r_9_n_0 ),
        .R(ld));
  FDRE \u0/slt6_r_reg[0] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[0]_i_1_n_0 ),
        .Q(\u0/slt6_r [0]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[10] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[10]_i_1_n_0 ),
        .Q(\u0/slt6_r [10]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[11] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[11]_i_1_n_0 ),
        .Q(\u0/slt6_r [11]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[12] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[12]_i_1_n_0 ),
        .Q(\u0/slt6_r [12]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[13] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[13]_i_1_n_0 ),
        .Q(\u0/slt6_r [13]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[14] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[14]_i_1_n_0 ),
        .Q(\u0/slt6_r [14]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[15] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[15]_i_1_n_0 ),
        .Q(\u0/slt6_r [15]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[16] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[16]_i_1_n_0 ),
        .Q(\u0/slt6_r [16]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[17] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[17]_i_1_n_0 ),
        .Q(\u0/slt6_r [17]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[18] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[18]_i_1_n_0 ),
        .Q(\u0/slt6_r [18]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[19] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[19]_i_1_n_0 ),
        .Q(\u0/slt6_r [19]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[1] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[1]_i_1_n_0 ),
        .Q(\u0/slt6_r [1]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[2] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[2]_i_1_n_0 ),
        .Q(\u0/slt6_r [2]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[3] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[3]_i_1_n_0 ),
        .Q(\u0/slt6_r [3]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[4] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[4]_i_1_n_0 ),
        .Q(\u0/slt6_r [4]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[5] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[5]_i_1_n_0 ),
        .Q(\u0/slt6_r [5]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[6] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[6]_i_1_n_0 ),
        .Q(\u0/slt6_r [6]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[7] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[7]_i_1_n_0 ),
        .Q(\u0/slt6_r [7]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[8] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[8]_i_1_n_0 ),
        .Q(\u0/slt6_r [8]),
        .R(\<const0> ));
  FDRE \u0/slt6_r_reg[9] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt6_r[9]_i_1_n_0 ),
        .Q(\u0/slt6_r [9]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[0] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[0]_i_1_n_0 ),
        .Q(\u0/slt7_r [0]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[10] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[10]_i_1_n_0 ),
        .Q(\u0/slt7_r [10]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[11] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[11]_i_1_n_0 ),
        .Q(\u0/slt7_r [11]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[12] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[12]_i_1_n_0 ),
        .Q(\u0/slt7_r [12]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[13] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[13]_i_1_n_0 ),
        .Q(\u0/slt7_r [13]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[14] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[14]_i_1_n_0 ),
        .Q(\u0/slt7_r [14]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[15] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[15]_i_1_n_0 ),
        .Q(\u0/slt7_r [15]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[16] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[16]_i_1_n_0 ),
        .Q(\u0/slt7_r [16]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[17] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[17]_i_1_n_0 ),
        .Q(\u0/slt7_r [17]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[18] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[18]_i_1_n_0 ),
        .Q(\u0/slt7_r [18]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[19] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[19]_i_1_n_0 ),
        .Q(\u0/slt7_r [19]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[1] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[1]_i_1_n_0 ),
        .Q(\u0/slt7_r [1]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[2] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[2]_i_1_n_0 ),
        .Q(\u0/slt7_r [2]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[3] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[3]_i_1_n_0 ),
        .Q(\u0/slt7_r [3]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[4] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[4]_i_1_n_0 ),
        .Q(\u0/slt7_r [4]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[5] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[5]_i_1_n_0 ),
        .Q(\u0/slt7_r [5]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[6] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[6]_i_1_n_0 ),
        .Q(\u0/slt7_r [6]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[7] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[7]_i_1_n_0 ),
        .Q(\u0/slt7_r [7]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[8] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[8]_i_1_n_0 ),
        .Q(\u0/slt7_r [8]),
        .R(\<const0> ));
  FDRE \u0/slt7_r_reg[9] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt7_r[9]_i_1_n_0 ),
        .Q(\u0/slt7_r [9]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[0] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[0]_i_1_n_0 ),
        .Q(\u0/slt8_r [0]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[10] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[10]_i_1_n_0 ),
        .Q(\u0/slt8_r [10]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[11] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[11]_i_1_n_0 ),
        .Q(\u0/slt8_r [11]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[12] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[12]_i_1_n_0 ),
        .Q(\u0/slt8_r [12]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[13] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[13]_i_1_n_0 ),
        .Q(\u0/slt8_r [13]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[14] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[14]_i_1_n_0 ),
        .Q(\u0/slt8_r [14]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[15] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[15]_i_1_n_0 ),
        .Q(\u0/slt8_r [15]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[16] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[16]_i_1_n_0 ),
        .Q(\u0/slt8_r [16]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[17] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[17]_i_1_n_0 ),
        .Q(\u0/slt8_r [17]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[18] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[18]_i_1_n_0 ),
        .Q(\u0/slt8_r [18]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[19] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[19]_i_1_n_0 ),
        .Q(\u0/slt8_r [19]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[1] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[1]_i_1_n_0 ),
        .Q(\u0/slt8_r [1]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[2] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[2]_i_1_n_0 ),
        .Q(\u0/slt8_r [2]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[3] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[3]_i_1_n_0 ),
        .Q(\u0/slt8_r [3]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[4] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[4]_i_1_n_0 ),
        .Q(\u0/slt8_r [4]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[5] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[5]_i_1_n_0 ),
        .Q(\u0/slt8_r [5]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[6] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[6]_i_1_n_0 ),
        .Q(\u0/slt8_r [6]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[7] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[7]_i_1_n_0 ),
        .Q(\u0/slt8_r [7]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[8] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[8]_i_1_n_0 ),
        .Q(\u0/slt8_r [8]),
        .R(\<const0> ));
  FDRE \u0/slt8_r_reg[9] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt8_r[9]_i_1_n_0 ),
        .Q(\u0/slt8_r [9]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[0] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\slt9_r[0]_i_1_n_0 ),
        .Q(\u0/slt9_r [0]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[10] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [10]),
        .Q(\u0/slt9_r [10]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[11] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [11]),
        .Q(\u0/slt9_r [11]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[12] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [12]),
        .Q(\u0/slt9_r [12]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[13] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [13]),
        .Q(\u0/slt9_r [13]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[14] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [14]),
        .Q(\u0/slt9_r [14]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[15] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [15]),
        .Q(\u0/slt9_r [15]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[16] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [16]),
        .Q(\u0/slt9_r [16]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[17] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [17]),
        .Q(\u0/slt9_r [17]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[18] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [18]),
        .Q(\u0/slt9_r [18]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[19] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [19]),
        .Q(\u0/slt9_r [19]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[1] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [1]),
        .Q(\u0/slt9_r [1]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[2] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [2]),
        .Q(\u0/slt9_r [2]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[3] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [3]),
        .Q(\u0/slt9_r [3]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[4] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [4]),
        .Q(\u0/slt9_r [4]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[5] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [5]),
        .Q(\u0/slt9_r [5]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[6] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [6]),
        .Q(\u0/slt9_r [6]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[7] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [7]),
        .Q(\u0/slt9_r [7]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[8] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [8]),
        .Q(\u0/slt9_r [8]),
        .R(\<const0> ));
  FDRE \u0/slt9_r_reg[9] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u0/p_0_in [9]),
        .Q(\u0/slt9_r [9]),
        .R(\<const0> ));
  FDRE #(
    .IS_C_INVERTED(1'b1)) 
    \u1/sdata_in_r_reg 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(sdata_pad_i),
        .Q(p_0_in[0]),
        .R(\<const0> ));
  FDRE \u1/slt0_reg[11] 
       (.C(bit_clk_pad_i),
        .CE(out_le[0]),
        .D(p_0_in[12]),
        .Q(in_slt0[11]),
        .R(\<const0> ));
  FDRE \u1/slt0_reg[12] 
       (.C(bit_clk_pad_i),
        .CE(out_le[0]),
        .D(p_0_in[13]),
        .Q(in_slt0[12]),
        .R(\<const0> ));
  FDRE \u1/slt0_reg[15] 
       (.C(bit_clk_pad_i),
        .CE(out_le[0]),
        .D(p_0_in[16]),
        .Q(in_slt0[15]),
        .R(\<const0> ));
  FDRE \u1/slt0_reg[9] 
       (.C(bit_clk_pad_i),
        .CE(out_le[0]),
        .D(p_0_in[10]),
        .Q(in_slt0[9]),
        .R(\<const0> ));
  FDRE \u1/slt1_reg[10] 
       (.C(bit_clk_pad_i),
        .CE(out_le[1]),
        .D(p_0_in[11]),
        .Q(in_slt1[10]),
        .R(\<const0> ));
  FDRE \u1/slt1_reg[11] 
       (.C(bit_clk_pad_i),
        .CE(out_le[1]),
        .D(p_0_in[12]),
        .Q(in_slt1[11]),
        .R(\<const0> ));
  FDRE \u1/slt1_reg[5] 
       (.C(bit_clk_pad_i),
        .CE(out_le[1]),
        .D(p_0_in[6]),
        .Q(in_slt1[5]),
        .R(\<const0> ));
  FDRE \u1/slt1_reg[6] 
       (.C(bit_clk_pad_i),
        .CE(out_le[1]),
        .D(p_0_in[7]),
        .Q(in_slt1[6]),
        .R(\<const0> ));
  FDRE \u1/slt1_reg[7] 
       (.C(bit_clk_pad_i),
        .CE(out_le[1]),
        .D(p_0_in[8]),
        .Q(in_slt1[7]),
        .R(\<const0> ));
  FDRE \u1/slt1_reg[8] 
       (.C(bit_clk_pad_i),
        .CE(out_le[1]),
        .D(p_0_in[9]),
        .Q(in_slt1[8]),
        .R(\<const0> ));
  FDRE \u1/slt2_reg[10] 
       (.C(bit_clk_pad_i),
        .CE(out_le[2]),
        .D(p_0_in[11]),
        .Q(in_slt2[10]),
        .R(\<const0> ));
  FDRE \u1/slt2_reg[11] 
       (.C(bit_clk_pad_i),
        .CE(out_le[2]),
        .D(p_0_in[12]),
        .Q(in_slt2[11]),
        .R(\<const0> ));
  FDRE \u1/slt2_reg[12] 
       (.C(bit_clk_pad_i),
        .CE(out_le[2]),
        .D(p_0_in[13]),
        .Q(in_slt2[12]),
        .R(\<const0> ));
  FDRE \u1/slt2_reg[13] 
       (.C(bit_clk_pad_i),
        .CE(out_le[2]),
        .D(p_0_in[14]),
        .Q(in_slt2[13]),
        .R(\<const0> ));
  FDRE \u1/slt2_reg[14] 
       (.C(bit_clk_pad_i),
        .CE(out_le[2]),
        .D(p_0_in[15]),
        .Q(in_slt2[14]),
        .R(\<const0> ));
  FDRE \u1/slt2_reg[15] 
       (.C(bit_clk_pad_i),
        .CE(out_le[2]),
        .D(p_0_in[16]),
        .Q(in_slt2[15]),
        .R(\<const0> ));
  FDRE \u1/slt2_reg[16] 
       (.C(bit_clk_pad_i),
        .CE(out_le[2]),
        .D(p_0_in[17]),
        .Q(in_slt2[16]),
        .R(\<const0> ));
  FDRE \u1/slt2_reg[17] 
       (.C(bit_clk_pad_i),
        .CE(out_le[2]),
        .D(p_0_in[18]),
        .Q(in_slt2[17]),
        .R(\<const0> ));
  FDRE \u1/slt2_reg[18] 
       (.C(bit_clk_pad_i),
        .CE(out_le[2]),
        .D(p_0_in[19]),
        .Q(in_slt2[18]),
        .R(\<const0> ));
  FDRE \u1/slt2_reg[19] 
       (.C(bit_clk_pad_i),
        .CE(out_le[2]),
        .D(\u1/sr_reg_n_0_[19] ),
        .Q(in_slt2[19]),
        .R(\<const0> ));
  FDRE \u1/slt2_reg[4] 
       (.C(bit_clk_pad_i),
        .CE(out_le[2]),
        .D(p_0_in[5]),
        .Q(in_slt2[4]),
        .R(\<const0> ));
  FDRE \u1/slt2_reg[5] 
       (.C(bit_clk_pad_i),
        .CE(out_le[2]),
        .D(p_0_in[6]),
        .Q(in_slt2[5]),
        .R(\<const0> ));
  FDRE \u1/slt2_reg[6] 
       (.C(bit_clk_pad_i),
        .CE(out_le[2]),
        .D(p_0_in[7]),
        .Q(in_slt2[6]),
        .R(\<const0> ));
  FDRE \u1/slt2_reg[7] 
       (.C(bit_clk_pad_i),
        .CE(out_le[2]),
        .D(p_0_in[8]),
        .Q(in_slt2[7]),
        .R(\<const0> ));
  FDRE \u1/slt2_reg[8] 
       (.C(bit_clk_pad_i),
        .CE(out_le[2]),
        .D(p_0_in[9]),
        .Q(in_slt2[8]),
        .R(\<const0> ));
  FDRE \u1/slt2_reg[9] 
       (.C(bit_clk_pad_i),
        .CE(out_le[2]),
        .D(p_0_in[10]),
        .Q(in_slt2[9]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[0] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[1]),
        .Q(in_slt3[0]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[10] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[11]),
        .Q(in_slt3[10]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[11] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[12]),
        .Q(in_slt3[11]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[12] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[13]),
        .Q(in_slt3[12]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[13] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[14]),
        .Q(in_slt3[13]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[14] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[15]),
        .Q(in_slt3[14]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[15] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[16]),
        .Q(in_slt3[15]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[16] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[17]),
        .Q(in_slt3[16]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[17] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[18]),
        .Q(in_slt3[17]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[18] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[19]),
        .Q(in_slt3[18]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[19] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(\u1/sr_reg_n_0_[19] ),
        .Q(in_slt3[19]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[1] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[2]),
        .Q(in_slt3[1]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[2] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[3]),
        .Q(in_slt3[2]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[3] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[4]),
        .Q(in_slt3[3]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[4] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[5]),
        .Q(in_slt3[4]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[5] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[6]),
        .Q(in_slt3[5]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[6] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[7]),
        .Q(in_slt3[6]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[7] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[8]),
        .Q(in_slt3[7]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[8] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[9]),
        .Q(in_slt3[8]),
        .R(\<const0> ));
  FDRE \u1/slt3_reg[9] 
       (.C(bit_clk_pad_i),
        .CE(out_le[3]),
        .D(p_0_in[10]),
        .Q(in_slt3[9]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[0] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[1]),
        .Q(in_slt4[0]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[10] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[11]),
        .Q(in_slt4[10]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[11] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[12]),
        .Q(in_slt4[11]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[12] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[13]),
        .Q(in_slt4[12]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[13] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[14]),
        .Q(in_slt4[13]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[14] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[15]),
        .Q(in_slt4[14]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[15] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[16]),
        .Q(in_slt4[15]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[16] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[17]),
        .Q(in_slt4[16]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[17] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[18]),
        .Q(in_slt4[17]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[18] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[19]),
        .Q(in_slt4[18]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[19] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(\u1/sr_reg_n_0_[19] ),
        .Q(in_slt4[19]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[1] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[2]),
        .Q(in_slt4[1]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[2] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[3]),
        .Q(in_slt4[2]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[3] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[4]),
        .Q(in_slt4[3]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[4] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[5]),
        .Q(in_slt4[4]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[5] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[6]),
        .Q(in_slt4[5]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[6] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[7]),
        .Q(in_slt4[6]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[7] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[8]),
        .Q(in_slt4[7]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[8] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[9]),
        .Q(in_slt4[8]),
        .R(\<const0> ));
  FDRE \u1/slt4_reg[9] 
       (.C(bit_clk_pad_i),
        .CE(out_le[4]),
        .D(p_0_in[10]),
        .Q(in_slt4[9]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[0] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[1]),
        .Q(in_slt6[0]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[10] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[11]),
        .Q(in_slt6[10]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[11] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[12]),
        .Q(in_slt6[11]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[12] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[13]),
        .Q(in_slt6[12]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[13] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[14]),
        .Q(in_slt6[13]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[14] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[15]),
        .Q(in_slt6[14]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[15] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[16]),
        .Q(in_slt6[15]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[16] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[17]),
        .Q(in_slt6[16]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[17] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[18]),
        .Q(in_slt6[17]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[18] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[19]),
        .Q(in_slt6[18]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[19] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(\u1/sr_reg_n_0_[19] ),
        .Q(in_slt6[19]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[1] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[2]),
        .Q(in_slt6[1]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[2] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[3]),
        .Q(in_slt6[2]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[3] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[4]),
        .Q(in_slt6[3]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[4] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[5]),
        .Q(in_slt6[4]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[5] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[6]),
        .Q(in_slt6[5]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[6] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[7]),
        .Q(in_slt6[6]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[7] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[8]),
        .Q(in_slt6[7]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[8] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[9]),
        .Q(in_slt6[8]),
        .R(\<const0> ));
  FDRE \u1/slt6_reg[9] 
       (.C(bit_clk_pad_i),
        .CE(out_le[5]),
        .D(p_0_in[10]),
        .Q(in_slt6[9]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[0] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[0]),
        .Q(p_0_in[1]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[10] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[10]),
        .Q(p_0_in[11]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[11] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[11]),
        .Q(p_0_in[12]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[12] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[12]),
        .Q(p_0_in[13]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[13] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[13]),
        .Q(p_0_in[14]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[14] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[14]),
        .Q(p_0_in[15]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[15] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[15]),
        .Q(p_0_in[16]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[16] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[16]),
        .Q(p_0_in[17]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[17] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[17]),
        .Q(p_0_in[18]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[18] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[18]),
        .Q(p_0_in[19]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[19] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[19]),
        .Q(\u1/sr_reg_n_0_[19] ),
        .R(\<const0> ));
  FDRE \u1/sr_reg[1] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[1]),
        .Q(p_0_in[2]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[2] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[2]),
        .Q(p_0_in[3]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[3] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[3]),
        .Q(p_0_in[4]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[4] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[4]),
        .Q(p_0_in[5]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[5] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[5]),
        .Q(p_0_in[6]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[6] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[6]),
        .Q(p_0_in[7]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[7] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[7]),
        .Q(p_0_in[8]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[8] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[8]),
        .Q(p_0_in[9]),
        .R(\<const0> ));
  FDRE \u1/sr_reg[9] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in[9]),
        .Q(p_0_in[10]),
        .R(\<const0> ));
  FDRE \u10/din_tmp1_reg[0] 
       (.C(clk_i),
        .CE(\u10/din_tmp10 ),
        .D(in_slt4[4]),
        .Q(\u10/din_tmp1 [0]),
        .R(\<const0> ));
  FDRE \u10/din_tmp1_reg[10] 
       (.C(clk_i),
        .CE(\u10/din_tmp10 ),
        .D(in_slt4[14]),
        .Q(\u10/din_tmp1 [10]),
        .R(\<const0> ));
  FDRE \u10/din_tmp1_reg[11] 
       (.C(clk_i),
        .CE(\u10/din_tmp10 ),
        .D(in_slt4[15]),
        .Q(\u10/din_tmp1 [11]),
        .R(\<const0> ));
  FDRE \u10/din_tmp1_reg[12] 
       (.C(clk_i),
        .CE(\u10/din_tmp10 ),
        .D(in_slt4[16]),
        .Q(\u10/din_tmp1 [12]),
        .R(\<const0> ));
  FDRE \u10/din_tmp1_reg[13] 
       (.C(clk_i),
        .CE(\u10/din_tmp10 ),
        .D(in_slt4[17]),
        .Q(\u10/din_tmp1 [13]),
        .R(\<const0> ));
  FDRE \u10/din_tmp1_reg[14] 
       (.C(clk_i),
        .CE(\u10/din_tmp10 ),
        .D(in_slt4[18]),
        .Q(\u10/din_tmp1 [14]),
        .R(\<const0> ));
  FDRE \u10/din_tmp1_reg[15] 
       (.C(clk_i),
        .CE(\u10/din_tmp10 ),
        .D(in_slt4[19]),
        .Q(\u10/din_tmp1 [15]),
        .R(\<const0> ));
  FDRE \u10/din_tmp1_reg[1] 
       (.C(clk_i),
        .CE(\u10/din_tmp10 ),
        .D(in_slt4[5]),
        .Q(\u10/din_tmp1 [1]),
        .R(\<const0> ));
  FDRE \u10/din_tmp1_reg[2] 
       (.C(clk_i),
        .CE(\u10/din_tmp10 ),
        .D(in_slt4[6]),
        .Q(\u10/din_tmp1 [2]),
        .R(\<const0> ));
  FDRE \u10/din_tmp1_reg[3] 
       (.C(clk_i),
        .CE(\u10/din_tmp10 ),
        .D(in_slt4[7]),
        .Q(\u10/din_tmp1 [3]),
        .R(\<const0> ));
  FDRE \u10/din_tmp1_reg[4] 
       (.C(clk_i),
        .CE(\u10/din_tmp10 ),
        .D(in_slt4[8]),
        .Q(\u10/din_tmp1 [4]),
        .R(\<const0> ));
  FDRE \u10/din_tmp1_reg[5] 
       (.C(clk_i),
        .CE(\u10/din_tmp10 ),
        .D(in_slt4[9]),
        .Q(\u10/din_tmp1 [5]),
        .R(\<const0> ));
  FDRE \u10/din_tmp1_reg[6] 
       (.C(clk_i),
        .CE(\u10/din_tmp10 ),
        .D(in_slt4[10]),
        .Q(\u10/din_tmp1 [6]),
        .R(\<const0> ));
  FDRE \u10/din_tmp1_reg[7] 
       (.C(clk_i),
        .CE(\u10/din_tmp10 ),
        .D(in_slt4[11]),
        .Q(\u10/din_tmp1 [7]),
        .R(\<const0> ));
  FDRE \u10/din_tmp1_reg[8] 
       (.C(clk_i),
        .CE(\u10/din_tmp10 ),
        .D(in_slt4[12]),
        .Q(\u10/din_tmp1 [8]),
        .R(\<const0> ));
  FDRE \u10/din_tmp1_reg[9] 
       (.C(clk_i),
        .CE(\u10/din_tmp10 ),
        .D(in_slt4[13]),
        .Q(\u10/din_tmp1 [9]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[0]),
        .Q(i4_dout[0]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[10] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[10]),
        .Q(i4_dout[10]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[11] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[11]),
        .Q(i4_dout[11]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[12] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[12]),
        .Q(i4_dout[12]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[13] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[13]),
        .Q(i4_dout[13]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[14] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[14]),
        .Q(i4_dout[14]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[15] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[15]),
        .Q(i4_dout[15]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[16] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[16]),
        .Q(i4_dout[16]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[17] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[17]),
        .Q(i4_dout[17]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[18] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[18]),
        .Q(i4_dout[18]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[19] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[19]),
        .Q(i4_dout[19]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[1]),
        .Q(i4_dout[1]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[20] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[20]),
        .Q(i4_dout[20]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[21] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[21]),
        .Q(i4_dout[21]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[22] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[22]),
        .Q(i4_dout[22]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[23] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[23]),
        .Q(i4_dout[23]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[24] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[24]),
        .Q(i4_dout[24]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[25] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[25]),
        .Q(i4_dout[25]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[26] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[26]),
        .Q(i4_dout[26]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[27] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[27]),
        .Q(i4_dout[27]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[28] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[28]),
        .Q(i4_dout[28]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[29] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[29]),
        .Q(i4_dout[29]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[2]),
        .Q(i4_dout[2]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[30] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[30]),
        .Q(i4_dout[30]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[31] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[31]),
        .Q(i4_dout[31]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[3] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[3]),
        .Q(i4_dout[3]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[4] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[4]),
        .Q(i4_dout[4]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[5] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[5]),
        .Q(i4_dout[5]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[6] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[6]),
        .Q(i4_dout[6]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[7] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[7]),
        .Q(i4_dout[7]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[8] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[8]),
        .Q(i4_dout[8]),
        .R(\<const0> ));
  FDRE \u10/dout_reg[9] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__0[9]),
        .Q(i4_dout[9]),
        .R(\<const0> ));
  FDRE \u10/empty_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u10/empty0 ),
        .Q(i4_empty),
        .R(\<const0> ));
  FDRE \u10/full_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u10/full0 ),
        .Q(i4_full),
        .R(\<const0> ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u10/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "5" *) 
  RAM32M \u10/mem_reg_0_3_0_5 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u10/rp_reg_n_0_[1] ,\u10/rp_reg_n_0_[0] }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u10/rp_reg_n_0_[1] ,\u10/rp_reg_n_0_[0] }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u10/rp_reg_n_0_[1] ,\u10/rp_reg_n_0_[0] }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u10/p_1_in }),
        .DIA(\u10/din_tmp [1:0]),
        .DIB(\u10/din_tmp [3:2]),
        .DIC(\u10/din_tmp [5:4]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout0__0[1:0]),
        .DOB(dout0__0[3:2]),
        .DOC(dout0__0[5:4]),
        .WCLK(clk_i),
        .WE(p_0_in__1));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u10/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "17" *) 
  RAM32M \u10/mem_reg_0_3_12_17 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u10/rp_reg_n_0_[1] ,\u10/rp_reg_n_0_[0] }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u10/rp_reg_n_0_[1] ,\u10/rp_reg_n_0_[0] }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u10/rp_reg_n_0_[1] ,\u10/rp_reg_n_0_[0] }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u10/p_1_in }),
        .DIA(\u10/din_tmp [13:12]),
        .DIB(\u10/din_tmp [15:14]),
        .DIC(\u10/din_tmp [17:16]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout0__0[13:12]),
        .DOB(dout0__0[15:14]),
        .DOC(dout0__0[17:16]),
        .WCLK(clk_i),
        .WE(p_0_in__1));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u10/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "23" *) 
  RAM32M \u10/mem_reg_0_3_18_23 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u10/rp_reg_n_0_[1] ,\u10/rp_reg_n_0_[0] }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u10/rp_reg_n_0_[1] ,\u10/rp_reg_n_0_[0] }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u10/rp_reg_n_0_[1] ,\u10/rp_reg_n_0_[0] }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u10/p_1_in }),
        .DIA(\u10/din_tmp [19:18]),
        .DIB(\u10/din_tmp [21:20]),
        .DIC(\u10/din_tmp [23:22]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout0__0[19:18]),
        .DOB(dout0__0[21:20]),
        .DOC(dout0__0[23:22]),
        .WCLK(clk_i),
        .WE(p_0_in__1));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u10/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "29" *) 
  RAM32M \u10/mem_reg_0_3_24_29 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u10/rp_reg_n_0_[1] ,\u10/rp_reg_n_0_[0] }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u10/rp_reg_n_0_[1] ,\u10/rp_reg_n_0_[0] }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u10/rp_reg_n_0_[1] ,\u10/rp_reg_n_0_[0] }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u10/p_1_in }),
        .DIA(\u10/din_tmp [25:24]),
        .DIB(\u10/din_tmp [27:26]),
        .DIC(\u10/din_tmp [29:28]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout0__0[25:24]),
        .DOB(dout0__0[27:26]),
        .DOC(dout0__0[29:28]),
        .WCLK(clk_i),
        .WE(p_0_in__1));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u10/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u10/mem_reg_0_3_30_31 
       (.A0(\u10/p_1_in [0]),
        .A1(\u10/p_1_in [1]),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(\u10/din_tmp [30]),
        .DPO(dout0__0[30]),
        .DPRA0(\u10/rp_reg_n_0_[0] ),
        .DPRA1(\u10/rp_reg_n_0_[1] ),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(p_0_in__1));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u10/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u10/mem_reg_0_3_30_31__0 
       (.A0(\u10/p_1_in [0]),
        .A1(\u10/p_1_in [1]),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(\u10/din_tmp [31]),
        .DPO(dout0__0[31]),
        .DPRA0(\u10/rp_reg_n_0_[0] ),
        .DPRA1(\u10/rp_reg_n_0_[1] ),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(p_0_in__1));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u10/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "11" *) 
  RAM32M \u10/mem_reg_0_3_6_11 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u10/rp_reg_n_0_[1] ,\u10/rp_reg_n_0_[0] }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u10/rp_reg_n_0_[1] ,\u10/rp_reg_n_0_[0] }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u10/rp_reg_n_0_[1] ,\u10/rp_reg_n_0_[0] }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u10/p_1_in }),
        .DIA(\u10/din_tmp [7:6]),
        .DIB(\u10/din_tmp [9:8]),
        .DIC(\u10/din_tmp [11:10]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout0__0[7:6]),
        .DOB(dout0__0[9:8]),
        .DOC(dout0__0[11:10]),
        .WCLK(clk_i),
        .WE(p_0_in__1));
  FDRE \u10/rp_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\rp[0]_i_1__0_n_0 ),
        .Q(\u10/rp_reg_n_0_[0] ),
        .R(\<const0> ));
  FDRE \u10/rp_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\rp[1]_i_1__0_n_0 ),
        .Q(\u10/rp_reg_n_0_[1] ),
        .R(\<const0> ));
  FDRE \u10/rp_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\rp[2]_i_1__0_n_0 ),
        .Q(\u10/rp_reg_n_0_[2] ),
        .R(\<const0> ));
  FDRE \u10/status_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\status[0]_i_1__6_n_0 ),
        .Q(i4_status[0]),
        .R(\<const0> ));
  FDRE \u10/status_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u10/status0 ),
        .Q(i4_status[1]),
        .R(\<const0> ));
  FDRE \u10/wp_reg[0] 
       (.C(clk_i),
        .CE(i4_we),
        .D(\wp[0]_i_1__6_n_0 ),
        .Q(\u10/wp_reg_n_0_[0] ),
        .R(\wp[3]_i_1__0_n_0 ));
  FDRE \u10/wp_reg[1] 
       (.C(clk_i),
        .CE(i4_we),
        .D(wp_p1__0[1]),
        .Q(\u10/p_1_in [0]),
        .R(\wp[3]_i_1__0_n_0 ));
  FDRE \u10/wp_reg[2] 
       (.C(clk_i),
        .CE(i4_we),
        .D(wp_p1__0[2]),
        .Q(\u10/p_1_in [1]),
        .R(\wp[3]_i_1__0_n_0 ));
  FDRE \u10/wp_reg[3] 
       (.C(clk_i),
        .CE(i4_we),
        .D(wp_p1__0[3]),
        .Q(\u10/wp_reg_n_0_[3] ),
        .R(\wp[3]_i_1__0_n_0 ));
  FDRE \u11/din_tmp1_reg[0] 
       (.C(clk_i),
        .CE(\u11/din_tmp10 ),
        .D(in_slt6[4]),
        .Q(\u11/din_tmp1 [0]),
        .R(\<const0> ));
  FDRE \u11/din_tmp1_reg[10] 
       (.C(clk_i),
        .CE(\u11/din_tmp10 ),
        .D(in_slt6[14]),
        .Q(\u11/din_tmp1 [10]),
        .R(\<const0> ));
  FDRE \u11/din_tmp1_reg[11] 
       (.C(clk_i),
        .CE(\u11/din_tmp10 ),
        .D(in_slt6[15]),
        .Q(\u11/din_tmp1 [11]),
        .R(\<const0> ));
  FDRE \u11/din_tmp1_reg[12] 
       (.C(clk_i),
        .CE(\u11/din_tmp10 ),
        .D(in_slt6[16]),
        .Q(\u11/din_tmp1 [12]),
        .R(\<const0> ));
  FDRE \u11/din_tmp1_reg[13] 
       (.C(clk_i),
        .CE(\u11/din_tmp10 ),
        .D(in_slt6[17]),
        .Q(\u11/din_tmp1 [13]),
        .R(\<const0> ));
  FDRE \u11/din_tmp1_reg[14] 
       (.C(clk_i),
        .CE(\u11/din_tmp10 ),
        .D(in_slt6[18]),
        .Q(\u11/din_tmp1 [14]),
        .R(\<const0> ));
  FDRE \u11/din_tmp1_reg[15] 
       (.C(clk_i),
        .CE(\u11/din_tmp10 ),
        .D(in_slt6[19]),
        .Q(\u11/din_tmp1 [15]),
        .R(\<const0> ));
  FDRE \u11/din_tmp1_reg[1] 
       (.C(clk_i),
        .CE(\u11/din_tmp10 ),
        .D(in_slt6[5]),
        .Q(\u11/din_tmp1 [1]),
        .R(\<const0> ));
  FDRE \u11/din_tmp1_reg[2] 
       (.C(clk_i),
        .CE(\u11/din_tmp10 ),
        .D(in_slt6[6]),
        .Q(\u11/din_tmp1 [2]),
        .R(\<const0> ));
  FDRE \u11/din_tmp1_reg[3] 
       (.C(clk_i),
        .CE(\u11/din_tmp10 ),
        .D(in_slt6[7]),
        .Q(\u11/din_tmp1 [3]),
        .R(\<const0> ));
  FDRE \u11/din_tmp1_reg[4] 
       (.C(clk_i),
        .CE(\u11/din_tmp10 ),
        .D(in_slt6[8]),
        .Q(\u11/din_tmp1 [4]),
        .R(\<const0> ));
  FDRE \u11/din_tmp1_reg[5] 
       (.C(clk_i),
        .CE(\u11/din_tmp10 ),
        .D(in_slt6[9]),
        .Q(\u11/din_tmp1 [5]),
        .R(\<const0> ));
  FDRE \u11/din_tmp1_reg[6] 
       (.C(clk_i),
        .CE(\u11/din_tmp10 ),
        .D(in_slt6[10]),
        .Q(\u11/din_tmp1 [6]),
        .R(\<const0> ));
  FDRE \u11/din_tmp1_reg[7] 
       (.C(clk_i),
        .CE(\u11/din_tmp10 ),
        .D(in_slt6[11]),
        .Q(\u11/din_tmp1 [7]),
        .R(\<const0> ));
  FDRE \u11/din_tmp1_reg[8] 
       (.C(clk_i),
        .CE(\u11/din_tmp10 ),
        .D(in_slt6[12]),
        .Q(\u11/din_tmp1 [8]),
        .R(\<const0> ));
  FDRE \u11/din_tmp1_reg[9] 
       (.C(clk_i),
        .CE(\u11/din_tmp10 ),
        .D(in_slt6[13]),
        .Q(\u11/din_tmp1 [9]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[0]),
        .Q(i6_dout[0]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[10] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[10]),
        .Q(i6_dout[10]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[11] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[11]),
        .Q(i6_dout[11]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[12] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[12]),
        .Q(i6_dout[12]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[13] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[13]),
        .Q(i6_dout[13]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[14] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[14]),
        .Q(i6_dout[14]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[15] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[15]),
        .Q(i6_dout[15]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[16] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[16]),
        .Q(i6_dout[16]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[17] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[17]),
        .Q(i6_dout[17]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[18] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[18]),
        .Q(i6_dout[18]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[19] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[19]),
        .Q(i6_dout[19]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[1]),
        .Q(i6_dout[1]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[20] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[20]),
        .Q(i6_dout[20]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[21] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[21]),
        .Q(i6_dout[21]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[22] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[22]),
        .Q(i6_dout[22]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[23] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[23]),
        .Q(i6_dout[23]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[24] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[24]),
        .Q(i6_dout[24]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[25] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[25]),
        .Q(i6_dout[25]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[26] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[26]),
        .Q(i6_dout[26]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[27] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[27]),
        .Q(i6_dout[27]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[28] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[28]),
        .Q(i6_dout[28]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[29] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[29]),
        .Q(i6_dout[29]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[2]),
        .Q(i6_dout[2]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[30] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[30]),
        .Q(i6_dout[30]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[31] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[31]),
        .Q(i6_dout[31]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[3] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[3]),
        .Q(i6_dout[3]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[4] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[4]),
        .Q(i6_dout[4]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[5] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[5]),
        .Q(i6_dout[5]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[6] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[6]),
        .Q(i6_dout[6]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[7] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[7]),
        .Q(i6_dout[7]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[8] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[8]),
        .Q(i6_dout[8]),
        .R(\<const0> ));
  FDRE \u11/dout_reg[9] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0__1[9]),
        .Q(i6_dout[9]),
        .R(\<const0> ));
  FDRE \u11/empty_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u11/empty0 ),
        .Q(i6_empty),
        .R(\<const0> ));
  FDRE \u11/full_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u11/full0 ),
        .Q(i6_full),
        .R(\<const0> ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u11/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "5" *) 
  RAM32M \u11/mem_reg_0_3_0_5 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u11/rp_reg_n_0_[1] ,\u11/rp_reg_n_0_[0] }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u11/rp_reg_n_0_[1] ,\u11/rp_reg_n_0_[0] }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u11/rp_reg_n_0_[1] ,\u11/rp_reg_n_0_[0] }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u11/p_1_in }),
        .DIA(\u11/din_tmp [1:0]),
        .DIB(\u11/din_tmp [3:2]),
        .DIC(\u11/din_tmp [5:4]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout0__1[1:0]),
        .DOB(dout0__1[3:2]),
        .DOC(dout0__1[5:4]),
        .WCLK(clk_i),
        .WE(p_0_in__2));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u11/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "17" *) 
  RAM32M \u11/mem_reg_0_3_12_17 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u11/rp_reg_n_0_[1] ,\u11/rp_reg_n_0_[0] }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u11/rp_reg_n_0_[1] ,\u11/rp_reg_n_0_[0] }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u11/rp_reg_n_0_[1] ,\u11/rp_reg_n_0_[0] }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u11/p_1_in }),
        .DIA(\u11/din_tmp [13:12]),
        .DIB(\u11/din_tmp [15:14]),
        .DIC(\u11/din_tmp [17:16]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout0__1[13:12]),
        .DOB(dout0__1[15:14]),
        .DOC(dout0__1[17:16]),
        .WCLK(clk_i),
        .WE(p_0_in__2));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u11/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "23" *) 
  RAM32M \u11/mem_reg_0_3_18_23 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u11/rp_reg_n_0_[1] ,\u11/rp_reg_n_0_[0] }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u11/rp_reg_n_0_[1] ,\u11/rp_reg_n_0_[0] }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u11/rp_reg_n_0_[1] ,\u11/rp_reg_n_0_[0] }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u11/p_1_in }),
        .DIA(\u11/din_tmp [19:18]),
        .DIB(\u11/din_tmp [21:20]),
        .DIC(\u11/din_tmp [23:22]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout0__1[19:18]),
        .DOB(dout0__1[21:20]),
        .DOC(dout0__1[23:22]),
        .WCLK(clk_i),
        .WE(p_0_in__2));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u11/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "29" *) 
  RAM32M \u11/mem_reg_0_3_24_29 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u11/rp_reg_n_0_[1] ,\u11/rp_reg_n_0_[0] }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u11/rp_reg_n_0_[1] ,\u11/rp_reg_n_0_[0] }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u11/rp_reg_n_0_[1] ,\u11/rp_reg_n_0_[0] }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u11/p_1_in }),
        .DIA(\u11/din_tmp [25:24]),
        .DIB(\u11/din_tmp [27:26]),
        .DIC(\u11/din_tmp [29:28]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout0__1[25:24]),
        .DOB(dout0__1[27:26]),
        .DOC(dout0__1[29:28]),
        .WCLK(clk_i),
        .WE(p_0_in__2));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u11/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u11/mem_reg_0_3_30_31 
       (.A0(\u11/p_1_in [0]),
        .A1(\u11/p_1_in [1]),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(\u11/din_tmp [30]),
        .DPO(dout0__1[30]),
        .DPRA0(\u11/rp_reg_n_0_[0] ),
        .DPRA1(\u11/rp_reg_n_0_[1] ),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(p_0_in__2));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u11/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u11/mem_reg_0_3_30_31__0 
       (.A0(\u11/p_1_in [0]),
        .A1(\u11/p_1_in [1]),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(\u11/din_tmp [31]),
        .DPO(dout0__1[31]),
        .DPRA0(\u11/rp_reg_n_0_[0] ),
        .DPRA1(\u11/rp_reg_n_0_[1] ),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(p_0_in__2));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u11/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "11" *) 
  RAM32M \u11/mem_reg_0_3_6_11 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u11/rp_reg_n_0_[1] ,\u11/rp_reg_n_0_[0] }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u11/rp_reg_n_0_[1] ,\u11/rp_reg_n_0_[0] }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u11/rp_reg_n_0_[1] ,\u11/rp_reg_n_0_[0] }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u11/p_1_in }),
        .DIA(\u11/din_tmp [7:6]),
        .DIB(\u11/din_tmp [9:8]),
        .DIC(\u11/din_tmp [11:10]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout0__1[7:6]),
        .DOB(dout0__1[9:8]),
        .DOC(dout0__1[11:10]),
        .WCLK(clk_i),
        .WE(p_0_in__2));
  FDRE \u11/rp_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\rp[0]_i_1__1_n_0 ),
        .Q(\u11/rp_reg_n_0_[0] ),
        .R(\<const0> ));
  FDRE \u11/rp_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\rp[1]_i_1__1_n_0 ),
        .Q(\u11/rp_reg_n_0_[1] ),
        .R(\<const0> ));
  FDRE \u11/rp_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\rp[2]_i_1__1_n_0 ),
        .Q(\u11/rp_reg_n_0_[2] ),
        .R(\<const0> ));
  FDRE \u11/status_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\status[0]_i_1__5_n_0 ),
        .Q(i6_status[0]),
        .R(\<const0> ));
  FDRE \u11/status_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u11/status0 ),
        .Q(i6_status[1]),
        .R(\<const0> ));
  FDRE \u11/wp_reg[0] 
       (.C(clk_i),
        .CE(i6_we),
        .D(\wp[0]_i_1__7_n_0 ),
        .Q(\u11/wp_reg_n_0_[0] ),
        .R(\wp[3]_i_1__1_n_0 ));
  FDRE \u11/wp_reg[1] 
       (.C(clk_i),
        .CE(i6_we),
        .D(wp_p1__1[1]),
        .Q(\u11/p_1_in [0]),
        .R(\wp[3]_i_1__1_n_0 ));
  FDRE \u11/wp_reg[2] 
       (.C(clk_i),
        .CE(i6_we),
        .D(wp_p1__1[2]),
        .Q(\u11/p_1_in [1]),
        .R(\wp[3]_i_1__1_n_0 ));
  FDRE \u11/wp_reg[3] 
       (.C(clk_i),
        .CE(i6_we),
        .D(wp_p1__1[3]),
        .Q(\u11/wp_reg_n_0_[3] ),
        .R(\wp[3]_i_1__1_n_0 ));
  FDRE \u12/dout_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[0]),
        .Q(wb_din[0]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[10] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[10]),
        .Q(wb_din[10]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[11] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[11]),
        .Q(wb_din[11]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[12] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[12]),
        .Q(wb_din[12]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[13] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[13]),
        .Q(wb_din[13]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[14] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[14]),
        .Q(wb_din[14]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[15] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[15]),
        .Q(wb_din[15]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[16] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[16]),
        .Q(wb_din[16]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[17] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[17]),
        .Q(wb_din[17]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[18] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[18]),
        .Q(wb_din[18]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[19] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[19]),
        .Q(wb_din[19]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[1]),
        .Q(wb_din[1]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[20] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[20]),
        .Q(wb_din[20]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[21] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[21]),
        .Q(wb_din[21]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[22] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[22]),
        .Q(wb_din[22]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[23] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[23]),
        .Q(wb_din[23]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[24] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[24]),
        .Q(wb_din[24]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[25] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[25]),
        .Q(wb_din[25]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[26] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[26]),
        .Q(wb_din[26]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[27] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[27]),
        .Q(wb_din[27]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[28] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[28]),
        .Q(wb_din[28]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[29] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[29]),
        .Q(wb_din[29]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[2]),
        .Q(wb_din[2]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[30] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[30]),
        .Q(wb_din[30]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[31] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[31]),
        .Q(wb_din[31]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[3] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[3]),
        .Q(wb_din[3]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[4] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[4]),
        .Q(wb_din[4]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[5] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[5]),
        .Q(wb_din[5]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[6] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[6]),
        .Q(wb_din[6]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[7] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[7]),
        .Q(wb_din[7]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[8] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[8]),
        .Q(wb_din[8]),
        .R(\<const0> ));
  FDRE \u12/dout_reg[9] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(wb_data_i[9]),
        .Q(wb_din[9]),
        .R(\<const0> ));
  FDRE \u12/i3_re_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u12/i3_re0 ),
        .Q(i3_re),
        .R(\<const0> ));
  FDRE \u12/i4_re_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u12/i4_re0 ),
        .Q(i4_re),
        .R(\<const0> ));
  FDRE \u12/i6_re_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u12/i6_re0 ),
        .Q(i6_re),
        .R(\<const0> ));
  FDRE \u12/o3_we_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(o3_we_i_2_n_0),
        .Q(o3_we),
        .R(o3_we_i_1_n_0));
  FDRE \u12/o4_we_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(o4_we_i_1_n_0),
        .Q(o4_we),
        .R(o3_we_i_1_n_0));
  FDRE \u12/o6_we_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(o6_we_i_1_n_0),
        .Q(o6_we),
        .R(o3_we_i_1_n_0));
  FDRE \u12/o7_we_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(o7_we_i_1_n_0),
        .Q(o7_we),
        .R(o3_we_i_1_n_0));
  FDRE \u12/o8_we_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(o8_we_i_1_n_0),
        .Q(o8_we),
        .R(o3_we_i_1_n_0));
  FDRE \u12/o9_we_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(o9_we_i_1_n_0),
        .Q(o9_we),
        .R(o3_we_i_1_n_0));
  FDRE \u12/re1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u12/re10 ),
        .Q(\u12/re1 ),
        .R(\<const0> ));
  FDRE \u12/re2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u12/re20 ),
        .Q(\u12/re2 ),
        .R(\<const0> ));
  FDRE \u12/rf_we_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u12/rf_we0 ),
        .Q(rf_we),
        .R(\<const0> ));
  FDRE \u12/wb_ack_o_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u12/wb_ack_o0 ),
        .Q(wb_ack_o),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[0]_i_1_n_0 ),
        .Q(wb_data_o[0]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[10] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[10]_i_1_n_0 ),
        .Q(wb_data_o[10]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[11] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[11]_i_1_n_0 ),
        .Q(wb_data_o[11]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[12] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[12]_i_1_n_0 ),
        .Q(wb_data_o[12]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[13] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[13]_i_1_n_0 ),
        .Q(wb_data_o[13]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[14] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[14]_i_1_n_0 ),
        .Q(wb_data_o[14]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[15] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[15]_i_1_n_0 ),
        .Q(wb_data_o[15]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[16] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[16]_i_1_n_0 ),
        .Q(wb_data_o[16]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[17] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[17]_i_1_n_0 ),
        .Q(wb_data_o[17]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[18] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[18]_i_1_n_0 ),
        .Q(wb_data_o[18]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[19] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[19]_i_1_n_0 ),
        .Q(wb_data_o[19]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[1]_i_1_n_0 ),
        .Q(wb_data_o[1]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[20] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[20]_i_1_n_0 ),
        .Q(wb_data_o[20]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[21] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[21]_i_1_n_0 ),
        .Q(wb_data_o[21]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[22] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[22]_i_1_n_0 ),
        .Q(wb_data_o[22]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[23] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[23]_i_1_n_0 ),
        .Q(wb_data_o[23]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[24] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[24]_i_1_n_0 ),
        .Q(wb_data_o[24]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[25] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[25]_i_1_n_0 ),
        .Q(wb_data_o[25]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[26] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[26]_i_1_n_0 ),
        .Q(wb_data_o[26]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[27] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[27]_i_1_n_0 ),
        .Q(wb_data_o[27]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[28] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[28]_i_1_n_0 ),
        .Q(wb_data_o[28]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[29] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[29]_i_1_n_0 ),
        .Q(wb_data_o[29]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[2]_i_1_n_0 ),
        .Q(wb_data_o[2]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[30] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[30]_i_1_n_0 ),
        .Q(wb_data_o[30]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[31] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[31]_i_1_n_0 ),
        .Q(wb_data_o[31]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[3] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[3]_i_1_n_0 ),
        .Q(wb_data_o[3]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[4] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[4]_i_1_n_0 ),
        .Q(wb_data_o[4]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[5] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[5]_i_1_n_0 ),
        .Q(wb_data_o[5]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[6] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[6]_i_1_n_0 ),
        .Q(wb_data_o[6]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[7] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[7]_i_1_n_0 ),
        .Q(wb_data_o[7]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[8] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[8]_i_1_n_0 ),
        .Q(wb_data_o[8]),
        .R(\<const0> ));
  FDRE \u12/wb_data_o_reg[9] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wb_data_o[9]_i_1_n_0 ),
        .Q(wb_data_o[9]),
        .R(\<const0> ));
  FDRE \u12/we1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u12/we10 ),
        .Q(\u12/we1 ),
        .R(\<const0> ));
  FDRE \u12/we2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u12/we20 ),
        .Q(\u12/we2 ),
        .R(\<const0> ));
  FDRE \u13/ac97_rst_force_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(ac97_rst_force_i_1_n_0),
        .Q(ac97_rst_force),
        .R(\<const0> ));
  FDRE \u13/crac_dout_r_reg[0] 
       (.C(clk_i),
        .CE(crac_we),
        .D(wb_din[0]),
        .Q(crac_out[0]),
        .R(\<const0> ));
  FDRE \u13/crac_dout_r_reg[10] 
       (.C(clk_i),
        .CE(crac_we),
        .D(wb_din[10]),
        .Q(crac_out[10]),
        .R(\<const0> ));
  FDRE \u13/crac_dout_r_reg[11] 
       (.C(clk_i),
        .CE(crac_we),
        .D(wb_din[11]),
        .Q(crac_out[11]),
        .R(\<const0> ));
  FDRE \u13/crac_dout_r_reg[12] 
       (.C(clk_i),
        .CE(crac_we),
        .D(wb_din[12]),
        .Q(crac_out[12]),
        .R(\<const0> ));
  FDRE \u13/crac_dout_r_reg[13] 
       (.C(clk_i),
        .CE(crac_we),
        .D(wb_din[13]),
        .Q(crac_out[13]),
        .R(\<const0> ));
  FDRE \u13/crac_dout_r_reg[14] 
       (.C(clk_i),
        .CE(crac_we),
        .D(wb_din[14]),
        .Q(crac_out[14]),
        .R(\<const0> ));
  FDRE \u13/crac_dout_r_reg[15] 
       (.C(clk_i),
        .CE(crac_we),
        .D(wb_din[15]),
        .Q(crac_out[15]),
        .R(\<const0> ));
  FDRE \u13/crac_dout_r_reg[1] 
       (.C(clk_i),
        .CE(crac_we),
        .D(wb_din[1]),
        .Q(crac_out[1]),
        .R(\<const0> ));
  FDRE \u13/crac_dout_r_reg[2] 
       (.C(clk_i),
        .CE(crac_we),
        .D(wb_din[2]),
        .Q(crac_out[2]),
        .R(\<const0> ));
  FDRE \u13/crac_dout_r_reg[3] 
       (.C(clk_i),
        .CE(crac_we),
        .D(wb_din[3]),
        .Q(crac_out[3]),
        .R(\<const0> ));
  FDRE \u13/crac_dout_r_reg[4] 
       (.C(clk_i),
        .CE(crac_we),
        .D(wb_din[4]),
        .Q(crac_out[4]),
        .R(\<const0> ));
  FDRE \u13/crac_dout_r_reg[5] 
       (.C(clk_i),
        .CE(crac_we),
        .D(wb_din[5]),
        .Q(crac_out[5]),
        .R(\<const0> ));
  FDRE \u13/crac_dout_r_reg[6] 
       (.C(clk_i),
        .CE(crac_we),
        .D(wb_din[6]),
        .Q(crac_out[6]),
        .R(\<const0> ));
  FDRE \u13/crac_dout_r_reg[7] 
       (.C(clk_i),
        .CE(crac_we),
        .D(wb_din[7]),
        .Q(crac_out[7]),
        .R(\<const0> ));
  FDRE \u13/crac_dout_r_reg[8] 
       (.C(clk_i),
        .CE(crac_we),
        .D(wb_din[8]),
        .Q(crac_out[8]),
        .R(\<const0> ));
  FDRE \u13/crac_dout_r_reg[9] 
       (.C(clk_i),
        .CE(crac_we),
        .D(wb_din[9]),
        .Q(crac_out[9]),
        .R(\<const0> ));
  FDCE \u13/crac_r_reg[0] 
       (.C(clk_i),
        .CE(crac_we),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[16]),
        .Q(crac_out[16]));
  FDCE \u13/crac_r_reg[1] 
       (.C(clk_i),
        .CE(crac_we),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[17]),
        .Q(crac_out[17]));
  FDCE \u13/crac_r_reg[2] 
       (.C(clk_i),
        .CE(crac_we),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[18]),
        .Q(crac_out[18]));
  FDCE \u13/crac_r_reg[3] 
       (.C(clk_i),
        .CE(crac_we),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[19]),
        .Q(crac_out[19]));
  FDCE \u13/crac_r_reg[4] 
       (.C(clk_i),
        .CE(crac_we),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[20]),
        .Q(crac_out[20]));
  FDCE \u13/crac_r_reg[5] 
       (.C(clk_i),
        .CE(crac_we),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[21]),
        .Q(crac_out[21]));
  FDCE \u13/crac_r_reg[6] 
       (.C(clk_i),
        .CE(crac_we),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[22]),
        .Q(crac_out[22]));
  FDCE \u13/crac_r_reg[7] 
       (.C(clk_i),
        .CE(crac_we),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[31]),
        .Q(crac_out[31]));
  FDCE \u13/icc_r_reg[0] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[0]),
        .Q(\u13/icc_r_reg_n_0_[0] ));
  FDCE \u13/icc_r_reg[10] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[10]),
        .Q(i4_mode[0]));
  FDCE \u13/icc_r_reg[11] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[11]),
        .Q(i4_mode[1]));
  FDCE \u13/icc_r_reg[12] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[12]),
        .Q(\u13/icc_r_reg_n_0_[12] ));
  FDCE \u13/icc_r_reg[13] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[13]),
        .Q(\u13/icc_r_reg_n_0_[13] ));
  FDCE \u13/icc_r_reg[14] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[14]),
        .Q(\u13/icc_r_reg_n_0_[14] ));
  FDCE \u13/icc_r_reg[15] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[15]),
        .Q(\u13/icc_r_reg_n_0_[15] ));
  FDCE \u13/icc_r_reg[16] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[16]),
        .Q(\u13/icc_r_reg_n_0_[16] ));
  FDCE \u13/icc_r_reg[17] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[17]),
        .Q(\u13/icc_r_reg_n_0_[17] ));
  FDCE \u13/icc_r_reg[18] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[18]),
        .Q(i6_mode[0]));
  FDCE \u13/icc_r_reg[19] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[19]),
        .Q(i6_mode[1]));
  FDCE \u13/icc_r_reg[1] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[1]),
        .Q(\u13/icc_r_reg_n_0_[1] ));
  FDCE \u13/icc_r_reg[20] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[20]),
        .Q(\u13/icc_r_reg_n_0_[20] ));
  FDCE \u13/icc_r_reg[21] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[21]),
        .Q(\u13/icc_r_reg_n_0_[21] ));
  FDCE \u13/icc_r_reg[22] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[22]),
        .Q(\u13/icc_r_reg_n_0_[22] ));
  FDCE \u13/icc_r_reg[23] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[23]),
        .Q(\u13/icc_r_reg_n_0_[23] ));
  FDCE \u13/icc_r_reg[2] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[2]),
        .Q(i3_mode[0]));
  FDCE \u13/icc_r_reg[3] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[3]),
        .Q(i3_mode[1]));
  FDCE \u13/icc_r_reg[4] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[4]),
        .Q(\u13/icc_r_reg_n_0_[4] ));
  FDCE \u13/icc_r_reg[5] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[5]),
        .Q(\u13/icc_r_reg_n_0_[5] ));
  FDCE \u13/icc_r_reg[6] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[6]),
        .Q(\u13/icc_r_reg_n_0_[6] ));
  FDCE \u13/icc_r_reg[7] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[7]),
        .Q(\u13/icc_r_reg_n_0_[7] ));
  FDCE \u13/icc_r_reg[8] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[8]),
        .Q(\u13/icc_r_reg_n_0_[8] ));
  FDCE \u13/icc_r_reg[9] 
       (.C(clk_i),
        .CE(\u13/icc_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[9]),
        .Q(\u13/icc_r_reg_n_0_[9] ));
  FDRE \u13/int_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(int_i_1_n_0),
        .Q(int_o),
        .R(\<const0> ));
  FDCE \u13/intm_r_reg[0] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[0]),
        .Q(\u13/intm [0]));
  FDCE \u13/intm_r_reg[10] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[10]),
        .Q(\u13/intm [10]));
  FDCE \u13/intm_r_reg[11] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[11]),
        .Q(\u13/intm [11]));
  FDCE \u13/intm_r_reg[12] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[12]),
        .Q(\u13/intm [12]));
  FDCE \u13/intm_r_reg[13] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[13]),
        .Q(\u13/intm [13]));
  FDCE \u13/intm_r_reg[14] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[14]),
        .Q(\u13/intm [14]));
  FDCE \u13/intm_r_reg[15] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[15]),
        .Q(\u13/intm [15]));
  FDCE \u13/intm_r_reg[16] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[16]),
        .Q(\u13/intm [16]));
  FDCE \u13/intm_r_reg[17] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[17]),
        .Q(\u13/intm [17]));
  FDCE \u13/intm_r_reg[18] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[18]),
        .Q(\u13/intm [18]));
  FDCE \u13/intm_r_reg[19] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[19]),
        .Q(\u13/intm [19]));
  FDCE \u13/intm_r_reg[1] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[1]),
        .Q(\u13/intm [1]));
  FDCE \u13/intm_r_reg[20] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[20]),
        .Q(\u13/intm [20]));
  FDCE \u13/intm_r_reg[21] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[21]),
        .Q(\u13/intm [21]));
  FDCE \u13/intm_r_reg[22] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[22]),
        .Q(\u13/intm [22]));
  FDCE \u13/intm_r_reg[23] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[23]),
        .Q(\u13/intm [23]));
  FDCE \u13/intm_r_reg[24] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[24]),
        .Q(\u13/intm [24]));
  FDCE \u13/intm_r_reg[25] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[25]),
        .Q(\u13/intm [25]));
  FDCE \u13/intm_r_reg[26] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[26]),
        .Q(\u13/intm [26]));
  FDCE \u13/intm_r_reg[27] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[27]),
        .Q(\u13/intm [27]));
  FDCE \u13/intm_r_reg[28] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[28]),
        .Q(\u13/intm [28]));
  FDCE \u13/intm_r_reg[2] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[2]),
        .Q(\u13/intm [2]));
  FDCE \u13/intm_r_reg[3] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[3]),
        .Q(\u13/intm [3]));
  FDCE \u13/intm_r_reg[4] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[4]),
        .Q(\u13/intm [4]));
  FDCE \u13/intm_r_reg[5] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[5]),
        .Q(\u13/intm [5]));
  FDCE \u13/intm_r_reg[6] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[6]),
        .Q(\u13/intm [6]));
  FDCE \u13/intm_r_reg[7] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[7]),
        .Q(\u13/intm [7]));
  FDCE \u13/intm_r_reg[8] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[8]),
        .Q(\u13/intm [8]));
  FDCE \u13/intm_r_reg[9] 
       (.C(clk_i),
        .CE(\u13/intm_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[9]),
        .Q(\u13/intm [9]));
  FDCE \u13/ints_r_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[0]_i_1_n_0 ),
        .Q(\u13/ints [0]));
  FDCE \u13/ints_r_reg[10] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[10]_i_1_n_0 ),
        .Q(\u13/ints [10]));
  FDCE \u13/ints_r_reg[11] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[11]_i_1_n_0 ),
        .Q(\u13/ints [11]));
  FDCE \u13/ints_r_reg[12] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[12]_i_1_n_0 ),
        .Q(\u13/ints [12]));
  FDCE \u13/ints_r_reg[13] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[13]_i_1_n_0 ),
        .Q(\u13/ints [13]));
  FDCE \u13/ints_r_reg[14] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[14]_i_1_n_0 ),
        .Q(\u13/ints [14]));
  FDCE \u13/ints_r_reg[15] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[15]_i_1_n_0 ),
        .Q(\u13/ints [15]));
  FDCE \u13/ints_r_reg[16] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[16]_i_1_n_0 ),
        .Q(\u13/ints [16]));
  FDCE \u13/ints_r_reg[17] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[17]_i_1_n_0 ),
        .Q(\u13/ints [17]));
  FDCE \u13/ints_r_reg[18] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[18]_i_1_n_0 ),
        .Q(\u13/ints [18]));
  FDCE \u13/ints_r_reg[19] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[19]_i_1_n_0 ),
        .Q(\u13/ints [19]));
  FDCE \u13/ints_r_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[1]_i_1_n_0 ),
        .Q(\u13/ints [1]));
  FDCE \u13/ints_r_reg[20] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[20]_i_1_n_0 ),
        .Q(\u13/ints [20]));
  FDCE \u13/ints_r_reg[21] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[21]_i_1_n_0 ),
        .Q(\u13/ints [21]));
  FDCE \u13/ints_r_reg[22] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[22]_i_1_n_0 ),
        .Q(\u13/ints [22]));
  FDCE \u13/ints_r_reg[23] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[23]_i_1_n_0 ),
        .Q(\u13/ints [23]));
  FDCE \u13/ints_r_reg[24] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[24]_i_1_n_0 ),
        .Q(\u13/ints [24]));
  FDCE \u13/ints_r_reg[25] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[25]_i_1_n_0 ),
        .Q(\u13/ints [25]));
  FDCE \u13/ints_r_reg[26] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[26]_i_1_n_0 ),
        .Q(\u13/ints [26]));
  FDCE \u13/ints_r_reg[27] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[27]_i_1_n_0 ),
        .Q(\u13/ints [27]));
  FDCE \u13/ints_r_reg[28] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[28]_i_1_n_0 ),
        .Q(\u13/ints [28]));
  FDCE \u13/ints_r_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[2]_i_1_n_0 ),
        .Q(\u13/ints [2]));
  FDCE \u13/ints_r_reg[3] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[3]_i_1_n_0 ),
        .Q(\u13/ints [3]));
  FDCE \u13/ints_r_reg[4] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[4]_i_1_n_0 ),
        .Q(\u13/ints [4]));
  FDCE \u13/ints_r_reg[5] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[5]_i_1_n_0 ),
        .Q(\u13/ints [5]));
  FDCE \u13/ints_r_reg[6] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[6]_i_1_n_0 ),
        .Q(\u13/ints [6]));
  FDCE \u13/ints_r_reg[7] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[7]_i_1_n_0 ),
        .Q(\u13/ints [7]));
  FDCE \u13/ints_r_reg[8] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[8]_i_1_n_0 ),
        .Q(\u13/ints [8]));
  FDCE \u13/ints_r_reg[9] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ints_r[9]_i_1_n_0 ),
        .Q(\u13/ints [9]));
  FDCE \u13/occ0_r_reg[0] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[0]),
        .Q(\u13/occ0_r_reg_n_0_[0] ));
  FDCE \u13/occ0_r_reg[10] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[10]),
        .Q(o4_mode[0]));
  FDCE \u13/occ0_r_reg[11] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[11]),
        .Q(o4_mode[1]));
  FDCE \u13/occ0_r_reg[12] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[12]),
        .Q(\u13/occ0_r_reg_n_0_[12] ));
  FDCE \u13/occ0_r_reg[13] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[13]),
        .Q(\u13/occ0_r_reg_n_0_[13] ));
  FDCE \u13/occ0_r_reg[14] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[14]),
        .Q(\u13/occ0_r_reg_n_0_[14] ));
  FDCE \u13/occ0_r_reg[15] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[15]),
        .Q(\u13/occ0_r_reg_n_0_[15] ));
  FDCE \u13/occ0_r_reg[16] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[16]),
        .Q(\u13/occ0_r_reg_n_0_[16] ));
  FDCE \u13/occ0_r_reg[17] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[17]),
        .Q(\u13/occ0_r_reg_n_0_[17] ));
  FDCE \u13/occ0_r_reg[18] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[18]),
        .Q(o6_mode[0]));
  FDCE \u13/occ0_r_reg[19] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[19]),
        .Q(o6_mode[1]));
  FDCE \u13/occ0_r_reg[1] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[1]),
        .Q(\u13/occ0_r_reg_n_0_[1] ));
  FDCE \u13/occ0_r_reg[20] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[20]),
        .Q(\u13/occ0_r_reg_n_0_[20] ));
  FDCE \u13/occ0_r_reg[21] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[21]),
        .Q(\u13/occ0_r_reg_n_0_[21] ));
  FDCE \u13/occ0_r_reg[22] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[22]),
        .Q(\u13/occ0_r_reg_n_0_[22] ));
  FDCE \u13/occ0_r_reg[23] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[23]),
        .Q(\u13/occ0_r_reg_n_0_[23] ));
  FDCE \u13/occ0_r_reg[24] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[24]),
        .Q(\u13/occ0_r_reg_n_0_[24] ));
  FDCE \u13/occ0_r_reg[25] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[25]),
        .Q(\u13/occ0_r_reg_n_0_[25] ));
  FDCE \u13/occ0_r_reg[26] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[26]),
        .Q(o7_mode[0]));
  FDCE \u13/occ0_r_reg[27] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[27]),
        .Q(o7_mode[1]));
  FDCE \u13/occ0_r_reg[28] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[28]),
        .Q(\u13/occ0_r_reg_n_0_[28] ));
  FDCE \u13/occ0_r_reg[29] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[29]),
        .Q(\u13/occ0_r_reg_n_0_[29] ));
  FDCE \u13/occ0_r_reg[2] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[2]),
        .Q(o3_mode[0]));
  FDCE \u13/occ0_r_reg[30] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[30]),
        .Q(\u13/occ0_r_reg_n_0_[30] ));
  FDCE \u13/occ0_r_reg[31] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[31]),
        .Q(\u13/occ0_r_reg_n_0_[31] ));
  FDCE \u13/occ0_r_reg[3] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[3]),
        .Q(o3_mode[1]));
  FDCE \u13/occ0_r_reg[4] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[4]),
        .Q(\u13/occ0_r_reg_n_0_[4] ));
  FDCE \u13/occ0_r_reg[5] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[5]),
        .Q(\u13/occ0_r_reg_n_0_[5] ));
  FDCE \u13/occ0_r_reg[6] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[6]),
        .Q(\u13/occ0_r_reg_n_0_[6] ));
  FDCE \u13/occ0_r_reg[7] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[7]),
        .Q(\u13/occ0_r_reg_n_0_[7] ));
  FDCE \u13/occ0_r_reg[8] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[8]),
        .Q(\u13/occ0_r_reg_n_0_[8] ));
  FDCE \u13/occ0_r_reg[9] 
       (.C(clk_i),
        .CE(\u13/occ00 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[9]),
        .Q(\u13/occ0_r_reg_n_0_[9] ));
  FDCE \u13/occ1_r_reg[0] 
       (.C(clk_i),
        .CE(\u13/occ1_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[0]),
        .Q(\u13/occ1_r_reg_n_0_[0] ));
  FDCE \u13/occ1_r_reg[10] 
       (.C(clk_i),
        .CE(\u13/occ1_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[10]),
        .Q(o9_mode[0]));
  FDCE \u13/occ1_r_reg[11] 
       (.C(clk_i),
        .CE(\u13/occ1_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[11]),
        .Q(o9_mode[1]));
  FDCE \u13/occ1_r_reg[12] 
       (.C(clk_i),
        .CE(\u13/occ1_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[12]),
        .Q(\u13/occ1_r_reg_n_0_[12] ));
  FDCE \u13/occ1_r_reg[13] 
       (.C(clk_i),
        .CE(\u13/occ1_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[13]),
        .Q(\u13/occ1_r_reg_n_0_[13] ));
  FDCE \u13/occ1_r_reg[14] 
       (.C(clk_i),
        .CE(\u13/occ1_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[14]),
        .Q(\u13/occ1_r_reg_n_0_[14] ));
  FDCE \u13/occ1_r_reg[15] 
       (.C(clk_i),
        .CE(\u13/occ1_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[15]),
        .Q(\u13/occ1_r_reg_n_0_[15] ));
  FDCE \u13/occ1_r_reg[1] 
       (.C(clk_i),
        .CE(\u13/occ1_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[1]),
        .Q(\u13/occ1_r_reg_n_0_[1] ));
  FDCE \u13/occ1_r_reg[2] 
       (.C(clk_i),
        .CE(\u13/occ1_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[2]),
        .Q(o8_mode[0]));
  FDCE \u13/occ1_r_reg[3] 
       (.C(clk_i),
        .CE(\u13/occ1_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[3]),
        .Q(o8_mode[1]));
  FDCE \u13/occ1_r_reg[4] 
       (.C(clk_i),
        .CE(\u13/occ1_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[4]),
        .Q(\u13/occ1_r_reg_n_0_[4] ));
  FDCE \u13/occ1_r_reg[5] 
       (.C(clk_i),
        .CE(\u13/occ1_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[5]),
        .Q(\u13/occ1_r_reg_n_0_[5] ));
  FDCE \u13/occ1_r_reg[6] 
       (.C(clk_i),
        .CE(\u13/occ1_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[6]),
        .Q(\u13/occ1_r_reg_n_0_[6] ));
  FDCE \u13/occ1_r_reg[7] 
       (.C(clk_i),
        .CE(\u13/occ1_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[7]),
        .Q(\u13/occ1_r_reg_n_0_[7] ));
  FDCE \u13/occ1_r_reg[8] 
       (.C(clk_i),
        .CE(\u13/occ1_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[8]),
        .Q(\u13/occ1_r_reg_n_0_[8] ));
  FDCE \u13/occ1_r_reg[9] 
       (.C(clk_i),
        .CE(\u13/occ1_r0 ),
        .CLR(dma_req_i_2_n_0),
        .D(wb_din[9]),
        .Q(\u13/occ1_r_reg_n_0_[9] ));
  FDRE \u13/resume_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(resume_req_i_1_n_0),
        .Q(resume_req),
        .R(\<const0> ));
  FDRE \u14/crac_valid_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(crac_valid_r_i_1_n_0),
        .Q(out_slt0[14]),
        .R(\<const0> ));
  FDRE \u14/crac_wr_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(crac_wr_r_i_1_n_0),
        .Q(out_slt0[13]),
        .R(\<const0> ));
  FDRE \u14/u0/en_out_l2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u14/u0/en_out_l20 ),
        .Q(\u14/u0/en_out_l2_reg_n_0 ),
        .R(\<const0> ));
  FDRE \u14/u0/en_out_l_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(en_out_l_i_1__4_n_0),
        .Q(out_slt0[12]),
        .R(\<const0> ));
  FDRE \u14/u0/full_empty_r_reg 
       (.C(clk_i),
        .CE(\u14/p_0_in ),
        .D(o3_empty),
        .Q(\u14/u0/full_empty_r ),
        .R(\<const0> ));
  FDRE \u14/u1/en_out_l2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u14/u1/en_out_l20 ),
        .Q(\u14/u1/en_out_l2_reg_n_0 ),
        .R(\<const0> ));
  FDRE \u14/u1/en_out_l_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(en_out_l_i_1__3_n_0),
        .Q(out_slt0[11]),
        .R(\<const0> ));
  FDRE \u14/u1/full_empty_r_reg 
       (.C(clk_i),
        .CE(\u14/p_0_in ),
        .D(o4_empty),
        .Q(\u14/u1/full_empty_r ),
        .R(\<const0> ));
  FDRE \u14/u2/en_out_l2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u14/u2/en_out_l20 ),
        .Q(\u14/u2/en_out_l2_reg_n_0 ),
        .R(\<const0> ));
  FDRE \u14/u2/en_out_l_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(en_out_l_i_1__2_n_0),
        .Q(out_slt0[9]),
        .R(\<const0> ));
  FDRE \u14/u2/full_empty_r_reg 
       (.C(clk_i),
        .CE(\u14/p_0_in ),
        .D(o6_empty),
        .Q(\u14/u2/full_empty_r ),
        .R(\<const0> ));
  FDRE \u14/u3/en_out_l2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u14/u3/en_out_l20 ),
        .Q(\u14/u3/en_out_l2_reg_n_0 ),
        .R(\<const0> ));
  FDRE \u14/u3/en_out_l_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(en_out_l_i_1__1_n_0),
        .Q(out_slt0[8]),
        .R(\<const0> ));
  FDRE \u14/u3/full_empty_r_reg 
       (.C(clk_i),
        .CE(\u14/p_0_in ),
        .D(o7_empty),
        .Q(\u14/u3/full_empty_r ),
        .R(\<const0> ));
  FDRE \u14/u4/en_out_l2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u14/u4/en_out_l20 ),
        .Q(\u14/u4/en_out_l2_reg_n_0 ),
        .R(\<const0> ));
  FDRE \u14/u4/en_out_l_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(en_out_l_i_1__0_n_0),
        .Q(out_slt0[7]),
        .R(\<const0> ));
  FDRE \u14/u4/full_empty_r_reg 
       (.C(clk_i),
        .CE(\u14/p_0_in ),
        .D(o8_empty),
        .Q(\u14/u4/full_empty_r ),
        .R(\<const0> ));
  FDRE \u14/u5/en_out_l2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u14/u5/en_out_l20 ),
        .Q(\u14/u5/en_out_l2_reg_n_0 ),
        .R(\<const0> ));
  FDRE \u14/u5/en_out_l_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(en_out_l_i_1_n_0),
        .Q(out_slt0[6]),
        .R(\<const0> ));
  FDRE \u14/u5/full_empty_r_reg 
       (.C(clk_i),
        .CE(\u14/p_0_in ),
        .D(o9_empty),
        .Q(\u14/u5/full_empty_r ),
        .R(\<const0> ));
  FDRE \u14/u6/en_out_l2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u14/u6/en_out_l20 ),
        .Q(\u14/u6/en_out_l2_reg_n_0 ),
        .R(\<const0> ));
  FDRE \u14/u6/en_out_l_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(en_out_l_i_1__5_n_0),
        .Q(\u14/u6/en_out_l_reg_n_0 ),
        .R(\<const0> ));
  FDRE \u14/u6/full_empty_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(full_empty_r_i_1__0_n_0),
        .Q(\u14/u6/full_empty_r ),
        .R(\<const0> ));
  FDRE \u14/u7/en_out_l2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u14/u7/en_out_l20 ),
        .Q(\u14/u7/en_out_l2_reg_n_0 ),
        .R(\<const0> ));
  FDRE \u14/u7/en_out_l_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(en_out_l_i_1__6_n_0),
        .Q(\u14/u7/en_out_l_reg_n_0 ),
        .R(\<const0> ));
  FDRE \u14/u7/full_empty_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(full_empty_r_i_1__1_n_0),
        .Q(\u14/u7/full_empty_r ),
        .R(\<const0> ));
  FDRE \u14/u8/en_out_l2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u14/u8/en_out_l20 ),
        .Q(\u14/u8/en_out_l2_reg_n_0 ),
        .R(\<const0> ));
  FDRE \u14/u8/en_out_l_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(en_out_l_i_1__7_n_0),
        .Q(\u14/u8/en_out_l_reg_n_0 ),
        .R(\<const0> ));
  FDRE \u14/u8/full_empty_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(full_empty_r_i_1__2_n_0),
        .Q(\u14/u8/full_empty_r ),
        .R(\<const0> ));
  FDCE \u15/crac_din_reg[0] 
       (.C(clk_i),
        .CE(crac_rd_done),
        .CLR(dma_req_i_2_n_0),
        .D(in_slt2[4]),
        .Q(crac_din[0]));
  FDCE \u15/crac_din_reg[10] 
       (.C(clk_i),
        .CE(crac_rd_done),
        .CLR(dma_req_i_2_n_0),
        .D(in_slt2[14]),
        .Q(crac_din[10]));
  FDCE \u15/crac_din_reg[11] 
       (.C(clk_i),
        .CE(crac_rd_done),
        .CLR(dma_req_i_2_n_0),
        .D(in_slt2[15]),
        .Q(crac_din[11]));
  FDCE \u15/crac_din_reg[12] 
       (.C(clk_i),
        .CE(crac_rd_done),
        .CLR(dma_req_i_2_n_0),
        .D(in_slt2[16]),
        .Q(crac_din[12]));
  FDCE \u15/crac_din_reg[13] 
       (.C(clk_i),
        .CE(crac_rd_done),
        .CLR(dma_req_i_2_n_0),
        .D(in_slt2[17]),
        .Q(crac_din[13]));
  FDCE \u15/crac_din_reg[14] 
       (.C(clk_i),
        .CE(crac_rd_done),
        .CLR(dma_req_i_2_n_0),
        .D(in_slt2[18]),
        .Q(crac_din[14]));
  FDCE \u15/crac_din_reg[15] 
       (.C(clk_i),
        .CE(crac_rd_done),
        .CLR(dma_req_i_2_n_0),
        .D(in_slt2[19]),
        .Q(crac_din[15]));
  FDCE \u15/crac_din_reg[1] 
       (.C(clk_i),
        .CE(crac_rd_done),
        .CLR(dma_req_i_2_n_0),
        .D(in_slt2[5]),
        .Q(crac_din[1]));
  FDCE \u15/crac_din_reg[2] 
       (.C(clk_i),
        .CE(crac_rd_done),
        .CLR(dma_req_i_2_n_0),
        .D(in_slt2[6]),
        .Q(crac_din[2]));
  FDCE \u15/crac_din_reg[3] 
       (.C(clk_i),
        .CE(crac_rd_done),
        .CLR(dma_req_i_2_n_0),
        .D(in_slt2[7]),
        .Q(crac_din[3]));
  FDCE \u15/crac_din_reg[4] 
       (.C(clk_i),
        .CE(crac_rd_done),
        .CLR(dma_req_i_2_n_0),
        .D(in_slt2[8]),
        .Q(crac_din[4]));
  FDCE \u15/crac_din_reg[5] 
       (.C(clk_i),
        .CE(crac_rd_done),
        .CLR(dma_req_i_2_n_0),
        .D(in_slt2[9]),
        .Q(crac_din[5]));
  FDCE \u15/crac_din_reg[6] 
       (.C(clk_i),
        .CE(crac_rd_done),
        .CLR(dma_req_i_2_n_0),
        .D(in_slt2[10]),
        .Q(crac_din[6]));
  FDCE \u15/crac_din_reg[7] 
       (.C(clk_i),
        .CE(crac_rd_done),
        .CLR(dma_req_i_2_n_0),
        .D(in_slt2[11]),
        .Q(crac_din[7]));
  FDCE \u15/crac_din_reg[8] 
       (.C(clk_i),
        .CE(crac_rd_done),
        .CLR(dma_req_i_2_n_0),
        .D(in_slt2[12]),
        .Q(crac_din[8]));
  FDCE \u15/crac_din_reg[9] 
       (.C(clk_i),
        .CE(crac_rd_done),
        .CLR(dma_req_i_2_n_0),
        .D(in_slt2[13]),
        .Q(crac_din[9]));
  FDRE \u15/crac_rd_done_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u15/crac_rd_done0 ),
        .Q(crac_rd_done),
        .R(\<const0> ));
  FDCE \u15/crac_rd_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(crac_rd_i_1_n_0),
        .Q(\u15/crac_rd ));
  FDRE \u15/crac_we_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(crac_we),
        .Q(\u15/crac_we_r ),
        .R(\<const0> ));
  FDCE \u15/crac_wr_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(crac_wr_i_1_n_0),
        .Q(crac_wr));
  FDCE \u15/rdd1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(rdd1_i_1_n_0),
        .Q(\u15/rdd1 ));
  FDCE \u15/rdd2_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(rdd2_i_1_n_0),
        .Q(\u15/rdd2 ));
  FDCE \u15/rdd3_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(rdd3_i_1_n_0),
        .Q(\u15/rdd3 ));
  FDRE \u15/valid_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(valid_s),
        .Q(\u15/valid_r ),
        .R(\<const0> ));
  FDRE \u16/u0/dma_req_r1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u16/u0/dma_req_r10 ),
        .Q(\u16/u0/dma_req_r1 ),
        .R(\<const0> ));
  FDCE \u16/u0/dma_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(dma_req_i_1_n_0),
        .Q(dma_req_o[0]));
  FDRE \u16/u1/dma_req_r1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u16/u1/dma_req_r10 ),
        .Q(\u16/u1/dma_req_r1 ),
        .R(\<const0> ));
  FDCE \u16/u1/dma_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(dma_req_i_1__0_n_0),
        .Q(dma_req_o[1]));
  FDRE \u16/u2/dma_req_r1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u16/u2/dma_req_r10 ),
        .Q(\u16/u2/dma_req_r1 ),
        .R(\<const0> ));
  FDCE \u16/u2/dma_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(dma_req_i_1__1_n_0),
        .Q(dma_req_o[2]));
  FDRE \u16/u3/dma_req_r1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u16/u3/dma_req_r10 ),
        .Q(\u16/u3/dma_req_r1 ),
        .R(\<const0> ));
  FDCE \u16/u3/dma_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(dma_req_i_1__2_n_0),
        .Q(dma_req_o[3]));
  FDRE \u16/u4/dma_req_r1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u16/u4/dma_req_r10 ),
        .Q(\u16/u4/dma_req_r1 ),
        .R(\<const0> ));
  FDCE \u16/u4/dma_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(dma_req_i_1__3_n_0),
        .Q(dma_req_o[4]));
  FDRE \u16/u5/dma_req_r1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u16/u5/dma_req_r10 ),
        .Q(\u16/u5/dma_req_r1 ),
        .R(\<const0> ));
  FDCE \u16/u5/dma_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(dma_req_i_1__4_n_0),
        .Q(dma_req_o[5]));
  FDRE \u16/u6/dma_req_r1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u16/u6/dma_req_r10 ),
        .Q(\u16/u6/dma_req_r1 ),
        .R(\<const0> ));
  FDCE \u16/u6/dma_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(dma_req_i_1__5_n_0),
        .Q(dma_req_o[6]));
  FDRE \u16/u7/dma_req_r1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u16/u7/dma_req_r10 ),
        .Q(\u16/u7/dma_req_r1 ),
        .R(\<const0> ));
  FDCE \u16/u7/dma_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(dma_req_i_1__6_n_0),
        .Q(dma_req_o[7]));
  FDRE \u16/u8/dma_req_r1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u16/u8/dma_req_r10 ),
        .Q(\u16/u8/dma_req_r1 ),
        .R(\<const0> ));
  FDCE \u16/u8/dma_req_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(dma_req_i_1__7_n_0),
        .Q(dma_req_o[8]));
  FDCE \u17/int_set_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\int_set[0]_i_1_n_0 ),
        .Q(oc0_int_set[0]));
  FDCE \u17/int_set_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u17/int_set_reg00_out ),
        .Q(oc0_int_set[1]));
  FDCE \u17/int_set_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u17/int_set_reg0 ),
        .Q(oc0_int_set[2]));
  FDCE \u18/int_set_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\int_set[0]_i_1__0_n_0 ),
        .Q(oc1_int_set[0]));
  FDCE \u18/int_set_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u18/int_set_reg00_out ),
        .Q(oc1_int_set[1]));
  FDCE \u18/int_set_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u18/int_set_reg0 ),
        .Q(oc1_int_set[2]));
  FDCE \u19/int_set_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\int_set[0]_i_1__1_n_0 ),
        .Q(oc2_int_set[0]));
  FDCE \u19/int_set_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u19/int_set_reg00_out ),
        .Q(oc2_int_set[1]));
  FDCE \u19/int_set_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u19/int_set_reg0 ),
        .Q(oc2_int_set[2]));
  FDRE \u2/bit_clk_e_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u2/bit_clk_e0 ),
        .Q(\u2/bit_clk_e ),
        .R(\<const0> ));
  FDRE \u2/bit_clk_r1_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u2/bit_clk_r ),
        .Q(\u2/bit_clk_r1 ),
        .R(\<const0> ));
  FDRE \u2/bit_clk_r_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(bit_clk_pad_i),
        .Q(\u2/bit_clk_r ),
        .R(\<const0> ));
  FDPE \u2/cnt_reg[0] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\cnt[0]_i_1__0_n_0 ),
        .PRE(dma_req_i_2_n_0),
        .Q(\u2/cnt_reg [0]));
  FDPE \u2/cnt_reg[1] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in__1__0[1]),
        .PRE(dma_req_i_2_n_0),
        .Q(\u2/cnt_reg [1]));
  FDPE \u2/cnt_reg[2] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in__1__0[2]),
        .PRE(dma_req_i_2_n_0),
        .Q(\u2/cnt_reg [2]));
  FDPE \u2/cnt_reg[3] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in__1__0[3]),
        .PRE(dma_req_i_2_n_0),
        .Q(\u2/cnt_reg [3]));
  FDPE \u2/cnt_reg[4] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in__1__0[4]),
        .PRE(dma_req_i_2_n_0),
        .Q(\u2/cnt_reg [4]));
  FDPE \u2/cnt_reg[5] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in__1__0[5]),
        .PRE(dma_req_i_2_n_0),
        .Q(\u2/cnt_reg [5]));
  FDPE \u2/cnt_reg[6] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in__1__0[6]),
        .PRE(dma_req_i_2_n_0),
        .Q(\u2/cnt_reg [6]));
  FDPE \u2/cnt_reg[7] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(p_0_in__1__0[7]),
        .PRE(dma_req_i_2_n_0),
        .Q(\u2/cnt_reg [7]));
  FDRE \u2/in_valid_reg[0] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u2/p_0_in ),
        .Q(in_valid[0]),
        .R(\<const0> ));
  FDRE \u2/in_valid_reg[1] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\in_valid[1]_i_1_n_0 ),
        .Q(in_valid[1]),
        .R(\<const0> ));
  FDRE \u2/in_valid_reg[2] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\in_valid[2]_i_1_n_0 ),
        .Q(in_valid[2]),
        .R(\<const0> ));
  FDRE \u2/ld_reg 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(ld_i_1_n_0),
        .Q(ld),
        .R(\<const0> ));
  FDRE \u2/out_le_reg[0] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\out_le[0]_i_1_n_0 ),
        .Q(out_le[0]),
        .R(\<const0> ));
  FDRE \u2/out_le_reg[1] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\out_le[1]_i_1_n_0 ),
        .Q(out_le[1]),
        .R(\<const0> ));
  FDRE \u2/out_le_reg[2] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\out_le[2]_i_1_n_0 ),
        .Q(out_le[2]),
        .R(\<const0> ));
  FDRE \u2/out_le_reg[3] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\out_le[3]_i_1_n_0 ),
        .Q(out_le[3]),
        .R(\<const0> ));
  FDRE \u2/out_le_reg[4] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\out_le[4]_i_1_n_0 ),
        .Q(out_le[4]),
        .R(\<const0> ));
  FDRE \u2/out_le_reg[5] 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\out_le[5]_i_1_n_0 ),
        .Q(out_le[5]),
        .R(\<const0> ));
  FDRE \u2/res_cnt_reg[0] 
       (.C(clk_i),
        .CE(ps_ce),
        .D(p_0_in__0__0[0]),
        .Q(\u2/res_cnt_reg [0]),
        .R(\u2/clear ));
  FDRE \u2/res_cnt_reg[1] 
       (.C(clk_i),
        .CE(ps_ce),
        .D(p_0_in__0__0[1]),
        .Q(\u2/res_cnt_reg [1]),
        .R(\u2/clear ));
  FDRE \u2/res_cnt_reg[2] 
       (.C(clk_i),
        .CE(ps_ce),
        .D(p_0_in__0__0[2]),
        .Q(\u2/res_cnt_reg [2]),
        .R(\u2/clear ));
  FDRE \u2/res_cnt_reg[3] 
       (.C(clk_i),
        .CE(ps_ce),
        .D(p_0_in__0__0[3]),
        .Q(\u2/res_cnt_reg [3]),
        .R(\u2/clear ));
  FDRE \u2/suspended_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u2/to ),
        .Q(suspended_o),
        .R(\<const0> ));
  FDRE \u2/sync_beat_reg 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(\u2/sync_beat0 ),
        .Q(\u2/sync_beat ),
        .R(\<const0> ));
  FDCE \u2/sync_resume_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(sync_resume_i_1_n_0),
        .Q(\u2/sync_resume_reg_n_0 ));
  FDCE \u2/to_cnt_reg[0] 
       (.C(clk_i),
        .CE(\to_cnt[5]_i_1_n_0 ),
        .CLR(dma_req_i_2_n_0),
        .D(\to_cnt[0]_i_1_n_0 ),
        .Q(\u2/to_cnt_reg [0]));
  FDCE \u2/to_cnt_reg[1] 
       (.C(clk_i),
        .CE(\to_cnt[5]_i_1_n_0 ),
        .CLR(dma_req_i_2_n_0),
        .D(p_0_in__3[1]),
        .Q(\u2/to_cnt_reg [1]));
  FDCE \u2/to_cnt_reg[2] 
       (.C(clk_i),
        .CE(\to_cnt[5]_i_1_n_0 ),
        .CLR(dma_req_i_2_n_0),
        .D(p_0_in__3[2]),
        .Q(\u2/to_cnt_reg [2]));
  FDCE \u2/to_cnt_reg[3] 
       (.C(clk_i),
        .CE(\to_cnt[5]_i_1_n_0 ),
        .CLR(dma_req_i_2_n_0),
        .D(p_0_in__3[3]),
        .Q(\u2/to_cnt_reg [3]));
  FDCE \u2/to_cnt_reg[4] 
       (.C(clk_i),
        .CE(\to_cnt[5]_i_1_n_0 ),
        .CLR(dma_req_i_2_n_0),
        .D(p_0_in__3[4]),
        .Q(\u2/to_cnt_reg [4]));
  FDCE \u2/to_cnt_reg[5] 
       (.C(clk_i),
        .CE(\to_cnt[5]_i_1_n_0 ),
        .CLR(dma_req_i_2_n_0),
        .D(p_0_in__3[5]),
        .Q(\u2/to_cnt_reg [5]));
  FDRE \u2/valid_reg 
       (.C(bit_clk_pad_i),
        .CE(\<const1> ),
        .D(valid_i_1_n_0),
        .Q(valid),
        .R(\<const0> ));
  FDCE \u20/int_set_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\int_set[0]_i_1__2_n_0 ),
        .Q(oc3_int_set[0]));
  FDCE \u20/int_set_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u20/int_set_reg00_out ),
        .Q(oc3_int_set[1]));
  FDCE \u20/int_set_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u20/int_set_reg0 ),
        .Q(oc3_int_set[2]));
  FDCE \u21/int_set_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\int_set[0]_i_1__3_n_0 ),
        .Q(oc4_int_set[0]));
  FDCE \u21/int_set_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u21/int_set_reg00_out ),
        .Q(oc4_int_set[1]));
  FDCE \u21/int_set_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u21/int_set_reg0 ),
        .Q(oc4_int_set[2]));
  FDCE \u22/int_set_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\int_set[0]_i_1__4_n_0 ),
        .Q(oc5_int_set[0]));
  FDCE \u22/int_set_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u22/int_set_reg00_out ),
        .Q(oc5_int_set[1]));
  FDCE \u22/int_set_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u22/int_set_reg0 ),
        .Q(oc5_int_set[2]));
  FDCE \u23/int_set_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\int_set[0]_i_1__5_n_0 ),
        .Q(ic0_int_set[0]));
  FDCE \u23/int_set_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u23/int_set_reg00_out ),
        .Q(ic0_int_set[1]));
  FDCE \u23/int_set_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u23/int_set_reg0 ),
        .Q(ic0_int_set[2]));
  FDCE \u24/int_set_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\int_set[0]_i_1__6_n_0 ),
        .Q(ic1_int_set[0]));
  FDCE \u24/int_set_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u24/int_set_reg00_out ),
        .Q(ic1_int_set[1]));
  FDCE \u24/int_set_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u24/int_set_reg0 ),
        .Q(ic1_int_set[2]));
  FDCE \u25/int_set_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\int_set[0]_i_1__7_n_0 ),
        .Q(ic2_int_set[0]));
  FDCE \u25/int_set_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u25/int_set_reg00_out ),
        .Q(ic2_int_set[1]));
  FDCE \u25/int_set_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\u25/int_set_reg0 ),
        .Q(ic2_int_set[2]));
  FDCE \u26/ac97_rst__reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(ac97_rst__i_1_n_0),
        .Q(ac97_reset_pad_o_));
  FDCE \u26/cnt_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\cnt[0]_i_1_n_0 ),
        .Q(\u26/cnt [0]));
  FDCE \u26/cnt_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\cnt[1]_i_1_n_0 ),
        .Q(\u26/cnt [1]));
  FDCE \u26/cnt_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\cnt[2]_i_1_n_0 ),
        .Q(\u26/cnt [2]));
  FDCE \u26/ps_cnt_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(\ps_cnt[0]_i_1_n_0 ),
        .Q(\u26/ps_cnt_reg [0]));
  FDCE \u26/ps_cnt_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(p_0_in__8[1]),
        .Q(\u26/ps_cnt_reg [1]));
  FDCE \u26/ps_cnt_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(p_0_in__8[2]),
        .Q(\u26/ps_cnt_reg [2]));
  FDCE \u26/ps_cnt_reg[3] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(p_0_in__8[3]),
        .Q(\u26/ps_cnt_reg [3]));
  FDCE \u26/ps_cnt_reg[4] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(p_0_in__8[4]),
        .Q(\u26/ps_cnt_reg [4]));
  FDCE \u26/ps_cnt_reg[5] 
       (.C(clk_i),
        .CE(\<const1> ),
        .CLR(dma_req_i_2_n_0),
        .D(p_0_in__8[5]),
        .Q(\u26/ps_cnt_reg [5]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \u3/dout[0]_i_1 
       (.I0(o3_mode[1]),
        .I1(dout_tmp[0]),
        .O(\u3/dout[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u3/dout[10]_i_1 
       (.I0(dout_tmp[10]),
        .I1(o3_mode[1]),
        .I2(\u3/dout[10]_i_2_n_0 ),
        .O(\u3/dout[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u3/dout[10]_i_2 
       (.I0(dout_tmp[8]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[22]),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(dout_tmp[6]),
        .O(\u3/dout[10]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u3/dout[11]_i_1 
       (.I0(dout_tmp[11]),
        .I1(o3_mode[1]),
        .I2(\u3/dout[11]_i_2_n_0 ),
        .O(\u3/dout[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u3/dout[11]_i_2 
       (.I0(dout_tmp[9]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[23]),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(dout_tmp[7]),
        .O(\u3/dout[11]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u3/dout[12]_i_1 
       (.I0(dout_tmp[12]),
        .I1(o3_mode[1]),
        .I2(\u3/dout[12]_i_2_n_0 ),
        .O(\u3/dout[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u3/dout[12]_i_2 
       (.I0(dout_tmp[10]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[24]),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(dout_tmp[8]),
        .O(\u3/dout[12]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u3/dout[13]_i_1 
       (.I0(dout_tmp[13]),
        .I1(o3_mode[1]),
        .I2(\u3/dout[13]_i_2_n_0 ),
        .O(\u3/dout[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u3/dout[13]_i_2 
       (.I0(dout_tmp[11]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[25]),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(dout_tmp[9]),
        .O(\u3/dout[13]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u3/dout[14]_i_1 
       (.I0(dout_tmp[14]),
        .I1(o3_mode[1]),
        .I2(\u3/dout[14]_i_2_n_0 ),
        .O(\u3/dout[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u3/dout[14]_i_2 
       (.I0(dout_tmp[12]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[26]),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(dout_tmp[10]),
        .O(\u3/dout[14]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u3/dout[15]_i_1 
       (.I0(dout_tmp[15]),
        .I1(o3_mode[1]),
        .I2(\u3/dout[15]_i_2_n_0 ),
        .O(\u3/dout[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u3/dout[15]_i_2 
       (.I0(dout_tmp[13]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[27]),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(dout_tmp[11]),
        .O(\u3/dout[15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u3/dout[16]_i_1 
       (.I0(dout_tmp[16]),
        .I1(o3_mode[1]),
        .I2(\u3/dout[16]_i_2_n_0 ),
        .O(\u3/dout[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u3/dout[16]_i_2 
       (.I0(dout_tmp[14]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[28]),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(dout_tmp[12]),
        .O(\u3/dout[16]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u3/dout[17]_i_1 
       (.I0(dout_tmp[17]),
        .I1(o3_mode[1]),
        .I2(\u3/dout[17]_i_2_n_0 ),
        .O(\u3/dout[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u3/dout[17]_i_2 
       (.I0(dout_tmp[15]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[29]),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(dout_tmp[13]),
        .O(\u3/dout[17]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u3/dout[18]_i_1 
       (.I0(dout_tmp[18]),
        .I1(o3_mode[1]),
        .I2(\u3/dout[18]_i_2_n_0 ),
        .O(\u3/dout[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u3/dout[18]_i_2 
       (.I0(dout_tmp[16]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[30]),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(dout_tmp[14]),
        .O(\u3/dout[18]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u3/dout[19]_i_3 
       (.I0(dout_tmp[19]),
        .I1(o3_mode[1]),
        .I2(\u3/dout[19]_i_4_n_0 ),
        .O(\u3/dout[19]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u3/dout[19]_i_4 
       (.I0(dout_tmp[17]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[31]),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(dout_tmp[15]),
        .O(\u3/dout[19]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \u3/dout[1]_i_1 
       (.I0(o3_mode[1]),
        .I1(dout_tmp[1]),
        .O(\u3/dout[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \u3/dout[2]_i_1 
       (.I0(dout_tmp[0]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[2]),
        .I3(o3_mode[1]),
        .O(\u3/dout[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \u3/dout[3]_i_1 
       (.I0(dout_tmp[1]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[3]),
        .I3(o3_mode[1]),
        .O(\u3/dout[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u3/dout[4]_i_1 
       (.I0(dout_tmp[4]),
        .I1(o3_mode[1]),
        .I2(\u3/dout[4]_i_2_n_0 ),
        .O(\u3/dout[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u3/dout[4]_i_2 
       (.I0(dout_tmp[2]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[16]),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(dout_tmp[0]),
        .O(\u3/dout[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u3/dout[5]_i_1 
       (.I0(dout_tmp[5]),
        .I1(o3_mode[1]),
        .I2(\u3/dout[5]_i_2_n_0 ),
        .O(\u3/dout[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u3/dout[5]_i_2 
       (.I0(dout_tmp[3]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[17]),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(dout_tmp[1]),
        .O(\u3/dout[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u3/dout[6]_i_1 
       (.I0(dout_tmp[6]),
        .I1(o3_mode[1]),
        .I2(\u3/dout[6]_i_2_n_0 ),
        .O(\u3/dout[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u3/dout[6]_i_2 
       (.I0(dout_tmp[4]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[18]),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(dout_tmp[2]),
        .O(\u3/dout[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u3/dout[7]_i_1 
       (.I0(dout_tmp[7]),
        .I1(o3_mode[1]),
        .I2(\u3/dout[7]_i_2_n_0 ),
        .O(\u3/dout[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u3/dout[7]_i_2 
       (.I0(dout_tmp[5]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[19]),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(dout_tmp[3]),
        .O(\u3/dout[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u3/dout[8]_i_1 
       (.I0(dout_tmp[8]),
        .I1(o3_mode[1]),
        .I2(\u3/dout[8]_i_2_n_0 ),
        .O(\u3/dout[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u3/dout[8]_i_2 
       (.I0(dout_tmp[6]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[20]),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(dout_tmp[4]),
        .O(\u3/dout[8]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u3/dout[9]_i_1 
       (.I0(dout_tmp[9]),
        .I1(o3_mode[1]),
        .I2(\u3/dout[9]_i_2_n_0 ),
        .O(\u3/dout[9]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u3/dout[9]_i_2 
       (.I0(dout_tmp[7]),
        .I1(o3_mode[0]),
        .I2(dout_tmp[21]),
        .I3(\u3/rp_reg_n_0_[0] ),
        .I4(dout_tmp[5]),
        .O(\u3/dout[9]_i_2_n_0 ));
  FDRE \u3/dout_reg[0] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[0]_i_1_n_0 ),
        .Q(out_slt3[0]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[10] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[10]_i_1_n_0 ),
        .Q(out_slt3[10]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[11] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[11]_i_1_n_0 ),
        .Q(out_slt3[11]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[12] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[12]_i_1_n_0 ),
        .Q(out_slt3[12]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[13] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[13]_i_1_n_0 ),
        .Q(out_slt3[13]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[14] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[14]_i_1_n_0 ),
        .Q(out_slt3[14]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[15] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[15]_i_1_n_0 ),
        .Q(out_slt3[15]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[16] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[16]_i_1_n_0 ),
        .Q(out_slt3[16]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[17] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[17]_i_1_n_0 ),
        .Q(out_slt3[17]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[18] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[18]_i_1_n_0 ),
        .Q(out_slt3[18]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[19] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[19]_i_3_n_0 ),
        .Q(out_slt3[19]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[1] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[1]_i_1_n_0 ),
        .Q(out_slt3[1]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[2] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[2]_i_1_n_0 ),
        .Q(out_slt3[2]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[3] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[3]_i_1_n_0 ),
        .Q(out_slt3[3]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[4] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[4]_i_1_n_0 ),
        .Q(out_slt3[4]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[5] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[5]_i_1_n_0 ),
        .Q(out_slt3[5]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[6] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[6]_i_1_n_0 ),
        .Q(out_slt3[6]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[7] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[7]_i_1_n_0 ),
        .Q(out_slt3[7]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[8] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[8]_i_1_n_0 ),
        .Q(out_slt3[8]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/dout_reg[9] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\u3/dout[9]_i_1_n_0 ),
        .Q(out_slt3[9]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/empty_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u3/empty0 ),
        .Q(o3_empty),
        .R(\<const0> ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u3/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "5" *) 
  RAM32M \u3/mem_reg_0_3_0_5 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u3/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u3/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u3/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u3/wp_reg_n_0_[1] ,\u3/wp_reg_n_0_[0] }),
        .DIA(wb_din[1:0]),
        .DIB(wb_din[3:2]),
        .DIC(wb_din[5:4]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp[1:0]),
        .DOB(dout_tmp[3:2]),
        .DOC(dout_tmp[5:4]),
        .WCLK(clk_i),
        .WE(o3_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u3/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "17" *) 
  RAM32M \u3/mem_reg_0_3_12_17 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u3/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u3/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u3/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u3/wp_reg_n_0_[1] ,\u3/wp_reg_n_0_[0] }),
        .DIA(wb_din[13:12]),
        .DIB(wb_din[15:14]),
        .DIC(wb_din[17:16]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp[13:12]),
        .DOB(dout_tmp[15:14]),
        .DOC(dout_tmp[17:16]),
        .WCLK(clk_i),
        .WE(o3_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u3/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "23" *) 
  RAM32M \u3/mem_reg_0_3_18_23 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u3/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u3/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u3/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u3/wp_reg_n_0_[1] ,\u3/wp_reg_n_0_[0] }),
        .DIA(wb_din[19:18]),
        .DIB(wb_din[21:20]),
        .DIC(wb_din[23:22]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp[19:18]),
        .DOB(dout_tmp[21:20]),
        .DOC(dout_tmp[23:22]),
        .WCLK(clk_i),
        .WE(o3_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u3/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "29" *) 
  RAM32M \u3/mem_reg_0_3_24_29 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u3/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u3/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u3/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u3/wp_reg_n_0_[1] ,\u3/wp_reg_n_0_[0] }),
        .DIA(wb_din[25:24]),
        .DIB(wb_din[27:26]),
        .DIC(wb_din[29:28]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp[25:24]),
        .DOB(dout_tmp[27:26]),
        .DOC(dout_tmp[29:28]),
        .WCLK(clk_i),
        .WE(o3_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u3/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u3/mem_reg_0_3_30_31 
       (.A0(\u3/wp_reg_n_0_[0] ),
        .A1(\u3/wp_reg_n_0_[1] ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(wb_din[30]),
        .DPO(dout_tmp[30]),
        .DPRA0(\u3/p_0_in [0]),
        .DPRA1(\u3/p_0_in [1]),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(o3_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u3/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u3/mem_reg_0_3_30_31__0 
       (.A0(\u3/wp_reg_n_0_[0] ),
        .A1(\u3/wp_reg_n_0_[1] ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(wb_din[31]),
        .DPO(dout_tmp[31]),
        .DPRA0(\u3/p_0_in [0]),
        .DPRA1(\u3/p_0_in [1]),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(o3_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u3/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "11" *) 
  RAM32M \u3/mem_reg_0_3_6_11 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u3/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u3/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u3/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u3/wp_reg_n_0_[1] ,\u3/wp_reg_n_0_[0] }),
        .DIA(wb_din[7:6]),
        .DIB(wb_din[9:8]),
        .DIC(wb_din[11:10]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp[7:6]),
        .DOB(dout_tmp[9:8]),
        .DOC(dout_tmp[11:10]),
        .WCLK(clk_i),
        .WE(o3_we));
  FDRE \u3/rp_reg[0] 
       (.C(clk_i),
        .CE(o3_re),
        .D(\rp[0]_i_1__2_n_0 ),
        .Q(\u3/rp_reg_n_0_[0] ),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/rp_reg[1] 
       (.C(clk_i),
        .CE(o3_re),
        .D(p_0_in__2__0[1]),
        .Q(\u3/p_0_in [0]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/rp_reg[2] 
       (.C(clk_i),
        .CE(o3_re),
        .D(p_0_in__2__0[2]),
        .Q(\u3/p_0_in [1]),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/rp_reg[3] 
       (.C(clk_i),
        .CE(o3_re),
        .D(p_0_in__2__0[3]),
        .Q(\u3/rp_reg_n_0_[3] ),
        .R(\dout[19]_i_1_n_0 ));
  FDRE \u3/status_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\status[0]_i_1_n_0 ),
        .Q(o3_status[0]),
        .R(\<const0> ));
  FDRE \u3/status_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u3/status0 ),
        .Q(o3_status[1]),
        .R(\<const0> ));
  FDRE \u3/wp_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[0]_i_1_n_0 ),
        .Q(\u3/wp_reg_n_0_[0] ),
        .R(\<const0> ));
  FDRE \u3/wp_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[1]_i_1_n_0 ),
        .Q(\u3/wp_reg_n_0_[1] ),
        .R(\<const0> ));
  FDRE \u3/wp_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[2]_i_1_n_0 ),
        .Q(\u3/p_1_in ),
        .R(\<const0> ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \u4/dout[0]_i_1 
       (.I0(o4_mode[1]),
        .I1(dout_tmp__0[0]),
        .O(\u4/dout[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u4/dout[10]_i_1 
       (.I0(dout_tmp__0[10]),
        .I1(o4_mode[1]),
        .I2(\u4/dout[10]_i_2_n_0 ),
        .O(\u4/dout[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u4/dout[10]_i_2 
       (.I0(dout_tmp__0[8]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[22]),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(dout_tmp__0[6]),
        .O(\u4/dout[10]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u4/dout[11]_i_1 
       (.I0(dout_tmp__0[11]),
        .I1(o4_mode[1]),
        .I2(\u4/dout[11]_i_2_n_0 ),
        .O(\u4/dout[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u4/dout[11]_i_2 
       (.I0(dout_tmp__0[9]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[23]),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(dout_tmp__0[7]),
        .O(\u4/dout[11]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u4/dout[12]_i_1 
       (.I0(dout_tmp__0[12]),
        .I1(o4_mode[1]),
        .I2(\u4/dout[12]_i_2_n_0 ),
        .O(\u4/dout[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u4/dout[12]_i_2 
       (.I0(dout_tmp__0[10]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[24]),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(dout_tmp__0[8]),
        .O(\u4/dout[12]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u4/dout[13]_i_1 
       (.I0(dout_tmp__0[13]),
        .I1(o4_mode[1]),
        .I2(\u4/dout[13]_i_2_n_0 ),
        .O(\u4/dout[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u4/dout[13]_i_2 
       (.I0(dout_tmp__0[11]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[25]),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(dout_tmp__0[9]),
        .O(\u4/dout[13]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u4/dout[14]_i_1 
       (.I0(dout_tmp__0[14]),
        .I1(o4_mode[1]),
        .I2(\u4/dout[14]_i_2_n_0 ),
        .O(\u4/dout[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u4/dout[14]_i_2 
       (.I0(dout_tmp__0[12]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[26]),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(dout_tmp__0[10]),
        .O(\u4/dout[14]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u4/dout[15]_i_1 
       (.I0(dout_tmp__0[15]),
        .I1(o4_mode[1]),
        .I2(\u4/dout[15]_i_2_n_0 ),
        .O(\u4/dout[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u4/dout[15]_i_2 
       (.I0(dout_tmp__0[13]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[27]),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(dout_tmp__0[11]),
        .O(\u4/dout[15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u4/dout[16]_i_1 
       (.I0(dout_tmp__0[16]),
        .I1(o4_mode[1]),
        .I2(\u4/dout[16]_i_2_n_0 ),
        .O(\u4/dout[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u4/dout[16]_i_2 
       (.I0(dout_tmp__0[14]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[28]),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(dout_tmp__0[12]),
        .O(\u4/dout[16]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u4/dout[17]_i_1 
       (.I0(dout_tmp__0[17]),
        .I1(o4_mode[1]),
        .I2(\u4/dout[17]_i_2_n_0 ),
        .O(\u4/dout[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u4/dout[17]_i_2 
       (.I0(dout_tmp__0[15]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[29]),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(dout_tmp__0[13]),
        .O(\u4/dout[17]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u4/dout[18]_i_1 
       (.I0(dout_tmp__0[18]),
        .I1(o4_mode[1]),
        .I2(\u4/dout[18]_i_2_n_0 ),
        .O(\u4/dout[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u4/dout[18]_i_2 
       (.I0(dout_tmp__0[16]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[30]),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(dout_tmp__0[14]),
        .O(\u4/dout[18]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u4/dout[19]_i_3 
       (.I0(dout_tmp__0[19]),
        .I1(o4_mode[1]),
        .I2(\u4/dout[19]_i_4_n_0 ),
        .O(\u4/dout[19]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u4/dout[19]_i_4 
       (.I0(dout_tmp__0[17]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[31]),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(dout_tmp__0[15]),
        .O(\u4/dout[19]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \u4/dout[1]_i_1 
       (.I0(o4_mode[1]),
        .I1(dout_tmp__0[1]),
        .O(\u4/dout[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \u4/dout[2]_i_1 
       (.I0(dout_tmp__0[0]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[2]),
        .I3(o4_mode[1]),
        .O(\u4/dout[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \u4/dout[3]_i_1 
       (.I0(dout_tmp__0[1]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[3]),
        .I3(o4_mode[1]),
        .O(\u4/dout[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u4/dout[4]_i_1 
       (.I0(dout_tmp__0[4]),
        .I1(o4_mode[1]),
        .I2(\u4/dout[4]_i_2_n_0 ),
        .O(\u4/dout[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u4/dout[4]_i_2 
       (.I0(dout_tmp__0[2]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[16]),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(dout_tmp__0[0]),
        .O(\u4/dout[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u4/dout[5]_i_1 
       (.I0(dout_tmp__0[5]),
        .I1(o4_mode[1]),
        .I2(\u4/dout[5]_i_2_n_0 ),
        .O(\u4/dout[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u4/dout[5]_i_2 
       (.I0(dout_tmp__0[3]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[17]),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(dout_tmp__0[1]),
        .O(\u4/dout[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u4/dout[6]_i_1 
       (.I0(dout_tmp__0[6]),
        .I1(o4_mode[1]),
        .I2(\u4/dout[6]_i_2_n_0 ),
        .O(\u4/dout[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u4/dout[6]_i_2 
       (.I0(dout_tmp__0[4]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[18]),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(dout_tmp__0[2]),
        .O(\u4/dout[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u4/dout[7]_i_1 
       (.I0(dout_tmp__0[7]),
        .I1(o4_mode[1]),
        .I2(\u4/dout[7]_i_2_n_0 ),
        .O(\u4/dout[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u4/dout[7]_i_2 
       (.I0(dout_tmp__0[5]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[19]),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(dout_tmp__0[3]),
        .O(\u4/dout[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u4/dout[8]_i_1 
       (.I0(dout_tmp__0[8]),
        .I1(o4_mode[1]),
        .I2(\u4/dout[8]_i_2_n_0 ),
        .O(\u4/dout[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u4/dout[8]_i_2 
       (.I0(dout_tmp__0[6]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[20]),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(dout_tmp__0[4]),
        .O(\u4/dout[8]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u4/dout[9]_i_1 
       (.I0(dout_tmp__0[9]),
        .I1(o4_mode[1]),
        .I2(\u4/dout[9]_i_2_n_0 ),
        .O(\u4/dout[9]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u4/dout[9]_i_2 
       (.I0(dout_tmp__0[7]),
        .I1(o4_mode[0]),
        .I2(dout_tmp__0[21]),
        .I3(\u4/rp_reg_n_0_[0] ),
        .I4(dout_tmp__0[5]),
        .O(\u4/dout[9]_i_2_n_0 ));
  FDRE \u4/dout_reg[0] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[0]_i_1_n_0 ),
        .Q(out_slt4[0]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[10] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[10]_i_1_n_0 ),
        .Q(out_slt4[10]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[11] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[11]_i_1_n_0 ),
        .Q(out_slt4[11]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[12] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[12]_i_1_n_0 ),
        .Q(out_slt4[12]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[13] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[13]_i_1_n_0 ),
        .Q(out_slt4[13]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[14] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[14]_i_1_n_0 ),
        .Q(out_slt4[14]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[15] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[15]_i_1_n_0 ),
        .Q(out_slt4[15]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[16] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[16]_i_1_n_0 ),
        .Q(out_slt4[16]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[17] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[17]_i_1_n_0 ),
        .Q(out_slt4[17]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[18] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[18]_i_1_n_0 ),
        .Q(out_slt4[18]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[19] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[19]_i_3_n_0 ),
        .Q(out_slt4[19]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[1] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[1]_i_1_n_0 ),
        .Q(out_slt4[1]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[2] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[2]_i_1_n_0 ),
        .Q(out_slt4[2]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[3] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[3]_i_1_n_0 ),
        .Q(out_slt4[3]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[4] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[4]_i_1_n_0 ),
        .Q(out_slt4[4]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[5] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[5]_i_1_n_0 ),
        .Q(out_slt4[5]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[6] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[6]_i_1_n_0 ),
        .Q(out_slt4[6]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[7] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[7]_i_1_n_0 ),
        .Q(out_slt4[7]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[8] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[8]_i_1_n_0 ),
        .Q(out_slt4[8]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/dout_reg[9] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\u4/dout[9]_i_1_n_0 ),
        .Q(out_slt4[9]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/empty_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u4/empty0 ),
        .Q(o4_empty),
        .R(\<const0> ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u4/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "5" *) 
  RAM32M \u4/mem_reg_0_3_0_5 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u4/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u4/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u4/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u4/wp_reg_n_0_[1] ,\u4/wp_reg_n_0_[0] }),
        .DIA(wb_din[1:0]),
        .DIB(wb_din[3:2]),
        .DIC(wb_din[5:4]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__0[1:0]),
        .DOB(dout_tmp__0[3:2]),
        .DOC(dout_tmp__0[5:4]),
        .WCLK(clk_i),
        .WE(o4_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u4/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "17" *) 
  RAM32M \u4/mem_reg_0_3_12_17 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u4/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u4/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u4/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u4/wp_reg_n_0_[1] ,\u4/wp_reg_n_0_[0] }),
        .DIA(wb_din[13:12]),
        .DIB(wb_din[15:14]),
        .DIC(wb_din[17:16]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__0[13:12]),
        .DOB(dout_tmp__0[15:14]),
        .DOC(dout_tmp__0[17:16]),
        .WCLK(clk_i),
        .WE(o4_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u4/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "23" *) 
  RAM32M \u4/mem_reg_0_3_18_23 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u4/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u4/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u4/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u4/wp_reg_n_0_[1] ,\u4/wp_reg_n_0_[0] }),
        .DIA(wb_din[19:18]),
        .DIB(wb_din[21:20]),
        .DIC(wb_din[23:22]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__0[19:18]),
        .DOB(dout_tmp__0[21:20]),
        .DOC(dout_tmp__0[23:22]),
        .WCLK(clk_i),
        .WE(o4_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u4/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "29" *) 
  RAM32M \u4/mem_reg_0_3_24_29 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u4/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u4/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u4/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u4/wp_reg_n_0_[1] ,\u4/wp_reg_n_0_[0] }),
        .DIA(wb_din[25:24]),
        .DIB(wb_din[27:26]),
        .DIC(wb_din[29:28]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__0[25:24]),
        .DOB(dout_tmp__0[27:26]),
        .DOC(dout_tmp__0[29:28]),
        .WCLK(clk_i),
        .WE(o4_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u4/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u4/mem_reg_0_3_30_31 
       (.A0(\u4/wp_reg_n_0_[0] ),
        .A1(\u4/wp_reg_n_0_[1] ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(wb_din[30]),
        .DPO(dout_tmp__0[30]),
        .DPRA0(\u4/p_0_in [0]),
        .DPRA1(\u4/p_0_in [1]),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(o4_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u4/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u4/mem_reg_0_3_30_31__0 
       (.A0(\u4/wp_reg_n_0_[0] ),
        .A1(\u4/wp_reg_n_0_[1] ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(wb_din[31]),
        .DPO(dout_tmp__0[31]),
        .DPRA0(\u4/p_0_in [0]),
        .DPRA1(\u4/p_0_in [1]),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(o4_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u4/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "11" *) 
  RAM32M \u4/mem_reg_0_3_6_11 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u4/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u4/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u4/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u4/wp_reg_n_0_[1] ,\u4/wp_reg_n_0_[0] }),
        .DIA(wb_din[7:6]),
        .DIB(wb_din[9:8]),
        .DIC(wb_din[11:10]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__0[7:6]),
        .DOB(dout_tmp__0[9:8]),
        .DOC(dout_tmp__0[11:10]),
        .WCLK(clk_i),
        .WE(o4_we));
  FDRE \u4/rp_reg[0] 
       (.C(clk_i),
        .CE(o4_re),
        .D(\rp[0]_i_1__3_n_0 ),
        .Q(\u4/rp_reg_n_0_[0] ),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/rp_reg[1] 
       (.C(clk_i),
        .CE(o4_re),
        .D(p_0_in__3__0[1]),
        .Q(\u4/p_0_in [0]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/rp_reg[2] 
       (.C(clk_i),
        .CE(o4_re),
        .D(p_0_in__3__0[2]),
        .Q(\u4/p_0_in [1]),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/rp_reg[3] 
       (.C(clk_i),
        .CE(o4_re),
        .D(p_0_in__3__0[3]),
        .Q(\u4/rp_reg_n_0_[3] ),
        .R(\dout[19]_i_1__0_n_0 ));
  FDRE \u4/status_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\status[0]_i_1__0_n_0 ),
        .Q(o4_status[0]),
        .R(\<const0> ));
  FDRE \u4/status_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u4/status0 ),
        .Q(o4_status[1]),
        .R(\<const0> ));
  FDRE \u4/wp_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[0]_i_1__0_n_0 ),
        .Q(\u4/wp_reg_n_0_[0] ),
        .R(\<const0> ));
  FDRE \u4/wp_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[1]_i_1__0_n_0 ),
        .Q(\u4/wp_reg_n_0_[1] ),
        .R(\<const0> ));
  FDRE \u4/wp_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[2]_i_1__0_n_0 ),
        .Q(\u4/p_1_in ),
        .R(\<const0> ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \u5/dout[0]_i_1 
       (.I0(o6_mode[1]),
        .I1(dout_tmp__1[0]),
        .O(\u5/dout[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u5/dout[10]_i_1 
       (.I0(dout_tmp__1[10]),
        .I1(o6_mode[1]),
        .I2(\u5/dout[10]_i_2_n_0 ),
        .O(\u5/dout[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u5/dout[10]_i_2 
       (.I0(dout_tmp__1[8]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[22]),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(dout_tmp__1[6]),
        .O(\u5/dout[10]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u5/dout[11]_i_1 
       (.I0(dout_tmp__1[11]),
        .I1(o6_mode[1]),
        .I2(\u5/dout[11]_i_2_n_0 ),
        .O(\u5/dout[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u5/dout[11]_i_2 
       (.I0(dout_tmp__1[9]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[23]),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(dout_tmp__1[7]),
        .O(\u5/dout[11]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u5/dout[12]_i_1 
       (.I0(dout_tmp__1[12]),
        .I1(o6_mode[1]),
        .I2(\u5/dout[12]_i_2_n_0 ),
        .O(\u5/dout[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u5/dout[12]_i_2 
       (.I0(dout_tmp__1[10]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[24]),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(dout_tmp__1[8]),
        .O(\u5/dout[12]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u5/dout[13]_i_1 
       (.I0(dout_tmp__1[13]),
        .I1(o6_mode[1]),
        .I2(\u5/dout[13]_i_2_n_0 ),
        .O(\u5/dout[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u5/dout[13]_i_2 
       (.I0(dout_tmp__1[11]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[25]),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(dout_tmp__1[9]),
        .O(\u5/dout[13]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u5/dout[14]_i_1 
       (.I0(dout_tmp__1[14]),
        .I1(o6_mode[1]),
        .I2(\u5/dout[14]_i_2_n_0 ),
        .O(\u5/dout[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u5/dout[14]_i_2 
       (.I0(dout_tmp__1[12]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[26]),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(dout_tmp__1[10]),
        .O(\u5/dout[14]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u5/dout[15]_i_1 
       (.I0(dout_tmp__1[15]),
        .I1(o6_mode[1]),
        .I2(\u5/dout[15]_i_2_n_0 ),
        .O(\u5/dout[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u5/dout[15]_i_2 
       (.I0(dout_tmp__1[13]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[27]),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(dout_tmp__1[11]),
        .O(\u5/dout[15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u5/dout[16]_i_1 
       (.I0(dout_tmp__1[16]),
        .I1(o6_mode[1]),
        .I2(\u5/dout[16]_i_2_n_0 ),
        .O(\u5/dout[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u5/dout[16]_i_2 
       (.I0(dout_tmp__1[14]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[28]),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(dout_tmp__1[12]),
        .O(\u5/dout[16]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u5/dout[17]_i_1 
       (.I0(dout_tmp__1[17]),
        .I1(o6_mode[1]),
        .I2(\u5/dout[17]_i_2_n_0 ),
        .O(\u5/dout[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u5/dout[17]_i_2 
       (.I0(dout_tmp__1[15]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[29]),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(dout_tmp__1[13]),
        .O(\u5/dout[17]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u5/dout[18]_i_1 
       (.I0(dout_tmp__1[18]),
        .I1(o6_mode[1]),
        .I2(\u5/dout[18]_i_2_n_0 ),
        .O(\u5/dout[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u5/dout[18]_i_2 
       (.I0(dout_tmp__1[16]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[30]),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(dout_tmp__1[14]),
        .O(\u5/dout[18]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u5/dout[19]_i_3 
       (.I0(dout_tmp__1[19]),
        .I1(o6_mode[1]),
        .I2(\u5/dout[19]_i_4_n_0 ),
        .O(\u5/dout[19]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u5/dout[19]_i_4 
       (.I0(dout_tmp__1[17]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[31]),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(dout_tmp__1[15]),
        .O(\u5/dout[19]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \u5/dout[1]_i_1 
       (.I0(o6_mode[1]),
        .I1(dout_tmp__1[1]),
        .O(\u5/dout[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \u5/dout[2]_i_1 
       (.I0(dout_tmp__1[0]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[2]),
        .I3(o6_mode[1]),
        .O(\u5/dout[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \u5/dout[3]_i_1 
       (.I0(dout_tmp__1[1]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[3]),
        .I3(o6_mode[1]),
        .O(\u5/dout[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u5/dout[4]_i_1 
       (.I0(dout_tmp__1[4]),
        .I1(o6_mode[1]),
        .I2(\u5/dout[4]_i_2_n_0 ),
        .O(\u5/dout[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u5/dout[4]_i_2 
       (.I0(dout_tmp__1[2]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[16]),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(dout_tmp__1[0]),
        .O(\u5/dout[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u5/dout[5]_i_1 
       (.I0(dout_tmp__1[5]),
        .I1(o6_mode[1]),
        .I2(\u5/dout[5]_i_2_n_0 ),
        .O(\u5/dout[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u5/dout[5]_i_2 
       (.I0(dout_tmp__1[3]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[17]),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(dout_tmp__1[1]),
        .O(\u5/dout[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u5/dout[6]_i_1 
       (.I0(dout_tmp__1[6]),
        .I1(o6_mode[1]),
        .I2(\u5/dout[6]_i_2_n_0 ),
        .O(\u5/dout[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u5/dout[6]_i_2 
       (.I0(dout_tmp__1[4]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[18]),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(dout_tmp__1[2]),
        .O(\u5/dout[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u5/dout[7]_i_1 
       (.I0(dout_tmp__1[7]),
        .I1(o6_mode[1]),
        .I2(\u5/dout[7]_i_2_n_0 ),
        .O(\u5/dout[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u5/dout[7]_i_2 
       (.I0(dout_tmp__1[5]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[19]),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(dout_tmp__1[3]),
        .O(\u5/dout[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u5/dout[8]_i_1 
       (.I0(dout_tmp__1[8]),
        .I1(o6_mode[1]),
        .I2(\u5/dout[8]_i_2_n_0 ),
        .O(\u5/dout[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u5/dout[8]_i_2 
       (.I0(dout_tmp__1[6]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[20]),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(dout_tmp__1[4]),
        .O(\u5/dout[8]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u5/dout[9]_i_1 
       (.I0(dout_tmp__1[9]),
        .I1(o6_mode[1]),
        .I2(\u5/dout[9]_i_2_n_0 ),
        .O(\u5/dout[9]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u5/dout[9]_i_2 
       (.I0(dout_tmp__1[7]),
        .I1(o6_mode[0]),
        .I2(dout_tmp__1[21]),
        .I3(\u5/rp_reg_n_0_[0] ),
        .I4(dout_tmp__1[5]),
        .O(\u5/dout[9]_i_2_n_0 ));
  FDRE \u5/dout_reg[0] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[0]_i_1_n_0 ),
        .Q(out_slt6[0]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[10] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[10]_i_1_n_0 ),
        .Q(out_slt6[10]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[11] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[11]_i_1_n_0 ),
        .Q(out_slt6[11]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[12] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[12]_i_1_n_0 ),
        .Q(out_slt6[12]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[13] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[13]_i_1_n_0 ),
        .Q(out_slt6[13]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[14] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[14]_i_1_n_0 ),
        .Q(out_slt6[14]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[15] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[15]_i_1_n_0 ),
        .Q(out_slt6[15]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[16] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[16]_i_1_n_0 ),
        .Q(out_slt6[16]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[17] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[17]_i_1_n_0 ),
        .Q(out_slt6[17]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[18] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[18]_i_1_n_0 ),
        .Q(out_slt6[18]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[19] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[19]_i_3_n_0 ),
        .Q(out_slt6[19]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[1] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[1]_i_1_n_0 ),
        .Q(out_slt6[1]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[2] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[2]_i_1_n_0 ),
        .Q(out_slt6[2]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[3] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[3]_i_1_n_0 ),
        .Q(out_slt6[3]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[4] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[4]_i_1_n_0 ),
        .Q(out_slt6[4]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[5] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[5]_i_1_n_0 ),
        .Q(out_slt6[5]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[6] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[6]_i_1_n_0 ),
        .Q(out_slt6[6]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[7] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[7]_i_1_n_0 ),
        .Q(out_slt6[7]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[8] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[8]_i_1_n_0 ),
        .Q(out_slt6[8]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/dout_reg[9] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\u5/dout[9]_i_1_n_0 ),
        .Q(out_slt6[9]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/empty_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/empty0 ),
        .Q(o6_empty),
        .R(\<const0> ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u5/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "5" *) 
  RAM32M \u5/mem_reg_0_3_0_5 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u5/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u5/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u5/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u5/wp_reg_n_0_[1] ,\u5/wp_reg_n_0_[0] }),
        .DIA(wb_din[1:0]),
        .DIB(wb_din[3:2]),
        .DIC(wb_din[5:4]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__1[1:0]),
        .DOB(dout_tmp__1[3:2]),
        .DOC(dout_tmp__1[5:4]),
        .WCLK(clk_i),
        .WE(o6_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u5/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "17" *) 
  RAM32M \u5/mem_reg_0_3_12_17 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u5/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u5/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u5/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u5/wp_reg_n_0_[1] ,\u5/wp_reg_n_0_[0] }),
        .DIA(wb_din[13:12]),
        .DIB(wb_din[15:14]),
        .DIC(wb_din[17:16]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__1[13:12]),
        .DOB(dout_tmp__1[15:14]),
        .DOC(dout_tmp__1[17:16]),
        .WCLK(clk_i),
        .WE(o6_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u5/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "23" *) 
  RAM32M \u5/mem_reg_0_3_18_23 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u5/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u5/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u5/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u5/wp_reg_n_0_[1] ,\u5/wp_reg_n_0_[0] }),
        .DIA(wb_din[19:18]),
        .DIB(wb_din[21:20]),
        .DIC(wb_din[23:22]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__1[19:18]),
        .DOB(dout_tmp__1[21:20]),
        .DOC(dout_tmp__1[23:22]),
        .WCLK(clk_i),
        .WE(o6_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u5/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "29" *) 
  RAM32M \u5/mem_reg_0_3_24_29 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u5/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u5/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u5/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u5/wp_reg_n_0_[1] ,\u5/wp_reg_n_0_[0] }),
        .DIA(wb_din[25:24]),
        .DIB(wb_din[27:26]),
        .DIC(wb_din[29:28]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__1[25:24]),
        .DOB(dout_tmp__1[27:26]),
        .DOC(dout_tmp__1[29:28]),
        .WCLK(clk_i),
        .WE(o6_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u5/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u5/mem_reg_0_3_30_31 
       (.A0(\u5/wp_reg_n_0_[0] ),
        .A1(\u5/wp_reg_n_0_[1] ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(wb_din[30]),
        .DPO(dout_tmp__1[30]),
        .DPRA0(\u5/p_0_in [0]),
        .DPRA1(\u5/p_0_in [1]),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(o6_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u5/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u5/mem_reg_0_3_30_31__0 
       (.A0(\u5/wp_reg_n_0_[0] ),
        .A1(\u5/wp_reg_n_0_[1] ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(wb_din[31]),
        .DPO(dout_tmp__1[31]),
        .DPRA0(\u5/p_0_in [0]),
        .DPRA1(\u5/p_0_in [1]),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(o6_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u5/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "11" *) 
  RAM32M \u5/mem_reg_0_3_6_11 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u5/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u5/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u5/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u5/wp_reg_n_0_[1] ,\u5/wp_reg_n_0_[0] }),
        .DIA(wb_din[7:6]),
        .DIB(wb_din[9:8]),
        .DIC(wb_din[11:10]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__1[7:6]),
        .DOB(dout_tmp__1[9:8]),
        .DOC(dout_tmp__1[11:10]),
        .WCLK(clk_i),
        .WE(o6_we));
  FDRE \u5/rp_reg[0] 
       (.C(clk_i),
        .CE(o6_re),
        .D(\rp[0]_i_1__4_n_0 ),
        .Q(\u5/rp_reg_n_0_[0] ),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/rp_reg[1] 
       (.C(clk_i),
        .CE(o6_re),
        .D(p_0_in__4[1]),
        .Q(\u5/p_0_in [0]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/rp_reg[2] 
       (.C(clk_i),
        .CE(o6_re),
        .D(p_0_in__4[2]),
        .Q(\u5/p_0_in [1]),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/rp_reg[3] 
       (.C(clk_i),
        .CE(o6_re),
        .D(p_0_in__4[3]),
        .Q(\u5/rp_reg_n_0_[3] ),
        .R(\dout[19]_i_1__1_n_0 ));
  FDRE \u5/status_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\status[0]_i_1__1_n_0 ),
        .Q(o6_status[0]),
        .R(\<const0> ));
  FDRE \u5/status_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u5/status0 ),
        .Q(o6_status[1]),
        .R(\<const0> ));
  FDRE \u5/wp_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[0]_i_1__1_n_0 ),
        .Q(\u5/wp_reg_n_0_[0] ),
        .R(\<const0> ));
  FDRE \u5/wp_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[1]_i_1__1_n_0 ),
        .Q(\u5/wp_reg_n_0_[1] ),
        .R(\<const0> ));
  FDRE \u5/wp_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[2]_i_1__1_n_0 ),
        .Q(\u5/p_1_in ),
        .R(\<const0> ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \u6/dout[0]_i_1 
       (.I0(o7_mode[1]),
        .I1(dout_tmp__2[0]),
        .O(\u6/dout[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u6/dout[10]_i_1 
       (.I0(dout_tmp__2[10]),
        .I1(o7_mode[1]),
        .I2(\u6/dout[10]_i_2_n_0 ),
        .O(\u6/dout[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u6/dout[10]_i_2 
       (.I0(dout_tmp__2[8]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[22]),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(dout_tmp__2[6]),
        .O(\u6/dout[10]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u6/dout[11]_i_1 
       (.I0(dout_tmp__2[11]),
        .I1(o7_mode[1]),
        .I2(\u6/dout[11]_i_2_n_0 ),
        .O(\u6/dout[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u6/dout[11]_i_2 
       (.I0(dout_tmp__2[9]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[23]),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(dout_tmp__2[7]),
        .O(\u6/dout[11]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u6/dout[12]_i_1 
       (.I0(dout_tmp__2[12]),
        .I1(o7_mode[1]),
        .I2(\u6/dout[12]_i_2_n_0 ),
        .O(\u6/dout[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u6/dout[12]_i_2 
       (.I0(dout_tmp__2[10]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[24]),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(dout_tmp__2[8]),
        .O(\u6/dout[12]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u6/dout[13]_i_1 
       (.I0(dout_tmp__2[13]),
        .I1(o7_mode[1]),
        .I2(\u6/dout[13]_i_2_n_0 ),
        .O(\u6/dout[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u6/dout[13]_i_2 
       (.I0(dout_tmp__2[11]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[25]),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(dout_tmp__2[9]),
        .O(\u6/dout[13]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u6/dout[14]_i_1 
       (.I0(dout_tmp__2[14]),
        .I1(o7_mode[1]),
        .I2(\u6/dout[14]_i_2_n_0 ),
        .O(\u6/dout[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u6/dout[14]_i_2 
       (.I0(dout_tmp__2[12]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[26]),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(dout_tmp__2[10]),
        .O(\u6/dout[14]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u6/dout[15]_i_1 
       (.I0(dout_tmp__2[15]),
        .I1(o7_mode[1]),
        .I2(\u6/dout[15]_i_2_n_0 ),
        .O(\u6/dout[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u6/dout[15]_i_2 
       (.I0(dout_tmp__2[13]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[27]),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(dout_tmp__2[11]),
        .O(\u6/dout[15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u6/dout[16]_i_1 
       (.I0(dout_tmp__2[16]),
        .I1(o7_mode[1]),
        .I2(\u6/dout[16]_i_2_n_0 ),
        .O(\u6/dout[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u6/dout[16]_i_2 
       (.I0(dout_tmp__2[14]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[28]),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(dout_tmp__2[12]),
        .O(\u6/dout[16]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u6/dout[17]_i_1 
       (.I0(dout_tmp__2[17]),
        .I1(o7_mode[1]),
        .I2(\u6/dout[17]_i_2_n_0 ),
        .O(\u6/dout[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u6/dout[17]_i_2 
       (.I0(dout_tmp__2[15]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[29]),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(dout_tmp__2[13]),
        .O(\u6/dout[17]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u6/dout[18]_i_1 
       (.I0(dout_tmp__2[18]),
        .I1(o7_mode[1]),
        .I2(\u6/dout[18]_i_2_n_0 ),
        .O(\u6/dout[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u6/dout[18]_i_2 
       (.I0(dout_tmp__2[16]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[30]),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(dout_tmp__2[14]),
        .O(\u6/dout[18]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u6/dout[19]_i_3 
       (.I0(dout_tmp__2[19]),
        .I1(o7_mode[1]),
        .I2(\u6/dout[19]_i_4_n_0 ),
        .O(\u6/dout[19]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u6/dout[19]_i_4 
       (.I0(dout_tmp__2[17]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[31]),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(dout_tmp__2[15]),
        .O(\u6/dout[19]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \u6/dout[1]_i_1 
       (.I0(o7_mode[1]),
        .I1(dout_tmp__2[1]),
        .O(\u6/dout[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \u6/dout[2]_i_1 
       (.I0(dout_tmp__2[0]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[2]),
        .I3(o7_mode[1]),
        .O(\u6/dout[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \u6/dout[3]_i_1 
       (.I0(dout_tmp__2[1]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[3]),
        .I3(o7_mode[1]),
        .O(\u6/dout[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u6/dout[4]_i_1 
       (.I0(dout_tmp__2[4]),
        .I1(o7_mode[1]),
        .I2(\u6/dout[4]_i_2_n_0 ),
        .O(\u6/dout[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u6/dout[4]_i_2 
       (.I0(dout_tmp__2[2]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[16]),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(dout_tmp__2[0]),
        .O(\u6/dout[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u6/dout[5]_i_1 
       (.I0(dout_tmp__2[5]),
        .I1(o7_mode[1]),
        .I2(\u6/dout[5]_i_2_n_0 ),
        .O(\u6/dout[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u6/dout[5]_i_2 
       (.I0(dout_tmp__2[3]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[17]),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(dout_tmp__2[1]),
        .O(\u6/dout[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u6/dout[6]_i_1 
       (.I0(dout_tmp__2[6]),
        .I1(o7_mode[1]),
        .I2(\u6/dout[6]_i_2_n_0 ),
        .O(\u6/dout[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u6/dout[6]_i_2 
       (.I0(dout_tmp__2[4]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[18]),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(dout_tmp__2[2]),
        .O(\u6/dout[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u6/dout[7]_i_1 
       (.I0(dout_tmp__2[7]),
        .I1(o7_mode[1]),
        .I2(\u6/dout[7]_i_2_n_0 ),
        .O(\u6/dout[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u6/dout[7]_i_2 
       (.I0(dout_tmp__2[5]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[19]),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(dout_tmp__2[3]),
        .O(\u6/dout[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u6/dout[8]_i_1 
       (.I0(dout_tmp__2[8]),
        .I1(o7_mode[1]),
        .I2(\u6/dout[8]_i_2_n_0 ),
        .O(\u6/dout[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u6/dout[8]_i_2 
       (.I0(dout_tmp__2[6]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[20]),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(dout_tmp__2[4]),
        .O(\u6/dout[8]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u6/dout[9]_i_1 
       (.I0(dout_tmp__2[9]),
        .I1(o7_mode[1]),
        .I2(\u6/dout[9]_i_2_n_0 ),
        .O(\u6/dout[9]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u6/dout[9]_i_2 
       (.I0(dout_tmp__2[7]),
        .I1(o7_mode[0]),
        .I2(dout_tmp__2[21]),
        .I3(\u6/rp_reg_n_0_[0] ),
        .I4(dout_tmp__2[5]),
        .O(\u6/dout[9]_i_2_n_0 ));
  FDRE \u6/dout_reg[0] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[0]_i_1_n_0 ),
        .Q(out_slt7[0]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[10] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[10]_i_1_n_0 ),
        .Q(out_slt7[10]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[11] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[11]_i_1_n_0 ),
        .Q(out_slt7[11]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[12] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[12]_i_1_n_0 ),
        .Q(out_slt7[12]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[13] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[13]_i_1_n_0 ),
        .Q(out_slt7[13]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[14] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[14]_i_1_n_0 ),
        .Q(out_slt7[14]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[15] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[15]_i_1_n_0 ),
        .Q(out_slt7[15]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[16] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[16]_i_1_n_0 ),
        .Q(out_slt7[16]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[17] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[17]_i_1_n_0 ),
        .Q(out_slt7[17]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[18] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[18]_i_1_n_0 ),
        .Q(out_slt7[18]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[19] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[19]_i_3_n_0 ),
        .Q(out_slt7[19]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[1] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[1]_i_1_n_0 ),
        .Q(out_slt7[1]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[2] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[2]_i_1_n_0 ),
        .Q(out_slt7[2]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[3] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[3]_i_1_n_0 ),
        .Q(out_slt7[3]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[4] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[4]_i_1_n_0 ),
        .Q(out_slt7[4]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[5] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[5]_i_1_n_0 ),
        .Q(out_slt7[5]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[6] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[6]_i_1_n_0 ),
        .Q(out_slt7[6]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[7] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[7]_i_1_n_0 ),
        .Q(out_slt7[7]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[8] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[8]_i_1_n_0 ),
        .Q(out_slt7[8]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/dout_reg[9] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\u6/dout[9]_i_1_n_0 ),
        .Q(out_slt7[9]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/empty_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u6/empty0 ),
        .Q(o7_empty),
        .R(\<const0> ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u6/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "5" *) 
  RAM32M \u6/mem_reg_0_3_0_5 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u6/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u6/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u6/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u6/wp_reg_n_0_[1] ,\u6/wp_reg_n_0_[0] }),
        .DIA(wb_din[1:0]),
        .DIB(wb_din[3:2]),
        .DIC(wb_din[5:4]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__2[1:0]),
        .DOB(dout_tmp__2[3:2]),
        .DOC(dout_tmp__2[5:4]),
        .WCLK(clk_i),
        .WE(o7_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u6/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "17" *) 
  RAM32M \u6/mem_reg_0_3_12_17 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u6/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u6/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u6/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u6/wp_reg_n_0_[1] ,\u6/wp_reg_n_0_[0] }),
        .DIA(wb_din[13:12]),
        .DIB(wb_din[15:14]),
        .DIC(wb_din[17:16]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__2[13:12]),
        .DOB(dout_tmp__2[15:14]),
        .DOC(dout_tmp__2[17:16]),
        .WCLK(clk_i),
        .WE(o7_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u6/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "23" *) 
  RAM32M \u6/mem_reg_0_3_18_23 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u6/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u6/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u6/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u6/wp_reg_n_0_[1] ,\u6/wp_reg_n_0_[0] }),
        .DIA(wb_din[19:18]),
        .DIB(wb_din[21:20]),
        .DIC(wb_din[23:22]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__2[19:18]),
        .DOB(dout_tmp__2[21:20]),
        .DOC(dout_tmp__2[23:22]),
        .WCLK(clk_i),
        .WE(o7_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u6/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "29" *) 
  RAM32M \u6/mem_reg_0_3_24_29 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u6/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u6/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u6/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u6/wp_reg_n_0_[1] ,\u6/wp_reg_n_0_[0] }),
        .DIA(wb_din[25:24]),
        .DIB(wb_din[27:26]),
        .DIC(wb_din[29:28]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__2[25:24]),
        .DOB(dout_tmp__2[27:26]),
        .DOC(dout_tmp__2[29:28]),
        .WCLK(clk_i),
        .WE(o7_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u6/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u6/mem_reg_0_3_30_31 
       (.A0(\u6/wp_reg_n_0_[0] ),
        .A1(\u6/wp_reg_n_0_[1] ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(wb_din[30]),
        .DPO(dout_tmp__2[30]),
        .DPRA0(\u6/p_0_in [0]),
        .DPRA1(\u6/p_0_in [1]),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(o7_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u6/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u6/mem_reg_0_3_30_31__0 
       (.A0(\u6/wp_reg_n_0_[0] ),
        .A1(\u6/wp_reg_n_0_[1] ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(wb_din[31]),
        .DPO(dout_tmp__2[31]),
        .DPRA0(\u6/p_0_in [0]),
        .DPRA1(\u6/p_0_in [1]),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(o7_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u6/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "11" *) 
  RAM32M \u6/mem_reg_0_3_6_11 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u6/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u6/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u6/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u6/wp_reg_n_0_[1] ,\u6/wp_reg_n_0_[0] }),
        .DIA(wb_din[7:6]),
        .DIB(wb_din[9:8]),
        .DIC(wb_din[11:10]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__2[7:6]),
        .DOB(dout_tmp__2[9:8]),
        .DOC(dout_tmp__2[11:10]),
        .WCLK(clk_i),
        .WE(o7_we));
  FDRE \u6/rp_reg[0] 
       (.C(clk_i),
        .CE(o7_re),
        .D(\rp[0]_i_1__5_n_0 ),
        .Q(\u6/rp_reg_n_0_[0] ),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/rp_reg[1] 
       (.C(clk_i),
        .CE(o7_re),
        .D(p_0_in__5[1]),
        .Q(\u6/p_0_in [0]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/rp_reg[2] 
       (.C(clk_i),
        .CE(o7_re),
        .D(p_0_in__5[2]),
        .Q(\u6/p_0_in [1]),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/rp_reg[3] 
       (.C(clk_i),
        .CE(o7_re),
        .D(p_0_in__5[3]),
        .Q(\u6/rp_reg_n_0_[3] ),
        .R(\dout[19]_i_1__2_n_0 ));
  FDRE \u6/status_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\status[0]_i_1__2_n_0 ),
        .Q(o7_status[0]),
        .R(\<const0> ));
  FDRE \u6/status_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u6/status0 ),
        .Q(o7_status[1]),
        .R(\<const0> ));
  FDRE \u6/wp_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[0]_i_1__2_n_0 ),
        .Q(\u6/wp_reg_n_0_[0] ),
        .R(\<const0> ));
  FDRE \u6/wp_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[1]_i_1__2_n_0 ),
        .Q(\u6/wp_reg_n_0_[1] ),
        .R(\<const0> ));
  FDRE \u6/wp_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[2]_i_1__2_n_0 ),
        .Q(\u6/p_1_in ),
        .R(\<const0> ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \u7/dout[0]_i_1 
       (.I0(o8_mode[1]),
        .I1(dout_tmp__3[0]),
        .O(\u7/dout[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u7/dout[10]_i_1 
       (.I0(dout_tmp__3[10]),
        .I1(o8_mode[1]),
        .I2(\u7/dout[10]_i_2_n_0 ),
        .O(\u7/dout[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u7/dout[10]_i_2 
       (.I0(dout_tmp__3[8]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[22]),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(dout_tmp__3[6]),
        .O(\u7/dout[10]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u7/dout[11]_i_1 
       (.I0(dout_tmp__3[11]),
        .I1(o8_mode[1]),
        .I2(\u7/dout[11]_i_2_n_0 ),
        .O(\u7/dout[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u7/dout[11]_i_2 
       (.I0(dout_tmp__3[9]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[23]),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(dout_tmp__3[7]),
        .O(\u7/dout[11]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u7/dout[12]_i_1 
       (.I0(dout_tmp__3[12]),
        .I1(o8_mode[1]),
        .I2(\u7/dout[12]_i_2_n_0 ),
        .O(\u7/dout[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u7/dout[12]_i_2 
       (.I0(dout_tmp__3[10]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[24]),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(dout_tmp__3[8]),
        .O(\u7/dout[12]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u7/dout[13]_i_1 
       (.I0(dout_tmp__3[13]),
        .I1(o8_mode[1]),
        .I2(\u7/dout[13]_i_2_n_0 ),
        .O(\u7/dout[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u7/dout[13]_i_2 
       (.I0(dout_tmp__3[11]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[25]),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(dout_tmp__3[9]),
        .O(\u7/dout[13]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u7/dout[14]_i_1 
       (.I0(dout_tmp__3[14]),
        .I1(o8_mode[1]),
        .I2(\u7/dout[14]_i_2_n_0 ),
        .O(\u7/dout[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u7/dout[14]_i_2 
       (.I0(dout_tmp__3[12]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[26]),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(dout_tmp__3[10]),
        .O(\u7/dout[14]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u7/dout[15]_i_1 
       (.I0(dout_tmp__3[15]),
        .I1(o8_mode[1]),
        .I2(\u7/dout[15]_i_2_n_0 ),
        .O(\u7/dout[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u7/dout[15]_i_2 
       (.I0(dout_tmp__3[13]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[27]),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(dout_tmp__3[11]),
        .O(\u7/dout[15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u7/dout[16]_i_1 
       (.I0(dout_tmp__3[16]),
        .I1(o8_mode[1]),
        .I2(\u7/dout[16]_i_2_n_0 ),
        .O(\u7/dout[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u7/dout[16]_i_2 
       (.I0(dout_tmp__3[14]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[28]),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(dout_tmp__3[12]),
        .O(\u7/dout[16]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u7/dout[17]_i_1 
       (.I0(dout_tmp__3[17]),
        .I1(o8_mode[1]),
        .I2(\u7/dout[17]_i_2_n_0 ),
        .O(\u7/dout[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u7/dout[17]_i_2 
       (.I0(dout_tmp__3[15]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[29]),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(dout_tmp__3[13]),
        .O(\u7/dout[17]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u7/dout[18]_i_1 
       (.I0(dout_tmp__3[18]),
        .I1(o8_mode[1]),
        .I2(\u7/dout[18]_i_2_n_0 ),
        .O(\u7/dout[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u7/dout[18]_i_2 
       (.I0(dout_tmp__3[16]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[30]),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(dout_tmp__3[14]),
        .O(\u7/dout[18]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u7/dout[19]_i_3 
       (.I0(dout_tmp__3[19]),
        .I1(o8_mode[1]),
        .I2(\u7/dout[19]_i_4_n_0 ),
        .O(\u7/dout[19]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u7/dout[19]_i_4 
       (.I0(dout_tmp__3[17]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[31]),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(dout_tmp__3[15]),
        .O(\u7/dout[19]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \u7/dout[1]_i_1 
       (.I0(o8_mode[1]),
        .I1(dout_tmp__3[1]),
        .O(\u7/dout[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \u7/dout[2]_i_1 
       (.I0(dout_tmp__3[0]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[2]),
        .I3(o8_mode[1]),
        .O(\u7/dout[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \u7/dout[3]_i_1 
       (.I0(dout_tmp__3[1]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[3]),
        .I3(o8_mode[1]),
        .O(\u7/dout[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u7/dout[4]_i_1 
       (.I0(dout_tmp__3[4]),
        .I1(o8_mode[1]),
        .I2(\u7/dout[4]_i_2_n_0 ),
        .O(\u7/dout[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u7/dout[4]_i_2 
       (.I0(dout_tmp__3[2]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[16]),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(dout_tmp__3[0]),
        .O(\u7/dout[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u7/dout[5]_i_1 
       (.I0(dout_tmp__3[5]),
        .I1(o8_mode[1]),
        .I2(\u7/dout[5]_i_2_n_0 ),
        .O(\u7/dout[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u7/dout[5]_i_2 
       (.I0(dout_tmp__3[3]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[17]),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(dout_tmp__3[1]),
        .O(\u7/dout[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u7/dout[6]_i_1 
       (.I0(dout_tmp__3[6]),
        .I1(o8_mode[1]),
        .I2(\u7/dout[6]_i_2_n_0 ),
        .O(\u7/dout[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u7/dout[6]_i_2 
       (.I0(dout_tmp__3[4]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[18]),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(dout_tmp__3[2]),
        .O(\u7/dout[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u7/dout[7]_i_1 
       (.I0(dout_tmp__3[7]),
        .I1(o8_mode[1]),
        .I2(\u7/dout[7]_i_2_n_0 ),
        .O(\u7/dout[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u7/dout[7]_i_2 
       (.I0(dout_tmp__3[5]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[19]),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(dout_tmp__3[3]),
        .O(\u7/dout[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u7/dout[8]_i_1 
       (.I0(dout_tmp__3[8]),
        .I1(o8_mode[1]),
        .I2(\u7/dout[8]_i_2_n_0 ),
        .O(\u7/dout[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u7/dout[8]_i_2 
       (.I0(dout_tmp__3[6]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[20]),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(dout_tmp__3[4]),
        .O(\u7/dout[8]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u7/dout[9]_i_1 
       (.I0(dout_tmp__3[9]),
        .I1(o8_mode[1]),
        .I2(\u7/dout[9]_i_2_n_0 ),
        .O(\u7/dout[9]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u7/dout[9]_i_2 
       (.I0(dout_tmp__3[7]),
        .I1(o8_mode[0]),
        .I2(dout_tmp__3[21]),
        .I3(\u7/rp_reg_n_0_[0] ),
        .I4(dout_tmp__3[5]),
        .O(\u7/dout[9]_i_2_n_0 ));
  FDRE \u7/dout_reg[0] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[0]_i_1_n_0 ),
        .Q(out_slt8[0]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[10] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[10]_i_1_n_0 ),
        .Q(out_slt8[10]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[11] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[11]_i_1_n_0 ),
        .Q(out_slt8[11]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[12] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[12]_i_1_n_0 ),
        .Q(out_slt8[12]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[13] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[13]_i_1_n_0 ),
        .Q(out_slt8[13]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[14] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[14]_i_1_n_0 ),
        .Q(out_slt8[14]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[15] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[15]_i_1_n_0 ),
        .Q(out_slt8[15]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[16] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[16]_i_1_n_0 ),
        .Q(out_slt8[16]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[17] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[17]_i_1_n_0 ),
        .Q(out_slt8[17]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[18] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[18]_i_1_n_0 ),
        .Q(out_slt8[18]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[19] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[19]_i_3_n_0 ),
        .Q(out_slt8[19]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[1] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[1]_i_1_n_0 ),
        .Q(out_slt8[1]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[2] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[2]_i_1_n_0 ),
        .Q(out_slt8[2]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[3] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[3]_i_1_n_0 ),
        .Q(out_slt8[3]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[4] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[4]_i_1_n_0 ),
        .Q(out_slt8[4]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[5] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[5]_i_1_n_0 ),
        .Q(out_slt8[5]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[6] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[6]_i_1_n_0 ),
        .Q(out_slt8[6]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[7] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[7]_i_1_n_0 ),
        .Q(out_slt8[7]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[8] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[8]_i_1_n_0 ),
        .Q(out_slt8[8]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/dout_reg[9] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\u7/dout[9]_i_1_n_0 ),
        .Q(out_slt8[9]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/empty_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u7/empty0 ),
        .Q(o8_empty),
        .R(\<const0> ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u7/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "5" *) 
  RAM32M \u7/mem_reg_0_3_0_5 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u7/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u7/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u7/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u7/wp_reg_n_0_[1] ,\u7/wp_reg_n_0_[0] }),
        .DIA(wb_din[1:0]),
        .DIB(wb_din[3:2]),
        .DIC(wb_din[5:4]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__3[1:0]),
        .DOB(dout_tmp__3[3:2]),
        .DOC(dout_tmp__3[5:4]),
        .WCLK(clk_i),
        .WE(o8_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u7/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "17" *) 
  RAM32M \u7/mem_reg_0_3_12_17 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u7/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u7/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u7/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u7/wp_reg_n_0_[1] ,\u7/wp_reg_n_0_[0] }),
        .DIA(wb_din[13:12]),
        .DIB(wb_din[15:14]),
        .DIC(wb_din[17:16]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__3[13:12]),
        .DOB(dout_tmp__3[15:14]),
        .DOC(dout_tmp__3[17:16]),
        .WCLK(clk_i),
        .WE(o8_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u7/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "23" *) 
  RAM32M \u7/mem_reg_0_3_18_23 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u7/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u7/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u7/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u7/wp_reg_n_0_[1] ,\u7/wp_reg_n_0_[0] }),
        .DIA(wb_din[19:18]),
        .DIB(wb_din[21:20]),
        .DIC(wb_din[23:22]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__3[19:18]),
        .DOB(dout_tmp__3[21:20]),
        .DOC(dout_tmp__3[23:22]),
        .WCLK(clk_i),
        .WE(o8_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u7/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "29" *) 
  RAM32M \u7/mem_reg_0_3_24_29 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u7/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u7/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u7/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u7/wp_reg_n_0_[1] ,\u7/wp_reg_n_0_[0] }),
        .DIA(wb_din[25:24]),
        .DIB(wb_din[27:26]),
        .DIC(wb_din[29:28]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__3[25:24]),
        .DOB(dout_tmp__3[27:26]),
        .DOC(dout_tmp__3[29:28]),
        .WCLK(clk_i),
        .WE(o8_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u7/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u7/mem_reg_0_3_30_31 
       (.A0(\u7/wp_reg_n_0_[0] ),
        .A1(\u7/wp_reg_n_0_[1] ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(wb_din[30]),
        .DPO(dout_tmp__3[30]),
        .DPRA0(\u7/p_0_in [0]),
        .DPRA1(\u7/p_0_in [1]),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(o8_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u7/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u7/mem_reg_0_3_30_31__0 
       (.A0(\u7/wp_reg_n_0_[0] ),
        .A1(\u7/wp_reg_n_0_[1] ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(wb_din[31]),
        .DPO(dout_tmp__3[31]),
        .DPRA0(\u7/p_0_in [0]),
        .DPRA1(\u7/p_0_in [1]),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(o8_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u7/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "11" *) 
  RAM32M \u7/mem_reg_0_3_6_11 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u7/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u7/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u7/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u7/wp_reg_n_0_[1] ,\u7/wp_reg_n_0_[0] }),
        .DIA(wb_din[7:6]),
        .DIB(wb_din[9:8]),
        .DIC(wb_din[11:10]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__3[7:6]),
        .DOB(dout_tmp__3[9:8]),
        .DOC(dout_tmp__3[11:10]),
        .WCLK(clk_i),
        .WE(o8_we));
  FDRE \u7/rp_reg[0] 
       (.C(clk_i),
        .CE(o8_re),
        .D(\rp[0]_i_1__6_n_0 ),
        .Q(\u7/rp_reg_n_0_[0] ),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/rp_reg[1] 
       (.C(clk_i),
        .CE(o8_re),
        .D(p_0_in__6[1]),
        .Q(\u7/p_0_in [0]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/rp_reg[2] 
       (.C(clk_i),
        .CE(o8_re),
        .D(p_0_in__6[2]),
        .Q(\u7/p_0_in [1]),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/rp_reg[3] 
       (.C(clk_i),
        .CE(o8_re),
        .D(p_0_in__6[3]),
        .Q(\u7/rp_reg_n_0_[3] ),
        .R(\dout[19]_i_1__3_n_0 ));
  FDRE \u7/status_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\status[0]_i_1__3_n_0 ),
        .Q(o8_status[0]),
        .R(\<const0> ));
  FDRE \u7/status_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u7/status0 ),
        .Q(o8_status[1]),
        .R(\<const0> ));
  FDRE \u7/wp_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[0]_i_1__3_n_0 ),
        .Q(\u7/wp_reg_n_0_[0] ),
        .R(\<const0> ));
  FDRE \u7/wp_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[1]_i_1__3_n_0 ),
        .Q(\u7/wp_reg_n_0_[1] ),
        .R(\<const0> ));
  FDRE \u7/wp_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[2]_i_1__3_n_0 ),
        .Q(\u7/p_1_in ),
        .R(\<const0> ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \u8/dout[0]_i_1 
       (.I0(o9_mode[1]),
        .I1(dout_tmp__4[0]),
        .O(\u8/dout[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u8/dout[10]_i_1 
       (.I0(dout_tmp__4[10]),
        .I1(o9_mode[1]),
        .I2(\u8/dout[10]_i_2_n_0 ),
        .O(\u8/dout[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u8/dout[10]_i_2 
       (.I0(dout_tmp__4[8]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[22]),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(dout_tmp__4[6]),
        .O(\u8/dout[10]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u8/dout[11]_i_1 
       (.I0(dout_tmp__4[11]),
        .I1(o9_mode[1]),
        .I2(\u8/dout[11]_i_2_n_0 ),
        .O(\u8/dout[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u8/dout[11]_i_2 
       (.I0(dout_tmp__4[9]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[23]),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(dout_tmp__4[7]),
        .O(\u8/dout[11]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u8/dout[12]_i_1 
       (.I0(dout_tmp__4[12]),
        .I1(o9_mode[1]),
        .I2(\u8/dout[12]_i_2_n_0 ),
        .O(\u8/dout[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u8/dout[12]_i_2 
       (.I0(dout_tmp__4[10]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[24]),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(dout_tmp__4[8]),
        .O(\u8/dout[12]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u8/dout[13]_i_1 
       (.I0(dout_tmp__4[13]),
        .I1(o9_mode[1]),
        .I2(\u8/dout[13]_i_2_n_0 ),
        .O(\u8/dout[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u8/dout[13]_i_2 
       (.I0(dout_tmp__4[11]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[25]),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(dout_tmp__4[9]),
        .O(\u8/dout[13]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u8/dout[14]_i_1 
       (.I0(dout_tmp__4[14]),
        .I1(o9_mode[1]),
        .I2(\u8/dout[14]_i_2_n_0 ),
        .O(\u8/dout[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u8/dout[14]_i_2 
       (.I0(dout_tmp__4[12]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[26]),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(dout_tmp__4[10]),
        .O(\u8/dout[14]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u8/dout[15]_i_1 
       (.I0(dout_tmp__4[15]),
        .I1(o9_mode[1]),
        .I2(\u8/dout[15]_i_2_n_0 ),
        .O(\u8/dout[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u8/dout[15]_i_2 
       (.I0(dout_tmp__4[13]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[27]),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(dout_tmp__4[11]),
        .O(\u8/dout[15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u8/dout[16]_i_1 
       (.I0(dout_tmp__4[16]),
        .I1(o9_mode[1]),
        .I2(\u8/dout[16]_i_2_n_0 ),
        .O(\u8/dout[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u8/dout[16]_i_2 
       (.I0(dout_tmp__4[14]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[28]),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(dout_tmp__4[12]),
        .O(\u8/dout[16]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u8/dout[17]_i_1 
       (.I0(dout_tmp__4[17]),
        .I1(o9_mode[1]),
        .I2(\u8/dout[17]_i_2_n_0 ),
        .O(\u8/dout[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u8/dout[17]_i_2 
       (.I0(dout_tmp__4[15]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[29]),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(dout_tmp__4[13]),
        .O(\u8/dout[17]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u8/dout[18]_i_1 
       (.I0(dout_tmp__4[18]),
        .I1(o9_mode[1]),
        .I2(\u8/dout[18]_i_2_n_0 ),
        .O(\u8/dout[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u8/dout[18]_i_2 
       (.I0(dout_tmp__4[16]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[30]),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(dout_tmp__4[14]),
        .O(\u8/dout[18]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u8/dout[19]_i_3 
       (.I0(dout_tmp__4[19]),
        .I1(o9_mode[1]),
        .I2(\u8/dout[19]_i_4_n_0 ),
        .O(\u8/dout[19]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u8/dout[19]_i_4 
       (.I0(dout_tmp__4[17]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[31]),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(dout_tmp__4[15]),
        .O(\u8/dout[19]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \u8/dout[1]_i_1 
       (.I0(o9_mode[1]),
        .I1(dout_tmp__4[1]),
        .O(\u8/dout[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \u8/dout[2]_i_1 
       (.I0(dout_tmp__4[0]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[2]),
        .I3(o9_mode[1]),
        .O(\u8/dout[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \u8/dout[3]_i_1 
       (.I0(dout_tmp__4[1]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[3]),
        .I3(o9_mode[1]),
        .O(\u8/dout[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u8/dout[4]_i_1 
       (.I0(dout_tmp__4[4]),
        .I1(o9_mode[1]),
        .I2(\u8/dout[4]_i_2_n_0 ),
        .O(\u8/dout[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u8/dout[4]_i_2 
       (.I0(dout_tmp__4[2]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[16]),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(dout_tmp__4[0]),
        .O(\u8/dout[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u8/dout[5]_i_1 
       (.I0(dout_tmp__4[5]),
        .I1(o9_mode[1]),
        .I2(\u8/dout[5]_i_2_n_0 ),
        .O(\u8/dout[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u8/dout[5]_i_2 
       (.I0(dout_tmp__4[3]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[17]),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(dout_tmp__4[1]),
        .O(\u8/dout[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u8/dout[6]_i_1 
       (.I0(dout_tmp__4[6]),
        .I1(o9_mode[1]),
        .I2(\u8/dout[6]_i_2_n_0 ),
        .O(\u8/dout[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u8/dout[6]_i_2 
       (.I0(dout_tmp__4[4]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[18]),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(dout_tmp__4[2]),
        .O(\u8/dout[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u8/dout[7]_i_1 
       (.I0(dout_tmp__4[7]),
        .I1(o9_mode[1]),
        .I2(\u8/dout[7]_i_2_n_0 ),
        .O(\u8/dout[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u8/dout[7]_i_2 
       (.I0(dout_tmp__4[5]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[19]),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(dout_tmp__4[3]),
        .O(\u8/dout[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u8/dout[8]_i_1 
       (.I0(dout_tmp__4[8]),
        .I1(o9_mode[1]),
        .I2(\u8/dout[8]_i_2_n_0 ),
        .O(\u8/dout[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u8/dout[8]_i_2 
       (.I0(dout_tmp__4[6]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[20]),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(dout_tmp__4[4]),
        .O(\u8/dout[8]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \u8/dout[9]_i_1 
       (.I0(dout_tmp__4[9]),
        .I1(o9_mode[1]),
        .I2(\u8/dout[9]_i_2_n_0 ),
        .O(\u8/dout[9]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \u8/dout[9]_i_2 
       (.I0(dout_tmp__4[7]),
        .I1(o9_mode[0]),
        .I2(dout_tmp__4[21]),
        .I3(\u8/rp_reg_n_0_[0] ),
        .I4(dout_tmp__4[5]),
        .O(\u8/dout[9]_i_2_n_0 ));
  FDRE \u8/dout_reg[0] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[0]_i_1_n_0 ),
        .Q(out_slt9[0]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[10] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[10]_i_1_n_0 ),
        .Q(out_slt9[10]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[11] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[11]_i_1_n_0 ),
        .Q(out_slt9[11]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[12] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[12]_i_1_n_0 ),
        .Q(out_slt9[12]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[13] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[13]_i_1_n_0 ),
        .Q(out_slt9[13]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[14] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[14]_i_1_n_0 ),
        .Q(out_slt9[14]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[15] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[15]_i_1_n_0 ),
        .Q(out_slt9[15]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[16] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[16]_i_1_n_0 ),
        .Q(out_slt9[16]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[17] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[17]_i_1_n_0 ),
        .Q(out_slt9[17]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[18] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[18]_i_1_n_0 ),
        .Q(out_slt9[18]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[19] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[19]_i_3_n_0 ),
        .Q(out_slt9[19]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[1] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[1]_i_1_n_0 ),
        .Q(out_slt9[1]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[2] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[2]_i_1_n_0 ),
        .Q(out_slt9[2]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[3] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[3]_i_1_n_0 ),
        .Q(out_slt9[3]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[4] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[4]_i_1_n_0 ),
        .Q(out_slt9[4]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[5] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[5]_i_1_n_0 ),
        .Q(out_slt9[5]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[6] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[6]_i_1_n_0 ),
        .Q(out_slt9[6]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[7] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[7]_i_1_n_0 ),
        .Q(out_slt9[7]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[8] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[8]_i_1_n_0 ),
        .Q(out_slt9[8]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/dout_reg[9] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\u8/dout[9]_i_1_n_0 ),
        .Q(out_slt9[9]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/empty_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u8/empty0 ),
        .Q(o9_empty),
        .R(\<const0> ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u8/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "5" *) 
  RAM32M \u8/mem_reg_0_3_0_5 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u8/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u8/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u8/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u8/wp_reg_n_0_[1] ,\u8/wp_reg_n_0_[0] }),
        .DIA(wb_din[1:0]),
        .DIB(wb_din[3:2]),
        .DIC(wb_din[5:4]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__4[1:0]),
        .DOB(dout_tmp__4[3:2]),
        .DOC(dout_tmp__4[5:4]),
        .WCLK(clk_i),
        .WE(o9_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u8/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "17" *) 
  RAM32M \u8/mem_reg_0_3_12_17 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u8/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u8/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u8/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u8/wp_reg_n_0_[1] ,\u8/wp_reg_n_0_[0] }),
        .DIA(wb_din[13:12]),
        .DIB(wb_din[15:14]),
        .DIC(wb_din[17:16]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__4[13:12]),
        .DOB(dout_tmp__4[15:14]),
        .DOC(dout_tmp__4[17:16]),
        .WCLK(clk_i),
        .WE(o9_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u8/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "23" *) 
  RAM32M \u8/mem_reg_0_3_18_23 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u8/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u8/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u8/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u8/wp_reg_n_0_[1] ,\u8/wp_reg_n_0_[0] }),
        .DIA(wb_din[19:18]),
        .DIB(wb_din[21:20]),
        .DIC(wb_din[23:22]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__4[19:18]),
        .DOB(dout_tmp__4[21:20]),
        .DOC(dout_tmp__4[23:22]),
        .WCLK(clk_i),
        .WE(o9_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u8/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "29" *) 
  RAM32M \u8/mem_reg_0_3_24_29 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u8/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u8/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u8/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u8/wp_reg_n_0_[1] ,\u8/wp_reg_n_0_[0] }),
        .DIA(wb_din[25:24]),
        .DIB(wb_din[27:26]),
        .DIC(wb_din[29:28]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__4[25:24]),
        .DOB(dout_tmp__4[27:26]),
        .DOC(dout_tmp__4[29:28]),
        .WCLK(clk_i),
        .WE(o9_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u8/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u8/mem_reg_0_3_30_31 
       (.A0(\u8/wp_reg_n_0_[0] ),
        .A1(\u8/wp_reg_n_0_[1] ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(wb_din[30]),
        .DPO(dout_tmp__4[30]),
        .DPRA0(\u8/p_0_in [0]),
        .DPRA1(\u8/p_0_in [1]),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(o9_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u8/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u8/mem_reg_0_3_30_31__0 
       (.A0(\u8/wp_reg_n_0_[0] ),
        .A1(\u8/wp_reg_n_0_[1] ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(wb_din[31]),
        .DPO(dout_tmp__4[31]),
        .DPRA0(\u8/p_0_in [0]),
        .DPRA1(\u8/p_0_in [1]),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(o9_we));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u8/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "11" *) 
  RAM32M \u8/mem_reg_0_3_6_11 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u8/p_0_in }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u8/p_0_in }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u8/p_0_in }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u8/wp_reg_n_0_[1] ,\u8/wp_reg_n_0_[0] }),
        .DIA(wb_din[7:6]),
        .DIB(wb_din[9:8]),
        .DIC(wb_din[11:10]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout_tmp__4[7:6]),
        .DOB(dout_tmp__4[9:8]),
        .DOC(dout_tmp__4[11:10]),
        .WCLK(clk_i),
        .WE(o9_we));
  FDRE \u8/rp_reg[0] 
       (.C(clk_i),
        .CE(o9_re),
        .D(\rp[0]_i_1__7_n_0 ),
        .Q(\u8/rp_reg_n_0_[0] ),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/rp_reg[1] 
       (.C(clk_i),
        .CE(o9_re),
        .D(p_0_in__7[1]),
        .Q(\u8/p_0_in [0]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/rp_reg[2] 
       (.C(clk_i),
        .CE(o9_re),
        .D(p_0_in__7[2]),
        .Q(\u8/p_0_in [1]),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/rp_reg[3] 
       (.C(clk_i),
        .CE(o9_re),
        .D(p_0_in__7[3]),
        .Q(\u8/rp_reg_n_0_[3] ),
        .R(\dout[19]_i_1__4_n_0 ));
  FDRE \u8/status_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\status[0]_i_1__4_n_0 ),
        .Q(o9_status[0]),
        .R(\<const0> ));
  FDRE \u8/status_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u8/status0 ),
        .Q(o9_status[1]),
        .R(\<const0> ));
  FDRE \u8/wp_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[0]_i_1__4_n_0 ),
        .Q(\u8/wp_reg_n_0_[0] ),
        .R(\<const0> ));
  FDRE \u8/wp_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[1]_i_1__4_n_0 ),
        .Q(\u8/wp_reg_n_0_[1] ),
        .R(\<const0> ));
  FDRE \u8/wp_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\wp[2]_i_1__4_n_0 ),
        .Q(\u8/p_1_in ),
        .R(\<const0> ));
  FDRE \u9/din_tmp1_reg[0] 
       (.C(clk_i),
        .CE(\u9/din_tmp10 ),
        .D(in_slt3[4]),
        .Q(\u9/din_tmp1 [0]),
        .R(\<const0> ));
  FDRE \u9/din_tmp1_reg[10] 
       (.C(clk_i),
        .CE(\u9/din_tmp10 ),
        .D(in_slt3[14]),
        .Q(\u9/din_tmp1 [10]),
        .R(\<const0> ));
  FDRE \u9/din_tmp1_reg[11] 
       (.C(clk_i),
        .CE(\u9/din_tmp10 ),
        .D(in_slt3[15]),
        .Q(\u9/din_tmp1 [11]),
        .R(\<const0> ));
  FDRE \u9/din_tmp1_reg[12] 
       (.C(clk_i),
        .CE(\u9/din_tmp10 ),
        .D(in_slt3[16]),
        .Q(\u9/din_tmp1 [12]),
        .R(\<const0> ));
  FDRE \u9/din_tmp1_reg[13] 
       (.C(clk_i),
        .CE(\u9/din_tmp10 ),
        .D(in_slt3[17]),
        .Q(\u9/din_tmp1 [13]),
        .R(\<const0> ));
  FDRE \u9/din_tmp1_reg[14] 
       (.C(clk_i),
        .CE(\u9/din_tmp10 ),
        .D(in_slt3[18]),
        .Q(\u9/din_tmp1 [14]),
        .R(\<const0> ));
  FDRE \u9/din_tmp1_reg[15] 
       (.C(clk_i),
        .CE(\u9/din_tmp10 ),
        .D(in_slt3[19]),
        .Q(\u9/din_tmp1 [15]),
        .R(\<const0> ));
  FDRE \u9/din_tmp1_reg[1] 
       (.C(clk_i),
        .CE(\u9/din_tmp10 ),
        .D(in_slt3[5]),
        .Q(\u9/din_tmp1 [1]),
        .R(\<const0> ));
  FDRE \u9/din_tmp1_reg[2] 
       (.C(clk_i),
        .CE(\u9/din_tmp10 ),
        .D(in_slt3[6]),
        .Q(\u9/din_tmp1 [2]),
        .R(\<const0> ));
  FDRE \u9/din_tmp1_reg[3] 
       (.C(clk_i),
        .CE(\u9/din_tmp10 ),
        .D(in_slt3[7]),
        .Q(\u9/din_tmp1 [3]),
        .R(\<const0> ));
  FDRE \u9/din_tmp1_reg[4] 
       (.C(clk_i),
        .CE(\u9/din_tmp10 ),
        .D(in_slt3[8]),
        .Q(\u9/din_tmp1 [4]),
        .R(\<const0> ));
  FDRE \u9/din_tmp1_reg[5] 
       (.C(clk_i),
        .CE(\u9/din_tmp10 ),
        .D(in_slt3[9]),
        .Q(\u9/din_tmp1 [5]),
        .R(\<const0> ));
  FDRE \u9/din_tmp1_reg[6] 
       (.C(clk_i),
        .CE(\u9/din_tmp10 ),
        .D(in_slt3[10]),
        .Q(\u9/din_tmp1 [6]),
        .R(\<const0> ));
  FDRE \u9/din_tmp1_reg[7] 
       (.C(clk_i),
        .CE(\u9/din_tmp10 ),
        .D(in_slt3[11]),
        .Q(\u9/din_tmp1 [7]),
        .R(\<const0> ));
  FDRE \u9/din_tmp1_reg[8] 
       (.C(clk_i),
        .CE(\u9/din_tmp10 ),
        .D(in_slt3[12]),
        .Q(\u9/din_tmp1 [8]),
        .R(\<const0> ));
  FDRE \u9/din_tmp1_reg[9] 
       (.C(clk_i),
        .CE(\u9/din_tmp10 ),
        .D(in_slt3[13]),
        .Q(\u9/din_tmp1 [9]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[0]),
        .Q(i3_dout[0]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[10] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[10]),
        .Q(i3_dout[10]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[11] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[11]),
        .Q(i3_dout[11]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[12] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[12]),
        .Q(i3_dout[12]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[13] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[13]),
        .Q(i3_dout[13]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[14] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[14]),
        .Q(i3_dout[14]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[15] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[15]),
        .Q(i3_dout[15]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[16] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[16]),
        .Q(i3_dout[16]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[17] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[17]),
        .Q(i3_dout[17]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[18] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[18]),
        .Q(i3_dout[18]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[19] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[19]),
        .Q(i3_dout[19]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[1]),
        .Q(i3_dout[1]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[20] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[20]),
        .Q(i3_dout[20]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[21] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[21]),
        .Q(i3_dout[21]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[22] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[22]),
        .Q(i3_dout[22]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[23] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[23]),
        .Q(i3_dout[23]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[24] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[24]),
        .Q(i3_dout[24]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[25] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[25]),
        .Q(i3_dout[25]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[26] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[26]),
        .Q(i3_dout[26]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[27] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[27]),
        .Q(i3_dout[27]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[28] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[28]),
        .Q(i3_dout[28]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[29] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[29]),
        .Q(i3_dout[29]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[2]),
        .Q(i3_dout[2]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[30] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[30]),
        .Q(i3_dout[30]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[31] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[31]),
        .Q(i3_dout[31]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[3] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[3]),
        .Q(i3_dout[3]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[4] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[4]),
        .Q(i3_dout[4]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[5] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[5]),
        .Q(i3_dout[5]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[6] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[6]),
        .Q(i3_dout[6]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[7] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[7]),
        .Q(i3_dout[7]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[8] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[8]),
        .Q(i3_dout[8]),
        .R(\<const0> ));
  FDRE \u9/dout_reg[9] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(dout0[9]),
        .Q(i3_dout[9]),
        .R(\<const0> ));
  FDRE \u9/empty_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u9/empty0 ),
        .Q(i3_empty),
        .R(\<const0> ));
  FDRE \u9/full_reg 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u9/full0 ),
        .Q(i3_full),
        .R(\<const0> ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u9/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "5" *) 
  RAM32M \u9/mem_reg_0_3_0_5 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u9/rp_reg_n_0_[1] ,\u9/rp_reg_n_0_[0] }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u9/rp_reg_n_0_[1] ,\u9/rp_reg_n_0_[0] }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u9/rp_reg_n_0_[1] ,\u9/rp_reg_n_0_[0] }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u9/p_1_in }),
        .DIA(\u9/din_tmp [1:0]),
        .DIB(\u9/din_tmp [3:2]),
        .DIC(\u9/din_tmp [5:4]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout0[1:0]),
        .DOB(dout0[3:2]),
        .DOC(dout0[5:4]),
        .WCLK(clk_i),
        .WE(p_0_in__0));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u9/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "17" *) 
  RAM32M \u9/mem_reg_0_3_12_17 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u9/rp_reg_n_0_[1] ,\u9/rp_reg_n_0_[0] }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u9/rp_reg_n_0_[1] ,\u9/rp_reg_n_0_[0] }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u9/rp_reg_n_0_[1] ,\u9/rp_reg_n_0_[0] }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u9/p_1_in }),
        .DIA(\u9/din_tmp [13:12]),
        .DIB(\u9/din_tmp [15:14]),
        .DIC(\u9/din_tmp [17:16]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout0[13:12]),
        .DOB(dout0[15:14]),
        .DOC(dout0[17:16]),
        .WCLK(clk_i),
        .WE(p_0_in__0));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u9/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "23" *) 
  RAM32M \u9/mem_reg_0_3_18_23 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u9/rp_reg_n_0_[1] ,\u9/rp_reg_n_0_[0] }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u9/rp_reg_n_0_[1] ,\u9/rp_reg_n_0_[0] }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u9/rp_reg_n_0_[1] ,\u9/rp_reg_n_0_[0] }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u9/p_1_in }),
        .DIA(\u9/din_tmp [19:18]),
        .DIB(\u9/din_tmp [21:20]),
        .DIC(\u9/din_tmp [23:22]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout0[19:18]),
        .DOB(dout0[21:20]),
        .DOC(dout0[23:22]),
        .WCLK(clk_i),
        .WE(p_0_in__0));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u9/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "29" *) 
  RAM32M \u9/mem_reg_0_3_24_29 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u9/rp_reg_n_0_[1] ,\u9/rp_reg_n_0_[0] }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u9/rp_reg_n_0_[1] ,\u9/rp_reg_n_0_[0] }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u9/rp_reg_n_0_[1] ,\u9/rp_reg_n_0_[0] }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u9/p_1_in }),
        .DIA(\u9/din_tmp [25:24]),
        .DIB(\u9/din_tmp [27:26]),
        .DIC(\u9/din_tmp [29:28]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout0[25:24]),
        .DOB(dout0[27:26]),
        .DOC(dout0[29:28]),
        .WCLK(clk_i),
        .WE(p_0_in__0));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u9/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u9/mem_reg_0_3_30_31 
       (.A0(\u9/p_1_in [0]),
        .A1(\u9/p_1_in [1]),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(\u9/din_tmp [30]),
        .DPO(dout0[30]),
        .DPRA0(\u9/rp_reg_n_0_[0] ),
        .DPRA1(\u9/rp_reg_n_0_[1] ),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(p_0_in__0));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u9/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM32X1D \u9/mem_reg_0_3_30_31__0 
       (.A0(\u9/p_1_in [0]),
        .A1(\u9/p_1_in [1]),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .D(\u9/din_tmp [31]),
        .DPO(dout0[31]),
        .DPRA0(\u9/rp_reg_n_0_[0] ),
        .DPRA1(\u9/rp_reg_n_0_[1] ),
        .DPRA2(\<const0> ),
        .DPRA3(\<const0> ),
        .DPRA4(\<const0> ),
        .WCLK(clk_i),
        .WE(p_0_in__0));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "u9/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "11" *) 
  RAM32M \u9/mem_reg_0_3_6_11 
       (.ADDRA({\<const0> ,\<const0> ,\<const0> ,\u9/rp_reg_n_0_[1] ,\u9/rp_reg_n_0_[0] }),
        .ADDRB({\<const0> ,\<const0> ,\<const0> ,\u9/rp_reg_n_0_[1] ,\u9/rp_reg_n_0_[0] }),
        .ADDRC({\<const0> ,\<const0> ,\<const0> ,\u9/rp_reg_n_0_[1] ,\u9/rp_reg_n_0_[0] }),
        .ADDRD({\<const0> ,\<const0> ,\<const0> ,\u9/p_1_in }),
        .DIA(\u9/din_tmp [7:6]),
        .DIB(\u9/din_tmp [9:8]),
        .DIC(\u9/din_tmp [11:10]),
        .DID({\<const0> ,\<const0> }),
        .DOA(dout0[7:6]),
        .DOB(dout0[9:8]),
        .DOC(dout0[11:10]),
        .WCLK(clk_i),
        .WE(p_0_in__0));
  FDRE \u9/rp_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\rp[0]_i_1_n_0 ),
        .Q(\u9/rp_reg_n_0_[0] ),
        .R(\<const0> ));
  FDRE \u9/rp_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\rp[1]_i_1_n_0 ),
        .Q(\u9/rp_reg_n_0_[1] ),
        .R(\<const0> ));
  FDRE \u9/rp_reg[2] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\rp[2]_i_1_n_0 ),
        .Q(\u9/rp_reg_n_0_[2] ),
        .R(\<const0> ));
  FDRE \u9/status_reg[0] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\status[0]_i_1__7_n_0 ),
        .Q(i3_status[0]),
        .R(\<const0> ));
  FDRE \u9/status_reg[1] 
       (.C(clk_i),
        .CE(\<const1> ),
        .D(\u9/status0 ),
        .Q(i3_status[1]),
        .R(\<const0> ));
  FDRE \u9/wp_reg[0] 
       (.C(clk_i),
        .CE(i3_we),
        .D(\wp[0]_i_1__5_n_0 ),
        .Q(\u9/wp_reg_n_0_[0] ),
        .R(\wp[3]_i_1_n_0 ));
  FDRE \u9/wp_reg[1] 
       (.C(clk_i),
        .CE(i3_we),
        .D(wp_p1[1]),
        .Q(\u9/p_1_in [0]),
        .R(\wp[3]_i_1_n_0 ));
  FDRE \u9/wp_reg[2] 
       (.C(clk_i),
        .CE(i3_we),
        .D(wp_p1[2]),
        .Q(\u9/p_1_in [1]),
        .R(\wp[3]_i_1_n_0 ));
  FDRE \u9/wp_reg[3] 
       (.C(clk_i),
        .CE(i3_we),
        .D(wp_p1[3]),
        .Q(\u9/wp_reg_n_0_[3] ),
        .R(\wp[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE0000000)) 
    valid_i_1
       (.I0(\u2/cnt_reg [1]),
        .I1(\u2/cnt_reg [2]),
        .I2(\u2/cnt_reg [5]),
        .I3(\u2/cnt_reg [4]),
        .I4(\u2/cnt_reg [3]),
        .I5(\out_le[1]_i_2_n_0 ),
        .O(valid_i_1_n_0));
  FDRE valid_s1_reg
       (.C(clk_i),
        .CE(\<const1> ),
        .D(valid),
        .Q(valid_s1),
        .R(\<const0> ));
  FDRE valid_s_reg
       (.C(clk_i),
        .CE(\<const1> ),
        .D(valid_s1),
        .Q(valid_s),
        .R(\<const0> ));
  (* SOFT_HLUTNM = "soft_lutpair136" *) 
  LUT3 #(
    .INIT(8'h23)) 
    wb_ack_o_i_1
       (.I0(wb_ack_o_i_2_n_0),
        .I1(wb_ack_o),
        .I2(wb_ack_o_i_3_n_0),
        .O(\u12/wb_ack_o0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT5 #(
    .INIT(32'h00008000)) 
    wb_ack_o_i_2
       (.I0(wb_cyc_i),
        .I1(wb_stb_i),
        .I2(wb_we_i),
        .I3(\u12/we1 ),
        .I4(\u12/we2 ),
        .O(wb_ack_o_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT5 #(
    .INIT(32'hFFF7FFFF)) 
    wb_ack_o_i_3
       (.I0(wb_cyc_i),
        .I1(wb_stb_i),
        .I2(\u12/re2 ),
        .I3(wb_we_i),
        .I4(\u12/re1 ),
        .O(wb_ack_o_i_3_n_0));
  LUT5 #(
    .INIT(32'hFFFFFEEE)) 
    \wb_data_o[0]_i_1 
       (.I0(\wb_data_o[0]_i_2_n_0 ),
        .I1(\wb_data_o[0]_i_3_n_0 ),
        .I2(\u13/intm [0]),
        .I3(o9_we_i_1_n_0),
        .I4(\wb_data_o[0]_i_4_n_0 ),
        .O(\wb_data_o[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00F000AA00CC0000)) 
    \wb_data_o[0]_i_2 
       (.I0(\u13/occ0_r_reg_n_0_[0] ),
        .I1(\u13/occ1_r_reg_n_0_[0] ),
        .I2(\u13/icc_r_reg_n_0_[0] ),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF002000200020)) 
    \wb_data_o[0]_i_3 
       (.I0(crac_din[0]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[2]),
        .I4(\u13/ints [0]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[0]_i_4 
       (.I0(\wb_data_o[23]_i_3_n_0 ),
        .I1(i3_dout[0]),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[0]),
        .I4(i6_dout[0]),
        .I5(\wb_data_o[31]_i_3_n_0 ),
        .O(\wb_data_o[0]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEEE)) 
    \wb_data_o[10]_i_1 
       (.I0(\wb_data_o[10]_i_2_n_0 ),
        .I1(\wb_data_o[10]_i_3_n_0 ),
        .I2(\u13/intm [10]),
        .I3(o9_we_i_1_n_0),
        .I4(\wb_data_o[10]_i_4_n_0 ),
        .O(\wb_data_o[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00F000AA00CC0000)) 
    \wb_data_o[10]_i_2 
       (.I0(o4_mode[0]),
        .I1(o9_mode[0]),
        .I2(i4_mode[0]),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF002000200020)) 
    \wb_data_o[10]_i_3 
       (.I0(crac_din[10]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[2]),
        .I4(\u13/ints [10]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[10]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[10]_i_4 
       (.I0(\wb_data_o[23]_i_3_n_0 ),
        .I1(i3_dout[10]),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[10]),
        .I4(i6_dout[10]),
        .I5(\wb_data_o[31]_i_3_n_0 ),
        .O(\wb_data_o[10]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEEE)) 
    \wb_data_o[11]_i_1 
       (.I0(\wb_data_o[11]_i_2_n_0 ),
        .I1(\wb_data_o[11]_i_3_n_0 ),
        .I2(\u13/intm [11]),
        .I3(o9_we_i_1_n_0),
        .I4(\wb_data_o[11]_i_4_n_0 ),
        .O(\wb_data_o[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00F000AA00CC0000)) 
    \wb_data_o[11]_i_2 
       (.I0(o4_mode[1]),
        .I1(o9_mode[1]),
        .I2(i4_mode[1]),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF002000200020)) 
    \wb_data_o[11]_i_3 
       (.I0(crac_din[11]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[2]),
        .I4(\u13/ints [11]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[11]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[11]_i_4 
       (.I0(\wb_data_o[23]_i_3_n_0 ),
        .I1(i3_dout[11]),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[11]),
        .I4(i6_dout[11]),
        .I5(\wb_data_o[31]_i_3_n_0 ),
        .O(\wb_data_o[11]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEEE)) 
    \wb_data_o[12]_i_1 
       (.I0(\wb_data_o[12]_i_2_n_0 ),
        .I1(\wb_data_o[12]_i_3_n_0 ),
        .I2(\u13/intm [12]),
        .I3(o9_we_i_1_n_0),
        .I4(\wb_data_o[12]_i_4_n_0 ),
        .O(\wb_data_o[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00F000AA00CC0000)) 
    \wb_data_o[12]_i_2 
       (.I0(\u13/occ0_r_reg_n_0_[12] ),
        .I1(\u13/occ1_r_reg_n_0_[12] ),
        .I2(\u13/icc_r_reg_n_0_[12] ),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF002000200020)) 
    \wb_data_o[12]_i_3 
       (.I0(crac_din[12]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[2]),
        .I4(\u13/ints [12]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[12]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[12]_i_4 
       (.I0(\wb_data_o[23]_i_3_n_0 ),
        .I1(i3_dout[12]),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[12]),
        .I4(i6_dout[12]),
        .I5(\wb_data_o[31]_i_3_n_0 ),
        .O(\wb_data_o[12]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEEE)) 
    \wb_data_o[13]_i_1 
       (.I0(\wb_data_o[13]_i_2_n_0 ),
        .I1(\wb_data_o[13]_i_3_n_0 ),
        .I2(\u13/intm [13]),
        .I3(o9_we_i_1_n_0),
        .I4(\wb_data_o[13]_i_4_n_0 ),
        .O(\wb_data_o[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00F000AA00CC0000)) 
    \wb_data_o[13]_i_2 
       (.I0(\u13/occ0_r_reg_n_0_[13] ),
        .I1(\u13/occ1_r_reg_n_0_[13] ),
        .I2(\u13/icc_r_reg_n_0_[13] ),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF002000200020)) 
    \wb_data_o[13]_i_3 
       (.I0(crac_din[13]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[2]),
        .I4(\u13/ints [13]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[13]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[13]_i_4 
       (.I0(\wb_data_o[23]_i_3_n_0 ),
        .I1(i3_dout[13]),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[13]),
        .I4(i6_dout[13]),
        .I5(\wb_data_o[31]_i_3_n_0 ),
        .O(\wb_data_o[13]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEEE)) 
    \wb_data_o[14]_i_1 
       (.I0(\wb_data_o[14]_i_2_n_0 ),
        .I1(\wb_data_o[14]_i_3_n_0 ),
        .I2(\u13/intm [14]),
        .I3(o9_we_i_1_n_0),
        .I4(\wb_data_o[14]_i_4_n_0 ),
        .O(\wb_data_o[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00F000AA00CC0000)) 
    \wb_data_o[14]_i_2 
       (.I0(\u13/occ0_r_reg_n_0_[14] ),
        .I1(\u13/occ1_r_reg_n_0_[14] ),
        .I2(\u13/icc_r_reg_n_0_[14] ),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF002000200020)) 
    \wb_data_o[14]_i_3 
       (.I0(crac_din[14]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[2]),
        .I4(\u13/ints [14]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[14]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[14]_i_4 
       (.I0(\wb_data_o[23]_i_3_n_0 ),
        .I1(i3_dout[14]),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[14]),
        .I4(i6_dout[14]),
        .I5(\wb_data_o[31]_i_3_n_0 ),
        .O(\wb_data_o[14]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEEE)) 
    \wb_data_o[15]_i_1 
       (.I0(\wb_data_o[15]_i_2_n_0 ),
        .I1(\wb_data_o[15]_i_3_n_0 ),
        .I2(\u13/intm [15]),
        .I3(o9_we_i_1_n_0),
        .I4(\wb_data_o[15]_i_4_n_0 ),
        .O(\wb_data_o[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00F000AA00CC0000)) 
    \wb_data_o[15]_i_2 
       (.I0(\u13/occ0_r_reg_n_0_[15] ),
        .I1(\u13/occ1_r_reg_n_0_[15] ),
        .I2(\u13/icc_r_reg_n_0_[15] ),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF002000200020)) 
    \wb_data_o[15]_i_3 
       (.I0(crac_din[15]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[2]),
        .I4(\u13/ints [15]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[15]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[15]_i_4 
       (.I0(\wb_data_o[23]_i_3_n_0 ),
        .I1(i3_dout[15]),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[15]),
        .I4(i6_dout[15]),
        .I5(\wb_data_o[31]_i_3_n_0 ),
        .O(\wb_data_o[15]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEAFFEAFFEA)) 
    \wb_data_o[16]_i_1 
       (.I0(\wb_data_o[16]_i_2_n_0 ),
        .I1(o9_we_i_1_n_0),
        .I2(\u13/intm [16]),
        .I3(\wb_data_o[16]_i_3_n_0 ),
        .I4(o8_we_i_1_n_0),
        .I5(crac_out[16]),
        .O(\wb_data_o[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[16]_i_2 
       (.I0(\wb_data_o[30]_i_2_n_0 ),
        .I1(i4_dout[16]),
        .I2(\wb_data_o[31]_i_3_n_0 ),
        .I3(i6_dout[16]),
        .I4(\u13/ints [16]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[16]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[16]_i_3 
       (.I0(o4_we_i_1_n_0),
        .I1(\u13/occ0_r_reg_n_0_[16] ),
        .I2(o7_we_i_1_n_0),
        .I3(\u13/icc_r_reg_n_0_[16] ),
        .I4(i3_dout[16]),
        .I5(\wb_data_o[23]_i_3_n_0 ),
        .O(\wb_data_o[16]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEAFFEAFFEA)) 
    \wb_data_o[17]_i_1 
       (.I0(\wb_data_o[17]_i_2_n_0 ),
        .I1(o9_we_i_1_n_0),
        .I2(\u13/intm [17]),
        .I3(\wb_data_o[17]_i_3_n_0 ),
        .I4(o8_we_i_1_n_0),
        .I5(crac_out[17]),
        .O(\wb_data_o[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[17]_i_2 
       (.I0(\wb_data_o[30]_i_2_n_0 ),
        .I1(i4_dout[17]),
        .I2(\wb_data_o[31]_i_3_n_0 ),
        .I3(i6_dout[17]),
        .I4(\u13/ints [17]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[17]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[17]_i_3 
       (.I0(o4_we_i_1_n_0),
        .I1(\u13/occ0_r_reg_n_0_[17] ),
        .I2(o7_we_i_1_n_0),
        .I3(\u13/icc_r_reg_n_0_[17] ),
        .I4(i3_dout[17]),
        .I5(\wb_data_o[23]_i_3_n_0 ),
        .O(\wb_data_o[17]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEAFFEAFFEA)) 
    \wb_data_o[18]_i_1 
       (.I0(\wb_data_o[18]_i_2_n_0 ),
        .I1(o9_we_i_1_n_0),
        .I2(\u13/intm [18]),
        .I3(\wb_data_o[18]_i_3_n_0 ),
        .I4(o8_we_i_1_n_0),
        .I5(crac_out[18]),
        .O(\wb_data_o[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[18]_i_2 
       (.I0(\wb_data_o[30]_i_2_n_0 ),
        .I1(i4_dout[18]),
        .I2(\wb_data_o[31]_i_3_n_0 ),
        .I3(i6_dout[18]),
        .I4(\u13/ints [18]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[18]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[18]_i_3 
       (.I0(o4_we_i_1_n_0),
        .I1(o6_mode[0]),
        .I2(o7_we_i_1_n_0),
        .I3(i6_mode[0]),
        .I4(i3_dout[18]),
        .I5(\wb_data_o[23]_i_3_n_0 ),
        .O(\wb_data_o[18]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEAFFEAFFEA)) 
    \wb_data_o[19]_i_1 
       (.I0(\wb_data_o[19]_i_2_n_0 ),
        .I1(o9_we_i_1_n_0),
        .I2(\u13/intm [19]),
        .I3(\wb_data_o[19]_i_3_n_0 ),
        .I4(o8_we_i_1_n_0),
        .I5(crac_out[19]),
        .O(\wb_data_o[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[19]_i_2 
       (.I0(\wb_data_o[30]_i_2_n_0 ),
        .I1(i4_dout[19]),
        .I2(\wb_data_o[31]_i_3_n_0 ),
        .I3(i6_dout[19]),
        .I4(\u13/ints [19]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[19]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[19]_i_3 
       (.I0(o4_we_i_1_n_0),
        .I1(o6_mode[1]),
        .I2(o7_we_i_1_n_0),
        .I3(i6_mode[1]),
        .I4(i3_dout[19]),
        .I5(\wb_data_o[23]_i_3_n_0 ),
        .O(\wb_data_o[19]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFEA)) 
    \wb_data_o[1]_i_1 
       (.I0(\wb_data_o[1]_i_2_n_0 ),
        .I1(\u13/intm [1]),
        .I2(o9_we_i_1_n_0),
        .I3(\wb_data_o[1]_i_3_n_0 ),
        .I4(\wb_data_o[1]_i_4_n_0 ),
        .O(\wb_data_o[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCECCFCCCCECCCC)) 
    \wb_data_o[1]_i_2 
       (.I0(crac_din[1]),
        .I1(\wb_data_o[1]_i_5_n_0 ),
        .I2(wb_addr_i[2]),
        .I3(wb_addr_i[3]),
        .I4(wb_addr_i[4]),
        .I5(\u13/occ0_r_reg_n_0_[1] ),
        .O(\wb_data_o[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[1]_i_3 
       (.I0(o6_we_i_1_n_0),
        .I1(\u13/occ1_r_reg_n_0_[1] ),
        .I2(o7_we_i_1_n_0),
        .I3(\u13/icc_r_reg_n_0_[1] ),
        .I4(i3_dout[1]),
        .I5(\wb_data_o[23]_i_3_n_0 ),
        .O(\wb_data_o[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[1]_i_4 
       (.I0(\wb_data_o[30]_i_2_n_0 ),
        .I1(i4_dout[1]),
        .I2(\wb_data_o[31]_i_3_n_0 ),
        .I3(i6_dout[1]),
        .I4(\u13/ints [1]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h000000000000008A)) 
    \wb_data_o[1]_i_5 
       (.I0(suspended_o),
        .I1(wb_addr_i[5]),
        .I2(wb_addr_i[6]),
        .I3(wb_addr_i[2]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[4]),
        .O(\wb_data_o[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEAFFEAFFEA)) 
    \wb_data_o[20]_i_1 
       (.I0(\wb_data_o[20]_i_2_n_0 ),
        .I1(o9_we_i_1_n_0),
        .I2(\u13/intm [20]),
        .I3(\wb_data_o[20]_i_3_n_0 ),
        .I4(o8_we_i_1_n_0),
        .I5(crac_out[20]),
        .O(\wb_data_o[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[20]_i_2 
       (.I0(\wb_data_o[30]_i_2_n_0 ),
        .I1(i4_dout[20]),
        .I2(\wb_data_o[31]_i_3_n_0 ),
        .I3(i6_dout[20]),
        .I4(\u13/ints [20]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[20]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[20]_i_3 
       (.I0(o4_we_i_1_n_0),
        .I1(\u13/occ0_r_reg_n_0_[20] ),
        .I2(o7_we_i_1_n_0),
        .I3(\u13/icc_r_reg_n_0_[20] ),
        .I4(i3_dout[20]),
        .I5(\wb_data_o[23]_i_3_n_0 ),
        .O(\wb_data_o[20]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEAFFEAFFEA)) 
    \wb_data_o[21]_i_1 
       (.I0(\wb_data_o[21]_i_2_n_0 ),
        .I1(o9_we_i_1_n_0),
        .I2(\u13/intm [21]),
        .I3(\wb_data_o[21]_i_3_n_0 ),
        .I4(o8_we_i_1_n_0),
        .I5(crac_out[21]),
        .O(\wb_data_o[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[21]_i_2 
       (.I0(\wb_data_o[30]_i_2_n_0 ),
        .I1(i4_dout[21]),
        .I2(\wb_data_o[31]_i_3_n_0 ),
        .I3(i6_dout[21]),
        .I4(\u13/ints [21]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[21]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[21]_i_3 
       (.I0(o4_we_i_1_n_0),
        .I1(\u13/occ0_r_reg_n_0_[21] ),
        .I2(o7_we_i_1_n_0),
        .I3(\u13/icc_r_reg_n_0_[21] ),
        .I4(i3_dout[21]),
        .I5(\wb_data_o[23]_i_3_n_0 ),
        .O(\wb_data_o[21]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEAFFEAFFEA)) 
    \wb_data_o[22]_i_1 
       (.I0(\wb_data_o[22]_i_2_n_0 ),
        .I1(o9_we_i_1_n_0),
        .I2(\u13/intm [22]),
        .I3(\wb_data_o[22]_i_3_n_0 ),
        .I4(o8_we_i_1_n_0),
        .I5(crac_out[22]),
        .O(\wb_data_o[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[22]_i_2 
       (.I0(\wb_data_o[30]_i_2_n_0 ),
        .I1(i4_dout[22]),
        .I2(\wb_data_o[31]_i_3_n_0 ),
        .I3(i6_dout[22]),
        .I4(\u13/ints [22]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[22]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[22]_i_3 
       (.I0(o4_we_i_1_n_0),
        .I1(\u13/occ0_r_reg_n_0_[22] ),
        .I2(o7_we_i_1_n_0),
        .I3(\u13/icc_r_reg_n_0_[22] ),
        .I4(i3_dout[22]),
        .I5(\wb_data_o[23]_i_3_n_0 ),
        .O(\wb_data_o[22]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFEAEAEA)) 
    \wb_data_o[23]_i_1 
       (.I0(\wb_data_o[23]_i_2_n_0 ),
        .I1(i3_dout[23]),
        .I2(\wb_data_o[23]_i_3_n_0 ),
        .I3(o9_we_i_1_n_0),
        .I4(\u13/intm [23]),
        .I5(\wb_data_o[23]_i_4_n_0 ),
        .O(\wb_data_o[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT5 #(
    .INIT(32'h0A0C0000)) 
    \wb_data_o[23]_i_2 
       (.I0(\u13/icc_r_reg_n_0_[23] ),
        .I1(\u13/occ0_r_reg_n_0_[23] ),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[3]),
        .I4(wb_addr_i[2]),
        .O(\wb_data_o[23]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000800)) 
    \wb_data_o[23]_i_3 
       (.I0(wb_addr_i[3]),
        .I1(wb_addr_i[4]),
        .I2(wb_addr_i[6]),
        .I3(wb_addr_i[5]),
        .I4(wb_addr_i[2]),
        .O(\wb_data_o[23]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[23]_i_4 
       (.I0(\wb_data_o[30]_i_2_n_0 ),
        .I1(i4_dout[23]),
        .I2(\wb_data_o[31]_i_3_n_0 ),
        .I3(i6_dout[23]),
        .I4(\u13/ints [23]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[23]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT4 #(
    .INIT(16'hD000)) 
    \wb_data_o[23]_i_5 
       (.I0(wb_addr_i[5]),
        .I1(wb_addr_i[6]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[3]),
        .O(\wb_data_o[23]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFF8F8F8)) 
    \wb_data_o[24]_i_1 
       (.I0(o9_we_i_1_n_0),
        .I1(\u13/intm [24]),
        .I2(\wb_data_o[24]_i_2_n_0 ),
        .I3(i6_dout[24]),
        .I4(\wb_data_o[31]_i_3_n_0 ),
        .I5(\wb_data_o[24]_i_3_n_0 ),
        .O(\wb_data_o[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT5 #(
    .INIT(32'h80880000)) 
    \wb_data_o[24]_i_2 
       (.I0(wb_addr_i[3]),
        .I1(wb_addr_i[4]),
        .I2(wb_addr_i[6]),
        .I3(wb_addr_i[5]),
        .I4(\u13/ints [24]),
        .O(\wb_data_o[24]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[24]_i_3 
       (.I0(o4_we_i_1_n_0),
        .I1(\u13/occ0_r_reg_n_0_[24] ),
        .I2(\wb_data_o[23]_i_3_n_0 ),
        .I3(i3_dout[24]),
        .I4(i4_dout[24]),
        .I5(\wb_data_o[30]_i_2_n_0 ),
        .O(\wb_data_o[24]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFF8F8F8)) 
    \wb_data_o[25]_i_1 
       (.I0(o9_we_i_1_n_0),
        .I1(\u13/intm [25]),
        .I2(\wb_data_o[25]_i_2_n_0 ),
        .I3(i6_dout[25]),
        .I4(\wb_data_o[31]_i_3_n_0 ),
        .I5(\wb_data_o[25]_i_3_n_0 ),
        .O(\wb_data_o[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT5 #(
    .INIT(32'h80880000)) 
    \wb_data_o[25]_i_2 
       (.I0(wb_addr_i[3]),
        .I1(wb_addr_i[4]),
        .I2(wb_addr_i[6]),
        .I3(wb_addr_i[5]),
        .I4(\u13/ints [25]),
        .O(\wb_data_o[25]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[25]_i_3 
       (.I0(o4_we_i_1_n_0),
        .I1(\u13/occ0_r_reg_n_0_[25] ),
        .I2(\wb_data_o[23]_i_3_n_0 ),
        .I3(i3_dout[25]),
        .I4(i4_dout[25]),
        .I5(\wb_data_o[30]_i_2_n_0 ),
        .O(\wb_data_o[25]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFF8F8F8)) 
    \wb_data_o[26]_i_1 
       (.I0(o9_we_i_1_n_0),
        .I1(\u13/intm [26]),
        .I2(\wb_data_o[26]_i_2_n_0 ),
        .I3(i6_dout[26]),
        .I4(\wb_data_o[31]_i_3_n_0 ),
        .I5(\wb_data_o[26]_i_3_n_0 ),
        .O(\wb_data_o[26]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h80880000)) 
    \wb_data_o[26]_i_2 
       (.I0(wb_addr_i[3]),
        .I1(wb_addr_i[4]),
        .I2(wb_addr_i[6]),
        .I3(wb_addr_i[5]),
        .I4(\u13/ints [26]),
        .O(\wb_data_o[26]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[26]_i_3 
       (.I0(o4_we_i_1_n_0),
        .I1(o7_mode[0]),
        .I2(\wb_data_o[23]_i_3_n_0 ),
        .I3(i3_dout[26]),
        .I4(i4_dout[26]),
        .I5(\wb_data_o[30]_i_2_n_0 ),
        .O(\wb_data_o[26]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFF8F8F8)) 
    \wb_data_o[27]_i_1 
       (.I0(o9_we_i_1_n_0),
        .I1(\u13/intm [27]),
        .I2(\wb_data_o[27]_i_2_n_0 ),
        .I3(i6_dout[27]),
        .I4(\wb_data_o[31]_i_3_n_0 ),
        .I5(\wb_data_o[27]_i_3_n_0 ),
        .O(\wb_data_o[27]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h80880000)) 
    \wb_data_o[27]_i_2 
       (.I0(wb_addr_i[3]),
        .I1(wb_addr_i[4]),
        .I2(wb_addr_i[6]),
        .I3(wb_addr_i[5]),
        .I4(\u13/ints [27]),
        .O(\wb_data_o[27]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[27]_i_3 
       (.I0(o4_we_i_1_n_0),
        .I1(o7_mode[1]),
        .I2(\wb_data_o[23]_i_3_n_0 ),
        .I3(i3_dout[27]),
        .I4(i4_dout[27]),
        .I5(\wb_data_o[30]_i_2_n_0 ),
        .O(\wb_data_o[27]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFF8F8F8)) 
    \wb_data_o[28]_i_1 
       (.I0(o9_we_i_1_n_0),
        .I1(\u13/intm [28]),
        .I2(\wb_data_o[28]_i_2_n_0 ),
        .I3(i6_dout[28]),
        .I4(\wb_data_o[31]_i_3_n_0 ),
        .I5(\wb_data_o[28]_i_3_n_0 ),
        .O(\wb_data_o[28]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h80880000)) 
    \wb_data_o[28]_i_2 
       (.I0(wb_addr_i[3]),
        .I1(wb_addr_i[4]),
        .I2(wb_addr_i[6]),
        .I3(wb_addr_i[5]),
        .I4(\u13/ints [28]),
        .O(\wb_data_o[28]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[28]_i_3 
       (.I0(o4_we_i_1_n_0),
        .I1(\u13/occ0_r_reg_n_0_[28] ),
        .I2(\wb_data_o[23]_i_3_n_0 ),
        .I3(i3_dout[28]),
        .I4(i4_dout[28]),
        .I5(\wb_data_o[30]_i_2_n_0 ),
        .O(\wb_data_o[28]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \wb_data_o[29]_i_1 
       (.I0(i6_dout[29]),
        .I1(\wb_data_o[31]_i_3_n_0 ),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[29]),
        .I4(\wb_data_o[29]_i_2_n_0 ),
        .O(\wb_data_o[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888F888888888)) 
    \wb_data_o[29]_i_2 
       (.I0(i3_dout[29]),
        .I1(\wb_data_o[23]_i_3_n_0 ),
        .I2(\u13/occ0_r_reg_n_0_[29] ),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[29]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEEE)) 
    \wb_data_o[2]_i_1 
       (.I0(\wb_data_o[2]_i_2_n_0 ),
        .I1(\wb_data_o[2]_i_3_n_0 ),
        .I2(\u13/intm [2]),
        .I3(o9_we_i_1_n_0),
        .I4(\wb_data_o[2]_i_4_n_0 ),
        .O(\wb_data_o[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00F000AA00CC0000)) 
    \wb_data_o[2]_i_2 
       (.I0(o3_mode[0]),
        .I1(o8_mode[0]),
        .I2(i3_mode[0]),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF002000200020)) 
    \wb_data_o[2]_i_3 
       (.I0(crac_din[2]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[2]),
        .I4(\u13/ints [2]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[2]_i_4 
       (.I0(\wb_data_o[23]_i_3_n_0 ),
        .I1(i3_dout[2]),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[2]),
        .I4(i6_dout[2]),
        .I5(\wb_data_o[31]_i_3_n_0 ),
        .O(\wb_data_o[2]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \wb_data_o[30]_i_1 
       (.I0(i6_dout[30]),
        .I1(\wb_data_o[31]_i_3_n_0 ),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[30]),
        .I4(\wb_data_o[30]_i_3_n_0 ),
        .O(\wb_data_o[30]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h08000000)) 
    \wb_data_o[30]_i_2 
       (.I0(wb_addr_i[3]),
        .I1(wb_addr_i[4]),
        .I2(wb_addr_i[6]),
        .I3(wb_addr_i[5]),
        .I4(wb_addr_i[2]),
        .O(\wb_data_o[30]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h888888F888888888)) 
    \wb_data_o[30]_i_3 
       (.I0(i3_dout[30]),
        .I1(\wb_data_o[23]_i_3_n_0 ),
        .I2(\u13/occ0_r_reg_n_0_[30] ),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[30]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFEAEAEA)) 
    \wb_data_o[31]_i_1 
       (.I0(\wb_data_o[31]_i_2_n_0 ),
        .I1(\wb_data_o[31]_i_3_n_0 ),
        .I2(i6_dout[31]),
        .I3(crac_out[31]),
        .I4(o8_we_i_1_n_0),
        .O(\wb_data_o[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[31]_i_2 
       (.I0(o4_we_i_1_n_0),
        .I1(\u13/occ0_r_reg_n_0_[31] ),
        .I2(\wb_data_o[23]_i_3_n_0 ),
        .I3(i3_dout[31]),
        .I4(i4_dout[31]),
        .I5(\wb_data_o[30]_i_2_n_0 ),
        .O(\wb_data_o[31]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \wb_data_o[31]_i_3 
       (.I0(wb_addr_i[6]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[5]),
        .I4(wb_addr_i[2]),
        .O(\wb_data_o[31]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEEE)) 
    \wb_data_o[3]_i_1 
       (.I0(\wb_data_o[3]_i_2_n_0 ),
        .I1(\wb_data_o[3]_i_3_n_0 ),
        .I2(\u13/intm [3]),
        .I3(o9_we_i_1_n_0),
        .I4(\wb_data_o[3]_i_4_n_0 ),
        .O(\wb_data_o[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00F000AA00CC0000)) 
    \wb_data_o[3]_i_2 
       (.I0(o3_mode[1]),
        .I1(o8_mode[1]),
        .I2(i3_mode[1]),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF002000200020)) 
    \wb_data_o[3]_i_3 
       (.I0(crac_din[3]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[2]),
        .I4(\u13/ints [3]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[3]_i_4 
       (.I0(\wb_data_o[23]_i_3_n_0 ),
        .I1(i3_dout[3]),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[3]),
        .I4(i6_dout[3]),
        .I5(\wb_data_o[31]_i_3_n_0 ),
        .O(\wb_data_o[3]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEEE)) 
    \wb_data_o[4]_i_1 
       (.I0(\wb_data_o[4]_i_2_n_0 ),
        .I1(\wb_data_o[4]_i_3_n_0 ),
        .I2(\u13/intm [4]),
        .I3(o9_we_i_1_n_0),
        .I4(\wb_data_o[4]_i_4_n_0 ),
        .O(\wb_data_o[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00F000AA00CC0000)) 
    \wb_data_o[4]_i_2 
       (.I0(\u13/occ0_r_reg_n_0_[4] ),
        .I1(\u13/occ1_r_reg_n_0_[4] ),
        .I2(\u13/icc_r_reg_n_0_[4] ),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF002000200020)) 
    \wb_data_o[4]_i_3 
       (.I0(crac_din[4]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[2]),
        .I4(\u13/ints [4]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[4]_i_4 
       (.I0(\wb_data_o[23]_i_3_n_0 ),
        .I1(i3_dout[4]),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[4]),
        .I4(i6_dout[4]),
        .I5(\wb_data_o[31]_i_3_n_0 ),
        .O(\wb_data_o[4]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEEE)) 
    \wb_data_o[5]_i_1 
       (.I0(\wb_data_o[5]_i_2_n_0 ),
        .I1(\wb_data_o[5]_i_3_n_0 ),
        .I2(\u13/intm [5]),
        .I3(o9_we_i_1_n_0),
        .I4(\wb_data_o[5]_i_4_n_0 ),
        .O(\wb_data_o[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00F000AA00CC0000)) 
    \wb_data_o[5]_i_2 
       (.I0(\u13/occ0_r_reg_n_0_[5] ),
        .I1(\u13/occ1_r_reg_n_0_[5] ),
        .I2(\u13/icc_r_reg_n_0_[5] ),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF002000200020)) 
    \wb_data_o[5]_i_3 
       (.I0(crac_din[5]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[2]),
        .I4(\u13/ints [5]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[5]_i_4 
       (.I0(\wb_data_o[23]_i_3_n_0 ),
        .I1(i3_dout[5]),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[5]),
        .I4(i6_dout[5]),
        .I5(\wb_data_o[31]_i_3_n_0 ),
        .O(\wb_data_o[5]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEEE)) 
    \wb_data_o[6]_i_1 
       (.I0(\wb_data_o[6]_i_2_n_0 ),
        .I1(\wb_data_o[6]_i_3_n_0 ),
        .I2(\u13/intm [6]),
        .I3(o9_we_i_1_n_0),
        .I4(\wb_data_o[6]_i_4_n_0 ),
        .O(\wb_data_o[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00F000AA00CC0000)) 
    \wb_data_o[6]_i_2 
       (.I0(\u13/occ0_r_reg_n_0_[6] ),
        .I1(\u13/occ1_r_reg_n_0_[6] ),
        .I2(\u13/icc_r_reg_n_0_[6] ),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF002000200020)) 
    \wb_data_o[6]_i_3 
       (.I0(crac_din[6]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[2]),
        .I4(\u13/ints [6]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[6]_i_4 
       (.I0(\wb_data_o[23]_i_3_n_0 ),
        .I1(i3_dout[6]),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[6]),
        .I4(i6_dout[6]),
        .I5(\wb_data_o[31]_i_3_n_0 ),
        .O(\wb_data_o[6]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEEE)) 
    \wb_data_o[7]_i_1 
       (.I0(\wb_data_o[7]_i_2_n_0 ),
        .I1(\wb_data_o[7]_i_3_n_0 ),
        .I2(\u13/intm [7]),
        .I3(o9_we_i_1_n_0),
        .I4(\wb_data_o[7]_i_4_n_0 ),
        .O(\wb_data_o[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00F000AA00CC0000)) 
    \wb_data_o[7]_i_2 
       (.I0(\u13/occ0_r_reg_n_0_[7] ),
        .I1(\u13/occ1_r_reg_n_0_[7] ),
        .I2(\u13/icc_r_reg_n_0_[7] ),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF002000200020)) 
    \wb_data_o[7]_i_3 
       (.I0(crac_din[7]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[2]),
        .I4(\u13/ints [7]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[7]_i_4 
       (.I0(\wb_data_o[23]_i_3_n_0 ),
        .I1(i3_dout[7]),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[7]),
        .I4(i6_dout[7]),
        .I5(\wb_data_o[31]_i_3_n_0 ),
        .O(\wb_data_o[7]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEEE)) 
    \wb_data_o[8]_i_1 
       (.I0(\wb_data_o[8]_i_2_n_0 ),
        .I1(\wb_data_o[8]_i_3_n_0 ),
        .I2(\u13/intm [8]),
        .I3(o9_we_i_1_n_0),
        .I4(\wb_data_o[8]_i_4_n_0 ),
        .O(\wb_data_o[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00F000AA00CC0000)) 
    \wb_data_o[8]_i_2 
       (.I0(\u13/occ0_r_reg_n_0_[8] ),
        .I1(\u13/occ1_r_reg_n_0_[8] ),
        .I2(\u13/icc_r_reg_n_0_[8] ),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF002000200020)) 
    \wb_data_o[8]_i_3 
       (.I0(crac_din[8]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[2]),
        .I4(\u13/ints [8]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[8]_i_4 
       (.I0(\wb_data_o[23]_i_3_n_0 ),
        .I1(i3_dout[8]),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[8]),
        .I4(i6_dout[8]),
        .I5(\wb_data_o[31]_i_3_n_0 ),
        .O(\wb_data_o[8]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEEE)) 
    \wb_data_o[9]_i_1 
       (.I0(\wb_data_o[9]_i_2_n_0 ),
        .I1(\wb_data_o[9]_i_3_n_0 ),
        .I2(\u13/intm [9]),
        .I3(o9_we_i_1_n_0),
        .I4(\wb_data_o[9]_i_4_n_0 ),
        .O(\wb_data_o[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00F000AA00CC0000)) 
    \wb_data_o[9]_i_2 
       (.I0(\u13/occ0_r_reg_n_0_[9] ),
        .I1(\u13/occ1_r_reg_n_0_[9] ),
        .I2(\u13/icc_r_reg_n_0_[9] ),
        .I3(wb_addr_i[4]),
        .I4(wb_addr_i[3]),
        .I5(wb_addr_i[2]),
        .O(\wb_data_o[9]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF002000200020)) 
    \wb_data_o[9]_i_3 
       (.I0(crac_din[9]),
        .I1(wb_addr_i[3]),
        .I2(wb_addr_i[4]),
        .I3(wb_addr_i[2]),
        .I4(\u13/ints [9]),
        .I5(\wb_data_o[23]_i_5_n_0 ),
        .O(\wb_data_o[9]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \wb_data_o[9]_i_4 
       (.I0(\wb_data_o[23]_i_3_n_0 ),
        .I1(i3_dout[9]),
        .I2(\wb_data_o[30]_i_2_n_0 ),
        .I3(i4_dout[9]),
        .I4(i6_dout[9]),
        .I5(\wb_data_o[31]_i_3_n_0 ),
        .O(\wb_data_o[9]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000B00000000)) 
    we1_i_1
       (.I0(\u12/we2 ),
        .I1(\u12/we1 ),
        .I2(wb_addr_i[31]),
        .I3(wb_addr_i[30]),
        .I4(wb_addr_i[29]),
        .I5(we1_i_2_n_0),
        .O(\u12/we10 ));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT3 #(
    .INIT(8'h80)) 
    we1_i_2
       (.I0(wb_we_i),
        .I1(wb_stb_i),
        .I2(wb_cyc_i),
        .O(we1_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    we2_i_1
       (.I0(wb_cyc_i),
        .I1(wb_stb_i),
        .I2(wb_we_i),
        .I3(\u12/we1 ),
        .O(\u12/we20 ));
  LUT3 #(
    .INIT(8'h60)) 
    \wp[0]_i_1 
       (.I0(\u3/wp_reg_n_0_[0] ),
        .I1(o3_we),
        .I2(\u13/occ0_r_reg_n_0_[0] ),
        .O(\wp[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \wp[0]_i_1__0 
       (.I0(\u4/wp_reg_n_0_[0] ),
        .I1(o4_we),
        .I2(\u13/occ0_r_reg_n_0_[8] ),
        .O(\wp[0]_i_1__0_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \wp[0]_i_1__1 
       (.I0(\u5/wp_reg_n_0_[0] ),
        .I1(o6_we),
        .I2(\u13/occ0_r_reg_n_0_[16] ),
        .O(\wp[0]_i_1__1_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \wp[0]_i_1__2 
       (.I0(\u6/wp_reg_n_0_[0] ),
        .I1(o7_we),
        .I2(\u13/occ0_r_reg_n_0_[24] ),
        .O(\wp[0]_i_1__2_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \wp[0]_i_1__3 
       (.I0(\u7/wp_reg_n_0_[0] ),
        .I1(o8_we),
        .I2(\u13/occ1_r_reg_n_0_[0] ),
        .O(\wp[0]_i_1__3_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \wp[0]_i_1__4 
       (.I0(\u8/wp_reg_n_0_[0] ),
        .I1(o9_we),
        .I2(\u13/occ1_r_reg_n_0_[8] ),
        .O(\wp[0]_i_1__4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair133" *) 
  LUT3 #(
    .INIT(8'hA9)) 
    \wp[0]_i_1__5 
       (.I0(\u9/wp_reg_n_0_[0] ),
        .I1(i3_mode[1]),
        .I2(i3_mode[0]),
        .O(\wp[0]_i_1__5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair134" *) 
  LUT3 #(
    .INIT(8'hA9)) 
    \wp[0]_i_1__6 
       (.I0(\u10/wp_reg_n_0_[0] ),
        .I1(i4_mode[1]),
        .I2(i4_mode[0]),
        .O(\wp[0]_i_1__6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair135" *) 
  LUT3 #(
    .INIT(8'hA9)) 
    \wp[0]_i_1__7 
       (.I0(\u11/wp_reg_n_0_[0] ),
        .I1(i6_mode[1]),
        .I2(i6_mode[0]),
        .O(\wp[0]_i_1__7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h6A00)) 
    \wp[1]_i_1 
       (.I0(\u3/wp_reg_n_0_[1] ),
        .I1(o3_we),
        .I2(\u3/wp_reg_n_0_[0] ),
        .I3(\u13/occ0_r_reg_n_0_[0] ),
        .O(\wp[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h6A00)) 
    \wp[1]_i_1__0 
       (.I0(\u4/wp_reg_n_0_[1] ),
        .I1(o4_we),
        .I2(\u4/wp_reg_n_0_[0] ),
        .I3(\u13/occ0_r_reg_n_0_[8] ),
        .O(\wp[1]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h6A00)) 
    \wp[1]_i_1__1 
       (.I0(\u5/wp_reg_n_0_[1] ),
        .I1(o6_we),
        .I2(\u5/wp_reg_n_0_[0] ),
        .I3(\u13/occ0_r_reg_n_0_[16] ),
        .O(\wp[1]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h6A00)) 
    \wp[1]_i_1__2 
       (.I0(\u6/wp_reg_n_0_[1] ),
        .I1(o7_we),
        .I2(\u6/wp_reg_n_0_[0] ),
        .I3(\u13/occ0_r_reg_n_0_[24] ),
        .O(\wp[1]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h6A00)) 
    \wp[1]_i_1__3 
       (.I0(\u7/wp_reg_n_0_[1] ),
        .I1(o8_we),
        .I2(\u7/wp_reg_n_0_[0] ),
        .I3(\u13/occ1_r_reg_n_0_[0] ),
        .O(\wp[1]_i_1__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h6A00)) 
    \wp[1]_i_1__4 
       (.I0(\u8/wp_reg_n_0_[1] ),
        .I1(o9_we),
        .I2(\u8/wp_reg_n_0_[0] ),
        .I3(\u13/occ1_r_reg_n_0_[8] ),
        .O(\wp[1]_i_1__4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'h01FE)) 
    \wp[1]_i_1__5 
       (.I0(\u9/wp_reg_n_0_[0] ),
        .I1(i3_mode[0]),
        .I2(i3_mode[1]),
        .I3(\u9/p_1_in [0]),
        .O(wp_p1[1]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'h01FE)) 
    \wp[1]_i_1__6 
       (.I0(\u10/wp_reg_n_0_[0] ),
        .I1(i4_mode[0]),
        .I2(i4_mode[1]),
        .I3(\u10/p_1_in [0]),
        .O(wp_p1__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT4 #(
    .INIT(16'h01FE)) 
    \wp[1]_i_1__7 
       (.I0(\u11/wp_reg_n_0_[0] ),
        .I1(i6_mode[0]),
        .I2(i6_mode[1]),
        .I3(\u11/p_1_in [0]),
        .O(wp_p1__1[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h6AAA0000)) 
    \wp[2]_i_1 
       (.I0(\u3/p_1_in ),
        .I1(o3_we),
        .I2(\u3/wp_reg_n_0_[0] ),
        .I3(\u3/wp_reg_n_0_[1] ),
        .I4(\u13/occ0_r_reg_n_0_[0] ),
        .O(\wp[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h6AAA0000)) 
    \wp[2]_i_1__0 
       (.I0(\u4/p_1_in ),
        .I1(o4_we),
        .I2(\u4/wp_reg_n_0_[0] ),
        .I3(\u4/wp_reg_n_0_[1] ),
        .I4(\u13/occ0_r_reg_n_0_[8] ),
        .O(\wp[2]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h6AAA0000)) 
    \wp[2]_i_1__1 
       (.I0(\u5/p_1_in ),
        .I1(o6_we),
        .I2(\u5/wp_reg_n_0_[0] ),
        .I3(\u5/wp_reg_n_0_[1] ),
        .I4(\u13/occ0_r_reg_n_0_[16] ),
        .O(\wp[2]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h6AAA0000)) 
    \wp[2]_i_1__2 
       (.I0(\u6/p_1_in ),
        .I1(o7_we),
        .I2(\u6/wp_reg_n_0_[0] ),
        .I3(\u6/wp_reg_n_0_[1] ),
        .I4(\u13/occ0_r_reg_n_0_[24] ),
        .O(\wp[2]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h6AAA0000)) 
    \wp[2]_i_1__3 
       (.I0(\u7/p_1_in ),
        .I1(o8_we),
        .I2(\u7/wp_reg_n_0_[0] ),
        .I3(\u7/wp_reg_n_0_[1] ),
        .I4(\u13/occ1_r_reg_n_0_[0] ),
        .O(\wp[2]_i_1__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h6AAA0000)) 
    \wp[2]_i_1__4 
       (.I0(\u8/p_1_in ),
        .I1(o9_we),
        .I2(\u8/wp_reg_n_0_[0] ),
        .I3(\u8/wp_reg_n_0_[1] ),
        .I4(\u13/occ1_r_reg_n_0_[8] ),
        .O(\wp[2]_i_1__4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT5 #(
    .INIT(32'h5557AAA8)) 
    \wp[2]_i_1__5 
       (.I0(\u9/p_1_in [0]),
        .I1(i3_mode[1]),
        .I2(i3_mode[0]),
        .I3(\u9/wp_reg_n_0_[0] ),
        .I4(\u9/p_1_in [1]),
        .O(wp_p1[2]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT5 #(
    .INIT(32'h5557AAA8)) 
    \wp[2]_i_1__6 
       (.I0(\u10/p_1_in [0]),
        .I1(i4_mode[1]),
        .I2(i4_mode[0]),
        .I3(\u10/wp_reg_n_0_[0] ),
        .I4(\u10/p_1_in [1]),
        .O(wp_p1__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT5 #(
    .INIT(32'h5557AAA8)) 
    \wp[2]_i_1__7 
       (.I0(\u11/p_1_in [0]),
        .I1(i6_mode[1]),
        .I2(i6_mode[0]),
        .I3(\u11/wp_reg_n_0_[0] ),
        .I4(\u11/p_1_in [1]),
        .O(wp_p1__1[2]));
  LUT1 #(
    .INIT(2'h1)) 
    \wp[3]_i_1 
       (.I0(\u13/icc_r_reg_n_0_[0] ),
        .O(\wp[3]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wp[3]_i_1__0 
       (.I0(\u13/icc_r_reg_n_0_[8] ),
        .O(\wp[3]_i_1__0_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wp[3]_i_1__1 
       (.I0(\u13/icc_r_reg_n_0_[16] ),
        .O(\wp[3]_i_1__1_n_0 ));
  LUT3 #(
    .INIT(8'h08)) 
    \wp[3]_i_2 
       (.I0(in_valid_s[0]),
        .I1(\u14/u6/en_out_l_reg_n_0 ),
        .I2(\u14/u6/en_out_l2_reg_n_0 ),
        .O(i3_we));
  LUT3 #(
    .INIT(8'h08)) 
    \wp[3]_i_2__0 
       (.I0(in_valid_s[1]),
        .I1(\u14/u7/en_out_l_reg_n_0 ),
        .I2(\u14/u7/en_out_l2_reg_n_0 ),
        .O(i4_we));
  LUT3 #(
    .INIT(8'h08)) 
    \wp[3]_i_2__1 
       (.I0(in_valid_s[2]),
        .I1(\u14/u8/en_out_l_reg_n_0 ),
        .I2(\u14/u8/en_out_l2_reg_n_0 ),
        .O(i6_we));
  LUT6 #(
    .INIT(64'h01FFFFFFFE000000)) 
    \wp[3]_i_3 
       (.I0(i3_mode[1]),
        .I1(i3_mode[0]),
        .I2(\u9/wp_reg_n_0_[0] ),
        .I3(\u9/p_1_in [0]),
        .I4(\u9/p_1_in [1]),
        .I5(\u9/wp_reg_n_0_[3] ),
        .O(wp_p1[3]));
  LUT6 #(
    .INIT(64'h01FFFFFFFE000000)) 
    \wp[3]_i_3__0 
       (.I0(i4_mode[1]),
        .I1(i4_mode[0]),
        .I2(\u10/wp_reg_n_0_[0] ),
        .I3(\u10/p_1_in [0]),
        .I4(\u10/p_1_in [1]),
        .I5(\u10/wp_reg_n_0_[3] ),
        .O(wp_p1__0[3]));
  LUT6 #(
    .INIT(64'h01FFFFFFFE000000)) 
    \wp[3]_i_3__1 
       (.I0(i6_mode[1]),
        .I1(i6_mode[0]),
        .I2(\u11/wp_reg_n_0_[0] ),
        .I3(\u11/p_1_in [0]),
        .I4(\u11/p_1_in [1]),
        .I5(\u11/wp_reg_n_0_[3] ),
        .O(wp_p1__1[3]));
endmodule
