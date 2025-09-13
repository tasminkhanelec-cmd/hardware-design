module tb;
  
  logic signed [7:0] V11;
  logic signed [7:0] V12;
  logic signed [7:0] V21;
  logic signed [7:0] V22;
  logic signed [15:0] Vo1;
  logic signed [15:0] Vo2;
  logic signed [15:0] Vo3;
  
  crossmul DUT(.V11(V11),
               .V12(V12),
               .V21(V21),
               .V22(V22),
               .Vo1(Vo1),
               .Vo2(Vo2),
               .Vo3(Vo3));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #200;
    $finish;
  end
  
  initial begin
    #2;
    $monitor("Vout=%0di+%0dj+%0dk for V1=%0di+%0dj and V2=%0dj+%0dk", Vo1,Vo2,Vo3,V11,V12,V21,V22);
  end
  
  initial begin
    V11=0;
    V12=0;
    V21=0;
    V22=0;
    #5;
    V21=3;
    #5;
    V22=4;
    #5;
    V11=2;
    #5;
    V22=0;
    #5;
    V12=-5;
    #5;
    V22=-2;
    #5;
    V21=-12;
  end
endmodule
  
  
