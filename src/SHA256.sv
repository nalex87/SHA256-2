`include "timescale.v"

module SHA256 (dut_interface dif);

logic select;
logic [31:0] message_processed [16];
logic [31:0] data0, data1, temp;


sha_transform sha_transform (
    .clk                (dif.clk),
    .rst_n              (dif.rst_n),
    .load               (dif.load),
    .message_processed  (message_processed)
    );

// Calculate number of bytes
assign temp = dif.data_length[0] + dif.message_length;
always_ff @(posedge dif.clk) begin : proc_num_bytes
    if(~dif.rst_n) begin
        data0 <= 0;
        data1 <= 0;
    end else begin
        if(dif.load)
            data0 <= temp * 8;
    end
end



// RWC edits needed to make this logic adjust to the input length
// Concatenate message bits to 32bit words
genvar i;
generate for (i=0; i<15; i++) begin
    assign message_processed[i] = {dif.message[i*4], dif.message[i*4+1], dif.message[i*4+2], dif.message[i*4+2]};
end
endgenerate

// Compute last 8 bytes of the message
assign message_processed[15][7:0]    = data0[7:0];
assign message_processed[15][15:8]   = data0[15:8];
assign message_processed[15][23:16]  = data0[23:16];
assign message_processed[15][31:24]  = data0[31:24];
assign message_processed[16][7:0]    = data1[7:0];
assign message_processed[16][15:8]   = data1[15:8];
assign message_processed[16][23:16]  = data1[23:16];
assign message_processed[16][31:24]  = data1[31:24];



endmodule