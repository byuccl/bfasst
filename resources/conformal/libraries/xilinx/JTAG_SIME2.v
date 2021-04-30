///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Jtag TAP Controler for VIRTEX7
// /___/   /\     Filename : JTAG_SIME2.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    05/17/10 - Initial version.
//    11/30/11 - 632642 - Updated supported devices and corresponding IDCODES.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps/1 ps

`celldefine

module JTAG_SIME2( TDO, TCK, TDI, TMS);


  output TDO;

  input TCK, TDI, TMS;
   

  parameter PART_NAME = "7A8";

endmodule

`endcelldefine
