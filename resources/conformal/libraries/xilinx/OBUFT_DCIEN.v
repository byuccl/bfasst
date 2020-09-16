///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  3-State Output Buffer
// /___/   /\     Filename : OBUFT_DCIEN.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/29/10 - Initial version.
//    12/20/10 - CR 587760 -- For backend support only, no corresponding unisim 
//    09/20/11 - CR 625725 -- Removed attribute CAPACITANCE
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module OBUFT_DCIEN (O, DCITERMDISABLE, I, T);

    parameter integer DRIVE = 12;
    parameter IOSTANDARD = "DEFAULT";
`ifdef XIL_TIMING
    parameter LOC = "UNPLACED";
`endif // `ifdef XIL_TIMING
    parameter SLEW = "SLOW";

    output O;

    input  DCITERMDISABLE;
    input  I;
    input  T;

    wire ts;


    or O1 (ts, T);
    bufif0 T1 (O, I, ts);

endmodule

`endcelldefine
