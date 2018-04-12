library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bcd_counter is
  port (
    clk_i : in std_logic;
    en_i : in std_logic;
    rst_i : in std_logic;
    cnt_o : out std_logic_vector(3 downto 0)
  );
end bcd_counter;

architecture behaviour of bcd_counter is
begin

process (en_i)
variable count_v: integer := 0;
begin
    if rising_edge(en_i) then
        count_v := count_v + 1;
        if count_v = 10 then
            count_v := 0;
        end if;
    end if;
    cnt_o <= std_logic_vector(to_unsigned(count_v, cnt_o'length));

end process;
end behaviour;
