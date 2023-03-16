library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity tea64 is
   port(
      key : in std_logic_vector(127 downto 0);
      text : in std_logic_vector(63 downto 0);
      cipher : out std_logic_vector(63 downto 0)
      );      
end tea64;

architecture Behavioral of tea64 is
   type teaA is array (64 downto 0) of std_logic_vector(31 downto 0);
   signal v0,v1,sum,feistelOut,feistelKey0,feistelKey1 : teaA;
   signal k0,k1,k2,k3 : std_logic_vector(31 downto 0);
begin

   sum(0)  <= x"9e3779b9";
   k0 <= key(31  downto  0);
   k1 <= key(63  downto 32);
   k2 <= key(95  downto 64);
   k3 <= key(127 downto 96);
   v0(0) <= text(31  downto  0);
   v1(0) <= text(63  downto 32);

   general_pipe: for i in 1 to 64 generate
      v1(i) <= v0(i-1) + feistelOut(i);
      v0(i) <= v1(i-1);
   end generate;

   feistel_pipe_odd: for j in 0 to 31 generate
      sum(2*j+1) <= sum(2*j);
      feistelOut(2*j+1) <= (v1(2*j) + sum(2*j)) xor ((v1(2*j)(27 downto 0) & "0000") + k0) xor (("00000" & v1(2*j)(31 downto 5)) + k1);
   end generate;

   feistel_pipe_even: for k in 1 to 32 generate
      sum(2*k) <= sum(2*k-1) + x"9e3779b9";
      feistelOut(2*k) <= (v1(2*k-1) + sum(2*k-1)) xor ((v1(2*k-1)(27 downto 0) & "0000") + k2) xor (("00000" & v1(2*k-1)(31 downto 5)) + k3);
   end generate;

   cipher <= v1(64) & v0(64);

end Behavioral;

