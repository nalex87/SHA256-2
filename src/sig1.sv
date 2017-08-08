/* sig1 Module */
`include "timescale.v"

module sig1 (input bit clk,
             input bit rst_n,
             input logic [31:0] x,
             output logic [31:0] out
    );

logic [31:0] rotateright_17;
logic [31:0] rotateright_19;
logic [31:0] shiftright_10;

always_comb begin
    rotateright_17 <=  { x[16:0], x[31:17] };
    rotateright_19 <=  { x[18:0], x[31:19] };
    shiftright_10  <=  { 10'h0, x[31:10] };
end 

always_ff @(posedge clk) begin
    if(~rst_n)
        out <= 32'h0;
    else
        out <= rotateright_17 ^ rotateright_19 ^ shiftright_10;
end

endmodule
