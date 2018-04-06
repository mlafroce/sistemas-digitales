# Instalación

Clonar y compilar

git clone https://github.com/potentialventures/cocotb

Se instala por defecto en /usr/local, esto puede tener el problema de que al compilar un test, no pueda tener permisos de escritura en esa carpeta.


# Correr un test

## Elegir un simulador

En el makefile agregar la variable SIM=*simulador*, por defecto usará Icarus.

# Otras cosas que aprendí por las malas

* cocotb es case sensitive, pero ghdl hace lowercase todo, por lo tanto, evitar camelCase

* Los clocks son buenos, ¡usalos!