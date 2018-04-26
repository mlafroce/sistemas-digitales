import cocotb
from math import pow
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotb.result import TestFailure

BCD_ENABLE_DIV = 200
DISPLAY_ENABLE_DIV = 20
TEST_CYCLES = 20

"""
entity tp is
  port(
    clk_s: in std_logic;
    rst_s: in std_logic;
    seg_s: out std_logic_vector(0 to 6);
    anodos_s: out std_logic_vector(0 to 3)
  );
end tp;
"""

def getBcdEncoding(i):
    encodings =  ["0000001", "1001111", "0010010", "0000110", "1001100",
                  "0100100", "0100001", "0001111", "0000000", "0000100", "1111111"]
    return encodings[i]

@cocotb.test()
def tp_test_zero(dut):
    dut.rst_i = 0
    # Inicializo un clock
    cocotb.fork(Clock(dut.clk_i, 20, units='ns').start())
    # Ejecuto N ciclos del reloj y comparo la salida en cada uno de ellos
    #yield RisingEdge(dut.clk_i)
    tick_counter = DISPLAY_ENABLE_DIV
    for i in range(0, TEST_CYCLES):
        for bcd in range (0, 4):
            currentMask = int(pow(10, bcd))
            expectedValue = (i%(currentMask*10)) / currentMask
            expectedOutput = getBcdEncoding(expectedValue)
            if str(dut.seg_o) != expectedOutput:
                print("FAIL at cycle {0}: {1} Expected at {3}, got {2}"
                    .format(tick_counter, expectedOutput, dut.seg_o, bcd))
                #raise TestFailure("FAIL at cycle {0}: {1} Expected, got {2}"
                #    .format(i, expectedOutput, dut.seg_o))
            else:
                print("OK at cycle {0}: {1} Expected at {3}, got {2}"
                    .format(tick_counter, expectedOutput, dut.seg_o, bcd))
                
            for display_ticks in range(0, DISPLAY_ENABLE_DIV):
                yield RisingEdge(dut.clk_i)
            tick_counter += DISPLAY_ENABLE_DIV
        for bcd_ticks in range(0, BCD_ENABLE_DIV - DISPLAY_ENABLE_DIV * 4):
            yield RisingEdge(dut.clk_i)
        tick_counter += BCD_ENABLE_DIV - DISPLAY_ENABLE_DIV * 4
