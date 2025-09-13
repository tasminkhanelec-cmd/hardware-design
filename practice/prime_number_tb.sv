module tb;
  logic clk, reset;
  logic [31:0] A, N, sum, prime;
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  primer DUT( .clk(clk), .reset(reset), .A(A), .N(N), .sum(sum), .prime(prime));
  
  initial begin
    reset = 1;
    A = 3;
    N = 4;
    #6;
    reset = 0;
    #200;
    $display ("output is %0d", sum);
    $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
