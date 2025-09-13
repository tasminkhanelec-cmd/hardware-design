module solver(input logic signed [7:0] b,c,
              output logic signed [7:0] x1r, x2r, x1i, x2i);
  
  logic signed [31:0] sqrt; 
  
  //sqrt is never negative but if you mix signed logic with unsigned logic (whic is the default) then usually unsigned result is assigned in xreal or ximaginay, so do not mix types in one equation, and if noth converges just put just put $signed infront of everything like x1r = ($signed(-b)+$signed(sqrt))/2
  
  always_comb
      if ((b*b) > (4*c)) begin
        sqrt = getsqrt(((b*b)-$signed(4*c)));
        x1i = 0;
        x2i = 0;
        x1r = ((-b) + (sqrt))/2 ; 
        x2r = ((-b) + (-sqrt))/2;
      end
      else begin
        sqrt = getsqrt((-(b*b)+(4*c)));
        x1i = sqrt/2;
        x2i = (-sqrt)/2;
        x1r = (-b)/2; 
        x2r = (-b)/2;
      end
          
  function logic [7:0]  getsqrt(input int y);
    static logic [7:0]  z = 0;
    static logic [31:0]  result = 0;
      while (result <= y)
        begin
          z = z+1;
          result = z*z;
        end
    return (z-1);
  endfunction
      
endmodule
