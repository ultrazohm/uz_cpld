library IEEE;
library machxo2;
use machxo2.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Waiting_for_Powerbutton_pressed_V0 is

  generic (
             GPI_PORT_NUM       : integer    := 1;       -- GPI port number
			 GPI_DATA_WIDTH     : integer    := 8;       -- GPI data width
			 GPO_PORT_NUM       : integer    := 1;       -- GPO port number
			 GPO_DATA_WIDTH     : integer    := 8;       -- GPO data width
			 MEM_ADDR_WIDTH     : integer    := 8;       -- Memory addrss width
			 IRQ_NUM            : integer    := 4;       -- Interrupt request number
			 MAX_MEM_BURST_NUM  : std_logic_vector (7 downto 0)    := "00001000";       -- Maximum memory burst number
		     INTQ_OPENDRAIN     : bit        := '1'      -- INTQ opendrain setting (S_ON/S_OFF)
		   );
    Port (
		-- Mapping nach Bänken
		--i2c
		SCL      : inout std_logic; -- PIN 126, CLK
		SDA      : inout std_logic; -- PIN 125, DATA
		RST_N    : in std_logic; -- RST; stop Taster PIN 122
		--- Bank 0, 3.3V
		FP_SysLEDg		: out STD_LOGIC; -- LED grün Power, PIN 141
		FP_SysLEDr		: out STD_LOGIC; -- LED rot Power, PIN 142
		FP_SysLEDb		: out STD_LOGIC;  -- Power, PIN 143		
		Carrier_PG_3V3	: out STD_LOGIC := 'Z';  -- Powergood 3.3V, PIN 115
		FPIO_FlexMIO52 	: out STD_LOGIC; -- wird in ps invertiert, FlexMIOs52_PCIe durchgeroutet, PIN 109	
		FPIO_ExternalStop	: in  STD_LOGIC; -- FP Externer Stop taster, PIN 114
		FPIO_isoCtrlRSTn	: out  STD_LOGIC; -- FP IO PIN 119
		-- Tastersignale FP
		SysSW_Pwr_NC 	: 		in  STD_LOGIC;	-- Eingang durch Powerbutton, PIN 121
		FP_UsrSW1		:		in  STD_LOGIC; 	-- Eingang SW1 Enable System, PIN 128
		FP_UsrSW2		:		in  STD_LOGIC; 	-- Eingang SW2 Enable Control, PIN 127
		FP_UsrSW3		:		in  STD_LOGIC; 	-- Eingang SW3 STOP, PIN 122
		--- Bank 1, 1.8V
		FP_UsrLED1		: out STD_LOGIC; -- LED 1 Ready, PIN 95
		FP_UsrLED2		: out STD_LOGIC; -- LED 2 Running, PIN 96
		FP_UsrLED3		: out STD_LOGIC; -- LED 3 Error, PIN 97
		FP_UsrLED4		: out STD_LOGIC; -- LED 4 User, PIN 98
		FP_SysLEDs		: out STD_LOGIC; -- LED rot STOP, PIN 104
		Carrier_PG_1V8	: out STD_LOGIC := 'Z';  -- ResetN Port, Powergood 1.8V PIN 107
		SD0_CD			: in STD_LOGIC;  -- PIN 100
		SD1_CD			: in STD_LOGIC;  -- PIN 103
		DIGS3C_Shared_CarrierReady : out STD_LOGIC;  -- PIN 94
		DIGS3C_Shared_ReqSafeState : out STD_LOGIC;  -- PIN 93
		
		DIGS3C_SlotD1_ReqOE : in STD_LOGIC;  -- PIN 92
		DIGS3C_SlotD1_SlotOK : in STD_LOGIC;  -- PIN 91
		
		DIGS3C_SlotD2_ReqOE : in STD_LOGIC;  -- PIN 89
		DIGS3C_SlotD2_SlotOK : in STD_LOGIC;  -- PIN 87
		
		DIGS3C_SlotD3_ReqOE : in STD_LOGIC;  -- PIN 86
		DIGS3C_SlotD3_SlotOK : in STD_LOGIC;  -- PIN 85
		
		DIGS3C_SlotD4_ReqOE : in STD_LOGIC;  -- PIN 84
		DIGS3C_SlotD4_SlotOK : in STD_LOGIC;  -- PIN 83
		
		DIGS3C_SlotD5_ReqOE : in STD_LOGIC;  -- PIN 82
		DIGS3C_SlotD5_SlotOK : in STD_LOGIC;  -- PIN 81
		
		--- Bank 2, 1.8V
		SD_SEL		: out STD_LOGIC := '0'; -- Signal, dass auf 0 getrieben werden soll, PIN 41
		FlexMIOs52_PCIe	: in  STD_LOGIC; -- Durchrouten zu FrontpanelIO.FlexMIO52_PCIe-R¯S¯T¯, invertierung in PS PIN 47
		FlexMio61ExternalStop 	: out STD_LOGIC; -- ExternalStop durchgeroutet, PIN 50
		FlexMIOs53_GPIO_PowerDown:out  STD_LOGIC; -- GPIO perform SoM Shutdown Signal, PIN 48
		
		--- Bank 3, 1.8V

		--- Bank 4, 3.3V
		ANL_S3C_SlotOK1 : in STD_LOGIC;  -- PIN 23
		ANL_S3C_SlotOK2 : in STD_LOGIC;  -- PIN 22
		ANL_S3C_SlotOK3 : in STD_LOGIC;  -- PIN 21
		ANL_S3C_CarrierReady: out STD_LOGIC;  -- PIN 24
		ANL_S3C_P54_Legacy	: out STD_LOGIC;  -- PIN 13
		
		DIGS3C_SlotD1_SlotOE : out STD_LOGIC;  -- PIN 20
		DIGS3C_SlotD2_SlotOE : out STD_LOGIC;  -- PIN 19
		DIGS3C_SlotD3_SlotOE : out STD_LOGIC;  -- PIN 17
		DIGS3C_SlotD4_SlotOE : out STD_LOGIC;  -- PIN 15
		DIGS3C_SlotD5_SlotOE : out STD_LOGIC;  -- PIN 14
		
		
		--- Bank 5, 3.3V
        Carrier_PwrOn 	: out STD_LOGIC;   	-- PIN 1
		PG_VIN			: in STD_LOGIC;		-- PIN 2
		PPn_VIN			: in STD_LOGIC;		-- PIN 3
		PG_Module 		: in STD_LOGIC		-- PIN 9
    );
	
end Waiting_for_Powerbutton_pressed_V0;

architecture behavior of Waiting_for_Powerbutton_pressed_V0 is
 --/***********************************************************************
 --*                                                                     *
 --* SPI SIGNALS                                           *
 --*                                                                     *
 --***********************************************************************/
    signal scuba_vhi: std_logic;
    signal spi_mosi_oe: std_logic;
    signal spi_mosi_o: std_logic;
    signal spi_miso_oe: std_logic;
    signal spi_miso_o: std_logic;
    signal spi_clk_oe: std_logic;
    signal spi_clk_o: std_logic;
    signal spi_mosi_i: std_logic;
    signal spi_miso_i: std_logic;
    signal spi_clk_i: std_logic;
    signal scuba_vlo: std_logic;
	  
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






	signal clk	:	STD_LOGIC;
	signal counter : integer range 0 to 4160000 := 0; 	-- Zähler 
	signal count_done_100ms : boolean := false; 			-- Flag für 100ms Ende
	signal reset_triggered : boolean := false; -- Flag, um zu tracken, dass resetn auf '0' gesetzt wurde

    -- Definition der Zustände der State Machine
    type state_type is (Waiting_for_Powerbutton_pressed,Waiting_for_Powerbutton_released,Wait_State, EthernetPhy_Reset,SoftPowerOff, Ready_State, Warning, Error, PowerOff);
    signal next_state : state_type:= Waiting_for_Powerbutton_pressed;
	
    -- Entprell-Zeitkonstante
    constant debounce_limit : integer := 20800; -- 10ms, bei 2.08MhZ

    -- Entprell-Zähler und stabile Zustände der Taster
    type debounce_array is array (0 to 1) of integer;
    signal debounce_counters : debounce_array := (others => 0);
	signal button_inputs  : STD_LOGIC_VECTOR(1 downto 0);  -- Tastereingänge
    signal button_inputs_asyn1  : STD_LOGIC_VECTOR(1 downto 0) := (others => '1');  -- Tastereingänge nach 1. flip flop
	signal button_inputs_asyn2  : STD_LOGIC_VECTOR(1 downto 0) := (others => '1'); -- Tastereingänge nach 2. flip flop
	signal pushed : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal buttons_debounced_syn   : STD_LOGIC_VECTOR(1 downto 0) := (others => '1');
	
	component efb_VHDL
	port (
        wb_clk_i: in  std_logic; 
        i2c1_scl: inout  std_logic; 
        i2c1_sda: inout  std_logic; 
        i2c1_irqo: out  std_logic);

	end component;
	
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
	attribute HGROUP 	: string;

begin
	OSCInst0: OSCH
	-- synthesis translate_off
	GENERIC MAP( NOM_FREQ => "7" )
	-- synthesis translate_on
	PORT MAP (STDBY=> '0',
	OSC => clk,
	SEDSTDBY => open
	);
	
	dut : efb_VHDL 
	port map (
	wb_clk_i => CLK,   
	i2c1_scl =>SCL,
	i2c1_sda =>SDA,
	i2c1_irqo =>i2c1_irqo
	);

	rst_p <= not (RST_N);
	wb_cyc_i<=  wb_stb_i;

-- Apply the HGROUP attribute to both flip-flops
--attribute HGROUP of button_inputs_asyn1, button_inputs_asyn2 : signal is "sync_group";

-- Ports default setzen + durchrouten
SD_SEL <= '0';
FPIO_FlexMIO52 <= FlexMIOs52_PCIe;
FlexMio61ExternalStop <= FPIO_ExternalStop;

-- Mapping der Taster zu einem Vektor für einfachere Handhabung, Enable System und Control werden nicht debounced
button_inputs(0) <= SysSW_Pwr_NC;
button_inputs(1) <= FPIO_ExternalStop;

-- Achtung!!! Signal muss noch durch twoStageSynchronizer!!
-- siehe https://www.digikey.com/en/articles/how-to-debounce-a-button-input-using-programmable-logic
-- realisiert 18.11. und getestet
-- 2FF Synchronizer von https://vhdlwhiz.com/snippets/fork-and-join/

process(clk)
    begin
        if rising_edge(clk) then
			--2FF
			button_inputs_asyn1 <= button_inputs;
			button_inputs_asyn2 <= button_inputs_asyn1; 
			-- button_inputs_asyn2 ist safe, keine metastabilität probleme
			
            -- Entprellung für jedes Signal im Vektor
            for i in 0 to 1 loop
                if button_inputs_asyn2(i) = '0' then  -- Taster gedrückt (LOW)
                    if debounce_counters(i) < debounce_limit then
                        debounce_counters(i) <= debounce_counters(i) + 1;
                    else
                        pushed(i) <= '1';  -- Taster gedrückt = True
                    end if;
                else  -- Taster losgelassen (HIGH)
                    debounce_counters(i) <= 0;
                    pushed(i) <= '0';
                end if;
                -- Ausgabe negiert
                if pushed(i) = '1' then
                    buttons_debounced_syn(i) <= '0';
                else
                    buttons_debounced_syn(i) <= '1';
                end if;
            end loop;
        end if;
end process;

-- Taster debouncen
--process(clk)
    --begin
        --if rising_edge(clk) then
             --Entprellung für jedes Signal im Vektor
            --for i in 0 to 2 loop
                --if button_inputs_asyn1(i) = '0' then  -- Taster gedrückt (LOW)
                    --if debounce_counters(i) < debounce_limit then
                        --debounce_counters(i) <= debounce_counters(i) + 1;
                    --else
                        --pushed(i) <= '1';  -- Taster bleibt gedrückt
                    --end if;
                --else  -- Taster losgelassen (HIGH)
                    --debounce_counters(i) <= 0;
                    --pushed(i) <= '0';
                --end if;
                 --Ausgabe negiert
                --if pushed(i) = '1' then
                    --buttons_debounced_syn(i) <= '0';
                --else
                    --buttons_debounced_syn(i) <= '1';
                --end if;
            --end loop;
        --end if;
--end process;

FP_UsrLED1 <= PG_VIN AND PG_Module AND PPn_VIN;
FP_UsrLED2 <= buttons_debounced_syn(0);

-- State machine
process(clk)
    begin
	if rising_edge(clk) then
        case next_state is
            when Waiting_for_Powerbutton_pressed =>
			FlexMIOs53_GPIO_PowerDown <= '0';
			FP_SysLEDr <= '1';	
			FP_SysLEDb <= '0';	
			FP_SysLEDg <= '0';	
			if buttons_debounced_syn(0) = '0' then
				next_state <= Waiting_for_Powerbutton_released;
			else
				Carrier_PwrOn <= '0';  -- Alle Rails aus, nur Systemcpld lebt
				Carrier_PG_3V3 <= '0';
				FPIO_isoCtrlRSTn <= '0'; -- Reset IsoIO einschalten
				Carrier_PG_1V8 <= 'Z';  -- Hochohmig, solange System aus
			end if;

			when Waiting_for_Powerbutton_released =>
			FP_SysLEDr <= '1';	
			FP_SysLEDb <= '0';	
			FP_SysLEDg <= '1';
			if buttons_debounced_syn(0) = '1' then
				Carrier_PwrOn <= '1';  -- Alle Rails enablen
				Carrier_PG_3V3 <= '1'; -- Hack IsoIo ein wenn PwrOn
				counter <= 2080000;
				-- neuer Zustand wenn button ausgelassen
				next_state <= Wait_State;	
			end if;
			
			when Wait_State =>
			FP_SysLEDr <= '1';	
			FP_SysLEDb <= '1';	
			FP_SysLEDg <= '0';
			if counter > 0 then
				counter <= counter - 1;
			else 
				counter <= 104000;
				Carrier_PG_1V8 <= '0';  -- resetn für 50ms auf '0' setzen
				next_state <= EthernetPhy_Reset;
			end if;
			
			when EthernetPhy_Reset =>
            --Übergang in den Ready_State nach Ethernet Reset
			FP_SysLEDr <= '0';	
			FP_SysLEDb <= '1';	
			FP_SysLEDg <= '0';
			if counter > 0 then
				counter <= counter - 1;
			else
				Carrier_PG_1V8 <= 'Z';  -- Nach 50ms wieder auf 'Z' setzen
				FPIO_isoCtrlRSTn <= '1'; -- Reset IsoIO ausschalten
				next_state <= Ready_State;
			end if;
			
            when Ready_State =>
				FP_SysLEDr <= '0';	
				FP_SysLEDb <= '0';	
				FP_SysLEDg <= '1';
				FP_SysLEDs <= '1';
                -- wenn externer Stop gedrückt dann in Shutdown springen
                if buttons_debounced_syn(1) = '0' then  -- Externer STOP-Taster gedrückt
                    next_state <= Error;
				-- TODO auf 1s auf den Powertaster drücken erweitern
                elsif buttons_debounced_syn(0) = '0' then  -- Power Taster gedrückt
					counter <= 4160000;
					next_state <= SoftPowerOff;
				end if;
            when Warning =>
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '0';	
				FP_SysLEDg <= '0';
				FP_SysLEDs <= '0';
                -- Von Warning geht es direkt in PowerOff
 --               next_state <= PowerOff;
            when Error =>
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '1';	
				FP_SysLEDg <= '1';
				FP_SysLEDs <= '0';	
				Carrier_PwrOn <= '0';  -- Alle Rails aus, nur Systemcpld lebt
				Carrier_PG_3V3 <= '0';
				FPIO_isoCtrlRSTn <= '0'; -- Reset IsoIO einschalten
                -- Von Error wechselt das System zu PowerOff
--                next_state <= PowerOff;
			when SoftPowerOff =>
				FlexMIOs53_GPIO_PowerDown <= '1';
				if counter > 0 then
					counter <= counter - 1;
				else
					if buttons_debounced_syn(0) = '0' then
						FlexMIOs53_GPIO_PowerDown <= '0';
						next_state <= PowerOff;
					end if;
				end if;
				if buttons_debounced_syn(0) = '1' then 
					FlexMIOs53_GPIO_PowerDown <= '0';
					next_state <= Ready_State;
				end if;
            when PowerOff =>
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '0';	
				FP_SysLEDg <= '1';
				FP_SysLEDs <= '0';	
                -- Endzustand; das System bleibt hier
				Carrier_PwrOn <= '0';   -- Alle Rails aus, nur Systemcpld lebt
				Carrier_PG_3V3 <= '0';
				FPIO_isoCtrlRSTn <= '0'; -- Reset IsoIO einschalten
				if buttons_debounced_syn(0) = '1' then
					next_state <= Waiting_for_Powerbutton_pressed;
				end if;
            when others =>
                next_state <= Waiting_for_Powerbutton_pressed;
        end case;
	end if;
end process;
end behavior;