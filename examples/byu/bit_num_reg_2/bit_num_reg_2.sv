// Logic between bit_num_reg_2 and the other flipflops
// Part of the tx netlist used to check for equivalence in the bit_num_reg_2 flipflop
`timescale 1 ps / 1 ps

(* ECO_CHECKSUM = "eda8c5a9" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module bit_num_reg_2(
  input Reset,
  input clk,
  input FSM_onehot_cs_1__i_1_n_0,
  input FSM_onehot_cs_2__i_1_n_0,
  input bitNum_0__i_1_n_0,
  input bitNum_1__i_1_n_0,
  input cycles_0__i_1_n_0,
  input cycles_reg_0__i_2_n_4,
  input cycles_reg_0__i_2_n_5,
  input cycles_reg_0__i_2_n_6,
  input cycles_reg_0__i_2_n_7,
  input cycles_reg_12__i_1_n_7,
  input cycles_reg_4__i_1_n_4,
  input cycles_reg_4__i_1_n_5,
  input cycles_reg_4__i_1_n_6,
  input cycles_reg_4__i_1_n_7,
  input cycles_reg_8__i_1_n_4,
  input cycles_reg_8__i_1_n_5,
  input cycles_reg_8__i_1_n_6,
  input cycles_reg_8__i_1_n_7,
  output [2:0]bitNum_reg_n_0_
  );

  wire \<const0> ;
  wire \<const1> ;
  wire \FSM_onehot_cs[5]_i_2_n_0 ;
  wire \FSM_onehot_cs[5]_i_3_n_0 ;
  wire \FSM_onehot_cs[5]_i_4_n_0 ;
  wire Reset_IBUF;
  wire \bitNum[2]_i_1_n_0 ;
  wire \bitNum[2]_i_2_n_0 ;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire [12:0]cycles_reg;
  wire dataBit;
  wire startBit;

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
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs_1__i_1_n_0 ),
        .Q(startBit),
        .R(Reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs_2__i_1_n_0  ),
        .Q(dataBit),
        .R(Reset_IBUF));
  GND GND
       (.G(\<const0> ));
  IBUF Reset_IBUF_inst
       (.I(Reset),
        .O(Reset_IBUF));
  VCC VCC
       (.P(\<const1> ));
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
        .D(\bitNum_0__i_1_n_0  ),
        .Q(bitNum_reg_n_0_[0]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \bitNum_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\bitNum_1__i_1_n_0 ),
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
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg_0__i_2_n_7 ),
        .Q(cycles_reg[0]),
        .R(\cycles_0__i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg_8__i_1_n_5 ),
        .Q(cycles_reg[10]),
        .R(\cycles_0__i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg_8__i_1_n_4 ),
        .Q(cycles_reg[11]),
        .R(\cycles_0__i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg_12__i_1_n_7 ),
        .Q(cycles_reg[12]),
        .R(\cycles_0__i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg_0__i_2_n_6 ),
        .Q(cycles_reg[1]),
        .R(\cycles_0__i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg_0__i_2_n_5 ),
        .Q(cycles_reg[2]),
        .R(\cycles_0__i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg_0__i_2_n_4 ),
        .Q(cycles_reg[3]),
        .R(\cycles_0__i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg_4__i_1_n_7 ),
        .Q(cycles_reg[4]),
        .R(\cycles_0__i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg_4__i_1_n_6 ),
        .Q(cycles_reg[5]),
        .R(\cycles_0__i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg_4__i_1_n_5 ),
        .Q(cycles_reg[6]),
        .R(\cycles_0__i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg_4__i_1_n_4 ),
        .Q(cycles_reg[7]),
        .R(\cycles_0__i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg_8__i_1_n_7 ),
        .Q(cycles_reg[8]),
        .R(\cycles_0__i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cycles_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\cycles_reg_8__i_1_n_6 ),
        .Q(cycles_reg[9]),
        .R(\cycles_0__i_1_n_0 ));
endmodule
