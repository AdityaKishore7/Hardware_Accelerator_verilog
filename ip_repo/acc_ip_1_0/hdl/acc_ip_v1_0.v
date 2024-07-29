
`timescale 1 ns / 1 ps

	module acc_ip_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 6,
      
		// Parameters of Axi Master Bus Interface M00_AXI
		parameter  C_M00_AXI_START_DATA_VALUE	= 32'hAA000000,
		parameter  C_M00_AXI_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		parameter integer C_M00_AXI_ADDR_WIDTH	= 32,
		parameter integer C_M00_AXI_DATA_WIDTH	= 32,
		parameter integer C_M00_AXI_TRANSACTIONS_NUM	= 9*9,
		parameter M_ROW =9,
		parameter M_COL =9
		
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready,

		// Ports of Axi Master Bus Interface M00_AXI
		
		output wire  m00_axi_error,
		output wire  m00_axi_txn_done,
		input wire  m00_axi_aclk,
		input wire  m00_axi_aresetn,
		output wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_awaddr,
		output wire [2 : 0] m00_axi_awprot,
		output wire  m00_axi_awvalid,
		input wire  m00_axi_awready,
		output wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_wdata,
		output wire [C_M00_AXI_DATA_WIDTH/8-1 : 0] m00_axi_wstrb,
		output wire  m00_axi_wvalid,
		input wire  m00_axi_wready,
		input wire [1 : 0] m00_axi_bresp,
		input wire  m00_axi_bvalid,
		output wire  m00_axi_bready,
		output wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_araddr,
		output wire [2 : 0] m00_axi_arprot,
		output wire  m00_axi_arvalid,
		input wire  m00_axi_arready,
		input wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_rdata,
		input wire [1 : 0] m00_axi_rresp,
		input wire  m00_axi_rvalid,
		output wire  m00_axi_rready
	);
	
	
	
 wire [31:0] InputImageAddress; //(slv_reg0)
 wire [3:0] InputImageDimensions;//  (slv_reg1)
 wire [31:0] ConvolutionKernelAddress ;// (slv_reg2)
 wire [1:0] ConvolutionKernelDimensions;//  (slv_reg3)
 wire [31:0] OutputImageAddress;//  (slv_reg4)
 wire [31:0] MatrixAAddress ;// (slv_reg5)
 wire [3:0] MatrixADimensions ;// (slv_reg6)
 wire [31:0] MatrixBAddress;//  (slv_reg7)
 wire [3:0] MatrixBDimensions;//  (slv_reg8)
 wire [31:0] OutputMatrixAddress;//  (slv_reg9)
 wire  ConvolutionOperationInterrupt;// (slv_reg10)
 wire  MatrixOperationInterrupt ;//(slv_reg11)
// Instantiation of Axi Bus Interface S00_AXI
	acc_ip_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) acc_ip_v1_0_S00_AXI_inst (
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready),
		 .InputImageAddress(InputImageAddress),
.InputImageDimensions(InputImageDimensions),
 .ConvolutionKernelAddress(ConvolutionKernelAddress) ,
 .ConvolutionKernelDimensions(ConvolutionKernelDimensions),
 .OutputImageAddress(OutputImageAddress),
 .MatrixAAddress(MatrixAAddress) ,
 .MatrixADimensions(MatrixADimensions) ,
 .MatrixBAddress(MatrixBAddress),
 .MatrixBDimensions(MatrixBDimensions),
 .OutputMatrixAddress(OutputMatrixAddress),
 .ConvolutionOperationInterrupt(ConvolutionOperationInterrupt),
.MatrixOperationInterrupt(MatrixOperationInterrupt) 
		
	);
	
 wire read_array_a;
 wire [7:0]read_index_a;
 wire read_done;
 wire write_done;
 wire read_array_b;
 wire [7:0]read_index_b;
wire  m00_axi_init_axi_txn;
wire systolic_done;
 wire [31:0] axi_wdata;
  wire [31:0] w_MatrixAAddress ;// (slv_reg5)
 wire [3:0] w_MatrixADimensions ;// (slv_reg6)
 wire [31:0]w_MatrixBAddress;//  (slv_reg7)
 wire [3:0]w_MatrixBDimensions;//  (slv_reg8)
 wire [31:0]w_OutputMatrixAddress;//  (slv_reg9)
// Instantiation of Axi Bus Interface M00_AXI
	acc_ip_v1_0_M00_AXI # ( 
		.C_M_START_DATA_VALUE(C_M00_AXI_START_DATA_VALUE),
		.C_M_TARGET_SLAVE_BASE_ADDR(C_M00_AXI_TARGET_SLAVE_BASE_ADDR),
		.C_M_AXI_ADDR_WIDTH(C_M00_AXI_ADDR_WIDTH),
		.C_M_AXI_DATA_WIDTH(C_M00_AXI_DATA_WIDTH),
		.C_M_TRANSACTIONS_NUM(C_M00_AXI_TRANSACTIONS_NUM)
	) acc_ip_v1_0_M00_AXI_inst (
		.INIT_AXI_TXN(m00_axi_init_axi_txn),
		.ERROR(m00_axi_error),
		.TXN_DONE(m00_axi_txn_done),
		.M_AXI_ACLK(m00_axi_aclk),
		.M_AXI_ARESETN(m00_axi_aresetn),
		.M_AXI_AWADDR(m00_axi_awaddr),
		.M_AXI_AWPROT(m00_axi_awprot),
		.M_AXI_AWVALID(m00_axi_awvalid),
		.M_AXI_AWREADY(m00_axi_awready),
		.M_AXI_WDATA(m00_axi_wdata),
		.M_AXI_WSTRB(m00_axi_wstrb),
		.M_AXI_WVALID(m00_axi_wvalid),
		.M_AXI_WREADY(m00_axi_wready),
		.M_AXI_BRESP(m00_axi_bresp),
		.M_AXI_BVALID(m00_axi_bvalid),
		.M_AXI_BREADY(m00_axi_bready),
		.M_AXI_ARADDR(m00_axi_araddr),
		.M_AXI_ARPROT(m00_axi_arprot),
		.M_AXI_ARVALID(m00_axi_arvalid),
		.M_AXI_ARREADY(m00_axi_arready),
		.M_AXI_RDATA(m00_axi_rdata),
		.M_AXI_RRESP(m00_axi_rresp),
		.M_AXI_RVALID(m00_axi_rvalid),
		.M_AXI_RREADY(m00_axi_rready),
		 .m_read_array_a(read_array_a),
	   .m_read_index_a(read_index_a),
		.m_reads_done(read_done),
		.m_write_done(write_done),
		.m_read_array_b(read_array_b),
	   .m_read_index_b(read_index_b),
	   .m_write_index(write_index),
	   .SYSTOLIC_DONE(systolic_done),                              
	   .c_MatrixAAddress(w_MatrixAAddress) ,
   .c_MatrixADimensions(w_MatrixADimensions) ,
   .c_MatrixBAddress(w_MatrixBAddress),
   . c_MatrixBDimensions(w_MatrixBDimensions),
  . OutputMatrixAddress(w_OutputMatrixAddress),
  .axi_wdata(axi_wdata)
			
	);
 
 

  
	// Add user logic here
reg[3:0] ROW=0;
     reg[3:0] COL=0;
    always@(*)begin
    if(w_operation)begin
    ROW <= w_MatrixADimensions;
    COL <= w_MatrixBDimensions;
    end 
    else begin 
    ROW <= w_MatrixBDimensions - w_MatrixADimensions +1;
    COL <= 1;
    end
  end

wire w_systolic_array_start;
wire  [M_COL*32-1:0] in_data;
wire  [M_ROW*32-1:0] wt_data;
input_memory #(.M_ROW(M_ROW),.M_COL(M_COL)) IM( .INIT_AXI_TXN(m00_axi_init_axi_txn),
                                                .M_AXI_ARESETN(m00_axi_aresetn),
                                                .M_AXI_ACLK(m00_axi_aclk), 
                                               .M_AXI_RDATA(m00_axi_rdata),
                                               .M_AXI_RVALID(m00_axi_rvalid),
		                                       .axi_rready(m00_axi_rready),
		                                       .read_array_a(read_array_a),
		                                       .read_index_a(read_index_a),
		                                       .read_done(read_done),
		                                       .in_data(in_data),
		                                       .systolic_array_start(w_systolic_array_start),
		                                       .systolic_array_done(systolic_done)
		                                       );


weight_memory #(.M_ROW(M_ROW),.M_COL(M_COL)) WM(  .INIT_AXI_TXN(m00_axi_init_axi_txn),
                                                .M_AXI_ARESETN(m00_axi_aresetn),
                                                .M_AXI_ACLK(m00_axi_aclk), 
                                                .M_AXI_RDATA(m00_axi_rdata),
                                                .M_AXI_RVALID(m00_axi_rvalid),
		                                        .axi_rready(m00_axi_rready),
		                                        .read_array_b(read_array_b),
		                                        .read_index_b(read_index_b),
		                                        .read_done(read_done),
		                                        .wt_data(wt_data),
		                                        .systolic_array_start(w_systolic_array_start)
		                                       
		                                        );
  

controller(
.InputImageAddress(InputImageAddress),
.InputImageDimensions(InputImageDimensions),
 .ConvolutionKernelAddress(ConvolutionKernelAddress) ,
 .ConvolutionKernelDimensions(ConvolutionKernelDimensions),
 .OutputImageAddress(OutputImageAddress),
 .MatrixAAddress(MatrixAAddress) ,
 .MatrixADimensions(MatrixADimensions) ,
 .MatrixBAddress(MatrixBAddress),
 .MatrixBDimensions(MatrixBDimensions),
 .OutputMatrixAddress(OutputMatrixAddress),
 .ConvolutionOperationInterrupt(ConvolutionOperationInterrupt),
.MatrixOperationInterrupt(MatrixOperationInterrupt), 
   
.c_MatrixAAddress(w_MatrixAAddress) ,
.c_MatrixADimensions(w_MatrixADimensions) ,
.c_MatrixBAddress(w_MatrixBAddress),
.c_MatrixBDimensions(w_MatrixBDimensions),
.c_OutputMatrixAddress(w_OutputMatrixAddress),
 
 .operation(w_operation)  ,
 
 .c_INIT_AXI_TXN(m00_axi_init_axi_txn),
 .c_systolic_array_start(w_systolic_array_start),
 .read_done(read_done),
 .systolic_array_done(systolic_done),
 .write_done(write_done)
 
 
    );
   
    
    
    
	// User logic ends
systolic #(.M_ROW(M_ROW),.M_COL(M_COL)) sys( .s_axi_wdata(axi_wdata),
 .M_AXI_ACLK(m00_axi_aclk),
    .M_AXI_ARESETN(m00_axi_aresetn),
   . init_txn_pulse(m00_axi_init_axi_txn),
    . M_AXI_WREADY(m00_axi_wready),
    . axi_wvalid(m00_axi_wvalid),
    . write_index(write_index),
    
    .wt_data(wt_data),
    .in_data(in_data)

  );
	
	
	
	
	endmodule
