library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vga is
port (
	clk : in std_logic;
	reset : in std_logic;

	addr : in std_logic_vector(14 downto 0);
	din : in std_logic_vector(7 downto 0);

	red : out std_logic;
	green : out std_logic;
	blue : out std_logic;
	hsync : out std_logic;
	vsync : out std_logic
);
end vga;

architecture bhv of vga is

signal s_hsync : std_logic;
signal s_vsync : std_logic;
signal s_red : std_logic;
signal s_green : std_logic;
signal s_blue : std_logic;
signal s_hsync_cnt : integer;
signal s_vsync_cnt : integer;

begin

	hsync_vsync: process(clk, reset)
	begin
		if reset = '0' then
			s_hsync <= '0';
			s_vsync <= '0';
			s_hsync_cnt <= 0;
			s_vsync_cnt <= 0;
		elsif clk'event and clk = '1' then

			if s_hsync_cnt = 1039 then
				s_hsync_cnt <= 0;
			else
				s_hsync_cnt <= s_hsync_cnt + 1;
			end if;

			if s_hsync_cnt = 855 then
				s_hsync <= '1';
			elsif s_hsync_cnt = 975 then
				s_hsync <= '0';
			end if;

			if s_hsync_cnt = 1039 then
				if s_vsync_cnt = 665 then
					s_vsync_cnt <= 0;
				else
					s_vsync_cnt <= s_vsync_cnt + 1;
				end if;
			
				if s_vsync_cnt = 636 then
					s_vsync <= '1';
				elsif s_vsync_cnt = 642 then
					s_vsync <= '0';
				end if;
			end if;

		end if;
	end process;

--	ram_address: process(clk, reset)
--	begin
--		if reset = '0' then
--			address(10) <= '1';
--			s_data_valid <= '0';
--			ram_page0_displayed <= '0';
--			ram_page1_displayed <= '0';
--		elsif clk'event and clk = '1' then
--
--			if s_vsync_cnt = 665 and s_hsync_cnt = 1039 then
--				if ram_page0_valid = '1' then
--					address(10) <= '0';
--					s_data_valid <= '1';
--					ram_page0_displayed <= '0';
--					ram_page1_displayed <= '1';
--				elsif ram_page1_valid = '1' then
--					address(10) <= '1';
--					s_data_valid <= '1';
--					ram_page0_displayed <= '1';
--					ram_page1_displayed <= '0';
--				else
--					s_data_valid <= '0';
--					ram_page0_displayed <= '0';
--					ram_page1_displayed <= '0';
--				end if;
--			end if;
--
--		end if;
--	end process;

	display: process(clk, reset)
	begin
		if reset = '0' then
			s_red <= '0';
			s_green <= '0';
			s_blue <= '0';
		elsif clk'event and clk = '1' then

			if s_hsync_cnt > 799 or s_vsync_cnt > 599 then
				s_red <= '0';
				s_green <= '0';
				s_blue <= '0';
			elsif s_hsync_cnt = 0 or s_hsync_cnt = 799 or s_vsync_cnt = 0 or s_vsync_cnt = 599 then
				s_red <= '1';
				s_green <= '1';
				s_blue <= '1';
			elsif s_vsync_cnt > 550 then
				if s_hsync_cnt > 0 and s_hsync_cnt <= 100 then
					s_red <= '1';
					s_green <= '0';
					s_blue <= '0';
				elsif s_hsync_cnt > 100 and s_hsync_cnt <= 200 then
					s_red <= '0';
					s_green <= '1';
					s_blue <= '0';
				elsif s_hsync_cnt > 200 and s_hsync_cnt <= 300 then
					s_red <= '0';
					s_green <= '0';
					s_blue <= '1';
				elsif s_hsync_cnt > 300 and s_hsync_cnt <= 400 then
					s_red <= '1';
					s_green <= '1';
					s_blue <= '0';
				elsif s_hsync_cnt > 400 and s_hsync_cnt <= 500 then
					s_red <= '1';
					s_green <= '0';
					s_blue <= '1';
				elsif s_hsync_cnt > 500 and s_hsync_cnt <= 600 then
					s_red <= '0';
					s_green <= '1';
					s_blue <= '1';
				elsif s_hsync_cnt > 600 and s_hsync_cnt <= 700 then
					s_red <= '1';
					s_green <= '1';
					s_blue <= '1';
				else
					s_red <= '0';
					s_green <= '0';
					s_blue <= '0';
				end if;
			else
				s_red <= din(2);
				s_blue <= din(1);
				s_green <= din(0);
			end if;

		end if;
	end process;

	hsync <= s_hsync;
	vsync <= s_vsync;
	red <= s_red;
	green <= s_green;
	blue <= s_blue;

end bhv;



