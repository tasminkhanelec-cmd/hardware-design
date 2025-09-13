`include "environment.sv"

//program block is used to avoid race conditions by being run after module block. Ensures the testbench (program) logic always runs after the DUT logic (module) in the same simulation timestep.

program test(input int count, alu_interface aluif);
  environment env;
  
  class testcase01 extends transaction;
    constraint c_s{
      s inside {[0:15]};
    }
  endclass
  
  initial begin
    testcase01 testcase01handle;
    testcase01handle = new();
    
    env = new(aluif);
    env.gen.custom_trans = testcase01handle;
    env.main(count);
  end
  
endprogram
      
