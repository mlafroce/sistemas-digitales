library IEEE;
use IEEE.std_logic_1164.all;


entity mux_4to1 is
  port (
    selector_i : in std_logic_vector(0 to 1);
    input_i : in std_logic_vector(0 to 3);
    output_o : out std_logic
  );
end mux_4to1;

architecture behaviour of mux_4to1 is
begin

process (selector_i, input_i)
begin

    case selector_i is
        --                       abcdefg
        when "00" => output_o <= input_i(0);
        when "01" => output_o <= input_i(1);
        when "10" => output_o <= input_i(2);
        when "11" => output_o <= input_i(3);
        when others => output_o <= input_i(0);
    end case;

end process;

end behaviour;
