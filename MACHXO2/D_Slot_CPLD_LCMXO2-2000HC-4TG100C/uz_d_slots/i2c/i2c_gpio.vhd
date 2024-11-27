--   ==================================================================
--   >>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
--   ------------------------------------------------------------------
--   Copyright (c) 2013 by Lattice Semiconductor Corporation
--   ALL RIGHTS RESERVED 
--   ------------------------------------------------------------------
--
--   Permission:
--
--      Lattice SG Pte. Ltd. grants permission to use this code
--      pursuant to the terms of the Lattice Reference Design License Agreement. 
--
--
--   Disclaimer:
--
--      This VHDL or Verilog source code is intended as a design reference
--      which illustrates how these types of functions can be implemented.
--      It is the user's responsibility to verify their design for
--      consistency and functionality through the use of formal
--      verification methods.  Lattice provides no warranty
--      regarding the use or functionality of this code.
--
--   --------------------------------------------------------------------
--
--                  Lattice SG Pte. Ltd.
--                  101 Thomson Road, United Square #07-02 
--                  Singapore 307591
--
--
--                  TEL: 1-800-Lattice (USA and Canada)
--                       +65-6631-2000 (Singapore)
--                       +1-503-268-8001 (other locations)
--
--                  web: http://www.latticesemi.com/
--                  email: techsupport@latticesemi.com
--
--   --------------------------------------------------------------------
--
-- --------------------------------------------------------------------
-- Code Revision History : 
-- --------------------------------------------------------------------
-- Ver: | Author      |Mod. Date  |Changes Made:
-- V1.0 |             |           |Initial Version
-- V2.0 | SHossner    |19-Sep-13  |Disabled clock stretching support per PCN#10A-13
-- --------------------------------------------------------------------

library ieee;
library machxo2;
use machxo2.all;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all ;
use ieee.std_logic_unsigned.all; 

--library work
--use work.my_pkg.all;
--library work;
--use work.efb_define_pkg.all;	   

entity i2c_gpio is

  generic (
             GPI_PORT_NUM       : integer    := 1;       -- GPI port number
			 GPI_DATA_WIDTH     : integer    := 8;       -- GPI data width
			 GPO_PORT_NUM       : integer    := 1;       -- GPO port number
			 GPO_DATA_WIDTH     : integer    := 2;       -- GPO data width
			 MEM_ADDR_WIDTH     : integer    := 8;       -- Memory addrss width
			 IRQ_NUM            : integer    := 4;       -- Interrupt request number
			 MAX_MEM_BURST_NUM  : std_logic_vector (7 downto 0)    := "00001000";       -- Maximum memory burst number
		     INTQ_OPENDRAIN     : bit        := '1'      -- INTQ opendrain setting (S_ON/S_OFF)
		   );

port(

SCL      : inout std_logic;
SDA      : inout std_logic;
GPO_0    : out std_logic_vector(GPO_DATA_WIDTH-1 downto 0);
IRQ      : in std_logic_vector (IRQ_NUM-1 downto 0);      
GPI_0    : in std_logic_vector (GPI_DATA_WIDTH-1 downto 0);
Enable   : out std_logic;
INTQ     : out std_logic:='1';
RST_N    : in std_logic;
MEM_CLK  : out std_logic;
MEM_WR   : out std_logic;
MEM_ADDR : out std_logic_vector(MEM_ADDR_WIDTH-1 downto 0);        
MEM_WD   : out std_logic_vector(7 downto 0);
MEM_RD   : in std_logic_vector(7 downto 0)
);
end entity;

architecture i2c_vhdl of i2c_gpio is

signal clk	:	STD_LOGIC;
 -- EFB REGISTER SET
 --constant INTQ_OPENDRAIN    : std_logic := '0';                                                       
 constant MICO_EFB_I2C_CR     : std_logic_vector(7 downto 0) := "01000000"; --4a
 constant MICO_EFB_I2C_CMDR   : std_logic_vector(7 downto 0) := "01000001";--4b
 constant MICO_EFB_I2C_BLOR	  : std_logic_vector(7 downto 0) := "01000010";--4c
 constant MICO_EFB_I2C_BHIR	  : std_logic_vector(7 downto 0) := "01000011"; --4d
 constant MICO_EFB_I2C_TXDR	  : std_logic_vector(7 downto 0) := "01000100"; --4e
 constant MICO_EFB_I2C_SR	  : std_logic_vector(7 downto 0) := "01000101"; --4f
 constant MICO_EFB_I2C_GCDR	  : std_logic_vector(7 downto 0) := "01000110";--50
 constant MICO_EFB_I2C_RXDR	  : std_logic_vector(7 downto 0) := "01000111"; --51
 constant MICO_EFB_I2C_IRQSR  : std_logic_vector(7 downto 0) := "01001000"; --52
 constant MICO_EFB_I2C_IRQENR : std_logic_vector(7 downto 0) := "01001001"; --53

--EFB I2C CONTROLLER PHYSICAL DEVICE SPECIFIC INFORMATION

-- Control Register Bit Masks

 constant MICO_EFB_I2C_CR_I2CEN  : std_logic_vector(7 downto 0) := "10000000";	 
 constant MICO_EFB_I2C_CR_GCEN   : std_logic_vector(7 downto 0) := "01000000"; 
 constant MICO_EFB_I2C_CR_WKUPEN : std_logic_vector(7 downto 0) := "00100000";

-- Status Register Bit Masks

 constant MICO_EFB_I2C_SR_TIP	 : std_logic_vector(7 downto 0) := "10000000"; 
 constant MICO_EFB_I2C_SR_BUSY   : std_logic_vector(7 downto 0) := "01000000"; 
 constant MICO_EFB_I2C_SR_RARC   : std_logic_vector(7 downto 0) := "00100000"; 
 constant MICO_EFB_I2C_SR_SRW	 : std_logic_vector(7 downto 0) := "00010000"; 
 constant MICO_EFB_I2C_SR_ARBL	 : std_logic_vector(7 downto 0) := "00001000";		 
 constant MICO_EFB_I2C_SR_TRRDY	 : std_logic_vector(7 downto 0) := "00000100"; 
 constant MICO_EFB_I2C_SR_TROE	 : std_logic_vector(7 downto 0) := "00000010";	 
 constant MICO_EFB_I2C_SR_HGC	 : std_logic_vector(7 downto 0) := "00000001";	 

-- Command Register Bit Masks 

 constant MICO_EFB_I2C_CMDR_STA     : std_logic_vector(7 downto 0) := "10000000"; 
 constant MICO_EFB_I2C_CMDR_STO	    : std_logic_vector(7 downto 0) := "01000000"; 
 constant MICO_EFB_I2C_CMDR_RD	    : std_logic_vector(7 downto 0) := "00100000"; 
 constant MICO_EFB_I2C_CMDR_WR	    : std_logic_vector(7 downto 0) := "00010000"; 
 constant MICO_EFB_I2C_CMDR_NACK	: std_logic_vector(7 downto 0) := "00001000"; 
 constant MICO_EFB_I2C_CMDR_CKSDIS  : std_logic_vector(7 downto 0) := "00000100"; 


--CODE SPECIFIC

  constant ALL_ZERO    : std_logic_vector(7 downto 0) := "00000000";   
  constant READ        : std_logic := '0';  
  constant HIGH        : std_logic := '1';  
  constant WRITE       : std_logic := '1';  
  constant LOW         : std_logic := '0';   
  constant READ_STATUS : std_logic := '0';   
  constant READ_DATA   : std_logic := '0';  

-- State Machine Variable

 constant	state0	: std_logic_vector:= "00000000";
 constant	state1	: std_logic_vector:= "00000001";
 constant	state2	: std_logic_vector:= "00000010";
 constant	state3	: std_logic_vector:= "00000011";
 constant	state4	: std_logic_vector:= "00000100";
 constant	state5	: std_logic_vector:= "00000101";
 constant	state6	: std_logic_vector:= "00000110";
 constant	state7	: std_logic_vector:= "00000111";
 constant	state8	: std_logic_vector:= "00001000";
 constant	state9	: std_logic_vector:= "00001001";
 constant	state10	: std_logic_vector:= "00001010";
 constant	state11	: std_logic_vector:= "00001011";
 constant	state12	: std_logic_vector:= "00001100";
 constant	state13	: std_logic_vector:= "00001101";
 constant	state14	: std_logic_vector:= "00001110";
 constant	state15	: std_logic_vector:= "00001111";
 constant	state16	: std_logic_vector:= "00010000";
 constant	state17	: std_logic_vector:= "00010001";
 constant	state18	: std_logic_vector:= "00010010";
 constant	state19	: std_logic_vector:= "00010011";
 constant	state20	: std_logic_vector:= "00010100";

	  
 --/***********************************************************************
 --*                                                                     *
 --* WISHBONE INTERFACE SIGNAL                                           *
 --*                                                                     *
 --***********************************************************************/

signal wb_dat_i : std_logic_vector(7 downto 0) ;
signal wb_stb_i : std_logic ;
signal wb_cyc_i : std_logic  ;
signal wb_adr_i : std_logic_vector(7 downto 0) ;
signal wb_we_i  : std_logic ;
signal wb_dat_o : std_logic_vector(7 downto 0) ;
signal wb_ack_o : std_logic ;



--/***********************************************************************
 --*                                                                     *
 --* Data Read and Write Register                                        *
 --*                                                                     *
 --***********************************************************************/
 
signal mem_wr1 : std_logic;
signal data0 : std_logic_vector(7 downto 0) ;
signal temp0,temp1,temp2,temp3 : std_logic_vector(7 downto 0) ;                                
signal n_temp0,n_temp1,n_temp2,n_temp3 : std_logic_vector(7 downto 0) ;                        
signal irq_en , irq_status  ,irq_clr, irq_status_clr  : std_logic_vector(IRQ_NUM-1 downto 0) ; 

-- Some more signals

signal reg_rdy  , reg_rdy_del : std_logic ;
signal dat_rdy  , dat_rdy_del : std_logic ;
signal efb_flag , n_efb_flag : std_logic ;
signal n_dat_count , dat_count : std_logic_vector(7 downto 0) ; 
signal GPI_DAT : std_logic_vector(7 downto 0) ;                                                 

signal i2c_cmd  : std_logic_vector(7 downto 0) ;
signal i2c1_irqo: std_logic := 'Z';
signal reg_addr  : std_logic_vector(7 downto 0) ;

signal memory_addr : std_logic_vector (MEM_ADDR_WIDTH-1 downto 0);        


signal cmd_rdy: std_logic ;

signal n_wb_dat_i : std_logic_vector(7 downto 0) ;
signal n_wb_stb_i : std_logic ;
signal n_wb_adr_i : std_logic_vector(7 downto 0) ;
signal n_wb_we_i , check_irq_status,GPIO_Write, GPIO_Read, Memory_Write, Memory_Write_or_Read, IRQ_Enable_Write,IRQ_Clear: std_logic ;

signal c_state ,n_state : std_logic_vector(7 downto 0) ;
signal rst_p,n_count_en , count_en, enable_command,intr_command,intr_read_command,gpio_command ,mem_command , cmd_data: std_logic ;



--/***********************************************************************
--* 2-D array for GPIO data                                             *
--***********************************************************************/
	subtype GPO_WIDTH is std_logic_vector(GPO_DATA_WIDTH-1 downto 0);
 	type GPO_ARRAY is array(GPO_PORT_NUM-1 downto 0) of GPO_WIDTH;

	subtype GPI_WIDTH is std_logic_vector(GPI_DATA_WIDTH-1 downto 0);	
	type GPI_ARRAY is array(GPI_PORT_NUM-1 downto 0) of GPI_WIDTH;
	
	signal GPO_DATA : GPO_ARRAY;
	signal GPI_DATA : GPI_ARRAY;


--********************************************************************************

	-- internen oszillator definieren
	COMPONENT OSCH
	-- synthesis translate_off
	GENERIC (NOM_FREQ: string := "7");
	-- synthesis translate_on
	PORT (
		STDBY	:	IN	std_logic;
		OSC		:	OUT	std_logic;
		SEDSTDBY:	OUT	std_logic);
	END COMPONENT;
	attribute NOM_FREQ 	: string;
	attribute NOM_FREQ of OSCinst0 : label is "7";

--EFB component declaration

--********************************************************************************

component efb_VHDL
    port (wb_clk_i: in  std_logic; wb_rst_i: in  std_logic; 
        wb_cyc_i: in  std_logic; wb_stb_i: in  std_logic; 
        wb_we_i: in  std_logic; 
        wb_adr_i: in  std_logic_vector(7 downto 0); 
        wb_dat_i: in  std_logic_vector(7 downto 0); 
        wb_dat_o: out  std_logic_vector(7 downto 0); 
        wb_ack_o: out  std_logic; i2c1_scl: inout  std_logic; 
        i2c1_sda: inout  std_logic; i2c1_irqo: out  std_logic);
end component;


begin


	OSCInst0: OSCH
	-- synthesis translate_off
	GENERIC MAP( NOM_FREQ => "2.08" )
	-- synthesis translate_on
	PORT MAP (STDBY=> '0',
	OSC => clk,
	SEDSTDBY => open
	);
	
dut : efb_VHDL 
port map (

wb_clk_i => CLK,
wb_rst_i =>rst_p,
wb_dat_i =>wb_dat_i,
wb_stb_i =>wb_stb_i,
wb_cyc_i =>wb_cyc_i,
wb_adr_i =>wb_adr_i,
wb_we_i  =>wb_we_i ,
wb_dat_o =>wb_dat_o, 
wb_ack_o =>wb_ack_o,      
i2c1_scl =>SCL,
i2c1_sda =>SDA,
i2c1_irqo =>i2c1_irqo 
);

rst_p <= not (RST_N);

wb_cyc_i<=  wb_stb_i;



--i2c data and command storing

process (CLK,RST_N) is
begin
if (CLK'event and CLK='1') then
   
   if( RST_N='0') then
       reg_rdy     <= '0' ;
	   reg_rdy_del <= '0' ;
	

    elsif ((c_state = state11) and (wb_ack_o = '1') and (efb_flag = '1')) then   
       reg_rdy  <= '1' ;
	  else
	reg_rdy <= '0';
	end if;
	reg_rdy_del  <= reg_rdy ;
	end if;
	end process;

  process(CLK,RST_N) is
    begin
      if (CLK'event and CLK='1') then
   
         if( RST_N='0') then
            dat_rdy     <= '0' ;
	        dat_rdy_del <= '0' ;
 
	     elsif ((c_state = state14) and (wb_ack_o = '1') and (efb_flag = '1')) then   
            dat_rdy      <= '1' ;
	        dat_rdy_del  <= dat_rdy ;
	     else 
	        dat_rdy <= '0';
	        dat_rdy_del  <= dat_rdy ;
	     end if;   
	  end if;
    end process;	   
   
 cmd_rdy  <= '1' when  (n_state = state9 ) else '0' ;   
 i2c_cmd  <= temp1 ;
 reg_addr <= temp2 ;	
   
   process(CLK,RST_N) is
    begin
      if (CLK'event and CLK='1') then
        if( RST_N='0') then
        data0 <= (others=>'0');
   -- Add your logic here for data[0-7] registers
        else  
		   case i2c_cmd is
		     when "00000101" => data0 <= GPI_DAT;               -- Read GPIO Input 
		     when "00001011" => data0 <= "10001000" ;               -- Read Mem Data 
		     when "01100101" => data0 <= "0000" & irq_status ;  -- Read IRQ Status  
		     when "01101010" => data0 <= "0000" & irq_en;       -- Read IRQ Enable Status 
		     when others     => data0 <= data0;
		   end case;
	    end if;   
      end if;  
    end process;

process(CLK,RST_N) is
begin
if (CLK'event and CLK='1') then
   
   if( RST_N='0') then
       
        temp0 <= (others=>'0') ;
        temp1 <= (others=>'0') ;
        temp2 <= (others=>'0') ;
		temp3 <= (others=>'0') ;
      
    else  
        temp0 <= n_temp0 ;
        temp1 <= n_temp1 ;
        temp2 <= n_temp2 ;
	    temp3 <= n_temp3 ;	 
    end if;
   end if;  
   end process;
   
--//////////////////////////////////////////////
--//                                          //
--//    GPIO Interface Block                  //
--//                                          //
--//////////////////////////////////////////////   
  
  GPIO_Write <= '1' when (i2c_cmd = "00000001") else '0';
   
--process(CLK,RST_N) is
--begin
--if (CLK'event and CLK='1') then
   
--   if( RST_N='0') then
--         GPO_0 <= (others=>'0');
--		 GPO_1 <= (others=>'0');
--		 GPO_2 <= (others=>'0');
--		 GPO_3 <= (others=>'0');		 
--      elsif ((dat_rdy_del and c)='1') then 
--       case reg_addr is
--          when "00000000" =>
--		  GPO_0 <= temp3;
--		  when "00000001" =>
--		  GPO_1 <= temp3;
--		  when "00000010" =>
--		  GPO_2 <= temp3;
--		  when "00000011" =>
--		  GPO_3 <= temp3; 
--		  when others=>
--		  NULL;
--	   end case;	  
--	end if;
-- end if;	
--end process;




    process(CLK,RST_N) is
     begin
       if (CLK'event and CLK='1') then
          if( RST_N = '0') then
		    for J in 0 to GPO_PORT_NUM-1 loop
			  GPO_DATA (J) <= (others=>'0');
			end loop;
          elsif ((dat_rdy_del and GPIO_Write)='1') then
			  GPO_DATA(to_integer(unsigned(reg_addr))) <= temp3(GPO_DATA_WIDTH-1 downto 0);              		  
	      end if;
       end if;	
     end process;
	 
   GPO_0 <= GPO_DATA(0);
 

  GPIO_Read <= '1' when (i2c_cmd = "00000101") else '0';

--process(CLK,RST_N) is
--begin
--if (CLK'event and CLK='1') then
   
--   if( RST_N='0') then

--         GPI_DAT <= (others=>'0');
--      elsif ((reg_rdy and d)='1') then 
--       case reg_addr is
--         when "00000000" =>
--		  GPI_DAT <= GPI_0;
--		  when "00000001" =>
--		  GPI_DAT <= GPI_1;
--		  when "00000010" =>
--		  GPI_DAT <= GPI_2;
--		  when "00000011" =>
--		  GPI_DAT <= GPI_3;
--		  when others=>
--		  NULL;
--	   end case;	  
--	end if;
 --end if;
--end process; 


    process(CLK,RST_N) is
     begin
       if (CLK'event and CLK='1') then
          if( RST_N = '0') then
			  GPI_DAT <= (others=>'0');
          elsif ((reg_rdy and GPIO_Read)='1') then
			  GPI_DAT <= GPI_DATA(to_integer(unsigned(reg_addr)));              		  
	      end if;
       end if;	
     end process;
	 
   GPI_DATA(0) <= GPI_0;


--/////////////////////////////////////////////
--//                                          //
--//    Memory Interface BLock                //
--//                                          //
--//////////////////////////////////////////////   

Memory_Write <='1' when (i2c_cmd = "00000010") else '0'; 
MEM_CLK  <= CLK ; 
process(CLK,RST_N) is
begin

 
if (CLK'event and CLK='1') then
   
   if( RST_N='0') then
         MEM_WD  <= (others=>'0');
		 mem_wr1  <= '0' ;
      
	elsif ((dat_rdy_del and Memory_Write)='1') then 
		 MEM_WD  <= temp3 after 1 ns;
		 mem_wr1  <= '1' after 1 ns;
       
	else 
        mem_wr1 <= '0' after 1 ns ;	
   end if;
end if;
end process;

process(CLK,RST_N) is
begin
if(CLK'event and CLK='1')then

if(RST_N='0')then
MEM_WR <= '0';
else
MEM_WR <= mem_wr1;
end if;
end if;
end process;





Memory_Write_or_Read <= '1' when ((i2c_cmd = "00000010") or (i2c_cmd = "00001011")) else '0';

process(CLK , RST_N) is
begin
if (CLK'event and CLK='1') then
   
   if( RST_N='0') then
         memory_addr <= (others=>'0');
      
	elsif ((reg_rdy and Memory_Write_or_Read)='1')then  
		 memory_addr <=  temp2 after 1 ns;

	elsif (   ((c_state = state15) and (wb_ack_o = '1') and (efb_flag = '1')) 
	       or ((c_state = state19) and (n_state = state14) and (mem_command = '1'))) then  
         memory_addr <=  memory_addr + '1' after 1 ns ; 	
       
   end if;
end if;
end process;
MEM_ADDR <= memory_addr;    

process(CLK , RST_N) is
begin
if (CLK'event and CLK='1') then
   
   if( RST_N='0') then 
         Enable <= '0' ;      
	elsif (i2c_cmd = "00000110")then
		 Enable <= '1' ;
	elsif (i2c_cmd = "00000100")then
		 Enable <= '0' ;
	--else
       --  Enable <= '0';
		 
	
   end if;
end if;
end process;

--/////////////////////////////////////////////
--//                                         //
--//        Interrupt Control Logic          //
--//                                         //
--/////////////////////////////////////////////   
--// intq is asserted low when any IRQ Status Register bit is set. 
--// And the INTQ_OPENDRAIN parameter defines INTQ's opendrain setting. 
  check_irq_status <= (irq_status(0)) or (irq_status(1)) or (irq_status(2)) or (irq_status(3)) ; 
  
   --a <= (irq(0)) or (irq(1)) or (irq(2)) or (irq(3));
   process(check_irq_status) is
   begin
      if(check_irq_status = '1')then
         INTQ<='0';
      else
        if (INTQ_OPENDRAIN='1')then
            INTQ <= 'Z';
        else
            INTQ <='1';
        end if;
	  end if;
   end process;

     
   -- When IRQ is enabled, a rising edge of an IRQ input will set the corresponding bit in the IRQ Status register.
   
 
 
   IRQ_STATUS_GENERATE:  for N in 0 to IRQ_NUM-1 generate
   begin
   
             process( IRQ(N), irq_status_clr(N), irq_clr(N), rst_p)
			 begin
			   irq_status_clr(N) <= ( irq_clr(N) or (rst_p) );
			   if   ( irq_status_clr(N) = '1' ) then
				      irq_status(N) <= '0';
			   elsif(IRQ(N)'event and IRQ(N) = '1') then
			      if ( irq_en(N) = '1') then
				       irq_status(N) <= '1';
				  end if;
               end if;
			 end process;
			 
   end generate IRQ_STATUS_GENERATE;
 
 --*********************************************************************************
   
   
--   process(IRQ,irq_status_clr,rst_p) is
   --variable i : integer:=0;
--begin   
--    for I in 0 to IRQ_NUM-1 loop                               
--   if ( irq_status_clr(I)='1'  ) then
--         irq_status(I) <= '0';
--          elsif (irq_en(I)='1') then
--               irq_status(I) <= '1';    
--          end if;
--		  irq_status_clr(I) <= irq_clr(I) or (rst_p);
--   end loop;
--end process;   


  IRQ_Enable_Write <= '1' when (i2c_cmd = "01100110") else '0';
  IRQ_Clear <= '1' when (i2c_cmd = "01100001") else '0';

process(CLK, RST_N) is
begin
if (CLK'event and CLK='1') then
   
   if( RST_N='0') then 
        irq_en  <= "0000";
		irq_clr <= "0000";
      
	elsif ((reg_rdy_del and IRQ_Enable_Write)= '1') then 
        irq_en  <= temp2(3 downto 0);
	elsif ((reg_rdy_del and IRQ_Clear)='1') then 
        irq_clr  <= temp2(3 downto 0);		
  end if;
  end if;
  end process;
 	

 
--process(CLK , RST_N) is
--begin
--if (CLK'event and CLK='1') then
  -- 
   --if( RST_N='0') then 
     --    irq_status  <= "0000";
    
	--elsif  (i2c_cmd = "01100101") then  -- Read IRQ 
      --   irq_status  <=  ((irq_en(3) and IRQ(3)) & (irq_en(2) & IRQ(2)) &(irq_en(1) and IRQ(1)) & (irq_en(0) and IRQ(0)));		  	   
	
	--elsif ((reg_rdy_del and (i2c_cmd = "01100001"))) then -- Clear IRQ
      --   irq  <= temp2(0 to 3);		 
	--end if;  		
 --end if;
--end process;


--/////////////////////////////////////////////
--//                                         //
--//        Command Decoding Logic           //
--//                                         //
--/////////////////////////////////////////////   
 
 enable_command    <= '1' when ((temp1 = "00000110") or (temp1 = "00000100")) else '0';
							
 intr_command      <= '1' when ((temp1 = "01100110") or (temp1 = "01100001")) else '0';
					 
 intr_read_command <= '1' when ((temp1 = "01100101") or (temp1 = "01101010")) else '0';
						 	
 gpio_command      <= '1' when ((temp1 = "00000001") or (temp1 = "00000101")) else '0';	

 mem_command       <= '1' when ((temp1 = "00000010") or (temp1 = "00001011")) else '0';						  

 cmd_data <=   (enable_command) or (intr_command) or (gpio_command) or (mem_command) or (intr_read_command );

--/***********************************************************************
 --*                                                                     *
 --*                    Main State Machine                               *
 --*                                                                     *
 --***********************************************************************/

 --/////////////////////////////////////////////
--//                                          //
--//    State Machines Sequential Block       //
--//                                          //
--//////////////////////////////////////////////   


process(CLK , RST_N) is
begin
if (CLK'event and CLK='1') then
   
   if( RST_N='0') then 
         wb_dat_i <= (others=>'0');
         wb_stb_i <= '0' ;
         wb_adr_i <= (others=>'0');
         wb_we_i  <= '0';   
         
    else 
      
         wb_dat_i <=  n_wb_dat_i after 1 ns;
         wb_stb_i <=  n_wb_stb_i after 1 ns;
         wb_adr_i <=  n_wb_adr_i after 1 ns;
         wb_we_i  <=  n_wb_we_i  after 1 ns;

       end if;
  end if;
  end process;

process(CLK , RST_N) is
begin
if (CLK'event and CLK='1') then
   
   if( RST_N='0') then 
      c_state  <= (others=>'0');
      efb_flag <= '0' ;
      count_en <= '0'; 
	  dat_count <= (others=>'0'); --"0000";   
      
    else   
      c_state  <= n_state   ;
      efb_flag <= n_efb_flag;
      count_en <= n_count_en;
	  dat_count <= n_dat_count ;
    end if; 
  end if;
  end process;

--//////////////////////////////////////////////
--//                                          //
--//    State Machines Combinational Block    //
--//                                          //
--//////////////////////////////////////////////   
  
 
m: process (intr_command, gpio_command, mem_command, wb_dat_o, n_state, c_state, temp0, temp1, temp2, temp3, enable_command, 
            efb_flag, wb_ack_o, i2c_cmd, data0, dat_count, cmd_data, intr_read_command) is  
  begin 
     n_efb_flag   <=  '0' ; 
     n_state      <= c_state ; 
	 n_dat_count  <= dat_count ;
     n_wb_dat_i  <= (others=>'0');
     n_wb_stb_i  <= '0' ;
     n_wb_adr_i  <= (others=>'0');
     n_wb_we_i   <= '0';
     n_count_en  <= '0'; 
     n_temp0     <= temp0;
     n_temp1     <= temp1;
     n_temp2     <= temp2;
     n_temp3     <= temp3;    
  
     case c_state is
     
	 when state0 => 
           n_wb_dat_i <=  (others=>'0');
           n_wb_stb_i <=  '0' ;
           n_wb_adr_i <=  (others=>'0');
           n_wb_we_i  <=  '0';           
           n_wb_stb_i <=  '0' ;     
           n_state <=  state1 ;             
     
       
    
  when state1 => -- Enable I2C Interface
      if ((wb_ack_o and efb_flag)='1') then
          n_wb_dat_i <= ALL_ZERO ;
          n_wb_adr_i <= ALL_ZERO ;
          n_wb_we_i <=  LOW ;
          n_wb_stb_i <= LOW ;
          n_efb_flag <= LOW ;
          n_count_en <= LOW ;
          n_state <= state2;
      
       elsif((wb_ack_o and efb_flag)='0') then
       n_efb_flag <= HIGH ;
       n_wb_we_i <=  WRITE;
       n_wb_adr_i <= MICO_EFB_I2C_CR;
       n_wb_dat_i <= "10000000";
       n_wb_stb_i <= HIGH ; 
       n_state <= c_state; 
    end if;
     
 
 
  when state2 => -- Clock Disable
      if ((wb_ack_o and efb_flag)='1') then
          n_wb_dat_i <= ALL_ZERO ;
          n_wb_adr_i <= ALL_ZERO ;
          n_wb_we_i <=  LOW ;
          n_wb_stb_i <= LOW ;
          n_efb_flag <= LOW ;
          n_count_en <= LOW ;
           n_state <= state3;
       
       else
       n_efb_flag <= HIGH ;
       n_wb_we_i <=  WRITE;
       n_wb_adr_i <= MICO_EFB_I2C_CMDR;
       n_wb_dat_i <= "00000100";
       n_wb_stb_i <= HIGH ; 
       n_state <= c_state; 
    end if;
     
 
 
  when state3 => -- Wait for not BUSY
      if ((wb_ack_o and efb_flag)='1') then
          n_wb_dat_i <= ALL_ZERO ;
          n_wb_adr_i <= ALL_ZERO ;
          n_wb_we_i <=  LOW ;
          n_wb_stb_i <= LOW ;
          n_efb_flag <= LOW ;
          n_count_en <= LOW ;
       if(((wb_dat_o) and  (MICO_EFB_I2C_SR_BUSY)) = "01000000") then
           n_state <= c_state;
       else
           n_state <= state4;
       end if;
	   
       else 
       n_efb_flag <= HIGH ;
       n_wb_we_i <=  READ_STATUS;
       n_wb_adr_i <= MICO_EFB_I2C_SR;
       n_wb_dat_i <=  (others=>'0');
       n_wb_stb_i <= HIGH ; 
       n_state <= c_state; 
    end if;
     
 
 
  when state4 => -- Discard data 1
      if ((wb_ack_o and efb_flag)='1') then
          n_wb_dat_i <=  ALL_ZERO ;
          n_wb_adr_i <=  ALL_ZERO ;
          n_wb_we_i <=   LOW ;
          n_wb_stb_i <=  LOW ;
          n_efb_flag <=  LOW ;
          n_count_en <=  LOW ;
        n_temp0 <= wb_dat_o; 
           n_state <=  state5;
       
       else 
       n_efb_flag <=  HIGH ;
       n_wb_we_i <=   READ_DATA;
       n_wb_adr_i <=  MICO_EFB_I2C_RXDR;
       n_wb_dat_i <=  (others=>'0') ;
       n_wb_stb_i <=  HIGH ; 
       n_state <= c_state; 
    end if;
     
 
 
   when state5 => -- Discard data 2
      if ((wb_ack_o and efb_flag)='1') then
          n_wb_dat_i <=  ALL_ZERO ;
          n_wb_adr_i <=  ALL_ZERO ;
          n_wb_we_i <=   LOW ;
          n_wb_stb_i <=  LOW ;
          n_efb_flag <=  LOW ;
          n_count_en <=  LOW ;
        n_temp0 <= wb_dat_o; 
           n_state <=  state7;  -- Bypass state6, keep clock stretching disabled per PCN#10A-13
       
       else 
       n_efb_flag <=  HIGH ;
       n_wb_we_i <=   READ_DATA;
       n_wb_adr_i <=  MICO_EFB_I2C_RXDR;
       n_wb_dat_i <=  (others=>'0') ;
       n_wb_stb_i <=  HIGH ; 
       n_state <= c_state; 
    end if;
     
 
 
--BYPASS THIS STATE.  Keep clock stretching disabled per PCN#10A-13 
--   when state6 => -- Clock Enable
--      if ((wb_ack_o and efb_flag)='1') then
--          n_wb_dat_i <=  ALL_ZERO ;
--          n_wb_adr_i <=  ALL_ZERO ;
--          n_wb_we_i <=   LOW ;
--          n_wb_stb_i <=  LOW ;
--          n_efb_flag <=  LOW ;
--          n_count_en <=  LOW ;
--           n_state <=  state7;
--       
--       else 
--       n_efb_flag <=  HIGH; 
--       n_wb_we_i <=   WRITE;
--       n_wb_adr_i <=  MICO_EFB_I2C_CMDR;
--       n_wb_dat_i <= (others=>'0');
--       n_wb_stb_i <=  HIGH ; 
--       n_state <= c_state; 
--    end if;
     
 
 
   when state7 => -- wait for data to come 
      if ((wb_ack_o and efb_flag)='1') then
          n_wb_dat_i <=  ALL_ZERO ;
          n_wb_adr_i <=  ALL_ZERO ;
          n_wb_we_i <=   LOW ;
          n_wb_stb_i <=  LOW ;
          n_efb_flag <=  LOW ;
          n_count_en <=  LOW ; 
		  n_temp1 <= (others=>'0'); 
       if(((wb_dat_o) and ( MICO_EFB_I2C_SR_TRRDY))="00000100") then
	         n_state <=  state8;		   
       else		   
           n_state <= c_state;
       end if;
       else 
       n_efb_flag <=  HIGH ;
       n_wb_we_i <=   READ_STATUS;
       n_wb_adr_i <=  MICO_EFB_I2C_SR;
       n_wb_dat_i <=  (others=>'0') ;
       n_wb_stb_i <=  HIGH ; 
       n_state <= c_state; 
    end if;
     
 
   -- state20: begin // Intermediate State to check for Stand Alone Read Operation
     -- if (wb_ack_o and efb_flag) begin
       --   n_wb_dat_i =  ALL_ZERO ;
         -- n_wb_adr_i =  ALL_ZERO ;
          --n_wb_we_i =   LOW ;
          --n_wb_stb_i =  LOW ;
          --n_efb_flag =  LOW ;
          --n_count_en =  LOW ; 		  
       --if(wb_dat_o & ( MICO_EFB_I2C_SR_TROE)) 
	     --    n_state =  state16;	// state17 	   
	   --elsif (~wb_dat_o[6])
         --  n_state =  state2;
       --else		   
         --  n_state =  state8;
       --end
       --else begin
       --n_efb_flag =  HIGH ;
       --n_wb_we_i =   READ_STATUS;
       --n_wb_adr_i =  MICO_EFB_I2C_SR;
       --n_wb_dat_i =  (others=>'0') ;
       --n_wb_stb_i =  HIGH ; 
       --n_state = c_state; 
    --end
    -- end
  
 --*/
   when state8 => --Store i2C Command Information
      if ((wb_ack_o and efb_flag)='1') then
          n_wb_dat_i <=  ALL_ZERO ;
          n_wb_adr_i <=  ALL_ZERO ;
          n_wb_we_i <=   LOW ;
          n_wb_stb_i <=  LOW ;
          n_efb_flag <=  LOW ;
          n_count_en <=  LOW ;
          n_temp1 <= wb_dat_o; 
          n_state <=  state9;
       
       else 
       n_efb_flag <=  HIGH ;
       n_wb_we_i <=   READ_DATA;
       n_wb_adr_i <=  MICO_EFB_I2C_RXDR;
       n_wb_dat_i <=  (others=>'0') ;
       n_wb_stb_i <=  HIGH ; 
       n_state <= c_state; 
    end if;
   
 
 
   when state9 => --Send ACK or NACK Based upon Command Receive & Wait for Stop  state 17
      if ((wb_ack_o and efb_flag)='1') then
          n_wb_dat_i <=  ALL_ZERO ;
          n_wb_adr_i <=  ALL_ZERO ;
          n_wb_we_i <=   LOW ;
          n_wb_stb_i <=  LOW ;
          n_efb_flag <=  LOW ;
          n_count_en <=  LOW ;
		  if(enable_command='1') then       --                                   // Enable command
		   n_state <=  state17;	
          elsif (intr_read_command ='1') then --                                  // Interrupt Read command
		   n_state <=  state12;
		  elsif (	(intr_command or gpio_command or mem_command) = '1') then --	   // other valid commands
           n_state <=  state10;
		  else       --                                                  // Error commands
           n_state <=  state17;		  
       end if;
       else 
       n_efb_flag <=  HIGH ;
       n_wb_we_i <=   WRITE;
       n_wb_adr_i <=  MICO_EFB_I2C_CMDR;
       n_wb_dat_i <= ("0000" & not(cmd_data) & "100");  -- Keep clock stretching disabled per PCN#10A-13 
       n_wb_stb_i <=  HIGH ; 
       n_state <= c_state; 
    end if;
     
 
 
   when state10 => -- Command Valid        
      if ((wb_ack_o and efb_flag)= '1') then
          n_wb_dat_i <=  ALL_ZERO ;
          n_wb_adr_i <=  ALL_ZERO ;
          n_wb_we_i <=   LOW ;
          n_wb_stb_i <=  LOW ;
          n_efb_flag <=  LOW ;
          n_count_en <=  LOW ;
	   if((wb_dat_o and   MICO_EFB_I2C_SR_TRRDY) = "00000100") then
           n_state <=  state11;
       elsif ( wb_dat_o(6)= '0') then
           n_state <=  state2;
       else
           n_state <= c_state;
       end if;
       
	   else 
       n_efb_flag <=  HIGH ;
       n_wb_we_i <=   READ_STATUS;
       n_wb_adr_i <=  MICO_EFB_I2C_SR;
       n_wb_dat_i <=  (others=>'0') ;
       n_wb_stb_i <=  HIGH ; 
       n_state <= c_state; 
    end if;
     
 
 
   when state11 => -- Store 2nd byte Information
      if ((wb_ack_o and efb_flag)='1') then
          n_wb_dat_i <=  ALL_ZERO ;
          n_wb_adr_i <=  ALL_ZERO ;
          n_wb_we_i <=   LOW ;
          n_wb_stb_i <=  LOW ;
          n_efb_flag <=  LOW ;
          n_count_en <=  LOW ;
          n_temp2 <= wb_dat_o; 
          if(intr_command = '1')then
		     n_state <=  state17;
		  else  
             n_dat_count <= MAX_MEM_BURST_NUM; --"1000" ; 	        
             n_state <=  state12;  -- For GPIO & Memory Command 
		  end if;	 
       
       else 
       n_efb_flag <=  HIGH ;
       n_wb_we_i <=   READ_DATA;
       n_wb_adr_i <=  MICO_EFB_I2C_RXDR;
       n_wb_dat_i <=  (others=>'0') ;
       n_wb_stb_i <=  HIGH ; 
       n_state <= c_state; 
    end if;
 
 

   when state12 => -- Wait for TRRDY Bit 
      if ((wb_ack_o and efb_flag)='1') then
          n_wb_dat_i <=  ALL_ZERO ;
          n_wb_adr_i <=  ALL_ZERO ;
          n_wb_we_i <=   LOW ;
          n_wb_stb_i <=  LOW ;
          n_efb_flag <=  LOW ;
          n_count_en <=  LOW ;
       if((wb_dat_o and MICO_EFB_I2C_SR_TRRDY)="00000100")then

		   if ((i2c_cmd = "00000101") or (i2c_cmd = "00001011") or (intr_read_command = '1'))  then  -- If Read Commands  
            n_state <=  state13;
		   else 
		    n_state <=   state14; -- For write Commands
			end if;
       elsif ( ( wb_dat_o(6))='0') then
           n_state <=  state2;
       else
           n_state <= c_state;
       end if;
       else 
       n_efb_flag <=  HIGH ;
       n_wb_we_i <=   READ_STATUS;
       n_wb_adr_i <=  MICO_EFB_I2C_SR;
       n_wb_dat_i <=  (others=>'0') ;
       n_wb_stb_i <=  HIGH ; 
       n_state <= c_state; 
    end if;
     
 
 
   when state13 => -- Check for read or write operation Go to State15
      if ((wb_ack_o and efb_flag)='1') then
          n_wb_dat_i <=  ALL_ZERO ;
          n_wb_adr_i <=  ALL_ZERO ;
          n_wb_we_i <=   LOW ;
          n_wb_stb_i <=  LOW ;
          n_efb_flag <=  LOW ;
          n_count_en <=  LOW ;
       if((wb_dat_o and MICO_EFB_I2C_SR_SRW)="00010000") then
           n_state <=  state15;
       elsif ( (wb_dat_o(6))='0') then
           n_state <=  state2;
       else
           n_state <= c_state;
       end if;
       else 
       n_efb_flag <=  HIGH ;
       n_wb_we_i <=   READ_STATUS;
       n_wb_adr_i <=  MICO_EFB_I2C_SR;
       n_wb_dat_i <=  (others=>'0') ;
       n_wb_stb_i <=  HIGH ; 
       n_state <= c_state; 
    end if;
     
 
 
   when state14 => -- Read Data
      if ((wb_ack_o and efb_flag)='1') then 
	  n_wb_dat_i <=  ALL_ZERO ;
          n_wb_adr_i <=  ALL_ZERO ;
          n_wb_we_i <=   LOW ;
          n_wb_stb_i <=  LOW ;
          n_efb_flag <=  LOW ;
          n_count_en <=  LOW ;
          n_temp3 <= wb_dat_o;		  
          if((gpio_command)='1')then  		  
             n_state <=  state16;
		  else  
             n_state <=  state19;			 
			 n_dat_count <= dat_count - '1'; 
		  end if;	 
       
       else 
       n_efb_flag <=  HIGH ;
       n_wb_we_i <=   READ_DATA;
       n_wb_adr_i <=  MICO_EFB_I2C_RXDR;
       n_wb_dat_i <=  (others=>'0') ;
       n_wb_stb_i <=  HIGH ; 
       n_state <= c_state; 
    end if;
     


	 when state15 => -- Send Data to Master
      if ((wb_ack_o and efb_flag)='1') then
          n_wb_dat_i <=  ALL_ZERO ;
          n_wb_adr_i <=  ALL_ZERO ;
          n_wb_we_i <=   LOW ;
          n_wb_stb_i <=  LOW ;
          n_efb_flag <=  LOW ;
          n_count_en <=  LOW ;
          n_state <=  state18;
		  if(mem_command ='1') then
		     n_dat_count <= dat_count - '1' ;
         		  
       end if;
       else 
       n_efb_flag <=  HIGH ;
       n_wb_we_i <=   WRITE;
       n_wb_adr_i <=  MICO_EFB_I2C_TXDR;
      n_wb_dat_i <= data0;
       n_wb_stb_i <=  HIGH ; 
       n_state <= c_state; 
    end if;
  
 
 
 
   when state16 => --Send NACK Based upon Command Receive
      if ((wb_ack_o and efb_flag)='1') then
          n_wb_dat_i <=  ALL_ZERO ;
          n_wb_adr_i <=  ALL_ZERO ;
          n_wb_we_i <=   LOW ;
          n_wb_stb_i <=  LOW ;
          n_efb_flag <=  LOW ;
          n_count_en <=  LOW ;
           n_state <=  state17;
       
       else 
       n_efb_flag <=  HIGH ;
       n_wb_we_i <=   WRITE;
       n_wb_adr_i <=  MICO_EFB_I2C_CMDR;
       n_wb_dat_i <= "00001100";  -- Keep clock stretching disabled per PCN#10A-13 
       n_wb_stb_i <=  HIGH ; 
       n_state <= c_state; 
    end if;
     
 
 
   when state17 => -- Wait till Stop is Send 
      if (wb_ack_o and efb_flag)='1' then
          n_wb_dat_i <=  ALL_ZERO ;
          n_wb_adr_i <=  ALL_ZERO ;
          n_wb_we_i <=   LOW ;
          n_wb_stb_i <=  LOW ;
          n_efb_flag <=  LOW ;
          n_count_en <=  LOW ;
       if(  wb_dat_o(6))='0' then
           n_state <=  state2;
       else
           n_state <= c_state;
       end if;
       else 
       n_efb_flag <=  HIGH ;
       n_wb_we_i <=   READ_STATUS;
       n_wb_adr_i <=  MICO_EFB_I2C_SR;
       n_wb_dat_i <=  (others=>'0') ;
       n_wb_stb_i <=  HIGH ; 
       n_state <= c_state; 
    end if;
   
 
   when  state18 => -- Wait for TxRDY flag and send data again if required 
      if (wb_ack_o and efb_flag)='1' then
          n_wb_dat_i <=  ALL_ZERO ;
          n_wb_adr_i <=  ALL_ZERO ;
          n_wb_we_i <=   LOW ;
          n_wb_stb_i <=  LOW ;
          n_efb_flag <=  LOW ;
          n_count_en <=  LOW ;
		  
	      if ((dat_count = "00000000") and (mem_command = '1')) then 
            n_state <=  state16;		             --     // Send Nack for Any More Read Request 
       elsif(wb_dat_o and  MICO_EFB_I2C_SR_TRRDY )="00000100" then
           if(mem_command='1')then
     		   n_state <=  state15;                   -- Send Data  
		   else
               n_state <=  state17;
           end if;			   -- Wait till Stop 
	   elsif (  wb_dat_o(6)='0')then -- If Stop go to beginning
           n_state <=  state2;
       else
           n_state <= c_state;
       end if;
	   
       else 
       n_efb_flag <=  HIGH ;
       n_wb_we_i <=   READ_STATUS;
       n_wb_adr_i <=  MICO_EFB_I2C_SR;
       n_wb_dat_i <=  (others=>'0') ;
       n_wb_stb_i <=  HIGH ; 
       n_state <= c_state; 
    end if;
     

 
    when state19 => -- Wait for TRRDY bit 
      if ((wb_ack_o and efb_flag)='1') then
          n_wb_dat_i <=  ALL_ZERO ;
          n_wb_adr_i <=  ALL_ZERO ;
          n_wb_we_i <=   LOW ;
          n_wb_stb_i <=  LOW ;
          n_efb_flag <=  LOW ;
          n_count_en <=  LOW ;
	   if ( dat_count = "00000000")then
            n_state <=  state16;		   
       elsif(wb_dat_o and MICO_EFB_I2C_SR_TRRDY )="00000100" then
           n_state <=  state14;
       elsif ( wb_dat_o(6))='0' then
           n_state <=  state2;
       else
           n_state <= c_state;
       end if;
       else 
       n_efb_flag <=  HIGH ;
       n_wb_we_i <=   READ_STATUS;
       n_wb_adr_i <=  MICO_EFB_I2C_SR;
       n_wb_dat_i <=  (others=>'0') ;
       n_wb_stb_i <=  HIGH ; 
       n_state <= c_state; 
    end if;		
	
	when others=>
	NULL;
     
	 
 
end case;
end process;
end i2c_vhdl;
    