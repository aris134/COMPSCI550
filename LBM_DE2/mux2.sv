module mux2 #(DATA_WIDTH=32)(input logic signed [DATA_WIDTH-1:0] Din0,
									  input logic signed [DATA_WIDTH-1:0] Din1,
									  input select,
									  output logic signed [DATA_WIDTH-1:0] Dout);
				 
assign Dout = (select) ? Din1 : Din0;
endmodule 