/*
* m32632 top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module m32632_random (
input logic clk,
input logic reset,
input logic WRCFG,
input logic BRESET,
input logic NMI_N,
input logic INT_N,
output logic [3:0] STATUS,
output logic ILO,
output logic [7:0] STATSIGS,
output logic IO_WR,
output logic IO_RD,
output logic [31:0] IO_A,
output logic [3:0] IO_BE,
output logic [31:0] IO_DI,
input logic IO_READY,
input logic ENDRAM,
input logic IC_MDONE,
input logic DC_MDONE,
input logic ENWR,
input logic WAMUX,
output logic IC_ACC,
output logic [27:0] IDRAM_ADR,
output logic DC_ACC,
output logic DC_WR,
output logic [27:0] DRAM_ADR,
output logic [35:0] DRAM_DI,
input logic HOLD,
output logic HLDA,
input logic DMA_CHK,
output logic COP_GO,
output logic [23:0] COP_OP,
    // output logic [127:0] COP_OUT,
input logic COP_DONE
);

logic [2:0]	DRAMSZ;
logic [31:0] IO_Q;
logic [11:2] WADDR;
logic [31:0] DRAM_Q;
logic [2:0]	DWCTRL;
logic [2:0]	IWCTRL;
logic [27:4] DMA_AA;
logic [63:0] COP_IN;

logic [127:0] COP_OUT; // unused output, to avoid overuse of i/o's

RandomNumberGenerator #(3, 3) rng_DRAMSZ (
    .clk(clk),
    .reset(reset),
    .random_number(DRAMSZ[2:0])
);

RandomNumberGenerator #(32, 5) rng_IQ_Q (
    .clk(clk),
    .reset(reset),
    .random_number(IO_Q[31:0])
);

RandomNumberGenerator #(10, 7) rng_WADDR (
    .clk(clk),
    .reset(reset),
    .random_number(WADDR[11:2])
);

RandomNumberGenerator #(32, 9) rng_DRAM_Q (
    .clk(clk),
    .reset(reset),
    .random_number(DRAM_Q[31:0])
);

RandomNumberGenerator #(3, 11) rng_DWCTRL (
    .clk(clk),
    .reset(reset),
    .random_number(DWCTRL[2:0])
);

RandomNumberGenerator #(3, 13) rng_IWCTRL (
    .clk(clk),
    .reset(reset),
    .random_number(IWCTRL[2:0])
);

RandomNumberGenerator #(24, 15) rng_DMA_AA (
    .clk(clk),
    .reset(reset),
    .random_number(DMA_AA[27:4])
);

RandomNumberGenerator #(64, 17) rng_COP_IN (
    .clk(clk),
    .reset(reset),
    .random_number(COP_IN[63:0])
);

m32632 m32632 (
    .BCLK(clk),
    .MCLK(clk),
    .WRCFG(WRCFG),
    .DRAMSZ(DRAMSZ[2:0]),
    .BRESET(BRESET),
    .NMI_N(NMI_N),
    .INT_N(INT_N),
    .STATUS(STATUS[3:0]),
    .ILO(ILO),
    .STATSIGS(STATSIGS[7:0]),
    .IO_WR(IO_WR),
    .IO_RD(IO_RD),
    .IO_A(IO_A[31:0]),
    .IO_BE(IO_BE[3:0]),
    .IO_DI(IO_DI[31:0]),
    .IO_Q(IO_Q[31:0]),
    .IO_READY(IO_READY),
    .ENDRAM(ENDRAM),
    .IC_MDONE(IC_MDONE),
    .DC_MDONE(DC_MDONE),
    .ENWR(ENWR),
    .WAMUX(WAMUX),
    .WADDR(WADDR[11:2]),
    .DRAM_Q(DRAM_Q[31:0]),
    .DWCTRL(DWCTRL[2:0]),
    .IWCTRL(IWCTRL[2:0]),
    .IC_ACC(IC_ACC),
    .IDRAM_ADR(IDRAM_ADR[27:0]),
    .DC_ACC(DC_ACC),
    .DC_WR(DC_WR),
    .DRAM_ADR(DRAM_ADR[27:0]),
    .DRAM_DI(DRAM_DI[35:0]),
    .HOLD(HOLD),
    .HLDA(HLDA),
    .DMA_CHK(DMA_CHK),
    .DMA_AA(DMA_AA[27:4]),
    .COP_GO(COP_GO),
    .COP_OP(COP_OP[23:0]),
    .COP_OUT(COP_OUT[127:0]),
    .COP_DONE(COP_DONE),
    .COP_IN(COP_IN[63:0])
);

endmodule