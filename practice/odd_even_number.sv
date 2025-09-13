// Code your design here
module game(input logic[31:0]n, input logic clk, input logic reset, output logic [31:0]m);
  
  always @(posedge clk)
    begin
      if(reset) m <= n;
      else if((m%2)==0) m <= m>>1;
      else m<=3*m+1;
    end 
 
endmodule


