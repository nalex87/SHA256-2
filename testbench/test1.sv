//----------------------------------------------------------------------
// This File: test1.sv
//----------------------------------------------------------------------
`include "timescale.v"

program test1(dut_interface dif);
  //Test Data
  logic [11:0] counter;

  initial begin
    $display("***************");
    $display("Starting SHA256");
    $display("***************");

    test1.dut_reset();
    test1.dut_data_init();
    //$display("Message:%p @ %0t", dif.message, $time);
  end

  initial begin
    $timeformat(-9, 5, " ns", 10);
    #10000 $stop;
  end

 // Tasks
  task dut_reset();
    begin
      repeat (1) @(posedge dif.clk); 
        begin
          dif.load        = 1'b0;
          counter         = 0;
        end
      repeat (2) @(posedge dif.clk); 
        begin
          dif.rst_n       = 1'b0;
        end
      repeat (2) @(posedge dif.clk); 
        begin
          dif.rst_n       = 1'b1;
        end
    end
  endtask 

  task dut_data_init();
    begin
      
      for (int i=2; i<64; i++)
        begin
          dif.message[i]  = 8'h00;
        end
      end

      @(posedge dif.clk);
      dif.load            = 1'b1;
      dif.message[0]      = 8'h61;
      dif.message[1]      = 8'h80;
      dif.message_length  = 1;
      dif.data_length[0]  = 0;
      dif.data_length[1]  = 0;

      @(posedge dif.clk);
      dif.load            = 1'b0;
      //$display("input w:%d @ %0t", dif.message, $time);
      $display("Message in HEX:%p @ %0t", dif.message, $time);
  endtask

endprogram