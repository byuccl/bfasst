module sender(
    input wire logic            clk, 
    input wire logic            btnu, //reset
    input wire logic    [7:0]   sw, 
    input wire logic            btnc, 
    output logic        [3:0]   anode, 
    output logic        [7:0]   segment, 
    output logic                tx_out, 
    output logic                tx_debug);

    logic reset;
    assign reset = btnu;
    assign tx_debug = tx_out;

    logic   btnc_r;
    logic   btnc_r2;
    logic   send_character;
    
    // Button
    always_ff@(posedge clk)
    begin
       btnc_r <= btnc;
       btnc_r2 <= btnc_r;
    end


    smooth_out inst(
        .clk(clk),
        .rst(reset),
        .not_smooth(btnc_r2),
        .smoothed_out(send_character)
    );
    

    u_t_x cheeta_inst(
        .clk    (clk), 
        .rst  (reset),
        .confirmation_send   (send_character),
        .dat_incoming    (sw),
        .confirmation_sent   (),
        .out_serial   (tx_out)
    );
        

    ssc SSC (
        .clk(clk),
        .reset(reset),
        .dataIn({8'h00, sw}),
        .display_dig(4'h3),
        .point_dig(4'h0), 
        .anode(anode),
        .segment(segment)
    );

    
endmodule