
-- VHDL Test Bench Created from source file rsacypher.vhd -- 13:35:16 05/04/2003
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

	COMPONENT rsacypher
	PORT(
		indata : IN std_logic_vector(31 downto 0);
		inexp : IN std_logic_vector(31 downto 0);
		inmod : IN std_logic_vector(31 downto 0);
		clk : IN std_logic;
		ds : IN std_logic;
		reset : IN std_logic;          
		cypher : OUT std_logic_vector(31 downto 0);
		ready : OUT std_logic
		);
	END COMPONENT;

	SIGNAL indata :  std_logic_vector(31 downto 0);
	SIGNAL inexp :  std_logic_vector(31 downto 0);
	SIGNAL inmod :  std_logic_vector(31 downto 0);
	SIGNAL cypher :  std_logic_vector(31 downto 0);
	SIGNAL clk :  std_logic;
	SIGNAL ds :  std_logic;
	SIGNAL reset :  std_logic;
	SIGNAL ready :  std_logic;

BEGIN

	uut: rsacypher PORT MAP(
		indata => indata,
		inexp => inexp,
		inmod => inmod,
		cypher => cypher,
		clk => clk,
		ds => ds,
		reset => reset,
		ready => ready
	);


-- *** Test Bench - User Defined Section ***
	TB: PROCESS
	BEGIN
		wait for 120ns;
		reset <= '1';
		ds <= '0';
		wait for 20ns;
		wait until clk = '0';
		reset <= '0';
		wait until clk = '1';
		wait until clk = '0';
		inexp <= x"00903ad9";
		inmod <= x"03b2c159";
		indata <= x"00724183"; 
		wait until clk = '1';
		wait for 2ns;
		ds <= '1';
		wait until ready = '0';
		ds <= '0';
		wait until ready = '1';
		wait;
-- decrypt exponent		inexp <= x"02d80e39";
	END PROCESS;


   ClkGen : PROCESS
   BEGIN
      wait for 5300ps; -- will wait forever
		if clk = '1' then
			clk <= '0';
		else
			clk <= '1';
		end if;
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
