library ieee;
use ieee.std_logic_1164.all;
library s3c;

entity heartbeat_tb is
    generic (SAFE_LEVEL : std_logic := '1'; PILOT_REQUIRED : boolean := true);
end entity;
architecture test of heartbeat_tb is
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal request : std_logic := SAFE_LEVEL;
    signal hb : std_logic := '0';
    signal pilot, enable : std_logic := '1';
    signal normal, safe, slotok, reqoe : std_logic;
begin
    dut: entity s3c.s3c_logic(heartbeat)
        generic map (REQUEST_SAFE_LEVEL => SAFE_LEVEL, REQUIRE_PILOT => PILOT_REQUIRED,
                     SLOTOK_NORMAL => '0', SLOTOK_SAFE => '1', REQOE_NORMAL => '1', REQOE_SAFE => '0')
        port map (clk => clk, reset => reset, reqsafestate => request, carrierrdy => hb,
                  pilot_in => pilot, card_enable => enable,
                  state_normal => normal, state_safe => safe, slotok => slotok, reqoe => reqoe);
    process
        procedure cycles(n : positive) is
        begin
            for i in 1 to n loop
                clk <= '0'; wait for 5 ns; clk <= '1'; wait for 5 ns;
            end loop;
        end procedure;
        procedure expect(value : boolean) is
        begin
            if value then
                assert normal = '1' and safe = '0' and slotok = '0' and reqoe = '1'
                    report "expected normal state" severity failure;
            else
                assert normal = '0' and safe = '1' and slotok = '1' and reqoe = '0'
                    report "expected safe state" severity failure;
            end if;
        end procedure;
        procedure restart is
        begin
            reset <= '1'; hb <= '0'; request <= not SAFE_LEVEL;
            pilot <= '1'; enable <= '1'; cycles(1);
            reset <= '0'; cycles(4); expect(false);
        end procedure;
        -- Each call finishes on the third sample of the new raw level:
        -- the receiver sees this edge now, exactly gap clocks after the last one.
        procedure edge_after(gap : positive := 21) is
        begin
            cycles(gap-3); hb <= not hb; cycles(3);
        end procedure;
        procedure qualify(gap : positive := 21) is
        begin
            for i in 1 to 16 loop edge_after(gap); end loop;
            expect(true);
        end procedure;
    begin
        restart;
        cycles(210); expect(false); -- stuck low
        hb <= '1'; cycles(210); expect(false); -- stuck high, single edge
        restart;
        for i in 1 to 15 loop edge_after; expect(false); end loop;
        edge_after; expect(true);

        -- A live heartbeat is not permission to ignore a static safety request.
        request <= SAFE_LEVEL; wait for 1 ns; expect(false);
        for i in 1 to 20 loop edge_after; expect(false); end loop;
        request <= not SAFE_LEVEL; wait for 1 ns; expect(false);
        cycles(1); expect(false); cycles(1); expect(true);
        request <= 'X'; wait for 1 ns; expect(false);
        request <= not SAFE_LEVEL; cycles(1); expect(false); cycles(1); expect(true);
        request <= 'Z'; wait for 1 ns; expect(false);
        request <= not SAFE_LEVEL; cycles(1); expect(false); cycles(1); expect(true);
        enable <= '0'; cycles(1); expect(true); cycles(1); expect(false);
        enable <= 'X'; cycles(3); expect(false);
        enable <= '1'; cycles(1); expect(false); cycles(1); expect(true);
        pilot <= '0'; cycles(1); expect(true); cycles(1); expect(not PILOT_REQUIRED);
        pilot <= 'X'; cycles(3); expect(not PILOT_REQUIRED);
        pilot <= '1'; cycles(1); expect(not PILOT_REQUIRED); cycles(1); expect(true);

        -- With no clock, assertion must still force every state/status output
        -- safe, and deassertion must not reopen the gate. Qualification is kept.
        restart; qualify;
        request <= SAFE_LEVEL; wait for 2 us; expect(false);
        request <= not SAFE_LEVEL; wait for 2 us; expect(false);
        cycles(1); expect(false); cycles(1); expect(true);
        -- Even a request entirely between edges must restart both release stages.
        request <= SAFE_LEVEL; wait for 1 ns; expect(false);
        request <= not SAFE_LEVEL; cycles(1); expect(false);
        request <= SAFE_LEVEL; wait for 1 ns; expect(false);
        request <= not SAFE_LEVEL; cycles(1); expect(false); cycles(1); expect(true);

        -- The monitor can acquire qualification while the request is asserted.
        restart; request <= SAFE_LEVEL;
        for i in 1 to 16 loop edge_after; expect(false); end loop;
        request <= not SAFE_LEVEL; cycles(1); expect(false); cycles(1); expect(true);

        -- It also expires qualification while the request is asserted.
        request <= SAFE_LEVEL; cycles(208); expect(false);
        request <= not SAFE_LEVEL; cycles(2); expect(false);
        for i in 1 to 15 loop edge_after; expect(false); end loop;
        edge_after; expect(true);
        -- A malformed train during a request cannot be hidden by the safety gate.
        request <= SAFE_LEVEL; edge_after(9); expect(false);
        request <= not SAFE_LEVEL; cycles(2); expect(false);
        qualify;

        restart; qualify;
        cycles(207); expect(true);
        cycles(1); expect(false); -- timeout on exactly clock 208 after observed edge
        qualify; -- recovery needs a new qualified train
        edge_after(9); expect(false); -- too fast revokes validity immediately
        for i in 1 to 14 loop edge_after; expect(false); end loop;
        edge_after; expect(true);
        edge_after(53); expect(false); -- too slow, but before timeout
        qualify;

        -- Both interval boundaries are inclusive.
        restart; qualify(10); qualify(52);
        for i in 1 to 20 loop edge_after(9); expect(false); end loop;
        for i in 1 to 20 loop edge_after(53); expect(false); end loop;

        -- Malformed final edge must not qualify using the previous counter value.
        restart;
        for i in 1 to 15 loop edge_after; expect(false); end loop;
        edge_after(9); expect(false);
        for i in 1 to 14 loop edge_after; expect(false); end loop;
        edge_after; expect(true);

        hb <= 'X'; cycles(3); expect(false);
        hb <= '0'; cycles(3); expect(false);
        qualify;
        reset <= '1'; wait for 1 ns; expect(false); -- immediate output masking
        cycles(1); reset <= '0'; cycles(4); expect(false);
        qualify;
        report "HEARTBEAT PASSED";
        wait;
    end process;
end architecture;
