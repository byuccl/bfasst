library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb is
end tb;

architecture rtl of tb is

component sys
port ( 
	clk  : in std_logic;
	rst  : in std_logic;
	led_o  : out std_logic
);
end component;

signal clk  : std_logic;
signal rst  : std_logic;
signal addr : std_logic_vector(14 downto 0);
signal din  : std_logic_vector(15 downto 0);
signal dout : std_logic_vector(15 downto 0);
signal rd   : std_logic;
signal wr   : std_logic;
signal lbe  : std_logic;
signal hbe  : std_logic;
signal irq  : std_logic_vector(14 downto 0);
signal iack : std_logic_vector(14 downto 0);
signal halt : std_logic;

signal led_o : std_logic;

begin

	rst <= '0' after 0 ns, '1' after 100 ns;

	process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;

	sys_1 : sys
	port map (
		clk  => clk,
		rst  => rst,
		led_o => led_o
	);

	halt <= '0';
	irq <= (others => '0');

end rtl;



