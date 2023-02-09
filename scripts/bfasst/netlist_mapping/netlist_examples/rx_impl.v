// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Mon Aug  8 17:51:50 2022
// Host        : CCL3 running 64-bit Ubuntu 20.04.4 LTS
// Command     : write_verilog -force -file /home/palm9727/bfasst/build/xilinx_conformal_impl/byu/rx/rx_impl.v
// Design      : rx
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7a200tsbg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* ECO_CHECKSUM = "8a1112f9" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module rx
   (Receive,
    Received,
    Reset,
    Sin,
    clk,
    parityErr,
    Dout);
  output Receive;
  input Received;
  input Reset;
  input Sin;
  input clk;
  output parityErr;
  output [7:0]Dout;

  wire \<const0> ;
  wire \<const1> ;
  wire [7:0]Dout;
  wire [7:0]Dout_OBUF;
  wire \FSM_onehot_cs[0]_i_1_n_0 ;
  wire \FSM_onehot_cs[1]_i_1_n_0 ;
  wire \FSM_onehot_cs[2]_i_1_n_0 ;
  wire \FSM_onehot_cs[3]_i_1_n_0 ;
  wire \FSM_onehot_cs[3]_i_2_n_0 ;
  wire \FSM_onehot_cs[4]_i_1_n_0 ;
  wire \FSM_onehot_cs[4]_i_2_n_0 ;
  wire \FSM_onehot_cs[4]_i_3_n_0 ;
  wire \FSM_onehot_cs[4]_i_4_n_0 ;
  wire [4:1]FSM_onehot_cs_reg_n_0_;
  wire Receive;
  wire Receive_OBUF;
  wire Received;
  wire Received_IBUF;
  wire Reset;
  wire Reset_IBUF;
  wire Sin;
  wire Sin_IBUF;
  wire bitNum0;
  wire [3:0]bitNum_reg;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire clrBit3_out;
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
  wire [3:0]p_0_in;
  wire parityErr;
  wire parityErr_OBUF;
  wire parityErr_OBUF_inst_i_2_n_0;
  wire [8:8]register;
  wire \register[8]_i_3_n_0 ;
  wire \register_reg[0]_lopt_replica_1 ;
  wire \register_reg[1]_lopt_replica_1 ;
  wire \register_reg[2]_lopt_replica_1 ;
  wire \register_reg[3]_lopt_replica_1 ;
  wire \register_reg[4]_lopt_replica_1 ;
  wire \register_reg[5]_lopt_replica_1 ;
  wire \register_reg[6]_lopt_replica_1 ;
  wire \register_reg[7]_lopt_replica_1 ;
  wire sampleBit1_out;
  wire [3:0]\NLW_cycles_reg[0]_i_2_CO_UNCONNECTED ;
  wire [3:0]\NLW_cycles_reg[4]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_cycles_reg[8]_i_1_CO_UNCONNECTED ;

  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \Dout_OBUF[0]_inst 
       (.I(\register_reg[0]_lopt_replica_1 ),
        .O(Dout[0]));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \Dout_OBUF[1]_inst 
       (.I(\register_reg[1]_lopt_replica_1 ),
        .O(Dout[1]));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \Dout_OBUF[2]_inst 
       (.I(\register_reg[2]_lopt_replica_1 ),
        .O(Dout[2]));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \Dout_OBUF[3]_inst 
       (.I(\register_reg[3]_lopt_replica_1 ),
        .O(Dout[3]));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \Dout_OBUF[4]_inst 
       (.I(\register_reg[4]_lopt_replica_1 ),
        .O(Dout[4]));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \Dout_OBUF[5]_inst 
       (.I(\register_reg[5]_lopt_replica_1 ),
        .O(Dout[5]));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \Dout_OBUF[6]_inst 
       (.I(\register_reg[6]_lopt_replica_1 ),
        .O(Dout[6]));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \Dout_OBUF[7]_inst 
       (.I(\register_reg[7]_lopt_replica_1 ),
        .O(Dout[7]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \FSM_onehot_cs[0]_i_1 
       (.I0(clrTimer),
        .I1(Sin_IBUF),
        .I2(FSM_onehot_cs_reg_n_0_[4]),
        .I3(Received_IBUF),
        .O(\FSM_onehot_cs[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF4F4F4F4F4F4F444)) 
    \FSM_onehot_cs[1]_i_1 
       (.I0(Sin_IBUF),
        .I1(clrTimer),
        .I2(FSM_onehot_cs_reg_n_0_[1]),
        .I3(\FSM_onehot_cs[4]_i_2_n_0 ),
        .I4(\FSM_onehot_cs[4]_i_3_n_0 ),
        .I5(\FSM_onehot_cs[4]_i_4_n_0 ),
        .O(\FSM_onehot_cs[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCECCCCCCCA)) 
    \FSM_onehot_cs[2]_i_1 
       (.I0(FSM_onehot_cs_reg_n_0_[1]),
        .I1(FSM_onehot_cs_reg_n_0_[2]),
        .I2(\FSM_onehot_cs[4]_i_4_n_0 ),
        .I3(\FSM_onehot_cs[4]_i_3_n_0 ),
        .I4(\FSM_onehot_cs[4]_i_2_n_0 ),
        .I5(\FSM_onehot_cs[3]_i_2_n_0 ),
        .O(\FSM_onehot_cs[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0F0F0F0F0F0F044)) 
    \FSM_onehot_cs[3]_i_1 
       (.I0(\FSM_onehot_cs[3]_i_2_n_0 ),
        .I1(FSM_onehot_cs_reg_n_0_[2]),
        .I2(FSM_onehot_cs_reg_n_0_[3]),
        .I3(\FSM_onehot_cs[4]_i_2_n_0 ),
        .I4(\FSM_onehot_cs[4]_i_3_n_0 ),
        .I5(\FSM_onehot_cs[4]_i_4_n_0 ),
        .O(\FSM_onehot_cs[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hFFEF)) 
    \FSM_onehot_cs[3]_i_2 
       (.I0(bitNum_reg[1]),
        .I1(bitNum_reg[0]),
        .I2(bitNum_reg[3]),
        .I3(bitNum_reg[2]),
        .O(\FSM_onehot_cs[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0100FFFF01000100)) 
    \FSM_onehot_cs[4]_i_1 
       (.I0(\FSM_onehot_cs[4]_i_2_n_0 ),
        .I1(\FSM_onehot_cs[4]_i_3_n_0 ),
        .I2(\FSM_onehot_cs[4]_i_4_n_0 ),
        .I3(FSM_onehot_cs_reg_n_0_[3]),
        .I4(Received_IBUF),
        .I5(FSM_onehot_cs_reg_n_0_[4]),
        .O(\FSM_onehot_cs[4]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \FSM_onehot_cs[4]_i_2 
       (.I0(cycles_reg[10]),
        .I1(cycles_reg[9]),
        .I2(cycles_reg[12]),
        .I3(cycles_reg[11]),
        .O(\FSM_onehot_cs[4]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \FSM_onehot_cs[4]_i_3 
       (.I0(cycles_reg[4]),
        .I1(cycles_reg[2]),
        .I2(cycles_reg[6]),
        .I3(cycles_reg[5]),
        .O(\FSM_onehot_cs[4]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEFF)) 
    \FSM_onehot_cs[4]_i_4 
       (.I0(cycles_reg[0]),
        .I1(cycles_reg[7]),
        .I2(cycles_reg[8]),
        .I3(cycles_reg[3]),
        .I4(cycles_reg[1]),
        .O(\FSM_onehot_cs[4]_i_4_n_0 ));
  (* FSM_ENCODED_STATES = "START:00010,BITS:00100,STOP:01000,ACK:10000,IDLE:00001" *) 
  FDSE #(
    .INIT(1'b1)) 
    \FSM_onehot_cs_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs[0]_i_1_n_0 ),
        .Q(clrTimer),
        .S(Reset_IBUF));
  (* FSM_ENCODED_STATES = "START:00010,BITS:00100,STOP:01000,ACK:10000,IDLE:00001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs[1]_i_1_n_0 ),
        .Q(FSM_onehot_cs_reg_n_0_[1]),
        .R(Reset_IBUF));
  (* FSM_ENCODED_STATES = "START:00010,BITS:00100,STOP:01000,ACK:10000,IDLE:00001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs[2]_i_1_n_0 ),
        .Q(FSM_onehot_cs_reg_n_0_[2]),
        .R(Reset_IBUF));
  (* FSM_ENCODED_STATES = "START:00010,BITS:00100,STOP:01000,ACK:10000,IDLE:00001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs[3]_i_1_n_0 ),
        .Q(FSM_onehot_cs_reg_n_0_[3]),
        .R(Reset_IBUF));
  (* FSM_ENCODED_STATES = "START:00010,BITS:00100,STOP:01000,ACK:10000,IDLE:00001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs[4]_i_1_n_0 ),
        .Q(FSM_onehot_cs_reg_n_0_[4]),
        .R(Reset_IBUF));
  GND GND
       (.G(\<const0> ));
  OBUF Receive_OBUF_inst
       (.I(Receive_OBUF),
        .O(Receive));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h2)) 
    Receive_OBUF_inst_i_1
       (.I0(FSM_onehot_cs_reg_n_0_[4]),
        .I1(Reset_IBUF),
        .O(Receive_OBUF));
  IBUF Received_IBUF_inst
       (.I(Received),
        .O(Received_IBUF));
  IBUF Reset_IBUF_inst
       (.I(Reset),
        .O(Reset_IBUF));
  IBUF Sin_IBUF_inst
       (.I(Sin),
        .O(Sin_IBUF));
  VCC VCC
       (.P(\<const1> ));
  LUT1 #(
    .INIT(2'h1)) 
    \bitNum[0]_i_1 
       (.I0(bitNum_reg[0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \bitNum[1]_i_1 
       (.I0(bitNum_reg[0]),
        .I1(bitNum_reg[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \bitNum[2]_i_1 
       (.I0(bitNum_reg[1]),
        .I1(bitNum_reg[0]),
        .I2(bitNum_reg[2]),
        .O(p_0_in[2]));
  LUT6 #(
    .INIT(64'h0000000000000008)) 
    \bitNum[3]_i_1 
       (.I0(\FSM_onehot_cs[3]_i_2_n_0 ),
        .I1(FSM_onehot_cs_reg_n_0_[2]),
        .I2(Reset_IBUF),
        .I3(\FSM_onehot_cs[4]_i_4_n_0 ),
        .I4(\FSM_onehot_cs[4]_i_3_n_0 ),
        .I5(\FSM_onehot_cs[4]_i_2_n_0 ),
        .O(bitNum0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h6CCC)) 
    \bitNum[3]_i_2 
       (.I0(bitNum_reg[2]),
        .I1(bitNum_reg[3]),
        .I2(bitNum_reg[0]),
        .I3(bitNum_reg[1]),
        .O(p_0_in[3]));
  FDRE #(
    .INIT(1'b0)) 
    \bitNum_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(bitNum0),
        .D(p_0_in[0]),
        .Q(bitNum_reg[0]),
        .R(clrBit3_out));
  FDRE #(
    .INIT(1'b0)) 
    \bitNum_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(bitNum0),
        .D(p_0_in[1]),
        .Q(bitNum_reg[1]),
        .R(clrBit3_out));
  FDRE #(
    .INIT(1'b0)) 
    \bitNum_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(bitNum0),
        .D(p_0_in[2]),
        .Q(bitNum_reg[2]),
        .R(clrBit3_out));
  FDRE #(
    .INIT(1'b0)) 
    \bitNum_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(bitNum0),
        .D(p_0_in[3]),
        .Q(bitNum_reg[3]),
        .R(clrBit3_out));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  LUT5 #(
    .INIT(32'h4444444F)) 
    \cycles[0]_i_1 
       (.I0(Reset_IBUF),
        .I1(clrTimer),
        .I2(\FSM_onehot_cs[4]_i_4_n_0 ),
        .I3(\FSM_onehot_cs[4]_i_3_n_0 ),
        .I4(\FSM_onehot_cs[4]_i_2_n_0 ),
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
  OBUF parityErr_OBUF_inst
       (.I(parityErr_OBUF),
        .O(parityErr));
  LUT6 #(
    .INIT(64'h9669699669969669)) 
    parityErr_OBUF_inst_i_1
       (.I0(register),
        .I1(parityErr_OBUF_inst_i_2_n_0),
        .I2(Dout_OBUF[6]),
        .I3(Dout_OBUF[7]),
        .I4(Dout_OBUF[4]),
        .I5(Dout_OBUF[5]),
        .O(parityErr_OBUF));
  LUT4 #(
    .INIT(16'h6996)) 
    parityErr_OBUF_inst_i_2
       (.I0(Dout_OBUF[2]),
        .I1(Dout_OBUF[3]),
        .I2(Dout_OBUF[0]),
        .I3(Dout_OBUF[1]),
        .O(parityErr_OBUF_inst_i_2_n_0));
  LUT5 #(
    .INIT(32'h00000004)) 
    \register[8]_i_1 
       (.I0(Reset_IBUF),
        .I1(FSM_onehot_cs_reg_n_0_[1]),
        .I2(\FSM_onehot_cs[4]_i_4_n_0 ),
        .I3(\FSM_onehot_cs[4]_i_3_n_0 ),
        .I4(\FSM_onehot_cs[4]_i_2_n_0 ),
        .O(clrBit3_out));
  LUT6 #(
    .INIT(64'h0010000000000000)) 
    \register[8]_i_2 
       (.I0(\FSM_onehot_cs[4]_i_4_n_0 ),
        .I1(cycles_reg[4]),
        .I2(cycles_reg[2]),
        .I3(cycles_reg[6]),
        .I4(cycles_reg[5]),
        .I5(\register[8]_i_3_n_0 ),
        .O(sampleBit1_out));
  LUT6 #(
    .INIT(64'h0000002000000000)) 
    \register[8]_i_3 
       (.I0(cycles_reg[11]),
        .I1(cycles_reg[12]),
        .I2(cycles_reg[9]),
        .I3(cycles_reg[10]),
        .I4(Reset_IBUF),
        .I5(FSM_onehot_cs_reg_n_0_[2]),
        .O(\register[8]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(Dout_OBUF[1]),
        .Q(Dout_OBUF[0]),
        .R(clrBit3_out));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[0]_lopt_replica 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(Dout_OBUF[1]),
        .Q(\register_reg[0]_lopt_replica_1 ),
        .R(clrBit3_out));
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(Dout_OBUF[2]),
        .Q(Dout_OBUF[1]),
        .R(clrBit3_out));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[1]_lopt_replica 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(Dout_OBUF[2]),
        .Q(\register_reg[1]_lopt_replica_1 ),
        .R(clrBit3_out));
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(Dout_OBUF[3]),
        .Q(Dout_OBUF[2]),
        .R(clrBit3_out));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[2]_lopt_replica 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(Dout_OBUF[3]),
        .Q(\register_reg[2]_lopt_replica_1 ),
        .R(clrBit3_out));
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(Dout_OBUF[4]),
        .Q(Dout_OBUF[3]),
        .R(clrBit3_out));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[3]_lopt_replica 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(Dout_OBUF[4]),
        .Q(\register_reg[3]_lopt_replica_1 ),
        .R(clrBit3_out));
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(Dout_OBUF[5]),
        .Q(Dout_OBUF[4]),
        .R(clrBit3_out));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[4]_lopt_replica 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(Dout_OBUF[5]),
        .Q(\register_reg[4]_lopt_replica_1 ),
        .R(clrBit3_out));
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(Dout_OBUF[6]),
        .Q(Dout_OBUF[5]),
        .R(clrBit3_out));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[5]_lopt_replica 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(Dout_OBUF[6]),
        .Q(\register_reg[5]_lopt_replica_1 ),
        .R(clrBit3_out));
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(Dout_OBUF[7]),
        .Q(Dout_OBUF[6]),
        .R(clrBit3_out));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[6]_lopt_replica 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(Dout_OBUF[7]),
        .Q(\register_reg[6]_lopt_replica_1 ),
        .R(clrBit3_out));
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(register),
        .Q(Dout_OBUF[7]),
        .R(clrBit3_out));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[7]_lopt_replica 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(register),
        .Q(\register_reg[7]_lopt_replica_1 ),
        .R(clrBit3_out));
  FDRE #(
    .INIT(1'b0)) 
    \register_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(sampleBit1_out),
        .D(Sin_IBUF),
        .Q(register),
        .R(clrBit3_out));
endmodule
