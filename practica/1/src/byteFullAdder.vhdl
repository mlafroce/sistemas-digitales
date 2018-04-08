library IEEE;
use IEEE.std_logic_1164.all;


entity byteFullAdder is
  port (
    a : in std_logic_vector(7 downto 0);
    b : in std_logic_vector(7 downto 0);
    sum : out std_logic_vector(7 downto 0)
  );
end byteFullAdder;

architecture behaviour of byteFullAdder is

signal carryVec : std_logic_vector(7 downto 0);

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
  GEN_ADD: for I in 0 to 7 generate

    LOWER_BIT: if I=0 generate
      U0: fullAdder port map
         (a(I), b(I), '0', sum(I), carryVec(I));
    end generate LOWER_BIT;

    UPPER_BITS: if I>0 generate
      UX: fullAdder port map
         (a(I), b(I), carryVec(I-1), sum(I), carryVec(I));
    end generate UPPER_BITS;

  end generate GEN_ADD;
end behaviour;
