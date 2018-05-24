library IEEE;
use IEEE.std_logic_1164.all;


entity deco_2to4 is
  port (
    selector_i : in std_logic_vector(0 to 1);
    output_o : out std_logic_vector(0 to 3)
  );
end deco_2to4;

architecture behaviour of deco_2to4 is
begin

process (selector_i)
begin
    case selector_i is
        --                       abcdefg
        when "00" => output_o <= "0111";
        when "01" => output_o <= "1011";
        when "10" => output_o <= "1101";
        when "11" => output_o <= "1110";
        when others => output_o <= "1111";
    end case;

end process;

end behaviour;
