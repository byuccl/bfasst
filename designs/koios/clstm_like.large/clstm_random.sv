/*
Random inputs to clstm
*/

`include "../../random_number_generator.sv"

module clstm_random(
    input logic clk,
    input logic rst,
    input logic [7:0] wen_stage1,
    input logic [6:0] wen_stage2,
	input logic [1:0] wen_stage3,
    input logic i_ready,
	input logic i_valid,
	input logic start_compute,
	output logic o_valid,
    output logic o_ready,
    output logic [17:0] data,
    input logic [2:0] data_sel0,
    input logic [3:0] data_sel1
);

logic  [161:0] wdata_stage1;
RandomNumberGenerator #(162, 0) rng1 (
    .clk(clk),
    .reset(rst),
    .random_number(wdata_stage1)
);

logic [287:0] wdata_stage2;
RandomNumberGenerator #(288, 1) rng2 (
    .clk(clk),
    .reset(rst),
    .random_number(wdata_stage2)
);

logic [161:0] wdata_stage3;
RandomNumberGenerator #(162, 3) rng3 (
    .clk(clk),
    .reset(rst),
    .random_number(wdata_stage3)
);

logic [17:0] i_X_data [15:0];
generate
    genvar i;
    for (i = 0; i < 16; i = i + 1) begin: gen_X_data
        RandomNumberGenerator #(18, i) rng_X_data (
            .clk(clk),
            .reset(rst),
            .random_number(i_X_data[i])
        );
    end
endgenerate

logic [17:0] o_sel [2:0][15:0];
assign data = o_sel[data_sel0][data_sel1[3:0]];

C_LSTM_datapath (
    clk,
    rst,
    wdata_stage1,
    wen_stage1,
    wdata_stage2,
    wen_stage2,
    wdata_stage3,
    wen_stage3,
    i_X_data[0],
    i_X_data[1],
    i_X_data[2],
    i_X_data[3],
    i_X_data[4],
    i_X_data[5],
    i_X_data[6],
    i_X_data[7],
    i_X_data[8],
    i_X_data[9],
    i_X_data[10],
    i_X_data[11],
    i_X_data[12],
    i_X_data[13],
    i_X_data[14],
    i_X_data[15],
    o_sel[0][0],
    o_sel[0][1],
    o_sel[0][2],
    o_sel[0][3],
    o_sel[0][4],
    o_sel[0][5],
    o_sel[0][6],
    o_sel[0][7],
    o_sel[0][8],
    o_sel[0][9],
    o_sel[0][10],
    o_sel[0][11],
    o_sel[0][12],
    o_sel[0][13],
    o_sel[0][14],
    o_sel[0][15],
    o_sel[1][0],
    o_sel[1][1],
    o_sel[1][2],
    o_sel[1][3],
    o_sel[1][4],
    o_sel[1][5],
    o_sel[1][6],
    o_sel[1][7],
    o_sel[1][8],
    o_sel[1][9],
    o_sel[1][10],
    o_sel[1][11],
    o_sel[1][12],
    o_sel[1][13],
    o_sel[1][14],
    o_sel[1][15],
    o_sel[2][0],
    o_sel[2][1],
    o_sel[2][2],
    o_sel[2][3],
    o_sel[2][4],
    o_sel[2][5],
    o_sel[2][6],
    o_sel[2][7],
    o_sel[2][8],
    o_sel[2][9],
    o_sel[2][10],
    o_sel[2][11],
    o_sel[2][12],
    o_sel[2][13],
    o_sel[2][14],
    o_sel[2][15]
);
	

endmodule