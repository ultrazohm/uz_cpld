library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity slicer862 is
	port(data : in std_logic_vector(7 downto 0);
	       y0 : out std_logic_vector(5 downto 0);
	       y6 : out std_logic;
	       y7 : out std_logic);
end;

architecture behavioral of slicer862 is
begin
		y0 <= data(5) & data(4) & data(3) & data(2) & data(1) & data(0);
		y6 <= data(6);
		y7 <= data(7);

end behavioral;

