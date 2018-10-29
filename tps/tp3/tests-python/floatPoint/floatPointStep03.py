#!/usr/bin/env python3

class FloatingPoint:
    """
    Iteración 2 de la clase punto flotante
    En esta iteración se pueden sumar números de distinto signo
    Se ignoran los bits de gsr
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
    
    def __eq__(self, other):
        """Override the default Equals behavior"""
        return self.sign == other.sign and self.exp == other.exp and self.mantisa == other.mantisa

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

    def mult(self, other):
        result = other.clone()
        result.sign = self.sign ^ other.sign
        result.exp += self.exp - self.bias

        msb = 1 << self.mantisaBits
        result.mantisa += msb
        self.mantisa += msb
        result.mantisa *= self.mantisa
        result.mantisa >>= self.mantisaBits

        carryBit = 1 << (self.mantisaBits+1)
        if result.mantisa & carryBit:
            result.exp += 1
            result.mantisa %= carryBit
            result.mantisa >>= 1
        else:
            result.mantisa %= msb
        return result

    def sum(self, other):
        # Paso 1: self tiene que tener el exponente mayor o igual a other
        if self.exp < other.exp:
            return other.sum(self)
        result = other.clone()
        # Asigno como exponente y signo tentativos el del sumando A
        result.exp = self.exp
        result.sign = self.sign
        # Avance de paso 4, 
        otherHiddenBit = 1 << result.mantisaBits
        result.mantisa += otherHiddenBit
        # Paso 2 complemento si son signos opuestos
        otherComplemented = self.sign != other.sign
        if otherComplemented:
            result.mantisa = -result.mantisa
        # Paso 3
        # Displacement es >= 0
        displacement = self.exp - other.exp
        # Agrego los que van al principio de la mantisa
        result.mantisa = result.mantisa >> displacement
        # Paso 4, la suma
        auxMantisa = (result.mantisa % (1 << self.mantisaBits + 1))
        selfHiddenBit = 1 << (self.mantisaBits)
        result.mantisa += selfHiddenBit
        result.mantisa += self.mantisa
        # Paso 5
        auxCarry = auxMantisa + selfHiddenBit + self.mantisa
        carryOut = auxCarry & (1 << (self.mantisaBits + 1))
        resultMsb = auxCarry & (1 << self.mantisaBits)
        # Paso 4, cambio de signo
        resultComplemented = False
        if otherComplemented and resultMsb and not carryOut:
            resultComplemented = True
            result.mantisa = -result.mantisa
            resultMsb = result.mantisa & (1 << (self.mantisaBits))
        # Vuelvo al paso 5
        result.mantisa %= (1 << self.mantisaBits)
        if not otherComplemented and carryOut:
            result.mantisa = result.mantisa >> 1
            result.mantisa += 1 << self.mantisaBits
            result.exp += 1
        else:
            # Me quedo con los bits de la mantisa
            if result.mantisa == 0:
                return result
            # normalizo
            while not resultMsb :
                result.mantisa = result.mantisa << 1
                resultMsb = result.mantisa & (1 << self.mantisaBits)
                result.exp -= 1
        result.mantisa %= (1 << self.mantisaBits)
        # Paso 8
        if resultComplemented:
            result.sign = not result.sign
        return result
