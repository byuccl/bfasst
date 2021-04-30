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
// /___/   /\      Filename    : ODDRE1.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//    10/31/14 - Added inverter functionality for IS_*_INVERTED parameter (CR 828995).
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module ODDRE1 #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter [0:0] IS_C_INVERTED = 1'b0,
  parameter [0:0] IS_D1_INVERTED = 1'b0,
  parameter [0:0] IS_D2_INVERTED = 1'b0,
  parameter [0:0] SRVAL = 1'b0
)(
  output Q,

  input C,
  input D1,
  input D2,
  input SR
);

  wire C_in;
  wire D1_in;
  wire D2_in;

  assign C_in = IS_C_INVERTED ^ C;
  assign D1_in = IS_D1_INVERTED ^ D1;
  assign D2_in = IS_D2_INVERTED ^ D2;
   
  ODDRE1_bb inst_bb (
            .Q(Q),
            .C(C_in),
            .D1(D1_in),
            .D2(D2_in),
            .SR(SR)
            );

endmodule

module ODDRE1_bb (
  output Q,

  input C,
  input D1,
  input D2,
  input SR
);

endmodule

`endcelldefine
