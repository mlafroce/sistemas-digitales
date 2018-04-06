library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdder is
  port (
    a_i : in std_logic;
    b_i : in std_logic;
    cin_i : in std_logic;
    clk_i : in std_logic;
    sum_o : out std_logic;
    cout_o : out std_logic
  );
end fullAdder;

architecture behaviour of fullAdder is
begin
  clk_process : process (clk_i) is
  begin
    if rising_edge(clk_i) then
      -- sum
      sum_o <= a_i xor b_i xor cin_i;
      -- Carry out
      cout_o <= (a_i and b_i) or (a_i and cin_i) or (b_i and cin_i);
    end if;
  end process clk_process;
end behaviour;
