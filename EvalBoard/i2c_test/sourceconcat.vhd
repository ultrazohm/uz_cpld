library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sourceConcat is
	port(
	       y0 : out std_logic_vector(7 downto 0));

end sourceConcat;

architecture arch_sourceConcat of sourceConcat is
		--signal temp_data : std_logic_vector(7 downto 0) := "10101010";
begin
		y0 <= "10101010";

end arch_sourceConcat;

