library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.common.all;

entity char_mapper is
  port (
    bcd_i: in bcd_array;
    pixel_x_i : in std_logic_vector(9 downto 0);  -- posicion horizontal del pixel
    pixel_y_i : in std_logic_vector(9 downto 0);  -- posicion vertical del pixel
    rgb_o : out std_logic_vector(2 downto 0)
  );
end char_mapper;

architecture behaviour of char_mapper is

  signal char_s: std_logic;
  signal index_s: std_logic_vector(3 downto 0);
  signal bcd0_debug : std_logic_vector(3 downto 0) := bcd_i(0);
  signal bcd1_debug : std_logic_vector(3 downto 0) := bcd_i(1);
  signal bcd2_debug : std_logic_vector(3 downto 0) := bcd_i(2);
  signal bcd3_debug : std_logic_vector(3 downto 0) := bcd_i(3);

begin
  char_rom_inst : char_rom port map(
      char_idx_i => index_s,
		font_col_i => pixel_x_i(2 downto 0),
      font_row_i => pixel_y_i(2 downto 0),
      rom_o => char_s
    );
  process(bcd_i)
  begin
  bcd0_debug <= bcd_i(0);
  bcd1_debug <= bcd_i(1);
  bcd2_debug <= bcd_i(2);
  bcd3_debug <= bcd_i(3);
  end process;
  process (pixel_x_i, pixel_y_i, bcd_i, char_s)
    begin
      if to_integer(unsigned(pixel_y_i)) >= 296 and to_integer(unsigned(pixel_y_i)) < 314 then
        case to_integer(unsigned(pixel_x_i)) is
          when 320 to 327 => index_s <= bcd_i(0);
          when 328 to 335 => index_s <= bcd_i(1);
          when 336 to 343 => index_s <= bcd_i(2);
          when 344 to 351 => index_s <= bcd_i(3);
          when 352 to 359 => index_s <= "1010";
          when others =>  index_s <= "1011";
        end case; -- end case x
      else
        index_s <= "1110";
      end if; -- end if pixel_y
      if char_s = '0' then
        rgb_o <= "000";
      else
        rgb_o <= "111";
      end if;
    end process;
end behaviour;
