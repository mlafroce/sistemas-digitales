library IEEE;
use IEEE.std_logic_1164.all;
use work.common.all;

entity main_test is
end;

architecture behaviour of main_test is

signal clk_t : std_logic := '0';
signal rst_t : std_logic := '0';
signal seg_t : std_logic_vector(0 to 6);
signal anodos_t : std_logic_vector(0 to 3);

begin
  -- Instanciacion del componente a probar
  main_inst: tp
    port map(
      clk_i => clk_t,
      rst_i => rst_t,
      seg_o => seg_t,
      anodos_o => anodos_t
    );

  -- Senales de prueba
  process 
  begin
  clk_t <= not clk_t;
  wait for 5 ns;
  end process;
end behaviour;