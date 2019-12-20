-- VHDL test bench created from symbol top_level.sym -- Nov 05 11:13:38 2019

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

   signal enable_in : std_logic;
   signal       in : std_logic_vector (28 downto 0);
   signal      out : std_logic_vector (28 downto 0);

   component TOP_LEVEL
      Port ( enable_in : In    std_logic;
                  in : In    std_logic_vector (28 downto 0);
                 out : Out   std_logic_vector (28 downto 0) );
   end component;

begin
   UUT : TOP_LEVEL
      Port Map ( enable_in=>enable_in, in=>in, out=>out );

-- *** Test Bench - User Defined Section ***
   TB : process
   begin
      wait; -- will wait forever
   end process;
-- *** End Test Bench - User Defined Section ***

end behavior;

