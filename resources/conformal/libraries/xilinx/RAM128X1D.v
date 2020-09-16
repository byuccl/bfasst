///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                   128X1 Dual Port Static RAM with synchronous write capability
// /___/   /\     Filename : RAM128X1D.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/01/08 - Initial version.
//    08/30/13 - PR683925 - add invertible pin support.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  100 ps / 10 ps

`celldefine

module RAM128X1D (DPO, SPO, A, D, DPRA, WCLK, WE);

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif
    parameter [127:0] INIT = 128'h00000000000000000000000000000000;
    parameter [0:0] IS_WCLK_INVERTED = 1'b0;

    output DPO, SPO;

    input  [6:0] A;
    input  [6:0] DPRA;
    input  D;
    input  WCLK;
    input  WE;

    wire DPO_temp1;
    wire DPO_temp2;
    wire SPO_temp1;
    wire SPO_temp2;
    wire WCLK_in;

    assign WCLK_in = IS_WCLK_INVERTED ^ WCLK;

    FORMAL_RAMS128 RAMD_SPO (
      .ADR0 (A[0]),
      .ADR1 (A[1]),
      .ADR2 (A[2]),
      .ADR3 (A[3]),
      .ADR4 (A[4]),
      .ADR5 (A[5]),
      .ADR6 (A[6]),
      .I (D),
      .CLK (WCLK_in),
      .WE (WE),
      .O (SPO)
    );
    
    defparam RAMD_SPO.INIT = INIT;
    
    FORMAL_RAMD128 RAMD_DPO (
      .RADR0 (DPRA[0]),
      .RADR1 (DPRA[1]),
      .RADR2 (DPRA[2]),
      .RADR3 (DPRA[3]),
      .RADR4 (DPRA[4]),
      .RADR5 (DPRA[5]),
      .RADR6 (DPRA[6]),
      .WADR0 (A[0]),
      .WADR1 (A[1]),
      .WADR2 (A[2]),
      .WADR3 (A[3]),
      .WADR4 (A[4]),
      .WADR5 (A[5]),
      .WADR6 (A[6]),
      .I (D),
      .CLK (WCLK_in),
      .WE (WE),
      .O (DPO)
    );

   defparam RAMD_DPO.INIT = INIT;
endmodule

`endcelldefine
