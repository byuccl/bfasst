///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  32x1 Dual Port Static RAM with synchronous write capability
// /___/   /\     Filename : RAM32X1D.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/01/08 - Initial version.
//    08/30/13 - PR683925 - add invertible pin support.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module RAM32X1D (DPO, SPO, A0, A1, A2, A3, A4, D, DPRA0, DPRA1, DPRA2, DPRA3, DPRA4, WCLK, WE);

    parameter [31:0] INIT = 32'h00000000;
    parameter [0:0] IS_WCLK_INVERTED = 1'b0;

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif

    output DPO, SPO;

    input  A0, A1, A2, A3, A4, D, DPRA0, DPRA1, DPRA2, DPRA3, DPRA4, WCLK, WE;
    wire WCLK_in;

    assign WCLK_in = IS_WCLK_INVERTED ^ WCLK;


    FORMAL_INV INV_A4 (
      .I (A4),
      .O (A4_INV)
    );

    FORMAL_AND2 AND_WE_0 (
      .I0 (A4_INV),
      .I1 (WE),
      .O (WE_0)
    );
    FORMAL_AND2 AND_WE_1 (
      .I0 (A4),
      .I1 (WE),
      .O (WE_1)
    );

    FORMAL_RAMD16 RAMD_SP_0 (
      .RADR0 (A0),
      .RADR1 (A1),
      .RADR2 (A2),
      .RADR3 (A3),
      .WADR0 (A0),
      .WADR1 (A1),
      .WADR2 (A2),
      .WADR3 (A3),
      .I (D),
      .CLK (WCLK_in),
      .WE (WE_0),
      .O (SP_0)
    );
    
    defparam RAMD_SP_0.INIT = INIT[15:0];
    
    FORMAL_RAMD16 RAMD_SP_1 (
      .RADR0 (A0),
      .RADR1 (A1),
      .RADR2 (A2),
      .RADR3 (A3),
      .WADR0 (A0),
      .WADR1 (A1),
      .WADR2 (A2),
      .WADR3 (A3),
      .I (D),
      .CLK (WCLK_in),
      .WE (WE_1),
      .O (SP_1)
    );
    
    defparam RAMD_SP_1.INIT = INIT[31:16];

    FORMAL_MUX2 MUX_SP (
      .IA (SP_0),
      .IB (SP_1),
      .SEL (A4),
      .O (SPO)
    );

    FORMAL_RAMD16 RAMD_DP_0 (
      .RADR0 (DPRA0),
      .RADR1 (DPRA1),
      .RADR2 (DPRA2),
      .RADR3 (DPRA3),
      .WADR0 (A0),
      .WADR1 (A1),
      .WADR2 (A2),
      .WADR3 (A3),
      .I (D),
      .CLK (WCLK_in),
      .WE (WE_0),
      .O (DP_0)
    );
    
    defparam RAMD_DP_0.INIT = INIT[15:0];
    
    FORMAL_RAMD16 RAMD_DP_1 (
      .RADR0 (DPRA0),
      .RADR1 (DPRA1),
      .RADR2 (DPRA2),
      .RADR3 (DPRA3),
      .WADR0 (A0),
      .WADR1 (A1),
      .WADR2 (A2),
      .WADR3 (A3),
      .I (D),
      .CLK (WCLK_in),
      .WE (WE_1),
      .O (DP_1)
    );
    
    defparam RAMD_DP_1.INIT = INIT[31:16];

    FORMAL_MUX2 MUX_DP (
      .IA (DP_0),
      .IB (DP_1),
      .SEL (DPRA4),
      .O (DPO)
    );

endmodule

`endcelldefine
