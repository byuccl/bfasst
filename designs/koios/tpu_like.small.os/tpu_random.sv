/*
Random I/Os for TPU
*/

`include "../../random_number_generator.sv"

//The width of the data. This design uses int8 precision. So, DWIDTH is 8
//To change to a floating point 16 version, change this to 16 and also
//change the datapath components (like adder and multiplier) to be floating point. 
`define DWIDTH 8

//This is the size of the matrix multiplier unit. In this design, we have a systolic
//matrix multiplication unit that can multiply 16x16 matrix with a 16x16 matrix.
`define DESIGN_SIZE 16
`define LOG2_DESIGN_SIZE 5
`define MAT_MUL_SIZE 16
`define MASK_WIDTH 16
`define LOG2_MAT_MUL_SIZE 5

//This it the size of the address bus, or the depth of the RAM. Each location of 
//the RAM is DWIDTH * MAT_MUL_SIZE wide. So, in this design, we use a total of
//1024 * 16 bytes of memory (i.e. 16 KB).
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
    input wire logic clk_mem,
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
    input wire logic [4:0] o_sel,
    output logic [7:0] o_data
);

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
    case(o_sel[4:1]) 
        4'd0: o_data = bram_rdata[o_sel[0]][7:0];
        4'd1: o_data = bram_rdata[o_sel[0]][15:8];
        4'd2: o_data = bram_rdata[o_sel[0]][23:16];
        4'd3: o_data = bram_rdata[o_sel[0]][31:24];
        4'd4: o_data = bram_rdata[o_sel[0]][39:32];
        4'd5: o_data = bram_rdata[o_sel[0]][47:40];
        4'd6: o_data = bram_rdata[o_sel[0]][55:48];
        4'd7: o_data = bram_rdata[o_sel[0]][63:56];
        4'd8: o_data = bram_rdata[o_sel[0]][71:64];
        4'd9: o_data = bram_rdata[o_sel[0]][79:72];
        4'd10: o_data = bram_rdata[o_sel[0]][87:80];
        4'd11: o_data = bram_rdata[o_sel[0]][95:88];
        4'd12: o_data = bram_rdata[o_sel[0]][103:96];
        4'd13: o_data = bram_rdata[o_sel[0]][111:104];
        4'd14: o_data = bram_rdata[o_sel[0]][119:112];
        4'd15: o_data = bram_rdata[o_sel[0]][127:120];
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