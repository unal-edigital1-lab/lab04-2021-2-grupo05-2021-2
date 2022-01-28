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
	reg rstD;
	//reg rstD;

    // Outputs
	wire [3:0] datOutRa;
	wire [3:0] datOutRb;
   wire [0:6] sseg;
   wire [5:0] an;
	wire led;

   	Bancoreg bacoReg (addrRa, addrRb, addrW,    
                        datW, RegWrite, clk, 	
                        rst, rstD, sseg, an);

    initial begin
        // Initialize Inputs
		addrRa = 1;
		addrRb = 2;
		addrW = 3;
		datW = 6;
		RegWrite = 1;
		clk = 0;
		rst = 0;
		rstD = 1;
		#30
		rstD = 0;
		#30
		rst = 1;
		#30
		rstD = 1;

		// Wait 100 ns for global reset to finish
		//#100;
		
		/*// writting 8 registers
		for (addrW = 0; addrW < 8; addrW = addrW + 1) begin
			datW = 15 - addrW;
			#5;
		end
		
		RegWrite = 0; // Disable register writting
		
		// 4 register lecture - 2 simultaneous
		for (addrRa = 0; addrRa < 4; addrRa = addrRa + 1) begin
				addrRb = 7 - addrRa;
				// $display("regA[%d] = %d y regB[%d] = %d", 
				// 		addrRa, datOutRa, addrRb, datOutRb);
						
				#5; // wait 5 ns to easily see changes
		end*/
	end
	
	always #1 clk = ~clk;

endmodule
