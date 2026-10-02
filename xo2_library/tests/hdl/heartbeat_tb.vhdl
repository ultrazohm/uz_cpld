library ieee;
use ieee.std_logic_1164.all;
library s3c;

entity heartbeat_tb is
    generic (SAFE_LEVEL : std_logic := '1'; PILOT_REQUIRED : boolean := true;
             FAULT_KIND : string := "timeout");
end entity;
architecture test of heartbeat_tb is
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal request : std_logic := SAFE_LEVEL;
    signal hb : std_logic := '0';
    signal pilot, enable : std_logic := '1';
    signal normal, safe, system_error, slotok, reqoe : std_logic;
begin
    dut: entity s3c.s3c_logic(heartbeat)
        generic map (REQUEST_SAFE_LEVEL => SAFE_LEVEL, REQUIRE_PILOT => PILOT_REQUIRED,
                     SLOTOK_NORMAL => '0', SLOTOK_SAFE => '1', REQOE_NORMAL => '1', REQOE_SAFE => '1')
        port map (clk => clk, reset => reset, reqsafestate => request, carrierrdy => hb,
                  pilot_in => pilot, card_enable => enable,
                  state_normal => normal, state_safe => safe, state_system_error => system_error,
                  slotok => slotok, reqoe => reqoe);
    process
        procedure cycles(n : positive) is
        begin
            for i in 1 to n loop
                clk <= '0'; wait for 5 ns; clk <= '1'; wait for 5 ns;
            end loop;
        end procedure;
        procedure expect(value : boolean; fault : boolean := false) is
        begin
            if fault then
                assert system_error = '1' and normal = '0' and safe = '0' and slotok = '0' and reqoe = '0'
                    report "expected system_error with both status outputs low" severity failure;
            elsif value then
                assert system_error = '0' and normal = '1' and safe = '0' and slotok = '0' and reqoe = '1'
                    report "expected normal state" severity failure;
            else
                assert system_error = '0' and normal = '0' and safe = '1' and slotok = '1' and reqoe = '1'
                    report "expected safe state without system_error" severity failure;
            end if;
        end procedure;
        -- Each call finishes when the receiver observes the new edge.
        -- Call immediately after an observed edge for an exact interval.
        procedure edge_after(gap : positive := 21) is
        begin
            cycles(gap-3); hb <= not hb; cycles(3);
        end procedure;
    begin
        -- Each simulation is a fresh power-on; runtime reset is not a power cycle.
        wait for 1 ns; expect(false, true);
        cycles(1); reset <= '0'; request <= not SAFE_LEVEL;
        cycles(210); expect(false, true);
        hb <= '1'; cycles(210); expect(false, true); -- no qualified heartbeat yet
        reset <= '1'; hb <= '0'; cycles(1); reset <= '0'; cycles(4);
        -- Malformed startup traffic cannot arm or latch the monitor.
        for i in 1 to 20 loop edge_after(9); expect(false, true); end loop;
        for i in 1 to 20 loop edge_after(53); expect(false, true); end loop;
        reset <= '1'; hb <= '0'; cycles(1); reset <= '0'; cycles(4);
        for i in 1 to 15 loop edge_after; expect(false, true); end loop;
        edge_after(9); expect(false, true); -- malformed final edge must not qualify
        for i in 1 to 14 loop edge_after; expect(false, true); end loop;
        -- Arming does not depend on normal permission: qualify in safe state.
        request <= SAFE_LEVEL;
        edge_after; expect(false);
        request <= not SAFE_LEVEL; wait for 1 ns; expect(false);
        cycles(1); expect(false); cycles(1); expect(true);
        edge_after; expect(true);
        edge_after(10); expect(true); edge_after(52); expect(true);

        -- Safe requests remain asynchronous with synchronized release.
        request <= SAFE_LEVEL; wait for 1 ns; expect(false);
        for i in 1 to 20 loop edge_after; expect(false); end loop;
        request <= not SAFE_LEVEL; wait for 1 ns; expect(false);
        cycles(1); expect(false); cycles(1); expect(true);
        request <= 'X'; wait for 1 ns; expect(false);
        request <= not SAFE_LEVEL; cycles(1); expect(false); cycles(1); expect(true);
        request <= 'Z'; wait for 1 ns; expect(false);
        request <= not SAFE_LEVEL; cycles(1); expect(false); cycles(1); expect(true);
        edge_after; expect(true);
        enable <= '0'; cycles(1); expect(true); cycles(1); expect(false);
        enable <= 'X'; cycles(3); expect(false);
        enable <= '1'; cycles(1); expect(false); cycles(1); expect(true);
        pilot <= '0'; cycles(1); expect(true); cycles(1); expect(not PILOT_REQUIRED);
        pilot <= 'X'; cycles(3); expect(not PILOT_REQUIRED);
        pilot <= '1'; cycles(1); expect(not PILOT_REQUIRED); cycles(1); expect(true);
        edge_after; expect(true);

        -- The fault monitor stays live through runtime reset; a healthy
        -- heartbeat continues and reset only masks normal permission.
        reset <= '1'; wait for 1 ns; expect(false);
        for i in 1 to 18 loop edge_after; expect(false); end loop;
        reset <= '0'; cycles(1); expect(false); cycles(1); expect(true);
        edge_after; expect(true);
        -- A stopped clock must not prevent request assertion or permit release.
        request <= SAFE_LEVEL; wait for 2 us; expect(false);
        request <= not SAFE_LEVEL; wait for 2 us; expect(false);
        cycles(1); expect(false); cycles(1); expect(true);
        request <= SAFE_LEVEL; wait for 1 ns; expect(false);
        request <= not SAFE_LEVEL; cycles(1); expect(false);
        request <= SAFE_LEVEL; wait for 1 ns; expect(false);
        request <= not SAFE_LEVEL; cycles(1); expect(false); cycles(1); expect(true);
        edge_after; expect(true);

        if FAULT_KIND = "short" then
            edge_after(9);
        elsif FAULT_KIND = "long" then
            edge_after(53);
        elsif FAULT_KIND = "unknown" then
            hb <= 'X'; cycles(3);
        else
            if FAULT_KIND = "safe_timeout" then request <= SAFE_LEVEL;
            elsif FAULT_KIND = "disabled_timeout" then enable <= '0';
            elsif FAULT_KIND = "reset_timeout" then reset <= '1';
            elsif FAULT_KIND = "high_timeout" then
                if hb = '0' then edge_after; end if;
            elsif FAULT_KIND = "low_timeout" then
                if hb = '1' then edge_after; end if;
            end if;
            cycles(207);
            expect(FAULT_KIND /= "safe_timeout" and FAULT_KIND /= "disabled_timeout" and FAULT_KIND /= "reset_timeout");
            cycles(1); -- fault on exactly cycle 208 after the observed edge
        end if;
        expect(false, true);

        -- Nothing in the runtime interface can clear the latch or hide it.
        hb <= '0'; reset <= '1'; request <= SAFE_LEVEL;
        pilot <= '0'; enable <= '0'; cycles(5); expect(false, true);
        for i in 1 to 20 loop edge_after; expect(false, true); end loop;
        reset <= '0'; request <= not SAFE_LEVEL;
        pilot <= '1'; enable <= '1';
        for i in 1 to 20 loop edge_after; expect(false, true); end loop;
        request <= SAFE_LEVEL; wait for 1 ns; expect(false, true);
        request <= not SAFE_LEVEL; cycles(2); expect(false, true);
        report "HEARTBEAT PASSED";
        wait;
    end process;
end architecture;
