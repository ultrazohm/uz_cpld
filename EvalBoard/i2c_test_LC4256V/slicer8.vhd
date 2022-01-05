library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity slice8 is
	port(data : in std_logic_vector(7 downto 0);
	       y0 : out std_logic;
	       y1 : out std_logic;
	       y2 : out std_logic;
	       y3 : out std_logic;
	       y4 : out std_logic;
	       y5 : out std_logic;
	       y6 : out std_logic;
	       y7 : out std_logic);
end slice8;

architecture arch_slice8 of slice8 is
	
begin
		y0 <= data(0);
		y1 <= data(1);
		y2 <= data(2);
		y3 <= data(3);
		y4 <= data(4);
		y5 <= data(5);
		y6 <= data(6);
		y7 <= data(7);

end arch_slice8;


