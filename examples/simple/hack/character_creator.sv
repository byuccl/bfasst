module character_creator # (parameter MAX_CHARS = 16)(
    input wire logic                            clk,        // Clock
    input wire logic                            reset,      // Active-high reset
    input wire logic                            enable,     // Start drawing
    output logic                                done,       // Done drawing
    output logic                                tx,         // Serial out
    input wire logic    [(MAX_CHARS * 8) - 1:0] string_in   // ASCII character string to draw
                                                            // MSB is drawn first
);
 
    logic clrCnt, incCnt, send, sent;
    logic[3:0] cnt;
    logic[7:0] din;

    // State Machine 
    typedef enum logic[1:0] {ST_WAIT, ST_WAIT_SENT, ST_SENT, ST_DONE, ERR='X} StateType;
    StateType cs, ns;

    assign din =    (cnt==0)?string_in[127:120]:
                    (cnt==1)?string_in[119:112]:
                    (cnt==2)?string_in[111:104]:
                    (cnt==3)?string_in[103:96]:
                    (cnt==4)?string_in[95:88]:
                    (cnt==5)?string_in[87:80]:
                    (cnt==6)?string_in[79:72]:
                    (cnt==7)?string_in[71:64]:
                    (cnt==8)?string_in[63:56]:
                    (cnt==9)?string_in[55:48]:
                    (cnt==10)?string_in[47:40]:
                    (cnt==11)?string_in[39:32]:
                    (cnt==12)?string_in[31:24]:
                    (cnt==13)?string_in[23:16]:
                    (cnt==14)?string_in[15:8]:
                              string_in[7:0];

    ////////////////////// Counter ////////////////////
    always_ff @(posedge clk)
        if (clrCnt)
                cnt <= 0;
        else if (incCnt)
            cnt <= cnt + 1;
    
    ////////////////////////////////// State Machine //////////////////////////////////
    always_ff @(posedge clk) 
        cs <= ns;

    always_comb begin
        ns = ERR;
        send = 0;
        clrCnt = 0;
        incCnt = 0;
        done = 0;
        if (reset)
            ns = ST_WAIT;
        else case (cs)
            ST_WAIT:  begin
                clrCnt = 1;
                if (enable)
                    ns = ST_WAIT_SENT;
                else
                    ns = ST_WAIT;
            end
            ST_WAIT_SENT:  begin
                send = 1;
                if (sent)
                    ns = ST_SENT;
                else
                    ns = ST_WAIT_SENT;
            end
            ST_SENT:  begin
                if (~sent && cnt != 15) begin
                    incCnt = 1;
                    ns = ST_WAIT_SENT;
                end
                else if (~sent && cnt == 15)
                    ns = ST_DONE;
                else
                    ns = ST_SENT;
            end
            ST_DONE:  begin
                done = 1;
                if (~enable)
                    ns = ST_WAIT;
                else
                    ns = ST_DONE;
            end
            default:
                ns = ERR;
        endcase
    end


    u_t_x samantha(.clk(clk), .rst(reset), .confirmation_send(send), .dat_incoming(din), .confirmation_sent(sent), .out_serial(tx));
    
endmodule