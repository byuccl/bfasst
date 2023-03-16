`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2017 12:23:18 PM
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
    wire [3:0] powerSequencer_0_i;
    wire [3:0] powerSequencer_0_o;
    wire [3:0] powerSequencer_1_i;
    wire [3:0] powerSequencer_1_o;
    wire [3:0] powerSequencer_2_i;
    wire [3:0] powerSequencer_2_o;
    wire [3:0] powerSequencer_3_i;
    wire [3:0] powerSequencer_3_o;
    wire [3:0] powerSequencer_4_i;
    wire [3:0] powerSequencer_4_o;
    wire [3:0] powerSequencer_5_i;
    wire [3:0] powerSequencer_5_o;
    wire [3:0] powerSequencer_6_i;
    wire [3:0] powerSequencer_6_o;
    wire [3:0] powerSequencer_7_i;
    wire [3:0] powerSequencer_7_o;
    wire [17:0] wb_lcd_i;
    wire [15:0] wb_lcd_o;
    
    // 16 bits
    assign designOutput_i = wb_lcd_o;
    
    // 4 bits
    assign powerSequencer_0_i = {2'b10, userInput_o[1:0]};
    // 4 bits
    assign powerSequencer_1_i = {powerSequencer_0_o[1:0], userInput_o[3:2]};
    // 4 bits
    assign powerSequencer_2_i = {powerSequencer_1_o[1:0], userInput_o[5:4]};
    // 4 bits
    assign powerSequencer_3_i = {powerSequencer_2_o[1:0], userInput_o[7:6]};
    // 4 bits
    assign powerSequencer_4_i = {powerSequencer_3_o[1:0], userInput_o[9:8]};
    // 4 bits
    assign powerSequencer_5_i = {powerSequencer_4_o[1:0], userInput_o[11:10]};
    // 4 bits
    assign powerSequencer_6_i = {powerSequencer_5_o[1:0], userInput_o[13:12]};
    // 4 bits
    assign powerSequencer_7_i = {powerSequencer_6_o[1:0], userInput_o[15:14]};
    
    // 18 bits = 7*2 + 4
    assign wb_lcd_i = {powerSequencer_0_o[3:2], powerSequencer_1_o[3:2], 
                        powerSequencer_2_o[3:2], powerSequencer_3_o[3:2], 
                        powerSequencer_4_o[3:2], powerSequencer_5_o[3:2], 
                        powerSequencer_6_o[3:2], powerSequencer_7_o};
    
    ///////////////////////////////////////////////////////////////////
    //
    // Module Instantiations
    //
    PowerSequencer powerSequencer_0(
        .clk(clk_o), //:               in  std_logic;
        .rst(rst_o), //:               in  std_logic;
        
        .ena_chain_async(powerSequencer_0_i[0]), //:   in  std_logic; -- enable this slice ( and the following ones if possible)
        .fail_chain_out(powerSequencer_0_o[0]), //:    out std_logic; -- we've got a problem ( or one of the following slices)
        .pu_chain_out(powerSequencer_0_o[1]), //:      out std_logic; -- power up status of _this_ slice and its slaves
        
        .ena_next(powerSequencer_0_o[2]), //:          out std_logic; -- cascade output to next slice
        .fail_chain_in(powerSequencer_0_i[1]), //:     in  std_logic; -- a cascaded slice has a problem
        .pu_chain_in(powerSequencer_0_i[2]), //:       in  std_logic; -- power up status of our slaves
        
        .supply_ena(powerSequencer_0_o[3]), //:        out std_logic; -- enable to the power supplies controlled by this slice
        .supply_good_async(powerSequencer_0_i[3])); //: in  std_logic  -- power good from the supplies controlled by this slice


    PowerSequencer powerSequencer_1(
        .clk(clk_o), //:               in  std_logic;
        .rst(rst_o), //:               in  std_logic;
        
        .ena_chain_async(powerSequencer_1_i[0]), //:   in  std_logic; -- enable this slice ( and the following ones if possible)
        .fail_chain_out(powerSequencer_1_o[0]), //:    out std_logic; -- we've got a problem ( or one of the following slices)
        .pu_chain_out(powerSequencer_1_o[1]), //:      out std_logic; -- power up status of _this_ slice and its slaves
        
        .ena_next(powerSequencer_1_o[2]), //:          out std_logic; -- cascade output to next slice
        .fail_chain_in(powerSequencer_1_i[1]), //:     in  std_logic; -- a cascaded slice has a problem
        .pu_chain_in(powerSequencer_1_i[2]), //:       in  std_logic; -- power up status of our slaves
        
        .supply_ena(powerSequencer_1_o[3]), //:        out std_logic; -- enable to the power supplies controlled by this slice
        .supply_good_async(powerSequencer_1_i[3])); //: in  std_logic  -- power good from the supplies controlled by this slice


    PowerSequencer powerSequencer_2(
        .clk(clk_o), //:               in  std_logic;
        .rst(rst_o), //:               in  std_logic;
        
        .ena_chain_async(powerSequencer_2_i[0]), //:   in  std_logic; -- enable this slice ( and the following ones if possible)
        .fail_chain_out(powerSequencer_2_o[0]), //:    out std_logic; -- we've got a problem ( or one of the following slices)
        .pu_chain_out(powerSequencer_2_o[1]), //:      out std_logic; -- power up status of _this_ slice and its slaves
        
        .ena_next(powerSequencer_2_o[2]), //:          out std_logic; -- cascade output to next slice
        .fail_chain_in(powerSequencer_2_i[1]), //:     in  std_logic; -- a cascaded slice has a problem
        .pu_chain_in(powerSequencer_2_i[2]), //:       in  std_logic; -- power up status of our slaves
        
        .supply_ena(powerSequencer_2_o[3]), //:        out std_logic; -- enable to the power supplies controlled by this slice
        .supply_good_async(powerSequencer_2_i[3])); //: in  std_logic  -- power good from the supplies controlled by this slice
        
        
    PowerSequencer powerSequencer_3(
        .clk(clk_o), //:               in  std_logic;
        .rst(rst_o), //:               in  std_logic;
        
        .ena_chain_async(powerSequencer_3_i[0]), //:   in  std_logic; -- enable this slice ( and the following ones if possible)
        .fail_chain_out(powerSequencer_3_o[0]), //:    out std_logic; -- we've got a problem ( or one of the following slices)
        .pu_chain_out(powerSequencer_3_o[1]), //:      out std_logic; -- power up status of _this_ slice and its slaves
        
        .ena_next(powerSequencer_3_o[2]), //:          out std_logic; -- cascade output to next slice
        .fail_chain_in(powerSequencer_3_i[1]), //:     in  std_logic; -- a cascaded slice has a problem
        .pu_chain_in(powerSequencer_3_i[2]), //:       in  std_logic; -- power up status of our slaves
        
        .supply_ena(powerSequencer_3_o[3]), //:        out std_logic; -- enable to the power supplies controlled by this slice
        .supply_good_async(powerSequencer_3_i[3])); //: in  std_logic  -- power good from the supplies controlled by this slice
    
    
    PowerSequencer powerSequencer_4(
        .clk(clk_o), //:               in  std_logic;
        .rst(rst_o), //:               in  std_logic;
        
        .ena_chain_async(powerSequencer_4_i[0]), //:   in  std_logic; -- enable this slice ( and the following ones if possible)
        .fail_chain_out(powerSequencer_4_o[0]), //:    out std_logic; -- we've got a problem ( or one of the following slices)
        .pu_chain_out(powerSequencer_4_o[1]), //:      out std_logic; -- power up status of _this_ slice and its slaves
        
        .ena_next(powerSequencer_4_o[2]), //:          out std_logic; -- cascade output to next slice
        .fail_chain_in(powerSequencer_4_i[1]), //:     in  std_logic; -- a cascaded slice has a problem
        .pu_chain_in(powerSequencer_4_i[2]), //:       in  std_logic; -- power up status of our slaves
        
        .supply_ena(powerSequencer_4_o[3]), //:        out std_logic; -- enable to the power supplies controlled by this slice
        .supply_good_async(powerSequencer_4_i[3])); //: in  std_logic  -- power good from the supplies controlled by this slice
    
    
    PowerSequencer powerSequencer_5(
        .clk(clk_o), //:               in  std_logic;
        .rst(rst_o), //:               in  std_logic;
        
        .ena_chain_async(powerSequencer_5_i[0]), //:   in  std_logic; -- enable this slice ( and the following ones if possible)
        .fail_chain_out(powerSequencer_5_o[0]), //:    out std_logic; -- we've got a problem ( or one of the following slices)
        .pu_chain_out(powerSequencer_5_o[1]), //:      out std_logic; -- power up status of _this_ slice and its slaves
        
        .ena_next(powerSequencer_5_o[2]), //:          out std_logic; -- cascade output to next slice
        .fail_chain_in(powerSequencer_5_i[1]), //:     in  std_logic; -- a cascaded slice has a problem
        .pu_chain_in(powerSequencer_5_i[2]), //:       in  std_logic; -- power up status of our slaves
        
        .supply_ena(powerSequencer_5_o[3]), //:        out std_logic; -- enable to the power supplies controlled by this slice
        .supply_good_async(powerSequencer_5_i[3])); //: in  std_logic  -- power good from the supplies controlled by this slice
    
    
    PowerSequencer powerSequencer_6(
        .clk(clk_o), //:               in  std_logic;
        .rst(rst_o), //:               in  std_logic;
        
        .ena_chain_async(powerSequencer_6_i[0]), //:   in  std_logic; -- enable this slice ( and the following ones if possible)
        .fail_chain_out(powerSequencer_6_o[0]), //:    out std_logic; -- we've got a problem ( or one of the following slices)
        .pu_chain_out(powerSequencer_6_o[1]), //:      out std_logic; -- power up status of _this_ slice and its slaves
        
        .ena_next(powerSequencer_6_o[2]), //:          out std_logic; -- cascade output to next slice
        .fail_chain_in(powerSequencer_6_i[1]), //:     in  std_logic; -- a cascaded slice has a problem
        .pu_chain_in(powerSequencer_6_i[2]), //:       in  std_logic; -- power up status of our slaves
        
        .supply_ena(powerSequencer_6_o[3]), //:        out std_logic; -- enable to the power supplies controlled by this slice
        .supply_good_async(powerSequencer_6_i[3])); //: in  std_logic  -- power good from the supplies controlled by this slice
    
    
    PowerSequencer powerSequencer_7(
        .clk(clk_o), //:               in  std_logic;
        .rst(rst_o), //:               in  std_logic;
        
        .ena_chain_async(powerSequencer_7_i[0]), //:   in  std_logic; -- enable this slice ( and the following ones if possible)
        .fail_chain_out(powerSequencer_7_o[0]), //:    out std_logic; -- we've got a problem ( or one of the following slices)
        .pu_chain_out(powerSequencer_7_o[1]), //:      out std_logic; -- power up status of _this_ slice and its slaves
        
        .ena_next(powerSequencer_7_o[2]), //:          out std_logic; -- cascade output to next slice
        .fail_chain_in(powerSequencer_7_i[1]), //:     in  std_logic; -- a cascaded slice has a problem
        .pu_chain_in(powerSequencer_7_i[2]), //:       in  std_logic; -- power up status of our slaves
        
        .supply_ena(powerSequencer_7_o[3]), //:        out std_logic; -- enable to the power supplies controlled by this slice
        .supply_good_async(powerSequencer_7_i[3])); //: in  std_logic  -- power good from the supplies controlled by this slice

    wb_lcd wb_lcd_0(
        //
        // I/O Ports
        //
        .wb_clk_i(clk_o),
        .wb_rst_i(rst_o),

        //
        // WB slave interface
        //
        .wb_dat_i(wb_lcd_i[7:0]),
        .wb_dat_o(wb_lcd_o[7:0]),
        .wb_adr_i(wb_lcd_i[14:8]),
        .wb_we_i(wb_lcd_i[15]),
        .wb_cyc_i(wb_lcd_i[16]),
        .wb_stb_i(wb_lcd_i[17]),
        .wb_ack_o(wb_lcd_o[8]),

        //
        // LCD interface
        //
        .SF_D(wb_lcd_o[12:9]),
        .LCD_E(wb_lcd_o[13]),
        .LCD_RS(wb_lcd_o[14]),
        .LCD_RW(wb_lcd_o[15]));
                    
endmodule
