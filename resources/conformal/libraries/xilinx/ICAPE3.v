///////////////////////////////////////////////////////
//  Copyright (c) 1995/2015 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \   \   \/      Version     : 2015.4
//  \   \          Description : Xilinx Formal Library Component
//  /  /                      
// /__/   /\       Filename    : ICAPE3.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
///////////////////////////////////////////////////////
//  Revision:    
//  10/31/12 - Initial version.
//  End Revision
///////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module ICAPE3 #(
      
`ifdef XIL_TIMING
  parameter LOC = "UNPLACED",  
`endif
  parameter [31:0] DEVICE_ID = 32'h03628093,
  parameter ICAP_AUTO_SWITCH = "DISABLE",
  parameter SIM_CFG_FILE_NAME = "NONE"

)(

  output AVAIL,
  output [31:0] O,
  output PRDONE,
  output PRERROR,
  
  input CLK,
  input CSIB,
  input RDWRB,
  input [31:0] I

);

endmodule

`endcelldefine
