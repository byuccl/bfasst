----------------------------------------------------------------------
----																					----
---- Basic RSA Public Key Cryptography IP Core 							----
---- 																					----
---- Implementation of BasicRSA IP core according to 					----
---- BasicRSA IP core specification document. 							----
---- 																					----
---- To Do: 																		----
---- - 																				----
---- 																					----
---- Author(s): 																	----
---- - Steven R. McQueen, srmcqueen@opencores.org 						----
---- 																					----
----------------------------------------------------------------------
---- 																					----
---- Copyright (C) 2001 Authors and OPENCORES.ORG 						----
---- 																					----
---- This source file may be used and distributed without 			----
---- restriction provided that this copyright statement is not 	----
---- removed from the file and that any derivative work contains 	----
---- the original copyright notice and the associated disclaimer. ----
---- 																					----
---- This source file is free software; you can redistribute it 	----
---- and/or modify it under the terms of the GNU Lesser General 	----
---- Public License as published by the Free Software Foundation; ----
---- either version 2.1 of the License, or (at your option) any 	----
---- later version. 																----
---- 																					----
---- This source is distributed in the hope that it will be 		----
---- useful, but WITHOUT ANY WARRANTY; without even the implied 	----
---- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 		----
---- PURPOSE. See the GNU Lesser General Public License for more 	----
---- details. 																		----
---- 																					----
---- You should have received a copy of the GNU Lesser General 	----
---- Public License along with this source; if not, download it 	----
---- from http://www.opencores.org/lgpl.shtml 							----
---- 																					----
----------------------------------------------------------------------
--
-- CVS Revision History
--
-- $Log: not supported by cvs2svn $
--

-- This module implements the RSA Public Key Cypher. It expects to receive the data block
-- to be encrypted or decrypted on the indata bus, the exponent to be used on the inExp bus,
-- and the modulus on the inMod bus. The data block must have a value less than the modulus.
-- It may be worth noting that in practice the exponent is not restricted to the size of the
-- modulus, as would be implied by the bus sizes used in this design. This design must
-- therefore be regarded as a demonstration only.
--
-- A Square-and-Multiply algorithm is used in this module. For each bit of the exponent, the
-- message value is squared. For each '1' bit of the exponent, the message value is multiplied
-- by the result of the squaring operation. The operation ends when there are no more '1'
-- bits in the exponent. Unfortunately, the squaring multiplication must be performed whether
-- the corresponding exponent bit is '1' or '0', so very little is gained by skipping the
-- multiplication of the data value. A multiplication is performed for every significant bit
-- in the exponent.
--
-- Comments, questions and suggestions may be directed to the author at srmcqueen@mcqueentech.com.


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;
																	
entity basicrsa is
	Generic (KEYSIZE: integer := 32);
    Port (indata: in std_logic_vector(KEYSIZE-1 downto 0);
	 		 inExp: in std_logic_vector(KEYSIZE-1 downto 0);
	 		 inMod: in std_logic_vector(KEYSIZE-1 downto 0);
	 		 cypher: out std_logic_vector(KEYSIZE-1 downto 0);
			 clk: in std_logic;
			 ds: in std_logic;
			 reset: in std_logic;
			 ready: out std_logic
			 );
end basicrsa;

architecture Behavioral of basicrsa is
attribute keep: string;

component modmult is
	Generic (MPWID: integer);
    Port ( mpand : in std_logic_vector(MPWID-1 downto 0);
           mplier : in std_logic_vector(MPWID-1 downto 0);
           modulus : in std_logic_vector(MPWID-1 downto 0);
           product : out std_logic_vector(MPWID-1 downto 0);
           clk : in std_logic;
           ds : in std_logic;
			  reset : in std_logic;
			  ready: out std_logic);
end component;

signal modreg: std_logic_vector(KEYSIZE-1 downto 0);	-- store the modulus value during operation
signal root: std_logic_vector(KEYSIZE-1 downto 0);	-- value to be squared
signal square: std_logic_vector(KEYSIZE-1 downto 0);	-- result of square operation
signal sqrin: std_logic_vector(KEYSIZE-1 downto 0);	-- 1 or copy of root
signal tempin: std_logic_vector(KEYSIZE-1 downto 0);	-- 1 or copy of square
signal tempout: std_logic_vector(KEYSIZE-1 downto 0);	-- result of multiplication
signal count: std_logic_vector(KEYSIZE-1 downto 0);	-- working copy of exponent

signal multrdy, sqrrdy, bothrdy: std_logic;	-- signals to indicate completion of multiplications
signal multgo, sqrgo: std_logic;	-- signals to trigger start of multiplications
signal done: std_logic;	-- signal to indicate encryption complete

--   The following attributes can be set to make signal tracing easier

--attribute keep of multrdy: signal is "true";
--attribute keep of sqrrdy: signal is "true";
--attribute keep of bothrdy: signal is "true";
--attribute keep of multgo: signal is "true";
--attribute keep of sqrgo: signal is "true";


begin

	ready <= done;
	bothrdy <= multrdy and sqrrdy;
	
	-- Modular multiplier to produce products
	modmultiply: modmult
	Generic Map(MPWID => KEYSIZE)
	Port Map(mpand => tempin,
				mplier => sqrin,
				modulus => modreg,
				product => tempout,
				clk => clk,
				ds => multgo,
				reset => reset,
				ready => multrdy);

	-- Modular multiplier to take care of squaring operations
	modsqr: modmult
	Generic Map(MPWID => KEYSIZE)
	Port Map(mpand => root,
				mplier => root,
				modulus => modreg,
				product => square,
				clk => clk,
				ds => multgo,
				reset => reset,
				ready =>sqrrdy);

	--counter manager process tracks counter and enable flags
	mngcount: process (clk, reset, done, ds, count, bothrdy) is
	begin
	-- handles DONE and COUNT signals
		
		if reset = '1' then
			count <= (others => '0');
			done <= '1';
		elsif rising_edge(clk) then
			if done = '1' then
				if ds = '1' then
-- first time through
					count <= '0' & inExp(KEYSIZE-1 downto 1);
					done <= '0';
				end if;
-- after first time
			elsif count = 0 then
				if bothrdy = '1' and multgo = '0' then
					cypher <= tempout;		-- set output value
					done <= '1';
				end if;
			elsif bothrdy = '1' then
				if multgo = '0' then
					count <= '0' & count(KEYSIZE-1 downto 1);
				end if;
			end if;
		end if;

	end process mngcount;

	-- This process sets the input values for the squaring multitplier
	setupsqr: process (clk, reset, done, ds) is
	begin
		
		if reset = '1' then
			root <= (others => '0');
			modreg <= (others => '0');
		elsif rising_edge(clk) then
			if done = '1' then
				if ds = '1' then
		-- first time through, input is sampled only once
					modreg <= inMod;
					root <= indata;
				end if;
		-- after first time, square result is fed back to multiplier
			else
				root <= square;
			end if;
		end if;

	end process setupsqr;
	
	-- This process sets input values for the product multiplier
	setupmult: process (clk, reset, done, ds) is
	begin
		
		if reset = '1' then
			tempin <= (others => '0');
			sqrin <= (others => '0');
			modreg <= (others => '0');
		elsif rising_edge(clk) then
			if done = '1' then
				if ds = '1' then
		-- first time through, input is sampled only once
		-- if the least significant bit of the exponent is '1' then we seed the
		--		multiplier with the message value. Otherwise, we seed it with 1.
		--    The square is set to 1, so the result of the first multiplication will be
		--    either 1 or the initial message value
					if inExp(0) = '1' then
						tempin <= indata;
					else
						tempin(KEYSIZE-1 downto 1) <= (others => '0');
						tempin(0) <= '1';
					end if;
					modreg <= inMod;
					sqrin(KEYSIZE-1 downto 1) <= (others => '0');
					sqrin(0) <= '1';
				end if;
		-- after first time, the multiplication and square results are fed back through the multiplier.
		-- The counter (exponent) has been shifted one bit to the right
		-- If the least significant bit of the exponent is '1' the result of the most recent
		--		squaring operation is fed to the multiplier.
		--	Otherwise, the square value is set to 1 to indicate no multiplication.
			else
				tempin <= tempout;
				if count(0) = '1' then
					sqrin <= square;
				else
					sqrin(KEYSIZE-1 downto 1) <= (others => '0');
					sqrin(0) <= '1';
				end if;
			end if;
		end if;

	end process setupmult;
	
	-- this process enables the multipliers when it is safe to do so
	crypto: process (clk, reset, done, ds, count, bothrdy) is
	begin
		
		if reset = '1' then
			multgo <= '0';
		elsif rising_edge(clk) then
			if done = '1' then
				if ds = '1' then
		-- first time through - automatically trigger first multiplier cycle
					multgo <= '1';
				end if;
		-- after first time, trigger multipliers when both operations are complete
			elsif count /= 0 then
				if bothrdy = '1' then
					multgo <= '1';
				end if;
			end if;
		-- when multipliers have been started, disable multiplier inputs
				if multgo = '1' then
					multgo <= '0';
				end if;
		end if;

	end process crypto;

end Behavioral;
