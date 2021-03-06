module special_clock (input CLOCK_25,
							 input reset_n,
							 output slow_clock);
							 
		logic [20:0] counter;					 
		assign slow_clock = counter[20];
		
		always_ff @ (posedge CLOCK_25 or negedge reset_n)
		begin
				if (~reset_n)
					counter <= 10'h0;
				else
					counter <= counter + 1;
		end
endmodule	