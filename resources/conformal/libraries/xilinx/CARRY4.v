///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Fast Carry Logic with Look Ahead 
// /___/   /\     Filename : CARRY4.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/11/05 - Initial version.
//    05/06/05 - Unused CYINT or CI pin need grounded instead of open (CR207752)
//    05/31/05 - Change pin order, remove connection check for CYINIT and CI.
//    05/30/07 - Change timescale to 1 ps / 1ps.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module CARRY4 (CO, O, CI, CYINIT, DI, S);

    output [3:0] CO;
    output [3:0] O;
    input        CI;
    input        CYINIT;
    input  [3:0] DI;
    input  [3:0] S;

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif

    wire ci_or_cyinit;


    assign O = S ^ {CO[2:0], ci_or_cyinit};
    assign CO[0] = S[0] ? ci_or_cyinit : DI[0];
    assign CO[1] = S[1] ? CO[0] : DI[1];
    assign CO[2] = S[2] ? CO[1] : DI[2];
    assign CO[3] = S[3] ? CO[2] : DI[3];
    assign ci_or_cyinit = CYINIT | CI;


endmodule

`endcelldefine

