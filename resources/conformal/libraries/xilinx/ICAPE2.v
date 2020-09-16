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
//  /  /                      
// /__/   /\       Filename    : ICAPE2.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
///////////////////////////////////////////////////////
//  Revision:    
//  04/30/10 - Initial version.
///////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module ICAPE2 (
  O,
  CLK,
  CSIB,
  I,
  RDWRB
);
  parameter [31:0] DEVICE_ID = 32'h04244093;

  parameter ICAP_WIDTH = "X32";
  parameter SIM_CFG_FILE_NAME = "NONE";

`ifdef XIL_TIMING

  parameter LOC = "UNPLACED";

`endif

  output [31:0] O;

  input CLK;
  input CSIB;
  input RDWRB;
  input [31:0] I;

 endmodule

`endcelldefine
