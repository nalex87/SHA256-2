/* maj Module */
`include "timescale.v"

module maj (input bit clk,
			input bit rst_n,
			input logic [31:0] a,
			input logic [31:0] b,
			input logic [31:0] c,
			output logic [31:0] out
			);

always_ff @(posedge clk) begin
    if(~rst_n)
        out <= 32'h0;
    else
        out <= (a & b) ^  ((a & c) ^ (b & c));
end 

endmodule
