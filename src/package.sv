`timescale 1ns/1ns

package dut_package;

    parameter VERSION = "1.0";

    typedef struct {
        logic [31:0] version;
        logic [255:0] PrevBlock;
        logic [255:0] MerkleRoot;
        logic [31:0] Time;
        logic [31:0] Bits;
        logic [31:0] Nonce;
    } Block_Header;

endpackage