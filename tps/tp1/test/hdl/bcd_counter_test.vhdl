library IEEE;
use IEEE.std_logic_1164.all;

entity bcd_counter_test is
end;

architecture behaviour of bcd_counter_test is

signal clk_t : std_logic := '0';
signal en_t : std_logic := '0';
signal rst_t : std_logic := '0';
signal cnt_t : std_logic_vector(3 downto 0);
signal carry_t : std_logic := '0';

component bcd_counter is
  port (
    clk_i : in std_logic;
    en_i : in std_logic;
    rst_i : in std_logic;
    cnt_o : out std_logic_vector(3 downto 0);
    carry_o : out std_logic
  );
end component bcd_counter;

begin
  -- Instanciacion del componente a probar
  bcd_counterInst: bcd_counter
    port map(
      clk_i => clk_t,
      en_i => en_t,
      rst_i => rst_t,
      cnt_o => cnt_t,
      carry_o => carry_t
    );

  -- Senales de prueba
  process -- clk process
  begin
  clk_t <= not clk_t after 5 ns, not clk_t after 10 ns;
  wait for 10 ns;
  end process;

  process
  begin
  en_t <= '1' after 45 ns, '0' after 55 ns;
  wait for 60 ns;
  end process;

  process
  begin
  rst_t <= '1' after 300 ns, '0' after 310 ns;
  wait for 310 ns;
  end process;
end behaviour;