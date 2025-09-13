`include "transaction.sv"

class generator;
  mailbox gen2driv;
  transaction g_trans, custom_trans;
  transaction copy_trans;
  
  function new(mailbox gen2driv);
    this.gen2driv = gen2driv;
  endfunction
  
  /*task print_mailbox();
    transaction temp_trans;
    int msg_count;
    msg_count = gen2driv.num(); // Get the size of the mailbox
    
    for (int i = 0; i < msg_count; i++) begin
      gen2driv.get(temp_trans); // Get the transaction from the mailbox
      $display("Transaction %0d: a=%0d, b=%0d, s=%0d", 
               i, temp_trans.a, temp_trans.b, temp_trans.s);
      gen2driv.put(temp_trans); // Put it back to maintain the original state
    end
  endtask*/
  
  
  task main(input int count);
    g_trans = new();
    g_trans = new custom_trans;
   
    
    //custom trans is useful if we wanna assign constraints on randomization through this custom class
    repeat(count) begin
      assert(g_trans.randomize()) //no semicolon here
        else $fatal("Randomization failed!");
      
      
      copy_trans = new();
      copy_trans = new g_trans;

      gen2driv.put(copy_trans);
      //print_mailbox();
    end
    
    
  endtask
  
endclass
