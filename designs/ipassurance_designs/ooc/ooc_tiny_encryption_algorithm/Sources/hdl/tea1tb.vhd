--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:14:25 07/09/2015
-- Design Name:   
-- Module Name:   C:/Users/FeketeBV/projects/fpga/tea/tea1tb.vhd
-- Project Name:  tea
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: tea1
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tea1tb IS
END tea1tb;
 
ARCHITECTURE behavior OF tea1tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT tea1
    PORT(
         clock, reset : IN  std_logic;
         start : IN  std_logic;
         ready : OUT  std_logic;
         key : IN  std_logic_vector(127 downto 0);
         text : IN  std_logic_vector(63 downto 0);
         cipher : OUT  std_logic_vector(63 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clock : std_logic := '0';
   signal start : std_logic := '0';
   signal key : std_logic_vector(127 downto 0) := (others => '0');
   signal text : std_logic_vector(63 downto 0) := (others => '0');

 	--Outputs
   signal ready : std_logic;
   signal cipher : std_logic_vector(63 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: tea1 PORT MAP (
			 reset => reset,
          clock => clock,
          start => start,
          ready => ready,
          key => key,
          text => text,
          cipher => cipher
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      reset <= '1';
		wait for 100 ns;	
		reset <= '0';
      wait for clock_period*10;
      key <= x"abcdef00111111111111111187654321";
		text <= x"1234567812345678";
		wait for clock_period;
		start <= '1';
      wait for clock_period;
      start <= '0';
		wait for clock_period*65;
      wait;

      -- insert stimulus here 

      wait;
   end process;

END;

--v0:1d981fcc
--v1:101a9222
--v0:f1ae2543
--v1:c6cfb000
--v0:33fff5de
--v1:b9ab9356
--v0:3a4964ee
--v1:64cbc15a
--v0:f6407b1b
--v1:2ffeacfb
--v0:66cb0f13
--v1:fed0594b
--v0:a604f863
--v1:36e8273b
--v0:759109fb
--v1:d8ff3788
--v0:de04d860
--v1:717d4bb
--v0:baeeacf2
--v1:ee5fbf35
--v0:8a137045
--v1:4282f410
--v0:9bc07471
--v1:be6c77af
--v0:59d5e13c
--v1:20c12d28
--v0:a07cbbd9
--v1:1049a6b0
--v0:7061f4b9
--v1:1e0c5b44
--v0:ec0a6717
--v1:cb281d62
--v0:4e64e12d
--v1:5435e100
--v0:fbd2c467
--v1:ba5e62cb
--v0:3fa5c4d7
--v1:15c3f100
--v0:bfa7d5a3
--v1:b77c0ffb
--v0:1b8b950c
--v1:2af4cb3b
--v0:2eb95a6
--v1:3a93f68b
--v0:56ba92e4
--v1:9a2374d0
--v0:a9e2f5a2
--v1:fb6ea836
--v0:f25dc136
--v1:dbb40575
--v0:aa7b0aa8
--v1:91b1212b
--v0:a0de430d
--v1:904ada94
--v0:e8bbe461
--v1:a95c8833
--v0:878f458c
--v1:f33397af
--v0:67170e0e
--v1:cf439eec
--v0:30651c8
--v1:9071a21c
--v0:cf9175c4
--v1:bf545d37
