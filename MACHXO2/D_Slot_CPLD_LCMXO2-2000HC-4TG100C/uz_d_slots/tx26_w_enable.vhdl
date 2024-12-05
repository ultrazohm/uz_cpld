library IEEE;
library machxo2;
use IEEE.STD_LOGIC_1164.ALL;

entity SignalRouter is
    Port (
	    -- Define 2 i2c ports
        i2c_scl : in STD_LOGIC;
        i2c_sda : in STD_LOGIC;
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
        fpga_14 : in STD_LOGIC;
        fpga_15 : in STD_LOGIC;
        fpga_16 : in STD_LOGIC;
        fpga_17 : in STD_LOGIC;
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
        d_14 : out STD_LOGIC;
        d_15 : out STD_LOGIC;
        d_16 : out STD_LOGIC;
        d_17 : out STD_LOGIC;
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
	
	SIGNAL enable : std_logic;
	
end SignalRouter;



architecture Behavioral of SignalRouter is
begin

    -- Define the enable signal logic
    enable <= '1' when (fpga_26 = '0' and fpga_27 = '0' and i2c_scl = '0' and i2c_sda = '0' and  fpga_28 = '1' and fpga_29 = '1') else '0';


    -- Map ports
    d_00 <= fpga_00 and enable;
    d_01 <= fpga_01 and enable;
    d_02 <= fpga_02 and enable;
    d_03 <= fpga_03 and enable;
    d_04 <= fpga_04 and enable;
    d_05 <= fpga_05 and enable;
    d_06 <= fpga_06 and enable;
    d_07 <= fpga_07 and enable;
    d_08 <= fpga_08 and enable;
    d_09 <= fpga_09 and enable;
    d_10 <= fpga_10 and enable;
    d_11 <= fpga_11 and enable;
    d_12 <= fpga_12 and enable;
    d_13 <= fpga_13 and enable;
    d_14 <= fpga_14 and enable;
    d_15 <= fpga_15 and enable;
    d_16 <= fpga_16 and enable;
    d_17 <= fpga_17 and enable;
    d_18 <= fpga_18 and enable;
    d_19 <= fpga_19 and enable;
    d_20 <= fpga_20 and enable;
    d_21 <= fpga_21 and enable;
    d_22 <= fpga_22 and enable;
    d_23 <= fpga_23 and enable;
    d_24 <= fpga_24 and enable;
    d_25 <= fpga_25 and enable;

end Behavioral;