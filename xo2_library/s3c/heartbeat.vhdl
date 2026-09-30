-- CarrierReady heartbeat plus independent static ReqSafeState.
-- Protocol defaults follow xo2_libraries@74c7446; malformed edges revoke
-- qualification here, and intervals count actual synchronized clock edges.
library ieee;
use ieee.std_logic_1164.all;

architecture heartbeat of s3c_logic is
    signal normal : boolean := false;
    signal request_meta, request_sync : std_logic := REQUEST_SAFE_LEVEL;
    signal heartbeat_meta, heartbeat_sync, heartbeat_last : std_logic := '0';
    signal pilot_meta, pilot_sync : std_logic := '0';
    signal enable_meta, enable_sync : std_logic := '0';
    signal warmup : natural range 0 to 3 := 0;
    signal age : natural range 0 to HB_TIMEOUT_CLKS := HB_TIMEOUT_CLKS;
    signal edges : natural range 0 to HB_VALID_EDGES_REQUIRED := 0;
    signal qualified : boolean := false;
begin
    assert HB_MIN_EDGE_CLKS <= HB_MAX_EDGE_CLKS and HB_MAX_EDGE_CLKS < HB_TIMEOUT_CLKS
        report "heartbeat requires min edge <= max edge < timeout" severity failure;
    assert HB_VALID_EDGES_REQUIRED >= 2
        report "heartbeat requires at least two qualifying edges" severity failure;

    -- Heartbeat is mandatory in this architecture. USE_CARRIER_READY and
    -- CARRIER_READY_LEVEL apply only to level_signals; pulse polarity is irrelevant.
    process(clk)
        variable valid : boolean;
    begin
        if rising_edge(clk) then
            if reset = '1' then
                normal <= false;
                request_meta <= REQUEST_SAFE_LEVEL; request_sync <= REQUEST_SAFE_LEVEL;
                heartbeat_meta <= '0'; heartbeat_sync <= '0'; heartbeat_last <= '0';
                pilot_meta <= '0'; pilot_sync <= '0';
                enable_meta <= '0'; enable_sync <= '0';
                warmup <= 0; age <= HB_TIMEOUT_CLKS; edges <= 0; qualified <= false;
            else
                request_meta <= reqsafestate; request_sync <= request_meta;
                heartbeat_meta <= carrierrdy; heartbeat_sync <= heartbeat_meta;
                pilot_meta <= pilot_in; pilot_sync <= pilot_meta;
                enable_meta <= card_enable; enable_sync <= enable_meta;
                valid := qualified;
                heartbeat_last <= heartbeat_sync;
                if heartbeat_sync /= '0' and heartbeat_sync /= '1' then
                    valid := false; edges <= 0; age <= HB_TIMEOUT_CLKS;
                elsif heartbeat_sync /= heartbeat_last then
                    -- age is the number of completed clocks since the last edge.
                    -- Compare age with bounds minus one to avoid integer overflow.
                    if edges > 0 and age >= HB_MIN_EDGE_CLKS-1 and age < HB_MAX_EDGE_CLKS then
                        if edges < HB_VALID_EDGES_REQUIRED then
                            edges <= edges + 1;
                        end if;
                        valid := edges >= HB_VALID_EDGES_REQUIRED-1;
                    else
                        -- This edge can start a fresh sequence, but cannot qualify it.
                        edges <= 1;
                        valid := false;
                    end if;
                    age <= 0;
                elsif age >= HB_TIMEOUT_CLKS-1 then
                    age <= HB_TIMEOUT_CLKS; edges <= 0; valid := false;
                else
                    age <= age + 1;
                end if;
                qualified <= valid;
                if warmup < 3 then
                    warmup <= warmup + 1;
                    normal <= false;
                else
                    normal <= valid and request_sync = not REQUEST_SAFE_LEVEL and
                              enable_sync = '1' and
                              (not REQUIRE_PILOT or pilot_sync = '1');
                end if;
            end if;
        end if;
    end process;
    state_normal <= '1' when normal and reset = '0' else '0';
    state_safe <= '0' when normal and reset = '0' else '1';
    slotok <= SLOTOK_NORMAL when normal and reset = '0' else SLOTOK_SAFE;
    reqoe <= REQOE_NORMAL when normal and reset = '0' else REQOE_SAFE;
end architecture;
