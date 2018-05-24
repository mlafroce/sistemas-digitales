library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity char_rom_test is
end;

architecture behaviour of char_rom_test is

signal char_idx_t : std_logic_vector(3 downto 0) := "0000";
signal font_row_t : std_logic_vector(2 downto 0) := "000";
signal font_col_t : std_logic_vector(2 downto 0) := "000";
signal rom_t : std_logic := '0';

component char_rom is
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
end component char_rom;

begin
  -- Instanciacion del componente a probar
  char_rom_inst: char_rom
    port map(
      char_idx_i => char_idx_t,
      font_row_i => font_row_t,
      font_col_i => font_col_t,
      rom_o => rom_t
    );

  -- Senales de prueba
  process -- clk process
  begin
  char_idx_t <= "0000";
  wait for 640 ns;
  end process;

  process
  variable row_v, col_v : integer range 0 to 7 := 0;
  begin
  wait for 10 ns;
  if col_v = 7 then
    col_v := 0;
    if row_v = 7 then
      row_v := 0;
    else
      row_v := row_v + 1;
    end if;
  else
    col_v := col_v + 1;
  end if;
  font_row_t <= std_logic_vector(to_unsigned(row_v, font_row_t'length));
  font_col_t <= std_logic_vector(to_unsigned(col_v, font_col_t'length));
  end process;

end behaviour;
