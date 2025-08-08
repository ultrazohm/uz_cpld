// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Thu Jul 03 15:34:50 2025
//
// Verilog Description of module I2CRev03
//

module I2CRev03 (X13_E2C_M62, X13_FP2x_ESt, X13_C2E_M61, X13_C2E_M60, 
            X13_E2C_M59, X13_E2C_M58, SCL, SDA, X13_E2C_M55, X13_C2E_M57, 
            X13_E2C_M54, X13_C2E_M56, X13_C2E_M53, X13_C2E_M52, Xc1_SPICLK, 
            Xc1_MOSI, Xc1_CS_A1, Xc1_CS_A2, Xc1_CS_A3, S3CsI2C_SDA, 
            S3CsI2C_SCL, Xc1_CollFlt, Xc1_PSANL, RTC_FOUT, S2C_S2, 
            S2C_S3, FP_UsrLED, FP_UsrSW1, FP_UsrSW2, FP_UsrSW3, FP_UsrSW4, 
            FP_SysLEDs, PG_VIN, PPn_VIN, TDnSHDN, TDnFFnFS, TDnALERT, 
            SPI0_SelnSYSUSRnCS, SPI0_nCS_USR, SPI0_nCS_SYS, SPI0_SCLK, 
            SPI0_MISO, SPI0_MOSI, DIG_00_Ch5, DIG_01_Ch5, DIG_02_Ch5, 
            DIG_03_Ch5, DIG_04_Ch5, DIG_05_Ch5, DIG_24_Ch5, DIG_25_Ch5, 
            DIG_26_Ch5, DIG_27_Ch5, DIG_28_Ch5, DIG_29_Ch5, S2C_FlexIO_IO0, 
            S2C_FlexIO_IO1, S2C_FlexIO_IO2, S2C_FlexIO_IO3, S2C_FlexIO_IO4, 
            S2C_FlexIO_IO5, S2C_FlexIO_IO6, S2C_FlexIO_IO7, IRQ);   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(8[8:16])
    output X13_E2C_M62;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(26[3:14])
    input X13_FP2x_ESt;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(27[3:15])
    input X13_C2E_M61;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(28[3:14])
    input X13_C2E_M60;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(29[3:14])
    output X13_E2C_M59;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(30[3:14])
    output X13_E2C_M58;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(31[3:14])
    inout SCL /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(33[3:6])
    inout SDA /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(34[3:6])
    output X13_E2C_M55;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(36[3:14])
    input X13_C2E_M57;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(37[3:14])
    output X13_E2C_M54;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(38[3:14])
    input X13_C2E_M56;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(39[3:14])
    input X13_C2E_M53;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(40[3:14])
    input X13_C2E_M52;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(43[3:14])
    input Xc1_SPICLK;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(44[3:13])
    input Xc1_MOSI;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(45[3:11])
    input Xc1_CS_A1;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(46[3:12])
    input Xc1_CS_A2;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(47[3:12])
    input Xc1_CS_A3;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(48[3:12])
    input S3CsI2C_SDA /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(50[3:14])
    input S3CsI2C_SCL /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(51[3:14])
    output Xc1_CollFlt;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(52[3:14])
    input Xc1_PSANL;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(53[3:12])
    input RTC_FOUT;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(54[3:11])
    input S2C_S2;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(56[3:9])
    input S2C_S3;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(57[3:9])
    output [4:1]FP_UsrLED;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(60[3:12])
    input FP_UsrSW1;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(60[55:64])
    input FP_UsrSW2;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(61[3:12])
    input FP_UsrSW3;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(62[3:12])
    input FP_UsrSW4;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(63[3:12])
    output FP_SysLEDs;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(64[3:13])
    input PG_VIN;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(65[3:9])
    input PPn_VIN;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(66[3:10])
    input TDnSHDN;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(67[3:10])
    input TDnFFnFS /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(68[3:11])
    input TDnALERT;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(69[3:11])
    output SPI0_SelnSYSUSRnCS;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(70[3:21])
    input SPI0_nCS_USR;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(71[3:15])
    input SPI0_nCS_SYS;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(72[3:15])
    inout SPI0_SCLK /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(73[3:12])
    inout SPI0_MISO /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(74[3:12])
    inout SPI0_MOSI /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(75[3:12])
    output DIG_00_Ch5 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(78[3:13])
    output DIG_01_Ch5 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(79[3:13])
    output DIG_02_Ch5 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(80[3:13])
    output DIG_03_Ch5 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(81[3:13])
    output DIG_04_Ch5 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(82[3:13])
    output DIG_05_Ch5 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(83[3:13])
    output DIG_24_Ch5 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(86[3:13])
    output DIG_25_Ch5 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(87[3:13])
    output DIG_26_Ch5 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(88[3:13])
    output DIG_27_Ch5 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(89[3:13])
    output DIG_28_Ch5 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(90[3:13])
    output DIG_29_Ch5 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(91[3:13])
    output S2C_FlexIO_IO0 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(95[3:17])
    output S2C_FlexIO_IO1 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(96[3:17])
    output S2C_FlexIO_IO2 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(97[3:17])
    output S2C_FlexIO_IO3 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(98[3:17])
    output S2C_FlexIO_IO4 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(99[3:17])
    output S2C_FlexIO_IO5 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(100[3:17])
    output S2C_FlexIO_IO6 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(101[3:17])
    output S2C_FlexIO_IO7 /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(102[3:17])
    input [3:0]IRQ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(105[3:6])
    
    wire clk /* synthesis SET_AS_NETWORK=clk, is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(113[9:12])
    wire dummy_signal /* synthesis noclip="on" */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(152[9:21])
    wire spi_clk_i /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/ipexpress/xo2/efb_vhdl.vhd(46[12:21])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/ipexpress/xo2/efb_vhdl.vhd(53[12:21])
    
    wire GND_net, VCC_net, X13_E2C_M62_c_0, X13_FP2x_ESt_c, X13_C2E_M61_c, 
        X13_C2E_M60_c, X13_E2C_M59_c_1, X13_E2C_M58_c_2, X13_C2E_M57_c, 
        X13_C2E_M56_c, X13_C2E_M53_c, X13_C2E_M52_c, Xc1_SPICLK_c, Xc1_MOSI_c, 
        Xc1_CS_A1_c, Xc1_CS_A2_c, Xc1_CS_A3_c, Xc1_PSANL_c, RTC_FOUT_c, 
        S2C_S2_c, S2C_S3_c, FP_UsrLED_c_4, FP_UsrLED_c_3, FP_UsrLED_c_2, 
        FP_UsrLED_c_1, FP_UsrSW1_c, FP_UsrSW2_c, FP_UsrSW3_c, FP_UsrSW4_c, 
        FP_SysLEDs_c_3, PG_VIN_c, PPn_VIN_c, TDnSHDN_c, TDnFFnFS_c, 
        TDnALERT_c, SPI0_nCS_USR_c;
    wire [24:0]resetcounter;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(115[9:21])
    
    wire resetnefb;
    wire [7:0]wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(250[8:16])
    wire [7:0]wb_adr_i;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(253[8:16])
    
    wire n5248, wb_we_i;
    wire [7:0]wb_dat_o;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(255[8:16])
    
    wire wb_ack_o;
    wire [7:0]data0;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(267[8:13])
    wire [7:0]temp1;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[14:19])
    
    wire n3699, n5271;
    wire [7:0]temp2;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[20:25])
    wire [7:0]temp3;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[26:31])
    wire [7:0]n_temp1;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(269[16:23])
    
    wire n3446, n3442, n4878, n3436, n3434, i2c1_sclo, i2c1_scloen, 
        i2c1_sdao, i2c1_sdaoen, reg_rdy, dat_rdy, dat_rdy_del;
    wire [7:0]n_dat_count;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(277[8:19])
    wire [7:0]dat_count;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(277[22:31])
    wire [7:0]GPI_DAT;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(278[8:15])
    wire [7:0]n_wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(289[8:18])
    wire [7:0]n_wb_adr_i;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(291[8:18])
    
    wire n_wb_we_i, n14, n5041, n4891, n62, n68, n50, n48, n18, 
        n4890, resetcounter_24__N_603, n48_adj_651, n4880, n5480, 
        reg_rdy_N_609, reg_rdy_N_607, dat_rdy_N_613, dat_rdy_N_611, 
        spi_miso_oe, spi_mosi_o, spi_mosi_oe;
    wire [7:0]data0_7__N_436;
    
    wire n9, n3724, n5479, n5197, n14_adj_652, n55, n5478, n15, 
        n5477, spi_miso_i, spi_mosi_i, spi_clk_o, n4231, n20, n6, 
        n5476, clk_enable_17, n10, n5474, n5472, n3432, n5427, 
        n2, n5247, n3430, n4884, n2954, n5471, n15_adj_653, n4, 
        n6_adj_654, n4312, n5470, n17, n4883, n30, n3424, n5458, 
        n36, n15_adj_655, n12, n6_adj_656, n5469, n4_adj_657, n5468, 
        n3704, n5227, n4942, n15_adj_658, n5223, n15_adj_659, n12_adj_660;
    wire [7:0]n_state_7__N_522;
    
    wire n5467, n12_adj_661, n3418, n5466, n2891, n6_adj_662, n10_adj_663, 
        n21, n1962, n1963, n1964, n1965, n1966, n1967, n1968, 
        n1969, n4889, n5267, n3202, n4932, n14_adj_664, n3, n5039, 
        n4_adj_665, n32, n31, n33;
    wire [7:0]n_dat_count_7__N_154;
    
    wire n4882, n5465;
    wire [7:0]n_state_7__N_578;
    
    wire n5464, n4888, n5394, n5217, n5393, n3450, n3452, n15_adj_666, 
        clk_enable_16, n24, n4887, n12_adj_667, n4886, n3698, n4245, 
        n5392, clk_enable_8, n22, n_temp1_7__N_82, n_temp1_7__N_83, 
        n_temp1_7__N_84, n_temp1_7__N_85, n_temp1_7__N_86, n_temp1_7__N_87, 
        n_temp1_7__N_88, n_temp1_7__N_89, n_temp1_7__N_90, n_temp1_7__N_91, 
        spi_clk_oe, n_temp1_7__N_93, n_temp1_7__N_94, spi_miso_o, n_temp1_7__N_96, 
        n_temp1_7__N_97, n_temp1_7__N_98, n_temp1_7__N_99, n_temp1_7__N_100, 
        n5282, i2c1_sdai, n15_adj_668, n12_adj_669, n29, n5463, 
        n10_adj_670, n5462, n5243, n5033, n18_adj_671, n19, n20_adj_672, 
        n21_adj_673, n22_adj_674, n23, n24_adj_675, n25, n15_adj_676, 
        n12_adj_677, n5, n106, n107, n108, n109, n110, n111, 
        n112, n113, n114, n115, n116, n117, n118, n119, n120, 
        n121, n122, n123, n124, n125, n126, n127, n128, n129, 
        n130, n6_adj_678, n6_adj_679, n15_adj_680, n12_adj_681, n4_adj_682, 
        n4879, n15_adj_683, n4_adj_684, n4881, n5125, n4989, n4893, 
        n4885, n4290, n5482, n4892, n5241, n6_adj_685, n4_adj_686, 
        n5481, n5288, n10_adj_687, n5222, n5206, n14_adj_688, n28, 
        n26, n5461, n8, n5460, n9_adj_689, n5220, n5189, n5459;
    
    VHI i2 (.Z(VCC_net));
    efb_vhdl dut (.clk(clk), .n5476(n5476), .\wb_adr_i[6] (wb_adr_i[6]), 
            .wb_we_i(wb_we_i), .GND_net(GND_net), .\wb_adr_i[2] (wb_adr_i[2]), 
            .\wb_adr_i[1] (wb_adr_i[1]), .\wb_adr_i[0] (wb_adr_i[0]), .wb_dat_i({wb_dat_i}), 
            .\wb_dat_o[7] (wb_dat_o[7]), .\n_state_7__N_578[4] (n_state_7__N_578[4]), 
            .\wb_dat_o[5] (wb_dat_o[5]), .\wb_dat_o[4] (wb_dat_o[4]), .\wb_dat_o[3] (wb_dat_o[3]), 
            .\wb_dat_o[2] (wb_dat_o[2]), .\wb_dat_o[1] (wb_dat_o[1]), .\wb_dat_o[0] (wb_dat_o[0]), 
            .wb_ack_o(wb_ack_o), .SPI0_nCS_USR_c(SPI0_nCS_USR_c), .spi_mosi_oe(spi_mosi_oe), 
            .spi_mosi_o(spi_mosi_o), .spi_miso_oe(spi_miso_oe), .spi_miso_o(spi_miso_o), 
            .spi_clk_oe(spi_clk_oe), .spi_clk_o(spi_clk_o), .spi_mosi_i(spi_mosi_i), 
            .spi_miso_i(spi_miso_i), .spi_clk_i(spi_clk_i), .i2c1_sdaoen(i2c1_sdaoen), 
            .i2c1_sdao(i2c1_sdao), .i2c1_scloen(i2c1_scloen), .i2c1_sclo(i2c1_sclo), 
            .i2c1_sdai(i2c1_sdai), .i2c1_scli(i2c1_scli), .VCC_net(VCC_net)) /* synthesis NGD_DRC_MASK=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(346[7:15])
    BB BBspi_mosi (.I(spi_mosi_o), .T(spi_mosi_oe), .B(SPI0_MOSI), .O(spi_mosi_i)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=346, LSE_RLINE=346 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/ipexpress/xo2/efb_vhdl.vhd(160[17:19])
    LUT4 i1_4_lut (.A(n9_adj_689), .B(n3202), .C(n14_adj_664), .D(n10), 
         .Z(n3724)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut.init = 16'hfffe;
    LUT4 i1_2_lut (.A(n_temp1_7__N_100), .B(n_temp1_7__N_94), .Z(n9_adj_689)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_2_lut.init = 16'heeee;
    CCU2D add_571_5 (.A0(dat_count[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4879), .COUT(n4880), .S0(n1966), .S1(n1965));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_571_5.INIT0 = 16'h5555;
    defparam add_571_5.INIT1 = 16'h5555;
    defparam add_571_5.INJECT1_0 = "NO";
    defparam add_571_5.INJECT1_1 = "NO";
    CCU2D add_571_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n4878), .S1(n1969));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_571_1.INIT0 = 16'hF000;
    defparam add_571_1.INIT1 = 16'h5555;
    defparam add_571_1.INJECT1_0 = "NO";
    defparam add_571_1.INJECT1_1 = "NO";
    CCU2D add_571_3 (.A0(dat_count[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4878), .COUT(n4879), .S0(n1968), .S1(n1967));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_571_3.INIT0 = 16'h5555;
    defparam add_571_3.INIT1 = 16'h5555;
    defparam add_571_3.INJECT1_0 = "NO";
    defparam add_571_3.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_917_add_4_3 (.A0(n24_adj_675), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(n23), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n4882), .COUT(n4883), .S0(n129), .S1(n128));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917_add_4_3.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_3.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_3.INJECT1_0 = "NO";
    defparam resetcounter_i24_917_add_4_3.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_917_add_4_17 (.A0(resetcounter[15]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4889), .COUT(n4890), .S0(n115), 
          .S1(n114));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917_add_4_17.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_17.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_17.INJECT1_0 = "NO";
    defparam resetcounter_i24_917_add_4_17.INJECT1_1 = "NO";
    FD1P3IX temp2__i0 (.D(wb_dat_o[0]), .SP(reg_rdy_N_607), .CD(n5476), 
            .CK(clk), .Q(temp2[0]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp2__i0.GSR = "ENABLED";
    FD1S3IX data0__i5 (.D(data0_7__N_436[5]), .CK(clk), .CD(n5476), .Q(data0[5]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(496[7] 509[14])
    defparam data0__i5.GSR = "ENABLED";
    CCU2D resetcounter_i24_917_add_4_15 (.A0(resetcounter[13]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4888), .COUT(n4889), .S0(n117), 
          .S1(n116));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917_add_4_15.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_15.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_15.INJECT1_0 = "NO";
    defparam resetcounter_i24_917_add_4_15.INJECT1_1 = "NO";
    FD1S3IX c_state_FSM_i13 (.D(n3436), .CK(clk), .CD(n5476), .Q(n_temp1_7__N_88));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i13.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i12 (.D(n3434), .CK(clk), .CD(n5476), .Q(n_temp1_7__N_89));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i12.GSR = "ENABLED";
    FD1P3IX temp3__i0 (.D(wb_dat_o[0]), .SP(dat_rdy_N_611), .CD(n5476), 
            .CK(clk), .Q(temp3[0]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp3__i0.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i0 (.D(n_wb_dat_i[0]), .CK(clk), .CD(n5476), .Q(wb_dat_i[0]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(705[1] 721[10])
    defparam wb_dat_i__i0.GSR = "ENABLED";
    FD1S3IX wb_adr_i__i1 (.D(n_wb_adr_i[0]), .CK(clk), .CD(n5476), .Q(wb_adr_i[0]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(705[1] 721[10])
    defparam wb_adr_i__i1.GSR = "ENABLED";
    FD1S3IX dat_count__i0 (.D(n_dat_count[0]), .CK(clk), .CD(n5476), .Q(dat_count[0]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(726[1] 740[10])
    defparam dat_count__i0.GSR = "ENABLED";
    LUT4 i6_4_lut (.A(n_temp1_7__N_88), .B(n_temp1_7__N_99), .C(n_temp1_7__N_85), 
         .D(n_temp1_7__N_93), .Z(n14_adj_664)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i6_4_lut.init = 16'hfffe;
    BB BB1_scl (.I(i2c1_sclo), .T(i2c1_scloen), .B(SCL), .O(i2c1_scli)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=346, LSE_RLINE=346 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/ipexpress/xo2/efb_vhdl.vhd(178[14:16])
    FD1P3IX GPO_DATA_0___i1 (.D(temp3[0]), .SP(clk_enable_8), .CD(n5476), 
            .CK(clk), .Q(X13_E2C_M62_c_0));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(562[8] 570[15])
    defparam GPO_DATA_0___i1.GSR = "ENABLED";
    BB BB1_sda (.I(i2c1_sdao), .T(i2c1_sdaoen), .B(SDA), .O(i2c1_sdai)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=346, LSE_RLINE=346 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/ipexpress/xo2/efb_vhdl.vhd(174[14:16])
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk)) /* synthesis NOM_FREQ="7", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "7";
    FD1S3IX c_state_FSM_i11 (.D(n3432), .CK(clk), .CD(n5476), .Q(n_temp1_7__N_90));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i11.GSR = "ENABLED";
    FD1S3IX data0__i0 (.D(data0_7__N_436[0]), .CK(clk), .CD(n5476), .Q(data0[0]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(496[7] 509[14])
    defparam data0__i0.GSR = "ENABLED";
    FD1S3IX data0__i4 (.D(data0_7__N_436[4]), .CK(clk), .CD(n5476), .Q(data0[4]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(496[7] 509[14])
    defparam data0__i4.GSR = "ENABLED";
    CCU2D resetcounter_i24_917_add_4_13 (.A0(resetcounter[11]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4887), .COUT(n4888), .S0(n119), 
          .S1(n118));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917_add_4_13.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_13.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_13.INJECT1_0 = "NO";
    defparam resetcounter_i24_917_add_4_13.INJECT1_1 = "NO";
    FD1S3IX data0__i3 (.D(data0_7__N_436[3]), .CK(clk), .CD(n5476), .Q(data0[3]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(496[7] 509[14])
    defparam data0__i3.GSR = "ENABLED";
    LUT4 i2_2_lut (.A(n_temp1_7__N_98), .B(n_temp1_7__N_91), .Z(n10)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i2_2_lut.init = 16'heeee;
    LUT4 i1855_2_lut_4_lut (.A(temp1[3]), .B(n5471), .C(n5465), .D(clk_enable_17), 
         .Z(n4245)) /* synthesis lut_function=(A (D)+!A (B (D)+!B (C (D)))) */ ;
    defparam i1855_2_lut_4_lut.init = 16'hfe00;
    FD1S3IX c_state_FSM_i10 (.D(n3430), .CK(clk), .CD(n5476), .Q(n_temp1_7__N_91));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i10.GSR = "ENABLED";
    FD1S3IX data0__i2 (.D(data0_7__N_436[2]), .CK(clk), .CD(n5476), .Q(data0[2]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(496[7] 509[14])
    defparam data0__i2.GSR = "ENABLED";
    CCU2D resetcounter_i24_917_add_4_11 (.A0(resetcounter[9]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4886), .COUT(n4887), .S0(n121), 
          .S1(n120));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917_add_4_11.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_11.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_11.INJECT1_0 = "NO";
    defparam resetcounter_i24_917_add_4_11.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_917_add_4_9 (.A0(n18_adj_671), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4885), .COUT(n4886), .S0(n123), 
          .S1(n122));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917_add_4_9.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_9.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_9.INJECT1_0 = "NO";
    defparam resetcounter_i24_917_add_4_9.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_917_add_4_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n4312), .B1(n5477), .C1(n25), .D1(GND_net), 
          .COUT(n4882), .S1(n130));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917_add_4_1.INIT0 = 16'hF000;
    defparam resetcounter_i24_917_add_4_1.INIT1 = 16'h8787;
    defparam resetcounter_i24_917_add_4_1.INJECT1_0 = "NO";
    defparam resetcounter_i24_917_add_4_1.INJECT1_1 = "NO";
    FD1S3IX data0__i1 (.D(data0_7__N_436[1]), .CK(clk), .CD(n5476), .Q(data0[1]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(496[7] 509[14])
    defparam data0__i1.GSR = "ENABLED";
    FD1P3IX GPO_DATA_0___i8 (.D(temp3[7]), .SP(clk_enable_8), .CD(n5476), 
            .CK(clk), .Q(FP_UsrLED_c_4));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(562[8] 570[15])
    defparam GPO_DATA_0___i8.GSR = "ENABLED";
    BB BBspi_clk (.I(spi_clk_o), .T(spi_clk_oe), .B(SPI0_SCLK), .O(spi_clk_i)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=346, LSE_RLINE=346 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/ipexpress/xo2/efb_vhdl.vhd(168[16:18])
    FD1P3IX GPO_DATA_0___i7 (.D(temp3[6]), .SP(clk_enable_8), .CD(n5476), 
            .CK(clk), .Q(FP_UsrLED_c_3));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(562[8] 570[15])
    defparam GPO_DATA_0___i7.GSR = "ENABLED";
    FD1P3IX GPO_DATA_0___i6 (.D(temp3[5]), .SP(clk_enable_8), .CD(n5476), 
            .CK(clk), .Q(FP_UsrLED_c_2));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(562[8] 570[15])
    defparam GPO_DATA_0___i6.GSR = "ENABLED";
    BB BBspi_miso (.I(spi_miso_o), .T(spi_miso_oe), .B(SPI0_MISO), .O(spi_miso_i)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=346, LSE_RLINE=346 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/ipexpress/xo2/efb_vhdl.vhd(164[17:19])
    FD1P3IX GPO_DATA_0___i5 (.D(temp3[4]), .SP(clk_enable_8), .CD(n5476), 
            .CK(clk), .Q(FP_UsrLED_c_1));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(562[8] 570[15])
    defparam GPO_DATA_0___i5.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i9 (.D(n3424), .CK(clk), .CD(n5476), .Q(reg_rdy_N_609));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i9.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i8 (.D(n5125), .CK(clk), .CD(n5476), .Q(n_temp1_7__N_93));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i8.GSR = "ENABLED";
    LUT4 i2901_4_lut (.A(n3699), .B(n48), .C(data0[3]), .D(n50), .Z(data0_7__N_436[3])) /* synthesis lut_function=(!(A+(B+!(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(501[6] 507[15])
    defparam i2901_4_lut.init = 16'h1011;
    LUT4 i1079_4_lut (.A(n_temp1_7__N_99), .B(clk_enable_17), .C(n_temp1_7__N_96), 
         .D(n5247), .Z(n3450)) /* synthesis lut_function=(A ((C+(D))+!B)+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1079_4_lut.init = 16'heae2;
    LUT4 i2_4_lut (.A(dat_count[1]), .B(n12_adj_667), .C(n17), .D(n15_adj_666), 
         .Z(n_dat_count[1])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i2_4_lut.init = 16'hffec;
    LUT4 i1_4_lut_adj_48 (.A(n_temp1_7__N_96), .B(dat_count[1]), .C(n1968), 
         .D(n5460), .Z(n12_adj_667)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_48.init = 16'ha088;
    FD1S3IX c_state_FSM_i7 (.D(n3418), .CK(clk), .CD(n5476), .Q(n_temp1_7__N_94));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i7.GSR = "ENABLED";
    FD1S3IX c_state_FSM_i1 (.D(n3452), .CK(clk), .CD(n5476), .Q(n_temp1_7__N_100));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i1.GSR = "ENABLED";
    LUT4 i1_2_lut_3_lut (.A(dat_rdy_N_613), .B(reg_rdy_N_609), .C(n_temp1_7__N_96), 
         .Z(n5271)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i1_2_lut_3_lut.init = 16'hfefe;
    LUT4 i1_2_lut_rep_76 (.A(n_state_7__N_578[4]), .B(wb_dat_o[2]), .Z(n5480)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam i1_2_lut_rep_76.init = 16'h2222;
    FD1S3AX resetnefb_488 (.D(resetcounter_24__N_603), .CK(clk), .Q(resetnefb));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(442[2] 449[9])
    defparam resetnefb_488.GSR = "ENABLED";
    LUT4 i2896_4_lut (.A(n14_adj_652), .B(n5472), .C(n5282), .D(n9), 
         .Z(n_state_7__N_522[3])) /* synthesis lut_function=(A+(B (C)+!B (C (D)))) */ ;
    defparam i2896_4_lut.init = 16'hfaea;
    LUT4 i4_4_lut (.A(temp1[0]), .B(n5478), .C(temp1[1]), .D(n6_adj_662), 
         .Z(n3698)) /* synthesis lut_function=(!((B+(C+!(D)))+!A)) */ ;
    defparam i4_4_lut.init = 16'h0200;
    LUT4 i1_2_lut_adj_49 (.A(temp1[3]), .B(temp1[2]), .Z(n6_adj_662)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i1_2_lut_adj_49.init = 16'h4444;
    FD1S3IX c_state_FSM_i6 (.D(n4942), .CK(clk), .CD(n5476), .Q(dat_rdy_N_613));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i6.GSR = "ENABLED";
    LUT4 i1_4_lut_adj_50 (.A(GPI_DAT[3]), .B(n3698), .C(temp1[5]), .D(temp1[6]), 
         .Z(n3699)) /* synthesis lut_function=(A (B (C (D)))+!A (B (C (D)+!C !(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(501[6] 507[15])
    defparam i1_4_lut_adj_50.init = 16'hc004;
    LUT4 i1_3_lut (.A(temp1[6]), .B(n18), .C(data0[3]), .Z(n48)) /* synthesis lut_function=(A (B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(501[6] 507[15])
    defparam i1_3_lut.init = 16'h8a8a;
    LUT4 i1_2_lut_4_lut (.A(temp1[3]), .B(n5471), .C(n5465), .D(dat_rdy_N_613), 
         .Z(n3)) /* synthesis lut_function=(!(A+(B+(C+!(D))))) */ ;
    defparam i1_2_lut_4_lut.init = 16'h0100;
    LUT4 i2_3_lut (.A(n_temp1_7__N_97), .B(n_temp1_7__N_84), .C(n_temp1_7__N_90), 
         .Z(n5197)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i2_3_lut.init = 16'hfefe;
    LUT4 i3_4_lut (.A(n_temp1_7__N_86), .B(n_temp1_7__N_89), .C(n_temp1_7__N_87), 
         .D(n5479), .Z(n3202)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i3_4_lut.init = 16'hfffe;
    LUT4 i6_4_lut_adj_51 (.A(dat_count[3]), .B(dat_count[1]), .C(dat_count[5]), 
         .D(dat_count[7]), .Z(n14_adj_688)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(1204[13:35])
    defparam i6_4_lut_adj_51.init = 16'hfffe;
    LUT4 i1_4_lut_adj_52 (.A(dat_rdy_N_613), .B(n1968), .C(dat_count[1]), 
         .D(n4245), .Z(n15_adj_666)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_52.init = 16'h88a0;
    FD1P3IX GPO_DATA_0___i4 (.D(temp3[3]), .SP(clk_enable_8), .CD(n5476), 
            .CK(clk), .Q(FP_SysLEDs_c_3));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(562[8] 570[15])
    defparam GPO_DATA_0___i4.GSR = "ENABLED";
    FD1P3IX GPO_DATA_0___i3 (.D(temp3[2]), .SP(clk_enable_8), .CD(n5476), 
            .CK(clk), .Q(X13_E2C_M58_c_2));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(562[8] 570[15])
    defparam GPO_DATA_0___i3.GSR = "ENABLED";
    FD1P3IX GPO_DATA_0___i2 (.D(temp3[1]), .SP(clk_enable_8), .CD(n5476), 
            .CK(clk), .Q(X13_E2C_M59_c_1));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(562[8] 570[15])
    defparam GPO_DATA_0___i2.GSR = "ENABLED";
    FD1S3IX dat_count__i7 (.D(n_dat_count[7]), .CK(clk), .CD(n5476), .Q(dat_count[7]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(726[1] 740[10])
    defparam dat_count__i7.GSR = "ENABLED";
    FD1S3IX dat_count__i6 (.D(n_dat_count[6]), .CK(clk), .CD(n5476), .Q(dat_count[6]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(726[1] 740[10])
    defparam dat_count__i6.GSR = "ENABLED";
    FD1S3IX dat_count__i5 (.D(n_dat_count[5]), .CK(clk), .CD(n5476), .Q(dat_count[5]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(726[1] 740[10])
    defparam dat_count__i5.GSR = "ENABLED";
    FD1S3IX dat_count__i4 (.D(n_dat_count[4]), .CK(clk), .CD(n5476), .Q(dat_count[4]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(726[1] 740[10])
    defparam dat_count__i4.GSR = "ENABLED";
    LUT4 i1_2_lut_3_lut_4_lut (.A(n_state_7__N_578[4]), .B(wb_dat_o[2]), 
         .C(n4231), .D(n15), .Z(n5247)) /* synthesis lut_function=(!((B+!(C+(D)))+!A)) */ ;
    defparam i1_2_lut_3_lut_4_lut.init = 16'h2220;
    FD1S3IX c_state_FSM_i5 (.D(n5222), .CK(clk), .CD(n5476), .Q(n_temp1_7__N_96));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i5.GSR = "ENABLED";
    LUT4 i694_2_lut_rep_63_3_lut_4_lut (.A(n_state_7__N_578[4]), .B(wb_dat_o[2]), 
         .C(wb_adr_i[6]), .D(wb_ack_o), .Z(n5467)) /* synthesis lut_function=(!(A (B (C (D)))+!A (C (D)))) */ ;
    defparam i694_2_lut_rep_63_3_lut_4_lut.init = 16'h2fff;
    LUT4 i1_3_lut_4_lut (.A(n_state_7__N_522[3]), .B(clk_enable_17), .C(reg_rdy_N_609), 
         .D(n5271), .Z(n17)) /* synthesis lut_function=(!(A (B (D)+!B !(C+!(D)))+!A !(C+!(D)))) */ ;
    defparam i1_3_lut_4_lut.init = 16'h70ff;
    FD1S3IX c_state_FSM_i4 (.D(n5039), .CK(clk), .CD(n5476), .Q(n_temp1_7__N_97));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i4.GSR = "ENABLED";
    LUT4 i4_4_lut_adj_53 (.A(temp1[1]), .B(temp1[3]), .C(temp1[0]), .D(temp1[5]), 
         .Z(n10_adj_663)) /* synthesis lut_function=(!(((C+!(D))+!B)+!A)) */ ;
    defparam i4_4_lut_adj_53.init = 16'h0800;
    LUT4 i1_4_lut_adj_54 (.A(n_temp1_7__N_96), .B(n5461), .C(data0[3]), 
         .D(n5206), .Z(n5217)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;
    defparam i1_4_lut_adj_54.init = 16'heca0;
    LUT4 i1_4_lut_adj_55 (.A(n5206), .B(n_temp1_7__N_91), .C(n4), .D(n5467), 
         .Z(n3430)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(294[17:24])
    defparam i1_4_lut_adj_55.init = 16'heca0;
    LUT4 i1_4_lut_adj_56 (.A(data0[2]), .B(n_temp1_7__N_97), .C(n_temp1_7__N_96), 
         .D(n_temp1_7__N_84), .Z(n5227)) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(294[17:24])
    defparam i1_4_lut_adj_56.init = 16'hffec;
    LUT4 i2904_4_lut (.A(n3704), .B(n48_adj_651), .C(data0[7]), .D(n50), 
         .Z(data0_7__N_436[7])) /* synthesis lut_function=(!(A+(B+!(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(501[6] 507[15])
    defparam i2904_4_lut.init = 16'h1011;
    LUT4 i1_4_lut_adj_57 (.A(GPI_DAT[7]), .B(n3698), .C(temp1[5]), .D(temp1[6]), 
         .Z(n3704)) /* synthesis lut_function=(A (B (C (D)))+!A (B (C (D)+!C !(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(501[6] 507[15])
    defparam i1_4_lut_adj_57.init = 16'hc004;
    OB X13_E2C_M62_pad (.I(X13_E2C_M62_c_0), .O(X13_E2C_M62));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(26[3:14])
    LUT4 i1_3_lut_adj_58 (.A(temp1[6]), .B(n18), .C(data0[7]), .Z(n48_adj_651)) /* synthesis lut_function=(A (B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(501[6] 507[15])
    defparam i1_3_lut_adj_58.init = 16'h8a8a;
    FD1S3IX dat_count__i3 (.D(n_dat_count[3]), .CK(clk), .CD(n5476), .Q(dat_count[3]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(726[1] 740[10])
    defparam dat_count__i3.GSR = "ENABLED";
    FD1S3IX dat_count__i2 (.D(n_dat_count[2]), .CK(clk), .CD(n5476), .Q(dat_count[2]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(726[1] 740[10])
    defparam dat_count__i2.GSR = "ENABLED";
    LUT4 i2_4_lut_adj_59 (.A(dat_count[0]), .B(n12_adj_681), .C(n17), 
         .D(n15_adj_680), .Z(n_dat_count[0])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i2_4_lut_adj_59.init = 16'hffec;
    CCU2D add_571_9 (.A0(dat_count[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n4881), 
          .S0(n1962));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_571_9.INIT0 = 16'h5555;
    defparam add_571_9.INIT1 = 16'h0000;
    defparam add_571_9.INJECT1_0 = "NO";
    defparam add_571_9.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_60 (.A(data0[6]), .B(temp1[6]), .C(n33), .D(n6), 
         .Z(data0_7__N_436[6])) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[14:19])
    defparam i1_4_lut_adj_60.init = 16'hb3a0;
    CCU2D resetcounter_i24_917_add_4_7 (.A0(n20_adj_672), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(n19), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n4884), .COUT(n4885), .S0(n125), .S1(n124));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917_add_4_7.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_7.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_7.INJECT1_0 = "NO";
    defparam resetcounter_i24_917_add_4_7.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_61 (.A(data0[2]), .B(temp1[6]), .C(n33), .D(n6_adj_678), 
         .Z(data0_7__N_436[2])) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[14:19])
    defparam i1_4_lut_adj_61.init = 16'hb3a0;
    LUT4 i19_4_lut (.A(GPI_DAT[2]), .B(data0[2]), .C(temp1[5]), .D(n3698), 
         .Z(n6_adj_678)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[14:19])
    defparam i19_4_lut.init = 16'hcac0;
    FD1S3IX c_state_FSM_i3 (.D(n5041), .CK(clk), .CD(n5476), .Q(n_temp1_7__N_98));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i3.GSR = "ENABLED";
    LUT4 i19_4_lut_adj_62 (.A(GPI_DAT[6]), .B(data0[6]), .C(temp1[5]), 
         .D(n3698), .Z(n6)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[14:19])
    defparam i19_4_lut_adj_62.init = 16'hcac0;
    LUT4 i1918_4_lut (.A(n5), .B(resetcounter[21]), .C(resetcounter[18]), 
         .D(resetcounter[20]), .Z(n4312)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;
    defparam i1918_4_lut.init = 16'heccc;
    CCU2D add_571_7 (.A0(dat_count[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n4880), .COUT(n4881), .S0(n1964), .S1(n1963));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_571_7.INIT0 = 16'h5555;
    defparam add_571_7.INIT1 = 16'h5555;
    defparam add_571_7.INJECT1_0 = "NO";
    defparam add_571_7.INJECT1_1 = "NO";
    CCU2D resetcounter_i24_917_add_4_5 (.A0(n22_adj_674), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(n21_adj_673), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4883), .COUT(n4884), .S0(n127), 
          .S1(n126));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917_add_4_5.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_5.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_5.INJECT1_0 = "NO";
    defparam resetcounter_i24_917_add_4_5.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_63 (.A(wb_dat_o[0]), .B(temp1[0]), .C(n5470), .D(n5288), 
         .Z(n_temp1[0])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_63.init = 16'ha0ec;
    FD1S3IX c_state_FSM_i2 (.D(n3450), .CK(clk), .CD(n5476), .Q(n_temp1_7__N_99));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i2.GSR = "ENABLED";
    LUT4 i2_3_lut_rep_58_4_lut (.A(temp1[6]), .B(n5466), .C(n5471), .D(temp1[3]), 
         .Z(n5462)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam i2_3_lut_rep_58_4_lut.init = 16'hfffe;
    CCU2D resetcounter_i24_917_add_4_25 (.A0(resetcounter[23]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4893), .S0(n107), .S1(n106));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917_add_4_25.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_25.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_25.INJECT1_0 = "NO";
    defparam resetcounter_i24_917_add_4_25.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_64 (.A(resetcounter[13]), .B(resetcounter[19]), .C(n10_adj_670), 
         .D(resetcounter[17]), .Z(n5)) /* synthesis lut_function=(A (B)+!A (B (C+(D)))) */ ;
    defparam i1_4_lut_adj_64.init = 16'hccc8;
    FD1S3IX dat_count__i1 (.D(n_dat_count[1]), .CK(clk), .CD(n5476), .Q(dat_count[1]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(726[1] 740[10])
    defparam dat_count__i1.GSR = "ENABLED";
    LUT4 i4_4_lut_adj_65 (.A(n4932), .B(n8), .C(resetcounter[16]), .D(resetcounter[12]), 
         .Z(n10_adj_670)) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(C))) */ ;
    defparam i4_4_lut_adj_65.init = 16'hfefc;
    CCU2D resetcounter_i24_917_add_4_23 (.A0(resetcounter[21]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4892), .COUT(n4893), .S0(n109), 
          .S1(n108));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917_add_4_23.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_23.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_23.INJECT1_0 = "NO";
    defparam resetcounter_i24_917_add_4_23.INJECT1_1 = "NO";
    GSR GSR_INST (.GSR(VCC_net));
    FD1S3IX wb_adr_i__i4 (.D(n_wb_adr_i[6]), .CK(clk), .CD(n5476), .Q(wb_adr_i[6]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(705[1] 721[10])
    defparam wb_adr_i__i4.GSR = "ENABLED";
    FD1S3IX wb_adr_i__i3 (.D(n_wb_adr_i[2]), .CK(clk), .CD(n5476), .Q(wb_adr_i[2]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(705[1] 721[10])
    defparam wb_adr_i__i3.GSR = "ENABLED";
    FD1S3IX wb_adr_i__i2 (.D(n_wb_adr_i[1]), .CK(clk), .CD(n5476), .Q(wb_adr_i[1]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(705[1] 721[10])
    defparam wb_adr_i__i2.GSR = "ENABLED";
    CCU2D resetcounter_i24_917_add_4_21 (.A0(resetcounter[19]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4891), .COUT(n4892), .S0(n111), 
          .S1(n110));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917_add_4_21.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_21.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_21.INJECT1_0 = "NO";
    defparam resetcounter_i24_917_add_4_21.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_66 (.A(n_temp1_7__N_96), .B(dat_count[0]), .C(n1969), 
         .D(n5460), .Z(n12_adj_681)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_66.init = 16'ha088;
    FD1S3IX wb_dat_i__i7 (.D(n_wb_dat_i[7]), .CK(clk), .CD(n5476), .Q(wb_dat_i[7]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(705[1] 721[10])
    defparam wb_dat_i__i7.GSR = "ENABLED";
    LUT4 i1_4_lut_adj_67 (.A(dat_rdy_N_613), .B(n1969), .C(dat_count[0]), 
         .D(n4245), .Z(n15_adj_680)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_67.init = 16'h88a0;
    FD1S3IX wb_dat_i__i6 (.D(n_wb_dat_i[6]), .CK(clk), .CD(n5476), .Q(wb_dat_i[6]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(705[1] 721[10])
    defparam wb_dat_i__i6.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i5 (.D(n_wb_dat_i[5]), .CK(clk), .CD(n5476), .Q(wb_dat_i[5]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(705[1] 721[10])
    defparam wb_dat_i__i5.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i4 (.D(n_wb_dat_i[4]), .CK(clk), .CD(n5476), .Q(wb_dat_i[4]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(705[1] 721[10])
    defparam wb_dat_i__i4.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i3 (.D(n_wb_dat_i[3]), .CK(clk), .CD(n5476), .Q(wb_dat_i[3]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(705[1] 721[10])
    defparam wb_dat_i__i3.GSR = "ENABLED";
    LUT4 temp1_1__bdd_2_lut_3_lut_4_lut (.A(temp1[6]), .B(n5466), .C(temp1[0]), 
         .D(n5472), .Z(n5427)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp1_1__bdd_2_lut_3_lut_4_lut.init = 16'hfffe;
    FD1S3IX wb_dat_i__i2 (.D(n_wb_dat_i[2]), .CK(clk), .CD(n5476), .Q(wb_dat_i[2]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(705[1] 721[10])
    defparam wb_dat_i__i2.GSR = "ENABLED";
    FD1S3IX wb_dat_i__i1 (.D(n_wb_dat_i[1]), .CK(clk), .CD(n5476), .Q(wb_dat_i[1]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(705[1] 721[10])
    defparam wb_dat_i__i1.GSR = "ENABLED";
    FD1P3IX temp3__i7 (.D(wb_dat_o[7]), .SP(dat_rdy_N_611), .CD(n5476), 
            .CK(clk), .Q(temp3[7]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp3__i7.GSR = "ENABLED";
    LUT4 i1_4_lut_adj_68 (.A(wb_dat_o[7]), .B(temp1[7]), .C(n5470), .D(n5288), 
         .Z(n_temp1[7])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_68.init = 16'ha0ec;
    FD1P3IX temp3__i6 (.D(n_state_7__N_578[4]), .SP(dat_rdy_N_611), .CD(n5476), 
            .CK(clk), .Q(temp3[6]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp3__i6.GSR = "ENABLED";
    FD1P3IX temp3__i5 (.D(wb_dat_o[5]), .SP(dat_rdy_N_611), .CD(n5476), 
            .CK(clk), .Q(temp3[5]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp3__i5.GSR = "ENABLED";
    FD1P3IX temp3__i4 (.D(wb_dat_o[4]), .SP(dat_rdy_N_611), .CD(n5476), 
            .CK(clk), .Q(temp3[4]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp3__i4.GSR = "ENABLED";
    FD1P3IX temp3__i3 (.D(wb_dat_o[3]), .SP(dat_rdy_N_611), .CD(n5476), 
            .CK(clk), .Q(temp3[3]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp3__i3.GSR = "ENABLED";
    LUT4 i1_4_lut_adj_69 (.A(n_state_7__N_578[4]), .B(temp1[6]), .C(n5470), 
         .D(n5288), .Z(n_temp1[6])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_69.init = 16'ha0ec;
    LUT4 i1_4_lut_adj_70 (.A(wb_dat_o[5]), .B(temp1[5]), .C(n5470), .D(n5288), 
         .Z(n_temp1[5])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_70.init = 16'ha0ec;
    LUT4 i2_3_lut_4_lut (.A(temp1[5]), .B(n5478), .C(temp1[0]), .D(n68), 
         .Z(n50)) /* synthesis lut_function=(A+(B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam i2_3_lut_4_lut.init = 16'hffef;
    FD1P3IX temp3__i2 (.D(wb_dat_o[2]), .SP(dat_rdy_N_611), .CD(n5476), 
            .CK(clk), .Q(temp3[2]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp3__i2.GSR = "ENABLED";
    FD1P3IX temp3__i1 (.D(wb_dat_o[1]), .SP(dat_rdy_N_611), .CD(n5476), 
            .CK(clk), .Q(temp3[1]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp3__i1.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i7 (.D(X13_C2E_M61_c), .SP(clk_enable_16), .CD(n5476), 
            .CK(clk), .Q(GPI_DAT[7]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(581[8] 587[15])
    defparam GPI_DAT__i7.GSR = "ENABLED";
    LUT4 i2_4_lut_adj_71 (.A(resetcounter[11]), .B(resetcounter[8]), .C(resetcounter[10]), 
         .D(resetcounter[9]), .Z(n4932)) /* synthesis lut_function=(A+(B (C+(D))+!B (C))) */ ;
    defparam i2_4_lut_adj_71.init = 16'hfefa;
    LUT4 i2_2_lut_adj_72 (.A(resetcounter[14]), .B(resetcounter[15]), .Z(n8)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2_2_lut_adj_72.init = 16'heeee;
    FD1P3IX GPI_DAT__i6 (.D(PG_VIN_c), .SP(clk_enable_16), .CD(n5476), 
            .CK(clk), .Q(GPI_DAT[6]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(581[8] 587[15])
    defparam GPI_DAT__i6.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i5 (.D(PPn_VIN_c), .SP(clk_enable_16), .CD(n5476), 
            .CK(clk), .Q(GPI_DAT[5]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(581[8] 587[15])
    defparam GPI_DAT__i5.GSR = "ENABLED";
    LUT4 i1_4_lut_adj_73 (.A(wb_dat_o[4]), .B(temp1[4]), .C(n5470), .D(n5288), 
         .Z(n_temp1[4])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_73.init = 16'ha0ec;
    FD1S3IX data0__i7 (.D(data0_7__N_436[7]), .CK(clk), .CD(n5476), .Q(data0[7]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(496[7] 509[14])
    defparam data0__i7.GSR = "ENABLED";
    LUT4 i1_2_lut_rep_60_3_lut_4_lut (.A(temp1[5]), .B(n5478), .C(n5472), 
         .D(temp1[6]), .Z(n5464)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam i1_2_lut_rep_60_3_lut_4_lut.init = 16'hfffe;
    LUT4 i1063_4_lut_4_lut (.A(clk_enable_17), .B(wb_dat_o[2]), .C(n_temp1_7__N_88), 
         .D(n_temp1_7__N_89), .Z(n3434)) /* synthesis lut_function=(A (B (C))+!A (D)) */ ;
    defparam i1063_4_lut_4_lut.init = 16'hd580;
    LUT4 i1055_4_lut_4_lut (.A(clk_enable_17), .B(wb_dat_o[2]), .C(n_temp1_7__N_91), 
         .D(reg_rdy_N_609), .Z(n3424)) /* synthesis lut_function=(A (B (C))+!A (D)) */ ;
    defparam i1055_4_lut_4_lut.init = 16'hd580;
    LUT4 i1065_4_lut_4_lut (.A(clk_enable_17), .B(wb_dat_o[2]), .C(n_temp1_7__N_87), 
         .D(n_temp1_7__N_88), .Z(n3436)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A (D)) */ ;
    defparam i1065_4_lut_4_lut.init = 16'hf7a0;
    LUT4 i1_4_lut_4_lut (.A(clk_enable_17), .B(n5480), .C(n4_adj_684), 
         .D(n_temp1_7__N_93), .Z(n5125)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(1050[8] 1061[15])
    defparam i1_4_lut_4_lut.init = 16'hfda0;
    FD1S3IX dat_rdy_del_493 (.D(dat_rdy), .CK(clk), .CD(n5476), .Q(dat_rdy_del));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[7] 487[11])
    defparam dat_rdy_del_493.GSR = "ENABLED";
    LUT4 i1_4_lut_adj_74 (.A(wb_dat_o[3]), .B(temp1[3]), .C(n5470), .D(n5288), 
         .Z(n_temp1[3])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_74.init = 16'ha0ec;
    FD1S3IX wb_we_i_506 (.D(n_wb_we_i), .CK(clk), .CD(n5476), .Q(wb_we_i));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(705[1] 721[10])
    defparam wb_we_i_506.GSR = "ENABLED";
    LUT4 i2872_4_lut_then_4_lut (.A(n14_adj_652), .B(temp1[2]), .C(temp1[0]), 
         .D(temp1[1]), .Z(n5482)) /* synthesis lut_function=(A+(B+(C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(684[58:76])
    defparam i2872_4_lut_then_4_lut.init = 16'hfeff;
    LUT4 i2872_4_lut_else_4_lut (.A(n14_adj_652), .B(temp1[2]), .C(temp1[0]), 
         .D(temp1[1]), .Z(n5481)) /* synthesis lut_function=(A+(((D)+!C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(684[58:76])
    defparam i2872_4_lut_else_4_lut.init = 16'hffbf;
    LUT4 i1_3_lut_4_lut_adj_75 (.A(wb_ack_o), .B(wb_adr_i[6]), .C(n5217), 
         .D(n_temp1_7__N_97), .Z(n_wb_dat_i[3])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1_3_lut_4_lut_adj_75.init = 16'h7770;
    FD1S3IX dat_rdy_492 (.D(dat_rdy_N_611), .CK(clk), .CD(n5476), .Q(dat_rdy));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[7] 487[11])
    defparam dat_rdy_492.GSR = "ENABLED";
    FD1S3IX reg_rdy_490 (.D(reg_rdy_N_607), .CK(clk), .CD(n5476), .Q(reg_rdy));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(456[1] 469[9])
    defparam reg_rdy_490.GSR = "ENABLED";
    FD1S3IX data0__i6 (.D(data0_7__N_436[6]), .CK(clk), .CD(n5476), .Q(data0[6]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(496[7] 509[14])
    defparam data0__i6.GSR = "ENABLED";
    FD1S3IX temp1__i0 (.D(n_temp1[0]), .CK(clk), .CD(n5476), .Q(temp1[0]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp1__i0.GSR = "ENABLED";
    LUT4 i1_3_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_adr_i[6]), .C(n_temp1_7__N_90), 
         .D(n_temp1_7__N_89), .Z(n3432)) /* synthesis lut_function=(A (B (D)+!B (C))+!A (C)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1_3_lut_3_lut_4_lut.init = 16'hf870;
    LUT4 i1_4_lut_adj_76 (.A(n5465), .B(n9), .C(n5267), .D(n5474), .Z(n4231)) /* synthesis lut_function=(A+(B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_76.init = 16'hfaea;
    LUT4 i2_3_lut_rep_64 (.A(n5197), .B(n_temp1_7__N_96), .C(n_temp1_7__N_83), 
         .Z(n5468)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i2_3_lut_rep_64.init = 16'hfefe;
    LUT4 i1043_2_lut_rep_65_3_lut (.A(wb_ack_o), .B(wb_adr_i[6]), .C(n_temp1_7__N_96), 
         .Z(n5469)) /* synthesis lut_function=(!(A (B+!(C))+!A !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1043_2_lut_rep_65_3_lut.init = 16'h7070;
    FD1S3AX resetcounter_i24_917__i0 (.D(n130), .CK(clk), .Q(n25)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i0.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i4 (.D(S2C_S2_c), .SP(clk_enable_16), .CD(n5476), 
            .CK(clk), .Q(GPI_DAT[4]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(581[8] 587[15])
    defparam GPI_DAT__i4.GSR = "ENABLED";
    LUT4 i1_2_lut_3_lut_4_lut_adj_77 (.A(wb_ack_o), .B(wb_adr_i[6]), .C(data0[4]), 
         .D(n_temp1_7__N_96), .Z(n_wb_dat_i[4])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_77.init = 16'h7000;
    LUT4 i1_4_lut_adj_78 (.A(wb_dat_o[2]), .B(temp1[2]), .C(n5470), .D(n5288), 
         .Z(n_temp1[2])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_78.init = 16'ha0ec;
    FD1P3IX GPI_DAT__i3 (.D(X13_FP2x_ESt_c), .SP(clk_enable_16), .CD(n5476), 
            .CK(clk), .Q(GPI_DAT[3]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(581[8] 587[15])
    defparam GPI_DAT__i3.GSR = "ENABLED";
    LUT4 i1_2_lut_3_lut_4_lut_adj_79 (.A(wb_ack_o), .B(wb_adr_i[6]), .C(n_temp1_7__N_93), 
         .D(wb_dat_o[2]), .Z(n5248)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_79.init = 16'h8000;
    LUT4 i1135_2_lut_4_lut (.A(n5197), .B(n_temp1_7__N_96), .C(n_temp1_7__N_83), 
         .D(clk_enable_17), .Z(n_wb_we_i)) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1135_2_lut_4_lut.init = 16'h00fe;
    LUT4 i1_4_lut_adj_80 (.A(data0[1]), .B(temp1[6]), .C(n33), .D(n6_adj_679), 
         .Z(data0_7__N_436[1])) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[14:19])
    defparam i1_4_lut_adj_80.init = 16'hb3a0;
    LUT4 i1_4_lut_adj_81 (.A(wb_dat_o[1]), .B(temp1[1]), .C(n5470), .D(n5288), 
         .Z(n_temp1[1])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_81.init = 16'ha0ec;
    LUT4 i1_4_lut_adj_82 (.A(data0[5]), .B(temp1[6]), .C(n33), .D(n6_adj_654), 
         .Z(data0_7__N_436[5])) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[14:19])
    defparam i1_4_lut_adj_82.init = 16'hb3a0;
    LUT4 i18_4_lut (.A(n_temp1_7__N_97), .B(n3), .C(clk_enable_17), .D(n55), 
         .Z(n5039)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;
    defparam i18_4_lut.init = 16'hfaca;
    LUT4 i1_2_lut_3_lut_4_lut_adj_83 (.A(wb_ack_o), .B(wb_adr_i[6]), .C(data0[6]), 
         .D(n_temp1_7__N_96), .Z(n_wb_dat_i[6])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_83.init = 16'h7000;
    LUT4 i19_4_lut_adj_84 (.A(n3698), .B(data0[1]), .C(temp1[5]), .D(GPI_DAT[1]), 
         .Z(n6_adj_679)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[14:19])
    defparam i19_4_lut_adj_84.init = 16'hcac0;
    LUT4 i712_3_lut_4_lut (.A(wb_ack_o), .B(wb_adr_i[6]), .C(n_state_7__N_578[4]), 
         .D(wb_dat_o[4]), .Z(n2891)) /* synthesis lut_function=(!(A (B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i712_3_lut_4_lut.init = 16'h77f7;
    OB X13_E2C_M59_pad (.I(X13_E2C_M59_c_1), .O(X13_E2C_M59));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(30[3:14])
    LUT4 i775_3_lut_4_lut (.A(wb_ack_o), .B(wb_adr_i[6]), .C(n5480), .D(n15), 
         .Z(n2954)) /* synthesis lut_function=(((C (D))+!B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i775_3_lut_4_lut.init = 16'hf777;
    LUT4 mux_393_i4_3_lut_4_lut (.A(n4231), .B(clk_enable_17), .C(n1966), 
         .D(dat_count[3]), .Z(n_dat_count_7__N_154[3])) /* synthesis lut_function=(A (D)+!A (B (C)+!B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(1127[7] 1146[12])
    defparam mux_393_i4_3_lut_4_lut.init = 16'hfb40;
    LUT4 i1_4_lut_adj_85 (.A(data0[0]), .B(temp1[6]), .C(n33), .D(n6_adj_656), 
         .Z(data0_7__N_436[0])) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[14:19])
    defparam i1_4_lut_adj_85.init = 16'hb3a0;
    LUT4 i19_4_lut_adj_86 (.A(GPI_DAT[0]), .B(data0[0]), .C(temp1[5]), 
         .D(n3698), .Z(n6_adj_656)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[14:19])
    defparam i19_4_lut_adj_86.init = 16'hcac0;
    LUT4 i1_2_lut_3_lut_4_lut_adj_87 (.A(wb_ack_o), .B(wb_adr_i[6]), .C(data0[5]), 
         .D(n_temp1_7__N_96), .Z(n_wb_dat_i[5])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_87.init = 16'h7000;
    LUT4 i38_4_lut (.A(n_temp1_7__N_84), .B(n_temp1_7__N_83), .C(clk_enable_17), 
         .D(n22), .Z(n5033)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i38_4_lut.init = 16'hfaca;
    LUT4 i3_4_lut_adj_88 (.A(n_dat_count_7__N_154[3]), .B(n6_adj_685), .C(n2), 
         .D(n_temp1_7__N_96), .Z(n_dat_count[3])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i3_4_lut_adj_88.init = 16'hfefc;
    LUT4 i1_2_lut_3_lut_4_lut_adj_89 (.A(n5464), .B(temp1[0]), .C(n62), 
         .D(n_temp1_7__N_90), .Z(n5206)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;
    defparam i1_2_lut_3_lut_4_lut_adj_89.init = 16'he000;
    LUT4 i1_4_lut_4_lut_adj_90 (.A(clk_enable_17), .B(n_state_7__N_578[4]), 
         .C(n5220), .D(n_temp1_7__N_98), .Z(n5041)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_4_lut_adj_90.init = 16'hfda0;
    LUT4 i878_2_lut_rep_56_3_lut (.A(wb_ack_o), .B(wb_adr_i[6]), .C(n4231), 
         .Z(n5460)) /* synthesis lut_function=(!(((C)+!B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i878_2_lut_rep_56_3_lut.init = 16'h0808;
    FD1P3IX GPI_DAT__i2 (.D(FP_UsrSW3_c), .SP(clk_enable_16), .CD(n5476), 
            .CK(clk), .Q(GPI_DAT[2]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(581[8] 587[15])
    defparam GPI_DAT__i2.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i1 (.D(FP_UsrSW2_c), .SP(clk_enable_16), .CD(n5476), 
            .CK(clk), .Q(GPI_DAT[1]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(581[8] 587[15])
    defparam GPI_DAT__i1.GSR = "ENABLED";
    FD1P3IX GPI_DAT__i0 (.D(FP_UsrSW1_c), .SP(clk_enable_16), .CD(n5476), 
            .CK(clk), .Q(GPI_DAT[0]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(581[8] 587[15])
    defparam GPI_DAT__i0.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i24 (.D(n106), .CK(clk), .Q(resetcounter[24])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i24.GSR = "ENABLED";
    LUT4 i1_4_lut_adj_91 (.A(n33), .B(temp1[6]), .C(data0[4]), .D(n30), 
         .Z(data0_7__N_436[4])) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;
    defparam i1_4_lut_adj_91.init = 16'hb3a0;
    LUT4 i1_2_lut_3_lut_4_lut_adj_92 (.A(wb_ack_o), .B(wb_adr_i[6]), .C(data0[1]), 
         .D(n_temp1_7__N_96), .Z(n_wb_dat_i[1])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_92.init = 16'h7000;
    LUT4 temp1_1__bdd_3_lut (.A(temp1[0]), .B(temp1[2]), .C(temp1[3]), 
         .Z(n5393)) /* synthesis lut_function=(((C)+!B)+!A) */ ;
    defparam temp1_1__bdd_3_lut.init = 16'hf7f7;
    LUT4 i19_4_lut_adj_93 (.A(GPI_DAT[5]), .B(data0[5]), .C(temp1[5]), 
         .D(n3698), .Z(n6_adj_654)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[14:19])
    defparam i19_4_lut_adj_93.init = 16'hcac0;
    LUT4 i1_2_lut_3_lut_adj_94 (.A(wb_ack_o), .B(wb_adr_i[6]), .C(wb_dat_o[4]), 
         .Z(n15_adj_683)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1_2_lut_3_lut_adj_94.init = 16'h8080;
    LUT4 i1_2_lut_3_lut_adj_95 (.A(wb_ack_o), .B(wb_adr_i[6]), .C(dat_rdy_N_613), 
         .Z(dat_rdy_N_611)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1_2_lut_3_lut_adj_95.init = 16'h8080;
    LUT4 i1075_2_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_adr_i[6]), .C(n_temp1_7__N_82), 
         .D(n_temp1_7__N_83), .Z(n3446)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A (C+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1075_2_lut_3_lut_4_lut.init = 16'hf7f0;
    LUT4 resetnefb_I_0_1_lut_rep_72 (.A(resetnefb), .Z(n5476)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(563[16:31])
    defparam resetnefb_I_0_1_lut_rep_72.init = 16'h5555;
    LUT4 i941_3_lut_4_lut_4_lut (.A(resetnefb), .B(reg_rdy), .C(n5464), 
         .D(n5471), .Z(clk_enable_16)) /* synthesis lut_function=(!(A ((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(563[16:31])
    defparam i941_3_lut_4_lut_4_lut.init = 16'h555d;
    LUT4 i940_4_lut_4_lut (.A(resetnefb), .B(n4_adj_665), .C(n5282), .D(n5465), 
         .Z(clk_enable_8)) /* synthesis lut_function=(!(A ((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(563[16:31])
    defparam i940_4_lut_4_lut.init = 16'h555d;
    LUT4 i1_3_lut_adj_96 (.A(n_state_7__N_578[4]), .B(n_temp1_7__N_98), 
         .C(n5223), .Z(n22)) /* synthesis lut_function=(!(A+!(B+(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_3_lut_adj_96.init = 16'h5454;
    FD1S3AX resetcounter_i24_917__i23 (.D(n107), .CK(clk), .Q(resetcounter[23])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i23.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i22 (.D(n108), .CK(clk), .Q(resetcounter[22])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i22.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i21 (.D(n109), .CK(clk), .Q(resetcounter[21])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i21.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i20 (.D(n110), .CK(clk), .Q(resetcounter[20])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i20.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i19 (.D(n111), .CK(clk), .Q(resetcounter[19])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i19.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i18 (.D(n112), .CK(clk), .Q(resetcounter[18])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i18.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i17 (.D(n113), .CK(clk), .Q(resetcounter[17])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i17.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i16 (.D(n114), .CK(clk), .Q(resetcounter[16])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i16.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i15 (.D(n115), .CK(clk), .Q(resetcounter[15])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i15.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i14 (.D(n116), .CK(clk), .Q(resetcounter[14])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i14.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i13 (.D(n117), .CK(clk), .Q(resetcounter[13])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i13.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i12 (.D(n118), .CK(clk), .Q(resetcounter[12])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i12.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i11 (.D(n119), .CK(clk), .Q(resetcounter[11])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i11.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i10 (.D(n120), .CK(clk), .Q(resetcounter[10])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i10.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i9 (.D(n121), .CK(clk), .Q(resetcounter[9])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i9.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i8 (.D(n122), .CK(clk), .Q(resetcounter[8])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i8.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i7 (.D(n123), .CK(clk), .Q(n18_adj_671)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i7.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i6 (.D(n124), .CK(clk), .Q(n19)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i6.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i5 (.D(n125), .CK(clk), .Q(n20_adj_672)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i5.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i4 (.D(n126), .CK(clk), .Q(n21_adj_673)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i4.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i3 (.D(n127), .CK(clk), .Q(n22_adj_674)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i3.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i2 (.D(n128), .CK(clk), .Q(n23)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i2.GSR = "ENABLED";
    FD1S3AX resetcounter_i24_917__i1 (.D(n129), .CK(clk), .Q(n24_adj_675)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917__i1.GSR = "ENABLED";
    FD1S3IX temp1__i7 (.D(n_temp1[7]), .CK(clk), .CD(n5476), .Q(temp1[7]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp1__i7.GSR = "ENABLED";
    FD1S3IX temp1__i6 (.D(n_temp1[6]), .CK(clk), .CD(n5476), .Q(temp1[6]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp1__i6.GSR = "ENABLED";
    FD1S3IX temp1__i5 (.D(n_temp1[5]), .CK(clk), .CD(n5476), .Q(temp1[5]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp1__i5.GSR = "ENABLED";
    FD1S3IX temp1__i4 (.D(n_temp1[4]), .CK(clk), .CD(n5476), .Q(temp1[4]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp1__i4.GSR = "ENABLED";
    FD1S3IX temp1__i3 (.D(n_temp1[3]), .CK(clk), .CD(n5476), .Q(temp1[3]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp1__i3.GSR = "ENABLED";
    FD1S3IX temp1__i2 (.D(n_temp1[2]), .CK(clk), .CD(n5476), .Q(temp1[2]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp1__i2.GSR = "ENABLED";
    FD1S3IX temp1__i1 (.D(n_temp1[1]), .CK(clk), .CD(n5476), .Q(temp1[1]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam temp1__i1.GSR = "ENABLED";
    FD1S3AX c_state_FSM_i19 (.D(n5476), .CK(clk), .Q(n_temp1_7__N_82));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i19.GSR = "ENABLED";
    LUT4 i2_3_lut_rep_73 (.A(resetcounter[24]), .B(resetcounter[23]), .C(resetcounter[22]), 
         .Z(n5477)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(443[6:29])
    defparam i2_3_lut_rep_73.init = 16'h8080;
    LUT4 i1_2_lut_rep_54_3_lut_4_lut (.A(n5465), .B(n5472), .C(n_temp1_7__N_90), 
         .D(temp1[0]), .Z(n5458)) /* synthesis lut_function=(A (C)+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(684[58:76])
    defparam i1_2_lut_rep_54_3_lut_4_lut.init = 16'hf0e0;
    LUT4 i1_2_lut_4_lut_adj_97 (.A(resetcounter[24]), .B(resetcounter[23]), 
         .C(resetcounter[22]), .D(n4312), .Z(resetcounter_24__N_603)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(443[6:29])
    defparam i1_2_lut_4_lut_adj_97.init = 16'h8000;
    LUT4 i2_3_lut_rep_57 (.A(n5462), .B(n_state_7__N_522[3]), .C(n4231), 
         .Z(n5461)) /* synthesis lut_function=(A (B (C))) */ ;
    defparam i2_3_lut_rep_57.init = 16'h8080;
    LUT4 i1_2_lut_4_lut_adj_98 (.A(n5462), .B(n_state_7__N_522[3]), .C(n4231), 
         .D(clk_enable_17), .Z(n4)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(D))+!A !(D))) */ ;
    defparam i1_2_lut_4_lut_adj_98.init = 16'h7f00;
    LUT4 i1_2_lut_rep_74 (.A(temp1[7]), .B(temp1[4]), .Z(n5478)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(501[6] 507[15])
    defparam i1_2_lut_rep_74.init = 16'heeee;
    LUT4 i1_2_lut_3_lut_adj_99 (.A(n15), .B(n4231), .C(n_temp1_7__N_99), 
         .Z(n5241)) /* synthesis lut_function=(A (C)+!A (B (C))) */ ;
    defparam i1_2_lut_3_lut_adj_99.init = 16'he0e0;
    LUT4 i1_4_lut_adj_100 (.A(n5478), .B(temp1[5]), .C(n5394), .D(n36), 
         .Z(n33)) /* synthesis lut_function=(A+(B (C)+!B (C+(D)))) */ ;
    defparam i1_4_lut_adj_100.init = 16'hfbfa;
    LUT4 i1_2_lut_adj_101 (.A(temp1[6]), .B(temp1[0]), .Z(n36)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(501[6] 507[15])
    defparam i1_2_lut_adj_101.init = 16'hbbbb;
    LUT4 i1071_4_lut_4_lut (.A(clk_enable_17), .B(n_state_7__N_578[4]), 
         .C(n_temp1_7__N_84), .D(n_temp1_7__N_85), .Z(n3442)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1071_4_lut_4_lut.init = 16'hfda0;
    LUT4 i2_4_lut_adj_102 (.A(dat_count[3]), .B(n5271), .C(reg_rdy_N_609), 
         .D(n5463), .Z(n6_adj_685)) /* synthesis lut_function=(A ((C)+!B)+!A (C (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i2_4_lut_adj_102.init = 16'hf2a2;
    CCU2D resetcounter_i24_917_add_4_19 (.A0(resetcounter[17]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(resetcounter[18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n4890), .COUT(n4891), .S0(n113), 
          .S1(n112));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(445[20:32])
    defparam resetcounter_i24_917_add_4_19.INIT0 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_19.INIT1 = 16'hfaaa;
    defparam resetcounter_i24_917_add_4_19.INJECT1_0 = "NO";
    defparam resetcounter_i24_917_add_4_19.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_103 (.A(n_state_7__N_522[3]), .B(n62), .C(reg_rdy_N_609), 
         .D(n5458), .Z(n4_adj_684)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(294[17:24])
    defparam i1_4_lut_adj_103.init = 16'hb3a0;
    LUT4 i1_4_lut_adj_104 (.A(n_temp1_7__N_94), .B(wb_dat_o[2]), .C(wb_dat_o[4]), 
         .D(n24), .Z(n5223)) /* synthesis lut_function=(!(A (B (C)+!B !((D)+!C))+!A (B+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_104.init = 16'h3b0a;
    LUT4 i8_4_lut (.A(n15_adj_653), .B(X13_C2E_M61_c), .C(n14), .D(X13_FP2x_ESt_c), 
         .Z(dummy_signal)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(389[17] 392[14])
    defparam i8_4_lut.init = 16'h8000;
    LUT4 i6_4_lut_adj_105 (.A(FP_UsrSW2_c), .B(PG_VIN_c), .C(FP_UsrSW3_c), 
         .D(FP_UsrSW1_c), .Z(n15_adj_653)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(389[17] 392[14])
    defparam i6_4_lut_adj_105.init = 16'h8000;
    OB X13_E2C_M58_pad (.I(X13_E2C_M58_c_2), .O(X13_E2C_M58));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(31[3:14])
    OBZ X13_E2C_M55_pad (.I(GND_net), .T(VCC_net), .O(X13_E2C_M55));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(399[1:12])
    LUT4 i2_4_lut_adj_106 (.A(n5241), .B(n5243), .C(n_temp1_7__N_91), 
         .D(n_temp1_7__N_93), .Z(n24)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i2_4_lut_adj_106.init = 16'hfffe;
    OBZ X13_E2C_M54_pad (.I(GND_net), .T(VCC_net), .O(X13_E2C_M54));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(398[1:12])
    OBZ Xc1_CollFlt_pad (.I(GND_net), .T(VCC_net), .O(Xc1_CollFlt));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(403[1:12])
    OB FP_UsrLED_pad_4 (.I(FP_UsrLED_c_4), .O(FP_UsrLED[4]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(60[3:12])
    OB FP_UsrLED_pad_3 (.I(FP_UsrLED_c_3), .O(FP_UsrLED[3]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(60[3:12])
    OB FP_UsrLED_pad_2 (.I(FP_UsrLED_c_2), .O(FP_UsrLED[2]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(60[3:12])
    OB FP_UsrLED_pad_1 (.I(FP_UsrLED_c_1), .O(FP_UsrLED[1]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(60[3:12])
    OB FP_SysLEDs_pad (.I(FP_SysLEDs_c_3), .O(FP_SysLEDs));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(64[3:13])
    OB SPI0_SelnSYSUSRnCS_pad (.I(GND_net), .O(SPI0_SelnSYSUSRnCS));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(70[3:21])
    OBZ DIG_00_Ch5_pad (.I(GND_net), .T(VCC_net), .O(DIG_00_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    LUT4 select_897_Select_3_i2_4_lut (.A(n1966), .B(dat_rdy_N_613), .C(dat_count[3]), 
         .D(n4245), .Z(n2)) /* synthesis lut_function=(A (B (C+(D)))+!A !(((D)+!C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam select_897_Select_3_i2_4_lut.init = 16'h88c0;
    OBZ DIG_01_Ch5_pad (.I(GND_net), .T(VCC_net), .O(DIG_01_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    LUT4 i1_4_lut_4_lut_adj_107 (.A(n15), .B(n4231), .C(n_temp1_7__N_100), 
         .D(n_temp1_7__N_99), .Z(n55)) /* synthesis lut_function=(!(A+!(B (C)+!B (C+(D))))) */ ;
    defparam i1_4_lut_4_lut_adj_107.init = 16'h5150;
    OBZ DIG_02_Ch5_pad (.I(GND_net), .T(VCC_net), .O(DIG_02_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    OBZ DIG_03_Ch5_pad (.I(GND_net), .T(VCC_net), .O(DIG_03_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    OBZ DIG_04_Ch5_pad (.I(GND_net), .T(VCC_net), .O(DIG_04_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    OBZ DIG_05_Ch5_pad (.I(GND_net), .T(VCC_net), .O(DIG_05_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    OBZ DIG_24_Ch5_pad (.I(GND_net), .T(VCC_net), .O(DIG_24_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    OBZ DIG_25_Ch5_pad (.I(GND_net), .T(VCC_net), .O(DIG_25_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    LUT4 i5_4_lut (.A(n31), .B(S2C_S2_c), .C(n32), .D(PPn_VIN_c), .Z(n14)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(389[17] 392[14])
    defparam i5_4_lut.init = 16'h8000;
    OBZ DIG_26_Ch5_pad (.I(GND_net), .T(VCC_net), .O(DIG_26_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    OBZ DIG_27_Ch5_pad (.I(GND_net), .T(VCC_net), .O(DIG_27_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    OBZ DIG_28_Ch5_pad (.I(GND_net), .T(VCC_net), .O(DIG_28_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    OBZ DIG_29_Ch5_pad (.I(GND_net), .T(VCC_net), .O(DIG_29_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    OBZ S2C_FlexIO_IO0_pad (.I(GND_net), .T(VCC_net), .O(S2C_FlexIO_IO0));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    OBZ S2C_FlexIO_IO1_pad (.I(GND_net), .T(VCC_net), .O(S2C_FlexIO_IO1));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    OBZ S2C_FlexIO_IO2_pad (.I(GND_net), .T(VCC_net), .O(S2C_FlexIO_IO2));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    FD1S3IX c_state_FSM_i18 (.D(n3446), .CK(clk), .CD(n5476), .Q(n_temp1_7__N_83));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i18.GSR = "ENABLED";
    OBZ S2C_FlexIO_IO3_pad (.I(GND_net), .T(VCC_net), .O(S2C_FlexIO_IO3));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    FD1S3IX c_state_FSM_i17 (.D(n5033), .CK(clk), .CD(n5476), .Q(n_temp1_7__N_84));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i17.GSR = "ENABLED";
    OBZ S2C_FlexIO_IO4_pad (.I(GND_net), .T(VCC_net), .O(S2C_FlexIO_IO4));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    FD1S3IX c_state_FSM_i16 (.D(n3442), .CK(clk), .CD(n5476), .Q(n_temp1_7__N_85));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i16.GSR = "ENABLED";
    OBZ S2C_FlexIO_IO5_pad (.I(GND_net), .T(VCC_net), .O(S2C_FlexIO_IO5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    FD1S3IX c_state_FSM_i15 (.D(n5189), .CK(clk), .CD(n5476), .Q(n_temp1_7__N_86));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i15.GSR = "ENABLED";
    OBZ S2C_FlexIO_IO6_pad (.I(GND_net), .T(VCC_net), .O(S2C_FlexIO_IO6));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    FD1P3IX c_state_FSM_i14 (.D(n_temp1_7__N_86), .SP(clk_enable_17), .CD(n5476), 
            .CK(clk), .Q(n_temp1_7__N_87));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam c_state_FSM_i14.GSR = "ENABLED";
    OBZ S2C_FlexIO_IO7_pad (.I(GND_net), .T(VCC_net), .O(S2C_FlexIO_IO7));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(405[1:17])
    IB X13_FP2x_ESt_pad (.I(X13_FP2x_ESt), .O(X13_FP2x_ESt_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(27[3:15])
    IB X13_C2E_M61_pad (.I(X13_C2E_M61), .O(X13_C2E_M61_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(28[3:14])
    IB X13_C2E_M60_pad (.I(X13_C2E_M60), .O(X13_C2E_M60_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(29[3:14])
    IB X13_C2E_M57_pad (.I(X13_C2E_M57), .O(X13_C2E_M57_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(37[3:14])
    IB X13_C2E_M56_pad (.I(X13_C2E_M56), .O(X13_C2E_M56_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(39[3:14])
    IB X13_C2E_M53_pad (.I(X13_C2E_M53), .O(X13_C2E_M53_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(40[3:14])
    IB X13_C2E_M52_pad (.I(X13_C2E_M52), .O(X13_C2E_M52_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(43[3:14])
    IB Xc1_SPICLK_pad (.I(Xc1_SPICLK), .O(Xc1_SPICLK_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(44[3:13])
    IB Xc1_MOSI_pad (.I(Xc1_MOSI), .O(Xc1_MOSI_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(45[3:11])
    IB Xc1_CS_A1_pad (.I(Xc1_CS_A1), .O(Xc1_CS_A1_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(46[3:12])
    IB Xc1_CS_A2_pad (.I(Xc1_CS_A2), .O(Xc1_CS_A2_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(47[3:12])
    IB Xc1_CS_A3_pad (.I(Xc1_CS_A3), .O(Xc1_CS_A3_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(48[3:12])
    IB Xc1_PSANL_pad (.I(Xc1_PSANL), .O(Xc1_PSANL_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(53[3:12])
    IB RTC_FOUT_pad (.I(RTC_FOUT), .O(RTC_FOUT_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(54[3:11])
    IB S2C_S2_pad (.I(S2C_S2), .O(S2C_S2_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(56[3:9])
    IB S2C_S3_pad (.I(S2C_S3), .O(S2C_S3_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(57[3:9])
    IB FP_UsrSW1_pad (.I(FP_UsrSW1), .O(FP_UsrSW1_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(60[55:64])
    IB FP_UsrSW2_pad (.I(FP_UsrSW2), .O(FP_UsrSW2_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(61[3:12])
    IB FP_UsrSW3_pad (.I(FP_UsrSW3), .O(FP_UsrSW3_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(62[3:12])
    IB FP_UsrSW4_pad (.I(FP_UsrSW4), .O(FP_UsrSW4_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(63[3:12])
    IB PG_VIN_pad (.I(PG_VIN), .O(PG_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(65[3:9])
    IB PPn_VIN_pad (.I(PPn_VIN), .O(PPn_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(66[3:10])
    IB TDnSHDN_pad (.I(TDnSHDN), .O(TDnSHDN_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(67[3:10])
    IB TDnFFnFS_pad (.I(TDnFFnFS), .O(TDnFFnFS_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(68[3:11])
    IB TDnALERT_pad (.I(TDnALERT), .O(TDnALERT_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(69[3:11])
    IB SPI0_nCS_USR_pad (.I(SPI0_nCS_USR), .O(SPI0_nCS_USR_c));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(71[3:15])
    LUT4 i2_2_lut_adj_108 (.A(dat_count[2]), .B(dat_count[4]), .Z(n10_adj_687)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(1204[13:35])
    defparam i2_2_lut_adj_108.init = 16'heeee;
    LUT4 i14_4_lut (.A(Xc1_MOSI_c), .B(n28), .C(n20), .D(Xc1_CS_A2_c), 
         .Z(n31)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(389[17] 392[14])
    defparam i14_4_lut.init = 16'h8000;
    LUT4 i2_4_lut_adj_109 (.A(dat_count[2]), .B(n12), .C(n17), .D(n15_adj_655), 
         .Z(n_dat_count[2])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i2_4_lut_adj_109.init = 16'hffec;
    LUT4 i1_4_lut_adj_110 (.A(n_temp1_7__N_96), .B(dat_count[2]), .C(n1967), 
         .D(n5460), .Z(n12)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_110.init = 16'ha088;
    LUT4 i1_4_lut_adj_111 (.A(dat_rdy_N_613), .B(n1967), .C(dat_count[2]), 
         .D(n4245), .Z(n15_adj_655)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_111.init = 16'h88a0;
    LUT4 i1_4_lut_adj_112 (.A(n_temp1_7__N_97), .B(n4231), .C(n4_adj_657), 
         .D(n4_adj_686), .Z(n5220)) /* synthesis lut_function=(A+(B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_112.init = 16'hfefa;
    LUT4 i1_3_lut_adj_113 (.A(reg_rdy_N_609), .B(n21), .C(n_state_7__N_522[3]), 
         .Z(n4_adj_657)) /* synthesis lut_function=(A (B+!(C))+!A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_3_lut_adj_113.init = 16'hcece;
    LUT4 i2_3_lut_4_lut_adj_114 (.A(temp1[7]), .B(temp1[4]), .C(temp1[5]), 
         .D(temp1[6]), .Z(n14_adj_652)) /* synthesis lut_function=(A+(B+!(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(501[6] 507[15])
    defparam i2_3_lut_4_lut_adj_114.init = 16'hefff;
    LUT4 i15_4_lut (.A(n29), .B(X13_C2E_M53_c), .C(n26), .D(TDnALERT_c), 
         .Z(n32)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(389[17] 392[14])
    defparam i15_4_lut.init = 16'h8000;
    LUT4 i12_4_lut (.A(Xc1_CS_A1_c), .B(TDnSHDN_c), .C(TDnFFnFS_c), .D(RTC_FOUT_c), 
         .Z(n29)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(389[17] 392[14])
    defparam i12_4_lut.init = 16'h8000;
    LUT4 i9_3_lut (.A(FP_UsrSW4_c), .B(Xc1_PSANL_c), .C(X13_C2E_M56_c), 
         .Z(n26)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(389[17] 392[14])
    defparam i9_3_lut.init = 16'h8080;
    LUT4 select_891_Select_7_i11_3_lut_4_lut_4_lut (.A(n_temp1_7__N_96), .B(clk_enable_17), 
         .C(data0[7]), .D(n_temp1_7__N_83), .Z(n_wb_dat_i[7])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A (B+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam select_891_Select_7_i11_3_lut_4_lut_4_lut.init = 16'h3320;
    LUT4 i1_2_lut_rep_61_3_lut_4_lut (.A(temp1[7]), .B(temp1[4]), .C(temp1[6]), 
         .D(temp1[5]), .Z(n5465)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(501[6] 507[15])
    defparam i1_2_lut_rep_61_3_lut_4_lut.init = 16'hfffe;
    LUT4 i11_4_lut (.A(X13_C2E_M60_c), .B(X13_C2E_M52_c), .C(X13_C2E_M57_c), 
         .D(Xc1_SPICLK_c), .Z(n28)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(389[17] 392[14])
    defparam i11_4_lut.init = 16'h8000;
    LUT4 i3_2_lut (.A(Xc1_CS_A3_c), .B(S2C_S3_c), .Z(n20)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(389[17] 392[14])
    defparam i3_2_lut.init = 16'h8888;
    LUT4 i5_3_lut_4_lut (.A(temp1[7]), .B(temp1[4]), .C(n10_adj_663), 
         .D(temp1[2]), .Z(n18)) /* synthesis lut_function=(!(A+(B+((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(501[6] 507[15])
    defparam i5_3_lut_4_lut.init = 16'h0010;
    LUT4 i11_4_lut_adj_115 (.A(n_temp1_7__N_86), .B(n_temp1_7__N_85), .C(clk_enable_17), 
         .D(n_state_7__N_578[4]), .Z(n5189)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i11_4_lut_adj_115.init = 16'h0aca;
    LUT4 temp1_7__I_0_569_i9_2_lut (.A(temp1[0]), .B(temp1[1]), .Z(n9)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(688[34:52])
    defparam temp1_7__I_0_569_i9_2_lut.init = 16'hbbbb;
    LUT4 temp1_7__I_0_566_i9_2_lut_rep_67 (.A(temp1[0]), .B(temp1[1]), .Z(n5471)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(685[58:76])
    defparam temp1_7__I_0_566_i9_2_lut_rep_67.init = 16'hdddd;
    LUT4 i2_4_lut_adj_116 (.A(n62), .B(n5465), .C(n5459), .D(n5267), 
         .Z(n4290)) /* synthesis lut_function=(A (B (C)+!B (C (D)))) */ ;
    defparam i2_4_lut_adj_116.init = 16'ha080;
    LUT4 i1_2_lut_adj_117 (.A(wb_dat_o[2]), .B(n_temp1_7__N_99), .Z(n4_adj_686)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_2_lut_adj_117.init = 16'h8888;
    LUT4 i71_3_lut_4_lut_3_lut (.A(temp1[2]), .B(temp1[3]), .C(temp1[1]), 
         .Z(n68)) /* synthesis lut_function=(A (B+(C))+!A !(B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(505[13:23])
    defparam i71_3_lut_4_lut_3_lut.init = 16'hbdbd;
    LUT4 i2_4_lut_adj_118 (.A(wb_dat_o[2]), .B(n4_adj_682), .C(clk_enable_17), 
         .D(n5243), .Z(n4942)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i2_4_lut_adj_118.init = 16'heccc;
    LUT4 i1050_4_lut (.A(n_temp1_7__N_94), .B(n4290), .C(n2891), .D(n5248), 
         .Z(n3418)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1050_4_lut.init = 16'hb3a0;
    LUT4 i1_4_lut_adj_119 (.A(n4290), .B(dat_rdy_N_613), .C(n5248), .D(clk_enable_17), 
         .Z(n4_adj_682)) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_119.init = 16'ha0ec;
    LUT4 i1_2_lut_adj_120 (.A(n_temp1_7__N_100), .B(n15), .Z(n5243)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_2_lut_adj_120.init = 16'h8888;
    LUT4 i1_4_lut_adj_121 (.A(n_temp1_7__N_90), .B(n5461), .C(n5427), 
         .D(n62), .Z(n21)) /* synthesis lut_function=(A (B ((D)+!C)+!B !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_121.init = 16'h8a0a;
    LUT4 i2_3_lut_4_lut_adj_122 (.A(temp1[2]), .B(temp1[3]), .C(temp1[0]), 
         .D(temp1[1]), .Z(n5267)) /* synthesis lut_function=(A+!(B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(505[13:23])
    defparam i2_3_lut_4_lut_adj_122.init = 16'hbfff;
    LUT4 temp1_7__I_0_566_i10_2_lut_rep_70 (.A(temp1[2]), .B(temp1[3]), 
         .Z(n5474)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(685[58:76])
    defparam temp1_7__I_0_566_i10_2_lut_rep_70.init = 16'heeee;
    LUT4 i1_2_lut_rep_62_3_lut (.A(temp1[7]), .B(temp1[4]), .C(temp1[5]), 
         .Z(n5466)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(501[6] 507[15])
    defparam i1_2_lut_rep_62_3_lut.init = 16'hfefe;
    LUT4 i1081_4_lut (.A(n_temp1_7__N_100), .B(dat_rdy_N_613), .C(n2954), 
         .D(n4245), .Z(n3452)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1081_4_lut.init = 16'heca0;
    LUT4 i2874_2_lut_3_lut_4_lut (.A(temp1[2]), .B(temp1[3]), .C(temp1[1]), 
         .D(temp1[0]), .Z(n5282)) /* synthesis lut_function=(A+(B+(C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(685[58:76])
    defparam i2874_2_lut_3_lut_4_lut.init = 16'hfeff;
    LUT4 i1_2_lut_rep_75 (.A(dat_rdy_N_613), .B(reg_rdy_N_609), .Z(n5479)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_rep_75.init = 16'heeee;
    LUT4 i1782_4_lut (.A(n3698), .B(data0[4]), .C(temp1[5]), .D(GPI_DAT[4]), 
         .Z(n30)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[14:19])
    defparam i1782_4_lut.init = 16'hcac0;
    LUT4 wb_ack_o_I_0_2_lut_rep_71 (.A(wb_ack_o), .B(wb_adr_i[6]), .Z(clk_enable_17)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam wb_ack_o_I_0_2_lut_rep_71.init = 16'h8888;
    LUT4 i1_2_lut_adj_123 (.A(temp2[0]), .B(dat_rdy_del), .Z(n4_adj_665)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i1_2_lut_adj_123.init = 16'h4444;
    LUT4 i2_4_lut_adj_124 (.A(dat_count[7]), .B(n12_adj_660), .C(n17), 
         .D(n15_adj_658), .Z(n_dat_count[7])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i2_4_lut_adj_124.init = 16'hffec;
    LUT4 temp1_1__bdd_4_lut (.A(temp1[5]), .B(temp1[0]), .C(temp1[2]), 
         .D(temp1[3]), .Z(n5392)) /* synthesis lut_function=(A (B+(C+!(D)))+!A (C+!(D))) */ ;
    defparam temp1_1__bdd_4_lut.init = 16'hf8ff;
    LUT4 i1_4_lut_adj_125 (.A(n_temp1_7__N_96), .B(dat_count[7]), .C(n1962), 
         .D(n5460), .Z(n12_adj_660)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_125.init = 16'ha088;
    LUT4 i1_2_lut_rep_55_3_lut_4_lut (.A(temp1[6]), .B(n5466), .C(n5471), 
         .D(n5472), .Z(n5459)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(514[1] 529[11])
    defparam i1_2_lut_rep_55_3_lut_4_lut.init = 16'hfffe;
    LUT4 i1_4_lut_adj_126 (.A(dat_rdy_N_613), .B(n1962), .C(dat_count[7]), 
         .D(n4245), .Z(n15_adj_658)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_126.init = 16'h88a0;
    LUT4 i2880_3_lut_4_lut (.A(wb_ack_o), .B(wb_adr_i[6]), .C(n_temp1_7__N_88), 
         .D(n_temp1_7__N_89), .Z(n5288)) /* synthesis lut_function=(A (B (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i2880_3_lut_4_lut.init = 16'h8880;
    LUT4 i1120_3_lut_4_lut (.A(wb_ack_o), .B(wb_adr_i[6]), .C(n3724), 
         .D(n_temp1_7__N_96), .Z(n_wb_adr_i[2])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1120_3_lut_4_lut.init = 16'h7770;
    LUT4 i1882_2_lut_rep_59_3_lut (.A(wb_ack_o), .B(wb_adr_i[6]), .C(n_state_7__N_522[3]), 
         .Z(n5463)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1882_2_lut_rep_59_3_lut.init = 16'h8080;
    PFUMX i2918 (.BLUT(n5393), .ALUT(n5392), .C0(temp1[1]), .Z(n5394));
    LUT4 i2_4_lut_adj_127 (.A(dat_count[6]), .B(n12_adj_669), .C(n17), 
         .D(n15_adj_668), .Z(n_dat_count[6])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i2_4_lut_adj_127.init = 16'hffec;
    LUT4 i1112_3_lut_4_lut (.A(wb_ack_o), .B(wb_adr_i[6]), .C(n5197), 
         .D(n3724), .Z(n_wb_adr_i[0])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1112_3_lut_4_lut.init = 16'h7770;
    LUT4 i1_4_lut_adj_128 (.A(n_temp1_7__N_96), .B(dat_count[6]), .C(n1963), 
         .D(n5460), .Z(n12_adj_669)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_128.init = 16'ha088;
    LUT4 i808_2_lut_rep_66_3_lut (.A(wb_ack_o), .B(wb_adr_i[6]), .C(n_temp1_7__N_89), 
         .Z(n5470)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i808_2_lut_rep_66_3_lut.init = 16'h8080;
    LUT4 i1_4_lut_adj_129 (.A(dat_rdy_N_613), .B(dat_count[6]), .C(n1963), 
         .D(n4245), .Z(n15_adj_668)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_129.init = 16'ha088;
    LUT4 select_895_Select_1_i2_2_lut_3_lut (.A(wb_ack_o), .B(wb_adr_i[6]), 
         .C(n3202), .Z(n_wb_adr_i[1])) /* synthesis lut_function=(!(A (B+!(C))+!A !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam select_895_Select_1_i2_2_lut_3_lut.init = 16'h7070;
    LUT4 i1118_3_lut_4_lut (.A(wb_ack_o), .B(wb_adr_i[6]), .C(n5468), 
         .D(n3724), .Z(n_wb_adr_i[6])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1118_3_lut_4_lut.init = 16'h7770;
    LUT4 temp1_7__I_0_565_i10_2_lut_rep_68 (.A(temp1[2]), .B(temp1[3]), 
         .Z(n5472)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(685[34:52])
    defparam temp1_7__I_0_565_i10_2_lut_rep_68.init = 16'hdddd;
    LUT4 i1_2_lut_3_lut_adj_130 (.A(wb_ack_o), .B(wb_adr_i[6]), .C(reg_rdy_N_609), 
         .Z(reg_rdy_N_607)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1_2_lut_3_lut_adj_130.init = 16'h8080;
    LUT4 i1_2_lut_3_lut_4_lut_adj_131 (.A(wb_ack_o), .B(wb_adr_i[6]), .C(data0[0]), 
         .D(n_temp1_7__N_96), .Z(n_wb_dat_i[0])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_131.init = 16'h7000;
    LUT4 i2_4_lut_adj_132 (.A(dat_count[5]), .B(n12_adj_661), .C(n17), 
         .D(n15_adj_659), .Z(n_dat_count[5])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i2_4_lut_adj_132.init = 16'hffec;
    LUT4 i1_4_lut_adj_133 (.A(n_temp1_7__N_96), .B(dat_count[5]), .C(n1964), 
         .D(n5460), .Z(n12_adj_661)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_133.init = 16'ha088;
    LUT4 i1_4_lut_adj_134 (.A(dat_rdy_N_613), .B(n1964), .C(dat_count[5]), 
         .D(n4245), .Z(n15_adj_659)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_134.init = 16'h88a0;
    LUT4 i2_4_lut_adj_135 (.A(dat_count[4]), .B(n12_adj_677), .C(n17), 
         .D(n15_adj_676), .Z(n_dat_count[4])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i2_4_lut_adj_135.init = 16'hffec;
    LUT4 i7_4_lut (.A(dat_count[0]), .B(n14_adj_688), .C(n10_adj_687), 
         .D(dat_count[6]), .Z(n15)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(1204[13:35])
    defparam i7_4_lut.init = 16'hfffe;
    LUT4 i1_3_lut_4_lut_adj_136 (.A(wb_ack_o), .B(wb_adr_i[6]), .C(n5227), 
         .D(n_temp1_7__N_90), .Z(n_wb_dat_i[2])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(889[12:33])
    defparam i1_3_lut_4_lut_adj_136.init = 16'h7770;
    LUT4 i1_4_lut_adj_137 (.A(n_temp1_7__N_96), .B(dat_count[4]), .C(n1965), 
         .D(n5460), .Z(n12_adj_677)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_137.init = 16'ha088;
    LUT4 i1_4_lut_adj_138 (.A(dat_rdy_N_613), .B(dat_count[4]), .C(n1965), 
         .D(n4245), .Z(n15_adj_676)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_138.init = 16'ha088;
    LUT4 i1_4_lut_adj_139 (.A(n5469), .B(n_temp1_7__N_94), .C(n4989), 
         .D(n15_adj_683), .Z(n5222)) /* synthesis lut_function=(A+(B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(766[6] 1258[10])
    defparam i1_4_lut_adj_139.init = 16'hfefa;
    LUT4 i2_4_lut_adj_140 (.A(clk_enable_17), .B(n4231), .C(n5241), .D(wb_dat_o[2]), 
         .Z(n4989)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(1204[8] 1216[15])
    defparam i2_4_lut_adj_140.init = 16'h2000;
    VLO i1 (.Z(GND_net));
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    PFUMX i2939 (.BLUT(n5481), .ALUT(n5482), .C0(temp1[3]), .Z(n62));
    TSALL TSALL_INST (.TSALL(GND_net));
    
endmodule
//
// Verilog Description of module efb_vhdl
//

module efb_vhdl (clk, n5476, \wb_adr_i[6] , wb_we_i, GND_net, \wb_adr_i[2] , 
            \wb_adr_i[1] , \wb_adr_i[0] , wb_dat_i, \wb_dat_o[7] , \n_state_7__N_578[4] , 
            \wb_dat_o[5] , \wb_dat_o[4] , \wb_dat_o[3] , \wb_dat_o[2] , 
            \wb_dat_o[1] , \wb_dat_o[0] , wb_ack_o, SPI0_nCS_USR_c, 
            spi_mosi_oe, spi_mosi_o, spi_miso_oe, spi_miso_o, spi_clk_oe, 
            spi_clk_o, spi_mosi_i, spi_miso_i, spi_clk_i, i2c1_sdaoen, 
            i2c1_sdao, i2c1_scloen, i2c1_sclo, i2c1_sdai, i2c1_scli, 
            VCC_net) /* synthesis NGD_DRC_MASK=1 */ ;
    input clk;
    input n5476;
    input \wb_adr_i[6] ;
    input wb_we_i;
    input GND_net;
    input \wb_adr_i[2] ;
    input \wb_adr_i[1] ;
    input \wb_adr_i[0] ;
    input [7:0]wb_dat_i;
    output \wb_dat_o[7] ;
    output \n_state_7__N_578[4] ;
    output \wb_dat_o[5] ;
    output \wb_dat_o[4] ;
    output \wb_dat_o[3] ;
    output \wb_dat_o[2] ;
    output \wb_dat_o[1] ;
    output \wb_dat_o[0] ;
    output wb_ack_o;
    input SPI0_nCS_USR_c;
    output spi_mosi_oe;
    output spi_mosi_o;
    output spi_miso_oe;
    output spi_miso_o;
    output spi_clk_oe;
    output spi_clk_o;
    input spi_mosi_i;
    input spi_miso_i;
    input spi_clk_i;
    output i2c1_sdaoen;
    output i2c1_sdao;
    output i2c1_scloen;
    output i2c1_sclo;
    input i2c1_sdai;
    input i2c1_scli;
    input VCC_net;
    
    wire clk /* synthesis SET_AS_NETWORK=clk, is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(113[9:12])
    wire spi_clk_i /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/ipexpress/xo2/efb_vhdl.vhd(46[12:21])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/ipexpress/xo2/efb_vhdl.vhd(53[12:21])
    
    EFB EFBInst_0 (.WBCLKI(clk), .WBRSTI(n5476), .WBCYCI(\wb_adr_i[6] ), 
        .WBSTBI(\wb_adr_i[6] ), .WBWEI(wb_we_i), .WBADRI0(\wb_adr_i[0] ), 
        .WBADRI1(\wb_adr_i[1] ), .WBADRI2(\wb_adr_i[2] ), .WBADRI3(GND_net), 
        .WBADRI4(GND_net), .WBADRI5(GND_net), .WBADRI6(\wb_adr_i[6] ), 
        .WBADRI7(GND_net), .WBDATI0(wb_dat_i[0]), .WBDATI1(wb_dat_i[1]), 
        .WBDATI2(wb_dat_i[2]), .WBDATI3(wb_dat_i[3]), .WBDATI4(wb_dat_i[4]), 
        .WBDATI5(wb_dat_i[5]), .WBDATI6(wb_dat_i[6]), .WBDATI7(wb_dat_i[7]), 
        .I2C1SCLI(i2c1_scli), .I2C1SDAI(i2c1_sdai), .I2C2SCLI(GND_net), 
        .I2C2SDAI(GND_net), .SPISCKI(spi_clk_i), .SPIMISOI(spi_miso_i), 
        .SPIMOSII(spi_mosi_i), .SPISCSN(SPI0_nCS_USR_c), .TCCLKI(GND_net), 
        .TCRSTN(GND_net), .TCIC(GND_net), .UFMSN(VCC_net), .PLL0DATI0(GND_net), 
        .PLL0DATI1(GND_net), .PLL0DATI2(GND_net), .PLL0DATI3(GND_net), 
        .PLL0DATI4(GND_net), .PLL0DATI5(GND_net), .PLL0DATI6(GND_net), 
        .PLL0DATI7(GND_net), .PLL0ACKI(GND_net), .PLL1DATI0(GND_net), 
        .PLL1DATI1(GND_net), .PLL1DATI2(GND_net), .PLL1DATI3(GND_net), 
        .PLL1DATI4(GND_net), .PLL1DATI5(GND_net), .PLL1DATI6(GND_net), 
        .PLL1DATI7(GND_net), .PLL1ACKI(GND_net), .WBDATO0(\wb_dat_o[0] ), 
        .WBDATO1(\wb_dat_o[1] ), .WBDATO2(\wb_dat_o[2] ), .WBDATO3(\wb_dat_o[3] ), 
        .WBDATO4(\wb_dat_o[4] ), .WBDATO5(\wb_dat_o[5] ), .WBDATO6(\n_state_7__N_578[4] ), 
        .WBDATO7(\wb_dat_o[7] ), .WBACKO(wb_ack_o), .I2C1SCLO(i2c1_sclo), 
        .I2C1SCLOEN(i2c1_scloen), .I2C1SDAO(i2c1_sdao), .I2C1SDAOEN(i2c1_sdaoen), 
        .SPISCKO(spi_clk_o), .SPISCKEN(spi_clk_oe), .SPIMISOO(spi_miso_o), 
        .SPIMISOEN(spi_miso_oe), .SPIMOSIO(spi_mosi_o), .SPIMOSIEN(spi_mosi_oe)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=346, LSE_RLINE=346 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(346[7:15])
    defparam EFBInst_0.EFB_I2C1 = "ENABLED";
    defparam EFBInst_0.EFB_I2C2 = "DISABLED";
    defparam EFBInst_0.EFB_SPI = "ENABLED";
    defparam EFBInst_0.EFB_TC = "DISABLED";
    defparam EFBInst_0.EFB_TC_PORTMODE = "WB";
    defparam EFBInst_0.EFB_UFM = "DISABLED";
    defparam EFBInst_0.EFB_WB_CLK_FREQ = "10.0";
    defparam EFBInst_0.DEV_DENSITY = "2000L";
    defparam EFBInst_0.UFM_INIT_PAGES = 0;
    defparam EFBInst_0.UFM_INIT_START_PAGE = 0;
    defparam EFBInst_0.UFM_INIT_ALL_ZEROS = "ENABLED";
    defparam EFBInst_0.UFM_INIT_FILE_NAME = "NONE";
    defparam EFBInst_0.UFM_INIT_FILE_FORMAT = "HEX";
    defparam EFBInst_0.I2C1_ADDRESSING = "7BIT";
    defparam EFBInst_0.I2C2_ADDRESSING = "7BIT";
    defparam EFBInst_0.I2C1_SLAVE_ADDR = "0b1000001";
    defparam EFBInst_0.I2C2_SLAVE_ADDR = "0b1000001";
    defparam EFBInst_0.I2C1_BUS_PERF = "100kHz";
    defparam EFBInst_0.I2C2_BUS_PERF = "100kHz";
    defparam EFBInst_0.I2C1_CLK_DIVIDER = 25;
    defparam EFBInst_0.I2C2_CLK_DIVIDER = 1;
    defparam EFBInst_0.I2C1_GEN_CALL = "DISABLED";
    defparam EFBInst_0.I2C2_GEN_CALL = "DISABLED";
    defparam EFBInst_0.I2C1_WAKEUP = "DISABLED";
    defparam EFBInst_0.I2C2_WAKEUP = "DISABLED";
    defparam EFBInst_0.SPI_MODE = "SLAVE";
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

