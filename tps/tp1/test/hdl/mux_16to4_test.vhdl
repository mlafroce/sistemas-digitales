library IEEE;
use IEEE.std_logic_1164.all;
use work.common.all;

entity mux_16to4_test is
end;

architecture behaviour of mux_16to4_test is

component mux_16to4 is
  port (
    selector_i : in std_logic_vector(0 to 1);
    input_i : in bcd_array;
    output_o : out std_logic_vector(0 to 3)
  );
end component mux_16to4;

signal selector_t : std_logic_vector(0 to 1) := "00";
-- 0001
-- 0011
-- 0101
-- 0100
signal input_t : bcd_array := ("0001", "0011", "0101", "0100");
signal output_t : std_logic_vector(0 to 3);

begin
  -- Instanciacion del componente a probar
  mux_16to4_inst: mux_16to4
    port map(
      selector_i => selector_t,
      input_i => input_t,
      output_o => output_t
    );

  -- Senales de prueba
  process 
  begin
  selector_t <= "00";
  wait for 20 ns;
  selector_t <= "01";
  wait for 20 ns;
  selector_t <= "10";
  wait for 20 ns;
  selector_t <= "11";
  wait for 20 ns;
  end process;
end behaviour;