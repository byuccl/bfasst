///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  128-bit RAM
// /___/   /\     Filename : FORMAL_RAMS128.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
// simprim primitive
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps/1 ps

`celldefine

module FORMAL_RAMS128 (O, ADR0, ADR1, ADR2, ADR3, ADR4, ADR5, ADR6, CLK, I, WE);

  parameter INIT = 128'h0000000000000000_0000000000000000;

  output O;
  input I, CLK, WE, ADR0, ADR1, ADR2, ADR3, ADR4, ADR5, ADR6;

    FORMAL_INV INV_ADR4 (
      .I (ADR4),
      .O (ADR4_INV)
    );
    FORMAL_INV INV_ADR5 (
      .I (ADR5),
      .O (ADR5_INV)
    );
    FORMAL_INV INV_ADR6 (
      .I (ADR6),
      .O (ADR6_INV)
    );

    FORMAL_AND4 AND_WE_0 (
      .I0 (ADR4_INV),
      .I1 (ADR5_INV),
      .I2 (ADR6_INV),
      .I3 (WE),
      .O (WE_0)
    );
    FORMAL_AND4 AND_WE_1 (
      .I0 (ADR4),
      .I1 (ADR5_INV),
      .I2 (ADR6_INV),
      .I3 (WE),
      .O (WE_1)
    );
    FORMAL_AND4 AND_WE_2 (
      .I0 (ADR4_INV),
      .I1 (ADR5),
      .I2 (ADR6_INV),
      .I3 (WE),
      .O (WE_2)
    );
    FORMAL_AND4 AND_WE_3 (
      .I0 (ADR4),
      .I1 (ADR5),
      .I2 (ADR6_INV),
      .I3 (WE),
      .O (WE_3)
    );
    FORMAL_AND4 AND_WE_4 (
      .I0 (ADR4_INV),
      .I1 (ADR5_INV),
      .I2 (ADR6),
      .I3 (WE),
      .O (WE_4)
    );
    FORMAL_AND4 AND_WE_5 (
      .I0 (ADR4),
      .I1 (ADR5_INV),
      .I2 (ADR6),
      .I3 (WE),
      .O (WE_5)
    );
    FORMAL_AND4 AND_WE_6 (
      .I0 (ADR4_INV),
      .I1 (ADR5),
      .I2 (ADR6),
      .I3 (WE),
      .O (WE_6)
    );
    FORMAL_AND4 AND_WE_7 (
      .I0 (ADR4),
      .I1 (ADR5),
      .I2 (ADR6),
      .I3 (WE),
      .O (WE_7)
    );

    FORMAL_RAMD16 RAMD_O_0 (
      .RADR0 (ADR0),
      .RADR1 (ADR1),
      .RADR2 (ADR2),
      .RADR3 (ADR3),
      .WADR0 (ADR0),
      .WADR1 (ADR1),
      .WADR2 (ADR2),
      .WADR3 (ADR3),
      .I (I),
      .CLK (CLK),
      .WE (WE_0),
      .O (O_0)
    );
    
    defparam RAMD_O_0.INIT = INIT[15:0];
    
    FORMAL_RAMD16 RAMD_O_1 (
      .RADR0 (ADR0),
      .RADR1 (ADR1),
      .RADR2 (ADR2),
      .RADR3 (ADR3),
      .WADR0 (ADR0),
      .WADR1 (ADR1),
      .WADR2 (ADR2),
      .WADR3 (ADR3),
      .I (I),
      .CLK (CLK),
      .WE (WE_1),
      .O (O_1)
    );
    
    defparam RAMD_O_1.INIT = INIT[31:16];
    
    FORMAL_RAMD16 RAMD_O_2 (
      .RADR0 (ADR0),
      .RADR1 (ADR1),
      .RADR2 (ADR2),
      .RADR3 (ADR3),
      .WADR0 (ADR0),
      .WADR1 (ADR1),
      .WADR2 (ADR2),
      .WADR3 (ADR3),
      .I (I),
      .CLK (CLK),
      .WE (WE_2),
      .O (O_2)
    );
    
    defparam RAMD_O_2.INIT = INIT[47:32];
    
    FORMAL_RAMD16 RAMD_O_3 (
      .RADR0 (ADR0),
      .RADR1 (ADR1),
      .RADR2 (ADR2),
      .RADR3 (ADR3),
      .WADR0 (ADR0),
      .WADR1 (ADR1),
      .WADR2 (ADR2),
      .WADR3 (ADR3),
      .I (I),
      .CLK (CLK),
      .WE (WE_3),
      .O (O_3)
    );
    
    defparam RAMD_O_3.INIT = INIT[63:48];
    
    FORMAL_RAMD16 RAMD_O_4 (
      .RADR0 (ADR0),
      .RADR1 (ADR1),
      .RADR2 (ADR2),
      .RADR3 (ADR3),
      .WADR0 (ADR0),
      .WADR1 (ADR1),
      .WADR2 (ADR2),
      .WADR3 (ADR3),
      .I (I),
      .CLK (CLK),
      .WE (WE_4),
      .O (O_4)
    );
    
    defparam RAMD_O_4.INIT = INIT[79:64];
    
    FORMAL_RAMD16 RAMD_O_5 (
      .RADR0 (ADR0),
      .RADR1 (ADR1),
      .RADR2 (ADR2),
      .RADR3 (ADR3),
      .WADR0 (ADR0),
      .WADR1 (ADR1),
      .WADR2 (ADR2),
      .WADR3 (ADR3),
      .I (I),
      .CLK (CLK),
      .WE (WE_5),
      .O (O_5)
    );
    
    defparam RAMD_O_5.INIT = INIT[95:80];
    
    FORMAL_RAMD16 RAMD_O_6 (
      .RADR0 (ADR0),
      .RADR1 (ADR1),
      .RADR2 (ADR2),
      .RADR3 (ADR3),
      .WADR0 (ADR0),
      .WADR1 (ADR1),
      .WADR2 (ADR2),
      .WADR3 (ADR3),
      .I (I),
      .CLK (CLK),
      .WE (WE_6),
      .O (O_6)
    );
    
    defparam RAMD_O_6.INIT = INIT[111:96];
    
    FORMAL_RAMD16 RAMD_O_7 (
      .RADR0 (ADR0),
      .RADR1 (ADR1),
      .RADR2 (ADR2),
      .RADR3 (ADR3),
      .WADR0 (ADR0),
      .WADR1 (ADR1),
      .WADR2 (ADR2),
      .WADR3 (ADR3),
      .I (I),
      .CLK (CLK),
      .WE (WE_7),
      .O (O_7)
    );
    
    defparam RAMD_O_7.INIT = INIT[127:112];

    FORMAL_MUX2 MUX_O_0 (
      .IA (O_0),
      .IB (O_1),
      .SEL (ADR4),
      .O (O_MUX_0)
    );
    FORMAL_MUX2 MUX_O_1 (
      .IA (O_2),
      .IB (O_3),
      .SEL (ADR4),
      .O (O_MUX_1)
    );
    FORMAL_MUX2 MUX_O_2 (
      .IA (O_4),
      .IB (O_5),
      .SEL (ADR4),
      .O (O_MUX_2)
    );
    FORMAL_MUX2 MUX_O_3 (
      .IA (O_6),
      .IB (O_7),
      .SEL (ADR4),
      .O (O_MUX_3)
    );
    FORMAL_MUX2 MUX_O_4 (
      .IA (O_MUX_0),
      .IB (O_MUX_1),
      .SEL (ADR5),
      .O (O_MUX_4)
    );
    FORMAL_MUX2 MUX_O_5 (
      .IA (O_MUX_2),
      .IB (O_MUX_3),
      .SEL (ADR5),
      .O (O_MUX_5)
    );
    FORMAL_MUX2 MUX_O (
      .IA (O_MUX_4),
      .IB (O_MUX_5),
      .SEL (ADR6),
      .O (O)
    );

endmodule

`endcelldefine
