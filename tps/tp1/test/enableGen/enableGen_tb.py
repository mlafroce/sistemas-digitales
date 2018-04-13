import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotb.result import TestFailure

ENABLE_DIV = 100
TEST_CYCLES = 1000

@cocotb.test()
def enable_gen_test(dut):
    # Inicializo un clock
    cocotb.fork(Clock(dut.clk_i, 100, units='ns').start())
    # Ejecuto N ciclos del reloj y comparo la salida en cada uno de ellos
    # Hay un par de ciclos para que el componente inicie, dado que el primer enable aparece apagado
    counter = 0
    for i in range(1, TEST_CYCLES):
        enableExpected = int(i % ENABLE_DIV == 0)
        yield RisingEdge(dut.clk_i)
        if dut.en_o != enableExpected:
            raise TestFailure("FAIL at cycle {0}: {1} Expected, got {2}"
                .format(i, enableExpected, dut.en_o))
    