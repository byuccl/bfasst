///////////////////////////////////////////////////////
//  Copyright (c) 1995/2015 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \  \    \/      Version     : 2015.4
//  \  \           Description : 
//  /  /                      
// /__/   /\       Filename    : MUXF9.uniprim.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
///////////////////////////////////////////////////////
//  Revision:
//     01/16/14 - Initial Version
//  End Revision
///////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module MUXF9
  `ifdef XIL_TIMING //Simprim 
#(
  parameter LOC = "UNPLACED"
)
  `endif
(
  output O,

  input I0,
  input I1,
  input S
);

    reg O_out;

    always @(I0 or I1 or S)
        if (S)
            O_out = I1;
        else
            O_out = I0;

    assign O = O_out;


endmodule

`endcelldefine
