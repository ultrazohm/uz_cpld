library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tick_counter_v2 is
    generic (
        COUNTER_LIMIT : integer := 1000   -- Anzahl Ticks (z.B. 1000 = 1000 ms)
    );
    port (
        clk     : in  std_logic;
        tick_in : in  std_logic;    -- z.B. 1 ms Tick
        start   : in  std_logic;    -- Neustart des Counters
        ready   : out std_logic     -- bleibt '1', bis neuer Start kommt
    );
end entity;

architecture rtl of tick_counter_v2 is
    signal cnt   : integer range 0 to COUNTER_LIMIT := 0;
    signal ready_i : std_logic := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if start = '1' then
                cnt     <= 0;
                ready_i <= '0';
            elsif tick_in = '1' and ready_i = '0' then
                if cnt = COUNTER_LIMIT then
                    ready_i <= '1';
                else
                    cnt <= cnt + 1;
                end if;
            end if;
        end if;
    end process;

    ready <= ready_i;
end architecture;