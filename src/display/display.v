`timescale 1ns / 1ps

module display (
	input [3:0] datoRA,   // 4 bits salida registro A (1 display)
	input [3:0] datoRB,   // 4 bits salida registro B (1 display)
	input [2:0] addRa, 	 // 4 bits dirección registro A (1 display)
	input [2:0] addRb,    // 4 bits dirección registro B (1 display)
	input [2:0] addrW,    // Dirección de escritura
	input [3:0] datW,     // Dato a escribir
   input clk,
	input rst,
   output [0:6] sseg,    // Salida 7 segmentos
   output reg [5:0] an,  // Habilita 6 display
	output led 			 	 // LED indicador de frecuencia	
    );

	reg [3:0] bcd = 0;

	BCDtoSSeg bcdtosseg(.BCD(bcd), .SSeg(sseg));


	reg [2:0] count = 0;
	always @(posedge clk) begin
			if(rst == 0) begin // cambiar a 1 para simulación en ModelSim
				count <= 0;
				an <= 6'b111111; 
			end else begin 
				if (count == 6) begin
					count <= 0;
				end else begin
					count <= count + 1;
					case (count) 
						3'b000: begin bcd <= datoRA;   an <= 6'b111110; end 
						3'b001: begin bcd <= addRa;    an <= 6'b111101; end 
						3'b010: begin bcd <= datoRB;   an <= 6'b111011; end 
						3'b011: begin bcd <= addRb;    an <= 6'b110111; end 
						3'b100: begin bcd <= datW;     an <= 6'b101111; end 
						3'b101: begin bcd <= addrW;    an <= 6'b011111; end 
					endcase
				end
			end
	end

endmodule