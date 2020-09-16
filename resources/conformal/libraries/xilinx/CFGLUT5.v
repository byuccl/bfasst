///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  5-input Dynamically Reconfigurable Look-Up-Table with Carry and Clock Enable
// /___/   /\     Filename : CFGLUT5.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    12/27/05 - Initial version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module CFGLUT5 (CDO, O5, O6, CDI, CE, CLK, I0, I1, I2, I3, I4);

  parameter [31:0] INIT = 32'h00000000;
  parameter [0:0]  IS_CLK_INVERTED = 1'b0;

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif

    output CDO;
    output O5;
    output O6;

    input  I4, I3, I2, I1, I0;
    input  CDI, CE, CLK;

    reg  [31:0] data;

    wire CLK_in;

    assign  O6 = data[{I4, I3, I2, I1, I0}];
    assign  O5 = data[{I3, I2, I1, I0}];
    assign  CDO = data[31];

    assign CLK_in = IS_CLK_INVERTED ^ CLK;

    initial
    begin
       data <= INIT;
    end

    always @(posedge CLK_in)
  if (CE == 1'b1) begin
      data <= #100 {data[30:0], CDI};
        end

endmodule

`endcelldefine

