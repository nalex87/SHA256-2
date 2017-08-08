`include "timescale.v"


import dut_package::*;

interface dut_interface (input bit clk);
    logic rst_n;
    logic load;
    byte  message_length;
    logic [31:0] data_length [2];
    byte message [64];
    logic [255:0] hash;

    modport DUT (input clk, rst_n, load, message, output hash);
endinterface

