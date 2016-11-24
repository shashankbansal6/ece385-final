module rdbw (input clk,
				 input reset_n,
				 output [9:0] bw_rdaddr);
				 
	
		always_ff @ (posedge clk or negedge reset_n)
		begin
				if (~reset_n)
					bw_rdaddr <= 10'h0;
				else if (bw_rdaddr < 784)
					bw_rdaddr <= bw_rdaddr + 1;
				else 
					bw_rdaddr <= 10'h0;
		end
		
endmodule
