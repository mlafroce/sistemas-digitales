library IEEE;
use IEEE.std_logic_1164.all;

package common is
  -- Types
  type bcd_array is array (0 to 3) of std_logic_vector(0 to 3);
  -- Constants
  constant DISPLAY_ENABLE_DIV : integer := 100;
  constant BCD_ENABLE_DIV : integer := 1000;
  -- Components
  component bcd_counter is
  port (
    clk_i : in std_logic;
    en_i : in std_logic;
    rst_i : in std_logic;
    cnt_o : out std_logic_vector(3 downto 0);
    carry_o : out std_logic
  );
  end component bcd_counter;

  component bcd_to_7seg is
    port (
      bcd_i : in std_logic_vector(0 to 3);
      seg_o : out std_logic_vector(0 to 6)
    );
  end component bcd_to_7seg;

  component counter_2bit is
  port (
    clk_i : in std_logic;
    en_i : in std_logic;
    rst_i : in std_logic;
    cnt_o : out std_logic_vector(1 downto 0)
  );
  end component counter_2bit;

  component deco_2to4 is
  port (
    selector_i : in std_logic_vector(0 to 1);
    output_o : out std_logic_vector(0 to 3)
  );
  end component deco_2to4;

  component enable_gen is
  generic (ENABLE_DIV: integer);
  port (
    clk_i : in std_logic;
    en_o : out std_logic := '0'
  );
  end component enable_gen;

  component mux_4to1 is
  port (
    selector_i : in std_logic_vector(0 to 1);
    input_i : in std_logic_vector(0 to 3);
    output_o : out std_logic
  );
  end component mux_4to1;

  component mux_16to4 is
    port (
      selector_i : in std_logic_vector(0 to 1);
      input_i : in bcd_array;
      output_o : out std_logic_vector(0 to 3)
    );
  end component mux_16to4;

  component display_controller is
  port (
    clk_i : in std_logic;
    bcd_i : in bcd_array;
    seg_o : out std_logic_vector(0 to 6);
    anodos_o : out std_logic_vector(0 to 3)
  );
  end component display_controller;

  -- End
end common;