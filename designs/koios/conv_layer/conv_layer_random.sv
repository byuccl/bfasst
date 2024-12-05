/*
Random inputs to conv layer
*/ 

`include "../../random_number_generator.sv"

`define DWIDTH 16
`define AWIDTH 10
`define MEM_SIZE 1024
`define DESIGN_SIZE 8
`define MAT_MUL_SIZE 4
`define MASK_WIDTH 4
`define LOG2_MAT_MUL_SIZE 2
`define NUM_CYCLES_IN_MAC 3
`define MEM_ACCESS_LATENCY 1
`define REG_DATAWIDTH 32
`define REG_ADDRWIDTH 8
`define ADDR_STRIDE_WIDTH 16
`define REG_STDN_TPU_ADDR 32'h4
`define REG_MATRIX_A_ADDR 32'he
`define REG_MATRIX_B_ADDR 32'h12
`define REG_MATRIX_C_ADDR 32'h16
`define REG_VALID_MASK_A_ROWS_ADDR 32'h20
`define REG_VALID_MASK_A_COLS_ADDR 32'h54
`define REG_VALID_MASK_B_ROWS_ADDR 32'h5c
`define REG_VALID_MASK_B_COLS_ADDR 32'h58
`define REG_MATRIX_A_STRIDE_ADDR 32'h28
`define REG_MATRIX_B_STRIDE_ADDR 32'h32
`define REG_MATRIX_C_STRIDE_ADDR 32'h36
`define ADDRESS_BASE_A 10'd0
`define ADDRESS_BASE_B 10'd0
`define ADDRESS_BASE_C 10'd0

module conv_layer_random(
  input logic clk,
  input logic clk_mem,
  input logic resetn,
  input logic pe_resetn,
  input logic start,
  output logic done,
  input  logic [7:0] bram_select,
  output logic [`MAT_MUL_SIZE*`DWIDTH-1:0] bram_rdata_ext
);

logic [`AWIDTH-1:0] bram_addr_ext;
RandomNumberGenerator #(
  .RANDOM_WIDTH(`AWIDTH),
  .SEED(0)
) rng (
  .clk(clk),
  .reset(resetn),
  .random_number(bram_addr_ext)
);

logic [`MAT_MUL_SIZE*`DWIDTH-1:0] bram_wdata_ext;
RandomNumberGenerator #(
  .RANDOM_WIDTH(`MAT_MUL_SIZE*`DWIDTH),
  .SEED(0)
) rng2 (
  .clk(clk),
  .reset(resetn),
  .random_number(bram_wdata_ext)
);

logic [`MAT_MUL_SIZE-1:0] bram_we_ext;
RandomNumberGenerator #(
  .RANDOM_WIDTH(`MAT_MUL_SIZE),
  .SEED(0)
) rng3 (
  .clk(clk),
  .reset(resetn),
  .random_number(bram_we_ext)
);

conv_layer(
    clk,
    clk_mem,
    resetn,
    pe_resetn,
    start,
    done,
    bram_select,
    bram_addr_ext,
    bram_rdata_ext,
    bram_wdata_ext,
    bram_we_ext
);

endmodule