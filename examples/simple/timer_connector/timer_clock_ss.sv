`default_nettype none
module timer_clock_ss(
    input wire logic clk,
    input wire logic reset,
    input wire logic go,
    output logic [3:0] left,
    output logic [3:0] middle_left,
    output logic [3:0] middle_right,
    output logic [3:0] right
    );
    
    logic [7:0] rolling_over;
    logic [19:0] currentCount;
    logic incrementClock;
    
    always_ff @(posedge clk)  // This always_ff block is a simple counter that increments every clock cycle (except when
    begin                     // go is low or reset is high). It rolls over when it reaches 1,000,000
        if (~go & ~reset)
            currentCount <= currentCount;
        else if ((~go & reset) || (currentCount == 20'hF4240))
            currentCount <= 16'h0000;
        else if (go & ~reset)
            currentCount <= currentCount + 16'h0001;
        else if (go & reset)
            currentCount <= currentCount;
        else
            currentCount <= currentCount;
    end
    
    assign incrementClock = go & (currentCount == 20'hF4240);
   
    simp_count #(10) digitZero(clk, reset, incrementClock, rolling_over[0], left);
    simp_count #(10) digitOne(clk, reset, rolling_over[0], rolling_over[1], middle_left);
    simp_count #(10) digitTwo(clk, reset, rolling_over[1], rolling_over[2], middle_right);
    simp_count #(6) digitThree(clk, reset, rolling_over[2], rolling_over[3], right);
    
endmodule