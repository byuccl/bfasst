module mem_c (
	read_clk,
	read_address,
	data_in,
	write_clk,
	rd_en,
	wr_en,
	write_address,
	data_out);
parameter address_width = 8;
parameter data_width = 8;
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
endmodule
