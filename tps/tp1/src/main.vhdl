library IEEE;
use IEEE.std_logic_1164.all;
use work.common.all;

entity tp is
  port(
    clk_i: in std_logic;
    rst_i: in std_logic;
    seg_o: out std_logic_vector(0 to 6);
    anodos_o: out std_logic_vector(0 to 3)
  );
  -- Mapeo de pines
  attribute loc: string;
    
  attribute loc of clk_i: signal is "B8";
  attribute loc of rst_i: signal is "B18";
  attribute loc of seg_o: signal is "L18 F18 D17 D16 G14 J17 H14 C17";
  attribute loc of anodos_o:  signal is "F17 H17 C18 F15";
end tp;

architecture behaviour of tp is

signal bcd_s : bcd_array := ("0000","0000","0000","0000");
signal bcd_carry_o_s : std_logic_vector(0 to 3) := "0000";
signal en_s : std_logic := '0';

begin
  -- Instanciacion del componente a probar
  display_controller_inst: display_controller
    port map(
      clk_i => clk_i,
      bcd_i => bcd_s,
      seg_o => seg_o,
      anodos_o => anodos_o

    );

  enable_generator: enable_gen
    generic map (BCD_ENABLE_DIV)
    port map (
    clk_i,
    en_s
  );

  counter_g: for I in 0 to 3 generate

    bcd0: if I=0 generate
      bcd0inst: bcd_counter port map
         (clk_i, en_s, rst_i, bcd_s(I), bcd_carry_o_s(I));
    end generate bcd0;

    bcdX: if I>0 generate
      bcd0inst: bcd_counter port map
        (clk_i, bcd_carry_o_s(I-1), rst_i, bcd_s(I), bcd_carry_o_s(I));
    end generate bcdX;

  end generate counter_g;
end behaviour;