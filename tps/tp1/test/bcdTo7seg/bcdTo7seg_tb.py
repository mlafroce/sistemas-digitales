import cocotb
from cocotb.triggers import Timer
from cocotb.result import TestFailure


@cocotb.test()
def bcd_to_7seg_test(dut):
    # 7 seg output (0: on, 1 off)
    test_expected = ["0000001","1001111","0010010","0000110",
    "1001100","0100100","0100001","0001111","0000000","0000100","1111111"]
    for i in range(0, 10):
        yield Timer(2)
        #bcd_input = "{0:04b}".format(i)
        dut.bcd_i = i
        yield Timer(2)
        if str(dut.seg_o) != test_expected[i]:
            raise TestFailure("FAIL {0}: {1} Expected, got {2}"
                .format(i, test_expected[i], dut.seg_o))

