import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge
from cocotb.result import TestFailure

TEST_CYCLES = 1000

@cocotb.test()
def counter2bit_test_enabled(dut):
    # Inicializo un clock
    # Ejecuto N ciclos del reloj y comparo la salida en cada uno de ellos
    cocotb.fork(Clock(dut.clk_i, 100, units='ns').start())
    dut.en_i = 1;
    # Espero para setear en_i = 1
    yield Timer(1)
    for i in range(0, TEST_CYCLES):
        valueExpected = int(i % 4)
        yield RisingEdge(dut.clk_i)
        if dut.cnt_o != valueExpected:
            raise TestFailure("FAIL at cycle {0}: {1} Expected, got {2}"
                .format(i, valueExpected, dut.cnt_o))
    