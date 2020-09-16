///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Delay Element.
// /___/   /\     Filename : ZHOLD_DELAY.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/14/10 - Initial version.
//    10/31/14 - Added inverter functionality for IS_*_INVERTED parameter (CR 828995).
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module ZHOLD_DELAY (
          DLYFABRIC,
          DLYIFF,
          DLYIN
       );

       parameter [0:0] IS_DLYIN_INVERTED = 1'b0;
       parameter ZHOLD_FABRIC = "DEFAULT"; // {"DEFAULT", "0", .... "31"}
       parameter ZHOLD_IFF    = "DEFAULT"; // {"DEFAULT", "0", .... "31"}

`ifdef XIL_TIMING

  parameter LOC = "UNPLACED";

`endif

       output DLYFABRIC;
       output DLYIFF;

       input  DLYIN;

       wire DLYIN_in;

       assign DLYIN_in = IS_DLYIN_INVERTED ^ DLYIN;

       assign DLYFABRIC = DLYIN_in;
       assign DLYIFF = DLYIN_in;

endmodule

`endcelldefine
