
// zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// File Name		: clk_domain_cross.v
// Description	: circuit synchronizer for signal goes across 
//								two different clock domains
// Author				: NUDT
// -------------------------------------------------------------------------------
// Version			: 
//	-- 2011-02-15 Modify by Zefu Dai, fix the reset signals to make it consistance
// fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

`timescale 1ns/1ps
module clk_domain_cross
(
  sigin,
  clkin,
  clr_in,
  clr_out,
  clkout,
  sigout,
  full
);

input sigin;
input clkin;
input clr_in;
input clkout;
input clr_out;
output sigout;
output full;

wire  [2:0] wptr,sync_wptr;
wire  [2:0] rptr,sync_rptr;
wire	      full; 

write_counter_2 		write_counter(  
                  .wptr    	(wptr			),
                  .full    	(full			),
                  .wq2_rptr	(sync_rptr),
                  .winc    	(sigin		),
                  .wclk    	(clkin		),
                  .wrst_n  	(clr_in		)
                   );
                   
sync_reg_2 					sync_write_ptr(
                  .out_ptr	(sync_wptr),
                  .in_ptr 	(wptr			),
                  .clk    	(clkout		),
                  .rst_n  	(clr_out	)
                  );
                  
                  
sync_reg_2 					sync_read_ptr(
                  .out_ptr	(sync_rptr),
                  .in_ptr 	(rptr			),
                  .clk   		(clkin		),
                  .rst_n 		(clr_in		)
                  );  
                  
                                    
trans_counter_2  	trans_counter(
                .sigout  		(sigout		),
                .rptr    		(rptr			),
                .rq2_wptr		(sync_wptr),
                .rclk    		(clkout		),
                .rrst_n  		(clr_out	)
                );

endmodule




module write_counter_2(
  		wptr,
  		full,
  		wq2_rptr,
  		winc,
  		wclk,
  		wrst_n
);

output [2:0] wptr;
output       full;
input  [2:0] wq2_rptr;
input        winc, wclk, wrst_n;
reg    [2:0] wbin;
wire   [2:0] wgraynext, wbinnext;
wire         wdec;
reg    [2:0] wptr;
reg 				 winc_reg;
wire   [2:0] wbinnext_next;

// GRAYSTYLE2 pointer
always @(posedge wclk)
begin
  	if (wrst_n) 
  	begin
  	  		{wbin, wptr} <= 0;
  	  		 winc_reg<=0;
  	end
  	else 
  	begin
  	  		{wbin, wptr} <= {wbinnext, wgraynext};
  	  		winc_reg <= winc;
  	end
end  
  
assign wbinnext 	=	wbin + winc_reg;
assign wdec 			= (wptr!=wq2_rptr);
assign wgraynext 	= (wbinnext>>1) ^ wbinnext;

assign wbinnext_next=(wbinnext+1);
assign full = (((wbinnext_next>>1)^wbinnext_next)==wq2_rptr);

endmodule



module trans_counter_2(
				sigout,
				rptr,
				rq2_wptr,
				rclk,
				rrst_n
);
//output reg rempty,
//output [ADDRSIZE-1:0] raddr,
output       sigout;
output [2:0] rptr;
input  [2:0] rq2_wptr;
input        rclk, rrst_n;
reg    [2:0] rbin;
wire   [2:0] rgraynext, rbinnext;
reg    [2:0] rptr;

always @(posedge rclk)
begin
  		if (rrst_n) {rbin, rptr} <= 0;
  		else {rbin, rptr} <= {rbinnext, rgraynext};
end
  
assign rbinnext 	= rbin + sigout;//(rinc & ~rempty);
assign rgraynext 	= (rbin>>1) ^ rbin;//(rbinnext>>1) ^ rbinnext;
assign sigout=(rgraynext != rq2_wptr); 

endmodule




module sync_reg_2(
			out_ptr,
			in_ptr,
			clk,
			rst_n
); 

output [2:0] 	out_ptr;
input  [2:0] 	in_ptr;
input					clk, rst_n; 

reg 	[2:0] 	out1_ptr;
reg 	[2:0] 	out_ptr;

always @(posedge clk)
begin
    if (rst_n) {out_ptr,out1_ptr} <= 0;
    else {out_ptr,out1_ptr} <= {out1_ptr,in_ptr};
end
    
endmodule
