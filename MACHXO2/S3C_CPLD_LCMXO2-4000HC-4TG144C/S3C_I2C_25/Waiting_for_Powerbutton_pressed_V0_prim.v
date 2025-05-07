// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Wed May 07 13:33:13 2025
//
// Verilog Description of module Waiting_for_Powerbutton_pressed_V0
//

module Waiting_for_Powerbutton_pressed_V0 (FP_SysLEDg, FP_SysLEDr, FP_SysLEDb, 
            FlexIO05, FlexIO04, FlexIO03, FlexIO02, FlexIO01, FP_UsrSW1, 
            FP_UsrSW2, SCL, SDA, FP_UsrSW3, SysSW_Pwr_NC, FPIO_isoCtrlRSTn, 
            FPIO_iosCtrlINTn, Carrier_PG_3V3, FPIO_ExternalStop, FPIO_FlexMIO28, 
            FPIO_FlexMIO27, FPIO_FlexMIO30, FPIO_FlexMIO29, FPIO_FlexMIO52, 
            Carrier_PG_1V8, S3CsI2C_SDA, S3CsI2C_SCL, FP_SysLEDs, SD1_CD, 
            SD0_CD, SPI_S3C_nCS_USR, FP_UsrLED, DIGS3C_Shared_CarrierReady, 
            DIGS3C_Shared_ReqSafeState, DIGS3C_SlotD_ReqOE, DIGS3C_SlotD_SlotOK, 
            FlexLIO, DIG5S3C26, DIG5S3C25, DIG5S3C24, SD_SEL, FlexMIOs52_PCIe, 
            FlexMIOs53_GPIO_PowerDown, FlexMIOs54, FlexMio61ExternalStop, 
            FlexMIOs62, FlexMIOs63, FlexMIOs31, FlexMIOs30, FlexMIOs29, 
            FlexMIOs28, FlexMIOs27, FlexMIOs26, FlexMIOs45, FlexMIOs37, 
            FlexMIOs36, FlexMIOs35, FlexMIOs34, FlexMIOs33, FlexMIOs32, 
            DIG5S3C03, DIG5S3C04, DIG5S3C05, DIG5S3C00, DIG5S3C02, 
            DIG5S3C01, DIG5S3C29, DIG5S3C28, DIG5S3C27, ANL_S3C_SLOTOK, 
            ANL_S3C_CarrierReady, ANL_S3C_P54_Legacy, DIGS3C_SlotD_SlotOE, 
            Carrier_PwrOn, PG_VIN, PPn_VIN, PG_Module, TDnSHDN, TDnFFnFS, 
            TDnALERT, S3C_S1);   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(7[8:42])
    output FP_SysLEDg;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(12[3:13])
    output FP_SysLEDr;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(13[3:13])
    output FP_SysLEDb;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(14[3:13])
    output FlexIO05;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(15[3:11])
    input FlexIO04;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(16[3:11])
    input FlexIO03;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(17[3:11])
    output FlexIO02;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(18[3:11])
    output FlexIO01;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(19[3:11])
    input FP_UsrSW1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(20[3:12])
    input FP_UsrSW2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(21[3:12])
    input SCL /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(23[3:6])
    input SDA /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(24[3:6])
    input FP_UsrSW3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(25[3:12])
    input SysSW_Pwr_NC;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(26[3:15])
    output FPIO_isoCtrlRSTn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(27[3:19])
    input FPIO_iosCtrlINTn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(28[3:19])
    output Carrier_PG_3V3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(29[3:17])
    input FPIO_ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(30[3:20])
    inout FPIO_FlexMIO28;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(31[3:17])
    inout FPIO_FlexMIO27;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(32[3:17])
    inout FPIO_FlexMIO30;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(33[3:17])
    inout FPIO_FlexMIO29;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(34[3:17])
    output FPIO_FlexMIO52;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(35[3:17])
    output Carrier_PG_1V8;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(37[3:17])
    input S3CsI2C_SDA /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(38[3:14])
    input S3CsI2C_SCL /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(39[3:14])
    output FP_SysLEDs;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(40[3:13])
    input SD1_CD;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(41[3:9])
    input SD0_CD;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(42[3:9])
    input SPI_S3C_nCS_USR;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(43[3:18])
    output [4:1]FP_UsrLED;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(44[3:12])
    output DIGS3C_Shared_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(45[3:29])
    output DIGS3C_Shared_ReqSafeState;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(46[3:29])
    input [5:1]DIGS3C_SlotD_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(47[3:21])
    input [5:1]DIGS3C_SlotD_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(48[3:22])
    input [5:0]FlexLIO;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(49[3:10])
    inout DIG5S3C26;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(51[3:12])
    inout DIG5S3C25;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(52[3:12])
    inout DIG5S3C24;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(53[3:12])
    output SD_SEL;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(54[3:9])
    input FlexMIOs52_PCIe;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(56[3:18])
    output FlexMIOs53_GPIO_PowerDown;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(57[3:28])
    inout FlexMIOs54;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(58[3:13])
    output FlexMio61ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(59[3:24])
    inout FlexMIOs62;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(60[3:13])
    inout FlexMIOs63;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(61[3:13])
    inout FlexMIOs31;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(62[3:13])
    inout FlexMIOs30;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(63[3:13])
    inout FlexMIOs29;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(64[3:13])
    inout FlexMIOs28;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(65[3:13])
    inout FlexMIOs27;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(66[3:13])
    inout FlexMIOs26;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(67[3:13])
    input FlexMIOs45 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(68[3:13])
    inout FlexMIOs37;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(69[3:13])
    inout FlexMIOs36;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(70[3:13])
    inout FlexMIOs35;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(71[3:13])
    inout FlexMIOs34;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(72[3:13])
    inout FlexMIOs33;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(73[3:13])
    inout FlexMIOs32;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(74[3:13])
    inout DIG5S3C03;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(76[3:12])
    inout DIG5S3C04;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(77[3:12])
    inout DIG5S3C05;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(78[3:12])
    inout DIG5S3C00;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(79[3:12])
    inout DIG5S3C02;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(80[3:12])
    inout DIG5S3C01;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(81[3:12])
    inout DIG5S3C29;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(82[3:12])
    inout DIG5S3C28;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(83[3:12])
    inout DIG5S3C27;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(84[3:12])
    input [3:1]ANL_S3C_SLOTOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(87[3:17])
    output ANL_S3C_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(88[3:23])
    input ANL_S3C_P54_Legacy /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(89[3:21])
    output [5:1]DIGS3C_SlotD_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(90[3:22])
    output Carrier_PwrOn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(93[9:22])
    input PG_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(94[3:9])
    input PPn_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(95[3:10])
    input PG_Module;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(96[3:12])
    input TDnSHDN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(97[3:10])
    input TDnFFnFS /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(98[3:11])
    input TDnALERT;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(99[3:11])
    input S3C_S1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(100[3:9])
    
    wire clk /* synthesis SET_AS_NETWORK=clk, is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(106[9:12])
    wire dummy_signal /* synthesis noclip="on" */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(157[9:21])
    
    wire GND_net, VCC_net, n111, FP_SysLEDg_c, FP_SysLEDr_c, FP_SysLEDb_c, 
        n40, FlexIO04_c, FlexIO03_c, FP_UsrSW1_c, FP_UsrSW2_c, SCL_c, 
        SDA_c, FP_UsrSW3_c, SysSW_Pwr_NC_c, FPIO_isoCtrlRSTn_c, FPIO_iosCtrlINTn_c, 
        Carrier_PG_3V3_c, FlexMio61ExternalStop_c_c, FPIO_FlexMIO52_c_c, 
        S3CsI2C_SDA_c, S3CsI2C_SCL_c, FP_SysLEDs_c, SD1_CD_c, SD0_CD_c, 
        SPI_S3C_nCS_USR_c, FP_UsrLED_c_3, FP_UsrLED_c_2, DIGS3C_Shared_ReqSafeState_c, 
        DIGS3C_SlotD_ReqOE_c_5, DIGS3C_SlotD_ReqOE_c_4, DIGS3C_SlotD_ReqOE_c_3, 
        DIGS3C_SlotD_ReqOE_c_2, DIGS3C_SlotD_ReqOE_c_1, DIGS3C_SlotD_SlotOK_c_5, 
        DIGS3C_SlotD_SlotOK_c_4, DIGS3C_SlotD_SlotOK_c_3, DIGS3C_SlotD_SlotOK_c_2, 
        DIGS3C_SlotD_SlotOK_c_1, FlexLIO_c_5, FlexLIO_c_4, FlexLIO_c_3, 
        FlexLIO_c_2, FlexLIO_c_1, FlexLIO_c_0, FlexMIOs53_GPIO_PowerDown_c, 
        FlexMIOs45_c, ANL_S3C_SLOTOK_c_3, ANL_S3C_SLOTOK_c_2, ANL_S3C_SLOTOK_c_1, 
        ANL_S3C_P54_Legacy_c, DIGS3C_SlotD_SlotOE_c_5, DIGS3C_SlotD_SlotOE_c_4, 
        DIGS3C_SlotD_SlotOE_c_3, DIGS3C_SlotD_SlotOE_c_2, DIGS3C_SlotD_SlotOE_c_1, 
        Carrier_PwrOn_c, PG_VIN_c, PPn_VIN_c, PG_Module_c, TDnSHDN_c, 
        TDnFFnFS_c, TDnALERT_c, S3C_S1_c;
    wire [24:0]counter;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(107[9:16])
    wire [24:0]resetcounter;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(108[9:21])
    wire [3:0]next_state;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(114[12:22])
    wire [31:0]\debounce_counters[1] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(121[12:29])
    wire [31:0]\debounce_counters[2] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(121[12:29])
    wire [31:0]\debounce_counters[3] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(121[12:29])
    wire [31:0]\debounce_counters[4] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(121[12:29])
    
    wire n48, n66, n46, n33, n5261, n43, n4956, n4955, n4954;
    wire [6:1]debounce_inputs_asyn1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(123[12:33])
    wire [6:1]debounce_inputs_asyn2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(124[9:30])
    
    wire clk_enable_86;
    wire [6:1]pushed;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(125[9:15])
    wire [6:1]signals_debounced_syn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(126[12:33])
    
    wire clk_enable_85, n110, n109, externstop_falling, externstop_last, 
        extern_connected, forceoutputdisable, n4938, n30, n86, clk_enable_15, 
        n42, n4953, n4937, n4952, n4936, n4935, clk_enable_13, 
        n4934, n4933, n4932, n4931, n5298, n4930, n4950, n108, 
        n107, n175, n176, n177, n178, n179, n180, n181, n182, 
        n183, n184, n185, n186, n187, n188, n189, n190, n191, 
        n192, n193, n194, n195, n196, n197, n198, n199, n200, 
        n201, n202, n203, n204, n205, n206, clk_enable_130, n24, 
        n4929, clk_enable_87, n4928, n27, n40_adj_1, n5239, n5280, 
        n33_adj_2, n3688, pushed_1__N_294, n106, n4927, n281, n282, 
        n283, n284, n285, n286, n287, n288, n289, n290, n291, 
        n292, n293, n294, n295, n296, n297, n298, n299, n300, 
        n301, n302, n303, n304, n305, n306, n307, n308, n309, 
        n310, n311, n312, n4949, n38, n4926, n4925, n4924, n4923, 
        n4922, n4948, n4921, n4947, n4920, n4919, n37, n4918, 
        n4917, n4916, n4915, n4914, n4946, n4945, n4913, pushed_2__N_292, 
        FPIO_FlexMIO28_out, n4944, n387, n388, n389, n390, n391, 
        n392, n393, n394, n395, n396, n397, n398, n399, n400, 
        n401, n402, n403, n404, n405, n406, n407, n408, n409, 
        n410, n411, n412, n413, n414, n415, n416, n417, n418, 
        n3460, n4943, n4912, n5682, n4911, n4910, n4909, n4908, 
        n4907, n4009, pushed_3__N_290, n493, n494, n495, n496, 
        n497, n498, n499, n500, n501, n502, n503, n504, n505, 
        n506, n507, n508, n509, n510, n511, n512, n513, n514, 
        n515, n516, n517, n518, n519, n520, n521, n522, n523, 
        n524, n3894, n5681, n4942, pushed_4__N_288, n4941, n4906, 
        n4905, n32, n20, n4904, n4903, n28, n27_adj_3, n4940, 
        n4939, n20_adj_4, n6, n4902, n4901, n4900, n4899, n4898, 
        n4897, n4896, n23, n18, n74, n4895, n4894, n4893, n4892, 
        n16, n4891, n73, n4890, n4975, n17, n4889, n19, n4888, 
        n4887, externstop_falling_N_764, n4974, n118, n5672, n4886, 
        n4885, n4884, clk_enable_129, n4883, n4973, n4882, n5679, 
        n4972, n4881, n4971, n4880, n3245, n4970, n4969, DIG5S3C27_out, 
        n3659, clk_enable_20, DIG5S3C28_out, DIG5S3C29_out, DIG5S3C01_out, 
        DIG5S3C02_out, DIG5S3C00_out, DIG5S3C05_out, DIG5S3C04_out, 
        n130, n4968, n129, n4967, DIG5S3C03_out, FlexMIOs32_out, 
        n5031, n4879, FlexMIOs33_out, FlexMIOs34_out, FlexMIOs35_out, 
        FlexMIOs36_out, n4878, FlexMIOs37_out, clk_enable_6, n112, 
        n113, n5671, FlexMIOs26_out;
    wire [3:0]next_state_3__N_538;
    
    wire n15, n14, n4877, n117, n116, n4876, n121, n115, FlexMIOs27_out, 
        n114, n5678, n11, n4966, n120, n124, FlexMIOs28_out, n2690, 
        n3695, n29, n4875, n4874, n119, n4873, n5, n5901, n4965, 
        n5865, n5864, n2688, n3477, n4872, n2684, n4871, n126, 
        n4870, n4869, n3622, n4868, n4964, n2526, n2519, n4963, 
        n4867, FlexMIOs29_out, FlexMIOs30_out, n5621, n4962, n4866, 
        n2632, n2631, n2628, n2622, n2621, n2620, n2618, n2617, 
        n2616, n5620, n4865, n124_adj_5, n4864, n5670, n4863, 
        n5669, n122, n5692, n120_adj_6, n4862, n5338, n118_adj_7, 
        n4861, clk_enable_7, n4860, clk_enable_133, FlexMIOs31_out, 
        FlexMIOs63_out, n5686, n4859, n4858, n4857, n2600, n4856, 
        n2598, n2597, n2596, n2595, n2593, n2591, n2590, n2589, 
        FlexMIOs53_GPIO_PowerDown_N_755;
    wire [3:0]next_state_3__N_542;
    
    wire n4855, n1776, n1777, n1778, n1779, n1780, n1781, n1782, 
        n1783, n1784, n1785, n1786, n1787, n1788, n1789, n1790, 
        n1791, n1792, n1793, n1794, n1795, n1796, n1797, n1798, 
        n1799, n1800, n2588, n2587, n2586, n5332, FlexMIOs62_out, 
        FlexMIOs54_out, DIG5S3C24_out, n4961, n78, n116_adj_8, n5330;
    wire [3:0]next_state_3__N_522;
    
    wire n5668, n114_adj_9, n5667, n4960, n4959, forceoutputdisable_N_8, 
        DIGS3C_Shared_ReqSafeState_N_752, FlexMIOs53_GPIO_PowerDown_N_754, 
        FP_SysLEDr_N_738, FP_SysLEDb_N_739, FP_SysLEDg_N_737;
    wire [3:0]next_state_3__N_61;
    
    wire Carrier_PwrOn_N_757, FPIO_isoCtrlRSTn_N_740, n4854, n4853, 
        n4852, clk_enable_89, n4851, n5674, clk_enable_142, n5585, 
        n3271, n5584, FP_SysLEDs_N_751, n5583, n5582, n4850, Carrier_PG_1V8_N_831, 
        Carrier_PG_1V8_N_838, Carrier_PG_1V8_N_750, n113_adj_10, n5899, 
        n112_adj_11, n5581, n110_adj_12, n5310, n108_adj_13, n5306, 
        n5823, clk_enable_19, DIG5S3C25_out, DIG5S3C26_out, FPIO_FlexMIO29_out, 
        FPIO_FlexMIO30_out, clk_enable_139, FPIO_FlexMIO27_out, n5822, 
        n5821, n4983, n5697, n6_adj_14, n5696, n5695, n106_adj_15, 
        n105, n104, n4849, n5693, n5691, clk_enable_132, clk_enable_172, 
        clk_enable_52, clk_enable_83, n5563, clk_enable_18, n4848, 
        n102, n3927, n5562, n5561, n100, n5560, n5690, n5558, 
        n70, n98, clk_enable_16, n5688, n5687, n5553, n17_adj_16, 
        n4847, n5552, n5346, n5345, n5344, n5685, n5342, n4846, 
        n4845, n94, n4844, n5684, n5689, n4958, n4843, n127, 
        n125, n122_adj_17, n4842, n2921, n4957, n90, n123, n89, 
        n128, n126_adj_18, n4841, n5683, n4840, n4839, clk_enable_11;
    
    VHI i2 (.Z(VCC_net));
    CCU2D add_176_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[2] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n4855), .S1(n312));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_1.INIT0 = 16'hF000;
    defparam add_176_1.INIT1 = 16'h5555;
    defparam add_176_1.INJECT1_0 = "NO";
    defparam add_176_1.INJECT1_1 = "NO";
    CCU2D add_194_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[4] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n4887), .S1(n524));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_1.INIT0 = 16'hF000;
    defparam add_194_1.INIT1 = 16'h5555;
    defparam add_194_1.INJECT1_0 = "NO";
    defparam add_194_1.INJECT1_1 = "NO";
    CCU2D add_2355_18 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4910), .COUT(n4911));
    defparam add_2355_18.INIT0 = 16'h5555;
    defparam add_2355_18.INIT1 = 16'h5555;
    defparam add_2355_18.INJECT1_0 = "NO";
    defparam add_2355_18.INJECT1_1 = "NO";
    CCU2D add_438_21 (.A0(counter[19]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[20]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4948), .COUT(n4949), .S0(n1781), .S1(n1780));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[17:24])
    defparam add_438_21.INIT0 = 16'h5555;
    defparam add_438_21.INIT1 = 16'h5555;
    defparam add_438_21.INJECT1_0 = "NO";
    defparam add_438_21.INJECT1_1 = "NO";
    CCU2D add_167_15 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4845), .COUT(n4846), .S0(n193), 
          .S1(n192));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_15.INIT0 = 16'h5aaa;
    defparam add_167_15.INIT1 = 16'h5aaa;
    defparam add_167_15.INJECT1_0 = "NO";
    defparam add_167_15.INJECT1_1 = "NO";
    CCU2D add_185_33 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4886), .S0(n387));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_33.INIT0 = 16'h5aaa;
    defparam add_185_33.INIT1 = 16'h0000;
    defparam add_185_33.INJECT1_0 = "NO";
    defparam add_185_33.INJECT1_1 = "NO";
    CCU2D add_176_31 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4869), .COUT(n4870), .S0(n283), 
          .S1(n282));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_31.INIT0 = 16'h5aaa;
    defparam add_176_31.INIT1 = 16'h5aaa;
    defparam add_176_31.INJECT1_0 = "NO";
    defparam add_176_31.INJECT1_1 = "NO";
    LUT4 i3_2_lut (.A(counter[23]), .B(counter[4]), .Z(n28)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i3_2_lut.init = 16'heeee;
    CCU2D add_2355_16 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4909), .COUT(n4910));
    defparam add_2355_16.INIT0 = 16'h5555;
    defparam add_2355_16.INIT1 = 16'h5555;
    defparam add_2355_16.INJECT1_0 = "NO";
    defparam add_2355_16.INJECT1_1 = "NO";
    CCU2D add_2355_14 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4908), .COUT(n4909));
    defparam add_2355_14.INIT0 = 16'h5555;
    defparam add_2355_14.INIT1 = 16'h5555;
    defparam add_2355_14.INJECT1_0 = "NO";
    defparam add_2355_14.INJECT1_1 = "NO";
    CCU2D add_438_19 (.A0(counter[17]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[18]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4947), .COUT(n4948), .S0(n1783), .S1(n1782));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[17:24])
    defparam add_438_19.INIT0 = 16'h5555;
    defparam add_438_19.INIT1 = 16'h5555;
    defparam add_438_19.INJECT1_0 = "NO";
    defparam add_438_19.INJECT1_1 = "NO";
    LUT4 n3477_bdd_4_lut_2842 (.A(n3477), .B(next_state[1]), .C(next_state[2]), 
         .D(next_state[0]), .Z(n5553)) /* synthesis lut_function=(!((B ((D)+!C)+!B !(C (D)))+!A)) */ ;
    defparam n3477_bdd_4_lut_2842.init = 16'h2080;
    CCU2D add_438_17 (.A0(counter[15]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[16]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4946), .COUT(n4947), .S0(n1785), .S1(n1784));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[17:24])
    defparam add_438_17.INIT0 = 16'h5555;
    defparam add_438_17.INIT1 = 16'h5555;
    defparam add_438_17.INJECT1_0 = "NO";
    defparam add_438_17.INJECT1_1 = "NO";
    CCU2D add_185_31 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4885), .COUT(n4886), .S0(n389), 
          .S1(n388));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_31.INIT0 = 16'h5aaa;
    defparam add_185_31.INIT1 = 16'h5aaa;
    defparam add_185_31.INJECT1_0 = "NO";
    defparam add_185_31.INJECT1_1 = "NO";
    CCU2D add_185_29 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4884), .COUT(n4885), .S0(n391), 
          .S1(n390));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_29.INIT0 = 16'h5aaa;
    defparam add_185_29.INIT1 = 16'h5aaa;
    defparam add_185_29.INJECT1_0 = "NO";
    defparam add_185_29.INJECT1_1 = "NO";
    CCU2D add_2355_12 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4907), .COUT(n4908));
    defparam add_2355_12.INIT0 = 16'h5555;
    defparam add_2355_12.INIT1 = 16'h5555;
    defparam add_2355_12.INJECT1_0 = "NO";
    defparam add_2355_12.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_66 (.A(n5031), .B(n3460), .Z(n5668)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(248[12:28])
    defparam i1_2_lut_rep_66.init = 16'heeee;
    CCU2D add_176_29 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4868), .COUT(n4869), .S0(n285), 
          .S1(n284));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_29.INIT0 = 16'h5aaa;
    defparam add_176_29.INIT1 = 16'h5aaa;
    defparam add_176_29.INJECT1_0 = "NO";
    defparam add_176_29.INJECT1_1 = "NO";
    CCU2D add_438_15 (.A0(counter[13]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[14]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4945), .COUT(n4946), .S0(n1787), .S1(n1786));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[17:24])
    defparam add_438_15.INIT0 = 16'h5555;
    defparam add_438_15.INIT1 = 16'h5555;
    defparam add_438_15.INJECT1_0 = "NO";
    defparam add_438_15.INJECT1_1 = "NO";
    CCU2D add_438_13 (.A0(counter[11]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[12]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4944), .COUT(n4945), .S0(n1789), .S1(n1788));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[17:24])
    defparam add_438_13.INIT0 = 16'h5555;
    defparam add_438_13.INIT1 = 16'h5555;
    defparam add_438_13.INJECT1_0 = "NO";
    defparam add_438_13.INJECT1_1 = "NO";
    LUT4 i1299_2_lut_4_lut (.A(n5310), .B(n5563), .C(n5670), .D(n2690), 
         .Z(n3695)) /* synthesis lut_function=(A (B (D))+!A !((C+!(D))+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i1299_2_lut_4_lut.init = 16'h8c00;
    LUT4 i2691_4_lut (.A(n5669), .B(externstop_falling), .C(next_state[3]), 
         .D(next_state[2]), .Z(n5310)) /* synthesis lut_function=(A (B+(D))+!A (B (C)+!B (C (D)))) */ ;
    defparam i2691_4_lut.init = 16'hfac8;
    CCU2D add_185_27 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4883), .COUT(n4884), .S0(n393), 
          .S1(n392));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_27.INIT0 = 16'h5aaa;
    defparam add_185_27.INIT1 = 16'h5aaa;
    defparam add_185_27.INJECT1_0 = "NO";
    defparam add_185_27.INJECT1_1 = "NO";
    CCU2D add_167_13 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4844), .COUT(n4845), .S0(n195), 
          .S1(n194));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_13.INIT0 = 16'h5aaa;
    defparam add_167_13.INIT1 = 16'h5aaa;
    defparam add_167_13.INJECT1_0 = "NO";
    defparam add_167_13.INJECT1_1 = "NO";
    CCU2D add_167_11 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4843), .COUT(n4844), .S0(n197), 
          .S1(n196));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_11.INIT0 = 16'h5aaa;
    defparam add_167_11.INIT1 = 16'h5aaa;
    defparam add_167_11.INJECT1_0 = "NO";
    defparam add_167_11.INJECT1_1 = "NO";
    LUT4 i2_2_lut (.A(FlexMIOs35_out), .B(S3C_S1_c), .Z(n66)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i2_2_lut.init = 16'h8888;
    FD1P3IX counter_i0_i7 (.D(n1793), .SP(clk_enable_142), .CD(n3688), 
            .CK(clk), .Q(counter[7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i7.GSR = "ENABLED";
    FD1P3IX counter_i0_i6 (.D(n2600), .SP(clk_enable_142), .CD(n3695), 
            .CK(clk), .Q(counter[6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i6.GSR = "ENABLED";
    LUT4 signals_debounced_syn_3__bdd_4_lut (.A(signals_debounced_syn[3]), 
         .B(next_state_3__N_542[2]), .C(next_state[2]), .D(next_state[3]), 
         .Z(n5865)) /* synthesis lut_function=(!(A (B (D)+!B (C))+!A (B (C+(D))+!B (C)))) */ ;
    defparam signals_debounced_syn_3__bdd_4_lut.init = 16'h038f;
    LUT4 i2775_4_lut_4_lut (.A(n5667), .B(n3659), .C(n5688), .D(n5678), 
         .Z(clk_enable_86)) /* synthesis lut_function=(!(A+(B (C)+!B (C+!(D))))) */ ;
    defparam i2775_4_lut_4_lut.init = 16'h0504;
    FD1P3IX counter_i0_i5 (.D(n1795), .SP(clk_enable_142), .CD(n3688), 
            .CK(clk), .Q(counter[5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i5.GSR = "ENABLED";
    LUT4 externstop_falling_bdd_4_lut (.A(next_state_3__N_542[2]), .B(next_state[1]), 
         .C(next_state[2]), .D(next_state[3]), .Z(n5864)) /* synthesis lut_function=(!(A (B (D)+!B (C+!(D)))+!A ((C (D))+!B))) */ ;
    defparam externstop_falling_bdd_4_lut.init = 16'h06cc;
    LUT4 n5562_bdd_3_lut_4_lut (.A(n5558), .B(next_state[3]), .C(next_state[2]), 
         .D(n5562), .Z(n5563)) /* synthesis lut_function=(A (C+(D))+!A (B (C+(D))+!B !(C+!(D)))) */ ;
    defparam n5562_bdd_3_lut_4_lut.init = 16'hefe0;
    CCU2D add_185_25 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4882), .COUT(n4883), .S0(n395), 
          .S1(n394));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_25.INIT0 = 16'h5aaa;
    defparam add_185_25.INIT1 = 16'h5aaa;
    defparam add_185_25.INJECT1_0 = "NO";
    defparam add_185_25.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_1___i0 (.D(n206), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i0.GSR = "ENABLED";
    LUT4 i17_4_lut (.A(counter[2]), .B(counter[13]), .C(counter[9]), .D(counter[18]), 
         .Z(n42)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i17_4_lut.init = 16'hfffe;
    CCU2D add_167_33 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4854), .S0(n175));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_33.INIT0 = 16'h5aaa;
    defparam add_167_33.INIT1 = 16'h0000;
    defparam add_167_33.INJECT1_0 = "NO";
    defparam add_167_33.INJECT1_1 = "NO";
    CCU2D add_167_9 (.A0(\debounce_counters[1] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4842), .COUT(n4843), .S0(n199), 
          .S1(n198));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_9.INIT0 = 16'h5aaa;
    defparam add_167_9.INIT1 = 16'h5aaa;
    defparam add_167_9.INJECT1_0 = "NO";
    defparam add_167_9.INJECT1_1 = "NO";
    LUT4 i2725_4_lut_4_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_542[2]), 
         .C(next_state[1]), .D(n5669), .Z(n5344)) /* synthesis lut_function=(A (B+(C))+!A !(B ((D)+!C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i2725_4_lut_4_lut_4_lut.init = 16'ha9f9;
    CCU2D add_167_31 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4853), .COUT(n4854), .S0(n177), 
          .S1(n176));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_31.INIT0 = 16'h5aaa;
    defparam add_167_31.INIT1 = 16'h5aaa;
    defparam add_167_31.INJECT1_0 = "NO";
    defparam add_167_31.INJECT1_1 = "NO";
    CCU2D add_438_11 (.A0(counter[9]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[10]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4943), .COUT(n4944), .S0(n1791), .S1(n1790));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[17:24])
    defparam add_438_11.INIT0 = 16'h5555;
    defparam add_438_11.INIT1 = 16'h5555;
    defparam add_438_11.INJECT1_0 = "NO";
    defparam add_438_11.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_2___i0 (.D(n312), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i0.GSR = "ENABLED";
    LUT4 i1_2_lut_rep_76 (.A(next_state[3]), .B(next_state[2]), .Z(n5678)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_rep_76.init = 16'heeee;
    FD1S3AY debounce_inputs_asyn2_i1 (.D(debounce_inputs_asyn1[1]), .CK(clk), 
            .Q(debounce_inputs_asyn2[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_inputs_asyn2_i1.GSR = "ENABLED";
    CCU2D add_167_29 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4852), .COUT(n4853), .S0(n179), 
          .S1(n178));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_29.INIT0 = 16'h5aaa;
    defparam add_167_29.INIT1 = 16'h5aaa;
    defparam add_167_29.INJECT1_0 = "NO";
    defparam add_167_29.INJECT1_1 = "NO";
    FD1P3IX pushed_i1 (.D(n5901), .SP(clk_enable_6), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(pushed[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam pushed_i1.GSR = "ENABLED";
    FD1S3AY signals_debounced_syn_i1 (.D(pushed_1__N_294), .CK(clk), .Q(next_state_3__N_542[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam signals_debounced_syn_i1.GSR = "ENABLED";
    CCU2D add_438_9 (.A0(counter[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[8]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4942), .COUT(n4943), .S0(n1793), .S1(n1792));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[17:24])
    defparam add_438_9.INIT0 = 16'h5555;
    defparam add_438_9.INIT1 = 16'h5555;
    defparam add_438_9.INJECT1_0 = "NO";
    defparam add_438_9.INJECT1_1 = "NO";
    LUT4 i7_2_lut (.A(counter[16]), .B(counter[21]), .Z(n32)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i7_2_lut.init = 16'heeee;
    FD1S3AX externstop_falling_390 (.D(externstop_falling_N_764), .CK(clk), 
            .Q(externstop_falling));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam externstop_falling_390.GSR = "ENABLED";
    FD1S3AX externstop_last_391 (.D(signals_debounced_syn[2]), .CK(clk), 
            .Q(externstop_last));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam externstop_last_391.GSR = "ENABLED";
    FD1P3AX forceoutputdisable_393 (.D(forceoutputdisable_N_8), .SP(clk_enable_7), 
            .CK(clk), .Q(forceoutputdisable));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam forceoutputdisable_393.GSR = "ENABLED";
    LUT4 i1512_2_lut (.A(n1779), .B(n2684), .Z(n2519)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i1512_2_lut.init = 16'heeee;
    LUT4 mux_623_i18_4_lut (.A(next_state[1]), .B(n1783), .C(n2688), .D(n2684), 
         .Z(n2589)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_623_i18_4_lut.init = 16'hf5c5;
    LUT4 next_state_1__bdd_4_lut_2894 (.A(next_state[1]), .B(next_state[0]), 
         .C(next_state[3]), .D(next_state[2]), .Z(clk_enable_133)) /* synthesis lut_function=(A+(B ((D)+!C)+!B (C+!(D)))) */ ;
    defparam next_state_1__bdd_4_lut_2894.init = 16'hfebf;
    FD1P3IX counter_i0_i4 (.D(n1796), .SP(clk_enable_142), .CD(n3688), 
            .CK(clk), .Q(counter[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i4.GSR = "ENABLED";
    CCU2D add_167_27 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4851), .COUT(n4852), .S0(n181), 
          .S1(n180));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_27.INIT0 = 16'h5aaa;
    defparam add_167_27.INIT1 = 16'h5aaa;
    defparam add_167_27.INJECT1_0 = "NO";
    defparam add_167_27.INJECT1_1 = "NO";
    CCU2D add_185_23 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4881), .COUT(n4882), .S0(n397), 
          .S1(n396));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_23.INIT0 = 16'h5aaa;
    defparam add_185_23.INIT1 = 16'h5aaa;
    defparam add_185_23.INJECT1_0 = "NO";
    defparam add_185_23.INJECT1_1 = "NO";
    CCU2D add_438_7 (.A0(counter[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4941), .COUT(n4942), .S0(n1795), .S1(n1794));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[17:24])
    defparam add_438_7.INIT0 = 16'h5555;
    defparam add_438_7.INIT1 = 16'h5555;
    defparam add_438_7.INJECT1_0 = "NO";
    defparam add_438_7.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i3 (.D(n1797), .SP(clk_enable_142), .CD(n3688), 
            .CK(clk), .Q(counter[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i3.GSR = "ENABLED";
    CCU2D add_167_7 (.A0(\debounce_counters[1] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4841), .COUT(n4842), .S0(n201), 
          .S1(n200));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_7.INIT0 = 16'h5aaa;
    defparam add_167_7.INIT1 = 16'h5aaa;
    defparam add_167_7.INJECT1_0 = "NO";
    defparam add_167_7.INJECT1_1 = "NO";
    CCU2D add_176_27 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4867), .COUT(n4868), .S0(n287), 
          .S1(n286));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_27.INIT0 = 16'h5aaa;
    defparam add_176_27.INIT1 = 16'h5aaa;
    defparam add_176_27.INJECT1_0 = "NO";
    defparam add_176_27.INJECT1_1 = "NO";
    LUT4 i1_4_lut_else_4_lut (.A(next_state[2]), .B(n5671), .C(next_state[3]), 
         .D(next_state[0]), .Z(n5686)) /* synthesis lut_function=(!(A+(((D)+!C)+!B))) */ ;
    defparam i1_4_lut_else_4_lut.init = 16'h0040;
    FD1P3IX counter_i0_i2 (.D(n1798), .SP(clk_enable_142), .CD(n3688), 
            .CK(clk), .Q(counter[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i2.GSR = "ENABLED";
    CCU2D add_2355_10 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4906), .COUT(n4907));
    defparam add_2355_10.INIT0 = 16'h5555;
    defparam add_2355_10.INIT1 = 16'h5555;
    defparam add_2355_10.INJECT1_0 = "NO";
    defparam add_2355_10.INJECT1_1 = "NO";
    CCU2D add_438_5 (.A0(counter[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4940), .COUT(n4941), .S0(n1797), .S1(n1796));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[17:24])
    defparam add_438_5.INIT0 = 16'h5555;
    defparam add_438_5.INIT1 = 16'h5555;
    defparam add_438_5.INJECT1_0 = "NO";
    defparam add_438_5.INJECT1_1 = "NO";
    CCU2D add_185_21 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4880), .COUT(n4881), .S0(n399), 
          .S1(n398));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_21.INIT0 = 16'h5aaa;
    defparam add_185_21.INIT1 = 16'h5aaa;
    defparam add_185_21.INJECT1_0 = "NO";
    defparam add_185_21.INJECT1_1 = "NO";
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk)) /* synthesis NOM_FREQ="2.08", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "2.08";
    LUT4 i1492_3_lut_3_lut (.A(n5031), .B(n3460), .C(n5338), .Z(FP_UsrLED_c_3)) /* synthesis lut_function=((B+!(C))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(248[12:28])
    defparam i1492_3_lut_3_lut.init = 16'hdfdf;
    LUT4 i1_3_lut_3_lut (.A(next_state[1]), .B(n5669), .C(next_state_3__N_542[2]), 
         .Z(n3659)) /* synthesis lut_function=(!(A (B)+!A (C))) */ ;
    defparam i1_3_lut_3_lut.init = 16'h2727;
    BB FPIO_FlexMIO28_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO28), 
       .O(FPIO_FlexMIO28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    LUT4 i1572_2_lut_3_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[1]), 
         .Z(FPIO_isoCtrlRSTn_N_740)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;
    defparam i1572_2_lut_3_lut.init = 16'h1010;
    LUT4 i1_4_lut_4_lut (.A(next_state[3]), .B(next_state[2]), .C(n5679), 
         .D(n17_adj_16), .Z(clk_enable_129)) /* synthesis lut_function=(A (B+(C))+!A (B (C)+!B (D))) */ ;
    defparam i1_4_lut_4_lut.init = 16'hf9e8;
    CCU2D add_176_25 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4866), .COUT(n4867), .S0(n289), 
          .S1(n288));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_25.INIT0 = 16'h5aaa;
    defparam add_176_25.INIT1 = 16'h5aaa;
    defparam add_176_25.INJECT1_0 = "NO";
    defparam add_176_25.INJECT1_1 = "NO";
    FD1P3AX DIGS3C_Shared_ReqSafeState_394 (.D(DIGS3C_Shared_ReqSafeState_N_752), 
            .SP(clk_enable_11), .CK(clk), .Q(DIGS3C_Shared_ReqSafeState_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam DIGS3C_Shared_ReqSafeState_394.GSR = "ENABLED";
    CCU2D add_176_23 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4865), .COUT(n4866), .S0(n291), 
          .S1(n290));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_23.INIT0 = 16'h5aaa;
    defparam add_176_23.INIT1 = 16'h5aaa;
    defparam add_176_23.INJECT1_0 = "NO";
    defparam add_176_23.INJECT1_1 = "NO";
    FD1P3AX FP_SysLEDb_397 (.D(FP_SysLEDb_N_739), .SP(clk_enable_13), .CK(clk), 
            .Q(FP_SysLEDb_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam FP_SysLEDb_397.GSR = "ENABLED";
    FD1P3AX FP_SysLEDg_398 (.D(FP_SysLEDg_N_737), .SP(clk_enable_13), .CK(clk), 
            .Q(FP_SysLEDg_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam FP_SysLEDg_398.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn1_i1 (.D(SysSW_Pwr_NC_c), .CK(clk), .Q(debounce_inputs_asyn1[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_inputs_asyn1_i1.GSR = "ENABLED";
    FD1P3AX Carrier_PwrOn_400 (.D(Carrier_PwrOn_N_757), .SP(clk_enable_15), 
            .CK(clk), .Q(Carrier_PwrOn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam Carrier_PwrOn_400.GSR = "ENABLED";
    FD1P3AX Carrier_PG_3V3_401 (.D(Carrier_PwrOn_N_757), .SP(clk_enable_15), 
            .CK(clk), .Q(Carrier_PG_3V3_c)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam Carrier_PG_3V3_401.GSR = "ENABLED";
    FD1P3AX FP_SysLEDs_405 (.D(FP_SysLEDs_N_751), .SP(clk_enable_16), .CK(clk), 
            .Q(FP_SysLEDs_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam FP_SysLEDs_405.GSR = "ENABLED";
    LUT4 n5669_bdd_4_lut_2971 (.A(next_state[2]), .B(next_state[3]), .C(extern_connected), 
         .D(signals_debounced_syn[2]), .Z(n5821)) /* synthesis lut_function=(!(A (B)+!A (B+((D)+!C)))) */ ;
    defparam n5669_bdd_4_lut_2971.init = 16'h2232;
    FD1P3AX i376_407 (.D(Carrier_PG_1V8_N_838), .SP(Carrier_PG_1V8_N_831), 
            .CK(clk), .Q(Carrier_PG_1V8_N_750));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam i376_407.GSR = "ENABLED";
    PFUMX i55 (.BLUT(n33_adj_2), .ALUT(n27), .C0(n5342), .Z(next_state_3__N_61[2]));
    LUT4 i1453_3_lut (.A(n1785), .B(n2688), .C(n2684), .Z(n2591)) /* synthesis lut_function=(!(A (B (C))+!A (B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i1453_3_lut.init = 16'h3b3b;
    CCU2D add_185_19 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4879), .COUT(n4880), .S0(n401), 
          .S1(n400));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_19.INIT0 = 16'h5aaa;
    defparam add_185_19.INIT1 = 16'h5aaa;
    defparam add_185_19.INJECT1_0 = "NO";
    defparam add_185_19.INJECT1_1 = "NO";
    CCU2D add_167_5 (.A0(\debounce_counters[1] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4840), .COUT(n4841), .S0(n203), 
          .S1(n202));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_5.INIT0 = 16'h5aaa;
    defparam add_167_5.INIT1 = 16'h5aaa;
    defparam add_167_5.INJECT1_0 = "NO";
    defparam add_167_5.INJECT1_1 = "NO";
    CCU2D add_185_17 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4878), .COUT(n4879), .S0(n403), 
          .S1(n402));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_17.INIT0 = 16'h5aaa;
    defparam add_185_17.INIT1 = 16'h5aaa;
    defparam add_185_17.INJECT1_0 = "NO";
    defparam add_185_17.INJECT1_1 = "NO";
    LUT4 i18_4_lut (.A(counter[0]), .B(counter[14]), .C(counter[10]), 
         .D(counter[19]), .Z(n43)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i18_4_lut.init = 16'hfffe;
    FD1P3IX counter_i0_i1 (.D(n1799), .SP(clk_enable_142), .CD(n3688), 
            .CK(clk), .Q(counter[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i1.GSR = "ENABLED";
    LUT4 i2_2_lut_rep_69_3_lut (.A(signals_debounced_syn[4]), .B(externstop_falling), 
         .C(next_state_3__N_542[2]), .Z(n5671)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(408[5] 416[12])
    defparam i2_2_lut_rep_69_3_lut.init = 16'h2020;
    FD1S3AY signals_debounced_syn_i4 (.D(pushed_4__N_288), .CK(clk), .Q(signals_debounced_syn[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam signals_debounced_syn_i4.GSR = "ENABLED";
    CCU2D add_2355_8 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4905), .COUT(n4906));
    defparam add_2355_8.INIT0 = 16'h5555;
    defparam add_2355_8.INIT1 = 16'h5aaa;
    defparam add_2355_8.INJECT1_0 = "NO";
    defparam add_2355_8.INJECT1_1 = "NO";
    CCU2D add_167_3 (.A0(\debounce_counters[1] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4839), .COUT(n4840), .S0(n205), 
          .S1(n204));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_3.INIT0 = 16'h5aaa;
    defparam add_167_3.INIT1 = 16'h5aaa;
    defparam add_167_3.INJECT1_0 = "NO";
    defparam add_167_3.INJECT1_1 = "NO";
    CCU2D add_167_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[1] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n4839), .S1(n206));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_1.INIT0 = 16'hF000;
    defparam add_167_1.INIT1 = 16'h5555;
    defparam add_167_1.INJECT1_0 = "NO";
    defparam add_167_1.INJECT1_1 = "NO";
    CCU2D add_2355_6 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4904), .COUT(n4905));
    defparam add_2355_6.INIT0 = 16'h5555;
    defparam add_2355_6.INIT1 = 16'h5aaa;
    defparam add_2355_6.INJECT1_0 = "NO";
    defparam add_2355_6.INJECT1_1 = "NO";
    CCU2D add_2355_4 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4903), .COUT(n4904));
    defparam add_2355_4.INIT0 = 16'h5555;
    defparam add_2355_4.INIT1 = 16'h5555;
    defparam add_2355_4.INJECT1_0 = "NO";
    defparam add_2355_4.INJECT1_1 = "NO";
    PFUMX i2836 (.BLUT(n5553), .ALUT(n5552), .C0(next_state[3]), .Z(n2684));
    LUT4 i12_2_lut (.A(counter[7]), .B(counter[12]), .Z(n37)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i12_2_lut.init = 16'heeee;
    LUT4 i1_2_lut_rep_77 (.A(next_state[0]), .B(next_state[1]), .Z(n5679)) /* synthesis lut_function=(A (B)) */ ;
    defparam i1_2_lut_rep_77.init = 16'h8888;
    CCU2D add_438_3 (.A0(counter[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4939), .COUT(n4940), .S0(n1799), .S1(n1798));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[17:24])
    defparam add_438_3.INIT0 = 16'h5555;
    defparam add_438_3.INIT1 = 16'h5555;
    defparam add_438_3.INJECT1_0 = "NO";
    defparam add_438_3.INJECT1_1 = "NO";
    CCU2D add_2355_2 (.A0(\debounce_counters[3] [7]), .B0(\debounce_counters[3] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[3] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n4903));
    defparam add_2355_2.INIT0 = 16'h1000;
    defparam add_2355_2.INIT1 = 16'h5aaa;
    defparam add_2355_2.INJECT1_0 = "NO";
    defparam add_2355_2.INJECT1_1 = "NO";
    CCU2D add_438_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n4939), .S1(n1800));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[17:24])
    defparam add_438_1.INIT0 = 16'hF000;
    defparam add_438_1.INIT1 = 16'h5555;
    defparam add_438_1.INJECT1_0 = "NO";
    defparam add_438_1.INJECT1_1 = "NO";
    CCU2D add_2356_26 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4938), .S1(clk_enable_20));
    defparam add_2356_26.INIT0 = 16'hf555;
    defparam add_2356_26.INIT1 = 16'h0000;
    defparam add_2356_26.INJECT1_0 = "NO";
    defparam add_2356_26.INJECT1_1 = "NO";
    FD1S3AX resetcounter_i24_787__i0 (.D(n130), .CK(clk), .Q(resetcounter[0])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i0.GSR = "ENABLED";
    FD1S3AY signals_debounced_syn_i3 (.D(pushed_3__N_290), .CK(clk), .Q(signals_debounced_syn[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam signals_debounced_syn_i3.GSR = "ENABLED";
    FD1S3AY signals_debounced_syn_i2 (.D(pushed_2__N_292), .CK(clk), .Q(signals_debounced_syn[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam signals_debounced_syn_i2.GSR = "ENABLED";
    FD1P3IX pushed_i4 (.D(n5901), .SP(clk_enable_18), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(pushed[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam pushed_i4.GSR = "ENABLED";
    FD1P3IX pushed_i3 (.D(n5901), .SP(clk_enable_19), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(pushed[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam pushed_i3.GSR = "ENABLED";
    FD1P3IX pushed_i2 (.D(n5901), .SP(clk_enable_20), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(pushed[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam pushed_i2.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn2_i4 (.D(debounce_inputs_asyn1[4]), .CK(clk), 
            .Q(debounce_inputs_asyn2[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_inputs_asyn2_i4.GSR = "ENABLED";
    CCU2D add_2356_24 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4937), .COUT(n4938));
    defparam add_2356_24.INIT0 = 16'h5555;
    defparam add_2356_24.INIT1 = 16'h5555;
    defparam add_2356_24.INJECT1_0 = "NO";
    defparam add_2356_24.INJECT1_1 = "NO";
    FD1S3AY debounce_inputs_asyn2_i3 (.D(debounce_inputs_asyn1[3]), .CK(clk), 
            .Q(debounce_inputs_asyn2[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_inputs_asyn2_i3.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn2_i2 (.D(debounce_inputs_asyn1[2]), .CK(clk), 
            .Q(debounce_inputs_asyn2[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_inputs_asyn2_i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i31 (.D(n281), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i31.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i30 (.D(n282), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i29 (.D(n283), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i28 (.D(n284), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i27 (.D(n285), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i26 (.D(n286), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i25 (.D(n287), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i24 (.D(n288), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i23 (.D(n289), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i22 (.D(n290), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i21 (.D(n291), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i20 (.D(n292), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i19 (.D(n293), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i19.GSR = "ENABLED";
    CCU2D add_194_33 (.A0(\debounce_counters[4] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4902), .S0(n493));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_33.INIT0 = 16'h5aaa;
    defparam add_194_33.INIT1 = 16'h0000;
    defparam add_194_33.INJECT1_0 = "NO";
    defparam add_194_33.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_2___i18 (.D(n294), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i17 (.D(n295), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i17.GSR = "ENABLED";
    CCU2D add_176_21 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4864), .COUT(n4865), .S0(n293), 
          .S1(n292));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_21.INIT0 = 16'h5aaa;
    defparam add_176_21.INIT1 = 16'h5aaa;
    defparam add_176_21.INJECT1_0 = "NO";
    defparam add_176_21.INJECT1_1 = "NO";
    CCU2D add_185_15 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4877), .COUT(n4878), .S0(n405), 
          .S1(n404));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_15.INIT0 = 16'h5aaa;
    defparam add_185_15.INIT1 = 16'h5aaa;
    defparam add_185_15.INJECT1_0 = "NO";
    defparam add_185_15.INJECT1_1 = "NO";
    CCU2D add_176_19 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4863), .COUT(n4864), .S0(n295), 
          .S1(n294));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_19.INIT0 = 16'h5aaa;
    defparam add_176_19.INIT1 = 16'h5aaa;
    defparam add_176_19.INJECT1_0 = "NO";
    defparam add_176_19.INJECT1_1 = "NO";
    CCU2D add_176_17 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4862), .COUT(n4863), .S0(n297), 
          .S1(n296));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_17.INIT0 = 16'h5aaa;
    defparam add_176_17.INIT1 = 16'h5aaa;
    defparam add_176_17.INJECT1_0 = "NO";
    defparam add_176_17.INJECT1_1 = "NO";
    LUT4 i1_4_lut (.A(next_state[2]), .B(next_state[3]), .C(n29), .D(n5697), 
         .Z(n2688)) /* synthesis lut_function=(!(A (B+!(D))+!A !(B (C)+!B (C+(D))))) */ ;
    defparam i1_4_lut.init = 16'h7350;
    FD1P3IX debounce_counters_2___i16 (.D(n296), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i15 (.D(n297), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i0 (.D(n418), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i0.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i14 (.D(n298), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i13 (.D(n299), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i12 (.D(n300), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i11 (.D(n301), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i10 (.D(n302), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i9 (.D(n303), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i8 (.D(n304), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i7 (.D(n305), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i6 (.D(n306), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i5 (.D(n307), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i4 (.D(n308), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i3 (.D(n309), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i2 (.D(n310), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i1 (.D(n311), .SP(clk_enable_52), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_2___i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i31 (.D(n175), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i31.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i30 (.D(n176), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i29 (.D(n177), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i28 (.D(n178), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i27 (.D(n179), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i26 (.D(n180), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i25 (.D(n181), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i24 (.D(n182), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i23 (.D(n183), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i22 (.D(n184), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i21 (.D(n185), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i20 (.D(n186), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i19 (.D(n187), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i18 (.D(n188), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i17 (.D(n189), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i16 (.D(n190), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i15 (.D(n191), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i14 (.D(n192), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i13 (.D(n193), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i12 (.D(n194), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i11 (.D(n195), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i10 (.D(n196), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i9 (.D(n197), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i8 (.D(n198), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i7 (.D(n199), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i6 (.D(n200), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i5 (.D(n201), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i4 (.D(n202), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i3 (.D(n203), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i2 (.D(n204), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i1 (.D(n205), .SP(clk_enable_83), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_1___i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i31 (.D(n493), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i31.GSR = "ENABLED";
    CCU2D add_2356_22 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4936), .COUT(n4937));
    defparam add_2356_22.INIT0 = 16'h5555;
    defparam add_2356_22.INIT1 = 16'h5555;
    defparam add_2356_22.INJECT1_0 = "NO";
    defparam add_2356_22.INJECT1_1 = "NO";
    CCU2D add_185_13 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4876), .COUT(n4877), .S0(n407), 
          .S1(n406));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_13.INIT0 = 16'h5aaa;
    defparam add_185_13.INIT1 = 16'h5aaa;
    defparam add_185_13.INJECT1_0 = "NO";
    defparam add_185_13.INJECT1_1 = "NO";
    CCU2D add_194_31 (.A0(\debounce_counters[4] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4901), .COUT(n4902), .S0(n495), 
          .S1(n494));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_31.INIT0 = 16'h5aaa;
    defparam add_194_31.INIT1 = 16'h5aaa;
    defparam add_194_31.INJECT1_0 = "NO";
    defparam add_194_31.INJECT1_1 = "NO";
    LUT4 i13_3_lut (.A(counter[8]), .B(counter[5]), .C(counter[6]), .Z(n38)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i13_3_lut.init = 16'hfefe;
    CCU2D add_194_29 (.A0(\debounce_counters[4] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4900), .COUT(n4901), .S0(n497), 
          .S1(n496));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_29.INIT0 = 16'h5aaa;
    defparam add_194_29.INIT1 = 16'h5aaa;
    defparam add_194_29.INJECT1_0 = "NO";
    defparam add_194_29.INJECT1_1 = "NO";
    CCU2D add_2356_20 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4935), .COUT(n4936));
    defparam add_2356_20.INIT0 = 16'h5555;
    defparam add_2356_20.INIT1 = 16'h5555;
    defparam add_2356_20.INJECT1_0 = "NO";
    defparam add_2356_20.INJECT1_1 = "NO";
    FD1P3AX next_state_i3 (.D(next_state_3__N_61[3]), .SP(clk_enable_85), 
            .CK(clk), .Q(next_state[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam next_state_i3.GSR = "ENABLED";
    CCU2D add_185_11 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4875), .COUT(n4876), .S0(n409), 
          .S1(n408));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_11.INIT0 = 16'h5aaa;
    defparam add_185_11.INIT1 = 16'h5aaa;
    defparam add_185_11.INJECT1_0 = "NO";
    defparam add_185_11.INJECT1_1 = "NO";
    FD1P3AX next_state_i2 (.D(next_state_3__N_61[2]), .SP(clk_enable_86), 
            .CK(clk), .Q(next_state[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam next_state_i2.GSR = "ENABLED";
    CCU2D add_194_27 (.A0(\debounce_counters[4] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4899), .COUT(n4900), .S0(n499), 
          .S1(n498));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_27.INIT0 = 16'h5aaa;
    defparam add_194_27.INIT1 = 16'h5aaa;
    defparam add_194_27.INJECT1_0 = "NO";
    defparam add_194_27.INJECT1_1 = "NO";
    CCU2D add_176_15 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4861), .COUT(n4862), .S0(n299), 
          .S1(n298));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_15.INIT0 = 16'h5aaa;
    defparam add_176_15.INIT1 = 16'h5aaa;
    defparam add_176_15.INJECT1_0 = "NO";
    defparam add_176_15.INJECT1_1 = "NO";
    CCU2D add_185_9 (.A0(\debounce_counters[3] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4874), .COUT(n4875), .S0(n411), 
          .S1(n410));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_9.INIT0 = 16'h5aaa;
    defparam add_185_9.INIT1 = 16'h5aaa;
    defparam add_185_9.INJECT1_0 = "NO";
    defparam add_185_9.INJECT1_1 = "NO";
    CCU2D add_176_13 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4860), .COUT(n4861), .S0(n301), 
          .S1(n300));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_13.INIT0 = 16'h5aaa;
    defparam add_176_13.INIT1 = 16'h5aaa;
    defparam add_176_13.INJECT1_0 = "NO";
    defparam add_176_13.INJECT1_1 = "NO";
    CCU2D add_2356_18 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4934), .COUT(n4935));
    defparam add_2356_18.INIT0 = 16'h5555;
    defparam add_2356_18.INIT1 = 16'h5555;
    defparam add_2356_18.INJECT1_0 = "NO";
    defparam add_2356_18.INJECT1_1 = "NO";
    FD1P3AX next_state_i1 (.D(next_state_3__N_61[1]), .SP(clk_enable_87), 
            .CK(clk), .Q(next_state[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam next_state_i1.GSR = "ENABLED";
    FD1P3IX counter_i0_i0 (.D(n1800), .SP(clk_enable_142), .CD(n3688), 
            .CK(clk), .Q(counter[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i0.GSR = "ENABLED";
    FD1P3AX extern_connected_406 (.D(n5901), .SP(clk_enable_89), .CK(clk), 
            .Q(extern_connected)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam extern_connected_406.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i30 (.D(n494), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i29 (.D(n495), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i28 (.D(n496), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i27 (.D(n497), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i26 (.D(n498), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i25 (.D(n499), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i24 (.D(n500), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i23 (.D(n501), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i22 (.D(n502), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i21 (.D(n503), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i21.GSR = "ENABLED";
    LUT4 i1506_2_lut (.A(n1786), .B(n2684), .Z(n2526)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i1506_2_lut.init = 16'heeee;
    PFUMX i35 (.BLUT(n23), .ALUT(n19), .C0(next_state[1]), .Z(n17));
    FD1P3IX debounce_counters_4___i20 (.D(n504), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i19 (.D(n505), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i18 (.D(n506), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i17 (.D(n507), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i16 (.D(n508), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i15 (.D(n509), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i14 (.D(n510), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i13 (.D(n511), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i12 (.D(n512), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i11 (.D(n513), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i10 (.D(n514), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i10.GSR = "ENABLED";
    CCU2D add_176_11 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4859), .COUT(n4860), .S0(n303), 
          .S1(n302));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_11.INIT0 = 16'h5aaa;
    defparam add_176_11.INIT1 = 16'h5aaa;
    defparam add_176_11.INJECT1_0 = "NO";
    defparam add_176_11.INJECT1_1 = "NO";
    BB FPIO_FlexMIO27_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO27), 
       .O(FPIO_FlexMIO27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    FD1P3IX debounce_counters_4___i9 (.D(n515), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i9.GSR = "ENABLED";
    BB FPIO_FlexMIO30_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO30), 
       .O(FPIO_FlexMIO30_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    FD1P3IX debounce_counters_4___i8 (.D(n516), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i8.GSR = "ENABLED";
    BB FPIO_FlexMIO29_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO29), 
       .O(FPIO_FlexMIO29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    FD1P3IX debounce_counters_4___i7 (.D(n517), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i7.GSR = "ENABLED";
    BB DIG5S3C26_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C26), .O(DIG5S3C26_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    FD1P3IX debounce_counters_4___i6 (.D(n518), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i6.GSR = "ENABLED";
    BB DIG5S3C25_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C25), .O(DIG5S3C25_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    FD1P3IX debounce_counters_4___i5 (.D(n519), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i5.GSR = "ENABLED";
    BB DIG5S3C24_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C24), .O(DIG5S3C24_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    FD1P3IX debounce_counters_4___i4 (.D(n520), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i4.GSR = "ENABLED";
    BB FlexMIOs54_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs54), .O(FlexMIOs54_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    FD1P3IX debounce_counters_4___i3 (.D(n521), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i3.GSR = "ENABLED";
    BB FlexMIOs62_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs62), .O(FlexMIOs62_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    FD1P3IX debounce_counters_4___i2 (.D(n522), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i2.GSR = "ENABLED";
    BB FlexMIOs63_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs63), .O(FlexMIOs63_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    FD1P3IX debounce_counters_4___i1 (.D(n523), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i1.GSR = "ENABLED";
    BB FlexMIOs31_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs31), .O(FlexMIOs31_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    LUT4 i58_4_lut (.A(next_state[1]), .B(n2921), .C(next_state[3]), .D(n5669), 
         .Z(n29)) /* synthesis lut_function=(!(A (C+!(D))+!A (B+!(C)))) */ ;
    defparam i58_4_lut.init = 16'h1a10;
    BB FlexMIOs30_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs30), .O(FlexMIOs30_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB FlexMIOs29_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs29), .O(FlexMIOs29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB FlexMIOs28_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs28), .O(FlexMIOs28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB FlexMIOs27_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs27), .O(FlexMIOs27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB FlexMIOs26_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs26), .O(FlexMIOs26_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB FlexMIOs37_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs37), .O(FlexMIOs37_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB FlexMIOs36_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs36), .O(FlexMIOs36_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB FlexMIOs35_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs35), .O(FlexMIOs35_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB FlexMIOs34_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs34), .O(FlexMIOs34_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB FlexMIOs33_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs33), .O(FlexMIOs33_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB FlexMIOs32_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs32), .O(FlexMIOs32_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB DIG5S3C03_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C03), .O(DIG5S3C03_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB DIG5S3C04_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C04), .O(DIG5S3C04_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB DIG5S3C05_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C05), .O(DIG5S3C05_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB DIG5S3C00_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C00), .O(DIG5S3C00_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB DIG5S3C02_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C02), .O(DIG5S3C02_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB DIG5S3C01_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C01), .O(DIG5S3C01_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB DIG5S3C29_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C29), .O(DIG5S3C29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB DIG5S3C28_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C28), .O(DIG5S3C28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    BB DIG5S3C27_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C27), .O(DIG5S3C27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(192[1:17])
    OB FP_SysLEDg_pad (.I(FP_SysLEDg_c), .O(FP_SysLEDg));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(12[3:13])
    OB FP_SysLEDr_pad (.I(FP_SysLEDr_c), .O(FP_SysLEDr));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(13[3:13])
    OB FP_SysLEDb_pad (.I(FP_SysLEDb_c), .O(FP_SysLEDb));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(14[3:13])
    OB FlexIO05_pad (.I(GND_net), .O(FlexIO05));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(15[3:11])
    OB FlexIO02_pad (.I(GND_net), .O(FlexIO02));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(18[3:11])
    OB FlexIO01_pad (.I(GND_net), .O(FlexIO01));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(19[3:11])
    OB FPIO_isoCtrlRSTn_pad (.I(FPIO_isoCtrlRSTn_c), .O(FPIO_isoCtrlRSTn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(27[3:19])
    OB Carrier_PG_3V3_pad (.I(Carrier_PG_3V3_c), .O(Carrier_PG_3V3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(29[3:17])
    OB FPIO_FlexMIO52_pad (.I(FPIO_FlexMIO52_c_c), .O(FPIO_FlexMIO52));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(35[3:17])
    CCU2D add_194_25 (.A0(\debounce_counters[4] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4898), .COUT(n4899), .S0(n501), 
          .S1(n500));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_25.INIT0 = 16'h5aaa;
    defparam add_194_25.INIT1 = 16'h5aaa;
    defparam add_194_25.INJECT1_0 = "NO";
    defparam add_194_25.INJECT1_1 = "NO";
    OBZ n3244_pad (.I(GND_net), .T(n3245), .O(Carrier_PG_1V8));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(276[1] 457[13])
    OB FP_SysLEDs_pad (.I(FP_SysLEDs_c), .O(FP_SysLEDs));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(40[3:13])
    OB FP_UsrLED_pad_4 (.I(n5668), .O(FP_UsrLED[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(44[3:12])
    OB FP_UsrLED_pad_3 (.I(FP_UsrLED_c_3), .O(FP_UsrLED[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(44[3:12])
    OB FP_UsrLED_pad_2 (.I(FP_UsrLED_c_2), .O(FP_UsrLED[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(44[3:12])
    OB FP_UsrLED_pad_1 (.I(n5668), .O(FP_UsrLED[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(44[3:12])
    OB DIGS3C_Shared_CarrierReady_pad (.I(GND_net), .O(DIGS3C_Shared_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(45[3:29])
    OB DIGS3C_Shared_ReqSafeState_pad (.I(DIGS3C_Shared_ReqSafeState_c), .O(DIGS3C_Shared_ReqSafeState));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(46[3:29])
    OB SD_SEL_pad (.I(GND_net), .O(SD_SEL));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(54[3:9])
    OB FlexMIOs53_GPIO_PowerDown_pad (.I(FlexMIOs53_GPIO_PowerDown_c), .O(FlexMIOs53_GPIO_PowerDown));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(57[3:28])
    OB FlexMio61ExternalStop_pad (.I(FlexMio61ExternalStop_c_c), .O(FlexMio61ExternalStop));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(59[3:24])
    OB ANL_S3C_CarrierReady_pad (.I(GND_net), .O(ANL_S3C_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(88[3:23])
    OB DIGS3C_SlotD_SlotOE_pad_5 (.I(DIGS3C_SlotD_SlotOE_c_5), .O(DIGS3C_SlotD_SlotOE[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(90[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_4 (.I(DIGS3C_SlotD_SlotOE_c_4), .O(DIGS3C_SlotD_SlotOE[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(90[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_3 (.I(DIGS3C_SlotD_SlotOE_c_3), .O(DIGS3C_SlotD_SlotOE[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(90[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_2 (.I(DIGS3C_SlotD_SlotOE_c_2), .O(DIGS3C_SlotD_SlotOE[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(90[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_1 (.I(DIGS3C_SlotD_SlotOE_c_1), .O(DIGS3C_SlotD_SlotOE[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(90[3:22])
    OB Carrier_PwrOn_pad (.I(Carrier_PwrOn_c), .O(Carrier_PwrOn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(93[9:22])
    IB FlexIO04_pad (.I(FlexIO04), .O(FlexIO04_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(16[3:11])
    IB FlexIO03_pad (.I(FlexIO03), .O(FlexIO03_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(17[3:11])
    IB FP_UsrSW1_pad (.I(FP_UsrSW1), .O(FP_UsrSW1_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(20[3:12])
    IB FP_UsrSW2_pad (.I(FP_UsrSW2), .O(FP_UsrSW2_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(21[3:12])
    IB SCL_pad (.I(SCL), .O(SCL_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(23[3:6])
    IB SDA_pad (.I(SDA), .O(SDA_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(24[3:6])
    IB FP_UsrSW3_pad (.I(FP_UsrSW3), .O(FP_UsrSW3_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(25[3:12])
    IB SysSW_Pwr_NC_pad (.I(SysSW_Pwr_NC), .O(SysSW_Pwr_NC_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(26[3:15])
    IB FPIO_iosCtrlINTn_pad (.I(FPIO_iosCtrlINTn), .O(FPIO_iosCtrlINTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(28[3:19])
    IB FlexMio61ExternalStop_c_pad (.I(FPIO_ExternalStop), .O(FlexMio61ExternalStop_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(30[3:20])
    IB S3CsI2C_SDA_pad (.I(S3CsI2C_SDA), .O(S3CsI2C_SDA_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(38[3:14])
    IB S3CsI2C_SCL_pad (.I(S3CsI2C_SCL), .O(S3CsI2C_SCL_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(39[3:14])
    IB SD1_CD_pad (.I(SD1_CD), .O(SD1_CD_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(41[3:9])
    IB SD0_CD_pad (.I(SD0_CD), .O(SD0_CD_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(42[3:9])
    IB SPI_S3C_nCS_USR_pad (.I(SPI_S3C_nCS_USR), .O(SPI_S3C_nCS_USR_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(43[3:18])
    IB DIGS3C_SlotD_ReqOE_pad_5 (.I(DIGS3C_SlotD_ReqOE[5]), .O(DIGS3C_SlotD_ReqOE_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(47[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_4 (.I(DIGS3C_SlotD_ReqOE[4]), .O(DIGS3C_SlotD_ReqOE_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(47[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_3 (.I(DIGS3C_SlotD_ReqOE[3]), .O(DIGS3C_SlotD_ReqOE_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(47[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_2 (.I(DIGS3C_SlotD_ReqOE[2]), .O(DIGS3C_SlotD_ReqOE_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(47[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_1 (.I(DIGS3C_SlotD_ReqOE[1]), .O(DIGS3C_SlotD_ReqOE_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(47[3:21])
    IB DIGS3C_SlotD_SlotOK_pad_5 (.I(DIGS3C_SlotD_SlotOK[5]), .O(DIGS3C_SlotD_SlotOK_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(48[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_4 (.I(DIGS3C_SlotD_SlotOK[4]), .O(DIGS3C_SlotD_SlotOK_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(48[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_3 (.I(DIGS3C_SlotD_SlotOK[3]), .O(DIGS3C_SlotD_SlotOK_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(48[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_2 (.I(DIGS3C_SlotD_SlotOK[2]), .O(DIGS3C_SlotD_SlotOK_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(48[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_1 (.I(DIGS3C_SlotD_SlotOK[1]), .O(DIGS3C_SlotD_SlotOK_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(48[3:22])
    IB FlexLIO_pad_5 (.I(FlexLIO[5]), .O(FlexLIO_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(49[3:10])
    IB FlexLIO_pad_4 (.I(FlexLIO[4]), .O(FlexLIO_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(49[3:10])
    IB FlexLIO_pad_3 (.I(FlexLIO[3]), .O(FlexLIO_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(49[3:10])
    IB FlexLIO_pad_2 (.I(FlexLIO[2]), .O(FlexLIO_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(49[3:10])
    IB FlexLIO_pad_1 (.I(FlexLIO[1]), .O(FlexLIO_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(49[3:10])
    IB FlexLIO_pad_0 (.I(FlexLIO[0]), .O(FlexLIO_c_0));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(49[3:10])
    IB FPIO_FlexMIO52_c_pad (.I(FlexMIOs52_PCIe), .O(FPIO_FlexMIO52_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(56[3:18])
    IB FlexMIOs45_pad (.I(FlexMIOs45), .O(FlexMIOs45_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(68[3:13])
    IB ANL_S3C_SLOTOK_pad_3 (.I(ANL_S3C_SLOTOK[3]), .O(ANL_S3C_SLOTOK_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(87[3:17])
    IB ANL_S3C_SLOTOK_pad_2 (.I(ANL_S3C_SLOTOK[2]), .O(ANL_S3C_SLOTOK_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(87[3:17])
    IB ANL_S3C_SLOTOK_pad_1 (.I(ANL_S3C_SLOTOK[1]), .O(ANL_S3C_SLOTOK_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(87[3:17])
    IB ANL_S3C_P54_Legacy_pad (.I(ANL_S3C_P54_Legacy), .O(ANL_S3C_P54_Legacy_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(89[3:21])
    IB PG_VIN_pad (.I(PG_VIN), .O(PG_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(94[3:9])
    IB PPn_VIN_pad (.I(PPn_VIN), .O(PPn_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(95[3:10])
    IB PG_Module_pad (.I(PG_Module), .O(PG_Module_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(96[3:12])
    IB TDnSHDN_pad (.I(TDnSHDN), .O(TDnSHDN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(97[3:10])
    IB TDnFFnFS_pad (.I(TDnFFnFS), .O(TDnFFnFS_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(98[3:11])
    IB TDnALERT_pad (.I(TDnALERT), .O(TDnALERT_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(99[3:11])
    IB S3C_S1_pad (.I(S3C_S1), .O(S3C_S1_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(100[3:9])
    CCU2D add_2356_16 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4933), .COUT(n4934));
    defparam add_2356_16.INIT0 = 16'h5555;
    defparam add_2356_16.INIT1 = 16'h5555;
    defparam add_2356_16.INJECT1_0 = "NO";
    defparam add_2356_16.INJECT1_1 = "NO";
    FD1S3AY debounce_inputs_asyn1_i2 (.D(FlexMio61ExternalStop_c_c), .CK(clk), 
            .Q(debounce_inputs_asyn1[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_inputs_asyn1_i2.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn1_i3 (.D(FP_UsrSW3_c), .CK(clk), .Q(debounce_inputs_asyn1[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_inputs_asyn1_i3.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn1_i4 (.D(FP_UsrSW1_c), .CK(clk), .Q(debounce_inputs_asyn1[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_inputs_asyn1_i4.GSR = "ENABLED";
    LUT4 i1_2_lut_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), .C(n5681), 
         .D(next_state[1]), .Z(n3622)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam i1_2_lut_3_lut_4_lut.init = 16'h2000;
    CCU2D add_2356_14 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4932), .COUT(n4933));
    defparam add_2356_14.INIT0 = 16'h5555;
    defparam add_2356_14.INIT1 = 16'h5555;
    defparam add_2356_14.INJECT1_0 = "NO";
    defparam add_2356_14.INJECT1_1 = "NO";
    LUT4 i1557_3_lut (.A(next_state[3]), .B(next_state[2]), .C(n6), .Z(DIGS3C_Shared_ReqSafeState_N_752)) /* synthesis lut_function=(!(A (B)+!A !((C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i1557_3_lut.init = 16'h7373;
    LUT4 i1_2_lut_3_lut (.A(next_state[0]), .B(next_state[3]), .C(next_state[2]), 
         .Z(Carrier_PwrOn_N_757)) /* synthesis lut_function=(!((B+(C))+!A)) */ ;
    defparam i1_2_lut_3_lut.init = 16'h0202;
    LUT4 i41_4_lut (.A(FlexLIO_c_3), .B(FlexMIOs26_out), .C(FlexLIO_c_5), 
         .D(FlexMIOs29_out), .Z(n105)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i41_4_lut.init = 16'h8000;
    LUT4 i24_4_lut_rep_67 (.A(n43), .B(n48), .C(n37), .D(n38), .Z(n5669)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i24_4_lut_rep_67.init = 16'hfffe;
    FD1P3AX counter_i0_i8 (.D(n2632), .SP(clk_enable_142), .CK(clk), .Q(counter[8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i8.GSR = "ENABLED";
    FD1P3AX counter_i0_i9 (.D(n2631), .SP(clk_enable_142), .CK(clk), .Q(counter[9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i9.GSR = "ENABLED";
    FD1P3AX counter_i0_i12 (.D(n2628), .SP(clk_enable_142), .CK(clk), 
            .Q(counter[12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i12.GSR = "ENABLED";
    FD1P3AX counter_i0_i18 (.D(n2622), .SP(clk_enable_142), .CK(clk), 
            .Q(counter[18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i18.GSR = "ENABLED";
    FD1P3AX counter_i0_i19 (.D(n2621), .SP(clk_enable_142), .CK(clk), 
            .Q(counter[19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i19.GSR = "ENABLED";
    FD1P3AX counter_i0_i20 (.D(n2620), .SP(clk_enable_142), .CK(clk), 
            .Q(counter[20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i20.GSR = "ENABLED";
    FD1P3AX counter_i0_i22 (.D(n2618), .SP(clk_enable_142), .CK(clk), 
            .Q(counter[22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i22.GSR = "ENABLED";
    FD1P3AX counter_i0_i23 (.D(n2617), .SP(clk_enable_142), .CK(clk), 
            .Q(counter[23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i23.GSR = "ENABLED";
    FD1P3AX counter_i0_i24 (.D(n2616), .SP(clk_enable_142), .CK(clk), 
            .Q(counter[24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i24.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i1 (.D(n129), .CK(clk), .Q(resetcounter[1])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i1.GSR = "ENABLED";
    CCU2D add_194_23 (.A0(\debounce_counters[4] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4897), .COUT(n4898), .S0(n503), 
          .S1(n502));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_23.INIT0 = 16'h5aaa;
    defparam add_194_23.INIT1 = 16'h5aaa;
    defparam add_194_23.INJECT1_0 = "NO";
    defparam add_194_23.INJECT1_1 = "NO";
    CCU2D add_185_7 (.A0(\debounce_counters[3] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4873), .COUT(n4874), .S0(n413), 
          .S1(n412));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_7.INIT0 = 16'h5aaa;
    defparam add_185_7.INIT1 = 16'h5aaa;
    defparam add_185_7.INJECT1_0 = "NO";
    defparam add_185_7.INJECT1_1 = "NO";
    LUT4 i1219_2_lut_rep_79 (.A(next_state_3__N_542[2]), .B(next_state[0]), 
         .Z(n5681)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam i1219_2_lut_rep_79.init = 16'h2222;
    LUT4 i53_3_lut_4_lut (.A(next_state[1]), .B(n5669), .C(next_state[3]), 
         .D(n20), .Z(n33)) /* synthesis lut_function=(A (B ((D)+!C)+!B (C (D)))+!A (C (D))) */ ;
    defparam i53_3_lut_4_lut.init = 16'hf808;
    FD1P3AX FPIO_isoCtrlRSTn_402 (.D(FPIO_isoCtrlRSTn_N_740), .SP(clk_enable_129), 
            .CK(clk), .Q(FPIO_isoCtrlRSTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam FPIO_isoCtrlRSTn_402.GSR = "ENABLED";
    LUT4 i2_4_lut_4_lut (.A(next_state[3]), .B(next_state[1]), .C(next_state[2]), 
         .D(FlexMIOs53_GPIO_PowerDown_N_755), .Z(FlexMIOs53_GPIO_PowerDown_N_754)) /* synthesis lut_function=(!(A+!(B (C)+!B (C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i2_4_lut_4_lut.init = 16'h5040;
    VLO i1 (.Z(GND_net));
    LUT4 i35_4_lut_4_lut (.A(next_state_3__N_542[2]), .B(next_state[0]), 
         .C(n5298), .D(next_state[1]), .Z(n17_adj_16)) /* synthesis lut_function=(!(A (B (C+!(D))+!B (D))+!A ((C+!(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam i35_4_lut_4_lut.init = 16'h0c22;
    LUT4 n5669_bdd_4_lut_2978 (.A(n5669), .B(externstop_falling), .C(next_state[2]), 
         .D(next_state[3]), .Z(n5822)) /* synthesis lut_function=(!(A (B (D)+!B (C+(D)))+!A (B (C (D))+!B (C)))) */ ;
    defparam n5669_bdd_4_lut_2978.init = 16'h05cf;
    LUT4 mux_623_i14_4_lut (.A(next_state[1]), .B(n1787), .C(n2688), .D(n2684), 
         .Z(n2593)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_623_i14_4_lut.init = 16'hf5c5;
    LUT4 i1612_4_lut (.A(n5), .B(resetcounter[21]), .C(resetcounter[18]), 
         .D(resetcounter[19]), .Z(n4009)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;
    defparam i1612_4_lut.init = 16'heccc;
    CCU2D add_2356_12 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4931), .COUT(n4932));
    defparam add_2356_12.INIT0 = 16'h5555;
    defparam add_2356_12.INIT1 = 16'h5555;
    defparam add_2356_12.INJECT1_0 = "NO";
    defparam add_2356_12.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_1 (.A(n5280), .B(resetcounter[20]), .C(n5239), .D(resetcounter[12]), 
         .Z(n5)) /* synthesis lut_function=(A (B (C+(D)))+!A (B (C))) */ ;
    defparam i1_4_lut_adj_1.init = 16'hc8c0;
    LUT4 i1_2_lut_rep_68_3_lut (.A(next_state_3__N_542[2]), .B(next_state[0]), 
         .C(next_state[1]), .Z(n5670)) /* synthesis lut_function=(!((B+(C))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam i1_2_lut_rep_68_3_lut.init = 16'h0202;
    CCU2D add_2356_10 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4930), .COUT(n4931));
    defparam add_2356_10.INIT0 = 16'h5555;
    defparam add_2356_10.INIT1 = 16'h5555;
    defparam add_2356_10.INJECT1_0 = "NO";
    defparam add_2356_10.INJECT1_1 = "NO";
    LUT4 i1_4_lut_4_lut_adj_2 (.A(next_state[2]), .B(next_state[3]), .C(next_state[0]), 
         .D(next_state[1]), .Z(FP_SysLEDg_N_737)) /* synthesis lut_function=(!(A (B+(D))+!A !(B (C+!(D))+!B (C)))) */ ;
    defparam i1_4_lut_4_lut_adj_2.init = 16'h5076;
    LUT4 i1_2_lut_3_lut_4_lut_adj_3 (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[3]), .D(next_state[2]), .Z(clk_enable_11)) /* synthesis lut_function=(A ((D)+!C)+!A (((D)+!C)+!B)) */ ;
    defparam i1_2_lut_3_lut_4_lut_adj_3.init = 16'hff1f;
    LUT4 i2_3_lut (.A(resetcounter[23]), .B(resetcounter[24]), .C(resetcounter[22]), 
         .Z(n4983)) /* synthesis lut_function=(A (B (C))) */ ;
    defparam i2_3_lut.init = 16'h8080;
    LUT4 i2785_2_lut_2_lut_3_lut_4_lut (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[3]), .D(next_state[2]), .Z(clk_enable_7)) /* synthesis lut_function=(A (B+((D)+!C))+!A (((D)+!C)+!B)) */ ;
    defparam i2785_2_lut_2_lut_3_lut_4_lut.init = 16'hff9f;
    LUT4 mux_623_i12_4_lut (.A(next_state[1]), .B(n1789), .C(n2688), .D(n2684), 
         .Z(n2595)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_623_i12_4_lut.init = 16'hf5c5;
    LUT4 i1454_3_lut (.A(n1790), .B(n2688), .C(n2684), .Z(n2596)) /* synthesis lut_function=(!(A (B (C))+!A (B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i1454_3_lut.init = 16'h3b3b;
    LUT4 i60_4_lut (.A(n89), .B(n120_adj_6), .C(n110_adj_12), .D(n90), 
         .Z(n124_adj_5)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i60_4_lut.init = 16'h8000;
    LUT4 i1_2_lut_3_lut_adj_4 (.A(next_state[0]), .B(next_state[1]), .C(next_state[2]), 
         .Z(n5261)) /* synthesis lut_function=(!(A (B+!(C))+!A !(B (C)))) */ ;
    defparam i1_2_lut_3_lut_adj_4.init = 16'h6060;
    LUT4 next_state_2__bdd_4_lut_2988 (.A(next_state[2]), .B(next_state[3]), 
         .C(next_state[1]), .D(next_state[0]), .Z(FP_SysLEDr_N_738)) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(B (C+!(D))+!B (C)))) */ ;
    defparam next_state_2__bdd_4_lut_2988.init = 16'h7054;
    LUT4 mux_623_i7_4_lut (.A(next_state[1]), .B(n1794), .C(n2688), .D(n2684), 
         .Z(n2600)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_623_i7_4_lut.init = 16'h0aca;
    LUT4 i60_3_lut (.A(next_state_3__N_542[2]), .B(n5669), .C(next_state[0]), 
         .Z(n2921)) /* synthesis lut_function=(!(A (B (C))+!A (B+!(C)))) */ ;
    defparam i60_3_lut.init = 16'h3a3a;
    LUT4 i1524_2_lut_3_lut_4_lut (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[2]), .D(next_state[3]), .Z(Carrier_PG_1V8_N_838)) /* synthesis lut_function=(A ((C+(D))+!B)+!A (B+(C+(D)))) */ ;
    defparam i1524_2_lut_3_lut_4_lut.init = 16'hfff6;
    PFUMX i2878 (.BLUT(n5620), .ALUT(n5674), .C0(next_state[1]), .Z(n5621));
    CCU2D add_2356_8 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4929), .COUT(n4930));
    defparam add_2356_8.INIT0 = 16'h5555;
    defparam add_2356_8.INIT1 = 16'h5aaa;
    defparam add_2356_8.INJECT1_0 = "NO";
    defparam add_2356_8.INJECT1_1 = "NO";
    LUT4 i54_4_lut (.A(FlexMIOs62_out), .B(n108_adj_13), .C(n86), .D(S3CsI2C_SCL_c), 
         .Z(n118_adj_7)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i54_4_lut.init = 16'h8000;
    CCU2D add_176_9 (.A0(\debounce_counters[2] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4858), .COUT(n4859), .S0(n305), 
          .S1(n304));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_9.INIT0 = 16'h5aaa;
    defparam add_176_9.INIT1 = 16'h5aaa;
    defparam add_176_9.INJECT1_0 = "NO";
    defparam add_176_9.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_80 (.A(next_state_3__N_542[2]), .B(signals_debounced_syn[3]), 
         .Z(n5682)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(346[17] 356[12])
    defparam i1_2_lut_rep_80.init = 16'h8888;
    FD1P3AX next_state_i0 (.D(next_state_3__N_61[0]), .SP(clk_enable_130), 
            .CK(clk), .Q(next_state[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam next_state_i0.GSR = "ENABLED";
    LUT4 i1_2_lut_rep_81 (.A(next_state[3]), .B(next_state[2]), .Z(n5683)) /* synthesis lut_function=(A (B)) */ ;
    defparam i1_2_lut_rep_81.init = 16'h8888;
    LUT4 i791_2_lut (.A(clk_enable_19), .B(debounce_inputs_asyn2[3]), .Z(clk_enable_172)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i791_2_lut.init = 16'hdddd;
    LUT4 mux_632_i19_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n2690), .D(n2588), .Z(n2622)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_632_i19_3_lut_4_lut.init = 16'h7f70;
    LUT4 mux_441_Mux_2_i15_3_lut (.A(n5691), .B(next_state[2]), .C(next_state[3]), 
         .Z(Carrier_PG_1V8_N_831)) /* synthesis lut_function=(A (B (C)+!B !(C))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_441_Mux_2_i15_3_lut.init = 16'hc2c2;
    CCU2D add_167_25 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4850), .COUT(n4851), .S0(n183), 
          .S1(n182));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_25.INIT0 = 16'h5aaa;
    defparam add_167_25.INIT1 = 16'h5aaa;
    defparam add_167_25.INJECT1_0 = "NO";
    defparam add_167_25.INJECT1_1 = "NO";
    CCU2D add_167_23 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4849), .COUT(n4850), .S0(n185), 
          .S1(n184));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_23.INIT0 = 16'h5aaa;
    defparam add_167_23.INIT1 = 16'h5aaa;
    defparam add_167_23.INJECT1_0 = "NO";
    defparam add_167_23.INJECT1_1 = "NO";
    LUT4 i2769_2_lut_rep_72 (.A(next_state[0]), .B(next_state_3__N_542[2]), 
         .Z(n5674)) /* synthesis lut_function=(!(A+(B))) */ ;
    defparam i2769_2_lut_rep_72.init = 16'h1111;
    LUT4 i2738_3_lut_4_lut (.A(n5671), .B(n5672), .C(next_state[3]), .D(n40), 
         .Z(n27)) /* synthesis lut_function=(!(A (C+!(D))+!A (B (C+!(D))+!B !(C+(D))))) */ ;
    defparam i2738_3_lut_4_lut.init = 16'h1f10;
    CCU2D add_194_21 (.A0(\debounce_counters[4] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4896), .COUT(n4897), .S0(n505), 
          .S1(n504));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_21.INIT0 = 16'h5aaa;
    defparam add_194_21.INIT1 = 16'h5aaa;
    defparam add_194_21.INJECT1_0 = "NO";
    defparam add_194_21.INJECT1_1 = "NO";
    CCU2D add_167_21 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4848), .COUT(n4849), .S0(n187), 
          .S1(n186));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_21.INIT0 = 16'h5aaa;
    defparam add_167_21.INIT1 = 16'h5aaa;
    defparam add_167_21.INJECT1_0 = "NO";
    defparam add_167_21.INJECT1_1 = "NO";
    LUT4 mux_632_i21_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n2690), .D(n2586), .Z(n2620)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_632_i21_3_lut_4_lut.init = 16'h7f70;
    CCU2D add_194_19 (.A0(\debounce_counters[4] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4895), .COUT(n4896), .S0(n507), 
          .S1(n506));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_19.INIT0 = 16'h5aaa;
    defparam add_194_19.INIT1 = 16'h5aaa;
    defparam add_194_19.INJECT1_0 = "NO";
    defparam add_194_19.INJECT1_1 = "NO";
    LUT4 i23_4_lut (.A(n27_adj_3), .B(n46), .C(n40_adj_1), .D(n28), 
         .Z(n48)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i23_4_lut.init = 16'hfffe;
    LUT4 mux_632_i10_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n2690), .D(n2597), .Z(n2631)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_632_i10_3_lut_4_lut.init = 16'h7f70;
    LUT4 mux_632_i20_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n2690), .D(n2587), .Z(n2621)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_632_i20_3_lut_4_lut.init = 16'h7f70;
    LUT4 mux_632_i9_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), .C(n2690), 
         .D(n2598), .Z(n2632)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_632_i9_3_lut_4_lut.init = 16'h7f70;
    LUT4 i1291_3_lut_4_lut (.A(clk_enable_142), .B(n2690), .C(n2688), 
         .D(n2684), .Z(n3688)) /* synthesis lut_function=(A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam i1291_3_lut_4_lut.init = 16'haa8a;
    CCU2D add_2356_6 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4928), .COUT(n4929));
    defparam add_2356_6.INIT0 = 16'h5555;
    defparam add_2356_6.INIT1 = 16'h5aaa;
    defparam add_2356_6.INJECT1_0 = "NO";
    defparam add_2356_6.INJECT1_1 = "NO";
    LUT4 i1_4_lut_then_4_lut (.A(next_state[2]), .B(next_state[3]), .C(next_state[0]), 
         .D(next_state_3__N_542[2]), .Z(n5687)) /* synthesis lut_function=(!(A+((C (D)+!C !(D))+!B))) */ ;
    defparam i1_4_lut_then_4_lut.init = 16'h0440;
    LUT4 i1487_4_lut (.A(next_state[2]), .B(externstop_falling), .C(signals_debounced_syn[3]), 
         .D(next_state_3__N_542[2]), .Z(next_state_3__N_538[2])) /* synthesis lut_function=(A (B+(C))+!A (B+!((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(346[17] 356[12])
    defparam i1487_4_lut.init = 16'hecfc;
    LUT4 i54_4_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_542[2]), 
         .C(next_state[2]), .D(n5669), .Z(n30)) /* synthesis lut_function=(!(A ((C)+!B)+!A (B (C)+!B !(C (D))))) */ ;
    defparam i54_4_lut_4_lut.init = 16'h1c0c;
    LUT4 i1_2_lut_rep_82 (.A(resetcounter[10]), .B(resetcounter[11]), .Z(n5684)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_rep_82.init = 16'heeee;
    LUT4 i2772_4_lut (.A(n30), .B(next_state[2]), .C(n5306), .D(n33), 
         .Z(clk_enable_87)) /* synthesis lut_function=(A (B (C)+!B !((D)+!C))+!A (B+!(D))) */ ;
    defparam i2772_4_lut.init = 16'hc4f5;
    LUT4 i2788_2_lut (.A(next_state[3]), .B(next_state[1]), .Z(n5342)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i2788_2_lut.init = 16'hbbbb;
    LUT4 n3927_bdd_4_lut_2854 (.A(n3927), .B(next_state[0]), .C(next_state[1]), 
         .D(n5669), .Z(n5558)) /* synthesis lut_function=(A (B (C (D))+!B !(C))+!A (((D)+!C)+!B)) */ ;
    defparam n3927_bdd_4_lut_2854.init = 16'hd717;
    LUT4 mux_441_Mux_2_i3_4_lut_then_4_lut (.A(extern_connected), .B(signals_debounced_syn[2]), 
         .C(n5669), .D(next_state[0]), .Z(n5690)) /* synthesis lut_function=(!(A (B (C)+!B (C+(D)))+!A (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_441_Mux_2_i3_4_lut_then_4_lut.init = 16'h0d0f;
    LUT4 mux_441_Mux_2_i3_4_lut_else_4_lut (.A(next_state[0]), .B(next_state_3__N_542[2]), 
         .Z(n5689)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_441_Mux_2_i3_4_lut_else_4_lut.init = 16'h4444;
    LUT4 next_state_0__bdd_4_lut_2844 (.A(next_state[3]), .B(next_state[1]), 
         .C(n5669), .D(next_state_3__N_542[2]), .Z(n5560)) /* synthesis lut_function=(!(A (B+!(C))+!A !(B (C)+!B !(D)))) */ ;
    defparam next_state_0__bdd_4_lut_2844.init = 16'h6071;
    LUT4 i1_4_lut_adj_5 (.A(next_state[3]), .B(externstop_falling), .C(n11), 
         .D(n5261), .Z(n2690)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;
    defparam i1_4_lut_adj_5.init = 16'heca0;
    LUT4 i42_4_lut (.A(FlexMIOs30_out), .B(FlexMIOs37_out), .C(FlexMIOs32_out), 
         .D(FlexMIOs45_c), .Z(n106_adj_15)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i42_4_lut.init = 16'h8000;
    LUT4 i2765_4_lut (.A(next_state[0]), .B(n5669), .C(next_state[1]), 
         .D(next_state[2]), .Z(clk_enable_89)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;
    defparam i2765_4_lut.init = 16'h2000;
    FD1S3AX resetcounter_i24_787__i2 (.D(n128), .CK(clk), .Q(resetcounter[2])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i2.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i3 (.D(n127), .CK(clk), .Q(resetcounter[3])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i3.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i4 (.D(n126_adj_18), .CK(clk), .Q(resetcounter[4])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i4.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i5 (.D(n125), .CK(clk), .Q(resetcounter[5])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i5.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i6 (.D(n124), .CK(clk), .Q(resetcounter[6])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i6.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i7 (.D(n123), .CK(clk), .Q(resetcounter[7])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i7.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i8 (.D(n122_adj_17), .CK(clk), .Q(resetcounter[8])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i8.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i9 (.D(n121), .CK(clk), .Q(resetcounter[9])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i9.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i10 (.D(n120), .CK(clk), .Q(resetcounter[10])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i10.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i11 (.D(n119), .CK(clk), .Q(resetcounter[11])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i11.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i12 (.D(n118), .CK(clk), .Q(resetcounter[12])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i12.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i13 (.D(n117), .CK(clk), .Q(resetcounter[13])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i13.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i14 (.D(n116), .CK(clk), .Q(resetcounter[14])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i14.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i15 (.D(n115), .CK(clk), .Q(resetcounter[15])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i15.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i16 (.D(n114), .CK(clk), .Q(resetcounter[16])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i16.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i17 (.D(n113), .CK(clk), .Q(resetcounter[17])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i17.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i18 (.D(n112), .CK(clk), .Q(resetcounter[18])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i18.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i19 (.D(n111), .CK(clk), .Q(resetcounter[19])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i19.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i20 (.D(n110), .CK(clk), .Q(resetcounter[20])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i20.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i21 (.D(n109), .CK(clk), .Q(resetcounter[21])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i21.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i22 (.D(n108), .CK(clk), .Q(resetcounter[22])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i22.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i23 (.D(n107), .CK(clk), .Q(resetcounter[23])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i23.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_787__i24 (.D(n106), .CK(clk), .Q(resetcounter[24])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787__i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i1 (.D(n417), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i1.GSR = "ENABLED";
    LUT4 i63_4_lut (.A(n113_adj_10), .B(n126), .C(n122), .D(n114_adj_9), 
         .Z(dummy_signal)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i63_4_lut.init = 16'h8000;
    LUT4 i49_4_lut (.A(TDnALERT_c), .B(n98), .C(n66), .D(FlexIO04_c), 
         .Z(n113_adj_10)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i49_4_lut.init = 16'h8000;
    LUT4 i62_4_lut (.A(n105), .B(n124_adj_5), .C(n118_adj_7), .D(n106_adj_15), 
         .Z(n126)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i62_4_lut.init = 16'h8000;
    LUT4 i25_2_lut (.A(DIG5S3C05_out), .B(DIG5S3C24_out), .Z(n89)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i25_2_lut.init = 16'h8888;
    LUT4 i56_4_lut (.A(FlexMIOs36_out), .B(n112_adj_11), .C(n94), .D(TDnSHDN_c), 
         .Z(n120_adj_6)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i56_4_lut.init = 16'h8000;
    LUT4 i2755_4_lut_then_3_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[0]), 
         .Z(n5693)) /* synthesis lut_function=(A (B+(C))+!A (B (C))) */ ;
    defparam i2755_4_lut_then_3_lut.init = 16'he8e8;
    LUT4 i2755_4_lut_else_3_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state_3__N_542[2]), 
         .D(next_state[0]), .Z(n5692)) /* synthesis lut_function=(A (B)+!A !(B+(C (D)+!C !(D)))) */ ;
    defparam i2755_4_lut_else_3_lut.init = 16'h8998;
    LUT4 i50_4_lut (.A(DIG5S3C29_out), .B(n100), .C(n70), .D(FPIO_FlexMIO30_out), 
         .Z(n114_adj_9)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i50_4_lut.init = 16'h8000;
    LUT4 i845_1_lut (.A(Carrier_PG_1V8_N_750), .Z(n3245)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(276[1] 457[13])
    defparam i845_1_lut.init = 16'h5555;
    LUT4 i34_4_lut (.A(SD0_CD_c), .B(SPI_S3C_nCS_USR_c), .C(SDA_c), .D(DIG5S3C03_out), 
         .Z(n98)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i34_4_lut.init = 16'h8000;
    FD1P3IX debounce_counters_4___i0 (.D(n524), .SP(clk_enable_132), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_4___i0.GSR = "ENABLED";
    LUT4 i8_4_lut (.A(n15), .B(resetcounter[9]), .C(n14), .D(resetcounter[18]), 
         .Z(n5031)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(248[12:28])
    defparam i8_4_lut.init = 16'hfffe;
    FD1P3AX FP_SysLEDr_396 (.D(FP_SysLEDr_N_738), .SP(clk_enable_133), .CK(clk), 
            .Q(FP_SysLEDr_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam FP_SysLEDr_396.GSR = "ENABLED";
    LUT4 i46_4_lut (.A(FlexLIO_c_1), .B(FlexLIO_c_4), .C(FlexLIO_c_2), 
         .D(FlexMIOs28_out), .Z(n110_adj_12)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i46_4_lut.init = 16'h8000;
    LUT4 i26_2_lut (.A(DIG5S3C26_out), .B(FPIO_FlexMIO27_out), .Z(n90)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i26_2_lut.init = 16'h8888;
    LUT4 i6_4_lut (.A(resetcounter[23]), .B(resetcounter[24]), .C(resetcounter[12]), 
         .D(resetcounter[20]), .Z(n15)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(248[12:28])
    defparam i6_4_lut.init = 16'hfffe;
    LUT4 i48_4_lut (.A(DIGS3C_SlotD_SlotOK_c_2), .B(FlexLIO_c_0), .C(DIG5S3C04_out), 
         .D(TDnFFnFS_c), .Z(n112_adj_11)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i48_4_lut.init = 16'h8000;
    LUT4 i30_2_lut (.A(PG_VIN_c), .B(ANL_S3C_SLOTOK_c_1), .Z(n94)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i30_2_lut.init = 16'h8888;
    CCU2D add_167_19 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4847), .COUT(n4848), .S0(n189), 
          .S1(n188));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_19.INIT0 = 16'h5aaa;
    defparam add_167_19.INIT1 = 16'h5aaa;
    defparam add_167_19.INJECT1_0 = "NO";
    defparam add_167_19.INJECT1_1 = "NO";
    LUT4 i1_2_lut (.A(n2688), .B(n2684), .Z(n3271)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i1_2_lut.init = 16'hdddd;
    LUT4 i9_2_lut (.A(FlexMIOs54_out), .B(FlexMIOs63_out), .Z(n73)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i9_2_lut.init = 16'h8888;
    LUT4 i1_4_lut_then_4_lut_adj_6 (.A(n5669), .B(next_state[1]), .C(next_state[0]), 
         .D(next_state[2]), .Z(n5696)) /* synthesis lut_function=(A (B (C+(D))+!B (D))+!A !(B (C+!(D))+!B !(C (D)))) */ ;
    defparam i1_4_lut_then_4_lut_adj_6.init = 16'hbe80;
    CCU2D add_194_17 (.A0(\debounce_counters[4] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4894), .COUT(n4895), .S0(n509), 
          .S1(n508));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_17.INIT0 = 16'h5aaa;
    defparam add_194_17.INIT1 = 16'h5aaa;
    defparam add_194_17.INJECT1_0 = "NO";
    defparam add_194_17.INJECT1_1 = "NO";
    LUT4 next_state_0__bdd_2_lut_2856 (.A(next_state[3]), .B(next_state[1]), 
         .Z(n5561)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;
    defparam next_state_0__bdd_2_lut_2856.init = 16'h6666;
    CCU2D add_176_7 (.A0(\debounce_counters[2] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4857), .COUT(n4858), .S0(n307), 
          .S1(n306));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_7.INIT0 = 16'h5aaa;
    defparam add_176_7.INIT1 = 16'h5aaa;
    defparam add_176_7.INJECT1_0 = "NO";
    defparam add_176_7.INJECT1_1 = "NO";
    LUT4 i5_3_lut (.A(resetcounter[19]), .B(resetcounter[8]), .C(resetcounter[22]), 
         .Z(n14)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(248[12:28])
    defparam i5_3_lut.init = 16'hfefe;
    LUT4 i792_2_lut (.A(clk_enable_18), .B(debounce_inputs_asyn2[4]), .Z(clk_enable_132)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i792_2_lut.init = 16'hdddd;
    LUT4 n3477_bdd_3_lut_2843_4_lut (.A(next_state[0]), .B(next_state_3__N_542[2]), 
         .C(next_state[2]), .D(next_state[1]), .Z(n5552)) /* synthesis lut_function=(!(A+(B+(C+(D))))) */ ;
    defparam n3477_bdd_3_lut_2843_4_lut.init = 16'h0001;
    LUT4 i10_4_lut (.A(resetcounter[4]), .B(n20_adj_4), .C(n16), .D(resetcounter[1]), 
         .Z(n3460)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(269[6:29])
    defparam i10_4_lut.init = 16'hfffe;
    LUT4 i9_4_lut (.A(n5684), .B(n18), .C(resetcounter[0]), .D(resetcounter[5]), 
         .Z(n20_adj_4)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(269[6:29])
    defparam i9_4_lut.init = 16'hfffe;
    LUT4 i1451_2_lut (.A(next_state[3]), .B(n5669), .Z(next_state_3__N_522[3])) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(436[5] 440[12])
    defparam i1451_2_lut.init = 16'hbbbb;
    LUT4 i5_2_lut (.A(resetcounter[21]), .B(n5239), .Z(n16)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(269[6:29])
    defparam i5_2_lut.init = 16'heeee;
    LUT4 i7_4_lut (.A(resetcounter[7]), .B(resetcounter[6]), .C(resetcounter[3]), 
         .D(resetcounter[2]), .Z(n18)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(269[6:29])
    defparam i7_4_lut.init = 16'hfffe;
    LUT4 i52_4_lut (.A(DIG5S3C01_out), .B(n104), .C(n78), .D(DIG5S3C02_out), 
         .Z(n116_adj_8)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i52_4_lut.init = 16'h8000;
    FD1P3IX counter_i0_i21 (.D(n2519), .SP(clk_enable_142), .CD(n3894), 
            .CK(clk), .Q(counter[21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i21.GSR = "ENABLED";
    LUT4 i38_4_lut (.A(SCL_c), .B(DIGS3C_SlotD_SlotOK_c_1), .C(SD1_CD_c), 
         .D(DIGS3C_SlotD_SlotOK_c_5), .Z(n102)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i38_4_lut.init = 16'h8000;
    PFUMX i2727 (.BLUT(n5344), .ALUT(n5345), .C0(next_state[2]), .Z(n5346));
    LUT4 m1_lut (.Z(n5901)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    LUT4 i58_4_lut_adj_7 (.A(n73), .B(n116_adj_8), .C(n102), .D(n74), 
         .Z(n122)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i58_4_lut_adj_7.init = 16'h8000;
    LUT4 i4_4_lut (.A(resetcounter[16]), .B(resetcounter[15]), .C(resetcounter[14]), 
         .D(n6_adj_14), .Z(n5239)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(269[6:29])
    defparam i4_4_lut.init = 16'hfffe;
    FD1P3IX counter_i0_i17 (.D(n2589), .SP(clk_enable_142), .CD(n3695), 
            .CK(clk), .Q(counter[17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i17.GSR = "ENABLED";
    LUT4 i10_2_lut (.A(PG_Module_c), .B(S3CsI2C_SDA_c), .Z(n74)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i10_2_lut.init = 16'h8888;
    LUT4 i789_2_lut (.A(clk_enable_6), .B(debounce_inputs_asyn2[1]), .Z(clk_enable_83)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i789_2_lut.init = 16'hdddd;
    CCU2D resetcounter_i24_787_add_4_25 (.A0(resetcounter[23]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4975), .S0(n107), .S1(n106));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787_add_4_25.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_25.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_25.INJECT1_0 = "NO";
    defparam resetcounter_i24_787_add_4_25.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_787_add_4_23 (.A0(resetcounter[21]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4974), .COUT(n4975), .S0(n109), 
          .S1(n108));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787_add_4_23.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_23.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_23.INJECT1_0 = "NO";
    defparam resetcounter_i24_787_add_4_23.INJECT1_1 = "NO";
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    CCU2D resetcounter_i24_787_add_4_21 (.A0(resetcounter[19]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4973), .COUT(n4974), .S0(n111), 
          .S1(n110));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787_add_4_21.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_21.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_21.INJECT1_0 = "NO";
    defparam resetcounter_i24_787_add_4_21.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_787_add_4_19 (.A0(resetcounter[17]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4972), .COUT(n4973), .S0(n113), 
          .S1(n112));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787_add_4_19.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_19.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_19.INJECT1_0 = "NO";
    defparam resetcounter_i24_787_add_4_19.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i16 (.D(n2590), .SP(clk_enable_142), .CD(n3695), 
            .CK(clk), .Q(counter[16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i16.GSR = "ENABLED";
    CCU2D resetcounter_i24_787_add_4_17 (.A0(resetcounter[15]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4971), .COUT(n4972), .S0(n115), 
          .S1(n114));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787_add_4_17.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_17.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_17.INJECT1_0 = "NO";
    defparam resetcounter_i24_787_add_4_17.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i15 (.D(n2591), .SP(clk_enable_142), .CD(n3695), 
            .CK(clk), .Q(counter[15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i15.GSR = "ENABLED";
    FD1P3IX counter_i0_i14 (.D(n2526), .SP(clk_enable_142), .CD(n3894), 
            .CK(clk), .Q(counter[14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i14.GSR = "ENABLED";
    LUT4 i40_4_lut (.A(DIG5S3C28_out), .B(FPIO_FlexMIO29_out), .C(FPIO_FlexMIO28_out), 
         .D(FPIO_iosCtrlINTn_c), .Z(n104)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i40_4_lut.init = 16'h8000;
    LUT4 i1_2_lut_adj_8 (.A(resetcounter[13]), .B(resetcounter[17]), .Z(n6_adj_14)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(269[6:29])
    defparam i1_2_lut_adj_8.init = 16'heeee;
    LUT4 i1_4_lut_4_lut_4_lut (.A(next_state[3]), .B(next_state_3__N_542[2]), 
         .C(n5685), .D(next_state[0]), .Z(n23)) /* synthesis lut_function=(!(A (((D)+!C)+!B)+!A !(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i1_4_lut_4_lut_4_lut.init = 16'h44c4;
    GSR GSR_INST (.GSR(VCC_net));
    CCU2D add_176_5 (.A0(\debounce_counters[2] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4856), .COUT(n4857), .S0(n309), 
          .S1(n308));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_5.INIT0 = 16'h5aaa;
    defparam add_176_5.INIT1 = 16'h5aaa;
    defparam add_176_5.INJECT1_0 = "NO";
    defparam add_176_5.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_787_add_4_15 (.A0(resetcounter[13]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4970), .COUT(n4971), .S0(n117), 
          .S1(n116));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787_add_4_15.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_15.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_15.INJECT1_0 = "NO";
    defparam resetcounter_i24_787_add_4_15.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_787_add_4_13 (.A0(resetcounter[11]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4969), .COUT(n4970), .S0(n119), 
          .S1(n118));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787_add_4_13.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_13.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_13.INJECT1_0 = "NO";
    defparam resetcounter_i24_787_add_4_13.INJECT1_1 = "NO";
    FD1P3AX FlexMIOs53_GPIO_PowerDown_395 (.D(FlexMIOs53_GPIO_PowerDown_N_754), 
            .SP(clk_enable_139), .CK(clk), .Q(FlexMIOs53_GPIO_PowerDown_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam FlexMIOs53_GPIO_PowerDown_395.GSR = "ENABLED";
    CCU2D add_2356_4 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4927), .COUT(n4928));
    defparam add_2356_4.INIT0 = 16'h5555;
    defparam add_2356_4.INIT1 = 16'h5555;
    defparam add_2356_4.INJECT1_0 = "NO";
    defparam add_2356_4.INJECT1_1 = "NO";
    CCU2D add_2356_2 (.A0(\debounce_counters[2] [7]), .B0(\debounce_counters[2] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[2] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n4927));
    defparam add_2356_2.INIT0 = 16'h1000;
    defparam add_2356_2.INIT1 = 16'h5aaa;
    defparam add_2356_2.INJECT1_0 = "NO";
    defparam add_2356_2.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i13 (.D(n2593), .SP(clk_enable_142), .CD(n3695), 
            .CK(clk), .Q(counter[13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i13.GSR = "ENABLED";
    CCU2D add_2357_26 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4926), .S1(clk_enable_6));
    defparam add_2357_26.INIT0 = 16'hf555;
    defparam add_2357_26.INIT1 = 16'h0000;
    defparam add_2357_26.INJECT1_0 = "NO";
    defparam add_2357_26.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_787_add_4_11 (.A0(resetcounter[9]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4968), .COUT(n4969), .S0(n121), 
          .S1(n120));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787_add_4_11.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_11.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_11.INJECT1_0 = "NO";
    defparam resetcounter_i24_787_add_4_11.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_787_add_4_9 (.A0(resetcounter[7]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4967), .COUT(n4968), .S0(n123), 
          .S1(n122_adj_17));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787_add_4_9.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_9.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_9.INJECT1_0 = "NO";
    defparam resetcounter_i24_787_add_4_9.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_787_add_4_7 (.A0(resetcounter[5]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4966), .COUT(n4967), .S0(n125), 
          .S1(n124));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787_add_4_7.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_7.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_7.INJECT1_0 = "NO";
    defparam resetcounter_i24_787_add_4_7.INJECT1_1 = "NO";
    CCU2D add_167_17 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4846), .COUT(n4847), .S0(n191), 
          .S1(n190));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_167_17.INIT0 = 16'h5aaa;
    defparam add_167_17.INIT1 = 16'h5aaa;
    defparam add_167_17.INJECT1_0 = "NO";
    defparam add_167_17.INJECT1_1 = "NO";
    LUT4 i1_4_lut_else_4_lut_adj_9 (.A(n5669), .B(next_state[1]), .C(next_state[0]), 
         .D(next_state[2]), .Z(n5695)) /* synthesis lut_function=(A (B (C)+!B !(C+!(D)))) */ ;
    defparam i1_4_lut_else_4_lut_adj_9.init = 16'h8280;
    CCU2D add_2357_24 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4925), .COUT(n4926));
    defparam add_2357_24.INIT0 = 16'h5555;
    defparam add_2357_24.INIT1 = 16'h5555;
    defparam add_2357_24.INJECT1_0 = "NO";
    defparam add_2357_24.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_787_add_4_5 (.A0(resetcounter[3]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4965), .COUT(n4966), .S0(n127), 
          .S1(n126_adj_18));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787_add_4_5.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_5.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_5.INJECT1_0 = "NO";
    defparam resetcounter_i24_787_add_4_5.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_787_add_4_3 (.A0(resetcounter[1]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4964), .COUT(n4965), .S0(n129), 
          .S1(n128));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787_add_4_3.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_3.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_787_add_4_3.INJECT1_0 = "NO";
    defparam resetcounter_i24_787_add_4_3.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_787_add_4_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n4009), .B1(n4983), .C1(resetcounter[0]), 
          .D1(GND_net), .COUT(n4964), .S1(n130));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(270[20:32])
    defparam resetcounter_i24_787_add_4_1.INIT0 = 16'hF000;
    defparam resetcounter_i24_787_add_4_1.INIT1 = 16'h8787;
    defparam resetcounter_i24_787_add_4_1.INJECT1_0 = "NO";
    defparam resetcounter_i24_787_add_4_1.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i11 (.D(n2595), .SP(clk_enable_142), .CD(n3695), 
            .CK(clk), .Q(counter[11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i11.GSR = "ENABLED";
    CCU2D add_2354_26 (.A0(\debounce_counters[4] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4963), .S1(clk_enable_18));
    defparam add_2354_26.INIT0 = 16'hf555;
    defparam add_2354_26.INIT1 = 16'h0000;
    defparam add_2354_26.INJECT1_0 = "NO";
    defparam add_2354_26.INJECT1_1 = "NO";
    CCU2D add_2354_24 (.A0(\debounce_counters[4] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4962), .COUT(n4963));
    defparam add_2354_24.INIT0 = 16'h5555;
    defparam add_2354_24.INIT1 = 16'h5555;
    defparam add_2354_24.INJECT1_0 = "NO";
    defparam add_2354_24.INJECT1_1 = "NO";
    CCU2D add_2354_22 (.A0(\debounce_counters[4] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4961), .COUT(n4962));
    defparam add_2354_22.INIT0 = 16'h5555;
    defparam add_2354_22.INIT1 = 16'h5555;
    defparam add_2354_22.INJECT1_0 = "NO";
    defparam add_2354_22.INJECT1_1 = "NO";
    CCU2D add_2357_22 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4924), .COUT(n4925));
    defparam add_2357_22.INIT0 = 16'h5555;
    defparam add_2357_22.INIT1 = 16'h5555;
    defparam add_2357_22.INJECT1_0 = "NO";
    defparam add_2357_22.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i10 (.D(n2596), .SP(clk_enable_142), .CD(n3695), 
            .CK(clk), .Q(counter[10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam counter_i0_i10.GSR = "ENABLED";
    LUT4 i2_4_lut_4_lut_adj_10 (.A(next_state[0]), .B(next_state_3__N_542[2]), 
         .C(next_state[1]), .D(next_state_3__N_522[3]), .Z(n24)) /* synthesis lut_function=(!(A ((D)+!C)+!A (B+(C+(D))))) */ ;
    defparam i2_4_lut_4_lut_adj_10.init = 16'h00a1;
    LUT4 i2719_4_lut (.A(n5330), .B(resetcounter[22]), .C(n5332), .D(resetcounter[19]), 
         .Z(n5338)) /* synthesis lut_function=(A (B (C (D)))) */ ;
    defparam i2719_4_lut.init = 16'h8000;
    CCU2D add_185_5 (.A0(\debounce_counters[3] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4872), .COUT(n4873), .S0(n415), 
          .S1(n414));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_5.INIT0 = 16'h5aaa;
    defparam add_185_5.INIT1 = 16'h5aaa;
    defparam add_185_5.INJECT1_0 = "NO";
    defparam add_185_5.INJECT1_1 = "NO";
    LUT4 i790_2_lut (.A(clk_enable_20), .B(debounce_inputs_asyn2[2]), .Z(clk_enable_52)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i790_2_lut.init = 16'hdddd;
    LUT4 i2711_4_lut (.A(resetcounter[23]), .B(resetcounter[18]), .C(resetcounter[9]), 
         .D(resetcounter[20]), .Z(n5330)) /* synthesis lut_function=(A (B (C (D)))) */ ;
    defparam i2711_4_lut.init = 16'h8000;
    PFUMX i2851 (.BLUT(n5585), .ALUT(n5581), .C0(next_state[3]), .Z(next_state_3__N_61[3]));
    LUT4 i2713_3_lut (.A(resetcounter[24]), .B(resetcounter[12]), .C(resetcounter[8]), 
         .Z(n5332)) /* synthesis lut_function=(A (B (C))) */ ;
    defparam i2713_3_lut.init = 16'h8080;
    LUT4 i14_2_lut (.A(DIG5S3C25_out), .B(DIG5S3C27_out), .Z(n78)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i14_2_lut.init = 16'h8888;
    CCU2D add_2357_20 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4923), .COUT(n4924));
    defparam add_2357_20.INIT0 = 16'h5555;
    defparam add_2357_20.INIT1 = 16'h5555;
    defparam add_2357_20.INJECT1_0 = "NO";
    defparam add_2357_20.INJECT1_1 = "NO";
    LUT4 i2676_3_lut (.A(n3460), .B(n5338), .C(n5031), .Z(FP_UsrLED_c_2)) /* synthesis lut_function=(A+!(B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(248[9] 263[16])
    defparam i2676_3_lut.init = 16'hbaba;
    CCU2D add_2357_18 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4922), .COUT(n4923));
    defparam add_2357_18.INIT0 = 16'h5555;
    defparam add_2357_18.INIT1 = 16'h5555;
    defparam add_2357_18.INJECT1_0 = "NO";
    defparam add_2357_18.INJECT1_1 = "NO";
    LUT4 i1_3_lut_4_lut (.A(resetcounter[10]), .B(resetcounter[11]), .C(resetcounter[9]), 
         .D(resetcounter[8]), .Z(n5280)) /* synthesis lut_function=(A+(B+(C (D)))) */ ;
    defparam i1_3_lut_4_lut.init = 16'hfeee;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut (.A(DIGS3C_SlotD_ReqOE_c_5), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_5)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(206[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut.init = 16'h2222;
    LUT4 next_state_3__bdd_4_lut_2845 (.A(next_state[3]), .B(next_state[2]), 
         .C(next_state[1]), .D(next_state[0]), .Z(clk_enable_16)) /* synthesis lut_function=(A (B+(C (D)+!C !(D)))+!A (B (C+(D)))) */ ;
    defparam next_state_3__bdd_4_lut_2845.init = 16'hecca;
    LUT4 i36_4_lut (.A(FlexMIOs27_out), .B(FlexMIOs33_out), .C(FlexMIOs31_out), 
         .D(FlexMIOs34_out), .Z(n100)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i36_4_lut.init = 16'h8000;
    PFUMX i2849 (.BLUT(n5583), .ALUT(n5582), .C0(n5669), .Z(n5584));
    CCU2D add_2354_20 (.A0(\debounce_counters[4] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4960), .COUT(n4961));
    defparam add_2354_20.INIT0 = 16'h5555;
    defparam add_2354_20.INIT1 = 16'h5555;
    defparam add_2354_20.INJECT1_0 = "NO";
    defparam add_2354_20.INJECT1_1 = "NO";
    CCU2D add_2357_16 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4921), .COUT(n4922));
    defparam add_2357_16.INIT0 = 16'h5555;
    defparam add_2357_16.INIT1 = 16'h5555;
    defparam add_2357_16.INJECT1_0 = "NO";
    defparam add_2357_16.INJECT1_1 = "NO";
    CCU2D add_2357_14 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4920), .COUT(n4921));
    defparam add_2357_14.INIT0 = 16'h5555;
    defparam add_2357_14.INIT1 = 16'h5555;
    defparam add_2357_14.INJECT1_0 = "NO";
    defparam add_2357_14.INJECT1_1 = "NO";
    CCU2D add_194_15 (.A0(\debounce_counters[4] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4893), .COUT(n4894), .S0(n511), 
          .S1(n510));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_15.INIT0 = 16'h5aaa;
    defparam add_194_15.INIT1 = 16'h5aaa;
    defparam add_194_15.INJECT1_0 = "NO";
    defparam add_194_15.INJECT1_1 = "NO";
    CCU2D add_194_13 (.A0(\debounce_counters[4] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4892), .COUT(n4893), .S0(n513), 
          .S1(n512));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_13.INIT0 = 16'h5aaa;
    defparam add_194_13.INIT1 = 16'h5aaa;
    defparam add_194_13.INJECT1_0 = "NO";
    defparam add_194_13.INJECT1_1 = "NO";
    CCU2D add_2354_18 (.A0(\debounce_counters[4] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4959), .COUT(n4960));
    defparam add_2354_18.INIT0 = 16'h5555;
    defparam add_2354_18.INIT1 = 16'h5555;
    defparam add_2354_18.INJECT1_0 = "NO";
    defparam add_2354_18.INJECT1_1 = "NO";
    LUT4 pushed_1__I_0_1_lut (.A(pushed[1]), .Z(pushed_1__N_294)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(226[17] 230[24])
    defparam pushed_1__I_0_1_lut.init = 16'h5555;
    CCU2D add_2354_16 (.A0(\debounce_counters[4] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4958), .COUT(n4959));
    defparam add_2354_16.INIT0 = 16'h5555;
    defparam add_2354_16.INIT1 = 16'h5555;
    defparam add_2354_16.INJECT1_0 = "NO";
    defparam add_2354_16.INJECT1_1 = "NO";
    LUT4 i1459_2_lut_2_lut (.A(next_state_3__N_542[2]), .B(n5669), .Z(FlexMIOs53_GPIO_PowerDown_N_755)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i1459_2_lut_2_lut.init = 16'h4444;
    LUT4 i2726_4_lut_4_lut (.A(next_state[0]), .B(n5682), .C(next_state[1]), 
         .D(externstop_falling), .Z(n5345)) /* synthesis lut_function=(!(A (B (C)+!B (C+!(D)))+!A !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i2726_4_lut_4_lut.init = 16'h5f0d;
    LUT4 i2778_4_lut (.A(n5667), .B(n3622), .C(next_state[2]), .D(n17), 
         .Z(clk_enable_85)) /* synthesis lut_function=(!(A+(B+!(C+!(D))))) */ ;
    defparam i2778_4_lut.init = 16'h1011;
    LUT4 i36_4_lut_4_lut (.A(next_state_3__N_542[2]), .B(next_state[0]), 
         .C(next_state[3]), .D(n5669), .Z(n19)) /* synthesis lut_function=(!(A (C+!(D))+!A !(B (C+(D))+!B !(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i36_4_lut_4_lut.init = 16'h4f40;
    CCU2D add_194_11 (.A0(\debounce_counters[4] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4891), .COUT(n4892), .S0(n515), 
          .S1(n514));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_11.INIT0 = 16'h5aaa;
    defparam add_194_11.INIT1 = 16'h5aaa;
    defparam add_194_11.INJECT1_0 = "NO";
    defparam add_194_11.INJECT1_1 = "NO";
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut (.A(DIGS3C_SlotD_ReqOE_c_4), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_4)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(206[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut.init = 16'h2222;
    CCU2D add_2354_14 (.A0(\debounce_counters[4] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4957), .COUT(n4958));
    defparam add_2354_14.INIT0 = 16'h5555;
    defparam add_2354_14.INIT1 = 16'h5555;
    defparam add_2354_14.INJECT1_0 = "NO";
    defparam add_2354_14.INJECT1_1 = "NO";
    CCU2D add_2357_12 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4919), .COUT(n4920));
    defparam add_2357_12.INIT0 = 16'h5555;
    defparam add_2357_12.INIT1 = 16'h5555;
    defparam add_2357_12.INJECT1_0 = "NO";
    defparam add_2357_12.INJECT1_1 = "NO";
    CCU2D add_194_9 (.A0(\debounce_counters[4] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4890), .COUT(n4891), .S0(n517), 
          .S1(n516));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_9.INIT0 = 16'h5aaa;
    defparam add_194_9.INIT1 = 16'h5aaa;
    defparam add_194_9.INJECT1_0 = "NO";
    defparam add_194_9.INJECT1_1 = "NO";
    CCU2D add_185_3 (.A0(\debounce_counters[3] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4871), .COUT(n4872), .S0(n417), 
          .S1(n416));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_3.INIT0 = 16'h5aaa;
    defparam add_185_3.INIT1 = 16'h5aaa;
    defparam add_185_3.INJECT1_0 = "NO";
    defparam add_185_3.INJECT1_1 = "NO";
    CCU2D add_2357_10 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4918), .COUT(n4919));
    defparam add_2357_10.INIT0 = 16'h5555;
    defparam add_2357_10.INIT1 = 16'h5555;
    defparam add_2357_10.INJECT1_0 = "NO";
    defparam add_2357_10.INJECT1_1 = "NO";
    CCU2D add_176_3 (.A0(\debounce_counters[2] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4855), .COUT(n4856), .S0(n311), 
          .S1(n310));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_3.INIT0 = 16'h5aaa;
    defparam add_176_3.INIT1 = 16'h5aaa;
    defparam add_176_3.INJECT1_0 = "NO";
    defparam add_176_3.INJECT1_1 = "NO";
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut (.A(DIGS3C_SlotD_ReqOE_c_3), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_3)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(206[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut.init = 16'h2222;
    LUT4 i6_2_lut (.A(FP_UsrSW2_c), .B(FlexIO03_c), .Z(n70)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i6_2_lut.init = 16'h8888;
    CCU2D add_2354_12 (.A0(\debounce_counters[4] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4956), .COUT(n4957));
    defparam add_2354_12.INIT0 = 16'h5555;
    defparam add_2354_12.INIT1 = 16'h5555;
    defparam add_2354_12.INJECT1_0 = "NO";
    defparam add_2354_12.INJECT1_1 = "NO";
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut (.A(DIGS3C_SlotD_ReqOE_c_2), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_2)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(206[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut.init = 16'h2222;
    LUT4 i44_4_lut (.A(ANL_S3C_SLOTOK_c_3), .B(DIGS3C_SlotD_SlotOK_c_4), 
         .C(DIGS3C_SlotD_SlotOK_c_3), .D(DIG5S3C00_out), .Z(n108_adj_13)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i44_4_lut.init = 16'h8000;
    CCU2D add_2357_8 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4917), .COUT(n4918));
    defparam add_2357_8.INIT0 = 16'h5555;
    defparam add_2357_8.INIT1 = 16'h5aaa;
    defparam add_2357_8.INJECT1_0 = "NO";
    defparam add_2357_8.INJECT1_1 = "NO";
    CCU2D add_2357_6 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4916), .COUT(n4917));
    defparam add_2357_6.INIT0 = 16'h5555;
    defparam add_2357_6.INIT1 = 16'h5aaa;
    defparam add_2357_6.INJECT1_0 = "NO";
    defparam add_2357_6.INJECT1_1 = "NO";
    CCU2D add_2354_10 (.A0(\debounce_counters[4] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4955), .COUT(n4956));
    defparam add_2354_10.INIT0 = 16'h5555;
    defparam add_2354_10.INIT1 = 16'h5555;
    defparam add_2354_10.INJECT1_0 = "NO";
    defparam add_2354_10.INJECT1_1 = "NO";
    CCU2D add_194_7 (.A0(\debounce_counters[4] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4889), .COUT(n4890), .S0(n519), 
          .S1(n518));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_7.INIT0 = 16'h5aaa;
    defparam add_194_7.INIT1 = 16'h5aaa;
    defparam add_194_7.INJECT1_0 = "NO";
    defparam add_194_7.INJECT1_1 = "NO";
    CCU2D add_194_5 (.A0(\debounce_counters[4] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4888), .COUT(n4889), .S0(n521), 
          .S1(n520));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_5.INIT0 = 16'h5aaa;
    defparam add_194_5.INIT1 = 16'h5aaa;
    defparam add_194_5.INJECT1_0 = "NO";
    defparam add_194_5.INJECT1_1 = "NO";
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut (.A(DIGS3C_SlotD_ReqOE_c_1), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_1)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(206[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut.init = 16'h2222;
    CCU2D add_2357_4 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4915), .COUT(n4916));
    defparam add_2357_4.INIT0 = 16'h5555;
    defparam add_2357_4.INIT1 = 16'h5555;
    defparam add_2357_4.INJECT1_0 = "NO";
    defparam add_2357_4.INJECT1_1 = "NO";
    CCU2D add_2357_2 (.A0(\debounce_counters[1] [7]), .B0(\debounce_counters[1] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[1] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n4915));
    defparam add_2357_2.INIT0 = 16'h1000;
    defparam add_2357_2.INIT1 = 16'h5aaa;
    defparam add_2357_2.INJECT1_0 = "NO";
    defparam add_2357_2.INJECT1_1 = "NO";
    LUT4 mux_623_i9_4_lut (.A(next_state[1]), .B(n1792), .C(n2688), .D(n2684), 
         .Z(n2598)) /* synthesis lut_function=(!(A (((D)+!C)+!B)+!A (B (C (D))+!B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_623_i9_4_lut.init = 16'h05c5;
    CCU2D add_2355_26 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4914), .S1(clk_enable_19));
    defparam add_2355_26.INIT0 = 16'hf555;
    defparam add_2355_26.INIT1 = 16'h0000;
    defparam add_2355_26.INJECT1_0 = "NO";
    defparam add_2355_26.INJECT1_1 = "NO";
    LUT4 n5865_bdd_4_lut (.A(n5865), .B(next_state[1]), .C(n5864), .D(externstop_falling), 
         .Z(n5899)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))+!A (C (D))) */ ;
    defparam n5865_bdd_4_lut.init = 16'hf088;
    LUT4 mux_623_i10_4_lut (.A(next_state[1]), .B(n1791), .C(n2688), .D(n2684), 
         .Z(n2597)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_623_i10_4_lut.init = 16'hfaca;
    CCU2D add_2355_24 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4913), .COUT(n4914));
    defparam add_2355_24.INIT0 = 16'h5555;
    defparam add_2355_24.INIT1 = 16'h5555;
    defparam add_2355_24.INJECT1_0 = "NO";
    defparam add_2355_24.INJECT1_1 = "NO";
    CCU2D add_2354_8 (.A0(\debounce_counters[4] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4954), .COUT(n4955));
    defparam add_2354_8.INIT0 = 16'h5555;
    defparam add_2354_8.INIT1 = 16'h5aaa;
    defparam add_2354_8.INJECT1_0 = "NO";
    defparam add_2354_8.INJECT1_1 = "NO";
    CCU2D add_2354_6 (.A0(\debounce_counters[4] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4953), .COUT(n4954));
    defparam add_2354_6.INIT0 = 16'h5555;
    defparam add_2354_6.INIT1 = 16'h5aaa;
    defparam add_2354_6.INJECT1_0 = "NO";
    defparam add_2354_6.INJECT1_1 = "NO";
    LUT4 mux_632_i13_4_lut (.A(n1788), .B(n5683), .C(n2690), .D(n3271), 
         .Z(n2628)) /* synthesis lut_function=(!(A (B (C))+!A (B (C+!(D))+!B !(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_632_i13_4_lut.init = 16'h3f3a;
    CCU2D add_2355_22 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4912), .COUT(n4913));
    defparam add_2355_22.INIT0 = 16'h5555;
    defparam add_2355_22.INIT1 = 16'h5555;
    defparam add_2355_22.INJECT1_0 = "NO";
    defparam add_2355_22.INJECT1_1 = "NO";
    CCU2D add_185_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[3] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n4871), .S1(n418));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_185_1.INIT0 = 16'hF000;
    defparam add_185_1.INIT1 = 16'h5555;
    defparam add_185_1.INJECT1_0 = "NO";
    defparam add_185_1.INJECT1_1 = "NO";
    LUT4 i22_2_lut (.A(ANL_S3C_P54_Legacy_c), .B(ANL_S3C_SLOTOK_c_2), .Z(n86)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(173[17] 184[58])
    defparam i22_2_lut.init = 16'h8888;
    CCU2D add_194_3 (.A0(\debounce_counters[4] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4887), .COUT(n4888), .S0(n523), 
          .S1(n522));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_194_3.INIT0 = 16'h5aaa;
    defparam add_194_3.INIT1 = 16'h5aaa;
    defparam add_194_3.INJECT1_0 = "NO";
    defparam add_194_3.INJECT1_1 = "NO";
    CCU2D add_2354_4 (.A0(\debounce_counters[4] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4952), .COUT(n4953));
    defparam add_2354_4.INIT0 = 16'h5555;
    defparam add_2354_4.INIT1 = 16'h5555;
    defparam add_2354_4.INJECT1_0 = "NO";
    defparam add_2354_4.INJECT1_1 = "NO";
    CCU2D add_2354_2 (.A0(\debounce_counters[4] [7]), .B0(\debounce_counters[4] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[4] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n4952));
    defparam add_2354_2.INIT0 = 16'h1000;
    defparam add_2354_2.INIT1 = 16'h5aaa;
    defparam add_2354_2.INJECT1_0 = "NO";
    defparam add_2354_2.INJECT1_1 = "NO";
    CCU2D add_438_25 (.A0(counter[23]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[24]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4950), .S0(n1777), .S1(n1776));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[17:24])
    defparam add_438_25.INIT0 = 16'h5555;
    defparam add_438_25.INIT1 = 16'h5555;
    defparam add_438_25.INJECT1_0 = "NO";
    defparam add_438_25.INJECT1_1 = "NO";
    LUT4 mux_623_i19_4_lut (.A(next_state[1]), .B(n1782), .C(n2688), .D(n2684), 
         .Z(n2588)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_623_i19_4_lut.init = 16'hf5c5;
    CCU2D add_2355_20 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4911), .COUT(n4912));
    defparam add_2355_20.INIT0 = 16'h5555;
    defparam add_2355_20.INIT1 = 16'h5555;
    defparam add_2355_20.INJECT1_0 = "NO";
    defparam add_2355_20.INJECT1_1 = "NO";
    LUT4 mux_623_i20_4_lut (.A(next_state[1]), .B(n1781), .C(n2688), .D(n2684), 
         .Z(n2587)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_623_i20_4_lut.init = 16'hf5c5;
    CCU2D add_176_33 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4870), .S0(n281));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(217[49:69])
    defparam add_176_33.INIT0 = 16'h5aaa;
    defparam add_176_33.INIT1 = 16'h0000;
    defparam add_176_33.INJECT1_0 = "NO";
    defparam add_176_33.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i2 (.D(n416), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i3 (.D(n415), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i4 (.D(n414), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i5 (.D(n413), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i6 (.D(n412), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i7 (.D(n411), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i8 (.D(n410), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i9 (.D(n409), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i10 (.D(n408), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i11 (.D(n407), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i12 (.D(n406), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i13 (.D(n405), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i14 (.D(n404), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i15 (.D(n403), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i16 (.D(n402), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i17 (.D(n401), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i18 (.D(n400), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i19 (.D(n399), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i20 (.D(n398), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i21 (.D(n397), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i22 (.D(n396), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i23 (.D(n395), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i24 (.D(n394), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i25 (.D(n393), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i26 (.D(n392), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i27 (.D(n391), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i28 (.D(n390), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i29 (.D(n389), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i30 (.D(n388), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i31 (.D(n387), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam debounce_counters_3___i31.GSR = "ENABLED";
    CCU2D add_438_23 (.A0(counter[21]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[22]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4949), .COUT(n4950), .S0(n1779), .S1(n1778));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[17:24])
    defparam add_438_23.INIT0 = 16'h5555;
    defparam add_438_23.INIT1 = 16'h5555;
    defparam add_438_23.INJECT1_0 = "NO";
    defparam add_438_23.INJECT1_1 = "NO";
    LUT4 n5685_bdd_4_lut (.A(n5685), .B(next_state[0]), .C(next_state_3__N_542[2]), 
         .D(next_state[1]), .Z(n20)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C))+!A (B (C+!(D))+!B !(C (D))))) */ ;
    defparam n5685_bdd_4_lut.init = 16'h3c20;
    LUT4 i2687_2_lut (.A(next_state[3]), .B(next_state[1]), .Z(n5306)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2687_2_lut.init = 16'heeee;
    LUT4 mux_623_i21_4_lut (.A(next_state[1]), .B(n1780), .C(n2688), .D(n2684), 
         .Z(n2586)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_623_i21_4_lut.init = 16'hf5c5;
    LUT4 next_state_0__bdd_3_lut_4_lut (.A(signals_debounced_syn[4]), .B(externstop_falling), 
         .C(next_state_3__N_542[2]), .D(next_state[0]), .Z(n5620)) /* synthesis lut_function=(A (B (C+(D))+!B (D))+!A (C+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(408[5] 416[12])
    defparam next_state_0__bdd_3_lut_4_lut.init = 16'hffd0;
    LUT4 i1_4_lut_adj_11 (.A(next_state[2]), .B(next_state_3__N_542[2]), 
         .C(next_state_3__N_538[2]), .D(next_state[0]), .Z(n40)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i1_4_lut_adj_11.init = 16'ha088;
    LUT4 FPIO_isoCtrlRSTn_N_744_bdd_4_lut_2860 (.A(next_state_3__N_538[3]), 
         .B(next_state[1]), .C(next_state[0]), .D(next_state_3__N_542[2]), 
         .Z(n5583)) /* synthesis lut_function=(A (B+(C+!(D)))+!A (B (C)+!B !(C+(D)))) */ ;
    defparam FPIO_isoCtrlRSTn_N_744_bdd_4_lut_2860.init = 16'he8eb;
    LUT4 next_state_0__bdd_4_lut_2855 (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[3]), .D(next_state[2]), .Z(clk_enable_13)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B+(C+!(D)))) */ ;
    defparam next_state_0__bdd_4_lut_2855.init = 16'hfedf;
    LUT4 next_state_1__bdd_4_lut_2853 (.A(next_state[1]), .B(next_state[2]), 
         .C(next_state[0]), .D(next_state[3]), .Z(clk_enable_139)) /* synthesis lut_function=(A (B (C+(D)))+!A (B ((D)+!C)+!B !(C+(D)))) */ ;
    defparam next_state_1__bdd_4_lut_2853.init = 16'hcc85;
    LUT4 mux_632_i23_4_lut (.A(n1778), .B(n5683), .C(n2690), .D(n3271), 
         .Z(n2618)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_632_i23_4_lut.init = 16'h303a;
    LUT4 FPIO_isoCtrlRSTn_N_744_bdd_3_lut_2863 (.A(next_state_3__N_538[3]), 
         .B(next_state[1]), .C(next_state[0]), .Z(n5582)) /* synthesis lut_function=(!((B (C)+!B !(C))+!A)) */ ;
    defparam FPIO_isoCtrlRSTn_N_744_bdd_3_lut_2863.init = 16'h2828;
    LUT4 mux_632_i24_4_lut (.A(n1777), .B(n5683), .C(n2690), .D(n3271), 
         .Z(n2617)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_632_i24_4_lut.init = 16'h303a;
    LUT4 mux_632_i25_4_lut (.A(n1776), .B(n5683), .C(n2690), .D(n3271), 
         .Z(n2616)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_632_i25_4_lut.init = 16'h303a;
    LUT4 i1_2_lut_3_lut_adj_12 (.A(next_state_3__N_542[2]), .B(signals_debounced_syn[3]), 
         .C(externstop_falling), .Z(n3477)) /* synthesis lut_function=(!(A+((C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(346[17] 356[12])
    defparam i1_2_lut_3_lut_adj_12.init = 16'h0404;
    LUT4 next_state_3__bdd_4_lut_2880_4_lut (.A(next_state[0]), .B(next_state_3__N_542[2]), 
         .C(next_state[1]), .D(next_state[2]), .Z(n5581)) /* synthesis lut_function=(!(A (C+(D))+!A (B+((D)+!C)))) */ ;
    defparam next_state_3__bdd_4_lut_2880_4_lut.init = 16'h001a;
    LUT4 i2783_2_lut_3_lut (.A(next_state_3__N_542[2]), .B(signals_debounced_syn[3]), 
         .C(externstop_falling), .Z(n3927)) /* synthesis lut_function=(!(A (C)+!A (B+(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(346[17] 356[12])
    defparam i2783_2_lut_3_lut.init = 16'h0b0b;
    LUT4 n5828_bdd_3_lut (.A(n5899), .B(n5823), .C(next_state[0]), .Z(next_state_3__N_61[1])) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam n5828_bdd_3_lut.init = 16'hcaca;
    LUT4 pushed_4__I_0_1_lut (.A(pushed[4]), .Z(pushed_4__N_288)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(226[17] 230[24])
    defparam pushed_4__I_0_1_lut.init = 16'h5555;
    LUT4 i40_4_lut_adj_13 (.A(next_state[3]), .B(n24), .C(next_state[2]), 
         .D(n20), .Z(clk_enable_130)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B (C)))) */ ;
    defparam i40_4_lut_adj_13.init = 16'h353f;
    LUT4 i1486_3_lut_4_lut (.A(next_state[3]), .B(next_state_3__N_542[2]), 
         .C(signals_debounced_syn[3]), .D(externstop_falling), .Z(next_state_3__N_538[3])) /* synthesis lut_function=(!(A (B (D)+!B (C+(D)))+!A (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(365[17] 373[12])
    defparam i1486_3_lut_4_lut.init = 16'h008f;
    LUT4 ANL_S3C_CarrierReady_c_bdd_2_lut_2877 (.A(n5584), .B(next_state[2]), 
         .Z(n5585)) /* synthesis lut_function=(A (B)) */ ;
    defparam ANL_S3C_CarrierReady_c_bdd_2_lut_2877.init = 16'h8888;
    TSALL TSALL_INST (.TSALL(GND_net));
    LUT4 i2679_2_lut_3_lut (.A(signals_debounced_syn[2]), .B(extern_connected), 
         .C(n5669), .Z(n5298)) /* synthesis lut_function=(A (C)+!A (B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam i2679_2_lut_3_lut.init = 16'hf4f4;
    PFUMX i2903 (.BLUT(n5695), .ALUT(n5696), .C0(n3477), .Z(n5697));
    LUT4 next_state_3__I_0_417_Mux_0_i15_4_lut (.A(n5346), .B(n5621), .C(next_state[3]), 
         .D(next_state[2]), .Z(next_state_3__N_61[0])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam next_state_3__I_0_417_Mux_0_i15_4_lut.init = 16'h0aca;
    PFUMX i2838 (.BLUT(n5561), .ALUT(n5560), .C0(next_state[0]), .Z(n5562));
    LUT4 i1540_2_lut_3_lut (.A(n1784), .B(n2688), .C(n2684), .Z(n2590)) /* synthesis lut_function=(A+((C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i1540_2_lut_3_lut.init = 16'hfbfb;
    LUT4 i3_4_lut_rep_65 (.A(n5669), .B(n5306), .C(next_state[2]), .D(n5674), 
         .Z(n5667)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[2] 456[9])
    defparam i3_4_lut_rep_65.init = 16'h2000;
    LUT4 i2780_2_lut_3_lut (.A(n2688), .B(n2690), .C(clk_enable_142), 
         .Z(n3894)) /* synthesis lut_function=(A (B (C))+!A (C)) */ ;
    defparam i2780_2_lut_3_lut.init = 16'hd0d0;
    LUT4 next_state_1__bdd_4_lut_2866 (.A(next_state[1]), .B(next_state[0]), 
         .C(next_state[3]), .D(next_state[2]), .Z(FP_SysLEDb_N_739)) /* synthesis lut_function=(!(A (B (C+(D))+!B (C (D)))+!A (D))) */ ;
    defparam next_state_1__bdd_4_lut_2866.init = 16'h027f;
    LUT4 i2705_2_lut_rep_70_3_lut (.A(next_state[1]), .B(next_state[2]), 
         .C(next_state[0]), .Z(n5672)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i2705_2_lut_rep_70_3_lut.init = 16'hfefe;
    PFUMX i2972 (.BLUT(n5822), .ALUT(n5821), .C0(next_state[1]), .Z(n5823));
    LUT4 i2759_3_lut_rep_64_4_lut (.A(next_state[1]), .B(n5681), .C(n5563), 
         .D(n5310), .Z(clk_enable_142)) /* synthesis lut_function=(A (C)+!A (B (C (D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i2759_3_lut_rep_64_4_lut.init = 16'hf0b0;
    LUT4 i2_2_lut_adj_14 (.A(counter[17]), .B(counter[22]), .Z(n27_adj_3)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2_2_lut_adj_14.init = 16'heeee;
    LUT4 i21_4_lut (.A(counter[11]), .B(n42), .C(n32), .D(counter[20]), 
         .Z(n46)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i21_4_lut.init = 16'hfffe;
    LUT4 mux_441_Mux_3_i15_4_lut_4_lut (.A(next_state[1]), .B(next_state[2]), 
         .C(next_state[3]), .D(next_state[0]), .Z(FP_SysLEDs_N_751)) /* synthesis lut_function=(!(A (C+!(D))+!A (B (C)))) */ ;
    defparam mux_441_Mux_3_i15_4_lut_4_lut.init = 16'h1f15;
    PFUMX i2901 (.BLUT(n5692), .ALUT(n5693), .C0(next_state[1]), .Z(clk_enable_15));
    LUT4 i1_2_lut_adj_15 (.A(signals_debounced_syn[2]), .B(externstop_last), 
         .Z(externstop_falling_N_764)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(209[9] 235[10])
    defparam i1_2_lut_adj_15.init = 16'h4444;
    PFUMX i2899 (.BLUT(n5689), .ALUT(n5690), .C0(next_state[1]), .Z(n5691));
    LUT4 i899_2_lut_rep_83 (.A(signals_debounced_syn[4]), .B(externstop_falling), 
         .Z(n5685)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(408[5] 416[12])
    defparam i899_2_lut_rep_83.init = 16'h2222;
    LUT4 mux_441_Mux_12_i15_4_lut (.A(PPn_VIN_c), .B(next_state[3]), .C(next_state[2]), 
         .D(next_state[1]), .Z(forceoutputdisable_N_8)) /* synthesis lut_function=(!(A (B (C+!(D))+!B (C))+!A (B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam mux_441_Mux_12_i15_4_lut.init = 16'h1f17;
    LUT4 i15_4_lut (.A(counter[15]), .B(counter[3]), .C(counter[1]), .D(counter[24]), 
         .Z(n40_adj_1)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i15_4_lut.init = 16'hfffe;
    LUT4 i1_3_lut_4_lut_adj_16 (.A(next_state[1]), .B(n5681), .C(next_state[2]), 
         .D(externstop_falling), .Z(n11)) /* synthesis lut_function=(A (C)+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i1_3_lut_4_lut_adj_16.init = 16'hf4f0;
    LUT4 pushed_3__I_0_1_lut (.A(pushed[3]), .Z(pushed_3__N_290)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(226[17] 230[24])
    defparam pushed_3__I_0_1_lut.init = 16'h5555;
    LUT4 i53_4_lut_4_lut (.A(next_state[2]), .B(n5669), .C(next_state_3__N_538[2]), 
         .D(next_state[0]), .Z(n33_adj_2)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(279[9] 455[18])
    defparam i53_4_lut_4_lut.init = 16'hdda0;
    LUT4 mux_441_Mux_11_i6_3_lut_4_lut (.A(next_state_3__N_542[2]), .B(n5669), 
         .C(next_state[1]), .D(next_state[0]), .Z(n6)) /* synthesis lut_function=(A (C (D))+!A (B (C (D))+!B (C (D)+!C !(D)))) */ ;
    defparam mux_441_Mux_11_i6_3_lut_4_lut.init = 16'hf001;
    PFUMX i2897 (.BLUT(n5686), .ALUT(n5687), .C0(next_state[1]), .Z(n5688));
    LUT4 pushed_2__I_0_1_lut (.A(pushed[2]), .Z(pushed_2__N_292)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(226[17] 230[24])
    defparam pushed_2__I_0_1_lut.init = 16'h5555;
    
endmodule
//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

