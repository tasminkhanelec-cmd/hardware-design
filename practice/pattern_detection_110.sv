module detection(input logic [15:0]in,
                 output logic [15:0]out,
                 output logic [4:0]i,
                 input logic clk, reset);
  
  logic [15:0]temp;
  logic detect;
 
  typedef enum logic [1:0] {S0,S1,S2,S3} statetype;
  statetype current, next;
  
  always_comb

    case(current)
      S0: if(temp[15]) next <= S1;
      else next <= S0;
      S1: if(temp[15]) next <= S2;
      else next <= S0;
      S2: if(temp[15]) next <= S2;
      else next <= S3;
      S3: next <= S0;
    endcase
  
  always @(posedge clk)
    if(reset)
      begin
        temp <= in;
        current <= S0;
        i = 16;
      end
    else 
      begin
        current <= next;
      end
  
  always @(negedge clk)
    if(i!==0)
      begin
        out[i-1] = detect;
        i-=1;
        temp = temp<<1;
      end
  
  always_comb
    detect = (current == S3);
  
endmodule
