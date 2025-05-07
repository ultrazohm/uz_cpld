// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Wed May 07 13:50:58 2025
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
            TDnALERT, S3C_S1, GPO, IRQ, GPI, RST_N, INTQ);   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(8[8:42])
    output FP_SysLEDg;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(25[3:13])
    output FP_SysLEDr;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(26[3:13])
    output FP_SysLEDb;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(27[3:13])
    output FlexIO05;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(28[3:11])
    input FlexIO04;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(29[3:11])
    input FlexIO03;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(30[3:11])
    output FlexIO02;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(31[3:11])
    output FlexIO01;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(32[3:11])
    input FP_UsrSW1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(33[3:12])
    input FP_UsrSW2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(34[3:12])
    input SCL /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(36[3:6])
    input SDA /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(37[3:6])
    input FP_UsrSW3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(38[3:12])
    input SysSW_Pwr_NC;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(39[3:15])
    output FPIO_isoCtrlRSTn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(40[3:19])
    input FPIO_iosCtrlINTn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(41[3:19])
    output Carrier_PG_3V3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(42[3:17])
    input FPIO_ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(43[3:20])
    inout FPIO_FlexMIO28;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(44[3:17])
    inout FPIO_FlexMIO27;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(45[3:17])
    inout FPIO_FlexMIO30;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(46[3:17])
    inout FPIO_FlexMIO29;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(47[3:17])
    output FPIO_FlexMIO52;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(48[3:17])
    output Carrier_PG_1V8;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(50[3:17])
    inout S3CsI2C_SDA /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(51[3:14])
    inout S3CsI2C_SCL /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(52[3:14])
    output FP_SysLEDs;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(53[3:13])
    input SD1_CD;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(54[3:9])
    input SD0_CD;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(55[3:9])
    input SPI_S3C_nCS_USR;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(56[3:18])
    output [4:1]FP_UsrLED;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(57[3:12])
    output DIGS3C_Shared_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(58[3:29])
    output DIGS3C_Shared_ReqSafeState;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(59[3:29])
    input [5:1]DIGS3C_SlotD_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(60[3:21])
    input [5:1]DIGS3C_SlotD_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(61[3:22])
    input [5:0]FlexLIO;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(62[3:10])
    inout DIG5S3C26;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(64[3:12])
    inout DIG5S3C25;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(65[3:12])
    inout DIG5S3C24;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(66[3:12])
    output SD_SEL;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(67[3:9])
    input FlexMIOs52_PCIe;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(69[3:18])
    output FlexMIOs53_GPIO_PowerDown;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(70[3:28])
    inout FlexMIOs54;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(71[3:13])
    output FlexMio61ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(72[3:24])
    inout FlexMIOs62;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(73[3:13])
    inout FlexMIOs63;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(74[3:13])
    inout FlexMIOs31;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(75[3:13])
    inout FlexMIOs30;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(76[3:13])
    inout FlexMIOs29;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(77[3:13])
    inout FlexMIOs28;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(78[3:13])
    inout FlexMIOs27;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(79[3:13])
    inout FlexMIOs26;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(80[3:13])
    input FlexMIOs45 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(81[3:13])
    inout FlexMIOs37;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(82[3:13])
    inout FlexMIOs36;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(83[3:13])
    inout FlexMIOs35;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(84[3:13])
    inout FlexMIOs34;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(85[3:13])
    inout FlexMIOs33;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(86[3:13])
    inout FlexMIOs32;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(87[3:13])
    inout DIG5S3C03;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(89[3:12])
    inout DIG5S3C04;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(90[3:12])
    inout DIG5S3C05;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(91[3:12])
    inout DIG5S3C00;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(92[3:12])
    inout DIG5S3C02;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(93[3:12])
    inout DIG5S3C01;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(94[3:12])
    inout DIG5S3C29;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(95[3:12])
    inout DIG5S3C28;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(96[3:12])
    inout DIG5S3C27;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(97[3:12])
    input [3:1]ANL_S3C_SLOTOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(100[3:17])
    output ANL_S3C_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(101[3:23])
    input ANL_S3C_P54_Legacy /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(102[3:21])
    output [5:1]DIGS3C_SlotD_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(103[3:22])
    output Carrier_PwrOn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(106[9:22])
    input PG_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(107[3:9])
    input PPn_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(108[3:10])
    input PG_Module;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(109[3:12])
    input TDnSHDN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(110[3:10])
    input TDnFFnFS /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(111[3:11])
    input TDnALERT;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(112[3:11])
    input S3C_S1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(113[3:9])
    output [7:0]GPO;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(116[3:6])
    input [3:0]IRQ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    input [7:0]GPI;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(118[3:6])
    input RST_N;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(119[3:8])
    output INTQ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(120[3:7])
    
    wire IRQ_c_3 /* synthesis is_clock=1, SET_AS_NETWORK=IRQ_c_3 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    wire IRQ_c_2 /* synthesis is_clock=1, SET_AS_NETWORK=IRQ_c_2 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    wire IRQ_c_1 /* synthesis is_clock=1, SET_AS_NETWORK=IRQ_c_1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    wire IRQ_c_0 /* synthesis is_clock=1, SET_AS_NETWORK=IRQ_c_0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    wire clk /* synthesis SET_AS_NETWORK=clk, is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(128[9:12])
    wire dummy_signal /* synthesis noclip="on" */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(179[9:21])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(40[12:21])
    
    wire GND_net, VCC_net, FP_SysLEDg_c, FP_SysLEDr_c, FP_SysLEDb_c, 
        FlexIO04_c, FlexIO03_c, n5039, FP_UsrSW1_c, FP_UsrSW2_c, SCL_c, 
        SDA_c, FP_UsrSW3_c, SysSW_Pwr_NC_c, FPIO_isoCtrlRSTn_c, FPIO_iosCtrlINTn_c, 
        Carrier_PG_3V3_c, FlexMio61ExternalStop_c_c, n9802, FPIO_FlexMIO52_c_c, 
        FP_SysLEDs_c, SD1_CD_c, SD0_CD_c, SPI_S3C_nCS_USR_c, FP_UsrLED_c_3, 
        FP_UsrLED_c_2, DIGS3C_Shared_ReqSafeState_c, DIGS3C_SlotD_ReqOE_c_5, 
        DIGS3C_SlotD_ReqOE_c_4, DIGS3C_SlotD_ReqOE_c_3, DIGS3C_SlotD_ReqOE_c_2, 
        DIGS3C_SlotD_ReqOE_c_1, DIGS3C_SlotD_SlotOK_c_5, DIGS3C_SlotD_SlotOK_c_4, 
        DIGS3C_SlotD_SlotOK_c_3, DIGS3C_SlotD_SlotOK_c_2, DIGS3C_SlotD_SlotOK_c_1, 
        FlexLIO_c_5, FlexLIO_c_4, FlexLIO_c_3, FlexLIO_c_2, FlexLIO_c_1, 
        FlexLIO_c_0, n9768, FlexMIOs53_GPIO_PowerDown_c, n15, n9593, 
        n14, FlexMIOs45_c, n9592, n9232, n9208, ANL_S3C_SLOTOK_c_3, 
        ANL_S3C_SLOTOK_c_2, ANL_S3C_SLOTOK_c_1, ANL_S3C_P54_Legacy_c, 
        DIGS3C_SlotD_SlotOE_c_5, DIGS3C_SlotD_SlotOE_c_4, DIGS3C_SlotD_SlotOE_c_3, 
        DIGS3C_SlotD_SlotOE_c_2, DIGS3C_SlotD_SlotOE_c_1, Carrier_PwrOn_c, 
        PG_VIN_c, PPn_VIN_c, PG_Module_c, TDnSHDN_c, TDnFFnFS_c, TDnALERT_c, 
        S3C_S1_c, GPO_c_7, GPO_c_6, GPO_c_5, GPO_c_4, GPO_c_3, GPO_c_2, 
        GPO_c_1, GPO_c_0, GPI_c_7, GPI_c_6, GPI_c_5, GPI_c_4, GPI_c_3, 
        GPI_c_2, GPI_c_1, GPI_c_0, RST_N_c;
    wire [24:0]counter;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(129[9:16])
    wire [24:0]resetcounter;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(130[9:21])
    wire [3:0]next_state;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(136[12:22])
    wire [31:0]\debounce_counters[1] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(143[12:29])
    wire [31:0]\debounce_counters[2] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(143[12:29])
    wire [31:0]\debounce_counters[3] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(143[12:29])
    wire [31:0]\debounce_counters[4] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(143[12:29])
    
    wire n8570, n8528, n8569, n8527, n8568, n8567, n8526, n8525, 
        n8524, n25, n8, n9767, n9757, n32, n9241, n28;
    wire [6:1]debounce_inputs_asyn1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(145[12:33])
    
    wire clk_enable_189;
    wire [6:1]debounce_inputs_asyn2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(146[9:30])
    wire [6:1]pushed;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(147[9:15])
    wire [6:1]signals_debounced_syn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(148[12:33])
    
    wire n8732, externstop_falling, externstop_last, extern_connected, 
        forceoutputdisable;
    wire [7:0]wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(271[8:16])
    
    wire wb_stb_i;
    wire [7:0]wb_adr_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(274[8:16])
    
    wire n8523, n9766, wb_we_i;
    wire [7:0]wb_dat_o;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(276[8:16])
    
    wire wb_ack_o;
    wire [7:0]data0;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(288[8:13])
    wire [7:0]temp1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(289[14:19])
    wire [7:0]temp2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(289[20:25])
    wire [7:0]temp3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(289[26:31])
    wire [7:0]n_temp1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(290[16:23])
    
    wire n9182, n15_adj_1429;
    wire [3:0]irq_en;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(291[8:14])
    wire [3:0]irq_status;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(291[17:27])
    wire [3:0]irq_clr;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(291[30:37])
    wire [3:0]irq_status_clr;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(291[39:53])
    
    wire reg_rdy, reg_rdy_del, dat_rdy, dat_rdy_del;
    wire [7:0]n_dat_count;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(298[8:19])
    wire [7:0]dat_count;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(298[22:31])
    wire [7:0]GPI_DAT;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(299[8:15])
    wire [7:0]n_wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(310[8:18])
    
    wire n_wb_stb_i, n8521;
    wire [7:0]n_wb_adr_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(312[8:18])
    
    wire n8566, n_wb_we_i, check_irq_status, n9175, n18, n40, n8565, 
        n12, n8564, n8563, n8578, n8562, n8561, n9172, n6174, 
        n8520, clk_enable_191, n175, n176, n177, n178, n179, n180, 
        n181, n182, n183, n184, n185, n186, n187, n188, n189, 
        n190, n191, n192, n193, n194, n195, n196, n197, n198, 
        n199, n200, n201, n202, n203, n204, n205, n206, n8519, 
        n8518, n7046, n8560, n8517, n8516, n7179, n8559, n8515, 
        n8558, n5916, n8514, n8585, n8557, n8513, pushed_1__N_302, 
        n281, n282, n283, n284, n285, n286, n287, n288, n289, 
        n290, n291, n292, n293, n294, n295, n296, n297, n298, 
        n299, n300, n301, n302, n303, n304, n305, n306, n307, 
        n308, n309, n310, n311, n312, n8556, n8555, n9224, n8554, 
        n8553, n8552, n8512, n8511, n8551, n8550, n8549, n8510, 
        n9142, n3, pushed_2__N_300, n387, n388, n389, n390, n391, 
        n392, n393, n394, n395, n396, n397, n398, n399, n400, 
        n401, n402, n403, n404, n405, n406, n407, n408, n409, 
        n410, n411, n412, n413, n414, n415, n416, n417, n418, 
        n8548, n8547, n8509, n8508, n8507, n2, n9301, n8546, 
        pushed_3__N_298, n8506, n493, n494, n495, n496, n497, 
        n498, n499, n500, n501, n502, n503, n504, n505, n506, 
        n507, n508, n509, n510, n511, n512, n513, n514, n515, 
        n516, n517, n518, n519, n520, n521, n522, n523, n524, 
        n8545, n17, n25_adj_1430, n32_adj_1431, n15_adj_1432, n8504, 
        n12_adj_1433, n9765, n8544, n15_adj_1434, n8503, n8543, 
        n8542, n8502, n12_adj_1435, clk_enable_25, pushed_4__N_296, 
        n15_adj_1436, n9289, n9287, n8541, n10, n8653, n8501, 
        n38, n8540, n8500, n9797, n6957, n9283, n8499, n8498, 
        n8539, n5510, n5506, n5498, n5496, n5494, n5492, n5490, 
        n5486, n5476, n8497, n8538, n8496, n5462, n8495, n9795, 
        n1, n8537, n8536, n8535, n8534, n8494, n8533, n8493, 
        n9269, n8492, n8491, n8490, n8489, n8488, externstop_falling_N_1330, 
        n17_adj_1437, n8823, n9267, n33, n15_adj_1438, reg_rdy_N_1338, 
        reg_rdy_N_1336, dat_rdy_N_1342, dat_rdy_N_1340, i2c1_sdao, i2c1_sdaoen, 
        n12_adj_1439, n8487, n8486, n9303, n8485, n7033, n8484, 
        n8483, n8482, n8481, n8480, n8532, n8531, n8530, n8479, 
        n8478, n8529, n8477, n8476, n8475, n8474, n14_adj_1440, 
        n24, n35, n8473, n8472, n8471, n8470, n8469, n8468, 
        n4637, n8467, n8466, n8465, n8464, n8463, n8462, n8461, 
        n8460, n8459, n6, n10104, clk_enable_187, n122, clk_enable_155, 
        n8458, n120, n8457, n8456, n8455, n9189, n10114, n10102, 
        n117, n9170, n9245, n116, n10101, n10100, n8454, n10099, 
        n5927, n114, n112, n111, n110, n5824, n27, n7011, n108, 
        n106, clk_enable_154, n15_adj_1441, n4935, n6181, n8453, 
        n9129, n12_adj_1442, n6949, clk_enable_153, n6945, n104, 
        n9764, n10_adj_1443, n9796, n12_adj_1444, n102, n3965, n101, 
        clk_enable_186, n100, n9756, n8452, n4, n2081, n2082, 
        n2083, n2084, n2085, n2086, n2087, n2088, n98, n12_adj_1445, 
        clk_enable_188, n16, n15_adj_1446, n96, n4694, n4643, n94, 
        n12_adj_1447;
    wire [7:0]n_dat_count_7__N_431;
    
    wire n90;
    wire [7:0]n_state_7__N_1056;
    
    wire n9750, n14_adj_1448, n9749, n9748, n9763, n86, n3_adj_1449, 
        n9469, clk_enable_13, n7, n9747, n130, n129, n128, n127, 
        n126, n9746, n125, n4693, n29, n8781, n9488, n124, n123, 
        n122_adj_1450, n121, n120_adj_1451, n119, n118, n117_adj_1452, 
        n116_adj_1453, n_temp1_7__N_351, n_temp1_7__N_352, n_temp1_7__N_353, 
        n_temp1_7__N_354, n_temp1_7__N_355, n_temp1_7__N_356, n_temp1_7__N_357, 
        n_temp1_7__N_358, n_temp1_7__N_359, n_temp1_7__N_360, i2c1_sclo, 
        n_temp1_7__N_362, n_temp1_7__N_363, i2c1_scloen, n_temp1_7__N_365, 
        n_temp1_7__N_366, n_temp1_7__N_367, n_temp1_7__N_368, n_temp1_7__N_369, 
        n115, n114_adj_1454, n8451, n85, n8450, clk_enable_182, 
        clk_enable_183, n27_adj_1455, clk_enable_126, clk_enable_89, 
        n9158, n113, n12_adj_1456, n3884, n14_adj_1457, n9520, n9519, 
        n3902, n112_adj_1458, n6_adj_1459, n82, n111_adj_1460, n110_adj_1461, 
        n109, n8449, n108_adj_1462, n107, n106_adj_1463, n4_adj_1464, 
        FPIO_FlexMIO28_out, n12_adj_1465, n8586, n8619, n4692, clk_enable_23, 
        n4691, n19;
    wire [3:0]next_state_3__N_1104;
    
    wire n9762, n4316, n4690, n15_adj_1466, n4641, n5, n8448, 
        n8447, n12_adj_1467, n9714, n8446, n3852, n9761, n9713, 
        n48, n9711, n9710, n9709, n9708, n9707, n8665, n4479, 
        n9700, n9699, n4472, n9698, n9696, n9695, n4585, n4584, 
        n4581, n20, n4575, n4574, n4573, n4571, n4570, n4569, 
        clk_enable_195, n9501, n9689, n8445, n9688, n9687, clk_enable_203, 
        n8444, n8443, n8442, n6_adj_1468, n8441, n9792, n4662, 
        n9791, n8440, n8439, n4553, n4551, n4550, n4549, n4548, 
        n4546, n4544, n4543, n4542, n8438, FlexMIOs53_GPIO_PowerDown_N_1321;
    wire [3:0]next_state_3__N_1108;
    
    wire n3137, n3138, n3139, n3140, n3141, n3142, n3143, n3144, 
        n3145, n3146, n3147, n3148, n3149, n3150, n3151, n3152, 
        n3153, n3154, n3155, n3156, n3157, n3158, n3159, n3160, 
        n3161, n4541, n4540, n4539, n9500, n10112, n8437, n9712, 
        n9790, clk_enable_27, n8436, n42, forceoutputdisable_N_8, 
        DIGS3C_Shared_ReqSafeState_N_1318, FlexMIOs53_GPIO_PowerDown_N_1320, 
        FP_SysLEDr_N_1304, FP_SysLEDb_N_1305, FP_SysLEDg_N_1303;
    wire [3:0]next_state_3__N_69;
    
    wire n9196, Carrier_PG_3V3_N_1312, FPIO_isoCtrlRSTn_N_1306, n18_adj_1469, 
        n8435, n8434, n8433, n8432, n9788, n5428, FP_SysLEDs_N_1317, 
        n9787, n74, Carrier_PG_1V8_N_1421, Carrier_PG_1V8_N_1428, Carrier_PG_1V8_N_1316, 
        n23, n8431, n8430, i2c1_sdai, n9786, n14_adj_1470, clk_enable_145, 
        clk_enable_193, clk_enable_152, clk_enable_142, clk_enable_162, 
        n9785, n5_adj_1471, n3_adj_1472, n8787, n9491, n2_adj_1473, 
        n9784, n9489, n9794, n9490, n46, n9487, n9793, n9781, 
        clk_enable_29, n70, n9486, n9780, n66, n9485, n9779, n37, 
        n9777, n9776, n9760, clk_enable_184, n43, FPIO_FlexMIO27_out, 
        FPIO_FlexMIO30_out, FPIO_FlexMIO29_out, DIG5S3C26_out, DIG5S3C25_out, 
        DIG5S3C24_out, FlexMIOs54_out, FlexMIOs62_out, FlexMIOs63_out, 
        FlexMIOs31_out, FlexMIOs30_out, n8429, FlexMIOs29_out, FlexMIOs28_out, 
        FlexMIOs27_out, FlexMIOs26_out, FlexMIOs37_out, FlexMIOs36_out, 
        FlexMIOs35_out, FlexMIOs34_out, FlexMIOs33_out, FlexMIOs32_out, 
        DIG5S3C03_out, DIG5S3C04_out, DIG5S3C05_out, DIG5S3C00_out, 
        DIG5S3C02_out, n6972, DIG5S3C01_out, n9803, DIG5S3C29_out, 
        DIG5S3C28_out, DIG5S3C27_out, n5385, n5382, n9144, n9774, 
        n9773, n9772, n4_adj_1474, n9223, n9801, n9069, clk_enable_19, 
        n9279, n9754, n9771, n6_adj_1475, n9313, n9312, n9311, 
        n9800, n9770, n9799, clk_enable_204, n9759, n28_adj_1476, 
        n9753, n9179, n9471, n9470, n9769, n9758, clk_enable_205;
    
    VHI i2 (.Z(VCC_net));
    LUT4 select_1287_Select_1_i2_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), 
         .C(n4316), .Z(n_wb_adr_i[1])) /* synthesis lut_function=(!(A (B+!(C))+!A !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam select_1287_Select_1_i2_2_lut_3_lut.init = 16'h7070;
    BB BB1_sda (.I(i2c1_sdao), .T(i2c1_sdaoen), .B(S3CsI2C_SDA), .O(i2c1_sdai)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=471, LSE_RLINE=471 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(150[14:16])
    FD1P3IX counter_i0_i14 (.D(n4479), .SP(clk_enable_205), .CD(n7033), 
            .CK(clk), .Q(counter[14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i14.GSR = "DISABLED";
    FD1P3IX counter_i0_i15 (.D(n4544), .SP(clk_enable_205), .CD(n6174), 
            .CK(clk), .Q(counter[15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i15.GSR = "DISABLED";
    CCU2D add_850_25 (.A0(counter[23]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[24]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8504), .S0(n3138), .S1(n3137));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1465[17:24])
    defparam add_850_25.INIT0 = 16'h5555;
    defparam add_850_25.INIT1 = 16'h5555;
    defparam add_850_25.INJECT1_0 = "NO";
    defparam add_850_25.INJECT1_1 = "NO";
    LUT4 irq_clr_3__I_0_i2_2_lut_2_lut (.A(RST_N_c), .B(irq_clr[1]), .Z(irq_status_clr[1])) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(488[10:21])
    defparam irq_clr_3__I_0_i2_2_lut_2_lut.init = 16'hdddd;
    CCU2D add_4634_10 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8562), .COUT(n8563));
    defparam add_4634_10.INIT0 = 16'h5555;
    defparam add_4634_10.INIT1 = 16'h5555;
    defparam add_4634_10.INJECT1_0 = "NO";
    defparam add_4634_10.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i13 (.D(n4546), .SP(clk_enable_205), .CD(n6174), 
            .CK(clk), .Q(counter[13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i13.GSR = "DISABLED";
    LUT4 i1582_3_lut_4_lut_4_lut (.A(RST_N_c), .B(n9144), .C(temp1[1]), 
         .D(temp1[0]), .Z(clk_enable_142)) /* synthesis lut_function=(!(A ((C+!(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(488[10:21])
    defparam i1582_3_lut_4_lut_4_lut.init = 16'h5d55;
    LUT4 irq_clr_3__I_0_i3_2_lut_2_lut (.A(RST_N_c), .B(irq_clr[2]), .Z(irq_status_clr[2])) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(488[10:21])
    defparam irq_clr_3__I_0_i3_2_lut_2_lut.init = 16'hdddd;
    CCU2D add_4634_8 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8561), .COUT(n8562));
    defparam add_4634_8.INIT0 = 16'h5555;
    defparam add_4634_8.INIT1 = 16'h5aaa;
    defparam add_4634_8.INJECT1_0 = "NO";
    defparam add_4634_8.INJECT1_1 = "NO";
    LUT4 i1591_3_lut_3_lut (.A(RST_N_c), .B(n5927), .C(reg_rdy_del), .Z(clk_enable_193)) /* synthesis lut_function=(!(A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(488[10:21])
    defparam i1591_3_lut_3_lut.init = 16'h7575;
    LUT4 i3327_3_lut_3_lut (.A(n8732), .B(n5824), .C(n9303), .Z(FP_UsrLED_c_3)) /* synthesis lut_function=((B+!(C))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(444[12:28])
    defparam i3327_3_lut_3_lut.init = 16'hdfdf;
    CCU2D add_4634_6 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8560), .COUT(n8561));
    defparam add_4634_6.INIT0 = 16'h5555;
    defparam add_4634_6.INIT1 = 16'h5aaa;
    defparam add_4634_6.INJECT1_0 = "NO";
    defparam add_4634_6.INJECT1_1 = "NO";
    LUT4 i31_2_lut_rep_112 (.A(next_state[0]), .B(next_state[1]), .Z(n9777)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;
    defparam i31_2_lut_rep_112.init = 16'h6666;
    FD1P3IX counter_i0_i16 (.D(n4543), .SP(clk_enable_205), .CD(n6174), 
            .CK(clk), .Q(counter[16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i16.GSR = "DISABLED";
    FD1P3IX debounce_counters_4___i11 (.D(n513), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i11.GSR = "DISABLED";
    FD1P3IX debounce_counters_4___i0 (.D(n524), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i0.GSR = "DISABLED";
    FD1P3IX debounce_counters_4___i10 (.D(n514), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i10.GSR = "DISABLED";
    CCU2D add_185_5 (.A0(\debounce_counters[3] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8462), .COUT(n8463), .S0(n415), 
          .S1(n414));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_5.INIT0 = 16'h5aaa;
    defparam add_185_5.INIT1 = 16'h5aaa;
    defparam add_185_5.INJECT1_0 = "NO";
    defparam add_185_5.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i9 (.D(n515), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i9.GSR = "DISABLED";
    CCU2D add_4634_4 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8559), .COUT(n8560));
    defparam add_4634_4.INIT0 = 16'h5555;
    defparam add_4634_4.INIT1 = 16'h5555;
    defparam add_4634_4.INJECT1_0 = "NO";
    defparam add_4634_4.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i8 (.D(n516), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i8.GSR = "DISABLED";
    LUT4 i1_2_lut_3_lut_4_lut (.A(n9766), .B(n9773), .C(clk_enable_184), 
         .D(temp1[3]), .Z(n6972)) /* synthesis lut_function=(A (C)+!A (B (C)+!B (C (D)))) */ ;
    defparam i1_2_lut_3_lut_4_lut.init = 16'hf0e0;
    FD1P3IX debounce_counters_4___i7 (.D(n517), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i7.GSR = "DISABLED";
    FD1P3IX data0__i0 (.D(n9700), .SP(clk_enable_162), .CD(n9776), .CK(clk), 
            .Q(data0[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(537[7] 550[14])
    defparam data0__i0.GSR = "DISABLED";
    FD1P3IX debounce_counters_4___i6 (.D(n518), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i6.GSR = "DISABLED";
    CCU2D add_850_23 (.A0(counter[21]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[22]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8503), .COUT(n8504), .S0(n3140), .S1(n3139));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1465[17:24])
    defparam add_850_23.INIT0 = 16'h5555;
    defparam add_850_23.INIT1 = 16'h5555;
    defparam add_850_23.INJECT1_0 = "NO";
    defparam add_850_23.INJECT1_1 = "NO";
    LUT4 n9760_bdd_3_lut_5779 (.A(n9760), .B(next_state_3__N_1104[2]), .C(next_state[1]), 
         .Z(n10100)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;
    defparam n9760_bdd_3_lut_5779.init = 16'hacac;
    FD1S3IX temp1__i0 (.D(n_temp1[0]), .CK(clk), .CD(n9776), .Q(temp1[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp1__i0.GSR = "DISABLED";
    FD1S3AY debounce_inputs_asyn2_i1 (.D(debounce_inputs_asyn1[1]), .CK(clk), 
            .Q(debounce_inputs_asyn2[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_inputs_asyn2_i1.GSR = "DISABLED";
    CCU2D add_4634_2 (.A0(\debounce_counters[2] [7]), .B0(\debounce_counters[2] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[2] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n8559));
    defparam add_4634_2.INIT0 = 16'h1000;
    defparam add_4634_2.INIT1 = 16'h5aaa;
    defparam add_4634_2.INJECT1_0 = "NO";
    defparam add_4634_2.INJECT1_1 = "NO";
    CCU2D add_850_21 (.A0(counter[19]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[20]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8502), .COUT(n8503), .S0(n3142), .S1(n3141));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1465[17:24])
    defparam add_850_21.INIT0 = 16'h5555;
    defparam add_850_21.INIT1 = 16'h5555;
    defparam add_850_21.INJECT1_0 = "NO";
    defparam add_850_21.INJECT1_1 = "NO";
    CCU2D add_4635_26 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8558), .S1(clk_enable_13));
    defparam add_4635_26.INIT0 = 16'hf555;
    defparam add_4635_26.INIT1 = 16'h0000;
    defparam add_4635_26.INJECT1_0 = "NO";
    defparam add_4635_26.INJECT1_1 = "NO";
    FD1P3IX pushed_i1 (.D(n10114), .SP(clk_enable_13), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(pushed[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam pushed_i1.GSR = "DISABLED";
    FD1S3AY signals_debounced_syn_i1 (.D(pushed_1__N_302), .CK(clk), .Q(next_state_3__N_1108[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam signals_debounced_syn_i1.GSR = "DISABLED";
    LUT4 i2_3_lut_rep_94_4_lut (.A(temp1[3]), .B(n9763), .C(n6957), .D(n9762), 
         .Z(n9759)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;
    defparam i2_3_lut_rep_94_4_lut.init = 16'he000;
    LUT4 n9760_bdd_4_lut (.A(n9791), .B(next_state[0]), .C(next_state[1]), 
         .D(next_state[2]), .Z(n10099)) /* synthesis lut_function=(!(A+(B+(C+(D))))) */ ;
    defparam n9760_bdd_4_lut.init = 16'h0001;
    FD1S3AX externstop_falling_716 (.D(externstop_falling_N_1330), .CK(clk), 
            .Q(externstop_falling));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam externstop_falling_716.GSR = "DISABLED";
    FD1S3AX externstop_last_717 (.D(signals_debounced_syn[2]), .CK(clk), 
            .Q(externstop_last));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam externstop_last_717.GSR = "DISABLED";
    FD1S3AX reg_rdy_del_720 (.D(reg_rdy), .CK(clk), .Q(reg_rdy_del));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(497[1] 510[9])
    defparam reg_rdy_del_720.GSR = "DISABLED";
    CCU2D add_850_19 (.A0(counter[17]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[18]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8501), .COUT(n8502), .S0(n3144), .S1(n3143));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1465[17:24])
    defparam add_850_19.INIT0 = 16'h5555;
    defparam add_850_19.INIT1 = 16'h5555;
    defparam add_850_19.INJECT1_0 = "NO";
    defparam add_850_19.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_4_lut_adj_97 (.A(n9766), .B(n9773), .C(dat_rdy_N_1342), 
         .D(temp1[3]), .Z(n14_adj_1457)) /* synthesis lut_function=(A+(B+((D)+!C))) */ ;
    defparam i1_2_lut_3_lut_4_lut_adj_97.init = 16'hffef;
    FD1P3IX GPI_DAT__i0 (.D(GPI_c_0), .SP(clk_enable_152), .CD(n9776), 
            .CK(clk), .Q(GPI_DAT[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(622[8] 628[15])
    defparam GPI_DAT__i0.GSR = "DISABLED";
    FD1P3IX temp2__i0 (.D(wb_dat_o[0]), .SP(reg_rdy_N_1336), .CD(n9776), 
            .CK(clk), .Q(temp2[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp2__i0.GSR = "DISABLED";
    LUT4 i3375_2_lut_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(next_state[1]), .D(next_state[0]), .Z(Carrier_PG_1V8_N_1428)) /* synthesis lut_function=(A+(B+!(C (D)+!C !(D)))) */ ;
    defparam i3375_2_lut_3_lut_4_lut.init = 16'heffe;
    FD1P3IX temp3__i0 (.D(wb_dat_o[0]), .SP(dat_rdy_N_1340), .CD(n9776), 
            .CK(clk), .Q(temp3[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp3__i0.GSR = "DISABLED";
    LUT4 i3398_2_lut_3_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[1]), 
         .Z(FPIO_isoCtrlRSTn_N_1306)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;
    defparam i3398_2_lut_3_lut.init = 16'h1010;
    FD1P3IX irq_clr__i0 (.D(temp2[0]), .SP(clk_enable_145), .CD(n9776), 
            .CK(clk), .Q(irq_clr[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(686[1] 697[10])
    defparam irq_clr__i0.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i1 (.D(temp3[0]), .SP(clk_enable_142), .CD(n9776), 
            .CK(clk), .Q(GPO_c_0));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(603[8] 611[15])
    defparam GPO_DATA_0___i1.GSR = "DISABLED";
    LUT4 i38_4_lut (.A(DIG5S3C27_out), .B(FPIO_FlexMIO27_out), .C(DIG5S3C29_out), 
         .D(FPIO_FlexMIO30_out), .Z(n100)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i38_4_lut.init = 16'h8000;
    CCU2D add_4635_24 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8557), .COUT(n8558));
    defparam add_4635_24.INIT0 = 16'h5555;
    defparam add_4635_24.INIT1 = 16'h5555;
    defparam add_4635_24.INJECT1_0 = "NO";
    defparam add_4635_24.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_2___i0 (.D(n312), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i0.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i0 (.D(n_wb_dat_i[0]), .CK(clk), .CD(n9776), .Q(wb_dat_i[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(746[1] 762[10])
    defparam wb_dat_i__i0.GSR = "DISABLED";
    PFUMX i5378 (.BLUT(n9311), .ALUT(n9312), .C0(next_state[2]), .Z(n9313));
    LUT4 i1_4_lut_4_lut (.A(next_state[3]), .B(next_state[2]), .C(n9779), 
         .D(n18), .Z(clk_enable_191)) /* synthesis lut_function=(A (B+(C))+!A (B (C+(D))+!B (D))) */ ;
    defparam i1_4_lut_4_lut.init = 16'hfde8;
    FD1S3IX wb_adr_i__i1 (.D(n_wb_adr_i[0]), .CK(clk), .CD(n9776), .Q(wb_adr_i[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(746[1] 762[10])
    defparam wb_adr_i__i1.GSR = "DISABLED";
    FD1S3IX dat_count__i0 (.D(n_dat_count[0]), .CK(clk), .CD(n9776), .Q(dat_count[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(767[1] 781[10])
    defparam dat_count__i0.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i0 (.D(n206), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i0.GSR = "DISABLED";
    PFUMX i5618 (.BLUT(n9750), .ALUT(n9746), .C0(next_state[3]), .Z(next_state_3__N_69[3]));
    LUT4 i3446_2_lut_rep_114 (.A(next_state[0]), .B(next_state[1]), .Z(n9779)) /* synthesis lut_function=(A (B)) */ ;
    defparam i3446_2_lut_rep_114.init = 16'h8888;
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk)) /* synthesis NOM_FREQ="2.08", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "2.08";
    LUT4 i3449_2_lut_3_lut (.A(next_state[0]), .B(next_state[1]), .C(next_state[2]), 
         .Z(n14_adj_1448)) /* synthesis lut_function=(!(A (B+(C))+!A (C))) */ ;
    defparam i3449_2_lut_3_lut.init = 16'h0707;
    LUT4 next_state_0__bdd_3_lut_5469 (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state_3__N_1108[2]), .Z(n9485)) /* synthesis lut_function=(!(A ((C)+!B)+!A !(B (C)))) */ ;
    defparam next_state_0__bdd_3_lut_5469.init = 16'h4848;
    FD1S3IX wb_we_i_739 (.D(n_wb_we_i), .CK(clk), .CD(n9776), .Q(wb_we_i));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(746[1] 762[10])
    defparam wb_we_i_739.GSR = "DISABLED";
    FD1S3IX dat_rdy_721 (.D(dat_rdy_N_1340), .CK(clk), .CD(n9776), .Q(dat_rdy));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(515[7] 528[11])
    defparam dat_rdy_721.GSR = "DISABLED";
    FD1P3AX forceoutputdisable_744 (.D(forceoutputdisable_N_8), .SP(clk_enable_19), 
            .CK(clk), .Q(forceoutputdisable));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam forceoutputdisable_744.GSR = "DISABLED";
    LUT4 i1_2_lut_2_lut_3_lut (.A(next_state[0]), .B(next_state[3]), .C(next_state[2]), 
         .Z(Carrier_PG_3V3_N_1312)) /* synthesis lut_function=(!((B+(C))+!A)) */ ;
    defparam i1_2_lut_2_lut_3_lut.init = 16'h0202;
    FD1P3IX debounce_counters_4___i5 (.D(n519), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i5.GSR = "DISABLED";
    CCU2D add_850_17 (.A0(counter[15]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[16]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8500), .COUT(n8501), .S0(n3146), .S1(n3145));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1465[17:24])
    defparam add_850_17.INIT0 = 16'h5555;
    defparam add_850_17.INIT1 = 16'h5555;
    defparam add_850_17.INJECT1_0 = "NO";
    defparam add_850_17.INJECT1_1 = "NO";
    LUT4 i5336_2_lut_rep_115 (.A(next_state[1]), .B(next_state[0]), .Z(n9780)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i5336_2_lut_rep_115.init = 16'heeee;
    CCU2D add_185_3 (.A0(\debounce_counters[3] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8461), .COUT(n8462), .S0(n417), 
          .S1(n416));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_3.INIT0 = 16'h5aaa;
    defparam add_185_3.INIT1 = 16'h5aaa;
    defparam add_185_3.INJECT1_0 = "NO";
    defparam add_185_3.INJECT1_1 = "NO";
    LUT4 mux_1145_Mux_2_i3_4_lut_then_4_lut (.A(signals_debounced_syn[2]), 
         .B(extern_connected), .C(n9760), .D(next_state[0]), .Z(n9794)) /* synthesis lut_function=(!(A (C)+!A (B (C+(D))+!B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam mux_1145_Mux_2_i3_4_lut_then_4_lut.init = 16'h0b0f;
    FD1P3IX debounce_counters_4___i4 (.D(n520), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i4.GSR = "DISABLED";
    FD1S3IX wb_stb_i_737 (.D(n_wb_stb_i), .CK(clk), .CD(n9776), .Q(wb_stb_i));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(746[1] 762[10])
    defparam wb_stb_i_737.GSR = "DISABLED";
    CCU2D add_4635_22 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8556), .COUT(n8557));
    defparam add_4635_22.INIT0 = 16'h5555;
    defparam add_4635_22.INIT1 = 16'h5555;
    defparam add_4635_22.INJECT1_0 = "NO";
    defparam add_4635_22.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_116 (.A(resetcounter[10]), .B(resetcounter[11]), .Z(n9781)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_rep_116.init = 16'heeee;
    PFUMX i5616 (.BLUT(n9748), .ALUT(n9747), .C0(n9760), .Z(n9749));
    CCU2D add_167_29 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8442), .COUT(n8443), .S0(n179), 
          .S1(n178));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_29.INIT0 = 16'h5aaa;
    defparam add_167_29.INIT1 = 16'h5aaa;
    defparam add_167_29.INJECT1_0 = "NO";
    defparam add_167_29.INJECT1_1 = "NO";
    CCU2D add_167_7 (.A0(\debounce_counters[1] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8431), .COUT(n8432), .S0(n201), 
          .S1(n200));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_7.INIT0 = 16'h5aaa;
    defparam add_167_7.INIT1 = 16'h5aaa;
    defparam add_167_7.INJECT1_0 = "NO";
    defparam add_167_7.INJECT1_1 = "NO";
    LUT4 n9760_bdd_3_lut (.A(next_state_3__N_1104[2]), .B(next_state_3__N_1108[2]), 
         .C(next_state[1]), .Z(n10101)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;
    defparam n9760_bdd_3_lut.init = 16'hacac;
    LUT4 i1_3_lut_4_lut (.A(resetcounter[10]), .B(resetcounter[11]), .C(resetcounter[9]), 
         .D(resetcounter[8]), .Z(n9232)) /* synthesis lut_function=(A+(B+(C (D)))) */ ;
    defparam i1_3_lut_4_lut.init = 16'hfeee;
    CCU2D add_850_15 (.A0(counter[13]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[14]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8499), .COUT(n8500), .S0(n3148), .S1(n3147));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1465[17:24])
    defparam add_850_15.INIT0 = 16'h5555;
    defparam add_850_15.INIT1 = 16'h5555;
    defparam add_850_15.INJECT1_0 = "NO";
    defparam add_850_15.INJECT1_1 = "NO";
    CCU2D add_185_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[3] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n8461), .S1(n418));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_1.INIT0 = 16'hF000;
    defparam add_185_1.INIT1 = 16'h5555;
    defparam add_185_1.INJECT1_0 = "NO";
    defparam add_185_1.INJECT1_1 = "NO";
    CCU2D add_4635_20 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8555), .COUT(n8556));
    defparam add_4635_20.INIT0 = 16'h5555;
    defparam add_4635_20.INIT1 = 16'h5555;
    defparam add_4635_20.INJECT1_0 = "NO";
    defparam add_4635_20.INJECT1_1 = "NO";
    LUT4 mux_1145_Mux_2_i3_4_lut_else_4_lut (.A(next_state[0]), .B(next_state_3__N_1108[2]), 
         .Z(n9793)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam mux_1145_Mux_2_i3_4_lut_else_4_lut.init = 16'h4444;
    CCU2D add_167_5 (.A0(\debounce_counters[1] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8430), .COUT(n8431), .S0(n203), 
          .S1(n202));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_5.INIT0 = 16'h5aaa;
    defparam add_167_5.INIT1 = 16'h5aaa;
    defparam add_167_5.INJECT1_0 = "NO";
    defparam add_167_5.INJECT1_1 = "NO";
    CCU2D add_167_27 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8441), .COUT(n8442), .S0(n181), 
          .S1(n180));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_27.INIT0 = 16'h5aaa;
    defparam add_167_27.INIT1 = 16'h5aaa;
    defparam add_167_27.INJECT1_0 = "NO";
    defparam add_167_27.INJECT1_1 = "NO";
    LUT4 mux_491_i4_3_lut_4_lut (.A(n6957), .B(clk_enable_184), .C(n2085), 
         .D(dat_count[3]), .Z(n_dat_count_7__N_431[3])) /* synthesis lut_function=(A (D)+!A (B (C)+!B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1168[7] 1187[12])
    defparam mux_491_i4_3_lut_4_lut.init = 16'hfb40;
    BB FPIO_FlexMIO28_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO28), 
       .O(FPIO_FlexMIO28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    CCU2D add_4635_18 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8554), .COUT(n8555));
    defparam add_4635_18.INIT0 = 16'h5555;
    defparam add_4635_18.INIT1 = 16'h5555;
    defparam add_4635_18.INJECT1_0 = "NO";
    defparam add_4635_18.INJECT1_1 = "NO";
    CCU2D add_167_3 (.A0(\debounce_counters[1] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8429), .COUT(n8430), .S0(n205), 
          .S1(n204));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_3.INIT0 = 16'h5aaa;
    defparam add_167_3.INIT1 = 16'h5aaa;
    defparam add_167_3.INJECT1_0 = "NO";
    defparam add_167_3.INJECT1_1 = "NO";
    LUT4 i3249_2_lut (.A(irq_en[3]), .B(temp1[0]), .Z(n4935)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(542[6] 548[15])
    defparam i3249_2_lut.init = 16'heeee;
    CCU2D add_167_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[1] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n8429), .S1(n206));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_1.INIT0 = 16'hF000;
    defparam add_167_1.INIT1 = 16'h5555;
    defparam add_167_1.INJECT1_0 = "NO";
    defparam add_167_1.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i17 (.D(n4542), .SP(clk_enable_205), .CD(n6174), 
            .CK(clk), .Q(counter[17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i17.GSR = "DISABLED";
    CCU2D add_4635_16 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8553), .COUT(n8554));
    defparam add_4635_16.INIT0 = 16'h5555;
    defparam add_4635_16.INIT1 = 16'h5555;
    defparam add_4635_16.INJECT1_0 = "NO";
    defparam add_4635_16.INJECT1_1 = "NO";
    LUT4 i2_3_lut_4_lut (.A(extern_connected), .B(signals_debounced_syn[2]), 
         .C(n9760), .D(next_state[0]), .Z(n8578)) /* synthesis lut_function=(!(A ((C+!(D))+!B)+!A (C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1359[10:51])
    defparam i2_3_lut_4_lut.init = 16'h0d00;
    LUT4 i1_2_lut_3_lut_4_lut_adj_98 (.A(next_state[2]), .B(next_state[3]), 
         .C(next_state[0]), .D(next_state[1]), .Z(clk_enable_23)) /* synthesis lut_function=(A+!(B (C+(D)))) */ ;
    defparam i1_2_lut_3_lut_4_lut_adj_98.init = 16'hbbbf;
    LUT4 i3229_3_lut (.A(n3146), .B(n4641), .C(n4637), .Z(n4544)) /* synthesis lut_function=(!(A (B (C))+!A (B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam i3229_3_lut.init = 16'h3b3b;
    FD1P3AX DIGS3C_Shared_ReqSafeState_745 (.D(DIGS3C_Shared_ReqSafeState_N_1318), 
            .SP(clk_enable_23), .CK(clk), .Q(DIGS3C_Shared_ReqSafeState_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam DIGS3C_Shared_ReqSafeState_745.GSR = "DISABLED";
    LUT4 i1979_2_lut_3_lut_4_lut (.A(n9769), .B(n_temp1_7__N_352), .C(clk_enable_184), 
         .D(n_temp1_7__N_365), .Z(n_wb_we_i)) /* synthesis lut_function=(!(A (C)+!A (B (C)+!B (C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1979_2_lut_3_lut_4_lut.init = 16'h0f0e;
    FD1P3AX FP_SysLEDb_748 (.D(FP_SysLEDb_N_1305), .SP(clk_enable_25), .CK(clk), 
            .Q(FP_SysLEDb_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam FP_SysLEDb_748.GSR = "DISABLED";
    FD1P3AX FP_SysLEDg_749 (.D(FP_SysLEDg_N_1303), .SP(clk_enable_25), .CK(clk), 
            .Q(FP_SysLEDg_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam FP_SysLEDg_749.GSR = "DISABLED";
    FD1P3AX Carrier_PwrOn_751 (.D(Carrier_PG_3V3_N_1312), .SP(clk_enable_27), 
            .CK(clk), .Q(Carrier_PwrOn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam Carrier_PwrOn_751.GSR = "DISABLED";
    FD1P3AX Carrier_PG_3V3_752 (.D(Carrier_PG_3V3_N_1312), .SP(clk_enable_27), 
            .CK(clk), .Q(Carrier_PG_3V3_c)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam Carrier_PG_3V3_752.GSR = "DISABLED";
    FD1P3IX debounce_counters_4___i3 (.D(n521), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i3.GSR = "DISABLED";
    FD1P3AX FP_SysLEDs_756 (.D(FP_SysLEDs_N_1317), .SP(clk_enable_29), .CK(clk), 
            .Q(FP_SysLEDs_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam FP_SysLEDs_756.GSR = "DISABLED";
    FD1P3IX debounce_counters_4___i2 (.D(n522), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i2.GSR = "DISABLED";
    CCU2D add_850_13 (.A0(counter[11]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[12]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8498), .COUT(n8499), .S0(n3150), .S1(n3149));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1465[17:24])
    defparam add_850_13.INIT0 = 16'h5555;
    defparam add_850_13.INIT1 = 16'h5555;
    defparam add_850_13.INJECT1_0 = "NO";
    defparam add_850_13.INJECT1_1 = "NO";
    LUT4 i5446_2_lut_2_lut_3_lut_4_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(next_state[1]), .D(next_state[0]), .Z(clk_enable_19)) /* synthesis lut_function=(A+((C (D)+!C !(D))+!B)) */ ;
    defparam i5446_2_lut_2_lut_3_lut_4_lut.init = 16'hfbbf;
    FD1S3AY debounce_inputs_asyn1_i1 (.D(SysSW_Pwr_NC_c), .CK(clk), .Q(debounce_inputs_asyn1[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_inputs_asyn1_i1.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i1 (.D(n5462), .CK(clk), .CD(n9776), .Q(n_temp1_7__N_369));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i1.GSR = "DISABLED";
    LUT4 mux_1373_i13_4_lut (.A(n3149), .B(n9786), .C(n4643), .D(n5428), 
         .Z(n4581)) /* synthesis lut_function=(!(A (B (C))+!A (B (C+!(D))+!B !(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam mux_1373_i13_4_lut.init = 16'h3f3a;
    CCU2D add_4635_14 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8552), .COUT(n8553));
    defparam add_4635_14.INIT0 = 16'h5555;
    defparam add_4635_14.INIT1 = 16'h5555;
    defparam add_4635_14.INJECT1_0 = "NO";
    defparam add_4635_14.INJECT1_1 = "NO";
    LUT4 i2_3_lut_3_lut (.A(temp1[2]), .B(n24), .C(temp1[1]), .Z(n8586)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;
    defparam i2_3_lut_3_lut.init = 16'h4040;
    CCU2D add_4635_12 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8551), .COUT(n8552));
    defparam add_4635_12.INIT0 = 16'h5555;
    defparam add_4635_12.INIT1 = 16'h5555;
    defparam add_4635_12.INJECT1_0 = "NO";
    defparam add_4635_12.INJECT1_1 = "NO";
    CCU2D add_4635_10 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8550), .COUT(n8551));
    defparam add_4635_10.INIT0 = 16'h5555;
    defparam add_4635_10.INIT1 = 16'h5555;
    defparam add_4635_10.INJECT1_0 = "NO";
    defparam add_4635_10.INJECT1_1 = "NO";
    BB BB1_scl (.I(i2c1_sclo), .T(i2c1_scloen), .B(S3CsI2C_SCL), .O(i2c1_scli)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=471, LSE_RLINE=471 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(154[14:16])
    LUT4 i3385_2_lut_3_lut (.A(temp1[5]), .B(temp1[1]), .C(GPI_DAT[6]), 
         .Z(n4691)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(542[6] 548[15])
    defparam i3385_2_lut_3_lut.init = 16'h1010;
    LUT4 i3384_2_lut_3_lut (.A(temp1[5]), .B(temp1[1]), .C(GPI_DAT[5]), 
         .Z(n4692)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(542[6] 548[15])
    defparam i3384_2_lut_3_lut.init = 16'h1010;
    LUT4 i3383_2_lut_3_lut (.A(temp1[5]), .B(temp1[1]), .C(GPI_DAT[4]), 
         .Z(n4693)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(542[6] 548[15])
    defparam i3383_2_lut_3_lut.init = 16'h1010;
    CCU2D add_4635_8 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8549), .COUT(n8550));
    defparam add_4635_8.INIT0 = 16'h5555;
    defparam add_4635_8.INIT1 = 16'h5aaa;
    defparam add_4635_8.INJECT1_0 = "NO";
    defparam add_4635_8.INJECT1_1 = "NO";
    CCU2D add_176_33 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8460), .S0(n281));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_33.INIT0 = 16'h5aaa;
    defparam add_176_33.INIT1 = 16'h0000;
    defparam add_176_33.INJECT1_0 = "NO";
    defparam add_176_33.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i21 (.D(n4472), .SP(clk_enable_205), .CD(n7033), 
            .CK(clk), .Q(counter[21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i21.GSR = "DISABLED";
    CCU2D add_850_11 (.A0(counter[9]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[10]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8497), .COUT(n8498), .S0(n3152), .S1(n3151));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1465[17:24])
    defparam add_850_11.INIT0 = 16'h5555;
    defparam add_850_11.INIT1 = 16'h5555;
    defparam add_850_11.INJECT1_0 = "NO";
    defparam add_850_11.INJECT1_1 = "NO";
    CCU2D add_4635_6 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8548), .COUT(n8549));
    defparam add_4635_6.INIT0 = 16'h5555;
    defparam add_4635_6.INIT1 = 16'h5aaa;
    defparam add_4635_6.INJECT1_0 = "NO";
    defparam add_4635_6.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i1 (.D(n523), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i1.GSR = "DISABLED";
    PFUMX i5458 (.BLUT(n9470), .ALUT(n9469), .C0(next_state[2]), .Z(n9471));
    CCU2D add_850_9 (.A0(counter[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[8]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8496), .COUT(n8497), .S0(n3154), .S1(n3153));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1465[17:24])
    defparam add_850_9.INIT0 = 16'h5555;
    defparam add_850_9.INIT1 = 16'h5555;
    defparam add_850_9.INJECT1_0 = "NO";
    defparam add_850_9.INJECT1_1 = "NO";
    CCU2D add_850_7 (.A0(counter[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8495), .COUT(n8496), .S0(n3156), .S1(n3155));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1465[17:24])
    defparam add_850_7.INIT0 = 16'h5555;
    defparam add_850_7.INIT1 = 16'h5555;
    defparam add_850_7.INJECT1_0 = "NO";
    defparam add_850_7.INJECT1_1 = "NO";
    PFUMX i5595 (.BLUT(n9713), .ALUT(n9712), .C0(temp1[1]), .Z(n9714));
    LUT4 i43_4_lut_3_lut (.A(temp1[0]), .B(temp1[6]), .C(temp1[5]), .Z(n24)) /* synthesis lut_function=(!(A (B+(C))+!A !(B (C)))) */ ;
    defparam i43_4_lut_3_lut.init = 16'h4242;
    FD1P3IX debounce_counters_3___i31 (.D(n387), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i31.GSR = "DISABLED";
    FD1S3IX dat_rdy_del_722 (.D(dat_rdy), .CK(clk), .CD(n9776), .Q(dat_rdy_del));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(515[7] 528[11])
    defparam dat_rdy_del_722.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i30 (.D(n388), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i30.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i29 (.D(n389), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i29.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i28 (.D(n390), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i28.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i27 (.D(n391), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i27.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i26 (.D(n392), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i26.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i25 (.D(n393), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i25.GSR = "DISABLED";
    PFUMX i5591 (.BLUT(n9709), .ALUT(n9708), .C0(next_state[2]), .Z(n9710));
    FD1S3IX reg_rdy_719 (.D(reg_rdy_N_1336), .CK(clk), .CD(n9776), .Q(reg_rdy));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(497[1] 510[9])
    defparam reg_rdy_719.GSR = "DISABLED";
    LUT4 mux_1364_i10_4_lut (.A(next_state[1]), .B(n3152), .C(n4641), 
         .D(n4637), .Z(n4550)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam mux_1364_i10_4_lut.init = 16'hfaca;
    LUT4 pushed_4__I_0_1_lut (.A(pushed[4]), .Z(pushed_4__N_296)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(422[17] 426[24])
    defparam pushed_4__I_0_1_lut.init = 16'h5555;
    LUT4 i3247_4_lut (.A(n10_adj_1443), .B(n5916), .C(n9790), .D(n9766), 
         .Z(n6957)) /* synthesis lut_function=(A (B)+!A (B (C+(D)))) */ ;
    defparam i3247_4_lut.init = 16'hccc8;
    LUT4 n5895_bdd_4_lut (.A(n9768), .B(next_state[1]), .C(next_state[2]), 
         .D(next_state[0]), .Z(n9491)) /* synthesis lut_function=(!((B ((D)+!C)+!B !(C (D)))+!A)) */ ;
    defparam n5895_bdd_4_lut.init = 16'h2080;
    LUT4 i1_2_lut_rep_119 (.A(n_temp1_7__N_353), .B(n_temp1_7__N_359), .Z(n9784)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_2_lut_rep_119.init = 16'heeee;
    VLO i1 (.Z(GND_net));
    LUT4 i2_2_lut_rep_104_3_lut (.A(n_temp1_7__N_353), .B(n_temp1_7__N_359), 
         .C(n_temp1_7__N_366), .Z(n9769)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i2_2_lut_rep_104_3_lut.init = 16'hfefe;
    PFUMX i5586 (.BLUT(n9699), .ALUT(n9698), .C0(temp1[1]), .Z(n9700));
    CCU2D add_4635_4 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8547), .COUT(n8548));
    defparam add_4635_4.INIT0 = 16'h5555;
    defparam add_4635_4.INIT1 = 16'h5555;
    defparam add_4635_4.INJECT1_0 = "NO";
    defparam add_4635_4.INJECT1_1 = "NO";
    LUT4 pushed_3__I_0_1_lut (.A(pushed[3]), .Z(pushed_3__N_298)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(422[17] 426[24])
    defparam pushed_3__I_0_1_lut.init = 16'h5555;
    LUT4 pushed_2__I_0_1_lut (.A(pushed[2]), .Z(pushed_2__N_300)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(422[17] 426[24])
    defparam pushed_2__I_0_1_lut.init = 16'h5555;
    LUT4 i4_4_lut (.A(n9766), .B(temp1[3]), .C(temp1[2]), .D(n9245), 
         .Z(n5916)) /* synthesis lut_function=(A+((C+!(D))+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(546[13:23])
    defparam i4_4_lut.init = 16'hfbff;
    FD1P3IX debounce_counters_1___i31 (.D(n175), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i31.GSR = "DISABLED";
    CCU2D add_4635_2 (.A0(\debounce_counters[1] [7]), .B0(\debounce_counters[1] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[1] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n8547));
    defparam add_4635_2.INIT0 = 16'h1000;
    defparam add_4635_2.INIT1 = 16'h5aaa;
    defparam add_4635_2.INJECT1_0 = "NO";
    defparam add_4635_2.INJECT1_1 = "NO";
    LUT4 i5311_2_lut (.A(temp1[0]), .B(temp1[1]), .Z(n9245)) /* synthesis lut_function=(A (B)) */ ;
    defparam i5311_2_lut.init = 16'h8888;
    CCU2D add_167_25 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8440), .COUT(n8441), .S0(n183), 
          .S1(n182));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_25.INIT0 = 16'h5aaa;
    defparam add_167_25.INIT1 = 16'h5aaa;
    defparam add_167_25.INJECT1_0 = "NO";
    defparam add_167_25.INJECT1_1 = "NO";
    CCU2D add_4632_26 (.A0(\debounce_counters[4] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8546), .S1(clk_enable_153));
    defparam add_4632_26.INIT0 = 16'hf555;
    defparam add_4632_26.INIT1 = 16'h0000;
    defparam add_4632_26.INJECT1_0 = "NO";
    defparam add_4632_26.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_99_3_lut_4_lut (.A(n_temp1_7__N_353), .B(n_temp1_7__N_359), 
         .C(n_temp1_7__N_352), .D(n_temp1_7__N_366), .Z(n9764)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_2_lut_rep_99_3_lut_4_lut.init = 16'hfffe;
    CCU2D add_4632_24 (.A0(\debounce_counters[4] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8545), .COUT(n8546));
    defparam add_4632_24.INIT0 = 16'h5555;
    defparam add_4632_24.INIT1 = 16'h5555;
    defparam add_4632_24.INJECT1_0 = "NO";
    defparam add_4632_24.INJECT1_1 = "NO";
    CCU2D add_850_5 (.A0(counter[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8494), .COUT(n8495), .S0(n3158), .S1(n3157));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1465[17:24])
    defparam add_850_5.INIT0 = 16'h5555;
    defparam add_850_5.INIT1 = 16'h5555;
    defparam add_850_5.INJECT1_0 = "NO";
    defparam add_850_5.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_120 (.A(dat_rdy_N_1342), .B(reg_rdy_N_1338), .Z(n9785)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_rep_120.init = 16'heeee;
    CCU2D add_850_3 (.A0(counter[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8493), .COUT(n8494), .S0(n3160), .S1(n3159));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1465[17:24])
    defparam add_850_3.INIT0 = 16'h5555;
    defparam add_850_3.INIT1 = 16'h5555;
    defparam add_850_3.INJECT1_0 = "NO";
    defparam add_850_3.INJECT1_1 = "NO";
    PFUMX i5582 (.BLUT(n9696), .ALUT(n9695), .C0(next_state[3]), .Z(FP_SysLEDr_N_1304));
    LUT4 i1_2_lut_3_lut (.A(dat_rdy_N_1342), .B(reg_rdy_N_1338), .C(n_temp1_7__N_365), 
         .Z(n9223)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i1_2_lut_3_lut.init = 16'hfefe;
    FD1P3IX debounce_counters_1___i30 (.D(n176), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i30.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i29 (.D(n177), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i29.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i28 (.D(n178), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i28.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i24 (.D(n394), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i24.GSR = "DISABLED";
    LUT4 i1_4_lut (.A(wb_dat_o[7]), .B(temp1[7]), .C(n9767), .D(n9269), 
         .Z(n_temp1[7])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut.init = 16'ha0ec;
    CCU2D add_850_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n8493), .S1(n3161));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1465[17:24])
    defparam add_850_1.INIT0 = 16'hF000;
    defparam add_850_1.INIT1 = 16'h5555;
    defparam add_850_1.INJECT1_0 = "NO";
    defparam add_850_1.INJECT1_1 = "NO";
    CCU2D add_4632_22 (.A0(\debounce_counters[4] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8544), .COUT(n8545));
    defparam add_4632_22.INIT0 = 16'h5555;
    defparam add_4632_22.INIT1 = 16'h5555;
    defparam add_4632_22.INJECT1_0 = "NO";
    defparam add_4632_22.INJECT1_1 = "NO";
    LUT4 next_state_1__bdd_4_lut_5568 (.A(next_state[1]), .B(next_state[2]), 
         .C(next_state[0]), .D(next_state[3]), .Z(clk_enable_203)) /* synthesis lut_function=(A (B (C+(D)))+!A (B ((D)+!C)+!B !(C+(D)))) */ ;
    defparam next_state_1__bdd_4_lut_5568.init = 16'hcc85;
    LUT4 i1_4_lut_adj_99 (.A(n_state_7__N_1056[4]), .B(temp1[6]), .C(n9767), 
         .D(n9269), .Z(n_temp1[6])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_99.init = 16'ha0ec;
    CCU2D add_194_33 (.A0(\debounce_counters[4] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8492), .S0(n493));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_33.INIT0 = 16'h5aaa;
    defparam add_194_33.INIT1 = 16'h0000;
    defparam add_194_33.INJECT1_0 = "NO";
    defparam add_194_33.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i23 (.D(n395), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i23.GSR = "DISABLED";
    LUT4 i1575_2_lut (.A(clk_enable_13), .B(debounce_inputs_asyn2[1]), .Z(clk_enable_89)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i1575_2_lut.init = 16'hdddd;
    FD1P3IX debounce_counters_3___i22 (.D(n396), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i22.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i21 (.D(n397), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i21.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i20 (.D(n398), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i20.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i19 (.D(n399), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i19.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i18 (.D(n400), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i18.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i17 (.D(n401), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i17.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i16 (.D(n402), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i16.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i15 (.D(n403), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i15.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i14 (.D(n404), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i14.GSR = "DISABLED";
    LUT4 i1_4_lut_adj_100 (.A(wb_dat_o[5]), .B(temp1[5]), .C(n9767), .D(n9269), 
         .Z(n_temp1[5])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_100.init = 16'ha0ec;
    LUT4 i3241_2_lut_rep_97_4_lut (.A(n9773), .B(n10_adj_1443), .C(n14_adj_1470), 
         .D(n5927), .Z(n9762)) /* synthesis lut_function=(A (D)+!A (B (D)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(543[13:23])
    defparam i3241_2_lut_rep_97_4_lut.init = 16'hfe00;
    FD1P3IX debounce_counters_3___i13 (.D(n405), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i13.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i12 (.D(n406), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i12.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i11 (.D(n407), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i11.GSR = "DISABLED";
    FD1P3AX i702_758 (.D(Carrier_PG_1V8_N_1428), .SP(Carrier_PG_1V8_N_1421), 
            .CK(clk), .Q(Carrier_PG_1V8_N_1316));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam i702_758.GSR = "DISABLED";
    FD1P3DX irq_status_2__732 (.D(n10114), .SP(irq_en[2]), .CK(IRQ_c_2), 
            .CD(irq_status_clr[2]), .Q(irq_status[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(668[7] 674[23])
    defparam irq_status_2__732.GSR = "DISABLED";
    FD1P3IX irq_en__i0 (.D(temp2[0]), .SP(clk_enable_193), .CD(n9776), 
            .CK(clk), .Q(irq_en[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(686[1] 697[10])
    defparam irq_en__i0.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i27 (.D(n179), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i27.GSR = "DISABLED";
    FD1P3AX irq_status_3__733 (.D(n10114), .SP(irq_en[3]), .CK(IRQ_c_3), 
            .Q(irq_status[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(668[7] 674[23])
    defparam irq_status_3__733.GSR = "ENABLED";
    FD1P3DX irq_status_1__731 (.D(n10114), .SP(irq_en[1]), .CK(IRQ_c_1), 
            .CD(irq_status_clr[1]), .Q(irq_status[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(668[7] 674[23])
    defparam irq_status_1__731.GSR = "DISABLED";
    LUT4 i1_4_lut_adj_101 (.A(wb_dat_o[4]), .B(temp1[4]), .C(n9767), .D(n9269), 
         .Z(n_temp1[4])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_101.init = 16'ha0ec;
    FD1P3DX irq_status_0__730 (.D(n10114), .SP(irq_en[0]), .CK(IRQ_c_0), 
            .CD(irq_status_clr[0]), .Q(irq_status[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(668[7] 674[23])
    defparam irq_status_0__730.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i26 (.D(n180), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i26.GSR = "DISABLED";
    LUT4 i1_2_lut_rep_121 (.A(next_state[3]), .B(next_state[2]), .Z(n9786)) /* synthesis lut_function=(A (B)) */ ;
    defparam i1_2_lut_rep_121.init = 16'h8888;
    FD1P3IX debounce_counters_1___i25 (.D(n181), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i25.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i24 (.D(n182), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i24.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i23 (.D(n183), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i23.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i22 (.D(n184), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i22.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i21 (.D(n185), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i21.GSR = "DISABLED";
    LUT4 mux_1373_i21_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n4643), .D(n4539), .Z(n4573)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_1373_i21_3_lut_4_lut.init = 16'h7f70;
    PFUMX i5577 (.BLUT(n9688), .ALUT(n9687), .C0(temp1[1]), .Z(n9689));
    FD1P3IX debounce_counters_1___i20 (.D(n186), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i20.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i19 (.D(n187), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i19.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i18 (.D(n188), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i18.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i17 (.D(n189), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i17.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i16 (.D(n190), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i16.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i15 (.D(n191), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i15.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i14 (.D(n192), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i14.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i13 (.D(n193), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i13.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i12 (.D(n194), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i12.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i11 (.D(n195), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i11.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i10 (.D(n196), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i10.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i9 (.D(n197), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i9.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i8 (.D(n198), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i8.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i7 (.D(n199), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i7.GSR = "DISABLED";
    LUT4 mux_1373_i9_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n4643), .D(n4551), .Z(n4585)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_1373_i9_3_lut_4_lut.init = 16'h7f70;
    LUT4 mux_1373_i10_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n4643), .D(n4550), .Z(n4584)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_1373_i10_3_lut_4_lut.init = 16'h7f70;
    LUT4 i24_4_lut_rep_95 (.A(n43), .B(n48), .C(n37), .D(n38), .Z(n9760)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i24_4_lut_rep_95.init = 16'hfffe;
    CCU2D add_194_31 (.A0(\debounce_counters[4] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8491), .COUT(n8492), .S0(n495), 
          .S1(n494));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_31.INIT0 = 16'h5aaa;
    defparam add_194_31.INIT1 = 16'h5aaa;
    defparam add_194_31.INJECT1_0 = "NO";
    defparam add_194_31.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_102 (.A(wb_dat_o[3]), .B(temp1[3]), .C(n9767), .D(n9269), 
         .Z(n_temp1[3])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_102.init = 16'ha0ec;
    CCU2D add_194_29 (.A0(\debounce_counters[4] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8490), .COUT(n8491), .S0(n497), 
          .S1(n496));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_29.INIT0 = 16'h5aaa;
    defparam add_194_29.INIT1 = 16'h5aaa;
    defparam add_194_29.INJECT1_0 = "NO";
    defparam add_194_29.INJECT1_1 = "NO";
    LUT4 mux_1373_i19_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n4643), .D(n4541), .Z(n4575)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_1373_i19_3_lut_4_lut.init = 16'h7f70;
    FD1P3IX debounce_counters_1___i6 (.D(n200), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i6.GSR = "DISABLED";
    LUT4 mux_1373_i20_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n4643), .D(n4540), .Z(n4574)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_1373_i20_3_lut_4_lut.init = 16'h7f70;
    LUT4 i1_4_lut_adj_103 (.A(wb_dat_o[2]), .B(temp1[2]), .C(n9767), .D(n9269), 
         .Z(n_temp1[2])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_103.init = 16'ha0ec;
    FD1P3IX debounce_counters_3___i10 (.D(n408), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i10.GSR = "DISABLED";
    LUT4 i1_4_lut_adj_104 (.A(wb_dat_o[1]), .B(temp1[1]), .C(n9767), .D(n9269), 
         .Z(n_temp1[1])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_104.init = 16'ha0ec;
    FD1P3IX debounce_counters_3___i9 (.D(n409), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i9.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i8 (.D(n410), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i8.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i7 (.D(n411), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i7.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i5 (.D(n201), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i5.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i4 (.D(n202), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i4.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i3 (.D(n203), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i3.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i2 (.D(n204), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i2.GSR = "DISABLED";
    FD1P3IX debounce_counters_1___i1 (.D(n205), .SP(clk_enable_89), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_1___i1.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i0 (.D(n130), .CK(clk), .Q(resetcounter[0])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i0.GSR = "DISABLED";
    LUT4 mux_1445_i8_4_lut (.A(GPI_DAT[7]), .B(temp1[0]), .C(temp1[1]), 
         .D(temp1[5]), .Z(n4690)) /* synthesis lut_function=(A (B (C+!(D))+!B !(C+(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(542[6] 548[15])
    defparam mux_1445_i8_4_lut.init = 16'hc0ca;
    LUT4 i5410_4_lut_then_3_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[0]), 
         .Z(n9797)) /* synthesis lut_function=(A (B+(C))+!A (B (C))) */ ;
    defparam i5410_4_lut_then_3_lut.init = 16'he8e8;
    LUT4 i5410_4_lut_else_3_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state_3__N_1108[2]), 
         .D(next_state[0]), .Z(n9796)) /* synthesis lut_function=(A (B)+!A !(B+(C (D)+!C !(D)))) */ ;
    defparam i5410_4_lut_else_3_lut.init = 16'h8998;
    CCU2D add_4632_20 (.A0(\debounce_counters[4] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8543), .COUT(n8544));
    defparam add_4632_20.INIT0 = 16'h5555;
    defparam add_4632_20.INIT1 = 16'h5555;
    defparam add_4632_20.INJECT1_0 = "NO";
    defparam add_4632_20.INJECT1_1 = "NO";
    CCU2D add_4632_18 (.A0(\debounce_counters[4] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8542), .COUT(n8543));
    defparam add_4632_18.INIT0 = 16'h5555;
    defparam add_4632_18.INIT1 = 16'h5555;
    defparam add_4632_18.INJECT1_0 = "NO";
    defparam add_4632_18.INJECT1_1 = "NO";
    FD1S3IX dat_count__i7 (.D(n_dat_count[7]), .CK(clk), .CD(n9776), .Q(dat_count[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(767[1] 781[10])
    defparam dat_count__i7.GSR = "DISABLED";
    LUT4 i1703_2_lut (.A(temp1[5]), .B(temp1[6]), .Z(n5385)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;
    defparam i1703_2_lut.init = 16'h6666;
    LUT4 i1700_1_lut (.A(Carrier_PG_1V8_N_1316), .Z(n5382)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1304[1] 1485[13])
    defparam i1700_1_lut.init = 16'h5555;
    FD1S3IX dat_count__i6 (.D(n_dat_count[6]), .CK(clk), .CD(n9776), .Q(dat_count[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(767[1] 781[10])
    defparam dat_count__i6.GSR = "DISABLED";
    FD1S3IX dat_count__i5 (.D(n_dat_count[5]), .CK(clk), .CD(n9776), .Q(dat_count[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(767[1] 781[10])
    defparam dat_count__i5.GSR = "DISABLED";
    FD1S3IX dat_count__i4 (.D(n_dat_count[4]), .CK(clk), .CD(n9776), .Q(dat_count[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(767[1] 781[10])
    defparam dat_count__i4.GSR = "DISABLED";
    FD1S3IX dat_count__i3 (.D(n_dat_count[3]), .CK(clk), .CD(n9776), .Q(dat_count[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(767[1] 781[10])
    defparam dat_count__i3.GSR = "DISABLED";
    FD1S3IX dat_count__i2 (.D(n_dat_count[2]), .CK(clk), .CD(n9776), .Q(dat_count[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(767[1] 781[10])
    defparam dat_count__i2.GSR = "DISABLED";
    FD1S3IX dat_count__i1 (.D(n_dat_count[1]), .CK(clk), .CD(n9776), .Q(dat_count[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(767[1] 781[10])
    defparam dat_count__i1.GSR = "DISABLED";
    FD1S3IX wb_adr_i__i4 (.D(n_wb_adr_i[6]), .CK(clk), .CD(n9776), .Q(wb_adr_i[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(746[1] 762[10])
    defparam wb_adr_i__i4.GSR = "DISABLED";
    FD1S3IX wb_adr_i__i3 (.D(n_wb_adr_i[2]), .CK(clk), .CD(n9776), .Q(wb_adr_i[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(746[1] 762[10])
    defparam wb_adr_i__i3.GSR = "DISABLED";
    FD1S3IX wb_adr_i__i2 (.D(n_wb_adr_i[1]), .CK(clk), .CD(n9776), .Q(wb_adr_i[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(746[1] 762[10])
    defparam wb_adr_i__i2.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i7 (.D(n_wb_dat_i[7]), .CK(clk), .CD(n9776), .Q(wb_dat_i[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(746[1] 762[10])
    defparam wb_dat_i__i7.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i6 (.D(n_wb_dat_i[6]), .CK(clk), .CD(n9776), .Q(wb_dat_i[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(746[1] 762[10])
    defparam wb_dat_i__i6.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i5 (.D(n_wb_dat_i[5]), .CK(clk), .CD(n9776), .Q(wb_dat_i[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(746[1] 762[10])
    defparam wb_dat_i__i5.GSR = "DISABLED";
    LUT4 i1_4_lut_adj_105 (.A(n12_adj_1445), .B(next_state[2]), .C(externstop_falling), 
         .D(n9777), .Z(n4643)) /* synthesis lut_function=(A+(B (C (D)))) */ ;
    defparam i1_4_lut_adj_105.init = 16'heaaa;
    LUT4 i1_2_lut_rep_98_4_lut (.A(n9772), .B(temp1[6]), .C(temp1[5]), 
         .D(n9773), .Z(n9763)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(546[13:23])
    defparam i1_2_lut_rep_98_4_lut.init = 16'hfffe;
    FD1S3IX wb_dat_i__i4 (.D(n_wb_dat_i[4]), .CK(clk), .CD(n9776), .Q(wb_dat_i[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(746[1] 762[10])
    defparam wb_dat_i__i4.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i3 (.D(n_wb_dat_i[3]), .CK(clk), .CD(n9776), .Q(wb_dat_i[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(746[1] 762[10])
    defparam wb_dat_i__i3.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i2 (.D(n_wb_dat_i[2]), .CK(clk), .CD(n9776), .Q(wb_dat_i[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(746[1] 762[10])
    defparam wb_dat_i__i2.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i1 (.D(n_wb_dat_i[1]), .CK(clk), .CD(n9776), .Q(wb_dat_i[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(746[1] 762[10])
    defparam wb_dat_i__i1.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i31 (.D(n281), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i31.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i30 (.D(n282), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i30.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i29 (.D(n283), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i29.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i28 (.D(n284), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i28.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i27 (.D(n285), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i27.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i26 (.D(n286), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i26.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i25 (.D(n287), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i25.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i24 (.D(n288), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i24.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i23 (.D(n289), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i23.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i22 (.D(n290), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i22.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i21 (.D(n291), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i21.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i20 (.D(n292), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i20.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i19 (.D(n293), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i19.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i18 (.D(n294), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i18.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i17 (.D(n295), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i17.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i16 (.D(n296), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i16.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i15 (.D(n297), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i15.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i14 (.D(n298), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i14.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i13 (.D(n299), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i13.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i6 (.D(n412), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i6.GSR = "DISABLED";
    LUT4 n9132_bdd_3_lut_2_lut (.A(next_state[0]), .B(next_state_3__N_1108[2]), 
         .Z(n9592)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;
    defparam n9132_bdd_3_lut_2_lut.init = 16'h6666;
    PFUMX i35 (.BLUT(n23), .ALUT(n19), .C0(next_state[1]), .Z(n17_adj_1437));
    LUT4 i8_4_lut (.A(n15), .B(resetcounter[9]), .C(n14), .D(resetcounter[18]), 
         .Z(n8732)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(444[12:28])
    defparam i8_4_lut.init = 16'hfffe;
    LUT4 i5377_4_lut_4_lut (.A(next_state[0]), .B(n9170), .C(next_state[1]), 
         .D(externstop_falling), .Z(n9312)) /* synthesis lut_function=(!(A (B (C)+!B (C+!(D)))+!A !((D)+!C))) */ ;
    defparam i5377_4_lut_4_lut.init = 16'h5f0d;
    FD1P3IX debounce_counters_3___i5 (.D(n413), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i5.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i4 (.D(n414), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i4.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i3 (.D(n415), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i3.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i2 (.D(n416), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i2.GSR = "DISABLED";
    FD1P3IX debounce_counters_3___i1 (.D(n417), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i1.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i12 (.D(n300), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i12.GSR = "DISABLED";
    LUT4 i6_4_lut (.A(resetcounter[23]), .B(resetcounter[24]), .C(resetcounter[12]), 
         .D(resetcounter[20]), .Z(n15)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(444[12:28])
    defparam i6_4_lut.init = 16'hfffe;
    CCU2D add_176_31 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8459), .COUT(n8460), .S0(n283), 
          .S1(n282));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_31.INIT0 = 16'h5aaa;
    defparam add_176_31.INIT1 = 16'h5aaa;
    defparam add_176_31.INJECT1_0 = "NO";
    defparam add_176_31.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_2___i11 (.D(n301), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i11.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i10 (.D(n302), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i10.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i9 (.D(n303), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i9.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i8 (.D(n304), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i8.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i7 (.D(n305), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i7.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i6 (.D(n306), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i6.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i5 (.D(n307), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i5.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i4 (.D(n308), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i4.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i3 (.D(n309), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i3.GSR = "DISABLED";
    CCU2D add_176_29 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8458), .COUT(n8459), .S0(n285), 
          .S1(n284));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_29.INIT0 = 16'h5aaa;
    defparam add_176_29.INIT1 = 16'h5aaa;
    defparam add_176_29.INJECT1_0 = "NO";
    defparam add_176_29.INJECT1_1 = "NO";
    CCU2D add_167_23 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8439), .COUT(n8440), .S0(n185), 
          .S1(n184));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_23.INIT0 = 16'h5aaa;
    defparam add_167_23.INIT1 = 16'h5aaa;
    defparam add_167_23.INJECT1_0 = "NO";
    defparam add_167_23.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_2___i2 (.D(n310), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i2.GSR = "DISABLED";
    FD1P3IX debounce_counters_2___i1 (.D(n311), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_2___i1.GSR = "DISABLED";
    FD1P3AX counter_i0_i24 (.D(n4569), .SP(clk_enable_205), .CK(clk), 
            .Q(counter[24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i24.GSR = "DISABLED";
    FD1P3AX counter_i0_i23 (.D(n4570), .SP(clk_enable_205), .CK(clk), 
            .Q(counter[23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i23.GSR = "DISABLED";
    FD1P3AX counter_i0_i22 (.D(n4571), .SP(clk_enable_205), .CK(clk), 
            .Q(counter[22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i22.GSR = "DISABLED";
    FD1P3AX counter_i0_i20 (.D(n4573), .SP(clk_enable_205), .CK(clk), 
            .Q(counter[20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i20.GSR = "DISABLED";
    FD1P3AX counter_i0_i19 (.D(n4574), .SP(clk_enable_205), .CK(clk), 
            .Q(counter[19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i19.GSR = "DISABLED";
    FD1P3AX counter_i0_i18 (.D(n4575), .SP(clk_enable_205), .CK(clk), 
            .Q(counter[18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i18.GSR = "DISABLED";
    FD1P3AX counter_i0_i12 (.D(n4581), .SP(clk_enable_205), .CK(clk), 
            .Q(counter[12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i12.GSR = "DISABLED";
    FD1P3AX counter_i0_i9 (.D(n4584), .SP(clk_enable_205), .CK(clk), .Q(counter[9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i9.GSR = "DISABLED";
    FD1P3AX counter_i0_i8 (.D(n4585), .SP(clk_enable_205), .CK(clk), .Q(counter[8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i8.GSR = "DISABLED";
    LUT4 i3402_3_lut_3_lut_3_lut (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[2]), .Z(n7)) /* synthesis lut_function=(!(A (C)+!A !(B+!(C)))) */ ;
    defparam i3402_3_lut_3_lut_3_lut.init = 16'h4f4f;
    FD1P3IX GPO_DATA_0___i8 (.D(temp3[7]), .SP(clk_enable_142), .CD(n9776), 
            .CK(clk), .Q(GPO_c_7));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(603[8] 611[15])
    defparam GPO_DATA_0___i8.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i7 (.D(temp3[6]), .SP(clk_enable_142), .CD(n9776), 
            .CK(clk), .Q(GPO_c_6));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(603[8] 611[15])
    defparam GPO_DATA_0___i7.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i6 (.D(temp3[5]), .SP(clk_enable_142), .CD(n9776), 
            .CK(clk), .Q(GPO_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(603[8] 611[15])
    defparam GPO_DATA_0___i6.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i5 (.D(temp3[4]), .SP(clk_enable_142), .CD(n9776), 
            .CK(clk), .Q(GPO_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(603[8] 611[15])
    defparam GPO_DATA_0___i5.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i4 (.D(temp3[3]), .SP(clk_enable_142), .CD(n9776), 
            .CK(clk), .Q(GPO_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(603[8] 611[15])
    defparam GPO_DATA_0___i4.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i3 (.D(temp3[2]), .SP(clk_enable_142), .CD(n9776), 
            .CK(clk), .Q(GPO_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(603[8] 611[15])
    defparam GPO_DATA_0___i3.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i2 (.D(temp3[1]), .SP(clk_enable_142), .CD(n9776), 
            .CK(clk), .Q(GPO_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(603[8] 611[15])
    defparam GPO_DATA_0___i2.GSR = "DISABLED";
    FD1P3IX irq_clr__i3 (.D(temp2[3]), .SP(clk_enable_145), .CD(n9776), 
            .CK(clk), .Q(irq_clr[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(686[1] 697[10])
    defparam irq_clr__i3.GSR = "DISABLED";
    FD1P3IX irq_clr__i2 (.D(temp2[2]), .SP(clk_enable_145), .CD(n9776), 
            .CK(clk), .Q(irq_clr[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(686[1] 697[10])
    defparam irq_clr__i2.GSR = "DISABLED";
    FD1P3IX irq_clr__i1 (.D(temp2[1]), .SP(clk_enable_145), .CD(n9776), 
            .CK(clk), .Q(irq_clr[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(686[1] 697[10])
    defparam irq_clr__i1.GSR = "DISABLED";
    FD1P3IX temp3__i7 (.D(wb_dat_o[7]), .SP(dat_rdy_N_1340), .CD(n9776), 
            .CK(clk), .Q(temp3[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp3__i7.GSR = "DISABLED";
    FD1P3IX temp3__i6 (.D(n_state_7__N_1056[4]), .SP(dat_rdy_N_1340), .CD(n9776), 
            .CK(clk), .Q(temp3[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp3__i6.GSR = "DISABLED";
    FD1P3IX temp3__i5 (.D(wb_dat_o[5]), .SP(dat_rdy_N_1340), .CD(n9776), 
            .CK(clk), .Q(temp3[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp3__i5.GSR = "DISABLED";
    FD1P3IX temp3__i4 (.D(wb_dat_o[4]), .SP(dat_rdy_N_1340), .CD(n9776), 
            .CK(clk), .Q(temp3[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp3__i4.GSR = "DISABLED";
    LUT4 FPIO_isoCtrlRSTn_N_1310_bdd_4_lut_5599_4_lut (.A(next_state[0]), 
         .B(next_state_3__N_1108[2]), .C(next_state[1]), .D(n9760), .Z(n9709)) /* synthesis lut_function=(A (B (C (D))+!B ((D)+!C))+!A (C)) */ ;
    defparam FPIO_isoCtrlRSTn_N_1310_bdd_4_lut_5599_4_lut.init = 16'hf252;
    FD1P3IX temp3__i3 (.D(wb_dat_o[3]), .SP(dat_rdy_N_1340), .CD(n9776), 
            .CK(clk), .Q(temp3[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp3__i3.GSR = "DISABLED";
    FD1P3IX temp3__i2 (.D(wb_dat_o[2]), .SP(dat_rdy_N_1340), .CD(n9776), 
            .CK(clk), .Q(temp3[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp3__i2.GSR = "DISABLED";
    FD1P3IX temp3__i1 (.D(wb_dat_o[1]), .SP(dat_rdy_N_1340), .CD(n9776), 
            .CK(clk), .Q(temp3[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp3__i1.GSR = "DISABLED";
    FD1P3IX temp2__i3 (.D(wb_dat_o[3]), .SP(reg_rdy_N_1336), .CD(n9776), 
            .CK(clk), .Q(temp2[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp2__i3.GSR = "DISABLED";
    LUT4 i1_4_lut_adj_106 (.A(next_state[3]), .B(externstop_falling), .C(next_state[2]), 
         .D(n9770), .Z(n12_adj_1445)) /* synthesis lut_function=(A (B (C+(D))+!B (C))) */ ;
    defparam i1_4_lut_adj_106.init = 16'ha8a0;
    FD1P3IX temp2__i2 (.D(wb_dat_o[2]), .SP(reg_rdy_N_1336), .CD(n9776), 
            .CK(clk), .Q(temp2[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp2__i2.GSR = "DISABLED";
    FD1P3IX temp2__i1 (.D(wb_dat_o[1]), .SP(reg_rdy_N_1336), .CD(n9776), 
            .CK(clk), .Q(temp2[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp2__i1.GSR = "DISABLED";
    FD1P3IX GPI_DAT__i7 (.D(GPI_c_7), .SP(clk_enable_152), .CD(n9776), 
            .CK(clk), .Q(GPI_DAT[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(622[8] 628[15])
    defparam GPI_DAT__i7.GSR = "DISABLED";
    FD1P3IX GPI_DAT__i6 (.D(GPI_c_6), .SP(clk_enable_152), .CD(n9776), 
            .CK(clk), .Q(GPI_DAT[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(622[8] 628[15])
    defparam GPI_DAT__i6.GSR = "DISABLED";
    FD1P3IX GPI_DAT__i5 (.D(GPI_c_5), .SP(clk_enable_152), .CD(n9776), 
            .CK(clk), .Q(GPI_DAT[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(622[8] 628[15])
    defparam GPI_DAT__i5.GSR = "DISABLED";
    LUT4 i12_2_lut (.A(DIG5S3C03_out), .B(DIG5S3C04_out), .Z(n74)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i12_2_lut.init = 16'h8888;
    FD1P3IX GPI_DAT__i4 (.D(GPI_c_4), .SP(clk_enable_152), .CD(n9776), 
            .CK(clk), .Q(GPI_DAT[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(622[8] 628[15])
    defparam GPI_DAT__i4.GSR = "DISABLED";
    FD1P3IX GPI_DAT__i3 (.D(GPI_c_3), .SP(clk_enable_152), .CD(n9776), 
            .CK(clk), .Q(GPI_DAT[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(622[8] 628[15])
    defparam GPI_DAT__i3.GSR = "DISABLED";
    FD1P3IX GPI_DAT__i2 (.D(GPI_c_2), .SP(clk_enable_152), .CD(n9776), 
            .CK(clk), .Q(GPI_DAT[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(622[8] 628[15])
    defparam GPI_DAT__i2.GSR = "DISABLED";
    FD1P3IX GPI_DAT__i1 (.D(GPI_c_1), .SP(clk_enable_152), .CD(n9776), 
            .CK(clk), .Q(GPI_DAT[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(622[8] 628[15])
    defparam GPI_DAT__i1.GSR = "DISABLED";
    FD1S3AY signals_debounced_syn_i4 (.D(pushed_4__N_296), .CK(clk), .Q(signals_debounced_syn[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam signals_debounced_syn_i4.GSR = "DISABLED";
    LUT4 i5_3_lut (.A(resetcounter[19]), .B(resetcounter[8]), .C(resetcounter[22]), 
         .Z(n14)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(444[12:28])
    defparam i5_3_lut.init = 16'hfefe;
    CCU2D add_194_27 (.A0(\debounce_counters[4] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8489), .COUT(n8490), .S0(n499), 
          .S1(n498));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_27.INIT0 = 16'h5aaa;
    defparam add_194_27.INIT1 = 16'h5aaa;
    defparam add_194_27.INJECT1_0 = "NO";
    defparam add_194_27.INJECT1_1 = "NO";
    LUT4 i3280_2_lut_2_lut (.A(next_state_3__N_1108[2]), .B(n9760), .Z(FlexMIOs53_GPIO_PowerDown_N_1321)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i3280_2_lut_2_lut.init = 16'h4444;
    LUT4 i54_3_lut_4_lut_4_lut (.A(next_state_3__N_1108[2]), .B(n9791), 
         .C(next_state[2]), .D(n9754), .Z(n25_adj_1430)) /* synthesis lut_function=(!(A ((C)+!B)+!A !(B ((D)+!C)+!B (C (D))))) */ ;
    defparam i54_3_lut_4_lut_4_lut.init = 16'h5c0c;
    CCU2D add_4632_16 (.A0(\debounce_counters[4] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8541), .COUT(n8542));
    defparam add_4632_16.INIT0 = 16'h5555;
    defparam add_4632_16.INIT1 = 16'h5555;
    defparam add_4632_16.INJECT1_0 = "NO";
    defparam add_4632_16.INJECT1_1 = "NO";
    CCU2D add_194_25 (.A0(\debounce_counters[4] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8488), .COUT(n8489), .S0(n501), 
          .S1(n500));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_25.INIT0 = 16'h5aaa;
    defparam add_194_25.INIT1 = 16'h5aaa;
    defparam add_194_25.INJECT1_0 = "NO";
    defparam add_194_25.INJECT1_1 = "NO";
    CCU2D add_4632_14 (.A0(\debounce_counters[4] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8540), .COUT(n8541));
    defparam add_4632_14.INIT0 = 16'h5555;
    defparam add_4632_14.INIT1 = 16'h5555;
    defparam add_4632_14.INJECT1_0 = "NO";
    defparam add_4632_14.INJECT1_1 = "NO";
    CCU2D add_194_23 (.A0(\debounce_counters[4] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8487), .COUT(n8488), .S0(n503), 
          .S1(n502));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_23.INIT0 = 16'h5aaa;
    defparam add_194_23.INIT1 = 16'h5aaa;
    defparam add_194_23.INJECT1_0 = "NO";
    defparam add_194_23.INJECT1_1 = "NO";
    CCU2D add_167_21 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8438), .COUT(n8439), .S0(n187), 
          .S1(n186));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_21.INIT0 = 16'h5aaa;
    defparam add_167_21.INIT1 = 16'h5aaa;
    defparam add_167_21.INJECT1_0 = "NO";
    defparam add_167_21.INJECT1_1 = "NO";
    CCU2D add_167_19 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8437), .COUT(n8438), .S0(n189), 
          .S1(n188));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_19.INIT0 = 16'h5aaa;
    defparam add_167_19.INIT1 = 16'h5aaa;
    defparam add_167_19.INJECT1_0 = "NO";
    defparam add_167_19.INJECT1_1 = "NO";
    CCU2D add_194_21 (.A0(\debounce_counters[4] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8486), .COUT(n8487), .S0(n505), 
          .S1(n504));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_21.INIT0 = 16'h5aaa;
    defparam add_194_21.INIT1 = 16'h5aaa;
    defparam add_194_21.INJECT1_0 = "NO";
    defparam add_194_21.INJECT1_1 = "NO";
    LUT4 i2_3_lut_4_lut_4_lut (.A(next_state_3__N_1108[2]), .B(next_state[2]), 
         .C(n9780), .D(n9754), .Z(n9208)) /* synthesis lut_function=(!(A+((C+!(D))+!B))) */ ;
    defparam i2_3_lut_4_lut_4_lut.init = 16'h0400;
    LUT4 i36_4_lut_4_lut (.A(next_state_3__N_1108[2]), .B(next_state[0]), 
         .C(next_state[3]), .D(n9760), .Z(n19)) /* synthesis lut_function=(!(A (C+!(D))+!A !(B (C+(D))+!B !(C+!(D))))) */ ;
    defparam i36_4_lut_4_lut.init = 16'h4f40;
    LUT4 i10_4_lut (.A(resetcounter[4]), .B(n20), .C(n16), .D(resetcounter[1]), 
         .Z(n5824)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(465[6:29])
    defparam i10_4_lut.init = 16'hfffe;
    LUT4 i9_4_lut (.A(n9781), .B(n18_adj_1469), .C(resetcounter[0]), .D(resetcounter[5]), 
         .Z(n20)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(465[6:29])
    defparam i9_4_lut.init = 16'hfffe;
    CCU2D add_4632_12 (.A0(\debounce_counters[4] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8539), .COUT(n8540));
    defparam add_4632_12.INIT0 = 16'h5555;
    defparam add_4632_12.INIT1 = 16'h5555;
    defparam add_4632_12.INJECT1_0 = "NO";
    defparam add_4632_12.INJECT1_1 = "NO";
    LUT4 i5_2_lut (.A(resetcounter[21]), .B(n9129), .Z(n16)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(465[6:29])
    defparam i5_2_lut.init = 16'heeee;
    CCU2D add_4632_10 (.A0(\debounce_counters[4] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8538), .COUT(n8539));
    defparam add_4632_10.INIT0 = 16'h5555;
    defparam add_4632_10.INIT1 = 16'h5555;
    defparam add_4632_10.INJECT1_0 = "NO";
    defparam add_4632_10.INJECT1_1 = "NO";
    CCU2D add_4632_8 (.A0(\debounce_counters[4] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8537), .COUT(n8538));
    defparam add_4632_8.INIT0 = 16'h5555;
    defparam add_4632_8.INIT1 = 16'h5aaa;
    defparam add_4632_8.INJECT1_0 = "NO";
    defparam add_4632_8.INJECT1_1 = "NO";
    FD1S3AY signals_debounced_syn_i3 (.D(pushed_3__N_298), .CK(clk), .Q(signals_debounced_syn[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam signals_debounced_syn_i3.GSR = "DISABLED";
    FD1S3AY signals_debounced_syn_i2 (.D(pushed_2__N_300), .CK(clk), .Q(signals_debounced_syn[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam signals_debounced_syn_i2.GSR = "DISABLED";
    FD1P3IX pushed_i4 (.D(n10114), .SP(clk_enable_153), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(pushed[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam pushed_i4.GSR = "DISABLED";
    LUT4 i1773_2_lut_rep_122 (.A(signals_debounced_syn[4]), .B(externstop_falling), 
         .Z(n9787)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1436[5] 1444[12])
    defparam i1773_2_lut_rep_122.init = 16'h2222;
    FD1P3IX pushed_i3 (.D(n10114), .SP(clk_enable_154), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(pushed[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam pushed_i3.GSR = "DISABLED";
    FD1P3IX pushed_i2 (.D(n10114), .SP(clk_enable_155), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(pushed[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam pushed_i2.GSR = "DISABLED";
    FD1S3AY debounce_inputs_asyn2_i4 (.D(debounce_inputs_asyn1[4]), .CK(clk), 
            .Q(debounce_inputs_asyn2[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_inputs_asyn2_i4.GSR = "DISABLED";
    PFUMX i5622 (.BLUT(n9796), .ALUT(n9797), .C0(next_state[1]), .Z(clk_enable_27));
    CCU2D add_194_19 (.A0(\debounce_counters[4] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8485), .COUT(n8486), .S0(n507), 
          .S1(n506));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_19.INIT0 = 16'h5aaa;
    defparam add_194_19.INIT1 = 16'h5aaa;
    defparam add_194_19.INJECT1_0 = "NO";
    defparam add_194_19.INJECT1_1 = "NO";
    FD1S3AY debounce_inputs_asyn2_i3 (.D(debounce_inputs_asyn1[3]), .CK(clk), 
            .Q(debounce_inputs_asyn2[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_inputs_asyn2_i3.GSR = "DISABLED";
    FD1S3AY debounce_inputs_asyn2_i2 (.D(debounce_inputs_asyn1[2]), .CK(clk), 
            .Q(debounce_inputs_asyn2[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_inputs_asyn2_i2.GSR = "DISABLED";
    FD1S3IX temp1__i7 (.D(n_temp1[7]), .CK(clk), .CD(n9776), .Q(temp1[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp1__i7.GSR = "DISABLED";
    FD1S3IX temp1__i6 (.D(n_temp1[6]), .CK(clk), .CD(n9776), .Q(temp1[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp1__i6.GSR = "DISABLED";
    FD1S3IX temp1__i5 (.D(n_temp1[5]), .CK(clk), .CD(n9776), .Q(temp1[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp1__i5.GSR = "DISABLED";
    FD1S3IX temp1__i4 (.D(n_temp1[4]), .CK(clk), .CD(n9776), .Q(temp1[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp1__i4.GSR = "DISABLED";
    FD1S3IX temp1__i3 (.D(n_temp1[3]), .CK(clk), .CD(n9776), .Q(temp1[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp1__i3.GSR = "DISABLED";
    FD1S3IX temp1__i2 (.D(n_temp1[2]), .CK(clk), .CD(n9776), .Q(temp1[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp1__i2.GSR = "DISABLED";
    FD1S3IX temp1__i1 (.D(n_temp1[1]), .CK(clk), .CD(n9776), .Q(temp1[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(555[1] 570[11])
    defparam temp1__i1.GSR = "DISABLED";
    FD1P3IX data0__i7 (.D(n4690), .SP(clk_enable_162), .CD(n9776), .CK(clk), 
            .Q(data0[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(537[7] 550[14])
    defparam data0__i7.GSR = "DISABLED";
    FD1P3IX data0__i6 (.D(n4691), .SP(clk_enable_162), .CD(n9776), .CK(clk), 
            .Q(data0[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(537[7] 550[14])
    defparam data0__i6.GSR = "DISABLED";
    FD1P3IX data0__i5 (.D(n4692), .SP(clk_enable_162), .CD(n9776), .CK(clk), 
            .Q(data0[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(537[7] 550[14])
    defparam data0__i5.GSR = "DISABLED";
    FD1P3IX data0__i4 (.D(n4693), .SP(clk_enable_162), .CD(n9776), .CK(clk), 
            .Q(data0[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(537[7] 550[14])
    defparam data0__i4.GSR = "DISABLED";
    FD1P3IX data0__i3 (.D(n4694), .SP(clk_enable_162), .CD(n9776), .CK(clk), 
            .Q(data0[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(537[7] 550[14])
    defparam data0__i3.GSR = "DISABLED";
    FD1P3IX data0__i2 (.D(n9689), .SP(clk_enable_162), .CD(n9776), .CK(clk), 
            .Q(data0[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(537[7] 550[14])
    defparam data0__i2.GSR = "DISABLED";
    FD1P3IX data0__i1 (.D(n9714), .SP(clk_enable_162), .CD(n9776), .CK(clk), 
            .Q(data0[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(537[7] 550[14])
    defparam data0__i1.GSR = "DISABLED";
    FD1P3IX debounce_counters_4___i31 (.D(n493), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i31.GSR = "DISABLED";
    LUT4 next_state_0__bdd_3_lut_5510_4_lut (.A(signals_debounced_syn[4]), 
         .B(externstop_falling), .C(next_state_3__N_1108[2]), .D(next_state[0]), 
         .Z(n9488)) /* synthesis lut_function=(A (B (C+(D))+!B (D))+!A (C+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1436[5] 1444[12])
    defparam next_state_0__bdd_3_lut_5510_4_lut.init = 16'hffd0;
    CCU2D add_4632_6 (.A0(\debounce_counters[4] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8536), .COUT(n8537));
    defparam add_4632_6.INIT0 = 16'h5555;
    defparam add_4632_6.INIT1 = 16'h5aaa;
    defparam add_4632_6.INJECT1_0 = "NO";
    defparam add_4632_6.INJECT1_1 = "NO";
    CCU2D add_167_17 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8436), .COUT(n8437), .S0(n191), 
          .S1(n190));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_17.INIT0 = 16'h5aaa;
    defparam add_167_17.INIT1 = 16'h5aaa;
    defparam add_167_17.INJECT1_0 = "NO";
    defparam add_167_17.INJECT1_1 = "NO";
    CCU2D add_167_15 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8435), .COUT(n8436), .S0(n193), 
          .S1(n192));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_15.INIT0 = 16'h5aaa;
    defparam add_167_15.INIT1 = 16'h5aaa;
    defparam add_167_15.INJECT1_0 = "NO";
    defparam add_167_15.INJECT1_1 = "NO";
    CCU2D add_194_17 (.A0(\debounce_counters[4] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8484), .COUT(n8485), .S0(n509), 
          .S1(n508));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_17.INIT0 = 16'h5aaa;
    defparam add_194_17.INIT1 = 16'h5aaa;
    defparam add_194_17.INJECT1_0 = "NO";
    defparam add_194_17.INJECT1_1 = "NO";
    CCU2D add_4632_4 (.A0(\debounce_counters[4] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8535), .COUT(n8536));
    defparam add_4632_4.INIT0 = 16'h5555;
    defparam add_4632_4.INIT1 = 16'h5555;
    defparam add_4632_4.INJECT1_0 = "NO";
    defparam add_4632_4.INJECT1_1 = "NO";
    LUT4 i7_4_lut (.A(resetcounter[7]), .B(resetcounter[6]), .C(resetcounter[3]), 
         .D(resetcounter[2]), .Z(n18_adj_1469)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(465[6:29])
    defparam i7_4_lut.init = 16'hfffe;
    LUT4 i3322_2_lut_rep_123 (.A(next_state_3__N_1108[2]), .B(next_state[0]), 
         .Z(n9788)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam i3322_2_lut_rep_123.init = 16'h2222;
    LUT4 i4_4_lut_adj_107 (.A(resetcounter[14]), .B(resetcounter[13]), .C(resetcounter[15]), 
         .D(n6), .Z(n9129)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(465[6:29])
    defparam i4_4_lut_adj_107.init = 16'hfffe;
    LUT4 i1_2_lut_rep_105_3_lut (.A(next_state_3__N_1108[2]), .B(next_state[0]), 
         .C(next_state[1]), .Z(n9770)) /* synthesis lut_function=(!((B+(C))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam i1_2_lut_rep_105_3_lut.init = 16'h0202;
    PFUMX i42 (.BLUT(n8619), .ALUT(n8586), .C0(temp1[3]), .Z(n27));
    PFUMX mux_1445_i4 (.BLUT(n4662), .ALUT(n4935), .C0(temp1[1]), .Z(n4694));
    LUT4 i5376_4_lut_4_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_1108[2]), 
         .C(next_state[1]), .D(n9760), .Z(n9311)) /* synthesis lut_function=(A (B+(C))+!A !(B ((D)+!C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam i5376_4_lut_4_lut_4_lut.init = 16'ha9f9;
    BB FPIO_FlexMIO27_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO27), 
       .O(FPIO_FlexMIO27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    BB FPIO_FlexMIO30_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO30), 
       .O(FPIO_FlexMIO30_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    BB FPIO_FlexMIO29_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO29), 
       .O(FPIO_FlexMIO29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    LUT4 equal_269_i9_2_lut_rep_125 (.A(temp1[0]), .B(temp1[1]), .Z(n9790)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(546[13:23])
    defparam equal_269_i9_2_lut_rep_125.init = 16'hbbbb;
    BB DIG5S3C26_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C26), .O(DIG5S3C26_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    BB DIG5S3C25_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C25), .O(DIG5S3C25_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    BB DIG5S3C24_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C24), .O(DIG5S3C24_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    BB FlexMIOs54_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs54), .O(FlexMIOs54_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i30 (.D(n494), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i30.GSR = "DISABLED";
    BB FlexMIOs62_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs62), .O(FlexMIOs62_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i29 (.D(n495), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i29.GSR = "DISABLED";
    BB FlexMIOs63_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs63), .O(FlexMIOs63_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i28 (.D(n496), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i28.GSR = "DISABLED";
    BB FlexMIOs31_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs31), .O(FlexMIOs31_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i27 (.D(n497), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i27.GSR = "DISABLED";
    BB FlexMIOs30_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs30), .O(FlexMIOs30_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i26 (.D(n498), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i26.GSR = "DISABLED";
    BB FlexMIOs29_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs29), .O(FlexMIOs29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i25 (.D(n499), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i25.GSR = "DISABLED";
    BB FlexMIOs28_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs28), .O(FlexMIOs28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i24 (.D(n500), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i24.GSR = "DISABLED";
    BB FlexMIOs27_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs27), .O(FlexMIOs27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i23 (.D(n501), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i23.GSR = "DISABLED";
    BB FlexMIOs26_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs26), .O(FlexMIOs26_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i22 (.D(n502), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i22.GSR = "DISABLED";
    BB FlexMIOs37_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs37), .O(FlexMIOs37_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i21 (.D(n503), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i21.GSR = "DISABLED";
    BB FlexMIOs36_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs36), .O(FlexMIOs36_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i20 (.D(n504), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i20.GSR = "DISABLED";
    BB FlexMIOs35_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs35), .O(FlexMIOs35_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i19 (.D(n505), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i19.GSR = "DISABLED";
    BB FlexMIOs34_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs34), .O(FlexMIOs34_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i18 (.D(n506), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i18.GSR = "DISABLED";
    BB FlexMIOs33_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs33), .O(FlexMIOs33_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i17 (.D(n507), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i17.GSR = "DISABLED";
    BB FlexMIOs32_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs32), .O(FlexMIOs32_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i16 (.D(n508), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i16.GSR = "DISABLED";
    BB DIG5S3C03_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C03), .O(DIG5S3C03_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i15 (.D(n509), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i15.GSR = "DISABLED";
    BB DIG5S3C04_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C04), .O(DIG5S3C04_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i14 (.D(n510), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i14.GSR = "DISABLED";
    BB DIG5S3C05_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C05), .O(DIG5S3C05_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i13 (.D(n511), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i13.GSR = "DISABLED";
    BB DIG5S3C00_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C00), .O(DIG5S3C00_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    FD1P3IX debounce_counters_4___i12 (.D(n512), .SP(clk_enable_182), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_4___i12.GSR = "DISABLED";
    BB DIG5S3C02_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C02), .O(DIG5S3C02_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    BB DIG5S3C01_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C01), .O(DIG5S3C01_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    BB DIG5S3C29_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C29), .O(DIG5S3C29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    BB DIG5S3C28_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C28), .O(DIG5S3C28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    LUT4 i1_3_lut_4_lut_adj_108 (.A(wb_ack_o), .B(wb_stb_i), .C(n6949), 
         .D(n_temp1_7__N_359), .Z(n9175)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i1_3_lut_4_lut_adj_108.init = 16'h8000;
    BB DIG5S3C27_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C27), .O(DIG5S3C27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(385[1:17])
    OB FP_SysLEDg_pad (.I(FP_SysLEDg_c), .O(FP_SysLEDg));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(25[3:13])
    OB FP_SysLEDr_pad (.I(FP_SysLEDr_c), .O(FP_SysLEDr));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(26[3:13])
    OB FP_SysLEDb_pad (.I(FP_SysLEDb_c), .O(FP_SysLEDb));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(27[3:13])
    OB FlexIO05_pad (.I(GND_net), .O(FlexIO05));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(28[3:11])
    OB FlexIO02_pad (.I(GND_net), .O(FlexIO02));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(31[3:11])
    OB FlexIO01_pad (.I(GND_net), .O(FlexIO01));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(32[3:11])
    OB FPIO_isoCtrlRSTn_pad (.I(FPIO_isoCtrlRSTn_c), .O(FPIO_isoCtrlRSTn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(40[3:19])
    OB Carrier_PG_3V3_pad (.I(Carrier_PG_3V3_c), .O(Carrier_PG_3V3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(42[3:17])
    OB FPIO_FlexMIO52_pad (.I(FPIO_FlexMIO52_c_c), .O(FPIO_FlexMIO52));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(48[3:17])
    OBZ n5381_pad (.I(GND_net), .T(n5382), .O(Carrier_PG_1V8));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1304[1] 1485[13])
    OB FP_SysLEDs_pad (.I(FP_SysLEDs_c), .O(FP_SysLEDs));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(53[3:13])
    OB FP_UsrLED_pad_4 (.I(n9756), .O(FP_UsrLED[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(57[3:12])
    OB FP_UsrLED_pad_3 (.I(FP_UsrLED_c_3), .O(FP_UsrLED[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(57[3:12])
    OB FP_UsrLED_pad_2 (.I(FP_UsrLED_c_2), .O(FP_UsrLED[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(57[3:12])
    OB FP_UsrLED_pad_1 (.I(n9756), .O(FP_UsrLED[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(57[3:12])
    OB DIGS3C_Shared_CarrierReady_pad (.I(GND_net), .O(DIGS3C_Shared_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(58[3:29])
    OB DIGS3C_Shared_ReqSafeState_pad (.I(DIGS3C_Shared_ReqSafeState_c), .O(DIGS3C_Shared_ReqSafeState));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(59[3:29])
    OB SD_SEL_pad (.I(GND_net), .O(SD_SEL));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(67[3:9])
    OB FlexMIOs53_GPIO_PowerDown_pad (.I(FlexMIOs53_GPIO_PowerDown_c), .O(FlexMIOs53_GPIO_PowerDown));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(70[3:28])
    OB FlexMio61ExternalStop_pad (.I(FlexMio61ExternalStop_c_c), .O(FlexMio61ExternalStop));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(72[3:24])
    OB ANL_S3C_CarrierReady_pad (.I(GND_net), .O(ANL_S3C_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(101[3:23])
    OB DIGS3C_SlotD_SlotOE_pad_5 (.I(DIGS3C_SlotD_SlotOE_c_5), .O(DIGS3C_SlotD_SlotOE[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(103[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_4 (.I(DIGS3C_SlotD_SlotOE_c_4), .O(DIGS3C_SlotD_SlotOE[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(103[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_3 (.I(DIGS3C_SlotD_SlotOE_c_3), .O(DIGS3C_SlotD_SlotOE[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(103[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_2 (.I(DIGS3C_SlotD_SlotOE_c_2), .O(DIGS3C_SlotD_SlotOE[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(103[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_1 (.I(DIGS3C_SlotD_SlotOE_c_1), .O(DIGS3C_SlotD_SlotOE[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(103[3:22])
    OB Carrier_PwrOn_pad (.I(Carrier_PwrOn_c), .O(Carrier_PwrOn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(106[9:22])
    OB GPO_pad_7 (.I(GPO_c_7), .O(GPO[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(116[3:6])
    OB GPO_pad_6 (.I(GPO_c_6), .O(GPO[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(116[3:6])
    OB GPO_pad_5 (.I(GPO_c_5), .O(GPO[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(116[3:6])
    OB GPO_pad_4 (.I(GPO_c_4), .O(GPO[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(116[3:6])
    OB GPO_pad_3 (.I(GPO_c_3), .O(GPO[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(116[3:6])
    OB GPO_pad_2 (.I(GPO_c_2), .O(GPO[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(116[3:6])
    OB GPO_pad_1 (.I(GPO_c_1), .O(GPO[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(116[3:6])
    OB GPO_pad_0 (.I(GPO_c_0), .O(GPO[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(116[3:6])
    OBZ INTQ_pad (.I(GND_net), .T(check_irq_status), .O(INTQ));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(644[4] 655[16])
    IB FlexIO04_pad (.I(FlexIO04), .O(FlexIO04_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(29[3:11])
    IB FlexIO03_pad (.I(FlexIO03), .O(FlexIO03_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(30[3:11])
    IB FP_UsrSW1_pad (.I(FP_UsrSW1), .O(FP_UsrSW1_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(33[3:12])
    IB FP_UsrSW2_pad (.I(FP_UsrSW2), .O(FP_UsrSW2_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(34[3:12])
    IB SCL_pad (.I(SCL), .O(SCL_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(36[3:6])
    IB SDA_pad (.I(SDA), .O(SDA_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(37[3:6])
    IB FP_UsrSW3_pad (.I(FP_UsrSW3), .O(FP_UsrSW3_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(38[3:12])
    IB SysSW_Pwr_NC_pad (.I(SysSW_Pwr_NC), .O(SysSW_Pwr_NC_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(39[3:15])
    IB FPIO_iosCtrlINTn_pad (.I(FPIO_iosCtrlINTn), .O(FPIO_iosCtrlINTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(41[3:19])
    IB FlexMio61ExternalStop_c_pad (.I(FPIO_ExternalStop), .O(FlexMio61ExternalStop_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(43[3:20])
    IB SD1_CD_pad (.I(SD1_CD), .O(SD1_CD_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(54[3:9])
    IB SD0_CD_pad (.I(SD0_CD), .O(SD0_CD_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(55[3:9])
    IB SPI_S3C_nCS_USR_pad (.I(SPI_S3C_nCS_USR), .O(SPI_S3C_nCS_USR_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(56[3:18])
    IB DIGS3C_SlotD_ReqOE_pad_5 (.I(DIGS3C_SlotD_ReqOE[5]), .O(DIGS3C_SlotD_ReqOE_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(60[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_4 (.I(DIGS3C_SlotD_ReqOE[4]), .O(DIGS3C_SlotD_ReqOE_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(60[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_3 (.I(DIGS3C_SlotD_ReqOE[3]), .O(DIGS3C_SlotD_ReqOE_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(60[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_2 (.I(DIGS3C_SlotD_ReqOE[2]), .O(DIGS3C_SlotD_ReqOE_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(60[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_1 (.I(DIGS3C_SlotD_ReqOE[1]), .O(DIGS3C_SlotD_ReqOE_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(60[3:21])
    IB DIGS3C_SlotD_SlotOK_pad_5 (.I(DIGS3C_SlotD_SlotOK[5]), .O(DIGS3C_SlotD_SlotOK_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(61[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_4 (.I(DIGS3C_SlotD_SlotOK[4]), .O(DIGS3C_SlotD_SlotOK_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(61[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_3 (.I(DIGS3C_SlotD_SlotOK[3]), .O(DIGS3C_SlotD_SlotOK_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(61[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_2 (.I(DIGS3C_SlotD_SlotOK[2]), .O(DIGS3C_SlotD_SlotOK_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(61[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_1 (.I(DIGS3C_SlotD_SlotOK[1]), .O(DIGS3C_SlotD_SlotOK_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(61[3:22])
    IB FlexLIO_pad_5 (.I(FlexLIO[5]), .O(FlexLIO_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(62[3:10])
    IB FlexLIO_pad_4 (.I(FlexLIO[4]), .O(FlexLIO_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(62[3:10])
    IB FlexLIO_pad_3 (.I(FlexLIO[3]), .O(FlexLIO_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(62[3:10])
    IB FlexLIO_pad_2 (.I(FlexLIO[2]), .O(FlexLIO_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(62[3:10])
    IB FlexLIO_pad_1 (.I(FlexLIO[1]), .O(FlexLIO_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(62[3:10])
    IB FlexLIO_pad_0 (.I(FlexLIO[0]), .O(FlexLIO_c_0));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(62[3:10])
    IB FPIO_FlexMIO52_c_pad (.I(FlexMIOs52_PCIe), .O(FPIO_FlexMIO52_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(69[3:18])
    IB FlexMIOs45_pad (.I(FlexMIOs45), .O(FlexMIOs45_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(81[3:13])
    IB ANL_S3C_SLOTOK_pad_3 (.I(ANL_S3C_SLOTOK[3]), .O(ANL_S3C_SLOTOK_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(100[3:17])
    IB ANL_S3C_SLOTOK_pad_2 (.I(ANL_S3C_SLOTOK[2]), .O(ANL_S3C_SLOTOK_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(100[3:17])
    IB ANL_S3C_SLOTOK_pad_1 (.I(ANL_S3C_SLOTOK[1]), .O(ANL_S3C_SLOTOK_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(100[3:17])
    IB ANL_S3C_P54_Legacy_pad (.I(ANL_S3C_P54_Legacy), .O(ANL_S3C_P54_Legacy_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(102[3:21])
    IB PG_VIN_pad (.I(PG_VIN), .O(PG_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(107[3:9])
    IB PPn_VIN_pad (.I(PPn_VIN), .O(PPn_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(108[3:10])
    IB PG_Module_pad (.I(PG_Module), .O(PG_Module_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(109[3:12])
    IB TDnSHDN_pad (.I(TDnSHDN), .O(TDnSHDN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(110[3:10])
    IB TDnFFnFS_pad (.I(TDnFFnFS), .O(TDnFFnFS_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(111[3:11])
    IB TDnALERT_pad (.I(TDnALERT), .O(TDnALERT_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(112[3:11])
    IB S3C_S1_pad (.I(S3C_S1), .O(S3C_S1_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(113[3:9])
    IB IRQ_pad_3 (.I(IRQ[3]), .O(IRQ_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    IB IRQ_pad_2 (.I(IRQ[2]), .O(IRQ_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    IB IRQ_pad_1 (.I(IRQ[1]), .O(IRQ_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    IB IRQ_pad_0 (.I(IRQ[0]), .O(IRQ_c_0));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    IB GPI_pad_7 (.I(GPI[7]), .O(GPI_c_7));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(118[3:6])
    IB GPI_pad_6 (.I(GPI[6]), .O(GPI_c_6));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(118[3:6])
    IB GPI_pad_5 (.I(GPI[5]), .O(GPI_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(118[3:6])
    IB GPI_pad_4 (.I(GPI[4]), .O(GPI_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(118[3:6])
    IB GPI_pad_3 (.I(GPI[3]), .O(GPI_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(118[3:6])
    IB GPI_pad_2 (.I(GPI[2]), .O(GPI_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(118[3:6])
    IB GPI_pad_1 (.I(GPI[1]), .O(GPI_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(118[3:6])
    IB GPI_pad_0 (.I(GPI[0]), .O(GPI_c_0));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(118[3:6])
    IB RST_N_pad (.I(RST_N), .O(RST_N_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(119[3:8])
    LUT4 i3387_2_lut_3_lut (.A(n3145), .B(n4637), .C(n4641), .Z(n4543)) /* synthesis lut_function=(A+(B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam i3387_2_lut_3_lut.init = 16'hefef;
    LUT4 i2467_3_lut_4_lut (.A(clk_enable_205), .B(n4643), .C(n4637), 
         .D(n4641), .Z(n6181)) /* synthesis lut_function=(A (B+(C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam i2467_3_lut_4_lut.init = 16'ha8aa;
    LUT4 i2_3_lut_4_lut_adj_109 (.A(n9301), .B(n9759), .C(n6949), .D(n_temp1_7__N_359), 
         .Z(n3)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i2_3_lut_4_lut_adj_109.init = 16'h8000;
    FD1P3IX debounce_counters_3___i0 (.D(n418), .SP(clk_enable_183), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_counters_3___i0.GSR = "DISABLED";
    PFUMX i5537 (.BLUT(n9593), .ALUT(n9592), .C0(next_state[1]), .Z(n25));
    LUT4 i2_4_lut_4_lut (.A(next_state[3]), .B(next_state[1]), .C(next_state[2]), 
         .D(FlexMIOs53_GPIO_PowerDown_N_1321), .Z(FlexMIOs53_GPIO_PowerDown_N_1320)) /* synthesis lut_function=(!(A+!(B (C)+!B (C (D))))) */ ;
    defparam i2_4_lut_4_lut.init = 16'h5040;
    LUT4 mux_1145_Mux_3_i15_4_lut_4_lut_4_lut (.A(next_state[1]), .B(next_state[3]), 
         .C(next_state[2]), .D(next_state[0]), .Z(FP_SysLEDs_N_1317)) /* synthesis lut_function=(!(A (B+!(D))+!A (B (C)))) */ ;
    defparam mux_1145_Mux_3_i15_4_lut_4_lut_4_lut.init = 16'h3715;
    LUT4 FPIO_isoCtrlRSTn_N_1309_bdd_4_lut_3_lut_4_lut (.A(next_state[0]), 
         .B(next_state[1]), .C(extern_connected), .D(signals_debounced_syn[2]), 
         .Z(n9470)) /* synthesis lut_function=(!(A (B ((D)+!C))+!A !(B))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1309_bdd_4_lut_3_lut_4_lut.init = 16'h66e6;
    LUT4 i1_4_lut_4_lut_4_lut (.A(next_state[0]), .B(next_state[1]), .C(next_state[2]), 
         .D(next_state[3]), .Z(clk_enable_25)) /* synthesis lut_function=(A (B+(C+!(D)))+!A (B+((D)+!C))) */ ;
    defparam i1_4_lut_4_lut_4_lut.init = 16'hfdef;
    LUT4 i1_2_lut_rep_89_2_lut (.A(next_state[3]), .B(n9760), .Z(n9754)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i1_2_lut_rep_89_2_lut.init = 16'h4444;
    LUT4 i18_4_lut (.A(counter[0]), .B(counter[14]), .C(counter[10]), 
         .D(counter[19]), .Z(n43)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i18_4_lut.init = 16'hfffe;
    CCU2D add_194_15 (.A0(\debounce_counters[4] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8483), .COUT(n8484), .S0(n511), 
          .S1(n510));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_15.INIT0 = 16'h5aaa;
    defparam add_194_15.INIT1 = 16'h5aaa;
    defparam add_194_15.INJECT1_0 = "NO";
    defparam add_194_15.INJECT1_1 = "NO";
    LUT4 i1806_4_lut_4_lut (.A(wb_dat_o[2]), .B(clk_enable_184), .C(n_temp1_7__N_360), 
         .D(reg_rdy_N_1338), .Z(n5490)) /* synthesis lut_function=(A (B (C)+!B (D))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1037[5] 1043[15])
    defparam i1806_4_lut_4_lut.init = 16'hb380;
    FD1S3AY debounce_inputs_asyn1_i2 (.D(FlexMio61ExternalStop_c_c), .CK(clk), 
            .Q(debounce_inputs_asyn1[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_inputs_asyn1_i2.GSR = "DISABLED";
    CCU2D add_4632_2 (.A0(\debounce_counters[4] [7]), .B0(\debounce_counters[4] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[4] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n8535));
    defparam add_4632_2.INIT0 = 16'h1000;
    defparam add_4632_2.INIT1 = 16'h5aaa;
    defparam add_4632_2.INJECT1_0 = "NO";
    defparam add_4632_2.INJECT1_1 = "NO";
    LUT4 i993_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_state_7__N_1056[4]), 
         .D(wb_dat_o[4]), .Z(n3902)) /* synthesis lut_function=(!(A (B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i993_3_lut_4_lut.init = 16'h77f7;
    LUT4 i1_4_lut_adj_110 (.A(clk_enable_184), .B(n_temp1_7__N_366), .C(n2), 
         .D(n3), .Z(n_wb_dat_i[3])) /* synthesis lut_function=(!(A+!(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_110.init = 16'h5554;
    LUT4 i1_2_lut (.A(data0[3]), .B(n_temp1_7__N_365), .Z(n2)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_2_lut.init = 16'h8888;
    LUT4 i1056_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n9792), .D(n15_adj_1436), 
         .Z(n3965)) /* synthesis lut_function=(((C (D))+!B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i1056_3_lut_4_lut.init = 16'hf777;
    LUT4 i5366_4_lut_then_4_lut (.A(n14_adj_1470), .B(temp1[3]), .C(temp1[2]), 
         .D(temp1[0]), .Z(n9803)) /* synthesis lut_function=(A+((C+(D))+!B)) */ ;
    defparam i5366_4_lut_then_4_lut.init = 16'hfffb;
    LUT4 i1826_2_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_351), 
         .D(n_temp1_7__N_352), .Z(n5510)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A (C+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i1826_2_lut_3_lut_4_lut.init = 16'hf7f0;
    LUT4 i3366_2_lut (.A(n3147), .B(n4637), .Z(n4479)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam i3366_2_lut.init = 16'heeee;
    LUT4 i5366_4_lut_else_4_lut (.A(n14_adj_1470), .B(temp1[3]), .C(temp1[2]), 
         .D(temp1[0]), .Z(n9802)) /* synthesis lut_function=(A+(B+!(C (D)))) */ ;
    defparam i5366_4_lut_else_4_lut.init = 16'hefff;
    LUT4 i1089_2_lut_rep_102_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_358), 
         .Z(n9767)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i1089_2_lut_rep_102_3_lut.init = 16'h8080;
    LUT4 i1810_3_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_359), 
         .D(n_temp1_7__N_358), .Z(n5494)) /* synthesis lut_function=(A (B (D)+!B (C))+!A (C)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i1810_3_lut_3_lut_4_lut.init = 16'hf870;
    LUT4 i1259_2_lut_rep_92_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n6957), 
         .Z(n9757)) /* synthesis lut_function=(!(((C)+!B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i1259_2_lut_rep_92_3_lut.init = 16'h0808;
    LUT4 i1_2_lut_3_lut_4_lut_adj_111 (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_362), 
         .D(wb_dat_o[2]), .Z(n9189)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_111.init = 16'h8000;
    CCU2D add_4633_26 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8534), .S1(clk_enable_154));
    defparam add_4633_26.INIT0 = 16'hf555;
    defparam add_4633_26.INIT1 = 16'h0000;
    defparam add_4633_26.INJECT1_0 = "NO";
    defparam add_4633_26.INJECT1_1 = "NO";
    LUT4 i1_4_lut_4_lut_4_lut_adj_112 (.A(next_state[3]), .B(next_state_3__N_1108[2]), 
         .C(n9787), .D(next_state[0]), .Z(n23)) /* synthesis lut_function=(!(A (((D)+!C)+!B)+!A !(B))) */ ;
    defparam i1_4_lut_4_lut_4_lut_adj_112.init = 16'h44c4;
    FD1S3AY debounce_inputs_asyn1_i3 (.D(FP_UsrSW3_c), .CK(clk), .Q(debounce_inputs_asyn1[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_inputs_asyn1_i3.GSR = "DISABLED";
    FD1S3AY debounce_inputs_asyn1_i4 (.D(FP_UsrSW1_c), .CK(clk), .Q(debounce_inputs_asyn1[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(405[9] 431[10])
    defparam debounce_inputs_asyn1_i4.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i2 (.D(n5476), .CK(clk), .CD(n9776), .Q(n_temp1_7__N_368));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i2.GSR = "DISABLED";
    CCU2D add_176_27 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8457), .COUT(n8458), .S0(n287), 
          .S1(n286));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_27.INIT0 = 16'h5aaa;
    defparam add_176_27.INIT1 = 16'h5aaa;
    defparam add_176_27.INJECT1_0 = "NO";
    defparam add_176_27.INJECT1_1 = "NO";
    CCU2D add_4633_24 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8533), .COUT(n8534));
    defparam add_4633_24.INIT0 = 16'h5555;
    defparam add_4633_24.INIT1 = 16'h5555;
    defparam add_4633_24.INJECT1_0 = "NO";
    defparam add_4633_24.INJECT1_1 = "NO";
    LUT4 i2_3_lut_rep_126 (.A(externstop_falling), .B(signals_debounced_syn[4]), 
         .C(next_state_3__N_1108[2]), .Z(n9791)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;
    defparam i2_3_lut_rep_126.init = 16'h4040;
    LUT4 i1_2_lut_adj_113 (.A(resetcounter[16]), .B(resetcounter[17]), .Z(n6)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(465[6:29])
    defparam i1_2_lut_adj_113.init = 16'heeee;
    LUT4 n9132_bdd_2_lut_2_lut_4_lut (.A(externstop_falling), .B(signals_debounced_syn[4]), 
         .C(next_state_3__N_1108[2]), .D(next_state[0]), .Z(n9593)) /* synthesis lut_function=(!(A+(((D)+!C)+!B))) */ ;
    defparam n9132_bdd_2_lut_2_lut_4_lut.init = 16'h0040;
    CCU2D add_4633_22 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8532), .COUT(n8533));
    defparam add_4633_22.INIT0 = 16'h5555;
    defparam add_4633_22.INIT1 = 16'h5555;
    defparam add_4633_22.INJECT1_0 = "NO";
    defparam add_4633_22.INJECT1_1 = "NO";
    CCU2D add_4633_20 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8531), .COUT(n8532));
    defparam add_4633_20.INIT0 = 16'h5555;
    defparam add_4633_20.INIT1 = 16'h5555;
    defparam add_4633_20.INJECT1_0 = "NO";
    defparam add_4633_20.INJECT1_1 = "NO";
    LUT4 i1814_4_lut_4_lut (.A(wb_dat_o[2]), .B(clk_enable_184), .C(n_temp1_7__N_356), 
         .D(n_temp1_7__N_357), .Z(n5498)) /* synthesis lut_function=(A (B (C)+!B (D))+!A (B (C+(D))+!B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1037[5] 1043[15])
    defparam i1814_4_lut_4_lut.init = 16'hf7c0;
    CCU2D add_4633_18 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8530), .COUT(n8531));
    defparam add_4633_18.INIT0 = 16'h5555;
    defparam add_4633_18.INIT1 = 16'h5555;
    defparam add_4633_18.INJECT1_0 = "NO";
    defparam add_4633_18.INJECT1_1 = "NO";
    LUT4 mux_1364_i20_4_lut_4_lut (.A(next_state[1]), .B(n4637), .C(n4641), 
         .D(n3142), .Z(n4540)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_1364_i20_4_lut_4_lut.init = 16'hf5c5;
    CCU2D add_194_13 (.A0(\debounce_counters[4] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8482), .COUT(n8483), .S0(n513), 
          .S1(n512));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_13.INIT0 = 16'h5aaa;
    defparam add_194_13.INIT1 = 16'h5aaa;
    defparam add_194_13.INJECT1_0 = "NO";
    defparam add_194_13.INJECT1_1 = "NO";
    LUT4 i23_4_lut (.A(n27_adj_1455), .B(n46), .C(n40), .D(n28_adj_1476), 
         .Z(n48)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i23_4_lut.init = 16'hfffe;
    CCU2D add_176_25 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8456), .COUT(n8457), .S0(n289), 
          .S1(n288));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_25.INIT0 = 16'h5aaa;
    defparam add_176_25.INIT1 = 16'h5aaa;
    defparam add_176_25.INJECT1_0 = "NO";
    defparam add_176_25.INJECT1_1 = "NO";
    CCU2D add_176_23 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8455), .COUT(n8456), .S0(n291), 
          .S1(n290));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_23.INIT0 = 16'h5aaa;
    defparam add_176_23.INIT1 = 16'h5aaa;
    defparam add_176_23.INJECT1_0 = "NO";
    defparam add_176_23.INJECT1_1 = "NO";
    CCU2D add_176_21 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8454), .COUT(n8455), .S0(n293), 
          .S1(n292));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_21.INIT0 = 16'h5aaa;
    defparam add_176_21.INIT1 = 16'h5aaa;
    defparam add_176_21.INJECT1_0 = "NO";
    defparam add_176_21.INJECT1_1 = "NO";
    LUT4 mux_1364_i18_4_lut_4_lut (.A(next_state[1]), .B(n4637), .C(n4641), 
         .D(n3144), .Z(n4542)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_1364_i18_4_lut_4_lut.init = 16'hf5c5;
    CCU2D add_194_11 (.A0(\debounce_counters[4] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8481), .COUT(n8482), .S0(n515), 
          .S1(n514));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_11.INIT0 = 16'h5aaa;
    defparam add_194_11.INIT1 = 16'h5aaa;
    defparam add_194_11.INJECT1_0 = "NO";
    defparam add_194_11.INJECT1_1 = "NO";
    CCU2D add_194_9 (.A0(\debounce_counters[4] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8480), .COUT(n8481), .S0(n517), 
          .S1(n516));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_9.INIT0 = 16'h5aaa;
    defparam add_194_9.INIT1 = 16'h5aaa;
    defparam add_194_9.INJECT1_0 = "NO";
    defparam add_194_9.INJECT1_1 = "NO";
    LUT4 i1812_4_lut_4_lut (.A(wb_dat_o[2]), .B(clk_enable_184), .C(n_temp1_7__N_357), 
         .D(n_temp1_7__N_358), .Z(n5496)) /* synthesis lut_function=(A (B (C)+!B (D))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1037[5] 1043[15])
    defparam i1812_4_lut_4_lut.init = 16'hb380;
    CCU2D add_167_13 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8434), .COUT(n8435), .S0(n195), 
          .S1(n194));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_13.INIT0 = 16'h5aaa;
    defparam add_167_13.INIT1 = 16'h5aaa;
    defparam add_167_13.INJECT1_0 = "NO";
    defparam add_167_13.INJECT1_1 = "NO";
    LUT4 i12_2_lut_adj_114 (.A(counter[7]), .B(counter[12]), .Z(n37)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i12_2_lut_adj_114.init = 16'heeee;
    CCU2D add_194_7 (.A0(\debounce_counters[4] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8479), .COUT(n8480), .S0(n519), 
          .S1(n518));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_7.INIT0 = 16'h5aaa;
    defparam add_194_7.INIT1 = 16'h5aaa;
    defparam add_194_7.INJECT1_0 = "NO";
    defparam add_194_7.INJECT1_1 = "NO";
    LUT4 n4_bdd_3_lut_5581_3_lut (.A(next_state[1]), .B(next_state[0]), 
         .C(next_state[2]), .Z(n9695)) /* synthesis lut_function=(!(A (C)+!A (B+(C)))) */ ;
    defparam n4_bdd_3_lut_5581_3_lut.init = 16'h0b0b;
    LUT4 mux_1364_i21_4_lut_4_lut (.A(next_state[1]), .B(n4637), .C(n4641), 
         .D(n3141), .Z(n4539)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_1364_i21_4_lut_4_lut.init = 16'hf5c5;
    LUT4 mux_1364_i19_4_lut_4_lut (.A(next_state[1]), .B(n4637), .C(n4641), 
         .D(n3143), .Z(n4541)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_1364_i19_4_lut_4_lut.init = 16'hf5c5;
    LUT4 next_state_1__bdd_3_lut_5478_3_lut_3_lut (.A(next_state[1]), .B(next_state[3]), 
         .C(next_state[2]), .Z(n9500)) /* synthesis lut_function=(A+((C)+!B)) */ ;
    defparam next_state_1__bdd_3_lut_5478_3_lut_3_lut.init = 16'hfbfb;
    FD1S3IX c_state_FSM_i3 (.D(n8787), .CK(clk), .CD(n9776), .Q(n_temp1_7__N_367));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i3.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i4 (.D(n12_adj_1456), .CK(clk), .CD(n9776), .Q(n_temp1_7__N_366));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i4.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i5 (.D(n8823), .CK(clk), .CD(n9776), .Q(n_temp1_7__N_365));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i5.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i6 (.D(n8665), .CK(clk), .CD(n9776), .Q(dat_rdy_N_1342));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i6.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i7 (.D(n5486), .CK(clk), .CD(n9776), .Q(n_temp1_7__N_363));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i7.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i8 (.D(n8653), .CK(clk), .CD(n9776), .Q(n_temp1_7__N_362));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i8.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i9 (.D(n5490), .CK(clk), .CD(n9776), .Q(reg_rdy_N_1338));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i9.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i10 (.D(n5492), .CK(clk), .CD(n9776), .Q(n_temp1_7__N_360));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i10.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i11 (.D(n5494), .CK(clk), .CD(n9776), .Q(n_temp1_7__N_359));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i11.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i12 (.D(n5496), .CK(clk), .CD(n9776), .Q(n_temp1_7__N_358));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i12.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i13 (.D(n5498), .CK(clk), .CD(n9776), .Q(n_temp1_7__N_357));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i13.GSR = "DISABLED";
    FD1P3IX c_state_FSM_i14 (.D(n_temp1_7__N_355), .SP(clk_enable_184), 
            .CD(n9776), .CK(clk), .Q(n_temp1_7__N_356));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i14.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i15 (.D(n9069), .CK(clk), .CD(n9776), .Q(n_temp1_7__N_355));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i15.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i16 (.D(n5506), .CK(clk), .CD(n9776), .Q(n_temp1_7__N_354));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i16.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i17 (.D(n8781), .CK(clk), .CD(n9776), .Q(n_temp1_7__N_353));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i17.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i18 (.D(n5510), .CK(clk), .CD(n9776), .Q(n_temp1_7__N_352));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i18.GSR = "DISABLED";
    FD1S3AX c_state_FSM_i19 (.D(n9776), .CK(clk), .Q(n_temp1_7__N_351));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam c_state_FSM_i19.GSR = "DISABLED";
    FD1P3IX irq_en__i1 (.D(temp2[1]), .SP(clk_enable_193), .CD(n9776), 
            .CK(clk), .Q(irq_en[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(686[1] 697[10])
    defparam irq_en__i1.GSR = "DISABLED";
    LUT4 mux_1364_i12_4_lut_4_lut (.A(next_state[1]), .B(n4637), .C(n4641), 
         .D(n3150), .Z(n4548)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_1364_i12_4_lut_4_lut.init = 16'hf5c5;
    LUT4 mux_1364_i9_4_lut_4_lut (.A(next_state[1]), .B(n4637), .C(n4641), 
         .D(n3153), .Z(n4551)) /* synthesis lut_function=(!(A (B+!(C (D)))+!A (B (C)+!B !((D)+!C)))) */ ;
    defparam mux_1364_i9_4_lut_4_lut.init = 16'h3505;
    LUT4 i1_4_lut_4_lut_4_lut_4_lut (.A(next_state[1]), .B(next_state[0]), 
         .C(next_state[3]), .D(next_state[2]), .Z(FP_SysLEDg_N_1303)) /* synthesis lut_function=(!(A ((D)+!B)+!A (B (C (D))+!B (C (D)+!C !(D))))) */ ;
    defparam i1_4_lut_4_lut_4_lut_4_lut.init = 16'h05dc;
    CCU2D add_194_5 (.A0(\debounce_counters[4] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8478), .COUT(n8479), .S0(n521), 
          .S1(n520));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_5.INIT0 = 16'h5aaa;
    defparam add_194_5.INIT1 = 16'h5aaa;
    defparam add_194_5.INJECT1_0 = "NO";
    defparam add_194_5.INJECT1_1 = "NO";
    LUT4 next_state_0__bdd_4_lut_5509_3_lut (.A(next_state[1]), .B(n9760), 
         .C(next_state_3__N_1108[2]), .Z(n9486)) /* synthesis lut_function=(A (B)+!A (C)) */ ;
    defparam next_state_0__bdd_4_lut_5509_3_lut.init = 16'hd8d8;
    LUT4 i1_2_lut_rep_128 (.A(n_temp1_7__N_362), .B(n_temp1_7__N_360), .Z(n10112)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_2_lut_rep_128.init = 16'heeee;
    LUT4 i1_2_lut_rep_127 (.A(n_state_7__N_1056[4]), .B(wb_dat_o[2]), .Z(n9792)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam i1_2_lut_rep_127.init = 16'h2222;
    LUT4 i5448_4_lut (.A(clk_enable_184), .B(n_temp1_7__N_366), .C(n9279), 
         .D(n9784), .Z(n_wb_dat_i[2])) /* synthesis lut_function=(!(A+!(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i5448_4_lut.init = 16'h5554;
    CCU2D add_176_19 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8453), .COUT(n8454), .S0(n295), 
          .S1(n294));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_19.INIT0 = 16'h5aaa;
    defparam add_176_19.INIT1 = 16'h5aaa;
    defparam add_176_19.INJECT1_0 = "NO";
    defparam add_176_19.INJECT1_1 = "NO";
    LUT4 i5368_4_lut (.A(n9287), .B(resetcounter[22]), .C(n9289), .D(resetcounter[19]), 
         .Z(n9303)) /* synthesis lut_function=(A (B (C (D)))) */ ;
    defparam i5368_4_lut.init = 16'h8000;
    LUT4 i5352_4_lut (.A(resetcounter[23]), .B(resetcounter[18]), .C(resetcounter[9]), 
         .D(resetcounter[20]), .Z(n9287)) /* synthesis lut_function=(A (B (C (D)))) */ ;
    defparam i5352_4_lut.init = 16'h8000;
    CCU2D add_4633_16 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8529), .COUT(n8530));
    defparam add_4633_16.INIT0 = 16'h5555;
    defparam add_4633_16.INIT1 = 16'h5555;
    defparam add_4633_16.INJECT1_0 = "NO";
    defparam add_4633_16.INJECT1_1 = "NO";
    CCU2D add_194_3 (.A0(\debounce_counters[4] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8477), .COUT(n8478), .S0(n523), 
          .S1(n522));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_3.INIT0 = 16'h5aaa;
    defparam add_194_3.INIT1 = 16'h5aaa;
    defparam add_194_3.INJECT1_0 = "NO";
    defparam add_194_3.INJECT1_1 = "NO";
    LUT4 i5344_2_lut (.A(data0[2]), .B(n_temp1_7__N_365), .Z(n9279)) /* synthesis lut_function=(A (B)) */ ;
    defparam i5344_2_lut.init = 16'h8888;
    CCU2D add_176_17 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8452), .COUT(n8453), .S0(n297), 
          .S1(n296));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_17.INIT0 = 16'h5aaa;
    defparam add_176_17.INIT1 = 16'h5aaa;
    defparam add_176_17.INJECT1_0 = "NO";
    defparam add_176_17.INJECT1_1 = "NO";
    LUT4 temp1_7__I_0_838_i10_2_lut (.A(temp1[2]), .B(temp1[3]), .Z(n10_adj_1443)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(682[26:46])
    defparam temp1_7__I_0_838_i10_2_lut.init = 16'heeee;
    LUT4 i5354_3_lut (.A(resetcounter[24]), .B(resetcounter[12]), .C(resetcounter[8]), 
         .Z(n9289)) /* synthesis lut_function=(A (B (C))) */ ;
    defparam i5354_3_lut.init = 16'h8080;
    LUT4 i5313_3_lut (.A(n5824), .B(n9303), .C(n8732), .Z(FP_UsrLED_c_2)) /* synthesis lut_function=(A+!(B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(444[9] 459[16])
    defparam i5313_3_lut.init = 16'hbaba;
    CCU2D add_176_15 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8451), .COUT(n8452), .S0(n299), 
          .S1(n298));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_15.INIT0 = 16'h5aaa;
    defparam add_176_15.INIT1 = 16'h5aaa;
    defparam add_176_15.INJECT1_0 = "NO";
    defparam add_176_15.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_4_lut_adj_115 (.A(n_state_7__N_1056[4]), .B(wb_dat_o[2]), 
         .C(n6957), .D(n15_adj_1436), .Z(n9196)) /* synthesis lut_function=(!((B+!(C+(D)))+!A)) */ ;
    defparam i1_2_lut_3_lut_4_lut_adj_115.init = 16'h2220;
    CCU2D add_4633_14 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8528), .COUT(n8529));
    defparam add_4633_14.INIT0 = 16'h5555;
    defparam add_4633_14.INIT1 = 16'h5555;
    defparam add_4633_14.INJECT1_0 = "NO";
    defparam add_4633_14.INJECT1_1 = "NO";
    CCU2D add_176_13 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8450), .COUT(n8451), .S0(n301), 
          .S1(n300));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_13.INIT0 = 16'h5aaa;
    defparam add_176_13.INIT1 = 16'h5aaa;
    defparam add_176_13.INJECT1_0 = "NO";
    defparam add_176_13.INJECT1_1 = "NO";
    LUT4 i3_4_lut (.A(temp2[0]), .B(n9766), .C(dat_rdy_del), .D(n10_adj_1443), 
         .Z(n9144)) /* synthesis lut_function=(!(A+(B+((D)+!C)))) */ ;
    defparam i3_4_lut.init = 16'h0010;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut (.A(DIGS3C_SlotD_ReqOE_c_5), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_5)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(399[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut.init = 16'h2222;
    CCU2D add_194_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[4] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n8477), .S1(n524));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_194_1.INIT0 = 16'hF000;
    defparam add_194_1.INIT1 = 16'h5555;
    defparam add_194_1.INJECT1_0 = "NO";
    defparam add_194_1.INJECT1_1 = "NO";
    CCU2D add_167_11 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8433), .COUT(n8434), .S0(n197), 
          .S1(n196));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_11.INIT0 = 16'h5aaa;
    defparam add_167_11.INIT1 = 16'h5aaa;
    defparam add_167_11.INJECT1_0 = "NO";
    defparam add_167_11.INJECT1_1 = "NO";
    CCU2D add_4633_12 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8527), .COUT(n8528));
    defparam add_4633_12.INIT0 = 16'h5555;
    defparam add_4633_12.INIT1 = 16'h5555;
    defparam add_4633_12.INJECT1_0 = "NO";
    defparam add_4633_12.INJECT1_1 = "NO";
    CCU2D add_4633_10 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8526), .COUT(n8527));
    defparam add_4633_10.INIT0 = 16'h5555;
    defparam add_4633_10.INIT1 = 16'h5555;
    defparam add_4633_10.INJECT1_0 = "NO";
    defparam add_4633_10.INJECT1_1 = "NO";
    CCU2D add_4633_8 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8525), .COUT(n8526));
    defparam add_4633_8.INIT0 = 16'h5555;
    defparam add_4633_8.INIT1 = 16'h5aaa;
    defparam add_4633_8.INJECT1_0 = "NO";
    defparam add_4633_8.INJECT1_1 = "NO";
    CCU2D add_4633_6 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8524), .COUT(n8525));
    defparam add_4633_6.INIT0 = 16'h5555;
    defparam add_4633_6.INIT1 = 16'h5aaa;
    defparam add_4633_6.INJECT1_0 = "NO";
    defparam add_4633_6.INJECT1_1 = "NO";
    LUT4 i975_2_lut_3_lut_4_lut (.A(n_state_7__N_1056[4]), .B(wb_dat_o[2]), 
         .C(wb_stb_i), .D(wb_ack_o), .Z(n3884)) /* synthesis lut_function=(!(A (B (C (D)))+!A (C (D)))) */ ;
    defparam i975_2_lut_3_lut_4_lut.init = 16'h2fff;
    CCU2D add_4633_4 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8523), .COUT(n8524));
    defparam add_4633_4.INIT0 = 16'h5555;
    defparam add_4633_4.INIT1 = 16'h5555;
    defparam add_4633_4.INJECT1_0 = "NO";
    defparam add_4633_4.INJECT1_1 = "NO";
    CCU2D add_4633_2 (.A0(\debounce_counters[3] [7]), .B0(\debounce_counters[3] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[3] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n8523));
    defparam add_4633_2.INIT0 = 16'h1000;
    defparam add_4633_2.INIT1 = 16'h5aaa;
    defparam add_4633_2.INJECT1_0 = "NO";
    defparam add_4633_2.INJECT1_1 = "NO";
    CCU2D add_185_33 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8476), .S0(n387));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_33.INIT0 = 16'h5aaa;
    defparam add_185_33.INIT1 = 16'h0000;
    defparam add_185_33.INJECT1_0 = "NO";
    defparam add_185_33.INJECT1_1 = "NO";
    CCU2D add_176_11 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8449), .COUT(n8450), .S0(n303), 
          .S1(n302));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_11.INIT0 = 16'h5aaa;
    defparam add_176_11.INIT1 = 16'h5aaa;
    defparam add_176_11.INJECT1_0 = "NO";
    defparam add_176_11.INJECT1_1 = "NO";
    CCU2D add_167_9 (.A0(\debounce_counters[1] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8432), .COUT(n8433), .S0(n199), 
          .S1(n198));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_9.INIT0 = 16'h5aaa;
    defparam add_167_9.INIT1 = 16'h5aaa;
    defparam add_167_9.INJECT1_0 = "NO";
    defparam add_167_9.INJECT1_1 = "NO";
    LUT4 i1576_2_lut (.A(clk_enable_155), .B(debounce_inputs_asyn2[2]), 
         .Z(clk_enable_126)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i1576_2_lut.init = 16'hdddd;
    PFUMX i5620 (.BLUT(n9793), .ALUT(n9794), .C0(next_state[1]), .Z(n9795));
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut (.A(DIGS3C_SlotD_ReqOE_c_4), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_4)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(399[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut.init = 16'h2222;
    CCU2D resetcounter_i24_1568_add_4_25 (.A0(resetcounter[23]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8521), .S0(n107), .S1(n106_adj_1463));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568_add_4_25.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_25.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_25.INJECT1_0 = "NO";
    defparam resetcounter_i24_1568_add_4_25.INJECT1_1 = "NO";
    LUT4 i3270_2_lut_rep_93_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n9765), 
         .D(n5927), .Z(n9758)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i3270_2_lut_rep_93_3_lut_4_lut.init = 16'h8000;
    LUT4 i1_2_lut_3_lut_4_lut_adj_116 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[0]), 
         .D(n_temp1_7__N_365), .Z(n_wb_dat_i[0])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_116.init = 16'h7000;
    LUT4 i1_3_lut_4_lut_adj_117 (.A(n9762), .B(clk_enable_184), .C(reg_rdy_N_1338), 
         .D(n9223), .Z(n17)) /* synthesis lut_function=(!(A (B (D)+!B !(C+!(D)))+!A !(C+!(D)))) */ ;
    defparam i1_3_lut_4_lut_adj_117.init = 16'h70ff;
    CCU2D resetcounter_i24_1568_add_4_23 (.A0(resetcounter[21]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8520), .COUT(n8521), .S0(n109), 
          .S1(n108_adj_1462));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568_add_4_23.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_23.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_23.INJECT1_0 = "NO";
    defparam resetcounter_i24_1568_add_4_23.INJECT1_1 = "NO";
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut (.A(DIGS3C_SlotD_ReqOE_c_3), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_3)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(399[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut.init = 16'h2222;
    CCU2D add_185_31 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8475), .COUT(n8476), .S0(n389), 
          .S1(n388));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_31.INIT0 = 16'h5aaa;
    defparam add_185_31.INIT1 = 16'h5aaa;
    defparam add_185_31.INJECT1_0 = "NO";
    defparam add_185_31.INJECT1_1 = "NO";
    LUT4 i13_3_lut (.A(counter[8]), .B(counter[5]), .C(counter[6]), .Z(n38)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i13_3_lut.init = 16'hfefe;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut (.A(DIGS3C_SlotD_ReqOE_c_2), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_2)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(399[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut.init = 16'h2222;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut (.A(DIGS3C_SlotD_ReqOE_c_1), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_1)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(399[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut.init = 16'h2222;
    CCU2D resetcounter_i24_1568_add_4_21 (.A0(resetcounter[19]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8519), .COUT(n8520), .S0(n111_adj_1460), 
          .S1(n110_adj_1461));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568_add_4_21.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_21.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_21.INJECT1_0 = "NO";
    defparam resetcounter_i24_1568_add_4_21.INJECT1_1 = "NO";
    CCU2D add_185_29 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8474), .COUT(n8475), .S0(n391), 
          .S1(n390));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_29.INIT0 = 16'h5aaa;
    defparam add_185_29.INIT1 = 16'h5aaa;
    defparam add_185_29.INJECT1_0 = "NO";
    defparam add_185_29.INJECT1_1 = "NO";
    LUT4 i1887_2_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n9224), 
         .D(n_temp1_7__N_365), .Z(n_wb_adr_i[2])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i1887_2_lut_3_lut_4_lut.init = 16'h7770;
    CCU2D resetcounter_i24_1568_add_4_19 (.A0(resetcounter[17]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8518), .COUT(n8519), .S0(n113), 
          .S1(n112_adj_1458));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568_add_4_19.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_19.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_19.INJECT1_0 = "NO";
    defparam resetcounter_i24_1568_add_4_19.INJECT1_1 = "NO";
    CCU2D add_185_27 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8473), .COUT(n8474), .S0(n393), 
          .S1(n392));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_27.INIT0 = 16'h5aaa;
    defparam add_185_27.INIT1 = 16'h5aaa;
    defparam add_185_27.INJECT1_0 = "NO";
    defparam add_185_27.INJECT1_1 = "NO";
    CCU2D add_176_9 (.A0(\debounce_counters[2] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8448), .COUT(n8449), .S0(n305), 
          .S1(n304));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_9.INIT0 = 16'h5aaa;
    defparam add_176_9.INIT1 = 16'h5aaa;
    defparam add_176_9.INJECT1_0 = "NO";
    defparam add_176_9.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1568_add_4_17 (.A0(resetcounter[15]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8517), .COUT(n8518), .S0(n115), 
          .S1(n114_adj_1454));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568_add_4_17.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_17.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_17.INJECT1_0 = "NO";
    defparam resetcounter_i24_1568_add_4_17.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1568_add_4_15 (.A0(resetcounter[13]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8516), .COUT(n8517), .S0(n117_adj_1452), 
          .S1(n116_adj_1453));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568_add_4_15.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_15.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_15.INJECT1_0 = "NO";
    defparam resetcounter_i24_1568_add_4_15.INJECT1_1 = "NO";
    LUT4 i5432_4_lut (.A(irq_status[0]), .B(irq_status[3]), .C(irq_status[2]), 
         .D(irq_status[1]), .Z(check_irq_status)) /* synthesis lut_function=(!(A+(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(644[4] 655[16])
    defparam i5432_4_lut.init = 16'h0001;
    FD1P3AX extern_connected_757 (.D(n10114), .SP(clk_enable_186), .CK(clk), 
            .Q(extern_connected)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam extern_connected_757.GSR = "DISABLED";
    LUT4 i943_3_lut_4_lut (.A(n9301), .B(n9759), .C(clk_enable_184), .D(n6949), 
         .Z(n3852)) /* synthesis lut_function=(A (B (C)+!B !((D)+!C))+!A !((D)+!C)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i943_3_lut_4_lut.init = 16'h80f0;
    FD1P3AX next_state_i3 (.D(next_state_3__N_69[3]), .SP(clk_enable_187), 
            .CK(clk), .Q(next_state[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam next_state_i3.GSR = "DISABLED";
    FD1P3AX next_state_i2 (.D(next_state_3__N_69[2]), .SP(clk_enable_188), 
            .CK(clk), .Q(next_state[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam next_state_i2.GSR = "DISABLED";
    LUT4 i1792_4_lut (.A(n_temp1_7__N_368), .B(clk_enable_184), .C(n_temp1_7__N_365), 
         .D(n9196), .Z(n5476)) /* synthesis lut_function=(A ((C+(D))+!B)+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1792_4_lut.init = 16'heae2;
    LUT4 i2_4_lut_4_lut_adj_118 (.A(clk_enable_184), .B(n_state_7__N_1056[4]), 
         .C(n5_adj_1471), .D(n_temp1_7__N_367), .Z(n6_adj_1468)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(862[7] 882[12])
    defparam i2_4_lut_4_lut_adj_118.init = 16'hfda0;
    LUT4 i1_2_lut_3_lut_4_lut_adj_119 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[5]), 
         .D(n_temp1_7__N_365), .Z(n_wb_dat_i[5])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_119.init = 16'h7000;
    FD1P3AX next_state_i1 (.D(next_state_3__N_69[1]), .SP(clk_enable_189), 
            .CK(clk), .Q(next_state[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam next_state_i1.GSR = "DISABLED";
    CCU2D resetcounter_i24_1568_add_4_13 (.A0(resetcounter[11]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8515), .COUT(n8516), .S0(n119), 
          .S1(n118));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568_add_4_13.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_13.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_13.INJECT1_0 = "NO";
    defparam resetcounter_i24_1568_add_4_13.INJECT1_1 = "NO";
    CCU2D add_185_25 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8472), .COUT(n8473), .S0(n395), 
          .S1(n394));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_25.INIT0 = 16'h5aaa;
    defparam add_185_25.INIT1 = 16'h5aaa;
    defparam add_185_25.INJECT1_0 = "NO";
    defparam add_185_25.INJECT1_1 = "NO";
    CCU2D add_176_7 (.A0(\debounce_counters[2] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8447), .COUT(n8448), .S0(n307), 
          .S1(n306));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_7.INIT0 = 16'h5aaa;
    defparam add_176_7.INIT1 = 16'h5aaa;
    defparam add_176_7.INJECT1_0 = "NO";
    defparam add_176_7.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_4_lut_adj_120 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[6]), 
         .D(n_temp1_7__N_365), .Z(n_wb_dat_i[6])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_120.init = 16'h7000;
    LUT4 i1_2_lut_3_lut_4_lut_adj_121 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[1]), 
         .D(n_temp1_7__N_365), .Z(n_wb_dat_i[1])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_121.init = 16'h7000;
    LUT4 i1822_4_lut_4_lut (.A(clk_enable_184), .B(n_state_7__N_1056[4]), 
         .C(n_temp1_7__N_353), .D(n_temp1_7__N_354), .Z(n5506)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(862[7] 882[12])
    defparam i1822_4_lut_4_lut.init = 16'hfda0;
    LUT4 i1829_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(dat_rdy_N_1342), 
         .Z(dat_rdy_N_1340)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i1829_2_lut_3_lut.init = 16'h8080;
    LUT4 i3_4_lut_adj_122 (.A(n3_adj_1472), .B(n6_adj_1468), .C(n3852), 
         .D(n_temp1_7__N_359), .Z(n8787)) /* synthesis lut_function=(A+(B+(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i3_4_lut_adj_122.init = 16'hfeee;
    LUT4 i1841_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(reg_rdy_N_1338), 
         .Z(reg_rdy_N_1336)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i1841_2_lut_3_lut.init = 16'h8080;
    LUT4 i2_4_lut (.A(clk_enable_184), .B(n6957), .C(n9753), .D(wb_dat_o[2]), 
         .Z(n3_adj_1472)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i2_4_lut.init = 16'h8000;
    LUT4 i2_3_lut_4_lut_4_lut_adj_123 (.A(n15_adj_1436), .B(n6957), .C(wb_dat_o[2]), 
         .D(n_temp1_7__N_368), .Z(n9182)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;
    defparam i2_3_lut_4_lut_4_lut_adj_123.init = 16'h2000;
    LUT4 mux_1145_Mux_11_i6_3_lut_4_lut (.A(next_state_3__N_1108[2]), .B(n9760), 
         .C(next_state[1]), .D(next_state[0]), .Z(n6_adj_1459)) /* synthesis lut_function=(A (C (D))+!A (B (C (D))+!B (C (D)+!C !(D)))) */ ;
    defparam mux_1145_Mux_11_i6_3_lut_4_lut.init = 16'hf001;
    FD1P3IX counter_i0_i1 (.D(n3160), .SP(clk_enable_205), .CD(n6181), 
            .CK(clk), .Q(counter[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i1.GSR = "DISABLED";
    LUT4 i1_3_lut_4_lut_adj_124 (.A(n5927), .B(n9765), .C(reg_rdy_N_1338), 
         .D(n_temp1_7__N_366), .Z(n5_adj_1471)) /* synthesis lut_function=(A (B (D)+!B (C+(D)))+!A (C+(D))) */ ;
    defparam i1_3_lut_4_lut_adj_124.init = 16'hff70;
    LUT4 i2_3_lut_4_lut_adj_125 (.A(n9762), .B(clk_enable_184), .C(n4_adj_1464), 
         .D(reg_rdy_N_1338), .Z(n8653)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (C)) */ ;
    defparam i2_3_lut_4_lut_adj_125.init = 16'hf8f0;
    LUT4 i25_4_lut (.A(n_temp1_7__N_366), .B(n14_adj_1457), .C(clk_enable_184), 
         .D(n9241), .Z(n12_adj_1456)) /* synthesis lut_function=(A (((D)+!C)+!B)+!A (B (C (D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i25_4_lut.init = 16'hfa3a;
    FD1P3AX FPIO_isoCtrlRSTn_753 (.D(FPIO_isoCtrlRSTn_N_1306), .SP(clk_enable_191), 
            .CK(clk), .Q(FPIO_isoCtrlRSTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam FPIO_isoCtrlRSTn_753.GSR = "DISABLED";
    LUT4 i1879_3_lut_4_lut (.A(n_temp1_7__N_366), .B(n9784), .C(n9224), 
         .D(clk_enable_184), .Z(n_wb_adr_i[0])) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1879_3_lut_4_lut.init = 16'h00fe;
    LUT4 i5334_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_357), 
         .D(n_temp1_7__N_358), .Z(n9269)) /* synthesis lut_function=(A (B (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i5334_3_lut_4_lut.init = 16'h8880;
    LUT4 i19_4_lut (.A(n_temp1_7__N_365), .B(n1), .C(clk_enable_184), 
         .D(n9182), .Z(n8823)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i19_4_lut.init = 16'hfaca;
    LUT4 i1_2_lut_adj_126 (.A(wb_dat_o[4]), .B(n_temp1_7__N_363), .Z(n1)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_2_lut_adj_126.init = 16'h8888;
    LUT4 i5348_4_lut (.A(n9760), .B(externstop_falling), .C(next_state[3]), 
         .D(next_state[2]), .Z(n9283)) /* synthesis lut_function=(A (B+(D))+!A (B (C)+!B (C (D)))) */ ;
    defparam i5348_4_lut.init = 16'hfac8;
    CCU2D resetcounter_i24_1568_add_4_11 (.A0(resetcounter[9]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8514), .COUT(n8515), .S0(n121), 
          .S1(n120_adj_1451));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568_add_4_11.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_11.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_11.INJECT1_0 = "NO";
    defparam resetcounter_i24_1568_add_4_11.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_91 (.A(n8732), .B(n5824), .Z(n9756)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(444[12:28])
    defparam i1_2_lut_rep_91.init = 16'heeee;
    LUT4 i1_2_lut_3_lut_4_lut_adj_127 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[4]), 
         .D(n_temp1_7__N_365), .Z(n_wb_dat_i[4])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_127.init = 16'h7000;
    LUT4 RST_N_I_0_1_lut_rep_111 (.A(RST_N_c), .Z(n9776)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(488[10:21])
    defparam RST_N_I_0_1_lut_rep_111.init = 16'h5555;
    LUT4 i1_2_lut_adj_128 (.A(next_state_3__N_1108[2]), .B(signals_debounced_syn[3]), 
         .Z(n9170)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1374[17] 1384[12])
    defparam i1_2_lut_adj_128.init = 16'h8888;
    LUT4 mux_1429_i4_3_lut (.A(GPI_DAT[3]), .B(irq_status[3]), .C(temp1[5]), 
         .Z(n4662)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(542[6] 548[15])
    defparam mux_1429_i4_3_lut.init = 16'hcaca;
    CCU2D add_176_5 (.A0(\debounce_counters[2] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8446), .COUT(n8447), .S0(n309), 
          .S1(n308));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_5.INIT0 = 16'h5aaa;
    defparam add_176_5.INIT1 = 16'h5aaa;
    defparam add_176_5.INJECT1_0 = "NO";
    defparam add_176_5.INJECT1_1 = "NO";
    CCU2D add_185_23 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8471), .COUT(n8472), .S0(n397), 
          .S1(n396));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_23.INIT0 = 16'h5aaa;
    defparam add_185_23.INIT1 = 16'h5aaa;
    defparam add_185_23.INJECT1_0 = "NO";
    defparam add_185_23.INJECT1_1 = "NO";
    LUT4 i2_4_lut_adj_129 (.A(wb_dat_o[2]), .B(n4_adj_1474), .C(clk_enable_184), 
         .D(n3_adj_1449), .Z(n8665)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i2_4_lut_adj_129.init = 16'heccc;
    LUT4 i1_4_lut_adj_130 (.A(n7046), .B(dat_rdy_N_1342), .C(n9189), .D(clk_enable_184), 
         .Z(n4_adj_1474)) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_130.init = 16'ha0ec;
    LUT4 i2_2_lut (.A(counter[17]), .B(counter[22]), .Z(n27_adj_1455)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2_2_lut.init = 16'heeee;
    LUT4 i1_2_lut_adj_131 (.A(n_temp1_7__N_369), .B(n15_adj_1436), .Z(n3_adj_1449)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_2_lut_adj_131.init = 16'h8888;
    LUT4 i5440_2_lut (.A(irq_clr[3]), .B(RST_N_c), .Z(irq_status_clr[3])) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(667[30:51])
    defparam i5440_2_lut.init = 16'h4444;
    LUT4 i5416_3_lut_rep_87_4_lut (.A(next_state[1]), .B(n9788), .C(n9711), 
         .D(n9283), .Z(clk_enable_205)) /* synthesis lut_function=(A (C)+!A (B (C (D))+!B (C))) */ ;
    defparam i5416_3_lut_rep_87_4_lut.init = 16'hf0b0;
    LUT4 i1583_3_lut_4_lut_4_lut (.A(RST_N_c), .B(reg_rdy), .C(n9763), 
         .D(n9774), .Z(clk_enable_152)) /* synthesis lut_function=(!(A ((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(488[10:21])
    defparam i1583_3_lut_4_lut_4_lut.init = 16'h555d;
    LUT4 i1802_4_lut (.A(n_temp1_7__N_363), .B(n7046), .C(n3902), .D(n9189), 
         .Z(n5486)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1802_4_lut.init = 16'hb3a0;
    LUT4 i1778_4_lut (.A(n_temp1_7__N_369), .B(dat_rdy_N_1342), .C(n3965), 
         .D(n6972), .Z(n5462)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1778_4_lut.init = 16'heca0;
    LUT4 i1_4_lut_adj_132 (.A(n9301), .B(n_temp1_7__N_362), .C(n9175), 
         .D(n3884), .Z(n4_adj_1464)) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_132.init = 16'hdc50;
    LUT4 mux_1373_i25_4_lut (.A(n3137), .B(n9786), .C(n4643), .D(n5428), 
         .Z(n4569)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam mux_1373_i25_4_lut.init = 16'h303a;
    CCU2D resetcounter_i24_1568_add_4_9 (.A0(resetcounter[7]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8513), .COUT(n8514), .S0(n123), 
          .S1(n122_adj_1450));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568_add_4_9.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_9.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_9.INJECT1_0 = "NO";
    defparam resetcounter_i24_1568_add_4_9.INJECT1_1 = "NO";
    LUT4 i7_4_lut_adj_133 (.A(dat_count[0]), .B(n14_adj_1440), .C(n10), 
         .D(dat_count[6]), .Z(n15_adj_1436)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1245[13:35])
    defparam i7_4_lut_adj_133.init = 16'hfffe;
    LUT4 i1_4_lut_adj_134 (.A(n4316), .B(n10112), .C(n12_adj_1465), .D(n8), 
         .Z(n9224)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_134.init = 16'hfffe;
    LUT4 i5_4_lut (.A(n_temp1_7__N_367), .B(n_temp1_7__N_354), .C(n_temp1_7__N_357), 
         .D(n_temp1_7__N_368), .Z(n12_adj_1465)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i5_4_lut.init = 16'hfffe;
    LUT4 i6_4_lut_adj_135 (.A(dat_count[3]), .B(dat_count[1]), .C(dat_count[5]), 
         .D(dat_count[7]), .Z(n14_adj_1440)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1245[13:35])
    defparam i6_4_lut_adj_135.init = 16'hfffe;
    CCU2D add_185_21 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8470), .COUT(n8471), .S0(n399), 
          .S1(n398));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_21.INIT0 = 16'h5aaa;
    defparam add_185_21.INIT1 = 16'h5aaa;
    defparam add_185_21.INJECT1_0 = "NO";
    defparam add_185_21.INJECT1_1 = "NO";
    LUT4 i1_2_lut_adj_136 (.A(n_temp1_7__N_369), .B(n_temp1_7__N_363), .Z(n8)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_2_lut_adj_136.init = 16'heeee;
    LUT4 i2_2_lut_adj_137 (.A(dat_count[2]), .B(dat_count[4]), .Z(n10)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1245[13:35])
    defparam i2_2_lut_adj_137.init = 16'heeee;
    LUT4 i1808_4_lut (.A(n_temp1_7__N_360), .B(n9175), .C(n3884), .D(n9267), 
         .Z(n5492)) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1808_4_lut.init = 16'ha0ec;
    LUT4 i3_4_lut_adj_138 (.A(n_temp1_7__N_358), .B(n_temp1_7__N_355), .C(n_temp1_7__N_356), 
         .D(n9785), .Z(n4316)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i3_4_lut_adj_138.init = 16'hfffe;
    LUT4 i1593_4_lut_4_lut (.A(RST_N_c), .B(reg_rdy_del), .C(n9765), .D(n5927), 
         .Z(clk_enable_145)) /* synthesis lut_function=(!(A ((C+!(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(488[10:21])
    defparam i1593_4_lut_4_lut.init = 16'h5d55;
    LUT4 i2_3_lut (.A(n9142), .B(S3CsI2C_SDA), .C(S3CsI2C_SCL), .Z(dummy_signal)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i2_3_lut.init = 16'h8080;
    LUT4 i61_4_lut (.A(n117), .B(n122), .C(n111), .D(n112), .Z(n9142)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i61_4_lut.init = 16'h8000;
    LUT4 i2_4_lut_adj_139 (.A(dat_count[0]), .B(n12_adj_1447), .C(n17), 
         .D(n15_adj_1446), .Z(n_dat_count[0])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i2_4_lut_adj_139.init = 16'hffec;
    LUT4 i55_4_lut (.A(FlexLIO_c_2), .B(n110), .C(n94), .D(PG_VIN_c), 
         .Z(n117)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i55_4_lut.init = 16'h8000;
    LUT4 i1_4_lut_adj_140 (.A(n_temp1_7__N_365), .B(dat_count[0]), .C(n2088), 
         .D(n9757), .Z(n12_adj_1447)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_140.init = 16'ha088;
    LUT4 i11_4_lut (.A(n_temp1_7__N_355), .B(n_temp1_7__N_354), .C(clk_enable_184), 
         .D(n_state_7__N_1056[4]), .Z(n9069)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i11_4_lut.init = 16'h0aca;
    LUT4 mux_1373_i24_4_lut (.A(n3138), .B(n9786), .C(n4643), .D(n5428), 
         .Z(n4570)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam mux_1373_i24_4_lut.init = 16'h303a;
    LUT4 i21_4_lut (.A(counter[11]), .B(n42), .C(n32_adj_1431), .D(counter[20]), 
         .Z(n46)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i21_4_lut.init = 16'hfffe;
    LUT4 i60_4_lut (.A(n101), .B(n120), .C(n114), .D(n102), .Z(n122)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i60_4_lut.init = 16'h8000;
    LUT4 i1_4_lut_adj_141 (.A(dat_rdy_N_1342), .B(dat_count[0]), .C(n2088), 
         .D(n6972), .Z(n15_adj_1446)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_141.init = 16'ha088;
    CCU2D add_176_3 (.A0(\debounce_counters[2] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8445), .COUT(n8446), .S0(n311), 
          .S1(n310));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_3.INIT0 = 16'h5aaa;
    defparam add_176_3.INIT1 = 16'h5aaa;
    defparam add_176_3.INJECT1_0 = "NO";
    defparam add_176_3.INJECT1_1 = "NO";
    CCU2D add_176_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[2] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n8445), .S1(n312));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_176_1.INIT0 = 16'hF000;
    defparam add_176_1.INIT1 = 16'h5555;
    defparam add_176_1.INJECT1_0 = "NO";
    defparam add_176_1.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1568_add_4_7 (.A0(resetcounter[5]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8512), .COUT(n8513), .S0(n125), 
          .S1(n124));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568_add_4_7.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_7.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_7.INJECT1_0 = "NO";
    defparam resetcounter_i24_1568_add_4_7.INJECT1_1 = "NO";
    LUT4 irq_clr_3__I_0_i1_2_lut_2_lut (.A(RST_N_c), .B(irq_clr[0]), .Z(irq_status_clr[0])) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(488[10:21])
    defparam irq_clr_3__I_0_i1_2_lut_2_lut.init = 16'hdddd;
    CCU2D add_185_19 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8469), .COUT(n8470), .S0(n401), 
          .S1(n400));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_19.INIT0 = 16'h5aaa;
    defparam add_185_19.INIT1 = 16'h5aaa;
    defparam add_185_19.INJECT1_0 = "NO";
    defparam add_185_19.INJECT1_1 = "NO";
    LUT4 i32_4_lut (.A(n_temp1_7__N_353), .B(n_temp1_7__N_352), .C(clk_enable_184), 
         .D(n12_adj_1444), .Z(n8781)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i32_4_lut.init = 16'hfaca;
    LUT4 mux_1373_i23_4_lut (.A(n3139), .B(n9786), .C(n4643), .D(n5428), 
         .Z(n4571)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam mux_1373_i23_4_lut.init = 16'h303a;
    CCU2D add_185_17 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8468), .COUT(n8469), .S0(n403), 
          .S1(n402));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_17.INIT0 = 16'h5aaa;
    defparam add_185_17.INIT1 = 16'h5aaa;
    defparam add_185_17.INJECT1_0 = "NO";
    defparam add_185_17.INJECT1_1 = "NO";
    FD1P3IX irq_en__i2 (.D(temp2[2]), .SP(clk_enable_193), .CD(n9776), 
            .CK(clk), .Q(irq_en[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(686[1] 697[10])
    defparam irq_en__i2.GSR = "DISABLED";
    FD1P3IX irq_en__i3 (.D(temp2[3]), .SP(clk_enable_193), .CD(n9776), 
            .CK(clk), .Q(irq_en[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(686[1] 697[10])
    defparam irq_en__i3.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i1 (.D(n129), .CK(clk), .Q(resetcounter[1])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i1.GSR = "DISABLED";
    LUT4 i1_4_lut_adj_142 (.A(n_state_7__N_1056[4]), .B(wb_dat_o[2]), .C(n4), 
         .D(n9801), .Z(n12_adj_1444)) /* synthesis lut_function=(!(A+!(B (C)+!B (C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_142.init = 16'h5150;
    CCU2D resetcounter_i24_1568_add_4_5 (.A0(resetcounter[3]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8511), .COUT(n8512), .S0(n127), 
          .S1(n126));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568_add_4_5.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_5.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_5.INJECT1_0 = "NO";
    defparam resetcounter_i24_1568_add_4_5.INJECT1_1 = "NO";
    LUT4 i1_3_lut (.A(wb_dat_o[4]), .B(n_temp1_7__N_367), .C(n_temp1_7__N_363), 
         .Z(n4)) /* synthesis lut_function=(A (B)+!A (B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_3_lut.init = 16'hdcdc;
    LUT4 i49_4_lut (.A(FlexMIOs33_out), .B(n98), .C(n70), .D(FlexMIOs35_out), 
         .Z(n111)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i49_4_lut.init = 16'h8000;
    LUT4 i50_4_lut (.A(DIGS3C_SlotD_SlotOK_c_3), .B(n100), .C(n74), .D(DIG5S3C01_out), 
         .Z(n112)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i50_4_lut.init = 16'h8000;
    LUT4 temp1_0__bdd_2_lut_5584 (.A(temp1[0]), .B(irq_en[2]), .Z(n9687)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam temp1_0__bdd_2_lut_5584.init = 16'h4444;
    CCU2D resetcounter_i24_1568_add_4_3 (.A0(resetcounter[1]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8510), .COUT(n8511), .S0(n129), 
          .S1(n128));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568_add_4_3.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_3.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1568_add_4_3.INJECT1_0 = "NO";
    defparam resetcounter_i24_1568_add_4_3.INJECT1_1 = "NO";
    CCU2D add_167_33 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8444), .S0(n175));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_33.INIT0 = 16'h5aaa;
    defparam add_167_33.INIT1 = 16'h0000;
    defparam add_167_33.INJECT1_0 = "NO";
    defparam add_167_33.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i2 (.D(n3159), .SP(clk_enable_205), .CD(n6181), 
            .CK(clk), .Q(counter[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i2.GSR = "DISABLED";
    LUT4 i5420_4_lut (.A(next_state[0]), .B(n9760), .C(next_state[2]), 
         .D(next_state[1]), .Z(clk_enable_186)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam i5420_4_lut.init = 16'h2000;
    CCU2D resetcounter_i24_1568_add_4_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n7179), .B1(n8585), .C1(resetcounter[0]), 
          .D1(GND_net), .COUT(n8510), .S1(n130));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568_add_4_1.INIT0 = 16'hF000;
    defparam resetcounter_i24_1568_add_4_1.INIT1 = 16'h8787;
    defparam resetcounter_i24_1568_add_4_1.INJECT1_0 = "NO";
    defparam resetcounter_i24_1568_add_4_1.INJECT1_1 = "NO";
    CCU2D add_185_15 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8467), .COUT(n8468), .S0(n405), 
          .S1(n404));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_15.INIT0 = 16'h5aaa;
    defparam add_185_15.INIT1 = 16'h5aaa;
    defparam add_185_15.INJECT1_0 = "NO";
    defparam add_185_15.INJECT1_1 = "NO";
    CCU2D add_185_13 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8466), .COUT(n8467), .S0(n407), 
          .S1(n406));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_13.INIT0 = 16'h5aaa;
    defparam add_185_13.INIT1 = 16'h5aaa;
    defparam add_185_13.INJECT1_0 = "NO";
    defparam add_185_13.INJECT1_1 = "NO";
    LUT4 i2_3_lut_4_lut_adj_143 (.A(temp1[2]), .B(temp1[3]), .C(temp1[0]), 
         .D(n9766), .Z(n6949)) /* synthesis lut_function=((B+(C+(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(543[13:23])
    defparam i2_3_lut_4_lut_adj_143.init = 16'hfffd;
    LUT4 i48_4_lut (.A(TDnALERT_c), .B(n96), .C(n66), .D(TDnFFnFS_c), 
         .Z(n110)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i48_4_lut.init = 16'h8000;
    PFUMX i5492 (.BLUT(n9519), .ALUT(n9771), .C0(next_state[1]), .Z(n9520));
    CCU2D add_849_9 (.A0(dat_count[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n8509), 
          .S0(n2081));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_849_9.INIT0 = 16'h5555;
    defparam add_849_9.INIT1 = 16'h0000;
    defparam add_849_9.INJECT1_0 = "NO";
    defparam add_849_9.INJECT1_1 = "NO";
    FD1P3AX FP_SysLEDr_747 (.D(FP_SysLEDr_N_1304), .SP(clk_enable_195), 
            .CK(clk), .Q(FP_SysLEDr_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam FP_SysLEDr_747.GSR = "DISABLED";
    CCU2D add_849_7 (.A0(dat_count[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8508), .COUT(n8509), .S0(n2083), .S1(n2082));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_849_7.INIT0 = 16'h5555;
    defparam add_849_7.INIT1 = 16'h5555;
    defparam add_849_7.INJECT1_0 = "NO";
    defparam add_849_7.INJECT1_1 = "NO";
    LUT4 i32_4_lut_adj_144 (.A(TDnSHDN_c), .B(FlexMIOs37_out), .C(FlexLIO_c_1), 
         .D(SD0_CD_c), .Z(n94)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i32_4_lut_adj_144.init = 16'h8000;
    FD1P3IX counter_i0_i3 (.D(n3158), .SP(clk_enable_205), .CD(n6181), 
            .CK(clk), .Q(counter[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i3.GSR = "DISABLED";
    FD1P3IX counter_i0_i4 (.D(n3157), .SP(clk_enable_205), .CD(n6181), 
            .CK(clk), .Q(counter[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i4.GSR = "DISABLED";
    CCU2D add_185_11 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8465), .COUT(n8466), .S0(n409), 
          .S1(n408));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_11.INIT0 = 16'h5aaa;
    defparam add_185_11.INIT1 = 16'h5aaa;
    defparam add_185_11.INJECT1_0 = "NO";
    defparam add_185_11.INJECT1_1 = "NO";
    LUT4 FPIO_isoCtrlRSTn_N_1424_bdd_4_lut_4_lut (.A(n9760), .B(next_state_3__N_1108[2]), 
         .C(next_state[0]), .D(externstop_falling), .Z(n9519)) /* synthesis lut_function=(!(A ((C+!(D))+!B)+!A !(B (C+(D))+!B (C)))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1424_bdd_4_lut_4_lut.init = 16'h5c50;
    CCU2D add_849_5 (.A0(dat_count[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8507), .COUT(n8508), .S0(n2085), .S1(n2084));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_849_5.INIT0 = 16'h5555;
    defparam add_849_5.INIT1 = 16'h5555;
    defparam add_849_5.INJECT1_0 = "NO";
    defparam add_849_5.INJECT1_1 = "NO";
    CCU2D add_849_3 (.A0(dat_count[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8506), .COUT(n8507), .S0(n2087), .S1(n2086));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_849_3.INIT0 = 16'h5555;
    defparam add_849_3.INIT1 = 16'h5555;
    defparam add_849_3.INJECT1_0 = "NO";
    defparam add_849_3.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i5 (.D(n3156), .SP(clk_enable_205), .CD(n6181), 
            .CK(clk), .Q(counter[5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i5.GSR = "DISABLED";
    CCU2D add_185_9 (.A0(\debounce_counters[3] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8464), .COUT(n8465), .S0(n411), 
          .S1(n410));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_9.INIT0 = 16'h5aaa;
    defparam add_185_9.INIT1 = 16'h5aaa;
    defparam add_185_9.INJECT1_0 = "NO";
    defparam add_185_9.INJECT1_1 = "NO";
    LUT4 select_1283_Select_7_i11_3_lut_4_lut_4_lut (.A(n_temp1_7__N_352), 
         .B(clk_enable_184), .C(data0[7]), .D(n_temp1_7__N_365), .Z(n_wb_dat_i[7])) /* synthesis lut_function=(!(A (B)+!A (B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam select_1283_Select_7_i11_3_lut_4_lut_4_lut.init = 16'h3222;
    CCU2D add_167_31 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8443), .COUT(n8444), .S0(n177), 
          .S1(n176));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_167_31.INIT0 = 16'h5aaa;
    defparam add_167_31.INIT1 = 16'h5aaa;
    defparam add_167_31.INJECT1_0 = "NO";
    defparam add_167_31.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i6 (.D(n4553), .SP(clk_enable_205), .CD(n6174), 
            .CK(clk), .Q(counter[6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i6.GSR = "DISABLED";
    LUT4 i1_4_lut_adj_145 (.A(next_state[2]), .B(next_state[3]), .C(n29), 
         .D(n35), .Z(n4641)) /* synthesis lut_function=(!(A (B+!(D))+!A !(B (C)+!B (C+(D))))) */ ;
    defparam i1_4_lut_adj_145.init = 16'h7350;
    LUT4 i34_4_lut (.A(FP_UsrSW2_c), .B(FlexLIO_c_0), .C(FlexIO04_c), 
         .D(FlexMIOs29_out), .Z(n96)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i34_4_lut.init = 16'h8000;
    LUT4 i38_4_lut_adj_146 (.A(next_state[3]), .B(n9158), .C(next_state[2]), 
         .D(n25), .Z(clk_enable_204)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B (C)))) */ ;
    defparam i38_4_lut_adj_146.init = 16'h353f;
    CCU2D add_185_7 (.A0(\debounce_counters[3] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8463), .COUT(n8464), .S0(n413), 
          .S1(n412));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(413[49:69])
    defparam add_185_7.INIT0 = 16'h5aaa;
    defparam add_185_7.INIT1 = 16'h5aaa;
    defparam add_185_7.INJECT1_0 = "NO";
    defparam add_185_7.INJECT1_1 = "NO";
    LUT4 i4_2_lut (.A(DIG5S3C05_out), .B(FPIO_FlexMIO28_out), .Z(n66)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i4_2_lut.init = 16'h8888;
    LUT4 i15_4_lut (.A(counter[15]), .B(counter[3]), .C(counter[1]), .D(counter[24]), 
         .Z(n40)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i15_4_lut.init = 16'hfffe;
    LUT4 i7_2_lut (.A(counter[16]), .B(counter[21]), .Z(n32_adj_1431)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i7_2_lut.init = 16'heeee;
    LUT4 i42_4_lut (.A(ANL_S3C_SLOTOK_c_2), .B(DIGS3C_SlotD_SlotOK_c_2), 
         .C(DIGS3C_SlotD_SlotOK_c_1), .D(DIGS3C_SlotD_SlotOK_c_5), .Z(n104)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i42_4_lut.init = 16'h8000;
    LUT4 i3_2_lut (.A(counter[23]), .B(counter[4]), .Z(n28_adj_1476)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i3_2_lut.init = 16'heeee;
    FD1P3IX counter_i0_i7 (.D(n3154), .SP(clk_enable_205), .CD(n6181), 
            .CK(clk), .Q(counter[7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i7.GSR = "DISABLED";
    CCU2D add_4634_26 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8570), .S1(clk_enable_155));
    defparam add_4634_26.INIT0 = 16'hf555;
    defparam add_4634_26.INIT1 = 16'h0000;
    defparam add_4634_26.INJECT1_0 = "NO";
    defparam add_4634_26.INJECT1_1 = "NO";
    LUT4 i17_4_lut (.A(counter[2]), .B(counter[13]), .C(counter[9]), .D(counter[18]), 
         .Z(n42)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i17_4_lut.init = 16'hfffe;
    FD1P3IX counter_i0_i10 (.D(n4549), .SP(clk_enable_205), .CD(n6174), 
            .CK(clk), .Q(counter[10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i10.GSR = "DISABLED";
    CCU2D add_4634_24 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8569), .COUT(n8570));
    defparam add_4634_24.INIT0 = 16'h5555;
    defparam add_4634_24.INIT1 = 16'h5555;
    defparam add_4634_24.INJECT1_0 = "NO";
    defparam add_4634_24.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i11 (.D(n4548), .SP(clk_enable_205), .CD(n6174), 
            .CK(clk), .Q(counter[11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i11.GSR = "DISABLED";
    CCU2D add_4634_22 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8568), .COUT(n8569));
    defparam add_4634_22.INIT0 = 16'h5555;
    defparam add_4634_22.INIT1 = 16'h5555;
    defparam add_4634_22.INJECT1_0 = "NO";
    defparam add_4634_22.INJECT1_1 = "NO";
    FD1P3AX FlexMIOs53_GPIO_PowerDown_746 (.D(FlexMIOs53_GPIO_PowerDown_N_1320), 
            .SP(clk_enable_203), .CK(clk), .Q(FlexMIOs53_GPIO_PowerDown_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam FlexMIOs53_GPIO_PowerDown_746.GSR = "DISABLED";
    LUT4 i1_2_lut_3_lut_4_lut_adj_147 (.A(next_state_3__N_1108[2]), .B(signals_debounced_syn[3]), 
         .C(next_state[2]), .D(externstop_falling), .Z(n9172)) /* synthesis lut_function=(!(A+(((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1374[17] 1384[12])
    defparam i1_2_lut_3_lut_4_lut_adj_147.init = 16'h0040;
    CCU2D add_4634_20 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8567), .COUT(n8568));
    defparam add_4634_20.INIT0 = 16'h5555;
    defparam add_4634_20.INIT1 = 16'h5555;
    defparam add_4634_20.INJECT1_0 = "NO";
    defparam add_4634_20.INJECT1_1 = "NO";
    CCU2D add_849_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n8506), .S1(n2088));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_849_1.INIT0 = 16'hF000;
    defparam add_849_1.INIT1 = 16'h5555;
    defparam add_849_1.INJECT1_0 = "NO";
    defparam add_849_1.INJECT1_1 = "NO";
    LUT4 i39_4_lut (.A(FPIO_iosCtrlINTn_c), .B(FlexLIO_c_5), .C(FlexIO03_c), 
         .D(FlexMIOs27_out), .Z(n101)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i39_4_lut.init = 16'h8000;
    LUT4 i3_4_lut_adj_148 (.A(temp1[2]), .B(temp1[1]), .C(temp1[0]), .D(n5385), 
         .Z(n8619)) /* synthesis lut_function=(!((B+((D)+!C))+!A)) */ ;
    defparam i3_4_lut_adj_148.init = 16'h0020;
    LUT4 i1_3_lut_4_lut_else_3_lut_4_lut (.A(n_temp1_7__N_362), .B(n_temp1_7__N_360), 
         .C(n_temp1_7__N_369), .D(n15_adj_1436), .Z(n9799)) /* synthesis lut_function=(A+(B+(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_3_lut_4_lut_else_3_lut_4_lut.init = 16'hfeee;
    FD1S3AX resetcounter_i24_1568__i2 (.D(n128), .CK(clk), .Q(resetcounter[2])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i2.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i3 (.D(n127), .CK(clk), .Q(resetcounter[3])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i3.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i4 (.D(n126), .CK(clk), .Q(resetcounter[4])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i4.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i5 (.D(n125), .CK(clk), .Q(resetcounter[5])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i5.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i6 (.D(n124), .CK(clk), .Q(resetcounter[6])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i6.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i7 (.D(n123), .CK(clk), .Q(resetcounter[7])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i7.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i8 (.D(n122_adj_1450), .CK(clk), .Q(resetcounter[8])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i8.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i9 (.D(n121), .CK(clk), .Q(resetcounter[9])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i9.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i10 (.D(n120_adj_1451), .CK(clk), .Q(resetcounter[10])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i10.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i11 (.D(n119), .CK(clk), .Q(resetcounter[11])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i11.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i12 (.D(n118), .CK(clk), .Q(resetcounter[12])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i12.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i13 (.D(n117_adj_1452), .CK(clk), .Q(resetcounter[13])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i13.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i14 (.D(n116_adj_1453), .CK(clk), .Q(resetcounter[14])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i14.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i15 (.D(n115), .CK(clk), .Q(resetcounter[15])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i15.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i16 (.D(n114_adj_1454), .CK(clk), .Q(resetcounter[16])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i16.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i17 (.D(n113), .CK(clk), .Q(resetcounter[17])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i17.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i18 (.D(n112_adj_1458), .CK(clk), .Q(resetcounter[18])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i18.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i19 (.D(n111_adj_1460), .CK(clk), .Q(resetcounter[19])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i19.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i20 (.D(n110_adj_1461), .CK(clk), .Q(resetcounter[20])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i20.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i21 (.D(n109), .CK(clk), .Q(resetcounter[21])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i21.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i22 (.D(n108_adj_1462), .CK(clk), .Q(resetcounter[22])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i22.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i23 (.D(n107), .CK(clk), .Q(resetcounter[23])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i23.GSR = "DISABLED";
    FD1S3AX resetcounter_i24_1568__i24 (.D(n106_adj_1463), .CK(clk), .Q(resetcounter[24])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(466[20:32])
    defparam resetcounter_i24_1568__i24.GSR = "DISABLED";
    LUT4 next_state_3__bdd_4_lut_5668 (.A(next_state[3]), .B(next_state[2]), 
         .C(next_state[1]), .D(next_state[0]), .Z(clk_enable_29)) /* synthesis lut_function=(A (B+(C (D)+!C !(D)))+!A (B (C+(D)))) */ ;
    defparam next_state_3__bdd_4_lut_5668.init = 16'hecca;
    LUT4 i5424_2_lut_3_lut (.A(next_state_3__N_1108[2]), .B(signals_debounced_syn[3]), 
         .C(externstop_falling), .Z(n7011)) /* synthesis lut_function=(!(A (C)+!A (B+(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1374[17] 1384[12])
    defparam i5424_2_lut_3_lut.init = 16'h0b0b;
    GSR GSR_INST (.GSR(irq_status_clr[3]));
    FD1P3AX next_state_i0 (.D(next_state_3__N_69[0]), .SP(clk_enable_204), 
            .CK(clk), .Q(next_state[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam next_state_i0.GSR = "DISABLED";
    FD1P3IX counter_i0_i0 (.D(n3161), .SP(clk_enable_205), .CD(n6181), 
            .CK(clk), .Q(counter[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1306[2] 1484[9])
    defparam counter_i0_i0.GSR = "DISABLED";
    LUT4 i58_4_lut (.A(n9760), .B(n5039), .C(next_state[3]), .D(next_state[1]), 
         .Z(n29)) /* synthesis lut_function=(!(A (B (C+!(D))+!B (C (D)+!C !(D)))+!A (B+((D)+!C)))) */ ;
    defparam i58_4_lut.init = 16'h0a30;
    LUT4 i58_4_lut_adj_149 (.A(n85), .B(n116), .C(n106), .D(n86), .Z(n120)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i58_4_lut_adj_149.init = 16'h8000;
    LUT4 i1_2_lut_rep_103_3_lut (.A(next_state_3__N_1108[2]), .B(signals_debounced_syn[3]), 
         .C(externstop_falling), .Z(n9768)) /* synthesis lut_function=(!(A+((C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1374[17] 1384[12])
    defparam i1_2_lut_rep_103_3_lut.init = 16'h0404;
    LUT4 i1_4_lut_4_lut_adj_150 (.A(next_state[2]), .B(next_state[0]), .C(next_state[1]), 
         .D(n9760), .Z(n33)) /* synthesis lut_function=(A (B (C (D))+!B !(C+!(D)))+!A (B (C (D)))) */ ;
    defparam i1_4_lut_4_lut_adj_150.init = 16'hc200;
    CCU2D add_4634_18 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8566), .COUT(n8567));
    defparam add_4634_18.INIT0 = 16'h5555;
    defparam add_4634_18.INIT1 = 16'h5555;
    defparam add_4634_18.INJECT1_0 = "NO";
    defparam add_4634_18.INJECT1_1 = "NO";
    CCU2D add_4634_16 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8565), .COUT(n8566));
    defparam add_4634_16.INIT0 = 16'h5555;
    defparam add_4634_16.INIT1 = 16'h5555;
    defparam add_4634_16.INJECT1_0 = "NO";
    defparam add_4634_16.INJECT1_1 = "NO";
    CCU2D add_4634_14 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8564), .COUT(n8565));
    defparam add_4634_14.INIT0 = 16'h5555;
    defparam add_4634_14.INIT1 = 16'h5555;
    defparam add_4634_14.INJECT1_0 = "NO";
    defparam add_4634_14.INJECT1_1 = "NO";
    CCU2D add_4634_12 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8563), .COUT(n8564));
    defparam add_4634_12.INIT0 = 16'h5555;
    defparam add_4634_12.INIT1 = 16'h5555;
    defparam add_4634_12.INJECT1_0 = "NO";
    defparam add_4634_12.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_151 (.A(next_state[0]), .B(n33), .C(n9172), .D(next_state[1]), 
         .Z(n35)) /* synthesis lut_function=(A (B+!((D)+!C))+!A (B+(C (D)))) */ ;
    defparam i1_4_lut_adj_151.init = 16'hdcec;
    LUT4 i60_3_lut (.A(next_state_3__N_1108[2]), .B(n9760), .C(next_state[0]), 
         .Z(n5039)) /* synthesis lut_function=(!(A (B (C))+!A (B+!(C)))) */ ;
    defparam i60_3_lut.init = 16'h3a3a;
    LUT4 i5443_2_lut_rep_106 (.A(next_state[0]), .B(next_state_3__N_1108[2]), 
         .Z(n9771)) /* synthesis lut_function=(!(A+(B))) */ ;
    defparam i5443_2_lut_rep_106.init = 16'h1111;
    LUT4 i52_4_lut (.A(FlexMIOs54_out), .B(n104), .C(n82), .D(FlexMIOs62_out), 
         .Z(n114)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i52_4_lut.init = 16'h8000;
    LUT4 i5429_4_lut (.A(n28), .B(n32), .C(next_state[3]), .D(next_state[1]), 
         .Z(clk_enable_189)) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A (B))) */ ;
    defparam i5429_4_lut.init = 16'h3331;
    LUT4 i52_4_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_1108[2]), 
         .C(next_state[2]), .D(n9760), .Z(n28)) /* synthesis lut_function=(!(A ((C)+!B)+!A (B (C)+!B !(C (D))))) */ ;
    defparam i52_4_lut_4_lut.init = 16'h1c0c;
    LUT4 n5895_bdd_3_lut_5524_4_lut (.A(next_state[0]), .B(next_state_3__N_1108[2]), 
         .C(next_state[2]), .D(next_state[1]), .Z(n9490)) /* synthesis lut_function=(!(A+(B+(C+(D))))) */ ;
    defparam n5895_bdd_3_lut_5524_4_lut.init = 16'h0001;
    LUT4 i40_4_lut (.A(FlexMIOs28_out), .B(FlexMIOs32_out), .C(FlexMIOs31_out), 
         .D(FlexMIOs34_out), .Z(n102)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i40_4_lut.init = 16'h8000;
    LUT4 i23_2_lut (.A(DIG5S3C00_out), .B(DIG5S3C02_out), .Z(n85)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i23_2_lut.init = 16'h8888;
    LUT4 i54_4_lut (.A(FlexMIOs26_out), .B(n108), .C(n90), .D(FlexMIOs30_out), 
         .Z(n116)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i54_4_lut.init = 16'h8000;
    PFUMX i5479 (.BLUT(n9501), .ALUT(n9500), .C0(next_state[0]), .Z(clk_enable_195));
    LUT4 i1_4_lut_4_lut_adj_152 (.A(next_state[0]), .B(next_state_3__N_1108[2]), 
         .C(next_state[1]), .D(n9754), .Z(n9158)) /* synthesis lut_function=(A (C (D))+!A !(B+(C+!(D)))) */ ;
    defparam i1_4_lut_4_lut_adj_152.init = 16'ha100;
    LUT4 n10103_bdd_3_lut_4_lut (.A(next_state[0]), .B(next_state[1]), .C(next_state[2]), 
         .D(n10102), .Z(n10104)) /* synthesis lut_function=(A (B ((D)+!C)+!B (C (D)))+!A (C (D))) */ ;
    defparam n10103_bdd_3_lut_4_lut.init = 16'hf808;
    LUT4 i44_4_lut (.A(DIG5S3C28_out), .B(FlexLIO_c_3), .C(FPIO_FlexMIO29_out), 
         .D(FlexLIO_c_4), .Z(n106)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i44_4_lut.init = 16'h8000;
    LUT4 i24_2_lut (.A(DIG5S3C25_out), .B(DIG5S3C26_out), .Z(n86)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i24_2_lut.init = 16'h8888;
    LUT4 i46_4_lut (.A(ANL_S3C_SLOTOK_c_1), .B(DIGS3C_SlotD_SlotOK_c_4), 
         .C(ANL_S3C_SLOTOK_c_3), .D(DIG5S3C24_out), .Z(n108)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i46_4_lut.init = 16'h8000;
    LUT4 i28_2_lut (.A(FlexMIOs45_c), .B(ANL_S3C_P54_Legacy_c), .Z(n90)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i28_2_lut.init = 16'h8888;
    LUT4 i3465_4_lut (.A(n5), .B(resetcounter[21]), .C(resetcounter[18]), 
         .D(resetcounter[19]), .Z(n7179)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;
    defparam i3465_4_lut.init = 16'heccc;
    LUT4 i1_4_lut_adj_153 (.A(n9232), .B(resetcounter[20]), .C(n9129), 
         .D(resetcounter[12]), .Z(n5)) /* synthesis lut_function=(A (B (C+(D)))+!A (B (C))) */ ;
    defparam i1_4_lut_adj_153.init = 16'hc8c0;
    LUT4 i2_3_lut_adj_154 (.A(resetcounter[23]), .B(resetcounter[24]), .C(resetcounter[22]), 
         .Z(n8585)) /* synthesis lut_function=(A (B (C))) */ ;
    defparam i2_3_lut_adj_154.init = 16'h8080;
    PFUMX i5472 (.BLUT(n9491), .ALUT(n9490), .C0(next_state[3]), .Z(n4637));
    LUT4 i1_2_lut_rep_107 (.A(temp1[4]), .B(temp1[7]), .Z(n9772)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_rep_107.init = 16'heeee;
    LUT4 i2_3_lut_rep_101_4_lut (.A(temp1[4]), .B(temp1[7]), .C(temp1[5]), 
         .D(temp1[6]), .Z(n9766)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i2_3_lut_rep_101_4_lut.init = 16'hfffe;
    LUT4 mux_1364_i7_4_lut (.A(next_state[1]), .B(n3155), .C(n4641), .D(n4637), 
         .Z(n4553)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam mux_1364_i7_4_lut.init = 16'h0aca;
    LUT4 i3238_3_lut (.A(n3151), .B(n4641), .C(n4637), .Z(n4549)) /* synthesis lut_function=(!(A (B (C))+!A (B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam i3238_3_lut.init = 16'h3b3b;
    LUT4 i2_3_lut_4_lut_adj_155 (.A(temp1[4]), .B(temp1[7]), .C(temp1[5]), 
         .D(temp1[6]), .Z(n14_adj_1470)) /* synthesis lut_function=(A+(B+!(C (D)))) */ ;
    defparam i2_3_lut_4_lut_adj_155.init = 16'hefff;
    LUT4 i1_2_lut_rep_96_3_lut_4_lut (.A(temp1[0]), .B(temp1[1]), .C(temp1[3]), 
         .D(n9766), .Z(n9761)) /* synthesis lut_function=((B+(C+(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(543[13:23])
    defparam i1_2_lut_rep_96_3_lut_4_lut.init = 16'hfffd;
    LUT4 i8_2_lut (.A(FlexMIOs36_out), .B(FlexMIOs63_out), .Z(n70)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i8_2_lut.init = 16'h8888;
    LUT4 i36_4_lut (.A(S3C_S1_c), .B(SDA_c), .C(SCL_c), .D(SPI_S3C_nCS_USR_c), 
         .Z(n98)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i36_4_lut.init = 16'h8000;
    LUT4 i20_2_lut (.A(PG_Module_c), .B(SD1_CD_c), .Z(n82)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(366[17] 377[58])
    defparam i20_2_lut.init = 16'h8888;
    PFUMX i5470 (.BLUT(n9488), .ALUT(n9771), .C0(next_state[1]), .Z(n9489));
    LUT4 i3372_2_lut (.A(n3140), .B(n4637), .Z(n4472)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam i3372_2_lut.init = 16'heeee;
    LUT4 i5332_2_lut_4_lut (.A(n9761), .B(n9762), .C(n6957), .D(n9301), 
         .Z(n9267)) /* synthesis lut_function=(A (B (C+!(D))+!B !(D))+!A !(D)) */ ;
    defparam i5332_2_lut_4_lut.init = 16'h80ff;
    LUT4 equal_266_i9_2_lut_rep_108 (.A(temp1[0]), .B(temp1[1]), .Z(n9773)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(543[13:23])
    defparam equal_266_i9_2_lut_rep_108.init = 16'hdddd;
    LUT4 i2_3_lut_4_lut_adj_156 (.A(n9774), .B(n9763), .C(n5916), .D(n9301), 
         .Z(n7046)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(725[58:76])
    defparam i2_3_lut_4_lut_adj_156.init = 16'he000;
    PFUMX i5782 (.BLUT(n10104), .ALUT(n10099), .C0(next_state[3]), .Z(next_state_3__N_69[2]));
    LUT4 i2_3_lut_rep_100_4_lut (.A(temp1[0]), .B(temp1[1]), .C(n14_adj_1470), 
         .D(n10_adj_1443), .Z(n9765)) /* synthesis lut_function=((B+(C+(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(543[13:23])
    defparam i2_3_lut_rep_100_4_lut.init = 16'hfffd;
    TSALL TSALL_INST (.TSALL(GND_net));
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    LUT4 i1577_2_lut (.A(clk_enable_154), .B(debounce_inputs_asyn2[3]), 
         .Z(clk_enable_183)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i1577_2_lut.init = 16'hdddd;
    PFUMX mux_1145_Mux_8_i15 (.BLUT(n7), .ALUT(n14_adj_1448), .C0(next_state[3]), 
          .Z(FP_SysLEDb_N_1305));
    PFUMX i5780 (.BLUT(n10101), .ALUT(n10100), .C0(next_state[0]), .Z(n10102));
    LUT4 i3223_4_lut (.A(next_state[3]), .B(externstop_falling), .C(signals_debounced_syn[3]), 
         .D(next_state_3__N_1108[2]), .Z(next_state_3__N_1104[3])) /* synthesis lut_function=(!(A (B+!((D)+!C))+!A (B+(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1374[17] 1384[12])
    defparam i3223_4_lut.init = 16'h2303;
    LUT4 i1877_3_lut_4_lut (.A(n_temp1_7__N_365), .B(n9224), .C(n9764), 
         .D(clk_enable_184), .Z(n_wb_stb_i)) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1877_3_lut_4_lut.init = 16'h00fe;
    LUT4 i1581_4_lut (.A(temp1[7]), .B(RST_N_c), .C(temp1[4]), .D(n27), 
         .Z(clk_enable_162)) /* synthesis lut_function=(!(A (B)+!A (B (C+!(D))))) */ ;
    defparam i1581_4_lut.init = 16'h3733;
    LUT4 i5426_2_lut_3_lut (.A(n4641), .B(n4643), .C(clk_enable_205), 
         .Z(n7033)) /* synthesis lut_function=(A (B (C))+!A (C)) */ ;
    defparam i5426_2_lut_3_lut.init = 16'hd0d0;
    LUT4 i3235_2_lut (.A(n9760), .B(next_state[1]), .Z(n6945)) /* synthesis lut_function=(A (B)) */ ;
    defparam i3235_2_lut.init = 16'h8888;
    LUT4 temp1_0__bdd_3_lut_5585 (.A(GPI_DAT[2]), .B(irq_status[2]), .C(temp1[5]), 
         .Z(n9688)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam temp1_0__bdd_3_lut_5585.init = 16'hcaca;
    LUT4 i2_4_lut_adj_157 (.A(dat_count[7]), .B(n12_adj_1442), .C(n17), 
         .D(n15_adj_1441), .Z(n_dat_count[7])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i2_4_lut_adj_157.init = 16'hffec;
    PFUMX i5467 (.BLUT(n9486), .ALUT(n9485), .C0(next_state[3]), .Z(n9487));
    LUT4 i1_4_lut_adj_158 (.A(wb_dat_o[0]), .B(temp1[0]), .C(n9767), .D(n9269), 
         .Z(n_temp1[0])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_158.init = 16'ha0ec;
    LUT4 i1_4_lut_adj_159 (.A(n_temp1_7__N_365), .B(dat_count[7]), .C(n2081), 
         .D(n9757), .Z(n12_adj_1442)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_159.init = 16'ha088;
    LUT4 wb_ack_o_I_0_2_lut_rep_110 (.A(wb_ack_o), .B(wb_stb_i), .Z(clk_enable_184)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(930[12:33])
    defparam wb_ack_o_I_0_2_lut_rep_110.init = 16'h8888;
    LUT4 i1_4_lut_adj_160 (.A(dat_rdy_N_1342), .B(n2081), .C(dat_count[7]), 
         .D(n6972), .Z(n15_adj_1441)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_160.init = 16'h88a0;
    LUT4 pushed_1__I_0_1_lut (.A(pushed[1]), .Z(pushed_1__N_302)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(422[17] 426[24])
    defparam pushed_1__I_0_1_lut.init = 16'h5555;
    LUT4 mux_1364_i14_4_lut (.A(next_state[1]), .B(n3148), .C(n4641), 
         .D(n4637), .Z(n4546)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam mux_1364_i14_4_lut.init = 16'hf5c5;
    LUT4 temp1_0__bdd_2_lut_5593 (.A(temp1[0]), .B(irq_en[0]), .Z(n9698)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam temp1_0__bdd_2_lut_5593.init = 16'h4444;
    LUT4 externstop_last_I_0_2_lut (.A(externstop_last), .B(signals_debounced_syn[2]), 
         .Z(externstop_falling_N_1330)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(429[26:74])
    defparam externstop_last_I_0_2_lut.init = 16'h2222;
    LUT4 FPIO_isoCtrlRSTn_N_1310_bdd_4_lut_5615_4_lut_4_lut (.A(next_state[2]), 
         .B(next_state[1]), .C(next_state_3__N_1108[2]), .D(next_state[0]), 
         .Z(n9746)) /* synthesis lut_function=(!(A+(B (C+(D))+!B !(D)))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1310_bdd_4_lut_5615_4_lut_4_lut.init = 16'h1104;
    LUT4 FPIO_isoCtrlRSTn_N_1309_bdd_4_lut_5457 (.A(n9170), .B(externstop_falling), 
         .C(next_state[1]), .D(next_state[0]), .Z(n9469)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (C+(D))+!B (C (D)))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1309_bdd_4_lut_5457.init = 16'hfce0;
    LUT4 temp1_0__bdd_3_lut_5594 (.A(GPI_DAT[0]), .B(irq_status[0]), .C(temp1[5]), 
         .Z(n9699)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam temp1_0__bdd_3_lut_5594.init = 16'hcaca;
    LUT4 n4_bdd_3_lut_3_lut (.A(next_state[2]), .B(next_state[0]), .C(next_state[1]), 
         .Z(n9696)) /* synthesis lut_function=(A (B (C))+!A (C)) */ ;
    defparam n4_bdd_3_lut_3_lut.init = 16'hd0d0;
    LUT4 FPIO_isoCtrlRSTn_N_1310_bdd_4_lut_5590 (.A(n9760), .B(n7011), .C(next_state[1]), 
         .D(next_state[0]), .Z(n9708)) /* synthesis lut_function=(A ((C (D)+!C !(D))+!B)+!A !(B (C+(D))+!B (C (D)))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1310_bdd_4_lut_5590.init = 16'ha33f;
    LUT4 i2_4_lut_adj_161 (.A(dat_count[6]), .B(n12_adj_1439), .C(n17), 
         .D(n15_adj_1438), .Z(n_dat_count[6])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i2_4_lut_adj_161.init = 16'hffec;
    LUT4 i1746_2_lut (.A(n4637), .B(n4641), .Z(n5428)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam i1746_2_lut.init = 16'hbbbb;
    LUT4 i1_4_lut_adj_162 (.A(n_temp1_7__N_365), .B(dat_count[6]), .C(n2082), 
         .D(n9757), .Z(n12_adj_1439)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_162.init = 16'ha088;
    LUT4 m1_lut (.Z(n10114)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    LUT4 n9710_bdd_3_lut (.A(n9710), .B(n9707), .C(next_state[3]), .Z(n9711)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam n9710_bdd_3_lut.init = 16'hcaca;
    LUT4 temp1_0__bdd_2_lut (.A(temp1[0]), .B(irq_en[1]), .Z(n9712)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam temp1_0__bdd_2_lut.init = 16'h4444;
    LUT4 temp1_0__bdd_3_lut (.A(GPI_DAT[1]), .B(irq_status[1]), .C(temp1[5]), 
         .Z(n9713)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam temp1_0__bdd_3_lut.init = 16'hcaca;
    LUT4 FPIO_isoCtrlRSTn_N_1310_bdd_4_lut_5589_4_lut (.A(next_state[2]), 
         .B(next_state[0]), .C(next_state[1]), .D(n9760), .Z(n9707)) /* synthesis lut_function=(A+!(B (C+!(D))+!B (C))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1310_bdd_4_lut_5589_4_lut.init = 16'hafab;
    LUT4 i1_4_lut_adj_163 (.A(dat_rdy_N_1342), .B(n2082), .C(dat_count[6]), 
         .D(n6972), .Z(n15_adj_1438)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_163.init = 16'h88a0;
    LUT4 i1578_2_lut (.A(clk_enable_153), .B(debounce_inputs_asyn2[4]), 
         .Z(clk_enable_182)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i1578_2_lut.init = 16'hdddd;
    LUT4 next_state_3__I_0_811_Mux_0_i15_4_lut_4_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(n9489), .D(n9313), .Z(next_state_3__N_69[0])) /* synthesis lut_function=(!(A (B+!(D))+!A !(B (C)+!B (D)))) */ ;
    defparam next_state_3__I_0_811_Mux_0_i15_4_lut_4_lut.init = 16'h7340;
    LUT4 i2_4_lut_adj_164 (.A(dat_count[5]), .B(n12_adj_1433), .C(n17), 
         .D(n15_adj_1432), .Z(n_dat_count[5])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i2_4_lut_adj_164.init = 16'hffec;
    LUT4 FPIO_isoCtrlRSTn_N_1310_bdd_4_lut (.A(next_state_3__N_1104[3]), .B(next_state[0]), 
         .C(next_state[1]), .D(next_state_3__N_1108[2]), .Z(n9748)) /* synthesis lut_function=(A (B+(C+!(D)))+!A (B (C)+!B !(C+(D)))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1310_bdd_4_lut.init = 16'he8eb;
    LUT4 i1_4_lut_adj_165 (.A(n_temp1_7__N_365), .B(dat_count[5]), .C(n2083), 
         .D(n9757), .Z(n12_adj_1433)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_165.init = 16'ha088;
    LUT4 i2_3_lut_4_lut_4_lut_adj_166 (.A(next_state[2]), .B(n9788), .C(next_state[1]), 
         .D(next_state[3]), .Z(n9179)) /* synthesis lut_function=(!(A+!(B (C (D))))) */ ;
    defparam i2_3_lut_4_lut_4_lut_adj_166.init = 16'h4000;
    LUT4 i5438_4_lut_4_lut (.A(next_state[2]), .B(n9208), .C(n17_adj_1437), 
         .D(n9179), .Z(clk_enable_187)) /* synthesis lut_function=(!(A (B+(D))+!A (B+(C+(D))))) */ ;
    defparam i5438_4_lut_4_lut.init = 16'h0023;
    LUT4 i1_4_lut_adj_167 (.A(dat_rdy_N_1342), .B(n2083), .C(dat_count[5]), 
         .D(n6972), .Z(n15_adj_1432)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_167.init = 16'h88a0;
    LUT4 i3413_3_lut_3_lut (.A(next_state[2]), .B(n6_adj_1459), .C(next_state[3]), 
         .Z(DIGS3C_Shared_ReqSafeState_N_1318)) /* synthesis lut_function=(!(A ((C)+!B))) */ ;
    defparam i3413_3_lut_3_lut.init = 16'h5d5d;
    LUT4 i2_4_lut_adj_168 (.A(dat_count[4]), .B(n12_adj_1467), .C(n17), 
         .D(n15_adj_1466), .Z(n_dat_count[4])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i2_4_lut_adj_168.init = 16'hffec;
    LUT4 i1_4_lut_adj_169 (.A(n_temp1_7__N_365), .B(dat_count[4]), .C(n2084), 
         .D(n9757), .Z(n12_adj_1467)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_169.init = 16'ha088;
    LUT4 i1_2_lut_rep_88_3_lut (.A(n15_adj_1436), .B(n6957), .C(n_temp1_7__N_368), 
         .Z(n9753)) /* synthesis lut_function=(A (C)+!A (B (C))) */ ;
    defparam i1_2_lut_rep_88_3_lut.init = 16'he0e0;
    LUT4 mux_1145_Mux_2_i15_4_lut_3_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(n9795), .Z(Carrier_PG_1V8_N_1421)) /* synthesis lut_function=(A (B)+!A !(B+!(C))) */ ;
    defparam mux_1145_Mux_2_i15_4_lut_3_lut.init = 16'h9898;
    LUT4 i2462_2_lut_4_lut (.A(n9283), .B(n9711), .C(n9770), .D(n4643), 
         .Z(n6174)) /* synthesis lut_function=(A (B (D))+!A !((C+!(D))+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1307[9] 1483[18])
    defparam i2462_2_lut_4_lut.init = 16'h8c00;
    LUT4 i1_4_lut_adj_170 (.A(dat_rdy_N_1342), .B(n2084), .C(dat_count[4]), 
         .D(n6972), .Z(n15_adj_1466)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_170.init = 16'h88a0;
    LUT4 i1_4_lut_4_lut_adj_171 (.A(next_state[2]), .B(next_state[1]), .C(n8578), 
         .D(n9788), .Z(n18)) /* synthesis lut_function=(!(A+!(B (C)+!B (D)))) */ ;
    defparam i1_4_lut_4_lut_adj_171.init = 16'h5140;
    LUT4 i3_4_lut_adj_172 (.A(n_dat_count_7__N_431[3]), .B(n6_adj_1475), 
         .C(n2_adj_1473), .D(n_temp1_7__N_365), .Z(n_dat_count[3])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i3_4_lut_adj_172.init = 16'hfefc;
    LUT4 i2_4_lut_adj_173 (.A(dat_count[3]), .B(n9223), .C(reg_rdy_N_1338), 
         .D(n9758), .Z(n6_adj_1475)) /* synthesis lut_function=(A ((C)+!B)+!A (C (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i2_4_lut_adj_173.init = 16'hf2a2;
    LUT4 select_1289_Select_3_i2_4_lut (.A(n2085), .B(dat_rdy_N_1342), .C(dat_count[3]), 
         .D(n6972), .Z(n2_adj_1473)) /* synthesis lut_function=(A (B (C+(D)))+!A !(((D)+!C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam select_1289_Select_3_i2_4_lut.init = 16'h88c0;
    LUT4 i2_4_lut_adj_174 (.A(dat_count[2]), .B(n12_adj_1435), .C(n17), 
         .D(n15_adj_1434), .Z(n_dat_count[2])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i2_4_lut_adj_174.init = 16'hffec;
    LUT4 ANL_S3C_CarrierReady_c_bdd_2_lut_5654 (.A(n9749), .B(next_state[2]), 
         .Z(n9750)) /* synthesis lut_function=(A (B)) */ ;
    defparam ANL_S3C_CarrierReady_c_bdd_2_lut_5654.init = 16'h8888;
    LUT4 i1_4_lut_4_lut_adj_175 (.A(next_state[2]), .B(next_state[3]), .C(n25), 
         .D(n6945), .Z(n32)) /* synthesis lut_function=(!(A+!(B (C)+!B (D)))) */ ;
    defparam i1_4_lut_4_lut_adj_175.init = 16'h5140;
    LUT4 i5435_4_lut_4_lut (.A(next_state[2]), .B(n9487), .C(n9780), .D(n25_adj_1430), 
         .Z(clk_enable_188)) /* synthesis lut_function=(A (C+!(D))+!A !(B+!(C+!(D)))) */ ;
    defparam i5435_4_lut_4_lut.init = 16'hb0bb;
    LUT4 next_state_1__bdd_3_lut_5567_3_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(next_state[1]), .Z(n9501)) /* synthesis lut_function=((B+(C))+!A) */ ;
    defparam next_state_1__bdd_3_lut_5567_3_lut.init = 16'hfdfd;
    LUT4 i3224_4_lut (.A(next_state[2]), .B(externstop_falling), .C(signals_debounced_syn[3]), 
         .D(next_state_3__N_1108[2]), .Z(next_state_3__N_1104[2])) /* synthesis lut_function=(A (B+(C))+!A (B+!((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1374[17] 1384[12])
    defparam i3224_4_lut.init = 16'hecfc;
    LUT4 i1983_3_lut_4_lut (.A(n_temp1_7__N_365), .B(n9764), .C(n9224), 
         .D(clk_enable_184), .Z(n_wb_adr_i[6])) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1983_3_lut_4_lut.init = 16'h00fe;
    LUT4 next_state_3__I_0_811_Mux_1_i15_4_lut_4_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(n9520), .D(n9471), .Z(next_state_3__N_69[1])) /* synthesis lut_function=(!(A (B+!(D))+!A !(B (C)+!B (D)))) */ ;
    defparam next_state_3__I_0_811_Mux_1_i15_4_lut_4_lut.init = 16'h7340;
    LUT4 i1_4_lut_adj_176 (.A(n_temp1_7__N_365), .B(dat_count[2]), .C(n2086), 
         .D(n9757), .Z(n12_adj_1435)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_176.init = 16'ha088;
    LUT4 i1_4_lut_adj_177 (.A(dat_rdy_N_1342), .B(n2086), .C(dat_count[2]), 
         .D(n6972), .Z(n15_adj_1434)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_177.init = 16'h88a0;
    LUT4 FPIO_isoCtrlRSTn_N_1310_bdd_3_lut (.A(next_state_3__N_1104[3]), .B(next_state[0]), 
         .C(next_state[1]), .Z(n9747)) /* synthesis lut_function=(!((B (C)+!B !(C))+!A)) */ ;
    defparam FPIO_isoCtrlRSTn_N_1310_bdd_3_lut.init = 16'h2828;
    LUT4 mux_1145_Mux_12_i15_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), 
         .C(PPn_VIN_c), .D(next_state[3]), .Z(forceoutputdisable_N_8)) /* synthesis lut_function=(!(A (C+(D))+!A !(B+!(C (D))))) */ ;
    defparam mux_1145_Mux_12_i15_4_lut_4_lut.init = 16'h455f;
    LUT4 equal_266_i10_2_lut_rep_109 (.A(temp1[2]), .B(temp1[3]), .Z(n9774)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(543[13:23])
    defparam equal_266_i10_2_lut_rep_109.init = 16'hdddd;
    LUT4 i2_4_lut_adj_178 (.A(dat_count[1]), .B(n12), .C(n17), .D(n15_adj_1429), 
         .Z(n_dat_count[1])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i2_4_lut_adj_178.init = 16'hffec;
    LUT4 i5307_4_lut_4_lut (.A(n15_adj_1436), .B(n6957), .C(n_temp1_7__N_368), 
         .D(n_temp1_7__N_369), .Z(n9241)) /* synthesis lut_function=(!(A+!(B (D)+!B (C+(D))))) */ ;
    defparam i5307_4_lut_4_lut.init = 16'h5510;
    LUT4 i1_3_lut_4_lut_then_3_lut_4_lut (.A(n_temp1_7__N_362), .B(n_temp1_7__N_360), 
         .C(n15_adj_1436), .D(n6957), .Z(n9800)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_3_lut_4_lut_then_3_lut_4_lut.init = 16'hfffe;
    PFUMX i5626 (.BLUT(n9802), .ALUT(n9803), .C0(temp1[1]), .Z(n9301));
    LUT4 i1_4_lut_adj_179 (.A(n_temp1_7__N_365), .B(dat_count[1]), .C(n2087), 
         .D(n9757), .Z(n12)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_179.init = 16'ha088;
    LUT4 i1_4_lut_adj_180 (.A(dat_rdy_N_1342), .B(dat_count[1]), .C(n2087), 
         .D(n6972), .Z(n15_adj_1429)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(807[6] 1299[10])
    defparam i1_4_lut_adj_180.init = 16'ha088;
    PFUMX i5624 (.BLUT(n9799), .ALUT(n9800), .C0(n_temp1_7__N_368), .Z(n9801));
    LUT4 i2_3_lut_4_lut_adj_181 (.A(temp1[2]), .B(temp1[3]), .C(n9790), 
         .D(n14_adj_1470), .Z(n5927)) /* synthesis lut_function=((B+(C+(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(543[13:23])
    defparam i2_3_lut_4_lut_adj_181.init = 16'hfffd;
    efb_vhdl dut (.clk(clk), .n9776(n9776), .wb_stb_i(wb_stb_i), .wb_we_i(wb_we_i), 
            .GND_net(GND_net), .\wb_adr_i[6] (wb_adr_i[6]), .\wb_adr_i[2] (wb_adr_i[2]), 
            .\wb_adr_i[1] (wb_adr_i[1]), .\wb_adr_i[0] (wb_adr_i[0]), .wb_dat_i({wb_dat_i}), 
            .\wb_dat_o[7] (wb_dat_o[7]), .\n_state_7__N_1056[4] (n_state_7__N_1056[4]), 
            .\wb_dat_o[5] (wb_dat_o[5]), .\wb_dat_o[4] (wb_dat_o[4]), .\wb_dat_o[3] (wb_dat_o[3]), 
            .\wb_dat_o[2] (wb_dat_o[2]), .\wb_dat_o[1] (wb_dat_o[1]), .\wb_dat_o[0] (wb_dat_o[0]), 
            .wb_ack_o(wb_ack_o), .i2c1_sdaoen(i2c1_sdaoen), .i2c1_sdao(i2c1_sdao), 
            .i2c1_scloen(i2c1_scloen), .i2c1_sclo(i2c1_sclo), .i2c1_sdai(i2c1_sdai), 
            .i2c1_scli(i2c1_scli), .VCC_net(VCC_net)) /* synthesis NGD_DRC_MASK=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(471[7:15])
    
endmodule
//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

//
// Verilog Description of module efb_vhdl
//

module efb_vhdl (clk, n9776, wb_stb_i, wb_we_i, GND_net, \wb_adr_i[6] , 
            \wb_adr_i[2] , \wb_adr_i[1] , \wb_adr_i[0] , wb_dat_i, \wb_dat_o[7] , 
            \n_state_7__N_1056[4] , \wb_dat_o[5] , \wb_dat_o[4] , \wb_dat_o[3] , 
            \wb_dat_o[2] , \wb_dat_o[1] , \wb_dat_o[0] , wb_ack_o, i2c1_sdaoen, 
            i2c1_sdao, i2c1_scloen, i2c1_sclo, i2c1_sdai, i2c1_scli, 
            VCC_net) /* synthesis NGD_DRC_MASK=1 */ ;
    input clk;
    input n9776;
    input wb_stb_i;
    input wb_we_i;
    input GND_net;
    input \wb_adr_i[6] ;
    input \wb_adr_i[2] ;
    input \wb_adr_i[1] ;
    input \wb_adr_i[0] ;
    input [7:0]wb_dat_i;
    output \wb_dat_o[7] ;
    output \n_state_7__N_1056[4] ;
    output \wb_dat_o[5] ;
    output \wb_dat_o[4] ;
    output \wb_dat_o[3] ;
    output \wb_dat_o[2] ;
    output \wb_dat_o[1] ;
    output \wb_dat_o[0] ;
    output wb_ack_o;
    output i2c1_sdaoen;
    output i2c1_sdao;
    output i2c1_scloen;
    output i2c1_sclo;
    input i2c1_sdai;
    input i2c1_scli;
    input VCC_net;
    
    wire clk /* synthesis SET_AS_NETWORK=clk, is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(128[9:12])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(40[12:21])
    
    EFB EFBInst_0 (.WBCLKI(clk), .WBRSTI(n9776), .WBCYCI(wb_stb_i), .WBSTBI(wb_stb_i), 
        .WBWEI(wb_we_i), .WBADRI0(\wb_adr_i[0] ), .WBADRI1(\wb_adr_i[1] ), 
        .WBADRI2(\wb_adr_i[2] ), .WBADRI3(GND_net), .WBADRI4(GND_net), 
        .WBADRI5(GND_net), .WBADRI6(\wb_adr_i[6] ), .WBADRI7(GND_net), 
        .WBDATI0(wb_dat_i[0]), .WBDATI1(wb_dat_i[1]), .WBDATI2(wb_dat_i[2]), 
        .WBDATI3(wb_dat_i[3]), .WBDATI4(wb_dat_i[4]), .WBDATI5(wb_dat_i[5]), 
        .WBDATI6(wb_dat_i[6]), .WBDATI7(wb_dat_i[7]), .I2C1SCLI(i2c1_scli), 
        .I2C1SDAI(i2c1_sdai), .I2C2SCLI(GND_net), .I2C2SDAI(GND_net), 
        .SPISCKI(GND_net), .SPIMISOI(GND_net), .SPIMOSII(GND_net), .SPISCSN(GND_net), 
        .TCCLKI(GND_net), .TCRSTN(GND_net), .TCIC(GND_net), .UFMSN(VCC_net), 
        .PLL0DATI0(GND_net), .PLL0DATI1(GND_net), .PLL0DATI2(GND_net), 
        .PLL0DATI3(GND_net), .PLL0DATI4(GND_net), .PLL0DATI5(GND_net), 
        .PLL0DATI6(GND_net), .PLL0DATI7(GND_net), .PLL0ACKI(GND_net), 
        .PLL1DATI0(GND_net), .PLL1DATI1(GND_net), .PLL1DATI2(GND_net), 
        .PLL1DATI3(GND_net), .PLL1DATI4(GND_net), .PLL1DATI5(GND_net), 
        .PLL1DATI6(GND_net), .PLL1DATI7(GND_net), .PLL1ACKI(GND_net), 
        .WBDATO0(\wb_dat_o[0] ), .WBDATO1(\wb_dat_o[1] ), .WBDATO2(\wb_dat_o[2] ), 
        .WBDATO3(\wb_dat_o[3] ), .WBDATO4(\wb_dat_o[4] ), .WBDATO5(\wb_dat_o[5] ), 
        .WBDATO6(\n_state_7__N_1056[4] ), .WBDATO7(\wb_dat_o[7] ), .WBACKO(wb_ack_o), 
        .I2C1SCLO(i2c1_sclo), .I2C1SCLOEN(i2c1_scloen), .I2C1SDAO(i2c1_sdao), 
        .I2C1SDAOEN(i2c1_sdaoen)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=471, LSE_RLINE=471 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(471[7:15])
    defparam EFBInst_0.EFB_I2C1 = "ENABLED";
    defparam EFBInst_0.EFB_I2C2 = "DISABLED";
    defparam EFBInst_0.EFB_SPI = "DISABLED";
    defparam EFBInst_0.EFB_TC = "DISABLED";
    defparam EFBInst_0.EFB_TC_PORTMODE = "WB";
    defparam EFBInst_0.EFB_UFM = "DISABLED";
    defparam EFBInst_0.EFB_WB_CLK_FREQ = "10.0";
    defparam EFBInst_0.DEV_DENSITY = "1200L";
    defparam EFBInst_0.UFM_INIT_PAGES = 0;
    defparam EFBInst_0.UFM_INIT_START_PAGE = 0;
    defparam EFBInst_0.UFM_INIT_ALL_ZEROS = "ENABLED";
    defparam EFBInst_0.UFM_INIT_FILE_NAME = "NONE";
    defparam EFBInst_0.UFM_INIT_FILE_FORMAT = "HEX";
    defparam EFBInst_0.I2C1_ADDRESSING = "7BIT";
    defparam EFBInst_0.I2C2_ADDRESSING = "7BIT";
    defparam EFBInst_0.I2C1_SLAVE_ADDR = "0b0011001";
    defparam EFBInst_0.I2C2_SLAVE_ADDR = "0b0001001";
    defparam EFBInst_0.I2C1_BUS_PERF = "100kHz";
    defparam EFBInst_0.I2C2_BUS_PERF = "100kHz";
    defparam EFBInst_0.I2C1_CLK_DIVIDER = 25;
    defparam EFBInst_0.I2C2_CLK_DIVIDER = 1;
    defparam EFBInst_0.I2C1_GEN_CALL = "DISABLED";
    defparam EFBInst_0.I2C2_GEN_CALL = "DISABLED";
    defparam EFBInst_0.I2C1_WAKEUP = "DISABLED";
    defparam EFBInst_0.I2C2_WAKEUP = "DISABLED";
    defparam EFBInst_0.SPI_MODE = "MASTER";
    defparam EFBInst_0.SPI_CLK_DIVIDER = 1;
    defparam EFBInst_0.SPI_LSB_FIRST = "DISABLED";
    defparam EFBInst_0.SPI_CLK_INV = "DISABLED";
    defparam EFBInst_0.SPI_PHASE_ADJ = "DISABLED";
    defparam EFBInst_0.SPI_SLAVE_HANDSHAKE = "DISABLED";
    defparam EFBInst_0.SPI_INTR_TXRDY = "DISABLED";
    defparam EFBInst_0.SPI_INTR_RXRDY = "DISABLED";
    defparam EFBInst_0.SPI_INTR_TXOVR = "DISABLED";
    defparam EFBInst_0.SPI_INTR_RXOVR = "DISABLED";
    defparam EFBInst_0.SPI_WAKEUP = "DISABLED";
    defparam EFBInst_0.TC_MODE = "CTCM";
    defparam EFBInst_0.TC_SCLK_SEL = "PCLOCK";
    defparam EFBInst_0.TC_CCLK_SEL = 1;
    defparam EFBInst_0.GSR = "ENABLED";
    defparam EFBInst_0.TC_TOP_SET = 65535;
    defparam EFBInst_0.TC_OCR_SET = 32767;
    defparam EFBInst_0.TC_OC_MODE = "TOGGLE";
    defparam EFBInst_0.TC_RESETN = "ENABLED";
    defparam EFBInst_0.TC_TOP_SEL = "OFF";
    defparam EFBInst_0.TC_OV_INT = "OFF";
    defparam EFBInst_0.TC_OCR_INT = "OFF";
    defparam EFBInst_0.TC_ICR_INT = "OFF";
    defparam EFBInst_0.TC_OVERFLOW = "DISABLED";
    defparam EFBInst_0.TC_ICAPTURE = "DISABLED";
    
endmodule
