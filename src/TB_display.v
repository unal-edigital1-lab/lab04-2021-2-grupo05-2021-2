`timescale 1ps/1ps

module TB_display;
	
	reg [3:0] datoRA;  // 4 bits salida registro A (1 display)
	reg [3:0] datoRB;  // 4 bits salida registro B (1 display)
	reg [2:0] addRa; 	 // 4 bits dirección registro A (1 display)
	reg [2:0] addRb;   // 4 bits dirección registro B (1 display)
	reg [2:0] addrW;    // Dirección de escritura
	reg [3:0] datW;     // Dato a escribir
   reg clk;
	reg rst;

   wire [0:6] sseg;   // Salida 7 segmentos
   wire [5:0] an; 	 // Habilita 6 display
	wire led; 			 // LED indicador de frecuencia	

   display dsps( datoRA, datoRB, addRa, addRb, addrW,
                     datW, clk, rst, sseg, an, led );
    
    initial begin
      clk = 0;
		rst = 1;
		#10 rst = 0;
		
		addRa = 1; datoRA = 15;
		addRb = 2; datoRB = 3;
		addrW = 7; datW = 7;

    end
	 always #1 clk = ~clk;
endmodule
