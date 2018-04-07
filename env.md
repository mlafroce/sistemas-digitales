# Configuración del ambiente

## GHDL

GHDL es un simulador open source de código VHDL, para más información visitar el [sitio oficial](ghdl.free.fr).
Para instalarlo, se debe clonar su repositorio de github, compilarlo e instalarlo.

~~~{.bash}
git clone https://github.com/ghdl/ghdl.git
cd ghdl
./configure
make
make install
~~~

### Flags útiles

* Agregar el flag `--prefix=<directorio>` al comando `./configure` permite cambiar el directorio de instalación.

* Agregar el flag `-j<n>` al comando `make` permite compilar hasta *n* trabajos en paralelo.

    Si se instala en un directorio que no es del sistema, recordar incluirlo en el `$PATH`

## VHDL

Clonar y compilar

git clone https://github.com/potentialventures/cocotb

Se instala por defecto en /usr/local, esto puede tener el problema de que al compilar un test, no pueda tener permisos de escritura en esa carpeta.

