/* ch Module */
`include "timescale.v"

module ch (	input bit clk,
			input bit rst_n,
			input logic [31:0] e,
			input logic [31:0] f,
			input logic [31:0] g,
			output logic [31:0] out
			);

always_ff @(posedge clk) begin
    if(~rst_n)
        out <= 32'h0;
    else
        out <= (e & f) ^ (~e & g);
end 

endmodule
