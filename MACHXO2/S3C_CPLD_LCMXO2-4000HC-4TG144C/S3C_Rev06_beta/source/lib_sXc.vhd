LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
LIBRARY machxo2;
USE machxo2.ALL;

ENTITY sXc_clkrst IS
	--GENERIC (
	--	CLK_FREQ_HZ : INTEGER := 2_080_000		-- CLK - 2.08 MHz
	--);
	PORT (
		clk:	OUT STD_LOGIC;
		rst:	OUT STD_LOGIC := '1'
	);
END sXc_clkrst;

ARCHITECTURE clkrst_arch OF sXc_clkrst IS

	COMPONENT OSCH
		-- synthesis translate_off
		GENERIC (
			NOM_FREQ:	STRING := "2.08"
		);
		-- synthesis translate_on
		PORT (
			STDBY:		IN	STD_LOGIC;
			OSC:		OUT	STD_LOGIC;
			SEDSTDBY:	OUT	STD_LOGIC
		);
	END COMPONENT;
	ATTRIBUTE NOM_FREQ:	STRING;
	ATTRIBUTE NOM_FREQ OF OSCinst0:	LABEL IS "2.08";

	SIGNAL local_clk:	STD_LOGIC;
	SIGNAL local_rst:	STD_LOGIC := '1';

BEGIN

	OSCInst0: OSCH
		-- synthesis translate_off
		GENERIC MAP (
			NOM_FREQ => "2.08"
		)
		-- synthesis translate_on
		PORT MAP (
			STDBY		=> '0',
			OSC			=> local_clk,
			SEDSTDBY	=> OPEN
		);

	PROCESS(local_clk)
	BEGIN
		IF RISING_EDGE(local_clk) THEN
			IF local_rst = '1' THEN
				local_rst <= '0';
			END IF;
		END IF;
	END PROCESS;

	clk <= local_clk;
	rst <= local_rst;

END clkrst_arch;


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY sXc_tick1ms IS
	GENERIC (
		CLK_FREQ_HZ : INTEGER := 2_080_000		-- CLK - 2.08 MHz
	);
	PORT (
		clk:		IN STD_LOGIC;
		tick1ms:	OUT STD_LOGIC
	);
END sXc_tick1ms;

ARCHITECTURE tick1ms_arch OF sXc_tick1ms IS

	CONSTANT TICK_US:			INTEGER := 1_000;			-- Tickdauer in µs (1000 = 1 ms)
	CONSTANT TICKS_PER_PERIOD:	INTEGER := CLK_FREQ_HZ / (1_000_000 / TICK_US);

	SIGNAL tickcounter:	INTEGER RANGE 0 TO TICKS_PER_PERIOD-1 := 0;

BEGIN

	PROCESS(clk)
	BEGIN
		IF RISING_EDGE(clk) THEN
			IF tickcounter > 0 THEN
				tickcounter <= tickcounter - 1;
				tick1ms <= '0';
			ELSE
				tickcounter <= TICKS_PER_PERIOD-1;
				tick1ms <= '1';
			END IF;
		END IF;
	END PROCESS;

END tick1ms_arch;


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Note that this requires VHDL-2008, so enable it (e.g., using "prj_strgy set_value -strategy Strategy1 syn_vhdl2008=True" in Diamond)
ENTITY sXc_debounce IS
	GENERIC (
		DEBOUNCE_TICKS:		INTEGER := 10;		-- Number of ticks to serve as debounce (time) constant
		DEBOUNCE_CHANNELS:	INTEGER := 1;		-- Number of channels (i.e., signals) for the debouncer
		DEBOUNCE_INITSTATE:	STD_LOGIC_VECTOR(DEBOUNCE_CHANNELS DOWNTO 1) := (OTHERS => '0');
		DEBOUNCE_INVERTOUT:	STD_LOGIC_VECTOR(DEBOUNCE_CHANNELS DOWNTO 1) := (OTHERS => '0')
	);
	PORT (
		clk:		IN STD_LOGIC;
		tick1ms:	IN STD_LOGIC;

		debounce_inputs:	IN STD_LOGIC_VECTOR(DEBOUNCE_CHANNELS DOWNTO 1);
		debounce_outputs:	OUT STD_LOGIC_VECTOR(DEBOUNCE_CHANNELS DOWNTO 1) := DEBOUNCE_INITSTATE
	);
END sXc_debounce;

ARCHITECTURE debounce_arch OF sXc_debounce IS

	TYPE debounce_array IS ARRAY (1 to DEBOUNCE_CHANNELS) OF INTEGER RANGE 0 TO DEBOUNCE_TICKS;
	SIGNAL debounce_counters:		debounce_array := (OTHERS => 0);

	SIGNAL debounce_inputs_asyn1:	STD_LOGIC_VECTOR(DEBOUNCE_CHANNELS DOWNTO 1) := DEBOUNCE_INITSTATE;		-- inputs after 1. flip flop
	SIGNAL debounce_inputs_asyn2:	STD_LOGIC_VECTOR(DEBOUNCE_CHANNELS DOWNTO 1) := DEBOUNCE_INITSTATE;		-- inputs after 2. flip flop
	SIGNAL debounce_pushed:			STD_LOGIC_VECTOR(DEBOUNCE_CHANNELS DOWNTO 1) := NOT DEBOUNCE_INITSTATE;

BEGIN

	PROCESS(clk)
	BEGIN
		IF RISING_EDGE(clk) THEN
			debounce_inputs_asyn1 <= debounce_inputs;
			debounce_inputs_asyn2 <= debounce_inputs_asyn1;

			-- debouncing for all signals
			FOR i IN 1 TO DEBOUNCE_CHANNELS LOOP
				IF debounce_inputs_asyn2(i) = '0' THEN	-- button pressed (low)
					IF debounce_counters(i) < DEBOUNCE_TICKS THEN
						IF tick1ms = '1' THEN
							debounce_counters(i) <= debounce_counters(i) + 1;
						END IF;
					ELSE
						debounce_pushed(i) <= '1';	-- button pressed = true
					END IF;
				ELSE	-- button high
					debounce_counters(i) <= 0;		-- TODO: off by one?
					debounce_pushed(i) <= '0';
				END IF;
				-- result inversion
				IF debounce_pushed(i) = DEBOUNCE_INVERTOUT(i) THEN
					debounce_outputs(i) <= '1';
				ELSE
					debounce_outputs(i) <= '0';
				END IF;
			END LOOP;

		END IF;
	END PROCESS;

END debounce_arch;