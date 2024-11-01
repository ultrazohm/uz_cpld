library IEEE;
library machxo2;
use IEEE.STD_LOGIC_1164.ALL;

entity SignalRouter is
    Port (
        -- Define 30 fpga ports
        fpga_00 : in STD_LOGIC;
        fpga_01 : in STD_LOGIC;
        fpga_02 : in STD_LOGIC;
        fpga_03 : in STD_LOGIC;
        fpga_04 : in STD_LOGIC;
        fpga_05 : in STD_LOGIC;
        fpga_06 : in STD_LOGIC;
        fpga_07 : in STD_LOGIC;
        fpga_08 : in STD_LOGIC;
        fpga_09 : in STD_LOGIC;
        fpga_10 : in STD_LOGIC;
        fpga_11 : in STD_LOGIC;
        fpga_12 : in STD_LOGIC;
        fpga_13 : in STD_LOGIC;
		
        fpga_14 : out STD_LOGIC;
        fpga_15 : out STD_LOGIC;
        fpga_16 : out STD_LOGIC;
        fpga_17 : out STD_LOGIC;
		
        fpga_18 : in STD_LOGIC;
        fpga_19 : in STD_LOGIC;
        fpga_20 : in STD_LOGIC;
        fpga_21 : in STD_LOGIC;
        fpga_22 : in STD_LOGIC;
        fpga_23 : in STD_LOGIC;
        fpga_24 : in STD_LOGIC;
        fpga_25 : in STD_LOGIC;
        fpga_26 : in STD_LOGIC;
        fpga_27 : in STD_LOGIC;
        fpga_28 : in STD_LOGIC;
        fpga_29 : in STD_LOGIC;

        -- Define 30 d-slot ports
        d_00 : out STD_LOGIC;
        d_01 : out STD_LOGIC;
        d_02 : out STD_LOGIC;
        d_03 : out STD_LOGIC;
        d_04 : out STD_LOGIC;
        d_05 : out STD_LOGIC;
        d_06 : out STD_LOGIC;
        d_07 : out STD_LOGIC;
        d_08 : out STD_LOGIC;
        d_09 : out STD_LOGIC;
        d_10 : out STD_LOGIC;
        d_11 : out STD_LOGIC;
        d_12 : out STD_LOGIC;
        d_13 : out STD_LOGIC;
		
        d_14 : in STD_LOGIC;
        d_15 : in STD_LOGIC;
        d_16 : in STD_LOGIC;
        d_17 : in STD_LOGIC;
		
        d_18 : out STD_LOGIC;
        d_19 : out STD_LOGIC;
        d_20 : out STD_LOGIC;
        d_21 : out STD_LOGIC;
        d_22 : out STD_LOGIC;
        d_23 : out STD_LOGIC;
        d_24 : out STD_LOGIC;
        d_25 : out STD_LOGIC;
        d_26 : out STD_LOGIC;
        d_27 : out STD_LOGIC;
        d_28 : out STD_LOGIC;
        d_29 : out STD_LOGIC
    );
end SignalRouter;

architecture Behavioral of SignalRouter is
begin
    -- Map ports
    d_00 <= fpga_00;
    d_01 <= fpga_01;
    d_02 <= fpga_02;
    d_03 <= fpga_03;
    d_04 <= fpga_04;
    d_05 <= fpga_05;
    d_06 <= fpga_06;
    d_07 <= fpga_07;
    d_08 <= fpga_08;
    d_09 <= fpga_09;
    d_10 <= fpga_10;
    d_11 <= fpga_11;
    d_12 <= fpga_12;
    d_13 <= fpga_13;
	
    fpga_14 <= d_14;
    fpga_15 <= d_15;
    fpga_16 <= d_16;
    fpga_17 <= d_17;
	
    d_18 <= fpga_18;
    d_19 <= fpga_19;
    d_20 <= fpga_20;
    d_21 <= fpga_21;
    d_22 <= fpga_22;
    d_23 <= fpga_23;
    d_24 <= fpga_24;
    d_25 <= fpga_25;
    d_26 <= fpga_26;
    d_27 <= fpga_27;
    d_28 <= fpga_28;
    d_29 <= fpga_29;
end Behavioral;