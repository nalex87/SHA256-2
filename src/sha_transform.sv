/* sha-transform Module */
`include "timescale.v"

module sha_transform (
    input bit clk,
    input bit rst_n,
    input bit load,
    input logic [31:0] message_processed [16],
    output logic [255:0] hash );

// Result of the sha_digester - temp storage
logic [31:0] m_temp [64];

// Hasher input values
logic [31:0] a [65];
logic [31:0] b [65];
logic [31:0] c [65];
logic [31:0] d [65];
logic [31:0] e [65];
logic [31:0] f [65];
logic [31:0] g [65];
logic [31:0] h [65];
logic [31:0] t1 [65];
logic [31:0] t2 [65];

// Hasher output values
logic [31:0] maj_out [65];
logic [31:0] ch_out [65];
logic [31:0] ep0_out [65];
logic [31:0] ep1_out [65];

//Debug Variables
logic [31:0] temp_t1_0, temp_t2_0,ks_temp;

// Constants defined by the SHA256 standard.
parameter [31:0] H[8] = {
32'h6a09e667, 32'hbb67ae85, 32'h3c6ef372, 32'ha54ff53a,
32'h510e527f, 32'h9b05688c, 32'h1f83d9ab, 32'h5be0cd19};

parameter [31:0] Ks[64] = {
32'h428a2f98, 32'h71374491, 32'hb5c0fbcf, 32'he9b5dba5,
32'h3956c25b, 32'h59f111f1, 32'h923f82a4, 32'hab1c5ed5,
32'hd807aa98, 32'h12835b01, 32'h243185be, 32'h550c7dc3,
32'h72be5d74, 32'h80deb1fe, 32'h9bdc06a7, 32'hc19bf174,
32'he49b69c1, 32'hefbe4786, 32'h0fc19dc6, 32'h240ca1cc,
32'h2de92c6f, 32'h4a7484aa, 32'h5cb0a9dc, 32'h76f988da,
32'h983e5152, 32'ha831c66d, 32'hb00327c8, 32'hbf597fc7,
32'hc6e00bf3, 32'hd5a79147, 32'h06ca6351, 32'h14292967,
32'h27b70a85, 32'h2e1b2138, 32'h4d2c6dfc, 32'h53380d13,
32'h650a7354, 32'h766a0abb, 32'h81c2c92e, 32'h92722c85,
32'ha2bfe8a1, 32'ha81a664b, 32'hc24b8b70, 32'hc76c51a3,
32'hd192e819, 32'hd6990624, 32'hf40e3585, 32'h106aa070,
32'h19a4c116, 32'h1e376c08, 32'h2748774c, 32'h34b0bcb5,
32'h391c0cb3, 32'h4ed8aa4a, 32'h5b9cca4f, 32'h682e6ff3,
32'h748f82ee, 32'h78a5636f, 32'h84c87814, 32'h8cc70208,
32'h90befffa, 32'ha4506ceb, 32'hbef9a3f7, 32'hc67178f2};


// Hashers Instantiation and interface connections
// Performs Rotates and Shifts called Sig0 and Sig1
sha_digester sha_digester (
    .clk        (clk),
    .rst_n      (rst_n),
    .load       (load),
    .message    (message_processed),
    .w          (m_temp)
    );

// Macros
// Skip [0] since it contains initial constants
genvar j;
generate for (j=0; j<64; j++) begin
    maj maj  (
        .clk        (clk),
        .rst_n      (rst_n),
        .a          (a[j]),
        .b          (b[j]),
        .c          (c[j]),
        .out        (maj_out[j])
    );

    ep0 ep0  (
        .clk        (clk),
        .rst_n      (rst_n),
        .a          (a[j]),
        .out        (ep0_out[j])
    );

    ep1 ep1  (
        .clk        (clk),
        .rst_n      (rst_n),
        .e          (e[j]),
        .out        (ep1_out[j])
    );

    ch ch  (
        .clk        (clk),
        .rst_n      (rst_n),
        .e          (e[j]),
        .f          (f[j]),
        .g          (g[j]),
        .out        (ch_out[j])
    );
end
endgenerate

// Second Stage Hash Calculations
// Skip [0] since it contains initial constants
genvar i;
generate for (i=1; i<65; i++) begin
    always_ff @(posedge clk) begin
        if (load) begin
            a[0] = H[0];
            b[0] = H[1];
            c[0] = H[2];
            d[0] = H[3];
            e[0] = H[4];
            f[0] = H[5];
            g[0] = H[6];
            h[0] = H[7];
        end
        else begin
            // a = t1 + t2
            a[i] <= ( h[i-1] + ep1_out[i-1] + ch_out[i-1] + Ks[i-1] + m_temp[i-1] )  +  (ep0_out[i-1] + maj_out[i-1]);
            // b = a
            b[i] <= a[i-1];
            // c = b
            c[i] <= b[i-1];
            // d = c
            d[i] <= c[i-1];
            // e = d + (h + ep1 + ch + K[i] + m_temp[i])
            e[i] <= d[i-1] + h[i-1] + ep1_out[i-1] + ch_out[i-1] + Ks[i-1] + m_temp[i-1];
            // f = e
            f[i] <= e[i-1];
            // g = f
            g[i] <= f[i-1];
            // h = g
            h[i] <= g[i-1];

            t1[i] <= h[i-1] + ep1_out[i-1] + ch_out[i-1] + Ks[i-1] + m_temp[i-1];

            t2[i] <= ep0_out[i-1] + maj_out[i-1];

            //RWC -- added these debug variable
            //t1[0]
            temp_t1_0 <= h[0] + Ks[0] + m_temp[0] + ch_out[0] + ep1_out[0] ;
            ks_temp <= h[0] + Ks[0] + m_temp[0] + ch_out[0];
            temp_t2_0 <= ep0_out[0] + maj_out[0];
        end
    end
end
endgenerate

// SHA 256 Result
always_ff @(posedge clk) begin : sha_result
    hash = {a[64],b[64],c[64],d[64],e[64],f[64],g[64],h[64]} + {H[0],H[1],H[2],H[3],H[4],H[5],H[6],H[7]};
end : sha_result

endmodule