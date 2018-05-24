library IEEE;
use IEEE.std_logic_1164.all;


entity bcd_to_7seg is
  port (
    bcd_i : in std_logic_vector(0 to 3);
    seg_o : out std_logic_vector(0 to 6)
  );
end bcd_to_7seg;

architecture behaviour of bcd_to_7seg is
begin

process (bcd_i)
begin

-- Patitas de un 7 segmentos
-- .a.
-- f.b
-- .g.
-- e.c
-- .d.

    case bcd_i is
        --                       abcdefg
        when "0000" => seg_o <= "0000001";
        when "0001" => seg_o <= "1001111";
        when "0010" => seg_o <= "0010010";
        when "0011" => seg_o <= "0000110";
        when "0100" => seg_o <= "1001100";
        when "0101" => seg_o <= "0100100";
        when "0110" => seg_o <= "0100001";
        when "0111" => seg_o <= "0001111";
        when "1000" => seg_o <= "0000000";
        when "1001" => seg_o <= "0000100";
        when others => seg_o <= "1111111";
    end case;

end process;

end behaviour;
