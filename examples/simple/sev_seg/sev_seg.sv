`default_nettype none
module sev_seg(
    input wire logic [3:0] sw,
    input wire logic btnc,
    output logic [7:0] segment,
    output logic [3:0] anode
    );
    
    seg_seven_logic SEG(sw, segment[6:0]);
    
    not(segment[7], btnc);
    
    assign anode = 4'b1110;
    
endmodule
