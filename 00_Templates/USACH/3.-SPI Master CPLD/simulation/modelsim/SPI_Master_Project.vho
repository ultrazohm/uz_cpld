-- Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus Prime License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 16.0.0 Build 211 04/27/2016 SJ Standard Edition"

-- DATE "08/09/2018 17:19:43"

-- 
-- Device: Altera EPM570T100C4 Package TQFP100
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY IEEE;
LIBRARY MAXII;
USE IEEE.STD_LOGIC_1164.ALL;
USE MAXII.MAXII_COMPONENTS.ALL;

ENTITY 	main IS
    PORT (
	clock : IN std_logic;
	reset_n : IN std_logic;
	trip : IN std_logic;
	PWM1 : OUT std_logic;
	PWM2 : OUT std_logic;
	PWM3 : OUT std_logic;
	PWM4 : OUT std_logic;
	PWM5 : OUT std_logic;
	PWM6 : OUT std_logic;
	PWM7 : OUT std_logic;
	PWM8 : OUT std_logic;
	PWM9 : OUT std_logic;
	PWM10 : OUT std_logic;
	PWM11 : OUT std_logic;
	PWM12 : OUT std_logic;
	PWM13 : OUT std_logic;
	PWM14 : OUT std_logic;
	PWM15 : OUT std_logic;
	PWM16 : OUT std_logic;
	PWM17 : OUT std_logic;
	PWM18 : OUT std_logic;
	PWM19 : OUT std_logic;
	PWM20 : OUT std_logic;
	PWM21 : OUT std_logic;
	PWM22 : OUT std_logic;
	PWM23 : OUT std_logic;
	PWM24 : OUT std_logic;
	DATA1 : OUT std_logic;
	DATA2 : OUT std_logic;
	DATA3 : OUT std_logic;
	DATA4 : IN std_logic;
	DATA5 : IN std_logic;
	DATA6 : IN std_logic;
	DATA7 : IN std_logic;
	DATA8 : IN std_logic
	);
END main;

-- Design Ports Information


ARCHITECTURE structure OF main IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clock : std_logic;
SIGNAL ww_reset_n : std_logic;
SIGNAL ww_trip : std_logic;
SIGNAL ww_PWM1 : std_logic;
SIGNAL ww_PWM2 : std_logic;
SIGNAL ww_PWM3 : std_logic;
SIGNAL ww_PWM4 : std_logic;
SIGNAL ww_PWM5 : std_logic;
SIGNAL ww_PWM6 : std_logic;
SIGNAL ww_PWM7 : std_logic;
SIGNAL ww_PWM8 : std_logic;
SIGNAL ww_PWM9 : std_logic;
SIGNAL ww_PWM10 : std_logic;
SIGNAL ww_PWM11 : std_logic;
SIGNAL ww_PWM12 : std_logic;
SIGNAL ww_PWM13 : std_logic;
SIGNAL ww_PWM14 : std_logic;
SIGNAL ww_PWM15 : std_logic;
SIGNAL ww_PWM16 : std_logic;
SIGNAL ww_PWM17 : std_logic;
SIGNAL ww_PWM18 : std_logic;
SIGNAL ww_PWM19 : std_logic;
SIGNAL ww_PWM20 : std_logic;
SIGNAL ww_PWM21 : std_logic;
SIGNAL ww_PWM22 : std_logic;
SIGNAL ww_PWM23 : std_logic;
SIGNAL ww_PWM24 : std_logic;
SIGNAL ww_DATA1 : std_logic;
SIGNAL ww_DATA2 : std_logic;
SIGNAL ww_DATA3 : std_logic;
SIGNAL ww_DATA4 : std_logic;
SIGNAL ww_DATA5 : std_logic;
SIGNAL ww_DATA6 : std_logic;
SIGNAL ww_DATA7 : std_logic;
SIGNAL ww_DATA8 : std_logic;
SIGNAL \spi_master_0|Add5~155\ : std_logic;
SIGNAL \clock~combout\ : std_logic;
SIGNAL \DATA4~combout\ : std_logic;
SIGNAL \DATA6~combout\ : std_logic;
SIGNAL \spi_master_0|Add1~0_combout\ : std_logic;
SIGNAL \DATA5~combout\ : std_logic;
SIGNAL \DATA7~combout\ : std_logic;
SIGNAL \spi_master_0|count[30]~1_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~157_cout\ : std_logic;
SIGNAL \spi_master_0|Add5~0_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~2\ : std_logic;
SIGNAL \spi_master_0|Add5~2COUT1_161\ : std_logic;
SIGNAL \spi_master_0|Add5~150_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~152\ : std_logic;
SIGNAL \spi_master_0|Add5~152COUT1_162\ : std_logic;
SIGNAL \spi_master_0|Add5~145_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~147\ : std_logic;
SIGNAL \spi_master_0|Add5~147COUT1_163\ : std_logic;
SIGNAL \spi_master_0|Add5~140_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~142\ : std_logic;
SIGNAL \spi_master_0|Add5~142COUT1_164\ : std_logic;
SIGNAL \spi_master_0|Add5~135_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~137\ : std_logic;
SIGNAL \spi_master_0|Add5~130_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~132\ : std_logic;
SIGNAL \spi_master_0|Add5~132COUT1_165\ : std_logic;
SIGNAL \spi_master_0|Add5~125_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~127\ : std_logic;
SIGNAL \spi_master_0|Add5~127COUT1_166\ : std_logic;
SIGNAL \spi_master_0|Add5~120_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~122\ : std_logic;
SIGNAL \spi_master_0|Add5~122COUT1_167\ : std_logic;
SIGNAL \spi_master_0|Add5~115_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~117\ : std_logic;
SIGNAL \spi_master_0|Add5~117COUT1_168\ : std_logic;
SIGNAL \spi_master_0|Add5~110_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~112\ : std_logic;
SIGNAL \spi_master_0|Add5~105_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~107\ : std_logic;
SIGNAL \spi_master_0|Add5~107COUT1_169\ : std_logic;
SIGNAL \spi_master_0|Add5~100_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~102\ : std_logic;
SIGNAL \spi_master_0|Add5~102COUT1_170\ : std_logic;
SIGNAL \spi_master_0|Add5~95_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~97\ : std_logic;
SIGNAL \spi_master_0|Add5~97COUT1_171\ : std_logic;
SIGNAL \spi_master_0|Add5~90_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~92\ : std_logic;
SIGNAL \spi_master_0|Add5~92COUT1_172\ : std_logic;
SIGNAL \spi_master_0|Add5~85_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~87\ : std_logic;
SIGNAL \spi_master_0|Add5~80_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~82\ : std_logic;
SIGNAL \spi_master_0|Add5~82COUT1_173\ : std_logic;
SIGNAL \spi_master_0|Add5~75_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~77\ : std_logic;
SIGNAL \spi_master_0|Add5~77COUT1_174\ : std_logic;
SIGNAL \spi_master_0|Add5~70_combout\ : std_logic;
SIGNAL \spi_master_0|Equal1~5_combout\ : std_logic;
SIGNAL \spi_master_0|Equal1~6_combout\ : std_logic;
SIGNAL \spi_master_0|Equal1~7_combout\ : std_logic;
SIGNAL \spi_master_0|Equal1~8_combout\ : std_logic;
SIGNAL \spi_master_0|Equal1~9_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~72\ : std_logic;
SIGNAL \spi_master_0|Add5~72COUT1_175\ : std_logic;
SIGNAL \spi_master_0|Add5~65_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~67\ : std_logic;
SIGNAL \spi_master_0|Add5~67COUT1_176\ : std_logic;
SIGNAL \spi_master_0|Add5~60_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~62\ : std_logic;
SIGNAL \spi_master_0|Add5~55_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~57\ : std_logic;
SIGNAL \spi_master_0|Add5~57COUT1_177\ : std_logic;
SIGNAL \spi_master_0|Add5~50_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~52\ : std_logic;
SIGNAL \spi_master_0|Add5~52COUT1_178\ : std_logic;
SIGNAL \spi_master_0|Add5~45_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~47\ : std_logic;
SIGNAL \spi_master_0|Add5~47COUT1_179\ : std_logic;
SIGNAL \spi_master_0|Add5~40_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~42\ : std_logic;
SIGNAL \spi_master_0|Add5~42COUT1_180\ : std_logic;
SIGNAL \spi_master_0|Add5~35_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~37\ : std_logic;
SIGNAL \spi_master_0|Add5~30_combout\ : std_logic;
SIGNAL \spi_master_0|Equal1~2_combout\ : std_logic;
SIGNAL \spi_master_0|Equal1~3_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~32\ : std_logic;
SIGNAL \spi_master_0|Add5~32COUT1_181\ : std_logic;
SIGNAL \spi_master_0|Add5~25_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~27\ : std_logic;
SIGNAL \spi_master_0|Add5~27COUT1_182\ : std_logic;
SIGNAL \spi_master_0|Add5~20_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~22\ : std_logic;
SIGNAL \spi_master_0|Add5~22COUT1_183\ : std_logic;
SIGNAL \spi_master_0|Add5~15_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~17\ : std_logic;
SIGNAL \spi_master_0|Add5~17COUT1_184\ : std_logic;
SIGNAL \spi_master_0|Add5~10_combout\ : std_logic;
SIGNAL \spi_master_0|Add5~12\ : std_logic;
SIGNAL \spi_master_0|Add5~5_combout\ : std_logic;
SIGNAL \spi_master_0|Equal1~0_combout\ : std_logic;
SIGNAL \spi_master_0|Equal1~1_combout\ : std_logic;
SIGNAL \spi_master_0|Equal1~4_combout\ : std_logic;
SIGNAL \spi_master_0|Equal1~10_combout\ : std_logic;
SIGNAL \spi_master_0|clk_toggles[4]~0_combout\ : std_logic;
SIGNAL \spi_master_0|Add1~2\ : std_logic;
SIGNAL \spi_master_0|Add1~2COUT1_26\ : std_logic;
SIGNAL \spi_master_0|Add1~20_combout\ : std_logic;
SIGNAL \spi_master_0|Add1~22\ : std_logic;
SIGNAL \spi_master_0|Add1~22COUT1_27\ : std_logic;
SIGNAL \spi_master_0|Add1~15_combout\ : std_logic;
SIGNAL \spi_master_0|Add1~17\ : std_logic;
SIGNAL \spi_master_0|Add1~17COUT1_28\ : std_logic;
SIGNAL \spi_master_0|Add1~10_combout\ : std_logic;
SIGNAL \spi_master_0|Equal3~0_combout\ : std_logic;
SIGNAL \spi_master_0|Equal3~1_combout\ : std_logic;
SIGNAL \spi_master_0|state~regout\ : std_logic;
SIGNAL \spi_master_0|Equal2~0_combout\ : std_logic;
SIGNAL \spi_master_0|process_0~1_combout\ : std_logic;
SIGNAL \spi_master_0|process_0~2_combout\ : std_logic;
SIGNAL \spi_master_0|Add1~12\ : std_logic;
SIGNAL \spi_master_0|Add1~12COUT1_29\ : std_logic;
SIGNAL \spi_master_0|Add1~5_combout\ : std_logic;
SIGNAL \spi_master_0|assert_data~regout\ : std_logic;
SIGNAL \spi_master_0|rx_buffer[0]~1_combout\ : std_logic;
SIGNAL \spi_master_0|ss_n~0_combout\ : std_logic;
SIGNAL \spi_master_0|process_0~0_combout\ : std_logic;
SIGNAL \spi_master_0|rx_buffer[0]~0_combout\ : std_logic;
SIGNAL \spi_master_0|rx_buffer[0]~2_combout\ : std_logic;
SIGNAL \spi_master_0|continue~regout\ : std_logic;
SIGNAL \spi_master_0|rx_data[0]~3_combout\ : std_logic;
SIGNAL \spi_master_0|rx_data[0]~2_combout\ : std_logic;
SIGNAL \spi_master_0|busy~regout\ : std_logic;
SIGNAL \spi_master_0|sclk~0_combout\ : std_logic;
SIGNAL \spi_master_0|sclk~1_combout\ : std_logic;
SIGNAL \spi_master_0|sclk~2_combout\ : std_logic;
SIGNAL \spi_master_0|sclk~regout\ : std_logic;
SIGNAL \spi_master_0|process_0~3_combout\ : std_logic;
SIGNAL \spi_master_0|process_0~4_combout\ : std_logic;
SIGNAL \spi_master_0|tx_buffer[7]~1_combout\ : std_logic;
SIGNAL \spi_master_0|tx_buffer[7]~2_combout\ : std_logic;
SIGNAL \spi_master_0|mosi~0_combout\ : std_logic;
SIGNAL \spi_master_0|mosi~reg0_regout\ : std_logic;
SIGNAL \spi_master_0|mosi~en_regout\ : std_logic;
SIGNAL \spi_master_0|rx_data\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \spi_master_0|ss_n\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \spi_master_0|rx_buffer\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \spi_master_0|clk_toggles\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \spi_master_0|slave\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \spi_master_0|count\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \spi_master_0|tx_buffer\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \ALT_INV_DATA7~combout\ : std_logic;
SIGNAL \spi_master_0|ALT_INV_ss_n\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \spi_master_0|ALT_INV_rx_data\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \spi_master_0|ALT_INV_state~regout\ : std_logic;

BEGIN

ww_clock <= clock;
ww_reset_n <= reset_n;
ww_trip <= trip;
PWM1 <= ww_PWM1;
PWM2 <= ww_PWM2;
PWM3 <= ww_PWM3;
PWM4 <= ww_PWM4;
PWM5 <= ww_PWM5;
PWM6 <= ww_PWM6;
PWM7 <= ww_PWM7;
PWM8 <= ww_PWM8;
PWM9 <= ww_PWM9;
PWM10 <= ww_PWM10;
PWM11 <= ww_PWM11;
PWM12 <= ww_PWM12;
PWM13 <= ww_PWM13;
PWM14 <= ww_PWM14;
PWM15 <= ww_PWM15;
PWM16 <= ww_PWM16;
PWM17 <= ww_PWM17;
PWM18 <= ww_PWM18;
PWM19 <= ww_PWM19;
PWM20 <= ww_PWM20;
PWM21 <= ww_PWM21;
PWM22 <= ww_PWM22;
PWM23 <= ww_PWM23;
PWM24 <= ww_PWM24;
DATA1 <= ww_DATA1;
DATA2 <= ww_DATA2;
DATA3 <= ww_DATA3;
ww_DATA4 <= DATA4;
ww_DATA5 <= DATA5;
ww_DATA6 <= DATA6;
ww_DATA7 <= DATA7;
ww_DATA8 <= DATA8;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_DATA7~combout\ <= NOT \DATA7~combout\;
\spi_master_0|ALT_INV_ss_n\(0) <= NOT \spi_master_0|ss_n\(0);
\spi_master_0|ALT_INV_rx_data\(7) <= NOT \spi_master_0|rx_data\(7);
\spi_master_0|ALT_INV_rx_data\(6) <= NOT \spi_master_0|rx_data\(6);
\spi_master_0|ALT_INV_rx_data\(5) <= NOT \spi_master_0|rx_data\(5);
\spi_master_0|ALT_INV_rx_data\(4) <= NOT \spi_master_0|rx_data\(4);
\spi_master_0|ALT_INV_rx_data\(3) <= NOT \spi_master_0|rx_data\(3);
\spi_master_0|ALT_INV_rx_data\(2) <= NOT \spi_master_0|rx_data\(2);
\spi_master_0|ALT_INV_rx_data\(1) <= NOT \spi_master_0|rx_data\(1);
\spi_master_0|ALT_INV_rx_data\(0) <= NOT \spi_master_0|rx_data\(0);
\spi_master_0|ALT_INV_state~regout\ <= NOT \spi_master_0|state~regout\;

-- Location: PIN_12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\clock~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_clock,
	combout => \clock~combout\);

-- Location: PIN_55,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\DATA4~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_DATA4,
	combout => \DATA4~combout\);

-- Location: PIN_57,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\DATA6~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_DATA6,
	combout => \DATA6~combout\);

-- Location: LC_X5_Y6_N0
\spi_master_0|Add1~0\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add1~0_combout\ = ((!\spi_master_0|clk_toggles\(0)))
-- \spi_master_0|Add1~2\ = CARRY(((\spi_master_0|clk_toggles\(0))))
-- \spi_master_0|Add1~2COUT1_26\ = CARRY(((\spi_master_0|clk_toggles\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "33cc",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|clk_toggles\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add1~0_combout\,
	cout0 => \spi_master_0|Add1~2\,
	cout1 => \spi_master_0|Add1~2COUT1_26\);

-- Location: PIN_56,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\DATA5~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_DATA5,
	combout => \DATA5~combout\);

-- Location: PIN_58,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\DATA7~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_DATA7,
	combout => \DATA7~combout\);

-- Location: LC_X8_Y6_N0
\spi_master_0|count[30]~1\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count[30]~1_combout\ = ((\DATA7~combout\ & ((\spi_master_0|state~regout\) # (\DATA5~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccc0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \DATA7~combout\,
	datac => \spi_master_0|state~regout\,
	datad => \DATA5~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|count[30]~1_combout\);

-- Location: LC_X8_Y5_N7
\spi_master_0|count[0]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(0) = DFFEAS((((!\spi_master_0|count\(0) & !\spi_master_0|Equal1~10_combout\))) # (!\spi_master_0|state~regout\), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "555f",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datac => \spi_master_0|count\(0),
	datad => \spi_master_0|Equal1~10_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(0));

-- Location: LC_X9_Y5_N4
\spi_master_0|Add5~157\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~157_cout\ = CARRY(((!\spi_master_0|count\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff33",
	operation_mode => "arithmetic",
	output_mode => "none",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~155\,
	cout => \spi_master_0|Add5~157_cout\);

-- Location: LC_X9_Y5_N5
\spi_master_0|Add5~0\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~0_combout\ = (\spi_master_0|count\(1) $ ((\spi_master_0|Add5~157_cout\)))
-- \spi_master_0|Add5~2\ = CARRY(((!\spi_master_0|Add5~157_cout\) # (!\spi_master_0|count\(1))))
-- \spi_master_0|Add5~2COUT1_161\ = CARRY(((!\spi_master_0|Add5~157_cout\) # (!\spi_master_0|count\(1))))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "3c3f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(1),
	cin => \spi_master_0|Add5~157_cout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~0_combout\,
	cout0 => \spi_master_0|Add5~2\,
	cout1 => \spi_master_0|Add5~2COUT1_161\);

-- Location: LC_X9_Y5_N1
\spi_master_0|count[1]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(1) = DFFEAS((((\spi_master_0|Add5~0_combout\ & !\spi_master_0|Equal1~10_combout\)) # (!\spi_master_0|state~regout\)), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "33f3",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|Add5~0_combout\,
	datad => \spi_master_0|Equal1~10_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(1));

-- Location: LC_X9_Y5_N6
\spi_master_0|Add5~150\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~150_combout\ = (\spi_master_0|count\(2) $ ((!(!\spi_master_0|Add5~157_cout\ & \spi_master_0|Add5~2\) # (\spi_master_0|Add5~157_cout\ & \spi_master_0|Add5~2COUT1_161\))))
-- \spi_master_0|Add5~152\ = CARRY(((\spi_master_0|count\(2) & !\spi_master_0|Add5~2\)))
-- \spi_master_0|Add5~152COUT1_162\ = CARRY(((\spi_master_0|count\(2) & !\spi_master_0|Add5~2COUT1_161\)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "c30c",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(2),
	cin => \spi_master_0|Add5~157_cout\,
	cin0 => \spi_master_0|Add5~2\,
	cin1 => \spi_master_0|Add5~2COUT1_161\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~150_combout\,
	cout0 => \spi_master_0|Add5~152\,
	cout1 => \spi_master_0|Add5~152COUT1_162\);

-- Location: LC_X9_Y5_N0
\spi_master_0|count[2]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(2) = DFFEAS(((\spi_master_0|state~regout\ & (\spi_master_0|Add5~150_combout\ & !\spi_master_0|Equal1~10_combout\))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00c0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|Add5~150_combout\,
	datad => \spi_master_0|Equal1~10_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(2));

-- Location: LC_X9_Y5_N7
\spi_master_0|Add5~145\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~145_combout\ = (\spi_master_0|count\(3) $ (((!\spi_master_0|Add5~157_cout\ & \spi_master_0|Add5~152\) # (\spi_master_0|Add5~157_cout\ & \spi_master_0|Add5~152COUT1_162\))))
-- \spi_master_0|Add5~147\ = CARRY(((!\spi_master_0|Add5~152\) # (!\spi_master_0|count\(3))))
-- \spi_master_0|Add5~147COUT1_163\ = CARRY(((!\spi_master_0|Add5~152COUT1_162\) # (!\spi_master_0|count\(3))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "3c3f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(3),
	cin => \spi_master_0|Add5~157_cout\,
	cin0 => \spi_master_0|Add5~152\,
	cin1 => \spi_master_0|Add5~152COUT1_162\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~145_combout\,
	cout0 => \spi_master_0|Add5~147\,
	cout1 => \spi_master_0|Add5~147COUT1_163\);

-- Location: LC_X7_Y5_N3
\spi_master_0|count[3]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(3) = DFFEAS(((\spi_master_0|state~regout\ & (!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~145_combout\))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0c00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~145_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(3));

-- Location: LC_X9_Y5_N8
\spi_master_0|Add5~140\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~140_combout\ = \spi_master_0|count\(4) $ ((((!(!\spi_master_0|Add5~157_cout\ & \spi_master_0|Add5~147\) # (\spi_master_0|Add5~157_cout\ & \spi_master_0|Add5~147COUT1_163\)))))
-- \spi_master_0|Add5~142\ = CARRY((\spi_master_0|count\(4) & ((!\spi_master_0|Add5~147\))))
-- \spi_master_0|Add5~142COUT1_164\ = CARRY((\spi_master_0|count\(4) & ((!\spi_master_0|Add5~147COUT1_163\))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "a50a",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(4),
	cin => \spi_master_0|Add5~157_cout\,
	cin0 => \spi_master_0|Add5~147\,
	cin1 => \spi_master_0|Add5~147COUT1_163\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~140_combout\,
	cout0 => \spi_master_0|Add5~142\,
	cout1 => \spi_master_0|Add5~142COUT1_164\);

-- Location: LC_X6_Y5_N8
\spi_master_0|count[4]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(4) = DFFEAS((\spi_master_0|state~regout\ & (\spi_master_0|Add5~140_combout\ & ((!\spi_master_0|Equal1~10_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0088",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datab => \spi_master_0|Add5~140_combout\,
	datad => \spi_master_0|Equal1~10_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(4));

-- Location: LC_X9_Y5_N9
\spi_master_0|Add5~135\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~135_combout\ = (\spi_master_0|count\(5) $ (((!\spi_master_0|Add5~157_cout\ & \spi_master_0|Add5~142\) # (\spi_master_0|Add5~157_cout\ & \spi_master_0|Add5~142COUT1_164\))))
-- \spi_master_0|Add5~137\ = CARRY(((!\spi_master_0|Add5~142COUT1_164\) # (!\spi_master_0|count\(5))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "3c3f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(5),
	cin => \spi_master_0|Add5~157_cout\,
	cin0 => \spi_master_0|Add5~142\,
	cin1 => \spi_master_0|Add5~142COUT1_164\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~135_combout\,
	cout => \spi_master_0|Add5~137\);

-- Location: LC_X7_Y5_N9
\spi_master_0|count[5]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(5) = DFFEAS(((\spi_master_0|state~regout\ & (!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~135_combout\))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0c00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~135_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(5));

-- Location: LC_X10_Y5_N0
\spi_master_0|Add5~130\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~130_combout\ = (\spi_master_0|count\(6) $ ((!\spi_master_0|Add5~137\)))
-- \spi_master_0|Add5~132\ = CARRY(((\spi_master_0|count\(6) & !\spi_master_0|Add5~137\)))
-- \spi_master_0|Add5~132COUT1_165\ = CARRY(((\spi_master_0|count\(6) & !\spi_master_0|Add5~137\)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "c30c",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(6),
	cin => \spi_master_0|Add5~137\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~130_combout\,
	cout0 => \spi_master_0|Add5~132\,
	cout1 => \spi_master_0|Add5~132COUT1_165\);

-- Location: LC_X7_Y5_N7
\spi_master_0|count[6]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(6) = DFFEAS((!\spi_master_0|Equal1~10_combout\ & (((\spi_master_0|Add5~130_combout\ & \spi_master_0|state~regout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "5000",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|Equal1~10_combout\,
	datac => \spi_master_0|Add5~130_combout\,
	datad => \spi_master_0|state~regout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(6));

-- Location: LC_X10_Y5_N1
\spi_master_0|Add5~125\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~125_combout\ = (\spi_master_0|count\(7) $ (((!\spi_master_0|Add5~137\ & \spi_master_0|Add5~132\) # (\spi_master_0|Add5~137\ & \spi_master_0|Add5~132COUT1_165\))))
-- \spi_master_0|Add5~127\ = CARRY(((!\spi_master_0|Add5~132\) # (!\spi_master_0|count\(7))))
-- \spi_master_0|Add5~127COUT1_166\ = CARRY(((!\spi_master_0|Add5~132COUT1_165\) # (!\spi_master_0|count\(7))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "3c3f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(7),
	cin => \spi_master_0|Add5~137\,
	cin0 => \spi_master_0|Add5~132\,
	cin1 => \spi_master_0|Add5~132COUT1_165\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~125_combout\,
	cout0 => \spi_master_0|Add5~127\,
	cout1 => \spi_master_0|Add5~127COUT1_166\);

-- Location: LC_X7_Y5_N1
\spi_master_0|count[7]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(7) = DFFEAS((!\spi_master_0|Equal1~10_combout\ & (\spi_master_0|state~regout\ & (\spi_master_0|Add5~125_combout\))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "4040",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|Equal1~10_combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|Add5~125_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(7));

-- Location: LC_X10_Y5_N2
\spi_master_0|Add5~120\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~120_combout\ = (\spi_master_0|count\(8) $ ((!(!\spi_master_0|Add5~137\ & \spi_master_0|Add5~127\) # (\spi_master_0|Add5~137\ & \spi_master_0|Add5~127COUT1_166\))))
-- \spi_master_0|Add5~122\ = CARRY(((\spi_master_0|count\(8) & !\spi_master_0|Add5~127\)))
-- \spi_master_0|Add5~122COUT1_167\ = CARRY(((\spi_master_0|count\(8) & !\spi_master_0|Add5~127COUT1_166\)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "c30c",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(8),
	cin => \spi_master_0|Add5~137\,
	cin0 => \spi_master_0|Add5~127\,
	cin1 => \spi_master_0|Add5~127COUT1_166\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~120_combout\,
	cout0 => \spi_master_0|Add5~122\,
	cout1 => \spi_master_0|Add5~122COUT1_167\);

-- Location: LC_X7_Y5_N4
\spi_master_0|count[8]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(8) = DFFEAS(((\spi_master_0|state~regout\ & (!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~120_combout\))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0c00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~120_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(8));

-- Location: LC_X10_Y5_N3
\spi_master_0|Add5~115\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~115_combout\ = (\spi_master_0|count\(9) $ (((!\spi_master_0|Add5~137\ & \spi_master_0|Add5~122\) # (\spi_master_0|Add5~137\ & \spi_master_0|Add5~122COUT1_167\))))
-- \spi_master_0|Add5~117\ = CARRY(((!\spi_master_0|Add5~122\) # (!\spi_master_0|count\(9))))
-- \spi_master_0|Add5~117COUT1_168\ = CARRY(((!\spi_master_0|Add5~122COUT1_167\) # (!\spi_master_0|count\(9))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "3c3f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(9),
	cin => \spi_master_0|Add5~137\,
	cin0 => \spi_master_0|Add5~122\,
	cin1 => \spi_master_0|Add5~122COUT1_167\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~115_combout\,
	cout0 => \spi_master_0|Add5~117\,
	cout1 => \spi_master_0|Add5~117COUT1_168\);

-- Location: LC_X7_Y5_N8
\spi_master_0|count[9]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(9) = DFFEAS(((\spi_master_0|state~regout\ & (!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~115_combout\))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0c00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~115_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(9));

-- Location: LC_X10_Y5_N4
\spi_master_0|Add5~110\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~110_combout\ = \spi_master_0|count\(10) $ ((((!(!\spi_master_0|Add5~137\ & \spi_master_0|Add5~117\) # (\spi_master_0|Add5~137\ & \spi_master_0|Add5~117COUT1_168\)))))
-- \spi_master_0|Add5~112\ = CARRY((\spi_master_0|count\(10) & ((!\spi_master_0|Add5~117COUT1_168\))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "a50a",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(10),
	cin => \spi_master_0|Add5~137\,
	cin0 => \spi_master_0|Add5~117\,
	cin1 => \spi_master_0|Add5~117COUT1_168\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~110_combout\,
	cout => \spi_master_0|Add5~112\);

-- Location: LC_X6_Y5_N0
\spi_master_0|count[10]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(10) = DFFEAS((\spi_master_0|state~regout\ & (((!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~110_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0a00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~110_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(10));

-- Location: LC_X10_Y5_N5
\spi_master_0|Add5~105\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~105_combout\ = (\spi_master_0|count\(11) $ ((\spi_master_0|Add5~112\)))
-- \spi_master_0|Add5~107\ = CARRY(((!\spi_master_0|Add5~112\) # (!\spi_master_0|count\(11))))
-- \spi_master_0|Add5~107COUT1_169\ = CARRY(((!\spi_master_0|Add5~112\) # (!\spi_master_0|count\(11))))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "3c3f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(11),
	cin => \spi_master_0|Add5~112\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~105_combout\,
	cout0 => \spi_master_0|Add5~107\,
	cout1 => \spi_master_0|Add5~107COUT1_169\);

-- Location: LC_X6_Y5_N4
\spi_master_0|count[11]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(11) = DFFEAS((\spi_master_0|state~regout\ & (((!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~105_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0a00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~105_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(11));

-- Location: LC_X10_Y5_N6
\spi_master_0|Add5~100\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~100_combout\ = (\spi_master_0|count\(12) $ ((!(!\spi_master_0|Add5~112\ & \spi_master_0|Add5~107\) # (\spi_master_0|Add5~112\ & \spi_master_0|Add5~107COUT1_169\))))
-- \spi_master_0|Add5~102\ = CARRY(((\spi_master_0|count\(12) & !\spi_master_0|Add5~107\)))
-- \spi_master_0|Add5~102COUT1_170\ = CARRY(((\spi_master_0|count\(12) & !\spi_master_0|Add5~107COUT1_169\)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "c30c",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(12),
	cin => \spi_master_0|Add5~112\,
	cin0 => \spi_master_0|Add5~107\,
	cin1 => \spi_master_0|Add5~107COUT1_169\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~100_combout\,
	cout0 => \spi_master_0|Add5~102\,
	cout1 => \spi_master_0|Add5~102COUT1_170\);

-- Location: LC_X6_Y5_N9
\spi_master_0|count[12]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(12) = DFFEAS((\spi_master_0|state~regout\ & (((!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~100_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0a00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~100_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(12));

-- Location: LC_X10_Y5_N7
\spi_master_0|Add5~95\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~95_combout\ = (\spi_master_0|count\(13) $ (((!\spi_master_0|Add5~112\ & \spi_master_0|Add5~102\) # (\spi_master_0|Add5~112\ & \spi_master_0|Add5~102COUT1_170\))))
-- \spi_master_0|Add5~97\ = CARRY(((!\spi_master_0|Add5~102\) # (!\spi_master_0|count\(13))))
-- \spi_master_0|Add5~97COUT1_171\ = CARRY(((!\spi_master_0|Add5~102COUT1_170\) # (!\spi_master_0|count\(13))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "3c3f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(13),
	cin => \spi_master_0|Add5~112\,
	cin0 => \spi_master_0|Add5~102\,
	cin1 => \spi_master_0|Add5~102COUT1_170\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~95_combout\,
	cout0 => \spi_master_0|Add5~97\,
	cout1 => \spi_master_0|Add5~97COUT1_171\);

-- Location: LC_X6_Y5_N3
\spi_master_0|count[13]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(13) = DFFEAS((\spi_master_0|state~regout\ & (((!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~95_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0a00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~95_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(13));

-- Location: LC_X10_Y5_N8
\spi_master_0|Add5~90\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~90_combout\ = \spi_master_0|count\(14) $ ((((!(!\spi_master_0|Add5~112\ & \spi_master_0|Add5~97\) # (\spi_master_0|Add5~112\ & \spi_master_0|Add5~97COUT1_171\)))))
-- \spi_master_0|Add5~92\ = CARRY((\spi_master_0|count\(14) & ((!\spi_master_0|Add5~97\))))
-- \spi_master_0|Add5~92COUT1_172\ = CARRY((\spi_master_0|count\(14) & ((!\spi_master_0|Add5~97COUT1_171\))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "a50a",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(14),
	cin => \spi_master_0|Add5~112\,
	cin0 => \spi_master_0|Add5~97\,
	cin1 => \spi_master_0|Add5~97COUT1_171\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~90_combout\,
	cout0 => \spi_master_0|Add5~92\,
	cout1 => \spi_master_0|Add5~92COUT1_172\);

-- Location: LC_X6_Y5_N2
\spi_master_0|count[14]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(14) = DFFEAS((\spi_master_0|state~regout\ & (((!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~90_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0a00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~90_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(14));

-- Location: LC_X10_Y5_N9
\spi_master_0|Add5~85\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~85_combout\ = (\spi_master_0|count\(15) $ (((!\spi_master_0|Add5~112\ & \spi_master_0|Add5~92\) # (\spi_master_0|Add5~112\ & \spi_master_0|Add5~92COUT1_172\))))
-- \spi_master_0|Add5~87\ = CARRY(((!\spi_master_0|Add5~92COUT1_172\) # (!\spi_master_0|count\(15))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "3c3f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(15),
	cin => \spi_master_0|Add5~112\,
	cin0 => \spi_master_0|Add5~92\,
	cin1 => \spi_master_0|Add5~92COUT1_172\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~85_combout\,
	cout => \spi_master_0|Add5~87\);

-- Location: LC_X5_Y5_N9
\spi_master_0|count[15]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(15) = DFFEAS(((\spi_master_0|state~regout\ & (\spi_master_0|Add5~85_combout\ & !\spi_master_0|Equal1~10_combout\))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00c0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|Add5~85_combout\,
	datad => \spi_master_0|Equal1~10_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(15));

-- Location: LC_X11_Y5_N0
\spi_master_0|Add5~80\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~80_combout\ = \spi_master_0|count\(16) $ ((((!\spi_master_0|Add5~87\))))
-- \spi_master_0|Add5~82\ = CARRY((\spi_master_0|count\(16) & ((!\spi_master_0|Add5~87\))))
-- \spi_master_0|Add5~82COUT1_173\ = CARRY((\spi_master_0|count\(16) & ((!\spi_master_0|Add5~87\))))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "a50a",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(16),
	cin => \spi_master_0|Add5~87\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~80_combout\,
	cout0 => \spi_master_0|Add5~82\,
	cout1 => \spi_master_0|Add5~82COUT1_173\);

-- Location: LC_X6_Y5_N1
\spi_master_0|count[16]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(16) = DFFEAS((\spi_master_0|state~regout\ & (((!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~80_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0a00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~80_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(16));

-- Location: LC_X11_Y5_N1
\spi_master_0|Add5~75\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~75_combout\ = (\spi_master_0|count\(17) $ (((!\spi_master_0|Add5~87\ & \spi_master_0|Add5~82\) # (\spi_master_0|Add5~87\ & \spi_master_0|Add5~82COUT1_173\))))
-- \spi_master_0|Add5~77\ = CARRY(((!\spi_master_0|Add5~82\) # (!\spi_master_0|count\(17))))
-- \spi_master_0|Add5~77COUT1_174\ = CARRY(((!\spi_master_0|Add5~82COUT1_173\) # (!\spi_master_0|count\(17))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "3c3f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(17),
	cin => \spi_master_0|Add5~87\,
	cin0 => \spi_master_0|Add5~82\,
	cin1 => \spi_master_0|Add5~82COUT1_173\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~75_combout\,
	cout0 => \spi_master_0|Add5~77\,
	cout1 => \spi_master_0|Add5~77COUT1_174\);

-- Location: LC_X6_Y5_N6
\spi_master_0|count[17]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(17) = DFFEAS((\spi_master_0|state~regout\ & (((!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~75_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0a00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~75_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(17));

-- Location: LC_X11_Y5_N2
\spi_master_0|Add5~70\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~70_combout\ = (\spi_master_0|count\(18) $ ((!(!\spi_master_0|Add5~87\ & \spi_master_0|Add5~77\) # (\spi_master_0|Add5~87\ & \spi_master_0|Add5~77COUT1_174\))))
-- \spi_master_0|Add5~72\ = CARRY(((\spi_master_0|count\(18) & !\spi_master_0|Add5~77\)))
-- \spi_master_0|Add5~72COUT1_175\ = CARRY(((\spi_master_0|count\(18) & !\spi_master_0|Add5~77COUT1_174\)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "c30c",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(18),
	cin => \spi_master_0|Add5~87\,
	cin0 => \spi_master_0|Add5~77\,
	cin1 => \spi_master_0|Add5~77COUT1_174\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~70_combout\,
	cout0 => \spi_master_0|Add5~72\,
	cout1 => \spi_master_0|Add5~72COUT1_175\);

-- Location: LC_X5_Y5_N5
\spi_master_0|count[18]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(18) = DFFEAS(((\spi_master_0|state~regout\ & (!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~70_combout\))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0c00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~70_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(18));

-- Location: LC_X6_Y5_N5
\spi_master_0|Equal1~5\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Equal1~5_combout\ = (!\spi_master_0|count\(17) & (!\spi_master_0|count\(16) & (!\spi_master_0|count\(15) & !\spi_master_0|count\(18))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(17),
	datab => \spi_master_0|count\(16),
	datac => \spi_master_0|count\(15),
	datad => \spi_master_0|count\(18),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Equal1~5_combout\);

-- Location: LC_X6_Y5_N7
\spi_master_0|Equal1~6\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Equal1~6_combout\ = (!\spi_master_0|count\(13) & (!\spi_master_0|count\(12) & (!\spi_master_0|count\(11) & !\spi_master_0|count\(14))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(13),
	datab => \spi_master_0|count\(12),
	datac => \spi_master_0|count\(11),
	datad => \spi_master_0|count\(14),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Equal1~6_combout\);

-- Location: LC_X7_Y5_N0
\spi_master_0|Equal1~7\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Equal1~7_combout\ = (!\spi_master_0|count\(10) & (!\spi_master_0|count\(7) & (!\spi_master_0|count\(8) & !\spi_master_0|count\(9))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(10),
	datab => \spi_master_0|count\(7),
	datac => \spi_master_0|count\(8),
	datad => \spi_master_0|count\(9),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Equal1~7_combout\);

-- Location: LC_X7_Y5_N2
\spi_master_0|Equal1~8\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Equal1~8_combout\ = (!\spi_master_0|count\(4) & (!\spi_master_0|count\(6) & (!\spi_master_0|count\(5) & !\spi_master_0|count\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(4),
	datab => \spi_master_0|count\(6),
	datac => \spi_master_0|count\(5),
	datad => \spi_master_0|count\(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Equal1~8_combout\);

-- Location: LC_X7_Y5_N6
\spi_master_0|Equal1~9\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Equal1~9_combout\ = (\spi_master_0|Equal1~5_combout\ & (\spi_master_0|Equal1~6_combout\ & (\spi_master_0|Equal1~7_combout\ & \spi_master_0|Equal1~8_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "8000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|Equal1~5_combout\,
	datab => \spi_master_0|Equal1~6_combout\,
	datac => \spi_master_0|Equal1~7_combout\,
	datad => \spi_master_0|Equal1~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Equal1~9_combout\);

-- Location: LC_X11_Y5_N3
\spi_master_0|Add5~65\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~65_combout\ = \spi_master_0|count\(19) $ (((((!\spi_master_0|Add5~87\ & \spi_master_0|Add5~72\) # (\spi_master_0|Add5~87\ & \spi_master_0|Add5~72COUT1_175\)))))
-- \spi_master_0|Add5~67\ = CARRY(((!\spi_master_0|Add5~72\)) # (!\spi_master_0|count\(19)))
-- \spi_master_0|Add5~67COUT1_176\ = CARRY(((!\spi_master_0|Add5~72COUT1_175\)) # (!\spi_master_0|count\(19)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "5a5f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(19),
	cin => \spi_master_0|Add5~87\,
	cin0 => \spi_master_0|Add5~72\,
	cin1 => \spi_master_0|Add5~72COUT1_175\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~65_combout\,
	cout0 => \spi_master_0|Add5~67\,
	cout1 => \spi_master_0|Add5~67COUT1_176\);

-- Location: LC_X9_Y6_N7
\spi_master_0|count[19]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(19) = DFFEAS((\spi_master_0|state~regout\ & (((!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~65_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0a00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~65_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(19));

-- Location: LC_X11_Y5_N4
\spi_master_0|Add5~60\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~60_combout\ = \spi_master_0|count\(20) $ ((((!(!\spi_master_0|Add5~87\ & \spi_master_0|Add5~67\) # (\spi_master_0|Add5~87\ & \spi_master_0|Add5~67COUT1_176\)))))
-- \spi_master_0|Add5~62\ = CARRY((\spi_master_0|count\(20) & ((!\spi_master_0|Add5~67COUT1_176\))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "a50a",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(20),
	cin => \spi_master_0|Add5~87\,
	cin0 => \spi_master_0|Add5~67\,
	cin1 => \spi_master_0|Add5~67COUT1_176\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~60_combout\,
	cout => \spi_master_0|Add5~62\);

-- Location: LC_X9_Y6_N9
\spi_master_0|count[20]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(20) = DFFEAS((\spi_master_0|state~regout\ & (((!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~60_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0a00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~60_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(20));

-- Location: LC_X11_Y5_N5
\spi_master_0|Add5~55\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~55_combout\ = (\spi_master_0|count\(21) $ ((\spi_master_0|Add5~62\)))
-- \spi_master_0|Add5~57\ = CARRY(((!\spi_master_0|Add5~62\) # (!\spi_master_0|count\(21))))
-- \spi_master_0|Add5~57COUT1_177\ = CARRY(((!\spi_master_0|Add5~62\) # (!\spi_master_0|count\(21))))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "3c3f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(21),
	cin => \spi_master_0|Add5~62\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~55_combout\,
	cout0 => \spi_master_0|Add5~57\,
	cout1 => \spi_master_0|Add5~57COUT1_177\);

-- Location: LC_X9_Y6_N3
\spi_master_0|count[21]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(21) = DFFEAS((\spi_master_0|state~regout\ & (((!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~55_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0a00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~55_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(21));

-- Location: LC_X11_Y5_N6
\spi_master_0|Add5~50\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~50_combout\ = (\spi_master_0|count\(22) $ ((!(!\spi_master_0|Add5~62\ & \spi_master_0|Add5~57\) # (\spi_master_0|Add5~62\ & \spi_master_0|Add5~57COUT1_177\))))
-- \spi_master_0|Add5~52\ = CARRY(((\spi_master_0|count\(22) & !\spi_master_0|Add5~57\)))
-- \spi_master_0|Add5~52COUT1_178\ = CARRY(((\spi_master_0|count\(22) & !\spi_master_0|Add5~57COUT1_177\)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "c30c",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(22),
	cin => \spi_master_0|Add5~62\,
	cin0 => \spi_master_0|Add5~57\,
	cin1 => \spi_master_0|Add5~57COUT1_177\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~50_combout\,
	cout0 => \spi_master_0|Add5~52\,
	cout1 => \spi_master_0|Add5~52COUT1_178\);

-- Location: LC_X9_Y6_N8
\spi_master_0|count[22]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(22) = DFFEAS((\spi_master_0|state~regout\ & (((!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~50_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0a00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~50_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(22));

-- Location: LC_X11_Y5_N7
\spi_master_0|Add5~45\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~45_combout\ = (\spi_master_0|count\(23) $ (((!\spi_master_0|Add5~62\ & \spi_master_0|Add5~52\) # (\spi_master_0|Add5~62\ & \spi_master_0|Add5~52COUT1_178\))))
-- \spi_master_0|Add5~47\ = CARRY(((!\spi_master_0|Add5~52\) # (!\spi_master_0|count\(23))))
-- \spi_master_0|Add5~47COUT1_179\ = CARRY(((!\spi_master_0|Add5~52COUT1_178\) # (!\spi_master_0|count\(23))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "3c3f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(23),
	cin => \spi_master_0|Add5~62\,
	cin0 => \spi_master_0|Add5~52\,
	cin1 => \spi_master_0|Add5~52COUT1_178\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~45_combout\,
	cout0 => \spi_master_0|Add5~47\,
	cout1 => \spi_master_0|Add5~47COUT1_179\);

-- Location: LC_X8_Y5_N8
\spi_master_0|count[23]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(23) = DFFEAS((\spi_master_0|state~regout\ & (((\spi_master_0|Add5~45_combout\ & !\spi_master_0|Equal1~10_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00a0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datac => \spi_master_0|Add5~45_combout\,
	datad => \spi_master_0|Equal1~10_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(23));

-- Location: LC_X11_Y5_N8
\spi_master_0|Add5~40\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~40_combout\ = (\spi_master_0|count\(24) $ ((!(!\spi_master_0|Add5~62\ & \spi_master_0|Add5~47\) # (\spi_master_0|Add5~62\ & \spi_master_0|Add5~47COUT1_179\))))
-- \spi_master_0|Add5~42\ = CARRY(((\spi_master_0|count\(24) & !\spi_master_0|Add5~47\)))
-- \spi_master_0|Add5~42COUT1_180\ = CARRY(((\spi_master_0|count\(24) & !\spi_master_0|Add5~47COUT1_179\)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "c30c",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(24),
	cin => \spi_master_0|Add5~62\,
	cin0 => \spi_master_0|Add5~47\,
	cin1 => \spi_master_0|Add5~47COUT1_179\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~40_combout\,
	cout0 => \spi_master_0|Add5~42\,
	cout1 => \spi_master_0|Add5~42COUT1_180\);

-- Location: LC_X8_Y5_N2
\spi_master_0|count[24]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(24) = DFFEAS((\spi_master_0|state~regout\ & (((\spi_master_0|Add5~40_combout\ & !\spi_master_0|Equal1~10_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00a0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datac => \spi_master_0|Add5~40_combout\,
	datad => \spi_master_0|Equal1~10_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(24));

-- Location: LC_X11_Y5_N9
\spi_master_0|Add5~35\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~35_combout\ = (\spi_master_0|count\(25) $ (((!\spi_master_0|Add5~62\ & \spi_master_0|Add5~42\) # (\spi_master_0|Add5~62\ & \spi_master_0|Add5~42COUT1_180\))))
-- \spi_master_0|Add5~37\ = CARRY(((!\spi_master_0|Add5~42COUT1_180\) # (!\spi_master_0|count\(25))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "3c3f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(25),
	cin => \spi_master_0|Add5~62\,
	cin0 => \spi_master_0|Add5~42\,
	cin1 => \spi_master_0|Add5~42COUT1_180\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~35_combout\,
	cout => \spi_master_0|Add5~37\);

-- Location: LC_X8_Y5_N9
\spi_master_0|count[25]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(25) = DFFEAS((\spi_master_0|state~regout\ & (((\spi_master_0|Add5~35_combout\ & !\spi_master_0|Equal1~10_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00a0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datac => \spi_master_0|Add5~35_combout\,
	datad => \spi_master_0|Equal1~10_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(25));

-- Location: LC_X12_Y5_N0
\spi_master_0|Add5~30\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~30_combout\ = (\spi_master_0|count\(26) $ ((!\spi_master_0|Add5~37\)))
-- \spi_master_0|Add5~32\ = CARRY(((\spi_master_0|count\(26) & !\spi_master_0|Add5~37\)))
-- \spi_master_0|Add5~32COUT1_181\ = CARRY(((\spi_master_0|count\(26) & !\spi_master_0|Add5~37\)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "c30c",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(26),
	cin => \spi_master_0|Add5~37\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~30_combout\,
	cout0 => \spi_master_0|Add5~32\,
	cout1 => \spi_master_0|Add5~32COUT1_181\);

-- Location: LC_X8_Y5_N4
\spi_master_0|count[26]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(26) = DFFEAS((\spi_master_0|state~regout\ & (((\spi_master_0|Add5~30_combout\ & !\spi_master_0|Equal1~10_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00a0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datac => \spi_master_0|Add5~30_combout\,
	datad => \spi_master_0|Equal1~10_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(26));

-- Location: LC_X8_Y5_N5
\spi_master_0|Equal1~2\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Equal1~2_combout\ = (!\spi_master_0|count\(26) & (!\spi_master_0|count\(25) & (!\spi_master_0|count\(24) & !\spi_master_0|count\(23))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(26),
	datab => \spi_master_0|count\(25),
	datac => \spi_master_0|count\(24),
	datad => \spi_master_0|count\(23),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Equal1~2_combout\);

-- Location: LC_X9_Y6_N6
\spi_master_0|Equal1~3\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Equal1~3_combout\ = (!\spi_master_0|count\(21) & (!\spi_master_0|count\(20) & (!\spi_master_0|count\(19) & !\spi_master_0|count\(22))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(21),
	datab => \spi_master_0|count\(20),
	datac => \spi_master_0|count\(19),
	datad => \spi_master_0|count\(22),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Equal1~3_combout\);

-- Location: LC_X12_Y5_N1
\spi_master_0|Add5~25\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~25_combout\ = \spi_master_0|count\(27) $ (((((!\spi_master_0|Add5~37\ & \spi_master_0|Add5~32\) # (\spi_master_0|Add5~37\ & \spi_master_0|Add5~32COUT1_181\)))))
-- \spi_master_0|Add5~27\ = CARRY(((!\spi_master_0|Add5~32\)) # (!\spi_master_0|count\(27)))
-- \spi_master_0|Add5~27COUT1_182\ = CARRY(((!\spi_master_0|Add5~32COUT1_181\)) # (!\spi_master_0|count\(27)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "5a5f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(27),
	cin => \spi_master_0|Add5~37\,
	cin0 => \spi_master_0|Add5~32\,
	cin1 => \spi_master_0|Add5~32COUT1_181\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~25_combout\,
	cout0 => \spi_master_0|Add5~27\,
	cout1 => \spi_master_0|Add5~27COUT1_182\);

-- Location: LC_X9_Y5_N2
\spi_master_0|count[27]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(27) = DFFEAS(((\spi_master_0|state~regout\ & (\spi_master_0|Add5~25_combout\ & !\spi_master_0|Equal1~10_combout\))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00c0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|Add5~25_combout\,
	datad => \spi_master_0|Equal1~10_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(27));

-- Location: LC_X12_Y5_N2
\spi_master_0|Add5~20\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~20_combout\ = \spi_master_0|count\(28) $ ((((!(!\spi_master_0|Add5~37\ & \spi_master_0|Add5~27\) # (\spi_master_0|Add5~37\ & \spi_master_0|Add5~27COUT1_182\)))))
-- \spi_master_0|Add5~22\ = CARRY((\spi_master_0|count\(28) & ((!\spi_master_0|Add5~27\))))
-- \spi_master_0|Add5~22COUT1_183\ = CARRY((\spi_master_0|count\(28) & ((!\spi_master_0|Add5~27COUT1_182\))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "a50a",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(28),
	cin => \spi_master_0|Add5~37\,
	cin0 => \spi_master_0|Add5~27\,
	cin1 => \spi_master_0|Add5~27COUT1_182\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~20_combout\,
	cout0 => \spi_master_0|Add5~22\,
	cout1 => \spi_master_0|Add5~22COUT1_183\);

-- Location: LC_X8_Y5_N3
\spi_master_0|count[28]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(28) = DFFEAS((\spi_master_0|state~regout\ & (\spi_master_0|Add5~20_combout\ & ((!\spi_master_0|Equal1~10_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0088",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datab => \spi_master_0|Add5~20_combout\,
	datad => \spi_master_0|Equal1~10_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(28));

-- Location: LC_X12_Y5_N3
\spi_master_0|Add5~15\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~15_combout\ = \spi_master_0|count\(29) $ (((((!\spi_master_0|Add5~37\ & \spi_master_0|Add5~22\) # (\spi_master_0|Add5~37\ & \spi_master_0|Add5~22COUT1_183\)))))
-- \spi_master_0|Add5~17\ = CARRY(((!\spi_master_0|Add5~22\)) # (!\spi_master_0|count\(29)))
-- \spi_master_0|Add5~17COUT1_184\ = CARRY(((!\spi_master_0|Add5~22COUT1_183\)) # (!\spi_master_0|count\(29)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "5a5f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(29),
	cin => \spi_master_0|Add5~37\,
	cin0 => \spi_master_0|Add5~22\,
	cin1 => \spi_master_0|Add5~22COUT1_183\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~15_combout\,
	cout0 => \spi_master_0|Add5~17\,
	cout1 => \spi_master_0|Add5~17COUT1_184\);

-- Location: LC_X12_Y5_N8
\spi_master_0|count[29]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(29) = DFFEAS(((\spi_master_0|state~regout\ & (!\spi_master_0|Equal1~10_combout\ & \spi_master_0|Add5~15_combout\))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0c00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~15_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(29));

-- Location: LC_X12_Y5_N4
\spi_master_0|Add5~10\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~10_combout\ = \spi_master_0|count\(30) $ ((((!(!\spi_master_0|Add5~37\ & \spi_master_0|Add5~17\) # (\spi_master_0|Add5~37\ & \spi_master_0|Add5~17COUT1_184\)))))
-- \spi_master_0|Add5~12\ = CARRY((\spi_master_0|count\(30) & ((!\spi_master_0|Add5~17COUT1_184\))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "a50a",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(30),
	cin => \spi_master_0|Add5~37\,
	cin0 => \spi_master_0|Add5~17\,
	cin1 => \spi_master_0|Add5~17COUT1_184\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~10_combout\,
	cout => \spi_master_0|Add5~12\);

-- Location: LC_X12_Y5_N6
\spi_master_0|count[30]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(30) = DFFEAS(((\spi_master_0|state~regout\ & (\spi_master_0|Add5~10_combout\ & !\spi_master_0|Equal1~10_combout\))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00c0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|Add5~10_combout\,
	datad => \spi_master_0|Equal1~10_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(30));

-- Location: LC_X12_Y5_N5
\spi_master_0|Add5~5\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add5~5_combout\ = ((\spi_master_0|Add5~12\ $ (!\spi_master_0|count\(31))))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "f00f",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datad => \spi_master_0|count\(31),
	cin => \spi_master_0|Add5~12\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add5~5_combout\);

-- Location: LC_X9_Y5_N3
\spi_master_0|count[31]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|count\(31) = DFFEAS((((\spi_master_0|Equal1~10_combout\) # (!\spi_master_0|Add5~5_combout\)) # (!\spi_master_0|state~regout\)), GLOBAL(\clock~combout\), VCC, , \spi_master_0|count[30]~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f3ff",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|Add5~5_combout\,
	aclr => GND,
	ena => \spi_master_0|count[30]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|count\(31));

-- Location: LC_X8_Y5_N6
\spi_master_0|Equal1~0\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Equal1~0_combout\ = (\spi_master_0|count\(1) & (\spi_master_0|count\(0) & (\spi_master_0|count\(31) & \spi_master_0|slave\(0)))) # (!\spi_master_0|count\(1) & (!\spi_master_0|count\(0) & (!\spi_master_0|count\(31) & 
-- !\spi_master_0|slave\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "8001",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(1),
	datab => \spi_master_0|count\(0),
	datac => \spi_master_0|count\(31),
	datad => \spi_master_0|slave\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Equal1~0_combout\);

-- Location: LC_X8_Y5_N0
\spi_master_0|Equal1~1\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Equal1~1_combout\ = (!\spi_master_0|count\(28) & (!\spi_master_0|count\(27) & (!\spi_master_0|count\(30) & !\spi_master_0|count\(29))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|count\(28),
	datab => \spi_master_0|count\(27),
	datac => \spi_master_0|count\(30),
	datad => \spi_master_0|count\(29),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Equal1~1_combout\);

-- Location: LC_X8_Y5_N1
\spi_master_0|Equal1~4\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Equal1~4_combout\ = (\spi_master_0|Equal1~2_combout\ & (\spi_master_0|Equal1~3_combout\ & (\spi_master_0|Equal1~0_combout\ & \spi_master_0|Equal1~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "8000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|Equal1~2_combout\,
	datab => \spi_master_0|Equal1~3_combout\,
	datac => \spi_master_0|Equal1~0_combout\,
	datad => \spi_master_0|Equal1~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Equal1~4_combout\);

-- Location: LC_X7_Y5_N5
\spi_master_0|Equal1~10\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Equal1~10_combout\ = ((!\spi_master_0|count\(2) & (\spi_master_0|Equal1~9_combout\ & \spi_master_0|Equal1~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "3000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|count\(2),
	datac => \spi_master_0|Equal1~9_combout\,
	datad => \spi_master_0|Equal1~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Equal1~10_combout\);

-- Location: LC_X8_Y6_N9
\spi_master_0|clk_toggles[4]~0\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|clk_toggles[4]~0_combout\ = (\DATA7~combout\ & ((\spi_master_0|state~regout\ & ((\spi_master_0|Equal1~10_combout\))) # (!\spi_master_0|state~regout\ & (\DATA5~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c808",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \DATA5~combout\,
	datab => \DATA7~combout\,
	datac => \spi_master_0|state~regout\,
	datad => \spi_master_0|Equal1~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|clk_toggles[4]~0_combout\);

-- Location: LC_X8_Y6_N7
\spi_master_0|clk_toggles[0]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|clk_toggles\(0) = DFFEAS((\spi_master_0|process_0~2_combout\ & (!\spi_master_0|Equal3~1_combout\ & ((\spi_master_0|Add1~0_combout\)))) # (!\spi_master_0|process_0~2_combout\ & (((!\spi_master_0|slave\(0))))), GLOBAL(\clock~combout\), VCC, , 
-- \spi_master_0|clk_toggles[4]~0_combout\, , , !\spi_master_0|state~regout\, )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "2705",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|process_0~2_combout\,
	datab => \spi_master_0|Equal3~1_combout\,
	datac => \spi_master_0|slave\(0),
	datad => \spi_master_0|Add1~0_combout\,
	aclr => GND,
	sclr => \spi_master_0|ALT_INV_state~regout\,
	ena => \spi_master_0|clk_toggles[4]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|clk_toggles\(0));

-- Location: LC_X5_Y6_N1
\spi_master_0|Add1~20\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add1~20_combout\ = (\spi_master_0|clk_toggles\(1) $ ((\spi_master_0|Add1~2\)))
-- \spi_master_0|Add1~22\ = CARRY(((!\spi_master_0|Add1~2\) # (!\spi_master_0|clk_toggles\(1))))
-- \spi_master_0|Add1~22COUT1_27\ = CARRY(((!\spi_master_0|Add1~2COUT1_26\) # (!\spi_master_0|clk_toggles\(1))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "3c3f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|clk_toggles\(1),
	cin0 => \spi_master_0|Add1~2\,
	cin1 => \spi_master_0|Add1~2COUT1_26\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add1~20_combout\,
	cout0 => \spi_master_0|Add1~22\,
	cout1 => \spi_master_0|Add1~22COUT1_27\);

-- Location: LC_X8_Y6_N8
\spi_master_0|clk_toggles[1]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|clk_toggles\(1) = DFFEAS((\spi_master_0|Add1~20_combout\ & (\spi_master_0|state~regout\ & (\spi_master_0|process_0~2_combout\ $ (\spi_master_0|Equal3~1_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|clk_toggles[4]~0_combout\, , 
-- , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "4080",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|process_0~2_combout\,
	datab => \spi_master_0|Add1~20_combout\,
	datac => \spi_master_0|state~regout\,
	datad => \spi_master_0|Equal3~1_combout\,
	aclr => GND,
	ena => \spi_master_0|clk_toggles[4]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|clk_toggles\(1));

-- Location: LC_X5_Y6_N2
\spi_master_0|Add1~15\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add1~15_combout\ = (\spi_master_0|clk_toggles\(2) $ ((!\spi_master_0|Add1~22\)))
-- \spi_master_0|Add1~17\ = CARRY(((\spi_master_0|clk_toggles\(2) & !\spi_master_0|Add1~22\)))
-- \spi_master_0|Add1~17COUT1_28\ = CARRY(((\spi_master_0|clk_toggles\(2) & !\spi_master_0|Add1~22COUT1_27\)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "c30c",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|clk_toggles\(2),
	cin0 => \spi_master_0|Add1~22\,
	cin1 => \spi_master_0|Add1~22COUT1_27\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add1~15_combout\,
	cout0 => \spi_master_0|Add1~17\,
	cout1 => \spi_master_0|Add1~17COUT1_28\);

-- Location: LC_X8_Y6_N3
\spi_master_0|clk_toggles[2]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|clk_toggles\(2) = DFFEAS((\spi_master_0|state~regout\ & (\spi_master_0|Add1~15_combout\ & (\spi_master_0|Equal3~1_combout\ $ (\spi_master_0|process_0~2_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|clk_toggles[4]~0_combout\, , 
-- , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "2080",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datab => \spi_master_0|Equal3~1_combout\,
	datac => \spi_master_0|Add1~15_combout\,
	datad => \spi_master_0|process_0~2_combout\,
	aclr => GND,
	ena => \spi_master_0|clk_toggles[4]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|clk_toggles\(2));

-- Location: LC_X5_Y6_N3
\spi_master_0|Add1~10\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add1~10_combout\ = (\spi_master_0|clk_toggles\(3) $ ((\spi_master_0|Add1~17\)))
-- \spi_master_0|Add1~12\ = CARRY(((!\spi_master_0|Add1~17\) # (!\spi_master_0|clk_toggles\(3))))
-- \spi_master_0|Add1~12COUT1_29\ = CARRY(((!\spi_master_0|Add1~17COUT1_28\) # (!\spi_master_0|clk_toggles\(3))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "3c3f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|clk_toggles\(3),
	cin0 => \spi_master_0|Add1~17\,
	cin1 => \spi_master_0|Add1~17COUT1_28\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add1~10_combout\,
	cout0 => \spi_master_0|Add1~12\,
	cout1 => \spi_master_0|Add1~12COUT1_29\);

-- Location: LC_X8_Y6_N1
\spi_master_0|clk_toggles[3]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|clk_toggles\(3) = DFFEAS((\spi_master_0|state~regout\ & (\spi_master_0|Add1~10_combout\ & (\spi_master_0|process_0~2_combout\ $ (\spi_master_0|Equal3~1_combout\)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|clk_toggles[4]~0_combout\, , 
-- , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "6000",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|process_0~2_combout\,
	datab => \spi_master_0|Equal3~1_combout\,
	datac => \spi_master_0|state~regout\,
	datad => \spi_master_0|Add1~10_combout\,
	aclr => GND,
	ena => \spi_master_0|clk_toggles[4]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|clk_toggles\(3));

-- Location: LC_X8_Y6_N5
\spi_master_0|Equal3~0\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Equal3~0_combout\ = (!\spi_master_0|clk_toggles\(1) & (!\spi_master_0|clk_toggles\(3) & ((!\spi_master_0|clk_toggles\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|clk_toggles\(1),
	datab => \spi_master_0|clk_toggles\(3),
	datad => \spi_master_0|clk_toggles\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Equal3~0_combout\);

-- Location: LC_X8_Y4_N3
\spi_master_0|Equal3~1\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Equal3~1_combout\ = (\spi_master_0|clk_toggles\(0) & (((\spi_master_0|clk_toggles\(4) & \spi_master_0|Equal3~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|clk_toggles\(0),
	datac => \spi_master_0|clk_toggles\(4),
	datad => \spi_master_0|Equal3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Equal3~1_combout\);

-- Location: LC_X7_Y6_N8
\spi_master_0|state\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|state~regout\ = DFFEAS((\DATA6~combout\) # (((!\spi_master_0|Equal1~10_combout\)) # (!\spi_master_0|Equal3~1_combout\)), GLOBAL(\clock~combout\), GLOBAL(\DATA7~combout\), , , \DATA5~combout\, , , !\spi_master_0|state~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "bbff",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \DATA6~combout\,
	datab => \spi_master_0|Equal3~1_combout\,
	datac => \DATA5~combout\,
	datad => \spi_master_0|Equal1~10_combout\,
	aclr => \ALT_INV_DATA7~combout\,
	sload => \spi_master_0|ALT_INV_state~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|state~regout\);

-- Location: LC_X8_Y6_N6
\spi_master_0|slave[0]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|slave\(0) = DFFEAS((\spi_master_0|slave\(0)) # ((!\spi_master_0|state~regout\ & (\DATA5~combout\ & \DATA7~combout\))), GLOBAL(\clock~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f4f0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|state~regout\,
	datab => \DATA5~combout\,
	datac => \spi_master_0|slave\(0),
	datad => \DATA7~combout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|slave\(0));

-- Location: LC_X7_Y6_N0
\spi_master_0|Equal2~0\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Equal2~0_combout\ = ((\spi_master_0|slave\(0) $ (!\spi_master_0|clk_toggles\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f00f",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \spi_master_0|slave\(0),
	datad => \spi_master_0|clk_toggles\(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Equal2~0_combout\);

-- Location: LC_X7_Y6_N6
\spi_master_0|process_0~1\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|process_0~1_combout\ = (\spi_master_0|slave\(0) & (((!\spi_master_0|clk_toggles\(0)) # (!\spi_master_0|clk_toggles\(2))) # (!\spi_master_0|clk_toggles\(1)))) # (!\spi_master_0|slave\(0) & ((\spi_master_0|clk_toggles\(1)) # 
-- ((\spi_master_0|clk_toggles\(2)) # (\spi_master_0|clk_toggles\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "7ffe",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|slave\(0),
	datab => \spi_master_0|clk_toggles\(1),
	datac => \spi_master_0|clk_toggles\(2),
	datad => \spi_master_0|clk_toggles\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|process_0~1_combout\);

-- Location: LC_X7_Y6_N7
\spi_master_0|process_0~2\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|process_0~2_combout\ = (((\spi_master_0|clk_toggles\(4)) # (\spi_master_0|process_0~1_combout\)) # (!\spi_master_0|Equal2~0_combout\)) # (!\DATA6~combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fff7",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \DATA6~combout\,
	datab => \spi_master_0|Equal2~0_combout\,
	datac => \spi_master_0|clk_toggles\(4),
	datad => \spi_master_0|process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|process_0~2_combout\);

-- Location: LC_X5_Y6_N4
\spi_master_0|Add1~5\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|Add1~5_combout\ = ((\spi_master_0|Add1~12\ $ (!\spi_master_0|clk_toggles\(4))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "f00f",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datad => \spi_master_0|clk_toggles\(4),
	cin0 => \spi_master_0|Add1~12\,
	cin1 => \spi_master_0|Add1~12COUT1_29\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|Add1~5_combout\);

-- Location: LC_X8_Y6_N2
\spi_master_0|clk_toggles[4]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|clk_toggles\(4) = DFFEAS((\spi_master_0|process_0~2_combout\ & (\spi_master_0|Add1~5_combout\ & ((!\spi_master_0|Equal3~1_combout\)))) # (!\spi_master_0|process_0~2_combout\ & (((!\spi_master_0|slave\(0))))), GLOBAL(\clock~combout\), VCC, , 
-- \spi_master_0|clk_toggles[4]~0_combout\, , , !\spi_master_0|state~regout\, )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "058d",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|process_0~2_combout\,
	datab => \spi_master_0|Add1~5_combout\,
	datac => \spi_master_0|slave\(0),
	datad => \spi_master_0|Equal3~1_combout\,
	aclr => GND,
	sclr => \spi_master_0|ALT_INV_state~regout\,
	ena => \spi_master_0|clk_toggles[4]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|clk_toggles\(4));

-- Location: LC_X8_Y6_N4
\spi_master_0|assert_data\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|assert_data~regout\ = DFFEAS((((!\spi_master_0|state~regout\))) # (!\spi_master_0|assert_data~regout\), GLOBAL(\clock~combout\), VCC, , \spi_master_0|clk_toggles[4]~0_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "5f5f",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|assert_data~regout\,
	datac => \spi_master_0|state~regout\,
	aclr => GND,
	ena => \spi_master_0|clk_toggles[4]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|assert_data~regout\);

-- Location: LC_X8_Y4_N6
\spi_master_0|rx_buffer[0]~1\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_buffer[0]~1_combout\ = ((\spi_master_0|slave\(0)) # ((!\spi_master_0|clk_toggles\(0) & \spi_master_0|Equal3~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cfcc",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \spi_master_0|slave\(0),
	datac => \spi_master_0|clk_toggles\(0),
	datad => \spi_master_0|Equal3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|rx_buffer[0]~1_combout\);

-- Location: LC_X8_Y4_N4
\spi_master_0|ss_n~0\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|ss_n~0_combout\ = (((!\spi_master_0|slave\(0) & !\spi_master_0|ss_n\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "000f",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \spi_master_0|slave\(0),
	datad => \spi_master_0|ss_n\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|ss_n~0_combout\);

-- Location: LC_X7_Y6_N9
\spi_master_0|process_0~0\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|process_0~0_combout\ = (!\DATA6~combout\ & (\spi_master_0|Equal3~0_combout\ & (\spi_master_0|clk_toggles\(4) & \spi_master_0|clk_toggles\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "4000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \DATA6~combout\,
	datab => \spi_master_0|Equal3~0_combout\,
	datac => \spi_master_0|clk_toggles\(4),
	datad => \spi_master_0|clk_toggles\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|process_0~0_combout\);

-- Location: LC_X8_Y4_N9
\spi_master_0|ss_n[0]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|ss_n\(0) = DFFEAS((!\spi_master_0|ss_n~0_combout\ & (\spi_master_0|state~regout\ & ((!\spi_master_0|Equal1~10_combout\) # (!\spi_master_0|process_0~0_combout\)))), GLOBAL(\clock~combout\), GLOBAL(\DATA7~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1050",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|ss_n~0_combout\,
	datab => \spi_master_0|process_0~0_combout\,
	datac => \spi_master_0|state~regout\,
	datad => \spi_master_0|Equal1~10_combout\,
	aclr => \ALT_INV_DATA7~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|ss_n\(0));

-- Location: LC_X7_Y4_N7
\spi_master_0|rx_buffer[0]~0\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_buffer[0]~0_combout\ = (\DATA7~combout\ & (\spi_master_0|ss_n\(0) & (\spi_master_0|state~regout\ & \spi_master_0|Equal1~10_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "8000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \DATA7~combout\,
	datab => \spi_master_0|ss_n\(0),
	datac => \spi_master_0|state~regout\,
	datad => \spi_master_0|Equal1~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|rx_buffer[0]~0_combout\);

-- Location: LC_X7_Y4_N8
\spi_master_0|rx_buffer[0]~2\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_buffer[0]~2_combout\ = (!\spi_master_0|clk_toggles\(4) & (!\spi_master_0|assert_data~regout\ & (\spi_master_0|rx_buffer[0]~1_combout\ & \spi_master_0|rx_buffer[0]~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|clk_toggles\(4),
	datab => \spi_master_0|assert_data~regout\,
	datac => \spi_master_0|rx_buffer[0]~1_combout\,
	datad => \spi_master_0|rx_buffer[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|rx_buffer[0]~2_combout\);

-- Location: LC_X7_Y4_N5
\spi_master_0|rx_buffer[0]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_buffer\(0) = DFFEAS(((\DATA4~combout\)), GLOBAL(\clock~combout\), VCC, , \spi_master_0|rx_buffer[0]~2_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cccc",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \DATA4~combout\,
	aclr => GND,
	ena => \spi_master_0|rx_buffer[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|rx_buffer\(0));

-- Location: LC_X6_Y4_N5
\spi_master_0|continue\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|continue~regout\ = DFFEAS((\spi_master_0|continue~regout\ & (!\spi_master_0|Equal1~10_combout\)) # (!\spi_master_0|continue~regout\ & (\spi_master_0|Equal1~10_combout\ & ((!\spi_master_0|process_0~2_combout\)))), GLOBAL(\clock~combout\), 
-- VCC, , \DATA7~combout\, , , !\spi_master_0|state~regout\, )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "2266",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|continue~regout\,
	datab => \spi_master_0|Equal1~10_combout\,
	datad => \spi_master_0|process_0~2_combout\,
	aclr => GND,
	sclr => \spi_master_0|ALT_INV_state~regout\,
	ena => \DATA7~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|continue~regout\);

-- Location: LC_X6_Y4_N6
\spi_master_0|rx_data[0]~3\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_data[0]~3_combout\ = (\spi_master_0|state~regout\ & (\spi_master_0|Equal1~10_combout\ & ((\spi_master_0|continue~regout\) # (\spi_master_0|process_0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c800",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|continue~regout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|process_0~0_combout\,
	datad => \spi_master_0|Equal1~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|rx_data[0]~3_combout\);

-- Location: LC_X6_Y4_N7
\spi_master_0|rx_data[0]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_data\(0) = DFFEAS((((\spi_master_0|rx_buffer\(0)))), GLOBAL(\clock~combout\), GLOBAL(\DATA7~combout\), , \spi_master_0|rx_data[0]~3_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datad => \spi_master_0|rx_buffer\(0),
	aclr => \ALT_INV_DATA7~combout\,
	ena => \spi_master_0|rx_data[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|rx_data\(0));

-- Location: LC_X7_Y4_N4
\spi_master_0|rx_buffer[1]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_buffer\(1) = DFFEAS(GND, GLOBAL(\clock~combout\), VCC, , \spi_master_0|rx_buffer[0]~2_combout\, \spi_master_0|rx_buffer\(0), , , VCC)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datac => \spi_master_0|rx_buffer\(0),
	aclr => GND,
	sload => VCC,
	ena => \spi_master_0|rx_buffer[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|rx_buffer\(1));

-- Location: LC_X6_Y4_N3
\spi_master_0|rx_data[1]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_data\(1) = DFFEAS((((\spi_master_0|rx_buffer\(1)))), GLOBAL(\clock~combout\), GLOBAL(\DATA7~combout\), , \spi_master_0|rx_data[0]~3_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datad => \spi_master_0|rx_buffer\(1),
	aclr => \ALT_INV_DATA7~combout\,
	ena => \spi_master_0|rx_data[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|rx_data\(1));

-- Location: LC_X7_Y4_N0
\spi_master_0|rx_buffer[2]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_buffer\(2) = DFFEAS(GND, GLOBAL(\clock~combout\), VCC, , \spi_master_0|rx_buffer[0]~2_combout\, \spi_master_0|rx_buffer\(1), , , VCC)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datac => \spi_master_0|rx_buffer\(1),
	aclr => GND,
	sload => VCC,
	ena => \spi_master_0|rx_buffer[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|rx_buffer\(2));

-- Location: LC_X6_Y4_N4
\spi_master_0|rx_data[2]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_data\(2) = DFFEAS((((\spi_master_0|rx_buffer\(2)))), GLOBAL(\clock~combout\), GLOBAL(\DATA7~combout\), , \spi_master_0|rx_data[0]~3_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datad => \spi_master_0|rx_buffer\(2),
	aclr => \ALT_INV_DATA7~combout\,
	ena => \spi_master_0|rx_data[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|rx_data\(2));

-- Location: LC_X7_Y4_N3
\spi_master_0|rx_buffer[3]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_buffer\(3) = DFFEAS(GND, GLOBAL(\clock~combout\), VCC, , \spi_master_0|rx_buffer[0]~2_combout\, \spi_master_0|rx_buffer\(2), , , VCC)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datac => \spi_master_0|rx_buffer\(2),
	aclr => GND,
	sload => VCC,
	ena => \spi_master_0|rx_buffer[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|rx_buffer\(3));

-- Location: LC_X6_Y4_N9
\spi_master_0|rx_data[3]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_data\(3) = DFFEAS((((\spi_master_0|rx_buffer\(3)))), GLOBAL(\clock~combout\), GLOBAL(\DATA7~combout\), , \spi_master_0|rx_data[0]~3_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0f0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datac => \spi_master_0|rx_buffer\(3),
	aclr => \ALT_INV_DATA7~combout\,
	ena => \spi_master_0|rx_data[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|rx_data\(3));

-- Location: LC_X7_Y4_N2
\spi_master_0|rx_buffer[4]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_buffer\(4) = DFFEAS((((\spi_master_0|rx_buffer\(3)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|rx_buffer[0]~2_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datad => \spi_master_0|rx_buffer\(3),
	aclr => GND,
	ena => \spi_master_0|rx_buffer[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|rx_buffer\(4));

-- Location: LC_X6_Y4_N1
\spi_master_0|rx_data[4]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_data\(4) = DFFEAS((((\spi_master_0|rx_buffer\(4)))), GLOBAL(\clock~combout\), GLOBAL(\DATA7~combout\), , \spi_master_0|rx_data[0]~3_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0f0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datac => \spi_master_0|rx_buffer\(4),
	aclr => \ALT_INV_DATA7~combout\,
	ena => \spi_master_0|rx_data[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|rx_data\(4));

-- Location: LC_X7_Y4_N6
\spi_master_0|rx_buffer[5]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_buffer\(5) = DFFEAS((((\spi_master_0|rx_buffer\(4)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|rx_buffer[0]~2_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datad => \spi_master_0|rx_buffer\(4),
	aclr => GND,
	ena => \spi_master_0|rx_buffer[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|rx_buffer\(5));

-- Location: LC_X6_Y4_N8
\spi_master_0|rx_data[5]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_data\(5) = DFFEAS((((\spi_master_0|rx_buffer\(5)))), GLOBAL(\clock~combout\), GLOBAL(\DATA7~combout\), , \spi_master_0|rx_data[0]~3_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datad => \spi_master_0|rx_buffer\(5),
	aclr => \ALT_INV_DATA7~combout\,
	ena => \spi_master_0|rx_data[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|rx_data\(5));

-- Location: LC_X7_Y4_N9
\spi_master_0|rx_buffer[6]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_buffer\(6) = DFFEAS(GND, GLOBAL(\clock~combout\), VCC, , \spi_master_0|rx_buffer[0]~2_combout\, \spi_master_0|rx_buffer\(5), , , VCC)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datac => \spi_master_0|rx_buffer\(5),
	aclr => GND,
	sload => VCC,
	ena => \spi_master_0|rx_buffer[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|rx_buffer\(6));

-- Location: LC_X6_Y4_N0
\spi_master_0|rx_data[6]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_data\(6) = DFFEAS((((\spi_master_0|rx_buffer\(6)))), GLOBAL(\clock~combout\), GLOBAL(\DATA7~combout\), , \spi_master_0|rx_data[0]~3_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0f0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datac => \spi_master_0|rx_buffer\(6),
	aclr => \ALT_INV_DATA7~combout\,
	ena => \spi_master_0|rx_data[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|rx_data\(6));

-- Location: LC_X7_Y4_N1
\spi_master_0|rx_buffer[7]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_buffer\(7) = DFFEAS((((\spi_master_0|rx_buffer\(6)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|rx_buffer[0]~2_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datad => \spi_master_0|rx_buffer\(6),
	aclr => GND,
	ena => \spi_master_0|rx_buffer[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|rx_buffer\(7));

-- Location: LC_X6_Y4_N2
\spi_master_0|rx_data[7]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_data\(7) = DFFEAS((((\spi_master_0|rx_buffer\(7)))), GLOBAL(\clock~combout\), GLOBAL(\DATA7~combout\), , \spi_master_0|rx_data[0]~3_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datad => \spi_master_0|rx_buffer\(7),
	aclr => \ALT_INV_DATA7~combout\,
	ena => \spi_master_0|rx_data[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|rx_data\(7));

-- Location: LC_X8_Y4_N1
\spi_master_0|rx_data[0]~2\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|rx_data[0]~2_combout\ = (((\spi_master_0|continue~regout\) # (\spi_master_0|process_0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fff0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \spi_master_0|continue~regout\,
	datad => \spi_master_0|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|rx_data[0]~2_combout\);

-- Location: LC_X8_Y4_N2
\spi_master_0|busy\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|busy~regout\ = DFFEAS((\spi_master_0|state~regout\ & (\spi_master_0|Equal1~10_combout\ & ((\spi_master_0|rx_data[0]~2_combout\)))) # (!\spi_master_0|state~regout\ & (((!\DATA5~combout\)))), GLOBAL(\clock~combout\), GLOBAL(\DATA7~combout\), , 
-- , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a303",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|Equal1~10_combout\,
	datab => \DATA5~combout\,
	datac => \spi_master_0|state~regout\,
	datad => \spi_master_0|rx_data[0]~2_combout\,
	aclr => \ALT_INV_DATA7~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|busy~regout\);

-- Location: LC_X8_Y4_N5
\spi_master_0|sclk~0\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|sclk~0_combout\ = ((\spi_master_0|clk_toggles\(4) & ((\spi_master_0|clk_toggles\(0)) # (!\spi_master_0|Equal3~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a0f0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|clk_toggles\(0),
	datac => \spi_master_0|clk_toggles\(4),
	datad => \spi_master_0|Equal3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|sclk~0_combout\);

-- Location: LC_X8_Y4_N0
\spi_master_0|sclk~1\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|sclk~1_combout\ = (\DATA7~combout\ & ((\spi_master_0|state~regout\ & (\spi_master_0|ss_n\(0))) # (!\spi_master_0|state~regout\ & ((\DATA5~combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "8a80",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \DATA7~combout\,
	datab => \spi_master_0|ss_n\(0),
	datac => \spi_master_0|state~regout\,
	datad => \DATA5~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|sclk~1_combout\);

-- Location: LC_X8_Y4_N7
\spi_master_0|sclk~2\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|sclk~2_combout\ = (\spi_master_0|sclk~1_combout\ & (((!\spi_master_0|sclk~0_combout\ & \spi_master_0|Equal1~10_combout\)) # (!\spi_master_0|state~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "4c0c",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|sclk~0_combout\,
	datab => \spi_master_0|sclk~1_combout\,
	datac => \spi_master_0|state~regout\,
	datad => \spi_master_0|Equal1~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|sclk~2_combout\);

-- Location: LC_X8_Y4_N8
\spi_master_0|sclk\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|sclk~regout\ = DFFEAS((\spi_master_0|sclk~regout\ & (((!\spi_master_0|sclk~2_combout\)))) # (!\spi_master_0|sclk~regout\ & (\spi_master_0|rx_buffer[0]~0_combout\ & (!\spi_master_0|sclk~0_combout\))), GLOBAL(\clock~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "04ae",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|sclk~regout\,
	datab => \spi_master_0|rx_buffer[0]~0_combout\,
	datac => \spi_master_0|sclk~0_combout\,
	datad => \spi_master_0|sclk~2_combout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|sclk~regout\);

-- Location: LC_X7_Y6_N2
\spi_master_0|process_0~3\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|process_0~3_combout\ = (\spi_master_0|clk_toggles\(3) & (\spi_master_0|clk_toggles\(1) & (\spi_master_0|clk_toggles\(2) & \spi_master_0|clk_toggles\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "8000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|clk_toggles\(3),
	datab => \spi_master_0|clk_toggles\(1),
	datac => \spi_master_0|clk_toggles\(2),
	datad => \spi_master_0|clk_toggles\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|process_0~3_combout\);

-- Location: LC_X7_Y6_N5
\spi_master_0|process_0~4\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|process_0~4_combout\ = (((\spi_master_0|clk_toggles\(4)) # (\spi_master_0|process_0~3_combout\)) # (!\spi_master_0|assert_data~regout\)) # (!\spi_master_0|slave\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fff7",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|slave\(0),
	datab => \spi_master_0|assert_data~regout\,
	datac => \spi_master_0|clk_toggles\(4),
	datad => \spi_master_0|process_0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|process_0~4_combout\);

-- Location: LC_X7_Y6_N1
\spi_master_0|tx_buffer[1]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|tx_buffer\(1) = DFFEAS(((\spi_master_0|tx_buffer\(1) & ((\spi_master_0|process_0~4_combout\)))) # (!\spi_master_0|process_0~2_combout\), GLOBAL(\clock~combout\), VCC, , \spi_master_0|clk_toggles[4]~0_combout\, VCC, , , 
-- !\spi_master_0|state~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "dd55",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|process_0~2_combout\,
	datab => \spi_master_0|tx_buffer\(1),
	datac => VCC,
	datad => \spi_master_0|process_0~4_combout\,
	aclr => GND,
	sload => \spi_master_0|ALT_INV_state~regout\,
	ena => \spi_master_0|clk_toggles[4]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|tx_buffer\(1));

-- Location: LC_X7_Y6_N3
\spi_master_0|tx_buffer[7]~1\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|tx_buffer[7]~1_combout\ = ((\spi_master_0|Equal1~10_combout\ & ((!\spi_master_0|process_0~2_combout\) # (!\spi_master_0|process_0~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "5f00",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|process_0~4_combout\,
	datac => \spi_master_0|process_0~2_combout\,
	datad => \spi_master_0|Equal1~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|tx_buffer[7]~1_combout\);

-- Location: LC_X7_Y6_N4
\spi_master_0|tx_buffer[7]~2\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|tx_buffer[7]~2_combout\ = (\DATA7~combout\ & ((\spi_master_0|state~regout\ & ((\spi_master_0|tx_buffer[7]~1_combout\))) # (!\spi_master_0|state~regout\ & (\DATA5~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c840",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|state~regout\,
	datab => \DATA7~combout\,
	datac => \DATA5~combout\,
	datad => \spi_master_0|tx_buffer[7]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|tx_buffer[7]~2_combout\);

-- Location: LC_X6_Y6_N0
\spi_master_0|tx_buffer[2]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|tx_buffer\(2) = DFFEAS(((\spi_master_0|state~regout\ & (\spi_master_0|tx_buffer\(1) & \spi_master_0|process_0~2_combout\))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|tx_buffer[7]~2_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c000",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|tx_buffer\(1),
	datad => \spi_master_0|process_0~2_combout\,
	aclr => GND,
	ena => \spi_master_0|tx_buffer[7]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|tx_buffer\(2));

-- Location: LC_X6_Y6_N6
\spi_master_0|tx_buffer[3]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|tx_buffer\(3) = DFFEAS((((\spi_master_0|tx_buffer\(2)) # (!\spi_master_0|state~regout\))) # (!\spi_master_0|process_0~2_combout\), GLOBAL(\clock~combout\), VCC, , \spi_master_0|tx_buffer[7]~2_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f5ff",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|process_0~2_combout\,
	datac => \spi_master_0|tx_buffer\(2),
	datad => \spi_master_0|state~regout\,
	aclr => GND,
	ena => \spi_master_0|tx_buffer[7]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|tx_buffer\(3));

-- Location: LC_X6_Y6_N7
\spi_master_0|tx_buffer[4]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|tx_buffer\(4) = DFFEAS((((\spi_master_0|tx_buffer\(3)) # (!\spi_master_0|process_0~2_combout\)) # (!\spi_master_0|state~regout\)), GLOBAL(\clock~combout\), VCC, , \spi_master_0|tx_buffer[7]~2_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f3ff",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|tx_buffer\(3),
	datad => \spi_master_0|process_0~2_combout\,
	aclr => GND,
	ena => \spi_master_0|tx_buffer[7]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|tx_buffer\(4));

-- Location: LC_X6_Y6_N3
\spi_master_0|tx_buffer[5]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|tx_buffer\(5) = DFFEAS(((\spi_master_0|state~regout\ & (\spi_master_0|tx_buffer\(4) & \spi_master_0|process_0~2_combout\))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|tx_buffer[7]~2_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c000",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|tx_buffer\(4),
	datad => \spi_master_0|process_0~2_combout\,
	aclr => GND,
	ena => \spi_master_0|tx_buffer[7]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|tx_buffer\(5));

-- Location: LC_X6_Y6_N4
\spi_master_0|tx_buffer[6]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|tx_buffer\(6) = DFFEAS((\spi_master_0|tx_buffer\(5)) # (((!\spi_master_0|state~regout\) # (!\spi_master_0|process_0~2_combout\))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|tx_buffer[7]~2_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "afff",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \spi_master_0|tx_buffer\(5),
	datac => \spi_master_0|process_0~2_combout\,
	datad => \spi_master_0|state~regout\,
	aclr => GND,
	ena => \spi_master_0|tx_buffer[7]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|tx_buffer\(6));

-- Location: LC_X6_Y6_N8
\spi_master_0|tx_buffer[7]\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|tx_buffer\(7) = DFFEAS(((\spi_master_0|state~regout\ & (\spi_master_0|tx_buffer\(6) & \spi_master_0|process_0~2_combout\))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|tx_buffer[7]~2_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c000",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|tx_buffer\(6),
	datad => \spi_master_0|process_0~2_combout\,
	aclr => GND,
	ena => \spi_master_0|tx_buffer[7]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|tx_buffer\(7));

-- Location: LC_X6_Y6_N1
\spi_master_0|mosi~0\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|mosi~0_combout\ = ((\spi_master_0|Equal1~10_combout\ & ((\spi_master_0|process_0~0_combout\) # (!\spi_master_0|process_0~4_combout\)))) # (!\spi_master_0|state~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f733",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \spi_master_0|process_0~4_combout\,
	datab => \spi_master_0|state~regout\,
	datac => \spi_master_0|process_0~0_combout\,
	datad => \spi_master_0|Equal1~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \spi_master_0|mosi~0_combout\);

-- Location: LC_X6_Y6_N5
\spi_master_0|mosi~reg0\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|mosi~reg0_regout\ = DFFEAS((((\spi_master_0|tx_buffer\(7)))), GLOBAL(\clock~combout\), VCC, , \spi_master_0|mosi~0_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datad => \spi_master_0|tx_buffer\(7),
	aclr => GND,
	ena => \spi_master_0|mosi~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|mosi~reg0_regout\);

-- Location: LC_X6_Y6_N9
\spi_master_0|mosi~en\ : maxii_lcell
-- Equation(s):
-- \spi_master_0|mosi~en_regout\ = DFFEAS((((!\spi_master_0|process_0~0_combout\ & \spi_master_0|state~regout\))), GLOBAL(\clock~combout\), GLOBAL(\DATA7~combout\), , \spi_master_0|mosi~0_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0f00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datac => \spi_master_0|process_0~0_combout\,
	datad => \spi_master_0|state~regout\,
	aclr => \ALT_INV_DATA7~combout\,
	ena => \spi_master_0|mosi~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \spi_master_0|mosi~en_regout\);

-- Location: PIN_91,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\reset_n~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_reset_n);

-- Location: PIN_5,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\trip~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_trip);

-- Location: PIN_18,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM1~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \spi_master_0|ALT_INV_rx_data\(0),
	oe => VCC,
	padio => ww_PWM1);

-- Location: PIN_19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM2~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \spi_master_0|ALT_INV_rx_data\(1),
	oe => VCC,
	padio => ww_PWM2);

-- Location: PIN_20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM3~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \spi_master_0|ALT_INV_rx_data\(2),
	oe => VCC,
	padio => ww_PWM3);

-- Location: PIN_21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM4~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \spi_master_0|ALT_INV_rx_data\(3),
	oe => VCC,
	padio => ww_PWM4);

-- Location: PIN_26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM5~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \spi_master_0|ALT_INV_rx_data\(4),
	oe => VCC,
	padio => ww_PWM5);

-- Location: PIN_27,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM6~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \spi_master_0|ALT_INV_rx_data\(5),
	oe => VCC,
	padio => ww_PWM6);

-- Location: PIN_28,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM7~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \spi_master_0|ALT_INV_rx_data\(6),
	oe => VCC,
	padio => ww_PWM7);

-- Location: PIN_29,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM8~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \spi_master_0|ALT_INV_rx_data\(7),
	oe => VCC,
	padio => ww_PWM8);

-- Location: PIN_30,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM9~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_PWM9);

-- Location: PIN_33,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM10~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_PWM10);

-- Location: PIN_34,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM11~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_PWM11);

-- Location: PIN_35,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM12~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_PWM12);

-- Location: PIN_36,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM13~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \spi_master_0|busy~regout\,
	oe => VCC,
	padio => ww_PWM13);

-- Location: PIN_38,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM14~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_PWM14);

-- Location: PIN_40,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM15~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_PWM15);

-- Location: PIN_41,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM16~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_PWM16);

-- Location: PIN_42,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM17~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_PWM17);

-- Location: PIN_43,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM18~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_PWM18);

-- Location: PIN_44,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM19~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_PWM19);

-- Location: PIN_47,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM20~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_PWM20);

-- Location: PIN_48,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM21~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_PWM21);

-- Location: PIN_49,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM22~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_PWM22);

-- Location: PIN_50,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM23~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_PWM23);

-- Location: PIN_51,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM24~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_PWM24);

-- Location: PIN_52,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 8mA
\DATA1~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \spi_master_0|sclk~regout\,
	oe => VCC,
	padio => ww_DATA1);

-- Location: PIN_53,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 8mA
\DATA2~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \spi_master_0|mosi~reg0_regout\,
	oe => \spi_master_0|mosi~en_regout\,
	padio => ww_DATA2);

-- Location: PIN_54,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\DATA3~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \spi_master_0|ALT_INV_ss_n\(0),
	oe => VCC,
	padio => ww_DATA3);

-- Location: PIN_61,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\DATA8~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_DATA8);
END structure;


