//////////////////////////////////////////////////////////////////////////////////
//
//  Filename: SevenSegmentControl.sv
//
//  Author: Mike Wirthlin, Jeff Goeders
//  
//  Description:
//
//     
//////////////////////////////////////////////////////////////////////////////////

module ssc(
    input wire logic            clk, 
    input wire logic            reset, 
    input wire logic    [31:0]  dataIn, 
    input wire logic    [7:0]   digitDisplay, 
    input wire logic    [7:0]   digitPoint, 
    output logic        [7:0]   anode, 
    output logic        [7:0]   segment
    );

    parameter integer COUNT_BITS = 17;
    
    logic   [COUNT_BITS-1:0]    count_val;
    logic   [2:0]               anode_select;
    logic   [7:0]               cur_anode;
    logic   [3:0]               cur_data_in;
    
    // Create counter    
    always_ff @(posedge clk) begin
       if (reset)
           count_val <= 0;
       else
           count_val <= count_val + 1;
    end

    // Signal to indicate which anode we are driving
    assign anode_select = count_val[COUNT_BITS-1:COUNT_BITS-3];

    // current andoe
    assign cur_anode = 
                        (anode_select == 3'b000) ? 8'b11111110 :
                        (anode_select == 3'b001) ? 8'b11111101 :
                        (anode_select == 3'b010) ? 8'b11111011 :
                        (anode_select == 3'b011) ? 8'b11110111 :
                        (anode_select == 3'b100) ? 8'b11101111 :
                        (anode_select == 3'b101) ? 8'b11011111 :
                        (anode_select == 3'b110) ? 8'b10111111 :
                        8'b01111111;
                        
    // Mask anode values that are not enabled with digit display
    //  (if a bit of digitDisplay is '0' (off), then it will be 
    //   inverted and "ored" with the annode making it '1' (no drive)
    assign anode = cur_anode | (~digitDisplay);
    
    // This is a statement to simulate a common student problem with the
    // anode is "stuck". This statement is used to make sure the testbench catches
    // this condition.
    //assign anode = 8'hff;              
    
    assign cur_data_in = 
                        (anode_select == 3'b000) ? dataIn[3:0] :
                        (anode_select == 3'b001) ? dataIn[7:4]  :
                        (anode_select == 3'b010) ? dataIn[11:8]  :
                        (anode_select == 3'b011) ? dataIn[15:12]  :
                        (anode_select == 3'b100) ? dataIn[19:16]  :
                        (anode_select == 3'b101) ? dataIn[23:20]  :
                        (anode_select == 3'b110) ? dataIn[27:24]  :
                        dataIn[31:28] ;
    
    // Digit point (drive segmetn with inverted version of input digit point)
    assign segment[7] = 
                        (anode_select == 3'b000) ? ~digitPoint[0] :
                        (anode_select == 3'b001) ? ~digitPoint[1]  :
                        (anode_select == 3'b010) ? ~digitPoint[2]  :
                        (anode_select == 3'b011) ? ~digitPoint[3]  :
                        (anode_select == 3'b100) ? ~digitPoint[4]  :
                        (anode_select == 3'b101) ? ~digitPoint[5]  :
                        (anode_select == 3'b110) ? ~digitPoint[6]  :
                        ~digitPoint[7] ;

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