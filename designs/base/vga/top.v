`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Brigham Young University
// Engineer: Sean Jensen
// 
// Create Date: 05/11/2017 02:41:22 PM
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
    wire [34:0] demosaic_i;
    wire [25:0] demosaic_o;
    wire [77:0] vga_i;
    wire [110:0] vga_o;
    wire [73:0] potato0_i;
    wire [103:0] potato0_o;
    wire [138:0] streamScaler_i;
    wire [9:0] streamScaler_o;
        
    // 78 bits
    assign vga_i = {{4{userInput_o}}, userInput_o[13:0]};
        
    //35 bits
    assign demosaic_i = vga_o[34:0];
    
    // 139 bits = 76 + 26
    assign streamScaler_i = {vga_o[110:35], demosaic_o, vga_o[36:0]};
    
    // 16 bits = 10 + 6
    assign designOutput_i = {streamScaler_o, demosaic_o[25:20]};
    
    ///////////////////////////////////////////////////////////////////
    //
    // Module Instantiations
    //
    bilinearDemosaic demosaic_0(.clk(clk_o), .rst(rst_o), .dIn(demosaic_i[7:0]), 
        .dInValid(demosaic_i[8]), .nextDin(demosaic_o[0]), .start(demosaic_i[9]), 
        .rOut(demosaic_o[8:1]), .gOut(demosaic_o[16:9]), .bOut(demosaic_o[24:17]), 
        .dOutValid(demosaic_o[25]), .nextDout(demosaic_i[10]), 
        .bayerPattern(demosaic_i[12:11]), .xRes(demosaic_i[23:13]), .yRes(demosaic_i[34:24]));
        
    vga vga_0(.CLK_I(clk_o), // : in std_logic;
        .RST_I(rst_o), // : in std_logic;
        .NRESET(vga_i[0]), // : in std_logic;
        .INTA_O(vga_o[0]), // : out std_logic;

        //-- slave signals
        .ADR_I(vga_i[3:1]), // : in unsigned(4 downto 2);                          -- only 32bit databus accesses supported
        .SDAT_I(vga_i[35:4]), // : in std_logic_vector(31 downto 0);
        .SDAT_O(vga_o[32:1]), // : out std_logic_vector(31 downto 0);
        .SEL_I(vga_i[39:36]), // : in std_logic_vector(3 downto 0);
        .WE_I(vga_i[40]), // : in std_logic;
        .STB_I(vga_i[41]), // : in std_logic;
        .CYC_I(vga_i[42]), // : in std_logic;
        .ACK_O(vga_o[33]), // : out std_logic;
        .ERR_O(vga_o[34]), // : out std_logic;
        
        //-- master signals
        .ADR_O(vga_o[74:35]), // : out unsigned(31 downto 2);
        .MDAT_I(vga_i[74:43]), // : in std_logic_vector(31 downto 0);
        .SEL_O(vga_o[78:75]), // : out std_logic_vector(3 downto 0);
        .WE_O(vga_o[79]), // : out std_logic;
        .STB_O(vga_o[80]), // : out std_logic;
        .CYC_O(vga_o[81]), // : out std_logic;
        .CAB_O(vga_o[82]), // : out std_logic;
        .ACK_I(vga_i[75]), // : in std_logic;
        .ERR_I(vga_i[76]), // : in std_logic;

        //-- VGA signals
        .PCLK(vga_i[77]), // : in std_logic;                     -- pixel clock
        .HSYNC(vga_o[83]), // : out std_logic;                   -- horizontal sync
        .VSYNC(vga_o[84]), // : out std_logic;                   -- vertical sync
        .CSYNC(vga_o[85]), // : out std_logic;                   -- composite sync
        .BLANK(vga_o[86]), // : out std_logic;                   -- blanking signal
        .R(vga_o[94:87]), // : out std_logic_vector(7 downto 0) -- RGB color signals
        .G(vga_o[102:95]), // : out std_logic_vector(7 downto 0) -- RGB color signals
        .B(vga_o[110:103]));// : out std_logic_vector(7 downto 0) -- RGB color signals
        
    streamScaler streamScaler_0(
        //---------------------------Module IO-----------------------------------------
        //Clock and reset
        .clk(clk_o),
        .rst(rst_o),
        
        //User interface
        //Input
        .dIn(streamScaler_i[7:0]),
        .dInValid(streamScaler_i[8]),
        .nextDin(streamScaler_o[0]),
        .start(streamScaler_i[9]),
        
        //Output
        .dOut(streamScaler_o[8:1]),
        .dOutValid(streamScaler_o[9]),            //latency of 4 clock cycles after nextDout is asserted
        .nextDout(streamScaler_i[10]),
        
        //Control
        .inputDiscardCnt(streamScaler_i[18:11]),    //Number of input pixels to discard before processing data. Used for clipping
        .inputXRes(streamScaler_i[29:19]),            //Resolution of input data minus 1
        .inputYRes(streamScaler_i[40:30]),
        .outputXRes(streamScaler_i[51:41]),            //Resolution of output data minus 1
        .outputYRes(streamScaler_i[62:52]),
        .xScale(streamScaler_i[80:63]),                //Scaling factors. Input resolution scaled up by 1/xScale. Format Q SCALE_INT_BITS.SCALE_FRAC_BITS
        .yScale(streamScaler_i[98:81]),                //Scaling factors. Input resolution scaled up by 1/yScale. Format Q SCALE_INT_BITS.SCALE_FRAC_BITS
        
        .leftOffset(streamScaler_i[123:99]),            //Integer/fraction of input pixel to offset output data horizontally right. Format Q OUTPUT_X_RES_WIDTH.SCALE_FRAC_BITS
        .topFracOffset(streamScaler_i[137:124]),        //Fraction of input pixel to offset data vertically down. Format Q0.SCALE_FRAC_BITS
        .nearestNeighbor(streamScaler_i[138]));        //Use nearest neighbor resize instead of bilinear

endmodule
