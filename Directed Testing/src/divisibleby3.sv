module divisible(input logic [15:0]number,
                 input logic clk, reset,
                 output logic out, start);
  
  logic [15:0] temp;
  
  always @(posedge clk)
    if(reset)
      begin
        temp <= 0;
        out <= 0;
        start<=1;
      end
  else if(temp>number)
    begin
    out <= 0;
      start<=0;
    end
  else if(temp==number)
    begin
    out <= 1;
     start <= 0;
    end
  else if(temp<number)
    temp <= temp+2'b11;
  
endmodule
