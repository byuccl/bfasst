/*
* bgm top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../../random_number_generator.sv"

module bgm_random(
    input logic clk, 
	input logic reset,
	output logic [31:0] Fn_out
    );

logic [31:0] sigma_a;
logic [31:0] sigma_b;
logic [31:0] sigma_c;
logic [31:0] Fn;
logic [31:0] dw_x;
logic [31:0] dw_y;
logic [31:0] dw_z;
logic [31:0] dt;

RandomNumberGenerator #(32, 3) rng_sigma_a (
  .clk(clk),
  .reset(reset),
  .random_number(sigma_a[31:0])
);

RandomNumberGenerator #(32, 5) rng_sigma_b (
  .clk(clk),
  .reset(reset),
  .random_number(sigma_b[31:0])
);

RandomNumberGenerator #(32, 7) rng_sigma_c (
  .clk(clk),
  .reset(reset),
  .random_number(sigma_c[31:0])
);

RandomNumberGenerator #(32, 9) rng_Fn (
  .clk(clk),
  .reset(reset),
  .random_number(Fn[7:0])
);

RandomNumberGenerator #(32, 11) rng_dw_x (
  .clk(clk),
  .reset(reset),
  .random_number(dw_x[31:0])
);

RandomNumberGenerator #(32, 13) rng_dw_y (
  .clk(clk),
  .reset(reset),
  .random_number(dw_y[31:0])
);

RandomNumberGenerator #(32, 15) rng_dw_z (
  .clk(clk),
  .reset(reset),
  .random_number(dw_z[31:0])
);

RandomNumberGenerator #(32, 17) rng_dt (
  .clk(clk),
  .reset(reset),
  .random_number(dt[31:0])
);

bgm bgm (
    .clock(clk), 
	.reset(reset),
	.sigma_a(sigma_a[31:0]), 
	.sigma_b(sigma_b[31:0]), 
	.sigma_c(sigma_c[31:0]),
	.Fn(Fn[31:0]),
	.dw_x(dw_x[31:0]),
	.dw_y(dw_y[31:0]),
	.dw_z(dw_z[31:0]),
	.dt(dt[31:0]),
	.Fn_out(Fn_out[31:0])
    );

endmodule