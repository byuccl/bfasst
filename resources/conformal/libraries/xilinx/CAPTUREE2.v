///////////////////////////////////////////////////////
//  Copyright (c) 1995/2015 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \  \    \/      Version     : 2015.4
//  \  \           Description : Xilinx Formal Library component
//  /  /                      
// /__/   /\       Filename    : CAPTUREE2.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
//
///////////////////////////////////////////////////////
//  Revision:
///////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module CAPTUREE2 (
  CAP,
  CLK
);

  parameter ONESHOT = "TRUE";

`ifdef XIL_TIMING

  parameter LOC = "UNPLACED";

`endif

  input CAP;
  input CLK;

endmodule

`endcelldefine
