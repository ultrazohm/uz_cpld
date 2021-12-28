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


// 
//  Name:  i2c_mstr.v   
// 
//  Description: i2c master used to simulate the i2c slave module
// 		 random read/write, sequential read are simulated
// 
//-------------------------------------------------------------------------
// Code Revision History :
//-------------------------------------------------------------------------
// Ver: | Author	|Mod. Date	    |Changes Made:
// V1.0 | cm		  |2005           |Initial ver
// V1.1 | cm	    |6/2009         |update header 
//					                      |emulate master stops if slave is not ready
// V1.2 | cm	    |7/2010         |stop scl when no command
//-------------------------------------------------------------------------

`timescale 1 ns /  100 ps


module i2c_mstr(XRESET, 
                scl, 
                sda,
                ready,
                scl_oe,
				error
                );

   //---------------------------------------------------------------------
   // port list

   output          XRESET;
   input [1:0]	   error;	
   output          scl;
   inout           sda;
   input 	         ready;
   input 			     scl_oe;

   //---------------------------------------------------------------------
   // registers and wires

   reg             XRESET;                     // reset
   reg             scl_reg;                    // clock register
   reg             sda_reg;                    // SDA input stimulus
   reg             scl_enable; 			           // enable / disable the scl clock
   reg     		data_read; 
   reg data_read_nostop;
   	
   //---------------------------------------------------------------------
   // parameters          

   parameter       clk_cycle   = 50; 
   parameter       delay       = 10; 
   parameter       reset_delay = 100;
   parameter       cycle_end   = 50;

   parameter       dev_add   = 4'b1010;
   parameter       rd        = 1'b1;
   parameter       wr        = 1'b0;

   parameter       upper_addra = 3'h2, 
	                 upper_addrb = 3'h3, 
	                 upper_addrc = 3'h8,
	                 upper_addrd = 3'hA;
   
   
   parameter       rd_a_addr = {dev_add, upper_addra, rd};
   parameter       rd_b_addr = {dev_add, upper_addrb, rd};
   parameter       rd_c_addr = {dev_add, upper_addrc, rd};
   parameter       rd_d_addr = {dev_add, upper_addrd, rd};

   parameter       wr_a_addr = {dev_add, upper_addra, wr};
   parameter       wr_b_addr = {dev_add, upper_addrb, wr};
   parameter       wr_c_addr = {dev_add, upper_addrc, wr};
   parameter       wr_d_addr = {dev_add, upper_addrd, wr};


   parameter       wr_a_addrl = 8'h06;
   parameter       wr_b_addrl = 8'h01;
   parameter       wr_c_addrl = 8'h0A;
   parameter       wr_d_addrl = 8'h0E;

   parameter       wr_a_data = 8'h11;
   parameter       wr_b_data = 8'h22;
   parameter       wr_c_data = 8'h33;
   parameter       wr_d_data = 8'h44; 
   parameter       wr_e_data = 8'h55; 
   parameter       wr_f_data = 8'h66; 
   parameter       wr_g_data = 8'h77; 
   parameter       wr_h_data = 8'h88; 


   //---------------------------------------------------------------------
   // assignments

   assign          sda   = (sda_reg) ? 1'bz : 1'b0;
   assign          scl   = (scl_reg) ? 1'bz : 1'b0;

   //---------------------------------------------------------------------
   // initial block

   initial begin
      
      $display($time,": Starting I2C Slave Simulation");
      $display();
      $display($time,": Initializing Test Bench");
      $display();
      init_chip;
      #50;
      // for lattice i2c slave
     
      // burst read (sequential read)
      $display($time,": Reading I2C Register");		// use current address pointer, no stop until the last read
      start_proc;						
      read_i2c_nostop(rd_a_addr);
      read_i2c_ack;
      read_i2c_repeat;
      read_i2c_ack;
      read_i2c_repeat;
      stop_proc;
    
      // burst write (sequential write)
      $display($time,": Writing I2C Register starting at %h", wr_a_addrl);
      start_proc;
      write_i2c_nostop(wr_a_addr,wr_a_addrl);		 // write address
      $display($time,": Wait for slave to release scl");
      scl_ready;
      write_i2c(wr_a_data);
      write_i2c_repeat(wr_b_data);
      write_i2c_repeat(wr_c_data);
      write_i2c_repeat(wr_d_data);
      stop_proc;
    
      
      //random read (change direction)
      $display($time,": Writing I2C Register to read from %h", wr_b_addrl);
      start_proc;
      write_i2c_nostop(wr_a_addr,wr_b_addrl);			// write address
      $display();
      $display($time,": Reading I2C Register starting at %h", wr_b_addrl);		
      wr_i2c_ack;
      #(clk_cycle);
      start_proc;						                      // read back with Repeat Start
      read_i2c_nostop(rd_a_addr);
      read_i2c_ack;
      read_i2c_repeat;
      stop_proc;
      start_proc;
      $display($time,": Writing I2C Register to read from %h", wr_c_addrl);
      write_i2c_nostop(wr_a_addr,wr_c_addrl);			// write address
      $display();
      $display($time,": Reading I2C Register starting at %h", wr_c_addrl);		
      wr_i2c_ack;
      #(clk_cycle);
      start_proc;						                      // read back with Repeat Start
      read_i2c_nostop(rd_a_addr);
      read_i2c_ack;
      read_i2c_repeat;
      stop_proc;
     
      $display();
  
      
      //random write
      $display($time,": Writing I2C Register at %h", wr_c_addrl);
      start_proc;						
      write_i2c_nostop(wr_a_addr,wr_c_addrl);
      write_i2c_repeat(wr_e_data);
      stop_proc;
      $display();
      $display($time,": Writing I2C Register at %h", wr_d_addrl);
      start_proc;						
      write_i2c_nostop(wr_a_addr,wr_d_addrl);
      write_i2c_repeat(wr_f_data); 
      stop_proc;
      $display();
      $display($time,": Writing I2C Register at %h", wr_c_addrl);
      start_proc;						
      write_i2c_nostop(wr_a_addr,wr_c_addrl);
      write_i2c_repeat(wr_g_data); 
      stop_proc;
      $display();
      $display($time,": Writing I2C Register at %h", wr_d_addrl);
      start_proc;						
      write_i2c_nostop(wr_a_addr,wr_d_addrl);
      write_i2c_repeat(wr_h_data); 
      stop_proc;
      $display();
      
         
      $display($time,": I2C Simulation Complete");
      # delay
	  
	  $display($time,": Number of Errors = %d",error);
         $stop;
   end  


   //---------------------------------------------------------------------
   // clock generation
   always #(clk_cycle/2) scl_reg = scl_enable ? ~scl_reg : (ready ? 1'b1 : 1'b0) ;

   //---------------------------------------------------------------------
   // Reset the chip

   task init_chip;                
      begin
         XRESET    <= #1 1'b1;
         sda_reg   <= #1 1'b1;
         scl_reg   <= #1 1'b1;
         scl_enable <= #1 1'b0;	
		 data_read=1'b0;
		 data_read_nostop=1'b0;
         #reset_delay;
         XRESET    <= #1 1'b0;
      end

   endtask

   //---------------------------------------------------------------------
   // start process
   task start_proc;
      begin
         #(clk_cycle/4);                         // middle of clock
         sda_reg    <= #1 1'b0;	                 // start 
         scl_enable <= #1 1'b1;                  // start scl clock
      end
   endtask    

   //--------------------------------------------------------------------
   // stop process
   task stop_proc;                	
      begin         
         @(negedge scl_reg);                     // nack           
         @(negedge scl_reg);                     // stop
         #(clk_cycle/4);                         // middle of clock
         sda_reg <= #1 1'b0;
         @(posedge scl_reg);                     // stop
         #(clk_cycle/4);                         // middle of clock
         sda_reg <= #1 1'b1;
         scl_enable <= #1 1'b0;                  // stop the scl clock
         #(cycle_end);                            
      end			
   endtask
   
   //--------------------------------------------------------------------
   task scl_ready;
      begin
        @(posedge scl_oe);
      	scl_enable <= 1'b0;   	
        @(negedge scl_oe);
      end
   endtask  
      
   //--------------------------------------------------------------------
   task read_i2c_ack;
      begin
         @(negedge scl_reg);                     // ack      
         #(clk_cycle/4);  
         sda_reg <= 1'b0;                        // tri-state    
         @(posedge scl_reg);                     // ack   
         @(negedge scl_reg);   
         #(clk_cycle/4);
         sda_reg <= 1'b1;
      end
   endtask      

   //--------------------------------------------------------------------
   task read_i2c_nack;
      begin
         @(negedge scl_reg);                     // ack       
         sda_reg <= #1 1'b1;                     // tri-state    
         @(posedge scl_reg);                     // ack   
      end
   endtask    

   // -------------------------------------------------------------------
   task wr_i2c_ack;
      begin
         @(negedge scl_reg);                     // ack 
         #(clk_cycle/4); 
         sda_reg <= #1 1'b1;                     // tri-state
         @(posedge scl_reg);                     // ack        
      end 
   endtask    

   //--------------------------------------------------------------------
   // i2c read tasks
   
   task read_i2c_nostop;

      input   [7:0]   address;
      reg     [7:0]   rd_reg;
      integer         i;

      begin
         data_read_nostop=1'b0;
         for (i = 7; i >= 0; i = i - 1) begin     // address
            @(negedge scl_reg);
            #(clk_cycle/4);                       // middle of clock
            sda_reg <= #1 address[i];
         end                               
         
         sda_reg <= #1 1'b1;                      // tri-state        
         @(negedge scl_reg);                      // ack           
         @(posedge scl_reg);                      // ack           
         
         for (i = 7; i >= 0; i = i - 1) begin     // data
    	    @(posedge scl_reg);
            rd_reg[i] <= #1 sda;
         end                               
         
         #2 $display($time,": Data Read = %h",rd_reg); 
		data_read_nostop=1'b1;
      end 
      
   endtask  


   task read_i2c_repeat;
      reg     [7:0]   rd_reg;
      integer         i;

      begin
		  data_read=1'b0;  
		  data_read_nostop=1'b0;
         sda_reg<= #1 1'b1; 
         for (i = 7; i >= 0; i = i - 1) begin     // data
            @(posedge scl_reg);
            rd_reg[i] <= #1 sda;
         end                               
         
         #2 $display($time,": Data Read = %h",rd_reg);
		 data_read=1'b1;
      end 
      
   endtask    


   //---------------------------------------------------------------------
   // i2c write tasks
   
   task write_i2c;                    
    input   [7:0]   data;
    integer         j;   
    begin
     data_read=1'b0;
	 data_read_nostop=1'b0;
    #(clk_cycle/4);
    sda_reg <= #1 data[7];
    #(clk_cycle/4);
    scl_enable <= 1'b1;
    for (j = 6; j >= 0; j = j - 1) begin     // data
    @(negedge scl_reg)
    #(clk_cycle/4);                          // middle of clock
    sda_reg <= #1 data[j];
    end 
    
    #2 $display($time,": Data Write = %h",data);	
    end    
   endtask                           

   task write_i2c_nostop;                     
      input   [7:0]   address;
      input   [7:0]   data;
      integer         i,j;

      begin
		  data_read=1'b0; 
		  data_read_nostop=1'b0;
         for (i = 7; i >= 0; i = i - 1) begin    // address
            @(negedge scl_reg);
            #(clk_cycle/4);                      // middle of clock
            sda_reg <= #1 address[i];
         end                               

         @(negedge scl_reg);                     // ack       
         #(clk_cycle/4)                          // added to avoid timing simulation glitch
         
         sda_reg <= #1 1'b1;                     // tri-state
         @(posedge scl_reg);                     // ack           
         
         for (j = 7; j >= 0; j = j - 1) begin    // data
            @(negedge scl_reg)
              #(clk_cycle/8);                     // middle of clock
            sda_reg <= #1 data[j];
         end  
      end 		
   endtask

   task write_i2c_repeat;                
      input   [7:0]   data;
      integer         i,j;

      begin	
		  data_read=1'b0; 
		  data_read_nostop=1'b0;
         @(negedge scl_reg);                      // ack   
         #(clk_cycle/4);     
         sda_reg <= #1 1'b1;                      // tri-state
         @(posedge scl_reg);                      // ack          
         
         for (j = 7; j >= 0; j = j - 1) begin     // data
            @(negedge scl_reg)
             #(clk_cycle/8);
            sda_reg <= #1 data[j];
         end   
	    #2 $display($time,": Data Write = %h",data);	                                     
      end 		
   endtask


endmodule





