/*
Random I/Os for softmax module
*/

`include "../../random_number_generator.sv"

`ifndef DEFINES_DONE
`define DEFINES_DONE
`define EXPONENT 5
`define MANTISSA 10
`define SIGN 1
`define DATAWIDTH (`SIGN+`EXPONENT+`MANTISSA)
`define IEEE_COMPLIANCE 1
`define NUM 8
`define ADDRSIZE 7
`define ADDRSIZE_FOR_TB 10
`endif

module softmax_random (
    input wire logic clk,
    input wire logic reset,
    input wire logic start,
    input wire logic init,

    input wire logic  [`ADDRSIZE-1:0]       end_addr,
    input wire logic  [`ADDRSIZE-1:0]       start_addr,

    output logic [`ADDRSIZE-1 :0] addr,
    output logic  [`ADDRSIZE-1:0] sub0_inp_addr,
    output logic  [`ADDRSIZE-1:0] sub1_inp_addr,

    output logic [2:0] sel,
    output logic [`DATAWIDTH-1:0] max_out,
    output logic done
);

logic [`DATAWIDTH-1:0] outp[3:0];
assign max_out = outp[sel[2:0]];

logic  [`DATAWIDTH*`NUM-1:0] inp [2:0];
generate
    genvar i;
    for (i=0; i<`NUM; i=i+1) begin
        RandomNumberGenerator #(
            .RANDOM_WIDTH(`DATAWIDTH*`NUM),
            .SEED(i)
        ) rng0 (
            .clk(clk),
            .reset(reset),
            .random_number(inp[i])
        );
    end
endgenerate

softmax sm0(
  inp[0],      //data in from memory to max block
  inp[1], //data inputs from memory to first-stage subtractors
  inp[2], //data inputs from memory to second-stage subtractors

  start_addr,   //the first address that contains input wire logic data in the on-chip memory
  end_addr,     //max address containing required data

  addr,          //address corresponding to data inp
  sub0_inp_addr, //address corresponding to sub0_inp
  sub1_inp_addr, //address corresponding to sub1_inp

  outp[0],
  outp[1],
  outp[2],
  outp[3],
  outp[4],
  outp[5],
  outp[6],
  outp[7],

  clk,
  reset,
  init,   //the signal indicating to latch the new start address
  done,   //done signal asserts when the softmax calculation is over
  start);

endmodule