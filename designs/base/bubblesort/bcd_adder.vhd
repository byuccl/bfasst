library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity bcd_adder is
	generic(
		--DEC_SIZE is the amount of decimal digits. e.g. BCD_ADD_DEC_SIZE = 4 means the highest representable integer is 9999
		DEC_SIZE : positive := 4
	);
	port(
		clk_i  : in  STD_LOGIC;
		a_i    : in  STD_LOGIC_VECTOR(4*DEC_SIZE-1 downto 0);
		b_i    : in  STD_LOGIC_VECTOR(4*DEC_SIZE-1 downto 0);
		sum_o  : out STD_LOGIC_VECTOR(4*DEC_SIZE-1 downto 0);
		cin_i  : in  STD_LOGIC;
		cout_o : out STD_LOGIC
	);
end entity;
architecture behavioral of bcd_adder is

	--input and output registers
	signal a_r    : unsigned(4*DEC_SIZE downto 0);
	signal b_r    : unsigned(4*DEC_SIZE downto 0);
	signal sum_r  : STD_LOGIC_VECTOR(4*DEC_SIZE-1 downto 0);
	signal cin_r  : STD_LOGIC;
	signal cout_r : STD_LOGIC;
	
	--increment6: a function to increment a 4 bit unsigned number by 6.
	function increment6 (number : unsigned(3 downto 0)) return unsigned is
	begin
		return ((number(3) or number(2) or number(1)) & ((number(2) or number(1)) nand (number(2) nand number(1))) & not(number(1)) & number(0));
	end function;
	
	--decrement6: a function to decrement a 4 bit unsigned number by 6.
	function decrement6 (number : unsigned(3 downto 0)) return unsigned is
	begin
		return ((number(3) and number(2) and number(1)) & (number(2) xor number(1)) & not(number(1)) & number(0)); 
	end function;
begin
	process(clk_i)
	
		--BCD_SIZE is the amount of binary digits that are needed for the BCD number. Each decimal digit is 4 bits, so 4*BCD_ADD_DEC_SIZE.
		constant BCD_SIZE : integer := 4*DEC_SIZE;
		variable sum_v 	  : unsigned(BCD_SIZE downto 0);
		variable a_v   	  : unsigned(BCD_SIZE downto 0);
		variable b_v   	  : unsigned(BCD_SIZE downto 0);
		variable cin_v 	  : STD_LOGIC;
	begin
		if rising_edge(clk_i) then
		
			--Put the inputs in the variables, add a leading '0' to store a later carry.
			a_r   <= unsigned('0' & a_i);
			b_r   <= unsigned('0' & b_i);
			cin_r <= cin_i;
			a_v   := a_r;
			b_v   := b_r;
			cin_v := cin_r;
					
			--increment every decimal digit of operand b by 6
			for i in 0 to DEC_SIZE-1 loop
				b_v(4*i+3 downto 4*i) := increment6(b_v(4*i+3 downto 4*i));
			end loop;
			
			--add a, b and the carry_in to form a temporary sum that needs to be corrected
			sum_v := a_v + b_v + ("" & cin_v);
			
			--correction: if the sum of two decimal digits exceeded 9, subtract 6 from the temporary sum
			for j in 0 to DEC_SIZE-1 loop
				if (sum_v(4*j+4) = (a_v(4*j+4) xor b_v(4*j+4))) then
					sum_v(4*j+3 downto 4*j) := decrement6(sum_v(4*j+3 downto 4*j));
				end if;
			end loop;
			
			sum_r  <= STD_LOGIC_VECTOR(sum_v(BCD_SIZE-1 downto 0));
			cout_r <= sum_v(BCD_SIZE);
		end if;
	end process;
	sum_o  <= sum_r;
	cout_o <= cout_r;
end behavioral;