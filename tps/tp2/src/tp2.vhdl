library IEEE;
use IEEE.std_logic_1164.all;
use work.common.all;

entity tp2 is
  port(
    clk_i: in std_logic := '0';
    rst_i: in std_logic := '0';
    vga_hsync_o: out std_logic;
    vga_vsync_o: out std_logic;
    vga_rgb_o: out std_logic_vector(0 to 2)
  );
  -- Mapeo de pines
  attribute altera_chip_pin_lc: string;
    
  -- Pines correspondientes a Cyclone II EP2C5 Mini Dev Board 
  attribute altera_chip_pin_lc of clk_i: signal is "@17";
  attribute altera_chip_pin_lc of vga_rgb_o: signal is "@65, @59, @63";
  attribute altera_chip_pin_lc of vga_hsync_o: signal is "@69";
  attribute altera_chip_pin_lc of vga_vsync_o: signal is "@71";
  
end tp2;

architecture behaviour of tp2 is
signal bcd_s : bcd_array := ("0000","0001","0010","0011");

begin
  -- Instanciacion del componente a probar
  vga_ctrl_inst : vga_ctrl
  port map(
    clk_i => clk_i,
    rst_i => '0',
    bcd_i => bcd_s,
    hsync_o => vga_hsync_o,
    vsync_o => vga_vsync_o,
    rgb_o => vga_rgb_o
  );
end behaviour;
