---------------------------------------------------------
--
-- Controlador de VGA
-- Version actualizada a 07/06/2016
--
-- Modulos:
--    vga_sync
--    gen_pixels
--
---------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.common.all;

entity vga_ctrl is
  port(
    clk_i, rst_i: in std_logic;
    bcd_i: in bcd_array;
    hsync_o , vsync_o : out std_logic;
    rgb_o : out std_logic_vector(2 downto 0)
  );
end vga_ctrl;

architecture vga_ctrl_arch of vga_ctrl is

  signal pixel_x, pixel_y: std_logic_vector(9 downto 0);
  signal video_on: std_logic := '1';

begin
  -- instanciacion del controlador VGA
  vga_sync_unit: entity work.vga_sync
    port map(
      clk   => clk_i,
      rst   => rst_i,
      hsync   => hsync_o,
      vsync   => vsync_o,
      vidon => video_on,
      p_tick  => open,
      pixel_x => pixel_x,
      pixel_y => pixel_y
    );

  pixeles: entity work.gen_pixels
    port map(
      clk_i     => clk_i,
      rst_i     => rst_i,
      bcd_i     => bcd_i,
      pixel_x_i => pixel_x,
      pixel_y_i => pixel_y,
      ena_i     => video_on,
      rgb_o     => rgb_o
    );
    

end vga_ctrl_arch;
