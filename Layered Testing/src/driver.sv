class driver;
  //main duty is to link msgs among connected blocks and to produce output signals for DRIVER modoport so the necessary variables are:
  
  mailbox gen2driv, driv2sb;
  virtual alu_interface.DRIVER v_aluif;
  transaction d_trans;
  event driven;
  
  //now we need to initialized these variables the moment we create a object of this class, so we need to pass them through new () function
  
  function new(mailbox gen2driv, driv2sb, virtual alu_interface.DRIVER v_aluif, event driven);
    this.gen2driv = gen2driv;
    this.driv2sb = driv2sb;
    this.v_aluif = v_aluif; 
    this.driven = driven;
  endfunction
  
  //now we will define a task to call when we want to drive the outputs through transactor
  
  task main(input int count); //how many packets you wanna send is the count
    
    repeat(count) begin
      d_trans = new();
      gen2driv.get(d_trans); //receive driving signals aka transaction from upper level
      
      //now we send these signals to DUT via interface pointer
      @(v_aluif.driver_cb);
      //prepare output using transation
      v_aluif.driver_cb.a <= d_trans.a;
      v_aluif.driver_cb.b <= d_trans.b;
      v_aluif.driver_cb.s <= d_trans.s;
      
      driv2sb.put(d_trans); //send transaction to scoreboard
      ->driven; //raise flag
    end
    
  endtask
endclass
