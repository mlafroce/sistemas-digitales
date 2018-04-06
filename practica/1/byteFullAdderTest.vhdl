library IEEE;
use IEEE.std_logic_1164.all;

entity byteFullAdderTest is
end;

architecture behaviour of byteFullAdderTest is

signal a_t : std_logic_vector (7 downto 0) := "00001111" ;
signal b_t : std_logic_vector (7 downto 0) := "00001001" ;
signal sum_t : std_logic_vector (7 downto 0);

component byteFullAdder is
  port (
    a : in std_logic_vector(7 downto 0);
    b : in std_logic_vector(7 downto 0);
    sum : out std_logic_vector(7 downto 0)
  );
end component byteFullAdder;

begin
  -- Instanciacion del componente a probar
  byteAdderInst: byteFullAdder
    port map(
      a => a_t,
      b => b_t,
      sum => sum_t
    );

  -- Senales de prueba
  process 
  begin
  a_t(5) <= '1' after 10 ns;
  b_t(5) <= '1' after 20 ns;
  wait for 100 ns;
  end process;
end behaviour;
