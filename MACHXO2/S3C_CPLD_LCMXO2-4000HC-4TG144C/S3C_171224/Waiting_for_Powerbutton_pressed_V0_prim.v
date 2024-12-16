// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Mon Dec 16 19:31:51 2024
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
    input FPIO_FlexMIO28 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(31[3:17])
    input FPIO_FlexMIO27 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(32[3:17])
    input FPIO_FlexMIO30 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(33[3:17])
    input FPIO_FlexMIO29 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(34[3:17])
    output FPIO_FlexMIO52;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(35[3:17])
    output Carrier_PG_1V8;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(37[3:17])
    input S3CsI2C_SDA /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(38[3:14])
    input S3CsI2C_SCL /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(39[3:14])
    output FP_SysLEDs;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(40[3:13])
    input SD1_CD;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(41[3:9])
    input SD0_CD;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(42[3:9])
    input SPI_S3C_nCS_USR;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(43[3:18])
    output [4:1]FP_UsrLED;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(45[3:12])
    output DIGS3C_Shared_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(50[3:29])
    output DIGS3C_Shared_ReqSafeState;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(51[3:29])
    input [5:1]DIGS3C_SlotD_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(52[3:21])
    input [5:1]DIGS3C_SlotD_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(53[3:22])
    input [5:0]FlexLIO;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(54[3:10])
    input DIG5S3C26 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(56[3:12])
    input DIG5S3C25 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(57[3:12])
    input DIG5S3C24 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(58[3:12])
    output SD_SEL;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(59[3:9])
    input FlexMIOs52_PCIe;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(62[3:18])
    output FlexMIOs53_GPIO_PowerDown;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(63[3:28])
    input FlexMIOs54 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(64[3:13])
    output FlexMio61ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(65[3:24])
    input FlexMIOs62 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(66[3:13])
    input FlexMIOs63 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(67[3:13])
    input FlexMIOs31 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(68[3:13])
    input FlexMIOs30 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(69[3:13])
    input FlexMIOs29 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(70[3:13])
    input FlexMIOs28 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(71[3:13])
    input FlexMIOs27 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(72[3:13])
    input FlexMIOs26 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(73[3:13])
    input FlexMIOs45 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(74[3:13])
    input FlexMIOs37 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[3:13])
    input FlexMIOs36 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(76[3:13])
    input FlexMIOs35 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(77[3:13])
    input FlexMIOs34 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(78[3:13])
    input FlexMIOs33 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(79[3:13])
    input FlexMIOs32 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(80[3:13])
    input DIG5S3C03 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(82[3:12])
    input DIG5S3C04 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(83[3:12])
    input DIG5S3C05 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(84[3:12])
    input DIG5S3C00 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(85[3:12])
    input DIG5S3C02 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(86[3:12])
    input DIG5S3C01 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(87[3:12])
    input DIG5S3C29 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(88[3:12])
    input DIG5S3C28 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(89[3:12])
    input DIG5S3C27 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(90[3:12])
    input [3:1]ANL_S3C_SLOTOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(93[3:17])
    output ANL_S3C_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(94[3:23])
    input ANL_S3C_P54_Legacy /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(95[3:21])
    output [5:1]DIGS3C_SlotD_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(96[3:22])
    output Carrier_PwrOn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(99[9:22])
    input PG_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(100[3:9])
    input PPn_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(101[3:10])
    input PG_Module;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(102[3:12])
    input TDnSHDN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(103[3:10])
    input TDnFFnFS /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(104[3:11])
    input TDnALERT;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(105[3:11])
    input S3C_S1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(106[3:9])
    
    wire clk /* synthesis is_clock=1, SET_AS_NETWORK=clk */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(112[9:12])
    wire dummy_signal /* synthesis noclip="on" */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(156[9:21])
    
    wire GND_net, VCC_net, FP_SysLEDg_c, FP_SysLEDr_c, FP_SysLEDb_c, 
        FlexIO04_c, FlexIO03_c, n41, FP_UsrSW1_c, FP_UsrSW2_c, SCL_c, 
        SDA_c, FP_UsrSW3_c, SysSW_Pwr_NC_c, FPIO_isoCtrlRSTn_c, FPIO_iosCtrlINTn_c, 
        Carrier_PG_3V3_c, FlexMio61ExternalStop_c_c, FPIO_FlexMIO28_c, 
        FPIO_FlexMIO27_c, FPIO_FlexMIO30_c, FPIO_FlexMIO29_c, FPIO_FlexMIO52_c_c, 
        S3CsI2C_SDA_c, S3CsI2C_SCL_c, FP_SysLEDs_c, SD1_CD_c, SD0_CD_c, 
        SPI_S3C_nCS_USR_c, n44, n62, n102_adj_1, DIGS3C_Shared_ReqSafeState_c, 
        DIGS3C_SlotD_ReqOE_c_5, DIGS3C_SlotD_ReqOE_c_4, DIGS3C_SlotD_ReqOE_c_3, 
        DIGS3C_SlotD_ReqOE_c_2, DIGS3C_SlotD_ReqOE_c_1, DIGS3C_SlotD_SlotOK_c_5, 
        DIGS3C_SlotD_SlotOK_c_4, DIGS3C_SlotD_SlotOK_c_3, DIGS3C_SlotD_SlotOK_c_2, 
        DIGS3C_SlotD_SlotOK_c_1, FlexLIO_c_5, FlexLIO_c_4, FlexLIO_c_3, 
        FlexLIO_c_2, FlexLIO_c_1, FlexLIO_c_0, DIG5S3C26_c, DIG5S3C25_c, 
        DIG5S3C24_c, FlexMIOs53_GPIO_PowerDown_c, FlexMIOs54_c, FlexMIOs62_c, 
        FlexMIOs63_c, FlexMIOs31_c, FlexMIOs30_c, FlexMIOs29_c, FlexMIOs28_c, 
        FlexMIOs27_c, FlexMIOs26_c, FlexMIOs45_c, FlexMIOs37_c, FlexMIOs36_c, 
        FlexMIOs35_c, FlexMIOs34_c, FlexMIOs33_c, FlexMIOs32_c, DIG5S3C03_c, 
        DIG5S3C04_c, DIG5S3C05_c, DIG5S3C00_c, DIG5S3C02_c, DIG5S3C01_c, 
        DIG5S3C29_c, DIG5S3C28_c, DIG5S3C27_c, ANL_S3C_SLOTOK_c_3, ANL_S3C_SLOTOK_c_2, 
        ANL_S3C_SLOTOK_c_1, ANL_S3C_P54_Legacy_c, DIGS3C_SlotD_SlotOE_c_5, 
        DIGS3C_SlotD_SlotOE_c_4, DIGS3C_SlotD_SlotOE_c_3, DIGS3C_SlotD_SlotOE_c_2, 
        DIGS3C_SlotD_SlotOE_c_1, Carrier_PwrOn_c, PG_VIN_c, PPn_VIN_c, 
        PG_Module_c, TDnSHDN_c, TDnFFnFS_c, TDnALERT_c, S3C_S1_c;
    wire [24:0]counter;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(113[9:16])
    wire [3:0]next_state;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(119[12:22])
    wire [31:0]\debounce_counters[1] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(126[12:29])
    wire [31:0]\debounce_counters[2] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(126[12:29])
    wire [31:0]\debounce_counters[3] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(126[12:29])
    wire [31:0]\debounce_counters[4] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(126[12:29])
    wire [6:1]button_inputs_asyn1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(128[12:31])
    wire [6:1]button_inputs_asyn2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(129[9:28])
    wire [6:1]pushed;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(130[9:15])
    wire [6:1]buttons_debounced_syn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(131[12:33])
    
    wire forceoutputdisable, n27, clk_enable_24, n4086, n100_adj_2, 
        clk_enable_163, n66, clk_enable_19, n3584, n2491, n2489, 
        n2487, n98_adj_3, n82, n83, n84, n85, n86, n87, n88, 
        n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, 
        n99, n100, n101, n102, n103, n104, n105, n106, n107, 
        n108, n109, n110, n111, n112, n113, clk_enable_169, n3376, 
        n3375, n3374, n3362, n3361, n3360, n3359, n3358, pushed_1__N_190, 
        n188, n189, n190, n191, n192, n193, n194, n195, n196, 
        n197, n198, n199, n200, n201, n202, n203, n204, n205, 
        n206, n207, n208, n209, n210, n211, n212, n213, n214, 
        n215, n216, n217, n218, n219, n3357, n2994, n3356, n3355, 
        n94_adj_4, n3373, n3354, n3372, n3371, n3963, n3353, n3370, 
        n3369, n3352, n3351, n3017, n3368, n3350, pushed_2__N_188, 
        n294, n295, n296, n297, n298, n299, n300, n301, n302, 
        n303, n304, n305, n306, n307, n308, n309, n310, n311, 
        n312, n313, n314, n315, n316, n317, n318, n319, n320, 
        n321, n322, n323, n324, n325, n3367, n3349, n3348, n3347, 
        n3366, n3346, n3345, n3344, n3343, n3342, n3341, n3939, 
        n3365, n3364, n3340, n3363, n3381, n3338, n90_adj_5, n3379, 
        n3337, n3336, n3335, n3334, n89_adj_6, n3380, n3333, pushed_3__N_186, 
        n400, n401, n402, n403, n404, n405, n406, n407, n408, 
        n409, n410, n411, n412, n413, n414, n415, n416, n417, 
        n418, n419, n420, n421, n422, n423, n424, n425, n426, 
        n427, n428, n429, n430, n431, n3332, n3547, n3331, n2859, 
        n3330, n3378, n3329, n3328, n3327, n3326, n3325, n3324, 
        n3323, n3322, n3321, n3320, n3319, n3318, n3317, n3316, 
        n3315, n3314, n3313, n3312, n3311, n3310, n3309, n3308, 
        pushed_4__N_184, n2691, n86_adj_7, clk_enable_16, n48, n4, 
        n3, n3962, clk_enable_35, n3307, n3607, n2301, n1903, 
        n1902, n3961, clk_enable_33, n3668, n33, n1804, n3306, 
        n3305, n1797, n3598, n3304, n3930, n1899, n1893, n1892, 
        n1891, n1889, n1888, n1887, n3949;
    wire [3:0]next_state_3__N_339;
    
    wire n3303, n3923, n3302, n3301, n3300, n2482, n2484, n1862, 
        n2492, n2494, n2496, n3447, n3741;
    wire [3:0]next_state_3__N_343;
    
    wire n1203, n1204, n1205, n1206, n1207, n1208, n1209, n1210, 
        n1211, n1212, n1213, n1214, n1215, n1216, n1217, n1218, 
        n1219, n1220, n1221, n1222, n1223, n1224, n1225, n1226, 
        n1227, n3299, n3298, n3297, n3296, n3295, n3294, forceoutputdisable_N_3, 
        FlexMIOs53_GPIO_PowerDown_N_505, FP_SysLEDr_N_489, FP_SysLEDb_N_490, 
        FP_SysLEDg_N_488;
    wire [3:0]next_state_3__N_31;
    
    wire Carrier_PwrOn_N_508, FPIO_isoCtrlRSTn_N_491, n3293, n3292, 
        n3291, n3290, n3289, n3288, n3387, n3287, n3386, n3286, 
        n3385, n3384, Carrier_PG_1V8_N_575, n3285, Carrier_PG_1V8_N_579, 
        Carrier_PG_1V8_N_501, n3284, n3383, n3283, n3377, n3282, 
        n1946, n3623, n2686, n3281, n3280, n1950, n29, n3279, 
        n3390, n2680, n3278, n3277, n60, n3276, n78, n3641, 
        n3275, n3921, n3274, clk_enable_34, n3642, n3929, clk_enable_171, 
        n3427, clk_enable_83, n2480, n3389, n3273, n3272, n3271, 
        n3927, n3270, n3269, clk_enable_36, n38, n4_adj_8, n3268, 
        n7, n74, clk_enable_167, clk_enable_121, n73, n126, n3388, 
        n3937, n3950, clk_enable_166, clk_enable_162, clk_enable_81, 
        clk_enable_115, n3267, n3382, n3463, n3948, clk_enable_44, 
        n124, n3266, n28, n3265, n3947, n28_adj_9, n46, n3935, 
        n70, n30, n122, n2425, n43, n3746, n32, n120, n118, 
        n3943, n35, n3934, n116, n3925, n3744, n3924, n3602, 
        n3942, clk_enable_82, n23, n114, n113_adj_10, n112_adj_11, 
        n3743, n3933, n110_adj_12, n3742, n108_adj_13, n3932, n3442, 
        n42, n3591, n3599, n27_adj_14, n3264, n3946, n3263, n106_adj_15, 
        n105_adj_16, n40, n37, n104_adj_17, n3936, n3940, n3931, 
        clk_enable_22;
    
    VHI i2 (.Z(VCC_net));
    LUT4 i30_2_lut (.A(PG_VIN_c), .B(ANL_S3C_SLOTOK_c_1), .Z(n94_adj_4)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i30_2_lut.init = 16'h8888;
    LUT4 mux_303_Mux_2_i3_3_lut_4_lut (.A(next_state_3__N_343[2]), .B(next_state[0]), 
         .C(next_state[1]), .D(n3924), .Z(n3)) /* synthesis lut_function=(!(A (B ((D)+!C)+!B (C (D)))+!A ((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam mux_303_Mux_2_i3_3_lut_4_lut.init = 16'h02f2;
    LUT4 i9_2_lut (.A(FlexMIOs54_c), .B(FlexMIOs63_c), .Z(n73)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i9_2_lut.init = 16'h8888;
    LUT4 i52_4_lut (.A(DIG5S3C01_c), .B(n104_adj_17), .C(n78), .D(DIG5S3C02_c), 
         .Z(n116)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i52_4_lut.init = 16'h8000;
    LUT4 i2_2_lut_3_lut (.A(next_state_3__N_343[2]), .B(next_state[0]), 
         .C(n3924), .Z(n3427)) /* synthesis lut_function=(!((B+(C))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i2_2_lut_3_lut.init = 16'h0202;
    FD1P3IX debounce_counters_4___i25 (.D(n406), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i25.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn2_i1 (.D(button_inputs_asyn1[1]), .CK(clk), 
            .Q(button_inputs_asyn2[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam button_inputs_asyn2_i1.GSR = "ENABLED";
    LUT4 i1285_2_lut_3_lut (.A(next_state[2]), .B(next_state[3]), .C(next_state[1]), 
         .Z(FPIO_isoCtrlRSTn_N_491)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1285_2_lut_3_lut.init = 16'h1010;
    CCU2D add_1466_26 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3375), .S1(clk_enable_36));
    defparam add_1466_26.INIT0 = 16'hf555;
    defparam add_1466_26.INIT1 = 16'h0000;
    defparam add_1466_26.INJECT1_0 = "NO";
    defparam add_1466_26.INJECT1_1 = "NO";
    LUT4 i775_3_lut_3_lut (.A(next_state[1]), .B(n29), .C(n1219), .Z(n2482)) /* synthesis lut_function=(A (B (C))+!A ((C)+!B)) */ ;
    defparam i775_3_lut_3_lut.init = 16'hd1d1;
    LUT4 i38_4_lut (.A(SCL_c), .B(DIGS3C_SlotD_SlotOK_c_1), .C(SD1_CD_c), 
         .D(DIGS3C_SlotD_SlotOK_c_5), .Z(n102_adj_1)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i38_4_lut.init = 16'h8000;
    CCU2D add_92_11 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3299), .COUT(n3300), .S0(n316), 
          .S1(n315));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_11.INIT0 = 16'h5aaa;
    defparam add_92_11.INIT1 = 16'h5aaa;
    defparam add_92_11.INJECT1_0 = "NO";
    defparam add_92_11.INJECT1_1 = "NO";
    LUT4 i10_2_lut (.A(PG_Module_c), .B(S3CsI2C_SDA_c), .Z(n74)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i10_2_lut.init = 16'h8888;
    LUT4 i1295_2_lut_3_lut_4_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(next_state[1]), .D(next_state[0]), .Z(Carrier_PG_1V8_N_579)) /* synthesis lut_function=(A+(B+!(C (D)+!C !(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1295_2_lut_3_lut_4_lut.init = 16'heffe;
    CCU2D add_74_7 (.A0(\debounce_counters[1] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3265), .COUT(n3266), .S0(n108), 
          .S1(n107));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_7.INIT0 = 16'h5aaa;
    defparam add_74_7.INIT1 = 16'h5aaa;
    defparam add_74_7.INJECT1_0 = "NO";
    defparam add_74_7.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i24 (.D(n407), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i23 (.D(n408), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i23.GSR = "ENABLED";
    LUT4 i785_3_lut_3_lut (.A(next_state[1]), .B(n29), .C(n1209), .Z(n2492)) /* synthesis lut_function=(A (B (C))+!A ((C)+!B)) */ ;
    defparam i785_3_lut_3_lut.init = 16'hd1d1;
    FD1S3AY buttons_debounced_syn_4__256 (.D(pushed_4__N_184), .CK(clk), 
            .Q(buttons_debounced_syn[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam buttons_debounced_syn_4__256.GSR = "ENABLED";
    FD1S3AY buttons_debounced_syn_3__257 (.D(pushed_3__N_186), .CK(clk), 
            .Q(buttons_debounced_syn[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam buttons_debounced_syn_3__257.GSR = "ENABLED";
    FD1S3AY buttons_debounced_syn_2__258 (.D(pushed_2__N_188), .CK(clk), 
            .Q(buttons_debounced_syn[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam buttons_debounced_syn_2__258.GSR = "ENABLED";
    FD1S3AY buttons_debounced_syn_1__259 (.D(pushed_1__N_190), .CK(clk), 
            .Q(next_state_3__N_343[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam buttons_debounced_syn_1__259.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i22 (.D(n409), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i22.GSR = "ENABLED";
    LUT4 i40_4_lut (.A(DIG5S3C28_c), .B(FPIO_FlexMIO29_c), .C(FPIO_FlexMIO28_c), 
         .D(FPIO_iosCtrlINTn_c), .Z(n104_adj_17)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i40_4_lut.init = 16'h8000;
    LUT4 i2_2_lut_rep_50 (.A(next_state[2]), .B(next_state[0]), .Z(n3927)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i2_2_lut_rep_50.init = 16'h2222;
    LUT4 i14_2_lut (.A(DIG5S3C25_c), .B(DIG5S3C27_c), .Z(n78)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i14_2_lut.init = 16'h8888;
    CCU2D add_83_9 (.A0(\debounce_counters[2] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3282), .COUT(n3283), .S0(n212), 
          .S1(n211));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_9.INIT0 = 16'h5aaa;
    defparam add_83_9.INIT1 = 16'h5aaa;
    defparam add_83_9.INJECT1_0 = "NO";
    defparam add_83_9.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i21 (.D(n410), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i21.GSR = "ENABLED";
    FD1P3IX counter_i0_i10 (.D(n3463), .SP(clk_enable_171), .CD(n2691), 
            .CK(clk), .Q(counter[10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i20 (.D(n411), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i20.GSR = "ENABLED";
    CCU2D add_92_9 (.A0(\debounce_counters[3] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3298), .COUT(n3299), .S0(n318), 
          .S1(n317));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_9.INIT0 = 16'h5aaa;
    defparam add_92_9.INIT1 = 16'h5aaa;
    defparam add_92_9.INJECT1_0 = "NO";
    defparam add_92_9.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i7 (.D(n1220), .SP(clk_enable_171), .CD(n2686), 
            .CK(clk), .Q(counter[7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i7.GSR = "ENABLED";
    CCU2D add_1466_24 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3374), .COUT(n3375));
    defparam add_1466_24.INIT0 = 16'h5555;
    defparam add_1466_24.INIT1 = 16'h5555;
    defparam add_1466_24.INJECT1_0 = "NO";
    defparam add_1466_24.INJECT1_1 = "NO";
    LUT4 n3745_bdd_3_lut_4_lut (.A(next_state[0]), .B(next_state[1]), .C(next_state[2]), 
         .D(n3744), .Z(n3746)) /* synthesis lut_function=(A (B ((D)+!C)+!B (C (D)))+!A (C (D))) */ ;
    defparam n3745_bdd_3_lut_4_lut.init = 16'hf808;
    LUT4 i1236_4_lut_4_lut (.A(next_state[1]), .B(n29), .C(n1210), .D(n1946), 
         .Z(n2491)) /* synthesis lut_function=(A (B (C+(D))+!B (D))+!A ((C+(D))+!B)) */ ;
    defparam i1236_4_lut_4_lut.init = 16'hffd1;
    LUT4 i11_4_lut (.A(next_state[0]), .B(n3932), .C(next_state[3]), .D(n3584), 
         .Z(n3547)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(119[12:22])
    defparam i11_4_lut.init = 16'h353f;
    FD1P3IX debounce_counters_4___i19 (.D(n412), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i19.GSR = "ENABLED";
    LUT4 i12_1_lut_rep_58 (.A(next_state[3]), .Z(n3935)) /* synthesis lut_function=(!(A)) */ ;
    defparam i12_1_lut_rep_58.init = 16'h5555;
    FD1P3IX debounce_counters_4___i18 (.D(n413), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i18.GSR = "ENABLED";
    FD1P3IX counter_i0_i5 (.D(n1222), .SP(clk_enable_171), .CD(n2686), 
            .CK(clk), .Q(counter[5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i5.GSR = "ENABLED";
    CCU2D add_1466_22 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3373), .COUT(n3374));
    defparam add_1466_22.INIT0 = 16'h5555;
    defparam add_1466_22.INIT1 = 16'h5555;
    defparam add_1466_22.INJECT1_0 = "NO";
    defparam add_1466_22.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i14 (.D(n1804), .SP(clk_enable_171), .CD(n2994), 
            .CK(clk), .Q(counter[14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i14.GSR = "ENABLED";
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk)) /* synthesis NOM_FREQ="2.08", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "2.08";
    FD1P3IX debounce_counters_2___i0 (.D(n219), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i0.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i17 (.D(n414), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i16 (.D(n415), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i16.GSR = "ENABLED";
    LUT4 i36_4_lut (.A(FlexMIOs27_c), .B(FlexMIOs33_c), .C(FlexMIOs31_c), 
         .D(FlexMIOs34_c), .Z(n100_adj_2)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i36_4_lut.init = 16'h8000;
    CCU2D add_92_31 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3309), .COUT(n3310), .S0(n296), 
          .S1(n295));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_31.INIT0 = 16'h5aaa;
    defparam add_92_31.INIT1 = 16'h5aaa;
    defparam add_92_31.INJECT1_0 = "NO";
    defparam add_92_31.INJECT1_1 = "NO";
    LUT4 i6_2_lut (.A(FP_UsrSW2_c), .B(FlexIO03_c), .Z(n70)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i6_2_lut.init = 16'h8888;
    LUT4 i1_4_lut_4_lut (.A(next_state[3]), .B(n62), .C(n3427), .D(n3925), 
         .Z(n44)) /* synthesis lut_function=(!(A (D)+!A !(B+(C+!(D))))) */ ;
    defparam i1_4_lut_4_lut.init = 16'h54ff;
    FD1P3AX FlexMIOs53_GPIO_PowerDown_262 (.D(FlexMIOs53_GPIO_PowerDown_N_505), 
            .SP(clk_enable_16), .CK(clk), .Q(FlexMIOs53_GPIO_PowerDown_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam FlexMIOs53_GPIO_PowerDown_262.GSR = "ENABLED";
    FD1P3AX FP_SysLEDr_263 (.D(FP_SysLEDr_N_489), .SP(clk_enable_19), .CK(clk), 
            .Q(FP_SysLEDr_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam FP_SysLEDr_263.GSR = "ENABLED";
    FD1P3AX FP_SysLEDb_264 (.D(FP_SysLEDb_N_490), .SP(clk_enable_19), .CK(clk), 
            .Q(FP_SysLEDb_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam FP_SysLEDb_264.GSR = "ENABLED";
    FD1P3AX FP_SysLEDg_265 (.D(FP_SysLEDg_N_488), .SP(clk_enable_19), .CK(clk), 
            .Q(FP_SysLEDg_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam FP_SysLEDg_265.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i0 (.D(n113), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i0.GSR = "ENABLED";
    FD1P3AX Carrier_PwrOn_267 (.D(Carrier_PwrOn_N_508), .SP(clk_enable_22), 
            .CK(clk), .Q(Carrier_PwrOn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam Carrier_PwrOn_267.GSR = "ENABLED";
    FD1P3AX Carrier_PG_3V3_268 (.D(Carrier_PwrOn_N_508), .SP(clk_enable_22), 
            .CK(clk), .Q(Carrier_PG_3V3_c)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam Carrier_PG_3V3_268.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i15 (.D(n416), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i15.GSR = "ENABLED";
    FD1P3AX FP_SysLEDs_272 (.D(n3935), .SP(clk_enable_24), .CK(clk), .Q(FP_SysLEDs_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam FP_SysLEDs_272.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn1_i1 (.D(SysSW_Pwr_NC_c), .CK(clk), .Q(button_inputs_asyn1[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam button_inputs_asyn1_i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i14 (.D(n417), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i13 (.D(n418), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i12 (.D(n419), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i11 (.D(n420), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i26 (.D(n405), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i10 (.D(n421), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i10.GSR = "ENABLED";
    LUT4 i44_4_lut (.A(ANL_S3C_SLOTOK_c_3), .B(DIGS3C_SlotD_SlotOK_c_4), 
         .C(DIGS3C_SlotD_SlotOK_c_3), .D(DIG5S3C00_c), .Z(n108_adj_13)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i44_4_lut.init = 16'h8000;
    LUT4 i1304_2_lut (.A(n1213), .B(n1946), .Z(n1804)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1304_2_lut.init = 16'heeee;
    LUT4 i22_2_lut (.A(ANL_S3C_P54_Legacy_c), .B(ANL_S3C_SLOTOK_c_2), .Z(n86_adj_7)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i22_2_lut.init = 16'h8888;
    LUT4 mux_446_i19_4_lut_4_lut (.A(next_state[3]), .B(n1946), .C(n1950), 
         .D(n2492), .Z(n1893)) /* synthesis lut_function=(!(A (B (C)+!B (C+!(D)))+!A !(B+(C+(D))))) */ ;
    defparam mux_446_i19_4_lut_4_lut.init = 16'h5f5c;
    FD1P3IX debounce_counters_4___i9 (.D(n422), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i9.GSR = "ENABLED";
    LUT4 mux_446_i23_4_lut_4_lut (.A(next_state[3]), .B(n3921), .C(n1950), 
         .D(n1205), .Z(n1889)) /* synthesis lut_function=(!(A (B+(C+!(D)))+!A !(B (C)+!B (C+(D))))) */ ;
    defparam mux_446_i23_4_lut_4_lut.init = 16'h5350;
    LUT4 mux_303_Mux_2_i15_3_lut (.A(n3), .B(next_state[2]), .C(next_state[3]), 
         .Z(Carrier_PG_1V8_N_575)) /* synthesis lut_function=(A (B (C)+!B !(C))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam mux_303_Mux_2_i15_3_lut.init = 16'hc2c2;
    LUT4 mux_446_i9_4_lut_4_lut (.A(next_state[3]), .B(n1946), .C(n1950), 
         .D(n2482), .Z(n1903)) /* synthesis lut_function=(!(A (B+(C+!(D)))+!A !(B (C)+!B (C+(D))))) */ ;
    defparam mux_446_i9_4_lut_4_lut.init = 16'h5350;
    LUT4 i61_then_4_lut (.A(next_state[1]), .B(next_state[3]), .C(n3924), 
         .D(next_state_3__N_343[2]), .Z(n3947)) /* synthesis lut_function=(!(A ((D)+!B)+!A !(B (C)+!B !(D)))) */ ;
    defparam i61_then_4_lut.init = 16'h40d9;
    CCU2D add_74_5 (.A0(\debounce_counters[1] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3264), .COUT(n3265), .S0(n110), 
          .S1(n109));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_5.INIT0 = 16'h5aaa;
    defparam add_74_5.INIT1 = 16'h5aaa;
    defparam add_74_5.INJECT1_0 = "NO";
    defparam add_74_5.INJECT1_1 = "NO";
    CCU2D add_74_3 (.A0(\debounce_counters[1] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3263), .COUT(n3264), .S0(n112), 
          .S1(n111));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_3.INIT0 = 16'h5aaa;
    defparam add_74_3.INIT1 = 16'h5aaa;
    defparam add_74_3.INJECT1_0 = "NO";
    defparam add_74_3.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i8 (.D(n423), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i8.GSR = "ENABLED";
    CCU2D add_74_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[1] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n3263), .S1(n113));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_1.INIT0 = 16'hF000;
    defparam add_74_1.INIT1 = 16'h5555;
    defparam add_74_1.INJECT1_0 = "NO";
    defparam add_74_1.INJECT1_1 = "NO";
    IB DIG5S3C25_pad (.I(DIG5S3C25), .O(DIG5S3C25_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(57[3:12])
    FD1P3AX i242_273 (.D(Carrier_PG_1V8_N_579), .SP(Carrier_PG_1V8_N_575), 
            .CK(clk), .Q(Carrier_PG_1V8_N_501));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam i242_273.GSR = "ENABLED";
    OB FP_SysLEDg_pad (.I(FP_SysLEDg_c), .O(FP_SysLEDg));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(12[3:13])
    IB DIG5S3C24_pad (.I(DIG5S3C24), .O(DIG5S3C24_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(58[3:12])
    CCU2D add_1466_20 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3372), .COUT(n3373));
    defparam add_1466_20.INIT0 = 16'h5555;
    defparam add_1466_20.INIT1 = 16'h5555;
    defparam add_1466_20.INJECT1_0 = "NO";
    defparam add_1466_20.INJECT1_1 = "NO";
    IB DIGS3C_SlotD_ReqOE_pad_4 (.I(DIGS3C_SlotD_ReqOE[4]), .O(DIGS3C_SlotD_ReqOE_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(52[3:21])
    FD1P3AX next_state_i0 (.D(next_state_3__N_31[0]), .SP(clk_enable_33), 
            .CK(clk), .Q(next_state[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam next_state_i0.GSR = "ENABLED";
    LUT4 i61_else_4_lut (.A(buttons_debounced_syn[4]), .B(next_state[1]), 
         .C(next_state[3]), .D(next_state_3__N_343[2]), .Z(n3946)) /* synthesis lut_function=(A (B (C (D))+!B (C+(D)))+!A (B (C (D))+!B !(C+!(D)))) */ ;
    defparam i61_else_4_lut.init = 16'he320;
    LUT4 mux_446_i25_4_lut_4_lut (.A(next_state[3]), .B(n3921), .C(n1950), 
         .D(n1203), .Z(n1887)) /* synthesis lut_function=(!(A (B+(C+!(D)))+!A !(B (C)+!B (C+(D))))) */ ;
    defparam mux_446_i25_4_lut_4_lut.init = 16'h5350;
    IB DIGS3C_SlotD_ReqOE_pad_5 (.I(DIGS3C_SlotD_ReqOE[5]), .O(DIGS3C_SlotD_ReqOE_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(52[3:21])
    IB SPI_S3C_nCS_USR_pad (.I(SPI_S3C_nCS_USR), .O(SPI_S3C_nCS_USR_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(43[3:18])
    IB SD0_CD_pad (.I(SD0_CD), .O(SD0_CD_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(42[3:9])
    LUT4 mux_446_i10_4_lut_4_lut (.A(next_state[3]), .B(n1946), .C(n1950), 
         .D(n2484), .Z(n1902)) /* synthesis lut_function=(!(A (B (C)+!B (C+!(D)))+!A !(B+(C+(D))))) */ ;
    defparam mux_446_i10_4_lut_4_lut.init = 16'h5f5c;
    LUT4 mux_446_i20_4_lut_4_lut (.A(next_state[3]), .B(n1946), .C(n1950), 
         .D(n2494), .Z(n1892)) /* synthesis lut_function=(!(A (B (C)+!B (C+!(D)))+!A !(B+(C+(D))))) */ ;
    defparam mux_446_i20_4_lut_4_lut.init = 16'h5f5c;
    LUT4 i18_4_lut (.A(counter[0]), .B(counter[14]), .C(counter[10]), 
         .D(counter[19]), .Z(n43)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i18_4_lut.init = 16'hfffe;
    FD1P3IX pushed_2__254 (.D(n4086), .SP(clk_enable_34), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(pushed[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam pushed_2__254.GSR = "ENABLED";
    IB SD1_CD_pad (.I(SD1_CD), .O(SD1_CD_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(41[3:9])
    LUT4 i48_4_lut_4_lut_4_lut (.A(next_state[3]), .B(n2425), .C(n30), 
         .D(next_state[2]), .Z(clk_enable_121)) /* synthesis lut_function=(!(A (C)+!A (B (C+!(D))+!B (C (D))))) */ ;
    defparam i48_4_lut_4_lut_4_lut.init = 16'h0f1b;
    IB S3CsI2C_SCL_pad (.I(S3CsI2C_SCL), .O(S3CsI2C_SCL_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(39[3:14])
    IB S3CsI2C_SDA_pad (.I(S3CsI2C_SDA), .O(S3CsI2C_SDA_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(38[3:14])
    FD1P3IX pushed_1__255 (.D(n4086), .SP(clk_enable_35), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(pushed[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam pushed_1__255.GSR = "ENABLED";
    FD1P3IX pushed_3__253 (.D(n4086), .SP(clk_enable_36), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(pushed[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam pushed_3__253.GSR = "ENABLED";
    IB FPIO_FlexMIO29_pad (.I(FPIO_FlexMIO29), .O(FPIO_FlexMIO29_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(34[3:17])
    IB FPIO_FlexMIO30_pad (.I(FPIO_FlexMIO30), .O(FPIO_FlexMIO30_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(33[3:17])
    FD1P3IX debounce_counters_4___i7 (.D(n424), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i7.GSR = "ENABLED";
    IB FPIO_FlexMIO27_pad (.I(FPIO_FlexMIO27), .O(FPIO_FlexMIO27_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(32[3:17])
    IB FPIO_FlexMIO28_pad (.I(FPIO_FlexMIO28), .O(FPIO_FlexMIO28_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(31[3:17])
    IB FlexMio61ExternalStop_c_pad (.I(FPIO_ExternalStop), .O(FlexMio61ExternalStop_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(30[3:20])
    IB FPIO_iosCtrlINTn_pad (.I(FPIO_iosCtrlINTn), .O(FPIO_iosCtrlINTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(28[3:19])
    IB SysSW_Pwr_NC_pad (.I(SysSW_Pwr_NC), .O(SysSW_Pwr_NC_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(26[3:15])
    IB FP_UsrSW3_pad (.I(FP_UsrSW3), .O(FP_UsrSW3_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(25[3:12])
    IB SDA_pad (.I(SDA), .O(SDA_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(24[3:6])
    IB SCL_pad (.I(SCL), .O(SCL_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(23[3:6])
    IB FP_UsrSW2_pad (.I(FP_UsrSW2), .O(FP_UsrSW2_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(21[3:12])
    IB FP_UsrSW1_pad (.I(FP_UsrSW1), .O(FP_UsrSW1_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(20[3:12])
    IB FlexIO03_pad (.I(FlexIO03), .O(FlexIO03_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(17[3:11])
    IB FlexIO04_pad (.I(FlexIO04), .O(FlexIO04_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(16[3:11])
    OB Carrier_PwrOn_pad (.I(Carrier_PwrOn_c), .O(Carrier_PwrOn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(99[9:22])
    OB DIGS3C_SlotD_SlotOE_pad_1 (.I(DIGS3C_SlotD_SlotOE_c_1), .O(DIGS3C_SlotD_SlotOE[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(96[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_2 (.I(DIGS3C_SlotD_SlotOE_c_2), .O(DIGS3C_SlotD_SlotOE[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(96[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_3 (.I(DIGS3C_SlotD_SlotOE_c_3), .O(DIGS3C_SlotD_SlotOE[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(96[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_4 (.I(DIGS3C_SlotD_SlotOE_c_4), .O(DIGS3C_SlotD_SlotOE[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(96[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_5 (.I(DIGS3C_SlotD_SlotOE_c_5), .O(DIGS3C_SlotD_SlotOE[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(96[3:22])
    OB ANL_S3C_CarrierReady_pad (.I(GND_net), .O(ANL_S3C_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(94[3:23])
    OB FlexMio61ExternalStop_pad (.I(FlexMio61ExternalStop_c_c), .O(FlexMio61ExternalStop));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(65[3:24])
    OB FlexMIOs53_GPIO_PowerDown_pad (.I(FlexMIOs53_GPIO_PowerDown_c), .O(FlexMIOs53_GPIO_PowerDown));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(63[3:28])
    OB SD_SEL_pad (.I(GND_net), .O(SD_SEL));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(59[3:9])
    OB DIGS3C_Shared_ReqSafeState_pad (.I(DIGS3C_Shared_ReqSafeState_c), .O(DIGS3C_Shared_ReqSafeState));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(51[3:29])
    OB DIGS3C_Shared_CarrierReady_pad (.I(GND_net), .O(DIGS3C_Shared_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(50[3:29])
    OB FP_UsrLED_pad_1 (.I(GND_net), .O(FP_UsrLED[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(45[3:12])
    OB FP_UsrLED_pad_2 (.I(GND_net), .O(FP_UsrLED[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(45[3:12])
    OB FP_UsrLED_pad_3 (.I(GND_net), .O(FP_UsrLED[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(45[3:12])
    OB FP_UsrLED_pad_4 (.I(GND_net), .O(FP_UsrLED[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(45[3:12])
    OB FP_SysLEDs_pad (.I(FP_SysLEDs_c), .O(FP_SysLEDs));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(40[3:13])
    OBZ n2300_pad (.I(GND_net), .T(n2301), .O(Carrier_PG_1V8));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(241[1] 411[13])
    LUT4 i571_2_lut (.A(clk_enable_35), .B(button_inputs_asyn2[1]), .Z(clk_enable_115)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i571_2_lut.init = 16'hdddd;
    LUT4 mux_446_i13_4_lut_4_lut (.A(next_state[3]), .B(n3921), .C(n1950), 
         .D(n1215), .Z(n1899)) /* synthesis lut_function=(!(A (B (C)+!B (C+!(D)))+!A !(B+(C+(D))))) */ ;
    defparam mux_446_i13_4_lut_4_lut.init = 16'h5f5c;
    OB FPIO_FlexMIO52_pad (.I(FPIO_FlexMIO52_c_c), .O(FPIO_FlexMIO52));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(35[3:17])
    OB Carrier_PG_3V3_pad (.I(Carrier_PG_3V3_c), .O(Carrier_PG_3V3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(29[3:17])
    OB FPIO_isoCtrlRSTn_pad (.I(FPIO_isoCtrlRSTn_c), .O(FPIO_isoCtrlRSTn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(27[3:19])
    OB FlexIO01_pad (.I(GND_net), .O(FlexIO01));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(19[3:11])
    OB FlexIO02_pad (.I(GND_net), .O(FlexIO02));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(18[3:11])
    OB FlexIO05_pad (.I(GND_net), .O(FlexIO05));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(15[3:11])
    OB FP_SysLEDb_pad (.I(FP_SysLEDb_c), .O(FP_SysLEDb));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(14[3:13])
    OB FP_SysLEDr_pad (.I(FP_SysLEDr_c), .O(FP_SysLEDr));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(13[3:13])
    LUT4 mux_446_i24_4_lut_4_lut (.A(next_state[3]), .B(n3921), .C(n1950), 
         .D(n1204), .Z(n1888)) /* synthesis lut_function=(!(A (B+(C+!(D)))+!A !(B (C)+!B (C+(D))))) */ ;
    defparam mux_446_i24_4_lut_4_lut.init = 16'h5350;
    LUT4 mux_446_i21_4_lut_4_lut (.A(next_state[3]), .B(n1946), .C(n1950), 
         .D(n2496), .Z(n1891)) /* synthesis lut_function=(!(A (B (C)+!B (C+!(D)))+!A !(B+(C+(D))))) */ ;
    defparam mux_446_i21_4_lut_4_lut.init = 16'h5f5c;
    LUT4 i1754_4_lut (.A(n33), .B(next_state[2]), .C(n3923), .D(n3948), 
         .Z(clk_enable_33)) /* synthesis lut_function=(!(A (B (C)+!B (C+(D)))+!A !(B+!(D)))) */ ;
    defparam i1754_4_lut.init = 16'h4c5f;
    LUT4 n3739_bdd_3_lut_then_4_lut (.A(next_state[3]), .B(n3924), .C(next_state[2]), 
         .D(next_state[1]), .Z(n3950)) /* synthesis lut_function=(A (C+(D))+!A (B (C (D))+!B (D))) */ ;
    defparam n3739_bdd_3_lut_then_4_lut.init = 16'hfba0;
    LUT4 n3739_bdd_3_lut_else_4_lut (.A(next_state[3]), .B(next_state_3__N_343[2]), 
         .C(next_state[2]), .D(next_state[1]), .Z(n3949)) /* synthesis lut_function=(A (C)+!A !((C+(D))+!B)) */ ;
    defparam n3739_bdd_3_lut_else_4_lut.init = 16'ha0a4;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut (.A(DIGS3C_SlotD_ReqOE_c_1), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_1)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(200[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut.init = 16'h2222;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut (.A(DIGS3C_SlotD_ReqOE_c_2), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_2)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(200[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut.init = 16'h2222;
    FD1P3IX debounce_counters_4___i6 (.D(n425), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i5 (.D(n426), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i4 (.D(n427), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i3 (.D(n428), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i2 (.D(n429), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i1 (.D(n430), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i1.GSR = "ENABLED";
    FD1P3IX pushed_4__252 (.D(n4086), .SP(clk_enable_44), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(pushed[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam pushed_4__252.GSR = "ENABLED";
    CCU2D add_92_29 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3308), .COUT(n3309), .S0(n298), 
          .S1(n297));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_29.INIT0 = 16'h5aaa;
    defparam add_92_29.INIT1 = 16'h5aaa;
    defparam add_92_29.INJECT1_0 = "NO";
    defparam add_92_29.INJECT1_1 = "NO";
    CCU2D add_1466_18 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3371), .COUT(n3372));
    defparam add_1466_18.INIT0 = 16'h5555;
    defparam add_1466_18.INIT1 = 16'h5555;
    defparam add_1466_18.INJECT1_0 = "NO";
    defparam add_1466_18.INJECT1_1 = "NO";
    CCU2D add_1466_16 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3370), .COUT(n3371));
    defparam add_1466_16.INIT0 = 16'h5555;
    defparam add_1466_16.INIT1 = 16'h5555;
    defparam add_1466_16.INJECT1_0 = "NO";
    defparam add_1466_16.INJECT1_1 = "NO";
    CCU2D add_1466_14 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3369), .COUT(n3370));
    defparam add_1466_14.INIT0 = 16'h5555;
    defparam add_1466_14.INIT1 = 16'h5555;
    defparam add_1466_14.INJECT1_0 = "NO";
    defparam add_1466_14.INJECT1_1 = "NO";
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut (.A(DIGS3C_SlotD_ReqOE_c_3), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_3)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(200[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut.init = 16'h2222;
    LUT4 n1357_bdd_2_lut_1927 (.A(n3962), .B(n3924), .Z(n3963)) /* synthesis lut_function=(A+!(B)) */ ;
    defparam n1357_bdd_2_lut_1927.init = 16'hbbbb;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut (.A(DIGS3C_SlotD_ReqOE_c_4), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_4)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(200[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut.init = 16'h2222;
    CCU2D add_92_7 (.A0(\debounce_counters[3] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3297), .COUT(n3298), .S0(n320), 
          .S1(n319));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_7.INIT0 = 16'h5aaa;
    defparam add_92_7.INIT1 = 16'h5aaa;
    defparam add_92_7.INJECT1_0 = "NO";
    defparam add_92_7.INJECT1_1 = "NO";
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut (.A(DIGS3C_SlotD_ReqOE_c_5), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_5)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(200[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut.init = 16'h2222;
    IB DIG5S3C26_pad (.I(DIG5S3C26), .O(DIG5S3C26_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(56[3:12])
    IB FlexLIO_pad_0 (.I(FlexLIO[0]), .O(FlexLIO_c_0));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(54[3:10])
    IB FlexLIO_pad_1 (.I(FlexLIO[1]), .O(FlexLIO_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(54[3:10])
    IB FlexLIO_pad_2 (.I(FlexLIO[2]), .O(FlexLIO_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(54[3:10])
    IB FlexLIO_pad_3 (.I(FlexLIO[3]), .O(FlexLIO_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(54[3:10])
    IB FlexLIO_pad_4 (.I(FlexLIO[4]), .O(FlexLIO_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(54[3:10])
    IB FlexLIO_pad_5 (.I(FlexLIO[5]), .O(FlexLIO_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(54[3:10])
    IB DIGS3C_SlotD_SlotOK_pad_1 (.I(DIGS3C_SlotD_SlotOK[1]), .O(DIGS3C_SlotD_SlotOK_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(53[3:22])
    CCU2D add_1466_12 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3368), .COUT(n3369));
    defparam add_1466_12.INIT0 = 16'h5555;
    defparam add_1466_12.INIT1 = 16'h5555;
    defparam add_1466_12.INJECT1_0 = "NO";
    defparam add_1466_12.INJECT1_1 = "NO";
    IB DIGS3C_SlotD_SlotOK_pad_2 (.I(DIGS3C_SlotD_SlotOK[2]), .O(DIGS3C_SlotD_SlotOK_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(53[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_3 (.I(DIGS3C_SlotD_SlotOK[3]), .O(DIGS3C_SlotD_SlotOK_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(53[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_4 (.I(DIGS3C_SlotD_SlotOK[4]), .O(DIGS3C_SlotD_SlotOK_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(53[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_5 (.I(DIGS3C_SlotD_SlotOK[5]), .O(DIGS3C_SlotD_SlotOK_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(53[3:22])
    IB DIGS3C_SlotD_ReqOE_pad_1 (.I(DIGS3C_SlotD_ReqOE[1]), .O(DIGS3C_SlotD_ReqOE_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(52[3:21])
    LUT4 i594_1_lut (.A(Carrier_PG_1V8_N_501), .Z(n2301)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(241[1] 411[13])
    defparam i594_1_lut.init = 16'h5555;
    FD1P3IX debounce_counters_3___i0 (.D(n325), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i0.GSR = "ENABLED";
    CCU2D add_1466_10 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3367), .COUT(n3368));
    defparam add_1466_10.INIT0 = 16'h5555;
    defparam add_1466_10.INIT1 = 16'h5555;
    defparam add_1466_10.INJECT1_0 = "NO";
    defparam add_1466_10.INJECT1_1 = "NO";
    IB DIGS3C_SlotD_ReqOE_pad_2 (.I(DIGS3C_SlotD_ReqOE[2]), .O(DIGS3C_SlotD_ReqOE_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(52[3:21])
    LUT4 i573_2_lut (.A(clk_enable_36), .B(button_inputs_asyn2[3]), .Z(clk_enable_162)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i573_2_lut.init = 16'hdddd;
    FD1P3IX debounce_counters_4___i27 (.D(n404), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i27.GSR = "ENABLED";
    IB DIGS3C_SlotD_ReqOE_pad_3 (.I(DIGS3C_SlotD_ReqOE[3]), .O(DIGS3C_SlotD_ReqOE_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(52[3:21])
    IB FPIO_FlexMIO52_c_pad (.I(FlexMIOs52_PCIe), .O(FPIO_FlexMIO52_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(62[3:18])
    IB FlexMIOs54_pad (.I(FlexMIOs54), .O(FlexMIOs54_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(64[3:13])
    IB FlexMIOs62_pad (.I(FlexMIOs62), .O(FlexMIOs62_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(66[3:13])
    IB FlexMIOs63_pad (.I(FlexMIOs63), .O(FlexMIOs63_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(67[3:13])
    IB FlexMIOs31_pad (.I(FlexMIOs31), .O(FlexMIOs31_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(68[3:13])
    IB FlexMIOs30_pad (.I(FlexMIOs30), .O(FlexMIOs30_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(69[3:13])
    IB FlexMIOs29_pad (.I(FlexMIOs29), .O(FlexMIOs29_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(70[3:13])
    IB FlexMIOs28_pad (.I(FlexMIOs28), .O(FlexMIOs28_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(71[3:13])
    IB FlexMIOs27_pad (.I(FlexMIOs27), .O(FlexMIOs27_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(72[3:13])
    IB FlexMIOs26_pad (.I(FlexMIOs26), .O(FlexMIOs26_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(73[3:13])
    IB FlexMIOs45_pad (.I(FlexMIOs45), .O(FlexMIOs45_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(74[3:13])
    IB FlexMIOs37_pad (.I(FlexMIOs37), .O(FlexMIOs37_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[3:13])
    IB FlexMIOs36_pad (.I(FlexMIOs36), .O(FlexMIOs36_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(76[3:13])
    IB FlexMIOs35_pad (.I(FlexMIOs35), .O(FlexMIOs35_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(77[3:13])
    IB FlexMIOs34_pad (.I(FlexMIOs34), .O(FlexMIOs34_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(78[3:13])
    IB FlexMIOs33_pad (.I(FlexMIOs33), .O(FlexMIOs33_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(79[3:13])
    IB FlexMIOs32_pad (.I(FlexMIOs32), .O(FlexMIOs32_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(80[3:13])
    IB DIG5S3C03_pad (.I(DIG5S3C03), .O(DIG5S3C03_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(82[3:12])
    IB DIG5S3C04_pad (.I(DIG5S3C04), .O(DIG5S3C04_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(83[3:12])
    IB DIG5S3C05_pad (.I(DIG5S3C05), .O(DIG5S3C05_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(84[3:12])
    IB DIG5S3C00_pad (.I(DIG5S3C00), .O(DIG5S3C00_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(85[3:12])
    IB DIG5S3C02_pad (.I(DIG5S3C02), .O(DIG5S3C02_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(86[3:12])
    IB DIG5S3C01_pad (.I(DIG5S3C01), .O(DIG5S3C01_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(87[3:12])
    IB DIG5S3C29_pad (.I(DIG5S3C29), .O(DIG5S3C29_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(88[3:12])
    IB DIG5S3C28_pad (.I(DIG5S3C28), .O(DIG5S3C28_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(89[3:12])
    IB DIG5S3C27_pad (.I(DIG5S3C27), .O(DIG5S3C27_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(90[3:12])
    IB ANL_S3C_SLOTOK_pad_3 (.I(ANL_S3C_SLOTOK[3]), .O(ANL_S3C_SLOTOK_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(93[3:17])
    IB ANL_S3C_SLOTOK_pad_2 (.I(ANL_S3C_SLOTOK[2]), .O(ANL_S3C_SLOTOK_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(93[3:17])
    IB ANL_S3C_SLOTOK_pad_1 (.I(ANL_S3C_SLOTOK[1]), .O(ANL_S3C_SLOTOK_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(93[3:17])
    IB ANL_S3C_P54_Legacy_pad (.I(ANL_S3C_P54_Legacy), .O(ANL_S3C_P54_Legacy_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(95[3:21])
    IB PG_VIN_pad (.I(PG_VIN), .O(PG_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(100[3:9])
    IB PPn_VIN_pad (.I(PPn_VIN), .O(PPn_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(101[3:10])
    IB PG_Module_pad (.I(PG_Module), .O(PG_Module_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(102[3:12])
    IB TDnSHDN_pad (.I(TDnSHDN), .O(TDnSHDN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(103[3:10])
    IB TDnFFnFS_pad (.I(TDnFFnFS), .O(TDnFFnFS_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(104[3:11])
    IB TDnALERT_pad (.I(TDnALERT), .O(TDnALERT_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(105[3:11])
    IB S3C_S1_pad (.I(S3C_S1), .O(S3C_S1_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(106[3:9])
    FD1P3IX debounce_counters_4___i28 (.D(n403), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i29 (.D(n402), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i30 (.D(n401), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i31 (.D(n400), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i31.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn2_i2 (.D(button_inputs_asyn1[2]), .CK(clk), 
            .Q(button_inputs_asyn2[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam button_inputs_asyn2_i2.GSR = "ENABLED";
    CCU2D add_1466_8 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3366), .COUT(n3367));
    defparam add_1466_8.INIT0 = 16'h5555;
    defparam add_1466_8.INIT1 = 16'h5aaa;
    defparam add_1466_8.INJECT1_0 = "NO";
    defparam add_1466_8.INJECT1_1 = "NO";
    LUT4 next_state_1__bdd_4_lut_1920 (.A(next_state[1]), .B(next_state[2]), 
         .C(next_state[0]), .D(next_state[3]), .Z(clk_enable_19)) /* synthesis lut_function=(A+(B (C+(D))+!B !(C (D)))) */ ;
    defparam next_state_1__bdd_4_lut_1920.init = 16'heffb;
    CCU2D add_1466_6 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3365), .COUT(n3366));
    defparam add_1466_6.INIT0 = 16'h5555;
    defparam add_1466_6.INIT1 = 16'h5aaa;
    defparam add_1466_6.INJECT1_0 = "NO";
    defparam add_1466_6.INJECT1_1 = "NO";
    LUT4 i1_2_lut (.A(next_state[0]), .B(buttons_debounced_syn[2]), .Z(n4_adj_8)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1_2_lut.init = 16'h8888;
    LUT4 i1260_4_lut (.A(buttons_debounced_syn[3]), .B(buttons_debounced_syn[2]), 
         .C(next_state[1]), .D(next_state_3__N_343[2]), .Z(next_state_3__N_339[1])) /* synthesis lut_function=(A ((C (D))+!B)+!A !(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(328[17] 336[12])
    defparam i1260_4_lut.init = 16'hb333;
    CCU2D add_92_5 (.A0(\debounce_counters[3] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3296), .COUT(n3297), .S0(n322), 
          .S1(n321));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_5.INIT0 = 16'h5aaa;
    defparam add_92_5.INIT1 = 16'h5aaa;
    defparam add_92_5.INJECT1_0 = "NO";
    defparam add_92_5.INJECT1_1 = "NO";
    LUT4 i971_2_lut_3_lut_4_lut_4_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(next_state[1]), .D(next_state[0]), .Z(n2680)) /* synthesis lut_function=(A (B)+!A !((C+(D))+!B)) */ ;
    defparam i971_2_lut_3_lut_4_lut_4_lut.init = 16'h888c;
    LUT4 i1776_2_lut_4_lut (.A(n1946), .B(n1950), .C(n29), .D(clk_enable_171), 
         .Z(n2994)) /* synthesis lut_function=(A (B (D))+!A (B (D)+!B !(C+!(D)))) */ ;
    defparam i1776_2_lut_4_lut.init = 16'hcd00;
    CCU2D add_101_9 (.A0(\debounce_counters[4] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3314), .COUT(n3315), .S0(n424), 
          .S1(n423));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_9.INIT0 = 16'h5aaa;
    defparam add_101_9.INIT1 = 16'h5aaa;
    defparam add_101_9.INJECT1_0 = "NO";
    defparam add_101_9.INJECT1_1 = "NO";
    LUT4 pushed_2__I_0_1_lut (.A(pushed[2]), .Z(pushed_2__N_188)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(224[17] 228[24])
    defparam pushed_2__I_0_1_lut.init = 16'h5555;
    LUT4 i789_3_lut_3_lut (.A(next_state[1]), .B(n29), .C(n1207), .Z(n2496)) /* synthesis lut_function=(A (B (C))+!A ((C)+!B)) */ ;
    defparam i789_3_lut_3_lut.init = 16'hd1d1;
    LUT4 i1316_2_lut_3_lut (.A(n1946), .B(n29), .C(n1211), .Z(n1862)) /* synthesis lut_function=(A+((C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1316_2_lut_3_lut.init = 16'hfbfb;
    PFUMX i64 (.BLUT(n44), .ALUT(n41), .C0(next_state[1]), .Z(n60));
    LUT4 i2_3_lut (.A(next_state[3]), .B(next_state[0]), .C(next_state[2]), 
         .Z(Carrier_PwrOn_N_508)) /* synthesis lut_function=(!(A+((C)+!B))) */ ;
    defparam i2_3_lut.init = 16'h0404;
    LUT4 pushed_1__I_0_1_lut (.A(pushed[1]), .Z(pushed_1__N_190)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(224[17] 228[24])
    defparam pushed_1__I_0_1_lut.init = 16'h5555;
    FD1S3AY button_inputs_asyn2_i3 (.D(button_inputs_asyn1[3]), .CK(clk), 
            .Q(button_inputs_asyn2[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam button_inputs_asyn2_i3.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn2_i4 (.D(button_inputs_asyn1[4]), .CK(clk), 
            .Q(button_inputs_asyn2[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam button_inputs_asyn2_i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i1 (.D(n218), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i1.GSR = "ENABLED";
    LUT4 i12_3_lut_4_lut (.A(next_state[0]), .B(next_state[1]), .C(next_state[3]), 
         .D(next_state[2]), .Z(clk_enable_16)) /* synthesis lut_function=(A (C (D))+!A (B (C (D))+!B ((D)+!C))) */ ;
    defparam i12_3_lut_4_lut.init = 16'hf101;
    LUT4 FPIO_isoCtrlRSTn_N_493_bdd_3_lut_1785 (.A(n3924), .B(next_state[1]), 
         .C(next_state_3__N_339[2]), .Z(n3742)) /* synthesis lut_function=(A (B+(C))+!A !(B+!(C))) */ ;
    defparam FPIO_isoCtrlRSTn_N_493_bdd_3_lut_1785.init = 16'hb8b8;
    CCU2D add_1466_4 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3364), .COUT(n3365));
    defparam add_1466_4.INIT0 = 16'h5555;
    defparam add_1466_4.INIT1 = 16'h5555;
    defparam add_1466_4.INJECT1_0 = "NO";
    defparam add_1466_4.INJECT1_1 = "NO";
    LUT4 i1308_2_lut (.A(n1206), .B(n1946), .Z(n1797)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1308_2_lut.init = 16'heeee;
    LUT4 i1766_2_lut (.A(n3668), .B(n60), .Z(clk_enable_171)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1766_2_lut.init = 16'h2222;
    LUT4 i2_2_lut (.A(counter[17]), .B(counter[22]), .Z(n27)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2_2_lut.init = 16'heeee;
    LUT4 i21_4_lut (.A(counter[11]), .B(n42), .C(n32), .D(counter[20]), 
         .Z(n46)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i21_4_lut.init = 16'hfffe;
    LUT4 i1757_2_lut_rep_52 (.A(next_state_3__N_343[2]), .B(buttons_debounced_syn[3]), 
         .Z(n3929)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1757_2_lut_rep_52.init = 16'hbbbb;
    LUT4 i66_4_lut_4_lut (.A(next_state_3__N_343[2]), .B(buttons_debounced_syn[3]), 
         .C(n4_adj_8), .D(next_state[2]), .Z(n62)) /* synthesis lut_function=(A (C (D))+!A !(B (D)+!B !(C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i66_4_lut_4_lut.init = 16'hb055;
    LUT4 i1_2_lut_rep_53 (.A(next_state[3]), .B(next_state[2]), .Z(n3930)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam i1_2_lut_rep_53.init = 16'h2222;
    LUT4 i1_4_lut_else_4_lut (.A(n3924), .B(next_state[2]), .C(next_state[3]), 
         .D(next_state[1]), .Z(n3939)) /* synthesis lut_function=(!((B (C+(D))+!B (C+!(D)))+!A)) */ ;
    defparam i1_4_lut_else_4_lut.init = 16'h0208;
    LUT4 i1_4_lut_then_4_lut (.A(n3924), .B(next_state[2]), .C(next_state[3]), 
         .D(next_state[1]), .Z(n3940)) /* synthesis lut_function=(!((B (C+!(D))+!B (C (D)+!C !(D)))+!A)) */ ;
    defparam i1_4_lut_then_4_lut.init = 16'h0a20;
    LUT4 i2_2_lut_3_lut_3_lut_4_lut (.A(next_state_3__N_343[2]), .B(n3927), 
         .C(next_state[3]), .D(n3924), .Z(n3598)) /* synthesis lut_function=(!(A+((C+!(D))+!B))) */ ;
    defparam i2_2_lut_3_lut_3_lut_4_lut.init = 16'h0400;
    LUT4 i1245_2_lut_rep_48 (.A(next_state[2]), .B(next_state[0]), .Z(n3925)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1245_2_lut_rep_48.init = 16'heeee;
    FD1P3IX debounce_counters_2___i2 (.D(n217), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i3 (.D(n216), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i4 (.D(n215), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i5 (.D(n214), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i6 (.D(n213), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i7 (.D(n212), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i8 (.D(n211), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i9 (.D(n210), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i10 (.D(n209), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i11 (.D(n208), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i12 (.D(n207), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i13 (.D(n206), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i14 (.D(n205), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i15 (.D(n204), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i16 (.D(n203), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i17 (.D(n202), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i18 (.D(n201), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i19 (.D(n200), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i20 (.D(n199), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i21 (.D(n198), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i22 (.D(n197), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i23 (.D(n196), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i24 (.D(n195), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i25 (.D(n194), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i26 (.D(n193), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i27 (.D(n192), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i28 (.D(n191), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i29 (.D(n190), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i30 (.D(n189), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i31 (.D(n188), .SP(clk_enable_81), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_2___i31.GSR = "ENABLED";
    FD1P3AX next_state_i1 (.D(next_state_3__N_31[1]), .SP(clk_enable_82), 
            .CK(clk), .Q(next_state[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam next_state_i1.GSR = "ENABLED";
    CCU2D add_1466_2 (.A0(\debounce_counters[3] [7]), .B0(\debounce_counters[3] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[3] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n3364));
    defparam add_1466_2.INIT0 = 16'h1000;
    defparam add_1466_2.INIT1 = 16'h5aaa;
    defparam add_1466_2.INJECT1_0 = "NO";
    defparam add_1466_2.INJECT1_1 = "NO";
    LUT4 i1_4_lut (.A(buttons_debounced_syn[2]), .B(next_state[2]), .C(buttons_debounced_syn[3]), 
         .D(next_state_3__N_343[2]), .Z(next_state_3__N_339[2])) /* synthesis lut_function=((B (C)+!B !((D)+!C))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam i1_4_lut.init = 16'hd5f5;
    LUT4 i1471_3_lut_4_lut_4_lut (.A(n3924), .B(next_state_3__N_339[3]), 
         .C(next_state[0]), .D(next_state[3]), .Z(n3389)) /* synthesis lut_function=(A (B ((D)+!C)+!B (C (D)))+!A (B+(C))) */ ;
    defparam i1471_3_lut_4_lut_4_lut.init = 16'hfc5c;
    LUT4 next_state_0__bdd_4_lut_1923 (.A(next_state[0]), .B(next_state[2]), 
         .C(next_state_3__N_343[2]), .D(next_state[1]), .Z(n3962)) /* synthesis lut_function=(A (B+!(D))+!A (B (C+(D))+!B !(D))) */ ;
    defparam next_state_0__bdd_4_lut_1923.init = 16'hccfb;
    LUT4 i24_4_lut_rep_47 (.A(n43), .B(n48), .C(n37), .D(n38), .Z(n3924)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i24_4_lut_rep_47.init = 16'hfffe;
    CCU2D add_1467_26 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3363), .S1(clk_enable_34));
    defparam add_1467_26.INIT0 = 16'hf555;
    defparam add_1467_26.INIT1 = 16'h0000;
    defparam add_1467_26.INJECT1_0 = "NO";
    defparam add_1467_26.INJECT1_1 = "NO";
    LUT4 i1764_4_lut_4_lut (.A(next_state[3]), .B(next_state[2]), .C(n3599), 
         .D(n3924), .Z(n3668)) /* synthesis lut_function=(A (B+(D))+!A ((D)+!C)) */ ;
    defparam i1764_4_lut_4_lut.init = 16'hff8d;
    LUT4 i15_4_lut (.A(counter[15]), .B(counter[3]), .C(counter[1]), .D(counter[24]), 
         .Z(n40)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i15_4_lut.init = 16'hfffe;
    LUT4 i3_2_lut (.A(counter[23]), .B(counter[4]), .Z(n28)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i3_2_lut.init = 16'heeee;
    CCU2D add_1467_24 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3362), .COUT(n3363));
    defparam add_1467_24.INIT0 = 16'h5555;
    defparam add_1467_24.INIT1 = 16'h5555;
    defparam add_1467_24.INJECT1_0 = "NO";
    defparam add_1467_24.INJECT1_1 = "NO";
    PFUMX i47 (.BLUT(n3607), .ALUT(n28_adj_9), .C0(next_state[3]), .Z(n30));
    LUT4 i706_2_lut_rep_44 (.A(n1946), .B(n29), .Z(n3921)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i706_2_lut_rep_44.init = 16'hbbbb;
    LUT4 i17_4_lut (.A(counter[2]), .B(counter[13]), .C(counter[9]), .D(counter[18]), 
         .Z(n42)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i17_4_lut.init = 16'hfffe;
    LUT4 i981_3_lut_4_lut (.A(n1946), .B(n29), .C(n1950), .D(clk_enable_171), 
         .Z(n2686)) /* synthesis lut_function=(A (D)+!A (B (C (D))+!B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i981_3_lut_4_lut.init = 16'hfb00;
    LUT4 i1_4_lut_then_3_lut (.A(next_state[1]), .B(next_state[0]), .C(next_state[3]), 
         .Z(n3937)) /* synthesis lut_function=(A (B+(C))+!A (C)) */ ;
    defparam i1_4_lut_then_3_lut.init = 16'hf8f8;
    LUT4 i60_3_lut_4_lut_4_lut (.A(next_state_3__N_343[2]), .B(next_state[2]), 
         .C(next_state[0]), .D(next_state[1]), .Z(n33)) /* synthesis lut_function=(A (B (C (D))+!B (D))+!A (B (C (D)+!C !(D))+!B (D))) */ ;
    defparam i60_3_lut_4_lut_4_lut.init = 16'hf304;
    LUT4 i1235_4_lut (.A(next_state[1]), .B(n1946), .C(n1214), .D(n29), 
         .Z(n2489)) /* synthesis lut_function=(A (B+(C (D)))+!A (B+(C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1235_4_lut.init = 16'hfcdd;
    LUT4 next_state_0__bdd_4_lut_1909 (.A(next_state[0]), .B(next_state[2]), 
         .C(buttons_debounced_syn[4]), .D(next_state[1]), .Z(n3961)) /* synthesis lut_function=(A+(B+((D)+!C))) */ ;
    defparam next_state_0__bdd_4_lut_1909.init = 16'hffef;
    LUT4 i1234_4_lut (.A(next_state[1]), .B(n1946), .C(n1216), .D(n29), 
         .Z(n2487)) /* synthesis lut_function=(A (B+(C (D)))+!A (B+(C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1234_4_lut.init = 16'hfcdd;
    LUT4 i1_3_lut (.A(n1946), .B(n1217), .C(n29), .Z(n3463)) /* synthesis lut_function=(!(A+!(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1_3_lut.init = 16'h4545;
    LUT4 pushed_4__I_0_1_lut (.A(pushed[4]), .Z(pushed_4__N_184)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(224[17] 228[24])
    defparam pushed_4__I_0_1_lut.init = 16'h5555;
    FD1P3AX forceoutputdisable_260 (.D(forceoutputdisable_N_3), .SP(clk_enable_83), 
            .CK(clk), .Q(forceoutputdisable));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam forceoutputdisable_260.GSR = "ENABLED";
    LUT4 i63_4_lut (.A(n113_adj_10), .B(n126), .C(n122), .D(n114), .Z(dummy_signal)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i63_4_lut.init = 16'h8000;
    FD1P3IX counter_i0_i4 (.D(n1223), .SP(clk_enable_171), .CD(n2686), 
            .CK(clk), .Q(counter[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i4.GSR = "ENABLED";
    LUT4 i894_2_lut_rep_54 (.A(next_state[0]), .B(next_state[1]), .Z(n3931)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i894_2_lut_rep_54.init = 16'h6666;
    FD1P3IX debounce_counters_1___i1 (.D(n112), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i2 (.D(n111), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i3 (.D(n110), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i4 (.D(n109), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i5 (.D(n108), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i6 (.D(n107), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i7 (.D(n106), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i8 (.D(n105), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i9 (.D(n104), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i10 (.D(n103), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i11 (.D(n102), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i12 (.D(n101), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i13 (.D(n100), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i14 (.D(n99), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i15 (.D(n98), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i16 (.D(n97), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i17 (.D(n96), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i18 (.D(n95), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i19 (.D(n94), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i20 (.D(n93), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i21 (.D(n92), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i22 (.D(n91), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i23 (.D(n90), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i24 (.D(n89), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i25 (.D(n88), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i26 (.D(n87), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i27 (.D(n86), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i28 (.D(n85), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i29 (.D(n84), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i30 (.D(n83), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i31 (.D(n82), .SP(clk_enable_115), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_1___i31.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn1_i2 (.D(FlexMio61ExternalStop_c_c), .CK(clk), 
            .Q(button_inputs_asyn1[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam button_inputs_asyn1_i2.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn1_i3 (.D(FP_UsrSW3_c), .CK(clk), .Q(button_inputs_asyn1[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam button_inputs_asyn1_i3.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn1_i4 (.D(FP_UsrSW1_c), .CK(clk), .Q(button_inputs_asyn1[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam button_inputs_asyn1_i4.GSR = "ENABLED";
    LUT4 i7_2_lut (.A(counter[16]), .B(counter[21]), .Z(n32)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i7_2_lut.init = 16'heeee;
    LUT4 i49_4_lut (.A(TDnALERT_c), .B(n98_adj_3), .C(n66), .D(FlexIO04_c), 
         .Z(n113_adj_10)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i49_4_lut.init = 16'h8000;
    LUT4 i1_4_lut_adj_1 (.A(buttons_debounced_syn[2]), .B(next_state[3]), 
         .C(buttons_debounced_syn[3]), .D(next_state_3__N_343[2]), .Z(next_state_3__N_339[3])) /* synthesis lut_function=(A (B ((D)+!C)+!B !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam i1_4_lut_adj_1.init = 16'h8a0a;
    CCU2D add_1467_22 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3361), .COUT(n3362));
    defparam add_1467_22.INIT0 = 16'h5555;
    defparam add_1467_22.INIT1 = 16'h5555;
    defparam add_1467_22.INJECT1_0 = "NO";
    defparam add_1467_22.INJECT1_1 = "NO";
    LUT4 i3_4_lut (.A(next_state[2]), .B(n3931), .C(n3929), .D(n3591), 
         .Z(n1946)) /* synthesis lut_function=(!(((C+!(D))+!B)+!A)) */ ;
    defparam i3_4_lut.init = 16'h0800;
    LUT4 i572_2_lut (.A(clk_enable_34), .B(button_inputs_asyn2[2]), .Z(clk_enable_81)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i572_2_lut.init = 16'hdddd;
    LUT4 i62_4_lut (.A(n105_adj_16), .B(n124), .C(n118), .D(n106_adj_15), 
         .Z(n126)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i62_4_lut.init = 16'h8000;
    PFUMX i1723 (.BLUT(n2859), .ALUT(n3623), .C0(next_state[2]), .Z(n3642));
    LUT4 i58_4_lut (.A(n73), .B(n116), .C(n102_adj_1), .D(n74), .Z(n122)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i58_4_lut.init = 16'h8000;
    LUT4 i1751_2_lut_2_lut_3_lut_4_lut (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[2]), .D(next_state[3]), .Z(clk_enable_83)) /* synthesis lut_function=(A (B+(C+!(D)))+!A ((C+!(D))+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1751_2_lut_2_lut_3_lut_4_lut.init = 16'hf9ff;
    FD1P3IX counter_i0_i3 (.D(n1224), .SP(clk_enable_171), .CD(n2686), 
            .CK(clk), .Q(counter[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i3.GSR = "ENABLED";
    LUT4 i50_4_lut (.A(DIG5S3C29_c), .B(n100_adj_2), .C(n70), .D(FPIO_FlexMIO30_c), 
         .Z(n114)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i50_4_lut.init = 16'h8000;
    FD1P3IX counter_i0_i2 (.D(n1225), .SP(clk_enable_171), .CD(n2686), 
            .CK(clk), .Q(counter[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i2.GSR = "ENABLED";
    LUT4 i895_2_lut_rep_55 (.A(next_state[1]), .B(next_state[2]), .Z(n3932)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i895_2_lut_rep_55.init = 16'heeee;
    LUT4 i34_4_lut (.A(SD0_CD_c), .B(SPI_S3C_nCS_USR_c), .C(SDA_c), .D(DIG5S3C03_c), 
         .Z(n98_adj_3)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i34_4_lut.init = 16'h8000;
    LUT4 i11_4_lut_adj_2 (.A(next_state[2]), .B(n3602), .C(next_state[3]), 
         .D(n3390), .Z(next_state_3__N_31[3])) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i11_4_lut_adj_2.init = 16'hcac0;
    LUT4 i1330_2_lut_3_lut (.A(next_state[1]), .B(next_state[2]), .C(next_state[3]), 
         .Z(n2859)) /* synthesis lut_function=(!(A (C)+!A (B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1330_2_lut_3_lut.init = 16'h1f1f;
    LUT4 i1_2_lut_3_lut (.A(next_state[1]), .B(next_state[2]), .C(next_state[0]), 
         .Z(n3602)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1_2_lut_3_lut.init = 16'h1010;
    LUT4 i1_2_lut_rep_46 (.A(next_state[3]), .B(n3924), .Z(n3923)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i1_2_lut_rep_46.init = 16'h4444;
    LUT4 i1_4_lut_adj_3 (.A(n3591), .B(n3930), .C(n3927), .D(n3929), 
         .Z(n41)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1_4_lut_adj_3.init = 16'heccc;
    FD1P3IX counter_i0_i13 (.D(n2489), .SP(clk_enable_171), .CD(n2691), 
            .CK(clk), .Q(counter[13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i13.GSR = "ENABLED";
    LUT4 i2_2_lut_adj_4 (.A(FlexMIOs35_c), .B(S3C_S1_c), .Z(n66)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i2_2_lut_adj_4.init = 16'h8888;
    LUT4 i1748_3_lut_4_lut_4_lut (.A(next_state[1]), .B(next_state[2]), 
         .C(n23), .D(n35), .Z(clk_enable_82)) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B (C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1748_3_lut_4_lut_4_lut.init = 16'h00ef;
    FD1P3IX counter_i0_i11 (.D(n2487), .SP(clk_enable_171), .CD(n2691), 
            .CK(clk), .Q(counter[11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i11.GSR = "ENABLED";
    CCU2D add_92_3 (.A0(\debounce_counters[3] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3295), .COUT(n3296), .S0(n324), 
          .S1(n323));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_3.INIT0 = 16'h5aaa;
    defparam add_92_3.INIT1 = 16'h5aaa;
    defparam add_92_3.INJECT1_0 = "NO";
    defparam add_92_3.INJECT1_1 = "NO";
    LUT4 i983_2_lut_3_lut (.A(n3668), .B(n60), .C(n1950), .Z(n2691)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam i983_2_lut_3_lut.init = 16'h2020;
    LUT4 i23_4_lut (.A(n27), .B(n46), .C(n40), .D(n28), .Z(n48)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i23_4_lut.init = 16'hfffe;
    CCU2D add_1467_20 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3360), .COUT(n3361));
    defparam add_1467_20.INIT0 = 16'h5555;
    defparam add_1467_20.INIT1 = 16'h5555;
    defparam add_1467_20.INJECT1_0 = "NO";
    defparam add_1467_20.INJECT1_1 = "NO";
    LUT4 mux_303_Mux_12_i15_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), 
         .C(PPn_VIN_c), .D(next_state[3]), .Z(forceoutputdisable_N_3)) /* synthesis lut_function=(!(A (C+(D))+!A !(B+!(C (D))))) */ ;
    defparam mux_303_Mux_12_i15_4_lut_4_lut.init = 16'h455f;
    LUT4 i1779_2_lut_3_lut_4_lut_4_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(next_state[1]), .D(next_state[0]), .Z(clk_enable_169)) /* synthesis lut_function=(A+!(B (C+(D)))) */ ;
    defparam i1779_2_lut_3_lut_4_lut_4_lut.init = 16'hbbbf;
    PFUMX i1472 (.BLUT(n3388), .ALUT(n3389), .C0(next_state[1]), .Z(n3390));
    LUT4 i1254_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), .C(next_state[0]), 
         .D(n4), .Z(n7)) /* synthesis lut_function=((B (C)+!B !(C+(D)))+!A) */ ;
    defparam i1254_4_lut_4_lut.init = 16'hd5d7;
    LUT4 i41_4_lut (.A(FlexLIO_c_3), .B(FlexMIOs26_c), .C(FlexLIO_c_5), 
         .D(FlexMIOs29_c), .Z(n105_adj_16)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i41_4_lut.init = 16'h8000;
    CCU2D add_1467_18 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3359), .COUT(n3360));
    defparam add_1467_18.INIT0 = 16'h5555;
    defparam add_1467_18.INIT1 = 16'h5555;
    defparam add_1467_18.INJECT1_0 = "NO";
    defparam add_1467_18.INJECT1_1 = "NO";
    CCU2D add_1467_16 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3358), .COUT(n3359));
    defparam add_1467_16.INIT0 = 16'h5555;
    defparam add_1467_16.INIT1 = 16'h5555;
    defparam add_1467_16.INJECT1_0 = "NO";
    defparam add_1467_16.INJECT1_1 = "NO";
    LUT4 i2_3_lut_adj_5 (.A(n1950), .B(n2480), .C(n1946), .Z(n3442)) /* synthesis lut_function=(!(A+((C)+!B))) */ ;
    defparam i2_3_lut_adj_5.init = 16'h0404;
    LUT4 i1_2_lut_3_lut_4_lut (.A(next_state[3]), .B(n3924), .C(next_state[2]), 
         .D(next_state_3__N_343[2]), .Z(FlexMIOs53_GPIO_PowerDown_N_505)) /* synthesis lut_function=(!(A+(((D)+!C)+!B))) */ ;
    defparam i1_2_lut_3_lut_4_lut.init = 16'h0040;
    LUT4 m1_lut (.Z(n4086)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    FD1P3IX counter_i0_i1 (.D(n1226), .SP(clk_enable_171), .CD(n2686), 
            .CK(clk), .Q(counter[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i1.GSR = "ENABLED";
    LUT4 mux_303_Mux_7_i15_3_lut_4_lut_4_lut (.A(next_state[2]), .B(next_state[0]), 
         .C(next_state[1]), .D(next_state[3]), .Z(FP_SysLEDg_N_488)) /* synthesis lut_function=(!(A (D)+!A !(B+!(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam mux_303_Mux_7_i15_3_lut_4_lut_4_lut.init = 16'h45ee;
    LUT4 pushed_3__I_0_1_lut (.A(pushed[3]), .Z(pushed_3__N_186)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(224[17] 228[24])
    defparam pushed_3__I_0_1_lut.init = 16'h5555;
    LUT4 i1_4_lut_adj_6 (.A(next_state[2]), .B(next_state[3]), .C(buttons_debounced_syn[2]), 
         .D(n3931), .Z(n1950)) /* synthesis lut_function=(A (B+!(C+!(D)))) */ ;
    defparam i1_4_lut_adj_6.init = 16'h8a88;
    FD1P3AX next_state_i3 (.D(next_state_3__N_31[3]), .SP(clk_enable_121), 
            .CK(clk), .Q(next_state[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam next_state_i3.GSR = "ENABLED";
    LUT4 i60_4_lut (.A(n89_adj_6), .B(n120), .C(n110_adj_12), .D(n90_adj_5), 
         .Z(n124)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i60_4_lut.init = 16'h8000;
    CCU2D add_1467_14 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3357), .COUT(n3358));
    defparam add_1467_14.INIT0 = 16'h5555;
    defparam add_1467_14.INIT1 = 16'h5555;
    defparam add_1467_14.INJECT1_0 = "NO";
    defparam add_1467_14.INJECT1_1 = "NO";
    LUT4 i773_3_lut (.A(next_state[1]), .B(n1221), .C(n29), .Z(n2480)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i773_3_lut.init = 16'hcaca;
    LUT4 i1_4_lut_4_lut_adj_7 (.A(next_state[3]), .B(next_state[2]), .C(next_state[1]), 
         .D(next_state[0]), .Z(clk_enable_24)) /* synthesis lut_function=(A (B+(C (D)+!C !(D)))+!A (B (C+(D)))) */ ;
    defparam i1_4_lut_4_lut_adj_7.init = 16'hecca;
    LUT4 i1_4_lut_4_lut_adj_8 (.A(next_state[2]), .B(next_state[3]), .C(n3934), 
         .D(n3924), .Z(n27_adj_14)) /* synthesis lut_function=(!(A+!(B (C)+!B (D)))) */ ;
    defparam i1_4_lut_4_lut_adj_8.init = 16'h5140;
    LUT4 n2602_bdd_3_lut_1825_4_lut (.A(next_state[1]), .B(next_state[2]), 
         .C(next_state[0]), .D(buttons_debounced_syn[4]), .Z(n3741)) /* synthesis lut_function=(!(A+(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam n2602_bdd_3_lut_1825_4_lut.init = 16'h0001;
    LUT4 i787_3_lut_3_lut (.A(next_state[1]), .B(n29), .C(n1208), .Z(n2494)) /* synthesis lut_function=(A (B (C))+!A ((C)+!B)) */ ;
    defparam i787_3_lut_3_lut.init = 16'hd1d1;
    LUT4 next_state_3__bdd_4_lut_1904 (.A(next_state[3]), .B(next_state[1]), 
         .C(next_state[2]), .D(next_state[0]), .Z(FP_SysLEDb_N_490)) /* synthesis lut_function=(!(A (B (C+(D))+!B (C))+!A !(B ((D)+!C)))) */ ;
    defparam next_state_3__bdd_4_lut_1904.init = 16'h460e;
    CCU2D add_1467_12 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3356), .COUT(n3357));
    defparam add_1467_12.INIT0 = 16'h5555;
    defparam add_1467_12.INIT1 = 16'h5555;
    defparam add_1467_12.INJECT1_0 = "NO";
    defparam add_1467_12.INJECT1_1 = "NO";
    LUT4 i54_4_lut (.A(FlexMIOs62_c), .B(n108_adj_13), .C(n86_adj_7), 
         .D(S3CsI2C_SCL_c), .Z(n118)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i54_4_lut.init = 16'h8000;
    CCU2D add_92_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[3] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n3295), .S1(n325));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_1.INIT0 = 16'hF000;
    defparam add_92_1.INIT1 = 16'h5555;
    defparam add_92_1.INJECT1_0 = "NO";
    defparam add_92_1.INJECT1_1 = "NO";
    LUT4 i2_3_lut_4_lut_4_lut (.A(next_state_3__N_343[2]), .B(n3924), .C(next_state[1]), 
         .D(next_state[0]), .Z(n3607)) /* synthesis lut_function=(!(A+((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(119[12:22])
    defparam i2_3_lut_4_lut_4_lut.init = 16'h0004;
    CCU2D add_92_27 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3307), .COUT(n3308), .S0(n300), 
          .S1(n299));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_27.INIT0 = 16'h5aaa;
    defparam add_92_27.INIT1 = 16'h5aaa;
    defparam add_92_27.INJECT1_0 = "NO";
    defparam add_92_27.INJECT1_1 = "NO";
    CCU2D add_1467_10 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3355), .COUT(n3356));
    defparam add_1467_10.INIT0 = 16'h5555;
    defparam add_1467_10.INIT1 = 16'h5555;
    defparam add_1467_10.INJECT1_0 = "NO";
    defparam add_1467_10.INJECT1_1 = "NO";
    CCU2D add_83_33 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3294), .S0(n188));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_33.INIT0 = 16'h5aaa;
    defparam add_83_33.INIT1 = 16'h0000;
    defparam add_83_33.INJECT1_0 = "NO";
    defparam add_83_33.INJECT1_1 = "NO";
    LUT4 i1470_3_lut_3_lut (.A(next_state_3__N_343[2]), .B(next_state[0]), 
         .C(next_state_3__N_339[3]), .Z(n3388)) /* synthesis lut_function=(A (B (C))+!A ((C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(119[12:22])
    defparam i1470_3_lut_3_lut.init = 16'hd1d1;
    CCU2D add_1467_8 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3354), .COUT(n3355));
    defparam add_1467_8.INIT0 = 16'h5555;
    defparam add_1467_8.INIT1 = 16'h5aaa;
    defparam add_1467_8.INJECT1_0 = "NO";
    defparam add_1467_8.INJECT1_1 = "NO";
    CCU2D add_1467_6 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3353), .COUT(n3354));
    defparam add_1467_6.INIT0 = 16'h5555;
    defparam add_1467_6.INIT1 = 16'h5aaa;
    defparam add_1467_6.INJECT1_0 = "NO";
    defparam add_1467_6.INJECT1_1 = "NO";
    CCU2D add_92_25 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3306), .COUT(n3307), .S0(n302), 
          .S1(n301));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_25.INIT0 = 16'h5aaa;
    defparam add_92_25.INIT1 = 16'h5aaa;
    defparam add_92_25.INJECT1_0 = "NO";
    defparam add_92_25.INJECT1_1 = "NO";
    CCU2D add_92_23 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3305), .COUT(n3306), .S0(n304), 
          .S1(n303));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_23.INIT0 = 16'h5aaa;
    defparam add_92_23.INIT1 = 16'h5aaa;
    defparam add_92_23.INJECT1_0 = "NO";
    defparam add_92_23.INJECT1_1 = "NO";
    CCU2D add_92_21 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3304), .COUT(n3305), .S0(n306), 
          .S1(n305));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_21.INIT0 = 16'h5aaa;
    defparam add_92_21.INIT1 = 16'h5aaa;
    defparam add_92_21.INJECT1_0 = "NO";
    defparam add_92_21.INJECT1_1 = "NO";
    CCU2D add_74_9 (.A0(\debounce_counters[1] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3266), .COUT(n3267), .S0(n106), 
          .S1(n105));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_9.INIT0 = 16'h5aaa;
    defparam add_74_9.INIT1 = 16'h5aaa;
    defparam add_74_9.INJECT1_0 = "NO";
    defparam add_74_9.INJECT1_1 = "NO";
    CCU2D add_101_7 (.A0(\debounce_counters[4] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3313), .COUT(n3314), .S0(n426), 
          .S1(n425));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_7.INIT0 = 16'h5aaa;
    defparam add_101_7.INIT1 = 16'h5aaa;
    defparam add_101_7.INJECT1_0 = "NO";
    defparam add_101_7.INJECT1_1 = "NO";
    CCU2D add_1467_4 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3352), .COUT(n3353));
    defparam add_1467_4.INIT0 = 16'h5555;
    defparam add_1467_4.INIT1 = 16'h5555;
    defparam add_1467_4.INJECT1_0 = "NO";
    defparam add_1467_4.INJECT1_1 = "NO";
    CCU2D add_1467_2 (.A0(\debounce_counters[2] [7]), .B0(\debounce_counters[2] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[2] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n3352));
    defparam add_1467_2.INIT0 = 16'h1000;
    defparam add_1467_2.INIT1 = 16'h5aaa;
    defparam add_1467_2.INJECT1_0 = "NO";
    defparam add_1467_2.INJECT1_1 = "NO";
    LUT4 n3787_bdd_3_lut_then_4_lut (.A(next_state[3]), .B(next_state[1]), 
         .C(next_state[0]), .D(next_state_3__N_339[1]), .Z(n3943)) /* synthesis lut_function=(!(A+!(B (C+(D))+!B (C (D))))) */ ;
    defparam n3787_bdd_3_lut_then_4_lut.init = 16'h5440;
    CCU2D add_83_31 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3293), .COUT(n3294), .S0(n190), 
          .S1(n189));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_31.INIT0 = 16'h5aaa;
    defparam add_83_31.INIT1 = 16'h5aaa;
    defparam add_83_31.INJECT1_0 = "NO";
    defparam add_83_31.INJECT1_1 = "NO";
    CCU2D add_1468_26 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3351), .S1(clk_enable_35));
    defparam add_1468_26.INIT0 = 16'hf555;
    defparam add_1468_26.INIT1 = 16'h0000;
    defparam add_1468_26.INJECT1_0 = "NO";
    defparam add_1468_26.INJECT1_1 = "NO";
    CCU2D add_1468_24 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3350), .COUT(n3351));
    defparam add_1468_24.INIT0 = 16'h5555;
    defparam add_1468_24.INIT1 = 16'h5555;
    defparam add_1468_24.INJECT1_0 = "NO";
    defparam add_1468_24.INJECT1_1 = "NO";
    CCU2D add_83_7 (.A0(\debounce_counters[2] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3281), .COUT(n3282), .S0(n214), 
          .S1(n213));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_7.INIT0 = 16'h5aaa;
    defparam add_83_7.INIT1 = 16'h5aaa;
    defparam add_83_7.INJECT1_0 = "NO";
    defparam add_83_7.INJECT1_1 = "NO";
    CCU2D add_83_29 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3292), .COUT(n3293), .S0(n192), 
          .S1(n191));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_29.INIT0 = 16'h5aaa;
    defparam add_83_29.INIT1 = 16'h5aaa;
    defparam add_83_29.INJECT1_0 = "NO";
    defparam add_83_29.INJECT1_1 = "NO";
    CCU2D add_83_5 (.A0(\debounce_counters[2] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3280), .COUT(n3281), .S0(n216), 
          .S1(n215));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_5.INIT0 = 16'h5aaa;
    defparam add_83_5.INIT1 = 16'h5aaa;
    defparam add_83_5.INJECT1_0 = "NO";
    defparam add_83_5.INJECT1_1 = "NO";
    CCU2D add_1468_22 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3349), .COUT(n3350));
    defparam add_1468_22.INIT0 = 16'h5555;
    defparam add_1468_22.INIT1 = 16'h5555;
    defparam add_1468_22.INJECT1_0 = "NO";
    defparam add_1468_22.INJECT1_1 = "NO";
    LUT4 i42_4_lut (.A(FlexMIOs30_c), .B(FlexMIOs37_c), .C(FlexMIOs32_c), 
         .D(FlexMIOs45_c), .Z(n106_adj_15)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i42_4_lut.init = 16'h8000;
    LUT4 i1_2_lut_adj_9 (.A(next_state[3]), .B(buttons_debounced_syn[2]), 
         .Z(n3591)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1_2_lut_adj_9.init = 16'h4444;
    LUT4 i777_3_lut (.A(next_state[1]), .B(n1218), .C(n29), .Z(n2484)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i777_3_lut.init = 16'hcaca;
    LUT4 i1_2_lut_rep_56 (.A(buttons_debounced_syn[4]), .B(next_state[0]), 
         .Z(n3933)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam i1_2_lut_rep_56.init = 16'h2222;
    PFUMX i41 (.BLUT(n3598), .ALUT(n27_adj_14), .C0(next_state[1]), .Z(n35));
    LUT4 i1_2_lut_adj_10 (.A(next_state[0]), .B(next_state[1]), .Z(n3599)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1_2_lut_adj_10.init = 16'h8888;
    LUT4 i574_2_lut (.A(clk_enable_44), .B(button_inputs_asyn2[4]), .Z(clk_enable_166)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i574_2_lut.init = 16'hdddd;
    VLO i1 (.Z(GND_net));
    LUT4 i12_2_lut (.A(counter[7]), .B(counter[12]), .Z(n37)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i12_2_lut.init = 16'heeee;
    LUT4 i1_4_lut_4_lut_adj_11 (.A(next_state[2]), .B(next_state[0]), .C(next_state[1]), 
         .D(next_state[3]), .Z(FP_SysLEDr_N_489)) /* synthesis lut_function=(!(A (B+((D)+!C))+!A !(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1_4_lut_4_lut_adj_11.init = 16'h4575;
    PFUMX i1907 (.BLUT(n3949), .ALUT(n3950), .C0(next_state[0]), .Z(clk_enable_167));
    TSALL TSALL_INST (.TSALL(GND_net));
    CCU2D add_1468_20 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3348), .COUT(n3349));
    defparam add_1468_20.INIT0 = 16'h5555;
    defparam add_1468_20.INIT1 = 16'h5555;
    defparam add_1468_20.INJECT1_0 = "NO";
    defparam add_1468_20.INJECT1_1 = "NO";
    CCU2D add_83_3 (.A0(\debounce_counters[2] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3279), .COUT(n3280), .S0(n218), 
          .S1(n217));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_3.INIT0 = 16'h5aaa;
    defparam add_83_3.INIT1 = 16'h5aaa;
    defparam add_83_3.INJECT1_0 = "NO";
    defparam add_83_3.INJECT1_1 = "NO";
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    LUT4 i1704_4_lut (.A(next_state[0]), .B(n3932), .C(next_state[3]), 
         .D(buttons_debounced_syn[2]), .Z(n3623)) /* synthesis lut_function=(!(A (B+!(C))+!A (B (C+(D))+!B !(C+!(D))))) */ ;
    defparam i1704_4_lut.init = 16'h3035;
    LUT4 i13_3_lut (.A(counter[8]), .B(counter[5]), .C(counter[6]), .Z(n38)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i13_3_lut.init = 16'hfefe;
    CCU2D add_1468_18 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3347), .COUT(n3348));
    defparam add_1468_18.INIT0 = 16'h5555;
    defparam add_1468_18.INIT1 = 16'h5555;
    defparam add_1468_18.INJECT1_0 = "NO";
    defparam add_1468_18.INJECT1_1 = "NO";
    CCU2D add_83_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[2] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n3279), .S1(n219));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_1.INIT0 = 16'hF000;
    defparam add_83_1.INIT1 = 16'h5555;
    defparam add_83_1.INJECT1_0 = "NO";
    defparam add_83_1.INJECT1_1 = "NO";
    CCU2D add_92_19 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3303), .COUT(n3304), .S0(n308), 
          .S1(n307));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_19.INIT0 = 16'h5aaa;
    defparam add_92_19.INIT1 = 16'h5aaa;
    defparam add_92_19.INJECT1_0 = "NO";
    defparam add_92_19.INJECT1_1 = "NO";
    CCU2D add_101_5 (.A0(\debounce_counters[4] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3312), .COUT(n3313), .S0(n428), 
          .S1(n427));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_5.INIT0 = 16'h5aaa;
    defparam add_101_5.INIT1 = 16'h5aaa;
    defparam add_101_5.INJECT1_0 = "NO";
    defparam add_101_5.INJECT1_1 = "NO";
    CCU2D add_1468_16 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3346), .COUT(n3347));
    defparam add_1468_16.INIT0 = 16'h5555;
    defparam add_1468_16.INIT1 = 16'h5555;
    defparam add_1468_16.INJECT1_0 = "NO";
    defparam add_1468_16.INJECT1_1 = "NO";
    CCU2D add_74_33 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3278), .S0(n82));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_33.INIT0 = 16'h5aaa;
    defparam add_74_33.INIT1 = 16'h0000;
    defparam add_74_33.INJECT1_0 = "NO";
    defparam add_74_33.INJECT1_1 = "NO";
    CCU2D add_1468_14 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3345), .COUT(n3346));
    defparam add_1468_14.INIT0 = 16'h5555;
    defparam add_1468_14.INIT1 = 16'h5555;
    defparam add_1468_14.INJECT1_0 = "NO";
    defparam add_1468_14.INJECT1_1 = "NO";
    LUT4 i25_2_lut (.A(DIG5S3C05_c), .B(DIG5S3C24_c), .Z(n89_adj_6)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i25_2_lut.init = 16'h8888;
    L6MUX21 i1724 (.D0(n3641), .D1(n3642), .SD(next_state[1]), .Z(next_state_3__N_31[0]));
    LUT4 i56_4_lut (.A(FlexMIOs36_c), .B(n112_adj_11), .C(n94_adj_4), 
         .D(TDnSHDN_c), .Z(n120)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i56_4_lut.init = 16'h8000;
    PFUMX i1722 (.BLUT(n3017), .ALUT(n3547), .C0(next_state[2]), .Z(n3641));
    CCU2D add_1468_12 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3344), .COUT(n3345));
    defparam add_1468_12.INIT0 = 16'h5555;
    defparam add_1468_12.INIT1 = 16'h5555;
    defparam add_1468_12.INJECT1_0 = "NO";
    defparam add_1468_12.INJECT1_1 = "NO";
    LUT4 i46_4_lut (.A(FlexLIO_c_1), .B(FlexLIO_c_4), .C(FlexLIO_c_2), 
         .D(FlexMIOs28_c), .Z(n110_adj_12)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i46_4_lut.init = 16'h8000;
    LUT4 i1_4_lut_else_3_lut (.A(next_state_3__N_343[2]), .B(next_state[1]), 
         .C(next_state[0]), .D(next_state[3]), .Z(n3936)) /* synthesis lut_function=(A (B (C (D))+!B !(D))+!A (B (C (D)))) */ ;
    defparam i1_4_lut_else_3_lut.init = 16'hc022;
    LUT4 i44_4_lut_4_lut (.A(buttons_debounced_syn[4]), .B(next_state[0]), 
         .C(next_state_3__N_343[2]), .D(next_state[3]), .Z(n23)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+(D)))+!A (B (C+(D))+!B ((D)+!C)))) */ ;
    defparam i44_4_lut_4_lut.init = 16'h223c;
    LUT4 i69_2_lut_rep_57 (.A(next_state[0]), .B(next_state_3__N_343[2]), 
         .Z(n3934)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;
    defparam i69_2_lut_rep_57.init = 16'h6666;
    LUT4 i26_2_lut (.A(DIG5S3C26_c), .B(FPIO_FlexMIO27_c), .Z(n90_adj_5)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i26_2_lut.init = 16'h8888;
    LUT4 i48_4_lut (.A(DIGS3C_SlotD_SlotOK_c_2), .B(FlexLIO_c_0), .C(DIG5S3C04_c), 
         .D(TDnFFnFS_c), .Z(n112_adj_11)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 183[58])
    defparam i48_4_lut.init = 16'h8000;
    LUT4 FPIO_isoCtrlRSTn_N_493_bdd_3_lut_1800 (.A(next_state[1]), .B(next_state_3__N_339[2]), 
         .C(next_state_3__N_343[2]), .Z(n3743)) /* synthesis lut_function=(A (B)+!A (C)) */ ;
    defparam FPIO_isoCtrlRSTn_N_493_bdd_3_lut_1800.init = 16'hd8d8;
    PFUMX i1905 (.BLUT(n3946), .ALUT(n3947), .C0(next_state[0]), .Z(n3948));
    LUT4 i718_3_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_343[2]), 
         .C(next_state[1]), .D(n3924), .Z(n2425)) /* synthesis lut_function=(A (B (C (D))+!B ((D)+!C))+!A (B ((D)+!C)+!B (C (D)))) */ ;
    defparam i718_3_lut_4_lut.init = 16'hf606;
    LUT4 n3787_bdd_3_lut_else_4_lut (.A(n3924), .B(next_state[3]), .C(next_state[1]), 
         .D(next_state[0]), .Z(n3942)) /* synthesis lut_function=(!(A (B+(C (D)+!C !(D)))+!A (B (C+!(D))+!B (C (D)+!C !(D))))) */ ;
    defparam n3787_bdd_3_lut_else_4_lut.init = 16'h0730;
    LUT4 i1_2_lut_adj_12 (.A(next_state_3__N_343[2]), .B(n3924), .Z(n4)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_adj_12.init = 16'heeee;
    LUT4 i1_3_lut_adj_13 (.A(buttons_debounced_syn[2]), .B(next_state_3__N_343[2]), 
         .C(buttons_debounced_syn[3]), .Z(n3584)) /* synthesis lut_function=(!((B (C))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(119[12:22])
    defparam i1_3_lut_adj_13.init = 16'h2a2a;
    PFUMX i1910 (.BLUT(n3963), .ALUT(n3961), .C0(next_state[3]), .Z(clk_enable_163));
    LUT4 i1313_3_lut_4_lut (.A(next_state[1]), .B(next_state[2]), .C(next_state[3]), 
         .D(next_state[0]), .Z(n3017)) /* synthesis lut_function=(!(A (C+(D))+!A (B (C+(D))+!B !(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1313_3_lut_4_lut.init = 16'h101f;
    CCU2D add_1468_10 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3343), .COUT(n3344));
    defparam add_1468_10.INIT0 = 16'h5555;
    defparam add_1468_10.INIT1 = 16'h5555;
    defparam add_1468_10.INJECT1_0 = "NO";
    defparam add_1468_10.INJECT1_1 = "NO";
    CCU2D add_74_31 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3277), .COUT(n3278), .S0(n84), 
          .S1(n83));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_31.INIT0 = 16'h5aaa;
    defparam add_74_31.INIT1 = 16'h5aaa;
    defparam add_74_31.INJECT1_0 = "NO";
    defparam add_74_31.INJECT1_1 = "NO";
    CCU2D add_74_29 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3276), .COUT(n3277), .S0(n86), 
          .S1(n85));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_29.INIT0 = 16'h5aaa;
    defparam add_74_29.INIT1 = 16'h5aaa;
    defparam add_74_29.INJECT1_0 = "NO";
    defparam add_74_29.INJECT1_1 = "NO";
    CCU2D add_92_17 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3302), .COUT(n3303), .S0(n310), 
          .S1(n309));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_17.INIT0 = 16'h5aaa;
    defparam add_92_17.INIT1 = 16'h5aaa;
    defparam add_92_17.INJECT1_0 = "NO";
    defparam add_92_17.INJECT1_1 = "NO";
    CCU2D add_1468_8 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3342), .COUT(n3343));
    defparam add_1468_8.INIT0 = 16'h5555;
    defparam add_1468_8.INIT1 = 16'h5aaa;
    defparam add_1468_8.INJECT1_0 = "NO";
    defparam add_1468_8.INJECT1_1 = "NO";
    CCU2D add_1468_6 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3341), .COUT(n3342));
    defparam add_1468_6.INIT0 = 16'h5555;
    defparam add_1468_6.INIT1 = 16'h5aaa;
    defparam add_1468_6.INJECT1_0 = "NO";
    defparam add_1468_6.INJECT1_1 = "NO";
    CCU2D add_83_27 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3291), .COUT(n3292), .S0(n194), 
          .S1(n193));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_27.INIT0 = 16'h5aaa;
    defparam add_83_27.INIT1 = 16'h5aaa;
    defparam add_83_27.INJECT1_0 = "NO";
    defparam add_83_27.INJECT1_1 = "NO";
    CCU2D add_1468_4 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3340), .COUT(n3341));
    defparam add_1468_4.INIT0 = 16'h5555;
    defparam add_1468_4.INIT1 = 16'h5555;
    defparam add_1468_4.INJECT1_0 = "NO";
    defparam add_1468_4.INJECT1_1 = "NO";
    CCU2D add_1468_2 (.A0(\debounce_counters[1] [7]), .B0(\debounce_counters[1] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[1] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n3340));
    defparam add_1468_2.INIT0 = 16'h1000;
    defparam add_1468_2.INIT1 = 16'h5aaa;
    defparam add_1468_2.INJECT1_0 = "NO";
    defparam add_1468_2.INJECT1_1 = "NO";
    CCU2D add_302_25 (.A0(counter[23]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[24]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3338), .S0(n1204), .S1(n1203));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(391[17:24])
    defparam add_302_25.INIT0 = 16'h5555;
    defparam add_302_25.INIT1 = 16'h5555;
    defparam add_302_25.INJECT1_0 = "NO";
    defparam add_302_25.INJECT1_1 = "NO";
    CCU2D add_302_23 (.A0(counter[21]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[22]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3337), .COUT(n3338), .S0(n1206), .S1(n1205));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(391[17:24])
    defparam add_302_23.INIT0 = 16'h5555;
    defparam add_302_23.INIT1 = 16'h5555;
    defparam add_302_23.INJECT1_0 = "NO";
    defparam add_302_23.INJECT1_1 = "NO";
    PFUMX i1902 (.BLUT(n3942), .ALUT(n3943), .C0(next_state[2]), .Z(next_state_3__N_31[1]));
    LUT4 i1_3_lut_adj_14 (.A(n1946), .B(n1212), .C(n29), .Z(n3447)) /* synthesis lut_function=(!(A+!(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(244[9] 409[18])
    defparam i1_3_lut_adj_14.init = 16'h4545;
    CCU2D add_74_27 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3275), .COUT(n3276), .S0(n88), 
          .S1(n87));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_27.INIT0 = 16'h5aaa;
    defparam add_74_27.INIT1 = 16'h5aaa;
    defparam add_74_27.INJECT1_0 = "NO";
    defparam add_74_27.INJECT1_1 = "NO";
    CCU2D add_101_3 (.A0(\debounce_counters[4] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3311), .COUT(n3312), .S0(n430), 
          .S1(n429));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_3.INIT0 = 16'h5aaa;
    defparam add_101_3.INIT1 = 16'h5aaa;
    defparam add_101_3.INJECT1_0 = "NO";
    defparam add_101_3.INJECT1_1 = "NO";
    CCU2D add_74_25 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3274), .COUT(n3275), .S0(n90), 
          .S1(n89));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_25.INIT0 = 16'h5aaa;
    defparam add_74_25.INIT1 = 16'h5aaa;
    defparam add_74_25.INJECT1_0 = "NO";
    defparam add_74_25.INJECT1_1 = "NO";
    CCU2D add_74_23 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3273), .COUT(n3274), .S0(n92), 
          .S1(n91));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_23.INIT0 = 16'h5aaa;
    defparam add_74_23.INIT1 = 16'h5aaa;
    defparam add_74_23.INJECT1_0 = "NO";
    defparam add_74_23.INJECT1_1 = "NO";
    CCU2D add_74_21 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3272), .COUT(n3273), .S0(n94), 
          .S1(n93));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_21.INIT0 = 16'h5aaa;
    defparam add_74_21.INIT1 = 16'h5aaa;
    defparam add_74_21.INJECT1_0 = "NO";
    defparam add_74_21.INJECT1_1 = "NO";
    CCU2D add_83_25 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3290), .COUT(n3291), .S0(n196), 
          .S1(n195));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_25.INIT0 = 16'h5aaa;
    defparam add_83_25.INIT1 = 16'h5aaa;
    defparam add_83_25.INJECT1_0 = "NO";
    defparam add_83_25.INJECT1_1 = "NO";
    CCU2D add_302_21 (.A0(counter[19]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[20]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3336), .COUT(n3337), .S0(n1208), .S1(n1207));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(391[17:24])
    defparam add_302_21.INIT0 = 16'h5555;
    defparam add_302_21.INIT1 = 16'h5555;
    defparam add_302_21.INJECT1_0 = "NO";
    defparam add_302_21.INJECT1_1 = "NO";
    CCU2D add_101_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[4] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n3311), .S1(n431));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_1.INIT0 = 16'hF000;
    defparam add_101_1.INIT1 = 16'h5555;
    defparam add_101_1.INJECT1_0 = "NO";
    defparam add_101_1.INJECT1_1 = "NO";
    CCU2D add_74_19 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3271), .COUT(n3272), .S0(n96), 
          .S1(n95));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_19.INIT0 = 16'h5aaa;
    defparam add_74_19.INIT1 = 16'h5aaa;
    defparam add_74_19.INJECT1_0 = "NO";
    defparam add_74_19.INJECT1_1 = "NO";
    CCU2D add_74_17 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3270), .COUT(n3271), .S0(n98), 
          .S1(n97));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_17.INIT0 = 16'h5aaa;
    defparam add_74_17.INIT1 = 16'h5aaa;
    defparam add_74_17.INJECT1_0 = "NO";
    defparam add_74_17.INJECT1_1 = "NO";
    CCU2D add_74_15 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3269), .COUT(n3270), .S0(n100), 
          .S1(n99));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_15.INIT0 = 16'h5aaa;
    defparam add_74_15.INIT1 = 16'h5aaa;
    defparam add_74_15.INJECT1_0 = "NO";
    defparam add_74_15.INJECT1_1 = "NO";
    CCU2D add_302_19 (.A0(counter[17]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[18]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3335), .COUT(n3336), .S0(n1210), .S1(n1209));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(391[17:24])
    defparam add_302_19.INIT0 = 16'h5555;
    defparam add_302_19.INIT1 = 16'h5555;
    defparam add_302_19.INJECT1_0 = "NO";
    defparam add_302_19.INJECT1_1 = "NO";
    CCU2D add_302_17 (.A0(counter[15]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[16]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3334), .COUT(n3335), .S0(n1212), .S1(n1211));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(391[17:24])
    defparam add_302_17.INIT0 = 16'h5555;
    defparam add_302_17.INIT1 = 16'h5555;
    defparam add_302_17.INJECT1_0 = "NO";
    defparam add_302_17.INJECT1_1 = "NO";
    CCU2D add_302_15 (.A0(counter[13]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[14]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3333), .COUT(n3334), .S0(n1214), .S1(n1213));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(391[17:24])
    defparam add_302_15.INIT0 = 16'h5555;
    defparam add_302_15.INIT1 = 16'h5555;
    defparam add_302_15.INJECT1_0 = "NO";
    defparam add_302_15.INJECT1_1 = "NO";
    FD1P3AX counter_i0_i6 (.D(n3442), .SP(clk_enable_171), .CK(clk), .Q(counter[6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i6.GSR = "ENABLED";
    FD1P3AX counter_i0_i8 (.D(n1903), .SP(clk_enable_171), .CK(clk), .Q(counter[8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i8.GSR = "ENABLED";
    FD1P3AX counter_i0_i9 (.D(n1902), .SP(clk_enable_171), .CK(clk), .Q(counter[9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i9.GSR = "ENABLED";
    FD1P3AX counter_i0_i12 (.D(n1899), .SP(clk_enable_171), .CK(clk), 
            .Q(counter[12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i12.GSR = "ENABLED";
    FD1P3AX counter_i0_i18 (.D(n1893), .SP(clk_enable_171), .CK(clk), 
            .Q(counter[18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i18.GSR = "ENABLED";
    FD1P3AX counter_i0_i19 (.D(n1892), .SP(clk_enable_171), .CK(clk), 
            .Q(counter[19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i19.GSR = "ENABLED";
    FD1P3AX counter_i0_i20 (.D(n1891), .SP(clk_enable_171), .CK(clk), 
            .Q(counter[20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i20.GSR = "ENABLED";
    FD1P3AX counter_i0_i22 (.D(n1889), .SP(clk_enable_171), .CK(clk), 
            .Q(counter[22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i22.GSR = "ENABLED";
    FD1P3AX counter_i0_i23 (.D(n1888), .SP(clk_enable_171), .CK(clk), 
            .Q(counter[23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i23.GSR = "ENABLED";
    FD1P3AX counter_i0_i24 (.D(n1887), .SP(clk_enable_171), .CK(clk), 
            .Q(counter[24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i1 (.D(n324), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i1.GSR = "ENABLED";
    LUT4 i1_4_lut_4_lut_adj_15 (.A(next_state[2]), .B(next_state[1]), .C(n3934), 
         .D(n3933), .Z(n28_adj_9)) /* synthesis lut_function=(!(A+!(B (C)+!B (D)))) */ ;
    defparam i1_4_lut_4_lut_adj_15.init = 16'h5140;
    CCU2D add_1465_26 (.A0(\debounce_counters[4] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3387), .S1(clk_enable_44));
    defparam add_1465_26.INIT0 = 16'hf555;
    defparam add_1465_26.INIT1 = 16'h0000;
    defparam add_1465_26.INJECT1_0 = "NO";
    defparam add_1465_26.INJECT1_1 = "NO";
    CCU2D add_1465_24 (.A0(\debounce_counters[4] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3386), .COUT(n3387));
    defparam add_1465_24.INIT0 = 16'h5555;
    defparam add_1465_24.INIT1 = 16'h5555;
    defparam add_1465_24.INJECT1_0 = "NO";
    defparam add_1465_24.INJECT1_1 = "NO";
    CCU2D add_1465_22 (.A0(\debounce_counters[4] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3385), .COUT(n3386));
    defparam add_1465_22.INIT0 = 16'h5555;
    defparam add_1465_22.INIT1 = 16'h5555;
    defparam add_1465_22.INJECT1_0 = "NO";
    defparam add_1465_22.INJECT1_1 = "NO";
    CCU2D add_1465_20 (.A0(\debounce_counters[4] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3384), .COUT(n3385));
    defparam add_1465_20.INIT0 = 16'h5555;
    defparam add_1465_20.INIT1 = 16'h5555;
    defparam add_1465_20.INJECT1_0 = "NO";
    defparam add_1465_20.INJECT1_1 = "NO";
    CCU2D add_1465_18 (.A0(\debounce_counters[4] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3383), .COUT(n3384));
    defparam add_1465_18.INIT0 = 16'h5555;
    defparam add_1465_18.INIT1 = 16'h5555;
    defparam add_1465_18.INJECT1_0 = "NO";
    defparam add_1465_18.INJECT1_1 = "NO";
    CCU2D add_1465_16 (.A0(\debounce_counters[4] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3382), .COUT(n3383));
    defparam add_1465_16.INIT0 = 16'h5555;
    defparam add_1465_16.INIT1 = 16'h5555;
    defparam add_1465_16.INJECT1_0 = "NO";
    defparam add_1465_16.INJECT1_1 = "NO";
    CCU2D add_1465_14 (.A0(\debounce_counters[4] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3381), .COUT(n3382));
    defparam add_1465_14.INIT0 = 16'h5555;
    defparam add_1465_14.INIT1 = 16'h5555;
    defparam add_1465_14.INJECT1_0 = "NO";
    defparam add_1465_14.INJECT1_1 = "NO";
    CCU2D add_1465_12 (.A0(\debounce_counters[4] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3380), .COUT(n3381));
    defparam add_1465_12.INIT0 = 16'h5555;
    defparam add_1465_12.INIT1 = 16'h5555;
    defparam add_1465_12.INJECT1_0 = "NO";
    defparam add_1465_12.INJECT1_1 = "NO";
    CCU2D add_1465_10 (.A0(\debounce_counters[4] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3379), .COUT(n3380));
    defparam add_1465_10.INIT0 = 16'h5555;
    defparam add_1465_10.INIT1 = 16'h5555;
    defparam add_1465_10.INJECT1_0 = "NO";
    defparam add_1465_10.INJECT1_1 = "NO";
    CCU2D add_302_13 (.A0(counter[11]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[12]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3332), .COUT(n3333), .S0(n1216), .S1(n1215));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(391[17:24])
    defparam add_302_13.INIT0 = 16'h5555;
    defparam add_302_13.INIT1 = 16'h5555;
    defparam add_302_13.INJECT1_0 = "NO";
    defparam add_302_13.INJECT1_1 = "NO";
    CCU2D add_302_11 (.A0(counter[9]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[10]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3331), .COUT(n3332), .S0(n1218), .S1(n1217));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(391[17:24])
    defparam add_302_11.INIT0 = 16'h5555;
    defparam add_302_11.INIT1 = 16'h5555;
    defparam add_302_11.INJECT1_0 = "NO";
    defparam add_302_11.INJECT1_1 = "NO";
    CCU2D add_302_9 (.A0(counter[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[8]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3330), .COUT(n3331), .S0(n1220), .S1(n1219));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(391[17:24])
    defparam add_302_9.INIT0 = 16'h5555;
    defparam add_302_9.INIT1 = 16'h5555;
    defparam add_302_9.INJECT1_0 = "NO";
    defparam add_302_9.INJECT1_1 = "NO";
    CCU2D add_302_7 (.A0(counter[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3329), .COUT(n3330), .S0(n1222), .S1(n1221));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(391[17:24])
    defparam add_302_7.INIT0 = 16'h5555;
    defparam add_302_7.INIT1 = 16'h5555;
    defparam add_302_7.INJECT1_0 = "NO";
    defparam add_302_7.INJECT1_1 = "NO";
    CCU2D add_302_5 (.A0(counter[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3328), .COUT(n3329), .S0(n1224), .S1(n1223));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(391[17:24])
    defparam add_302_5.INIT0 = 16'h5555;
    defparam add_302_5.INIT1 = 16'h5555;
    defparam add_302_5.INJECT1_0 = "NO";
    defparam add_302_5.INJECT1_1 = "NO";
    CCU2D add_302_3 (.A0(counter[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3327), .COUT(n3328), .S0(n1226), .S1(n1225));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(391[17:24])
    defparam add_302_3.INIT0 = 16'h5555;
    defparam add_302_3.INIT1 = 16'h5555;
    defparam add_302_3.INJECT1_0 = "NO";
    defparam add_302_3.INJECT1_1 = "NO";
    CCU2D add_302_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n3327), .S1(n1227));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(391[17:24])
    defparam add_302_1.INIT0 = 16'hF000;
    defparam add_302_1.INIT1 = 16'h5555;
    defparam add_302_1.INJECT1_0 = "NO";
    defparam add_302_1.INJECT1_1 = "NO";
    CCU2D add_101_33 (.A0(\debounce_counters[4] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3326), .S0(n400));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_33.INIT0 = 16'h5aaa;
    defparam add_101_33.INIT1 = 16'h0000;
    defparam add_101_33.INJECT1_0 = "NO";
    defparam add_101_33.INJECT1_1 = "NO";
    CCU2D add_101_31 (.A0(\debounce_counters[4] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3325), .COUT(n3326), .S0(n402), 
          .S1(n401));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_31.INIT0 = 16'h5aaa;
    defparam add_101_31.INIT1 = 16'h5aaa;
    defparam add_101_31.INJECT1_0 = "NO";
    defparam add_101_31.INJECT1_1 = "NO";
    CCU2D add_74_13 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3268), .COUT(n3269), .S0(n102), 
          .S1(n101));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_13.INIT0 = 16'h5aaa;
    defparam add_74_13.INIT1 = 16'h5aaa;
    defparam add_74_13.INJECT1_0 = "NO";
    defparam add_74_13.INJECT1_1 = "NO";
    CCU2D add_74_11 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3267), .COUT(n3268), .S0(n104), 
          .S1(n103));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_74_11.INIT0 = 16'h5aaa;
    defparam add_74_11.INIT1 = 16'h5aaa;
    defparam add_74_11.INJECT1_0 = "NO";
    defparam add_74_11.INJECT1_1 = "NO";
    CCU2D add_83_23 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3289), .COUT(n3290), .S0(n198), 
          .S1(n197));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_23.INIT0 = 16'h5aaa;
    defparam add_83_23.INIT1 = 16'h5aaa;
    defparam add_83_23.INJECT1_0 = "NO";
    defparam add_83_23.INJECT1_1 = "NO";
    CCU2D add_1465_8 (.A0(\debounce_counters[4] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3378), .COUT(n3379));
    defparam add_1465_8.INIT0 = 16'h5555;
    defparam add_1465_8.INIT1 = 16'h5aaa;
    defparam add_1465_8.INJECT1_0 = "NO";
    defparam add_1465_8.INJECT1_1 = "NO";
    CCU2D add_101_29 (.A0(\debounce_counters[4] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3324), .COUT(n3325), .S0(n404), 
          .S1(n403));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_29.INIT0 = 16'h5aaa;
    defparam add_101_29.INIT1 = 16'h5aaa;
    defparam add_101_29.INJECT1_0 = "NO";
    defparam add_101_29.INJECT1_1 = "NO";
    CCU2D add_101_27 (.A0(\debounce_counters[4] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3323), .COUT(n3324), .S0(n406), 
          .S1(n405));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_27.INIT0 = 16'h5aaa;
    defparam add_101_27.INIT1 = 16'h5aaa;
    defparam add_101_27.INJECT1_0 = "NO";
    defparam add_101_27.INJECT1_1 = "NO";
    CCU2D add_1465_6 (.A0(\debounce_counters[4] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3377), .COUT(n3378));
    defparam add_1465_6.INIT0 = 16'h5555;
    defparam add_1465_6.INIT1 = 16'h5aaa;
    defparam add_1465_6.INJECT1_0 = "NO";
    defparam add_1465_6.INJECT1_1 = "NO";
    CCU2D add_101_25 (.A0(\debounce_counters[4] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3322), .COUT(n3323), .S0(n408), 
          .S1(n407));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_25.INIT0 = 16'h5aaa;
    defparam add_101_25.INIT1 = 16'h5aaa;
    defparam add_101_25.INJECT1_0 = "NO";
    defparam add_101_25.INJECT1_1 = "NO";
    CCU2D add_101_23 (.A0(\debounce_counters[4] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3321), .COUT(n3322), .S0(n410), 
          .S1(n409));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_23.INIT0 = 16'h5aaa;
    defparam add_101_23.INIT1 = 16'h5aaa;
    defparam add_101_23.INJECT1_0 = "NO";
    defparam add_101_23.INJECT1_1 = "NO";
    CCU2D add_101_21 (.A0(\debounce_counters[4] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3320), .COUT(n3321), .S0(n412), 
          .S1(n411));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_21.INIT0 = 16'h5aaa;
    defparam add_101_21.INIT1 = 16'h5aaa;
    defparam add_101_21.INJECT1_0 = "NO";
    defparam add_101_21.INJECT1_1 = "NO";
    CCU2D add_101_19 (.A0(\debounce_counters[4] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3319), .COUT(n3320), .S0(n414), 
          .S1(n413));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_19.INIT0 = 16'h5aaa;
    defparam add_101_19.INIT1 = 16'h5aaa;
    defparam add_101_19.INJECT1_0 = "NO";
    defparam add_101_19.INJECT1_1 = "NO";
    CCU2D add_1465_4 (.A0(\debounce_counters[4] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3376), .COUT(n3377));
    defparam add_1465_4.INIT0 = 16'h5555;
    defparam add_1465_4.INIT1 = 16'h5555;
    defparam add_1465_4.INJECT1_0 = "NO";
    defparam add_1465_4.INJECT1_1 = "NO";
    CCU2D add_1465_2 (.A0(\debounce_counters[4] [7]), .B0(\debounce_counters[4] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[4] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n3376));
    defparam add_1465_2.INIT0 = 16'h1000;
    defparam add_1465_2.INIT1 = 16'h5aaa;
    defparam add_1465_2.INJECT1_0 = "NO";
    defparam add_1465_2.INJECT1_1 = "NO";
    CCU2D add_101_17 (.A0(\debounce_counters[4] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3318), .COUT(n3319), .S0(n416), 
          .S1(n415));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_17.INIT0 = 16'h5aaa;
    defparam add_101_17.INIT1 = 16'h5aaa;
    defparam add_101_17.INJECT1_0 = "NO";
    defparam add_101_17.INJECT1_1 = "NO";
    CCU2D add_83_21 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3288), .COUT(n3289), .S0(n200), 
          .S1(n199));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_21.INIT0 = 16'h5aaa;
    defparam add_83_21.INIT1 = 16'h5aaa;
    defparam add_83_21.INJECT1_0 = "NO";
    defparam add_83_21.INJECT1_1 = "NO";
    CCU2D add_83_19 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3287), .COUT(n3288), .S0(n202), 
          .S1(n201));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_19.INIT0 = 16'h5aaa;
    defparam add_83_19.INIT1 = 16'h5aaa;
    defparam add_83_19.INJECT1_0 = "NO";
    defparam add_83_19.INJECT1_1 = "NO";
    CCU2D add_92_15 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3301), .COUT(n3302), .S0(n312), 
          .S1(n311));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_15.INIT0 = 16'h5aaa;
    defparam add_92_15.INIT1 = 16'h5aaa;
    defparam add_92_15.INJECT1_0 = "NO";
    defparam add_92_15.INJECT1_1 = "NO";
    CCU2D add_92_13 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3300), .COUT(n3301), .S0(n314), 
          .S1(n313));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_13.INIT0 = 16'h5aaa;
    defparam add_92_13.INIT1 = 16'h5aaa;
    defparam add_92_13.INJECT1_0 = "NO";
    defparam add_92_13.INJECT1_1 = "NO";
    CCU2D add_92_33 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3310), .S0(n294));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_92_33.INIT0 = 16'h5aaa;
    defparam add_92_33.INIT1 = 16'h0000;
    defparam add_92_33.INJECT1_0 = "NO";
    defparam add_92_33.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i2 (.D(n323), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i3 (.D(n322), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i4 (.D(n321), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i5 (.D(n320), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i6 (.D(n319), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i7 (.D(n318), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i8 (.D(n317), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i9 (.D(n316), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i10 (.D(n315), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i11 (.D(n314), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i12 (.D(n313), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i13 (.D(n312), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i14 (.D(n311), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i15 (.D(n310), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i16 (.D(n309), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i17 (.D(n308), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i18 (.D(n307), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i19 (.D(n306), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i20 (.D(n305), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i21 (.D(n304), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i22 (.D(n303), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i23 (.D(n302), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i24 (.D(n301), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i25 (.D(n300), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i26 (.D(n299), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i27 (.D(n298), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i28 (.D(n297), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i29 (.D(n296), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i30 (.D(n295), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i31 (.D(n294), .SP(clk_enable_162), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_3___i31.GSR = "ENABLED";
    PFUMX i1788 (.BLUT(n3746), .ALUT(n3741), .C0(next_state[3]), .Z(next_state_3__N_31[2]));
    CCU2D add_101_15 (.A0(\debounce_counters[4] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3317), .COUT(n3318), .S0(n418), 
          .S1(n417));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_15.INIT0 = 16'h5aaa;
    defparam add_101_15.INIT1 = 16'h5aaa;
    defparam add_101_15.INJECT1_0 = "NO";
    defparam add_101_15.INJECT1_1 = "NO";
    CCU2D add_83_17 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3286), .COUT(n3287), .S0(n204), 
          .S1(n203));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_17.INIT0 = 16'h5aaa;
    defparam add_83_17.INIT1 = 16'h5aaa;
    defparam add_83_17.INJECT1_0 = "NO";
    defparam add_83_17.INJECT1_1 = "NO";
    CCU2D add_83_15 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3285), .COUT(n3286), .S0(n206), 
          .S1(n205));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_15.INIT0 = 16'h5aaa;
    defparam add_83_15.INIT1 = 16'h5aaa;
    defparam add_83_15.INJECT1_0 = "NO";
    defparam add_83_15.INJECT1_1 = "NO";
    CCU2D add_101_13 (.A0(\debounce_counters[4] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3316), .COUT(n3317), .S0(n420), 
          .S1(n419));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_13.INIT0 = 16'h5aaa;
    defparam add_101_13.INIT1 = 16'h5aaa;
    defparam add_101_13.INJECT1_0 = "NO";
    defparam add_101_13.INJECT1_1 = "NO";
    CCU2D add_83_13 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3284), .COUT(n3285), .S0(n208), 
          .S1(n207));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_13.INIT0 = 16'h5aaa;
    defparam add_83_13.INIT1 = 16'h5aaa;
    defparam add_83_13.INJECT1_0 = "NO";
    defparam add_83_13.INJECT1_1 = "NO";
    CCU2D add_83_11 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3283), .COUT(n3284), .S0(n210), 
          .S1(n209));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_83_11.INIT0 = 16'h5aaa;
    defparam add_83_11.INIT1 = 16'h5aaa;
    defparam add_83_11.INJECT1_0 = "NO";
    defparam add_83_11.INJECT1_1 = "NO";
    FD1P3AX next_state_i2 (.D(next_state_3__N_31[2]), .SP(clk_enable_163), 
            .CK(clk), .Q(next_state[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam next_state_i2.GSR = "ENABLED";
    FD1P3IX counter_i0_i0 (.D(n1227), .SP(clk_enable_171), .CD(n2686), 
            .CK(clk), .Q(counter[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i0.GSR = "ENABLED";
    PFUMX i1900 (.BLUT(n3939), .ALUT(n3940), .C0(next_state[0]), .Z(n29));
    PFUMX i1786 (.BLUT(n3743), .ALUT(n3742), .C0(next_state[0]), .Z(n3744));
    FD1P3IX counter_i0_i21 (.D(n1797), .SP(clk_enable_171), .CD(n2994), 
            .CK(clk), .Q(counter[21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i0 (.D(n431), .SP(clk_enable_166), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(206[9] 230[16])
    defparam debounce_counters_4___i0.GSR = "ENABLED";
    FD1P3AX FPIO_isoCtrlRSTn_269 (.D(FPIO_isoCtrlRSTn_N_491), .SP(clk_enable_167), 
            .CK(clk), .Q(FPIO_isoCtrlRSTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam FPIO_isoCtrlRSTn_269.GSR = "ENABLED";
    FD1P3IX counter_i0_i17 (.D(n2491), .SP(clk_enable_171), .CD(n2691), 
            .CK(clk), .Q(counter[17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i17.GSR = "ENABLED";
    GSR GSR_INST (.GSR(VCC_net));
    FD1P3IX DIGS3C_Shared_ReqSafeState_261 (.D(n7), .SP(clk_enable_169), 
            .CD(n2680), .CK(clk), .Q(DIGS3C_Shared_ReqSafeState_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam DIGS3C_Shared_ReqSafeState_261.GSR = "ENABLED";
    CCU2D add_101_11 (.A0(\debounce_counters[4] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3315), .COUT(n3316), .S0(n422), 
          .S1(n421));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[49:69])
    defparam add_101_11.INIT0 = 16'h5aaa;
    defparam add_101_11.INIT1 = 16'h5aaa;
    defparam add_101_11.INJECT1_0 = "NO";
    defparam add_101_11.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i16 (.D(n1862), .SP(clk_enable_171), .CD(n2691), 
            .CK(clk), .Q(counter[16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i16.GSR = "ENABLED";
    FD1P3IX counter_i0_i15 (.D(n3447), .SP(clk_enable_171), .CD(n2691), 
            .CK(clk), .Q(counter[15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(243[2] 410[9])
    defparam counter_i0_i15.GSR = "ENABLED";
    PFUMX i1898 (.BLUT(n3936), .ALUT(n3937), .C0(next_state[2]), .Z(clk_enable_22));
    
endmodule
//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

