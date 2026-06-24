library IEEE;
library machxo2;
use IEEE.STD_LOGIC_1164.ALL;
use machxo2.all;

entity SignalRouter is
    Port (
        -- Safety
        pilot_in: in STD_LOGIC;     -- from adapter card, high active, card okay
        reqsafestate: in STD_LOGIC; -- from s3c
        carrierrdy: in STD_LOGIC;   -- from s3c
        slotok : out STD_LOGIC;     -- to s3c
        reqoe: out STD_LOGIC;       -- to s3c

        -- Define 2 i2c ports
        i2c_scl : in STD_LOGIC;
        i2c_sda : in STD_LOGIC;

        -- Define 30 fpga ports
        fpga_00 : out STD_LOGIC;
        fpga_01 : out STD_LOGIC;
        fpga_02 : out STD_LOGIC;
        fpga_03 : out STD_LOGIC;
        fpga_04 : out STD_LOGIC;
        fpga_05 : out STD_LOGIC;
        fpga_06 : out STD_LOGIC;
        fpga_07 : out STD_LOGIC;
        fpga_08 : in STD_LOGIC;
        fpga_09 : in STD_LOGIC;
        fpga_10 : in STD_LOGIC;
        fpga_11 : in STD_LOGIC;
        fpga_12 : in STD_LOGIC;
        fpga_13 : in STD_LOGIC;
        fpga_14 : in STD_LOGIC;
        fpga_15 : in STD_LOGIC;
        fpga_16 : in STD_LOGIC;
        fpga_17 : in STD_LOGIC;
        fpga_18 : in STD_LOGIC;
        fpga_19 : in STD_LOGIC;
        fpga_20 : in STD_LOGIC;
        fpga_21 : in STD_LOGIC;
        fpga_22 : in STD_LOGIC;
        fpga_23 : in STD_LOGIC;
        fpga_24 : out STD_LOGIC;
        fpga_25 : out STD_LOGIC;
        fpga_26 : out STD_LOGIC;
        fpga_27 : out STD_LOGIC;
        fpga_28 : out STD_LOGIC;
        fpga_29 : out STD_LOGIC;

        -- Define 30 d-slot ports
        d_00 : in STD_LOGIC;
        d_01 : in STD_LOGIC;
        d_02 : in STD_LOGIC;
        d_03 : in STD_LOGIC;
        d_04 : in STD_LOGIC;
        d_05 : in STD_LOGIC;
        d_06 : in STD_LOGIC;
        d_07 : in STD_LOGIC;
        d_08 : out STD_LOGIC;
        d_09 : out STD_LOGIC;
        d_10 : out STD_LOGIC;
        d_11 : out STD_LOGIC;
        d_12 : out STD_LOGIC;
        d_13 : out STD_LOGIC;
        d_14 : out STD_LOGIC;
        d_15 : out STD_LOGIC;
        d_16 : out STD_LOGIC;
        d_17 : out STD_LOGIC;
        d_18 : out STD_LOGIC;
        d_19 : out STD_LOGIC;
        d_20 : out STD_LOGIC;
        d_21 : out STD_LOGIC;
        d_22 : out STD_LOGIC;
        d_23 : out STD_LOGIC;
        d_24 : in STD_LOGIC;
        d_25 : in STD_LOGIC;
        d_26 : in STD_LOGIC;
        d_27 : in STD_LOGIC;
        d_28 : in STD_LOGIC;
        d_29 : in STD_LOGIC
    );

    SIGNAL enable_forwarding : std_logic;
    SIGNAL user_enable_forwarding : std_logic;
    SIGNAL safe_state_request : STD_LOGIC;
    SIGNAL tristate_outputs: std_logic;

    signal dummy_signal : std_logic;
    attribute syn_keep : boolean;
    attribute syn_keep of dummy_signal : signal is true;
end SignalRouter;

architecture Behavioral of SignalRouter is
begin
    dslot_heartbeat: ENTITY work.dslot_heartbeat_receiver
        PORT MAP (
            reqsafestate        => reqsafestate,
            safe_state_request  => safe_state_request
        );

    -- Fixed definitions
    reqoe <= NOT tristate_outputs;
    enable_forwarding <= user_enable_forwarding AND NOT safe_state_request;

    -- Specific safety definitions for card
    slotok <= enable_forwarding;
    -- tristate_outputs <= NOT pilot_in;
    tristate_outputs <= '0';

    -- voltage_8rx_8tx_8tx_6rx: group 1 rx, group 2 tx, group 3 tx, group 4 rx.
    user_enable_forwarding <= '1';

    -- Group 1: rx
    fpga_00 <= d_00;
    fpga_01 <= d_01;
    fpga_02 <= d_02;
    fpga_03 <= d_03;
    fpga_04 <= d_04;
    fpga_05 <= d_05;
    fpga_06 <= d_06;
    fpga_07 <= d_07;

    -- Group 2: tx
    d_08 <= fpga_08 AND enable_forwarding;
    d_09 <= fpga_09 AND enable_forwarding;
    d_10 <= fpga_10 AND enable_forwarding;
    d_11 <= fpga_11 AND enable_forwarding;
    d_12 <= fpga_12 AND enable_forwarding;
    d_13 <= fpga_13 AND enable_forwarding;
    d_14 <= fpga_14 AND enable_forwarding;
    d_15 <= fpga_15 AND enable_forwarding;

    -- Group 3: tx
    d_16 <= fpga_16 AND enable_forwarding;
    d_17 <= fpga_17 AND enable_forwarding;
    d_18 <= fpga_18 AND enable_forwarding;
    d_19 <= fpga_19 AND enable_forwarding;
    d_20 <= fpga_20 AND enable_forwarding;
    d_21 <= fpga_21 AND enable_forwarding;
    d_22 <= fpga_22 AND enable_forwarding;
    d_23 <= fpga_23 AND enable_forwarding;

    -- Group 4: rx
    fpga_24 <= d_24;
    fpga_25 <= d_25;
    fpga_26 <= d_26;
    fpga_27 <= d_27;
    fpga_28 <= d_28;
    fpga_29 <= d_29;

    -- Make sure ports are not optimized away
    dummy_signal <= i2c_scl AND i2c_sda AND carrierrdy AND pilot_in;
end Behavioral;

