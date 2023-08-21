/*
* paj_raygentop_hierarchy_no_mem top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module paj_raygentop_hierarchy_no_mem_random(
    input logic clk,
    input logic reset,
    output logic rgwant_addr,
    output logic rgwant_data,
    output logic rgread_ready,
    input logic rgaddr_ready,
    input logic rgdata_ready,
    input logic rgwant_read,
    output logic rgwant_CfgData,
    input logic rgCfgData_ready,
    output logic tm3_sram_adsp,
    output logic fbdatavalid,
    input logic fbnextscanline,
    output logic [1:0] raygroup01,
    output logic raygroupvalid01,
    input logic busy01,
    output logic [1:0] raygroup10,
    output logic raygroupvalid10,
    input logic busy10,
    input logic globalreset, 
    output logic rgAddrValid,
    input logic rgDone,
    input logic rgResultReady,
    input logic [1:0] rgResultSource
    );


logic [63:0] tm3_sram_data_out;
logic [18:0] tm3_sram_addr;
logic [7:0] tm3_sram_we;
logic [1:0] tm3_sram_oe;
logic [63:0] rgdataout;
logic [31:0] rgStat;
logic [63:0] fbdata;
logic [31:0] rgData;
logic [3:0] rgAddr;
logic [2:0] rgWE;

logic [63:0] rgdatain;
logic [17:0] rgaddrin;
logic [31:0] rgCont;
logic [63:0] tm3_sram_data_in;
logic [31:0] rgCfgData;
logic [31:0] rgResultData;

RandomNumberGenerator #(64, 3) rng_rgdatain (
  .clk(clk),
  .reset(reset),
  .random_number(rgdatain[63:0])
);

RandomNumberGenerator #(18, 5) rng_rgaddrin (
  .clk(clk),
  .reset(reset),
  .random_number(rgaddrin[17:0])
);

RandomNumberGenerator #(32, 7) rng_rgCont (
  .clk(clk),
  .reset(reset),
  .random_number(rgCont[31:0])
);

RandomNumberGenerator #(64, 9) rng_tm3_sram_data_in (
  .clk(clk),
  .reset(reset),
  .random_number(tm3_sram_data_in[63:0])
);

RandomNumberGenerator #(32, 11) rng_rgCfgData (
  .clk(clk),
  .reset(reset),
  .random_number(rgCfgData[31:0])
);

RandomNumberGenerator #(32, 13) rng_rgResultData (
  .clk(clk),
  .reset(reset),
  .random_number(rgResultData[31:0])
);

paj_raygentop_hierarchy_no_mem paj_raygentop_hierarchy_no_mem (
    .rgwant_addr(rgwant_addr),
    .rgwant_data(rgwant_data),
    .rgread_ready(rgread_ready),
    .rgaddr_ready(rgaddr_ready),
    .rgdata_ready(rgdata_ready),
    .rgwant_read(rgwant_read),
    .rgdatain(rgdatain[63:0]),
    .rgdataout(rgdataout[63:0]),
    .rgaddrin(rgaddrin[17:0]),
    .rgCont(rgCont[31:0]),
    .rgStat(rgStat[31:0]),
    .rgCfgData(rgCfgData[31:0]),
    .rgwant_CfgData(rgwant_CfgData),
    .rgCfgData_ready(rgCfgData_ready),
    .tm3_sram_data_in(tm3_sram_data_in[63:0]),
    .tm3_sram_data_out(tm3_sram_data_out[63:0]),
    .tm3_sram_addr(tm3_sram_addr[18:0]),
    .tm3_sram_we(tm3_sram_we[7:0]),
    .tm3_sram_oe(tm3_sram_oe[1:0]),
    .tm3_sram_adsp(tm3_sram_adsp),
    .clk(clk),
    .fbdata(fbdata[63:0]),
    .fbdatavalid(fbdatavalid),
    .fbnextscanline(fbnextscanline),
    .raygroup01(raygroup01[1:0]),
    .raygroupvalid01(raygroupvalid01),
    .busy01(busy01),
    .raygroup10(raygroup10[1:0]),
    .raygroupvalid10(raygroupvalid10),
    .busy10(busy10),
    .globalreset(globalreset), 
    .rgData(rgData[31:0]),
    .rgAddr(rgAddr[3:0]),
    .rgWE(rgWE[2:0]),
    .rgAddrValid(rgAddrValid),
    .rgDone(rgDone),
    .rgResultData(rgResultData[31:0]),
    .rgResultReady(rgResultReady),
    .rgResultSource(rgResultSource[1:0])
    );

endmodule