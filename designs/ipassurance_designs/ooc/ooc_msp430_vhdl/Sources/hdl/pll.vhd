-- for simulation only

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity pll is
port (
	areset : in std_logic;
	inclk0 : in std_logic;
	c0     : out std_logic;
	c1     : out std_logic;
	locked : out std_logic
);
end pll;

architecture bhv of pll is

signal s_c1 : std_logic;

begin

	c0 <= inclk0;
	c1 <= s_c1;

	process(inclk0, areset)
	begin
		if areset = '0' then
			s_c1 <= '0';
			locked <= '0';
		elsif inclk0'event and inclk0 = '1' then
			s_c1 <= not s_c1;
			locked <= '1';
		end if;
	end process;

end bhv;

