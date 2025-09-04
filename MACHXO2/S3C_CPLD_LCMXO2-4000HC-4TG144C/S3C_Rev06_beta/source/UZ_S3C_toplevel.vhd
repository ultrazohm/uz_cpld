library IEEE;
library machxo2;
use machxo2.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Soft_Off_V0 is
    generic (
        CLK_FREQ_HZ : integer := 2080000;  	-- CLK - 2.08 MHz
        TICK_US     : integer := 1000      	-- Tickdauer in µs (1000 = 1 ms)	
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
		FPIO_iosCtrlINTn	: 	in  STD_LOGIC;
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
		S3C_S1 			: in STD_LOGIC		-- pin 10, pulldown
    );
	
end Soft_Off_V0;

architecture behavior of Soft_Off_V0 is
	signal clk	:	STD_LOGIC;
	signal counter : integer range 0 to 31200000 := 0; 	-- counter 
	signal count_done_100ms : boolean := false; 			-- flag for 100ms end
	signal reset_triggered : boolean := false; -- flag, to track resetn is zero

    -- states in statemachine
    type state_type is (
		Soft_Off,
		WaitFor_PowerbuttonRelease_Bootup, Wait_State, EthernetPhy_Reset,
		Ack_previous_Harderror, Ack_bootup_Harderror,
		Ready_State, Warning_State, Softerror,
		Harderror_1ReqSafe, Harderror_2SoftOff,
		Wait_for_PowerbuttonPressed2sec, sleep_for_dslot_down, Wait_for_PowerbuttonReleased_Powerdown
	);
    signal next_state : state_type:= Soft_Off;
	
	-- error type definitions (currently hard errors only)
	type error_type is (NoError, TemperatureShutdown, ExternalStop, SlotError, SupplyFailure);
	signal lasterror : error_type;

    -- debounceconstant
    constant debounce_limit : integer := 20800; -- 10ms, at 2.08MhZ

    -- debounce counter and vectors for debouncing
    type debounce_array is array (1 to 6) of integer;
    signal debounce_counters : debounce_array := (others => 0);
	signal debounce_inputs  : STD_LOGIC_VECTOR(6 downto 1);  -- inputs
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
	GENERIC (NOM_FREQ: string := "2.08");
	-- synthesis translate_on
	PORT (
		STDBY	:	IN	std_logic;
		OSC		:	OUT	std_logic;
		SEDSTDBY:	OUT	std_logic);
	END COMPONENT;
	attribute NOM_FREQ 	: string;
	attribute NOM_FREQ of OSCinst0 : label is "2.08";
	attribute HGROUP 	: string;
	signal dummy_signal : std_logic;
	attribute syn_keep : boolean;
	attribute noclip   : string;
	attribute noclip of dummy_signal  : signal is "on";
	attribute syn_keep of dummy_signal : signal is true;
	-- signals for tick creation
	constant TICKS_PER_PERIOD : integer := CLK_FREQ_HZ / (1_000_000 / TICK_US);
	signal tickcounter : integer range 0 to TICKS_PER_PERIOD-1 := 0;
	signal tick1ms		: STD_LOGIC;
	-- interne Signale für Counter
	signal start_50ms     : std_logic := '0';
	signal ready_50ms     : std_logic;
	signal start_1000ms   : std_logic := '0';
	signal ready_1000ms   : std_logic;

begin
	OSCInst0: OSCH
	-- synthesis translate_off
	GENERIC MAP( NOM_FREQ => "2.08" )
	-- synthesis translate_on
	PORT MAP (STDBY=> '0',
	OSC => clk,
	SEDSTDBY => open
	);

-- Instanzen
--u_cnt50 : entity work.tick_counter
    --generic map (COUNTER_LIMIT => 50)
    --port map (
        --clk     => clk,
        --tick_in => tick1ms,
        --done    => done_50ms
    --);

--u_cnt1000 : entity work.tick_counter
    --generic map (COUNTER_LIMIT => 1000)
    --port map (
        --clk     => clk,
        --tick_in => tick1ms,
        --done    => done_1000ms
    --);	
u_cnt50 : entity work.tick_counter_v2
    generic map (COUNTER_LIMIT => 50)
    port map (
        clk     => clk,
        tick_in => tick1ms,
        start   => start_50ms,
        ready   => ready_50ms
    );

u_cnt1000 : entity work.tick_counter_v2
    generic map (COUNTER_LIMIT => 1000)
    port map (
        clk     => clk,
        tick_in => tick1ms,
        start   => start_1000ms,
        ready   => ready_1000ms
    );
--Dummy
dummy_signal <= TDnALERT AND TDnFFnFS AND TDnSHDN and ANL_S3C_P54_Legacy AND ANL_S3C_SLOTOK(1) AND ANL_S3C_SLOTOK(2) AND ANL_S3C_SLOTOK(3)  
AND DIGS3C_SlotD_SlotOK(1) AND DIGS3C_SlotD_SlotOK(2) AND DIGS3C_SlotD_SlotOK(3) AND DIGS3C_SlotD_SlotOK(4) AND DIGS3C_SlotD_SlotOK(5)
AND DIG5S3C00 AND DIG5S3C01 AND DIG5S3C02 AND DIG5S3C03 AND DIG5S3C04 AND DIG5S3C05
AND DIG5S3C24 AND DIG5S3C25 AND DIG5S3C26 AND DIG5S3C27 AND DIG5S3C28 AND DIG5S3C29
AND FPIO_FlexMIO27 AND FPIO_FlexMIO28 AND FPIO_FlexMIO29 AND FPIO_FlexMIO30
AND FPIO_iosCtrlINTn AND FP_UsrSW2 AND FlexIO03 and FlexIO04
AND FLexLIO(0) AND FLexLIO(1) AND FLexLIO(2) AND FLexLIO(3) AND FLexLIO(4) AND FLexLIO(5)
AND FlexMIOs26 AND FlexMIOs27 AND FlexMIOs28 AND FlexMIOs29 AND FlexMIOs30 AND FlexMIOs31
AND FlexMIOs32 AND FlexMIOs33 AND FlexMIOs34 AND FlexMIOs35 AND FlexMIOs36 AND FlexMIOs37
AND FlexMIOs45 AND FlexMIOs54 AND FlexMIOs62 AND FlexMIOs63 AND PG_Module 
AND S3C_S1 AND S3CsI2C_SCL AND S3CsI2C_SDA
AND SCL AND SD0_CD AND SD1_CD AND SDA AND SPI_S3C_nCS_USR;

tristate_signals <= DIG5S3C00 & DIG5S3C01 & DIG5S3C02 & DIG5S3C03 & DIG5S3C04  & DIG5S3C05
& DIG5S3C24 & DIG5S3C25 & DIG5S3C26 & DIG5S3C27 & DIG5S3C28 & DIG5S3C29 
& FlexMIOs26 & FlexMIOs27 & FlexMIOs28 & FlexMIOs29 & FlexMIOs30 & FlexMIOs31
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
-- debounce process
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
-- process tick 1ms
process(clk)
begin
	if rising_edge(clk) then
		if tickcounter = TICKS_PER_PERIOD-1 then
			tickcounter <= 0;
			tick1ms <= '1';
		else
			tickcounter <= tickcounter  + 1;
			tick1ms <= '0';
		end if;
	end if;
end process;

-- State machine
process(clk)

-- error handling
	procedure show_harderror (
		constant error : in error_type
	) is
	begin
		case error is
			when NoError => FP_UsrLED <= "0000";
			when ExternalStop => FP_UsrLED <= "1100";
			when SupplyFailure => FP_UsrLED <= "0110";
			when TemperatureShutdown => FP_UsrLED <= "1111";
			when SlotError => FP_UsrLED <= "0101";
			when others => FP_UsrLED <= "0000";
		end case;
	end procedure;

	impure function get_harderror return error_type is
	begin
		if pg10v = '0' then  
			return(SupplyFailure);
		elsif externstop_falling = '1' then  					-- edge-based (? check is always active)
			return(ExternalStop);
		elsif extern_connected='1' AND stopextern = '1' then	-- level-based (iff previously detected)
			return(ExternalStop);
		else
			return(NoError);
		end if;
	end function;

	procedure enter_errorstate (
		constant error_reason : in error_type
	) is
	begin
		if error_reason /= NoError then

			counter <= 31200000/3;
			next_state <= Harderror_1ReqSafe;

			case error_reason is
				when NoError =>
				when ExternalStop =>
					extern_connected <= '1';	-- bit to store if external stop was connected
				when SupplyFailure =>
				--when TemperatureShutdown =>
				--when SlotError =>
			end case;
		end if;

		lasterror <= error_reason;
	end procedure;

	procedure checkandhandle_harderror is
		variable current_error : error_type;
	begin
		current_error := get_harderror;

		show_harderror(current_error);
		enter_errorstate(current_error);
	end procedure;

-- state machine start
	begin


	if rising_edge(clk) then
	start_50ms   <= '0';
    start_1000ms <= '0';
        case next_state is
            when Soft_Off =>
				forceoutputdisable <= '1';
				DIGS3C_Shared_ReqSafeState <= '1'; -- not working because bank 1 1.8vper not supplied
				FlexMIOs53_GPIO_PowerDown <= '0';
				FP_SysLEDr <= '0';	
				FP_SysLEDb <= '1';	
				FP_SysLEDg <= '0';	
				if power = '1' then
					next_state <= WaitFor_PowerbuttonRelease_Bootup;
				else
					Carrier_PwrOn <= '0';  -- all rails down, only s3c alive
					Carrier_PG_3V3 <= '0';
					FPIO_isoCtrlRSTn <= '0'; -- reset IsoIO enable
					Carrier_PG_1V8 <= 'Z';  -- tristate as long as system is down
				end if;

			when WaitFor_PowerbuttonRelease_Bootup =>
				forceoutputdisable <= '1';
				DIGS3C_Shared_ReqSafeState <= '1'; -- not working because bank 1 1.8vper not supplied
				FP_SysLEDr <= '0';	
				FP_SysLEDb <= '1';	
				FP_SysLEDg <= '1';
				if power = '0' AND tick1ms = '1' then
					Carrier_PwrOn <= '1';  -- enables all rails
					Carrier_PG_3V3 <= '1'; -- Hack IsoIo on, if power on
					next_state <= Wait_State;
					start_1000ms <= '1';   -- Counter gleich starten
				end if;

			when Wait_State =>
				forceoutputdisable <= '1';
				DIGS3C_Shared_ReqSafeState <= '1'; -- not working because bank 1 1.8vper not supplied
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '1';	
				FP_SysLEDg <= '0';
				if ready_1000ms = '1' then
					Carrier_PG_1V8 <= '0';  -- resetn for 50ms to zero
					next_state <= EthernetPhy_Reset;
					start_50ms <= '1';     -- Counter für Reset starten
				end if;

			when EthernetPhy_Reset =>
				forceoutputdisable <= '1';
				DIGS3C_Shared_ReqSafeState <= '1'; -- not working because bank 1 1.8vper not supplied
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '1';	
				FP_SysLEDg <= '1';
				if ready_50ms = '1' then
					-- Init complete
					Carrier_PG_1V8 <= 'Z';  -- after 50 ms tristate
					FPIO_isoCtrlRSTn <= '1'; -- reset IsoIO off
					
					if lasterror /= NoError then
						next_state <= Ack_previous_Harderror;
					elsif get_harderror /= NoError then
						next_state <= Ack_bootup_Harderror;
					else
						next_state <= ready_state;
					end if;
				end if;
			when Ack_previous_Harderror =>
				-- Blinky
				if counter > 0 then
					counter <= counter - 1;
				else
					counter <= 8*104000;
				end if;
				if counter > 2*104000 then
						FP_SysLEDr <= '1';
						FP_SysLEDb <= '1';
					else
						FP_SysLEDr <= '0';
						FP_SysLEDb <= '0';
					end if;
				FP_SysLEDg <= '0';

				show_harderror(lasterror);
				if lasterror /= NoError then
						if power = '1' then
						lasterror <= NoError;

						if get_harderror = NoError then
							show_harderror(NoError);
							next_state <= Wait_for_PowerbuttonReleased_Powerdown;
						else
							next_state <= Ack_bootup_Harderror;
				
						end if;
						end if;
				else	
						if power = '1' then
						lasterror <= NoError;

						if get_harderror = NoError then
							show_harderror(NoError);
							next_state <= ready_state;
						else
							next_state <= Ack_bootup_Harderror;
				
						end if;
						end if;
				end if;

			when Ack_bootup_Harderror =>
				-- Blinky
				FP_SysLEDr <= '1';
				FP_SysLEDb <= '1';
				FP_SysLEDg <= '0';

				show_harderror(get_harderror);
				if get_harderror = NoError AND power = '1' then
					next_state <= Wait_for_PowerbuttonReleased_Powerdown;
				end if;


            when ready_state =>
				forceoutputdisable <= NOT PPn_VIN; -- noch zu messen, evtl durch debounce version ersetzen
				DIGS3C_Shared_ReqSafeState <= '0';
				FP_SysLEDr <= '0';
				FP_SysLEDb <= '0';
				FP_SysLEDg <= '1';
				FP_SysLEDs <= '1';

				if stop = '1' then  
                    next_state <= Softerror;
				elsif warning = '1' then
					next_state <= Warning_State;
                elsif power = '1' then 
					counter <= 4160000;
					next_state <= Wait_for_PowerbuttonPressed2sec;
				end if;
				checkandhandle_harderror;

            when warning_state =>
				forceoutputdisable <= NOT PPn_VIN; -- noch zu messen, evtl durch debounce version ersetzen
				DIGS3C_Shared_ReqSafeState <= '0';
				FP_SysLEDr <= '0';	
				FP_SysLEDb <= '1';	
				FP_SysLEDg <= '0';
				FP_SysLEDs <= '0';

				if stop = '1' then  
                    next_state <= Softerror;
                elsif power = '1' then 
					counter <= 4160000;
					next_state <= Wait_for_PowerbuttonPressed2sec;
				end if;
				checkandhandle_harderror;

            when Harderror_1ReqSafe =>
				--Request safe state to dslots
				forceoutputdisable <= NOT PPn_VIN; -- noch zu messen, evtl durch debounce version ersetzen
				DIGS3C_Shared_ReqSafeState <= '1';
				FlexMIOs53_GPIO_PowerDown <= '1';  -- info to som, power linux down;

				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '0';	
				FP_SysLEDg <= '0';
				FP_SysLEDs <= '1';
				if counter > 0 then
					counter <= counter - 1;
				else
					Carrier_PwrOn <= '0';  -- all rails down, only s3c alive
					Carrier_PG_3V3 <= '0';
					FPIO_isoCtrlRSTn <= '0'; -- reset IsoIO on
					next_state <= Harderror_2SoftOff;
				end if;

			when Harderror_2SoftOff =>
				forceoutputdisable <= '1';
				DIGS3C_Shared_ReqSafeState <= '1'; -- not working because bank 1 1.8vper not supplied
				FlexMIOs53_GPIO_PowerDown <= '0';
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '1';	
				FP_SysLEDg <= '0';
				if power = '1' then
					next_state <= WaitFor_PowerbuttonRelease_Bootup;
				else
					Carrier_PwrOn <= '0';  -- all rails down, only s3c alive
					Carrier_PG_3V3 <= '0';
					FPIO_isoCtrlRSTn <= '0'; -- reset IsoIO enable
					Carrier_PG_1V8 <= 'Z';  -- tristate as long as system is down
				end if;

			when Softerror =>
				--Request safe state to dslots
				forceoutputdisable <= NOT PPn_VIN; -- noch zu messen, evtl durch debounce version ersetzen
				DIGS3C_Shared_ReqSafeState <= '1';
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '1';	
				FP_SysLEDg <= '1';
				FP_SysLEDs <= '1';

				if power = '1' then
				 -- Powerbutton im Softerror startet immer nur die Shutdown-Sequenz
					FlexMIOs53_GPIO_PowerDown <= '0'; -- end info to som
					counter <= 2080000;
					next_state <= sleep_for_dslot_down;
				elsif enable = '1' then 
					next_state <= Ready_State;
				end if;
				checkandhandle_harderror;

			when Wait_for_PowerbuttonPressed2sec =>
				forceoutputdisable <= NOT PPn_VIN; -- noch zu messen, evtl durch debounce version ersetzen
				DIGS3C_Shared_ReqSafeState <= '0';
				FlexMIOs53_GPIO_PowerDown <= '1';  -- info to som, power linux down;
				if counter > 0 then
					counter <= counter - 1;
				else
					if power = '1' then -- override mode activated
						FlexMIOs53_GPIO_PowerDown <= '0'; -- end info to som
						DIGS3C_Shared_ReqSafeState <= '1'; -- info to dcplds
						counter <= 2080000;
						next_state <= sleep_for_dslot_down;
					end if;
				end if;
				if power = '0' then 
					FlexMIOs53_GPIO_PowerDown <= '0';
					next_state <= Ready_State;
				end if;
				checkandhandle_harderror;

			when sleep_for_dslot_down =>
				if counter > 0 then
					counter <= counter - 1;
				else
					next_state <= Wait_for_PowerbuttonReleased_Powerdown;
				end if;
				checkandhandle_harderror;

            when Wait_for_PowerbuttonReleased_Powerdown =>
				forceoutputdisable <= '1'; 
				FP_SysLEDr <= '1';	
				FP_SysLEDb <= '0';	
				FP_SysLEDg <= '1';
				FP_SysLEDs <= '0';	
				Carrier_PwrOn <= '0'; -- all rails down, only s3c alive
				Carrier_PG_3V3 <= '0';
				FPIO_isoCtrlRSTn <= '0'; -- reset IsoIO on
				if power = '0' then
					next_state <= Soft_Off;
				end if;

            when others =>
                next_state <= Soft_Off;
        end case;
	end if;
end process;
end behavior;