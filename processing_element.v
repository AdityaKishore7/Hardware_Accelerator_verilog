`include "fp_adder.v"
`include "fp_multiplier.v"

module pe(
    input [31:0] in_a, in_b,
    input clk,
    output reg [31:0] out_a, out_b, out_c
);

wire [31:0] prod_a_b;
wire [31:0] next_out_c;
always @ (posedge clk) begin
    out_a <= in_a;
    out_b <= in_b;
    out_c <= next_out_c;
end

fp_multiplier multiplier(.a(in_a), .b(in_b), .result(prod_a_b));
fp_adder adder(.a(out_c), .b(prod_a_b), .result(next_out_c));


initial out_c = 32'd0;
endmodule;
