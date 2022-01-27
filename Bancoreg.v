`timescale 1ns / 1ps

/**Integración sistema completo: 
* conexión modulos 'BancoRegistro' y 'display'
*/

module Bancoreg (
    input [2:0] addrRa,   // Dirección registro A
	input [2:0] addrRb,   // Dirección registro B
	input [2:0] addrW,    // Dirección de escritura
	input [3:0] datW,     // Dato a escribir
    input RegWrite, 	  // Señal activación escritura de registros
	input clk, 			  // Señal de Reloj
	input rst, 		  // reset
	
    output [0:6] sseg,
    output [3:0] an
	 );
	
	wire [3:0] datOutRa;
    wire [3:0] datOutRb;
	
	// instancia modulo bancoRegistro
	BancoRegistro bancoRegistro(addrRa, addrRb, datOutRa, 
										 datOutRb, addrW, datW,
										 RegWrite, clk, rst);

	// instancia modulo display
	display disp(datOutRa, datOutRb, addrRa, 
					 addrRb, addrW, datW, clk, rst, sseg, an);

endmodule
