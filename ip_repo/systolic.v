`timescale 1ns / 1ps

module systolic #(parameter SYS_ROW = 9, parameter SYS_COL  = 9)
(     input M_AXI_ACLK,
    input M_AXI_ARESETN,
    input init_txn_pulse,
    input M_AXI_WREADY,
    input axi_wvalid,
    input[7:0] write_index,
    
    input [SYS_ROW*32 -1 : 0] wt_data,
    input [SYS_COL*32 -1 : 0] in_data,
    
 
    output s_axi_wdata
    
    );
  
  
    reg [31:0]reg_out_data[SYS_COL-1:0][SYS_ROW-1:0];
   
   
    genvar j;
    genvar i;
    generate
        for (i = 0; i < SYS_ROW ; i = i + 1) begin 
         for (j = 0; j < SYS_COL ; j = j + 1) begin : genblk1
         processing_element pe(
         .clk(M_AXI_ACLK),
          .in_a(in_data[SYS_COL*32-1 - 32*j -:32]),
          .in_b( wt_data[SYS_ROW*32-1 - 32*i-:32]),
          .out_c(reg_out_data[j][i])
          );
        end
        end
         endgenerate
         
         
 reg axi_wdata;
 assign s_axi_wdata = axi_wdata;
 always @(posedge M_AXI_ACLK)
                       begin
                 if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1)
                          begin
                        axi_wdata <= 0;
                            end
    // Signals a new write data is available by user logic
                        else if (M_AXI_WREADY && axi_wvalid)
                                   begin
                            axi_wdata <= reg_out_data[write_index / SYS_ROW][write_index % SYS_ROW];
                     end
              end
         
endmodule
