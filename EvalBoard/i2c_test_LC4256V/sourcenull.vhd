library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sourceNull is
port(	y1 : out std_logic;
	y2 : out std_logic;
	y3 : out std_logic;
	y4 : out std_logic;
	y5 : out std_logic);

end;

architecture behavioral of sourceNull is
begin

	y1 <= '0';
	y2 <= '0';
	y3 <= '0';
	y4 <= '0';
	y5 <= '0';

end behavioral;

