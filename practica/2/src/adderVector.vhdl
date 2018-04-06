library IEEE;
use IEEE.std_logic_1164.all;


entity adder_vector is
  generic (N: integer);
  port (
    a_i : in std_logic_vector(N-1 downto 0);
    b_i : in std_logic_vector(N-1 downto 0);
    cin_i : in std_logic;
    clk_i : in std_logic;
    sum_o : out std_logic_vector(N-1 downto 0);
    cout_o : out std_logic
  );
end adder_vector;



architecture behaviour of adder_vector is

signal carryVec : std_logic_vector(N-1 downto 0);

component fullAdder is
  port (
    a_i : in std_logic;
    b_i : in std_logic;
    cin_i : in std_logic;
    clk_i : in std_logic;
    sum_o : out std_logic;
    cout_o : out std_logic
  );
end component fullAdder;

begin
  GEN_ADD: for I in 0 to N-1 generate

    LOWER_BIT: if I=0 generate
      U0: fullAdder port map
         (a_i(I), b_i(I), cin_i, clk_i, sum_o(I), carryVec(I));
    end generate LOWER_BIT;

    UPPER_BITS: if I>0 generate
      UX: fullAdder port map
         (a_i(I), b_i(I), carryVec(I-1), clk_i, sum_o(I), carryVec(I));
    end generate UPPER_BITS;

  end generate GEN_ADD;
end behaviour;
