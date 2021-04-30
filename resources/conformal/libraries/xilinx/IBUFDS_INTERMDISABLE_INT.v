///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Differential Signaling Input Buffer
// /___/   /\     Filename : IBUFDS_INTERMDISABLE_INT.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    11/09/11 - Initial -- added due to CR 631983 fix - for timing netlist only
//    02/05/14 - Removed X's assignment.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module IBUFDS_INTERMDISABLE_INT (O, I, IB, IBUFDISABLE, INTERMDISABLE);

    parameter DIFF_TERM = "FALSE";
    parameter DQS_BIAS = "FALSE";
    parameter IBUF_LOW_PWR = "TRUE";
    parameter IOSTANDARD = "DEFAULT";
    parameter USE_IBUFDISABLE = "TRUE";
`ifdef XIL_TIMING
    parameter LOC = "UNPLACED";
`endif // `ifdef XIL_TIMING

    output O;

    input  I;
    input  IB;
    input  IBUFDISABLE;
    input  INTERMDISABLE;

    reg o_out;

    always @(I or IB) 
  if (I == 1'b1 && IB == 1'b0)
      o_out = I;
  else if (I == 1'b0 && IB == 1'b1)
      o_out = I;

    generate
       case (USE_IBUFDISABLE)
          "TRUE" :  begin
                        assign O = (IBUFDISABLE == 0)? o_out : (IBUFDISABLE == 1)? 1'b1  : 1'b0;
                    end
          "FALSE" : begin
                        assign O = o_out;
                    end
       endcase
    endgenerate

endmodule

`endcelldefine
