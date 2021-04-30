///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  64x1 Dual Port Static RAM with synchronous write capability
// /___/   /\     Filename : RAM64X1D.v
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

module RAM64X1D (DPO, SPO, A0, A1, A2, A3, A4, A5, D, DPRA0, DPRA1, DPRA2, DPRA3, DPRA4, DPRA5, WCLK, WE);

    parameter [63:0] INIT = 64'h0000000000000000;
    parameter [0:0] IS_WCLK_INVERTED = 1'b0;

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif

    output DPO, SPO;

    input  A0, A1, A2, A3, A4, A5, D, DPRA0, DPRA1, DPRA2, DPRA3, DPRA4, DPRA5, WCLK, WE;
    wire WCLK_in;

    assign WCLK_in = IS_WCLK_INVERTED ^ WCLK;

    FORMAL_INV INV_A4 (
      .I (A4),
      .O (A4_INV)
    );
    FORMAL_INV INV_A5 (
      .I (A5),
      .O (A5_INV)
    );

    FORMAL_AND3 AND_WE_0 (
      .I0 (A4_INV),
      .I1 (A5_INV),
      .I2 (WE),
      .O (WE_0)
    );
    FORMAL_AND3 AND_WE_1 (
      .I0 (A4),
      .I1 (A5_INV),
      .I2 (WE),
      .O (WE_1)
    );
    FORMAL_AND3 AND_WE_2 (
      .I0 (A4_INV),
      .I1 (A5),
      .I2 (WE),
      .O (WE_2)
    );
    FORMAL_AND3 AND_WE_3 (
      .I0 (A4),
      .I1 (A5),
      .I2 (WE),
      .O (WE_3)
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
    
    FORMAL_RAMD16 RAMD_SP_2 (
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
      .WE (WE_2),
      .O (SP_2)
    );
    
    defparam RAMD_SP_2.INIT = INIT[47:32];
    
    FORMAL_RAMD16 RAMD_SP_3 (
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
      .WE (WE_3),
      .O (SP_3)
    );
    
    defparam RAMD_SP_3.INIT = INIT[63:48];

    FORMAL_MUX2 MUX_SP_0 (
      .IA (SP_0),
      .IB (SP_1),
      .SEL (A4),
      .O (SP_MUX_0)
    );
    FORMAL_MUX2 MUX_SP_1 (
      .IA (SP_2),
      .IB (SP_3),
      .SEL (A4),
      .O (SP_MUX_1)
    );
    FORMAL_MUX2 MUX_SP (
      .IA (SP_MUX_0),
      .IB (SP_MUX_1),
      .SEL (A5),
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
    
    FORMAL_RAMD16 RAMD_DP_2 (
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
      .WE (WE_2),
      .O (DP_2)
    );
    
    defparam RAMD_DP_2.INIT = INIT[47:32];
    
    FORMAL_RAMD16 RAMD_DP_3 (
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
      .WE (WE_3),
      .O (DP_3)
    );
    
    defparam RAMD_DP_3.INIT = INIT[63:48];

    FORMAL_MUX2 MUX_DP_0 (
      .IA (DP_0),
      .IB (DP_1),
      .SEL (DPRA4),
      .O (DP_MUX_0)
    );
    FORMAL_MUX2 MUX_DP_1 (
      .IA (DP_2),
      .IB (DP_3),
      .SEL (DPRA4),
      .O (DP_MUX_1)
    );
    FORMAL_MUX2 MUX_DP (
      .IA (DP_MUX_0),
      .IB (DP_MUX_1),
      .SEL (DPRA5),
      .O (DPO)
    );

endmodule

`endcelldefine
