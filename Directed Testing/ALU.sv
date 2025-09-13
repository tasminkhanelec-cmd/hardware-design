module ALU(input logic [1:0]S, input logic [31:0]A, B, 
           input logic clk, reset, output logic [31:0]out);
  
  always @(posedge clk)
    if(reset)
      out<=0;
  else
    case(S)
      2'b00: out<=A+B;
      2'b01: out<=A-B;
      2'b10: if(A<B) out<=A+1;
               else out<=B+1;
      2'b11: if(A>B) out<=A-1;
               else out<=B-1;
    endcase
endmodule
  
