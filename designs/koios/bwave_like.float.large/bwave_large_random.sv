/*
Randomize input to bwave_large
*/ 

`include "../../random_number_generator.sv"

`define NUM_TILES 4
`define NUM_LDPES 32
`define DSPS_PER_LDPE 4

`define IN_PRECISION 16
`define OUT_PRECISION 16

`define FLOAT_EXP 8
`define FLOAT_MANTISA 7
`define FLOAT_DWIDTH (`FLOAT_EXP+`FLOAT_MANTISA + 1)

`define BFLOAT_EXP 5
`define BFLOAT_MANTISA 5
`define BFLOAT_DWIDTH (`BFLOAT_EXP + `BFLOAT_MANTISA + 1)
`define BFLOAT_MANTISA_WITH_LO (`BFLOAT_MANTISA+1)


`define DSPS_PER_SUB_LDPE 4
`define SUB_LDPES_PER_LDPE (`DSPS_PER_LDPE/`DSPS_PER_SUB_LDPE)

`define MULTS_PER_DSP 2
`define DSP_X_AVA_INPUT_WIDTH 18
`define LDPE_X_AVA_INPUT_WIDTH (`DSP_X_AVA_INPUT_WIDTH * `DSPS_PER_LDPE)
`define DSP_Y_AVA_INPUT_WIDTH 19
`define LDPE_Y_AVA_INPUT_WIDTH (`DSP_Y_AVA_INPUT_WIDTH * `DSPS_PER_LDPE)

`define DSP_AVA_OUTPUT_WIDTH 37
`define LDPE_AVA_OUTPUT_WIDTH `DSP_AVA_OUTPUT_WIDTH

`define DSP_USED_INPUT_WIDTH (`BFLOAT_MANTISA+1)

`define LDPE_USED_INPUT_WIDTH (`FLOAT_DWIDTH * `DSPS_PER_LDPE)
`define SUB_LDPE_USED_INPUT_WIDTH (`BFLOAT_DWIDTH * `DSPS_PER_SUB_LDPE)
`define DSP_X_ZERO_PAD_INPUT_WIDTH (`DSP_X_AVA_INPUT_WIDTH - `DSP_USED_INPUT_WIDTH)
`define DSP_Y_ZERO_PAD_INPUT_WIDTH (`DSP_Y_AVA_INPUT_WIDTH - `DSP_USED_INPUT_WIDTH)

`define DSP_USED_OUTPUT_WIDTH 27
`define LDPE_USED_OUTPUT_WIDTH `DSP_USED_OUTPUT_WIDTH
`define DSP_ZERO_PAD_OUTPUT_WIDTH (`DSP_AVA_OUTPUT_WIDTH - `DSP_USED_OUTPUT_WIDTH)

`define LDPES_PER_MRF 1
`define DSPS_PER_MRF (`DSPS_PER_LDPE * `LDPES_PER_MRF)
`define MAT_BRAM_AWIDTH 9
`define MAT_BRAM_DWIDTH 16
`define MAT_BRAMS_PER_MRF_SUBSET 8
`define SUBSETS_PER_MRF 1
`define BRAMS_PER_MRF (`MAT_BRAMS_PER_MRF_SUBSET * `SUBSETS_PER_MRF)
`define MRF_AWIDTH (`MAT_BRAM_AWIDTH)
`define MRF_DWIDTH (`MAT_BRAM_DWIDTH * `MAT_BRAMS_PER_MRF_SUBSET)

`define LDPES_PER_VRF 1
`define DSPS_PER_VRF (`DSPS_PER_LDPE * `LDPES_PER_VRF)
`define VEC_BRAM_AWIDTH 9
`define VEC_BRAM_DWIDTH 16
`define BRAMS_PER_VRF 8
`define VRF_AWIDTH `VEC_BRAM_AWIDTH
`define VRF_DWIDTH (`VEC_BRAM_DWIDTH * `BRAMS_PER_VRF)

`define LDPES_PER_ORF 1
`define OUTPUTS_PER_LDPE 1
`define OUT_BRAM_AWIDTH 9
`define OUT_BRAM_DWIDTH 16
`define ORF_AWIDTH `OUT_BRAM_AWIDTH
`define OUT_DWIDTH 16
`define ORF_DWIDTH 512 //512

`define MAX_VRF_DWIDTH 512
`define DRAM_DWIDTH `ORF_DWIDTH //This is the max of mrf, orf and vrf widths
`define DRAM_AWIDTH `MRF_AWIDTH

`define OPCODE_WIDTH 4 
`define TARGET_OP_WIDTH 8

`define INSTR_WIDTH (`OPCODE_WIDTH+`TARGET_OP_WIDTH+`DRAM_AWIDTH+`TARGET_OP_WIDTH+`VRF_AWIDTH + `VRF_AWIDTH)

`define ACTIVATION 2'b00
`define ELT_WISE_MULTIPLY 2'b10
`define ELT_WISE_ADD 2'b01
`define BYPASS 2'b11

`define RELU 2'b00
`define TANH 2'b01
`define SIGM 2'b10
//OPCODES

`define V_RD 0
`define V_WR 1
`define M_RD 2
`define M_WR 3 //NEWLY ADDED
`define MV_MUL 4
`define VV_ADD 5
`define VV_SUB 6 //QUESTIONED
`define VV_PASS 7
`define VV_MUL 8
`define V_RELU 9
`define V_SIGM 10
`define V_TANH 11
`define END_CHAIN 12
//MEM_IDS

`define VRF_0 0
`define VRF_1 1
`define VRF_2 2
`define VRF_3 3

`define VRF_4 4
`define VRF_5 5
`define VRF_6 6
`define VRF_7 7
`define VRF_MUXED 8
`define DRAM_MEM_ID 9
`define MFU_0_DSTN_ID 10
`define MFU_1_DSTN_ID 11

`define MRF_0 0
`define MRF_1 1
`define MRF_2 2
`define MRF_3 3
`define MRF_4 4
`define MRF_5 5
`define MRF_6 6
`define MRF_7 7
`define MRF_8 8
`define MRF_9 9
`define MRF_10 10
`define MRF_11 11
`define MRF_12 12
`define MRF_13 13
`define MRF_14 14
`define MRF_15 15
`define MRF_16 16
`define MRF_17 17
`define MRF_18 18
`define MRF_19 19
`define MRF_20 20
`define MRF_21 21
`define MRF_22 22
`define MRF_23 23
`define MRF_24 24
`define MRF_25 25
`define MRF_26 26
`define MRF_27 27
`define MRF_28 28
`define MRF_29 29
`define MRF_30 30
`define MRF_31 31
`define MRF_32 32
`define MRF_33 33
`define MRF_34 34
`define MRF_35 35
`define MRF_36 36
`define MRF_37 37
`define MRF_38 38
`define MRF_39 39
`define MRF_40 40
`define MRF_41 41
`define MRF_42 42
`define MRF_43 43
`define MRF_44 44
`define MRF_45 45
`define MRF_46 46
`define MRF_47 47
`define MRF_48 48
`define MRF_49 49
`define MRF_50 50
`define MRF_51 51
`define MRF_52 52
`define MRF_53 53
`define MRF_54 54
`define MRF_55 55
`define MRF_56 56
`define MRF_57 57
`define MRF_58 58
`define MRF_59 59
`define MRF_60 60
`define MRF_61 61
`define MRF_62 62
`define MRF_63 63
`define MRF_64 64
`define MRF_65 65
`define MRF_66 66
`define MRF_67 67
`define MRF_68 68
`define MRF_69 69
`define MRF_70 70
`define MRF_71 71
`define MRF_72 72
`define MRF_73 73
`define MRF_74 74
`define MRF_75 75
`define MRF_76 76
`define MRF_77 77
`define MRF_78 78
`define MRF_79 79
`define MRF_80 80
`define MRF_81 81
`define MRF_82 82
`define MRF_83 83
`define MRF_84 84
`define MRF_85 85
`define MRF_86 86
`define MRF_87 87
`define MRF_88 88
`define MRF_89 89
`define MRF_90 90
`define MRF_91 91
`define MRF_92 92
`define MRF_93 93
`define MRF_94 94
`define MRF_95 95
`define MRF_96 96
`define MRF_97 97
`define MRF_98 98
`define MRF_99 99
`define MRF_100 100
`define MRF_101 101
`define MRF_102 102
`define MRF_103 103
`define MRF_104 104
`define MRF_105 105
`define MRF_106 106
`define MRF_107 107
`define MRF_108 108
`define MRF_109 109
`define MRF_110 110
`define MRF_111 111
`define MRF_112 112
`define MRF_113 113
`define MRF_114 114
`define MRF_115 115
`define MRF_116 116
`define MRF_117 117
`define MRF_118 118
`define MRF_119 119
`define MRF_120 120
`define MRF_121 121
`define MRF_122 122
`define MRF_123 123
`define MRF_124 124
`define MRF_125 125
`define MRF_126 126
`define MRF_127 127

`define MFU_0 0
`define MFU_1 1
`define INSTR_MEM_AWIDTH 9

`define EXPONENT 5
`define MANTISSA 10

`define SIGN 1
`define NUM_COMPARATOR_TREE_CYCLES 5
`define NUM_COMPARATOR_TREE_CYCLES_FOR_TILE 4
`define NUM_LZD_CYCLES 5

`define DESIGN_SIZE `NUM_LDPES
`define DWIDTH `OUT_PRECISION
`define MASK_WIDTH `OUT_PRECISION

`define ADD_LATENCY 5
`define LOG_ADD_LATENCY 3
`define MUL_LATENCY 5
`define LOG_MUL_LATENCY 3 
`define ACTIVATION_LATENCY 3
`define TANH_LATENCY (`ACTIVATION_LATENCY+1)
`define SIGMOID_LATENCY (`ACTIVATION_LATENCY+1)

`define NUM_REDUCTION_CYCLES 2
`define NUM_MVM_CYCLES 16
`define NUM_NORMALISE_CYCLES 6

module bwave_large_random (
    input logic clk,
    input logic rst,
    // get rid of the vector output and output a single bit instead
    output logic single_xor_out,
    // output logic [`DRAM_DWIDTH-1:0] output_data_DRAM,
    output logic [`DRAM_AWIDTH-1:0] dram_addr,
    output logic dram_write_enable,
    output logic get_instr,
    output logic [`INSTR_MEM_AWIDTH-1:0] get_instr_addr
);

logic [`DRAM_DWIDTH-1:0] input_data_DRAM;
// add in a temp vector for output data that we can xor into the single bit output
logic [`DRAM_DWIDTH-1:0] internal_output_data_DRAM;

RandomNumberGenerator #(`DRAM_DWIDTH, 0) rng (
    .clk(clk),
    .reset(rst),
    .random_number(input_data_DRAM)
);

logic [`INSTR_WIDTH-1:0] instruction;
RandomNumberGenerator #(`INSTR_WIDTH, 1) rng_instr (
    .clk(clk),
    .reset(rst),
    .random_number(instruction)
);

NPU npu0(
    rst,
    instruction,
    input_data_DRAM,
    internal_output_data_DRAM,
    dram_addr,
    dram_write_enable,
    get_instr,
    get_instr_addr,
    clk
);

assign single_xor_out = ^internal_output_data_DRAM;

endmodule

