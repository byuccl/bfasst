///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Static Synchronous RAM 512-Deep by 1-Wide
// /___/   /\     Filename : RAM512X1S.v
// \   \  /  \    
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    12/19/13 - Initial Version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module RAM512X1S # (
`ifdef XIL_TIMING
    parameter LOC = "UNPLACED",
`endif
    parameter [511:0] INIT = 512'h0,
    parameter [0:0] IS_WCLK_INVERTED = 1'b0
) (
    output O,
    input [8:0] A,
    input D,
    input WCLK,
    input WE
);

    reg  [511:0] mem;
    wire [8:0] A_in;

    wire D_in, WCLK_in, WE_in;
    
    assign O = mem[A_in];

    initial 
        mem = INIT;

    assign WCLK_in = WCLK ^ IS_WCLK_INVERTED;
    assign A_in = A;
    assign D_in = D;
    assign WE_in = WE;

    always @(posedge WCLK_in) 
        if (WE_in == 1'b1) mem[A_in] <= #100 D_in;

endmodule

`endcelldefine
