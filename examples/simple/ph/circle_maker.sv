`default_nettype none
module circle_maker(
    input wire logic clk,
    input wire logic reset,
    input wire logic start,
    input wire logic [8:0] x_in,
    input wire logic [7:0] y_in,
    output logic draw,
    output logic done,
    output logic [8:0] x_out,
    output logic [7:0] y_out
    );
    
    typedef enum logic [2:0] {IDLE, DRAW_LT, DRAW_RT, DRAW_RB, DRAW_LB, FINISH, ERR='X} StateType;
    StateType ns, cs;
    
    always_comb
    begin
        ns = ERR;
        x_out = 0;
        y_out = 0;
        draw = 0;
        done = 0;
        
        if (reset)
            ns = IDLE;
        else
            case (cs)
                IDLE:    if (start)
                             ns = DRAW_LT;
                         else
                             ns = IDLE;
                DRAW_LT: begin
                         draw = 1;
                         x_out = x_in;
                         y_out = y_in;
                         ns = DRAW_RT;
                         end
                DRAW_RT: begin
                         draw = 1;
                         x_out = x_in + 1;
                         y_out = y_in;
                         ns = DRAW_RB;
                         end
                DRAW_RB: begin
                         draw = 1;
                         x_out = x_in + 1;
                         y_out = y_in + 1;
                         ns = DRAW_LB;
                         end
                DRAW_LB: begin
                         draw = 1;
                         done = 1;
                         x_out = x_in;
                         y_out = y_in + 1;
                         ns = FINISH;
                         end
                FINISH:  if (~start)
                             ns = IDLE;
                         else
                             ns = FINISH;
            endcase
                
    end
    
    always_ff @(posedge clk)
        cs <= ns;
    
    
endmodule
