`timescale 1ns / 1ps
//////////////////////////////////////////////////////


module adder(
    input wire [31:0] a,
    input wire [31:0] b,
    output reg [31:0] result
);


reg sign_a, sign_b;
reg [7:0] exp_a, exp_b;
reg [23:0] mantissa_a, mantissa_b;


reg sign_result;
reg [7:0] exp_result;
reg [24:0] mantissa_result;
integer i; 
// Splitting inputs into sign, exponent, and mantissa
always @* begin
    sign_a = a[31];
    sign_b = b[31];
    exp_a = a[30:23];
    exp_b = b[30:23];
    mantissa_a = {1'b1,a[22:0]};
    mantissa_b = {1'b1,b[22:0]};
end
always @* begin
  
    if(exp_a > exp_b) begin
        exp_result = exp_a;
        mantissa_b = mantissa_b >> (exp_a - exp_b);
    end 
    else begin
        exp_result = exp_b;
        mantissa_a = mantissa_a >> (exp_b - exp_a);
    end

 
    if(sign_a == sign_b) begin
        mantissa_result = mantissa_a + mantissa_b;
         sign_result=sign_a;
    end 
    else begin

         if ( mantissa_a > mantissa_b) begin 
         sign_result=sign_a;
          mantissa_result = mantissa_a - mantissa_b;  
  //       e = 1'b1; 
         end else if ( mantissa_a == mantissa_b) begin 
          sign_result=0; 
            exp_result=7'b0;
           mantissa_result = mantissa_a - mantissa_b;
          end else begin
            sign_result=sign_b;
             mantissa_result = mantissa_b - mantissa_a;
            end 
  end

    //Checking for overflow in mantissa
   
        if(mantissa_result[24] == 1'b1)  begin
        mantissa_result = mantissa_result >> 1; 
        exp_result = exp_result + 1;
     //   f = 1'b1;
        end

   // Checking for underflow in mantissa
   // Assuming mantissa_result is 24-bit
     if (mantissa_result != 24'b0) begin
for (i = 0; i < 24; i = i + 1) begin
    if ((mantissa_result[23] == 1'b0) && (mantissa_result != 24'b0)) begin
        exp_result = exp_result - 1;
        mantissa_result = mantissa_result << 1;
    end
end
end



    // Combining sign, exponent, and mantissa to get the result
    
    result = {sign_result, exp_result, mantissa_result[22:0]};
end

endmodule



