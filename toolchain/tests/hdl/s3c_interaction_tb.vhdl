configuration simulated_s3c of Waiting_for_Powerbutton_pressed_V0 is
    for behavior
        for OSCInst0 : OSCH
            use entity work.OSCH(simulation);
        end for;
    end for;
end configuration;
configuration simulated_slot of tx30_stateful is
    for rtl
        for oscillator : OSCH
            use entity work.OSCH(simulation);
        end for;
    end for;
end configuration;
library ieee;
use ieee.std_logic_1164.all;
entity pair is end entity;
architecture test of pair is
    signal power_button, stop_button, enable_button : std_logic := '1';
    signal safe_request, carrier_ready, slotok, reqoe : std_logic;
    signal slot_oe, reqoe_bus, slotok_bus : std_logic_vector(5 downto 1);
    signal outputs : std_logic_vector(29 downto 0);
begin
    reqoe_bus <= (others => reqoe);
    slotok_bus <= (others => slotok);
    s3c: configuration work.simulated_s3c port map (
FP_SysLEDg => open,
FP_SysLEDr => open,
FP_SysLEDb => open,
FlexIO05 => open,
FlexIO04 => '1',
FlexIO03 => '1',
FlexIO02 => open,
FlexIO01 => open,
FP_UsrSW1 => enable_button,
FP_UsrSW2 => '1',
SCL => open,
SDA => open,
FP_UsrSW3 => stop_button,
SysSW_Pwr_NC => power_button,
FPIO_isoCtrlRSTn => open,
FPIO_iosCtrlINTn => '1',
Carrier_PG_3V3 => open,
FPIO_ExternalStop => '1',
FPIO_FlexMIO28 => open,
FPIO_FlexMIO27 => open,
FPIO_FlexMIO30 => open,
FPIO_FlexMIO29 => open,
FPIO_FlexMIO52 => open,
Carrier_PG_1V8 => open,
S3CsI2C_SDA => open,
S3CsI2C_SCL => open,
FP_SysLEDs => open,
SD1_CD => '1',
SD0_CD => '1',
SPI_S3C_nCS_USR => '1',
FP_UsrLED => open,
DIGS3C_Shared_CarrierReady => carrier_ready,
DIGS3C_Shared_ReqSafeState => safe_request,
DIGS3C_SlotD_ReqOE => reqoe_bus,
DIGS3C_SlotD_SlotOK => slotok_bus,
FlexLIO => open,
DIG5S3C26 => open,
DIG5S3C25 => open,
DIG5S3C24 => open,
SD_SEL => open,
FlexMIOs52_PCIe => '1',
FlexMIOs53_GPIO_PowerDown => open,
FlexMIOs54 => open,
FlexMio61ExternalStop => open,
FlexMIOs62 => open,
FlexMIOs63 => open,
FlexMIOs31 => open,
FlexMIOs30 => open,
FlexMIOs29 => open,
FlexMIOs28 => open,
FlexMIOs27 => open,
FlexMIOs26 => open,
FlexMIOs45 => open,
FlexMIOs37 => open,
FlexMIOs36 => open,
FlexMIOs35 => open,
FlexMIOs34 => open,
FlexMIOs33 => open,
FlexMIOs32 => open,
DIG5S3C03 => open,
DIG5S3C04 => open,
DIG5S3C05 => open,
DIG5S3C00 => open,
DIG5S3C02 => open,
DIG5S3C01 => open,
DIG5S3C29 => open,
DIG5S3C28 => open,
DIG5S3C27 => open,
ANL_S3C_SLOTOK => (others => '1'),
ANL_S3C_CarrierReady => open,
ANL_S3C_P54_Legacy => open,
DIGS3C_SlotD_SlotOE => slot_oe,
Carrier_PwrOn => open,
PG_VIN => '1',
PPn_VIN => '1',
PG_Module => '1',
TDnSHDN => '1',
TDnFFnFS => open,
TDnALERT => '1',
S3C_S1 => '1');
    slot: configuration work.simulated_slot port map (
pilot_in => '0',
reqsafestate => safe_request,
carrierrdy => carrier_ready,
slotok => slotok,
reqoe => reqoe,
i2c_scl => '0',
i2c_sda => '0',
fpga_00 => '1',
fpga_01 => '1',
fpga_02 => '1',
fpga_03 => '1',
fpga_04 => '1',
fpga_05 => '1',
fpga_06 => '1',
fpga_07 => '1',
fpga_08 => '1',
fpga_09 => '1',
fpga_10 => '1',
fpga_11 => '1',
fpga_12 => '1',
fpga_13 => '1',
fpga_14 => '1',
fpga_15 => '1',
fpga_16 => '1',
fpga_17 => '1',
fpga_18 => '1',
fpga_19 => '1',
fpga_20 => '1',
fpga_21 => '1',
fpga_22 => '1',
fpga_23 => '1',
fpga_24 => '1',
fpga_25 => '1',
fpga_26 => '1',
fpga_27 => '1',
fpga_28 => '1',
fpga_29 => '1',
d_00 => outputs(0),
d_01 => outputs(1),
d_02 => outputs(2),
d_03 => outputs(3),
d_04 => outputs(4),
d_05 => outputs(5),
d_06 => outputs(6),
d_07 => outputs(7),
d_08 => outputs(8),
d_09 => outputs(9),
d_10 => outputs(10),
d_11 => outputs(11),
d_12 => outputs(12),
d_13 => outputs(13),
d_14 => outputs(14),
d_15 => outputs(15),
d_16 => outputs(16),
d_17 => outputs(17),
d_18 => outputs(18),
d_19 => outputs(19),
d_20 => outputs(20),
d_21 => outputs(21),
d_22 => outputs(22),
d_23 => outputs(23),
d_24 => outputs(24),
d_25 => outputs(25),
d_26 => outputs(26),
d_27 => outputs(27),
d_28 => outputs(28),
d_29 => outputs(29));
    process
    begin
        wait for 150 ns;
        assert safe_request = '1' and slot_oe = "00000" and outputs = (outputs'range => '0')
            report "startup" severity failure;
        power_button <= '0'; wait for 210 us;
        power_button <= '1'; wait for 22 ms;
        assert safe_request = '0' and slot_oe = "11111" and outputs = (outputs'range => '1')
            report "ready" severity failure;
        stop_button <= '0'; wait for 210 us;
        assert safe_request = '1' and slot_oe = "11111" and outputs = (outputs'range => '0')
            report "soft stop must gate data even with physical OE asserted" severity failure;
        stop_button <= '1'; enable_button <= '0'; wait for 210 us;
        assert safe_request = '0' and slot_oe = "11111" and outputs = (outputs'range => '1')
            report "enable after soft stop" severity failure;
        report "S3C PAIR PASSED";
        wait;
    end process;
end architecture;
