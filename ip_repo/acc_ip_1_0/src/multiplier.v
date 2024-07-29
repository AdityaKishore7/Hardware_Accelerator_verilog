`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2024 02:26:52 AM
// Design Name: 
// Module Name: multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



 module multiplier (
    input wire [31:0] a,
    input wire [31:0] b,
    output reg [31:0] result
);

    // Extract components of the inputs
reg sign_a, sign_b;
reg [7:0] exp_a, exp_b;
reg [23:0] mantissa_a, mantissa_b;

reg sign_result;
reg [7:0] exp_result;
reg [47:0] mantissa_result;

always @* begin
    sign_a = a[31];
    sign_b = b[31];
    exp_a = a[30:23];
    exp_b = b[30:23];
    mantissa_a = {1'b1,a[22:0]};
    mantissa_b = {1'b1,b[22:0]};
end

always @* begin
    sign_result = sign_a ^ sign_b;
    exp_result = exp_a + exp_b - 8'd127;
    mantissa_result = mantissa_a * mantissa_b;
    
    
    if(mantissa_result[47] == 1'b1) begin
    exp_result = exp_result + 8'd1;
    mantissa_result = mantissa_result >> 1;
    end
    
    result = {sign_result, exp_result, mantissa_result[45:23]};
end

endmodule
