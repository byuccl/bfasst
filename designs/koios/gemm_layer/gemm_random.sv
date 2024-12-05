/*
Random I/Os for gemm_layer
*/

`include "../../random_number_generator.sv"

`define BFLOAT16 

// IEEE Half Precision => EXPONENT = 5, MANTISSA = 10
// BFLOAT16 => EXPONENT = 8, MANTISSA = 7 

`ifdef BFLOAT16
`define EXPONENT 8
`define MANTISSA 7
`else // for ieee half precision fp16
`define EXPONENT 5
`define MANTISSA 10
`endif

`define SIGN 1
`define DWIDTH (`SIGN+`EXPONENT+`MANTISSA)

`define AWIDTH 8
`define MEM_SIZE 256

`define MAT_MUL_SIZE 20
`define MASK_WIDTH 20
//This define isn't needed for this design, because we set a_loc and b_loc to 0
`define LOG2_MAT_MUL_SIZE 4 

`define BB_MAT_MUL_SIZE `MAT_MUL_SIZE
`define NUM_CYCLES_IN_MAC 3
`define MEM_ACCESS_LATENCY 1
`define ADDR_STRIDE_WIDTH 8

module gemm_random #(
    parameter C_S00_AXI_DATA_WIDTH	= 32,
	parameter C_S00_AXI_ADDR_WIDTH	= 6
)(
    // User ports ends
    // Do not modify the ports beyond this line

    // Ports of Axi Slave Bus Interface S00_AXI
    input wire logic s00_axi_aclk,
    input wire logic s00_axi_aresetn,
    input wire logic[C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
    input wire logic[2 : 0] s00_axi_awprot,
    input wire logic s00_axi_awvalid,
    output logic  s00_axi_awready,
    input wire logic[C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
    input wire logic[(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
    input wire logic s00_axi_wvalid,
    output logic  s00_axi_wready,
    output logic [1 : 0] s00_axi_bresp,
    output logic  s00_axi_bvalid,
    input wire logic s00_axi_bready,
    input wire logic[C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
    input wire logic[2 : 0] s00_axi_arprot,
    input wire logic s00_axi_arvalid,
    output logic  s00_axi_arready,
    output logic [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
    output logic [1 : 0] s00_axi_rresp,
    output logic  s00_axi_rvalid,
    input wire logic s00_axi_rready,
    input wire logic [1:0] abc_sel,
    input wire logic [5:0] byte_sel,
    output logic [14:0] addr_out,
    output logic [7:0] data_out,
    output logic[`MASK_WIDTH-1:0] mask_out,
    output logic en_out
);

logic[`MAT_MUL_SIZE*`DWIDTH-1:0] bram_rdata [2:0];
generate
    genvar i;
    for (i=0; i<3; i=i+1) begin: gen_rng
        RandomNumberGenerator #(
            .RANDOM_WIDTH(`MAT_MUL_SIZE*`DWIDTH),
            .SEED(i)
        ) rng (
            .clk(s00_axi_aclk),
            .reset(s00_axi_aresetn),
            .random_number(bram_rdata[i])
        );
    end
endgenerate

logic [14:0] bram_addr [2:0];
logic [`MAT_MUL_SIZE*`DWIDTH-1:0] bram_wdata [2:0];
logic[`MASK_WIDTH-1:0] bram_we [2:0];	
logic bram_en [2:0];

assign en_out = (abc_sel[1:0] < 3) ? bram_en[abc_sel[1:0]] : 0;
assign addr_out = (abc_sel[1:0] < 3) ? bram_addr[abc_sel[1:0]] : 0;
assign mask_out = (abc_sel[1:0] < 3) ? bram_we[abc_sel[1:0]] : 0;


always_comb begin
    if (abc_sel[1:0] == 3) begin
        data_out = 0;
    end
    else begin
        case(byte_sel[5:0])
            6'd0: data_out = bram_wdata[abc_sel[1:0]][7:0];
            6'd1: data_out = bram_wdata[abc_sel[1:0]][15:8];
            6'd2: data_out = bram_wdata[abc_sel[1:0]][23:16];
            6'd3: data_out = bram_wdata[abc_sel[1:0]][31:24];
            6'd4: data_out = bram_wdata[abc_sel[1:0]][39:32];
            6'd5: data_out = bram_wdata[abc_sel[1:0]][47:40];
            6'd6: data_out = bram_wdata[abc_sel[1:0]][55:48];
            6'd7: data_out = bram_wdata[abc_sel[1:0]][63:56];
            6'd8: data_out = bram_wdata[abc_sel[1:0]][71:64];
            6'd9: data_out = bram_wdata[abc_sel[1:0]][79:72];
            6'd10: data_out = bram_wdata[abc_sel[1:0]][87:80];
            6'd11: data_out = bram_wdata[abc_sel[1:0]][95:88];
            6'd12: data_out = bram_wdata[abc_sel[1:0]][103:96];
            6'd13: data_out = bram_wdata[abc_sel[1:0]][111:104];
            6'd14: data_out = bram_wdata[abc_sel[1:0]][119:112];
            6'd15: data_out = bram_wdata[abc_sel[1:0]][127:120];
            6'd16: data_out = bram_wdata[abc_sel[1:0]][135:128];
            6'd17: data_out = bram_wdata[abc_sel[1:0]][143:136];
            6'd18: data_out = bram_wdata[abc_sel[1:0]][151:144];
            6'd19: data_out = bram_wdata[abc_sel[1:0]][159:152];
            6'd20: data_out = bram_wdata[abc_sel[1:0]][167:160];
            6'd21: data_out = bram_wdata[abc_sel[1:0]][175:168];
            6'd22: data_out = bram_wdata[abc_sel[1:0]][183:176];
            6'd23: data_out = bram_wdata[abc_sel[1:0]][191:184];
            6'd24: data_out = bram_wdata[abc_sel[1:0]][199:192];
            6'd25: data_out = bram_wdata[abc_sel[1:0]][207:200];
            6'd26: data_out = bram_wdata[abc_sel[1:0]][215:208];
            6'd27: data_out = bram_wdata[abc_sel[1:0]][223:216];
            6'd28: data_out = bram_wdata[abc_sel[1:0]][231:224];
            6'd29: data_out = bram_wdata[abc_sel[1:0]][239:232];
            6'd30: data_out = bram_wdata[abc_sel[1:0]][247:240];
            6'd31: data_out = bram_wdata[abc_sel[1:0]][255:248];
            6'd32: data_out = bram_wdata[abc_sel[1:0]][263:256];
            6'd33: data_out = bram_wdata[abc_sel[1:0]][271:264];
            6'd34: data_out = bram_wdata[abc_sel[1:0]][279:272];
            6'd35: data_out = bram_wdata[abc_sel[1:0]][287:280];
            6'd36: data_out = bram_wdata[abc_sel[1:0]][295:288];
            6'd37: data_out = {3'b0, bram_wdata[abc_sel[1:0]][300:296]};
            default: data_out = 0;
        endcase
    end
end


gemm_layer #(
    .C_S00_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH),
    .C_S00_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH)
) gemm(
    bram_addr[0],
    bram_rdata[0],
    bram_wdata[0],
    bram_we[0],	
    bram_en[0],
    bram_addr[1],
    bram_rdata[1],
    bram_wdata[1],
    bram_we[1],	
    bram_en[1],
    bram_addr[2],
    bram_rdata[2],
    bram_wdata[2],
    bram_we[2],	
    bram_en[2],
    s00_axi_aclk,
    s00_axi_aresetn,
    s00_axi_awaddr,
    s00_axi_awprot,
    s00_axi_awvalid,
    s00_axi_awready,
    s00_axi_wdata,
    s00_axi_wstrb,
    s00_axi_wvalid,
    s00_axi_wready,
    s00_axi_bresp,
    s00_axi_bvalid,
    s00_axi_bready,
    s00_axi_araddr,
    s00_axi_arprot,
    s00_axi_arvalid,
    s00_axi_arready,
    s00_axi_rdata,
    s00_axi_rresp,
    s00_axi_rvalid,
    s00_axi_rready
);


endmodule