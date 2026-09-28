library ieee;
use ieee.std_logic_1164.all;

entity S3CToolchainTestProgram is
    port (
        Carrier_PwrOn                  : out std_logic;
        ANL_S3C_CarrierReady           : out std_logic;
        DIGS3C_Shared_CarrierReady     : out std_logic;
        DIGS3C_Shared_ReqSafeState     : out std_logic;
        DIGS3C_SlotD1_SlotOE           : out std_logic;
        DIGS3C_SlotD2_SlotOE           : out std_logic;
        DIGS3C_SlotD3_SlotOE           : out std_logic;
        DIGS3C_SlotD4_SlotOE           : out std_logic;
        DIGS3C_SlotD5_SlotOE           : out std_logic
    );
end S3CToolchainTestProgram;

architecture rtl of S3CToolchainTestProgram is
begin
    Carrier_PwrOn              <= '0';
    ANL_S3C_CarrierReady       <= '0';
    DIGS3C_Shared_CarrierReady <= '0';
    DIGS3C_Shared_ReqSafeState <= '1';
    DIGS3C_SlotD1_SlotOE       <= '0';
    DIGS3C_SlotD2_SlotOE       <= '0';
    DIGS3C_SlotD3_SlotOE       <= '0';
    DIGS3C_SlotD4_SlotOE       <= '0';
    DIGS3C_SlotD5_SlotOE       <= '0';
end rtl;
