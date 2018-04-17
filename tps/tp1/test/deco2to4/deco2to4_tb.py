import cocotb
from cocotb.triggers import Timer
from cocotb.result import TestFailure

TEST_CYCLES = 100

"""
entity deco_2to4 is
  port (
    selector_i : in std_logic_vector(0 to 1);
    output_o : out std_logic_vector(0 to 3)
  );
end deco_2to4;
"""

@cocotb.test()
def deco_2to4_test(dut):
    # 7 seg output (0: on, 1 off)
    testExpected = ["0001","0010","0100","1000"]
    for i in range(0, TEST_CYCLES):
        currentOutput =  i % 4
        yield Timer(1)
        #bcd_input = "{0:04b}".format(i)
        dut.selector_i = currentOutput
        yield Timer(1)
        if str(dut.output_o) != testExpected[currentOutput]:
            raise TestFailure("FAIL {0}: {1} Expected, got {2}"
                .format(i, testExpected[i], dut.seg_o))

