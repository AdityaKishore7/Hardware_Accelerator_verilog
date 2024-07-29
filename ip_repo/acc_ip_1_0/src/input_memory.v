module input_memory #(parameter M_ROW = 9, parameter M_COL = 9 )(
    input M_AXI_ACLK,
    input M_AXI_ARESETN,
    input init_txn_pulse,
    input M_AXI_RVALID,
    input axi_rready,
    input [31:0] M_AXI_RDATA,
    input read_array_a,
    input [7:0] read_index_a,
    input systolic_array_start,
    output reg [M_COL*32-1:0] in_data,
    output reg systolic_array_done
);

reg [31:0] array_a [0:M_COL - 1] [0:M_COL - 1]; // 2D array to store elements of matrix A
integer row, col;
reg [7:0] row_counter;

always @(posedge M_AXI_ACLK) begin
    if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) begin
        for (row = 0; row < M_COL; row = row + 1) begin
            for (col = 0; col < M_COL; col = col + 1) begin
                array_a[row][col] <= 0;
            end
        end
        row_counter <= 0;
        systolic_array_done <= 0;
    end
    else if (M_AXI_RVALID && axi_rready) begin
        if (read_array_a) begin
            array_a[read_index_a / M_COL][read_index_a % M_COL] <= M_AXI_RDATA;
        end
    end
    
    
    
    else if (systolic_array_start) begin
        if (row_counter < M_ROW) begin
            in_data <= 0;
            for (col = 0; col < M_COL; col = col + 1) begin
                in_data <= {in_data, array_a[row_counter][col]};
            end
            row_counter <= row_counter + 1;
        end
        else begin
            systolic_array_done <= 1;
        end
    end
end

endmodule