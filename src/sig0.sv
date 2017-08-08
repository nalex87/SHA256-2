/* sig0 Module */
`include "timescale.v"

module sig0 (input bit clk,
             input bit rst_n,
             input logic [31:0] x,
             output logic [31:0] out
    );


logic [31:0] rotateright_7;
logic [31:0] rotateright_18;
logic [31:0] shiftright_3;

always_comb begin
    rotateright_7  <=  { x[6:0], x[31:7] };
    rotateright_18 <=  { x[17:0], x[31:18] };
    shiftright_3   <=  { 3'h0, x[31:3] };
end 

always_ff @(posedge clk) begin
    if(~rst_n)
        out <= 32'h0;
    else
        out <= rotateright_7 ^ rotateright_18 ^ shiftright_3;
end

endmodule
