#!/usr/bin/env python3
from sys import argv 
import math

import traceback
import sys

class FloatingPoint:
    """
    Iteración 1 de la clase punto flotante
    En esta iteración se pueden multiplicar números de punto flotante, pero
    solo se pueden sumar números positivos. 
    """
    def __init__(self, num = 0, numBits = 2, expBits = 1):
        self.mantisaBits = (numBits - expBits - 1)
        signMask = 1 << numBits - 1
        expMask = int(pow(2,expBits) - 1)
        mantisaMask = (1 << self.mantisaBits) - 1
        self.sign = num & signMask != 0
        self.exp = (num >> self.mantisaBits) & expMask
        self.mantisa = num & mantisaMask
        self.bias = (1 << (expBits - 1)) - 1
        
    def convertToDec(self):
        normExp = self.exp - self.bias - self.mantisaBits
        result = 0
        tmpMantisa = self.mantisa
        for _ in range (0, self.mantisaBits):
            if (tmpMantisa % 2 != 0):
                result += pow(2, normExp)
            tmpMantisa = tmpMantisa // 2
            normExp += 1
        result += pow(2, normExp)
        if (self.sign):
            result = -result
        return result

    def clone(self):
        c = FloatingPoint()
        c.bias = self.bias
        c.exp = self.exp
        c.mantisa = self.mantisa
        c.mantisaBits = self.mantisaBits
        c.sign = self.sign
        return c

    def sum(self, other):
        # Paso 1: self tiene que tener el exponente mayor o igual a other
        if self.exp < other.exp:
            return other.sum(self)
        result = other.clone()
        # Asigno exponente tentativo el sumando A
        result.exp = self.exp
        # Paso 2 complemento si son signos opuestos
        resultComplemented = self.sign != other.sign
        if resultComplemented:
            pass
        # Paso 3
        # Displacement es >= 0
        displacement = self.exp - other.exp
        print("Paso3 -> sign: {0} - exp: {1} - mantisa: {2:0>17b} Aplicando displacement".format(result.sign, result.exp, result.mantisa))
        # Agrego los que van al principio de la mantisa
        result.mantisa = result.mantisa >> displacement
        otherHiddenBit = 1 << (result.mantisaBits - displacement)
        result.mantisa += otherHiddenBit
        selfHiddenBit = 1 << (self.mantisaBits)
        # Paso 4
        result.mantisa += self.mantisa
        result.mantisa += selfHiddenBit
        # Paso 5
        carryOut = result.mantisa >= (1 << self.mantisaBits + 1)
        resultMsb = result.mantisa & (1 << (self.mantisaBits))
        if not resultComplemented and carryOut:
            result.mantisa = result.mantisa >> 1
            result.mantisa += 1 << self.mantisaBits
            result.exp += 1
        else:
            # Me quedo con los bits de la mantisa
            if result.mantisa == 0:
                return result
            print("Paso5 (normalize) -> msb? {0} & {1}".format(result.mantisa, (1 << self.mantisaBits)))
            print("Paso5 (normalize) -> sign: {0} - exp: {1} - mantisa: {2}(1{2:0>16b})".format(result.sign, result.exp, result.mantisa))
            # normalizo (no hay mucho que normalizar siendo suma de positivos)
            while not resultMsb :
                print("Adjusting")
                result.mantisa = result.mantisa << 1
                resultMsb = result.mantisa & (1 << self.mantisaBits)
                result.exp -= 1
        mantisaModulo = (1 << (self.mantisaBits))
        result.mantisa = result.mantisa % mantisaModulo
        return result
