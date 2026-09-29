-- Direct controller tests: no generated routing or S3C firmware required.
library ieee;
use ieee.std_logic_1164.all;
library s3c;

entity s3c_logic_tb is
    generic (
        SAFE_LEVEL : std_logic := '1';
        READY_LEVEL : std_logic := '1';
        USE_READY : boolean := true;
        PILOT_REQUIRED : boolean := true
    );
end entity;

architecture test of s3c_logic_tb is
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal request : std_logic := SAFE_LEVEL;
    signal ready : std_logic := READY_LEVEL;
    signal pilot, enable : std_logic := '1';
    signal normal, safe, slotok, reqoe : std_logic;
begin
    dut: entity s3c.s3c_logic(level_signals)
        generic map (
            REQUIRE_PILOT => PILOT_REQUIRED,
            REQUEST_SAFE_LEVEL => SAFE_LEVEL,
            USE_CARRIER_READY => USE_READY,
            CARRIER_READY_LEVEL => READY_LEVEL,
            SLOTOK_NORMAL => '0', SLOTOK_SAFE => '1',
            REQOE_NORMAL => '1', REQOE_SAFE => '0'
        )
        port map (
            clk => clk, reset => reset, reqsafestate => request,
            carrierrdy => ready, pilot_in => pilot, card_enable => enable,
            state_normal => normal, state_safe => safe, slotok => slotok, reqoe => reqoe
        );
    process
        procedure cycles(n : positive) is
        begin
            for i in 1 to n loop
                clk <= '0'; wait for 5 ns; clk <= '1'; wait for 5 ns;
            end loop;
        end procedure;
        procedure expect_normal(value : boolean) is
        begin
            if value then
                assert normal = '1' and safe = '0' and slotok = '0' and reqoe = '1'
                    report "expected normal_state and configured status levels" severity failure;
            else
                assert normal = '0' and safe = '1' and slotok = '1' and reqoe = '0'
                    report "expected safe_state and configured status levels" severity failure;
            end if;
        end procedure;
    begin
        cycles(1); expect_normal(false);
        request <= not SAFE_LEVEL; reset <= '0';
        cycles(3); expect_normal(false);
        cycles(1); expect_normal(true);

        request <= SAFE_LEVEL;
        cycles(2); expect_normal(true);
        cycles(1); expect_normal(false);
        request <= not SAFE_LEVEL; cycles(3); expect_normal(true);
        request <= 'X'; cycles(3); expect_normal(false);
        request <= 'Z'; cycles(3); expect_normal(false);
        request <= not SAFE_LEVEL; cycles(3); expect_normal(true);

        enable <= '0'; cycles(3); expect_normal(false);
        enable <= 'X'; cycles(3); expect_normal(false);
        enable <= '1'; cycles(3); expect_normal(true);

        pilot <= '0'; cycles(3); expect_normal(not PILOT_REQUIRED);
        pilot <= 'X'; cycles(3); expect_normal(not PILOT_REQUIRED);
        pilot <= '1'; cycles(3); expect_normal(true);

        ready <= not READY_LEVEL; cycles(3); expect_normal(not USE_READY);
        ready <= 'U'; cycles(3); expect_normal(not USE_READY);
        ready <= READY_LEVEL; cycles(3); expect_normal(true);

        reset <= '1'; cycles(1); expect_normal(false);
        reset <= '0'; cycles(3); expect_normal(false);
        cycles(1); expect_normal(true);
        report "S3C LOGIC PASSED";
        wait;
    end process;
end architecture;
