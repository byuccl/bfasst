`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Brigham Young University
// Engineer: Sean Jensen
// 
// Create Date: 05/15/2017 02:41:22 PM
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
`default_nettype wire

module top(clk_o, rst_o, userInput_o, designOutput_i);
    input clk_o;
    input rst_o;
    input [15:0] userInput_o;
    output [15:0] designOutput_i;
    
	///////////////////////////////////////////////////////////////////
    //
    // Local wires and registers
    //
    wire [112:0] mem_ctrl_i;
    wire [151:0] mem_ctrl_o;
    wire [63:0] atahost_i;
    wire [62:0] atahost_o;
    wire [70:0] wb_lcd_i;
    wire [39:0] wb_lcd_o;
    wire [80:0] ac97_0_i;
    wire [47:0] ac97_0_o;
    wire [80:0] ac97_1_i;
    wire [47:0] ac97_1_o;
    
    // 113 bits
    assign mem_ctrl_i = {atahost_o, atahost_o[49:0]};
    
    // 64 bits
    assign atahost_i = {4{userInput_o,1'b1}};
            
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

    atahost atahost_0(
        //-- WISHBONE SYSCON signals
        .wb_clk_i(clk_o), // : in std_logic;                       -- master clock in
        .arst_i(clk_o), //   : in std_logic := '1';                -- asynchronous active low reset
        .wb_rst_i(rst_o), // : in std_logic := '0';                -- synchronous active high reset
        
        //-- WISHBONE SLAVE signals
        .wb_cyc_i(atahost_i[0]), // : in std_logic;                       -- valid bus cycle input
        .wb_stb_i(atahost_i[1]), // : in std_logic;                       -- strobe/core select input
        .wb_ack_o(atahost_o[0]), // : out std_logic;                      -- strobe acknowledge output
        .wb_rty_o(atahost_o[1]), // : out std_logic;                      -- retry output
        .wb_err_o(atahost_o[2]), // : out std_logic;                      -- error output
        .wb_adr_i(atahost_i[6:2]), // : in unsigned(6 downto 2);            -- A6 = '1' ATA devices selected
                                                       // --       A5 = '1' CS1- asserted, '0' CS0- asserted
                                                       // --       A4..A2 ATA address lines
                                                       // -- A6 = '0' ATA controller selected
        .wb_dat_i(atahost_i[38:7]), // : in std_logic_vector(31 downto 0);   -- Databus in
        .wb_dat_o(atahost_o[34:3]), // : out std_logic_vector(31 downto 0);  -- Databus out
        .wb_sel_i(atahost_i[42:39]), // : in std_logic_vector(3 downto 0);    -- Byte select signals
        .wb_we_i(atahost_i[43]), //  : in std_logic;                       -- Write enable input
        .wb_inta_o(atahost_o[35]), // : out std_logic;                     -- interrupt request signal IDE0
        
        //-- DMA engine signals
        .DMA_req(atahost_o[36]), // : out std_logic;                    -- DMA request
        .DMA_Ack(atahost_i[44]), // : in std_logic;                     -- DMA acknowledge
        
        //-- ATA signals
        .resetn_pad_o(atahost_o[37]), // : out std_logic;
        .dd_pad_i(atahost_i[60:45]), //     : in  std_logic_vector(15 downto 0);
        .dd_pad_o(atahost_o[53:38]), //     : out std_logic_vector(15 downto 0);
        .dd_padoe_o(atahost_o[54]), //   : out std_logic;
        .da_pad_o(atahost_o[57:55]), //     : out unsigned(2 downto 0);
        .cs0n_pad_o(atahost_o[58]), //   : out std_logic;
        .cs1n_pad_o(atahost_o[59]), //   : out std_logic;
        
        .diorn_pad_o(atahost_o[60]), //     : out std_logic;
        .diown_pad_o(atahost_o[61]), //     : out std_logic;
        .iordy_pad_i(atahost_i[61]), //     : in  std_logic;
        .intrq_pad_i(atahost_i[62]), //     : in  std_logic;
        
        .dmarq_pad_i(atahost_i[63]), //  : in  std_logic;
        .dmackn_pad_o(atahost_o[62])); // : out std_logic
endmodule
