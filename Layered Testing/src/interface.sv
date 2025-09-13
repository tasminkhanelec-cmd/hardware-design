interface alu_interface(input clk);
  logic [7:0] a,b;
  logic [3:0]s;
  logic [15:0] out;
  
  clocking driver_cb @(negedge clk);
    default input #3 output #2;
    output a,b,s;
  endclocking
    
  clocking monitor_cb @(posedge clk);
    default input #3 output #2;
    input a,b,s,out;
  endclocking
  
  modport DRIVER(clocking driver_cb, input clk);
  modport MONITOR(clocking monitor_cb, input clk);
    
  /*the input or output direction for modport definition will come from the clocking block and will be as it is defined there, if smth is defined as output in the cloking block, so will it be in the modport */
  
endinterface
