library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sys is
port ( 
	clk : in std_logic;
	rst : in std_logic;

	vga_red   : out std_logic;
	vga_green : out std_logic;
	vga_blue  : out std_logic;
	vga_hsync : out std_logic;
	vga_vsync : out std_logic
);
end sys;

architecture rtl of sys is

component pll
port (
	areset : in std_logic;
	inclk0 : in std_logic;
	c0     : out std_logic;
	c1     : out std_logic;
	locked : out std_logic
);
end component;

component cpu
port (
	clk  : in std_logic;
	rst  : in std_logic;
	addr : out std_logic_vector(15 downto 1);
	din  : in std_logic_vector(15 downto 0);
	dout : out std_logic_vector(15 downto 0);
	rd   : out std_logic;
	wr   : out std_logic;
	lbe  : out std_logic;
	hbe  : out std_logic;
	irq  : in std_logic_vector(14 downto 0);
	iack : out std_logic_vector(14 downto 0);
	halt : in std_logic
);
end component;

component ram
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
end component;

component led
port ( 
	clk  : in std_logic;
	rst  : in std_logic;
	addr : in std_logic_vector(2 downto 0);
	din  : in std_logic_vector(15 downto 0);
	dout : out std_logic_vector(15 downto 0);
	rd   : in std_logic;
	wr   : in std_logic;
	lbe  : in std_logic;
	hbe  : in std_logic;
	led_o  : out std_logic_vector(15 downto 0)
);
end component;

component vga
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
end component;

signal rst1 : std_logic := '0';
signal rst2 : std_logic := '0';
signal rst3 : std_logic := '0';

signal clk_50MHz : std_logic;
signal clk_25MHz : std_logic;
signal pll_locked : std_logic;

signal addr : std_logic_vector(14 downto 0);
signal addr_d : std_logic_vector(14 downto 0);
signal cpu_din : std_logic_vector(15 downto 0);
signal cpu_dout : std_logic_vector(15 downto 0);
signal rd : std_logic;
signal wr : std_logic;
signal lbe : std_logic;
signal hbe : std_logic;
signal irq : std_logic_vector(14 downto 0);
signal iack :  std_logic_vector(14 downto 0);
signal halt : std_logic;

signal ram_dout : std_logic_vector(15 downto 0);
signal ram_wr : std_logic;
signal ram_rd : std_logic;

signal led_dout : std_logic_vector(15 downto 0);
signal led_wr : std_logic;
signal led_rd : std_logic;
signal led_o : std_logic_vector(15 downto 0);

begin

	process(clk)
	begin
		if clk'event and clk = '1' then
			rst1 <= not rst;
			rst2 <= rst1;
		end if;
	end process;

	pll_1: pll
	port map (
		areset => rst2,
		inclk0 => clk,
		c0     => clk_50MHz,
		c1     => clk_25MHz,
		locked => rst3
	);

	cpu_1 : cpu
	port map (
		clk  => clk_25MHz,
		rst  => rst3,
		addr => addr,
		din  => cpu_din,
		dout => cpu_dout,
		rd   => rd,
		wr   => wr,
		lbe  => lbe,
		hbe  => hbe,
		irq  => irq,
		iack => iack,
		halt => halt
	);

	ram_1 : ram
	port map (
		clk  => clk_25MHz,
		rst  => rst3,
		addr => addr,
		din  => cpu_dout,
		dout => ram_dout,
		rd   => ram_rd,
		wr   => ram_wr,
		lbe  => lbe,
		hbe  => hbe
	);

	led_1 : led
	port map (
		clk  => clk_25MHz,
		rst  => rst3,
		addr => addr(2 downto 0),
		din  => cpu_dout,
		dout => led_dout,
		rd   => led_rd,
		wr   => led_wr,
		lbe  => lbe,
		hbe  => hbe,
		led_o  => led_o
	);

	vga_1: vga
	port map (
		clk	=> clk_50MHz,
		reset	=> rst3,

		addr	=> addr,
		din	=> led_o(7 downto 0),

		red	=> vga_red,	-- test3h
		green	=> vga_green,	-- test2l
		blue	=> vga_blue,	-- display_c1
		hsync	=> vga_hsync,	-- inj_start_ctrl_o
		vsync	=> vga_vsync	-- test6l_o
	);

	process(clk_25MHz, rst3)
	begin
		if rst3 = '0' then
			addr_d <= (others => '0');
		elsif clk_25MHz'event and clk_25MHz = '1' then
			addr_d <= addr;		-- data to cpu is delayed due to sync ram
		end if;
	end process;

	cpu_din <= ram_dout when addr_d(14 downto 12) = "111" else
		   led_dout when addr_d(14 downto 3) = x"000" else
		   x"0000";

	ram_wr <= wr when addr(14 downto 12) = "111" else '0';
	ram_rd <= rd when addr(14 downto 12) = "111" else '0';
	led_wr <= wr when addr(14 downto 3) = x"000" else '0';
	led_rd <= rd when addr(14 downto 3) = x"000" else '0';

	irq <= (others => '0');
	halt <= '0';

end rtl;






