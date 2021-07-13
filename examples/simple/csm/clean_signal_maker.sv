`default_nettype none
module clean_signal_maker(
    input wire logic clk,
    input wire logic btnu, // reset
    input wire logic btnc,
    output logic [3:0] anode,
    output logic [7:0] segment
    );
    
    // Internal signals for ded input (indicated by 1)
    logic synchronizer1, syncedButton1, ded1;  // Used for synchronizer and 
    logic firstFlipFlopSignal1, secondFlipFlopSignal1, oneShotSignal1;  // Used for 
    logic [7:0] count1;  // Used for counter
    
    // Internal signals for unded input (indicated by 2)
    logic oneShotSignal2;  // Used for 
    logic [7:0] count2;  // Used for counter
    
    // Synchronizer
    always_ff @(posedge clk)
    begin
        synchronizer1 <= btnc;
        syncedButton1 <= synchronizer1;
    end
    
    // Smoother outer
    smooth_out smoother_outer(clk, btnu, syncedButton1, ded1);
    
    // 
    always_ff @(posedge clk)
    begin
        firstFlipFlopSignal1 <= ded1;
        secondFlipFlopSignal1 <= firstFlipFlopSignal1;
    end
    assign oneShotSignal1 = firstFlipFlopSignal1 & ~secondFlipFlopSignal1;
    
    // 16-bit counter
    always_ff @(posedge clk)
        if (btnu)
            count1 <= 0;
        else if (oneShotSignal1)
            count1 <= count1 + 1;
            
    
    //  for unded input
    assign oneShotSignal2 = synchronizer1 & ~syncedButton1;
    
    // 16-bit counter for unded input
    always_ff @(posedge clk)
        if (btnu)
            count2 <= 0;
        else if (oneShotSignal2)
            count2 <= count2 + 1;

    ssc ssc(clk, btnu, {count2, count1}, 4'b1111, 4'b0000, anode, segment);
        
endmodule
