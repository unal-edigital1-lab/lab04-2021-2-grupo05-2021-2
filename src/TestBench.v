`timescale 1ns / 1ps


module TestBench;

	// Inputs
	reg [3:0] addrRa;
	reg [3:0] addrRb;
	reg [4:0] addrW;
	reg [3:0] datW;
	reg RegWrite;
	reg clk;
	reg rst;

	// Outputs
	wire [3:0] datOutRa;
	wire [3:0] datOutRb;

	// Instantiate the Unit Under Test (UUT)
	BancoRegistro uut (
		.addrRa(addrRa), 
		.addrRb(addrRb), 
		.datOutRa(datOutRa), 
		.datOutRb(datOutRb), 
		.addrW(addrW), 
		.datW(datW), 
		.RegWrite(RegWrite), 
		.clk(clk), 
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		addrRa = 0;
		addrRb = 0;
		addrW = 0;
		datW = 4;
		RegWrite = 1;
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		// writting 8 registers
		for (addrW = 0; addrW < 8; addrW = addrW + 1) begin
			datW = 15 - addrW; // 15 14 13 12 11 10 9 8
			#5; // wait 5 ns
		end
		
		//RegWrite = 0;
		// 4 register lecture - 2 simultaneous
		// 0 1 6 7
		for (addrRa = 0; addrRa < 4; addrRa = addrRa + 1) begin
				addrRb = 7 - addrRa;
				$display("regA[%d] = %d y regB[%d] = %d", 
						addrRa, datOutRa, addrRb, datOutRb);
				#5; // wait 5 ns to see changes
		end
		
		#280
		for (addrRa = 0; addrRa < 4; addrRa = addrRa + 1) begin
				addrRb = 7 - addrRa;
				$display("regA[%d] = %d y regB[%d] = %d", 
						addrRa, datOutRa, addrRb, datOutRb);
				#5; // wait 5 ns to see changes
		end
      /**
		for (addrRa = 0; addrRa < 8; addrRa = addrRa + 1) begin
			#5 addrRb = addrRa + 8;
			 $display("el valor del registro %d =  %d y %d = %d",
							addrRa, datOutRa, addrRb, datOutRb) ;
			#1 datW = datW + 1;
		end
		**/
	end	
	
	always #1 clk = ~clk;
	always #140 RegWrite = ~RegWrite;
	always begin
		#280 rst = ~rst;
		RegWrite = ~RegWrite;
		//$display("rst: %d, regA[%d] = %d y regB[%d] = %d", 
		//			rst, addrRa, datOutRa, addrRb, datOutRb);
		
	end
		
	
      
endmodule

