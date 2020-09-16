///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Simulation Library Component
//  /   /                  32-Bit Shift Register Look-Up-Table with Clock Enable
// /___/   /\     Filename : SRL32E.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    09/08/11 - Initial version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps/1 ps

`celldefine

module SRL32E (Q, A, CE, CLK, D);

  parameter [31:0] INIT = 32'h00000000;

`ifdef XIL_TIMING

  parameter LOC = "UNPLACED";

`endif


  output Q;

  input  [4:0] A;
  input  CE, CLK, D;

  reg  [31:0] data;
  wire CLK_dly, CE_dly, D_dly;


    initial
    begin
          assign  data = INIT;
          while (CLK_dly === 1'b1 || CLK_dly ===1'bX) 
            #10; 
       //deassign data;
    end


  always @(posedge CLK_dly) 
    if (CE_dly == 1'b1) 
      data[31:0] <=  {data[30:0], D_dly};


    assign Q = data[A];

    assign D_dly = D;
    assign CLK_dly = CLK;
    assign CE_dly = CE;

endmodule

`endcelldefine
