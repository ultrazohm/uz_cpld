-- Shared interface for S3C controller implementations.
library ieee;
use ieee.std_logic_1164.all;

entity s3c_logic is
    generic (
        REQUIRE_PILOT : boolean := false;
        REQUEST_SAFE_LEVEL : std_logic := '1';
        USE_CARRIER_READY : boolean := false;
        CARRIER_READY_LEVEL : std_logic := '1';
        SLOTOK_NORMAL : std_logic := '1';
        SLOTOK_SAFE : std_logic := '0';
        REQOE_NORMAL : std_logic := '1';
        REQOE_SAFE : std_logic := '1'
    );
    port (
        clk, reset : in std_logic;
        reqsafestate, carrierrdy, pilot_in, card_enable : in std_logic;
        state_normal, state_safe : out std_logic;
        slotok, reqoe : out std_logic
    );
end entity;
