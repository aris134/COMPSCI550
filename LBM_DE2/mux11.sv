module mux11 #(DATA_WIDTH=32*9)( // was 9*16*16 for some reason?
									  input logic signed [DATA_WIDTH-1:0] Din0,
									  input logic signed [DATA_WIDTH-1:0] Din1,
									  input logic signed [DATA_WIDTH-1:0] Din2,
									  input logic signed [DATA_WIDTH-1:0] Din3,
									  input logic signed [DATA_WIDTH-1:0] Din4,
									  input logic signed [DATA_WIDTH-1:0] Din5,
									  input logic signed [DATA_WIDTH-1:0] Din6,
									  input logic signed [DATA_WIDTH-1:0] Din7,
									  input logic signed [DATA_WIDTH-1:0] Din8,
									  input logic signed [DATA_WIDTH-1:0] Din9,
									  input logic signed [DATA_WIDTH-1:0] Din10,
									  input [3:0] select,
									  output logic signed [DATA_WIDTH-1:0] Dout);
				 
logic signed [DATA_WIDTH-1:0] Dout_wire;
assign Dout = Dout_wire;
always @ (Din0 or Din1 or Din2 or Din3 or Din4 or Din5 or Din6 or Din7 or Din8 or Din9 or Din10 or select)
begin
	case(select)
	4'b0000		   :Dout_wire = Din0; 
	4'b0001			:Dout_wire = Din1;
	4'b0010			:Dout_wire = Din2;
	4'b0011			:Dout_wire = Din3;
	4'b0100			:Dout_wire = Din4;
	4'b0101			:Dout_wire = Din5;
	4'b0110			:Dout_wire = Din6;
	4'b0111			:Dout_wire = Din7;
	4'b1000			:Dout_wire = Din8;
	4'b1001			:Dout_wire = Din9;
	4'b1010			:Dout_wire = Din10;
	default  		:Dout_wire = Din0; 
	endcase
end
endmodule 