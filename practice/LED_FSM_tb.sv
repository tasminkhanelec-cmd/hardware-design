module lighttb;
  logic A, clk, reset;
  logic [9:0] LED;
  
  initial begin 
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin
    $dumpfile("dumo.vcd");
    $dumpvars;
    #100;
    $finish;
  end
  
  lights DUT(.A(A), .clk(clk), .reset(reset), .LED(LED));
  
  initial begin
    reset = 1;
    A = 1;
    #6;
    reset = 0;
    #50;
    A = 0;
  end
  
endmodule
    
