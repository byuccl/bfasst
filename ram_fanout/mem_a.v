module mem_a (
	read_clk,
	read_address,
	data_in,
	write_clk,
	rd_en,
	wr_en,
	write_address,
	data_out);
parameter address_width = 8;
parameter data_width = 64;
parameter depth = 256;
input read_clk, write_clk;
input rd_en;
input wr_en;
input [address_width-1:0] read_address, write_address;
input [data_width-1:0] data_in;
output [data_width-1:0] data_out;
reg [data_width-1:0] mem [depth -1 : 0]/* synthesis syn_ramstyle="no_rw_check" */;
reg [data_width-1:0] data_out;
always @(posedge write_clk)
	if(wr_en)
		mem[write_address] <= data_in;
	always @(posedge read_clk)
		if(rd_en)
			data_out <= mem[read_address];


	// always @(posedge read_clk) begin
	// 	case (read_address)
	// 	0 : data_out = 32'h4;
	// 	1 : data_out = 32'h9;
	// 	2 : data_out = 32'h1;
	// 	3: data_out = 32'h57385738;
	// 	4: data_out = 32'h39573723;
	// 	5: data_out = 32'h20394857;
	// 	6: data_out = 32'h18273625;
	// 	7: data_out = 32'h98736482;
	// 	8: data_out = 32'h02948223;
	// 	9: data_out = 32'h45685236;
	// 	10: data_out = 32'h78541236;
	// 	11: data_out = 32'h96587412;
	// 	12: data_out = 32'h12321232;
	// 	13: data_out = 32'h52585256;
	// 	14: data_out = 32'h78544478;
	// 	15 : data_out = 32'h85258654;
	// 	16 : data_out = 32'h74745454;
	// 	17 : data_out = 32'h82826459;
	// 	18 : data_out = 32'h4;
	// 	19 : data_out = 32'h9;
	// 	20 : data_out = 32'h1;
	// 	21: data_out = 32'h57385738;
	// 	22: data_out = 32'h39573723;
	// 	23: data_out = 32'h20394857;
	// 	24: data_out = 32'h18273625;
	// 	25: data_out = 32'h98736482;
	// 	26: data_out = 32'h02948223;
	// 	27: data_out = 32'h45685236;
	// 	28: data_out = 32'h78541236;
	// 	29: data_out = 32'h96587412;
	// 	30: data_out = 32'h12321232;
	// 	31: data_out = 32'h52585256;
	// 	32: data_out = 32'h78544478;
	// 	33 : data_out = 32'h85258654;
	// 	34 : data_out = 32'h74745454;
	// 	35 : data_out = 32'h82826459;
	// 	36 : data_out = 32'h4;
	// 	37 : data_out = 32'h9;
	// 	38 : data_out = 32'h1;
	// 	39: data_out = 32'h57385738;
	// 	40: data_out = 32'h39573723;
	// 	41: data_out = 32'h20394857;
	// 	42: data_out = 32'h18273625;
	// 	43: data_out = 32'h98736482;
	// 	44: data_out = 32'h02948223;
	// 	45: data_out = 32'h45685236;
	// 	46: data_out = 32'h78541236;
	// 	47: data_out = 32'h96587412;
	// 	48: data_out = 32'h12321232;
	// 	49: data_out = 32'h52585256;
	// 	50: data_out = 32'h78544478;
	// 	51 : data_out = 32'h85258654;
	// 	52 : data_out = 32'h74745454;
	// 	53 : data_out = 32'h82826459;
	// 	default: data_out = 32'h78523654;
	// 	endcase
	// end
endmodule
