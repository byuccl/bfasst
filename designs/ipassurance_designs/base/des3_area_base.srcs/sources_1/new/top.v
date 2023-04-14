`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2017 01:29:40 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk_o,
    input rst_o,
    input [15:0] userInput_o,
    output [15:0] designOutput_i
    );
    
     wire [112:0] mem_ctrl_i;
     wire [151:0] mem_ctrl_o;
     
     // des3_area added here
     wire [63:0] des3_area_i;
     wire [63:0] des3_area_o;
     wire [55:0] key1, key2, key3;
     wire decrypt;
     wire [5:0] roundSel;
     // end added code
     
     wire [70:0] wb_lcd_i;
     wire [39:0] wb_lcd_o;
     wire [80:0] ac97_0_i;
     wire [47:0] ac97_0_o;
     wire [80:0] ac97_1_i;
     wire [47:0] ac97_1_o;
     
    // 113 bits
    assign mem_ctrl_i = {des3_area_o, des3_area_o[49:0]};
    
    wire [64:0] four_inputs;
    assign four_inputs = {4{userInput_o}};
    
    // 64 bits
    assign des3_area_i = four_inputs;
    
    // new des3_area assignments
    assign key1 = four_inputs[55:0];
    assign key2 = four_inputs[59:4];
    assign key3 = four_inputs[63:8];
    assign decrypt = clk_o ^ rst_o;
    assign roundSel = {mem_ctrl_o[99], mem_ctrl_o[89], mem_ctrl_o[79], mem_ctrl_o[69], mem_ctrl_o[59]};
                
    // 81 bits
    assign ac97_0_i = {5'b10101, mem_ctrl_o[75:0]};
            
    // 81 bits
    assign ac97_1_i = {5'b01010, mem_ctrl_o[151:76]};
    

    // 16 bits
    assign designOutput_i = {&ac97_0_o[5:0],
                            &ac97_0_o[11:6],
                            &ac97_0_o[17:12],
                            &ac97_0_o[23:18],
                            &ac97_0_o[29:24],
                            &ac97_0_o[35:30],
                            &ac97_0_o[41:36],
                            &ac97_0_o[47:42],
                            &ac97_1_o[5:0],
                            &ac97_1_o[11:6],
                            &ac97_1_o[17:12],
                            &ac97_1_o[23:18],
                            &ac97_1_o[29:24],
                            &ac97_1_o[35:30],
                            &ac97_1_o[41:36],
                            &ac97_1_o[47:42]};
    
    ///////////////////////////////////////////////////////////////////
    //
    // Module Instantiations
    //
    mc_top mem_ctrl_0(
        .clk_i(clk_o), 
        .rst_i(rst_o),
        
        // --------------------------------------
        // WISHBONE SLAVE INTERFACE 
        .wb_data_i(mem_ctrl_i[31:0]),
        .wb_data_o(mem_ctrl_o[31:0]),
        .wb_addr_i(mem_ctrl_i[63:32]),
        .wb_sel_i(mem_ctrl_i[67:64]),
        .wb_we_i(mem_ctrl_i[68]),
        .wb_cyc_i(mem_ctrl_i[69]),
        .wb_stb_i(mem_ctrl_i[70]),
        .wb_ack_o(mem_ctrl_o[32]),
        .wb_err_o(mem_ctrl_o[33]),
        
        // --------------------------------------
        // Suspend Resume Interface
        .susp_req_i(mem_ctrl_i[71]),
        .resume_req_i(mem_ctrl_i[72]),
        .suspended_o(mem_ctrl_o[34]),
        
        // POC
        .poc_o(mem_ctrl_o[66:35]),
        
        // --------------------------------------
        // Memory Bus Signals
        .mc_clk_i(mem_ctrl_i[73]),
        .mc_br_pad_i(mem_ctrl_i[74]),
        .mc_bg_pad_o(mem_ctrl_o[67]),
        .mc_ack_pad_i(mem_ctrl_i[75]),
        .mc_addr_pad_o(mem_ctrl_o[91:68]),
        .mc_data_pad_i(mem_ctrl_i[107:76]),
        .mc_data_pad_o(mem_ctrl_o[123:92]),
        .mc_dp_pad_i(mem_ctrl_i[111:108]),
        .mc_dp_pad_o(mem_ctrl_o[127:124]),
        .mc_doe_pad_doe_o(mem_ctrl_o[128]),
        .mc_dqm_pad_o(mem_ctrl_o[132:129]),
        .mc_oe_pad_o_(mem_ctrl_o[133]),
        .mc_we_pad_o_(mem_ctrl_o[134]),
        .mc_cas_pad_o_(mem_ctrl_o[135]),
        .mc_ras_pad_o_(mem_ctrl_o[136]),
        .mc_cke_pad_o_(mem_ctrl_o[137]),
        .mc_cs_pad_o_(mem_ctrl_o[145:138]),
        .mc_sts_pad_i(mem_ctrl_i[112]),
        .mc_rp_pad_o_(mem_ctrl_o[146]),
        .mc_vpen_pad_o(mem_ctrl_o[147]),
        .mc_adsc_pad_o_(mem_ctrl_o[148]),
        .mc_adv_pad_o_(mem_ctrl_o[149]),
        .mc_zz_pad_o(mem_ctrl_o[150]),
        .mc_coe_pad_coe_o(mem_ctrl_o[151]));
            
    ac97_top ac97_0(.clk_i(clk_o), .rst_i(rst_o),

        .wb_data_i(ac97_0_i[31:0]), .wb_data_o(ac97_0_o[31:0]), .wb_addr_i(ac97_0_i[63:32]), 
        .wb_sel_i(ac97_0_i[67:64]), .wb_we_i(ac97_0_i[68]), .wb_cyc_i(ac97_0_i[69]),
        .wb_stb_i(ac97_0_i[70]), .wb_ack_o(ac97_0_o[32]), .wb_err_o(ac97_0_o[33]),
    
        .int_o(ac97_0_o[34]), .dma_req_o(ac97_0_o[43:35]), .dma_ack_i(ac97_0_i[79:71]),
        .suspended_o(ac97_0_o[44]),
    
        .bit_clk_pad_i(clk_o), .sync_pad_o(ac97_0_o[45]), .sdata_pad_o(ac97_0_o[46]), 
        .sdata_pad_i(ac97_0_i[80]), .ac97_reset_pad_o_(ac97_0_o[47]));
                    
    ac97_top ac97_1(.clk_i(clk_o), .rst_i(rst_o),

        .wb_data_i(ac97_1_i[31:0]), .wb_data_o(ac97_1_o[31:0]), .wb_addr_i(ac97_1_i[63:32]), 
        .wb_sel_i(ac97_1_i[67:64]), .wb_we_i(ac97_1_i[68]), .wb_cyc_i(ac97_1_i[69]),
        .wb_stb_i(ac97_1_i[70]), .wb_ack_o(ac97_1_o[32]), .wb_err_o(ac97_1_o[33]),
    
        .int_o(ac97_1_o[34]), .dma_req_o(ac97_1_o[43:35]), .dma_ack_i(ac97_1_i[79:71]),
        .suspended_o(ac97_1_o[44]),
    
        .bit_clk_pad_i(clk_o), .sync_pad_o(ac97_1_o[45]), .sdata_pad_o(ac97_1_o[46]), 
        .sdata_pad_i(ac97_1_i[80]), .ac97_reset_pad_o_(ac97_1_o[47]));
        
    des3_area des3_area_0(
        .desOut(des3_area_o),
        .desIn(des3_area_i),
        .key1(key1),
        .key2(key2),
        .key3(key3),
        .decrypt(decrypt),
        .roundSel(roundSel),
        .clk(clk_o)
    );
 
endmodule
