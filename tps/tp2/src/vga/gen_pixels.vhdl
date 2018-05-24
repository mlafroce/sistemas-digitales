---------------------------------------------------------
--
-- Generador de pixeles para la VGA
-- Version actualizada a 07/06/2016
--
-- Modulos:
-- 
--
---------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.common.all;

entity gen_pixels is
  port(
    clk_i, rst_i: in std_logic;
    bcd_i: in bcd_array;
    pixel_x_i, pixel_y_i : in std_logic_vector(9 downto 0);
    ena_i: in std_logic;
    rgb_o : out std_logic_vector(2 downto 0)
  );
  
end gen_pixels;

architecture gen_pixels_arch of gen_pixels is

  signal rgb_s, char_s: std_logic_vector(2 downto 0);
  signal index_s: bcd_array;

begin
  char_mapper_inst : char_mapper port map(
    bcd_i => index_s,
    pixel_x_i => pixel_x_i,
    pixel_y_i => pixel_y_i,
    rgb_o => char_s
  );
  process(clk_i, rst_i)
  begin
  if rst_i = '1' then
      rgb_s <= (others => '0');
    elsif rising_edge(clk_i) then
    if (to_integer(unsigned(pixel_y_i)) < 280) or (to_integer(unsigned(pixel_y_i)) > 320) then
      if ((pixel_x_i(0) xor pixel_y_i(0)) = '0') then
          rgb_s <= "111";
      else
        rgb_s <= "001";
      end if;
    else
      rgb_s <= char_s;
    end if;
  end if;
  end process;

  rgb_o <= rgb_s when ena_i = '1' else "000";

end gen_pixels_arch;