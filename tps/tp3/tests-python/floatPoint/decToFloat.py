#!/usr/bin/env python3
from sys import argv 
import math

import traceback
import sys

__doc__ = """
Uso: {__file__} [-h/--help]
"""

class Converter:
    def __init__(self, numBits = 32, expBits = 8):
        self.bias = (1 << (expBits - 1)) - 1
        self.mantisaBits = (numBits - expBits - 1)
        self.numBits = numBits
        
    def decToFloat(self, num):
        if num == 0:
            return 0
        sign = 0
        if num < 0:
            sign = 1 << (self.numBits - 1)
        exp = self.bias
        if num > 1:
            while num >= 2:
                num /= 2
                exp += 1
        else:
            while num < 1:
                num *= 2
                exp -= 1
        num -= 1
        mantisa = 0
        for _ in range(0, self.mantisaBits):
            num *= 2
            if num >= 1:
                num -= 1
                mantisa += 1
            mantisa = mantisa << 1
        mantisa = mantisa >> 1
        result = mantisa + (exp << self.mantisaBits) + sign
        return result