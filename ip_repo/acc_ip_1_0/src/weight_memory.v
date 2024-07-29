`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2024 06:26:29 AM
// Design Name: 
// Module Name: weight_memory
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

module weight_memory #(parameter M_ROW = 9, parameter M_COL = 9 )(
    input M_AXI_ACLK,
    input M_AXI_ARESETN,
    input init_txn_pulse,
    input M_AXI_RVALID,
    input axi_rready,
    input [31:0] M_AXI_RDATA,
    input read_array_b,
    input [7:0] read_index_b,
    input systolic_array_start,
    output reg [M_ROW*32-1:0] wt_data,
    output reg systolic_array_done
);

reg [31:0] array_b [0:M_ROW - 1] [0:M_ROW - 1]; // 2D array to store elements of matrix b
integer row, col;
reg [7:0] col_counter;

always @(posedge M_AXI_ACLK) begin
    if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) begin
        for (row = 0; row < M_ROW; row = row + 1) begin
            for (col = 0; col < M_ROW; col = col + 1) begin
                array_b[row][col] <= 0;
            end
        end
        col_counter <= 0;
        systolic_array_done <= 0;
    end
    else if (M_AXI_RVALID && axi_rready) begin
        if (read_array_b) begin
            array_b[read_index_b / M_COL][read_index_b % M_COL] <= M_AXI_RDATA;
        end
    end
    else if (systolic_array_start) begin
        if (col_counter < M_COL) begin
            wt_data <= 0;
            for (row = 0; row < M_ROW; row = row + 1) begin
                wt_data <= {wt_data, array_b[row][col_counter]};
            end
            col_counter <= col_counter + 1;
        end
        else begin
            systolic_array_done <= 1;
        end
    end
end

endmodule
