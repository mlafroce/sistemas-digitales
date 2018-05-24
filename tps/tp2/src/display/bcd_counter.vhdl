library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bcd_counter is
  port (
    clk_i : in std_logic;
    en_i : in std_logic;
    rst_i : in std_logic;
    cnt_o : out std_logic_vector(3 downto 0);
    carry_o : out std_logic
  );
end bcd_counter;

architecture behaviour of bcd_counter is
begin

process (clk_i)
variable count_v: integer range 0 to 10 := 0;
begin
    if rising_edge(clk_i) then
        if en_i = '1' then
            count_v := count_v + 1;

            if count_v = 10 then
                carry_o <= '1';
                count_v := 0;
            end if; -- end if count

        else -- else if en_i = '0'
            carry_o <= '0';
        end if; -- end if en_i
        if rst_i = '1' then
            count_v := 0;
            carry_o <= '0';
        end if; -- rst_i
        
    end if; -- clk_i
    cnt_o <= std_logic_vector(to_unsigned(count_v, cnt_o'length));

end process;
end behaviour;
