///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Input Buffer
// /___/   /\     Filename : IBUFDS_DIFF_OUT.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/01/08 - Initial version.
//    02/05/14 - Removed X's assignment.
//    07/24/14 - Add missing parameter (CR 806964).
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module IBUFDS_DIFF_OUT (O, OB, I, IB);

    parameter DIFF_TERM = "FALSE";
    parameter DQS_BIAS = "FALSE";
    parameter IBUF_LOW_PWR = "TRUE";
    parameter IOSTANDARD = "DEFAULT";


`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif

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
