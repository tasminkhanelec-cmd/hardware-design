`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  mailbox gen2driv;
  mailbox driv2sb;
  mailbox mon2sb;
  
  generator gen;
  driver driv;
  monitor mon;
  scoreboard scb;
  
  event driven;
  
  virtual alu_interface v_aluif;
  
  function new(virtual alu_interface v_aluif);
    this.v_aluif = v_aluif;
    gen2driv = new();
    driv2sb = new();
    mon2sb = new();
    
    gen = new(gen2driv);
    driv = new(gen2driv, driv2sb, v_aluif.DRIVER, driven);
    mon = new(mon2sb, v_aluif.MONITOR, driven);
    scb = new(driv2sb, mon2sb);
  endfunction
  
  task main(input int count);
    //main task of environment is to invoke these and to invoke them, you need to create them first in the function block, to create them you need to pass the mailbox as arguments and so create mailboxes annd other argument such as event trigger through them too
    
    //begin-end runs them sequentially and fork-join runs them concurrently, concurrently running them is essential to ensure all the components are running on the same timeline in realtime
    fork 
      gen.main(count);
      driv.main(count);
      mon.main(count);
      scb.main(count);
    join
    $finish;
  endtask
  
endclass
