library IEEE;
library machxo2;
use machxo2.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Powerup_V0 is
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
	
end Powerup_V0;

architecture behavior of Powerup_V0 is
	signal clk	:	STD_LOGIC;
	signal count_100ms : integer range 0 to 208000 := 0; 	-- Zähler für 100ms -> Powergood 1.8V ist high
	signal count_50ms  : integer range 0 to 104000 := 0; 	-- Zähler für 50ms -> Powergood 1,8V ist low
	signal count_done_100ms : boolean := false; 			-- Flag für 100ms Ende
	signal reset_triggered : boolean := false; -- Flag, um zu tracken, dass resetn auf '0' gesetzt wurde
	signal power_on			: boolean := false; -- Flag ob Powertaster gedrückt wurde
	signal count_1000ms  : integer range 0 to 2080000 := 0; 	-- Zähler für 1000ms -> 1 Sekunde in jedem state

    -- Definition der Zustände der State Machine
    type state_type is (Powerup, EthernetPhy_Reset, Safe_State, Error_State, Shutdown_Extern, Powerdown);
    signal current_state, next_state : state_type;

    -- Entprell-Zeitkonstante
    constant debounce_limit : integer := 20800; -- 10ms, bei 2.08MhZ

    -- Entprell-Zähler und stabile Zustände der Taster
    type debounce_array is array (0 to 3) of integer;
    signal debounce_counters : debounce_array := (others => 0);
    signal button_inputs  : STD_LOGIC_VECTOR(3 downto 0);  -- Tastereingänge
	signal stable_state : STD_LOGIC_VECTOR(3 downto 0) := (others => '1');
    signal debounced    : STD_LOGIC_VECTOR(3 downto 0) := (others => '1');
    signal button_debounced : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');  -- Entprellte Ausgänge

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

-- Mapping der Taster zu einem Vektor für einfachere Handhabung
button_inputs <= SysSW_Pwr_NC & FP_UsrSW1 & FP_UsrSW2 & FP_UsrSW3;

-- Prozess für Taster debouncen und Power enablen
process(clk, PG_Module)
    begin
        if PG_Module = '0' then
            debounce_counters <= (others => 0);
            button_debounced <= (others => '1');
			
        elsif rising_edge(clk) then
            -- Entprellung für jedes Signal im Vektor
            for i in 0 to 3 loop
                if button_inputs(i) = '0' then  -- Taster gedrückt (LOW)
                    if debounce_counters(i) < debounce_limit then
                        debounce_counters(i) <= debounce_counters(i) + 1;
                    else
                        stable_state(i) <= '0';  -- Taster bleibt gedrückt
                    end if;
                else  -- Taster losgelassen (HIGH)
                    debounce_counters(i) <= 0;
                    stable_state(i) <= '1';
                end if;

                -- Ausgabe nur dann setzen, wenn entprellter Zustand LOW ist
                if stable_state(i) = '0' then
                    debounced(i) <= '0';
                else
                    debounced(i) <= '1';
                end if;
            end loop;
            button_debounced <= debounced; -- Setze die entprellten Signale als Ausgang
        end if;
end process;

-- Zustandsübergänge und Aktionen
process(current_state, button_debounced)
    begin
        next_state <= current_state;  -- Standardzuweisung, um unerwünschte Latchs zu vermeiden
        case current_state is
            when Powerup =>
			if button_debounced(0) = '0' then
				Carrier_PwrOn <= '1';  -- Alle Rails enablen
			else
				Carrier_PwrOn <= '0';  -- Alle Rails aus, nur Systemcpld lebt
			end if;
                -- Übergang zu EthernetPhy_Reset nach Initialisierung
                next_state <= EthernetPhy_Reset;

            when EthernetPhy_Reset =>
                -- Übergang in den Safe_State nach Ethernet Reset
			if rising_edge(clk) then
            if not count_done_100ms then
                -- Zähle zuerst 100ms
                if count_100ms < 256000 then
                    count_100ms <= count_100ms + 1;
                else
                    count_done_100ms <= true;  -- 100ms abgelaufen, Zähler für 50ms starten
					Carrier_PG_1V8 <= '0';  -- resetn für 50ms auf '0' setzen
					FP_UsrLED1 <= '1'; -- led an wenn reset
                end if;
            elsif count_done_100ms and not reset_triggered then
                -- Zähle 50ms, nachdem 100ms abgelaufen sind
                if count_50ms < 128000 then
                    count_50ms <= count_50ms + 1;
                else
                    Carrier_PG_1V8 <= 'Z';  -- Nach 50ms wieder auf 'Z' setzen
                    reset_triggered <= true;  -- Markiere, dass resetn auf 'Z' gesetzt wurde
					FP_UsrLED1 <= '0';
                end if;
            end if;
        end if;
                next_state <= Safe_State;

            when Safe_State =>
					FP_UsrLED1  <=  '1';
					FP_UsrLED2  <=  '1';
					FP_UsrLED3  <=  '1';
					FP_UsrLED4  <=  '1';
					
					if power_on = true then  -- Powertaster gedrückt
						Carrier_PwrOn <= '1';  -- Alle Rails enablen
					else
						Carrier_PwrOn <= '0';  -- Alle Rails aus, nur Systemcpld lebt
					end if;
                -- Integriere die Tasterlogik: Stop- und Power-Taster steuern Übergänge
                if button_debounced(1) = '0' then  -- STOP-Taster gedrückt
                    next_state <= Error_State;
                end if;
            when Error_State =>
                -- Von Error_State geht es zurück zu Powerdown oder Shutdown
                next_state <= Powerdown;
            when Shutdown_Extern =>
                -- Von Shutdown_Extern wechselt das System zu Powerdown
                next_state <= Powerdown;
            when Powerdown =>
                -- Endzustand; das System bleibt hier
				Carrier_PwrOn <= '0';   -- Alle Rails aus, nur Systemcpld lebt
                next_state <= Powerdown;
            when others =>
                next_state <= Powerdown;
        end case;
end process;

end behavior;