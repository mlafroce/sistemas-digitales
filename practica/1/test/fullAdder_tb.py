import cocotb
from cocotb.triggers import Timer
from cocotb.result import TestFailure

class AdderModel():
    def __init__(self, a, b, cin):
        full_sum = a + b + cin
        self.sum = full_sum % 2
        self.cout = full_sum > 1

@cocotb.test()
def adder_basic_test(dut):
    for i in xrange(0,8):
        test_a = i%2
        test_b = (i >> 1)%2
        test_cin = (i >> 2)%2

        yield Timer(2)
        dut.a = test_a
        dut.b = test_b
        dut.cin = test_cin

        model = AdderModel(test_a, test_b, test_cin)

        yield Timer(2)
        if dut.sum != model.sum or dut.cout != model.cout:
            raise TestFailure("{0}+{1} (carry in: {2}) =  Failed"
                .format(test_a, test_b, test_cin))

