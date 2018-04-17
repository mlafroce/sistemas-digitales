library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter_2bit is
  port (
    clk_i : in std_logic;
    en_i : in std_logic;
    rst_i : in std_logic;
    cnt_o : out std_logic_vector(1 downto 0)
  );
end counter_2bit;

architecture behaviour of counter_2bit is
begin

process (clk_i)
variable count_v: integer := 0;
begin
    if rising_edge(clk_i) then
        if en_i = '1' then
            count_v := count_v + 1;

            if count_v = 4 then
                count_v := 0;
            end if; -- end if count
               
        end if; -- end if en_i
        
    end if; -- clk_i
    cnt_o <= std_logic_vector(to_unsigned(count_v, cnt_o'length));

end process;
end behaviour;
