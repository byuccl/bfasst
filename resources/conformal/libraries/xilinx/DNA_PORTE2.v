///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2015 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \   \   \/      Version     : 2015.4
//  \   \          Description : Xilinx Formal Library Component
//  /   /                        
// /___/   /\      Filename    : DNA_PORTE2.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//     01/15/14 - Initial version.
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module DNA_PORTE2 #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter [95:0] SIM_DNA_VALUE = 96'h000000000000000000000000
)(
  output DOUT,

  input CLK,
  input DIN,
  input READ,
  input SHIFT
);
  
   reg [95:0] SIM_DNA_VALUE_reg = SIM_DNA_VALUE;

   tri0 GSR = 1'b0;
   
   localparam MAX_DNA_BITS = 96;
   localparam MSB_DNA_BITS = MAX_DNA_BITS - 1;
   
   reg [MSB_DNA_BITS:0] dna_val = SIM_DNA_VALUE;
   reg dout_out;

   wire clk_in;
   wire din_in;
   wire read_in;
   wire shift_in;
   
   assign DOUT = dout_out;
   assign clk_in = CLK;
   assign din_in = DIN;
   assign read_in = READ;
   assign shift_in = SHIFT;
   
   always @(posedge clk_in) begin
      if(read_in == 1'b1) begin
         dna_val = SIM_DNA_VALUE_reg;
         dout_out = 1'b1;
      end // read_in == 1'b1
      else if(read_in == 1'b0)
        if(shift_in == 1'b1) begin
           dna_val = {dna_val[MSB_DNA_BITS-1 : 0], din_in};
           dout_out = dna_val[MSB_DNA_BITS];
        end  // shift_in == 1'b1
   end // always @ (posedge clk_in)

endmodule

`endcelldefine
