/*
* paj_boundtop_hierarchy_no_mem top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module paj_boundtop_hierarchy_no_mem_random(
    input logic clk,
    input logic reset,
    output logic triIDvalid,
    output logic [15:0] triID,
    input logic wanttriID, 
    output logic [31:0] raydata,
    output logic [3:0] rayaddr,
    output logic [2:0] raywe,
    input logic resultready,
    output logic globalreset,
    output logic want_braddr,
    input logic braddr_ready,
    output logic want_brdata,
    input logic brdata_ready,
    output logic want_addr2,
    input logic addr2_ready,
    output logic want_data2,
    input logic data2_ready,
    input logic pglobalreset,
    input logic tm3_clk_v0,
    output logic [63:0] tm3_sram_data_out,
    output logic [18:0] tm3_sram_addr,
    output logic [7:0] tm3_sram_we,
    output logic [1:0] tm3_sram_oe,
    output logic tm3_sram_adsp,
    input logic [1:0] raygroup01,
    input logic raygroupvalid01,
    output logic busy01,
    input logic [1:0] raygroup10,
    input logic raygroupvalid10,
    output logic busy10,
    input logic [3:0] rgAddr,
    input logic [2:0] rgWE,
    input logic rgAddrValid,
    output logic rgDone,
    output logic [31:0] rgResultData,
    output logic rgResultReady,
    output logic [1:0] rgResultSource,
    input logic input1
    );

logic [31:0] resultdata;
logic [9:0] braddrin;
logic [31:0] brdatain;
logic [17:0] addr2in;
logic [63:0] data2in;
logic [63:0] tm3_sram_data_in;
logic [31:0] rgData;

RandomNumberGenerator #(32, 3) rng_resultdata (
  .clk(clk),
  .reset(reset),
  .random_number(resultdata[31:0])
);

RandomNumberGenerator #(10, 5) rng_braddrin (
  .clk(clk),
  .reset(reset),
  .random_number(braddrin[9:0])
);

RandomNumberGenerator #(32, 7) rng_brdatain (
  .clk(clk),
  .reset(reset),
  .random_number(brdatain[31:0])
);

RandomNumberGenerator #(18, 9) rng_addr2in (
  .clk(clk),
  .reset(reset),
  .random_number(addr2in[17:0])
);

RandomNumberGenerator #(64, 11) rng_data2in (
  .clk(clk),
  .reset(reset),
  .random_number(data2in[63:0])
);

RandomNumberGenerator #(64, 13) rng_tm3_sram_data_in (
  .clk(clk),
  .reset(reset),
  .random_number(tm3_sram_data_in[63:0])
);

RandomNumberGenerator #(32, 15) rng_rgData (
  .clk(clk),
  .reset(reset),
  .random_number(rgData[31:0])
);

paj_boundtop_hierarchy_no_mem paj_boundtop_hierarchy_no_mem (
    .triIDvalid(triIDvalid),
    .triID(triID[15:0]),
    .wanttriID(wanttriID), 
    .raydata(raydata[31:0]),
    .rayaddr(rayaddr[3:0]),
    .raywe(raywe[2:0]),
    .resultready(resultready),
    .resultdata(resultdata[31:0]),
    .globalreset(globalreset),
    .want_braddr(want_braddr),
    .braddr_ready(braddr_ready),
    .braddrin(braddrin[9:0]),
    .want_brdata(want_brdata),
    .brdata_ready(brdata_ready),
    .brdatain(brdatain[31:0]),
    .want_addr2(want_addr2),
    .addr2_ready(addr2_ready),
    .addr2in(addr2in[17:0]),
    .want_data2(want_data2),
    .data2_ready(data2_ready),
    .data2in(data2in[63:0]),
    .pglobalreset(pglobalreset),
    .tm3_clk_v0(tm3_clk_v0),
    .tm3_sram_data_in(tm3_sram_data_in[63:0]),
    .tm3_sram_data_out(tm3_sram_data_out[63:0]),
    .tm3_sram_addr(tm3_sram_addr[18:0]),
    .tm3_sram_we(tm3_sram_we[7:0]),
    .tm3_sram_oe(tm3_sram_oe[1:0]),
    .tm3_sram_adsp(tm3_sram_adsp),
    .raygroup01(raygroup01[1:0]),
    .raygroupvalid01(raygroupvalid01),
    .busy01(busy01),
    .raygroup10(raygroup10[1:0]),
    .raygroupvalid10(raygroupvalid10),
    .busy10(busy10),
    .rgData(rgData[31:0]),
    .rgAddr(rgAddr[3:0]),
    .rgWE(rgWE[2:0]),
    .rgAddrValid(rgAddrValid),
    .rgDone(rgDone),
    .rgResultData(rgResultData[31:0]),
    .rgResultReady(rgResultReady),
    .rgResultSource(rgResultSource[1:0]),
    .input1(input1)
    );

endmodule