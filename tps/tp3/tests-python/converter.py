#!/usr/bin/env python3
from sys import argv 
from floatPoint.decToFloat import Converter
import math

import traceback
import sys

__doc__ = """
Uso: {__file__} [-h/--help]
"""

def processLine(line, converter):
    nums = line.split(' ')
    if len(nums) != 3:
        print("Numero incorrecto de parametros")
        raise
    floats = [converter.decToFloat(float(num)) for num in nums]
    print("{} {} {}".format(*floats))
        

if __name__ == '__main__':
    if '-h' in argv or '--help' in argv:
        print(__doc__)
        exit(0)
    elif len(argv) != 2:
        print(__doc__)
        exit(1)

    converter = Converter(23, 6)

    with open(argv[1]) as inputFile:
        for line in inputFile:
            try:
                output = processLine(line, converter)
            except Exception as e:
                traceback.print_exc(file=sys.stdout)
                print (e)
                print ('Error: Linea "{}" invalida'.format(line))
