module tb;
  logic signed [7:0] b,c,x1r, x2r, x1i, x2i;
  
  solver DUT(.b(b),
             .c(c),
             .x1r(x1r), 
             .x2r(x2r), 
             .x1i(x1i), 
             .x2i(x2i));
  
  initial begin
    b = -2;
    c = 5;
    #3;
    $display("outputs are %0d+%0di and %0d+%0di",
             x1r, x1i, x2r, x2i);
    b=3;
    c=-4;
    #3;
    $display("outputs are %0d+%0di and %0d+%0di",
             x1r, x1i, x2r, x2i);
    #1;
  end
  
endmodule
