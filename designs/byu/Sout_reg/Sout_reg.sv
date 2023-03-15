// Logic between Sout_reg and the other flipflops
// Part of the tx netlist used to check for equivalence in the Sout_reg flipflop
`timescale 1 ps / 1 ps

(* ECO_CHECKSUM = "eda8c5a9" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module Sout_reg(
  input Reset,
  input clk,
  input [7:0]Din,
  input FSM_onehot_cs_1__i_1_n_0,
  input FSM_onehot_cs_2__i_1_n_0,
  input FSM_onehot_cs_3__i_1_n_0,
  input bitNum_0__i_1_n_0,
  input bitNum_1__i_1_n_0,
  input bitNum_2__i_1_n_0,
  output Sout
  );

  wire \<const0> ;
  wire \<const1> ;
  wire [7:0]Din_IBUF;
  wire Reset_IBUF;
  wire Sout1_out;
  wire Sout_OBUF;
  wire Sout_i_3_n_0;
  wire Sout_i_4_n_0;
  wire Sout_i_5_n_0;
  wire Sout_i_6_n_0;
  wire Sout_reg_i_2_n_0;
  wire [2:0]bitNum_reg_n_0_;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire dataBit;
  wire parityBit;
  wire startBit;

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
        .D(\FSM_onehot_cs_2__i_1_n_0 ),
        .Q(dataBit),
        .R(Reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs_3__i_1_n_0 ),
        .Q(parityBit),
        .R(Reset_IBUF));
  GND GND
       (.G(\<const0> ));
  IBUF Reset_IBUF_inst
       (.I(Reset),
        .O(Reset_IBUF));
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
  FDRE #(
    .INIT(1'b0)) 
    \bitNum_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\bitNum_0__i_1_n_0 ),
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
        .D(\bitNum_2__i_1_n_0 ),
        .Q(bitNum_reg_n_0_[2]),
        .R(\<const0> ));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
endmodule
