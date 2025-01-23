/*
Random inputs to hls conv layer
*/

`include "../../random_number_generator.sv"

module conv_layer_random (
    input logic clk,
    input logic ap_rst,
    output logic in_data_ce0_0,
    output logic in_data_we0_0,
    output logic in_data_ce1_0,
    output logic in_data_we1_0,
    output logic out_data_we1_2,
    input logic ap_start_2,
    input logic in_data_empty_n_2,
    output logic in_data_read_2,
    input logic out_data_full_n_2,
    output logic out_data_write_2,
    output logic ap_done_2,
    output logic ap_ready_2,
    output logic ap_idle_2,
    input logic ap_continue_2,
    output logic filter_data_ce0_0,
    output logic out_data_we1_0,
    input logic ap_start_0,
    input logic in_data_empty_n_0,
    output logic in_data_read_0,
    input logic out_data_full_n_0,
    output logic out_data_write_0,
    output logic ap_done_0,
    output logic ap_ready_0,
    output logic ap_idle_0,
    input logic ap_continue_0,
    output logic filter_data_we0_0,
    output logic filter_data_ce1_0,
    output logic filter_data_we1_0,
    output logic out_data_ce0_0,
    output logic out_data_we0_0,
    output logic out_data_ce1_0,
    input logic ap_start_1,
    input logic in_data_empty_n_1,
    output logic in_data_read_1,
    input logic out_data_full_n_1,
    output logic out_data_write_1,
    output logic ap_done_1,
    output logic ap_ready_1,
    output logic ap_idle_1,
    input logic ap_continue_1,
    output logic in_data_ce0_1,
    output logic in_data_we0_1,
    output logic in_data_ce1_1,
    output logic in_data_we1_1,
    output logic filter_data_ce0_1,
    output logic filter_data_we0_1,
    output logic filter_data_ce1_1,
    output logic filter_data_we1_1,
    output logic out_data_ce0_1,
    output logic out_data_we0_1,
    output logic out_data_we1_1,
    output logic out_data_ce1_1,
    output logic in_data_we0_2,
    output logic in_data_ce0_2,
    output logic in_data_ce1_2,
    output logic in_data_we1_2,
    output logic filter_data_ce0_2,
    output logic filter_data_we1_2,
    output logic out_data_we0_2,
    output logic filter_data_we0_2,
    output logic filter_data_ce1_2,
    output logic out_data_ce1_2,
    output logic out_data_ce0_2,
    input logic [2:0] data_out_select0,
    output logic [8:0] filter_data,
    output logic [11:0] out_data_addr,
    output logic [14:0] in_data_addr,
    output logic [15:0] filter_data_d_out,
    input logic [3:0] data_out_select1,
    output logic [7:0] in_data,
    input logic [4:0] data_out_select2,
    output logic [7:0] out_data
);

logic [8:0] filter_data_address[5:0];
assign filter_data = filter_data_address[data_out_select0[2:0]];

logic [11:0] out_data_address[5:0];
assign out_data_addr = out_data_addr[data_out_select0[2:0]];

logic [14:0] in_data_address[5:0];
assign in_data_addr = in_data_address[data_out_select0[2:0]];

logic [15:0] filter_data_d[5:0];
assign filter_data_d_out = filter_data_d[data_out_select0[2:0]];

logic [63:0] in_data_d[5:0];
logic [63:0] in_data_row;
assign in_data_row = in_data_d[data_out_select0[2:0]];
always_comb begin
    case (data_out_select1[3:0])
        4'd0: in_data = in_data_row[7:0];
        4'd1: in_data = in_data_row[15:8];
        4'd2: in_data = in_data_row[23:16];
        4'd3: in_data = in_data_row[31:24];
        4'd4: in_data = in_data_row[39:32];
        4'd5: in_data = in_data_row[47:40];
        4'd6: in_data = in_data_row[55:48];
        4'd7: in_data = in_data_row[63:56];
        default: in_data = 8'd0;
    endcase
end

logic [255:0] out_data_d[5:0];
logic [255:0] out_data_row;
assign out_data_row = out_data_d[data_out_select0[2:0]];
always_comb begin
    case (data_out_select2[4:0])
        8'd0: out_data = out_data_row[7:0];
        8'd1: out_data = out_data_row[15:8];
        8'd2: out_data = out_data_row[23:16];
        8'd3: out_data = out_data_row[31:24];
        8'd4: out_data = out_data_row[39:32];
        8'd5: out_data = out_data_row[47:40];
        8'd6: out_data = out_data_row[55:48];
        8'd7: out_data = out_data_row[63:56];
        8'd8: out_data = out_data_row[71:64];
        8'd9: out_data = out_data_row[79:72];
        8'd10: out_data = out_data_row[87:80];
        8'd11: out_data = out_data_row[95:88];
        8'd12: out_data = out_data_row[103:96];
        8'd13: out_data = out_data_row[111:104];
        8'd14: out_data = out_data_row[119:112];
        8'd15: out_data = out_data_row[127:120];
        8'd16: out_data = out_data_row[135:128];
        8'd17: out_data = out_data_row[143:136];
        8'd18: out_data = out_data_row[151:144];
        8'd19: out_data = out_data_row[159:152];
        8'd20: out_data = out_data_row[167:160];
        8'd21: out_data = out_data_row[175:168];
        8'd22: out_data = out_data_row[183:176];
        8'd23: out_data = out_data_row[191:184];
        8'd24: out_data = out_data_row[199:192];
        8'd25: out_data = out_data_row[207:200];
        8'd26: out_data = out_data_row[215:208];
        8'd27: out_data = out_data_row[223:216];
        8'd28: out_data = out_data_row[231:224];
        8'd29: out_data = out_data_row[239:232];
        8'd30: out_data = out_data_row[247:240];
        8'd31: out_data = out_data_row[255:248];
        default: out_data = 8'd0;
    endcase
end


logic  [63:0] in_data_q0_0;
RandomNumberGenerator #(
  .RANDOM_WIDTH(64),
  .SEED(0)
) rng_in_data_q0_0 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(in_data_q0_0)
);

logic [63:0] in_data_q1_0;
RandomNumberGenerator #(
  .RANDOM_WIDTH(64),
  .SEED(0)
) rng_in_data_q1_0 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(in_data_q1_0)
);

logic [15:0] filter_data_q0_0;
RandomNumberGenerator #(
  .RANDOM_WIDTH(16),
  .SEED(0)
) rng_filter_data_q0_0 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(filter_data_q0_0)
);

logic [15:0] filter_data_q1_0;
RandomNumberGenerator #(
  .RANDOM_WIDTH(16),
  .SEED(0)
) rng_filter_data_q1_0 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(filter_data_q1_0)
);

logic [255:0] out_data_q0_0;
RandomNumberGenerator #(
  .RANDOM_WIDTH(256),
  .SEED(0)
) rng_out_data_q0_0 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(out_data_q0_0)
);

logic [255:0] out_data_q1_0;
RandomNumberGenerator #(
  .RANDOM_WIDTH(256),
  .SEED(0)
) rng_out_data_q1_0 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(out_data_q1_0)
);

logic [63:0] in_data_q1_1;
RandomNumberGenerator #(
  .RANDOM_WIDTH(64),
  .SEED(0)
) rng_in_data_q1_1 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(in_data_q1_1)
);
logic [63:0] in_data_q0_1;
RandomNumberGenerator #(
  .RANDOM_WIDTH(64),
  .SEED(0)
) rng_in_data_q0_1 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(in_data_q0_1)
);
logic [15:0] filter_data_q0_1;
RandomNumberGenerator #(
  .RANDOM_WIDTH(16),
  .SEED(0)
) rng_filter_data_q0_1 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(filter_data_q0_1)
);
logic [15:0] filter_data_q1_1;
RandomNumberGenerator #(
  .RANDOM_WIDTH(16),
  .SEED(0)
) rng_filter_data_q1_1 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(filter_data_q0_1)
);
logic [255:0] out_data_q0_1;
RandomNumberGenerator #(
  .RANDOM_WIDTH(256),
  .SEED(0)
) rng_out_data_q0_1 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(filter_data_q0_1)
);
logic [255:0] out_data_q1_1;
RandomNumberGenerator #(
  .RANDOM_WIDTH(256),
  .SEED(0)
) rng_out_data_q1_1 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(filter_data_q0_1)
);

logic [63:0] in_data_q0_2;
RandomNumberGenerator #(
  .RANDOM_WIDTH(64),
  .SEED(0)
) rng_in_data_q0_2 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(in_data_q0_2)
);
logic [63:0] in_data_q1_2;
RandomNumberGenerator #(
  .RANDOM_WIDTH(64),
  .SEED(0)
) rng_in_data_q1_2 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(in_data_q1_2)
);
logic [15:0] filter_data_q0_2;
RandomNumberGenerator #(
  .RANDOM_WIDTH(16),
  .SEED(0)
) rng_filter_data_q0_2 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(filter_data_q0_2)
);
logic [15:0] filter_data_q1_2;
RandomNumberGenerator #(
  .RANDOM_WIDTH(16),
  .SEED(0)
) rng_filter_data_q1_2 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(filter_data_q1_2)
);
logic [255:0] out_data_q0_2;
RandomNumberGenerator #(
  .RANDOM_WIDTH(256),
  .SEED(0)
) rng_out_data_q0_2 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(out_data_q0_2)
);
logic [255:0] out_data_q1_2;
RandomNumberGenerator #(
  .RANDOM_WIDTH(256),
  .SEED(0)
) rng_out_data_q1_2 (
  .clk(clk),
  .reset(ap_rst),
  .random_number(out_data_q1_2)
);

top (
        clk,
        ap_rst,
        in_data_address[0],
        in_data_address[1],
        in_data_address[2],
        in_data_ce0_0,
        in_data_ce0_1,
        in_data_ce0_2,
        in_data_d[0],
        in_data_d[1],
        in_data_d[2],
        in_data_q0_0,
        in_data_q0_1,
        in_data_q0_2,
        in_data_we0_0,
        in_data_we0_1,
        in_data_we0_2,
        in_data_address[3],
        in_data_address[4],
        in_data_address[5],
        in_data_ce1_0,
        in_data_ce1_1,
        in_data_ce1_2,
        in_data_d[3],
        in_data_d[4],
        in_data_d[5],
        in_data_q1_0,
        in_data_q1_1,
        in_data_q1_2,
        in_data_we1_0,
        in_data_we1_1,
        in_data_we1_2,
        filter_data_address[0],
        filter_data_address[1],
        filter_data_address[2],
        filter_data_ce0_0,
        filter_data_ce0_1,
        filter_data_ce0_2,
        filter_data_d[0],
        filter_data_d[1],
        filter_data_d[2],
        filter_data_q0_0,
        filter_data_q0_1,
        filter_data_q0_2,
        filter_data_we0_0,
        filter_data_we0_1,
        filter_data_we0_2,
        filter_data_address[3],
        filter_data_address[4],
        filter_data_address[5],
        filter_data_ce1_0,
        filter_data_ce1_1,
        filter_data_ce1_2,
        filter_data_d[3],
        filter_data_d[4],
        filter_data_d[5],
        filter_data_q1_0,
        filter_data_q1_1,
        filter_data_q1_2,
        filter_data_we1_0,
        filter_data_we1_1,
        filter_data_we1_2,
        out_data_address[0],
        out_data_address[1],
        out_data_address[2],
        out_data_ce0_0,
        out_data_ce0_1,
        out_data_ce0_2,
        out_data_d[0],
        out_data_d[1],
        out_data_d[2],
        out_data_q0_0,
        out_data_q0_1,
        out_data_q0_2,
        out_data_we0_0,
        out_data_we0_1,
        out_data_we0_2,
        out_data_address[4],
        out_data_address[5],
        out_data_address[6],
        out_data_ce1_0,
        out_data_ce1_1,
        out_data_ce1_2,
        out_data_d[3],
        out_data_d[4],
        out_data_d[5],
        out_data_q1_0,
        out_data_q1_1,
        out_data_q1_2,
        out_data_we1_0,
        out_data_we1_1,
        out_data_we1_2,
        ap_start_0,
        ap_start_1,
        ap_start_2,
        in_data_empty_n_0,
        in_data_empty_n_1,
        in_data_empty_n_2,
        in_data_read_0,
        in_data_read_1,
        in_data_read_2,
        out_data_full_n_0,
        out_data_full_n_1,
        out_data_full_n_2,
        out_data_write_0,
        out_data_write_1,
        out_data_write_2,
        ap_done_0,
        ap_done_1,
        ap_done_2,
        ap_ready_0,
        ap_ready_1,
        ap_ready_2,
        ap_idle_0,
        ap_idle_1,
        ap_idle_2,
        ap_continue_0,
        ap_continue_1,
        ap_continue_2
);

endmodule