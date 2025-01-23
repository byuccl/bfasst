/*
* a25_decode top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../../random_number_generator.sv"

module a25_decode_random(
    input logic clk,
    input logic reset,
    input logic i_core_stall,
    input logic i_irq,
    input logic i_firq,
    input logic i_dabt,
    input logic i_iabt,
    input logic i_adex,
    input logic i_multiply_done,
    output reg  [31:0] o_imm32,
    output reg  [4:0] o_imm_shift_amount,
    output reg  o_shift_imm_zero,
    output wire [3:0] o_condition,
    output reg  o_decode_exclusive,
    output wire o_decode_iaccess,
    output reg  o_decode_daccess,
    output wire [1:0] o_status_bits_mode,
    output wire o_status_bits_irq_mask,
    output wire o_status_bits_firq_mask,
    output reg  [3:0] o_rm_sel,
    output reg  [3:0] o_rs_sel,
    output reg  [7:0] o_load_rd,
    output reg  [3:0] o_rn_sel,
    output reg  [1:0] o_barrel_shift_amount_sel,
    output reg  [1:0] o_barrel_shift_data_sel,
    output reg  [1:0] o_barrel_shift_function,
    output reg  [8:0] o_alu_function,
    output reg  [1:0] o_multiply_function,
    output reg  [2:0] o_interrupt_vector_sel,
    output wire [3:0] o_iaddress_sel,
    output wire [3:0] o_daddress_sel,
    output wire [2:0] o_pc_sel,
    output reg  [1:0] o_byte_enable_sel,
    output reg  [2:0] o_status_bits_sel,
    output reg  [2:0] o_reg_write_sel,
    output reg  o_user_mode_regs_store_nxt,
    output reg  o_firq_not_user_mode,
    output reg  o_use_carry_in,
    output reg  o_write_data_wen,
    output reg  o_base_address_wen,
    output wire o_pc_wen,
    output reg  [14:0] o_reg_bank_wen,
    output reg  o_status_bits_flags_wen,
    output reg  o_status_bits_mode_wen,
    output reg  o_status_bits_irq_mask_wen,
    output reg  o_status_bits_firq_mask_wen,
    output reg  [2:0] o_copro_opcode1,
    output reg  [2:0] o_copro_opcode2,
    output reg  [3:0] o_copro_crn,
    output reg  [3:0] o_copro_crm,
    output reg  [3:0] o_copro_num,
    output reg  [1:0] o_copro_operation,
    output reg  o_copro_write_data_wen,
    output o_iabt_trigger,
    output [31:0] o_iabt_address,
    output [7:0] o_iabt_status,
    output o_dabt_trigger,
    output [31:0] o_dabt_address,
    output [7:0] o_dabt_status,
    output o_conflict,
    output reg  o_rn_use_read,
    output reg  o_rm_use_read,
    output reg  o_rs_use_read,
    output reg  o_rd_use_read
    );

logic [31:0] i_fetch_instruction;
logic [31:0] i_execute_iaddress;
logic [31:0] i_execute_daddress;
logic [7:0] i_abt_status;
logic [31:0] i_execute_status_bits;

RandomNumberGenerator #(32, 3) rng_i_fetch_instruction (
  .clk(clk),
  .reset(reset),
  .random_number(i_fetch_instruction[31:0])
);

RandomNumberGenerator #(32, 5) rng_i_execute_iaddress (
  .clk(clk),
  .reset(reset),
  .random_number(i_execute_iaddress[31:0])
);

RandomNumberGenerator #(32, 7) rng_i_execute_daddress (
  .clk(clk),
  .reset(reset),
  .random_number(i_execute_daddress[31:0])
);

RandomNumberGenerator #(8, 9) rng_i_abt_status (
  .clk(clk),
  .reset(reset),
  .random_number(i_abt_status[7:0])
);

RandomNumberGenerator #(32, 11) rng_i_execute_status_bits (
  .clk(clk),
  .reset(reset),
  .random_number(i_execute_status_bits[31:0])
);

a25_decode decode (
    .i_clk(clk),
    .i_fetch_instruction(i_fetch_instruction[31:0]),
    .i_core_stall(i_core_stall),
    .i_irq(i_irq),
    .i_firq(i_firq),
    .i_dabt(i_dabt),
    .i_iabt(i_iabt),
    .i_adex(i_adex),
    .i_execute_iaddress(i_execute_iaddress[31:0]),
    .i_execute_daddress(i_execute_daddress[31:0]),
    .i_abt_status(i_abt_status[7:0]),
    .i_execute_status_bits(i_execute_status_bits[31:0]),
    .i_multiply_done(i_multiply_done),
    .o_imm32(o_imm32[31:0]),
    .o_imm_shift_amount(o_imm_shift_amount[4:0]),
    .o_shift_imm_zero(o_shift_imm_zero),
    .o_condition(o_condition[3:0]),
    .o_decode_exclusive(o_decode_exclusive),
    .o_decode_iaccess(o_decode_iaccess),
    .o_decode_daccess(o_decode_daccess),
    .o_status_bits_mode(o_status_bits_mode[1:0]),
    .o_status_bits_irq_mask(o_status_bits_irq_mask),
    .o_status_bits_firq_mask(o_status_bits_firq_mask),
    .o_rm_sel(o_rm_sel[3:0]),
    .o_rs_sel(o_rs_sel[3:0]),
    .o_load_rd(o_load_rd[7:0]),
    .o_rn_sel(o_rn_sel[3:0]),
    .o_barrel_shift_amount_sel(o_barrel_shift_amount_sel[1:0]),
    .o_barrel_shift_data_sel(o_barrel_shift_data_sel[1:0]),
    .o_barrel_shift_function(o_barrel_shift_function[1:0]),
    .o_alu_function(o_alu_function[8:0]),
    .o_multiply_function(o_multiply_function[1:0]),
    .o_interrupt_vector_sel(o_interrupt_vector_sel[2:0]),
    .o_iaddress_sel(o_iaddress_sel[3:0]),
    .o_daddress_sel(o_daddress_sel[3:0]),
    .o_pc_sel(o_pc_sel[2:0]),
    .o_byte_enable_sel(o_byte_enable_sel[1:0]),
    .o_status_bits_sel(o_status_bits_sel[2:0]),
    .o_reg_write_sel(o_reg_write_sel[2:0]),
    .o_user_mode_regs_store_nxt(o_user_mode_regs_store_nxt),
    .o_firq_not_user_mode(o_firq_not_user_mode),
    .o_use_carry_in(o_use_carry_in),
    .o_write_data_wen(o_write_data_wen),
    .o_base_address_wen(o_base_address_wen),
    .o_pc_wen(o_pc_wen),
    .o_reg_bank_wen(o_reg_bank_wen[14:0]),
    .o_status_bits_flags_wen(o_status_bits_flags_wen),
    .o_status_bits_mode_wen(o_status_bits_mode_wen),
    .o_status_bits_irq_mask_wen(o_status_bits_irq_mask_wen),
    .o_status_bits_firq_mask_wen(o_status_bits_firq_mask_wen),
    .o_copro_opcode1(o_copro_opcode1[2:0]),
    .o_copro_opcode2(o_copro_opcode2[2:0]),
    .o_copro_crn(o_copro_crn[3:0]),
    .o_copro_crm(o_copro_crm[3:0]),
    .o_copro_num(o_copro_num[3:0]),
    .o_copro_operation(o_copro_operation[1:0]),
    .o_copro_write_data_wen(o_copro_write_data_wen),
    .o_iabt_trigger(o_iabt_trigger),
    .o_iabt_address(o_iabt_address[31:0]),
    .o_iabt_status(o_iabt_status[7:0]),
    .o_dabt_trigger(o_dabt_trigger),
    .o_dabt_address(o_dabt_address[31:0]),
    .o_dabt_status(o_dabt_status[7:0]),
    .o_conflict(o_conflict),
    .o_rn_use_read(o_rn_use_read),
    .o_rm_use_read(o_rm_use_read),
    .o_rs_use_read(o_rs_use_read),
    .o_rd_use_read(o_rd_use_read)
);

endmodule