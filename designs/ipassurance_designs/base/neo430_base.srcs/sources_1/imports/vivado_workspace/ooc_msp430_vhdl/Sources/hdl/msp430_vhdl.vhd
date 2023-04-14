-- MSP430 CPU core by Peter Szabo (peter.szb@gmail.com)
-- Uploaded to opencores.org
-- v0.1 - Feb. 2010 - synthesized on Altera Cyclone II FPGA, able to run software, but not verified

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity msp430_vhdl is
port (
	clk  : in std_logic;
	rst  : in std_logic;
	addr : out std_logic_vector(15 downto 1);
	din  : in std_logic_vector(15 downto 0);
	dout : out std_logic_vector(15 downto 0);
	rd   : out std_logic;
	wr   : out std_logic;
	lbe  : out std_logic;
	hbe  : out std_logic;
	irq  : in std_logic_vector(14 downto 0);
	iack : out std_logic_vector(14 downto 0);
	halt : in std_logic
);
end msp430_vhdl;

architecture rtl of msp430_vhdl is

-- single operand instructions (soi)
constant rrc  : std_logic_vector(2 downto 0) := "000";
constant swpb : std_logic_vector(2 downto 0) := "001";
constant rra  : std_logic_vector(2 downto 0) := "010";
constant sxt  : std_logic_vector(2 downto 0) := "011";
constant push : std_logic_vector(2 downto 0) := "100";
constant call : std_logic_vector(2 downto 0) := "101";
constant reti : std_logic_vector(2 downto 0) := "110";

-- jump instrucions
constant jnz  : std_logic_vector(2 downto 0) := "000";
constant jz   : std_logic_vector(2 downto 0) := "001";
constant jnc  : std_logic_vector(2 downto 0) := "010";
constant jc   : std_logic_vector(2 downto 0) := "011";
constant jn   : std_logic_vector(2 downto 0) := "100";
constant jge  : std_logic_vector(2 downto 0) := "101";
constant jl   : std_logic_vector(2 downto 0) := "110";
constant jmp  : std_logic_vector(2 downto 0) := "111";

-- double operand instructions (doi)
constant mov  : std_logic_vector(3 downto 0) := x"4";
constant add  : std_logic_vector(3 downto 0) := x"5";
constant addc : std_logic_vector(3 downto 0) := x"6";
constant subc : std_logic_vector(3 downto 0) := x"7";
constant sub  : std_logic_vector(3 downto 0) := x"8";
constant cmp  : std_logic_vector(3 downto 0) := x"9";
constant dadd : std_logic_vector(3 downto 0) := x"A";
constant bitx : std_logic_vector(3 downto 0) := x"B";
constant bic  : std_logic_vector(3 downto 0) := x"C";
constant bis  : std_logic_vector(3 downto 0) := x"D";
constant xorx : std_logic_vector(3 downto 0) := x"E";
constant andx : std_logic_vector(3 downto 0) := x"F";

type t_states is (
rd_code_p1,		-- fetch opcode phase 1
rd_code_p2,		-- fetch opcode phase 2

-- single operand instructions
soi_rd_bs,		-- read base address of operand (single op instr)
soi_rdwr_op,		-- read operand and write result (single op instr)

push_rd_bs,		-- read base address of operand (push, call)
push_rdwr,		-- read operand (push, call) and write to stack (push: operand, call: pc)

reti_popsr_p1,		-- read sr from stack (reti) phase 1 - required for more simple address output
reti_popsr_p2,		-- read sr from stack (reti) phase 2
reti_poppc,		-- read pc from stack (reti)

-- double operand instructions
doi_rd_srcbs,		-- read base address of src (double op instr)
doi_rd_src,		-- read src (double op instr)
doi_rd_dstbs,		-- read base address of dst (double op instr)
doi_rdwr_dst,		-- read dst and write result (double op instr)

-- interrupt
irq_init,		-- init interrupt : complete instruction (required when dst=sr and gie is affected), get irq source, ack irq
irq_pushpc,		-- push pc on stack
irq_pushsr,		-- push sr on stack
irq_rd_vct_p1,		-- read interrupt vector from table
irq_rd_vct_p2,		-- read interrupt vector from table

cpu_off			-- msp430_vhdl off (status register)
);

signal state : t_states;
signal nstate : t_states;

type t_register_array is array(natural range <>) of std_logic_vector(15 downto 0);
signal r : t_register_array(4 to 15);		-- registers 0..15
signal rrs : t_register_array(0 to 15);		-- registers read as src operands (single and double op instr)
signal rrd : t_register_array(0 to 15);		-- registers read as dst operands (double op instr only)

signal pc : std_logic_vector(15 downto 0);
signal sp : std_logic_vector(15 downto 0);
signal sr : std_logic_vector(15 downto 0);

constant cg1 : t_register_array(1 to 3) := ((x"0000"), (x"0004"), (x"0008"));
constant cg2 : t_register_array(0 to 3) := ((x"0000"), (x"0001"), (x"0002"), (x"FFFF"));

alias c is sr(0);
alias z is sr(1);
alias n is sr(2);
alias gie is sr(3);
alias cpuoff is sr(4);	-- stop msp430_vhdl when 1
alias oscoff is sr(5);
alias scg0 is sr(6);
alias scg1 is sr(7);
alias v is sr(8);

signal girq : std_logic;
signal irqaddr : std_logic_vector(15 downto 0);

signal s_addr : std_logic_vector(15 downto 0);
signal wr_code : std_logic;
signal wr_data : std_logic;
signal rd_code : std_logic;
signal rd_data : std_logic;

signal soi : std_logic;
signal doi : std_logic;
signal jmpi : std_logic;

signal code : std_logic_vector(15 downto 0);
signal r_code : std_logic_vector(15 downto 0);
signal bsaddr : std_logic_vector(15 downto 0);
signal ad : std_logic;
signal bw : std_logic;
signal as : std_logic_vector(1 downto 0);
signal soc : std_logic_vector(2 downto 0);
signal doc : std_logic_vector(3 downto 0);
signal joc : std_logic_vector(2 downto 0);
signal isrc : integer range 0 to 15;
signal idst : integer range 0 to 15;
signal jmpoffs : std_logic_vector(9 downto 0);

signal sas : std_logic_vector(1 downto 0);
signal das : std_logic_vector(1 downto 0);
signal dad : std_logic;

signal nc : std_logic;
signal nz : std_logic;
signal nn : std_logic;
signal nv : std_logic;

signal r_a0 : std_logic;
signal s_din : std_logic_vector(15 downto 0);
signal src : std_logic_vector(15 downto 0);
signal alu_out : std_logic_vector(15 downto 0);
signal alu_op1 : std_logic_vector(16 downto 0);
signal alu_op2 : std_logic_vector(16 downto 0);
signal s_alu_op1 : std_logic_vector(15 downto 0);
signal s_alu_op2 : std_logic_vector(15 downto 0);

begin

-----------------------------------------------------------------------------------------------
-- state machine
-----------------------------------------------------------------------------------------------

	state_machine : process(clk, rst, halt)
	begin
		if rst = '0' then
			state <= irq_rd_vct_p1;
		elsif clk'event and clk = '1' and halt = '0' then
			state <= nstate;
		end if;
	end process;

	state_machine_encoding : process(state, soi, doi, jmpi, soc, doc, sas, das, dad, idst, girq, cpuoff)
	begin
		nstate <= state;
		case state is
			when rd_code_p1 =>					-- fetch opcode
				nstate <= rd_code_p2;
			when rd_code_p2 =>					-- fetch opcode
				if soi = '1' then				-- single op instr
					if soc = reti then
						nstate <= reti_popsr_p1;
					elsif soc = push or soc = call then
						if sas = "00" then		-- direct addr or const
							nstate <= push_rdwr;
						else				-- indexed or indirect(+) addr (sas = "01" or "1-")
							nstate <= push_rd_bs;
						end if;
					else
						if sas = "00" then		-- direct or const operand
							if girq = '1' then
								nstate <= irq_init;
							elsif cpuoff = '1' then
								nstate <= cpu_off;
							elsif idst = 0 then	-- operand is pc
								nstate <= rd_code_p1;
							end if;
						elsif sas = "01" then		-- indexed addr
							nstate <= soi_rd_bs;
						else				-- indirect addr (as = "10" or "11")
							nstate <= soi_rdwr_op;
						end if;
					end if;
				elsif jmpi = '1' then				-- jump instr
					if girq = '1' then
						nstate <= irq_init;
					elsif cpuoff = '1' then
						nstate <= cpu_off;
					else
						nstate <= rd_code_p1;
					end if;
				elsif doi = '1' then
					if das = "00" and dad = '0' then	-- direct or const src and dst
						if girq = '1' then
							nstate <= irq_init;
						elsif cpuoff = '1' then
							nstate <= cpu_off;
						elsif idst = 0 then		-- dst operand is pc
							nstate <= rd_code_p1;
						end if;
					elsif das = "00" then			-- direct or const src and indexed dst
						nstate <= doi_rd_dstbs;
					elsif das = "01" then			-- indexed src
						nstate <= doi_rd_srcbs;
					else					-- indirect(+) src
						nstate <= doi_rd_src;
					end if;
				end if;
			-- single operand instructions
			when soi_rd_bs =>	-- read base address of operand (single op instr)
				nstate <= soi_rdwr_op;
			when soi_rdwr_op =>	-- read operand and write result (single op instr)
				if girq = '1' then
					nstate <= irq_init;
				elsif cpuoff = '1' then
					nstate <= cpu_off;
				else
					nstate <= rd_code_p1;
				end if;
			-- push and call instructions
			when push_rd_bs =>	-- read base address of operand (push, call)
				nstate <= push_rdwr;
			when push_rdwr =>	-- read operand and write to stack (push: operand, call: pc, pc=operand)
				if girq = '1' then
					nstate <= irq_init;
				elsif cpuoff = '1' then
					nstate <= cpu_off;
				else
					nstate <= rd_code_p1;
				end if;
			-- return from interrupt
			when reti_popsr_p1 =>	-- read sr from stack (reti) phase 1: address out (-SP)
				nstate <= reti_popsr_p2;
			when reti_popsr_p2 =>	-- read sr from stack (reti) phase 2: SR=din, address out (-SP)
				nstate <= reti_poppc;
			when reti_poppc =>	-- read pc from stack (reti) : PC=din
				if girq = '1' then
					nstate <= irq_init;
				elsif cpuoff = '1' then
					nstate <= cpu_off;
				else
					nstate <= rd_code_p1;
				end if;
			-- double operand instructions
			when doi_rd_srcbs =>	-- read base address of src (double op instr)
				nstate <= doi_rd_src;
			when doi_rd_src =>	-- read src (double op instr)
				if dad = '0' then				-- dst direct addr
					if girq = '1' then
						nstate <= irq_init;
					elsif cpuoff = '1' then
						nstate <= cpu_off;
					elsif idst = 0 then			-- dst operand is pc
						nstate <= rd_code_p1;
					else
						nstate <= rd_code_p2;
					end if;
				else						-- dst indexed
					nstate <= doi_rd_dstbs;
				end if;
			when doi_rd_dstbs =>	-- read base address of dst (double op instr)
				nstate <= doi_rdwr_dst;
			when doi_rdwr_dst =>	-- read dst and write result (double op instr)
				if girq = '1' then
					nstate <= irq_init;
				elsif cpuoff = '1' then
					nstate <= cpu_off;
				elsif idst = 0 then				-- dst operand is pc
					nstate <= rd_code_p1;
				else
					nstate <= rd_code_p2;
				end if;
			-- interrupt
			when irq_init =>	-- init interrupt : complete instruction (required when dst=sr and gie is affected), get irq source, ack irq
				if girq = '1' then
					nstate <= irq_pushpc;
				elsif cpuoff = '1' then
					nstate <= cpu_off;
				else
					nstate <= rd_code_p1;
				end if;
			when irq_pushpc =>	-- push pc on stack
				nstate <= irq_pushsr;
			when irq_pushsr =>	-- push sr on stack
				nstate <= irq_rd_vct_p1;
			when irq_rd_vct_p1 =>	-- read interrupt vector from table
				nstate <= irq_rd_vct_p2;
			when irq_rd_vct_p2 =>	-- read interrupt vector from table
				nstate <= rd_code_p1;
			when cpu_off =>
				if girq = '1' then
					nstate <= irq_init;
				end if;
			when others =>
				nstate <= rd_code_p1;
		end case;
	end process;


-----------------------------------------------------------------------------------------------
-- memory bus
-----------------------------------------------------------------------------------------------

	addr <= s_addr(15 downto 1);	-- 16 bit bus, byte transfers are validated with lbe and hbe

	s_addr <= irqaddr when state = irq_rd_vct_p1 else				-- irq vector read
		  sp when state = irq_pushpc or state = irq_pushsr or			-- irq push pc and sr
			  state = reti_popsr_p1 or state = reti_popsr_p2 or		-- reti pop sr and pc
			  state = push_rdwr else					-- push/call, write to stack
		  rrs(idst) when (state = rd_code_p2 and soi = '1' and sas(1) = '1') or	-- soi, read indirect op
				 (state = push_rd_bs and sas(1) = '1') or		-- push/call, read indirect op
				 (state = soi_rdwr_op and sas(1) = '1') else		-- soi, write indirect op
		  rrs(isrc) when state = rd_code_p2 and doi = '1' and das(1) = '1' else	-- doi, read indirect src
		  din + rrs(idst) when state = soi_rd_bs or				-- soi, read indexed op
				       (state = push_rd_bs and sas = "01") else		-- push/call, read indexed op
		  din + rrs(isrc) when state = doi_rd_srcbs else			-- doi, read indexed src
		  din + rrd(idst) when state = doi_rd_dstbs else			-- doi, read indexed dst
		  bsaddr + rrs(idst) when state = soi_rdwr_op and sas = "01" else	-- soi, write indexed op
		  bsaddr + rrs(isrc) when state = doi_rdwr_dst else			-- doi, write indexed dst
		  pc;

	dout <= pc when state = irq_pushpc or						-- interrupt, push pc
			(state = push_rdwr and soc = call) else				-- call: push pc
		sr when state = irq_pushsr else						-- interrupt, push sr
		x"00" & alu_out(7 downto 0) when (soi = '1' or doi = '1') and bw = '1' else
		alu_out;

	wr_data <= '1' when state = soi_rdwr_op or
			    state = push_rdwr or
			    (state = doi_rdwr_dst and soc /= cmp and soc /= bitx) else '0';
	wr_code <= '1' when state = irq_pushpc or
			    state = irq_pushsr else '0';

	wr <= wr_data or wr_code;

	rd_data <= '1' when state = soi_rd_bs or
			    state = push_rd_bs or
			    state = doi_rd_srcbs or
			    state = doi_rd_dstbs or
			    (state = rd_code_p2 and soi = '1' and sas(1) = '1' and soc /= push and soc /= call) or
			    (state = rd_code_p2 and doi = '1' and das(1) = '1') else '0';
	rd_code <= '1' when state = rd_code_p1 or
			    state = reti_popsr_p1 or
			    state = reti_popsr_p2 or
			    state = irq_rd_vct_p1 or
			    (state = rd_code_p2 and soi = '1' and sas = "01") or
			    (state = rd_code_p2 and soi = '1' and sas = "00" and nstate = rd_code_p2) or
			    (state = rd_code_p2 and doi = '1' and das = "01") or
			    (state = rd_code_p2 and doi = '1' and dad = '1') or
			    (state = rd_code_p2 and doi = '1' and das = "00" and dad = '1') or
			    (state = rd_code_p2 and doi = '1' and das = "00" and dad = '0' and nstate = rd_code_p2) or
			    (state = doi_rd_src and dad = '1') or
			    (state = doi_rd_src and dad = '0' and nstate = rd_code_p2) else '0';

	rd <= rd_code or rd_data;

	lbe <= '1' when rd_code = '1' or wr_code = '1' or
			((rd_data = '1' or wr_data = '1') and (bw = '0' or s_addr(0) = '0')) else '0';

	hbe <= '1' when rd_code = '1' or wr_code = '1' or
			((rd_data = '1' or wr_data = '1') and (bw = '0' or s_addr(0) = '1')) else '0';

	input_registers: process(clk, rst, halt)
	begin
		if rst = '0' then
			r_code <= (others => '0');
			bsaddr <= (others => '0');
		elsif clk'event and clk = '1' and halt = '0' then
			if state = rd_code_p2 then
				r_code <= din;
			end if;
			if state = rd_code_p2 then
				bsaddr <= x"0000";
			elsif state = soi_rd_bs or state = doi_rd_dstbs then
				bsaddr <= din;
			end if;
		end if;
	end process;

	with state select
		code <= din when rd_code_p2,
			r_code when others;

	soi <= '1' when code(15 downto 10) = "000100" else '0';			-- single op instr
	doi <= '1' when code(15 downto 14) = "01" or code(15) = '1' else '0';	-- double op instr
	jmpi <= '1' when code(15 downto 13) = "001" else '0';			-- jump instr
--	invi <= not (soi or jmpi or doi);					-- invalid instr

	soc <= code(9 downto 7);						-- opcode of single op instr
	doc <= code(15 downto 12);						-- opcode of double op instr
	joc <= code(12 downto 10);						-- opcode of jmp instr
	bw <= code(6);								-- byte/word operand
	as <= code(5 downto 4);							-- src addressing mode
	ad <= code(7);								-- dst addressing mode (with double op instr only)
	isrc <= conv_integer(code(11 downto 8));				-- src register index
	idst <= conv_integer(code(3 downto 0));					-- dst register index
	jmpoffs <= code(9 downto 0);						-- jump offset

	sas <= "00" when idst = 3 or (idst = 2 and as(1) = '1') else as;	-- single op, real src addressing mode (cg is direct) 
	das <= "00" when isrc = 3 or (isrc = 2 and as(1) = '1') else as;	-- double op, real src addressing mode (cg is direct) 
	dad <= '0' when idst = 3 else ad;					-- double op, real dst addressing mode (cg is direct) 


-----------------------------------------------------------------------------------------------
-- registers R0..15
-----------------------------------------------------------------------------------------------

	r0_r15 : process(clk, rst, halt)
	begin
		if rst = '0' then
			pc <= (others => '0');
			sp <= (others => '0');
			sr <= (others => '0');
			for i in 4 to 15 loop
				r(i) <= (others => '0');
			end loop;
		elsif clk'event and clk = '1' and halt = '0' then

			-- pc (r0)
			if state = reti_poppc or state = irq_rd_vct_p2 then			-- reti pop pc, or read irq vector
				pc <= din;
			-- pc specific
			elsif (state = rd_code_p2 and jmpi = '1') or				-- jump instr
			      (state = push_rdwr and soc = call) then				-- call instr, move result to pc
				pc <= alu_out;
			-- for all Rs
			elsif idst = 0 and
			      ((state = rd_code_p2 and soi = '1' and sas = "00") or		-- soi direct op
			      (state = rd_code_p2 and doi = '1' and das = "00" and dad = '0') or	-- doi, src direct, dst direct
			      (state = doi_rd_src and dad = '0')) then				-- doi direct dst
				if soc /= cmp and soc /= bitx then
					pc <= alu_out;
				end if;
			-- pc specific : increment pc after an instruction or an src/dst base address (indexed addr) is read
			elsif state = rd_code_p1 or
			      (state = rd_code_p2 and soi = '1' and sas = "01") or		-- soi indexed addr
			      (state = rd_code_p2 and doi = '1' and das = "01") or		-- doi indexed src addr
			      (state = rd_code_p2 and doi = '1' and das = "00" and dad = '1') or-- doi direct src, indexed dst
			      (state = rd_code_p2 and nstate = rd_code_p2) or			-- new address out if single cycle instr
			      (state = doi_rd_src and nstate = rd_code_p2) then			-- new address out if 
				pc <= pc + 2;
			-- for all Rs
			elsif idst = 0 and
			      ((state = push_rd_bs and sas = "11") or				-- push/call indirect+ with pc
			      (state = soi_rdwr_op and sas = "11")) then			-- soi indirect+ with pc (immediate) and instr is not push or call
				pc <= pc + 2;
			elsif isrc = 0 and
			      (state = rd_code_p2 and doi = '1' and das = "11") then		-- doi indirect+ src addr with pc (immediate)
				pc <= pc + 2;
			end if;

			-- sp (r1)
			if nstate = push_rd_bs or nstate = push_rdwr or nstate = irq_pushpc or nstate = irq_pushsr then-- push to stack (dec before push)
				sp <= sp - 2;
			-- for all Rs
			elsif idst = 1 and
			      ((state = rd_code_p2 and soi = '1' and sas = "00") or		-- soi direct op
			      (state = rd_code_p2 and doi = '1' and das = "00" and dad = '0') or	-- doi, src direct, dst direct
			      (state = doi_rd_src and dad = '0')) then				-- doi direct dst
				if soc /= cmp and soc /= bitx then
					sp <= alu_out;
				end if;
			-- sp specific
			elsif (state = reti_popsr_p1 or state = reti_popsr_p2) then		-- reti pop from stack (inc after pop)
				sp <= sp + 2;
			-- for all Rs
			elsif idst = 1 and
			      ((state = push_rd_bs and sas = "11") or				-- push/call indirect+ with pc
			      (state = soi_rdwr_op and sas = "11")) then			-- soi indirect+ with pc (immediate) and instr is not push or call
				sp <= sp + 2;
			elsif isrc = 1 and
			      (state = rd_code_p2 and doi = '1' and das = "11") then		-- doi indirect+ src addr with pc (immediate)
				sp <= sp + 2;
			end if;

			-- sr (r2)
			if state = reti_popsr_p2 then						-- reti pop sr
				sr <= din;
			-- for all Rs
			elsif idst = 2 and
			      ((state = rd_code_p2 and soi = '1' and sas = "00") or		-- soi direct op
			       (state = rd_code_p2 and doi = '1' and das = "00" and dad = '0') or	-- doi, src direct, dst direct
			       (state = doi_rd_src and dad = '0')) then				-- doi direct dst
				if soc /= cmp and soc /= bitx then
					sr <= alu_out;
				end if;
			-- sr specific
			elsif (state = rd_code_p2 and soi = '1' and sas = "00") or		-- single op, direct
			      (state = soi_rdwr_op) or						-- single op, not direct
			      (state = rd_code_p2 and doi = '1' and das = "00" and dad = '0') or	-- double op, both direct
			      (state = doi_rd_src and dad = '0') or				-- double op, dst direct
			      (state = doi_rdwr_dst) then					-- double op, not direct
				n <= nn;
				z <= nz;
				c <= nc;
				v <= nv;
			end if;

			-- all other registers (except r3 (constant))
			for i in 4 to 15 loop
				if idst = i and							-- direct addr, dst is r(idst)
				   ((state = rd_code_p2 and soi = '1' and sas = "00") or	-- soi direct op
				   (state = rd_code_p2 and doi = '1' and das = "00" and dad = '0') or	-- doi, src direct, dst direct
				   (state = doi_rd_src and dad = '0')) then			-- doi direct dst
					if soc /= cmp and soc /= bitx then
						r(i) <= alu_out;
					end if;
				elsif idst = i and
				      ((state = push_rd_bs and sas = "11") or			-- push/call indirect+ with pc
				      (state = soi_rdwr_op and sas = "11")) then		-- soi indirect+ with pc (immediate) and instr is not push or call
					if bw = '0' then					-- word operation
						r(i) <= r(i) + 2;
					else							-- byte operation
						r(i) <= r(i) + 1;
					end if;
				elsif isrc = i and
				      (state = rd_code_p2 and doi = '1' and das = "11") then	-- doi indirect+ src addr with pc (immediate)
					if bw = '0' then					-- word operation
						r(i) <= r(i) + 2;
					else							-- byte operation
						r(i) <= r(i) + 1;
					end if;
				end if;
			end loop;
		end if;
	end process;

	-- registers read as source operand (single or double op instr)
	rrs(0) <= pc;
	rrs(1) <= sp;
	-- sr_cg1 read as source operand (single or double op instr)
	rrs(2) <= cg1(1) when as = "01" else
		  cg1(2) when as = "10" else
		  cg1(3) when as = "11" else
		  sr;
	-- cg2 read as source operand (single or double op instr)
	rrs(3) <= cg2(0) when as = "00" else
		  cg2(1) when as = "01" else
		  cg2(2) when as = "10" else
		  cg2(3); -- when as = "11"
	rrs(4) <= r(4);
	rrs(5) <= r(5);
	rrs(6) <= r(6);
	rrs(7) <= r(7);
	rrs(8) <= r(8);
	rrs(9) <= r(9);
	rrs(10) <= r(10);
	rrs(11) <= r(11);
	rrs(12) <= r(12);
	rrs(13) <= r(13);
	rrs(14) <= r(14);
	rrs(15) <= r(15);


	-- registers read as destination operand (double op instr only)
	rrd(0) <= pc;
	rrd(1) <= sp;
	-- sr_cg1 read as destination operand (double op instr only - dst constants might be valid for flags generation ???)
	rrd(2) <= cg1(1) when ad = '1' else
		  sr;
	-- cg2 read as dst operand (double op instr only - dst constants might be valid for flags generation ???)
	rrd(3) <= cg2(0) when ad = '0' else
		  cg2(1); -- when ad = '1'
	rrd(4) <= r(4);
	rrd(5) <= r(5);
	rrd(6) <= r(6);
	rrd(7) <= r(7);
	rrd(8) <= r(8);
	rrd(9) <= r(9);
	rrd(10) <= r(10);
	rrd(11) <= r(11);
	rrd(12) <= r(12);
	rrd(13) <= r(13);
	rrd(14) <= r(14);
	rrd(15) <= r(15);


-----------------------------------------------------------------------------------------------
-- alu
-----------------------------------------------------------------------------------------------

	process(clk, rst, halt)
	begin
		if rst = '0' then
			r_a0 <= '0';
		elsif clk'event and clk = '1' and halt = '0' then
			r_a0 <= s_addr(0);
		end if;
	end process;

	-- use MSB of din if byte operand is read from odd address
	s_din(7 downto 0) <= din(15 downto 8) when bw = '1' and r_a0 = '1' else
			     din(7 downto 0);

	s_din(15 downto 8) <= x"00" when bw = '1' and r_a0 = '1' else
			     din(15 downto 8);

	-- register din if cannot be utilized immediately (doi, src is from ram and dst is not direct)
	src_op: process(clk, rst, halt)
	begin
		if rst = '0' then
			src <= (others => '0');
		elsif clk'event and clk = '1' and halt = '0' then
			if state = doi_rd_src then
				src <= s_din;
			end if;
		end if;
	end process;

	s_alu_op1(15 downto 0) <= rrd(idst) when doi = '1' and dad = '0' else	-- doi, direct dst (direct addressing or constant)
				  pc when jmpi = '1' else
				  s_din;	-- when state = doi_rdwr_dst;

	s_alu_op2(15 downto 0) <= rrs(idst) when soi = '1' and sas = "00" else	-- soi, direct src (direct addressing or constant)
				  rrs(isrc) when doi = '1' and das = "00" else	-- doi, direct src (direct addressing or constant)
				  (jmpoffs(9)&jmpoffs(9)&jmpoffs(9)&jmpoffs(9)&jmpoffs(9)&jmpoffs(9 downto 0)&'0') when jmpi = '1' else
				  src when doi = '1' and das /= "00" and dad = '1' else	-- doi, not direct src, indirect dst
				  s_din;	-- when state = soi_rd_op or state = push_rd_op or state = doi_rd_src;

	-- due to carry on bit 16 in ALU, byte operations are applied on MSB
	alu_op1(16 downto 8) <= '0' & s_alu_op1(7 downto 0) when (soi = '1' or doi = '1') and bw = '1' else
			        '0' & s_alu_op1(15 downto 8);
	alu_op2(16 downto 8) <= '0' & s_alu_op2(7 downto 0) when (soi = '1' or doi = '1') and bw = '1' else
			        '0' & s_alu_op2(15 downto 8);
	alu_op1(7 downto 0) <= x"00" when (soi = '1' or doi = '1') and bw = '1' else
			       s_alu_op1(7 downto 0);
	alu_op2(7 downto 0) <= x"00" when (soi = '1' or doi = '1') and bw = '1' else
			       s_alu_op2(7 downto 0);

	alu : process(alu_op1, alu_op2, soi, doi, jmpi, soc, doc, joc, bw, n, z, c, v)
	 variable v_alu_out : std_logic_vector(16 downto 0);
	 function zero (word : std_logic_vector(16 downto 0)) return std_logic is
	 begin
		if word(15 downto 0) = x"0000" then
			return '1';
		else
			return '0';
		end if;
	 end zero;
	begin
		v_alu_out := '0' & x"0000";
		nn <= n;
		nz <= z;
		nc <= c;
		nv <= v;
		if soi = '1' then
			if soc = rrc then
				v_alu_out(14 downto 0) := alu_op2(15 downto 1);
				v_alu_out(15) := c;
				nn <= v_alu_out(15);
				nz <= zero(v_alu_out);
				nv <= '0';
				nc <= (bw and alu_op2(0)) or (not bw and alu_op2(8));
			elsif soc = swpb then
				v_alu_out(7 downto 0) := alu_op2(15 downto 8);
				v_alu_out(15 downto 8) := alu_op2(7 downto 0);
			elsif soc = rra then
				v_alu_out(14 downto 0) := alu_op2(15 downto 1);
				v_alu_out(15) := alu_op2(15);
				nn <= v_alu_out(15);
				nz <= zero(v_alu_out);
				nc <= (bw and alu_op2(0)) or (not bw and alu_op2(8));
				nv <= '0';
			elsif soc = sxt  then
				for i in 8 to 15 loop
					v_alu_out(i) := alu_op2(7);
				end loop;
				nn <= v_alu_out(15);
				nz <= zero(v_alu_out);
				nc <= not zero(v_alu_out);
				nv <= '0';
			elsif soc = push then
				v_alu_out := alu_op2;
			elsif soc = call then
				v_alu_out := alu_op2;
			end if;
		elsif doi = '1' then
			if doc = mov then
				v_alu_out := alu_op2;
			elsif doc = add then
				v_alu_out := alu_op1 + alu_op2;
				nn <= v_alu_out(15);
				nz <= zero(v_alu_out);
				nc <= v_alu_out(16);
				nv <= (not alu_op1(15) and not alu_op2(15) and v_alu_out(15)) or (alu_op1(15) and alu_op2(15) and not v_alu_out(15));
			elsif doc = addc then
				if bw = '0' then
					v_alu_out := alu_op1 + alu_op2 + c;
				else
					v_alu_out(16 downto 8) := alu_op1(16 downto 8) + alu_op2(16 downto 8) + c;
				end if;
				nn <= v_alu_out(15);
				nz <= zero(v_alu_out);
				nc <= v_alu_out(16);
				nv <= (not alu_op1(15) and not alu_op2(15) and v_alu_out(15)) or (alu_op1(15) and alu_op2(15) and not v_alu_out(15));
			elsif doc = subc then
				if bw = '0' then
					v_alu_out := alu_op1 + (not alu_op2) + c;
				else
					v_alu_out(16 downto 8) := alu_op1(16 downto 8) + (not alu_op2(16 downto 8)) + c;
				end if;
				nn <= v_alu_out(15);
				nz <= zero(v_alu_out);
				nc <= v_alu_out(16);
				nv <= (not alu_op1(15) and alu_op2(15) and not v_alu_out(15)) or (alu_op1(15) and not alu_op2(15) and not v_alu_out(15));
			elsif doc = sub then
				v_alu_out := alu_op1 - alu_op2;
				nn <= v_alu_out(15);
				nz <= zero(v_alu_out);
				nc <= v_alu_out(16);
				nv <= (not alu_op1(15) and alu_op2(15) and not v_alu_out(15)) or (alu_op1(15) and not alu_op2(15) and not v_alu_out(15));
			elsif doc = cmp then
				v_alu_out := alu_op1 - alu_op2;
				nn <= v_alu_out(15);
				nz <= zero(v_alu_out);
				nc <= v_alu_out(16);
				nv <= (not alu_op1(15) and alu_op2(15) and not v_alu_out(15)) or (alu_op1(15) and not alu_op2(15) and not v_alu_out(15));
			elsif doc = dadd then
				if bw = '0' then
					v_alu_out(0) := c;
					v_alu_out(4 downto 0) := ('0' & alu_op1(3 downto 0)) + ('0' & alu_op2(3 downto 0)) + ("000" & v_alu_out(0));
					if v_alu_out(4 downto 0) > 9 then
						v_alu_out(4 downto 0) := v_alu_out(4 downto 0) - 6;
						v_alu_out(4) := '1';
					end if;
					v_alu_out(8 downto 4) := ('0' & alu_op1(7 downto 4)) + ('0' & alu_op2(7 downto 4)) + ("000" & v_alu_out(4));
					if v_alu_out(8 downto 4) > 9 then
						v_alu_out(8 downto 4) := v_alu_out(8 downto 4) - 6;
						v_alu_out(8) := '1';
					end if;
				else
					v_alu_out(8) := c;
				end if;

				v_alu_out(12 downto 8) := ('0' & alu_op1(11 downto 8)) + ('0' & alu_op2(11 downto 8)) + ("000" & v_alu_out(8));
				if v_alu_out(12 downto 8) > 9 then
					v_alu_out(12 downto 8) := v_alu_out(12 downto 8) - 6;
					v_alu_out(12) := '1';
				end if;
				v_alu_out(16 downto 12) := ('0' & alu_op1(15 downto 12)) + ('0' & alu_op2(15 downto 12)) + ("000" & v_alu_out(12));
				if v_alu_out(16 downto 12) > 9 then
					v_alu_out(16 downto 12) := v_alu_out(16 downto 12) - 6;
					v_alu_out(16) := '1';
				end if;
				nc <= v_alu_out(16);
				nn <= v_alu_out(15);
				nz <= zero(v_alu_out);
			elsif doc = bitx then
				v_alu_out := alu_op1 and alu_op2;
				nn <= v_alu_out(15);
				nz <= zero(v_alu_out);
				nc <= not zero(v_alu_out);
				nv <= '0';
			elsif doc = bic then
				v_alu_out := alu_op1 and not alu_op2;
			elsif doc = bis then
				v_alu_out := alu_op1 or alu_op2;
			elsif doc = xorx then
				v_alu_out := alu_op1 xor alu_op2;
				nn <= v_alu_out(15);
				nz <= zero(v_alu_out);
				nc <= not zero(v_alu_out);
				nv <= alu_op1(15) and alu_op2(15);
			elsif doc = andx then
				v_alu_out := alu_op1 and alu_op2;
				nn <= v_alu_out(15);
				nz <= zero(v_alu_out);
				nc <= not zero(v_alu_out);
				nv <= '0';
			end if;
		elsif jmpi = '1' then
			if (joc = jnz and z = '0') or
			   (joc = jz  and z = '1') or
			   (joc = jnc and c = '0') or
			   (joc = jc  and c = '1') or
			   (joc = jn  and n = '1') or
			   (joc = jge and (n xor v) = '0') or
			   (joc = jl  and (n xor v) = '1') or
			   (joc = jmp) then
				v_alu_out := alu_op1 + alu_op2;
			else
				v_alu_out := alu_op1;
			end if;
		end if;
		-- result of byte operation is carried out on MSB -> shift to LSB
		if (soi = '1' or doi = '1') and bw = '1' then
			alu_out(7 downto 0) <= v_alu_out(15 downto 8);
			alu_out(15 downto 8) <= x"00";
		else
			alu_out <= v_alu_out(15 downto 0);
		end if;
	end process;


-----------------------------------------------------------------------------------------------
-- interrupt controller
-----------------------------------------------------------------------------------------------

	-- global interrupt request (14 is nmi)
	girq <= '1' when (irq(14) /= '0') or (irq(13 downto 0) /= ("00" & x"000") and gie = '1') else '0';

	interrupts : process(clk, rst, halt)
	begin
		if rst = '0' then
			iack <= (others => '0');
			irqaddr <= x"FFFE";	-- reset vector (irq 15)
		elsif clk'event and clk = '1' and halt = '0' then
			if state = irq_init and girq = '1' then
				if irq(14) = '1' then
					irqaddr <= x"FFFC";
					iack(14) <= '1';
				elsif irq(13) = '1' then
					irqaddr <= x"FFFA";
					iack(13) <= '1';
				elsif irq(12) = '1' then
					irqaddr <= x"FFF8";
					iack(12) <= '1';
				elsif irq(11) = '1' then
					irqaddr <= x"FFF6";
					iack(11) <= '1';
				elsif irq(10) = '1' then
					irqaddr <= x"FFF4";
					iack(10) <= '1';
				elsif irq(9) = '1' then
					irqaddr <= x"FFF2";
					iack(9) <= '1';
				elsif irq(8) = '1' then
					irqaddr <= x"FFF0";
					iack(8) <= '1';
				elsif irq(7) = '1' then
					irqaddr <= x"FFEE";
					iack(7) <= '1';
				elsif irq(6) = '1' then
					irqaddr <= x"FFEC";
					iack(6) <= '1';
				elsif irq(5) = '1' then
					irqaddr <= x"FFEA";
					iack(5) <= '1';
				elsif irq(4) = '1' then
					irqaddr <= x"FFE8";
					iack(4) <= '1';
				elsif irq(3) = '1' then
					irqaddr <= x"FFE6";
					iack(3) <= '1';
				elsif irq(2) = '1' then
					irqaddr <= x"FFE4";
					iack(2) <= '1';
				elsif irq(1) = '1' then
					irqaddr <= x"FFE2";
					iack(1) <= '1';
				elsif irq(0) = '1' then
					irqaddr <= x"FFE0";
					iack(0) <= '1';
				end if;	
			else
				iack <= (others => '0');
			end if;
		end if;
	end process;

end rtl;




