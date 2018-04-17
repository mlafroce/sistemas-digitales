library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity enable_gen is
  generic (ENABLE_DIV: integer := 100);
  port (
    clk_i : in std_logic;
    en_o : out std_logic := '0'
  );
end enable_gen;

architecture behaviour of enable_gen is
begin

process (clk_i)
variable count_v: integer := ENABLE_DIV - 2;
begin
    if rising_edge(clk_i) then
        count_v := count_v - 1;

        if count_v = 0 then
            en_o <= '1';
            count_v := ENABLE_DIV;
        else
            en_o <= '0';
        end if;       
    end if; -- clk_i
end process;
end behaviour;
