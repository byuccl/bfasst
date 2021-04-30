///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Static Dual Port Synchronous RAM 256-Deep by 1-Wide
// /___/   /\     Filename : RAMD256.v
// \   \  /  \    
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    12/18/13 - Initial Version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps/1 ps

`celldefine

module RAM256X1D # (
`ifdef XIL_TIMING
    parameter LOC = "UNPLACED",
`endif
    parameter [255:0] INIT = 256'h0000000000000000000000000000000000000000000000000000000000000000,
    parameter [0:0] IS_WCLK_INVERTED = 1'b0
)  (
    output DPO,
    output SPO,
    input  [7:0] A,
    input  D,
    input  [7:0] DPRA,
    input  WCLK,
    input  WE
);

    reg  [255:0] mem;
    wire [7:0] A_dly, A_in;
    wire WCLK_dly, WE_dly, D_dly;
    wire WCLK_in, WE_in, D_in;

    assign SPO = mem[A_in];
    assign DPO = mem[DPRA];

    initial 
        mem = INIT;

    always @(posedge WCLK_in) 
        if (WE_in == 1'b1) mem[A_in] <= #100 D_in;

    
    assign A_dly = A;
    assign D_dly = D;
    assign WCLK_dly = WCLK;
    assign WE_dly = WE;

    assign WCLK_in = WCLK_dly ^ IS_WCLK_INVERTED;
    assign A_in = A_dly;
    assign D_in = D_dly;
    assign WE_in = WE_dly;
    
endmodule

`endcelldefine
