library IEEE;
library machxo2;
use machxo2.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Waiting_for_Powerbutton_pressed_V0 is
    Port (
		-- Mapping nach Bänken
		--- Bank 0, 3.3V
		FP_SysLEDg		: out STD_LOGIC; -- LED grün Power, PIN 141
		FP_SysLEDr		: out STD_LOGIC; -- LED rot Power, PIN 142
		FP_SysLEDb		: out STD_LOGIC;  -- Power, PIN 143		
		Carrier_PG_3V3	: out STD_LOGIC := 'Z';  -- Powergood 3.3V, PIN 115
		FPIO_FlexMIO52 	: out STD_LOGIC; -- wird in ps invertiert, FlexMIOs52_PCIe durchgeroutet, PIN 109	
		FPIO_ExternalStop	: in  STD_LOGIC; -- FP Externer Stop taster, PIN 114
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
		PG_Module 		: in STD_LOGIC		-- PIN 9
    );
	
end Waiting_for_Powerbutton_pressed_V0;

architecture behavior of Waiting_for_Powerbutton_pressed_V0 is
	signal clk	:	STD_LOGIC;
	signal counter : integer range 0 to 2080000 := 0; 	-- Zähler 
	signal count_done_100ms : boolean := false; 			-- Flag für 100ms Ende
	signal reset_triggered : boolean := false; -- Flag, um zu tracken, dass resetn auf '0' gesetzt wurde

    -- Definition der Zustände der State Machine
    type state_type is (Waiting_for_Powerbutton_pressed,Waiting_for_Powerbutton_released,Wait_State, EthernetPhy_Reset, Ready_State, Error_State, Shutdown_Extern, Powerdown);
    signal next_state : state_type:= Waiting_for_Powerbutton_pressed;
	
    -- Entprell-Zeitkonstante
    constant debounce_limit : integer := 20800; -- 10ms, bei 2.08MhZ

    -- Entprell-Zähler und stabile Zustände der Taster
    type debounce_array is array (0 to 2) of integer;
    signal debounce_counters : debounce_array := (others => 0);
    signal button_inputs  : STD_LOGIC_VECTOR(2 downto 0);  -- Tastereingänge
	signal pushed : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal buttons_debounced    : STD_LOGIC_VECTOR(2 downto 0) := (others => '1');

	-- internen oszillator definieren
	COMPONENT OSCH
	-- synthesis translate_off
	GENERIC (NOM_FREQ: string := "2.08");
	-- synthesis translate_on
	PORT (
		STDBY	:	IN	std_logic;
		OSC		:	OUT	std_logic;
		SEDSTDBY:	OUT	std_logic);
	END COMPONENT;
attribute NOM_FREQ : string;
attribute NOM_FREQ of OSCinst0 : label is "2.08";


begin
	OSCInst0: OSCH
	-- synthesis translate_off
	GENERIC MAP( NOM_FREQ => "2.08" )
	-- synthesis translate_on
	PORT MAP (STDBY=> '0',
	OSC => clk,
	SEDSTDBY => open
	);
	
-- Ports default setzen + durchrouten
SD_SEL <= '0';
FPIO_FlexMIO52 <= FlexMIOs52_PCIe;
FlexMio61ExternalStop <= FPIO_ExternalStop;

-- Mapping der Taster zu einem Vektor für einfachere Handhabung, Enable System und Control werden nicht debounced
button_inputs(0) <= SysSW_Pwr_NC;
button_inputs(1) <= FP_UsrSW3;
button_inputs(2) <= FPIO_ExternalStop;

-- Achtung!!! Signal muss noch durch twoStageSynchronizer!!
-- siehe https://www.digikey.com/en/articles/how-to-debounce-a-button-input-using-programmable-logic
-- 2FF Synchronizer

-- Taster debouncen
process(clk)
    begin
        if rising_edge(clk) then
            -- Entprellung für jedes Signal im Vektor
            for i in 0 to 2 loop
                if button_inputs(i) = '0' then  -- Taster gedrückt (LOW)
                    if debounce_counters(i) < debounce_limit then
                        debounce_counters(i) <= debounce_counters(i) + 1;
                    else
                        pushed(i) <= '1';  -- Taster bleibt gedrückt
                    end if;
                else  -- Taster losgelassen (HIGH)
                    debounce_counters(i) <= 0;
                    pushed(i) <= '0';
                end if;
                -- Ausgabe negiert
                if pushed(i) = '1' then
                    buttons_debounced(i) <= '0';
                else
                    buttons_debounced(i) <= '1';
                end if;
            end loop;
        end if;
end process;

FP_UsrLED1 <= button_inputs(2);
FP_UsrLED2 <= buttons_debounced(2);
-- State machine
process(clk)
    begin
	if rising_edge(clk) then
        case next_state is
            when Waiting_for_Powerbutton_pressed =>
			FP_SysLEDr <= '1';	
			FP_SysLEDb <= '0';	
			FP_SysLEDg <= '0';	
			if buttons_debounced(0) = '0' then
				next_state <= Waiting_for_Powerbutton_released;
			else
				Carrier_PwrOn <= '0';  -- Alle Rails aus, nur Systemcpld lebt
				Carrier_PG_3V3 <= '0';
				Carrier_PG_1V8 <= 'Z';  -- Hochohmig, solange System aus
			end if;

			when Waiting_for_Powerbutton_released =>
			FP_SysLEDr <= '1';	
			FP_SysLEDb <= '0';	
			FP_SysLEDg <= '1';
			if buttons_debounced(0) = '1' then
				Carrier_PwrOn <= '1';  -- Alle Rails enablen
				Carrier_PG_3V3 <= '1'; -- Hack IsoIo ein wenn PwrOn
				counter <= 2080000;
				-- neuer Zustand wenn button ausgelassen
				next_state <= Wait_State;	
			end if;
			
			when Wait_State =>
			FP_SysLEDr <= '0';	
			FP_SysLEDb <= '1';	
			FP_SysLEDg <= '0';
			if counter > 0 then
				counter <= counter - 1;
			else
				next_state <= Ready_State;
			end if;
			
            when EthernetPhy_Reset =>
            -- Übergang in den Ready_State nach Ethernet Reset
			--FP_SysLEDr <= '0';	
			--FP_SysLEDb <= '1';	
			--FP_SysLEDg <= '0';
			--if not count_done_100ms then
				 --Zähle zuerst 100ms
				--if count_100ms < 256000 then
					--count_100ms <= count_100ms + 1;
				--else
					--count_done_100ms <= true;  -- 100ms abgelaufen, Zähler für 50ms starten
					--Carrier_PG_1V8 <= '0';  -- resetn für 50ms auf '0' setzen
					--FP_SysLEDr <= '1';	
				--end if;
			--elsif count_done_100ms and not reset_triggered then
				 --Zähle 50ms, nachdem 100ms abgelaufen sind
				--if count_50ms < 128000 then
					--count_50ms <= count_50ms + 1;
				--else
					--Carrier_PG_1V8 <= 'Z';  -- Nach 50ms wieder auf 'Z' setzen
					--reset_triggered <= true;  -- Markiere, dass resetn auf 'Z' gesetzt wurde
					--next_state <= Ready_State;
				--end if;
			--end if;	
			
            when Ready_State =>
				FP_SysLEDr <= '0';	
				FP_SysLEDb <= '0';	
				FP_SysLEDg <= '1';	
                -- wenn externer Stop gedrückt dann in Shutdown springen
                if buttons_debounced(2) = '0' then  -- Externer STOP-Taster gedrückt
                    next_state <= Shutdown_Extern;
				-- wenn Stop gedrückt dann in Error springen
                elsif buttons_debounced(1) = '0' then  -- STOP-Taster gedrückt
                    next_state <= Error_State;
				-- TODO auf 1s auf den Powertaster drücken erweitern
                elsif buttons_debounced(0) = '0' then  -- Power Taster gedrückt
                    next_state <= Powerdown;
                end if;
            when Error_State =>
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '0';	
				FP_SysLEDg <= '0';	
                -- Von Error_State geht es direkt in Powerdown
 --               next_state <= Powerdown;
            when Shutdown_Extern =>
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '1';	
				FP_SysLEDg <= '1';	
				Carrier_PwrOn <= '0';  -- Alle Rails aus, nur Systemcpld lebt
				Carrier_PG_3V3 <= '0';
                -- Von Shutdown_Extern wechselt das System zu Powerdown
--                next_state <= Powerdown;
            when Powerdown =>
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '0';	
				FP_SysLEDg <= '1';	
                -- Endzustand; das System bleibt hier
				Carrier_PwrOn <= '0';   -- Alle Rails aus, nur Systemcpld lebt
				Carrier_PG_3V3 <= '0';
				if buttons_debounced(0) = '1' then
					next_state <= Waiting_for_Powerbutton_pressed;
				end if;
            when others =>
                next_state <= Waiting_for_Powerbutton_pressed;
        end case;
	end if;
end process;

end behavior;