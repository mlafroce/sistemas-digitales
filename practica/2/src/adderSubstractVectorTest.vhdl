library IEEE;
use IEEE.std_logic_1164.all;

entity adder_substract_vector_test is
end;

architecture behaviour of adder_substract_vector_test is

signal a_t : std_logic_vector (7 downto 0) := "00001111" ;
signal b_t : std_logic_vector (7 downto 0) := "00001001" ;
signal res_t : std_logic_vector (7 downto 0);
signal op_t : std_logic := '0';

component adder_substract_vector is
  generic (N: integer);
  port (
    a_i : in std_logic_vector(N-1 downto 0);
    b_i : in std_logic_vector(N-1 downto 0);
    op_i : in std_logic;
    result_o : out std_logic_vector(N-1 downto 0)
  );
end component adder_substract_vector;

begin
  -- Instanciacion del componente a probar
  byteAdderInst: adder_substract_vector
    generic map(N => 8)
    port map(
      a_i => a_t,
      b_i => b_t,
      op_i => op_t,
      result_o => res_t
    );

  -- Senales de prueba
  process 
  begin
  wait for 5 ns;
  op_t <= '1';
  wait for 5 ns;
  a_t(5) <= '1';
  wait for 5 ns;
  op_t <= '0';
  wait for 5 ns;
  op_t <= '1';
  end process;
end behaviour;
