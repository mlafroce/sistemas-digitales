import cocotb
from cocotb.triggers import Timer
from cocotb.result import TestFailure


@cocotb.test()
def mux4to1_test(dut):
    test_input = "1011"
    dut.input_i = int(test_input, 2)
    yield Timer(2)
    for i in range(0, 4):
        dut.selector_i = i
        yield Timer(2)
        if str(dut.output_o) != test_input[i]:
            raise TestFailure("FAIL {0}: {1} Expected, got {2}"
                .format(i, test_input[i], dut.output_o))

