///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2016 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \   \   \/      Version     : 2016.1
//  \   \          Description : Xilinx Formal Library Component
//  /   /                        IBUFDS_GTE4
// /___/   /\      Filename    : IBUFDS_GTE4.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//  12/11/2012 - Initial version
//  03/22/2013 - Model added
//  03/25/2013 - Sync 5 YML & model update
//  04/12/2013 - Add attribute section
//  08/28/2013 - Add specify section
//  06/02/2014 - New simulation library message format.
//  10/22/2014 - 808642  Added #1 to $finish
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module IBUFDS_GTE4 #(
`ifdef XIL_TIMING
  parameter LOC = "UNPLACED",  
`endif
  parameter [0:0] REFCLK_EN_TX_PATH = 1'b0,
  parameter [1:0] REFCLK_HROW_CK_SEL = 2'b00,
  parameter [1:0] REFCLK_ICNTL_RX = 2'b00
)(
  output O,
  output ODIV2,

  input CEB,
  input I,
  input IB
);
  
// define constants

  localparam MODULE_NAME = "IBUFDS_GTE4";

  localparam [0:0] REFCLK_EN_TX_PATH_REG = REFCLK_EN_TX_PATH;
  localparam [1:0] REFCLK_HROW_CK_SEL_REG = REFCLK_HROW_CK_SEL;
  localparam [1:0] REFCLK_ICNTL_RX_REG = REFCLK_ICNTL_RX;

  wire REFCLK_EN_TX_PATH_BIN;
  wire [1:0] REFCLK_HROW_CK_SEL_BIN;
  wire [1:0] REFCLK_ICNTL_RX_BIN;

  tri0 glblGSR = 1'b0;
   
  reg  ODIV2_out=0;
  wire  O_out;

  assign O  = O_out;
  assign ODIV2   = ODIV2_out;

  assign REFCLK_EN_TX_PATH_BIN = REFCLK_EN_TX_PATH_REG;

  assign REFCLK_HROW_CK_SEL_BIN = REFCLK_HROW_CK_SEL_REG;

  assign REFCLK_ICNTL_RX_BIN = REFCLK_ICNTL_RX_REG;

  reg [2:0] ce_count = 1;
  reg [2:0] edge_count = 0;

  reg allEqual = 1'b0;

// =====================
// Count the rising edges of the clk
// =====================
  always @(posedge I) begin
    if (allEqual)
      edge_count <= 3'b000;
    else
      if ((CEB === 1'b0) || (CEB === 1'bz)) // rv = 0
        edge_count <= edge_count + 1;
    end

//  Generate synchronous reset after DIVIDE number of counts
  always @(edge_count)
    if (edge_count == ce_count)
      allEqual = 1;
    else
      allEqual = 0;

// =====================
// Generate ODIV2
// =====================
  always @(*) begin
    case (REFCLK_HROW_CK_SEL_BIN)
      2'b00: ODIV2_out <= O_out;
      2'b01: ODIV2_out <= allEqual;
      2'b10: ODIV2_out <= 1'b0;
      2'b11: ODIV2_out <= 1'b0;
      default : ODIV2_out <= O_out;
    endcase
  end

// =====================
// Generate O
// =====================

  assign O_out = (REFCLK_EN_TX_PATH_BIN | (CEB === 1'b1)) ? 1'b0 : I;

endmodule

`endcelldefine
