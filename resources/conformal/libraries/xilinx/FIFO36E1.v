///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /
// /___/   /\     Filename : FIFO36E1.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/28/09 - Initial version.
//    08/16/13 - Added invertible pins support (CR 715417).
//    10/31/14 - Added inverter functionality for IS_*_INVERTED parameter (CR 828995).
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module FIFO36E1 (ALMOSTEMPTY, ALMOSTFULL, DBITERR, DO, DOP, ECCPARITY, EMPTY, FULL, RDCOUNT, RDERR, SBITERR, WRCOUNT, WRERR,
         DI, DIP, INJECTDBITERR, INJECTSBITERR, RDCLK, RDEN, REGCE, RST, RSTREG, WRCLK, WREN);

    parameter ALMOST_EMPTY_OFFSET = 13'h0080;
    parameter ALMOST_FULL_OFFSET = 13'h0080;
    parameter integer DATA_WIDTH = 4;
    parameter integer DO_REG = 1;
    parameter EN_ECC_READ = "FALSE";
    parameter EN_ECC_WRITE = "FALSE";
    parameter EN_SYN = "FALSE";
    parameter FIFO_MODE = "FIFO36";
    parameter FIRST_WORD_FALL_THROUGH = "FALSE";
    parameter INIT = 72'h0;
    parameter SIM_DEVICE = "VIRTEX6";
    parameter SRVAL = 72'h0;
    parameter IS_RDCLK_INVERTED = 1'b0;
    parameter IS_RDEN_INVERTED = 1'b0;
    parameter IS_RSTREG_INVERTED = 1'b0;
    parameter IS_RST_INVERTED = 1'b0;
    parameter IS_WRCLK_INVERTED = 1'b0;
    parameter IS_WREN_INVERTED = 1'b0;
   
`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif
    
    output ALMOSTEMPTY;
    output ALMOSTFULL;
    output DBITERR;
    output [63:0] DO;
    output [7:0] DOP;
    output [7:0] ECCPARITY;
    output EMPTY;
    output FULL;
    output [12:0] RDCOUNT;
    output RDERR;
    output SBITERR;
    output [12:0] WRCOUNT;
    output WRERR;

    input [63:0] DI;
    input [7:0] DIP;
    input INJECTDBITERR;
    input INJECTSBITERR;
    input RDCLK;
    input RDEN;
    input REGCE;
    input RST;
    input RSTREG;
    input WRCLK;
    input WREN;
    
   wire RDCLK_in;
   wire RDEN_in;
   wire RSTREG_in;
   wire RST_in;
   wire WRCLK_in;
   wire WREN_in;
   
   assign RDCLK_in = RDCLK ^ IS_RDCLK_INVERTED;
   assign RDEN_in = RDEN ^ IS_RDEN_INVERTED;
   assign RSTREG_in = RSTREG ^ IS_RSTREG_INVERTED;
   assign RST_in = RST ^ IS_RST_INVERTED;
   assign WRCLK_in = WRCLK ^ IS_WRCLK_INVERTED;
   assign WREN_in = WREN ^ IS_WREN_INVERTED;
   
   FIFO36E1_bb inst_bb (
            .ALMOSTEMPTY(ALMOSTEMPTY),
            .ALMOSTFULL(ALMOSTFULL),
            .DBITERR(DBITERR),
            .DO(DO),
            .DOP(DOP),
            .ECCPARITY(ECCPARITY),
            .EMPTY(EMPTY),
            .FULL(FULL),
            .RDCOUNT(RDCOUNT),
            .RDERR(RDERR),
            .SBITERR(SBITERR),
            .WRCOUNT(WRCOUNT),
            .WRERR(WRERR),
            .DI(DI),
            .DIP(DIP),
            .INJECTDBITERR(INJECTDBITERR),
            .INJECTSBITERR(INJECTSBITERR),
            .RDCLK(RDCLK_in),
            .RDEN(RDEN_in),
            .REGCE(REGCE),
            .RST(RST_in),
            .RSTREG(RSTREG_in),
            .WRCLK(WRCLK_in),
            .WREN(WREN_in)
            );

endmodule

module FIFO36E1_bb (
    output ALMOSTEMPTY,
    output ALMOSTFULL,
    output DBITERR,
    output [63:0] DO,
    output [7:0] DOP,
    output [7:0] ECCPARITY,
    output EMPTY,
    output FULL,
    output [12:0] RDCOUNT,
    output RDERR,
    output SBITERR,
    output [12:0] WRCOUNT,
    output WRERR,

    input [63:0] DI,
    input [7:0] DIP,
    input INJECTDBITERR,
    input INJECTSBITERR,
    input RDCLK,
    input RDEN,
    input REGCE,
    input RST,
    input RSTREG,
    input WRCLK,
    input WREN
);

endmodule
`endcelldefine
