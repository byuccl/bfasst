

module ClockGenerator
        (
        input wire EXTERNAL_RESET_L,
        output reg CLOCKS_STABLE_H,
        input wire CLK_33MHz,

        output wire CLK_80MHz,
        output wire CLK_320MHz
        );

        localparam DLL_RESET_COUNTER_LEN = 4;

        wire CLK_80MHz_GENERATOR_LOCKED_H, CLK_320MHz_GENERATOR_LOCKED_H;
        reg [DLL_RESET_COUNTER_LEN-1:0] DLLResetCounter;
        reg CLOCK_GENERATOR_RESET_H;

        // This is a registered signal in order to avoid input setup time problems with all the flip flops that use it as a reset
        reg CLK_80MHz_GENERATOR_LOCKED_H_REG, CLK_320MHz_GENERATOR_LOCKED_H_REG, EXT_RESET_CLK_80MHz_L;
        always @(posedge CLK_80MHz) begin
                EXT_RESET_CLK_80MHz_L <= EXTERNAL_RESET_L;
                CLK_80MHz_GENERATOR_LOCKED_H_REG <= CLK_80MHz_GENERATOR_LOCKED_H;
               // CLK_320MHz_GENERATOR_LOCKED_H_REG <= CLK_320MHz_GENERATOR_LOCKED_H;
                CLOCKS_STABLE_H <= EXT_RESET_CLK_80MHz_L & DLLResetCounter[DLL_RESET_COUNTER_LEN-1] & CLK_80MHz_GENERATOR_LOCKED_H_REG;// & CLK_320MHz_GENERATOR_LOCKED_H_REG;
        end

        // This is a registered signal in order to avoid input setup time problems with all the flip flops that use it as a reset
        reg EXT_RESET_CLK_33MHz_L;
        // Make sure that the clocks stable signal is low right after FPGA configuration, and set the initial DLLResetCounter to 0
        //      right after configuration in order to simulate a reset button push.
        initial begin
                EXT_RESET_CLK_80MHz_L <= 1'b1;
                DLLResetCounter <= 0;
                CLOCKS_STABLE_H <= 1'b0;
                CLOCK_GENERATOR_RESET_H <= 1'b0;
                CLK_80MHz_GENERATOR_LOCKED_H_REG <= 1'b0;
              //  CLK_320MHz_GENERATOR_LOCKED_H_REG <= 1'b0;
        end
        always @(posedge(CLK_33MHz)) begin
                EXT_RESET_CLK_33MHz_L <= EXTERNAL_RESET_L;
                if (EXT_RESET_CLK_33MHz_L == 0) begin
                        DLLResetCounter <= 0;
                        CLOCK_GENERATOR_RESET_H <= 0;
                end
                else if (DLLResetCounter[DLL_RESET_COUNTER_LEN-1] == 1'b0) begin
                        DLLResetCounter <= DLLResetCounter + 1;
                        CLOCK_GENERATOR_RESET_H <= 1;
                end
                else
                        CLOCK_GENERATOR_RESET_H <= 0;
        end

        // 80MHz clock generation, based on page 91 of the Virtex 5 User Guide, and datasheet
        // Fin = 33MHz, Fpfdmin = 19MHz, Fpfdmax = 450MHz, Fvcomin = 400MHz, Fvcomax = 900MHz
        // Dmin = Fin/Fpfdmax = 1 (just satisfying the phase detector max frequency)
        // Dmax = Fin/Fpfdmin = 1 (if you divide input clock by more than one, 33 MHz will be below 19MHz)
        // Mmin = Fvcomin/Fin = 13 (round up to avoid hitting Fvcomin)
        // Mmax = Dmin*Fvcomax/Fin = 27 (round down to avoid hitting Fvcomax)
        // Mideal = Dmin*Fvcomax/Fin = 27
        // In my spreadsheet I found an optimum of Din = 1, M = 17, D0 = 4 gives 140.25MHz
        wire CLK_80MHz_FB, CLK_80MHz_Raw, CLK_80MHz_270_Raw;
        wire CLK_320MHz_Raw;

        defparam CLK_80MHz_Generator.CLKIN1_PERIOD = 25.0;
        defparam CLK_80MHz_Generator.DIVCLK_DIVIDE = 1;

        // 80 MHz
        defparam CLK_80MHz_Generator.CLKFBOUT_MULT_F = 16.0;
        defparam CLK_80MHz_Generator.CLKOUT0_DIVIDE_F = 16.0;

        // 320 MHz
        defparam CLK_80MHz_Generator.CLKOUT1_DIVIDE = 4;

	MMCM_BASE CLK_80MHz_Generator (
	.CLKFBOUT(CLK_80MHz_FB), // 1-bit MMCM Feedback clock output
	.CLKFBOUTB(), // 1-bit Inverted MMCM feedback clock output
	.CLKOUT0(CLK_80MHz_Raw), // 1-bit MMCM clock output 0
	.CLKOUT0B(), // 1-bit Inverted MMCM clock output 0
	.CLKOUT1(CLK_320MHz_Raw), // 1-bit MMCM clock output 1
	.CLKOUT1B(), // 1-bit Inverted MMCM clock output 1
	.CLKOUT2(), // 1-bit MMCM clock output 2
	.CLKOUT2B(), // 1-bit Inverted MMCM clock output 2
	.CLKOUT3(), // 1-bit MMCM clock output 3
	.CLKOUT3B(), // 1-bit Inverted MMCM clock output 3
	.CLKOUT4(), // 1-bit MMCM clock output 4
	.CLKOUT5(), // 1-bit MMCM clock output 5, not used if CLKOUT0 is not an integer
	.CLKOUT6(), // 1-bit MMCM clock output 6, not used if CLKFBOUT_MULT is not an integer
	.LOCKED(CLK_80MHz_GENERATOR_LOCKED_H), // 1-bit MMC locked signal
	.CLKFBIN(CLK_80MHz_FB), // 1-bit Feedback clock pin to the MMCM
	.CLKIN1(CLK_33MHz), // 1-bit Reference clock pin 1 to the MMCM
	.PWRDWN(1'b0), // 1-bit Power down
	.RST(CLOCK_GENERATOR_RESET_H) // 1-bit MMCM global reset pin
	);

       /* PLL_BASE CLK_80MHz_Generator (
                .RST(CLOCK_GENERATOR_RESET_H),  // Just use the first SRAM clock reset

                .CLKIN(CLK_33MHz),
                .CLKFBIN(CLK_80MHz_FB),

                .CLKOUT0(CLK_80MHz_Raw),
                .CLKOUT1(),
                .CLKOUT2(),
                .CLKOUT3(),
                .CLKOUT4(),
                .CLKOUT5(),
                .CLKFBOUT(CLK_80MHz_FB),

                .LOCKED(CLK_80MHz_GENERATOR_LOCKED_H)
        );*/
        BUFG CLK_80MHz_Buffer ( .I(CLK_80MHz_Raw), .O(CLK_80MHz) );
        BUFG CLK_320MHz_Buffer ( .I(CLK_320MHz_Raw), .O(CLK_320MHz) );
        // DDR2 200MHz clock, similar to above
        // From the spreadsheet Din = 1, M = 25, D0 = 4 gives 206.25MHz
        // From the spreadsheet Din = 1, M = 24, D0 = 4 gives 198.0MHz

       /* defparam CLK_320MHz_Generator.CLKIN_PERIOD = 25;
        defparam CLK_320MHz_Generator.DIVCLK_DIVIDE = 1;

	// 333.33 MHz
        defparam CLK_320MHz_Generator.CLKFBOUT_MULT = 16;
        defparam CLK_320MHz_Generator.CLKOUT0_DIVIDE = 2;
      
        defparam CLK_80MHz_Generator.CLKIN1_PERIOD = 25.0;
        defparam CLK_80MHz_Generator.DIVCLK_DIVIDE = 1;

	PLL_BASE CLK_320MHz_Generator (
                .RST(CLOCK_GENERATOR_RESET_H),  // Just use the first SRAM clock reset

                .CLKIN(CLK_33MHz),
                .CLKFBIN(CLK_320MHz_FB),

                .CLKOUT0(CLK_320MHz_Raw),
                .CLKOUT1(),
                .CLKOUT2(),
                .CLKOUT3(),
                .CLKOUT4(),
                .CLKOUT5(),
                .CLKFBOUT(CLK_320MHz_FB),

                .LOCKED(CLK_320MHz_GENERATOR_LOCKED_H)
        );*/




endmodule




