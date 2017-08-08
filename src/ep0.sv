/* ep0 Module */

`include "timescale.v"

module ep0 (input bit clk,
			input bit rst_n,
			input logic [31:0] a,
			output logic [31:0] out
			);

logic [31:0] rotateright_2;
logic [31:0] rotateright_13;
logic [31:0] rotateright_22;

always_comb begin
    rotateright_2  <=  { a[1:0], a[31:2] };
    rotateright_13 <=  { a[12:0], a[31:13] };
    rotateright_22 <=  { a[21:0], a[31:22] };
end 

always_ff @(posedge clk) begin
    if(~rst_n)
        out <= 32'h0;
    else
        out <= rotateright_2 ^ rotateright_13 ^ rotateright_22;
end

endmodule