module traffictb;
  logic clk, reset;
  logic [5:0]R;
  
  traffic DUT(
    .clk(clk),
    .reset(reset),
    .R(R));
  
  initial begin
    clk =0;
    forever #5 clk=~clk;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #200;
    $finish;
  end
  
  initial begin
    reset = 1;
    #6;
    reset = 0;
   end 
  
   always @(negedge clk)
      begin
        $display("Route: blue %2b  black %2b  yellow %2b",
              R[5:4], R[3:2], R[1:0]);
      end
               
endmodule 
               
    
