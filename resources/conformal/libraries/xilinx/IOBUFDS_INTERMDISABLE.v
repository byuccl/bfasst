///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  3-State Diffential Signaling I/O Buffer
// /___/   /\     Filename : IOBUFDS_INTERMDISABLE.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/20/11 - Initial version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module IOBUFDS_INTERMDISABLE (O, IO, IOB, I, IBUFDISABLE, INTERMDISABLE, T);

    parameter DIFF_TERM = "FALSE";
    parameter DQS_BIAS = "FALSE";
    parameter IBUF_LOW_PWR = "TRUE";
    parameter IOSTANDARD = "DEFAULT";
    parameter SIM_DEVICE = "7SERIES";
    parameter SLEW = "SLOW";
    parameter USE_IBUFDISABLE = "TRUE";
   
    output O;
    inout  IO;
    inout  IOB;
    input  I;
    input  IBUFDISABLE;
    input  INTERMDISABLE;
    input  T;

    wire ts;

    or O1 (ts, T);
    bufif0 B1 (IO, I, ts);
    notif0 N1 (IOB, I, ts);

    reg O_int;


    always @(IO or IOB) begin
        if (IO == 1'b1 && IOB == 1'b0)
            O_int <= IO;
        else if (IO == 1'b0 && IOB == 1'b1)
            O_int <= IO;
    end
    
    assign O = (IBUFDISABLE == 1'b1) ? 1'b0 : (IBUFDISABLE == 1'b0) ? O_int : 1'b0;


endmodule

`endcelldefine
