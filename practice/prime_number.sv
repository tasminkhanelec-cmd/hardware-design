module primer(input logic[31:0] A, N,
             input logic clk, reset,
              output logic [31:0] sum, prime);
  
  logic [31:0] i;
  
  always @(posedge clk)
    begin
      if(reset)
        begin
          sum <= 0;
          i <= 0;
          prime <= A;
        end
      else if(i<N)
        begin
          while(isprime(prime)!==1)
            begin
              $display("not prime yet %0d", prime);
              prime = prime+1;
            end
          $display("prime ho chuki %0d", prime);
          sum <= sum+prime;
          i <= i+1;
          prime <= prime+1;
        end
    end
  
      
  function bit isprime(input int check);
    for(int j=2; j<check; j++)
      if(check%j==0)
        begin
          return 0;
          break;
        end
    return 1;
  endfunction
      
  
 endmodule
