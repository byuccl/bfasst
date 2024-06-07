/****************************************************************************
            Fetch Unit
op
  0  Conditional PC write
  1  UnConditional PC write

****************************************************************************/

module ifetch(clk,resetn,
        en,
        squashn,
        we,
        op,
        load,
        load_data,

        pc_out,
        next_pc,

  boot_iaddr, 
  boot_idata, 
  boot_iwe,

        opcode,
        rs,
        rt,
        rd,
        sa,
        offset,
        instr_index,
        func,
        instr);

parameter PC_WIDTH=30;
parameter I_DATAWIDTH=32;
parameter I_ADDRESSWIDTH=8;
parameter I_SIZE=64;

input [31:0] boot_iaddr;
input [31:0] boot_idata;
input boot_iwe;

input clk;
input resetn;
input en;     // PC increment enable
input we;     // PC write enable
input squashn;// squash fetch
input op;     // determines if conditional or unconditional branch
input load;
input [I_DATAWIDTH-1:0] load_data;
output [I_DATAWIDTH-1:0] pc_out;   // output pc + 1 shifted left 2 bits
output [PC_WIDTH-1:0] next_pc;
output [31:26] opcode;
output [25:21] rs;
output [20:16] rt;
output [15:11] rd;
output [10:6] sa;
output [15:0] offset;
output [25:0] instr_index;
output [5:0] func;
output [I_DATAWIDTH-1:0] instr;


wire [PC_WIDTH-1:0] pc_plus_1;
wire [PC_WIDTH-1:0] pc;
wire ctrl_load;
wire out_of_sync;

assign ctrl_load=(load&~op|op);

lpm_counter pc_register(
        .data(load_data[I_DATAWIDTH-1:2]),
        .clock(clk),
        .clk_en(en|we),
        .cnt_en((~ctrl_load)&~out_of_sync),
        .aset(~resetn),
        .sload(ctrl_load),

        .updown(1'b0), .cin(1'b0), .sset(1'b0), .sclr(1'b0), .aclr(1'b0), .aload(1'b0), 
        .eq(1'b0), .cout(1'b0),
        .q(pc));

/****** Re-synchronize for case:
 * en=0 && we=1  ->  pc_register gets updated but not imem address
 *
 * Solution: stall pc_register and load memory address by changing 
 * incrementer to increment by 0
 *******/
register sync_pcs_up( (we&~en&squashn), clk, resetn,en|we, out_of_sync);
  defparam sync_pcs_up.WIDTH=1;



    RAMB36E1 #(
        .DOA_REG(0),
        .DOB_REG(0),
        .SRVAL_A(36'h0),
        .SRVAL_B(36'h0),
        .WRITE_MODE_A("WRITE_FIRST"),
        .WRITE_MODE_B("WRITE_FIRST")
    )
imem (
    .DOADO(instr),                      // Data output for port A
    .DOPADOP(),                         // Parity output for port A (optional, not used)
    .DOBDO(),                           // Data output for port B (optional, not used)
    .DOPBDOP(),                         // Parity output for port B (optional, not used)
    .ADDRARDADDR({next_pc[I_ADDRESSWIDTH-1:0], 2'b00}), // Address for port A (with 2 LSBs as 0)
    .CLKARDCLK(clk),                    // Clock for port A
    .ENARDEN(en | ~squashn | ~resetn),  // Enable for port A
    .REGCEAREGCE(1'b0),                 // Output register enable for port A (unused)
    .RSTRAMARSTRAM(~resetn),            // Reset for port A (active low)
    .RSTREGARSTREG(1'b0),               // Output register reset for port A (unused)
    .WEA(1'b0),                         // Write enable for port A (unused)
    .DIADI(1'b0),                       // Data input for port A (unused)
    .DIPADIP(),                         // Parity input for port A (optional, not used)
    .ADDRBWRADDR(16'b1),  // Address for port B (with 2 LSBs as 0)
    .CLKBWRCLK(clk),                    // Clock for port B
    .ENBWREN(boot_iwe),                 // Enable for port B
    .REGCEB(1'b0),                      // Output register enable for port B (unused)
    .RSTRAMB(1'b0),                     // Reset for port B (unused)
    .RSTREGB(1'b0),                     // Output register reset for port B (unused)
    .WEBWE({4{boot_iwe}}),              // Write enable for port B (4-bit wide, as it is 36Kb RAM)
    .DIBDI(boot_idata),                 // Data input for port B
    .DIPBDIP()                          // Parity input for port B (optional, not used)
);


// altsyncram  imem (
//    .clock0 (clk),
//    .clocken0 (en|~squashn|~resetn),
//    .clock1 (clk),                            
//    .clocken1 (boot_iwe),                      
//    `ifdef TEST_BENCH
//    .aclr0(~resetn), 
//    `endif
//    .address_a (next_pc[I_ADDRESSWIDTH-1:0]),
//    .wren_b (boot_iwe), .data_b (boot_idata), .address_b (boot_iaddr), 
//    .wren_a (1'b0), .rden_b (1'b0), .data_a (1'b0), 
//    .aclr1 (1'b0), .byteena_a (1'b0),
//    .addressstall_a (1'b0), .addressstall_b (1'b0), .q_b (1'b0),
//    .q_a (instr)
//    );


        
wire dummy;

assign {dummy,pc_plus_1} = pc + {1'b0,~out_of_sync};
assign pc_out={pc_plus_1,2'b0};

assign next_pc = ctrl_load ? load_data[I_DATAWIDTH-1:2] : pc_plus_1;

assign opcode=instr[31:26];
assign rs=instr[25:21];
assign rt=instr[20:16];
assign rd=instr[15:11];
assign sa=instr[10:6];
assign offset=instr[15:0]; 
assign instr_index=instr[25:0];
assign func=instr[5:0];

endmodule
