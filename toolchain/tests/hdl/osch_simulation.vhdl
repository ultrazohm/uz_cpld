library ieee;
use ieee.std_logic_1164.all;
entity OSCH is
    generic (NOM_FREQ : string := "2.08");
    port (STDBY : in std_logic; OSC, SEDSTDBY : out std_logic);
end entity;
architecture simulation of OSCH is
begin
    process begin
        OSC <= '0'; wait for 5 ns; OSC <= '1'; wait for 5 ns;
    end process;
    SEDSTDBY <= '0';
end architecture;
