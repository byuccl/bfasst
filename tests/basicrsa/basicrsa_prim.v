// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Thu Dec 13 17:34:19 2018
//
// Verilog Description of module basicrsa
//

module basicrsa (indata, inExp, inMod, cypher, clk, ds, reset, 
            ready);   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(74[8:16])
    input [31:0]indata;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(76[11:17])
    input [31:0]inExp;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(77[6:11])
    input [31:0]inMod;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(78[6:11])
    output [31:0]cypher;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(79[6:12])
    input clk;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(80[5:8])
    input ds;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(81[5:7])
    input reset;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(82[5:10])
    output ready;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    
    wire clk_c /* synthesis is_clock=1, SET_AS_NETWORK=clk_c */ ;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(80[5:8])
    
    wire GND_net, VCC_net, indata_c_31, indata_c_30, indata_c_29, 
        indata_c_28, indata_c_27, indata_c_26, indata_c_25, indata_c_24, 
        indata_c_23, indata_c_22, indata_c_21, indata_c_20, indata_c_19, 
        indata_c_18, indata_c_17, indata_c_16, indata_c_15, indata_c_14, 
        indata_c_13, indata_c_12, indata_c_11, indata_c_10, indata_c_9, 
        indata_c_8, indata_c_7, indata_c_6, indata_c_5, indata_c_4, 
        indata_c_3, indata_c_2, indata_c_1, indata_c_0, inExp_c_31, 
        inExp_c_30, inExp_c_29, inExp_c_28, inExp_c_27, inExp_c_26, 
        inExp_c_25, inExp_c_24, inExp_c_23, inExp_c_22, inExp_c_21, 
        inExp_c_20, inExp_c_19, inExp_c_18, inExp_c_17, inExp_c_16, 
        inExp_c_15, inExp_c_14, inExp_c_13, inExp_c_12, inExp_c_11, 
        inExp_c_10, inExp_c_9, inExp_c_8, inExp_c_7, inExp_c_6, inExp_c_5, 
        inExp_c_4, inExp_c_3, inExp_c_2, inExp_c_1, inExp_c_0, inMod_c_31, 
        inMod_c_30, inMod_c_29, inMod_c_28, inMod_c_27, inMod_c_26, 
        inMod_c_25, inMod_c_24, inMod_c_23, inMod_c_22, inMod_c_21, 
        inMod_c_20, inMod_c_19, inMod_c_18, inMod_c_17, inMod_c_16, 
        inMod_c_15, inMod_c_14, inMod_c_13, inMod_c_12, inMod_c_11, 
        inMod_c_10, inMod_c_9, inMod_c_8, inMod_c_7, inMod_c_6, inMod_c_5, 
        inMod_c_4, inMod_c_3, inMod_c_2, inMod_c_1, inMod_c_0, cypher_c_31, 
        cypher_c_30, cypher_c_29, cypher_c_28, cypher_c_27, cypher_c_26, 
        cypher_c_25, cypher_c_24, cypher_c_23, cypher_c_22, cypher_c_21, 
        cypher_c_20, cypher_c_19, cypher_c_18, cypher_c_17, cypher_c_16, 
        cypher_c_15, cypher_c_14, cypher_c_13, cypher_c_12, cypher_c_11, 
        cypher_c_10, cypher_c_9, cypher_c_8, cypher_c_7, cypher_c_6, 
        cypher_c_5, cypher_c_4, cypher_c_3, cypher_c_2, cypher_c_1, 
        cypher_c_0, ds_c, reset_c, ready_c;
    wire [31:0]modreg;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(102[8:14])
    wire [31:0]root;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(103[8:12])
    wire [31:0]square;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(104[8:14])
    wire [31:0]sqrin;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(105[8:13])
    wire [31:0]tempin;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(106[8:14])
    wire [31:0]tempout;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(107[8:15])
    wire [31:0]count;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(108[8:13])
    
    wire multrdy, sqrrdy, multgo, ready_N_452, n2912, n4528, n4559, 
        n50, n61;
    wire [31:0]root_31__N_65;
    
    wire n49, n4497;
    wire [31:0]tempin_31__N_129;
    wire [31:0]sqrin_31__N_97;
    wire [31:0]mpreg;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(88[8:13])
    wire [33:0]mcreg;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(89[8:13])
    wire [33:0]mcreg1;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(89[15:21])
    
    wire n2808, n2807, n2806, n3898, n48, n3895, n4683, n3892, 
        n2805;
    wire [33:0]prodreg;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[8:15])
    
    wire n4373, n5730, n4342, n3541, n4311, n4466, n5724;
    wire [31:0]mpreg_adj_916;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(88[8:13])
    wire [33:0]mcreg_adj_917;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(89[8:13])
    
    wire n2804, n2803, n2802, n4652, n2801;
    wire [33:0]prodreg_adj_922;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[8:15])
    wire [33:0]prodreg1_adj_923;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[17:25])
    wire [33:0]prodreg2_adj_924;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[27:35])
    wire [33:0]prodreg3_adj_925;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    
    wire n4280, n4858, n4838, n4807, n4776, n4745, n4714, n5812, 
        n4111, n4107, n4103, n4100, n4096, n4093, n4090, n4086, 
        n4083, n4080, n2915, n4076, n4073, n4070, n5726, n4063, 
        n4059, n4056, n4053, n4049, n4046, n4621, n4043, n4039, 
        n4036, n4033, n4029, n4026, n4023, n4019, n4016, n4013, 
        n4009, n4435, n4006, n4003, n3573, n3999, n1966, n3996, 
        n4404, n5728, n2830, n2829, n2828, n2827, n2826, n2825, 
        n2824, n2823, n2822, n2821, n2820, n2819, n2818, n2817, 
        n2816, n2815, n2814, n2813, n2812, n2811, n2810, n2009, 
        n2001, n2800, n3988, n2057, n60, n4590, n2088, n3985, 
        n2097, n3981, n3978, n3975, n3971, n3968, n3964, n55, 
        n3961, n54, n3958, n2179, n2193, n53, n52, n2315, n51, 
        n2809;
    
    VCC i2 (.Y(VCC_net));
    \modmult(32)  modsqr (.n2315(n2315), .clk_c(clk_c), .GND_net(GND_net), 
            .sqrrdy(sqrrdy), .reset_c(reset_c), .multgo(multgo), .n2915(n2915), 
            .prodreg3({prodreg3_adj_925[33], Open_0, Open_1, Open_2, 
            Open_3, Open_4, Open_5, Open_6, Open_7, Open_8, Open_9, 
            Open_10, Open_11, Open_12, Open_13, Open_14, Open_15, 
            Open_16, Open_17, Open_18, Open_19, Open_20, Open_21, 
            Open_22, Open_23, Open_24, Open_25, Open_26, Open_27, 
            Open_28, Open_29, Open_30, Open_31, Open_32}), .VCC_net(VCC_net), 
            .\prodreg3[29] (prodreg3_adj_925[29]), .\prodreg1[29] (prodreg1_adj_923[29]), 
            .\prodreg3[28] (prodreg3_adj_925[28]), .\prodreg1[28] (prodreg1_adj_923[28]), 
            .\prodreg3[27] (prodreg3_adj_925[27]), .\prodreg1[27] (prodreg1_adj_923[27]), 
            .\prodreg3[26] (prodreg3_adj_925[26]), .\prodreg1[26] (prodreg1_adj_923[26]), 
            .\prodreg3[25] (prodreg3_adj_925[25]), .\prodreg1[25] (prodreg1_adj_923[25]), 
            .\prodreg3[24] (prodreg3_adj_925[24]), .\prodreg1[24] (prodreg1_adj_923[24]), 
            .\prodreg2[33] (prodreg2_adj_924[33]), .\prodreg3[23] (prodreg3_adj_925[23]), 
            .\prodreg1[23] (prodreg1_adj_923[23]), .\prodreg3[22] (prodreg3_adj_925[22]), 
            .\prodreg1[22] (prodreg1_adj_923[22]), .\prodreg3[21] (prodreg3_adj_925[21]), 
            .\prodreg1[21] (prodreg1_adj_923[21]), .\prodreg3[20] (prodreg3_adj_925[20]), 
            .\prodreg1[20] (prodreg1_adj_923[20]), .\prodreg3[19] (prodreg3_adj_925[19]), 
            .\prodreg1[19] (prodreg1_adj_923[19]), .\prodreg3[18] (prodreg3_adj_925[18]), 
            .\prodreg1[18] (prodreg1_adj_923[18]), .\prodreg3[17] (prodreg3_adj_925[17]), 
            .\prodreg1[17] (prodreg1_adj_923[17]), .\prodreg3[16] (prodreg3_adj_925[16]), 
            .\prodreg1[16] (prodreg1_adj_923[16]), .\prodreg3[15] (prodreg3_adj_925[15]), 
            .\prodreg1[15] (prodreg1_adj_923[15]), .\prodreg3[14] (prodreg3_adj_925[14]), 
            .\prodreg1[14] (prodreg1_adj_923[14]), .\prodreg3[13] (prodreg3_adj_925[13]), 
            .\prodreg1[13] (prodreg1_adj_923[13]), .\prodreg3[12] (prodreg3_adj_925[12]), 
            .\prodreg1[12] (prodreg1_adj_923[12]), .\prodreg3[11] (prodreg3_adj_925[11]), 
            .\prodreg1[11] (prodreg1_adj_923[11]), .\square[10] (square[10]), 
            .\square[9] (square[9]), .\square[8] (square[8]), .\prodreg2[29] (prodreg2_adj_924[29]), 
            .\prodreg2[28] (prodreg2_adj_924[28]), .\prodreg2[27] (prodreg2_adj_924[27]), 
            .\prodreg2[26] (prodreg2_adj_924[26]), .\prodreg2[25] (prodreg2_adj_924[25]), 
            .\prodreg2[24] (prodreg2_adj_924[24]), .\prodreg[31] (prodreg_adj_922[31]), 
            .\prodreg[30] (prodreg_adj_922[30]), .\prodreg[29] (prodreg_adj_922[29]), 
            .\prodreg[28] (prodreg_adj_922[28]), .\prodreg2[23] (prodreg2_adj_924[23]), 
            .\prodreg2[22] (prodreg2_adj_924[22]), .\prodreg2[21] (prodreg2_adj_924[21]), 
            .\prodreg2[20] (prodreg2_adj_924[20]), .\prodreg2[19] (prodreg2_adj_924[19]), 
            .\prodreg2[18] (prodreg2_adj_924[18]), .\prodreg2[17] (prodreg2_adj_924[17]), 
            .\prodreg2[16] (prodreg2_adj_924[16]), .\prodreg2[15] (prodreg2_adj_924[15]), 
            .\prodreg[27] (prodreg_adj_922[27]), .\prodreg2[14] (prodreg2_adj_924[14]), 
            .\prodreg2[13] (prodreg2_adj_924[13]), .\prodreg2[12] (prodreg2_adj_924[12]), 
            .\prodreg2[11] (prodreg2_adj_924[11]), .\prodreg[26] (prodreg_adj_922[26]), 
            .\prodreg[25] (prodreg_adj_922[25]), .\prodreg[24] (prodreg_adj_922[24]), 
            .n4111(n4111), .\prodreg[0] (prodreg_adj_922[0]), .n4103(n4103), 
            .n4100(n4100), .n4096(n4096), .n4093(n4093), .n4090(n4090), 
            .n4086(n4086), .n4083(n4083), .n4080(n4080), .n4076(n4076), 
            .\prodreg[23] (prodreg_adj_922[23]), .n4073(n4073), .\prodreg[22] (prodreg_adj_922[22]), 
            .n4070(n4070), .\prodreg[21] (prodreg_adj_922[21]), .\square[7] (square[7]), 
            .n5724(n5724), .\mcreg[0] (mcreg_adj_917[0]), .n4063(n4063), 
            .\prodreg[20] (prodreg_adj_922[20]), .n4059(n4059), .\prodreg[19] (prodreg_adj_922[19]), 
            .n4056(n4056), .\prodreg[18] (prodreg_adj_922[18]), .n4049(n4049), 
            .\prodreg[17] (prodreg_adj_922[17]), .n4046(n4046), .\prodreg[16] (prodreg_adj_922[16]), 
            .n4043(n4043), .\prodreg[15] (prodreg_adj_922[15]), .n4039(n4039), 
            .\prodreg[14] (prodreg_adj_922[14]), .n4036(n4036), .\prodreg[13] (prodreg_adj_922[13]), 
            .n4033(n4033), .\prodreg[12] (prodreg_adj_922[12]), .n4029(n4029), 
            .\prodreg[11] (prodreg_adj_922[11]), .n4026(n4026), .\prodreg[10] (prodreg_adj_922[10]), 
            .\square[6] (square[6]), .n4023(n4023), .\prodreg[9] (prodreg_adj_922[9]), 
            .n4019(n4019), .\prodreg[8] (prodreg_adj_922[8]), .n4016(n4016), 
            .\prodreg[7] (prodreg_adj_922[7]), .n4013(n4013), .\prodreg[6] (prodreg_adj_922[6]), 
            .n4009(n4009), .\prodreg[5] (prodreg_adj_922[5]), .n4006(n4006), 
            .\prodreg[4] (prodreg_adj_922[4]), .n4003(n4003), .\prodreg[3] (prodreg_adj_922[3]), 
            .n3999(n3999), .\prodreg[2] (prodreg_adj_922[2]), .n3996(n3996), 
            .\prodreg[1] (prodreg_adj_922[1]), .n5726(n5726), .\mpreg[31] (mpreg_adj_916[31]), 
            .\square[5] (square[5]), .\square[4] (square[4]), .\square[2] (square[2]), 
            .\square[3] (square[3]), .n2193(n2193), .\square[1] (square[1]), 
            .\square[31] (square[31]), .\square[30] (square[30]), .\square[0] (square[0]), 
            .root({root}), .modreg({modreg}));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(141[10:17])
    SB_DFFER root_i0 (.Q(root[0]), .C(clk_c), .E(n3541), .D(root_31__N_65[0]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_LUT4 i2532_2_lut_4_lut (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(square[8]), .O(sqrin_31__N_97[8]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i2532_2_lut_4_lut.LUT_INIT = 16'h3a00;
    SB_DFFER count__i1 (.Q(count[0]), .C(clk_c), .E(n2001), .D(n2830), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER tempin_i0 (.Q(tempin[0]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[0]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i0 (.Q(sqrin[0]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[0]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER root_i1 (.Q(root[1]), .C(clk_c), .E(n3541), .D(root_31__N_65[1]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_LUT4 tempout_31__I_0_i2_4_lut (.I0(tempout[1]), .I1(indata_c_1), 
            .I2(ready_c), .I3(inExp_c_0), .O(tempin_31__N_129[1]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam tempout_31__I_0_i2_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i2533_2_lut_4_lut (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(square[7]), .O(sqrin_31__N_97[7]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i2533_2_lut_4_lut.LUT_INIT = 16'h3a00;
    SB_IO cypher_pad_26 (.PACKAGE_PIN(cypher[26]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_26)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_26.PIN_TYPE = 6'b011001;
    defparam cypher_pad_26.PULLUP = 1'b0;
    defparam cypher_pad_26.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_26.IO_STANDARD = "SB_LVCMOS";
    SB_DFFR multgo_71 (.Q(multgo), .C(clk_c), .D(n5730), .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(252[3] 270[10])
    SB_DFFER modreg_51_i0_i0 (.Q(modreg[0]), .C(clk_c), .E(n1966), .D(inMod_c_0), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_IO cypher_pad_31 (.PACKAGE_PIN(cypher[31]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_31)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_31.PIN_TYPE = 6'b011001;
    defparam cypher_pad_31.PULLUP = 1'b0;
    defparam cypher_pad_31.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_31.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_27 (.PACKAGE_PIN(cypher[27]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_27)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_27.PIN_TYPE = 6'b011001;
    defparam cypher_pad_27.PULLUP = 1'b0;
    defparam cypher_pad_27.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_27.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_28 (.PACKAGE_PIN(cypher[28]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_28)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_28.PIN_TYPE = 6'b011001;
    defparam cypher_pad_28.PULLUP = 1'b0;
    defparam cypher_pad_28.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_28.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_29 (.PACKAGE_PIN(cypher[29]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_29)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_29.PIN_TYPE = 6'b011001;
    defparam cypher_pad_29.PULLUP = 1'b0;
    defparam cypher_pad_29.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_29.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_30 (.PACKAGE_PIN(cypher[30]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_30)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_30.PIN_TYPE = 6'b011001;
    defparam cypher_pad_30.PULLUP = 1'b0;
    defparam cypher_pad_30.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_30.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_24 (.PACKAGE_PIN(cypher[24]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_24)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_24.PIN_TYPE = 6'b011001;
    defparam cypher_pad_24.PULLUP = 1'b0;
    defparam cypher_pad_24.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_24.IO_STANDARD = "SB_LVCMOS";
    SB_DFFS done_64 (.Q(ready_c), .C(clk_c), .D(n5728), .S(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER modreg_51_i0_i31 (.Q(modreg[31]), .C(clk_c), .E(n1966), .D(inMod_c_31), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i30 (.Q(modreg[30]), .C(clk_c), .E(n1966), .D(inMod_c_30), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i29 (.Q(modreg[29]), .C(clk_c), .E(n1966), .D(inMod_c_29), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i28 (.Q(modreg[28]), .C(clk_c), .E(n1966), .D(inMod_c_28), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i27 (.Q(modreg[27]), .C(clk_c), .E(n1966), .D(inMod_c_27), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i26 (.Q(modreg[26]), .C(clk_c), .E(n1966), .D(inMod_c_26), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i25 (.Q(modreg[25]), .C(clk_c), .E(n1966), .D(inMod_c_25), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i24 (.Q(modreg[24]), .C(clk_c), .E(n1966), .D(inMod_c_24), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i23 (.Q(modreg[23]), .C(clk_c), .E(n1966), .D(inMod_c_23), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i22 (.Q(modreg[22]), .C(clk_c), .E(n1966), .D(inMod_c_22), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i21 (.Q(modreg[21]), .C(clk_c), .E(n1966), .D(inMod_c_21), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i20 (.Q(modreg[20]), .C(clk_c), .E(n1966), .D(inMod_c_20), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i19 (.Q(modreg[19]), .C(clk_c), .E(n1966), .D(inMod_c_19), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i18 (.Q(modreg[18]), .C(clk_c), .E(n1966), .D(inMod_c_18), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i17 (.Q(modreg[17]), .C(clk_c), .E(n1966), .D(inMod_c_17), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i16 (.Q(modreg[16]), .C(clk_c), .E(n1966), .D(inMod_c_16), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i15 (.Q(modreg[15]), .C(clk_c), .E(n1966), .D(inMod_c_15), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i14 (.Q(modreg[14]), .C(clk_c), .E(n1966), .D(inMod_c_14), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i13 (.Q(modreg[13]), .C(clk_c), .E(n1966), .D(inMod_c_13), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i12 (.Q(modreg[12]), .C(clk_c), .E(n1966), .D(inMod_c_12), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i11 (.Q(modreg[11]), .C(clk_c), .E(n1966), .D(inMod_c_11), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i10 (.Q(modreg[10]), .C(clk_c), .E(n1966), .D(inMod_c_10), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i9 (.Q(modreg[9]), .C(clk_c), .E(n1966), .D(inMod_c_9), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i8 (.Q(modreg[8]), .C(clk_c), .E(n1966), .D(inMod_c_8), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i7 (.Q(modreg[7]), .C(clk_c), .E(n1966), .D(inMod_c_7), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i6 (.Q(modreg[6]), .C(clk_c), .E(n1966), .D(inMod_c_6), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i5 (.Q(modreg[5]), .C(clk_c), .E(n1966), .D(inMod_c_5), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i4 (.Q(modreg[4]), .C(clk_c), .E(n1966), .D(inMod_c_4), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i3 (.Q(modreg[3]), .C(clk_c), .E(n1966), .D(inMod_c_3), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i2 (.Q(modreg[2]), .C(clk_c), .E(n1966), .D(inMod_c_2), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER modreg_51_i0_i1 (.Q(modreg[1]), .C(clk_c), .E(n1966), .D(inMod_c_1), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i3 (.Q(root[3]), .C(clk_c), .E(n3541), .D(root_31__N_65[3]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i4 (.Q(root[4]), .C(clk_c), .E(n3541), .D(root_31__N_65[4]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_IO cypher_pad_23 (.PACKAGE_PIN(cypher[23]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_23)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_23.PIN_TYPE = 6'b011001;
    defparam cypher_pad_23.PULLUP = 1'b0;
    defparam cypher_pad_23.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_23.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_22 (.PACKAGE_PIN(cypher[22]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_22)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_22.PIN_TYPE = 6'b011001;
    defparam cypher_pad_22.PULLUP = 1'b0;
    defparam cypher_pad_22.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_22.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_21 (.PACKAGE_PIN(cypher[21]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_21)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_21.PIN_TYPE = 6'b011001;
    defparam cypher_pad_21.PULLUP = 1'b0;
    defparam cypher_pad_21.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_21.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_20 (.PACKAGE_PIN(cypher[20]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_20)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_20.PIN_TYPE = 6'b011001;
    defparam cypher_pad_20.PULLUP = 1'b0;
    defparam cypher_pad_20.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_20.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_19 (.PACKAGE_PIN(cypher[19]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_19)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_19.PIN_TYPE = 6'b011001;
    defparam cypher_pad_19.PULLUP = 1'b0;
    defparam cypher_pad_19.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_19.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_18 (.PACKAGE_PIN(cypher[18]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_18)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_18.PIN_TYPE = 6'b011001;
    defparam cypher_pad_18.PULLUP = 1'b0;
    defparam cypher_pad_18.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_18.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_17 (.PACKAGE_PIN(cypher[17]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_17)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_17.PIN_TYPE = 6'b011001;
    defparam cypher_pad_17.PULLUP = 1'b0;
    defparam cypher_pad_17.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_17.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_16 (.PACKAGE_PIN(cypher[16]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_16)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_16.PIN_TYPE = 6'b011001;
    defparam cypher_pad_16.PULLUP = 1'b0;
    defparam cypher_pad_16.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_16.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_15 (.PACKAGE_PIN(cypher[15]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_15)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_15.PIN_TYPE = 6'b011001;
    defparam cypher_pad_15.PULLUP = 1'b0;
    defparam cypher_pad_15.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_15.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_14 (.PACKAGE_PIN(cypher[14]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_14)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_14.PIN_TYPE = 6'b011001;
    defparam cypher_pad_14.PULLUP = 1'b0;
    defparam cypher_pad_14.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_14.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_13 (.PACKAGE_PIN(cypher[13]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_13)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_13.PIN_TYPE = 6'b011001;
    defparam cypher_pad_13.PULLUP = 1'b0;
    defparam cypher_pad_13.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_13.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_12 (.PACKAGE_PIN(cypher[12]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_12)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_12.PIN_TYPE = 6'b011001;
    defparam cypher_pad_12.PULLUP = 1'b0;
    defparam cypher_pad_12.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_12.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_11 (.PACKAGE_PIN(cypher[11]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_11)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_11.PIN_TYPE = 6'b011001;
    defparam cypher_pad_11.PULLUP = 1'b0;
    defparam cypher_pad_11.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_11.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_10 (.PACKAGE_PIN(cypher[10]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_10)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_10.PIN_TYPE = 6'b011001;
    defparam cypher_pad_10.PULLUP = 1'b0;
    defparam cypher_pad_10.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_10.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_9 (.PACKAGE_PIN(cypher[9]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_9)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_9.PIN_TYPE = 6'b011001;
    defparam cypher_pad_9.PULLUP = 1'b0;
    defparam cypher_pad_9.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_9.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_8 (.PACKAGE_PIN(cypher[8]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_8)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_8.PIN_TYPE = 6'b011001;
    defparam cypher_pad_8.PULLUP = 1'b0;
    defparam cypher_pad_8.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_8.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_7 (.PACKAGE_PIN(cypher[7]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_7)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_7.PIN_TYPE = 6'b011001;
    defparam cypher_pad_7.PULLUP = 1'b0;
    defparam cypher_pad_7.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_7.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_6 (.PACKAGE_PIN(cypher[6]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_6)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_6.PIN_TYPE = 6'b011001;
    defparam cypher_pad_6.PULLUP = 1'b0;
    defparam cypher_pad_6.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_6.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_5 (.PACKAGE_PIN(cypher[5]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_5)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_5.PIN_TYPE = 6'b011001;
    defparam cypher_pad_5.PULLUP = 1'b0;
    defparam cypher_pad_5.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_5.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_4 (.PACKAGE_PIN(cypher[4]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_4)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_4.PIN_TYPE = 6'b011001;
    defparam cypher_pad_4.PULLUP = 1'b0;
    defparam cypher_pad_4.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_4.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_3 (.PACKAGE_PIN(cypher[3]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_3)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_3.PIN_TYPE = 6'b011001;
    defparam cypher_pad_3.PULLUP = 1'b0;
    defparam cypher_pad_3.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_3.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_2 (.PACKAGE_PIN(cypher[2]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_2)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_2.PIN_TYPE = 6'b011001;
    defparam cypher_pad_2.PULLUP = 1'b0;
    defparam cypher_pad_2.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_2.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_1 (.PACKAGE_PIN(cypher[1]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_1)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_1.PIN_TYPE = 6'b011001;
    defparam cypher_pad_1.PULLUP = 1'b0;
    defparam cypher_pad_1.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_1.IO_STANDARD = "SB_LVCMOS";
    SB_IO cypher_pad_0 (.PACKAGE_PIN(cypher[0]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_0)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_0.PIN_TYPE = 6'b011001;
    defparam cypher_pad_0.PULLUP = 1'b0;
    defparam cypher_pad_0.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_0.IO_STANDARD = "SB_LVCMOS";
    SB_IO ready_pad (.PACKAGE_PIN(ready), .OUTPUT_ENABLE(VCC_net), .D_OUT_0(ready_c));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam ready_pad.PIN_TYPE = 6'b011001;
    defparam ready_pad.PULLUP = 1'b0;
    defparam ready_pad.NEG_TRIGGER = 1'b0;
    defparam ready_pad.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_31 (.PACKAGE_PIN(indata[31]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_31));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_31.PIN_TYPE = 6'b000001;
    defparam indata_pad_31.PULLUP = 1'b0;
    defparam indata_pad_31.NEG_TRIGGER = 1'b0;
    defparam indata_pad_31.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_30 (.PACKAGE_PIN(indata[30]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_30));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_30.PIN_TYPE = 6'b000001;
    defparam indata_pad_30.PULLUP = 1'b0;
    defparam indata_pad_30.NEG_TRIGGER = 1'b0;
    defparam indata_pad_30.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_29 (.PACKAGE_PIN(indata[29]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_29));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_29.PIN_TYPE = 6'b000001;
    defparam indata_pad_29.PULLUP = 1'b0;
    defparam indata_pad_29.NEG_TRIGGER = 1'b0;
    defparam indata_pad_29.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_28 (.PACKAGE_PIN(indata[28]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_28));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_28.PIN_TYPE = 6'b000001;
    defparam indata_pad_28.PULLUP = 1'b0;
    defparam indata_pad_28.NEG_TRIGGER = 1'b0;
    defparam indata_pad_28.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_27 (.PACKAGE_PIN(indata[27]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_27));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_27.PIN_TYPE = 6'b000001;
    defparam indata_pad_27.PULLUP = 1'b0;
    defparam indata_pad_27.NEG_TRIGGER = 1'b0;
    defparam indata_pad_27.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_26 (.PACKAGE_PIN(indata[26]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_26));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_26.PIN_TYPE = 6'b000001;
    defparam indata_pad_26.PULLUP = 1'b0;
    defparam indata_pad_26.NEG_TRIGGER = 1'b0;
    defparam indata_pad_26.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_25 (.PACKAGE_PIN(indata[25]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_25));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_25.PIN_TYPE = 6'b000001;
    defparam indata_pad_25.PULLUP = 1'b0;
    defparam indata_pad_25.NEG_TRIGGER = 1'b0;
    defparam indata_pad_25.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_24 (.PACKAGE_PIN(indata[24]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_24));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_24.PIN_TYPE = 6'b000001;
    defparam indata_pad_24.PULLUP = 1'b0;
    defparam indata_pad_24.NEG_TRIGGER = 1'b0;
    defparam indata_pad_24.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_23 (.PACKAGE_PIN(indata[23]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_23));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_23.PIN_TYPE = 6'b000001;
    defparam indata_pad_23.PULLUP = 1'b0;
    defparam indata_pad_23.NEG_TRIGGER = 1'b0;
    defparam indata_pad_23.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_22 (.PACKAGE_PIN(indata[22]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_22));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_22.PIN_TYPE = 6'b000001;
    defparam indata_pad_22.PULLUP = 1'b0;
    defparam indata_pad_22.NEG_TRIGGER = 1'b0;
    defparam indata_pad_22.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_21 (.PACKAGE_PIN(indata[21]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_21));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_21.PIN_TYPE = 6'b000001;
    defparam indata_pad_21.PULLUP = 1'b0;
    defparam indata_pad_21.NEG_TRIGGER = 1'b0;
    defparam indata_pad_21.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_20 (.PACKAGE_PIN(indata[20]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_20));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_20.PIN_TYPE = 6'b000001;
    defparam indata_pad_20.PULLUP = 1'b0;
    defparam indata_pad_20.NEG_TRIGGER = 1'b0;
    defparam indata_pad_20.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_19 (.PACKAGE_PIN(indata[19]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_19));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_19.PIN_TYPE = 6'b000001;
    defparam indata_pad_19.PULLUP = 1'b0;
    defparam indata_pad_19.NEG_TRIGGER = 1'b0;
    defparam indata_pad_19.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_18 (.PACKAGE_PIN(indata[18]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_18));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_18.PIN_TYPE = 6'b000001;
    defparam indata_pad_18.PULLUP = 1'b0;
    defparam indata_pad_18.NEG_TRIGGER = 1'b0;
    defparam indata_pad_18.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_17 (.PACKAGE_PIN(indata[17]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_17));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_17.PIN_TYPE = 6'b000001;
    defparam indata_pad_17.PULLUP = 1'b0;
    defparam indata_pad_17.NEG_TRIGGER = 1'b0;
    defparam indata_pad_17.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_16 (.PACKAGE_PIN(indata[16]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_16));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_16.PIN_TYPE = 6'b000001;
    defparam indata_pad_16.PULLUP = 1'b0;
    defparam indata_pad_16.NEG_TRIGGER = 1'b0;
    defparam indata_pad_16.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_15 (.PACKAGE_PIN(indata[15]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_15));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_15.PIN_TYPE = 6'b000001;
    defparam indata_pad_15.PULLUP = 1'b0;
    defparam indata_pad_15.NEG_TRIGGER = 1'b0;
    defparam indata_pad_15.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_14 (.PACKAGE_PIN(indata[14]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_14));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_14.PIN_TYPE = 6'b000001;
    defparam indata_pad_14.PULLUP = 1'b0;
    defparam indata_pad_14.NEG_TRIGGER = 1'b0;
    defparam indata_pad_14.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_13 (.PACKAGE_PIN(indata[13]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_13));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_13.PIN_TYPE = 6'b000001;
    defparam indata_pad_13.PULLUP = 1'b0;
    defparam indata_pad_13.NEG_TRIGGER = 1'b0;
    defparam indata_pad_13.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_12 (.PACKAGE_PIN(indata[12]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_12));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_12.PIN_TYPE = 6'b000001;
    defparam indata_pad_12.PULLUP = 1'b0;
    defparam indata_pad_12.NEG_TRIGGER = 1'b0;
    defparam indata_pad_12.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_11 (.PACKAGE_PIN(indata[11]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_11));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_11.PIN_TYPE = 6'b000001;
    defparam indata_pad_11.PULLUP = 1'b0;
    defparam indata_pad_11.NEG_TRIGGER = 1'b0;
    defparam indata_pad_11.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_10 (.PACKAGE_PIN(indata[10]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_10));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_10.PIN_TYPE = 6'b000001;
    defparam indata_pad_10.PULLUP = 1'b0;
    defparam indata_pad_10.NEG_TRIGGER = 1'b0;
    defparam indata_pad_10.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_9 (.PACKAGE_PIN(indata[9]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_9));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_9.PIN_TYPE = 6'b000001;
    defparam indata_pad_9.PULLUP = 1'b0;
    defparam indata_pad_9.NEG_TRIGGER = 1'b0;
    defparam indata_pad_9.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_8 (.PACKAGE_PIN(indata[8]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_8));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_8.PIN_TYPE = 6'b000001;
    defparam indata_pad_8.PULLUP = 1'b0;
    defparam indata_pad_8.NEG_TRIGGER = 1'b0;
    defparam indata_pad_8.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_7 (.PACKAGE_PIN(indata[7]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_7));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_7.PIN_TYPE = 6'b000001;
    defparam indata_pad_7.PULLUP = 1'b0;
    defparam indata_pad_7.NEG_TRIGGER = 1'b0;
    defparam indata_pad_7.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_6 (.PACKAGE_PIN(indata[6]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_6));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_6.PIN_TYPE = 6'b000001;
    defparam indata_pad_6.PULLUP = 1'b0;
    defparam indata_pad_6.NEG_TRIGGER = 1'b0;
    defparam indata_pad_6.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_5 (.PACKAGE_PIN(indata[5]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_5));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_5.PIN_TYPE = 6'b000001;
    defparam indata_pad_5.PULLUP = 1'b0;
    defparam indata_pad_5.NEG_TRIGGER = 1'b0;
    defparam indata_pad_5.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_4 (.PACKAGE_PIN(indata[4]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_4));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_4.PIN_TYPE = 6'b000001;
    defparam indata_pad_4.PULLUP = 1'b0;
    defparam indata_pad_4.NEG_TRIGGER = 1'b0;
    defparam indata_pad_4.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_3 (.PACKAGE_PIN(indata[3]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_3));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_3.PIN_TYPE = 6'b000001;
    defparam indata_pad_3.PULLUP = 1'b0;
    defparam indata_pad_3.NEG_TRIGGER = 1'b0;
    defparam indata_pad_3.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_2 (.PACKAGE_PIN(indata[2]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_2));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_2.PIN_TYPE = 6'b000001;
    defparam indata_pad_2.PULLUP = 1'b0;
    defparam indata_pad_2.NEG_TRIGGER = 1'b0;
    defparam indata_pad_2.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_1 (.PACKAGE_PIN(indata[1]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_1));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_1.PIN_TYPE = 6'b000001;
    defparam indata_pad_1.PULLUP = 1'b0;
    defparam indata_pad_1.NEG_TRIGGER = 1'b0;
    defparam indata_pad_1.IO_STANDARD = "SB_LVCMOS";
    SB_IO indata_pad_0 (.PACKAGE_PIN(indata[0]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(indata_c_0));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam indata_pad_0.PIN_TYPE = 6'b000001;
    defparam indata_pad_0.PULLUP = 1'b0;
    defparam indata_pad_0.NEG_TRIGGER = 1'b0;
    defparam indata_pad_0.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_31 (.PACKAGE_PIN(inExp[31]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_31));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_31.PIN_TYPE = 6'b000001;
    defparam inExp_pad_31.PULLUP = 1'b0;
    defparam inExp_pad_31.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_31.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_30 (.PACKAGE_PIN(inExp[30]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_30));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_30.PIN_TYPE = 6'b000001;
    defparam inExp_pad_30.PULLUP = 1'b0;
    defparam inExp_pad_30.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_30.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_29 (.PACKAGE_PIN(inExp[29]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_29));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_29.PIN_TYPE = 6'b000001;
    defparam inExp_pad_29.PULLUP = 1'b0;
    defparam inExp_pad_29.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_29.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_28 (.PACKAGE_PIN(inExp[28]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_28));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_28.PIN_TYPE = 6'b000001;
    defparam inExp_pad_28.PULLUP = 1'b0;
    defparam inExp_pad_28.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_28.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_27 (.PACKAGE_PIN(inExp[27]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_27));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_27.PIN_TYPE = 6'b000001;
    defparam inExp_pad_27.PULLUP = 1'b0;
    defparam inExp_pad_27.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_27.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_26 (.PACKAGE_PIN(inExp[26]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_26));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_26.PIN_TYPE = 6'b000001;
    defparam inExp_pad_26.PULLUP = 1'b0;
    defparam inExp_pad_26.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_26.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_25 (.PACKAGE_PIN(inExp[25]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_25));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_25.PIN_TYPE = 6'b000001;
    defparam inExp_pad_25.PULLUP = 1'b0;
    defparam inExp_pad_25.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_25.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_24 (.PACKAGE_PIN(inExp[24]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_24));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_24.PIN_TYPE = 6'b000001;
    defparam inExp_pad_24.PULLUP = 1'b0;
    defparam inExp_pad_24.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_24.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_23 (.PACKAGE_PIN(inExp[23]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_23));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_23.PIN_TYPE = 6'b000001;
    defparam inExp_pad_23.PULLUP = 1'b0;
    defparam inExp_pad_23.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_23.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_22 (.PACKAGE_PIN(inExp[22]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_22));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_22.PIN_TYPE = 6'b000001;
    defparam inExp_pad_22.PULLUP = 1'b0;
    defparam inExp_pad_22.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_22.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_21 (.PACKAGE_PIN(inExp[21]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_21));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_21.PIN_TYPE = 6'b000001;
    defparam inExp_pad_21.PULLUP = 1'b0;
    defparam inExp_pad_21.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_21.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_20 (.PACKAGE_PIN(inExp[20]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_20));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_20.PIN_TYPE = 6'b000001;
    defparam inExp_pad_20.PULLUP = 1'b0;
    defparam inExp_pad_20.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_20.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_19 (.PACKAGE_PIN(inExp[19]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_19));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_19.PIN_TYPE = 6'b000001;
    defparam inExp_pad_19.PULLUP = 1'b0;
    defparam inExp_pad_19.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_19.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_18 (.PACKAGE_PIN(inExp[18]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_18));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_18.PIN_TYPE = 6'b000001;
    defparam inExp_pad_18.PULLUP = 1'b0;
    defparam inExp_pad_18.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_18.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_17 (.PACKAGE_PIN(inExp[17]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_17));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_17.PIN_TYPE = 6'b000001;
    defparam inExp_pad_17.PULLUP = 1'b0;
    defparam inExp_pad_17.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_17.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_16 (.PACKAGE_PIN(inExp[16]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_16));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_16.PIN_TYPE = 6'b000001;
    defparam inExp_pad_16.PULLUP = 1'b0;
    defparam inExp_pad_16.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_16.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_15 (.PACKAGE_PIN(inExp[15]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_15));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_15.PIN_TYPE = 6'b000001;
    defparam inExp_pad_15.PULLUP = 1'b0;
    defparam inExp_pad_15.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_15.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_14 (.PACKAGE_PIN(inExp[14]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_14));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_14.PIN_TYPE = 6'b000001;
    defparam inExp_pad_14.PULLUP = 1'b0;
    defparam inExp_pad_14.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_14.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_13 (.PACKAGE_PIN(inExp[13]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_13));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_13.PIN_TYPE = 6'b000001;
    defparam inExp_pad_13.PULLUP = 1'b0;
    defparam inExp_pad_13.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_13.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_12 (.PACKAGE_PIN(inExp[12]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_12));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_12.PIN_TYPE = 6'b000001;
    defparam inExp_pad_12.PULLUP = 1'b0;
    defparam inExp_pad_12.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_12.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_11 (.PACKAGE_PIN(inExp[11]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_11));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_11.PIN_TYPE = 6'b000001;
    defparam inExp_pad_11.PULLUP = 1'b0;
    defparam inExp_pad_11.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_11.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_10 (.PACKAGE_PIN(inExp[10]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_10));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_10.PIN_TYPE = 6'b000001;
    defparam inExp_pad_10.PULLUP = 1'b0;
    defparam inExp_pad_10.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_10.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_9 (.PACKAGE_PIN(inExp[9]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_9));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_9.PIN_TYPE = 6'b000001;
    defparam inExp_pad_9.PULLUP = 1'b0;
    defparam inExp_pad_9.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_9.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_8 (.PACKAGE_PIN(inExp[8]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_8));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_8.PIN_TYPE = 6'b000001;
    defparam inExp_pad_8.PULLUP = 1'b0;
    defparam inExp_pad_8.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_8.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_7 (.PACKAGE_PIN(inExp[7]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_7));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_7.PIN_TYPE = 6'b000001;
    defparam inExp_pad_7.PULLUP = 1'b0;
    defparam inExp_pad_7.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_7.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_6 (.PACKAGE_PIN(inExp[6]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_6));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_6.PIN_TYPE = 6'b000001;
    defparam inExp_pad_6.PULLUP = 1'b0;
    defparam inExp_pad_6.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_6.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_5 (.PACKAGE_PIN(inExp[5]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_5));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_5.PIN_TYPE = 6'b000001;
    defparam inExp_pad_5.PULLUP = 1'b0;
    defparam inExp_pad_5.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_5.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_4 (.PACKAGE_PIN(inExp[4]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_4));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_4.PIN_TYPE = 6'b000001;
    defparam inExp_pad_4.PULLUP = 1'b0;
    defparam inExp_pad_4.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_4.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_3 (.PACKAGE_PIN(inExp[3]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_3));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_3.PIN_TYPE = 6'b000001;
    defparam inExp_pad_3.PULLUP = 1'b0;
    defparam inExp_pad_3.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_3.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_2 (.PACKAGE_PIN(inExp[2]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_2));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_2.PIN_TYPE = 6'b000001;
    defparam inExp_pad_2.PULLUP = 1'b0;
    defparam inExp_pad_2.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_2.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_1 (.PACKAGE_PIN(inExp[1]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_1));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_1.PIN_TYPE = 6'b000001;
    defparam inExp_pad_1.PULLUP = 1'b0;
    defparam inExp_pad_1.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_1.IO_STANDARD = "SB_LVCMOS";
    SB_IO inExp_pad_0 (.PACKAGE_PIN(inExp[0]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inExp_c_0));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inExp_pad_0.PIN_TYPE = 6'b000001;
    defparam inExp_pad_0.PULLUP = 1'b0;
    defparam inExp_pad_0.NEG_TRIGGER = 1'b0;
    defparam inExp_pad_0.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_31 (.PACKAGE_PIN(inMod[31]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_31));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_31.PIN_TYPE = 6'b000001;
    defparam inMod_pad_31.PULLUP = 1'b0;
    defparam inMod_pad_31.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_31.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_30 (.PACKAGE_PIN(inMod[30]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_30));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_30.PIN_TYPE = 6'b000001;
    defparam inMod_pad_30.PULLUP = 1'b0;
    defparam inMod_pad_30.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_30.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_29 (.PACKAGE_PIN(inMod[29]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_29));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_29.PIN_TYPE = 6'b000001;
    defparam inMod_pad_29.PULLUP = 1'b0;
    defparam inMod_pad_29.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_29.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_28 (.PACKAGE_PIN(inMod[28]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_28));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_28.PIN_TYPE = 6'b000001;
    defparam inMod_pad_28.PULLUP = 1'b0;
    defparam inMod_pad_28.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_28.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_27 (.PACKAGE_PIN(inMod[27]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_27));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_27.PIN_TYPE = 6'b000001;
    defparam inMod_pad_27.PULLUP = 1'b0;
    defparam inMod_pad_27.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_27.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_26 (.PACKAGE_PIN(inMod[26]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_26));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_26.PIN_TYPE = 6'b000001;
    defparam inMod_pad_26.PULLUP = 1'b0;
    defparam inMod_pad_26.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_26.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_25 (.PACKAGE_PIN(inMod[25]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_25));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_25.PIN_TYPE = 6'b000001;
    defparam inMod_pad_25.PULLUP = 1'b0;
    defparam inMod_pad_25.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_25.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_24 (.PACKAGE_PIN(inMod[24]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_24));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_24.PIN_TYPE = 6'b000001;
    defparam inMod_pad_24.PULLUP = 1'b0;
    defparam inMod_pad_24.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_24.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_23 (.PACKAGE_PIN(inMod[23]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_23));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_23.PIN_TYPE = 6'b000001;
    defparam inMod_pad_23.PULLUP = 1'b0;
    defparam inMod_pad_23.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_23.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_22 (.PACKAGE_PIN(inMod[22]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_22));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_22.PIN_TYPE = 6'b000001;
    defparam inMod_pad_22.PULLUP = 1'b0;
    defparam inMod_pad_22.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_22.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_21 (.PACKAGE_PIN(inMod[21]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_21));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_21.PIN_TYPE = 6'b000001;
    defparam inMod_pad_21.PULLUP = 1'b0;
    defparam inMod_pad_21.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_21.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_20 (.PACKAGE_PIN(inMod[20]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_20));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_20.PIN_TYPE = 6'b000001;
    defparam inMod_pad_20.PULLUP = 1'b0;
    defparam inMod_pad_20.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_20.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_19 (.PACKAGE_PIN(inMod[19]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_19));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_19.PIN_TYPE = 6'b000001;
    defparam inMod_pad_19.PULLUP = 1'b0;
    defparam inMod_pad_19.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_19.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_18 (.PACKAGE_PIN(inMod[18]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_18));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_18.PIN_TYPE = 6'b000001;
    defparam inMod_pad_18.PULLUP = 1'b0;
    defparam inMod_pad_18.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_18.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_17 (.PACKAGE_PIN(inMod[17]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_17));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_17.PIN_TYPE = 6'b000001;
    defparam inMod_pad_17.PULLUP = 1'b0;
    defparam inMod_pad_17.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_17.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_16 (.PACKAGE_PIN(inMod[16]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_16));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_16.PIN_TYPE = 6'b000001;
    defparam inMod_pad_16.PULLUP = 1'b0;
    defparam inMod_pad_16.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_16.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_15 (.PACKAGE_PIN(inMod[15]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_15));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_15.PIN_TYPE = 6'b000001;
    defparam inMod_pad_15.PULLUP = 1'b0;
    defparam inMod_pad_15.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_15.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_14 (.PACKAGE_PIN(inMod[14]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_14));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_14.PIN_TYPE = 6'b000001;
    defparam inMod_pad_14.PULLUP = 1'b0;
    defparam inMod_pad_14.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_14.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_13 (.PACKAGE_PIN(inMod[13]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_13));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_13.PIN_TYPE = 6'b000001;
    defparam inMod_pad_13.PULLUP = 1'b0;
    defparam inMod_pad_13.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_13.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_12 (.PACKAGE_PIN(inMod[12]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_12));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_12.PIN_TYPE = 6'b000001;
    defparam inMod_pad_12.PULLUP = 1'b0;
    defparam inMod_pad_12.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_12.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_11 (.PACKAGE_PIN(inMod[11]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_11));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_11.PIN_TYPE = 6'b000001;
    defparam inMod_pad_11.PULLUP = 1'b0;
    defparam inMod_pad_11.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_11.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_10 (.PACKAGE_PIN(inMod[10]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_10));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_10.PIN_TYPE = 6'b000001;
    defparam inMod_pad_10.PULLUP = 1'b0;
    defparam inMod_pad_10.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_10.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_9 (.PACKAGE_PIN(inMod[9]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_9));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_9.PIN_TYPE = 6'b000001;
    defparam inMod_pad_9.PULLUP = 1'b0;
    defparam inMod_pad_9.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_9.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_8 (.PACKAGE_PIN(inMod[8]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_8));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_8.PIN_TYPE = 6'b000001;
    defparam inMod_pad_8.PULLUP = 1'b0;
    defparam inMod_pad_8.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_8.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_7 (.PACKAGE_PIN(inMod[7]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_7));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_7.PIN_TYPE = 6'b000001;
    defparam inMod_pad_7.PULLUP = 1'b0;
    defparam inMod_pad_7.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_7.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_6 (.PACKAGE_PIN(inMod[6]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_6));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_6.PIN_TYPE = 6'b000001;
    defparam inMod_pad_6.PULLUP = 1'b0;
    defparam inMod_pad_6.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_6.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_5 (.PACKAGE_PIN(inMod[5]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_5));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_5.PIN_TYPE = 6'b000001;
    defparam inMod_pad_5.PULLUP = 1'b0;
    defparam inMod_pad_5.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_5.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_4 (.PACKAGE_PIN(inMod[4]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_4));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_4.PIN_TYPE = 6'b000001;
    defparam inMod_pad_4.PULLUP = 1'b0;
    defparam inMod_pad_4.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_4.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_3 (.PACKAGE_PIN(inMod[3]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_3));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_3.PIN_TYPE = 6'b000001;
    defparam inMod_pad_3.PULLUP = 1'b0;
    defparam inMod_pad_3.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_3.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_2 (.PACKAGE_PIN(inMod[2]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_2));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_2.PIN_TYPE = 6'b000001;
    defparam inMod_pad_2.PULLUP = 1'b0;
    defparam inMod_pad_2.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_2.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_1 (.PACKAGE_PIN(inMod[1]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_1));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_1.PIN_TYPE = 6'b000001;
    defparam inMod_pad_1.PULLUP = 1'b0;
    defparam inMod_pad_1.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_1.IO_STANDARD = "SB_LVCMOS";
    SB_IO inMod_pad_0 (.PACKAGE_PIN(inMod[0]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(inMod_c_0));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam inMod_pad_0.PIN_TYPE = 6'b000001;
    defparam inMod_pad_0.PULLUP = 1'b0;
    defparam inMod_pad_0.NEG_TRIGGER = 1'b0;
    defparam inMod_pad_0.IO_STANDARD = "SB_LVCMOS";
    SB_GB_IO clk_pad (.PACKAGE_PIN(clk), .OUTPUT_ENABLE(VCC_net), .GLOBAL_BUFFER_OUTPUT(clk_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(80[5:8])
    defparam clk_pad.PIN_TYPE = 6'b000001;
    defparam clk_pad.PULLUP = 1'b0;
    defparam clk_pad.NEG_TRIGGER = 1'b0;
    defparam clk_pad.IO_STANDARD = "SB_LVCMOS";
    SB_IO ds_pad (.PACKAGE_PIN(ds), .OUTPUT_ENABLE(VCC_net), .D_IN_0(ds_c));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam ds_pad.PIN_TYPE = 6'b000001;
    defparam ds_pad.PULLUP = 1'b0;
    defparam ds_pad.NEG_TRIGGER = 1'b0;
    defparam ds_pad.IO_STANDARD = "SB_LVCMOS";
    SB_IO reset_pad (.PACKAGE_PIN(reset), .OUTPUT_ENABLE(VCC_net), .D_IN_0(reset_c));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam reset_pad.PIN_TYPE = 6'b000001;
    defparam reset_pad.PULLUP = 1'b0;
    defparam reset_pad.NEG_TRIGGER = 1'b0;
    defparam reset_pad.IO_STANDARD = "SB_LVCMOS";
    SB_DFFER root_i5 (.Q(root[5]), .C(clk_c), .E(n3541), .D(root_31__N_65[5]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_IO cypher_pad_25 (.PACKAGE_PIN(cypher[25]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(cypher_c_25)) /* synthesis IO_FF_OUT=TRUE */ ;   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam cypher_pad_25.PIN_TYPE = 6'b011001;
    defparam cypher_pad_25.PULLUP = 1'b0;
    defparam cypher_pad_25.NEG_TRIGGER = 1'b0;
    defparam cypher_pad_25.IO_STANDARD = "SB_LVCMOS";
    SB_DFFER root_i6 (.Q(root[6]), .C(clk_c), .E(n3541), .D(root_31__N_65[6]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i7 (.Q(root[7]), .C(clk_c), .E(n3541), .D(root_31__N_65[7]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i8 (.Q(root[8]), .C(clk_c), .E(n3541), .D(root_31__N_65[8]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i9 (.Q(root[9]), .C(clk_c), .E(n3541), .D(root_31__N_65[9]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i10 (.Q(root[10]), .C(clk_c), .E(n3541), .D(root_31__N_65[10]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i11 (.Q(root[11]), .C(clk_c), .E(n3541), .D(root_31__N_65[11]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i12 (.Q(root[12]), .C(clk_c), .E(n3541), .D(root_31__N_65[12]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i13 (.Q(root[13]), .C(clk_c), .E(n3541), .D(root_31__N_65[13]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i14 (.Q(root[14]), .C(clk_c), .E(n3541), .D(root_31__N_65[14]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i15 (.Q(root[15]), .C(clk_c), .E(n3541), .D(root_31__N_65[15]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i16 (.Q(root[16]), .C(clk_c), .E(n3541), .D(root_31__N_65[16]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i17 (.Q(root[17]), .C(clk_c), .E(n3541), .D(root_31__N_65[17]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i18 (.Q(root[18]), .C(clk_c), .E(n3541), .D(root_31__N_65[18]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i19 (.Q(root[19]), .C(clk_c), .E(n3541), .D(root_31__N_65[19]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i20 (.Q(root[20]), .C(clk_c), .E(n3541), .D(root_31__N_65[20]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i21 (.Q(root[21]), .C(clk_c), .E(n3541), .D(root_31__N_65[21]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i22 (.Q(root[22]), .C(clk_c), .E(n3541), .D(root_31__N_65[22]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i23 (.Q(root[23]), .C(clk_c), .E(n3541), .D(root_31__N_65[23]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i24 (.Q(root[24]), .C(clk_c), .E(n3541), .D(root_31__N_65[24]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i25 (.Q(root[25]), .C(clk_c), .E(n3541), .D(root_31__N_65[25]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i26 (.Q(root[26]), .C(clk_c), .E(n3541), .D(root_31__N_65[26]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i27 (.Q(root[27]), .C(clk_c), .E(n3541), .D(root_31__N_65[27]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i28 (.Q(root[28]), .C(clk_c), .E(n3541), .D(root_31__N_65[28]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i29 (.Q(root[29]), .C(clk_c), .E(n3541), .D(root_31__N_65[29]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i30 (.Q(root[30]), .C(clk_c), .E(n3541), .D(root_31__N_65[30]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER root_i31 (.Q(root[31]), .C(clk_c), .E(n3541), .D(root_31__N_65[31]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_DFFER count__i2 (.Q(count[1]), .C(clk_c), .E(n2001), .D(n2829), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i3 (.Q(count[2]), .C(clk_c), .E(n2001), .D(n2828), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i4 (.Q(count[3]), .C(clk_c), .E(n2001), .D(n2827), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i5 (.Q(count[4]), .C(clk_c), .E(n2001), .D(n2826), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i6 (.Q(count[5]), .C(clk_c), .E(n2001), .D(n2825), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i7 (.Q(count[6]), .C(clk_c), .E(n2001), .D(n2824), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i8 (.Q(count[7]), .C(clk_c), .E(n2001), .D(n2823), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i9 (.Q(count[8]), .C(clk_c), .E(n2001), .D(n2822), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i10 (.Q(count[9]), .C(clk_c), .E(n2001), .D(n2821), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i11 (.Q(count[10]), .C(clk_c), .E(n2001), .D(n2820), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i12 (.Q(count[11]), .C(clk_c), .E(n2001), .D(n2819), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i13 (.Q(count[12]), .C(clk_c), .E(n2001), .D(n2818), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i14 (.Q(count[13]), .C(clk_c), .E(n2001), .D(n2817), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i15 (.Q(count[14]), .C(clk_c), .E(n2001), .D(n2816), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i16 (.Q(count[15]), .C(clk_c), .E(n2001), .D(n2815), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i17 (.Q(count[16]), .C(clk_c), .E(n2001), .D(n2814), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i18 (.Q(count[17]), .C(clk_c), .E(n2001), .D(n2813), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i19 (.Q(count[18]), .C(clk_c), .E(n2001), .D(n2812), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i20 (.Q(count[19]), .C(clk_c), .E(n2001), .D(n2811), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i21 (.Q(count[20]), .C(clk_c), .E(n2001), .D(n2810), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i22 (.Q(count[21]), .C(clk_c), .E(n2001), .D(n2809), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i23 (.Q(count[22]), .C(clk_c), .E(n2001), .D(n2808), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i24 (.Q(count[23]), .C(clk_c), .E(n2001), .D(n2807), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i25 (.Q(count[24]), .C(clk_c), .E(n2001), .D(n2806), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i26 (.Q(count[25]), .C(clk_c), .E(n2001), .D(n2805), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i27 (.Q(count[26]), .C(clk_c), .E(n2001), .D(n2804), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i28 (.Q(count[27]), .C(clk_c), .E(n2001), .D(n2803), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i29 (.Q(count[28]), .C(clk_c), .E(n2001), .D(n2802), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i30 (.Q(count[29]), .C(clk_c), .E(n2001), .D(n2801), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFER count__i31 (.Q(count[30]), .C(clk_c), .E(n2001), .D(n2800), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_LUT4 i1688_4_lut_4_lut (.I0(n2315), .I1(n2193), .I2(prodreg_adj_922[0]), 
            .I3(square[0]), .O(n4111));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1688_4_lut_4_lut.LUT_INIT = 16'h7250;
    SB_LUT4 i2460_3_lut_4_lut (.I0(mpreg[31]), .I1(sqrin[30]), .I2(multrdy), 
            .I3(multgo), .O(n2088));
    defparam i2460_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_DFFER tempin_i1 (.Q(tempin[1]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[1]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i2 (.Q(tempin[2]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[2]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i3 (.Q(tempin[3]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[3]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i4 (.Q(tempin[4]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[4]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i5 (.Q(tempin[5]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[5]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i6 (.Q(tempin[6]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[6]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i7 (.Q(tempin[7]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[7]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i8 (.Q(tempin[8]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[8]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i9 (.Q(tempin[9]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[9]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i10 (.Q(tempin[10]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[10]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i11 (.Q(tempin[11]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[11]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i12 (.Q(tempin[12]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[12]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i13 (.Q(tempin[13]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[13]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i14 (.Q(tempin[14]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[14]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i15 (.Q(tempin[15]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[15]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i16 (.Q(tempin[16]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[16]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i17 (.Q(tempin[17]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[17]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i18 (.Q(tempin[18]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[18]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i19 (.Q(tempin[19]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[19]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i20 (.Q(tempin[20]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[20]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i21 (.Q(tempin[21]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[21]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i22 (.Q(tempin[22]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[22]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i23 (.Q(tempin[23]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[23]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i24 (.Q(tempin[24]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[24]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i25 (.Q(tempin[25]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[25]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i26 (.Q(tempin[26]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[26]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i27 (.Q(tempin[27]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[27]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i28 (.Q(tempin[28]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[28]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i29 (.Q(tempin[29]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[29]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i30 (.Q(tempin[30]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[30]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER tempin_i31 (.Q(tempin[31]), .C(clk_c), .E(n3541), .D(tempin_31__N_129[31]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i1 (.Q(sqrin[1]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[1]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i2 (.Q(sqrin[2]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[2]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i3 (.Q(sqrin[3]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[3]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i4 (.Q(sqrin[4]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[4]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i5 (.Q(sqrin[5]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[5]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i6 (.Q(sqrin[6]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[6]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i7 (.Q(sqrin[7]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[7]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i8 (.Q(sqrin[8]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[8]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i9 (.Q(sqrin[9]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[9]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i10 (.Q(sqrin[10]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[10]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i11 (.Q(sqrin[11]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[11]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i12 (.Q(sqrin[12]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[12]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i13 (.Q(sqrin[13]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[13]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i14 (.Q(sqrin[14]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[14]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i15 (.Q(sqrin[15]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[15]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i16 (.Q(sqrin[16]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[16]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i17 (.Q(sqrin[17]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[17]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i18 (.Q(sqrin[18]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[18]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i19 (.Q(sqrin[19]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[19]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i20 (.Q(sqrin[20]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[20]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i21 (.Q(sqrin[21]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[21]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i22 (.Q(sqrin[22]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[22]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i23 (.Q(sqrin[23]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[23]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i24 (.Q(sqrin[24]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[24]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i25 (.Q(sqrin[25]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[25]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i26 (.Q(sqrin[26]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[26]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i27 (.Q(sqrin[27]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[27]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i28 (.Q(sqrin[28]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[28]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i29 (.Q(sqrin[29]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[29]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i30 (.Q(sqrin[30]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[30]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_DFFER sqrin_i31 (.Q(sqrin[31]), .C(clk_c), .E(n3573), .D(sqrin_31__N_97[31]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(208[3] 244[10])
    SB_LUT4 square_31__I_0_i11_3_lut (.I0(square[10]), .I1(indata_c_10), 
            .I2(ready_c), .I3(GND_net), .O(root_31__N_65[10]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(190[4] 199[11])
    defparam square_31__I_0_i11_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 square_31__I_0_i10_3_lut (.I0(square[9]), .I1(indata_c_9), .I2(ready_c), 
            .I3(GND_net), .O(root_31__N_65[9]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(190[4] 199[11])
    defparam square_31__I_0_i10_3_lut.LUT_INIT = 16'hcaca;
    SB_DFFE cypher_i0_i1 (.Q(cypher_c_0), .C(clk_c), .E(n2009), .D(tempout[0]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i2 (.Q(cypher_c_1), .C(clk_c), .E(n2009), .D(tempout[1]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i3 (.Q(cypher_c_2), .C(clk_c), .E(n2009), .D(tempout[2]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i4 (.Q(cypher_c_3), .C(clk_c), .E(n2009), .D(tempout[3]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i5 (.Q(cypher_c_4), .C(clk_c), .E(n2009), .D(tempout[4]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i6 (.Q(cypher_c_5), .C(clk_c), .E(n2009), .D(tempout[5]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i7 (.Q(cypher_c_6), .C(clk_c), .E(n2009), .D(tempout[6]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i8 (.Q(cypher_c_7), .C(clk_c), .E(n2009), .D(tempout[7]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i9 (.Q(cypher_c_8), .C(clk_c), .E(n2009), .D(tempout[8]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i10 (.Q(cypher_c_9), .C(clk_c), .E(n2009), .D(tempout[9]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i11 (.Q(cypher_c_10), .C(clk_c), .E(n2009), .D(tempout[10]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i12 (.Q(cypher_c_11), .C(clk_c), .E(n2009), .D(tempout[11]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i13 (.Q(cypher_c_12), .C(clk_c), .E(n2009), .D(tempout[12]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i14 (.Q(cypher_c_13), .C(clk_c), .E(n2009), .D(tempout[13]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i15 (.Q(cypher_c_14), .C(clk_c), .E(n2009), .D(tempout[14]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i16 (.Q(cypher_c_15), .C(clk_c), .E(n2009), .D(tempout[15]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i17 (.Q(cypher_c_16), .C(clk_c), .E(n2009), .D(tempout[16]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i18 (.Q(cypher_c_17), .C(clk_c), .E(n2009), .D(tempout[17]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i19 (.Q(cypher_c_18), .C(clk_c), .E(n2009), .D(tempout[18]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i20 (.Q(cypher_c_19), .C(clk_c), .E(n2009), .D(tempout[19]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i21 (.Q(cypher_c_20), .C(clk_c), .E(n2009), .D(tempout[20]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i22 (.Q(cypher_c_21), .C(clk_c), .E(n2009), .D(tempout[21]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i23 (.Q(cypher_c_22), .C(clk_c), .E(n2009), .D(tempout[22]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i24 (.Q(cypher_c_23), .C(clk_c), .E(n2009), .D(tempout[23]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i25 (.Q(cypher_c_24), .C(clk_c), .E(n2009), .D(tempout[24]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i26 (.Q(cypher_c_25), .C(clk_c), .E(n2009), .D(tempout[25]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i27 (.Q(cypher_c_26), .C(clk_c), .E(n2009), .D(tempout[26]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i28 (.Q(cypher_c_27), .C(clk_c), .E(n2009), .D(tempout[27]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i29 (.Q(cypher_c_28), .C(clk_c), .E(n2009), .D(tempout[28]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i30 (.Q(cypher_c_29), .C(clk_c), .E(n2009), .D(tempout[29]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_DFFE cypher_i0_i31 (.Q(cypher_c_30), .C(clk_c), .E(n2009), .D(tempout[30]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    SB_LUT4 square_31__I_0_i9_3_lut (.I0(square[8]), .I1(indata_c_8), .I2(ready_c), 
            .I3(GND_net), .O(root_31__N_65[8]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(190[4] 199[11])
    defparam square_31__I_0_i9_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 square_31__I_0_i8_3_lut (.I0(square[7]), .I1(indata_c_7), .I2(ready_c), 
            .I3(GND_net), .O(root_31__N_65[7]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(190[4] 199[11])
    defparam square_31__I_0_i8_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 square_31__I_0_i7_3_lut (.I0(square[6]), .I1(indata_c_6), .I2(ready_c), 
            .I3(GND_net), .O(root_31__N_65[6]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(190[4] 199[11])
    defparam square_31__I_0_i7_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 square_31__I_0_i6_3_lut (.I0(square[5]), .I1(indata_c_5), .I2(ready_c), 
            .I3(GND_net), .O(root_31__N_65[5]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(190[4] 199[11])
    defparam square_31__I_0_i6_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 square_31__I_0_i5_3_lut (.I0(square[4]), .I1(indata_c_4), .I2(ready_c), 
            .I3(GND_net), .O(root_31__N_65[4]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(190[4] 199[11])
    defparam square_31__I_0_i5_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 square_31__I_0_i4_3_lut (.I0(square[3]), .I1(indata_c_3), .I2(ready_c), 
            .I3(GND_net), .O(root_31__N_65[3]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(190[4] 199[11])
    defparam square_31__I_0_i4_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2534_2_lut_4_lut (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(square[6]), .O(sqrin_31__N_97[6]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i2534_2_lut_4_lut.LUT_INIT = 16'h3a00;
    SB_LUT4 tempout_31__I_0_i32_4_lut (.I0(tempout[31]), .I1(indata_c_31), 
            .I2(ready_c), .I3(inExp_c_0), .O(tempin_31__N_129[31]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam tempout_31__I_0_i32_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 tempout_31__I_0_i31_4_lut (.I0(tempout[30]), .I1(indata_c_30), 
            .I2(ready_c), .I3(inExp_c_0), .O(tempin_31__N_129[30]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam tempout_31__I_0_i31_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i2454_3_lut (.I0(mcreg1[0]), .I1(mcreg[0]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(n4858));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(89[15:21])
    defparam i2454_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2455_3_lut (.I0(n4858), .I1(tempin[1]), .I2(n2057), .I3(GND_net), 
            .O(n2097));
    defparam i2455_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1475_4_lut (.I0(n2912), .I1(prodreg[30]), .I2(tempout[30]), 
            .I3(n2179), .O(n3898));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1475_4_lut.LUT_INIT = 16'h5044;
    SB_DFFE cypher_i0_i32 (.Q(cypher_c_31), .C(clk_c), .E(n2009), .D(tempout[31]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(157[3] 178[10])
    GND i1 (.Y(GND_net));
    SB_DFFER root_i2 (.Q(root[2]), .C(clk_c), .E(n3541), .D(root_31__N_65[2]), 
            .R(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(186[3] 200[10])
    SB_LUT4 i1_4_lut (.I0(multgo), .I1(n5812), .I2(ds_c), .I3(ready_c), 
            .O(n5730));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(252[3] 270[10])
    defparam i1_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 square_31__I_0_i2_3_lut (.I0(square[1]), .I1(indata_c_1), .I2(ready_c), 
            .I3(GND_net), .O(root_31__N_65[1]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(190[4] 199[11])
    defparam square_31__I_0_i2_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i3222_2_lut (.I0(ready_c), .I1(ds_c), .I2(GND_net), .I3(GND_net), 
            .O(n3573));
    defparam i3222_2_lut.LUT_INIT = 16'hdddd;
    SB_LUT4 i2535_2_lut_4_lut (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(square[5]), .O(sqrin_31__N_97[5]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i2535_2_lut_4_lut.LUT_INIT = 16'h3a00;
    SB_LUT4 tempout_31__I_0_i1_4_lut (.I0(tempout[0]), .I1(inExp_c_0), .I2(ready_c), 
            .I3(indata_c_0), .O(tempin_31__N_129[0]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam tempout_31__I_0_i1_4_lut.LUT_INIT = 16'hfa3a;
    SB_LUT4 i122_2_lut (.I0(ready_c), .I1(ds_c), .I2(GND_net), .I3(GND_net), 
            .O(n1966));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam i122_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i23_4_lut (.I0(count[26]), .I1(count[13]), .I2(count[29]), 
            .I3(count[4]), .O(n54));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(261[10:20])
    defparam i23_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 square_31__I_0_i32_3_lut (.I0(square[31]), .I1(indata_c_31), 
            .I2(ready_c), .I3(GND_net), .O(root_31__N_65[31]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(190[4] 199[11])
    defparam square_31__I_0_i32_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i21_4_lut (.I0(count[18]), .I1(count[24]), .I2(count[20]), 
            .I3(count[5]), .O(n52));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(261[10:20])
    defparam i21_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i22_4_lut (.I0(count[8]), .I1(count[23]), .I2(count[11]), 
            .I3(count[22]), .O(n53));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(261[10:20])
    defparam i22_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i20_4_lut (.I0(count[15]), .I1(count[6]), .I2(count[28]), 
            .I3(count[10]), .O(n51));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(261[10:20])
    defparam i20_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i17_4_lut (.I0(count[19]), .I1(count[0]), .I2(count[7]), .I3(count[12]), 
            .O(n48));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(261[10:20])
    defparam i17_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i19_4_lut (.I0(count[16]), .I1(count[1]), .I2(count[17]), 
            .I3(count[3]), .O(n50));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(261[10:20])
    defparam i19_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i18_4_lut (.I0(count[21]), .I1(count[27]), .I2(count[25]), 
            .I3(count[9]), .O(n49));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(261[10:20])
    defparam i18_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 square_31__I_0_i31_3_lut (.I0(square[30]), .I1(indata_c_30), 
            .I2(ready_c), .I3(GND_net), .O(root_31__N_65[30]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(190[4] 199[11])
    defparam square_31__I_0_i31_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i29_4_lut (.I0(n51), .I1(n53), .I2(n52), .I3(n54), .O(n60));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(261[10:20])
    defparam i29_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i24_4_lut (.I0(count[14]), .I1(n48), .I2(count[30]), .I3(count[2]), 
            .O(n55));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(261[10:20])
    defparam i24_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 tempout_31__I_0_i11_4_lut (.I0(tempout[10]), .I1(indata_c_10), 
            .I2(ready_c), .I3(inExp_c_0), .O(tempin_31__N_129[10]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam tempout_31__I_0_i11_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i30_4_lut (.I0(n55), .I1(n60), .I2(n49), .I3(n50), .O(n61));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(261[10:20])
    defparam i30_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 tempout_31__I_0_i10_4_lut (.I0(tempout[9]), .I1(indata_c_9), 
            .I2(ready_c), .I3(inExp_c_0), .O(tempin_31__N_129[9]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam tempout_31__I_0_i10_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i311_4_lut (.I0(ready_N_452), .I1(ds_c), .I2(ready_c), .I3(n61), 
            .O(n2001));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam i311_4_lut.LUT_INIT = 16'hcac0;
    SB_LUT4 tempout_31__I_0_i9_4_lut (.I0(tempout[8]), .I1(indata_c_8), 
            .I2(ready_c), .I3(inExp_c_0), .O(tempin_31__N_129[8]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam tempout_31__I_0_i9_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 tempout_31__I_0_i8_4_lut (.I0(tempout[7]), .I1(indata_c_7), 
            .I2(ready_c), .I3(inExp_c_0), .O(tempin_31__N_129[7]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam tempout_31__I_0_i8_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i2536_2_lut_4_lut (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(square[4]), .O(sqrin_31__N_97[4]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i2536_2_lut_4_lut.LUT_INIT = 16'h3a00;
    SB_LUT4 tempout_31__I_0_i7_4_lut (.I0(tempout[6]), .I1(indata_c_6), 
            .I2(ready_c), .I3(inExp_c_0), .O(tempin_31__N_129[6]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam tempout_31__I_0_i7_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 tempout_31__I_0_i6_4_lut (.I0(tempout[5]), .I1(indata_c_5), 
            .I2(ready_c), .I3(inExp_c_0), .O(tempin_31__N_129[5]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam tempout_31__I_0_i6_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i2537_2_lut_4_lut (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(square[3]), .O(sqrin_31__N_97[3]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i2537_2_lut_4_lut.LUT_INIT = 16'h3a00;
    SB_LUT4 tempout_31__I_0_i5_4_lut (.I0(tempout[4]), .I1(indata_c_4), 
            .I2(ready_c), .I3(inExp_c_0), .O(tempin_31__N_129[4]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam tempout_31__I_0_i5_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 tempout_31__I_0_i4_4_lut (.I0(tempout[3]), .I1(indata_c_3), 
            .I2(ready_c), .I3(inExp_c_0), .O(tempin_31__N_129[3]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam tempout_31__I_0_i4_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i2538_2_lut_4_lut (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(square[2]), .O(sqrin_31__N_97[2]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i2538_2_lut_4_lut.LUT_INIT = 16'h3a00;
    SB_LUT4 i2539_2_lut_4_lut (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(square[1]), .O(sqrin_31__N_97[1]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i2539_2_lut_4_lut.LUT_INIT = 16'h3a00;
    SB_LUT4 tempout_31__I_0_i3_4_lut (.I0(tempout[2]), .I1(indata_c_2), 
            .I2(ready_c), .I3(inExp_c_0), .O(tempin_31__N_129[2]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam tempout_31__I_0_i3_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i1_2_lut (.I0(ds_c), .I1(ready_c), .I2(GND_net), .I3(GND_net), 
            .O(n3541));
    defparam i1_2_lut.LUT_INIT = 16'hbbbb;
    SB_LUT4 square_31__I_0_i1_3_lut (.I0(square[0]), .I1(indata_c_0), .I2(ready_c), 
            .I3(GND_net), .O(root_31__N_65[0]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(190[4] 199[11])
    defparam square_31__I_0_i1_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1472_4_lut (.I0(n2912), .I1(prodreg[31]), .I2(tempout[31]), 
            .I3(n2179), .O(n3895));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1472_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i2459_4_lut (.I0(mpreg[31]), .I1(sqrin[31]), .I2(n2179), .I3(n2057), 
            .O(n3892));
    defparam i2459_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 mux_288_i1_3_lut_4_lut (.I0(count[1]), .I1(inExp_c_1), .I2(ready_c), 
            .I3(ds_c), .O(n2830));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i1_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i2_3_lut_4_lut (.I0(count[2]), .I1(inExp_c_2), .I2(ready_c), 
            .I3(ds_c), .O(n2829));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i2_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i3_3_lut_4_lut (.I0(count[3]), .I1(inExp_c_3), .I2(ready_c), 
            .I3(ds_c), .O(n2828));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i3_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i4_3_lut_4_lut (.I0(count[4]), .I1(inExp_c_4), .I2(ready_c), 
            .I3(ds_c), .O(n2827));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i4_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i5_3_lut_4_lut (.I0(count[5]), .I1(inExp_c_5), .I2(ready_c), 
            .I3(ds_c), .O(n2826));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i5_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i6_3_lut_4_lut (.I0(count[6]), .I1(inExp_c_6), .I2(ready_c), 
            .I3(ds_c), .O(n2825));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i6_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i7_3_lut_4_lut (.I0(count[7]), .I1(inExp_c_7), .I2(ready_c), 
            .I3(ds_c), .O(n2824));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i7_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i8_3_lut_4_lut (.I0(count[8]), .I1(inExp_c_8), .I2(ready_c), 
            .I3(ds_c), .O(n2823));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i8_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i9_3_lut_4_lut (.I0(count[9]), .I1(inExp_c_9), .I2(ready_c), 
            .I3(ds_c), .O(n2822));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i9_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i10_3_lut_4_lut (.I0(count[10]), .I1(inExp_c_10), .I2(ready_c), 
            .I3(ds_c), .O(n2821));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i10_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i11_3_lut_4_lut (.I0(count[11]), .I1(inExp_c_11), .I2(ready_c), 
            .I3(ds_c), .O(n2820));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i11_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i12_3_lut_4_lut (.I0(count[12]), .I1(inExp_c_12), .I2(ready_c), 
            .I3(ds_c), .O(n2819));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i12_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i13_3_lut_4_lut (.I0(count[13]), .I1(inExp_c_13), .I2(ready_c), 
            .I3(ds_c), .O(n2818));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i13_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i14_3_lut_4_lut (.I0(count[14]), .I1(inExp_c_14), .I2(ready_c), 
            .I3(ds_c), .O(n2817));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i14_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i15_3_lut_4_lut (.I0(count[15]), .I1(inExp_c_15), .I2(ready_c), 
            .I3(ds_c), .O(n2816));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i15_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i16_3_lut_4_lut (.I0(count[16]), .I1(inExp_c_16), .I2(ready_c), 
            .I3(ds_c), .O(n2815));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i16_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i17_3_lut_4_lut (.I0(count[17]), .I1(inExp_c_17), .I2(ready_c), 
            .I3(ds_c), .O(n2814));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i17_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i18_3_lut_4_lut (.I0(count[18]), .I1(inExp_c_18), .I2(ready_c), 
            .I3(ds_c), .O(n2813));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i18_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i19_3_lut_4_lut (.I0(count[19]), .I1(inExp_c_19), .I2(ready_c), 
            .I3(ds_c), .O(n2812));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i19_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i20_3_lut_4_lut (.I0(count[20]), .I1(inExp_c_20), .I2(ready_c), 
            .I3(ds_c), .O(n2811));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i20_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i21_3_lut_4_lut (.I0(count[21]), .I1(inExp_c_21), .I2(ready_c), 
            .I3(ds_c), .O(n2810));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i21_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i22_3_lut_4_lut (.I0(count[22]), .I1(inExp_c_22), .I2(ready_c), 
            .I3(ds_c), .O(n2809));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i22_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i23_3_lut_4_lut (.I0(count[23]), .I1(inExp_c_23), .I2(ready_c), 
            .I3(ds_c), .O(n2808));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i23_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i24_3_lut_4_lut (.I0(count[24]), .I1(inExp_c_24), .I2(ready_c), 
            .I3(ds_c), .O(n2807));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i24_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i25_3_lut_4_lut (.I0(count[25]), .I1(inExp_c_25), .I2(ready_c), 
            .I3(ds_c), .O(n2806));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i25_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i26_3_lut_4_lut (.I0(count[26]), .I1(inExp_c_26), .I2(ready_c), 
            .I3(ds_c), .O(n2805));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i26_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i27_3_lut_4_lut (.I0(count[27]), .I1(inExp_c_27), .I2(ready_c), 
            .I3(ds_c), .O(n2804));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i27_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i28_3_lut_4_lut (.I0(count[28]), .I1(inExp_c_28), .I2(ready_c), 
            .I3(ds_c), .O(n2803));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i28_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i29_3_lut_4_lut (.I0(count[29]), .I1(inExp_c_29), .I2(ready_c), 
            .I3(ds_c), .O(n2802));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i29_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_288_i30_3_lut_4_lut (.I0(count[30]), .I1(inExp_c_30), .I2(ready_c), 
            .I3(ds_c), .O(n2801));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam mux_288_i30_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i2573_2_lut_3_lut (.I0(inExp_c_31), .I1(ready_c), .I2(ds_c), 
            .I3(GND_net), .O(n2800));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(161[4] 177[11])
    defparam i2573_2_lut_3_lut.LUT_INIT = 16'h8080;
    SB_LUT4 i1_2_lut_4_lut (.I0(count[0]), .I1(ds_c), .I2(ready_c), .I3(n4466), 
            .O(sqrin_31__N_97[16]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut.LUT_INIT = 16'h3a00;
    SB_LUT4 i1_2_lut_4_lut_adj_4 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4497), .O(sqrin_31__N_97[17]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_4.LUT_INIT = 16'h3a00;
    SB_LUT4 i2457_4_lut (.I0(mcreg[0]), .I1(tempin[0]), .I2(n2179), .I3(n2057), 
            .O(n4107));
    defparam i2457_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i1_2_lut_4_lut_adj_5 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4528), .O(sqrin_31__N_97[18]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_5.LUT_INIT = 16'h3a00;
    SB_LUT4 i1680_4_lut (.I0(n2915), .I1(prodreg_adj_922[31]), .I2(square[31]), 
            .I3(n2315), .O(n4103));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1680_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1677_4_lut (.I0(n2915), .I1(prodreg_adj_922[30]), .I2(square[30]), 
            .I3(n2315), .O(n4100));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1677_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1_2_lut_4_lut_adj_6 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4559), .O(sqrin_31__N_97[19]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_6.LUT_INIT = 16'h3a00;
    SB_LUT4 i1673_4_lut (.I0(n2915), .I1(prodreg_adj_922[29]), .I2(n4280), 
            .I3(n2315), .O(n4096));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1673_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1670_4_lut (.I0(n2915), .I1(prodreg_adj_922[28]), .I2(n4838), 
            .I3(n2315), .O(n4093));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1670_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1667_4_lut (.I0(n2915), .I1(prodreg_adj_922[27]), .I2(n4807), 
            .I3(n2315), .O(n4090));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1667_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1_2_lut_4_lut_adj_7 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4590), .O(sqrin_31__N_97[20]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_7.LUT_INIT = 16'h3a00;
    SB_LUT4 i1663_4_lut (.I0(n2915), .I1(prodreg_adj_922[26]), .I2(n4776), 
            .I3(n2315), .O(n4086));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1663_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1660_4_lut (.I0(n2915), .I1(prodreg_adj_922[25]), .I2(n4745), 
            .I3(n2315), .O(n4083));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1660_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1657_4_lut (.I0(n2915), .I1(prodreg_adj_922[24]), .I2(n4714), 
            .I3(n2315), .O(n4080));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1657_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1_2_lut_4_lut_adj_8 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4621), .O(sqrin_31__N_97[21]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_8.LUT_INIT = 16'h3a00;
    SB_LUT4 i1653_4_lut (.I0(n2915), .I1(prodreg_adj_922[23]), .I2(n4683), 
            .I3(n2315), .O(n4076));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1653_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1650_4_lut (.I0(n2915), .I1(prodreg_adj_922[22]), .I2(n4652), 
            .I3(n2315), .O(n4073));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1650_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1647_4_lut (.I0(n2915), .I1(prodreg_adj_922[21]), .I2(n4621), 
            .I3(n2315), .O(n4070));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1647_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1_2_lut_4_lut_adj_9 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4652), .O(sqrin_31__N_97[22]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_9.LUT_INIT = 16'h3a00;
    SB_LUT4 i12_4_lut (.I0(mcreg_adj_917[0]), .I1(root[0]), .I2(n2315), 
            .I3(n2193), .O(n5724));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i12_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i1640_4_lut (.I0(n2915), .I1(prodreg_adj_922[20]), .I2(n4590), 
            .I3(n2315), .O(n4063));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1640_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1_2_lut_4_lut_adj_10 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4683), .O(sqrin_31__N_97[23]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_10.LUT_INIT = 16'h3a00;
    SB_LUT4 i1636_4_lut (.I0(n2915), .I1(prodreg_adj_922[19]), .I2(n4559), 
            .I3(n2315), .O(n4059));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1636_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1633_4_lut (.I0(n2915), .I1(prodreg_adj_922[18]), .I2(n4528), 
            .I3(n2315), .O(n4056));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1633_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1630_4_lut (.I0(n2912), .I1(prodreg[0]), .I2(tempout[0]), 
            .I3(n2179), .O(n4053));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1630_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1_2_lut_4_lut_adj_11 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4714), .O(sqrin_31__N_97[24]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_11.LUT_INIT = 16'h3a00;
    SB_LUT4 i1626_4_lut (.I0(n2915), .I1(prodreg_adj_922[17]), .I2(n4497), 
            .I3(n2315), .O(n4049));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1626_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1623_4_lut (.I0(n2915), .I1(prodreg_adj_922[16]), .I2(n4466), 
            .I3(n2315), .O(n4046));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1623_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1620_4_lut (.I0(n2915), .I1(prodreg_adj_922[15]), .I2(n4435), 
            .I3(n2315), .O(n4043));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1620_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1_2_lut_4_lut_adj_12 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4745), .O(sqrin_31__N_97[25]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_12.LUT_INIT = 16'h3a00;
    SB_LUT4 i1616_4_lut (.I0(n2915), .I1(prodreg_adj_922[14]), .I2(n4404), 
            .I3(n2315), .O(n4039));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1616_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1613_4_lut (.I0(n2915), .I1(prodreg_adj_922[13]), .I2(n4373), 
            .I3(n2315), .O(n4036));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1613_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1610_4_lut (.I0(n2915), .I1(prodreg_adj_922[12]), .I2(n4342), 
            .I3(n2315), .O(n4033));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1610_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1_2_lut_4_lut_adj_13 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4776), .O(sqrin_31__N_97[26]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_13.LUT_INIT = 16'h3a00;
    SB_LUT4 i1606_4_lut (.I0(n2915), .I1(prodreg_adj_922[11]), .I2(n4311), 
            .I3(n2315), .O(n4029));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1606_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1603_4_lut (.I0(n2915), .I1(prodreg_adj_922[10]), .I2(square[10]), 
            .I3(n2315), .O(n4026));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1603_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1600_4_lut (.I0(n2915), .I1(prodreg_adj_922[9]), .I2(square[9]), 
            .I3(n2315), .O(n4023));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1600_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1_2_lut_4_lut_adj_14 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4807), .O(sqrin_31__N_97[27]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_14.LUT_INIT = 16'h3a00;
    SB_LUT4 i1596_4_lut (.I0(n2915), .I1(prodreg_adj_922[8]), .I2(square[8]), 
            .I3(n2315), .O(n4019));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1596_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1593_4_lut (.I0(n2915), .I1(prodreg_adj_922[7]), .I2(square[7]), 
            .I3(n2315), .O(n4016));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1593_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1590_4_lut (.I0(n2915), .I1(prodreg_adj_922[6]), .I2(square[6]), 
            .I3(n2315), .O(n4013));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1590_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1_2_lut_4_lut_adj_15 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4838), .O(sqrin_31__N_97[28]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_15.LUT_INIT = 16'h3a00;
    SB_LUT4 i1586_4_lut (.I0(n2915), .I1(prodreg_adj_922[5]), .I2(square[5]), 
            .I3(n2315), .O(n4009));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1586_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1583_4_lut (.I0(n2915), .I1(prodreg_adj_922[4]), .I2(square[4]), 
            .I3(n2315), .O(n4006));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1583_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1580_4_lut (.I0(n2915), .I1(prodreg_adj_922[3]), .I2(square[3]), 
            .I3(n2315), .O(n4003));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1580_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1_2_lut_4_lut_adj_16 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4280), .O(sqrin_31__N_97[29]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_16.LUT_INIT = 16'h3a00;
    SB_LUT4 i1576_4_lut (.I0(n2915), .I1(prodreg_adj_922[2]), .I2(square[2]), 
            .I3(n2315), .O(n3999));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1576_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1573_4_lut (.I0(n2915), .I1(prodreg_adj_922[1]), .I2(square[1]), 
            .I3(n2315), .O(n3996));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1573_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i2517_2_lut_4_lut (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(square[30]), .O(sqrin_31__N_97[30]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i2517_2_lut_4_lut.LUT_INIT = 16'h3a00;
    SB_LUT4 i12_4_lut_adj_17 (.I0(mpreg_adj_916[31]), .I1(root[31]), .I2(n2315), 
            .I3(n2193), .O(n5726));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i12_4_lut_adj_17.LUT_INIT = 16'hca0a;
    SB_LUT4 i2483_2_lut_4_lut (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(square[31]), .O(sqrin_31__N_97[31]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i2483_2_lut_4_lut.LUT_INIT = 16'h3a00;
    SB_LUT4 i3212_2_lut_3_lut (.I0(multrdy), .I1(sqrrdy), .I2(n61), .I3(GND_net), 
            .O(n5812));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(126[13:31])
    defparam i3212_2_lut_3_lut.LUT_INIT = 16'h8080;
    SB_LUT4 i1565_4_lut (.I0(n2912), .I1(prodreg[1]), .I2(tempout[1]), 
            .I3(n2179), .O(n3988));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1565_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 bothrdy_I_0_2_lut_3_lut (.I0(multrdy), .I1(sqrrdy), .I2(multgo), 
            .I3(GND_net), .O(ready_N_452));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(126[13:31])
    defparam bothrdy_I_0_2_lut_3_lut.LUT_INIT = 16'h0808;
    SB_LUT4 i1562_4_lut (.I0(n2912), .I1(prodreg[2]), .I2(tempout[2]), 
            .I3(n2179), .O(n3985));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1562_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i2479_2_lut_4_lut (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(square[0]), .O(sqrin_31__N_97[0]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i2479_2_lut_4_lut.LUT_INIT = 16'hffc5;
    SB_LUT4 i2530_2_lut_4_lut (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(square[10]), .O(sqrin_31__N_97[10]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i2530_2_lut_4_lut.LUT_INIT = 16'h3a00;
    SB_LUT4 i1558_4_lut (.I0(n2912), .I1(prodreg[3]), .I2(tempout[3]), 
            .I3(n2179), .O(n3981));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1558_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1_2_lut_4_lut_adj_18 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4311), .O(sqrin_31__N_97[11]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_18.LUT_INIT = 16'h3a00;
    SB_LUT4 i1555_4_lut (.I0(n2912), .I1(prodreg[4]), .I2(tempout[4]), 
            .I3(n2179), .O(n3978));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1555_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1_2_lut_4_lut_adj_19 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4342), .O(sqrin_31__N_97[12]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_19.LUT_INIT = 16'h3a00;
    SB_LUT4 i1552_4_lut (.I0(n2912), .I1(prodreg[5]), .I2(tempout[5]), 
            .I3(n2179), .O(n3975));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1552_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i2_3_lut_4_lut (.I0(ready_N_452), .I1(n61), .I2(reset_c), 
            .I3(ready_c), .O(n2009));
    defparam i2_3_lut_4_lut.LUT_INIT = 16'h0002;
    SB_LUT4 i1_2_lut_4_lut_adj_20 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4373), .O(sqrin_31__N_97[13]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_20.LUT_INIT = 16'h3a00;
    SB_LUT4 i1548_4_lut (.I0(n2912), .I1(prodreg[6]), .I2(tempout[6]), 
            .I3(n2179), .O(n3971));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1548_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1_2_lut_4_lut_adj_21 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4404), .O(sqrin_31__N_97[14]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_21.LUT_INIT = 16'h3a00;
    SB_LUT4 i1545_4_lut (.I0(n2912), .I1(prodreg[7]), .I2(tempout[7]), 
            .I3(n2179), .O(n3968));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1545_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i11_3_lut_4_lut (.I0(ready_N_452), .I1(n61), .I2(ready_c), 
            .I3(ds_c), .O(n5728));
    defparam i11_3_lut_4_lut.LUT_INIT = 16'h02f2;
    SB_LUT4 i1_2_lut_4_lut_adj_22 (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(n4435), .O(sqrin_31__N_97[15]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i1_2_lut_4_lut_adj_22.LUT_INIT = 16'h3a00;
    SB_LUT4 i1541_4_lut (.I0(n2912), .I1(prodreg[8]), .I2(tempout[8]), 
            .I3(n2179), .O(n3964));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1541_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i2531_2_lut_4_lut (.I0(count[0]), .I1(ds_c), .I2(ready_c), 
            .I3(square[9]), .O(sqrin_31__N_97[9]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(213[4] 243[11])
    defparam i2531_2_lut_4_lut.LUT_INIT = 16'h3a00;
    SB_LUT4 i1538_4_lut (.I0(n2912), .I1(prodreg[9]), .I2(tempout[9]), 
            .I3(n2179), .O(n3961));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1538_4_lut.LUT_INIT = 16'h5044;
    SB_LUT4 i1535_4_lut (.I0(n2912), .I1(prodreg[10]), .I2(tempout[10]), 
            .I3(n2179), .O(n3958));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1535_4_lut.LUT_INIT = 16'h5044;
    \modmult(32)_U0  modmultiply (.n4776(n4776), .indata_c_26(indata_c_26), 
            .ready_c(ready_c), .\root_31__N_65[26] (root_31__N_65[26]), 
            .GND_net(GND_net), .\prodreg1[25] (prodreg1_adj_923[25]), .\prodreg2[25] (prodreg2_adj_924[25]), 
            .\prodreg2[33] (prodreg2_adj_924[33]), .tempout({tempout}), 
            .\prodreg3[25] (prodreg3_adj_925[25]), .\prodreg3[33] (prodreg3_adj_925[33]), 
            .n4745(n4745), .\mcreg1[32] (mcreg1[32]), .indata_c_25(indata_c_25), 
            .\root_31__N_65[25] (root_31__N_65[25]), .\tempin[31] (tempin[31]), 
            .n2057(n2057), .prodreg({Open_33, Open_34, prodreg[31:30], 
            Open_35, Open_36, Open_37, Open_38, Open_39, Open_40, 
            Open_41, Open_42, Open_43, Open_44, Open_45, Open_46, 
            Open_47, Open_48, Open_49, Open_50, Open_51, Open_52, 
            Open_53, Open_54, Open_55, prodreg[8], Open_56, Open_57, 
            prodreg[5], Open_58, Open_59, Open_60, Open_61, Open_62}), 
            .\prodreg1[24] (prodreg1_adj_923[24]), .\prodreg2[24] (prodreg2_adj_924[24]), 
            .\prodreg3[24] (prodreg3_adj_925[24]), .n4714(n4714), .indata_c_24(indata_c_24), 
            .\root_31__N_65[24] (root_31__N_65[24]), .multrdy(multrdy), 
            .clk_c(clk_c), .reset_c(reset_c), .\prodreg1[23] (prodreg1_adj_923[23]), 
            .\prodreg2[23] (prodreg2_adj_924[23]), .\tempin[30] (tempin[30]), 
            .\prodreg3[23] (prodreg3_adj_925[23]), .n4683(n4683), .indata_c_23(indata_c_23), 
            .\root_31__N_65[23] (root_31__N_65[23]), .n3898(n3898), .VCC_net(VCC_net), 
            .\tempin[29] (tempin[29]), .\prodreg1[22] (prodreg1_adj_923[22]), 
            .\prodreg2[22] (prodreg2_adj_924[22]), .\prodreg3[22] (prodreg3_adj_925[22]), 
            .n4652(n4652), .\tempin[28] (tempin[28]), .indata_c_22(indata_c_22), 
            .\root_31__N_65[22] (root_31__N_65[22]), .\prodreg1[21] (prodreg1_adj_923[21]), 
            .\prodreg2[21] (prodreg2_adj_924[21]), .\prodreg3[21] (prodreg3_adj_925[21]), 
            .n4621(n4621), .n2179(n2179), .indata_c_21(indata_c_21), .\root_31__N_65[21] (root_31__N_65[21]), 
            .\tempin[27] (tempin[27]), .\prodreg1[20] (prodreg1_adj_923[20]), 
            .\prodreg2[20] (prodreg2_adj_924[20]), .\prodreg3[20] (prodreg3_adj_925[20]), 
            .n4590(n4590), .\tempin[26] (tempin[26]), .indata_c_20(indata_c_20), 
            .\root_31__N_65[20] (root_31__N_65[20]), .\prodreg1[19] (prodreg1_adj_923[19]), 
            .\prodreg2[19] (prodreg2_adj_924[19]), .\prodreg3[19] (prodreg3_adj_925[19]), 
            .n4559(n4559), .\tempin[25] (tempin[25]), .indata_c_19(indata_c_19), 
            .\root_31__N_65[19] (root_31__N_65[19]), .\prodreg1[18] (prodreg1_adj_923[18]), 
            .\prodreg2[18] (prodreg2_adj_924[18]), .\tempin[24] (tempin[24]), 
            .\prodreg3[18] (prodreg3_adj_925[18]), .n4528(n4528), .\tempin[23] (tempin[23]), 
            .indata_c_18(indata_c_18), .\root_31__N_65[18] (root_31__N_65[18]), 
            .\prodreg1[17] (prodreg1_adj_923[17]), .\prodreg2[17] (prodreg2_adj_924[17]), 
            .\prodreg3[17] (prodreg3_adj_925[17]), .n4497(n4497), .\tempin[22] (tempin[22]), 
            .indata_c_17(indata_c_17), .\root_31__N_65[17] (root_31__N_65[17]), 
            .\prodreg1[16] (prodreg1_adj_923[16]), .\prodreg2[16] (prodreg2_adj_924[16]), 
            .n2097(n2097), .\tempin[21] (tempin[21]), .\prodreg3[16] (prodreg3_adj_925[16]), 
            .n4466(n4466), .indata_c_16(indata_c_16), .\root_31__N_65[16] (root_31__N_65[16]), 
            .\tempin[20] (tempin[20]), .\prodreg1[15] (prodreg1_adj_923[15]), 
            .\prodreg2[15] (prodreg2_adj_924[15]), .\prodreg3[15] (prodreg3_adj_925[15]), 
            .n4435(n4435), .\tempin[19] (tempin[19]), .indata_c_15(indata_c_15), 
            .\root_31__N_65[15] (root_31__N_65[15]), .\prodreg1[14] (prodreg1_adj_923[14]), 
            .\prodreg2[14] (prodreg2_adj_924[14]), .\prodreg3[14] (prodreg3_adj_925[14]), 
            .n4404(n4404), .\tempin[18] (tempin[18]), .\sqrin[29] (sqrin[29]), 
            .multgo(multgo), .indata_c_14(indata_c_14), .\root_31__N_65[14] (root_31__N_65[14]), 
            .\sqrin[28] (sqrin[28]), .\prodreg1[13] (prodreg1_adj_923[13]), 
            .\prodreg2[13] (prodreg2_adj_924[13]), .\tempin[17] (tempin[17]), 
            .\prodreg[7] (prodreg[7]), .\prodreg[2] (prodreg[2]), .\sqrin[27] (sqrin[27]), 
            .\prodreg3[13] (prodreg3_adj_925[13]), .n4373(n4373), .\sqrin[26] (sqrin[26]), 
            .indata_c_13(indata_c_13), .\root_31__N_65[13] (root_31__N_65[13]), 
            .\tempin[16] (tempin[16]), .\prodreg1[12] (prodreg1_adj_923[12]), 
            .\prodreg2[12] (prodreg2_adj_924[12]), .\sqrin[25] (sqrin[25]), 
            .\sqrin[24] (sqrin[24]), .\prodreg3[12] (prodreg3_adj_925[12]), 
            .n4342(n4342), .\sqrin[23] (sqrin[23]), .\tempin[15] (tempin[15]), 
            .indata_c_12(indata_c_12), .\root_31__N_65[12] (root_31__N_65[12]), 
            .\sqrin[22] (sqrin[22]), .\prodreg1[11] (prodreg1_adj_923[11]), 
            .\prodreg2[11] (prodreg2_adj_924[11]), .\sqrin[21] (sqrin[21]), 
            .\prodreg3[11] (prodreg3_adj_925[11]), .n4311(n4311), .\tempin[14] (tempin[14]), 
            .\sqrin[20] (sqrin[20]), .indata_c_11(indata_c_11), .\root_31__N_65[11] (root_31__N_65[11]), 
            .\sqrin[19] (sqrin[19]), .\tempin[13] (tempin[13]), .n3895(n3895), 
            .n3892(n3892), .\mpreg[31] (mpreg[31]), .\sqrin[18] (sqrin[18]), 
            .\tempin[12] (tempin[12]), .\sqrin[17] (sqrin[17]), .\sqrin[16] (sqrin[16]), 
            .\tempin[11] (tempin[11]), .\sqrin[15] (sqrin[15]), .\prodreg[0] (prodreg[0]), 
            .\sqrin[14] (sqrin[14]), .n2088(n2088), .n4107(n4107), .\mcreg[0] (mcreg[0]), 
            .\sqrin[13] (sqrin[13]), .\tempin[10] (tempin[10]), .\tempin[9] (tempin[9]), 
            .n4053(n4053), .\tempin[8] (tempin[8]), .\tempin[7] (tempin[7]), 
            .n3988(n3988), .\prodreg[1] (prodreg[1]), .n3985(n3985), .n2912(n2912), 
            .n3981(n3981), .\prodreg[3] (prodreg[3]), .n3978(n3978), .\prodreg[4] (prodreg[4]), 
            .n3975(n3975), .\tempin[6] (tempin[6]), .n3971(n3971), .\prodreg[6] (prodreg[6]), 
            .n3968(n3968), .\tempin[5] (tempin[5]), .n3964(n3964), .n3961(n3961), 
            .\prodreg[9] (prodreg[9]), .n3958(n3958), .\prodreg[10] (prodreg[10]), 
            .\tempin[4] (tempin[4]), .\sqrin[12] (sqrin[12]), .\tempin[3] (tempin[3]), 
            .\sqrin[11] (sqrin[11]), .\sqrin[10] (sqrin[10]), .\sqrin[9] (sqrin[9]), 
            .\tempin[2] (tempin[2]), .indata_c_29(indata_c_29), .inExp_c_0(inExp_c_0), 
            .\tempin_31__N_129[29] (tempin_31__N_129[29]), .indata_c_28(indata_c_28), 
            .\tempin_31__N_129[28] (tempin_31__N_129[28]), .indata_c_27(indata_c_27), 
            .\tempin_31__N_129[27] (tempin_31__N_129[27]), .\tempin_31__N_129[26] (tempin_31__N_129[26]), 
            .\tempin_31__N_129[25] (tempin_31__N_129[25]), .\tempin_31__N_129[24] (tempin_31__N_129[24]), 
            .\mcreg1[0] (mcreg1[0]), .\sqrin[8] (sqrin[8]), .\tempin_31__N_129[23] (tempin_31__N_129[23]), 
            .\tempin_31__N_129[22] (tempin_31__N_129[22]), .\tempin_31__N_129[21] (tempin_31__N_129[21]), 
            .\tempin_31__N_129[20] (tempin_31__N_129[20]), .\tempin_31__N_129[19] (tempin_31__N_129[19]), 
            .\tempin_31__N_129[18] (tempin_31__N_129[18]), .\tempin_31__N_129[17] (tempin_31__N_129[17]), 
            .\tempin_31__N_129[16] (tempin_31__N_129[16]), .\sqrin[7] (sqrin[7]), 
            .\sqrin[6] (sqrin[6]), .\tempin_31__N_129[15] (tempin_31__N_129[15]), 
            .\tempin_31__N_129[14] (tempin_31__N_129[14]), .\sqrin[5] (sqrin[5]), 
            .\tempin_31__N_129[13] (tempin_31__N_129[13]), .\tempin_31__N_129[12] (tempin_31__N_129[12]), 
            .\tempin_31__N_129[11] (tempin_31__N_129[11]), .\prodreg1[29] (prodreg1_adj_923[29]), 
            .\prodreg2[29] (prodreg2_adj_924[29]), .\prodreg3[29] (prodreg3_adj_925[29]), 
            .n4280(n4280), .\sqrin[4] (sqrin[4]), .modreg({modreg}), .\root_31__N_65[29] (root_31__N_65[29]), 
            .\prodreg1[28] (prodreg1_adj_923[28]), .\prodreg2[28] (prodreg2_adj_924[28]), 
            .\prodreg3[28] (prodreg3_adj_925[28]), .n4838(n4838), .\root_31__N_65[28] (root_31__N_65[28]), 
            .\prodreg1[27] (prodreg1_adj_923[27]), .\prodreg2[27] (prodreg2_adj_924[27]), 
            .\prodreg3[27] (prodreg3_adj_925[27]), .n4807(n4807), .\root_31__N_65[27] (root_31__N_65[27]), 
            .\prodreg1[26] (prodreg1_adj_923[26]), .\prodreg2[26] (prodreg2_adj_924[26]), 
            .\prodreg3[26] (prodreg3_adj_925[26]), .\sqrin[3] (sqrin[3]), 
            .\sqrin[2] (sqrin[2]), .\sqrin[1] (sqrin[1]), .\sqrin[0] (sqrin[0]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(129[15:22])
    SB_LUT4 square_31__I_0_i3_3_lut (.I0(square[2]), .I1(indata_c_2), .I2(ready_c), 
            .I3(GND_net), .O(root_31__N_65[2]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(190[4] 199[11])
    defparam square_31__I_0_i3_3_lut.LUT_INIT = 16'hcaca;
    
endmodule
//
// Verilog Description of module \modmult(32) 
//

module \modmult(32)  (n2315, clk_c, GND_net, sqrrdy, reset_c, multgo, 
            n2915, prodreg3, VCC_net, \prodreg3[29] , \prodreg1[29] , 
            \prodreg3[28] , \prodreg1[28] , \prodreg3[27] , \prodreg1[27] , 
            \prodreg3[26] , \prodreg1[26] , \prodreg3[25] , \prodreg1[25] , 
            \prodreg3[24] , \prodreg1[24] , \prodreg2[33] , \prodreg3[23] , 
            \prodreg1[23] , \prodreg3[22] , \prodreg1[22] , \prodreg3[21] , 
            \prodreg1[21] , \prodreg3[20] , \prodreg1[20] , \prodreg3[19] , 
            \prodreg1[19] , \prodreg3[18] , \prodreg1[18] , \prodreg3[17] , 
            \prodreg1[17] , \prodreg3[16] , \prodreg1[16] , \prodreg3[15] , 
            \prodreg1[15] , \prodreg3[14] , \prodreg1[14] , \prodreg3[13] , 
            \prodreg1[13] , \prodreg3[12] , \prodreg1[12] , \prodreg3[11] , 
            \prodreg1[11] , \square[10] , \square[9] , \square[8] , 
            \prodreg2[29] , \prodreg2[28] , \prodreg2[27] , \prodreg2[26] , 
            \prodreg2[25] , \prodreg2[24] , \prodreg[31] , \prodreg[30] , 
            \prodreg[29] , \prodreg[28] , \prodreg2[23] , \prodreg2[22] , 
            \prodreg2[21] , \prodreg2[20] , \prodreg2[19] , \prodreg2[18] , 
            \prodreg2[17] , \prodreg2[16] , \prodreg2[15] , \prodreg[27] , 
            \prodreg2[14] , \prodreg2[13] , \prodreg2[12] , \prodreg2[11] , 
            \prodreg[26] , \prodreg[25] , \prodreg[24] , n4111, \prodreg[0] , 
            n4103, n4100, n4096, n4093, n4090, n4086, n4083, n4080, 
            n4076, \prodreg[23] , n4073, \prodreg[22] , n4070, \prodreg[21] , 
            \square[7] , n5724, \mcreg[0] , n4063, \prodreg[20] , 
            n4059, \prodreg[19] , n4056, \prodreg[18] , n4049, \prodreg[17] , 
            n4046, \prodreg[16] , n4043, \prodreg[15] , n4039, \prodreg[14] , 
            n4036, \prodreg[13] , n4033, \prodreg[12] , n4029, \prodreg[11] , 
            n4026, \prodreg[10] , \square[6] , n4023, \prodreg[9] , 
            n4019, \prodreg[8] , n4016, \prodreg[7] , n4013, \prodreg[6] , 
            n4009, \prodreg[5] , n4006, \prodreg[4] , n4003, \prodreg[3] , 
            n3999, \prodreg[2] , n3996, \prodreg[1] , n5726, \mpreg[31] , 
            \square[5] , \square[4] , \square[2] , \square[3] , n2193, 
            \square[1] , \square[31] , \square[30] , \square[0] , root, 
            modreg);
    output n2315;
    input clk_c;
    input GND_net;
    output sqrrdy;
    input reset_c;
    input multgo;
    output n2915;
    output [33:0]prodreg3;
    input VCC_net;
    output \prodreg3[29] ;
    output \prodreg1[29] ;
    output \prodreg3[28] ;
    output \prodreg1[28] ;
    output \prodreg3[27] ;
    output \prodreg1[27] ;
    output \prodreg3[26] ;
    output \prodreg1[26] ;
    output \prodreg3[25] ;
    output \prodreg1[25] ;
    output \prodreg3[24] ;
    output \prodreg1[24] ;
    output \prodreg2[33] ;
    output \prodreg3[23] ;
    output \prodreg1[23] ;
    output \prodreg3[22] ;
    output \prodreg1[22] ;
    output \prodreg3[21] ;
    output \prodreg1[21] ;
    output \prodreg3[20] ;
    output \prodreg1[20] ;
    output \prodreg3[19] ;
    output \prodreg1[19] ;
    output \prodreg3[18] ;
    output \prodreg1[18] ;
    output \prodreg3[17] ;
    output \prodreg1[17] ;
    output \prodreg3[16] ;
    output \prodreg1[16] ;
    output \prodreg3[15] ;
    output \prodreg1[15] ;
    output \prodreg3[14] ;
    output \prodreg1[14] ;
    output \prodreg3[13] ;
    output \prodreg1[13] ;
    output \prodreg3[12] ;
    output \prodreg1[12] ;
    output \prodreg3[11] ;
    output \prodreg1[11] ;
    output \square[10] ;
    output \square[9] ;
    output \square[8] ;
    output \prodreg2[29] ;
    output \prodreg2[28] ;
    output \prodreg2[27] ;
    output \prodreg2[26] ;
    output \prodreg2[25] ;
    output \prodreg2[24] ;
    output \prodreg[31] ;
    output \prodreg[30] ;
    output \prodreg[29] ;
    output \prodreg[28] ;
    output \prodreg2[23] ;
    output \prodreg2[22] ;
    output \prodreg2[21] ;
    output \prodreg2[20] ;
    output \prodreg2[19] ;
    output \prodreg2[18] ;
    output \prodreg2[17] ;
    output \prodreg2[16] ;
    output \prodreg2[15] ;
    output \prodreg[27] ;
    output \prodreg2[14] ;
    output \prodreg2[13] ;
    output \prodreg2[12] ;
    output \prodreg2[11] ;
    output \prodreg[26] ;
    output \prodreg[25] ;
    output \prodreg[24] ;
    input n4111;
    output \prodreg[0] ;
    input n4103;
    input n4100;
    input n4096;
    input n4093;
    input n4090;
    input n4086;
    input n4083;
    input n4080;
    input n4076;
    output \prodreg[23] ;
    input n4073;
    output \prodreg[22] ;
    input n4070;
    output \prodreg[21] ;
    output \square[7] ;
    input n5724;
    output \mcreg[0] ;
    input n4063;
    output \prodreg[20] ;
    input n4059;
    output \prodreg[19] ;
    input n4056;
    output \prodreg[18] ;
    input n4049;
    output \prodreg[17] ;
    input n4046;
    output \prodreg[16] ;
    input n4043;
    output \prodreg[15] ;
    input n4039;
    output \prodreg[14] ;
    input n4036;
    output \prodreg[13] ;
    input n4033;
    output \prodreg[12] ;
    input n4029;
    output \prodreg[11] ;
    input n4026;
    output \prodreg[10] ;
    output \square[6] ;
    input n4023;
    output \prodreg[9] ;
    input n4019;
    output \prodreg[8] ;
    input n4016;
    output \prodreg[7] ;
    input n4013;
    output \prodreg[6] ;
    input n4009;
    output \prodreg[5] ;
    input n4006;
    output \prodreg[4] ;
    input n4003;
    output \prodreg[3] ;
    input n3999;
    output \prodreg[2] ;
    input n3996;
    output \prodreg[1] ;
    input n5726;
    output \mpreg[31] ;
    output \square[5] ;
    output \square[4] ;
    output \square[2] ;
    output \square[3] ;
    output n2193;
    output \square[1] ;
    output \square[31] ;
    output \square[30] ;
    output \square[0] ;
    input [31:0]root;
    input [31:0]modreg;
    
    wire clk_c /* synthesis is_clock=1, SET_AS_NETWORK=clk_c */ ;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(80[5:8])
    
    wire n2194;
    wire [31:0]mpreg;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(88[8:13])
    wire [33:0]modreg1;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(90[8:15])
    wire [33:0]n1;
    
    wire n2268;
    wire [33:0]prodreg1;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[17:25])
    
    wire n5493;
    wire [33:0]prodreg3_c;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    
    wire n5492, n5491, n5490, n5489, n5488, n5487, n5486, n5485, 
        n5484, n2195;
    wire [33:0]prodreg2;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[27:35])
    
    wire n2948, n5483, n5482, n5481, n5480, n5479, n5478, n5477, 
        n5476, n5475, n5474, n5473, n5472, n5471, n5470, n5469, 
        n5468, n5467, n5466, n5465, n5464, n5463, n5462, n5461, 
        n2196, n2197, n2198, n2199, n2200, n2201, n2202, n2203, 
        n2204, n2205, n2206, n2207, n2208, n2209, n2210, n2211, 
        n2212, n2213, n2214, n2215, n2216, n2217, n2218, n2219, 
        n2220, n2221, n2222, n2223, n2224, n2233;
    wire [33:0]mcreg;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(89[8:13])
    
    wire n3889, n3888, n3887, n3886, n3885, n3884, n3883, n3882, 
        n3881, n3880, n3879, n3878, n3877, n3876, n3875, n3874, 
        n3873, n3872, n3871, n3870, n3869, n3868, n3867, n3866, 
        n3865, n3864, n2234, n2235, n2236, n2237, n2238, n2239, 
        n2240, n2241, n2242, n2243, n2244, n2245, n2246, n2247, 
        n2248, n2249, n2250, n2251, n2252, n2253, n2254, n2255, 
        n2256, n2257, n2258, n2259, n2260, n2261, n2262, n2263, 
        n3863, n3862, n3861, n3860, n3859, n2947, n2946, n5427, 
        n5426, n5425, n5424, n5423, n5422, n5421, n5420, n5419, 
        n5418, n3827;
    wire [33:0]prodreg;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[8:15])
    wire [33:0]n2790;
    
    wire n5329, n5328, n5327, n5326, n5325, n5324, n5417, n5416, 
        n5415, n5414, n5413, n5412, n5411, n5410, n5409, n5323, 
        n5408, n5407, n5406, n5405, n5404, n5403, n5402, n5401, 
        n5400, n5399, n5398, n5397, n5396, n5395;
    wire [33:0]mcreg1;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(89[15:21])
    
    wire n5394, n5393, n5392, n5391, n5390, n5389, n5388, n5387, 
        n5386, n5385, n5384, n5383, n5382, n5381, n5380, n5379, 
        n5378, n5377, n5376, n5375, n5374, n5373, n5372, n5371, 
        n5370, n5369, n5368, n5367, n5322, n5321, n5320, n2945, 
        n2944, n2943, n5319, n5318, n5317, n5316, n5315, n5314, 
        n5313, n5312, n5311, n5310, n5309, n5308, n5307, n5306, 
        n5305, n5304, n2942, n5303, n5302, n5301, n5300, n5299, 
        n5298, n2941, n5297;
    wire [33:0]mcreg2;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(89[23:29])
    
    wire n5366, n2940, n5365, n5364;
    wire [33:0]prodreg4;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[47:55])
    
    wire n5363, n56, n54, n55, n53, n52, n50, n51, n5765, 
        n62, n5763, n2939, n2969, n2968, n2970;
    
    SB_DFFE mpreg_i0_i0 (.Q(mpreg[0]), .C(clk_c), .E(n2315), .D(n2194));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 sub_89_inv_0_i2_1_lut (.I0(modreg1[0]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[1]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i2_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i3_1_lut (.I0(modreg1[1]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[2]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i3_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i4_1_lut (.I0(modreg1[2]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[3]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i4_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i5_1_lut (.I0(modreg1[3]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[4]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i5_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i6_1_lut (.I0(modreg1[4]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[5]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i6_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i7_1_lut (.I0(modreg1[5]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[6]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i7_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i8_1_lut (.I0(modreg1[6]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[7]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i8_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i9_1_lut (.I0(modreg1[7]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[8]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i9_1_lut.LUT_INIT = 16'h5555;
    SB_DFFS first_45 (.Q(sqrrdy), .C(clk_c), .D(n2268), .S(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 sub_89_inv_0_i10_1_lut (.I0(modreg1[8]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[9]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i10_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i11_1_lut (.I0(modreg1[9]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[10]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i11_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i12_1_lut (.I0(modreg1[10]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[11]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i12_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i13_1_lut (.I0(modreg1[11]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[12]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i13_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i14_1_lut (.I0(modreg1[12]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[13]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i14_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i15_1_lut (.I0(modreg1[13]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[14]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i15_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i16_1_lut (.I0(modreg1[14]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[15]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i16_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i17_1_lut (.I0(modreg1[15]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[16]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i17_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i18_1_lut (.I0(modreg1[16]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[17]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i18_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i19_1_lut (.I0(modreg1[17]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[18]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i19_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i20_1_lut (.I0(modreg1[18]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[19]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i20_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i21_1_lut (.I0(modreg1[19]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[20]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i21_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i22_1_lut (.I0(modreg1[20]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[21]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i22_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i23_1_lut (.I0(modreg1[21]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[22]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i23_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i24_1_lut (.I0(modreg1[22]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[23]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i24_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 i1368_2_lut_4_lut (.I0(n2268), .I1(reset_c), .I2(sqrrdy), 
            .I3(multgo), .O(n2915));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1368_2_lut_4_lut.LUT_INIT = 16'h1000;
    SB_LUT4 sub_89_add_2_35_lut (.I0(GND_net), .I1(prodreg1[33]), .I2(VCC_net), 
            .I3(n5493), .O(prodreg3[33])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_35_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_89_add_2_34_lut (.I0(GND_net), .I1(prodreg1[32]), .I2(n1[32]), 
            .I3(n5492), .O(prodreg3_c[32])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_34_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_34 (.CI(n5492), .I0(prodreg1[32]), .I1(n1[32]), 
            .CO(n5493));
    SB_LUT4 sub_89_add_2_33_lut (.I0(GND_net), .I1(prodreg1[31]), .I2(n1[31]), 
            .I3(n5491), .O(prodreg3_c[31])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_33_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_33 (.CI(n5491), .I0(prodreg1[31]), .I1(n1[31]), 
            .CO(n5492));
    SB_LUT4 sub_89_add_2_32_lut (.I0(GND_net), .I1(prodreg1[30]), .I2(n1[30]), 
            .I3(n5490), .O(prodreg3_c[30])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_32_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_32 (.CI(n5490), .I0(prodreg1[30]), .I1(n1[30]), 
            .CO(n5491));
    SB_LUT4 sub_89_add_2_31_lut (.I0(GND_net), .I1(\prodreg1[29] ), .I2(n1[29]), 
            .I3(n5489), .O(\prodreg3[29] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_31_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_31 (.CI(n5489), .I0(\prodreg1[29] ), .I1(n1[29]), 
            .CO(n5490));
    SB_LUT4 sub_89_add_2_30_lut (.I0(GND_net), .I1(\prodreg1[28] ), .I2(n1[28]), 
            .I3(n5488), .O(\prodreg3[28] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_30_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_30 (.CI(n5488), .I0(\prodreg1[28] ), .I1(n1[28]), 
            .CO(n5489));
    SB_LUT4 sub_89_add_2_29_lut (.I0(GND_net), .I1(\prodreg1[27] ), .I2(n1[27]), 
            .I3(n5487), .O(\prodreg3[27] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_29_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_29 (.CI(n5487), .I0(\prodreg1[27] ), .I1(n1[27]), 
            .CO(n5488));
    SB_LUT4 sub_89_add_2_28_lut (.I0(GND_net), .I1(\prodreg1[26] ), .I2(n1[26]), 
            .I3(n5486), .O(\prodreg3[26] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_28_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_28 (.CI(n5486), .I0(\prodreg1[26] ), .I1(n1[26]), 
            .CO(n5487));
    SB_LUT4 sub_89_add_2_27_lut (.I0(GND_net), .I1(\prodreg1[25] ), .I2(n1[25]), 
            .I3(n5485), .O(\prodreg3[25] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_27_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_27 (.CI(n5485), .I0(\prodreg1[25] ), .I1(n1[25]), 
            .CO(n5486));
    SB_LUT4 sub_89_add_2_26_lut (.I0(GND_net), .I1(\prodreg1[24] ), .I2(n1[24]), 
            .I3(n5484), .O(\prodreg3[24] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_26_lut.LUT_INIT = 16'hC33C;
    SB_DFFE mpreg_i0_i1 (.Q(mpreg[1]), .C(clk_c), .E(n2315), .D(n2195));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 i525_3_lut (.I0(prodreg1[10]), .I1(prodreg2[10]), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n2948));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i525_3_lut.LUT_INIT = 16'hacac;
    SB_CARRY sub_89_add_2_26 (.CI(n5484), .I0(\prodreg1[24] ), .I1(n1[24]), 
            .CO(n5485));
    SB_LUT4 sub_89_add_2_25_lut (.I0(GND_net), .I1(\prodreg1[23] ), .I2(n1[23]), 
            .I3(n5483), .O(\prodreg3[23] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_25_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_25 (.CI(n5483), .I0(\prodreg1[23] ), .I1(n1[23]), 
            .CO(n5484));
    SB_LUT4 sub_89_add_2_24_lut (.I0(GND_net), .I1(\prodreg1[22] ), .I2(n1[22]), 
            .I3(n5482), .O(\prodreg3[22] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_24_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_24 (.CI(n5482), .I0(\prodreg1[22] ), .I1(n1[22]), 
            .CO(n5483));
    SB_LUT4 sub_89_add_2_23_lut (.I0(GND_net), .I1(\prodreg1[21] ), .I2(n1[21]), 
            .I3(n5481), .O(\prodreg3[21] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_23_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_23 (.CI(n5481), .I0(\prodreg1[21] ), .I1(n1[21]), 
            .CO(n5482));
    SB_LUT4 sub_89_add_2_22_lut (.I0(GND_net), .I1(\prodreg1[20] ), .I2(n1[20]), 
            .I3(n5480), .O(\prodreg3[20] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_22_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_22 (.CI(n5480), .I0(\prodreg1[20] ), .I1(n1[20]), 
            .CO(n5481));
    SB_LUT4 sub_89_add_2_21_lut (.I0(GND_net), .I1(\prodreg1[19] ), .I2(n1[19]), 
            .I3(n5479), .O(\prodreg3[19] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_21_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_21 (.CI(n5479), .I0(\prodreg1[19] ), .I1(n1[19]), 
            .CO(n5480));
    SB_LUT4 sub_89_add_2_20_lut (.I0(GND_net), .I1(\prodreg1[18] ), .I2(n1[18]), 
            .I3(n5478), .O(\prodreg3[18] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_20_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_20 (.CI(n5478), .I0(\prodreg1[18] ), .I1(n1[18]), 
            .CO(n5479));
    SB_LUT4 sub_89_add_2_19_lut (.I0(GND_net), .I1(\prodreg1[17] ), .I2(n1[17]), 
            .I3(n5477), .O(\prodreg3[17] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_19_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_19 (.CI(n5477), .I0(\prodreg1[17] ), .I1(n1[17]), 
            .CO(n5478));
    SB_LUT4 sub_89_add_2_18_lut (.I0(GND_net), .I1(\prodreg1[16] ), .I2(n1[16]), 
            .I3(n5476), .O(\prodreg3[16] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_18_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_18 (.CI(n5476), .I0(\prodreg1[16] ), .I1(n1[16]), 
            .CO(n5477));
    SB_LUT4 sub_89_add_2_17_lut (.I0(GND_net), .I1(\prodreg1[15] ), .I2(n1[15]), 
            .I3(n5475), .O(\prodreg3[15] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_17_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_17 (.CI(n5475), .I0(\prodreg1[15] ), .I1(n1[15]), 
            .CO(n5476));
    SB_LUT4 sub_89_add_2_16_lut (.I0(GND_net), .I1(\prodreg1[14] ), .I2(n1[14]), 
            .I3(n5474), .O(\prodreg3[14] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_16_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_16 (.CI(n5474), .I0(\prodreg1[14] ), .I1(n1[14]), 
            .CO(n5475));
    SB_LUT4 sub_89_add_2_15_lut (.I0(GND_net), .I1(\prodreg1[13] ), .I2(n1[13]), 
            .I3(n5473), .O(\prodreg3[13] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_15_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_15 (.CI(n5473), .I0(\prodreg1[13] ), .I1(n1[13]), 
            .CO(n5474));
    SB_LUT4 sub_89_add_2_14_lut (.I0(GND_net), .I1(\prodreg1[12] ), .I2(n1[12]), 
            .I3(n5472), .O(\prodreg3[12] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_14_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_14 (.CI(n5472), .I0(\prodreg1[12] ), .I1(n1[12]), 
            .CO(n5473));
    SB_LUT4 sub_89_add_2_13_lut (.I0(GND_net), .I1(\prodreg1[11] ), .I2(n1[11]), 
            .I3(n5471), .O(\prodreg3[11] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_13_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_13 (.CI(n5471), .I0(\prodreg1[11] ), .I1(n1[11]), 
            .CO(n5472));
    SB_LUT4 sub_89_add_2_12_lut (.I0(GND_net), .I1(prodreg1[10]), .I2(n1[10]), 
            .I3(n5470), .O(prodreg3_c[10])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_12_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_12 (.CI(n5470), .I0(prodreg1[10]), .I1(n1[10]), 
            .CO(n5471));
    SB_LUT4 sub_89_add_2_11_lut (.I0(GND_net), .I1(prodreg1[9]), .I2(n1[9]), 
            .I3(n5469), .O(prodreg3_c[9])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_11_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_11 (.CI(n5469), .I0(prodreg1[9]), .I1(n1[9]), 
            .CO(n5470));
    SB_LUT4 sub_89_add_2_10_lut (.I0(GND_net), .I1(prodreg1[8]), .I2(n1[8]), 
            .I3(n5468), .O(prodreg3_c[8])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_10_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_10 (.CI(n5468), .I0(prodreg1[8]), .I1(n1[8]), 
            .CO(n5469));
    SB_LUT4 sub_89_add_2_9_lut (.I0(GND_net), .I1(prodreg1[7]), .I2(n1[7]), 
            .I3(n5467), .O(prodreg3_c[7])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_9_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_9 (.CI(n5467), .I0(prodreg1[7]), .I1(n1[7]), 
            .CO(n5468));
    SB_LUT4 sub_89_add_2_8_lut (.I0(GND_net), .I1(prodreg1[6]), .I2(n1[6]), 
            .I3(n5466), .O(prodreg3_c[6])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_8_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_8 (.CI(n5466), .I0(prodreg1[6]), .I1(n1[6]), 
            .CO(n5467));
    SB_LUT4 sub_89_add_2_7_lut (.I0(GND_net), .I1(prodreg1[5]), .I2(n1[5]), 
            .I3(n5465), .O(prodreg3_c[5])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_7_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_7 (.CI(n5465), .I0(prodreg1[5]), .I1(n1[5]), 
            .CO(n5466));
    SB_LUT4 sub_89_add_2_6_lut (.I0(GND_net), .I1(prodreg1[4]), .I2(n1[4]), 
            .I3(n5464), .O(prodreg3_c[4])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_6_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_6 (.CI(n5464), .I0(prodreg1[4]), .I1(n1[4]), 
            .CO(n5465));
    SB_LUT4 sub_89_add_2_5_lut (.I0(GND_net), .I1(prodreg1[3]), .I2(n1[3]), 
            .I3(n5463), .O(prodreg3_c[3])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_5_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_5 (.CI(n5463), .I0(prodreg1[3]), .I1(n1[3]), 
            .CO(n5464));
    SB_LUT4 sub_89_add_2_4_lut (.I0(GND_net), .I1(prodreg1[2]), .I2(n1[2]), 
            .I3(n5462), .O(prodreg3_c[2])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_4_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_4 (.CI(n5462), .I0(prodreg1[2]), .I1(n1[2]), 
            .CO(n5463));
    SB_LUT4 sub_89_add_2_3_lut (.I0(GND_net), .I1(prodreg1[1]), .I2(n1[1]), 
            .I3(n5461), .O(prodreg3_c[1])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_89_add_2_3_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_89_add_2_3 (.CI(n5461), .I0(prodreg1[1]), .I1(n1[1]), 
            .CO(n5462));
    SB_CARRY sub_89_add_2_2 (.CI(VCC_net), .I0(prodreg3_c[0]), .I1(VCC_net), 
            .CO(n5461));
    SB_DFFE mpreg_i0_i2 (.Q(mpreg[2]), .C(clk_c), .E(n2315), .D(n2196));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i3 (.Q(mpreg[3]), .C(clk_c), .E(n2315), .D(n2197));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i4 (.Q(mpreg[4]), .C(clk_c), .E(n2315), .D(n2198));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i5 (.Q(mpreg[5]), .C(clk_c), .E(n2315), .D(n2199));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i6 (.Q(mpreg[6]), .C(clk_c), .E(n2315), .D(n2200));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i7 (.Q(mpreg[7]), .C(clk_c), .E(n2315), .D(n2201));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i8 (.Q(mpreg[8]), .C(clk_c), .E(n2315), .D(n2202));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i9 (.Q(mpreg[9]), .C(clk_c), .E(n2315), .D(n2203));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i10 (.Q(mpreg[10]), .C(clk_c), .E(n2315), .D(n2204));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i11 (.Q(mpreg[11]), .C(clk_c), .E(n2315), .D(n2205));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i12 (.Q(mpreg[12]), .C(clk_c), .E(n2315), .D(n2206));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i13 (.Q(mpreg[13]), .C(clk_c), .E(n2315), .D(n2207));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i14 (.Q(mpreg[14]), .C(clk_c), .E(n2315), .D(n2208));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i15 (.Q(mpreg[15]), .C(clk_c), .E(n2315), .D(n2209));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i16 (.Q(mpreg[16]), .C(clk_c), .E(n2315), .D(n2210));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i17 (.Q(mpreg[17]), .C(clk_c), .E(n2315), .D(n2211));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i18 (.Q(mpreg[18]), .C(clk_c), .E(n2315), .D(n2212));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i19 (.Q(mpreg[19]), .C(clk_c), .E(n2315), .D(n2213));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i20 (.Q(mpreg[20]), .C(clk_c), .E(n2315), .D(n2214));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i21 (.Q(mpreg[21]), .C(clk_c), .E(n2315), .D(n2215));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i22 (.Q(mpreg[22]), .C(clk_c), .E(n2315), .D(n2216));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i23 (.Q(mpreg[23]), .C(clk_c), .E(n2315), .D(n2217));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i24 (.Q(mpreg[24]), .C(clk_c), .E(n2315), .D(n2218));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i25 (.Q(mpreg[25]), .C(clk_c), .E(n2315), .D(n2219));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i26 (.Q(mpreg[26]), .C(clk_c), .E(n2315), .D(n2220));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i27 (.Q(mpreg[27]), .C(clk_c), .E(n2315), .D(n2221));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i28 (.Q(mpreg[28]), .C(clk_c), .E(n2315), .D(n2222));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i29 (.Q(mpreg[29]), .C(clk_c), .E(n2315), .D(n2223));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i30 (.Q(mpreg[30]), .C(clk_c), .E(n2315), .D(n2224));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i1 (.Q(mcreg[1]), .C(clk_c), .E(n2315), .D(n2233));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_275_i11_3_lut (.I0(prodreg3_c[10]), .I1(n2948), .I2(prodreg3[33]), 
            .I3(GND_net), .O(\square[10] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_275_i11_3_lut.LUT_INIT = 16'hcaca;
    SB_DFF modreg1__i32 (.Q(modreg1[31]), .C(clk_c), .D(n3889));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i31 (.Q(modreg1[30]), .C(clk_c), .D(n3888));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i30 (.Q(modreg1[29]), .C(clk_c), .D(n3887));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i29 (.Q(modreg1[28]), .C(clk_c), .D(n3886));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i28 (.Q(modreg1[27]), .C(clk_c), .D(n3885));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i27 (.Q(modreg1[26]), .C(clk_c), .D(n3884));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i26 (.Q(modreg1[25]), .C(clk_c), .D(n3883));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i25 (.Q(modreg1[24]), .C(clk_c), .D(n3882));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i24 (.Q(modreg1[23]), .C(clk_c), .D(n3881));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i23 (.Q(modreg1[22]), .C(clk_c), .D(n3880));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i22 (.Q(modreg1[21]), .C(clk_c), .D(n3879));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i21 (.Q(modreg1[20]), .C(clk_c), .D(n3878));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i20 (.Q(modreg1[19]), .C(clk_c), .D(n3877));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i19 (.Q(modreg1[18]), .C(clk_c), .D(n3876));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i18 (.Q(modreg1[17]), .C(clk_c), .D(n3875));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i17 (.Q(modreg1[16]), .C(clk_c), .D(n3874));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i16 (.Q(modreg1[15]), .C(clk_c), .D(n3873));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i15 (.Q(modreg1[14]), .C(clk_c), .D(n3872));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i14 (.Q(modreg1[13]), .C(clk_c), .D(n3871));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i13 (.Q(modreg1[12]), .C(clk_c), .D(n3870));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i12 (.Q(modreg1[11]), .C(clk_c), .D(n3869));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i11 (.Q(modreg1[10]), .C(clk_c), .D(n3868));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i10 (.Q(modreg1[9]), .C(clk_c), .D(n3867));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i9 (.Q(modreg1[8]), .C(clk_c), .D(n3866));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i8 (.Q(modreg1[7]), .C(clk_c), .D(n3865));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i7 (.Q(modreg1[6]), .C(clk_c), .D(n3864));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i2 (.Q(mcreg[2]), .C(clk_c), .E(n2315), .D(n2234));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i3 (.Q(mcreg[3]), .C(clk_c), .E(n2315), .D(n2235));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i4 (.Q(mcreg[4]), .C(clk_c), .E(n2315), .D(n2236));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i5 (.Q(mcreg[5]), .C(clk_c), .E(n2315), .D(n2237));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i6 (.Q(mcreg[6]), .C(clk_c), .E(n2315), .D(n2238));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i7 (.Q(mcreg[7]), .C(clk_c), .E(n2315), .D(n2239));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i8 (.Q(mcreg[8]), .C(clk_c), .E(n2315), .D(n2240));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i9 (.Q(mcreg[9]), .C(clk_c), .E(n2315), .D(n2241));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i10 (.Q(mcreg[10]), .C(clk_c), .E(n2315), .D(n2242));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i11 (.Q(mcreg[11]), .C(clk_c), .E(n2315), .D(n2243));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i12 (.Q(mcreg[12]), .C(clk_c), .E(n2315), .D(n2244));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i13 (.Q(mcreg[13]), .C(clk_c), .E(n2315), .D(n2245));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i14 (.Q(mcreg[14]), .C(clk_c), .E(n2315), .D(n2246));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i15 (.Q(mcreg[15]), .C(clk_c), .E(n2315), .D(n2247));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i16 (.Q(mcreg[16]), .C(clk_c), .E(n2315), .D(n2248));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i17 (.Q(mcreg[17]), .C(clk_c), .E(n2315), .D(n2249));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i18 (.Q(mcreg[18]), .C(clk_c), .E(n2315), .D(n2250));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i19 (.Q(mcreg[19]), .C(clk_c), .E(n2315), .D(n2251));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i20 (.Q(mcreg[20]), .C(clk_c), .E(n2315), .D(n2252));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i21 (.Q(mcreg[21]), .C(clk_c), .E(n2315), .D(n2253));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i22 (.Q(mcreg[22]), .C(clk_c), .E(n2315), .D(n2254));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i23 (.Q(mcreg[23]), .C(clk_c), .E(n2315), .D(n2255));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i24 (.Q(mcreg[24]), .C(clk_c), .E(n2315), .D(n2256));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i25 (.Q(mcreg[25]), .C(clk_c), .E(n2315), .D(n2257));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i26 (.Q(mcreg[26]), .C(clk_c), .E(n2315), .D(n2258));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i27 (.Q(mcreg[27]), .C(clk_c), .E(n2315), .D(n2259));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i28 (.Q(mcreg[28]), .C(clk_c), .E(n2315), .D(n2260));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i29 (.Q(mcreg[29]), .C(clk_c), .E(n2315), .D(n2261));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i30 (.Q(mcreg[30]), .C(clk_c), .E(n2315), .D(n2262));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i31 (.Q(mcreg[31]), .C(clk_c), .E(n2315), .D(n2263));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i6 (.Q(modreg1[5]), .C(clk_c), .D(n3863));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i5 (.Q(modreg1[4]), .C(clk_c), .D(n3862));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i4 (.Q(modreg1[3]), .C(clk_c), .D(n3861));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i3 (.Q(modreg1[2]), .C(clk_c), .D(n3860));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i2 (.Q(modreg1[1]), .C(clk_c), .D(n3859));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 i524_3_lut (.I0(prodreg1[9]), .I1(prodreg2[9]), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n2947));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i524_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_275_i10_3_lut (.I0(prodreg3_c[9]), .I1(n2947), .I2(prodreg3[33]), 
            .I3(GND_net), .O(\square[9] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_275_i10_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i523_3_lut (.I0(prodreg1[8]), .I1(prodreg2[8]), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n2946));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i523_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_275_i9_3_lut (.I0(prodreg3_c[8]), .I1(n2946), .I2(prodreg3[33]), 
            .I3(GND_net), .O(\square[8] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_275_i9_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 sub_88_add_2_35_lut (.I0(GND_net), .I1(prodreg1[33]), .I2(VCC_net), 
            .I3(n5427), .O(\prodreg2[33] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_35_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_88_add_2_34_lut (.I0(GND_net), .I1(prodreg1[32]), .I2(VCC_net), 
            .I3(n5426), .O(prodreg2[32])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_34_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_34 (.CI(n5426), .I0(prodreg1[32]), .I1(VCC_net), 
            .CO(n5427));
    SB_LUT4 sub_88_add_2_33_lut (.I0(GND_net), .I1(prodreg1[31]), .I2(n1[32]), 
            .I3(n5425), .O(prodreg2[31])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_33_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_33 (.CI(n5425), .I0(prodreg1[31]), .I1(n1[32]), 
            .CO(n5426));
    SB_LUT4 sub_88_add_2_32_lut (.I0(GND_net), .I1(prodreg1[30]), .I2(n1[31]), 
            .I3(n5424), .O(prodreg2[30])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_32_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_32 (.CI(n5424), .I0(prodreg1[30]), .I1(n1[31]), 
            .CO(n5425));
    SB_LUT4 sub_88_add_2_31_lut (.I0(GND_net), .I1(\prodreg1[29] ), .I2(n1[30]), 
            .I3(n5423), .O(\prodreg2[29] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_31_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_31 (.CI(n5423), .I0(\prodreg1[29] ), .I1(n1[30]), 
            .CO(n5424));
    SB_LUT4 sub_88_add_2_30_lut (.I0(GND_net), .I1(\prodreg1[28] ), .I2(n1[29]), 
            .I3(n5422), .O(\prodreg2[28] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_30_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_30 (.CI(n5422), .I0(\prodreg1[28] ), .I1(n1[29]), 
            .CO(n5423));
    SB_LUT4 sub_88_add_2_29_lut (.I0(GND_net), .I1(\prodreg1[27] ), .I2(n1[28]), 
            .I3(n5421), .O(\prodreg2[27] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_29_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_29 (.CI(n5421), .I0(\prodreg1[27] ), .I1(n1[28]), 
            .CO(n5422));
    SB_LUT4 sub_88_add_2_28_lut (.I0(GND_net), .I1(\prodreg1[26] ), .I2(n1[27]), 
            .I3(n5420), .O(\prodreg2[26] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_28_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_28 (.CI(n5420), .I0(\prodreg1[26] ), .I1(n1[27]), 
            .CO(n5421));
    SB_LUT4 sub_88_add_2_27_lut (.I0(GND_net), .I1(\prodreg1[25] ), .I2(n1[26]), 
            .I3(n5419), .O(\prodreg2[25] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_27_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_27 (.CI(n5419), .I0(\prodreg1[25] ), .I1(n1[26]), 
            .CO(n5420));
    SB_LUT4 sub_88_add_2_26_lut (.I0(GND_net), .I1(\prodreg1[24] ), .I2(n1[25]), 
            .I3(n5418), .O(\prodreg2[24] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_26_lut.LUT_INIT = 16'hC33C;
    SB_DFF modreg1__i1 (.Q(modreg1[0]), .C(clk_c), .D(n3827));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 add_283_35_lut (.I0(GND_net), .I1(prodreg[33]), .I2(n2790[33]), 
            .I3(n5329), .O(prodreg1[33])) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_35_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_283_34_lut (.I0(GND_net), .I1(prodreg[32]), .I2(n2790[32]), 
            .I3(n5328), .O(prodreg1[32])) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_34_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_34 (.CI(n5328), .I0(prodreg[32]), .I1(n2790[32]), 
            .CO(n5329));
    SB_LUT4 add_283_33_lut (.I0(GND_net), .I1(\prodreg[31] ), .I2(n2790[31]), 
            .I3(n5327), .O(prodreg1[31])) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_33_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_33 (.CI(n5327), .I0(\prodreg[31] ), .I1(n2790[31]), 
            .CO(n5328));
    SB_LUT4 add_283_32_lut (.I0(GND_net), .I1(\prodreg[30] ), .I2(n2790[30]), 
            .I3(n5326), .O(prodreg1[30])) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_32_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_32 (.CI(n5326), .I0(\prodreg[30] ), .I1(n2790[30]), 
            .CO(n5327));
    SB_LUT4 add_283_31_lut (.I0(GND_net), .I1(\prodreg[29] ), .I2(n2790[29]), 
            .I3(n5325), .O(\prodreg1[29] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_31_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_31 (.CI(n5325), .I0(\prodreg[29] ), .I1(n2790[29]), 
            .CO(n5326));
    SB_LUT4 add_283_30_lut (.I0(GND_net), .I1(\prodreg[28] ), .I2(n2790[28]), 
            .I3(n5324), .O(\prodreg1[28] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_30_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_30 (.CI(n5324), .I0(\prodreg[28] ), .I1(n2790[28]), 
            .CO(n5325));
    SB_CARRY sub_88_add_2_26 (.CI(n5418), .I0(\prodreg1[24] ), .I1(n1[25]), 
            .CO(n5419));
    SB_LUT4 sub_88_add_2_25_lut (.I0(GND_net), .I1(\prodreg1[23] ), .I2(n1[24]), 
            .I3(n5417), .O(\prodreg2[23] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_25_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_25 (.CI(n5417), .I0(\prodreg1[23] ), .I1(n1[24]), 
            .CO(n5418));
    SB_LUT4 sub_88_add_2_24_lut (.I0(GND_net), .I1(\prodreg1[22] ), .I2(n1[23]), 
            .I3(n5416), .O(\prodreg2[22] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_24_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_24 (.CI(n5416), .I0(\prodreg1[22] ), .I1(n1[23]), 
            .CO(n5417));
    SB_LUT4 sub_88_add_2_23_lut (.I0(GND_net), .I1(\prodreg1[21] ), .I2(n1[22]), 
            .I3(n5415), .O(\prodreg2[21] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_23_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_23 (.CI(n5415), .I0(\prodreg1[21] ), .I1(n1[22]), 
            .CO(n5416));
    SB_LUT4 sub_88_add_2_22_lut (.I0(GND_net), .I1(\prodreg1[20] ), .I2(n1[21]), 
            .I3(n5414), .O(\prodreg2[20] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_22_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_22 (.CI(n5414), .I0(\prodreg1[20] ), .I1(n1[21]), 
            .CO(n5415));
    SB_LUT4 sub_88_add_2_21_lut (.I0(GND_net), .I1(\prodreg1[19] ), .I2(n1[20]), 
            .I3(n5413), .O(\prodreg2[19] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_21_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_21 (.CI(n5413), .I0(\prodreg1[19] ), .I1(n1[20]), 
            .CO(n5414));
    SB_LUT4 sub_88_add_2_20_lut (.I0(GND_net), .I1(\prodreg1[18] ), .I2(n1[19]), 
            .I3(n5412), .O(\prodreg2[18] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_20_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_20 (.CI(n5412), .I0(\prodreg1[18] ), .I1(n1[19]), 
            .CO(n5413));
    SB_LUT4 sub_88_add_2_19_lut (.I0(GND_net), .I1(\prodreg1[17] ), .I2(n1[18]), 
            .I3(n5411), .O(\prodreg2[17] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_19_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_19 (.CI(n5411), .I0(\prodreg1[17] ), .I1(n1[18]), 
            .CO(n5412));
    SB_LUT4 sub_88_add_2_18_lut (.I0(GND_net), .I1(\prodreg1[16] ), .I2(n1[17]), 
            .I3(n5410), .O(\prodreg2[16] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_18_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_18 (.CI(n5410), .I0(\prodreg1[16] ), .I1(n1[17]), 
            .CO(n5411));
    SB_LUT4 sub_88_add_2_17_lut (.I0(GND_net), .I1(\prodreg1[15] ), .I2(n1[16]), 
            .I3(n5409), .O(\prodreg2[15] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_17_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_17 (.CI(n5409), .I0(\prodreg1[15] ), .I1(n1[16]), 
            .CO(n5410));
    SB_LUT4 add_283_29_lut (.I0(GND_net), .I1(\prodreg[27] ), .I2(n2790[27]), 
            .I3(n5323), .O(\prodreg1[27] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_29_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_88_add_2_16_lut (.I0(GND_net), .I1(\prodreg1[14] ), .I2(n1[15]), 
            .I3(n5408), .O(\prodreg2[14] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_16_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_16 (.CI(n5408), .I0(\prodreg1[14] ), .I1(n1[15]), 
            .CO(n5409));
    SB_LUT4 sub_88_add_2_15_lut (.I0(GND_net), .I1(\prodreg1[13] ), .I2(n1[14]), 
            .I3(n5407), .O(\prodreg2[13] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_15_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_15 (.CI(n5407), .I0(\prodreg1[13] ), .I1(n1[14]), 
            .CO(n5408));
    SB_LUT4 sub_88_add_2_14_lut (.I0(GND_net), .I1(\prodreg1[12] ), .I2(n1[13]), 
            .I3(n5406), .O(\prodreg2[12] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_14_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_14 (.CI(n5406), .I0(\prodreg1[12] ), .I1(n1[13]), 
            .CO(n5407));
    SB_LUT4 sub_88_add_2_13_lut (.I0(GND_net), .I1(\prodreg1[11] ), .I2(n1[12]), 
            .I3(n5405), .O(\prodreg2[11] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_13_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_13 (.CI(n5405), .I0(\prodreg1[11] ), .I1(n1[12]), 
            .CO(n5406));
    SB_LUT4 sub_88_add_2_12_lut (.I0(GND_net), .I1(prodreg1[10]), .I2(n1[11]), 
            .I3(n5404), .O(prodreg2[10])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_12_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_12 (.CI(n5404), .I0(prodreg1[10]), .I1(n1[11]), 
            .CO(n5405));
    SB_LUT4 sub_88_add_2_11_lut (.I0(GND_net), .I1(prodreg1[9]), .I2(n1[10]), 
            .I3(n5403), .O(prodreg2[9])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_11_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_11 (.CI(n5403), .I0(prodreg1[9]), .I1(n1[10]), 
            .CO(n5404));
    SB_LUT4 sub_88_add_2_10_lut (.I0(GND_net), .I1(prodreg1[8]), .I2(n1[9]), 
            .I3(n5402), .O(prodreg2[8])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_10_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_10 (.CI(n5402), .I0(prodreg1[8]), .I1(n1[9]), 
            .CO(n5403));
    SB_LUT4 sub_88_add_2_9_lut (.I0(GND_net), .I1(prodreg1[7]), .I2(n1[8]), 
            .I3(n5401), .O(prodreg2[7])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_9_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_9 (.CI(n5401), .I0(prodreg1[7]), .I1(n1[8]), 
            .CO(n5402));
    SB_LUT4 sub_88_add_2_8_lut (.I0(GND_net), .I1(prodreg1[6]), .I2(n1[7]), 
            .I3(n5400), .O(prodreg2[6])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_8_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_8 (.CI(n5400), .I0(prodreg1[6]), .I1(n1[7]), 
            .CO(n5401));
    SB_LUT4 sub_88_add_2_7_lut (.I0(GND_net), .I1(prodreg1[5]), .I2(n1[6]), 
            .I3(n5399), .O(prodreg2[5])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_7_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_7 (.CI(n5399), .I0(prodreg1[5]), .I1(n1[6]), 
            .CO(n5400));
    SB_LUT4 sub_88_add_2_6_lut (.I0(GND_net), .I1(prodreg1[4]), .I2(n1[5]), 
            .I3(n5398), .O(prodreg2[4])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_6_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_6 (.CI(n5398), .I0(prodreg1[4]), .I1(n1[5]), 
            .CO(n5399));
    SB_LUT4 sub_88_add_2_5_lut (.I0(GND_net), .I1(prodreg1[3]), .I2(n1[4]), 
            .I3(n5397), .O(prodreg2[3])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_5_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_5 (.CI(n5397), .I0(prodreg1[3]), .I1(n1[4]), 
            .CO(n5398));
    SB_LUT4 sub_88_add_2_4_lut (.I0(GND_net), .I1(prodreg1[2]), .I2(n1[3]), 
            .I3(n5396), .O(prodreg2[2])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_4_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_4 (.CI(n5396), .I0(prodreg1[2]), .I1(n1[3]), 
            .CO(n5397));
    SB_LUT4 sub_88_add_2_3_lut (.I0(GND_net), .I1(prodreg1[1]), .I2(n1[2]), 
            .I3(n5395), .O(prodreg2[1])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_3_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_3 (.CI(n5395), .I0(prodreg1[1]), .I1(n1[2]), 
            .CO(n5396));
    SB_LUT4 sub_88_add_2_2_lut (.I0(GND_net), .I1(prodreg3_c[0]), .I2(n1[1]), 
            .I3(VCC_net), .O(prodreg2[0])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_88_add_2_2_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_88_add_2_2 (.CI(VCC_net), .I0(prodreg3_c[0]), .I1(n1[1]), 
            .CO(n5395));
    SB_LUT4 sub_95_add_2_34_lut (.I0(GND_net), .I1(mcreg[32]), .I2(VCC_net), 
            .I3(n5394), .O(mcreg1[32])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_34_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_95_add_2_33_lut (.I0(GND_net), .I1(mcreg[31]), .I2(n1[32]), 
            .I3(n5393), .O(mcreg1[31])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_33_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_33 (.CI(n5393), .I0(mcreg[31]), .I1(n1[32]), 
            .CO(n5394));
    SB_LUT4 sub_95_add_2_32_lut (.I0(GND_net), .I1(mcreg[30]), .I2(n1[31]), 
            .I3(n5392), .O(mcreg1[30])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_32_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_32 (.CI(n5392), .I0(mcreg[30]), .I1(n1[31]), 
            .CO(n5393));
    SB_LUT4 sub_95_add_2_31_lut (.I0(GND_net), .I1(mcreg[29]), .I2(n1[30]), 
            .I3(n5391), .O(mcreg1[29])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_31_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_31 (.CI(n5391), .I0(mcreg[29]), .I1(n1[30]), 
            .CO(n5392));
    SB_LUT4 sub_95_add_2_30_lut (.I0(GND_net), .I1(mcreg[28]), .I2(n1[29]), 
            .I3(n5390), .O(mcreg1[28])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_30_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_30 (.CI(n5390), .I0(mcreg[28]), .I1(n1[29]), 
            .CO(n5391));
    SB_LUT4 sub_95_add_2_29_lut (.I0(GND_net), .I1(mcreg[27]), .I2(n1[28]), 
            .I3(n5389), .O(mcreg1[27])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_29_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_29 (.CI(n5389), .I0(mcreg[27]), .I1(n1[28]), 
            .CO(n5390));
    SB_LUT4 sub_95_add_2_28_lut (.I0(GND_net), .I1(mcreg[26]), .I2(n1[27]), 
            .I3(n5388), .O(mcreg1[26])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_28_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_28 (.CI(n5388), .I0(mcreg[26]), .I1(n1[27]), 
            .CO(n5389));
    SB_LUT4 sub_95_add_2_27_lut (.I0(GND_net), .I1(mcreg[25]), .I2(n1[26]), 
            .I3(n5387), .O(mcreg1[25])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_27_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_27 (.CI(n5387), .I0(mcreg[25]), .I1(n1[26]), 
            .CO(n5388));
    SB_LUT4 sub_95_add_2_26_lut (.I0(GND_net), .I1(mcreg[24]), .I2(n1[25]), 
            .I3(n5386), .O(mcreg1[24])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_26_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_26 (.CI(n5386), .I0(mcreg[24]), .I1(n1[25]), 
            .CO(n5387));
    SB_LUT4 sub_95_add_2_25_lut (.I0(GND_net), .I1(mcreg[23]), .I2(n1[24]), 
            .I3(n5385), .O(mcreg1[23])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_25_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_25 (.CI(n5385), .I0(mcreg[23]), .I1(n1[24]), 
            .CO(n5386));
    SB_LUT4 sub_95_add_2_24_lut (.I0(GND_net), .I1(mcreg[22]), .I2(n1[23]), 
            .I3(n5384), .O(mcreg1[22])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_24_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_24 (.CI(n5384), .I0(mcreg[22]), .I1(n1[23]), 
            .CO(n5385));
    SB_LUT4 sub_95_add_2_23_lut (.I0(GND_net), .I1(mcreg[21]), .I2(n1[22]), 
            .I3(n5383), .O(mcreg1[21])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_23_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_23 (.CI(n5383), .I0(mcreg[21]), .I1(n1[22]), 
            .CO(n5384));
    SB_LUT4 sub_95_add_2_22_lut (.I0(GND_net), .I1(mcreg[20]), .I2(n1[21]), 
            .I3(n5382), .O(mcreg1[20])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_22_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_22 (.CI(n5382), .I0(mcreg[20]), .I1(n1[21]), 
            .CO(n5383));
    SB_LUT4 sub_95_add_2_21_lut (.I0(GND_net), .I1(mcreg[19]), .I2(n1[20]), 
            .I3(n5381), .O(mcreg1[19])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_21_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_21 (.CI(n5381), .I0(mcreg[19]), .I1(n1[20]), 
            .CO(n5382));
    SB_LUT4 sub_95_add_2_20_lut (.I0(GND_net), .I1(mcreg[18]), .I2(n1[19]), 
            .I3(n5380), .O(mcreg1[18])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_20_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_20 (.CI(n5380), .I0(mcreg[18]), .I1(n1[19]), 
            .CO(n5381));
    SB_LUT4 sub_95_add_2_19_lut (.I0(GND_net), .I1(mcreg[17]), .I2(n1[18]), 
            .I3(n5379), .O(mcreg1[17])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_19_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_19 (.CI(n5379), .I0(mcreg[17]), .I1(n1[18]), 
            .CO(n5380));
    SB_LUT4 sub_95_add_2_18_lut (.I0(GND_net), .I1(mcreg[16]), .I2(n1[17]), 
            .I3(n5378), .O(mcreg1[16])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_18_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_18 (.CI(n5378), .I0(mcreg[16]), .I1(n1[17]), 
            .CO(n5379));
    SB_LUT4 sub_95_add_2_17_lut (.I0(GND_net), .I1(mcreg[15]), .I2(n1[16]), 
            .I3(n5377), .O(mcreg1[15])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_17_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_17 (.CI(n5377), .I0(mcreg[15]), .I1(n1[16]), 
            .CO(n5378));
    SB_LUT4 sub_95_add_2_16_lut (.I0(GND_net), .I1(mcreg[14]), .I2(n1[15]), 
            .I3(n5376), .O(mcreg1[14])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_16_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_16 (.CI(n5376), .I0(mcreg[14]), .I1(n1[15]), 
            .CO(n5377));
    SB_LUT4 sub_95_add_2_15_lut (.I0(GND_net), .I1(mcreg[13]), .I2(n1[14]), 
            .I3(n5375), .O(mcreg1[13])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_15_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_15 (.CI(n5375), .I0(mcreg[13]), .I1(n1[14]), 
            .CO(n5376));
    SB_LUT4 sub_95_add_2_14_lut (.I0(GND_net), .I1(mcreg[12]), .I2(n1[13]), 
            .I3(n5374), .O(mcreg1[12])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_14_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_14 (.CI(n5374), .I0(mcreg[12]), .I1(n1[13]), 
            .CO(n5375));
    SB_LUT4 sub_95_add_2_13_lut (.I0(GND_net), .I1(mcreg[11]), .I2(n1[12]), 
            .I3(n5373), .O(mcreg1[11])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_13_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_13 (.CI(n5373), .I0(mcreg[11]), .I1(n1[12]), 
            .CO(n5374));
    SB_LUT4 sub_95_add_2_12_lut (.I0(GND_net), .I1(mcreg[10]), .I2(n1[11]), 
            .I3(n5372), .O(mcreg1[10])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_12_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_12 (.CI(n5372), .I0(mcreg[10]), .I1(n1[11]), 
            .CO(n5373));
    SB_LUT4 sub_95_add_2_11_lut (.I0(GND_net), .I1(mcreg[9]), .I2(n1[10]), 
            .I3(n5371), .O(mcreg1[9])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_11_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_11 (.CI(n5371), .I0(mcreg[9]), .I1(n1[10]), 
            .CO(n5372));
    SB_LUT4 sub_95_add_2_10_lut (.I0(GND_net), .I1(mcreg[8]), .I2(n1[9]), 
            .I3(n5370), .O(mcreg1[8])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_10_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_10 (.CI(n5370), .I0(mcreg[8]), .I1(n1[9]), .CO(n5371));
    SB_LUT4 sub_95_add_2_9_lut (.I0(GND_net), .I1(mcreg[7]), .I2(n1[8]), 
            .I3(n5369), .O(mcreg1[7])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_9_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_9 (.CI(n5369), .I0(mcreg[7]), .I1(n1[8]), .CO(n5370));
    SB_LUT4 sub_95_add_2_8_lut (.I0(GND_net), .I1(mcreg[6]), .I2(n1[7]), 
            .I3(n5368), .O(mcreg1[6])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_8_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_8 (.CI(n5368), .I0(mcreg[6]), .I1(n1[7]), .CO(n5369));
    SB_LUT4 sub_95_add_2_7_lut (.I0(GND_net), .I1(mcreg[5]), .I2(n1[6]), 
            .I3(n5367), .O(mcreg1[5])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_7_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_29 (.CI(n5323), .I0(\prodreg[27] ), .I1(n2790[27]), 
            .CO(n5324));
    SB_LUT4 add_283_28_lut (.I0(GND_net), .I1(\prodreg[26] ), .I2(n2790[26]), 
            .I3(n5322), .O(\prodreg1[26] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_28_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_28 (.CI(n5322), .I0(\prodreg[26] ), .I1(n2790[26]), 
            .CO(n5323));
    SB_LUT4 add_283_27_lut (.I0(GND_net), .I1(\prodreg[25] ), .I2(n2790[25]), 
            .I3(n5321), .O(\prodreg1[25] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_27_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_27 (.CI(n5321), .I0(\prodreg[25] ), .I1(n2790[25]), 
            .CO(n5322));
    SB_LUT4 add_283_26_lut (.I0(GND_net), .I1(\prodreg[24] ), .I2(n2790[24]), 
            .I3(n5320), .O(\prodreg1[24] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_26_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_26 (.CI(n5320), .I0(\prodreg[24] ), .I1(n2790[24]), 
            .CO(n5321));
    SB_DFFE prodreg__i0 (.Q(\prodreg[0] ), .C(clk_c), .E(VCC_net), .D(n4111));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_CARRY sub_95_add_2_7 (.CI(n5367), .I0(mcreg[5]), .I1(n1[6]), .CO(n5368));
    SB_DFFE prodreg__i31 (.Q(\prodreg[31] ), .C(clk_c), .E(VCC_net), .D(n4103));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i30 (.Q(\prodreg[30] ), .C(clk_c), .E(VCC_net), .D(n4100));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i29 (.Q(\prodreg[29] ), .C(clk_c), .E(VCC_net), .D(n4096));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i28 (.Q(\prodreg[28] ), .C(clk_c), .E(VCC_net), .D(n4093));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i27 (.Q(\prodreg[27] ), .C(clk_c), .E(VCC_net), .D(n4090));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i26 (.Q(\prodreg[26] ), .C(clk_c), .E(VCC_net), .D(n4086));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i25 (.Q(\prodreg[25] ), .C(clk_c), .E(VCC_net), .D(n4083));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 i522_3_lut (.I0(prodreg1[7]), .I1(prodreg2[7]), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n2945));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i522_3_lut.LUT_INIT = 16'hacac;
    SB_DFFE prodreg__i24 (.Q(\prodreg[24] ), .C(clk_c), .E(VCC_net), .D(n4080));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 sub_89_inv_0_i25_1_lut (.I0(modreg1[23]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[24]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i25_1_lut.LUT_INIT = 16'h5555;
    SB_DFFE prodreg__i23 (.Q(\prodreg[23] ), .C(clk_c), .E(VCC_net), .D(n4076));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i22 (.Q(\prodreg[22] ), .C(clk_c), .E(VCC_net), .D(n4073));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i21 (.Q(\prodreg[21] ), .C(clk_c), .E(VCC_net), .D(n4070));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_275_i8_3_lut (.I0(prodreg3_c[7]), .I1(n2945), .I2(prodreg3[33]), 
            .I3(GND_net), .O(\square[7] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_275_i8_3_lut.LUT_INIT = 16'hcaca;
    SB_DFFE mcreg_i0_i0 (.Q(\mcreg[0] ), .C(clk_c), .E(VCC_net), .D(n5724));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i20 (.Q(\prodreg[20] ), .C(clk_c), .E(VCC_net), .D(n4063));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 sub_89_inv_0_i26_1_lut (.I0(modreg1[24]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[25]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i26_1_lut.LUT_INIT = 16'h5555;
    SB_DFFE prodreg__i19 (.Q(\prodreg[19] ), .C(clk_c), .E(VCC_net), .D(n4059));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i18 (.Q(\prodreg[18] ), .C(clk_c), .E(VCC_net), .D(n4056));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 sub_89_inv_0_i27_1_lut (.I0(modreg1[25]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[26]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i27_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_89_inv_0_i28_1_lut (.I0(modreg1[26]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[27]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i28_1_lut.LUT_INIT = 16'h5555;
    SB_DFFE prodreg__i17 (.Q(\prodreg[17] ), .C(clk_c), .E(VCC_net), .D(n4049));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i16 (.Q(\prodreg[16] ), .C(clk_c), .E(VCC_net), .D(n4046));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i15 (.Q(\prodreg[15] ), .C(clk_c), .E(VCC_net), .D(n4043));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 i521_3_lut (.I0(prodreg1[6]), .I1(prodreg2[6]), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n2944));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i521_3_lut.LUT_INIT = 16'hacac;
    SB_DFFE prodreg__i14 (.Q(\prodreg[14] ), .C(clk_c), .E(VCC_net), .D(n4039));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i13 (.Q(\prodreg[13] ), .C(clk_c), .E(VCC_net), .D(n4036));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 sub_89_inv_0_i29_1_lut (.I0(modreg1[27]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[28]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i29_1_lut.LUT_INIT = 16'h5555;
    SB_DFFE prodreg__i12 (.Q(\prodreg[12] ), .C(clk_c), .E(VCC_net), .D(n4033));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 sub_89_inv_0_i30_1_lut (.I0(modreg1[28]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[29]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i30_1_lut.LUT_INIT = 16'h5555;
    SB_DFFE prodreg__i11 (.Q(\prodreg[11] ), .C(clk_c), .E(VCC_net), .D(n4029));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i10 (.Q(\prodreg[10] ), .C(clk_c), .E(VCC_net), .D(n4026));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_275_i7_3_lut (.I0(prodreg3_c[6]), .I1(n2944), .I2(prodreg3[33]), 
            .I3(GND_net), .O(\square[6] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_275_i7_3_lut.LUT_INIT = 16'hcaca;
    SB_DFFE prodreg__i9 (.Q(\prodreg[9] ), .C(clk_c), .E(VCC_net), .D(n4023));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i8 (.Q(\prodreg[8] ), .C(clk_c), .E(VCC_net), .D(n4019));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i7 (.Q(\prodreg[7] ), .C(clk_c), .E(VCC_net), .D(n4016));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 sub_89_inv_0_i31_1_lut (.I0(modreg1[29]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[30]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i31_1_lut.LUT_INIT = 16'h5555;
    SB_DFFE prodreg__i6 (.Q(\prodreg[6] ), .C(clk_c), .E(VCC_net), .D(n4013));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 sub_89_inv_0_i32_1_lut (.I0(modreg1[30]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[31]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i32_1_lut.LUT_INIT = 16'h5555;
    SB_DFFE prodreg__i5 (.Q(\prodreg[5] ), .C(clk_c), .E(VCC_net), .D(n4009));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i4 (.Q(\prodreg[4] ), .C(clk_c), .E(VCC_net), .D(n4006));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i3 (.Q(\prodreg[3] ), .C(clk_c), .E(VCC_net), .D(n4003));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 i520_3_lut (.I0(prodreg1[5]), .I1(prodreg2[5]), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n2943));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i520_3_lut.LUT_INIT = 16'hacac;
    SB_DFFE prodreg__i2 (.Q(\prodreg[2] ), .C(clk_c), .E(VCC_net), .D(n3999));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i1 (.Q(\prodreg[1] ), .C(clk_c), .E(VCC_net), .D(n3996));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 sub_89_inv_0_i33_1_lut (.I0(modreg1[31]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[32]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_89_inv_0_i33_1_lut.LUT_INIT = 16'h5555;
    SB_DFFE mpreg_i0_i31 (.Q(\mpreg[31] ), .C(clk_c), .E(VCC_net), .D(n5726));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_275_i6_3_lut (.I0(prodreg3_c[5]), .I1(n2943), .I2(prodreg3[33]), 
            .I3(GND_net), .O(\square[5] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_275_i6_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 add_283_25_lut (.I0(GND_net), .I1(\prodreg[23] ), .I2(n2790[23]), 
            .I3(n5319), .O(\prodreg1[23] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_25_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_25 (.CI(n5319), .I0(\prodreg[23] ), .I1(n2790[23]), 
            .CO(n5320));
    SB_LUT4 add_283_24_lut (.I0(GND_net), .I1(\prodreg[22] ), .I2(n2790[22]), 
            .I3(n5318), .O(\prodreg1[22] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_24_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_24 (.CI(n5318), .I0(\prodreg[22] ), .I1(n2790[22]), 
            .CO(n5319));
    SB_LUT4 add_283_23_lut (.I0(GND_net), .I1(\prodreg[21] ), .I2(n2790[21]), 
            .I3(n5317), .O(\prodreg1[21] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_23_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_23 (.CI(n5317), .I0(\prodreg[21] ), .I1(n2790[21]), 
            .CO(n5318));
    SB_LUT4 add_283_22_lut (.I0(GND_net), .I1(\prodreg[20] ), .I2(n2790[20]), 
            .I3(n5316), .O(\prodreg1[20] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_22_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_22 (.CI(n5316), .I0(\prodreg[20] ), .I1(n2790[20]), 
            .CO(n5317));
    SB_LUT4 add_283_21_lut (.I0(GND_net), .I1(\prodreg[19] ), .I2(n2790[19]), 
            .I3(n5315), .O(\prodreg1[19] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_21_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_21 (.CI(n5315), .I0(\prodreg[19] ), .I1(n2790[19]), 
            .CO(n5316));
    SB_LUT4 add_283_20_lut (.I0(GND_net), .I1(\prodreg[18] ), .I2(n2790[18]), 
            .I3(n5314), .O(\prodreg1[18] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_20_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_20 (.CI(n5314), .I0(\prodreg[18] ), .I1(n2790[18]), 
            .CO(n5315));
    SB_LUT4 add_283_19_lut (.I0(GND_net), .I1(\prodreg[17] ), .I2(n2790[17]), 
            .I3(n5313), .O(\prodreg1[17] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_19_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_19 (.CI(n5313), .I0(\prodreg[17] ), .I1(n2790[17]), 
            .CO(n5314));
    SB_LUT4 add_283_18_lut (.I0(GND_net), .I1(\prodreg[16] ), .I2(n2790[16]), 
            .I3(n5312), .O(\prodreg1[16] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_18_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_18 (.CI(n5312), .I0(\prodreg[16] ), .I1(n2790[16]), 
            .CO(n5313));
    SB_LUT4 add_283_17_lut (.I0(GND_net), .I1(\prodreg[15] ), .I2(n2790[15]), 
            .I3(n5311), .O(\prodreg1[15] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_17_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_17 (.CI(n5311), .I0(\prodreg[15] ), .I1(n2790[15]), 
            .CO(n5312));
    SB_LUT4 add_283_16_lut (.I0(GND_net), .I1(\prodreg[14] ), .I2(n2790[14]), 
            .I3(n5310), .O(\prodreg1[14] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_16_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_16 (.CI(n5310), .I0(\prodreg[14] ), .I1(n2790[14]), 
            .CO(n5311));
    SB_LUT4 add_283_15_lut (.I0(GND_net), .I1(\prodreg[13] ), .I2(n2790[13]), 
            .I3(n5309), .O(\prodreg1[13] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_15_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_15 (.CI(n5309), .I0(\prodreg[13] ), .I1(n2790[13]), 
            .CO(n5310));
    SB_LUT4 add_283_14_lut (.I0(GND_net), .I1(\prodreg[12] ), .I2(n2790[12]), 
            .I3(n5308), .O(\prodreg1[12] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_14_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_14 (.CI(n5308), .I0(\prodreg[12] ), .I1(n2790[12]), 
            .CO(n5309));
    SB_LUT4 add_283_13_lut (.I0(GND_net), .I1(\prodreg[11] ), .I2(n2790[11]), 
            .I3(n5307), .O(\prodreg1[11] )) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_13_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_13 (.CI(n5307), .I0(\prodreg[11] ), .I1(n2790[11]), 
            .CO(n5308));
    SB_LUT4 add_283_12_lut (.I0(GND_net), .I1(\prodreg[10] ), .I2(n2790[10]), 
            .I3(n5306), .O(prodreg1[10])) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_12_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_12 (.CI(n5306), .I0(\prodreg[10] ), .I1(n2790[10]), 
            .CO(n5307));
    SB_LUT4 add_283_11_lut (.I0(GND_net), .I1(\prodreg[9] ), .I2(n2790[9]), 
            .I3(n5305), .O(prodreg1[9])) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_11_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_11 (.CI(n5305), .I0(\prodreg[9] ), .I1(n2790[9]), 
            .CO(n5306));
    SB_LUT4 add_283_10_lut (.I0(GND_net), .I1(\prodreg[8] ), .I2(n2790[8]), 
            .I3(n5304), .O(prodreg1[8])) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_10_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_10 (.CI(n5304), .I0(\prodreg[8] ), .I1(n2790[8]), 
            .CO(n5305));
    SB_LUT4 i519_3_lut (.I0(prodreg1[4]), .I1(prodreg2[4]), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n2942));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i519_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 add_283_9_lut (.I0(GND_net), .I1(\prodreg[7] ), .I2(n2790[7]), 
            .I3(n5303), .O(prodreg1[7])) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_9_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_9 (.CI(n5303), .I0(\prodreg[7] ), .I1(n2790[7]), 
            .CO(n5304));
    SB_LUT4 add_283_8_lut (.I0(GND_net), .I1(\prodreg[6] ), .I2(n2790[6]), 
            .I3(n5302), .O(prodreg1[6])) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_8_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_8 (.CI(n5302), .I0(\prodreg[6] ), .I1(n2790[6]), 
            .CO(n5303));
    SB_LUT4 add_283_7_lut (.I0(GND_net), .I1(\prodreg[5] ), .I2(n2790[5]), 
            .I3(n5301), .O(prodreg1[5])) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_7_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 mux_275_i5_3_lut (.I0(prodreg3_c[4]), .I1(n2942), .I2(prodreg3[33]), 
            .I3(GND_net), .O(\square[4] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_275_i5_3_lut.LUT_INIT = 16'hcaca;
    SB_CARRY add_283_7 (.CI(n5301), .I0(\prodreg[5] ), .I1(n2790[5]), 
            .CO(n5302));
    SB_LUT4 add_283_6_lut (.I0(GND_net), .I1(\prodreg[4] ), .I2(n2790[4]), 
            .I3(n5300), .O(prodreg1[4])) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_6_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_6 (.CI(n5300), .I0(\prodreg[4] ), .I1(n2790[4]), 
            .CO(n5301));
    SB_LUT4 add_283_5_lut (.I0(GND_net), .I1(\prodreg[3] ), .I2(n2790[3]), 
            .I3(n5299), .O(prodreg1[3])) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_5_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_5 (.CI(n5299), .I0(\prodreg[3] ), .I1(n2790[3]), 
            .CO(n5300));
    SB_LUT4 add_283_4_lut (.I0(GND_net), .I1(\prodreg[2] ), .I2(n2790[2]), 
            .I3(n5298), .O(prodreg1[2])) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_4_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_4 (.CI(n5298), .I0(\prodreg[2] ), .I1(n2790[2]), 
            .CO(n5299));
    SB_LUT4 i518_3_lut (.I0(prodreg1[3]), .I1(prodreg2[3]), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n2941));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i518_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 add_283_3_lut (.I0(GND_net), .I1(\prodreg[1] ), .I2(n2790[1]), 
            .I3(n5297), .O(prodreg1[1])) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_3_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_3 (.CI(n5297), .I0(\prodreg[1] ), .I1(n2790[1]), 
            .CO(n5298));
    SB_LUT4 add_283_2_lut (.I0(GND_net), .I1(\prodreg[0] ), .I2(n2790[0]), 
            .I3(GND_net), .O(prodreg3_c[0])) /* synthesis syn_instantiated=1 */ ;
    defparam add_283_2_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_283_2 (.CI(GND_net), .I0(\prodreg[0] ), .I1(n2790[0]), 
            .CO(n5297));
    SB_DFFESR mcreg_i0_i33 (.Q(mcreg[33]), .C(clk_c), .E(n2315), .D(mcreg2[32]), 
            .R(n2915));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 sub_95_add_2_6_lut (.I0(GND_net), .I1(mcreg[4]), .I2(n1[5]), 
            .I3(n5366), .O(mcreg1[4])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_6_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 i517_3_lut (.I0(prodreg1[2]), .I1(prodreg2[2]), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n2940));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i517_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_275_i3_3_lut (.I0(prodreg3_c[2]), .I1(n2940), .I2(prodreg3[33]), 
            .I3(GND_net), .O(\square[2] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_275_i3_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_275_i4_3_lut (.I0(prodreg3_c[3]), .I1(n2941), .I2(prodreg3[33]), 
            .I3(GND_net), .O(\square[3] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_275_i4_3_lut.LUT_INIT = 16'hcaca;
    SB_CARRY sub_95_add_2_6 (.CI(n5366), .I0(mcreg[4]), .I1(n1[5]), .CO(n5367));
    SB_LUT4 sub_95_add_2_5_lut (.I0(GND_net), .I1(mcreg[3]), .I2(n1[4]), 
            .I3(n5365), .O(mcreg1[3])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_5_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_5 (.CI(n5365), .I0(mcreg[3]), .I1(n1[4]), .CO(n5366));
    SB_DFFESR mcreg_i0_i32 (.Q(mcreg[32]), .C(clk_c), .E(n2315), .D(mcreg2[31]), 
            .R(n2915));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 sub_95_add_2_4_lut (.I0(GND_net), .I1(mcreg[2]), .I2(n1[3]), 
            .I3(n5364), .O(mcreg1[2])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_4_lut.LUT_INIT = 16'hC33C;
    SB_DFFESR prodreg__i32 (.Q(prodreg[32]), .C(clk_c), .E(n2315), .D(prodreg4[32]), 
            .R(n2915));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_CARRY sub_95_add_2_4 (.CI(n5364), .I0(mcreg[2]), .I1(n1[3]), .CO(n5365));
    SB_LUT4 sub_95_add_2_3_lut (.I0(GND_net), .I1(mcreg[1]), .I2(n1[2]), 
            .I3(n5363), .O(mcreg1[1])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_3_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_3 (.CI(n5363), .I0(mcreg[1]), .I1(n1[2]), .CO(n5364));
    SB_LUT4 sub_95_add_2_2_lut (.I0(GND_net), .I1(\mcreg[0] ), .I2(n1[1]), 
            .I3(VCC_net), .O(mcreg1[0])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_95_add_2_2_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_95_add_2_2 (.CI(VCC_net), .I0(\mcreg[0] ), .I1(n1[1]), 
            .CO(n5363));
    SB_DFFESR prodreg__i33 (.Q(prodreg[33]), .C(clk_c), .E(n2315), .D(prodreg4[33]), 
            .R(n2915));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 i208_2_lut (.I0(sqrrdy), .I1(multgo), .I2(GND_net), .I3(GND_net), 
            .O(n2193));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam i208_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i24_4_lut (.I0(mpreg[29]), .I1(mpreg[3]), .I2(mpreg[13]), 
            .I3(\mpreg[31] ), .O(n56));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(151[8:17])
    defparam i24_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i22_4_lut (.I0(mpreg[19]), .I1(mpreg[5]), .I2(mpreg[22]), 
            .I3(mpreg[6]), .O(n54));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(151[8:17])
    defparam i22_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i23_4_lut (.I0(mpreg[10]), .I1(mpreg[15]), .I2(mpreg[20]), 
            .I3(mpreg[23]), .O(n55));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(151[8:17])
    defparam i23_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i21_4_lut (.I0(mpreg[27]), .I1(mpreg[7]), .I2(mpreg[30]), 
            .I3(mpreg[14]), .O(n53));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(151[8:17])
    defparam i21_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i20_4_lut (.I0(mpreg[17]), .I1(mpreg[1]), .I2(mpreg[24]), 
            .I3(mpreg[4]), .O(n52));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(151[8:17])
    defparam i20_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i18_4_lut (.I0(mpreg[8]), .I1(mpreg[11]), .I2(mpreg[16]), 
            .I3(mpreg[21]), .O(n50));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(151[8:17])
    defparam i18_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i19_4_lut (.I0(mpreg[25]), .I1(mpreg[9]), .I2(mpreg[26]), 
            .I3(mpreg[12]), .O(n51));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(151[8:17])
    defparam i19_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i3191_4_lut (.I0(mpreg[28]), .I1(mpreg[18]), .I2(mpreg[0]), 
            .I3(mpreg[2]), .O(n5765));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam i3191_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i30_4_lut (.I0(n53), .I1(n55), .I2(n54), .I3(n56), .O(n62));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(151[8:17])
    defparam i30_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i3176_4_lut (.I0(n5765), .I1(n51), .I2(n50), .I3(n52), .O(n5763));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam i3176_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i317_4_lut (.I0(n5763), .I1(multgo), .I2(sqrrdy), .I3(n62), 
            .O(n2268));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam i317_4_lut.LUT_INIT = 16'h3035;
    SB_LUT4 i217_2_lut (.I0(n2268), .I1(reset_c), .I2(GND_net), .I3(GND_net), 
            .O(n2315));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i217_2_lut.LUT_INIT = 16'h1111;
    SB_LUT4 i516_3_lut (.I0(prodreg1[1]), .I1(prodreg2[1]), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n2939));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i516_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_275_i2_3_lut (.I0(prodreg3_c[1]), .I1(n2939), .I2(prodreg3[33]), 
            .I3(GND_net), .O(\square[1] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_275_i2_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i546_3_lut (.I0(prodreg1[31]), .I1(prodreg2[31]), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n2969));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i546_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_275_i32_3_lut (.I0(prodreg3_c[31]), .I1(n2969), .I2(prodreg3[33]), 
            .I3(GND_net), .O(\square[31] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_275_i32_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i545_3_lut (.I0(prodreg1[30]), .I1(prodreg2[30]), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n2968));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i545_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_275_i31_3_lut (.I0(prodreg3_c[30]), .I1(n2968), .I2(prodreg3[33]), 
            .I3(GND_net), .O(\square[30] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_275_i31_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i513_4_lut (.I0(prodreg3_c[0]), .I1(prodreg2[0]), .I2(prodreg3[33]), 
            .I3(\prodreg2[33] ), .O(\square[0] ));
    defparam i513_4_lut.LUT_INIT = 16'haaca;
    SB_LUT4 mux_197_i2_3_lut (.I0(mcreg2[0]), .I1(root[1]), .I2(n2193), 
            .I3(GND_net), .O(n2233));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i2_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i1_3_lut (.I0(mcreg1[0]), .I1(\mcreg[0] ), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[0]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i1_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_190_i31_3_lut_4_lut (.I0(\mpreg[31] ), .I1(root[30]), .I2(sqrrdy), 
            .I3(multgo), .O(n2224));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i31_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i30_3_lut_4_lut (.I0(mpreg[30]), .I1(root[29]), .I2(sqrrdy), 
            .I3(multgo), .O(n2223));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i30_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i29_3_lut_4_lut (.I0(mpreg[29]), .I1(root[28]), .I2(sqrrdy), 
            .I3(multgo), .O(n2222));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i29_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i28_3_lut_4_lut (.I0(mpreg[28]), .I1(root[27]), .I2(sqrrdy), 
            .I3(multgo), .O(n2221));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i28_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i27_3_lut_4_lut (.I0(mpreg[27]), .I1(root[26]), .I2(sqrrdy), 
            .I3(multgo), .O(n2220));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i27_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i26_3_lut_4_lut (.I0(mpreg[26]), .I1(root[25]), .I2(sqrrdy), 
            .I3(multgo), .O(n2219));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i26_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i25_3_lut_4_lut (.I0(mpreg[25]), .I1(root[24]), .I2(sqrrdy), 
            .I3(multgo), .O(n2218));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i25_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i24_3_lut_4_lut (.I0(mpreg[24]), .I1(root[23]), .I2(sqrrdy), 
            .I3(multgo), .O(n2217));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i24_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i23_3_lut_4_lut (.I0(mpreg[23]), .I1(root[22]), .I2(sqrrdy), 
            .I3(multgo), .O(n2216));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i23_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i22_3_lut_4_lut (.I0(mpreg[22]), .I1(root[21]), .I2(sqrrdy), 
            .I3(multgo), .O(n2215));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i22_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i21_3_lut_4_lut (.I0(mpreg[21]), .I1(root[20]), .I2(sqrrdy), 
            .I3(multgo), .O(n2214));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i21_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i20_3_lut_4_lut (.I0(mpreg[20]), .I1(root[19]), .I2(sqrrdy), 
            .I3(multgo), .O(n2213));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i20_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i19_3_lut_4_lut (.I0(mpreg[19]), .I1(root[18]), .I2(sqrrdy), 
            .I3(multgo), .O(n2212));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i19_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i18_3_lut_4_lut (.I0(mpreg[18]), .I1(root[17]), .I2(sqrrdy), 
            .I3(multgo), .O(n2211));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i18_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i17_3_lut_4_lut (.I0(mpreg[17]), .I1(root[16]), .I2(sqrrdy), 
            .I3(multgo), .O(n2210));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i17_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i16_3_lut_4_lut (.I0(mpreg[16]), .I1(root[15]), .I2(sqrrdy), 
            .I3(multgo), .O(n2209));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i16_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i15_3_lut_4_lut (.I0(mpreg[15]), .I1(root[14]), .I2(sqrrdy), 
            .I3(multgo), .O(n2208));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i15_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i14_3_lut_4_lut (.I0(mpreg[14]), .I1(root[13]), .I2(sqrrdy), 
            .I3(multgo), .O(n2207));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i14_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i13_3_lut_4_lut (.I0(mpreg[13]), .I1(root[12]), .I2(sqrrdy), 
            .I3(multgo), .O(n2206));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i13_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i12_3_lut_4_lut (.I0(mpreg[12]), .I1(root[11]), .I2(sqrrdy), 
            .I3(multgo), .O(n2205));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i12_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i11_3_lut_4_lut (.I0(mpreg[11]), .I1(root[10]), .I2(sqrrdy), 
            .I3(multgo), .O(n2204));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i11_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i10_3_lut_4_lut (.I0(mpreg[10]), .I1(root[9]), .I2(sqrrdy), 
            .I3(multgo), .O(n2203));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i10_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i9_3_lut_4_lut (.I0(mpreg[9]), .I1(root[8]), .I2(sqrrdy), 
            .I3(multgo), .O(n2202));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i9_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i8_3_lut_4_lut (.I0(mpreg[8]), .I1(root[7]), .I2(sqrrdy), 
            .I3(multgo), .O(n2201));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i8_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_197_i3_3_lut (.I0(mcreg2[1]), .I1(root[2]), .I2(n2193), 
            .I3(GND_net), .O(n2234));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i3_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i2_3_lut (.I0(mcreg1[1]), .I1(mcreg[1]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[1]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i2_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i4_3_lut (.I0(mcreg2[2]), .I1(root[3]), .I2(n2193), 
            .I3(GND_net), .O(n2235));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i4_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i3_3_lut (.I0(mcreg1[2]), .I1(mcreg[2]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[2]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i3_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i5_3_lut (.I0(mcreg2[3]), .I1(root[4]), .I2(n2193), 
            .I3(GND_net), .O(n2236));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i5_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i4_3_lut (.I0(mcreg1[3]), .I1(mcreg[3]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[3]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i4_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i6_3_lut (.I0(mcreg2[4]), .I1(root[5]), .I2(n2193), 
            .I3(GND_net), .O(n2237));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i6_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i5_3_lut (.I0(mcreg1[4]), .I1(mcreg[4]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[4]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i5_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i7_3_lut (.I0(mcreg2[5]), .I1(root[6]), .I2(n2193), 
            .I3(GND_net), .O(n2238));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i7_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i6_3_lut (.I0(mcreg1[5]), .I1(mcreg[5]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[5]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i6_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i8_3_lut (.I0(mcreg2[6]), .I1(root[7]), .I2(n2193), 
            .I3(GND_net), .O(n2239));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i8_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i7_3_lut (.I0(mcreg1[6]), .I1(mcreg[6]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[6]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i7_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i9_3_lut (.I0(mcreg2[7]), .I1(root[8]), .I2(n2193), 
            .I3(GND_net), .O(n2240));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i9_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i8_3_lut (.I0(mcreg1[7]), .I1(mcreg[7]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[7]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i8_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i10_3_lut (.I0(mcreg2[8]), .I1(root[9]), .I2(n2193), 
            .I3(GND_net), .O(n2241));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i10_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i9_3_lut (.I0(mcreg1[8]), .I1(mcreg[8]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[8]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i9_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i11_3_lut (.I0(mcreg2[9]), .I1(root[10]), .I2(n2193), 
            .I3(GND_net), .O(n2242));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i11_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i10_3_lut (.I0(mcreg1[9]), .I1(mcreg[9]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[9]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i10_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i12_3_lut (.I0(mcreg2[10]), .I1(root[11]), .I2(n2193), 
            .I3(GND_net), .O(n2243));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i12_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i11_3_lut (.I0(mcreg1[10]), .I1(mcreg[10]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[10]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i11_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i13_3_lut (.I0(mcreg2[11]), .I1(root[12]), .I2(n2193), 
            .I3(GND_net), .O(n2244));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i13_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i12_3_lut (.I0(mcreg1[11]), .I1(mcreg[11]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[11]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i12_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i14_3_lut (.I0(mcreg2[12]), .I1(root[13]), .I2(n2193), 
            .I3(GND_net), .O(n2245));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i14_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i13_3_lut (.I0(mcreg1[12]), .I1(mcreg[12]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[12]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i13_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i15_3_lut (.I0(mcreg2[13]), .I1(root[14]), .I2(n2193), 
            .I3(GND_net), .O(n2246));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i15_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i14_3_lut (.I0(mcreg1[13]), .I1(mcreg[13]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[13]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i14_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i16_3_lut (.I0(mcreg2[14]), .I1(root[15]), .I2(n2193), 
            .I3(GND_net), .O(n2247));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i16_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i15_3_lut (.I0(mcreg1[14]), .I1(mcreg[14]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[14]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i15_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i17_3_lut (.I0(mcreg2[15]), .I1(root[16]), .I2(n2193), 
            .I3(GND_net), .O(n2248));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i17_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i16_3_lut (.I0(mcreg1[15]), .I1(mcreg[15]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[15]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i16_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i18_3_lut (.I0(mcreg2[16]), .I1(root[17]), .I2(n2193), 
            .I3(GND_net), .O(n2249));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i18_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i17_3_lut (.I0(mcreg1[16]), .I1(mcreg[16]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[16]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i17_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i19_3_lut (.I0(mcreg2[17]), .I1(root[18]), .I2(n2193), 
            .I3(GND_net), .O(n2250));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i19_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i18_3_lut (.I0(mcreg1[17]), .I1(mcreg[17]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[17]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i18_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i20_3_lut (.I0(mcreg2[18]), .I1(root[19]), .I2(n2193), 
            .I3(GND_net), .O(n2251));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i20_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i19_3_lut (.I0(mcreg1[18]), .I1(mcreg[18]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[18]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i19_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i21_3_lut (.I0(mcreg2[19]), .I1(root[20]), .I2(n2193), 
            .I3(GND_net), .O(n2252));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i21_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i20_3_lut (.I0(mcreg1[19]), .I1(mcreg[19]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[19]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i20_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i22_3_lut (.I0(mcreg2[20]), .I1(root[21]), .I2(n2193), 
            .I3(GND_net), .O(n2253));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i22_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i21_3_lut (.I0(mcreg1[20]), .I1(mcreg[20]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[20]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i21_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i23_3_lut (.I0(mcreg2[21]), .I1(root[22]), .I2(n2193), 
            .I3(GND_net), .O(n2254));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i23_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i22_3_lut (.I0(mcreg1[21]), .I1(mcreg[21]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[21]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i22_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i24_3_lut (.I0(mcreg2[22]), .I1(root[23]), .I2(n2193), 
            .I3(GND_net), .O(n2255));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i24_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i23_3_lut (.I0(mcreg1[22]), .I1(mcreg[22]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[22]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i23_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i25_3_lut (.I0(mcreg2[23]), .I1(root[24]), .I2(n2193), 
            .I3(GND_net), .O(n2256));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i25_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i24_3_lut (.I0(mcreg1[23]), .I1(mcreg[23]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[23]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i24_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i26_3_lut (.I0(mcreg2[24]), .I1(root[25]), .I2(n2193), 
            .I3(GND_net), .O(n2257));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i26_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i25_3_lut (.I0(mcreg1[24]), .I1(mcreg[24]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[24]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i25_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i27_3_lut (.I0(mcreg2[25]), .I1(root[26]), .I2(n2193), 
            .I3(GND_net), .O(n2258));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i27_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i26_3_lut (.I0(mcreg1[25]), .I1(mcreg[25]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[25]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i26_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i28_3_lut (.I0(mcreg2[26]), .I1(root[27]), .I2(n2193), 
            .I3(GND_net), .O(n2259));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i28_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i27_3_lut (.I0(mcreg1[26]), .I1(mcreg[26]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[26]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i27_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i29_3_lut (.I0(mcreg2[27]), .I1(root[28]), .I2(n2193), 
            .I3(GND_net), .O(n2260));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i29_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i28_3_lut (.I0(mcreg1[27]), .I1(mcreg[27]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[27]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i28_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i30_3_lut (.I0(mcreg2[28]), .I1(root[29]), .I2(n2193), 
            .I3(GND_net), .O(n2261));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i30_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i29_3_lut (.I0(mcreg1[28]), .I1(mcreg[28]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[28]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i29_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i31_3_lut (.I0(mcreg2[29]), .I1(root[30]), .I2(n2193), 
            .I3(GND_net), .O(n2262));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i31_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i30_3_lut (.I0(mcreg1[29]), .I1(mcreg[29]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[29]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i30_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_197_i32_3_lut (.I0(mcreg2[30]), .I1(root[31]), .I2(n2193), 
            .I3(GND_net), .O(n2263));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_197_i32_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_91_i31_3_lut (.I0(mcreg1[30]), .I1(mcreg[30]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[30]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i31_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_190_i7_3_lut_4_lut (.I0(mpreg[7]), .I1(root[6]), .I2(sqrrdy), 
            .I3(multgo), .O(n2200));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i7_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i6_3_lut_4_lut (.I0(mpreg[6]), .I1(root[5]), .I2(sqrrdy), 
            .I3(multgo), .O(n2199));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i6_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i5_3_lut_4_lut (.I0(mpreg[5]), .I1(root[4]), .I2(sqrrdy), 
            .I3(multgo), .O(n2198));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i5_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i4_3_lut_4_lut (.I0(mpreg[4]), .I1(root[3]), .I2(sqrrdy), 
            .I3(multgo), .O(n2197));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i4_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i1_3_lut_4_lut (.I0(mpreg[1]), .I1(root[0]), .I2(sqrrdy), 
            .I3(multgo), .O(n2194));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i1_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i2_3_lut_4_lut (.I0(mpreg[2]), .I1(root[1]), .I2(sqrrdy), 
            .I3(multgo), .O(n2195));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i2_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_190_i3_3_lut_4_lut (.I0(mpreg[3]), .I1(root[2]), .I2(sqrrdy), 
            .I3(multgo), .O(n2196));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_190_i3_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i2572_2_lut (.I0(mcreg[33]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[33]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2572_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2571_2_lut (.I0(mcreg[32]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[32]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2571_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2570_2_lut (.I0(mcreg[31]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[31]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2570_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2569_2_lut (.I0(mcreg[30]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[30]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2569_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2568_2_lut (.I0(mcreg[29]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[29]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2568_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2567_2_lut (.I0(mcreg[28]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[28]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2567_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2566_2_lut (.I0(mcreg[27]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[27]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2566_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2565_2_lut (.I0(mcreg[26]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[26]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2565_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2564_2_lut (.I0(mcreg[25]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[25]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2564_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2563_2_lut (.I0(mcreg[24]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[24]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2563_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1466_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[31]), 
            .I3(modreg1[31]), .O(n3889));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1466_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1465_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[30]), 
            .I3(modreg1[30]), .O(n3888));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1465_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1464_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[29]), 
            .I3(modreg1[29]), .O(n3887));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1464_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1463_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[28]), 
            .I3(modreg1[28]), .O(n3886));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1463_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1462_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[27]), 
            .I3(modreg1[27]), .O(n3885));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1462_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1461_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[26]), 
            .I3(modreg1[26]), .O(n3884));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1461_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1460_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[25]), 
            .I3(modreg1[25]), .O(n3883));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1460_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1459_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[24]), 
            .I3(modreg1[24]), .O(n3882));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1459_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1458_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[23]), 
            .I3(modreg1[23]), .O(n3881));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1458_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1457_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[22]), 
            .I3(modreg1[22]), .O(n3880));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1457_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1456_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[21]), 
            .I3(modreg1[21]), .O(n3879));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1456_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1455_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[20]), 
            .I3(modreg1[20]), .O(n3878));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1455_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1454_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[19]), 
            .I3(modreg1[19]), .O(n3877));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1454_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1453_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[18]), 
            .I3(modreg1[18]), .O(n3876));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1453_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1452_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[17]), 
            .I3(modreg1[17]), .O(n3875));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1452_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1451_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[16]), 
            .I3(modreg1[16]), .O(n3874));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1451_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1450_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[15]), 
            .I3(modreg1[15]), .O(n3873));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1450_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1449_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[14]), 
            .I3(modreg1[14]), .O(n3872));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1449_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1448_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[13]), 
            .I3(modreg1[13]), .O(n3871));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1448_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1447_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[12]), 
            .I3(modreg1[12]), .O(n3870));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1447_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1446_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[11]), 
            .I3(modreg1[11]), .O(n3869));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1446_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1445_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[10]), 
            .I3(modreg1[10]), .O(n3868));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1445_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1444_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[9]), 
            .I3(modreg1[9]), .O(n3867));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1444_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1443_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[8]), 
            .I3(modreg1[8]), .O(n3866));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1443_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1442_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[7]), 
            .I3(modreg1[7]), .O(n3865));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1442_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1441_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[6]), 
            .I3(modreg1[6]), .O(n3864));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1441_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1440_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[5]), 
            .I3(modreg1[5]), .O(n3863));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1440_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1439_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[4]), 
            .I3(modreg1[4]), .O(n3862));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1439_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1438_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[3]), 
            .I3(modreg1[3]), .O(n3861));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1438_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1437_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[2]), 
            .I3(modreg1[2]), .O(n3860));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1437_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1404_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[0]), 
            .I3(modreg1[0]), .O(n3827));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1404_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1436_3_lut_4_lut (.I0(n2193), .I1(reset_c), .I2(modreg[1]), 
            .I3(modreg1[1]), .O(n3859));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1436_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i2562_2_lut (.I0(mcreg[23]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[23]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2562_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2561_2_lut (.I0(mcreg[22]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[22]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2561_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2560_2_lut (.I0(mcreg[21]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[21]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2560_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2559_2_lut (.I0(mcreg[20]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[20]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2559_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2558_2_lut (.I0(mcreg[19]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[19]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2558_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2557_2_lut (.I0(mcreg[18]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[18]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2557_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2556_2_lut (.I0(mcreg[17]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[17]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2556_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2555_2_lut (.I0(mcreg[16]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[16]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2555_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2554_2_lut (.I0(mcreg[15]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[15]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2554_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2553_2_lut (.I0(mcreg[14]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[14]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2553_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2552_2_lut (.I0(mcreg[13]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[13]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2552_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2551_2_lut (.I0(mcreg[12]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[12]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2551_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2550_2_lut (.I0(mcreg[11]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[11]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2550_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2549_2_lut (.I0(mcreg[10]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[10]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2549_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2548_2_lut (.I0(mcreg[9]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2790[9]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2548_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2547_2_lut (.I0(mcreg[8]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2790[8]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2547_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2546_2_lut (.I0(mcreg[7]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2790[7]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2546_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2545_2_lut (.I0(mcreg[6]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2790[6]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2545_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2544_2_lut (.I0(mcreg[5]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2790[5]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2544_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2543_2_lut (.I0(mcreg[4]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2790[4]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2543_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2542_2_lut (.I0(mcreg[3]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2790[3]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2542_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2541_2_lut (.I0(mcreg[2]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2790[2]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2541_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2540_2_lut (.I0(mcreg[1]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2790[1]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2540_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2480_2_lut (.I0(\mcreg[0] ), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2790[0]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2480_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i506_2_lut (.I0(mcreg[32]), .I1(mcreg1[32]), .I2(GND_net), 
            .I3(GND_net), .O(mcreg2[32]));
    defparam i506_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 mux_91_i32_3_lut (.I0(mcreg1[31]), .I1(mcreg[31]), .I2(mcreg1[32]), 
            .I3(GND_net), .O(mcreg2[31]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_91_i32_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_275_i33_3_lut (.I0(prodreg3_c[32]), .I1(n2970), .I2(prodreg3[33]), 
            .I3(GND_net), .O(prodreg4[32]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_275_i33_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i547_3_lut (.I0(prodreg1[32]), .I1(prodreg2[32]), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n2970));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i547_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i1_3_lut (.I0(prodreg1[33]), .I1(\prodreg2[33] ), .I2(prodreg3[33]), 
            .I3(GND_net), .O(prodreg4[33]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i1_3_lut.LUT_INIT = 16'h8080;
    
endmodule
//
// Verilog Description of module \modmult(32)_U0 
//

module \modmult(32)_U0  (n4776, indata_c_26, ready_c, \root_31__N_65[26] , 
            GND_net, \prodreg1[25] , \prodreg2[25] , \prodreg2[33] , 
            tempout, \prodreg3[25] , \prodreg3[33] , n4745, \mcreg1[32] , 
            indata_c_25, \root_31__N_65[25] , \tempin[31] , n2057, prodreg, 
            \prodreg1[24] , \prodreg2[24] , \prodreg3[24] , n4714, indata_c_24, 
            \root_31__N_65[24] , multrdy, clk_c, reset_c, \prodreg1[23] , 
            \prodreg2[23] , \tempin[30] , \prodreg3[23] , n4683, indata_c_23, 
            \root_31__N_65[23] , n3898, VCC_net, \tempin[29] , \prodreg1[22] , 
            \prodreg2[22] , \prodreg3[22] , n4652, \tempin[28] , indata_c_22, 
            \root_31__N_65[22] , \prodreg1[21] , \prodreg2[21] , \prodreg3[21] , 
            n4621, n2179, indata_c_21, \root_31__N_65[21] , \tempin[27] , 
            \prodreg1[20] , \prodreg2[20] , \prodreg3[20] , n4590, \tempin[26] , 
            indata_c_20, \root_31__N_65[20] , \prodreg1[19] , \prodreg2[19] , 
            \prodreg3[19] , n4559, \tempin[25] , indata_c_19, \root_31__N_65[19] , 
            \prodreg1[18] , \prodreg2[18] , \tempin[24] , \prodreg3[18] , 
            n4528, \tempin[23] , indata_c_18, \root_31__N_65[18] , \prodreg1[17] , 
            \prodreg2[17] , \prodreg3[17] , n4497, \tempin[22] , indata_c_17, 
            \root_31__N_65[17] , \prodreg1[16] , \prodreg2[16] , n2097, 
            \tempin[21] , \prodreg3[16] , n4466, indata_c_16, \root_31__N_65[16] , 
            \tempin[20] , \prodreg1[15] , \prodreg2[15] , \prodreg3[15] , 
            n4435, \tempin[19] , indata_c_15, \root_31__N_65[15] , \prodreg1[14] , 
            \prodreg2[14] , \prodreg3[14] , n4404, \tempin[18] , \sqrin[29] , 
            multgo, indata_c_14, \root_31__N_65[14] , \sqrin[28] , \prodreg1[13] , 
            \prodreg2[13] , \tempin[17] , \prodreg[7] , \prodreg[2] , 
            \sqrin[27] , \prodreg3[13] , n4373, \sqrin[26] , indata_c_13, 
            \root_31__N_65[13] , \tempin[16] , \prodreg1[12] , \prodreg2[12] , 
            \sqrin[25] , \sqrin[24] , \prodreg3[12] , n4342, \sqrin[23] , 
            \tempin[15] , indata_c_12, \root_31__N_65[12] , \sqrin[22] , 
            \prodreg1[11] , \prodreg2[11] , \sqrin[21] , \prodreg3[11] , 
            n4311, \tempin[14] , \sqrin[20] , indata_c_11, \root_31__N_65[11] , 
            \sqrin[19] , \tempin[13] , n3895, n3892, \mpreg[31] , 
            \sqrin[18] , \tempin[12] , \sqrin[17] , \sqrin[16] , \tempin[11] , 
            \sqrin[15] , \prodreg[0] , \sqrin[14] , n2088, n4107, 
            \mcreg[0] , \sqrin[13] , \tempin[10] , \tempin[9] , n4053, 
            \tempin[8] , \tempin[7] , n3988, \prodreg[1] , n3985, 
            n2912, n3981, \prodreg[3] , n3978, \prodreg[4] , n3975, 
            \tempin[6] , n3971, \prodreg[6] , n3968, \tempin[5] , 
            n3964, n3961, \prodreg[9] , n3958, \prodreg[10] , \tempin[4] , 
            \sqrin[12] , \tempin[3] , \sqrin[11] , \sqrin[10] , \sqrin[9] , 
            \tempin[2] , indata_c_29, inExp_c_0, \tempin_31__N_129[29] , 
            indata_c_28, \tempin_31__N_129[28] , indata_c_27, \tempin_31__N_129[27] , 
            \tempin_31__N_129[26] , \tempin_31__N_129[25] , \tempin_31__N_129[24] , 
            \mcreg1[0] , \sqrin[8] , \tempin_31__N_129[23] , \tempin_31__N_129[22] , 
            \tempin_31__N_129[21] , \tempin_31__N_129[20] , \tempin_31__N_129[19] , 
            \tempin_31__N_129[18] , \tempin_31__N_129[17] , \tempin_31__N_129[16] , 
            \sqrin[7] , \sqrin[6] , \tempin_31__N_129[15] , \tempin_31__N_129[14] , 
            \sqrin[5] , \tempin_31__N_129[13] , \tempin_31__N_129[12] , 
            \tempin_31__N_129[11] , \prodreg1[29] , \prodreg2[29] , \prodreg3[29] , 
            n4280, \sqrin[4] , modreg, \root_31__N_65[29] , \prodreg1[28] , 
            \prodreg2[28] , \prodreg3[28] , n4838, \root_31__N_65[28] , 
            \prodreg1[27] , \prodreg2[27] , \prodreg3[27] , n4807, \root_31__N_65[27] , 
            \prodreg1[26] , \prodreg2[26] , \prodreg3[26] , \sqrin[3] , 
            \sqrin[2] , \sqrin[1] , \sqrin[0] );
    output n4776;
    input indata_c_26;
    input ready_c;
    output \root_31__N_65[26] ;
    input GND_net;
    input \prodreg1[25] ;
    input \prodreg2[25] ;
    input \prodreg2[33] ;
    output [31:0]tempout;
    input \prodreg3[25] ;
    input \prodreg3[33] ;
    output n4745;
    output \mcreg1[32] ;
    input indata_c_25;
    output \root_31__N_65[25] ;
    input \tempin[31] ;
    output n2057;
    output [33:0]prodreg;
    input \prodreg1[24] ;
    input \prodreg2[24] ;
    input \prodreg3[24] ;
    output n4714;
    input indata_c_24;
    output \root_31__N_65[24] ;
    output multrdy;
    input clk_c;
    input reset_c;
    input \prodreg1[23] ;
    input \prodreg2[23] ;
    input \tempin[30] ;
    input \prodreg3[23] ;
    output n4683;
    input indata_c_23;
    output \root_31__N_65[23] ;
    input n3898;
    input VCC_net;
    input \tempin[29] ;
    input \prodreg1[22] ;
    input \prodreg2[22] ;
    input \prodreg3[22] ;
    output n4652;
    input \tempin[28] ;
    input indata_c_22;
    output \root_31__N_65[22] ;
    input \prodreg1[21] ;
    input \prodreg2[21] ;
    input \prodreg3[21] ;
    output n4621;
    output n2179;
    input indata_c_21;
    output \root_31__N_65[21] ;
    input \tempin[27] ;
    input \prodreg1[20] ;
    input \prodreg2[20] ;
    input \prodreg3[20] ;
    output n4590;
    input \tempin[26] ;
    input indata_c_20;
    output \root_31__N_65[20] ;
    input \prodreg1[19] ;
    input \prodreg2[19] ;
    input \prodreg3[19] ;
    output n4559;
    input \tempin[25] ;
    input indata_c_19;
    output \root_31__N_65[19] ;
    input \prodreg1[18] ;
    input \prodreg2[18] ;
    input \tempin[24] ;
    input \prodreg3[18] ;
    output n4528;
    input \tempin[23] ;
    input indata_c_18;
    output \root_31__N_65[18] ;
    input \prodreg1[17] ;
    input \prodreg2[17] ;
    input \prodreg3[17] ;
    output n4497;
    input \tempin[22] ;
    input indata_c_17;
    output \root_31__N_65[17] ;
    input \prodreg1[16] ;
    input \prodreg2[16] ;
    input n2097;
    input \tempin[21] ;
    input \prodreg3[16] ;
    output n4466;
    input indata_c_16;
    output \root_31__N_65[16] ;
    input \tempin[20] ;
    input \prodreg1[15] ;
    input \prodreg2[15] ;
    input \prodreg3[15] ;
    output n4435;
    input \tempin[19] ;
    input indata_c_15;
    output \root_31__N_65[15] ;
    input \prodreg1[14] ;
    input \prodreg2[14] ;
    input \prodreg3[14] ;
    output n4404;
    input \tempin[18] ;
    input \sqrin[29] ;
    input multgo;
    input indata_c_14;
    output \root_31__N_65[14] ;
    input \sqrin[28] ;
    input \prodreg1[13] ;
    input \prodreg2[13] ;
    input \tempin[17] ;
    output \prodreg[7] ;
    output \prodreg[2] ;
    input \sqrin[27] ;
    input \prodreg3[13] ;
    output n4373;
    input \sqrin[26] ;
    input indata_c_13;
    output \root_31__N_65[13] ;
    input \tempin[16] ;
    input \prodreg1[12] ;
    input \prodreg2[12] ;
    input \sqrin[25] ;
    input \sqrin[24] ;
    input \prodreg3[12] ;
    output n4342;
    input \sqrin[23] ;
    input \tempin[15] ;
    input indata_c_12;
    output \root_31__N_65[12] ;
    input \sqrin[22] ;
    input \prodreg1[11] ;
    input \prodreg2[11] ;
    input \sqrin[21] ;
    input \prodreg3[11] ;
    output n4311;
    input \tempin[14] ;
    input \sqrin[20] ;
    input indata_c_11;
    output \root_31__N_65[11] ;
    input \sqrin[19] ;
    input \tempin[13] ;
    input n3895;
    input n3892;
    output \mpreg[31] ;
    input \sqrin[18] ;
    input \tempin[12] ;
    input \sqrin[17] ;
    input \sqrin[16] ;
    input \tempin[11] ;
    input \sqrin[15] ;
    output \prodreg[0] ;
    input \sqrin[14] ;
    input n2088;
    input n4107;
    output \mcreg[0] ;
    input \sqrin[13] ;
    input \tempin[10] ;
    input \tempin[9] ;
    input n4053;
    input \tempin[8] ;
    input \tempin[7] ;
    input n3988;
    output \prodreg[1] ;
    input n3985;
    output n2912;
    input n3981;
    output \prodreg[3] ;
    input n3978;
    output \prodreg[4] ;
    input n3975;
    input \tempin[6] ;
    input n3971;
    output \prodreg[6] ;
    input n3968;
    input \tempin[5] ;
    input n3964;
    input n3961;
    output \prodreg[9] ;
    input n3958;
    output \prodreg[10] ;
    input \tempin[4] ;
    input \sqrin[12] ;
    input \tempin[3] ;
    input \sqrin[11] ;
    input \sqrin[10] ;
    input \sqrin[9] ;
    input \tempin[2] ;
    input indata_c_29;
    input inExp_c_0;
    output \tempin_31__N_129[29] ;
    input indata_c_28;
    output \tempin_31__N_129[28] ;
    input indata_c_27;
    output \tempin_31__N_129[27] ;
    output \tempin_31__N_129[26] ;
    output \tempin_31__N_129[25] ;
    output \tempin_31__N_129[24] ;
    output \mcreg1[0] ;
    input \sqrin[8] ;
    output \tempin_31__N_129[23] ;
    output \tempin_31__N_129[22] ;
    output \tempin_31__N_129[21] ;
    output \tempin_31__N_129[20] ;
    output \tempin_31__N_129[19] ;
    output \tempin_31__N_129[18] ;
    output \tempin_31__N_129[17] ;
    output \tempin_31__N_129[16] ;
    input \sqrin[7] ;
    input \sqrin[6] ;
    output \tempin_31__N_129[15] ;
    output \tempin_31__N_129[14] ;
    input \sqrin[5] ;
    output \tempin_31__N_129[13] ;
    output \tempin_31__N_129[12] ;
    output \tempin_31__N_129[11] ;
    input \prodreg1[29] ;
    input \prodreg2[29] ;
    input \prodreg3[29] ;
    output n4280;
    input \sqrin[4] ;
    input [31:0]modreg;
    output \root_31__N_65[29] ;
    input \prodreg1[28] ;
    input \prodreg2[28] ;
    input \prodreg3[28] ;
    output n4838;
    output \root_31__N_65[28] ;
    input \prodreg1[27] ;
    input \prodreg2[27] ;
    input \prodreg3[27] ;
    output n4807;
    output \root_31__N_65[27] ;
    input \prodreg1[26] ;
    input \prodreg2[26] ;
    input \prodreg3[26] ;
    input \sqrin[3] ;
    input \sqrin[2] ;
    input \sqrin[1] ;
    input \sqrin[0] ;
    
    wire clk_c /* synthesis is_clock=1, SET_AS_NETWORK=clk_c */ ;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(80[5:8])
    wire [33:0]prodreg3;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    wire [33:0]prodreg1;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[17:25])
    wire [33:0]n1;
    
    wire n5341, n4744, n2971, n5342, n5340;
    wire [33:0]modreg1;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(90[8:15])
    wire [33:0]mcreg1;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(89[15:21])
    wire [33:0]mcreg;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(89[8:13])
    wire [33:0]mcreg2;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(89[23:29])
    
    wire n2127, n5262;
    wire [33:0]n2753;
    
    wire n5263, n4713, n5236, n5237, n2132, n4682, n2126, n5339, 
        n2125, n4651, n2124, n4620, n2058;
    wire [31:0]mpreg;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(88[8:13])
    
    wire n2123, n4589, n2122, n4558, n2121, n4527, n2120, n2119, 
        n4496, n2118, n4465, n2098, n2117, n2116, n4434, n2115, 
        n4403, n2114, n2087, n2086, n4372, n2099, n2100, n2101, 
        n2102, n2103, n2104, n2105, n2106, n2107, n2108, n2109, 
        n2110, n2111, n2112, n2113, n5239, n5240, n5261, n5252;
    wire [33:0]prodreg_c;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[8:15])
    
    wire n5253, n5251, n5238, n5260, n5233, n5250, n5259, n5249, 
        n5338, n5258, n2085, n2084, n4341, n2083, n2082, n2081, 
        n2080, n4310, n2079, n2078, n2077;
    wire [33:0]prodreg2;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[27:35])
    
    wire n5460, n5459, n5458, n5457, n5456, n5455, n5454, n5453, 
        n5452, n5451, n5450, n5449, n5448, n5447, n5446, n2076, 
        n5445, n5444, n5443, n5442, n5441, n5440, n3858, n3857, 
        n3856, n3855, n3854, n3853, n3852, n3851, n3850, n3849, 
        n3848, n3847, n3846, n3845, n3844, n3843, n3842, n3841, 
        n3840, n3839, n3838, n3837, n3836, n3835, n3834, n3833, 
        n3832, n3831, n2059, n2075, n5337, n5336, n5335, n5334, 
        n5333, n5332, n5331, n5330, n2074, n3830, n5439, n5438, 
        n5437, n5436, n5435, n5434, n5433, n5432, n5431, n5430, 
        n5429, n5428, n2073, n3829, n3828, n3826, n2060, n5243, 
        n5244, n5242, n5347, n5348, n5346, n5345, n2072, n2061, 
        n2062, n2063, n2064, n2065, n2066, n2067, n2068, n2069, 
        n2070, n2071, n4112, n4108, n4104, n4097, n4087, n4077, 
        n4067, n4060, n4050, n4040, n4030, n4020, n4010, n4000, 
        n3993, n3989, n3982, n5344, n5343;
    wire [33:0]prodreg4;   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[47:55])
    
    wire n3972, n3965, n5296, n5295, n5294, n3001, n4272, n4830, 
        n3000, n4799, n56, n54, n4768, n55, n53, n52, n4737, 
        n50, n4706, n51, n5760, n62, n5293, n5292, n5291, n5290, 
        n5289, n5288, n5287, n5362, n5361, n5286, n5360, n5359, 
        n5285, n5358, n5284, n5357, n5356, n5283, n5758, n5355, 
        n5282, n5354, n5353, n5281, n5352, n5351, n5280, n5350, 
        n5279, n5349, n5278, n5277, n5276, n5275, n5274, n5273, 
        n5272, n5271, n5248, n5257, n5241, n5247, n5235, n5256, 
        n5246, n5245, n5255, n5254, n5270, n5269, n5268, n5267, 
        n5266, n5265, n5264, n5232, n5234, n4675, n4644, n4613, 
        n4582, n4551, n4520, n4489, n4458, n4427, n4396, n4365, 
        n4334, n4303, n2980, n4279, n2979, n2978, n4837, n2977, 
        n2976, n4806, n2975, n2974, n4775, n2973, n2972, n3002;
    
    SB_LUT4 i2371_3_lut (.I0(n4776), .I1(indata_c_26), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[26] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2371_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 sub_84_add_2_14_lut (.I0(GND_net), .I1(prodreg1[12]), .I2(n1[12]), 
            .I3(n5341), .O(prodreg3[12])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_14_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 i2336_3_lut (.I0(\prodreg1[25] ), .I1(\prodreg2[25] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4744));
    defparam i2336_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_272_i2_3_lut (.I0(prodreg3[1]), .I1(n2971), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[1]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_272_i2_3_lut.LUT_INIT = 16'hcaca;
    SB_CARRY sub_84_add_2_14 (.CI(n5341), .I0(prodreg1[12]), .I1(n1[12]), 
            .CO(n5342));
    SB_LUT4 i2337_3_lut (.I0(\prodreg3[25] ), .I1(n4744), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4745));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2337_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 sub_84_add_2_13_lut (.I0(GND_net), .I1(prodreg1[11]), .I2(n1[11]), 
            .I3(n5340), .O(prodreg3[11])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_13_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_84_inv_0_i26_1_lut (.I0(modreg1[24]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[25]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i26_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i27_1_lut (.I0(modreg1[25]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[26]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i27_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i28_1_lut (.I0(modreg1[26]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[27]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i28_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 mux_86_i31_3_lut (.I0(mcreg1[30]), .I1(mcreg[30]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[30]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i31_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2339_3_lut (.I0(n4745), .I1(indata_c_25), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[25] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2339_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_158_i32_3_lut (.I0(mcreg2[30]), .I1(\tempin[31] ), .I2(n2057), 
            .I3(GND_net), .O(n2127));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i32_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 sub_84_inv_0_i29_1_lut (.I0(modreg1[27]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[28]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i29_1_lut.LUT_INIT = 16'h5555;
    SB_CARRY add_281_33 (.CI(n5262), .I0(prodreg[31]), .I1(n2753[31]), 
            .CO(n5263));
    SB_LUT4 sub_84_inv_0_i30_1_lut (.I0(modreg1[28]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[29]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i30_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 i2304_3_lut (.I0(\prodreg1[24] ), .I1(\prodreg2[24] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4713));
    defparam i2304_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2305_3_lut (.I0(\prodreg3[24] ), .I1(n4713), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4714));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2305_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 sub_84_inv_0_i31_1_lut (.I0(modreg1[29]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[30]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i31_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i32_1_lut (.I0(modreg1[30]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[31]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i32_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 mux_86_i30_3_lut (.I0(mcreg1[29]), .I1(mcreg[29]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[29]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i30_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2307_3_lut (.I0(n4714), .I1(indata_c_24), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[24] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2307_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 sub_84_inv_0_i33_1_lut (.I0(modreg1[31]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[32]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i33_1_lut.LUT_INIT = 16'h5555;
    SB_CARRY add_281_7 (.CI(n5236), .I0(prodreg[5]), .I1(n2753[5]), .CO(n5237));
    SB_DFFS first_45 (.Q(multrdy), .C(clk_c), .D(n2132), .S(reset_c));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_CARRY sub_84_add_2_13 (.CI(n5340), .I0(prodreg1[11]), .I1(n1[11]), 
            .CO(n5341));
    SB_LUT4 i2272_3_lut (.I0(\prodreg1[23] ), .I1(\prodreg2[23] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4682));
    defparam i2272_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_158_i31_3_lut (.I0(mcreg2[29]), .I1(\tempin[30] ), .I2(n2057), 
            .I3(GND_net), .O(n2126));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i31_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2273_3_lut (.I0(\prodreg3[23] ), .I1(n4682), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4683));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2273_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_86_i29_3_lut (.I0(mcreg1[28]), .I1(mcreg[28]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[28]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i29_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2275_3_lut (.I0(n4683), .I1(indata_c_23), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[23] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2275_3_lut.LUT_INIT = 16'hcaca;
    SB_DFFE prodreg__i30 (.Q(prodreg[30]), .C(clk_c), .E(VCC_net), .D(n3898));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 sub_84_add_2_12_lut (.I0(GND_net), .I1(prodreg1[10]), .I2(n1[10]), 
            .I3(n5339), .O(prodreg3[10])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_12_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 mux_158_i30_3_lut (.I0(mcreg2[28]), .I1(\tempin[29] ), .I2(n2057), 
            .I3(GND_net), .O(n2125));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i30_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2240_3_lut (.I0(\prodreg1[22] ), .I1(\prodreg2[22] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4651));
    defparam i2240_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2241_3_lut (.I0(\prodreg3[22] ), .I1(n4651), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4652));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2241_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_86_i28_3_lut (.I0(mcreg1[27]), .I1(mcreg[27]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[27]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i28_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_158_i29_3_lut (.I0(mcreg2[27]), .I1(\tempin[28] ), .I2(n2057), 
            .I3(GND_net), .O(n2124));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i29_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2243_3_lut (.I0(n4652), .I1(indata_c_22), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[22] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2243_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2208_3_lut (.I0(\prodreg1[21] ), .I1(\prodreg2[21] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4620));
    defparam i2208_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2209_3_lut (.I0(\prodreg3[21] ), .I1(n4620), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4621));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2209_3_lut.LUT_INIT = 16'hcaca;
    SB_DFFE mpreg_i0_i0 (.Q(mpreg[0]), .C(clk_c), .E(n2179), .D(n2058));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_86_i27_3_lut (.I0(mcreg1[26]), .I1(mcreg[26]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[26]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i27_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2211_3_lut (.I0(n4621), .I1(indata_c_21), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[21] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2211_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_158_i28_3_lut (.I0(mcreg2[26]), .I1(\tempin[27] ), .I2(n2057), 
            .I3(GND_net), .O(n2123));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i28_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2176_3_lut (.I0(\prodreg1[20] ), .I1(\prodreg2[20] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4589));
    defparam i2176_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2177_3_lut (.I0(\prodreg3[20] ), .I1(n4589), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4590));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2177_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_86_i26_3_lut (.I0(mcreg1[25]), .I1(mcreg[25]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[25]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i26_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_158_i27_3_lut (.I0(mcreg2[25]), .I1(\tempin[26] ), .I2(n2057), 
            .I3(GND_net), .O(n2122));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i27_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2179_3_lut (.I0(n4590), .I1(indata_c_20), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[20] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2179_3_lut.LUT_INIT = 16'hcaca;
    SB_CARRY sub_84_add_2_12 (.CI(n5339), .I0(prodreg1[10]), .I1(n1[10]), 
            .CO(n5340));
    SB_LUT4 i2144_3_lut (.I0(\prodreg1[19] ), .I1(\prodreg2[19] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4558));
    defparam i2144_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_86_i25_3_lut (.I0(mcreg1[24]), .I1(mcreg[24]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[24]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i25_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2145_3_lut (.I0(\prodreg3[19] ), .I1(n4558), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4559));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2145_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_158_i26_3_lut (.I0(mcreg2[24]), .I1(\tempin[25] ), .I2(n2057), 
            .I3(GND_net), .O(n2121));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i26_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_86_i24_3_lut (.I0(mcreg1[23]), .I1(mcreg[23]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[23]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i24_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2147_3_lut (.I0(n4559), .I1(indata_c_19), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[19] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2147_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2112_3_lut (.I0(\prodreg1[18] ), .I1(\prodreg2[18] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4527));
    defparam i2112_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_158_i25_3_lut (.I0(mcreg2[23]), .I1(\tempin[24] ), .I2(n2057), 
            .I3(GND_net), .O(n2120));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i25_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2113_3_lut (.I0(\prodreg3[18] ), .I1(n4527), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4528));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2113_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_86_i23_3_lut (.I0(mcreg1[22]), .I1(mcreg[22]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[22]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i23_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_158_i24_3_lut (.I0(mcreg2[22]), .I1(\tempin[23] ), .I2(n2057), 
            .I3(GND_net), .O(n2119));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i24_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2115_3_lut (.I0(n4528), .I1(indata_c_18), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[18] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2115_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2080_3_lut (.I0(\prodreg1[17] ), .I1(\prodreg2[17] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4496));
    defparam i2080_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_86_i22_3_lut (.I0(mcreg1[21]), .I1(mcreg[21]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[21]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i22_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2081_3_lut (.I0(\prodreg3[17] ), .I1(n4496), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4497));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2081_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_158_i23_3_lut (.I0(mcreg2[21]), .I1(\tempin[22] ), .I2(n2057), 
            .I3(GND_net), .O(n2118));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i23_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2083_3_lut (.I0(n4497), .I1(indata_c_17), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[17] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2083_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_86_i21_3_lut (.I0(mcreg1[20]), .I1(mcreg[20]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[20]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i21_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2048_3_lut (.I0(\prodreg1[16] ), .I1(\prodreg2[16] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4465));
    defparam i2048_3_lut.LUT_INIT = 16'hacac;
    SB_DFFE mcreg_i0_i1 (.Q(mcreg[1]), .C(clk_c), .E(n2179), .D(n2097));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i2 (.Q(mcreg[2]), .C(clk_c), .E(n2179), .D(n2098));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_158_i22_3_lut (.I0(mcreg2[20]), .I1(\tempin[21] ), .I2(n2057), 
            .I3(GND_net), .O(n2117));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i22_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2049_3_lut (.I0(\prodreg3[16] ), .I1(n4465), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4466));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2049_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_86_i20_3_lut (.I0(mcreg1[19]), .I1(mcreg[19]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[19]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i20_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2051_3_lut (.I0(n4466), .I1(indata_c_16), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[16] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2051_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_158_i21_3_lut (.I0(mcreg2[19]), .I1(\tempin[20] ), .I2(n2057), 
            .I3(GND_net), .O(n2116));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i21_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2016_3_lut (.I0(\prodreg1[15] ), .I1(\prodreg2[15] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4434));
    defparam i2016_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2017_3_lut (.I0(\prodreg3[15] ), .I1(n4434), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4435));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2017_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_86_i19_3_lut (.I0(mcreg1[18]), .I1(mcreg[18]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[18]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i19_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_158_i20_3_lut (.I0(mcreg2[18]), .I1(\tempin[19] ), .I2(n2057), 
            .I3(GND_net), .O(n2115));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i20_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2019_3_lut (.I0(n4435), .I1(indata_c_15), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[15] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2019_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1984_3_lut (.I0(\prodreg1[14] ), .I1(\prodreg2[14] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4403));
    defparam i1984_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_86_i18_3_lut (.I0(mcreg1[17]), .I1(mcreg[17]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[17]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i18_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1985_3_lut (.I0(\prodreg3[14] ), .I1(n4403), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4404));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i1985_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_158_i19_3_lut (.I0(mcreg2[17]), .I1(\tempin[18] ), .I2(n2057), 
            .I3(GND_net), .O(n2114));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i19_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i30_3_lut_4_lut (.I0(mpreg[30]), .I1(\sqrin[29] ), .I2(multrdy), 
            .I3(multgo), .O(n2087));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i30_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i1987_3_lut (.I0(n4404), .I1(indata_c_14), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[14] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i1987_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i29_3_lut_4_lut (.I0(mpreg[29]), .I1(\sqrin[28] ), .I2(multrdy), 
            .I3(multgo), .O(n2086));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i29_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_86_i17_3_lut (.I0(mcreg1[16]), .I1(mcreg[16]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[16]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i17_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1952_3_lut (.I0(\prodreg1[13] ), .I1(\prodreg2[13] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4372));
    defparam i1952_3_lut.LUT_INIT = 16'hacac;
    SB_DFFE mcreg_i0_i3 (.Q(mcreg[3]), .C(clk_c), .E(n2179), .D(n2099));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i4 (.Q(mcreg[4]), .C(clk_c), .E(n2179), .D(n2100));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i5 (.Q(mcreg[5]), .C(clk_c), .E(n2179), .D(n2101));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i6 (.Q(mcreg[6]), .C(clk_c), .E(n2179), .D(n2102));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i7 (.Q(mcreg[7]), .C(clk_c), .E(n2179), .D(n2103));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i8 (.Q(mcreg[8]), .C(clk_c), .E(n2179), .D(n2104));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i9 (.Q(mcreg[9]), .C(clk_c), .E(n2179), .D(n2105));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i10 (.Q(mcreg[10]), .C(clk_c), .E(n2179), .D(n2106));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i11 (.Q(mcreg[11]), .C(clk_c), .E(n2179), .D(n2107));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i12 (.Q(mcreg[12]), .C(clk_c), .E(n2179), .D(n2108));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i13 (.Q(mcreg[13]), .C(clk_c), .E(n2179), .D(n2109));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i14 (.Q(mcreg[14]), .C(clk_c), .E(n2179), .D(n2110));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i15 (.Q(mcreg[15]), .C(clk_c), .E(n2179), .D(n2111));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i16 (.Q(mcreg[16]), .C(clk_c), .E(n2179), .D(n2112));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i17 (.Q(mcreg[17]), .C(clk_c), .E(n2179), .D(n2113));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i18 (.Q(mcreg[18]), .C(clk_c), .E(n2179), .D(n2114));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i19 (.Q(mcreg[19]), .C(clk_c), .E(n2179), .D(n2115));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i20 (.Q(mcreg[20]), .C(clk_c), .E(n2179), .D(n2116));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i21 (.Q(mcreg[21]), .C(clk_c), .E(n2179), .D(n2117));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i22 (.Q(mcreg[22]), .C(clk_c), .E(n2179), .D(n2118));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i23 (.Q(mcreg[23]), .C(clk_c), .E(n2179), .D(n2119));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i24 (.Q(mcreg[24]), .C(clk_c), .E(n2179), .D(n2120));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i25 (.Q(mcreg[25]), .C(clk_c), .E(n2179), .D(n2121));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i26 (.Q(mcreg[26]), .C(clk_c), .E(n2179), .D(n2122));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i27 (.Q(mcreg[27]), .C(clk_c), .E(n2179), .D(n2123));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i28 (.Q(mcreg[28]), .C(clk_c), .E(n2179), .D(n2124));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i29 (.Q(mcreg[29]), .C(clk_c), .E(n2179), .D(n2125));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i30 (.Q(mcreg[30]), .C(clk_c), .E(n2179), .D(n2126));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i31 (.Q(mcreg[31]), .C(clk_c), .E(n2179), .D(n2127));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_158_i18_3_lut (.I0(mcreg2[16]), .I1(\tempin[17] ), .I2(n2057), 
            .I3(GND_net), .O(n2113));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i18_3_lut.LUT_INIT = 16'hcaca;
    SB_CARRY add_281_10 (.CI(n5239), .I0(prodreg[8]), .I1(n2753[8]), .CO(n5240));
    SB_LUT4 add_281_32_lut (.I0(GND_net), .I1(prodreg[30]), .I2(n2753[30]), 
            .I3(n5261), .O(prodreg1[30])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_32_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_23 (.CI(n5252), .I0(prodreg_c[21]), .I1(n2753[21]), 
            .CO(n5253));
    SB_CARRY add_281_32 (.CI(n5261), .I0(prodreg[30]), .I1(n2753[30]), 
            .CO(n5262));
    SB_LUT4 add_281_22_lut (.I0(GND_net), .I1(prodreg_c[20]), .I2(n2753[20]), 
            .I3(n5251), .O(prodreg1[20])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_22_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_9_lut (.I0(GND_net), .I1(\prodreg[7] ), .I2(n2753[7]), 
            .I3(n5238), .O(prodreg1[7])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_9_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_22 (.CI(n5251), .I0(prodreg_c[20]), .I1(n2753[20]), 
            .CO(n5252));
    SB_LUT4 add_281_31_lut (.I0(GND_net), .I1(prodreg_c[29]), .I2(n2753[29]), 
            .I3(n5260), .O(prodreg1[29])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_31_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_4_lut (.I0(GND_net), .I1(\prodreg[2] ), .I2(n2753[2]), 
            .I3(n5233), .O(prodreg1[2])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_4_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_21_lut (.I0(GND_net), .I1(prodreg_c[19]), .I2(n2753[19]), 
            .I3(n5250), .O(prodreg1[19])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_21_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_31 (.CI(n5260), .I0(prodreg_c[29]), .I1(n2753[29]), 
            .CO(n5261));
    SB_CARRY add_281_21 (.CI(n5250), .I0(prodreg_c[19]), .I1(n2753[19]), 
            .CO(n5251));
    SB_LUT4 add_281_30_lut (.I0(GND_net), .I1(prodreg_c[28]), .I2(n2753[28]), 
            .I3(n5259), .O(prodreg1[28])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_30_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_20_lut (.I0(GND_net), .I1(prodreg_c[18]), .I2(n2753[18]), 
            .I3(n5249), .O(prodreg1[18])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_20_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_30 (.CI(n5259), .I0(prodreg_c[28]), .I1(n2753[28]), 
            .CO(n5260));
    SB_CARRY add_281_20 (.CI(n5249), .I0(prodreg_c[18]), .I1(n2753[18]), 
            .CO(n5250));
    SB_LUT4 sub_84_add_2_11_lut (.I0(GND_net), .I1(prodreg1[9]), .I2(n1[9]), 
            .I3(n5338), .O(prodreg3[9])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_11_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_29_lut (.I0(GND_net), .I1(prodreg_c[27]), .I2(n2753[27]), 
            .I3(n5258), .O(prodreg1[27])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_29_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_29 (.CI(n5258), .I0(prodreg_c[27]), .I1(n2753[27]), 
            .CO(n5259));
    SB_LUT4 mux_86_i16_3_lut (.I0(mcreg1[15]), .I1(mcreg[15]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[15]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i16_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i28_3_lut_4_lut (.I0(mpreg[28]), .I1(\sqrin[27] ), .I2(multrdy), 
            .I3(multgo), .O(n2085));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i28_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i1953_3_lut (.I0(\prodreg3[13] ), .I1(n4372), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4373));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i1953_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i27_3_lut_4_lut (.I0(mpreg[27]), .I1(\sqrin[26] ), .I2(multrdy), 
            .I3(multgo), .O(n2084));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i27_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i1955_3_lut (.I0(n4373), .I1(indata_c_13), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[13] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i1955_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_158_i17_3_lut (.I0(mcreg2[15]), .I1(\tempin[16] ), .I2(n2057), 
            .I3(GND_net), .O(n2112));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i17_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1920_3_lut (.I0(\prodreg1[12] ), .I1(\prodreg2[12] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4341));
    defparam i1920_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_151_i26_3_lut_4_lut (.I0(mpreg[26]), .I1(\sqrin[25] ), .I2(multrdy), 
            .I3(multgo), .O(n2083));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i26_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_86_i15_3_lut (.I0(mcreg1[14]), .I1(mcreg[14]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[14]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i15_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i25_3_lut_4_lut (.I0(mpreg[25]), .I1(\sqrin[24] ), .I2(multrdy), 
            .I3(multgo), .O(n2082));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i25_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i1921_3_lut (.I0(\prodreg3[12] ), .I1(n4341), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4342));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i1921_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i24_3_lut_4_lut (.I0(mpreg[24]), .I1(\sqrin[23] ), .I2(multrdy), 
            .I3(multgo), .O(n2081));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i24_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_158_i16_3_lut (.I0(mcreg2[14]), .I1(\tempin[15] ), .I2(n2057), 
            .I3(GND_net), .O(n2111));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i16_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1923_3_lut (.I0(n4342), .I1(indata_c_12), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[12] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i1923_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_86_i14_3_lut (.I0(mcreg1[13]), .I1(mcreg[13]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[13]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i14_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i23_3_lut_4_lut (.I0(mpreg[23]), .I1(\sqrin[22] ), .I2(multrdy), 
            .I3(multgo), .O(n2080));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i23_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i1888_3_lut (.I0(\prodreg1[11] ), .I1(\prodreg2[11] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4310));
    defparam i1888_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_151_i22_3_lut_4_lut (.I0(mpreg[22]), .I1(\sqrin[21] ), .I2(multrdy), 
            .I3(multgo), .O(n2079));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i22_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i1889_3_lut (.I0(\prodreg3[11] ), .I1(n4310), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4311));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i1889_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_158_i15_3_lut (.I0(mcreg2[13]), .I1(\tempin[14] ), .I2(n2057), 
            .I3(GND_net), .O(n2110));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i15_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_86_i13_3_lut (.I0(mcreg1[12]), .I1(mcreg[12]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[12]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i13_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i21_3_lut_4_lut (.I0(mpreg[21]), .I1(\sqrin[20] ), .I2(multrdy), 
            .I3(multgo), .O(n2078));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i21_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i1891_3_lut (.I0(n4311), .I1(indata_c_11), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[11] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i1891_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i20_3_lut_4_lut (.I0(mpreg[20]), .I1(\sqrin[19] ), .I2(multrdy), 
            .I3(multgo), .O(n2077));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i20_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 sub_83_add_2_35_lut (.I0(GND_net), .I1(prodreg1[33]), .I2(VCC_net), 
            .I3(n5460), .O(prodreg2[33])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_35_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_83_add_2_34_lut (.I0(GND_net), .I1(prodreg1[32]), .I2(VCC_net), 
            .I3(n5459), .O(prodreg2[32])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_34_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_34 (.CI(n5459), .I0(prodreg1[32]), .I1(VCC_net), 
            .CO(n5460));
    SB_LUT4 sub_83_add_2_33_lut (.I0(GND_net), .I1(prodreg1[31]), .I2(n1[32]), 
            .I3(n5458), .O(prodreg2[31])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_33_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_33 (.CI(n5458), .I0(prodreg1[31]), .I1(n1[32]), 
            .CO(n5459));
    SB_LUT4 sub_83_add_2_32_lut (.I0(GND_net), .I1(prodreg1[30]), .I2(n1[31]), 
            .I3(n5457), .O(prodreg2[30])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_32_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_32 (.CI(n5457), .I0(prodreg1[30]), .I1(n1[31]), 
            .CO(n5458));
    SB_LUT4 sub_83_add_2_31_lut (.I0(GND_net), .I1(prodreg1[29]), .I2(n1[30]), 
            .I3(n5456), .O(prodreg2[29])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_31_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_31 (.CI(n5456), .I0(prodreg1[29]), .I1(n1[30]), 
            .CO(n5457));
    SB_LUT4 sub_83_add_2_30_lut (.I0(GND_net), .I1(prodreg1[28]), .I2(n1[29]), 
            .I3(n5455), .O(prodreg2[28])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_30_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_30 (.CI(n5455), .I0(prodreg1[28]), .I1(n1[29]), 
            .CO(n5456));
    SB_LUT4 sub_83_add_2_29_lut (.I0(GND_net), .I1(prodreg1[27]), .I2(n1[28]), 
            .I3(n5454), .O(prodreg2[27])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_29_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_29 (.CI(n5454), .I0(prodreg1[27]), .I1(n1[28]), 
            .CO(n5455));
    SB_LUT4 sub_83_add_2_28_lut (.I0(GND_net), .I1(prodreg1[26]), .I2(n1[27]), 
            .I3(n5453), .O(prodreg2[26])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_28_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_28 (.CI(n5453), .I0(prodreg1[26]), .I1(n1[27]), 
            .CO(n5454));
    SB_LUT4 mux_158_i14_3_lut (.I0(mcreg2[12]), .I1(\tempin[13] ), .I2(n2057), 
            .I3(GND_net), .O(n2109));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i14_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 sub_83_add_2_27_lut (.I0(GND_net), .I1(prodreg1[25]), .I2(n1[26]), 
            .I3(n5452), .O(prodreg2[25])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_27_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_27 (.CI(n5452), .I0(prodreg1[25]), .I1(n1[26]), 
            .CO(n5453));
    SB_LUT4 sub_83_add_2_26_lut (.I0(GND_net), .I1(prodreg1[24]), .I2(n1[25]), 
            .I3(n5451), .O(prodreg2[24])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_26_lut.LUT_INIT = 16'hC33C;
    SB_DFFE prodreg__i31 (.Q(prodreg[31]), .C(clk_c), .E(VCC_net), .D(n3895));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i31 (.Q(\mpreg[31] ), .C(clk_c), .E(VCC_net), .D(n3892));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_CARRY sub_83_add_2_26 (.CI(n5451), .I0(prodreg1[24]), .I1(n1[25]), 
            .CO(n5452));
    SB_CARRY sub_84_add_2_11 (.CI(n5338), .I0(prodreg1[9]), .I1(n1[9]), 
            .CO(n5339));
    SB_LUT4 sub_83_add_2_25_lut (.I0(GND_net), .I1(prodreg1[23]), .I2(n1[24]), 
            .I3(n5450), .O(prodreg2[23])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_25_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_25 (.CI(n5450), .I0(prodreg1[23]), .I1(n1[24]), 
            .CO(n5451));
    SB_LUT4 sub_83_add_2_24_lut (.I0(GND_net), .I1(prodreg1[22]), .I2(n1[23]), 
            .I3(n5449), .O(prodreg2[22])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_24_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_24 (.CI(n5449), .I0(prodreg1[22]), .I1(n1[23]), 
            .CO(n5450));
    SB_LUT4 sub_83_add_2_23_lut (.I0(GND_net), .I1(prodreg1[21]), .I2(n1[22]), 
            .I3(n5448), .O(prodreg2[21])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_23_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_23 (.CI(n5448), .I0(prodreg1[21]), .I1(n1[22]), 
            .CO(n5449));
    SB_LUT4 sub_83_add_2_22_lut (.I0(GND_net), .I1(prodreg1[20]), .I2(n1[21]), 
            .I3(n5447), .O(prodreg2[20])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_22_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_22 (.CI(n5447), .I0(prodreg1[20]), .I1(n1[21]), 
            .CO(n5448));
    SB_LUT4 sub_83_add_2_21_lut (.I0(GND_net), .I1(prodreg1[19]), .I2(n1[20]), 
            .I3(n5446), .O(prodreg2[19])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_21_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 mux_151_i19_3_lut_4_lut (.I0(mpreg[19]), .I1(\sqrin[18] ), .I2(multrdy), 
            .I3(multgo), .O(n2076));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i19_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_CARRY sub_83_add_2_21 (.CI(n5446), .I0(prodreg1[19]), .I1(n1[20]), 
            .CO(n5447));
    SB_LUT4 sub_83_add_2_20_lut (.I0(GND_net), .I1(prodreg1[18]), .I2(n1[19]), 
            .I3(n5445), .O(prodreg2[18])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_20_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_20 (.CI(n5445), .I0(prodreg1[18]), .I1(n1[19]), 
            .CO(n5446));
    SB_LUT4 sub_83_add_2_19_lut (.I0(GND_net), .I1(prodreg1[17]), .I2(n1[18]), 
            .I3(n5444), .O(prodreg2[17])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_19_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_19 (.CI(n5444), .I0(prodreg1[17]), .I1(n1[18]), 
            .CO(n5445));
    SB_LUT4 sub_83_add_2_18_lut (.I0(GND_net), .I1(prodreg1[16]), .I2(n1[17]), 
            .I3(n5443), .O(prodreg2[16])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_18_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_18 (.CI(n5443), .I0(prodreg1[16]), .I1(n1[17]), 
            .CO(n5444));
    SB_LUT4 sub_83_add_2_17_lut (.I0(GND_net), .I1(prodreg1[15]), .I2(n1[16]), 
            .I3(n5442), .O(prodreg2[15])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_17_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_17 (.CI(n5442), .I0(prodreg1[15]), .I1(n1[16]), 
            .CO(n5443));
    SB_LUT4 sub_83_add_2_16_lut (.I0(GND_net), .I1(prodreg1[14]), .I2(n1[15]), 
            .I3(n5441), .O(prodreg2[14])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_16_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_16 (.CI(n5441), .I0(prodreg1[14]), .I1(n1[15]), 
            .CO(n5442));
    SB_LUT4 sub_83_add_2_15_lut (.I0(GND_net), .I1(prodreg1[13]), .I2(n1[14]), 
            .I3(n5440), .O(prodreg2[13])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_15_lut.LUT_INIT = 16'hC33C;
    SB_DFF modreg1__i32 (.Q(modreg1[31]), .C(clk_c), .D(n3858));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i31 (.Q(modreg1[30]), .C(clk_c), .D(n3857));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i30 (.Q(modreg1[29]), .C(clk_c), .D(n3856));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i29 (.Q(modreg1[28]), .C(clk_c), .D(n3855));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i28 (.Q(modreg1[27]), .C(clk_c), .D(n3854));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i27 (.Q(modreg1[26]), .C(clk_c), .D(n3853));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i26 (.Q(modreg1[25]), .C(clk_c), .D(n3852));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i25 (.Q(modreg1[24]), .C(clk_c), .D(n3851));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i24 (.Q(modreg1[23]), .C(clk_c), .D(n3850));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i23 (.Q(modreg1[22]), .C(clk_c), .D(n3849));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i22 (.Q(modreg1[21]), .C(clk_c), .D(n3848));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i21 (.Q(modreg1[20]), .C(clk_c), .D(n3847));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i20 (.Q(modreg1[19]), .C(clk_c), .D(n3846));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i19 (.Q(modreg1[18]), .C(clk_c), .D(n3845));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i18 (.Q(modreg1[17]), .C(clk_c), .D(n3844));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i17 (.Q(modreg1[16]), .C(clk_c), .D(n3843));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i16 (.Q(modreg1[15]), .C(clk_c), .D(n3842));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i15 (.Q(modreg1[14]), .C(clk_c), .D(n3841));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i14 (.Q(modreg1[13]), .C(clk_c), .D(n3840));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i13 (.Q(modreg1[12]), .C(clk_c), .D(n3839));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i12 (.Q(modreg1[11]), .C(clk_c), .D(n3838));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i11 (.Q(modreg1[10]), .C(clk_c), .D(n3837));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i10 (.Q(modreg1[9]), .C(clk_c), .D(n3836));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i9 (.Q(modreg1[8]), .C(clk_c), .D(n3835));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i8 (.Q(modreg1[7]), .C(clk_c), .D(n3834));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i7 (.Q(modreg1[6]), .C(clk_c), .D(n3833));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i6 (.Q(modreg1[5]), .C(clk_c), .D(n3832));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i5 (.Q(modreg1[4]), .C(clk_c), .D(n3831));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i1 (.Q(mpreg[1]), .C(clk_c), .E(n2179), .D(n2059));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_86_i12_3_lut (.I0(mcreg1[11]), .I1(mcreg[11]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[11]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i12_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_158_i13_3_lut (.I0(mcreg2[11]), .I1(\tempin[12] ), .I2(n2057), 
            .I3(GND_net), .O(n2108));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i13_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i18_3_lut_4_lut (.I0(mpreg[18]), .I1(\sqrin[17] ), .I2(multrdy), 
            .I3(multgo), .O(n2075));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i18_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_86_i11_3_lut (.I0(mcreg1[10]), .I1(mcreg[10]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[10]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i11_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 sub_84_add_2_10_lut (.I0(GND_net), .I1(prodreg1[8]), .I2(n1[8]), 
            .I3(n5337), .O(prodreg3[8])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_10_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_10 (.CI(n5337), .I0(prodreg1[8]), .I1(n1[8]), 
            .CO(n5338));
    SB_LUT4 sub_84_add_2_9_lut (.I0(GND_net), .I1(prodreg1[7]), .I2(n1[7]), 
            .I3(n5336), .O(prodreg3[7])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_9_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_9 (.CI(n5336), .I0(prodreg1[7]), .I1(n1[7]), 
            .CO(n5337));
    SB_LUT4 sub_84_add_2_8_lut (.I0(GND_net), .I1(prodreg1[6]), .I2(n1[6]), 
            .I3(n5335), .O(prodreg3[6])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_8_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_8 (.CI(n5335), .I0(prodreg1[6]), .I1(n1[6]), 
            .CO(n5336));
    SB_LUT4 sub_84_add_2_7_lut (.I0(GND_net), .I1(prodreg1[5]), .I2(n1[5]), 
            .I3(n5334), .O(prodreg3[5])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_7_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_7 (.CI(n5334), .I0(prodreg1[5]), .I1(n1[5]), 
            .CO(n5335));
    SB_LUT4 sub_84_add_2_6_lut (.I0(GND_net), .I1(prodreg1[4]), .I2(n1[4]), 
            .I3(n5333), .O(prodreg3[4])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_6_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_6 (.CI(n5333), .I0(prodreg1[4]), .I1(n1[4]), 
            .CO(n5334));
    SB_LUT4 sub_84_add_2_5_lut (.I0(GND_net), .I1(prodreg1[3]), .I2(n1[3]), 
            .I3(n5332), .O(prodreg3[3])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_5_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_5 (.CI(n5332), .I0(prodreg1[3]), .I1(n1[3]), 
            .CO(n5333));
    SB_LUT4 sub_84_add_2_4_lut (.I0(GND_net), .I1(prodreg1[2]), .I2(n1[2]), 
            .I3(n5331), .O(prodreg3[2])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_4_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_4 (.CI(n5331), .I0(prodreg1[2]), .I1(n1[2]), 
            .CO(n5332));
    SB_LUT4 sub_84_add_2_3_lut (.I0(GND_net), .I1(prodreg1[1]), .I2(n1[1]), 
            .I3(n5330), .O(prodreg3[1])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_3_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 mux_151_i17_3_lut_4_lut (.I0(mpreg[17]), .I1(\sqrin[16] ), .I2(multrdy), 
            .I3(multgo), .O(n2074));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i17_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_CARRY sub_84_add_2_3 (.CI(n5330), .I0(prodreg1[1]), .I1(n1[1]), 
            .CO(n5331));
    SB_DFF modreg1__i4 (.Q(modreg1[3]), .C(clk_c), .D(n3830));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_CARRY sub_84_add_2_2 (.CI(VCC_net), .I0(prodreg3[0]), .I1(VCC_net), 
            .CO(n5330));
    SB_CARRY sub_83_add_2_15 (.CI(n5440), .I0(prodreg1[13]), .I1(n1[14]), 
            .CO(n5441));
    SB_LUT4 sub_83_add_2_14_lut (.I0(GND_net), .I1(prodreg1[12]), .I2(n1[13]), 
            .I3(n5439), .O(prodreg2[12])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_14_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_14 (.CI(n5439), .I0(prodreg1[12]), .I1(n1[13]), 
            .CO(n5440));
    SB_LUT4 sub_83_add_2_13_lut (.I0(GND_net), .I1(prodreg1[11]), .I2(n1[12]), 
            .I3(n5438), .O(prodreg2[11])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_13_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_13 (.CI(n5438), .I0(prodreg1[11]), .I1(n1[12]), 
            .CO(n5439));
    SB_LUT4 sub_83_add_2_12_lut (.I0(GND_net), .I1(prodreg1[10]), .I2(n1[11]), 
            .I3(n5437), .O(prodreg2[10])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_12_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_12 (.CI(n5437), .I0(prodreg1[10]), .I1(n1[11]), 
            .CO(n5438));
    SB_LUT4 sub_83_add_2_11_lut (.I0(GND_net), .I1(prodreg1[9]), .I2(n1[10]), 
            .I3(n5436), .O(prodreg2[9])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_11_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_11 (.CI(n5436), .I0(prodreg1[9]), .I1(n1[10]), 
            .CO(n5437));
    SB_LUT4 sub_83_add_2_10_lut (.I0(GND_net), .I1(prodreg1[8]), .I2(n1[9]), 
            .I3(n5435), .O(prodreg2[8])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_10_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_10 (.CI(n5435), .I0(prodreg1[8]), .I1(n1[9]), 
            .CO(n5436));
    SB_LUT4 sub_83_add_2_9_lut (.I0(GND_net), .I1(prodreg1[7]), .I2(n1[8]), 
            .I3(n5434), .O(prodreg2[7])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_9_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_9 (.CI(n5434), .I0(prodreg1[7]), .I1(n1[8]), 
            .CO(n5435));
    SB_LUT4 sub_83_add_2_8_lut (.I0(GND_net), .I1(prodreg1[6]), .I2(n1[7]), 
            .I3(n5433), .O(prodreg2[6])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_8_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_8 (.CI(n5433), .I0(prodreg1[6]), .I1(n1[7]), 
            .CO(n5434));
    SB_LUT4 sub_83_add_2_7_lut (.I0(GND_net), .I1(prodreg1[5]), .I2(n1[6]), 
            .I3(n5432), .O(prodreg2[5])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_7_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_7 (.CI(n5432), .I0(prodreg1[5]), .I1(n1[6]), 
            .CO(n5433));
    SB_LUT4 sub_83_add_2_6_lut (.I0(GND_net), .I1(prodreg1[4]), .I2(n1[5]), 
            .I3(n5431), .O(prodreg2[4])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_6_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_6 (.CI(n5431), .I0(prodreg1[4]), .I1(n1[5]), 
            .CO(n5432));
    SB_LUT4 sub_83_add_2_5_lut (.I0(GND_net), .I1(prodreg1[3]), .I2(n1[4]), 
            .I3(n5430), .O(prodreg2[3])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_5_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_5 (.CI(n5430), .I0(prodreg1[3]), .I1(n1[4]), 
            .CO(n5431));
    SB_LUT4 sub_83_add_2_4_lut (.I0(GND_net), .I1(prodreg1[2]), .I2(n1[3]), 
            .I3(n5429), .O(prodreg2[2])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_4_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_4 (.CI(n5429), .I0(prodreg1[2]), .I1(n1[3]), 
            .CO(n5430));
    SB_LUT4 sub_83_add_2_3_lut (.I0(GND_net), .I1(prodreg1[1]), .I2(n1[2]), 
            .I3(n5428), .O(prodreg2[1])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_3_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_3 (.CI(n5428), .I0(prodreg1[1]), .I1(n1[2]), 
            .CO(n5429));
    SB_LUT4 sub_83_add_2_2_lut (.I0(GND_net), .I1(prodreg3[0]), .I2(n1[1]), 
            .I3(VCC_net), .O(prodreg2[0])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_83_add_2_2_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_83_add_2_2 (.CI(VCC_net), .I0(prodreg3[0]), .I1(n1[1]), 
            .CO(n5428));
    SB_LUT4 mux_158_i12_3_lut (.I0(mcreg2[10]), .I1(\tempin[11] ), .I2(n2057), 
            .I3(GND_net), .O(n2107));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i12_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i16_3_lut_4_lut (.I0(mpreg[16]), .I1(\sqrin[15] ), .I2(multrdy), 
            .I3(multgo), .O(n2073));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i16_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_DFF modreg1__i3 (.Q(modreg1[2]), .C(clk_c), .D(n3829));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i2 (.Q(modreg1[1]), .C(clk_c), .D(n3828));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF modreg1__i1 (.Q(modreg1[0]), .C(clk_c), .D(n3826));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i2 (.Q(mpreg[2]), .C(clk_c), .E(n2179), .D(n2060));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_CARRY add_281_14 (.CI(n5243), .I0(prodreg_c[12]), .I1(n2753[12]), 
            .CO(n5244));
    SB_LUT4 add_281_13_lut (.I0(GND_net), .I1(prodreg_c[11]), .I2(n2753[11]), 
            .I3(n5242), .O(prodreg1[11])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_13_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_2_lut (.I0(GND_net), .I1(\prodreg[0] ), .I2(n2753[0]), 
            .I3(GND_net), .O(prodreg3[0])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_2_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_9 (.CI(n5238), .I0(\prodreg[7] ), .I1(n2753[7]), 
            .CO(n5239));
    SB_LUT4 sub_84_add_2_20_lut (.I0(GND_net), .I1(prodreg1[18]), .I2(n1[18]), 
            .I3(n5347), .O(prodreg3[18])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_20_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_20 (.CI(n5347), .I0(prodreg1[18]), .I1(n1[18]), 
            .CO(n5348));
    SB_LUT4 sub_84_add_2_19_lut (.I0(GND_net), .I1(prodreg1[17]), .I2(n1[17]), 
            .I3(n5346), .O(prodreg3[17])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_19_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_84_add_2_18_lut (.I0(GND_net), .I1(prodreg1[16]), .I2(n1[16]), 
            .I3(n5345), .O(prodreg3[16])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_18_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 mux_151_i15_3_lut_4_lut (.I0(mpreg[15]), .I1(\sqrin[14] ), .I2(multrdy), 
            .I3(multgo), .O(n2072));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i15_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_DFFE mpreg_i0_i3 (.Q(mpreg[3]), .C(clk_c), .E(n2179), .D(n2061));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i4 (.Q(mpreg[4]), .C(clk_c), .E(n2179), .D(n2062));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i5 (.Q(mpreg[5]), .C(clk_c), .E(n2179), .D(n2063));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i6 (.Q(mpreg[6]), .C(clk_c), .E(n2179), .D(n2064));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i7 (.Q(mpreg[7]), .C(clk_c), .E(n2179), .D(n2065));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i8 (.Q(mpreg[8]), .C(clk_c), .E(n2179), .D(n2066));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i9 (.Q(mpreg[9]), .C(clk_c), .E(n2179), .D(n2067));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i10 (.Q(mpreg[10]), .C(clk_c), .E(n2179), .D(n2068));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i11 (.Q(mpreg[11]), .C(clk_c), .E(n2179), .D(n2069));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i12 (.Q(mpreg[12]), .C(clk_c), .E(n2179), .D(n2070));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i13 (.Q(mpreg[13]), .C(clk_c), .E(n2179), .D(n2071));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i14 (.Q(mpreg[14]), .C(clk_c), .E(n2179), .D(n2072));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i15 (.Q(mpreg[15]), .C(clk_c), .E(n2179), .D(n2073));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i16 (.Q(mpreg[16]), .C(clk_c), .E(n2179), .D(n2074));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i17 (.Q(mpreg[17]), .C(clk_c), .E(n2179), .D(n2075));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i18 (.Q(mpreg[18]), .C(clk_c), .E(n2179), .D(n2076));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i19 (.Q(mpreg[19]), .C(clk_c), .E(n2179), .D(n2077));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i20 (.Q(mpreg[20]), .C(clk_c), .E(n2179), .D(n2078));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i21 (.Q(mpreg[21]), .C(clk_c), .E(n2179), .D(n2079));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i22 (.Q(mpreg[22]), .C(clk_c), .E(n2179), .D(n2080));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i23 (.Q(mpreg[23]), .C(clk_c), .E(n2179), .D(n2081));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i24 (.Q(mpreg[24]), .C(clk_c), .E(n2179), .D(n2082));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i25 (.Q(mpreg[25]), .C(clk_c), .E(n2179), .D(n2083));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i26 (.Q(mpreg[26]), .C(clk_c), .E(n2179), .D(n2084));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i27 (.Q(mpreg[27]), .C(clk_c), .E(n2179), .D(n2085));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i28 (.Q(mpreg[28]), .C(clk_c), .E(n2179), .D(n2086));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i29 (.Q(mpreg[29]), .C(clk_c), .E(n2179), .D(n2087));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mpreg_i0_i30 (.Q(mpreg[30]), .C(clk_c), .E(n2179), .D(n2088));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF prodreg__i29 (.Q(prodreg_c[29]), .C(clk_c), .D(n4112));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_86_i10_3_lut (.I0(mcreg1[9]), .I1(mcreg[9]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[9]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i10_3_lut.LUT_INIT = 16'hcaca;
    SB_DFF prodreg__i28 (.Q(prodreg_c[28]), .C(clk_c), .D(n4108));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE mcreg_i0_i0 (.Q(\mcreg[0] ), .C(clk_c), .E(VCC_net), .D(n4107));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF prodreg__i27 (.Q(prodreg_c[27]), .C(clk_c), .D(n4104));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_CARRY sub_84_add_2_18 (.CI(n5345), .I0(prodreg1[16]), .I1(n1[16]), 
            .CO(n5346));
    SB_DFF prodreg__i26 (.Q(prodreg_c[26]), .C(clk_c), .D(n4097));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_151_i14_3_lut_4_lut (.I0(mpreg[14]), .I1(\sqrin[13] ), .I2(multrdy), 
            .I3(multgo), .O(n2071));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i14_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_DFF prodreg__i25 (.Q(prodreg_c[25]), .C(clk_c), .D(n4087));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_158_i11_3_lut (.I0(mcreg2[9]), .I1(\tempin[10] ), .I2(n2057), 
            .I3(GND_net), .O(n2106));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i11_3_lut.LUT_INIT = 16'hcaca;
    SB_DFF prodreg__i24 (.Q(prodreg_c[24]), .C(clk_c), .D(n4077));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF prodreg__i23 (.Q(prodreg_c[23]), .C(clk_c), .D(n4067));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_86_i9_3_lut (.I0(mcreg1[8]), .I1(mcreg[8]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[8]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i9_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_158_i10_3_lut (.I0(mcreg2[8]), .I1(\tempin[9] ), .I2(n2057), 
            .I3(GND_net), .O(n2105));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i10_3_lut.LUT_INIT = 16'hcaca;
    SB_DFF prodreg__i22 (.Q(prodreg_c[22]), .C(clk_c), .D(n4060));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i0 (.Q(\prodreg[0] ), .C(clk_c), .E(VCC_net), .D(n4053));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF prodreg__i21 (.Q(prodreg_c[21]), .C(clk_c), .D(n4050));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_86_i8_3_lut (.I0(mcreg1[7]), .I1(mcreg[7]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[7]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i8_3_lut.LUT_INIT = 16'hcaca;
    SB_DFF prodreg__i20 (.Q(prodreg_c[20]), .C(clk_c), .D(n4040));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF prodreg__i19 (.Q(prodreg_c[19]), .C(clk_c), .D(n4030));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_158_i9_3_lut (.I0(mcreg2[7]), .I1(\tempin[8] ), .I2(n2057), 
            .I3(GND_net), .O(n2104));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i9_3_lut.LUT_INIT = 16'hcaca;
    SB_DFF prodreg__i18 (.Q(prodreg_c[18]), .C(clk_c), .D(n4020));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF prodreg__i17 (.Q(prodreg_c[17]), .C(clk_c), .D(n4010));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_86_i7_3_lut (.I0(mcreg1[6]), .I1(mcreg[6]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[6]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i7_3_lut.LUT_INIT = 16'hcaca;
    SB_DFF prodreg__i16 (.Q(prodreg_c[16]), .C(clk_c), .D(n4000));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF prodreg__i15 (.Q(prodreg_c[15]), .C(clk_c), .D(n3993));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_158_i8_3_lut (.I0(mcreg2[6]), .I1(\tempin[7] ), .I2(n2057), 
            .I3(GND_net), .O(n2103));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i8_3_lut.LUT_INIT = 16'hcaca;
    SB_DFF prodreg__i14 (.Q(prodreg_c[14]), .C(clk_c), .D(n3989));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 i2493_2_lut (.I0(mcreg[27]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[27]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2493_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 sub_84_inv_0_i10_1_lut (.I0(modreg1[8]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[9]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i10_1_lut.LUT_INIT = 16'h5555;
    SB_DFFE prodreg__i1 (.Q(\prodreg[1] ), .C(clk_c), .E(VCC_net), .D(n3988));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i2 (.Q(\prodreg[2] ), .C(clk_c), .E(VCC_net), .D(n3985));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFF prodreg__i13 (.Q(prodreg_c[13]), .C(clk_c), .D(n3982));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 i2502_2_lut (.I0(mcreg[18]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[18]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2502_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 mux_86_i6_3_lut (.I0(mcreg1[5]), .I1(mcreg[5]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[5]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i6_3_lut.LUT_INIT = 16'hcaca;
    SB_CARRY sub_84_add_2_19 (.CI(n5346), .I0(prodreg1[17]), .I1(n1[17]), 
            .CO(n5347));
    SB_LUT4 sub_84_add_2_17_lut (.I0(GND_net), .I1(prodreg1[15]), .I2(n1[15]), 
            .I3(n5344), .O(prodreg3[15])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_17_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_17 (.CI(n5344), .I0(prodreg1[15]), .I1(n1[15]), 
            .CO(n5345));
    SB_LUT4 sub_84_add_2_16_lut (.I0(GND_net), .I1(prodreg1[14]), .I2(n1[14]), 
            .I3(n5343), .O(prodreg3[14])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_16_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_16 (.CI(n5343), .I0(prodreg1[14]), .I1(n1[14]), 
            .CO(n5344));
    SB_LUT4 sub_84_add_2_15_lut (.I0(GND_net), .I1(prodreg1[13]), .I2(n1[13]), 
            .I3(n5342), .O(prodreg3[13])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_15_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 i2492_2_lut (.I0(mcreg[28]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[28]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2492_2_lut.LUT_INIT = 16'h8888;
    SB_DFFESR prodreg__i33 (.Q(prodreg_c[33]), .C(clk_c), .E(n2179), .D(prodreg4[33]), 
            .R(n2912));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i3 (.Q(\prodreg[3] ), .C(clk_c), .E(VCC_net), .D(n3981));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFESR prodreg__i32 (.Q(prodreg_c[32]), .C(clk_c), .E(n2179), .D(prodreg4[32]), 
            .R(n2912));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i4 (.Q(\prodreg[4] ), .C(clk_c), .E(VCC_net), .D(n3978));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 i2501_2_lut (.I0(mcreg[19]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[19]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2501_2_lut.LUT_INIT = 16'h8888;
    SB_DFFE prodreg__i5 (.Q(prodreg[5]), .C(clk_c), .E(VCC_net), .D(n3975));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 i2485_2_lut (.I0(mcreg[2]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2753[2]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2485_2_lut.LUT_INIT = 16'h8888;
    SB_DFF prodreg__i12 (.Q(prodreg_c[12]), .C(clk_c), .D(n3972));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 i2491_2_lut (.I0(mcreg[29]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[29]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2491_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 mux_158_i7_3_lut (.I0(mcreg2[5]), .I1(\tempin[6] ), .I2(n2057), 
            .I3(GND_net), .O(n2102));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i7_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_86_i5_3_lut (.I0(mcreg1[4]), .I1(mcreg[4]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[4]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i5_3_lut.LUT_INIT = 16'hcaca;
    SB_DFFE prodreg__i6 (.Q(\prodreg[6] ), .C(clk_c), .E(VCC_net), .D(n3971));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i7 (.Q(\prodreg[7] ), .C(clk_c), .E(VCC_net), .D(n3968));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 mux_158_i6_3_lut (.I0(mcreg2[4]), .I1(\tempin[5] ), .I2(n2057), 
            .I3(GND_net), .O(n2101));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i6_3_lut.LUT_INIT = 16'hcaca;
    SB_DFF prodreg__i11 (.Q(prodreg_c[11]), .C(clk_c), .D(n3965));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i8 (.Q(prodreg[8]), .C(clk_c), .E(VCC_net), .D(n3964));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_DFFE prodreg__i9 (.Q(\prodreg[9] ), .C(clk_c), .E(VCC_net), .D(n3961));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 i2513_2_lut (.I0(mcreg[7]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2753[7]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2513_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 sub_93_add_2_34_lut (.I0(GND_net), .I1(mcreg[32]), .I2(VCC_net), 
            .I3(n5296), .O(\mcreg1[32] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_34_lut.LUT_INIT = 16'hC33C;
    SB_DFFE prodreg__i10 (.Q(\prodreg[10] ), .C(clk_c), .E(VCC_net), .D(n3958));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 sub_93_add_2_33_lut (.I0(GND_net), .I1(mcreg[31]), .I2(n1[32]), 
            .I3(n5295), .O(mcreg1[31])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_33_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_33 (.CI(n5295), .I0(mcreg[31]), .I1(n1[32]), 
            .CO(n5296));
    SB_LUT4 i2500_2_lut (.I0(mcreg[20]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[20]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2500_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2499_2_lut (.I0(mcreg[21]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[21]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2499_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 sub_93_add_2_32_lut (.I0(GND_net), .I1(mcreg[30]), .I2(n1[31]), 
            .I3(n5294), .O(mcreg1[30])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_32_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 i2490_2_lut (.I0(mcreg[30]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[30]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2490_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2512_2_lut (.I0(mcreg[8]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2753[8]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2512_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 mux_86_i4_3_lut (.I0(mcreg1[3]), .I1(mcreg[3]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[3]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i4_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_158_i5_3_lut (.I0(mcreg2[3]), .I1(\tempin[4] ), .I2(n2057), 
            .I3(GND_net), .O(n2100));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i5_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i13_3_lut_4_lut (.I0(mpreg[13]), .I1(\sqrin[12] ), .I2(multrdy), 
            .I3(multgo), .O(n2070));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i13_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_86_i3_3_lut (.I0(mcreg1[2]), .I1(mcreg[2]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[2]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i3_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_158_i4_3_lut (.I0(mcreg2[2]), .I1(\tempin[3] ), .I2(n2057), 
            .I3(GND_net), .O(n2099));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i4_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i12_3_lut_4_lut (.I0(mpreg[12]), .I1(\sqrin[11] ), .I2(multrdy), 
            .I3(multgo), .O(n2069));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i12_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_151_i11_3_lut_4_lut (.I0(mpreg[11]), .I1(\sqrin[10] ), .I2(multrdy), 
            .I3(multgo), .O(n2068));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i11_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i578_3_lut (.I0(prodreg1[31]), .I1(prodreg2[31]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n3001));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i578_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_272_i32_3_lut (.I0(prodreg3[31]), .I1(n3001), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[31]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_272_i32_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i10_3_lut_4_lut (.I0(mpreg[10]), .I1(\sqrin[9] ), .I2(multrdy), 
            .I3(multgo), .O(n2067));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i10_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_86_i2_3_lut (.I0(mcreg1[1]), .I1(mcreg[1]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[1]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i2_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 sub_84_inv_0_i11_1_lut (.I0(modreg1[9]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[10]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i11_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 mux_158_i3_3_lut (.I0(mcreg2[1]), .I1(\tempin[2] ), .I2(n2057), 
            .I3(GND_net), .O(n2098));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_158_i3_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i169_2_lut (.I0(multrdy), .I1(multgo), .I2(GND_net), .I3(GND_net), 
            .O(n2057));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam i169_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1849_3_lut (.I0(prodreg1[29]), .I1(prodreg2[29]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4272));
    defparam i1849_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i1851_3_lut (.I0(prodreg3[29]), .I1(n4272), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[29]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i1851_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i178_2_lut (.I0(n2132), .I1(reset_c), .I2(GND_net), .I3(GND_net), 
            .O(n2179));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i178_2_lut.LUT_INIT = 16'h1111;
    SB_LUT4 i1855_4_lut (.I0(tempout[29]), .I1(indata_c_29), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[29] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i1855_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i2425_3_lut (.I0(prodreg1[28]), .I1(prodreg2[28]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4830));
    defparam i2425_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i577_3_lut (.I0(prodreg1[30]), .I1(prodreg2[30]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n3000));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i577_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2427_3_lut (.I0(prodreg3[28]), .I1(n4830), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[28]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2427_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_272_i31_3_lut (.I0(prodreg3[30]), .I1(n3000), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[30]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_272_i31_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2431_4_lut (.I0(tempout[28]), .I1(indata_c_28), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[28] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2431_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i2393_3_lut (.I0(prodreg1[27]), .I1(prodreg2[27]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4799));
    defparam i2393_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2395_3_lut (.I0(prodreg3[27]), .I1(n4799), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[27]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2395_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2399_4_lut (.I0(tempout[27]), .I1(indata_c_27), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[27] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2399_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i24_4_lut (.I0(mpreg[29]), .I1(mpreg[3]), .I2(mpreg[13]), 
            .I3(\mpreg[31] ), .O(n56));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(151[8:17])
    defparam i24_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i22_4_lut (.I0(mpreg[19]), .I1(mpreg[5]), .I2(mpreg[22]), 
            .I3(mpreg[6]), .O(n54));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(151[8:17])
    defparam i22_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i2361_3_lut (.I0(prodreg1[26]), .I1(prodreg2[26]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4768));
    defparam i2361_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i23_4_lut (.I0(mpreg[10]), .I1(mpreg[15]), .I2(mpreg[20]), 
            .I3(mpreg[23]), .O(n55));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(151[8:17])
    defparam i23_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i21_4_lut (.I0(mpreg[27]), .I1(mpreg[7]), .I2(mpreg[30]), 
            .I3(mpreg[14]), .O(n53));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(151[8:17])
    defparam i21_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i20_4_lut (.I0(mpreg[17]), .I1(mpreg[1]), .I2(mpreg[24]), 
            .I3(mpreg[4]), .O(n52));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(151[8:17])
    defparam i20_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i2363_3_lut (.I0(prodreg3[26]), .I1(n4768), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[26]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2363_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2367_4_lut (.I0(tempout[26]), .I1(indata_c_26), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[26] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2367_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i2329_3_lut (.I0(prodreg1[25]), .I1(prodreg2[25]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4737));
    defparam i2329_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2331_3_lut (.I0(prodreg3[25]), .I1(n4737), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[25]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2331_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i18_4_lut (.I0(mpreg[8]), .I1(mpreg[11]), .I2(mpreg[16]), 
            .I3(mpreg[21]), .O(n50));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(151[8:17])
    defparam i18_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i2335_4_lut (.I0(tempout[25]), .I1(indata_c_25), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[25] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2335_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i2297_3_lut (.I0(prodreg1[24]), .I1(prodreg2[24]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4706));
    defparam i2297_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i19_4_lut (.I0(mpreg[25]), .I1(mpreg[9]), .I2(mpreg[26]), 
            .I3(mpreg[12]), .O(n51));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(151[8:17])
    defparam i19_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i3209_4_lut (.I0(mpreg[28]), .I1(mpreg[18]), .I2(mpreg[0]), 
            .I3(mpreg[2]), .O(n5760));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam i3209_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i2299_3_lut (.I0(prodreg3[24]), .I1(n4706), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[24]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2299_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i30_4_lut (.I0(n53), .I1(n55), .I2(n54), .I3(n56), .O(n62));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(151[8:17])
    defparam i30_4_lut.LUT_INIT = 16'hfffe;
    SB_CARRY sub_93_add_2_32 (.CI(n5294), .I0(mcreg[30]), .I1(n1[31]), 
            .CO(n5295));
    SB_LUT4 sub_93_add_2_31_lut (.I0(GND_net), .I1(mcreg[29]), .I2(n1[30]), 
            .I3(n5293), .O(mcreg1[29])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_31_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_31 (.CI(n5293), .I0(mcreg[29]), .I1(n1[30]), 
            .CO(n5294));
    SB_LUT4 sub_93_add_2_30_lut (.I0(GND_net), .I1(mcreg[28]), .I2(n1[29]), 
            .I3(n5292), .O(mcreg1[28])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_30_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_30 (.CI(n5292), .I0(mcreg[28]), .I1(n1[29]), 
            .CO(n5293));
    SB_DFFESR mcreg_i0_i33 (.Q(mcreg[33]), .C(clk_c), .E(n2179), .D(mcreg2[32]), 
            .R(n2912));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 sub_93_add_2_29_lut (.I0(GND_net), .I1(mcreg[27]), .I2(n1[28]), 
            .I3(n5291), .O(mcreg1[27])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_29_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_29 (.CI(n5291), .I0(mcreg[27]), .I1(n1[28]), 
            .CO(n5292));
    SB_DFFESR mcreg_i0_i32 (.Q(mcreg[32]), .C(clk_c), .E(n2179), .D(mcreg2[31]), 
            .R(n2912));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    SB_LUT4 sub_93_add_2_28_lut (.I0(GND_net), .I1(mcreg[26]), .I2(n1[27]), 
            .I3(n5290), .O(mcreg1[26])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_28_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_28 (.CI(n5290), .I0(mcreg[26]), .I1(n1[27]), 
            .CO(n5291));
    SB_LUT4 sub_93_add_2_27_lut (.I0(GND_net), .I1(mcreg[25]), .I2(n1[26]), 
            .I3(n5289), .O(mcreg1[25])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_27_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_27 (.CI(n5289), .I0(mcreg[25]), .I1(n1[26]), 
            .CO(n5290));
    SB_LUT4 sub_93_add_2_26_lut (.I0(GND_net), .I1(mcreg[24]), .I2(n1[25]), 
            .I3(n5288), .O(mcreg1[24])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_26_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_26 (.CI(n5288), .I0(mcreg[24]), .I1(n1[25]), 
            .CO(n5289));
    SB_LUT4 sub_93_add_2_25_lut (.I0(GND_net), .I1(mcreg[23]), .I2(n1[24]), 
            .I3(n5287), .O(mcreg1[23])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_25_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_25 (.CI(n5287), .I0(mcreg[23]), .I1(n1[24]), 
            .CO(n5288));
    SB_LUT4 sub_84_add_2_35_lut (.I0(GND_net), .I1(prodreg1[33]), .I2(VCC_net), 
            .I3(n5362), .O(prodreg3[33])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_35_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_84_add_2_34_lut (.I0(GND_net), .I1(prodreg1[32]), .I2(n1[32]), 
            .I3(n5361), .O(prodreg3[32])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_34_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_93_add_2_24_lut (.I0(GND_net), .I1(mcreg[22]), .I2(n1[23]), 
            .I3(n5286), .O(mcreg1[22])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_24_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_34 (.CI(n5361), .I0(prodreg1[32]), .I1(n1[32]), 
            .CO(n5362));
    SB_CARRY sub_93_add_2_24 (.CI(n5286), .I0(mcreg[22]), .I1(n1[23]), 
            .CO(n5287));
    SB_LUT4 sub_84_add_2_33_lut (.I0(GND_net), .I1(prodreg1[31]), .I2(n1[31]), 
            .I3(n5360), .O(prodreg3[31])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_33_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_33 (.CI(n5360), .I0(prodreg1[31]), .I1(n1[31]), 
            .CO(n5361));
    SB_LUT4 sub_84_add_2_32_lut (.I0(GND_net), .I1(prodreg1[30]), .I2(n1[30]), 
            .I3(n5359), .O(prodreg3[30])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_32_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_93_add_2_23_lut (.I0(GND_net), .I1(mcreg[21]), .I2(n1[22]), 
            .I3(n5285), .O(mcreg1[21])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_23_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_32 (.CI(n5359), .I0(prodreg1[30]), .I1(n1[30]), 
            .CO(n5360));
    SB_CARRY sub_93_add_2_23 (.CI(n5285), .I0(mcreg[21]), .I1(n1[22]), 
            .CO(n5286));
    SB_LUT4 sub_84_add_2_31_lut (.I0(GND_net), .I1(prodreg1[29]), .I2(n1[29]), 
            .I3(n5358), .O(prodreg3[29])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_31_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_31 (.CI(n5358), .I0(prodreg1[29]), .I1(n1[29]), 
            .CO(n5359));
    SB_LUT4 sub_93_add_2_22_lut (.I0(GND_net), .I1(mcreg[20]), .I2(n1[21]), 
            .I3(n5284), .O(mcreg1[20])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_22_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_84_add_2_30_lut (.I0(GND_net), .I1(prodreg1[28]), .I2(n1[28]), 
            .I3(n5357), .O(prodreg3[28])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_30_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_22 (.CI(n5284), .I0(mcreg[20]), .I1(n1[21]), 
            .CO(n5285));
    SB_CARRY sub_84_add_2_30 (.CI(n5357), .I0(prodreg1[28]), .I1(n1[28]), 
            .CO(n5358));
    SB_LUT4 sub_84_add_2_29_lut (.I0(GND_net), .I1(prodreg1[27]), .I2(n1[27]), 
            .I3(n5356), .O(prodreg3[27])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_29_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_93_add_2_21_lut (.I0(GND_net), .I1(mcreg[19]), .I2(n1[20]), 
            .I3(n5283), .O(mcreg1[19])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_21_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_29 (.CI(n5356), .I0(prodreg1[27]), .I1(n1[27]), 
            .CO(n5357));
    SB_CARRY sub_93_add_2_21 (.CI(n5283), .I0(mcreg[19]), .I1(n1[20]), 
            .CO(n5284));
    SB_LUT4 i3207_4_lut (.I0(n5760), .I1(n51), .I2(n50), .I3(n52), .O(n5758));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam i3207_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 sub_84_add_2_28_lut (.I0(GND_net), .I1(prodreg1[26]), .I2(n1[26]), 
            .I3(n5355), .O(prodreg3[26])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_28_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_28 (.CI(n5355), .I0(prodreg1[26]), .I1(n1[26]), 
            .CO(n5356));
    SB_LUT4 sub_93_add_2_20_lut (.I0(GND_net), .I1(mcreg[18]), .I2(n1[19]), 
            .I3(n5282), .O(mcreg1[18])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_20_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_84_add_2_27_lut (.I0(GND_net), .I1(prodreg1[25]), .I2(n1[25]), 
            .I3(n5354), .O(prodreg3[25])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_27_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_20 (.CI(n5282), .I0(mcreg[18]), .I1(n1[19]), 
            .CO(n5283));
    SB_CARRY sub_84_add_2_27 (.CI(n5354), .I0(prodreg1[25]), .I1(n1[25]), 
            .CO(n5355));
    SB_LUT4 sub_84_add_2_26_lut (.I0(GND_net), .I1(prodreg1[24]), .I2(n1[24]), 
            .I3(n5353), .O(prodreg3[24])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_26_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_26 (.CI(n5353), .I0(prodreg1[24]), .I1(n1[24]), 
            .CO(n5354));
    SB_LUT4 sub_93_add_2_19_lut (.I0(GND_net), .I1(mcreg[17]), .I2(n1[18]), 
            .I3(n5281), .O(mcreg1[17])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_19_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_84_add_2_25_lut (.I0(GND_net), .I1(prodreg1[23]), .I2(n1[23]), 
            .I3(n5352), .O(prodreg3[23])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_25_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_19 (.CI(n5281), .I0(mcreg[17]), .I1(n1[18]), 
            .CO(n5282));
    SB_CARRY sub_84_add_2_25 (.CI(n5352), .I0(prodreg1[23]), .I1(n1[23]), 
            .CO(n5353));
    SB_LUT4 sub_84_add_2_24_lut (.I0(GND_net), .I1(prodreg1[22]), .I2(n1[22]), 
            .I3(n5351), .O(prodreg3[22])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_24_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_24 (.CI(n5351), .I0(prodreg1[22]), .I1(n1[22]), 
            .CO(n5352));
    SB_LUT4 sub_93_add_2_18_lut (.I0(GND_net), .I1(mcreg[16]), .I2(n1[17]), 
            .I3(n5280), .O(mcreg1[16])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_18_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_84_add_2_23_lut (.I0(GND_net), .I1(prodreg1[21]), .I2(n1[21]), 
            .I3(n5350), .O(prodreg3[21])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_23_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_18 (.CI(n5280), .I0(mcreg[16]), .I1(n1[17]), 
            .CO(n5281));
    SB_CARRY sub_84_add_2_23 (.CI(n5350), .I0(prodreg1[21]), .I1(n1[21]), 
            .CO(n5351));
    SB_LUT4 sub_93_add_2_17_lut (.I0(GND_net), .I1(mcreg[15]), .I2(n1[16]), 
            .I3(n5279), .O(mcreg1[15])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_17_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_84_add_2_22_lut (.I0(GND_net), .I1(prodreg1[20]), .I2(n1[20]), 
            .I3(n5349), .O(prodreg3[20])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_22_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_17 (.CI(n5279), .I0(mcreg[15]), .I1(n1[16]), 
            .CO(n5280));
    SB_LUT4 sub_93_add_2_16_lut (.I0(GND_net), .I1(mcreg[14]), .I2(n1[15]), 
            .I3(n5278), .O(mcreg1[14])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_16_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_16 (.CI(n5278), .I0(mcreg[14]), .I1(n1[15]), 
            .CO(n5279));
    SB_CARRY sub_84_add_2_22 (.CI(n5349), .I0(prodreg1[20]), .I1(n1[20]), 
            .CO(n5350));
    SB_LUT4 sub_93_add_2_15_lut (.I0(GND_net), .I1(mcreg[13]), .I2(n1[14]), 
            .I3(n5277), .O(mcreg1[13])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_15_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_15 (.CI(n5277), .I0(mcreg[13]), .I1(n1[14]), 
            .CO(n5278));
    SB_LUT4 sub_84_add_2_21_lut (.I0(GND_net), .I1(prodreg1[19]), .I2(n1[19]), 
            .I3(n5348), .O(prodreg3[19])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_84_add_2_21_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_93_add_2_14_lut (.I0(GND_net), .I1(mcreg[12]), .I2(n1[13]), 
            .I3(n5276), .O(mcreg1[12])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_14_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_84_add_2_21 (.CI(n5348), .I0(prodreg1[19]), .I1(n1[19]), 
            .CO(n5349));
    SB_CARRY sub_93_add_2_14 (.CI(n5276), .I0(mcreg[12]), .I1(n1[13]), 
            .CO(n5277));
    SB_CARRY sub_84_add_2_15 (.CI(n5342), .I0(prodreg1[13]), .I1(n1[13]), 
            .CO(n5343));
    SB_LUT4 sub_93_add_2_13_lut (.I0(GND_net), .I1(mcreg[11]), .I2(n1[12]), 
            .I3(n5275), .O(mcreg1[11])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_13_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_13 (.CI(n5275), .I0(mcreg[11]), .I1(n1[12]), 
            .CO(n5276));
    SB_LUT4 sub_93_add_2_12_lut (.I0(GND_net), .I1(mcreg[10]), .I2(n1[11]), 
            .I3(n5274), .O(mcreg1[10])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_12_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_12 (.CI(n5274), .I0(mcreg[10]), .I1(n1[11]), 
            .CO(n5275));
    SB_LUT4 sub_93_add_2_11_lut (.I0(GND_net), .I1(mcreg[9]), .I2(n1[10]), 
            .I3(n5273), .O(mcreg1[9])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_11_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_11 (.CI(n5273), .I0(mcreg[9]), .I1(n1[10]), 
            .CO(n5274));
    SB_LUT4 sub_93_add_2_10_lut (.I0(GND_net), .I1(mcreg[8]), .I2(n1[9]), 
            .I3(n5272), .O(mcreg1[8])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_10_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_10 (.CI(n5272), .I0(mcreg[8]), .I1(n1[9]), .CO(n5273));
    SB_LUT4 sub_93_add_2_9_lut (.I0(GND_net), .I1(mcreg[7]), .I2(n1[8]), 
            .I3(n5271), .O(mcreg1[7])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_9_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_9 (.CI(n5271), .I0(mcreg[7]), .I1(n1[8]), .CO(n5272));
    SB_CARRY add_281_13 (.CI(n5242), .I0(prodreg_c[11]), .I1(n2753[11]), 
            .CO(n5243));
    SB_LUT4 add_281_19_lut (.I0(GND_net), .I1(prodreg_c[17]), .I2(n2753[17]), 
            .I3(n5248), .O(prodreg1[17])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_19_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_28_lut (.I0(GND_net), .I1(prodreg_c[26]), .I2(n2753[26]), 
            .I3(n5257), .O(prodreg1[26])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_28_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_8_lut (.I0(GND_net), .I1(\prodreg[6] ), .I2(n2753[6]), 
            .I3(n5237), .O(prodreg1[6])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_8_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_8 (.CI(n5237), .I0(\prodreg[6] ), .I1(n2753[6]), 
            .CO(n5238));
    SB_LUT4 add_281_12_lut (.I0(GND_net), .I1(\prodreg[10] ), .I2(n2753[10]), 
            .I3(n5241), .O(prodreg1[10])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_12_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_7_lut (.I0(GND_net), .I1(prodreg[5]), .I2(n2753[5]), 
            .I3(n5236), .O(prodreg1[5])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_7_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_19 (.CI(n5248), .I0(prodreg_c[17]), .I1(n2753[17]), 
            .CO(n5249));
    SB_LUT4 add_281_18_lut (.I0(GND_net), .I1(prodreg_c[16]), .I2(n2753[16]), 
            .I3(n5247), .O(prodreg1[16])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_18_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_18 (.CI(n5247), .I0(prodreg_c[16]), .I1(n2753[16]), 
            .CO(n5248));
    SB_LUT4 i314_4_lut (.I0(n5758), .I1(multgo), .I2(multrdy), .I3(n62), 
            .O(n2132));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam i314_4_lut.LUT_INIT = 16'h3035;
    SB_CARRY add_281_28 (.CI(n5257), .I0(prodreg_c[26]), .I1(n2753[26]), 
            .CO(n5258));
    SB_LUT4 add_281_6_lut (.I0(GND_net), .I1(\prodreg[4] ), .I2(n2753[4]), 
            .I3(n5235), .O(prodreg1[4])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_6_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_27_lut (.I0(GND_net), .I1(prodreg_c[25]), .I2(n2753[25]), 
            .I3(n5256), .O(prodreg1[25])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_27_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_12 (.CI(n5241), .I0(\prodreg[10] ), .I1(n2753[10]), 
            .CO(n5242));
    SB_LUT4 add_281_11_lut (.I0(GND_net), .I1(\prodreg[9] ), .I2(n2753[9]), 
            .I3(n5240), .O(prodreg1[9])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_11_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_17_lut (.I0(GND_net), .I1(prodreg_c[15]), .I2(n2753[15]), 
            .I3(n5246), .O(prodreg1[15])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_17_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_27 (.CI(n5256), .I0(prodreg_c[25]), .I1(n2753[25]), 
            .CO(n5257));
    SB_CARRY add_281_11 (.CI(n5240), .I0(\prodreg[9] ), .I1(n2753[9]), 
            .CO(n5241));
    SB_CARRY add_281_17 (.CI(n5246), .I0(prodreg_c[15]), .I1(n2753[15]), 
            .CO(n5247));
    SB_LUT4 add_281_16_lut (.I0(GND_net), .I1(prodreg_c[14]), .I2(n2753[14]), 
            .I3(n5245), .O(prodreg1[14])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_16_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_26_lut (.I0(GND_net), .I1(prodreg_c[24]), .I2(n2753[24]), 
            .I3(n5255), .O(prodreg1[24])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_26_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_26 (.CI(n5255), .I0(prodreg_c[24]), .I1(n2753[24]), 
            .CO(n5256));
    SB_LUT4 add_281_25_lut (.I0(GND_net), .I1(prodreg_c[23]), .I2(n2753[23]), 
            .I3(n5254), .O(prodreg1[23])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_25_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_16 (.CI(n5245), .I0(prodreg_c[14]), .I1(n2753[14]), 
            .CO(n5246));
    SB_LUT4 sub_93_add_2_8_lut (.I0(GND_net), .I1(mcreg[6]), .I2(n1[7]), 
            .I3(n5270), .O(mcreg1[6])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_8_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_25 (.CI(n5254), .I0(prodreg_c[23]), .I1(n2753[23]), 
            .CO(n5255));
    SB_CARRY sub_93_add_2_8 (.CI(n5270), .I0(mcreg[6]), .I1(n1[7]), .CO(n5271));
    SB_LUT4 sub_93_add_2_7_lut (.I0(GND_net), .I1(mcreg[5]), .I2(n1[6]), 
            .I3(n5269), .O(mcreg1[5])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_7_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_7 (.CI(n5269), .I0(mcreg[5]), .I1(n1[6]), .CO(n5270));
    SB_LUT4 sub_93_add_2_6_lut (.I0(GND_net), .I1(mcreg[4]), .I2(n1[5]), 
            .I3(n5268), .O(mcreg1[4])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_6_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_6 (.CI(n5268), .I0(mcreg[4]), .I1(n1[5]), .CO(n5269));
    SB_LUT4 sub_93_add_2_5_lut (.I0(GND_net), .I1(mcreg[3]), .I2(n1[4]), 
            .I3(n5267), .O(mcreg1[3])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_5_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_5 (.CI(n5267), .I0(mcreg[3]), .I1(n1[4]), .CO(n5268));
    SB_LUT4 sub_93_add_2_4_lut (.I0(GND_net), .I1(mcreg[2]), .I2(n1[3]), 
            .I3(n5266), .O(mcreg1[2])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_4_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 i2303_4_lut (.I0(tempout[24]), .I1(indata_c_24), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[24] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2303_4_lut.LUT_INIT = 16'hca0a;
    SB_CARRY sub_93_add_2_4 (.CI(n5266), .I0(mcreg[2]), .I1(n1[3]), .CO(n5267));
    SB_LUT4 sub_93_add_2_3_lut (.I0(GND_net), .I1(mcreg[1]), .I2(n1[2]), 
            .I3(n5265), .O(mcreg1[1])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_3_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_3 (.CI(n5265), .I0(mcreg[1]), .I1(n1[2]), .CO(n5266));
    SB_LUT4 sub_93_add_2_2_lut (.I0(GND_net), .I1(\mcreg[0] ), .I2(n1[1]), 
            .I3(VCC_net), .O(\mcreg1[0] )) /* synthesis syn_instantiated=1 */ ;
    defparam sub_93_add_2_2_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_93_add_2_2 (.CI(VCC_net), .I0(\mcreg[0] ), .I1(n1[1]), 
            .CO(n5265));
    SB_LUT4 add_281_35_lut (.I0(GND_net), .I1(prodreg_c[33]), .I2(n2753[33]), 
            .I3(n5264), .O(prodreg1[33])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_35_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_34_lut (.I0(GND_net), .I1(prodreg_c[32]), .I2(n2753[32]), 
            .I3(n5263), .O(prodreg1[32])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_34_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_34 (.CI(n5263), .I0(prodreg_c[32]), .I1(n2753[32]), 
            .CO(n5264));
    SB_LUT4 add_281_33_lut (.I0(GND_net), .I1(prodreg[31]), .I2(n2753[31]), 
            .I3(n5262), .O(prodreg1[31])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_33_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_3_lut (.I0(GND_net), .I1(\prodreg[1] ), .I2(n2753[1]), 
            .I3(n5232), .O(prodreg1[1])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_3_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_15_lut (.I0(GND_net), .I1(prodreg_c[13]), .I2(n2753[13]), 
            .I3(n5244), .O(prodreg1[13])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_15_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_15 (.CI(n5244), .I0(prodreg_c[13]), .I1(n2753[13]), 
            .CO(n5245));
    SB_LUT4 add_281_10_lut (.I0(GND_net), .I1(prodreg[8]), .I2(n2753[8]), 
            .I3(n5239), .O(prodreg1[8])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_10_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_5_lut (.I0(GND_net), .I1(\prodreg[3] ), .I2(n2753[3]), 
            .I3(n5234), .O(prodreg1[3])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_5_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_14_lut (.I0(GND_net), .I1(prodreg_c[12]), .I2(n2753[12]), 
            .I3(n5243), .O(prodreg1[12])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_14_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 add_281_24_lut (.I0(GND_net), .I1(prodreg_c[22]), .I2(n2753[22]), 
            .I3(n5253), .O(prodreg1[22])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_24_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_24 (.CI(n5253), .I0(prodreg_c[22]), .I1(n2753[22]), 
            .CO(n5254));
    SB_CARRY add_281_3 (.CI(n5232), .I0(\prodreg[1] ), .I1(n2753[1]), 
            .CO(n5233));
    SB_CARRY add_281_2 (.CI(GND_net), .I0(\prodreg[0] ), .I1(n2753[0]), 
            .CO(n5232));
    SB_LUT4 add_281_23_lut (.I0(GND_net), .I1(prodreg_c[21]), .I2(n2753[21]), 
            .I3(n5252), .O(prodreg1[21])) /* synthesis syn_instantiated=1 */ ;
    defparam add_281_23_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_281_5 (.CI(n5234), .I0(\prodreg[3] ), .I1(n2753[3]), 
            .CO(n5235));
    SB_CARRY add_281_6 (.CI(n5235), .I0(\prodreg[4] ), .I1(n2753[4]), 
            .CO(n5236));
    SB_CARRY add_281_4 (.CI(n5233), .I0(\prodreg[2] ), .I1(n2753[2]), 
            .CO(n5234));
    SB_LUT4 i2515_2_lut (.I0(mcreg[5]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2753[5]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2515_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2265_3_lut (.I0(prodreg1[23]), .I1(prodreg2[23]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4675));
    defparam i2265_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2267_3_lut (.I0(prodreg3[23]), .I1(n4675), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[23]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2267_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i9_3_lut_4_lut (.I0(mpreg[9]), .I1(\sqrin[8] ), .I2(multrdy), 
            .I3(multgo), .O(n2066));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i9_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i2271_4_lut (.I0(tempout[23]), .I1(indata_c_23), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[23] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2271_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i2489_2_lut (.I0(mcreg[31]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[31]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2489_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2233_3_lut (.I0(prodreg1[22]), .I1(prodreg2[22]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4644));
    defparam i2233_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2235_3_lut (.I0(prodreg3[22]), .I1(n4644), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[22]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2235_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2239_4_lut (.I0(tempout[22]), .I1(indata_c_22), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[22] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2239_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i2201_3_lut (.I0(prodreg1[21]), .I1(prodreg2[21]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4613));
    defparam i2201_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2203_3_lut (.I0(prodreg3[21]), .I1(n4613), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[21]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2203_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2207_4_lut (.I0(tempout[21]), .I1(indata_c_21), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[21] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2207_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i2169_3_lut (.I0(prodreg1[20]), .I1(prodreg2[20]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4582));
    defparam i2169_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2171_3_lut (.I0(prodreg3[20]), .I1(n4582), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[20]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2171_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2175_4_lut (.I0(tempout[20]), .I1(indata_c_20), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[20] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2175_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i2137_3_lut (.I0(prodreg1[19]), .I1(prodreg2[19]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4551));
    defparam i2137_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2139_3_lut (.I0(prodreg3[19]), .I1(n4551), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[19]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2139_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2143_4_lut (.I0(tempout[19]), .I1(indata_c_19), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[19] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2143_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i2105_3_lut (.I0(prodreg1[18]), .I1(prodreg2[18]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4520));
    defparam i2105_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2107_3_lut (.I0(prodreg3[18]), .I1(n4520), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[18]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2107_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2111_4_lut (.I0(tempout[18]), .I1(indata_c_18), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[18] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2111_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i2073_3_lut (.I0(prodreg1[17]), .I1(prodreg2[17]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4489));
    defparam i2073_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2075_3_lut (.I0(prodreg3[17]), .I1(n4489), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[17]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2075_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2079_4_lut (.I0(tempout[17]), .I1(indata_c_17), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[17] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2079_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i2041_3_lut (.I0(prodreg1[16]), .I1(prodreg2[16]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4458));
    defparam i2041_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2043_3_lut (.I0(prodreg3[16]), .I1(n4458), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[16]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2043_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2047_4_lut (.I0(tempout[16]), .I1(indata_c_16), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[16] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2047_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 mux_151_i8_3_lut_4_lut (.I0(mpreg[8]), .I1(\sqrin[7] ), .I2(multrdy), 
            .I3(multgo), .O(n2065));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i8_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i2009_3_lut (.I0(prodreg1[15]), .I1(prodreg2[15]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4427));
    defparam i2009_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2011_3_lut (.I0(prodreg3[15]), .I1(n4427), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[15]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2011_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i7_3_lut_4_lut (.I0(mpreg[7]), .I1(\sqrin[6] ), .I2(multrdy), 
            .I3(multgo), .O(n2064));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i7_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i2015_4_lut (.I0(tempout[15]), .I1(indata_c_15), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[15] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2015_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 sub_84_inv_0_i12_1_lut (.I0(modreg1[10]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[11]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i12_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 i515_4_lut (.I0(prodreg3[0]), .I1(prodreg2[0]), .I2(prodreg3[33]), 
            .I3(prodreg2[33]), .O(tempout[0]));
    defparam i515_4_lut.LUT_INIT = 16'haaca;
    SB_LUT4 i1977_3_lut (.I0(prodreg1[14]), .I1(prodreg2[14]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4396));
    defparam i1977_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i1979_3_lut (.I0(prodreg3[14]), .I1(n4396), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[14]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i1979_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1983_4_lut (.I0(tempout[14]), .I1(indata_c_14), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[14] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i1983_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 mux_151_i6_3_lut_4_lut (.I0(mpreg[6]), .I1(\sqrin[5] ), .I2(multrdy), 
            .I3(multgo), .O(n2063));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i6_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i1945_3_lut (.I0(prodreg1[13]), .I1(prodreg2[13]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4365));
    defparam i1945_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i1947_3_lut (.I0(prodreg3[13]), .I1(n4365), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[13]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i1947_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1951_4_lut (.I0(tempout[13]), .I1(indata_c_13), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[13] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i1951_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i1913_3_lut (.I0(prodreg1[12]), .I1(prodreg2[12]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4334));
    defparam i1913_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i1915_3_lut (.I0(prodreg3[12]), .I1(n4334), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[12]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i1915_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1919_4_lut (.I0(tempout[12]), .I1(indata_c_12), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[12] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i1919_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i1881_3_lut (.I0(prodreg1[11]), .I1(prodreg2[11]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n4303));
    defparam i1881_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i1883_3_lut (.I0(prodreg3[11]), .I1(n4303), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[11]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i1883_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1887_4_lut (.I0(tempout[11]), .I1(indata_c_11), .I2(ready_c), 
            .I3(inExp_c_0), .O(\tempin_31__N_129[11] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i1887_4_lut.LUT_INIT = 16'hca0a;
    SB_LUT4 i557_3_lut (.I0(prodreg1[10]), .I1(prodreg2[10]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n2980));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i557_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_272_i11_3_lut (.I0(prodreg3[10]), .I1(n2980), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[10]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_272_i11_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1856_3_lut (.I0(\prodreg1[29] ), .I1(\prodreg2[29] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4279));
    defparam i1856_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i1857_3_lut (.I0(\prodreg3[29] ), .I1(n4279), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4280));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i1857_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 mux_151_i5_3_lut_4_lut (.I0(mpreg[5]), .I1(\sqrin[4] ), .I2(multrdy), 
            .I3(multgo), .O(n2062));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i5_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i556_3_lut (.I0(prodreg1[9]), .I1(prodreg2[9]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n2979));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i556_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_272_i10_3_lut (.I0(prodreg3[9]), .I1(n2979), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[9]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_272_i10_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1435_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[31]), 
            .I3(modreg1[31]), .O(n3858));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1435_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1434_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[30]), 
            .I3(modreg1[30]), .O(n3857));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1434_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1859_3_lut (.I0(n4280), .I1(indata_c_29), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[29] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i1859_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i555_3_lut (.I0(prodreg1[8]), .I1(prodreg2[8]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n2978));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i555_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_272_i9_3_lut (.I0(prodreg3[8]), .I1(n2978), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[8]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_272_i9_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1433_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[29]), 
            .I3(modreg1[29]), .O(n3856));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1433_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i2432_3_lut (.I0(\prodreg1[28] ), .I1(\prodreg2[28] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4837));
    defparam i2432_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2433_3_lut (.I0(\prodreg3[28] ), .I1(n4837), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4838));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2433_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1432_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[28]), 
            .I3(modreg1[28]), .O(n3855));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1432_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i554_3_lut (.I0(prodreg1[7]), .I1(prodreg2[7]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n2977));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i554_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_272_i8_3_lut (.I0(prodreg3[7]), .I1(n2977), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[7]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_272_i8_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1431_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[27]), 
            .I3(modreg1[27]), .O(n3854));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1431_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1430_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[26]), 
            .I3(modreg1[26]), .O(n3853));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1430_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1429_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[25]), 
            .I3(modreg1[25]), .O(n3852));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1429_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i2435_3_lut (.I0(n4838), .I1(indata_c_28), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[28] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2435_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1428_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[24]), 
            .I3(modreg1[24]), .O(n3851));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1428_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i553_3_lut (.I0(prodreg1[6]), .I1(prodreg2[6]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n2976));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i553_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_272_i7_3_lut (.I0(prodreg3[6]), .I1(n2976), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[6]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_272_i7_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1427_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[23]), 
            .I3(modreg1[23]), .O(n3850));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1427_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i2400_3_lut (.I0(\prodreg1[27] ), .I1(\prodreg2[27] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4806));
    defparam i2400_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2401_3_lut (.I0(\prodreg3[27] ), .I1(n4806), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4807));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2401_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1426_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[22]), 
            .I3(modreg1[22]), .O(n3849));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1426_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1425_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[21]), 
            .I3(modreg1[21]), .O(n3848));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1425_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i552_3_lut (.I0(prodreg1[5]), .I1(prodreg2[5]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n2975));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i552_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_272_i6_3_lut (.I0(prodreg3[5]), .I1(n2975), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[5]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_272_i6_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1424_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[20]), 
            .I3(modreg1[20]), .O(n3847));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1424_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1423_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[19]), 
            .I3(modreg1[19]), .O(n3846));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1423_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1422_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[18]), 
            .I3(modreg1[18]), .O(n3845));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1422_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1421_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[17]), 
            .I3(modreg1[17]), .O(n3844));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1421_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1420_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[16]), 
            .I3(modreg1[16]), .O(n3843));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1420_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i2403_3_lut (.I0(n4807), .I1(indata_c_27), .I2(ready_c), .I3(GND_net), 
            .O(\root_31__N_65[27] ));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/basicrsa.vhd(83[5:10])
    defparam i2403_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1419_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[15]), 
            .I3(modreg1[15]), .O(n3842));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1419_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i551_3_lut (.I0(prodreg1[4]), .I1(prodreg2[4]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n2974));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i551_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_272_i5_3_lut (.I0(prodreg3[4]), .I1(n2974), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[4]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_272_i5_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2368_3_lut (.I0(\prodreg1[26] ), .I1(\prodreg2[26] ), .I2(\prodreg2[33] ), 
            .I3(GND_net), .O(n4775));
    defparam i2368_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i1418_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[14]), 
            .I3(modreg1[14]), .O(n3841));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1418_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1417_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[13]), 
            .I3(modreg1[13]), .O(n3840));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1417_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i2369_3_lut (.I0(\prodreg3[26] ), .I1(n4775), .I2(\prodreg3[33] ), 
            .I3(GND_net), .O(n4776));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(91[37:45])
    defparam i2369_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1416_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[12]), 
            .I3(modreg1[12]), .O(n3839));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1416_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i550_3_lut (.I0(prodreg1[3]), .I1(prodreg2[3]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n2973));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i550_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 mux_272_i4_3_lut (.I0(prodreg3[3]), .I1(n2973), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[3]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_272_i4_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1415_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[11]), 
            .I3(modreg1[11]), .O(n3838));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1415_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i549_3_lut (.I0(prodreg1[2]), .I1(prodreg2[2]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n2972));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i549_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i1414_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[10]), 
            .I3(modreg1[10]), .O(n3837));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1414_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 mux_272_i3_3_lut (.I0(prodreg3[2]), .I1(n2972), .I2(prodreg3[33]), 
            .I3(GND_net), .O(tempout[2]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_272_i3_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1413_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[9]), 
            .I3(modreg1[9]), .O(n3836));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1413_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1412_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[8]), 
            .I3(modreg1[8]), .O(n3835));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1412_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1411_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[7]), 
            .I3(modreg1[7]), .O(n3834));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1411_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1410_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[6]), 
            .I3(modreg1[6]), .O(n3833));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1410_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1409_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[5]), 
            .I3(modreg1[5]), .O(n3832));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1409_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1408_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[4]), 
            .I3(modreg1[4]), .O(n3831));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1408_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i1407_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[3]), 
            .I3(modreg1[3]), .O(n3830));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1407_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 i548_3_lut (.I0(prodreg1[1]), .I1(prodreg2[1]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n2971));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i548_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i1406_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[2]), 
            .I3(modreg1[2]), .O(n3829));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1406_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 sub_84_inv_0_i13_1_lut (.I0(modreg1[11]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[12]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i13_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 i1403_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[0]), 
            .I3(modreg1[0]), .O(n3826));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1403_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 mux_151_i4_3_lut_4_lut (.I0(mpreg[4]), .I1(\sqrin[3] ), .I2(multrdy), 
            .I3(multgo), .O(n2061));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i4_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i1405_3_lut_4_lut (.I0(n2057), .I1(reset_c), .I2(modreg[1]), 
            .I3(modreg1[1]), .O(n3828));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1405_3_lut_4_lut.LUT_INIT = 16'hfd20;
    SB_LUT4 mux_151_i3_3_lut_4_lut (.I0(mpreg[3]), .I1(\sqrin[2] ), .I2(multrdy), 
            .I3(multgo), .O(n2060));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i3_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 mux_151_i2_3_lut_4_lut (.I0(mpreg[2]), .I1(\sqrin[1] ), .I2(multrdy), 
            .I3(multgo), .O(n2059));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i2_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 sub_84_inv_0_i25_1_lut (.I0(modreg1[23]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[24]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i25_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i24_1_lut (.I0(modreg1[22]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[23]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i24_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i23_1_lut (.I0(modreg1[21]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[22]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i23_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i22_1_lut (.I0(modreg1[20]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[21]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i22_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i21_1_lut (.I0(modreg1[19]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[20]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i21_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i20_1_lut (.I0(modreg1[18]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[19]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i20_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i19_1_lut (.I0(modreg1[17]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[18]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i19_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i18_1_lut (.I0(modreg1[16]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[17]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i18_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i17_1_lut (.I0(modreg1[15]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[16]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i17_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i16_1_lut (.I0(modreg1[14]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[15]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i16_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i15_1_lut (.I0(modreg1[13]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[14]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i15_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i9_1_lut (.I0(modreg1[7]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[8]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i9_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i8_1_lut (.I0(modreg1[6]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[7]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i8_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i7_1_lut (.I0(modreg1[5]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[6]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i7_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i6_1_lut (.I0(modreg1[4]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[5]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i6_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i5_1_lut (.I0(modreg1[3]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[4]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i5_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i4_1_lut (.I0(modreg1[2]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[3]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i4_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i3_1_lut (.I0(modreg1[1]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[2]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i3_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 sub_84_inv_0_i2_1_lut (.I0(modreg1[0]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[1]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i2_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 i1365_2_lut_4_lut (.I0(n2132), .I1(reset_c), .I2(multrdy), 
            .I3(multgo), .O(n2912));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1365_2_lut_4_lut.LUT_INIT = 16'h1000;
    SB_LUT4 sub_84_inv_0_i14_1_lut (.I0(modreg1[12]), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(n1[13]));   // /opt/lattice/LSE/vhdl_packages/syn_arit.vhd(1113[42:66])
    defparam sub_84_inv_0_i14_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 mux_151_i1_3_lut_4_lut (.I0(mpreg[1]), .I1(\sqrin[0] ), .I2(multrdy), 
            .I3(multgo), .O(n2058));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(137[4] 161[11])
    defparam mux_151_i1_3_lut_4_lut.LUT_INIT = 16'hcaaa;
    SB_LUT4 i2508_2_lut (.I0(mcreg[12]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[12]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2508_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2509_2_lut (.I0(mcreg[11]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[11]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2509_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1_2_lut (.I0(mpreg[0]), .I1(\mcreg[0] ), .I2(GND_net), .I3(GND_net), 
            .O(n2753[0]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(134[3] 162[10])
    defparam i1_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1852_4_lut (.I0(prodreg_c[29]), .I1(tempout[29]), .I2(n2179), 
            .I3(n2912), .O(n4112));
    defparam i1852_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i2428_4_lut (.I0(prodreg_c[28]), .I1(tempout[28]), .I2(n2179), 
            .I3(n2912), .O(n4108));
    defparam i2428_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i2396_4_lut (.I0(prodreg_c[27]), .I1(tempout[27]), .I2(n2179), 
            .I3(n2912), .O(n4104));
    defparam i2396_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i2364_4_lut (.I0(prodreg_c[26]), .I1(tempout[26]), .I2(n2179), 
            .I3(n2912), .O(n4097));
    defparam i2364_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i2332_4_lut (.I0(prodreg_c[25]), .I1(tempout[25]), .I2(n2179), 
            .I3(n2912), .O(n4087));
    defparam i2332_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i2300_4_lut (.I0(prodreg_c[24]), .I1(tempout[24]), .I2(n2179), 
            .I3(n2912), .O(n4077));
    defparam i2300_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i2268_4_lut (.I0(prodreg_c[23]), .I1(tempout[23]), .I2(n2179), 
            .I3(n2912), .O(n4067));
    defparam i2268_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i2236_4_lut (.I0(prodreg_c[22]), .I1(tempout[22]), .I2(n2179), 
            .I3(n2912), .O(n4060));
    defparam i2236_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i2204_4_lut (.I0(prodreg_c[21]), .I1(tempout[21]), .I2(n2179), 
            .I3(n2912), .O(n4050));
    defparam i2204_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i2172_4_lut (.I0(prodreg_c[20]), .I1(tempout[20]), .I2(n2179), 
            .I3(n2912), .O(n4040));
    defparam i2172_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i2140_4_lut (.I0(prodreg_c[19]), .I1(tempout[19]), .I2(n2179), 
            .I3(n2912), .O(n4030));
    defparam i2140_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i2108_4_lut (.I0(prodreg_c[18]), .I1(tempout[18]), .I2(n2179), 
            .I3(n2912), .O(n4020));
    defparam i2108_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i2076_4_lut (.I0(prodreg_c[17]), .I1(tempout[17]), .I2(n2179), 
            .I3(n2912), .O(n4010));
    defparam i2076_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i2044_4_lut (.I0(prodreg_c[16]), .I1(tempout[16]), .I2(n2179), 
            .I3(n2912), .O(n4000));
    defparam i2044_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i2012_4_lut (.I0(prodreg_c[15]), .I1(tempout[15]), .I2(n2179), 
            .I3(n2912), .O(n3993));
    defparam i2012_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i1980_4_lut (.I0(prodreg_c[14]), .I1(tempout[14]), .I2(n2179), 
            .I3(n2912), .O(n3989));
    defparam i1980_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i1948_4_lut (.I0(prodreg_c[13]), .I1(tempout[13]), .I2(n2179), 
            .I3(n2912), .O(n3982));
    defparam i1948_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i1_3_lut (.I0(prodreg1[33]), .I1(prodreg2[33]), .I2(prodreg3[33]), 
            .I3(GND_net), .O(prodreg4[33]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i1_3_lut.LUT_INIT = 16'h8080;
    SB_LUT4 mux_272_i33_3_lut (.I0(prodreg3[32]), .I1(n3002), .I2(prodreg3[33]), 
            .I3(GND_net), .O(prodreg4[32]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam mux_272_i33_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i579_3_lut (.I0(prodreg1[32]), .I1(prodreg2[32]), .I2(prodreg2[33]), 
            .I3(GND_net), .O(n3002));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(115[2] 118[28])
    defparam i579_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i1916_4_lut (.I0(prodreg_c[12]), .I1(tempout[12]), .I2(n2179), 
            .I3(n2912), .O(n3972));
    defparam i1916_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i1884_4_lut (.I0(prodreg_c[11]), .I1(tempout[11]), .I2(n2179), 
            .I3(n2912), .O(n3965));
    defparam i1884_4_lut.LUT_INIT = 16'h0aca;
    SB_LUT4 i504_2_lut (.I0(mcreg[32]), .I1(\mcreg1[32] ), .I2(GND_net), 
            .I3(GND_net), .O(mcreg2[32]));
    defparam i504_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 mux_86_i32_3_lut (.I0(mcreg1[31]), .I1(mcreg[31]), .I2(\mcreg1[32] ), 
            .I3(GND_net), .O(mcreg2[31]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(124[2] 126[26])
    defparam mux_86_i32_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i2503_2_lut (.I0(mcreg[17]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[17]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2503_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2494_2_lut (.I0(mcreg[26]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[26]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2494_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2514_2_lut (.I0(mcreg[6]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2753[6]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2514_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2510_2_lut (.I0(mcreg[10]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[10]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2510_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2504_2_lut (.I0(mcreg[16]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[16]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2504_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2516_2_lut (.I0(mcreg[4]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2753[4]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2516_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2495_2_lut (.I0(mcreg[25]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[25]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2495_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2511_2_lut (.I0(mcreg[9]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2753[9]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2511_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2505_2_lut (.I0(mcreg[15]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[15]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2505_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2506_2_lut (.I0(mcreg[14]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[14]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2506_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2496_2_lut (.I0(mcreg[24]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[24]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2496_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2497_2_lut (.I0(mcreg[23]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[23]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2497_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2487_2_lut (.I0(mcreg[33]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[33]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2487_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2488_2_lut (.I0(mcreg[32]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[32]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2488_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2486_2_lut (.I0(mcreg[1]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2753[1]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2486_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2507_2_lut (.I0(mcreg[13]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[13]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2507_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2484_2_lut (.I0(mcreg[3]), .I1(mpreg[0]), .I2(GND_net), .I3(GND_net), 
            .O(n2753[3]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2484_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i2498_2_lut (.I0(mcreg[22]), .I1(mpreg[0]), .I2(GND_net), 
            .I3(GND_net), .O(n2753[22]));   // ../../../ipassurance/base/amber_base/amber_base.srcs/sources_1/imports/hdl/modmult.vhd(103[2] 105[27])
    defparam i2498_2_lut.LUT_INIT = 16'h8888;
    
endmodule
