`default_nettype none
module line_maker(
    input wire logic clk,
    input wire logic reset,
    input wire logic start,
    input wire logic [8:0] x_in,
    input wire logic [7:0] y_in,
    input wire logic [7:0] height,
    output logic draw,
    output logic done,
    output logic [8:0] x_out,
    output logic [7:0] y_out
    );
    
    logic clrCounter;
    logic counterDone;
    logic [7:0] count;
    // Height counter
    always_ff @(posedge clk)
        if (clrCounter || count == height)
            count <= 0;
        else
            count <= count + 1;
    always_comb
        if (count == height)
            counterDone = 1;
        else
            counterDone = 0;
    
    typedef enum logic[1:0] {IDLE, DRAW_LINE, FINISH, ERR='X} StateType;
    StateType ns, cs;
    
    always_comb
    begin
        ns = ERR;
        clrCounter = 0;
        x_out = 0;
        y_out = 0;
        draw = 0;
        done = 0;
        if (reset)
            ns = IDLE;
        else
            case (cs)
                IDLE:      begin
                           clrCounter = 1;
                           if (start)
                               ns = DRAW_LINE;
                           else
                               ns = IDLE;
                           end
                DRAW_LINE: begin
                           draw = 1;
                           x_out = x_in;
                           y_out = y_in + count;
                           if (counterDone)
                           begin
                               done = 1;
                               ns = FINISH;
                           end
                           else
                               ns = DRAW_LINE;
                           end
                FINISH:    if (~start)
                               ns = IDLE;
                           else
                               ns = FINISH;
            endcase
    end
    
    always_ff @(posedge clk)
        cs <= ns;
    
endmodule
