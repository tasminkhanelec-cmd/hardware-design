module crossmul(input logic signed [7:0] V11,
                input logic signed [7:0] V12,
                input logic signed [7:0] V21,
                input logic signed [7:0] V22,
                output logic signed [15:0] Vo1,
                output logic signed [15:0] Vo2,
                output logic signed [15:0] Vo3);
  always_comb
    begin
      Vo1 = V12*V22;
      Vo2 = -(V11*V22);
      Vo3 = V11*V21;
    end
  
endmodule
