// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Sat Jan 21 20:15:48 2023
// Host        : CCL3 running 64-bit Ubuntu 20.04.5 LTS
// Command     : write_verilog -force -file /home/palm9727/bfasst/build/xilinx_conformal_impl/byu/uart_ssc/ssc_impl.v
// Design      : ssc
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7a200tsbg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* COUNT_BITS = "17" *) (* ECO_CHECKSUM = "168073d8" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module ssc
   (clk,
    reset,
    anode,
    dataIn,
    digitDisplay,
    digitPoint,
    segment);
  input clk;
  input reset;
  output [7:0]anode;
  input [31:0]dataIn;
  input [7:0]digitDisplay;
  input [7:0]digitPoint;
  output [7:0]segment;

  wire \<const0> ;
  wire \<const1> ;
  wire [7:0]anode;
  wire [7:0]anode_OBUF;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire \count_val[0]_i_2_n_0 ;
  wire \count_val_reg[0]_i_1_n_0 ;
  wire \count_val_reg[0]_i_1_n_4 ;
  wire \count_val_reg[0]_i_1_n_5 ;
  wire \count_val_reg[0]_i_1_n_6 ;
  wire \count_val_reg[0]_i_1_n_7 ;
  wire \count_val_reg[12]_i_1_n_0 ;
  wire \count_val_reg[12]_i_1_n_4 ;
  wire \count_val_reg[12]_i_1_n_5 ;
  wire \count_val_reg[12]_i_1_n_6 ;
  wire \count_val_reg[12]_i_1_n_7 ;
  wire \count_val_reg[16]_i_1_n_7 ;
  wire \count_val_reg[4]_i_1_n_0 ;
  wire \count_val_reg[4]_i_1_n_4 ;
  wire \count_val_reg[4]_i_1_n_5 ;
  wire \count_val_reg[4]_i_1_n_6 ;
  wire \count_val_reg[4]_i_1_n_7 ;
  wire \count_val_reg[8]_i_1_n_0 ;
  wire \count_val_reg[8]_i_1_n_4 ;
  wire \count_val_reg[8]_i_1_n_5 ;
  wire \count_val_reg[8]_i_1_n_6 ;
  wire \count_val_reg[8]_i_1_n_7 ;
  wire [13:0]count_val_reg_n_0_;
  wire [31:0]dataIn;
  wire [31:0]dataIn_IBUF;
  wire [7:0]digitDisplay;
  wire [7:0]digitDisplay_IBUF;
  wire [7:0]digitPoint;
  wire [7:0]digitPoint_IBUF;
  wire reset;
  wire reset_IBUF;
  wire [7:0]segment;
  wire [7:0]segment_OBUF;
  wire \segment_OBUF[6]_inst_i_10_n_0 ;
  wire \segment_OBUF[6]_inst_i_11_n_0 ;
  wire \segment_OBUF[6]_inst_i_12_n_0 ;
  wire \segment_OBUF[6]_inst_i_13_n_0 ;
  wire \segment_OBUF[6]_inst_i_2_n_0 ;
  wire \segment_OBUF[6]_inst_i_3_n_0 ;
  wire \segment_OBUF[6]_inst_i_4_n_0 ;
  wire \segment_OBUF[6]_inst_i_5_n_0 ;
  wire \segment_OBUF[6]_inst_i_6_n_0 ;
  wire \segment_OBUF[6]_inst_i_7_n_0 ;
  wire \segment_OBUF[6]_inst_i_8_n_0 ;
  wire \segment_OBUF[6]_inst_i_9_n_0 ;
  wire \segment_OBUF[7]_inst_i_2_n_0 ;
  wire \segment_OBUF[7]_inst_i_3_n_0 ;
  wire [2:0]sel0;
  wire [3:0]\NLW_count_val_reg[0]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_count_val_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_count_val_reg[4]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_count_val_reg[8]_i_1_CO_UNCONNECTED ;

  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  OBUF \anode_OBUF[0]_inst 
       (.I(anode_OBUF[0]),
        .O(anode[0]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hFEFF)) 
    \anode_OBUF[0]_inst_i_1 
       (.I0(sel0[0]),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(digitDisplay_IBUF[0]),
        .O(anode_OBUF[0]));
  OBUF \anode_OBUF[1]_inst 
       (.I(anode_OBUF[1]),
        .O(anode[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hFDFF)) 
    \anode_OBUF[1]_inst_i_1 
       (.I0(sel0[0]),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(digitDisplay_IBUF[1]),
        .O(anode_OBUF[1]));
  OBUF \anode_OBUF[2]_inst 
       (.I(anode_OBUF[2]),
        .O(anode[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hFDFF)) 
    \anode_OBUF[2]_inst_i_1 
       (.I0(sel0[1]),
        .I1(sel0[0]),
        .I2(sel0[2]),
        .I3(digitDisplay_IBUF[2]),
        .O(anode_OBUF[2]));
  OBUF \anode_OBUF[3]_inst 
       (.I(anode_OBUF[3]),
        .O(anode[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hBFFF)) 
    \anode_OBUF[3]_inst_i_1 
       (.I0(sel0[2]),
        .I1(sel0[0]),
        .I2(sel0[1]),
        .I3(digitDisplay_IBUF[3]),
        .O(anode_OBUF[3]));
  OBUF \anode_OBUF[4]_inst 
       (.I(anode_OBUF[4]),
        .O(anode[4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hFDFF)) 
    \anode_OBUF[4]_inst_i_1 
       (.I0(sel0[2]),
        .I1(sel0[0]),
        .I2(sel0[1]),
        .I3(digitDisplay_IBUF[4]),
        .O(anode_OBUF[4]));
  OBUF \anode_OBUF[5]_inst 
       (.I(anode_OBUF[5]),
        .O(anode[5]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hBFFF)) 
    \anode_OBUF[5]_inst_i_1 
       (.I0(sel0[1]),
        .I1(sel0[0]),
        .I2(sel0[2]),
        .I3(digitDisplay_IBUF[5]),
        .O(anode_OBUF[5]));
  OBUF \anode_OBUF[6]_inst 
       (.I(anode_OBUF[6]),
        .O(anode[6]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hBFFF)) 
    \anode_OBUF[6]_inst_i_1 
       (.I0(sel0[0]),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(digitDisplay_IBUF[6]),
        .O(anode_OBUF[6]));
  OBUF \anode_OBUF[7]_inst 
       (.I(anode_OBUF[7]),
        .O(anode[7]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    \anode_OBUF[7]_inst_i_1 
       (.I0(sel0[1]),
        .I1(sel0[0]),
        .I2(sel0[2]),
        .I3(digitDisplay_IBUF[7]),
        .O(anode_OBUF[7]));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  LUT1 #(
    .INIT(2'h1)) 
    \count_val[0]_i_2 
       (.I0(count_val_reg_n_0_[0]),
        .O(\count_val[0]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[0]_i_1_n_7 ),
        .Q(count_val_reg_n_0_[0]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_val_reg[0]_i_1 
       (.CI(\<const0> ),
        .CO({\count_val_reg[0]_i_1_n_0 ,\NLW_count_val_reg[0]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .O({\count_val_reg[0]_i_1_n_4 ,\count_val_reg[0]_i_1_n_5 ,\count_val_reg[0]_i_1_n_6 ,\count_val_reg[0]_i_1_n_7 }),
        .S({count_val_reg_n_0_[3:1],\count_val[0]_i_2_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[8]_i_1_n_5 ),
        .Q(count_val_reg_n_0_[10]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[8]_i_1_n_4 ),
        .Q(count_val_reg_n_0_[11]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[12]_i_1_n_7 ),
        .Q(count_val_reg_n_0_[12]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_val_reg[12]_i_1 
       (.CI(\count_val_reg[8]_i_1_n_0 ),
        .CO({\count_val_reg[12]_i_1_n_0 ,\NLW_count_val_reg[12]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\count_val_reg[12]_i_1_n_4 ,\count_val_reg[12]_i_1_n_5 ,\count_val_reg[12]_i_1_n_6 ,\count_val_reg[12]_i_1_n_7 }),
        .S({sel0[1:0],count_val_reg_n_0_[13:12]}));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[12]_i_1_n_6 ),
        .Q(count_val_reg_n_0_[13]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[12]_i_1_n_5 ),
        .Q(sel0[0]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[12]_i_1_n_4 ),
        .Q(sel0[1]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[16]_i_1_n_7 ),
        .Q(sel0[2]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \count_val_reg[16]_i_1 
       (.CI(\count_val_reg[12]_i_1_n_0 ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(\count_val_reg[16]_i_1_n_7 ),
        .S({\<const0> ,\<const0> ,\<const0> ,sel0[2]}));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[0]_i_1_n_6 ),
        .Q(count_val_reg_n_0_[1]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[0]_i_1_n_5 ),
        .Q(count_val_reg_n_0_[2]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[0]_i_1_n_4 ),
        .Q(count_val_reg_n_0_[3]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[4]_i_1_n_7 ),
        .Q(count_val_reg_n_0_[4]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_val_reg[4]_i_1 
       (.CI(\count_val_reg[0]_i_1_n_0 ),
        .CO({\count_val_reg[4]_i_1_n_0 ,\NLW_count_val_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\count_val_reg[4]_i_1_n_4 ,\count_val_reg[4]_i_1_n_5 ,\count_val_reg[4]_i_1_n_6 ,\count_val_reg[4]_i_1_n_7 }),
        .S(count_val_reg_n_0_[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[4]_i_1_n_6 ),
        .Q(count_val_reg_n_0_[5]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[4]_i_1_n_5 ),
        .Q(count_val_reg_n_0_[6]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[4]_i_1_n_4 ),
        .Q(count_val_reg_n_0_[7]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[8]_i_1_n_7 ),
        .Q(count_val_reg_n_0_[8]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_val_reg[8]_i_1 
       (.CI(\count_val_reg[4]_i_1_n_0 ),
        .CO({\count_val_reg[8]_i_1_n_0 ,\NLW_count_val_reg[8]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\count_val_reg[8]_i_1_n_4 ,\count_val_reg[8]_i_1_n_5 ,\count_val_reg[8]_i_1_n_6 ,\count_val_reg[8]_i_1_n_7 }),
        .S(count_val_reg_n_0_[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_val_reg[8]_i_1_n_6 ),
        .Q(count_val_reg_n_0_[9]),
        .R(reset_IBUF));
  IBUF \dataIn_IBUF[0]_inst 
       (.I(dataIn[0]),
        .O(dataIn_IBUF[0]));
  IBUF \dataIn_IBUF[10]_inst 
       (.I(dataIn[10]),
        .O(dataIn_IBUF[10]));
  IBUF \dataIn_IBUF[11]_inst 
       (.I(dataIn[11]),
        .O(dataIn_IBUF[11]));
  IBUF \dataIn_IBUF[12]_inst 
       (.I(dataIn[12]),
        .O(dataIn_IBUF[12]));
  IBUF \dataIn_IBUF[13]_inst 
       (.I(dataIn[13]),
        .O(dataIn_IBUF[13]));
  IBUF \dataIn_IBUF[14]_inst 
       (.I(dataIn[14]),
        .O(dataIn_IBUF[14]));
  IBUF \dataIn_IBUF[15]_inst 
       (.I(dataIn[15]),
        .O(dataIn_IBUF[15]));
  IBUF \dataIn_IBUF[16]_inst 
       (.I(dataIn[16]),
        .O(dataIn_IBUF[16]));
  IBUF \dataIn_IBUF[17]_inst 
       (.I(dataIn[17]),
        .O(dataIn_IBUF[17]));
  IBUF \dataIn_IBUF[18]_inst 
       (.I(dataIn[18]),
        .O(dataIn_IBUF[18]));
  IBUF \dataIn_IBUF[19]_inst 
       (.I(dataIn[19]),
        .O(dataIn_IBUF[19]));
  IBUF \dataIn_IBUF[1]_inst 
       (.I(dataIn[1]),
        .O(dataIn_IBUF[1]));
  IBUF \dataIn_IBUF[20]_inst 
       (.I(dataIn[20]),
        .O(dataIn_IBUF[20]));
  IBUF \dataIn_IBUF[21]_inst 
       (.I(dataIn[21]),
        .O(dataIn_IBUF[21]));
  IBUF \dataIn_IBUF[22]_inst 
       (.I(dataIn[22]),
        .O(dataIn_IBUF[22]));
  IBUF \dataIn_IBUF[23]_inst 
       (.I(dataIn[23]),
        .O(dataIn_IBUF[23]));
  IBUF \dataIn_IBUF[24]_inst 
       (.I(dataIn[24]),
        .O(dataIn_IBUF[24]));
  IBUF \dataIn_IBUF[25]_inst 
       (.I(dataIn[25]),
        .O(dataIn_IBUF[25]));
  IBUF \dataIn_IBUF[26]_inst 
       (.I(dataIn[26]),
        .O(dataIn_IBUF[26]));
  IBUF \dataIn_IBUF[27]_inst 
       (.I(dataIn[27]),
        .O(dataIn_IBUF[27]));
  IBUF \dataIn_IBUF[28]_inst 
       (.I(dataIn[28]),
        .O(dataIn_IBUF[28]));
  IBUF \dataIn_IBUF[29]_inst 
       (.I(dataIn[29]),
        .O(dataIn_IBUF[29]));
  IBUF \dataIn_IBUF[2]_inst 
       (.I(dataIn[2]),
        .O(dataIn_IBUF[2]));
  IBUF \dataIn_IBUF[30]_inst 
       (.I(dataIn[30]),
        .O(dataIn_IBUF[30]));
  IBUF \dataIn_IBUF[31]_inst 
       (.I(dataIn[31]),
        .O(dataIn_IBUF[31]));
  IBUF \dataIn_IBUF[3]_inst 
       (.I(dataIn[3]),
        .O(dataIn_IBUF[3]));
  IBUF \dataIn_IBUF[4]_inst 
       (.I(dataIn[4]),
        .O(dataIn_IBUF[4]));
  IBUF \dataIn_IBUF[5]_inst 
       (.I(dataIn[5]),
        .O(dataIn_IBUF[5]));
  IBUF \dataIn_IBUF[6]_inst 
       (.I(dataIn[6]),
        .O(dataIn_IBUF[6]));
  IBUF \dataIn_IBUF[7]_inst 
       (.I(dataIn[7]),
        .O(dataIn_IBUF[7]));
  IBUF \dataIn_IBUF[8]_inst 
       (.I(dataIn[8]),
        .O(dataIn_IBUF[8]));
  IBUF \dataIn_IBUF[9]_inst 
       (.I(dataIn[9]),
        .O(dataIn_IBUF[9]));
  IBUF \digitDisplay_IBUF[0]_inst 
       (.I(digitDisplay[0]),
        .O(digitDisplay_IBUF[0]));
  IBUF \digitDisplay_IBUF[1]_inst 
       (.I(digitDisplay[1]),
        .O(digitDisplay_IBUF[1]));
  IBUF \digitDisplay_IBUF[2]_inst 
       (.I(digitDisplay[2]),
        .O(digitDisplay_IBUF[2]));
  IBUF \digitDisplay_IBUF[3]_inst 
       (.I(digitDisplay[3]),
        .O(digitDisplay_IBUF[3]));
  IBUF \digitDisplay_IBUF[4]_inst 
       (.I(digitDisplay[4]),
        .O(digitDisplay_IBUF[4]));
  IBUF \digitDisplay_IBUF[5]_inst 
       (.I(digitDisplay[5]),
        .O(digitDisplay_IBUF[5]));
  IBUF \digitDisplay_IBUF[6]_inst 
       (.I(digitDisplay[6]),
        .O(digitDisplay_IBUF[6]));
  IBUF \digitDisplay_IBUF[7]_inst 
       (.I(digitDisplay[7]),
        .O(digitDisplay_IBUF[7]));
  IBUF \digitPoint_IBUF[0]_inst 
       (.I(digitPoint[0]),
        .O(digitPoint_IBUF[0]));
  IBUF \digitPoint_IBUF[1]_inst 
       (.I(digitPoint[1]),
        .O(digitPoint_IBUF[1]));
  IBUF \digitPoint_IBUF[2]_inst 
       (.I(digitPoint[2]),
        .O(digitPoint_IBUF[2]));
  IBUF \digitPoint_IBUF[3]_inst 
       (.I(digitPoint[3]),
        .O(digitPoint_IBUF[3]));
  IBUF \digitPoint_IBUF[4]_inst 
       (.I(digitPoint[4]),
        .O(digitPoint_IBUF[4]));
  IBUF \digitPoint_IBUF[5]_inst 
       (.I(digitPoint[5]),
        .O(digitPoint_IBUF[5]));
  IBUF \digitPoint_IBUF[6]_inst 
       (.I(digitPoint[6]),
        .O(digitPoint_IBUF[6]));
  IBUF \digitPoint_IBUF[7]_inst 
       (.I(digitPoint[7]),
        .O(digitPoint_IBUF[7]));
  IBUF reset_IBUF_inst
       (.I(reset),
        .O(reset_IBUF));
  OBUF \segment_OBUF[0]_inst 
       (.I(segment_OBUF[0]),
        .O(segment[0]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h2094)) 
    \segment_OBUF[0]_inst_i_1 
       (.I0(\segment_OBUF[6]_inst_i_2_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_4_n_0 ),
        .I2(\segment_OBUF[6]_inst_i_3_n_0 ),
        .I3(\segment_OBUF[6]_inst_i_5_n_0 ),
        .O(segment_OBUF[0]));
  OBUF \segment_OBUF[1]_inst 
       (.I(segment_OBUF[1]),
        .O(segment[1]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hA4C8)) 
    \segment_OBUF[1]_inst_i_1 
       (.I0(\segment_OBUF[6]_inst_i_2_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_4_n_0 ),
        .I2(\segment_OBUF[6]_inst_i_5_n_0 ),
        .I3(\segment_OBUF[6]_inst_i_3_n_0 ),
        .O(segment_OBUF[1]));
  OBUF \segment_OBUF[2]_inst 
       (.I(segment_OBUF[2]),
        .O(segment[2]));
  LUT4 #(
    .INIT(16'hA210)) 
    \segment_OBUF[2]_inst_i_1 
       (.I0(\segment_OBUF[6]_inst_i_2_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_3_n_0 ),
        .I2(\segment_OBUF[6]_inst_i_5_n_0 ),
        .I3(\segment_OBUF[6]_inst_i_4_n_0 ),
        .O(segment_OBUF[2]));
  OBUF \segment_OBUF[3]_inst 
       (.I(segment_OBUF[3]),
        .O(segment[3]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hC214)) 
    \segment_OBUF[3]_inst_i_1 
       (.I0(\segment_OBUF[6]_inst_i_2_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_4_n_0 ),
        .I2(\segment_OBUF[6]_inst_i_3_n_0 ),
        .I3(\segment_OBUF[6]_inst_i_5_n_0 ),
        .O(segment_OBUF[3]));
  OBUF \segment_OBUF[4]_inst 
       (.I(segment_OBUF[4]),
        .O(segment[4]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h5710)) 
    \segment_OBUF[4]_inst_i_1 
       (.I0(\segment_OBUF[6]_inst_i_2_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_5_n_0 ),
        .I2(\segment_OBUF[6]_inst_i_4_n_0 ),
        .I3(\segment_OBUF[6]_inst_i_3_n_0 ),
        .O(segment_OBUF[4]));
  OBUF \segment_OBUF[5]_inst 
       (.I(segment_OBUF[5]),
        .O(segment[5]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h5910)) 
    \segment_OBUF[5]_inst_i_1 
       (.I0(\segment_OBUF[6]_inst_i_2_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_4_n_0 ),
        .I2(\segment_OBUF[6]_inst_i_5_n_0 ),
        .I3(\segment_OBUF[6]_inst_i_3_n_0 ),
        .O(segment_OBUF[5]));
  OBUF \segment_OBUF[6]_inst 
       (.I(segment_OBUF[6]),
        .O(segment[6]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h4025)) 
    \segment_OBUF[6]_inst_i_1 
       (.I0(\segment_OBUF[6]_inst_i_2_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_3_n_0 ),
        .I2(\segment_OBUF[6]_inst_i_4_n_0 ),
        .I3(\segment_OBUF[6]_inst_i_5_n_0 ),
        .O(segment_OBUF[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \segment_OBUF[6]_inst_i_10 
       (.I0(dataIn_IBUF[14]),
        .I1(dataIn_IBUF[10]),
        .I2(sel0[1]),
        .I3(dataIn_IBUF[6]),
        .I4(sel0[0]),
        .I5(dataIn_IBUF[2]),
        .O(\segment_OBUF[6]_inst_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \segment_OBUF[6]_inst_i_11 
       (.I0(dataIn_IBUF[30]),
        .I1(dataIn_IBUF[26]),
        .I2(sel0[1]),
        .I3(dataIn_IBUF[22]),
        .I4(sel0[0]),
        .I5(dataIn_IBUF[18]),
        .O(\segment_OBUF[6]_inst_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \segment_OBUF[6]_inst_i_12 
       (.I0(dataIn_IBUF[13]),
        .I1(dataIn_IBUF[9]),
        .I2(sel0[1]),
        .I3(dataIn_IBUF[5]),
        .I4(sel0[0]),
        .I5(dataIn_IBUF[1]),
        .O(\segment_OBUF[6]_inst_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \segment_OBUF[6]_inst_i_13 
       (.I0(dataIn_IBUF[29]),
        .I1(dataIn_IBUF[25]),
        .I2(sel0[1]),
        .I3(dataIn_IBUF[21]),
        .I4(sel0[0]),
        .I5(dataIn_IBUF[17]),
        .O(\segment_OBUF[6]_inst_i_13_n_0 ));
  MUXF7 \segment_OBUF[6]_inst_i_2 
       (.I0(\segment_OBUF[6]_inst_i_6_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_7_n_0 ),
        .O(\segment_OBUF[6]_inst_i_2_n_0 ),
        .S(sel0[2]));
  MUXF7 \segment_OBUF[6]_inst_i_3 
       (.I0(\segment_OBUF[6]_inst_i_8_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_9_n_0 ),
        .O(\segment_OBUF[6]_inst_i_3_n_0 ),
        .S(sel0[2]));
  MUXF7 \segment_OBUF[6]_inst_i_4 
       (.I0(\segment_OBUF[6]_inst_i_10_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_11_n_0 ),
        .O(\segment_OBUF[6]_inst_i_4_n_0 ),
        .S(sel0[2]));
  MUXF7 \segment_OBUF[6]_inst_i_5 
       (.I0(\segment_OBUF[6]_inst_i_12_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_13_n_0 ),
        .O(\segment_OBUF[6]_inst_i_5_n_0 ),
        .S(sel0[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \segment_OBUF[6]_inst_i_6 
       (.I0(dataIn_IBUF[15]),
        .I1(dataIn_IBUF[11]),
        .I2(sel0[1]),
        .I3(dataIn_IBUF[7]),
        .I4(sel0[0]),
        .I5(dataIn_IBUF[3]),
        .O(\segment_OBUF[6]_inst_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \segment_OBUF[6]_inst_i_7 
       (.I0(dataIn_IBUF[31]),
        .I1(dataIn_IBUF[27]),
        .I2(sel0[1]),
        .I3(dataIn_IBUF[23]),
        .I4(sel0[0]),
        .I5(dataIn_IBUF[19]),
        .O(\segment_OBUF[6]_inst_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \segment_OBUF[6]_inst_i_8 
       (.I0(dataIn_IBUF[12]),
        .I1(dataIn_IBUF[8]),
        .I2(sel0[1]),
        .I3(dataIn_IBUF[4]),
        .I4(sel0[0]),
        .I5(dataIn_IBUF[0]),
        .O(\segment_OBUF[6]_inst_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \segment_OBUF[6]_inst_i_9 
       (.I0(dataIn_IBUF[28]),
        .I1(dataIn_IBUF[24]),
        .I2(sel0[1]),
        .I3(dataIn_IBUF[20]),
        .I4(sel0[0]),
        .I5(dataIn_IBUF[16]),
        .O(\segment_OBUF[6]_inst_i_9_n_0 ));
  OBUF \segment_OBUF[7]_inst 
       (.I(segment_OBUF[7]),
        .O(segment[7]));
  MUXF7 \segment_OBUF[7]_inst_i_1 
       (.I0(\segment_OBUF[7]_inst_i_2_n_0 ),
        .I1(\segment_OBUF[7]_inst_i_3_n_0 ),
        .O(segment_OBUF[7]),
        .S(sel0[2]));
  LUT6 #(
    .INIT(64'h505F3030505F3F3F)) 
    \segment_OBUF[7]_inst_i_2 
       (.I0(digitPoint_IBUF[3]),
        .I1(digitPoint_IBUF[2]),
        .I2(sel0[1]),
        .I3(digitPoint_IBUF[1]),
        .I4(sel0[0]),
        .I5(digitPoint_IBUF[0]),
        .O(\segment_OBUF[7]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h505F3030505F3F3F)) 
    \segment_OBUF[7]_inst_i_3 
       (.I0(digitPoint_IBUF[7]),
        .I1(digitPoint_IBUF[6]),
        .I2(sel0[1]),
        .I3(digitPoint_IBUF[5]),
        .I4(sel0[0]),
        .I5(digitPoint_IBUF[4]),
        .O(\segment_OBUF[7]_inst_i_3_n_0 ));
endmodule
