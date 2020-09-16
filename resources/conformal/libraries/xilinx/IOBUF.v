///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Bi-Directional Buffer
// /___/   /\     Filename : IOBUF.v
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

module IOBUF (O, IO, I, T);

    parameter integer DRIVE = 12;
    parameter IBUF_LOW_PWR = "TRUE";
    parameter IOSTANDARD = "DEFAULT";
`ifdef XIL_TIMING

    parameter LOC = " UNPLACED";

`endif
    parameter SLEW = "SLOW";

    output O;
    inout  IO;
    input  I, T;

    wire ts;

    or O1 (ts,T);
    bufif0 T1 (IO, I, ts);

    buf B1 (O, IO);

endmodule

`endcelldefine
