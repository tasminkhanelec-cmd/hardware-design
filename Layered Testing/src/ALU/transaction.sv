class transaction;
  
  rand bit[7:0] a;
  rand bit[7:0] b;
  randc bit[3:0] s;
  bit[15:0] out;
  
endclass

// interface class is the wire group connecting modules, this class helps select which wire will be driven at what clock edge

//transaction class is the data packet to be driven through corresponding wires
