library IEEE;
use IEEE.std_logic_1164.all;

package common is

  -- Types
  type bcd_array is array (0 to 3) of std_logic_vector(0 to 3);
  type pixel_pos is array(9 downto 0) of std_logic;

  -- Constants
  constant DISPLAY_ENABLE_DIV : integer := 50000;
  constant BCD_ENABLE_DIV : integer := 10E6;

  -- Components
  component gen_pixels is
    port(
      clk_i, rst_i: in std_logic;
      bcd_i: in bcd_array;
      pixel_x_i, pixel_y_i : in std_logic_vector(9 downto 0);
      ena_i: in std_logic;
      rgb_o : out std_logic_vector(2 downto 0)
  );
  end component gen_pixels;

  component vga_ctrl is
    port(
      clk_i, rst_i: in std_logic;
      bcd_i: in bcd_array;
      hsync_o , vsync_o : out std_logic;
      rgb_o : out std_logic_vector(2 downto 0)
  );
  end component vga_ctrl;

  component char_mapper is
    port (
    bcd_i: in bcd_array;
    pixel_x_i : in std_logic_vector(9 downto 0);  -- posicion horizontal del pixel
    pixel_y_i : in std_logic_vector(9 downto 0);  -- posicion vertical del pixel
    rgb_o : out std_logic_vector(2 downto 0)
  );
  end component char_mapper;

  component char_rom is
  generic(
    N: integer:= 6;
    M: integer:= 3;
    W: integer:= 8
  );
  port(
    char_idx_i: in std_logic_vector(3 downto 0);
    font_row_i, font_col_i: in std_logic_vector(M-1 downto 0);
    rom_o: out std_logic
  );
  end component char_rom;

  -- End
end common;
