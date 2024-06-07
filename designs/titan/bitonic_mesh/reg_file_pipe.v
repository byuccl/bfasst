/****************************************************************************
          Register File

   - Has two read ports (a and b) and one write port (c)
   - sel chooses the register to be read/written
****************************************************************************/
module reg_file(clk,resetn, 
	a_reg, a_readdataout, a_en,
	b_reg, b_readdataout, b_en,
	c_reg, c_writedatain, c_we);

parameter WIDTH=32;
parameter NUMREGS=32;
parameter LOG2NUMREGS=5;

input clk;
input resetn;

input a_en;
input b_en;

input [LOG2NUMREGS-1:0] a_reg,b_reg,c_reg;
output [WIDTH-1:0] a_readdataout, b_readdataout;
input [WIDTH-1:0] c_writedatain;
input c_we;

    RAMB36E1 #(
        .DOA_REG(0),
        .DOB_REG(0),
        .SRVAL_A(36'h0),
        .SRVAL_B(36'h0),
        .WRITE_MODE_A("WRITE_FIRST"),
        .WRITE_MODE_B("WRITE_FIRST")
    ) reg_file1 (
    .DOADO(),                           // Data output for port A (unused)
    .DOPADOP(),                         // Parity output for port A (optional, not used)
    .DOBDO(a_readdataout),              // Data output for port B
    .DOPBDOP(),                         // Parity output for port B (optional, not used)
    .ADDRARDADDR({13'b0, c_reg[LOG2NUMREGS-1:0], 2'b00}), // Address for port A (with upper bits zeroed)
    .CLKARDCLK(clk),                    // Clock for port A
    .ENARDEN(c_we & |c_reg),            // Enable for port A
    .REGCEAREGCE(1'b0),                 // Output register enable for port A (unused)
    .RSTRAMARSTRAM(1'b0),               // Reset for port A (unused)
    .RSTREGARSTREG(1'b0),               // Output register reset for port A (unused)
    .WEA(4'b1111),                      // Write enable for port A (4-bit wide, always enabled when writing)
    .DIADI(c_writedatain),              // Data input for port A
    .DIPADIP(4'b0),                     // Parity input for port A (optional, not used)
    .ADDRBWRADDR({16'b1}), // Address for port B (with upper bits zeroed)
    .CLKBWRCLK(clk),                    // Clock for port B
    .ENBWREN(a_en),                     // Enable for port B
    .REGCEB(1'b0),                      // Output register enable for port B (unused)
    .RSTRAMB(1'b0),                     // Reset for port B (unused)
    .RSTREGB(1'b0),                     // Output register reset for port B (unused)
    .WEBWE(4'b0),                       // Write enable for port B (not used)
    .DIBDI(32'b0),                      // Data input for port B (not used)
    .DIPBDIP(4'b0)                      // Parity input for port B (optional, not used)
);

    RAMB36E1 #(
        .DOA_REG(0),
        .DOB_REG(0),
        .SRVAL_A(36'h0),
        .SRVAL_B(36'h0),
        .WRITE_MODE_A("WRITE_FIRST"),
        .WRITE_MODE_B("WRITE_FIRST")
    ) reg_file2 (
    .DOADO(),                           // Data output for port A (unused)
    .DOPADOP(),                         // Parity output for port A (optional, not used)
    .DOBDO(b_readdataout),              // Data output for port B
    .DOPBDOP(),                         // Parity output for port B (optional, not used)
    .ADDRARDADDR({13'b0, c_reg[LOG2NUMREGS-1:0], 2'b00}), // Address for port A (with upper bits zeroed)
    .CLKARDCLK(clk),                    // Clock for port A
    .ENARDEN(c_we & |c_reg),            // Enable for port A
    .REGCEAREGCE(1'b0),                 // Output register enable for port A (unused)
    .RSTRAMARSTRAM(1'b0),               // Reset for port A (unused)
    .RSTREGARSTREG(1'b0),               // Output register reset for port A (unused)
    .WEA(4'b1111),                      // Write enable for port A (4-bit wide, always enabled when writing)
    .DIADI(c_writedatain),              // Data input for port A
    .DIPADIP(4'b0),                     // Parity input for port A (optional, not used)
    .ADDRBWRADDR(16'b1), // Address for port B (with upper bits zeroed)
    .CLKBWRCLK(clk),                    // Clock for port B
    .ENBWREN(b_en),                     // Enable for port B
    .REGCEB(1'b0),                      // Output register enable for port B (unused)
    .RSTRAMB(1'b0),                     // Reset for port B (unused)
    .RSTREGB(1'b0),                     // Output register reset for port B (unused)
    .WEBWE(4'b0),                       // Write enable for port B (not used)
    .DIBDI(32'b0),                      // Data input for port B (not used)
    .DIPBDIP(4'b0)                      // Parity input for port B (optional, not used)
);

endmodule

