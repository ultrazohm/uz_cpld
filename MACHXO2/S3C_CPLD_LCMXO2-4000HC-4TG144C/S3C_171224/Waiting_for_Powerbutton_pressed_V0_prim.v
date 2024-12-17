// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Tue Dec 17 17:55:00 2024
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
            TDnALERT, S3C_S1);   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(7[8:42])
    output FP_SysLEDg;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(12[3:13])
    output FP_SysLEDr;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(13[3:13])
    output FP_SysLEDb;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(14[3:13])
    output FlexIO05;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(15[3:11])
    input FlexIO04;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(16[3:11])
    input FlexIO03;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(17[3:11])
    output FlexIO02;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(18[3:11])
    output FlexIO01;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(19[3:11])
    input FP_UsrSW1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(20[3:12])
    input FP_UsrSW2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(21[3:12])
    input SCL /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(23[3:6])
    input SDA /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(24[3:6])
    input FP_UsrSW3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(25[3:12])
    input SysSW_Pwr_NC;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(26[3:15])
    output FPIO_isoCtrlRSTn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(27[3:19])
    input FPIO_iosCtrlINTn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(28[3:19])
    output Carrier_PG_3V3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(29[3:17])
    input FPIO_ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(30[3:20])
    inout FPIO_FlexMIO28;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(31[3:17])
    inout FPIO_FlexMIO27;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(32[3:17])
    inout FPIO_FlexMIO30;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(33[3:17])
    inout FPIO_FlexMIO29;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(34[3:17])
    output FPIO_FlexMIO52;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(35[3:17])
    output Carrier_PG_1V8;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(37[3:17])
    input S3CsI2C_SDA /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(38[3:14])
    input S3CsI2C_SCL /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(39[3:14])
    output FP_SysLEDs;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(40[3:13])
    input SD1_CD;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(41[3:9])
    input SD0_CD;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(42[3:9])
    input SPI_S3C_nCS_USR;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(43[3:18])
    output [4:1]FP_UsrLED;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(45[3:12])
    output DIGS3C_Shared_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(46[3:29])
    output DIGS3C_Shared_ReqSafeState;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(47[3:29])
    input [5:1]DIGS3C_SlotD_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(48[3:21])
    input [5:1]DIGS3C_SlotD_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(49[3:22])
    input [5:0]FlexLIO;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(50[3:10])
    inout DIG5S3C26;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(52[3:12])
    inout DIG5S3C25;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(53[3:12])
    inout DIG5S3C24;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(54[3:12])
    output SD_SEL;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(55[3:9])
    input FlexMIOs52_PCIe;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(58[3:18])
    output FlexMIOs53_GPIO_PowerDown;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(59[3:28])
    inout FlexMIOs54;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(60[3:13])
    output FlexMio61ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(61[3:24])
    inout FlexMIOs62;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(62[3:13])
    inout FlexMIOs63;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(63[3:13])
    inout FlexMIOs31;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(64[3:13])
    inout FlexMIOs30;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(65[3:13])
    inout FlexMIOs29;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(66[3:13])
    inout FlexMIOs28;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(67[3:13])
    inout FlexMIOs27;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(68[3:13])
    inout FlexMIOs26;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(69[3:13])
    input FlexMIOs45 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(70[3:13])
    inout FlexMIOs37;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(71[3:13])
    inout FlexMIOs36;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(72[3:13])
    inout FlexMIOs35;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(73[3:13])
    inout FlexMIOs34;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(74[3:13])
    inout FlexMIOs33;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[3:13])
    inout FlexMIOs32;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(76[3:13])
    inout DIG5S3C03;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(78[3:12])
    inout DIG5S3C04;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(79[3:12])
    inout DIG5S3C05;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(80[3:12])
    inout DIG5S3C00;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(81[3:12])
    inout DIG5S3C02;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(82[3:12])
    inout DIG5S3C01;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(83[3:12])
    inout DIG5S3C29;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(84[3:12])
    inout DIG5S3C28;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(85[3:12])
    inout DIG5S3C27;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(86[3:12])
    input [3:1]ANL_S3C_SLOTOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(89[3:17])
    output ANL_S3C_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(90[3:23])
    input ANL_S3C_P54_Legacy /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(91[3:21])
    output [5:1]DIGS3C_SlotD_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(92[3:22])
    output Carrier_PwrOn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(95[9:22])
    input PG_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(96[3:9])
    input PPn_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(97[3:10])
    input PG_Module;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(98[3:12])
    input TDnSHDN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(99[3:10])
    input TDnFFnFS /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(100[3:11])
    input TDnALERT;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(101[3:11])
    input S3C_S1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(102[3:9])
    
    wire clk /* synthesis is_clock=1, SET_AS_NETWORK=clk */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(108[9:12])
    wire dummy_signal /* synthesis noclip="on" */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(158[9:21])
    
    wire GND_net, VCC_net, FP_SysLEDg_c, FP_SysLEDr_c, FP_SysLEDb_c, 
        FlexIO04_c, FlexIO03_c, FP_UsrSW1_c, FP_UsrSW2_c, SCL_c, SDA_c, 
        FP_UsrSW3_c, SysSW_Pwr_NC_c, FPIO_isoCtrlRSTn_c, FPIO_iosCtrlINTn_c, 
        Carrier_PG_3V3_c, FlexMio61ExternalStop_c_c, FPIO_FlexMIO52_c_c, 
        n4947, S3CsI2C_SDA_c, S3CsI2C_SCL_c, FP_SysLEDs_c, SD1_CD_c, 
        SD0_CD_c, SPI_S3C_nCS_USR_c, FP_UsrLED_c_4, DIGS3C_Shared_ReqSafeState_c, 
        DIGS3C_SlotD_ReqOE_c_5, DIGS3C_SlotD_ReqOE_c_4, DIGS3C_SlotD_ReqOE_c_3, 
        DIGS3C_SlotD_ReqOE_c_2, DIGS3C_SlotD_ReqOE_c_1, DIGS3C_SlotD_SlotOK_c_5, 
        DIGS3C_SlotD_SlotOK_c_4, DIGS3C_SlotD_SlotOK_c_3, DIGS3C_SlotD_SlotOK_c_2, 
        DIGS3C_SlotD_SlotOK_c_1, FlexLIO_c_5, FlexLIO_c_4, FlexLIO_c_3, 
        FlexLIO_c_2, FlexLIO_c_1, FlexLIO_c_0, n5256, FlexMIOs53_GPIO_PowerDown_c, 
        n4946, FlexMIOs45_c, n7, ANL_S3C_SLOTOK_c_3, ANL_S3C_SLOTOK_c_2, 
        ANL_S3C_SLOTOK_c_1, ANL_S3C_P54_Legacy_c, DIGS3C_SlotD_SlotOE_c_5, 
        DIGS3C_SlotD_SlotOE_c_4, DIGS3C_SlotD_SlotOE_c_3, DIGS3C_SlotD_SlotOE_c_2, 
        DIGS3C_SlotD_SlotOE_c_1, Carrier_PwrOn_c, PG_VIN_c, PPn_VIN_c, 
        PG_Module_c, TDnSHDN_c, TDnFFnFS_c, TDnALERT_c, S3C_S1_c;
    wire [24:0]counter;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(109[9:16])
    wire [3:0]next_state;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(115[12:22])
    wire [31:0]\debounce_counters[1] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(122[12:29])
    wire [31:0]\debounce_counters[2] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(122[12:29])
    wire [31:0]\debounce_counters[3] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(122[12:29])
    wire [31:0]\debounce_counters[4] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(122[12:29])
    
    wire n28, n6, n10, clk_enable_112, n29, n26, n4945, n4972, 
        n5249, n5606, n32, n5274, n4944, n4943, n4942, n4941, 
        n4940;
    wire [6:1]debounce_inputs_asyn1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(124[12:33])
    wire [6:1]debounce_inputs_asyn2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(125[9:30])
    
    wire n4939;
    wire [6:1]pushed;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(126[9:15])
    wire [6:1]signals_debounced_syn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(127[12:33])
    
    wire externstop_falling, externstop_last, forceoutputdisable, n4971, 
        n4938, n4937, n5605, n4970, n4936, n4935, n4934, n4933, 
        n4932, n32_adj_1, n4931, n5416, n4930, n126, n4969, n66, 
        n4968, n175, n176, n177, n178, n179, n180, n181, n182, 
        n183, n184, n185, n186, n187, n188, n189, n190, n191, 
        n192, n193, n194, n195, n196, n197, n198, n199, n200, 
        n201, n202, n203, n204, n205, n206, n4967, n4929, n4966, 
        n4928, n124, n4927, n4926, n4925, n3540, n4924, n4965, 
        clk_enable_111, n4923, n4964, n122, n4963, n120, pushed_1__N_267, 
        DIG5S3C27_out, n4922, n281, n282, n283, n284, n285, n286, 
        n287, n288, n289, n290, n291, n292, n293, n294, n295, 
        n296, n297, n298, n299, n300, n301, n302, n303, n304, 
        n305, n306, n307, n308, n309, n310, n311, n312, n5604, 
        n3646, n3649, n5312, n59, n5415, n118, n4962, n116, 
        n3664, n4921, clk_enable_122, n5308, pushed_2__N_265, DIG5S3C28_out, 
        n387, n388, n389, n390, n391, n392, n393, n394, n395, 
        n396, n397, n398, n399, n400, n401, n402, n403, n404, 
        n405, n406, n407, n408, n409, n410, n411, n412, n413, 
        n414, n415, n416, n417, n418, n70, n4961, n5603, clk_enable_115, 
        n4960, n4959, n4920, n4958, n4957, n4956, n4919, clk_enable_113, 
        n4955, n114, pushed_3__N_263, n493, n494, n495, n496, 
        n497, n498, n499, n500, n501, n502, n503, n504, n505, 
        n506, n507, n508, n509, n510, n511, n512, n513, n514, 
        n515, n516, n517, n518, n519, n520, n521, n522, n523, 
        n524, n4954, n3773, n113, n4953, n112, n3761, n3762, 
        n14, n4952, n110, n4951, n4918, n4917, n4950, n4949, 
        n4916, n4915, n5414, pushed_4__N_261, DIG5S3C29_out, n4914, 
        n4913, n4912, n4911, n108, n4910, n4909, n4908, n4907, 
        n4906, n5602, n5219, n5595, n5601, n4905, clk_enable_22, 
        clk_enable_141, n5612, n106, n4904, clk_enable_77, n105, 
        DIG5S3C01_out, n4903, n4902, n4901, n104, n4900, n5610, 
        n4899, n4898, n4897, n4896, n4895, n4894, n4893, n4892, 
        n4891, n4890, n3185, n4889, n4888, n4887, n4886, n102, 
        n43, n100, externstop_falling_N_709, n4885, n4884, n23, 
        DIG5S3C02_out, n4883, DIG5S3C00_out, DIG5S3C05_out, clk_enable_118, 
        clk_enable_117, n17, n19, FP_UsrLED_4__N_3, DIG5S3C04_out, 
        clk_enable_108, clk_enable_20, n4882, DIG5S3C03_out, FlexMIOs32_out, 
        n98, FlexMIOs33_out, FlexMIOs34_out, FlexMIOs35_out, n49, 
        n45, n4881, n4880, n4879, clk_enable_5, FlexMIOs36_out;
    wire [3:0]next_state_3__N_484;
    
    wire n3965, FlexMIOs37_out, FlexMIOs26_out, FlexMIOs27_out, FlexMIOs28_out, 
        n5226, n5615, FlexMIOs29_out, n11, n4878, n94, n42, n74, 
        n2565, FlexMIOs30_out, clk_enable_120, n5224, n29_adj_2, n5573, 
        FlexMIOs31_out, n5572, n2563, n2559, n5623, n4877, FlexMIOs63_out, 
        n4876, n4875, n3526, n4874, n4873, n2401, n5609, n2394, 
        n4872, n5596, n4871, n2507, n2506, n2503, n4870, n2497, 
        n2496, n2495, n2493, n2492, n2491, n4869, n5543, n5542, 
        n5541, n5540, n5539, n90, n4868, FlexMIOs62_out, n89, 
        n4867, n4866, n4865, n4864, n2475, n4863, n2473, n2472, 
        n2471, n2470, n2468, n2466, n2465, n2464, n4862, FlexMIOs53_GPIO_PowerDown_N_700;
    wire [3:0]next_state_3__N_488;
    
    wire n1681, n1682, n1683, n1684, n1685, n1686, n1687, n1688, 
        n1689, n1690, n1691, n1692, n1693, n1694, n1695, n1696, 
        n1697, n1698, n1699, n1700, n1701, n1702, n1703, n1704, 
        n1705, n2463, n2462, n2461, FlexMIOs54_out, n5258, n5622, 
        n4861, n5225, forceoutputdisable_N_6, FlexMIOs53_GPIO_PowerDown_N_699, 
        FP_SysLEDr_N_684, FP_SysLEDb_N_685, FP_SysLEDg_N_683;
    wire [3:0]next_state_3__N_34;
    
    wire Carrier_PwrOn_N_702, n48, FPIO_isoCtrlRSTn_N_686, n26_adj_3, 
        n5620, n5528, n27, n3531, n5527, n37, n5525, n5524, 
        n5619, n3947, n5523, FP_SysLEDs_N_696, n4860, n5522, n5599, 
        n5618, Carrier_PG_1V8_N_774, n29_adj_4, Carrier_PG_1V8_N_781, 
        Carrier_PG_1V8_N_695, n4, n86, n5244, n4859, DIG5S3C24_out, 
        clk_enable_116, DIG5S3C25_out, DIG5S3C26_out, FPIO_FlexMIO29_out, 
        FPIO_FlexMIO30_out, FPIO_FlexMIO27_out, FPIO_FlexMIO28_out, n38, 
        n5514, n5513, n5512, n5511, clk_enable_109, n5510, n4858, 
        n4857, n5616, n4856, n46, n78, n74_adj_5, n40, clk_enable_110, 
        n73, n4855, n4854, n5614, n5613, n5787, clk_enable_43, 
        clk_enable_130, clk_enable_172, clk_enable_107, n4853, n70_adj_6, 
        n4852, n4851, n4850, n3108, n4849, n2796, n5611, n4848;
    
    VHI i2 (.Z(VCC_net));
    LUT4 mux_613_i24_4_lut (.A(n1682), .B(n5606), .C(n2565), .D(n3185), 
         .Z(n2492)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam mux_613_i24_4_lut.init = 16'h303a;
    LUT4 mux_613_i25_4_lut (.A(n1681), .B(n5606), .C(n2565), .D(n3185), 
         .Z(n2491)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam mux_613_i25_4_lut.init = 16'h303a;
    LUT4 i2_2_lut (.A(FlexMIOs35_out), .B(S3C_S1_c), .Z(n66)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i2_2_lut.init = 16'h8888;
    CCU2D add_2467_12 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4965), .COUT(n4966));
    defparam add_2467_12.INIT0 = 16'h5555;
    defparam add_2467_12.INIT1 = 16'h5555;
    defparam add_2467_12.INJECT1_0 = "NO";
    defparam add_2467_12.INJECT1_1 = "NO";
    LUT4 i62_4_lut (.A(n105), .B(n124), .C(n118), .D(n106), .Z(n126)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i62_4_lut.init = 16'h8000;
    CCU2D add_194_25 (.A0(\debounce_counters[4] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4919), .COUT(n4920), .S0(n501), 
          .S1(n500));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_25.INIT0 = 16'h5aaa;
    defparam add_194_25.INIT1 = 16'h5aaa;
    defparam add_194_25.INJECT1_0 = "NO";
    defparam add_194_25.INJECT1_1 = "NO";
    CCU2D add_2467_10 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4964), .COUT(n4965));
    defparam add_2467_10.INIT0 = 16'h5555;
    defparam add_2467_10.INIT1 = 16'h5555;
    defparam add_2467_10.INJECT1_0 = "NO";
    defparam add_2467_10.INJECT1_1 = "NO";
    CCU2D add_2466_14 (.A0(\debounce_counters[4] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4853), .COUT(n4854));
    defparam add_2466_14.INIT0 = 16'h5555;
    defparam add_2466_14.INIT1 = 16'h5555;
    defparam add_2466_14.INJECT1_0 = "NO";
    defparam add_2466_14.INJECT1_1 = "NO";
    CCU2D add_2467_8 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4963), .COUT(n4964));
    defparam add_2467_8.INIT0 = 16'h5555;
    defparam add_2467_8.INIT1 = 16'h5aaa;
    defparam add_2467_8.INJECT1_0 = "NO";
    defparam add_2467_8.INJECT1_1 = "NO";
    CCU2D add_176_33 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4891), .S0(n281));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_33.INIT0 = 16'h5aaa;
    defparam add_176_33.INIT1 = 16'h0000;
    defparam add_176_33.INJECT1_0 = "NO";
    defparam add_176_33.INJECT1_1 = "NO";
    CCU2D add_2467_6 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4962), .COUT(n4963));
    defparam add_2467_6.INIT0 = 16'h5555;
    defparam add_2467_6.INIT1 = 16'h5aaa;
    defparam add_2467_6.INJECT1_0 = "NO";
    defparam add_2467_6.INJECT1_1 = "NO";
    LUT4 i60_3_lut (.A(next_state_3__N_488[2]), .B(FP_UsrLED_4__N_3), .C(next_state[0]), 
         .Z(n2796)) /* synthesis lut_function=(!(A (B (C))+!A (B+!(C)))) */ ;
    defparam i60_3_lut.init = 16'h3a3a;
    CCU2D add_2467_4 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4961), .COUT(n4962));
    defparam add_2467_4.INIT0 = 16'h5555;
    defparam add_2467_4.INIT1 = 16'h5555;
    defparam add_2467_4.INJECT1_0 = "NO";
    defparam add_2467_4.INJECT1_1 = "NO";
    CCU2D add_194_23 (.A0(\debounce_counters[4] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4918), .COUT(n4919), .S0(n503), 
          .S1(n502));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_23.INIT0 = 16'h5aaa;
    defparam add_194_23.INIT1 = 16'h5aaa;
    defparam add_194_23.INJECT1_0 = "NO";
    defparam add_194_23.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i4 (.D(n1701), .SP(clk_enable_141), .CD(n3531), 
            .CK(clk), .Q(counter[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i4.GSR = "ENABLED";
    CCU2D add_176_31 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4890), .COUT(n4891), .S0(n283), 
          .S1(n282));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_31.INIT0 = 16'h5aaa;
    defparam add_176_31.INIT1 = 16'h5aaa;
    defparam add_176_31.INJECT1_0 = "NO";
    defparam add_176_31.INJECT1_1 = "NO";
    CCU2D add_2467_2 (.A0(\debounce_counters[3] [7]), .B0(\debounce_counters[3] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[3] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n4961));
    defparam add_2467_2.INIT0 = 16'h1000;
    defparam add_2467_2.INIT1 = 16'h5aaa;
    defparam add_2467_2.INJECT1_0 = "NO";
    defparam add_2467_2.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i3 (.D(n1702), .SP(clk_enable_141), .CD(n3531), 
            .CK(clk), .Q(counter[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i3.GSR = "ENABLED";
    CCU2D add_194_21 (.A0(\debounce_counters[4] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4917), .COUT(n4918), .S0(n505), 
          .S1(n504));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_21.INIT0 = 16'h5aaa;
    defparam add_194_21.INIT1 = 16'h5aaa;
    defparam add_194_21.INJECT1_0 = "NO";
    defparam add_194_21.INJECT1_1 = "NO";
    LUT4 mux_604_i21_4_lut (.A(next_state[1]), .B(n1685), .C(n2563), .D(n2559), 
         .Z(n2461)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam mux_604_i21_4_lut.init = 16'hf5c5;
    CCU2D add_176_29 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4889), .COUT(n4890), .S0(n285), 
          .S1(n284));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_29.INIT0 = 16'h5aaa;
    defparam add_176_29.INIT1 = 16'h5aaa;
    defparam add_176_29.INJECT1_0 = "NO";
    defparam add_176_29.INJECT1_1 = "NO";
    CCU2D add_194_19 (.A0(\debounce_counters[4] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4916), .COUT(n4917), .S0(n507), 
          .S1(n506));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_19.INIT0 = 16'h5aaa;
    defparam add_194_19.INIT1 = 16'h5aaa;
    defparam add_194_19.INJECT1_0 = "NO";
    defparam add_194_19.INJECT1_1 = "NO";
    CCU2D add_167_19 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4868), .COUT(n4869), .S0(n189), 
          .S1(n188));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_19.INIT0 = 16'h5aaa;
    defparam add_167_19.INIT1 = 16'h5aaa;
    defparam add_167_19.INJECT1_0 = "NO";
    defparam add_167_19.INJECT1_1 = "NO";
    CCU2D add_2466_12 (.A0(\debounce_counters[4] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4852), .COUT(n4853));
    defparam add_2466_12.INIT0 = 16'h5555;
    defparam add_2466_12.INIT1 = 16'h5555;
    defparam add_2466_12.INJECT1_0 = "NO";
    defparam add_2466_12.INJECT1_1 = "NO";
    CCU2D add_2468_26 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4960), .S1(clk_enable_108));
    defparam add_2468_26.INIT0 = 16'hf555;
    defparam add_2468_26.INIT1 = 16'h0000;
    defparam add_2468_26.INJECT1_0 = "NO";
    defparam add_2468_26.INJECT1_1 = "NO";
    CCU2D add_2468_24 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4959), .COUT(n4960));
    defparam add_2468_24.INIT0 = 16'h5555;
    defparam add_2468_24.INIT1 = 16'h5555;
    defparam add_2468_24.INJECT1_0 = "NO";
    defparam add_2468_24.INJECT1_1 = "NO";
    LUT4 i41_4_lut (.A(FlexLIO_c_3), .B(FlexMIOs26_out), .C(FlexLIO_c_5), 
         .D(FlexMIOs29_out), .Z(n105)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i41_4_lut.init = 16'h8000;
    CCU2D add_176_27 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4888), .COUT(n4889), .S0(n287), 
          .S1(n286));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_27.INIT0 = 16'h5aaa;
    defparam add_176_27.INIT1 = 16'h5aaa;
    defparam add_176_27.INJECT1_0 = "NO";
    defparam add_176_27.INJECT1_1 = "NO";
    CCU2D add_2468_22 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4958), .COUT(n4959));
    defparam add_2468_22.INIT0 = 16'h5555;
    defparam add_2468_22.INIT1 = 16'h5555;
    defparam add_2468_22.INJECT1_0 = "NO";
    defparam add_2468_22.INJECT1_1 = "NO";
    CCU2D add_167_17 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4867), .COUT(n4868), .S0(n191), 
          .S1(n190));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_17.INIT0 = 16'h5aaa;
    defparam add_167_17.INIT1 = 16'h5aaa;
    defparam add_167_17.INJECT1_0 = "NO";
    defparam add_167_17.INJECT1_1 = "NO";
    CCU2D add_194_17 (.A0(\debounce_counters[4] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4915), .COUT(n4916), .S0(n509), 
          .S1(n508));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_17.INIT0 = 16'h5aaa;
    defparam add_194_17.INIT1 = 16'h5aaa;
    defparam add_194_17.INJECT1_0 = "NO";
    defparam add_194_17.INJECT1_1 = "NO";
    CCU2D add_194_15 (.A0(\debounce_counters[4] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4914), .COUT(n4915), .S0(n511), 
          .S1(n510));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_15.INIT0 = 16'h5aaa;
    defparam add_194_15.INIT1 = 16'h5aaa;
    defparam add_194_15.INJECT1_0 = "NO";
    defparam add_194_15.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i0 (.D(n524), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i0.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i0 (.D(n206), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i0.GSR = "ENABLED";
    LUT4 i1_4_lut (.A(next_state[2]), .B(next_state[3]), .C(n29_adj_2), 
         .D(n5614), .Z(n2563)) /* synthesis lut_function=(!(A (B+!(D))+!A !(B (C)+!B (C+(D))))) */ ;
    defparam i1_4_lut.init = 16'h7350;
    LUT4 i2824_3_lut_rep_77_4_lut (.A(next_state[1]), .B(n5603), .C(n5312), 
         .D(n3965), .Z(clk_enable_141)) /* synthesis lut_function=(A (C)+!A (B (C (D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i2824_3_lut_rep_77_4_lut.init = 16'hf0b0;
    CCU2D add_194_13 (.A0(\debounce_counters[4] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4913), .COUT(n4914), .S0(n513), 
          .S1(n512));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_13.INIT0 = 16'h5aaa;
    defparam add_194_13.INIT1 = 16'h5aaa;
    defparam add_194_13.INJECT1_0 = "NO";
    defparam add_194_13.INJECT1_1 = "NO";
    FD1S3AY debounce_inputs_asyn2_i1 (.D(debounce_inputs_asyn1[1]), .CK(clk), 
            .Q(debounce_inputs_asyn2[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_inputs_asyn2_i1.GSR = "ENABLED";
    LUT4 i2811_2_lut (.A(next_state[1]), .B(next_state[0]), .Z(n5274)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(115[12:22])
    defparam i2811_2_lut.init = 16'hbbbb;
    LUT4 i58_4_lut (.A(next_state[1]), .B(n2796), .C(next_state[3]), .D(FP_UsrLED_4__N_3), 
         .Z(n29_adj_2)) /* synthesis lut_function=(!(A (C+!(D))+!A (B+!(C)))) */ ;
    defparam i58_4_lut.init = 16'h1a10;
    CCU2D add_2468_20 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4957), .COUT(n4958));
    defparam add_2468_20.INIT0 = 16'h5555;
    defparam add_2468_20.INIT1 = 16'h5555;
    defparam add_2468_20.INJECT1_0 = "NO";
    defparam add_2468_20.INJECT1_1 = "NO";
    FD1P3IX pushed_i1 (.D(n5787), .SP(clk_enable_5), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(pushed[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam pushed_i1.GSR = "ENABLED";
    CCU2D add_2468_18 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4956), .COUT(n4957));
    defparam add_2468_18.INIT0 = 16'h5555;
    defparam add_2468_18.INIT1 = 16'h5555;
    defparam add_2468_18.INJECT1_0 = "NO";
    defparam add_2468_18.INJECT1_1 = "NO";
    LUT4 i60_4_lut (.A(n89), .B(n120), .C(n110), .D(n90), .Z(n124)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i60_4_lut.init = 16'h8000;
    CCU2D add_2468_16 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4955), .COUT(n4956));
    defparam add_2468_16.INIT0 = 16'h5555;
    defparam add_2468_16.INIT1 = 16'h5555;
    defparam add_2468_16.INJECT1_0 = "NO";
    defparam add_2468_16.INJECT1_1 = "NO";
    FD1S3AY signals_debounced_syn_i1 (.D(pushed_1__N_267), .CK(clk), .Q(next_state_3__N_488[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam signals_debounced_syn_i1.GSR = "ENABLED";
    FD1S3AX externstop_falling_379 (.D(externstop_falling_N_709), .CK(clk), 
            .Q(externstop_falling));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam externstop_falling_379.GSR = "ENABLED";
    FD1S3AX externstop_last_380 (.D(signals_debounced_syn[2]), .CK(clk), 
            .Q(externstop_last));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam externstop_last_380.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i31 (.D(n493), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i31.GSR = "ENABLED";
    CCU2D add_194_11 (.A0(\debounce_counters[4] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4912), .COUT(n4913), .S0(n515), 
          .S1(n514));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_11.INIT0 = 16'h5aaa;
    defparam add_194_11.INIT1 = 16'h5aaa;
    defparam add_194_11.INJECT1_0 = "NO";
    defparam add_194_11.INJECT1_1 = "NO";
    CCU2D add_2468_14 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4954), .COUT(n4955));
    defparam add_2468_14.INIT0 = 16'h5555;
    defparam add_2468_14.INIT1 = 16'h5555;
    defparam add_2468_14.INJECT1_0 = "NO";
    defparam add_2468_14.INJECT1_1 = "NO";
    CCU2D add_2468_12 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4953), .COUT(n4954));
    defparam add_2468_12.INIT0 = 16'h5555;
    defparam add_2468_12.INIT1 = 16'h5555;
    defparam add_2468_12.INJECT1_0 = "NO";
    defparam add_2468_12.INJECT1_1 = "NO";
    CCU2D add_176_25 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4887), .COUT(n4888), .S0(n289), 
          .S1(n288));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_25.INIT0 = 16'h5aaa;
    defparam add_176_25.INIT1 = 16'h5aaa;
    defparam add_176_25.INJECT1_0 = "NO";
    defparam add_176_25.INJECT1_1 = "NO";
    CCU2D add_2466_10 (.A0(\debounce_counters[4] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4851), .COUT(n4852));
    defparam add_2466_10.INIT0 = 16'h5555;
    defparam add_2466_10.INIT1 = 16'h5555;
    defparam add_2466_10.INJECT1_0 = "NO";
    defparam add_2466_10.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i2 (.D(n1703), .SP(clk_enable_141), .CD(n3531), 
            .CK(clk), .Q(counter[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i2.GSR = "ENABLED";
    CCU2D add_167_15 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4866), .COUT(n4867), .S0(n193), 
          .S1(n192));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_15.INIT0 = 16'h5aaa;
    defparam add_167_15.INIT1 = 16'h5aaa;
    defparam add_167_15.INJECT1_0 = "NO";
    defparam add_167_15.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i30 (.D(n494), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i30.GSR = "ENABLED";
    CCU2D add_194_9 (.A0(\debounce_counters[4] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4911), .COUT(n4912), .S0(n517), 
          .S1(n516));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_9.INIT0 = 16'h5aaa;
    defparam add_194_9.INIT1 = 16'h5aaa;
    defparam add_194_9.INJECT1_0 = "NO";
    defparam add_194_9.INJECT1_1 = "NO";
    LUT4 i1467_4_lut_4_lut (.A(next_state[2]), .B(externstop_falling), .C(FP_UsrLED_4__N_3), 
         .D(next_state[3]), .Z(n3761)) /* synthesis lut_function=(!(A ((D)+!B)+!A (C (D)))) */ ;
    defparam i1467_4_lut_4_lut.init = 16'h05dd;
    FD1P3IX debounce_counters_4___i29 (.D(n495), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i28 (.D(n496), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i27 (.D(n497), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i27.GSR = "ENABLED";
    LUT4 mux_424_Mux_8_i15_4_lut_4_lut (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[2]), .D(next_state[3]), .Z(FP_SysLEDb_N_685)) /* synthesis lut_function=(!(A (B (D)+!B (C+!(D)))+!A (B (C (D))+!B (C+!(D))))) */ ;
    defparam mux_424_Mux_8_i15_4_lut_4_lut.init = 16'h07cc;
    CCU2D add_176_23 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4886), .COUT(n4887), .S0(n291), 
          .S1(n290));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_23.INIT0 = 16'h5aaa;
    defparam add_176_23.INIT1 = 16'h5aaa;
    defparam add_176_23.INJECT1_0 = "NO";
    defparam add_176_23.INJECT1_1 = "NO";
    CCU2D add_167_13 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4865), .COUT(n4866), .S0(n195), 
          .S1(n194));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_13.INIT0 = 16'h5aaa;
    defparam add_167_13.INIT1 = 16'h5aaa;
    defparam add_167_13.INJECT1_0 = "NO";
    defparam add_167_13.INJECT1_1 = "NO";
    LUT4 mux_613_i23_4_lut (.A(n1683), .B(n5606), .C(n2565), .D(n3185), 
         .Z(n2493)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam mux_613_i23_4_lut.init = 16'h303a;
    CCU2D add_2466_8 (.A0(\debounce_counters[4] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4850), .COUT(n4851));
    defparam add_2466_8.INIT0 = 16'h5555;
    defparam add_2466_8.INIT1 = 16'h5aaa;
    defparam add_2466_8.INJECT1_0 = "NO";
    defparam add_2466_8.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i26 (.D(n498), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i26.GSR = "ENABLED";
    CCU2D add_176_21 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4885), .COUT(n4886), .S0(n293), 
          .S1(n292));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_21.INIT0 = 16'h5aaa;
    defparam add_176_21.INIT1 = 16'h5aaa;
    defparam add_176_21.INJECT1_0 = "NO";
    defparam add_176_21.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i1 (.D(n1704), .SP(clk_enable_141), .CD(n3531), 
            .CK(clk), .Q(counter[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i25 (.D(n499), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i25.GSR = "ENABLED";
    LUT4 next_state_0__bdd_2_lut_2971 (.A(next_state[1]), .B(externstop_falling), 
         .Z(n5540)) /* synthesis lut_function=((B)+!A) */ ;
    defparam next_state_0__bdd_2_lut_2971.init = 16'hdddd;
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk)) /* synthesis NOM_FREQ="2.08", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "2.08";
    FD1P3IX debounce_counters_4___i24 (.D(n500), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i24.GSR = "ENABLED";
    LUT4 i58_4_lut_adj_1 (.A(n73), .B(n116), .C(n102), .D(n74_adj_5), 
         .Z(n122)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i58_4_lut_adj_1.init = 16'h8000;
    FD1P3IX debounce_counters_4___i23 (.D(n501), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i23.GSR = "ENABLED";
    LUT4 i54_4_lut (.A(FlexMIOs62_out), .B(n108), .C(n86), .D(S3CsI2C_SCL_c), 
         .Z(n118)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i54_4_lut.init = 16'h8000;
    LUT4 i50_4_lut (.A(DIG5S3C29_out), .B(n100), .C(n70_adj_6), .D(FPIO_FlexMIO30_out), 
         .Z(n114)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i50_4_lut.init = 16'h8000;
    FD1P3IX debounce_counters_4___i22 (.D(n502), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i22.GSR = "ENABLED";
    FD1P3AX FP_SysLEDr_384 (.D(FP_SysLEDr_N_684), .SP(clk_enable_20), .CK(clk), 
            .Q(FP_SysLEDr_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam FP_SysLEDr_384.GSR = "ENABLED";
    FD1P3AX FP_SysLEDb_385 (.D(FP_SysLEDb_N_685), .SP(clk_enable_20), .CK(clk), 
            .Q(FP_SysLEDb_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam FP_SysLEDb_385.GSR = "ENABLED";
    FD1P3AX FP_SysLEDg_386 (.D(FP_SysLEDg_N_683), .SP(clk_enable_20), .CK(clk), 
            .Q(FP_SysLEDg_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam FP_SysLEDg_386.GSR = "ENABLED";
    FD1P3AX Carrier_PwrOn_388 (.D(Carrier_PwrOn_N_702), .SP(clk_enable_22), 
            .CK(clk), .Q(Carrier_PwrOn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam Carrier_PwrOn_388.GSR = "ENABLED";
    FD1P3AX Carrier_PG_3V3_389 (.D(Carrier_PwrOn_N_702), .SP(clk_enable_22), 
            .CK(clk), .Q(Carrier_PG_3V3_c)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam Carrier_PG_3V3_389.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i21 (.D(n503), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i20 (.D(n504), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i20.GSR = "ENABLED";
    CCU2D add_2468_10 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4952), .COUT(n4953));
    defparam add_2468_10.INIT0 = 16'h5555;
    defparam add_2468_10.INIT1 = 16'h5555;
    defparam add_2468_10.INJECT1_0 = "NO";
    defparam add_2468_10.INJECT1_1 = "NO";
    LUT4 i2751_3_lut_4_lut (.A(next_state[0]), .B(next_state[1]), .C(next_state[2]), 
         .D(next_state[3]), .Z(FP_SysLEDr_N_684)) /* synthesis lut_function=(!(A (C)+!A (B (C+(D))+!B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i2751_3_lut_4_lut.init = 16'h0b0f;
    FD1S3AY debounce_inputs_asyn1_i1 (.D(SysSW_Pwr_NC_c), .CK(clk), .Q(debounce_inputs_asyn1[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_inputs_asyn1_i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i19 (.D(n505), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i18 (.D(n506), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i18.GSR = "ENABLED";
    LUT4 i34_4_lut (.A(SD0_CD_c), .B(SPI_S3C_nCS_USR_c), .C(SDA_c), .D(DIG5S3C03_out), 
         .Z(n98)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i34_4_lut.init = 16'h8000;
    LUT4 i1648_2_lut_3_lut (.A(next_state[0]), .B(next_state[1]), .C(next_state[3]), 
         .Z(FP_SysLEDs_N_696)) /* synthesis lut_function=(!(A (C)+!A (B+(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i1648_2_lut_3_lut.init = 16'h0b0b;
    CCU2D add_2466_6 (.A0(\debounce_counters[4] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4849), .COUT(n4850));
    defparam add_2466_6.INIT0 = 16'h5555;
    defparam add_2466_6.INIT1 = 16'h5aaa;
    defparam add_2466_6.INJECT1_0 = "NO";
    defparam add_2466_6.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i17 (.D(n507), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i16 (.D(n508), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i16.GSR = "ENABLED";
    CCU2D add_2466_4 (.A0(\debounce_counters[4] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4848), .COUT(n4849));
    defparam add_2466_4.INIT0 = 16'h5555;
    defparam add_2466_4.INIT1 = 16'h5555;
    defparam add_2466_4.INJECT1_0 = "NO";
    defparam add_2466_4.INJECT1_1 = "NO";
    LUT4 i42_4_lut (.A(FlexMIOs30_out), .B(FlexMIOs37_out), .C(FlexMIOs32_out), 
         .D(FlexMIOs45_c), .Z(n106)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i42_4_lut.init = 16'h8000;
    CCU2D add_2468_8 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4951), .COUT(n4952));
    defparam add_2468_8.INIT0 = 16'h5555;
    defparam add_2468_8.INIT1 = 16'h5aaa;
    defparam add_2468_8.INJECT1_0 = "NO";
    defparam add_2468_8.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i15 (.D(n509), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i15.GSR = "ENABLED";
    LUT4 i25_2_lut (.A(DIG5S3C05_out), .B(DIG5S3C24_out), .Z(n89)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i25_2_lut.init = 16'h8888;
    CCU2D add_2466_2 (.A0(\debounce_counters[4] [7]), .B0(\debounce_counters[4] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[4] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n4848));
    defparam add_2466_2.INIT0 = 16'h1000;
    defparam add_2466_2.INIT1 = 16'h5aaa;
    defparam add_2466_2.INJECT1_0 = "NO";
    defparam add_2466_2.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_89 (.A(next_state[3]), .B(next_state[2]), .Z(n5606)) /* synthesis lut_function=(A (B)) */ ;
    defparam i1_2_lut_rep_89.init = 16'h8888;
    IB FP_UsrSW2_pad (.I(FP_UsrSW2), .O(FP_UsrSW2_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(21[3:12])
    IB FP_UsrSW1_pad (.I(FP_UsrSW1), .O(FP_UsrSW1_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(20[3:12])
    IB FlexIO03_pad (.I(FlexIO03), .O(FlexIO03_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(17[3:11])
    IB FlexIO04_pad (.I(FlexIO04), .O(FlexIO04_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(16[3:11])
    OB Carrier_PwrOn_pad (.I(Carrier_PwrOn_c), .O(Carrier_PwrOn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(95[9:22])
    OB DIGS3C_SlotD_SlotOE_pad_1 (.I(DIGS3C_SlotD_SlotOE_c_1), .O(DIGS3C_SlotD_SlotOE[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(92[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_2 (.I(DIGS3C_SlotD_SlotOE_c_2), .O(DIGS3C_SlotD_SlotOE[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(92[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_3 (.I(DIGS3C_SlotD_SlotOE_c_3), .O(DIGS3C_SlotD_SlotOE[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(92[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_4 (.I(DIGS3C_SlotD_SlotOE_c_4), .O(DIGS3C_SlotD_SlotOE[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(92[3:22])
    FD1P3IX debounce_counters_4___i14 (.D(n510), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i13 (.D(n511), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i13.GSR = "ENABLED";
    OB DIGS3C_SlotD_SlotOE_pad_5 (.I(DIGS3C_SlotD_SlotOE_c_5), .O(DIGS3C_SlotD_SlotOE[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(92[3:22])
    CCU2D add_2468_6 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4950), .COUT(n4951));
    defparam add_2468_6.INIT0 = 16'h5555;
    defparam add_2468_6.INIT1 = 16'h5aaa;
    defparam add_2468_6.INJECT1_0 = "NO";
    defparam add_2468_6.INJECT1_1 = "NO";
    OB ANL_S3C_CarrierReady_pad (.I(GND_net), .O(ANL_S3C_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(90[3:23])
    OB FlexMio61ExternalStop_pad (.I(FlexMio61ExternalStop_c_c), .O(FlexMio61ExternalStop));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(61[3:24])
    OB FlexMIOs53_GPIO_PowerDown_pad (.I(FlexMIOs53_GPIO_PowerDown_c), .O(FlexMIOs53_GPIO_PowerDown));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(59[3:28])
    OB SD_SEL_pad (.I(GND_net), .O(SD_SEL));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(55[3:9])
    OB DIGS3C_Shared_ReqSafeState_pad (.I(DIGS3C_Shared_ReqSafeState_c), .O(DIGS3C_Shared_ReqSafeState));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(47[3:29])
    OB DIGS3C_Shared_CarrierReady_pad (.I(GND_net), .O(DIGS3C_Shared_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(46[3:29])
    OB FP_UsrLED_pad_1 (.I(GND_net), .O(FP_UsrLED[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(45[3:12])
    OB FP_UsrLED_pad_2 (.I(GND_net), .O(FP_UsrLED[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(45[3:12])
    OB FP_UsrLED_pad_3 (.I(GND_net), .O(FP_UsrLED[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(45[3:12])
    OB FP_UsrLED_pad_4 (.I(FP_UsrLED_c_4), .O(FP_UsrLED[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(45[3:12])
    OB FP_SysLEDs_pad (.I(FP_SysLEDs_c), .O(FP_SysLEDs));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(40[3:13])
    OBZ n3107_pad (.I(GND_net), .T(n3108), .O(Carrier_PG_1V8));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(247[1] 428[13])
    OB FPIO_FlexMIO52_pad (.I(FPIO_FlexMIO52_c_c), .O(FPIO_FlexMIO52));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(35[3:17])
    OB Carrier_PG_3V3_pad (.I(Carrier_PG_3V3_c), .O(Carrier_PG_3V3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(29[3:17])
    OB FPIO_isoCtrlRSTn_pad (.I(FPIO_isoCtrlRSTn_c), .O(FPIO_isoCtrlRSTn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(27[3:19])
    OB FlexIO01_pad (.I(GND_net), .O(FlexIO01));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(19[3:11])
    OB FlexIO02_pad (.I(GND_net), .O(FlexIO02));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(18[3:11])
    OB FlexIO05_pad (.I(GND_net), .O(FlexIO05));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(15[3:11])
    OB FP_SysLEDb_pad (.I(FP_SysLEDb_c), .O(FP_SysLEDb));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(14[3:13])
    OB FP_SysLEDr_pad (.I(FP_SysLEDr_c), .O(FP_SysLEDr));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(13[3:13])
    OB FP_SysLEDg_pad (.I(FP_SysLEDg_c), .O(FP_SysLEDg));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(12[3:13])
    FD1P3IX debounce_counters_4___i12 (.D(n512), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i12.GSR = "ENABLED";
    BB DIG5S3C27_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C27), .O(DIG5S3C27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_4___i11 (.D(n513), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i11.GSR = "ENABLED";
    BB DIG5S3C28_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C28), .O(DIG5S3C28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_4___i10 (.D(n514), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i10.GSR = "ENABLED";
    BB DIG5S3C29_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C29), .O(DIG5S3C29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_4___i9 (.D(n515), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i9.GSR = "ENABLED";
    BB DIG5S3C01_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C01), .O(DIG5S3C01_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_4___i8 (.D(n516), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i8.GSR = "ENABLED";
    BB DIG5S3C02_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C02), .O(DIG5S3C02_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_4___i7 (.D(n517), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i7.GSR = "ENABLED";
    BB DIG5S3C00_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C00), .O(DIG5S3C00_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_4___i6 (.D(n518), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i6.GSR = "ENABLED";
    BB DIG5S3C05_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C05), .O(DIG5S3C05_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_4___i5 (.D(n519), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i5.GSR = "ENABLED";
    BB DIG5S3C04_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C04), .O(DIG5S3C04_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_4___i4 (.D(n520), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i4.GSR = "ENABLED";
    BB DIG5S3C03_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C03), .O(DIG5S3C03_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    BB FPIO_FlexMIO28_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO28), 
       .O(FPIO_FlexMIO28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_4___i3 (.D(n521), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i3.GSR = "ENABLED";
    BB FlexMIOs32_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs32), .O(FlexMIOs32_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3AX i365_395 (.D(Carrier_PG_1V8_N_781), .SP(Carrier_PG_1V8_N_774), 
            .CK(clk), .Q(Carrier_PG_1V8_N_695));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam i365_395.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i2 (.D(n522), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i2.GSR = "ENABLED";
    BB FlexMIOs33_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs33), .O(FlexMIOs33_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_4___i1 (.D(n523), .SP(clk_enable_43), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_4___i1.GSR = "ENABLED";
    BB FlexMIOs34_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs34), .O(FlexMIOs34_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i31 (.D(n387), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i31.GSR = "ENABLED";
    BB FlexMIOs35_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs35), .O(FlexMIOs35_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i30 (.D(n388), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i30.GSR = "ENABLED";
    BB FlexMIOs36_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs36), .O(FlexMIOs36_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i29 (.D(n389), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i29.GSR = "ENABLED";
    BB FlexMIOs37_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs37), .O(FlexMIOs37_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i28 (.D(n390), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i28.GSR = "ENABLED";
    BB FlexMIOs26_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs26), .O(FlexMIOs26_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i27 (.D(n391), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i27.GSR = "ENABLED";
    BB FlexMIOs27_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs27), .O(FlexMIOs27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i26 (.D(n392), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i26.GSR = "ENABLED";
    BB FlexMIOs28_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs28), .O(FlexMIOs28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i25 (.D(n393), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i25.GSR = "ENABLED";
    BB FlexMIOs29_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs29), .O(FlexMIOs29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i24 (.D(n394), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i24.GSR = "ENABLED";
    BB FlexMIOs30_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs30), .O(FlexMIOs30_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i23 (.D(n395), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i23.GSR = "ENABLED";
    BB FlexMIOs31_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs31), .O(FlexMIOs31_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i22 (.D(n396), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i22.GSR = "ENABLED";
    BB FlexMIOs63_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs63), .O(FlexMIOs63_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i21 (.D(n397), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i21.GSR = "ENABLED";
    BB FlexMIOs62_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs62), .O(FlexMIOs62_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i20 (.D(n398), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i20.GSR = "ENABLED";
    BB FlexMIOs54_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs54), .O(FlexMIOs54_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i19 (.D(n399), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i19.GSR = "ENABLED";
    BB DIG5S3C24_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C24), .O(DIG5S3C24_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i18 (.D(n400), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i18.GSR = "ENABLED";
    BB DIG5S3C25_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C25), .O(DIG5S3C25_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i17 (.D(n401), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i17.GSR = "ENABLED";
    BB DIG5S3C26_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C26), .O(DIG5S3C26_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i16 (.D(n402), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i16.GSR = "ENABLED";
    BB FPIO_FlexMIO29_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO29), 
       .O(FPIO_FlexMIO29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i15 (.D(n403), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i15.GSR = "ENABLED";
    BB FPIO_FlexMIO30_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO30), 
       .O(FPIO_FlexMIO30_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i14 (.D(n404), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i14.GSR = "ENABLED";
    BB FPIO_FlexMIO27_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO27), 
       .O(FPIO_FlexMIO27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(193[1:17])
    FD1P3IX debounce_counters_3___i13 (.D(n405), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i13.GSR = "ENABLED";
    CCU2D add_2468_4 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4949), .COUT(n4950));
    defparam add_2468_4.INIT0 = 16'h5555;
    defparam add_2468_4.INIT1 = 16'h5555;
    defparam add_2468_4.INJECT1_0 = "NO";
    defparam add_2468_4.INJECT1_1 = "NO";
    PFUMX i2939 (.BLUT(n5573), .ALUT(n5572), .C0(next_state[2]), .Z(n3646));
    FD1P3IX debounce_counters_3___i12 (.D(n406), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i11 (.D(n407), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i10 (.D(n408), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i9 (.D(n409), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i8 (.D(n410), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i7 (.D(n411), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i7.GSR = "ENABLED";
    LUT4 i56_4_lut (.A(FlexMIOs36_out), .B(n112), .C(n94), .D(TDnSHDN_c), 
         .Z(n120)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i56_4_lut.init = 16'h8000;
    LUT4 i46_4_lut (.A(FlexLIO_c_1), .B(FlexLIO_c_4), .C(FlexLIO_c_2), 
         .D(FlexMIOs28_out), .Z(n110)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i46_4_lut.init = 16'h8000;
    LUT4 i26_2_lut (.A(DIG5S3C26_out), .B(FPIO_FlexMIO27_out), .Z(n90)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i26_2_lut.init = 16'h8888;
    CCU2D add_194_7 (.A0(\debounce_counters[4] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4910), .COUT(n4911), .S0(n519), 
          .S1(n518));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_7.INIT0 = 16'h5aaa;
    defparam add_194_7.INIT1 = 16'h5aaa;
    defparam add_194_7.INJECT1_0 = "NO";
    defparam add_194_7.INJECT1_1 = "NO";
    CCU2D add_2468_2 (.A0(\debounce_counters[2] [7]), .B0(\debounce_counters[2] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[2] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n4949));
    defparam add_2468_2.INIT0 = 16'h1000;
    defparam add_2468_2.INIT1 = 16'h5aaa;
    defparam add_2468_2.INJECT1_0 = "NO";
    defparam add_2468_2.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_2___i0 (.D(n312), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i0.GSR = "ENABLED";
    CCU2D add_423_25 (.A0(counter[23]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[24]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4947), .S0(n1682), .S1(n1681));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(408[17:24])
    defparam add_423_25.INIT0 = 16'h5555;
    defparam add_423_25.INIT1 = 16'h5555;
    defparam add_423_25.INJECT1_0 = "NO";
    defparam add_423_25.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i6 (.D(n412), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i5 (.D(n413), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i4 (.D(n414), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i3 (.D(n415), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i2 (.D(n416), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i1 (.D(n417), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i1 (.D(n205), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i1.GSR = "ENABLED";
    LUT4 mux_613_i19_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n2565), .D(n2463), .Z(n2497)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_613_i19_3_lut_4_lut.init = 16'h7f70;
    IB SCL_pad (.I(SCL), .O(SCL_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(23[3:6])
    IB SDA_pad (.I(SDA), .O(SDA_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(24[3:6])
    IB FP_UsrSW3_pad (.I(FP_UsrSW3), .O(FP_UsrSW3_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(25[3:12])
    IB SysSW_Pwr_NC_pad (.I(SysSW_Pwr_NC), .O(SysSW_Pwr_NC_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(26[3:15])
    IB FPIO_iosCtrlINTn_pad (.I(FPIO_iosCtrlINTn), .O(FPIO_iosCtrlINTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(28[3:19])
    IB FlexMio61ExternalStop_c_pad (.I(FPIO_ExternalStop), .O(FlexMio61ExternalStop_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(30[3:20])
    IB S3CsI2C_SDA_pad (.I(S3CsI2C_SDA), .O(S3CsI2C_SDA_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(38[3:14])
    IB S3CsI2C_SCL_pad (.I(S3CsI2C_SCL), .O(S3CsI2C_SCL_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(39[3:14])
    IB SD1_CD_pad (.I(SD1_CD), .O(SD1_CD_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(41[3:9])
    IB SD0_CD_pad (.I(SD0_CD), .O(SD0_CD_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(42[3:9])
    IB SPI_S3C_nCS_USR_pad (.I(SPI_S3C_nCS_USR), .O(SPI_S3C_nCS_USR_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(43[3:18])
    IB DIGS3C_SlotD_ReqOE_pad_5 (.I(DIGS3C_SlotD_ReqOE[5]), .O(DIGS3C_SlotD_ReqOE_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(48[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_4 (.I(DIGS3C_SlotD_ReqOE[4]), .O(DIGS3C_SlotD_ReqOE_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(48[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_3 (.I(DIGS3C_SlotD_ReqOE[3]), .O(DIGS3C_SlotD_ReqOE_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(48[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_2 (.I(DIGS3C_SlotD_ReqOE[2]), .O(DIGS3C_SlotD_ReqOE_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(48[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_1 (.I(DIGS3C_SlotD_ReqOE[1]), .O(DIGS3C_SlotD_ReqOE_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(48[3:21])
    IB DIGS3C_SlotD_SlotOK_pad_5 (.I(DIGS3C_SlotD_SlotOK[5]), .O(DIGS3C_SlotD_SlotOK_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(49[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_4 (.I(DIGS3C_SlotD_SlotOK[4]), .O(DIGS3C_SlotD_SlotOK_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(49[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_3 (.I(DIGS3C_SlotD_SlotOK[3]), .O(DIGS3C_SlotD_SlotOK_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(49[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_2 (.I(DIGS3C_SlotD_SlotOK[2]), .O(DIGS3C_SlotD_SlotOK_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(49[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_1 (.I(DIGS3C_SlotD_SlotOK[1]), .O(DIGS3C_SlotD_SlotOK_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(49[3:22])
    IB FlexLIO_pad_5 (.I(FlexLIO[5]), .O(FlexLIO_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(50[3:10])
    IB FlexLIO_pad_4 (.I(FlexLIO[4]), .O(FlexLIO_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(50[3:10])
    IB FlexLIO_pad_3 (.I(FlexLIO[3]), .O(FlexLIO_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(50[3:10])
    IB FlexLIO_pad_2 (.I(FlexLIO[2]), .O(FlexLIO_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(50[3:10])
    IB FlexLIO_pad_1 (.I(FlexLIO[1]), .O(FlexLIO_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(50[3:10])
    IB FlexLIO_pad_0 (.I(FlexLIO[0]), .O(FlexLIO_c_0));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(50[3:10])
    IB FPIO_FlexMIO52_c_pad (.I(FlexMIOs52_PCIe), .O(FPIO_FlexMIO52_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(58[3:18])
    IB FlexMIOs45_pad (.I(FlexMIOs45), .O(FlexMIOs45_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(70[3:13])
    IB ANL_S3C_SLOTOK_pad_3 (.I(ANL_S3C_SLOTOK[3]), .O(ANL_S3C_SLOTOK_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(89[3:17])
    IB ANL_S3C_SLOTOK_pad_2 (.I(ANL_S3C_SLOTOK[2]), .O(ANL_S3C_SLOTOK_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(89[3:17])
    IB ANL_S3C_SLOTOK_pad_1 (.I(ANL_S3C_SLOTOK[1]), .O(ANL_S3C_SLOTOK_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(89[3:17])
    IB ANL_S3C_P54_Legacy_pad (.I(ANL_S3C_P54_Legacy), .O(ANL_S3C_P54_Legacy_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(91[3:21])
    IB PG_VIN_pad (.I(PG_VIN), .O(PG_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(96[3:9])
    IB PPn_VIN_pad (.I(PPn_VIN), .O(PPn_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(97[3:10])
    IB PG_Module_pad (.I(PG_Module), .O(PG_Module_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(98[3:12])
    IB TDnSHDN_pad (.I(TDnSHDN), .O(TDnSHDN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(99[3:10])
    IB TDnFFnFS_pad (.I(TDnFFnFS), .O(TDnFFnFS_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(100[3:11])
    IB TDnALERT_pad (.I(TDnALERT), .O(TDnALERT_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(101[3:11])
    IB S3C_S1_pad (.I(S3C_S1), .O(S3C_S1_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(102[3:9])
    PFUMX i2841 (.BLUT(n5416), .ALUT(n5414), .C0(next_state[3]), .Z(clk_enable_112));
    LUT4 i2776_3_lut (.A(n5226), .B(n5256), .C(next_state[1]), .Z(n29_adj_4)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(115[12:22])
    defparam i2776_3_lut.init = 16'hcaca;
    CCU2D add_194_5 (.A0(\debounce_counters[4] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4909), .COUT(n4910), .S0(n521), 
          .S1(n520));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_5.INIT0 = 16'h5aaa;
    defparam add_194_5.INIT1 = 16'h5aaa;
    defparam add_194_5.INJECT1_0 = "NO";
    defparam add_194_5.INJECT1_1 = "NO";
    FD1P3AX next_state_i3 (.D(next_state_3__N_34[3]), .SP(clk_enable_77), 
            .CK(clk), .Q(next_state[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam next_state_i3.GSR = "ENABLED";
    CCU2D add_423_23 (.A0(counter[21]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[22]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4946), .COUT(n4947), .S0(n1684), .S1(n1683));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(408[17:24])
    defparam add_423_23.INIT0 = 16'h5555;
    defparam add_423_23.INIT1 = 16'h5555;
    defparam add_423_23.INJECT1_0 = "NO";
    defparam add_423_23.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_1___i2 (.D(n204), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i3 (.D(n203), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i4 (.D(n202), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i5 (.D(n201), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i6 (.D(n200), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i7 (.D(n199), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i8 (.D(n198), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i9 (.D(n197), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i10 (.D(n196), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i11 (.D(n195), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i12 (.D(n194), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i13 (.D(n193), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i14 (.D(n192), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i15 (.D(n191), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i16 (.D(n190), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i17 (.D(n189), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i18 (.D(n188), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i19 (.D(n187), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i20 (.D(n186), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i21 (.D(n185), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i22 (.D(n184), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i23 (.D(n183), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i24 (.D(n182), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i25 (.D(n181), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i26 (.D(n180), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i27 (.D(n179), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i28 (.D(n178), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i29 (.D(n177), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i30 (.D(n176), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i31 (.D(n175), .SP(clk_enable_107), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_1___i31.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn2_i2 (.D(debounce_inputs_asyn1[2]), .CK(clk), 
            .Q(debounce_inputs_asyn2[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_inputs_asyn2_i2.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn2_i3 (.D(debounce_inputs_asyn1[3]), .CK(clk), 
            .Q(debounce_inputs_asyn2[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_inputs_asyn2_i3.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn2_i4 (.D(debounce_inputs_asyn1[4]), .CK(clk), 
            .Q(debounce_inputs_asyn2[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_inputs_asyn2_i4.GSR = "ENABLED";
    FD1P3IX pushed_i2 (.D(n5787), .SP(clk_enable_108), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(pushed[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam pushed_i2.GSR = "ENABLED";
    FD1P3IX pushed_i3 (.D(n5787), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(pushed[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam pushed_i3.GSR = "ENABLED";
    FD1P3IX pushed_i4 (.D(n5787), .SP(clk_enable_110), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(pushed[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam pushed_i4.GSR = "ENABLED";
    FD1S3AY signals_debounced_syn_i2 (.D(pushed_2__N_265), .CK(clk), .Q(signals_debounced_syn[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam signals_debounced_syn_i2.GSR = "ENABLED";
    LUT4 i48_4_lut (.A(DIGS3C_SlotD_SlotOK_c_2), .B(FlexLIO_c_0), .C(DIG5S3C04_out), 
         .D(TDnFFnFS_c), .Z(n112)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i48_4_lut.init = 16'h8000;
    FD1S3AY signals_debounced_syn_i3 (.D(pushed_3__N_263), .CK(clk), .Q(signals_debounced_syn[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam signals_debounced_syn_i3.GSR = "ENABLED";
    FD1S3AY signals_debounced_syn_i4 (.D(pushed_4__N_261), .CK(clk), .Q(signals_debounced_syn[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam signals_debounced_syn_i4.GSR = "ENABLED";
    CCU2D add_176_19 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4884), .COUT(n4885), .S0(n295), 
          .S1(n294));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_19.INIT0 = 16'h5aaa;
    defparam add_176_19.INIT1 = 16'h5aaa;
    defparam add_176_19.INJECT1_0 = "NO";
    defparam add_176_19.INJECT1_1 = "NO";
    CCU2D add_194_3 (.A0(\debounce_counters[4] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4908), .COUT(n4909), .S0(n523), 
          .S1(n522));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_3.INIT0 = 16'h5aaa;
    defparam add_194_3.INIT1 = 16'h5aaa;
    defparam add_194_3.INJECT1_0 = "NO";
    defparam add_194_3.INJECT1_1 = "NO";
    CCU2D add_194_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[4] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n4908), .S1(n524));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_1.INIT0 = 16'hF000;
    defparam add_194_1.INIT1 = 16'h5555;
    defparam add_194_1.INJECT1_0 = "NO";
    defparam add_194_1.INJECT1_1 = "NO";
    CCU2D add_176_17 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4883), .COUT(n4884), .S0(n297), 
          .S1(n296));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_17.INIT0 = 16'h5aaa;
    defparam add_176_17.INIT1 = 16'h5aaa;
    defparam add_176_17.INJECT1_0 = "NO";
    defparam add_176_17.INJECT1_1 = "NO";
    LUT4 i30_2_lut (.A(PG_VIN_c), .B(ANL_S3C_SLOTOK_c_1), .Z(n94)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i30_2_lut.init = 16'h8888;
    CCU2D add_167_11 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4864), .COUT(n4865), .S0(n197), 
          .S1(n196));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_11.INIT0 = 16'h5aaa;
    defparam add_167_11.INIT1 = 16'h5aaa;
    defparam add_167_11.INJECT1_0 = "NO";
    defparam add_167_11.INJECT1_1 = "NO";
    LUT4 i9_2_lut (.A(FlexMIOs54_out), .B(FlexMIOs63_out), .Z(n73)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i9_2_lut.init = 16'h8888;
    LUT4 i52_4_lut (.A(DIG5S3C01_out), .B(n104), .C(n78), .D(DIG5S3C02_out), 
         .Z(n116)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i52_4_lut.init = 16'h8000;
    FD1P3AX next_state_i2 (.D(next_state_3__N_34[2]), .SP(clk_enable_111), 
            .CK(clk), .Q(next_state[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam next_state_i2.GSR = "ENABLED";
    CCU2D add_423_21 (.A0(counter[19]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[20]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4945), .COUT(n4946), .S0(n1686), .S1(n1685));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(408[17:24])
    defparam add_423_21.INIT0 = 16'h5555;
    defparam add_423_21.INIT1 = 16'h5555;
    defparam add_423_21.INJECT1_0 = "NO";
    defparam add_423_21.INJECT1_1 = "NO";
    CCU2D add_423_19 (.A0(counter[17]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[18]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4944), .COUT(n4945), .S0(n1688), .S1(n1687));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(408[17:24])
    defparam add_423_19.INIT0 = 16'h5555;
    defparam add_423_19.INIT1 = 16'h5555;
    defparam add_423_19.INJECT1_0 = "NO";
    defparam add_423_19.INJECT1_1 = "NO";
    CCU2D add_176_15 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4882), .COUT(n4883), .S0(n299), 
          .S1(n298));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_15.INIT0 = 16'h5aaa;
    defparam add_176_15.INIT1 = 16'h5aaa;
    defparam add_176_15.INJECT1_0 = "NO";
    defparam add_176_15.INJECT1_1 = "NO";
    LUT4 i38_4_lut (.A(SCL_c), .B(DIGS3C_SlotD_SlotOK_c_1), .C(SD1_CD_c), 
         .D(DIGS3C_SlotD_SlotOK_c_5), .Z(n102)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i38_4_lut.init = 16'h8000;
    CCU2D add_423_17 (.A0(counter[15]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[16]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4943), .COUT(n4944), .S0(n1690), .S1(n1689));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(408[17:24])
    defparam add_423_17.INIT0 = 16'h5555;
    defparam add_423_17.INIT1 = 16'h5555;
    defparam add_423_17.INJECT1_0 = "NO";
    defparam add_423_17.INJECT1_1 = "NO";
    CCU2D add_167_9 (.A0(\debounce_counters[1] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4863), .COUT(n4864), .S0(n199), 
          .S1(n198));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_9.INIT0 = 16'h5aaa;
    defparam add_167_9.INIT1 = 16'h5aaa;
    defparam add_167_9.INJECT1_0 = "NO";
    defparam add_167_9.INJECT1_1 = "NO";
    CCU2D add_176_13 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4881), .COUT(n4882), .S0(n301), 
          .S1(n300));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_13.INIT0 = 16'h5aaa;
    defparam add_176_13.INIT1 = 16'h5aaa;
    defparam add_176_13.INJECT1_0 = "NO";
    defparam add_176_13.INJECT1_1 = "NO";
    LUT4 i10_2_lut (.A(PG_Module_c), .B(S3CsI2C_SDA_c), .Z(n74_adj_5)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i10_2_lut.init = 16'h8888;
    CCU2D add_176_11 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4880), .COUT(n4881), .S0(n303), 
          .S1(n302));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_11.INIT0 = 16'h5aaa;
    defparam add_176_11.INIT1 = 16'h5aaa;
    defparam add_176_11.INJECT1_0 = "NO";
    defparam add_176_11.INJECT1_1 = "NO";
    CCU2D add_423_15 (.A0(counter[13]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[14]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4942), .COUT(n4943), .S0(n1692), .S1(n1691));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(408[17:24])
    defparam add_423_15.INIT0 = 16'h5555;
    defparam add_423_15.INIT1 = 16'h5555;
    defparam add_423_15.INJECT1_0 = "NO";
    defparam add_423_15.INJECT1_1 = "NO";
    LUT4 next_state_0__bdd_4_lut_2934 (.A(next_state[1]), .B(externstop_falling), 
         .C(next_state_3__N_488[2]), .D(signals_debounced_syn[3]), .Z(n5539)) /* synthesis lut_function=(!(A+!(B+(C (D))))) */ ;
    defparam next_state_0__bdd_4_lut_2934.init = 16'h5444;
    CCU2D add_185_33 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4907), .S0(n387));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_33.INIT0 = 16'h5aaa;
    defparam add_185_33.INIT1 = 16'h0000;
    defparam add_185_33.INJECT1_0 = "NO";
    defparam add_185_33.INJECT1_1 = "NO";
    LUT4 i40_4_lut (.A(DIG5S3C28_out), .B(FPIO_FlexMIO29_out), .C(FPIO_FlexMIO28_out), 
         .D(FPIO_iosCtrlINTn_c), .Z(n104)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i40_4_lut.init = 16'h8000;
    LUT4 i14_2_lut (.A(DIG5S3C25_out), .B(DIG5S3C27_out), .Z(n78)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i14_2_lut.init = 16'h8888;
    LUT4 i36_4_lut (.A(FlexMIOs27_out), .B(FlexMIOs33_out), .C(FlexMIOs31_out), 
         .D(FlexMIOs34_out), .Z(n100)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i36_4_lut.init = 16'h8000;
    LUT4 mux_613_i21_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n2565), .D(n2461), .Z(n2495)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_613_i21_3_lut_4_lut.init = 16'h7f70;
    LUT4 i6_2_lut (.A(FP_UsrSW2_c), .B(FlexIO03_c), .Z(n70_adj_6)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i6_2_lut.init = 16'h8888;
    FD1P3AX next_state_i0 (.D(next_state_3__N_34[0]), .SP(clk_enable_112), 
            .CK(clk), .Q(next_state[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam next_state_i0.GSR = "ENABLED";
    CCU2D add_423_13 (.A0(counter[11]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[12]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4941), .COUT(n4942), .S0(n1694), .S1(n1693));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(408[17:24])
    defparam add_423_13.INIT0 = 16'h5555;
    defparam add_423_13.INIT1 = 16'h5555;
    defparam add_423_13.INJECT1_0 = "NO";
    defparam add_423_13.INJECT1_1 = "NO";
    FD1P3AX next_state_i1 (.D(next_state_3__N_34[1]), .SP(clk_enable_113), 
            .CK(clk), .Q(next_state[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam next_state_i1.GSR = "ENABLED";
    LUT4 i44_4_lut (.A(ANL_S3C_SLOTOK_c_3), .B(DIGS3C_SlotD_SlotOK_c_4), 
         .C(DIGS3C_SlotD_SlotOK_c_3), .D(DIG5S3C00_out), .Z(n108)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i44_4_lut.init = 16'h8000;
    CCU2D add_185_31 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4906), .COUT(n4907), .S0(n389), 
          .S1(n388));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_31.INIT0 = 16'h5aaa;
    defparam add_185_31.INIT1 = 16'h5aaa;
    defparam add_185_31.INJECT1_0 = "NO";
    defparam add_185_31.INJECT1_1 = "NO";
    CCU2D add_423_11 (.A0(counter[9]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[10]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4940), .COUT(n4941), .S0(n1696), .S1(n1695));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(408[17:24])
    defparam add_423_11.INIT0 = 16'h5555;
    defparam add_423_11.INIT1 = 16'h5555;
    defparam add_423_11.INJECT1_0 = "NO";
    defparam add_423_11.INJECT1_1 = "NO";
    FD1S3AY debounce_inputs_asyn1_i2 (.D(FlexMio61ExternalStop_c_c), .CK(clk), 
            .Q(debounce_inputs_asyn1[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_inputs_asyn1_i2.GSR = "ENABLED";
    CCU2D add_176_9 (.A0(\debounce_counters[2] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4879), .COUT(n4880), .S0(n305), 
          .S1(n304));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_9.INIT0 = 16'h5aaa;
    defparam add_176_9.INIT1 = 16'h5aaa;
    defparam add_176_9.INJECT1_0 = "NO";
    defparam add_176_9.INJECT1_1 = "NO";
    CCU2D add_423_9 (.A0(counter[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[8]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4939), .COUT(n4940), .S0(n1698), .S1(n1697));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(408[17:24])
    defparam add_423_9.INIT0 = 16'h5555;
    defparam add_423_9.INIT1 = 16'h5555;
    defparam add_423_9.INJECT1_0 = "NO";
    defparam add_423_9.INJECT1_1 = "NO";
    CCU2D add_423_7 (.A0(counter[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4938), .COUT(n4939), .S0(n1700), .S1(n1699));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(408[17:24])
    defparam add_423_7.INIT0 = 16'h5555;
    defparam add_423_7.INIT1 = 16'h5555;
    defparam add_423_7.INJECT1_0 = "NO";
    defparam add_423_7.INJECT1_1 = "NO";
    LUT4 i22_2_lut (.A(ANL_S3C_P54_Legacy_c), .B(ANL_S3C_SLOTOK_c_2), .Z(n86)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i22_2_lut.init = 16'h8888;
    CCU2D add_423_5 (.A0(counter[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4937), .COUT(n4938), .S0(n1702), .S1(n1701));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(408[17:24])
    defparam add_423_5.INIT0 = 16'h5555;
    defparam add_423_5.INIT1 = 16'h5555;
    defparam add_423_5.INJECT1_0 = "NO";
    defparam add_423_5.INJECT1_1 = "NO";
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut (.A(DIGS3C_SlotD_ReqOE_c_1), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_1)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(207[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut.init = 16'h2222;
    FD1S3AY debounce_inputs_asyn1_i3 (.D(FP_UsrSW3_c), .CK(clk), .Q(debounce_inputs_asyn1[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_inputs_asyn1_i3.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn1_i4 (.D(FP_UsrSW1_c), .CK(clk), .Q(debounce_inputs_asyn1[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_inputs_asyn1_i4.GSR = "ENABLED";
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut (.A(DIGS3C_SlotD_ReqOE_c_2), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_2)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(207[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut.init = 16'h2222;
    CCU2D add_185_29 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4905), .COUT(n4906), .S0(n391), 
          .S1(n390));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_29.INIT0 = 16'h5aaa;
    defparam add_185_29.INIT1 = 16'h5aaa;
    defparam add_185_29.INJECT1_0 = "NO";
    defparam add_185_29.INJECT1_1 = "NO";
    CCU2D add_423_3 (.A0(counter[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4936), .COUT(n4937), .S0(n1704), .S1(n1703));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(408[17:24])
    defparam add_423_3.INIT0 = 16'h5555;
    defparam add_423_3.INIT1 = 16'h5555;
    defparam add_423_3.INJECT1_0 = "NO";
    defparam add_423_3.INJECT1_1 = "NO";
    CCU2D add_167_7 (.A0(\debounce_counters[1] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4862), .COUT(n4863), .S0(n201), 
          .S1(n200));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_7.INIT0 = 16'h5aaa;
    defparam add_167_7.INIT1 = 16'h5aaa;
    defparam add_167_7.INJECT1_0 = "NO";
    defparam add_167_7.INJECT1_1 = "NO";
    LUT4 mux_604_i20_4_lut (.A(next_state[1]), .B(n1686), .C(n2563), .D(n2559), 
         .Z(n2462)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam mux_604_i20_4_lut.init = 16'hf5c5;
    CCU2D add_176_7 (.A0(\debounce_counters[2] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4878), .COUT(n4879), .S0(n307), 
          .S1(n306));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_7.INIT0 = 16'h5aaa;
    defparam add_176_7.INIT1 = 16'h5aaa;
    defparam add_176_7.INJECT1_0 = "NO";
    defparam add_176_7.INJECT1_1 = "NO";
    CCU2D add_185_27 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4904), .COUT(n4905), .S0(n393), 
          .S1(n392));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_27.INIT0 = 16'h5aaa;
    defparam add_185_27.INIT1 = 16'h5aaa;
    defparam add_185_27.INJECT1_0 = "NO";
    defparam add_185_27.INJECT1_1 = "NO";
    CCU2D add_167_5 (.A0(\debounce_counters[1] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4861), .COUT(n4862), .S0(n203), 
          .S1(n202));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_5.INIT0 = 16'h5aaa;
    defparam add_167_5.INIT1 = 16'h5aaa;
    defparam add_167_5.INJECT1_0 = "NO";
    defparam add_167_5.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i0 (.D(n1705), .SP(clk_enable_141), .CD(n3531), 
            .CK(clk), .Q(counter[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i0.GSR = "ENABLED";
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut (.A(DIGS3C_SlotD_ReqOE_c_3), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_3)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(207[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut.init = 16'h2222;
    LUT4 i49_4_lut (.A(FP_UsrLED_4__N_3), .B(next_state_3__N_488[2]), .C(next_state[3]), 
         .D(next_state[0]), .Z(n5256)) /* synthesis lut_function=(!(A (B (C (D))+!B !((D)+!C))+!A (B ((D)+!C)+!B !(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(115[12:22])
    defparam i49_4_lut.init = 16'h3aca;
    CCU2D add_423_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n4936), .S1(n1705));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(408[17:24])
    defparam add_423_1.INIT0 = 16'hF000;
    defparam add_423_1.INIT1 = 16'h5555;
    defparam add_423_1.INJECT1_0 = "NO";
    defparam add_423_1.INJECT1_1 = "NO";
    FD1P3AX extern_connected_394 (.D(n5787), .SP(clk_enable_115), .CK(clk), 
            .Q(FP_UsrLED_c_4)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam extern_connected_394.GSR = "ENABLED";
    LUT4 i1_2_lut_rep_88 (.A(next_state[0]), .B(next_state[1]), .Z(n5605)) /* synthesis lut_function=(A (B)) */ ;
    defparam i1_2_lut_rep_88.init = 16'h8888;
    CCU2D add_176_5 (.A0(\debounce_counters[2] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4877), .COUT(n4878), .S0(n309), 
          .S1(n308));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_5.INIT0 = 16'h5aaa;
    defparam add_176_5.INIT1 = 16'h5aaa;
    defparam add_176_5.INJECT1_0 = "NO";
    defparam add_176_5.INJECT1_1 = "NO";
    CCU2D add_2469_26 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4935), .S1(clk_enable_5));
    defparam add_2469_26.INIT0 = 16'hf555;
    defparam add_2469_26.INIT1 = 16'h0000;
    defparam add_2469_26.INJECT1_0 = "NO";
    defparam add_2469_26.INJECT1_1 = "NO";
    CCU2D add_185_25 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4903), .COUT(n4904), .S0(n395), 
          .S1(n394));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_25.INIT0 = 16'h5aaa;
    defparam add_185_25.INIT1 = 16'h5aaa;
    defparam add_185_25.INJECT1_0 = "NO";
    defparam add_185_25.INJECT1_1 = "NO";
    PFUMX i2915 (.BLUT(n5540), .ALUT(n5539), .C0(next_state[0]), .Z(n5541));
    FD1P3AX FP_SysLEDs_393 (.D(FP_SysLEDs_N_696), .SP(clk_enable_116), .CK(clk), 
            .Q(FP_SysLEDs_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam FP_SysLEDs_393.GSR = "ENABLED";
    CCU2D add_167_3 (.A0(\debounce_counters[1] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4860), .COUT(n4861), .S0(n205), 
          .S1(n204));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_3.INIT0 = 16'h5aaa;
    defparam add_167_3.INIT1 = 16'h5aaa;
    defparam add_167_3.INJECT1_0 = "NO";
    defparam add_167_3.INJECT1_1 = "NO";
    CCU2D add_2469_24 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4934), .COUT(n4935));
    defparam add_2469_24.INIT0 = 16'h5555;
    defparam add_2469_24.INIT1 = 16'h5555;
    defparam add_2469_24.INJECT1_0 = "NO";
    defparam add_2469_24.INJECT1_1 = "NO";
    FD1P3AX forceoutputdisable_381 (.D(forceoutputdisable_N_6), .SP(clk_enable_117), 
            .CK(clk), .Q(forceoutputdisable));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam forceoutputdisable_381.GSR = "ENABLED";
    FD1P3AX FPIO_isoCtrlRSTn_390 (.D(FPIO_isoCtrlRSTn_N_686), .SP(clk_enable_118), 
            .CK(clk), .Q(FPIO_isoCtrlRSTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam FPIO_isoCtrlRSTn_390.GSR = "ENABLED";
    CCU2D add_167_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[1] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n4860), .S1(n206));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_1.INIT0 = 16'hF000;
    defparam add_167_1.INIT1 = 16'h5555;
    defparam add_167_1.INJECT1_0 = "NO";
    defparam add_167_1.INJECT1_1 = "NO";
    CCU2D add_2469_22 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4933), .COUT(n4934));
    defparam add_2469_22.INIT0 = 16'h5555;
    defparam add_2469_22.INIT1 = 16'h5555;
    defparam add_2469_22.INJECT1_0 = "NO";
    defparam add_2469_22.INJECT1_1 = "NO";
    CCU2D add_176_3 (.A0(\debounce_counters[2] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4876), .COUT(n4877), .S0(n311), 
          .S1(n310));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_3.INIT0 = 16'h5aaa;
    defparam add_176_3.INIT1 = 16'h5aaa;
    defparam add_176_3.INJECT1_0 = "NO";
    defparam add_176_3.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i7 (.D(n1698), .SP(clk_enable_141), .CD(n3531), 
            .CK(clk), .Q(counter[7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i7.GSR = "ENABLED";
    FD1P3AX FlexMIOs53_GPIO_PowerDown_383 (.D(FlexMIOs53_GPIO_PowerDown_N_699), 
            .SP(clk_enable_120), .CK(clk), .Q(FlexMIOs53_GPIO_PowerDown_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam FlexMIOs53_GPIO_PowerDown_383.GSR = "ENABLED";
    FD1P3IX counter_i0_i21 (.D(n2394), .SP(clk_enable_141), .CD(n3947), 
            .CK(clk), .Q(counter[21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i21.GSR = "ENABLED";
    FD1P3IX DIGS3C_Shared_ReqSafeState_382 (.D(n7), .SP(clk_enable_122), 
            .CD(n3526), .CK(clk), .Q(DIGS3C_Shared_ReqSafeState_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam DIGS3C_Shared_ReqSafeState_382.GSR = "ENABLED";
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut (.A(DIGS3C_SlotD_ReqOE_c_4), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_4)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(207[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut.init = 16'h2222;
    CCU2D add_2469_20 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4932), .COUT(n4933));
    defparam add_2469_20.INIT0 = 16'h5555;
    defparam add_2469_20.INIT1 = 16'h5555;
    defparam add_2469_20.INJECT1_0 = "NO";
    defparam add_2469_20.INJECT1_1 = "NO";
    CCU2D add_185_23 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4902), .COUT(n4903), .S0(n397), 
          .S1(n396));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_23.INIT0 = 16'h5aaa;
    defparam add_185_23.INIT1 = 16'h5aaa;
    defparam add_185_23.INJECT1_0 = "NO";
    defparam add_185_23.INJECT1_1 = "NO";
    CCU2D add_2469_18 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4931), .COUT(n4932));
    defparam add_2469_18.INIT0 = 16'h5555;
    defparam add_2469_18.INIT1 = 16'h5555;
    defparam add_2469_18.INJECT1_0 = "NO";
    defparam add_2469_18.INJECT1_1 = "NO";
    CCU2D add_2469_16 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4930), .COUT(n4931));
    defparam add_2469_16.INIT0 = 16'h5555;
    defparam add_2469_16.INIT1 = 16'h5555;
    defparam add_2469_16.INJECT1_0 = "NO";
    defparam add_2469_16.INJECT1_1 = "NO";
    CCU2D add_2469_14 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4929), .COUT(n4930));
    defparam add_2469_14.INIT0 = 16'h5555;
    defparam add_2469_14.INIT1 = 16'h5555;
    defparam add_2469_14.INJECT1_0 = "NO";
    defparam add_2469_14.INJECT1_1 = "NO";
    CCU2D add_2469_12 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4928), .COUT(n4929));
    defparam add_2469_12.INIT0 = 16'h5555;
    defparam add_2469_12.INIT1 = 16'h5555;
    defparam add_2469_12.INJECT1_0 = "NO";
    defparam add_2469_12.INJECT1_1 = "NO";
    CCU2D add_2469_10 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4927), .COUT(n4928));
    defparam add_2469_10.INIT0 = 16'h5555;
    defparam add_2469_10.INIT1 = 16'h5555;
    defparam add_2469_10.INJECT1_0 = "NO";
    defparam add_2469_10.INJECT1_1 = "NO";
    CCU2D add_185_21 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4901), .COUT(n4902), .S0(n399), 
          .S1(n398));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_21.INIT0 = 16'h5aaa;
    defparam add_185_21.INIT1 = 16'h5aaa;
    defparam add_185_21.INJECT1_0 = "NO";
    defparam add_185_21.INJECT1_1 = "NO";
    CCU2D add_185_19 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4900), .COUT(n4901), .S0(n401), 
          .S1(n400));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_19.INIT0 = 16'h5aaa;
    defparam add_185_19.INIT1 = 16'h5aaa;
    defparam add_185_19.INJECT1_0 = "NO";
    defparam add_185_19.INJECT1_1 = "NO";
    CCU2D add_176_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[2] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n4876), .S1(n312));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_176_1.INIT0 = 16'hF000;
    defparam add_176_1.INIT1 = 16'h5555;
    defparam add_176_1.INJECT1_0 = "NO";
    defparam add_176_1.INJECT1_1 = "NO";
    CCU2D add_167_33 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4875), .S0(n175));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_33.INIT0 = 16'h5aaa;
    defparam add_167_33.INIT1 = 16'h0000;
    defparam add_167_33.INJECT1_0 = "NO";
    defparam add_167_33.INJECT1_1 = "NO";
    CCU2D add_2469_8 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4926), .COUT(n4927));
    defparam add_2469_8.INIT0 = 16'h5555;
    defparam add_2469_8.INIT1 = 16'h5aaa;
    defparam add_2469_8.INJECT1_0 = "NO";
    defparam add_2469_8.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i17 (.D(n2464), .SP(clk_enable_141), .CD(n3540), 
            .CK(clk), .Q(counter[17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i17.GSR = "ENABLED";
    FD1P3IX counter_i0_i16 (.D(n2465), .SP(clk_enable_141), .CD(n3540), 
            .CK(clk), .Q(counter[16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i16.GSR = "ENABLED";
    CCU2D add_185_17 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4899), .COUT(n4900), .S0(n403), 
          .S1(n402));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_17.INIT0 = 16'h5aaa;
    defparam add_185_17.INIT1 = 16'h5aaa;
    defparam add_185_17.INJECT1_0 = "NO";
    defparam add_185_17.INJECT1_1 = "NO";
    CCU2D add_167_31 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4874), .COUT(n4875), .S0(n177), 
          .S1(n176));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_31.INIT0 = 16'h5aaa;
    defparam add_167_31.INIT1 = 16'h5aaa;
    defparam add_167_31.INJECT1_0 = "NO";
    defparam add_167_31.INJECT1_1 = "NO";
    CCU2D add_2469_6 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4925), .COUT(n4926));
    defparam add_2469_6.INIT0 = 16'h5555;
    defparam add_2469_6.INIT1 = 16'h5aaa;
    defparam add_2469_6.INJECT1_0 = "NO";
    defparam add_2469_6.INJECT1_1 = "NO";
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut (.A(DIGS3C_SlotD_ReqOE_c_5), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_5)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(207[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut.init = 16'h2222;
    LUT4 FP_UsrLED_4__N_3_bdd_4_lut_2917 (.A(FP_UsrLED_4__N_3), .B(next_state[0]), 
         .C(next_state[1]), .D(next_state_3__N_488[2]), .Z(n5542)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+(D)))+!A (B (C+(D))+!B (C+!(D)))) */ ;
    defparam FP_UsrLED_4__N_3_bdd_4_lut_2917.init = 16'hdcd3;
    FD1P3IX counter_i0_i15 (.D(n2466), .SP(clk_enable_141), .CD(n3540), 
            .CK(clk), .Q(counter[15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i15.GSR = "ENABLED";
    CCU2D add_2466_26 (.A0(\debounce_counters[4] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4859), .S1(clk_enable_110));
    defparam add_2466_26.INIT0 = 16'hf555;
    defparam add_2466_26.INIT1 = 16'h0000;
    defparam add_2466_26.INJECT1_0 = "NO";
    defparam add_2466_26.INJECT1_1 = "NO";
    CCU2D add_167_29 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4873), .COUT(n4874), .S0(n179), 
          .S1(n178));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_29.INIT0 = 16'h5aaa;
    defparam add_167_29.INIT1 = 16'h5aaa;
    defparam add_167_29.INJECT1_0 = "NO";
    defparam add_167_29.INJECT1_1 = "NO";
    LUT4 i813_1_lut (.A(Carrier_PG_1V8_N_695), .Z(n3108)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(247[1] 428[13])
    defparam i813_1_lut.init = 16'h5555;
    FD1P3IX counter_i0_i14 (.D(n2401), .SP(clk_enable_141), .CD(n3947), 
            .CK(clk), .Q(counter[14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i14.GSR = "ENABLED";
    LUT4 n5542_bdd_3_lut (.A(n5542), .B(n5541), .C(next_state[2]), .Z(n5543)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam n5542_bdd_3_lut.init = 16'hcaca;
    LUT4 next_state_1__bdd_4_lut_2967 (.A(next_state[1]), .B(next_state[3]), 
         .C(next_state[0]), .D(next_state[2]), .Z(clk_enable_120)) /* synthesis lut_function=(A (B (D)+!B (C (D)))+!A (B (D)+!B !(C))) */ ;
    defparam next_state_1__bdd_4_lut_2967.init = 16'hed01;
    LUT4 i770_2_lut (.A(clk_enable_110), .B(debounce_inputs_asyn2[4]), .Z(clk_enable_43)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i770_2_lut.init = 16'hdddd;
    FD1P3IX counter_i0_i13 (.D(n2468), .SP(clk_enable_141), .CD(n3540), 
            .CK(clk), .Q(counter[13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i13.GSR = "ENABLED";
    CCU2D add_2466_24 (.A0(\debounce_counters[4] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4858), .COUT(n4859));
    defparam add_2466_24.INIT0 = 16'h5555;
    defparam add_2466_24.INIT1 = 16'h5555;
    defparam add_2466_24.INJECT1_0 = "NO";
    defparam add_2466_24.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i11 (.D(n2470), .SP(clk_enable_141), .CD(n3540), 
            .CK(clk), .Q(counter[11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i11.GSR = "ENABLED";
    LUT4 FP_UsrLED_4__N_3_bdd_3_lut_2906 (.A(next_state_3__N_484[3]), .B(next_state[1]), 
         .C(next_state[0]), .Z(n5511)) /* synthesis lut_function=(!((B (C)+!B !(C))+!A)) */ ;
    defparam FP_UsrLED_4__N_3_bdd_3_lut_2906.init = 16'h2828;
    LUT4 mux_424_Mux_12_i15_4_lut (.A(PPn_VIN_c), .B(next_state[3]), .C(next_state[2]), 
         .D(next_state[1]), .Z(forceoutputdisable_N_6)) /* synthesis lut_function=(!(A (B (C+!(D))+!B (C))+!A (B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam mux_424_Mux_12_i15_4_lut.init = 16'h1f17;
    LUT4 i28_3_lut (.A(next_state[2]), .B(next_state[3]), .C(n5611), .Z(Carrier_PG_1V8_N_774)) /* synthesis lut_function=(A (B)+!A !(B+!(C))) */ ;
    defparam i28_3_lut.init = 16'h9898;
    LUT4 mux_613_i10_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n2565), .D(n2472), .Z(n2506)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_613_i10_3_lut_4_lut.init = 16'h7f70;
    LUT4 i2832_4_lut_4_lut (.A(next_state[2]), .B(next_state[3]), .C(next_state[1]), 
         .D(next_state[0]), .Z(clk_enable_116)) /* synthesis lut_function=(A (B+(C+(D)))+!A (B (C (D)+!C !(D)))) */ ;
    defparam i2832_4_lut_4_lut.init = 16'heaac;
    LUT4 i2_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), .C(externstop_falling), 
         .D(next_state_3__N_488[2]), .Z(n5225)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;
    defparam i2_3_lut_4_lut.init = 16'h2000;
    FD1P3IX counter_i0_i10 (.D(n2471), .SP(clk_enable_141), .CD(n3540), 
            .CK(clk), .Q(counter[10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i10.GSR = "ENABLED";
    CCU2D add_167_27 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4872), .COUT(n4873), .S0(n181), 
          .S1(n180));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_27.INIT0 = 16'h5aaa;
    defparam add_167_27.INIT1 = 16'h5aaa;
    defparam add_167_27.INJECT1_0 = "NO";
    defparam add_167_27.INJECT1_1 = "NO";
    PFUMX i2903 (.BLUT(n5528), .ALUT(n5527), .C0(next_state[3]), .Z(n2559));
    LUT4 i769_2_lut (.A(clk_enable_109), .B(debounce_inputs_asyn2[3]), .Z(clk_enable_130)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i769_2_lut.init = 16'hdddd;
    LUT4 i1246_2_lut_4_lut_4_lut (.A(n3965), .B(n74), .C(n5596), .D(n2565), 
         .Z(n3540)) /* synthesis lut_function=(!(A (B+!(D))+!A (B+(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i1246_2_lut_4_lut_4_lut.init = 16'h2300;
    LUT4 FP_UsrLED_4__N_3_bdd_4_lut_2905 (.A(next_state_3__N_484[3]), .B(next_state[1]), 
         .C(next_state[0]), .D(next_state_3__N_488[2]), .Z(n5512)) /* synthesis lut_function=(A (B+(C+!(D)))+!A (B (C)+!B !(C+(D)))) */ ;
    defparam FP_UsrLED_4__N_3_bdd_4_lut_2905.init = 16'he8eb;
    FD1P3IX debounce_counters_3___i0 (.D(n418), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_3___i0.GSR = "ENABLED";
    CCU2D add_185_15 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4898), .COUT(n4899), .S0(n405), 
          .S1(n404));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_15.INIT0 = 16'h5aaa;
    defparam add_185_15.INIT1 = 16'h5aaa;
    defparam add_185_15.INJECT1_0 = "NO";
    defparam add_185_15.INJECT1_1 = "NO";
    LUT4 i768_2_lut (.A(clk_enable_108), .B(debounce_inputs_asyn2[2]), .Z(clk_enable_172)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i768_2_lut.init = 16'hdddd;
    LUT4 n1841_bdd_2_lut_2844 (.A(n5415), .B(FP_UsrLED_4__N_3), .Z(n5416)) /* synthesis lut_function=(A+!(B)) */ ;
    defparam n1841_bdd_2_lut_2844.init = 16'hbbbb;
    CCU2D add_185_13 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4897), .COUT(n4898), .S0(n407), 
          .S1(n406));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_13.INIT0 = 16'h5aaa;
    defparam add_185_13.INIT1 = 16'h5aaa;
    defparam add_185_13.INJECT1_0 = "NO";
    defparam add_185_13.INJECT1_1 = "NO";
    LUT4 mux_613_i20_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n2565), .D(n2462), .Z(n2496)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_613_i20_3_lut_4_lut.init = 16'h7f70;
    LUT4 i2829_2_lut_rep_85 (.A(next_state[0]), .B(next_state_3__N_488[2]), 
         .Z(n5602)) /* synthesis lut_function=(!(A+(B))) */ ;
    defparam i2829_2_lut_rep_85.init = 16'h1111;
    LUT4 i24_4_lut (.A(n43), .B(n48), .C(n37), .D(n38), .Z(FP_UsrLED_4__N_3)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i24_4_lut.init = 16'hfffe;
    GSR GSR_INST (.GSR(VCC_net));
    CCU2D add_2469_4 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4924), .COUT(n4925));
    defparam add_2469_4.INIT0 = 16'h5555;
    defparam add_2469_4.INIT1 = 16'h5555;
    defparam add_2469_4.INJECT1_0 = "NO";
    defparam add_2469_4.INJECT1_1 = "NO";
    LUT4 i2823_1_lut (.A(n74), .Z(n5312)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i2823_1_lut.init = 16'h5555;
    CCU2D add_2466_22 (.A0(\debounce_counters[4] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4857), .COUT(n4858));
    defparam add_2466_22.INIT0 = 16'h5555;
    defparam add_2466_22.INIT1 = 16'h5555;
    defparam add_2466_22.INJECT1_0 = "NO";
    defparam add_2466_22.INJECT1_1 = "NO";
    LUT4 next_state_3__bdd_4_lut_2911_4_lut (.A(next_state[0]), .B(next_state_3__N_488[2]), 
         .C(next_state[1]), .D(next_state[2]), .Z(n5510)) /* synthesis lut_function=(!(A (C+(D))+!A (B+((D)+!C)))) */ ;
    defparam next_state_3__bdd_4_lut_2911_4_lut.init = 16'h001a;
    FD1P3IX counter_i0_i6 (.D(n2475), .SP(clk_enable_141), .CD(n3540), 
            .CK(clk), .Q(counter[6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i6.GSR = "ENABLED";
    LUT4 i2814_4_lut (.A(next_state[2]), .B(n5224), .C(n17), .D(n5244), 
         .Z(clk_enable_77)) /* synthesis lut_function=(!(A (B+(D))+!A (B+(C+(D))))) */ ;
    defparam i2814_4_lut.init = 16'h0023;
    LUT4 ANL_S3C_CarrierReady_c_bdd_2_lut_2910 (.A(n5513), .B(next_state[2]), 
         .Z(n5514)) /* synthesis lut_function=(A (B)) */ ;
    defparam ANL_S3C_CarrierReady_c_bdd_2_lut_2910.init = 16'h8888;
    LUT4 mux_613_i9_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), .C(n2565), 
         .D(n2473), .Z(n2507)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_613_i9_3_lut_4_lut.init = 16'h7f70;
    LUT4 i1_3_lut_4_lut (.A(next_state[1]), .B(n5603), .C(next_state[2]), 
         .D(externstop_falling), .Z(n11)) /* synthesis lut_function=(A (C)+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i1_3_lut_4_lut.init = 16'hf4f0;
    LUT4 i2820_2_lut_4_lut_4_lut (.A(n3965), .B(n74), .C(n5596), .D(n5308), 
         .Z(n3947)) /* synthesis lut_function=(!(A (B+!(D))+!A (B+(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i2820_2_lut_4_lut_4_lut.init = 16'h2300;
    FD1P3IX counter_i0_i5 (.D(n1700), .SP(clk_enable_141), .CD(n3531), 
            .CK(clk), .Q(counter[5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i5.GSR = "ENABLED";
    CCU2D add_185_11 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4896), .COUT(n4897), .S0(n409), 
          .S1(n408));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_11.INIT0 = 16'h5aaa;
    defparam add_185_11.INIT1 = 16'h5aaa;
    defparam add_185_11.INJECT1_0 = "NO";
    defparam add_185_11.INJECT1_1 = "NO";
    LUT4 i2785_3_lut_4_lut_4_lut (.A(next_state[3]), .B(n5225), .C(next_state[1]), 
         .D(n5620), .Z(n3762)) /* synthesis lut_function=(!(A ((C)+!B)+!A !(B ((D)+!C)+!B (C (D))))) */ ;
    defparam i2785_3_lut_4_lut_4_lut.init = 16'h5c0c;
    LUT4 i1239_3_lut_4_lut (.A(clk_enable_141), .B(n2565), .C(n2559), 
         .D(n2563), .Z(n3531)) /* synthesis lut_function=(A (B+(C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam i1239_3_lut_4_lut.init = 16'ha8aa;
    LUT4 i2755_2_lut (.A(next_state[3]), .B(next_state[1]), .Z(n5258)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2755_2_lut.init = 16'heeee;
    LUT4 i18_4_lut (.A(counter[0]), .B(counter[14]), .C(counter[10]), 
         .D(counter[19]), .Z(n43)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i18_4_lut.init = 16'hfffe;
    LUT4 n70_bdd_3_lut_2941_4_lut (.A(next_state[0]), .B(next_state_3__N_488[2]), 
         .C(next_state[2]), .D(next_state[1]), .Z(n5527)) /* synthesis lut_function=(!(A+(B+(C+(D))))) */ ;
    defparam n70_bdd_3_lut_2941_4_lut.init = 16'h0001;
    LUT4 i1_2_lut_rep_78 (.A(FP_UsrLED_4__N_3), .B(next_state[0]), .Z(n5595)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i1_2_lut_rep_78.init = 16'h4444;
    LUT4 i1663_2_lut_3_lut (.A(n1689), .B(n2559), .C(n2563), .Z(n2465)) /* synthesis lut_function=(A+(B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i1663_2_lut_3_lut.init = 16'hefef;
    LUT4 i1_4_lut_4_lut_then_3_lut (.A(next_state[2]), .B(next_state[1]), 
         .C(next_state[0]), .Z(n5616)) /* synthesis lut_function=(A+(B (C))) */ ;
    defparam i1_4_lut_4_lut_then_3_lut.init = 16'heaea;
    LUT4 i23_4_lut (.A(n27), .B(n46), .C(n40), .D(n28), .Z(n48)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i23_4_lut.init = 16'hfffe;
    LUT4 FP_UsrLED_4__N_3_bdd_4_lut_2843_4_lut (.A(next_state[0]), .B(next_state_3__N_488[2]), 
         .C(next_state[1]), .D(next_state[2]), .Z(n5415)) /* synthesis lut_function=(!(A (C (D))+!A !(B+(C+!(D))))) */ ;
    defparam FP_UsrLED_4__N_3_bdd_4_lut_2843_4_lut.init = 16'h5eff;
    LUT4 n5226_bdd_4_lut (.A(n5226), .B(next_state[1]), .C(next_state[0]), 
         .D(next_state_3__N_488[2]), .Z(n26)) /* synthesis lut_function=(!(A (B (C (D)+!C !(D)))+!A ((C (D)+!C !(D))+!B))) */ ;
    defparam n5226_bdd_4_lut.init = 16'h2ee2;
    LUT4 i2_4_lut (.A(next_state[3]), .B(FlexMIOs53_GPIO_PowerDown_N_700), 
         .C(next_state[2]), .D(next_state[1]), .Z(FlexMIOs53_GPIO_PowerDown_N_699)) /* synthesis lut_function=(!(A+!(B (C)+!B (C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i2_4_lut.init = 16'h5040;
    LUT4 i1599_2_lut (.A(FP_UsrLED_4__N_3), .B(next_state_3__N_488[2]), 
         .Z(FlexMIOs53_GPIO_PowerDown_N_700)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(402[5] 405[12])
    defparam i1599_2_lut.init = 16'h2222;
    LUT4 i1_2_lut_3_lut_4_lut (.A(next_state[1]), .B(next_state[0]), .C(next_state[3]), 
         .D(next_state[2]), .Z(n3526)) /* synthesis lut_function=(A (C (D))+!A (B (C (D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(115[12:22])
    defparam i1_2_lut_3_lut_4_lut.init = 16'hf010;
    PFUMX i2901 (.BLUT(n5524), .ALUT(n5523), .C0(next_state[1]), .Z(n5525));
    LUT4 i2817_2_lut_3_lut_4_lut (.A(next_state[1]), .B(next_state[0]), 
         .C(next_state[3]), .D(next_state[2]), .Z(clk_enable_122)) /* synthesis lut_function=(A ((D)+!C)+!A (((D)+!C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(115[12:22])
    defparam i2817_2_lut_3_lut_4_lut.init = 16'hff1f;
    LUT4 i1_4_lut_4_lut_else_3_lut (.A(next_state[2]), .B(next_state[1]), 
         .C(next_state_3__N_488[2]), .D(next_state[0]), .Z(n5615)) /* synthesis lut_function=(A (B (D))+!A !(B+(C (D)+!C !(D)))) */ ;
    defparam i1_4_lut_4_lut_else_3_lut.init = 16'h8910;
    LUT4 i28_4_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_488[2]), 
         .C(next_state[1]), .D(n5249), .Z(n14)) /* synthesis lut_function=(!(A (C)+!A (B (C+!(D))+!B !(C+(D))))) */ ;
    defparam i28_4_lut_4_lut.init = 16'h1f1a;
    LUT4 i2819_2_lut (.A(n2563), .B(n2565), .Z(n5308)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i2819_2_lut.init = 16'hdddd;
    LUT4 i1646_2_lut (.A(n1684), .B(n2559), .Z(n2394)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i1646_2_lut.init = 16'heeee;
    LUT4 pushed_2__I_0_1_lut (.A(pushed[2]), .Z(pushed_2__N_265)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(227[17] 231[24])
    defparam pushed_2__I_0_1_lut.init = 16'h5555;
    CCU2D add_2469_2 (.A0(\debounce_counters[1] [7]), .B0(\debounce_counters[1] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[1] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n4924));
    defparam add_2469_2.INIT0 = 16'h1000;
    defparam add_2469_2.INIT1 = 16'h5aaa;
    defparam add_2469_2.INJECT1_0 = "NO";
    defparam add_2469_2.INJECT1_1 = "NO";
    CCU2D add_194_33 (.A0(\debounce_counters[4] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4923), .S0(n493));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_33.INIT0 = 16'h5aaa;
    defparam add_194_33.INIT1 = 16'h0000;
    defparam add_194_33.INJECT1_0 = "NO";
    defparam add_194_33.INJECT1_1 = "NO";
    CCU2D add_167_25 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4871), .COUT(n4872), .S0(n183), 
          .S1(n182));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_25.INIT0 = 16'h5aaa;
    defparam add_167_25.INIT1 = 16'h5aaa;
    defparam add_167_25.INJECT1_0 = "NO";
    defparam add_167_25.INJECT1_1 = "NO";
    LUT4 pushed_3__I_0_1_lut (.A(pushed[3]), .Z(pushed_3__N_263)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(227[17] 231[24])
    defparam pushed_3__I_0_1_lut.init = 16'h5555;
    LUT4 n3157_bdd_4_lut_then_4_lut (.A(next_state_3__N_488[2]), .B(externstop_falling), 
         .C(next_state[0]), .D(signals_debounced_syn[3]), .Z(n5619)) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(C))) */ ;
    defparam n3157_bdd_4_lut_then_4_lut.init = 16'hfefc;
    LUT4 i1628_4_lut (.A(n4), .B(next_state[2]), .C(next_state[0]), .D(next_state[1]), 
         .Z(n7)) /* synthesis lut_function=(A ((C (D))+!B)+!A ((C (D)+!C !(D))+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i1628_4_lut.init = 16'hf337;
    LUT4 n3157_bdd_4_lut_else_4_lut (.A(signals_debounced_syn[2]), .B(FP_UsrLED_c_4), 
         .C(next_state[0]), .Z(n5618)) /* synthesis lut_function=(!(A (C)+!A !(B+!(C)))) */ ;
    defparam n3157_bdd_4_lut_else_4_lut.init = 16'h4f4f;
    LUT4 i1_2_lut (.A(next_state_3__N_488[2]), .B(FP_UsrLED_4__N_3), .Z(n4)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut.init = 16'heeee;
    LUT4 i1615_4_lut_4_lut (.A(externstop_falling), .B(next_state_3__N_488[2]), 
         .C(signals_debounced_syn[3]), .D(next_state[3]), .Z(next_state_3__N_484[3])) /* synthesis lut_function=(!(A+!(B ((D)+!C)+!B !(C)))) */ ;
    defparam i1615_4_lut_4_lut.init = 16'h4505;
    LUT4 i72_4_lut_then_4_lut (.A(FP_UsrLED_4__N_3), .B(next_state[0]), 
         .C(signals_debounced_syn[2]), .D(FP_UsrLED_c_4), .Z(n5622)) /* synthesis lut_function=(!(A+!(B (C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(115[12:22])
    defparam i72_4_lut_then_4_lut.init = 16'h4044;
    LUT4 mux_604_i18_4_lut (.A(next_state[1]), .B(n1688), .C(n2563), .D(n2559), 
         .Z(n2464)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam mux_604_i18_4_lut.init = 16'hf5c5;
    LUT4 i29_4_lut_else_4_lut (.A(next_state[0]), .B(next_state_3__N_488[2]), 
         .Z(n5609)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i29_4_lut_else_4_lut.init = 16'h4444;
    LUT4 i52_4_lut_4_lut (.A(next_state[2]), .B(FP_UsrLED_4__N_3), .C(next_state_3__N_488[2]), 
         .D(next_state[0]), .Z(n26_adj_3)) /* synthesis lut_function=(!(A ((C+(D))+!B)+!A !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(115[12:22])
    defparam i52_4_lut_4_lut.init = 16'h5058;
    LUT4 i1_3_lut_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), .C(next_state[0]), 
         .D(FP_UsrLED_4__N_3), .Z(n49)) /* synthesis lut_function=(!(A+!(B+!((D)+!C)))) */ ;
    defparam i1_3_lut_4_lut_4_lut.init = 16'h4454;
    LUT4 i3_4_lut (.A(next_state_3__N_488[2]), .B(signals_debounced_syn[4]), 
         .C(externstop_falling), .D(next_state[0]), .Z(n5226)) /* synthesis lut_function=(!(((C+(D))+!B)+!A)) */ ;
    defparam i3_4_lut.init = 16'h0008;
    LUT4 i54_4_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_488[2]), 
         .C(next_state[2]), .D(FP_UsrLED_4__N_3), .Z(n29)) /* synthesis lut_function=(!(A ((C)+!B)+!A (B (C)+!B !(C (D))))) */ ;
    defparam i54_4_lut_4_lut.init = 16'h1c0c;
    LUT4 i2_3_lut_4_lut_4_lut (.A(externstop_falling), .B(next_state[0]), 
         .C(signals_debounced_syn[3]), .D(next_state_3__N_488[2]), .Z(n6)) /* synthesis lut_function=(!(A+!(B ((D)+!C)))) */ ;
    defparam i2_3_lut_4_lut_4_lut.init = 16'h4404;
    LUT4 i1619_3_lut (.A(n1690), .B(n2563), .C(n2559), .Z(n2466)) /* synthesis lut_function=(!(A (B (C))+!A (B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i1619_3_lut.init = 16'h3b3b;
    LUT4 i767_2_lut (.A(clk_enable_5), .B(debounce_inputs_asyn2[1]), .Z(clk_enable_107)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i767_2_lut.init = 16'hdddd;
    LUT4 pushed_1__I_0_1_lut (.A(pushed[1]), .Z(pushed_1__N_267)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(227[17] 231[24])
    defparam pushed_1__I_0_1_lut.init = 16'h5555;
    LUT4 i1640_2_lut (.A(n1691), .B(n2559), .Z(n2401)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i1640_2_lut.init = 16'heeee;
    LUT4 i2806_4_lut (.A(n26_adj_3), .B(next_state[2]), .C(n5258), .D(n29_adj_4), 
         .Z(clk_enable_111)) /* synthesis lut_function=(A (B (C)+!B !((D)+!C))+!A (B+!(D))) */ ;
    defparam i2806_4_lut.init = 16'hc4f5;
    LUT4 i1_2_lut_2_lut (.A(next_state[0]), .B(next_state_3__N_488[2]), 
         .Z(n10)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i1_2_lut_2_lut.init = 16'hdddd;
    LUT4 mux_604_i14_4_lut (.A(next_state[1]), .B(n1692), .C(n2563), .D(n2559), 
         .Z(n2468)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam mux_604_i14_4_lut.init = 16'hf5c5;
    LUT4 i2798_2_lut_2_lut_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(next_state[0]), .D(next_state[1]), .Z(clk_enable_117)) /* synthesis lut_function=((B+(C (D)+!C !(D)))+!A) */ ;
    defparam i2798_2_lut_2_lut_3_lut_4_lut.init = 16'hfddf;
    CCU2D add_185_9 (.A0(\debounce_counters[3] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4895), .COUT(n4896), .S0(n411), 
          .S1(n410));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_9.INIT0 = 16'h5aaa;
    defparam add_185_9.INIT1 = 16'h5aaa;
    defparam add_185_9.INJECT1_0 = "NO";
    defparam add_185_9.INJECT1_1 = "NO";
    CCU2D add_194_31 (.A0(\debounce_counters[4] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4922), .COUT(n4923), .S0(n495), 
          .S1(n494));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_31.INIT0 = 16'h5aaa;
    defparam add_194_31.INIT1 = 16'h5aaa;
    defparam add_194_31.INJECT1_0 = "NO";
    defparam add_194_31.INJECT1_1 = "NO";
    LUT4 mux_604_i12_4_lut (.A(next_state[1]), .B(n1694), .C(n2563), .D(n2559), 
         .Z(n2470)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam mux_604_i12_4_lut.init = 16'hf5c5;
    LUT4 i1165_2_lut_rep_86 (.A(next_state_3__N_488[2]), .B(next_state[0]), 
         .Z(n5603)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam i1165_2_lut_rep_86.init = 16'h2222;
    LUT4 i1618_3_lut (.A(n1695), .B(n2563), .C(n2559), .Z(n2471)) /* synthesis lut_function=(!(A (B (C))+!A (B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i1618_3_lut.init = 16'h3b3b;
    CCU2D add_194_29 (.A0(\debounce_counters[4] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4921), .COUT(n4922), .S0(n497), 
          .S1(n496));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_29.INIT0 = 16'h5aaa;
    defparam add_194_29.INIT1 = 16'h5aaa;
    defparam add_194_29.INJECT1_0 = "NO";
    defparam add_194_29.INJECT1_1 = "NO";
    LUT4 i36_3_lut_4_lut (.A(next_state_3__N_488[2]), .B(next_state[0]), 
         .C(next_state[3]), .D(FP_UsrLED_4__N_3), .Z(n19)) /* synthesis lut_function=(!(A (C+!(D))+!A !(B (C+(D))+!B !(C+!(D))))) */ ;
    defparam i36_3_lut_4_lut.init = 16'h4f40;
    CCU2D add_2466_20 (.A0(\debounce_counters[4] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4856), .COUT(n4857));
    defparam add_2466_20.INIT0 = 16'h5555;
    defparam add_2466_20.INIT1 = 16'h5555;
    defparam add_2466_20.INJECT1_0 = "NO";
    defparam add_2466_20.INJECT1_1 = "NO";
    L6MUX21 i76 (.D0(n3664), .D1(n45), .SD(n5258), .Z(n74));
    LUT4 mux_604_i7_4_lut (.A(next_state[1]), .B(n1699), .C(n2563), .D(n2559), 
         .Z(n2475)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam mux_604_i7_4_lut.init = 16'h0aca;
    PFUMX i2951 (.BLUT(n5609), .ALUT(n5610), .C0(next_state[1]), .Z(n5611));
    LUT4 i1_2_lut_rep_79_3_lut (.A(next_state_3__N_488[2]), .B(next_state[0]), 
         .C(next_state[1]), .Z(n5596)) /* synthesis lut_function=(!((B+(C))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam i1_2_lut_rep_79_3_lut.init = 16'h0202;
    LUT4 i1_4_lut_4_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_488[2]), 
         .C(n5599), .D(next_state[3]), .Z(n23)) /* synthesis lut_function=(!(A ((D)+!B)+!A !(B (C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i1_4_lut_4_lut_4_lut.init = 16'h40cc;
    LUT4 i2_2_lut_adj_2 (.A(counter[17]), .B(counter[22]), .Z(n27)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2_2_lut_adj_2.init = 16'heeee;
    LUT4 i12_2_lut (.A(counter[7]), .B(counter[12]), .Z(n37)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i12_2_lut.init = 16'heeee;
    LUT4 i27_4_lut (.A(n5543), .B(next_state[2]), .C(next_state[3]), .D(n14), 
         .Z(next_state_3__N_34[0])) /* synthesis lut_function=(!(A (B (C)+!B !((D)+!C))+!A (B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i27_4_lut.init = 16'h3a0a;
    LUT4 i21_4_lut (.A(counter[11]), .B(n42), .C(n32), .D(counter[20]), 
         .Z(n46)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i21_4_lut.init = 16'hfffe;
    LUT4 i1_2_lut_rep_82 (.A(externstop_falling), .B(signals_debounced_syn[4]), 
         .Z(n5599)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i1_2_lut_rep_82.init = 16'h4444;
    LUT4 i15_4_lut (.A(counter[15]), .B(counter[3]), .C(counter[1]), .D(counter[24]), 
         .Z(n40)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i15_4_lut.init = 16'hfffe;
    LUT4 i1_2_lut_3_lut (.A(externstop_falling), .B(signals_debounced_syn[4]), 
         .C(next_state_3__N_488[2]), .Z(n5249)) /* synthesis lut_function=(A (C)+!A !(B+!(C))) */ ;
    defparam i1_2_lut_3_lut.init = 16'hb0b0;
    PFUMX i21 (.BLUT(n10), .ALUT(n6), .C0(next_state[2]), .Z(n3664));
    LUT4 i29_4_lut_then_4_lut (.A(FP_UsrLED_4__N_3), .B(next_state[0]), 
         .C(signals_debounced_syn[2]), .D(FP_UsrLED_c_4), .Z(n5610)) /* synthesis lut_function=(!(A+!((C+!(D))+!B))) */ ;
    defparam i29_4_lut_then_4_lut.init = 16'h5155;
    LUT4 i1_4_lut_adj_3 (.A(next_state[3]), .B(externstop_falling), .C(n11), 
         .D(n5219), .Z(n2565)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;
    defparam i1_4_lut_adj_3.init = 16'heca0;
    LUT4 i1_4_lut_adj_4 (.A(externstop_falling), .B(n5595), .C(n5604), 
         .D(n5601), .Z(n59)) /* synthesis lut_function=(A (B)+!A (B+!((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(115[12:22])
    defparam i1_4_lut_adj_4.init = 16'hccdc;
    LUT4 i1675_4_lut (.A(FP_UsrLED_4__N_3), .B(externstop_falling), .C(next_state[3]), 
         .D(next_state[2]), .Z(n3965)) /* synthesis lut_function=(A (B+(D))+!A (B (C)+!B (C (D)))) */ ;
    defparam i1675_4_lut.init = 16'hfac8;
    LUT4 i2_3_lut_4_lut_4_lut_adj_5 (.A(n5602), .B(n5258), .C(FP_UsrLED_4__N_3), 
         .D(next_state[2]), .Z(n5244)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;
    defparam i2_3_lut_4_lut_4_lut_adj_5.init = 16'h2000;
    PFUMX i2893 (.BLUT(n5514), .ALUT(n5510), .C0(next_state[3]), .Z(next_state_3__N_34[3]));
    LUT4 i1_2_lut_adj_6 (.A(signals_debounced_syn[2]), .B(externstop_last), 
         .Z(externstop_falling_N_709)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam i1_2_lut_adj_6.init = 16'h4444;
    TSALL TSALL_INST (.TSALL(GND_net));
    LUT4 i3_2_lut (.A(counter[23]), .B(counter[4]), .Z(n28)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i3_2_lut.init = 16'heeee;
    FD1P3AX counter_i0_i8 (.D(n2507), .SP(clk_enable_141), .CK(clk), .Q(counter[8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i8.GSR = "ENABLED";
    FD1P3AX counter_i0_i9 (.D(n2506), .SP(clk_enable_141), .CK(clk), .Q(counter[9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i9.GSR = "ENABLED";
    LUT4 i17_4_lut (.A(counter[2]), .B(counter[13]), .C(counter[9]), .D(counter[18]), 
         .Z(n42)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i17_4_lut.init = 16'hfffe;
    FD1P3AX counter_i0_i12 (.D(n2503), .SP(clk_enable_141), .CK(clk), 
            .Q(counter[12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i12.GSR = "ENABLED";
    PFUMX i1375 (.BLUT(n59), .ALUT(n49), .C0(next_state[3]), .Z(n45));
    LUT4 next_state_2__bdd_4_lut_2962 (.A(externstop_falling), .B(next_state[3]), 
         .C(signals_debounced_syn[4]), .D(next_state_3__N_488[2]), .Z(n5573)) /* synthesis lut_function=(A (B)+!A !((C (D))+!B)) */ ;
    defparam next_state_2__bdd_4_lut_2962.init = 16'h8ccc;
    LUT4 i1_2_lut_3_lut_adj_7 (.A(next_state[1]), .B(next_state[0]), .C(next_state[2]), 
         .Z(n5219)) /* synthesis lut_function=(!(A (B+!(C))+!A !(B (C)))) */ ;
    defparam i1_2_lut_3_lut_adj_7.init = 16'h6060;
    FD1P3AX counter_i0_i18 (.D(n2497), .SP(clk_enable_141), .CK(clk), 
            .Q(counter[18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i18.GSR = "ENABLED";
    FD1P3AX counter_i0_i19 (.D(n2496), .SP(clk_enable_141), .CK(clk), 
            .Q(counter[19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i19.GSR = "ENABLED";
    FD1P3AX counter_i0_i20 (.D(n2495), .SP(clk_enable_141), .CK(clk), 
            .Q(counter[20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i20.GSR = "ENABLED";
    FD1P3AX counter_i0_i22 (.D(n2493), .SP(clk_enable_141), .CK(clk), 
            .Q(counter[22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i22.GSR = "ENABLED";
    FD1P3AX counter_i0_i23 (.D(n2492), .SP(clk_enable_141), .CK(clk), 
            .Q(counter[23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i23.GSR = "ENABLED";
    FD1P3AX counter_i0_i24 (.D(n2491), .SP(clk_enable_141), .CK(clk), 
            .Q(counter[24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam counter_i0_i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i1 (.D(n311), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i1.GSR = "ENABLED";
    LUT4 i886_2_lut (.A(n2559), .B(n2563), .Z(n3185)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i886_2_lut.init = 16'hbbbb;
    LUT4 i1_3_lut (.A(next_state[2]), .B(externstop_falling), .C(signals_debounced_syn[3]), 
         .Z(n3649)) /* synthesis lut_function=(A (B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam i1_3_lut.init = 16'ha8a8;
    LUT4 n3646_bdd_3_lut (.A(n3646), .B(n3649), .C(next_state[0]), .Z(n5524)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam n3646_bdd_3_lut.init = 16'hcaca;
    LUT4 i7_2_lut (.A(counter[16]), .B(counter[21]), .Z(n32)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i7_2_lut.init = 16'heeee;
    LUT4 next_state_3__bdd_2_lut_2874 (.A(next_state[2]), .B(n26), .Z(n5414)) /* synthesis lut_function=(A+!(B)) */ ;
    defparam next_state_3__bdd_2_lut_2874.init = 16'hbbbb;
    LUT4 next_state_2__bdd_2_lut_2961 (.A(next_state[3]), .B(next_state_3__N_488[2]), 
         .Z(n5572)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam next_state_2__bdd_2_lut_2961.init = 16'h4444;
    PFUMX i1479 (.BLUT(n3761), .ALUT(n3762), .C0(n5274), .Z(n3773));
    LUT4 i13_3_lut (.A(counter[8]), .B(counter[5]), .C(counter[6]), .Z(n38)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i13_3_lut.init = 16'hfefe;
    LUT4 i1_2_lut_rep_87 (.A(next_state[2]), .B(next_state[0]), .Z(n5604)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(115[12:22])
    defparam i1_2_lut_rep_87.init = 16'h2222;
    CCU2D add_185_7 (.A0(\debounce_counters[3] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4894), .COUT(n4895), .S0(n413), 
          .S1(n412));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_7.INIT0 = 16'h5aaa;
    defparam add_185_7.INIT1 = 16'h5aaa;
    defparam add_185_7.INJECT1_0 = "NO";
    defparam add_185_7.INJECT1_1 = "NO";
    LUT4 next_state_0__bdd_4_lut_2914 (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[2]), .D(next_state[3]), .Z(FP_SysLEDg_N_683)) /* synthesis lut_function=(!(A (C (D))+!A (B+(C (D)+!C !(D))))) */ ;
    defparam next_state_0__bdd_4_lut_2914.init = 16'h0bba;
    LUT4 i2809_4_lut (.A(n29), .B(next_state[2]), .C(n5258), .D(n32_adj_1), 
         .Z(clk_enable_113)) /* synthesis lut_function=(A (B (C)+!B !((D)+!C))+!A (B+!(D))) */ ;
    defparam i2809_4_lut.init = 16'hc4f5;
    CCU2D add_2467_26 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4972), .S1(clk_enable_109));
    defparam add_2467_26.INIT0 = 16'hf555;
    defparam add_2467_26.INIT1 = 16'h0000;
    defparam add_2467_26.INJECT1_0 = "NO";
    defparam add_2467_26.INJECT1_1 = "NO";
    LUT4 i520_2_lut_rep_84 (.A(next_state_3__N_488[2]), .B(signals_debounced_syn[3]), 
         .Z(n5601)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(317[17] 327[12])
    defparam i520_2_lut_rep_84.init = 16'h4444;
    LUT4 mux_604_i9_4_lut (.A(next_state[1]), .B(n1697), .C(n2563), .D(n2559), 
         .Z(n2473)) /* synthesis lut_function=(!(A (((D)+!C)+!B)+!A (B (C (D))+!B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam mux_604_i9_4_lut.init = 16'h05c5;
    CCU2D add_185_5 (.A0(\debounce_counters[3] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4893), .COUT(n4894), .S0(n415), 
          .S1(n414));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_5.INIT0 = 16'h5aaa;
    defparam add_185_5.INIT1 = 16'h5aaa;
    defparam add_185_5.INJECT1_0 = "NO";
    defparam add_185_5.INJECT1_1 = "NO";
    CCU2D add_194_27 (.A0(\debounce_counters[4] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4920), .COUT(n4921), .S0(n499), 
          .S1(n498));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_194_27.INIT0 = 16'h5aaa;
    defparam add_194_27.INIT1 = 16'h5aaa;
    defparam add_194_27.INJECT1_0 = "NO";
    defparam add_194_27.INJECT1_1 = "NO";
    LUT4 pushed_4__I_0_1_lut (.A(pushed[4]), .Z(pushed_4__N_261)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(227[17] 231[24])
    defparam pushed_4__I_0_1_lut.init = 16'h5555;
    CCU2D add_2466_18 (.A0(\debounce_counters[4] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4855), .COUT(n4856));
    defparam add_2466_18.INIT0 = 16'h5555;
    defparam add_2466_18.INIT1 = 16'h5555;
    defparam add_2466_18.INJECT1_0 = "NO";
    defparam add_2466_18.INJECT1_1 = "NO";
    CCU2D add_2466_16 (.A0(\debounce_counters[4] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4854), .COUT(n4855));
    defparam add_2466_16.INIT0 = 16'h5555;
    defparam add_2466_16.INIT1 = 16'h5555;
    defparam add_2466_16.INJECT1_0 = "NO";
    defparam add_2466_16.INJECT1_1 = "NO";
    CCU2D add_2467_24 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4971), .COUT(n4972));
    defparam add_2467_24.INIT0 = 16'h5555;
    defparam add_2467_24.INIT1 = 16'h5555;
    defparam add_2467_24.INJECT1_0 = "NO";
    defparam add_2467_24.INJECT1_1 = "NO";
    CCU2D add_185_3 (.A0(\debounce_counters[3] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4892), .COUT(n4893), .S0(n417), 
          .S1(n416));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_3.INIT0 = 16'h5aaa;
    defparam add_185_3.INIT1 = 16'h5aaa;
    defparam add_185_3.INJECT1_0 = "NO";
    defparam add_185_3.INJECT1_1 = "NO";
    CCU2D add_185_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[3] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n4892), .S1(n418));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_185_1.INIT0 = 16'hF000;
    defparam add_185_1.INIT1 = 16'h5555;
    defparam add_185_1.INJECT1_0 = "NO";
    defparam add_185_1.INJECT1_1 = "NO";
    CCU2D add_167_23 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4870), .COUT(n4871), .S0(n185), 
          .S1(n184));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_23.INIT0 = 16'h5aaa;
    defparam add_167_23.INIT1 = 16'h5aaa;
    defparam add_167_23.INJECT1_0 = "NO";
    defparam add_167_23.INJECT1_1 = "NO";
    CCU2D add_167_21 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4869), .COUT(n4870), .S0(n187), 
          .S1(n186));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(218[49:69])
    defparam add_167_21.INIT0 = 16'h5aaa;
    defparam add_167_21.INIT1 = 16'h5aaa;
    defparam add_167_21.INJECT1_0 = "NO";
    defparam add_167_21.INJECT1_1 = "NO";
    LUT4 n3646_bdd_4_lut (.A(FP_UsrLED_4__N_3), .B(n3649), .C(next_state[2]), 
         .D(next_state[0]), .Z(n5523)) /* synthesis lut_function=(A (B+(D))+!A !(B (C (D))+!B (C+!(D)))) */ ;
    defparam n3646_bdd_4_lut.init = 16'hafcc;
    LUT4 i1_4_lut_then_4_lut (.A(FP_UsrLED_4__N_3), .B(next_state[1]), .C(next_state[0]), 
         .D(next_state[2]), .Z(n5613)) /* synthesis lut_function=(A (B (C+(D))+!B (D))+!A !(B (C+!(D))+!B !(C (D)))) */ ;
    defparam i1_4_lut_then_4_lut.init = 16'hbe80;
    PFUMX i2891 (.BLUT(n5512), .ALUT(n5511), .C0(FP_UsrLED_4__N_3), .Z(n5513));
    FD1P3IX debounce_counters_2___i2 (.D(n310), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i3 (.D(n309), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i4 (.D(n308), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i5 (.D(n307), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i6 (.D(n306), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i7 (.D(n305), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i8 (.D(n304), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i9 (.D(n303), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i10 (.D(n302), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i11 (.D(n301), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i12 (.D(n300), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i13 (.D(n299), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i14 (.D(n298), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i15 (.D(n297), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i16 (.D(n296), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i17 (.D(n295), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i18 (.D(n294), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i19 (.D(n293), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i20 (.D(n292), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i21 (.D(n291), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i22 (.D(n290), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i23 (.D(n289), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i24 (.D(n288), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i25 (.D(n287), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i26 (.D(n286), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i27 (.D(n285), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i28 (.D(n284), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i29 (.D(n283), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i30 (.D(n282), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i31 (.D(n281), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(210[9] 236[10])
    defparam debounce_counters_2___i31.GSR = "ENABLED";
    LUT4 n3646_bdd_3_lut_2900 (.A(n3646), .B(next_state[1]), .C(next_state[0]), 
         .Z(n5522)) /* synthesis lut_function=(!((B+(C))+!A)) */ ;
    defparam n3646_bdd_3_lut_2900.init = 16'h0202;
    CCU2D add_2467_22 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4970), .COUT(n4971));
    defparam add_2467_22.INIT0 = 16'h5555;
    defparam add_2467_22.INIT1 = 16'h5555;
    defparam add_2467_22.INJECT1_0 = "NO";
    defparam add_2467_22.INJECT1_1 = "NO";
    CCU2D add_2467_20 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4969), .COUT(n4970));
    defparam add_2467_20.INIT0 = 16'h5555;
    defparam add_2467_20.INIT1 = 16'h5555;
    defparam add_2467_20.INJECT1_0 = "NO";
    defparam add_2467_20.INJECT1_1 = "NO";
    CCU2D add_2467_18 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4968), .COUT(n4969));
    defparam add_2467_18.INIT0 = 16'h5555;
    defparam add_2467_18.INIT1 = 16'h5555;
    defparam add_2467_18.INJECT1_0 = "NO";
    defparam add_2467_18.INJECT1_1 = "NO";
    CCU2D add_2467_16 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4967), .COUT(n4968));
    defparam add_2467_16.INIT0 = 16'h5555;
    defparam add_2467_16.INIT1 = 16'h5555;
    defparam add_2467_16.INJECT1_0 = "NO";
    defparam add_2467_16.INJECT1_1 = "NO";
    CCU2D add_2467_14 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4966), .COUT(n4967));
    defparam add_2467_14.INIT0 = 16'h5555;
    defparam add_2467_14.INIT1 = 16'h5555;
    defparam add_2467_14.INJECT1_0 = "NO";
    defparam add_2467_14.INJECT1_1 = "NO";
    LUT4 i53_4_lut (.A(next_state[1]), .B(n26), .C(next_state[3]), .D(FP_UsrLED_4__N_3), 
         .Z(n32_adj_1)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;
    defparam i53_4_lut.init = 16'hcac0;
    LUT4 i1_4_lut_adj_8 (.A(n3773), .B(n5602), .C(next_state[1]), .D(next_state[2]), 
         .Z(next_state_3__N_34[1])) /* synthesis lut_function=(A+!(((D)+!C)+!B)) */ ;
    defparam i1_4_lut_adj_8.init = 16'haaea;
    LUT4 i1597_2_lut_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(next_state[0]), .D(next_state[1]), .Z(Carrier_PG_1V8_N_781)) /* synthesis lut_function=(A+(B+!(C (D)+!C !(D)))) */ ;
    defparam i1597_2_lut_3_lut_4_lut.init = 16'heffe;
    PFUMX i2959 (.BLUT(n5609), .ALUT(n5622), .C0(next_state[1]), .Z(n5623));
    LUT4 i1622_2_lut_3_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[1]), 
         .Z(FPIO_isoCtrlRSTn_N_686)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;
    defparam i1622_2_lut_3_lut.init = 16'h1010;
    LUT4 mux_604_i10_4_lut (.A(next_state[1]), .B(n1696), .C(n2563), .D(n2559), 
         .Z(n2472)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam mux_604_i10_4_lut.init = 16'hfaca;
    PFUMX i35 (.BLUT(n23), .ALUT(n19), .C0(next_state[1]), .Z(n17));
    LUT4 i1_4_lut_adj_9 (.A(next_state[1]), .B(next_state[2]), .C(next_state[3]), 
         .D(next_state[0]), .Z(clk_enable_20)) /* synthesis lut_function=(A+(B (C+(D))+!B !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(115[12:22])
    defparam i1_4_lut_adj_9.init = 16'heffb;
    LUT4 i1_4_lut_4_lut (.A(next_state[3]), .B(next_state[2]), .C(n5605), 
         .D(n5623), .Z(clk_enable_118)) /* synthesis lut_function=(A (B+(C))+!A (B (C)+!B (D))) */ ;
    defparam i1_4_lut_4_lut.init = 16'hf9e8;
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    LUT4 mux_613_i13_4_lut (.A(n1693), .B(n5606), .C(n2565), .D(n3185), 
         .Z(n2503)) /* synthesis lut_function=(!(A (B (C))+!A (B (C+!(D))+!B !(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam mux_613_i13_4_lut.init = 16'h3f3a;
    PFUMX i2957 (.BLUT(n5618), .ALUT(n5619), .C0(next_state[2]), .Z(n5620));
    LUT4 i2802_4_lut (.A(next_state[0]), .B(FP_UsrLED_4__N_3), .C(next_state[1]), 
         .D(next_state[2]), .Z(clk_enable_115)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam i2802_4_lut.init = 16'h2000;
    LUT4 n5525_bdd_3_lut (.A(n5525), .B(n5522), .C(next_state[3]), .Z(next_state_3__N_34[2])) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam n5525_bdd_3_lut.init = 16'hcaca;
    LUT4 i1_2_lut_3_lut_adj_10 (.A(next_state[3]), .B(next_state[0]), .C(next_state[2]), 
         .Z(Carrier_PwrOn_N_702)) /* synthesis lut_function=(!(A+((C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(249[2] 427[9])
    defparam i1_2_lut_3_lut_adj_10.init = 16'h0404;
    PFUMX i2955 (.BLUT(n5615), .ALUT(n5616), .C0(next_state[3]), .Z(clk_enable_22));
    LUT4 i1_4_lut_else_4_lut (.A(FP_UsrLED_4__N_3), .B(next_state[1]), .C(next_state[0]), 
         .D(next_state[2]), .Z(n5612)) /* synthesis lut_function=(A (B (C)+!B !(C+!(D)))) */ ;
    defparam i1_4_lut_else_4_lut.init = 16'h8280;
    LUT4 i1_2_lut_3_lut_adj_11 (.A(next_state_3__N_488[2]), .B(signals_debounced_syn[3]), 
         .C(externstop_falling), .Z(n70)) /* synthesis lut_function=(!(A+((C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(317[17] 327[12])
    defparam i1_2_lut_3_lut_adj_11.init = 16'h0404;
    LUT4 i2_3_lut_4_lut_adj_12 (.A(next_state[3]), .B(next_state[2]), .C(next_state[1]), 
         .D(n5603), .Z(n5224)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;
    defparam i2_3_lut_4_lut_adj_12.init = 16'h2000;
    PFUMX i2953 (.BLUT(n5612), .ALUT(n5613), .C0(n70), .Z(n5614));
    LUT4 m1_lut (.Z(n5787)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    VLO i1 (.Z(GND_net));
    LUT4 i49_4_lut_adj_13 (.A(TDnALERT_c), .B(n98), .C(n66), .D(FlexIO04_c), 
         .Z(n113)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i49_4_lut_adj_13.init = 16'h8000;
    LUT4 i63_4_lut (.A(n113), .B(n126), .C(n122), .D(n114), .Z(dummy_signal)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(174[17] 185[58])
    defparam i63_4_lut.init = 16'h8000;
    LUT4 mux_604_i19_4_lut (.A(next_state[1]), .B(n1687), .C(n2563), .D(n2559), 
         .Z(n2463)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(250[9] 426[18])
    defparam mux_604_i19_4_lut.init = 16'hf5c5;
    LUT4 n70_bdd_4_lut (.A(n70), .B(next_state[1]), .C(next_state[2]), 
         .D(next_state[0]), .Z(n5528)) /* synthesis lut_function=(!((B ((D)+!C)+!B !(C (D)))+!A)) */ ;
    defparam n70_bdd_4_lut.init = 16'h2080;
    
endmodule
//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

