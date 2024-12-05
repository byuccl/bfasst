/*
    Random inputs for bnn, output selectable
*/

`include "../../random_number_generator.sv"

module bnn_random(
    input logic clk,
    input logic rst,
    input logic ap_ce,
    output logic [5:0] addr,
    output logic [15:0] data
);

logic [15:0] ret[63:0];
assign data = ret[addr];

logic  [255:0] data_V_read;
RandomNumberGenerator #(256, 255) rng1(clk, rst, data_V_read);

dense_latency_0_0_0_0_0_0_0_0_0_0_0_0_0_0_0_0_0_0_0_0_0_0_0_1 bnn(
        clk,
        rst,
        data_V_read,
        ret[0],
        ret[1],
        ret[2],
        ret[3],
        ret[4],
        ret[5],
        ret[6],
        ret[7],
        ret[8],
        ret[9],
        ret[10],
        ret[11],
        ret[12],
        ret[13],
        ret[14],
        ret[15],
        ret[16],
        ret[17],
        ret[18],
        ret[19],
        ret[20],
        ret[21],
        ret[22],
        ret[23],
        ret[24],
        ret[25],
        ret[26],
        ret[27],
        ret[28],
        ret[29],
        ret[30],
        ret[31],
        ret[32],
        ret[33],
        ret[34],
        ret[35],
        ret[36],
        ret[37],
        ret[38],
        ret[39],
        ret[40],
        ret[41],
        ret[42],
        ret[43],
        ret[44],
        ret[45],
        ret[46],
        ret[47],
        ret[48],
        ret[49],
        ret[50],
        ret[51],
        ret[52],
        ret[53],
        ret[54],
        ret[55],
        ret[56],
        ret[57],
        ret[58],
        ret[59],
        ret[60],
        ret[61],
        ret[62],
        ret[63]
);


endmodule