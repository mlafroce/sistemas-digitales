library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdderTest is
end;

architecture behaviour of fullAdderTest is

signal a_t : std_logic := '0';
signal b_t : std_logic := '0';
signal cin_t : std_logic := '0';
signal sum_t : std_logic;
signal cout_t : std_logic;

component fullAdder is
  port (
    a : in std_logic;
    b : in std_logic;
    cin : in std_logic;
    sum : out std_logic;
    cout : out std_logic
  );
end component fullAdder;

begin
  -- Instanciacion del componente a probar
  fullAdderInst: fullAdder
    port map(
      a => a_t,
      b => b_t,
      cin => cin_t,
      sum => sum_t,
      cout => cout_t
    );

  -- Senales de prueba
  process 
  begin
  a_t <= '1' after 10 ns;
  b_t <= '1' after 20 ns;
  a_t <= '1' after 30 ns;
  a_t <= '1' after 20 ns;
  cin_t <= '1' after 40 ns;
  wait for 100 ns;
  end process;
end behaviour;
