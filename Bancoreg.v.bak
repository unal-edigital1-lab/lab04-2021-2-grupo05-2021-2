`timescale 1ns / 1ps
module Bancoreg(
    input [2:0] addrRa, // Dirección registro A
	 input [2:0] addrRb, // Dirección registro B
	 input [2:0] addW, // Dirrección de escritura
	 input [3:0] datW, // Dato a escribir
    input RegWrite, //Señal para guardar el dato
	 input clk, // Reloj
	 input rst, // reset
	 
    output [6:0] sseg,
    output reg [3:0] an,
	 
    );

// Conexiones de salida banco de registro
wire [3:0] datOutRa; 
wire [3:0] datOutRb;
	
//Instanciación de BancoRegistro
BancoRegistro #(.BIT_ADDR(3), .BIT_DATO(4)) BR(.addrRa(addrRa), .addrRb(addrRb), 
.datOutRa(datOutRa), .datOutRb(datOutRb), .addrW(addrW), .datW(datW),
 .RegWrite(RegWrite), .clk(clk), .rst(rst));
 
//Instanciacion de display
display disp(.datA(datOutRa), .datB(datOutRb), .addrRa(addrRa), .addrRb(addrRb), 
.clk(clk), .sseg(sseg), .an(an), .led(led));

endmodule