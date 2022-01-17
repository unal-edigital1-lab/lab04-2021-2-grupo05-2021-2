# LABORATORIO 04- Diseño de banco de registro.

* Nicolás Velásquez Ospina
* Jhair Steven Gallego Mendez
* Juan David Sarmiento Lastra

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

En el repositorio proporcionado por el profesor nos encontramos con el archivo de Quartus BancoRegistro.v :

![Screenshot](Imagenes/BancoRegistro.png)

En este módulo proporcionado nos encontramos con la descripción en verilog del banco de registro. Como primer paso se definen los parámetros `BIT_ADDR` y `BIT_DATO`, donde el primero refiere al tamaño de bits necesario para la dirección del registro, que en este caso son 3 bits, ya que son 8 registros. El segundo se re refiera al tamaño en bits de cada registro, que ya se habían mencionado que eran 4 bits. Posteriormente gracias a esto se definen las entradas y las salidas del bloque de banco de registro que ya se habían trabajado.

El siguiente paso será adecuado a la configuración del banco de registros como tal, donde se define el tamaño del mismo, es decir, el número de registros que tendrá el banco, comprendido por NREG = 2 ** BIT_ADDR.
Así mismo se asignan los datos de salida que tendrá el banco de registro según la dirección proporcionada con anterioridad.

Para la escritura se sabe que siempre que la señal RegWrite sea 1, el registro de la dirección addrW será datW.

Orientandonos con el diagrama de bloques, se observa que la salida de esté banco de registros vendrá conectada a la visualizacion dinamica realizada en el pasado laboratorio, es por esto que se tendrá que instanciar el archivo display.v, al igual que en el interior de este vendrá instanciado BCDtoSseg.v:


``timescale 1ns / 1ps
module display(
    //input [15:0] num, // el programa era de 16 entradas (4 paquetes de BCD 4 bits)
	 input [3:0] datoRA, // 4 bits salida registro A (1 display)
	 input [3:0] datoRB, // 4 bits salida registro B (1 display)
	 input [3:0] addRa, // 4 bits dirección registro A (1 display)
	 input [3:0] addRb, // 4 bits dirección registro B (1 display)
    input clk, //Reloj
    output [0:6] sseg, // Salida 7 segmentos
    output reg [3:0] an, // 4 anodos
	 output led,
	 input rst// reset
    );



reg [3:0]bcd=0;
 
BCDtoSSeg bcdtosseg(.BCD(bcd), .SSeg(sseg));

reg [26:0] cfreq=0;
wire enable;

// Divisor de frecuecia

assign enable = cfreq[16];
assign led =enable;
always @(posedge clk) begin
  if(rst==1) begin
		cfreq <= 0;
	end else begin
		cfreq <=cfreq+1;
	end
end

reg [1:0] count =0;
always @(posedge enable) begin
		if(rst==1) begin
			count<= 0;
			an<=4'b1111; 
		end else begin 
			count<= count+1;
			an<=4'b1101; 
			case (count) 
				2'h0: begin bcd <= datoRA;   an<=4'b1110; end 
				2'h1: begin bcd <= datoRB;   an<=4'b1101; end 
				2'h2: begin bcd <= addRa;    an<=4'b1011; end 
				2'h3: begin bcd <= addRb;    an<=4'b0111; end 
			endcase
		end
end

endmodule
`