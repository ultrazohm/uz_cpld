library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity bi_d_mux is
port ( in1 : in std_logic_vector(3 downto 0);
       in2 : in std_logic_vector(3 downto 0);
       out1 : out std_logic_vector(3 downto 0);
       out2 : out std_logic_vector(3 downto 0);
       S   : in std_logic_vector(1 downto 0);
       IO  : inout std_logic_vector(3 downto 0)
);
end bi_d_mux;

architecture simple of bi_d_mux is
begin
  process(S, IO, in1, in2)
  begin
  IO <= (others => 'Z');
  out1 <= (others => '0');
  out2 <= (others => '0');
    case S is
    when "00" => IO <= in1;
    when "01" => IO <= in2;
    when "10" => out1 <= IO;
    when "11" => out2 <= IO;
    when others => null;
    end case;
end process;
end simple;
