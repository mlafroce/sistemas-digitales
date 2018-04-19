library IEEE;
use IEEE.std_logic_1164.all;
use work.common.all;

entity tp1 is
end tp1;

architecture behaviour of tp1 is
signal clk_s : std_logic := '0';
signal rst_s : std_logic := '0';
signal bcd_s : bcd_array;
signal seg_s : std_logic_vector(0 to 6);
signal anodos_s : std_logic_vector(0 to 3);
signal bcd_carry_o_s : std_logic_vector(0 to 3);
signal en_s : std_logic := '0';

begin
  -- Instanciacion del componente a probar
  display_controller_inst: display_controller
    port map(
      clk_i => clk_s,
      bcd_i => bcd_s,
      seg_o => seg_s,
      anodos_o => anodos_s
    );

  enable_generator: enable_gen
    generic map (BCD_ENABLE_DIV)
    port map (
    clk_s,
    en_s
  );

  GEN_ADD: for I in 0 to 3 generate

    bcd0: if I=0 generate
      bcd0inst: bcd_counter port map
         (clk_s, en_s, rst_s, bcd_s(I), bcd_carry_o_s(I));
    end generate bcd0;

    bcdX: if I>0 generate
      bcd0inst: bcd_counter port map
        (clk_s, bcd_carry_o_s(I-1), rst_s, bcd_s(I), bcd_carry_o_s(I));
    end generate bcdX;

  end generate GEN_ADD;
end behaviour;