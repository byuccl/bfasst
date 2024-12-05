/*
* mcml top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../../random_number_generator.sv"

module mcml_random(
    input logic reset,
	input logic clk,
	input logic read_constants,
    output logic [31:0] result, 
	input logic inc_result,
    output calc_in_progress,
    output logic [31:0] c_const__103,
    output logic [31:0] c_const__102,
    output logic [31:0] c_const__101, 
    output logic [31:0] c_const__100, 
    output logic [31:0] c_const__99,
	output logic absorb_wren_mux, 
    output logic [3:0] r_state, 
    output logic [3:0] c_state
    );

logic [31:0] constants;
logic [15:0] c_absorb_read_counter;
logic [15:0] c_absorb_write_counter;
logic [15:0] absorb_rdaddress_mux;
logic [15:0] absorb_wraddress_mux;
logic [63:0] absorb_data_mux;
logic [12:0] r_counter;
logic [12:0] c_counter; 

RandomNumberGenerator #(32, 3) rng_constants (
  .clk(clk),
  .reset(reset),
  .random_number(constants[31:0])
);

RandomNumberGenerator #(16, 5) rng_c_absorb_read_counter (
  .clk(clk),
  .reset(reset),
  .random_number(c_absorb_read_counter[15:0])
);

RandomNumberGenerator #(16, 7) rng_c_absorb_write_counter (
  .clk(clk),
  .reset(reset),
  .random_number(c_absorb_write_counter[15:0])
);

RandomNumberGenerator #(16, 9) rng_absorb_rdaddress_mux (
  .clk(clk),
  .reset(reset),
  .random_number(absorb_rdaddress_mux[15:0])
);

RandomNumberGenerator #(16, 11) rng_absorb_wraddress_mux (
  .clk(clk),
  .reset(reset),
  .random_number(absorb_wraddress_mux[15:0])
);

RandomNumberGenerator #(64, 13) rng_absorb_data_mux (
  .clk(clk),
  .reset(reset),
  .random_number(absorb_data_mux[63:0])
);

RandomNumberGenerator #(13, 15) rng_r_counter (
  .clk(clk),
  .reset(reset),
  .random_number(r_counter[12:0])
);

RandomNumberGenerator #(13, 17) rng_c_counter (
  .clk(clk),
  .reset(reset),
  .random_number(c_counter[12:0])
);

mcml mcml (
    .reset(reset),
	.clk(clk),
    .constants(constants[31:0]),
	.read_constants(read_constants),
    .result(result[31:0]), 
	.inc_result(inc_result),
    .calc_in_progress(calc_in_progress),
    .c_absorb_read_counter(c_absorb_read_counter[15:0]), 
    .c_absorb_write_counter(c_absorb_write_counter[15:0]),
	.absorb_rdaddress_mux(absorb_rdaddress_mux[15:0]), 
    .absorb_wraddress_mux(absorb_wraddress_mux[15:0]),
	.absorb_data_mux(absorb_data_mux[63:0]),
	.absorb_wren_mux(absorb_wren_mux), 
    .r_state(r_state[3:0]), 
    .c_state(c_state[3:0]), 
	.r_counter(r_counter[12:0]), 
	.c_counter(c_counter[12:0]), 
    .c_const__103(c_const__103[31:0]), 
    .c_const__102(c_const__102[31:0]), 
    .c_const__101(c_const__101[31:0]), 
    .c_const__100(c_const__100[31:0]), 
    .c_const__99(c_const__99[31:0])
    );

endmodule