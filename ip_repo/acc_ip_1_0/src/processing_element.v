`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module processing_element(
    input wire clk,
    input wire [31:0] in_a,
    input wire [31:0] in_b,
    output reg [31:0] out_c
);

  wire [31:0] mult_out, add_out;
  multiplier mul(in_a, in_b, mult_out);
  adder add(out_c, mult_out, add_out);

  always @(posedge clk) begin
    out_c <= add_out;
  end

  initial begin
    out_c = 32'b00000000000000000000000000000000;
  end

endmodule