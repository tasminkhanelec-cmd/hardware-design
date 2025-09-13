class evenpress;
  rand bit [9:0] a;
  constraint range{a inside {10'b0100000000,
                             10'b0001000000,
                             10'b0000010000,
                             10'b0000000100,
                             10'b0000000001};}
  function void randing();
    this.randomize();
  endfunction
  
endclass

class oddpress;
  rand bit [9:0] a;
  constraint range{a inside {10'b1000000000,
                             10'b0010000000,
                             10'b0000100000,
                             10'b0000001000,
                             10'b0000000010};}
  function void randing();
    this.randomize();
  endfunction
  
endclass

