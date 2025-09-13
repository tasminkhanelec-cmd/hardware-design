
module counter(clk, rst, load, data, out);
 input clk;
 input rst;
 input load;
 
 input [7:0] data;
 output reg [7:0] out;
 
 always @(posedge clk) begin
 if(rst) out <= 0;
 else if (load) out <= data;
 else #8 out <= out + 1;
 end
endmodule
