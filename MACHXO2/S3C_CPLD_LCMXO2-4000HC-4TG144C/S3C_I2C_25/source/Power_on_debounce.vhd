library ieee;
library machxo2;
use machxo2.all;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all ;
use ieee.std_logic_unsigned.all; 
entity Waiting_for_Powerbutton_pressed_V0 is
-- i2c entities
  generic (
			 I2C_ADRESS_SPACE		: integer	 := 7;	     -- Default 7-bit space for i2c, could be extended to 10
			 GPO_DATA_WIDTH 		: integer	 := 8;	     -- Select Data width for all gpio (fixed width for input and output because of temp sizes)
			 GPI_DATA_WIDTH 		: integer	 := 8;	     -- Select Data width for all gpio (fixed width for input and output because of temp sizes)
             GPI_PORT_NUM       	: integer    := 1;       -- GPI port number
			 GPO_PORT_NUM       	: integer    := 1;       -- GPO port number
			 MEM_ADDR_WIDTH     	: integer    := 8;       -- Memory addrss width
			 IRQ_NUM            	: integer    := 4;       -- Interrupt request number
			 MAX_MEM_BURST_NUM  	: std_logic_vector (7 downto 0)    := "00001000";       -- Maximum memory burst number
		     INTQ_OPENDRAIN     	: bit        := '1'      -- INTQ opendrain setting (S_ON/S_OFF)
		   );

    Port (
		-- Mapping according to banks
		--- Bank 0, 3.3V
		FP_SysLEDg		: out STD_LOGIC; -- led green Power, pin 141
		FP_SysLEDr		: out STD_LOGIC; -- led red Power, pin 142
		FP_SysLEDb		: out STD_LOGIC;  --led blue Power, pin 143		
		FlexIO05 : out STD_LOGIC; --drive 0
		FlexIO04 : in STD_LOGIC; -- pulldown
		FlexIO03 : in STD_LOGIC;-- pulldown
		FlexIO02 : out STD_LOGIC;--drive 0
		FlexIO01 : out STD_LOGIC;--drive 0
		FP_UsrSW1		:		in  STD_LOGIC; 	-- button Enable System, pin 128
		FP_UsrSW2		:		in  STD_LOGIC; 	-- button SW2 Enable Control, pin 127
		--i2c
		SCL      : inout std_logic; -- pin 126, i2c CLK
		SDA      : inout std_logic; -- pin 125, i2c DATA
		FP_UsrSW3		:		in  STD_LOGIC; 	-- button SW3 STOP, pin 122
		SysSW_Pwr_NC 	: 		in  STD_LOGIC;	-- button Power, pin 121
		FPIO_isoCtrlRSTn	: 	out STD_LOGIC;	-- Z  off, 1 on, none
		FPIO_isoCtrlINTn	: 	in  STD_LOGIC;
		Carrier_PG_3V3	: out STD_LOGIC := 'Z';  -- Powergood 3.3V, pin 115
		FPIO_ExternalStop: in  STD_LOGIC; -- button external stop, pin 114
		FPIO_FlexMIO28 	: inout STD_LOGIC:= 'Z'; --Z
		FPIO_FlexMIO27 	: inout STD_LOGIC:= 'Z';
		FPIO_FlexMIO30 	: inout STD_LOGIC:= 'Z';
		FPIO_FlexMIO29 	: inout STD_LOGIC:= 'Z';
		FPIO_FlexMIO52 	: out STD_LOGIC; -- is converted in ps, pin 109, Z
		--- Bank 1, 1.8V
		Carrier_PG_1V8	: out STD_LOGIC := 'Z';  -- ResetN Port, Powergood 1.8V pin 107
		S3CsI2C_SDA		: inout STD_LOGIC;
		S3CsI2C_SCL		: inout STD_LOGIC;
		FP_SysLEDs		: out STD_LOGIC; -- led red SW3, pin 104
		SD1_CD			: in STD_LOGIC;  -- pin 103
		SD0_CD			: in STD_LOGIC;  -- pin 100
		SPI_S3C_nCS_USR : in STD_LOGIC;
		FP_UsrLED 		: out STD_LOGIC_VECTOR (4 downto 1); 
		DIGS3C_Shared_CarrierReady : out STD_LOGIC;  -- pin 94
		DIGS3C_Shared_ReqSafeState : out STD_LOGIC;  -- pin 93
		DIGS3C_SlotD_ReqOE : in STD_LOGIC_VECTOR (5 downto 1); -- pin 92,89,86,84,82
		DIGS3C_SlotD_SlotOK : in STD_LOGIC_VECTOR (5 downto 1); -- pin 91,87,85,83,81
		FlexLIO 		: inout STD_LOGIC_VECTOR (5 downto 0)  := (others => 'Z');
		--- Bank 2, 1.8V
		DIG5S3C26	: inout STD_LOGIC; --bidir,Z
		DIG5S3C25	: inout STD_LOGIC; --bidir,Z
		DIG5S3C24	: inout STD_LOGIC; --bidir,Z
		SD_SEL		: out STD_LOGIC := '0'; -- signal, that is driven to 0, pin 41
		ANL_VIN_FLT : in STD_LOGIC; -- Faul signal overcurrent A Slots
		-- Flex MIos
		FlexMIOs52_PCIe	: in  STD_LOGIC; -- routing through to FrontpanelIO.FlexMIO52_PCIe-R¯S¯T¯, inversion in PS pin 47
		FlexMIOs53_GPIO_PowerDown:out  STD_LOGIC; -- gpio perform SoM Shutdown, pin 48
		FlexMIOs54	: inout STD_LOGIC; --bidir,Z
		FlexMio61ExternalStop 	: out STD_LOGIC; -- external stop routed through, pin 50
		FlexMIOs62	: inout STD_LOGIC; --bidir,Z
		FlexMIOs63	: inout STD_LOGIC; --bidir,Z
		FlexMIOs31	: inout STD_LOGIC; --bidir,Z
		FlexMIOs30	: inout STD_LOGIC; --bidir,Z
		FlexMIOs29	: inout STD_LOGIC; --bidir,Z
		FlexMIOs28	: inout STD_LOGIC; --bidir,Z
		FlexMIOs27	: inout STD_LOGIC; --bidir,Z
		FlexMIOs26	: inout STD_LOGIC; --bidir,Z
		FlexMIOs45	: inout STD_LOGIC; --bidir,Z
		FlexMIOs37	: inout STD_LOGIC; --bidir,Z
		FlexMIOs36	: inout STD_LOGIC; --bidir,Z
		FlexMIOs35	: inout STD_LOGIC; --bidir,Z
		FlexMIOs34	: inout STD_LOGIC; --bidir,Z
		FlexMIOs33	: inout STD_LOGIC; --bidir,Z
		FlexMIOs32	: inout STD_LOGIC; --bidir,Z		
		--- Bank 3, 1.8V
		DIG5S3C03	: inout STD_LOGIC; --bidir,Z
		DIG5S3C04	: inout STD_LOGIC; --bidir,Z
		DIG5S3C05	: inout STD_LOGIC; --bidir,Z
		DIG5S3C00	: inout STD_LOGIC; --bidir,Z
		DIG5S3C02	: inout STD_LOGIC; --bidir,Z
		DIG5S3C01	: inout STD_LOGIC; --bidir,Z
		DIG5S3C29	: inout STD_LOGIC; --bidir,Z
		DIG5S3C28	: inout STD_LOGIC; --bidir,Z
		DIG5S3C27	: inout STD_LOGIC; --bidir,Z
		
		--- Bank 4, 3.3V
		ANL_S3C_SLOTOK : in STD_LOGIC_VECTOR (3 downto 1); -- pin 23,22,21
		ANL_S3C_CarrierReady: out STD_LOGIC;  -- pin 24
		ANL_S3C_P54_Legacy	: inout STD_LOGIC;--bidir,Z,pin 13		
		DIGS3C_SlotD_SlotOE : OUT STD_LOGIC_VECTOR (5 downto 1); -- pin 20,19,17,15,14
		
		--- Bank 5, 3.3V
        Carrier_PwrOn 	: out STD_LOGIC;   	-- pin 1
		PG_VIN			: in STD_LOGIC;		-- pin 2, none
		PPn_VIN			: in STD_LOGIC;		-- pin 3, none
		PG_Module 		: in STD_LOGIC;		-- pin 9, none
		TDnSHDN			: in STD_LOGIC;		-- pin 4, none
		TDnFFnFS		: inout STD_LOGIC;	-- pin 5, none
		TDnALERT 		: in STD_LOGIC;		-- pin 6, none
		S3C_S1 			: in STD_LOGIC;		-- pin 10, pulldown
		
		--i2c ports - need to be assigned to existing ports
		IRQ      : in std_logic_vector (IRQ_NUM-1 downto 0)      
		-- RST_N	 : in std_logic => PG_Module dient als RESETN
		--INTQ     : out std_logic:='1' no interrupts
    );
	
end Waiting_for_Powerbutton_pressed_V0;

architecture behavior of Waiting_for_Powerbutton_pressed_V0 is
	signal clk	:	STD_LOGIC;
	signal counter : integer range 0 to 31200000 := 0; 	-- counter 
	signal resetcounter : integer range 0 to 31200000 := 31200000; 	-- reset counter for soft reset
	signal resetnefb		: STD_LOGIC;
	signal count_done_100ms : boolean := false; 			-- flag for 100ms end
	signal reset_triggered : boolean := false; -- flag, to track resetn is zero

    -- states in statemachine
    type state_type is (Waiting_for_Powerbutton_pressed,Waiting_for_Powerbutton_released,Wait_State, EthernetPhy_Reset,Waiting_for_Powerbutton_pressed_2sec , Ready_State, Warning_State, Harderror,Softerror, sleep_for_dslot_down,Acknowledge_error ,Waiting_for_Powerbutton_released_after_2sec2 );
    signal next_state : state_type:= Waiting_for_Powerbutton_pressed;
	
    -- debounceconstant
    constant debounce_limit : integer := 70000; -- 10ms, needs to be adjusted to clock 2.08MhZ

    -- debounce counter and vectors for debouncing
    type debounce_array is array (1 to 6) of integer;
    signal debounce_counters : debounce_array := (others => 0);
	signal debounce_inputs  : STD_LOGIC_VECTOR(6 downto 1) ;  -- inputs
    signal debounce_inputs_asyn1  : STD_LOGIC_VECTOR(6 downto 1)  := (others => '1');  -- inputs after 1.flip flop
	signal debounce_inputs_asyn2  : STD_LOGIC_VECTOR(6 downto 1)  := (others => '1'); -- inputs after 2. flip flop
	signal pushed : STD_LOGIC_VECTOR(6 downto 1)  := (others => '0');
    signal signals_debounced_syn   : STD_LOGIC_VECTOR(6 downto 1)  := (others => '1');
	-- debounced signal
	signal power	:	STD_LOGIC;
	signal stopextern	:	STD_LOGIC;
	signal stop	:	STD_LOGIC;
	signal enable	:	STD_LOGIC;
	signal pg10v	:	STD_LOGIC;
	signal ppn6v	:	STD_LOGIC;
	signal warning 	: 	STD_LOGIC;
	
	-- detect external stop edge
	signal externstop_falling: 	STD_LOGIC;
	signal externstop_last: 	STD_LOGIC;
	signal extern_connected: 	STD_LOGIC := '0';
	-- Tristate
	signal tristate_signals : std_logic_vector(30 downto 0);
	-- Dslot
	signal forceoutputdisable :		STD_LOGIC;
	-- define internal clock
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
	attribute HGROUP 	: string;
	signal dummy_signal : std_logic;
	attribute syn_keep : boolean;
	attribute noclip   : string;
	attribute noclip of dummy_signal  : signal is "on";
	attribute syn_keep of dummy_signal : signal is true;

-- EFB and Wishbone Interface

--gpi ports
signal GPI    	 : std_logic_vector (GPI_DATA_WIDTH-1 downto 0);
--gpo ports
signal GPO		 : std_logic_vector(GPO_DATA_WIDTH-1 downto 0);



-- EFB REGISTER SET
 --constant INTQ_OPENDRAIN    : std_logic := '0';                                                       
 constant MICO_EFB_I2C_CR     : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "01000000"; --4a
 constant MICO_EFB_I2C_CMDR   : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "01000001";--4b
 constant MICO_EFB_I2C_BLOR	  : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "01000010";--4c
 constant MICO_EFB_I2C_BHIR	  : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "01000011"; --4d
 constant MICO_EFB_I2C_TXDR	  : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "01000100"; --4e
 constant MICO_EFB_I2C_SR	  : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "01000101"; --4f
 constant MICO_EFB_I2C_GCDR	  : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "01000110";--50
 constant MICO_EFB_I2C_RXDR	  : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "01000111"; --51
 constant MICO_EFB_I2C_IRQSR  : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "01001000"; --52
 constant MICO_EFB_I2C_IRQENR : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "01001001"; --53

--EFB I2C CONTROLLER PHYSICAL DEVICE SPECIFIC INFORMATION

-- Control Register Bit Masks

 constant MICO_EFB_I2C_CR_I2CEN  : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "10000000";	 
 constant MICO_EFB_I2C_CR_GCEN   : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "01000000"; 
 constant MICO_EFB_I2C_CR_WKUPEN : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "00100000";

-- Status Register Bit Masks

 constant MICO_EFB_I2C_SR_TIP	 : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "10000000"; 
 constant MICO_EFB_I2C_SR_BUSY   : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "01000000"; 
 constant MICO_EFB_I2C_SR_RARC   : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "00100000"; 
 constant MICO_EFB_I2C_SR_SRW	 : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "00010000"; 
 constant MICO_EFB_I2C_SR_ARBL	 : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "00001000";		 
 constant MICO_EFB_I2C_SR_TRRDY	 : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "00000100"; 
 constant MICO_EFB_I2C_SR_TROE	 : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "00000010";	 
 constant MICO_EFB_I2C_SR_HGC	 : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "00000001";	 

-- Command Register Bit Masks 

 constant MICO_EFB_I2C_CMDR_STA     : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "10000000"; 
 constant MICO_EFB_I2C_CMDR_STO	    : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "01000000"; 
 constant MICO_EFB_I2C_CMDR_RD	    : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "00100000"; 
 constant MICO_EFB_I2C_CMDR_WR	    : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "00010000"; 
 constant MICO_EFB_I2C_CMDR_NACK	: std_logic_vector(I2C_ADRESS_SPACE downto 0) := "00001000"; 
 constant MICO_EFB_I2C_CMDR_CKSDIS  : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "00000100"; 


--CODE SPECIFIC

  constant ALL_ZERO    : std_logic_vector(I2C_ADRESS_SPACE downto 0) := "00000000";   
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

signal wb_dat_i : std_logic_vector(I2C_ADRESS_SPACE downto 0) ;
signal wb_stb_i : std_logic ;
signal wb_cyc_i : std_logic  ;
signal wb_adr_i : std_logic_vector(I2C_ADRESS_SPACE downto 0) ;
signal wb_we_i  : std_logic ;
signal wb_dat_o : std_logic_vector(I2C_ADRESS_SPACE downto 0) ;
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
	GENERIC MAP( NOM_FREQ => "7" )-- Always change in the spreadsheet view too
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

rst_p <= not (resetnefb);
wb_cyc_i<=  wb_stb_i;


-- Zuweisung der GPIs
GPI(0) <= FP_UsrSW1;
GPI(1) <= FP_UsrSW2;
GPI(2) <= FP_UsrSW3;
GPI(3) <= FlexIO03;
GPI(4) <= FlexIO04;
GPI(5) <= SD0_CD;
GPI(6) <= FPIO_isoCtrlINTn;
GPI(7) <= ANL_VIN_FLT; 
--Zuweisung der GPOs
FlexIO01 <= GPO(0);
FlexIO02 <= GPO(1);
FlexIO05 <= GPO(2);
FP_SysLEDs <= GPO(3);
fp_usrled(1) <= GPO(4);
fp_usrled(2) <= GPO(5);
fp_usrled(3)<= GPO(6);
fp_usrled(4)<= GPO(7);

--Dummy
dummy_signal <= TDnALERT AND TDnFFnFS AND TDnSHDN AND PG_VIN and ANL_S3C_P54_Legacy AND ANL_S3C_SLOTOK(1) AND ANL_S3C_SLOTOK(2) AND ANL_S3C_SLOTOK(3)  
AND DIGS3C_SlotD_SlotOK(1) AND DIGS3C_SlotD_SlotOK(2) AND DIGS3C_SlotD_SlotOK(3) AND DIGS3C_SlotD_SlotOK(4) AND DIGS3C_SlotD_SlotOK(5)
AND DIG5S3C00 AND DIG5S3C01 AND DIG5S3C02 AND DIG5S3C03 AND DIG5S3C04 AND DIG5S3C05
AND DIG5S3C24 AND DIG5S3C25 AND DIG5S3C26 AND DIG5S3C27 AND DIG5S3C28 AND DIG5S3C29
AND FPIO_FlexMIO27 AND FPIO_FlexMIO28 AND FPIO_FlexMIO29 AND FPIO_FlexMIO30
AND FPIO_isoCtrlINTn AND FP_UsrSW2 
AND FLexLIO(0) AND FLexLIO(1) AND FLexLIO(2) AND FLexLIO(3) AND FLexLIO(4) AND FLexLIO(5)
AND FlexMIOs26 AND FlexMIOs27 AND FlexMIOs28 AND FlexMIOs29 AND FlexMIOs30 
AND FlexMIOs31
AND FlexMIOs32 AND FlexMIOs33 AND FlexMIOs34 AND FlexMIOs35 AND FlexMIOs36 AND FlexMIOs37
AND FlexMIOs45 AND FlexMIOs54 AND FlexMIOs62 AND FlexMIOs63 AND PG_Module 
AND S3C_S1 AND 
S3CsI2C_SCL AND S3CsI2C_SDA AND 
--SCL AND SDA AND
SD0_CD AND SD1_CD  AND SPI_S3C_nCS_USR;

tristate_signals <= DIG5S3C00 & DIG5S3C01 & DIG5S3C02 & DIG5S3C03 & DIG5S3C04  & DIG5S3C05
& DIG5S3C24 & DIG5S3C25 & DIG5S3C26 & DIG5S3C27 & DIG5S3C28 & DIG5S3C29 
& FlexMIOs26 & FlexMIOs27 & FlexMIOs28 & FlexMIOs29 & FlexMIOs30 & 
FlexMIOs31
& FlexMIOs32 & FlexMIOs33 & FlexMIOs34 & FlexMIOs35 & FlexMIOs36 & FlexMIOs37
& FlexMIOs54 & FlexMIOs62 & FlexMIOs63 & FPIO_FlexMIO27 & FPIO_FlexMIO28 & FPIO_FlexMIO29 & FPIO_FlexMIO30;
-- Assign 'Z' to all unused signal
tristate_signals <= (others => 'Z');
-- Ports default + routing through
SD_SEL <= '0';
FPIO_FlexMIO52 <= FlexMIOs52_PCIe;
FlexMio61ExternalStop <= FPIO_ExternalStop;
warning <= '0'; -- hardcoded 0 = never warning
-- Mapping buttons
debounce_inputs(1) <= SysSW_Pwr_NC;
debounce_inputs(2) <= FPIO_ExternalStop;
debounce_inputs(3) <= FP_UsrSW3;
debounce_inputs(4) <= FP_UsrSW1;
debounce_inputs(5) <= PG_VIN;
debounce_inputs(6) <= PPn_VIN;
-- Conditional passthrough for OE
DIGS3C_SlotD_SlotOE <= DIGS3C_SlotD_ReqOE and (DIGS3C_SlotD_SlotOE'Range => NOT forceoutputdisable);


-- Buttons debounce process
process(clk)
    begin
        if rising_edge(clk) then
			debounce_inputs_asyn1 <= debounce_inputs;
			debounce_inputs_asyn2 <= debounce_inputs_asyn1; 
		
		-- debouncing for all signals
            for i in 1 to 6 loop
                if debounce_inputs_asyn2(i) = '0' then  -- button pressed (low)
                    if debounce_counters(i) < debounce_limit then
                        debounce_counters(i) <= debounce_counters(i) + 1;
                    else
                        pushed(i) <= '1';  -- button pressed = true
                    end if;
                else  -- button high
                    debounce_counters(i) <= 0;
                    pushed(i) <= '0';
                end if;
                -- result inverted
                if pushed(i) = '1' then
                    signals_debounced_syn(i) <= '0';
                else
                    signals_debounced_syn(i) <= '1';
                end if;
            end loop;
			-- detect falling edge in external stop
			externstop_falling <= externstop_last and NOT signals_debounced_syn(2);
			externstop_last  <= signals_debounced_syn(2);
		end if;
end process;
-- Decode buttons for better readability, 1 => user press the buttons
power<=NOT signals_debounced_syn(1);
stopextern<=NOT signals_debounced_syn(2);
stop<=NOT signals_debounced_syn(3);
enable<=NOT signals_debounced_syn(4);
pg10v<=signals_debounced_syn(5);
ppn6v<=signals_debounced_syn(6);

     --LED control logic
    --led_control: process(resetcounter)
    --begin
        --if resetcounter = 0 then
			--fp_usrled(1) <= '0';
			--fp_usrled(2) <= '0';
			--fp_usrled(3) <= '1';
			--fp_usrled(4) <= '0';
        --elsif resetcounter = 31200000 then
			--fp_usrled(1) <= '1';
			--fp_usrled(1) <= '0';
			--fp_usrled(3) <= '0';
			--fp_usrled(4) <= '1';
		--else
			--fp_usrled(4) <= '1';
			--fp_usrled(3) <= '1';
			--fp_usrled(2) <= '1';
			--fp_usrled(1) <= '1';
        --end if;
    --end process;
 -- soft reset for i2c and efb
	reset_control: process(clk,resetcounter)
	begin
	if rising_edge(clk) then
		if resetcounter < 31200000 then
			resetnefb <= '0';
			resetcounter <= resetcounter + 1;
		else
			resetnefb <= '1';
		end if;
	end if;
	end process;


--i2c data and command storing

process (CLK, resetnefb) is
begin
if (CLK'event and CLK='1') then
   
   if(  resetnefb='0') then
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

  process(CLK, resetnefb) is
    begin
      if (CLK'event and CLK='1') then
   
         if(  resetnefb='0') then
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
   
   process(CLK, resetnefb) is
    begin
      if (CLK'event and CLK='1') then
        if(  resetnefb='0') then
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

process(CLK, resetnefb) is
begin
if (CLK'event and CLK='1') then
   
   if(  resetnefb='0') then
       
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
   
--process(CLK, resetnefb) is
--begin
--if (CLK'event and CLK='1') then
   
   --if(  resetnefb='0') then
         --GPO <= (others=>'0');	 
      --elsif ((dat_rdy_del and c)='1') then 
       --case reg_addr is
          --when "00000000" =>
		  --GPO <= temp3;
		  --when others=>
		  --NULL;
	   --end case;	  
	--end if;
 --end if;	
--end process;




    process(CLK, resetnefb) is
     begin
       if (CLK'event and CLK='1') then
          if(  resetnefb = '0') then
		    for J in 0 to GPO_PORT_NUM-1 loop
			  GPO_DATA (J) <= (others=>'0');
			end loop;
          elsif ((dat_rdy_del and GPIO_Write)='1') then
			  GPO_DATA(to_integer(unsigned(reg_addr))) <= temp3(GPO_DATA_WIDTH-1 downto 0);              		  
	      end if;
       end if;	
     end process;
	 
   GPO <= GPO_DATA(0);
   GPO <= GPO_DATA(0);
 

  GPIO_Read <= '1' when (i2c_cmd = "00000101") else '0';

    process(CLK, resetnefb) is
     begin
       if (CLK'event and CLK='1') then
          if(  resetnefb = '0') then
			  GPI_DAT <= (others=>'0');
          elsif ((reg_rdy and GPIO_Read)='1') then
			  GPI_DAT <= GPI_DATA(to_integer(unsigned(reg_addr)));              		  
	      end if;
       end if;	
     end process;
	 
   GPI_DATA(0) <= GPI;


--/////////////////////////////////////////////
--//                                         //
--//        Interrupt Control Logic          //
--//                                         //
--/////////////////////////////////////////////   
--// intq is asserted low when any IRQ Status Register bit is set. 
--// And the INTQ_OPENDRAIN parameter defines INTQ's opendrain setting. 
  --check_irq_status <= (irq_status(0)) or (irq_status(1)) or (irq_status(2)) or (irq_status(3)) ; 
  
   --a <= (irq(0)) or (irq(1)) or (irq(2)) or (irq(3));
   --process(check_irq_status) is
   --begin
      --if(check_irq_status = '1')then
         --INTQ<='0';
      --else
        --if (INTQ_OPENDRAIN='1')then
            --INTQ <= 'Z';
        --else
            --INTQ <='1';
        --end if;
	  --end if;
   --end process;

     
   -- When IRQ is enabled, a rising edge of an IRQ input will set the corresponding bit in the IRQ Status register.
   
 
 
   --IRQ_STATUS_GENERATE:  for N in 0 to IRQ_NUM-1 generate
   --begin
   
             --process( IRQ(N), irq_status_clr(N), irq_clr(N), rst_p)
			 --begin
			   --irq_status_clr(N) <= ( irq_clr(N) or (rst_p) );
			   --if   ( irq_status_clr(N) = '1' ) then
				      --irq_status(N) <= '0';
			   --elsif(IRQ(N)'event and IRQ(N) = '1') then
			      --if ( irq_en(N) = '1') then
				       --irq_status(N) <= '1';
				  --end if;
               --end if;
			 --end process;
			 
   --end generate IRQ_STATUS_GENERATE;
 
-- *********************************************************************************

  --IRQ_Enable_Write <= '1' when (i2c_cmd = "01100110") else '0';
  --IRQ_Clear <= '1' when (i2c_cmd = "01100001") else '0';

process(CLK,  resetnefb) is
begin
if (CLK'event and CLK='1') then
   
   if(  resetnefb='0') then 
        irq_en  <= "0000";
		irq_clr <= "0000";
      
	elsif ((reg_rdy_del and IRQ_Enable_Write)= '1') then 
        irq_en  <= temp2(3 downto 0);
	elsif ((reg_rdy_del and IRQ_Clear)='1') then 
        irq_clr  <= temp2(3 downto 0);		
  end if;
  end if;
  end process;
 	

 
--process(CLK ,  resetnefb) is
--begin
--if (CLK'event and CLK='1') then
  -- 
   --if(  resetnefb='0') then 
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


process(CLK ,  resetnefb) is
begin
if (CLK'event and CLK='1') then
   
   if(  resetnefb='0') then 
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

process(CLK ,  resetnefb) is
begin
if (CLK'event and CLK='1') then
   
   if(  resetnefb='0') then 
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


-- State machine s3c 
process(clk)
    begin
	if rising_edge(clk) then
        case next_state is
            when Waiting_for_Powerbutton_pressed =>
				forceoutputdisable <= '1';
				DIGS3C_Shared_ReqSafeState <= '1'; -- not working because bank 1 1.8vper not supplied
				FlexMIOs53_GPIO_PowerDown <= '0';
				FP_SysLEDr <= '0';	
				FP_SysLEDb <= '1';	
				FP_SysLEDg <= '0';	
				if power = '1' then
					next_state <= Waiting_for_Powerbutton_released;
				else
					Carrier_PwrOn <= '0';  -- all rails down, only s3c alive
					Carrier_PG_3V3 <= '0';
					FPIO_isoCtrlRSTn <= '0'; -- reset IsoIO enable
					Carrier_PG_1V8 <= 'Z';  -- tristate as long as system is down
				end if;
			when Waiting_for_Powerbutton_released =>
				forceoutputdisable <= '1';
				DIGS3C_Shared_ReqSafeState <= '1'; -- not working because bank 1 1.8vper not supplied
				FP_SysLEDr <= '0';	
				FP_SysLEDb <= '1';	
				FP_SysLEDg <= '1';
				if power = '1' then
					Carrier_PwrOn <= '1';  -- enables all rails
					Carrier_PG_3V3 <= '1'; -- Hack IsoIo on, if power on
					counter <= 7000000;
					next_state <= Wait_State;
				end if;
			
			when Wait_State =>
				forceoutputdisable <= '1';
				DIGS3C_Shared_ReqSafeState <= '1'; -- not working because bank 1 1.8vper not supplied
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '1';	
				FP_SysLEDg <= '0';
				if counter > 0 then
					counter <= counter - 1;
				else 
					counter <= 350000;
					Carrier_PG_1V8 <= '0';  -- resetn for 50ms to zero
					next_state <= EthernetPhy_Reset;
				end if;
			
			when EthernetPhy_Reset =>
				forceoutputdisable <= '1';
				DIGS3C_Shared_ReqSafeState <= '1'; -- not working because bank 1 1.8vper not supplied
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '1';	
				FP_SysLEDg <= '1';
				if counter > 0 then
					counter <= counter - 1;
				else
					if  extern_connected='1' AND stopextern = '1' then
						next_state <= Harderror;
					else
						Carrier_PG_1V8 <= 'Z';  -- after 50 ms tristate
						FPIO_isoCtrlRSTn <= '1'; -- reset IsoIO off
						next_state <= Ready_State;
					end if;
				end if;
            when ready_state =>
				forceoutputdisable <= NOT PPn_VIN; 
				DIGS3C_Shared_ReqSafeState <= '0';
				FP_SysLEDr <= '0';	
				FP_SysLEDb <= '0';	
				FP_SysLEDg <= '1';
				--FP_SysLEDs <= '1';
                if externstop_falling = '1' then  
					counter <= 31200000;
                    next_state <= Harderror;
				elsif stop = '1' then  
                    next_state <= Softerror;
				elsif warning = '1' then
					next_state <= Warning_State;
                elsif power = '1' then 
					counter <= 14000000;
					next_state <= Waiting_for_Powerbutton_pressed_2sec ;
				end if;
            when warning_state =>
				forceoutputdisable <= NOT PPn_VIN; 
				DIGS3C_Shared_ReqSafeState <= '0';
				FP_SysLEDr <= '0';	
				FP_SysLEDb <= '1';	
				FP_SysLEDg <= '0';
				--FP_SysLEDs <= '0';
                -- skip external stop
                if externstop_falling = '1' then  
					counter <= 31200000;
                    next_state <= Harderror;
				elsif stop = '1' then  
                    next_state <= Softerror;
                elsif power = '1' then 
					counter <= 14000000;
					next_state <= Waiting_for_Powerbutton_pressed_2sec;
				end if;
            when Harderror =>
				--Request safe state to dslots
				forceoutputdisable <= NOT PPn_VIN; 
				DIGS3C_Shared_ReqSafeState <= '1';
				FlexMIOs53_GPIO_PowerDown <= '1';  -- info to som, power linux down;
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '0';	
				FP_SysLEDg <= '0';
				--FP_SysLEDs <= '1';	
				Carrier_PwrOn <= '0';  -- all rails down, only s3c alive
				Carrier_PG_3V3 <= '0';
				FPIO_isoCtrlRSTn <= '0'; -- reset IsoIO on
				if counter > 0 then
					counter <= counter - 1;
				else
					-- bit to check if external stop was connected
					extern_connected <= '1';
					next_state <= Acknowledge_error;
				end if;
			when Acknowledge_error => 
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '1';	
				FP_SysLEDg <= '0';
				if power = '1' then 
					next_state <= Waiting_for_Powerbutton_released_after_2sec2;
				end if;
			when Softerror =>
				--Request safe state to dslots
				forceoutputdisable <= NOT PPn_VIN; 
				DIGS3C_Shared_ReqSafeState <= '1';
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '1';	
				FP_SysLEDg <= '1';
				--FP_SysLEDs <= '1';	
				if power = '1' then 
					counter <= 14000000;
					next_state <= Waiting_for_Powerbutton_pressed_2sec ;
				elsif externstop_falling = '1' then  
					counter <= 31200000;
                    next_state <= Harderror;
				elsif enable = '1' then 
					next_state <= Ready_State;
				end if;
			when Waiting_for_Powerbutton_pressed_2sec  =>
				forceoutputdisable <= NOT PPn_VIN; 
				DIGS3C_Shared_ReqSafeState <= '0';
				FlexMIOs53_GPIO_PowerDown <= '1';  -- info to som, power linux down;
				if counter > 0 then
					counter <= counter - 1;
				else
					if power = '1' then -- override mode activated
						FlexMIOs53_GPIO_PowerDown <= '0'; -- end info to som
						DIGS3C_Shared_ReqSafeState <= '1'; -- info to dcplds
						counter <= 7000000;
						next_state <= sleep_for_dslot_down;
					end if;
				end if;
				if power = '0' then 
					FlexMIOs53_GPIO_PowerDown <= '0';
					next_state <= Ready_State;
				end if;
			when sleep_for_dslot_down =>
				if counter > 0 then
					counter <= counter - 1;
				else
					next_state <= Waiting_for_Powerbutton_released_after_2sec2 ;
				end if;
            when Waiting_for_Powerbutton_released_after_2sec2  => 
				forceoutputdisable <= '1'; 
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '0';	
				FP_SysLEDg <= '1';
				--FP_SysLEDs <= '0';	
				Carrier_PwrOn <= '0'; -- all rails down, only s3c alive
				Carrier_PG_3V3 <= '0';
				FPIO_isoCtrlRSTn <= '0'; -- reset IsoIO on
				if power = '0' then
					next_state <= Waiting_for_Powerbutton_pressed;
				end if;
            when others =>
                next_state <= Waiting_for_Powerbutton_pressed;
        end case;
	end if;
end process;

end behavior;