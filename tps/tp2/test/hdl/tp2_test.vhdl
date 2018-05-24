library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tp2_test is
end;

architecture behaviour of tp2_test is

signal clk_t : std_logic := '0';

component tp2 is
  port(
    clk_i: in std_logic := '0';
    rst_i: in std_logic := '0';
    vga_hsync_o: out std_logic;
    vga_vsync_o: out std_logic;
    vga_rgb_o: out std_logic_vector(0 to 2)
  );
end component tp2;

begin
  -- Instanciacion del componente a probar
  tp2_inst: tp2
    port map(
    clk_i => clk_t,
    rst_i => open,
    vga_hsync_o => open,
    vga_vsync_o => open,
    vga_rgb_o => open
    );

  -- Senales de prueba
  process -- clk process
  begin
  clk_t <= not clk_t;
  wait for 20 ns;
  end process;
end behaviour;
