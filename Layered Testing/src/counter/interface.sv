// Code your testbench here
// or browse Examples
interface counter_interface(input bit clk, rst);
  
 logic [7:0] data;
 logic [7:0] out;
 logic load;
  
 clocking clocking_cb @(posedge clk);
 default input #1 output #2;
 input out;
 output data;
 output load;
 endclocking
  
 clocking clocking_cb_b @(posedge clk);
 default input #3 output #1;
 input out;
 endclocking
  
endinterface
