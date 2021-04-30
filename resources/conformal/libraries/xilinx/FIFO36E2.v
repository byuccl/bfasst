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
// /___/   /\      Filename    : FIFO36E2.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//  11/30/2012 - intial
//  12/12/2012 - yaml update, 691724 and 691715
//  02/07/2013 - 699628 - correction to DO_PIPELINED mode
//  02/28/2013 - update to keep in sync with RAMB models
//  03/18/2013 - 707083 reads should clear FULL when RD & WR in CDC.
//  03/22/2013 - sync5 yaml update, port ordering, *RSTBUSY
//  03/25/2013 - 707652 - RST = 1 n enters RST sequence but does not hold it there.
//  03/25/2013 - 707719 - Add sync5 cascade feature
//  03/27/2013 - 708820 - FULL flag deassert during WREN ind clocks.
//  10/31/14 - Added inverter functionality for IS_*_INVERTED parameter (CR 828995).
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module FIFO36E2 #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter CASCADE_ORDER = "NONE",
  parameter CLOCK_DOMAINS = "INDEPENDENT",
  parameter EN_ECC_PIPE = "FALSE",
  parameter EN_ECC_READ = "FALSE",
  parameter EN_ECC_WRITE = "FALSE",
  parameter FIRST_WORD_FALL_THROUGH = "FALSE",
  parameter [71:0] INIT = 72'h000000000000000000,
  parameter [0:0] IS_RDCLK_INVERTED = 1'b0,
  parameter [0:0] IS_RDEN_INVERTED = 1'b0,
  parameter [0:0] IS_RSTREG_INVERTED = 1'b0,
  parameter [0:0] IS_RST_INVERTED = 1'b0,
  parameter [0:0] IS_WRCLK_INVERTED = 1'b0,
  parameter [0:0] IS_WREN_INVERTED = 1'b0,
  parameter integer PROG_EMPTY_THRESH = 256,
  parameter integer PROG_FULL_THRESH = 256,
  parameter RDCOUNT_TYPE = "RAW_PNTR",
  parameter integer READ_WIDTH = 4,
  parameter REGISTER_MODE = "UNREGISTERED",
  parameter RSTREG_PRIORITY = "RSTREG",
  parameter SLEEP_ASYNC = "FALSE",
  parameter [71:0] SRVAL = 72'h000000000000000000,
  parameter WRCOUNT_TYPE = "RAW_PNTR",
  parameter integer WRITE_WIDTH = 4
)(
  output [63:0] CASDOUT,
  output [7:0] CASDOUTP,
  output CASNXTEMPTY,
  output CASPRVRDEN,
  output DBITERR,
  output [63:0] DOUT,
  output [7:0] DOUTP,
  output [7:0] ECCPARITY,
  output EMPTY,
  output FULL,
  output PROGEMPTY,
  output PROGFULL,
  output [13:0] RDCOUNT,
  output RDERR,
  output RDRSTBUSY,
  output SBITERR,
  output [13:0] WRCOUNT,
  output WRERR,
  output WRRSTBUSY,

  input [63:0] CASDIN,
  input [7:0] CASDINP,
  input CASDOMUX,
  input CASDOMUXEN,
  input CASNXTRDEN,
  input CASOREGIMUX,
  input CASOREGIMUXEN,
  input CASPRVEMPTY,
  input [63:0] DIN,
  input [7:0] DINP,
  input INJECTDBITERR,
  input INJECTSBITERR,
  input RDCLK,
  input RDEN,
  input REGCE,
  input RST,
  input RSTREG,
  input SLEEP,
  input WRCLK,
  input WREN
);

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
   
   FIFO36E2_bb inst_bb (
            .CASDOUT(CASDOUT),
            .CASDOUTP(CASDOUTP),
            .CASNXTEMPTY(CASNXTEMPTY),
            .CASPRVRDEN(CASPRVRDEN),
            .DBITERR(DBITERR),
            .DOUT(DOUT),
            .DOUTP(DOUTP),
            .ECCPARITY(ECCPARITY),
            .EMPTY(EMPTY),
            .FULL(FULL),
            .PROGEMPTY(PROGEMPTY),
            .PROGFULL(PROGFULL),
            .RDCOUNT(RDCOUNT),
            .RDERR(RDERR),
            .RDRSTBUSY(RDRSTBUSY),
            .SBITERR(SBITERR),
            .WRCOUNT(WRCOUNT),
            .WRERR(WRERR),
            .WRRSTBUSY(WRRSTBUSY),
            .CASDIN(CASDIN),
            .CASDINP(CASDINP),
            .CASDOMUX(CASDOMUX),
            .CASDOMUXEN(CASDOMUXEN),
            .CASNXTRDEN(CASNXTRDEN),
            .CASOREGIMUX(CASOREGIMUX),
            .CASOREGIMUXEN(CASOREGIMUXEN),
            .CASPRVEMPTY(CASPRVEMPTY),
            .DIN(DIN),
            .DINP(DINP),
            .INJECTDBITERR(INJECTDBITERR),
            .INJECTSBITERR(INJECTSBITERR),
            .RDCLK(RDCLK_in),
            .RDEN(RDEN_in),
            .REGCE(REGCE),
            .RST(RST_in),
            .RSTREG(RSTREG_in),
            .SLEEP(SLEEP),
            .WRCLK(WRCLK_in),
            .WREN(WREN_in)
            );

endmodule

module FIFO36E2_bb (
  output [63:0] CASDOUT,
  output [7:0] CASDOUTP,
  output CASNXTEMPTY,
  output CASPRVRDEN,
  output DBITERR,
  output [63:0] DOUT,
  output [7:0] DOUTP,
  output [7:0] ECCPARITY,
  output EMPTY,
  output FULL,
  output PROGEMPTY,
  output PROGFULL,
  output [13:0] RDCOUNT,
  output RDERR,
  output RDRSTBUSY,
  output SBITERR,
  output [13:0] WRCOUNT,
  output WRERR,
  output WRRSTBUSY,

  input [63:0] CASDIN,
  input [7:0] CASDINP,
  input CASDOMUX,
  input CASDOMUXEN,
  input CASNXTRDEN,
  input CASOREGIMUX,
  input CASOREGIMUXEN,
  input CASPRVEMPTY,
  input [63:0] DIN,
  input [7:0] DINP,
  input INJECTDBITERR,
  input INJECTSBITERR,
  input RDCLK,
  input RDEN,
  input REGCE,
  input RST,
  input RSTREG,
  input SLEEP,
  input WRCLK,
  input WREN
);

endmodule

`endcelldefine
