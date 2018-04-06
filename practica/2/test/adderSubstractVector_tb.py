import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge, Edge, Event
from cocotb.result import TestFailure, TestError, ReturnValue, SimFailure
from cocotb.binary import BinaryValue

"""
    a : in std_logic_vector(N-1 downto 0);
    b : in std_logic_vector(N-1 downto 0);
    op : in std_logic;
    result : out std_logic_vector(N-1 downto 0)
"""

class AdderSubstractVectorCtrl:

    def __init__(self, dut):
        self.dut = dut
        self.dut.a_i = 0
        self.dut.b_i = 0
        self.dut.op_i = 0
        self.signal_out = []

    def get_signal(self):
        return self.signal_out

    @cocotb.coroutine
    def set_sum(self, a, b):
        self.dut.a_i = a
        self.dut.b_i = b
        self.dut.op_i = 0
        for i in range(10):
            yield RisingEdge(self.dut.clk_i)
        self.signal_out.append(self.dut.result_o.value.integer)

    @cocotb.coroutine
    def set_subs(self, a, b):
        self.dut.a_i = a
        self.dut.b_i = b
        self.dut.op_i = 1
        for i in range(10):
            yield RisingEdge(self.dut.clk_i)
        self.signal_out.append(self.dut.result_o.value.integer)


@cocotb.test()
def test(dut):
    dut._log.info("> Starting Test")

    # Clock
    cocotb.fork(Clock(dut.clk_i, 10, units='ns').start())

    asvDev = AdderSubstractVectorCtrl(dut)
    yield asvDev.set_sum(3, 5)
    yield asvDev.set_sum(4, 8)
    yield asvDev.set_subs(8, 14)
    dut._log.info("> End of test!")
    signal_out = asvDev.get_signal()
    expected = [8, 12, (-6 % 256)]
    if signal_out != expected:
        raise TestFailure("La salida esperada era %s pero se encontro %s" % (
                          signal_out, expected))
