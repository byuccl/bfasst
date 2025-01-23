/*
Random I/Os for tpu.ws
*/

`include "../../random_number_generator.sv"

`define VCS
`define MATMUL_SIZE_16 
`define MORE_TESTS
`define DESIGN_SIZE_16
`define SIMULATION
`define layer_test

`define DWIDTH 8
`define AWIDTH 11
`define MEM_SIZE 2048

`ifdef MATMUL_SIZE_4
`define MAT_MUL_SIZE 4
`define MASK_WIDTH 4
`define LOG2_MAT_MUL_SIZE 2
`endif

`ifdef MATMUL_SIZE_8
`define MAT_MUL_SIZE 8
`define MASK_WIDTH 8
`define LOG2_MAT_MUL_SIZE 3
`endif

`ifdef MATMUL_SIZE_16
`define MAT_MUL_SIZE 16
`define MASK_WIDTH 16
`define LOG2_MAT_MUL_SIZE 4
`endif

`ifdef MATMUL_SIZE_32
`define MAT_MUL_SIZE 32
`define MASK_WIDTH 32
`define LOG2_MAT_MUL_SIZE 5
`endif

`ifdef DESIGN_SIZE_4
`define DESIGN_SIZE 4
`define LOG2_DESIGN_SIZE 2
`endif

`ifdef DESIGN_SIZE_8
`define DESIGN_SIZE 8
`define LOG2_DESIGN_SIZE 3
`endif

`ifdef DESIGN_SIZE_16
`define DESIGN_SIZE 16
`define LOG2_DESIGN_SIZE 4
`endif

`ifdef DESIGN_SIZE_32
`define DESIGN_SIZE 32
`define LOG2_DESIGN_SIZE 5
`endif

`define BB_MAT_MUL_SIZE `MAT_MUL_SIZE
`define NUM_CYCLES_IN_MAC 3
`define MEM_ACCESS_LATENCY 1
`define REG_DATAWIDTH 32
`define REG_ADDRWIDTH 8
`define ADDR_STRIDE_WIDTH 8
`define MAX_BITS_POOL 3

module tpu_random (
    input wire logicclk,
    input wire logicclk_mem,
    input wire logicreset,
    input wire logicresetn,
    input wire logic[`REG_ADDRWIDTH-1:0] PADDR,
    input wire logicPWRITE,
    input wire logicPSEL,
    input wire logicPENABLE,
    input wire logic[`REG_DATAWIDTH-1:0] PWDATA,
    output logic[`REG_DATAWIDTH-1:0] PRDATA,
    output logicPREADY,
    input wire logic[`AWIDTH-1:0] bram_addr_a_ext,
    input wire logic[`DESIGN_SIZE-1:0] bram_we_a_ext,
    input wire logic[`AWIDTH-1:0] bram_addr_b_ext,
    input wire logic[`DESIGN_SIZE-1:0] bram_we_b_ext,
    input wire logic[4:0] out_sel,
    output logic [7:0] out
);

logic[`DESIGN_SIZE*`DWIDTH-1:0] bram_rdata[1:0];
always_comb begin
    case(out_sel[4:1])
        4'd0: out = bram_rdata[out_sel[0]][7:0];
        4'd1: out = bram_rdata[out_sel[0]][15:8];
        4'd2: out = bram_rdata[out_sel[0]][23:16];
        4'd3: out = bram_rdata[out_sel[0]][31:24];
        4'd4: out = bram_rdata[out_sel[0]][39:32];
        4'd5: out = bram_rdata[out_sel[0]][47:40];
        4'd6: out = bram_rdata[out_sel[0]][55:48];
        4'd7: out = bram_rdata[out_sel[0]][63:56];
        4'd8: out = bram_rdata[out_sel[0]][71:64];
        4'd9: out = bram_rdata[out_sel[0]][79:72];
        4'd10: out = bram_rdata[out_sel[0]][87:80];
        4'd11: out = bram_rdata[out_sel[0]][95:88];
        4'd12: out = bram_rdata[out_sel[0]][103:96];
        4'd13: out = bram_rdata[out_sel[0]][111:104];
        4'd14: out = bram_rdata[out_sel[0]][119:112];
        4'd15: out = bram_rdata[out_sel[0]][127:120];
    endcase
end


logic[`DESIGN_SIZE*`DWIDTH-1:0] bram_wdata_a_ext;
logic[`DESIGN_SIZE*`DWIDTH-1:0] bram_wdata_b_ext;
RandomNumberGenerator #(
    .RANDOM_WIDTH(`DESIGN_SIZE*`DWIDTH),
    .SEED(0)
) tpu0_random_number_generator (
    .clk(logicclk),
    .reset(logicreset),
    .random_number(bram_wdata_a_ext)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(`DESIGN_SIZE*`DWIDTH),
    .SEED(1)
) tpu1_random_number_generator (
    .clk(logicclk),
    .reset(logicreset),
    .random_number(bram_wdata_b_ext)
);

top tpu0(
    clk,
    clk_mem,
    reset,
    resetn,
    PADDR,
    PWRITE,
    PSEL,
    PENABLE,
    PWDATA,
    PRDATA,
    PREADY,
    bram_addr_a_ext,
    bram_rdata[0],
    bram_wdata_a_ext,
    bram_we_a_ext,
    bram_addr_b_ext,
    bram_rdata[1],
    bram_wdata_b_ext,
    bram_we_b_ext
);

endmodule