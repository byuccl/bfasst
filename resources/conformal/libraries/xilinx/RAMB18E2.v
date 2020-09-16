///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2015 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \   \   \/      Version     : 2015.4
//  \   \          Description : Xilinx Formal Library Component
//  /   /                     
// /___/   /\      Filename    : RAMB18E2.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//     01/23/14 - Initial version
//     04/11/14 - Fixed rd_loops_a and rd_loops_b error (CR 781537).
//     10/20/14 - Removed b'x support (CR 817718).
//     10/29/14 - Fixed READ/WRITE_WIDTH_A/B_BIN signals (CR 829919).
//     01/27/15 - Added Support for CDC (PR 824120).
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module RAMB18E2 #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter CASCADE_ORDER_A = "NONE",
  parameter CASCADE_ORDER_B = "NONE",
  parameter CLOCK_DOMAINS = "INDEPENDENT",
  parameter integer DOA_REG = 1,
  parameter integer DOB_REG = 1,
  parameter ENADDRENA = "FALSE",
  parameter ENADDRENB = "FALSE",
  parameter [255:0] INITP_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INITP_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INITP_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INITP_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INITP_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INITP_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INITP_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INITP_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_08 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_09 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_0A = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_0B = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_0C = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_0D = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_0E = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_0F = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_10 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_11 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_12 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_13 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_14 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_15 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_16 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_17 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_18 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_19 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_1A = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_1B = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_1C = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_1D = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_1E = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_1F = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_20 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_21 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_22 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_23 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_24 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_25 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_26 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_27 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_28 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_29 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_2A = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_2B = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_2C = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_2D = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_2E = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_2F = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_30 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_31 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_32 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_33 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_34 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_35 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_36 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_37 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_38 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_39 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_3A = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_3B = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_3C = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_3D = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_3E = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [255:0] INIT_3F = 256'h0000000000000000000000000000000000000000000000000000000000000000,
  parameter [17:0] INIT_A = 18'h00000,
  parameter [17:0] INIT_B = 18'h00000,
  parameter INIT_FILE = "NONE",
  parameter [0:0] IS_CLKARDCLK_INVERTED = 1'b0,
  parameter [0:0] IS_CLKBWRCLK_INVERTED = 1'b0,
  parameter [0:0] IS_ENARDEN_INVERTED = 1'b0,
  parameter [0:0] IS_ENBWREN_INVERTED = 1'b0,
  parameter [0:0] IS_RSTRAMARSTRAM_INVERTED = 1'b0,
  parameter [0:0] IS_RSTRAMB_INVERTED = 1'b0,
  parameter [0:0] IS_RSTREGARSTREG_INVERTED = 1'b0,
  parameter [0:0] IS_RSTREGB_INVERTED = 1'b0,
  parameter RDADDRCHANGEA = "FALSE",
  parameter RDADDRCHANGEB = "FALSE",
  parameter integer READ_WIDTH_A = 0,
  parameter integer READ_WIDTH_B = 0,
  parameter RSTREG_PRIORITY_A = "RSTREG",
  parameter RSTREG_PRIORITY_B = "RSTREG",
  parameter SIM_COLLISION_CHECK = "ALL",
  parameter SLEEP_ASYNC = "FALSE",
  parameter [17:0] SRVAL_A = 18'h00000,
  parameter [17:0] SRVAL_B = 18'h00000,
  parameter WRITE_MODE_A = "NO_CHANGE",
  parameter WRITE_MODE_B = "NO_CHANGE",
  parameter integer WRITE_WIDTH_A = 0,
  parameter integer WRITE_WIDTH_B = 0
)(
  output [15:0] CASDOUTA,
  output [15:0] CASDOUTB,
  output [1:0] CASDOUTPA,
  output [1:0] CASDOUTPB,
  output [15:0] DOUTADOUT,
  output [15:0] DOUTBDOUT,
  output [1:0] DOUTPADOUTP,
  output [1:0] DOUTPBDOUTP,

  input [13:0] ADDRARDADDR,
  input [13:0] ADDRBWRADDR,
  input ADDRENA,
  input ADDRENB,
  input CASDIMUXA,
  input CASDIMUXB,
  input [15:0] CASDINA,
  input [15:0] CASDINB,
  input [1:0] CASDINPA,
  input [1:0] CASDINPB,
  input CASDOMUXA,
  input CASDOMUXB,
  input CASDOMUXEN_A,
  input CASDOMUXEN_B,
  input CASOREGIMUXA,
  input CASOREGIMUXB,
  input CASOREGIMUXEN_A,
  input CASOREGIMUXEN_B,
  input CLKARDCLK,
  input CLKBWRCLK,
  input [15:0] DINADIN,
  input [15:0] DINBDIN,
  input [1:0] DINPADINP,
  input [1:0] DINPBDINP,
  input ENARDEN,
  input ENBWREN,
  input REGCEAREGCE,
  input REGCEB,
  input RSTRAMARSTRAM,
  input RSTRAMB,
  input RSTREGARSTREG,
  input RSTREGB,
  input SLEEP,
  input [1:0] WEA,
  input [3:0] WEBWE
);

// define constants
  localparam MODULE_NAME = "RAMB18E2";
  localparam in_delay     = 0;
  localparam out_delay    = 0;
  localparam inclk_delay  = 0;
  localparam outclk_delay = 0;
  integer t_coll_min = 48;

  localparam integer ADDR_WIDTH = 14;
  localparam integer INIT_WIDTH =  36;
  localparam integer D_WIDTH  = 32;
  localparam integer DP_WIDTH = 4;

  localparam mem_width = 1;
  localparam memp_width = 1;
  localparam mem_depth = 16384;
  localparam memp_depth = 2048;

// Parameter encodings and registers
  localparam CASCADE_ORDER_FIRST  = 1;
  localparam CASCADE_ORDER_LAST   = 2;
  localparam CASCADE_ORDER_MIDDLE = 3;
  localparam CASCADE_ORDER_NONE   = 0;
  localparam CLOCK_DOMAINS_COMMON      = 1;
  localparam CLOCK_DOMAINS_INDEPENDENT = 0;
  localparam DOA_REG_0 = 1;
  localparam DOA_REG_1 = 0;
  localparam DOB_REG_0 = 1;
  localparam DOB_REG_1 = 0;
  localparam ENADDRENA_FALSE = 0;
  localparam ENADDRENA_TRUE  = 1;
  localparam ENADDRENB_FALSE = 0;
  localparam ENADDRENB_TRUE  = 1;
  localparam RDADDRCHANGEA_FALSE = 0;
  localparam RDADDRCHANGEA_TRUE  = 1;
  localparam RDADDRCHANGEB_FALSE = 0;
  localparam RDADDRCHANGEB_TRUE  = 1;
  localparam READ_WIDTH_A_0  = 1;
  localparam READ_WIDTH_A_1  = 1;
  localparam READ_WIDTH_A_18 = 16;
  localparam READ_WIDTH_A_2  = 2;
  localparam READ_WIDTH_A_36 = 32;
  localparam READ_WIDTH_A_4  = 4;
  localparam READ_WIDTH_A_9  = 8;
  localparam READ_WIDTH_B_0  = 1;
  localparam READ_WIDTH_B_1  = 1;
  localparam READ_WIDTH_B_18 = 16;
  localparam READ_WIDTH_B_2  = 2;
  localparam READ_WIDTH_B_4  = 4;
  localparam READ_WIDTH_B_9  = 8;
  localparam RSTREG_PRIORITY_A_REGCE  = 1;
  localparam RSTREG_PRIORITY_A_RSTREG = 0;
  localparam RSTREG_PRIORITY_B_REGCE  = 1;
  localparam RSTREG_PRIORITY_B_RSTREG = 0;
  localparam SIM_COLLISION_CHECK_ALL             = 0;
  localparam SIM_COLLISION_CHECK_GENERATE_X_ONLY = 1;
  localparam SIM_COLLISION_CHECK_NONE            = 2;
  localparam SIM_COLLISION_CHECK_WARNING_ONLY    = 3;
  localparam SLEEP_ASYNC_FALSE = 0;
  localparam SLEEP_ASYNC_TRUE  = 1;
  localparam WRITE_MODE_A_NO_CHANGE   = 0;
  localparam WRITE_MODE_A_READ_FIRST  = 1;
  localparam WRITE_MODE_A_WRITE_FIRST = 2;
  localparam WRITE_MODE_B_NO_CHANGE   = 0;
  localparam WRITE_MODE_B_READ_FIRST  = 1;
  localparam WRITE_MODE_B_WRITE_FIRST = 2;
  localparam WRITE_WIDTH_A_0  = 1;
  localparam WRITE_WIDTH_A_1  = 1;
  localparam WRITE_WIDTH_A_18 = 16;
  localparam WRITE_WIDTH_A_2  = 2;
  localparam WRITE_WIDTH_A_4  = 4;
  localparam WRITE_WIDTH_A_9  = 8;
  localparam WRITE_WIDTH_B_0  = 1;
  localparam WRITE_WIDTH_B_1  = 1;
  localparam WRITE_WIDTH_B_18 = 16;
  localparam WRITE_WIDTH_B_2  = 2;
  localparam WRITE_WIDTH_B_36 = 32;
  localparam WRITE_WIDTH_B_4  = 4;
  localparam WRITE_WIDTH_B_9  = 8;

  `ifndef XIL_DR
  localparam [48:1] CASCADE_ORDER_A_REG = CASCADE_ORDER_A;
  localparam [48:1] CASCADE_ORDER_B_REG = CASCADE_ORDER_B;
  localparam [88:1] CLOCK_DOMAINS_REG = CLOCK_DOMAINS;
  localparam [0:0] DOA_REG_REG = DOA_REG;
  localparam [0:0] DOB_REG_REG = DOB_REG;
  localparam [40:1] ENADDRENA_REG = ENADDRENA;
  localparam [40:1] ENADDRENB_REG = ENADDRENB;
  localparam [255:0] INITP_00_REG = INITP_00;
  localparam [255:0] INITP_01_REG = INITP_01;
  localparam [255:0] INITP_02_REG = INITP_02;
  localparam [255:0] INITP_03_REG = INITP_03;
  localparam [255:0] INITP_04_REG = INITP_04;
  localparam [255:0] INITP_05_REG = INITP_05;
  localparam [255:0] INITP_06_REG = INITP_06;
  localparam [255:0] INITP_07_REG = INITP_07;
  localparam [255:0] INIT_00_REG = INIT_00;
  localparam [255:0] INIT_01_REG = INIT_01;
  localparam [255:0] INIT_02_REG = INIT_02;
  localparam [255:0] INIT_03_REG = INIT_03;
  localparam [255:0] INIT_04_REG = INIT_04;
  localparam [255:0] INIT_05_REG = INIT_05;
  localparam [255:0] INIT_06_REG = INIT_06;
  localparam [255:0] INIT_07_REG = INIT_07;
  localparam [255:0] INIT_08_REG = INIT_08;
  localparam [255:0] INIT_09_REG = INIT_09;
  localparam [255:0] INIT_0A_REG = INIT_0A;
  localparam [255:0] INIT_0B_REG = INIT_0B;
  localparam [255:0] INIT_0C_REG = INIT_0C;
  localparam [255:0] INIT_0D_REG = INIT_0D;
  localparam [255:0] INIT_0E_REG = INIT_0E;
  localparam [255:0] INIT_0F_REG = INIT_0F;
  localparam [255:0] INIT_10_REG = INIT_10;
  localparam [255:0] INIT_11_REG = INIT_11;
  localparam [255:0] INIT_12_REG = INIT_12;
  localparam [255:0] INIT_13_REG = INIT_13;
  localparam [255:0] INIT_14_REG = INIT_14;
  localparam [255:0] INIT_15_REG = INIT_15;
  localparam [255:0] INIT_16_REG = INIT_16;
  localparam [255:0] INIT_17_REG = INIT_17;
  localparam [255:0] INIT_18_REG = INIT_18;
  localparam [255:0] INIT_19_REG = INIT_19;
  localparam [255:0] INIT_1A_REG = INIT_1A;
  localparam [255:0] INIT_1B_REG = INIT_1B;
  localparam [255:0] INIT_1C_REG = INIT_1C;
  localparam [255:0] INIT_1D_REG = INIT_1D;
  localparam [255:0] INIT_1E_REG = INIT_1E;
  localparam [255:0] INIT_1F_REG = INIT_1F;
  localparam [255:0] INIT_20_REG = INIT_20;
  localparam [255:0] INIT_21_REG = INIT_21;
  localparam [255:0] INIT_22_REG = INIT_22;
  localparam [255:0] INIT_23_REG = INIT_23;
  localparam [255:0] INIT_24_REG = INIT_24;
  localparam [255:0] INIT_25_REG = INIT_25;
  localparam [255:0] INIT_26_REG = INIT_26;
  localparam [255:0] INIT_27_REG = INIT_27;
  localparam [255:0] INIT_28_REG = INIT_28;
  localparam [255:0] INIT_29_REG = INIT_29;
  localparam [255:0] INIT_2A_REG = INIT_2A;
  localparam [255:0] INIT_2B_REG = INIT_2B;
  localparam [255:0] INIT_2C_REG = INIT_2C;
  localparam [255:0] INIT_2D_REG = INIT_2D;
  localparam [255:0] INIT_2E_REG = INIT_2E;
  localparam [255:0] INIT_2F_REG = INIT_2F;
  localparam [255:0] INIT_30_REG = INIT_30;
  localparam [255:0] INIT_31_REG = INIT_31;
  localparam [255:0] INIT_32_REG = INIT_32;
  localparam [255:0] INIT_33_REG = INIT_33;
  localparam [255:0] INIT_34_REG = INIT_34;
  localparam [255:0] INIT_35_REG = INIT_35;
  localparam [255:0] INIT_36_REG = INIT_36;
  localparam [255:0] INIT_37_REG = INIT_37;
  localparam [255:0] INIT_38_REG = INIT_38;
  localparam [255:0] INIT_39_REG = INIT_39;
  localparam [255:0] INIT_3A_REG = INIT_3A;
  localparam [255:0] INIT_3B_REG = INIT_3B;
  localparam [255:0] INIT_3C_REG = INIT_3C;
  localparam [255:0] INIT_3D_REG = INIT_3D;
  localparam [255:0] INIT_3E_REG = INIT_3E;
  localparam [255:0] INIT_3F_REG = INIT_3F;
  localparam [17:0] INIT_A_REG = INIT_A;
  localparam [17:0] INIT_B_REG = INIT_B;
  localparam INIT_FILE_REG = INIT_FILE;
  localparam [0:0] IS_CLKARDCLK_INVERTED_REG = IS_CLKARDCLK_INVERTED;
  localparam [0:0] IS_CLKBWRCLK_INVERTED_REG = IS_CLKBWRCLK_INVERTED;
  localparam [0:0] IS_ENARDEN_INVERTED_REG = IS_ENARDEN_INVERTED;
  localparam [0:0] IS_ENBWREN_INVERTED_REG = IS_ENBWREN_INVERTED;
  localparam [0:0] IS_RSTRAMARSTRAM_INVERTED_REG = IS_RSTRAMARSTRAM_INVERTED;
  localparam [0:0] IS_RSTRAMB_INVERTED_REG = IS_RSTRAMB_INVERTED;
  localparam [0:0] IS_RSTREGARSTREG_INVERTED_REG = IS_RSTREGARSTREG_INVERTED;
  localparam [0:0] IS_RSTREGB_INVERTED_REG = IS_RSTREGB_INVERTED;
  localparam [40:1] RDADDRCHANGEA_REG = RDADDRCHANGEA;
  localparam [40:1] RDADDRCHANGEB_REG = RDADDRCHANGEB;
  localparam [5:0] READ_WIDTH_A_REG = READ_WIDTH_A;
  localparam [4:0] READ_WIDTH_B_REG = READ_WIDTH_B;
  localparam [48:1] RSTREG_PRIORITY_A_REG = RSTREG_PRIORITY_A;
  localparam [48:1] RSTREG_PRIORITY_B_REG = RSTREG_PRIORITY_B;
  localparam [120:1] SIM_COLLISION_CHECK_REG = SIM_COLLISION_CHECK;
  localparam [40:1] SLEEP_ASYNC_REG = SLEEP_ASYNC;
  localparam [17:0] SRVAL_A_REG = SRVAL_A;
  localparam [17:0] SRVAL_B_REG = SRVAL_B;
  localparam [88:1] WRITE_MODE_A_REG = WRITE_MODE_A;
  localparam [88:1] WRITE_MODE_B_REG = WRITE_MODE_B;
  localparam [4:0] WRITE_WIDTH_A_REG = WRITE_WIDTH_A;
  localparam [5:0] WRITE_WIDTH_B_REG = WRITE_WIDTH_B;
  `endif

  wire [1:0] CASCADE_ORDER_A_BIN;
  wire [1:0] CASCADE_ORDER_B_BIN;
  wire CLOCK_DOMAINS_BIN;
  wire DOA_REG_BIN;
  wire DOB_REG_BIN;
  wire ENADDRENA_BIN;
  wire ENADDRENB_BIN;
  wire [255:0] INITP_BIN [0:7];
  reg [255:0] INITP_TMP;
  wire [255:0] INIT_BIN [0:63];
  reg [255:0] INIT_TMP;
  wire [INIT_WIDTH/2-1:0] INIT_A_BIN;
  wire [INIT_WIDTH/2-1:0] INIT_B_BIN;
//  wire INIT_FILE_BIN;
  wire IS_CLKARDCLK_INVERTED_BIN;
  wire IS_CLKBWRCLK_INVERTED_BIN;
  wire IS_ENARDEN_INVERTED_BIN;
  wire IS_ENBWREN_INVERTED_BIN;
  wire IS_RSTRAMARSTRAM_INVERTED_BIN;
  wire IS_RSTRAMB_INVERTED_BIN;
  wire IS_RSTREGARSTREG_INVERTED_BIN;
  wire IS_RSTREGB_INVERTED_BIN;
  wire RDADDRCHANGEA_BIN;
  wire RDADDRCHANGEB_BIN;
  wire RSTREG_PRIORITY_A_BIN;
  wire RSTREG_PRIORITY_B_BIN;
  wire [1:0] SIM_COLLISION_CHECK_BIN;
  wire SLEEP_ASYNC_BIN;
  wire [INIT_WIDTH/2-1:0] SRVAL_A_BIN;
  wire [INIT_WIDTH/2-1:0] SRVAL_B_BIN;
  wire [1:0] WRITE_MODE_A_BIN;
  wire [1:0] WRITE_MODE_B_BIN;

  reg trig_gsr = 1'b0;
  tri0 glblGSR = trig_gsr;

  wire [D_WIDTH/2-1:0] CASDOUTA_out;
  wire [D_WIDTH/2-1:0] CASDOUTB_out;
  wire [DP_WIDTH/2-1:0] CASDOUTPA_out;
  wire [DP_WIDTH/2-1:0] CASDOUTPB_out;
  wire [D_WIDTH/2-1:0] DOUTADOUT_out;
  wire [D_WIDTH/2-1:0] DOUTBDOUT_out;
  wire [DP_WIDTH/2-1:0] DOUTPADOUTP_out;
  wire [DP_WIDTH/2-1:0] DOUTPBDOUTP_out;

  wire [15:0] CASDOUTA_delay;
  wire [15:0] CASDOUTB_delay;
  wire [15:0] DOUTADOUT_delay;
  wire [15:0] DOUTBDOUT_delay;
  wire [1:0] CASDOUTPA_delay;
  wire [1:0] CASDOUTPB_delay;
  wire [1:0] DOUTPADOUTP_delay;
  wire [1:0] DOUTPBDOUTP_delay;

  wire ADDRENA_in;
  wire ADDRENB_in;
  wire CASDIMUXA_in;
  wire CASDIMUXB_in;
  wire CASDOMUXA_in;
  wire CASDOMUXB_in;
  wire CASDOMUXEN_A_in;
  wire CASDOMUXEN_B_in;
  wire CASOREGIMUXA_in;
  wire CASOREGIMUXB_in;
  wire CASOREGIMUXEN_A_in;
  wire CASOREGIMUXEN_B_in;
  wire CLKARDCLK_in;
  wire CLKBWRCLK_in;
  wire ENARDEN_in;
  wire ENBWREN_in;
  wire REGCEAREGCE_in;
  wire REGCEB_in;
  wire RSTRAMARSTRAM_in;
  wire RSTRAMB_in;
  wire RSTREGARSTREG_in;
  wire RSTREGB_in;
  wire SLEEP_in;
  wire [13:0] ADDRARDADDR_in;
  wire [13:0] ADDRBWRADDR_in;
  wire [D_WIDTH/2-1:0] CASDINA_in;
  wire [D_WIDTH/2-1:0] CASDINB_in;
  wire [D_WIDTH/2-1:0] DINADIN_in;
  wire [D_WIDTH/2-1:0] DINBDIN_in;
  wire [1:0] CASDINPA_in;
  wire [1:0] CASDINPB_in;
  wire [DP_WIDTH/2-1:0] DINPADINP_in;
  wire [DP_WIDTH/2-1:0] DINPBDINP_in;
  wire [1:0] WEA_in;
  wire [3:0] WEBWE_in;

  wire ADDRENA_delay;
  wire ADDRENB_delay;
  wire CASDIMUXA_delay;
  wire CASDIMUXB_delay;
  wire CASDOMUXA_delay;
  wire CASDOMUXB_delay;
  wire CASDOMUXEN_A_delay;
  wire CASDOMUXEN_B_delay;
  wire CASOREGIMUXA_delay;
  wire CASOREGIMUXB_delay;
  wire CASOREGIMUXEN_A_delay;
  wire CASOREGIMUXEN_B_delay;
  wire CLKARDCLK_delay;
  wire CLKBWRCLK_delay;
  wire ENARDEN_delay;
  wire ENBWREN_delay;
  wire REGCEAREGCE_delay;
  wire REGCEB_delay;
  wire RSTRAMARSTRAM_delay;
  wire RSTRAMB_delay;
  wire RSTREGARSTREG_delay;
  wire RSTREGB_delay;
  wire SLEEP_delay;
  wire [13:0] ADDRARDADDR_delay;
  wire [13:0] ADDRBWRADDR_delay;
  wire [15:0] CASDINA_delay;
  wire [15:0] CASDINB_delay;
  wire [15:0] DINADIN_delay;
  wire [15:0] DINBDIN_delay;
  wire [1:0] CASDINPA_delay;
  wire [1:0] CASDINPB_delay;
  wire [1:0] DINPADINP_delay;
  wire [1:0] DINPBDINP_delay;
  wire [1:0] WEA_delay;
  wire [3:0] WEBWE_delay;

// internal variables, signals, busses
  integer i=0;
  integer j=0;
  integer k=0;
  integer ra=0;
  integer wb=0;
  integer rb=0;
  integer wa=0;
  localparam max_rd_loops = D_WIDTH;
  localparam max_wr_loops = D_WIDTH;
  reg INIT_MEM = 0;
  wire SLEEP_int;
  reg  SLEEP_reg = 1'b0;
  reg  SLEEP_reg1 = 1'b0;
  wire RSTREG_A_int;
  wire REGCE_A_int;
  wire RSTREG_B_int;
  wire REGCE_B_int;
  reg CASDOMUXA_reg = 1'b0;
  reg CASOREGIMUXA_reg = 1'b0;
  reg CASDOMUXB_reg = 1'b0;
  reg CASOREGIMUXB_reg = 1'b0;
  wire CASDOMUXB_int;
  wire [INIT_WIDTH-1:0] INIT_A_int;
  wire [INIT_WIDTH-1:0] SRVAL_A_int;
  wire [INIT_WIDTH/2-1:0] INIT_B_int;
  wire [INIT_WIDTH/2-1:0] SRVAL_B_int;

  wire mem_wr_clk_a;
  wire mem_wr_en_a;
  reg mem_wr_en_a_wf = 1'b0;
  wire [D_WIDTH-1:0] mem_we_a;
  wire [DP_WIDTH-1:0] memp_we_a;
  wire [D_WIDTH/2-1:0] mem_rm_doutb;
  wire [DP_WIDTH/2-1:0] memp_rm_doutb;
  wire [D_WIDTH-1:0] mem_rm_a;
  wire [D_WIDTH-1:0] mem_rm_b;
  wire [D_WIDTH-1:0] mem_wm_a;
  wire [D_WIDTH-1:0] mem_wm_b;
  reg wr_data_matches = 0;
  reg wr_a_data_matches_rd_b_data = 0;
  reg wr_b_data_matches_rd_a_data = 0;
  wire mem_wr_clk_b;
  wire mem_wr_en_b;
  reg mem_wr_en_b_wf = 1'b0;
  wire [D_WIDTH-1:0] mem_we_b;
  wire [DP_WIDTH-1:0] memp_we_b;
  wire [D_WIDTH-1:0] mem_rm_douta;
  wire [DP_WIDTH-1:0] memp_rm_douta;
  wire mem_rd_clk_a;
  wire mem_rd_en_a;
  wire mem_rst_a;
  wire mem_rd_clk_b;
  wire mem_rd_en_b;
  wire mem_rst_b;

  reg  [mem_depth-1 : 0] mem;
  wire [D_WIDTH/2-1 : 0]  mem_wr_a;
  reg  wr_a_event = 1'b0;
  reg  [D_WIDTH-1 : 0]  mem_rd_a;
  reg  [D_WIDTH-1 : 0]  mem_rd_a_rf;
  reg  [D_WIDTH-1 : 0]  mem_rd_a_wf;
  wire [D_WIDTH-1 : 0]  mem_wr_b;
  reg  wr_b_event = 1'b0;
  reg  [D_WIDTH-1 : 0]  mem_rd_b;
  reg  [D_WIDTH-1 : 0]  mem_rd_b_rf;
  reg  [D_WIDTH-1 : 0]  mem_rd_b_wf;
  reg  [D_WIDTH-1 : 0]  mem_a_reg;
  wire [D_WIDTH-1 : 0]  mem_a_reg_mux;
  wire [D_WIDTH-1 : 0]  mem_a_mux;
  reg  [D_WIDTH-1 : 0]  mem_a_lat;
  wire [D_WIDTH-1 : 0]  mem_a_out;
  reg  [D_WIDTH/2-1 : 0]  mem_b_reg;
  wire [D_WIDTH/2-1 : 0]  mem_b_reg_mux;
  wire [D_WIDTH/2-1 : 0]  mem_b_mux;
  reg  [D_WIDTH/2-1 : 0]  mem_b_lat;
  wire [D_WIDTH/2-1 : 0]  mem_b_out;
  reg [memp_depth - 1 : 0] memp;
  wire [DP_WIDTH-1 : 0] memp_wr_a;
  reg  [DP_WIDTH-1 : 0] memp_rd_a;
  reg  [DP_WIDTH-1 : 0] memp_rd_a_rf;
  reg  [DP_WIDTH-1 : 0] memp_rd_a_wf;
  wire [DP_WIDTH-1 : 0] memp_wr_b;
  reg  [DP_WIDTH-1 : 0] memp_rd_b;
  reg  [DP_WIDTH-1 : 0] memp_rd_b_rf;
  reg  [DP_WIDTH-1 : 0] memp_rd_b_wf;
  reg  [DP_WIDTH-1 : 0]  memp_a_reg;
  wire [DP_WIDTH-1 : 0]  memp_a_reg_mux;
  wire [DP_WIDTH-1 : 0]  memp_a_mux;
  reg  [DP_WIDTH-1 : 0]  memp_a_lat;
  wire [DP_WIDTH-1 : 0]  memp_a_out;
  reg  [DP_WIDTH/2-1 : 0]  memp_b_reg;
  wire [DP_WIDTH/2-1 : 0]  memp_b_reg_mux;
  wire [DP_WIDTH/2-1 : 0]  memp_b_mux;
  reg  [DP_WIDTH/2-1 : 0]  memp_b_lat;
  wire [DP_WIDTH/2-1 : 0]  memp_b_out;
  reg [ADDR_WIDTH-1:0] rd_addr_a = 0;
  reg [ADDR_WIDTH-1:0] rd_addr_b = 0;
  reg [ADDR_WIDTH-1:0] wr_addr_a = 0;
  reg [ADDR_WIDTH-1:0] wr_addr_b = 0;
  wire wr_a_rd_b_addr_coll;
  wire wr_addr_coll;
  wire wr_b_rd_a_addr_coll;
  wire sdp_mode;
  wire sdp_mode_wr;
  wire sdp_mode_rd;

// clk period for collision window variables
integer t_max_a=3000, t_max_b=3000;
reg clka_timeout=0, clkb_timeout=0;
reg en_clk_sync = 1'b0;


// input output assignments
  assign #(out_delay) CASDOUTA = CASDOUTA_delay;
  assign #(out_delay) CASDOUTB = CASDOUTB_delay;
  assign #(out_delay) CASDOUTPA = CASDOUTPA_delay;
  assign #(out_delay) CASDOUTPB = CASDOUTPB_delay;
  assign #(out_delay) DOUTADOUT = DOUTADOUT_delay;
  assign #(out_delay) DOUTBDOUT = DOUTBDOUT_delay;
  assign #(out_delay) DOUTPADOUTP = DOUTPADOUTP_delay;
  assign #(out_delay) DOUTPBDOUTP = DOUTPBDOUTP_delay;

`ifndef XIL_TIMING // inputs with timing checks
  assign #(inclk_delay) CLKARDCLK_delay = CLKARDCLK;
  assign #(inclk_delay) CLKBWRCLK_delay = CLKBWRCLK;

  assign #(in_delay) ADDRARDADDR_delay = ADDRARDADDR;
  assign #(in_delay) ADDRBWRADDR_delay = ADDRBWRADDR;
  assign #(in_delay) ADDRENA_delay = ADDRENA;
  assign #(in_delay) ADDRENB_delay = ADDRENB;
  assign #(in_delay) CASDIMUXA_delay = CASDIMUXA;
  assign #(in_delay) CASDIMUXB_delay = CASDIMUXB;
  assign #(in_delay) CASDINA_delay = CASDINA;
  assign #(in_delay) CASDINB_delay = CASDINB;
  assign #(in_delay) CASDINPA_delay = CASDINPA;
  assign #(in_delay) CASDINPB_delay = CASDINPB;
  assign #(in_delay) CASDOMUXA_delay = CASDOMUXA;
  assign #(in_delay) CASDOMUXB_delay = CASDOMUXB;
  assign #(in_delay) CASDOMUXEN_A_delay = CASDOMUXEN_A;
  assign #(in_delay) CASDOMUXEN_B_delay = CASDOMUXEN_B;
  assign #(in_delay) CASOREGIMUXA_delay = CASOREGIMUXA;
  assign #(in_delay) CASOREGIMUXB_delay = CASOREGIMUXB;
  assign #(in_delay) CASOREGIMUXEN_A_delay = CASOREGIMUXEN_A;
  assign #(in_delay) CASOREGIMUXEN_B_delay = CASOREGIMUXEN_B;
  assign #(in_delay) DINADIN_delay = DINADIN;
  assign #(in_delay) DINBDIN_delay = DINBDIN;
  assign #(in_delay) DINPADINP_delay = DINPADINP;
  assign #(in_delay) DINPBDINP_delay = DINPBDINP;
  assign #(in_delay) ENARDEN_delay = ENARDEN;
  assign #(in_delay) ENBWREN_delay = ENBWREN;
  assign #(in_delay) REGCEAREGCE_delay = REGCEAREGCE;
  assign #(in_delay) REGCEB_delay = REGCEB;
  assign #(in_delay) RSTRAMARSTRAM_delay = RSTRAMARSTRAM;
  assign #(in_delay) RSTRAMB_delay = RSTRAMB;
  assign #(in_delay) RSTREGARSTREG_delay = RSTREGARSTREG;
  assign #(in_delay) RSTREGB_delay = RSTREGB;
  assign #(in_delay) SLEEP_delay = SLEEP;
  assign #(in_delay) WEA_delay = WEA;
  assign #(in_delay) WEBWE_delay = WEBWE;
`endif //  `ifndef XIL_TIMING

  assign CASDOUTA_delay = CASDOUTA_out;
  assign CASDOUTB_delay = CASDOUTB_out;
  assign CASDOUTPA_delay = CASDOUTPA_out;
  assign CASDOUTPB_delay = CASDOUTPB_out;
  assign DOUTADOUT_delay = DOUTADOUT_out;
  assign DOUTBDOUT_delay = DOUTBDOUT_out;
  assign DOUTPADOUTP_delay = DOUTPADOUTP_out;
  assign DOUTPBDOUTP_delay = DOUTPBDOUTP_out;

  assign ADDRARDADDR_in = ADDRARDADDR_delay;
  assign ADDRBWRADDR_in = ADDRBWRADDR_delay;
  assign ADDRENA_in = (ENADDRENA_BIN == ENADDRENA_TRUE) ? ADDRENA_delay : 1'b1;
  assign ADDRENB_in = (ENADDRENB_BIN == ENADDRENB_TRUE) ? ADDRENB_delay : 1'b1;
  assign CASDIMUXA_in = CASDIMUXA_delay;
  assign CASDIMUXB_in = CASDIMUXB_delay;
  assign CASDINA_in = CASDINA_delay;
  assign CASDINB_in = CASDINB_delay;
  assign CASDINPA_in = CASDINPA_delay;
  assign CASDINPB_in = CASDINPB_delay;
  assign CASDOMUXA_in = CASDOMUXA_delay;
  assign CASDOMUXB_in = CASDOMUXB_delay;
  assign CASDOMUXEN_A_in = CASDOMUXEN_A_delay;
  assign CASDOMUXEN_B_in = CASDOMUXEN_B_delay;
  assign CASOREGIMUXA_in = CASOREGIMUXA_delay;
  assign CASOREGIMUXB_in = CASOREGIMUXB_delay;
  assign CASOREGIMUXEN_A_in = CASOREGIMUXEN_A_delay;
  assign CASOREGIMUXEN_B_in = CASOREGIMUXEN_B_delay;
  assign CLKARDCLK_in = CLKARDCLK_delay ^ IS_CLKARDCLK_INVERTED_BIN;
  assign CLKBWRCLK_in = CLKBWRCLK_delay ^ IS_CLKBWRCLK_INVERTED_BIN;
  assign DINPADINP_in = (((CASCADE_ORDER_A_BIN == CASCADE_ORDER_LAST) ||
                          (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) && CASDIMUXA_in) ?
                        CASDINPA_delay : DINPADINP_delay;
  assign DINADIN_in   = (((CASCADE_ORDER_A_BIN == CASCADE_ORDER_LAST) ||
                          (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) && CASDIMUXA_in) ?
                        CASDINA_delay : DINADIN_delay;
  assign DINPBDINP_in = (((CASCADE_ORDER_B_BIN == CASCADE_ORDER_LAST) ||
                          (CASCADE_ORDER_B_BIN == CASCADE_ORDER_MIDDLE)) && CASDIMUXB_in) ?
                        CASDINPB_delay : DINPBDINP_delay;
  assign DINBDIN_in   = (((CASCADE_ORDER_B_BIN == CASCADE_ORDER_LAST) ||
                          (CASCADE_ORDER_B_BIN == CASCADE_ORDER_MIDDLE)) && CASDIMUXB_in) ?
                        CASDINB_delay : DINBDIN_delay;
  assign ENARDEN_in = ENARDEN_delay ^ IS_ENARDEN_INVERTED_BIN;
  assign ENBWREN_in = ENBWREN_delay ^ IS_ENBWREN_INVERTED_BIN;
  assign REGCEAREGCE_in = REGCEAREGCE_delay;
  assign REGCEB_in = REGCEB_delay;
  assign RSTRAMARSTRAM_in = RSTRAMARSTRAM_delay ^ IS_RSTRAMARSTRAM_INVERTED_BIN;
  assign RSTRAMB_in = RSTRAMB_delay ^ IS_RSTRAMB_INVERTED_BIN;
  assign RSTREGARSTREG_in = RSTREGARSTREG_delay ^ IS_RSTREGARSTREG_INVERTED_BIN;
  assign RSTREGB_in = RSTREGB_delay ^ IS_RSTREGB_INVERTED_BIN;
  assign SLEEP_in = SLEEP_delay;
  assign WEA_in = WEA_delay;
  assign WEBWE_in = WEBWE_delay;

  localparam wr_loops_b = 
    (WRITE_WIDTH_B_REG == 0) ? WRITE_WIDTH_B_0 :
    (WRITE_WIDTH_B_REG == 1) ? WRITE_WIDTH_B_1 :
    (WRITE_WIDTH_B_REG == 2) ? WRITE_WIDTH_B_2 :
    (WRITE_WIDTH_B_REG == 4) ? WRITE_WIDTH_B_4 :
    (WRITE_WIDTH_B_REG == 9) ? WRITE_WIDTH_B_9 :
    (WRITE_WIDTH_B_REG == 18) ? WRITE_WIDTH_B_18 :
    (WRITE_WIDTH_B_REG == 36) ? WRITE_WIDTH_B_36 :
    WRITE_WIDTH_B_0;
   
  localparam WRITE_WIDTH_B_BIN = wr_loops_b;
   
  assign mem_rd_clk_a = CLKARDCLK_in;
  assign mem_rd_clk_b = sdp_mode ? 1'b0 : CLKBWRCLK_in;
  assign mem_wr_clk_a = sdp_mode ? 1'b0 : CLKARDCLK_in;
  assign mem_wr_clk_b = CLKBWRCLK_in;
  assign mem_rst_a = RSTRAMARSTRAM_in;
  assign mem_rst_b = sdp_mode ? RSTRAMARSTRAM_in : RSTRAMB_in;
  assign mem_wr_a = {16'h0, DINADIN_in};
  assign mem_wr_b = (WRITE_WIDTH_B_BIN != WRITE_WIDTH_B_36) ? {16'h0, DINBDIN_in} :
                    {DINBDIN_in, DINADIN_in};

  assign mem_wr_en_a  = sdp_mode ? 1'b0 : ENARDEN_in && |WEA_in;
  assign mem_rd_en_a  = (WRITE_MODE_A_BIN == WRITE_MODE_A_NO_CHANGE) ?
                        ENARDEN_in && (~mem_wr_en_a || mem_rst_a) : ENARDEN_in;
  assign mem_wr_en_b  = ENBWREN_in && (sdp_mode ? |WEBWE_in : |WEBWE_in[DP_WIDTH/2-1:0]);
  assign mem_rd_en_b  = sdp_mode ? 1'b0 :
                        (WRITE_MODE_B_BIN == WRITE_MODE_B_NO_CHANGE) ?
                        ENBWREN_in && (~mem_wr_en_b || mem_rst_b) : ENBWREN_in;

  assign memp_wr_b[3] = DINPBDINP_in[1];
  assign memp_wr_b[2] = DINPBDINP_in[0];
  assign memp_wr_b[1] = (WRITE_WIDTH_B_BIN == WRITE_WIDTH_B_36) ? DINPADINP_in[1] : DINPBDINP_in[1];
  assign memp_wr_b[0] = (WRITE_WIDTH_B_BIN == WRITE_WIDTH_B_36) ? DINPADINP_in[0] : DINPBDINP_in[0];
  assign memp_wr_a[3] = 1'b0;
  assign memp_wr_a[2] = 1'b0;
  assign memp_wr_a[1] = DINPADINP_in[1];
  assign memp_wr_a[0] = DINPADINP_in[0];


  assign CASCADE_ORDER_A_BIN = 
    (CASCADE_ORDER_A_REG == "NONE") ? CASCADE_ORDER_NONE :
    (CASCADE_ORDER_A_REG == "FIRST") ? CASCADE_ORDER_FIRST :
    (CASCADE_ORDER_A_REG == "LAST") ? CASCADE_ORDER_LAST :
    (CASCADE_ORDER_A_REG == "MIDDLE") ? CASCADE_ORDER_MIDDLE :
    CASCADE_ORDER_NONE;

  assign CASCADE_ORDER_B_BIN = 
    (CASCADE_ORDER_B_REG == "NONE") ? CASCADE_ORDER_NONE :
    (CASCADE_ORDER_B_REG == "FIRST") ? CASCADE_ORDER_FIRST :
    (CASCADE_ORDER_B_REG == "LAST") ? CASCADE_ORDER_LAST :
    (CASCADE_ORDER_B_REG == "MIDDLE") ? CASCADE_ORDER_MIDDLE :
    CASCADE_ORDER_NONE;

  assign CLOCK_DOMAINS_BIN = 
    (CLOCK_DOMAINS_REG == "INDEPENDENT") ? CLOCK_DOMAINS_INDEPENDENT :
    (CLOCK_DOMAINS_REG == "COMMON") ? CLOCK_DOMAINS_COMMON :
    CLOCK_DOMAINS_INDEPENDENT;

  assign DOA_REG_BIN = 
    (DOA_REG_REG == 1) ? DOA_REG_1 :
    (DOA_REG_REG == 0) ? DOA_REG_0 :
    DOA_REG_1;

  assign DOB_REG_BIN = 
    (DOB_REG_REG == 1) ? DOB_REG_1 :
    (DOB_REG_REG == 0) ? DOB_REG_0 :
    DOB_REG_1;

  assign ENADDRENA_BIN = 
    (ENADDRENA_REG == "FALSE") ? ENADDRENA_FALSE :
    (ENADDRENA_REG == "TRUE") ? ENADDRENA_TRUE :
    ENADDRENA_FALSE;

  assign ENADDRENB_BIN = 
    (ENADDRENB_REG == "FALSE") ? ENADDRENB_FALSE :
    (ENADDRENB_REG == "TRUE") ? ENADDRENB_TRUE :
    ENADDRENB_FALSE;

  assign INITP_BIN['h00] = INITP_00_REG;

  assign INITP_BIN['h01] = INITP_01_REG;

  assign INITP_BIN['h02] = INITP_02_REG;

  assign INITP_BIN['h03] = INITP_03_REG;

  assign INITP_BIN['h04] = INITP_04_REG;

  assign INITP_BIN['h05] = INITP_05_REG;

  assign INITP_BIN['h06] = INITP_06_REG;

  assign INITP_BIN['h07] = INITP_07_REG;

  assign INIT_BIN['h00] = INIT_00_REG;

  assign INIT_BIN['h01] = INIT_01_REG;

  assign INIT_BIN['h02] = INIT_02_REG;

  assign INIT_BIN['h03] = INIT_03_REG;

  assign INIT_BIN['h04] = INIT_04_REG;

  assign INIT_BIN['h05] = INIT_05_REG;

  assign INIT_BIN['h06] = INIT_06_REG;

  assign INIT_BIN['h07] = INIT_07_REG;

  assign INIT_BIN['h08] = INIT_08_REG;

  assign INIT_BIN['h09] = INIT_09_REG;

  assign INIT_BIN['h0A] = INIT_0A_REG;

  assign INIT_BIN['h0B] = INIT_0B_REG;

  assign INIT_BIN['h0C] = INIT_0C_REG;

  assign INIT_BIN['h0D] = INIT_0D_REG;

  assign INIT_BIN['h0E] = INIT_0E_REG;

  assign INIT_BIN['h0F] = INIT_0F_REG;

  assign INIT_BIN['h10] = INIT_10_REG;

  assign INIT_BIN['h11] = INIT_11_REG;

  assign INIT_BIN['h12] = INIT_12_REG;

  assign INIT_BIN['h13] = INIT_13_REG;

  assign INIT_BIN['h14] = INIT_14_REG;

  assign INIT_BIN['h15] = INIT_15_REG;

  assign INIT_BIN['h16] = INIT_16_REG;

  assign INIT_BIN['h17] = INIT_17_REG;

  assign INIT_BIN['h18] = INIT_18_REG;

  assign INIT_BIN['h19] = INIT_19_REG;

  assign INIT_BIN['h1A] = INIT_1A_REG;

  assign INIT_BIN['h1B] = INIT_1B_REG;

  assign INIT_BIN['h1C] = INIT_1C_REG;

  assign INIT_BIN['h1D] = INIT_1D_REG;

  assign INIT_BIN['h1E] = INIT_1E_REG;

  assign INIT_BIN['h1F] = INIT_1F_REG;

  assign INIT_BIN['h20] = INIT_20_REG;

  assign INIT_BIN['h21] = INIT_21_REG;

  assign INIT_BIN['h22] = INIT_22_REG;

  assign INIT_BIN['h23] = INIT_23_REG;

  assign INIT_BIN['h24] = INIT_24_REG;

  assign INIT_BIN['h25] = INIT_25_REG;

  assign INIT_BIN['h26] = INIT_26_REG;

  assign INIT_BIN['h27] = INIT_27_REG;

  assign INIT_BIN['h28] = INIT_28_REG;

  assign INIT_BIN['h29] = INIT_29_REG;

  assign INIT_BIN['h2A] = INIT_2A_REG;

  assign INIT_BIN['h2B] = INIT_2B_REG;

  assign INIT_BIN['h2C] = INIT_2C_REG;

  assign INIT_BIN['h2D] = INIT_2D_REG;

  assign INIT_BIN['h2E] = INIT_2E_REG;

  assign INIT_BIN['h2F] = INIT_2F_REG;

  assign INIT_BIN['h30] = INIT_30_REG;

  assign INIT_BIN['h31] = INIT_31_REG;

  assign INIT_BIN['h32] = INIT_32_REG;

  assign INIT_BIN['h33] = INIT_33_REG;

  assign INIT_BIN['h34] = INIT_34_REG;

  assign INIT_BIN['h35] = INIT_35_REG;

  assign INIT_BIN['h36] = INIT_36_REG;

  assign INIT_BIN['h37] = INIT_37_REG;

  assign INIT_BIN['h38] = INIT_38_REG;

  assign INIT_BIN['h39] = INIT_39_REG;

  assign INIT_BIN['h3A] = INIT_3A_REG;

  assign INIT_BIN['h3B] = INIT_3B_REG;

  assign INIT_BIN['h3C] = INIT_3C_REG;

  assign INIT_BIN['h3D] = INIT_3D_REG;

  assign INIT_BIN['h3E] = INIT_3E_REG;

  assign INIT_BIN['h3F] = INIT_3F_REG;

  assign INIT_A_BIN = INIT_A_REG;

  assign INIT_B_BIN = INIT_B_REG;

//  assign INIT_FILE_BIN = 
//    (INIT_FILE_REG == "NONE") ? INIT_FILE_NONE :
//    INIT_FILE_NONE;

  assign IS_CLKARDCLK_INVERTED_BIN = IS_CLKARDCLK_INVERTED_REG;

  assign IS_CLKBWRCLK_INVERTED_BIN = IS_CLKBWRCLK_INVERTED_REG;

  assign IS_ENARDEN_INVERTED_BIN = IS_ENARDEN_INVERTED_REG;

  assign IS_ENBWREN_INVERTED_BIN = IS_ENBWREN_INVERTED_REG;

  assign IS_RSTRAMARSTRAM_INVERTED_BIN = IS_RSTRAMARSTRAM_INVERTED_REG;

  assign IS_RSTRAMB_INVERTED_BIN = IS_RSTRAMB_INVERTED_REG;

  assign IS_RSTREGARSTREG_INVERTED_BIN = IS_RSTREGARSTREG_INVERTED_REG;

  assign IS_RSTREGB_INVERTED_BIN = IS_RSTREGB_INVERTED_REG;

  assign RDADDRCHANGEA_BIN = 
    (RDADDRCHANGEA_REG == "FALSE") ? RDADDRCHANGEA_FALSE :
    (RDADDRCHANGEA_REG == "TRUE") ? RDADDRCHANGEA_TRUE :
    RDADDRCHANGEA_FALSE;

  assign RDADDRCHANGEB_BIN = 
    (RDADDRCHANGEB_REG == "FALSE") ? RDADDRCHANGEB_FALSE :
    (RDADDRCHANGEB_REG == "TRUE") ? RDADDRCHANGEB_TRUE :
    RDADDRCHANGEB_FALSE;

  localparam rd_loops_a = 
    (READ_WIDTH_A_REG == 0) ? READ_WIDTH_A_0 :
    (READ_WIDTH_A_REG == 1) ? READ_WIDTH_A_1 :
    (READ_WIDTH_A_REG == 2) ? READ_WIDTH_A_2 :
    (READ_WIDTH_A_REG == 4) ? READ_WIDTH_A_4 :
    (READ_WIDTH_A_REG == 9) ? READ_WIDTH_A_9 :
    (READ_WIDTH_A_REG == 18) ? READ_WIDTH_A_18 :
    (READ_WIDTH_A_REG == 36) ? READ_WIDTH_A_36 :
    READ_WIDTH_A_0;

  localparam READ_WIDTH_A_BIN = rd_loops_a;
   
  localparam rd_loops_b = 
    (READ_WIDTH_B_REG == 0) ? READ_WIDTH_B_0 :
    (READ_WIDTH_B_REG == 1) ? READ_WIDTH_B_1 :
    (READ_WIDTH_B_REG == 2) ? READ_WIDTH_B_2 :
    (READ_WIDTH_B_REG == 4) ? READ_WIDTH_B_4 :
    (READ_WIDTH_B_REG == 9) ? READ_WIDTH_B_9 :
    (READ_WIDTH_B_REG == 18) ? READ_WIDTH_B_18 :
    READ_WIDTH_B_0;

  localparam READ_WIDTH_B_BIN = rd_loops_b;

  localparam rd_memp_loops_a = 
    (READ_WIDTH_A_REG == 0) ? 1 :
    (READ_WIDTH_A_REG == 1) ? 1 :
    (READ_WIDTH_A_REG == 2) ? 1 :
    (READ_WIDTH_A_REG == 4) ? 1 :
    (READ_WIDTH_A_REG == 9) ? 1 :
    (READ_WIDTH_A_REG == 18) ? 2 :
    (READ_WIDTH_A_REG == 36) ? 4 : 1;
   
  localparam rd_memp_loops_b = 
    (READ_WIDTH_B_REG == 0) ? 1 :
    (READ_WIDTH_B_REG == 1) ? 1 :
    (READ_WIDTH_B_REG == 2) ? 1 :
    (READ_WIDTH_B_REG == 4) ? 1 :
    (READ_WIDTH_B_REG == 9) ? 1 :
    (READ_WIDTH_B_REG == 18) ? 2 : 1;

   
  assign RSTREG_PRIORITY_A_BIN = 
    (RSTREG_PRIORITY_A_REG == "RSTREG") ? RSTREG_PRIORITY_A_RSTREG :
    (RSTREG_PRIORITY_A_REG == "REGCE") ? RSTREG_PRIORITY_A_REGCE :
    RSTREG_PRIORITY_A_RSTREG;

  assign RSTREG_PRIORITY_B_BIN = 
    (RSTREG_PRIORITY_B_REG == "RSTREG") ? RSTREG_PRIORITY_B_RSTREG :
    (RSTREG_PRIORITY_B_REG == "REGCE") ? RSTREG_PRIORITY_B_REGCE :
    RSTREG_PRIORITY_B_RSTREG;

  assign SIM_COLLISION_CHECK_BIN = 
    (SIM_COLLISION_CHECK_REG == "ALL") ? SIM_COLLISION_CHECK_ALL :
    (SIM_COLLISION_CHECK_REG == "GENERATE_X_ONLY") ? SIM_COLLISION_CHECK_GENERATE_X_ONLY :
    (SIM_COLLISION_CHECK_REG == "NONE") ? SIM_COLLISION_CHECK_NONE :
    (SIM_COLLISION_CHECK_REG == "WARNING_ONLY") ? SIM_COLLISION_CHECK_WARNING_ONLY :
    SIM_COLLISION_CHECK_ALL;

  assign SLEEP_ASYNC_BIN = 
    (SLEEP_ASYNC_REG == "FALSE") ? SLEEP_ASYNC_FALSE :
    (SLEEP_ASYNC_REG == "TRUE") ? SLEEP_ASYNC_TRUE :
    SLEEP_ASYNC_FALSE;

  assign SRVAL_A_BIN = SRVAL_A_REG;

  assign SRVAL_B_BIN = SRVAL_B_REG;

  assign WRITE_MODE_A_BIN = 
    (WRITE_MODE_A_REG == "NO_CHANGE") ? WRITE_MODE_A_NO_CHANGE :
    (WRITE_MODE_A_REG == "READ_FIRST") ? WRITE_MODE_A_READ_FIRST :
    (WRITE_MODE_A_REG == "WRITE_FIRST") ? WRITE_MODE_A_WRITE_FIRST :
    WRITE_MODE_A_NO_CHANGE;

  assign WRITE_MODE_B_BIN = 
    (WRITE_MODE_B_REG == "NO_CHANGE") ? WRITE_MODE_B_NO_CHANGE :
    (WRITE_MODE_B_REG == "READ_FIRST") ? WRITE_MODE_B_READ_FIRST :
    (WRITE_MODE_B_REG == "WRITE_FIRST") ? WRITE_MODE_B_WRITE_FIRST :
    WRITE_MODE_B_NO_CHANGE;

  localparam wr_loops_a = 
    (WRITE_WIDTH_A_REG == 0) ? WRITE_WIDTH_A_0 :
    (WRITE_WIDTH_A_REG == 1) ? WRITE_WIDTH_A_1 :
    (WRITE_WIDTH_A_REG == 2) ? WRITE_WIDTH_A_2 :
    (WRITE_WIDTH_A_REG == 4) ? WRITE_WIDTH_A_4 :
    (WRITE_WIDTH_A_REG == 9) ? WRITE_WIDTH_A_9 :
    (WRITE_WIDTH_A_REG == 18) ? WRITE_WIDTH_A_18 :
    WRITE_WIDTH_A_0;

  localparam WRITE_WIDTH_A_BIN = wr_loops_a;
   
  localparam rd_addr_a_mask = 
    (READ_WIDTH_A_REG == 0) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3f} :
    (READ_WIDTH_A_REG == 1) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3f} :
    (READ_WIDTH_A_REG == 2) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3e} :
    (READ_WIDTH_A_REG == 4) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3c} :
    (READ_WIDTH_A_REG == 9) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h38} :
    (READ_WIDTH_A_REG == 18) ? {{ADDR_WIDTH-6{1'b1}}, 6'h30} :
    (READ_WIDTH_A_REG == 36) ? {{ADDR_WIDTH-6{1'b1}}, 6'h20} :
    {{ADDR_WIDTH-6{1'b1}}, 6'h3f};

  localparam rd_addr_b_mask = 
    (READ_WIDTH_B_REG == 0) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3f} :
    (READ_WIDTH_B_REG == 1) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3f} :
    (READ_WIDTH_B_REG == 2) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3e} :
    (READ_WIDTH_B_REG == 4) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3c} :
    (READ_WIDTH_B_REG == 9) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h38} :
    (READ_WIDTH_B_REG == 18) ? {{ADDR_WIDTH-6{1'b1}}, 6'h30} :
    (READ_WIDTH_B_REG == 36) ? {{ADDR_WIDTH-6{1'b1}}, 6'h20} :
    {{ADDR_WIDTH-6{1'b1}}, 6'h3f};

  localparam wr_addr_a_mask = 
    (WRITE_WIDTH_A_REG == 0) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3f} :
    (WRITE_WIDTH_A_REG == 1) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3f} :
    (WRITE_WIDTH_A_REG == 2) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3e} :
    (WRITE_WIDTH_A_REG == 4) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3c} :
    (WRITE_WIDTH_A_REG == 9) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h38} :
    (WRITE_WIDTH_A_REG == 18) ? {{ADDR_WIDTH-6{1'b1}}, 6'h30} :
    (WRITE_WIDTH_A_REG == 36) ? {{ADDR_WIDTH-6{1'b1}}, 6'h20} :
    {{ADDR_WIDTH-6{1'b1}}, 6'h3f};

  localparam wr_addr_b_mask = 
    (WRITE_WIDTH_B_REG == 0) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3f} :
    (WRITE_WIDTH_B_REG == 1) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3f} :
    (WRITE_WIDTH_B_REG == 2) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3e} :
    (WRITE_WIDTH_B_REG == 4) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3c} :
    (WRITE_WIDTH_B_REG == 9) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h38} :
    (WRITE_WIDTH_B_REG == 18) ? {{ADDR_WIDTH-6{1'b1}}, 6'h30} :
    (WRITE_WIDTH_B_REG == 36) ? {{ADDR_WIDTH-6{1'b1}}, 6'h20} :
    {{ADDR_WIDTH-6{1'b1}}, 6'h3f};

    always @ (posedge mem_rd_clk_a) begin
      if (glblGSR) begin
          SLEEP_reg <= 1'b0;
          SLEEP_reg1 <= 1'b0;
      end
      else begin
          SLEEP_reg <= SLEEP_in;
          SLEEP_reg1 <= SLEEP_reg;
      end
    end

    assign SLEEP_int = (SLEEP_ASYNC_BIN == SLEEP_ASYNC_FALSE) ? SLEEP_reg : SLEEP_in;

    assign sdp_mode_wr = (WRITE_WIDTH_B_BIN == WRITE_WIDTH_B_36) ? 1'b1 : 1'b0;
    assign sdp_mode_rd = (READ_WIDTH_A_BIN == READ_WIDTH_A_36) ? 1'b1 : 1'b0;
   assign sdp_mode = sdp_mode_rd || sdp_mode_wr;
   assign REGCE_A_int  = REGCEAREGCE_in;
   assign REGCE_B_int  = REGCEB_in;
   assign RSTREG_A_int = (RSTREG_PRIORITY_A_BIN == RSTREG_PRIORITY_A_RSTREG) ?
                         RSTREGARSTREG_in : (RSTREGARSTREG_in && REGCEAREGCE_in);
   assign RSTREG_B_int = (RSTREG_PRIORITY_B_BIN == RSTREG_PRIORITY_B_RSTREG) ?
                         RSTREGB_in : (RSTREGB_in && REGCEB_in);
   assign DOUTADOUT_out  = (((CASCADE_ORDER_A_BIN == CASCADE_ORDER_LAST) ||
                            (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) && CASDOMUXA_reg) ?
                           CASDINA_in  : (mem_a_mux ^ mem_rm_douta);
   assign DOUTPADOUTP_out = (((CASCADE_ORDER_A_BIN == CASCADE_ORDER_LAST) ||
                            (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) && CASDOMUXA_reg) ?
                           CASDINPA_in : (memp_a_mux ^ memp_rm_douta);
   assign DOUTBDOUT_out  = (((CASCADE_ORDER_B_BIN == CASCADE_ORDER_LAST) ||
                            (CASCADE_ORDER_B_BIN == CASCADE_ORDER_MIDDLE)) && CASDOMUXB_int) ?
                           CASDINB_in  : (mem_b_mux ^ mem_rm_doutb);
   assign DOUTPBDOUTP_out = (((CASCADE_ORDER_B_BIN == CASCADE_ORDER_LAST) ||
                            (CASCADE_ORDER_B_BIN == CASCADE_ORDER_MIDDLE)) && CASDOMUXB_int) ?
                           CASDINPB_in : (memp_b_mux ^ memp_rm_doutb);

   assign mem_a_mux  = (DOA_REG_BIN == DOA_REG_1) ? mem_a_reg : mem_a_out;
   assign memp_a_mux = (DOA_REG_BIN == DOA_REG_1) ? memp_a_reg : memp_a_out;

   assign mem_a_out  = mem_wr_en_a_wf ? mem_rd_a_wf  : mem_a_lat;
   assign memp_a_out = mem_wr_en_a_wf ? memp_rd_a_wf : memp_a_lat;

   assign mem_b_out  = mem_wr_en_b_wf ? mem_rd_b_wf  : mem_b_lat;
   assign memp_b_out = mem_wr_en_b_wf ? memp_rd_b_wf : memp_b_lat;

   assign mem_b_mux =  sdp_mode_rd ?
                      ((DOA_REG_BIN == DOA_REG_1) ? mem_a_reg[31:16] : mem_a_out[31:16]) :
                      ((DOB_REG_BIN == DOB_REG_1) ? mem_b_reg : mem_b_out);
   assign memp_b_mux = sdp_mode_rd ?
                      ((DOA_REG_BIN == DOA_REG_1) ? memp_a_reg[3:2] : memp_a_out[3:2]) :
                      ((DOB_REG_BIN == DOB_REG_1) ? memp_b_reg : memp_b_out);
   assign INIT_A_int =
    (READ_WIDTH_A_BIN <= READ_WIDTH_A_9)  ? {{4{INIT_A_BIN[8]}}, {4{INIT_A_BIN[7:0]}}} :
    (READ_WIDTH_A_BIN == READ_WIDTH_A_18) ? {{2{INIT_A_BIN[17:16]}}, {2{INIT_A_BIN[15:0]}}} :
          {INIT_B_BIN[17:16],INIT_A_BIN[17:16],INIT_B_BIN[15:0],INIT_A_BIN[15:0]};

   assign INIT_B_int =
    (READ_WIDTH_B_BIN <= READ_WIDTH_B_9)  ? {{2{INIT_B_BIN[8]}}, {2{INIT_B_BIN[7:0]}}} :
                                            INIT_B_BIN;

   assign SRVAL_A_int =
    (READ_WIDTH_A_BIN <= READ_WIDTH_A_9)  ? {{4{SRVAL_A_BIN[8]}}, {4{SRVAL_A_BIN[7:0]}}} :
    (READ_WIDTH_A_BIN == READ_WIDTH_A_18) ? {{2{SRVAL_A_BIN[17:16]}}, {2{SRVAL_A_BIN[15:0]}}} :
          {SRVAL_B_BIN[17:16],SRVAL_A_BIN[17:16],SRVAL_B_BIN[15:0],SRVAL_A_BIN[15:0]};
   assign SRVAL_B_int =
    (READ_WIDTH_B_BIN <= READ_WIDTH_B_9)  ? {{2{SRVAL_B_BIN[8]}}, {2{SRVAL_B_BIN[7:0]}}} :
                                            SRVAL_B_BIN;
// cascade out
   assign CASDOUTA_out  = ((CASCADE_ORDER_A_BIN == CASCADE_ORDER_FIRST) ||
                           (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) ?
                          DOUTADOUT_out : {D_WIDTH-1{1'b0}};
   assign CASDOUTPA_out = ((CASCADE_ORDER_A_BIN == CASCADE_ORDER_FIRST) ||
                           (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) ?
                          DOUTPADOUTP_out : {DP_WIDTH-1{1'b0}};
   assign CASDOUTB_out  = ((CASCADE_ORDER_B_BIN == CASCADE_ORDER_FIRST) ||
                           (CASCADE_ORDER_B_BIN == CASCADE_ORDER_MIDDLE)) ?
                          DOUTBDOUT_out : {D_WIDTH-1{1'b0}};
   assign CASDOUTPB_out = ((CASCADE_ORDER_B_BIN == CASCADE_ORDER_FIRST) ||
                           (CASCADE_ORDER_B_BIN == CASCADE_ORDER_MIDDLE)) ?
                          DOUTPBDOUTP_out : {DP_WIDTH-1{1'b0}};
// start model internals

// cascade control
   always @ (posedge mem_rd_clk_a) begin
      if (glblGSR) CASDOMUXA_reg <= 1'b0;
      else if (CASDOMUXEN_A_in == 1'b1) CASDOMUXA_reg <= CASDOMUXA_in;
      end

   always @ (posedge mem_rd_clk_a) begin
      if (glblGSR) CASOREGIMUXA_reg <= 1'b0;
      else if (CASOREGIMUXEN_A_in == 1'b1) CASOREGIMUXA_reg <= CASOREGIMUXA_in;
      end

   assign CASDOMUXB_int = (READ_WIDTH_A_BIN == READ_WIDTH_A_36) ?
                          CASDOMUXA_reg : CASDOMUXB_reg;
   always @ (posedge mem_rd_clk_b) begin
      if (glblGSR) CASDOMUXB_reg <= 1'b0;
      else if (CASDOMUXEN_B_in == 1'b1) CASDOMUXB_reg <= CASDOMUXB_in;
      end

   always @ (posedge mem_rd_clk_b) begin
      if (glblGSR) CASOREGIMUXB_reg <= 1'b0;
      else if (CASOREGIMUXEN_B_in == 1'b1) CASOREGIMUXB_reg <= CASOREGIMUXB_in;
      end


// output register
   assign mem_a_reg_mux  = (((CASCADE_ORDER_A_BIN == CASCADE_ORDER_LAST) ||
                             (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) &&
                            CASOREGIMUXA_reg) ? {CASDINB_in, CASDINA_in}  : mem_a_out;
   assign memp_a_reg_mux = (((CASCADE_ORDER_A_BIN == CASCADE_ORDER_LAST) ||
                             (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) &&
                            CASOREGIMUXA_reg) ? {CASDINPB_in, CASDINPA_in} : memp_a_out;

   always @ (posedge mem_rd_clk_a) begin
      if (RSTREG_A_int) begin
         {memp_a_reg, mem_a_reg} <= SRVAL_A_int;
         end
      else if (REGCE_A_int) begin
         mem_a_reg <= mem_a_reg_mux;
         memp_a_reg <= memp_a_reg_mux;
         end
      end

   assign mem_b_reg_mux  = (((CASCADE_ORDER_B_BIN == CASCADE_ORDER_LAST) ||
                             (CASCADE_ORDER_B_BIN == CASCADE_ORDER_MIDDLE)) &&
                            CASOREGIMUXB_reg) ? CASDINB_in  : mem_b_out;
   assign memp_b_reg_mux = (((CASCADE_ORDER_B_BIN == CASCADE_ORDER_LAST) ||
                             (CASCADE_ORDER_B_BIN == CASCADE_ORDER_MIDDLE)) &&
                            CASOREGIMUXB_reg) ? CASDINPB_in : memp_b_out;

   always @ (posedge mem_rd_clk_b) begin
      if (RSTREG_B_int) begin
         {memp_b_reg, mem_b_reg} <= SRVAL_B_int;
         end
      else if (REGCE_B_int) begin
         mem_b_reg <= mem_b_reg_mux;
         memp_b_reg <= memp_b_reg_mux;
         end
      end

// read engine
   always @ (posedge mem_wr_clk_a) begin
     if ((WRITE_MODE_A_BIN == WRITE_MODE_A_WRITE_FIRST) && mem_rd_en_a) begin
       mem_wr_en_a_wf <= mem_wr_en_a && ~mem_rst_a;
     end
   end

   always @ (posedge mem_wr_clk_b) begin
     if ((WRITE_MODE_B_BIN == WRITE_MODE_B_WRITE_FIRST) && mem_rd_en_b) begin
       mem_wr_en_b_wf <= mem_wr_en_b && ~mem_rst_b;
     end
   end

   always @ (wr_a_event) begin
      mem_rd_a_wf <= mem [rd_addr_a +: rd_loops_a];
      memp_rd_a_wf <= memp [(rd_addr_a/8) +: rd_memp_loops_a];
   end
   
   always @ (rd_addr_a or mem_rd_en_a or mem_rst_a or wr_a_event or wr_b_event) begin
      if (mem_rd_en_a && ~mem_rst_a) begin
            mem_rd_a <= mem [rd_addr_a +: rd_loops_a];
            memp_rd_a <= memp [(rd_addr_a/8) +: rd_memp_loops_a];
      end
   end

   always @(posedge mem_rd_clk_a) begin
      if (mem_rst_a && mem_rd_en_a) begin
         mem_a_lat[0 +: rd_loops_a] <= SRVAL_A_int[0 +: rd_loops_a];
         memp_a_lat[0 +: rd_memp_loops_a]  <= SRVAL_A_int[D_WIDTH +: rd_memp_loops_a];
      end
      else if (mem_rd_en_a) begin
         mem_a_lat  <= mem_rd_a;
         memp_a_lat <= memp_rd_a;
      end
   end
   
   always @(wr_b_event) begin
      mem_rd_b_wf <= mem [rd_addr_b +: rd_loops_b];
      memp_rd_b_wf <= memp [rd_addr_b/8 +: rd_memp_loops_b];
   end

   always @ (rd_addr_b or mem_rd_en_b or mem_rst_b or wr_b_event or wr_a_event) begin
      if (mem_rd_en_b && ~mem_rst_b) begin
         mem_rd_b <= mem [rd_addr_b +: rd_loops_b];
         memp_rd_b <= memp [(rd_addr_b/8) +: rd_memp_loops_b];
      end
   end


   always @(posedge mem_rd_clk_b) begin
      if (mem_rst_b && mem_rd_en_b) begin
   mem_b_lat[0 +: rd_loops_b] <= SRVAL_B_int[0 +: rd_loops_b];
   memp_b_lat[0 +: rd_memp_loops_b]  <= SRVAL_B_int[D_WIDTH/2 +: rd_memp_loops_b];
      end
      else if (mem_rd_en_b) begin
        mem_b_lat <= mem_rd_b[D_WIDTH/2-1:0];
        memp_b_lat <= memp_rd_b[DP_WIDTH/2-1:0];
      end
   end

// write engine
   always @ (posedge mem_wr_clk_a) begin
      if (mem_wr_en_a) begin
         for (wa=0;wa<rd_loops_a;wa=wa+1) begin
           mem_rd_a_rf[wa]    <= mem [rd_addr_a+wa];
           if (wa<rd_loops_a/8) begin
               memp_rd_a_rf[wa]        <= memp [rd_addr_a/8+wa];
           end
         end
         for (wa=0;wa<wr_loops_a;wa=wa+1) begin
           if (mem_we_a[wa]) begin
             mem [wr_addr_a+wa] <= mem_wr_a[wa];
           end
           if (wa<wr_loops_a/8) begin
             if (memp_we_a[wa]) begin
               memp [(wr_addr_a/8)+wa] <= memp_wr_a[wa];
             end
           end
         end
         wr_a_event <= ~wr_a_event;
      end // if (mem_wr_en_a)
   end // always @ (posedge mem_wr_clk_a)
   

   initial begin
   // initialize memory
      for (j=0;j<128;j=j+1) begin
    mem [j*256 +: 256] <= INIT_BIN[j];
      end
      
   // initialize memory p
      for (j=0;j<16;j=j+1) begin
          memp [j*256 +: 256] <= INITP_BIN[j];
      end
   end // initial begin

   
   always @ (posedge mem_wr_clk_b) begin
      if (mem_wr_en_b) begin
         for (wb=0;wb<rd_loops_b;wb=wb+1) begin
           mem_rd_b_rf[wb]    <= mem [rd_addr_b+wb];
           if (wb<rd_loops_b/8) begin
               memp_rd_b_rf[wb]        <= memp [rd_addr_b/8+wb];
           end
         end
         for (wb=0;wb<wr_loops_b;wb=wb+1) begin
           if (mem_we_b[wb]) begin
             mem [wr_addr_b+wb] <= mem_wr_b[wb];
           end
           if (wb<wr_loops_b/8) begin
             if (memp_we_b[wb]) begin
               memp [(wr_addr_b/8)+wb] <= memp_wr_b[wb];
             end
           end
         end
         wr_b_event <= ~wr_b_event;
       end
   end // always @ (posedge mem_wr_clk_b)
   

  assign mem_rm_douta = sdp_mode_rd ? {D_WIDTH{1'b0}} : {D_WIDTH{1'b0}}<<rd_loops_a;
  assign memp_rm_douta = sdp_mode_rd ? {DP_WIDTH{1'b0}} : {DP_WIDTH{1'b0}}<<rd_loops_a/8;
  assign mem_rm_doutb = sdp_mode_rd ? {D_WIDTH/2{1'b0}} : {D_WIDTH{1'b0}}<<rd_loops_b;
  assign memp_rm_doutb = sdp_mode_rd ? {DP_WIDTH/2{1'b0}} : {DP_WIDTH/2{1'b0}}<<rd_loops_b/8;
  always @(ADDRARDADDR_in or CLKARDCLK_in or ADDRENA_in) begin
    if (CLKARDCLK_in == 1'b0 && ADDRENA_in == 1'b1) begin
      rd_addr_a = ADDRARDADDR_in & rd_addr_a_mask;
      wr_addr_a = ADDRARDADDR_in & wr_addr_a_mask;
    end
  end

  always @(ADDRBWRADDR_in or CLKBWRCLK_in or ADDRENB_in) begin
    if (CLKBWRCLK_in == 1'b0 && ADDRENB_in == 1'b1) begin
      rd_addr_b = ADDRBWRADDR_in & rd_addr_b_mask;
      wr_addr_b = ADDRBWRADDR_in & wr_addr_b_mask;
    end
  end

  assign mem_rm_a = {D_WIDTH{1'b1}}>>(max_rd_loops-rd_loops_a);
  assign mem_rm_b = {D_WIDTH{1'b1}}>>(max_rd_loops-rd_loops_b);
  assign mem_wm_a = {D_WIDTH{1'b1}}>>(max_wr_loops-wr_loops_a);
  assign mem_wm_b = {D_WIDTH{1'b1}}>>(max_wr_loops-wr_loops_b);
  assign wr_a_rd_b_addr_coll = ~sdp_mode && ((wr_addr_a & rd_addr_b_mask) == (rd_addr_b & wr_addr_a_mask)) && mem_wr_en_a && mem_rd_en_b && ~mem_wr_en_b;
  assign wr_addr_coll = ~sdp_mode && ((wr_addr_a & wr_addr_b_mask) == (wr_addr_b & wr_addr_a_mask)) && mem_wr_en_b && mem_wr_en_a;
  assign wr_b_rd_a_addr_coll = ((wr_addr_b & rd_addr_a_mask) == (rd_addr_a & wr_addr_b_mask)) && mem_wr_en_b && mem_rd_en_a && ~mem_wr_en_a;

  assign mem_we_a = {{D_WIDTH/2{1'b0}},{8{WEA_in[1]}},{8{WEA_in[0]}}} & ({D_WIDTH{1'b1}}>>(max_wr_loops-wr_loops_a));
  assign mem_we_b = {{8{WEBWE_in[3]}},{8{WEBWE_in[2]}},{8{WEBWE_in[1]}},{8{WEBWE_in[0]}}} & ({D_WIDTH{1'b1}}>>(max_wr_loops-wr_loops_b));
  assign memp_we_a = (WRITE_WIDTH_A_BIN > WRITE_WIDTH_A_4) ? {2'b0,WEA_in} : 4'b0;
  assign memp_we_b = (WRITE_WIDTH_B_BIN > WRITE_WIDTH_B_4) ? WEBWE_in : 4'b0;


endmodule

`endcelldefine
