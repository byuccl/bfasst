/*
Random I/Os for tpu.ws
*/

`include "../../random_number_generator.sv"

`define VCS
`define MATMUL_SIZE_32 
`define MORE_TESTS
`define DESIGN_SIZE_32
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
    input wire logic clk,
    input wire logic reset,
    input wire logic resetn,
    input wire logic[`REG_ADDRWIDTH-1:0] PADDR,
    input wire logic PWRITE,
    input wire logic PSEL,
    input wire logic PENABLE,
    input wire logic[`REG_DATAWIDTH-1:0] PWDATA,
    output logic[`REG_DATAWIDTH-1:0] PRDATA,
    output logic PREADY,
    input wire logic[`AWIDTH-1:0] bram_addr_a_ext,
    input wire logic[`DESIGN_SIZE-1:0] bram_we_a_ext,
    input wire logic[`AWIDTH-1:0] bram_addr_b_ext,
    input wire logic[`DESIGN_SIZE-1:0] bram_we_b_ext,
    input wire logic[5:0] out_sel,
    output logic [7:0] out
);

logic clk_mem;
assign clk_mem = clk;

logic[`DESIGN_SIZE*`DWIDTH-1:0] bram_rdata[1:0];
always_comb begin
    case(out_sel[5:1])
        5'd0: out = bram_rdata[out_sel[0]][7:0];
        5'd1: out = bram_rdata[out_sel[0]][15:8];
        5'd2: out = bram_rdata[out_sel[0]][23:16];
        5'd3: out = bram_rdata[out_sel[0]][31:24];
        5'd4: out = bram_rdata[out_sel[0]][39:32];
        5'd5: out = bram_rdata[out_sel[0]][47:40];
        5'd6: out = bram_rdata[out_sel[0]][55:48];
        5'd7: out = bram_rdata[out_sel[0]][63:56];
        5'd8: out = bram_rdata[out_sel[0]][71:64];
        5'd9: out = bram_rdata[out_sel[0]][79:72];
        5'd10: out = bram_rdata[out_sel[0]][87:80];
        5'd11: out = bram_rdata[out_sel[0]][95:88];
        5'd12: out = bram_rdata[out_sel[0]][103:96];
        5'd13: out = bram_rdata[out_sel[0]][111:104];
        5'd14: out = bram_rdata[out_sel[0]][119:112];
        5'd15: out = bram_rdata[out_sel[0]][127:120];
        5'd16: out = bram_rdata[out_sel[0]][135:128];
        5'd17: out = bram_rdata[out_sel[0]][143:136];
        5'd18: out = bram_rdata[out_sel[0]][151:144];
        5'd19: out = bram_rdata[out_sel[0]][159:152];
        5'd20: out = bram_rdata[out_sel[0]][167:160];
        5'd21: out = bram_rdata[out_sel[0]][175:168];
        5'd22: out = bram_rdata[out_sel[0]][183:176];
        5'd23: out = bram_rdata[out_sel[0]][191:184];
        5'd24: out = bram_rdata[out_sel[0]][199:192];
        5'd25: out = bram_rdata[out_sel[0]][207:200];
        5'd26: out = bram_rdata[out_sel[0]][215:208];
        5'd27: out = bram_rdata[out_sel[0]][223:216];
        5'd28: out = bram_rdata[out_sel[0]][231:224];
        5'd29: out = bram_rdata[out_sel[0]][239:232];
        5'd30: out = bram_rdata[out_sel[0]][247:240];
        5'd31: out = bram_rdata[out_sel[0]][255:248];
    endcase
end


logic[`DESIGN_SIZE*`DWIDTH-1:0] bram_wdata_a_ext;
logic[`DESIGN_SIZE*`DWIDTH-1:0] bram_wdata_b_ext;
RandomNumberGenerator #(
    .RANDOM_WIDTH(`DESIGN_SIZE*`DWIDTH),
    .SEED(0)
) tpu0_random_number_generator (
    .clk(clk),
    .reset(reset),
    .random_number(bram_wdata_a_ext)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(`DESIGN_SIZE*`DWIDTH),
    .SEED(1)
) tpu1_random_number_generator (
    .clk(clk),
    .reset(reset),
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