// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Mon Aug  8 18:14:25 2022
// Host        : CCL3 running 64-bit Ubuntu 20.04.4 LTS
// Command     : write_verilog -force -file /home/palm9727/bfasst/build/xilinx_conformal_impl/byu/tx/tx_impl.v
// Design      : tx
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7a200tsbg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* ECO_CHECKSUM = "eda8c5a9" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module tx
   (Reset,
    Send,
    Sent,
    Sout,
    clk,
    Din);
  input Reset;
  input Send;
  output Sent;
  output Sout;
  input clk;
  input [7:0]Din;

  wire \<const0> ;
  wire \<const1> ;
  wire [7:0]Din;
  wire [7:0]Din_IBUF;
  wire \FSM_onehot_cs[0]_i_1_n_0 ;
  wire \FSM_onehot_cs[1]_i_1_n_0 ;
  wire \FSM_onehot_cs[2]_i_1_n_0 ;
  wire \FSM_onehot_cs[3]_i_1_n_0 ;
  wire \FSM_onehot_cs[4]_i_1_n_0 ;
  wire \FSM_onehot_cs[5]_i_1_n_0 ;
  wire \FSM_onehot_cs[5]_i_2_n_0 ;
  wire \FSM_onehot_cs[5]_i_3_n_0 ;
  wire \FSM_onehot_cs[5]_i_4_n_0 ;
  wire [5:4]FSM_onehot_cs_reg_n_0_;
  wire Reset;
  wire Reset_IBUF;
  wire Send;
  wire Send_IBUF;
  wire Sent;
  wire Sent_OBUF;
  wire Sout;
  wire Sout1_out;
  wire Sout_OBUF;
  wire Sout_i_3_n_0;
  wire Sout_i_4_n_0;
  wire Sout_i_5_n_0;
  wire Sout_i_6_n_0;
  wire Sout_reg_i_2_n_0;
  wire \bitNum[0]_i_1_n_0 ;
  wire \bitNum[0]_i_2_n_0 ;
  wire \bitNum[1]_i_1_n_0 ;
  wire \bitNum[1]_i_2_n_0 ;
  wire \bitNum[1]_i_3_n_0 ;
  wire \bitNum[2]_i_1_n_0 ;
  wire \bitNum[2]_i_2_n_0 ;
  wire [2:0]bitNum_reg_n_0_;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire clrTimer;
  wire \cycles[0]_i_1_n_0 ;
  wire \cycles[0]_i_3_n_0 ;
  wire [12:0]cycles_reg;
  wire \cycles_reg[0]_i_2_n_0 ;
  wire \cycles_reg[0]_i_2_n_4 ;
  wire \cycles_reg[0]_i_2_n_5 ;
  wire \cycles_reg[0]_i_2_n_6 ;
  wire \cycles_reg[0]_i_2_n_7 ;
  wire \cycles_reg[12]_i_1_n_7 ;
  wire \cycles_reg[4]_i_1_n_0 ;
  wire \cycles_reg[4]_i_1_n_4 ;
  wire \cycles_reg[4]_i_1_n_5 ;
  wire \cycles_reg[4]_i_1_n_6 ;
  wire \cycles_reg[4]_i_1_n_7 ;
  wire \cycles_reg[8]_i_1_n_0 ;
  wire \cycles_reg[8]_i_1_n_4 ;
  wire \cycles_reg[8]_i_1_n_5 ;
  wire \cycles_reg[8]_i_1_n_6 ;
  wire \cycles_reg[8]_i_1_n_7 ;
  wire dataBit;
  wire parityBit;
  wire startBit;
  wire [3:0]\NLW_cycles_reg[0]_i_2_CO_UNCONNECTED ;
  wire [3:0]\NLW_cycles_reg[4]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_cycles_reg[8]_i_1_CO_UNCONNECTED ;

  IBUF \Din_IBUF[0]_inst 
       (.I(Din[0]),
        .O(Din_IBUF[0]));
  IBUF \Din_IBUF[1]_inst 
       (.I(Din[1]),
        .O(Din_IBUF[1]));
  IBUF \Din_IBUF[2]_inst 
       (.I(Din[2]),
        .O(Din_IBUF[2]));
  IBUF \Din_IBUF[3]_inst 
       (.I(Din[3]),
        .O(Din_IBUF[3]));
  IBUF \Din_IBUF[4]_inst 
       (.I(Din[4]),
        .O(Din_IBUF[4]));
  IBUF \Din_IBUF[5]_inst 
       (.I(Din[5]),
        .O(Din_IBUF[5]));
  IBUF \Din_IBUF[6]_inst 
       (.I(Din[6]),
        .O(Din_IBUF[6]));
  IBUF \Din_IBUF[7]_inst 
       (.I(Din[7]),
        .O(Din_IBUF[7]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \FSM_onehot_cs[0]_i_1 
       (.I0(FSM_onehot_cs_reg_n_0_[5]),
        .I1(clrTimer),
        .I2(Send_IBUF),
        .O(\FSM_onehot_cs[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hF444)) 
    \FSM_onehot_cs[1]_i_1 
       (.I0(\FSM_onehot_cs[5]_i_2_n_0 ),
        .I1(startBit),
        .I2(Send_IBUF),
        .I3(clrTimer),
        .O(\FSM_onehot_cs[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFF007F00FF00)) 
    \FSM_onehot_cs[2]_i_1 
       (.I0(bitNum_reg_n_0_[2]),
        .I1(bitNum_reg_n_0_[1]),
        .I2(bitNum_reg_n_0_[0]),
        .I3(dataBit),
        .I4(\FSM_onehot_cs[5]_i_2_n_0 ),
        .I5(startBit),
        .O(\FSM_onehot_cs[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE222222222222222)) 
    \FSM_onehot_cs[3]_i_1 
       (.I0(parityBit),
        .I1(\FSM_onehot_cs[5]_i_2_n_0 ),
        .I2(bitNum_reg_n_0_[2]),
        .I3(bitNum_reg_n_0_[1]),
        .I4(bitNum_reg_n_0_[0]),
        .I5(dataBit),
        .O(\FSM_onehot_cs[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \FSM_onehot_cs[4]_i_1 
       (.I0(parityBit),
        .I1(\FSM_onehot_cs[5]_i_2_n_0 ),
        .I2(FSM_onehot_cs_reg_n_0_[4]),
        .O(\FSM_onehot_cs[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \FSM_onehot_cs[5]_i_1 
       (.I0(Send_IBUF),
        .I1(FSM_onehot_cs_reg_n_0_[5]),
        .I2(\FSM_onehot_cs[5]_i_2_n_0 ),
        .I3(FSM_onehot_cs_reg_n_0_[4]),
        .O(\FSM_onehot_cs[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \FSM_onehot_cs[5]_i_2 
       (.I0(\FSM_onehot_cs[5]_i_3_n_0 ),
        .I1(\FSM_onehot_cs[5]_i_4_n_0 ),
        .I2(cycles_reg[3]),
        .I3(cycles_reg[10]),
        .I4(cycles_reg[6]),
        .O(\FSM_onehot_cs[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000100)) 
    \FSM_onehot_cs[5]_i_3 
       (.I0(cycles_reg[9]),
        .I1(cycles_reg[8]),
        .I2(cycles_reg[1]),
        .I3(cycles_reg[12]),
        .I4(cycles_reg[0]),
        .I5(cycles_reg[7]),
        .O(\FSM_onehot_cs[5]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFFEF)) 
    \FSM_onehot_cs[5]_i_4 
       (.I0(cycles_reg[2]),
        .I1(cycles_reg[11]),
        .I2(cycles_reg[4]),
        .I3(cycles_reg[5]),
        .O(\FSM_onehot_cs[5]_i_4_n_0 ));
  (* FSM_ENCODED_STATES = "START:000010,BITS:000100,PAR:001000,STOP:010000,ACK:100000,IDLE:000001" *) 
  FDSE #(
    .INIT(1'b1)) 
    \FSM_onehot_cs_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs[0]_i_1_n_0 ),
        .Q(clrTimer),
        .S(Reset_IBUF));
  (* FSM_ENCODED_STATES = "START:000010,BITS:000100,PAR:001000,STOP:010000,ACK:100000,IDLE:000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs[1]_i_1_n_0 ),
        .Q(startBit),
        .R(Reset_IBUF));
  (* FSM_ENCODED_STATES = "START:000010,BITS:000100,PAR:001000,STOP:010000,ACK:100000,IDLE:000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs[2]_i_1_n_0 ),
        .Q(dataBit),
        .R(Reset_IBUF));
  (* FSM_ENCODED_STATES = "START:000010,BITS:000100,PAR:001000,STOP:010000,ACK:100000,IDLE:000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs[3]_i_1_n_0 ),
        .Q(parityBit),
        .R(Reset_IBUF));
  (* FSM_ENCODED_STATES = "START:000010,BITS:000100,PAR:001000,STOP:010000,ACK:100000,IDLE:000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs[4]_i_1_n_0 ),
        .Q(FSM_onehot_cs_reg_n_0_[4]),
        .R(Reset_IBUF));
  (* FSM_ENCODED_STATES = "START:000010,BITS:000100,PAR:001000,STOP:010000,ACK:100000,IDLE:000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs[5]_i_1_n_0 ),
        .Q(FSM_onehot_cs_reg_n_0_[5]),
        .R(Reset_IBUF));
  GND GND
       (.G(\<const0> ));
  IBUF Reset_IBUF_inst
       (.I(Reset),
        .O(Reset_IBUF));
  IBUF Send_IBUF_inst
       (.I(Send),
        .O(Send_IBUF));
  OBUF Sent_OBUF_inst
       (.I(Sent_OBUF),
        .O(Sent));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h2)) 
    Sent_OBUF_inst_i_1
       (.I0(FSM_onehot_cs_reg_n_0_[5]),
        .I1(Reset_IBUF),
        .O(Sent_OBUF));
  OBUF Sout_OBUF_inst
       (.I(Sout_OBUF),
        .O(Sout));
  LUT6 #(
    .INIT(64'hFFFF0000FFFF8BBB)) 
    Sout_i_1
       (.I0(Sout_reg_i_2_n_0),
        .I1(dataBit),
        .I2(Sout_i_3_n_0),
        .I3(parityBit),
        .I4(Reset_IBUF),
        .I5(startBit),
        .O(Sout1_out));
  LUT5 #(
    .INIT(32'h96696996)) 
    Sout_i_3
       (.I0(Din_IBUF[2]),
        .I1(Din_IBUF[3]),
        .I2(Din_IBUF[0]),
        .I3(Din_IBUF[1]),
        .I4(Sout_i_6_n_0),
        .O(Sout_i_3_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    Sout_i_4
       (.I0(Din_IBUF[3]),
        .I1(Din_IBUF[2]),
        .I2(bitNum_reg_n_0_[1]),
        .I3(Din_IBUF[1]),
        .I4(bitNum_reg_n_0_[0]),
        .I5(Din_IBUF[0]),
        .O(Sout_i_4_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    Sout_i_5
       (.I0(Din_IBUF[7]),
        .I1(Din_IBUF[6]),
        .I2(bitNum_reg_n_0_[1]),
        .I3(Din_IBUF[5]),
        .I4(bitNum_reg_n_0_[0]),
        .I5(Din_IBUF[4]),
        .O(Sout_i_5_n_0));
  LUT4 #(
    .INIT(16'h6996)) 
    Sout_i_6
       (.I0(Din_IBUF[5]),
        .I1(Din_IBUF[4]),
        .I2(Din_IBUF[7]),
        .I3(Din_IBUF[6]),
        .O(Sout_i_6_n_0));
  FDRE #(
    .INIT(1'b0)) 
    Sout_reg
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(Sout1_out),
        .Q(Sout_OBUF),
        .R(\<const0> ));
  MUXF7 Sout_reg_i_2
       (.I0(Sout_i_4_n_0),
        .I1(Sout_i_5_n_0),
        .O(Sout_reg_i_2_n_0),
        .S(bitNum_reg_n_0_[2]));
  VCC VCC
       (.P(\<const1> ));
  LUT6 #(
    .INIT(64'hAAAA006AAAAAAAAA)) 
    \bitNum[0]_i_1 
       (.I0(bitNum_reg_n_0_[0]),
        .I1(\bitNum[0]_i_2_n_0 ),
        .I2(dataBit),
        .I3(startBit),
        .I4(Reset_IBUF),
        .I5(\FSM_onehot_cs[5]_i_2_n_0 ),
        .O(\bitNum[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \bitNum[0]_i_2 
       (.I0(bitNum_reg_n_0_[0]),
        .I1(bitNum_reg_n_0_[1]),
        .I2(bitNum_reg_n_0_[2]),
        .O(\bitNum[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000E5F0F0F0F0F0)) 
    \bitNum[1]_i_1 
       (.I0(\bitNum[1]_i_2_n_0 ),
        .I1(bitNum_reg_n_0_[2]),
        .I2(bitNum_reg_n_0_[1]),
        .I3(bitNum_reg_n_0_[0]),
        .I4(\bitNum[1]_i_3_n_0 ),
        .I5(\FSM_onehot_cs[5]_i_2_n_0 ),
        .O(\bitNum[1]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \bitNum[1]_i_2 
       (.I0(Reset_IBUF),
        .I1(dataBit),
        .O(\bitNum[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \bitNum[1]_i_3 
       (.I0(startBit),
        .I1(Reset_IBUF),
        .O(\bitNum[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCCCC00CECCCCCCCC)) 
    \bitNum[2]_i_1 
       (.I0(dataBit),
        .I1(bitNum_reg_n_0_[2]),
        .I2(\bitNum[2]_i_2_n_0 ),
        .I3(startBit),
        .I4(Reset_IBUF),
        .I5(\FSM_onehot_cs[5]_i_2_n_0 ),
        .O(\bitNum[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \bitNum[2]_i_2 
       (.I0(bitNum_reg_n_0_[1]),
        .I1(bitNum_reg_n_0_[0]),
        .O(\bitNum[2]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \bitNum_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\bitNum[0]_i_1_n_0 ),
        .Q(bitNum_reg_n_0_[0]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \bitNum_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\bitNum[1]_i_1_n_0 ),
        .Q(bitNum_reg_n_0_[1]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \bitNum_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\bitNum[2]_i_1_n_0 ),
        .Q(bitNum_reg_n_0_[2]),
        .R(\<const0> ));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  LUT3 #(
    .INIT(8'hF4)) 
    \cycles[0]_i_1 
       (.I0(Reset_IBUF),
        .I1(clrTimer),
        .I2(\FSM_onehot_cs[5]_i_2_n_0 ),
        .O(\cycles[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \cycles[0]_i_3 
       (.I0(cycles_reg[0]),
        .O(\cycles[0]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg[0]_i_2_n_7 ),
        .Q(cycles_reg[0]),
        .R(\cycles[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \cycles_reg[0]_i_2 
       (.CI(\<const0> ),
        .CO({\cycles_reg[0]_i_2_n_0 ,\NLW_cycles_reg[0]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .O({\cycles_reg[0]_i_2_n_4 ,\cycles_reg[0]_i_2_n_5 ,\cycles_reg[0]_i_2_n_6 ,\cycles_reg[0]_i_2_n_7 }),
        .S({cycles_reg[3:1],\cycles[0]_i_3_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg[8]_i_1_n_5 ),
        .Q(cycles_reg[10]),
        .R(\cycles[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg[8]_i_1_n_4 ),
        .Q(cycles_reg[11]),
        .R(\cycles[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg[12]_i_1_n_7 ),
        .Q(cycles_reg[12]),
        .R(\cycles[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \cycles_reg[12]_i_1 
       (.CI(\cycles_reg[8]_i_1_n_0 ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(\cycles_reg[12]_i_1_n_7 ),
        .S({\<const0> ,\<const0> ,\<const0> ,cycles_reg[12]}));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg[0]_i_2_n_6 ),
        .Q(cycles_reg[1]),
        .R(\cycles[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg[0]_i_2_n_5 ),
        .Q(cycles_reg[2]),
        .R(\cycles[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg[0]_i_2_n_4 ),
        .Q(cycles_reg[3]),
        .R(\cycles[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg[4]_i_1_n_7 ),
        .Q(cycles_reg[4]),
        .R(\cycles[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \cycles_reg[4]_i_1 
       (.CI(\cycles_reg[0]_i_2_n_0 ),
        .CO({\cycles_reg[4]_i_1_n_0 ,\NLW_cycles_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\cycles_reg[4]_i_1_n_4 ,\cycles_reg[4]_i_1_n_5 ,\cycles_reg[4]_i_1_n_6 ,\cycles_reg[4]_i_1_n_7 }),
        .S(cycles_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg[4]_i_1_n_6 ),
        .Q(cycles_reg[5]),
        .R(\cycles[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg[4]_i_1_n_5 ),
        .Q(cycles_reg[6]),
        .R(\cycles[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg[4]_i_1_n_4 ),
        .Q(cycles_reg[7]),
        .R(\cycles[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg[8]_i_1_n_7 ),
        .Q(cycles_reg[8]),
        .R(\cycles[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \cycles_reg[8]_i_1 
       (.CI(\cycles_reg[4]_i_1_n_0 ),
        .CO({\cycles_reg[8]_i_1_n_0 ,\NLW_cycles_reg[8]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\cycles_reg[8]_i_1_n_4 ,\cycles_reg[8]_i_1_n_5 ,\cycles_reg[8]_i_1_n_6 ,\cycles_reg[8]_i_1_n_7 }),
        .S(cycles_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg[8]_i_1_n_6 ),
        .Q(cycles_reg[9]),
        .R(\cycles[0]_i_1_n_0 ));
endmodule
