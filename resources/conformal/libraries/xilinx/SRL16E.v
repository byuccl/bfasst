///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  16 bit Shift Register LUT with Carry and Clock Enable
// /___/   /\     Filename : SRL16E.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/01/08 - Initial version.
//    08/30/13 - PR683925 - add invertible pin support.
//    10/30/14 - Added range for parameters (CR 830410).
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module SRL16E (Q, A0, A1, A2, A3, CE, CLK, D);

    parameter [15:0] INIT = 16'h0000;
    parameter [0:0] IS_CLK_INVERTED = 1'b0;

`ifdef XIL_TIMING //Simprim

  parameter LOC = "UNPLACED";

`endif

    output Q;

    input  A0, A1, A2, A3, CE, CLK, D;

    reg  [5:0]  count;
    reg  [15:0] data;
    wire [3:0]  addr;
    wire  q_int;
    wire CLK_in;

    buf b_a3 (addr[3], A3);
    buf b_a2 (addr[2], A2);
    buf b_a1 (addr[1], A1);
    buf b_a0 (addr[0], A0);

    assign Q = data[addr];
    assign CLK_in = IS_CLK_INVERTED ^ CLK;

// synopsys disabledTranslate_off
    initial begin
  for (count = 0; count < 16; count = count + 1)
      data[count] <= INIT[count];
    end
// synopsys disabledTranslate_on

    always @(posedge CLK_in) begin
  if (CE == 1'b1) begin
      {data[15:0]} <= {data[14:0], D};
  end
    end

endmodule

`endcelldefine
