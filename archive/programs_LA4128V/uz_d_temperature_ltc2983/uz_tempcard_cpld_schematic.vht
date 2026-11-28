-- VHDL test bench created from symbol uz_tempcard_cpld_schematic.sym -- May 20 11:38:07 2021

LIBRARY vanmacro;
USE vanmacro.components.ALL;
LIBRARY ieee;
LIBRARY generics;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE generics.components.ALL;

entity testbench is
end testbench;

Architecture behavior of testbench is

   signal      I_0 : std_logic;
   signal      I_1 : std_logic;
   signal      I_2 : std_logic;
   signal      I_3 : std_logic;
   signal      I_4 : std_logic;
   signal      I_5 : std_logic;
   signal      I_6 : std_logic;
   signal      I_7 : std_logic;
   signal      I_8 : std_logic;
   signal      I_9 : std_logic;
   signal     I_10 : std_logic;
   signal     I_11 : std_logic;
   signal     I_12 : std_logic;
   signal     I_13 : std_logic;
   signal     I_14 : std_logic;
   signal     I_15 : std_logic;
   signal     I_16 : std_logic;
   signal     I_17 : std_logic;
   signal     I_18 : std_logic;
   signal     I_19 : std_logic;
   signal     I_20 : std_logic;
   signal     I_21 : std_logic;
   signal     I_22 : std_logic;
   signal     I_23 : std_logic;
   signal     I_24 : std_logic;
   signal     I_25 : std_logic;
   signal     I_26 : std_logic;
   signal     I_27 : std_logic;
   signal     I_28 : std_logic;
   signal     I_29 : std_logic;
   signal      O_0 : std_logic;
   signal      O_1 : std_logic;
   signal      O_2 : std_logic;
   signal      O_3 : std_logic;
   signal      O_4 : std_logic;
   signal      O_5 : std_logic;
   signal      O_6 : std_logic;
   signal      O_7 : std_logic;
   signal      O_8 : std_logic;
   signal      O_9 : std_logic;
   signal     O_10 : std_logic;
   signal     O_11 : std_logic;
   signal     O_12 : std_logic;
   signal     O_13 : std_logic;
   signal     O_14 : std_logic;
   signal     O_15 : std_logic;
   signal     O_16 : std_logic;
   signal     O_17 : std_logic;
   signal     O_18 : std_logic;
   signal     O_19 : std_logic;
   signal     O_20 : std_logic;
   signal     O_21 : std_logic;
   signal     O_22 : std_logic;
   signal     O_23 : std_logic;
   signal     O_24 : std_logic;
   signal     O_25 : std_logic;
   signal     O_26 : std_logic;
   signal     O_27 : std_logic;
   signal     O_28 : std_logic;
   signal     O_29 : std_logic;

   component UZ_TEMPCARD_CPLD_SCHEMATIC
      Port (     I_0 : In    std_logic;
                 I_1 : In    std_logic;
                 I_2 : In    std_logic;
                 I_3 : In    std_logic;
                 I_4 : In    std_logic;
                 I_5 : In    std_logic;
                 I_6 : In    std_logic;
                 I_7 : In    std_logic;
                 I_8 : In    std_logic;
                 I_9 : In    std_logic;
                I_10 : In    std_logic;
                I_11 : In    std_logic;
                I_12 : In    std_logic;
                I_13 : In    std_logic;
                I_14 : In    std_logic;
                I_15 : In    std_logic;
                I_16 : In    std_logic;
                I_17 : In    std_logic;
                I_18 : In    std_logic;
                I_19 : In    std_logic;
                I_20 : In    std_logic;
                I_21 : In    std_logic;
                I_22 : In    std_logic;
                I_23 : In    std_logic;
                I_24 : In    std_logic;
                I_25 : In    std_logic;
                I_26 : In    std_logic;
                I_27 : In    std_logic;
                I_28 : In    std_logic;
                I_29 : In    std_logic;
                 O_0 : Out   std_logic;
                 O_1 : Out   std_logic;
                 O_2 : Out   std_logic;
                 O_3 : Out   std_logic;
                 O_4 : Out   std_logic;
                 O_5 : Out   std_logic;
                 O_6 : Out   std_logic;
                 O_7 : Out   std_logic;
                 O_8 : Out   std_logic;
                 O_9 : Out   std_logic;
                O_10 : Out   std_logic;
                O_11 : Out   std_logic;
                O_12 : Out   std_logic;
                O_13 : Out   std_logic;
                O_14 : Out   std_logic;
                O_15 : Out   std_logic;
                O_16 : Out   std_logic;
                O_17 : Out   std_logic;
                O_18 : Out   std_logic;
                O_19 : Out   std_logic;
                O_20 : Out   std_logic;
                O_21 : Out   std_logic;
                O_22 : Out   std_logic;
                O_23 : Out   std_logic;
                O_24 : Out   std_logic;
                O_25 : Out   std_logic;
                O_26 : Out   std_logic;
                O_27 : Out   std_logic;
                O_28 : Out   std_logic;
                O_29 : Out   std_logic );
   end component;

begin
   UUT : UZ_TEMPCARD_CPLD_SCHEMATIC
      Port Map ( I_0=>I_0, I_1=>I_1, I_10=>I_10, I_11=>I_11, I_12=>I_12,
                 I_13=>I_13, I_14=>I_14, I_15=>I_15, I_16=>I_16,
                 I_17=>I_17, I_18=>I_18, I_19=>I_19, I_2=>I_2,
                 I_20=>I_20, I_21=>I_21, I_22=>I_22, I_23=>I_23,
                 I_24=>I_24, I_25=>I_25, I_26=>I_26, I_27=>I_27,
                 I_28=>I_28, I_29=>I_29, I_3=>I_3, I_4=>I_4, I_5=>I_5,
                 I_6=>I_6, I_7=>I_7, I_8=>I_8, I_9=>I_9, O_0=>O_0,
                 O_1=>O_1, O_10=>O_10, O_11=>O_11, O_12=>O_12,
                 O_13=>O_13, O_14=>O_14, O_15=>O_15, O_16=>O_16,
                 O_17=>O_17, O_18=>O_18, O_19=>O_19, O_2=>O_2,
                 O_20=>O_20, O_21=>O_21, O_22=>O_22, O_23=>O_23,
                 O_24=>O_24, O_25=>O_25, O_26=>O_26, O_27=>O_27,
                 O_28=>O_28, O_29=>O_29, O_3=>O_3, O_4=>O_4, O_5=>O_5,
                 O_6=>O_6, O_7=>O_7, O_8=>O_8, O_9=>O_9 );

-- *** Test Bench - User Defined Section ***
   TB : process
   begin
      wait; -- will wait forever
   end process;
-- *** End Test Bench - User Defined Section ***

end behavior;

