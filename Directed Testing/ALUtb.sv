module tbALU;
  logic[1:0]S;
  logic [31:0]A,B,out;
  logic clk, reset;
  
  initial begin
    clk = 0;
    forever #5 clk=~clk;
  end
  
  ALU DUT(
    .A(A),
    .B(B),
    .out(out),
    .reset(reset),
    .clk(clk),
    .S(S));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  initial begin
    reset = 1;
    A=6;
    B=3;
    S=0;
    #6 reset=0;
    #10;
    $display("output %0d",out);
    S=1;
    #10;
    $display("output %0d",out);
    S=2;
    #10;
    $display("output %0d",out);
    S=3;
    #10;
    $display("output %0d",out);
    #2;
    $finish;
    
  end
endmodule
