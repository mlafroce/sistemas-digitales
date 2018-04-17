library IEEE;
use IEEE.std_logic_1164.all;
use work.common.all;

entity display_controller_test is
end;

architecture behaviour of display_controller_test is

component display_controller is
  port (
    clk_i : in std_logic;
    bcd_i : in bcd_array;
    seg_o : out std_logic_vector(0 to 6);
    anodos_o : out std_logic_vector(0 to 3)
  );
end component display_controller;

signal clk_t : std_logic := '0';
signal bcd_t : bcd_array := ("0000", "0001", "0010", "0011");
signal seg_t : std_logic_vector(0 to 6);
signal anodos_t : std_logic_vector(0 to 3);

begin
  -- Instanciacion del componente a probar
  display_controller_inst: display_controller
    port map(
      clk_i => clk_t,
      bcd_i => bcd_t,
      seg_o => seg_t,
      anodos_o => anodos_t
    );

  -- Senales de prueba
  process 
  begin
  clk_t <= '0';
  wait for 20 ns;
  clk_t <= '1';
  wait for 20 ns;
  end process;
end behaviour;