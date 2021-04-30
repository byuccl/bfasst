///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Clock Buffer
// /___/   /\     Filename : AUTOBUF.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/08/08 - Initial version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module AUTOBUF (O, I);

    parameter BUFFER_TYPE = "AUTO";
 
`ifdef XIL_TIMING //Simprim

  parameter LOC = "UNPLACED";

`endif


    output O;

    input  I;

    initial begin
    case (BUFFER_TYPE)
      "AUTO" : ;
      "BUFG" : ;
      "BUFH" : ;
      "BUFIO" : ;
      "BUFR" : ;
      "IBUF" : ;
      default : begin
        $display("Attribute Syntax Error : The Attribute BUFFER_TYPE on AUTOBUF instance %m is set to %s.  Legal values for this attribute are AUTO, BUFG, BUFH, BUFIO, BUFR and IBUF.", BUFFER_TYPE);
      end
    endcase
    end

  buf B1 (O, I);


endmodule

`endcelldefine
