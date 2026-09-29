-- Shared synchronous controller for level-based S3C contracts.
library ieee;
use ieee.std_logic_1164.all;

architecture level_signals of s3c_logic is
    type state_type is (safe_state, normal_state);
    signal state : state_type := safe_state;
    signal request_meta, request_sync : std_logic := REQUEST_SAFE_LEVEL;
    signal ready_meta, ready_sync : std_logic := not CARRIER_READY_LEVEL;
    signal pilot_meta, pilot_sync : std_logic := '0';
    signal enable_meta, enable_sync : std_logic := '0';
    signal warmup : natural range 0 to 3 := 0;
    signal allow_normal : boolean;
begin
    allow_normal <= request_sync = not REQUEST_SAFE_LEVEL and enable_sync = '1' and
                    (not USE_CARRIER_READY or ready_sync = CARRIER_READY_LEVEL) and
                    (not REQUIRE_PILOT or pilot_sync = '1');
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state <= safe_state;
                request_meta <= REQUEST_SAFE_LEVEL; request_sync <= REQUEST_SAFE_LEVEL;
                ready_meta <= not CARRIER_READY_LEVEL; ready_sync <= not CARRIER_READY_LEVEL;
                pilot_meta <= '0'; pilot_sync <= '0';
                enable_meta <= '0'; enable_sync <= '0';
                warmup <= 0;
            else
                request_meta <= reqsafestate; request_sync <= request_meta;
                ready_meta <= carrierrdy; ready_sync <= ready_meta;
                pilot_meta <= pilot_in; pilot_sync <= pilot_meta;
                enable_meta <= card_enable; enable_sync <= enable_meta;
                if warmup < 3 then
                    warmup <= warmup + 1;
                    state <= safe_state;
                else
                    case state is
                        when safe_state =>
                            if allow_normal then
                                state <= normal_state;
                            end if;
                        when normal_state =>
                            if not allow_normal then
                                state <= safe_state;
                            end if;
                    end case;
                end if;
            end if;
        end if;
    end process;
    state_normal <= '1' when state = normal_state and reset = '0' else '0';
    state_safe <= '1' when state = safe_state or reset /= '0' else '0';
    slotok <= SLOTOK_NORMAL when state = normal_state and reset = '0' else SLOTOK_SAFE;
    reqoe <= REQOE_NORMAL when state = normal_state and reset = '0' else REQOE_SAFE;
end architecture;
