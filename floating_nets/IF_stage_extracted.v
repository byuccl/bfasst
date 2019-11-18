
module chip (input clk_ibuf, input branch_taken, input \branch_offset_imm_ibuf[0] , output \pc_obuf[6] , output \pc_obuf[7] , output \pc_obuf[5] , output \pc_obuf[4] , output \pc_obuf[0] , output \pc_obuf[3] , output \pc_obuf[2] , output \pc_obuf[1] , input \branch_offset_imm_ibuf[1] , input \branch_offset_imm_ibuf[2] , input \branch_offset_imm_ibuf[3] , input \branch_offset_imm_ibuf[4] , input \branch_offset_imm_ibuf[5] , input instruction_fetch_en, output \instruction_obuf[0] , output \instruction_obuf[1] , output \instruction_obuf[10] , output \instruction_obuf[11] , output \instruction_obuf[12] , output \instruction_obuf[13] , output \instruction_obuf[14] , output \instruction_obuf[15] , output \instruction_obuf[2] , output \instruction_obuf[3] , output \instruction_obuf[4] , output \instruction_obuf[5] , output \instruction_obuf[6] , output \instruction_obuf[7] , output \instruction_obuf[8] , output \instruction_obuf[9] , input rst);

wire clk_ibuf, branch_taken, \branch_offset_imm_ibuf[0] , n9, n13, n14, n15, n16, n17, n18;
wire n19, \branch_offset_imm_ibuf[1] , \branch_offset_imm_ibuf[2] , \branch_offset_imm_ibuf[3] , \branch_offset_imm_ibuf[4] , \branch_offset_imm_ibuf[5] , instruction_fetch_en, \instruction_obuf[0] , \instruction_obuf[1] , \instruction_obuf[10] ;
wire \instruction_obuf[11] , \instruction_obuf[12] , \instruction_obuf[13] , \instruction_obuf[14] , \instruction_obuf[15] , \instruction_obuf[2] , \instruction_obuf[3] , \instruction_obuf[4] , \instruction_obuf[5] , \instruction_obuf[6] ;
wire \instruction_obuf[7] , \instruction_obuf[8] , \instruction_obuf[9] , rst, n43, n44, n45, n46, n47, n48;
wire n49, n50, n51, n52, n53, n54, n55, n56, n57, n58;
wire n59, n60, n61, n62, n63, n64, n65, n66, n67, n68;
wire n69, n70, n71, n72, n73, n74, n75, n76, n77, n78;
reg \pc_obuf[6]  = 0, \pc_obuf[7]  = 0, \pc_obuf[5]  = 0, \pc_obuf[4]  = 0, \pc_obuf[0]  = 0, \pc_obuf[3]  = 0, \pc_obuf[2]  = 0, \pc_obuf[1]  = 0;
assign n68 = 1;
assign n71 = 0;

assign n67 = /* LUT    1  7  0 */ 1'b0;
assign n70 = /* LUT    1  8  0 */ 1'b0;
assign n72 = /* LUT    1  6  1 */ 1'b1;
assign n57 = /* LUT    1  7  2 */ (n44 ? (branch_taken ? n14 : !\pc_obuf[2] ) : (branch_taken ? n14 : \pc_obuf[2] ));
assign n58 = /* LUT    1  8  2 */ (n51 ? (\branch_offset_imm_ibuf[2]  ? \pc_obuf[2]  : !\pc_obuf[2] ) : (\branch_offset_imm_ibuf[2]  ? !\pc_obuf[2]  : \pc_obuf[2] ));
assign n59 = /* LUT    1  8  1 */ (n50 ? (\branch_offset_imm_ibuf[1]  ? \pc_obuf[1]  : !\pc_obuf[1] ) : (\branch_offset_imm_ibuf[1]  ? !\pc_obuf[1]  : \pc_obuf[1] ));
assign n60 = /* LUT    1  7  5 */ (n47 ? (branch_taken ? n17 : !\pc_obuf[5] ) : (branch_taken ? n17 : \pc_obuf[5] ));
assign n61 = /* LUT    1  8  7 */ (n56 ? (\pc_obuf[7]  ? \branch_offset_imm_ibuf[5]  : !\branch_offset_imm_ibuf[5] ) : (\pc_obuf[7]  ? !\branch_offset_imm_ibuf[5]  : \branch_offset_imm_ibuf[5] ));
assign n62 = /* LUT    1  7  1 */ (n43 ? (branch_taken ? n13 : !\pc_obuf[1] ) : (branch_taken ? n13 : \pc_obuf[1] ));
assign n63 = /* LUT    1  8  3 */ (n52 ? (\branch_offset_imm_ibuf[3]  ? \pc_obuf[3]  : !\pc_obuf[3] ) : (\branch_offset_imm_ibuf[3]  ? !\pc_obuf[3]  : \pc_obuf[3] ));
assign n64 = /* LUT    1  7  4 */ (n46 ? (branch_taken ? n16 : !\pc_obuf[4] ) : (branch_taken ? n16 : \pc_obuf[4] ));
assign n65 = /* LUT    1  8  4 */ (n53 ? (\branch_offset_imm_ibuf[4]  ? \pc_obuf[4]  : !\pc_obuf[4] ) : (\branch_offset_imm_ibuf[4]  ? !\pc_obuf[4]  : \pc_obuf[4] ));
assign n73 = /* LUT    1  8  5 */ (n54 ? (\branch_offset_imm_ibuf[5]  ? \pc_obuf[5]  : !\pc_obuf[5] ) : (\branch_offset_imm_ibuf[5]  ? !\pc_obuf[5]  : \pc_obuf[5] ));
assign n74 = /* LUT    1  6  0 */ (branch_taken ? (\branch_offset_imm_ibuf[0]  ? !\pc_obuf[0]  : \pc_obuf[0] ) : (n9 ? !\pc_obuf[0]  : \pc_obuf[0] ));
assign n75 = /* LUT    1  7  7 */ (n49 ? (branch_taken ? n19 : !\pc_obuf[7] ) : (branch_taken ? n19 : \pc_obuf[7] ));
assign n76 = /* LUT    1  7  3 */ (n45 ? (branch_taken ? n15 : !\pc_obuf[3] ) : (branch_taken ? n15 : \pc_obuf[3] ));
assign n77 = /* LUT    1  7  6 */ (n48 ? (branch_taken ? n18 : !\pc_obuf[6] ) : (branch_taken ? n18 : \pc_obuf[6] ));
assign n78 = /* LUT    1  8  6 */ (n55 ? (\branch_offset_imm_ibuf[5]  ? \pc_obuf[6]  : !\pc_obuf[6] ) : (\branch_offset_imm_ibuf[5]  ? !\pc_obuf[6]  : \pc_obuf[6] ));
assign n45 = /* CARRY  1  7  2 */ (\pc_obuf[2]  & branch_taken) | ((\pc_obuf[2]  | branch_taken) & n44);
assign n52 = /* CARRY  1  8  2 */ (\pc_obuf[2]  & \branch_offset_imm_ibuf[2] ) | ((\pc_obuf[2]  | \branch_offset_imm_ibuf[2] ) & n51);
assign n51 = /* CARRY  1  8  1 */ (\pc_obuf[1]  & \branch_offset_imm_ibuf[1] ) | ((\pc_obuf[1]  | \branch_offset_imm_ibuf[1] ) & n50);
assign n48 = /* CARRY  1  7  5 */ (\pc_obuf[5]  & branch_taken) | ((\pc_obuf[5]  | branch_taken) & n47);
assign n44 = /* CARRY  1  7  1 */ (\pc_obuf[1]  & branch_taken) | ((\pc_obuf[1]  | branch_taken) & n43);
assign n53 = /* CARRY  1  8  3 */ (\pc_obuf[3]  & \branch_offset_imm_ibuf[3] ) | ((\pc_obuf[3]  | \branch_offset_imm_ibuf[3] ) & n52);
assign n47 = /* CARRY  1  7  4 */ (\pc_obuf[4]  & branch_taken) | ((\pc_obuf[4]  | branch_taken) & n46);
assign n54 = /* CARRY  1  8  4 */ (\pc_obuf[4]  & \branch_offset_imm_ibuf[4] ) | ((\pc_obuf[4]  | \branch_offset_imm_ibuf[4] ) & n53);
assign n43 = /* CARRY  1  7  0 */ (\pc_obuf[0]  & 1'b0) | ((\pc_obuf[0]  | 1'b0) & n68);
assign n50 = /* CARRY  1  8  0 */ (\pc_obuf[0]  & \branch_offset_imm_ibuf[0] ) | ((\pc_obuf[0]  | \branch_offset_imm_ibuf[0] ) & n71);
assign n55 = /* CARRY  1  8  5 */ (\pc_obuf[5]  & \branch_offset_imm_ibuf[5] ) | ((\pc_obuf[5]  | \branch_offset_imm_ibuf[5] ) & n54);
assign n46 = /* CARRY  1  7  3 */ (\pc_obuf[3]  & branch_taken) | ((\pc_obuf[3]  | branch_taken) & n45);
assign n49 = /* CARRY  1  7  6 */ (\pc_obuf[6]  & branch_taken) | ((\pc_obuf[6]  | branch_taken) & n48);
assign n56 = /* CARRY  1  8  6 */ (\pc_obuf[6]  & \branch_offset_imm_ibuf[5] ) | ((\pc_obuf[6]  | \branch_offset_imm_ibuf[5] ) & n55);
/* FF  1  7  2 */ always @(posedge clk_ibuf, posedge rst) if (rst) \pc_obuf[2]  <= 1'b0; else if (instruction_fetch_en) \pc_obuf[2]  <= n57;
/* FF  1  8  2 */ assign n14 = n58;
/* FF  1  8  1 */ assign n13 = n59;
/* FF  1  7  5 */ always @(posedge clk_ibuf, posedge rst) if (rst) \pc_obuf[5]  <= 1'b0; else if (instruction_fetch_en) \pc_obuf[5]  <= n60;
/* FF  1  8  7 */ assign n19 = n61;
/* FF  1  7  1 */ always @(posedge clk_ibuf, posedge rst) if (rst) \pc_obuf[1]  <= 1'b0; else if (instruction_fetch_en) \pc_obuf[1]  <= n62;
/* FF  1  8  3 */ assign n15 = n63;
/* FF  1  7  4 */ always @(posedge clk_ibuf, posedge rst) if (rst) \pc_obuf[4]  <= 1'b0; else if (instruction_fetch_en) \pc_obuf[4]  <= n64;
/* FF  1  8  4 */ assign n16 = n65;
/* FF  1  7  0 */ assign n66 = n67;
/* FF  1  8  0 */ assign n69 = n70;
/* FF  1  6  1 */ assign n9 = n72;
/* FF  1  8  5 */ assign n17 = n73;
/* FF  1  6  0 */ always @(posedge clk_ibuf, posedge rst) if (rst) \pc_obuf[0]  <= 1'b0; else if (instruction_fetch_en) \pc_obuf[0]  <= n74;
/* FF  1  7  7 */ always @(posedge clk_ibuf, posedge rst) if (rst) \pc_obuf[7]  <= 1'b0; else if (instruction_fetch_en) \pc_obuf[7]  <= n75;
/* FF  1  7  3 */ always @(posedge clk_ibuf, posedge rst) if (rst) \pc_obuf[3]  <= 1'b0; else if (instruction_fetch_en) \pc_obuf[3]  <= n76;
/* FF  1  7  6 */ always @(posedge clk_ibuf, posedge rst) if (rst) \pc_obuf[6]  <= 1'b0; else if (instruction_fetch_en) \pc_obuf[6]  <= n77;
/* FF  1  8  6 */ assign n18 = n78;

endmodule

