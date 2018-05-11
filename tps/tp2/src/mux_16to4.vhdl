library IEEE;
use IEEE.std_logic_1164.all;
use work.common.all;

entity mux_16to4 is
  port (
    selector_i : in std_logic_vector(0 to 1);
    input_i : in bcd_array;
    output_o : out std_logic_vector(0 to 3)
  );
end mux_16to4;

architecture behaviour of mux_16to4 is
signal input_t : bcd_array;

begin
gen_t1: for I in 0 to 3 generate
  gen_t2: for J in 0 to 3 generate
    input_t(I)(J) <= input_i(J)(I);
  end generate gen_t2;
end generate gen_t1;

gen_mux: for I in 0 to 3 generate
  mux : mux_4to1 port map
    (selector_i,
    input_t(I),
    output_o(I));
end generate gen_mux;

end behaviour;
