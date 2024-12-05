/*
* mkDelayWorker32B top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../../random_number_generator.sv"

module mkDelayWorker32B_random(
    input logic clk,
	input logic reset,
	input logic [2:0] wciS0_MCmd,
	input logic wciS0_MAddrSpace,
	input logic [3:0] wciS0_MByteEn,
	input logic [19:0] wciS0_MAddr,
	output logic [1:0] wciS0_SResp,
	output logic [31:0] wciS0_SData,
	output logic wciS0_SThreadBusy,
	output logic [1:0] wciS0_SFlag,
	input logic [1:0] wciS0_MFlag,
	input logic [2:0]  wsiS1_MCmd,
	input logic wsiS1_MReqLast,
	input logic wsiS1_MBurstPrecise,
	input logic [11:0] wsiS1_MBurstLength,
	input logic [7:0] wsiS1_MReqInfo,
	output logic wsiS1_SThreadBusy,
	output logic wsiS1_SReset_n,
	input logic wsiS1_MReset_n,
	output logic [2:0] wsiM1_MCmd,
	output logic wsiM1_MReqLast,
	output logic wsiM1_MBurstPrecise,
	output logic [11:0] wsiM1_MBurstLength,
	output logic [31:0] wsiM1_MByteEn,
	output logic [7:0] wsiM1_MReqInfo,
	input logic wsiM1_SThreadBusy,
	output logic wsiM1_MReset_n,
	input logic wsiM1_SReset_n,
	output logic [2:0] wmemiM_MCmd,
	output logic wmemiM_MReqLast,
	output logic [35:0] wmemiM_MAddr,
	output logic [11:0] wmemiM_MBurstLength,
	output logic wmemiM_MDataValid,
	output logic wmemiM_MDataLast,
	output logic [15:0] wmemiM_MDataByteEn,
	input logic [1:0] wmemiM_SResp,
	input logic wmemiM_SRespLast,
	input logic wmemiM_SCmdAccept,
	input logic wmemiM_SDataAccept,
	output logic wmemiM_MReset_n,
	output logic prevent_hanging_nodes
    );

logic [255:0] wsiS1_MData;
logic [255:0] wsiM1_MData; //doesn't need rng
logic [127:0] wmemiM_MData; //doesn't need rng
logic [127:0] wmemiM_SData;
logic [31:0] wciS0_MData;
logic [31:0] wsiS1_MByteEn;


RandomNumberGenerator #(256, 3) rng_wsiS1_MData (
  .clk(clk),
  .reset(reset),
  .random_number(wsiS1_MData[255:0])
);

RandomNumberGenerator #(128, 5) rng_wmemiM_SData (
  .clk(clk),
  .reset(reset),
  .random_number(wmemiM_SData[127:0])
);

RandomNumberGenerator #(32, 7) rng_wciS0_MData (
  .clk(clk),
  .reset(reset),
  .random_number(wciS0_MData[31:0])
);

RandomNumberGenerator #(32, 9) rng_wsiS1_MByteEn (
  .clk(clk),
  .reset(reset),
  .random_number(wsiS1_MByteEn[31:0])
);

mkDelayWorker32B mkDelayWorker32B (
    .wciS0_Clk(clk),
	.wciS0_MReset_n(reset),
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
	.wsiS1_MCmd(wsiS1_MCmd[2:0]),
	.wsiS1_MReqLast(wsiS1_MReqLast),
	.wsiS1_MBurstPrecise(wsiS1_MBurstPrecise),
	.wsiS1_MBurstLength(wsiS1_MBurstLength[11:0]),
	.wsiS1_MData(wsiS1_MData[255:0]),
	.wsiS1_MByteEn(wsiS1_MByteEn[31:0]),
	.wsiS1_MReqInfo(wsiS1_MReqInfo[7:0]),
	.wsiS1_SThreadBusy(wsiS1_SThreadBusy),
	.wsiS1_SReset_n(wsiS1_SReset_n),
	.wsiS1_MReset_n(wsiS1_MReset_n),
	.wsiM1_MCmd(wsiM1_MCmd[2:0]),
	.wsiM1_MReqLast(wsiM1_MReqLast),
	.wsiM1_MBurstPrecise(wsiM1_MBurstPrecise),
	.wsiM1_MBurstLength(wsiM1_MBurstLength[11:0]),
	.wsiM1_MData(wsiM1_MData[255:0]),
	.wsiM1_MByteEn(wsiM1_MByteEn[31:0]),
	.wsiM1_MReqInfo(wsiM1_MReqInfo[7:0]),
	.wsiM1_SThreadBusy(wsiM1_SThreadBusy),
	.wsiM1_MReset_n(wsiM1_MReset_n),
	.wsiM1_SReset_n(wsiM1_SReset_n),
	.wmemiM_MCmd(wmemiM_MCmd[2:0]),
	.wmemiM_MReqLast(wmemiM_MReqLast),
	.wmemiM_MAddr(wmemiM_MAddr[35:0]),
	.wmemiM_MBurstLength(wmemiM_MBurstLength[11:0]),
	.wmemiM_MDataValid(wmemiM_MDataValid),
	.wmemiM_MDataLast(wmemiM_MDataLast),
	.wmemiM_MData(wmemiM_MData[127:0]),
	.wmemiM_MDataByteEn(wmemiM_MDataByteEn[15:0]),
	.wmemiM_SResp(wmemiM_SResp[1:0]),
	.wmemiM_SRespLast(wmemiM_SRespLast),
	.wmemiM_SData(wmemiM_SData[127:0]),
	.wmemiM_SCmdAccept(wmemiM_SCmdAccept),
	.wmemiM_SDataAccept(wmemiM_SDataAccept),
	.wmemiM_MReset_n(wmemiM_MReset_n),
	.prevent_hanging_nodes(prevent_hanging_nodes)
    );

endmodule