library IEEE;
library machxo2;
use machxo2.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity S3C is
	--generic (
	--	CLK_FREQ_HZ : integer := 2_080_000		-- CLK - 2.08 MHz
	--);
	Port (
		-- Mapping according to banks
		--- Bank 0, 3.3V
		FP_SysLEDg		: out STD_LOGIC;							-- LED green Power, pin 141
		FP_SysLEDr		: out STD_LOGIC;							-- LED red Power, pin 142
		FP_SysLEDb		: out STD_LOGIC;							-- LED blue Power, pin 143
		FlexIO05 : out STD_LOGIC;									-- drive 0
		FlexIO04 : in STD_LOGIC;									-- pulldown
		FlexIO03 : in STD_LOGIC;									-- pulldown
		FlexIO02 : out STD_LOGIC;									-- drive 0
		FlexIO01 : out STD_LOGIC;									-- drive 0
		FP_UsrSW1		:		in STD_LOGIC;						-- button Enable System, pin 128
		FP_UsrSW2		:		in STD_LOGIC;						-- button SW2 Enable Control, pin 127
		SCL      : inout STD_LOGIC;								-- pin 126, I²C CLK
		SDA      : inout STD_LOGIC;								-- pin 125, I²C DATA
		FP_UsrSW3		:		in STD_LOGIC;						-- button SW3 STOP, pin 122
		SysSW_Pwr_NC 	: 		in STD_LOGIC;						-- button Power, pin 121
		FPIO_isoCtrlRSTn	: 	out STD_LOGIC;						-- Z off, 1 on, none
		FPIO_iosCtrlINTn	: 	in STD_LOGIC;
		Carrier_PG_3V3	: out STD_LOGIC;							-- Powergood 3.3V, pin 115
		FPIO_ExternalStop: in STD_LOGIC;							-- button external stop, pin 114
		FPIO_FlexMIO28 	: inout STD_LOGIC:= 'Z';					-- Z
		FPIO_FlexMIO27 	: inout STD_LOGIC:= 'Z';
		FPIO_FlexMIO30 	: inout STD_LOGIC:= 'Z';
		FPIO_FlexMIO29 	: inout STD_LOGIC:= 'Z';
		FPIO_FlexMIO52 	: out STD_LOGIC;							-- is converted in PS, pin 109, Z

		--- Bank 1, 1.8V
		Carrier_PG_1V8	: out STD_LOGIC := 'Z';					-- ResetN Port, Powergood 1.8V pin 107
		S3CsI2C_SDA		: inout STD_LOGIC;
		S3CsI2C_SCL		: inout STD_LOGIC;
		FP_SysLEDs		: out STD_LOGIC;							-- LED red SW3, pin 104
		SD1_CD			: in STD_LOGIC;								-- pin 103
		SD0_CD			: in STD_LOGIC;								-- pin 100
		SPI_S3C_nCS_USR : in STD_LOGIC;
		FP_UsrLED 		: out STD_LOGIC_VECTOR (4 downto 1);
		DIGS3C_Shared_CarrierReady : out STD_LOGIC;				-- pin 94
		DIGS3C_Shared_ReqSafeState : out STD_LOGIC;				-- pin 93
		DIGS3C_SlotD_ReqOE : in STD_LOGIC_VECTOR (5 downto 1);		-- pin 92,89,86,84,82
		DIGS3C_SlotD_SlotOK : in STD_LOGIC_VECTOR (5 downto 1);	-- pin 91,87,85,83,81
		FlexLIO 		: inout STD_LOGIC_VECTOR (5 downto 0)  := (others => 'Z');

		--- Bank 2, 1.8V
		DIG5S3C26	: inout STD_LOGIC;								-- bidir,Z
		DIG5S3C25	: inout STD_LOGIC;								-- bidir,Z
		DIG5S3C24	: inout STD_LOGIC;								-- bidir,Z
		SD_SEL		: out STD_LOGIC := '0';						-- signal that is driven to 0, pin 41
		-- Flex MIos
		FlexMIOs52_PCIe	: in STD_LOGIC;								-- routing through to FrontpanelIO.FlexMIO52_PCIe-R¯S¯T¯, inversion in PS pin 47
		FlexMIOs53_GPIO_PowerDown :out STD_LOGIC;					-- gpio perform SoM Shutdown, pin 48
		FlexMIOs54	: inout STD_LOGIC;								-- bidir,Z
		FlexMio61ExternalStop 	: out STD_LOGIC;					-- external stop routed through, pin 50
		FlexMIOs62	: inout STD_LOGIC;								-- bidir,Z
		FlexMIOs63	: inout STD_LOGIC;								-- bidir,Z
		FlexMIOs31	: inout STD_LOGIC;								-- bidir,Z
		FlexMIOs30	: inout STD_LOGIC;								-- bidir,Z
		FlexMIOs29	: inout STD_LOGIC;								-- bidir,Z
		FlexMIOs28	: inout STD_LOGIC;								-- bidir,Z
		FlexMIOs27	: inout STD_LOGIC;								-- bidir,Z
		FlexMIOs26	: inout STD_LOGIC;								-- bidir,Z
		FlexMIOs45	: inout STD_LOGIC;								-- bidir,Z
		FlexMIOs37	: inout STD_LOGIC;								-- bidir,Z
		FlexMIOs36	: inout STD_LOGIC;								-- bidir,Z
		FlexMIOs35	: inout STD_LOGIC;								-- bidir,Z
		FlexMIOs34	: inout STD_LOGIC;								-- bidir,Z
		FlexMIOs33	: inout STD_LOGIC;								-- bidir,Z
		FlexMIOs32	: inout STD_LOGIC;								-- bidir,Z

		--- Bank 3, 1.8V
		DIG5S3C03	: inout STD_LOGIC;								-- bidir,Z
		DIG5S3C04	: inout STD_LOGIC;								-- bidir,Z
		DIG5S3C05	: inout STD_LOGIC;								-- bidir,Z
		DIG5S3C00	: inout STD_LOGIC;								-- bidir,Z
		DIG5S3C02	: inout STD_LOGIC;								-- bidir,Z
		DIG5S3C01	: inout STD_LOGIC;								-- bidir,Z
		DIG5S3C29	: inout STD_LOGIC;								-- bidir,Z
		DIG5S3C28	: inout STD_LOGIC;								-- bidir,Z
		DIG5S3C27	: inout STD_LOGIC;								-- bidir,Z

		--- Bank 4, 3.3V
		ANL_S3C_SLOTOK : in STD_LOGIC_VECTOR (3 downto 1);			-- pin 23,22,21
		ANL_S3C_CarrierReady: out STD_LOGIC;						-- pin 24
		ANL_S3C_P54_Legacy	: inout STD_LOGIC;						-- bidir,Z,pin 13
		DIGS3C_SlotD_SlotOE : OUT STD_LOGIC_VECTOR (5 downto 1);	-- pin 20,19,17,15,14

		--- Bank 5, 3.3V
		Carrier_PwrOn 	: out STD_LOGIC;							-- pin 1
		PG_VIN			: in STD_LOGIC;								-- pin 2, none
		PPn_VIN			: in STD_LOGIC;								-- pin 3, none
		PG_Module 		: in STD_LOGIC;								-- pin 9, none
		TDnSHDN			: in STD_LOGIC;								-- pin 4, none
		TDnFFnFS		: inout STD_LOGIC;							-- pin 5, none
		TDnALERT 		: in STD_LOGIC;								-- pin 6, none
		S3C_S1 			: in STD_LOGIC								-- pin 10, pulldown
	);

end S3C;

architecture S3C_arch of S3C is
	signal clk	:	STD_LOGIC;
	signal rst	:	STD_LOGIC := '1';

	signal tick1ms		: STD_LOGIC;


	-- debounced signals
	signal power	:	STD_LOGIC;
	signal externstop	:	STD_LOGIC;
	signal stop	:	STD_LOGIC;
	signal enable	:	STD_LOGIC;
	signal pg10v	:	STD_LOGIC;
	signal ppn6v	:	STD_LOGIC;

	-- counter outside fsm 2sec
	signal power_counter2sec : integer range 0 to 2_000 := 0;		-- counter for button
	-- Power button: Edge and long press detection
	signal power_pressededge:	STD_LOGIC;
	signal power_lastvalue:		STD_LOGIC := '0';
	signal power_pushed2sec: 	STD_LOGIC := '0';

	-- Dslot
	signal forceoutputdisable :		STD_LOGIC;

	-- Tristate
	signal tristate_signals : STD_LOGIC_vector(31 downto 0);
	-- In-Dummy
	signal dummy_signal : STD_LOGIC;
	attribute syn_keep : boolean;
	attribute syn_noprune : boolean;
	attribute noclip   : string;
	attribute noclip of dummy_signal  : signal is "on";
	attribute syn_keep of dummy_signal : signal is true;
	attribute syn_noprune of dummy_signal : signal is true;


begin	-- arch


dummy_signal <= TDnALERT AND TDnSHDN and ANL_S3C_P54_Legacy AND ANL_S3C_SLOTOK(1) AND ANL_S3C_SLOTOK(2) AND ANL_S3C_SLOTOK(3)
	AND DIGS3C_SlotD_SlotOK(1) AND DIGS3C_SlotD_SlotOK(2) AND DIGS3C_SlotD_SlotOK(3) AND DIGS3C_SlotD_SlotOK(4) AND DIGS3C_SlotD_SlotOK(5)
	AND DIG5S3C00 AND DIG5S3C01 AND DIG5S3C02 AND DIG5S3C03 AND DIG5S3C04 AND DIG5S3C05
	AND DIG5S3C24 AND DIG5S3C25 AND DIG5S3C26 AND DIG5S3C27 AND DIG5S3C28 AND DIG5S3C29
	AND FPIO_FlexMIO27 AND FPIO_FlexMIO28 AND FPIO_FlexMIO29 AND FPIO_FlexMIO30
	AND FPIO_iosCtrlINTn AND FP_UsrSW2 AND FlexIO03 and FlexIO04
	AND FLexLIO(0) AND FLexLIO(1) AND FLexLIO(2) AND FLexLIO(3) AND FLexLIO(4) AND FLexLIO(5)
	AND FlexMIOs26 AND FlexMIOs27 AND FlexMIOs28 AND FlexMIOs29 AND FlexMIOs30 AND FlexMIOs31
	AND FlexMIOs32 AND FlexMIOs33 AND FlexMIOs34 AND FlexMIOs35 AND FlexMIOs36 AND FlexMIOs37
	AND FlexMIOs45 AND FlexMIOs54 AND FlexMIOs62 AND FlexMIOs63 AND PG_Module
	AND S3CsI2C_SCL AND S3CsI2C_SDA
	AND SCL AND SD0_CD AND SD1_CD AND SDA AND SPI_S3C_nCS_USR AND TDnFFnFS;

tristate_signals <= DIG5S3C00 & DIG5S3C01 & DIG5S3C02 & DIG5S3C03 & DIG5S3C04  & DIG5S3C05
	& DIG5S3C24 & DIG5S3C25 & DIG5S3C26 & DIG5S3C27 & DIG5S3C28 & DIG5S3C29
	& FlexMIOs26 & FlexMIOs27 & FlexMIOs28 & FlexMIOs29 & FlexMIOs30 & FlexMIOs31
	& FlexMIOs32 & FlexMIOs33 & FlexMIOs34 & FlexMIOs35 & FlexMIOs36 & FlexMIOs37
	& FlexMIOs54 & FlexMIOs62 & FlexMIOs63 & FPIO_FlexMIO27 & FPIO_FlexMIO28 & FPIO_FlexMIO29 & FPIO_FlexMIO30 & TDnFFnFS;
-- Assign 'Z' to all unused signal
tristate_signals <= (others => 'Z');

-- Ports default + routing through
SD_SEL <= '0';
FPIO_FlexMIO52 <= FlexMIOs52_PCIe;
FlexMio61ExternalStop <= FPIO_ExternalStop;

-- FIXME: Debug
FlexIO01 <= PG_Module AND ppn6v;					-- move (possibly AND-ed) to TP
FlexIO02 <= PG_Module AND S3C_S1;
FlexIO05 <= PG_Module AND NOT clk;

-- Conditional passthrough for OE of D slots
DIGS3C_SlotD_SlotOE <= DIGS3C_SlotD_ReqOE and (DIGS3C_SlotD_SlotOE'Range => NOT forceoutputdisable);


s3c_clkrst: ENTITY work.sXc_clkrst
	PORT MAP (
		clk	=> clk,
		rst	=> rst
	);

s3c_tick1ms: ENTITY work.sXc_tick1ms
	PORT MAP (
		clk		=> clk,
		tick1ms	=> tick1ms
	);

-- Mapping of buttons (1 <=> button pressed) and other inputs for debounce and detection logic
s3c_debounce: ENTITY work.sXc_debounce
	GENERIC MAP (
		DEBOUNCE_TICKS => 10,					-- debounce constant: 10ms
		DEBOUNCE_CHANNELS => 6,
		DEBOUNCE_INITSTATE => "000000",			-- Bits 6-5 (TPS3803) low (nRESET), bits 4-3 (SW1/3) low (U21), bit 2 (Ext. STOP) low (R18/26 @ FPM), and bit 1 (Power button) low (R1)
		                   ---	Power Panic (6V)	Power Good (10V)	EnableSystem button		STOP button		External STOP		Power button
		DEBOUNCE_INVERTOUT =>	'0' &				'0' &				'1' &					'1' &			'1' &				'1'
	)
	PORT MAP (
		clk => clk,        ---	|              |	|              |	|                 |		|         |		|               |	|          |
		tick1ms => tick1ms,
		debounce_inputs(6) =>	PPn_VIN,
		debounce_inputs(5) =>						PG_VIN,
		debounce_inputs(4) =>											FP_UsrSW1,
		debounce_inputs(3) =>																	FP_UsrSW3,
		debounce_inputs(2) =>																					FPIO_ExternalStop,
		debounce_inputs(1) =>																										SysSW_Pwr_NC,
		debounce_outputs(6) =>	ppn6v,
		debounce_outputs(5) =>						pg10v,
		debounce_outputs(4) =>											enable,
		debounce_outputs(3) =>																	stop,
		debounce_outputs(2) =>																					externstop,
		debounce_outputs(1) =>																										power
	);

-- post-debounce processing for power button
process(clk)
begin
	if rising_edge(clk) then
		-- powerbutton "just pressed" check
		power_pressededge <= NOT power_lastvalue AND power;
		power_lastvalue <= power;
		-- powerbutton press duration check
		if power = '1' then
			if power_counter2sec > 0 then
				if tick1ms = '1' then
					power_counter2sec <= power_counter2sec - 1;
				end if;
			else
				power_pushed2sec <= '1';
			end if;
		else
			power_counter2sec <= 2_000;
			power_pushed2sec <= '0';
		end if;
	end if;
end process;

s3c_fsm: ENTITY work.s3c_fsm
	PORT MAP (
		clk							=> clk,
		rst							=> rst,
		tick1ms						=> tick1ms,

		---- UI
		-- Inputs
		power						=> power,
		stop						=> stop,
		enable						=> enable,
		externstop					=> externstop,

		-- Outputs
		FP_SysLEDr					=> FP_SysLEDr,
		FP_SysLEDb					=> FP_SysLEDb,
		FP_SysLEDg					=> FP_SysLEDg,
		FP_SysLEDs					=> FP_SysLEDs,
		FP_UsrLED					=> FP_UsrLED,

		-- Internal
		power_pressededge			=> power_pressededge,
		power_pushed2sec			=> power_pushed2sec,

		---- CC
		-- Inputs
		pg10v						=> pg10v,
		ppn6v						=> ppn6v,
		PPn_VIN						=> PPn_VIN,						-- NB: Cf. comment in s3c_fsm

		-- Outputs
		Carrier_PwrOn				=> Carrier_PwrOn,
		Carrier_PG_3V3				=> Carrier_PG_3V3,
		Carrier_PG_1V8				=> Carrier_PG_1V8,
		FPIO_isoCtrlRSTn			=> FPIO_isoCtrlRSTn,
		FlexMIOs53_GPIO_PowerDown	=> FlexMIOs53_GPIO_PowerDown,
		DIGS3C_Shared_ReqSafeState	=> DIGS3C_Shared_ReqSafeState,

		-- Internal
		forceoutputdisable			=> forceoutputdisable
	);

end S3C_arch;