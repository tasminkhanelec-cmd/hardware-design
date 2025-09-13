module butterworth #(parameter N=8, parameter width = 32)(
input logic clk,
input logic rst,
input logic [width-1:0] xin,
output logic [width-1:0] yout
);

//filtercoefficients
parameter signed [width-1:0] b [0:N] = '{
   32'sd113,
   32'sd905,
   32'sd3168,
   32'sd6337,
   32'sd7921,
   32'sd6337,
   32'sd3168,
   32'sd905,
   32'sd113
};

parameter signed [width-1:0] a [0:N] = '{
   32'sd1048576,
   -32'sd4177301,
   32'sd7902314,
   -32'sd9017560,
   32'sd6711048,
   -32'sd3309332,
   32'sd1050355,
   -32'sd195394,
   32'sd16261
}; 

//delay registers
logic signed [width-1:0] xreg [0:N];
logic signed [width-1:0] yreg [1:N]; //no use of y0
logic signed [(2*width)-1:0] sum;   

always_comb 
  begin
	sum = 0;
   	for (int i = 0; i <= N; i++) 
	  begin
       		sum += b[i] * xreg[i];
   	  end
   	for (int i = 1; i <= N; i++) 
	  begin
       		sum -= a[i] * yreg[i];
   	  end
   	yout = sum >>> 20; //yout is combinational
  end

always_ff @(posedge clk or posedge rst)
	if (rst) 
	  begin
		xreg[0] <= 0;
		for (int i = 1; i <= N; i++) 
		  begin
                	xreg[i] <= 0;
                	yreg[i] <= 0;
                  end
	  end 
	else 
	  begin
		xreg[0] <= xin;
		xreg[1] <= xreg[0];
		for (int i = N; i > 1; i--) 
		  begin
                	xreg[i] <= xreg[i-1];
                	yreg[i] <= yreg[i-1];
		  end
		yreg[1] <= yout;
	  end

endmodule
	
