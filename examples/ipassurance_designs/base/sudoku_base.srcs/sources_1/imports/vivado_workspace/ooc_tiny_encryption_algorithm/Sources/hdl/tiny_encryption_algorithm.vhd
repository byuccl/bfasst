library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity tiny_encryption_algorithm is
   port(
      clock, reset : in std_logic;
      start : in std_logic;
      ready : out std_logic;
      key : in std_logic_vector(127 downto 0);
      text : in std_logic_vector(63 downto 0);
      cipher : out std_logic_vector(63 downto 0)
      );      
end tiny_encryption_algorithm;

architecture Behavioral of tiny_encryption_algorithm is
   signal cnt : std_logic_vector(6 downto 0);
   signal k0,k1,k2,k3,v0,v1,sum,feistelOut,feistelKey0,feistelKey1 : std_logic_vector(31 downto 0);
begin

   fcontrolling_fsm:process(reset, clock)
   begin
      if rising_edge(clock) then
         if reset = '1' then
            cnt <= (others => '1');
         elsif cnt(6) = '1' then
            if start = '1' then
               cnt <= (others => '0');
            end if;
         else
            cnt <= cnt + '1';
         end if;
      end if;
   end process;

   encryption:process(clock)
   begin
      if rising_edge(clock) then
         if cnt(6) = '1' then
            sum  <= x"9e3779b9";
            k0 <= key(31  downto  0);
            k1 <= key(63  downto 32);
            k2 <= key(95  downto 64);
            k3 <= key(127 downto 96);
            v0 <= text(31  downto  0);
            v1 <= text(63  downto 32);
         else
            if cnt(0) = '1' then 
               sum <= sum + x"9e3779b9";
            end if;
            v1 <= v0 + feistelOut;
            v0 <= v1;
         end if;
      end if;
   end process;

   --encryption asynchron parts
   feistelKey0 <= k0 when cnt(0) = '0' else k2;
   feistelKey1 <= k1 when cnt(0) = '0' else k3;
   feistelOut <= (v1 + sum) xor ((v1(27 downto 0) & "0000") + feistelKey0) xor (("00000" & v1(31 downto 5)) + feistelKey1);

   --output   
   cipher <= v1 & v0;
   ready <= cnt(6);

end Behavioral;

