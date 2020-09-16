///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Regional Clock Buffer
// /___/   /\     Filename : BUFR.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    03/23/04 - Initial version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module BUFR (O, CE, CLR, I);

    output O;

    input CE;
    input CLR;
    input I;

    parameter BUFR_DIVIDE = "BYPASS";
    parameter SIM_DEVICE = "7SERIES";
    
`ifdef XIL_TIMING //Simprim

  parameter LOC = "UNPLACED";

`endif

endmodule

`endcelldefine
