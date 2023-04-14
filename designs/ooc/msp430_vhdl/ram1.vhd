library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ram is
port ( 
	clk  : in std_logic;
	rst  : in std_logic;
	addr : in std_logic_vector(14 downto 0);
	din  : in std_logic_vector(15 downto 0);
	dout : out std_logic_vector(15 downto 0);
	rd   : in std_logic;
	wr   : in std_logic;
	lbe  : in std_logic;
	hbe  : in std_logic
);
end ram;

architecture rtl of ram is

component ram_4096x16
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		byteena		: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		clock		: IN STD_LOGIC ;
		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
end component;

signal s_en : std_logic_vector(1 downto 0);

begin

	s_en <= hbe & lbe;

	ram_l : ram_4096x16
	port map(
		address	=> addr(11 downto 0),
		byteena => s_en,
		clock	=> clk,
		data	=> din,
		wren	=> wr,
		q	=> dout
	);		

end rtl;



