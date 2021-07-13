`default_nettype none
module hack_machine(
    input wire logic clk,
    input wire logic reset,
    input wire logic start,
    input wire logic ddpt,
    output logic [15:0] key_display,            // Only top 16 bits of key will be displayed
    output logic time_go,
    output logic dpt,
    output logic [127:0] plaintext_to_draw
    );
    
    logic enableDecrypter, decrypterDone, incrementKey, plaintext_is_ascii;
    logic [127:0] plaintext;
    logic [127:0] cyphertext;
    logic [23:0] key;
    
    // This is the text we will decrypt
    //assign cyphertext = 128'ha13a3ab3071897088f3233a58d6238bb;
    assign cyphertext = 128'h189f2800aac06ce4a74292bffe33fd2c;
    
    // Instantiation of the decrypter
    rc4_decrypt theDecrypter(
        clk, 
        reset, 
        enableDecrypter, 
        key, 
        cyphertext, 
        plaintext_to_draw, 
        decrypterDone
    );
    
    typedef enum logic [2:0] {wait_, decrypt_, check_, display_, end_, ERR='X} StateType;
    StateType ns, cs;
    
    // Increments the key while going from check_ state to decrypt_ state
    always_ff @(posedge clk)
        if (reset)
            key = 0;
        else if (incrementKey)
            key = key + 1;
    
    // key_display is assigned top 16 bits
    assign key_display = key[23:8];
    
    assign plaintext = plaintext_to_draw;
    
    // This logic checks if the text can be converted to A-Z, 0-9, or space in ASCII
    assign plaintext_is_ascii = ((plaintext[127:120] >= "A" && plaintext[127:120] <= "Z") || (plaintext[127:120] >= "0" && plaintext[127:120] <= "9") || (plaintext[127:120] == " ")) && 
                                ((plaintext[119:112] >= "A" && plaintext[119:112] <= "Z") || (plaintext[119:112] >= "0" && plaintext[119:112] <= "9") || (plaintext[119:112] == " ")) && 
                                ((plaintext[111:104] >= "A" && plaintext[111:104] <= "Z") || (plaintext[111:104] >= "0" && plaintext[111:104] <= "9") || (plaintext[111:104] == " ")) && 
                                ((plaintext[103:96] >= "A" && plaintext[103:96] <= "Z") || (plaintext[103:96] >= "0" && plaintext[103:96] <= "9") || (plaintext[103:96] == " ")) && 
                                ((plaintext[95:88] >= "A" && plaintext[95:88] <= "Z") || (plaintext[95:88] >= "0" && plaintext[95:88] <= "9") || (plaintext[95:88] == " ")) && 
                                ((plaintext[87:80] >= "A" && plaintext[87:80] <= "Z") || (plaintext[87:80] >= "0" && plaintext[87:80] <= "9") || (plaintext[87:80] == " ")) && 
                                ((plaintext[79:72] >= "A" && plaintext[79:72] <= "Z") || (plaintext[79:72] >= "0" && plaintext[79:72] <= "9") || (plaintext[79:72] == " ")) && 
                                ((plaintext[71:64] >= "A" && plaintext[71:64] <= "Z") || (plaintext[71:64] >= "0" && plaintext[71:64] <= "9") || (plaintext[71:64] == " ")) && 
                                ((plaintext[63:56] >= "A" && plaintext[63:56] <= "Z") || (plaintext[63:56] >= "0" && plaintext[63:56] <= "9") || (plaintext[63:56] == " ")) && 
                                ((plaintext[55:48] >= "A" && plaintext[55:48] <= "Z") || (plaintext[55:48] >= "0" && plaintext[55:48] <= "9") || (plaintext[55:48] == " ")) && 
                                ((plaintext[47:40] >= "A" && plaintext[47:40] <= "Z") || (plaintext[47:40] >= "0" && plaintext[47:40] <= "9") || (plaintext[47:40] == " ")) && 
                                ((plaintext[39:32] >= "A" && plaintext[39:32] <= "Z") || (plaintext[39:32] >= "0" && plaintext[39:32] <= "9") || (plaintext[39:32] == " ")) && 
                                ((plaintext[31:24] >= "A" && plaintext[31:24] <= "Z") || (plaintext[31:24] >= "0" && plaintext[31:24] <= "9") || (plaintext[31:24] == " ")) && 
                                ((plaintext[23:16] >= "A" && plaintext[23:16] <= "Z") || (plaintext[23:16] >= "0" && plaintext[23:16] <= "9") || (plaintext[23:16] == " ")) && 
                                ((plaintext[15:8] >= "A" && plaintext[15:8] <= "Z") || (plaintext[15:8] >= "0" && plaintext[15:8] <= "9") || (plaintext[15:8] == " ")) && 
                                ((plaintext[7:0] >= "A" && plaintext[7:0] <= "Z") || (plaintext[7:0] >= "0" && plaintext[7:0] <= "9") || (plaintext[7:0] == " "));
    
    // Codebreaker state machine
    always_comb
    begin
        ns = ERR;
        dpt = 0; // Moore output
        enableDecrypter = 0; // Moore output
        time_go = 0; // Moore output
        incrementKey = 0; // Mealy output
        
        if (reset)          // Reset is priority over all input signals
            ns = wait_;
        else
            case (cs)
                wait_: if (start)           // Waits for start to go high
                           ns = decrypt_;
                       else
                           ns = wait_;
                decrypt_: begin             // enableDecrypter goes high which causes the
                          enableDecrypter = 1;  // decrypter module to run. The stopwatch
                          time_go = 1;    // also runs in this state.
                          if (decrypterDone)
                              ns = check_;
                          else
                              ns = decrypt_;
                          end
                check_: begin               // checks if text is readable
                        time_go = 1;
                        if (plaintext_is_ascii)
                            ns = display_;
                        else
                        begin
                            incrementKey = 1;
                            ns = decrypt_;
                        end
                        end
                
                display_: begin             // dpt goes high causing CharDrawer and 
                          dpt = 1;   // BitmaptoVGA modules to draw text on screen.
                          if (ddpt)
                              ns = end_;
                          else
                              ns = display_;
                          end
                end_: if (reset)            // When it is done drawing it waits for the reset signal.
                          ns = wait_;
                      else
                          ns = end_;
            endcase                          
        
    end
    
    // Next state is loaded into current state
    always_ff @(posedge clk)
        cs <= ns;
    
    
    
endmodule



