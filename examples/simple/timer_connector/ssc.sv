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
*  Module Description: Four digit seven segment controller - multiplexes through each cathode signal of the
*                      seven segment display.
*
**************************************************************************************************************/

module ssc(
    input wire logic            clk, 
    input wire logic            reset, 
    input wire logic    [15:0]  dataIn, 
    input wire logic    [3:0]   display_dig, 
    input wire logic    [3:0]   point_dig, 
    output logic        [3:0]   anode, 
    output logic        [7:0]   segment
    );

    parameter integer COUNT_BITS = 17;
    
    logic   [COUNT_BITS-1:0]    count_val;
    logic   [1:0]               anode_select;
    logic   [3:0]               cur_anode;
    logic   [3:0]               cur_data_in;
    
    // Create counter    
    always_ff @(posedge clk) begin
       if (reset)
           count_val <= 0;
       else
           count_val <= count_val + 1;
    end

    // Signal to indicate which anode we are driving
    assign anode_select = count_val[COUNT_BITS-1:COUNT_BITS-2];

    // current andoe
    assign cur_anode = 
                        (anode_select == 2'b00) ? 4'b1110 :
                        (anode_select == 2'b01) ? 4'b1101 :
                        (anode_select == 2'b10) ? 4'b1011 :
                        4'b0111;
                        
    // Mask anode values that are not enabled with digit display
    //  (if a bit of display_dig is '0' (off), then it will be 
    //   inverted and "ored" with the annode making it '1' (no drive)
    assign anode = cur_anode | (~display_dig);
    
    // This is a statement to simulate a common student problem with the
    // anode is "stuck". This statement is used to make sure the testbench catches
    // this condition.
    //assign anode = 8'hff;              
    
    assign cur_data_in = 
                        (anode_select == 2'b00) ? dataIn[3:0] :
                        (anode_select == 2'b01) ? dataIn[7:4]  :
                        (anode_select == 2'b10) ? dataIn[11:8]  :
                        dataIn[15:12] ;
    
    // Digit point (drive segmetn with inverted version of input digit point)
    assign segment[7] = 
                        (anode_select == 2'b00) ? ~point_dig[0] :
                        (anode_select == 2'b01) ? ~point_dig[1]  :
                        (anode_select == 2'b10) ? ~point_dig[2]  :
                        ~point_dig[3] ;

    assign segment[6:0] =
        (cur_data_in == 0) ? 7'b1000000 :
        (cur_data_in == 1) ? 7'b1111001 :
        (cur_data_in == 2) ? 7'b0100100 :
        (cur_data_in == 3) ? 7'b0110000 :
        (cur_data_in == 4) ? 7'b0011001 :
        (cur_data_in == 5) ? 7'b0010010 :
        (cur_data_in == 6) ? 7'b0000010 :
        (cur_data_in == 7) ? 7'b1111000 :
        (cur_data_in == 8) ? 7'b0000000 :
        (cur_data_in == 9) ? 7'b0010000 :
        (cur_data_in == 10) ? 7'b0001000 :
        (cur_data_in == 11) ? 7'b0000011 :
        (cur_data_in == 12) ? 7'b1000110 :
        (cur_data_in == 13) ? 7'b0100001 :
        (cur_data_in == 14) ? 7'b0000110 :
        7'b0001110;

                        
endmodule
