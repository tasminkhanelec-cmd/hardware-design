class monitor;
  
  mailbox mon2sb;
  virtual alu_interface.MONITOR v_aluif;
  transaction m_trans;
  event driven;
  
  function new(mailbox mon2sb, virtual alu_interface.MONITOR v_aluif, event driven);
    this.mon2sb = mon2sb;
    this.v_aluif = v_aluif;
    this.driven = driven;
  endfunction
  
  task main(input int count);
    @(driven);
    @(v_aluif.monitor_cb);
    
    repeat(count) begin
      m_trans = new();
      //why not use @(alu_interface.monitor_cb); here
      @(posedge v_aluif.clk);
      
      //prepare the transaction
      m_trans.out = v_aluif.monitor_cb.out;
      //you can not assign values to clocking block input coming from DUT but you can retrieve these values and use them elsewhere
      
      mon2sb.put(m_trans);
    end
    
  endtask
  
endclass
