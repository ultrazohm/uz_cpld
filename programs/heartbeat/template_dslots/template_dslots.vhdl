library IEEE;
library s3c;
library machxo2;
use machxo2.all;
use IEEE.STD_LOGIC_1164.ALL;

entity SignalRouter is
    Port (
			
		--Safety
		pilot_in: in STD_LOGIC;	-- from adapter card, high active, card okay
		reqsafestate: in STD_LOGIC; --from s3c
		carrierrdy: in STD_LOGIC;--from s3c
		slotok : out STD_LOGIC;--to s3c
		reqoe: out STD_LOGIC;--to s3c
		
	    -- Define 2 i2c ports
        i2c_scl : in STD_LOGIC;
        i2c_sda : in STD_LOGIC;
        -- Define 30 fpga ports
        fpga_00 : in STD_LOGIC;
        fpga_01 : in STD_LOGIC;
        fpga_02 : in STD_LOGIC;
        fpga_03 : in STD_LOGIC;
        fpga_04 : in STD_LOGIC;
        fpga_05 : in STD_LOGIC;
        fpga_06 : in STD_LOGIC;
        fpga_07 : in STD_LOGIC;
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
        fpga_24 : in STD_LOGIC;
        fpga_25 : in STD_LOGIC;
        fpga_26 : in STD_LOGIC;
        fpga_27 : in STD_LOGIC;
        fpga_28 : in STD_LOGIC;
        fpga_29 : in STD_LOGIC;

        -- Define 30 d-slot ports
        d_00 : out STD_LOGIC;
        d_01 : out STD_LOGIC;
        d_02 : out STD_LOGIC;
        d_03 : out STD_LOGIC;
        d_04 : out STD_LOGIC;
        d_05 : out STD_LOGIC;
        d_06 : out STD_LOGIC;
        d_07 : out STD_LOGIC;
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
        d_24 : out STD_LOGIC;
        d_25 : out STD_LOGIC;
        d_26 : out STD_LOGIC;
        d_27 : out STD_LOGIC;
        d_28 : out STD_LOGIC;
        d_29 : out STD_LOGIC
    );
	
	SIGNAL enable_forwarding : std_logic;
	SIGNAL user_enable_forwarding : std_logic;
	
	-- dummy
	signal dummy_signal : std_logic;
	attribute syn_keep : boolean;
	attribute syn_keep of dummy_signal : signal is true;
end SignalRouter;

architecture Behavioral of SignalRouter is

	SIGNAL clk: STD_LOGIC;

	COMPONENT OSCH
		-- synthesis translate_off
		GENERIC (NOM_FREQ: STRING := "2.08");
		-- synthesis translate_on
		PORT (
			STDBY: IN STD_LOGIC;
			OSC: OUT STD_LOGIC;
			SEDSTDBY: OUT STD_LOGIC
		);
	END COMPONENT;
	ATTRIBUTE NOM_FREQ: STRING;
	ATTRIBUTE NOM_FREQ OF OSCInst0: LABEL IS "2.08";
begin
	OSCInst0: OSCH
		-- synthesis translate_off
		GENERIC MAP (NOM_FREQ => "2.08")
		-- synthesis translate_on
		PORT MAP (
			STDBY => '0',
			OSC => clk,
			SEDSTDBY => OPEN
		);

	    -- Shared receiver: asynchronous safe assertion, two-clock recovery.
    dslot_heartbeat: entity s3c.s3c_logic(heartbeat)
        generic map (
            REQUIRE_PILOT => false, REQUEST_SAFE_LEVEL => '1',
            SLOTOK_NORMAL => '1', SLOTOK_SAFE => '0',
            REQOE_NORMAL => '1', REQOE_SAFE => '1'
        )
        port map (
            clk => clk, reset => '0',
            reqsafestate => reqsafestate, carrierrdy => carrierrdy,
            pilot_in => pilot_in, card_enable => user_enable_forwarding,
            state_normal => enable_forwarding, state_safe => open,
            slotok => slotok, reqoe => reqoe
        );

	--Fixed definitions
	
	-- Specific safety definitions for card
	--	tristate_outputs <= NOT pilot_in; -- set to pilot_in if card is driven by pilot_in, definition can be extended by user based on card specific logic AND internal states
	
    -- Define the user specific enable_forwarding signal logic
	--user_enable_forwarding <= '1'; -- for tx30
	user_enable_forwarding <= '1' when (fpga_26 = '0' AND fpga_27 = '0' AND  fpga_28 = '1' AND fpga_29 = '1') else '0'; -- for tx26_w_enable
    
	-- Map ports
    d_00 <= fpga_00 AND enable_forwarding;
    d_01 <= fpga_01 AND enable_forwarding;
    d_02 <= fpga_02 AND enable_forwarding;
    d_03 <= fpga_03 AND enable_forwarding;
    d_04 <= fpga_04 AND enable_forwarding;
    d_05 <= fpga_05 AND enable_forwarding;
    d_06 <= fpga_06 AND enable_forwarding;
    d_07 <= fpga_07 AND enable_forwarding;
    d_08 <= fpga_08 AND enable_forwarding;
    d_09 <= fpga_09 AND enable_forwarding;
    d_10 <= fpga_10 AND enable_forwarding;
    d_11 <= fpga_11 AND enable_forwarding;
    d_12 <= fpga_12 AND enable_forwarding;
    d_13 <= fpga_13 AND enable_forwarding;
    d_14 <= fpga_14 AND enable_forwarding;
    d_15 <= fpga_15 AND enable_forwarding;
    d_16 <= fpga_16 AND enable_forwarding;
    d_17 <= fpga_17 AND enable_forwarding;
    d_18 <= fpga_18 AND enable_forwarding;
    d_19 <= fpga_19 AND enable_forwarding;
    d_20 <= fpga_20 AND enable_forwarding;
    d_21 <= fpga_21 AND enable_forwarding;
    d_22 <= fpga_22 AND enable_forwarding;
    d_23 <= fpga_23 AND enable_forwarding;
    d_24 <= fpga_24 AND enable_forwarding;
    d_25 <= fpga_25 AND enable_forwarding;

	-- Make sure ports are not optimized away
	dummy_signal <= i2c_scl AND i2c_sda AND carrierrdy AND pilot_in;

end Behavioral;