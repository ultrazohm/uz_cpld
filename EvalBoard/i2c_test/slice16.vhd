library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity slice16 is
	port(data : in std_logic_vector(15 downto 0);
	       y0 : out std_logic;
	       y1 : out std_logic;
	       y2 : out std_logic;
	       y3 : out std_logic;
	       y4 : out std_logic;
	       y5 : out std_logic;
	       y6 : out std_logic;
	       y7 : out std_logic;
	       y8 : out std_logic;
	       y9 : out std_logic;
	       y10 : out std_logic;
	       y11 : out std_logic;
	       y12 : out std_logic;
	       y13 : out std_logic;
	       y14 : out std_logic;
	       y15 : out std_logic);
end slice16;

architecture arch_slice16 of slice16 is
	
begin
		y0 <= data(0);
		y1 <= data(1);
		y2 <= data(2);
		y3 <= data(3);
		y4 <= data(4);
		y5 <= data(5);
		y6 <= data(6);
		y7 <= data(7);
		y8 <= data(8);
		y9 <= data(9);
		y10 <= data(10);
		y11 <= data(11);
		y12 <= data(12);
		y13 <= data(13);
		y14 <= data(14);
		y15 <= data(15);

end arch_slice16;


