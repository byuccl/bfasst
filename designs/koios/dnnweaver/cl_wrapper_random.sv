/*
Random I/Os to cl_wrapper for dnnweaver
*/

`include "../../random_number_generator.sv"

module cl_wrapper_random #(
    parameter integer  INST_W   = 32,
    parameter integer  INST_ADDR_W   = 5,
    parameter integer  IFIFO_ADDR_W  = 10,
    parameter integer  BUF_TYPE_W    = 2,
    parameter integer  OP_CODE_W= 5,
    parameter integer  OP_SPEC_W= 6,
    parameter integer  LOOP_ID_W= 5,

  // Systolic Array
    parameter integer  ARRAY_N  = 32,
    parameter integer  ARRAY_M  = 32,

  // Precision
    parameter integer  DATA_WIDTH    = 8,
    parameter integer  BIAS_WIDTH    = 16,
    parameter integer  ACC_WIDTH= 32,

  // Buffers
    parameter integer  NUM_TAGS = 2,
    parameter integer  IBUF_CAPACITY_BITS = ARRAY_N * DATA_WIDTH * 2048 / NUM_TAGS,
    parameter integer  WBUF_CAPACITY_BITS = ARRAY_N * ARRAY_M * DATA_WIDTH * 256 / NUM_TAGS,
    parameter integer  OBUF_CAPACITY_BITS = ARRAY_M * ACC_WIDTH * 2048 / NUM_TAGS,
    parameter integer  BBUF_CAPACITY_BITS = ARRAY_M * BIAS_WIDTH * 2048 / NUM_TAGS,

  // Buffer Addr Width
    parameter integer  IBUF_ADDR_WIDTH    = $clog2(IBUF_CAPACITY_BITS / ARRAY_N / DATA_WIDTH),
    parameter integer  WBUF_ADDR_WIDTH    = $clog2(WBUF_CAPACITY_BITS / ARRAY_N / ARRAY_M / DATA_WIDTH),
    parameter integer  OBUF_ADDR_WIDTH    = $clog2(OBUF_CAPACITY_BITS / ARRAY_M / ACC_WIDTH),
    parameter integer  BBUF_ADDR_WIDTH    = $clog2(BBUF_CAPACITY_BITS / ARRAY_M / BIAS_WIDTH),

  // AXI DATA
    parameter integer  AXI_ADDR_WIDTH= 42,
    parameter integer  AXI_BURST_WIDTH    = 8,
    parameter integer  IBUF_AXI_DATA_WIDTH= 256,
    parameter integer  IBUF_WSTRB_W  = IBUF_AXI_DATA_WIDTH/8,
    parameter integer  OBUF_AXI_DATA_WIDTH= 256,
    parameter integer  OBUF_WSTRB_W  = OBUF_AXI_DATA_WIDTH/8,
    parameter integer  PU_AXI_DATA_WIDTH  = 256,
    parameter integer  PU_WSTRB_W    = PU_AXI_DATA_WIDTH/8,
    parameter integer  WBUF_AXI_DATA_WIDTH= 256,
    parameter integer  WBUF_WSTRB_W  = WBUF_AXI_DATA_WIDTH/8,
    parameter integer  BBUF_AXI_DATA_WIDTH= 256,
    parameter integer  BBUF_WSTRB_W  = BBUF_AXI_DATA_WIDTH/8,
    parameter integer  AXI_ID_WIDTH  = 1,
  // AXI Instructions
    parameter integer  INST_ADDR_WIDTH    = 16,
    parameter integer  INST_DATA_WIDTH    = 32,
    parameter integer  INST_WSTRB_WIDTH   = INST_DATA_WIDTH/8,
    parameter integer  INST_BURST_WIDTH   = 8,
  // AXI-Lite
    parameter integer  CTRL_ADDR_WIDTH    = 16,
    parameter integer  CTRL_DATA_WIDTH    = 32,
    parameter integer  CTRL_WSTRB_WIDTH   = CTRL_DATA_WIDTH/8
) (
    input wire logic clk,
    input wire logic reset,
    // PCIe-> CL_wrapper AXI4-Lite interface
    // Slave Write address
    input wire logic pci_cl_ctrl_awvalid,
    output logic pci_cl_ctrl_awready,
    // Slave Write data
    input wire logic pci_cl_ctrl_wvalid,
    output logic pci_cl_ctrl_wready,
    //Write response
    output logic pci_cl_ctrl_bvalid,
    output logic [2-1:0] pci_cl_ctrl_bresp,
    input wire logic pci_cl_ctrl_bready,
    //Read address
    input wire logic pci_cl_ctrl_arvalid,
    output logic pci_cl_ctrl_arready,
    //Read data/response
    output logic pci_cl_ctrl_rvalid,
    output logic [CTRL_DATA_WIDTH-1:0] pci_cl_ctrl_rdata,
    output logic [2-1:0] pci_cl_ctrl_rresp,
    input wire logic pci_cl_ctrl_rready,

    // PCIe-> CL_wrapper AXI4 interface
    // Slave Interface Write Address
    input wire logic [3-1:0] pci_cl_data_awsize,
    input wire logic [2-1:0] pci_cl_data_awburst,
    input wire logic pci_cl_data_awvalid,
    output logic pci_cl_data_awready,
    // Slave Interface Write Data
    input wire logic pci_cl_data_wlast,
    input wire logic pci_cl_data_wvalid,
    output logic pci_cl_data_wready,
    // Slave Interface Write Response
    output logic [2-1:0] pci_cl_data_bresp,
    output logic pci_cl_data_bvalid,
    input wire logic pci_cl_data_bready,
    // Slave Interface Read Address
    input wire logic [3-1:0] pci_cl_data_arsize,
    input wire logic [2-1:0] pci_cl_data_arburst,
    input wire logic pci_cl_data_arvalid,
    output logic pci_cl_data_arready,
    // Slave Interface Read Data
    output logic [INST_DATA_WIDTH-1:0] pci_cl_data_rdata,
    output logic [2-1:0] pci_cl_data_rresp,
    output logic pci_cl_data_rlast,
    output logic pci_cl_data_rvalid,
    input wire logic pci_cl_data_rready,

    // CL_wrapper-> DDR0 AXI4 interface
    // Master Interface Write Address
    output logic [3-1:0] cl_ddr0_awsize,
    output logic [2-1:0] cl_ddr0_awburst,
    output logic cl_ddr0_awvalid,
    input wire logic cl_ddr0_awready,
    // Master Interface Write Data
    output logic cl_ddr0_wlast,
    output logic cl_ddr0_wvalid,
    input wire logic cl_ddr0_wready,
    // Master Interface Write Response
    input wire logic [2-1:0] cl_ddr0_bresp,
    input wire logic cl_ddr0_bvalid,
    output logic cl_ddr0_bready,
    // Master Interface Read Address
    output logic [3-1:0] cl_ddr0_arsize,
    output logic [2-1:0] cl_ddr0_arburst,
    output logic cl_ddr0_arvalid,
    output logic [AXI_ID_WIDTH-1:0] cl_ddr0_arid,
    input wire logic cl_ddr0_arready,
    // Master Interface Read Data
    input wire logic [2-1:0] cl_ddr0_rresp,
    input wire logic cl_ddr0_rlast,
    input wire logic cl_ddr0_rvalid,
    output logic cl_ddr0_rready,

    // CL_wrapper-> DDR1 AXI4 interface
    // Master Interface Write Address
    output logic [3-1:0] cl_ddr1_awsize,
    output logic [2-1:0] cl_ddr1_awburst,
    output logic cl_ddr1_awvalid,
    input wire logic cl_ddr1_awready,
    // Master Interface Write Data
    output logic cl_ddr1_wlast,
    output logic cl_ddr1_wvalid,
    input wire logic cl_ddr1_wready,
    // Master Interface Write Response
    input wire logic [2-1:0] cl_ddr1_bresp,
    input wire logic cl_ddr1_bvalid,
    output logic cl_ddr1_bready,
    // Master Interface Read Address
    output logic [3-1:0] cl_ddr1_arsize,
    output logic [2-1:0] cl_ddr1_arburst,
    output logic cl_ddr1_arvalid,
    output logic [AXI_ID_WIDTH-1:0] cl_ddr1_arid,
    input wire logic cl_ddr1_arready,
    // Master Interface Read Data
    input wire logic [2-1:0] cl_ddr1_rresp,
    input wire logic cl_ddr1_rlast,
    input wire logic cl_ddr1_rvalid,
    output logic cl_ddr1_rready,

    // CL_wrapper-> DDR2 AXI4 interface
    // Master Interface Write Address
    output logic [3-1:0] cl_ddr2_awsize,
    output logic [2-1:0] cl_ddr2_awburst,
    output logic cl_ddr2_awvalid,
    input wire logic cl_ddr2_awready,
    // Master Interface Write Data
    output logic cl_ddr2_wlast,
    output logic cl_ddr2_wvalid,
    input wire logic cl_ddr2_wready,
    // Master Interface Write Response
    input wire logic [2-1:0] cl_ddr2_bresp,
    input wire logic cl_ddr2_bvalid,
    output logic cl_ddr2_bready,
    // Master Interface Read Address
    output logic [3-1:0] cl_ddr2_arsize,
    output logic [2-1:0] cl_ddr2_arburst,
    output logic cl_ddr2_arvalid,
    output logic [AXI_ID_WIDTH-1:0] cl_ddr2_arid,
    input wire logic cl_ddr2_arready,
    // Master Interface Read Data
    input wire logic [2-1:0] cl_ddr2_rresp,
    input wire logic cl_ddr2_rlast,
    input wire logic cl_ddr2_rvalid,
    output logic cl_ddr2_rready,

    // CL_wrapper-> DDR3 AXI4 interface
    // Master Interface Write Address
    output logic [3-1:0] cl_ddr3_awsize,
    output logic [2-1:0] cl_ddr3_awburst,
    output logic cl_ddr3_awvalid,
    input wire logic cl_ddr3_awready,
    // Master Interface Write Data
    output logic cl_ddr3_wlast,
    output logic cl_ddr3_wvalid,
    input wire logic cl_ddr3_wready,
    // Master Interface Write Response
    input wire logic [2-1:0] cl_ddr3_bresp,
    input wire logic cl_ddr3_bvalid,
    output logic cl_ddr3_bready,
    // Master Interface Read Address
    output logic [3-1:0] cl_ddr3_arsize,
    output logic [2-1:0] cl_ddr3_arburst,
    output logic cl_ddr3_arvalid,
    output logic [AXI_ID_WIDTH-1:0] cl_ddr3_arid,
    input wire logic cl_ddr3_arready,
    // Master Interface Read Data
    input wire logic [2-1:0] cl_ddr3_rresp,
    input wire logic cl_ddr3_rlast,
    input wire logic cl_ddr3_rvalid,
    output logic cl_ddr3_rready,


    // CL_wrapper-> DDR3 AXI4 interface
    // Master Interface Write Address
    output logic [3-1:0] cl_ddr4_awsize,
    output logic [2-1:0] cl_ddr4_awburst,
    output logic cl_ddr4_awvalid,
    input wire logic cl_ddr4_awready,
    // Master Interface Write Data
    output logic cl_ddr4_wlast,
    output logic cl_ddr4_wvalid,
    input wire logic cl_ddr4_wready,
    // Master Interface Write Response
    input wire logic [2-1:0] cl_ddr4_bresp,
    input wire logic cl_ddr4_bvalid,
    output logic cl_ddr4_bready,
    // Master Interface Read Address
    output logic [3-1:0] cl_ddr4_arsize,
    output logic [2-1:0] cl_ddr4_arburst,
    output logic cl_ddr4_arvalid,
    output logic [AXI_ID_WIDTH-1:0] cl_ddr4_arid,
    input wire logic cl_ddr4_arready,
    // Master Interface Read Data
    input wire logic [2-1:0] cl_ddr4_rresp,
    input wire logic cl_ddr4_rlast,
    input wire logic cl_ddr4_rvalid,
    output logic cl_ddr4_rready,
    input wire logic[4:0] wstrb_sel,
    input wire logic [7:0] wdata_sel,
    input wire logic [3:0] ax_addr_sel,
    input wire logic [5:0] arw_addr_sel,
    output logic [7:0] data_out,
    input wire logic [1:0] out_sel
);
logic [7:0] wstrb;
logic [7:0] wdata;
logic [AXI_BURST_WIDTH-1:0] ax_addr;
logic [6:0] arw_addr;
always_comb begin
    case (out_sel[1:0])
        0: data_out = wstrb;
        1: data_out = wdata;
        2: data_out = ax_addr;
        3: data_out = {1'b0, arw_addr};
        default: data_out = 8'b0;
    endcase
end

logic [IBUF_WSTRB_W-1:0] cl_ddr0_wstrb;
logic [OBUF_WSTRB_W-1:0] cl_ddr1_wstrb;
logic [WBUF_WSTRB_W-1:0] cl_ddr2_wstrb;
logic [BBUF_WSTRB_W-1:0] cl_ddr3_wstrb;
logic [PU_WSTRB_W-1:0] cl_ddr4_wstrb;

always_comb begin
    case (wstrb_sel[4:0])
        0: wstrb = cl_ddr0_wstrb[7:0];
        1: wstrb = cl_ddr0_wstrb[15:8];
        2: wstrb = cl_ddr0_wstrb[23:16];
        3: wstrb = cl_ddr0_wstrb[31:24];
        4: wstrb = cl_ddr1_wstrb[7:0];
        5: wstrb = cl_ddr1_wstrb[15:8];
        6: wstrb = cl_ddr1_wstrb[23:16];
        7: wstrb = cl_ddr1_wstrb[31:24];
        8: wstrb = cl_ddr2_wstrb[7:0];
        9: wstrb = cl_ddr2_wstrb[15:8];
        10: wstrb = cl_ddr2_wstrb[23:16];
        11: wstrb = cl_ddr2_wstrb[31:24];
        12: wstrb = cl_ddr3_wstrb[7:0];
        13: wstrb = cl_ddr3_wstrb[15:8];
        14: wstrb = cl_ddr3_wstrb[23:16];
        15: wstrb = cl_ddr3_wstrb[31:24];
        16: wstrb = cl_ddr4_wstrb[7:0];
        17: wstrb = cl_ddr4_wstrb[15:8];
        18: wstrb = cl_ddr4_wstrb[23:16];
        19: wstrb = cl_ddr4_wstrb[31:24];
        default: wstrb = 8'b0;
    endcase
end


logic [IBUF_AXI_DATA_WIDTH-1:0] cl_ddr0_wdata;
logic [OBUF_AXI_DATA_WIDTH-1:0] cl_ddr1_wdata;
logic [WBUF_AXI_DATA_WIDTH-1:0] cl_ddr2_wdata;
logic [BBUF_AXI_DATA_WIDTH-1:0] cl_ddr3_wdata;
logic [PU_AXI_DATA_WIDTH-1:0] cl_ddr4_wdata;
always_comb begin
    case (wdata_sel[7:0])
        0: wdata = cl_ddr0_wdata[7:0];
        1: wdata = cl_ddr0_wdata[15:8];
        2: wdata = cl_ddr0_wdata[23:16];
        3: wdata = cl_ddr0_wdata[31:24];
        4: wdata = cl_ddr0_wdata[39:32];
        5: wdata = cl_ddr0_wdata[47:40];
        6: wdata = cl_ddr0_wdata[55:48];
        7: wdata = cl_ddr0_wdata[63:56];
        8: wdata = cl_ddr0_wdata[71:64];
        9: wdata = cl_ddr0_wdata[79:72];
        10: wdata = cl_ddr0_wdata[87:80];
        11: wdata = cl_ddr0_wdata[95:88];
        12: wdata = cl_ddr0_wdata[103:96];
        13: wdata = cl_ddr0_wdata[111:104];
        14: wdata = cl_ddr0_wdata[119:112];
        15: wdata = cl_ddr0_wdata[127:120];
        16: wdata = cl_ddr0_wdata[135:128];
        17: wdata = cl_ddr0_wdata[143:136];
        18: wdata = cl_ddr0_wdata[151:144];
        19: wdata = cl_ddr0_wdata[159:152];
        20: wdata = cl_ddr0_wdata[167:160];
        21: wdata = cl_ddr0_wdata[175:168];
        22: wdata = cl_ddr0_wdata[183:176];
        23: wdata = cl_ddr0_wdata[191:184];
        24: wdata = cl_ddr0_wdata[199:192];
        25: wdata = cl_ddr0_wdata[207:200];
        26: wdata = cl_ddr0_wdata[215:208];
        27: wdata = cl_ddr0_wdata[223:216];
        28: wdata = cl_ddr0_wdata[231:224];
        29: wdata = cl_ddr0_wdata[239:232];
        30: wdata = cl_ddr0_wdata[247:240];
        31: wdata = cl_ddr0_wdata[255:248];
        32: wdata = cl_ddr1_wdata[7:0];
        33: wdata = cl_ddr1_wdata[15:8];
        34: wdata = cl_ddr1_wdata[23:16];
        35: wdata = cl_ddr1_wdata[31:24];
        36: wdata = cl_ddr1_wdata[39:32];
        37: wdata = cl_ddr1_wdata[47:40];
        38: wdata = cl_ddr1_wdata[55:48];
        39: wdata = cl_ddr1_wdata[63:56];
        40: wdata = cl_ddr1_wdata[71:64];
        41: wdata = cl_ddr1_wdata[79:72];
        42: wdata = cl_ddr1_wdata[87:80];
        43: wdata = cl_ddr1_wdata[95:88];
        44: wdata = cl_ddr1_wdata[103:96];
        45: wdata = cl_ddr1_wdata[111:104];
        46: wdata = cl_ddr1_wdata[119:112];
        47: wdata = cl_ddr1_wdata[127:120];
        48: wdata = cl_ddr1_wdata[135:128];
        49: wdata = cl_ddr1_wdata[143:136];
        50: wdata = cl_ddr1_wdata[151:144];
        51: wdata = cl_ddr1_wdata[159:152];
        52: wdata = cl_ddr1_wdata[167:160];
        53: wdata = cl_ddr1_wdata[175:168];
        54: wdata = cl_ddr1_wdata[183:176];
        55: wdata = cl_ddr1_wdata[191:184];
        56: wdata = cl_ddr1_wdata[199:192];
        57: wdata = cl_ddr1_wdata[207:200];
        58: wdata = cl_ddr1_wdata[215:208];
        59: wdata = cl_ddr1_wdata[223:216];
        60: wdata = cl_ddr1_wdata[231:224];
        61: wdata = cl_ddr1_wdata[239:232];
        62: wdata = cl_ddr1_wdata[247:240];
        63: wdata = cl_ddr1_wdata[255:248];
        64: wdata = cl_ddr2_wdata[7:0];
        65: wdata = cl_ddr2_wdata[15:8];
        66: wdata = cl_ddr2_wdata[23:16];
        67: wdata = cl_ddr2_wdata[31:24];
        68: wdata = cl_ddr2_wdata[39:32];
        69: wdata = cl_ddr2_wdata[47:40];
        70: wdata = cl_ddr2_wdata[55:48];
        71: wdata = cl_ddr2_wdata[63:56];
        72: wdata = cl_ddr2_wdata[71:64];
        73: wdata = cl_ddr2_wdata[79:72];
        74: wdata = cl_ddr2_wdata[87:80];
        75: wdata = cl_ddr2_wdata[95:88];
        76: wdata = cl_ddr2_wdata[103:96];
        77: wdata = cl_ddr2_wdata[111:104];
        78: wdata = cl_ddr2_wdata[119:112];
        79: wdata = cl_ddr2_wdata[127:120];
        80: wdata = cl_ddr2_wdata[135:128];
        81: wdata = cl_ddr2_wdata[143:136];
        82: wdata = cl_ddr2_wdata[151:144];
        83: wdata = cl_ddr2_wdata[159:152];
        84: wdata = cl_ddr2_wdata[167:160];
        85: wdata = cl_ddr2_wdata[175:168];
        86: wdata = cl_ddr2_wdata[183:176];
        87: wdata = cl_ddr2_wdata[191:184];
        88: wdata = cl_ddr2_wdata[199:192];
        89: wdata = cl_ddr2_wdata[207:200];
        90: wdata = cl_ddr2_wdata[215:208];
        91: wdata = cl_ddr2_wdata[223:216];
        92: wdata = cl_ddr2_wdata[231:224];
        93: wdata = cl_ddr2_wdata[239:232];
        94: wdata = cl_ddr2_wdata[247:240];
        95: wdata = cl_ddr2_wdata[255:248];
        96: wdata = cl_ddr3_wdata[7:0];
        97: wdata = cl_ddr3_wdata[15:8];
        98: wdata = cl_ddr3_wdata[23:16];
        99: wdata = cl_ddr3_wdata[31:24];
        100: wdata = cl_ddr3_wdata[39:32];
        101: wdata = cl_ddr3_wdata[47:40];
        102: wdata = cl_ddr3_wdata[55:48];
        103: wdata = cl_ddr3_wdata[63:56];
        104: wdata = cl_ddr3_wdata[71:64];
        105: wdata = cl_ddr3_wdata[79:72];
        106: wdata = cl_ddr3_wdata[87:80];
        107: wdata = cl_ddr3_wdata[95:88];
        108: wdata = cl_ddr3_wdata[103:96];
        109: wdata = cl_ddr3_wdata[111:104];
        110: wdata = cl_ddr3_wdata[119:112];
        111: wdata = cl_ddr3_wdata[127:120];
        112: wdata = cl_ddr3_wdata[135:128];
        113: wdata = cl_ddr3_wdata[143:136];
        114: wdata = cl_ddr3_wdata[151:144];
        115: wdata = cl_ddr3_wdata[159:152];
        116: wdata = cl_ddr3_wdata[167:160];
        117: wdata = cl_ddr3_wdata[175:168];
        118: wdata = cl_ddr3_wdata[183:176];
        119: wdata = cl_ddr3_wdata[191:184];
        120: wdata = cl_ddr3_wdata[199:192];
        121: wdata = cl_ddr3_wdata[207:200];
        122: wdata = cl_ddr3_wdata[215:208];
        123: wdata = cl_ddr3_wdata[223:216];
        124: wdata = cl_ddr3_wdata[231:224];
        125: wdata = cl_ddr3_wdata[239:232];
        126: wdata = cl_ddr3_wdata[247:240];
        127: wdata = cl_ddr3_wdata[255:248];
        128: wdata = cl_ddr4_wdata[7:0];
        129: wdata = cl_ddr4_wdata[15:8];
        130: wdata = cl_ddr4_wdata[23:16];
        131: wdata = cl_ddr4_wdata[31:24];
        132: wdata = cl_ddr4_wdata[39:32];
        133: wdata = cl_ddr4_wdata[47:40];
        134: wdata = cl_ddr4_wdata[55:48];
        135: wdata = cl_ddr4_wdata[63:56];
        136: wdata = cl_ddr4_wdata[71:64];
        137: wdata = cl_ddr4_wdata[79:72];
        138: wdata = cl_ddr4_wdata[87:80];
        139: wdata = cl_ddr4_wdata[95:88];
        140: wdata = cl_ddr4_wdata[103:96];
        141: wdata = cl_ddr4_wdata[111:104];
        142: wdata = cl_ddr4_wdata[119:112];
        143: wdata = cl_ddr4_wdata[127:120];
        144: wdata = cl_ddr4_wdata[135:128];
        145: wdata = cl_ddr4_wdata[143:136];
        146: wdata = cl_ddr4_wdata[151:144];
        147: wdata = cl_ddr4_wdata[159:152];
        148: wdata = cl_ddr4_wdata[167:160];
        149: wdata = cl_ddr4_wdata[175:168];
        150: wdata = cl_ddr4_wdata[183:176];
        151: wdata = cl_ddr4_wdata[191:184];
        152: wdata = cl_ddr4_wdata[199:192];
        153: wdata = cl_ddr4_wdata[207:200];
        154: wdata = cl_ddr4_wdata[215:208];
        155: wdata = cl_ddr4_wdata[223:216];
        156: wdata = cl_ddr4_wdata[231:224];
        157: wdata = cl_ddr4_wdata[239:232];
        158: wdata = cl_ddr4_wdata[247:240];
        159: wdata = cl_ddr4_wdata[255:248];
        default: wdata = 8'b0;
    endcase
end


logic [AXI_BURST_WIDTH-1:0] cl_ddr0_arlen;
logic [AXI_BURST_WIDTH-1:0] cl_ddr0_awlen;
logic [AXI_BURST_WIDTH-1:0] cl_ddr1_awlen;
logic [AXI_BURST_WIDTH-1:0] cl_ddr1_arlen;
logic [AXI_BURST_WIDTH-1:0] cl_ddr2_awlen;
logic [AXI_BURST_WIDTH-1:0] cl_ddr2_arlen;
logic [AXI_BURST_WIDTH-1:0] cl_ddr3_awlen;
logic [AXI_BURST_WIDTH-1:0] cl_ddr3_arlen;
logic [AXI_BURST_WIDTH-1:0] cl_ddr4_awlen;
logic [AXI_BURST_WIDTH-1:0] cl_ddr4_arlen;
always_comb begin
    case (ax_addr_sel[3:0])
        0: ax_addr = cl_ddr0_arlen;
        1: ax_addr = cl_ddr0_awlen;
        2: ax_addr = cl_ddr1_awlen;
        3: ax_addr = cl_ddr1_arlen;
        4: ax_addr = cl_ddr2_awlen;
        5: ax_addr = cl_ddr2_arlen;
        6: ax_addr = cl_ddr3_awlen;
        7: ax_addr = cl_ddr3_arlen;
        8: ax_addr = cl_ddr4_awlen;
        9: ax_addr = cl_ddr4_arlen;
        default: ax_addr = {AXI_BURST_WIDTH{1'b0}};
    endcase
end


logic [AXI_ADDR_WIDTH-1:0] cl_ddr0_araddr;
logic [AXI_ADDR_WIDTH-1:0] cl_ddr0_awaddr;
logic [AXI_ADDR_WIDTH-1:0] cl_ddr1_awaddr;
logic [AXI_ADDR_WIDTH-1:0] cl_ddr1_araddr;
logic [AXI_ADDR_WIDTH-1:0] cl_ddr2_awaddr;
logic [AXI_ADDR_WIDTH-1:0] cl_ddr2_araddr;
logic [AXI_ADDR_WIDTH-1:0] cl_ddr3_awaddr;
logic [AXI_ADDR_WIDTH-1:0] cl_ddr3_araddr;
logic [AXI_ADDR_WIDTH-1:0] cl_ddr4_awaddr;
logic [AXI_ADDR_WIDTH-1:0] cl_ddr4_araddr;
always_comb begin
    case (arw_addr_sel[5:0])
        0: arw_addr = cl_ddr0_araddr[6:0];
        1: arw_addr = cl_ddr0_araddr[13:7];
        2: arw_addr = cl_ddr0_araddr[20:14];
        3: arw_addr = cl_ddr0_araddr[27:21];
        4: arw_addr = cl_ddr0_araddr[34:28];
        5: arw_addr = cl_ddr0_araddr[41:35];
        6: arw_addr = cl_ddr0_awaddr[6:0];
        7: arw_addr = cl_ddr0_awaddr[13:7];
        8: arw_addr = cl_ddr0_awaddr[20:14];
        9: arw_addr = cl_ddr0_awaddr[27:21];
        10: arw_addr = cl_ddr0_awaddr[34:28];
        11: arw_addr = cl_ddr0_awaddr[41:35];
        12: arw_addr = cl_ddr1_araddr[6:0];
        13: arw_addr = cl_ddr1_araddr[13:7];
        14: arw_addr = cl_ddr1_araddr[20:14];
        15: arw_addr = cl_ddr1_araddr[27:21];
        16: arw_addr = cl_ddr1_araddr[34:28];
        17: arw_addr = cl_ddr1_araddr[41:35];
        18: arw_addr = cl_ddr1_awaddr[6:0];
        19: arw_addr = cl_ddr1_awaddr[13:7];
        20: arw_addr = cl_ddr1_awaddr[20:14];
        21: arw_addr = cl_ddr1_awaddr[27:21];
        22: arw_addr = cl_ddr1_awaddr[34:28];
        23: arw_addr = cl_ddr1_awaddr[41:35];
        24: arw_addr = cl_ddr2_araddr[6:0];
        25: arw_addr = cl_ddr2_araddr[13:7];
        26: arw_addr = cl_ddr2_araddr[20:14];
        27: arw_addr = cl_ddr2_araddr[27:21];
        28: arw_addr = cl_ddr2_araddr[34:28];
        29: arw_addr = cl_ddr2_araddr[41:35];
        30: arw_addr = cl_ddr2_awaddr[6:0];
        31: arw_addr = cl_ddr2_awaddr[13:7];
        32: arw_addr = cl_ddr2_awaddr[20:14];
        33: arw_addr = cl_ddr2_awaddr[27:21];
        34: arw_addr = cl_ddr2_awaddr[34:28];
        35: arw_addr = cl_ddr2_awaddr[41:35];
        36: arw_addr = cl_ddr3_araddr[6:0];
        37: arw_addr = cl_ddr3_araddr[13:7];
        38: arw_addr = cl_ddr3_araddr[20:14];
        39: arw_addr = cl_ddr3_araddr[27:21];
        40: arw_addr = cl_ddr3_araddr[34:28];
        41: arw_addr = cl_ddr3_araddr[41:35];
        42: arw_addr = cl_ddr3_awaddr[6:0];
        43: arw_addr = cl_ddr3_awaddr[13:7];
        44: arw_addr = cl_ddr3_awaddr[20:14];
        45: arw_addr = cl_ddr3_awaddr[27:21];
        46: arw_addr = cl_ddr3_awaddr[34:28];
        47: arw_addr = cl_ddr3_awaddr[41:35];
        48: arw_addr = cl_ddr4_araddr[6:0];
        49: arw_addr = cl_ddr4_araddr[13:7];
        50: arw_addr = cl_ddr4_araddr[20:14];
        51: arw_addr = cl_ddr4_araddr[27:21];
        52: arw_addr = cl_ddr4_araddr[34:28];
        53: arw_addr = cl_ddr4_araddr[41:35];
        54: arw_addr = cl_ddr4_awaddr[6:0];
        55: arw_addr = cl_ddr4_awaddr[13:7];
        56: arw_addr = cl_ddr4_awaddr[20:14];
        57: arw_addr = cl_ddr4_awaddr[27:21];
        58: arw_addr = cl_ddr4_awaddr[34:28];
        59: arw_addr = cl_ddr4_awaddr[41:35];
        default: arw_addr = {AXI_ADDR_WIDTH{1'b0}};
        endcase
    end

logic [INST_DATA_WIDTH-1:0] pci_cl_data_wdata;
RandomNumberGenerator #(
    .RANDOM_WIDTH(INST_DATA_WIDTH),
    .SEED(0)
) rng0 (
    .clk(clk),
    .reset(reset),
    .random_number(pci_cl_data_wdata)
);

logic [INST_WSTRB_WIDTH-1:0] pci_cl_data_wstrb;
logic [CTRL_ADDR_WIDTH-1:0] pci_cl_ctrl_awaddr;
logic [CTRL_DATA_WIDTH-1:0] pci_cl_ctrl_wdata;
logic [CTRL_WSTRB_WIDTH-1:0] pci_cl_ctrl_wstrb;
logic [CTRL_ADDR_WIDTH-1:0] pci_cl_ctrl_araddr;
logic [INST_ADDR_WIDTH-1:0] pci_cl_data_awaddr;
logic [INST_BURST_WIDTH-1:0] pci_cl_data_awlen;
logic [INST_ADDR_WIDTH-1:0] pci_cl_data_araddr;
logic [INST_BURST_WIDTH-1:0] pci_cl_data_arlen;
logic [IBUF_AXI_DATA_WIDTH-1:0] cl_ddr0_rdata;
logic [AXI_ID_WIDTH-1:0] cl_ddr0_rid;
logic [OBUF_AXI_DATA_WIDTH-1:0] cl_ddr1_rdata;
logic [AXI_ID_WIDTH-1:0] cl_ddr1_rid;
logic [WBUF_AXI_DATA_WIDTH-1:0] cl_ddr2_rdata;
logic [AXI_ID_WIDTH-1:0] cl_ddr2_rid;
logic [BBUF_AXI_DATA_WIDTH-1:0] cl_ddr3_rdata;
logic [AXI_ID_WIDTH-1:0] cl_ddr3_rid;
logic [PU_AXI_DATA_WIDTH-1:0] cl_ddr4_rdata;
logic [AXI_ID_WIDTH-1:0] cl_ddr4_rid;

RandomNumberGenerator #(
    .RANDOM_WIDTH(INST_WSTRB_WIDTH),
    .SEED(1)
) rng1 (
    .clk(clk),
    .reset(reset),
    .random_number(pci_cl_data_wstrb)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(CTRL_ADDR_WIDTH),
    .SEED(2)
) rng2 (
    .clk(clk),
    .reset(reset),
    .random_number(pci_cl_ctrl_awaddr)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(CTRL_DATA_WIDTH),
    .SEED(3)
) rng3 (
    .clk(clk),
    .reset(reset),
    .random_number(pci_cl_ctrl_wdata)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(CTRL_WSTRB_WIDTH),
    .SEED(4)
) rng4 (
    .clk(clk),
    .reset(reset),
    .random_number(pci_cl_ctrl_wstrb)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(CTRL_ADDR_WIDTH),
    .SEED(5)
) rng5 (
    .clk(clk),
    .reset(reset),
    .random_number(pci_cl_ctrl_araddr)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(INST_ADDR_WIDTH),
    .SEED(6)
) rng6 (
    .clk(clk),
    .reset(reset),
    .random_number(pci_cl_data_awaddr)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(INST_BURST_WIDTH),
    .SEED(7)
) rng7 (
    .clk(clk),
    .reset(reset),
    .random_number(pci_cl_data_awlen)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(INST_ADDR_WIDTH),
    .SEED(8)
) rng8 (
    .clk(clk),
    .reset(reset),
    .random_number(pci_cl_data_araddr)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(INST_BURST_WIDTH),
    .SEED(9)
) rng9 (
    .clk(clk),
    .reset(reset),
    .random_number(pci_cl_data_arlen)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(IBUF_AXI_DATA_WIDTH),
    .SEED(10)
) rng10 (
    .clk(clk),
    .reset(reset),
    .random_number(cl_ddr0_rdata)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(AXI_ID_WIDTH),
    .SEED(11)
) rng11 (
    .clk(clk),
    .reset(reset),
    .random_number(cl_ddr0_rid)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(OBUF_AXI_DATA_WIDTH),
    .SEED(12)
) rng12 (
    .clk(clk),
    .reset(reset),
    .random_number(cl_ddr1_rdata)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(AXI_ID_WIDTH),
    .SEED(13)
) rng13 (
    .clk(clk),
    .reset(reset),
    .random_number(cl_ddr1_rid)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(WBUF_AXI_DATA_WIDTH),
    .SEED(14)
) rng14 (
    .clk(clk),
    .reset(reset),
    .random_number(cl_ddr2_rdata)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(AXI_ID_WIDTH),
    .SEED(15)
) rng15 (
    .clk(clk),
    .reset(reset),
    .random_number(cl_ddr2_rid)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(BBUF_AXI_DATA_WIDTH),
    .SEED(16)
) rng16 (
    .clk(clk),
    .reset(reset),
    .random_number(cl_ddr3_rdata)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(AXI_ID_WIDTH),
    .SEED(17)
) rng17 (
    .clk(clk),
    .reset(reset),
    .random_number(cl_ddr3_rid)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(PU_AXI_DATA_WIDTH),
    .SEED(18)
) rng18 (
    .clk(clk),
    .reset(reset),
    .random_number(cl_ddr4_rdata)
);

RandomNumberGenerator #(
    .RANDOM_WIDTH(AXI_ID_WIDTH),
    .SEED(19)
) rng19 (
    .clk(clk),
    .reset(reset),
    .random_number(cl_ddr4_rid)
);




cl_wrapper #(
    .INST_W(INST_W),
    .INST_ADDR_W(INST_ADDR_W),
    .IFIFO_ADDR_W(IFIFO_ADDR_W),
    .BUF_TYPE_W(BUF_TYPE_W),
    .OP_CODE_W(OP_CODE_W),
    .OP_SPEC_W(OP_SPEC_W),
    .LOOP_ID_W(LOOP_ID_W),
    .ARRAY_N(ARRAY_N),
    .ARRAY_M(ARRAY_M),
    .DATA_WIDTH(DATA_WIDTH),
    .BIAS_WIDTH(BIAS_WIDTH),
    .ACC_WIDTH(ACC_WIDTH),
    .NUM_TAGS(NUM_TAGS),
    .IBUF_CAPACITY_BITS(IBUF_CAPACITY_BITS),
    .WBUF_CAPACITY_BITS(WBUF_CAPACITY_BITS),
    .OBUF_CAPACITY_BITS(OBUF_CAPACITY_BITS),
    .BBUF_CAPACITY_BITS(BBUF_CAPACITY_BITS),
    .IBUF_ADDR_WIDTH(IBUF_ADDR_WIDTH),
    .WBUF_ADDR_WIDTH(WBUF_ADDR_WIDTH),
    .OBUF_ADDR_WIDTH(OBUF_ADDR_WIDTH),
    .BBUF_ADDR_WIDTH(BBUF_ADDR_WIDTH),
    .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
    .AXI_BURST_WIDTH(AXI_BURST_WIDTH),
    .IBUF_AXI_DATA_WIDTH(IBUF_AXI_DATA_WIDTH),
    .IBUF_WSTRB_W(IBUF_WSTRB_W),
    .OBUF_AXI_DATA_WIDTH(OBUF_AXI_DATA_WIDTH),
    .OBUF_WSTRB_W(OBUF_WSTRB_W),
    .PU_AXI_DATA_WIDTH(PU_AXI_DATA_WIDTH),
    .PU_WSTRB_W(PU_WSTRB_W),
    .WBUF_AXI_DATA_WIDTH(WBUF_AXI_DATA_WIDTH),
    .WBUF_WSTRB_W(WBUF_WSTRB_W),
    .BBUF_AXI_DATA_WIDTH(BBUF_AXI_DATA_WIDTH),
    .BBUF_WSTRB_W(BBUF_WSTRB_W),
    .AXI_ID_WIDTH(AXI_ID_WIDTH),
    .INST_ADDR_WIDTH(INST_ADDR_WIDTH),
    .INST_DATA_WIDTH(INST_DATA_WIDTH),
    .INST_WSTRB_WIDTH(INST_WSTRB_WIDTH),
    .INST_BURST_WIDTH(INST_BURST_WIDTH),
    .CTRL_ADDR_WIDTH(CTRL_ADDR_WIDTH),
    .CTRL_DATA_WIDTH(CTRL_DATA_WIDTH),
    .CTRL_WSTRB_WIDTH(CTRL_WSTRB_WIDTH)
) dnnweaver_wrapped(
    clk,
    reset,
    pci_cl_ctrl_awvalid,
    pci_cl_ctrl_awaddr,
    pci_cl_ctrl_awready,
    // Slave Write data
    pci_cl_ctrl_wvalid,
    pci_cl_ctrl_wdata,
    pci_cl_ctrl_wstrb,
    pci_cl_ctrl_wready,
    //Write response
    pci_cl_ctrl_bvalid,
    pci_cl_ctrl_bresp,
    pci_cl_ctrl_bready,
    //Read address
    pci_cl_ctrl_arvalid,
    pci_cl_ctrl_araddr,
    pci_cl_ctrl_arready,
    //Read data/response
    pci_cl_ctrl_rvalid,
    pci_cl_ctrl_rdata,
    pci_cl_ctrl_rresp,
    pci_cl_ctrl_rready,

    // PCIe-> CL_wrapper AXI4 interface
    // Slave Interface Write Address
    pci_cl_data_awaddr,
    pci_cl_data_awlen,
    pci_cl_data_awsize,
    pci_cl_data_awburst,
    pci_cl_data_awvalid,
    pci_cl_data_awready,
    // Slave Interface Write Data
    pci_cl_data_wdata,
    pci_cl_data_wstrb,
    pci_cl_data_wlast,
    pci_cl_data_wvalid,
    pci_cl_data_wready,
    // Slave Interface Write Response
    pci_cl_data_bresp,
    pci_cl_data_bvalid,
    pci_cl_data_bready,
    // Slave Interface Read Address
    pci_cl_data_araddr,
    pci_cl_data_arlen,
    pci_cl_data_arsize,
    pci_cl_data_arburst,
    pci_cl_data_arvalid,
    pci_cl_data_arready,
    // Slave Interface Read Data
    pci_cl_data_rdata,
    pci_cl_data_rresp,
    pci_cl_data_rlast,
    pci_cl_data_rvalid,
    pci_cl_data_rready,

    // CL_wrapper-> DDR0 AXI4 interface
    // Master Interface Write Address
    cl_ddr0_awaddr,
    cl_ddr0_awlen,
    cl_ddr0_awsize,
    cl_ddr0_awburst,
    cl_ddr0_awvalid,
    cl_ddr0_awready,
    // Master Interface Write Data
    cl_ddr0_wdata,
    cl_ddr0_wstrb,
    cl_ddr0_wlast,
    cl_ddr0_wvalid,
    cl_ddr0_wready,
    // Master Interface Write Response
    cl_ddr0_bresp,
    cl_ddr0_bvalid,
    cl_ddr0_bready,
    // Master Interface Read Address
    cl_ddr0_araddr,
    cl_ddr0_arlen,
    cl_ddr0_arsize,
    cl_ddr0_arburst,
    cl_ddr0_arvalid,
    cl_ddr0_arid,
    cl_ddr0_arready,
    // Master Interface Read Data
    cl_ddr0_rdata,
    cl_ddr0_rid,
    cl_ddr0_rresp,
    cl_ddr0_rlast,
    cl_ddr0_rvalid,
    cl_ddr0_rready,

    // CL_wrapper-> DDR1 AXI4 interface
    // Master Interface Write Address
    cl_ddr1_awaddr,
    cl_ddr1_awlen,
    cl_ddr1_awsize,
    cl_ddr1_awburst,
    cl_ddr1_awvalid,
    cl_ddr1_awready,
    // Master Interface Write Data
    cl_ddr1_wdata,
    cl_ddr1_wstrb,
    cl_ddr1_wlast,
    cl_ddr1_wvalid,
    cl_ddr1_wready,
    // Master Interface Write Response
    cl_ddr1_bresp,
    cl_ddr1_bvalid,
    cl_ddr1_bready,
    // Master Interface Read Address
    cl_ddr1_araddr,
    cl_ddr1_arlen,
    cl_ddr1_arsize,
    cl_ddr1_arburst,
    cl_ddr1_arvalid,
    cl_ddr1_arid,
    cl_ddr1_arready,
    // Master Interface Read Data
    cl_ddr1_rdata,
    cl_ddr1_rid,
    cl_ddr1_rresp,
    cl_ddr1_rlast,
    cl_ddr1_rvalid,
    cl_ddr1_rready,

    // CL_wrapper-> DDR2 AXI4 interface
    // Master Interface Write Address
    cl_ddr2_awaddr,
    cl_ddr2_awlen,
    cl_ddr2_awsize,
    cl_ddr2_awburst,
    cl_ddr2_awvalid,
    cl_ddr2_awready,
    // Master Interface Write Data
    cl_ddr2_wdata,
    cl_ddr2_wstrb,
    cl_ddr2_wlast,
    cl_ddr2_wvalid,
    cl_ddr2_wready,
    // Master Interface Write Response
    cl_ddr2_bresp,
    cl_ddr2_bvalid,
    cl_ddr2_bready,
    // Master Interface Read Address
    cl_ddr2_araddr,
    cl_ddr2_arlen,
    cl_ddr2_arsize,
    cl_ddr2_arburst,
    cl_ddr2_arvalid,
    cl_ddr2_arid,
    cl_ddr2_arready,
    // Master Interface Read Data
    cl_ddr2_rdata,
    cl_ddr2_rid,
    cl_ddr2_rresp,
    cl_ddr2_rlast,
    cl_ddr2_rvalid,
    cl_ddr2_rready,

    // CL_wrapper-> DDR3 AXI4 interface
    // Master Interface Write Address
    cl_ddr3_awaddr,
    cl_ddr3_awlen,
    cl_ddr3_awsize,
    cl_ddr3_awburst,
    cl_ddr3_awvalid,
    cl_ddr3_awready,
    // Master Interface Write Data
    cl_ddr3_wdata,
    cl_ddr3_wstrb,
    cl_ddr3_wlast,
    cl_ddr3_wvalid,
    cl_ddr3_wready,
    // Master Interface Write Response
    cl_ddr3_bresp,
    cl_ddr3_bvalid,
    cl_ddr3_bready,
    // Master Interface Read Address
    cl_ddr3_araddr,
    cl_ddr3_arlen,
    cl_ddr3_arsize,
    cl_ddr3_arburst,
    cl_ddr3_arvalid,
    cl_ddr3_arid,
    cl_ddr3_arready,
    // Master Interface Read Data
    cl_ddr3_rdata,
    cl_ddr3_rid,
    cl_ddr3_rresp,
    cl_ddr3_rlast,
    cl_ddr3_rvalid,
    cl_ddr3_rready,


    // CL_wrapper-> DDR3 AXI4 interface
    // Master Interface Write Address
    cl_ddr4_awaddr,
    cl_ddr4_awlen,
    cl_ddr4_awsize,
    cl_ddr4_awburst,
    cl_ddr4_awvalid,
    cl_ddr4_awready,
    // Master Interface Write Data
    cl_ddr4_wdata,
    cl_ddr4_wstrb,
    cl_ddr4_wlast,
    cl_ddr4_wvalid,
    cl_ddr4_wready,
    // Master Interface Write Response
    cl_ddr4_bresp,
    cl_ddr4_bvalid,
    cl_ddr4_bready,
    // Master Interface Read Address
    cl_ddr4_araddr,
    cl_ddr4_arlen,
    cl_ddr4_arsize,
    cl_ddr4_arburst,
    cl_ddr4_arvalid,
    cl_ddr4_arid,
    cl_ddr4_arready,
    // Master Interface Read Data
    cl_ddr4_rdata,
    cl_ddr4_rid,
    cl_ddr4_rresp,
    cl_ddr4_rlast,
    cl_ddr4_rvalid,
    cl_ddr4_rready
);

endmodule