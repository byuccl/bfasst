`timescale 1ns / 1ps

// IP that controls the seven segment display using the buttons

module configurable_display(
    input clk,
    input reset,
    input [4:0] buttons,
    output [6:0] segments,
    output dot_point,
    output [7:0] anodes
    );
    
    // Mapping of button_value to 7-segment display
    reg [6:0] seven_seg_map [0:15] = {
        7'b1000000, // 0
        7'b1111001, // 1
        7'b0100100, // 2
        7'b0110000, // 3
        7'b0011001, // 4
        7'b0010010, // 5
        7'b0000010, // 6
        7'b1111000, // 7
        7'b0000000, // 8
        7'b0010000, // 9
        7'b0001000, // A
        7'b0000011, // b
        7'b1000110, // C
        7'b0100001, // d
        7'b0000110, // E
        7'b0001110  // F
    };
    
    reg [4:0] buttons_buf;
    
    always @(posedge clk)
        if (!reset) 
            buttons_buf <= 0;
        else 
            buttons_buf <= buttons;
           
            
    reg [4:0] final_button_values;
    
    
    // Copied from ChatGPT-4
    
    reg [4:0] button_buf_prev;
    reg [4:0] button_buf_stable;
    reg [4:0] button_buf_edge;
    reg [19:0] counters[4:0];
    
    integer i;
    
    localparam DEBOUNCE_COUNT = 1000000;
    
    always @(posedge clk) begin
        if (!reset) begin
            button_buf_prev <= 0;
            button_buf_stable <= 0;
            button_buf_edge <= 0;
            final_button_values <= 0;
            for (i = 0; i < 5; i = i + 1) begin
                counters[i] <= 0;
            end
        end else begin
            for (i = 0; i < 5; i = i + 1) begin
                if (buttons_buf[i] != button_buf_prev[i]) begin
                    counters[i] <= counters[i] + 1;
                    if (counters[i] >= DEBOUNCE_COUNT) begin
                        button_buf_edge[i] <= !button_buf_edge[i];
                        button_buf_stable[i] <= buttons_buf[i];
                        counters[i] <= 0;
                    end
                end else begin
                    counters[i] <= 0;
                end
            end
            final_button_values <= (button_buf_stable ^ button_buf_prev) & button_buf_edge;
            button_buf_prev <= button_buf_stable;
        end
    end
    
    // End copy
    
    reg [6:0] segments_buf;
    reg dot_point_buf;
    reg [7:0] anodes_buf;
    reg [3:0] values [0:7]; // The current numerical value of each digit on the display
    reg [2:0] selection;    // Which digit on the display is currently selected
    
    assign segments = segments_buf;
    assign dot_point = dot_point_buf;
    assign anodes = anodes_buf;
        
    // Cycle through which digit is selected
    always @(posedge clk)
        if (!reset || final_button_values == 5'b00001)
            selection <= 0;
        else if (final_button_values == 5'b00100 && selection != 7)
            selection <= selection + 1;
        else if (final_button_values == 5'b01000 && selection != 0)
            selection <= selection - 1;
        else
            selection <= selection;
    
    // Increment or decrement selected digit when buttons pressed
    always @(posedge clk)
        for (i = 0; i < 8; i = i + 1)
            if (!reset || final_button_values == 5'b00001)
                values[i] <= 0;
            else if (final_button_values == 5'b00010 && i == selection)   // Button up
                values[i] <= values[i] + 1;
            else if (final_button_values == 5'b10000 && i == selection)   // Button down
                values[i] <= values[i] - 1;
            else
                values[i] <= values[i];
                
    reg [15:0] display_cycle_counter;
    
    always @(posedge clk)
        if (!reset)
            display_cycle_counter <= 0;
        else
            display_cycle_counter <= display_cycle_counter + 1;
    
    // SEGMENT VALUES
    always @(posedge clk)
        if (!reset || final_button_values == 5'b00001)
            segments_buf <= seven_seg_map[0];
        else
            segments_buf <= seven_seg_map[values[display_cycle_counter[15:13]]];
    
    // DOT POINT VALUE
    always @(posedge clk)
        if (!reset || final_button_values == 5'b00001)
            dot_point_buf <= 1;
        else if (display_cycle_counter[15:13] == selection)
            dot_point_buf <= 0;
        else
            dot_point_buf <= 1;
    
    // ANODE VALUES
    always @(posedge clk)
        if (!reset || final_button_values == 5'b00001)
            anodes_buf <= ~1;
        else
            anodes_buf <= ~(1 << display_cycle_counter[15:13]);
    

endmodule