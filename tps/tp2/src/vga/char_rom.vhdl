library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity char_rom is
  generic(
    N: integer:= 6;
    M: integer:= 3;
    W: integer:= 8
  );
  port(
    char_idx_i: in std_logic_vector(3 downto 0);
    font_row_i, font_col_i: in std_logic_vector(M-1 downto 0);
    rom_o: out std_logic
  );
end;

architecture p of char_rom is
  subtype tipoLinea is std_logic_vector(0 to W-1);

  type char is array(0 to W-1) of tipoLinea;
  constant N0: char:= (
                "00111100",
                "01100110",
                "01100110",
                "01100110",
                "01100110",
                "01100110",
                "00111100",
                "00000000"
            );
  constant N1: char:= (
                "00001100",
                "00011100",
                "00111100",
                "00001100",
                "00001100",
                "00001100",
                "00111111",
                "00000000"
            );
  constant N2: char:= (
                "00111110",
                "01100011",
                "00000011",
                "00000110",
                "00001100",
                "00011000",
                "01111111",
                "00000000"
            );

  constant N3: char:= (
                "00111100",
                "01100110",
                "00000110",
                "00011100",
                "00000110",
                "01100110",
                "00111100",
                "00000000"
            );

  constant N4: char:= (
                "00000110",
                "00001110",
                "00011110",
                "00110110",
                "01111110",
                "00000110",
                "00001111",
                "00000000"
            );

  constant N5: char:= (
                "01111110",
                "01100000",
                "01100000",
                "01111100",
                "00000110",
                "00000110",
                "01111100",
                "00000000"
            );

  constant N6: char:= (
                "00111100",
                "01100010",
                "01100000",
                "01111110",
                "01100110",
                "01100110",
                "00111100",
                "00000000"
            );

  constant N7: char:= (
                "01111110",
                "00001100",
                "00001100",
                "00011000",
                "00011000",
                "00110000",
                "01110000",
                "00000000"
            );
            
  constant N8: char:= (
                "00111100",
                "01100110",
                "01100110",
                "00111100",
                "01100110",
                "01100110",
                "00111100",
                "00000000"
            );
            
  constant N9: char:= (
                "00111100",
                "01100110",
                "01100110",
                "00111110",
                "00000110",
                "00000110",
                "00011110",
                "00000000"
            );
            
  constant V: char:= (
                "00000000",
                "01100110",
                "01100110",
                "01100110",
                "00111100",
                "00111100",
                "00011000",
                "00000000"
            );
    constant EMPTY: char := (
               "00000000",
                "00000000",
                "00000000",
                "00000000",
                "00000000",
                "00000000",
                "00000000",
                "00000000"
    );
            

  type memo is array(0 to 15) of char;
  constant RAM: memo:= (N0, N1, N2, N3, N4, N5, N6, N7, N8, N9, V, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY);
  
  
begin
process (char_idx_i, font_row_i, font_col_i)
begin
  rom_o <= RAM(to_integer(unsigned(char_idx_i)))(to_integer(unsigned(font_row_i)))(to_integer(unsigned(font_col_i)));
end process;
end;