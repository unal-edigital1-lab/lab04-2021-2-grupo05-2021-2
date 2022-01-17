# LABORATORIO 04- Diseño de banco de registro.

* Nicolás Velásquez
* Steven Gallego
* J. David S. Lastra.

### Introducción
Para empezar, se puede definir a un registro como una memoria de almacenamiento temporal, o a su vez, como circuitos secuenciales constituidos por flip-flops. A su vez un banco de registros se compone por un numero n de registros, los cuales pueden ser seleccionados por una señal de control, que define la función a realizar, es decir lectura o escritura. El banco de registros puede tener varios puertos de salida y varios de entrada, permitiendo de esta forma la lectura o la escritura simultánea de varios registros.

## Banco de registro
Para la implementación necesaria para el banco de registro se deben tener en cuenta las siguientes condiciones a la hora de elaborar el diseño:
* Debe contar con 8 registros de 4 bits.
* Lectura de 2 registros simultáneos.
* Señal que controla la escritura de un registro (RegWrite).
* Contar con señal reset.
* Visualización de la información en displays
* Ingreso de información por medio de interruptores

Teniendo en cuenta lo anterior, los bloques a realizar resultan de la siguiente manera:

![Screenshot](Imagenes/bloques.jpg)

Con esto nos damos cuentas de las entradas y salidas de nuestro bloque de banco de registro. Las entradas están comprendidas por:
* datW [3:0] = Nos indica que el registro es de 4 bits
* addrW [2:0] = Es la dirección de escritura, es de 3 bits porque son 8 registros
* addrA [2:0] = Dirección para el dato de salida A
* addrB [2:0] = Dirección para el dato de salida B
* RegWrite = Señal de control para la escritura
* clk = Reloj
* rst= Reset

Y las salidas:
* datA [3:0] = Dato de salida A
* datB [3:0] = Dato de salida A