// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Wed May 07 14:58:11 2025
//
// Verilog Description of module Waiting_for_Powerbutton_pressed_V0
//

module Waiting_for_Powerbutton_pressed_V0 (FP_SysLEDg, FP_SysLEDr, FP_SysLEDb, 
            FP_UsrSW1, FP_UsrSW2, SCL, SDA, FP_UsrSW3, SysSW_Pwr_NC, 
            FPIO_isoCtrlRSTn, FPIO_iosCtrlINTn, Carrier_PG_3V3, FPIO_ExternalStop, 
            FPIO_FlexMIO28, FPIO_FlexMIO27, FPIO_FlexMIO30, FPIO_FlexMIO29, 
            FPIO_FlexMIO52, Carrier_PG_1V8, S3CsI2C_SDA, S3CsI2C_SCL, 
            FP_SysLEDs, SD1_CD, SD0_CD, SPI_S3C_nCS_USR, FP_UsrLED, 
            DIGS3C_Shared_CarrierReady, DIGS3C_Shared_ReqSafeState, DIGS3C_SlotD_ReqOE, 
            DIGS3C_SlotD_SlotOK, DIG5S3C26, DIG5S3C25, DIG5S3C24, SD_SEL, 
            FlexMIOs52_PCIe, FlexMIOs53_GPIO_PowerDown, FlexMIOs54, FlexMio61ExternalStop, 
            FlexMIOs62, FlexMIOs63, FlexMIOs31, FlexMIOs45, FlexMIOs37, 
            FlexMIOs36, FlexMIOs35, FlexMIOs34, FlexMIOs33, FlexMIOs32, 
            DIG5S3C03, DIG5S3C04, DIG5S3C05, DIG5S3C00, DIG5S3C02, 
            DIG5S3C01, DIG5S3C29, DIG5S3C28, DIG5S3C27, ANL_S3C_SLOTOK, 
            ANL_S3C_CarrierReady, ANL_S3C_P54_Legacy, DIGS3C_SlotD_SlotOE, 
            Carrier_PwrOn, PG_VIN, PPn_VIN, PG_Module, TDnSHDN, TDnFFnFS, 
            TDnALERT, S3C_S1, GPO, IRQ, GPI);   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(8[8:42])
    output FP_SysLEDg;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(25[3:13])
    output FP_SysLEDr;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(26[3:13])
    output FP_SysLEDb;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(27[3:13])
    input FP_UsrSW1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(33[3:12])
    input FP_UsrSW2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(34[3:12])
    inout SCL /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(36[3:6])
    inout SDA /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(37[3:6])
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
    output [7:0]GPO;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    input [3:0]IRQ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(118[3:6])
    input [7:0]GPI;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(120[3:6])
    
    wire clk /* synthesis SET_AS_NETWORK=clk, is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(129[9:12])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(40[12:21])
    wire dummy_signal /* synthesis noclip="on" */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(180[9:21])
    
    wire GND_net, VCC_net, FP_SysLEDg_c, FP_SysLEDr_c, FP_SysLEDb_c, 
        FP_UsrSW1_c, FP_UsrSW2_c, FP_UsrSW3_c, SysSW_Pwr_NC_c, FPIO_isoCtrlRSTn_c, 
        FPIO_iosCtrlINTn_c, Carrier_PG_3V3_c, FlexMio61ExternalStop_c_c, 
        FPIO_FlexMIO52_c_c, S3CsI2C_SDA_c, S3CsI2C_SCL_c, FP_SysLEDs_c, 
        SD1_CD_c, SD0_CD_c, SPI_S3C_nCS_USR_c, FP_UsrLED_c_3, FP_UsrLED_c_2, 
        DIGS3C_Shared_ReqSafeState_c, DIGS3C_SlotD_ReqOE_c_5, DIGS3C_SlotD_ReqOE_c_4, 
        DIGS3C_SlotD_ReqOE_c_3, DIGS3C_SlotD_ReqOE_c_2, DIGS3C_SlotD_ReqOE_c_1, 
        DIGS3C_SlotD_SlotOK_c_5, DIGS3C_SlotD_SlotOK_c_4, DIGS3C_SlotD_SlotOK_c_3, 
        DIGS3C_SlotD_SlotOK_c_2, DIGS3C_SlotD_SlotOK_c_1, FlexMIOs53_GPIO_PowerDown_c, 
        FlexMIOs45_c, ANL_S3C_SLOTOK_c_3, ANL_S3C_SLOTOK_c_2, ANL_S3C_SLOTOK_c_1, 
        ANL_S3C_P54_Legacy_c, DIGS3C_SlotD_SlotOE_c_5, DIGS3C_SlotD_SlotOE_c_4, 
        DIGS3C_SlotD_SlotOE_c_3, DIGS3C_SlotD_SlotOE_c_2, DIGS3C_SlotD_SlotOE_c_1, 
        Carrier_PwrOn_c, PG_VIN_c, PPn_VIN_c, PG_Module_c, TDnSHDN_c, 
        TDnFFnFS_c, TDnALERT_c, S3C_S1_c, GPO_c_7, GPO_c_6, GPO_c_5, 
        GPO_c_4, GPO_c_3, GPO_c_2, GPO_c_1, GPO_c_0, GPI_c_7, GPI_c_6, 
        GPI_c_5, GPI_c_4, GPI_c_3, GPI_c_2, GPI_c_1, GPI_c_0;
    wire [24:0]counter;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(130[9:16])
    wire [24:0]resetcounter;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(131[9:21])
    wire [3:0]next_state;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(137[12:22])
    wire [31:0]\debounce_counters[1] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(144[12:29])
    wire [31:0]\debounce_counters[2] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(144[12:29])
    wire [31:0]\debounce_counters[3] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(144[12:29])
    wire [31:0]\debounce_counters[4] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(144[12:29])
    wire [6:1]debounce_inputs_asyn1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(146[12:33])
    wire [6:1]debounce_inputs_asyn2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(147[9:30])
    wire [6:1]pushed;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(148[9:15])
    wire [6:1]signals_debounced_syn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(149[12:33])
    
    wire n9551, externstop_falling, externstop_last, extern_connected, 
        forceoutputdisable;
    wire [7:0]wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(272[8:16])
    
    wire wb_stb_i;
    wire [7:0]wb_adr_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(275[8:16])
    
    wire wb_we_i;
    wire [7:0]wb_dat_o;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(277[8:16])
    
    wire wb_ack_o;
    wire [7:0]data0;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(289[8:13])
    wire [7:0]temp1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(290[14:19])
    wire [7:0]temp2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(290[20:25])
    wire [7:0]temp3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(290[26:31])
    wire [7:0]n_temp1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(291[16:23])
    
    wire n7091, n12, reg_rdy, dat_rdy, dat_rdy_del;
    wire [7:0]n_dat_count;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(299[8:19])
    wire [7:0]dat_count;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(299[22:31])
    wire [7:0]GPI_DAT;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(300[8:15])
    wire [7:0]n_wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(311[8:18])
    wire [7:0]n_wb_adr_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(313[8:18])
    
    wire n_wb_we_i, n8321, n8297, n8296, n8320, n8934, n8562, 
        n42, n8295, n8319, n8318, n8294, n8293, n8292, n8291, 
        n8317, n8290, n5941, n6030, n179, n180, n181, n182, 
        n183, n184, n185, n186, n187, n188, n189, n190, n191, 
        n192, n193, n194, n195, n196, n197, n198, n199, n200, 
        n201, n202, n203, n204, n205, n206, n207, n208, n209, 
        n210, n8289, n8288, n8287, n8286, n8316, n8285, n8315, 
        n8314, n8313, n8312, n8311, n8310, n8998, n8376, clk_enable_188, 
        pushed_1__N_302, n285, n286, n287, n288, n289, n290, n291, 
        n292, n293, n294, n295, n296, n297, n298, n299, n300, 
        n301, n302, n303, n304, n305, n306, n307, n308, n309, 
        n310, n311, n312, n313, n314, n315, n316, n6942, n7086, 
        n8284, n15, n7171, n7081, pushed_2__N_300, n391, n392, 
        n393, n394, n395, n396, n397, n398, n399, n400, n401, 
        n402, n403, n404, n405, n406, n407, n408, n409, n410, 
        n411, n412, n413, n414, n415, n416, n417, n418, n419, 
        n420, n421, n422, clk_enable_136, n7008, n9417, n8283, 
        n8282, n9416, n9415, pushed_3__N_298, n497, n498, n499, 
        n500, n501, n502, n503, n504, n505, n506, n507, n508, 
        n509, n510, n511, n512, n513, n514, n515, n516, n517, 
        n518, n519, n520, n521, n522, n523, n524, n525, n526, 
        n527, n528, n8281, n8280, n8279, clk_enable_185, n6946, 
        n14, n9567, pushed_4__N_296, clk_enable_17, n8278, n8309, 
        n8277, n8276, n8275, n8308, n9573, n8307, n8273, n5585, 
        n8272, clk_enable_14, n8306, n8271, n8270, n8305, n8304, 
        n8303, n8302, n8301, n8300, n8269, n8299, n8268, n8396, 
        n8298, n58, n17, externstop_falling_N_1314, n15_adj_1398, 
        n30, n15_adj_1399, n36, n9102, n33, n12_adj_1400, n40, 
        n6024, n18, clk_enable_127, clk_enable_187, reg_rdy_N_1322, 
        reg_rdy_N_1320, dat_rdy_N_1326, dat_rdy_N_1324, i2c1_sdao, i2c1_sdaoen;
    wire [7:0]data0_7__N_898;
    
    wire n8267, n12_adj_1401, n8266, n15_adj_1402, n9391, n9576, 
        n9390, n4566, n8265, n8264, i2c1_sdai, n57, n8263, n8262, 
        n9084, n54, n8261, n8942, n31, n8260, n8966, n9054, 
        n8259, n9078, n68, n8258, n50, n48, clk_enable_125, n9550, 
        n9072, n8257, n5722, n5290, n5, n8256, n9068, n18_adj_1403, 
        n8255, n5294, n8254, n8253, n4, n15_adj_1404, n12_adj_1405, 
        n8252, n38, n8251, n8250, n8249, n8248, n8247, n8937, 
        n8246, n30_adj_1406, n8245, n8244, n8566, n28, n8243, 
        n30_adj_1407, n8242;
    wire [7:0]n_state_7__N_984;
    
    wire n8241, n8240, clk_enable_55, n32, n9007, n9549, clk_enable_189, 
        n9548, n8339, n8338, n8337, n15_adj_1408, n8239, n9537, 
        n9547, n8992, n6, n8238, n8336, n3891, n9546, n12_adj_1409, 
        n8237, n9530, n8335, n2012, n2013, n2014, n2015, n2016, 
        n2017, n2018, n2019, n11, n47, n8334, n9035, n2, n8333, 
        n5726, n4572, n8236, n8332, n1, n3, n2_adj_1410, clk_enable_183, 
        n8592, n9004, n8235;
    wire [7:0]n_dat_count_7__N_423;
    
    wire clk_enable_178, clk_enable_86, n5_adj_1411;
    wire [7:0]n_state_7__N_1040;
    
    wire n8234, clk_enable_126, clk_enable_135, n8233, n15_adj_1412, 
        n12_adj_1413, n51, n8232, n9536, n9674, n30_adj_1414, n6_adj_1415, 
        n5311, n5307, n5301, n7141, n5299, n5297, n5295, n29, 
        n5293, n5668, n8231, n9672, n9283, n8230, n48_adj_1416, 
        n_temp1_7__N_351, n_temp1_7__N_352, n_temp1_7__N_353, n_temp1_7__N_354, 
        n_temp1_7__N_355, n_temp1_7__N_356, n_temp1_7__N_357, n_temp1_7__N_358, 
        n_temp1_7__N_359, n_temp1_7__N_360, i2c1_sclo, n_temp1_7__N_362, 
        n_temp1_7__N_363, i2c1_scloen, n_temp1_7__N_365, n_temp1_7__N_366, 
        n_temp1_7__N_367, n_temp1_7__N_368, n_temp1_7__N_369, n5289, 
        n8229, n5959, clk_enable_26, n8228, n8227, n8226, n8225, 
        n6_adj_1417, n9282, n8331, n8224, n94, n92, n3828, n8330, 
        n90, n89, n88, n4_adj_1418, n86, clk_enable_4, n4846, 
        clk_enable_117, n8329, n5724;
    wire [3:0]next_state_3__N_1088;
    
    wire n9671, n8429, n5279, n84, n4570, n15_adj_1419, n8223, 
        n8222, n14_adj_1420, n5277, n8328, n8221, n8220, n25, 
        clk_enable_124, n9670, n8219, n8218, n30_adj_1421, clk_enable_134, 
        n8217, n8216, n8215, n9669, n3778, n8214, n5997, n8213, 
        n4408, n4401, n8212, n8211, n8210, n15_adj_1422, n12_adj_1423, 
        n4514, n4513, n8326, n4510, n8209, n8325, n4504, n4503, 
        n4502, n8208, n4500, n4499, n4498, n8324, n82, n8207, 
        n6975, n28_adj_1424, n5749, n80, n8206, n4482, n14_adj_1425, 
        n4480, n4479, n4478, n4477, n4475, n4473, n4472, n4471, 
        n18_adj_1426;
    wire [3:0]next_state_3__N_1092;
    
    wire n48_adj_1427, n3068, n3069, n3070, n3071, n3072, n3073, 
        n3074, n3075, n3076, n3077, n3078, n3079, n3080, n3081, 
        n3082, n3083, n3084, n3085, n3086, n3087, n3088, n3089, 
        n3090, n3091, n3092, n4470, n4469, n4468, n12_adj_1428, 
        n78, n6_adj_1429, n8205, n14_adj_1430, n14_adj_1431, n10, 
        n13, n8204, n9535, n9544, forceoutputdisable_N_8, DIGS3C_Shared_ReqSafeState_N_1302, 
        FlexMIOs53_GPIO_PowerDown_N_1304, FP_SysLEDr_N_1288, FP_SysLEDb_N_1289, 
        FP_SysLEDg_N_1287;
    wire [3:0]next_state_3__N_69;
    
    wire Carrier_PG_3V3_N_1296, FPIO_isoCtrlRSTn_N_1290, n76, n20, n8323, 
        n8203, FP_SysLEDs_N_1301, Carrier_PG_1V8_N_1390, Carrier_PG_1V8_N_1397, 
        Carrier_PG_1V8_N_1300, n8202, n8201, n30_adj_1432, n8200, 
        n9543, n8199, n9542, n9541, n9834, n74, n73, n5422, 
        FPIO_FlexMIO28_out, n106, n107, n108, n109, n110, n111, 
        n112, n113, n114, n115, n116, n117, n118, n119, n120, 
        n121, n122, n123, n124, n125, n126, n127, n128, n129, 
        n130, n8379, n9534, n6_adj_1433, n7, n8198, n14_adj_1434, 
        n8322, n10_adj_1435, n9113, n9533, n5_adj_1436, n3_adj_1437, 
        n15_adj_1438, n70, n9519, n9518, n9517, n9516, FPIO_FlexMIO27_out, 
        n9515, FPIO_FlexMIO30_out, FPIO_FlexMIO29_out, DIG5S3C26_out, 
        DIG5S3C25_out, DIG5S3C24_out, FlexMIOs54_out, FlexMIOs62_out, 
        FlexMIOs63_out, FlexMIOs31_out, FlexMIOs37_out, FlexMIOs36_out, 
        FlexMIOs35_out, FlexMIOs34_out, FlexMIOs33_out, FlexMIOs32_out, 
        n9514, DIG5S3C03_out, DIG5S3C04_out, DIG5S3C05_out, n8498, 
        DIG5S3C00_out, DIG5S3C02_out, DIG5S3C01_out, DIG5S3C29_out, 
        DIG5S3C28_out, DIG5S3C27_out, n5222, n9322, n9115, n9114, 
        n9112, n9111, n9044, n9110, n9505, n9504, n9321, n9503, 
        n9320, n9540, n18_adj_1439, n9532, n9531, n16, n9319, 
        n9539, n66, n9566, n9318, n9565, n9564, n9563, n9562, 
        n8941, n9482, clk_enable_12, n9577, n9561, n9481, n10_adj_1440, 
        n14_adj_1441, n8986, n4_adj_1442, n9575, clk_enable_137, n9560, 
        n9574, n9471, n9470, n9469, n9559, clk_enable_16, n9557, 
        clk_enable_5, n9572, n9555, n9571, n46, n8964, n9030, 
        n8880, n37, n9570, n9538, n9568, n9082, n43, clk_enable_9, 
        n9554, n9553, n9552, n27, n62;
    
    VHI i2 (.Z(VCC_net));
    efb_vhdl dut (.clk(clk), .n9561(n9561), .wb_stb_i(wb_stb_i), .wb_we_i(wb_we_i), 
            .GND_net(GND_net), .\wb_adr_i[2] (wb_adr_i[2]), .\wb_adr_i[1] (wb_adr_i[1]), 
            .\wb_adr_i[0] (wb_adr_i[0]), .wb_dat_i({wb_dat_i}), .\wb_dat_o[7] (wb_dat_o[7]), 
            .\n_state_7__N_1040[4] (n_state_7__N_1040[4]), .\wb_dat_o[5] (wb_dat_o[5]), 
            .\wb_dat_o[4] (wb_dat_o[4]), .\wb_dat_o[3] (wb_dat_o[3]), .\wb_dat_o[2] (wb_dat_o[2]), 
            .\wb_dat_o[1] (wb_dat_o[1]), .\wb_dat_o[0] (wb_dat_o[0]), .wb_ack_o(wb_ack_o), 
            .i2c1_sdaoen(i2c1_sdaoen), .i2c1_sdao(i2c1_sdao), .i2c1_scloen(i2c1_scloen), 
            .i2c1_sclo(i2c1_sclo), .i2c1_sdai(i2c1_sdai), .i2c1_scli(i2c1_scli), 
            .VCC_net(VCC_net)) /* synthesis NGD_DRC_MASK=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(358[7:15])
    LUT4 i1_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(reg_rdy_N_1322), 
         .Z(reg_rdy_N_1320)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1_2_lut_3_lut.init = 16'h8080;
    FD1P3IX counter_i0_i6 (.D(n4482), .SP(clk_enable_188), .CD(n6030), 
            .CK(clk), .Q(counter[6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i6.GSR = "ENABLED";
    CCU2D add_147_3 (.A0(\debounce_counters[2] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8214), .COUT(n8215), .S0(n315), 
          .S1(n314));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_3.INIT0 = 16'h5aaa;
    defparam add_147_3.INIT1 = 16'h5aaa;
    defparam add_147_3.INJECT1_0 = "NO";
    defparam add_147_3.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i5 (.D(n3087), .SP(clk_enable_188), .CD(n6024), 
            .CK(clk), .Q(counter[5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i5.GSR = "ENABLED";
    CCU2D add_787_17 (.A0(counter[15]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[16]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8269), .COUT(n8270), .S0(n3077), .S1(n3076));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1482[17:24])
    defparam add_787_17.INIT0 = 16'h5555;
    defparam add_787_17.INIT1 = 16'h5555;
    defparam add_787_17.INJECT1_0 = "NO";
    defparam add_787_17.INJECT1_1 = "NO";
    LUT4 n9538_bdd_3_lut_5521 (.A(next_state_3__N_1088[2]), .B(next_state_3__N_1092[2]), 
         .C(next_state[1]), .Z(n9671)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;
    defparam n9538_bdd_3_lut_5521.init = 16'hacac;
    CCU2D add_787_15 (.A0(counter[13]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[14]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8268), .COUT(n8269), .S0(n3079), .S1(n3078));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1482[17:24])
    defparam add_787_15.INIT0 = 16'h5555;
    defparam add_787_15.INIT1 = 16'h5555;
    defparam add_787_15.INJECT1_0 = "NO";
    defparam add_787_15.INJECT1_1 = "NO";
    CCU2D add_787_13 (.A0(counter[11]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[12]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8267), .COUT(n8268), .S0(n3081), .S1(n3080));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1482[17:24])
    defparam add_787_13.INIT0 = 16'h5555;
    defparam add_787_13.INIT1 = 16'h5555;
    defparam add_787_13.INJECT1_0 = "NO";
    defparam add_787_13.INJECT1_1 = "NO";
    LUT4 n9538_bdd_3_lut_5479 (.A(n9538), .B(next_state_3__N_1088[2]), .C(next_state[1]), 
         .Z(n9670)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;
    defparam n9538_bdd_3_lut_5479.init = 16'hacac;
    CCU2D add_787_11 (.A0(counter[9]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[10]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8266), .COUT(n8267), .S0(n3083), .S1(n3082));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1482[17:24])
    defparam add_787_11.INIT0 = 16'h5555;
    defparam add_787_11.INIT1 = 16'h5555;
    defparam add_787_11.INJECT1_0 = "NO";
    defparam add_787_11.INJECT1_1 = "NO";
    CCU2D add_156_7 (.A0(\debounce_counters[3] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8232), .COUT(n8233), .S0(n417), 
          .S1(n416));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_7.INIT0 = 16'h5aaa;
    defparam add_156_7.INIT1 = 16'h5aaa;
    defparam add_156_7.INJECT1_0 = "NO";
    defparam add_156_7.INJECT1_1 = "NO";
    LUT4 n9538_bdd_4_lut_5501 (.A(n5941), .B(next_state[0]), .C(next_state[1]), 
         .D(next_state[2]), .Z(n9669)) /* synthesis lut_function=(!(A+(B+(C+(D))))) */ ;
    defparam n9538_bdd_4_lut_5501.init = 16'h0001;
    CCU2D add_787_9 (.A0(counter[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[8]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8265), .COUT(n8266), .S0(n3085), .S1(n3084));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1482[17:24])
    defparam add_787_9.INIT0 = 16'h5555;
    defparam add_787_9.INIT1 = 16'h5555;
    defparam add_787_9.INJECT1_0 = "NO";
    defparam add_787_9.INJECT1_1 = "NO";
    CCU2D add_787_7 (.A0(counter[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8264), .COUT(n8265), .S0(n3087), .S1(n3086));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1482[17:24])
    defparam add_787_7.INIT0 = 16'h5555;
    defparam add_787_7.INIT1 = 16'h5555;
    defparam add_787_7.INJECT1_0 = "NO";
    defparam add_787_7.INJECT1_1 = "NO";
    CCU2D add_4455_24 (.A0(\debounce_counters[4] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8313), .COUT(n8314));
    defparam add_4455_24.INIT0 = 16'h5555;
    defparam add_4455_24.INIT1 = 16'h5555;
    defparam add_4455_24.INJECT1_0 = "NO";
    defparam add_4455_24.INJECT1_1 = "NO";
    CCU2D add_4455_22 (.A0(\debounce_counters[4] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8312), .COUT(n8313));
    defparam add_4455_22.INIT0 = 16'h5555;
    defparam add_4455_22.INIT1 = 16'h5555;
    defparam add_4455_22.INJECT1_0 = "NO";
    defparam add_4455_22.INJECT1_1 = "NO";
    CCU2D add_4455_20 (.A0(\debounce_counters[4] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8311), .COUT(n8312));
    defparam add_4455_20.INIT0 = 16'h5555;
    defparam add_4455_20.INIT1 = 16'h5555;
    defparam add_4455_20.INJECT1_0 = "NO";
    defparam add_4455_20.INJECT1_1 = "NO";
    CCU2D add_4455_18 (.A0(\debounce_counters[4] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8310), .COUT(n8311));
    defparam add_4455_18.INIT0 = 16'h5555;
    defparam add_4455_18.INIT1 = 16'h5555;
    defparam add_4455_18.INJECT1_0 = "NO";
    defparam add_4455_18.INJECT1_1 = "NO";
    CCU2D add_4455_16 (.A0(\debounce_counters[4] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8309), .COUT(n8310));
    defparam add_4455_16.INIT0 = 16'h5555;
    defparam add_4455_16.INIT1 = 16'h5555;
    defparam add_4455_16.INJECT1_0 = "NO";
    defparam add_4455_16.INJECT1_1 = "NO";
    CCU2D add_4455_14 (.A0(\debounce_counters[4] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8308), .COUT(n8309));
    defparam add_4455_14.INIT0 = 16'h5555;
    defparam add_4455_14.INIT1 = 16'h5555;
    defparam add_4455_14.INJECT1_0 = "NO";
    defparam add_4455_14.INJECT1_1 = "NO";
    CCU2D add_4455_12 (.A0(\debounce_counters[4] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8307), .COUT(n8308));
    defparam add_4455_12.INIT0 = 16'h5555;
    defparam add_4455_12.INIT1 = 16'h5555;
    defparam add_4455_12.INJECT1_0 = "NO";
    defparam add_4455_12.INJECT1_1 = "NO";
    CCU2D add_4455_10 (.A0(\debounce_counters[4] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8306), .COUT(n8307));
    defparam add_4455_10.INIT0 = 16'h5555;
    defparam add_4455_10.INIT1 = 16'h5555;
    defparam add_4455_10.INJECT1_0 = "NO";
    defparam add_4455_10.INJECT1_1 = "NO";
    CCU2D add_787_5 (.A0(counter[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8263), .COUT(n8264), .S0(n3089), .S1(n3088));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1482[17:24])
    defparam add_787_5.INIT0 = 16'h5555;
    defparam add_787_5.INIT1 = 16'h5555;
    defparam add_787_5.INJECT1_0 = "NO";
    defparam add_787_5.INJECT1_1 = "NO";
    FD1S3IX c_state_FSM_i18 (.D(n5311), .CK(clk), .CD(n9561), .Q(n_temp1_7__N_352));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i18.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i17 (.D(n8566), .CK(clk), .CD(n9561), .Q(n_temp1_7__N_353));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i17.GSR = "ENABLED";
    FD1P3IX GPO_DATA_0___i1 (.D(temp3[0]), .SP(clk_enable_134), .CD(n9561), 
            .CK(clk), .Q(GPO_c_0));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(620[8] 628[15])
    defparam GPO_DATA_0___i1.GSR = "ENABLED";
    LUT4 wb_ack_o_I_0_2_lut_rep_136 (.A(wb_ack_o), .B(wb_stb_i), .Z(clk_enable_5)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam wb_ack_o_I_0_2_lut_rep_136.init = 16'h8888;
    CCU2D add_4455_8 (.A0(\debounce_counters[4] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8305), .COUT(n8306));
    defparam add_4455_8.INIT0 = 16'h5555;
    defparam add_4455_8.INIT1 = 16'h5aaa;
    defparam add_4455_8.INJECT1_0 = "NO";
    defparam add_4455_8.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_362), 
         .D(wb_dat_o[2]), .Z(n8998)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1_2_lut_3_lut_4_lut.init = 16'h8000;
    FD1S3IX temp1__i0 (.D(n_temp1[0]), .CK(clk), .CD(n9561), .Q(temp1[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp1__i0.GSR = "ENABLED";
    LUT4 i1660_4_lut (.A(n_temp1_7__N_363), .B(n7086), .C(n3828), .D(n8998), 
         .Z(n5289)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1660_4_lut.init = 16'hb3a0;
    FD1S3AY debounce_inputs_asyn2_i1 (.D(debounce_inputs_asyn1[1]), .CK(clk), 
            .Q(debounce_inputs_asyn2[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_inputs_asyn2_i1.GSR = "ENABLED";
    FD1P3IX pushed_i1 (.D(n9834), .SP(clk_enable_4), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(pushed[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam pushed_i1.GSR = "ENABLED";
    FD1S3AY signals_debounced_syn_i1 (.D(pushed_1__N_302), .CK(clk), .Q(next_state_3__N_1092[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam signals_debounced_syn_i1.GSR = "ENABLED";
    FD1S3AX externstop_falling_659 (.D(externstop_falling_N_1314), .CK(clk), 
            .Q(externstop_falling));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam externstop_falling_659.GSR = "ENABLED";
    FD1S3AX externstop_last_660 (.D(signals_debounced_syn[2]), .CK(clk), 
            .Q(externstop_last));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam externstop_last_660.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i15 (.D(n8880), .CK(clk), .CD(n9561), .Q(n_temp1_7__N_355));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i15.GSR = "ENABLED";
    CCU2D add_4455_6 (.A0(\debounce_counters[4] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8304), .COUT(n8305));
    defparam add_4455_6.INIT0 = 16'h5555;
    defparam add_4455_6.INIT1 = 16'h5aaa;
    defparam add_4455_6.INJECT1_0 = "NO";
    defparam add_4455_6.INJECT1_1 = "NO";
    FD1P3IX c_state_FSM_i14 (.D(n_temp1_7__N_355), .SP(clk_enable_5), .CD(n9561), 
            .CK(clk), .Q(n_temp1_7__N_356));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i14.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i0 (.D(GPI_c_0), .SP(clk_enable_124), .CD(n9561), 
            .CK(clk), .Q(GPI_DAT[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(639[8] 645[15])
    defparam GPI_DAT__i0.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i13 (.D(n5301), .CK(clk), .CD(n9561), .Q(n_temp1_7__N_357));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i13.GSR = "ENABLED";
    FD1P3IX temp2__i0 (.D(wb_dat_o[0]), .SP(reg_rdy_N_1320), .CD(n9561), 
            .CK(clk), .Q(temp2[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp2__i0.GSR = "ENABLED";
    LUT4 i5274_4_lut (.A(n5726), .B(n48_adj_1416), .C(data0[3]), .D(n50), 
         .Z(data0_7__N_898[3])) /* synthesis lut_function=(!(A+(B+!(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i5274_4_lut.init = 16'h1011;
    FD1S3IX c_state_FSM_i12 (.D(n5299), .CK(clk), .CD(n9561), .Q(n_temp1_7__N_358));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i12.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i11 (.D(n5297), .CK(clk), .CD(n9561), .Q(n_temp1_7__N_359));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i11.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i10 (.D(n5295), .CK(clk), .CD(n9561), .Q(n_temp1_7__N_360));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i10.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i9 (.D(n5293), .CK(clk), .CD(n9561), .Q(reg_rdy_N_1322));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i9.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i8 (.D(n8396), .CK(clk), .CD(n9561), .Q(n_temp1_7__N_362));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i8.GSR = "ENABLED";
    FD1P3IX temp3__i0 (.D(wb_dat_o[0]), .SP(dat_rdy_N_1324), .CD(n9561), 
            .CK(clk), .Q(temp3[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp3__i0.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i0 (.D(n_wb_dat_i[0]), .CK(clk), .CD(n9561), .Q(wb_dat_i[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(763[1] 779[10])
    defparam wb_dat_i__i0.GSR = "ENABLED";
    FD1S3IX data0__i0 (.D(data0_7__N_898[0]), .CK(clk), .CD(n9561), .Q(data0[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(554[7] 567[14])
    defparam data0__i0.GSR = "ENABLED";
    FD1S3IX wb_adr_i__i1 (.D(n_wb_adr_i[0]), .CK(clk), .CD(n9561), .Q(wb_adr_i[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(763[1] 779[10])
    defparam wb_adr_i__i1.GSR = "ENABLED";
    FD1S3IX dat_count__i0 (.D(n_dat_count[0]), .CK(clk), .CD(n9561), .Q(dat_count[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(784[1] 798[10])
    defparam dat_count__i0.GSR = "ENABLED";
    BB BB1_scl (.I(i2c1_sclo), .T(i2c1_scloen), .B(SCL), .O(i2c1_scli)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=358, LSE_RLINE=358 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(154[14:16])
    FD1S3IX c_state_FSM_i7 (.D(n5289), .CK(clk), .CD(n9561), .Q(n_temp1_7__N_363));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i7.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i6 (.D(n8429), .CK(clk), .CD(n9561), .Q(dat_rdy_N_1326));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i6.GSR = "ENABLED";
    LUT4 i1_4_lut (.A(GPI_DAT[3]), .B(n5722), .C(temp1[5]), .D(temp1[6]), 
         .Z(n5726)) /* synthesis lut_function=(A (B (C (D)))+!A (B (C (D)+!C !(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i1_4_lut.init = 16'hc004;
    FD1S3IX c_state_FSM_i5 (.D(n8592), .CK(clk), .CD(n9561), .Q(n_temp1_7__N_365));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i5.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i4 (.D(n12_adj_1428), .CK(clk), .CD(n9561), .Q(n_temp1_7__N_366));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i4.GSR = "ENABLED";
    BB BB1_sda (.I(i2c1_sdao), .T(i2c1_sdaoen), .B(SDA), .O(i2c1_sdai)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=358, LSE_RLINE=358 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(150[14:16])
    FD1P3IX debounce_counters_1___i0 (.D(n210), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i0.GSR = "ENABLED";
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk)) /* synthesis NOM_FREQ="2.08", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "2.08";
    FD1S3IX c_state_FSM_i3 (.D(n8562), .CK(clk), .CD(n9561), .Q(n_temp1_7__N_367));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i0 (.D(n316), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i0.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i2 (.D(n5279), .CK(clk), .CD(n9561), .Q(n_temp1_7__N_368));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i2.GSR = "ENABLED";
    FD1P3AX forceoutputdisable_683 (.D(forceoutputdisable_N_8), .SP(clk_enable_9), 
            .CK(clk), .Q(forceoutputdisable));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam forceoutputdisable_683.GSR = "ENABLED";
    LUT4 i1665_2_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_360), 
         .D(n9566), .Z(n5294)) /* synthesis lut_function=(A (B (C (D))+!B (C))+!A (C)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1665_2_lut_3_lut_4_lut.init = 16'hf070;
    LUT4 n5749_bdd_4_lut_5367 (.A(n5749), .B(next_state[1]), .C(next_state[2]), 
         .D(next_state[0]), .Z(n9391)) /* synthesis lut_function=(!((B ((D)+!C)+!B !(C (D)))+!A)) */ ;
    defparam n5749_bdd_4_lut_5367.init = 16'h2080;
    LUT4 i5186_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_357), 
         .D(n_temp1_7__N_358), .Z(n9068)) /* synthesis lut_function=(A (B (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i5186_3_lut_4_lut.init = 16'h8880;
    LUT4 i1_2_lut_3_lut_rep_112_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n6942), 
         .D(n9536), .Z(n9532)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1_2_lut_3_lut_rep_112_4_lut.init = 16'h8000;
    LUT4 i1_3_lut (.A(temp1[6]), .B(n18_adj_1403), .C(data0[3]), .Z(n48_adj_1416)) /* synthesis lut_function=(A (B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i1_3_lut.init = 16'h8a8a;
    PFUMX i5302 (.BLUT(n9282), .ALUT(n9555), .C0(next_state[1]), .Z(n9283));
    LUT4 i1_2_lut_3_lut_4_lut_adj_79 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[6]), 
         .D(n_temp1_7__N_365), .Z(n_wb_dat_i[6])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_79.init = 16'h7000;
    LUT4 i1_2_lut_rep_137 (.A(next_state[3]), .B(next_state[2]), .Z(n9557)) /* synthesis lut_function=(A (B)) */ ;
    defparam i1_2_lut_rep_137.init = 16'h8888;
    FD1P3IX counter_i0_i4 (.D(n3088), .SP(clk_enable_188), .CD(n6024), 
            .CK(clk), .Q(counter[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i4.GSR = "ENABLED";
    LUT4 i3_4_lut (.A(temp1[0]), .B(n9540), .C(n9551), .D(temp1[1]), 
         .Z(n5585)) /* synthesis lut_function=((B+(C+!(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(561[13:23])
    defparam i3_4_lut.init = 16'hfdff;
    CCU2D add_138_7 (.A0(\debounce_counters[1] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8200), .COUT(n8201), .S0(n205), 
          .S1(n204));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_7.INIT0 = 16'h5aaa;
    defparam add_138_7.INIT1 = 16'h5aaa;
    defparam add_138_7.INJECT1_0 = "NO";
    defparam add_138_7.INJECT1_1 = "NO";
    CCU2D add_138_5 (.A0(\debounce_counters[1] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8199), .COUT(n8200), .S0(n207), 
          .S1(n206));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_5.INIT0 = 16'h5aaa;
    defparam add_138_5.INIT1 = 16'h5aaa;
    defparam add_138_5.INJECT1_0 = "NO";
    defparam add_138_5.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i3 (.D(n3089), .SP(clk_enable_188), .CD(n6024), 
            .CK(clk), .Q(counter[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i3.GSR = "ENABLED";
    CCU2D add_138_3 (.A0(\debounce_counters[1] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8198), .COUT(n8199), .S0(n209), 
          .S1(n208));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_3.INIT0 = 16'h5aaa;
    defparam add_138_3.INIT1 = 16'h5aaa;
    defparam add_138_3.INJECT1_0 = "NO";
    defparam add_138_3.INJECT1_1 = "NO";
    CCU2D add_138_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[1] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n8198), .S1(n210));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_1.INIT0 = 16'hF000;
    defparam add_138_1.INIT1 = 16'h5555;
    defparam add_138_1.INJECT1_0 = "NO";
    defparam add_138_1.INJECT1_1 = "NO";
    FD1P3AX DIGS3C_Shared_ReqSafeState_684 (.D(DIGS3C_Shared_ReqSafeState_N_1302), 
            .SP(clk_enable_12), .CK(clk), .Q(DIGS3C_Shared_ReqSafeState_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam DIGS3C_Shared_ReqSafeState_684.GSR = "ENABLED";
    LUT4 mux_1305_i19_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n4572), .D(n4470), .Z(n4504)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_1305_i19_3_lut_4_lut.init = 16'h7f70;
    FD1P3AX FP_SysLEDb_687 (.D(FP_SysLEDb_N_1289), .SP(clk_enable_14), .CK(clk), 
            .Q(FP_SysLEDb_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam FP_SysLEDb_687.GSR = "ENABLED";
    FD1P3AX FP_SysLEDg_688 (.D(FP_SysLEDg_N_1287), .SP(clk_enable_14), .CK(clk), 
            .Q(FP_SysLEDg_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam FP_SysLEDg_688.GSR = "ENABLED";
    FD1P3AX Carrier_PwrOn_690 (.D(Carrier_PG_3V3_N_1296), .SP(clk_enable_16), 
            .CK(clk), .Q(Carrier_PwrOn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam Carrier_PwrOn_690.GSR = "ENABLED";
    FD1P3AX Carrier_PG_3V3_691 (.D(Carrier_PG_3V3_N_1296), .SP(clk_enable_16), 
            .CK(clk), .Q(Carrier_PG_3V3_c)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam Carrier_PG_3V3_691.GSR = "ENABLED";
    FD1P3AX FP_SysLEDs_695 (.D(FP_SysLEDs_N_1301), .SP(clk_enable_17), .CK(clk), 
            .Q(FP_SysLEDs_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam FP_SysLEDs_695.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn1_i1 (.D(SysSW_Pwr_NC_c), .CK(clk), .Q(debounce_inputs_asyn1[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_inputs_asyn1_i1.GSR = "ENABLED";
    LUT4 mux_1305_i21_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n4572), .D(n4468), .Z(n4502)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_1305_i21_3_lut_4_lut.init = 16'h7f70;
    LUT4 mux_1305_i10_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n4572), .D(n4479), .Z(n4513)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_1305_i10_3_lut_4_lut.init = 16'h7f70;
    BB FPIO_FlexMIO28_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO28), 
       .O(FPIO_FlexMIO28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    FD1S3IX c_state_FSM_i16 (.D(n5307), .CK(clk), .CD(n9561), .Q(n_temp1_7__N_354));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i16.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i1 (.D(n5277), .CK(clk), .CD(n9561), .Q(n_temp1_7__N_369));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i1.GSR = "ENABLED";
    LUT4 ANL_S3C_CarrierReady_c_bdd_2_lut_5332 (.A(n9321), .B(next_state[2]), 
         .Z(n9322)) /* synthesis lut_function=(A (B)) */ ;
    defparam ANL_S3C_CarrierReady_c_bdd_2_lut_5332.init = 16'h8888;
    LUT4 mux_1305_i20_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n4572), .D(n4469), .Z(n4503)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_1305_i20_3_lut_4_lut.init = 16'h7f70;
    LUT4 mux_1305_i9_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(n4572), .D(n4480), .Z(n4514)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(C+(D)))+!A !(C+(D)))) */ ;
    defparam mux_1305_i9_3_lut_4_lut.init = 16'h7f70;
    LUT4 i2_4_lut (.A(wb_dat_o[2]), .B(n4_adj_1442), .C(clk_enable_5), 
         .D(n9004), .Z(n8429)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i2_4_lut.init = 16'heccc;
    FD1P3IX counter_i0_i2 (.D(n3090), .SP(clk_enable_188), .CD(n6024), 
            .CK(clk), .Q(counter[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i2.GSR = "ENABLED";
    LUT4 i5228_4_lut_4_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_1092[2]), 
         .C(next_state[1]), .D(n9538), .Z(n9110)) /* synthesis lut_function=(A (B+(C))+!A !(B ((D)+!C)+!B (C (D)))) */ ;
    defparam i5228_4_lut_4_lut_4_lut.init = 16'ha9f9;
    LUT4 i1_2_lut_rep_139 (.A(next_state[3]), .B(next_state[2]), .Z(n9559)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_rep_139.init = 16'heeee;
    CCU2D add_4455_4 (.A0(\debounce_counters[4] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8303), .COUT(n8304));
    defparam add_4455_4.INIT0 = 16'h5555;
    defparam add_4455_4.INIT1 = 16'h5555;
    defparam add_4455_4.INJECT1_0 = "NO";
    defparam add_4455_4.INJECT1_1 = "NO";
    LUT4 externstop_falling_bdd_4_lut (.A(externstop_falling), .B(next_state[1]), 
         .C(next_state[0]), .D(n8992), .Z(n9114)) /* synthesis lut_function=(A (B+(C))+!A (B (C+(D)))) */ ;
    defparam externstop_falling_bdd_4_lut.init = 16'hece8;
    LUT4 i3441_2_lut_3_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[1]), 
         .Z(FPIO_isoCtrlRSTn_N_1290)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;
    defparam i3441_2_lut_3_lut.init = 16'h1010;
    CCU2D add_156_5 (.A0(\debounce_counters[3] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8231), .COUT(n8232), .S0(n419), 
          .S1(n418));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_5.INIT0 = 16'h5aaa;
    defparam add_156_5.INIT1 = 16'h5aaa;
    defparam add_156_5.INJECT1_0 = "NO";
    defparam add_156_5.INJECT1_1 = "NO";
    CCU2D add_147_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[2] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n8214), .S1(n316));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_1.INIT0 = 16'hF000;
    defparam add_147_1.INIT1 = 16'h5555;
    defparam add_147_1.INJECT1_0 = "NO";
    defparam add_147_1.INJECT1_1 = "NO";
    CCU2D add_787_3 (.A0(counter[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8262), .COUT(n8263), .S0(n3091), .S1(n3090));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1482[17:24])
    defparam add_787_3.INIT0 = 16'h5555;
    defparam add_787_3.INIT1 = 16'h5555;
    defparam add_787_3.INJECT1_0 = "NO";
    defparam add_787_3.INJECT1_1 = "NO";
    CCU2D add_4455_2 (.A0(\debounce_counters[4] [7]), .B0(\debounce_counters[4] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[4] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n8303));
    defparam add_4455_2.INIT0 = 16'h1000;
    defparam add_4455_2.INIT1 = 16'h5aaa;
    defparam add_4455_2.INJECT1_0 = "NO";
    defparam add_4455_2.INJECT1_1 = "NO";
    CCU2D add_4456_26 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8302), .S1(clk_enable_126));
    defparam add_4456_26.INIT0 = 16'hf555;
    defparam add_4456_26.INIT1 = 16'h0000;
    defparam add_4456_26.INJECT1_0 = "NO";
    defparam add_4456_26.INJECT1_1 = "NO";
    CCU2D add_4456_24 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8301), .COUT(n8302));
    defparam add_4456_24.INIT0 = 16'h5555;
    defparam add_4456_24.INIT1 = 16'h5555;
    defparam add_4456_24.INJECT1_0 = "NO";
    defparam add_4456_24.INJECT1_1 = "NO";
    FD1S3AY debounce_inputs_asyn1_i4 (.D(FP_UsrSW1_c), .CK(clk), .Q(debounce_inputs_asyn1[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_inputs_asyn1_i4.GSR = "ENABLED";
    LUT4 i1_4_lut_4_lut (.A(next_state[3]), .B(next_state[2]), .C(n9560), 
         .D(n18_adj_1426), .Z(clk_enable_185)) /* synthesis lut_function=(A (B+(C))+!A (B (C+(D))+!B (D))) */ ;
    defparam i1_4_lut_4_lut.init = 16'hfde8;
    LUT4 i1_4_lut_adj_80 (.A(n7086), .B(dat_rdy_N_1326), .C(n8998), .D(clk_enable_5), 
         .Z(n4_adj_1442)) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_80.init = 16'ha0ec;
    CCU2D add_787_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n8262), .S1(n3092));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1482[17:24])
    defparam add_787_1.INIT0 = 16'hF000;
    defparam add_787_1.INIT1 = 16'h5555;
    defparam add_787_1.INJECT1_0 = "NO";
    defparam add_787_1.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_140 (.A(next_state[0]), .B(next_state[1]), .Z(n9560)) /* synthesis lut_function=(A (B)) */ ;
    defparam i1_2_lut_rep_140.init = 16'h8888;
    LUT4 i19_4_lut (.A(n_temp1_7__N_365), .B(n1), .C(clk_enable_5), .D(n8964), 
         .Z(n8592)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i19_4_lut.init = 16'hfaca;
    LUT4 i3498_2_lut_3_lut (.A(next_state[0]), .B(next_state[1]), .C(next_state[2]), 
         .Z(n14_adj_1434)) /* synthesis lut_function=(!(A (B+(C))+!A (C))) */ ;
    defparam i3498_2_lut_3_lut.init = 16'h0707;
    LUT4 n3228_bdd_2_lut_5392 (.A(n9416), .B(n9538), .Z(n9417)) /* synthesis lut_function=(A+!(B)) */ ;
    defparam n3228_bdd_2_lut_5392.init = 16'hbbbb;
    LUT4 i1_4_lut_adj_81 (.A(temp1[6]), .B(data0[2]), .C(n30), .D(n33), 
         .Z(data0_7__N_898[2])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i1_4_lut_adj_81.init = 16'hdc50;
    CCU2D add_4456_22 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8300), .COUT(n8301));
    defparam add_4456_22.INIT0 = 16'h5555;
    defparam add_4456_22.INIT1 = 16'h5555;
    defparam add_4456_22.INJECT1_0 = "NO";
    defparam add_4456_22.INJECT1_1 = "NO";
    CCU2D add_156_3 (.A0(\debounce_counters[3] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8230), .COUT(n8231), .S0(n421), 
          .S1(n420));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_3.INIT0 = 16'h5aaa;
    defparam add_156_3.INIT1 = 16'h5aaa;
    defparam add_156_3.INJECT1_0 = "NO";
    defparam add_156_3.INJECT1_1 = "NO";
    CCU2D add_165_33 (.A0(\debounce_counters[4] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8261), .S0(n497));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_33.INIT0 = 16'h5aaa;
    defparam add_165_33.INIT1 = 16'h0000;
    defparam add_165_33.INJECT1_0 = "NO";
    defparam add_165_33.INJECT1_1 = "NO";
    LUT4 i1_2_lut (.A(wb_dat_o[4]), .B(n_temp1_7__N_363), .Z(n1)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_2_lut.init = 16'h8888;
    CCU2D add_4456_20 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8299), .COUT(n8300));
    defparam add_4456_20.INIT0 = 16'h5555;
    defparam add_4456_20.INIT1 = 16'h5555;
    defparam add_4456_20.INJECT1_0 = "NO";
    defparam add_4456_20.INJECT1_1 = "NO";
    LUT4 i56_4_lut (.A(GPI_DAT[2]), .B(data0[2]), .C(temp1[5]), .D(n5722), 
         .Z(n30)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i56_4_lut.init = 16'hcac0;
    CCU2D add_4456_18 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8298), .COUT(n8299));
    defparam add_4456_18.INIT0 = 16'h5555;
    defparam add_4456_18.INIT1 = 16'h5555;
    defparam add_4456_18.INJECT1_0 = "NO";
    defparam add_4456_18.INJECT1_1 = "NO";
    LUT4 i1_4_lut_4_lut_adj_82 (.A(clk_enable_5), .B(wb_dat_o[2]), .C(n_temp1_7__N_356), 
         .D(n_temp1_7__N_357), .Z(n5301)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A (D)) */ ;
    defparam i1_4_lut_4_lut_adj_82.init = 16'hf7a0;
    CCU2D add_156_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[3] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n8230), .S1(n422));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_1.INIT0 = 16'hF000;
    defparam add_156_1.INIT1 = 16'h5555;
    defparam add_156_1.INJECT1_0 = "NO";
    defparam add_156_1.INJECT1_1 = "NO";
    PFUMX i5430 (.BLUT(n9567), .ALUT(n9568), .C0(temp1[2]), .Z(n6942));
    LUT4 i25_4_lut (.A(n_temp1_7__N_366), .B(n14_adj_1430), .C(clk_enable_5), 
         .D(n4), .Z(n12_adj_1428)) /* synthesis lut_function=(!(A (B (C (D)))+!A (B ((D)+!C)+!B !(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i25_4_lut.init = 16'h3afa;
    LUT4 i1_4_lut_adj_83 (.A(temp1[6]), .B(data0[1]), .C(n30_adj_1421), 
         .D(n33), .Z(data0_7__N_898[1])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i1_4_lut_adj_83.init = 16'hdc50;
    LUT4 i1_2_lut_3_lut_adj_84 (.A(next_state[0]), .B(next_state[3]), .C(next_state[2]), 
         .Z(Carrier_PG_3V3_N_1296)) /* synthesis lut_function=(!((B+(C))+!A)) */ ;
    defparam i1_2_lut_3_lut_adj_84.init = 16'h0202;
    LUT4 PG_Module_I_0_1_lut_rep_141 (.A(PG_Module_c), .Z(n9561)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(375[10:25])
    defparam PG_Module_I_0_1_lut_rep_141.init = 16'h5555;
    LUT4 i56_4_lut_adj_85 (.A(GPI_DAT[1]), .B(data0[1]), .C(temp1[5]), 
         .D(n5722), .Z(n30_adj_1421)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i56_4_lut_adj_85.init = 16'hcac0;
    LUT4 i1503_3_lut_4_lut_4_lut (.A(PG_Module_c), .B(reg_rdy), .C(n9537), 
         .D(n9552), .Z(clk_enable_124)) /* synthesis lut_function=(!(A ((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(375[10:25])
    defparam i1503_3_lut_4_lut_4_lut.init = 16'h555d;
    LUT4 i1502_4_lut_4_lut (.A(PG_Module_c), .B(n4_adj_1418), .C(n9044), 
         .D(n9540), .Z(clk_enable_134)) /* synthesis lut_function=(!(A ((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(375[10:25])
    defparam i1502_4_lut_4_lut.init = 16'h555d;
    LUT4 i3418_2_lut_3_lut_4_lut (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[2]), .D(next_state[3]), .Z(Carrier_PG_1V8_N_1397)) /* synthesis lut_function=(A ((C+(D))+!B)+!A (B+(C+(D)))) */ ;
    defparam i3418_2_lut_3_lut_4_lut.init = 16'hfff6;
    LUT4 next_state_3__bdd_2_lut_5420 (.A(next_state[2]), .B(n25), .Z(n9415)) /* synthesis lut_function=(A+!(B)) */ ;
    defparam next_state_3__bdd_2_lut_5420.init = 16'hbbbb;
    LUT4 i1_2_lut_3_lut_adj_86 (.A(next_state[0]), .B(next_state[1]), .C(next_state[2]), 
         .Z(n8966)) /* synthesis lut_function=(!(A (B+!(C))+!A !(B (C)))) */ ;
    defparam i1_2_lut_3_lut_adj_86.init = 16'h6060;
    LUT4 i1670_4_lut_4_lut (.A(clk_enable_5), .B(wb_dat_o[2]), .C(n_temp1_7__N_357), 
         .D(n_temp1_7__N_358), .Z(n5299)) /* synthesis lut_function=(A (B (C))+!A (D)) */ ;
    defparam i1670_4_lut_4_lut.init = 16'hd580;
    LUT4 i1_2_lut_adj_87 (.A(n_temp1_7__N_362), .B(n_temp1_7__N_360), .Z(n9035)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_2_lut_adj_87.init = 16'heeee;
    LUT4 i1496_2_lut (.A(clk_enable_4), .B(debounce_inputs_asyn2[1]), .Z(clk_enable_117)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i1496_2_lut.init = 16'hdddd;
    FD1S3AY debounce_inputs_asyn1_i3 (.D(FP_UsrSW3_c), .CK(clk), .Q(debounce_inputs_asyn1[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_inputs_asyn1_i3.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn1_i2 (.D(FlexMio61ExternalStop_c_c), .CK(clk), 
            .Q(debounce_inputs_asyn1[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_inputs_asyn1_i2.GSR = "ENABLED";
    LUT4 i3_4_lut_adj_88 (.A(n3_adj_1437), .B(n6_adj_1415), .C(n3778), 
         .D(n_temp1_7__N_359), .Z(n8562)) /* synthesis lut_function=(A+(B+(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i3_4_lut_adj_88.init = 16'hfeee;
    FD1P3IX counter_i0_i1 (.D(n3091), .SP(clk_enable_188), .CD(n6024), 
            .CK(clk), .Q(counter[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i1.GSR = "ENABLED";
    LUT4 i2_4_lut_adj_89 (.A(clk_enable_5), .B(n6946), .C(n9530), .D(wb_dat_o[2]), 
         .Z(n3_adj_1437)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i2_4_lut_adj_89.init = 16'h8000;
    LUT4 i1_3_lut_adj_90 (.A(n_state_7__N_984[3]), .B(n_temp1_7__N_366), 
         .C(reg_rdy_N_1322), .Z(n5_adj_1436)) /* synthesis lut_function=(A (B)+!A (B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_3_lut_adj_90.init = 16'hdcdc;
    LUT4 i1664_4_lut_4_lut (.A(clk_enable_5), .B(wb_dat_o[2]), .C(n_temp1_7__N_360), 
         .D(reg_rdy_N_1322), .Z(n5293)) /* synthesis lut_function=(A (B (C))+!A (D)) */ ;
    defparam i1664_4_lut_4_lut.init = 16'hd580;
    LUT4 mux_434_i4_3_lut_4_lut (.A(n6946), .B(clk_enable_5), .C(n2016), 
         .D(dat_count[3]), .Z(n_dat_count_7__N_423[3])) /* synthesis lut_function=(A (D)+!A (B (C)+!B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1185[7] 1204[12])
    defparam mux_434_i4_3_lut_4_lut.init = 16'hfb40;
    LUT4 i1_2_lut_rep_113 (.A(n8498), .B(n5668), .Z(n9533)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(482[12:28])
    defparam i1_2_lut_rep_113.init = 16'heeee;
    CCU2D add_165_31 (.A0(\debounce_counters[4] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8260), .COUT(n8261), .S0(n499), 
          .S1(n498));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_31.INIT0 = 16'h5aaa;
    defparam add_165_31.INIT1 = 16'h5aaa;
    defparam add_165_31.INJECT1_0 = "NO";
    defparam add_165_31.INJECT1_1 = "NO";
    LUT4 i3413_3_lut_3_lut (.A(n8498), .B(n5668), .C(n9102), .Z(FP_UsrLED_c_3)) /* synthesis lut_function=((B+!(C))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(482[12:28])
    defparam i3413_3_lut_3_lut.init = 16'hdfdf;
    LUT4 i1_4_lut_adj_91 (.A(clk_enable_5), .B(n_temp1_7__N_366), .C(n2_adj_1410), 
         .D(n3), .Z(n_wb_dat_i[3])) /* synthesis lut_function=(!(A+!(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_91.init = 16'h5554;
    LUT4 i1_2_lut_adj_92 (.A(data0[3]), .B(n_temp1_7__N_365), .Z(n2_adj_1410)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_2_lut_adj_92.init = 16'h8888;
    CCU2D add_138_33 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8213), .S0(n179));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_33.INIT0 = 16'h5aaa;
    defparam add_138_33.INIT1 = 16'h0000;
    defparam add_138_33.INJECT1_0 = "NO";
    defparam add_138_33.INJECT1_1 = "NO";
    CCU2D add_4456_16 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8297), .COUT(n8298));
    defparam add_4456_16.INIT0 = 16'h5555;
    defparam add_4456_16.INIT1 = 16'h5555;
    defparam add_4456_16.INJECT1_0 = "NO";
    defparam add_4456_16.INJECT1_1 = "NO";
    LUT4 i1497_2_lut (.A(clk_enable_127), .B(debounce_inputs_asyn2[2]), 
         .Z(clk_enable_86)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i1497_2_lut.init = 16'hdddd;
    PFUMX i5317 (.BLUT(n9320), .ALUT(n9319), .C0(n9538), .Z(n9321));
    LUT4 i1650_4_lut (.A(n_temp1_7__N_368), .B(clk_enable_5), .C(n_temp1_7__N_365), 
         .D(n9007), .Z(n5279)) /* synthesis lut_function=(A ((C+(D))+!B)+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1650_4_lut.init = 16'heae2;
    CCU2D add_165_29 (.A0(\debounce_counters[4] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8259), .COUT(n8260), .S0(n501), 
          .S1(n500));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_29.INIT0 = 16'h5aaa;
    defparam add_165_29.INIT1 = 16'h5aaa;
    defparam add_165_29.INJECT1_0 = "NO";
    defparam add_165_29.INJECT1_1 = "NO";
    LUT4 i3_4_lut_adj_93 (.A(n7141), .B(n9536), .C(n_temp1_7__N_359), 
         .D(n6942), .Z(n3)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i3_4_lut_adj_93.init = 16'h8000;
    CCU2D add_138_31 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8212), .COUT(n8213), .S0(n181), 
          .S1(n180));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_31.INIT0 = 16'h5aaa;
    defparam add_138_31.INIT1 = 16'h5aaa;
    defparam add_138_31.INJECT1_0 = "NO";
    defparam add_138_31.INJECT1_1 = "NO";
    LUT4 i5296_4_lut (.A(clk_enable_5), .B(n_temp1_7__N_366), .C(n9078), 
         .D(n9564), .Z(n_wb_dat_i[2])) /* synthesis lut_function=(!(A+!(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i5296_4_lut.init = 16'h5554;
    LUT4 next_state_3__bdd_4_lut_5417 (.A(next_state[3]), .B(next_state[2]), 
         .C(next_state[1]), .D(next_state[0]), .Z(clk_enable_17)) /* synthesis lut_function=(A (B+(C (D)+!C !(D)))+!A (B (C+(D)))) */ ;
    defparam next_state_3__bdd_4_lut_5417.init = 16'hecca;
    FD1S3IX dat_rdy_del_665 (.D(dat_rdy), .CK(clk), .CD(n9561), .Q(dat_rdy_del));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(532[7] 545[11])
    defparam dat_rdy_del_665.GSR = "ENABLED";
    LUT4 mux_1296_i19_4_lut_4_lut (.A(next_state[1]), .B(n4566), .C(n4570), 
         .D(n3074), .Z(n4470)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_1296_i19_4_lut_4_lut.init = 16'hf5c5;
    LUT4 mux_1082_Mux_12_i15_4_lut (.A(PPn_VIN_c), .B(next_state[3]), .C(next_state[2]), 
         .D(next_state[1]), .Z(forceoutputdisable_N_8)) /* synthesis lut_function=(!(A (B (C+!(D))+!B (C))+!A (B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam mux_1082_Mux_12_i15_4_lut.init = 16'h1f17;
    LUT4 i58_4_lut_4_lut (.A(n9538), .B(next_state[1]), .C(n4846), .D(next_state[3]), 
         .Z(n29)) /* synthesis lut_function=(!(A (B (D)+!B (C+!(D)))+!A (B+(C+!(D))))) */ ;
    defparam i58_4_lut_4_lut.init = 16'h0388;
    VLO i1 (.Z(GND_net));
    CCU2D add_4456_14 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8296), .COUT(n8297));
    defparam add_4456_14.INIT0 = 16'h5555;
    defparam add_4456_14.INIT1 = 16'h5555;
    defparam add_4456_14.INJECT1_0 = "NO";
    defparam add_4456_14.INJECT1_1 = "NO";
    LUT4 i2_3_lut_4_lut (.A(temp1[5]), .B(n9550), .C(temp1[0]), .D(n68), 
         .Z(n50)) /* synthesis lut_function=(A+(B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i2_3_lut_4_lut.init = 16'hffef;
    CCU2D add_147_33 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8229), .S0(n285));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_33.INIT0 = 16'h5aaa;
    defparam add_147_33.INIT1 = 16'h0000;
    defparam add_147_33.INJECT1_0 = "NO";
    defparam add_147_33.INJECT1_1 = "NO";
    TSALL TSALL_INST (.TSALL(GND_net));
    LUT4 i5196_2_lut (.A(data0[2]), .B(n_temp1_7__N_365), .Z(n9078)) /* synthesis lut_function=(A (B)) */ ;
    defparam i5196_2_lut.init = 16'h8888;
    CCU2D add_4456_12 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8295), .COUT(n8296));
    defparam add_4456_12.INIT0 = 16'h5555;
    defparam add_4456_12.INIT1 = 16'h5555;
    defparam add_4456_12.INJECT1_0 = "NO";
    defparam add_4456_12.INJECT1_1 = "NO";
    LUT4 pushed_4__I_0_1_lut (.A(pushed[4]), .Z(pushed_4__N_296)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(460[17] 464[24])
    defparam pushed_4__I_0_1_lut.init = 16'h5555;
    LUT4 pushed_3__I_0_1_lut (.A(pushed[3]), .Z(pushed_3__N_298)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(460[17] 464[24])
    defparam pushed_3__I_0_1_lut.init = 16'h5555;
    LUT4 pushed_2__I_0_1_lut (.A(pushed[2]), .Z(pushed_2__N_300)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(460[17] 464[24])
    defparam pushed_2__I_0_1_lut.init = 16'h5555;
    LUT4 i1_2_lut_rep_117_3_lut_4_lut (.A(temp1[5]), .B(n9550), .C(n9549), 
         .D(temp1[6]), .Z(n9537)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i1_2_lut_rep_117_3_lut_4_lut.init = 16'hfffe;
    LUT4 n7_bdd_3_lut_4_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_1092[2]), 
         .C(next_state[3]), .D(n9554), .Z(n9470)) /* synthesis lut_function=(!(A ((C)+!B)+!A !(B ((D)+!C)))) */ ;
    defparam n7_bdd_3_lut_4_lut_4_lut.init = 16'h4c0c;
    LUT4 i1_4_lut_adj_94 (.A(wb_dat_o[7]), .B(temp1[7]), .C(n9542), .D(n9068), 
         .Z(n_temp1[7])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_94.init = 16'ha0ec;
    CCU2D add_4456_10 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8294), .COUT(n8295));
    defparam add_4456_10.INIT0 = 16'h5555;
    defparam add_4456_10.INIT1 = 16'h5555;
    defparam add_4456_10.INJECT1_0 = "NO";
    defparam add_4456_10.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_95 (.A(n_state_7__N_1040[4]), .B(temp1[6]), .C(n9542), 
         .D(n9068), .Z(n_temp1[6])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_95.init = 16'ha0ec;
    CCU2D add_4456_8 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8293), .COUT(n8294));
    defparam add_4456_8.INIT0 = 16'h5555;
    defparam add_4456_8.INIT1 = 16'h5aaa;
    defparam add_4456_8.INJECT1_0 = "NO";
    defparam add_4456_8.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_96 (.A(wb_dat_o[5]), .B(temp1[5]), .C(n9542), .D(n9068), 
         .Z(n_temp1[5])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_96.init = 16'ha0ec;
    LUT4 i1498_2_lut (.A(clk_enable_126), .B(debounce_inputs_asyn2[3]), 
         .Z(clk_enable_178)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i1498_2_lut.init = 16'hdddd;
    FD1S3IX wb_we_i_678 (.D(n_wb_we_i), .CK(clk), .CD(n9561), .Q(wb_we_i));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(763[1] 779[10])
    defparam wb_we_i_678.GSR = "ENABLED";
    CCU2D add_4456_6 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8292), .COUT(n8293));
    defparam add_4456_6.INIT0 = 16'h5555;
    defparam add_4456_6.INIT1 = 16'h5aaa;
    defparam add_4456_6.INJECT1_0 = "NO";
    defparam add_4456_6.INJECT1_1 = "NO";
    FD1S3IX wb_stb_i_676 (.D(n_wb_adr_i[6]), .CK(clk), .CD(n9561), .Q(wb_stb_i));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(763[1] 779[10])
    defparam wb_stb_i_676.GSR = "ENABLED";
    CCU2D add_165_27 (.A0(\debounce_counters[4] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8258), .COUT(n8259), .S0(n503), 
          .S1(n502));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_27.INIT0 = 16'h5aaa;
    defparam add_165_27.INIT1 = 16'h5aaa;
    defparam add_165_27.INJECT1_0 = "NO";
    defparam add_165_27.INJECT1_1 = "NO";
    CCU2D add_138_9 (.A0(\debounce_counters[1] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8201), .COUT(n8202), .S0(n203), 
          .S1(n202));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_9.INIT0 = 16'h5aaa;
    defparam add_138_9.INIT1 = 16'h5aaa;
    defparam add_138_9.INJECT1_0 = "NO";
    defparam add_138_9.INJECT1_1 = "NO";
    FD1S3IX dat_rdy_664 (.D(dat_rdy_N_1324), .CK(clk), .CD(n9561), .Q(dat_rdy));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(532[7] 545[11])
    defparam dat_rdy_664.GSR = "ENABLED";
    LUT4 n7_bdd_4_lut_5400 (.A(n9538), .B(next_state_3__N_1092[2]), .C(next_state[3]), 
         .D(next_state[0]), .Z(n9469)) /* synthesis lut_function=(!(A (B (C)+!B !((D)+!C))+!A (B+!(C (D))))) */ ;
    defparam n7_bdd_4_lut_5400.init = 16'h3a0a;
    FD1P3AX i645_697 (.D(Carrier_PG_1V8_N_1397), .SP(Carrier_PG_1V8_N_1390), 
            .CK(clk), .Q(Carrier_PG_1V8_N_1300));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam i645_697.GSR = "ENABLED";
    FD1S3IX reg_rdy_662 (.D(reg_rdy_N_1320), .CK(clk), .CD(n9561), .Q(reg_rdy));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(514[1] 527[9])
    defparam reg_rdy_662.GSR = "ENABLED";
    LUT4 i1_4_lut_adj_97 (.A(wb_dat_o[4]), .B(temp1[4]), .C(n9542), .D(n9068), 
         .Z(n_temp1[4])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_97.init = 16'ha0ec;
    LUT4 i3453_3_lut_3_lut_3_lut (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[2]), .Z(n7)) /* synthesis lut_function=(!(A (C)+!A !(B+!(C)))) */ ;
    defparam i3453_3_lut_3_lut_3_lut.init = 16'h4f4f;
    CCU2D add_4456_4 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8291), .COUT(n8292));
    defparam add_4456_4.INIT0 = 16'h5555;
    defparam add_4456_4.INIT1 = 16'h5555;
    defparam add_4456_4.INJECT1_0 = "NO";
    defparam add_4456_4.INJECT1_1 = "NO";
    CCU2D add_138_29 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8211), .COUT(n8212), .S0(n183), 
          .S1(n182));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_29.INIT0 = 16'h5aaa;
    defparam add_138_29.INIT1 = 16'h5aaa;
    defparam add_138_29.INJECT1_0 = "NO";
    defparam add_138_29.INJECT1_1 = "NO";
    CCU2D add_147_31 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8228), .COUT(n8229), .S0(n287), 
          .S1(n286));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_31.INIT0 = 16'h5aaa;
    defparam add_147_31.INIT1 = 16'h5aaa;
    defparam add_147_31.INJECT1_0 = "NO";
    defparam add_147_31.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i0 (.D(n422), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i0.GSR = "ENABLED";
    CCU2D add_165_25 (.A0(\debounce_counters[4] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8257), .COUT(n8258), .S0(n505), 
          .S1(n504));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_25.INIT0 = 16'h5aaa;
    defparam add_165_25.INIT1 = 16'h5aaa;
    defparam add_165_25.INJECT1_0 = "NO";
    defparam add_165_25.INJECT1_1 = "NO";
    CCU2D add_138_27 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8210), .COUT(n8211), .S0(n185), 
          .S1(n184));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_27.INIT0 = 16'h5aaa;
    defparam add_138_27.INIT1 = 16'h5aaa;
    defparam add_138_27.INJECT1_0 = "NO";
    defparam add_138_27.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i31 (.D(n497), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i31.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i30 (.D(n498), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i29 (.D(n499), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i29.GSR = "ENABLED";
    CCU2D add_165_23 (.A0(\debounce_counters[4] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8256), .COUT(n8257), .S0(n507), 
          .S1(n506));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_23.INIT0 = 16'h5aaa;
    defparam add_165_23.INIT1 = 16'h5aaa;
    defparam add_165_23.INJECT1_0 = "NO";
    defparam add_165_23.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i0 (.D(n3092), .SP(clk_enable_188), .CD(n6024), 
            .CK(clk), .Q(counter[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i0.GSR = "ENABLED";
    FD1P3IX counter_i0_i7 (.D(n3085), .SP(clk_enable_188), .CD(n6024), 
            .CK(clk), .Q(counter[7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i7.GSR = "ENABLED";
    CCU2D add_165_21 (.A0(\debounce_counters[4] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8255), .COUT(n8256), .S0(n509), 
          .S1(n508));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_21.INIT0 = 16'h5aaa;
    defparam add_165_21.INIT1 = 16'h5aaa;
    defparam add_165_21.INJECT1_0 = "NO";
    defparam add_165_21.INJECT1_1 = "NO";
    CCU2D add_4456_2 (.A0(\debounce_counters[3] [7]), .B0(\debounce_counters[3] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[3] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n8291));
    defparam add_4456_2.INIT0 = 16'h1000;
    defparam add_4456_2.INIT1 = 16'h5aaa;
    defparam add_4456_2.INJECT1_0 = "NO";
    defparam add_4456_2.INJECT1_1 = "NO";
    FD1P3AX next_state_i1 (.D(next_state_3__N_69[1]), .SP(clk_enable_26), 
            .CK(clk), .Q(next_state[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam next_state_i1.GSR = "ENABLED";
    CCU2D add_147_29 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8227), .COUT(n8228), .S0(n289), 
          .S1(n288));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_29.INIT0 = 16'h5aaa;
    defparam add_147_29.INIT1 = 16'h5aaa;
    defparam add_147_29.INJECT1_0 = "NO";
    defparam add_147_29.INJECT1_1 = "NO";
    L6MUX21 i5426 (.D0(n9519), .D1(n9516), .SD(next_state[1]), .Z(clk_enable_188));
    FD1P3IX debounce_counters_4___i28 (.D(n500), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i27 (.D(n501), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i26 (.D(n502), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i25 (.D(n503), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i24 (.D(n504), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i23 (.D(n505), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i22 (.D(n506), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i21 (.D(n507), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i20 (.D(n508), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i19 (.D(n509), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i18 (.D(n510), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i17 (.D(n511), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i16 (.D(n512), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i16.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i0 (.D(n130), .CK(clk), .Q(resetcounter[0])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i0.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i15 (.D(n513), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i15.GSR = "ENABLED";
    CCU2D add_4457_26 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8290), .S1(clk_enable_127));
    defparam add_4457_26.INIT0 = 16'hf555;
    defparam add_4457_26.INIT1 = 16'h0000;
    defparam add_4457_26.INJECT1_0 = "NO";
    defparam add_4457_26.INJECT1_1 = "NO";
    CCU2D add_138_25 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8209), .COUT(n8210), .S0(n187), 
          .S1(n186));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_25.INIT0 = 16'h5aaa;
    defparam add_138_25.INIT1 = 16'h5aaa;
    defparam add_138_25.INJECT1_0 = "NO";
    defparam add_138_25.INJECT1_1 = "NO";
    LUT4 i5229_4_lut_4_lut (.A(next_state[0]), .B(n8992), .C(next_state[1]), 
         .D(externstop_falling), .Z(n9111)) /* synthesis lut_function=(!(A (B (C)+!B (C+!(D)))+!A !((D)+!C))) */ ;
    defparam i5229_4_lut_4_lut.init = 16'h5f0d;
    CCU2D add_165_19 (.A0(\debounce_counters[4] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8254), .COUT(n8255), .S0(n511), 
          .S1(n510));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_19.INIT0 = 16'h5aaa;
    defparam add_165_19.INIT1 = 16'h5aaa;
    defparam add_165_19.INJECT1_0 = "NO";
    defparam add_165_19.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_124_3_lut_3_lut (.A(next_state[0]), .B(externstop_falling), 
         .C(signals_debounced_syn[4]), .Z(n9544)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;
    defparam i1_2_lut_rep_124_3_lut_3_lut.init = 16'h1010;
    LUT4 i1_4_lut_adj_98 (.A(wb_dat_o[3]), .B(temp1[3]), .C(n9542), .D(n9068), 
         .Z(n_temp1[3])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_98.init = 16'ha0ec;
    LUT4 i1_4_lut_adj_99 (.A(n_temp1_7__N_365), .B(dat_count[4]), .C(n2015), 
         .D(n9531), .Z(n12_adj_1409)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_99.init = 16'ha088;
    PFUMX i5424 (.BLUT(n9518), .ALUT(n9517), .C0(next_state[0]), .Z(n9519));
    LUT4 FPIO_isoCtrlRSTn_N_1294_bdd_4_lut_4_lut (.A(next_state[0]), .B(next_state[2]), 
         .C(n7081), .D(n9538), .Z(n9515)) /* synthesis lut_function=(A (D)+!A !(B (C))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1294_bdd_4_lut_4_lut.init = 16'hbf15;
    LUT4 i3464_3_lut (.A(next_state[3]), .B(next_state[2]), .C(n6_adj_1433), 
         .Z(DIGS3C_Shared_ReqSafeState_N_1302)) /* synthesis lut_function=(!(A (B)+!A !((C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam i3464_3_lut.init = 16'h7373;
    FD1P3IX debounce_counters_4___i14 (.D(n514), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i13 (.D(n515), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i12 (.D(n516), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i11 (.D(n517), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i10 (.D(n518), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i9 (.D(n519), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i8 (.D(n520), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i7 (.D(n521), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i6 (.D(n522), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i5 (.D(n523), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i4 (.D(n524), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i3 (.D(n525), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i2 (.D(n526), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i1 (.D(n527), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i0 (.D(n528), .SP(clk_enable_55), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_4___i0.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i31 (.D(n285), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i31.GSR = "ENABLED";
    PFUMX i5233 (.BLUT(n9113), .ALUT(n9114), .C0(next_state[2]), .Z(n9115));
    FD1P3IX debounce_counters_2___i30 (.D(n286), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i29 (.D(n287), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i28 (.D(n288), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i27 (.D(n289), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i26 (.D(n290), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i25 (.D(n291), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i24 (.D(n292), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i23 (.D(n293), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i22 (.D(n294), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i21 (.D(n295), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i20 (.D(n296), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i19 (.D(n297), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i18 (.D(n298), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i17 (.D(n299), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i16 (.D(n300), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i15 (.D(n301), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i14 (.D(n302), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i13 (.D(n303), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i12 (.D(n304), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i11 (.D(n305), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i10 (.D(n306), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i9 (.D(n307), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i8 (.D(n308), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i7 (.D(n309), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i6 (.D(n310), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i5 (.D(n311), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i4 (.D(n312), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i3 (.D(n313), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i2 (.D(n314), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i1 (.D(n315), .SP(clk_enable_86), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_2___i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i31 (.D(n179), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i31.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i30 (.D(n180), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i29 (.D(n181), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i28 (.D(n182), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i27 (.D(n183), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i26 (.D(n184), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i25 (.D(n185), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i24 (.D(n186), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i23 (.D(n187), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i22 (.D(n188), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i21 (.D(n189), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i20 (.D(n190), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i19 (.D(n191), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i18 (.D(n192), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i17 (.D(n193), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i16 (.D(n194), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i15 (.D(n195), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i14 (.D(n196), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i13 (.D(n197), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i12 (.D(n198), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i11 (.D(n199), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i10 (.D(n200), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i9 (.D(n201), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i8 (.D(n202), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i7 (.D(n203), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i6 (.D(n204), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i5 (.D(n205), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i4 (.D(n206), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i3 (.D(n207), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i2 (.D(n208), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i1 (.D(n209), .SP(clk_enable_117), .CD(debounce_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_1___i1.GSR = "ENABLED";
    FD1S3IX dat_count__i7 (.D(n_dat_count[7]), .CK(clk), .CD(n9561), .Q(dat_count[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(784[1] 798[10])
    defparam dat_count__i7.GSR = "ENABLED";
    FD1S3IX dat_count__i6 (.D(n_dat_count[6]), .CK(clk), .CD(n9561), .Q(dat_count[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(784[1] 798[10])
    defparam dat_count__i6.GSR = "ENABLED";
    FD1S3IX dat_count__i5 (.D(n_dat_count[5]), .CK(clk), .CD(n9561), .Q(dat_count[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(784[1] 798[10])
    defparam dat_count__i5.GSR = "ENABLED";
    FD1S3IX dat_count__i4 (.D(n_dat_count[4]), .CK(clk), .CD(n9561), .Q(dat_count[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(784[1] 798[10])
    defparam dat_count__i4.GSR = "ENABLED";
    FD1S3IX dat_count__i3 (.D(n_dat_count[3]), .CK(clk), .CD(n9561), .Q(dat_count[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(784[1] 798[10])
    defparam dat_count__i3.GSR = "ENABLED";
    FD1S3IX dat_count__i2 (.D(n_dat_count[2]), .CK(clk), .CD(n9561), .Q(dat_count[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(784[1] 798[10])
    defparam dat_count__i2.GSR = "ENABLED";
    FD1S3IX dat_count__i1 (.D(n_dat_count[1]), .CK(clk), .CD(n9561), .Q(dat_count[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(784[1] 798[10])
    defparam dat_count__i1.GSR = "ENABLED";
    FD1S3IX wb_adr_i__i3 (.D(n_wb_adr_i[2]), .CK(clk), .CD(n9561), .Q(wb_adr_i[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(763[1] 779[10])
    defparam wb_adr_i__i3.GSR = "ENABLED";
    FD1S3IX wb_adr_i__i2 (.D(n_wb_adr_i[1]), .CK(clk), .CD(n9561), .Q(wb_adr_i[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(763[1] 779[10])
    defparam wb_adr_i__i2.GSR = "ENABLED";
    FD1S3IX data0__i7 (.D(data0_7__N_898[7]), .CK(clk), .CD(n9561), .Q(data0[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(554[7] 567[14])
    defparam data0__i7.GSR = "ENABLED";
    FD1S3IX data0__i6 (.D(data0_7__N_898[6]), .CK(clk), .CD(n9561), .Q(data0[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(554[7] 567[14])
    defparam data0__i6.GSR = "ENABLED";
    FD1S3IX data0__i5 (.D(data0_7__N_898[5]), .CK(clk), .CD(n9561), .Q(data0[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(554[7] 567[14])
    defparam data0__i5.GSR = "ENABLED";
    FD1S3IX data0__i4 (.D(data0_7__N_898[4]), .CK(clk), .CD(n9561), .Q(data0[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(554[7] 567[14])
    defparam data0__i4.GSR = "ENABLED";
    FD1S3IX data0__i3 (.D(data0_7__N_898[3]), .CK(clk), .CD(n9561), .Q(data0[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(554[7] 567[14])
    defparam data0__i3.GSR = "ENABLED";
    FD1S3IX data0__i2 (.D(data0_7__N_898[2]), .CK(clk), .CD(n9561), .Q(data0[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(554[7] 567[14])
    defparam data0__i2.GSR = "ENABLED";
    FD1S3IX data0__i1 (.D(data0_7__N_898[1]), .CK(clk), .CD(n9561), .Q(data0[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(554[7] 567[14])
    defparam data0__i1.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i7 (.D(n_wb_dat_i[7]), .CK(clk), .CD(n9561), .Q(wb_dat_i[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(763[1] 779[10])
    defparam wb_dat_i__i7.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i6 (.D(n_wb_dat_i[6]), .CK(clk), .CD(n9561), .Q(wb_dat_i[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(763[1] 779[10])
    defparam wb_dat_i__i6.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i5 (.D(n_wb_dat_i[5]), .CK(clk), .CD(n9561), .Q(wb_dat_i[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(763[1] 779[10])
    defparam wb_dat_i__i5.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i4 (.D(n_wb_dat_i[4]), .CK(clk), .CD(n9561), .Q(wb_dat_i[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(763[1] 779[10])
    defparam wb_dat_i__i4.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i3 (.D(n_wb_dat_i[3]), .CK(clk), .CD(n9561), .Q(wb_dat_i[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(763[1] 779[10])
    defparam wb_dat_i__i3.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i2 (.D(n_wb_dat_i[2]), .CK(clk), .CD(n9561), .Q(wb_dat_i[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(763[1] 779[10])
    defparam wb_dat_i__i2.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i1 (.D(n_wb_dat_i[1]), .CK(clk), .CD(n9561), .Q(wb_dat_i[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(763[1] 779[10])
    defparam wb_dat_i__i1.GSR = "ENABLED";
    FD1P3IX temp3__i7 (.D(wb_dat_o[7]), .SP(dat_rdy_N_1324), .CD(n9561), 
            .CK(clk), .Q(temp3[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp3__i7.GSR = "ENABLED";
    FD1P3IX temp3__i6 (.D(n_state_7__N_1040[4]), .SP(dat_rdy_N_1324), .CD(n9561), 
            .CK(clk), .Q(temp3[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp3__i6.GSR = "ENABLED";
    FD1P3IX temp3__i5 (.D(wb_dat_o[5]), .SP(dat_rdy_N_1324), .CD(n9561), 
            .CK(clk), .Q(temp3[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp3__i5.GSR = "ENABLED";
    FD1P3IX temp3__i4 (.D(wb_dat_o[4]), .SP(dat_rdy_N_1324), .CD(n9561), 
            .CK(clk), .Q(temp3[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp3__i4.GSR = "ENABLED";
    FD1P3IX temp3__i3 (.D(wb_dat_o[3]), .SP(dat_rdy_N_1324), .CD(n9561), 
            .CK(clk), .Q(temp3[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp3__i3.GSR = "ENABLED";
    FD1P3IX temp3__i2 (.D(wb_dat_o[2]), .SP(dat_rdy_N_1324), .CD(n9561), 
            .CK(clk), .Q(temp3[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp3__i2.GSR = "ENABLED";
    FD1P3IX temp3__i1 (.D(wb_dat_o[1]), .SP(dat_rdy_N_1324), .CD(n9561), 
            .CK(clk), .Q(temp3[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp3__i1.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i7 (.D(GPI_c_7), .SP(clk_enable_124), .CD(n9561), 
            .CK(clk), .Q(GPI_DAT[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(639[8] 645[15])
    defparam GPI_DAT__i7.GSR = "ENABLED";
    LUT4 i1_4_lut_adj_100 (.A(wb_dat_o[2]), .B(temp1[2]), .C(n9542), .D(n9068), 
         .Z(n_temp1[2])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_100.init = 16'ha0ec;
    LUT4 i1_4_lut_adj_101 (.A(wb_dat_o[1]), .B(temp1[1]), .C(n9542), .D(n9068), 
         .Z(n_temp1[1])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_101.init = 16'ha0ec;
    FD1P3IX GPI_DAT__i6 (.D(GPI_c_6), .SP(clk_enable_124), .CD(n9561), 
            .CK(clk), .Q(GPI_DAT[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(639[8] 645[15])
    defparam GPI_DAT__i6.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i5 (.D(GPI_c_5), .SP(clk_enable_124), .CD(n9561), 
            .CK(clk), .Q(GPI_DAT[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(639[8] 645[15])
    defparam GPI_DAT__i5.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i4 (.D(GPI_c_4), .SP(clk_enable_124), .CD(n9561), 
            .CK(clk), .Q(GPI_DAT[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(639[8] 645[15])
    defparam GPI_DAT__i4.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i3 (.D(GPI_c_3), .SP(clk_enable_124), .CD(n9561), 
            .CK(clk), .Q(GPI_DAT[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(639[8] 645[15])
    defparam GPI_DAT__i3.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i2 (.D(GPI_c_2), .SP(clk_enable_124), .CD(n9561), 
            .CK(clk), .Q(GPI_DAT[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(639[8] 645[15])
    defparam GPI_DAT__i2.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i1 (.D(GPI_c_1), .SP(clk_enable_124), .CD(n9561), 
            .CK(clk), .Q(GPI_DAT[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(639[8] 645[15])
    defparam GPI_DAT__i1.GSR = "ENABLED";
    FD1S3AY signals_debounced_syn_i4 (.D(pushed_4__N_296), .CK(clk), .Q(signals_debounced_syn[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam signals_debounced_syn_i4.GSR = "ENABLED";
    FD1S3AY signals_debounced_syn_i3 (.D(pushed_3__N_298), .CK(clk), .Q(signals_debounced_syn[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam signals_debounced_syn_i3.GSR = "ENABLED";
    FD1S3AY signals_debounced_syn_i2 (.D(pushed_2__N_300), .CK(clk), .Q(signals_debounced_syn[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam signals_debounced_syn_i2.GSR = "ENABLED";
    FD1P3IX pushed_i4 (.D(n9834), .SP(clk_enable_125), .CD(debounce_inputs_asyn2[4]), 
            .CK(clk), .Q(pushed[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam pushed_i4.GSR = "ENABLED";
    LUT4 next_state_0__bdd_4_lut_5498 (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[3]), .D(next_state[2]), .Z(clk_enable_14)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B+(C+!(D)))) */ ;
    defparam next_state_0__bdd_4_lut_5498.init = 16'hfedf;
    FD1P3IX pushed_i3 (.D(n9834), .SP(clk_enable_126), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(pushed[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam pushed_i3.GSR = "ENABLED";
    FD1P3IX pushed_i2 (.D(n9834), .SP(clk_enable_127), .CD(debounce_inputs_asyn2[2]), 
            .CK(clk), .Q(pushed[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam pushed_i2.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn2_i4 (.D(debounce_inputs_asyn1[4]), .CK(clk), 
            .Q(debounce_inputs_asyn2[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_inputs_asyn2_i4.GSR = "ENABLED";
    CCU2D add_147_27 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8226), .COUT(n8227), .S0(n291), 
          .S1(n290));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_27.INIT0 = 16'h5aaa;
    defparam add_147_27.INIT1 = 16'h5aaa;
    defparam add_147_27.INJECT1_0 = "NO";
    defparam add_147_27.INJECT1_1 = "NO";
    CCU2D add_165_17 (.A0(\debounce_counters[4] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8253), .COUT(n8254), .S0(n513), 
          .S1(n512));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_17.INIT0 = 16'h5aaa;
    defparam add_165_17.INIT1 = 16'h5aaa;
    defparam add_165_17.INJECT1_0 = "NO";
    defparam add_165_17.INJECT1_1 = "NO";
    CCU2D add_4454_26 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8339), .S1(clk_enable_4));
    defparam add_4454_26.INIT0 = 16'hf555;
    defparam add_4454_26.INIT1 = 16'h0000;
    defparam add_4454_26.INJECT1_0 = "NO";
    defparam add_4454_26.INJECT1_1 = "NO";
    FD1S3AY debounce_inputs_asyn2_i3 (.D(debounce_inputs_asyn1[3]), .CK(clk), 
            .Q(debounce_inputs_asyn2[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_inputs_asyn2_i3.GSR = "ENABLED";
    FD1S3AY debounce_inputs_asyn2_i2 (.D(debounce_inputs_asyn1[2]), .CK(clk), 
            .Q(debounce_inputs_asyn2[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_inputs_asyn2_i2.GSR = "ENABLED";
    FD1S3IX temp1__i7 (.D(n_temp1[7]), .CK(clk), .CD(n9561), .Q(temp1[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp1__i7.GSR = "ENABLED";
    FD1S3IX temp1__i6 (.D(n_temp1[6]), .CK(clk), .CD(n9561), .Q(temp1[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp1__i6.GSR = "ENABLED";
    PFUMX i5421 (.BLUT(n9515), .ALUT(n9514), .C0(next_state[3]), .Z(n9516));
    FD1S3IX temp1__i5 (.D(n_temp1[5]), .CK(clk), .CD(n9561), .Q(temp1[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp1__i5.GSR = "ENABLED";
    FD1S3IX temp1__i4 (.D(n_temp1[4]), .CK(clk), .CD(n9561), .Q(temp1[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp1__i4.GSR = "ENABLED";
    FD1S3IX temp1__i3 (.D(n_temp1[3]), .CK(clk), .CD(n9561), .Q(temp1[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp1__i3.GSR = "ENABLED";
    FD1S3IX temp1__i2 (.D(n_temp1[2]), .CK(clk), .CD(n9561), .Q(temp1[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp1__i2.GSR = "ENABLED";
    FD1S3IX temp1__i1 (.D(n_temp1[1]), .CK(clk), .CD(n9561), .Q(temp1[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam temp1__i1.GSR = "ENABLED";
    FD1P3IX GPO_DATA_0___i8 (.D(temp3[7]), .SP(clk_enable_134), .CD(n9561), 
            .CK(clk), .Q(GPO_c_7));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(620[8] 628[15])
    defparam GPO_DATA_0___i8.GSR = "ENABLED";
    FD1P3IX GPO_DATA_0___i7 (.D(temp3[6]), .SP(clk_enable_134), .CD(n9561), 
            .CK(clk), .Q(GPO_c_6));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(620[8] 628[15])
    defparam GPO_DATA_0___i7.GSR = "ENABLED";
    BB FPIO_FlexMIO27_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO27), 
       .O(FPIO_FlexMIO27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    FD1P3IX GPO_DATA_0___i6 (.D(temp3[5]), .SP(clk_enable_134), .CD(n9561), 
            .CK(clk), .Q(GPO_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(620[8] 628[15])
    defparam GPO_DATA_0___i6.GSR = "ENABLED";
    BB FPIO_FlexMIO30_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO30), 
       .O(FPIO_FlexMIO30_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    FD1P3IX GPO_DATA_0___i5 (.D(temp3[4]), .SP(clk_enable_134), .CD(n9561), 
            .CK(clk), .Q(GPO_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(620[8] 628[15])
    defparam GPO_DATA_0___i5.GSR = "ENABLED";
    BB FPIO_FlexMIO29_pad (.I(GND_net), .T(VCC_net), .B(FPIO_FlexMIO29), 
       .O(FPIO_FlexMIO29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    FD1P3IX GPO_DATA_0___i4 (.D(temp3[3]), .SP(clk_enable_134), .CD(n9561), 
            .CK(clk), .Q(GPO_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(620[8] 628[15])
    defparam GPO_DATA_0___i4.GSR = "ENABLED";
    BB DIG5S3C26_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C26), .O(DIG5S3C26_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    FD1P3IX GPO_DATA_0___i3 (.D(temp3[2]), .SP(clk_enable_134), .CD(n9561), 
            .CK(clk), .Q(GPO_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(620[8] 628[15])
    defparam GPO_DATA_0___i3.GSR = "ENABLED";
    BB DIG5S3C25_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C25), .O(DIG5S3C25_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    FD1P3IX GPO_DATA_0___i2 (.D(temp3[1]), .SP(clk_enable_134), .CD(n9561), 
            .CK(clk), .Q(GPO_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(620[8] 628[15])
    defparam GPO_DATA_0___i2.GSR = "ENABLED";
    BB DIG5S3C24_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C24), .O(DIG5S3C24_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    BB FlexMIOs54_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs54), .O(FlexMIOs54_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    BB FlexMIOs62_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs62), .O(FlexMIOs62_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    LUT4 FPIO_isoCtrlRSTn_N_1294_bdd_4_lut_5307 (.A(n9538), .B(externstop_falling), 
         .C(next_state[0]), .D(next_state_3__N_1092[2]), .Z(n9282)) /* synthesis lut_function=(!(A ((C+!(D))+!B)+!A !(B (C+(D))+!B (C)))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1294_bdd_4_lut_5307.init = 16'h5c50;
    BB FlexMIOs63_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs63), .O(FlexMIOs63_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    BB FlexMIOs31_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs31), .O(FlexMIOs31_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    FD1P3AX next_state_i2 (.D(next_state_3__N_69[2]), .SP(clk_enable_135), 
            .CK(clk), .Q(next_state[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam next_state_i2.GSR = "ENABLED";
    BB FlexMIOs37_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs37), .O(FlexMIOs37_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    CCU2D add_4454_24 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8338), .COUT(n8339));
    defparam add_4454_24.INIT0 = 16'h5555;
    defparam add_4454_24.INIT1 = 16'h5555;
    defparam add_4454_24.INJECT1_0 = "NO";
    defparam add_4454_24.INJECT1_1 = "NO";
    BB FlexMIOs36_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs36), .O(FlexMIOs36_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    BB FlexMIOs35_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs35), .O(FlexMIOs35_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    BB FlexMIOs34_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs34), .O(FlexMIOs34_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    LUT4 i1_4_lut_4_lut_adj_102 (.A(next_state[2]), .B(next_state[3]), .C(next_state[0]), 
         .D(next_state[1]), .Z(FP_SysLEDg_N_1287)) /* synthesis lut_function=(!(A (B+(D))+!A !(B (C+!(D))+!B (C)))) */ ;
    defparam i1_4_lut_4_lut_adj_102.init = 16'h5076;
    BB FlexMIOs33_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs33), .O(FlexMIOs33_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    BB FlexMIOs32_pad (.I(GND_net), .T(VCC_net), .B(FlexMIOs32), .O(FlexMIOs32_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    BB DIG5S3C03_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C03), .O(DIG5S3C03_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    BB DIG5S3C04_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C04), .O(DIG5S3C04_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    BB DIG5S3C05_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C05), .O(DIG5S3C05_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    BB DIG5S3C00_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C00), .O(DIG5S3C00_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    BB DIG5S3C02_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C02), .O(DIG5S3C02_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    BB DIG5S3C01_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C01), .O(DIG5S3C01_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    BB DIG5S3C29_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C29), .O(DIG5S3C29_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    LUT4 i1_2_lut_rep_142 (.A(resetcounter[10]), .B(resetcounter[11]), .Z(n9562)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_rep_142.init = 16'heeee;
    BB DIG5S3C28_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C28), .O(DIG5S3C28_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    BB DIG5S3C27_pad (.I(GND_net), .T(VCC_net), .B(DIG5S3C27), .O(DIG5S3C27_out));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(423[1:17])
    CCU2D add_4454_22 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8337), .COUT(n8338));
    defparam add_4454_22.INIT0 = 16'h5555;
    defparam add_4454_22.INIT1 = 16'h5555;
    defparam add_4454_22.INJECT1_0 = "NO";
    defparam add_4454_22.INJECT1_1 = "NO";
    OB FP_SysLEDg_pad (.I(FP_SysLEDg_c), .O(FP_SysLEDg));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(25[3:13])
    OB FP_SysLEDr_pad (.I(FP_SysLEDr_c), .O(FP_SysLEDr));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(26[3:13])
    OB FP_SysLEDb_pad (.I(FP_SysLEDb_c), .O(FP_SysLEDb));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(27[3:13])
    OB FPIO_isoCtrlRSTn_pad (.I(FPIO_isoCtrlRSTn_c), .O(FPIO_isoCtrlRSTn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(40[3:19])
    OB Carrier_PG_3V3_pad (.I(Carrier_PG_3V3_c), .O(Carrier_PG_3V3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(42[3:17])
    OB FPIO_FlexMIO52_pad (.I(FPIO_FlexMIO52_c_c), .O(FPIO_FlexMIO52));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(48[3:17])
    LUT4 i1_3_lut_4_lut (.A(resetcounter[10]), .B(resetcounter[11]), .C(resetcounter[9]), 
         .D(resetcounter[8]), .Z(n9030)) /* synthesis lut_function=(A+(B+(C (D)))) */ ;
    defparam i1_3_lut_4_lut.init = 16'hfeee;
    OBZ n5221_pad (.I(GND_net), .T(n5222), .O(Carrier_PG_1V8));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1321[1] 1502[13])
    OB FP_SysLEDs_pad (.I(FP_SysLEDs_c), .O(FP_SysLEDs));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(53[3:13])
    OB FP_UsrLED_pad_4 (.I(n9533), .O(FP_UsrLED[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(57[3:12])
    OB FP_UsrLED_pad_3 (.I(FP_UsrLED_c_3), .O(FP_UsrLED[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(57[3:12])
    OB FP_UsrLED_pad_2 (.I(FP_UsrLED_c_2), .O(FP_UsrLED[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(57[3:12])
    OB FP_UsrLED_pad_1 (.I(n9533), .O(FP_UsrLED[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(57[3:12])
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
    OB GPO_pad_7 (.I(GPO_c_7), .O(GPO[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    OB GPO_pad_6 (.I(GPO_c_6), .O(GPO[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    OB GPO_pad_5 (.I(GPO_c_5), .O(GPO[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    OB GPO_pad_4 (.I(GPO_c_4), .O(GPO[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    OB GPO_pad_3 (.I(GPO_c_3), .O(GPO[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    OB GPO_pad_2 (.I(GPO_c_2), .O(GPO[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    OB GPO_pad_1 (.I(GPO_c_1), .O(GPO[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    OB GPO_pad_0 (.I(GPO_c_0), .O(GPO[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(117[3:6])
    IB FP_UsrSW1_pad (.I(FP_UsrSW1), .O(FP_UsrSW1_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(33[3:12])
    IB FP_UsrSW2_pad (.I(FP_UsrSW2), .O(FP_UsrSW2_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(34[3:12])
    IB FP_UsrSW3_pad (.I(FP_UsrSW3), .O(FP_UsrSW3_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(38[3:12])
    IB SysSW_Pwr_NC_pad (.I(SysSW_Pwr_NC), .O(SysSW_Pwr_NC_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(39[3:15])
    IB FPIO_iosCtrlINTn_pad (.I(FPIO_iosCtrlINTn), .O(FPIO_iosCtrlINTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(41[3:19])
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
    IB GPI_pad_7 (.I(GPI[7]), .O(GPI_c_7));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(120[3:6])
    IB GPI_pad_6 (.I(GPI[6]), .O(GPI_c_6));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(120[3:6])
    IB GPI_pad_5 (.I(GPI[5]), .O(GPI_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(120[3:6])
    IB GPI_pad_4 (.I(GPI[4]), .O(GPI_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(120[3:6])
    IB GPI_pad_3 (.I(GPI[3]), .O(GPI_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(120[3:6])
    IB GPI_pad_2 (.I(GPI[2]), .O(GPI_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(120[3:6])
    IB GPI_pad_1 (.I(GPI[1]), .O(GPI_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(120[3:6])
    IB GPI_pad_0 (.I(GPI[0]), .O(GPI_c_0));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(120[3:6])
    CCU2D add_4454_20 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8336), .COUT(n8337));
    defparam add_4454_20.INIT0 = 16'h5555;
    defparam add_4454_20.INIT1 = 16'h5555;
    defparam add_4454_20.INJECT1_0 = "NO";
    defparam add_4454_20.INJECT1_1 = "NO";
    CCU2D add_165_15 (.A0(\debounce_counters[4] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8252), .COUT(n8253), .S0(n515), 
          .S1(n514));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_15.INIT0 = 16'h5aaa;
    defparam add_165_15.INIT1 = 16'h5aaa;
    defparam add_165_15.INJECT1_0 = "NO";
    defparam add_165_15.INJECT1_1 = "NO";
    CCU2D add_165_13 (.A0(\debounce_counters[4] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8251), .COUT(n8252), .S0(n517), 
          .S1(n516));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_13.INIT0 = 16'h5aaa;
    defparam add_165_13.INIT1 = 16'h5aaa;
    defparam add_165_13.INJECT1_0 = "NO";
    defparam add_165_13.INJECT1_1 = "NO";
    CCU2D add_4457_24 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8289), .COUT(n8290));
    defparam add_4457_24.INIT0 = 16'h5555;
    defparam add_4457_24.INIT1 = 16'h5555;
    defparam add_4457_24.INJECT1_0 = "NO";
    defparam add_4457_24.INJECT1_1 = "NO";
    CCU2D add_165_11 (.A0(\debounce_counters[4] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8250), .COUT(n8251), .S0(n519), 
          .S1(n518));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_11.INIT0 = 16'h5aaa;
    defparam add_165_11.INIT1 = 16'h5aaa;
    defparam add_165_11.INJECT1_0 = "NO";
    defparam add_165_11.INJECT1_1 = "NO";
    LUT4 i2328_2_lut_rep_143 (.A(next_state_3__N_1092[2]), .B(next_state[0]), 
         .Z(n9563)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam i2328_2_lut_rep_143.init = 16'h2222;
    CCU2D add_4457_22 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8288), .COUT(n8289));
    defparam add_4457_22.INIT0 = 16'h5555;
    defparam add_4457_22.INIT1 = 16'h5555;
    defparam add_4457_22.INJECT1_0 = "NO";
    defparam add_4457_22.INJECT1_1 = "NO";
    LUT4 i1666_4_lut (.A(n5294), .B(n9532), .C(n_temp1_7__N_359), .D(n7141), 
         .Z(n5295)) /* synthesis lut_function=(A+!(((D)+!C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1666_4_lut.init = 16'haaea;
    CCU2D add_4454_18 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8335), .COUT(n8336));
    defparam add_4454_18.INIT0 = 16'h5555;
    defparam add_4454_18.INIT1 = 16'h5555;
    defparam add_4454_18.INJECT1_0 = "NO";
    defparam add_4454_18.INJECT1_1 = "NO";
    CCU2D add_165_9 (.A0(\debounce_counters[4] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8249), .COUT(n8250), .S0(n521), 
          .S1(n520));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_9.INIT0 = 16'h5aaa;
    defparam add_165_9.INIT1 = 16'h5aaa;
    defparam add_165_9.INJECT1_0 = "NO";
    defparam add_165_9.INJECT1_1 = "NO";
    LUT4 i18_4_lut (.A(counter[0]), .B(counter[14]), .C(counter[10]), 
         .D(counter[19]), .Z(n43)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i18_4_lut.init = 16'hfffe;
    CCU2D add_4454_16 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8334), .COUT(n8335));
    defparam add_4454_16.INIT0 = 16'h5555;
    defparam add_4454_16.INIT1 = 16'h5555;
    defparam add_4454_16.INJECT1_0 = "NO";
    defparam add_4454_16.INJECT1_1 = "NO";
    LUT4 i23_4_lut (.A(n27), .B(n46), .C(n40), .D(n28_adj_1424), .Z(n48_adj_1427)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i23_4_lut.init = 16'hfffe;
    PFUMX mux_1082_Mux_8_i15 (.BLUT(n7), .ALUT(n14_adj_1434), .C0(next_state[3]), 
          .Z(FP_SysLEDb_N_1289));
    LUT4 i12_2_lut (.A(counter[7]), .B(counter[12]), .Z(n37)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i12_2_lut.init = 16'heeee;
    LUT4 i13_3_lut (.A(counter[8]), .B(counter[5]), .C(counter[6]), .Z(n38)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i13_3_lut.init = 16'hfefe;
    CCU2D add_4457_20 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8287), .COUT(n8288));
    defparam add_4457_20.INIT0 = 16'h5555;
    defparam add_4457_20.INIT1 = 16'h5555;
    defparam add_4457_20.INJECT1_0 = "NO";
    defparam add_4457_20.INJECT1_1 = "NO";
    CCU2D add_4454_14 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8333), .COUT(n8334));
    defparam add_4454_14.INIT0 = 16'h5555;
    defparam add_4454_14.INIT1 = 16'h5555;
    defparam add_4454_14.INJECT1_0 = "NO";
    defparam add_4454_14.INJECT1_1 = "NO";
    CCU2D add_147_25 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8225), .COUT(n8226), .S0(n293), 
          .S1(n292));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_25.INIT0 = 16'h5aaa;
    defparam add_147_25.INIT1 = 16'h5aaa;
    defparam add_147_25.INJECT1_0 = "NO";
    defparam add_147_25.INJECT1_1 = "NO";
    CCU2D add_4457_18 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8286), .COUT(n8287));
    defparam add_4457_18.INIT0 = 16'h5555;
    defparam add_4457_18.INIT1 = 16'h5555;
    defparam add_4457_18.INJECT1_0 = "NO";
    defparam add_4457_18.INJECT1_1 = "NO";
    CCU2D add_138_23 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8208), .COUT(n8209), .S0(n189), 
          .S1(n188));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_23.INIT0 = 16'h5aaa;
    defparam add_138_23.INIT1 = 16'h5aaa;
    defparam add_138_23.INJECT1_0 = "NO";
    defparam add_138_23.INJECT1_1 = "NO";
    CCU2D add_165_7 (.A0(\debounce_counters[4] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8248), .COUT(n8249), .S0(n523), 
          .S1(n522));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_7.INIT0 = 16'h5aaa;
    defparam add_165_7.INIT1 = 16'h5aaa;
    defparam add_165_7.INJECT1_0 = "NO";
    defparam add_165_7.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_103 (.A(next_state_3__N_1092[2]), .B(next_state[1]), 
         .C(next_state[0]), .D(n9546), .Z(n8942)) /* synthesis lut_function=(!(A ((C+!(D))+!B)+!A !(B (C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam i1_4_lut_adj_103.init = 16'h4800;
    CCU2D add_4454_12 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8332), .COUT(n8333));
    defparam add_4454_12.INIT0 = 16'h5555;
    defparam add_4454_12.INIT1 = 16'h5555;
    defparam add_4454_12.INJECT1_0 = "NO";
    defparam add_4454_12.INJECT1_1 = "NO";
    CCU2D add_4454_10 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8331), .COUT(n8332));
    defparam add_4454_10.INIT0 = 16'h5555;
    defparam add_4454_10.INIT1 = 16'h5555;
    defparam add_4454_10.INJECT1_0 = "NO";
    defparam add_4454_10.INJECT1_1 = "NO";
    CCU2D add_147_23 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8224), .COUT(n8225), .S0(n295), 
          .S1(n294));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_23.INIT0 = 16'h5aaa;
    defparam add_147_23.INIT1 = 16'h5aaa;
    defparam add_147_23.INJECT1_0 = "NO";
    defparam add_147_23.INJECT1_1 = "NO";
    CCU2D add_138_21 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8207), .COUT(n8208), .S0(n191), 
          .S1(n190));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_21.INIT0 = 16'h5aaa;
    defparam add_138_21.INIT1 = 16'h5aaa;
    defparam add_138_21.INJECT1_0 = "NO";
    defparam add_138_21.INJECT1_1 = "NO";
    LUT4 i2_2_lut (.A(counter[17]), .B(counter[22]), .Z(n27)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2_2_lut.init = 16'heeee;
    CCU2D add_138_19 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8206), .COUT(n8207), .S0(n193), 
          .S1(n192));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_19.INIT0 = 16'h5aaa;
    defparam add_138_19.INIT1 = 16'h5aaa;
    defparam add_138_19.INJECT1_0 = "NO";
    defparam add_138_19.INJECT1_1 = "NO";
    CCU2D add_4457_16 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8285), .COUT(n8286));
    defparam add_4457_16.INIT0 = 16'h5555;
    defparam add_4457_16.INIT1 = 16'h5555;
    defparam add_4457_16.INJECT1_0 = "NO";
    defparam add_4457_16.INJECT1_1 = "NO";
    CCU2D add_4454_8 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8330), .COUT(n8331));
    defparam add_4454_8.INIT0 = 16'h5555;
    defparam add_4454_8.INIT1 = 16'h5aaa;
    defparam add_4454_8.INJECT1_0 = "NO";
    defparam add_4454_8.INJECT1_1 = "NO";
    CCU2D add_4454_6 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8329), .COUT(n8330));
    defparam add_4454_6.INIT0 = 16'h5555;
    defparam add_4454_6.INIT1 = 16'h5aaa;
    defparam add_4454_6.INJECT1_0 = "NO";
    defparam add_4454_6.INJECT1_1 = "NO";
    LUT4 i21_4_lut (.A(counter[11]), .B(n42), .C(n32), .D(counter[20]), 
         .Z(n46)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i21_4_lut.init = 16'hfffe;
    LUT4 i1_2_lut_adj_104 (.A(next_state[2]), .B(next_state[3]), .Z(n8986)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam i1_2_lut_adj_104.init = 16'h2222;
    CCU2D add_4454_4 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8328), .COUT(n8329));
    defparam add_4454_4.INIT0 = 16'h5555;
    defparam add_4454_4.INIT1 = 16'h5555;
    defparam add_4454_4.INJECT1_0 = "NO";
    defparam add_4454_4.INJECT1_1 = "NO";
    LUT4 i15_4_lut (.A(counter[15]), .B(counter[3]), .C(counter[1]), .D(counter[24]), 
         .Z(n40)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i15_4_lut.init = 16'hfffe;
    CCU2D add_4457_14 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8284), .COUT(n8285));
    defparam add_4457_14.INIT0 = 16'h5555;
    defparam add_4457_14.INIT1 = 16'h5555;
    defparam add_4457_14.INJECT1_0 = "NO";
    defparam add_4457_14.INJECT1_1 = "NO";
    CCU2D add_165_5 (.A0(\debounce_counters[4] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8247), .COUT(n8248), .S0(n525), 
          .S1(n524));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_5.INIT0 = 16'h5aaa;
    defparam add_165_5.INIT1 = 16'h5aaa;
    defparam add_165_5.INJECT1_0 = "NO";
    defparam add_165_5.INJECT1_1 = "NO";
    CCU2D add_147_21 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8223), .COUT(n8224), .S0(n297), 
          .S1(n296));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_21.INIT0 = 16'h5aaa;
    defparam add_147_21.INIT1 = 16'h5aaa;
    defparam add_147_21.INJECT1_0 = "NO";
    defparam add_147_21.INJECT1_1 = "NO";
    CCU2D add_4454_2 (.A0(\debounce_counters[1] [7]), .B0(\debounce_counters[1] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[1] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n8328));
    defparam add_4454_2.INIT0 = 16'h1000;
    defparam add_4454_2.INIT1 = 16'h5aaa;
    defparam add_4454_2.INJECT1_0 = "NO";
    defparam add_4454_2.INJECT1_1 = "NO";
    CCU2D add_4457_12 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8283), .COUT(n8284));
    defparam add_4457_12.INIT0 = 16'h5555;
    defparam add_4457_12.INIT1 = 16'h5555;
    defparam add_4457_12.INJECT1_0 = "NO";
    defparam add_4457_12.INJECT1_1 = "NO";
    LUT4 i3_2_lut (.A(counter[23]), .B(counter[4]), .Z(n28_adj_1424)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i3_2_lut.init = 16'heeee;
    CCU2D add_4457_10 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8282), .COUT(n8283));
    defparam add_4457_10.INIT0 = 16'h5555;
    defparam add_4457_10.INIT1 = 16'h5555;
    defparam add_4457_10.INJECT1_0 = "NO";
    defparam add_4457_10.INJECT1_1 = "NO";
    LUT4 i17_4_lut (.A(counter[2]), .B(counter[13]), .C(counter[9]), .D(counter[18]), 
         .Z(n42)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i17_4_lut.init = 16'hfffe;
    LUT4 i1594_1_lut (.A(Carrier_PG_1V8_N_1300), .Z(n5222)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1321[1] 1502[13])
    defparam i1594_1_lut.init = 16'h5555;
    CCU2D resetcounter_i24_1473_add_4_25 (.A0(resetcounter[23]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8326), .S0(n107), .S1(n106));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473_add_4_25.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_25.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_25.INJECT1_0 = "NO";
    defparam resetcounter_i24_1473_add_4_25.INJECT1_1 = "NO";
    CCU2D add_4457_8 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8281), .COUT(n8282));
    defparam add_4457_8.INIT0 = 16'h5555;
    defparam add_4457_8.INIT1 = 16'h5aaa;
    defparam add_4457_8.INJECT1_0 = "NO";
    defparam add_4457_8.INJECT1_1 = "NO";
    CCU2D add_165_3 (.A0(\debounce_counters[4] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8246), .COUT(n8247), .S0(n527), 
          .S1(n526));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_3.INIT0 = 16'h5aaa;
    defparam add_165_3.INIT1 = 16'h5aaa;
    defparam add_165_3.INJECT1_0 = "NO";
    defparam add_165_3.INJECT1_1 = "NO";
    LUT4 i1499_2_lut (.A(clk_enable_125), .B(debounce_inputs_asyn2[4]), 
         .Z(clk_enable_55)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i1499_2_lut.init = 16'hdddd;
    LUT4 i8_4_lut (.A(n15_adj_1419), .B(resetcounter[9]), .C(n14_adj_1420), 
         .D(resetcounter[18]), .Z(n8498)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(482[12:28])
    defparam i8_4_lut.init = 16'hfffe;
    LUT4 i6_4_lut (.A(resetcounter[23]), .B(resetcounter[24]), .C(resetcounter[12]), 
         .D(resetcounter[20]), .Z(n15_adj_1419)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(482[12:28])
    defparam i6_4_lut.init = 16'hfffe;
    CCU2D add_147_19 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8222), .COUT(n8223), .S0(n299), 
          .S1(n298));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_19.INIT0 = 16'h5aaa;
    defparam add_147_19.INIT1 = 16'h5aaa;
    defparam add_147_19.INJECT1_0 = "NO";
    defparam add_147_19.INJECT1_1 = "NO";
    CCU2D add_147_17 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8221), .COUT(n8222), .S0(n301), 
          .S1(n300));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_17.INIT0 = 16'h5aaa;
    defparam add_147_17.INIT1 = 16'h5aaa;
    defparam add_147_17.INJECT1_0 = "NO";
    defparam add_147_17.INJECT1_1 = "NO";
    CCU2D add_165_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[4] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n8246), .S1(n528));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_165_1.INIT0 = 16'hF000;
    defparam add_165_1.INIT1 = 16'h5555;
    defparam add_165_1.INJECT1_0 = "NO";
    defparam add_165_1.INJECT1_1 = "NO";
    CCU2D add_156_33 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8245), .S0(n391));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_33.INIT0 = 16'h5aaa;
    defparam add_156_33.INIT1 = 16'h0000;
    defparam add_156_33.INJECT1_0 = "NO";
    defparam add_156_33.INJECT1_1 = "NO";
    CCU2D add_138_17 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8205), .COUT(n8206), .S0(n195), 
          .S1(n194));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_17.INIT0 = 16'h5aaa;
    defparam add_138_17.INIT1 = 16'h5aaa;
    defparam add_138_17.INJECT1_0 = "NO";
    defparam add_138_17.INJECT1_1 = "NO";
    CCU2D add_156_31 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8244), .COUT(n8245), .S0(n393), 
          .S1(n392));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_31.INIT0 = 16'h5aaa;
    defparam add_156_31.INIT1 = 16'h5aaa;
    defparam add_156_31.INJECT1_0 = "NO";
    defparam add_156_31.INJECT1_1 = "NO";
    LUT4 i5216_4_lut_then_4_lut (.A(n14), .B(temp1[1]), .C(temp1[0]), 
         .D(temp1[3]), .Z(n9568)) /* synthesis lut_function=(A+(B+((D)+!C))) */ ;
    defparam i5216_4_lut_then_4_lut.init = 16'hffef;
    CCU2D resetcounter_i24_1473_add_4_23 (.A0(resetcounter[21]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8325), .COUT(n8326), .S0(n109), 
          .S1(n108));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473_add_4_23.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_23.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_23.INJECT1_0 = "NO";
    defparam resetcounter_i24_1473_add_4_23.INJECT1_1 = "NO";
    LUT4 i5_3_lut (.A(resetcounter[19]), .B(resetcounter[8]), .C(resetcounter[22]), 
         .Z(n14_adj_1420)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(482[12:28])
    defparam i5_3_lut.init = 16'hfefe;
    PFUMX i5413 (.BLUT(n9504), .ALUT(n9503), .C0(temp1[1]), .Z(n9505));
    CCU2D resetcounter_i24_1473_add_4_21 (.A0(resetcounter[19]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8324), .COUT(n8325), .S0(n111), 
          .S1(n110));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473_add_4_21.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_21.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_21.INJECT1_0 = "NO";
    defparam resetcounter_i24_1473_add_4_21.INJECT1_1 = "NO";
    LUT4 i5298_2_lut_2_lut_3_lut_4_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(next_state[1]), .D(next_state[0]), .Z(clk_enable_9)) /* synthesis lut_function=(A+((C (D)+!C !(D))+!B)) */ ;
    defparam i5298_2_lut_2_lut_3_lut_4_lut.init = 16'hfbbf;
    LUT4 i1_2_lut_3_lut_4_lut_adj_105 (.A(next_state[2]), .B(next_state[3]), 
         .C(next_state[1]), .D(next_state[0]), .Z(clk_enable_12)) /* synthesis lut_function=(A+!(B (C+(D)))) */ ;
    defparam i1_2_lut_3_lut_4_lut_adj_105.init = 16'hbbbf;
    CCU2D add_156_29 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8243), .COUT(n8244), .S0(n395), 
          .S1(n394));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_29.INIT0 = 16'h5aaa;
    defparam add_156_29.INIT1 = 16'h5aaa;
    defparam add_156_29.INJECT1_0 = "NO";
    defparam add_156_29.INJECT1_1 = "NO";
    FD1P3AX next_state_i0 (.D(next_state_3__N_69[0]), .SP(clk_enable_136), 
            .CK(clk), .Q(next_state[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam next_state_i0.GSR = "ENABLED";
    LUT4 i10_4_lut (.A(resetcounter[4]), .B(n20), .C(n16), .D(resetcounter[1]), 
         .Z(n5668)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(503[6:29])
    defparam i10_4_lut.init = 16'hfffe;
    LUT4 i7_2_lut (.A(counter[16]), .B(counter[21]), .Z(n32)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i7_2_lut.init = 16'heeee;
    LUT4 i3_4_lut_adj_106 (.A(n_dat_count_7__N_423[3]), .B(n6_adj_1417), 
         .C(n2), .D(n_temp1_7__N_365), .Z(n_dat_count[3])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i3_4_lut_adj_106.init = 16'hfefc;
    CCU2D resetcounter_i24_1473_add_4_19 (.A0(resetcounter[17]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8323), .COUT(n8324), .S0(n113), 
          .S1(n112));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473_add_4_19.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_19.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_19.INJECT1_0 = "NO";
    defparam resetcounter_i24_1473_add_4_19.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_144 (.A(n_temp1_7__N_353), .B(n_temp1_7__N_359), .Z(n9564)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_2_lut_rep_144.init = 16'heeee;
    LUT4 i9_4_lut (.A(n9562), .B(n18_adj_1439), .C(resetcounter[0]), .D(resetcounter[5]), 
         .Z(n20)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(503[6:29])
    defparam i9_4_lut.init = 16'hfffe;
    LUT4 i5258_2_lut_3_lut_4_lut_4_lut_4_lut (.A(next_state[1]), .B(next_state[2]), 
         .C(next_state[3]), .D(next_state[0]), .Z(clk_enable_187)) /* synthesis lut_function=(A+(B (C+(D))+!B !(C (D)))) */ ;
    defparam i5258_2_lut_3_lut_4_lut_4_lut_4_lut.init = 16'heffb;
    LUT4 i5_2_lut (.A(resetcounter[21]), .B(n8937), .Z(n16)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(503[6:29])
    defparam i5_2_lut.init = 16'heeee;
    LUT4 i2_4_lut_adj_107 (.A(dat_count[3]), .B(n47), .C(reg_rdy_N_1322), 
         .D(n9535), .Z(n6_adj_1417)) /* synthesis lut_function=(A ((C)+!B)+!A (C (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i2_4_lut_adj_107.init = 16'hf2a2;
    CCU2D resetcounter_i24_1473_add_4_17 (.A0(resetcounter[15]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8322), .COUT(n8323), .S0(n115), 
          .S1(n114));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473_add_4_17.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_17.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_17.INJECT1_0 = "NO";
    defparam resetcounter_i24_1473_add_4_17.INJECT1_1 = "NO";
    LUT4 i7_4_lut (.A(resetcounter[7]), .B(resetcounter[6]), .C(resetcounter[3]), 
         .D(resetcounter[2]), .Z(n18_adj_1439)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(503[6:29])
    defparam i7_4_lut.init = 16'hfffe;
    CCU2D resetcounter_i24_1473_add_4_15 (.A0(resetcounter[13]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8321), .COUT(n8322), .S0(n117), 
          .S1(n116));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473_add_4_15.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_15.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_15.INJECT1_0 = "NO";
    defparam resetcounter_i24_1473_add_4_15.INJECT1_1 = "NO";
    LUT4 i4_4_lut (.A(resetcounter[14]), .B(resetcounter[15]), .C(resetcounter[16]), 
         .D(n6), .Z(n8937)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(503[6:29])
    defparam i4_4_lut.init = 16'hfffe;
    LUT4 select_1221_Select_3_i2_4_lut (.A(n2016), .B(dat_rdy_N_1326), .C(dat_count[3]), 
         .D(n6975), .Z(n2)) /* synthesis lut_function=(A (B (C+(D)))+!A !(((D)+!C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam select_1221_Select_3_i2_4_lut.init = 16'h88c0;
    LUT4 i1_2_lut_adj_108 (.A(resetcounter[13]), .B(resetcounter[17]), .Z(n6)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(503[6:29])
    defparam i1_2_lut_adj_108.init = 16'heeee;
    LUT4 i1_2_lut_rep_115_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_state_7__N_984[3]), 
         .Z(n9535)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1_2_lut_rep_115_3_lut.init = 16'h8080;
    LUT4 i2_4_lut_adj_109 (.A(dat_count[2]), .B(n12), .C(n17), .D(n15_adj_1438), 
         .Z(n_dat_count[2])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i2_4_lut_adj_109.init = 16'hffec;
    LUT4 i1_4_lut_adj_110 (.A(n_temp1_7__N_365), .B(dat_count[2]), .C(n2017), 
         .D(n9531), .Z(n12)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_110.init = 16'ha088;
    LUT4 i1_4_lut_adj_111 (.A(dat_rdy_N_1326), .B(dat_count[2]), .C(n2017), 
         .D(n6975), .Z(n15_adj_1438)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_111.init = 16'ha088;
    CCU2D add_147_15 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8220), .COUT(n8221), .S0(n303), 
          .S1(n302));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_15.INIT0 = 16'h5aaa;
    defparam add_147_15.INIT1 = 16'h5aaa;
    defparam add_147_15.INJECT1_0 = "NO";
    defparam add_147_15.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_119_3_lut_4_lut (.A(n_temp1_7__N_353), .B(n_temp1_7__N_359), 
         .C(n_temp1_7__N_352), .D(n_temp1_7__N_366), .Z(n9539)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_2_lut_rep_119_3_lut_4_lut.init = 16'hfffe;
    LUT4 i2_4_lut_adj_112 (.A(dat_count[1]), .B(n12_adj_1423), .C(n17), 
         .D(n15_adj_1422), .Z(n_dat_count[1])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i2_4_lut_adj_112.init = 16'hffec;
    CCU2D add_4457_6 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8280), .COUT(n8281));
    defparam add_4457_6.INIT0 = 16'h5555;
    defparam add_4457_6.INIT1 = 16'h5aaa;
    defparam add_4457_6.INJECT1_0 = "NO";
    defparam add_4457_6.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_113 (.A(n_temp1_7__N_365), .B(dat_count[1]), .C(n2018), 
         .D(n9531), .Z(n12_adj_1423)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_113.init = 16'ha088;
    CCU2D add_4457_4 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8279), .COUT(n8280));
    defparam add_4457_4.INIT0 = 16'h5555;
    defparam add_4457_4.INIT1 = 16'h5555;
    defparam add_4457_4.INJECT1_0 = "NO";
    defparam add_4457_4.INJECT1_1 = "NO";
    LUT4 i3422_2_lut_3_lut (.A(n3076), .B(n4570), .C(n4566), .Z(n4472)) /* synthesis lut_function=(A+((C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam i3422_2_lut_3_lut.init = 16'hfbfb;
    LUT4 i5220_4_lut (.A(n9082), .B(resetcounter[9]), .C(n9084), .D(resetcounter[18]), 
         .Z(n9102)) /* synthesis lut_function=(A (B (C (D)))) */ ;
    defparam i5220_4_lut.init = 16'h8000;
    LUT4 i1_4_lut_adj_114 (.A(dat_rdy_N_1326), .B(n2018), .C(dat_count[1]), 
         .D(n6975), .Z(n15_adj_1422)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_114.init = 16'h88a0;
    FD1P3AX next_state_i3 (.D(next_state_3__N_69[3]), .SP(clk_enable_137), 
            .CK(clk), .Q(next_state[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam next_state_i3.GSR = "ENABLED";
    FD1P3IX counter_i0_i21 (.D(n4401), .SP(clk_enable_188), .CD(n7091), 
            .CK(clk), .Q(counter[21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i21.GSR = "ENABLED";
    LUT4 i1_3_lut_4_lut_adj_115 (.A(wb_ack_o), .B(wb_stb_i), .C(n8934), 
         .D(n9565), .Z(n_wb_adr_i[1])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1_3_lut_4_lut_adj_115.init = 16'h7770;
    LUT4 i5200_4_lut (.A(resetcounter[24]), .B(resetcounter[23]), .C(resetcounter[22]), 
         .D(resetcounter[20]), .Z(n9082)) /* synthesis lut_function=(A (B (C (D)))) */ ;
    defparam i5200_4_lut.init = 16'h8000;
    LUT4 i2360_3_lut_4_lut (.A(clk_enable_188), .B(n4572), .C(n4570), 
         .D(n4566), .Z(n6024)) /* synthesis lut_function=(A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam i2360_3_lut_4_lut.init = 16'haa8a;
    LUT4 i5202_3_lut (.A(resetcounter[19]), .B(resetcounter[8]), .C(resetcounter[12]), 
         .Z(n9084)) /* synthesis lut_function=(A (B (C))) */ ;
    defparam i5202_3_lut.init = 16'h8080;
    LUT4 i1661_2_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_362), 
         .D(n9566), .Z(n5290)) /* synthesis lut_function=(A (B (C (D))+!B (C))+!A (C)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1661_2_lut_3_lut_4_lut.init = 16'hf070;
    PFUMX i5230 (.BLUT(n9110), .ALUT(n9111), .C0(next_state[2]), .Z(n9112));
    CCU2D add_156_27 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8242), .COUT(n8243), .S0(n397), 
          .S1(n396));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_27.INIT0 = 16'h5aaa;
    defparam add_156_27.INIT1 = 16'h5aaa;
    defparam add_156_27.INJECT1_0 = "NO";
    defparam add_156_27.INJECT1_1 = "NO";
    CCU2D add_156_25 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8241), .COUT(n8242), .S0(n399), 
          .S1(n398));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_25.INIT0 = 16'h5aaa;
    defparam add_156_25.INIT1 = 16'h5aaa;
    defparam add_156_25.INJECT1_0 = "NO";
    defparam add_156_25.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1473_add_4_13 (.A0(resetcounter[11]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8320), .COUT(n8321), .S0(n119), 
          .S1(n118));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473_add_4_13.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_13.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_13.INJECT1_0 = "NO";
    defparam resetcounter_i24_1473_add_4_13.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_4_lut_adj_116 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[5]), 
         .D(n_temp1_7__N_365), .Z(n_wb_dat_i[5])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_116.init = 16'h7000;
    CCU2D add_147_13 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8219), .COUT(n8220), .S0(n305), 
          .S1(n304));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_13.INIT0 = 16'h5aaa;
    defparam add_147_13.INIT1 = 16'h5aaa;
    defparam add_147_13.INJECT1_0 = "NO";
    defparam add_147_13.INJECT1_1 = "NO";
    LUT4 i18_4_lut_then_4_lut (.A(extern_connected), .B(signals_debounced_syn[2]), 
         .C(n9538), .D(next_state[0]), .Z(n9571)) /* synthesis lut_function=(!(A (B (C)+!B (C+(D)))+!A (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(137[12:22])
    defparam i18_4_lut_then_4_lut.init = 16'h0d0f;
    CCU2D resetcounter_i24_1473_add_4_11 (.A0(resetcounter[9]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8319), .COUT(n8320), .S0(n121), 
          .S1(n120));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473_add_4_11.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_11.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_11.INJECT1_0 = "NO";
    defparam resetcounter_i24_1473_add_4_11.INJECT1_1 = "NO";
    CCU2D add_138_15 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8204), .COUT(n8205), .S0(n197), 
          .S1(n196));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_15.INIT0 = 16'h5aaa;
    defparam add_138_15.INIT1 = 16'h5aaa;
    defparam add_138_15.INJECT1_0 = "NO";
    defparam add_138_15.INJECT1_1 = "NO";
    CCU2D add_4457_2 (.A0(\debounce_counters[2] [7]), .B0(\debounce_counters[2] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[2] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n8279));
    defparam add_4457_2.INIT0 = 16'h1000;
    defparam add_4457_2.INIT1 = 16'h5aaa;
    defparam add_4457_2.INJECT1_0 = "NO";
    defparam add_4457_2.INJECT1_1 = "NO";
    CCU2D add_786_9 (.A0(dat_count[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n8278), 
          .S0(n2012));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_786_9.INIT0 = 16'h5555;
    defparam add_786_9.INIT1 = 16'h0000;
    defparam add_786_9.INJECT1_0 = "NO";
    defparam add_786_9.INJECT1_1 = "NO";
    CCU2D add_156_23 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8240), .COUT(n8241), .S0(n401), 
          .S1(n400));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_23.INIT0 = 16'h5aaa;
    defparam add_156_23.INIT1 = 16'h5aaa;
    defparam add_156_23.INJECT1_0 = "NO";
    defparam add_156_23.INJECT1_1 = "NO";
    LUT4 i5165_3_lut (.A(n5668), .B(n9102), .C(n8498), .Z(FP_UsrLED_c_2)) /* synthesis lut_function=(A+!(B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(482[9] 497[16])
    defparam i5165_3_lut.init = 16'hbaba;
    LUT4 i18_4_lut_else_4_lut (.A(next_state[0]), .B(next_state_3__N_1092[2]), 
         .Z(n9570)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(137[12:22])
    defparam i18_4_lut_else_4_lut.init = 16'h4444;
    CCU2D add_147_11 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8218), .COUT(n8219), .S0(n307), 
          .S1(n306));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_11.INIT0 = 16'h5aaa;
    defparam add_147_11.INIT1 = 16'h5aaa;
    defparam add_147_11.INJECT1_0 = "NO";
    defparam add_147_11.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_4_lut_adj_117 (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_351), 
         .D(n_temp1_7__N_352), .Z(n5311)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A (C+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_117.init = 16'hf7f0;
    CCU2D add_786_7 (.A0(dat_count[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8277), .COUT(n8278), .S0(n2014), .S1(n2013));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_786_7.INIT0 = 16'h5555;
    defparam add_786_7.INIT1 = 16'h5555;
    defparam add_786_7.INJECT1_0 = "NO";
    defparam add_786_7.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_118 (.A(temp1[6]), .B(data0[0]), .C(n30_adj_1432), 
         .D(n33), .Z(data0_7__N_898[0])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i1_4_lut_adj_118.init = 16'hdc50;
    LUT4 i56_4_lut_adj_119 (.A(GPI_DAT[0]), .B(data0[0]), .C(temp1[5]), 
         .D(n5722), .Z(n30_adj_1432)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i56_4_lut_adj_119.init = 16'hcac0;
    CCU2D resetcounter_i24_1473_add_4_9 (.A0(resetcounter[7]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8318), .COUT(n8319), .S0(n123), 
          .S1(n122));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473_add_4_9.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_9.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_9.INJECT1_0 = "NO";
    defparam resetcounter_i24_1473_add_4_9.INJECT1_1 = "NO";
    LUT4 i2_2_lut_rep_127_3_lut (.A(n_temp1_7__N_353), .B(n_temp1_7__N_359), 
         .C(n_temp1_7__N_366), .Z(n9547)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i2_2_lut_rep_127_3_lut.init = 16'hfefe;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut (.A(DIGS3C_SlotD_ReqOE_c_5), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_5)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut.init = 16'h2222;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut (.A(DIGS3C_SlotD_ReqOE_c_4), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_4)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut.init = 16'h2222;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut (.A(DIGS3C_SlotD_ReqOE_c_3), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_3)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut.init = 16'h2222;
    LUT4 i4_4_lut_adj_120 (.A(temp1[0]), .B(n9550), .C(temp1[1]), .D(n6_adj_1429), 
         .Z(n5722)) /* synthesis lut_function=(!((B+(C+!(D)))+!A)) */ ;
    defparam i4_4_lut_adj_120.init = 16'h0200;
    LUT4 i1_2_lut_adj_121 (.A(temp1[3]), .B(temp1[2]), .Z(n6_adj_1429)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i1_2_lut_adj_121.init = 16'h4444;
    LUT4 i993_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n9566), .D(n15), 
         .Z(n3891)) /* synthesis lut_function=(((C (D))+!B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i993_3_lut_4_lut.init = 16'hf777;
    LUT4 i1_2_lut_rep_145 (.A(dat_rdy_N_1326), .B(reg_rdy_N_1322), .Z(n9565)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_2_lut_rep_145.init = 16'heeee;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut (.A(DIGS3C_SlotD_ReqOE_c_2), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_2)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut.init = 16'h2222;
    LUT4 i1_3_lut_rep_121_4_lut (.A(dat_rdy_N_1326), .B(reg_rdy_N_1322), 
         .C(n14_adj_1431), .D(n13), .Z(n9541)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_3_lut_rep_121_4_lut.init = 16'hfffe;
    LUT4 i1_4_lut_adj_122 (.A(n9550), .B(temp1[5]), .C(n9505), .D(n36), 
         .Z(n33)) /* synthesis lut_function=(A+(B (C)+!B (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i1_4_lut_adj_122.init = 16'hfbfa;
    CCU2D resetcounter_i24_1473_add_4_7 (.A0(resetcounter[5]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8317), .COUT(n8318), .S0(n125), 
          .S1(n124));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473_add_4_7.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_7.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_7.INJECT1_0 = "NO";
    defparam resetcounter_i24_1473_add_4_7.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1473_add_4_5 (.A0(resetcounter[3]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8316), .COUT(n8317), .S0(n127), 
          .S1(n126));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473_add_4_5.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_5.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_5.INJECT1_0 = "NO";
    defparam resetcounter_i24_1473_add_4_5.INJECT1_1 = "NO";
    LUT4 i5190_4_lut_4_lut (.A(n9538), .B(next_state[1]), .C(next_state_3__N_1092[2]), 
         .D(n9559), .Z(n9072)) /* synthesis lut_function=(A (B (D)+!B ((D)+!C))+!A (B+((D)+!C))) */ ;
    defparam i5190_4_lut_4_lut.init = 16'hff47;
    LUT4 i1_2_lut_adj_123 (.A(temp1[6]), .B(temp1[0]), .Z(n36)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i1_2_lut_adj_123.init = 16'hbbbb;
    LUT4 i1026_2_lut_rep_122_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_358), 
         .Z(n9542)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1026_2_lut_rep_122_3_lut.init = 16'h8080;
    LUT4 mux_1082_Mux_11_i6_3_lut_4_lut (.A(next_state_3__N_1092[2]), .B(n9538), 
         .C(next_state[1]), .D(next_state[0]), .Z(n6_adj_1433)) /* synthesis lut_function=(A (C (D))+!A (B (C (D))+!B (C (D)+!C !(D)))) */ ;
    defparam mux_1082_Mux_11_i6_3_lut_4_lut.init = 16'hf001;
    FD1P3AX counter_i0_i8 (.D(n4514), .SP(clk_enable_188), .CK(clk), .Q(counter[8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i8.GSR = "ENABLED";
    FD1P3AX counter_i0_i9 (.D(n4513), .SP(clk_enable_188), .CK(clk), .Q(counter[9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i9.GSR = "ENABLED";
    FD1P3AX counter_i0_i12 (.D(n4510), .SP(clk_enable_188), .CK(clk), 
            .Q(counter[12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i12.GSR = "ENABLED";
    LUT4 i1_4_lut_then_4_lut (.A(n9538), .B(next_state[2]), .C(next_state[1]), 
         .D(next_state[0]), .Z(n9574)) /* synthesis lut_function=(A (B+(C (D)))+!A !((C (D)+!C !(D))+!B)) */ ;
    defparam i1_4_lut_then_4_lut.init = 16'hacc8;
    LUT4 i1_2_lut_3_lut_adj_124 (.A(dat_rdy_N_1326), .B(reg_rdy_N_1322), 
         .C(n_temp1_7__N_365), .Z(n47)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_2_lut_3_lut_adj_124.init = 16'hfefe;
    FD1P3AX counter_i0_i18 (.D(n4504), .SP(clk_enable_188), .CK(clk), 
            .Q(counter[18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i18.GSR = "ENABLED";
    FD1P3AX counter_i0_i19 (.D(n4503), .SP(clk_enable_188), .CK(clk), 
            .Q(counter[19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i19.GSR = "ENABLED";
    FD1P3AX counter_i0_i20 (.D(n4502), .SP(clk_enable_188), .CK(clk), 
            .Q(counter[20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i20.GSR = "ENABLED";
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut (.A(DIGS3C_SlotD_ReqOE_c_1), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_1)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(437[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut.init = 16'h2222;
    FD1P3AX counter_i0_i22 (.D(n4500), .SP(clk_enable_188), .CK(clk), 
            .Q(counter[22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i22.GSR = "ENABLED";
    FD1P3AX counter_i0_i23 (.D(n4499), .SP(clk_enable_188), .CK(clk), 
            .Q(counter[23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i23.GSR = "ENABLED";
    FD1P3AX counter_i0_i24 (.D(n4498), .SP(clk_enable_188), .CK(clk), 
            .Q(counter[24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i1 (.D(n421), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i1.GSR = "ENABLED";
    CCU2D add_786_5 (.A0(dat_count[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8276), .COUT(n8277), .S0(n2016), .S1(n2015));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_786_5.INIT0 = 16'h5555;
    defparam add_786_5.INIT1 = 16'h5555;
    defparam add_786_5.INJECT1_0 = "NO";
    defparam add_786_5.INJECT1_1 = "NO";
    LUT4 i1_4_lut_else_4_lut (.A(n9538), .B(next_state[2]), .C(next_state[1]), 
         .D(next_state[0]), .Z(n9573)) /* synthesis lut_function=(A (B (C (D)+!C !(D))+!B (C (D)))) */ ;
    defparam i1_4_lut_else_4_lut.init = 16'ha008;
    CCU2D add_786_3 (.A0(dat_count[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8275), .COUT(n8276), .S0(n2018), .S1(n2017));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_786_3.INIT0 = 16'h5555;
    defparam add_786_3.INIT1 = 16'h5555;
    defparam add_786_3.INJECT1_0 = "NO";
    defparam add_786_3.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_1473_add_4_3 (.A0(resetcounter[1]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8315), .COUT(n8316), .S0(n129), 
          .S1(n128));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473_add_4_3.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_3.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_1473_add_4_3.INJECT1_0 = "NO";
    defparam resetcounter_i24_1473_add_4_3.INJECT1_1 = "NO";
    CCU2D add_138_13 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8203), .COUT(n8204), .S0(n199), 
          .S1(n198));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_13.INIT0 = 16'h5aaa;
    defparam add_138_13.INIT1 = 16'h5aaa;
    defparam add_138_13.INJECT1_0 = "NO";
    defparam add_138_13.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_146 (.A(n_state_7__N_1040[4]), .B(wb_dat_o[2]), .Z(n9566)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam i1_2_lut_rep_146.init = 16'h2222;
    CCU2D add_156_21 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8239), .COUT(n8240), .S0(n403), 
          .S1(n402));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_21.INIT0 = 16'h5aaa;
    defparam add_156_21.INIT1 = 16'h5aaa;
    defparam add_156_21.INJECT1_0 = "NO";
    defparam add_156_21.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_4_lut_adj_125 (.A(n_state_7__N_1040[4]), .B(wb_dat_o[2]), 
         .C(n6946), .D(n15), .Z(n9007)) /* synthesis lut_function=(!((B+!(C+(D)))+!A)) */ ;
    defparam i1_2_lut_3_lut_4_lut_adj_125.init = 16'h2220;
    LUT4 i1678_4_lut_4_lut (.A(clk_enable_5), .B(n_state_7__N_1040[4]), 
         .C(n_temp1_7__N_353), .D(n_temp1_7__N_354), .Z(n5307)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(879[7] 899[12])
    defparam i1678_4_lut_4_lut.init = 16'hfda0;
    LUT4 i5_4_lut (.A(n_temp1_7__N_369), .B(n_temp1_7__N_367), .C(n_temp1_7__N_363), 
         .D(n_temp1_7__N_357), .Z(n13)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i5_4_lut.init = 16'hfffe;
    LUT4 i6_4_lut_adj_126 (.A(n_temp1_7__N_354), .B(n8934), .C(n_temp1_7__N_368), 
         .D(n9035), .Z(n14_adj_1431)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i6_4_lut_adj_126.init = 16'hfffe;
    LUT4 i1_3_lut_4_lut_adj_127 (.A(n_state_7__N_984[3]), .B(clk_enable_5), 
         .C(reg_rdy_N_1322), .D(n47), .Z(n17)) /* synthesis lut_function=(!(A (B (D)+!B !(C+!(D)))+!A !(C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_3_lut_4_lut_adj_127.init = 16'h70ff;
    CCU2D add_786_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n8275), .S1(n2019));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_786_1.INIT0 = 16'hF000;
    defparam add_786_1.INIT1 = 16'h5555;
    defparam add_786_1.INJECT1_0 = "NO";
    defparam add_786_1.INJECT1_1 = "NO";
    LUT4 n4_bdd_3_lut_5401_3_lut (.A(next_state[1]), .B(next_state[0]), 
         .C(next_state[2]), .Z(n9481)) /* synthesis lut_function=(!(A (C)+!A (B+(C)))) */ ;
    defparam n4_bdd_3_lut_5401_3_lut.init = 16'h0b0b;
    LUT4 i5288_2_lut_3_lut (.A(n4570), .B(n4572), .C(clk_enable_188), 
         .Z(n7091)) /* synthesis lut_function=(A (B (C))+!A (C)) */ ;
    defparam i5288_2_lut_3_lut.init = 16'hd0d0;
    CCU2D add_156_19 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8238), .COUT(n8239), .S0(n405), 
          .S1(n404));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_19.INIT0 = 16'h5aaa;
    defparam add_156_19.INIT1 = 16'h5aaa;
    defparam add_156_19.INJECT1_0 = "NO";
    defparam add_156_19.INJECT1_1 = "NO";
    CCU2D add_147_9 (.A0(\debounce_counters[2] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8217), .COUT(n8218), .S0(n309), 
          .S1(n308));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_9.INIT0 = 16'h5aaa;
    defparam add_147_9.INIT1 = 16'h5aaa;
    defparam add_147_9.INJECT1_0 = "NO";
    defparam add_147_9.INJECT1_1 = "NO";
    CCU2D add_147_7 (.A0(\debounce_counters[2] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8216), .COUT(n8217), .S0(n311), 
          .S1(n310));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_7.INIT0 = 16'h5aaa;
    defparam add_147_7.INIT1 = 16'h5aaa;
    defparam add_147_7.INJECT1_0 = "NO";
    defparam add_147_7.INJECT1_1 = "NO";
    CCU2D add_156_17 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8237), .COUT(n8238), .S0(n407), 
          .S1(n406));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_17.INIT0 = 16'h5aaa;
    defparam add_156_17.INIT1 = 16'h5aaa;
    defparam add_156_17.INJECT1_0 = "NO";
    defparam add_156_17.INJECT1_1 = "NO";
    LUT4 n7_bdd_4_lut (.A(n9544), .B(next_state[1]), .C(next_state_3__N_1092[2]), 
         .D(next_state[0]), .Z(n25)) /* synthesis lut_function=(!(A (B (C (D)+!C !(D))+!B !(C))+!A ((C (D)+!C !(D))+!B))) */ ;
    defparam n7_bdd_4_lut.init = 16'h2ce0;
    LUT4 i2_4_lut_4_lut (.A(clk_enable_5), .B(n_state_7__N_1040[4]), .C(n5_adj_1436), 
         .D(n_temp1_7__N_367), .Z(n6_adj_1415)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(879[7] 899[12])
    defparam i2_4_lut_4_lut.init = 16'hfda0;
    LUT4 i5283_4_lut_then_3_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[0]), 
         .Z(n9577)) /* synthesis lut_function=(A (B+(C))+!A (B (C))) */ ;
    defparam i5283_4_lut_then_3_lut.init = 16'he8e8;
    CCU2D add_787_25 (.A0(counter[23]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[24]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8273), .S0(n3069), .S1(n3068));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1482[17:24])
    defparam add_787_25.INIT0 = 16'h5555;
    defparam add_787_25.INIT1 = 16'h5555;
    defparam add_787_25.INJECT1_0 = "NO";
    defparam add_787_25.INJECT1_1 = "NO";
    CCU2D add_156_15 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8236), .COUT(n8237), .S0(n409), 
          .S1(n408));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_15.INIT0 = 16'h5aaa;
    defparam add_156_15.INIT1 = 16'h5aaa;
    defparam add_156_15.INJECT1_0 = "NO";
    defparam add_156_15.INJECT1_1 = "NO";
    LUT4 i2_3_lut (.A(n_temp1_7__N_355), .B(n_temp1_7__N_358), .C(n_temp1_7__N_356), 
         .Z(n8934)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i2_3_lut.init = 16'hfefe;
    CCU2D add_147_5 (.A0(\debounce_counters[2] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8215), .COUT(n8216), .S0(n313), 
          .S1(n312));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_147_5.INIT0 = 16'h5aaa;
    defparam add_147_5.INIT1 = 16'h5aaa;
    defparam add_147_5.INJECT1_0 = "NO";
    defparam add_147_5.INJECT1_1 = "NO";
    LUT4 i1_3_lut_4_lut_adj_128 (.A(next_state[1]), .B(n9563), .C(next_state[2]), 
         .D(externstop_falling), .Z(n11)) /* synthesis lut_function=(A (C)+!A (B (C+(D))+!B (C))) */ ;
    defparam i1_3_lut_4_lut_adj_128.init = 16'hf4f0;
    FD1P3IX debounce_counters_3___i2 (.D(n420), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i3 (.D(n419), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i4 (.D(n418), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i5 (.D(n417), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i6 (.D(n416), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i7 (.D(n415), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i8 (.D(n414), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i9 (.D(n413), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i10 (.D(n412), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i11 (.D(n411), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i12 (.D(n410), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i13 (.D(n409), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i14 (.D(n408), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i15 (.D(n407), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i16 (.D(n406), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i17 (.D(n405), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i18 (.D(n404), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i19 (.D(n403), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i20 (.D(n402), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i21 (.D(n401), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i22 (.D(n400), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i23 (.D(n399), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i24 (.D(n398), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i25 (.D(n397), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i26 (.D(n396), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i27 (.D(n395), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i28 (.D(n394), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i29 (.D(n393), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i30 (.D(n392), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i31 (.D(n391), .SP(clk_enable_178), .CD(debounce_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam debounce_counters_3___i31.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i1 (.D(n129), .CK(clk), .Q(resetcounter[1])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i1.GSR = "ENABLED";
    LUT4 mux_1082_Mux_3_i15_4_lut (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[3]), .D(next_state[2]), .Z(FP_SysLEDs_N_1301)) /* synthesis lut_function=(!(A (B (C)+!B (C (D)))+!A (B+(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam mux_1082_Mux_3_i15_4_lut.init = 16'h0b3b;
    CCU2D add_787_23 (.A0(counter[21]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[22]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8272), .COUT(n8273), .S0(n3071), .S1(n3070));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1482[17:24])
    defparam add_787_23.INIT0 = 16'h5555;
    defparam add_787_23.INIT1 = 16'h5555;
    defparam add_787_23.INJECT1_0 = "NO";
    defparam add_787_23.INJECT1_1 = "NO";
    LUT4 i3357_2_lut (.A(n3071), .B(n4566), .Z(n4401)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam i3357_2_lut.init = 16'heeee;
    LUT4 i2_3_lut_4_lut_adj_129 (.A(n9536), .B(clk_enable_5), .C(n6942), 
         .D(n_temp1_7__N_359), .Z(n8376)) /* synthesis lut_function=(!(((C+!(D))+!B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1026[5] 1034[15])
    defparam i2_3_lut_4_lut_adj_129.init = 16'h0800;
    CCU2D add_787_21 (.A0(counter[19]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[20]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8271), .COUT(n8272), .S0(n3073), .S1(n3072));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1482[17:24])
    defparam add_787_21.INIT0 = 16'h5555;
    defparam add_787_21.INIT1 = 16'h5555;
    defparam add_787_21.INJECT1_0 = "NO";
    defparam add_787_21.INJECT1_1 = "NO";
    LUT4 i1648_4_lut (.A(n_temp1_7__N_369), .B(dat_rdy_N_1326), .C(n3891), 
         .D(n6975), .Z(n5277)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1648_4_lut.init = 16'heca0;
    CCU2D resetcounter_i24_1473_add_4_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n7171), .B1(n8379), .C1(resetcounter[0]), 
          .D1(GND_net), .COUT(n8315), .S1(n130));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473_add_4_1.INIT0 = 16'hF000;
    defparam resetcounter_i24_1473_add_4_1.INIT1 = 16'h8787;
    defparam resetcounter_i24_1473_add_4_1.INJECT1_0 = "NO";
    defparam resetcounter_i24_1473_add_4_1.INJECT1_1 = "NO";
    LUT4 i5283_4_lut_else_3_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state_3__N_1092[2]), 
         .D(next_state[0]), .Z(n9576)) /* synthesis lut_function=(A (B)+!A !(B+(C (D)+!C !(D)))) */ ;
    defparam i5283_4_lut_else_3_lut.init = 16'h8998;
    CCU2D add_4455_26 (.A0(\debounce_counters[4] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8314), .S1(clk_enable_125));
    defparam add_4455_26.INIT0 = 16'hf555;
    defparam add_4455_26.INIT1 = 16'h0000;
    defparam add_4455_26.INJECT1_0 = "NO";
    defparam add_4455_26.INJECT1_1 = "NO";
    CCU2D add_156_13 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8235), .COUT(n8236), .S0(n411), 
          .S1(n410));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_13.INIT0 = 16'h5aaa;
    defparam add_156_13.INIT1 = 16'h5aaa;
    defparam add_156_13.INJECT1_0 = "NO";
    defparam add_156_13.INJECT1_1 = "NO";
    FD1P3IX counter_i0_i17 (.D(n4471), .SP(clk_enable_188), .CD(n6030), 
            .CK(clk), .Q(counter[17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i17.GSR = "ENABLED";
    LUT4 i930_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_state_7__N_1040[4]), 
         .D(wb_dat_o[4]), .Z(n3828)) /* synthesis lut_function=(!(A (B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i930_3_lut_4_lut.init = 16'h77f7;
    LUT4 mux_1296_i7_4_lut (.A(next_state[1]), .B(n3086), .C(n4570), .D(n4566), 
         .Z(n4482)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam mux_1296_i7_4_lut.init = 16'h0aca;
    FD1P3IX counter_i0_i16 (.D(n4472), .SP(clk_enable_188), .CD(n6030), 
            .CK(clk), .Q(counter[16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i16.GSR = "ENABLED";
    LUT4 i1683_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(dat_rdy_N_1326), 
         .Z(dat_rdy_N_1324)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1683_2_lut_3_lut.init = 16'h8080;
    LUT4 i1_3_lut_4_lut_adj_130 (.A(n_temp1_7__N_352), .B(n9547), .C(n_temp1_7__N_365), 
         .D(clk_enable_5), .Z(n_wb_we_i)) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_3_lut_4_lut_adj_130.init = 16'h00fe;
    LUT4 i5216_4_lut_else_4_lut (.A(n14), .B(temp1[1]), .C(temp1[0]), 
         .D(temp1[3]), .Z(n9567)) /* synthesis lut_function=(A+((C+!(D))+!B)) */ ;
    defparam i5216_4_lut_else_4_lut.init = 16'hfbff;
    FD1P3IX counter_i0_i15 (.D(n4473), .SP(clk_enable_188), .CD(n6030), 
            .CK(clk), .Q(counter[15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i15.GSR = "ENABLED";
    FD1P3IX counter_i0_i14 (.D(n4408), .SP(clk_enable_188), .CD(n7091), 
            .CK(clk), .Q(counter[14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i14.GSR = "ENABLED";
    FD1P3AX extern_connected_696 (.D(n9834), .SP(clk_enable_183), .CK(clk), 
            .Q(extern_connected)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam extern_connected_696.GSR = "ENABLED";
    LUT4 i60_3_lut (.A(next_state_3__N_1092[2]), .B(n9538), .C(next_state[0]), 
         .Z(n4846)) /* synthesis lut_function=(!(A (B (C))+!A (B+!(C)))) */ ;
    defparam i60_3_lut.init = 16'h3a3a;
    LUT4 i1_4_lut_adj_131 (.A(next_state[3]), .B(externstop_falling), .C(n11), 
         .D(n8966), .Z(n4572)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;
    defparam i1_4_lut_adj_131.init = 16'heca0;
    FD1P3IX counter_i0_i13 (.D(n4475), .SP(clk_enable_188), .CD(n6030), 
            .CK(clk), .Q(counter[13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i13.GSR = "ENABLED";
    LUT4 i1719_3_lut_4_lut (.A(n_temp1_7__N_366), .B(n9564), .C(n9541), 
         .D(clk_enable_5), .Z(n_wb_adr_i[0])) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1719_3_lut_4_lut.init = 16'h00fe;
    FD1P3AX FPIO_isoCtrlRSTn_692 (.D(FPIO_isoCtrlRSTn_N_1290), .SP(clk_enable_185), 
            .CK(clk), .Q(FPIO_isoCtrlRSTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam FPIO_isoCtrlRSTn_692.GSR = "ENABLED";
    FD1S3AX c_state_FSM_i19 (.D(n9561), .CK(clk), .Q(n_temp1_7__N_351));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam c_state_FSM_i19.GSR = "ENABLED";
    LUT4 i1_4_lut_adj_132 (.A(PG_Module_c), .B(n89), .C(n94), .D(n90), 
         .Z(dummy_signal)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i1_4_lut_adj_132.init = 16'h8000;
    LUT4 i41_4_lut (.A(DIG5S3C27_out), .B(n82), .C(n66), .D(DIG5S3C28_out), 
         .Z(n89)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i41_4_lut.init = 16'h8000;
    FD1P3IX counter_i0_i11 (.D(n4477), .SP(clk_enable_188), .CD(n6030), 
            .CK(clk), .Q(counter[11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i11.GSR = "ENABLED";
    FD1P3AX FP_SysLEDr_686 (.D(FP_SysLEDr_N_1288), .SP(clk_enable_187), 
            .CK(clk), .Q(FP_SysLEDr_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam FP_SysLEDr_686.GSR = "ENABLED";
    LUT4 i1_2_lut_3_lut_4_lut_adj_133 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[4]), 
         .D(n_temp1_7__N_365), .Z(n_wb_dat_i[4])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_133.init = 16'h7000;
    FD1P3IX counter_i0_i10 (.D(n4478), .SP(clk_enable_188), .CD(n6030), 
            .CK(clk), .Q(counter[10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam counter_i0_i10.GSR = "ENABLED";
    LUT4 i1191_2_lut_rep_111_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n6946), 
         .Z(n9531)) /* synthesis lut_function=(!(((C)+!B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1191_2_lut_rep_111_3_lut.init = 16'h0808;
    LUT4 i1_3_lut_4_lut_4_lut (.A(clk_enable_5), .B(n_temp1_7__N_365), .C(data0[7]), 
         .D(n_temp1_7__N_352), .Z(n_wb_dat_i[7])) /* synthesis lut_function=(!(A+!(B (C+(D))+!B (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_3_lut_4_lut_4_lut.init = 16'h5540;
    LUT4 i3355_4_lut (.A(n9538), .B(externstop_falling), .C(next_state[3]), 
         .D(next_state[2]), .Z(n7008)) /* synthesis lut_function=(A (B+(D))+!A (B (C)+!B (C (D)))) */ ;
    defparam i3355_4_lut.init = 16'hfac8;
    LUT4 i5263_4_lut (.A(n5724), .B(n48), .C(n50), .D(data0[7]), .Z(data0_7__N_898[7])) /* synthesis lut_function=(!(A+(B+!((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i5263_4_lut.init = 16'h1101;
    CCU2D add_156_11 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8234), .COUT(n8235), .S0(n413), 
          .S1(n412));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_11.INIT0 = 16'h5aaa;
    defparam add_156_11.INIT1 = 16'h5aaa;
    defparam add_156_11.INJECT1_0 = "NO";
    defparam add_156_11.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_134 (.A(GPI_DAT[7]), .B(n5722), .C(temp1[5]), .D(temp1[6]), 
         .Z(n5724)) /* synthesis lut_function=(A (B (C (D)))+!A (B (C (D)+!C !(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i1_4_lut_adj_134.init = 16'hc004;
    LUT4 i1_3_lut_adj_135 (.A(temp1[6]), .B(n18_adj_1403), .C(data0[7]), 
         .Z(n48)) /* synthesis lut_function=(A (B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(572[1] 587[11])
    defparam i1_3_lut_adj_135.init = 16'h8a8a;
    LUT4 i5277_4_lut_4_lut (.A(n9534), .B(n8942), .C(n5959), .D(n9072), 
         .Z(clk_enable_135)) /* synthesis lut_function=(!(A+(B+(C+!(D))))) */ ;
    defparam i5277_4_lut_4_lut.init = 16'h0100;
    LUT4 next_state_1__bdd_4_lut_5383 (.A(next_state[1]), .B(next_state[2]), 
         .C(next_state[0]), .D(next_state[3]), .Z(clk_enable_189)) /* synthesis lut_function=(A (B (C+(D)))+!A (B ((D)+!C)+!B !(C+(D)))) */ ;
    defparam next_state_1__bdd_4_lut_5383.init = 16'hcc85;
    LUT4 i2_4_lut_adj_136 (.A(dat_count[0]), .B(n12_adj_1401), .C(n17), 
         .D(n15_adj_1399), .Z(n_dat_count[0])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i2_4_lut_adj_136.init = 16'hffec;
    LUT4 i2_3_lut_rep_116_4_lut (.A(temp1[6]), .B(n9543), .C(temp1[0]), 
         .D(n9552), .Z(n9536)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i2_3_lut_rep_116_4_lut.init = 16'hfffe;
    LUT4 i46_4_lut (.A(n73), .B(n92), .C(n86), .D(n74), .Z(n94)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i46_4_lut.init = 16'h8000;
    LUT4 i4_4_lut_adj_137 (.A(temp1[1]), .B(temp1[3]), .C(temp1[0]), .D(temp1[5]), 
         .Z(n10)) /* synthesis lut_function=(!(((C+!(D))+!B)+!A)) */ ;
    defparam i4_4_lut_adj_137.init = 16'h0800;
    LUT4 i42_4_lut (.A(FlexMIOs63_out), .B(n84), .C(n70), .D(TDnFFnFS_c), 
         .Z(n90)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i42_4_lut.init = 16'h8000;
    CCU2D add_156_9 (.A0(\debounce_counters[3] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8233), .COUT(n8234), .S0(n415), 
          .S1(n414));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_156_9.INIT0 = 16'h5aaa;
    defparam add_156_9.INIT1 = 16'h5aaa;
    defparam add_156_9.INJECT1_0 = "NO";
    defparam add_156_9.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_138 (.A(n_temp1_7__N_365), .B(dat_count[0]), .C(n2019), 
         .D(n9531), .Z(n12_adj_1401)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_138.init = 16'ha088;
    LUT4 i1_4_lut_adj_139 (.A(dat_rdy_N_1326), .B(n2019), .C(dat_count[0]), 
         .D(n6975), .Z(n15_adj_1399)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_139.init = 16'h88a0;
    LUT4 mux_1296_i10_4_lut (.A(next_state[1]), .B(n3083), .C(n4570), 
         .D(n4566), .Z(n4479)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam mux_1296_i10_4_lut.init = 16'hfaca;
    LUT4 i1_4_lut_adj_140 (.A(temp1[6]), .B(data0[6]), .C(n30_adj_1406), 
         .D(n33), .Z(data0_7__N_898[6])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i1_4_lut_adj_140.init = 16'hdc50;
    LUT4 i56_4_lut_adj_141 (.A(GPI_DAT[6]), .B(data0[6]), .C(temp1[5]), 
         .D(n5722), .Z(n30_adj_1406)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i56_4_lut_adj_141.init = 16'hcac0;
    LUT4 i1_2_lut_adj_142 (.A(n4570), .B(n4566), .Z(n5422)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam i1_2_lut_adj_142.init = 16'hdddd;
    LUT4 i34_4_lut (.A(FPIO_iosCtrlINTn_c), .B(FlexMIOs35_out), .C(FlexMIOs34_out), 
         .D(FlexMIOs37_out), .Z(n82)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i34_4_lut.init = 16'h8000;
    LUT4 i1_4_lut_adj_143 (.A(temp1[6]), .B(data0[5]), .C(n30_adj_1407), 
         .D(n33), .Z(data0_7__N_898[5])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i1_4_lut_adj_143.init = 16'hdc50;
    LUT4 i1_2_lut_rep_110_3_lut (.A(n15), .B(n6946), .C(n_temp1_7__N_368), 
         .Z(n9530)) /* synthesis lut_function=(A (C)+!A (B (C))) */ ;
    defparam i1_2_lut_rep_110_3_lut.init = 16'he0e0;
    LUT4 i880_4_lut_4_lut (.A(n9536), .B(clk_enable_5), .C(n6942), .D(n7141), 
         .Z(n3778)) /* synthesis lut_function=(A (B (C (D)))+!A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1026[5] 1034[15])
    defparam i880_4_lut_4_lut.init = 16'hc444;
    LUT4 mux_1305_i13_4_lut (.A(n3080), .B(n9557), .C(n4572), .D(n5422), 
         .Z(n4510)) /* synthesis lut_function=(!(A (B (C))+!A (B (C+!(D))+!B !(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam mux_1305_i13_4_lut.init = 16'h3f3a;
    LUT4 i56_4_lut_adj_144 (.A(GPI_DAT[5]), .B(data0[5]), .C(temp1[5]), 
         .D(n5722), .Z(n30_adj_1407)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i56_4_lut_adj_144.init = 16'hcac0;
    CCU2D add_138_11 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n8202), .COUT(n8203), .S0(n201), 
          .S1(n200));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(451[49:69])
    defparam add_138_11.INIT0 = 16'h5aaa;
    defparam add_138_11.INIT1 = 16'h5aaa;
    defparam add_138_11.INJECT1_0 = "NO";
    defparam add_138_11.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_4_lut_adj_145 (.A(wb_ack_o), .B(wb_stb_i), .C(n9541), 
         .D(n_temp1_7__N_365), .Z(n_wb_adr_i[2])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_145.init = 16'h7770;
    LUT4 i1668_3_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_359), 
         .D(n_temp1_7__N_358), .Z(n5297)) /* synthesis lut_function=(A (B (D)+!B (C))+!A (C)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1668_3_lut_3_lut_4_lut.init = 16'hf870;
    CCU2D add_787_19 (.A0(counter[17]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[18]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n8270), .COUT(n8271), .S0(n3075), .S1(n3074));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1482[17:24])
    defparam add_787_19.INIT0 = 16'h5555;
    defparam add_787_19.INIT1 = 16'h5555;
    defparam add_787_19.INJECT1_0 = "NO";
    defparam add_787_19.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_4_lut_adj_146 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[0]), 
         .D(n_temp1_7__N_365), .Z(n_wb_dat_i[0])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_146.init = 16'h7000;
    LUT4 i1_3_lut_4_lut_adj_147 (.A(n_temp1_7__N_365), .B(n9541), .C(n9539), 
         .D(clk_enable_5), .Z(n_wb_adr_i[6])) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B ((D)+!C)))) */ ;
    defparam i1_3_lut_4_lut_adj_147.init = 16'h00fe;
    LUT4 i2_3_lut_4_lut_adj_148 (.A(temp1[3]), .B(n9537), .C(n6946), .D(n_state_7__N_984[3]), 
         .Z(n7141)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;
    defparam i2_3_lut_4_lut_adj_148.init = 16'he000;
    LUT4 i18_2_lut (.A(FPIO_FlexMIO28_out), .B(FPIO_FlexMIO29_out), .Z(n66)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i18_2_lut.init = 16'h8888;
    LUT4 temp1_1__bdd_3_lut (.A(temp1[0]), .B(temp1[3]), .C(temp1[2]), 
         .Z(n9504)) /* synthesis lut_function=((B+!(C))+!A) */ ;
    defparam temp1_1__bdd_3_lut.init = 16'hdfdf;
    LUT4 temp1_1__bdd_4_lut (.A(temp1[5]), .B(temp1[0]), .C(temp1[3]), 
         .D(temp1[2]), .Z(n9503)) /* synthesis lut_function=(A (B+((D)+!C))+!A ((D)+!C)) */ ;
    defparam temp1_1__bdd_4_lut.init = 16'hff8f;
    LUT4 i1_2_lut_3_lut_4_lut_adj_149 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[1]), 
         .D(n_temp1_7__N_365), .Z(n_wb_dat_i[1])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(947[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_149.init = 16'h7000;
    LUT4 i1_4_lut_adj_150 (.A(temp1[6]), .B(data0[4]), .C(n30_adj_1414), 
         .D(n33), .Z(data0_7__N_898[4])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i1_4_lut_adj_150.init = 16'hdc50;
    LUT4 i56_4_lut_adj_151 (.A(GPI_DAT[4]), .B(data0[4]), .C(temp1[5]), 
         .D(n5722), .Z(n30_adj_1414)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i56_4_lut_adj_151.init = 16'hcac0;
    LUT4 i25_4_lut_adj_152 (.A(DIG5S3C03_out), .B(DIGS3C_SlotD_SlotOK_c_1), 
         .C(TDnALERT_c), .D(DIGS3C_SlotD_SlotOK_c_5), .Z(n73)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i25_4_lut_adj_152.init = 16'h8000;
    LUT4 i44_4_lut (.A(n57), .B(n88), .C(n78), .D(n58), .Z(n92)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i44_4_lut.init = 16'h8000;
    LUT4 i38_4_lut (.A(S3CsI2C_SDA_c), .B(n76), .C(n54), .D(SD1_CD_c), 
         .Z(n86)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i38_4_lut.init = 16'h8000;
    LUT4 i26_4_lut (.A(DIG5S3C01_out), .B(FlexMIOs32_out), .C(DIG5S3C02_out), 
         .D(FlexMIOs62_out), .Z(n74)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i26_4_lut.init = 16'h8000;
    LUT4 mux_1296_i21_4_lut_4_lut (.A(next_state[1]), .B(n4566), .C(n4570), 
         .D(n3072), .Z(n4468)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_1296_i21_4_lut_4_lut.init = 16'hf5c5;
    LUT4 temp1_7__I_0_777_i10_2_lut_rep_128 (.A(temp1[2]), .B(temp1[3]), 
         .Z(n9548)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(743[58:76])
    defparam temp1_7__I_0_777_i10_2_lut_rep_128.init = 16'heeee;
    PFUMX i5319 (.BLUT(n9322), .ALUT(n9318), .C0(next_state[3]), .Z(next_state_3__N_69[3]));
    GSR GSR_INST (.GSR(VCC_net));
    LUT4 mux_1305_i23_4_lut (.A(n3070), .B(n9557), .C(n4572), .D(n5422), 
         .Z(n4500)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam mux_1305_i23_4_lut.init = 16'h303a;
    LUT4 i9_2_lut (.A(DIG5S3C00_out), .B(DIG5S3C29_out), .Z(n57)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i9_2_lut.init = 16'h8888;
    FD1P3AX FlexMIOs53_GPIO_PowerDown_685 (.D(FlexMIOs53_GPIO_PowerDown_N_1304), 
            .SP(clk_enable_189), .CK(clk), .Q(FlexMIOs53_GPIO_PowerDown_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam FlexMIOs53_GPIO_PowerDown_685.GSR = "ENABLED";
    LUT4 i40_4_lut (.A(S3C_S1_c), .B(n80), .C(n62), .D(S3CsI2C_SCL_c), 
         .Z(n88)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i40_4_lut.init = 16'h8000;
    FD1S3AX resetcounter_i24_1473__i2 (.D(n128), .CK(clk), .Q(resetcounter[2])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i2.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i3 (.D(n127), .CK(clk), .Q(resetcounter[3])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i3.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i4 (.D(n126), .CK(clk), .Q(resetcounter[4])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i4.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i5 (.D(n125), .CK(clk), .Q(resetcounter[5])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i5.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i6 (.D(n124), .CK(clk), .Q(resetcounter[6])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i6.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i7 (.D(n123), .CK(clk), .Q(resetcounter[7])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i7.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i8 (.D(n122), .CK(clk), .Q(resetcounter[8])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i8.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i9 (.D(n121), .CK(clk), .Q(resetcounter[9])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i9.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i10 (.D(n120), .CK(clk), .Q(resetcounter[10])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i10.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i11 (.D(n119), .CK(clk), .Q(resetcounter[11])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i11.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i12 (.D(n118), .CK(clk), .Q(resetcounter[12])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i12.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i13 (.D(n117), .CK(clk), .Q(resetcounter[13])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i13.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i14 (.D(n116), .CK(clk), .Q(resetcounter[14])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i14.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i15 (.D(n115), .CK(clk), .Q(resetcounter[15])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i15.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i16 (.D(n114), .CK(clk), .Q(resetcounter[16])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i16.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i17 (.D(n113), .CK(clk), .Q(resetcounter[17])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i17.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i18 (.D(n112), .CK(clk), .Q(resetcounter[18])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i18.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i19 (.D(n111), .CK(clk), .Q(resetcounter[19])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i19.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i20 (.D(n110), .CK(clk), .Q(resetcounter[20])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i20.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i21 (.D(n109), .CK(clk), .Q(resetcounter[21])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i21.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i22 (.D(n108), .CK(clk), .Q(resetcounter[22])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i22.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i23 (.D(n107), .CK(clk), .Q(resetcounter[23])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i23.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_1473__i24 (.D(n106), .CK(clk), .Q(resetcounter[24])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(504[20:32])
    defparam resetcounter_i24_1473__i24.GSR = "ENABLED";
    LUT4 temp1_7__I_0_777_i9_2_lut_rep_129 (.A(temp1[0]), .B(temp1[1]), 
         .Z(n9549)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(743[58:76])
    defparam temp1_7__I_0_777_i9_2_lut_rep_129.init = 16'hdddd;
    LUT4 mux_1305_i24_4_lut (.A(n3069), .B(n9557), .C(n4572), .D(n5422), 
         .Z(n4499)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam mux_1305_i24_4_lut.init = 16'h303a;
    LUT4 i30_4_lut (.A(FlexMIOs31_out), .B(FlexMIOs45_c), .C(FlexMIOs36_out), 
         .D(FlexMIOs54_out), .Z(n78)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i30_4_lut.init = 16'h8000;
    LUT4 mux_1305_i25_4_lut (.A(n3068), .B(n9557), .C(n4572), .D(n5422), 
         .Z(n4498)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam mux_1305_i25_4_lut.init = 16'h303a;
    LUT4 i10_2_lut (.A(FPIO_FlexMIO30_out), .B(FP_UsrSW2_c), .Z(n58)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i10_2_lut.init = 16'h8888;
    LUT4 i32_4_lut (.A(PG_VIN_c), .B(DIGS3C_SlotD_SlotOK_c_2), .C(ANL_S3C_SLOTOK_c_1), 
         .D(DIG5S3C25_out), .Z(n80)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i32_4_lut.init = 16'h8000;
    PFUMX i5402 (.BLUT(n9482), .ALUT(n9481), .C0(next_state[3]), .Z(FP_SysLEDr_N_1288));
    LUT4 i3513_4_lut (.A(n5_adj_1411), .B(resetcounter[21]), .C(resetcounter[18]), 
         .D(resetcounter[20]), .Z(n7171)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;
    defparam i3513_4_lut.init = 16'heccc;
    LUT4 i1_4_lut_adj_153 (.A(n9030), .B(resetcounter[19]), .C(n8937), 
         .D(resetcounter[12]), .Z(n5_adj_1411)) /* synthesis lut_function=(A (B (C+(D)))+!A (B (C))) */ ;
    defparam i1_4_lut_adj_153.init = 16'hc8c0;
    LUT4 i2_3_lut_adj_154 (.A(resetcounter[24]), .B(resetcounter[23]), .C(resetcounter[22]), 
         .Z(n8379)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(503[6:29])
    defparam i2_3_lut_adj_154.init = 16'h8080;
    LUT4 i5163_2_lut_3_lut_4_lut (.A(temp1[0]), .B(temp1[1]), .C(temp1[3]), 
         .D(temp1[2]), .Z(n9044)) /* synthesis lut_function=((B+(C+(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(743[58:76])
    defparam i5163_2_lut_3_lut_4_lut.init = 16'hfffd;
    LUT4 i14_2_lut (.A(SD0_CD_c), .B(TDnSHDN_c), .Z(n62)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i14_2_lut.init = 16'h8888;
    LUT4 i2_2_lut_2_lut_3_lut_4_lut (.A(signals_debounced_syn[2]), .B(extern_connected), 
         .C(n9538), .D(next_state[0]), .Z(n14_adj_1425)) /* synthesis lut_function=(!(A (C+!(D))+!A (B+(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam i2_2_lut_2_lut_3_lut_4_lut.init = 16'h0b00;
    LUT4 i3408_3_lut (.A(n3077), .B(n4570), .C(n4566), .Z(n4473)) /* synthesis lut_function=(!(A (B (C))+!A (B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam i3408_3_lut.init = 16'h3b3b;
    LUT4 i3364_2_lut (.A(n3078), .B(n4566), .Z(n4408)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam i3364_2_lut.init = 16'heeee;
    LUT4 i36_4_lut (.A(DIG5S3C26_out), .B(FlexMIOs33_out), .C(FPIO_FlexMIO27_out), 
         .D(DIG5S3C04_out), .Z(n84)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i36_4_lut.init = 16'h8000;
    LUT4 i22_2_lut (.A(DIG5S3C05_out), .B(DIG5S3C24_out), .Z(n70)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i22_2_lut.init = 16'h8888;
    LUT4 i5260_4_lut (.A(next_state[0]), .B(n9538), .C(next_state[1]), 
         .D(next_state[2]), .Z(clk_enable_183)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;
    defparam i5260_4_lut.init = 16'h2000;
    LUT4 i28_4_lut (.A(ANL_S3C_SLOTOK_c_2), .B(DIGS3C_SlotD_SlotOK_c_3), 
         .C(ANL_S3C_SLOTOK_c_3), .D(DIGS3C_SlotD_SlotOK_c_4), .Z(n76)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i28_4_lut.init = 16'h8000;
    LUT4 i6_2_lut (.A(SPI_S3C_nCS_USR_c), .B(ANL_S3C_P54_Legacy_c), .Z(n54)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(398[17] 413[39])
    defparam i6_2_lut.init = 16'h8888;
    LUT4 i5231_3_lut_3_lut_4_lut (.A(signals_debounced_syn[2]), .B(extern_connected), 
         .C(next_state[1]), .D(next_state[0]), .Z(n9113)) /* synthesis lut_function=(!(A (C (D)+!C !(D))+!A !(B (C+(D))+!B !(C (D)+!C !(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam i5231_3_lut_3_lut_4_lut.init = 16'h4ff0;
    LUT4 i3409_3_lut (.A(n3082), .B(n4570), .C(n4566), .Z(n4478)) /* synthesis lut_function=(!(A (B (C))+!A (B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam i3409_3_lut.init = 16'h3b3b;
    LUT4 i3402_4_lut (.A(next_state[3]), .B(externstop_falling), .C(signals_debounced_syn[3]), 
         .D(next_state_3__N_1092[2]), .Z(next_state_3__N_1088[3])) /* synthesis lut_function=(!(A (B+!((D)+!C))+!A (B+(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1391[17] 1401[12])
    defparam i3402_4_lut.init = 16'h2303;
    LUT4 i1_2_lut_rep_130 (.A(temp1[4]), .B(temp1[7]), .Z(n9550)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i1_2_lut_rep_130.init = 16'heeee;
    LUT4 i1_4_lut_adj_155 (.A(n9538), .B(n8986), .C(next_state[1]), .D(next_state_3__N_1092[2]), 
         .Z(FlexMIOs53_GPIO_PowerDown_N_1304)) /* synthesis lut_function=(A (B (C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam i1_4_lut_adj_155.init = 16'hc0c8;
    LUT4 i2_3_lut_4_lut_adj_156 (.A(n9552), .B(n9537), .C(n5585), .D(n6942), 
         .Z(n7086)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(742[58:76])
    defparam i2_3_lut_4_lut_adj_156.init = 16'he000;
    LUT4 i3403_4_lut (.A(next_state[2]), .B(externstop_falling), .C(signals_debounced_syn[3]), 
         .D(next_state_3__N_1092[2]), .Z(next_state_3__N_1088[2])) /* synthesis lut_function=(A (B+(C))+!A (B+!((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1391[17] 1401[12])
    defparam i3403_4_lut.init = 16'hecfc;
    LUT4 n7008_bdd_4_lut (.A(n7008), .B(next_state_3__N_1092[2]), .C(n51), 
         .D(next_state[3]), .Z(n9518)) /* synthesis lut_function=(A ((D)+!C)+!A !(B+!((D)+!C))) */ ;
    defparam n7008_bdd_4_lut.init = 16'hbb0b;
    LUT4 i5_3_lut_4_lut (.A(temp1[4]), .B(temp1[7]), .C(n10), .D(temp1[2]), 
         .Z(n18_adj_1403)) /* synthesis lut_function=(!(A+(B+((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i5_3_lut_4_lut.init = 16'h0010;
    LUT4 mux_1296_i9_4_lut_4_lut (.A(next_state[1]), .B(n4566), .C(n4570), 
         .D(n3084), .Z(n4480)) /* synthesis lut_function=(!(A (B+!(C (D)))+!A (B (C)+!B !((D)+!C)))) */ ;
    defparam mux_1296_i9_4_lut_4_lut.init = 16'h3505;
    LUT4 i1_2_lut_rep_120_3_lut_4_lut (.A(temp1[4]), .B(temp1[7]), .C(temp1[6]), 
         .D(temp1[5]), .Z(n9540)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i1_2_lut_rep_120_3_lut_4_lut.init = 16'hfffe;
    LUT4 i1_2_lut_rep_123_3_lut (.A(temp1[4]), .B(temp1[7]), .C(temp1[5]), 
         .Z(n9543)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i1_2_lut_rep_123_3_lut.init = 16'hfefe;
    LUT4 i1_4_lut_4_lut_adj_157 (.A(n15), .B(n6946), .C(n_temp1_7__N_368), 
         .D(n_temp1_7__N_369), .Z(n4)) /* synthesis lut_function=(A+!(B (D)+!B (C+(D)))) */ ;
    defparam i1_4_lut_4_lut_adj_157.init = 16'haaef;
    LUT4 i1_2_lut_3_lut_adj_158 (.A(next_state_3__N_1092[2]), .B(signals_debounced_syn[3]), 
         .C(externstop_falling), .Z(n5749)) /* synthesis lut_function=(!(A+((C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1391[17] 1401[12])
    defparam i1_2_lut_3_lut_adj_158.init = 16'h0404;
    LUT4 temp1_7__I_0_780_i9_2_lut_rep_133 (.A(temp1[0]), .B(temp1[1]), 
         .Z(n9553)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(746[34:52])
    defparam temp1_7__I_0_780_i9_2_lut_rep_133.init = 16'hbbbb;
    LUT4 i2367_2_lut (.A(clk_enable_188), .B(n4572), .Z(n6030)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1323[2] 1501[9])
    defparam i2367_2_lut.init = 16'h8888;
    LUT4 i74_4_lut_4_lut (.A(next_state_3__N_1092[2]), .B(next_state[0]), 
         .C(n7081), .D(next_state[2]), .Z(n51)) /* synthesis lut_function=(A (B (C+!(D))+!B !(D))+!A (B (C (D))+!B !(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1324[9] 1500[18])
    defparam i74_4_lut_4_lut.init = 16'hc0bb;
    LUT4 i3322_2_lut_3_lut_4_lut (.A(n9540), .B(n9549), .C(clk_enable_5), 
         .D(temp1[3]), .Z(n6975)) /* synthesis lut_function=(A (C)+!A (B (C)+!B (C (D)))) */ ;
    defparam i3322_2_lut_3_lut_4_lut.init = 16'hf0e0;
    LUT4 i2_3_lut_4_lut_adj_159 (.A(temp1[4]), .B(temp1[7]), .C(temp1[6]), 
         .D(temp1[5]), .Z(n14)) /* synthesis lut_function=(A+(B+!(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i2_3_lut_4_lut_adj_159.init = 16'hefff;
    PFUMX i5395 (.BLUT(n9470), .ALUT(n9469), .C0(next_state[1]), .Z(n9471));
    PFUMX i5381 (.BLUT(n9417), .ALUT(n9415), .C0(next_state[3]), .Z(clk_enable_136));
    LUT4 i31_4_lut (.A(n_temp1_7__N_353), .B(n_temp1_7__N_352), .C(clk_enable_5), 
         .D(n15_adj_1402), .Z(n8566)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i31_4_lut.init = 16'hfaca;
    LUT4 i11_4_lut (.A(n_temp1_7__N_355), .B(n_temp1_7__N_354), .C(clk_enable_5), 
         .D(n_state_7__N_1040[4]), .Z(n8880)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;
    defparam i11_4_lut.init = 16'h0aca;
    LUT4 i1_4_lut_adj_160 (.A(n_state_7__N_1040[4]), .B(n_temp1_7__N_367), 
         .C(n5), .D(n18), .Z(n15_adj_1402)) /* synthesis lut_function=(!(A+!(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_160.init = 16'h5554;
    LUT4 i1_2_lut_rep_134 (.A(signals_debounced_syn[4]), .B(externstop_falling), 
         .Z(n9554)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam i1_2_lut_rep_134.init = 16'h2222;
    LUT4 i1_2_lut_adj_161 (.A(wb_dat_o[4]), .B(n_temp1_7__N_363), .Z(n5)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_2_lut_adj_161.init = 16'h4444;
    LUT4 i2995_3_lut (.A(next_state[3]), .B(next_state[2]), .C(n9572), 
         .Z(Carrier_PG_1V8_N_1390)) /* synthesis lut_function=(A (B)+!A !(B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(137[12:22])
    defparam i2995_3_lut.init = 16'h9898;
    LUT4 i1_2_lut_rep_131 (.A(temp1[3]), .B(temp1[2]), .Z(n9551)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(559[6] 565[15])
    defparam i1_2_lut_rep_131.init = 16'hdddd;
    LUT4 i2292_2_lut_3_lut (.A(signals_debounced_syn[4]), .B(externstop_falling), 
         .C(next_state_3__N_1092[2]), .Z(n5941)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;
    defparam i2292_2_lut_3_lut.init = 16'h2020;
    LUT4 i1_4_lut_adj_162 (.A(wb_dat_o[2]), .B(n9004), .C(n9035), .D(n9530), 
         .Z(n18)) /* synthesis lut_function=(!(A+!(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_162.init = 16'h5554;
    LUT4 mux_1296_i20_4_lut_4_lut (.A(next_state[1]), .B(n4566), .C(n4570), 
         .D(n3073), .Z(n4469)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_1296_i20_4_lut_4_lut.init = 16'hf5c5;
    LUT4 mux_1296_i14_4_lut_4_lut (.A(next_state[1]), .B(n4566), .C(n4570), 
         .D(n3079), .Z(n4475)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_1296_i14_4_lut_4_lut.init = 16'hf5c5;
    LUT4 i2334_2_lut_3_lut (.A(signals_debounced_syn[4]), .B(externstop_falling), 
         .C(next_state_3__N_1092[2]), .Z(n5997)) /* synthesis lut_function=(!(A (B (C))+!A (C))) */ ;
    defparam i2334_2_lut_3_lut.init = 16'h2f2f;
    LUT4 i5172_2_lut (.A(next_state[3]), .B(next_state[1]), .Z(n9054)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i5172_2_lut.init = 16'heeee;
    LUT4 i3_4_lut_rep_114_4_lut (.A(next_state[1]), .B(n9555), .C(n8986), 
         .D(n9538), .Z(n9534)) /* synthesis lut_function=(!(A+!(B (C (D))))) */ ;
    defparam i3_4_lut_rep_114_4_lut.init = 16'h4000;
    LUT4 i3_4_lut_4_lut (.A(next_state[1]), .B(n9546), .C(next_state[0]), 
         .D(n5941), .Z(n5959)) /* synthesis lut_function=(!(A+((C+!(D))+!B))) */ ;
    defparam i3_4_lut_4_lut.init = 16'h0400;
    LUT4 mux_1296_i12_4_lut_4_lut (.A(next_state[1]), .B(n4566), .C(n4570), 
         .D(n3081), .Z(n4477)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_1296_i12_4_lut_4_lut.init = 16'hf5c5;
    LUT4 mux_1296_i18_4_lut_4_lut (.A(next_state[1]), .B(n4566), .C(n4570), 
         .D(n3075), .Z(n4471)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_1296_i18_4_lut_4_lut.init = 16'hf5c5;
    LUT4 i5291_2_lut_rep_135 (.A(next_state_3__N_1092[2]), .B(next_state[0]), 
         .Z(n9555)) /* synthesis lut_function=(!(A+(B))) */ ;
    defparam i5291_2_lut_rep_135.init = 16'h1111;
    LUT4 FPIO_isoCtrlRSTn_N_1294_bdd_4_lut_5331 (.A(next_state_3__N_1088[3]), 
         .B(next_state[1]), .C(next_state[0]), .D(next_state_3__N_1092[2]), 
         .Z(n9320)) /* synthesis lut_function=(A (B+(C+!(D)))+!A (B (C)+!B !(C+(D)))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1294_bdd_4_lut_5331.init = 16'he8eb;
    LUT4 i1_2_lut_adj_163 (.A(n15), .B(n_temp1_7__N_369), .Z(n9004)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1295[5] 1303[15])
    defparam i1_2_lut_adj_163.init = 16'h8888;
    LUT4 FPIO_isoCtrlRSTn_N_1294_bdd_3_lut_5330 (.A(next_state_3__N_1088[3]), 
         .B(next_state[1]), .C(next_state[0]), .Z(n9319)) /* synthesis lut_function=(!((B (C)+!B !(C))+!A)) */ ;
    defparam FPIO_isoCtrlRSTn_N_1294_bdd_3_lut_5330.init = 16'h2828;
    LUT4 i51_4_lut (.A(n9538), .B(n25), .C(next_state[3]), .D(next_state[1]), 
         .Z(n31)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;
    defparam i51_4_lut.init = 16'hcac0;
    LUT4 i5218_4_lut (.A(n14), .B(n9552), .C(n9044), .D(n9553), .Z(n_state_7__N_984[3])) /* synthesis lut_function=(A+(B (C)+!B (C (D)))) */ ;
    defparam i5218_4_lut.init = 16'hfaea;
    LUT4 i52_4_lut_4_lut (.A(next_state_3__N_1092[2]), .B(next_state[0]), 
         .C(next_state[2]), .D(n9538), .Z(n28)) /* synthesis lut_function=(!(A (C)+!A (B+!(C (D))))) */ ;
    defparam i52_4_lut_4_lut.init = 16'h1a0a;
    LUT4 FPIO_isoCtrlRSTn_N_1294_bdd_4_lut_5384_4_lut (.A(next_state_3__N_1092[2]), 
         .B(next_state[0]), .C(next_state[1]), .D(next_state[2]), .Z(n9416)) /* synthesis lut_function=(!(A (B (C (D)))+!A (B (C (D))+!B !(C+!(D))))) */ ;
    defparam FPIO_isoCtrlRSTn_N_1294_bdd_4_lut_5384_4_lut.init = 16'h3eff;
    LUT4 i7_4_lut_adj_164 (.A(dat_count[0]), .B(n14_adj_1441), .C(n10_adj_1440), 
         .D(dat_count[6]), .Z(n15)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1262[13:35])
    defparam i7_4_lut_adj_164.init = 16'hfffe;
    LUT4 temp1_7__I_0_776_i10_2_lut_rep_132 (.A(temp1[2]), .B(temp1[3]), 
         .Z(n9552)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(743[34:52])
    defparam temp1_7__I_0_776_i10_2_lut_rep_132.init = 16'hdddd;
    LUT4 i1_2_lut_3_lut_4_lut_adj_165 (.A(n9540), .B(n9549), .C(dat_rdy_N_1326), 
         .D(temp1[3]), .Z(n14_adj_1430)) /* synthesis lut_function=(A+(B+((D)+!C))) */ ;
    defparam i1_2_lut_3_lut_4_lut_adj_165.init = 16'hffef;
    LUT4 i1_4_lut_adj_166 (.A(dat_rdy_N_1326), .B(dat_count[4]), .C(n2015), 
         .D(n6975), .Z(n15_adj_1408)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_166.init = 16'ha088;
    LUT4 n5749_bdd_3_lut_5368_4_lut (.A(next_state_3__N_1092[2]), .B(next_state[0]), 
         .C(next_state[2]), .D(next_state[1]), .Z(n9390)) /* synthesis lut_function=(!(A+(B+(C+(D))))) */ ;
    defparam n5749_bdd_3_lut_5368_4_lut.init = 16'h0001;
    PFUMX i5365 (.BLUT(n9391), .ALUT(n9390), .C0(next_state[3]), .Z(n4566));
    LUT4 i1_4_lut_adj_167 (.A(wb_dat_o[0]), .B(temp1[0]), .C(n9542), .D(n9068), 
         .Z(n_temp1[0])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_167.init = 16'ha0ec;
    LUT4 n9673_bdd_3_lut_4_lut (.A(next_state[0]), .B(next_state[1]), .C(next_state[2]), 
         .D(n9672), .Z(n9674)) /* synthesis lut_function=(A (B ((D)+!C)+!B (C (D)))+!A (C (D))) */ ;
    defparam n9673_bdd_3_lut_4_lut.init = 16'hf808;
    LUT4 next_state_3__I_0_749_Mux_0_i10_4_lut_4_lut (.A(next_state_3__N_1092[2]), 
         .B(next_state[0]), .C(n5997), .D(next_state[1]), .Z(n10_adj_1435)) /* synthesis lut_function=(!(A (B (D)+!B (C+(D)))+!A (B (D)+!B !((D)+!C)))) */ ;
    defparam next_state_3__I_0_749_Mux_0_i10_4_lut_4_lut.init = 16'h11cf;
    LUT4 i6_4_lut_adj_168 (.A(dat_count[3]), .B(dat_count[1]), .C(dat_count[5]), 
         .D(dat_count[7]), .Z(n14_adj_1441)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1262[13:35])
    defparam i6_4_lut_adj_168.init = 16'hfffe;
    LUT4 i2_2_lut_adj_169 (.A(dat_count[2]), .B(dat_count[4]), .Z(n10_adj_1440)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1262[13:35])
    defparam i2_2_lut_adj_169.init = 16'heeee;
    LUT4 i24_4_lut_rep_118 (.A(n43), .B(n48_adj_1427), .C(n37), .D(n38), 
         .Z(n9538)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i24_4_lut_rep_118.init = 16'hfffe;
    LUT4 i3293_4_lut (.A(n9548), .B(n5585), .C(n9553), .D(n9540), .Z(n6946)) /* synthesis lut_function=(A (B)+!A (B (C+(D)))) */ ;
    defparam i3293_4_lut.init = 16'hccc8;
    LUT4 i1_2_lut_adj_170 (.A(temp2[0]), .B(dat_rdy_del), .Z(n4_adj_1418)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i1_2_lut_adj_170.init = 16'h4444;
    LUT4 n4_bdd_3_lut_3_lut (.A(next_state[2]), .B(next_state[0]), .C(next_state[1]), 
         .Z(n9482)) /* synthesis lut_function=(A (B (C))+!A (C)) */ ;
    defparam n4_bdd_3_lut_3_lut.init = 16'hd0d0;
    LUT4 i1_2_lut_rep_126_2_lut (.A(next_state[2]), .B(next_state[3]), .Z(n9546)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i1_2_lut_rep_126_2_lut.init = 16'h4444;
    LUT4 i1_2_lut_adj_171 (.A(next_state_3__N_1092[2]), .B(signals_debounced_syn[3]), 
         .Z(n8992)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1391[17] 1401[12])
    defparam i1_2_lut_adj_171.init = 16'h8888;
    LUT4 i1_4_lut_4_lut_adj_172 (.A(next_state[2]), .B(next_state[1]), .C(n14_adj_1425), 
         .D(n9563), .Z(n18_adj_1426)) /* synthesis lut_function=(!(A+!(B (C)+!B (D)))) */ ;
    defparam i1_4_lut_4_lut_adj_172.init = 16'h5140;
    LUT4 i71_3_lut_4_lut_3_lut (.A(temp1[2]), .B(temp1[3]), .C(temp1[1]), 
         .Z(n68)) /* synthesis lut_function=(A (B+(C))+!A !(B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(743[34:52])
    defparam i71_3_lut_4_lut_3_lut.init = 16'hbdbd;
    PFUMX i5482 (.BLUT(n9674), .ALUT(n9669), .C0(next_state[3]), .Z(next_state_3__N_69[2]));
    LUT4 i2_4_lut_adj_173 (.A(dat_count[7]), .B(n12_adj_1400), .C(n17), 
         .D(n15_adj_1398), .Z(n_dat_count[7])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i2_4_lut_adj_173.init = 16'hffec;
    LUT4 i1_4_lut_adj_174 (.A(n_temp1_7__N_365), .B(dat_count[7]), .C(n2012), 
         .D(n9531), .Z(n12_adj_1400)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_174.init = 16'ha088;
    LUT4 i1_4_lut_adj_175 (.A(dat_rdy_N_1326), .B(n2012), .C(dat_count[7]), 
         .D(n6975), .Z(n15_adj_1398)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_175.init = 16'h88a0;
    LUT4 next_state_3__bdd_4_lut_5377_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), 
         .C(next_state[0]), .D(next_state_3__N_1092[2]), .Z(n9318)) /* synthesis lut_function=(!(A+(B (C+(D))+!B !(C)))) */ ;
    defparam next_state_3__bdd_4_lut_5377_4_lut_4_lut.init = 16'h1014;
    LUT4 m1_lut (.Z(n9834)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    LUT4 n7008_bdd_4_lut_5423_4_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(n51), .D(n9538), .Z(n9517)) /* synthesis lut_function=(A (B+!(C))+!A (B (D)+!B !(C))) */ ;
    defparam n7008_bdd_4_lut_5423_4_lut.init = 16'hcf8b;
    LUT4 i2_4_lut_adj_176 (.A(dat_count[6]), .B(n12_adj_1405), .C(n17), 
         .D(n15_adj_1404), .Z(n_dat_count[6])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i2_4_lut_adj_176.init = 16'hffec;
    LUT4 i1_4_lut_adj_177 (.A(n_temp1_7__N_365), .B(dat_count[6]), .C(n2013), 
         .D(n9531), .Z(n12_adj_1405)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_177.init = 16'ha088;
    LUT4 FPIO_isoCtrlRSTn_N_1294_bdd_1_lut_1_lut (.A(next_state[2]), .Z(n9514)) /* synthesis lut_function=(A) */ ;
    defparam FPIO_isoCtrlRSTn_N_1294_bdd_1_lut_1_lut.init = 16'haaaa;
    LUT4 i1_4_lut_adj_178 (.A(dat_rdy_N_1326), .B(n2013), .C(dat_count[6]), 
         .D(n6975), .Z(n15_adj_1404)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_178.init = 16'h88a0;
    LUT4 i5271_4_lut_4_lut (.A(next_state[2]), .B(n9471), .C(n8941), .D(n9534), 
         .Z(clk_enable_137)) /* synthesis lut_function=(!(A (C+(D))+!A (B+(C+(D))))) */ ;
    defparam i5271_4_lut_4_lut.init = 16'h000b;
    LUT4 i5286_2_lut_3_lut (.A(next_state_3__N_1092[2]), .B(signals_debounced_syn[3]), 
         .C(externstop_falling), .Z(n7081)) /* synthesis lut_function=(!(A (C)+!A (B+(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(1391[17] 1401[12])
    defparam i5286_2_lut_3_lut.init = 16'h0b0b;
    LUT4 i1_3_lut_4_lut_4_lut_adj_179 (.A(next_state[2]), .B(n9563), .C(next_state[1]), 
         .D(next_state[3]), .Z(n8941)) /* synthesis lut_function=(!(A+!(B (C (D))))) */ ;
    defparam i1_3_lut_4_lut_4_lut_adj_179.init = 16'h4000;
    PFUMX i5480 (.BLUT(n9671), .ALUT(n9670), .C0(next_state[0]), .Z(n9672));
    LUT4 i1_4_lut_4_lut_adj_180 (.A(next_state[2]), .B(n9575), .C(n29), 
         .D(next_state[3]), .Z(n4570)) /* synthesis lut_function=(!(A ((D)+!B)+!A !(B (C+!(D))+!B (C)))) */ ;
    defparam i1_4_lut_4_lut_adj_180.init = 16'h50dc;
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    LUT4 next_state_3__I_0_749_Mux_0_i15_4_lut_4_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(n10_adj_1435), .D(n9112), .Z(next_state_3__N_69[0])) /* synthesis lut_function=(!(A (B+!(D))+!A !(B (C)+!B (D)))) */ ;
    defparam next_state_3__I_0_749_Mux_0_i15_4_lut_4_lut.init = 16'h7340;
    LUT4 i5280_4_lut_4_lut (.A(next_state[2]), .B(n31), .C(n9054), .D(n28), 
         .Z(clk_enable_26)) /* synthesis lut_function=(A (C+!(D))+!A !(B+!(C+!(D)))) */ ;
    defparam i5280_4_lut_4_lut.init = 16'hb0bb;
    LUT4 i2_4_lut_adj_181 (.A(dat_count[5]), .B(n12_adj_1413), .C(n17), 
         .D(n15_adj_1412), .Z(n_dat_count[5])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i2_4_lut_adj_181.init = 16'hffec;
    LUT4 next_state_3__I_0_749_Mux_1_i15_4_lut_4_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(n9283), .D(n9115), .Z(next_state_3__N_69[1])) /* synthesis lut_function=(!(A (B+!(D))+!A !(B (C)+!B (D)))) */ ;
    defparam next_state_3__I_0_749_Mux_1_i15_4_lut_4_lut.init = 16'h7340;
    LUT4 i1_4_lut_adj_182 (.A(n_temp1_7__N_365), .B(dat_count[5]), .C(n2014), 
         .D(n9531), .Z(n12_adj_1413)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_182.init = 16'ha088;
    LUT4 i1_4_lut_adj_183 (.A(dat_rdy_N_1326), .B(n2014), .C(dat_count[5]), 
         .D(n6975), .Z(n15_adj_1412)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i1_4_lut_adj_183.init = 16'h88a0;
    LUT4 i2_4_lut_adj_184 (.A(dat_count[4]), .B(n12_adj_1409), .C(n17), 
         .D(n15_adj_1408), .Z(n_dat_count[4])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i2_4_lut_adj_184.init = 16'hffec;
    LUT4 i2_4_lut_adj_185 (.A(reg_rdy_N_1322), .B(n8376), .C(n9535), .D(n5290), 
         .Z(n8396)) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(824[6] 1316[10])
    defparam i2_4_lut_adj_185.init = 16'hffec;
    PFUMX i5436 (.BLUT(n9576), .ALUT(n9577), .C0(next_state[1]), .Z(clk_enable_16));
    LUT4 pushed_1__I_0_1_lut (.A(pushed[1]), .Z(pushed_1__N_302)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(460[17] 464[24])
    defparam pushed_1__I_0_1_lut.init = 16'h5555;
    PFUMX i5434 (.BLUT(n9573), .ALUT(n9574), .C0(n5749), .Z(n9575));
    LUT4 i2_3_lut_4_lut_4_lut (.A(n15), .B(n6946), .C(wb_dat_o[2]), .D(n_temp1_7__N_368), 
         .Z(n8964)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;
    defparam i2_3_lut_4_lut_4_lut.init = 16'h2000;
    PFUMX i5432 (.BLUT(n9570), .ALUT(n9571), .C0(next_state[1]), .Z(n9572));
    LUT4 i1_2_lut_adj_186 (.A(signals_debounced_syn[2]), .B(externstop_last), 
         .Z(externstop_falling_N_1314)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(443[9] 469[10])
    defparam i1_2_lut_adj_186.init = 16'h4444;
    
endmodule
//
// Verilog Description of module efb_vhdl
//

module efb_vhdl (clk, n9561, wb_stb_i, wb_we_i, GND_net, \wb_adr_i[2] , 
            \wb_adr_i[1] , \wb_adr_i[0] , wb_dat_i, \wb_dat_o[7] , \n_state_7__N_1040[4] , 
            \wb_dat_o[5] , \wb_dat_o[4] , \wb_dat_o[3] , \wb_dat_o[2] , 
            \wb_dat_o[1] , \wb_dat_o[0] , wb_ack_o, i2c1_sdaoen, i2c1_sdao, 
            i2c1_scloen, i2c1_sclo, i2c1_sdai, i2c1_scli, VCC_net) /* synthesis NGD_DRC_MASK=1 */ ;
    input clk;
    input n9561;
    input wb_stb_i;
    input wb_we_i;
    input GND_net;
    input \wb_adr_i[2] ;
    input \wb_adr_i[1] ;
    input \wb_adr_i[0] ;
    input [7:0]wb_dat_i;
    output \wb_dat_o[7] ;
    output \n_state_7__N_1040[4] ;
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
    
    wire clk /* synthesis SET_AS_NETWORK=clk, is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(129[9:12])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(40[12:21])
    
    EFB EFBInst_0 (.WBCLKI(clk), .WBRSTI(n9561), .WBCYCI(wb_stb_i), .WBSTBI(wb_stb_i), 
        .WBWEI(wb_we_i), .WBADRI0(\wb_adr_i[0] ), .WBADRI1(\wb_adr_i[1] ), 
        .WBADRI2(\wb_adr_i[2] ), .WBADRI3(GND_net), .WBADRI4(GND_net), 
        .WBADRI5(GND_net), .WBADRI6(wb_stb_i), .WBADRI7(GND_net), .WBDATI0(wb_dat_i[0]), 
        .WBDATI1(wb_dat_i[1]), .WBDATI2(wb_dat_i[2]), .WBDATI3(wb_dat_i[3]), 
        .WBDATI4(wb_dat_i[4]), .WBDATI5(wb_dat_i[5]), .WBDATI6(wb_dat_i[6]), 
        .WBDATI7(wb_dat_i[7]), .I2C1SCLI(i2c1_scli), .I2C1SDAI(i2c1_sdai), 
        .I2C2SCLI(GND_net), .I2C2SDAI(GND_net), .SPISCKI(GND_net), .SPIMISOI(GND_net), 
        .SPIMOSII(GND_net), .SPISCSN(GND_net), .TCCLKI(GND_net), .TCRSTN(GND_net), 
        .TCIC(GND_net), .UFMSN(VCC_net), .PLL0DATI0(GND_net), .PLL0DATI1(GND_net), 
        .PLL0DATI2(GND_net), .PLL0DATI3(GND_net), .PLL0DATI4(GND_net), 
        .PLL0DATI5(GND_net), .PLL0DATI6(GND_net), .PLL0DATI7(GND_net), 
        .PLL0ACKI(GND_net), .PLL1DATI0(GND_net), .PLL1DATI1(GND_net), 
        .PLL1DATI2(GND_net), .PLL1DATI3(GND_net), .PLL1DATI4(GND_net), 
        .PLL1DATI5(GND_net), .PLL1DATI6(GND_net), .PLL1DATI7(GND_net), 
        .PLL1ACKI(GND_net), .WBDATO0(\wb_dat_o[0] ), .WBDATO1(\wb_dat_o[1] ), 
        .WBDATO2(\wb_dat_o[2] ), .WBDATO3(\wb_dat_o[3] ), .WBDATO4(\wb_dat_o[4] ), 
        .WBDATO5(\wb_dat_o[5] ), .WBDATO6(\n_state_7__N_1040[4] ), .WBDATO7(\wb_dat_o[7] ), 
        .WBACKO(wb_ack_o), .I2C1SCLO(i2c1_sclo), .I2C1SCLOEN(i2c1_scloen), 
        .I2C1SDAO(i2c1_sdao), .I2C1SDAOEN(i2c1_sdaoen)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=358, LSE_RLINE=358 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/power_on_debounce.vhd(358[7:15])
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
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

