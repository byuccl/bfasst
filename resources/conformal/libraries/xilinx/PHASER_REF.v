///////////////////////////////////////////////////////
//  Copyright (c) 1995/2015 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \  \    \/      Version     : 2015.4
//  \  \           Description : Xilinx Formal Library Component
//  /  /                         7SERIES PHASER REF
// /__/   /\       Filename    : PHASER_REF.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
///////////////////////////////////////////////////////
//  Revision: Comment:
//  23APR2010 Initial UNI/UNP/SIM version from yml
//    10/31/14 - Added inverter functionality for IS_*_INVERTED parameter (CR 828995).
// End Revision
///////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module PHASER_REF (
  LOCKED,

  CLKIN,
  PWRDWN,
  RST
);

`ifdef XIL_TIMING
  parameter LOC = "UNPLACED";
`endif
  parameter [0:0] IS_RST_INVERTED = 1'b0;
  parameter [0:0] IS_PWRDWN_INVERTED = 1'b0;

  output LOCKED;

  input CLKIN;
  input PWRDWN;
  input RST;

  wire RST_in;
  wire PWRDWN_in;
   
  assign RST_in = RST ^ IS_RST_INVERTED;
  assign PWRDWN_in = PWRDWN ^ IS_PWRDWN_INVERTED;
   
  PHASER_REF_bb inst_bb (
              .LOCKED(LOCKED),
              .CLKIN(CLKIN),
              .PWRDWN(PWRDWN_in),
              .RST(RST_in)
              );

endmodule

module PHASER_REF_bb (
  output LOCKED,

  input CLKIN,
  input PWRDWN,
  input RST
);

endmodule

`endcelldefine
