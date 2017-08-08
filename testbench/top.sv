/* sha-transform top level dut and testbench integration */
`include "timescale.v"

module top;
	// Declarations
	bit clk_50, clk_200;

	// Clock
	clkgen clock_gen (clk_50,
					  clk_200,
					  clk_400);

    dut_interface dif(clk_50);
    SHA256 SHA256 (dif);
    test1 test1 (dif);

endmodule:top
