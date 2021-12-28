-- VHDL test bench created from symbol io_pins.sym -- Dec 27 14:54:13 2021

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

   signal     FPGA : std_logic;
   signal  Adapter : std_logic;
   signal IOselector : std_logic;
   signal       y7 : std_logic;
   signal       y6 : std_logic;
   signal       y5 : std_logic;
   signal       y4 : std_logic;
   signal       y3 : std_logic;
   signal       y2 : std_logic;
   signal       y1 : std_logic;
   signal       y0 : std_logic;

   component IO_PINS
      Port (    FPGA : InOut std_logic;
             Adapter : InOut std_logic;
             IOselector : In    std_logic;
                  y7 : Out   std_logic;
                  y6 : Out   std_logic;
                  y5 : Out   std_logic;
                  y4 : Out   std_logic;
                  y3 : Out   std_logic;
                  y2 : Out   std_logic;
                  y1 : Out   std_logic;
                  y0 : Out   std_logic );
   end component;

begin
   UUT : IO_PINS
      Port Map ( Adapter=>Adapter, FPGA=>FPGA, IOselector=>IOselector,
                 y0=>y0, y1=>y1, y2=>y2, y3=>y3, y4=>y4, y5=>y5, y6=>y6,
                 y7=>y7 );

-- *** Test Bench - User Defined Section ***
   TB : process
   begin
      wait; -- will wait forever
   end process;
-- *** End Test Bench - User Defined Section ***

end behavior;

