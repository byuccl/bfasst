library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity led is
port ( 
	clk   : in std_logic;
	rst   : in std_logic;
	addr  : in std_logic_vector(2 downto 0);
	din   : in std_logic_vector(15 downto 0);
	dout  : out std_logic_vector(15 downto 0);
	rd    : in std_logic;
	wr    : in std_logic;
	lbe   : in std_logic;
	hbe   : in std_logic;
	led_o  : out std_logic_vector(15 downto 0)
);
end led;

architecture rtl of led is

signal s_led : std_logic_vector(15 downto 0);

begin

	process(clk, rst)
	begin
		if rst = '0' then
			s_led <= (others => '0');
		elsif clk'event and clk = '1' then
			if wr = '1' and lbe = '1' and addr = "000" then
				s_led <= din;
			end if;
		end if;
	end process;

	dout <= s_led;

	led_o <= s_led;

end rtl;

