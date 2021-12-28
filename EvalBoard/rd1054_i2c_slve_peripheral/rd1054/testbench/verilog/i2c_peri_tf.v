//   ==================================================================
//   >>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
//   ------------------------------------------------------------------
//   Copyright (c) 2013 by Lattice Semiconductor Corporation
//   ALL RIGHTS RESERVED 
//   ------------------------------------------------------------------
//
//   Permission:
//
//      Lattice SG Pte. Ltd. grants permission to use this code
//      pursuant to the terms of the Lattice Reference Design License Agreement. 
//
//
//   Disclaimer:
//
//      This VHDL or Verilog source code is intended as a design reference
//      which illustrates how these types of functions can be implemented.
//      It is the user's responsibility to verify their design for
//      consistency and functionality through the use of formal
//      verification methods.  Lattice provides no warranty
//      regarding the use or functionality of this code.
//
//   --------------------------------------------------------------------
//
//                  Lattice SG Pte. Ltd.
//                  101 Thomson Road, United Square #07-02 
//                  Singapore 307591
//
//
//                  TEL: 1-800-Lattice (USA and Canada)
//                       +65-6631-2000 (Singapore)
//                       +1-503-268-8001 (other locations)
//
//                  web: http://www.latticesemi.com/
//                  email: techsupport@latticesemi.com
//
//   --------------------------------------------------------------------
//
// Name:  i2c_per_tb.v   
// 
// Description: This is the top-level test bench for the i2c peripheral 
//-------------------------------------------------------------------------
// Code Revision History :
//-------------------------------------------------------------------------
// Ver: | Author	|Mod. Date	|Changes Made:
// V1.0 | cm            |2005           |Initial ver
// V1.1 | cm            |6/2009         |update header 
//                                      |add logic to display received byte  
//	                                    |emulate slave is not ready     
// V1.2 | cm            |7/2010         |update the license date                              
//-------------------------------------------------------------------------

`timescale 1 ns /  100 ps
`include "i2c_mstr.v"


module i2c_peri_tb;

parameter    data_width = 8;
parameter    addr_width = 16;

//---------------------------------------------------------------------
// interconnect wires


//tri1 sda;
//tri1 scl;

wire sda;
wire scl;

wire   rst;
wire   start;

reg [1:0] error;

reg ready;

reg [7:0] data_in;
wire [7:0] data_out;
wire  r_w, data_vld; 
wire sda_oe, scl_oe;

reg sclk;
reg [addr_width-1:0]  byte_cnt;
// address pointer for both read / write operations
reg [addr_width-1:0]  i2c_addr;		
integer i;
//--------------------------------------------------------------------
// initiate memory
reg [data_width-1:0] mem [addr_width-1:0]; // initiate memory
//reg [addr_width-1:0] mem_adr;

pullup p1(sda);
pullup p2(scl);
//---------------------------------------------------------------------
// instantiated modules

i2c_slave u1   								 
	(.XRESET  (rst), 
   .ready   (ready),
	 .start		(start),
	 .stop		(stop),
	 .data_in	(mem[i2c_addr]), 
	 .data_out      (data_out), 
	 .r_w		(r_w), 
	 .data_vld      (data_vld), 
	 .scl_in	(scl), 
         .scl_oe 	(scl_oe),
	 .sda_in	(sda), 
	 .sda_oe	(sda_oe)
	 ) ;

assign sda = sda_oe ? 1'b0 : 1'bz;
assign scl = scl_oe ? 1'b0 : 1'bz;

i2c_mstr MST(   .XRESET(rst), 
                .scl(scl), 
                .sda(sda),
				.ready(ready),
                .scl_oe(scl_oe),
				.error(error)
                );
		
initial begin
	#0 ready = 1'b1;
	   data_in = 8'h0;
	   sclk = 1'b0;
	   error = 2'b0;
	   $readmemh("../../../testbench/verilog/i2c.mem", mem); 
	//for (i = 15; i >= 0; i = i - 1) begin	  
//		$display("INITIIAL MEMORY CONTENTS AT LOCATION %h : %h",i,mem[i]);
//	end
	   //$readmemh("i2c.mem", mem);
	#2800 ready = 1'b0;
	#3000 ready = 1'b1;	
	#12600;
	//for (i = 15; i >= 0; i = i - 1) begin	  
//		$display("MEMORY CONTENT AT LOCATION %h : %h",i,mem[i]);
//	end
end	 

always 
	#15 sclk = ~sclk;   

// indicate an ACK is detected
   always @ (posedge scl or posedge rst)
      // every 9 clocks there will be a valid data / address
      begin
         if (rst) 
            byte_cnt <= #1 0;
         else
            if (byte_cnt == 4'hF)
               byte_cnt <= #1 byte_cnt;
            else if (data_vld)
               byte_cnt <=  #1 byte_cnt + 1;
            else if (start)
               byte_cnt <= #1 0;
      end

   always @ (posedge scl or posedge rst)
      begin
         if (rst) 
            i2c_addr <= #1 4'h0;
         else
            if ((byte_cnt == 1) & !r_w & data_vld)
               // load the address 
               i2c_addr <= #1 data_out; // put received data into memory
            else if (data_vld) 
               i2c_addr <= #1 i2c_addr + 1;	 
            else if (stop | start)
            	i2c_addr <= data_out;
      end	
always @(posedge MST.data_read or posedge MST.data_read_nostop)
	begin	
	//	if (!MST.data_read)	begin
		if(MST.data_read_nostop) begin
			if(MST.read_i2c_nostop.rd_reg==mem[i2c_addr]) 				
				$display($time,": Checking with memory contents...DATA MATCH");
			else
				begin
				$display($time,": Checking with memory contents...ERROR:DATA MISMATCH");
				error <= error + 1;
				end				
		end	  
		
		else if(MST.data_read) begin	
			if(MST.read_i2c_repeat.rd_reg==mem[i2c_addr])				 
				$display($time,": Checking with memory contents...DATA MATCH");
			else
				begin
				$display($time,": Checking with memory contents...ERROR:DATA MISMATCH"); 
				error <= error + 1;	
				end
		end	  
	//end	
	end	
			
	  
   always @ (posedge sclk)
    	if (!r_w & (byte_cnt > 1))
    	mem[i2c_addr] <= #1 data_out;	   		
                            
endmodule

//-------------------------------EOF------------------------------------------
