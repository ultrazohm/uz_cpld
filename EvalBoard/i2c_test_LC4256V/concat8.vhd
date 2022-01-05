library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity concat8 is
	port(	u0 : in std_logic;
		u1 : in std_logic;
		u2 : in std_logic;
		u3 : in std_logic;
		u4 : in std_logic;
		u5 : in std_logic;
		u6 : in std_logic;
		u7 : in std_logic;
		 y : out std_logic_vector(7 downto 0));
end concat8;

architecture arch_concat8 of concat8 is
begin

	y <= u7 & u6 & u5 & u4 & u3 & u2 & u1 & u0;

end arch_concat8;



