library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity output_en is
	port(output_in : in 	std_logic;
	     output_out: out 	std_logic;
             input_in  : in 	std_logic;
	     input_out : out 	std_logic;
	     en        : in	std_logic);
end;

architecture behavioral of output_en is

begin

process(en) begin
if en = '1' then
	output_out <= output_in;
	input_out <= input_in;
else
	output_out <= '0';
	input_out <= '0';
end if;
	
end process;


end behavioral;

