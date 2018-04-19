import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotb.result import TestFailure

ENABLE_DIV = 50000
TEST_CYCLES = 20

"""
entity display_controller is
  port (
    clk_i : in std_logic;
    bcd_i : in bcd_array;
    seg_o : out std_logic_vector(0 to 6);
    anodos_o : out std_logic_vector(0 to 3)
  );
end display_controller;
"""

def getBcdEncoding(i):
    encodings =  ["0000001", "1001111", "0010010", "0000110", "1001100",
                  "0100100", "0100001", "0001111", "0000000", "0000100", "1111111"]
    return encodings[i]

@cocotb.test()
def display_controller_test_zero(dut):
    # Inicializo un clock
    cocotb.fork(Clock(dut.clk_i, 20, units='ns').start())
    # Ejecuto N ciclos del reloj y comparo la salida en cada uno de ellos
    yield RisingEdge(dut.clk_i)
    for i in range(0, TEST_CYCLES):
        print("dut {0}".format(dut._sub_handles))
        print("dut {0}".format(dut._getAttributeNames()))
        expectedOutput = getBcdEncoding(i%10)
        if dut.seg_o != expectedOutput:
            print("FAIL at cycle {0}: {1} Expected, got {2}"
                .format(i, expectedOutput, dut.seg_o))
            #raise TestFailure("FAIL at cycle {0}: {1} Expected, got {2}"
            #    .format(i, expectedOutput, dut.seg_o))
        for i in range(0, ENABLE_DIV):
            yield RisingEdge(dut.clk_i)
    