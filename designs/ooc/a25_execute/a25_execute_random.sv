/*
* a25_execute top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module a25_execute_random(
    input logic clk,
    input logic reset,
    input logic i_core_stall,
    input logic i_mem_stall,
    output logic o_exec_stall,
    input logic i_wb_read_data_valid,
    input logic i_decode_iaccess,
    input logic i_decode_daccess,
    output reg  [31:0] o_copro_write_data,
    output reg  [31:0] o_write_data,
    output wire [31:0] o_iaddress,
    output logic [31:0] o_iaddress_nxt,
    output reg o_iaddress_valid,
    output reg [31:0] o_daddress,
    output logic [31:0] o_daddress_nxt,
    output reg o_daddress_valid,
    output reg o_adex,
    output reg o_priviledged,
    output reg o_exclusive,
    output reg o_write_enable,
    // output reg [3:0] o_byte_enable,
    output reg [8:0] o_exec_load_rd,
    output logic [31:0] o_status_bits,
    output logic o_multiply_done,
    input logic i_status_bits_irq_mask,
    input logic i_status_bits_firq_mask,
    input logic i_shift_imm_zero,
    input logic i_decode_exclusive,
    input logic i_user_mode_regs_store_nxt,
    input logic i_firq_not_user_mode,
    input logic i_use_carry_in,
    input logic i_write_data_wen,
    input logic i_base_address_wen,
    input logic i_pc_wen,
    input logic [14:0] i_reg_bank_wen,
    input logic i_status_bits_flags_wen,
    input logic i_status_bits_mode_wen,
    input logic i_status_bits_irq_mask_wen,
    input logic i_status_bits_firq_mask_wen,
    input logic i_copro_write_data_wen,
    input logic i_conflict,
    input logic i_rn_use_read,
    input logic i_rm_use_read,
    input logic i_rs_use_read,
    input logic i_rd_use_read
    );

logic [31:0] i_wb_read_data;
logic [10:0] i_wb_load_rd;
logic [31:0] i_copro_read_data;
logic [7:0] i_decode_load_rd;
logic [1:0] i_status_bits_mode;
logic [31:0] i_imm32;
logic [4:0] i_imm_shift_amount;
logic [3:0] i_condition;
logic [3:0] i_rm_sel;
logic [3:0] i_rs_sel;
logic [3:0] i_rn_sel;
logic [1:0] i_barrel_shift_amount_sel;
logic [1:0] i_barrel_shift_data_sel;
logic [1:0] i_barrel_shift_function;
logic [8:0] i_alu_function;
logic [1:0] i_multiply_function;
logic [2:0] i_interrupt_vector_sel;
logic [3:0] i_iaddress_sel;
logic [3:0] i_daddress_sel;
logic [2:0] i_pc_sel;
logic [1:0] i_byte_enable_sel;
logic [2:0] i_status_bits_sel;
logic [2:0] i_reg_write_sel;

reg [3:0] o_byte_enable; // to avoid i/o overutilization


RandomNumberGenerator #(32, 3) rng_i_wb_read_data (
  .clk(clk),
  .reset(reset),
  .random_number(i_wb_read_data[31:0])
);

RandomNumberGenerator #(11, 5) rng_i_wb_load_rd (
  .clk(clk),
  .reset(reset),
  .random_number(i_wb_load_rd[10:0])
);

RandomNumberGenerator #(32, 7) rng_i_copro_read_data (
  .clk(clk),
  .reset(reset),
  .random_number(i_copro_read_data[31:0])
);

RandomNumberGenerator #(8, 9) rng_i_decode_load_rd (
  .clk(clk),
  .reset(reset),
  .random_number(i_decode_load_rd[7:0])
);

RandomNumberGenerator #(2, 11) rng_i_status_bits_mode (
  .clk(clk),
  .reset(reset),
  .random_number(i_status_bits_mode[1:0])
);

RandomNumberGenerator #(32, 13) rng_i_imm32 (
  .clk(clk),
  .reset(reset),
  .random_number(i_imm32[31:0])
);

RandomNumberGenerator #(5, 15) rng_i_imm_shift_amount (
  .clk(clk),
  .reset(reset),
  .random_number(i_imm_shift_amount[4:0])
);

RandomNumberGenerator #(4, 17) rng_i_condition (
  .clk(clk),
  .reset(reset),
  .random_number(i_condition[3:0])
);

RandomNumberGenerator #(4, 19) rng_i_rm_sel (
  .clk(clk),
  .reset(reset),
  .random_number(i_rm_sel[3:0])
);

RandomNumberGenerator #(4, 21) rng_i_rs_sel (
  .clk(clk),
  .reset(reset),
  .random_number(i_rs_sel[3:0])
);

RandomNumberGenerator #(4, 23) rng_i_rn_sel (
  .clk(clk),
  .reset(reset),
  .random_number(i_rn_sel[3:0])
);

RandomNumberGenerator #(2, 25) rng_i_barrel_shift_amount_sel (
  .clk(clk),
  .reset(reset),
  .random_number(i_barrel_shift_amount_sel[1:0])
);

RandomNumberGenerator #(2, 27) rng_i_barrel_shift_data_sel (
  .clk(clk),
  .reset(reset),
  .random_number(i_barrel_shift_data_sel[1:0])
);

RandomNumberGenerator #(2, 29) rng_i_barrel_shift_function (
  .clk(clk),
  .reset(reset),
  .random_number(i_barrel_shift_function[1:0])
);

RandomNumberGenerator #(9, 31) rng_i_alu_function (
  .clk(clk),
  .reset(reset),
  .random_number(i_alu_function[8:0])
);

RandomNumberGenerator #(2,33) rng_i_multiply_function (
  .clk(clk),
  .reset(reset),
  .random_number(i_multiply_function[1:0])
);

RandomNumberGenerator #(3, 35) rng_i_interrupt_vector_sel (
  .clk(clk),
  .reset(reset),
  .random_number(i_interrupt_vector_sel[2:0])
);

RandomNumberGenerator #(4, 37) rng_i_iaddress_sel (
  .clk(clk),
  .reset(reset),
  .random_number(i_iaddress_sel[3:0])
);

RandomNumberGenerator #(4, 39) rng_i_daddress_sel (
  .clk(clk),
  .reset(reset),
  .random_number(i_daddress_sel[3:0])
);

RandomNumberGenerator #(3, 41) rng_i_pc_sel (
  .clk(clk),
  .reset(reset),
  .random_number(i_pc_sel[2:0])
);

RandomNumberGenerator #(2, 43) rng_i_byte_enable_sel (
  .clk(clk),
  .reset(reset),
  .random_number(i_byte_enable_sel[1:0])
);

RandomNumberGenerator #(3, 45) rng_i_status_bits_sel (
  .clk(clk),
  .reset(reset),
  .random_number(i_status_bits_sel[2:0])
);

RandomNumberGenerator #(3, 47) rng_i_reg_write_sel (
  .clk(clk),
  .reset(reset),
  .random_number(i_reg_write_sel[2:0])
);

a25_execute execute (
    .i_clk(clk),
    .i_core_stall(i_core_stall),
    .i_mem_stall(i_mem_stall),
    .o_exec_stall(o_exec_stall),
    .i_wb_read_data(i_wb_read_data[31:0]),
    .i_wb_read_data_valid(i_wb_read_data_valid),
    .i_wb_load_rd(i_wb_load_rd[10:0]),
    .i_copro_read_data(i_copro_read_data[31:0]),
    .i_decode_iaccess(i_decode_iaccess),
    .i_decode_daccess(i_decode_daccess),
    .i_decode_load_rd(i_decode_load_rd[7:0]),
    .o_copro_write_data(o_copro_write_data[31:0]),
    .o_write_data(o_write_data[31:0]),
    .o_iaddress(o_iaddress[31:0]),
    .o_iaddress_nxt(o_iaddress_nxt[31:0]),
    .o_iaddress_valid(o_iaddress_valid),
    .o_daddress(o_daddress[31:0]),
    .o_daddress_nxt(o_daddress_nxt[31:0]),
    .o_daddress_valid(o_daddress_valid),
    .o_adex(o_adex),
    .o_priviledged(o_priviledged),
    .o_exclusive(o_exclusive),
    .o_write_enable(o_write_enable),
    .o_byte_enable(o_byte_enable[3:0]),
    .o_exec_load_rd(o_exec_load_rd[8:0]),
    .o_status_bits(o_status_bits[31:0]),
    .o_multiply_done(o_multiply_done),
    .i_status_bits_mode(i_status_bits_mode[1:0]),
    .i_status_bits_irq_mask(i_status_bits_irq_mask),
    .i_status_bits_firq_mask(i_status_bits_firq_mask),
    .i_imm32(i_imm32[31:0]),
    .i_imm_shift_amount(i_imm_shift_amount[4:0]),
    .i_shift_imm_zero(i_shift_imm_zero),
    .i_condition(i_condition[3:0]),
    .i_decode_exclusive(i_decode_exclusive),
    .i_rm_sel(i_rm_sel[3:0]),
    .i_rs_sel(i_rs_sel[3:0]),
    .i_rn_sel(i_rn_sel[3:0]),
    .i_barrel_shift_amount_sel(i_barrel_shift_amount_sel[1:0]),
    .i_barrel_shift_data_sel(i_barrel_shift_data_sel[1:0]),
    .i_barrel_shift_function(i_barrel_shift_function[1:0]),
    .i_alu_function(i_alu_function[8:0]),
    .i_multiply_function(i_multiply_function[1:0]),
    .i_interrupt_vector_sel(i_interrupt_vector_sel[2:0]),
    .i_iaddress_sel(i_iaddress_sel[3:0]),
    .i_daddress_sel(i_daddress_sel[3:0]),
    .i_pc_sel(i_pc_sel[2:0]),
    .i_byte_enable_sel(i_byte_enable_sel[1:0]),
    .i_status_bits_sel(i_status_bits_sel[2:0]),
    .i_reg_write_sel(i_reg_write_sel[2:0]),
    .i_user_mode_regs_store_nxt(i_user_mode_regs_store_nxt),
    .i_firq_not_user_mode(i_firq_not_user_mode),
    .i_use_carry_in(i_use_carry_in),
    .i_write_data_wen(i_write_data_wen),
    .i_base_address_wen(i_base_address_wen),
    .i_pc_wen(i_pc_wen),
    .i_reg_bank_wen(i_reg_bank_wen[14:0]),
    .i_status_bits_flags_wen(i_status_bits_flags_wen),
    .i_status_bits_mode_wen(i_status_bits_mode_wen),
    .i_status_bits_irq_mask_wen(i_status_bits_irq_mask_wen),
    .i_status_bits_firq_mask_wen(i_status_bits_firq_mask_wen),
    .i_copro_write_data_wen(i_copro_write_data_wen),
    .i_conflict(i_conflict),
    .i_rn_use_read(i_rn_use_read),
    .i_rm_use_read(i_rm_use_read),
    .i_rs_use_read(i_rs_use_read),
    .i_rd_use_read(i_rd_use_read)
);

endmodule