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

ENTITY sXc_tickgen IS
	GENERIC (
		CLK_FREQ_HZ : INTEGER := 2_080_000;	-- CLK - 2.08 MHz
		TICK_US		: INTEGER := 1_000;			-- Tickdauer in us (1000 = 1 ms)
		CASCADE		: INTEGER RANGE 0 TO 1		-- Primary (0) vs. cascaded (1)? This is a bit of a hack to catch an unassigned tickin at the cost of one null range warning on any primary instance :/
	);
	PORT (
		clk:		IN STD_LOGIC;
		tickin:		IN STD_LOGIC_VECTOR(CASCADE-1 DOWNTO 0) := (others => '0');
		tickout:	OUT STD_LOGIC
	);
END sXc_tickgen;

ARCHITECTURE tickgen_arch OF sXc_tickgen IS

	SIGNAL tick_local:	STD_LOGIC;

	CONSTANT TICKS_PER_PERIOD:	INTEGER := CASCADE + CLK_FREQ_HZ / (1_000_000 / TICK_US);

	SIGNAL tickcounter:	INTEGER RANGE 0 TO TICKS_PER_PERIOD-1 := 0;

BEGIN

	cascaded: IF ( CASCADE = 0 ) GENERATE
		tick_local <= '1';
	ELSE GENERATE
		tick_local <= tickin(0);
	END GENERATE;

	PROCESS(clk)
	BEGIN
		IF RISING_EDGE(clk) THEN
			IF tickcounter > 0 THEN
				IF tick_local = '1' THEN
					tickcounter <= tickcounter - 1;
				END IF;
				tickout <= '0';
			ELSE
				tickcounter <= TICKS_PER_PERIOD-1;
				tickout <= '1';
			END IF;
		END IF;
	END PROCESS;

END tickgen_arch;


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


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE sXc_sr_pkg IS
	TYPE srarray_t IS ARRAY(NATURAL RANGE <>) OF STD_LOGIC_VECTOR;
END PACKAGE;


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.sXc_sr_pkg.ALL;

ENTITY sXc_sr IS
	GENERIC (
		WIDTH:	POSITIVE := 1;			-- number of shift registers
		DEPTH:	POSITIVE := 4			-- depth of single register, i.e., how many stages "reside between DI(i) and DO(i)"
	);
	PORT (
		clk:	IN STD_LOGIC;
		rst:	IN STD_LOGIC;

		clken:	IN STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);

		DI:		IN STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);				-- data in
		DO:		OUT STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);			-- data out
		DOE:	OUT srarray_t(WIDTH-1 DOWNTO 0)(DEPTH-1 DOWNTO 0)	-- entire SR (if needed)
	);
END sXc_sr;

ARCHITECTURE arch OF sXc_sr IS
	SIGNAL srdata:		srarray_t(WIDTH-1 DOWNTO 0)(DEPTH-1 DOWNTO 0);
BEGIN

	srregs: FOR i IN WIDTH-1 DOWNTO 0 GENERATE
		PROCESS(clk)
		BEGIN
			IF RISING_EDGE(clk) THEN
				IF (rst = '1') THEN
					srdata(i) <= ( OTHERS => '0' );
				ELSE	--rst
					IF (clken(i) = '1') THEN
						srdata(i) <= srdata(i)(DEPTH-2 DOWNTO 0) & DI(i);
					END IF;
				END IF;	--rst
			END IF;		--clk
		END PROCESS;

		DO(i) <= srdata(i)(DEPTH-1);	-- oldest bit
	END GENERATE;

	DOE <= srdata;						-- all bits

END arch;


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.sXc_sr_pkg.ALL;

ENTITY sXc_hbmon IS
	GENERIC (
		CHANNELS:	POSITIVE := 3;		-- Number of monitored (incoming) heartbeat signals (and thus, also, clken)
		CNT_BITS:	POSITIVE := 8		-- Number of bits in the timeout counters (counting between PATTERN events)
	);
	PORT (
		clk:		IN STD_LOGIC;
		rst:		IN STD_LOGIC;

		clken:		IN STD_LOGIC_VECTOR(CHANNELS-1 DOWNTO 0);					-- timebase (tick) input of channel

		HB:			IN STD_LOGIC_VECTOR(CHANNELS-1 DOWNTO 0);					-- heartbeat input
		OK:			OUT STD_LOGIC_VECTOR(CHANNELS-1 DOWNTO 0);					-- HB valid output

		CNT:		OUT srarray_t(CHANNELS-1 DOWNTO 0)(CNT_BITS-1 DOWNTO 0);	-- last seen number of ticks between detected heartbeats (optional)
		ERR:		OUT srarray_t(CHANNELS-1 DOWNTO 0)(CNT_BITS-1 DOWNTO 0)	-- non-limited counter of "timeout reached" error events (optional)
	);
END sXc_hbmon;

ARCHITECTURE arch OF sXc_hbmon IS

	-- length of search pattern (>= 2 bits), e.g., four (=2*2)
	CONSTANT PLENGTH:	POSITIVE RANGE 2 TO 8 := 4;
	-- default search pattern (as a vector), e.g., rising edge
	CONSTANT PATTERN:	STD_LOGIC_VECTOR(PLENGTH-1 DOWNTO 0) := (
		(PLENGTH-1) DOWNTO (PLENGTH/2)	=> '0',
		( (PLENGTH/2) - 1 ) DOWNTO 0	=> '1'
	);

	SIGNAL srdata:		srarray_t(CHANNELS-1 DOWNTO 0)(PLENGTH-1 DOWNTO 0);

	SIGNAL edgefound:	STD_LOGIC_VECTOR(CHANNELS-1 DOWNTO 0);

	SIGNAL patcnt:		srarray_t(CHANNELS-1 DOWNTO 0)(CNT_BITS-1 DOWNTO 0);			-- ticks between events
	CONSTANT CNTMAX:	STD_LOGIC_VECTOR(CNT_BITS-1 DOWNTO 0) := ( OTHERS => '1' );

	SIGNAL hbseen:		srarray_t(CHANNELS-1 DOWNTO 0)(CNT_BITS-1 DOWNTO 0);			-- last observed patcnt (ticks between HBs)
	SIGNAL hblost:		srarray_t(CHANNELS-1 DOWNTO 0)(CNT_BITS-1 DOWNTO 0);			-- "HB lost" event cntr (wraps at overflow)

BEGIN

	hbmon_shift: ENTITY WORK.sXc_sr
		GENERIC MAP (
			WIDTH	=> CHANNELS,
			DEPTH	=> PLENGTH
		)
		PORT MAP (
			clk		=> clk,
			rst		=> rst,
			clken	=> clken,
			DI		=> HB,
			DO		=> OPEN,
			DOE		=> srdata
		);

	hbmon_check: FOR i IN CHANNELS-1 DOWNTO 0 GENERATE
		edgefound(i) <= '1' WHEN ( srdata(i) = PATTERN ) ELSE '0';
	END GENERATE;

	hbmon_count: FOR i IN CHANNELS-1 DOWNTO 0 GENERATE
		PROCESS(clk)
			VARIABLE cntrun:	BOOLEAN;
		BEGIN
			IF RISING_EDGE(clk) THEN
				IF (rst = '1') THEN
					patcnt(i) <= CNTMAX;
					hbseen(i) <= ( OTHERS => '0' );
					hblost(i) <= ( OTHERS => '0' );
				ELSE		--rst
					IF ( clken(i) = '1' ) THEN

						cntrun := ( patcnt(i) < CNTMAX );

						IF ( edgefound(i) = '1' ) THEN
							-- restart counter
							patcnt(i) <= ( OTHERS => '0' );
							hbseen(i) <= patcnt(i);

							-- signal "OK" iff there was no timeout between events
							IF cntrun THEN
								OK(i) <= '1';
							END IF;
						ELSIF cntrun THEN
							-- counter running
							patcnt(i) <= STD_LOGIC_VECTOR( UNSIGNED(patcnt(i)) + 1 );
						ELSE
							-- halted @ CNTMAX
							OK(i) <= '0';

							IF ( OK(i) = '1' ) THEN
								hblost(i) <= STD_LOGIC_VECTOR( UNSIGNED(hblost(i)) + 1 );	-- no overflow handling
							END IF;
						END IF;

					END IF;	--clken
				END IF;		--rst
			END IF;			--clk
		END PROCESS;
	END GENERATE;

	CNT <= hbseen;
	ERR <= hblost;

END arch;


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE sXc_hbgen_pkg IS
	TYPE hbgen_cfgarray_t IS ARRAY(NATURAL RANGE <>) OF POSITIVE RANGE 2 TO 128;
END PACKAGE;


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.sXc_hbgen_pkg.ALL;

ENTITY sXc_hbgen IS
	GENERIC (
		CHANNELS:	POSITIVE := 3;													-- Number of generated (outgoing) heartbeat signals (and thus, also, clken)
		PERTICKS:	hbgen_cfgarray_t(CHANNELS-1 DOWNTO 0) := ( OTHERS => 100 )	-- Number of ticks per "heartbeat period" per channel; duty cycle fixed 50%
	);
	PORT (
		clk:		IN STD_LOGIC;

		clken:		IN STD_LOGIC_VECTOR(CHANNELS-1 DOWNTO 0);				-- timebase (tick) input of channel

		EN:			IN STD_LOGIC_VECTOR(CHANNELS-1 DOWNTO 0);				-- enable
		HB:			OUT STD_LOGIC_VECTOR(CHANNELS-1 DOWNTO 0)				-- output
	);
END sXc_hbgen;

ARCHITECTURE arch of sXc_hbgen IS

BEGIN

	hbgen_count: FOR i IN CHANNELS-1 DOWNTO 0 GENERATE
		PROCESS(clk)
			CONSTANT CNTMAX:	POSITIVE := (PERTICKS(i)-1);
			VARIABLE cnt:		NATURAL RANGE 0 TO CNTMAX;
		BEGIN
			IF RISING_EDGE(clk) THEN
				IF ( EN(i) = '0' ) THEN
					cnt := 0;
				ELSE	-- EN
					IF ( clken(i) = '1' ) THEN
						IF (cnt < CNTMAX) THEN
							cnt := cnt + 1;
						ELSE
							cnt := 0;
						END IF;
					END IF;
				END IF;	-- EN
			END IF;		--clk

			HB(i) <= '0' WHEN ( cnt <= CNTMAX/2 ) ELSE '1';
		END PROCESS;
	END GENERATE;

END arch;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY sXc_heartbeat_sender IS
	GENERIC (
		HEARTBEAT_HALF_PERIOD_CLKS:	INTEGER := 21	-- 2.08 MHz / (2 * 21) = approx. 49.5 kHz
	);
	PORT (
		clk:					IN STD_LOGIC;
		safe_state_request:	IN STD_LOGIC;
		heartbeat_out:		OUT STD_LOGIC
	);
END sXc_heartbeat_sender;

ARCHITECTURE sender_arch OF sXc_heartbeat_sender IS
	SIGNAL heartbeat_local:	STD_LOGIC := '1';
	SIGNAL heartbeat_counter:	INTEGER RANGE 0 TO HEARTBEAT_HALF_PERIOD_CLKS-1 := 0;

BEGIN

	PROCESS(clk)
	BEGIN
		IF RISING_EDGE(clk) THEN
			IF safe_state_request = '0' THEN
				IF heartbeat_counter > 0 THEN
					heartbeat_counter <= heartbeat_counter - 1;
				ELSE
					heartbeat_counter <= HEARTBEAT_HALF_PERIOD_CLKS-1;
					heartbeat_local <= NOT heartbeat_local;
				END IF;
			ELSE
				heartbeat_counter <= 0;
				heartbeat_local <= '1';
			END IF;
		END IF;
	END PROCESS;

	heartbeat_out <= heartbeat_local;

END sender_arch;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY dslot_heartbeat_receiver IS
	GENERIC (
		HB_TIMEOUT_CLKS:			INTEGER := 208;	-- 100 us at 2.08 MHz
		HB_MIN_EDGE_CLKS:			INTEGER := 10;	-- 4.8 us at 2.08 MHz
		HB_MAX_EDGE_CLKS:			INTEGER := 52;	-- 25.0 us at 2.08 MHz
		HB_VALID_EDGES_REQUIRED:	INTEGER := 16
	);
	PORT (
		clk:					IN STD_LOGIC;
		heartbeat_in:	IN STD_LOGIC;
		heartbeat_invalid:	OUT STD_LOGIC
	);
END dslot_heartbeat_receiver;

ARCHITECTURE receiver_arch OF dslot_heartbeat_receiver IS
	SIGNAL heartbeat_meta:		STD_LOGIC := '0';
	SIGNAL heartbeat_sync:		STD_LOGIC := '0';
	SIGNAL heartbeat_last:		STD_LOGIC := '0';
	SIGNAL hb_timeout_cnt:		INTEGER RANGE 0 TO HB_TIMEOUT_CLKS := 0;
	SIGNAL hb_since_edge_cnt:	INTEGER RANGE 0 TO HB_TIMEOUT_CLKS := HB_TIMEOUT_CLKS;
	SIGNAL hb_valid_edge_cnt:	INTEGER RANGE 0 TO HB_VALID_EDGES_REQUIRED := 0;
	SIGNAL local_safe_request:	STD_LOGIC := '1';

BEGIN

	PROCESS(clk)
	BEGIN
		IF RISING_EDGE(clk) THEN
			heartbeat_meta <= heartbeat_in;
			heartbeat_sync <= heartbeat_meta;

			IF heartbeat_sync /= heartbeat_last THEN
				heartbeat_last <= heartbeat_sync;
				hb_timeout_cnt <= HB_TIMEOUT_CLKS;
				hb_since_edge_cnt <= 0;

				IF hb_since_edge_cnt >= HB_MIN_EDGE_CLKS AND hb_since_edge_cnt <= HB_MAX_EDGE_CLKS THEN
					IF hb_valid_edge_cnt < HB_VALID_EDGES_REQUIRED THEN
						hb_valid_edge_cnt <= hb_valid_edge_cnt + 1;
					END IF;
				ELSE
					hb_valid_edge_cnt <= 1;
				END IF;

				IF hb_valid_edge_cnt >= HB_VALID_EDGES_REQUIRED-1 THEN
					local_safe_request <= '0';
				END IF;
			ELSIF hb_timeout_cnt > 0 THEN
				hb_timeout_cnt <= hb_timeout_cnt - 1;
				IF hb_since_edge_cnt < HB_TIMEOUT_CLKS THEN
					hb_since_edge_cnt <= hb_since_edge_cnt + 1;
				END IF;
			ELSE
				hb_valid_edge_cnt <= 0;
				hb_since_edge_cnt <= HB_TIMEOUT_CLKS;
				local_safe_request <= '1';
			END IF;
		END IF;
	END PROCESS;

	heartbeat_invalid <= local_safe_request;

END receiver_arch;
