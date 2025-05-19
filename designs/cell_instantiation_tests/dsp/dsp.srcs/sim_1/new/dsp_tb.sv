`timescale 1ns / 1ps

module dsp_tb;
    logic clk = 0;
    logic rst = 1;
    logic ce  = 1;

    logic [29:0] a;
    logic [17:0] b;
    logic [47:0] c;
    logic [47:0] p;

    // Clock generator: 100 MHz (10 ns period)
    always #5 clk = ~clk;

    // Instantiate the DUT (your DSP48E1 wrapper)
    dsp_mac_example dut (
        .clk(clk),
        .rst(rst),
        .ce(ce),
        .a(a),
        .b(b),
        .c(c),
        .p(p)
    );

    initial begin
        $display("Starting DSP48E1 simulation...");
        $dumpvars(0, dsp_tb);  // For waveform tools like GTKWave (if using .vcd)

        // Reset pulse
        #12;
        rst = 0;

        // Apply inputs
        a = 30'd100;
        b = 18'd3;
        c = 48'd5;

        // Wait for result
        repeat (5) @(posedge clk);
        $display("Result: P = %0d", p);

        #20;
        $finish;
    end
endmodule
