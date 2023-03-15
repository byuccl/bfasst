-- for simulation only

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;

entity rom_4096x16 is
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		clock		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
end rom_4096x16;

architecture rtl of rom_4096x16 is

constant ram_size : integer := 4096;
type t_ram_type is array(0 to ram_size-1) of std_logic_vector(15 downto 0);

function ram_init return t_ram_type is
file ram_file : text open read_mode is "..\quartus\ram_init.mif";
variable v_ram : t_ram_type;
variable l : line;
variable length : integer := 16;
variable w : std_logic_vector(15 downto 0);
variable c : character := '0';
variable s : string(1 to 256);
begin
	while c /= 'C' loop
		exit when endfile(ram_file);
		readline(ram_file, l);
		if l'length > 0 then
			read(l, c);
		end if;
	end loop;

	for i in 0 to ram_size-1 loop
		exit when endfile(ram_file);
		readline(ram_file, l);
		c := '0';
		while c /= ':' loop read(l, c); end loop;
		read(l, c);
		while c = ' ' loop read(l, c); end loop;
		for j in 3 downto 0 loop
			case c is
				when '0' => w(4*j+3 downto 4*j) := x"0";
				when '1' => w(4*j+3 downto 4*j) := x"1";
				when '2' => w(4*j+3 downto 4*j) := x"2";
				when '3' => w(4*j+3 downto 4*j) := x"3";
				when '4' => w(4*j+3 downto 4*j) := x"4";
				when '5' => w(4*j+3 downto 4*j) := x"5";
				when '6' => w(4*j+3 downto 4*j) := x"6";
				when '7' => w(4*j+3 downto 4*j) := x"7";
				when '8' => w(4*j+3 downto 4*j) := x"8";
				when '9' => w(4*j+3 downto 4*j) := x"9";
				when 'A' => w(4*j+3 downto 4*j) := x"A";
				when 'B' => w(4*j+3 downto 4*j) := x"B";
				when 'C' => w(4*j+3 downto 4*j) := x"C";
				when 'D' => w(4*j+3 downto 4*j) := x"D";
				when 'E' => w(4*j+3 downto 4*j) := x"E";
				when 'F' => w(4*j+3 downto 4*j) := x"F";
				when others => w(4*j+3 downto 4*j) := x"0";
			end case;
			read(l, c);
		end loop;
		v_ram(i) := w;
	end loop;
	return v_ram;
end function;

signal s_ram : t_ram_type := ram_init;

begin

	process(clock)
	begin
		if clock'event and clock = '1' then
			q <= s_ram(conv_integer(address));
		end if;
	end process;

end rtl;

