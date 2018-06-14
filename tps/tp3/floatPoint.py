#!/usr/bin/env python3
from sys import argv 
import math


__doc__ = """
Uso: {__file__} [-h/--help]
"""

class FloatingPoint:
    def __init__(self, num, numBits, expBits):
        mantisaBits = (numBits - expBits - 1)
        signMask = 1 << numBits - 1
        expMask = int(pow(2,expBits) - 1)
        mantisaMask = int(pow(2,mantisaBits) - 1)
        self.sign = num & signMask != 0
        self.exp = (num >> mantisaBits) & expMask
        self.mantisa = num & mantisaMask
        

def processLine(line, numBits, expBits):
    nums = line.split(' ')
    if len(nums) != 3:
        print("Numero incorrecto de parametros")
        raise
    nums = [int(i) for i in nums]
    print("Leido {0} -> {0:0>{3}b}, {1} -> {1:0>{3}b}, {2} -> {2:0>{3}b}".format(*nums, numBits))
    a = FloatingPoint(nums[0], numBits, expBits)
    b = FloatingPoint(nums[1], numBits, expBits)
    resExp = FloatingPoint(nums[2], numBits, expBits)
    print("A -> sign: {0} - exp: {1} - mantisa: {2}".format(a.sign, a.exp, a.mantisa))
    print("B -> sign: {0} - exp: {1} - mantisa: {2}".format(b.sign, b.exp, b.mantisa))
    print("Expected -> sign: {0} - exp: {1} - mantisa: {2}".format(resExp.sign, resExp.exp, resExp.mantisa))


if __name__ == '__main__':
    if '-h' in argv or '--help' in argv:
        print(__doc__)
        exit(0)
    elif len(argv) != 2:
        print(__doc__)
        exit(1)

    with open(argv[1]) as inputFile:
        for line in inputFile:
            try:
                processLine(line, 23, 6)
            except Exception as e:
                print (e)
                print ('Error: Linea "{}" invalida'.format(line))

