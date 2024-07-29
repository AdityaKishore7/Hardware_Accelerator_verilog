module fp_multiplier(
    input [31:0] a, b,
    output [31:0] result
);

wire sign_a, sign_b;
wire [7:0] exp_a, exp_b;
wire [23:0] mant_a, mant_b;

assign sign_a = a[31];
assign sign_b = b[31];

assign exp_a = a[30:23];
assign exp_b = b[30:23];

assign mant_a = {1'b1, a[22:0]};
assign mant_b = {1'b1, b[22:0]};

wire sign_result;

assign sign_result = sign_a ^ sign_b;

wire [47:0]mult_a_b;

assign mult_a_b = mant_a * mant_b;

wire [8:0] exp_sum;
assign exp_sum = exp_a + exp_b - 9'd127;

reg [22:0]mant_result;
reg [7:0]exp_result;

always @ (*) begin
    if(mult_a_b[47]) begin
        mant_result = mult_a_b[46:24];
        exp_result = exp_sum + 9'b1;
    end
    else begin
        mant_result = mult_a_b[45:23];
        exp_result = exp_sum;
    end
end

assign result  = {sign_result, exp_result, mant_result};

endmodule 


