///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Differential Signaling Input Buffer with Differential Outputs
// /___/   /\     Filename : IBUFDS_DIFF_OUT_INTERMDISABLE.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/20/11 - Initial version.
//    02/05/14 - Removed X's assignment.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module IBUFDS_DIFF_OUT_INTERMDISABLE (O, OB, I, IB, IBUFDISABLE, INTERMDISABLE);

    parameter DIFF_TERM = "FALSE";
    parameter DQS_BIAS = "FALSE";
    parameter IBUF_LOW_PWR = "TRUE";
    parameter IOSTANDARD = "DEFAULT";
    parameter SIM_DEVICE = "7SERIES";
    parameter USE_IBUFDISABLE = "TRUE";
`ifdef XIL_TIMING
    parameter LOC = "UNPLACED";
`endif //  `ifdef XIL_TIMING


    output O; 
    output OB;

    input I;
    input IB;
    input IBUFDISABLE;
    input INTERMDISABLE;

    reg  o_out;

    always @(I or IB) begin
  if (I == 1'b1 && IB == 1'b0)
      o_out <= I;
  else if (I == 1'b0 && IB == 1'b1)
      o_out <= I;
    end

    generate
       case (USE_IBUFDISABLE)
          "TRUE" :  begin
                       assign O  = (IBUFDISABLE == 0)? o_out  : (IBUFDISABLE == 1)? 1'b1  : 1'b0;
                       assign OB = (IBUFDISABLE == 0)? ~o_out : (IBUFDISABLE == 1)? 1'b1  : 1'b0;
                    end
          "FALSE" : begin
                       assign O  =  o_out;
                       assign OB =  ~o_out;
                    end
       endcase
    endgenerate

endmodule

`endcelldefine
