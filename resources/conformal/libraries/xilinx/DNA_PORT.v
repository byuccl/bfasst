///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                       Device DNA Data Access Port
// /___/   /\     Filename : DNA_PORT.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    10/10/05 - Initial version.
//    05/29/07 - Added wire declaration for internal signals
//    06/04/08 - CR 472697 -- added check for SIM_DNA_VALUE
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module DNA_PORT (DOUT, CLK, DIN, READ, SHIFT);

    parameter [56:0] SIM_DNA_VALUE = 57'h0;

`ifdef XIL_TIMING
 
  parameter LOC = "UNPLACED";

`endif

    output DOUT;

    input  CLK, DIN, READ, SHIFT;

    wire  GSR = 1'b0;

    localparam MAX_DNA_BITS = 57;
    localparam MSB_DNA_BITS = MAX_DNA_BITS - 1;

    reg [MSB_DNA_BITS:0] dna_val = SIM_DNA_VALUE;
    reg dout_out;
    

    wire clk_in, din_in, gsr_in, read_in, shift_in;

    buf b_dout  (DOUT, dout_out);
    buf b_clk   (clk_in, CLK);
    buf b_din   (din_in, DIN);
    buf buf_gsr (gsr_in, GSR);
    buf b_read  (read_in, READ);
    buf b_shift (shift_in, SHIFT);

    initial begin
       dna_val = SIM_DNA_VALUE;
       if(dna_val[MSB_DNA_BITS : (MSB_DNA_BITS -1)] != 2'b10)
        begin
             $display("Attribute Syntax Warning : SIM_DNA_VALUE bits [56:55] on instance %m do not match the expected value \"10\". The simulation will not exactly model the hardware behavior, as detailed in the Spartan-3 Generation FPGA User Guide");
        end     

    end

//  GSR has no effect
    
    always @(posedge clk_in) begin
       if(read_in == 1'b1) begin
          dna_val = SIM_DNA_VALUE;
          dout_out = 1'b1;
       end // read_in == 1'b1
       else if(read_in == 1'b0)
               if(shift_in == 1'b1) begin
                   dna_val = {din_in, dna_val[MSB_DNA_BITS :1]};
                   dout_out = dna_val[0];
               end  // shift_in == 1'b1
    end // always @ (posedge clk_in)


endmodule

`endcelldefine
