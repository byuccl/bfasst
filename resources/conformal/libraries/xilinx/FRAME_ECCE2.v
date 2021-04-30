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
// /__/   /\       Filename    : FRAME_ECCE2.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
///////////////////////////////////////////////////////
//  Revision:    1.0
///////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module FRAME_ECCE2 (
  CRCERROR,
  ECCERROR,
  ECCERRORSINGLE,
  FAR,
  SYNBIT,
  SYNDROME,
  SYNDROMEVALID,
  SYNWORD
);



  parameter FARSRC = "EFAR";
  parameter FRAME_RBT_IN_FILENAME = "NONE";

`ifdef XIL_TIMING

  parameter LOC = "UNPLACED";

`endif

  output CRCERROR;
  output ECCERROR;
  output ECCERRORSINGLE;
  output SYNDROMEVALID;
  output [12:0] SYNDROME;
  output [25:0] FAR;
  output [4:0] SYNBIT;
  output [6:0] SYNWORD;

  
endmodule

`endcelldefine 
