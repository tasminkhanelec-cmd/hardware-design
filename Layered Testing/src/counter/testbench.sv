`include "interface.sv"

module tb_top;
  
  logic clk;
  logic rst;
  
  logic [7:0] data_rcv_a;
  logic [7:0] data_rcv_b;
  
  counter_interface c_if(clk,rst);
  
  
  initial begin
    clk = 0;
    c_if.clocking_cb.load <= 0;
    c_if.clocking_cb.data <= 0;
    rst = 1;
    #10;
    rst = 0;
  end
 
  
  initial forever #5 clk=~clk;
 
  
  initial begin
    
    repeat(5) @(c_if.clocking_cb);
    c_if.clocking_cb.data <= 8'b01101100; //6c
    c_if.clocking_cb.load <= 1;
    @(c_if.clocking_cb);
    c_if.clocking_cb.load <=0;
    
    repeat (5) @(c_if.clocking_cb);
    data_rcv_a = c_if.clocking_cb.out;
    data_rcv_b = c_if.clocking_cb_b.out;
    
    $display("");
    $display("Data Received for a is %0h @%0t ns", data_rcv_a, $time);
    $display("Data Received for b is %0h @%0t ns", data_rcv_b, $time);
    $display("");
    
    #200;
    $finish;
  end
  
  counter dut(
    .clk(clk),
    .rst(rst),
    .data(c_if.data),
    .load(c_if.load),
    .out(c_if.out)
  );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
