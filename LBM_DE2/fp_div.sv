/*
	This module represents a
	fixed point divider. This is derived
	from the Project F Library by Will Green
	
	https://github.com/projf/projf-explore/blob/master/lib/maths/div_int.sv
	
	This module was modified to accomodate signed division.
	
*/

module fp_div #(
    parameter WIDTH=32,  // width of numbers in bits
    parameter FBITS=24   // fractional bits (for fixed point)
    ) (
    input wire logic clk,
    input wire logic start,          // start signal
    output     logic busy,           // calculation in progress
    output     logic valid,          // quotient and remainder are valid
    output     logic dbz,            // divide by zero flag
    output     logic ovf,            // overflow flag (fixed-point)
    input wire logic signed [WIDTH-1:0] x,  // dividend
    input wire logic signed [WIDTH-1:0] y,  // divisor
    output		logic signed [WIDTH-1:0] q,  // quotient
    output     logic signed [WIDTH-1:0] r   // remainder
    );

    // avoid negative vector width when fractional bits are not used
    localparam FBITSW = (FBITS) ? FBITS : 1;

    logic signed [WIDTH-1:0] y1;           // copy of divisor
    logic [WIDTH-1:0] q1, q1_next;  // intermediate quotient
    logic [WIDTH:0] ac, ac_next;    // accumulator (1 bit wider)

    localparam ITER = WIDTH+FBITS;  // iterations are dividend width + fractional bits
    logic [$clog2(ITER)-1:0] i;     // iteration counter
	 logic negate;
	 logic signed [WIDTH-1:0] x1;

	 assign negate = x[WIDTH-1] ^ y[WIDTH-1]; // avoid negative numbers (multiply the positive numbers)
	 assign x1 = (x > 0) ? x : -x;
	 assign y1 = (y > 0) ? y : -y;
	 
    always_comb begin
        if (ac >= {1'b0,y1}) begin
            ac_next = ac - y1;
            {ac_next, q1_next} = {ac_next[WIDTH-1:0], q1, 1'b1};
        end else begin
            {ac_next, q1_next} = {ac, q1} << 1;
        end
    end

    always_ff @(posedge clk) begin
        if (start) begin
            valid <= 0;
            ovf <= 0;
            i <= 0;
            if (y == 0) begin  // catch divide by zero
                busy <= 0;
                dbz <= 1;
            end else begin
                busy <= 1;
                dbz <= 0;
                {ac, q1} <= {{WIDTH{1'b0}}, x1, 1'b0}; //
            end
        end else if (busy) begin
            if (i == ITER-1) begin  // done
                busy <= 0;
                valid <= 1;
                r <= ac_next[WIDTH:1];  // undo final shift
					 if (!negate) begin
						q <= q1_next;
					 end else begin
						q <= ~q1_next + 1;
					 end
            end else if (i == WIDTH-1 && q1_next[WIDTH-1:WIDTH-FBITSW]) begin // overflow?
                busy <= 0;
                ovf <= 1;
                q <= 0;
                r <= 0;
            end else begin  // next iteration
                i <= i + 1;
                ac <= ac_next;
                q1 <= q1_next;
            end
        end
    end
endmodule
