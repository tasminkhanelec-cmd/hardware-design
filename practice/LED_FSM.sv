`include "LED_FSM_rand.sv"

module lights(input logic A, 
              output logic [9:0] LED, 
              input logic clk, 
              input logic reset);
  
  typedef enum logic [1:0] {S0, S1, S2} statetype;
  statetype state, next;
  
  
  oddpress odd;
  evenpress even;
  
  initial begin
  odd = new();
  even = new();
  end
  
  always_comb 
    case(state)
      S0: next = A? S1: S0;
      S1: next = A? S2: S1;
      S2: next = A? S1: S2;
    endcase
    
    always @(posedge clk)
      if(reset) state <= S0;
  else state <= next;
  
  always_comb
      if(state == S0) LED <= 'b0;
    else if(state == S1) begin
      odd.randing();
      LED <= odd.a;
    end
    else if(state == S2) begin
      even.randing();
      LED <= even.a;
    end
endmodule
