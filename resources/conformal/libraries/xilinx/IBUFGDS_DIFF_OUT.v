///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Differential Signaling Input Clock Buffer with Differential Outputs
// /___/   /\     Filename : IBUFGDS_DIFF_OUT.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    03/23/04 - Initial version.
//    05/23/07 - Changed timescale to 1 ps / 1 ps.
//    02/10/09 - CR 430124 -- Added attribute DIFF_TERM.
//    06/02/09 - CR 523083 -- Added attribute IBUF_LOW_PWR.
//    11/03/10 - CR 576577 -- changed default value of IOSTANDARD from LVDS_25 to DEFAULT.
//    12/13/11 - Added `celldefine and `endcelldefine (CR 524859).
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module IBUFGDS_DIFF_OUT (O, OB, I, IB);

  parameter DIFF_TERM = "FALSE";
  parameter DQS_BIAS = "FALSE";
  parameter IBUF_LOW_PWR = "TRUE";
  parameter IOSTANDARD = "DEFAULT";

  output O, OB;

  input  I, IB;

  reg  o_out;

  buf B0 (O, o_out);
  not B1 (OB, o_out);

  always @(I or IB) begin
    if (I == 1'b1 && IB == 1'b0)
      o_out <= I;
    else if (I == 1'b0 && IB == 1'b1)
      o_out <= I;
    end

endmodule

`endcelldefine
