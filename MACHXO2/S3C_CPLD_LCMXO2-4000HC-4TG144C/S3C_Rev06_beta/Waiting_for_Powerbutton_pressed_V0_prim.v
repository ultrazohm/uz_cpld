// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Thu Aug 21 13:11:13 2025
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
            TDnALERT, S3C_S1);   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(7[8:42])
    output FP_SysLEDg;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(12[3:13])
    output FP_SysLEDr;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(13[3:13])
    output FP_SysLEDb;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(14[3:13])
    output FlexIO05;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(15[3:11])
    input FlexIO04;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(16[3:11])
    input FlexIO03;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(17[3:11])
    output FlexIO02;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(18[3:11])
    output FlexIO01;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(19[3:11])
    input FP_UsrSW1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(20[3:12])
    input FP_UsrSW2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(21[3:12])
    input SCL /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(23[3:6])
    input SDA /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(24[3:6])
    input FP_UsrSW3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(25[3:12])
    input SysSW_Pwr_NC;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(26[3:15])
    output FPIO_isoCtrlRSTn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(27[3:19])
    input FPIO_iosCtrlINTn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(28[3:19])
    output Carrier_PG_3V3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(29[3:17])
    input FPIO_ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(30[3:20])
    inout FPIO_FlexMIO28;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(31[3:17])
    inout FPIO_FlexMIO27;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(32[3:17])
    inout FPIO_FlexMIO30;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(33[3:17])
    inout FPIO_FlexMIO29;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(34[3:17])
    output FPIO_FlexMIO52;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(35[3:17])
    output Carrier_PG_1V8;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(37[3:17])
    input S3CsI2C_SDA /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(38[3:14])
    input S3CsI2C_SCL /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(39[3:14])
    output FP_SysLEDs;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(40[3:13])
    input SD1_CD;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(41[3:9])
    input SD0_CD;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(42[3:9])
    input SPI_S3C_nCS_USR;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(43[3:18])
    output [4:1]FP_UsrLED;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(44[3:12])
    output DIGS3C_Shared_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(45[3:29])
    output DIGS3C_Shared_ReqSafeState;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(46[3:29])
    input [5:1]DIGS3C_SlotD_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(47[3:21])
    input [5:1]DIGS3C_SlotD_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(48[3:22])
    input [5:0]FlexLIO;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(49[3:10])
    inout DIG5S3C26;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(51[3:12])
    inout DIG5S3C25;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(52[3:12])
    inout DIG5S3C24;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(53[3:12])
    output SD_SEL;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(54[3:9])
    input FlexMIOs52_PCIe;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(56[3:18])
    output FlexMIOs53_GPIO_PowerDown;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(57[3:28])
    inout FlexMIOs54;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(58[3:13])
    output FlexMio61ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(59[3:24])
    inout FlexMIOs62;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(60[3:13])
    inout FlexMIOs63;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(61[3:13])
    inout FlexMIOs31;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(62[3:13])
    inout FlexMIOs30;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(63[3:13])
    inout FlexMIOs29;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(64[3:13])
    inout FlexMIOs28;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(65[3:13])
    inout FlexMIOs27;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(66[3:13])
    inout FlexMIOs26;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(67[3:13])
    input FlexMIOs45 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(68[3:13])
    inout FlexMIOs37;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(69[3:13])
    inout FlexMIOs36;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(70[3:13])
    inout FlexMIOs35;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(71[3:13])
    inout FlexMIOs34;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(72[3:13])
    inout FlexMIOs33;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(73[3:13])
    inout FlexMIOs32;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(74[3:13])
    inout DIG5S3C03;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(76[3:12])
    inout DIG5S3C04;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(77[3:12])
    inout DIG5S3C05;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(78[3:12])
    inout DIG5S3C00;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(79[3:12])
    inout DIG5S3C02;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(80[3:12])
    inout DIG5S3C01;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(81[3:12])
    inout DIG5S3C29;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(82[3:12])
    inout DIG5S3C28;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(83[3:12])
    inout DIG5S3C27;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(84[3:12])
    input [3:1]ANL_S3C_SLOTOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(87[3:17])
    output ANL_S3C_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(88[3:23])
    input ANL_S3C_P54_Legacy /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(89[3:21])
    output [5:1]DIGS3C_SlotD_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(90[3:22])
    output Carrier_PwrOn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(93[9:22])
    input PG_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(94[3:9])
    input PPn_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(95[3:10])
    input PG_Module;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(96[3:12])
    input TDnSHDN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(97[3:10])
    input TDnFFnFS /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(98[3:11])
    input TDnALERT;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(99[3:11])
    input S3C_S1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(100[3:9])
    
    wire clk /* synthesis is_clock=1, SET_AS_NETWORK=clk */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(106[9:12])
    wire dummy_signal /* synthesis noclip="on" */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(156[9:21])
    
    wire GND_net, VCC_net, FP_SysLEDg_c, FP_SysLEDr_c, FP_SysLEDb_c, 
        FlexIO04_c, FlexIO03_c, FP_UsrSW1_c, FP_UsrSW2_c, SCL_c, SDA_c, 
        FP_UsrSW3_c, SysSW_Pwr_NC_c, FPIO_isoCtrlRSTn_c, FPIO_iosCtrlINTn_c, 
        Carrier_PG_3V3_c, FlexMio61ExternalStop_c_c, FPIO_FlexMIO52_c_c, 
        S3CsI2C_SDA_c, S3CsI2C_SCL_c, FP_SysLEDs_c, SD1_CD_c, SD0_CD_c, 
        SPI_S3C_nCS_USR_c, DIGS3C_Shared_ReqSafeState_c, DIGS3C_SlotD_ReqOE_c_5, 
        DIGS3C_SlotD_ReqOE_c_4, DIGS3C_SlotD_ReqOE_c_3, DIGS3C_SlotD_ReqOE_c_2, 
        DIGS3C_SlotD_ReqOE_c_1, DIGS3C_SlotD_SlotOK_c_5, DIGS3C_SlotD_SlotOK_c_4, 
        DIGS3C_SlotD_SlotOK_c_3, DIGS3C_SlotD_SlotOK_c_2, DIGS3C_SlotD_SlotOK_c_1, 
        FlexLIO_c_5, FlexLIO_c_4, FlexLIO_c_3, FlexLIO_c_2, FlexLIO_c_1, 
        FlexLIO_c_0, FlexMIOs53_GPIO_PowerDown_c, n5329, FlexMIOs45_c, 
        ANL_S3C_SLOTOK_c_3, ANL_S3C_SLOTOK_c_2, ANL_S3C_SLOTOK_c_1, ANL_S3C_P54_Legacy_c, 
        DIGS3C_SlotD_SlotOE_c_5, DIGS3C_SlotD_SlotOE_c_4, DIGS3C_SlotD_SlotOE_c_3, 
        DIGS3C_SlotD_SlotOE_c_2, DIGS3C_SlotD_SlotOE_c_1, Carrier_PwrOn_c, 
        PG_VIN_c, PPn_VIN_c, PG_Module_c, TDnSHDN_c, TDnFFnFS_c, TDnALERT_c, 
        S3C_S1_c;
    wire [24:0]counter;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(107[9:16])
    wire [3:0]next_state;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(113[12:22])
    wire [31:0]\debounce_counters[1] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(120[12:29])
    wire [31:0]\debounce_counters[2] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(120[12:29])
    wire [31:0]\debounce_counters[3] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(120[12:29])
    wire [31:0]\debounce_counters[4] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(120[12:29])
    
    wire n5409, n5408, n5407;
    wire [6:1]debounce_inputs_asyn1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(122[12:33])
    wire [6:1]debounce_inputs_asyn2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(123[9:30])
    wire [6:1]pushed;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(124[9:15])
    wire [6:1]signals_debounced_syn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(125[12:33])
    
    wire n5069, n5703, externstop_falling, externstop_last, extern_connected, 
        forceoutputdisable, n5068, n5067, n5089, clk_enable_118, n5066, 
        n5065, n5064, n5723, clk_enable_21, n5088, n5087, n5086, 
        n5085, n5722, n175, n176, n177, n178, n179, n180, n181, 
        n182, n183, n184, n185, n186, n187, n188, n189, n190, 
        n191, n192, n193, n194, n195, n196, n197, n198, n199, 
        n200, n201, n202, n203, n204, n205, n206, n48, n5063, 
        n5062, n46, n5084, n4, n33, n43, n5061, n5060, n5083, 
        n42, n5082, n5081, n5080, n5701, pushed_1__N_264, DIG5S3C27_out, 
        n281, n282, n283, n284, n285, n286, n287, n288, n289, 
        n290, n291, n292, n293, n294, n295, n296, n297, n298, 
        n299, n300, n301, n302, n303, n304, n305, n306, n307, 
        n308, n309, n310, n311, n312, n5059, n5058, n5057, n5056, 
        n5079, n5370, n5055, n40, n5441, n5078, n38, n5077, 
        pushed_2__N_262, DIG5S3C28_out, n387, n388, n389, n390, 
        n391, n392, n393, n394, n395, n396, n397, n398, n399, 
        n400, n401, n402, n403, n404, n405, n406, n407, n408, 
        n409, n410, n411, n412, n413, n414, n415, n416, n417, 
        n418, n5054, n37, n5076, n5053, n10, n5052, n5075, clk_enable_121, 
        n5074, n5073, n5366, clk_enable_23, n5072, n5051, n5071, 
        pushed_3__N_260, n493, n494, n495, n496, n497, n498, n499, 
        n500, n501, n502, n503, n504, n505, n506, n507, n508, 
        n509, n510, n511, n512, n513, n514, n515, n516, n517, 
        n518, n519, n520, n521, n522, n523, n524, n48_adj_1, 
        clk_enable_131, n8, n5050, n5049, pushed_4__N_258, DIG5S3C29_out, 
        n5048, n5047, n32, n86, n5046, n5045, n3922, n5044, 
        n28, n5043, n5042, n5041, n3872, n5040, n5039, n5038, 
        n5037, n5036, n27, n5035, n5034, n5360, n70, n5033, 
        n5032, DIG5S3C01_out, n3923, n5031, n126, n3499, n5030, 
        n3534, n5029, n124, n4115, n5028, n5027, n5026, n5025, 
        clk_enable_141, n5024, n122, n5023, n5022, externstop_falling_N_707, 
        n120, n5021, n118, n5020, DIG5S3C02_out, n3433, DIG5S3C00_out, 
        DIG5S3C05_out, FPIO_isoCtrlRSTn_N_687, DIG5S3C04_out, clk_enable_110, 
        n116, n5019, n5018, clk_enable_116, DIG5S3C03_out, FlexMIOs32_out, 
        FlexMIOs33_out, n5097, FlexMIOs34_out, FlexMIOs35_out, n5675, 
        n49, n45, n5674, n5673, n4059, clk_enable_129, clk_enable_6, 
        n78, FlexMIOs36_out, n114, n5668, n113, FlexMIOs37_out, 
        FlexMIOs26_out, FlexMIOs27_out, n5017, n5667, FlexMIOs28_out, 
        n5666, n35, FlexMIOs29_out, n11, n4_adj_2, n112, n51, 
        n57, n5748, n74, n2565, FlexMIOs30_out, n5747, n5016, 
        n29, FlexMIOs31_out, n2563, n110, n2559, n5746, FlexMIOs63_out, 
        n5745, n5744, n5879, n5878, n5877, n2401, n5876, n5875, 
        n5874, n5873, n2394, n5015, n5014, n108, n5013, n2507, 
        n2506, n106, n2503, n2497, n2496, n2495, n2493, n2492, 
        n2491, n5012, n105, n104, clk_enable_132, n5872, n5011, 
        n5010, n5009, n5008, FlexMIOs62_out, n5328, n5639, n5638, 
        n5637, n5007, n5006, n5636, n5005, n2475, n5004, n2473, 
        n2472, n2471, n2470, n2468, n3971, n2466, n2465, n2464, 
        n5003, FlexMIOs53_GPIO_PowerDown_N_698, n5718;
    wire [3:0]next_state_3__N_485;
    
    wire n102, n1681, n1682, n1683, n1684, n1685, n1686, n1687, 
        n1688, n1689, n1690, n1691, n1692, n1693, n1694, n1695, 
        n1696, n1697, n1698, n1699, n1700, n1701, n1702, n1703, 
        n1704, n1705, n2463, n2462, n2461, n5717, n5716, n66, 
        clk_enable_7, FlexMIOs54_out, n5714, n5002, n5922, forceoutputdisable_N_3, 
        DIGS3C_Shared_ReqSafeState_N_695, FlexMIOs53_GPIO_PowerDown_N_697, 
        FP_SysLEDr_N_681, FP_SysLEDb_N_682, FP_SysLEDg_N_680;
    wire [3:0]next_state_3__N_31;
    
    wire Carrier_PwrOn_N_700, n100, FPIO_isoCtrlRSTn_N_683, n5713, n23, 
        n5001, n5920, n5000, n5712, clk_enable_25, n17, n19, FP_SysLEDs_N_694, 
        n4999, n74_adj_3, Carrier_PG_1V8_N_774, Carrier_PG_1V8_N_781, 
        Carrier_PG_1V8_N_693, n5711, n5350, clk_enable_19, n5710, 
        n5386, n5096, n4998, clk_enable_119, DIG5S3C24_out, n4997, 
        DIG5S3C25_out, n4996, DIG5S3C26_out, n4995, FPIO_FlexMIO29_out, 
        n4994, FPIO_FlexMIO30_out, FPIO_FlexMIO27_out, FPIO_FlexMIO28_out, 
        n4993, n4992, n4991, n4990, n4989, n4988, clk_enable_111, 
        n5709, n5724, n5729, n4987, n4986, n5728, n4985, n5700, 
        n5095, n4984, n4983, n4982, n98, n73, n4981, n4980, 
        n5094, clk_enable_112, n4979, n4978, n94, n3525, n4977, 
        n5708, n4976, n4975, n5727, n5093, n4974, n5347, clk_enable_120, 
        n4973, clk_enable_46, clk_enable_130, clk_enable_172, clk_enable_109, 
        n5092, n90, n5091, n89, n30, n7, n5090, n5705, n4972, 
        n3108, n4971, n2796, n5725, n4970, n5704;
    
    VHI i2 (.Z(VCC_net));
    LUT4 i1832_2_lut_3_lut (.A(n2559), .B(n2563), .C(n1689), .Z(n2465)) /* synthesis lut_function=(A+((C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i1832_2_lut_3_lut.init = 16'hfbfb;
    LUT4 i1529_4_lut_4_lut (.A(next_state[3]), .B(n5097), .C(next_state[2]), 
         .D(n5675), .Z(next_state_3__N_31[2])) /* synthesis lut_function=(!(A (C+!(D))+!A !(B (C+(D))+!B !(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam i1529_4_lut_4_lut.init = 16'h4f40;
    LUT4 i2921_3_lut (.A(n57), .B(n49), .C(next_state[3]), .Z(n45)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i2921_3_lut.init = 16'hcaca;
    LUT4 FPIO_isoCtrlRSTn_N_687_bdd_4_lut_3150 (.A(FPIO_isoCtrlRSTn_N_687), 
         .B(externstop_falling), .C(next_state[2]), .D(next_state[3]), 
         .Z(n5873)) /* synthesis lut_function=(!(A (B (D)+!B (C+(D)))+!A (B (C (D))+!B (C)))) */ ;
    defparam FPIO_isoCtrlRSTn_N_687_bdd_4_lut_3150.init = 16'h05cf;
    CCU2D add_2588_12 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4974), .COUT(n4975));
    defparam add_2588_12.INIT0 = 16'h5555;
    defparam add_2588_12.INIT1 = 16'h5555;
    defparam add_2588_12.INJECT1_0 = "NO";
    defparam add_2588_12.INJECT1_1 = "NO";
    LUT4 next_state_1__bdd_4_lut_3162 (.A(externstop_falling), .B(next_state_3__N_485[2]), 
         .C(next_state[2]), .D(next_state[3]), .Z(n5878)) /* synthesis lut_function=(!(((C+!(D))+!B)+!A)) */ ;
    defparam next_state_1__bdd_4_lut_3162.init = 16'h0800;
    CCU2D add_2590_18 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4989), .COUT(n4990));
    defparam add_2590_18.INIT0 = 16'h5555;
    defparam add_2590_18.INIT1 = 16'h5555;
    defparam add_2590_18.INJECT1_0 = "NO";
    defparam add_2590_18.INJECT1_1 = "NO";
    CCU2D add_185_5 (.A0(\debounce_counters[3] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5027), .COUT(n5028), .S0(n415), 
          .S1(n414));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_5.INIT0 = 16'h5aaa;
    defparam add_185_5.INIT1 = 16'h5aaa;
    defparam add_185_5.INJECT1_0 = "NO";
    defparam add_185_5.INJECT1_1 = "NO";
    LUT4 n5878_bdd_3_lut (.A(n5878), .B(n5877), .C(next_state[1]), .Z(n5879)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam n5878_bdd_3_lut.init = 16'hcaca;
    CCU2D add_2587_26 (.A0(\debounce_counters[4] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5082), .S1(clk_enable_112));
    defparam add_2587_26.INIT0 = 16'hf555;
    defparam add_2587_26.INIT1 = 16'h0000;
    defparam add_2587_26.INJECT1_0 = "NO";
    defparam add_2587_26.INJECT1_1 = "NO";
    LUT4 n5879_bdd_3_lut (.A(n5879), .B(n5874), .C(next_state[0]), .Z(next_state_3__N_31[1])) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam n5879_bdd_3_lut.init = 16'hcaca;
    CCU2D add_2588_10 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4973), .COUT(n4974));
    defparam add_2588_10.INIT0 = 16'h5555;
    defparam add_2588_10.INIT1 = 16'h5555;
    defparam add_2588_10.INJECT1_0 = "NO";
    defparam add_2588_10.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_4_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(next_state[1]), .D(next_state[0]), .Z(clk_enable_19)) /* synthesis lut_function=((B+!(C+(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam i1_2_lut_3_lut_4_lut_4_lut.init = 16'hdddf;
    CCU2D add_2587_24 (.A0(\debounce_counters[4] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5081), .COUT(n5082));
    defparam add_2587_24.INIT0 = 16'h5555;
    defparam add_2587_24.INIT1 = 16'h5555;
    defparam add_2587_24.INJECT1_0 = "NO";
    defparam add_2587_24.INJECT1_1 = "NO";
    CCU2D add_2587_22 (.A0(\debounce_counters[4] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5080), .COUT(n5081));
    defparam add_2587_22.INIT0 = 16'h5555;
    defparam add_2587_22.INIT1 = 16'h5555;
    defparam add_2587_22.INJECT1_0 = "NO";
    defparam add_2587_22.INJECT1_1 = "NO";
    LUT4 next_state_2__bdd_2_lut_3044 (.A(next_state[3]), .B(next_state[0]), 
         .Z(n5636)) /* synthesis lut_function=(A+(B)) */ ;
    defparam next_state_2__bdd_2_lut_3044.init = 16'heeee;
    LUT4 i1_4_lut_4_lut (.A(next_state[3]), .B(n35), .C(n29), .D(next_state[2]), 
         .Z(n2563)) /* synthesis lut_function=(!(A ((D)+!C)+!A !(B+!((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam i1_4_lut_4_lut.init = 16'h44f4;
    LUT4 next_state_1__bdd_4_lut_2976 (.A(next_state[1]), .B(next_state[0]), 
         .C(next_state[3]), .D(next_state[2]), .Z(clk_enable_120)) /* synthesis lut_function=(A (B (D)+!B (C (D)))+!A (B (C (D))+!B ((D)+!C))) */ ;
    defparam next_state_1__bdd_4_lut_2976.init = 16'hf901;
    FD1P3IX counter_i0_i10 (.D(n2471), .SP(clk_enable_141), .CD(n3534), 
            .CK(clk), .Q(counter[10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i10.GSR = "ENABLED";
    FD1P3IX counter_i0_i7 (.D(n1698), .SP(clk_enable_141), .CD(n3525), 
            .CK(clk), .Q(counter[7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i7.GSR = "ENABLED";
    CCU2D add_2590_16 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4988), .COUT(n4989));
    defparam add_2590_16.INIT0 = 16'h5555;
    defparam add_2590_16.INIT1 = 16'h5555;
    defparam add_2590_16.INJECT1_0 = "NO";
    defparam add_2590_16.INJECT1_1 = "NO";
    CCU2D add_2587_20 (.A0(\debounce_counters[4] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5079), .COUT(n5080));
    defparam add_2587_20.INIT0 = 16'h5555;
    defparam add_2587_20.INIT1 = 16'h5555;
    defparam add_2587_20.INJECT1_0 = "NO";
    defparam add_2587_20.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i0 (.D(n524), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i0.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i0 (.D(n206), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i0.GSR = "ENABLED";
    CCU2D add_185_3 (.A0(\debounce_counters[3] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5026), .COUT(n5027), .S0(n417), 
          .S1(n416));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_3.INIT0 = 16'h5aaa;
    defparam add_185_3.INIT1 = 16'h5aaa;
    defparam add_185_3.INJECT1_0 = "NO";
    defparam add_185_3.INJECT1_1 = "NO";
    CCU2D add_185_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[3] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n5026), .S1(n418));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_1.INIT0 = 16'hF000;
    defparam add_185_1.INIT1 = 16'h5555;
    defparam add_185_1.INJECT1_0 = "NO";
    defparam add_185_1.INJECT1_1 = "NO";
    LUT4 mux_604_i9_4_lut (.A(next_state[1]), .B(n1697), .C(n2563), .D(n2559), 
         .Z(n2473)) /* synthesis lut_function=(!(A (((D)+!C)+!B)+!A (B (C (D))+!B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_604_i9_4_lut.init = 16'h05c5;
    CCU2D add_176_33 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5025), .S0(n281));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_33.INIT0 = 16'h5aaa;
    defparam add_176_33.INIT1 = 16'h0000;
    defparam add_176_33.INJECT1_0 = "NO";
    defparam add_176_33.INJECT1_1 = "NO";
    CCU2D add_176_31 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5024), .COUT(n5025), .S0(n283), 
          .S1(n282));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_31.INIT0 = 16'h5aaa;
    defparam add_176_31.INIT1 = 16'h5aaa;
    defparam add_176_31.INJECT1_0 = "NO";
    defparam add_176_31.INJECT1_1 = "NO";
    FD1S3AY debounce_inputs_asyn2_i1 (.D(debounce_inputs_asyn1[1]), .CK(clk), 
            .Q(debounce_inputs_asyn2[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_inputs_asyn2_i1.GSR = "ENABLED";
    CCU2D add_2587_18 (.A0(\debounce_counters[4] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5078), .COUT(n5079));
    defparam add_2587_18.INIT0 = 16'h5555;
    defparam add_2587_18.INIT1 = 16'h5555;
    defparam add_2587_18.INJECT1_0 = "NO";
    defparam add_2587_18.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i6 (.D(n2475), .SP(clk_enable_141), .CD(n3534), 
            .CK(clk), .Q(counter[6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i6.GSR = "ENABLED";
    FD1P3IX pushed_i1 (.D(n5922), .SP(clk_enable_6), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(pushed[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam pushed_i1.GSR = "ENABLED";
    CCU2D add_176_29 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5023), .COUT(n5024), .S0(n285), 
          .S1(n284));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_29.INIT0 = 16'h5aaa;
    defparam add_176_29.INIT1 = 16'h5aaa;
    defparam add_176_29.INJECT1_0 = "NO";
    defparam add_176_29.INJECT1_1 = "NO";
    CCU2D add_2587_16 (.A0(\debounce_counters[4] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5077), .COUT(n5078));
    defparam add_2587_16.INIT0 = 16'h5555;
    defparam add_2587_16.INIT1 = 16'h5555;
    defparam add_2587_16.INJECT1_0 = "NO";
    defparam add_2587_16.INJECT1_1 = "NO";
    LUT4 i1_3_lut_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), .C(next_state[0]), 
         .D(FPIO_isoCtrlRSTn_N_687), .Z(n49)) /* synthesis lut_function=(!(A+!(B+!((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(113[12:22])
    defparam i1_3_lut_4_lut_4_lut.init = 16'h4454;
    LUT4 mux_424_Mux_12_i15_4_lut (.A(PPn_VIN_c), .B(next_state[3]), .C(next_state[2]), 
         .D(next_state[1]), .Z(forceoutputdisable_N_3)) /* synthesis lut_function=(!(A (B (C+!(D))+!B (C))+!A (B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_424_Mux_12_i15_4_lut.init = 16'h1f17;
    CCU2D add_2587_14 (.A0(\debounce_counters[4] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5076), .COUT(n5077));
    defparam add_2587_14.INIT0 = 16'h5555;
    defparam add_2587_14.INIT1 = 16'h5555;
    defparam add_2587_14.INJECT1_0 = "NO";
    defparam add_2587_14.INJECT1_1 = "NO";
    FD1S3AY signals_debounced_syn_i1 (.D(pushed_1__N_264), .CK(clk), .Q(next_state_3__N_485[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam signals_debounced_syn_i1.GSR = "ENABLED";
    CCU2D add_2590_14 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4987), .COUT(n4988));
    defparam add_2590_14.INIT0 = 16'h5555;
    defparam add_2590_14.INIT1 = 16'h5555;
    defparam add_2590_14.INJECT1_0 = "NO";
    defparam add_2590_14.INJECT1_1 = "NO";
    FD1S3AX externstop_falling_379 (.D(externstop_falling_N_707), .CK(clk), 
            .Q(externstop_falling));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam externstop_falling_379.GSR = "ENABLED";
    CCU2D add_2587_12 (.A0(\debounce_counters[4] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5075), .COUT(n5076));
    defparam add_2587_12.INIT0 = 16'h5555;
    defparam add_2587_12.INIT1 = 16'h5555;
    defparam add_2587_12.INJECT1_0 = "NO";
    defparam add_2587_12.INJECT1_1 = "NO";
    FD1S3AX externstop_last_380 (.D(signals_debounced_syn[2]), .CK(clk), 
            .Q(externstop_last));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam externstop_last_380.GSR = "ENABLED";
    FD1P3AX forceoutputdisable_381 (.D(forceoutputdisable_N_3), .SP(clk_enable_7), 
            .CK(clk), .Q(forceoutputdisable));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam forceoutputdisable_381.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i31 (.D(n493), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i31.GSR = "ENABLED";
    CCU2D add_2587_10 (.A0(\debounce_counters[4] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5074), .COUT(n5075));
    defparam add_2587_10.INIT0 = 16'h5555;
    defparam add_2587_10.INIT1 = 16'h5555;
    defparam add_2587_10.INJECT1_0 = "NO";
    defparam add_2587_10.INJECT1_1 = "NO";
    CCU2D add_176_27 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5022), .COUT(n5023), .S0(n287), 
          .S1(n286));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_27.INIT0 = 16'h5aaa;
    defparam add_176_27.INIT1 = 16'h5aaa;
    defparam add_176_27.INJECT1_0 = "NO";
    defparam add_176_27.INJECT1_1 = "NO";
    PFUMX i3067 (.BLUT(n5745), .ALUT(n5744), .C0(FPIO_isoCtrlRSTn_N_687), 
          .Z(n5746));
    LUT4 mux_604_i10_4_lut (.A(next_state[1]), .B(n1696), .C(n2563), .D(n2559), 
         .Z(n2472)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_604_i10_4_lut.init = 16'hfaca;
    FD1P3IX debounce_counters_4___i30 (.D(n494), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i29 (.D(n495), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i28 (.D(n496), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i28.GSR = "ENABLED";
    LUT4 i1_3_lut_3_lut_3_lut (.A(next_state[0]), .B(n5370), .C(next_state[3]), 
         .Z(n48_adj_1)) /* synthesis lut_function=(!(A ((C)+!B)+!A (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i1_3_lut_3_lut_3_lut.init = 16'h0d0d;
    FD1P3IX debounce_counters_4___i27 (.D(n497), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i27.GSR = "ENABLED";
    LUT4 mux_613_i13_4_lut (.A(n1693), .B(n5718), .C(n2565), .D(n5700), 
         .Z(n2503)) /* synthesis lut_function=(!(A (B (C))+!A (B (C+!(D))+!B !(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_613_i13_4_lut.init = 16'h3f3a;
    CCU2D add_2588_8 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4972), .COUT(n4973));
    defparam add_2588_8.INIT0 = 16'h5555;
    defparam add_2588_8.INIT1 = 16'h5aaa;
    defparam add_2588_8.INJECT1_0 = "NO";
    defparam add_2588_8.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i26 (.D(n498), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i26.GSR = "ENABLED";
    FD1P3IX counter_i0_i5 (.D(n1700), .SP(clk_enable_141), .CD(n3525), 
            .CK(clk), .Q(counter[5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i25 (.D(n499), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i25.GSR = "ENABLED";
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk)) /* synthesis NOM_FREQ="2.08", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "2.08";
    FD1P3IX debounce_counters_4___i24 (.D(n500), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i24.GSR = "ENABLED";
    CCU2D add_2590_12 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4986), .COUT(n4987));
    defparam add_2590_12.INIT0 = 16'h5555;
    defparam add_2590_12.INIT1 = 16'h5555;
    defparam add_2590_12.INJECT1_0 = "NO";
    defparam add_2590_12.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i23 (.D(n501), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i23.GSR = "ENABLED";
    LUT4 i2938_4_lut_then_3_lut (.A(next_state[2]), .B(next_state[3]), .C(next_state[0]), 
         .Z(n5725)) /* synthesis lut_function=(A (B+(C))+!A (B (C))) */ ;
    defparam i2938_4_lut_then_3_lut.init = 16'he8e8;
    LUT4 n3808_bdd_4_lut_4_lut (.A(next_state[0]), .B(next_state[3]), .C(next_state_3__N_485[2]), 
         .D(n5710), .Z(n5674)) /* synthesis lut_function=(!(A+!(B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam n3808_bdd_4_lut_4_lut.init = 16'h4404;
    FD1P3IX debounce_counters_4___i22 (.D(n502), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i22.GSR = "ENABLED";
    FD1P3AX DIGS3C_Shared_ReqSafeState_382 (.D(DIGS3C_Shared_ReqSafeState_N_695), 
            .SP(clk_enable_19), .CK(clk), .Q(DIGS3C_Shared_ReqSafeState_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam DIGS3C_Shared_ReqSafeState_382.GSR = "ENABLED";
    LUT4 i9_3_lut_3_lut (.A(next_state[0]), .B(FPIO_isoCtrlRSTn_N_687), 
         .C(next_state[3]), .Z(n8)) /* synthesis lut_function=(!(A (C)+!A (B+(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i9_3_lut_3_lut.init = 16'h0b0b;
    FD1P3AX FP_SysLEDb_385 (.D(FP_SysLEDb_N_682), .SP(clk_enable_21), .CK(clk), 
            .Q(FP_SysLEDb_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam FP_SysLEDb_385.GSR = "ENABLED";
    FD1P3AX FP_SysLEDg_386 (.D(FP_SysLEDg_N_680), .SP(clk_enable_21), .CK(clk), 
            .Q(FP_SysLEDg_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam FP_SysLEDg_386.GSR = "ENABLED";
    FD1P3AX Carrier_PwrOn_388 (.D(Carrier_PwrOn_N_700), .SP(clk_enable_23), 
            .CK(clk), .Q(Carrier_PwrOn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam Carrier_PwrOn_388.GSR = "ENABLED";
    FD1P3AX Carrier_PG_3V3_389 (.D(Carrier_PwrOn_N_700), .SP(clk_enable_23), 
            .CK(clk), .Q(Carrier_PG_3V3_c)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam Carrier_PG_3V3_389.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i21 (.D(n503), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i21.GSR = "ENABLED";
    FD1P3AX FP_SysLEDs_393 (.D(FP_SysLEDs_N_694), .SP(clk_enable_25), .CK(clk), 
            .Q(FP_SysLEDs_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam FP_SysLEDs_393.GSR = "ENABLED";
    LUT4 i74_4_lut_4_lut (.A(next_state[0]), .B(next_state[2]), .C(n5347), 
         .D(next_state_3__N_485[2]), .Z(n51)) /* synthesis lut_function=(A (B (C)+!B (D))+!A ((C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i74_4_lut_4_lut.init = 16'hf3d1;
    FD1P3IX debounce_counters_4___i20 (.D(n504), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i20.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn1_i1 (.D(SysSW_Pwr_NC_c), .CK(clk), .Q(debounce_inputs_asyn1[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_inputs_asyn1_i1.GSR = "ENABLED";
    LUT4 mux_604_i19_4_lut (.A(next_state[1]), .B(n1687), .C(n2563), .D(n2559), 
         .Z(n2463)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_604_i19_4_lut.init = 16'hf5c5;
    FD1P3IX debounce_counters_4___i19 (.D(n505), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i19.GSR = "ENABLED";
    LUT4 i1_2_lut_3_lut_3_lut_3_lut (.A(next_state[0]), .B(externstop_falling), 
         .C(next_state[3]), .Z(n5350)) /* synthesis lut_function=(!(A+((C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i1_2_lut_3_lut_3_lut_3_lut.init = 16'h0404;
    FD1P3IX debounce_counters_4___i18 (.D(n506), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i18.GSR = "ENABLED";
    FD1P3IX counter_i0_i4 (.D(n1701), .SP(clk_enable_141), .CD(n3525), 
            .CK(clk), .Q(counter[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i4.GSR = "ENABLED";
    LUT4 i1797_3_lut_3_lut_3_lut (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[2]), .Z(n7)) /* synthesis lut_function=(!(A (C)+!A !(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i1797_3_lut_3_lut_3_lut.init = 16'h4f4f;
    CCU2D add_2588_6 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4971), .COUT(n4972));
    defparam add_2588_6.INIT0 = 16'h5555;
    defparam add_2588_6.INIT1 = 16'h5aaa;
    defparam add_2588_6.INJECT1_0 = "NO";
    defparam add_2588_6.INJECT1_1 = "NO";
    CCU2D add_2587_8 (.A0(\debounce_counters[4] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5073), .COUT(n5074));
    defparam add_2587_8.INIT0 = 16'h5555;
    defparam add_2587_8.INIT1 = 16'h5aaa;
    defparam add_2587_8.INJECT1_0 = "NO";
    defparam add_2587_8.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i17 (.D(n507), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i16 (.D(n508), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i16.GSR = "ENABLED";
    CCU2D add_2588_4 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4970), .COUT(n4971));
    defparam add_2588_4.INIT0 = 16'h5555;
    defparam add_2588_4.INIT1 = 16'h5555;
    defparam add_2588_4.INJECT1_0 = "NO";
    defparam add_2588_4.INJECT1_1 = "NO";
    CCU2D add_176_25 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5021), .COUT(n5022), .S0(n289), 
          .S1(n288));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_25.INIT0 = 16'h5aaa;
    defparam add_176_25.INIT1 = 16'h5aaa;
    defparam add_176_25.INJECT1_0 = "NO";
    defparam add_176_25.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i15 (.D(n509), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i15.GSR = "ENABLED";
    LUT4 mux_604_i20_4_lut (.A(next_state[1]), .B(n1686), .C(n2563), .D(n2559), 
         .Z(n2462)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_604_i20_4_lut.init = 16'hf5c5;
    LUT4 i36_4_lut (.A(FlexMIOs27_out), .B(FlexMIOs33_out), .C(FlexMIOs31_out), 
         .D(FlexMIOs34_out), .Z(n100)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i36_4_lut.init = 16'h8000;
    CCU2D add_2588_2 (.A0(\debounce_counters[3] [7]), .B0(\debounce_counters[3] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[3] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n4970));
    defparam add_2588_2.INIT0 = 16'h1000;
    defparam add_2588_2.INIT1 = 16'h5aaa;
    defparam add_2588_2.INJECT1_0 = "NO";
    defparam add_2588_2.INJECT1_1 = "NO";
    CCU2D add_176_23 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5020), .COUT(n5021), .S0(n291), 
          .S1(n290));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_23.INIT0 = 16'h5aaa;
    defparam add_176_23.INIT1 = 16'h5aaa;
    defparam add_176_23.INJECT1_0 = "NO";
    defparam add_176_23.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_69_3_lut_2_lut (.A(next_state_3__N_485[2]), .B(next_state[0]), 
         .Z(n5709)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;
    defparam i1_2_lut_rep_69_3_lut_2_lut.init = 16'h6666;
    LUT4 i36_3_lut_4_lut (.A(next_state_3__N_485[2]), .B(next_state[0]), 
         .C(next_state[3]), .D(FPIO_isoCtrlRSTn_N_687), .Z(n19)) /* synthesis lut_function=(!(A (C+!(D))+!A !(B (C+(D))+!B !(C+!(D))))) */ ;
    defparam i36_3_lut_4_lut.init = 16'h4f40;
    IB FP_UsrSW2_pad (.I(FP_UsrSW2), .O(FP_UsrSW2_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(21[3:12])
    IB FP_UsrSW1_pad (.I(FP_UsrSW1), .O(FP_UsrSW1_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(20[3:12])
    IB FlexIO03_pad (.I(FlexIO03), .O(FlexIO03_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(17[3:11])
    CCU2D add_2587_6 (.A0(\debounce_counters[4] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5072), .COUT(n5073));
    defparam add_2587_6.INIT0 = 16'h5555;
    defparam add_2587_6.INIT1 = 16'h5aaa;
    defparam add_2587_6.INJECT1_0 = "NO";
    defparam add_2587_6.INJECT1_1 = "NO";
    LUT4 i6_2_lut (.A(FP_UsrSW2_c), .B(FlexIO03_c), .Z(n70)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i6_2_lut.init = 16'h8888;
    IB FlexIO04_pad (.I(FlexIO04), .O(FlexIO04_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(16[3:11])
    OB Carrier_PwrOn_pad (.I(Carrier_PwrOn_c), .O(Carrier_PwrOn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(93[9:22])
    OB DIGS3C_SlotD_SlotOE_pad_1 (.I(DIGS3C_SlotD_SlotOE_c_1), .O(DIGS3C_SlotD_SlotOE[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(90[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_2 (.I(DIGS3C_SlotD_SlotOE_c_2), .O(DIGS3C_SlotD_SlotOE[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(90[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_3 (.I(DIGS3C_SlotD_SlotOE_c_3), .O(DIGS3C_SlotD_SlotOE[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(90[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_4 (.I(DIGS3C_SlotD_SlotOE_c_4), .O(DIGS3C_SlotD_SlotOE[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(90[3:22])
    FD1P3IX debounce_counters_4___i14 (.D(n510), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i13 (.D(n511), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i13.GSR = "ENABLED";
    OB DIGS3C_SlotD_SlotOE_pad_5 (.I(DIGS3C_SlotD_SlotOE_c_5), .O(DIGS3C_SlotD_SlotOE[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(90[3:22])
    OB ANL_S3C_CarrierReady_pad (.I(GND_net), .O(ANL_S3C_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(88[3:23])
    CCU2D add_176_21 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5019), .COUT(n5020), .S0(n293), 
          .S1(n292));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_21.INIT0 = 16'h5aaa;
    defparam add_176_21.INIT1 = 16'h5aaa;
    defparam add_176_21.INJECT1_0 = "NO";
    defparam add_176_21.INJECT1_1 = "NO";
    OB FlexMio61ExternalStop_pad (.I(FlexMio61ExternalStop_c_c), .O(FlexMio61ExternalStop));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(59[3:24])
    OB FlexMIOs53_GPIO_PowerDown_pad (.I(FlexMIOs53_GPIO_PowerDown_c), .O(FlexMIOs53_GPIO_PowerDown));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(57[3:28])
    LUT4 i2938_4_lut_else_3_lut (.A(next_state[2]), .B(next_state[3]), .C(next_state_3__N_485[2]), 
         .D(next_state[0]), .Z(n5724)) /* synthesis lut_function=(A (B)+!A !(B+(C (D)+!C !(D)))) */ ;
    defparam i2938_4_lut_else_3_lut.init = 16'h8998;
    OB SD_SEL_pad (.I(GND_net), .O(SD_SEL));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(54[3:9])
    LUT4 i1_3_lut_4_lut (.A(next_state[3]), .B(next_state_3__N_485[2]), 
         .C(signals_debounced_syn[3]), .D(externstop_falling), .Z(n3971)) /* synthesis lut_function=(!(A (B (D)+!B (C+(D)))+!A (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam i1_3_lut_4_lut.init = 16'h008f;
    OB DIGS3C_Shared_ReqSafeState_pad (.I(DIGS3C_Shared_ReqSafeState_c), .O(DIGS3C_Shared_ReqSafeState));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(46[3:29])
    OB DIGS3C_Shared_CarrierReady_pad (.I(GND_net), .O(DIGS3C_Shared_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(45[3:29])
    OB FP_UsrLED_pad_1 (.I(GND_net), .O(FP_UsrLED[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(44[3:12])
    OB FP_UsrLED_pad_2 (.I(GND_net), .O(FP_UsrLED[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(44[3:12])
    OB FP_UsrLED_pad_3 (.I(GND_net), .O(FP_UsrLED[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(44[3:12])
    OB FP_UsrLED_pad_4 (.I(GND_net), .O(FP_UsrLED[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(44[3:12])
    OB FP_SysLEDs_pad (.I(FP_SysLEDs_c), .O(FP_SysLEDs));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(40[3:13])
    OBZ n3107_pad (.I(GND_net), .T(n3108), .O(Carrier_PG_1V8));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(244[1] 425[13])
    OB FPIO_FlexMIO52_pad (.I(FPIO_FlexMIO52_c_c), .O(FPIO_FlexMIO52));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(35[3:17])
    OB Carrier_PG_3V3_pad (.I(Carrier_PG_3V3_c), .O(Carrier_PG_3V3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(29[3:17])
    OB FPIO_isoCtrlRSTn_pad (.I(FPIO_isoCtrlRSTn_c), .O(FPIO_isoCtrlRSTn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(27[3:19])
    OB FlexIO01_pad (.I(GND_net), .O(FlexIO01));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(19[3:11])
    OB FlexIO02_pad (.I(GND_net), .O(FlexIO02));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(18[3:11])
    OB FlexIO05_pad (.I(GND_net), .O(FlexIO05));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(15[3:11])
    OB FP_SysLEDb_pad (.I(FP_SysLEDb_c), .O(FP_SysLEDb));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(14[3:13])
    OB FP_SysLEDr_pad (.I(FP_SysLEDr_c), .O(FP_SysLEDr));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(13[3:13])
    OB FP_SysLEDg_pad (.I(FP_SysLEDg_c), .O(FP_SysLEDg));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(12[3:13])
    FD1P3IX debounce_counters_4___i12 (.D(n512), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i12.GSR = "ENABLED";
    BB DIG5S3C27_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C27), .O(DIG5S3C27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_4___i11 (.D(n513), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i11.GSR = "ENABLED";
    BB DIG5S3C28_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C28), .O(DIG5S3C28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_4___i10 (.D(n514), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i10.GSR = "ENABLED";
    BB DIG5S3C29_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C29), .O(DIG5S3C29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_4___i9 (.D(n515), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i9.GSR = "ENABLED";
    BB DIG5S3C01_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C01), .O(DIG5S3C01_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_4___i8 (.D(n516), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i8.GSR = "ENABLED";
    BB DIG5S3C02_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C02), .O(DIG5S3C02_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_4___i7 (.D(n517), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i7.GSR = "ENABLED";
    BB DIG5S3C00_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C00), .O(DIG5S3C00_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_4___i6 (.D(n518), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i6.GSR = "ENABLED";
    BB DIG5S3C05_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C05), .O(DIG5S3C05_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_4___i5 (.D(n519), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i5.GSR = "ENABLED";
    BB DIG5S3C04_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C04), .O(DIG5S3C04_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_4___i4 (.D(n520), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i4.GSR = "ENABLED";
    BB DIG5S3C03_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C03), .O(DIG5S3C03_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    BB FPIO_FlexMIO28_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO28), 
       .O(FPIO_FlexMIO28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_4___i3 (.D(n521), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i3.GSR = "ENABLED";
    BB FlexMIOs32_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs32), .O(FlexMIOs32_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3AX i365_395 (.D(Carrier_PG_1V8_N_781), .SP(Carrier_PG_1V8_N_774), 
            .CK(clk), .Q(Carrier_PG_1V8_N_693));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam i365_395.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i2 (.D(n522), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i2.GSR = "ENABLED";
    BB FlexMIOs33_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs33), .O(FlexMIOs33_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_4___i1 (.D(n523), .SP(clk_enable_46), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_4___i1.GSR = "ENABLED";
    BB FlexMIOs34_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs34), .O(FlexMIOs34_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i31 (.D(n387), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i31.GSR = "ENABLED";
    BB FlexMIOs35_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs35), .O(FlexMIOs35_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i30 (.D(n388), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i30.GSR = "ENABLED";
    BB FlexMIOs36_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs36), .O(FlexMIOs36_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i29 (.D(n389), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i29.GSR = "ENABLED";
    BB FlexMIOs37_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs37), .O(FlexMIOs37_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i28 (.D(n390), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i28.GSR = "ENABLED";
    BB FlexMIOs26_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs26), .O(FlexMIOs26_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i27 (.D(n391), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i27.GSR = "ENABLED";
    BB FlexMIOs27_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs27), .O(FlexMIOs27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i26 (.D(n392), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i26.GSR = "ENABLED";
    BB FlexMIOs28_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs28), .O(FlexMIOs28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i25 (.D(n393), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i25.GSR = "ENABLED";
    BB FlexMIOs29_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs29), .O(FlexMIOs29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i24 (.D(n394), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i24.GSR = "ENABLED";
    BB FlexMIOs30_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs30), .O(FlexMIOs30_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i23 (.D(n395), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i23.GSR = "ENABLED";
    BB FlexMIOs31_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs31), .O(FlexMIOs31_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i22 (.D(n396), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i22.GSR = "ENABLED";
    BB FlexMIOs63_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs63), .O(FlexMIOs63_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i21 (.D(n397), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i21.GSR = "ENABLED";
    BB FlexMIOs62_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs62), .O(FlexMIOs62_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i20 (.D(n398), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i20.GSR = "ENABLED";
    BB FlexMIOs54_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs54), .O(FlexMIOs54_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i19 (.D(n399), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i19.GSR = "ENABLED";
    BB DIG5S3C24_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C24), .O(DIG5S3C24_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i18 (.D(n400), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i18.GSR = "ENABLED";
    BB DIG5S3C25_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C25), .O(DIG5S3C25_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i17 (.D(n401), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i17.GSR = "ENABLED";
    BB DIG5S3C26_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C26), .O(DIG5S3C26_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i16 (.D(n402), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i16.GSR = "ENABLED";
    BB FPIO_FlexMIO29_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO29), 
       .O(FPIO_FlexMIO29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i15 (.D(n403), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i15.GSR = "ENABLED";
    BB FPIO_FlexMIO30_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO30), 
       .O(FPIO_FlexMIO30_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i14 (.D(n404), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i14.GSR = "ENABLED";
    BB FPIO_FlexMIO27_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO27), 
       .O(FPIO_FlexMIO27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(191[1:17])
    FD1P3IX debounce_counters_3___i13 (.D(n405), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i13.GSR = "ENABLED";
    LUT4 i1_2_lut_rep_70 (.A(externstop_falling), .B(signals_debounced_syn[4]), 
         .Z(n5710)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam i1_2_lut_rep_70.init = 16'hbbbb;
    FD1P3IX debounce_counters_3___i12 (.D(n406), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i11 (.D(n407), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i10 (.D(n408), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i9 (.D(n409), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i9.GSR = "ENABLED";
    LUT4 mux_604_i21_4_lut (.A(next_state[1]), .B(n1685), .C(n2563), .D(n2559), 
         .Z(n2461)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_604_i21_4_lut.init = 16'hf5c5;
    FD1P3IX debounce_counters_3___i8 (.D(n410), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i7 (.D(n411), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i7.GSR = "ENABLED";
    LUT4 i44_4_lut (.A(ANL_S3C_SLOTOK_c_3), .B(DIGS3C_SlotD_SlotOK_c_4), 
         .C(DIGS3C_SlotD_SlotOK_c_3), .D(DIG5S3C00_out), .Z(n108)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i44_4_lut.init = 16'h8000;
    LUT4 next_state_2__bdd_4_lut (.A(next_state[3]), .B(next_state[1]), 
         .C(next_state[0]), .D(next_state_3__N_485[2]), .Z(n5748)) /* synthesis lut_function=(!((B (C+(D))+!B !(C))+!A)) */ ;
    defparam next_state_2__bdd_4_lut.init = 16'h2028;
    FD1P3IX debounce_counters_2___i0 (.D(n312), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i0.GSR = "ENABLED";
    CCU2D add_2587_4 (.A0(\debounce_counters[4] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5071), .COUT(n5072));
    defparam add_2587_4.INIT0 = 16'h5555;
    defparam add_2587_4.INIT1 = 16'h5555;
    defparam add_2587_4.INJECT1_0 = "NO";
    defparam add_2587_4.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i6 (.D(n412), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i6.GSR = "ENABLED";
    LUT4 n5639_bdd_3_lut (.A(n5639), .B(n5638), .C(next_state[1]), .Z(clk_enable_132)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam n5639_bdd_3_lut.init = 16'hcaca;
    LUT4 i1781_3_lut (.A(n1695), .B(n2563), .C(n2559), .Z(n2471)) /* synthesis lut_function=(!(A (B (C))+!A (B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i1781_3_lut.init = 16'h3b3b;
    FD1P3IX debounce_counters_3___i5 (.D(n413), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i4 (.D(n414), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i3 (.D(n415), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i2 (.D(n416), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i1 (.D(n417), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i1 (.D(n205), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i1.GSR = "ENABLED";
    LUT4 n1841_bdd_2_lut_3124 (.A(n5666), .B(FPIO_isoCtrlRSTn_N_687), .Z(n5667)) /* synthesis lut_function=(A+!(B)) */ ;
    defparam n1841_bdd_2_lut_3124.init = 16'hbbbb;
    IB SCL_pad (.I(SCL), .O(SCL_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(23[3:6])
    IB SDA_pad (.I(SDA), .O(SDA_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(24[3:6])
    IB FP_UsrSW3_pad (.I(FP_UsrSW3), .O(FP_UsrSW3_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(25[3:12])
    IB SysSW_Pwr_NC_pad (.I(SysSW_Pwr_NC), .O(SysSW_Pwr_NC_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(26[3:15])
    IB FPIO_iosCtrlINTn_pad (.I(FPIO_iosCtrlINTn), .O(FPIO_iosCtrlINTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(28[3:19])
    IB FlexMio61ExternalStop_c_pad (.I(FPIO_ExternalStop), .O(FlexMio61ExternalStop_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(30[3:20])
    IB S3CsI2C_SDA_pad (.I(S3CsI2C_SDA), .O(S3CsI2C_SDA_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(38[3:14])
    IB S3CsI2C_SCL_pad (.I(S3CsI2C_SCL), .O(S3CsI2C_SCL_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(39[3:14])
    IB SD1_CD_pad (.I(SD1_CD), .O(SD1_CD_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(41[3:9])
    IB SD0_CD_pad (.I(SD0_CD), .O(SD0_CD_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(42[3:9])
    IB SPI_S3C_nCS_USR_pad (.I(SPI_S3C_nCS_USR), .O(SPI_S3C_nCS_USR_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(43[3:18])
    IB DIGS3C_SlotD_ReqOE_pad_5 (.I(DIGS3C_SlotD_ReqOE[5]), .O(DIGS3C_SlotD_ReqOE_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(47[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_4 (.I(DIGS3C_SlotD_ReqOE[4]), .O(DIGS3C_SlotD_ReqOE_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(47[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_3 (.I(DIGS3C_SlotD_ReqOE[3]), .O(DIGS3C_SlotD_ReqOE_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(47[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_2 (.I(DIGS3C_SlotD_ReqOE[2]), .O(DIGS3C_SlotD_ReqOE_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(47[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_1 (.I(DIGS3C_SlotD_ReqOE[1]), .O(DIGS3C_SlotD_ReqOE_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(47[3:21])
    IB DIGS3C_SlotD_SlotOK_pad_5 (.I(DIGS3C_SlotD_SlotOK[5]), .O(DIGS3C_SlotD_SlotOK_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(48[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_4 (.I(DIGS3C_SlotD_SlotOK[4]), .O(DIGS3C_SlotD_SlotOK_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(48[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_3 (.I(DIGS3C_SlotD_SlotOK[3]), .O(DIGS3C_SlotD_SlotOK_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(48[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_2 (.I(DIGS3C_SlotD_SlotOK[2]), .O(DIGS3C_SlotD_SlotOK_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(48[3:22])
    IB DIGS3C_SlotD_SlotOK_pad_1 (.I(DIGS3C_SlotD_SlotOK[1]), .O(DIGS3C_SlotD_SlotOK_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(48[3:22])
    IB FlexLIO_pad_5 (.I(FlexLIO[5]), .O(FlexLIO_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(49[3:10])
    IB FlexLIO_pad_4 (.I(FlexLIO[4]), .O(FlexLIO_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(49[3:10])
    IB FlexLIO_pad_3 (.I(FlexLIO[3]), .O(FlexLIO_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(49[3:10])
    IB FlexLIO_pad_2 (.I(FlexLIO[2]), .O(FlexLIO_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(49[3:10])
    IB FlexLIO_pad_1 (.I(FlexLIO[1]), .O(FlexLIO_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(49[3:10])
    IB FlexLIO_pad_0 (.I(FlexLIO[0]), .O(FlexLIO_c_0));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(49[3:10])
    IB FPIO_FlexMIO52_c_pad (.I(FlexMIOs52_PCIe), .O(FPIO_FlexMIO52_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(56[3:18])
    IB FlexMIOs45_pad (.I(FlexMIOs45), .O(FlexMIOs45_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(68[3:13])
    IB ANL_S3C_SLOTOK_pad_3 (.I(ANL_S3C_SLOTOK[3]), .O(ANL_S3C_SLOTOK_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(87[3:17])
    IB ANL_S3C_SLOTOK_pad_2 (.I(ANL_S3C_SLOTOK[2]), .O(ANL_S3C_SLOTOK_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(87[3:17])
    IB ANL_S3C_SLOTOK_pad_1 (.I(ANL_S3C_SLOTOK[1]), .O(ANL_S3C_SLOTOK_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(87[3:17])
    IB ANL_S3C_P54_Legacy_pad (.I(ANL_S3C_P54_Legacy), .O(ANL_S3C_P54_Legacy_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(89[3:21])
    IB PG_VIN_pad (.I(PG_VIN), .O(PG_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(94[3:9])
    IB PPn_VIN_pad (.I(PPn_VIN), .O(PPn_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(95[3:10])
    IB PG_Module_pad (.I(PG_Module), .O(PG_Module_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(96[3:12])
    IB TDnSHDN_pad (.I(TDnSHDN), .O(TDnSHDN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(97[3:10])
    IB TDnFFnFS_pad (.I(TDnFFnFS), .O(TDnFFnFS_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(98[3:11])
    IB TDnALERT_pad (.I(TDnALERT), .O(TDnALERT_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(99[3:11])
    IB S3C_S1_pad (.I(S3C_S1), .O(S3C_S1_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(100[3:9])
    CCU2D add_2590_10 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4985), .COUT(n4986));
    defparam add_2590_10.INIT0 = 16'h5555;
    defparam add_2590_10.INIT1 = 16'h5555;
    defparam add_2590_10.INJECT1_0 = "NO";
    defparam add_2590_10.INJECT1_1 = "NO";
    CCU2D add_2587_2 (.A0(\debounce_counters[4] [7]), .B0(\debounce_counters[4] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[4] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n5071));
    defparam add_2587_2.INIT0 = 16'h1000;
    defparam add_2587_2.INIT1 = 16'h5aaa;
    defparam add_2587_2.INJECT1_0 = "NO";
    defparam add_2587_2.INJECT1_1 = "NO";
    CCU2D add_2590_8 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4984), .COUT(n4985));
    defparam add_2590_8.INIT0 = 16'h5555;
    defparam add_2590_8.INIT1 = 16'h5aaa;
    defparam add_2590_8.INJECT1_0 = "NO";
    defparam add_2590_8.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_1___i2 (.D(n204), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i3 (.D(n203), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i4 (.D(n202), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i5 (.D(n201), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i6 (.D(n200), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i7 (.D(n199), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i8 (.D(n198), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i9 (.D(n197), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i10 (.D(n196), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i11 (.D(n195), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i12 (.D(n194), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i13 (.D(n193), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i14 (.D(n192), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i15 (.D(n191), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i16 (.D(n190), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i17 (.D(n189), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i18 (.D(n188), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i19 (.D(n187), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i20 (.D(n186), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i21 (.D(n185), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i22 (.D(n184), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i23 (.D(n183), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i24 (.D(n182), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i25 (.D(n181), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i26 (.D(n180), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i27 (.D(n179), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i28 (.D(n178), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i29 (.D(n177), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i30 (.D(n176), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i31 (.D(n175), .SP(clk_enable_109), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_1___i31.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn2_i2 (.D(debounce_inputs_asyn1[2]), .CK(clk), 
            .Q(debounce_inputs_asyn2[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_inputs_asyn2_i2.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn2_i3 (.D(debounce_inputs_asyn1[3]), .CK(clk), 
            .Q(debounce_inputs_asyn2[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_inputs_asyn2_i3.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn2_i4 (.D(debounce_inputs_asyn1[4]), .CK(clk), 
            .Q(debounce_inputs_asyn2[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_inputs_asyn2_i4.GSR = "ENABLED";
    FD1P3IX pushed_i2 (.D(n5922), .SP(clk_enable_110), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(pushed[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam pushed_i2.GSR = "ENABLED";
    FD1P3IX pushed_i3 (.D(n5922), .SP(clk_enable_111), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(pushed[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam pushed_i3.GSR = "ENABLED";
    FD1P3IX pushed_i4 (.D(n5922), .SP(clk_enable_112), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(pushed[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam pushed_i4.GSR = "ENABLED";
    FD1S3AY signals_debounced_syn_i2 (.D(pushed_2__N_262), .CK(clk), .Q(signals_debounced_syn[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam signals_debounced_syn_i2.GSR = "ENABLED";
    FD1S3AY signals_debounced_syn_i3 (.D(pushed_3__N_260), .CK(clk), .Q(signals_debounced_syn[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam signals_debounced_syn_i3.GSR = "ENABLED";
    FD1S3AY signals_debounced_syn_i4 (.D(pushed_4__N_258), .CK(clk), .Q(signals_debounced_syn[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam signals_debounced_syn_i4.GSR = "ENABLED";
    LUT4 next_state_2__bdd_4_lut_3040 (.A(next_state[3]), .B(n5920), .C(FPIO_isoCtrlRSTn_N_687), 
         .D(next_state[0]), .Z(n5637)) /* synthesis lut_function=(A (D)+!A !(B+(C+!(D)))) */ ;
    defparam next_state_2__bdd_4_lut_3040.init = 16'hab00;
    CCU2D add_176_19 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5018), .COUT(n5019), .S0(n295), 
          .S1(n294));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_19.INIT0 = 16'h5aaa;
    defparam add_176_19.INIT1 = 16'h5aaa;
    defparam add_176_19.INJECT1_0 = "NO";
    defparam add_176_19.INJECT1_1 = "NO";
    CCU2D add_176_17 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5017), .COUT(n5018), .S0(n297), 
          .S1(n296));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_17.INIT0 = 16'h5aaa;
    defparam add_176_17.INIT1 = 16'h5aaa;
    defparam add_176_17.INJECT1_0 = "NO";
    defparam add_176_17.INJECT1_1 = "NO";
    CCU2D add_176_15 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5016), .COUT(n5017), .S0(n299), 
          .S1(n298));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_15.INIT0 = 16'h5aaa;
    defparam add_176_15.INIT1 = 16'h5aaa;
    defparam add_176_15.INJECT1_0 = "NO";
    defparam add_176_15.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_71 (.A(next_state[0]), .B(next_state_3__N_485[2]), 
         .Z(n5711)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i1_2_lut_rep_71.init = 16'h4444;
    LUT4 mux_613_i23_4_lut (.A(n1683), .B(n5718), .C(n2565), .D(n5700), 
         .Z(n2493)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_613_i23_4_lut.init = 16'h303a;
    LUT4 n3450_bdd_3_lut_3050_4_lut (.A(next_state[0]), .B(next_state_3__N_485[2]), 
         .C(next_state[3]), .D(next_state[2]), .Z(n5639)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)+!C !(D))+!B (C (D)))) */ ;
    defparam n3450_bdd_3_lut_3050_4_lut.init = 16'hf004;
    LUT4 mux_613_i24_4_lut (.A(n1682), .B(n5718), .C(n2565), .D(n5700), 
         .Z(n2492)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_613_i24_4_lut.init = 16'h303a;
    FD1P3IX counter_i0_i3 (.D(n1702), .SP(clk_enable_141), .CD(n3525), 
            .CK(clk), .Q(counter[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i3.GSR = "ENABLED";
    CCU2D add_423_25 (.A0(counter[23]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[24]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5069), .S0(n1682), .S1(n1681));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(405[17:24])
    defparam add_423_25.INIT0 = 16'h5555;
    defparam add_423_25.INIT1 = 16'h5555;
    defparam add_423_25.INJECT1_0 = "NO";
    defparam add_423_25.INJECT1_1 = "NO";
    CCU2D add_423_23 (.A0(counter[21]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[22]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5068), .COUT(n5069), .S0(n1684), .S1(n1683));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(405[17:24])
    defparam add_423_23.INIT0 = 16'h5555;
    defparam add_423_23.INIT1 = 16'h5555;
    defparam add_423_23.INJECT1_0 = "NO";
    defparam add_423_23.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i11 (.D(n2470), .SP(clk_enable_141), .CD(n3534), 
            .CK(clk), .Q(counter[11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i11.GSR = "ENABLED";
    PFUMX i3041 (.BLUT(n5674), .ALUT(n5673), .C0(next_state[1]), .Z(n5675));
    CCU2D add_176_13 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5015), .COUT(n5016), .S0(n301), 
          .S1(n300));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_13.INIT0 = 16'h5aaa;
    defparam add_176_13.INIT1 = 16'h5aaa;
    defparam add_176_13.INJECT1_0 = "NO";
    defparam add_176_13.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i2 (.D(n1703), .SP(clk_enable_141), .CD(n3525), 
            .CK(clk), .Q(counter[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i2.GSR = "ENABLED";
    FD1P3AX FP_SysLEDr_384 (.D(FP_SysLEDr_N_681), .SP(clk_enable_116), .CK(clk), 
            .Q(FP_SysLEDr_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam FP_SysLEDr_384.GSR = "ENABLED";
    FD1P3IX counter_i0_i1 (.D(n1704), .SP(clk_enable_141), .CD(n3525), 
            .CK(clk), .Q(counter[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i1.GSR = "ENABLED";
    LUT4 FPIO_isoCtrlRSTn_N_687_bdd_3_lut_3076 (.A(n3971), .B(next_state[1]), 
         .C(next_state[0]), .Z(n5744)) /* synthesis lut_function=(!((B (C)+!B !(C))+!A)) */ ;
    defparam FPIO_isoCtrlRSTn_N_687_bdd_3_lut_3076.init = 16'h2828;
    FD1S3AY debounce_inputs_asyn1_i2 (.D(FlexMio61ExternalStop_c_c), .CK(clk), 
            .Q(debounce_inputs_asyn1[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_inputs_asyn1_i2.GSR = "ENABLED";
    CCU2D add_423_21 (.A0(counter[19]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[20]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5067), .COUT(n5068), .S0(n1686), .S1(n1685));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(405[17:24])
    defparam add_423_21.INIT0 = 16'h5555;
    defparam add_423_21.INIT1 = 16'h5555;
    defparam add_423_21.INJECT1_0 = "NO";
    defparam add_423_21.INJECT1_1 = "NO";
    LUT4 mux_613_i25_4_lut (.A(n1681), .B(n5718), .C(n2565), .D(n5700), 
         .Z(n2491)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_613_i25_4_lut.init = 16'h303a;
    CCU2D add_423_19 (.A0(counter[17]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[18]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5066), .COUT(n5067), .S0(n1688), .S1(n1687));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(405[17:24])
    defparam add_423_19.INIT0 = 16'h5555;
    defparam add_423_19.INIT1 = 16'h5555;
    defparam add_423_19.INJECT1_0 = "NO";
    defparam add_423_19.INJECT1_1 = "NO";
    CCU2D add_176_11 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5014), .COUT(n5015), .S0(n303), 
          .S1(n302));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_11.INIT0 = 16'h5aaa;
    defparam add_176_11.INIT1 = 16'h5aaa;
    defparam add_176_11.INJECT1_0 = "NO";
    defparam add_176_11.INJECT1_1 = "NO";
    FD1S3AY debounce_inputs_asyn1_i3 (.D(FP_UsrSW3_c), .CK(clk), .Q(debounce_inputs_asyn1[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_inputs_asyn1_i3.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn1_i4 (.D(FP_UsrSW1_c), .CK(clk), .Q(debounce_inputs_asyn1[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_inputs_asyn1_i4.GSR = "ENABLED";
    LUT4 i1_2_lut_rep_64_3_lut (.A(next_state[0]), .B(next_state_3__N_485[2]), 
         .C(next_state[1]), .Z(n5704)) /* synthesis lut_function=(!(A+((C)+!B))) */ ;
    defparam i1_2_lut_rep_64_3_lut.init = 16'h0404;
    LUT4 i1232_3_lut_4_lut (.A(n2559), .B(n2563), .C(n2565), .D(clk_enable_141), 
         .Z(n3525)) /* synthesis lut_function=(A (D)+!A (B (C (D))+!B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i1232_3_lut_4_lut.init = 16'hfb00;
    LUT4 i2950_2_lut_3_lut_4_lut (.A(n2563), .B(n2565), .C(n5441), .D(n74), 
         .Z(n4115)) /* synthesis lut_function=(!(A (((D)+!C)+!B)+!A ((D)+!C))) */ ;
    defparam i2950_2_lut_3_lut_4_lut.init = 16'h00d0;
    LUT4 next_state_3__bdd_2_lut_3053_4_lut (.A(n5703), .B(n5709), .C(next_state[1]), 
         .D(next_state[3]), .Z(n5668)) /* synthesis lut_function=(!(A (B (D)+!B !(C+!(D)))+!A (B (C (D))))) */ ;
    defparam next_state_3__bdd_2_lut_3053_4_lut.init = 16'h35ff;
    FD1P3AX next_state_i3 (.D(next_state_3__N_31[3]), .SP(clk_enable_118), 
            .CK(clk), .Q(next_state[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam next_state_i3.GSR = "ENABLED";
    FD1P3AX next_state_i2 (.D(next_state_3__N_31[2]), .SP(clk_enable_119), 
            .CK(clk), .Q(next_state[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam next_state_i2.GSR = "ENABLED";
    LUT4 i2935_4_lut (.A(n30), .B(next_state[2]), .C(n5386), .D(n33), 
         .Z(clk_enable_121)) /* synthesis lut_function=(A (B (C)+!B !((D)+!C))+!A (B+!(D))) */ ;
    defparam i2935_4_lut.init = 16'hc4f5;
    LUT4 i1_4_lut_4_lut_adj_1 (.A(next_state[0]), .B(next_state[1]), .C(next_state[2]), 
         .D(next_state[3]), .Z(clk_enable_21)) /* synthesis lut_function=(A (B+(C+!(D)))+!A (B+((D)+!C))) */ ;
    defparam i1_4_lut_4_lut_adj_1.init = 16'hfdef;
    LUT4 i1_4_lut_4_lut_4_lut (.A(next_state[0]), .B(next_state[2]), .C(FPIO_isoCtrlRSTn_N_687), 
         .D(n5708), .Z(n57)) /* synthesis lut_function=(!(A (C)+!A !(B (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i1_4_lut_4_lut_4_lut.init = 16'h4e0a;
    LUT4 i1239_2_lut_3_lut (.A(n5441), .B(n74), .C(n2565), .Z(n3534)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam i1239_2_lut_3_lut.init = 16'h2020;
    CCU2D add_423_17 (.A0(counter[15]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[16]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5065), .COUT(n5066), .S0(n1690), .S1(n1689));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(405[17:24])
    defparam add_423_17.INIT0 = 16'h5555;
    defparam add_423_17.INIT1 = 16'h5555;
    defparam add_423_17.INJECT1_0 = "NO";
    defparam add_423_17.INJECT1_1 = "NO";
    FD1P3AX FlexMIOs53_GPIO_PowerDown_383 (.D(FlexMIOs53_GPIO_PowerDown_N_697), 
            .SP(clk_enable_120), .CK(clk), .Q(FlexMIOs53_GPIO_PowerDown_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam FlexMIOs53_GPIO_PowerDown_383.GSR = "ENABLED";
    FD1P3AX next_state_i1 (.D(next_state_3__N_31[1]), .SP(clk_enable_121), 
            .CK(clk), .Q(next_state[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam next_state_i1.GSR = "ENABLED";
    LUT4 i23_4_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_485[2]), 
         .C(next_state[1]), .D(FPIO_isoCtrlRSTn_N_687), .Z(n10)) /* synthesis lut_function=(A (C)+!A !(B+(C+(D)))) */ ;
    defparam i23_4_lut_4_lut.init = 16'ha0a1;
    LUT4 i2941_4_lut_4_lut (.A(n5701), .B(n3499), .C(n4_adj_2), .D(n5716), 
         .Z(clk_enable_119)) /* synthesis lut_function=(!(A+(B (C)+!B (C+!(D))))) */ ;
    defparam i2941_4_lut_4_lut.init = 16'h0504;
    LUT4 i2_3_lut_3_lut (.A(next_state[1]), .B(FPIO_isoCtrlRSTn_N_687), 
         .C(next_state_3__N_485[2]), .Z(n3499)) /* synthesis lut_function=(!(A (B)+!A (C))) */ ;
    defparam i2_3_lut_3_lut.init = 16'h2727;
    FD1P3IX counter_i0_i21 (.D(n2394), .SP(clk_enable_141), .CD(n4115), 
            .CK(clk), .Q(counter[21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i21.GSR = "ENABLED";
    LUT4 i53_4_lut_4_lut_then_2_lut (.A(next_state_3__N_485[2]), .B(next_state[1]), 
         .Z(n5728)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i53_4_lut_4_lut_then_2_lut.init = 16'h4444;
    LUT4 i54_3_lut_4_lut (.A(next_state[1]), .B(FPIO_isoCtrlRSTn_N_687), 
         .C(next_state[3]), .D(n5729), .Z(n33)) /* synthesis lut_function=(A (B ((D)+!C)+!B (C (D)))+!A (C (D))) */ ;
    defparam i54_3_lut_4_lut.init = 16'hf808;
    LUT4 i1_4_lut_4_lut_adj_2 (.A(next_state[0]), .B(next_state_3__N_485[2]), 
         .C(next_state[1]), .D(n5713), .Z(n3922)) /* synthesis lut_function=(!(A (C+!(D))+!A (B+!(C (D))))) */ ;
    defparam i1_4_lut_4_lut_adj_2.init = 16'h1a00;
    LUT4 i53_4_lut_4_lut_else_2_lut (.A(next_state_3__N_485[2]), .B(externstop_falling), 
         .C(signals_debounced_syn[4]), .D(next_state[1]), .Z(n5727)) /* synthesis lut_function=(A (B (D)+!B (C+(D)))) */ ;
    defparam i53_4_lut_4_lut_else_2_lut.init = 16'haa20;
    LUT4 next_state_1__bdd_4_lut_3018 (.A(next_state[1]), .B(next_state[0]), 
         .C(next_state[3]), .D(next_state[2]), .Z(clk_enable_116)) /* synthesis lut_function=(A+(B ((D)+!C)+!B (C+!(D)))) */ ;
    defparam next_state_1__bdd_4_lut_3018.init = 16'hfebf;
    LUT4 i1_3_lut_4_lut_adj_3 (.A(next_state[1]), .B(n5711), .C(next_state[2]), 
         .D(externstop_falling), .Z(n11)) /* synthesis lut_function=(A (C)+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i1_3_lut_4_lut_adj_3.init = 16'hf4f0;
    LUT4 i2954_2_lut (.A(n5441), .B(n74), .Z(clk_enable_141)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i2954_2_lut.init = 16'h2222;
    LUT4 i2952_4_lut (.A(n4059), .B(n5704), .C(next_state[2]), .D(externstop_falling), 
         .Z(n5441)) /* synthesis lut_function=(A ((C+(D))+!B)+!A !(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i2952_4_lut.init = 16'hbbb3;
    LUT4 i3_4_lut_rep_61 (.A(FPIO_isoCtrlRSTn_N_687), .B(n5717), .C(next_state[2]), 
         .D(n5386), .Z(n5701)) /* synthesis lut_function=(!((B+((D)+!C))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam i3_4_lut_rep_61.init = 16'h0020;
    LUT4 i55_4_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_485[2]), 
         .C(next_state[2]), .D(FPIO_isoCtrlRSTn_N_687), .Z(n30)) /* synthesis lut_function=(!(A ((C)+!B)+!A (B (C)+!B !(C (D))))) */ ;
    defparam i55_4_lut_4_lut.init = 16'h1c0c;
    LUT4 i1_3_lut_4_lut_adj_4 (.A(next_state[1]), .B(n5713), .C(next_state[0]), 
         .D(next_state_3__N_485[2]), .Z(n5328)) /* synthesis lut_function=(!(((C (D)+!C !(D))+!B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(113[12:22])
    defparam i1_3_lut_4_lut_adj_4.init = 16'h0880;
    CCU2D add_176_9 (.A0(\debounce_counters[2] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5013), .COUT(n5014), .S0(n305), 
          .S1(n304));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_9.INIT0 = 16'h5aaa;
    defparam add_176_9.INIT1 = 16'h5aaa;
    defparam add_176_9.INJECT1_0 = "NO";
    defparam add_176_9.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i17 (.D(n2464), .SP(clk_enable_141), .CD(n3534), 
            .CK(clk), .Q(counter[17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i17.GSR = "ENABLED";
    CCU2D add_176_7 (.A0(\debounce_counters[2] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5012), .COUT(n5013), .S0(n307), 
          .S1(n306));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_7.INIT0 = 16'h5aaa;
    defparam add_176_7.INIT1 = 16'h5aaa;
    defparam add_176_7.INJECT1_0 = "NO";
    defparam add_176_7.INJECT1_1 = "NO";
    CCU2D add_423_15 (.A0(counter[13]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[14]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5064), .COUT(n5065), .S0(n1692), .S1(n1691));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(405[17:24])
    defparam add_423_15.INIT0 = 16'h5555;
    defparam add_423_15.INIT1 = 16'h5555;
    defparam add_423_15.INJECT1_0 = "NO";
    defparam add_423_15.INJECT1_1 = "NO";
    LUT4 mux_424_Mux_3_i15_4_lut (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[3]), .D(next_state[2]), .Z(FP_SysLEDs_N_694)) /* synthesis lut_function=(!(A (B (C)+!B (C (D)))+!A (B+(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_424_Mux_3_i15_4_lut.init = 16'h0b3b;
    CCU2D add_423_13 (.A0(counter[11]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[12]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5063), .COUT(n5064), .S0(n1694), .S1(n1693));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(405[17:24])
    defparam add_423_13.INIT0 = 16'h5555;
    defparam add_423_13.INIT1 = 16'h5555;
    defparam add_423_13.INJECT1_0 = "NO";
    defparam add_423_13.INJECT1_1 = "NO";
    CCU2D add_2590_6 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4983), .COUT(n4984));
    defparam add_2590_6.INIT0 = 16'h5555;
    defparam add_2590_6.INIT1 = 16'h5aaa;
    defparam add_2590_6.INJECT1_0 = "NO";
    defparam add_2590_6.INJECT1_1 = "NO";
    CCU2D add_2590_4 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4982), .COUT(n4983));
    defparam add_2590_4.INIT0 = 16'h5555;
    defparam add_2590_4.INIT1 = 16'h5555;
    defparam add_2590_4.INJECT1_0 = "NO";
    defparam add_2590_4.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_78 (.A(next_state[3]), .B(next_state[2]), .Z(n5718)) /* synthesis lut_function=(A (B)) */ ;
    defparam i1_2_lut_rep_78.init = 16'h8888;
    LUT4 i63_4_lut (.A(n113), .B(n126), .C(n122), .D(n114), .Z(dummy_signal)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i63_4_lut.init = 16'h8000;
    PFUMX i3038 (.BLUT(n5668), .ALUT(n5667), .C0(next_state[2]), .Z(clk_enable_129));
    LUT4 i1815_2_lut (.A(n1684), .B(n2559), .Z(n2394)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i1815_2_lut.init = 16'heeee;
    LUT4 mux_613_i19_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n2565), .D(n2463), .Z(n2497)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_613_i19_3_lut_4_lut.init = 16'h7f70;
    LUT4 i1_2_lut_rep_81 (.A(signals_debounced_syn[2]), .B(extern_connected), 
         .Z(n5920)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam i1_2_lut_rep_81.init = 16'h4444;
    LUT4 mux_604_i18_4_lut (.A(next_state[1]), .B(n1688), .C(n2563), .D(n2559), 
         .Z(n2464)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_604_i18_4_lut.init = 16'hf5c5;
    LUT4 i1_2_lut_rep_63_3_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_485[2]), 
         .C(signals_debounced_syn[4]), .D(externstop_falling), .Z(n5703)) /* synthesis lut_function=(!(A+(((D)+!C)+!B))) */ ;
    defparam i1_2_lut_rep_63_3_lut_4_lut.init = 16'h0040;
    CCU2D add_423_11 (.A0(counter[9]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[10]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5062), .COUT(n5063), .S0(n1696), .S1(n1695));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(405[17:24])
    defparam add_423_11.INIT0 = 16'h5555;
    defparam add_423_11.INIT1 = 16'h5555;
    defparam add_423_11.INJECT1_0 = "NO";
    defparam add_423_11.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_485[2]), 
         .C(n5713), .D(next_state[1]), .Z(n5329)) /* synthesis lut_function=(!(A+!(B (C (D))))) */ ;
    defparam i1_2_lut_3_lut_4_lut.init = 16'h4000;
    LUT4 i49_4_lut (.A(TDnALERT_c), .B(n98), .C(n66), .D(FlexIO04_c), 
         .Z(n113)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i49_4_lut.init = 16'h8000;
    CCU2D add_176_5 (.A0(\debounce_counters[2] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5011), .COUT(n5012), .S0(n309), 
          .S1(n308));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_5.INIT0 = 16'h5aaa;
    defparam add_176_5.INIT1 = 16'h5aaa;
    defparam add_176_5.INJECT1_0 = "NO";
    defparam add_176_5.INJECT1_1 = "NO";
    CCU2D add_423_9 (.A0(counter[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[8]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5061), .COUT(n5062), .S0(n1698), .S1(n1697));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(405[17:24])
    defparam add_423_9.INIT0 = 16'h5555;
    defparam add_423_9.INIT1 = 16'h5555;
    defparam add_423_9.INJECT1_0 = "NO";
    defparam add_423_9.INJECT1_1 = "NO";
    CCU2D add_176_3 (.A0(\debounce_counters[2] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5010), .COUT(n5011), .S0(n311), 
          .S1(n310));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_3.INIT0 = 16'h5aaa;
    defparam add_176_3.INIT1 = 16'h5aaa;
    defparam add_176_3.INJECT1_0 = "NO";
    defparam add_176_3.INJECT1_1 = "NO";
    CCU2D add_423_7 (.A0(counter[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5060), .COUT(n5061), .S0(n1700), .S1(n1699));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(405[17:24])
    defparam add_423_7.INIT0 = 16'h5555;
    defparam add_423_7.INIT1 = 16'h5555;
    defparam add_423_7.INJECT1_0 = "NO";
    defparam add_423_7.INJECT1_1 = "NO";
    CCU2D add_423_5 (.A0(counter[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5059), .COUT(n5060), .S0(n1702), .S1(n1701));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(405[17:24])
    defparam add_423_5.INIT0 = 16'h5555;
    defparam add_423_5.INIT1 = 16'h5555;
    defparam add_423_5.INJECT1_0 = "NO";
    defparam add_423_5.INJECT1_1 = "NO";
    LUT4 i62_4_lut (.A(n105), .B(n124), .C(n118), .D(n106), .Z(n126)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i62_4_lut.init = 16'h8000;
    CCU2D add_423_3 (.A0(counter[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5058), .COUT(n5059), .S0(n1704), .S1(n1703));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(405[17:24])
    defparam add_423_3.INIT0 = 16'h5555;
    defparam add_423_3.INIT1 = 16'h5555;
    defparam add_423_3.INJECT1_0 = "NO";
    defparam add_423_3.INJECT1_1 = "NO";
    LUT4 i58_4_lut (.A(n73), .B(n116), .C(n102), .D(n74_adj_3), .Z(n122)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i58_4_lut.init = 16'h8000;
    LUT4 i50_4_lut (.A(DIG5S3C29_out), .B(n100), .C(n70), .D(FPIO_FlexMIO30_out), 
         .Z(n114)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i50_4_lut.init = 16'h8000;
    CCU2D add_423_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n5058), .S1(n1705));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(405[17:24])
    defparam add_423_1.INIT0 = 16'hF000;
    defparam add_423_1.INIT1 = 16'h5555;
    defparam add_423_1.INJECT1_0 = "NO";
    defparam add_423_1.INJECT1_1 = "NO";
    LUT4 i1576_4_lut_3_lut (.A(next_state[1]), .B(next_state[0]), .C(next_state[2]), 
         .Z(n3872)) /* synthesis lut_function=(A (B)+!A !(B+!(C))) */ ;
    defparam i1576_4_lut_3_lut.init = 16'h9898;
    CCU2D add_194_33 (.A0(\debounce_counters[4] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5057), .S0(n493));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_33.INIT0 = 16'h5aaa;
    defparam add_194_33.INIT1 = 16'h0000;
    defparam add_194_33.INJECT1_0 = "NO";
    defparam add_194_33.INJECT1_1 = "NO";
    LUT4 i34_4_lut (.A(SD0_CD_c), .B(SPI_S3C_nCS_USR_c), .C(SDA_c), .D(DIG5S3C03_out), 
         .Z(n98)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i34_4_lut.init = 16'h8000;
    LUT4 i1_3_lut (.A(externstop_falling), .B(next_state_3__N_485[2]), .C(signals_debounced_syn[3]), 
         .Z(n5370)) /* synthesis lut_function=(A+(B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(113[12:22])
    defparam i1_3_lut.init = 16'heaea;
    CCU2D add_194_31 (.A0(\debounce_counters[4] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5056), .COUT(n5057), .S0(n495), 
          .S1(n494));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_31.INIT0 = 16'h5aaa;
    defparam add_194_31.INIT1 = 16'h5aaa;
    defparam add_194_31.INJECT1_0 = "NO";
    defparam add_194_31.INJECT1_1 = "NO";
    LUT4 mux_613_i21_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n2565), .D(n2461), .Z(n2495)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_613_i21_3_lut_4_lut.init = 16'h7f70;
    CCU2D add_194_29 (.A0(\debounce_counters[4] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5055), .COUT(n5056), .S0(n497), 
          .S1(n496));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_29.INIT0 = 16'h5aaa;
    defparam add_194_29.INIT1 = 16'h5aaa;
    defparam add_194_29.INJECT1_0 = "NO";
    defparam add_194_29.INJECT1_1 = "NO";
    LUT4 mux_613_i10_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n2565), .D(n2472), .Z(n2506)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_613_i10_3_lut_4_lut.init = 16'h7f70;
    LUT4 i1782_3_lut (.A(n1690), .B(n2563), .C(n2559), .Z(n2466)) /* synthesis lut_function=(!(A (B (C))+!A (B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i1782_3_lut.init = 16'h3b3b;
    LUT4 i1809_2_lut (.A(n1691), .B(n2559), .Z(n2401)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i1809_2_lut.init = 16'heeee;
    LUT4 i2_2_lut (.A(FlexMIOs35_out), .B(S3C_S1_c), .Z(n66)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i2_2_lut.init = 16'h8888;
    LUT4 mux_613_i20_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n2565), .D(n2462), .Z(n2496)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_613_i20_3_lut_4_lut.init = 16'h7f70;
    CCU2D add_176_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[2] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n5010), .S1(n312));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_176_1.INIT0 = 16'hF000;
    defparam add_176_1.INIT1 = 16'h5555;
    defparam add_176_1.INJECT1_0 = "NO";
    defparam add_176_1.INJECT1_1 = "NO";
    CCU2D add_194_27 (.A0(\debounce_counters[4] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5054), .COUT(n5055), .S0(n499), 
          .S1(n498));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_27.INIT0 = 16'h5aaa;
    defparam add_194_27.INIT1 = 16'h5aaa;
    defparam add_194_27.INJECT1_0 = "NO";
    defparam add_194_27.INJECT1_1 = "NO";
    CCU2D add_194_25 (.A0(\debounce_counters[4] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5053), .COUT(n5054), .S0(n501), 
          .S1(n500));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_25.INIT0 = 16'h5aaa;
    defparam add_194_25.INIT1 = 16'h5aaa;
    defparam add_194_25.INJECT1_0 = "NO";
    defparam add_194_25.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i16 (.D(n2465), .SP(clk_enable_141), .CD(n3534), 
            .CK(clk), .Q(counter[16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i16.GSR = "ENABLED";
    LUT4 i41_4_lut (.A(FlexLIO_c_3), .B(FlexMIOs26_out), .C(FlexLIO_c_5), 
         .D(FlexMIOs29_out), .Z(n105)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i41_4_lut.init = 16'h8000;
    LUT4 mux_604_i14_4_lut (.A(next_state[1]), .B(n1692), .C(n2563), .D(n2559), 
         .Z(n2468)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_604_i14_4_lut.init = 16'hf5c5;
    LUT4 i60_4_lut (.A(n89), .B(n120), .C(n110), .D(n90), .Z(n124)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i60_4_lut.init = 16'h8000;
    LUT4 mux_613_i9_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), .C(n2565), 
         .D(n2473), .Z(n2507)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_613_i9_3_lut_4_lut.init = 16'h7f70;
    LUT4 n3808_bdd_2_lut_2_lut (.A(next_state[3]), .B(next_state[0]), .Z(n5673)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam n3808_bdd_2_lut_2_lut.init = 16'h4444;
    FD1P3IX counter_i0_i0 (.D(n1705), .SP(clk_enable_141), .CD(n3525), 
            .CK(clk), .Q(counter[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i0.GSR = "ENABLED";
    FD1P3IX counter_i0_i15 (.D(n2466), .SP(clk_enable_141), .CD(n3534), 
            .CK(clk), .Q(counter[15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i15.GSR = "ENABLED";
    LUT4 i54_4_lut (.A(FlexMIOs62_out), .B(n108), .C(n86), .D(S3CsI2C_SCL_c), 
         .Z(n118)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i54_4_lut.init = 16'h8000;
    FD1P3IX counter_i0_i14 (.D(n2401), .SP(clk_enable_141), .CD(n4115), 
            .CK(clk), .Q(counter[14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i14.GSR = "ENABLED";
    LUT4 i887_2_lut_rep_60 (.A(n2559), .B(n2563), .Z(n5700)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i887_2_lut_rep_60.init = 16'hbbbb;
    FD1P3IX counter_i0_i13 (.D(n2468), .SP(clk_enable_141), .CD(n3534), 
            .CK(clk), .Q(counter[13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i13.GSR = "ENABLED";
    FD1P3AX next_state_i0 (.D(next_state_3__N_31[0]), .SP(clk_enable_129), 
            .CK(clk), .Q(next_state[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam next_state_i0.GSR = "ENABLED";
    LUT4 i2_3_lut_4_lut_4_lut (.A(next_state[3]), .B(n5714), .C(n5712), 
         .D(externstop_falling), .Z(n5366)) /* synthesis lut_function=(!(A+(((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam i2_3_lut_4_lut_4_lut.init = 16'h0040;
    LUT4 i1_3_lut_3_lut (.A(next_state[3]), .B(n10), .C(next_state[2]), 
         .Z(DIGS3C_Shared_ReqSafeState_N_695)) /* synthesis lut_function=(!(A (C)+!A !(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam i1_3_lut_3_lut.init = 16'h4f4f;
    LUT4 i1_2_lut_3_lut_3_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[0]), 
         .Z(Carrier_PwrOn_N_700)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam i1_2_lut_3_lut_3_lut.init = 16'h1010;
    PFUMX mux_424_Mux_8_i15 (.BLUT(n7), .ALUT(n3433), .C0(next_state[3]), 
          .Z(FP_SysLEDb_N_682));
    LUT4 i2_4_lut_4_lut (.A(next_state[3]), .B(next_state[1]), .C(next_state[2]), 
         .D(FlexMIOs53_GPIO_PowerDown_N_698), .Z(FlexMIOs53_GPIO_PowerDown_N_697)) /* synthesis lut_function=(!(A+!(B (C)+!B (C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam i2_4_lut_4_lut.init = 16'h5040;
    LUT4 i1_2_lut (.A(n5409), .B(n3922), .Z(next_state_3__N_31[0])) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(113[12:22])
    defparam i1_2_lut.init = 16'heeee;
    LUT4 FPIO_isoCtrlRSTn_N_687_bdd_3_lut_3156_4_lut (.A(signals_debounced_syn[2]), 
         .B(extern_connected), .C(next_state[3]), .D(next_state[2]), .Z(n5872)) /* synthesis lut_function=(!(A (C+!(D))+!A (B (C)+!B (C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam FPIO_isoCtrlRSTn_N_687_bdd_3_lut_3156_4_lut.init = 16'h0f04;
    LUT4 i42_4_lut (.A(FlexMIOs30_out), .B(FlexMIOs37_out), .C(FlexMIOs32_out), 
         .D(FlexMIOs45_c), .Z(n106)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i42_4_lut.init = 16'h8000;
    LUT4 i1_4_lut (.A(next_state_3__N_485[2]), .B(next_state[0]), .C(next_state[3]), 
         .D(n5710), .Z(n23)) /* synthesis lut_function=(!((B (C)+!B (C (D)))+!A)) */ ;
    defparam i1_4_lut.init = 16'h0a2a;
    LUT4 i2957_2_lut_3_lut_3_lut_4_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(next_state[0]), .D(next_state[1]), .Z(clk_enable_7)) /* synthesis lut_function=((B+(C (D)+!C !(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam i2957_2_lut_3_lut_3_lut_4_lut_4_lut.init = 16'hfddf;
    LUT4 FPIO_isoCtrlRSTn_N_687_bdd_4_lut_4_lut_4_lut (.A(next_state[3]), 
         .B(next_state[1]), .C(next_state_3__N_485[2]), .D(next_state[0]), 
         .Z(n5666)) /* synthesis lut_function=(A+!(B (D)+!B !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam FPIO_isoCtrlRSTn_N_687_bdd_4_lut_4_lut_4_lut.init = 16'hbbfe;
    LUT4 i2932_4_lut (.A(next_state[0]), .B(FPIO_isoCtrlRSTn_N_687), .C(next_state[1]), 
         .D(next_state[2]), .Z(clk_enable_131)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam i2932_4_lut.init = 16'h2000;
    LUT4 i25_2_lut (.A(DIG5S3C05_out), .B(DIG5S3C24_out), .Z(n89)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i25_2_lut.init = 16'h8888;
    FD1P3IX debounce_counters_3___i0 (.D(n418), .SP(clk_enable_130), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_3___i0.GSR = "ENABLED";
    LUT4 externstop_falling_bdd_2_lut (.A(next_state_3__N_485[2]), .B(next_state[3]), 
         .Z(n5876)) /* synthesis lut_function=(!(A (B))) */ ;
    defparam externstop_falling_bdd_2_lut.init = 16'h7777;
    LUT4 externstop_falling_bdd_4_lut (.A(externstop_falling), .B(next_state_3__N_485[2]), 
         .C(next_state[3]), .D(signals_debounced_syn[3]), .Z(n5875)) /* synthesis lut_function=(!(A (C)+!A ((C+!(D))+!B))) */ ;
    defparam externstop_falling_bdd_4_lut.init = 16'h0e0a;
    LUT4 i56_4_lut (.A(FlexMIOs36_out), .B(n112), .C(n94), .D(TDnSHDN_c), 
         .Z(n120)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i56_4_lut.init = 16'h8000;
    LUT4 i46_4_lut (.A(FlexLIO_c_1), .B(FlexLIO_c_4), .C(FlexLIO_c_2), 
         .D(FlexMIOs28_out), .Z(n110)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i46_4_lut.init = 16'h8000;
    LUT4 mux_424_Mux_2_i3_4_lut_then_4_lut (.A(extern_connected), .B(signals_debounced_syn[2]), 
         .C(FPIO_isoCtrlRSTn_N_687), .D(next_state[0]), .Z(n5722)) /* synthesis lut_function=(!(A (B (C)+!B (C+(D)))+!A (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_424_Mux_2_i3_4_lut_then_4_lut.init = 16'h0d0f;
    CCU2D add_194_23 (.A0(\debounce_counters[4] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5052), .COUT(n5053), .S0(n503), 
          .S1(n502));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_23.INIT0 = 16'h5aaa;
    defparam add_194_23.INIT1 = 16'h5aaa;
    defparam add_194_23.INJECT1_0 = "NO";
    defparam add_194_23.INJECT1_1 = "NO";
    PFUMX i3024 (.BLUT(n5637), .ALUT(n5636), .C0(next_state[2]), .Z(n5638));
    LUT4 i520_2_lut_rep_72 (.A(next_state_3__N_485[2]), .B(signals_debounced_syn[3]), 
         .Z(n5712)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(314[17] 324[12])
    defparam i520_2_lut_rep_72.init = 16'h4444;
    GSR GSR_INST (.GSR(VCC_net));
    CCU2D add_194_21 (.A0(\debounce_counters[4] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5051), .COUT(n5052), .S0(n505), 
          .S1(n504));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_21.INIT0 = 16'h5aaa;
    defparam add_194_21.INIT1 = 16'h5aaa;
    defparam add_194_21.INJECT1_0 = "NO";
    defparam add_194_21.INJECT1_1 = "NO";
    LUT4 m1_lut (.Z(n5922)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    LUT4 i1_2_lut_adj_5 (.A(signals_debounced_syn[2]), .B(externstop_last), 
         .Z(externstop_falling_N_707)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam i1_2_lut_adj_5.init = 16'h4444;
    LUT4 i1785_2_lut_3_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[1]), 
         .Z(FPIO_isoCtrlRSTn_N_683)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;
    defparam i1785_2_lut_3_lut.init = 16'h1010;
    LUT4 i1_2_lut_3_lut_4_lut_adj_6 (.A(next_state_3__N_485[2]), .B(signals_debounced_syn[3]), 
         .C(next_state[0]), .D(externstop_falling), .Z(n5347)) /* synthesis lut_function=(!(A ((D)+!C)+!A (B+((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(314[17] 324[12])
    defparam i1_2_lut_3_lut_4_lut_adj_6.init = 16'h00b0;
    FD1P3AX extern_connected_394 (.D(n5922), .SP(clk_enable_131), .CK(clk), 
            .Q(extern_connected)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam extern_connected_394.GSR = "ENABLED";
    FD1P3AX FPIO_isoCtrlRSTn_390 (.D(FPIO_isoCtrlRSTn_N_683), .SP(clk_enable_132), 
            .CK(clk), .Q(FPIO_isoCtrlRSTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam FPIO_isoCtrlRSTn_390.GSR = "ENABLED";
    LUT4 i26_2_lut (.A(DIG5S3C26_out), .B(FPIO_FlexMIO27_out), .Z(n90)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i26_2_lut.init = 16'h8888;
    CCU2D add_167_33 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5009), .S0(n175));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_33.INIT0 = 16'h5aaa;
    defparam add_167_33.INIT1 = 16'h0000;
    defparam add_167_33.INJECT1_0 = "NO";
    defparam add_167_33.INJECT1_1 = "NO";
    CCU2D add_167_31 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5008), .COUT(n5009), .S0(n177), 
          .S1(n176));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_31.INIT0 = 16'h5aaa;
    defparam add_167_31.INIT1 = 16'h5aaa;
    defparam add_167_31.INJECT1_0 = "NO";
    defparam add_167_31.INJECT1_1 = "NO";
    LUT4 next_state_2__bdd_4_lut_3043 (.A(next_state[2]), .B(next_state[3]), 
         .C(next_state[1]), .D(next_state[0]), .Z(FP_SysLEDr_N_681)) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(B (C+!(D))+!B (C)))) */ ;
    defparam next_state_2__bdd_4_lut_3043.init = 16'h7054;
    LUT4 i22_2_lut (.A(ANL_S3C_P54_Legacy_c), .B(ANL_S3C_SLOTOK_c_2), .Z(n86)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i22_2_lut.init = 16'h8888;
    LUT4 i2947_2_lut_rep_68_3_lut (.A(next_state_3__N_485[2]), .B(signals_debounced_syn[3]), 
         .C(externstop_falling), .Z(n5708)) /* synthesis lut_function=(!(A (C)+!A (B+(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(314[17] 324[12])
    defparam i2947_2_lut_rep_68_3_lut.init = 16'h0b0b;
    LUT4 i48_4_lut (.A(DIGS3C_SlotD_SlotOK_c_2), .B(FlexLIO_c_0), .C(DIG5S3C04_out), 
         .D(TDnFFnFS_c), .Z(n112)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i48_4_lut.init = 16'h8000;
    CCU2D add_194_19 (.A0(\debounce_counters[4] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5050), .COUT(n5051), .S0(n507), 
          .S1(n506));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_19.INIT0 = 16'h5aaa;
    defparam add_194_19.INIT1 = 16'h5aaa;
    defparam add_194_19.INJECT1_0 = "NO";
    defparam add_194_19.INJECT1_1 = "NO";
    CCU2D add_194_17 (.A0(\debounce_counters[4] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5049), .COUT(n5050), .S0(n509), 
          .S1(n508));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_17.INIT0 = 16'h5aaa;
    defparam add_194_17.INIT1 = 16'h5aaa;
    defparam add_194_17.INJECT1_0 = "NO";
    defparam add_194_17.INJECT1_1 = "NO";
    LUT4 i30_2_lut (.A(PG_VIN_c), .B(ANL_S3C_SLOTOK_c_1), .Z(n94)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i30_2_lut.init = 16'h8888;
    CCU2D add_167_29 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5007), .COUT(n5008), .S0(n179), 
          .S1(n178));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_29.INIT0 = 16'h5aaa;
    defparam add_167_29.INIT1 = 16'h5aaa;
    defparam add_167_29.INJECT1_0 = "NO";
    defparam add_167_29.INJECT1_1 = "NO";
    LUT4 i9_2_lut (.A(FlexMIOs54_out), .B(FlexMIOs63_out), .Z(n73)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i9_2_lut.init = 16'h8888;
    LUT4 i52_4_lut (.A(DIG5S3C01_out), .B(n104), .C(n78), .D(DIG5S3C02_out), 
         .Z(n116)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i52_4_lut.init = 16'h8000;
    LUT4 i18_4_lut (.A(counter[0]), .B(counter[14]), .C(counter[10]), 
         .D(counter[19]), .Z(n43)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i18_4_lut.init = 16'hfffe;
    CCU2D add_167_27 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5006), .COUT(n5007), .S0(n181), 
          .S1(n180));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_27.INIT0 = 16'h5aaa;
    defparam add_167_27.INIT1 = 16'h5aaa;
    defparam add_167_27.INJECT1_0 = "NO";
    defparam add_167_27.INJECT1_1 = "NO";
    CCU2D add_194_15 (.A0(\debounce_counters[4] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5048), .COUT(n5049), .S0(n511), 
          .S1(n510));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_15.INIT0 = 16'h5aaa;
    defparam add_194_15.INIT1 = 16'h5aaa;
    defparam add_194_15.INJECT1_0 = "NO";
    defparam add_194_15.INJECT1_1 = "NO";
    LUT4 i23_4_lut (.A(n27), .B(n46), .C(n40), .D(n28), .Z(n48)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i23_4_lut.init = 16'hfffe;
    LUT4 i38_4_lut (.A(SCL_c), .B(DIGS3C_SlotD_SlotOK_c_1), .C(SD1_CD_c), 
         .D(DIGS3C_SlotD_SlotOK_c_5), .Z(n102)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i38_4_lut.init = 16'h8000;
    LUT4 i10_2_lut (.A(PG_Module_c), .B(S3CsI2C_SDA_c), .Z(n74_adj_3)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i10_2_lut.init = 16'h8888;
    LUT4 i40_4_lut (.A(DIG5S3C28_out), .B(FPIO_FlexMIO29_out), .C(FPIO_FlexMIO28_out), 
         .D(FPIO_iosCtrlINTn_c), .Z(n104)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i40_4_lut.init = 16'h8000;
    LUT4 i2_2_lut_adj_7 (.A(counter[17]), .B(counter[22]), .Z(n27)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2_2_lut_adj_7.init = 16'heeee;
    LUT4 i12_2_lut (.A(counter[7]), .B(counter[12]), .Z(n37)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i12_2_lut.init = 16'heeee;
    LUT4 i14_2_lut (.A(DIG5S3C25_out), .B(DIG5S3C27_out), .Z(n78)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(172[17] 183[58])
    defparam i14_2_lut.init = 16'h8888;
    LUT4 i21_4_lut (.A(counter[11]), .B(n42), .C(n32), .D(counter[20]), 
         .Z(n46)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i21_4_lut.init = 16'hfffe;
    LUT4 i15_4_lut (.A(counter[15]), .B(counter[3]), .C(counter[1]), .D(counter[24]), 
         .Z(n40)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i15_4_lut.init = 16'hfffe;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut (.A(DIGS3C_SlotD_ReqOE_c_1), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_1)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(205[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut.init = 16'h2222;
    CCU2D add_194_13 (.A0(\debounce_counters[4] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5047), .COUT(n5048), .S0(n513), 
          .S1(n512));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_13.INIT0 = 16'h5aaa;
    defparam add_194_13.INIT1 = 16'h5aaa;
    defparam add_194_13.INJECT1_0 = "NO";
    defparam add_194_13.INJECT1_1 = "NO";
    CCU2D add_167_25 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5005), .COUT(n5006), .S0(n183), 
          .S1(n182));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_25.INIT0 = 16'h5aaa;
    defparam add_167_25.INIT1 = 16'h5aaa;
    defparam add_167_25.INJECT1_0 = "NO";
    defparam add_167_25.INJECT1_1 = "NO";
    CCU2D add_2590_2 (.A0(\debounce_counters[1] [7]), .B0(\debounce_counters[1] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[1] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n4982));
    defparam add_2590_2.INIT0 = 16'h1000;
    defparam add_2590_2.INIT1 = 16'h5aaa;
    defparam add_2590_2.INJECT1_0 = "NO";
    defparam add_2590_2.INJECT1_1 = "NO";
    LUT4 i3_2_lut (.A(counter[23]), .B(counter[4]), .Z(n28)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i3_2_lut.init = 16'heeee;
    CCU2D add_167_23 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5004), .COUT(n5005), .S0(n185), 
          .S1(n184));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_23.INIT0 = 16'h5aaa;
    defparam add_167_23.INIT1 = 16'h5aaa;
    defparam add_167_23.INJECT1_0 = "NO";
    defparam add_167_23.INJECT1_1 = "NO";
    LUT4 i1138_2_lut_3_lut (.A(next_state[1]), .B(next_state[0]), .C(next_state[2]), 
         .Z(n3433)) /* synthesis lut_function=(!(A (B+(C))+!A (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam i1138_2_lut_3_lut.init = 16'h0707;
    LUT4 i58_4_lut_adj_8 (.A(next_state[1]), .B(n2796), .C(next_state[3]), 
         .D(FPIO_isoCtrlRSTn_N_687), .Z(n29)) /* synthesis lut_function=(!(A (C+!(D))+!A (B+!(C)))) */ ;
    defparam i58_4_lut_adj_8.init = 16'h1a10;
    LUT4 i13_3_lut (.A(counter[8]), .B(counter[5]), .C(counter[6]), .Z(n38)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i13_3_lut.init = 16'hfefe;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut (.A(DIGS3C_SlotD_ReqOE_c_2), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_2)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(205[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut.init = 16'h2222;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut (.A(DIGS3C_SlotD_ReqOE_c_3), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_3)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(205[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut.init = 16'h2222;
    LUT4 i1767_2_lut (.A(FPIO_isoCtrlRSTn_N_687), .B(next_state_3__N_485[2]), 
         .Z(FlexMIOs53_GPIO_PowerDown_N_698)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(399[5] 402[12])
    defparam i1767_2_lut.init = 16'h2222;
    LUT4 i17_4_lut (.A(counter[2]), .B(counter[13]), .C(counter[9]), .D(counter[18]), 
         .Z(n42)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i17_4_lut.init = 16'hfffe;
    PFUMX i76 (.BLUT(n51), .ALUT(n45), .C0(n5386), .Z(n74));
    CCU2D add_167_21 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5003), .COUT(n5004), .S0(n187), 
          .S1(n186));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_21.INIT0 = 16'h5aaa;
    defparam add_167_21.INIT1 = 16'h5aaa;
    defparam add_167_21.INJECT1_0 = "NO";
    defparam add_167_21.INJECT1_1 = "NO";
    CCU2D add_167_19 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5002), .COUT(n5003), .S0(n189), 
          .S1(n188));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_19.INIT0 = 16'h5aaa;
    defparam add_167_19.INIT1 = 16'h5aaa;
    defparam add_167_19.INJECT1_0 = "NO";
    defparam add_167_19.INJECT1_1 = "NO";
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut (.A(DIGS3C_SlotD_ReqOE_c_4), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_4)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(205[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut.init = 16'h2222;
    CCU2D add_167_17 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5001), .COUT(n5002), .S0(n191), 
          .S1(n190));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_17.INIT0 = 16'h5aaa;
    defparam add_167_17.INIT1 = 16'h5aaa;
    defparam add_167_17.INJECT1_0 = "NO";
    defparam add_167_17.INJECT1_1 = "NO";
    CCU2D add_194_11 (.A0(\debounce_counters[4] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5046), .COUT(n5047), .S0(n515), 
          .S1(n514));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_11.INIT0 = 16'h5aaa;
    defparam add_194_11.INIT1 = 16'h5aaa;
    defparam add_194_11.INJECT1_0 = "NO";
    defparam add_194_11.INJECT1_1 = "NO";
    CCU2D add_167_15 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5000), .COUT(n5001), .S0(n193), 
          .S1(n192));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_15.INIT0 = 16'h5aaa;
    defparam add_167_15.INIT1 = 16'h5aaa;
    defparam add_167_15.INJECT1_0 = "NO";
    defparam add_167_15.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_65_3_lut (.A(next_state_3__N_485[2]), .B(signals_debounced_syn[3]), 
         .C(externstop_falling), .Z(n5705)) /* synthesis lut_function=(!(A+((C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(314[17] 324[12])
    defparam i1_2_lut_rep_65_3_lut.init = 16'h0404;
    CCU2D add_194_9 (.A0(\debounce_counters[4] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5045), .COUT(n5046), .S0(n517), 
          .S1(n516));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_9.INIT0 = 16'h5aaa;
    defparam add_194_9.INIT1 = 16'h5aaa;
    defparam add_194_9.INJECT1_0 = "NO";
    defparam add_194_9.INJECT1_1 = "NO";
    LUT4 mux_604_i7_4_lut (.A(next_state[1]), .B(n1699), .C(n2563), .D(n2559), 
         .Z(n2475)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_604_i7_4_lut.init = 16'h0aca;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut (.A(DIGS3C_SlotD_ReqOE_c_5), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_5)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(205[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut.init = 16'h2222;
    TSALL TSALL_INST (.TSALL(GND_net));
    CCU2D add_167_13 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4999), .COUT(n5000), .S0(n195), 
          .S1(n194));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_13.INIT0 = 16'h5aaa;
    defparam add_167_13.INIT1 = 16'h5aaa;
    defparam add_167_13.INJECT1_0 = "NO";
    defparam add_167_13.INJECT1_1 = "NO";
    CCU2D add_167_11 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4998), .COUT(n4999), .S0(n197), 
          .S1(n196));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_11.INIT0 = 16'h5aaa;
    defparam add_167_11.INIT1 = 16'h5aaa;
    defparam add_167_11.INJECT1_0 = "NO";
    defparam add_167_11.INJECT1_1 = "NO";
    LUT4 i1761_2_lut_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(next_state[0]), .D(next_state[1]), .Z(Carrier_PG_1V8_N_781)) /* synthesis lut_function=(A+(B+!(C (D)+!C !(D)))) */ ;
    defparam i1761_2_lut_3_lut_4_lut.init = 16'heffe;
    CCU2D add_167_9 (.A0(\debounce_counters[1] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4997), .COUT(n4998), .S0(n199), 
          .S1(n198));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_9.INIT0 = 16'h5aaa;
    defparam add_167_9.INIT1 = 16'h5aaa;
    defparam add_167_9.INJECT1_0 = "NO";
    defparam add_167_9.INJECT1_1 = "NO";
    CCU2D add_194_7 (.A0(\debounce_counters[4] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5044), .COUT(n5045), .S0(n519), 
          .S1(n518));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_7.INIT0 = 16'h5aaa;
    defparam add_194_7.INIT1 = 16'h5aaa;
    defparam add_194_7.INJECT1_0 = "NO";
    defparam add_194_7.INJECT1_1 = "NO";
    CCU2D add_167_7 (.A0(\debounce_counters[1] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4996), .COUT(n4997), .S0(n201), 
          .S1(n200));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_7.INIT0 = 16'h5aaa;
    defparam add_167_7.INIT1 = 16'h5aaa;
    defparam add_167_7.INJECT1_0 = "NO";
    defparam add_167_7.INJECT1_1 = "NO";
    CCU2D add_194_5 (.A0(\debounce_counters[4] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5043), .COUT(n5044), .S0(n521), 
          .S1(n520));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_5.INIT0 = 16'h5aaa;
    defparam add_194_5.INIT1 = 16'h5aaa;
    defparam add_194_5.INJECT1_0 = "NO";
    defparam add_194_5.INJECT1_1 = "NO";
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    CCU2D add_2588_26 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4981), .S1(clk_enable_111));
    defparam add_2588_26.INIT0 = 16'hf555;
    defparam add_2588_26.INIT1 = 16'h0000;
    defparam add_2588_26.INJECT1_0 = "NO";
    defparam add_2588_26.INJECT1_1 = "NO";
    CCU2D add_194_3 (.A0(\debounce_counters[4] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5042), .COUT(n5043), .S0(n523), 
          .S1(n522));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_3.INIT0 = 16'h5aaa;
    defparam add_194_3.INIT1 = 16'h5aaa;
    defparam add_194_3.INJECT1_0 = "NO";
    defparam add_194_3.INJECT1_1 = "NO";
    LUT4 i813_1_lut (.A(Carrier_PG_1V8_N_693), .Z(n3108)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(244[1] 425[13])
    defparam i813_1_lut.init = 16'h5555;
    LUT4 n5746_bdd_2_lut (.A(n5746), .B(next_state[3]), .Z(n5747)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam n5746_bdd_2_lut.init = 16'h2222;
    CCU2D add_2589_26 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5094), .S1(clk_enable_110));
    defparam add_2589_26.INIT0 = 16'hf555;
    defparam add_2589_26.INIT1 = 16'h0000;
    defparam add_2589_26.INJECT1_0 = "NO";
    defparam add_2589_26.INJECT1_1 = "NO";
    CCU2D add_2588_24 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4980), .COUT(n4981));
    defparam add_2588_24.INIT0 = 16'h5555;
    defparam add_2588_24.INIT1 = 16'h5555;
    defparam add_2588_24.INJECT1_0 = "NO";
    defparam add_2588_24.INJECT1_1 = "NO";
    CCU2D add_2589_24 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5093), .COUT(n5094));
    defparam add_2589_24.INIT0 = 16'h5555;
    defparam add_2589_24.INIT1 = 16'h5555;
    defparam add_2589_24.INJECT1_0 = "NO";
    defparam add_2589_24.INJECT1_1 = "NO";
    CCU2D add_194_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[4] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n5042), .S1(n524));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_194_1.INIT0 = 16'hF000;
    defparam add_194_1.INIT1 = 16'h5555;
    defparam add_194_1.INJECT1_0 = "NO";
    defparam add_194_1.INJECT1_1 = "NO";
    LUT4 i7_2_lut (.A(counter[16]), .B(counter[21]), .Z(n32)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i7_2_lut.init = 16'heeee;
    LUT4 mux_424_Mux_2_i15_3_lut (.A(n5723), .B(next_state[2]), .C(next_state[3]), 
         .Z(Carrier_PG_1V8_N_774)) /* synthesis lut_function=(A (B (C)+!B !(C))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_424_Mux_2_i15_3_lut.init = 16'hc2c2;
    LUT4 FPIO_isoCtrlRSTn_N_687_bdd_4_lut_3077 (.A(n3971), .B(next_state[1]), 
         .C(next_state[0]), .D(next_state_3__N_485[2]), .Z(n5745)) /* synthesis lut_function=(A (B+(C+!(D)))+!A (B (C)+!B !(C+(D)))) */ ;
    defparam FPIO_isoCtrlRSTn_N_687_bdd_4_lut_3077.init = 16'he8eb;
    CCU2D add_2589_22 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5092), .COUT(n5093));
    defparam add_2589_22.INIT0 = 16'h5555;
    defparam add_2589_22.INIT1 = 16'h5555;
    defparam add_2589_22.INJECT1_0 = "NO";
    defparam add_2589_22.INJECT1_1 = "NO";
    CCU2D add_2589_20 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5091), .COUT(n5092));
    defparam add_2589_20.INIT0 = 16'h5555;
    defparam add_2589_20.INIT1 = 16'h5555;
    defparam add_2589_20.INJECT1_0 = "NO";
    defparam add_2589_20.INJECT1_1 = "NO";
    CCU2D add_185_33 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5041), .S0(n387));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_33.INIT0 = 16'h5aaa;
    defparam add_185_33.INIT1 = 16'h0000;
    defparam add_185_33.INJECT1_0 = "NO";
    defparam add_185_33.INJECT1_1 = "NO";
    PFUMX i3148 (.BLUT(n5876), .ALUT(n5875), .C0(next_state[2]), .Z(n5877));
    VLO i1 (.Z(GND_net));
    CCU2D add_185_31 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5040), .COUT(n5041), .S0(n389), 
          .S1(n388));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_31.INIT0 = 16'h5aaa;
    defparam add_185_31.INIT1 = 16'h5aaa;
    defparam add_185_31.INJECT1_0 = "NO";
    defparam add_185_31.INJECT1_1 = "NO";
    CCU2D add_185_29 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5039), .COUT(n5040), .S0(n391), 
          .S1(n390));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_29.INIT0 = 16'h5aaa;
    defparam add_185_29.INIT1 = 16'h5aaa;
    defparam add_185_29.INJECT1_0 = "NO";
    defparam add_185_29.INJECT1_1 = "NO";
    CCU2D add_185_27 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5038), .COUT(n5039), .S0(n393), 
          .S1(n392));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_27.INIT0 = 16'h5aaa;
    defparam add_185_27.INIT1 = 16'h5aaa;
    defparam add_185_27.INJECT1_0 = "NO";
    defparam add_185_27.INJECT1_1 = "NO";
    LUT4 i769_2_lut (.A(clk_enable_111), .B(debounce_inputs_asyn2[3]), .Z(clk_enable_130)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i769_2_lut.init = 16'hdddd;
    LUT4 i768_2_lut (.A(clk_enable_110), .B(debounce_inputs_asyn2[2]), .Z(clk_enable_172)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i768_2_lut.init = 16'hdddd;
    LUT4 pushed_2__I_0_1_lut (.A(pushed[2]), .Z(pushed_2__N_262)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(225[17] 229[24])
    defparam pushed_2__I_0_1_lut.init = 16'h5555;
    PFUMX i3146 (.BLUT(n5873), .ALUT(n5872), .C0(next_state[1]), .Z(n5874));
    LUT4 i1_4_lut_adj_9 (.A(n5360), .B(FPIO_isoCtrlRSTn_N_687), .C(n5705), 
         .D(n3872), .Z(n35)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;
    defparam i1_4_lut_adj_9.init = 16'heca0;
    LUT4 i1_2_lut_adj_10 (.A(next_state[1]), .B(next_state[3]), .Z(n4)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i1_2_lut_adj_10.init = 16'h4444;
    FD1P3AX counter_i0_i8 (.D(n2507), .SP(clk_enable_141), .CK(clk), .Q(counter[8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i8.GSR = "ENABLED";
    FD1P3AX counter_i0_i9 (.D(n2506), .SP(clk_enable_141), .CK(clk), .Q(counter[9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i9.GSR = "ENABLED";
    FD1P3AX counter_i0_i12 (.D(n2503), .SP(clk_enable_141), .CK(clk), 
            .Q(counter[12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i12.GSR = "ENABLED";
    L6MUX21 i2906 (.D0(n5407), .D1(n5408), .SD(next_state[1]), .Z(n5409));
    PFUMX i2905 (.BLUT(n8), .ALUT(n5350), .C0(next_state[2]), .Z(n5408));
    FD1P3AX counter_i0_i18 (.D(n2497), .SP(clk_enable_141), .CK(clk), 
            .Q(counter[18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i18.GSR = "ENABLED";
    FD1P3AX counter_i0_i19 (.D(n2496), .SP(clk_enable_141), .CK(clk), 
            .Q(counter[19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i19.GSR = "ENABLED";
    FD1P3AX counter_i0_i20 (.D(n2495), .SP(clk_enable_141), .CK(clk), 
            .Q(counter[20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i20.GSR = "ENABLED";
    FD1P3AX counter_i0_i22 (.D(n2493), .SP(clk_enable_141), .CK(clk), 
            .Q(counter[22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i22.GSR = "ENABLED";
    FD1P3AX counter_i0_i23 (.D(n2492), .SP(clk_enable_141), .CK(clk), 
            .Q(counter[23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i23.GSR = "ENABLED";
    FD1P3AX counter_i0_i24 (.D(n2491), .SP(clk_enable_141), .CK(clk), 
            .Q(counter[24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam counter_i0_i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i1 (.D(n311), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i1.GSR = "ENABLED";
    CCU2D add_167_5 (.A0(\debounce_counters[1] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4995), .COUT(n4996), .S0(n203), 
          .S1(n202));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_5.INIT0 = 16'h5aaa;
    defparam add_167_5.INIT1 = 16'h5aaa;
    defparam add_167_5.INJECT1_0 = "NO";
    defparam add_167_5.INJECT1_1 = "NO";
    CCU2D add_2588_22 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4979), .COUT(n4980));
    defparam add_2588_22.INIT0 = 16'h5555;
    defparam add_2588_22.INIT1 = 16'h5555;
    defparam add_2588_22.INJECT1_0 = "NO";
    defparam add_2588_22.INJECT1_1 = "NO";
    CCU2D add_2588_20 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4978), .COUT(n4979));
    defparam add_2588_20.INIT0 = 16'h5555;
    defparam add_2588_20.INIT1 = 16'h5555;
    defparam add_2588_20.INJECT1_0 = "NO";
    defparam add_2588_20.INJECT1_1 = "NO";
    CCU2D add_2588_18 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4977), .COUT(n4978));
    defparam add_2588_18.INIT0 = 16'h5555;
    defparam add_2588_18.INIT1 = 16'h5555;
    defparam add_2588_18.INJECT1_0 = "NO";
    defparam add_2588_18.INJECT1_1 = "NO";
    CCU2D add_167_3 (.A0(\debounce_counters[1] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4994), .COUT(n4995), .S0(n205), 
          .S1(n204));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_3.INIT0 = 16'h5aaa;
    defparam add_167_3.INIT1 = 16'h5aaa;
    defparam add_167_3.INJECT1_0 = "NO";
    defparam add_167_3.INJECT1_1 = "NO";
    CCU2D add_2589_18 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5090), .COUT(n5091));
    defparam add_2589_18.INIT0 = 16'h5555;
    defparam add_2589_18.INIT1 = 16'h5555;
    defparam add_2589_18.INJECT1_0 = "NO";
    defparam add_2589_18.INJECT1_1 = "NO";
    CCU2D add_185_25 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5037), .COUT(n5038), .S0(n395), 
          .S1(n394));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_25.INIT0 = 16'h5aaa;
    defparam add_185_25.INIT1 = 16'h5aaa;
    defparam add_185_25.INJECT1_0 = "NO";
    defparam add_185_25.INJECT1_1 = "NO";
    CCU2D add_2589_16 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5089), .COUT(n5090));
    defparam add_2589_16.INIT0 = 16'h5555;
    defparam add_2589_16.INIT1 = 16'h5555;
    defparam add_2589_16.INJECT1_0 = "NO";
    defparam add_2589_16.INJECT1_1 = "NO";
    CCU2D add_185_23 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5036), .COUT(n5037), .S0(n397), 
          .S1(n396));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_23.INIT0 = 16'h5aaa;
    defparam add_185_23.INIT1 = 16'h5aaa;
    defparam add_185_23.INJECT1_0 = "NO";
    defparam add_185_23.INJECT1_1 = "NO";
    CCU2D add_2589_14 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5088), .COUT(n5089));
    defparam add_2589_14.INIT0 = 16'h5555;
    defparam add_2589_14.INIT1 = 16'h5555;
    defparam add_2589_14.INJECT1_0 = "NO";
    defparam add_2589_14.INJECT1_1 = "NO";
    CCU2D add_185_21 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5035), .COUT(n5036), .S0(n399), 
          .S1(n398));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_21.INIT0 = 16'h5aaa;
    defparam add_185_21.INIT1 = 16'h5aaa;
    defparam add_185_21.INJECT1_0 = "NO";
    defparam add_185_21.INJECT1_1 = "NO";
    CCU2D add_167_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[1] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n4994), .S1(n206));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_167_1.INIT0 = 16'hF000;
    defparam add_167_1.INIT1 = 16'h5555;
    defparam add_167_1.INJECT1_0 = "NO";
    defparam add_167_1.INJECT1_1 = "NO";
    CCU2D add_2590_26 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4993), .S1(clk_enable_6));
    defparam add_2590_26.INIT0 = 16'hf555;
    defparam add_2590_26.INIT1 = 16'h0000;
    defparam add_2590_26.INJECT1_0 = "NO";
    defparam add_2590_26.INJECT1_1 = "NO";
    CCU2D add_2589_12 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5087), .COUT(n5088));
    defparam add_2589_12.INIT0 = 16'h5555;
    defparam add_2589_12.INIT1 = 16'h5555;
    defparam add_2589_12.INJECT1_0 = "NO";
    defparam add_2589_12.INJECT1_1 = "NO";
    CCU2D add_185_19 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5034), .COUT(n5035), .S0(n401), 
          .S1(n400));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_19.INIT0 = 16'h5aaa;
    defparam add_185_19.INIT1 = 16'h5aaa;
    defparam add_185_19.INJECT1_0 = "NO";
    defparam add_185_19.INJECT1_1 = "NO";
    CCU2D add_2590_24 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4992), .COUT(n4993));
    defparam add_2590_24.INIT0 = 16'h5555;
    defparam add_2590_24.INIT1 = 16'h5555;
    defparam add_2590_24.INJECT1_0 = "NO";
    defparam add_2590_24.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_73 (.A(next_state[3]), .B(next_state[2]), .Z(n5713)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(113[12:22])
    defparam i1_2_lut_rep_73.init = 16'h2222;
    CCU2D add_185_17 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5033), .COUT(n5034), .S0(n403), 
          .S1(n402));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_17.INIT0 = 16'h5aaa;
    defparam add_185_17.INIT1 = 16'h5aaa;
    defparam add_185_17.INJECT1_0 = "NO";
    defparam add_185_17.INJECT1_1 = "NO";
    CCU2D add_2588_16 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4976), .COUT(n4977));
    defparam add_2588_16.INIT0 = 16'h5555;
    defparam add_2588_16.INIT1 = 16'h5555;
    defparam add_2588_16.INJECT1_0 = "NO";
    defparam add_2588_16.INJECT1_1 = "NO";
    CCU2D add_2588_14 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4975), .COUT(n4976));
    defparam add_2588_14.INIT0 = 16'h5555;
    defparam add_2588_14.INIT1 = 16'h5555;
    defparam add_2588_14.INJECT1_0 = "NO";
    defparam add_2588_14.INJECT1_1 = "NO";
    CCU2D add_2589_10 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5086), .COUT(n5087));
    defparam add_2589_10.INIT0 = 16'h5555;
    defparam add_2589_10.INIT1 = 16'h5555;
    defparam add_2589_10.INJECT1_0 = "NO";
    defparam add_2589_10.INJECT1_1 = "NO";
    CCU2D add_2590_22 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4991), .COUT(n4992));
    defparam add_2590_22.INIT0 = 16'h5555;
    defparam add_2590_22.INIT1 = 16'h5555;
    defparam add_2590_22.INJECT1_0 = "NO";
    defparam add_2590_22.INJECT1_1 = "NO";
    CCU2D add_2589_8 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5085), .COUT(n5086));
    defparam add_2589_8.INIT0 = 16'h5555;
    defparam add_2589_8.INIT1 = 16'h5aaa;
    defparam add_2589_8.INJECT1_0 = "NO";
    defparam add_2589_8.INJECT1_1 = "NO";
    LUT4 i770_2_lut (.A(clk_enable_112), .B(debounce_inputs_asyn2[4]), .Z(clk_enable_46)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i770_2_lut.init = 16'hdddd;
    CCU2D add_2589_6 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5084), .COUT(n5085));
    defparam add_2589_6.INIT0 = 16'h5555;
    defparam add_2589_6.INIT1 = 16'h5aaa;
    defparam add_2589_6.INJECT1_0 = "NO";
    defparam add_2589_6.INJECT1_1 = "NO";
    CCU2D add_185_15 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5032), .COUT(n5033), .S0(n405), 
          .S1(n404));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_15.INIT0 = 16'h5aaa;
    defparam add_185_15.INIT1 = 16'h5aaa;
    defparam add_185_15.INJECT1_0 = "NO";
    defparam add_185_15.INJECT1_1 = "NO";
    CCU2D add_185_13 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5031), .COUT(n5032), .S0(n407), 
          .S1(n406));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_13.INIT0 = 16'h5aaa;
    defparam add_185_13.INIT1 = 16'h5aaa;
    defparam add_185_13.INJECT1_0 = "NO";
    defparam add_185_13.INJECT1_1 = "NO";
    LUT4 pushed_3__I_0_1_lut (.A(pushed[3]), .Z(pushed_3__N_260)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(225[17] 229[24])
    defparam pushed_3__I_0_1_lut.init = 16'h5555;
    LUT4 i82_2_lut_rep_77 (.A(next_state[0]), .B(next_state_3__N_485[2]), 
         .Z(n5717)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i82_2_lut_rep_77.init = 16'heeee;
    PFUMX i35 (.BLUT(n23), .ALUT(n19), .C0(next_state[1]), .Z(n17));
    CCU2D add_185_11 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5030), .COUT(n5031), .S0(n409), 
          .S1(n408));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_11.INIT0 = 16'h5aaa;
    defparam add_185_11.INIT1 = 16'h5aaa;
    defparam add_185_11.INJECT1_0 = "NO";
    defparam add_185_11.INJECT1_1 = "NO";
    CCU2D add_2589_4 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5083), .COUT(n5084));
    defparam add_2589_4.INIT0 = 16'h5555;
    defparam add_2589_4.INIT1 = 16'h5555;
    defparam add_2589_4.INJECT1_0 = "NO";
    defparam add_2589_4.INJECT1_1 = "NO";
    CCU2D add_185_9 (.A0(\debounce_counters[3] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5029), .COUT(n5030), .S0(n411), 
          .S1(n410));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_9.INIT0 = 16'h5aaa;
    defparam add_185_9.INIT1 = 16'h5aaa;
    defparam add_185_9.INJECT1_0 = "NO";
    defparam add_185_9.INJECT1_1 = "NO";
    LUT4 pushed_4__I_0_1_lut (.A(pushed[4]), .Z(pushed_4__N_258)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(225[17] 229[24])
    defparam pushed_4__I_0_1_lut.init = 16'h5555;
    CCU2D add_185_7 (.A0(\debounce_counters[3] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n5028), .COUT(n5029), .S0(n413), 
          .S1(n412));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(216[49:69])
    defparam add_185_7.INIT0 = 16'h5aaa;
    defparam add_185_7.INIT1 = 16'h5aaa;
    defparam add_185_7.INJECT1_0 = "NO";
    defparam add_185_7.INJECT1_1 = "NO";
    CCU2D add_2590_20 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4990), .COUT(n4991));
    defparam add_2590_20.INIT0 = 16'h5555;
    defparam add_2590_20.INIT1 = 16'h5555;
    defparam add_2590_20.INJECT1_0 = "NO";
    defparam add_2590_20.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_2___i2 (.D(n310), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i3 (.D(n309), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i4 (.D(n308), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i5 (.D(n307), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i6 (.D(n306), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i7 (.D(n305), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i8 (.D(n304), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i9 (.D(n303), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i10 (.D(n302), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i11 (.D(n301), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i12 (.D(n300), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i13 (.D(n299), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i14 (.D(n298), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i15 (.D(n297), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i16 (.D(n296), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i17 (.D(n295), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i18 (.D(n294), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i19 (.D(n293), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i20 (.D(n292), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i21 (.D(n291), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i22 (.D(n290), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i23 (.D(n289), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i24 (.D(n288), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i25 (.D(n287), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i26 (.D(n286), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i27 (.D(n285), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i28 (.D(n284), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i29 (.D(n283), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i30 (.D(n282), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i31 (.D(n281), .SP(clk_enable_172), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam debounce_counters_2___i31.GSR = "ENABLED";
    CCU2D add_2589_2 (.A0(\debounce_counters[2] [7]), .B0(\debounce_counters[2] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[2] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n5083));
    defparam add_2589_2.INIT0 = 16'h1000;
    defparam add_2589_2.INIT1 = 16'h5aaa;
    defparam add_2589_2.INJECT1_0 = "NO";
    defparam add_2589_2.INJECT1_1 = "NO";
    LUT4 i767_2_lut (.A(clk_enable_6), .B(debounce_inputs_asyn2[1]), .Z(clk_enable_109)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i767_2_lut.init = 16'hdddd;
    PFUMX i2594 (.BLUT(n5095), .ALUT(n5096), .C0(next_state[1]), .Z(n5097));
    LUT4 pushed_1__I_0_1_lut (.A(pushed[1]), .Z(pushed_1__N_264)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(225[17] 229[24])
    defparam pushed_1__I_0_1_lut.init = 16'h5555;
    LUT4 mux_604_i12_4_lut (.A(next_state[1]), .B(n1694), .C(n2563), .D(n2559), 
         .Z(n2470)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(247[9] 423[18])
    defparam mux_604_i12_4_lut.init = 16'hf5c5;
    LUT4 i22_2_lut_rep_74 (.A(next_state[1]), .B(next_state[0]), .Z(n5714)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam i22_2_lut_rep_74.init = 16'h6666;
    LUT4 i2944_4_lut (.A(n5701), .B(n5329), .C(next_state[2]), .D(n17), 
         .Z(clk_enable_118)) /* synthesis lut_function=(!(A+(B+!(C+!(D))))) */ ;
    defparam i2944_4_lut.init = 16'h1011;
    LUT4 i1_4_lut_adj_11 (.A(next_state[3]), .B(externstop_falling), .C(n11), 
         .D(n5360), .Z(n2565)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;
    defparam i1_4_lut_adj_11.init = 16'heca0;
    LUT4 next_state_3__bdd_4_lut_3071 (.A(next_state[3]), .B(next_state[2]), 
         .C(next_state[1]), .D(next_state[0]), .Z(clk_enable_25)) /* synthesis lut_function=(A (B+(C (D)+!C !(D)))+!A (B (C+(D)))) */ ;
    defparam next_state_3__bdd_4_lut_3071.init = 16'hecca;
    LUT4 i1_2_lut_3_lut (.A(next_state[1]), .B(next_state[0]), .C(next_state[2]), 
         .Z(n5360)) /* synthesis lut_function=(!(A (B+!(C))+!A !(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(246[2] 424[9])
    defparam i1_2_lut_3_lut.init = 16'h6060;
    LUT4 i60_3_lut (.A(next_state_3__N_485[2]), .B(FPIO_isoCtrlRSTn_N_687), 
         .C(next_state[0]), .Z(n2796)) /* synthesis lut_function=(!(A (B (C))+!A (B+!(C)))) */ ;
    defparam i60_3_lut.init = 16'h3a3a;
    LUT4 i2592_3_lut_4_lut (.A(externstop_falling), .B(signals_debounced_syn[3]), 
         .C(next_state[0]), .D(next_state_3__N_485[2]), .Z(n5095)) /* synthesis lut_function=(A (C+(D))+!A (B (C+(D))+!B !(C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam i2592_3_lut_4_lut.init = 16'hefe0;
    LUT4 i1541_4_lut (.A(n5717), .B(n5366), .C(next_state[2]), .D(n4), 
         .Z(n2559)) /* synthesis lut_function=(A (B (C))+!A (B (C+(D))+!B !(C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(113[12:22])
    defparam i1541_4_lut.init = 16'hc5c0;
    PFUMX i2904 (.BLUT(n3923), .ALUT(n48_adj_1), .C0(next_state[2]), .Z(n5407));
    LUT4 i1768_2_lut (.A(FPIO_isoCtrlRSTn_N_687), .B(next_state[3]), .Z(n4059)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1768_2_lut.init = 16'heeee;
    LUT4 i1_3_lut_4_lut_4_lut_adj_12 (.A(next_state[0]), .B(next_state[2]), 
         .C(next_state[1]), .D(next_state[3]), .Z(FP_SysLEDg_N_680)) /* synthesis lut_function=(!(A (B (C+(D)))+!A (B (C+(D))+!B (C+!(D))))) */ ;
    defparam i1_3_lut_4_lut_4_lut_adj_12.init = 16'h232e;
    LUT4 i2593_3_lut_4_lut (.A(externstop_falling), .B(signals_debounced_syn[3]), 
         .C(next_state[0]), .D(FPIO_isoCtrlRSTn_N_687), .Z(n5096)) /* synthesis lut_function=(A ((D)+!C)+!A (B ((D)+!C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_rev06_beta/source/uz_s3c_toplevel.vhd(208[9] 234[10])
    defparam i2593_3_lut_4_lut.init = 16'hfe0e;
    LUT4 i2883_2_lut (.A(next_state[3]), .B(next_state[1]), .Z(n5386)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2883_2_lut.init = 16'heeee;
    LUT4 i1628_4_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_485[2]), 
         .C(next_state[3]), .D(n5710), .Z(n3923)) /* synthesis lut_function=(A (B ((D)+!C))+!A (B (C (D))+!B !(C))) */ ;
    defparam i1628_4_lut_4_lut.init = 16'hc909;
    LUT4 i1_4_lut_adj_13 (.A(n5703), .B(n5328), .C(next_state[1]), .D(n5713), 
         .Z(n4_adj_2)) /* synthesis lut_function=(A (B+!(C+!(D)))+!A (B)) */ ;
    defparam i1_4_lut_adj_13.init = 16'hcecc;
    PFUMX i3063 (.BLUT(n5727), .ALUT(n5728), .C0(next_state[0]), .Z(n5729));
    LUT4 i1_2_lut_rep_76 (.A(next_state[3]), .B(next_state[2]), .Z(n5716)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_rep_76.init = 16'heeee;
    PFUMX i3059 (.BLUT(n5711), .ALUT(n5722), .C0(next_state[1]), .Z(n5723));
    PFUMX i3061 (.BLUT(n5724), .ALUT(n5725), .C0(next_state[1]), .Z(clk_enable_23));
    PFUMX i3069 (.BLUT(n5748), .ALUT(n5747), .C0(next_state[2]), .Z(next_state_3__N_31[3]));
    LUT4 i24_4_lut (.A(n43), .B(n48), .C(n37), .D(n38), .Z(FPIO_isoCtrlRSTn_N_687)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i24_4_lut.init = 16'hfffe;
    
endmodule
//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

