library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is
  port (
    a : in std_logic;
    b : in std_logic;
    cin : in std_logic;
    sum : out std_logic;
    cout : out std_logic
  );
end full_adder;

architecture behaviour of full_adder is
begin
  -- sum
  sum <= a xor b xor cin;
  -- Carry out
  cout <= (a and b) or (a and cin) or (b and cin);
end behaviour;
