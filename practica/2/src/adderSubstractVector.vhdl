library IEEE;
use IEEE.std_logic_1164.all;


entity adder_substract_vector is
  generic (N: integer := 8);
  port (
    a_i : in std_logic_vector(N-1 downto 0);
    b_i : in std_logic_vector(N-1 downto 0);
    op_i : in std_logic;
    clk_i : in std_logic;
    result_o : out std_logic_vector(N-1 downto 0)
  );
end adder_substract_vector;

architecture behaviour of adder_substract_vector is

component adder_vector is
  generic (N: integer);
  port (
    a_i : in std_logic_vector(N-1 downto 0);
    b_i : in std_logic_vector(N-1 downto 0);
    cin_i : in std_logic;
    clk_i : in std_logic;
    sum_o : out std_logic_vector(N-1 downto 0);
    cout_o : out std_logic
  );
end component adder_vector;

signal addSubB: std_logic_vector(N-1 downto 0);

begin
  adderSubsInst: adder_vector
    generic map(N => N)
    port map(
      a_i => a_i,
      b_i => addSubB,
      cin_i => op_i,
      clk_i => clk_i,
      sum_o => result_o
    );
  op_process : process(clk_i) is
  begin
    if rising_edge(clk_i) then
      if op_i = '0' then
        addSubB <= b_i;
      else
        addSubB <= not b_i;
      end if;
    end if;
  end process op_process;
end behaviour;
