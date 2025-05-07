library IEEE;
library machxo2;
use machxo2.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Powerup_V0 is
    Port (
        SysSW_Pwr_NC 	: 		in  STD_LOGIC;  -- Eingang durch Powerbutton
        Carrier_PwrOn 	: out STD_LOGIC;   -- Ausgang (schalte alle Rails an)
		Carrier_PG_1V8			: out STD_LOGIC := 'Z';  -- ResetN Port, Powergood 1.8V
		SD_Select 		: out STD_LOGIC := '0'; -- Signal, dass auf 0 getrieben werden soll
		FlexMIOs52_PCIe	: in  STD_LOGIC; -- Durchrouten zu FrontpanelIO.FlexMIO52_PCIe-R¯S¯T¯, invertierung in PS
		FPIO_FlexMIO52 	: out STD_LOGIC; -- wird in ps invertiert, FlexMIOs52_PCIe durchgeroutet
		FPIO_ExternalStop	: in  STD_LOGIC; -- FP Externer Stop taster
		FlexMio61ExternalStop 	: out STD_LOGIC; -- ExternalStop durchgeroutet
		FP_UsrLED1		: out STD_LOGIC; -- LED 1 FP
		FP_UsrLED2		: out STD_LOGIC; -- LED 2 FP
		FP_UsrLED3		: out STD_LOGIC; -- LED 3 FP
		FP_UsrLED4		: out STD_LOGIC; -- LED 4 FP
		FP_SysLEDg		: out STD_LOGIC; -- LED grün Powertaster
		FP_SysLEDr		: out STD_LOGIC; -- LED rot Powertaster
		FP_SysLEDb		: out STD_LOGIC  -- LED blau Powertaster
    );
	
end Powerup_V0;


architecture behavior of Powerup_V0 is
signal clk	:	STD_LOGIC;
signal count_100ms : integer range 0 to 256000 := 0; 	-- Zähler für 100ms -> Powergood 1.8V ist high
signal count_50ms  : integer range 0 to 128000 := 0; 	-- Zähler für 50ms -> Powergood 1,8V ist low
signal count_done_100ms : boolean := false; 			-- Flag für 100ms Ende
signal reset_triggered : boolean := false; -- Flag, um zu tracken, dass resetn auf '0' gesetzt wurde

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
-- Ports default auf einen Wert zu setzen oder einfach durchzurouten
SD_Select <= '0';
FPIO_FlexMIO52 <= FlexMIOs52_PCIe;
FlexMio61ExternalStop <= FPIO_ExternalStop;

-- Prozess für Power: Wenn Taster nicht gedrückt(NC=>1), ist UZ an
	process(SysSW_Pwr_NC)
    begin
        if SysSW_Pwr_NC = '1' then
            Carrier_PwrOn <= '1';  -- Alle Rails enablen
        else
            Carrier_PwrOn <= '0';  -- Alle Rails aus, nur Systemcpld lebt
        end if;
    end process;
	
-- Prozess für Zähler und Powergood/Ethernetphyreset-Steuerung
    process(clk)
    begin
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
    end process;
end behavior;
