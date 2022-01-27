`timescale 1ns / 1ps

module BancoRegistro #(      		 // Se definen los parametros 
         parameter BIT_ADDR = 3,  // Parametro de bits para la dirección del registro  
         parameter BIT_DATO = 4  //  Parametro de tamaño de bits del registro
	)
	(
    input [BIT_ADDR-1:0] addrRa, // Entrada dirección de registro A
    input [BIT_ADDR-1:0] addrRb, // Entrada dirección de registro B
    
	 output [BIT_DATO-1:0] datOutRa, // Salida dato de registro A
    output [BIT_DATO-1:0] datOutRb, // Salida dato de registro B
    
	 input [BIT_ADDR-1:0] addrW, // Entrada dirección de escritura
    input [BIT_DATO-1:0] datW, //Entrada dato de 4 bits
    
	 input RegWrite, // Entrada pulsador RegWrite
    input clk, // Entrada reloj
    input rst // Entrada reset
    );


	localparam NREG = 2 ** BIT_ADDR; // Numero de registros (2**3=8)

	// configiración del banco de registro

	// reg [size each reg] name [num of regs]
	// reg 3:0 breg 7:0
	// 8 regs de 4 bits cada uno
	reg [BIT_DATO-1: 0] breg [NREG-1:0];


	assign  datOutRa = breg[addrRa]; // El dato de salida será igual a lo que tenga el banco de registros en esa dirección
	assign  datOutRb = breg[addrRb];

	// Esto es para la escritura:
	always @(posedge clk) begin // Para todo flanco de reloj ascendente 
		if (RegWrite == 1) // Siempre que la señal RegWrite sea 1
			begin
				breg[addrW] <= datW; // El banco de registros en esa dirección dada será datW
			end
		if (rst == 1) begin
			breg[0] <= 1;
			breg[1] <= 1;
			breg[2] <= 1;
			breg[3] <= 1;
			breg[4] <= 1;
			breg[5] <= 1;
			breg[6] <= 1;
		end
	end
endmodule

