-- CarrierReady heartbeat plus independent static ReqSafeState.
-- Protocol defaults follow xo2_libraries@74c7446; malformed edges revoke
-- qualification here, and intervals count actual synchronized clock edges.
library ieee;
use ieee.std_logic_1164.all;

architecture heartbeat of s3c_logic is
    signal normal : boolean;
    signal release_meta, release_sync : std_logic := '0';
    signal heartbeat_meta, heartbeat_sync, heartbeat_last : std_logic := '0';
    signal pilot_meta, pilot_sync : std_logic := '0';
    signal enable_meta, enable_sync : std_logic := '0';
    signal age : natural range 0 to HB_TIMEOUT_CLKS := HB_TIMEOUT_CLKS;
    signal edges : natural range 0 to HB_VALID_EDGES_REQUIRED := 0;
    signal qualified : boolean := false;
begin
    assert HB_MIN_EDGE_CLKS <= HB_MAX_EDGE_CLKS and HB_MAX_EDGE_CLKS < HB_TIMEOUT_CLKS
        report "heartbeat requires min edge <= max edge < timeout" severity failure;
    assert HB_VALID_EDGES_REQUIRED >= 2
        report "heartbeat requires at least two qualifying edges" severity failure;

    -- Assert safety without a clock; release only after two rising edges.
    -- This gate never resets heartbeat qualification or its timeout counter.
    process(clk, reset, reqsafestate)
    begin
        if reset /= '0' or reqsafestate /= not REQUEST_SAFE_LEVEL then
            release_meta <= '0';
            release_sync <= '0';
        elsif rising_edge(clk) then
            release_meta <= '1';
            release_sync <= release_meta;
        end if;
    end process;

    -- Heartbeat is mandatory in this architecture. USE_CARRIER_READY and
    -- CARRIER_READY_LEVEL apply only to level_signals; pulse polarity is irrelevant.
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                heartbeat_meta <= '0'; heartbeat_sync <= '0'; heartbeat_last <= '0';
                pilot_meta <= '0'; pilot_sync <= '0';
                enable_meta <= '0'; enable_sync <= '0';
                age <= HB_TIMEOUT_CLKS; edges <= 0; qualified <= false;
            else
                heartbeat_meta <= carrierrdy; heartbeat_sync <= heartbeat_meta;
                pilot_meta <= pilot_in; pilot_sync <= pilot_meta;
                enable_meta <= card_enable; enable_sync <= enable_meta;
                heartbeat_last <= heartbeat_sync;
                if heartbeat_sync /= '0' and heartbeat_sync /= '1' then
                    qualified <= false; edges <= 0; age <= HB_TIMEOUT_CLKS;
                elsif heartbeat_sync /= heartbeat_last then
                    -- age is the number of completed clocks since the last edge.
                    -- Compare age with bounds minus one to avoid integer overflow.
                    if edges > 0 and age >= HB_MIN_EDGE_CLKS-1 and age < HB_MAX_EDGE_CLKS then
                        if edges < HB_VALID_EDGES_REQUIRED then
                            edges <= edges + 1;
                        end if;
                        qualified <= edges >= HB_VALID_EDGES_REQUIRED-1;
                    else
                        -- This edge can start a fresh sequence, but cannot qualify it.
                        edges <= 1;
                        qualified <= false;
                    end if;
                    age <= 0;
                elsif age >= HB_TIMEOUT_CLKS-1 then
                    age <= HB_TIMEOUT_CLKS; edges <= 0; qualified <= false;
                else
                    age <= age + 1;
                end if;
            end if;
        end if;
    end process;
    normal <= release_sync = '1' and qualified and enable_sync = '1' and
              (not REQUIRE_PILOT or pilot_sync = '1');
    state_normal <= '1' when normal else '0';
    state_safe <= '0' when normal else '1';
    slotok <= SLOTOK_NORMAL when normal else SLOTOK_SAFE;
    reqoe <= REQOE_NORMAL when normal else REQOE_SAFE;
end architecture;
