/*
 fifo with independent clock for read and write port.
 */

module xfifo_sc_2clk (
    clk_wr, clk_rd,
    rst,
    din,
    wr_en,
    full,
    wr_ack,
    overflow,
    prog_full,
    dout,
    rd_en,
    empty,
    valid,
    underflow,
    prog_empty
);

  parameter [8:0] data_width = 9'd8;    // Data bus width
  parameter [8:0] addr_width = 9'd8;   // Address bus width, determines fifo size by evaluating 2^addr_width
  parameter [8:0] prog_thresh = 9'd1;  // Programmable threshold constant for prog_empty and prog_full

  input clk_wr;                        // Write clock
  input clk_rd;                        // Read clock
  input rst;                           // Low-active sync master reset

  /* read port */
  output reg [data_width-1:0] dout;     // Data output
  input rd_en;                         // Read enable
  output reg empty;                    // Asserted if fifo is empty; no additional reads can be performed
  output reg valid;                    // Valid (read acknowledge): indicates rd_en was asserted during the previous clock cycle, and data was successfully read from fifo and placed on dout
  output reg underflow;                // Underflow (read error): indicates rd_en was asserted during the previous clock cycle, but no data was read from fifo because the fifo was empty
  output reg prog_empty;               // Indicates the fifo has prog_thresh entries, or less. The threshold for asserting prog_empty is prog_thresh

  /* write port */
  input [data_width-1:0] din;           // Data input
  input wr_en;                         // Write enable
  output reg full;                     // Asserted if fifo is full; no additional writes can be performed
  output reg overflow;                 // Overflow (write error): indicates wr_en was asserted during the previous clock cycle, but no data was written to fifo because the fifo was full
  output reg wr_ack;                   // Write acknowledge: indicates wr_en was asserted during the previous clock cycle, and data was successfully written to fifo
  output reg prog_full;                // Indicates the fifo has prog_thresh free entries or less left. The threshold for asserting prog_full is 2^addr_width - prog_thresh

  /* Writing when the fifo is full, or reading while the fifo is empty, does not destroy the contents of the fifo. */

  // Read and write addresses
  (* ram_style = "registers" *) reg [addr_width:0] wr_addr;
  (* ram_style = "registers" *) reg [addr_width:0] rd_addr;
  (* ram_style = "registers" *) reg [addr_width:0] next_wr_addr;
  (* ram_style = "registers" *) reg [addr_width:0] next_rd_addr;

  always @(posedge clk_wr)
    if (wr_en && ~full) next_wr_addr <= wr_addr + 1'b1;
    else next_wr_addr <= wr_addr;

  always @(posedge clk_rd)
    if (rd_en && ~empty) next_rd_addr <= rd_addr + 1'b1;
    else next_rd_addr <= rd_addr;

  always @(posedge clk_wr)
    if (~rst) wr_addr <= 1'b0;
    else wr_addr <= next_wr_addr;

  always @(posedge clk_rd)
    if (~rst) rd_addr <= 1'b0;
    else rd_addr <= next_rd_addr;

  // Empty and full
  always @(posedge clk_rd)
    if (~rst) empty <= 1'b1;
    else empty <= (next_wr_addr == next_rd_addr);

  always @(posedge clk_wr)
    if (~rst) full <= 1'b0;
    else full <= (next_wr_addr[addr_width-1:0] == next_rd_addr[addr_width-1:0]) && (next_wr_addr[addr_width] != next_rd_addr[addr_width]);

  // Valid and wr_ack
  always @(posedge clk_rd)
    if (~rst) valid <= 1'b0;
    else valid <= rd_en && ~empty;

  always @(posedge clk_wr)
    if (~rst) wr_ack <= 1'b0;
    else wr_ack <= wr_en && ~full;

  // Underflow and overflow
  always @(posedge clk_rd)
    if (~rst) underflow <= 1'b0;
    else underflow <= rd_en && empty;

  always @(posedge clk_wr)
    if (~rst) overflow <= 1'b0;
    else overflow <= wr_en && full;

  // Prog_empty and prog_full
  wire [addr_width:0] next_count = next_wr_addr - next_rd_addr;
  wire [addr_width:0] lower_threshold = prog_thresh + 1'b1;
  wire [addr_width:0] max_count = 1'b1 << addr_width;
  wire [addr_width:0] upper_threshold = max_count - lower_threshold;

  always @(posedge clk_rd)
    if (~rst) prog_empty <= 1'b1;
    else prog_empty <= (next_count < lower_threshold);

  always @(posedge clk_wr)
    if (~rst) prog_full <= 1'b0;
    else prog_full <= (next_count > upper_threshold);

  // Dual-port RAM w/registered output
  (* ram_style = "registers" *) reg [data_width-1:0] ram[(1 << addr_width)-1:0];

  always @(posedge clk_rd)
    if (~rst) dout <= 0;
    else if (~empty) dout <= ram[rd_addr[addr_width-1:0]];
    else dout <= dout;

  always @(posedge clk_wr)
    if (wr_en && ~full) ram[wr_addr[addr_width-1:0]] <= din;

endmodule
