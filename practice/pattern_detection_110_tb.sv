//ans = 000100000100001
  
module detect_tb();
  
  logic clk, reset;
  logic [15:0] in, out;
  logic [4:0] i;
  
  initial begin
    clk=0;
    forever #5 clk = ~clk;
  end
  
  detection DUT(
    .in(in), .out(out), .reset(reset), .clk(clk), .i(i));
  
  initial begin
    reset = 1;
    in = 'b111010111000110;
    #6 reset = 0;
    #200;
    $display("Output string is %b", out);
    $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule 
