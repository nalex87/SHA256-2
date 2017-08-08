/* ep1 Module */

`include "timescale.v"

module ep1 (input bit clk,
			input bit rst_n,
			input logic [31:0] e,
			output logic [31:0] out
			);

logic [31:0] rotateright_6;
logic [31:0] rotateright_11;
logic [31:0] rotateright_25;

always_comb begin
    rotateright_6  <=  { e[5:0], e[31:6] };
    rotateright_11 <=  { e[10:0], e[31:11] };
    rotateright_25 <=  { e[24:0], e[31:25] };
end 

always_ff @(posedge clk) begin
    if(~rst_n)
        out <= 32'h0;
    else
        out <= rotateright_6 ^ rotateright_11 ^ rotateright_25;
end

endmodule