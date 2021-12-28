library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity source is
	port(  y0 : out std_logic;
	       y1 : out std_logic;
	       y2 : out std_logic;
	       y3 : out std_logic;
	       y4 : out std_logic;
	       y5 : out std_logic;
	       y6 : out std_logic;
	       y7 : out std_logic);
end entity;

architecture rtl of source is
	signal temp_y : std_logic_vector(7 downto 0) :="00111100";
begin
		y0 <= temp_y(0);
		y1 <= temp_y(1);
		y2 <= temp_y(2);
		y3 <= temp_y(3);
		y4 <= temp_y(4);
		y5 <= temp_y(5);
		y6 <= temp_y(6);
		y7 <= temp_y(7);

end architecture;

