///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  2-INPUT MUX
// /___/   /\     Filename : FORMAL_MUX2.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
// simprim primitive
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps/1 ps

`celldefine

module FORMAL_MUX2 (O, IA, IB, SEL);

  output O;
  input IA, IB, SEL;

  mux (O, IA, IB, SEL);

endmodule

`endcelldefine

`celldefine

primitive mux (out, ina, inb, sel);

  output out;
  input  ina, inb, sel;

  table

   //    ina   inb   sel   out;

          0     ?     0  :  0;
          1     ?     0  :  1;
          ?     0     1  :  0;
          ?     1     1  :  1;
          0     0     x  :  0;
          1     1     x  :  1;

  endtable

endprimitive

`endcelldefine
