
module chip (input clk, input rst, output \pc[0] , output \pc[7] , output \pc[2] , output \pc[3] , output \pc[4] , output \pc[5] , output \pc[6] , output \pc[1] );

wire clk, rst, n11, n12, n13, n14, n15, n16, n17, n18;
wire n19, n20, n21, n22, n23, n24, n25, n26, n27, n28;
wire n29, n30;
reg \pc[0]  = 0, \pc[7]  = 0, \pc[2]  = 0, \pc[3]  = 0, \pc[4]  = 0, \pc[5]  = 0, \pc[6]  = 0, \pc[1]  = 0;
assign n21 = 1;

assign n20 = /* LUT    1  4  0 */ 1'b0;
assign n24 = /* LUT    1  4  1 */ 1'b0;
assign n18 = /* LUT    1  4  7 */ (n16 ? !\pc[7]  : \pc[7] );
assign n22 = /* LUT    1  4  4 */ (n13 ? !\pc[4]  : \pc[4] );
assign n25 = /* LUT    1  4  5 */ (n14 ? !\pc[5]  : \pc[5] );
assign n26 = /* LUT    1  5  6 */ !\pc[1] ;
assign n27 = /* LUT    1  4  2 */ (n11 ? !\pc[2]  : \pc[2] );
assign n28 = /* LUT    1  3  4 */ !\pc[0] ;
assign n29 = /* LUT    1  4  6 */ (n15 ? !\pc[6]  : \pc[6] );
assign n30 = /* LUT    1  4  3 */ (n12 ? !\pc[3]  : \pc[3] );
assign n17 = /* CARRY  1  4  0 */ (\pc[0]  & 1'b0) | ((\pc[0]  | 1'b0) & n21);
assign n14 = /* CARRY  1  4  4 */ (1'b0 & \pc[4] ) | ((1'b0 | \pc[4] ) & n13);
assign n11 = /* CARRY  1  4  1 */ (1'b0 & \pc[1] ) | ((1'b0 | \pc[1] ) & n17);
assign n15 = /* CARRY  1  4  5 */ (1'b0 & \pc[5] ) | ((1'b0 | \pc[5] ) & n14);
assign n12 = /* CARRY  1  4  2 */ (1'b0 & \pc[2] ) | ((1'b0 | \pc[2] ) & n11);
assign n16 = /* CARRY  1  4  6 */ (1'b0 & \pc[6] ) | ((1'b0 | \pc[6] ) & n15);
assign n13 = /* CARRY  1  4  3 */ (1'b0 & \pc[3] ) | ((1'b0 | \pc[3] ) & n12);
/* FF  1  4  7 */ always @(posedge clk, posedge rst) if (rst) \pc[7]  <= 1'b0; else if (1'b1) \pc[7]  <= n18;
/* FF  1  4  0 */ assign n19 = n20;
/* FF  1  4  4 */ always @(posedge clk, posedge rst) if (rst) \pc[4]  <= 1'b0; else if (1'b1) \pc[4]  <= n22;
/* FF  1  4  1 */ assign n23 = n24;
/* FF  1  4  5 */ always @(posedge clk, posedge rst) if (rst) \pc[5]  <= 1'b0; else if (1'b1) \pc[5]  <= n25;
/* FF  1  5  6 */ always @(posedge clk, posedge rst) if (rst) \pc[1]  <= 1'b0; else if (\pc[0] ) \pc[1]  <= n26;
/* FF  1  4  2 */ always @(posedge clk, posedge rst) if (rst) \pc[2]  <= 1'b0; else if (1'b1) \pc[2]  <= n27;
/* FF  1  3  4 */ always @(posedge clk, posedge rst) if (rst) \pc[0]  <= 1'b0; else if (1'b1) \pc[0]  <= n28;
/* FF  1  4  6 */ always @(posedge clk, posedge rst) if (rst) \pc[6]  <= 1'b0; else if (1'b1) \pc[6]  <= n29;
/* FF  1  4  3 */ always @(posedge clk, posedge rst) if (rst) \pc[3]  <= 1'b0; else if (1'b1) \pc[3]  <= n30;

endmodule

