/*
Random I/Os for LSTM
*/

`include "../../random_number_generator.sv"

`define ARRAY_DEPTH 64      //Number of Hidden neurons
`define input wire logic_DEPTH 100	    //LSTM input wire logic vector dimensions
`define DATA_WIDTH 16		//16 bit representation
`define INWEIGHT_DEPTH 6400 //100x64
`define HWEIGHT_DEPTH 4096  //64x64
`define varraysize 1600   //100x16
`define uarraysize 1024  //64x16

module lstm_random (
input wire logic clk,
input wire logic reset,
input wire logic start,  		   //start the computation
input wire logic [6:0] start_addr,   //start address of the Xin bram (input wire logic words to LSTM)
input wire logic [6:0] end_addr,	  //end address of the Xin bram 
input wire logic wren_a,
input wire logic [`DATA_WIDTH-1:0] wdata_b,
output logic ht_valid,	//indicates the output logic ht_out is valid in those cycles
output logic [`DATA_WIDTH-1:0] ht_out, //output logic ht from the lstm
output logic cycle_complete,	//generates a pulse when a cycle fo 64 ht output logics are complete
output logic Done        //Stays high indicating the end of lstm output logic computation for all the Xin words provided.
);

logic [`uarraysize-1:0] wdata_u;
RandomNumberGenerator #(
    .RANDOM_WIDTH(`uarraysize),
    .SEED(0)
) rng0 (
    .clk(clk),
    .reset(reset),
    .random_number(wdata_u)
);

logic [`varraysize-1:0] wdata_v;
RandomNumberGenerator #(
    .RANDOM_WIDTH(`varraysize),
    .SEED(0)
) rng1 (
    .clk(clk),
    .reset(reset),
    .random_number(wdata_v)
);



top lstm0(
    clk,
    reset,
    start,  		   //start the computation
    start_addr,   //start address of the Xin bram (input words to LSTM)
    end_addr,	  //end address of the Xin bram 
    wren_a,
    wdata_u,
    wdata_v,
    wdata_b,
    ht_valid,	//indicates the output ht_out is valid in those cycles
    ht_out, //output ht from the lstm
    cycle_complete,	//generates a pulse when a cycle fo 64 ht outputs are complete
    Done        //Stays high indicating the end of lstm output computation for all the Xin words provided.
);

endmodule