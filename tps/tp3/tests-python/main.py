#!/usr/bin/env python3
from sys import argv 
from floatPoint.floatPointStep01 import FloatingPoint
import math

import traceback
import sys

__doc__ = """
Uso: {__file__} [-h/--help]
"""

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
    result = a.sum(b)
    print("A = {0}, B = {1}, Result = {2}, Exp = {3}".format(a.convertToDec(), b.convertToDec(), result.convertToDec(),resExp.convertToDec()))
    print("A -> sign:        {0} - exp: {1} - mantisa: {2} (1{2:0>16b})".format(a.sign, a.exp, a.mantisa))
    print("B -> sign:        {0} - exp: {1} - mantisa: {2} (1{2:0>16b})".format(b.sign, b.exp, b.mantisa))
    print("Result   -> sign: {0} - exp: {1} - mantisa: {2} (1{2:0>16b})".format(result.sign, result.exp, result.mantisa))
    print("Expected -> sign: {0} - exp: {1} - mantisa: {2} (1{2:0>16b})\n".format(resExp.sign, resExp.exp, resExp.mantisa))

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
                traceback.print_exc(file=sys.stdout)
                print (e)
                print ('Error: Linea "{}" invalida'.format(line))
