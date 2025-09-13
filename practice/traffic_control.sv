module traffic(input logic clk, reset, 
               output logic [5:0] R);
  logic [2:0] current;
  logic [1:0] b,bl,y;
  
  always_comb
    case(current)
      'd0: begin b = 01; bl = 01; y = 01; end
      'd1: begin y=~y; end
      'd2: begin bl=~bl; y=~y; end
      'd3: begin y=~y; end
      'd4: begin b=~b; bl=~bl; y=~y; end
      'd5: begin y=~y; end
      'd6: begin bl=~bl; y=~y; end
      'd7: begin y=~y; end
    endcase
  
  always_comb
    R ={b,bl,y};
    
  always @(posedge clk)
    if(reset)
      current = 0;
  else
    current += 1;
  
endmodule
