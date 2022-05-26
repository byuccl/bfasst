// Logic between bit_num_reg_1 and the other flipflops
// Part of the tx netlist used to check for equivalence in the bit_num_reg_1 flipflop
`timescale 1 ps / 1 ps

(* ECO_CHECKSUM = "eda8c5a9" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module bit_num_reg_1_single_ff(
  input Reset,
  input clk,
  input startBit,
  input dataBit,
  input bitNum_0__i_1_n_0,
  input bitNum_2__i_1_n_0,
  input [12:0]cycles_reg,
  output [2:0]bitNum_reg_n_0_
  );

  wire \<const0> ;
  wire \<const1> ;
  wire \FSM_onehot_cs[5]_i_2_n_0 ;
  wire \FSM_onehot_cs[5]_i_3_n_0 ;
  wire \FSM_onehot_cs[5]_i_4_n_0 ;
  wire Reset_IBUF;
  wire \bitNum[1]_i_1_n_0 ;
  wire \bitNum[1]_i_2_n_0 ;
  wire \bitNum[1]_i_3_n_0 ;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire \cycles[0]_i_1_n_0 ;
  wire dataBit;
  wire startBit;

  LUT5 #( // G
    .INIT(32'h20000000)) 
    \FSM_onehot_cs[5]_i_2 
       (.I0(\FSM_onehot_cs[5]_i_3_n_0 ),
        .I1(\FSM_onehot_cs[5]_i_4_n_0 ),
        .I2(cycles_reg[3]),
        .I3(cycles_reg[10]),
        .I4(cycles_reg[6]),
        .O(\FSM_onehot_cs[5]_i_2_n_0 ));
  LUT6 #( // G
    .INIT(64'h0000000000000100)) 
    \FSM_onehot_cs[5]_i_3 
       (.I0(cycles_reg[9]),
        .I1(cycles_reg[8]),
        .I2(cycles_reg[1]),
        .I3(cycles_reg[12]),
        .I4(cycles_reg[0]),
        .I5(cycles_reg[7]),
        .O(\FSM_onehot_cs[5]_i_3_n_0 ));
  LUT4 #( // G
    .INIT(16'hFFEF)) 
    \FSM_onehot_cs[5]_i_4 
       (.I0(cycles_reg[2]),
        .I1(cycles_reg[11]),
        .I2(cycles_reg[4]),
        .I3(cycles_reg[5]),
        .O(\FSM_onehot_cs[5]_i_4_n_0 ));
  GND GND // G
       (.G(\<const0> ));
  IBUF Reset_IBUF_inst // G
       (.I(Reset),
        .O(Reset_IBUF));
  VCC VCC // G
       (.P(\<const1> ));
  LUT6 #( // G
    .INIT(64'h0000E5F0F0F0F0F0)) 
    \bitNum[1]_i_1 
       (.I0(\bitNum[1]_i_2_n_0 ),
        .I1(bitNum_reg_n_0_[2]),
        .I2(bitNum_reg_n_0_[1]),
        .I3(bitNum_reg_n_0_[0]),
        .I4(\bitNum[1]_i_3_n_0 ),
        .I5(\FSM_onehot_cs[5]_i_2_n_0 ),
        .O(\bitNum[1]_i_1_n_0 ));
  LUT2 #( // G
    .INIT(4'hB)) 
    \bitNum[1]_i_2 
       (.I0(Reset_IBUF),
        .I1(dataBit),
        .O(\bitNum[1]_i_2_n_0 ));
  LUT2 #( // G
    .INIT(4'h2)) 
    \bitNum[1]_i_3 
       (.I0(startBit),
        .I1(Reset_IBUF),
        .O(\bitNum[1]_i_3_n_0 ));
  FDRE #( // G
    .INIT(1'b0)) 
    \bitNum_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\bitNum_0__i_1_n_0 ),
        .Q(bitNum_reg_n_0_[0]),
        .R(\<const0> ));
  FDRE #( // G
    .INIT(1'b0)) 
    \bitNum_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\bitNum[1]_i_1_n_0 ),
        .Q(bitNum_reg_n_0_[1]),
        .R(\<const0> ));
  FDRE #( // G
    .INIT(1'b0)) 
    \bitNum_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\bitNum_2__i_1_n_0 ),
        .Q(bitNum_reg_n_0_[2]),
        .R(\<const0> ));
  BUFG clk_IBUF_BUFG_inst // G
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst // G
       (.I(clk),
        .O(clk_IBUF));
endmodule
