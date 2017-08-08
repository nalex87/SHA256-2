//----------------------------------------------------------------------
// This File: clkgen.sv
//----------------------------------------------------------------------

`include "CYCLE.sv"
module clkgen (
  output logic clk_50,
  output logic clk_200,
  output logic clk_400);

  initial begin
    clk_50 	<= 0;

    forever begin
    	#(`CYCLE_50/2) 	clk_50		<= ~clk_50;
     end
  end

  initial begin
    clk_200 <= 0;

    forever begin
      #(`CYCLE_200/2) clk_200   <= ~clk_200;
     end
  end

  initial begin
    clk_400 <= 0;

    forever begin
      #(`CYCLE_400/2) clk_400   <= ~clk_400;
     end
  end

endmodule 
