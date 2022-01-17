`timescale 1ns / 1ps

module Bancoreg(
    input [2:0] addrRa,  // Dirección registro A
	 input [2:0] addrRb,  // Dirección registro B
	 input [2:0] addW,    // Dirrección de escritura
	 input [3:0] datW,    // Dato a escribir
    input RegWrite, 		 // Señal para guardar el dato
	 input clk, 			 // Reloj
	 input rst, 			 // reset
	 
    output [6:0] sseg,
    output [3:0] an,
	 output led
	 
	 );
	
	//conexiones entre el top y el modulo display y banco de registro
	
	wire [3:0] datOutRa; //datos de los 2 registros que se leen simultaneamente
   wire [3:0] datOutRb;
	
	//instancia modulo bancoRegistro
	BancoRegistro bancoRegistro(addrRa, addrRb, datOutRa, 
										 datOutRb, addrW, datW,
										 RegWrite, clk, rst);
	
	//instancia modulo display
	display disp(datOutRa, datOutRb, addrRa, 
					 addrRb, clk, sseg, an, 
					 led, rst);
	
	
	endmodule

