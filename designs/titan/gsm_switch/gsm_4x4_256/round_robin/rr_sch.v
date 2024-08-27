// zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// File Name	: rr_sch.v
// Description	: round robin scheduler
// Author		: Zefu Dai
// -------------------------------------------------------------------------------
// Version		: 
//	-- 2011-06-29 created by Zefu Dai
// fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff


`timescale 1ns/1ps

module rr_sch
#(
	parameter	NUM_PORT = 4,	// number of requests to be scheduled
	parameter	LOG_NUM_PORT = 2
)
(
	input wire clk,
	input wire rst_n,
	input wire clr,

	input wire [NUM_PORT-1:0] req,
	input wire stall,

	output wire [NUM_PORT-1:0] grant
);
genvar iRR;
integer i;

reg     [NUM_PORT-1:0]          rr_prior_non_empty_vec;
reg     [NUM_PORT-1:0]          rr_prior[0:NUM_PORT-1];
reg     [NUM_PORT-1:0]          rr_prior_non_empty[0:NUM_PORT-1];       
reg     [NUM_PORT-1:0]          rr_prior_mask[0:NUM_PORT-1];
        
reg     [LOG_NUM_PORT-1:0]      rr_index[0:NUM_PORT-1]; 
reg 	[LOG_NUM_PORT-1:0] 	sch_index ;
reg     [NUM_PORT-1:0]          rr_nxt_non_empty_vec;

always@(*)begin              
        rr_prior_non_empty_vec = 0;
        for(i=0;i<NUM_PORT;i=i+1)
                rr_prior_non_empty_vec = rr_prior_non_empty_vec | rr_prior_non_empty[i];                        
end

generate
	for(iRR=0;iRR<NUM_PORT; iRR=iRR+1) begin : ROUND_ROBIN           
                        
                // the Round Robin priority of each port is updated whenever the token is 
                // passed from one port to another
                always@(posedge clk )begin
                       if(clr)
                                rr_index[iRR] <= NUM_PORT - iRR;
                        else if(~stall)
                                rr_index[iRR] <= sch_index - iRR + NUM_PORT; 
                end     
                
                always@(*)begin
                        rr_prior[iRR] = 1 << rr_index[iRR];
                        rr_prior_mask[iRR] = {NUM_PORT{1'b1}} << (rr_index[iRR] + 1);
                        rr_prior_non_empty[iRR] = req[iRR] ? rr_prior[iRR] : 0;
                end     
                
                always@(*)begin
                        rr_nxt_non_empty_vec[iRR] = req[iRR] ? ( ~|(rr_prior_non_empty_vec & rr_prior_mask[iRR]) ) : 0;
                end                     
                                                                         		
	end // end for
endgenerate

generate 
	if(NUM_PORT == 4) begin
            always @ (*)
                case (rr_nxt_non_empty_vec)
                    4'b0001: sch_index = 0;
                    4'b0010: sch_index = 1;
                    4'b0100: sch_index = 2;
                    4'b1000: sch_index = 3;
                    default: sch_index = 0;
                endcase
	end
endgenerate

assign grant = rr_nxt_non_empty_vec;

endmodule
