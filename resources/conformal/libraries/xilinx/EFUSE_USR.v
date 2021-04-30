///////////////////////////////////////////////////////
//  Copyright (c) 1995/2015 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \  \    \/      Version : 2015.4
//  \  \           Description : Xilinx Formal Library Component
//  /  /                      
// /__/   /\       Filename    : EFUSE_USR.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
///////////////////////////////////////////////////////
//  Revision:    1.0
///////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module EFUSE_USR (
  EFUSEUSR
);

  parameter [31:0] SIM_EFUSE_VALUE = 32'h00000000;

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif

  output [31:0] EFUSEUSR;

  assign EFUSEUSR = SIM_EFUSE_VALUE;

endmodule

`endcelldefine
