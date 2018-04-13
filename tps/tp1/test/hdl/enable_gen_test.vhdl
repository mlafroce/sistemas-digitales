library IEEE;
use IEEE.std_logic_1164.all;

entity enable_gen_test is
end;

architecture behaviour of enable_gen_test is

signal clk_t : std_logic := '0';
signal en_t : std_logic := '0';

component enable_gen is
  port (
    clk_i : in std_logic;
    en_o : out std_logic
  );
end component enable_gen;

begin
  -- Instanciacion del componente a probar
  enable_genInst: enable_gen
    port map(
      clk_i => clk_t,
      en_o => en_t
    );

  -- Senales de prueba
  process 
  begin
  clk_t <= '0';
  wait for 5 ns;
  clk_t <= '1';
  wait for 5 ns;
  end process;
end behaviour;
