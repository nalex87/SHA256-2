`include "timescale.v"

import dut_package::*;

interface dut_interface (input bit clk);
    logic rst_n;
    logic load;
    dut_package::Block_Header chunk_0;
    dut_package::Block_Header chunk_1;
    dut_package::Block_Header chunk_2;
    logic [511:0] message;
    logic [255:0] proofofwork;

    modport DUT (input clk, rst_n, load, message, chunk_0, chunk_1, chunk_2, output proofofwork);
    modport TEST (input clk, proofofwork, output chunk_0, chunk_1, chunk_2, load, rst_n, message);
endinterface


// SHA Transform
interface sha_interface (input bit clk);
    logic rst_n;
    logic [31:0] w [64];
    logic [255:0] hash;
    logic load, done;

    modport SHA (input w, rst_n, load, clk, output hash, done);
endinterface


interface ep1_interface (input bit clk);
    logic rst_n;
    logic [31:0] e [64];
    logic [31:0] out [64];

    modport EP1 (input clk, e, rst_n, output out);
endinterface:ep1_interface

interface ch_interface (input bit clk);
    logic rst_n;
    logic [31:0] e [64];
    logic [31:0] f [64];
    logic [31:0] g [64];
    logic [31:0] out [64];

    modport CH (input clk, e, f, g, rst_n, output out);
endinterface:ch_interface

