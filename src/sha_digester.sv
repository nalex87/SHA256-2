/* Message PrePocessing/Digester Module */
`include "timescale.v"

module sha_digester (input bit clk,
                     input bit rst_n,
                     input bit load,
                     input logic [31:0] message [16],
                     output logic [31:0] w [64] );


logic [31:0] sig0_x [64];
logic [31:0] sig0_out [64];
logic [31:0] sig1_x [64];
logic [31:0] sig1_out [64];

// Message PreProcessing Stage
genvar i;
generate for (i=0; i<64; i++) begin : PreProcessing_Stage

// Hashers Instantiation and interface connections
sig0 sig0  (
    .clk        (clk),
    .rst_n      (rst_n),
    .x          (sig0_x[i]),
    .out        (sig0_out[i])
    );

sig1 sig1  (
    .clk        (clk),
    .rst_n      (rst_n),
    .x          (sig1_x[i]),
    .out        (sig1_out[i])
    );

    always_ff @(posedge clk) begin
        if (i<16) begin
            w[i] <= message[i];
        end
        else begin
            sig0_x[i] <= w[i-15];
            sig1_x[i] <= w[i-2];
            w[i] <= ( sig0_out[i] + w[i-7] + sig1_out[i] + w[i-16] ) ;
        end
    end
end : PreProcessing_Stage
endgenerate

endmodule