-- retriggerable timer
-- (c) 2005..2010 Gerhard Hoffmann opencores@hoffmann-hochfrequenz.de
-- .. V1.0 published under BSD license
--
-- delivers a done pulse TICKS clocks after a do command.


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;




entity retrigg_timer is
	generic (
		ticks: integer	range 2 to integer'high  -- clock ticks between do and done
	);

	port (

	clk:     in  std_logic;
	rst:     in  std_logic;

	do:      in  std_logic;
	done:    out std_logic;
	running: out std_logic
);
end retrigg_timer;





architecture rtl of retrigg_timer is

	signal tctr:				 integer range 0 to ticks;
	signal irunning: std_logic;
	signal idone:			 std_logic;


	function bool2sl (b: boolean) return std_logic is
	begin
		if b  then return '1'; else return '0';	end if;
	end function bool2sl;


begin

u_timer: process(clk) is
begin
	if rising_edge(clk)
	then

		if rst = '1'
		then
			tctr     <= 0;
			irunning <= '0';

		elsif (do = '1')
		then
			tctr     <= ticks -1;
			irunning <= '1';

		elsif ((irunning = '1') and (idone = '0'))

		then
			tctr <= tctr - 1;

		elsif (idone = '1')
		then
			irunning <= '0';

		end if; -- rst

        -- we are not done when a retrigger comes
        -- just before the timeout
		idone <= bool2sl((tctr = 1) and (do /= '1'));

	end if; -- rising_edge()
end process u_timer;

done    <= idone;
running <= irunning;

end architecture rtl;

