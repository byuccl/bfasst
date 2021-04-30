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
// /___/   /\     Filename : IOBUFDS_DIFF_OUT.v
// \   \  /  \
//  \___\/\___\
//
// Revision:
//    01/19/09 - Initial version.
//    01/28/09 - Reflected RC's feedback.
//    07/24/14 - Added missing parameter (CR 806964).
// End Revision

`timescale  1 ps / 1 ps

`celldefine

module IOBUFDS_DIFF_OUT (O, OB, IO, IOB, I, TM, TS);

    parameter DIFF_TERM = "FALSE";
    parameter DQS_BIAS = "FALSE";
    parameter IBUF_LOW_PWR = "TRUE";
    parameter IOSTANDARD = "DEFAULT";

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif

    output O;
    output OB;
    inout  IO;
    inout  IOB;
    input  I;
    input  TM;
    input  TS;

    wire t1, t2;

    wire GTS = 1'b0;

    reg O, OB;
    
    or O1 (t1, GTS, TM);
    bufif0 B1 (IO, I, t1);

    or O2 (t2, GTS, TS);
    notif0 N2 (IOB, I, t2);

    initial begin
  
        case (DIFF_TERM)

            "TRUE", "FALSE" : ;
            default : begin
                          $display("Attribute Syntax Error : The attribute DIFF_TERM on IOBUFDS_DIFF_OUT instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", DIFF_TERM);
                          $finish;
                      end

        endcase // case(DIFF_TERM)

    end


    always @(IO or IOB) begin
        if (IO == 1'b1 && IOB == 1'b0) begin
            O  = IO;
            OB = ~IO;
        end
        else if (IO == 1'b0 && IOB == 1'b1) begin
            O  = IO;
            OB = ~IO;
        end
    end
    
endmodule

`endcelldefine
