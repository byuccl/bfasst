/*************************************************************************************************************
*
*  Copyright 2021 BYU Configurable Computing Lab
*
*  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
*  associated documentation files (the "Software"), to deal in the Software without restriction, including 
*  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
*  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the 
*  following conditions:
*
*  The above copyright notice and this permission notice shall be included in all copies or substantial 
*  portions of the Software.
*
*  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
*  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
*  EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER 
*  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
*  THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*
**************************************************************************************************************/

/*************************************************************************************************************
*
*  Module Description: Top module for sending data that is not noisy
*
**************************************************************************************************************/

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
