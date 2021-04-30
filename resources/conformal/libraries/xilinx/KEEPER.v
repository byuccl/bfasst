///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Keeper
// /___/   /\     Filename : KEEPER.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/01/08 - Initial version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module KEEPER (O);

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif

    inout O;
    reg   in;

    always @(O)
  if (O)
      in <= 1;
  else
      in <= 0;

    buf (pull1, pull0) B1 (O, in);

endmodule

`endcelldefine
