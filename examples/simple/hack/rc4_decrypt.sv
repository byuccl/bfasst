module rc4_decrypt #(
    parameter BYTES_LEN = 16
) (
    input wire logic                                        clk,        // Clock
    input wire logic                                        reset,      // Active-high reset
    input wire logic                                        enable,     // Start encryption/decryption
    input wire logic    [23:0]                              key,        // 3 byte key
    input wire logic    [(BYTES_LEN * 8) - 1:0]             bytes_in,   // byte stream in
    output logic        [(BYTES_LEN * 8) - 1:0]             bytes_out,  // byte stream out
    output logic                                            done        // Active-high done 
);

    typedef enum {S_INIT, S_LOOP1, 
                    S_LOOP2_readSi, S_LOOP2_readSj, S_LOOP2_write, 
                    S_LOOP3_init, S_LOOP3_readSi, S_LOOP3_readSj, S_LOOP3_writeSi, S_LOOP3_writeSj, S_LOOP3_readK,
                    S_update_text_out,
                    S_DONE} StateType;
    StateType cs;


    logic   [7:0]   i;                          // i Variable register
    logic   [7:0]   j;                          // j Variable registers
    logic   [7:0]   j_calc;                     // Combinational-logic calculate of j variable (LOOP2)
    
    // Signals to access dual-port S[] array
    logic   [7:0]   ram_addr_a;
    logic   [7:0]   ram_addr_b;
    logic ram_we_a;
    logic ram_we_b;
    logic   [7:0]   ram_data_in_a;
    logic   [7:0]   ram_data_in_b;
    logic   [7:0]   ram_data_out_a;
    logic   [7:0]   ram_data_out_b;

    logic   [7:0]   Si_saved;                   // Register to save S[i] read value
    logic   [7:0]   Sj_saved;                   // Register to save S[j] read value
    logic   [7:0]   i_calc_loop3;               // Combinational logic to calculate i variable (LOOP3)
    logic   [7:0]   j_calc_loop3;               // Combinational logic to calculate j variable (LOOP3)
    logic   [7:0]   K_lookup;                   // Address to lookup K-value: (S[i] + S[j])
    
    logic   [31:0]  msg_byte_idx;               // Index to count which byte of input stream is being processed.
                                                // The most significant byte is processed first.  

    ////////////////////////////// Outputs //////////////////////////////////////
    always_ff @(posedge clk) begin
        if (cs == S_update_text_out) begin
            bytes_out[msg_byte_idx * 8 +: 8] <= bytes_in[msg_byte_idx * 8 +: 8] ^ ram_data_out_a;
        end
    end

   
    ////////////////////////////// STATE MACHINE ////////////////////////////////

    always_ff @(posedge clk) begin    
        done <= 1'b0;
        if (reset) begin
            cs <= S_INIT;
        end else begin
            case(cs) 
                S_INIT:
                    if (enable)
                        cs <= S_LOOP1;
                S_LOOP1:
                    if (i == 254)
                        cs <= S_LOOP2_readSi;
                S_LOOP2_readSi:
                    cs <= S_LOOP2_readSj;
                S_LOOP2_readSj:
                    cs <= S_LOOP2_write;
                S_LOOP2_write:
                    if (i == 255)
                        cs <= S_LOOP3_init;
                    else    
                        cs <= S_LOOP2_readSi;
                S_LOOP3_init:
                    cs <= S_LOOP3_readSi;
                S_LOOP3_readSi:
                    cs <= S_LOOP3_readSj;
                S_LOOP3_readSj:
                    cs <= S_LOOP3_writeSi;
                S_LOOP3_writeSi:
                    cs <= S_LOOP3_writeSj;
                S_LOOP3_writeSj:
                    cs <= S_LOOP3_readK;
                S_LOOP3_readK:
                    cs <= S_update_text_out;
                S_update_text_out: begin
                    if (msg_byte_idx == 0) begin
                        cs <= S_DONE;
                        done <= 1'b1;
                    end else begin
                        cs <= S_LOOP3_readSi;
                    end
                end
                S_DONE:
                    if (!enable)
                        cs <= S_INIT;
            endcase
        end
    end

    ////////////////////////////// Datapath variables ////////////////////////////////

    // Update i, j and curent byte index (msg_byte_idx)
    always_ff @(posedge clk) begin
        case(cs)
        S_INIT: begin
            i <= 8'b0;
            j <= 8'b0;            
        end
        S_LOOP1: begin 
            i <= i + 2;
        end
        S_LOOP2_readSj: begin
            j <= j_calc;      
        end
        S_LOOP2_write: begin
            i <= i + 1;
        end
        S_LOOP3_init: begin
            i <= 0;
            j <= 0;
            msg_byte_idx <= (BYTES_LEN - 1);
        end
        S_LOOP3_readSi: begin
            i <= i_calc_loop3;
        end
        S_LOOP3_readSj: begin
            j <= j_calc_loop3;
        end
        S_update_text_out: begin
            msg_byte_idx <= msg_byte_idx - 1;
        end
        endcase
    end

    // Save S[i] and S[j] values read from S[] memory
    always_ff @(posedge clk) begin
        if (cs == S_LOOP2_readSj)
            Si_saved <= ram_data_out_a;
        if (cs == S_LOOP3_readSj)
            Si_saved <= ram_data_out_a;
        if (cs == S_LOOP3_writeSi)
            Sj_saved <= ram_data_out_a;
    end

    assign i_calc_loop3 = i + 1;
    assign j_calc = j + ram_data_out_a + key[(i % 3) * 8 +: 8];
    assign j_calc_loop3 = (j + ram_data_out_a);
    assign K_lookup = Si_saved + Sj_saved;

    // Signals to access S[] memory
    always_comb begin
        ram_addr_a = 8'bxxxxxxxx;
        ram_addr_b = 8'bxxxxxxxx;
        ram_data_in_a = 8'bxxxxxxxx;
        ram_data_in_b = 8'bxxxxxxxx;
        ram_we_a = 0;
        ram_we_b = 0;
        case(cs)
            S_LOOP1: begin
                ram_we_a = 1;
                ram_we_b = 1;
                ram_addr_a = i;
                ram_addr_b = i + 1;
                ram_data_in_a = i;
                ram_data_in_b = i + 1;
            end
            S_LOOP2_readSi: begin
                ram_addr_a = i;
            end
            S_LOOP2_readSj: begin
                ram_addr_a = j_calc;
            end
            S_LOOP2_write: begin
                ram_we_a = 1;
                ram_addr_a = i;
                ram_data_in_a = ram_data_out_a;
               
                ram_we_b = 1;
                ram_addr_b = j;
                ram_data_in_b = Si_saved;
            end
            S_LOOP3_readSi: begin
                ram_addr_a = i_calc_loop3;
            end
            S_LOOP3_readSj: begin
                ram_addr_a = j_calc_loop3;
            end
            S_LOOP3_writeSi: begin
                ram_we_a = 1;
                ram_addr_a = i;
                ram_data_in_a = ram_data_out_a;
            end
            S_LOOP3_writeSj: begin
                ram_we_a = 1;
                ram_addr_a = j;
                ram_data_in_a = Si_saved;
            end
            S_LOOP3_readK: begin
                ram_addr_a = K_lookup;
            end
        endcase
    end

    dual_port_ram #(.ADDR_WIDTH(8), .DATA_WIDTH(8)) ram_inst (
        .clk_a(clk),
        .clk_b(clk),
        .en_a(1'b1),
        .en_b(1'b1),
        .we_a(ram_we_a),
        .we_b(ram_we_b),
        .addr_a(ram_addr_a),
        .addr_b(ram_addr_b),
        .data_in_a(ram_data_in_a),
        .data_in_b(ram_data_in_b),
        .data_out_a(ram_data_out_a),
        .data_out_b(ram_data_out_b)
    );

endmodule


module dual_port_ram #(
    parameter ADDR_WIDTH=10,
    parameter DATA_WIDTH=32
)(
    input wire logic clk_a,
    input wire logic clk_b,
    input wire logic en_a,
    input wire logic en_b,
    input wire logic we_a,
    input wire logic we_b,
    input wire logic    [ADDR_WIDTH-1:0]    addr_a,
    input wire logic    [ADDR_WIDTH-1:0]    addr_b,
    input wire logic    [DATA_WIDTH-1:0]    data_in_a,
    input wire logic    [DATA_WIDTH-1:0]    data_in_b,
    output logic        [DATA_WIDTH-1:0]    data_out_a,
    output logic        [DATA_WIDTH-1:0]    data_out_b
);

logic   [DATA_WIDTH-1:0]    ram [(2**ADDR_WIDTH)-1:0];

always_ff @(posedge clk_a) begin
    if (en_a) begin
        if (we_a)
            ram[addr_a] <= data_in_a;
        data_out_a <= ram[addr_a];
    end
end

always @(posedge clk_b) begin 
    if (en_a)
        if (we_b)
            ram[addr_b] <= data_in_b;
        data_out_b <= ram[addr_b];
    end
endmodule