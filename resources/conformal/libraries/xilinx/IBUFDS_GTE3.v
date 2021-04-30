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
// /___/   /\      Filename    : IBUFDS_GTE3.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//      01/16/14 - Initial version
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module IBUFDS_GTE3 #(
  `ifdef XIL_TIMING //Simprim 
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

  localparam MODULE_NAME = "IBUFDS_GTE3";

   // Parameter encodings and registers
  `ifndef XIL_DR
  localparam [0:0] REFCLK_EN_TX_PATH_REG = REFCLK_EN_TX_PATH;
  localparam [1:0] REFCLK_HROW_CK_SEL_REG = REFCLK_HROW_CK_SEL;
  localparam [1:0] REFCLK_ICNTL_RX_REG = REFCLK_ICNTL_RX;
  `endif

  wire REFCLK_EN_TX_PATH_BIN;
  wire [1:0] REFCLK_HROW_CK_SEL_BIN;
  wire [1:0] REFCLK_ICNTL_RX_BIN;
  wire i_in, ib_in, ceb_in;
   
  tri0 GSR = 1'b0;

  assign i_in = I;
  assign ib_in = IB;
  assign ceb_in = CEB;
   
  assign REFCLK_EN_TX_PATH_BIN = REFCLK_EN_TX_PATH_REG;
  assign REFCLK_HROW_CK_SEL_BIN = REFCLK_HROW_CK_SEL_REG;
  assign REFCLK_ICNTL_RX_BIN = REFCLK_ICNTL_RX_REG;

   reg  ODIV2_out=0;
   wire  O_out;
   

    reg [2:0] ce_count = 1;
    reg [2:0] edge_count = 0;

    reg allEqual;

    initial begin
        allEqual = 0;
     end // initial begin


// =====================
// Count the rising edges of the clk
// =====================
    always @(posedge I) begin
         if(allEqual)
             edge_count <= 3'b000;
          else
             if (CEB == 1'b0)
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

   assign O_out = (REFCLK_EN_TX_PATH_BIN | ceb_in) ? 1'b0 : i_in;
   


// =====================
// Outputs   
// =====================

    assign O  = O_out;
    assign ODIV2   = ODIV2_out;
    

endmodule

`endcelldefine
