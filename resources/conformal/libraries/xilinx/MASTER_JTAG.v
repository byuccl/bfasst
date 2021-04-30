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
// /___/   /\      Filename    : MASTER_JTAG.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//     06/17/13 - Initial version.
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module MASTER_JTAG 
  `ifdef XIL_TIMING //Simprim adding LOC only 
#(
  parameter LOC = "UNPLACED"  
)
  `endif
(
  output TDO,

  input TCK,
  input TDI,
  input TMS
);

endmodule

`endcelldefine
