/******************************************************************************
            Data memory and interface

Operation table:

  load/store sign size1 size0    |   Operation
7     0       1     1     1      |      LB
5     0       1     0     1      |      LH
0     0       X     0     0      |      LW
3     0       0     1     1      |      LBU
1     0       0     0     1      |      LHU
11    1       X     1     1      |      SB
9     1       X     0     1      |      SH
8     1       X     0     0      |      SW

******************************************************************************/

module data_mem( clk, resetn, en, stalled,
                d_writedata,
                d_address,
                boot_daddr, boot_ddata, boot_dwe, 
                op,
                d_loadresult);

parameter D_ADDRESSWIDTH=32;

parameter DM_DATAWIDTH=32;
parameter DM_BYTEENAWIDTH=4;            // usually should be DM_DATAWIDTH/8
//parameter DM_ADDRESSWIDTH=16;         //Deepak commented
//parameter DM_SIZE=16384;              //Deepak commented

//Deepak : UnCommented to see why the processor is stopping after the first instruction
parameter DM_ADDRESSWIDTH=8;     //Deepak
parameter DM_SIZE=64;          //Deepak : Increased the size of memory

input clk;
input resetn;
input en;
output stalled;


input [31:0] boot_daddr;
input [31:0] boot_ddata;
input boot_dwe;

input [D_ADDRESSWIDTH-1:0] d_address;
input [4-1:0] op;
input [DM_DATAWIDTH-1:0] d_writedata;
output [DM_DATAWIDTH-1:0] d_loadresult;

wire [DM_BYTEENAWIDTH-1:0] d_byteena;
wire [DM_DATAWIDTH-1:0] d_readdatain;
wire [DM_DATAWIDTH-1:0] d_writedatamem;
wire d_write;
wire [1:0] d_address_latched;

assign d_write=op[3];
//assign d_write = d_write;//deepak
register d_address_reg(d_address[1:0],clk,1'b1,en,d_address_latched);
    defparam d_address_reg.WIDTH=2;
                
store_data_translator sdtrans_inst(
    .write_data(d_writedata),
    .d_address(d_address[1:0]),
    .store_size(op[1:0]),
    .d_byteena(d_byteena),
    .d_writedataout(d_writedatamem));

load_data_translator ldtrans_inst(
    .d_readdatain(d_readdatain),
    .d_address(d_address_latched[1:0]),
    .load_size(op[1:0]),
    .load_sign_ext(op[2]),
    .d_loadresult(d_loadresult));


    RAMB36E1 #(
        .DOA_REG(0),
        .DOB_REG(0),
        .SRVAL_A(36'h0),
        .SRVAL_B(36'h0),
        .WRITE_MODE_A("WRITE_FIRST"),
        .WRITE_MODE_B("WRITE_FIRST")
    )

dmem (
    .DOADO(d_readdatain),              // Data output for port A
    .DOPADOP(),                        // Parity output for port A (optional, not used)
    .DOBDO(),                          // Data output for port B (optional, not used)
    .DOPBDOP(),                        // Parity output for port B (optional, not used)
    .ADDRARDADDR({d_address[DM_ADDRESSWIDTH+2-1:2], 2'b00}), // Address for port A (with 2 LSBs as 0)
    .CLKARDCLK(clk),                   // Clock for port A
    .ENARDEN(d_write & en & (~d_address[31])),  // Enable for port A
    .REGCEAREGCE(1'b0),                // Output register enable for port A (unused)
    .RSTRAMARSTRAM(~resetn),           // Reset for port A (active low)
    .RSTREGARSTREG(1'b0),              // Output register reset for port A (unused)
    .WEA(d_byteena),                   // Write enable for port A (byte enables)
    .DIADI(d_writedatamem),            // Data input for port A
    .DIPADIP(),                        // Parity input for port A (optional, not used)
    .ADDRBWRADDR({16'b1}), // Address for port B (with 2 LSBs as 0)
    .CLKBWRCLK(clk),                   // Clock for port B
    .ENBWREN(boot_dwe),                // Enable for port B
    .REGCEB(1'b0),                     // Output register enable for port B (unused)
    .RSTRAMB(1'b0),                    // Reset for port B (unused)
    .RSTREGB(1'b0),                    // Output register reset for port B (unused)
    .WEBWE({4{boot_dwe}}),             // Write enable for port B (4-bit wide, as it is 36Kb RAM)
    .DIBDI(boot_ddata),                // Data input for port B
    .DIPBDIP()                         // Parity input for port B (optional, not used)
);

  


// altsyncram  dmem (
//     .wren_a (d_write&en&(~d_address[31])),
//     .clock0 (clk),
//     .clocken0 (1'b0),
//     .clock1 (clk),
//     .clocken1 (boot_dwe),
//     `ifdef TEST_BENCH
//     .aclr0(~resetn), 
//     `endif
//     .byteena_a (d_byteena),
//     .address_a (d_address[DM_ADDRESSWIDTH+2-1:2]),
//     .data_a (d_writedatamem),
//     .wren_b (boot_dwe), .data_b (boot_ddata), .address_b (boot_daddr), 
//     .rden_b (1'b0), 
//     .aclr1 (1'b0),
//     .addressstall_a (1'b0), .addressstall_b (1'b0), .q_b (1'b0),
//     .q_a (d_readdatain)


    
// );  
//    defparam
//        dmem.intended_device_family = "Kintex", //Deepak changed from Stratix to Cyclone
//        dmem.width_a = DM_DATAWIDTH,
//        dmem.widthad_a = DM_ADDRESSWIDTH-2,
//        dmem.numwords_a = DM_SIZE,
//        dmem.width_byteena_a = DM_BYTEENAWIDTH,
//        dmem.operation_mode = "BIDIR_DUAL_PORT",
//        dmem.width_b = DM_DATAWIDTH,
//        dmem.widthad_b = DM_ADDRESSWIDTH-2,
//        dmem.numwords_b = DM_SIZE,
//        dmem.width_byteena_b = 1,
//        dmem.outdata_reg_a = "UNREGISTERED",
//        dmem.address_reg_b = "CLOCK1",
//        dmem.wrcontrol_wraddress_reg_b = "CLOCK1",
//        dmem.wrcontrol_aclr_a = "NONE",
//        dmem.address_aclr_a = "NONE",
//        dmem.outdata_aclr_a = "NONE",
//        dmem.byteena_aclr_a = "NONE",
//        dmem.byte_size = 8,
//        `ifdef TEST_BENCH
//          dmem.indata_aclr_a = "CLEAR0",
//          dmem.init_file = "data.rif",
//        `endif
//        `ifdef QUARTUS_SIM
//          dmem.init_file = "data.mif",
//          dmem.ram_block_type = "M4K",
//        `else
//          dmem.ram_block_type = "MEGARAM",
//        `endif
//        dmem.lpm_type = "altsyncram";
  
// 1 cycle stall state machine
onecyclestall staller(en&~d_write,clk,resetn,stalled);


endmodule



/****************************************************************************
          Store data translator
          - moves store data to appropriate byte/halfword 
          - interfaces with altera blockrams
****************************************************************************/
module store_data_translator(
    write_data,             // data in least significant position
    d_address,
    store_size,
    d_byteena,
    d_writedataout);        // shifted data to coincide with address
parameter WIDTH=32;

input [WIDTH-1:0] write_data;
input [1:0] d_address;
input [1:0] store_size;
output [3:0] d_byteena;
output [WIDTH-1:0] d_writedataout;

reg [3:0] d_byteena;
reg [WIDTH-1:0] d_writedataout;

always @(write_data or d_address or store_size)
begin
  
    case (store_size)
        2'b11:
            case(d_address[1:0])
                0: 
                begin 
                    d_byteena=4'b1000; 
                    d_writedataout={write_data[7:0],24'b0}; 
                end
                1: 
                begin 
                    d_byteena=4'b0100; 
                    d_writedataout={8'b0,write_data[7:0],16'b0}; 
                end
                2: 
                begin 
                    d_byteena=4'b0010; 
                    d_writedataout={16'b0,write_data[7:0],8'b0}; 
                end
                default: 
                begin 
                    d_byteena=4'b0001; 
                    d_writedataout={24'b0,write_data[7:0]}; 
                end
            endcase
        2'b01:
            case(d_address[1])
                0: 
                begin 
                    d_byteena=4'b1100; 
                    d_writedataout={write_data[15:0],16'b0}; 
                end
                default: 
                begin 
                    d_byteena=4'b0011; 
                    d_writedataout={16'b0,write_data[15:0]}; 
                end
            endcase
        default:
        begin
            d_byteena=4'b1111;
            d_writedataout=write_data;
        end
    endcase
end

endmodule

/****************************************************************************
          Load data translator
          - moves read data to appropriate byte/halfword and zero/sign extends
****************************************************************************/
module load_data_translator(
    d_readdatain,
    d_address,
    load_size,
    load_sign_ext,
    d_loadresult);
parameter WIDTH=32;

input [WIDTH-1:0] d_readdatain;
input [1:0] d_address;
input [1:0] load_size;
input load_sign_ext;
output [WIDTH-1:0] d_loadresult;

reg [WIDTH-1:0] d_loadresult;

always @(d_readdatain or d_address or load_size or load_sign_ext)
begin
    case (load_size)
        2'b11:
        begin
            case (d_address[1:0])
                0: d_loadresult[7:0]=d_readdatain[31:24];
                1: d_loadresult[7:0]=d_readdatain[23:16];
                2: d_loadresult[7:0]=d_readdatain[15:8];
                default: d_loadresult[7:0]=d_readdatain[7:0];
            endcase
            d_loadresult[31:8]={24{load_sign_ext&d_loadresult[7]}};
        end
        2'b01:
        begin
            case (d_address[1])
                0: d_loadresult[15:0]=d_readdatain[31:16];
                default: d_loadresult[15:0]=d_readdatain[15:0];
            endcase
            d_loadresult[31:16]={16{load_sign_ext&d_loadresult[15]}};
        end
        default:
            d_loadresult=d_readdatain;
    endcase
end

endmodule

