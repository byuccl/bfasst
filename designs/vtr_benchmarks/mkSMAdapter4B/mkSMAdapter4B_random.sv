/*
* mkSMAdapter4B top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../../random_number_generator.sv"

module mkSMAdapter4B_random(
    input  logic clk,
    input  logic reset,
    output logic prevent_sweep_node,
    input  logic [2 : 0] wciS0_MCmd,
    input  logic wciS0_MAddrSpace,
    input  logic [3 : 0] wciS0_MByteEn,
    output logic [1 : 0] wciS0_SResp,
    output logic [31 : 0] wciS0_SData,
    output logic wciS0_SThreadBusy,
    output logic [1 : 0] wciS0_SFlag,
    input  logic [1 : 0] wciS0_MFlag,
    output logic [2 : 0] wmiM_MCmd,
    output logic wmiM_MReqLast,
    output logic wmiM_MReqInfo,
    output logic wmiM_MAddrSpace,
    output logic [13 : 0] wmiM_MAddr,
    output logic [11 : 0] wmiM_MBurstLength,
    output logic wmiM_MDataValid,
    output logic wmiM_MDataLast,
    output logic [31 : 0] wmiM_MData,
    output logic [3 : 0] wmiM_MDataByteEn,
    input  logic [1 : 0] wmiM_SResp,
    input  logic wmiM_SThreadBusy,
    input  logic wmiM_SDataThreadBusy,
    input  logic wmiM_SRespLast,
    output logic [31 : 0] wmiM_MFlag,
    output logic wmiM_MReset_n,
    input  logic wmiM_SReset_n,
    output logic [2 : 0] wsiM1_MCmd,
    output logic wsiM1_MReqLast,
    output logic wsiM1_MBurstPrecise,
    output logic [11 : 0] wsiM1_MBurstLength,
    output logic [31 : 0] wsiM1_MData,
    output logic [3 : 0] wsiM1_MByteEn,
    output logic [7 : 0] wsiM1_MReqInfo,
    input  logic wsiM1_SThreadBusy,
    output logic wsiM1_MReset_n,
    input  logic wsiM1_SReset_n,
    input  logic [2 : 0] wsiS1_MCmd,
    input  logic wsiS1_MReqLast,
    input  logic wsiS1_MBurstPrecise,
    output logic wsiS1_SThreadBusy,
    output logic wsiS1_SReset_n,
    input  logic wsiS1_MReset_n
    );


logic [19 : 0] wciS0_MAddr;
logic [31 : 0] wciS0_MData;
logic [31 : 0] wmiM_SData;
logic [31 : 0] wmiM_SFlag;
logic [11 : 0] wsiS1_MBurstLength;
logic [31 : 0] wsiS1_MData;
logic [3 : 0] wsiS1_MByteEn;
logic [7 : 0] wsiS1_MReqInfo;


RandomNumberGenerator #(20, 3) rng_wciS0_MAddr (
  .clk(clk),
  .reset(reset),
  .random_number(wciS0_MAddr[19:0])
);

RandomNumberGenerator #(32, 5) rng_wciS0_MData (
  .clk(clk),
  .reset(reset),
  .random_number(wciS0_MData[31:0])
);

RandomNumberGenerator #(32, 7) rng_wmiM_SData (
  .clk(clk),
  .reset(reset),
  .random_number(wmiM_SData[31:0])
);

RandomNumberGenerator #(32, 9) rng_wmiM_SFlag (
  .clk(clk),
  .reset(reset),
  .random_number(wmiM_SFlag[31:0])
);

RandomNumberGenerator #(12, 11) rng_wsiS1_MBurstLength (
  .clk(clk),
  .reset(reset),
  .random_number(wsiS1_MBurstLength[11:0])
);

RandomNumberGenerator #(32, 13) rng_wsiS1_MData (
  .clk(clk),
  .reset(reset),
  .random_number(wsiS1_MData[31:0])
);

RandomNumberGenerator #(4, 15) rng_wsiS1_MByteEn (
  .clk(clk),
  .reset(reset),
  .random_number(wsiS1_MByteEn[3:0])
);

RandomNumberGenerator #(8, 17) rng_wsiS1_MReqInfo (
  .clk(clk),
  .reset(reset),
  .random_number(wsiS1_MReqInfo[7:0])
);

mkSMAdapter4B mkSMAdapter4B (
    .wciS0_Clk(clk),
    .wciS0_MReset_n(reset),
    .prevent_sweep_node(prevent_sweep_node),
    .wciS0_MCmd(wciS0_MCmd[2:0]),
    .wciS0_MAddrSpace(wciS0_MAddrSpace),
    .wciS0_MByteEn(wciS0_MByteEn[3:0]),
    .wciS0_MAddr(wciS0_MAddr[19:0]),
    .wciS0_MData(wciS0_MData[31:0]),
    .wciS0_SResp(wciS0_SResp[1:0]),
    .wciS0_SData(wciS0_SData[31:0]),
    .wciS0_SThreadBusy(wciS0_SThreadBusy),
    .wciS0_SFlag(wciS0_SFlag[1:0]),
    .wciS0_MFlag(wciS0_MFlag[1:0]),
    .wmiM_MCmd(wmiM_MCmd[2:0]),
    .wmiM_MReqLast(wmiM_MReqLast),
    .wmiM_MReqInfo(wmiM_MReqInfo),
    .wmiM_MAddrSpace(wmiM_MAddrSpace),
    .wmiM_MAddr(wmiM_MAddr[13:0]),
    .wmiM_MBurstLength(wmiM_MBurstLength[11:0]),
    .wmiM_MDataValid(wmiM_MDataValid),
    .wmiM_MDataLast(wmiM_MDataLast),
    .wmiM_MData(wmiM_MData[31:0]),
    .wmiM_MDataByteEn(wmiM_MDataByteEn[3:0]),
    .wmiM_SResp(wmiM_SResp[1:0]),
    .wmiM_SData(wmiM_SData[31:0]),
    .wmiM_SThreadBusy(wmiM_SThreadBusy),
    .wmiM_SDataThreadBusy(wmiM_SDataThreadBusy),
    .wmiM_SRespLast(wmiM_SRespLast),
    .wmiM_SFlag(wmiM_SFlag[31:0]),
    .wmiM_MFlag(wmiM_MFlag[31:0]),
    .wmiM_MReset_n(wmiM_MReset_n),
    .wmiM_SReset_n(wmiM_SReset_n),
    .wsiM1_MCmd(wsiM1_MCmd[2:0]),
    .wsiM1_MReqLast(wsiM1_MReqLast),
    .wsiM1_MBurstPrecise(wsiM1_MBurstPrecise),
    .wsiM1_MBurstLength(wsiM1_MBurstLength[11:0]),
    .wsiM1_MData(wsiM1_MData[31:0]),
    .wsiM1_MByteEn(wsiM1_MByteEn[3:0]),
    .wsiM1_MReqInfo(wsiM1_MReqInfo[7:0]),
    .wsiM1_SThreadBusy(wsiM1_SThreadBusy),
    .wsiM1_MReset_n(wsiM1_MReset_n),
    .wsiM1_SReset_n(wsiM1_SReset_n),
    .wsiS1_MCmd(wsiS1_MCmd[2:0]),
    .wsiS1_MReqLast(wsiS1_MReqLast),
    .wsiS1_MBurstPrecise(wsiS1_MBurstPrecise),
    .wsiS1_MBurstLength(wsiS1_MBurstLength[11:0]),
    .wsiS1_MData(wsiS1_MData[31:0]),
    .wsiS1_MByteEn(wsiS1_MByteEn[3:0]),
    .wsiS1_MReqInfo(wsiS1_MReqInfo[7:0]),
    .wsiS1_SThreadBusy(wsiS1_SThreadBusy),
    .wsiS1_SReset_n(wsiS1_SReset_n),
    .wsiS1_MReset_n(wsiS1_MReset_n)
    );

endmodule