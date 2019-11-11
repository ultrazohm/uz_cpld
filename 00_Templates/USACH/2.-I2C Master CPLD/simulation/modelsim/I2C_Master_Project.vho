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

-- DATE "08/08/2018 19:28:37"

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
	DATA1 : INOUT std_logic;
	DATA2 : INOUT std_logic;
	DATA3 : IN std_logic;
	DATA4 : IN std_logic;
	DATA5 : OUT std_logic;
	DATA6 : OUT std_logic;
	DATA7 : OUT std_logic;
	DATA8 : OUT std_logic
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
SIGNAL ww_DATA3 : std_logic;
SIGNAL ww_DATA4 : std_logic;
SIGNAL ww_DATA5 : std_logic;
SIGNAL ww_DATA6 : std_logic;
SIGNAL ww_DATA7 : std_logic;
SIGNAL ww_DATA8 : std_logic;
SIGNAL \DATA1~0\ : std_logic;
SIGNAL \DATA2~0\ : std_logic;
SIGNAL \clock~combout\ : std_logic;
SIGNAL \DATA4~combout\ : std_logic;
SIGNAL \DATA3~combout\ : std_logic;
SIGNAL \i2c_master_0|Selector21~2_combout\ : std_logic;
SIGNAL \i2c_master_0|Add0~37\ : std_logic;
SIGNAL \i2c_master_0|Add0~37COUT1_46\ : std_logic;
SIGNAL \i2c_master_0|Add0~42\ : std_logic;
SIGNAL \i2c_master_0|Add0~42COUT1_47\ : std_logic;
SIGNAL \i2c_master_0|Add0~30_combout\ : std_logic;
SIGNAL \i2c_master_0|Add0~32\ : std_logic;
SIGNAL \i2c_master_0|Add0~32COUT1_48\ : std_logic;
SIGNAL \i2c_master_0|Add0~20_combout\ : std_logic;
SIGNAL \i2c_master_0|Add0~22\ : std_logic;
SIGNAL \i2c_master_0|Add0~22COUT1_49\ : std_logic;
SIGNAL \i2c_master_0|Add0~25_combout\ : std_logic;
SIGNAL \i2c_master_0|Add0~27\ : std_logic;
SIGNAL \i2c_master_0|Add0~15_combout\ : std_logic;
SIGNAL \i2c_master_0|Add0~17\ : std_logic;
SIGNAL \i2c_master_0|Add0~17COUT1_50\ : std_logic;
SIGNAL \i2c_master_0|Add0~10_combout\ : std_logic;
SIGNAL \i2c_master_0|Add0~12\ : std_logic;
SIGNAL \i2c_master_0|Add0~12COUT1_51\ : std_logic;
SIGNAL \i2c_master_0|Add0~2\ : std_logic;
SIGNAL \i2c_master_0|Add0~2COUT1_52\ : std_logic;
SIGNAL \i2c_master_0|Add0~5_combout\ : std_logic;
SIGNAL \i2c_master_0|count~0_combout\ : std_logic;
SIGNAL \i2c_master_0|Equal0~0\ : std_logic;
SIGNAL \i2c_master_0|Add0~40_combout\ : std_logic;
SIGNAL \i2c_master_0|Equal0~1_combout\ : std_logic;
SIGNAL \i2c_master_0|Add0~0_combout\ : std_logic;
SIGNAL \i2c_master_0|process_0~0_combout\ : std_logic;
SIGNAL \i2c_master_0|process_0~1_combout\ : std_logic;
SIGNAL \i2c_master_0|process_0~2_combout\ : std_logic;
SIGNAL \i2c_master_0|process_0~3_combout\ : std_logic;
SIGNAL \i2c_master_0|process_0~4_combout\ : std_logic;
SIGNAL \i2c_master_0|stretch~regout\ : std_logic;
SIGNAL \i2c_master_0|Add0~35_combout\ : std_logic;
SIGNAL \i2c_master_0|Equal0~2_combout\ : std_logic;
SIGNAL \i2c_master_0|LessThan1~0_combout\ : std_logic;
SIGNAL \i2c_master_0|LessThan1~1_combout\ : std_logic;
SIGNAL \i2c_master_0|process_0~5_combout\ : std_logic;
SIGNAL \i2c_master_0|data_clk~0_combout\ : std_logic;
SIGNAL \i2c_master_0|data_clk~regout\ : std_logic;
SIGNAL \i2c_master_0|data_clk_prev~regout\ : std_logic;
SIGNAL \i2c_master_0|process_1~0_combout\ : std_logic;
SIGNAL \i2c_master_0|state.slv_ack1~regout\ : std_logic;
SIGNAL \i2c_master_0|Selector20~0_combout\ : std_logic;
SIGNAL \i2c_master_0|Equal1~0_combout\ : std_logic;
SIGNAL \i2c_master_0|state.wr~regout\ : std_logic;
SIGNAL \i2c_master_0|state~14_combout\ : std_logic;
SIGNAL \i2c_master_0|state.slv_ack2~regout\ : std_logic;
SIGNAL \i2c_master_0|state.mstr_ack~regout\ : std_logic;
SIGNAL \i2c_master_0|state.rd~regout\ : std_logic;
SIGNAL \i2c_master_0|data_rd[0]~2_combout\ : std_logic;
SIGNAL \i2c_master_0|Selector23~0\ : std_logic;
SIGNAL \i2c_master_0|Selector23~2_combout\ : std_logic;
SIGNAL \i2c_master_0|Selector23~3\ : std_logic;
SIGNAL \i2c_master_0|Selector22~0_combout\ : std_logic;
SIGNAL \i2c_master_0|Selector23~1\ : std_logic;
SIGNAL \i2c_master_0|Selector23~4_combout\ : std_logic;
SIGNAL \i2c_master_0|sda_int~regout\ : std_logic;
SIGNAL \i2c_master_0|state.stop~regout\ : std_logic;
SIGNAL \i2c_master_0|state.ready~regout\ : std_logic;
SIGNAL \i2c_master_0|Selector0~1_combout\ : std_logic;
SIGNAL \i2c_master_0|state.start~regout\ : std_logic;
SIGNAL \i2c_master_0|state.command~regout\ : std_logic;
SIGNAL \i2c_master_0|Selector0~2_combout\ : std_logic;
SIGNAL \i2c_master_0|bit_cnt[2]~5_combout\ : std_logic;
SIGNAL \i2c_master_0|Decoder0~0\ : std_logic;
SIGNAL \i2c_master_0|Decoder0~1_combout\ : std_logic;
SIGNAL \i2c_master_0|data_rd[0]~3_combout\ : std_logic;
SIGNAL \i2c_master_0|Decoder0~2_combout\ : std_logic;
SIGNAL \i2c_master_0|Decoder0~3_combout\ : std_logic;
SIGNAL \i2c_master_0|Decoder0~4_combout\ : std_logic;
SIGNAL \i2c_master_0|Decoder0~5_combout\ : std_logic;
SIGNAL \i2c_master_0|Decoder0~6_combout\ : std_logic;
SIGNAL \i2c_master_0|Decoder0~7_combout\ : std_logic;
SIGNAL \i2c_master_0|Decoder0~8_combout\ : std_logic;
SIGNAL \i2c_master_0|Selector28~0\ : std_logic;
SIGNAL \i2c_master_0|bit_cnt[2]~4_combout\ : std_logic;
SIGNAL \i2c_master_0|Selector28~1_combout\ : std_logic;
SIGNAL \i2c_master_0|process_1~1_combout\ : std_logic;
SIGNAL \i2c_master_0|scl_ena~regout\ : std_logic;
SIGNAL \i2c_master_0|Selector28~2_combout\ : std_logic;
SIGNAL \i2c_master_0|ack_error~regout\ : std_logic;
SIGNAL \i2c_master_0|Selector0~0_combout\ : std_logic;
SIGNAL \i2c_master_0|busy~regout\ : std_logic;
SIGNAL \i2c_master_0|scl_clk~regout\ : std_logic;
SIGNAL \i2c_master_0|scl~1_combout\ : std_logic;
SIGNAL \i2c_master_0|Selector29~0_combout\ : std_logic;
SIGNAL \i2c_master_0|data_rd\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \i2c_master_0|data_rx\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \i2c_master_0|bit_cnt\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \i2c_master_0|count\ : std_logic_vector(8 DOWNTO 0);
SIGNAL \ALT_INV_DATA4~combout\ : std_logic;
SIGNAL \i2c_master_0|ALT_INV_ack_error~regout\ : std_logic;
SIGNAL \i2c_master_0|ALT_INV_data_rd\ : std_logic_vector(7 DOWNTO 0);

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
ww_DATA3 <= DATA3;
ww_DATA4 <= DATA4;
DATA5 <= ww_DATA5;
DATA6 <= ww_DATA6;
DATA7 <= ww_DATA7;
DATA8 <= ww_DATA8;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_DATA4~combout\ <= NOT \DATA4~combout\;
\i2c_master_0|ALT_INV_ack_error~regout\ <= NOT \i2c_master_0|ack_error~regout\;
\i2c_master_0|ALT_INV_data_rd\(7) <= NOT \i2c_master_0|data_rd\(7);
\i2c_master_0|ALT_INV_data_rd\(6) <= NOT \i2c_master_0|data_rd\(6);
\i2c_master_0|ALT_INV_data_rd\(5) <= NOT \i2c_master_0|data_rd\(5);
\i2c_master_0|ALT_INV_data_rd\(4) <= NOT \i2c_master_0|data_rd\(4);
\i2c_master_0|ALT_INV_data_rd\(3) <= NOT \i2c_master_0|data_rd\(3);
\i2c_master_0|ALT_INV_data_rd\(2) <= NOT \i2c_master_0|data_rd\(2);
\i2c_master_0|ALT_INV_data_rd\(1) <= NOT \i2c_master_0|data_rd\(1);
\i2c_master_0|ALT_INV_data_rd\(0) <= NOT \i2c_master_0|data_rd\(0);

-- Location: PIN_52,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 8mA
\DATA1~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	open_drain_output => "true",
	operation_mode => "bidir")
-- pragma translate_on
PORT MAP (
	datain => \i2c_master_0|scl~1_combout\,
	oe => VCC,
	padio => DATA1,
	combout => \DATA1~0\);

-- Location: PIN_53,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 8mA
\DATA2~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	open_drain_output => "true",
	operation_mode => "bidir")
-- pragma translate_on
PORT MAP (
	datain => \i2c_master_0|Selector29~0_combout\,
	oe => VCC,
	padio => DATA2,
	combout => \DATA2~0\);

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

-- Location: LC_X10_Y3_N8
\i2c_master_0|bit_cnt[2]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|bit_cnt\(2) = DFFEAS((\i2c_master_0|bit_cnt\(2) $ (((\i2c_master_0|bit_cnt\(1) & \i2c_master_0|bit_cnt\(0))))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|bit_cnt[2]~5_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "7788",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|bit_cnt\(1),
	datab => \i2c_master_0|bit_cnt\(0),
	datad => \i2c_master_0|bit_cnt\(2),
	aclr => \ALT_INV_DATA4~combout\,
	ena => \i2c_master_0|bit_cnt[2]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|bit_cnt\(2));

-- Location: PIN_54,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\DATA3~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_DATA3,
	combout => \DATA3~combout\);

-- Location: LC_X10_Y3_N9
\i2c_master_0|Selector21~2\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Selector21~2_combout\ = (\i2c_master_0|state.rd~regout\ & (((!\i2c_master_0|bit_cnt\(1)) # (!\i2c_master_0|bit_cnt\(0))) # (!\i2c_master_0|bit_cnt\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "7f00",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|bit_cnt\(2),
	datab => \i2c_master_0|bit_cnt\(0),
	datac => \i2c_master_0|bit_cnt\(1),
	datad => \i2c_master_0|state.rd~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Selector21~2_combout\);

-- Location: LC_X10_Y4_N0
\i2c_master_0|Add0~35\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Add0~35_combout\ = \i2c_master_0|stretch~regout\ $ ((!\i2c_master_0|count\(0)))
-- \i2c_master_0|Add0~37\ = CARRY((!\i2c_master_0|stretch~regout\ & (\i2c_master_0|count\(0))))
-- \i2c_master_0|Add0~37COUT1_46\ = CARRY((!\i2c_master_0|stretch~regout\ & (\i2c_master_0|count\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "9944",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|stretch~regout\,
	datab => \i2c_master_0|count\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Add0~35_combout\,
	cout0 => \i2c_master_0|Add0~37\,
	cout1 => \i2c_master_0|Add0~37COUT1_46\);

-- Location: LC_X10_Y4_N1
\i2c_master_0|Add0~40\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Add0~40_combout\ = (\i2c_master_0|count\(1) $ ((\i2c_master_0|Add0~37\)))
-- \i2c_master_0|Add0~42\ = CARRY(((!\i2c_master_0|Add0~37\) # (!\i2c_master_0|count\(1))))
-- \i2c_master_0|Add0~42COUT1_47\ = CARRY(((!\i2c_master_0|Add0~37COUT1_46\) # (!\i2c_master_0|count\(1))))

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
	datab => \i2c_master_0|count\(1),
	cin0 => \i2c_master_0|Add0~37\,
	cin1 => \i2c_master_0|Add0~37COUT1_46\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Add0~40_combout\,
	cout0 => \i2c_master_0|Add0~42\,
	cout1 => \i2c_master_0|Add0~42COUT1_47\);

-- Location: LC_X10_Y4_N2
\i2c_master_0|Add0~30\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Add0~30_combout\ = (\i2c_master_0|count\(2) $ ((!\i2c_master_0|Add0~42\)))
-- \i2c_master_0|Add0~32\ = CARRY(((\i2c_master_0|count\(2) & !\i2c_master_0|Add0~42\)))
-- \i2c_master_0|Add0~32COUT1_48\ = CARRY(((\i2c_master_0|count\(2) & !\i2c_master_0|Add0~42COUT1_47\)))

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
	datab => \i2c_master_0|count\(2),
	cin0 => \i2c_master_0|Add0~42\,
	cin1 => \i2c_master_0|Add0~42COUT1_47\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Add0~30_combout\,
	cout0 => \i2c_master_0|Add0~32\,
	cout1 => \i2c_master_0|Add0~32COUT1_48\);

-- Location: LC_X9_Y4_N2
\i2c_master_0|count[2]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|count\(2) = DFFEAS((\i2c_master_0|Add0~30_combout\ & (((!\i2c_master_0|Equal0~1_combout\) # (!\i2c_master_0|Equal0~0\)) # (!\i2c_master_0|count\(0)))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "4ccc",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|count\(0),
	datab => \i2c_master_0|Add0~30_combout\,
	datac => \i2c_master_0|Equal0~0\,
	datad => \i2c_master_0|Equal0~1_combout\,
	aclr => \ALT_INV_DATA4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|count\(2));

-- Location: LC_X10_Y4_N3
\i2c_master_0|Add0~20\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Add0~20_combout\ = (\i2c_master_0|count\(3) $ ((\i2c_master_0|Add0~32\)))
-- \i2c_master_0|Add0~22\ = CARRY(((!\i2c_master_0|Add0~32\) # (!\i2c_master_0|count\(3))))
-- \i2c_master_0|Add0~22COUT1_49\ = CARRY(((!\i2c_master_0|Add0~32COUT1_48\) # (!\i2c_master_0|count\(3))))

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
	datab => \i2c_master_0|count\(3),
	cin0 => \i2c_master_0|Add0~32\,
	cin1 => \i2c_master_0|Add0~32COUT1_48\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Add0~20_combout\,
	cout0 => \i2c_master_0|Add0~22\,
	cout1 => \i2c_master_0|Add0~22COUT1_49\);

-- Location: LC_X9_Y4_N7
\i2c_master_0|count[3]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|count\(3) = DFFEAS((\i2c_master_0|Add0~20_combout\ & (((!\i2c_master_0|Equal0~1_combout\) # (!\i2c_master_0|count\(0))) # (!\i2c_master_0|Equal0~0\))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "70f0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|Equal0~0\,
	datab => \i2c_master_0|count\(0),
	datac => \i2c_master_0|Add0~20_combout\,
	datad => \i2c_master_0|Equal0~1_combout\,
	aclr => \ALT_INV_DATA4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|count\(3));

-- Location: LC_X10_Y4_N4
\i2c_master_0|Add0~25\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Add0~25_combout\ = \i2c_master_0|count\(4) $ ((((!\i2c_master_0|Add0~22\))))
-- \i2c_master_0|Add0~27\ = CARRY((\i2c_master_0|count\(4) & ((!\i2c_master_0|Add0~22COUT1_49\))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "a50a",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|count\(4),
	cin0 => \i2c_master_0|Add0~22\,
	cin1 => \i2c_master_0|Add0~22COUT1_49\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Add0~25_combout\,
	cout => \i2c_master_0|Add0~27\);

-- Location: LC_X9_Y4_N9
\i2c_master_0|count[4]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|count\(4) = DFFEAS((\i2c_master_0|Add0~25_combout\ & (((!\i2c_master_0|count\(0)) # (!\i2c_master_0|Equal0~1_combout\)) # (!\i2c_master_0|Equal0~0\))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "7f00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|Equal0~0\,
	datab => \i2c_master_0|Equal0~1_combout\,
	datac => \i2c_master_0|count\(0),
	datad => \i2c_master_0|Add0~25_combout\,
	aclr => \ALT_INV_DATA4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|count\(4));

-- Location: LC_X10_Y4_N5
\i2c_master_0|Add0~15\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Add0~15_combout\ = \i2c_master_0|count\(5) $ ((((\i2c_master_0|Add0~27\))))
-- \i2c_master_0|Add0~17\ = CARRY(((!\i2c_master_0|Add0~27\)) # (!\i2c_master_0|count\(5)))
-- \i2c_master_0|Add0~17COUT1_50\ = CARRY(((!\i2c_master_0|Add0~27\)) # (!\i2c_master_0|count\(5)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "5a5f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|count\(5),
	cin => \i2c_master_0|Add0~27\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Add0~15_combout\,
	cout0 => \i2c_master_0|Add0~17\,
	cout1 => \i2c_master_0|Add0~17COUT1_50\);

-- Location: LC_X9_Y4_N0
\i2c_master_0|count[5]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|count\(5) = DFFEAS((\i2c_master_0|Add0~15_combout\ & (((!\i2c_master_0|Equal0~0\) # (!\i2c_master_0|Equal0~1_combout\)) # (!\i2c_master_0|count\(0)))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "7f00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|count\(0),
	datab => \i2c_master_0|Equal0~1_combout\,
	datac => \i2c_master_0|Equal0~0\,
	datad => \i2c_master_0|Add0~15_combout\,
	aclr => \ALT_INV_DATA4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|count\(5));

-- Location: LC_X10_Y4_N6
\i2c_master_0|Add0~10\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Add0~10_combout\ = (\i2c_master_0|count\(6) $ ((!(!\i2c_master_0|Add0~27\ & \i2c_master_0|Add0~17\) # (\i2c_master_0|Add0~27\ & \i2c_master_0|Add0~17COUT1_50\))))
-- \i2c_master_0|Add0~12\ = CARRY(((\i2c_master_0|count\(6) & !\i2c_master_0|Add0~17\)))
-- \i2c_master_0|Add0~12COUT1_51\ = CARRY(((\i2c_master_0|count\(6) & !\i2c_master_0|Add0~17COUT1_50\)))

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
	datab => \i2c_master_0|count\(6),
	cin => \i2c_master_0|Add0~27\,
	cin0 => \i2c_master_0|Add0~17\,
	cin1 => \i2c_master_0|Add0~17COUT1_50\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Add0~10_combout\,
	cout0 => \i2c_master_0|Add0~12\,
	cout1 => \i2c_master_0|Add0~12COUT1_51\);

-- Location: LC_X9_Y4_N8
\i2c_master_0|count[6]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|count\(6) = DFFEAS((\i2c_master_0|Add0~10_combout\ & (((!\i2c_master_0|Equal0~1_combout\) # (!\i2c_master_0|count\(0))) # (!\i2c_master_0|Equal0~0\))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "70f0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|Equal0~0\,
	datab => \i2c_master_0|count\(0),
	datac => \i2c_master_0|Add0~10_combout\,
	datad => \i2c_master_0|Equal0~1_combout\,
	aclr => \ALT_INV_DATA4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|count\(6));

-- Location: LC_X9_Y4_N5
\i2c_master_0|count[8]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Equal0~0\ = (!\i2c_master_0|count\(6) & (\i2c_master_0|count\(7) & (B1_count[8] & !\i2c_master_0|count\(5))))
-- \i2c_master_0|count\(8) = DFFEAS(\i2c_master_0|Equal0~0\, GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , , \i2c_master_0|count~0_combout\, , , VCC)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0040",
	operation_mode => "normal",
	output_mode => "reg_and_comb",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|count\(6),
	datab => \i2c_master_0|count\(7),
	datac => \i2c_master_0|count~0_combout\,
	datad => \i2c_master_0|count\(5),
	aclr => \ALT_INV_DATA4~combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Equal0~0\,
	regout => \i2c_master_0|count\(8));

-- Location: LC_X10_Y4_N7
\i2c_master_0|Add0~0\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Add0~0_combout\ = \i2c_master_0|count\(7) $ (((((!\i2c_master_0|Add0~27\ & \i2c_master_0|Add0~12\) # (\i2c_master_0|Add0~27\ & \i2c_master_0|Add0~12COUT1_51\)))))
-- \i2c_master_0|Add0~2\ = CARRY(((!\i2c_master_0|Add0~12\)) # (!\i2c_master_0|count\(7)))
-- \i2c_master_0|Add0~2COUT1_52\ = CARRY(((!\i2c_master_0|Add0~12COUT1_51\)) # (!\i2c_master_0|count\(7)))

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
	dataa => \i2c_master_0|count\(7),
	cin => \i2c_master_0|Add0~27\,
	cin0 => \i2c_master_0|Add0~12\,
	cin1 => \i2c_master_0|Add0~12COUT1_51\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Add0~0_combout\,
	cout0 => \i2c_master_0|Add0~2\,
	cout1 => \i2c_master_0|Add0~2COUT1_52\);

-- Location: LC_X10_Y4_N8
\i2c_master_0|Add0~5\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Add0~5_combout\ = (((!\i2c_master_0|Add0~27\ & \i2c_master_0|Add0~2\) # (\i2c_master_0|Add0~27\ & \i2c_master_0|Add0~2COUT1_52\) $ (!\i2c_master_0|count\(8))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "f00f",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datad => \i2c_master_0|count\(8),
	cin => \i2c_master_0|Add0~27\,
	cin0 => \i2c_master_0|Add0~2\,
	cin1 => \i2c_master_0|Add0~2COUT1_52\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Add0~5_combout\);

-- Location: LC_X11_Y4_N1
\i2c_master_0|count~0\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|count~0_combout\ = (\i2c_master_0|Add0~5_combout\ & (((!\i2c_master_0|Equal0~1_combout\) # (!\i2c_master_0|count\(0))) # (!\i2c_master_0|Equal0~0\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "7f00",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|Equal0~0\,
	datab => \i2c_master_0|count\(0),
	datac => \i2c_master_0|Equal0~1_combout\,
	datad => \i2c_master_0|Add0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|count~0_combout\);

-- Location: LC_X9_Y4_N6
\i2c_master_0|count[1]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|count\(1) = DFFEAS((\i2c_master_0|Add0~40_combout\ & (((!\i2c_master_0|Equal0~0\) # (!\i2c_master_0|Equal0~1_combout\)) # (!\i2c_master_0|count\(0)))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "7f00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|count\(0),
	datab => \i2c_master_0|Equal0~1_combout\,
	datac => \i2c_master_0|Equal0~0\,
	datad => \i2c_master_0|Add0~40_combout\,
	aclr => \ALT_INV_DATA4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|count\(1));

-- Location: LC_X9_Y4_N3
\i2c_master_0|Equal0~1\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Equal0~1_combout\ = (\i2c_master_0|count\(1) & (\i2c_master_0|count\(2) & (\i2c_master_0|count\(3) & !\i2c_master_0|count\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0080",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|count\(1),
	datab => \i2c_master_0|count\(2),
	datac => \i2c_master_0|count\(3),
	datad => \i2c_master_0|count\(4),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Equal0~1_combout\);

-- Location: LC_X9_Y4_N1
\i2c_master_0|count[7]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|count\(7) = DFFEAS((\i2c_master_0|Add0~0_combout\ & (((!\i2c_master_0|Equal0~0\) # (!\i2c_master_0|Equal0~1_combout\)) # (!\i2c_master_0|count\(0)))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "7f00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|count\(0),
	datab => \i2c_master_0|Equal0~1_combout\,
	datac => \i2c_master_0|Equal0~0\,
	datad => \i2c_master_0|Add0~0_combout\,
	aclr => \ALT_INV_DATA4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|count\(7));

-- Location: LC_X11_Y4_N9
\i2c_master_0|process_0~0\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|process_0~0_combout\ = ((!\i2c_master_0|Add0~25_combout\ & ((!\i2c_master_0|Add0~20_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0033",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \i2c_master_0|Add0~25_combout\,
	datad => \i2c_master_0|Add0~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|process_0~0_combout\);

-- Location: LC_X10_Y4_N9
\i2c_master_0|process_0~1\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|process_0~1_combout\ = ((\i2c_master_0|Add0~30_combout\ & ((\i2c_master_0|Add0~20_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cc00",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \i2c_master_0|Add0~30_combout\,
	datad => \i2c_master_0|Add0~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|process_0~1_combout\);

-- Location: LC_X11_Y4_N3
\i2c_master_0|process_0~2\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|process_0~2_combout\ = (\i2c_master_0|count~0_combout\ & ((\i2c_master_0|Add0~25_combout\) # ((\i2c_master_0|process_0~1_combout\ & !\i2c_master_0|Equal0~2_combout\)))) # (!\i2c_master_0|count~0_combout\ & 
-- (((\i2c_master_0|Equal0~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cef0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|process_0~1_combout\,
	datab => \i2c_master_0|Add0~25_combout\,
	datac => \i2c_master_0|Equal0~2_combout\,
	datad => \i2c_master_0|count~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|process_0~2_combout\);

-- Location: LC_X11_Y4_N4
\i2c_master_0|process_0~3\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|process_0~3_combout\ = (\i2c_master_0|Add0~15_combout\ & (((\i2c_master_0|process_0~2_combout\)))) # (!\i2c_master_0|Add0~15_combout\ & (\i2c_master_0|Add0~10_combout\ & ((\i2c_master_0|process_0~0_combout\) # 
-- (\i2c_master_0|process_0~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fa40",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|Add0~15_combout\,
	datab => \i2c_master_0|process_0~0_combout\,
	datac => \i2c_master_0|Add0~10_combout\,
	datad => \i2c_master_0|process_0~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|process_0~3_combout\);

-- Location: LC_X11_Y4_N5
\i2c_master_0|process_0~4\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|process_0~4_combout\ = (\i2c_master_0|process_0~3_combout\) # ((\i2c_master_0|Add0~0_combout\ & ((\i2c_master_0|count~0_combout\) # (!\i2c_master_0|Add0~10_combout\))) # (!\i2c_master_0|Add0~0_combout\ & ((\i2c_master_0|Add0~10_combout\) # 
-- (!\i2c_master_0|count~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ffdb",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|Add0~0_combout\,
	datab => \i2c_master_0|count~0_combout\,
	datac => \i2c_master_0|Add0~10_combout\,
	datad => \i2c_master_0|process_0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|process_0~4_combout\);

-- Location: LC_X11_Y4_N6
\i2c_master_0|stretch\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|stretch~regout\ = DFFEAS(((\i2c_master_0|process_0~4_combout\ & ((\i2c_master_0|stretch~regout\))) # (!\i2c_master_0|process_0~4_combout\ & (!\DATA1~0\))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f033",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \DATA1~0\,
	datac => \i2c_master_0|stretch~regout\,
	datad => \i2c_master_0|process_0~4_combout\,
	aclr => \ALT_INV_DATA4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|stretch~regout\);

-- Location: LC_X9_Y4_N4
\i2c_master_0|count[0]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|count\(0) = DFFEAS((\i2c_master_0|Add0~35_combout\ & (((!\i2c_master_0|Equal0~1_combout\) # (!\i2c_master_0|Equal0~0\)) # (!\i2c_master_0|count\(0)))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "4ccc",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|count\(0),
	datab => \i2c_master_0|Add0~35_combout\,
	datac => \i2c_master_0|Equal0~0\,
	datad => \i2c_master_0|Equal0~1_combout\,
	aclr => \ALT_INV_DATA4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|count\(0));

-- Location: LC_X12_Y4_N9
\i2c_master_0|Equal0~2\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Equal0~2_combout\ = ((\i2c_master_0|count\(0) & (\i2c_master_0|Equal0~1_combout\ & \i2c_master_0|Equal0~0\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \i2c_master_0|count\(0),
	datac => \i2c_master_0|Equal0~1_combout\,
	datad => \i2c_master_0|Equal0~0\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Equal0~2_combout\);

-- Location: LC_X12_Y4_N1
\i2c_master_0|LessThan1~0\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|LessThan1~0_combout\ = ((\i2c_master_0|Add0~20_combout\) # ((\i2c_master_0|Add0~25_combout\) # (\i2c_master_0|Add0~30_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fffc",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \i2c_master_0|Add0~20_combout\,
	datac => \i2c_master_0|Add0~25_combout\,
	datad => \i2c_master_0|Add0~30_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|LessThan1~0_combout\);

-- Location: LC_X11_Y4_N7
\i2c_master_0|LessThan1~1\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|LessThan1~1_combout\ = (!\i2c_master_0|Add0~0_combout\ & (((!\i2c_master_0|LessThan1~0_combout\) # (!\i2c_master_0|Add0~10_combout\)) # (!\i2c_master_0|Add0~15_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1333",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|Add0~15_combout\,
	datab => \i2c_master_0|Add0~0_combout\,
	datac => \i2c_master_0|Add0~10_combout\,
	datad => \i2c_master_0|LessThan1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|LessThan1~1_combout\);

-- Location: LC_X11_Y4_N0
\i2c_master_0|process_0~5\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|process_0~5_combout\ = (\i2c_master_0|Add0~10_combout\ & ((\i2c_master_0|Add0~15_combout\ & (\i2c_master_0|Add0~0_combout\)) # (!\i2c_master_0|Add0~15_combout\ & ((!\i2c_master_0|process_0~0_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "80d0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|Add0~15_combout\,
	datab => \i2c_master_0|Add0~0_combout\,
	datac => \i2c_master_0|Add0~10_combout\,
	datad => \i2c_master_0|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|process_0~5_combout\);

-- Location: LC_X11_Y4_N8
\i2c_master_0|data_clk~0\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_clk~0_combout\ = ((\i2c_master_0|Add0~5_combout\) # ((\i2c_master_0|process_0~5_combout\ & !\i2c_master_0|LessThan1~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccfc",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \i2c_master_0|Add0~5_combout\,
	datac => \i2c_master_0|process_0~5_combout\,
	datad => \i2c_master_0|LessThan1~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|data_clk~0_combout\);

-- Location: LC_X11_Y4_N2
\i2c_master_0|data_clk\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_clk~regout\ = DFFEAS((!\i2c_master_0|Equal0~2_combout\ & ((\i2c_master_0|data_clk~0_combout\ & ((!\i2c_master_0|process_0~4_combout\))) # (!\i2c_master_0|data_clk~0_combout\ & (!\i2c_master_0|LessThan1~1_combout\)))), 
-- GLOBAL(\clock~combout\), VCC, , \DATA4~combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0511",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|Equal0~2_combout\,
	datab => \i2c_master_0|LessThan1~1_combout\,
	datac => \i2c_master_0|process_0~4_combout\,
	datad => \i2c_master_0|data_clk~0_combout\,
	aclr => GND,
	ena => \DATA4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_clk~regout\);

-- Location: LC_X12_Y4_N8
\i2c_master_0|data_clk_prev\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Decoder0~0\ = (\DATA4~combout\ & (!\i2c_master_0|data_clk~regout\ & (B1_data_clk_prev & \i2c_master_0|state.rd~regout\)))
-- \i2c_master_0|data_clk_prev~regout\ = DFFEAS(\i2c_master_0|Decoder0~0\, GLOBAL(\clock~combout\), VCC, , \DATA4~combout\, \i2c_master_0|data_clk~regout\, , , VCC)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "2000",
	operation_mode => "normal",
	output_mode => "reg_and_comb",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \DATA4~combout\,
	datab => \i2c_master_0|data_clk~regout\,
	datac => \i2c_master_0|data_clk~regout\,
	datad => \i2c_master_0|state.rd~regout\,
	aclr => GND,
	sload => VCC,
	ena => \DATA4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Decoder0~0\,
	regout => \i2c_master_0|data_clk_prev~regout\);

-- Location: LC_X10_Y3_N0
\i2c_master_0|process_1~0\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|process_1~0_combout\ = ((\i2c_master_0|data_clk~regout\ & ((!\i2c_master_0|data_clk_prev~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00cc",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \i2c_master_0|data_clk~regout\,
	datad => \i2c_master_0|data_clk_prev~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|process_1~0_combout\);

-- Location: LC_X11_Y3_N7
\i2c_master_0|state.slv_ack1\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|state.slv_ack1~regout\ = DFFEAS((\i2c_master_0|state.command~regout\ & (\i2c_master_0|bit_cnt\(2) & (\i2c_master_0|bit_cnt\(1) & \i2c_master_0|bit_cnt\(0)))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , 
-- \i2c_master_0|process_1~0_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "8000",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|state.command~regout\,
	datab => \i2c_master_0|bit_cnt\(2),
	datac => \i2c_master_0|bit_cnt\(1),
	datad => \i2c_master_0|bit_cnt\(0),
	aclr => \ALT_INV_DATA4~combout\,
	ena => \i2c_master_0|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|state.slv_ack1~regout\);

-- Location: LC_X12_Y3_N6
\i2c_master_0|Selector20~0\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Selector20~0_combout\ = ((\i2c_master_0|state.slv_ack1~regout\) # ((\DATA3~combout\ & \i2c_master_0|state.slv_ack2~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff88",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \DATA3~combout\,
	datab => \i2c_master_0|state.slv_ack2~regout\,
	datad => \i2c_master_0|state.slv_ack1~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Selector20~0_combout\);

-- Location: LC_X11_Y3_N0
\i2c_master_0|Equal1~0\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Equal1~0_combout\ = (((\i2c_master_0|bit_cnt\(1) & \i2c_master_0|bit_cnt\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \i2c_master_0|bit_cnt\(1),
	datad => \i2c_master_0|bit_cnt\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Equal1~0_combout\);

-- Location: LC_X11_Y3_N1
\i2c_master_0|state.wr\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|state.wr~regout\ = DFFEAS((\i2c_master_0|Selector20~0_combout\) # ((\i2c_master_0|state.wr~regout\ & ((!\i2c_master_0|bit_cnt\(2)) # (!\i2c_master_0|Equal1~0_combout\)))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , 
-- \i2c_master_0|process_1~0_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "bfaa",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|Selector20~0_combout\,
	datab => \i2c_master_0|Equal1~0_combout\,
	datac => \i2c_master_0|bit_cnt\(2),
	datad => \i2c_master_0|state.wr~regout\,
	aclr => \ALT_INV_DATA4~combout\,
	ena => \i2c_master_0|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|state.wr~regout\);

-- Location: LC_X10_Y3_N1
\i2c_master_0|state~14\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|state~14_combout\ = (\i2c_master_0|bit_cnt\(2) & (\i2c_master_0|bit_cnt\(0) & (\i2c_master_0|bit_cnt\(1) & \i2c_master_0|state.wr~regout\)))

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
	dataa => \i2c_master_0|bit_cnt\(2),
	datab => \i2c_master_0|bit_cnt\(0),
	datac => \i2c_master_0|bit_cnt\(1),
	datad => \i2c_master_0|state.wr~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|state~14_combout\);

-- Location: LC_X12_Y3_N2
\i2c_master_0|state.slv_ack2\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Selector28~0\ = (((!B1_state.slv_ack2 & !\i2c_master_0|state.slv_ack1~regout\)))
-- \i2c_master_0|state.slv_ack2~regout\ = DFFEAS(\i2c_master_0|Selector28~0\, GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|process_1~0_combout\, \i2c_master_0|state~14_combout\, , , VCC)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "000f",
	operation_mode => "normal",
	output_mode => "reg_and_comb",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datac => \i2c_master_0|state~14_combout\,
	datad => \i2c_master_0|state.slv_ack1~regout\,
	aclr => \ALT_INV_DATA4~combout\,
	sload => VCC,
	ena => \i2c_master_0|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Selector28~0\,
	regout => \i2c_master_0|state.slv_ack2~regout\);

-- Location: LC_X12_Y3_N5
\i2c_master_0|state.mstr_ack\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Selector23~0\ = ((B1_state.mstr_ack) # ((!\DATA3~combout\ & \i2c_master_0|state.slv_ack2~regout\))) # (!\i2c_master_0|state.ready~regout\)
-- \i2c_master_0|state.mstr_ack~regout\ = DFFEAS(\i2c_master_0|Selector23~0\, GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|process_1~0_combout\, \i2c_master_0|data_rd[0]~2_combout\, , , VCC)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f7f3",
	operation_mode => "normal",
	output_mode => "reg_and_comb",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \DATA3~combout\,
	datab => \i2c_master_0|state.ready~regout\,
	datac => \i2c_master_0|data_rd[0]~2_combout\,
	datad => \i2c_master_0|state.slv_ack2~regout\,
	aclr => \ALT_INV_DATA4~combout\,
	sload => VCC,
	ena => \i2c_master_0|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Selector23~0\,
	regout => \i2c_master_0|state.mstr_ack~regout\);

-- Location: LC_X12_Y3_N8
\i2c_master_0|state.rd\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|state.rd~regout\ = DFFEAS((\i2c_master_0|Selector21~2_combout\) # ((\DATA3~combout\ & (\i2c_master_0|state.mstr_ack~regout\))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|process_1~0_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ecec",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \DATA3~combout\,
	datab => \i2c_master_0|Selector21~2_combout\,
	datac => \i2c_master_0|state.mstr_ack~regout\,
	aclr => \ALT_INV_DATA4~combout\,
	ena => \i2c_master_0|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|state.rd~regout\);

-- Location: LC_X10_Y3_N6
\i2c_master_0|data_rd[0]~2\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rd[0]~2_combout\ = (\i2c_master_0|bit_cnt\(2) & (\i2c_master_0|bit_cnt\(0) & (\i2c_master_0|bit_cnt\(1) & \i2c_master_0|state.rd~regout\)))

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
	dataa => \i2c_master_0|bit_cnt\(2),
	datab => \i2c_master_0|bit_cnt\(0),
	datac => \i2c_master_0|bit_cnt\(1),
	datad => \i2c_master_0|state.rd~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|data_rd[0]~2_combout\);

-- Location: LC_X11_Y3_N8
\i2c_master_0|Selector23~2\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Selector23~2_combout\ = (\i2c_master_0|state.command~regout\ & ((\i2c_master_0|bit_cnt\(0) & (\i2c_master_0|bit_cnt\(1) & \i2c_master_0|bit_cnt\(2))) # (!\i2c_master_0|bit_cnt\(0) & ((!\i2c_master_0|bit_cnt\(2))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "8030",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|bit_cnt\(1),
	datab => \i2c_master_0|bit_cnt\(0),
	datac => \i2c_master_0|state.command~regout\,
	datad => \i2c_master_0|bit_cnt\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Selector23~2_combout\);

-- Location: LC_X11_Y3_N9
\i2c_master_0|state.start\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Selector23~3\ = (!\i2c_master_0|bit_cnt\(2) & (B1_state.start & ((\i2c_master_0|bit_cnt\(0)) # (!\i2c_master_0|bit_cnt\(1)))))
-- \i2c_master_0|state.start~regout\ = DFFEAS(\i2c_master_0|Selector23~3\, GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|process_1~0_combout\, \i2c_master_0|Selector0~1_combout\, , , VCC)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "3010",
	operation_mode => "normal",
	output_mode => "reg_and_comb",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|bit_cnt\(1),
	datab => \i2c_master_0|bit_cnt\(2),
	datac => \i2c_master_0|Selector0~1_combout\,
	datad => \i2c_master_0|bit_cnt\(0),
	aclr => \ALT_INV_DATA4~combout\,
	sload => VCC,
	ena => \i2c_master_0|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Selector23~3\,
	regout => \i2c_master_0|state.start~regout\);

-- Location: LC_X12_Y3_N4
\i2c_master_0|Selector22~0\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Selector22~0_combout\ = (!\DATA3~combout\ & ((\i2c_master_0|state.slv_ack2~regout\) # ((\i2c_master_0|state.mstr_ack~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "5454",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \DATA3~combout\,
	datab => \i2c_master_0|state.slv_ack2~regout\,
	datac => \i2c_master_0|state.mstr_ack~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Selector22~0_combout\);

-- Location: LC_X12_Y3_N7
\i2c_master_0|state.stop\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Selector23~1\ = (!\i2c_master_0|sda_int~regout\ & ((\i2c_master_0|Selector23~0\) # ((B1_state.stop) # (\i2c_master_0|Selector21~2_combout\))))
-- \i2c_master_0|state.stop~regout\ = DFFEAS(\i2c_master_0|Selector23~1\, GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|process_1~0_combout\, \i2c_master_0|Selector22~0_combout\, , , VCC)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "3332",
	operation_mode => "normal",
	output_mode => "reg_and_comb",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|Selector23~0\,
	datab => \i2c_master_0|sda_int~regout\,
	datac => \i2c_master_0|Selector22~0_combout\,
	datad => \i2c_master_0|Selector21~2_combout\,
	aclr => \ALT_INV_DATA4~combout\,
	sload => VCC,
	ena => \i2c_master_0|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Selector23~1\,
	regout => \i2c_master_0|state.stop~regout\);

-- Location: LC_X11_Y3_N5
\i2c_master_0|Selector23~4\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Selector23~4_combout\ = (\i2c_master_0|Selector23~2_combout\) # ((\i2c_master_0|Selector23~3\) # ((\i2c_master_0|state~14_combout\) # (\i2c_master_0|Selector23~1\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fffe",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|Selector23~2_combout\,
	datab => \i2c_master_0|Selector23~3\,
	datac => \i2c_master_0|state~14_combout\,
	datad => \i2c_master_0|Selector23~1\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Selector23~4_combout\);

-- Location: LC_X12_Y3_N9
\i2c_master_0|sda_int\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|sda_int~regout\ = DFFEAS((!\i2c_master_0|Selector23~4_combout\ & ((\DATA3~combout\ & ((!\i2c_master_0|state.mstr_ack~regout\))) # (!\DATA3~combout\ & (!\i2c_master_0|data_rd[0]~2_combout\)))), GLOBAL(\clock~combout\), 
-- GLOBAL(\DATA4~combout\), , \i2c_master_0|process_1~0_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "001b",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \DATA3~combout\,
	datab => \i2c_master_0|data_rd[0]~2_combout\,
	datac => \i2c_master_0|state.mstr_ack~regout\,
	datad => \i2c_master_0|Selector23~4_combout\,
	aclr => \ALT_INV_DATA4~combout\,
	ena => \i2c_master_0|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|sda_int~regout\);

-- Location: LC_X12_Y3_N1
\i2c_master_0|state.ready\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|state.ready~regout\ = DFFEAS((!\i2c_master_0|state.stop~regout\ & ((\DATA3~combout\) # ((\i2c_master_0|state.ready~regout\)))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|process_1~0_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "3322",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \DATA3~combout\,
	datab => \i2c_master_0|state.stop~regout\,
	datad => \i2c_master_0|state.ready~regout\,
	aclr => \ALT_INV_DATA4~combout\,
	ena => \i2c_master_0|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|state.ready~regout\);

-- Location: LC_X12_Y3_N0
\i2c_master_0|Selector0~1\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Selector0~1_combout\ = ((!\i2c_master_0|state.ready~regout\ & ((\DATA3~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "3300",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \i2c_master_0|state.ready~regout\,
	datad => \DATA3~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Selector0~1_combout\);

-- Location: LC_X11_Y3_N4
\i2c_master_0|state.command\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|state.command~regout\ = DFFEAS((\i2c_master_0|state.start~regout\) # ((\i2c_master_0|state.command~regout\ & ((!\i2c_master_0|bit_cnt\(2)) # (!\i2c_master_0|Equal1~0_combout\)))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , 
-- \i2c_master_0|process_1~0_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "bfaa",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|state.start~regout\,
	datab => \i2c_master_0|Equal1~0_combout\,
	datac => \i2c_master_0|bit_cnt\(2),
	datad => \i2c_master_0|state.command~regout\,
	aclr => \ALT_INV_DATA4~combout\,
	ena => \i2c_master_0|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|state.command~regout\);

-- Location: LC_X10_Y3_N3
\i2c_master_0|Selector0~2\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Selector0~2_combout\ = ((!\i2c_master_0|state.rd~regout\ & ((!\i2c_master_0|state.wr~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0033",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \i2c_master_0|state.rd~regout\,
	datad => \i2c_master_0|state.wr~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Selector0~2_combout\);

-- Location: LC_X10_Y3_N4
\i2c_master_0|bit_cnt[2]~5\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|bit_cnt[2]~5_combout\ = (!\i2c_master_0|data_clk_prev~regout\ & (\i2c_master_0|data_clk~regout\ & ((\i2c_master_0|state.command~regout\) # (!\i2c_master_0|Selector0~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "2030",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|state.command~regout\,
	datab => \i2c_master_0|data_clk_prev~regout\,
	datac => \i2c_master_0|data_clk~regout\,
	datad => \i2c_master_0|Selector0~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|bit_cnt[2]~5_combout\);

-- Location: LC_X10_Y3_N2
\i2c_master_0|bit_cnt[0]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|bit_cnt\(0) = DFFEAS((((!\i2c_master_0|bit_cnt\(0)))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|bit_cnt[2]~5_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00ff",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datad => \i2c_master_0|bit_cnt\(0),
	aclr => \ALT_INV_DATA4~combout\,
	ena => \i2c_master_0|bit_cnt[2]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|bit_cnt\(0));

-- Location: LC_X10_Y3_N5
\i2c_master_0|bit_cnt[1]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|bit_cnt\(1) = DFFEAS(((\i2c_master_0|bit_cnt\(1) $ (\i2c_master_0|bit_cnt\(0)))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|bit_cnt[2]~5_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0ff0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datac => \i2c_master_0|bit_cnt\(1),
	datad => \i2c_master_0|bit_cnt\(0),
	aclr => \ALT_INV_DATA4~combout\,
	ena => \i2c_master_0|bit_cnt[2]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|bit_cnt\(1));

-- Location: LC_X8_Y4_N6
\i2c_master_0|Decoder0~1\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Decoder0~1_combout\ = (\i2c_master_0|bit_cnt\(1) & (\i2c_master_0|bit_cnt\(0) & (\i2c_master_0|bit_cnt\(2) & \i2c_master_0|Decoder0~0\)))

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
	dataa => \i2c_master_0|bit_cnt\(1),
	datab => \i2c_master_0|bit_cnt\(0),
	datac => \i2c_master_0|bit_cnt\(2),
	datad => \i2c_master_0|Decoder0~0\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Decoder0~1_combout\);

-- Location: LC_X8_Y4_N7
\i2c_master_0|data_rx[0]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rx\(0) = DFFEAS(((\i2c_master_0|Decoder0~1_combout\ & (\DATA2~0\)) # (!\i2c_master_0|Decoder0~1_combout\ & ((\i2c_master_0|data_rx\(0))))), GLOBAL(\clock~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccf0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \DATA2~0\,
	datac => \i2c_master_0|data_rx\(0),
	datad => \i2c_master_0|Decoder0~1_combout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_rx\(0));

-- Location: LC_X10_Y3_N7
\i2c_master_0|data_rd[0]~3\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rd[0]~3_combout\ = ((\i2c_master_0|data_clk~regout\ & (!\i2c_master_0|data_clk_prev~regout\ & \i2c_master_0|data_rd[0]~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0c00",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \i2c_master_0|data_clk~regout\,
	datac => \i2c_master_0|data_clk_prev~regout\,
	datad => \i2c_master_0|data_rd[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|data_rd[0]~3_combout\);

-- Location: LC_X8_Y4_N3
\i2c_master_0|data_rd[0]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rd\(0) = DFFEAS(GND, GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|data_rd[0]~3_combout\, \i2c_master_0|data_rx\(0), , , VCC)

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
	datac => \i2c_master_0|data_rx\(0),
	aclr => \ALT_INV_DATA4~combout\,
	sload => VCC,
	ena => \i2c_master_0|data_rd[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_rd\(0));

-- Location: LC_X8_Y4_N1
\i2c_master_0|Decoder0~2\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Decoder0~2_combout\ = (\i2c_master_0|bit_cnt\(1) & (!\i2c_master_0|bit_cnt\(0) & (\i2c_master_0|bit_cnt\(2) & \i2c_master_0|Decoder0~0\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "2000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|bit_cnt\(1),
	datab => \i2c_master_0|bit_cnt\(0),
	datac => \i2c_master_0|bit_cnt\(2),
	datad => \i2c_master_0|Decoder0~0\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Decoder0~2_combout\);

-- Location: LC_X8_Y4_N2
\i2c_master_0|data_rx[1]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rx\(1) = DFFEAS(((\i2c_master_0|Decoder0~2_combout\ & ((\DATA2~0\))) # (!\i2c_master_0|Decoder0~2_combout\ & (\i2c_master_0|data_rx\(1)))), GLOBAL(\clock~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0cc",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \i2c_master_0|data_rx\(1),
	datac => \DATA2~0\,
	datad => \i2c_master_0|Decoder0~2_combout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_rx\(1));

-- Location: LC_X8_Y4_N8
\i2c_master_0|data_rd[1]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rd\(1) = DFFEAS((((\i2c_master_0|data_rx\(1)))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|data_rd[0]~3_combout\, , , , )

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
	datad => \i2c_master_0|data_rx\(1),
	aclr => \ALT_INV_DATA4~combout\,
	ena => \i2c_master_0|data_rd[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_rd\(1));

-- Location: LC_X8_Y4_N9
\i2c_master_0|Decoder0~3\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Decoder0~3_combout\ = (!\i2c_master_0|bit_cnt\(1) & (\i2c_master_0|bit_cnt\(0) & (\i2c_master_0|bit_cnt\(2) & \i2c_master_0|Decoder0~0\)))

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
	dataa => \i2c_master_0|bit_cnt\(1),
	datab => \i2c_master_0|bit_cnt\(0),
	datac => \i2c_master_0|bit_cnt\(2),
	datad => \i2c_master_0|Decoder0~0\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Decoder0~3_combout\);

-- Location: LC_X8_Y4_N0
\i2c_master_0|data_rx[2]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rx\(2) = DFFEAS(((\i2c_master_0|Decoder0~3_combout\ & (\DATA2~0\)) # (!\i2c_master_0|Decoder0~3_combout\ & ((\i2c_master_0|data_rx\(2))))), GLOBAL(\clock~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccf0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \DATA2~0\,
	datac => \i2c_master_0|data_rx\(2),
	datad => \i2c_master_0|Decoder0~3_combout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_rx\(2));

-- Location: LC_X8_Y4_N5
\i2c_master_0|data_rd[2]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rd\(2) = DFFEAS(GND, GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|data_rd[0]~3_combout\, \i2c_master_0|data_rx\(2), , , VCC)

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
	datac => \i2c_master_0|data_rx\(2),
	aclr => \ALT_INV_DATA4~combout\,
	sload => VCC,
	ena => \i2c_master_0|data_rd[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_rd\(2));

-- Location: LC_X8_Y4_N4
\i2c_master_0|Decoder0~4\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Decoder0~4_combout\ = (!\i2c_master_0|bit_cnt\(1) & (!\i2c_master_0|bit_cnt\(0) & (\i2c_master_0|bit_cnt\(2) & \i2c_master_0|Decoder0~0\)))

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
	dataa => \i2c_master_0|bit_cnt\(1),
	datab => \i2c_master_0|bit_cnt\(0),
	datac => \i2c_master_0|bit_cnt\(2),
	datad => \i2c_master_0|Decoder0~0\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Decoder0~4_combout\);

-- Location: LC_X6_Y4_N4
\i2c_master_0|data_rx[3]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rx\(3) = DFFEAS(((\i2c_master_0|Decoder0~4_combout\ & (\DATA2~0\)) # (!\i2c_master_0|Decoder0~4_combout\ & ((\i2c_master_0|data_rx\(3))))), GLOBAL(\clock~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccf0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \DATA2~0\,
	datac => \i2c_master_0|data_rx\(3),
	datad => \i2c_master_0|Decoder0~4_combout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_rx\(3));

-- Location: LC_X6_Y4_N5
\i2c_master_0|data_rd[3]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rd\(3) = DFFEAS(GND, GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|data_rd[0]~3_combout\, \i2c_master_0|data_rx\(3), , , VCC)

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
	datac => \i2c_master_0|data_rx\(3),
	aclr => \ALT_INV_DATA4~combout\,
	sload => VCC,
	ena => \i2c_master_0|data_rd[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_rd\(3));

-- Location: LC_X7_Y4_N4
\i2c_master_0|Decoder0~5\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Decoder0~5_combout\ = (\i2c_master_0|bit_cnt\(1) & (!\i2c_master_0|bit_cnt\(2) & (\i2c_master_0|bit_cnt\(0) & \i2c_master_0|Decoder0~0\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "2000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|bit_cnt\(1),
	datab => \i2c_master_0|bit_cnt\(2),
	datac => \i2c_master_0|bit_cnt\(0),
	datad => \i2c_master_0|Decoder0~0\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Decoder0~5_combout\);

-- Location: LC_X7_Y4_N2
\i2c_master_0|data_rx[4]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rx\(4) = DFFEAS(((\i2c_master_0|Decoder0~5_combout\ & (\DATA2~0\)) # (!\i2c_master_0|Decoder0~5_combout\ & ((\i2c_master_0|data_rx\(4))))), GLOBAL(\clock~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "afa0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \DATA2~0\,
	datac => \i2c_master_0|Decoder0~5_combout\,
	datad => \i2c_master_0|data_rx\(4),
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_rx\(4));

-- Location: LC_X7_Y4_N7
\i2c_master_0|data_rd[4]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rd\(4) = DFFEAS((((\i2c_master_0|data_rx\(4)))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|data_rd[0]~3_combout\, , , , )

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
	datad => \i2c_master_0|data_rx\(4),
	aclr => \ALT_INV_DATA4~combout\,
	ena => \i2c_master_0|data_rd[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_rd\(4));

-- Location: LC_X7_Y4_N8
\i2c_master_0|Decoder0~6\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Decoder0~6_combout\ = (\i2c_master_0|bit_cnt\(1) & (!\i2c_master_0|bit_cnt\(2) & (!\i2c_master_0|bit_cnt\(0) & \i2c_master_0|Decoder0~0\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0200",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|bit_cnt\(1),
	datab => \i2c_master_0|bit_cnt\(2),
	datac => \i2c_master_0|bit_cnt\(0),
	datad => \i2c_master_0|Decoder0~0\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Decoder0~6_combout\);

-- Location: LC_X7_Y4_N0
\i2c_master_0|data_rx[5]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rx\(5) = DFFEAS(((\i2c_master_0|Decoder0~6_combout\ & (\DATA2~0\)) # (!\i2c_master_0|Decoder0~6_combout\ & ((\i2c_master_0|data_rx\(5))))), GLOBAL(\clock~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aaf0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \DATA2~0\,
	datac => \i2c_master_0|data_rx\(5),
	datad => \i2c_master_0|Decoder0~6_combout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_rx\(5));

-- Location: LC_X7_Y4_N3
\i2c_master_0|data_rd[5]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rd\(5) = DFFEAS(GND, GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|data_rd[0]~3_combout\, \i2c_master_0|data_rx\(5), , , VCC)

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
	datac => \i2c_master_0|data_rx\(5),
	aclr => \ALT_INV_DATA4~combout\,
	sload => VCC,
	ena => \i2c_master_0|data_rd[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_rd\(5));

-- Location: LC_X7_Y4_N5
\i2c_master_0|Decoder0~7\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Decoder0~7_combout\ = (!\i2c_master_0|bit_cnt\(1) & (!\i2c_master_0|bit_cnt\(2) & (\i2c_master_0|bit_cnt\(0) & \i2c_master_0|Decoder0~0\)))

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
	dataa => \i2c_master_0|bit_cnt\(1),
	datab => \i2c_master_0|bit_cnt\(2),
	datac => \i2c_master_0|bit_cnt\(0),
	datad => \i2c_master_0|Decoder0~0\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Decoder0~7_combout\);

-- Location: LC_X7_Y4_N6
\i2c_master_0|data_rx[6]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rx\(6) = DFFEAS(((\i2c_master_0|Decoder0~7_combout\ & (\DATA2~0\)) # (!\i2c_master_0|Decoder0~7_combout\ & ((\i2c_master_0|data_rx\(6))))), GLOBAL(\clock~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aaf0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \DATA2~0\,
	datac => \i2c_master_0|data_rx\(6),
	datad => \i2c_master_0|Decoder0~7_combout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_rx\(6));

-- Location: LC_X7_Y4_N9
\i2c_master_0|data_rd[6]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rd\(6) = DFFEAS(GND, GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|data_rd[0]~3_combout\, \i2c_master_0|data_rx\(6), , , VCC)

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
	datac => \i2c_master_0|data_rx\(6),
	aclr => \ALT_INV_DATA4~combout\,
	sload => VCC,
	ena => \i2c_master_0|data_rd[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_rd\(6));

-- Location: LC_X7_Y4_N1
\i2c_master_0|Decoder0~8\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Decoder0~8_combout\ = (!\i2c_master_0|bit_cnt\(1) & (!\i2c_master_0|bit_cnt\(2) & (!\i2c_master_0|bit_cnt\(0) & \i2c_master_0|Decoder0~0\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|bit_cnt\(1),
	datab => \i2c_master_0|bit_cnt\(2),
	datac => \i2c_master_0|bit_cnt\(0),
	datad => \i2c_master_0|Decoder0~0\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Decoder0~8_combout\);

-- Location: LC_X6_Y4_N6
\i2c_master_0|data_rx[7]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rx\(7) = DFFEAS(((\i2c_master_0|Decoder0~8_combout\ & (\DATA2~0\)) # (!\i2c_master_0|Decoder0~8_combout\ & ((\i2c_master_0|data_rx\(7))))), GLOBAL(\clock~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccf0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \DATA2~0\,
	datac => \i2c_master_0|data_rx\(7),
	datad => \i2c_master_0|Decoder0~8_combout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_rx\(7));

-- Location: LC_X6_Y4_N2
\i2c_master_0|data_rd[7]\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|data_rd\(7) = DFFEAS(GND, GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|data_rd[0]~3_combout\, \i2c_master_0|data_rx\(7), , , VCC)

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
	datac => \i2c_master_0|data_rx\(7),
	aclr => \ALT_INV_DATA4~combout\,
	sload => VCC,
	ena => \i2c_master_0|data_rd[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|data_rd\(7));

-- Location: LC_X11_Y3_N6
\i2c_master_0|bit_cnt[2]~4\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|bit_cnt[2]~4_combout\ = ((!\i2c_master_0|state.wr~regout\ & (!\i2c_master_0|state.command~regout\ & !\i2c_master_0|state.rd~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0003",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \i2c_master_0|state.wr~regout\,
	datac => \i2c_master_0|state.command~regout\,
	datad => \i2c_master_0|state.rd~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|bit_cnt[2]~4_combout\);

-- Location: LC_X12_Y3_N3
\i2c_master_0|Selector28~1\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Selector28~1_combout\ = (!\i2c_master_0|state.mstr_ack~regout\ & (\i2c_master_0|state.ready~regout\ & (\i2c_master_0|bit_cnt[2]~4_combout\ & \i2c_master_0|Selector28~0\)))

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
	dataa => \i2c_master_0|state.mstr_ack~regout\,
	datab => \i2c_master_0|state.ready~regout\,
	datac => \i2c_master_0|bit_cnt[2]~4_combout\,
	datad => \i2c_master_0|Selector28~0\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Selector28~1_combout\);

-- Location: LC_X12_Y2_N6
\i2c_master_0|process_1~1\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|process_1~1_combout\ = ((!\i2c_master_0|data_clk~regout\ & ((\i2c_master_0|data_clk_prev~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "3300",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \i2c_master_0|data_clk~regout\,
	datad => \i2c_master_0|data_clk_prev~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|process_1~1_combout\);

-- Location: LC_X12_Y2_N2
\i2c_master_0|scl_ena\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|scl_ena~regout\ = DFFEAS(((\i2c_master_0|state.start~regout\) # ((\i2c_master_0|scl_ena~regout\ & !\i2c_master_0|Selector28~1_combout\))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|process_1~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0fc",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	datab => \i2c_master_0|scl_ena~regout\,
	datac => \i2c_master_0|state.start~regout\,
	datad => \i2c_master_0|Selector28~1_combout\,
	aclr => \ALT_INV_DATA4~combout\,
	ena => \i2c_master_0|process_1~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|scl_ena~regout\);

-- Location: LC_X12_Y2_N8
\i2c_master_0|Selector28~2\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Selector28~2_combout\ = (\i2c_master_0|state.stop~regout\) # (((\i2c_master_0|state.start~regout\ & \i2c_master_0|scl_ena~regout\)) # (!\i2c_master_0|Selector28~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f8ff",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|state.start~regout\,
	datab => \i2c_master_0|scl_ena~regout\,
	datac => \i2c_master_0|state.stop~regout\,
	datad => \i2c_master_0|Selector28~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Selector28~2_combout\);

-- Location: LC_X12_Y2_N9
\i2c_master_0|ack_error\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|ack_error~regout\ = DFFEAS((\DATA2~0\ & (((\i2c_master_0|ack_error~regout\ & \i2c_master_0|Selector28~2_combout\)) # (!\i2c_master_0|Selector28~0\))) # (!\DATA2~0\ & (\i2c_master_0|ack_error~regout\ & 
-- ((\i2c_master_0|Selector28~2_combout\)))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , \i2c_master_0|process_1~1_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ce0a",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \DATA2~0\,
	datab => \i2c_master_0|ack_error~regout\,
	datac => \i2c_master_0|Selector28~0\,
	datad => \i2c_master_0|Selector28~2_combout\,
	aclr => \ALT_INV_DATA4~combout\,
	ena => \i2c_master_0|process_1~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|ack_error~regout\);

-- Location: LC_X11_Y3_N3
\i2c_master_0|Selector0~0\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Selector0~0_combout\ = (!\i2c_master_0|busy~regout\ & ((\i2c_master_0|state.command~regout\) # ((\i2c_master_0|state.slv_ack1~regout\) # (\i2c_master_0|Selector22~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "3332",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|state.command~regout\,
	datab => \i2c_master_0|busy~regout\,
	datac => \i2c_master_0|state.slv_ack1~regout\,
	datad => \i2c_master_0|Selector22~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Selector0~0_combout\);

-- Location: LC_X11_Y3_N2
\i2c_master_0|busy\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|busy~regout\ = DFFEAS((!\i2c_master_0|state.start~regout\ & (\i2c_master_0|Selector0~2_combout\ & (!\i2c_master_0|Selector0~1_combout\ & !\i2c_master_0|Selector0~0_combout\))), GLOBAL(\clock~combout\), GLOBAL(\DATA4~combout\), , 
-- \i2c_master_0|process_1~0_combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0004",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|state.start~regout\,
	datab => \i2c_master_0|Selector0~2_combout\,
	datac => \i2c_master_0|Selector0~1_combout\,
	datad => \i2c_master_0|Selector0~0_combout\,
	aclr => \ALT_INV_DATA4~combout\,
	ena => \i2c_master_0|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|busy~regout\);

-- Location: LC_X12_Y4_N2
\i2c_master_0|scl_clk\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|scl_clk~regout\ = DFFEAS((!\i2c_master_0|Equal0~2_combout\ & ((\i2c_master_0|Add0~5_combout\) # ((\i2c_master_0|process_0~5_combout\ & !\i2c_master_0|LessThan1~1_combout\)))), GLOBAL(\clock~combout\), VCC, , \DATA4~combout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "2232",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clock~combout\,
	dataa => \i2c_master_0|Add0~5_combout\,
	datab => \i2c_master_0|Equal0~2_combout\,
	datac => \i2c_master_0|process_0~5_combout\,
	datad => \i2c_master_0|LessThan1~1_combout\,
	aclr => GND,
	ena => \DATA4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i2c_master_0|scl_clk~regout\);

-- Location: LC_X12_Y2_N0
\i2c_master_0|scl~1\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|scl~1_combout\ = (((\i2c_master_0|scl_clk~regout\)) # (!\i2c_master_0|scl_ena~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f3f3",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \i2c_master_0|scl_ena~regout\,
	datac => \i2c_master_0|scl_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|scl~1_combout\);

-- Location: LC_X12_Y2_N5
\i2c_master_0|Selector29~0\ : maxii_lcell
-- Equation(s):
-- \i2c_master_0|Selector29~0_combout\ = (\i2c_master_0|state.start~regout\ & (((\i2c_master_0|data_clk_prev~regout\)))) # (!\i2c_master_0|state.start~regout\ & ((\i2c_master_0|state.stop~regout\ & ((!\i2c_master_0|data_clk_prev~regout\))) # 
-- (!\i2c_master_0|state.stop~regout\ & (!\i2c_master_0|sda_int~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ab51",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \i2c_master_0|state.start~regout\,
	datab => \i2c_master_0|sda_int~regout\,
	datac => \i2c_master_0|state.stop~regout\,
	datad => \i2c_master_0|data_clk_prev~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \i2c_master_0|Selector29~0_combout\);

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
	datain => \i2c_master_0|ALT_INV_data_rd\(0),
	oe => VCC,
	padio => ww_PWM1);

-- Location: PIN_19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM2~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \i2c_master_0|ALT_INV_data_rd\(1),
	oe => VCC,
	padio => ww_PWM2);

-- Location: PIN_20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM3~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \i2c_master_0|ALT_INV_data_rd\(2),
	oe => VCC,
	padio => ww_PWM3);

-- Location: PIN_21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM4~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \i2c_master_0|ALT_INV_data_rd\(3),
	oe => VCC,
	padio => ww_PWM4);

-- Location: PIN_26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM5~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \i2c_master_0|ALT_INV_data_rd\(4),
	oe => VCC,
	padio => ww_PWM5);

-- Location: PIN_27,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM6~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \i2c_master_0|ALT_INV_data_rd\(5),
	oe => VCC,
	padio => ww_PWM6);

-- Location: PIN_28,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM7~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \i2c_master_0|ALT_INV_data_rd\(6),
	oe => VCC,
	padio => ww_PWM7);

-- Location: PIN_29,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM8~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \i2c_master_0|ALT_INV_data_rd\(7),
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
	datain => \i2c_master_0|ALT_INV_ack_error~regout\,
	oe => VCC,
	padio => ww_PWM13);

-- Location: PIN_38,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\PWM14~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \i2c_master_0|busy~regout\,
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

-- Location: PIN_56,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\DATA5~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_DATA5);

-- Location: PIN_57,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\DATA6~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_DATA6);

-- Location: PIN_58,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\DATA7~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_DATA7);

-- Location: PIN_61,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\DATA8~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	oe => VCC,
	padio => ww_DATA8);
END structure;


