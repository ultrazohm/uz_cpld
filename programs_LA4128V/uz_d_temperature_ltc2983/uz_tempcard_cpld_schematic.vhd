-- VHDL model created from schematic uz_tempcard_cpld_schematic.sch -- May 20 11:38:08 2021

LIBRARY ieee;
LIBRARY generics;
LIBRARY lat_vhd;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE generics.components.ALL;
USE lat_vhd.components.ALL;

entity UZ_TEMPCARD_CPLD_SCHEMATIC is
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
end UZ_TEMPCARD_CPLD_SCHEMATIC;

architecture SCHEMATIC of UZ_TEMPCARD_CPLD_SCHEMATIC is

   SIGNAL gnd : std_logic := '0';
   SIGNAL vcc : std_logic := '1';

   signal        D : std_logic_vector (29 downto 0);

begin

   I1 : G_OUTPUT
      Port Map ( I=>D(28), O=>O_28 );
   I2 : G_OUTPUT
      Port Map ( I=>D(29), O=>O_29 );
   I3 : G_OUTPUT
      Port Map ( I=>D(27), O=>O_27 );
   I4 : G_OUTPUT
      Port Map ( I=>D(26), O=>O_26 );
   I5 : G_OUTPUT
      Port Map ( I=>D(25), O=>O_25 );
   I6 : G_OUTPUT
      Port Map ( I=>D(24), O=>O_24 );
   I7 : G_OUTPUT
      Port Map ( I=>D(23), O=>O_23 );
   I8 : G_OUTPUT
      Port Map ( I=>D(22), O=>O_22 );
   I9 : G_OUTPUT
      Port Map ( I=>D(21), O=>O_21 );
   I10 : G_OUTPUT
      Port Map ( I=>D(20), O=>O_20 );
   I11 : G_OUTPUT
      Port Map ( I=>D(19), O=>O_19 );
   I12 : G_OUTPUT
      Port Map ( I=>D(18), O=>O_18 );
   I13 : G_OUTPUT
      Port Map ( I=>D(17), O=>O_17 );
   I14 : G_OUTPUT
      Port Map ( I=>D(16), O=>O_16 );
   I15 : G_OUTPUT
      Port Map ( I=>D(15), O=>O_15 );
   I16 : G_OUTPUT
      Port Map ( I=>D(13), O=>O_13 );
   I17 : G_OUTPUT
      Port Map ( I=>D(14), O=>O_14 );
   I18 : G_OUTPUT
      Port Map ( I=>D(12), O=>O_12 );
   I19 : G_OUTPUT
      Port Map ( I=>D(11), O=>O_11 );
   I20 : G_OUTPUT
      Port Map ( I=>D(10), O=>O_10 );
   I21 : G_OUTPUT
      Port Map ( I=>D(9), O=>O_9 );
   I22 : G_OUTPUT
      Port Map ( I=>D(8), O=>O_8 );
   I23 : G_OUTPUT
      Port Map ( I=>D(7), O=>O_7 );
   I24 : G_OUTPUT
      Port Map ( I=>D(6), O=>O_6 );
   I25 : G_OUTPUT
      Port Map ( I=>D(5), O=>O_5 );
   I26 : G_OUTPUT
      Port Map ( I=>D(4), O=>O_4 );
   I27 : G_OUTPUT
      Port Map ( I=>D(3), O=>O_3 );
   I28 : G_OUTPUT
      Port Map ( I=>D(2), O=>O_2 );
   I29 : G_OUTPUT
      Port Map ( I=>D(1), O=>O_1 );
   I30 : G_OUTPUT
      Port Map ( I=>D(0), O=>O_0 );
   I31 : G_INPUT
      Port Map ( I=>I_0, O=>D(0) );
   I32 : G_INPUT
      Port Map ( I=>I_29, O=>D(29) );
   I33 : G_INPUT
      Port Map ( I=>I_28, O=>D(28) );
   I34 : G_INPUT
      Port Map ( I=>I_27, O=>D(27) );
   I35 : G_INPUT
      Port Map ( I=>I_26, O=>D(26) );
   I36 : G_INPUT
      Port Map ( I=>I_25, O=>D(25) );
   I37 : G_INPUT
      Port Map ( I=>I_24, O=>D(24) );
   I38 : G_INPUT
      Port Map ( I=>I_23, O=>D(23) );
   I39 : G_INPUT
      Port Map ( I=>I_22, O=>D(22) );
   I40 : G_INPUT
      Port Map ( I=>I_21, O=>D(21) );
   I41 : G_INPUT
      Port Map ( I=>I_20, O=>D(20) );
   I42 : G_INPUT
      Port Map ( I=>I_19, O=>D(19) );
   I43 : G_INPUT
      Port Map ( I=>I_18, O=>D(18) );
   I44 : G_INPUT
      Port Map ( I=>I_17, O=>D(17) );
   I45 : G_INPUT
      Port Map ( I=>I_16, O=>D(16) );
   I46 : G_INPUT
      Port Map ( I=>I_15, O=>D(15) );
   I47 : G_INPUT
      Port Map ( I=>I_14, O=>D(14) );
   I48 : G_INPUT
      Port Map ( I=>I_13, O=>D(13) );
   I49 : G_INPUT
      Port Map ( I=>I_12, O=>D(12) );
   I50 : G_INPUT
      Port Map ( I=>I_11, O=>D(11) );
   I51 : G_INPUT
      Port Map ( I=>I_10, O=>D(10) );
   I52 : G_INPUT
      Port Map ( I=>I_7, O=>D(7) );
   I53 : G_INPUT
      Port Map ( I=>I_6, O=>D(6) );
   I54 : G_INPUT
      Port Map ( I=>I_8, O=>D(8) );
   I55 : G_INPUT
      Port Map ( I=>I_2, O=>D(2) );
   I56 : G_INPUT
      Port Map ( I=>I_9, O=>D(9) );
   I57 : G_INPUT
      Port Map ( I=>I_5, O=>D(5) );
   I58 : G_INPUT
      Port Map ( I=>I_4, O=>D(4) );
   I59 : G_INPUT
      Port Map ( I=>I_3, O=>D(3) );
   I60 : G_INPUT
      Port Map ( I=>I_1, O=>D(1) );

end SCHEMATIC;
