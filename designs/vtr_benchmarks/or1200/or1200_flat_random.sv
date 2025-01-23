/*
* or1200_flat top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../../random_number_generator.sv"

module or1200_flat_random(
    input logic clk,
    input logic reset,
    output logic ic_en,
    output logic icpu_cycstb_o,
    input logic icpu_ack_i,
    input logic icpu_rty_i,
    input logic icpu_err_i,
    input logic [3:0] icpu_tag_i,
    output logic immu_en,
    output logic ex_freeze,
    input logic du_stall,
    input logic du_read,
    input logic du_write,
    input logic du_hwbkpt,
    output logic dcpu_cycstb_o,
    output logic dcpu_we_o,
    input logic dcpu_ack_i,
    input logic dcpu_rty_i,
    input logic dcpu_err_i,
    input logic [3:0] dcpu_tag_i,
    output logic dc_en,
    output logic dmmu_en,
    output logic supv,
    output logic spr_we,
    input logic sig_int,
    input logic sig_tick
    );

logic [31:0] icpu_dat_i;
logic [31:0] icpu_adr_i;
logic [31:0] du_addr;
logic [31:0] du_dat_du;
logic [31:0] du_dsr;
logic [31:0] dcpu_dat_i;
logic [31:0] spr_dat_pic;
logic [31:0] spr_dat_tt;
logic [31:0] spr_dat_pm;
logic [31:0] spr_dat_dmmu;
logic [31:0] spr_dat_immu;
logic [31:0] spr_dat_du;
logic [31:0] id_pc;
logic [31:0] branch_op;
logic [31:0] du_dat_cpu;
logic [31:0] rf_dataw;
logic [31:0] dcpu_adr_o;
logic [31:0] spr_addr;
logic [31:0] spr_dat_cpu;
logic [31:0] spr_dat_npc;
logic [31:0] spr_cs;
logic [31:0] ex_insn;
logic [12:0] du_except;
logic [31:0] dcpu_dat_o;
logic [31:0] icpu_adr_o;
logic [3:0] icpu_sel_o;
logic [3:0] icpu_tag_o;
logic [3:0] dcpu_sel_o;
logic [3:0] dcpu_tag_o;

RandomNumberGenerator #(32, 3) rng_icpu_dat_i (
  .clk(clk),
  .reset(reset),
  .random_number(icpu_dat_i[31:0])
);

RandomNumberGenerator #(32, 5) rng_icpu_adr_i (
  .clk(clk),
  .reset(reset),
  .random_number(icpu_adr_i[31:0])
);

RandomNumberGenerator #(32, 7) rng_du_addr (
  .clk(clk),
  .reset(reset),
  .random_number(du_addr[31:0])
);

RandomNumberGenerator #(32, 9) rng_du_dat_du (
  .clk(clk),
  .reset(reset),
  .random_number(du_dat_du[31:0])
);

RandomNumberGenerator #(32, 11) rng_du_dsr (
  .clk(clk),
  .reset(reset),
  .random_number(du_dsr[31:0])
);

RandomNumberGenerator #(32, 13) rng_dcpu_dat_i (
  .clk(clk),
  .reset(reset),
  .random_number(dcpu_dat_i[31:0])
);

RandomNumberGenerator #(32, 15) rng_spr_dat_pic (
  .clk(clk),
  .reset(reset),
  .random_number(spr_dat_pic[31:0])
);

RandomNumberGenerator #(32, 17) rng_spr_dat_tt (
  .clk(clk),
  .reset(reset),
  .random_number(spr_dat_tt[31:0])
);

RandomNumberGenerator #(32, 19) rng_spr_dat_pm (
  .clk(clk),
  .reset(reset),
  .random_number(spr_dat_pm[31:0])
);

RandomNumberGenerator #(32, 21) rng_spr_dat_dmmu (
  .clk(clk),
  .reset(reset),
  .random_number(spr_dat_dmmu[31:0])
);

RandomNumberGenerator #(32, 23) rng_spr_dat_immu (
  .clk(clk),
  .reset(reset),
  .random_number(spr_dat_immu[31:0])
);

RandomNumberGenerator #(32, 25) rng_spr_dat_du (
  .clk(clk),
  .reset(reset),
  .random_number(spr_dat_du[31:0])
);

or1200_flat or1200_flat (
    .clk(clk),
    .rst(reset),
    .ic_en(ic_en),
    .icpu_adr_o(icpu_adr_o[31:0]),
    .icpu_cycstb_o(icpu_cycstb_o),
    .icpu_sel_o(icpu_sel_o[3:0]),
    .icpu_tag_o(icpu_tag_o[3:0]),
    .icpu_dat_i(icpu_dat_i[31:0]),
    .icpu_ack_i(icpu_ack_i),
    .icpu_rty_i(icpu_rty_i),
    .icpu_err_i(icpu_err_i),
    .icpu_adr_i(icpu_adr_i[31:0]),
    .icpu_tag_i(icpu_tag_i[3:0]),
    .immu_en(immu_en),
    .ex_insn(ex_insn[31:0]),
    .ex_freeze(ex_freeze),
    .id_pc(id_pc[31:0]),
    .branch_op(branch_op[31:0]),
    .du_stall(du_stall),
    .du_addr(du_addr[31:0]),
    .du_dat_du(du_dat_du[31:0]),
    .du_read(du_read),
    .du_write(du_write),
    .du_dsr(du_dsr[31:0]),
    .du_hwbkpt(du_hwbkpt),
    .du_except(du_except[12:0]),
    .du_dat_cpu(du_dat_cpu[31:0]),
    .rf_dataw(rf_dataw[31:0]),
    .dcpu_adr_o(dcpu_adr_o[31:0]),
    .dcpu_cycstb_o(dcpu_cycstb_o),
    .dcpu_we_o(dcpu_we_o),
    .dcpu_sel_o(dcpu_sel_o[3:0]),
    .dcpu_tag_o(dcpu_tag_o[3:0]),
    .dcpu_dat_o(dcpu_dat_o[31:0]),
    .dcpu_dat_i(dcpu_dat_i[31:0]),
    .dcpu_ack_i(dcpu_ack_i),
    .dcpu_rty_i(dcpu_rty_i),
    .dcpu_err_i(dcpu_err_i),
    .dcpu_tag_i(dcpu_tag_i[3:0]),
    .dc_en(dc_en),
    .dmmu_en(dmmu_en),
    .supv(supv),
    .spr_dat_pic(spr_dat_pic[31:0]),
    .spr_dat_tt(spr_dat_tt[31:0]),
    .spr_dat_pm(spr_dat_pm[31:0]),
    .spr_dat_dmmu(spr_dat_dmmu[31:0]),
    .spr_dat_immu(spr_dat_immu[31:0]),
    .spr_dat_du(spr_dat_du[31:0]),
    .spr_addr(spr_addr[31:0]),
    .spr_dat_cpu(spr_dat_cpu[31:0]),
    .spr_dat_npc(spr_dat_npc[31:0]),
    .spr_cs(spr_cs[31:0]),
    .spr_we(spr_we),
    .sig_int(sig_int),
    .sig_tick(sig_tick)
    );

endmodule