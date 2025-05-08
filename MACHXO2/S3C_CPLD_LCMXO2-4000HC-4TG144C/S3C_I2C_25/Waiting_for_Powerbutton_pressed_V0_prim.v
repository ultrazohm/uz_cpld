// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Thu May 08 10:07:15 2025
//
// Verilog Description of module Waiting_for_Powerbutton_pressed_V0
//

module Waiting_for_Powerbutton_pressed_V0 (FP_SysLEDg, FP_SysLEDr, FP_SysLEDb, 
            FlexIO05, FlexIO04, FlexIO03, FlexIO02, FlexIO01, FP_UsrSW1, 
            FP_UsrSW2, SCL, SDA, FP_UsrSW3, SysSW_Pwr_NC, FPIO_isoCtrlRSTn, 
            FPIO_isoCtrlINTn, Carrier_PG_3V3, FPIO_ExternalStop, FPIO_FlexMIO28, 
            FPIO_FlexMIO27, FPIO_FlexMIO30, FPIO_FlexMIO29, FPIO_FlexMIO52, 
            Carrier_PG_1V8, S3CsI2C_SDA, S3CsI2C_SCL, FP_SysLEDs, SD1_CD, 
            SD0_CD, SPI_S3C_nCS_USR, FP_UsrLED, DIGS3C_Shared_CarrierReady, 
            DIGS3C_Shared_ReqSafeState, DIGS3C_SlotD_ReqOE, DIGS3C_SlotD_SlotOK, 
            FlexLIO, DIG5S3C26, DIG5S3C25, DIG5S3C24, SD_SEL, ANL_VIN_FLT, 
            FlexMIOs52_PCIe, FlexMIOs53_GPIO_PowerDown, FlexMIOs54, FlexMio61ExternalStop, 
            FlexMIOs62, FlexMIOs63, FlexMIOs31, FlexMIOs30, FlexMIOs29, 
            FlexMIOs28, FlexMIOs27, FlexMIOs26, FlexMIOs45, FlexMIOs37, 
            FlexMIOs36, FlexMIOs35, FlexMIOs34, FlexMIOs33, FlexMIOs32, 
            DIG5S3C03, DIG5S3C04, DIG5S3C05, DIG5S3C00, DIG5S3C02, 
            DIG5S3C01, DIG5S3C29, DIG5S3C28, DIG5S3C27, ANL_S3C_SLOTOK, 
            ANL_S3C_CarrierReady, ANL_S3C_P54_Legacy, DIGS3C_SlotD_SlotOE, 
            Carrier_PwrOn, PG_VIN, PPn_VIN, PG_Module, TDnSHDN, TDnFFnFS, 
            TDnALERT, S3C_S1, IRQ);   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(8[8:42])
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
    inout SCL /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(36[3:6])
    inout SDA /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(37[3:6])
    input FP_UsrSW3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(38[3:12])
    input SysSW_Pwr_NC;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(39[3:15])
    output FPIO_isoCtrlRSTn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(40[3:19])
    input FPIO_isoCtrlINTn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(41[3:19])
    output Carrier_PG_3V3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(42[3:17])
    input FPIO_ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(43[3:20])
    inout FPIO_FlexMIO28;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(44[3:17])
    inout FPIO_FlexMIO27;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(45[3:17])
    inout FPIO_FlexMIO30;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(46[3:17])
    inout FPIO_FlexMIO29;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(47[3:17])
    output FPIO_FlexMIO52;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(48[3:17])
    output Carrier_PG_1V8;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(50[3:17])
    input S3CsI2C_SDA /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(51[3:14])
    input S3CsI2C_SCL /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(52[3:14])
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
    input ANL_VIN_FLT;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(68[3:14])
    input FlexMIOs52_PCIe;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(70[3:18])
    output FlexMIOs53_GPIO_PowerDown;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(71[3:28])
    inout FlexMIOs54;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(72[3:13])
    output FlexMio61ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(73[3:24])
    inout FlexMIOs62;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(74[3:13])
    inout FlexMIOs63;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(75[3:13])
    inout FlexMIOs31;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(76[3:13])
    inout FlexMIOs30;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(77[3:13])
    inout FlexMIOs29;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(78[3:13])
    inout FlexMIOs28;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(79[3:13])
    inout FlexMIOs27;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(80[3:13])
    inout FlexMIOs26;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(81[3:13])
    input FlexMIOs45 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(82[3:13])
    inout FlexMIOs37;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(83[3:13])
    inout FlexMIOs36;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(84[3:13])
    inout FlexMIOs35;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(85[3:13])
    inout FlexMIOs34;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(86[3:13])
    inout FlexMIOs33;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(87[3:13])
    inout FlexMIOs32;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(88[3:13])
    inout DIG5S3C03;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(90[3:12])
    inout DIG5S3C04;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(91[3:12])
    inout DIG5S3C05;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(92[3:12])
    inout DIG5S3C00;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(93[3:12])
    inout DIG5S3C02;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(94[3:12])
    inout DIG5S3C01;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(95[3:12])
    inout DIG5S3C29;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(96[3:12])
    inout DIG5S3C28;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(97[3:12])
    inout DIG5S3C27;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(98[3:12])
    input [3:1]ANL_S3C_SLOTOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(101[3:17])
    output ANL_S3C_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(102[3:23])
    input ANL_S3C_P54_Legacy /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(103[3:21])
    output [5:1]DIGS3C_SlotD_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(104[3:22])
    output Carrier_PwrOn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(107[9:22])
    input PG_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(108[3:9])
    input PPn_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(109[3:10])
    input PG_Module;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(110[3:12])
    input TDnSHDN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(111[3:10])
    input TDnFFnFS /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(112[3:11])
    input TDnALERT;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(113[3:11])
    input S3C_S1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(114[3:9])
    input [3:0]IRQ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    
    wire clk /* synthesis SET_AS_NETWORK=clk, is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(125[9:12])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(40[12:21])
    wire dummy_signal /* synthesis noclip="on" */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(177[9:21])
    
    wire GND_net, VCC_net, FP_SysLEDg_c, FP_SysLEDr_c, FP_SysLEDb_c, 
        FlexIO05_c_2, FlexIO04_c, FlexIO03_c, FlexIO02_c_1, FlexIO01_c_0, 
        FP_UsrSW1_c, FP_UsrSW2_c, FP_UsrSW3_c, SysSW_Pwr_NC_c, FPIO_isoCtrlRSTn_c, 
        FPIO_isoCtrlINTn_c, Carrier_PG_3V3_c, FlexMio61ExternalStop_c_c, 
        FPIO_FlexMIO52_c_c, S3CsI2C_SDA_c, S3CsI2C_SCL_c, FP_SysLEDs_c_3, 
        SD1_CD_c, SD0_CD_c, SPI_S3C_nCS_USR_c, FP_UsrLED_c_4, FP_UsrLED_c_3, 
        FP_UsrLED_c_2, FP_UsrLED_c_1, DIGS3C_Shared_ReqSafeState_c, DIGS3C_SlotD_ReqOE_c_5, 
        DIGS3C_SlotD_ReqOE_c_4, DIGS3C_SlotD_ReqOE_c_3, DIGS3C_SlotD_ReqOE_c_2, 
        DIGS3C_SlotD_ReqOE_c_1, DIGS3C_SlotD_SlotOK_c_5, DIGS3C_SlotD_SlotOK_c_4, 
        DIGS3C_SlotD_SlotOK_c_3, DIGS3C_SlotD_SlotOK_c_2, DIGS3C_SlotD_SlotOK_c_1, 
        FlexLIO_c_5, FlexLIO_c_4, FlexLIO_c_3, FlexLIO_c_2, FlexLIO_c_1, 
        FlexLIO_c_0, ANL_VIN_FLT_c, FlexMIOs53_GPIO_PowerDown_c, FlexMIOs45_c, 
        ANL_S3C_SLOTOK_c_3, ANL_S3C_SLOTOK_c_2, ANL_S3C_SLOTOK_c_1, ANL_S3C_P54_Legacy_c, 
        DIGS3C_SlotD_SlotOE_c_5, DIGS3C_SlotD_SlotOE_c_4, DIGS3C_SlotD_SlotOE_c_3, 
        DIGS3C_SlotD_SlotOE_c_2, DIGS3C_SlotD_SlotOE_c_1, Carrier_PwrOn_c, 
        PG_VIN_c, PPn_VIN_c, PG_Module_c, TDnSHDN_c, TDnFFnFS_c, TDnALERT_c, 
        S3C_S1_c;
    wire [24:0]counter;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(126[9:16])
    wire [24:0]resetcounter;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(127[9:21])
    
    wire n33, n27, resetnefb;
    wire [3:0]next_state;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(134[12:22])
    wire [31:0]\debounce_counters[1] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(141[12:29])
    wire [31:0]\debounce_counters[2] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(141[12:29])
    wire [31:0]\debounce_counters[3] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(141[12:29])
    wire [31:0]\debounce_counters[4] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(141[12:29])
    
    wire n8321, n8320, n8319, n8318, n15, n12, n96, n8, n9079, 
        n94, n8317;
    wire [6:1]debounce_inputs_asyn1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(143[12:33])
    wire [6:1]debounce_inputs_asyn2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(144[9:30])
    wire [6:1]pushed;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(145[9:15])
    wire [6:1]signals_debounced_syn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(146[12:33])
    
    wire externstop_falling, externstop_last, extern_connected, forceoutputdisable;
    wire [7:0]wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(275[8:16])
    
    wire wb_stb_i, n8316;
    wire [7:0]wb_adr_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(278[8:16])
    
    wire n8315, wb_we_i;
    wire [7:0]wb_dat_o;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(280[8:16])
    
    wire wb_ack_o;
    wire [7:0]data0;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(292[8:13])
    wire [7:0]temp1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(293[14:19])
    wire [7:0]temp2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(293[20:25])
    wire [7:0]temp3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(293[26:31])
    wire [7:0]n_temp1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(294[16:23])
    
    wire n8987, reg_rdy, dat_rdy, dat_rdy_del;
    wire [7:0]n_dat_count;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(302[8:19])
    wire [7:0]dat_count;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(302[22:31])
    wire [7:0]GPI_DAT;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(303[8:15])
    wire [7:0]n_wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(314[8:18])
    
    wire n_wb_stb_i;
    wire [7:0]n_wb_adr_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(316[8:18])
    
    wire n_wb_we_i, n8314, n15_adj_1404, n8558, n7, n18, n5, n8998, 
        clk_enable_145, n12_adj_1405, n4, n6023, n5971, n205, n206, 
        n207, n208, n209, n210, n211, n212, n213, n214, n215, 
        n216, n217, n218, n219, n220, n221, n222, n223, n224, 
        n225, n226, n227, n228, n229, n230, n231, n232, n233, 
        n234, n235, n236, n76, n74, n2, n8448, n46, pushed_1__N_297, 
        n311, n312, n313, n314, n315, n316, n317, n318, n319, 
        n320, n321, n322, n323, n324, n325, n326, n327, n328, 
        n329, n330, n331, n332, n333, n334, n335, n336, n337, 
        n338, n339, n340, n341, n342, n8313, n8312, n8311, n76_adj_1406, 
        n8708, n8310, n15_adj_1407, n23, pushed_2__N_295, n417, 
        n418, n419, n420, n421, n422, n423, n424, n425, n426, 
        n427, n428, n429, n430, n431, n432, n433, n434, n435, 
        n436, n437, n438, n439, n440, n441, n442, n443, n444, 
        n445, n446, n447, n448, n92, n8309, n8308, n8306, n9053, 
        n8305, n8304, n9, n30, pushed_3__N_293, n523, n524, n525, 
        n526, n527, n528, n529, n530, n531, n532, n533, n534, 
        n535, n536, n537, n538, n539, n540, n541, n542, n543, 
        n544, n545, n546, n547, n548, n549, n550, n551, n552, 
        n553, n554, n8303, n8302, n8301, n8300, n8299, n8298, 
        n8297, n8296, n8295, n14, n8294, n8293, n64, pushed_4__N_291, 
        n8292, n8291, n8289, n8288, n8287, n8286, n8285, n8284, 
        n8283, n8282, n8359, n8281, n8280, n8358, n8357, n8279, 
        n9541, n9059, n4_adj_1408, n8278, n8356, n8355, n8354, 
        n8353, n6823, n8277, n8276, n8275, n6870, n9279, n17, 
        n8274, n8273, n8272, n8352, n6, n75, n10, externstop_falling_N_1309, 
        n15_adj_1409, n15_adj_1410, n9540, clk_enable_136, n30_adj_1411, 
        n9539, n36, n8351, n33_adj_1412, n10_adj_1413, resetcounter_24__N_1304, 
        n8350, n8349, n8348, n33_adj_1414, n8347, n8346, n12_adj_1415, 
        clk_enable_128, n8345, reg_rdy_N_1317, reg_rdy_N_1315, dat_rdy_N_1321, 
        dat_rdy_N_1319, i2c1_sdao, i2c1_sdaoen, clk_enable_144;
    wire [7:0]data0_7__N_892;
    
    wire n8271, n8344, n8343, n8270, n50, clk_enable_41, n8269, 
        n35, n9014, n8934, n8342, n12_adj_1416, n8268, i2c1_sdai, 
        n6797, n8341, n19, n91, n8267, n90, clk_enable_56, n5440, 
        n6_adj_1417, n22, n21, n20, n19_adj_1418, n6_adj_1419, n130, 
        n129, n128, clk_enable_126, n8340, clk_enable_188, n127, 
        n8266, n8953, n126, n8339, n125, n124, n8338, n8985, 
        n18_adj_1420, n8337, n15_adj_1421, n68, n9278, n50_adj_1422, 
        n8554, n12_adj_1423, n123, n8336, n122, n121, n9277, n8335, 
        n120, n72, n5735, n48, n8265, n18_adj_1424, n8916, n119, 
        n118, n4579, n14_adj_1425, n117, n9382, n9381, n116, n115, 
        n114, n113, n112, n9276, n8334, n9275, n8264, n30_adj_1426, 
        n8333, n6863, n9380, n111, n110, n109, n108, n107, n106, 
        FPIO_FlexMIO28_out, n8263, n9021, n8332, n9379;
    wire [7:0]n_state_7__N_978;
    
    wire n9378, n8363, n8331, n30_adj_1427, n5739, n9538, n8262, 
        n8330, n8329, n8328, n3903, n8327, n8261, n9527, n9537, 
        n6975, n2028, n2029, n2030, n2031, n2032, n2033, n2034, 
        n2035, n12_adj_1428, n8975, n8326, n8325, n8324, n8260, 
        n4585, n40, n8323, n1, n8586, n6020, n6540, n88;
    wire [7:0]n_dat_count_7__N_418;
    
    wire n8259, n5347;
    wire [7:0]n_state_7__N_1034;
    
    wire clk_enable_127, n8258, n8322, n30_adj_1429, n5343, n9536, 
        n5337, n9526, n5335, n5333, n8257, n8256, n9486, n8255, 
        n9270, n5331, n29, n48_adj_1430, n8254, n8253, n8252, 
        n_temp1_7__N_346, n_temp1_7__N_347, n_temp1_7__N_348, n_temp1_7__N_349, 
        n_temp1_7__N_350, n_temp1_7__N_351, n_temp1_7__N_352, n_temp1_7__N_353, 
        n_temp1_7__N_354, n_temp1_7__N_355, i2c1_sclo, n_temp1_7__N_357, 
        n_temp1_7__N_358, i2c1_scloen, n_temp1_7__N_360, n_temp1_7__N_361, 
        n_temp1_7__N_362, n_temp1_7__N_363, n_temp1_7__N_364, n5329, 
        n60, n8251, n59, n5990, n9570, n8250, n9269, n8249, 
        n8248, n8247, n8246, FPIO_isoCtrlRSTn_N_1288, n8977, n15_adj_1431, 
        n8245, n3840, n12_adj_1432, n8244, n8243, n43, n8242, 
        n8241, clk_enable_4, n5325, n112_adj_1433, n8240, n8239, 
        n30_adj_1434, n8238, n5737, clk_enable_87, n6936, n8237, 
        n8236, n4258, n8235, n67, n25, n8234, n8233, n8232, 
        n4583, n8435, n9869, n8_adj_1435, n4415, n4412, n15_adj_1436, 
        n110_adj_1437, n4527, n4526, n4523, n4517, n4516, n4515, 
        n4513, n4512, n4511, clk_enable_13, clk_enable_17, n4_adj_1438, 
        n8231, n4_adj_1439, n5305, n4497, n4496, n4495, n4494, 
        n4491, n4490, n4489, n4487, n4486, n4485, n4484;
    wire [3:0]next_state_3__N_1086;
    
    wire n3084, n3085, n3086, n3087, n3088, n3089, n3090, n3091, 
        n3092, n3093, n3094, n3095, n3096, n3097, n3098, n3099, 
        n3100, n3101, n3102, n3103, n3104, n3105, n3106, n3107, 
        n3108, n4483, n4482, n4480, n4479, n108_adj_1440, n8230, 
        forceoutputdisable_N_11, DIGS3C_Shared_ReqSafeState_N_1295, FlexMIOs53_GPIO_PowerDown_N_1297, 
        FP_SysLEDr_N_1282, FP_SysLEDb_N_1283, FP_SysLEDg_N_1281;
    wire [3:0]next_state_3__N_64;
    
    wire Carrier_PwrOn_N_1300, FPIO_isoCtrlRSTn_N_1284, n8229, n8228, 
        n106_adj_1441, n12_adj_1442, n8227, n8226, n8225, n8224, 
        n42, n8223, n8222, n8221, n5298, n4_adj_1443, n9535, n4_adj_1444, 
        Carrier_PG_1V8_N_1396, Carrier_PG_1V8_N_1403, Carrier_PG_1V8_N_1294, 
        n6543, n8220, n24, n23_adj_1445, clk_enable_118, clk_enable_125, 
        n30_adj_1446, n8564, n8990, clk_enable_135, n4862, n23_adj_1447, 
        n14_adj_1448, n8219, n8218, clk_enable_137, n8941, n9510, 
        n9509, n9508, n12_adj_1449, n9522, clk_enable_157, n17_adj_1450, 
        n8217, n8216, n8215, n14_adj_1451, FPIO_FlexMIO27_out, FPIO_FlexMIO30_out, 
        FPIO_FlexMIO29_out, DIG5S3C26_out, DIG5S3C25_out, DIG5S3C24_out, 
        n7_adj_1452, FlexMIOs54_out, n9498, FlexMIOs62_out, n9497, 
        FlexMIOs63_out, FlexMIOs31_out, FlexMIOs30_out, FlexMIOs29_out, 
        FlexMIOs28_out, n80, FlexMIOs27_out, FlexMIOs26_out, FlexMIOs37_out, 
        FlexMIOs36_out, n9496, FlexMIOs35_out, FlexMIOs34_out, FlexMIOs33_out, 
        n8214, FlexMIOs32_out, DIG5S3C03_out, n36_adj_1453, DIG5S3C04_out, 
        n9495, DIG5S3C05_out, DIG5S3C00_out, DIG5S3C02_out, DIG5S3C01_out, 
        DIG5S3C29_out, n9494, DIG5S3C28_out, DIG5S3C27_out, n9045, 
        n5257, n9525, n9533, n9316, n9488, n9315, n9314, n9487, 
        n9571, n4_adj_1454, n28, n58, n12_adj_1455, n9532, n9523, 
        n9520, n9531, n104, n102, n100, n99, n98, n9560, n9559, 
        n9558, n9569, n9556, n9568, clk_enable_138, n9555, n9554, 
        n9530, clk_enable_148, n9553, n38, clk_enable_2, n9057, 
        n9551, n9550, n9028, n9566, n32, n9744, n9743, n9742, 
        n9549, n9741, n9740, n9867, n9737, clk_enable_143, n9736, 
        clk_enable_146, n9565, n8929, n27_adj_1456, n9562, n9564, 
        n9546, n9529, n37, n12_adj_1457, n8937, n9561, n9866, 
        n8876, n9544, n9543, n9011, n48_adj_1458, n9542, n10_adj_1459, 
        clk_enable_15;
    
    VHI i2 (.Z(VCC_net));
    efb_vhdl dut (.clk(clk), .n9558(n9558), .wb_stb_i(wb_stb_i), .wb_we_i(wb_we_i), 
            .GND_net(GND_net), .\wb_adr_i[6] (wb_adr_i[6]), .\wb_adr_i[2] (wb_adr_i[2]), 
            .\wb_adr_i[1] (wb_adr_i[1]), .\wb_adr_i[0] (wb_adr_i[0]), .wb_dat_i({wb_dat_i}), 
            .\wb_dat_o[7] (wb_dat_o[7]), .\n_state_7__N_1034[4] (n_state_7__N_1034[4]), 
            .\wb_dat_o[5] (wb_dat_o[5]), .\wb_dat_o[4] (wb_dat_o[4]), .\wb_dat_o[3] (wb_dat_o[3]), 
            .\wb_dat_o[2] (wb_dat_o[2]), .\wb_dat_o[1] (wb_dat_o[1]), .\wb_dat_o[0] (wb_dat_o[0]), 
            .wb_ack_o(wb_ack_o), .i2c1_sdaoen(i2c1_sdaoen), .i2c1_sdao(i2c1_sdao), 
            .i2c1_scloen(i2c1_scloen), .i2c1_sclo(i2c1_sclo), .i2c1_sdai(i2c1_sdai), 
            .i2c1_scli(i2c1_scli), .VCC_net(VCC_net)) /* synthesis NGD_DRC_MASK=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(361[7:15])
    LUT4 mux_458_i4_3_lut_4_lut (.A(n6797), .B(clk_enable_2), .C(n2032), 
         .D(dat_count[3]), .Z(n_dat_count_7__N_418[3])) /* synthesis lut_function=(A (D)+!A (B (C)+!B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1190[7] 1209[12])
    defparam mux_458_i4_3_lut_4_lut.init = 16'hfb40;
    LUT4 i3155_2_lut_3_lut_4_lut (.A(n9532), .B(n9542), .C(clk_enable_2), 
         .D(temp1[3]), .Z(n6823)) /* synthesis lut_function=(A (C)+!A (B (C)+!B (C (D)))) */ ;
    defparam i3155_2_lut_3_lut_4_lut.init = 16'hf0e0;
    LUT4 i2_3_lut_4_lut (.A(temp1[2]), .B(temp1[3]), .C(temp1[0]), .D(temp1[1]), 
         .Z(n9021)) /* synthesis lut_function=(A+!(B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(568[13:23])
    defparam i2_3_lut_4_lut.init = 16'hbfff;
    LUT4 mux_1323_i9_4_lut (.A(n3100), .B(n9555), .C(n4585), .D(n5440), 
         .Z(n4527)) /* synthesis lut_function=(!(A (B (C))+!A (B (C+!(D))+!B !(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1323_i9_4_lut.init = 16'h3f3a;
    LUT4 i71_3_lut_4_lut_3_lut (.A(temp1[2]), .B(temp1[3]), .C(temp1[1]), 
         .Z(n68)) /* synthesis lut_function=(A (B+(C))+!A !(B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(568[13:23])
    defparam i71_3_lut_4_lut_3_lut.init = 16'hbdbd;
    FD1P3IX counter_i0_i13 (.D(n3095), .SP(clk_enable_157), .CD(n6020), 
            .CK(clk), .Q(counter[13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i13.GSR = "ENABLED";
    LUT4 i2_3_lut_4_lut_adj_89 (.A(next_state[0]), .B(next_state[1]), .C(next_state[2]), 
         .D(next_state[3]), .Z(clk_enable_13)) /* synthesis lut_function=(A (C+!(D))+!A ((C+!(D))+!B)) */ ;
    defparam i2_3_lut_4_lut_adj_89.init = 16'hf1ff;
    LUT4 i1651_4_lut (.A(n_temp1_7__N_364), .B(dat_rdy_N_1321), .C(n3903), 
         .D(n6823), .Z(n5298)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1651_4_lut.init = 16'heca0;
    CCU2D add_805_7 (.A0(dat_count[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8293), .COUT(n8294), .S0(n2030), .S1(n2029));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_805_7.INIT0 = 16'h5555;
    defparam add_805_7.INIT1 = 16'h5555;
    defparam add_805_7.INJECT1_0 = "NO";
    defparam add_805_7.INJECT1_1 = "NO";
    FD1S3IX c_state_FSM_i18 (.D(n5347), .CK(clk), .CD(n9558), .Q(n_temp1_7__N_347));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i18.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i17 (.D(n8558), .CK(clk), .CD(n9558), .Q(n_temp1_7__N_348));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i17.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i16 (.D(n5343), .CK(clk), .CD(n9558), .Q(n_temp1_7__N_349));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i16.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i15 (.D(n8876), .CK(clk), .CD(n9558), .Q(n_temp1_7__N_350));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i15.GSR = "ENABLED";
    FD1P3IX c_state_FSM_i14 (.D(n_temp1_7__N_350), .SP(clk_enable_2), .CD(n9558), 
            .CK(clk), .Q(n_temp1_7__N_351));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i14.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i13 (.D(n5337), .CK(clk), .CD(n9558), .Q(n_temp1_7__N_352));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i13.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i12 (.D(n5335), .CK(clk), .CD(n9558), .Q(n_temp1_7__N_353));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i12.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i11 (.D(n5333), .CK(clk), .CD(n9558), .Q(n_temp1_7__N_354));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i11.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i10 (.D(n5331), .CK(clk), .CD(n9558), .Q(n_temp1_7__N_355));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i10.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i9 (.D(n5329), .CK(clk), .CD(n9558), .Q(reg_rdy_N_1317));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i9.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i8 (.D(n8708), .CK(clk), .CD(n9558), .Q(n_temp1_7__N_357));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i8.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i7 (.D(n5325), .CK(clk), .CD(n9558), .Q(n_temp1_7__N_358));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i7.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i6 (.D(n8448), .CK(clk), .CD(n9558), .Q(dat_rdy_N_1321));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i6.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i5 (.D(n8586), .CK(clk), .CD(n9558), .Q(n_temp1_7__N_360));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i5.GSR = "ENABLED";
    FD1P3IX GPO_DATA_0___i1 (.D(temp3[0]), .SP(clk_enable_135), .CD(n9558), 
            .CK(clk), .Q(FlexIO01_c_0));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(625[8] 633[15])
    defparam GPO_DATA_0___i1.GSR = "ENABLED";
    LUT4 next_state_1__bdd_3_lut_4_lut (.A(extern_connected), .B(signals_debounced_syn[2]), 
         .C(next_state[0]), .D(next_state[1]), .Z(n9743)) /* synthesis lut_function=(!(A (B (C (D)+!C !(D))+!B !(C+(D)))+!A (C (D)+!C !(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1381[10:51])
    defparam next_state_1__bdd_3_lut_4_lut.init = 16'h2ff0;
    LUT4 i3_4_lut (.A(SD0_CD_c), .B(FP_UsrSW2_c), .C(FPIO_isoCtrlINTn_c), 
         .D(n8941), .Z(dummy_signal)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i3_4_lut.init = 16'h8000;
    LUT4 i56_4_lut (.A(n99), .B(n112_adj_1433), .C(n108_adj_1440), .D(n100), 
         .Z(n8941)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i56_4_lut.init = 16'h8000;
    CCU2D add_182_7 (.A0(\debounce_counters[3] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8248), .COUT(n8249), .S0(n443), 
          .S1(n442));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_7.INIT0 = 16'h5aaa;
    defparam add_182_7.INIT1 = 16'h5aaa;
    defparam add_182_7.INJECT1_0 = "NO";
    defparam add_182_7.INJECT1_1 = "NO";
    FD1S3IX temp1__i0 (.D(n_temp1[0]), .CK(clk), .CD(n9558), .Q(temp1[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp1__i0.GSR = "ENABLED";
    LUT4 mux_1323_i10_4_lut (.A(n3099), .B(n9555), .C(n4585), .D(n5440), 
         .Z(n4526)) /* synthesis lut_function=(!(A (B (C))+!A (B (C+!(D))+!B !(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1323_i10_4_lut.init = 16'h3f3a;
    FD1S3AY debounce_inputs_asyn2_i1 (.D(debounce_inputs_asyn1[1]), .CK(clk), 
            .Q(debounce_inputs_asyn2[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_inputs_asyn2_i1.GSR = "ENABLED";
    FD1P3IX pushed_i1 (.D(n9869), .SP(clk_enable_4), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(pushed[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam pushed_i1.GSR = "ENABLED";
    FD1S3AY signals_debounced_syn_i1 (.D(pushed_1__N_297), .CK(clk), .Q(next_state_3__N_1086[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam signals_debounced_syn_i1.GSR = "ENABLED";
    FD1S3AX externstop_falling_681 (.D(externstop_falling_N_1309), .CK(clk), 
            .Q(externstop_falling));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam externstop_falling_681.GSR = "ENABLED";
    FD1S3AX externstop_last_682 (.D(signals_debounced_syn[2]), .CK(clk), 
            .Q(externstop_last));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam externstop_last_682.GSR = "ENABLED";
    FD1S3AX resetnefb_683 (.D(resetcounter_24__N_1304), .CK(clk), .Q(resetnefb));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[2] 511[9])
    defparam resetnefb_683.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i3 (.D(n8554), .CK(clk), .CD(n9558), .Q(n_temp1_7__N_362));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i3.GSR = "ENABLED";
    LUT4 resetnefb_I_0_1_lut_rep_148 (.A(resetnefb), .Z(n9558)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(626[16:31])
    defparam resetnefb_I_0_1_lut_rep_148.init = 16'h5555;
    FD1S3IX c_state_FSM_i2 (.D(n5305), .CK(clk), .CD(n9558), .Q(n_temp1_7__N_363));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i2.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i0 (.D(FP_UsrSW1_c), .SP(clk_enable_125), .CD(n9558), 
            .CK(clk), .Q(GPI_DAT[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(644[8] 650[15])
    defparam GPI_DAT__i0.GSR = "ENABLED";
    FD1P3IX temp2__i0 (.D(wb_dat_o[0]), .SP(reg_rdy_N_1315), .CD(n9558), 
            .CK(clk), .Q(temp2[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp2__i0.GSR = "ENABLED";
    FD1P3IX temp3__i0 (.D(wb_dat_o[0]), .SP(dat_rdy_N_1319), .CD(n9558), 
            .CK(clk), .Q(temp3[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp3__i0.GSR = "ENABLED";
    LUT4 i42_4_lut (.A(DIGS3C_SlotD_SlotOK_c_2), .B(DIGS3C_SlotD_SlotOK_c_5), 
         .C(DIGS3C_SlotD_SlotOK_c_3), .D(DIG5S3C03_out), .Z(n99)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i42_4_lut.init = 16'h8000;
    FD1S3IX wb_dat_i__i0 (.D(n_wb_dat_i[0]), .CK(clk), .CD(n9558), .Q(wb_dat_i[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(768[1] 784[10])
    defparam wb_dat_i__i0.GSR = "ENABLED";
    FD1S3IX data0__i0 (.D(data0_7__N_892[0]), .CK(clk), .CD(n9558), .Q(data0[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[7] 572[14])
    defparam data0__i0.GSR = "ENABLED";
    LUT4 i55_4_lut (.A(n91), .B(n110_adj_1437), .C(n104), .D(n92), .Z(n112_adj_1433)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i55_4_lut.init = 16'h8000;
    LUT4 i51_4_lut (.A(n59), .B(n102), .C(n88), .D(n60), .Z(n108_adj_1440)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i51_4_lut.init = 16'h8000;
    FD1S3IX wb_adr_i__i1 (.D(n_wb_adr_i[0]), .CK(clk), .CD(n9558), .Q(wb_adr_i[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(768[1] 784[10])
    defparam wb_adr_i__i1.GSR = "ENABLED";
    FD1S3IX dat_count__i0 (.D(n_dat_count[0]), .CK(clk), .CD(n9558), .Q(dat_count[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(789[1] 803[10])
    defparam dat_count__i0.GSR = "ENABLED";
    BB BB1_scl (.I(i2c1_sclo), .T(i2c1_scloen), .B(SCL), .O(i2c1_scli)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=361, LSE_RLINE=361 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(154[14:16])
    FD1P3IX debounce_counters_1___i0 (.D(n236), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i0.GSR = "ENABLED";
    LUT4 i43_4_lut (.A(DIG5S3C29_out), .B(DIGS3C_SlotD_SlotOK_c_1), .C(FlexMIOs31_out), 
         .D(n58), .Z(n100)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i43_4_lut.init = 16'h8000;
    LUT4 i34_4_lut (.A(DIG5S3C02_out), .B(DIG5S3C26_out), .C(DIG5S3C24_out), 
         .D(DIG5S3C27_out), .Z(n91)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i34_4_lut.init = 16'h8000;
    BB BB1_sda (.I(i2c1_sdao), .T(i2c1_sdaoen), .B(SDA), .O(i2c1_sdai)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=361, LSE_RLINE=361 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(150[14:16])
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk)) /* synthesis NOM_FREQ="7", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "7";
    LUT4 i5175_4_lut (.A(n14), .B(n9543), .C(n9057), .D(n9), .Z(n_state_7__N_978[3])) /* synthesis lut_function=(A+(B (C)+!B (C (D)))) */ ;
    defparam i5175_4_lut.init = 16'hfaea;
    FD1P3IX debounce_counters_2___i0 (.D(n342), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i0.GSR = "ENABLED";
    LUT4 i1_4_lut (.A(n9532), .B(n9), .C(n9021), .D(n9554), .Z(n6797)) /* synthesis lut_function=(A+(B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut.init = 16'hfaea;
    LUT4 i1520_4_lut_4_lut (.A(resetnefb), .B(n4_adj_1444), .C(n9057), 
         .D(n9532), .Z(clk_enable_135)) /* synthesis lut_function=(!(A ((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(626[16:31])
    defparam i1520_4_lut_4_lut.init = 16'h555d;
    FD1P3IX counter_i0_i7 (.D(n4494), .SP(clk_enable_157), .CD(n6023), 
            .CK(clk), .Q(counter[7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i7.GSR = "ENABLED";
    LUT4 mux_1314_i13_4_lut (.A(next_state[1]), .B(n3096), .C(n4583), 
         .D(n4579), .Z(n4489)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1314_i13_4_lut.init = 16'hfaca;
    LUT4 i1521_3_lut_4_lut_4_lut (.A(resetnefb), .B(reg_rdy), .C(n9531), 
         .D(n9543), .Z(clk_enable_125)) /* synthesis lut_function=(!(A ((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(626[16:31])
    defparam i1521_3_lut_4_lut_4_lut.init = 16'h555d;
    CCU2D add_164_23 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8224), .COUT(n8225), .S0(n215), 
          .S1(n214));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_23.INIT0 = 16'h5aaa;
    defparam add_164_23.INIT1 = 16'h5aaa;
    defparam add_164_23.INJECT1_0 = "NO";
    defparam add_164_23.INJECT1_1 = "NO";
    LUT4 i53_4_lut (.A(n75), .B(n106_adj_1441), .C(n96), .D(n76_adj_1406), 
         .Z(n110_adj_1437)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i53_4_lut.init = 16'h8000;
    LUT4 i47_4_lut (.A(FlexLIO_c_5), .B(n94), .C(n72), .D(FlexMIOs27_out), 
         .Z(n104)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i47_4_lut.init = 16'h8000;
    LUT4 mux_1314_i19_4_lut (.A(next_state[1]), .B(n3090), .C(n4583), 
         .D(n4579), .Z(n4483)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1314_i19_4_lut.init = 16'hfaca;
    LUT4 i1_2_lut_rep_149 (.A(next_state[0]), .B(next_state_3__N_1086[2]), 
         .Z(n9559)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i1_2_lut_rep_149.init = 16'h4444;
    LUT4 i1_2_lut_3_lut_2_lut (.A(next_state[0]), .B(next_state_3__N_1086[2]), 
         .Z(n36_adj_1453)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;
    defparam i1_2_lut_3_lut_2_lut.init = 16'h6666;
    LUT4 i35_4_lut (.A(FPIO_FlexMIO29_out), .B(FlexLIO_c_1), .C(FlexLIO_c_0), 
         .D(FlexLIO_c_4), .Z(n92)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i35_4_lut.init = 16'h8000;
    LUT4 i18_2_lut (.A(TDnALERT_c), .B(DIGS3C_SlotD_SlotOK_c_4), .Z(n75)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i18_2_lut.init = 16'h8888;
    LUT4 mux_1314_i20_4_lut (.A(next_state[1]), .B(n3089), .C(n4583), 
         .D(n4579), .Z(n4482)) /* synthesis lut_function=(!(A (((D)+!C)+!B)+!A (B (C (D))+!B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1314_i20_4_lut.init = 16'h05c5;
    CCU2D add_164_7 (.A0(\debounce_counters[1] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8216), .COUT(n8217), .S0(n231), 
          .S1(n230));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_7.INIT0 = 16'h5aaa;
    defparam add_164_7.INIT1 = 16'h5aaa;
    defparam add_164_7.INJECT1_0 = "NO";
    defparam add_164_7.INJECT1_1 = "NO";
    CCU2D add_805_5 (.A0(dat_count[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8292), .COUT(n8293), .S0(n2032), .S1(n2031));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_805_5.INIT0 = 16'h5555;
    defparam add_805_5.INIT1 = 16'h5555;
    defparam add_805_5.INJECT1_0 = "NO";
    defparam add_805_5.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i6 (.D(n4495), .SP(clk_enable_157), .CD(n6023), 
            .CK(clk), .Q(counter[6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i6.GSR = "ENABLED";
    CCU2D add_805_3 (.A0(dat_count[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8291), .COUT(n8292), .S0(n2034), .S1(n2033));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_805_3.INIT0 = 16'h5555;
    defparam add_805_3.INIT1 = 16'h5555;
    defparam add_805_3.INJECT1_0 = "NO";
    defparam add_805_3.INJECT1_1 = "NO";
    CCU2D add_805_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n8291), .S1(n2035));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_805_1.INIT0 = 16'hF000;
    defparam add_805_1.INIT1 = 16'h5555;
    defparam add_805_1.INJECT1_0 = "NO";
    defparam add_805_1.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i5 (.D(n4496), .SP(clk_enable_157), .CD(n6023), 
            .CK(clk), .Q(counter[5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i5.GSR = "ENABLED";
    CCU2D add_164_21 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8223), .COUT(n8224), .S0(n217), 
          .S1(n216));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_21.INIT0 = 16'h5aaa;
    defparam add_164_21.INIT1 = 16'h5aaa;
    defparam add_164_21.INJECT1_0 = "NO";
    defparam add_164_21.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i4 (.D(n4497), .SP(clk_enable_157), .CD(n6023), 
            .CK(clk), .Q(counter[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i4.GSR = "ENABLED";
    CCU2D add_164_5 (.A0(\debounce_counters[1] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8215), .COUT(n8216), .S0(n233), 
          .S1(n232));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_5.INIT0 = 16'h5aaa;
    defparam add_164_5.INIT1 = 16'h5aaa;
    defparam add_164_5.INJECT1_0 = "NO";
    defparam add_164_5.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_129_3_lut (.A(next_state[0]), .B(next_state_3__N_1086[2]), 
         .C(next_state[1]), .Z(n9539)) /* synthesis lut_function=(!(A+((C)+!B))) */ ;
    defparam i1_2_lut_rep_129_3_lut.init = 16'h0404;
    FD1P3IX counter_i0_i11 (.D(n4490), .SP(clk_enable_157), .CD(n6023), 
            .CK(clk), .Q(counter[11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i11.GSR = "ENABLED";
    CCU2D add_164_3 (.A0(\debounce_counters[1] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8214), .COUT(n8215), .S0(n235), 
          .S1(n234));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_3.INIT0 = 16'h5aaa;
    defparam add_164_3.INIT1 = 16'h5aaa;
    defparam add_164_3.INJECT1_0 = "NO";
    defparam add_164_3.INJECT1_1 = "NO";
    CCU2D add_164_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[1] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n8214), .S1(n236));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_1.INIT0 = 16'hF000;
    defparam add_164_1.INIT1 = 16'h5555;
    defparam add_164_1.INJECT1_0 = "NO";
    defparam add_164_1.INJECT1_1 = "NO";
    CCU2D add_182_5 (.A0(\debounce_counters[3] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8247), .COUT(n8248), .S0(n445), 
          .S1(n444));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_5.INIT0 = 16'h5aaa;
    defparam add_182_5.INIT1 = 16'h5aaa;
    defparam add_182_5.INJECT1_0 = "NO";
    defparam add_182_5.INJECT1_1 = "NO";
    CCU2D add_806_25 (.A0(counter[23]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[24]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8289), .S0(n3085), .S1(n3084));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1487[17:24])
    defparam add_806_25.INIT0 = 16'h5555;
    defparam add_806_25.INIT1 = 16'h5555;
    defparam add_806_25.INJECT1_0 = "NO";
    defparam add_806_25.INJECT1_1 = "NO";
    FD1P3AX DIGS3C_Shared_ReqSafeState_707 (.D(DIGS3C_Shared_ReqSafeState_N_1295), 
            .SP(clk_enable_13), .CK(clk), .Q(DIGS3C_Shared_ReqSafeState_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam DIGS3C_Shared_ReqSafeState_707.GSR = "ENABLED";
    FD1P3AX FP_SysLEDb_710 (.D(FP_SysLEDb_N_1283), .SP(clk_enable_15), .CK(clk), 
            .Q(FP_SysLEDb_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam FP_SysLEDb_710.GSR = "ENABLED";
    FD1P3AX FP_SysLEDg_711 (.D(FP_SysLEDg_N_1281), .SP(clk_enable_15), .CK(clk), 
            .Q(FP_SysLEDg_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam FP_SysLEDg_711.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn1_i1 (.D(SysSW_Pwr_NC_c), .CK(clk), .Q(debounce_inputs_asyn1[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_inputs_asyn1_i1.GSR = "ENABLED";
    FD1P3AX Carrier_PwrOn_713 (.D(Carrier_PwrOn_N_1300), .SP(clk_enable_17), 
            .CK(clk), .Q(Carrier_PwrOn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam Carrier_PwrOn_713.GSR = "ENABLED";
    FD1P3AX Carrier_PG_3V3_714 (.D(Carrier_PwrOn_N_1300), .SP(clk_enable_17), 
            .CK(clk), .Q(Carrier_PG_3V3_c)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam Carrier_PG_3V3_714.GSR = "ENABLED";
    LUT4 mux_1323_i21_4_lut (.A(n4415), .B(n9555), .C(n4585), .D(n4583), 
         .Z(n4515)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1323_i21_4_lut.init = 16'h3a30;
    FD1S3IX c_state_FSM_i4 (.D(n8564), .CK(clk), .CD(n9558), .Q(n_temp1_7__N_361));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i4.GSR = "ENABLED";
    BB FPIO_FlexMIO28_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO28), 
       .O(FPIO_FlexMIO28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    LUT4 i1_4_lut_adj_90 (.A(temp1[6]), .B(data0[2]), .C(n30_adj_1411), 
         .D(n33_adj_1412), .Z(data0_7__N_892[2])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_4_lut_adj_90.init = 16'hdc50;
    FD1S3IX c_state_FSM_i1 (.D(n5298), .CK(clk), .CD(n9558), .Q(n_temp1_7__N_364));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i1.GSR = "ENABLED";
    CCU2D add_806_23 (.A0(counter[21]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[22]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8288), .COUT(n8289), .S0(n3087), .S1(n3086));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1487[17:24])
    defparam add_806_23.INIT0 = 16'h5555;
    defparam add_806_23.INIT1 = 16'h5555;
    defparam add_806_23.INJECT1_0 = "NO";
    defparam add_806_23.INJECT1_1 = "NO";
    LUT4 i3222_2_lut (.A(n3088), .B(n4579), .Z(n4415)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam i3222_2_lut.init = 16'heeee;
    LUT4 i49_4_lut (.A(FPIO_FlexMIO28_out), .B(n98), .C(n80), .D(FPIO_FlexMIO30_out), 
         .Z(n106_adj_1441)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i49_4_lut.init = 16'h8000;
    CCU2D add_806_21 (.A0(counter[19]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[20]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8287), .COUT(n8288), .S0(n3089), .S1(n3088));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1487[17:24])
    defparam add_806_21.INIT0 = 16'h5555;
    defparam add_806_21.INIT1 = 16'h5555;
    defparam add_806_21.INJECT1_0 = "NO";
    defparam add_806_21.INJECT1_1 = "NO";
    PFUMX mux_1099_Mux_7_i15 (.BLUT(n7_adj_1452), .ALUT(n14_adj_1451), .C0(next_state[3]), 
          .Z(FP_SysLEDb_N_1283));
    LUT4 mux_1314_i7_4_lut (.A(next_state[1]), .B(n3102), .C(n4583), .D(n4579), 
         .Z(n4495)) /* synthesis lut_function=(!(A (((D)+!C)+!B)+!A (B (C (D))+!B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1314_i7_4_lut.init = 16'h05c5;
    LUT4 i39_4_lut (.A(DIG5S3C04_out), .B(DIG5S3C25_out), .C(DIG5S3C05_out), 
         .D(FPIO_FlexMIO27_out), .Z(n96)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i39_4_lut.init = 16'h8000;
    FD1S3AY debounce_inputs_asyn1_i4 (.D(FP_UsrSW1_c), .CK(clk), .Q(debounce_inputs_asyn1[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_inputs_asyn1_i4.GSR = "ENABLED";
    LUT4 i19_2_lut (.A(DIG5S3C00_out), .B(DIG5S3C01_out), .Z(n76_adj_1406)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i19_2_lut.init = 16'h8888;
    LUT4 mux_1314_i23_4_lut (.A(next_state[1]), .B(n3086), .C(n4583), 
         .D(n4579), .Z(n4479)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1314_i23_4_lut.init = 16'hf5c5;
    LUT4 mux_1323_i24_4_lut (.A(n4412), .B(n9555), .C(n4585), .D(n4583), 
         .Z(n4512)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1323_i24_4_lut.init = 16'h3a30;
    LUT4 i3225_2_lut (.A(n3085), .B(n4579), .Z(n4412)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam i3225_2_lut.init = 16'heeee;
    FD1S3AY debounce_inputs_asyn1_i3 (.D(FP_UsrSW3_c), .CK(clk), .Q(debounce_inputs_asyn1[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_inputs_asyn1_i3.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn1_i2 (.D(FlexMio61ExternalStop_c_c), .CK(clk), 
            .Q(debounce_inputs_asyn1[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_inputs_asyn1_i2.GSR = "ENABLED";
    LUT4 mux_1323_i25_4_lut (.A(n3084), .B(n9555), .C(n4585), .D(n5440), 
         .Z(n4511)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1323_i25_4_lut.init = 16'h303a;
    LUT4 i1_4_lut_adj_91 (.A(externstop_falling), .B(next_state[3]), .C(signals_debounced_syn[3]), 
         .D(next_state_3__N_1086[2]), .Z(n67)) /* synthesis lut_function=(A+!(B ((D)+!C)+!B !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(134[12:22])
    defparam i1_4_lut_adj_91.init = 16'hbafa;
    LUT4 i2_3_lut_rep_119_4_lut (.A(temp1[6]), .B(n9533), .C(temp1[0]), 
         .D(n9543), .Z(n9529)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i2_3_lut_rep_119_4_lut.init = 16'hfffe;
    PFUMX i5258 (.BLUT(n9279), .ALUT(n9278), .C0(next_state[2]), .Z(next_state_3__N_64[3]));
    CCU2D add_806_19 (.A0(counter[17]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[18]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8286), .COUT(n8287), .S0(n3091), .S1(n3090));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1487[17:24])
    defparam add_806_19.INIT0 = 16'h5555;
    defparam add_806_19.INIT1 = 16'h5555;
    defparam add_806_19.INJECT1_0 = "NO";
    defparam add_806_19.INJECT1_1 = "NO";
    CCU2D add_164_19 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8222), .COUT(n8223), .S0(n219), 
          .S1(n218));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_19.INIT0 = 16'h5aaa;
    defparam add_164_19.INIT1 = 16'h5aaa;
    defparam add_164_19.INJECT1_0 = "NO";
    defparam add_164_19.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_92 (.A(n_state_7__N_978[3]), .B(n76), .C(reg_rdy_N_1317), 
         .D(n9523), .Z(n4_adj_1438)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(319[17:24])
    defparam i1_4_lut_adj_92.init = 16'hb3a0;
    CCU2D add_806_17 (.A0(counter[15]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[16]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8285), .COUT(n8286), .S0(n3093), .S1(n3092));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1487[17:24])
    defparam add_806_17.INIT0 = 16'h5555;
    defparam add_806_17.INIT1 = 16'h5555;
    defparam add_806_17.INJECT1_0 = "NO";
    defparam add_806_17.INJECT1_1 = "NO";
    CCU2D add_806_15 (.A0(counter[13]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[14]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8284), .COUT(n8285), .S0(n3095), .S1(n3094));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1487[17:24])
    defparam add_806_15.INIT0 = 16'h5555;
    defparam add_806_15.INIT1 = 16'h5555;
    defparam add_806_15.INJECT1_0 = "NO";
    defparam add_806_15.INJECT1_1 = "NO";
    LUT4 i1_3_lut (.A(next_state[1]), .B(next_state_3__N_1086[2]), .C(FPIO_isoCtrlRSTn_N_1288), 
         .Z(n5990)) /* synthesis lut_function=(!(A (C)+!A (B))) */ ;
    defparam i1_3_lut.init = 16'h1b1b;
    CCU2D add_182_3 (.A0(\debounce_counters[3] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8246), .COUT(n8247), .S0(n447), 
          .S1(n446));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_3.INIT0 = 16'h5aaa;
    defparam add_182_3.INIT1 = 16'h5aaa;
    defparam add_182_3.INJECT1_0 = "NO";
    defparam add_182_3.INJECT1_1 = "NO";
    LUT4 n7_bdd_4_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_1086[2]), 
         .C(next_state[1]), .D(n9538), .Z(n9520)) /* synthesis lut_function=(A (B (C+!(D))+!B !(C))+!A !(B (C+(D)))) */ ;
    defparam n7_bdd_4_lut_4_lut.init = 16'h939f;
    LUT4 i41_4_lut (.A(FlexMIOs33_out), .B(FlexMIOs54_out), .C(FlexMIOs35_out), 
         .D(SPI_S3C_nCS_USR_c), .Z(n98)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i41_4_lut.init = 16'h8000;
    FD1P3IX debounce_counters_4___i31 (.D(n523), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i31.GSR = "ENABLED";
    LUT4 i23_2_lut (.A(FlexLIO_c_3), .B(FlexMIOs32_out), .Z(n80)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i23_2_lut.init = 16'h8888;
    LUT4 i1_2_lut (.A(externstop_falling), .B(signals_debounced_syn[3]), 
         .Z(n6540)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam i1_2_lut.init = 16'heeee;
    LUT4 i1_2_lut_rep_150 (.A(n_state_7__N_1034[4]), .B(wb_dat_o[2]), .Z(n9560)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam i1_2_lut_rep_150.init = 16'h2222;
    LUT4 i2_2_lut (.A(SD1_CD_c), .B(PG_VIN_c), .Z(n59)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i2_2_lut.init = 16'h8888;
    LUT4 i45_4_lut (.A(FlexMIOs29_out), .B(n90), .C(n64), .D(FlexMIOs45_c), 
         .Z(n102)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i45_4_lut.init = 16'h8000;
    LUT4 i31_4_lut (.A(DIG5S3C28_out), .B(FlexMIOs26_out), .C(FlexLIO_c_2), 
         .D(FlexMIOs28_out), .Z(n88)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i31_4_lut.init = 16'h8000;
    LUT4 i3_2_lut (.A(ANL_S3C_SLOTOK_c_1), .B(ANL_S3C_SLOTOK_c_2), .Z(n60)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i3_2_lut.init = 16'h8888;
    LUT4 i33_4_lut (.A(S3CsI2C_SDA_c), .B(TDnSHDN_c), .C(TDnFFnFS_c), 
         .D(ANL_S3C_P54_Legacy_c), .Z(n90)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i33_4_lut.init = 16'h8000;
    LUT4 i7_2_lut (.A(PG_Module_c), .B(S3CsI2C_SCL_c), .Z(n64)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i7_2_lut.init = 16'h8888;
    LUT4 i1_2_lut_adj_93 (.A(ANL_S3C_SLOTOK_c_3), .B(FlexMIOs30_out), .Z(n58)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i1_2_lut_adj_93.init = 16'h8888;
    CCU2D add_806_13 (.A0(counter[11]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[12]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8283), .COUT(n8284), .S0(n3097), .S1(n3096));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1487[17:24])
    defparam add_806_13.INIT0 = 16'h5555;
    defparam add_806_13.INIT1 = 16'h5555;
    defparam add_806_13.INJECT1_0 = "NO";
    defparam add_806_13.INJECT1_1 = "NO";
    CCU2D add_806_11 (.A0(counter[9]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[10]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8282), .COUT(n8283), .S0(n3099), .S1(n3098));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1487[17:24])
    defparam add_806_11.INIT0 = 16'h5555;
    defparam add_806_11.INIT1 = 16'h5555;
    defparam add_806_11.INJECT1_0 = "NO";
    defparam add_806_11.INJECT1_1 = "NO";
    LUT4 i1678_4_lut (.A(n_temp1_7__N_358), .B(n6936), .C(n3840), .D(n8987), 
         .Z(n5325)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1678_4_lut.init = 16'hb3a0;
    PFUMX i5256 (.BLUT(n9276), .ALUT(n9275), .C0(FPIO_isoCtrlRSTn_N_1288), 
          .Z(n9277));
    CCU2D add_164_17 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8221), .COUT(n8222), .S0(n221), 
          .S1(n220));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_17.INIT0 = 16'h5aaa;
    defparam add_164_17.INIT1 = 16'h5aaa;
    defparam add_164_17.INJECT1_0 = "NO";
    defparam add_164_17.INJECT1_1 = "NO";
    CCU2D add_182_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[3] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n8246), .S1(n448));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_1.INIT0 = 16'hF000;
    defparam add_182_1.INIT1 = 16'h5555;
    defparam add_182_1.INJECT1_0 = "NO";
    defparam add_182_1.INJECT1_1 = "NO";
    LUT4 i37_4_lut (.A(FlexMIOs37_out), .B(FlexMIOs63_out), .C(FlexMIOs62_out), 
         .D(S3C_S1_c), .Z(n94)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i37_4_lut.init = 16'h8000;
    LUT4 i15_2_lut (.A(FlexMIOs34_out), .B(FlexMIOs36_out), .Z(n72)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(402[17] 416[39])
    defparam i15_2_lut.init = 16'h8888;
    LUT4 i1517_2_lut (.A(clk_enable_126), .B(debounce_inputs_asyn2[4]), 
         .Z(clk_enable_56)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i1517_2_lut.init = 16'hdddd;
    PFUMX i5376 (.BLUT(n9510), .ALUT(n9508), .C0(next_state[3]), .Z(clk_enable_137));
    CCU2D add_4442_28 (.A0(\debounce_counters[4] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8359), .S1(clk_enable_126));
    defparam add_4442_28.INIT0 = 16'hf555;
    defparam add_4442_28.INIT1 = 16'h0000;
    defparam add_4442_28.INJECT1_0 = "NO";
    defparam add_4442_28.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i3 (.D(n3105), .SP(clk_enable_157), .CD(n6020), 
            .CK(clk), .Q(counter[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i3.GSR = "ENABLED";
    LUT4 i2_4_lut (.A(n76), .B(n9532), .C(n9526), .D(n9021), .Z(n6936)) /* synthesis lut_function=(A (B (C)+!B (C (D)))) */ ;
    defparam i2_4_lut.init = 16'ha080;
    FD1P3IX counter_i0_i2 (.D(n3106), .SP(clk_enable_157), .CD(n6020), 
            .CK(clk), .Q(counter[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i2.GSR = "ENABLED";
    FD1P3IX counter_i0_i10 (.D(n4491), .SP(clk_enable_157), .CD(n6023), 
            .CK(clk), .Q(counter[10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i10.GSR = "ENABLED";
    LUT4 i1_2_lut_3_lut_4_lut (.A(n_state_7__N_1034[4]), .B(wb_dat_o[2]), 
         .C(n6797), .D(n15_adj_1407), .Z(n8998)) /* synthesis lut_function=(!((B+!(C+(D)))+!A)) */ ;
    defparam i1_2_lut_3_lut_4_lut.init = 16'h2220;
    FD1P3IX debounce_counters_4___i30 (.D(n524), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i29 (.D(n525), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i28 (.D(n526), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i28.GSR = "ENABLED";
    FD1P3IX counter_i0_i1 (.D(n3107), .SP(clk_enable_157), .CD(n6020), 
            .CK(clk), .Q(counter[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i1.GSR = "ENABLED";
    LUT4 i929_2_lut_rep_125_3_lut_4_lut (.A(n_state_7__N_1034[4]), .B(wb_dat_o[2]), 
         .C(wb_stb_i), .D(wb_ack_o), .Z(n9535)) /* synthesis lut_function=(!(A (B (C (D)))+!A (C (D)))) */ ;
    defparam i929_2_lut_rep_125_3_lut_4_lut.init = 16'h2fff;
    FD1P3IX counter_i0_i0 (.D(n3108), .SP(clk_enable_157), .CD(n6020), 
            .CK(clk), .Q(counter[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i0.GSR = "ENABLED";
    LUT4 i1_2_lut_adj_94 (.A(n4579), .B(n4583), .Z(n5440)) /* synthesis lut_function=(A+!(B)) */ ;
    defparam i1_2_lut_adj_94.init = 16'hbbbb;
    FD1P3IX debounce_counters_4___i27 (.D(n527), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i26 (.D(n528), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i25 (.D(n529), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i25.GSR = "ENABLED";
    LUT4 i2_4_lut_adj_95 (.A(wb_dat_o[2]), .B(n4_adj_1454), .C(clk_enable_2), 
         .D(n8985), .Z(n8448)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i2_4_lut_adj_95.init = 16'heccc;
    LUT4 i1_4_lut_adj_96 (.A(n6936), .B(dat_rdy_N_1321), .C(n8987), .D(clk_enable_2), 
         .Z(n4_adj_1454)) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_96.init = 16'ha0ec;
    LUT4 select_1233_Select_7_i11_3_lut_4_lut_4_lut (.A(clk_enable_2), .B(n_temp1_7__N_347), 
         .C(data0[7]), .D(n_temp1_7__N_360), .Z(n_wb_dat_i[7])) /* synthesis lut_function=(!(A+!(B+(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam select_1233_Select_7_i11_3_lut_4_lut_4_lut.init = 16'h5444;
    CCU2D add_173_33 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8245), .S0(n311));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_33.INIT0 = 16'h5aaa;
    defparam add_173_33.INIT1 = 16'h0000;
    defparam add_173_33.INJECT1_0 = "NO";
    defparam add_173_33.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i24 (.D(n530), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i23 (.D(n531), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i22 (.D(n532), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i22.GSR = "ENABLED";
    LUT4 i19_4_lut (.A(n_temp1_7__N_360), .B(n1), .C(clk_enable_2), .D(n8977), 
         .Z(n8586)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i19_4_lut.init = 16'hfaca;
    CCU2D add_806_9 (.A0(counter[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[8]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8281), .COUT(n8282), .S0(n3101), .S1(n3100));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1487[17:24])
    defparam add_806_9.INIT0 = 16'h5555;
    defparam add_806_9.INIT1 = 16'h5555;
    defparam add_806_9.INJECT1_0 = "NO";
    defparam add_806_9.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i21 (.D(n533), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i20 (.D(n534), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i20.GSR = "ENABLED";
    CCU2D add_806_7 (.A0(counter[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8280), .COUT(n8281), .S0(n3103), .S1(n3102));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1487[17:24])
    defparam add_806_7.INIT0 = 16'h5555;
    defparam add_806_7.INIT1 = 16'h5555;
    defparam add_806_7.INJECT1_0 = "NO";
    defparam add_806_7.INJECT1_1 = "NO";
    LUT4 i1_2_lut_adj_97 (.A(wb_dat_o[4]), .B(n_temp1_7__N_358), .Z(n1)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_2_lut_adj_97.init = 16'h8888;
    LUT4 i1516_2_lut (.A(clk_enable_127), .B(debounce_inputs_asyn2[3]), 
         .Z(clk_enable_188)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i1516_2_lut.init = 16'hdddd;
    CCU2D add_4442_26 (.A0(\debounce_counters[4] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8358), .COUT(n8359));
    defparam add_4442_26.INIT0 = 16'h5555;
    defparam add_4442_26.INIT1 = 16'h5555;
    defparam add_4442_26.INJECT1_0 = "NO";
    defparam add_4442_26.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i19 (.D(n535), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i19.GSR = "ENABLED";
    FD1S3IX dat_rdy_del_688 (.D(dat_rdy), .CK(clk), .CD(n9558), .Q(dat_rdy_del));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(537[7] 550[11])
    defparam dat_rdy_del_688.GSR = "ENABLED";
    LUT4 i5128_2_lut (.A(next_state[3]), .B(next_state[1]), .Z(n9045)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i5128_2_lut.init = 16'heeee;
    LUT4 i54_4_lut (.A(next_state[1]), .B(n27), .C(next_state[3]), .D(FPIO_isoCtrlRSTn_N_1288), 
         .Z(n33)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;
    defparam i54_4_lut.init = 16'hcac0;
    LUT4 FPIO_isoCtrlRSTn_N_1288_bdd_4_lut_5262 (.A(n67), .B(next_state[0]), 
         .C(next_state[1]), .D(next_state_3__N_1086[2]), .Z(n9276)) /* synthesis lut_function=(A (B (C)+!B !(C+(D)))+!A (B+(C+!(D)))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1288_bdd_4_lut_5262.init = 16'hd4d7;
    LUT4 i1864_2_lut_3_lut_4_lut (.A(n_temp1_7__N_347), .B(n9550), .C(clk_enable_2), 
         .D(n_temp1_7__N_360), .Z(n_wb_we_i)) /* synthesis lut_function=(!(A (C)+!A (B (C)+!B (C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1864_2_lut_3_lut_4_lut.init = 16'h0f0e;
    CCU2D add_4442_24 (.A0(\debounce_counters[4] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8357), .COUT(n8358));
    defparam add_4442_24.INIT0 = 16'h5555;
    defparam add_4442_24.INIT1 = 16'h5555;
    defparam add_4442_24.INJECT1_0 = "NO";
    defparam add_4442_24.INJECT1_1 = "NO";
    FD1S3IX wb_we_i_701 (.D(n_wb_we_i), .CK(clk), .CD(n9558), .Q(wb_we_i));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(768[1] 784[10])
    defparam wb_we_i_701.GSR = "ENABLED";
    FD1S3IX wb_stb_i_699 (.D(n_wb_stb_i), .CK(clk), .CD(n9558), .Q(wb_stb_i));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(768[1] 784[10])
    defparam wb_stb_i_699.GSR = "ENABLED";
    FD1S3IX dat_rdy_687 (.D(dat_rdy_N_1319), .CK(clk), .CD(n9558), .Q(dat_rdy));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(537[7] 550[11])
    defparam dat_rdy_687.GSR = "ENABLED";
    LUT4 next_state_1__bdd_4_lut_5348 (.A(next_state[1]), .B(next_state[2]), 
         .C(next_state[0]), .D(next_state[3]), .Z(clk_enable_148)) /* synthesis lut_function=(A (B (C+(D)))+!A (B ((D)+!C)+!B !(C+(D)))) */ ;
    defparam next_state_1__bdd_4_lut_5348.init = 16'hcc85;
    FD1P3AX i667_719 (.D(Carrier_PG_1V8_N_1403), .SP(Carrier_PG_1V8_N_1396), 
            .CK(clk), .Q(Carrier_PG_1V8_N_1294));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam i667_719.GSR = "ENABLED";
    CCU2D add_173_31 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8244), .COUT(n8245), .S0(n313), 
          .S1(n312));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_31.INIT0 = 16'h5aaa;
    defparam add_173_31.INIT1 = 16'h5aaa;
    defparam add_173_31.INJECT1_0 = "NO";
    defparam add_173_31.INJECT1_1 = "NO";
    FD1S3IX reg_rdy_685 (.D(reg_rdy_N_1315), .CK(clk), .CD(n9558), .Q(reg_rdy));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(519[1] 532[9])
    defparam reg_rdy_685.GSR = "ENABLED";
    LUT4 i1_4_lut_adj_98 (.A(n_temp1_7__N_360), .B(dat_count[0]), .C(n2035), 
         .D(n9525), .Z(n12_adj_1415)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_98.init = 16'ha088;
    CCU2D add_4442_22 (.A0(\debounce_counters[4] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8356), .COUT(n8357));
    defparam add_4442_22.INIT0 = 16'h5555;
    defparam add_4442_22.INIT1 = 16'h5555;
    defparam add_4442_22.INJECT1_0 = "NO";
    defparam add_4442_22.INJECT1_1 = "NO";
    CCU2D add_164_15 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8220), .COUT(n8221), .S0(n223), 
          .S1(n222));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_15.INIT0 = 16'h5aaa;
    defparam add_164_15.INIT1 = 16'h5aaa;
    defparam add_164_15.INJECT1_0 = "NO";
    defparam add_164_15.INJECT1_1 = "NO";
    CCU2D add_173_29 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8243), .COUT(n8244), .S0(n315), 
          .S1(n314));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_29.INIT0 = 16'h5aaa;
    defparam add_173_29.INIT1 = 16'h5aaa;
    defparam add_173_29.INJECT1_0 = "NO";
    defparam add_173_29.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_116_3_lut_4_lut (.A(temp1[6]), .B(n9533), .C(n9543), 
         .D(n9542), .Z(n9526)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_2_lut_rep_116_3_lut_4_lut.init = 16'hfffe;
    LUT4 i2_4_lut_adj_99 (.A(dat_count[7]), .B(n12_adj_1442), .C(n17), 
         .D(n15_adj_1436), .Z(n_dat_count[7])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i2_4_lut_adj_99.init = 16'hffec;
    LUT4 i1_4_lut_adj_100 (.A(n_temp1_7__N_360), .B(dat_count[7]), .C(n2028), 
         .D(n9525), .Z(n12_adj_1442)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_100.init = 16'ha088;
    FD1P3IX debounce_counters_3___i0 (.D(n448), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i0.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i0 (.D(n130), .CK(clk), .Q(n25)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i0.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i18 (.D(n536), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i17 (.D(n537), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i16 (.D(n538), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i15 (.D(n539), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i15.GSR = "ENABLED";
    CCU2D add_806_5 (.A0(counter[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8279), .COUT(n8280), .S0(n3105), .S1(n3104));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1487[17:24])
    defparam add_806_5.INIT0 = 16'h5555;
    defparam add_806_5.INIT1 = 16'h5555;
    defparam add_806_5.INJECT1_0 = "NO";
    defparam add_806_5.INJECT1_1 = "NO";
    FD1P3AX next_state_i1 (.D(next_state_3__N_64[1]), .SP(clk_enable_41), 
            .CK(clk), .Q(next_state[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam next_state_i1.GSR = "ENABLED";
    LUT4 i1690_4_lut_4_lut (.A(clk_enable_2), .B(wb_dat_o[2]), .C(n_temp1_7__N_351), 
         .D(n_temp1_7__N_352), .Z(n5337)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A (D)) */ ;
    defparam i1690_4_lut_4_lut.init = 16'hf7a0;
    LUT4 i1_4_lut_adj_101 (.A(dat_rdy_N_1321), .B(dat_count[0]), .C(n2035), 
         .D(n6823), .Z(n15_adj_1409)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_101.init = 16'ha088;
    FD1P3IX debounce_counters_4___i14 (.D(n540), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i13 (.D(n541), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i12 (.D(n542), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i11 (.D(n543), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i10 (.D(n544), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i9 (.D(n545), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i8 (.D(n546), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i7 (.D(n547), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i6 (.D(n548), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i5 (.D(n549), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i4 (.D(n550), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i3 (.D(n551), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i2 (.D(n552), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i1 (.D(n553), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i0 (.D(n554), .SP(clk_enable_56), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_4___i0.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i31 (.D(n311), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i31.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i30 (.D(n312), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i29 (.D(n313), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i28 (.D(n314), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i27 (.D(n315), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i26 (.D(n316), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i25 (.D(n317), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i25.GSR = "ENABLED";
    PFUMX i5369 (.BLUT(n9496), .ALUT(n9495), .C0(next_state[1]), .Z(n9497));
    LUT4 i56_4_lut_adj_102 (.A(GPI_DAT[2]), .B(data0[2]), .C(temp1[5]), 
         .D(n5735), .Z(n30_adj_1411)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i56_4_lut_adj_102.init = 16'hcac0;
    FD1P3IX debounce_counters_2___i24 (.D(n318), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i23 (.D(n319), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i22 (.D(n320), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i21 (.D(n321), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i20 (.D(n322), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i19 (.D(n323), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i18 (.D(n324), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i17 (.D(n325), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i16 (.D(n326), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i15 (.D(n327), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i14 (.D(n328), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i13 (.D(n329), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i12 (.D(n330), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i11 (.D(n331), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i10 (.D(n332), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i9 (.D(n333), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i8 (.D(n334), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i7 (.D(n335), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i6 (.D(n336), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i5 (.D(n337), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i4 (.D(n338), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i3 (.D(n339), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i2 (.D(n340), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i1 (.D(n341), .SP(clk_enable_87), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_2___i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i31 (.D(n205), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i31.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i30 (.D(n206), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i29 (.D(n207), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i28 (.D(n208), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i27 (.D(n209), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i26 (.D(n210), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i25 (.D(n211), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i24 (.D(n212), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i23 (.D(n213), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i22 (.D(n214), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i21 (.D(n215), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i20 (.D(n216), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i19 (.D(n217), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i18 (.D(n218), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i17 (.D(n219), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i16 (.D(n220), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i15 (.D(n221), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i14 (.D(n222), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i13 (.D(n223), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i12 (.D(n224), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i11 (.D(n225), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i10 (.D(n226), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i9 (.D(n227), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i8 (.D(n228), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i7 (.D(n229), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i6 (.D(n230), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i5 (.D(n231), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i4 (.D(n232), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i3 (.D(n233), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i2 (.D(n234), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i1 (.D(n235), .SP(clk_enable_118), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_1___i1.GSR = "ENABLED";
    FD1S3IX dat_count__i7 (.D(n_dat_count[7]), .CK(clk), .CD(n9558), .Q(dat_count[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(789[1] 803[10])
    defparam dat_count__i7.GSR = "ENABLED";
    FD1S3IX dat_count__i6 (.D(n_dat_count[6]), .CK(clk), .CD(n9558), .Q(dat_count[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(789[1] 803[10])
    defparam dat_count__i6.GSR = "ENABLED";
    FD1S3IX dat_count__i5 (.D(n_dat_count[5]), .CK(clk), .CD(n9558), .Q(dat_count[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(789[1] 803[10])
    defparam dat_count__i5.GSR = "ENABLED";
    FD1S3IX dat_count__i4 (.D(n_dat_count[4]), .CK(clk), .CD(n9558), .Q(dat_count[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(789[1] 803[10])
    defparam dat_count__i4.GSR = "ENABLED";
    FD1S3IX dat_count__i3 (.D(n_dat_count[3]), .CK(clk), .CD(n9558), .Q(dat_count[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(789[1] 803[10])
    defparam dat_count__i3.GSR = "ENABLED";
    FD1S3IX dat_count__i2 (.D(n_dat_count[2]), .CK(clk), .CD(n9558), .Q(dat_count[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(789[1] 803[10])
    defparam dat_count__i2.GSR = "ENABLED";
    FD1S3IX dat_count__i1 (.D(n_dat_count[1]), .CK(clk), .CD(n9558), .Q(dat_count[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(789[1] 803[10])
    defparam dat_count__i1.GSR = "ENABLED";
    FD1S3IX wb_adr_i__i4 (.D(n_wb_adr_i[6]), .CK(clk), .CD(n9558), .Q(wb_adr_i[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(768[1] 784[10])
    defparam wb_adr_i__i4.GSR = "ENABLED";
    FD1S3IX wb_adr_i__i3 (.D(n_wb_adr_i[2]), .CK(clk), .CD(n9558), .Q(wb_adr_i[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(768[1] 784[10])
    defparam wb_adr_i__i3.GSR = "ENABLED";
    FD1S3IX wb_adr_i__i2 (.D(n_wb_adr_i[1]), .CK(clk), .CD(n9558), .Q(wb_adr_i[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(768[1] 784[10])
    defparam wb_adr_i__i2.GSR = "ENABLED";
    FD1S3IX data0__i7 (.D(data0_7__N_892[7]), .CK(clk), .CD(n9558), .Q(data0[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[7] 572[14])
    defparam data0__i7.GSR = "ENABLED";
    FD1S3IX data0__i6 (.D(data0_7__N_892[6]), .CK(clk), .CD(n9558), .Q(data0[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[7] 572[14])
    defparam data0__i6.GSR = "ENABLED";
    FD1S3IX data0__i5 (.D(data0_7__N_892[5]), .CK(clk), .CD(n9558), .Q(data0[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[7] 572[14])
    defparam data0__i5.GSR = "ENABLED";
    FD1S3IX data0__i4 (.D(data0_7__N_892[4]), .CK(clk), .CD(n9558), .Q(data0[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[7] 572[14])
    defparam data0__i4.GSR = "ENABLED";
    FD1S3IX data0__i3 (.D(data0_7__N_892[3]), .CK(clk), .CD(n9558), .Q(data0[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[7] 572[14])
    defparam data0__i3.GSR = "ENABLED";
    FD1S3IX data0__i2 (.D(data0_7__N_892[2]), .CK(clk), .CD(n9558), .Q(data0[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[7] 572[14])
    defparam data0__i2.GSR = "ENABLED";
    FD1S3IX data0__i1 (.D(data0_7__N_892[1]), .CK(clk), .CD(n9558), .Q(data0[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[7] 572[14])
    defparam data0__i1.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i7 (.D(n_wb_dat_i[7]), .CK(clk), .CD(n9558), .Q(wb_dat_i[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(768[1] 784[10])
    defparam wb_dat_i__i7.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i6 (.D(n_wb_dat_i[6]), .CK(clk), .CD(n9558), .Q(wb_dat_i[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(768[1] 784[10])
    defparam wb_dat_i__i6.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i5 (.D(n_wb_dat_i[5]), .CK(clk), .CD(n9558), .Q(wb_dat_i[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(768[1] 784[10])
    defparam wb_dat_i__i5.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i4 (.D(n_wb_dat_i[4]), .CK(clk), .CD(n9558), .Q(wb_dat_i[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(768[1] 784[10])
    defparam wb_dat_i__i4.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i3 (.D(n_wb_dat_i[3]), .CK(clk), .CD(n9558), .Q(wb_dat_i[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(768[1] 784[10])
    defparam wb_dat_i__i3.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i2 (.D(n_wb_dat_i[2]), .CK(clk), .CD(n9558), .Q(wb_dat_i[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(768[1] 784[10])
    defparam wb_dat_i__i2.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i1 (.D(n_wb_dat_i[1]), .CK(clk), .CD(n9558), .Q(wb_dat_i[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(768[1] 784[10])
    defparam wb_dat_i__i1.GSR = "ENABLED";
    FD1P3IX temp3__i7 (.D(wb_dat_o[7]), .SP(dat_rdy_N_1319), .CD(n9558), 
            .CK(clk), .Q(temp3[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp3__i7.GSR = "ENABLED";
    FD1P3IX temp3__i6 (.D(n_state_7__N_1034[4]), .SP(dat_rdy_N_1319), .CD(n9558), 
            .CK(clk), .Q(temp3[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp3__i6.GSR = "ENABLED";
    FD1P3IX temp3__i5 (.D(wb_dat_o[5]), .SP(dat_rdy_N_1319), .CD(n9558), 
            .CK(clk), .Q(temp3[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp3__i5.GSR = "ENABLED";
    FD1P3IX temp3__i4 (.D(wb_dat_o[4]), .SP(dat_rdy_N_1319), .CD(n9558), 
            .CK(clk), .Q(temp3[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp3__i4.GSR = "ENABLED";
    FD1P3IX temp3__i3 (.D(wb_dat_o[3]), .SP(dat_rdy_N_1319), .CD(n9558), 
            .CK(clk), .Q(temp3[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp3__i3.GSR = "ENABLED";
    FD1P3IX temp3__i2 (.D(wb_dat_o[2]), .SP(dat_rdy_N_1319), .CD(n9558), 
            .CK(clk), .Q(temp3[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp3__i2.GSR = "ENABLED";
    FD1P3IX temp3__i1 (.D(wb_dat_o[1]), .SP(dat_rdy_N_1319), .CD(n9558), 
            .CK(clk), .Q(temp3[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp3__i1.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i7 (.D(ANL_VIN_FLT_c), .SP(clk_enable_125), .CD(n9558), 
            .CK(clk), .Q(GPI_DAT[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(644[8] 650[15])
    defparam GPI_DAT__i7.GSR = "ENABLED";
    CCU2D add_806_3 (.A0(counter[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8278), .COUT(n8279), .S0(n3107), .S1(n3106));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1487[17:24])
    defparam add_806_3.INIT0 = 16'h5555;
    defparam add_806_3.INIT1 = 16'h5555;
    defparam add_806_3.INJECT1_0 = "NO";
    defparam add_806_3.INJECT1_1 = "NO";
    FD1P3IX GPI_DAT__i6 (.D(FPIO_isoCtrlINTn_c), .SP(clk_enable_125), .CD(n9558), 
            .CK(clk), .Q(GPI_DAT[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(644[8] 650[15])
    defparam GPI_DAT__i6.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i5 (.D(SD0_CD_c), .SP(clk_enable_125), .CD(n9558), 
            .CK(clk), .Q(GPI_DAT[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(644[8] 650[15])
    defparam GPI_DAT__i5.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i4 (.D(FlexIO04_c), .SP(clk_enable_125), .CD(n9558), 
            .CK(clk), .Q(GPI_DAT[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(644[8] 650[15])
    defparam GPI_DAT__i4.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i3 (.D(FlexIO03_c), .SP(clk_enable_125), .CD(n9558), 
            .CK(clk), .Q(GPI_DAT[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(644[8] 650[15])
    defparam GPI_DAT__i3.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i2 (.D(FP_UsrSW3_c), .SP(clk_enable_125), .CD(n9558), 
            .CK(clk), .Q(GPI_DAT[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(644[8] 650[15])
    defparam GPI_DAT__i2.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i1 (.D(FP_UsrSW2_c), .SP(clk_enable_125), .CD(n9558), 
            .CK(clk), .Q(GPI_DAT[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(644[8] 650[15])
    defparam GPI_DAT__i1.GSR = "ENABLED";
    FD1S3AY signals_debounced_syn_i4 (.D(pushed_4__N_291), .CK(clk), .Q(signals_debounced_syn[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam signals_debounced_syn_i4.GSR = "ENABLED";
    FD1S3AY signals_debounced_syn_i3 (.D(pushed_3__N_293), .CK(clk), .Q(signals_debounced_syn[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam signals_debounced_syn_i3.GSR = "ENABLED";
    FD1S3AY signals_debounced_syn_i2 (.D(pushed_2__N_295), .CK(clk), .Q(signals_debounced_syn[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam signals_debounced_syn_i2.GSR = "ENABLED";
    FD1P3IX pushed_i4 (.D(n9869), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(pushed[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam pushed_i4.GSR = "ENABLED";
    FD1P3IX pushed_i3 (.D(n9869), .SP(clk_enable_127), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(pushed[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam pushed_i3.GSR = "ENABLED";
    FD1P3IX pushed_i2 (.D(n9869), .SP(clk_enable_128), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(pushed[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam pushed_i2.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn2_i4 (.D(debounce_inputs_asyn1[4]), .CK(clk), 
            .Q(debounce_inputs_asyn2[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_inputs_asyn2_i4.GSR = "ENABLED";
    LUT4 i1_2_lut_adj_103 (.A(temp2[0]), .B(dat_rdy_del), .Z(n4_adj_1444)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i1_2_lut_adj_103.init = 16'h4444;
    CCU2D add_4442_20 (.A0(\debounce_counters[4] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8355), .COUT(n8356));
    defparam add_4442_20.INIT0 = 16'h5555;
    defparam add_4442_20.INIT1 = 16'h5555;
    defparam add_4442_20.INJECT1_0 = "NO";
    defparam add_4442_20.INJECT1_1 = "NO";
    CCU2D add_4442_18 (.A0(\debounce_counters[4] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8354), .COUT(n8355));
    defparam add_4442_18.INIT0 = 16'h5555;
    defparam add_4442_18.INIT1 = 16'h5555;
    defparam add_4442_18.INJECT1_0 = "NO";
    defparam add_4442_18.INJECT1_1 = "NO";
    FD1S3AY debounce_inputs_asyn2_i3 (.D(debounce_inputs_asyn1[3]), .CK(clk), 
            .Q(debounce_inputs_asyn2[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_inputs_asyn2_i3.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn2_i2 (.D(debounce_inputs_asyn1[2]), .CK(clk), 
            .Q(debounce_inputs_asyn2[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_inputs_asyn2_i2.GSR = "ENABLED";
    FD1S3IX temp1__i7 (.D(n_temp1[7]), .CK(clk), .CD(n9558), .Q(temp1[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp1__i7.GSR = "ENABLED";
    FD1S3IX temp1__i6 (.D(n_temp1[6]), .CK(clk), .CD(n9558), .Q(temp1[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp1__i6.GSR = "ENABLED";
    FD1S3IX temp1__i5 (.D(n_temp1[5]), .CK(clk), .CD(n9558), .Q(temp1[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp1__i5.GSR = "ENABLED";
    FD1S3IX temp1__i4 (.D(n_temp1[4]), .CK(clk), .CD(n9558), .Q(temp1[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp1__i4.GSR = "ENABLED";
    FD1S3IX temp1__i3 (.D(n_temp1[3]), .CK(clk), .CD(n9558), .Q(temp1[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp1__i3.GSR = "ENABLED";
    FD1S3IX temp1__i2 (.D(n_temp1[2]), .CK(clk), .CD(n9558), .Q(temp1[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp1__i2.GSR = "ENABLED";
    FD1S3IX temp1__i1 (.D(n_temp1[1]), .CK(clk), .CD(n9558), .Q(temp1[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(577[1] 592[11])
    defparam temp1__i1.GSR = "ENABLED";
    BB FPIO_FlexMIO27_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO27), 
       .O(FPIO_FlexMIO27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    FD1P3IX GPO_DATA_0___i8 (.D(temp3[7]), .SP(clk_enable_135), .CD(n9558), 
            .CK(clk), .Q(FP_UsrLED_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(625[8] 633[15])
    defparam GPO_DATA_0___i8.GSR = "ENABLED";
    BB FPIO_FlexMIO30_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO30), 
       .O(FPIO_FlexMIO30_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    FD1P3IX GPO_DATA_0___i7 (.D(temp3[6]), .SP(clk_enable_135), .CD(n9558), 
            .CK(clk), .Q(FP_UsrLED_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(625[8] 633[15])
    defparam GPO_DATA_0___i7.GSR = "ENABLED";
    BB FPIO_FlexMIO29_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO29), 
       .O(FPIO_FlexMIO29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    FD1P3IX GPO_DATA_0___i6 (.D(temp3[5]), .SP(clk_enable_135), .CD(n9558), 
            .CK(clk), .Q(FP_UsrLED_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(625[8] 633[15])
    defparam GPO_DATA_0___i6.GSR = "ENABLED";
    BB DIG5S3C26_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C26), .O(DIG5S3C26_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    FD1P3IX GPO_DATA_0___i5 (.D(temp3[4]), .SP(clk_enable_135), .CD(n9558), 
            .CK(clk), .Q(FP_UsrLED_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(625[8] 633[15])
    defparam GPO_DATA_0___i5.GSR = "ENABLED";
    BB DIG5S3C25_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C25), .O(DIG5S3C25_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    FD1P3IX GPO_DATA_0___i4 (.D(temp3[3]), .SP(clk_enable_135), .CD(n9558), 
            .CK(clk), .Q(FP_SysLEDs_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(625[8] 633[15])
    defparam GPO_DATA_0___i4.GSR = "ENABLED";
    BB DIG5S3C24_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C24), .O(DIG5S3C24_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    FD1P3IX GPO_DATA_0___i3 (.D(temp3[2]), .SP(clk_enable_135), .CD(n9558), 
            .CK(clk), .Q(FlexIO05_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(625[8] 633[15])
    defparam GPO_DATA_0___i3.GSR = "ENABLED";
    BB FlexMIOs54_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs54), .O(FlexMIOs54_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    FD1P3IX GPO_DATA_0___i2 (.D(temp3[1]), .SP(clk_enable_135), .CD(n9558), 
            .CK(clk), .Q(FlexIO02_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(625[8] 633[15])
    defparam GPO_DATA_0___i2.GSR = "ENABLED";
    BB FlexMIOs62_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs62), .O(FlexMIOs62_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB FlexMIOs63_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs63), .O(FlexMIOs63_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB FlexMIOs31_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs31), .O(FlexMIOs31_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    LUT4 i1_4_lut_adj_104 (.A(dat_rdy_N_1321), .B(n2028), .C(dat_count[7]), 
         .D(n6823), .Z(n15_adj_1436)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_104.init = 16'h88a0;
    BB FlexMIOs30_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs30), .O(FlexMIOs30_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB FlexMIOs29_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs29), .O(FlexMIOs29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB FlexMIOs28_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs28), .O(FlexMIOs28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB FlexMIOs27_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs27), .O(FlexMIOs27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    CCU2D add_4442_16 (.A0(\debounce_counters[4] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8353), .COUT(n8354));
    defparam add_4442_16.INIT0 = 16'h5555;
    defparam add_4442_16.INIT1 = 16'h5555;
    defparam add_4442_16.INJECT1_0 = "NO";
    defparam add_4442_16.INJECT1_1 = "NO";
    BB FlexMIOs26_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs26), .O(FlexMIOs26_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    CCU2D add_173_27 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8242), .COUT(n8243), .S0(n317), 
          .S1(n316));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_27.INIT0 = 16'h5aaa;
    defparam add_173_27.INIT1 = 16'h5aaa;
    defparam add_173_27.INJECT1_0 = "NO";
    defparam add_173_27.INJECT1_1 = "NO";
    BB FlexMIOs37_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs37), .O(FlexMIOs37_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB FlexMIOs36_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs36), .O(FlexMIOs36_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    LUT4 i5204_3_lut_rep_111_4_lut (.A(next_state[1]), .B(n9559), .C(n9498), 
         .D(n6863), .Z(clk_enable_157)) /* synthesis lut_function=(A (C)+!A (B (C (D))+!B (C))) */ ;
    defparam i5204_3_lut_rep_111_4_lut.init = 16'hf0b0;
    BB FlexMIOs35_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs35), .O(FlexMIOs35_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    CCU2D add_4442_14 (.A0(\debounce_counters[4] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8352), .COUT(n8353));
    defparam add_4442_14.INIT0 = 16'h5555;
    defparam add_4442_14.INIT1 = 16'h5555;
    defparam add_4442_14.INJECT1_0 = "NO";
    defparam add_4442_14.INJECT1_1 = "NO";
    BB FlexMIOs34_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs34), .O(FlexMIOs34_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB FlexMIOs33_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs33), .O(FlexMIOs33_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB FlexMIOs32_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs32), .O(FlexMIOs32_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB DIG5S3C03_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C03), .O(DIG5S3C03_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB DIG5S3C04_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C04), .O(DIG5S3C04_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB DIG5S3C05_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C05), .O(DIG5S3C05_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB DIG5S3C00_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C00), .O(DIG5S3C00_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB DIG5S3C02_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C02), .O(DIG5S3C02_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB DIG5S3C01_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C01), .O(DIG5S3C01_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB DIG5S3C29_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C29), .O(DIG5S3C29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB DIG5S3C28_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C28), .O(DIG5S3C28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    BB DIG5S3C27_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C27), .O(DIG5S3C27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(425[1:17])
    OB FP_SysLEDg_pad (.I(FP_SysLEDg_c), .O(FP_SysLEDg));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(25[3:13])
    OB FP_SysLEDr_pad (.I(FP_SysLEDr_c), .O(FP_SysLEDr));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(26[3:13])
    OB FP_SysLEDb_pad (.I(FP_SysLEDb_c), .O(FP_SysLEDb));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(27[3:13])
    OB FlexIO05_pad (.I(FlexIO05_c_2), .O(FlexIO05));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(28[3:11])
    OB FlexIO02_pad (.I(FlexIO02_c_1), .O(FlexIO02));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(31[3:11])
    OB FlexIO01_pad (.I(FlexIO01_c_0), .O(FlexIO01));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(32[3:11])
    OB FPIO_isoCtrlRSTn_pad (.I(FPIO_isoCtrlRSTn_c), .O(FPIO_isoCtrlRSTn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(40[3:19])
    OB Carrier_PG_3V3_pad (.I(Carrier_PG_3V3_c), .O(Carrier_PG_3V3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(42[3:17])
    OB FPIO_FlexMIO52_pad (.I(FPIO_FlexMIO52_c_c), .O(FPIO_FlexMIO52));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(48[3:17])
    OBZ n5256_pad (.I(GND_net), .T(n5257), .O(Carrier_PG_1V8));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1326[1] 1507[13])
    OB FP_SysLEDs_pad (.I(FP_SysLEDs_c_3), .O(FP_SysLEDs));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(53[3:13])
    OB FP_UsrLED_pad_4 (.I(FP_UsrLED_c_4), .O(FP_UsrLED[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(57[3:12])
    OB FP_UsrLED_pad_3 (.I(FP_UsrLED_c_3), .O(FP_UsrLED[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(57[3:12])
    OB FP_UsrLED_pad_2 (.I(FP_UsrLED_c_2), .O(FP_UsrLED[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(57[3:12])
    OB FP_UsrLED_pad_1 (.I(FP_UsrLED_c_1), .O(FP_UsrLED[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(57[3:12])
    OB DIGS3C_Shared_CarrierReady_pad (.I(GND_net), .O(DIGS3C_Shared_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(58[3:29])
    OB DIGS3C_Shared_ReqSafeState_pad (.I(DIGS3C_Shared_ReqSafeState_c), .O(DIGS3C_Shared_ReqSafeState));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(59[3:29])
    OB SD_SEL_pad (.I(GND_net), .O(SD_SEL));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(67[3:9])
    OB FlexMIOs53_GPIO_PowerDown_pad (.I(FlexMIOs53_GPIO_PowerDown_c), .O(FlexMIOs53_GPIO_PowerDown));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(71[3:28])
    OB FlexMio61ExternalStop_pad (.I(FlexMio61ExternalStop_c_c), .O(FlexMio61ExternalStop));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(73[3:24])
    OB ANL_S3C_CarrierReady_pad (.I(GND_net), .O(ANL_S3C_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(102[3:23])
    OB DIGS3C_SlotD_SlotOE_pad_5 (.I(DIGS3C_SlotD_SlotOE_c_5), .O(DIGS3C_SlotD_SlotOE[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(104[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_4 (.I(DIGS3C_SlotD_SlotOE_c_4), .O(DIGS3C_SlotD_SlotOE[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(104[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_3 (.I(DIGS3C_SlotD_SlotOE_c_3), .O(DIGS3C_SlotD_SlotOE[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(104[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_2 (.I(DIGS3C_SlotD_SlotOE_c_2), .O(DIGS3C_SlotD_SlotOE[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(104[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_1 (.I(DIGS3C_SlotD_SlotOE_c_1), .O(DIGS3C_SlotD_SlotOE[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(104[3:22])
    OB Carrier_PwrOn_pad (.I(Carrier_PwrOn_c), .O(Carrier_PwrOn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(107[9:22])
    IB FlexIO04_pad (.I(FlexIO04), .O(FlexIO04_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(29[3:11])
    IB FlexIO03_pad (.I(FlexIO03), .O(FlexIO03_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(30[3:11])
    IB FP_UsrSW1_pad (.I(FP_UsrSW1), .O(FP_UsrSW1_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(33[3:12])
    IB FP_UsrSW2_pad (.I(FP_UsrSW2), .O(FP_UsrSW2_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(34[3:12])
    IB FP_UsrSW3_pad (.I(FP_UsrSW3), .O(FP_UsrSW3_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(38[3:12])
    IB SysSW_Pwr_NC_pad (.I(SysSW_Pwr_NC), .O(SysSW_Pwr_NC_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(39[3:15])
    IB FPIO_isoCtrlINTn_pad (.I(FPIO_isoCtrlINTn), .O(FPIO_isoCtrlINTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(41[3:19])
    IB FlexMio61ExternalStop_c_pad (.I(FPIO_ExternalStop), .O(FlexMio61ExternalStop_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(43[3:20])
    IB S3CsI2C_SDA_pad (.I(S3CsI2C_SDA), .O(S3CsI2C_SDA_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(51[3:14])
    IB S3CsI2C_SCL_pad (.I(S3CsI2C_SCL), .O(S3CsI2C_SCL_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(52[3:14])
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
    IB ANL_VIN_FLT_pad (.I(ANL_VIN_FLT), .O(ANL_VIN_FLT_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(68[3:14])
    IB FPIO_FlexMIO52_c_pad (.I(FlexMIOs52_PCIe), .O(FPIO_FlexMIO52_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(70[3:18])
    IB FlexMIOs45_pad (.I(FlexMIOs45), .O(FlexMIOs45_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(82[3:13])
    IB ANL_S3C_SLOTOK_pad_3 (.I(ANL_S3C_SLOTOK[3]), .O(ANL_S3C_SLOTOK_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(101[3:17])
    IB ANL_S3C_SLOTOK_pad_2 (.I(ANL_S3C_SLOTOK[2]), .O(ANL_S3C_SLOTOK_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(101[3:17])
    IB ANL_S3C_SLOTOK_pad_1 (.I(ANL_S3C_SLOTOK[1]), .O(ANL_S3C_SLOTOK_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(101[3:17])
    IB ANL_S3C_P54_Legacy_pad (.I(ANL_S3C_P54_Legacy), .O(ANL_S3C_P54_Legacy_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(103[3:21])
    IB PG_VIN_pad (.I(PG_VIN), .O(PG_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(108[3:9])
    IB PPn_VIN_pad (.I(PPn_VIN), .O(PPn_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(109[3:10])
    IB PG_Module_pad (.I(PG_Module), .O(PG_Module_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(110[3:12])
    IB TDnSHDN_pad (.I(TDnSHDN), .O(TDnSHDN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(111[3:10])
    IB TDnFFnFS_pad (.I(TDnFFnFS), .O(TDnFFnFS_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(112[3:11])
    IB TDnALERT_pad (.I(TDnALERT), .O(TDnALERT_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(113[3:11])
    IB S3C_S1_pad (.I(S3C_S1), .O(S3C_S1_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(114[3:9])
    CCU2D add_806_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n8278), .S1(n3108));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1487[17:24])
    defparam add_806_1.INIT0 = 16'hF000;
    defparam add_806_1.INIT1 = 16'h5555;
    defparam add_806_1.INJECT1_0 = "NO";
    defparam add_806_1.INJECT1_1 = "NO";
    CCU2D add_191_33 (.A0(\debounce_counters[4] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8277), .S0(n523));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_33.INIT0 = 16'h5aaa;
    defparam add_191_33.INIT1 = 16'h0000;
    defparam add_191_33.INJECT1_0 = "NO";
    defparam add_191_33.INJECT1_1 = "NO";
    CCU2D add_4442_12 (.A0(\debounce_counters[4] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8351), .COUT(n8352));
    defparam add_4442_12.INIT0 = 16'h5555;
    defparam add_4442_12.INIT1 = 16'h5aaa;
    defparam add_4442_12.INJECT1_0 = "NO";
    defparam add_4442_12.INJECT1_1 = "NO";
    CCU2D add_191_31 (.A0(\debounce_counters[4] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8276), .COUT(n8277), .S0(n525), 
          .S1(n524));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_31.INIT0 = 16'h5aaa;
    defparam add_191_31.INIT1 = 16'h5aaa;
    defparam add_191_31.INJECT1_0 = "NO";
    defparam add_191_31.INJECT1_1 = "NO";
    CCU2D add_191_29 (.A0(\debounce_counters[4] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8275), .COUT(n8276), .S0(n527), 
          .S1(n526));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_29.INIT0 = 16'h5aaa;
    defparam add_191_29.INIT1 = 16'h5aaa;
    defparam add_191_29.INJECT1_0 = "NO";
    defparam add_191_29.INJECT1_1 = "NO";
    CCU2D add_4442_10 (.A0(\debounce_counters[4] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8350), .COUT(n8351));
    defparam add_4442_10.INIT0 = 16'h5555;
    defparam add_4442_10.INIT1 = 16'h5555;
    defparam add_4442_10.INJECT1_0 = "NO";
    defparam add_4442_10.INJECT1_1 = "NO";
    CCU2D add_4442_8 (.A0(\debounce_counters[4] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8349), .COUT(n8350));
    defparam add_4442_8.INIT0 = 16'h5555;
    defparam add_4442_8.INIT1 = 16'h5aaa;
    defparam add_4442_8.INJECT1_0 = "NO";
    defparam add_4442_8.INJECT1_1 = "NO";
    CCU2D add_4442_6 (.A0(\debounce_counters[4] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8348), .COUT(n8349));
    defparam add_4442_6.INIT0 = 16'h5555;
    defparam add_4442_6.INIT1 = 16'h5555;
    defparam add_4442_6.INJECT1_0 = "NO";
    defparam add_4442_6.INJECT1_1 = "NO";
    LUT4 i3268_2_lut_3_lut (.A(n3098), .B(n4579), .C(n4583), .Z(n4491)) /* synthesis lut_function=(A+(B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam i3268_2_lut_3_lut.init = 16'hefef;
    CCU2D add_4442_4 (.A0(\debounce_counters[4] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8347), .COUT(n8348));
    defparam add_4442_4.INIT0 = 16'h5555;
    defparam add_4442_4.INIT1 = 16'h5aaa;
    defparam add_4442_4.INJECT1_0 = "NO";
    defparam add_4442_4.INJECT1_1 = "NO";
    CCU2D add_4442_2 (.A0(\debounce_counters[4] [5]), .B0(\debounce_counters[4] [4]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[4] [6]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n8347));
    defparam add_4442_2.INIT0 = 16'h7000;
    defparam add_4442_2.INIT1 = 16'h5aaa;
    defparam add_4442_2.INJECT1_0 = "NO";
    defparam add_4442_2.INJECT1_1 = "NO";
    CCU2D add_4443_28 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8346), .S1(clk_enable_127));
    defparam add_4443_28.INIT0 = 16'hf555;
    defparam add_4443_28.INIT1 = 16'h0000;
    defparam add_4443_28.INJECT1_0 = "NO";
    defparam add_4443_28.INJECT1_1 = "NO";
    CCU2D add_4443_26 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8345), .COUT(n8346));
    defparam add_4443_26.INIT0 = 16'h5555;
    defparam add_4443_26.INIT1 = 16'h5555;
    defparam add_4443_26.INJECT1_0 = "NO";
    defparam add_4443_26.INJECT1_1 = "NO";
    CCU2D add_4443_24 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8344), .COUT(n8345));
    defparam add_4443_24.INIT0 = 16'h5555;
    defparam add_4443_24.INIT1 = 16'h5555;
    defparam add_4443_24.INJECT1_0 = "NO";
    defparam add_4443_24.INJECT1_1 = "NO";
    LUT4 i5234_4_lut_4_lut (.A(next_state[1]), .B(next_state[2]), .C(next_state[0]), 
         .D(next_state[3]), .Z(clk_enable_146)) /* synthesis lut_function=(A+(B (C+(D))+!B !(C (D)))) */ ;
    defparam i5234_4_lut_4_lut.init = 16'heffb;
    LUT4 i1688_4_lut_4_lut (.A(clk_enable_2), .B(wb_dat_o[2]), .C(n_temp1_7__N_352), 
         .D(n_temp1_7__N_353), .Z(n5335)) /* synthesis lut_function=(A (B (C))+!A (D)) */ ;
    defparam i1688_4_lut_4_lut.init = 16'hd580;
    LUT4 i2343_3_lut_4_lut (.A(clk_enable_157), .B(n4585), .C(n4579), 
         .D(n4583), .Z(n6020)) /* synthesis lut_function=(A (B+(C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam i2343_3_lut_4_lut.init = 16'ha8aa;
    LUT4 i947_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_state_7__N_1034[4]), 
         .D(wb_dat_o[4]), .Z(n3840)) /* synthesis lut_function=(!(A (B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i947_3_lut_4_lut.init = 16'h77f7;
    LUT4 i1_2_lut_rep_130 (.A(signals_debounced_syn[4]), .B(externstop_falling), 
         .Z(n9540)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam i1_2_lut_rep_130.init = 16'h2222;
    LUT4 i3157_2_lut_rep_120_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_state_7__N_978[3]), 
         .Z(n9530)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i3157_2_lut_rep_120_3_lut.init = 16'h8080;
    LUT4 i1_2_lut_adj_105 (.A(next_state[2]), .B(next_state[3]), .Z(n8990)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam i1_2_lut_adj_105.init = 16'h2222;
    LUT4 i1043_2_lut_rep_126_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_353), 
         .Z(n9536)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i1043_2_lut_rep_126_3_lut.init = 16'h8080;
    CCU2D add_191_27 (.A0(\debounce_counters[4] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8274), .COUT(n8275), .S0(n529), 
          .S1(n528));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_27.INIT0 = 16'h5aaa;
    defparam add_191_27.INIT1 = 16'h5aaa;
    defparam add_191_27.INJECT1_0 = "NO";
    defparam add_191_27.INJECT1_1 = "NO";
    LUT4 i1700_2_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_346), 
         .D(n_temp1_7__N_347), .Z(n5347)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A (C+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i1700_2_lut_3_lut_4_lut.init = 16'hf7f0;
    LUT4 i1_4_lut_adj_106 (.A(wb_dat_o[0]), .B(temp1[0]), .C(n9536), .D(n9053), 
         .Z(n_temp1[0])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_106.init = 16'ha0ec;
    CCU2D add_164_13 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8219), .COUT(n8220), .S0(n225), 
          .S1(n224));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_13.INIT0 = 16'h5aaa;
    defparam add_164_13.INIT1 = 16'h5aaa;
    defparam add_164_13.INJECT1_0 = "NO";
    defparam add_164_13.INJECT1_1 = "NO";
    LUT4 pushed_1__I_0_1_lut (.A(pushed[1]), .Z(pushed_1__N_297)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(462[17] 466[24])
    defparam pushed_1__I_0_1_lut.init = 16'h5555;
    FD1P3AX next_state_i2 (.D(next_state_3__N_64[2]), .SP(clk_enable_136), 
            .CK(clk), .Q(next_state[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam next_state_i2.GSR = "ENABLED";
    LUT4 mux_1099_Mux_2_i3_4_lut_then_4_lut (.A(signals_debounced_syn[2]), 
         .B(extern_connected), .C(FPIO_isoCtrlRSTn_N_1288), .D(next_state[0]), 
         .Z(n9568)) /* synthesis lut_function=(!(A (C)+!A (B (C+(D))+!B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1099_Mux_2_i3_4_lut_then_4_lut.init = 16'h0b0f;
    LUT4 i1_2_lut_4_lut (.A(resetcounter[24]), .B(resetcounter[23]), .C(resetcounter[22]), 
         .D(n6975), .Z(resetcounter_24__N_1304)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(505[6:29])
    defparam i1_2_lut_4_lut.init = 16'h8000;
    CCU2D add_191_25 (.A0(\debounce_counters[4] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8273), .COUT(n8274), .S0(n531), 
          .S1(n530));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_25.INIT0 = 16'h5aaa;
    defparam add_191_25.INIT1 = 16'h5aaa;
    defparam add_191_25.INJECT1_0 = "NO";
    defparam add_191_25.INJECT1_1 = "NO";
    LUT4 i1682_4_lut_4_lut (.A(clk_enable_2), .B(wb_dat_o[2]), .C(n_temp1_7__N_355), 
         .D(reg_rdy_N_1317), .Z(n5329)) /* synthesis lut_function=(A (B (C))+!A (D)) */ ;
    defparam i1682_4_lut_4_lut.init = 16'hd580;
    CCU2D add_191_23 (.A0(\debounce_counters[4] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8272), .COUT(n8273), .S0(n533), 
          .S1(n532));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_23.INIT0 = 16'h5aaa;
    defparam add_191_23.INIT1 = 16'h5aaa;
    defparam add_191_23.INJECT1_0 = "NO";
    defparam add_191_23.INJECT1_1 = "NO";
    CCU2D add_4443_22 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8343), .COUT(n8344));
    defparam add_4443_22.INIT0 = 16'h5555;
    defparam add_4443_22.INIT1 = 16'h5555;
    defparam add_4443_22.INJECT1_0 = "NO";
    defparam add_4443_22.INJECT1_1 = "NO";
    CCU2D add_191_21 (.A0(\debounce_counters[4] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8271), .COUT(n8272), .S0(n535), 
          .S1(n534));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_21.INIT0 = 16'h5aaa;
    defparam add_191_21.INIT1 = 16'h5aaa;
    defparam add_191_21.INJECT1_0 = "NO";
    defparam add_191_21.INJECT1_1 = "NO";
    LUT4 i2_4_lut_adj_107 (.A(dat_count[6]), .B(n12_adj_1423), .C(n17), 
         .D(n15_adj_1421), .Z(n_dat_count[6])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i2_4_lut_adj_107.init = 16'hffec;
    LUT4 i1_2_lut_3_lut_4_lut_adj_108 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[4]), 
         .D(n_temp1_7__N_360), .Z(n_wb_dat_i[4])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_108.init = 16'h7000;
    CCU2D add_4443_20 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8342), .COUT(n8343));
    defparam add_4443_20.INIT0 = 16'h5555;
    defparam add_4443_20.INIT1 = 16'h5555;
    defparam add_4443_20.INJECT1_0 = "NO";
    defparam add_4443_20.INJECT1_1 = "NO";
    PFUMX i5363 (.BLUT(n9487), .ALUT(n9486), .C0(temp1[1]), .Z(n9488));
    LUT4 externstop_last_I_0_2_lut (.A(externstop_last), .B(signals_debounced_syn[2]), 
         .Z(externstop_falling_N_1309)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(469[26:74])
    defparam externstop_last_I_0_2_lut.init = 16'h2222;
    FD1P3AX next_state_i0 (.D(next_state_3__N_64[0]), .SP(clk_enable_137), 
            .CK(clk), .Q(next_state[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam next_state_i0.GSR = "ENABLED";
    LUT4 i1_4_lut_then_4_lut (.A(next_state[0]), .B(next_state[2]), .C(next_state[3]), 
         .D(next_state[1]), .Z(n9571)) /* synthesis lut_function=(A (B (C+(D))+!B (C (D)))+!A (B (C)+!B !(C+(D)))) */ ;
    defparam i1_4_lut_then_4_lut.init = 16'he8c1;
    CCU2D add_4443_18 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8341), .COUT(n8342));
    defparam add_4443_18.INIT0 = 16'h5555;
    defparam add_4443_18.INIT1 = 16'h5555;
    defparam add_4443_18.INJECT1_0 = "NO";
    defparam add_4443_18.INJECT1_1 = "NO";
    LUT4 i1_4_lut_else_4_lut (.A(next_state[0]), .B(next_state[2]), .C(next_state[3]), 
         .D(next_state[1]), .Z(n9570)) /* synthesis lut_function=(A (B (C+(D))+!B (C (D)+!C !(D)))+!A (B (C))) */ ;
    defparam i1_4_lut_else_4_lut.init = 16'he8c2;
    FD1P3AX next_state_i3 (.D(next_state_3__N_64[3]), .SP(clk_enable_138), 
            .CK(clk), .Q(next_state[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam next_state_i3.GSR = "ENABLED";
    LUT4 mux_1314_i6_4_lut (.A(next_state[1]), .B(n3103), .C(n4583), .D(n4579), 
         .Z(n4496)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1314_i6_4_lut.init = 16'h0aca;
    FD1P3IX counter_i0_i21 (.D(n4480), .SP(clk_enable_157), .CD(n6023), 
            .CK(clk), .Q(counter[21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i21.GSR = "ENABLED";
    LUT4 i1_4_lut_adj_109 (.A(n_temp1_7__N_360), .B(dat_count[6]), .C(n2029), 
         .D(n9525), .Z(n12_adj_1423)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_109.init = 16'ha088;
    LUT4 i32_4_lut (.A(n_temp1_7__N_348), .B(n_temp1_7__N_347), .C(clk_enable_2), 
         .D(n12_adj_1449), .Z(n8558)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i32_4_lut.init = 16'hfaca;
    LUT4 i3194_4_lut (.A(FPIO_isoCtrlRSTn_N_1288), .B(externstop_falling), 
         .C(next_state[3]), .D(next_state[2]), .Z(n6863)) /* synthesis lut_function=(A (B+(D))+!A (B (C)+!B (C (D)))) */ ;
    defparam i3194_4_lut.init = 16'hfac8;
    FD1P3IX counter_i0_i17 (.D(n4484), .SP(clk_enable_157), .CD(n6023), 
            .CK(clk), .Q(counter[17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i17.GSR = "ENABLED";
    LUT4 i2_3_lut_4_lut_adj_110 (.A(n9540), .B(next_state_3__N_1086[2]), 
         .C(next_state[0]), .D(next_state[3]), .Z(n8363)) /* synthesis lut_function=(!(A (B+(C+!(D)))+!A (C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam i2_3_lut_4_lut_adj_110.init = 16'h0700;
    LUT4 i5136_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_352), 
         .D(n_temp1_7__N_353), .Z(n9053)) /* synthesis lut_function=(A (B (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i5136_3_lut_4_lut.init = 16'h8880;
    FD1P3IX counter_i0_i16 (.D(n4485), .SP(clk_enable_157), .CD(n6023), 
            .CK(clk), .Q(counter[16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i16.GSR = "ENABLED";
    CCU2D add_4443_16 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8340), .COUT(n8341));
    defparam add_4443_16.INIT0 = 16'h5555;
    defparam add_4443_16.INIT1 = 16'h5555;
    defparam add_4443_16.INJECT1_0 = "NO";
    defparam add_4443_16.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_111 (.A(dat_rdy_N_1321), .B(n2029), .C(dat_count[6]), 
         .D(n6823), .Z(n15_adj_1421)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_111.init = 16'h88a0;
    LUT4 i1_2_lut_rep_113_4_lut (.A(n9543), .B(n9532), .C(temp1[0]), .D(n_temp1_7__N_354), 
         .Z(n9523)) /* synthesis lut_function=(A (D)+!A (B (D)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(747[58:76])
    defparam i1_2_lut_rep_113_4_lut.init = 16'hfe00;
    LUT4 i1_2_lut_3_lut (.A(n_temp1_7__N_354), .B(n9529), .C(n76), .Z(n8916)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(319[17:24])
    defparam i1_2_lut_3_lut.init = 16'h8080;
    LUT4 i3200_3_lut_4_lut (.A(signals_debounced_syn[4]), .B(externstop_falling), 
         .C(next_state_3__N_1086[2]), .D(next_state[0]), .Z(n6870)) /* synthesis lut_function=(A (B (C+(D))+!B (D))+!A (C+(D))) */ ;
    defparam i3200_3_lut_4_lut.init = 16'hffd0;
    FD1P3IX counter_i0_i15 (.D(n4486), .SP(clk_enable_157), .CD(n6023), 
            .CK(clk), .Q(counter[15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i15.GSR = "ENABLED";
    LUT4 mux_1314_i5_4_lut (.A(next_state[1]), .B(n3104), .C(n4583), .D(n4579), 
         .Z(n4497)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1314_i5_4_lut.init = 16'h0aca;
    LUT4 mux_1314_i22_4_lut (.A(next_state[1]), .B(n3087), .C(n4583), 
         .D(n4579), .Z(n4480)) /* synthesis lut_function=(!(A (((D)+!C)+!B)+!A (B (C (D))+!B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1314_i22_4_lut.init = 16'h05c5;
    LUT4 i2_4_lut_adj_112 (.A(dat_count[5]), .B(n12_adj_1416), .C(n17), 
         .D(n15_adj_1410), .Z(n_dat_count[5])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i2_4_lut_adj_112.init = 16'hffec;
    LUT4 i1686_3_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_354), 
         .D(n_temp1_7__N_353), .Z(n5333)) /* synthesis lut_function=(A (B (D)+!B (C))+!A (C)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i1686_3_lut_3_lut_4_lut.init = 16'hf870;
    LUT4 i1_4_lut_adj_113 (.A(n_temp1_7__N_360), .B(dat_count[5]), .C(n2030), 
         .D(n9525), .Z(n12_adj_1416)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_113.init = 16'ha088;
    CCU2D add_173_25 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8241), .COUT(n8242), .S0(n319), 
          .S1(n318));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_25.INIT0 = 16'h5aaa;
    defparam add_173_25.INIT1 = 16'h5aaa;
    defparam add_173_25.INJECT1_0 = "NO";
    defparam add_173_25.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_114 (.A(dat_rdy_N_1321), .B(n2030), .C(dat_count[5]), 
         .D(n6823), .Z(n15_adj_1410)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_114.init = 16'h88a0;
    CCU2D add_4443_14 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8339), .COUT(n8340));
    defparam add_4443_14.INIT0 = 16'h5555;
    defparam add_4443_14.INIT1 = 16'h5555;
    defparam add_4443_14.INJECT1_0 = "NO";
    defparam add_4443_14.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_131 (.A(temp1[4]), .B(temp1[7]), .Z(n9541)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_2_lut_rep_131.init = 16'heeee;
    LUT4 mux_1314_i18_4_lut (.A(next_state[1]), .B(n3091), .C(n4583), 
         .D(n4579), .Z(n4484)) /* synthesis lut_function=(!(A (((D)+!C)+!B)+!A (B (C (D))+!B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1314_i18_4_lut.init = 16'h05c5;
    LUT4 i2_4_lut_adj_115 (.A(dat_count[4]), .B(n12), .C(n17), .D(n15), 
         .Z(n_dat_count[4])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i2_4_lut_adj_115.init = 16'hffec;
    CCU2D add_4443_12 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8338), .COUT(n8339));
    defparam add_4443_12.INIT0 = 16'h5555;
    defparam add_4443_12.INIT1 = 16'h5aaa;
    defparam add_4443_12.INJECT1_0 = "NO";
    defparam add_4443_12.INJECT1_1 = "NO";
    CCU2D add_173_23 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8240), .COUT(n8241), .S0(n321), 
          .S1(n320));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_23.INIT0 = 16'h5aaa;
    defparam add_173_23.INIT1 = 16'h5aaa;
    defparam add_173_23.INJECT1_0 = "NO";
    defparam add_173_23.INJECT1_1 = "NO";
    FD1P3AX forceoutputdisable_706 (.D(forceoutputdisable_N_11), .SP(clk_enable_143), 
            .CK(clk), .Q(forceoutputdisable));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam forceoutputdisable_706.GSR = "ENABLED";
    FD1P3AX extern_connected_718 (.D(n9869), .SP(clk_enable_144), .CK(clk), 
            .Q(extern_connected)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam extern_connected_718.GSR = "ENABLED";
    LUT4 i1774_2_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n9014), 
         .D(n_temp1_7__N_360), .Z(n_wb_adr_i[2])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i1774_2_lut_3_lut_4_lut.init = 16'h7770;
    LUT4 i1718_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n9014), .D(n9550), 
         .Z(n_wb_adr_i[0])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i1718_3_lut_4_lut.init = 16'h7770;
    CCU2D add_4443_10 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8337), .COUT(n8338));
    defparam add_4443_10.INIT0 = 16'h5555;
    defparam add_4443_10.INIT1 = 16'h5555;
    defparam add_4443_10.INJECT1_0 = "NO";
    defparam add_4443_10.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_116 (.A(n_temp1_7__N_360), .B(dat_count[4]), .C(n2031), 
         .D(n9525), .Z(n12)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_116.init = 16'ha088;
    CCU2D add_173_21 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8239), .COUT(n8240), .S0(n323), 
          .S1(n322));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_21.INIT0 = 16'h5aaa;
    defparam add_173_21.INIT1 = 16'h5aaa;
    defparam add_173_21.INJECT1_0 = "NO";
    defparam add_173_21.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_4_lut_adj_117 (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_357), 
         .D(wb_dat_o[2]), .Z(n8987)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_117.init = 16'h8000;
    LUT4 i1_4_lut_adj_118 (.A(dat_rdy_N_1321), .B(n2031), .C(dat_count[4]), 
         .D(n6823), .Z(n15)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_118.init = 16'h88a0;
    CCU2D add_191_19 (.A0(\debounce_counters[4] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8270), .COUT(n8271), .S0(n537), 
          .S1(n536));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_19.INIT0 = 16'h5aaa;
    defparam add_191_19.INIT1 = 16'h5aaa;
    defparam add_191_19.INJECT1_0 = "NO";
    defparam add_191_19.INJECT1_1 = "NO";
    CCU2D add_191_17 (.A0(\debounce_counters[4] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8269), .COUT(n8270), .S0(n539), 
          .S1(n538));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_17.INIT0 = 16'h5aaa;
    defparam add_191_17.INIT1 = 16'h5aaa;
    defparam add_191_17.INJECT1_0 = "NO";
    defparam add_191_17.INJECT1_1 = "NO";
    CCU2D add_164_11 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8218), .COUT(n8219), .S0(n227), 
          .S1(n226));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_11.INIT0 = 16'h5aaa;
    defparam add_164_11.INIT1 = 16'h5aaa;
    defparam add_164_11.INJECT1_0 = "NO";
    defparam add_164_11.INJECT1_1 = "NO";
    CCU2D add_191_15 (.A0(\debounce_counters[4] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8268), .COUT(n8269), .S0(n541), 
          .S1(n540));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_15.INIT0 = 16'h5aaa;
    defparam add_191_15.INIT1 = 16'h5aaa;
    defparam add_191_15.INJECT1_0 = "NO";
    defparam add_191_15.INJECT1_1 = "NO";
    LUT4 select_1237_Select_1_i2_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), 
         .C(n4258), .Z(n_wb_adr_i[1])) /* synthesis lut_function=(!(A (B+!(C))+!A !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam select_1237_Select_1_i2_2_lut_3_lut.init = 16'h7070;
    CCU2D add_191_13 (.A0(\debounce_counters[4] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8267), .COUT(n8268), .S0(n543), 
          .S1(n542));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_13.INIT0 = 16'h5aaa;
    defparam add_191_13.INIT1 = 16'h5aaa;
    defparam add_191_13.INJECT1_0 = "NO";
    defparam add_191_13.INJECT1_1 = "NO";
    LUT4 i1_3_lut_4_lut (.A(n_state_7__N_978[3]), .B(clk_enable_2), .C(reg_rdy_N_1317), 
         .D(n9028), .Z(n17)) /* synthesis lut_function=(!(A (B (D)+!B !(C+!(D)))+!A !(C+!(D)))) */ ;
    defparam i1_3_lut_4_lut.init = 16'h70ff;
    CCU2D add_191_11 (.A0(\debounce_counters[4] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8266), .COUT(n8267), .S0(n545), 
          .S1(n544));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_11.INIT0 = 16'h5aaa;
    defparam add_191_11.INIT1 = 16'h5aaa;
    defparam add_191_11.INJECT1_0 = "NO";
    defparam add_191_11.INJECT1_1 = "NO";
    CCU2D add_173_19 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8238), .COUT(n8239), .S0(n325), 
          .S1(n324));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_19.INIT0 = 16'h5aaa;
    defparam add_173_19.INIT1 = 16'h5aaa;
    defparam add_173_19.INJECT1_0 = "NO";
    defparam add_173_19.INJECT1_1 = "NO";
    CCU2D add_191_9 (.A0(\debounce_counters[4] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8265), .COUT(n8266), .S0(n547), 
          .S1(n546));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_9.INIT0 = 16'h5aaa;
    defparam add_191_9.INIT1 = 16'h5aaa;
    defparam add_191_9.INJECT1_0 = "NO";
    defparam add_191_9.INJECT1_1 = "NO";
    CCU2D add_173_17 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8237), .COUT(n8238), .S0(n327), 
          .S1(n326));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_17.INIT0 = 16'h5aaa;
    defparam add_173_17.INIT1 = 16'h5aaa;
    defparam add_173_17.INJECT1_0 = "NO";
    defparam add_173_17.INJECT1_1 = "NO";
    LUT4 i5127_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_361), 
         .D(n74), .Z(n_wb_dat_i[3])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i5127_3_lut_4_lut.init = 16'h7770;
    CCU2D add_164_9 (.A0(\debounce_counters[1] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8217), .COUT(n8218), .S0(n229), 
          .S1(n228));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_9.INIT0 = 16'h5aaa;
    defparam add_164_9.INIT1 = 16'h5aaa;
    defparam add_164_9.INJECT1_0 = "NO";
    defparam add_164_9.INJECT1_1 = "NO";
    CCU2D add_191_7 (.A0(\debounce_counters[4] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8264), .COUT(n8265), .S0(n549), 
          .S1(n548));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_7.INIT0 = 16'h5aaa;
    defparam add_191_7.INIT1 = 16'h5aaa;
    defparam add_191_7.INJECT1_0 = "NO";
    defparam add_191_7.INJECT1_1 = "NO";
    CCU2D add_4443_8 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8336), .COUT(n8337));
    defparam add_4443_8.INIT0 = 16'h5555;
    defparam add_4443_8.INIT1 = 16'h5aaa;
    defparam add_4443_8.INJECT1_0 = "NO";
    defparam add_4443_8.INJECT1_1 = "NO";
    CCU2D add_173_15 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8236), .COUT(n8237), .S0(n329), 
          .S1(n328));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_15.INIT0 = 16'h5aaa;
    defparam add_173_15.INIT1 = 16'h5aaa;
    defparam add_173_15.INJECT1_0 = "NO";
    defparam add_173_15.INJECT1_1 = "NO";
    CCU2D add_191_5 (.A0(\debounce_counters[4] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8263), .COUT(n8264), .S0(n551), 
          .S1(n550));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_5.INIT0 = 16'h5aaa;
    defparam add_191_5.INIT1 = 16'h5aaa;
    defparam add_191_5.INJECT1_0 = "NO";
    defparam add_191_5.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_4_lut_adj_119 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[1]), 
         .D(n_temp1_7__N_360), .Z(n_wb_dat_i[1])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_119.init = 16'h7000;
    CCU2D add_4443_6 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8335), .COUT(n8336));
    defparam add_4443_6.INIT0 = 16'h5555;
    defparam add_4443_6.INIT1 = 16'h5555;
    defparam add_4443_6.INJECT1_0 = "NO";
    defparam add_4443_6.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_123_3_lut (.A(temp1[4]), .B(temp1[7]), .C(temp1[5]), 
         .Z(n9533)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_2_lut_rep_123_3_lut.init = 16'hfefe;
    LUT4 i1_2_lut_3_lut_adj_120 (.A(wb_ack_o), .B(wb_stb_i), .C(reg_rdy_N_1317), 
         .Z(reg_rdy_N_1315)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i1_2_lut_3_lut_adj_120.init = 16'h8080;
    LUT4 i1712_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(dat_rdy_N_1321), 
         .Z(dat_rdy_N_1319)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i1712_2_lut_3_lut.init = 16'h8080;
    LUT4 i1010_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n9560), .D(n15_adj_1407), 
         .Z(n3903)) /* synthesis lut_function=(((C (D))+!B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i1010_3_lut_4_lut.init = 16'hf777;
    LUT4 i2_3_lut_rep_112_4_lut (.A(temp1[3]), .B(n9531), .C(n6797), .D(n_state_7__N_978[3]), 
         .Z(n9522)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;
    defparam i2_3_lut_rep_112_4_lut.init = 16'he000;
    CCU2D add_4443_4 (.A0(\debounce_counters[3] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8334), .COUT(n8335));
    defparam add_4443_4.INIT0 = 16'h5555;
    defparam add_4443_4.INIT1 = 16'h5aaa;
    defparam add_4443_4.INJECT1_0 = "NO";
    defparam add_4443_4.INJECT1_1 = "NO";
    LUT4 next_state_1__bdd_4_lut_5412 (.A(next_state[1]), .B(next_state[0]), 
         .C(next_state[2]), .D(next_state[3]), .Z(clk_enable_15)) /* synthesis lut_function=(A+(B (C+!(D))+!B ((D)+!C))) */ ;
    defparam next_state_1__bdd_4_lut_5412.init = 16'hfbef;
    CCU2D add_173_13 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8235), .COUT(n8236), .S0(n331), 
          .S1(n330));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_13.INIT0 = 16'h5aaa;
    defparam add_173_13.INIT1 = 16'h5aaa;
    defparam add_173_13.INJECT1_0 = "NO";
    defparam add_173_13.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_4_lut_adj_121 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[6]), 
         .D(n_temp1_7__N_360), .Z(n_wb_dat_i[6])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_121.init = 16'h7000;
    LUT4 i2_3_lut_4_lut_4_lut (.A(n9544), .B(n8990), .C(FPIO_isoCtrlRSTn_N_1288), 
         .D(next_state[1]), .Z(n5971)) /* synthesis lut_function=(!(A+(((D)+!C)+!B))) */ ;
    defparam i2_3_lut_4_lut_4_lut.init = 16'h0040;
    CCU2D add_4443_2 (.A0(\debounce_counters[3] [5]), .B0(\debounce_counters[3] [4]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[3] [6]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n8334));
    defparam add_4443_2.INIT0 = 16'h7000;
    defparam add_4443_2.INIT1 = 16'h5aaa;
    defparam add_4443_2.INJECT1_0 = "NO";
    defparam add_4443_2.INJECT1_1 = "NO";
    LUT4 i3_4_lut_adj_122 (.A(n_dat_count_7__N_418[3]), .B(n6_adj_1419), 
         .C(n2), .D(n_temp1_7__N_360), .Z(n_dat_count[3])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i3_4_lut_adj_122.init = 16'hfefc;
    LUT4 mux_1314_i17_4_lut (.A(next_state[1]), .B(n3092), .C(n4583), 
         .D(n4579), .Z(n4485)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1314_i17_4_lut.init = 16'hfaca;
    CCU2D add_4444_28 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8333), .S1(clk_enable_128));
    defparam add_4444_28.INIT0 = 16'hf555;
    defparam add_4444_28.INIT1 = 16'h0000;
    defparam add_4444_28.INJECT1_0 = "NO";
    defparam add_4444_28.INJECT1_1 = "NO";
    CCU2D add_4444_26 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8332), .COUT(n8333));
    defparam add_4444_26.INIT0 = 16'h5555;
    defparam add_4444_26.INIT1 = 16'h5555;
    defparam add_4444_26.INJECT1_0 = "NO";
    defparam add_4444_26.INJECT1_1 = "NO";
    CCU2D add_4444_24 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8331), .COUT(n8332));
    defparam add_4444_24.INIT0 = 16'h5555;
    defparam add_4444_24.INIT1 = 16'h5555;
    defparam add_4444_24.INJECT1_0 = "NO";
    defparam add_4444_24.INJECT1_1 = "NO";
    CCU2D add_191_3 (.A0(\debounce_counters[4] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8262), .COUT(n8263), .S0(n553), 
          .S1(n552));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_3.INIT0 = 16'h5aaa;
    defparam add_191_3.INIT1 = 16'h5aaa;
    defparam add_191_3.INJECT1_0 = "NO";
    defparam add_191_3.INJECT1_1 = "NO";
    CCU2D add_4444_22 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8330), .COUT(n8331));
    defparam add_4444_22.INIT0 = 16'h5555;
    defparam add_4444_22.INIT1 = 16'h5555;
    defparam add_4444_22.INJECT1_0 = "NO";
    defparam add_4444_22.INJECT1_1 = "NO";
    LUT4 i1209_2_lut_rep_115_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n6797), 
         .Z(n9525)) /* synthesis lut_function=(!(((C)+!B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i1209_2_lut_rep_115_3_lut.init = 16'h0808;
    CCU2D add_4444_20 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8329), .COUT(n8330));
    defparam add_4444_20.INIT0 = 16'h5555;
    defparam add_4444_20.INIT1 = 16'h5555;
    defparam add_4444_20.INJECT1_0 = "NO";
    defparam add_4444_20.INJECT1_1 = "NO";
    CCU2D add_191_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[4] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n8262), .S1(n554));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_191_1.INIT0 = 16'hF000;
    defparam add_191_1.INIT1 = 16'h5555;
    defparam add_191_1.INJECT1_0 = "NO";
    defparam add_191_1.INJECT1_1 = "NO";
    CCU2D add_4444_18 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8328), .COUT(n8329));
    defparam add_4444_18.INIT0 = 16'h5555;
    defparam add_4444_18.INIT1 = 16'h5555;
    defparam add_4444_18.INJECT1_0 = "NO";
    defparam add_4444_18.INJECT1_1 = "NO";
    LUT4 mux_1314_i16_4_lut (.A(next_state[1]), .B(n3093), .C(n4583), 
         .D(n4579), .Z(n4486)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1314_i16_4_lut.init = 16'hf5c5;
    LUT4 i1_4_lut_4_lut (.A(n15_adj_1407), .B(n6797), .C(n_temp1_7__N_363), 
         .D(n_temp1_7__N_364), .Z(n4_adj_1439)) /* synthesis lut_function=(!(A+!(B (D)+!B (C+(D))))) */ ;
    defparam i1_4_lut_4_lut.init = 16'h5510;
    LUT4 i3299_4_lut (.A(n5), .B(resetcounter[21]), .C(resetcounter[18]), 
         .D(resetcounter[20]), .Z(n6975)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;
    defparam i3299_4_lut.init = 16'heccc;
    CCU2D add_173_11 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8234), .COUT(n8235), .S0(n333), 
          .S1(n332));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_11.INIT0 = 16'h5aaa;
    defparam add_173_11.INIT1 = 16'h5aaa;
    defparam add_173_11.INJECT1_0 = "NO";
    defparam add_173_11.INJECT1_1 = "NO";
    CCU2D add_4444_16 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8327), .COUT(n8328));
    defparam add_4444_16.INIT0 = 16'h5555;
    defparam add_4444_16.INIT1 = 16'h5555;
    defparam add_4444_16.INJECT1_0 = "NO";
    defparam add_4444_16.INJECT1_1 = "NO";
    LUT4 i1_3_lut_adj_123 (.A(n_state_7__N_1034[4]), .B(n_temp1_7__N_362), 
         .C(n8937), .Z(n12_adj_1449)) /* synthesis lut_function=(!(A+!(B+(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_3_lut_adj_123.init = 16'h5454;
    LUT4 i1866_3_lut_4_lut (.A(n_temp1_7__N_360), .B(n9014), .C(n9537), 
         .D(clk_enable_2), .Z(n_wb_stb_i)) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1866_3_lut_4_lut.init = 16'h00fe;
    LUT4 i1_2_lut_3_lut_4_lut_adj_124 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[0]), 
         .D(n_temp1_7__N_360), .Z(n_wb_dat_i[0])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_124.init = 16'h7000;
    CCU2D add_4444_14 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8326), .COUT(n8327));
    defparam add_4444_14.INIT0 = 16'h5555;
    defparam add_4444_14.INIT1 = 16'h5555;
    defparam add_4444_14.INJECT1_0 = "NO";
    defparam add_4444_14.INJECT1_1 = "NO";
    CCU2D add_182_33 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8261), .S0(n417));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_33.INIT0 = 16'h5aaa;
    defparam add_182_33.INIT1 = 16'h0000;
    defparam add_182_33.INJECT1_0 = "NO";
    defparam add_182_33.INJECT1_1 = "NO";
    LUT4 i2_4_lut_adj_125 (.A(dat_count[3]), .B(n9028), .C(reg_rdy_N_1317), 
         .D(n9530), .Z(n6_adj_1419)) /* synthesis lut_function=(A ((C)+!B)+!A (C (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i2_4_lut_adj_125.init = 16'hf2a2;
    CCU2D add_182_31 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8260), .COUT(n8261), .S0(n419), 
          .S1(n418));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_31.INIT0 = 16'h5aaa;
    defparam add_182_31.INIT1 = 16'h5aaa;
    defparam add_182_31.INJECT1_0 = "NO";
    defparam add_182_31.INJECT1_1 = "NO";
    LUT4 i5_3_lut_4_lut (.A(temp1[4]), .B(temp1[7]), .C(n10), .D(temp1[2]), 
         .Z(n18_adj_1424)) /* synthesis lut_function=(!(A+(B+((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i5_3_lut_4_lut.init = 16'h0010;
    CCU2D add_4444_12 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8325), .COUT(n8326));
    defparam add_4444_12.INIT0 = 16'h5555;
    defparam add_4444_12.INIT1 = 16'h5aaa;
    defparam add_4444_12.INJECT1_0 = "NO";
    defparam add_4444_12.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_4_lut_adj_126 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[5]), 
         .D(n_temp1_7__N_360), .Z(n_wb_dat_i[5])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_126.init = 16'h7000;
    CCU2D add_4444_10 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8324), .COUT(n8325));
    defparam add_4444_10.INIT0 = 16'h5555;
    defparam add_4444_10.INIT1 = 16'h5555;
    defparam add_4444_10.INJECT1_0 = "NO";
    defparam add_4444_10.INJECT1_1 = "NO";
    CCU2D add_4444_8 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8323), .COUT(n8324));
    defparam add_4444_8.INIT0 = 16'h5555;
    defparam add_4444_8.INIT1 = 16'h5aaa;
    defparam add_4444_8.INJECT1_0 = "NO";
    defparam add_4444_8.INJECT1_1 = "NO";
    CCU2D add_173_9 (.A0(\debounce_counters[2] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8233), .COUT(n8234), .S0(n335), 
          .S1(n334));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_9.INIT0 = 16'h5aaa;
    defparam add_173_9.INIT1 = 16'h5aaa;
    defparam add_173_9.INJECT1_0 = "NO";
    defparam add_173_9.INJECT1_1 = "NO";
    CCU2D add_173_7 (.A0(\debounce_counters[2] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8232), .COUT(n8233), .S0(n337), 
          .S1(n336));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_7.INIT0 = 16'h5aaa;
    defparam add_173_7.INIT1 = 16'h5aaa;
    defparam add_173_7.INJECT1_0 = "NO";
    defparam add_173_7.INJECT1_1 = "NO";
    CCU2D add_182_29 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8259), .COUT(n8260), .S0(n421), 
          .S1(n420));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_29.INIT0 = 16'h5aaa;
    defparam add_182_29.INIT1 = 16'h5aaa;
    defparam add_182_29.INJECT1_0 = "NO";
    defparam add_182_29.INJECT1_1 = "NO";
    CCU2D add_182_27 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8258), .COUT(n8259), .S0(n423), 
          .S1(n422));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_27.INIT0 = 16'h5aaa;
    defparam add_182_27.INIT1 = 16'h5aaa;
    defparam add_182_27.INJECT1_0 = "NO";
    defparam add_182_27.INJECT1_1 = "NO";
    LUT4 mux_1314_i12_4_lut (.A(next_state[1]), .B(n3097), .C(n4583), 
         .D(n4579), .Z(n4490)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1314_i12_4_lut.init = 16'hf5c5;
    CCU2D add_173_5 (.A0(\debounce_counters[2] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8231), .COUT(n8232), .S0(n339), 
          .S1(n338));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_5.INIT0 = 16'h5aaa;
    defparam add_173_5.INIT1 = 16'h5aaa;
    defparam add_173_5.INJECT1_0 = "NO";
    defparam add_173_5.INJECT1_1 = "NO";
    CCU2D add_173_3 (.A0(\debounce_counters[2] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8230), .COUT(n8231), .S0(n341), 
          .S1(n340));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_3.INIT0 = 16'h5aaa;
    defparam add_173_3.INIT1 = 16'h5aaa;
    defparam add_173_3.INJECT1_0 = "NO";
    defparam add_173_3.INJECT1_1 = "NO";
    CCU2D add_4444_6 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8322), .COUT(n8323));
    defparam add_4444_6.INIT0 = 16'h5555;
    defparam add_4444_6.INIT1 = 16'h5555;
    defparam add_4444_6.INJECT1_0 = "NO";
    defparam add_4444_6.INJECT1_1 = "NO";
    CCU2D add_182_25 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8257), .COUT(n8258), .S0(n425), 
          .S1(n424));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_25.INIT0 = 16'h5aaa;
    defparam add_182_25.INIT1 = 16'h5aaa;
    defparam add_182_25.INJECT1_0 = "NO";
    defparam add_182_25.INJECT1_1 = "NO";
    CCU2D add_4444_4 (.A0(\debounce_counters[2] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8321), .COUT(n8322));
    defparam add_4444_4.INIT0 = 16'h5555;
    defparam add_4444_4.INIT1 = 16'h5aaa;
    defparam add_4444_4.INJECT1_0 = "NO";
    defparam add_4444_4.INJECT1_1 = "NO";
    CCU2D add_4444_2 (.A0(\debounce_counters[2] [5]), .B0(\debounce_counters[2] [4]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[2] [6]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n8321));
    defparam add_4444_2.INIT0 = 16'h7000;
    defparam add_4444_2.INIT1 = 16'h5aaa;
    defparam add_4444_2.INJECT1_0 = "NO";
    defparam add_4444_2.INJECT1_1 = "NO";
    CCU2D add_182_23 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8256), .COUT(n8257), .S0(n427), 
          .S1(n426));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_23.INIT0 = 16'h5aaa;
    defparam add_182_23.INIT1 = 16'h5aaa;
    defparam add_182_23.INJECT1_0 = "NO";
    defparam add_182_23.INJECT1_1 = "NO";
    CCU2D add_182_21 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8255), .COUT(n8256), .S0(n429), 
          .S1(n428));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_21.INIT0 = 16'h5aaa;
    defparam add_182_21.INIT1 = 16'h5aaa;
    defparam add_182_21.INJECT1_0 = "NO";
    defparam add_182_21.INJECT1_1 = "NO";
    CCU2D add_182_19 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8254), .COUT(n8255), .S0(n431), 
          .S1(n430));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_19.INIT0 = 16'h5aaa;
    defparam add_182_19.INIT1 = 16'h5aaa;
    defparam add_182_19.INJECT1_0 = "NO";
    defparam add_182_19.INJECT1_1 = "NO";
    LUT4 i1_4_lut_then_3_lut_4_lut (.A(n_temp1_7__N_357), .B(n_temp1_7__N_355), 
         .C(n15_adj_1407), .D(n6797), .Z(n9565)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_then_3_lut_4_lut.init = 16'hfffe;
    CCU2D add_182_17 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8253), .COUT(n8254), .S0(n433), 
          .S1(n432));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_17.INIT0 = 16'h5aaa;
    defparam add_182_17.INIT1 = 16'h5aaa;
    defparam add_182_17.INJECT1_0 = "NO";
    defparam add_182_17.INJECT1_1 = "NO";
    CCU2D add_4441_28 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8320), .S1(clk_enable_4));
    defparam add_4441_28.INIT0 = 16'hf555;
    defparam add_4441_28.INIT1 = 16'h0000;
    defparam add_4441_28.INJECT1_0 = "NO";
    defparam add_4441_28.INJECT1_1 = "NO";
    CCU2D add_4441_26 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8319), .COUT(n8320));
    defparam add_4441_26.INIT0 = 16'h5555;
    defparam add_4441_26.INIT1 = 16'h5555;
    defparam add_4441_26.INJECT1_0 = "NO";
    defparam add_4441_26.INJECT1_1 = "NO";
    LUT4 i2_3_lut_4_lut_adj_127 (.A(temp1[5]), .B(n9541), .C(temp1[0]), 
         .D(n68), .Z(n50_adj_1422)) /* synthesis lut_function=(A+(B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i2_3_lut_4_lut_adj_127.init = 16'hffef;
    LUT4 i2_3_lut_4_lut_adj_128 (.A(next_state[0]), .B(externstop_falling), 
         .C(next_state_3__N_1086[2]), .D(signals_debounced_syn[4]), .Z(n8975)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;
    defparam i2_3_lut_4_lut_adj_128.init = 16'h1000;
    CCU2D add_173_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[2] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n8230), .S1(n342));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_173_1.INIT0 = 16'hF000;
    defparam add_173_1.INIT1 = 16'h5555;
    defparam add_173_1.INJECT1_0 = "NO";
    defparam add_173_1.INJECT1_1 = "NO";
    CCU2D add_4441_24 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8318), .COUT(n8319));
    defparam add_4441_24.INIT0 = 16'h5555;
    defparam add_4441_24.INIT1 = 16'h5555;
    defparam add_4441_24.INJECT1_0 = "NO";
    defparam add_4441_24.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_143 (.A(wb_dat_o[2]), .B(n_temp1_7__N_363), .Z(n9553)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_2_lut_rep_143.init = 16'h8888;
    CCU2D add_164_33 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8229), .S0(n205));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_33.INIT0 = 16'h5aaa;
    defparam add_164_33.INIT1 = 16'h0000;
    defparam add_164_33.INJECT1_0 = "NO";
    defparam add_164_33.INJECT1_1 = "NO";
    CCU2D add_164_31 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8228), .COUT(n8229), .S0(n207), 
          .S1(n206));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_31.INIT0 = 16'h5aaa;
    defparam add_164_31.INIT1 = 16'h5aaa;
    defparam add_164_31.INJECT1_0 = "NO";
    defparam add_164_31.INJECT1_1 = "NO";
    LUT4 i2_3_lut_4_lut_adj_129 (.A(wb_dat_o[2]), .B(n_temp1_7__N_363), 
         .C(n15_adj_1407), .D(n6797), .Z(n8977)) /* synthesis lut_function=(!((((D)+!C)+!B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i2_3_lut_4_lut_adj_129.init = 16'h0080;
    LUT4 i3237_3_lut_3_lut_3_lut (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[2]), .Z(n7_adj_1452)) /* synthesis lut_function=(!(A (C)+!A !(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam i3237_3_lut_3_lut_3_lut.init = 16'h4f4f;
    LUT4 i1_2_lut_rep_121_3_lut_4_lut (.A(temp1[5]), .B(n9541), .C(n9542), 
         .D(temp1[6]), .Z(n9531)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_2_lut_rep_121_3_lut_4_lut.init = 16'hfffe;
    LUT4 i1_4_lut_adj_130 (.A(resetcounter[13]), .B(resetcounter[19]), .C(n10_adj_1413), 
         .D(resetcounter[17]), .Z(n5)) /* synthesis lut_function=(A (B)+!A (B (C+(D)))) */ ;
    defparam i1_4_lut_adj_130.init = 16'hccc8;
    CCU2D add_164_29 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8227), .COUT(n8228), .S0(n209), 
          .S1(n208));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_29.INIT0 = 16'h5aaa;
    defparam add_164_29.INIT1 = 16'h5aaa;
    defparam add_164_29.INJECT1_0 = "NO";
    defparam add_164_29.INJECT1_1 = "NO";
    FD1P3AX FPIO_isoCtrlRSTn_715 (.D(FPIO_isoCtrlRSTn_N_1284), .SP(clk_enable_145), 
            .CK(clk), .Q(FPIO_isoCtrlRSTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam FPIO_isoCtrlRSTn_715.GSR = "ENABLED";
    LUT4 i4_4_lut (.A(n8435), .B(n8_adj_1435), .C(resetcounter[16]), .D(resetcounter[12]), 
         .Z(n10_adj_1413)) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(C))) */ ;
    defparam i4_4_lut.init = 16'hfefc;
    FD1S3AX c_state_FSM_i19 (.D(n9558), .CK(clk), .Q(n_temp1_7__N_346));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam c_state_FSM_i19.GSR = "ENABLED";
    LUT4 i1_2_lut_rep_128_3_lut_3_lut (.A(next_state[0]), .B(externstop_falling), 
         .C(signals_debounced_syn[4]), .Z(n9538)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam i1_2_lut_rep_128_3_lut_3_lut.init = 16'h1010;
    GSR GSR_INST (.GSR(VCC_net));
    LUT4 FPIO_isoCtrlRSTn_N_1288_bdd_4_lut_5304 (.A(FPIO_isoCtrlRSTn_N_1288), 
         .B(next_state[0]), .C(externstop_falling), .D(next_state[2]), 
         .Z(n9378)) /* synthesis lut_function=(!(A (B (D)+!B !(C (D)))+!A (B (D)+!B !(C+!(D))))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1288_bdd_4_lut_5304.init = 16'h30dd;
    LUT4 i1_2_lut_rep_151 (.A(n_temp1_7__N_357), .B(n_temp1_7__N_355), .Z(n9867)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_2_lut_rep_151.init = 16'heeee;
    LUT4 i1_4_lut_adj_131 (.A(temp1[6]), .B(data0[1]), .C(n30_adj_1434), 
         .D(n33_adj_1412), .Z(data0_7__N_892[1])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_4_lut_adj_131.init = 16'hdc50;
    LUT4 next_state_0__bdd_4_lut_5349 (.A(externstop_falling), .B(next_state[2]), 
         .C(next_state_3__N_1086[2]), .D(signals_debounced_syn[3]), .Z(n9379)) /* synthesis lut_function=(A (B+(C))+!A (B (C (D))+!B (C))) */ ;
    defparam next_state_0__bdd_4_lut_5349.init = 16'hf8b8;
    CCU2D add_164_27 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8226), .COUT(n8227), .S0(n211), 
          .S1(n210));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_27.INIT0 = 16'h5aaa;
    defparam add_164_27.INIT1 = 16'h5aaa;
    defparam add_164_27.INJECT1_0 = "NO";
    defparam add_164_27.INJECT1_1 = "NO";
    CCU2D add_4441_22 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8317), .COUT(n8318));
    defparam add_4441_22.INIT0 = 16'h5555;
    defparam add_4441_22.INIT1 = 16'h5555;
    defparam add_4441_22.INJECT1_0 = "NO";
    defparam add_4441_22.INJECT1_1 = "NO";
    LUT4 select_1239_Select_3_i2_4_lut (.A(n2032), .B(dat_rdy_N_1321), .C(dat_count[3]), 
         .D(n6823), .Z(n2)) /* synthesis lut_function=(A (B (C+(D)))+!A !(((D)+!C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam select_1239_Select_3_i2_4_lut.init = 16'h88c0;
    LUT4 i1_2_lut_4_lut_adj_132 (.A(n9527), .B(n_state_7__N_978[3]), .C(n6797), 
         .D(clk_enable_2), .Z(n4)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(D))+!A !(D))) */ ;
    defparam i1_2_lut_4_lut_adj_132.init = 16'h7f00;
    LUT4 i2_4_lut_adj_133 (.A(dat_count[2]), .B(n12_adj_1432), .C(n17), 
         .D(n15_adj_1431), .Z(n_dat_count[2])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i2_4_lut_adj_133.init = 16'hffec;
    LUT4 i1_3_lut_4_lut_4_lut_4_lut (.A(next_state[3]), .B(n9540), .C(next_state_3__N_1086[2]), 
         .D(next_state[0]), .Z(n23)) /* synthesis lut_function=(!(A (((D)+!C)+!B)+!A !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam i1_3_lut_4_lut_4_lut_4_lut.init = 16'h50d0;
    CCU2D add_182_15 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8252), .COUT(n8253), .S0(n435), 
          .S1(n434));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_15.INIT0 = 16'h5aaa;
    defparam add_182_15.INIT1 = 16'h5aaa;
    defparam add_182_15.INJECT1_0 = "NO";
    defparam add_182_15.INJECT1_1 = "NO";
    LUT4 i2_4_lut_adj_134 (.A(resetcounter[11]), .B(resetcounter[8]), .C(resetcounter[10]), 
         .D(resetcounter[9]), .Z(n8435)) /* synthesis lut_function=(A+(B (C+(D))+!B (C))) */ ;
    defparam i2_4_lut_adj_134.init = 16'hfefa;
    LUT4 i1_4_lut_4_lut_adj_135 (.A(next_state[3]), .B(next_state[0]), .C(n6540), 
         .D(next_state_3__N_1086[2]), .Z(n50)) /* synthesis lut_function=(!(A+!(B (C)+!B (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam i1_4_lut_4_lut_adj_135.init = 16'h5140;
    LUT4 temp1_7__I_0_796_i10_2_lut_rep_144 (.A(temp1[2]), .B(temp1[3]), 
         .Z(n9554)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(748[58:76])
    defparam temp1_7__I_0_796_i10_2_lut_rep_144.init = 16'heeee;
    CCU2D add_4441_20 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8316), .COUT(n8317));
    defparam add_4441_20.INIT0 = 16'h5555;
    defparam add_4441_20.INIT1 = 16'h5555;
    defparam add_4441_20.INJECT1_0 = "NO";
    defparam add_4441_20.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_136 (.A(n_temp1_7__N_360), .B(dat_count[2]), .C(n2033), 
         .D(n9525), .Z(n12_adj_1432)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_136.init = 16'ha088;
    LUT4 i2_2_lut_adj_137 (.A(resetcounter[14]), .B(resetcounter[15]), .Z(n8_adj_1435)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2_2_lut_adj_137.init = 16'heeee;
    LUT4 i1_4_lut_adj_138 (.A(dat_rdy_N_1321), .B(dat_count[2]), .C(n2033), 
         .D(n6823), .Z(n15_adj_1431)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_138.init = 16'ha088;
    LUT4 i2_4_lut_adj_139 (.A(dat_count[1]), .B(n12_adj_1405), .C(n17), 
         .D(n15_adj_1404), .Z(n_dat_count[1])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i2_4_lut_adj_139.init = 16'hffec;
    CCU2D add_4441_18 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8315), .COUT(n8316));
    defparam add_4441_18.INIT0 = 16'h5555;
    defparam add_4441_18.INIT1 = 16'h5555;
    defparam add_4441_18.INJECT1_0 = "NO";
    defparam add_4441_18.INJECT1_1 = "NO";
    LUT4 i5140_2_lut_3_lut_4_lut (.A(temp1[2]), .B(temp1[3]), .C(temp1[1]), 
         .D(temp1[0]), .Z(n9057)) /* synthesis lut_function=(A+(B+(C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(748[58:76])
    defparam i5140_2_lut_3_lut_4_lut.init = 16'hfeff;
    LUT4 i1_2_lut_rep_145 (.A(next_state[3]), .B(next_state[2]), .Z(n9555)) /* synthesis lut_function=(A (B)) */ ;
    defparam i1_2_lut_rep_145.init = 16'h8888;
    LUT4 i1_4_lut_adj_140 (.A(n_temp1_7__N_360), .B(dat_count[1]), .C(n2034), 
         .D(n9525), .Z(n12_adj_1405)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_140.init = 16'ha088;
    FD1P3AX FP_SysLEDr_709 (.D(FP_SysLEDr_N_1282), .SP(clk_enable_146), 
            .CK(clk), .Q(FP_SysLEDr_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam FP_SysLEDr_709.GSR = "ENABLED";
    CCU2D add_4441_16 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8314), .COUT(n8315));
    defparam add_4441_16.INIT0 = 16'h5555;
    defparam add_4441_16.INIT1 = 16'h5555;
    defparam add_4441_16.INJECT1_0 = "NO";
    defparam add_4441_16.INJECT1_1 = "NO";
    LUT4 mux_1323_i19_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n4585), .D(n4483), .Z(n4517)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_1323_i19_3_lut_4_lut.init = 16'h7f70;
    LUT4 next_state_1__bdd_2_lut (.A(next_state[1]), .B(FPIO_isoCtrlRSTn_N_1288), 
         .Z(n9740)) /* synthesis lut_function=(!(A+(B))) */ ;
    defparam next_state_1__bdd_2_lut.init = 16'h1111;
    LUT4 next_state_1__bdd_3_lut_5463 (.A(next_state[1]), .B(next_state_3__N_1086[2]), 
         .C(externstop_falling), .Z(n9741)) /* synthesis lut_function=(!(A (B)+!A !(B (C)))) */ ;
    defparam next_state_1__bdd_3_lut_5463.init = 16'h6262;
    FD1P3IX counter_i0_i14 (.D(n4487), .SP(clk_enable_157), .CD(n6023), 
            .CK(clk), .Q(counter[14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i14.GSR = "ENABLED";
    FD1P3AX FlexMIOs53_GPIO_PowerDown_708 (.D(FlexMIOs53_GPIO_PowerDown_N_1297), 
            .SP(clk_enable_148), .CK(clk), .Q(FlexMIOs53_GPIO_PowerDown_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam FlexMIOs53_GPIO_PowerDown_708.GSR = "ENABLED";
    CCU2D add_4441_14 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8313), .COUT(n8314));
    defparam add_4441_14.INIT0 = 16'h5555;
    defparam add_4441_14.INIT1 = 16'h5555;
    defparam add_4441_14.INJECT1_0 = "NO";
    defparam add_4441_14.INJECT1_1 = "NO";
    LUT4 i5211_4_lut (.A(next_state[0]), .B(FPIO_isoCtrlRSTn_N_1288), .C(next_state[1]), 
         .D(next_state[2]), .Z(clk_enable_144)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;
    defparam i5211_4_lut.init = 16'h2000;
    LUT4 i1696_4_lut_4_lut (.A(clk_enable_2), .B(n_state_7__N_1034[4]), 
         .C(n_temp1_7__N_348), .D(n_temp1_7__N_349), .Z(n5343)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1696_4_lut_4_lut.init = 16'hfda0;
    CCU2D add_4441_12 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8312), .COUT(n8313));
    defparam add_4441_12.INIT0 = 16'h5555;
    defparam add_4441_12.INIT1 = 16'h5aaa;
    defparam add_4441_12.INJECT1_0 = "NO";
    defparam add_4441_12.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_141 (.A(dat_rdy_N_1321), .B(n2034), .C(dat_count[1]), 
         .D(n6823), .Z(n15_adj_1404)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_141.init = 16'h88a0;
    LUT4 i2_3_lut_4_lut_adj_142 (.A(temp1[4]), .B(temp1[7]), .C(temp1[6]), 
         .D(temp1[5]), .Z(n14)) /* synthesis lut_function=(A+(B+!(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i2_3_lut_4_lut_adj_142.init = 16'hefff;
    LUT4 i1_2_lut_rep_122_3_lut_4_lut (.A(temp1[4]), .B(temp1[7]), .C(temp1[6]), 
         .D(temp1[5]), .Z(n9532)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_2_lut_rep_122_3_lut_4_lut.init = 16'hfffe;
    FD1P3AX counter_i0_i8 (.D(n4527), .SP(clk_enable_157), .CK(clk), .Q(counter[8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i8.GSR = "ENABLED";
    FD1P3AX counter_i0_i9 (.D(n4526), .SP(clk_enable_157), .CK(clk), .Q(counter[9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i9.GSR = "ENABLED";
    FD1P3AX counter_i0_i12 (.D(n4523), .SP(clk_enable_157), .CK(clk), 
            .Q(counter[12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i12.GSR = "ENABLED";
    LUT4 mux_1323_i13_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n4585), .D(n4489), .Z(n4523)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_1323_i13_3_lut_4_lut.init = 16'h7f70;
    FD1P3AX counter_i0_i18 (.D(n4517), .SP(clk_enable_157), .CK(clk), 
            .Q(counter[18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i18.GSR = "ENABLED";
    FD1P3AX counter_i0_i19 (.D(n4516), .SP(clk_enable_157), .CK(clk), 
            .Q(counter[19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i19.GSR = "ENABLED";
    FD1P3AX counter_i0_i20 (.D(n4515), .SP(clk_enable_157), .CK(clk), 
            .Q(counter[20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i20.GSR = "ENABLED";
    LUT4 mux_1323_i23_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n4585), .D(n4479), .Z(n4513)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_1323_i23_3_lut_4_lut.init = 16'h7f70;
    FD1P3AX counter_i0_i22 (.D(n4513), .SP(clk_enable_157), .CK(clk), 
            .Q(counter[22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i22.GSR = "ENABLED";
    FD1P3AX counter_i0_i23 (.D(n4512), .SP(clk_enable_157), .CK(clk), 
            .Q(counter[23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i23.GSR = "ENABLED";
    FD1P3AX counter_i0_i24 (.D(n4511), .SP(clk_enable_157), .CK(clk), 
            .Q(counter[24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1328[2] 1506[9])
    defparam counter_i0_i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i1 (.D(n447), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i1.GSR = "ENABLED";
    LUT4 mux_1323_i20_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n4585), .D(n4482), .Z(n4516)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_1323_i20_3_lut_4_lut.init = 16'h7f70;
    LUT4 i1_4_lut_adj_143 (.A(n_temp1_7__N_361), .B(n6797), .C(n4_adj_1408), 
         .D(n9553), .Z(n8934)) /* synthesis lut_function=(A+(B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_143.init = 16'hfefa;
    CCU2D add_4441_10 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8311), .COUT(n8312));
    defparam add_4441_10.INIT0 = 16'h5555;
    defparam add_4441_10.INIT1 = 16'h5555;
    defparam add_4441_10.INJECT1_0 = "NO";
    defparam add_4441_10.INJECT1_1 = "NO";
    CCU2D add_182_13 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8251), .COUT(n8252), .S0(n437), 
          .S1(n436));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_13.INIT0 = 16'h5aaa;
    defparam add_182_13.INIT1 = 16'h5aaa;
    defparam add_182_13.INJECT1_0 = "NO";
    defparam add_182_13.INJECT1_1 = "NO";
    CCU2D add_4441_8 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8310), .COUT(n8311));
    defparam add_4441_8.INIT0 = 16'h5555;
    defparam add_4441_8.INIT1 = 16'h5aaa;
    defparam add_4441_8.INJECT1_0 = "NO";
    defparam add_4441_8.INJECT1_1 = "NO";
    CCU2D add_182_11 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8250), .COUT(n8251), .S0(n439), 
          .S1(n438));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_11.INIT0 = 16'h5aaa;
    defparam add_182_11.INIT1 = 16'h5aaa;
    defparam add_182_11.INJECT1_0 = "NO";
    defparam add_182_11.INJECT1_1 = "NO";
    LUT4 i1_4_lut_4_lut_adj_144 (.A(clk_enable_2), .B(n_state_7__N_1034[4]), 
         .C(n8934), .D(n_temp1_7__N_362), .Z(n8554)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_4_lut_adj_144.init = 16'hfda0;
    CCU2D add_4441_6 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8309), .COUT(n8310));
    defparam add_4441_6.INIT0 = 16'h5555;
    defparam add_4441_6.INIT1 = 16'h5555;
    defparam add_4441_6.INJECT1_0 = "NO";
    defparam add_4441_6.INJECT1_1 = "NO";
    CCU2D add_4441_4 (.A0(\debounce_counters[1] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8308), .COUT(n8309));
    defparam add_4441_4.INIT0 = 16'h5555;
    defparam add_4441_4.INIT1 = 16'h5aaa;
    defparam add_4441_4.INJECT1_0 = "NO";
    defparam add_4441_4.INJECT1_1 = "NO";
    CCU2D add_164_25 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8225), .COUT(n8226), .S0(n213), 
          .S1(n212));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_164_25.INIT0 = 16'h5aaa;
    defparam add_164_25.INIT1 = 16'h5aaa;
    defparam add_164_25.INJECT1_0 = "NO";
    defparam add_164_25.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_145 (.A(n12_adj_1455), .B(n18), .C(next_state[2]), 
         .D(next_state[3]), .Z(clk_enable_145)) /* synthesis lut_function=(A+(B (C+!(D))+!B (C (D)))) */ ;
    defparam i1_4_lut_adj_145.init = 16'hfaee;
    LUT4 i1_4_lut_adj_146 (.A(reg_rdy_N_1317), .B(n_temp1_7__N_354), .C(n_state_7__N_978[3]), 
         .D(n23_adj_1447), .Z(n4_adj_1408)) /* synthesis lut_function=(A (B ((D)+!C)+!B !(C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_146.init = 16'hce0a;
    CCU2D add_4441_2 (.A0(\debounce_counters[1] [5]), .B0(\debounce_counters[1] [4]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[1] [6]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n8308));
    defparam add_4441_2.INIT0 = 16'h7000;
    defparam add_4441_2.INIT1 = 16'h5aaa;
    defparam add_4441_2.INJECT1_0 = "NO";
    defparam add_4441_2.INJECT1_1 = "NO";
    LUT4 i3284_2_lut_3_lut (.A(next_state[0]), .B(next_state[1]), .C(next_state[2]), 
         .Z(n14_adj_1451)) /* synthesis lut_function=(!(A (B+(C))+!A (C))) */ ;
    defparam i3284_2_lut_3_lut.init = 16'h0707;
    LUT4 next_state_0__bdd_2_lut_5297 (.A(next_state[2]), .B(next_state_3__N_1086[2]), 
         .Z(n9380)) /* synthesis lut_function=(A+!(B)) */ ;
    defparam next_state_0__bdd_2_lut_5297.init = 16'hbbbb;
    CCU2D add_182_9 (.A0(\debounce_counters[3] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8249), .COUT(n8250), .S0(n441), 
          .S1(n440));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(453[49:69])
    defparam add_182_9.INIT0 = 16'h5aaa;
    defparam add_182_9.INIT1 = 16'h5aaa;
    defparam add_182_9.INJECT1_0 = "NO";
    defparam add_182_9.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1491_add_4_25 (.A0(resetcounter[23]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8306), .S0(n107), .S1(n106));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491_add_4_25.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_25.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_25.INJECT1_0 = "NO";
    defparam resetcounter_i24_1491_add_4_25.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1491_add_4_23 (.A0(resetcounter[21]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8305), .COUT(n8306), .S0(n109), 
          .S1(n108));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491_add_4_23.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_23.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_23.INJECT1_0 = "NO";
    defparam resetcounter_i24_1491_add_4_23.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1491_add_4_21 (.A0(resetcounter[19]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8304), .COUT(n8305), .S0(n111), 
          .S1(n110));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491_add_4_21.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_21.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_21.INJECT1_0 = "NO";
    defparam resetcounter_i24_1491_add_4_21.INJECT1_1 = "NO";
    LUT4 next_state_1__bdd_2_lut_5460 (.A(next_state[0]), .B(externstop_falling), 
         .Z(n9737)) /* synthesis lut_function=(A (B)) */ ;
    defparam next_state_1__bdd_2_lut_5460.init = 16'h8888;
    CCU2D resetcounter_i24_1491_add_4_19 (.A0(resetcounter[17]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8303), .COUT(n8304), .S0(n113), 
          .S1(n112));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491_add_4_19.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_19.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_19.INJECT1_0 = "NO";
    defparam resetcounter_i24_1491_add_4_19.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1491_add_4_17 (.A0(resetcounter[15]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8302), .COUT(n8303), .S0(n115), 
          .S1(n114));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491_add_4_17.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_17.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_17.INJECT1_0 = "NO";
    defparam resetcounter_i24_1491_add_4_17.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1491_add_4_15 (.A0(resetcounter[13]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8301), .COUT(n8302), .S0(n117), 
          .S1(n116));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491_add_4_15.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_15.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_15.INJECT1_0 = "NO";
    defparam resetcounter_i24_1491_add_4_15.INJECT1_1 = "NO";
    LUT4 temp1_7__I_0_796_i9_2_lut_rep_132 (.A(temp1[0]), .B(temp1[1]), 
         .Z(n9542)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(748[58:76])
    defparam temp1_7__I_0_796_i9_2_lut_rep_132.init = 16'hdddd;
    LUT4 next_state_1__bdd_4_lut (.A(next_state[0]), .B(next_state_3__N_1086[2]), 
         .C(signals_debounced_syn[3]), .D(externstop_falling), .Z(n9736)) /* synthesis lut_function=(A+(B (C+(D))+!B (D))) */ ;
    defparam next_state_1__bdd_4_lut.init = 16'hffea;
    LUT4 n9743_bdd_3_lut (.A(n9743), .B(n9742), .C(next_state[3]), .Z(n9744)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam n9743_bdd_3_lut.init = 16'hcaca;
    LUT4 i2_2_lut_rep_146 (.A(next_state[2]), .B(next_state[3]), .Z(n9556)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2_2_lut_rep_146.init = 16'heeee;
    LUT4 i3263_2_lut_3_lut_4_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(next_state[1]), .D(next_state[0]), .Z(Carrier_PG_1V8_N_1403)) /* synthesis lut_function=(A+(B+!(C (D)+!C !(D)))) */ ;
    defparam i3263_2_lut_3_lut_4_lut.init = 16'heffe;
    LUT4 i1_4_lut_4_lut_adj_147 (.A(clk_enable_2), .B(n9560), .C(n4_adj_1438), 
         .D(n_temp1_7__N_357), .Z(n8708)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1113[8] 1124[15])
    defparam i1_4_lut_4_lut_adj_147.init = 16'hfda0;
    LUT4 i3243_2_lut_3_lut (.A(next_state[2]), .B(next_state[3]), .C(next_state[1]), 
         .Z(FPIO_isoCtrlRSTn_N_1284)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;
    defparam i3243_2_lut_3_lut.init = 16'h1010;
    LUT4 i2_2_lut_3_lut_4_lut (.A(next_state[2]), .B(next_state[3]), .C(next_state[1]), 
         .D(next_state[0]), .Z(n12_adj_1455)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;
    defparam i2_2_lut_3_lut_4_lut.init = 16'he000;
    LUT4 i5214_4_lut (.A(n5737), .B(n48), .C(data0[7]), .D(n50_adj_1422), 
         .Z(data0_7__N_892[7])) /* synthesis lut_function=(!(A+(B+!(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i5214_4_lut.init = 16'h1011;
    FD1P3IX debounce_counters_3___i2 (.D(n446), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i3 (.D(n445), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i4 (.D(n444), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i5 (.D(n443), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i6 (.D(n442), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i7 (.D(n441), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i8 (.D(n440), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i9 (.D(n439), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i10 (.D(n438), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i11 (.D(n437), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i12 (.D(n436), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i13 (.D(n435), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i14 (.D(n434), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i15 (.D(n433), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i16 (.D(n432), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i17 (.D(n431), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i18 (.D(n430), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i19 (.D(n429), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i20 (.D(n428), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i21 (.D(n427), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i22 (.D(n426), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i23 (.D(n425), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i24 (.D(n424), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i25 (.D(n423), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i26 (.D(n422), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i27 (.D(n421), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i28 (.D(n420), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i29 (.D(n419), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i30 (.D(n418), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i31 (.D(n417), .SP(clk_enable_188), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(445[9] 471[10])
    defparam debounce_counters_3___i31.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i1 (.D(n129), .CK(clk), .Q(n24)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i1.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i2 (.D(n128), .CK(clk), .Q(n23_adj_1445)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i2.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i3 (.D(n127), .CK(clk), .Q(n22)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i3.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i4 (.D(n126), .CK(clk), .Q(n21)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i4.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i5 (.D(n125), .CK(clk), .Q(n20)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i5.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i6 (.D(n124), .CK(clk), .Q(n19_adj_1418)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i6.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i7 (.D(n123), .CK(clk), .Q(n18_adj_1420)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i7.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i8 (.D(n122), .CK(clk), .Q(resetcounter[8])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i8.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i9 (.D(n121), .CK(clk), .Q(resetcounter[9])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i9.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i10 (.D(n120), .CK(clk), .Q(resetcounter[10])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i10.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i11 (.D(n119), .CK(clk), .Q(resetcounter[11])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i11.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i12 (.D(n118), .CK(clk), .Q(resetcounter[12])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i12.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i13 (.D(n117), .CK(clk), .Q(resetcounter[13])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i13.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i14 (.D(n116), .CK(clk), .Q(resetcounter[14])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i14.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i15 (.D(n115), .CK(clk), .Q(resetcounter[15])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i15.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i16 (.D(n114), .CK(clk), .Q(resetcounter[16])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i16.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i17 (.D(n113), .CK(clk), .Q(resetcounter[17])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i17.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i18 (.D(n112), .CK(clk), .Q(resetcounter[18])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i18.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i19 (.D(n111), .CK(clk), .Q(resetcounter[19])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i19.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i20 (.D(n110), .CK(clk), .Q(resetcounter[20])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i20.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i21 (.D(n109), .CK(clk), .Q(resetcounter[21])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i21.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i22 (.D(n108), .CK(clk), .Q(resetcounter[22])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i22.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i23 (.D(n107), .CK(clk), .Q(resetcounter[23])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i23.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1491__i24 (.D(n106), .CK(clk), .Q(resetcounter[24])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491__i24.GSR = "ENABLED";
    LUT4 n9737_bdd_4_lut (.A(n9737), .B(n9736), .C(next_state[1]), .D(next_state[3]), 
         .Z(n9866)) /* synthesis lut_function=(!(A (B (D)+!B (C+(D)))+!A (((D)+!C)+!B))) */ ;
    defparam n9737_bdd_4_lut.init = 16'h00ca;
    CCU2D resetcounter_i24_1491_add_4_13 (.A0(resetcounter[11]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8300), .COUT(n8301), .S0(n119), 
          .S1(n118));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491_add_4_13.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_13.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_13.INJECT1_0 = "NO";
    defparam resetcounter_i24_1491_add_4_13.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1491_add_4_11 (.A0(resetcounter[9]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8299), .COUT(n8300), .S0(n121), 
          .S1(n120));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491_add_4_11.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_11.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_11.INJECT1_0 = "NO";
    defparam resetcounter_i24_1491_add_4_11.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1491_add_4_9 (.A0(n18_adj_1420), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8298), .COUT(n8299), .S0(n123), 
          .S1(n122));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491_add_4_9.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_9.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_9.INJECT1_0 = "NO";
    defparam resetcounter_i24_1491_add_4_9.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1491_add_4_7 (.A0(n20), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n19_adj_1418), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n8297), .COUT(n8298), .S0(n125), .S1(n124));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491_add_4_7.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_7.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_7.INJECT1_0 = "NO";
    defparam resetcounter_i24_1491_add_4_7.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1491_add_4_5 (.A0(n22), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n21), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8296), .COUT(n8297), .S0(n127), .S1(n126));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491_add_4_5.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_5.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_5.INJECT1_0 = "NO";
    defparam resetcounter_i24_1491_add_4_5.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1491_add_4_3 (.A0(n24), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n23_adj_1445), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n8295), .COUT(n8296), .S0(n129), .S1(n128));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491_add_4_3.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_3.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1491_add_4_3.INJECT1_0 = "NO";
    defparam resetcounter_i24_1491_add_4_3.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1491_add_4_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n6975), .B1(n9551), .C1(n25), .D1(GND_net), 
          .COUT(n8295), .S1(n130));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(507[20:32])
    defparam resetcounter_i24_1491_add_4_1.INIT0 = 16'hF000;
    defparam resetcounter_i24_1491_add_4_1.INIT1 = 16'h8787;
    defparam resetcounter_i24_1491_add_4_1.INJECT1_0 = "NO";
    defparam resetcounter_i24_1491_add_4_1.INJECT1_1 = "NO";
    CCU2D add_805_9 (.A0(dat_count[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n8294), 
          .S0(n2028));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_805_9.INIT0 = 16'h5555;
    defparam add_805_9.INIT1 = 16'h0000;
    defparam add_805_9.INJECT1_0 = "NO";
    defparam add_805_9.INJECT1_1 = "NO";
    LUT4 i1_3_lut_adj_148 (.A(n9522), .B(n9529), .C(n76), .Z(n23_adj_1447)) /* synthesis lut_function=(A ((C)+!B)+!A !(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_3_lut_adj_148.init = 16'hb3b3;
    LUT4 i1_4_lut_adj_149 (.A(GPI_DAT[7]), .B(n5735), .C(temp1[5]), .D(temp1[6]), 
         .Z(n5737)) /* synthesis lut_function=(A (B (C (D)))+!A (B (C (D)+!C !(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_4_lut_adj_149.init = 16'hc004;
    LUT4 n9381_bdd_3_lut (.A(n9381), .B(n9378), .C(next_state[1]), .Z(n9382)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam n9381_bdd_3_lut.init = 16'hcaca;
    LUT4 i3218_3_lut (.A(n3094), .B(n4583), .C(n4579), .Z(n4487)) /* synthesis lut_function=(!(A (B (C))+!A (B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam i3218_3_lut.init = 16'h3b3b;
    LUT4 temp1_7__I_0_799_i9_2_lut (.A(temp1[0]), .B(temp1[1]), .Z(n9)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(751[34:52])
    defparam temp1_7__I_0_799_i9_2_lut.init = 16'hbbbb;
    LUT4 i1_2_lut_2_lut_3_lut (.A(next_state[0]), .B(next_state[3]), .C(next_state[2]), 
         .Z(Carrier_PwrOn_N_1300)) /* synthesis lut_function=(!((B+(C))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam i1_2_lut_2_lut_3_lut.init = 16'h0202;
    LUT4 i1658_4_lut (.A(n_temp1_7__N_363), .B(clk_enable_2), .C(n_temp1_7__N_360), 
         .D(n8998), .Z(n5305)) /* synthesis lut_function=(A ((C+(D))+!B)+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1658_4_lut.init = 16'heae2;
    LUT4 i1_3_lut_adj_150 (.A(temp1[6]), .B(n18_adj_1424), .C(data0[7]), 
         .Z(n48)) /* synthesis lut_function=(A (B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_3_lut_adj_150.init = 16'h8a8a;
    LUT4 i1_2_lut_3_lut_4_lut_adj_151 (.A(n9532), .B(n9542), .C(dat_rdy_N_1321), 
         .D(temp1[3]), .Z(n4_adj_1443)) /* synthesis lut_function=(!(A+(B+((D)+!C)))) */ ;
    defparam i1_2_lut_3_lut_4_lut_adj_151.init = 16'h0010;
    LUT4 FPIO_isoCtrlRSTn_N_1288_bdd_3_lut_5261 (.A(n67), .B(next_state[0]), 
         .C(next_state[1]), .Z(n9275)) /* synthesis lut_function=(!(A+(B (C)+!B !(C)))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1288_bdd_3_lut_5261.init = 16'h1414;
    LUT4 temp1_1__bdd_4_lut (.A(temp1[5]), .B(temp1[0]), .C(temp1[2]), 
         .D(temp1[3]), .Z(n9486)) /* synthesis lut_function=(A (B+(C+!(D)))+!A (C+!(D))) */ ;
    defparam temp1_1__bdd_4_lut.init = 16'hf8ff;
    LUT4 temp1_1__bdd_3_lut (.A(temp1[0]), .B(temp1[2]), .C(temp1[3]), 
         .Z(n9487)) /* synthesis lut_function=(((C)+!B)+!A) */ ;
    defparam temp1_1__bdd_3_lut.init = 16'hf7f7;
    LUT4 temp1_7__I_0_795_i10_2_lut_rep_133 (.A(temp1[2]), .B(temp1[3]), 
         .Z(n9543)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(748[34:52])
    defparam temp1_7__I_0_795_i10_2_lut_rep_133.init = 16'hdddd;
    LUT4 i4_4_lut_adj_152 (.A(temp1[1]), .B(temp1[3]), .C(temp1[0]), .D(temp1[5]), 
         .Z(n10)) /* synthesis lut_function=(!(((C+!(D))+!B)+!A)) */ ;
    defparam i4_4_lut_adj_152.init = 16'h0800;
    LUT4 i1514_2_lut (.A(clk_enable_4), .B(debounce_inputs_asyn2[1]), .Z(clk_enable_118)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i1514_2_lut.init = 16'hdddd;
    LUT4 mux_1099_Mux_10_i6_3_lut_4_lut (.A(next_state_3__N_1086[2]), .B(FPIO_isoCtrlRSTn_N_1288), 
         .C(next_state[1]), .D(next_state[0]), .Z(n6_adj_1417)) /* synthesis lut_function=(A (C (D))+!A (B (C (D))+!B (C (D)+!C !(D)))) */ ;
    defparam mux_1099_Mux_10_i6_3_lut_4_lut.init = 16'hf001;
    LUT4 i1_4_lut_adj_153 (.A(wb_dat_o[4]), .B(wb_dat_o[2]), .C(n_temp1_7__N_358), 
         .D(n9566), .Z(n8937)) /* synthesis lut_function=(!(A (B+!(D))+!A !(B (C)+!B (C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_153.init = 16'h7350;
    LUT4 i1_4_lut_adj_154 (.A(FPIO_isoCtrlRSTn_N_1288), .B(n8990), .C(next_state[1]), 
         .D(next_state_3__N_1086[2]), .Z(FlexMIOs53_GPIO_PowerDown_N_1297)) /* synthesis lut_function=(A (B (C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam i1_4_lut_adj_154.init = 16'hc0c8;
    LUT4 i1_4_lut_adj_155 (.A(temp1[6]), .B(data0[6]), .C(n30_adj_1426), 
         .D(n33_adj_1412), .Z(data0_7__N_892[6])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_4_lut_adj_155.init = 16'hdc50;
    LUT4 i1_4_lut_adj_156 (.A(temp1[6]), .B(data0[0]), .C(n30_adj_1446), 
         .D(n33_adj_1412), .Z(data0_7__N_892[0])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_4_lut_adj_156.init = 16'hdc50;
    LUT4 i56_4_lut_adj_157 (.A(GPI_DAT[0]), .B(data0[0]), .C(temp1[5]), 
         .D(n5735), .Z(n30_adj_1446)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i56_4_lut_adj_157.init = 16'hcac0;
    LUT4 i56_4_lut_adj_158 (.A(GPI_DAT[6]), .B(data0[6]), .C(temp1[5]), 
         .D(n5735), .Z(n30_adj_1426)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i56_4_lut_adj_158.init = 16'hcac0;
    LUT4 i56_4_lut_adj_159 (.A(GPI_DAT[1]), .B(data0[1]), .C(temp1[5]), 
         .D(n5735), .Z(n30_adj_1434)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i56_4_lut_adj_159.init = 16'hcac0;
    LUT4 i4_4_lut_adj_160 (.A(temp1[0]), .B(n9541), .C(temp1[1]), .D(n6), 
         .Z(n5735)) /* synthesis lut_function=(!((B+(C+!(D)))+!A)) */ ;
    defparam i4_4_lut_adj_160.init = 16'h0200;
    LUT4 i1_2_lut_adj_161 (.A(temp1[3]), .B(temp1[2]), .Z(n6)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i1_2_lut_adj_161.init = 16'h4444;
    LUT4 i1_4_lut_adj_162 (.A(temp1[6]), .B(data0[5]), .C(n30_adj_1427), 
         .D(n33_adj_1412), .Z(data0_7__N_892[5])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_4_lut_adj_162.init = 16'hdc50;
    LUT4 i19_4_lut_adj_163 (.A(n_temp1_7__N_361), .B(n4_adj_1443), .C(clk_enable_2), 
         .D(n4_adj_1439), .Z(n8564)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(319[17:24])
    defparam i19_4_lut_adj_163.init = 16'hfaca;
    LUT4 i1_4_lut_adj_164 (.A(n9541), .B(temp1[5]), .C(n9488), .D(n36), 
         .Z(n33_adj_1412)) /* synthesis lut_function=(A+(B (C)+!B (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_4_lut_adj_164.init = 16'hfbfa;
    LUT4 i1_2_lut_adj_165 (.A(temp1[6]), .B(temp1[0]), .Z(n36)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_2_lut_adj_165.init = 16'hbbbb;
    LUT4 i56_4_lut_adj_166 (.A(GPI_DAT[5]), .B(data0[5]), .C(temp1[5]), 
         .D(n5735), .Z(n30_adj_1427)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i56_4_lut_adj_166.init = 16'hcac0;
    LUT4 i1_4_lut_else_3_lut_4_lut (.A(n_temp1_7__N_357), .B(n_temp1_7__N_355), 
         .C(n_temp1_7__N_364), .D(n15_adj_1407), .Z(n9564)) /* synthesis lut_function=(A+(B+(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_else_3_lut_4_lut.init = 16'hfeee;
    LUT4 FPIO_isoCtrlRSTn_N_1288_bdd_4_lut_5368 (.A(FPIO_isoCtrlRSTn_N_1288), 
         .B(n9059), .C(next_state[2]), .D(next_state[0]), .Z(n9495)) /* synthesis lut_function=(A (((D)+!C)+!B)+!A !(B (C+(D))+!B (D))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1288_bdd_4_lut_5368.init = 16'haa3f;
    LUT4 i1_4_lut_adj_167 (.A(temp1[6]), .B(data0[4]), .C(n30_adj_1429), 
         .D(n33_adj_1412), .Z(data0_7__N_892[4])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_4_lut_adj_167.init = 16'hdc50;
    LUT4 i56_4_lut_adj_168 (.A(GPI_DAT[4]), .B(data0[4]), .C(temp1[5]), 
         .D(n5735), .Z(n30_adj_1429)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i56_4_lut_adj_168.init = 16'hcac0;
    LUT4 FPIO_isoCtrlRSTn_N_1288_bdd_4_lut_5375 (.A(n9059), .B(next_state[2]), 
         .C(next_state[0]), .D(next_state_3__N_1086[2]), .Z(n9496)) /* synthesis lut_function=(!(A (B (C)+!B ((D)+!C))+!A !(B+!((D)+!C)))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1288_bdd_4_lut_5375.init = 16'h4c7c;
    VLO i1 (.Z(GND_net));
    LUT4 n9497_bdd_3_lut (.A(n9497), .B(n9494), .C(next_state[3]), .Z(n9498)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam n9497_bdd_3_lut.init = 16'hcaca;
    LUT4 n9507_bdd_2_lut (.A(n9520), .B(next_state[2]), .Z(n9508)) /* synthesis lut_function=(A+(B)) */ ;
    defparam n9507_bdd_2_lut.init = 16'heeee;
    LUT4 i2346_2_lut_4_lut (.A(n6863), .B(n9498), .C(n9539), .D(n4585), 
         .Z(n6023)) /* synthesis lut_function=(A (B (D))+!A !((C+!(D))+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam i2346_2_lut_4_lut.init = 16'h8c00;
    LUT4 i5229_4_lut (.A(n5739), .B(n48_adj_1430), .C(data0[3]), .D(n50_adj_1422), 
         .Z(data0_7__N_892[3])) /* synthesis lut_function=(!(A+(B+!(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i5229_4_lut.init = 16'h1011;
    LUT4 i1_4_lut_adj_169 (.A(GPI_DAT[3]), .B(n5735), .C(temp1[5]), .D(temp1[6]), 
         .Z(n5739)) /* synthesis lut_function=(A (B (C (D)))+!A (B (C (D)+!C !(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_4_lut_adj_169.init = 16'hc004;
    LUT4 i1_4_lut_adj_170 (.A(n4258), .B(n9867), .C(n12_adj_1457), .D(n8), 
         .Z(n9014)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_170.init = 16'hfffe;
    LUT4 i1_3_lut_adj_171 (.A(temp1[6]), .B(n18_adj_1424), .C(data0[3]), 
         .Z(n48_adj_1430)) /* synthesis lut_function=(A (B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_3_lut_adj_171.init = 16'h8a8a;
    LUT4 i2876_4_lut (.A(n6543), .B(next_state[3]), .C(next_state[1]), 
         .D(n7), .Z(next_state_3__N_64[2])) /* synthesis lut_function=(!(A (B (C)+!B !((D)+!C))+!A (B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(134[12:22])
    defparam i2876_4_lut.init = 16'h3a0a;
    LUT4 i5_4_lut (.A(n_temp1_7__N_362), .B(n_temp1_7__N_349), .C(n_temp1_7__N_352), 
         .D(n_temp1_7__N_363), .Z(n12_adj_1457)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i5_4_lut.init = 16'hfffe;
    LUT4 i1_2_lut_adj_172 (.A(n_temp1_7__N_364), .B(n_temp1_7__N_358), .Z(n8)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_2_lut_adj_172.init = 16'heeee;
    LUT4 i3_4_lut_adj_173 (.A(n_temp1_7__N_353), .B(n_temp1_7__N_350), .C(n_temp1_7__N_351), 
         .D(n9549), .Z(n4258)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i3_4_lut_adj_173.init = 16'hfffe;
    LUT4 i1515_2_lut (.A(clk_enable_128), .B(debounce_inputs_asyn2[2]), 
         .Z(clk_enable_87)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i1515_2_lut.init = 16'hdddd;
    LUT4 mux_1314_i8_4_lut (.A(next_state[1]), .B(n3101), .C(n4583), .D(n4579), 
         .Z(n4494)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1329[9] 1505[18])
    defparam mux_1314_i8_4_lut.init = 16'hf5c5;
    LUT4 i1_4_lut_adj_174 (.A(n12_adj_1428), .B(next_state[2]), .C(externstop_falling), 
         .D(n9546), .Z(n4585)) /* synthesis lut_function=(A+(B (C (D)))) */ ;
    defparam i1_4_lut_adj_174.init = 16'heaaa;
    LUT4 i1_4_lut_adj_175 (.A(next_state[3]), .B(externstop_falling), .C(next_state[2]), 
         .D(n9539), .Z(n12_adj_1428)) /* synthesis lut_function=(A (B (C+(D))+!B (C))) */ ;
    defparam i1_4_lut_adj_175.init = 16'ha8a0;
    LUT4 n3242_bdd_2_lut_5407 (.A(n9509), .B(FPIO_isoCtrlRSTn_N_1288), .Z(n9510)) /* synthesis lut_function=(A+!(B)) */ ;
    defparam n3242_bdd_2_lut_5407.init = 16'hbbbb;
    LUT4 i2_4_lut_adj_176 (.A(dat_count[0]), .B(n12_adj_1415), .C(n17), 
         .D(n15_adj_1409), .Z(n_dat_count[0])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i2_4_lut_adj_176.init = 16'hffec;
    LUT4 n4_bdd_4_lut_5251 (.A(n9540), .B(next_state[1]), .C(next_state_3__N_1086[2]), 
         .D(next_state[0]), .Z(n9269)) /* synthesis lut_function=(A (B (C (D)+!C !(D))+!B ((D)+!C))+!A ((C (D)+!C !(D))+!B)) */ ;
    defparam n4_bdd_4_lut_5251.init = 16'hf31f;
    LUT4 i1768_3_lut_4_lut (.A(n_temp1_7__N_360), .B(n9537), .C(n9014), 
         .D(clk_enable_2), .Z(n_wb_adr_i[6])) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1768_3_lut_4_lut.init = 16'h00fe;
    LUT4 i1_4_lut_adj_177 (.A(n9522), .B(data0[3]), .C(n8916), .D(n_temp1_7__N_360), 
         .Z(n74)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(294[16:23])
    defparam i1_4_lut_adj_177.init = 16'heca0;
    LUT4 i2875_4_lut (.A(next_state[0]), .B(n6540), .C(next_state[2]), 
         .D(FPIO_isoCtrlRSTn_N_1288), .Z(n7)) /* synthesis lut_function=(A ((D)+!C)+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(134[12:22])
    defparam i2875_4_lut.init = 16'hea4a;
    LUT4 i1_2_lut_3_lut_4_lut_adj_178 (.A(extern_connected), .B(signals_debounced_syn[2]), 
         .C(FPIO_isoCtrlRSTn_N_1288), .D(next_state[0]), .Z(n8953)) /* synthesis lut_function=(!(A ((C+!(D))+!B)+!A (C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1381[10:51])
    defparam i1_2_lut_3_lut_4_lut_adj_178.init = 16'h0d00;
    LUT4 wb_ack_o_I_0_2_lut_rep_142 (.A(wb_ack_o), .B(wb_stb_i), .Z(clk_enable_2)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(952[12:33])
    defparam wb_ack_o_I_0_2_lut_rep_142.init = 16'h8888;
    PFUMX i5295 (.BLUT(n9382), .ALUT(n14_adj_1448), .C0(next_state[3]), 
          .Z(next_state_3__N_64[0]));
    LUT4 i5242_4_lut (.A(clk_enable_2), .B(n_temp1_7__N_354), .C(n9079), 
         .D(n_temp1_7__N_361), .Z(n_wb_dat_i[2])) /* synthesis lut_function=(!(A+!(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i5242_4_lut.init = 16'h5554;
    LUT4 i1_4_lut_adj_179 (.A(next_state[2]), .B(next_state[3]), .C(n29), 
         .D(n35), .Z(n4583)) /* synthesis lut_function=(!(A (B+!(D))+!A !(B (C)+!B (C+(D))))) */ ;
    defparam i1_4_lut_adj_179.init = 16'h7350;
    LUT4 next_state_1__bdd_4_lut_5355_4_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(next_state[0]), .D(next_state[1]), .Z(FP_SysLEDr_N_1282)) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(B ((D)+!C)+!B (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(134[12:22])
    defparam next_state_1__bdd_4_lut_5355_4_lut.init = 16'h7504;
    LUT4 i58_4_lut (.A(next_state[1]), .B(n4862), .C(next_state[3]), .D(FPIO_isoCtrlRSTn_N_1288), 
         .Z(n29)) /* synthesis lut_function=(!(A (C+!(D))+!A (B+!(C)))) */ ;
    defparam i58_4_lut.init = 16'h1a10;
    LUT4 i5161_3_lut (.A(n_temp1_7__N_348), .B(data0[2]), .C(n_temp1_7__N_360), 
         .Z(n9079)) /* synthesis lut_function=(A+(B (C))) */ ;
    defparam i5161_3_lut.init = 16'heaea;
    LUT4 i1_4_lut_adj_180 (.A(next_state[0]), .B(n33_adj_1414), .C(n9011), 
         .D(next_state[1]), .Z(n35)) /* synthesis lut_function=(A (B+!((D)+!C))+!A (B+(C (D)))) */ ;
    defparam i1_4_lut_adj_180.init = 16'hdcec;
    LUT4 pushed_4__I_0_1_lut (.A(pushed[4]), .Z(pushed_4__N_291)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(462[17] 466[24])
    defparam pushed_4__I_0_1_lut.init = 16'h5555;
    LUT4 i60_3_lut (.A(next_state_3__N_1086[2]), .B(FPIO_isoCtrlRSTn_N_1288), 
         .C(next_state[0]), .Z(n4862)) /* synthesis lut_function=(!(A (B (C))+!A (B+!(C)))) */ ;
    defparam i60_3_lut.init = 16'h3a3a;
    LUT4 pushed_3__I_0_1_lut (.A(pushed[3]), .Z(pushed_3__N_293)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(462[17] 466[24])
    defparam pushed_3__I_0_1_lut.init = 16'h5555;
    LUT4 mux_1099_Mux_2_i15_4_lut_3_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(n9569), .Z(Carrier_PG_1V8_N_1396)) /* synthesis lut_function=(A (B)+!A !(B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(134[12:22])
    defparam mux_1099_Mux_2_i15_4_lut_3_lut.init = 16'h9898;
    LUT4 pushed_2__I_0_1_lut (.A(pushed[2]), .Z(pushed_2__N_295)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(462[17] 466[24])
    defparam pushed_2__I_0_1_lut.init = 16'h5555;
    LUT4 i1_2_lut_adj_181 (.A(n15_adj_1407), .B(n_temp1_7__N_364), .Z(n8985)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1300[5] 1308[15])
    defparam i1_2_lut_adj_181.init = 16'h8888;
    LUT4 i3277_2_lut_rep_134 (.A(next_state_3__N_1086[2]), .B(next_state[0]), 
         .Z(n9544)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i3277_2_lut_rep_134.init = 16'heeee;
    PFUMX i35 (.BLUT(n23), .ALUT(n19), .C0(next_state[1]), .Z(n17_adj_1450));
    LUT4 n22_bdd_4_lut_5265_4_lut_4_lut (.A(next_state_3__N_1086[2]), .B(next_state[0]), 
         .C(next_state[3]), .D(next_state[1]), .Z(n9279)) /* synthesis lut_function=(!(A (((D)+!C)+!B)+!A (B ((D)+!C)+!B !(C (D))))) */ ;
    defparam n22_bdd_4_lut_5265_4_lut_4_lut.init = 16'h10c0;
    LUT4 n9277_bdd_2_lut (.A(n9277), .B(next_state[3]), .Z(n9278)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam n9277_bdd_2_lut.init = 16'h2222;
    LUT4 i1_4_lut_adj_182 (.A(wb_dat_o[7]), .B(temp1[7]), .C(n9536), .D(n9053), 
         .Z(n_temp1[7])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_182.init = 16'ha0ec;
    LUT4 n3242_bdd_2_lut_5252_3_lut_3_lut (.A(next_state[2]), .B(n9269), 
         .C(next_state[3]), .Z(n9270)) /* synthesis lut_function=(A+(B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(134[12:22])
    defparam n3242_bdd_2_lut_5252_3_lut_3_lut.init = 16'hefef;
    LUT4 i1_4_lut_4_lut_adj_183 (.A(next_state[2]), .B(next_state[1]), .C(n8953), 
         .D(n9559), .Z(n18)) /* synthesis lut_function=(!(A+!(B (C)+!B (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(134[12:22])
    defparam i1_4_lut_4_lut_adj_183.init = 16'h5140;
    LUT4 i1_4_lut_adj_184 (.A(n_state_7__N_1034[4]), .B(temp1[6]), .C(n9536), 
         .D(n9053), .Z(n_temp1[6])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_184.init = 16'ha0ec;
    LUT4 i1_4_lut_adj_185 (.A(n8916), .B(n_temp1_7__N_355), .C(n4), .D(n9535), 
         .Z(n5331)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(319[17:24])
    defparam i1_4_lut_adj_185.init = 16'heca0;
    LUT4 i5220_4_lut_4_lut (.A(next_state[2]), .B(n17_adj_1450), .C(n8929), 
         .D(n5971), .Z(clk_enable_138)) /* synthesis lut_function=(!(A (C+(D))+!A (B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(134[12:22])
    defparam i5220_4_lut_4_lut.init = 16'h000b;
    LUT4 i1_2_lut_rep_117_3_lut_4_lut (.A(temp1[6]), .B(n9533), .C(temp1[3]), 
         .D(n9542), .Z(n9527)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(564[6] 570[15])
    defparam i1_2_lut_rep_117_3_lut_4_lut.init = 16'hfffe;
    LUT4 FPIO_isoCtrlRSTn_N_1288_bdd_4_lut_5367_4_lut (.A(next_state[2]), 
         .B(next_state[0]), .C(next_state[1]), .D(FPIO_isoCtrlRSTn_N_1288), 
         .Z(n9494)) /* synthesis lut_function=(A+!(B (C+!(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(134[12:22])
    defparam FPIO_isoCtrlRSTn_N_1288_bdd_4_lut_5367_4_lut.init = 16'hafab;
    PFUMX i5382 (.BLUT(n9561), .ALUT(n9562), .C0(temp1[3]), .Z(n76));
    LUT4 i55_4_lut_4_lut_4_lut (.A(next_state_3__N_1086[2]), .B(next_state[0]), 
         .C(FPIO_isoCtrlRSTn_N_1288), .D(next_state[2]), .Z(n30)) /* synthesis lut_function=(!(A (D)+!A (B+!(C (D))))) */ ;
    defparam i55_4_lut_4_lut_4_lut.init = 16'h10aa;
    LUT4 i3197_4_lut_4_lut_4_lut (.A(next_state[2]), .B(n6870), .C(next_state[1]), 
         .D(n9544), .Z(n14_adj_1448)) /* synthesis lut_function=(!(A+(B (C (D))+!B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(134[12:22])
    defparam i3197_4_lut_4_lut_4_lut.init = 16'h0454;
    LUT4 i1_4_lut_adj_186 (.A(wb_dat_o[5]), .B(temp1[5]), .C(n9536), .D(n9053), 
         .Z(n_temp1[5])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_186.init = 16'ha0ec;
    PFUMX i5464 (.BLUT(n9744), .ALUT(n9866), .C0(next_state[2]), .Z(next_state_3__N_64[1]));
    LUT4 i5177_4_lut_then_4_lut (.A(n14), .B(temp1[2]), .C(temp1[0]), 
         .D(temp1[1]), .Z(n9562)) /* synthesis lut_function=(A+(B+(C+!(D)))) */ ;
    defparam i5177_4_lut_then_4_lut.init = 16'hfeff;
    LUT4 mux_1099_Mux_11_i15_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), 
         .C(PPn_VIN_c), .D(next_state[3]), .Z(forceoutputdisable_N_11)) /* synthesis lut_function=(!(A (C+(D))+!A !(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(134[12:22])
    defparam mux_1099_Mux_11_i15_4_lut_4_lut.init = 16'h455f;
    LUT4 m1_lut (.Z(n9869)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    PFUMX i5461 (.BLUT(n9741), .ALUT(n9740), .C0(next_state[0]), .Z(n9742));
    LUT4 i7_4_lut (.A(dat_count[0]), .B(n14_adj_1425), .C(n10_adj_1459), 
         .D(dat_count[6]), .Z(n15_adj_1407)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1267[13:35])
    defparam i7_4_lut.init = 16'hfffe;
    LUT4 i1_4_lut_adj_187 (.A(wb_dat_o[4]), .B(temp1[4]), .C(n9536), .D(n9053), 
         .Z(n_temp1[4])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_187.init = 16'ha0ec;
    LUT4 i6_4_lut (.A(dat_count[3]), .B(dat_count[1]), .C(dat_count[5]), 
         .D(dat_count[7]), .Z(n14_adj_1425)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1267[13:35])
    defparam i6_4_lut.init = 16'hfffe;
    LUT4 i1_4_lut_4_lut_adj_188 (.A(next_state[2]), .B(next_state[0]), .C(next_state[3]), 
         .D(next_state[1]), .Z(FP_SysLEDg_N_1281)) /* synthesis lut_function=(!(A (C+(D))+!A !(B+!((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(134[12:22])
    defparam i1_4_lut_4_lut_adj_188.init = 16'h445e;
    PFUMX i2869 (.BLUT(n8363), .ALUT(n50), .C0(next_state[2]), .Z(n6543));
    LUT4 n22_bdd_3_lut_5378_3_lut_4_lut (.A(next_state_3__N_1086[2]), .B(next_state[0]), 
         .C(next_state[1]), .D(next_state[2]), .Z(n9314)) /* synthesis lut_function=(!(A+(B+(C+(D))))) */ ;
    defparam n22_bdd_3_lut_5378_3_lut_4_lut.init = 16'h0001;
    LUT4 FPIO_isoCtrlRSTn_N_1288_bdd_4_lut_5379_4_lut_4_lut (.A(next_state_3__N_1086[2]), 
         .B(next_state[0]), .C(next_state[2]), .D(next_state[1]), .Z(n9509)) /* synthesis lut_function=(!(A (B (C (D)))+!A (B (C (D))+!B !((D)+!C)))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1288_bdd_4_lut_5379_4_lut_4_lut.init = 16'h3fef;
    LUT4 i2_2_lut_adj_189 (.A(dat_count[2]), .B(dat_count[4]), .Z(n10_adj_1459)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1267[13:35])
    defparam i2_2_lut_adj_189.init = 16'heeee;
    LUT4 i31_2_lut_rep_136 (.A(next_state[0]), .B(next_state[1]), .Z(n9546)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;
    defparam i31_2_lut_rep_136.init = 16'h6666;
    LUT4 i5207_2_lut_2_lut_3_lut_3_lut_4_lut (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[3]), .D(next_state[2]), .Z(clk_enable_143)) /* synthesis lut_function=(A (B+((D)+!C))+!A (((D)+!C)+!B)) */ ;
    defparam i5207_2_lut_2_lut_3_lut_3_lut_4_lut.init = 16'hff9f;
    LUT4 i5177_4_lut_else_4_lut (.A(n14), .B(temp1[2]), .C(temp1[0]), 
         .D(temp1[1]), .Z(n9561)) /* synthesis lut_function=(A+(((D)+!C)+!B)) */ ;
    defparam i5177_4_lut_else_4_lut.init = 16'hffbf;
    LUT4 i1_4_lut_4_lut_adj_190 (.A(next_state[2]), .B(next_state[0]), .C(next_state[1]), 
         .D(FPIO_isoCtrlRSTn_N_1288), .Z(n33_adj_1414)) /* synthesis lut_function=(A (B (C (D))+!B !(C+!(D)))+!A (B (C (D)))) */ ;
    defparam i1_4_lut_4_lut_adj_190.init = 16'hc200;
    LUT4 i36_3_lut_4_lut (.A(next_state_3__N_1086[2]), .B(next_state[0]), 
         .C(next_state[3]), .D(FPIO_isoCtrlRSTn_N_1288), .Z(n19)) /* synthesis lut_function=(!(A (C+!(D))+!A !(B (C+(D))+!B !(C+!(D))))) */ ;
    defparam i36_3_lut_4_lut.init = 16'h4f40;
    LUT4 i1_4_lut_adj_191 (.A(wb_dat_o[3]), .B(temp1[3]), .C(n9536), .D(n9053), 
         .Z(n_temp1[3])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_191.init = 16'ha0ec;
    LUT4 i24_4_lut (.A(n43), .B(n48_adj_1458), .C(n37), .D(n38), .Z(FPIO_isoCtrlRSTn_N_1288)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i24_4_lut.init = 16'hfffe;
    LUT4 i18_4_lut (.A(counter[0]), .B(counter[14]), .C(counter[10]), 
         .D(counter[19]), .Z(n43)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i18_4_lut.init = 16'hfffe;
    LUT4 i1_4_lut_adj_192 (.A(wb_dat_o[2]), .B(temp1[2]), .C(n9536), .D(n9053), 
         .Z(n_temp1[2])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_192.init = 16'ha0ec;
    LUT4 i23_4_lut (.A(n27_adj_1456), .B(n46), .C(n40), .D(n28), .Z(n48_adj_1458)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i23_4_lut.init = 16'hfffe;
    LUT4 i1_4_lut_adj_193 (.A(wb_dat_o[1]), .B(temp1[1]), .C(n9536), .D(n9053), 
         .Z(n_temp1[1])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_4_lut_adj_193.init = 16'ha0ec;
    LUT4 i1617_1_lut (.A(Carrier_PG_1V8_N_1294), .Z(n5257)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1326[1] 1507[13])
    defparam i1617_1_lut.init = 16'h5555;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut (.A(DIGS3C_SlotD_ReqOE_c_5), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_5)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(439[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut.init = 16'h2222;
    LUT4 i12_2_lut (.A(counter[7]), .B(counter[12]), .Z(n37)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i12_2_lut.init = 16'heeee;
    LUT4 i1_3_lut_4_lut_4_lut (.A(next_state[2]), .B(n9559), .C(next_state[1]), 
         .D(next_state[3]), .Z(n8929)) /* synthesis lut_function=(!(A+!(B (C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(134[12:22])
    defparam i1_3_lut_4_lut_4_lut.init = 16'h4000;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut (.A(DIGS3C_SlotD_ReqOE_c_4), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_4)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(439[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut.init = 16'h2222;
    LUT4 i13_3_lut (.A(counter[8]), .B(counter[5]), .C(counter[6]), .Z(n38)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i13_3_lut.init = 16'hfefe;
    LUT4 i2_2_lut_adj_194 (.A(counter[17]), .B(counter[22]), .Z(n27_adj_1456)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2_2_lut_adj_194.init = 16'heeee;
    LUT4 i21_4_lut (.A(counter[11]), .B(n42), .C(n32), .D(counter[20]), 
         .Z(n46)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i21_4_lut.init = 16'hfffe;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut (.A(DIGS3C_SlotD_ReqOE_c_3), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_3)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(439[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut.init = 16'h2222;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut (.A(DIGS3C_SlotD_ReqOE_c_2), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_2)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(439[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut.init = 16'h2222;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut (.A(DIGS3C_SlotD_ReqOE_c_1), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_1)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(439[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut.init = 16'h2222;
    LUT4 ANL_S3C_CarrierReady_c_bdd_2_lut_5287_3_lut (.A(next_state_3__N_1086[2]), 
         .B(signals_debounced_syn[3]), .C(n9315), .Z(n9316)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(474[8:36])
    defparam ANL_S3C_CarrierReady_c_bdd_2_lut_5287_3_lut.init = 16'h4040;
    LUT4 i3234_3_lut_3_lut (.A(next_state[2]), .B(n6_adj_1417), .C(next_state[3]), 
         .Z(DIGS3C_Shared_ReqSafeState_N_1295)) /* synthesis lut_function=(!(A ((C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(134[12:22])
    defparam i3234_3_lut_3_lut.init = 16'h5d5d;
    LUT4 i15_4_lut (.A(counter[15]), .B(counter[3]), .C(counter[1]), .D(counter[24]), 
         .Z(n40)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i15_4_lut.init = 16'hfffe;
    LUT4 i3_2_lut_adj_195 (.A(counter[23]), .B(counter[4]), .Z(n28)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i3_2_lut_adj_195.init = 16'heeee;
    LUT4 i17_4_lut (.A(counter[2]), .B(counter[13]), .C(counter[9]), .D(counter[18]), 
         .Z(n42)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i17_4_lut.init = 16'hfffe;
    LUT4 i5226_4_lut_4_lut (.A(next_state[2]), .B(n33), .C(n9045), .D(n30), 
         .Z(clk_enable_41)) /* synthesis lut_function=(A (C+!(D))+!A !(B+!(C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(134[12:22])
    defparam i5226_4_lut_4_lut.init = 16'hb0bb;
    LUT4 i1_2_lut_3_lut_4_lut_adj_196 (.A(next_state_3__N_1086[2]), .B(signals_debounced_syn[3]), 
         .C(externstop_falling), .D(next_state[2]), .Z(n9011)) /* synthesis lut_function=(!(A+((C+!(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(474[8:36])
    defparam i1_2_lut_3_lut_4_lut_adj_196.init = 16'h0400;
    LUT4 i7_2_lut_adj_197 (.A(counter[16]), .B(counter[21]), .Z(n32)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i7_2_lut_adj_197.init = 16'heeee;
    LUT4 i5238_2_lut_3_lut (.A(next_state_3__N_1086[2]), .B(signals_debounced_syn[3]), 
         .C(externstop_falling), .Z(n9059)) /* synthesis lut_function=(!(A (C)+!A (B+(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(474[8:36])
    defparam i5238_2_lut_3_lut.init = 16'h0b0b;
    LUT4 i1_2_lut_rep_139 (.A(dat_rdy_N_1321), .B(reg_rdy_N_1317), .Z(n9549)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_rep_139.init = 16'heeee;
    LUT4 i1_2_lut_3_lut_adj_198 (.A(dat_rdy_N_1321), .B(reg_rdy_N_1317), 
         .C(n_temp1_7__N_360), .Z(n9028)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i1_2_lut_3_lut_adj_198.init = 16'hfefe;
    PFUMX i53 (.BLUT(n8975), .ALUT(n36_adj_1453), .C0(next_state[1]), 
          .Z(n27));
    LUT4 i1_3_lut_rep_140 (.A(n_temp1_7__N_354), .B(n_temp1_7__N_361), .C(n_temp1_7__N_348), 
         .Z(n9550)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_3_lut_rep_140.init = 16'hfefe;
    PFUMX i5388 (.BLUT(n9570), .ALUT(n9571), .C0(next_state_3__N_1086[2]), 
          .Z(clk_enable_17));
    LUT4 i1_2_lut_rep_127_4_lut (.A(n_temp1_7__N_354), .B(n_temp1_7__N_361), 
         .C(n_temp1_7__N_348), .D(n_temp1_7__N_347), .Z(n9537)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i1_2_lut_rep_127_4_lut.init = 16'hfffe;
    PFUMX i5293 (.BLUT(n9380), .ALUT(n9379), .C0(next_state[0]), .Z(n9381));
    LUT4 i2_3_lut_rep_141 (.A(resetcounter[24]), .B(resetcounter[23]), .C(resetcounter[22]), 
         .Z(n9551)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(505[6:29])
    defparam i2_3_lut_rep_141.init = 16'h8080;
    LUT4 i5223_4_lut (.A(n9270), .B(n5971), .C(n9556), .D(n5990), .Z(clk_enable_136)) /* synthesis lut_function=(!((B+!(C+(D)))+!A)) */ ;
    defparam i5223_4_lut.init = 16'h2220;
    PFUMX i5386 (.BLUT(n9559), .ALUT(n9568), .C0(next_state[1]), .Z(n9569));
    LUT4 i11_4_lut (.A(n_temp1_7__N_350), .B(n_temp1_7__N_349), .C(clk_enable_2), 
         .D(n_state_7__N_1034[4]), .Z(n8876)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(829[6] 1321[10])
    defparam i11_4_lut.init = 16'h0aca;
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    PFUMX i5266 (.BLUT(n9316), .ALUT(n9314), .C0(next_state[3]), .Z(n4579));
    PFUMX i5384 (.BLUT(n9564), .ALUT(n9565), .C0(n_temp1_7__N_363), .Z(n9566));
    LUT4 next_state_1__bdd_4_lut_5347 (.A(next_state[1]), .B(next_state[2]), 
         .C(externstop_falling), .D(next_state[0]), .Z(n9315)) /* synthesis lut_function=(!(A ((C+(D))+!B)+!A ((C+!(D))+!B))) */ ;
    defparam next_state_1__bdd_4_lut_5347.init = 16'h0408;
    TSALL TSALL_INST (.TSALL(GND_net));
    
endmodule
//
// Verilog Description of module efb_vhdl
//

module efb_vhdl (clk, n9558, wb_stb_i, wb_we_i, GND_net, \wb_adr_i[6] , 
            \wb_adr_i[2] , \wb_adr_i[1] , \wb_adr_i[0] , wb_dat_i, \wb_dat_o[7] , 
            \n_state_7__N_1034[4] , \wb_dat_o[5] , \wb_dat_o[4] , \wb_dat_o[3] , 
            \wb_dat_o[2] , \wb_dat_o[1] , \wb_dat_o[0] , wb_ack_o, i2c1_sdaoen, 
            i2c1_sdao, i2c1_scloen, i2c1_sclo, i2c1_sdai, i2c1_scli, 
            VCC_net) /* synthesis NGD_DRC_MASK=1 */ ;
    input clk;
    input n9558;
    input wb_stb_i;
    input wb_we_i;
    input GND_net;
    input \wb_adr_i[6] ;
    input \wb_adr_i[2] ;
    input \wb_adr_i[1] ;
    input \wb_adr_i[0] ;
    input [7:0]wb_dat_i;
    output \wb_dat_o[7] ;
    output \n_state_7__N_1034[4] ;
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
    
    wire clk /* synthesis SET_AS_NETWORK=clk, is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(125[9:12])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(40[12:21])
    
    EFB EFBInst_0 (.WBCLKI(clk), .WBRSTI(n9558), .WBCYCI(wb_stb_i), .WBSTBI(wb_stb_i), 
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
        .WBDATO6(\n_state_7__N_1034[4] ), .WBDATO7(\wb_dat_o[7] ), .WBACKO(wb_ack_o), 
        .I2C1SCLO(i2c1_sclo), .I2C1SCLOEN(i2c1_scloen), .I2C1SDAO(i2c1_sdao), 
        .I2C1SDAOEN(i2c1_sdaoen)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=361, LSE_RLINE=361 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(361[7:15])
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
//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

