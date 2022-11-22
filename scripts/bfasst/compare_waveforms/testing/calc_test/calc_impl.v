// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
// Date        : Wed Oct 26 14:08:43 2022
// Host        : CCL15 running 64-bit Ubuntu 20.04.4 LTS
// Command     : write_verilog -force -file /home/edvenson/bfasst/build/xilinx_yosys_waveform/byu/calc/calc_impl.v
// Design      : calc
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7a200tsbg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module alu
   (accumulator_reg,
    \accumulator_reg[0]_0 ,
    \accumulator_reg[0]_1 ,
    \accumulator_reg[10]_0 ,
    \accumulator_reg[11]_0 ,
    \accumulator_reg[12]_0 ,
    \accumulator_reg[13]_0 ,
    \accumulator_reg[14]_0 ,
    \accumulator_reg[1]_0 ,
    \accumulator_reg[2]_0 ,
    \accumulator_reg[3]_0 ,
    \accumulator_reg[4]_0 ,
    \accumulator_reg[5]_0 ,
    \accumulator_reg[6]_0 ,
    \accumulator_reg[9]_0 ,
    btnc_IBUF,
    btnl_IBUF,
    btnr_IBUF,
    D,
    Q,
    sw_IBUF);
  input [15:0]accumulator_reg;
  input \accumulator_reg[0]_0 ;
  input \accumulator_reg[0]_1 ;
  input \accumulator_reg[10]_0 ;
  input \accumulator_reg[11]_0 ;
  input \accumulator_reg[12]_0 ;
  input \accumulator_reg[13]_0 ;
  input \accumulator_reg[14]_0 ;
  input \accumulator_reg[1]_0 ;
  input \accumulator_reg[2]_0 ;
  input \accumulator_reg[3]_0 ;
  input \accumulator_reg[4]_0 ;
  input \accumulator_reg[5]_0 ;
  input \accumulator_reg[6]_0 ;
  input \accumulator_reg[9]_0 ;
  input btnc_IBUF;
  input btnl_IBUF;
  input btnr_IBUF;
  output [15:0]D;
  input [15:0]Q;
  input [15:0]sw_IBUF;

  wire \<const0> ;
  wire \<const1> ;
  wire [15:0]D;
  wire [15:0]Q;
  wire \accumulator[0]_i_4_n_0 ;
  wire \accumulator[10]_i_4_n_0 ;
  wire \accumulator[11]_i_4_n_0 ;
  wire \accumulator[12]_i_4_n_0 ;
  wire \accumulator[13]_i_4_n_0 ;
  wire \accumulator[14]_i_4_n_0 ;
  wire \accumulator[15]_i_3_n_0 ;
  wire \accumulator[1]_i_4_n_0 ;
  wire \accumulator[2]_i_4_n_0 ;
  wire \accumulator[3]_i_4_n_0 ;
  wire \accumulator[4]_i_4_n_0 ;
  wire \accumulator[5]_i_4_n_0 ;
  wire \accumulator[6]_i_4_n_0 ;
  wire \accumulator[7]_i_2_n_0 ;
  wire \accumulator[8]_i_2_n_0 ;
  wire \accumulator[9]_i_4_n_0 ;
  wire [15:0]accumulator_reg;
  wire \accumulator_reg[0]_0 ;
  wire \accumulator_reg[0]_1 ;
  wire \accumulator_reg[10]_0 ;
  wire \accumulator_reg[11]_0 ;
  wire \accumulator_reg[12]_0 ;
  wire \accumulator_reg[13]_0 ;
  wire \accumulator_reg[14]_0 ;
  wire \accumulator_reg[1]_0 ;
  wire \accumulator_reg[2]_0 ;
  wire \accumulator_reg[3]_0 ;
  wire \accumulator_reg[4]_0 ;
  wire \accumulator_reg[5]_0 ;
  wire \accumulator_reg[6]_0 ;
  wire \accumulator_reg[9]_0 ;
  wire btnc_IBUF;
  wire btnl_IBUF;
  wire btnr_IBUF;
  wire [15:0]data2;
  wire [15:0]data3;
  wire data4;
  wire i__carry__0_i_1__0_n_0;
  wire i__carry__0_i_1__1_n_0;
  wire i__carry__0_i_1_n_0;
  wire i__carry__0_i_2__0_n_0;
  wire i__carry__0_i_2__1_n_0;
  wire i__carry__0_i_2_n_0;
  wire i__carry__0_i_3__0_n_0;
  wire i__carry__0_i_3__1_n_0;
  wire i__carry__0_i_3_n_0;
  wire i__carry__0_i_4__0_n_0;
  wire i__carry__0_i_4__1_n_0;
  wire i__carry__0_i_4_n_0;
  wire i__carry__0_i_5_n_0;
  wire i__carry__0_i_6_n_0;
  wire i__carry__0_i_7_n_0;
  wire i__carry__0_i_8_n_0;
  wire i__carry__1_i_1__0_n_0;
  wire i__carry__1_i_1__1_n_0;
  wire i__carry__1_i_1_n_0;
  wire i__carry__1_i_2__0_n_0;
  wire i__carry__1_i_2__1_n_0;
  wire i__carry__1_i_2_n_0;
  wire i__carry__1_i_3__0_n_0;
  wire i__carry__1_i_3__1_n_0;
  wire i__carry__1_i_3_n_0;
  wire i__carry__1_i_4__0_n_0;
  wire i__carry__1_i_4__1_n_0;
  wire i__carry__1_i_4_n_0;
  wire i__carry__1_i_5_n_0;
  wire i__carry__1_i_6_n_0;
  wire i__carry__1_i_7_n_0;
  wire i__carry__1_i_8_n_0;
  wire i__carry__2_i_1__0_n_0;
  wire i__carry__2_i_1__1_n_0;
  wire i__carry__2_i_1_n_0;
  wire i__carry__2_i_2__0_n_0;
  wire i__carry__2_i_2__1_n_0;
  wire i__carry__2_i_2_n_0;
  wire i__carry__2_i_3__0_n_0;
  wire i__carry__2_i_3__1_n_0;
  wire i__carry__2_i_3_n_0;
  wire i__carry__2_i_4__0_n_0;
  wire i__carry__2_i_4__1_n_0;
  wire i__carry__2_i_4_n_0;
  wire i__carry__2_i_5_n_0;
  wire i__carry__2_i_6_n_0;
  wire i__carry__2_i_7_n_0;
  wire i__carry__2_i_8_n_0;
  wire i__carry_i_1__0_n_0;
  wire i__carry_i_1__1_n_0;
  wire i__carry_i_1_n_0;
  wire i__carry_i_2__0_n_0;
  wire i__carry_i_2__1_n_0;
  wire i__carry_i_2_n_0;
  wire i__carry_i_3__0_n_0;
  wire i__carry_i_3__1_n_0;
  wire i__carry_i_3_n_0;
  wire i__carry_i_4__0_n_0;
  wire i__carry_i_4__1_n_0;
  wire i__carry_i_4_n_0;
  wire i__carry_i_5_n_0;
  wire i__carry_i_6_n_0;
  wire i__carry_i_7_n_0;
  wire i__carry_i_8_n_0;
  wire \result0_inferred__1/i__carry__0_n_0 ;
  wire \result0_inferred__1/i__carry__1_n_0 ;
  wire \result0_inferred__1/i__carry_n_0 ;
  wire \result0_inferred__2/i__carry__0_n_0 ;
  wire \result0_inferred__2/i__carry__1_n_0 ;
  wire \result0_inferred__2/i__carry_n_0 ;
  wire \result0_inferred__3/i__carry__0_n_0 ;
  wire \result0_inferred__3/i__carry__1_n_0 ;
  wire \result0_inferred__3/i__carry_n_0 ;
  wire [15:0]sw_IBUF;
  wire [3:0]\NLW_result0_inferred__1/i__carry_CO_UNCONNECTED ;
  wire [3:0]\NLW_result0_inferred__1/i__carry__0_CO_UNCONNECTED ;
  wire [3:0]\NLW_result0_inferred__1/i__carry__1_CO_UNCONNECTED ;
  wire [3:0]\NLW_result0_inferred__2/i__carry_CO_UNCONNECTED ;
  wire [3:0]\NLW_result0_inferred__2/i__carry__0_CO_UNCONNECTED ;
  wire [3:0]\NLW_result0_inferred__2/i__carry__1_CO_UNCONNECTED ;
  wire [3:0]\NLW_result0_inferred__3/i__carry_CO_UNCONNECTED ;
  wire [3:0]\NLW_result0_inferred__3/i__carry__0_CO_UNCONNECTED ;
  wire [3:0]\NLW_result0_inferred__3/i__carry__1_CO_UNCONNECTED ;
  wire [3:0]\NLW_result0_inferred__3/i__carry__2_CO_UNCONNECTED ;

  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \accumulator[0]_i_1 
       (.I0(accumulator_reg[0]),
        .I1(btnr_IBUF),
        .I2(\accumulator_reg[0]_0 ),
        .I3(btnc_IBUF),
        .I4(\accumulator[0]_i_4_n_0 ),
        .O(D[0]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[0]_i_4 
       (.I0(data4),
        .I1(data3[0]),
        .I2(btnr_IBUF),
        .I3(\accumulator_reg[0]_1 ),
        .I4(btnl_IBUF),
        .I5(data2[0]),
        .O(\accumulator[0]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \accumulator[10]_i_1 
       (.I0(accumulator_reg[10]),
        .I1(btnr_IBUF),
        .I2(\accumulator_reg[10]_0 ),
        .I3(btnc_IBUF),
        .I4(\accumulator[10]_i_4_n_0 ),
        .O(D[10]));
  LUT6 #(
    .INIT(64'h0330BBBB03308888)) 
    \accumulator[10]_i_4 
       (.I0(data3[10]),
        .I1(btnr_IBUF),
        .I2(Q[10]),
        .I3(sw_IBUF[10]),
        .I4(btnl_IBUF),
        .I5(data2[10]),
        .O(\accumulator[10]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \accumulator[11]_i_1 
       (.I0(accumulator_reg[11]),
        .I1(btnr_IBUF),
        .I2(\accumulator_reg[11]_0 ),
        .I3(btnc_IBUF),
        .I4(\accumulator[11]_i_4_n_0 ),
        .O(D[11]));
  LUT6 #(
    .INIT(64'h0330BBBB03308888)) 
    \accumulator[11]_i_4 
       (.I0(data3[11]),
        .I1(btnr_IBUF),
        .I2(Q[11]),
        .I3(sw_IBUF[11]),
        .I4(btnl_IBUF),
        .I5(data2[11]),
        .O(\accumulator[11]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \accumulator[12]_i_1 
       (.I0(accumulator_reg[12]),
        .I1(btnr_IBUF),
        .I2(\accumulator_reg[12]_0 ),
        .I3(btnc_IBUF),
        .I4(\accumulator[12]_i_4_n_0 ),
        .O(D[12]));
  LUT6 #(
    .INIT(64'h0330BBBB03308888)) 
    \accumulator[12]_i_4 
       (.I0(data3[12]),
        .I1(btnr_IBUF),
        .I2(Q[12]),
        .I3(sw_IBUF[12]),
        .I4(btnl_IBUF),
        .I5(data2[12]),
        .O(\accumulator[12]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \accumulator[13]_i_1 
       (.I0(accumulator_reg[13]),
        .I1(btnr_IBUF),
        .I2(\accumulator_reg[13]_0 ),
        .I3(btnc_IBUF),
        .I4(\accumulator[13]_i_4_n_0 ),
        .O(D[13]));
  LUT6 #(
    .INIT(64'h0330BBBB03308888)) 
    \accumulator[13]_i_4 
       (.I0(data3[13]),
        .I1(btnr_IBUF),
        .I2(Q[13]),
        .I3(sw_IBUF[13]),
        .I4(btnl_IBUF),
        .I5(data2[13]),
        .O(\accumulator[13]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \accumulator[14]_i_1 
       (.I0(accumulator_reg[14]),
        .I1(btnr_IBUF),
        .I2(\accumulator_reg[14]_0 ),
        .I3(btnc_IBUF),
        .I4(\accumulator[14]_i_4_n_0 ),
        .O(D[14]));
  LUT6 #(
    .INIT(64'h0330BBBB03308888)) 
    \accumulator[14]_i_4 
       (.I0(data3[14]),
        .I1(btnr_IBUF),
        .I2(Q[14]),
        .I3(sw_IBUF[14]),
        .I4(btnl_IBUF),
        .I5(data2[14]),
        .O(\accumulator[14]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0330BBBB03308888)) 
    \accumulator[15]_i_3 
       (.I0(data3[15]),
        .I1(btnr_IBUF),
        .I2(Q[15]),
        .I3(sw_IBUF[15]),
        .I4(btnl_IBUF),
        .I5(data2[15]),
        .O(\accumulator[15]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \accumulator[1]_i_1 
       (.I0(accumulator_reg[1]),
        .I1(btnr_IBUF),
        .I2(\accumulator_reg[1]_0 ),
        .I3(btnc_IBUF),
        .I4(\accumulator[1]_i_4_n_0 ),
        .O(D[1]));
  LUT6 #(
    .INIT(64'h0330BBBB03308888)) 
    \accumulator[1]_i_4 
       (.I0(data3[1]),
        .I1(btnr_IBUF),
        .I2(sw_IBUF[1]),
        .I3(Q[1]),
        .I4(btnl_IBUF),
        .I5(data2[1]),
        .O(\accumulator[1]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \accumulator[2]_i_1 
       (.I0(accumulator_reg[2]),
        .I1(btnr_IBUF),
        .I2(\accumulator_reg[2]_0 ),
        .I3(btnc_IBUF),
        .I4(\accumulator[2]_i_4_n_0 ),
        .O(D[2]));
  LUT6 #(
    .INIT(64'h0330BBBB03308888)) 
    \accumulator[2]_i_4 
       (.I0(data3[2]),
        .I1(btnr_IBUF),
        .I2(sw_IBUF[2]),
        .I3(Q[2]),
        .I4(btnl_IBUF),
        .I5(data2[2]),
        .O(\accumulator[2]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \accumulator[3]_i_1 
       (.I0(accumulator_reg[3]),
        .I1(btnr_IBUF),
        .I2(\accumulator_reg[3]_0 ),
        .I3(btnc_IBUF),
        .I4(\accumulator[3]_i_4_n_0 ),
        .O(D[3]));
  LUT6 #(
    .INIT(64'h0330BBBB03308888)) 
    \accumulator[3]_i_4 
       (.I0(data3[3]),
        .I1(btnr_IBUF),
        .I2(sw_IBUF[3]),
        .I3(Q[3]),
        .I4(btnl_IBUF),
        .I5(data2[3]),
        .O(\accumulator[3]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \accumulator[4]_i_1 
       (.I0(accumulator_reg[4]),
        .I1(btnr_IBUF),
        .I2(\accumulator_reg[4]_0 ),
        .I3(btnc_IBUF),
        .I4(\accumulator[4]_i_4_n_0 ),
        .O(D[4]));
  LUT6 #(
    .INIT(64'h0330BBBB03308888)) 
    \accumulator[4]_i_4 
       (.I0(data3[4]),
        .I1(btnr_IBUF),
        .I2(sw_IBUF[4]),
        .I3(Q[4]),
        .I4(btnl_IBUF),
        .I5(data2[4]),
        .O(\accumulator[4]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \accumulator[5]_i_1 
       (.I0(accumulator_reg[5]),
        .I1(btnr_IBUF),
        .I2(\accumulator_reg[5]_0 ),
        .I3(btnc_IBUF),
        .I4(\accumulator[5]_i_4_n_0 ),
        .O(D[5]));
  LUT6 #(
    .INIT(64'h0330BBBB03308888)) 
    \accumulator[5]_i_4 
       (.I0(data3[5]),
        .I1(btnr_IBUF),
        .I2(Q[5]),
        .I3(sw_IBUF[5]),
        .I4(btnl_IBUF),
        .I5(data2[5]),
        .O(\accumulator[5]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \accumulator[6]_i_1 
       (.I0(accumulator_reg[6]),
        .I1(btnr_IBUF),
        .I2(\accumulator_reg[6]_0 ),
        .I3(btnc_IBUF),
        .I4(\accumulator[6]_i_4_n_0 ),
        .O(D[6]));
  LUT6 #(
    .INIT(64'h0330BBBB03308888)) 
    \accumulator[6]_i_4 
       (.I0(data3[6]),
        .I1(btnr_IBUF),
        .I2(Q[6]),
        .I3(sw_IBUF[6]),
        .I4(btnl_IBUF),
        .I5(data2[6]),
        .O(\accumulator[6]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0330BBBB03308888)) 
    \accumulator[7]_i_2 
       (.I0(data3[7]),
        .I1(btnr_IBUF),
        .I2(Q[7]),
        .I3(sw_IBUF[7]),
        .I4(btnl_IBUF),
        .I5(data2[7]),
        .O(\accumulator[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0330BBBB03308888)) 
    \accumulator[8]_i_2 
       (.I0(data3[8]),
        .I1(btnr_IBUF),
        .I2(Q[8]),
        .I3(sw_IBUF[8]),
        .I4(btnl_IBUF),
        .I5(data2[8]),
        .O(\accumulator[8]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \accumulator[9]_i_1 
       (.I0(accumulator_reg[9]),
        .I1(btnr_IBUF),
        .I2(\accumulator_reg[9]_0 ),
        .I3(btnc_IBUF),
        .I4(\accumulator[9]_i_4_n_0 ),
        .O(D[9]));
  LUT6 #(
    .INIT(64'h0330BBBB03308888)) 
    \accumulator[9]_i_4 
       (.I0(data3[9]),
        .I1(btnr_IBUF),
        .I2(Q[9]),
        .I3(sw_IBUF[9]),
        .I4(btnl_IBUF),
        .I5(data2[9]),
        .O(\accumulator[9]_i_4_n_0 ));
  MUXF7 \accumulator_reg[15]_i_2 
       (.I0(\accumulator[15]_i_3_n_0 ),
        .I1(accumulator_reg[15]),
        .O(D[15]),
        .S(btnc_IBUF));
  MUXF7 \accumulator_reg[7]_i_1 
       (.I0(\accumulator[7]_i_2_n_0 ),
        .I1(accumulator_reg[7]),
        .O(D[7]),
        .S(btnc_IBUF));
  MUXF7 \accumulator_reg[8]_i_1 
       (.I0(\accumulator[8]_i_2_n_0 ),
        .I1(accumulator_reg[8]),
        .O(D[8]),
        .S(btnc_IBUF));
  LUT4 #(
    .INIT(16'h7510)) 
    i__carry__0_i_1
       (.I0(Q[15]),
        .I1(Q[14]),
        .I2(sw_IBUF[14]),
        .I3(sw_IBUF[15]),
        .O(i__carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__0_i_1__0
       (.I0(Q[7]),
        .I1(sw_IBUF[7]),
        .O(i__carry__0_i_1__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_1__1
       (.I0(sw_IBUF[7]),
        .I1(Q[7]),
        .O(i__carry__0_i_1__1_n_0));
  LUT4 #(
    .INIT(16'h4D44)) 
    i__carry__0_i_2
       (.I0(Q[13]),
        .I1(sw_IBUF[13]),
        .I2(Q[12]),
        .I3(sw_IBUF[12]),
        .O(i__carry__0_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__0_i_2__0
       (.I0(Q[6]),
        .I1(sw_IBUF[6]),
        .O(i__carry__0_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_2__1
       (.I0(sw_IBUF[6]),
        .I1(Q[6]),
        .O(i__carry__0_i_2__1_n_0));
  LUT4 #(
    .INIT(16'h4D44)) 
    i__carry__0_i_3
       (.I0(Q[11]),
        .I1(sw_IBUF[11]),
        .I2(Q[10]),
        .I3(sw_IBUF[10]),
        .O(i__carry__0_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__0_i_3__0
       (.I0(Q[5]),
        .I1(sw_IBUF[5]),
        .O(i__carry__0_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_3__1
       (.I0(sw_IBUF[5]),
        .I1(Q[5]),
        .O(i__carry__0_i_3__1_n_0));
  LUT4 #(
    .INIT(16'h4D44)) 
    i__carry__0_i_4
       (.I0(Q[9]),
        .I1(sw_IBUF[9]),
        .I2(Q[8]),
        .I3(sw_IBUF[8]),
        .O(i__carry__0_i_4_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__0_i_4__0
       (.I0(Q[4]),
        .I1(sw_IBUF[4]),
        .O(i__carry__0_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_4__1
       (.I0(Q[4]),
        .I1(sw_IBUF[4]),
        .O(i__carry__0_i_4__1_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    i__carry__0_i_5
       (.I0(sw_IBUF[15]),
        .I1(Q[15]),
        .I2(sw_IBUF[14]),
        .I3(Q[14]),
        .O(i__carry__0_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    i__carry__0_i_6
       (.I0(sw_IBUF[12]),
        .I1(Q[12]),
        .I2(sw_IBUF[13]),
        .I3(Q[13]),
        .O(i__carry__0_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    i__carry__0_i_7
       (.I0(sw_IBUF[10]),
        .I1(Q[10]),
        .I2(sw_IBUF[11]),
        .I3(Q[11]),
        .O(i__carry__0_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    i__carry__0_i_8
       (.I0(sw_IBUF[8]),
        .I1(Q[8]),
        .I2(sw_IBUF[9]),
        .I3(Q[9]),
        .O(i__carry__0_i_8_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry__1_i_1
       (.I0(sw_IBUF[15]),
        .I1(Q[15]),
        .O(i__carry__1_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__1_i_1__0
       (.I0(Q[11]),
        .I1(sw_IBUF[11]),
        .O(i__carry__1_i_1__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_1__1
       (.I0(sw_IBUF[11]),
        .I1(Q[11]),
        .O(i__carry__1_i_1__1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry__1_i_2
       (.I0(sw_IBUF[15]),
        .I1(Q[15]),
        .O(i__carry__1_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__1_i_2__0
       (.I0(Q[10]),
        .I1(sw_IBUF[10]),
        .O(i__carry__1_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_2__1
       (.I0(sw_IBUF[10]),
        .I1(Q[10]),
        .O(i__carry__1_i_2__1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry__1_i_3
       (.I0(sw_IBUF[15]),
        .I1(Q[15]),
        .O(i__carry__1_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__1_i_3__0
       (.I0(Q[9]),
        .I1(sw_IBUF[9]),
        .O(i__carry__1_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_3__1
       (.I0(sw_IBUF[9]),
        .I1(Q[9]),
        .O(i__carry__1_i_3__1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry__1_i_4
       (.I0(sw_IBUF[15]),
        .I1(Q[15]),
        .O(i__carry__1_i_4_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__1_i_4__0
       (.I0(Q[8]),
        .I1(sw_IBUF[8]),
        .O(i__carry__1_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_4__1
       (.I0(sw_IBUF[8]),
        .I1(Q[8]),
        .O(i__carry__1_i_4__1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_5
       (.I0(Q[15]),
        .I1(sw_IBUF[15]),
        .O(i__carry__1_i_5_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_6
       (.I0(Q[15]),
        .I1(sw_IBUF[15]),
        .O(i__carry__1_i_6_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_7
       (.I0(Q[15]),
        .I1(sw_IBUF[15]),
        .O(i__carry__1_i_7_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_8
       (.I0(Q[15]),
        .I1(sw_IBUF[15]),
        .O(i__carry__1_i_8_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__2_i_1
       (.I0(Q[15]),
        .I1(sw_IBUF[15]),
        .O(i__carry__2_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_1__0
       (.I0(Q[15]),
        .I1(sw_IBUF[15]),
        .O(i__carry__2_i_1__0_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry__2_i_1__1
       (.I0(Q[15]),
        .I1(sw_IBUF[15]),
        .O(i__carry__2_i_1__1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry__2_i_2
       (.I0(sw_IBUF[15]),
        .I1(Q[15]),
        .O(i__carry__2_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__2_i_2__0
       (.I0(Q[14]),
        .I1(sw_IBUF[14]),
        .O(i__carry__2_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_2__1
       (.I0(sw_IBUF[14]),
        .I1(Q[14]),
        .O(i__carry__2_i_2__1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry__2_i_3
       (.I0(sw_IBUF[15]),
        .I1(Q[15]),
        .O(i__carry__2_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__2_i_3__0
       (.I0(Q[13]),
        .I1(sw_IBUF[13]),
        .O(i__carry__2_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_3__1
       (.I0(sw_IBUF[13]),
        .I1(Q[13]),
        .O(i__carry__2_i_3__1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry__2_i_4
       (.I0(sw_IBUF[15]),
        .I1(Q[15]),
        .O(i__carry__2_i_4_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__2_i_4__0
       (.I0(Q[12]),
        .I1(sw_IBUF[12]),
        .O(i__carry__2_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_4__1
       (.I0(sw_IBUF[12]),
        .I1(Q[12]),
        .O(i__carry__2_i_4__1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_5
       (.I0(Q[15]),
        .I1(sw_IBUF[15]),
        .O(i__carry__2_i_5_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_6
       (.I0(Q[15]),
        .I1(sw_IBUF[15]),
        .O(i__carry__2_i_6_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_7
       (.I0(Q[15]),
        .I1(sw_IBUF[15]),
        .O(i__carry__2_i_7_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_8
       (.I0(Q[15]),
        .I1(sw_IBUF[15]),
        .O(i__carry__2_i_8_n_0));
  LUT4 #(
    .INIT(16'h4D44)) 
    i__carry_i_1
       (.I0(Q[7]),
        .I1(sw_IBUF[7]),
        .I2(Q[6]),
        .I3(sw_IBUF[6]),
        .O(i__carry_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_1__0
       (.I0(Q[3]),
        .I1(sw_IBUF[3]),
        .O(i__carry_i_1__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_1__1
       (.I0(Q[3]),
        .I1(sw_IBUF[3]),
        .O(i__carry_i_1__1_n_0));
  LUT4 #(
    .INIT(16'h4D44)) 
    i__carry_i_2
       (.I0(Q[5]),
        .I1(sw_IBUF[5]),
        .I2(Q[4]),
        .I3(sw_IBUF[4]),
        .O(i__carry_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_2__0
       (.I0(Q[2]),
        .I1(sw_IBUF[2]),
        .O(i__carry_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_2__1
       (.I0(Q[2]),
        .I1(sw_IBUF[2]),
        .O(i__carry_i_2__1_n_0));
  LUT4 #(
    .INIT(16'h20BA)) 
    i__carry_i_3
       (.I0(sw_IBUF[3]),
        .I1(Q[2]),
        .I2(sw_IBUF[2]),
        .I3(Q[3]),
        .O(i__carry_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_3__0
       (.I0(Q[1]),
        .I1(sw_IBUF[1]),
        .O(i__carry_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_3__1
       (.I0(Q[1]),
        .I1(sw_IBUF[1]),
        .O(i__carry_i_3__1_n_0));
  LUT4 #(
    .INIT(16'h4D44)) 
    i__carry_i_4
       (.I0(Q[1]),
        .I1(sw_IBUF[1]),
        .I2(Q[0]),
        .I3(sw_IBUF[0]),
        .O(i__carry_i_4_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_4__0
       (.I0(Q[0]),
        .I1(sw_IBUF[0]),
        .O(i__carry_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_4__1
       (.I0(Q[0]),
        .I1(sw_IBUF[0]),
        .O(i__carry_i_4__1_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    i__carry_i_5
       (.I0(sw_IBUF[6]),
        .I1(Q[6]),
        .I2(sw_IBUF[7]),
        .I3(Q[7]),
        .O(i__carry_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    i__carry_i_6
       (.I0(sw_IBUF[4]),
        .I1(Q[4]),
        .I2(sw_IBUF[5]),
        .I3(Q[5]),
        .O(i__carry_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    i__carry_i_7
       (.I0(sw_IBUF[2]),
        .I1(Q[2]),
        .I2(sw_IBUF[3]),
        .I3(Q[3]),
        .O(i__carry_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    i__carry_i_8
       (.I0(sw_IBUF[0]),
        .I1(Q[0]),
        .I2(sw_IBUF[1]),
        .I3(Q[1]),
        .O(i__carry_i_8_n_0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \result0_inferred__1/i__carry 
       (.CI(\<const0> ),
        .CO({\result0_inferred__1/i__carry_n_0 ,\NLW_result0_inferred__1/i__carry_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI(Q[3:0]),
        .O(data2[3:0]),
        .S({i__carry_i_1__0_n_0,i__carry_i_2__0_n_0,i__carry_i_3__0_n_0,i__carry_i_4__0_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \result0_inferred__1/i__carry__0 
       (.CI(\result0_inferred__1/i__carry_n_0 ),
        .CO({\result0_inferred__1/i__carry__0_n_0 ,\NLW_result0_inferred__1/i__carry__0_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI(Q[7:4]),
        .O(data2[7:4]),
        .S({i__carry__0_i_1__0_n_0,i__carry__0_i_2__0_n_0,i__carry__0_i_3__0_n_0,i__carry__0_i_4__0_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \result0_inferred__1/i__carry__1 
       (.CI(\result0_inferred__1/i__carry__0_n_0 ),
        .CO({\result0_inferred__1/i__carry__1_n_0 ,\NLW_result0_inferred__1/i__carry__1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI(Q[11:8]),
        .O(data2[11:8]),
        .S({i__carry__1_i_1__0_n_0,i__carry__1_i_2__0_n_0,i__carry__1_i_3__0_n_0,i__carry__1_i_4__0_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \result0_inferred__1/i__carry__2 
       (.CI(\result0_inferred__1/i__carry__1_n_0 ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,Q[14:12]}),
        .O(data2[15:12]),
        .S({i__carry__2_i_1_n_0,i__carry__2_i_2__0_n_0,i__carry__2_i_3__0_n_0,i__carry__2_i_4__0_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \result0_inferred__2/i__carry 
       (.CI(\<const0> ),
        .CO({\result0_inferred__2/i__carry_n_0 ,\NLW_result0_inferred__2/i__carry_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const1> ),
        .DI(Q[3:0]),
        .O(data3[3:0]),
        .S({i__carry_i_1__1_n_0,i__carry_i_2__1_n_0,i__carry_i_3__1_n_0,i__carry_i_4__1_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \result0_inferred__2/i__carry__0 
       (.CI(\result0_inferred__2/i__carry_n_0 ),
        .CO({\result0_inferred__2/i__carry__0_n_0 ,\NLW_result0_inferred__2/i__carry__0_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI(Q[7:4]),
        .O(data3[7:4]),
        .S({i__carry__0_i_1__1_n_0,i__carry__0_i_2__1_n_0,i__carry__0_i_3__1_n_0,i__carry__0_i_4__1_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \result0_inferred__2/i__carry__1 
       (.CI(\result0_inferred__2/i__carry__0_n_0 ),
        .CO({\result0_inferred__2/i__carry__1_n_0 ,\NLW_result0_inferred__2/i__carry__1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI(Q[11:8]),
        .O(data3[11:8]),
        .S({i__carry__1_i_1__1_n_0,i__carry__1_i_2__1_n_0,i__carry__1_i_3__1_n_0,i__carry__1_i_4__1_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \result0_inferred__2/i__carry__2 
       (.CI(\result0_inferred__2/i__carry__1_n_0 ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,Q[14:12]}),
        .O(data3[15:12]),
        .S({i__carry__2_i_1__0_n_0,i__carry__2_i_2__1_n_0,i__carry__2_i_3__1_n_0,i__carry__2_i_4__1_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \result0_inferred__3/i__carry 
       (.CI(\<const0> ),
        .CO({\result0_inferred__3/i__carry_n_0 ,\NLW_result0_inferred__3/i__carry_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({i__carry_i_1_n_0,i__carry_i_2_n_0,i__carry_i_3_n_0,i__carry_i_4_n_0}),
        .S({i__carry_i_5_n_0,i__carry_i_6_n_0,i__carry_i_7_n_0,i__carry_i_8_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \result0_inferred__3/i__carry__0 
       (.CI(\result0_inferred__3/i__carry_n_0 ),
        .CO({\result0_inferred__3/i__carry__0_n_0 ,\NLW_result0_inferred__3/i__carry__0_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({i__carry__0_i_1_n_0,i__carry__0_i_2_n_0,i__carry__0_i_3_n_0,i__carry__0_i_4_n_0}),
        .S({i__carry__0_i_5_n_0,i__carry__0_i_6_n_0,i__carry__0_i_7_n_0,i__carry__0_i_8_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \result0_inferred__3/i__carry__1 
       (.CI(\result0_inferred__3/i__carry__0_n_0 ),
        .CO({\result0_inferred__3/i__carry__1_n_0 ,\NLW_result0_inferred__3/i__carry__1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({i__carry__1_i_1_n_0,i__carry__1_i_2_n_0,i__carry__1_i_3_n_0,i__carry__1_i_4_n_0}),
        .S({i__carry__1_i_5_n_0,i__carry__1_i_6_n_0,i__carry__1_i_7_n_0,i__carry__1_i_8_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \result0_inferred__3/i__carry__2 
       (.CI(\result0_inferred__3/i__carry__1_n_0 ),
        .CO({data4,\NLW_result0_inferred__3/i__carry__2_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({i__carry__2_i_1__1_n_0,i__carry__2_i_2_n_0,i__carry__2_i_3_n_0,i__carry__2_i_4_n_0}),
        .S({i__carry__2_i_5_n_0,i__carry__2_i_6_n_0,i__carry__2_i_7_n_0,i__carry__2_i_8_n_0}));
endmodule

(* ADD = "4'b0010" *) (* AND = "4'b0000" *) (* ECO_CHECKSUM = "824d8421" *) 
(* OR = "4'b0001" *) (* SLL = "4'b1001" *) (* SLT = "4'b0111" *) 
(* SRA = "4'b1010" *) (* SRL = "4'b1000" *) (* SUB = "4'b0110" *) 
(* XOR = "4'b1101" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module calc
   (btnc,
    btnd,
    btnl,
    btnr,
    btnu,
    clk,
    led,
    sw);
  input btnc;
  input btnd;
  input btnl;
  input btnr;
  input btnu;
  input clk;
  output [15:0]led;
  input [15:0]sw;

  wire \accumulator[0]_i_2_n_0 ;
  wire \accumulator[0]_i_3_n_0 ;
  wire \accumulator[0]_i_5_n_0 ;
  wire \accumulator[0]_i_6_n_0 ;
  wire \accumulator[0]_i_7_n_0 ;
  wire \accumulator[0]_i_8_n_0 ;
  wire \accumulator[10]_i_2_n_0 ;
  wire \accumulator[10]_i_3_n_0 ;
  wire \accumulator[10]_i_5_n_0 ;
  wire \accumulator[10]_i_6_n_0 ;
  wire \accumulator[10]_i_7_n_0 ;
  wire \accumulator[10]_i_8_n_0 ;
  wire \accumulator[10]_i_9_n_0 ;
  wire \accumulator[11]_i_2_n_0 ;
  wire \accumulator[11]_i_3_n_0 ;
  wire \accumulator[11]_i_5_n_0 ;
  wire \accumulator[11]_i_6_n_0 ;
  wire \accumulator[11]_i_7_n_0 ;
  wire \accumulator[11]_i_8_n_0 ;
  wire \accumulator[11]_i_9_n_0 ;
  wire \accumulator[12]_i_2_n_0 ;
  wire \accumulator[12]_i_3_n_0 ;
  wire \accumulator[12]_i_5_n_0 ;
  wire \accumulator[12]_i_6_n_0 ;
  wire \accumulator[12]_i_7_n_0 ;
  wire \accumulator[12]_i_8_n_0 ;
  wire \accumulator[12]_i_9_n_0 ;
  wire \accumulator[13]_i_10_n_0 ;
  wire \accumulator[13]_i_11_n_0 ;
  wire \accumulator[13]_i_2_n_0 ;
  wire \accumulator[13]_i_3_n_0 ;
  wire \accumulator[13]_i_5_n_0 ;
  wire \accumulator[13]_i_6_n_0 ;
  wire \accumulator[13]_i_7_n_0 ;
  wire \accumulator[13]_i_8_n_0 ;
  wire \accumulator[13]_i_9_n_0 ;
  wire \accumulator[14]_i_10_n_0 ;
  wire \accumulator[14]_i_2_n_0 ;
  wire \accumulator[14]_i_3_n_0 ;
  wire \accumulator[14]_i_5_n_0 ;
  wire \accumulator[14]_i_6_n_0 ;
  wire \accumulator[14]_i_7_n_0 ;
  wire \accumulator[14]_i_8_n_0 ;
  wire \accumulator[14]_i_9_n_0 ;
  wire \accumulator[15]_i_4_n_0 ;
  wire \accumulator[15]_i_5_n_0 ;
  wire \accumulator[15]_i_6_n_0 ;
  wire \accumulator[15]_i_7_n_0 ;
  wire \accumulator[15]_i_8_n_0 ;
  wire \accumulator[15]_i_9_n_0 ;
  wire \accumulator[1]_i_2_n_0 ;
  wire \accumulator[1]_i_3_n_0 ;
  wire \accumulator[1]_i_5_n_0 ;
  wire \accumulator[1]_i_6_n_0 ;
  wire \accumulator[1]_i_7_n_0 ;
  wire \accumulator[2]_i_2_n_0 ;
  wire \accumulator[2]_i_3_n_0 ;
  wire \accumulator[2]_i_5_n_0 ;
  wire \accumulator[2]_i_6_n_0 ;
  wire \accumulator[2]_i_7_n_0 ;
  wire \accumulator[3]_i_2_n_0 ;
  wire \accumulator[3]_i_3_n_0 ;
  wire \accumulator[3]_i_5_n_0 ;
  wire \accumulator[3]_i_6_n_0 ;
  wire \accumulator[3]_i_7_n_0 ;
  wire \accumulator[3]_i_8_n_0 ;
  wire \accumulator[3]_i_9_n_0 ;
  wire \accumulator[4]_i_2_n_0 ;
  wire \accumulator[4]_i_3_n_0 ;
  wire \accumulator[4]_i_5_n_0 ;
  wire \accumulator[4]_i_6_n_0 ;
  wire \accumulator[4]_i_7_n_0 ;
  wire \accumulator[4]_i_8_n_0 ;
  wire \accumulator[5]_i_10_n_0 ;
  wire \accumulator[5]_i_2_n_0 ;
  wire \accumulator[5]_i_3_n_0 ;
  wire \accumulator[5]_i_5_n_0 ;
  wire \accumulator[5]_i_6_n_0 ;
  wire \accumulator[5]_i_7_n_0 ;
  wire \accumulator[5]_i_8_n_0 ;
  wire \accumulator[5]_i_9_n_0 ;
  wire \accumulator[6]_i_2_n_0 ;
  wire \accumulator[6]_i_3_n_0 ;
  wire \accumulator[6]_i_5_n_0 ;
  wire \accumulator[6]_i_6_n_0 ;
  wire \accumulator[6]_i_7_n_0 ;
  wire \accumulator[6]_i_8_n_0 ;
  wire \accumulator[7]_i_3_n_0 ;
  wire \accumulator[7]_i_4_n_0 ;
  wire \accumulator[7]_i_5_n_0 ;
  wire \accumulator[7]_i_6_n_0 ;
  wire \accumulator[8]_i_3_n_0 ;
  wire \accumulator[8]_i_4_n_0 ;
  wire \accumulator[8]_i_5_n_0 ;
  wire \accumulator[8]_i_6_n_0 ;
  wire \accumulator[8]_i_7_n_0 ;
  wire \accumulator[9]_i_2_n_0 ;
  wire \accumulator[9]_i_3_n_0 ;
  wire \accumulator[9]_i_5_n_0 ;
  wire \accumulator[9]_i_6_n_0 ;
  wire \accumulator[9]_i_7_n_0 ;
  wire \accumulator[9]_i_8_n_0 ;
  wire \accumulator[9]_i_9_n_0 ;
  wire btnc;
  wire btnc_IBUF;
  wire btnd;
  wire btnd_IBUF;
  wire btnl;
  wire btnl_IBUF;
  wire btnr;
  wire btnr_IBUF;
  wire btnu;
  wire btnu_IBUF;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire [15:0]led;
  wire [15:0]led_OBUF;
  wire os_n_0;
  wire [15:0]result;
  wire [15:0]sw;
  wire [15:0]sw_IBUF;

  LUT6 #(
    .INIT(64'hB8FFB8FFB8FFB800)) 
    \accumulator[0]_i_2 
       (.I0(led_OBUF[15]),
        .I1(sw_IBUF[4]),
        .I2(\accumulator[0]_i_5_n_0 ),
        .I3(btnl_IBUF),
        .I4(led_OBUF[0]),
        .I5(sw_IBUF[0]),
        .O(\accumulator[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h0F002020)) 
    \accumulator[0]_i_3 
       (.I0(\accumulator[0]_i_6_n_0 ),
        .I1(sw_IBUF[4]),
        .I2(btnl_IBUF),
        .I3(led_OBUF[0]),
        .I4(sw_IBUF[0]),
        .O(\accumulator[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[0]_i_5 
       (.I0(\accumulator[9]_i_8_n_0 ),
        .I1(\accumulator[1]_i_7_n_0 ),
        .I2(sw_IBUF[0]),
        .I3(\accumulator[8]_i_6_n_0 ),
        .I4(sw_IBUF[3]),
        .I5(\accumulator[0]_i_8_n_0 ),
        .O(\accumulator[0]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \accumulator[0]_i_6 
       (.I0(sw_IBUF[2]),
        .I1(led_OBUF[0]),
        .I2(sw_IBUF[1]),
        .I3(sw_IBUF[3]),
        .O(\accumulator[0]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \accumulator[0]_i_7 
       (.I0(sw_IBUF[0]),
        .I1(led_OBUF[0]),
        .O(\accumulator[0]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[0]_i_8 
       (.I0(led_OBUF[6]),
        .I1(led_OBUF[4]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[2]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[0]),
        .O(\accumulator[0]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'hBBB8)) 
    \accumulator[10]_i_2 
       (.I0(\accumulator[10]_i_5_n_0 ),
        .I1(btnl_IBUF),
        .I2(sw_IBUF[10]),
        .I3(led_OBUF[10]),
        .O(\accumulator[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \accumulator[10]_i_3 
       (.I0(\accumulator[11]_i_6_n_0 ),
        .I1(sw_IBUF[0]),
        .I2(\accumulator[10]_i_6_n_0 ),
        .I3(sw_IBUF[4]),
        .I4(btnl_IBUF),
        .I5(\accumulator[10]_i_7_n_0 ),
        .O(\accumulator[10]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hEF40EF45EF40EA40)) 
    \accumulator[10]_i_5 
       (.I0(sw_IBUF[4]),
        .I1(\accumulator[11]_i_8_n_0 ),
        .I2(sw_IBUF[0]),
        .I3(led_OBUF[15]),
        .I4(sw_IBUF[3]),
        .I5(\accumulator[10]_i_8_n_0 ),
        .O(\accumulator[10]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \accumulator[10]_i_6 
       (.I0(sw_IBUF[1]),
        .I1(led_OBUF[1]),
        .I2(sw_IBUF[2]),
        .I3(sw_IBUF[3]),
        .I4(\accumulator[10]_i_9_n_0 ),
        .O(\accumulator[10]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \accumulator[10]_i_7 
       (.I0(sw_IBUF[10]),
        .I1(led_OBUF[10]),
        .O(\accumulator[10]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[10]_i_8 
       (.I0(led_OBUF[15]),
        .I1(led_OBUF[14]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[12]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[10]),
        .O(\accumulator[10]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[10]_i_9 
       (.I0(led_OBUF[3]),
        .I1(led_OBUF[5]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[7]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[9]),
        .O(\accumulator[10]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'hBBB8)) 
    \accumulator[11]_i_2 
       (.I0(\accumulator[11]_i_5_n_0 ),
        .I1(btnl_IBUF),
        .I2(sw_IBUF[11]),
        .I3(led_OBUF[11]),
        .O(\accumulator[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \accumulator[11]_i_3 
       (.I0(\accumulator[12]_i_6_n_0 ),
        .I1(sw_IBUF[0]),
        .I2(\accumulator[11]_i_6_n_0 ),
        .I3(sw_IBUF[4]),
        .I4(btnl_IBUF),
        .I5(\accumulator[11]_i_7_n_0 ),
        .O(\accumulator[11]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \accumulator[11]_i_5 
       (.I0(led_OBUF[15]),
        .I1(sw_IBUF[4]),
        .I2(\accumulator[12]_i_8_n_0 ),
        .I3(sw_IBUF[0]),
        .I4(\accumulator[11]_i_8_n_0 ),
        .O(\accumulator[11]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \accumulator[11]_i_6 
       (.I0(led_OBUF[2]),
        .I1(sw_IBUF[1]),
        .I2(led_OBUF[0]),
        .I3(sw_IBUF[2]),
        .I4(sw_IBUF[3]),
        .I5(\accumulator[11]_i_9_n_0 ),
        .O(\accumulator[11]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \accumulator[11]_i_7 
       (.I0(sw_IBUF[11]),
        .I1(led_OBUF[11]),
        .O(\accumulator[11]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hCDC8CDCDCDC8C8C8)) 
    \accumulator[11]_i_8 
       (.I0(sw_IBUF[3]),
        .I1(led_OBUF[15]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[13]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[11]),
        .O(\accumulator[11]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[11]_i_9 
       (.I0(led_OBUF[4]),
        .I1(led_OBUF[6]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[8]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[10]),
        .O(\accumulator[11]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'hBBB8)) 
    \accumulator[12]_i_2 
       (.I0(\accumulator[12]_i_5_n_0 ),
        .I1(btnl_IBUF),
        .I2(sw_IBUF[12]),
        .I3(led_OBUF[12]),
        .O(\accumulator[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \accumulator[12]_i_3 
       (.I0(\accumulator[13]_i_6_n_0 ),
        .I1(sw_IBUF[0]),
        .I2(\accumulator[12]_i_6_n_0 ),
        .I3(sw_IBUF[4]),
        .I4(btnl_IBUF),
        .I5(\accumulator[12]_i_7_n_0 ),
        .O(\accumulator[12]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \accumulator[12]_i_5 
       (.I0(led_OBUF[15]),
        .I1(sw_IBUF[4]),
        .I2(\accumulator[13]_i_9_n_0 ),
        .I3(sw_IBUF[0]),
        .I4(\accumulator[12]_i_8_n_0 ),
        .O(\accumulator[12]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \accumulator[12]_i_6 
       (.I0(led_OBUF[3]),
        .I1(sw_IBUF[1]),
        .I2(led_OBUF[1]),
        .I3(sw_IBUF[2]),
        .I4(sw_IBUF[3]),
        .I5(\accumulator[12]_i_9_n_0 ),
        .O(\accumulator[12]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \accumulator[12]_i_7 
       (.I0(sw_IBUF[12]),
        .I1(led_OBUF[12]),
        .O(\accumulator[12]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hCDC8CDCDCDC8C8C8)) 
    \accumulator[12]_i_8 
       (.I0(sw_IBUF[3]),
        .I1(led_OBUF[15]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[14]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[12]),
        .O(\accumulator[12]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[12]_i_9 
       (.I0(led_OBUF[5]),
        .I1(led_OBUF[7]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[9]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[11]),
        .O(\accumulator[12]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \accumulator[13]_i_10 
       (.I0(led_OBUF[0]),
        .I1(sw_IBUF[2]),
        .I2(led_OBUF[2]),
        .I3(sw_IBUF[1]),
        .I4(led_OBUF[4]),
        .O(\accumulator[13]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[13]_i_11 
       (.I0(led_OBUF[6]),
        .I1(led_OBUF[8]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[10]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[12]),
        .O(\accumulator[13]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'hBBB8)) 
    \accumulator[13]_i_2 
       (.I0(\accumulator[13]_i_5_n_0 ),
        .I1(btnl_IBUF),
        .I2(sw_IBUF[13]),
        .I3(led_OBUF[13]),
        .O(\accumulator[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \accumulator[13]_i_3 
       (.I0(\accumulator[14]_i_7_n_0 ),
        .I1(sw_IBUF[0]),
        .I2(\accumulator[13]_i_6_n_0 ),
        .I3(sw_IBUF[4]),
        .I4(btnl_IBUF),
        .I5(\accumulator[13]_i_7_n_0 ),
        .O(\accumulator[13]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \accumulator[13]_i_5 
       (.I0(led_OBUF[15]),
        .I1(sw_IBUF[4]),
        .I2(\accumulator[13]_i_8_n_0 ),
        .I3(sw_IBUF[0]),
        .I4(\accumulator[13]_i_9_n_0 ),
        .O(\accumulator[13]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \accumulator[13]_i_6 
       (.I0(\accumulator[13]_i_10_n_0 ),
        .I1(sw_IBUF[3]),
        .I2(\accumulator[13]_i_11_n_0 ),
        .O(\accumulator[13]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \accumulator[13]_i_7 
       (.I0(sw_IBUF[13]),
        .I1(led_OBUF[13]),
        .O(\accumulator[13]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'hF0F1F0E0)) 
    \accumulator[13]_i_8 
       (.I0(sw_IBUF[3]),
        .I1(sw_IBUF[2]),
        .I2(led_OBUF[15]),
        .I3(sw_IBUF[1]),
        .I4(led_OBUF[14]),
        .O(\accumulator[13]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hF0F1F0E0)) 
    \accumulator[13]_i_9 
       (.I0(sw_IBUF[3]),
        .I1(sw_IBUF[2]),
        .I2(led_OBUF[15]),
        .I3(sw_IBUF[1]),
        .I4(led_OBUF[13]),
        .O(\accumulator[13]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[14]_i_10 
       (.I0(led_OBUF[7]),
        .I1(led_OBUF[9]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[11]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[13]),
        .O(\accumulator[14]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hB8FFB8FFB8FFB800)) 
    \accumulator[14]_i_2 
       (.I0(led_OBUF[15]),
        .I1(sw_IBUF[4]),
        .I2(\accumulator[14]_i_5_n_0 ),
        .I3(btnl_IBUF),
        .I4(sw_IBUF[14]),
        .I5(led_OBUF[14]),
        .O(\accumulator[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \accumulator[14]_i_3 
       (.I0(\accumulator[14]_i_6_n_0 ),
        .I1(sw_IBUF[0]),
        .I2(\accumulator[14]_i_7_n_0 ),
        .I3(sw_IBUF[4]),
        .I4(btnl_IBUF),
        .I5(\accumulator[14]_i_8_n_0 ),
        .O(\accumulator[14]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFF00FF01FF00FE00)) 
    \accumulator[14]_i_5 
       (.I0(sw_IBUF[0]),
        .I1(sw_IBUF[3]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[15]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[14]),
        .O(\accumulator[14]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \accumulator[14]_i_6 
       (.I0(\accumulator[15]_i_6_n_0 ),
        .I1(sw_IBUF[3]),
        .I2(\accumulator[15]_i_7_n_0 ),
        .O(\accumulator[14]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \accumulator[14]_i_7 
       (.I0(\accumulator[14]_i_9_n_0 ),
        .I1(sw_IBUF[3]),
        .I2(\accumulator[14]_i_10_n_0 ),
        .O(\accumulator[14]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \accumulator[14]_i_8 
       (.I0(sw_IBUF[14]),
        .I1(led_OBUF[14]),
        .O(\accumulator[14]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \accumulator[14]_i_9 
       (.I0(led_OBUF[1]),
        .I1(sw_IBUF[2]),
        .I2(led_OBUF[3]),
        .I3(sw_IBUF[1]),
        .I4(led_OBUF[5]),
        .O(\accumulator[14]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hAEFFAEAA04AA0400)) 
    \accumulator[15]_i_4 
       (.I0(btnr_IBUF),
        .I1(\accumulator[15]_i_5_n_0 ),
        .I2(sw_IBUF[4]),
        .I3(btnl_IBUF),
        .I4(sw_IBUF[15]),
        .I5(led_OBUF[15]),
        .O(\accumulator[15]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[15]_i_5 
       (.I0(\accumulator[15]_i_6_n_0 ),
        .I1(\accumulator[15]_i_7_n_0 ),
        .I2(sw_IBUF[0]),
        .I3(\accumulator[15]_i_8_n_0 ),
        .I4(sw_IBUF[3]),
        .I5(\accumulator[15]_i_9_n_0 ),
        .O(\accumulator[15]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[15]_i_6 
       (.I0(led_OBUF[0]),
        .I1(led_OBUF[2]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[4]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[6]),
        .O(\accumulator[15]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[15]_i_7 
       (.I0(led_OBUF[8]),
        .I1(led_OBUF[10]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[12]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[14]),
        .O(\accumulator[15]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[15]_i_8 
       (.I0(led_OBUF[1]),
        .I1(led_OBUF[3]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[5]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[7]),
        .O(\accumulator[15]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[15]_i_9 
       (.I0(led_OBUF[9]),
        .I1(led_OBUF[11]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[13]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[15]),
        .O(\accumulator[15]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hB8FFB8FFB8FFB800)) 
    \accumulator[1]_i_2 
       (.I0(led_OBUF[15]),
        .I1(sw_IBUF[4]),
        .I2(\accumulator[1]_i_5_n_0 ),
        .I3(btnl_IBUF),
        .I4(led_OBUF[1]),
        .I5(sw_IBUF[1]),
        .O(\accumulator[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h2F202020)) 
    \accumulator[1]_i_3 
       (.I0(\accumulator[1]_i_6_n_0 ),
        .I1(sw_IBUF[4]),
        .I2(btnl_IBUF),
        .I3(led_OBUF[1]),
        .I4(sw_IBUF[1]),
        .O(\accumulator[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[1]_i_5 
       (.I0(\accumulator[10]_i_8_n_0 ),
        .I1(\accumulator[2]_i_7_n_0 ),
        .I2(sw_IBUF[0]),
        .I3(\accumulator[9]_i_8_n_0 ),
        .I4(sw_IBUF[3]),
        .I5(\accumulator[1]_i_7_n_0 ),
        .O(\accumulator[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000B08)) 
    \accumulator[1]_i_6 
       (.I0(led_OBUF[0]),
        .I1(sw_IBUF[0]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[1]),
        .I4(sw_IBUF[1]),
        .I5(sw_IBUF[3]),
        .O(\accumulator[1]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[1]_i_7 
       (.I0(led_OBUF[7]),
        .I1(led_OBUF[5]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[3]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[1]),
        .O(\accumulator[1]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hB8FFB8FFB8FFB800)) 
    \accumulator[2]_i_2 
       (.I0(led_OBUF[15]),
        .I1(sw_IBUF[4]),
        .I2(\accumulator[2]_i_5_n_0 ),
        .I3(btnl_IBUF),
        .I4(led_OBUF[2]),
        .I5(sw_IBUF[2]),
        .O(\accumulator[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h2F202020)) 
    \accumulator[2]_i_3 
       (.I0(\accumulator[2]_i_6_n_0 ),
        .I1(sw_IBUF[4]),
        .I2(btnl_IBUF),
        .I3(led_OBUF[2]),
        .I4(sw_IBUF[2]),
        .O(\accumulator[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[2]_i_5 
       (.I0(\accumulator[3]_i_8_n_0 ),
        .I1(\accumulator[3]_i_9_n_0 ),
        .I2(sw_IBUF[0]),
        .I3(\accumulator[10]_i_8_n_0 ),
        .I4(sw_IBUF[3]),
        .I5(\accumulator[2]_i_7_n_0 ),
        .O(\accumulator[2]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0004FFFF00040000)) 
    \accumulator[2]_i_6 
       (.I0(sw_IBUF[2]),
        .I1(led_OBUF[1]),
        .I2(sw_IBUF[1]),
        .I3(sw_IBUF[3]),
        .I4(sw_IBUF[0]),
        .I5(\accumulator[3]_i_6_n_0 ),
        .O(\accumulator[2]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[2]_i_7 
       (.I0(led_OBUF[8]),
        .I1(led_OBUF[6]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[4]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[2]),
        .O(\accumulator[2]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hB8FFB8FFB8FFB800)) 
    \accumulator[3]_i_2 
       (.I0(led_OBUF[15]),
        .I1(sw_IBUF[4]),
        .I2(\accumulator[3]_i_5_n_0 ),
        .I3(btnl_IBUF),
        .I4(led_OBUF[3]),
        .I5(sw_IBUF[3]),
        .O(\accumulator[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \accumulator[3]_i_3 
       (.I0(\accumulator[4]_i_6_n_0 ),
        .I1(sw_IBUF[0]),
        .I2(\accumulator[3]_i_6_n_0 ),
        .I3(sw_IBUF[4]),
        .I4(btnl_IBUF),
        .I5(\accumulator[3]_i_7_n_0 ),
        .O(\accumulator[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[3]_i_5 
       (.I0(\accumulator[4]_i_7_n_0 ),
        .I1(\accumulator[4]_i_8_n_0 ),
        .I2(sw_IBUF[0]),
        .I3(\accumulator[3]_i_8_n_0 ),
        .I4(sw_IBUF[3]),
        .I5(\accumulator[3]_i_9_n_0 ),
        .O(\accumulator[3]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h00004540)) 
    \accumulator[3]_i_6 
       (.I0(sw_IBUF[2]),
        .I1(led_OBUF[0]),
        .I2(sw_IBUF[1]),
        .I3(led_OBUF[2]),
        .I4(sw_IBUF[3]),
        .O(\accumulator[3]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \accumulator[3]_i_7 
       (.I0(led_OBUF[3]),
        .I1(sw_IBUF[3]),
        .O(\accumulator[3]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \accumulator[3]_i_8 
       (.I0(led_OBUF[15]),
        .I1(sw_IBUF[2]),
        .I2(led_OBUF[13]),
        .I3(sw_IBUF[1]),
        .I4(led_OBUF[11]),
        .O(\accumulator[3]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[3]_i_9 
       (.I0(led_OBUF[9]),
        .I1(led_OBUF[7]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[5]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[3]),
        .O(\accumulator[3]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hAFAFCFC0)) 
    \accumulator[4]_i_2 
       (.I0(led_OBUF[15]),
        .I1(\accumulator[4]_i_5_n_0 ),
        .I2(btnl_IBUF),
        .I3(led_OBUF[4]),
        .I4(sw_IBUF[4]),
        .O(\accumulator[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00FF0000E200E200)) 
    \accumulator[4]_i_3 
       (.I0(\accumulator[5]_i_7_n_0 ),
        .I1(sw_IBUF[0]),
        .I2(\accumulator[4]_i_6_n_0 ),
        .I3(btnl_IBUF),
        .I4(led_OBUF[4]),
        .I5(sw_IBUF[4]),
        .O(\accumulator[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[4]_i_5 
       (.I0(\accumulator[5]_i_9_n_0 ),
        .I1(\accumulator[5]_i_10_n_0 ),
        .I2(sw_IBUF[0]),
        .I3(\accumulator[4]_i_7_n_0 ),
        .I4(sw_IBUF[3]),
        .I5(\accumulator[4]_i_8_n_0 ),
        .O(\accumulator[4]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h00004540)) 
    \accumulator[4]_i_6 
       (.I0(sw_IBUF[2]),
        .I1(led_OBUF[1]),
        .I2(sw_IBUF[1]),
        .I3(led_OBUF[3]),
        .I4(sw_IBUF[3]),
        .O(\accumulator[4]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \accumulator[4]_i_7 
       (.I0(led_OBUF[15]),
        .I1(sw_IBUF[2]),
        .I2(led_OBUF[14]),
        .I3(sw_IBUF[1]),
        .I4(led_OBUF[12]),
        .O(\accumulator[4]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[4]_i_8 
       (.I0(led_OBUF[10]),
        .I1(led_OBUF[8]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[6]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[4]),
        .O(\accumulator[4]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[5]_i_10 
       (.I0(led_OBUF[11]),
        .I1(led_OBUF[9]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[7]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[5]),
        .O(\accumulator[5]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hB8FFB8FFB8FFB800)) 
    \accumulator[5]_i_2 
       (.I0(led_OBUF[15]),
        .I1(sw_IBUF[4]),
        .I2(\accumulator[5]_i_5_n_0 ),
        .I3(btnl_IBUF),
        .I4(sw_IBUF[5]),
        .I5(led_OBUF[5]),
        .O(\accumulator[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \accumulator[5]_i_3 
       (.I0(\accumulator[5]_i_6_n_0 ),
        .I1(sw_IBUF[0]),
        .I2(\accumulator[5]_i_7_n_0 ),
        .I3(sw_IBUF[4]),
        .I4(btnl_IBUF),
        .I5(\accumulator[5]_i_8_n_0 ),
        .O(\accumulator[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[5]_i_5 
       (.I0(\accumulator[6]_i_7_n_0 ),
        .I1(\accumulator[6]_i_8_n_0 ),
        .I2(sw_IBUF[0]),
        .I3(\accumulator[5]_i_9_n_0 ),
        .I4(sw_IBUF[3]),
        .I5(\accumulator[5]_i_10_n_0 ),
        .O(\accumulator[5]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \accumulator[5]_i_6 
       (.I0(led_OBUF[5]),
        .I1(sw_IBUF[1]),
        .I2(led_OBUF[3]),
        .I3(sw_IBUF[2]),
        .I4(led_OBUF[1]),
        .I5(sw_IBUF[3]),
        .O(\accumulator[5]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \accumulator[5]_i_7 
       (.I0(led_OBUF[4]),
        .I1(sw_IBUF[1]),
        .I2(led_OBUF[2]),
        .I3(sw_IBUF[2]),
        .I4(led_OBUF[0]),
        .I5(sw_IBUF[3]),
        .O(\accumulator[5]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \accumulator[5]_i_8 
       (.I0(sw_IBUF[5]),
        .I1(led_OBUF[5]),
        .O(\accumulator[5]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hCDC8)) 
    \accumulator[5]_i_9 
       (.I0(sw_IBUF[2]),
        .I1(led_OBUF[15]),
        .I2(sw_IBUF[1]),
        .I3(led_OBUF[13]),
        .O(\accumulator[5]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hB8FFB8FFB8FFB800)) 
    \accumulator[6]_i_2 
       (.I0(led_OBUF[15]),
        .I1(sw_IBUF[4]),
        .I2(\accumulator[6]_i_5_n_0 ),
        .I3(btnl_IBUF),
        .I4(sw_IBUF[6]),
        .I5(led_OBUF[6]),
        .O(\accumulator[6]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hB888)) 
    \accumulator[6]_i_3 
       (.I0(\accumulator[6]_i_6_n_0 ),
        .I1(btnl_IBUF),
        .I2(sw_IBUF[6]),
        .I3(led_OBUF[6]),
        .O(\accumulator[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[6]_i_5 
       (.I0(led_OBUF[15]),
        .I1(\accumulator[7]_i_6_n_0 ),
        .I2(sw_IBUF[0]),
        .I3(\accumulator[6]_i_7_n_0 ),
        .I4(sw_IBUF[3]),
        .I5(\accumulator[6]_i_8_n_0 ),
        .O(\accumulator[6]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h0000F404)) 
    \accumulator[6]_i_6 
       (.I0(sw_IBUF[3]),
        .I1(\accumulator[15]_i_6_n_0 ),
        .I2(sw_IBUF[0]),
        .I3(\accumulator[5]_i_6_n_0 ),
        .I4(sw_IBUF[4]),
        .O(\accumulator[6]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hCDC8)) 
    \accumulator[6]_i_7 
       (.I0(sw_IBUF[2]),
        .I1(led_OBUF[15]),
        .I2(sw_IBUF[1]),
        .I3(led_OBUF[14]),
        .O(\accumulator[6]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[6]_i_8 
       (.I0(led_OBUF[12]),
        .I1(led_OBUF[10]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[8]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[6]),
        .O(\accumulator[6]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hB8FFB8CCB8CCB800)) 
    \accumulator[7]_i_3 
       (.I0(\accumulator[7]_i_4_n_0 ),
        .I1(btnr_IBUF),
        .I2(\accumulator[7]_i_5_n_0 ),
        .I3(btnl_IBUF),
        .I4(sw_IBUF[7]),
        .I5(led_OBUF[7]),
        .O(\accumulator[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFF00EF45FF00EA40)) 
    \accumulator[7]_i_4 
       (.I0(sw_IBUF[4]),
        .I1(\accumulator[8]_i_6_n_0 ),
        .I2(sw_IBUF[0]),
        .I3(led_OBUF[15]),
        .I4(sw_IBUF[3]),
        .I5(\accumulator[7]_i_6_n_0 ),
        .O(\accumulator[7]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00005404)) 
    \accumulator[7]_i_5 
       (.I0(sw_IBUF[3]),
        .I1(\accumulator[15]_i_8_n_0 ),
        .I2(sw_IBUF[0]),
        .I3(\accumulator[15]_i_6_n_0 ),
        .I4(sw_IBUF[4]),
        .O(\accumulator[7]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[7]_i_6 
       (.I0(led_OBUF[13]),
        .I1(led_OBUF[11]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[9]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[7]),
        .O(\accumulator[7]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hB8FFB8CCB8CCB800)) 
    \accumulator[8]_i_3 
       (.I0(\accumulator[8]_i_4_n_0 ),
        .I1(btnr_IBUF),
        .I2(\accumulator[8]_i_5_n_0 ),
        .I3(btnl_IBUF),
        .I4(sw_IBUF[8]),
        .I5(led_OBUF[8]),
        .O(\accumulator[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFF00EF45FF00EA40)) 
    \accumulator[8]_i_4 
       (.I0(sw_IBUF[4]),
        .I1(\accumulator[9]_i_8_n_0 ),
        .I2(sw_IBUF[0]),
        .I3(led_OBUF[15]),
        .I4(sw_IBUF[3]),
        .I5(\accumulator[8]_i_6_n_0 ),
        .O(\accumulator[8]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \accumulator[8]_i_5 
       (.I0(\accumulator[9]_i_9_n_0 ),
        .I1(sw_IBUF[3]),
        .I2(\accumulator[8]_i_7_n_0 ),
        .I3(sw_IBUF[0]),
        .I4(\accumulator[15]_i_8_n_0 ),
        .I5(sw_IBUF[4]),
        .O(\accumulator[8]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[8]_i_6 
       (.I0(led_OBUF[14]),
        .I1(led_OBUF[12]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[10]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[8]),
        .O(\accumulator[8]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \accumulator[8]_i_7 
       (.I0(sw_IBUF[1]),
        .I1(led_OBUF[0]),
        .I2(sw_IBUF[2]),
        .O(\accumulator[8]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'hBBB8)) 
    \accumulator[9]_i_2 
       (.I0(\accumulator[9]_i_5_n_0 ),
        .I1(btnl_IBUF),
        .I2(sw_IBUF[9]),
        .I3(led_OBUF[9]),
        .O(\accumulator[9]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \accumulator[9]_i_3 
       (.I0(\accumulator[10]_i_6_n_0 ),
        .I1(sw_IBUF[0]),
        .I2(\accumulator[9]_i_6_n_0 ),
        .I3(sw_IBUF[4]),
        .I4(btnl_IBUF),
        .I5(\accumulator[9]_i_7_n_0 ),
        .O(\accumulator[9]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFF00EF45FF00EA40)) 
    \accumulator[9]_i_5 
       (.I0(sw_IBUF[4]),
        .I1(\accumulator[10]_i_8_n_0 ),
        .I2(sw_IBUF[0]),
        .I3(led_OBUF[15]),
        .I4(sw_IBUF[3]),
        .I5(\accumulator[9]_i_8_n_0 ),
        .O(\accumulator[9]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \accumulator[9]_i_6 
       (.I0(sw_IBUF[1]),
        .I1(led_OBUF[0]),
        .I2(sw_IBUF[2]),
        .I3(sw_IBUF[3]),
        .I4(\accumulator[9]_i_9_n_0 ),
        .O(\accumulator[9]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \accumulator[9]_i_7 
       (.I0(sw_IBUF[9]),
        .I1(led_OBUF[9]),
        .O(\accumulator[9]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[9]_i_8 
       (.I0(led_OBUF[15]),
        .I1(led_OBUF[13]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[11]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[9]),
        .O(\accumulator[9]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \accumulator[9]_i_9 
       (.I0(led_OBUF[2]),
        .I1(led_OBUF[4]),
        .I2(sw_IBUF[2]),
        .I3(led_OBUF[6]),
        .I4(sw_IBUF[1]),
        .I5(led_OBUF[8]),
        .O(\accumulator[9]_i_9_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \accumulator_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(os_n_0),
        .D(result[0]),
        .Q(led_OBUF[0]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \accumulator_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(os_n_0),
        .D(result[10]),
        .Q(led_OBUF[10]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \accumulator_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(os_n_0),
        .D(result[11]),
        .Q(led_OBUF[11]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \accumulator_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(os_n_0),
        .D(result[12]),
        .Q(led_OBUF[12]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \accumulator_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(os_n_0),
        .D(result[13]),
        .Q(led_OBUF[13]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \accumulator_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(os_n_0),
        .D(result[14]),
        .Q(led_OBUF[14]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \accumulator_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(os_n_0),
        .D(result[15]),
        .Q(led_OBUF[15]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \accumulator_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(os_n_0),
        .D(result[1]),
        .Q(led_OBUF[1]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \accumulator_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(os_n_0),
        .D(result[2]),
        .Q(led_OBUF[2]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \accumulator_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(os_n_0),
        .D(result[3]),
        .Q(led_OBUF[3]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \accumulator_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(os_n_0),
        .D(result[4]),
        .Q(led_OBUF[4]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \accumulator_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(os_n_0),
        .D(result[5]),
        .Q(led_OBUF[5]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \accumulator_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(os_n_0),
        .D(result[6]),
        .Q(led_OBUF[6]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \accumulator_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(os_n_0),
        .D(result[7]),
        .Q(led_OBUF[7]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \accumulator_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(os_n_0),
        .D(result[8]),
        .Q(led_OBUF[8]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \accumulator_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(os_n_0),
        .D(result[9]),
        .Q(led_OBUF[9]),
        .R(btnu_IBUF));
  alu alu_calc
       (.D(result),
        .Q(led_OBUF),
        .accumulator_reg({\accumulator[15]_i_4_n_0 ,\accumulator[14]_i_2_n_0 ,\accumulator[13]_i_2_n_0 ,\accumulator[12]_i_2_n_0 ,\accumulator[11]_i_2_n_0 ,\accumulator[10]_i_2_n_0 ,\accumulator[9]_i_2_n_0 ,\accumulator[8]_i_3_n_0 ,\accumulator[7]_i_3_n_0 ,\accumulator[6]_i_2_n_0 ,\accumulator[5]_i_2_n_0 ,\accumulator[4]_i_2_n_0 ,\accumulator[3]_i_2_n_0 ,\accumulator[2]_i_2_n_0 ,\accumulator[1]_i_2_n_0 ,\accumulator[0]_i_2_n_0 }),
        .\accumulator_reg[0]_0 (\accumulator[0]_i_3_n_0 ),
        .\accumulator_reg[0]_1 (\accumulator[0]_i_7_n_0 ),
        .\accumulator_reg[10]_0 (\accumulator[10]_i_3_n_0 ),
        .\accumulator_reg[11]_0 (\accumulator[11]_i_3_n_0 ),
        .\accumulator_reg[12]_0 (\accumulator[12]_i_3_n_0 ),
        .\accumulator_reg[13]_0 (\accumulator[13]_i_3_n_0 ),
        .\accumulator_reg[14]_0 (\accumulator[14]_i_3_n_0 ),
        .\accumulator_reg[1]_0 (\accumulator[1]_i_3_n_0 ),
        .\accumulator_reg[2]_0 (\accumulator[2]_i_3_n_0 ),
        .\accumulator_reg[3]_0 (\accumulator[3]_i_3_n_0 ),
        .\accumulator_reg[4]_0 (\accumulator[4]_i_3_n_0 ),
        .\accumulator_reg[5]_0 (\accumulator[5]_i_3_n_0 ),
        .\accumulator_reg[6]_0 (\accumulator[6]_i_3_n_0 ),
        .\accumulator_reg[9]_0 (\accumulator[9]_i_3_n_0 ),
        .btnc_IBUF(btnc_IBUF),
        .btnl_IBUF(btnl_IBUF),
        .btnr_IBUF(btnr_IBUF),
        .sw_IBUF(sw_IBUF));
  IBUF btnc_IBUF_inst
       (.I(btnc),
        .O(btnc_IBUF));
  IBUF btnd_IBUF_inst
       (.I(btnd),
        .O(btnd_IBUF));
  IBUF btnl_IBUF_inst
       (.I(btnl),
        .O(btnl_IBUF));
  IBUF btnr_IBUF_inst
       (.I(btnr),
        .O(btnr_IBUF));
  IBUF btnu_IBUF_inst
       (.I(btnu),
        .O(btnu_IBUF));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  OBUF \led_OBUF[0]_inst 
       (.I(led_OBUF[0]),
        .O(led[0]));
  OBUF \led_OBUF[10]_inst 
       (.I(led_OBUF[10]),
        .O(led[10]));
  OBUF \led_OBUF[11]_inst 
       (.I(led_OBUF[11]),
        .O(led[11]));
  OBUF \led_OBUF[12]_inst 
       (.I(led_OBUF[12]),
        .O(led[12]));
  OBUF \led_OBUF[13]_inst 
       (.I(led_OBUF[13]),
        .O(led[13]));
  OBUF \led_OBUF[14]_inst 
       (.I(led_OBUF[14]),
        .O(led[14]));
  OBUF \led_OBUF[15]_inst 
       (.I(led_OBUF[15]),
        .O(led[15]));
  OBUF \led_OBUF[1]_inst 
       (.I(led_OBUF[1]),
        .O(led[1]));
  OBUF \led_OBUF[2]_inst 
       (.I(led_OBUF[2]),
        .O(led[2]));
  OBUF \led_OBUF[3]_inst 
       (.I(led_OBUF[3]),
        .O(led[3]));
  OBUF \led_OBUF[4]_inst 
       (.I(led_OBUF[4]),
        .O(led[4]));
  OBUF \led_OBUF[5]_inst 
       (.I(led_OBUF[5]),
        .O(led[5]));
  OBUF \led_OBUF[6]_inst 
       (.I(led_OBUF[6]),
        .O(led[6]));
  OBUF \led_OBUF[7]_inst 
       (.I(led_OBUF[7]),
        .O(led[7]));
  OBUF \led_OBUF[8]_inst 
       (.I(led_OBUF[8]),
        .O(led[8]));
  OBUF \led_OBUF[9]_inst 
       (.I(led_OBUF[9]),
        .O(led[9]));
  oneshot os
       (.E(os_n_0),
        .SR(btnu_IBUF),
        .btnd_IBUF(btnd_IBUF),
        .clk_IBUF_BUFG(clk_IBUF_BUFG));
  IBUF \sw_IBUF[0]_inst 
       (.I(sw[0]),
        .O(sw_IBUF[0]));
  IBUF \sw_IBUF[10]_inst 
       (.I(sw[10]),
        .O(sw_IBUF[10]));
  IBUF \sw_IBUF[11]_inst 
       (.I(sw[11]),
        .O(sw_IBUF[11]));
  IBUF \sw_IBUF[12]_inst 
       (.I(sw[12]),
        .O(sw_IBUF[12]));
  IBUF \sw_IBUF[13]_inst 
       (.I(sw[13]),
        .O(sw_IBUF[13]));
  IBUF \sw_IBUF[14]_inst 
       (.I(sw[14]),
        .O(sw_IBUF[14]));
  IBUF \sw_IBUF[15]_inst 
       (.I(sw[15]),
        .O(sw_IBUF[15]));
  IBUF \sw_IBUF[1]_inst 
       (.I(sw[1]),
        .O(sw_IBUF[1]));
  IBUF \sw_IBUF[2]_inst 
       (.I(sw[2]),
        .O(sw_IBUF[2]));
  IBUF \sw_IBUF[3]_inst 
       (.I(sw[3]),
        .O(sw_IBUF[3]));
  IBUF \sw_IBUF[4]_inst 
       (.I(sw[4]),
        .O(sw_IBUF[4]));
  IBUF \sw_IBUF[5]_inst 
       (.I(sw[5]),
        .O(sw_IBUF[5]));
  IBUF \sw_IBUF[6]_inst 
       (.I(sw[6]),
        .O(sw_IBUF[6]));
  IBUF \sw_IBUF[7]_inst 
       (.I(sw[7]),
        .O(sw_IBUF[7]));
  IBUF \sw_IBUF[8]_inst 
       (.I(sw[8]),
        .O(sw_IBUF[8]));
  IBUF \sw_IBUF[9]_inst 
       (.I(sw[9]),
        .O(sw_IBUF[9]));
endmodule

module oneshot
   (btnd_IBUF,
    clk_IBUF_BUFG,
    E,
    SR);
  input btnd_IBUF;
  input clk_IBUF_BUFG;
  output [0:0]E;
  input [0:0]SR;

  wire \<const0> ;
  wire \<const1> ;
  wire [0:0]E;
  wire \FSM_sequential_state[0]_i_1_n_0 ;
  wire \FSM_sequential_state[1]_i_1_n_0 ;
  wire [0:0]SR;
  wire btnd_IBUF;
  wire clk_IBUF_BUFG;
  wire [1:0]state;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \FSM_sequential_state[0]_i_1 
       (.I0(state[1]),
        .I1(btnd_IBUF),
        .I2(state[0]),
        .I3(SR),
        .O(\FSM_sequential_state[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h0048)) 
    \FSM_sequential_state[1]_i_1 
       (.I0(state[1]),
        .I1(btnd_IBUF),
        .I2(state[0]),
        .I3(SR),
        .O(\FSM_sequential_state[1]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "INC:01,ONE:10,ZERO:00,iSTATE:11" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_sequential_state[0]_i_1_n_0 ),
        .Q(state[0]),
        .R(\<const0> ));
  (* FSM_ENCODED_STATES = "INC:01,ONE:10,ZERO:00,iSTATE:11" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_sequential_state[1]_i_1_n_0 ),
        .Q(state[1]),
        .R(\<const0> ));
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  LUT2 #(
    .INIT(4'h2)) 
    \accumulator[15]_i_1 
       (.I0(state[0]),
        .I1(state[1]),
        .O(E));
endmodule
