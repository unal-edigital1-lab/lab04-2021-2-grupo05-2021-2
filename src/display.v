`timescale 1ns / 1ps
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
