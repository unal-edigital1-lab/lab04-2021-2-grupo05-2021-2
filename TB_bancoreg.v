`timescale 1ns / 1ps

module TB_bancoreg;

    // Inputs
	reg [2:0] addrRa;
	reg [2:0] addrRb;
	reg [2:0] addrW;
	reg [3:0] datW;
	reg RegWrite;
	reg clk;
	reg rst;

    // Outputs
	wire [3:0] datOutRa;
	wire [3:0] datOutRb;
   	wire [0:6] sseg;
   	wire [5:0] an;
	wire led;

   	Bancoreg bacoReg ( addrRa, addrRb, addrW, datW, RegWrite, 
	   					clk, rst, sseg, an);

    initial begin
        // Initialize Inputs
		addrRa = 0;
		addrRb = 3;
		addrW = 0;
		datW = 4;
		RegWrite = 1;
		clk = 0;
		rst = 1;
		#10 rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		// writting 8 registers
		for (addrW = 0; addrW < 8; addrW = addrW + 1) begin
			datW = 15 - addrW;
			#521;
		end
		
		RegWrite = 0; // Disable register writting
		
		// 4 register lecture - 2 simultaneous
		for (addrRa = 0; addrRa < 4; addrRa = addrRa + 1) begin
			addrRb = 7 - addrRa;
			#521; // wait 5 ns to easily see changes
		end
		
		RegWrite = 1;
		rst = 1; // Reset all registers to default value
		#521 //wait for register default value asignment
		
		rst = 0;
		RegWrite = 0;
		
		// Read all registers again, to see the change to default value
		for (addrRa = 0; addrRa < 4; addrRa = addrRa + 1) begin
			addrRb = 7 - addrRa;
			#521; // wait 5 ns to easily see changes
		end
	end
	
	always #1 clk = ~clk;

endmodule
