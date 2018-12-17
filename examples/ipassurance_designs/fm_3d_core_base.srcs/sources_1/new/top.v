`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Brigham Young University
// Engineer: Sean Jensen
// 
// Create Date: 05/12/2017 10:41:22 AM
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
    wire [73:0] potato0_i;
    wire [103:0] potato0_o;
    wire [66:0] fm_3d_core_i;
    wire [101:0] fm_3d_core_o;
    wire [145:0] tmu_i;
    wire [195:0] tmu_o;
    wire [39:0] vga80x40_0_i;
    wire [28:0] vga80x40_0_o;
    wire [39:0] vga80x40_1_i;
    wire [28:0] vga80x40_1_o;
    wire [39:0] vga80x40_2_i;
    wire [28:0] vga80x40_2_o;
    
    // 74 bits
    assign potato0_i = fm_3d_core_o[73:0];
    
    // 67 bits
    assign fm_3d_core_i = {3'b101, {4{userInput_o}}};
    
    // 146 bits = 28 + 104 + 14
    assign tmu_i = {fm_3d_core_o[101:74], potato0_o, fm_3d_core_o[13:0]};
        
    // 40 bits
    assign vga80x40_0_i = tmu_o[39:0] & tmu_o[159:120];
    
    // 40 bits
    assign vga80x40_1_i = tmu_o[79:40] & {tmu_o[195:160], fm_3d_core_o[17:14]};
    
    // 40 bits
    assign vga80x40_2_i = tmu_o[119:80] & tmu_o[39:0];
    
    // 16 bits = 
    assign designOutput_i = {
        &vga80x40_0_o[4:0], &vga80x40_0_o[9:5], &vga80x40_0_o[14:10], 
        &vga80x40_0_o[19:15], &vga80x40_0_o[24:20], &vga80x40_0_o[28:25], 
        &vga80x40_1_o[4:0], &vga80x40_1_o[9:5], &vga80x40_1_o[14:10], 
        &vga80x40_1_o[19:15], &vga80x40_1_o[24:20], &vga80x40_1_o[28:25], 
        &vga80x40_2_o[6:0], &vga80x40_2_o[13:7],
        &vga80x40_2_o[20:14], &vga80x40_2_o[28:21]};
        
    
    ///////////////////////////////////////////////////////////////////
    //
    // Module Instantiations
    //
    pp_potato potato0(
        .clk(clk_o), //       : in std_logic;
        .timer_clk(clk_o), // : in std_logic;
        .reset(rst_o), //     : in std_logic;

        //-- Interrupts:
        .irq(potato0_i[7:0]), // : in std_logic_vector(7 downto 0);

        //-- Host/Target interface:
        .fromhost_data(potato0_i[39:8]), //    : in std_logic_vector(31 downto 0);
        .fromhost_updated(potato0_i[40]), // : in std_logic;
        .tohost_data(potato0_o[31:0]), //      : out std_logic_vector(31 downto 0);
        .tohost_updated(potato0_o[32]), //   : out std_logic;

        //-- Wishbone interface:
        .wb_adr_out(potato0_o[64:33]), // : out std_logic_vector(31 downto 0);
        .wb_sel_out(potato0_o[68:65]), // : out std_logic_vector( 3 downto 0);
        .wb_cyc_out(potato0_o[69]), // : out std_logic;
        .wb_stb_out(potato0_o[70]), // : out std_logic;
        .wb_we_out(potato0_o[71]), //  : out std_logic;
        .wb_dat_out(potato0_o[103:72]), // : out std_logic_vector(31 downto 0);
        .wb_dat_in(potato0_i[72:41]), //  : in  std_logic_vector(31 downto 0);
        .wb_ack_in(potato0_i[73]));//  : in  std_logic
    
    fm_3d_core fm_3d_core_0(
        .clk_i(clk_o),
        .rst_i(rst_o),  // sync reset
        .int_o(fm_3d_core_o[0]),
        // WishBone Slave
        .s_wb_stb_i(fm_3d_core_i[0]),
        .s_wb_we_i(fm_3d_core_i[1]),
        .s_wb_adr_i(fm_3d_core_i[7:2]),
        .s_wb_ack_o(fm_3d_core_o[1]),
        .s_wb_sel_i(fm_3d_core_i[11:8]),
        .s_wb_dat_i(fm_3d_core_i[43:12]),
        .s_wb_dat_o(fm_3d_core_o[33:2]),
        
        // WishBone Master
        .m_wb_stb_o(fm_3d_core_o[34]),
        .m_wb_we_o(fm_3d_core_o[35]),
        .m_wb_adr_o(fm_3d_core_o[65:36]),
        .m_wb_ack_i(fm_3d_core_i[34]),
        .m_wb_sel_o(fm_3d_core_o[69:66]),
        .m_wb_dat_o(fm_3d_core_o[101:70]),
        .m_wb_dat_i(fm_3d_core_i[66:35]));
       
    
    tmu tmu_0(.sys_clk(clk_o), .sys_rst(rst_o), .csr_a(tmu_i[13:0]), .csr_we(tmu_i[14]), 
        .csr_di(tmu_i[46:15]), .csr_do(tmu_o[31:0]), .irq(tmu_o[32]), .wbm_adr_o(tmu_o[64:33]), 
        .wbm_cti_o(tmu_o[67:65]), .wbm_cyc_o(tmu_o[68]), .wbm_stb_o(tmu_o[69]), .wbm_ack_i(tmu_i[47]), 
        .wbm_dat_i(tmu_i[79:48]), .fmlr_adr(tmu_o[95:70]), .fmlr_stb(tmu_o[96]), .fmlr_ack(tmu_i[80]),
        .fmlr_di(tmu_i[144:81]), .fmlw_adr(tmu_o[122:97]), .fmlw_stb(tmu_o[123]), .fmlw_ack(tmu_i[145]),
        .fmlw_sel(tmu_o[131:124]), .fmlw_do(tmu_o[195:132]));
                
    vga80x40 vga80x40_0(
        .reset(rst_o), //       : in  std_logic;
        .clk25MHz(clk_o), //    : in  std_logic;
        .TEXT_A(vga80x40_0_o[11:0]), //      : out std_logic_vector(11 downto 0); -- text buffer
        .TEXT_D(vga80x40_0_i[7:0]), //      : in  std_logic_vector(07 downto 0);
        .FONT_A(vga80x40_0_o[23:12]), //      : out std_logic_vector(11 downto 0); -- font buffer
        .FONT_D(vga80x40_0_i[15:8]), //      : in  std_logic_vector(07 downto 0);
        
        .ocrx(vga80x40_0_i[23:16]), //        : in  std_logic_vector(07 downto 0); -- OUTPUT regs
        .ocry(vga80x40_0_i[31:24]), //        : in  std_logic_vector(07 downto 0);
        .octl(vga80x40_0_i[39:32]), //        : in  std_logic_vector(07 downto 0);
        
        .R(vga80x40_0_o[24]), //           : out std_logic;
        .G(vga80x40_0_o[25]), //           : out std_logic;
        .B(vga80x40_0_o[26]), //           : out std_logic;
        .hsync(vga80x40_0_o[27]), //       : out std_logic;
        .vsync(vga80x40_0_o[28])); //       : out std_logic
                
    vga80x40 vga80x40_1(
        .reset(rst_o), //       : in  std_logic;
        .clk25MHz(clk_o), //    : in  std_logic;
        .TEXT_A(vga80x40_1_o[11:0]), //      : out std_logic_vector(11 downto 0); -- text buffer
        .TEXT_D(vga80x40_1_i[7:0]), //      : in  std_logic_vector(07 downto 0);
        .FONT_A(vga80x40_1_o[23:12]), //      : out std_logic_vector(11 downto 0); -- font buffer
        .FONT_D(vga80x40_1_i[15:8]), //      : in  std_logic_vector(07 downto 0);
        
        .ocrx(vga80x40_1_i[23:16]), //        : in  std_logic_vector(07 downto 0); -- OUTPUT regs
        .ocry(vga80x40_1_i[31:24]), //        : in  std_logic_vector(07 downto 0);
        .octl(vga80x40_1_i[39:32]), //        : in  std_logic_vector(07 downto 0);
        
        .R(vga80x40_1_o[24]), //           : out std_logic;
        .G(vga80x40_1_o[25]), //           : out std_logic;
        .B(vga80x40_1_o[26]), //           : out std_logic;
        .hsync(vga80x40_1_o[27]), //       : out std_logic;
        .vsync(vga80x40_1_o[28])); //       : out std_logic
                
    vga80x40 vga80x40_2(
        .reset(rst_o), //       : in  std_logic;
        .clk25MHz(clk_o), //    : in  std_logic;
        .TEXT_A(vga80x40_2_o[11:0]), //      : out std_logic_vector(11 downto 0); -- text buffer
        .TEXT_D(vga80x40_2_i[7:0]), //      : in  std_logic_vector(07 downto 0);
        .FONT_A(vga80x40_2_o[23:12]), //      : out std_logic_vector(11 downto 0); -- font buffer
        .FONT_D(vga80x40_2_i[15:8]), //      : in  std_logic_vector(07 downto 0);
        
        .ocrx(vga80x40_2_i[23:16]), //        : in  std_logic_vector(07 downto 0); -- OUTPUT regs
        .ocry(vga80x40_2_i[31:24]), //        : in  std_logic_vector(07 downto 0);
        .octl(vga80x40_2_i[39:32]), //        : in  std_logic_vector(07 downto 0);
        
        .R(vga80x40_2_o[24]), //           : out std_logic;
        .G(vga80x40_2_o[25]), //           : out std_logic;
        .B(vga80x40_2_o[26]), //           : out std_logic;
        .hsync(vga80x40_2_o[27]), //       : out std_logic;
        .vsync(vga80x40_2_o[28])); //       : out std_logic

endmodule