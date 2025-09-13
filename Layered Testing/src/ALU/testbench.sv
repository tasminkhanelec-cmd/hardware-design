`include "testcase01.sv"
`include "interface.sv"

module testbench;
  
  bit clk;
  
  initial begin 
    forever #5 clk=~clk;
  end
  
  
  int count = 100;
  alu_interface aluif(clk);
  test test01(count, aluif);
 
  
  alu DUT( //here passing the dut connections to the interface
    .a(aluif.a),
    .b(aluif.b),
    .s(aluif.s),
    .out(aluif.out),
    .clk(clk)
  );
  
  //use any other tool than xelium for coverage, free version does not enable coverage in EDA for this tol option. choose Aldec Riviera Pro instead.
  covergroup alu_coverage;
    coverpoint aluif.a { bins all_a[] = {[0:255]}; }
    coverpoint aluif.b { bins all_b[] = {[0:255]}; }
    coverpoint aluif.s { bins all_s[] = {[0:15]}; }
    cross aluif.a, aluif.b, aluif.s;
  endgroup
 
  
  alu_coverage cg;
  initial begin
    cg = new(); // Create coverage group instance
  end
  
  // Sample the coverage group on each clock cycle
  always @(posedge clk) begin
    cg.sample();
  end
 
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  
  final begin
    $display("Coverage Results:");
    $display("Total Coverage: %0d%% with %0d test combinations", cg.get_coverage(), count);
    $finish;
  end

  
endmodule
