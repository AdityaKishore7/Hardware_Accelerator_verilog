module fp_adder(
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

wire [7:0] exp_diff;
wire [23:0] mant_a_sf;
wire [23:0] mant_b_sf;
wire [7:0] exp_interim;

assign exp_diff = (exp_a > exp_b) ? (exp_a - exp_b) : (exp_b - exp_a);

assign mant_a_sf = (exp_a > exp_b) ? mant_a : (mant_a >> exp_diff);
assign mant_b_sf = (exp_a > exp_b) ? (mant_b >> exp_diff) : mant_b;

assign exp_interim = (exp_a > exp_b) ? exp_a : exp_b;

reg [24:0] mant_after_add;
reg sign_after_add;

always @ (*) begin
    if (sign_a == sign_b) begin
        mant_after_add = {1'b0, mant_a_sf} + {1'b0, mant_b_sf};
        sign_after_add = sign_a;
    end
    else begin
        if (mant_a_sf >= mant_b_sf) begin
            mant_after_add = {1'b0, mant_a_sf} - {1'b0, mant_b_sf};
            sign_after_add = sign_a;
        end
        else begin
            mant_after_add = {1'b0, mant_b_sf} - {1'b0, mant_a_sf};
            sign_after_add = sign_b;
        end
    end
end

reg [7:0] exp_result;
reg [24:0] mant_result;
integer k;
// initial begin
//     k = 22;
//     l = 1;
// end
reg [5:0]left_shift;
always @ (*) begin
    if (mant_after_add[24]) begin
        mant_result = mant_after_add >> 1;
        exp_result = exp_interim + 1;
    end
    else begin
        if(~mant_after_add[23]) begin
            // while(mant_after_add[k] | (k == 0)) begin
            //     k = k - 1;
            //     l = l + 1;
            // end
            for(k = 1; k < 24; k = k + 1) begin
                if(mant_after_add[23 - k]) begin
                    left_shift = k;
                    k = 30;
                end 
            end

            mant_result = mant_after_add << left_shift;
            exp_result = exp_interim - left_shift;
        end
        else begin
            exp_result = exp_interim;
            mant_result = mant_after_add;
        end
    end
end

assign result = {sign_after_add, exp_result, mant_result[22:0]};

endmodule