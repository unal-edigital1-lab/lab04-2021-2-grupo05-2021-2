`timescale 1ns / 1ps

module BancoRegistro #(      		 	// Se definen los parametros 
         parameter BIT_ADDR = 3,  	// Parametro de bits para la dirección del registro  
         parameter BIT_DATO = 4  	//  Parametro de tamaño de bits del registro
	)
	(
    input [BIT_ADDR-1:0] addrRa, 	// Entrada dirección de registro A
    input [BIT_ADDR-1:0] addrRb, 	// Entrada dirección de registro B
    
	 output [BIT_DATO-1:0] datOutRa, // Salida dato de registro A
    output [BIT_DATO-1:0] datOutRb, // Salida dato de registro B
    
	 input [BIT_ADDR-1:0] addrW, 		// Entrada dirección de escritura
    input [BIT_DATO-1:0] datW,		//Entrada dato de 4 bits
    
	 input RegWrite, 						// Entrada pulsador RegWrite
    input clk, 							// Entrada reloj
    input rst  							// Entrada reset
    );


	localparam NREG = 2 ** BIT_ADDR; // Numero de registros (2**3=8)

	// Configuración del banco de registro

	// reg [size each reg] name [num of regs]
	// reg 3:0 breg 7:0
	// 8 regs de 4 bits cada uno
	reg [BIT_DATO-1: 0] breg [NREG-1:0];

	/** El dato de salida será igual a lo que 
	 ** tenga el banco de registros en esa dirección
	 */
	
	assign  datOutRa = breg[addrRa];
	assign  datOutRb = breg[addrRb];


	always @(posedge clk) begin // Para todo flanco de reloj ascendente 
	
		if (RegWrite == 1 && rst == 0) begin
			// Al registreo en 'addrW' asignele el valor 'datW'
			breg[addrW] <= datW;
		end
		
		if (rst == 1) begin
			// Se ponen todos los registros en un valor de 15
			breg[0] <= 15;
			breg[1] <= 15;
			breg[2] <= 15;
			breg[3] <= 15;
			breg[4] <= 15;
			breg[5] <= 15;
			breg[6] <= 15;
		end
	end
endmodule

