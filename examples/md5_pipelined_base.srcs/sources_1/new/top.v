`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2017 03:34:04 PM
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
//`default_nettype none

module top(
        input wire [7:0] sw, JA, JB, JC, JD,
        input wire btnCpuReset, clk,
        output wire [15:0] led
    );
    
    // ++++++++++ Basic Signals
    wire [3:0] STATUS; // check
    wire ILO;          // check
    wire [7:0] STATSIGS; // check
    // +++++++++ General Purpose Interface
    wire IO_WR, IO_RD; // check
    wire [3:0] IO_BE; // check
    wire [31:0] IO_A, IO_DI; // check
    // +++++++++ DRAM Interface In
    wire IC_ACC; // check
    wire [27:0] IDRAM_ADR, DRAM_ADR; // check
    wire DC_ACC, DC_WR; // check
    wire [35:0] DRAM_DI; // check
    // ++++++++++ DMA Interface
    wire HLDA; // check
    // ++++++++++ Coprocessor Interface
    wire COP_GO; // check
    wire [23:0] COP_OP; // check
    wire [127:0] COP_OUT; // check
    
    wire [7:0] pixel1, pixel2, pixel3, pixel4; // check
    wire [9:0] raddr_a, raddr_b, raddr_c; // check
    wire [9:0] waddr; // check
    
    wire [31:0] a64, b64, c64, d64; // check
    
    wire [7:0] pc; // check
    
    m32632 m32632_0(
        .BCLK(clk),
        .MCLK(clk),
        .WRCFG(sw[0]),
        .DRAMSZ(sw[3:1]),
        .BRESET(btnCpuReset),
        .NMI_N(sw[4]),
        .INT_N(sw[5]),
        .STATUS(STATUS),
        .ILO(ILO),
        .STATSIGS(STATSIGS),
        .IO_WR(IO_WR),
        .IO_RD(IO_RD),
        .IO_A(IO_A),
        .IO_BE(IO_BE),
        .IO_Q({4{JA}}),
        .IO_READY(sw[6]),
        .ENDRAM(sw[7]),
        .IC_MDONE(pixel2[0]),
        .DC_MDONE(pixel2[1]),
        .ENWR(pixel2[2]),
        .WAMUX(pixel2[3]),
        .WADDR({JD[7], JD[6], pixel1}),
        .DRAM_Q({4{JC}}),
        .DWCTRL(pixel2[7:6]),
        .IWCTRL(pixel2[5:4]),
        .IC_ACC(IC_ACC),
        .IDRAM_ADR(IDRAM_ADR),
        .DC_ACC(DC_ACC),
        .DC_WR(DC_WR),
        .DRAM_ADR(DRAM_ADR),
        .DRAM_DI(DRAM_DI),
        .HOLD(sw[0]),    // 1 bit
        .HLDA(HLDA),
        .DMA_CHK(^pc), // 1 bit
        .DMA_AA(c64[27:4]),  // [27:4]
        .COP_GO(COP_GO),
        .COP_OP(COP_OP),
        .COP_OUT(COP_OUT),
        .COP_DONE(^waddr),    // 1 bit
        .COP_IN({a64, b64})       // [63:0]
    );
    
    assign IO_DI = (pixel1 ^ pixel2 ^ pixel3 ^ pixel4);     //Added in by Sean because it wasn't assigned to

    md5_pipelined md5_pipelined_0(
        .clk(clk),
        .wb({4{COP_OUT}}),
        .a0(IO_A),
        .b0(IO_DI),
        .c0({IDRAM_ADR, STATUS}),
        .d0({DRAM_ADR, IO_BE}),
        .a64(a64),
        .b64(b64),
        .c64(c64),            
        .d64(d64)
    );
    

    
    median median_0(
        .clk(clk),
        .rst_n(btnCpuReset),
        .word0(b64),
        .word1(c64),
        .word2(d64),
        .pixel1(pixel1),
        .pixel2(pixel2),
        .pixel3(pixel3),
        .pixel4(pixel4),
        .raddr_a(raddr_a),
        .raddr_b(raddr_b),
        .raddr_c(raddr_c),
        .waddr(waddr)
    );
    
    
    
    mips_16 mips_16_0(
        .clk(clk),
        .rst(btnCpuReset),
        .pc(pc)
    );
    
    assign led[9:0] = ((pixel1 ^ pixel2 ^ pixel3 ^ pixel4) ^ (raddr_a ^ raddr_b ^ raddr_c));
    assign led[10] = ILO;
    assign led[11] = ^STATSIGS;
    assign led[12] = IO_WR;
    assign led[13] = IO_RD;
    assign led[14] = IC_ACC ^ DC_ACC ^ DC_WR ^ HLDA ^ COP_GO;
    assign led[15] = ^DRAM_DI ^ ^COP_OP;
    

endmodule
