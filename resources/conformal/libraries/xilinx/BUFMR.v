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
// /__/   /\       Filename    : BUFMR.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
///////////////////////////////////////////////////////
//  Revision:    1.0
///////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module BUFMR (
  O,

  I
);

`ifdef XIL_TIMING

  parameter LOC = "UNPLACED";

`endif

  output O;

  input I;

  buf B1 (O, I);

endmodule

`endcelldefine
