/* sha-transform testbench */

`include "timescale.v"

module richminer_testbench(dut.TEST dif);

    initial
        begin
            // Sample Bitcoin chunks
            miner_if.chunk_0.version    = 32'h00000000;
            miner_if.chunk_0.PrevBlock  = 256'h81cd02ab7e569e8bcd9317e2fe99f2de44d49ab2b8851ba4a308000000000000;
            miner_if.chunk_0.MerkleRoot = 256'he320b6c2fffc8d750423db8b1eb942ae710e951ed797f7affc8892b0f1fc122b;
            miner_if.chunk_0.Time       = 32'hc7f5d74d;
            miner_if.chunk_0.Bits       = 32'hf2b9441a;
            miner_if.chunk_0.Nonce      = 32'h42a14695;

            miner_if.chunk_1.version    = 32'h00000000;
            miner_if.chunk_1.PrevBlock  = 256'hffffffffffffffffffffffffffffffffffffffffb8851ba4a308000000000000;
            miner_if.chunk_1.MerkleRoot = 256'hffffffffffffffffffffffffffffffffffffffffb8851ba4a308000000000000;
            miner_if.chunk_1.Time       = 32'h00000000;
            miner_if.chunk_1.Bits       = 32'h00000000;
            miner_if.chunk_1.Nonce      = 32'h00000000;

            miner_if.chunk_2.version    = 32'h00000000;
            miner_if.chunk_2.PrevBlock  = 256'h0000000000000000000000000000000000000000000000000308000000000000;
            miner_if.chunk_2.MerkleRoot = 256'h0000000000000000000000000000000000000000000000000308000000000000;
            miner_if.chunk_2.Time       = 32'h00000000;
            miner_if.chunk_2.Bits       = 32'h00000000;
            miner_if.chunk_2.Nonce      = 32'h00000000;


            miner_if.rst_n      = 0;
            miner_if.load       = 1'b0;
    #12     miner_if.rst_n      = 1;
    #20     miner_if.load       = 1'b1;
            miner_if.message    = 512'h0;
    end



/*
        foreach (sha_if.w[i])
            sha_if.w[i] = 32'h0;
//        #1000   sha_if.load     = 1'b0;
        end



        for (i:0;i<16:i++)
            $display("leading bit is %d:", (i*32+31));


     always @(posedge sha_if.clk)
            begin
                sha_if.w        = 512'h0;
                sha_if.w     = 32'h6a09e667;
                $display("@%0t: Drove a", $time);
            end
            */
endmodule