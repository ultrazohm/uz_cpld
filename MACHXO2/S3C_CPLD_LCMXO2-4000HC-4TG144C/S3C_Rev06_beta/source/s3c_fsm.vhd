LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY s3c_fsm IS
	PORT (
		clk:						IN STD_LOGIC;
		rst:						IN STD_LOGIC;
		tick1ms:					IN STD_LOGIC;

		---- UI
		-- Inputs
		power:						IN STD_LOGIC;
		stop:						IN STD_LOGIC;
		enable:						IN STD_LOGIC;
		externstop:					IN STD_LOGIC;

		-- Outputs
		FP_SysLEDr:					OUT STD_LOGIC;
		FP_SysLEDb:					OUT STD_LOGIC;
		FP_SysLEDg:					OUT STD_LOGIC;
		FP_SysLEDs:					OUT STD_LOGIC;
		FP_UsrLED:					OUT STD_LOGIC_VECTOR(4 DOWNTO 1);

		-- Internal
		power_pressededge:			IN STD_LOGIC;
		power_pushed2sec:			IN STD_LOGIC := '0';

		---- CC
		-- Inputs
		pg10v:						IN STD_LOGIC;
		ppn6v:						IN STD_LOGIC;
		PPn_VIN:					IN STD_LOGIC;

		-- Outputs
		Carrier_PwrOn:				OUT STD_LOGIC;
		Carrier_PG_3V3:				OUT STD_LOGIC;
		Carrier_PG_1V8:				OUT STD_LOGIC := 'Z';
		FPIO_isoCtrlRSTn:			OUT STD_LOGIC;
		FlexMIOs53_GPIO_PowerDown:	OUT STD_LOGIC;
		DIGS3C_Shared_ReqSafeState:	OUT STD_LOGIC;

		-- Internal
		forceoutputdisable:			OUT STD_LOGIC
	);
END s3c_fsm;

ARCHITECTURE fsm_arch OF s3c_fsm IS

	TYPE state_type IS (
		WaitForSupply,
		Soft_Off,
		Wait_State, EthernetPhy_Reset,
		Ack_previous_Harderror, Ack_bootup_Harderror,
		Ready_State, Warning_State, Softerror,
		Harderror,
		sleep_for_dslot_down
	);
	CONSTANT fsm_init:	state_type := WaitForSupply;

	SIGNAL fsm_state:	state_type;
	ATTRIBUTE syn_encoding:	STRING;
	ATTRIBUTE syn_encoding OF fsm_state:	SIGNAL IS "safe,gray";	-- NB: Do not use one-hot encoding with LSE (due to initial reg state) - "sequential" should be an alternative choice with slightly different resource demand...

	SIGNAL counter:	INTEGER RANGE 0 TO 5_000 := 0;

	-- error type definitions (currently hard errors only)
	TYPE error_type IS (NoError, TemperatureShutdown, ExternalStop, SlotError, SupplyFailure);
	SIGNAL lasterror:				error_type := NoError;
	SIGNAL harderror_duringbootup:	STD_LOGIC  := '0';

	-- External Stop: "Is one connected" detection
	SIGNAL externstop_wasfound:		STD_LOGIC := '0';

	SIGNAL warning:					STD_LOGIC;

BEGIN

	warning <= '0';					-- hardcoded 0 = never warning

	process(clk)

		------ FSM helpers

		-- Counter
		impure function counter_done return boolean is
		begin
			if counter > 0 then
				if tick1ms = '1' then
					counter <= counter - 1;
				end if;

				return(false);
			else
				return(true);
			end if;
		end function;

		-- Regular state changes (incl. errors...)
		procedure change2state (
			constant target_state : in state_type
		) is
		begin

			case target_state is

				when WaitForSupply =>
					-- Note that fsm_init (aka WaitForSupply) is entered directly and thus anything here (i.e., inside of change2state) is *not* going to take any effect...
					NULL;

				when Soft_Off =>
					NULL;

				when Wait_State =>
					harderror_duringbootup <= '0';
					Carrier_PwrOn <= '1';		-- enables all rails
					Carrier_PG_3V3 <= '1';		-- Hack IsoIo on, if power on

					counter <= 1_000;			-- Counter gleich starten

				when EthernetPhy_Reset =>
					Carrier_PG_1V8 <= '0';				-- resetn for 50ms to zero

					counter <= 50;						-- Counter gleich starten

				when Ack_previous_Harderror
				   | Ack_bootup_Harderror
				   | Ready_State
				   | Warning_State
				   | Softerror =>
					NULL;

				when Harderror =>

					counter <= 5_000;

				when sleep_for_dslot_down =>
					FlexMIOs53_GPIO_PowerDown <= '0';		-- end info to som
					DIGS3C_Shared_ReqSafeState <= '1';		-- info to dcplds

					counter <= 1_000;

			end case;

			fsm_state <= target_state;

		end procedure;


		---- error detection and handling

		-- LED mapping (4 downto 1): FP_UsrLED[4] is "User", FP_UsrLED[3] is "Error", FP_UsrLED[2] is "Running", and FP_UsrLED[1] is "Ready"
		procedure show_harderror (
			constant error : in error_type
		) is
		begin
			case error is
				when NoError =>
					FP_UsrLED <= "0000";
				when ExternalStop =>
					FP_UsrLED <= "1100";	-- Err + Usr
				when SupplyFailure =>
					FP_UsrLED <= "0110";	-- Err + Run
				when TemperatureShutdown =>
					FP_UsrLED <= "1111";	-- Err +  *
				when SlotError =>
					FP_UsrLED <= "0101";	-- Err + Rdy

				-- No OTHERS as all cases are defined :)

			end case;
		end procedure;

		-- Error sources
		impure function get_harderror return error_type is
		begin
			if pg10v = '0' then
				return(SupplyFailure);
			elsif externstop_wasfound='1' and externstop = '1' then	-- level-based (iff previously detected)
				return(externalstop);
			else
				return(NoError);
			end if;
		end function;

		procedure enter_errorstate (
			constant error_reason : in error_type
		) is
		begin
			if error_reason /= NoError then
				change2state(Harderror);
			end if;

			lasterror <= error_reason;
		end procedure;

		procedure checkandhandle_harderror is
			variable current_error : error_type;
		begin
			-- Once an External STOP is seen (i.e., a "not pressed" is received) even for a single clock cycle,
			-- store that - This should be turned into a persistent (I²C-set?) configuration flag in the future
			if externstop = '0' then
				externstop_wasfound <= '1';	-- bit to store if external stop was connected
			end if;

			current_error := get_harderror;

			show_harderror(current_error);
			enter_errorstate(current_error);
		end procedure;


	begin	-- process


		------ FSM start
		if rising_edge(clk) then
			if rst = '1' then
				fsm_state <= fsm_init;
			else
				case fsm_state is

					when WaitForSupply =>
						forceoutputdisable <= '1';
						DIGS3C_Shared_ReqSafeState <= '1';	-- not working because bank 1 1.8vper not supplied

						FP_SysLEDr <= '1';
						FP_SysLEDb <= '0';
						FP_SysLEDg <= '1';

						FlexMIOs53_GPIO_PowerDown <= '0';

						-- Wait until
						-- - the VIN rail has exceeded 6V (i.e., PPn_VIN via ppn6v), and
						-- - SysSW_Pwr_NC=1 (i.e., FP connected and button not pressed).
						if ppn6v = '1' AND power = '0' then
							change2state(Soft_Off);
						end if;

					when Soft_Off =>
						forceoutputdisable <= '1';
						DIGS3C_Shared_ReqSafeState <= '1';	-- not working because bank 1 1.8vper not supplied

						if lasterror = NoError then
							FP_SysLEDr <= '0';
							FP_SysLEDb <= '1';
							FP_SysLEDg <= '0';
						else
							FP_SysLEDr <= '1';
							FP_SysLEDb <= '1';
							FP_SysLEDg <= '0';
						end if;

						FlexMIOs53_GPIO_PowerDown <= '0';

						if power_pressededge = '1' then
							change2state(Wait_State);
						else
							Carrier_PwrOn <= '0';		-- all rails down, only s3c alive
							Carrier_PG_3V3 <= '0';
							FPIO_isoCtrlRSTn <= '0';	-- reset IsoIO enable
							Carrier_PG_1V8 <= 'Z';		-- tristate as long as system is down
						end if;

					when Wait_State =>
						forceoutputdisable <= '1';
						DIGS3C_Shared_ReqSafeState <= '1';	-- not working because bank 1 1.8vper not supplied

						FP_SysLEDr <= '1';
						FP_SysLEDb <= '1';
						FP_SysLEDg <= '0';

						if counter_done then
							change2state(EthernetPhy_Reset);
						end if;

					when EthernetPhy_Reset =>
						forceoutputdisable <= '1';
						DIGS3C_Shared_ReqSafeState <= '1';	-- not working because bank 1 1.8vper not supplied

						FP_SysLEDr <= '1';
						FP_SysLEDb <= '1';
						FP_SysLEDg <= '1';

						if get_harderror /= NoError then
							harderror_duringbootup <= '1';
						end if;

						if counter_done then
							-- Init complete
							Carrier_PG_1V8 <= 'Z';		-- after 50 ms tristate
							FPIO_isoCtrlRSTn <= '1';	-- reset IsoIO off

							if lasterror /= NoError then
								change2state(Ack_previous_Harderror);
							elsif harderror_duringbootup = '1' then
								change2state(Ack_bootup_Harderror);
							else
								change2state(ready_state);
							end if;
						end if;

					when Ack_previous_Harderror =>
						-- Blinky
						if counter_done then
							counter <= 400;
						end if;
						if counter > 300 then
							FP_SysLEDr <= '1';
							FP_SysLEDb <= '1';
							show_harderror(NoError);
						else
							FP_SysLEDr <= '0';
							FP_SysLEDb <= '0';
							show_harderror(lasterror);
						end if;
						FP_SysLEDg <= '0';

						if get_harderror /= NoError then
							harderror_duringbootup <= '1';
						end if;

						if power_pressededge = '1' then
							lasterror <= NoError;
							if harderror_duringbootup = '0' then
								show_harderror(NoError);
								change2state(ready_state);
							else
								change2state(Ack_bootup_Harderror);
							end if;
						end if;

					when Ack_bootup_Harderror =>

						FP_SysLEDr <= '1';
						FP_SysLEDb <= '1';
						FP_SysLEDg <= '0';

						FlexMIOs53_GPIO_PowerDown <= '1';		-- info to som, power linux down;

						show_harderror(get_harderror);
						if get_harderror = NoError AND power_pressededge = '1' then
							change2state(Soft_Off);
						end if;
						if power_pushed2sec = '1' then
							change2state(sleep_for_dslot_down);		-- Version 1:Blau = Nutzer fährt system herunter, Lila = system fährt sich selbst herunter
						end if;

					when ready_state =>
						forceoutputdisable <= NOT PPn_VIN;	-- noch zu messen, evtl durch debounce version ersetzen
						DIGS3C_Shared_ReqSafeState <= '0';

						FP_SysLEDr <= '0';
						FP_SysLEDb <= '0';
						FP_SysLEDg <= '1';
						FP_SysLEDs <= '1';

						FlexMIOs53_GPIO_PowerDown <= power;			-- NB: This copies the power button's current state to the SoM, which is going to be '1' just at/after entering this state (as the button is still pressed)

						if stop = '1' then
							change2state(Softerror);
						elsif warning = '1' then
							change2state(Warning_State);
						elsif power_pushed2sec = '1' then			-- NB: In line with FlexMIOs53_GPIO_PowerDown above, this timer surely is going to start just at/after entering this state (as the button is still pressed)
							change2state(sleep_for_dslot_down);
						end if;
						checkandhandle_harderror;

					when warning_state =>
						forceoutputdisable <= NOT PPn_VIN;	-- noch zu messen, evtl durch debounce version ersetzen
						DIGS3C_Shared_ReqSafeState <= '0';

						FP_SysLEDr <= '0';
						FP_SysLEDb <= '1';
						FP_SysLEDg <= '0';
						FP_SysLEDs <= '0';

						FlexMIOs53_GPIO_PowerDown <= power;

						if stop = '1' then
							change2state(Softerror);
						elsif power_pushed2sec = '1' then
							change2state(sleep_for_dslot_down);
						end if;
						checkandhandle_harderror;

					when Harderror =>
						--Request safe state to dslots
						forceoutputdisable <= NOT PPn_VIN;	-- noch zu messen, evtl durch debounce version ersetzen
						DIGS3C_Shared_ReqSafeState <= '1';

						FP_SysLEDr <= '1';
						FP_SysLEDb <= '0';
						FP_SysLEDg <= '0';
						FP_SysLEDs <= '1';

						FlexMIOs53_GPIO_PowerDown <= '1';		-- info to som, power linux down;

						if counter_done then
							change2state(Soft_Off);
						end if;

					when Softerror =>
						--Request safe state to dslots
						forceoutputdisable <= NOT PPn_VIN;	-- noch zu messen, evtl durch debounce version ersetzen
						DIGS3C_Shared_ReqSafeState <= '1';

						FP_SysLEDr <= '1';
						FP_SysLEDb <= '1';
						FP_SysLEDg <= '1';
						FP_SysLEDs <= '1';

						FlexMIOs53_GPIO_PowerDown <= power;

						if power_pushed2sec = '1' then
							change2state(sleep_for_dslot_down);
						elsif stop = '0' AND enable = '1' then	-- when both buttons pressed no state change
							change2state(Ready_State);
						end if;
						checkandhandle_harderror;

					when sleep_for_dslot_down =>
						if counter_done then
							change2state(Soft_Off);
						end if;

					when others =>
						fsm_state <= fsm_init;

				end case;
			end if;			-- rst
		end if;				-- clk
	end process;

END fsm_arch;