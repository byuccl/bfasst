/*
Random I/Os for TPU
*/

`include "../../random_number_generator.sv"

`define DWIDTH 8

//This is the size of the matrix multiplier unit. In this design, we have a systolic
//matrix multiplication unit that can multiply 32x32 matrix with a 32x32 matrix.
`define DESIGN_SIZE 32
`define LOG2_DESIGN_SIZE 5
`define MAT_MUL_SIZE 32
`define MASK_WIDTH 32
`define LOG2_MAT_MUL_SIZE 5

//This it the size of the address bus, or the depth of the RAM. Each location of 
//the RAM is DWIDTH * MAT_MUL_SIZE wide. So, in this design, we use a total of
//1024 * 32 bytes of memory (i.e. 32 KB).
`define AWIDTH 10

//This is the number of clock cycles spent in the mac block
`define NUM_CYCLES_IN_MAC 3

//This defines the latency of accessing data from a block ram
`define MEM_ACCESS_LATENCY 1

//Data width and address width of the APB interface for registers
`define REG_DATAWIDTH 32
`define REG_ADDRWIDTH 8

//Width of the stride for each column in the matrices (same as ram address width)
`define ADDR_STRIDE_WIDTH 16

//Number of bits to specify the pooling window. We support 3 sizes.
`define MAX_BITS_POOL 3

module tpu_random(
    input wire logic clk,
    input wire logic reset,
    input wire logic resetn,
    input wire logic [`REG_ADDRWIDTH-1:0] PADDR,
    input wire logic PWRITE,
    input wire logic PSEL,
    input wire logic PENABLE,
    input wire logic [`REG_DATAWIDTH-1:0] PWDATA,
    output logic [`REG_DATAWIDTH-1:0] PRDATA,
    output logic PREADY,
    input wire logic [`AWIDTH-1:0] bram_addr_a_ext,
    input wire logic [`DESIGN_SIZE-1:0] bram_we_a_ext,
    input wire logic [`AWIDTH-1:0] bram_addr_b_ext,
    input wire logic [`DESIGN_SIZE-1:0] bram_we_b_ext,
    input wire logic [5:0] o_sel,
    output logic [7:0] o_data
);

logic clk_mem;
assign clk_mem = clk;

logic [`DESIGN_SIZE*`DWIDTH-1:0] bram_wdata_a_ext;
logic [`DESIGN_SIZE*`DWIDTH-1:0] bram_wdata_b_ext;

RandomNumberGenerator #(
    .RANDOM_WIDTH(`DESIGN_SIZE*`DWIDTH),
    .SEED(0)
) rng (
    .clk(clk),
    .reset(reset),
    .random_number(bram_wdata_a_ext)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(`DESIGN_SIZE*`DWIDTH),
    .SEED(0)
) rng2 (
    .clk(clk),
    .reset(reset),
    .random_number(bram_wdata_b_ext)
);

logic [`DESIGN_SIZE*`DWIDTH-1:0] bram_rdata[1:0];

always_comb begin
    case(o_sel[5:1]) 
        5'd0: o_data = bram_rdata[o_sel[0]][7:0];
        5'd1: o_data = bram_rdata[o_sel[0]][15:8];
        5'd2: o_data = bram_rdata[o_sel[0]][23:16];
        5'd3: o_data = bram_rdata[o_sel[0]][31:24];
        5'd4: o_data = bram_rdata[o_sel[0]][39:32];
        5'd5: o_data = bram_rdata[o_sel[0]][47:40];
        5'd6: o_data = bram_rdata[o_sel[0]][55:48];
        5'd7: o_data = bram_rdata[o_sel[0]][63:56];
        5'd8: o_data = bram_rdata[o_sel[0]][71:64];
        5'd9: o_data = bram_rdata[o_sel[0]][79:72];
        5'd10: o_data = bram_rdata[o_sel[0]][87:80];
        5'd11: o_data = bram_rdata[o_sel[0]][95:88];
        5'd12: o_data = bram_rdata[o_sel[0]][103:96];
        5'd13: o_data = bram_rdata[o_sel[0]][111:104];
        5'd14: o_data = bram_rdata[o_sel[0]][119:112];
        5'd15: o_data = bram_rdata[o_sel[0]][127:120];
        5'd16: o_data = bram_rdata[o_sel[0]][135:128];
        5'd17: o_data = bram_rdata[o_sel[0]][143:136];
        5'd18: o_data = bram_rdata[o_sel[0]][151:144];
        5'd19: o_data = bram_rdata[o_sel[0]][159:152];
        5'd20: o_data = bram_rdata[o_sel[0]][167:160];
        5'd21: o_data = bram_rdata[o_sel[0]][175:168];
        5'd22: o_data = bram_rdata[o_sel[0]][183:176];
        5'd23: o_data = bram_rdata[o_sel[0]][191:184];
        5'd24: o_data = bram_rdata[o_sel[0]][199:192];
        5'd25: o_data = bram_rdata[o_sel[0]][207:200];
        5'd26: o_data = bram_rdata[o_sel[0]][215:208];
        5'd27: o_data = bram_rdata[o_sel[0]][223:216];
        5'd28: o_data = bram_rdata[o_sel[0]][231:224];
        5'd29: o_data = bram_rdata[o_sel[0]][239:232];
        5'd30: o_data = bram_rdata[o_sel[0]][247:240];
        5'd31: o_data = bram_rdata[o_sel[0]][255:248];
        default: o_data = 8'b0;
    endcase
end



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