library IEEE;
use IEEE.std_logic_1164.all;
use work.common.all;

entity display_controller is
  port (
    clk_i : in std_logic;
    bcd_i : in bcd_array;
    seg_o : out std_logic_vector(0 to 6);
    anodos_o : out std_logic_vector(0 to 3)
  );
end display_controller;

architecture behaviour of display_controller is

  signal counter_o : std_logic_vector(0 to 1);
  signal enable_gen_o : std_logic;
  signal current_bcd : std_logic_vector (0 to 3);

  begin
  counter: counter_2bit port map(
    clk_i,
    enable_gen_o,
    '0',
    counter_o
  );

  enable_generator: enable_gen
    generic map (ENABLE_DIV)
    port map (
    clk_i,
    enable_gen_o
  );

  deco: deco_2to4 port map (
    counter_o,
    anodos_o
  );

  bcd_converter: bcd_to_7seg port map(
    current_bcd, seg_o
  );

  mux: mux_16to4 port map(
    counter_o, bcd_i, current_bcd
  );
end behaviour;

