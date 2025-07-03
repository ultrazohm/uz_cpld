// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Wed Jul 02 16:12:49 2025
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
            SPI0_SelnSYSUSRnCS, SPI0_nCS_USR, DIG_00_Ch5, DIG_01_Ch5, 
            DIG_02_Ch5, DIG_03_Ch5, DIG_04_Ch5, DIG_05_Ch5, DIG_24_Ch5, 
            DIG_25_Ch5, DIG_26_Ch5, DIG_27_Ch5, DIG_28_Ch5, DIG_29_Ch5, 
            S2C_FlexIO_IO0, S2C_FlexIO_IO1, S2C_FlexIO_IO2, S2C_FlexIO_IO3, 
            S2C_FlexIO_IO4, S2C_FlexIO_IO5, S2C_FlexIO_IO6, S2C_FlexIO_IO7, 
            IRQ);   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(8[8:16])
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
    
    wire clk /* synthesis is_clock=1, SET_AS_NETWORK=clk */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(113[9:12])
    wire dummy_signal /* synthesis noclip="on" */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(152[9:21])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/ipexpress/xo2/efb_vhdl.vhd(40[12:21])
    
    wire X13_FP2x_ESt_c, X13_C2E_M61_c, X13_C2E_M60_c, n5042, n5108, 
        X13_C2E_M57_c, X13_C2E_M56_c, X13_C2E_M53_c, X13_C2E_M52_c, 
        Xc1_SPICLK_c, Xc1_MOSI_c, Xc1_CS_A1_c, Xc1_CS_A2_c, Xc1_CS_A3_c, 
        Xc1_PSANL_c, RTC_FOUT_c, S2C_S2_c, S2C_S3_c, FP_UsrLED_c_4, 
        FP_UsrLED_c_3, FP_UsrLED_c_2, FP_UsrLED_c_1, FP_UsrSW1_c, FP_UsrSW2_c, 
        FP_UsrSW3_c, FP_UsrSW4_c, FP_SysLEDs_c_3, PG_VIN_c, PPn_VIN_c, 
        TDnSHDN_c, TDnFFnFS_c, TDnALERT_c;
    wire [7:0]wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(250[8:16])
    
    wire wb_stb_i;
    wire [7:0]wb_adr_i;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(253[8:16])
    
    wire wb_we_i;
    wire [7:0]wb_dat_o;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(255[8:16])
    
    wire wb_ack_o;
    wire [7:0]data0;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(267[8:13])
    wire [7:0]temp1;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[14:19])
    
    wire n4122, n3648;
    wire [7:0]temp2;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[20:25])
    wire [7:0]temp3;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(268[26:31])
    
    wire n3188, n3171, reg_rdy, dat_rdy, dat_rdy_del;
    wire [7:0]dat_count;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(277[22:31])
    wire [7:0]GPI_DAT;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(278[8:15])
    wire [7:0]n_wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(289[8:18])
    
    wire n5250, n4851, n3194, i2c1_sdao, n3170, n5249, n6, n46, 
        reg_rdy_N_484, reg_rdy_N_483, dat_rdy_N_487, dat_rdy_N_486;
    wire [7:0]data0_7__N_9;
    
    wire n48, GPI_DAT_7__N_339, n15, n32, i2c1_sdaoen, SPI0_SelnSYSUSRnCS_c, 
        n31, n10, n30, n4798, n68, n3182, n3186, n5070, n5248, 
        n5247, n5038, n3181, n2703, n48_adj_523, n50, n5246, n5245, 
        n3459, n3456, n5216, n36, n18, n33, n3531, n5215, n5214, 
        n3180, n14, n3377, n3068, n4837, n5244, n5243;
    wire [7:0]n_state_7__N_402;
    
    wire n3032, clk_enable_27, n2640, n5241, n3529, clk_enable_18, 
        n14_adj_524, n14_adj_525, n4, n30_adj_526, n10_adj_527, n10_adj_528, 
        clk_enable_28, n30_adj_529, n3, n5058, n13, n5, n30_adj_530, 
        n30_adj_531, n29;
    wire [7:0]n_wb_dat_i_7__N_125;
    
    wire n4918, n28;
    wire [7:0]n_dat_count_7__N_85;
    
    wire n5232, n3_adj_532, n2590, n5239, n5231;
    wire [7:0]n_state_7__N_458;
    
    wire n5092, n4_adj_533, n30_adj_534, n5238, n3220, n3222, clk_enable_25, 
        n6_adj_535, n15_adj_536, n14_adj_537, n26, clk_enable_17, 
        n5078, n_temp1_7__N_19, n_temp1_7__N_20, n_temp1_7__N_21, n_temp1_7__N_22, 
        n_temp1_7__N_23, n_temp1_7__N_24, n_temp1_7__N_25, n_temp1_7__N_26, 
        i2c1_sclo, n_temp1_7__N_28, n_temp1_7__N_29, i2c1_scloen, n_temp1_7__N_31, 
        n_temp1_7__N_32, n_temp1_7__N_33, n_temp1_7__N_34, n_temp1_7__N_35, 
        n1, n4814, i2c1_sdai, clk_enable_29, n3451, n14_adj_538, 
        n3507, n5030, n5186, n5237, n10_adj_539, n5236, n4910, 
        n3_adj_540, n4934, n2, n20, n5073, n4801, n4800, n4799, 
        n6_adj_541, n4057, n5235, n5234, n5233, n4053, n5252, 
        n5251, n4098, VCC_net, n4815, n3636, n4819;
    
    VLO scuba_vlo_inst (.Z(SPI0_SelnSYSUSRnCS_c)) /* synthesis LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=336, LSE_RLINE=336 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(336[7:15])
    LUT4 i2863_2_lut_3_lut_4_lut (.A(temp1[0]), .B(temp1[1]), .C(temp1[3]), 
         .D(temp1[2]), .Z(n5092)) /* synthesis lut_function=((B+(C+(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(658[58:76])
    defparam i2863_2_lut_3_lut_4_lut.init = 16'hfffd;
    LUT4 i2879_3_lut (.A(n_temp1_7__N_19), .B(data0[2]), .C(n_temp1_7__N_31), 
         .Z(n5108)) /* synthesis lut_function=(A+(B (C))) */ ;
    defparam i2879_3_lut.init = 16'heaea;
    LUT4 i2_3_lut_4_lut (.A(n5236), .B(clk_enable_27), .C(n_temp1_7__N_25), 
         .D(n4053), .Z(n4837)) /* synthesis lut_function=(!((((D)+!C)+!B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(941[5] 949[15])
    defparam i2_3_lut_4_lut.init = 16'h0080;
    FD1P3AX GPI_DAT_i0_i0 (.D(FP_UsrSW1_c), .SP(GPI_DAT_7__N_339), .CK(clk), 
            .Q(GPI_DAT[0]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(554[8] 560[15])
    defparam GPI_DAT_i0_i0.GSR = "ENABLED";
    FD1P3IX dat_count_i0_i4 (.D(n_dat_count_7__N_85[4]), .SP(clk_enable_29), 
            .CD(n3648), .CK(clk), .Q(dat_count[4]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(699[1] 713[10])
    defparam dat_count_i0_i4.GSR = "ENABLED";
    FD1P3AX GPI_DAT_i0_i5 (.D(PPn_VIN_c), .SP(GPI_DAT_7__N_339), .CK(clk), 
            .Q(GPI_DAT[5]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(554[8] 560[15])
    defparam GPI_DAT_i0_i5.GSR = "ENABLED";
    FD1S3AX data0_i1 (.D(data0_7__N_9[1]), .CK(clk), .Q(data0[1]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(469[7] 482[14])
    defparam data0_i1.GSR = "ENABLED";
    FD1S3IX wb_adr_i_i1 (.D(n3636), .CK(clk), .CD(clk_enable_27), .Q(wb_adr_i[0]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(678[1] 694[10])
    defparam wb_adr_i_i1.GSR = "ENABLED";
    BB BB1_scl (.I(i2c1_sclo), .T(i2c1_scloen), .B(SCL), .O(i2c1_scli)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=336, LSE_RLINE=336 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/ipexpress/xo2/efb_vhdl.vhd(154[14:16])
    FD1P3AX GPI_DAT_i0_i4 (.D(S2C_S2_c), .SP(GPI_DAT_7__N_339), .CK(clk), 
            .Q(GPI_DAT[4]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(554[8] 560[15])
    defparam GPI_DAT_i0_i4.GSR = "ENABLED";
    FD1P3IX dat_count_i0_i5 (.D(n_dat_count_7__N_85[5]), .SP(clk_enable_29), 
            .CD(n3648), .CK(clk), .Q(dat_count[5]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(699[1] 713[10])
    defparam dat_count_i0_i5.GSR = "ENABLED";
    FD1S3IX wb_stb_i_468 (.D(n4851), .CK(clk), .CD(clk_enable_27), .Q(wb_stb_i));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(678[1] 694[10])
    defparam wb_stb_i_468.GSR = "ENABLED";
    FD1P3IX dat_count_i0_i6 (.D(n_dat_count_7__N_85[6]), .SP(clk_enable_29), 
            .CD(n3648), .CK(clk), .Q(dat_count[6]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(699[1] 713[10])
    defparam dat_count_i0_i6.GSR = "ENABLED";
    BB BB1_sda (.I(i2c1_sdao), .T(i2c1_sdaoen), .B(SDA), .O(i2c1_sdai)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=336, LSE_RLINE=336 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/ipexpress/xo2/efb_vhdl.vhd(150[14:16])
    LUT4 i1_2_lut (.A(n_temp1_7__N_28), .B(n_temp1_7__N_26), .Z(n5078)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1_2_lut.init = 16'heeee;
    OSCH OSCInst0 (.STDBY(SPI0_SelnSYSUSRnCS_c), .OSC(clk)) /* synthesis NOM_FREQ="7", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "7";
    FD1S3IX wb_we_i_470 (.D(n5241), .CK(clk), .CD(clk_enable_27), .Q(wb_we_i));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(678[1] 694[10])
    defparam wb_we_i_470.GSR = "ENABLED";
    FD1S3AX c_state_FSM_i0 (.D(n3222), .CK(clk), .Q(n_temp1_7__N_35));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i0.GSR = "ENABLED";
    LUT4 i1_4_lut (.A(reg_rdy_N_484), .B(n_temp1_7__N_31), .C(n_dat_count_7__N_85[3]), 
         .D(dat_rdy_N_487), .Z(n3032)) /* synthesis lut_function=(A+(B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(269[16:23])
    defparam i1_4_lut.init = 16'hfaea;
    FD1P3AX GPI_DAT_i0_i3 (.D(X13_FP2x_ESt_c), .SP(GPI_DAT_7__N_339), .CK(clk), 
            .Q(GPI_DAT[3]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(554[8] 560[15])
    defparam GPI_DAT_i0_i3.GSR = "ENABLED";
    LUT4 i1_2_lut_rep_42_3_lut (.A(n15), .B(n4057), .C(n_temp1_7__N_34), 
         .Z(n5231)) /* synthesis lut_function=(A (C)+!A (B (C))) */ ;
    defparam i1_2_lut_rep_42_3_lut.init = 16'he0e0;
    CCU2D add_536_1 (.A0(SPI0_SelnSYSUSRnCS_c), .B0(SPI0_SelnSYSUSRnCS_c), 
          .C0(SPI0_SelnSYSUSRnCS_c), .D0(SPI0_SelnSYSUSRnCS_c), .A1(dat_count[0]), 
          .B1(SPI0_SelnSYSUSRnCS_c), .C1(SPI0_SelnSYSUSRnCS_c), .D1(SPI0_SelnSYSUSRnCS_c), 
          .COUT(n4798), .S1(n_dat_count_7__N_85[0]));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_536_1.INIT0 = 16'hF000;
    defparam add_536_1.INIT1 = 16'h5555;
    defparam add_536_1.INJECT1_0 = "NO";
    defparam add_536_1.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_42 (.A(temp1[6]), .B(data0[4]), .C(n30), .D(n33), 
         .Z(data0_7__N_9[4])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i1_4_lut_adj_42.init = 16'hdc50;
    LUT4 i56_4_lut (.A(GPI_DAT[4]), .B(data0[4]), .C(temp1[5]), .D(n3451), 
         .Z(n30)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i56_4_lut.init = 16'hcac0;
    LUT4 i2861_2_lut_rep_56 (.A(temp1[7]), .B(temp1[4]), .Z(n5245)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2861_2_lut_rep_56.init = 16'heeee;
    FD1P3IX dat_count_i0_i7 (.D(n_dat_count_7__N_85[7]), .SP(clk_enable_29), 
            .CD(n3648), .CK(clk), .Q(dat_count[7]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(699[1] 713[10])
    defparam dat_count_i0_i7.GSR = "ENABLED";
    LUT4 i1_2_lut_rep_49_3_lut_4_lut (.A(temp1[7]), .B(temp1[4]), .C(temp1[6]), 
         .D(temp1[5]), .Z(n5238)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i1_2_lut_rep_49_3_lut_4_lut.init = 16'hfffe;
    FD1P3AX GPI_DAT_i0_i2 (.D(FP_UsrSW3_c), .SP(GPI_DAT_7__N_339), .CK(clk), 
            .Q(GPI_DAT[2]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(554[8] 560[15])
    defparam GPI_DAT_i0_i2.GSR = "ENABLED";
    LUT4 i1_4_lut_adj_43 (.A(temp1[6]), .B(data0[0]), .C(n30_adj_526), 
         .D(n33), .Z(data0_7__N_9[0])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i1_4_lut_adj_43.init = 16'hdc50;
    LUT4 i1_2_lut_rep_50_3_lut (.A(temp1[7]), .B(temp1[4]), .C(temp1[5]), 
         .Z(n5239)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i1_2_lut_rep_50_3_lut.init = 16'hfefe;
    LUT4 i56_4_lut_adj_44 (.A(GPI_DAT[0]), .B(data0[0]), .C(temp1[5]), 
         .D(n3451), .Z(n30_adj_526)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i56_4_lut_adj_44.init = 16'hcac0;
    LUT4 i1047_4_lut (.A(n_temp1_7__N_35), .B(n5234), .C(n2703), .D(clk_enable_25), 
         .Z(n3222)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1047_4_lut.init = 16'heca0;
    LUT4 i2_3_lut_4_lut_adj_45 (.A(temp1[7]), .B(temp1[4]), .C(temp1[6]), 
         .D(temp1[5]), .Z(n14)) /* synthesis lut_function=(A+(B+!(C (D)))) */ ;
    defparam i2_3_lut_4_lut_adj_45.init = 16'hefff;
    LUT4 i7_4_lut (.A(dat_count[0]), .B(n14_adj_538), .C(n10_adj_539), 
         .D(dat_count[6]), .Z(n15)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(1177[13:35])
    defparam i7_4_lut.init = 16'hfffe;
    LUT4 i6_4_lut (.A(dat_count[3]), .B(dat_count[1]), .C(dat_count[5]), 
         .D(dat_count[7]), .Z(n14_adj_538)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(1177[13:35])
    defparam i6_4_lut.init = 16'hfffe;
    FD1S3IX wb_dat_i_i0 (.D(n_wb_dat_i_7__N_125[0]), .CK(clk), .CD(n3529), 
            .Q(wb_dat_i[0]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(678[1] 694[10])
    defparam wb_dat_i_i0.GSR = "ENABLED";
    FD1P3IX dat_count_i0_i0 (.D(n_dat_count_7__N_85[0]), .SP(clk_enable_29), 
            .CD(n3648), .CK(clk), .Q(dat_count[0]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(699[1] 713[10])
    defparam dat_count_i0_i0.GSR = "ENABLED";
    LUT4 i2_2_lut (.A(dat_count[2]), .B(dat_count[4]), .Z(n10_adj_539)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(1177[13:35])
    defparam i2_2_lut.init = 16'heeee;
    LUT4 i629_4_lut_4_lut (.A(n5236), .B(clk_enable_27), .C(n4053), .D(n4122), 
         .Z(n2590)) /* synthesis lut_function=(A (B (C (D)))+!A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(941[5] 949[15])
    defparam i629_4_lut_4_lut.init = 16'hc444;
    LUT4 i2894_4_lut (.A(n3459), .B(n48), .C(data0[7]), .D(n50), .Z(data0_7__N_9[7])) /* synthesis lut_function=(!(A+(B+!(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i2894_4_lut.init = 16'h1011;
    FD1P3IX temp1_i0_i1 (.D(wb_dat_o[1]), .SP(clk_enable_28), .CD(n3531), 
            .CK(clk), .Q(temp1[1]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(487[1] 502[11])
    defparam temp1_i0_i1.GSR = "ENABLED";
    LUT4 i1_4_lut_adj_46 (.A(GPI_DAT[7]), .B(n3451), .C(temp1[5]), .D(temp1[6]), 
         .Z(n3459)) /* synthesis lut_function=(A (B (C (D)))+!A (B (C (D)+!C !(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i1_4_lut_adj_46.init = 16'hc004;
    FD1S3AX dat_rdy_del_459 (.D(dat_rdy), .CK(clk), .Q(dat_rdy_del));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(447[7] 460[11])
    defparam dat_rdy_del_459.GSR = "ENABLED";
    LUT4 i1_3_lut (.A(temp1[6]), .B(n18), .C(data0[7]), .Z(n48)) /* synthesis lut_function=(A (B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i1_3_lut.init = 16'h8a8a;
    LUT4 i1_3_lut_4_lut (.A(n5186), .B(clk_enable_27), .C(n5233), .D(n3648), 
         .Z(clk_enable_29)) /* synthesis lut_function=(A (B ((D)+!C)+!B (D))+!A (D)) */ ;
    defparam i1_3_lut_4_lut.init = 16'hff08;
    LUT4 i1830_4_lut (.A(n5243), .B(n3377), .C(n5246), .D(n5238), .Z(n4057)) /* synthesis lut_function=(A (B)+!A (B (C+(D)))) */ ;
    defparam i1830_4_lut.init = 16'hccc8;
    FD1P3IX temp1_i0_i2 (.D(wb_dat_o[2]), .SP(clk_enable_28), .CD(n3531), 
            .CK(clk), .Q(temp1[2]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(487[1] 502[11])
    defparam temp1_i0_i2.GSR = "ENABLED";
    FD1P3IX temp1_i0_i3 (.D(wb_dat_o[3]), .SP(clk_enable_28), .CD(n3531), 
            .CK(clk), .Q(temp1[3]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(487[1] 502[11])
    defparam temp1_i0_i3.GSR = "ENABLED";
    LUT4 i3_4_lut (.A(temp1[0]), .B(n5238), .C(n5247), .D(temp1[1]), 
         .Z(n3377)) /* synthesis lut_function=((B+(C+!(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(476[13:23])
    defparam i3_4_lut.init = 16'hfdff;
    LUT4 i5_3_lut_4_lut (.A(temp1[7]), .B(temp1[4]), .C(n10), .D(temp1[2]), 
         .Z(n18)) /* synthesis lut_function=(!(A+(B+((D)+!C)))) */ ;
    defparam i5_3_lut_4_lut.init = 16'h0010;
    LUT4 i926_1_lut (.A(wb_stb_i), .Z(n3068)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(678[1] 694[10])
    defparam i926_1_lut.init = 16'h5555;
    LUT4 i1_2_lut_adj_47 (.A(reg_rdy_N_484), .B(wb_ack_o), .Z(reg_rdy_N_483)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1_2_lut_adj_47.init = 16'h8888;
    LUT4 i2_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(dat_rdy_N_487), .Z(clk_enable_25)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i2_3_lut.init = 16'h8080;
    LUT4 i8_4_lut (.A(n15_adj_536), .B(X13_C2E_M61_c), .C(n14_adj_537), 
         .D(X13_FP2x_ESt_c), .Z(dummy_signal)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(375[17] 378[14])
    defparam i8_4_lut.init = 16'h8000;
    FD1P3IX temp1_i0_i4 (.D(wb_dat_o[4]), .SP(clk_enable_28), .CD(n3531), 
            .CK(clk), .Q(temp1[4]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(487[1] 502[11])
    defparam temp1_i0_i4.GSR = "ENABLED";
    LUT4 i6_4_lut_adj_48 (.A(FP_UsrSW2_c), .B(PG_VIN_c), .C(FP_UsrSW3_c), 
         .D(FP_UsrSW1_c), .Z(n15_adj_536)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(375[17] 378[14])
    defparam i6_4_lut_adj_48.init = 16'h8000;
    LUT4 i5_4_lut (.A(n31), .B(S2C_S2_c), .C(n32), .D(PPn_VIN_c), .Z(n14_adj_537)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(375[17] 378[14])
    defparam i5_4_lut.init = 16'h8000;
    LUT4 i1_2_lut_adj_49 (.A(dat_rdy_N_487), .B(wb_ack_o), .Z(dat_rdy_N_486)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1_2_lut_adj_49.init = 16'h8888;
    LUT4 i3_4_lut_4_lut (.A(reg_rdy_N_484), .B(n5235), .C(n_temp1_7__N_31), 
         .D(dat_rdy_N_487), .Z(n3648)) /* synthesis lut_function=(!(((C+(D))+!B)+!A)) */ ;
    defparam i3_4_lut_4_lut.init = 16'h0008;
    LUT4 temp1_7__I_0_530_i9_2_lut_rep_57 (.A(temp1[0]), .B(temp1[1]), .Z(n5246)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(658[34:52])
    defparam temp1_7__I_0_530_i9_2_lut_rep_57.init = 16'hbbbb;
    LUT4 i14_4_lut (.A(Xc1_MOSI_c), .B(n28), .C(n20), .D(Xc1_CS_A2_c), 
         .Z(n31)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(375[17] 378[14])
    defparam i14_4_lut.init = 16'h8000;
    LUT4 i15_4_lut (.A(n29), .B(X13_C2E_M53_c), .C(n26), .D(TDnALERT_c), 
         .Z(n32)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(375[17] 378[14])
    defparam i15_4_lut.init = 16'h8000;
    LUT4 i12_4_lut (.A(Xc1_CS_A1_c), .B(TDnSHDN_c), .C(TDnFFnFS_c), .D(RTC_FOUT_c), 
         .Z(n29)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(375[17] 378[14])
    defparam i12_4_lut.init = 16'h8000;
    LUT4 i2_3_lut_4_lut_adj_50 (.A(n5249), .B(n5237), .C(n3377), .D(n4053), 
         .Z(n4098)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(657[58:76])
    defparam i2_3_lut_4_lut_adj_50.init = 16'he000;
    LUT4 temp1_7__I_0_509_i10_2_lut_rep_58 (.A(temp1[2]), .B(temp1[3]), 
         .Z(n5247)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(478[13:23])
    defparam temp1_7__I_0_509_i10_2_lut_rep_58.init = 16'hbbbb;
    FD1P3IX dat_count_i0_i1 (.D(n_dat_count_7__N_85[1]), .SP(clk_enable_29), 
            .CD(n3648), .CK(clk), .Q(dat_count[1]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(699[1] 713[10])
    defparam dat_count_i0_i1.GSR = "ENABLED";
    LUT4 i9_3_lut (.A(FP_UsrSW4_c), .B(Xc1_PSANL_c), .C(X13_C2E_M56_c), 
         .Z(n26)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(375[17] 378[14])
    defparam i9_3_lut.init = 16'h8080;
    LUT4 i27_4_lut (.A(n_temp1_7__N_19), .B(n_state_7__N_458[4]), .C(clk_enable_27), 
         .D(n10_adj_528), .Z(n4918)) /* synthesis lut_function=(!(A (B (C)+!B !((D)+!C))+!A (B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i27_4_lut.init = 16'h3a0a;
    LUT4 i2_4_lut (.A(n14_adj_525), .B(n_temp1_7__N_33), .C(n_temp1_7__N_29), 
         .D(wb_dat_o[4]), .Z(n10_adj_528)) /* synthesis lut_function=(A+(B+!((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i2_4_lut.init = 16'heefe;
    LUT4 i2_3_lut_rep_59 (.A(n_temp1_7__N_32), .B(n_temp1_7__N_19), .C(n_temp1_7__N_25), 
         .Z(n5248)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i2_3_lut_rep_59.init = 16'hfefe;
    LUT4 i1_4_lut_adj_51 (.A(wb_dat_o[2]), .B(n3), .C(n5078), .D(n5231), 
         .Z(n14_adj_525)) /* synthesis lut_function=(!(A+!(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1_4_lut_adj_51.init = 16'h5554;
    LUT4 i1_2_lut_rep_52_4_lut (.A(n_temp1_7__N_32), .B(n_temp1_7__N_19), 
         .C(n_temp1_7__N_25), .D(n_temp1_7__N_31), .Z(n5241)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1_2_lut_rep_52_4_lut.init = 16'hfffe;
    LUT4 i11_4_lut (.A(X13_C2E_M60_c), .B(X13_C2E_M52_c), .C(X13_C2E_M57_c), 
         .D(Xc1_SPICLK_c), .Z(n28)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(375[17] 378[14])
    defparam i11_4_lut.init = 16'h8000;
    FD1P3IX dat_count_i0_i2 (.D(n_dat_count_7__N_85[2]), .SP(clk_enable_29), 
            .CD(n3648), .CK(clk), .Q(dat_count[2]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(699[1] 713[10])
    defparam dat_count_i0_i2.GSR = "ENABLED";
    LUT4 i1_2_lut_4_lut (.A(n_temp1_7__N_32), .B(n_temp1_7__N_19), .C(n_temp1_7__N_25), 
         .D(n46), .Z(n3636)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1_2_lut_4_lut.init = 16'hfffe;
    LUT4 i1_2_lut_adj_52 (.A(n_temp1_7__N_35), .B(n15), .Z(n3)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1_2_lut_adj_52.init = 16'h8888;
    LUT4 i3_2_lut (.A(Xc1_CS_A3_c), .B(S2C_S3_c), .Z(n20)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(375[17] 378[14])
    defparam i3_2_lut.init = 16'h8888;
    LUT4 i8_1_lut (.A(n_temp1_7__N_31), .Z(n3529)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i8_1_lut.init = 16'h5555;
    LUT4 i1_2_lut_rep_60 (.A(temp1[3]), .B(temp1[2]), .Z(n5249)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i1_2_lut_rep_60.init = 16'hbbbb;
    LUT4 i742_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n5250), .D(n15), 
         .Z(n2703)) /* synthesis lut_function=(((C (D))+!B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i742_3_lut_4_lut.init = 16'hf777;
    LUT4 i71_3_lut_4_lut_3_lut (.A(temp1[3]), .B(temp1[2]), .C(temp1[1]), 
         .Z(n68)) /* synthesis lut_function=(A (B+!(C))+!A ((C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i71_3_lut_4_lut_3_lut.init = 16'hdbdb;
    LUT4 i2875_4_lut_then_4_lut (.A(n14), .B(temp1[3]), .C(temp1[2]), 
         .D(temp1[0]), .Z(n5252)) /* synthesis lut_function=(A+((C+(D))+!B)) */ ;
    defparam i2875_4_lut_then_4_lut.init = 16'hfffb;
    LUT4 i1_2_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_28), 
         .D(wb_dat_o[2]), .Z(n5058)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i1_2_lut_3_lut_4_lut.init = 16'h8000;
    FD1S3AX data0_i2 (.D(data0_7__N_9[2]), .CK(clk), .Q(data0[2]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(469[7] 482[14])
    defparam data0_i2.GSR = "ENABLED";
    LUT4 i1_2_lut_rep_61 (.A(n_state_7__N_458[4]), .B(wb_dat_o[2]), .Z(n5250)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam i1_2_lut_rep_61.init = 16'h2222;
    LUT4 i1_2_lut_3_lut_4_lut_adj_53 (.A(n_state_7__N_458[4]), .B(wb_dat_o[2]), 
         .C(n4057), .D(n15), .Z(n5073)) /* synthesis lut_function=(!((B+!(C+(D)))+!A)) */ ;
    defparam i1_2_lut_3_lut_4_lut_adj_53.init = 16'h2220;
    FD1S3AX data0_i3 (.D(data0_7__N_9[3]), .CK(clk), .Q(data0[3]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(469[7] 482[14])
    defparam data0_i3.GSR = "ENABLED";
    FD1S3AX data0_i6 (.D(data0_7__N_9[6]), .CK(clk), .Q(data0[6]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(469[7] 482[14])
    defparam data0_i6.GSR = "ENABLED";
    FD1P3AX GPI_DAT_i0_i1 (.D(FP_UsrSW2_c), .SP(GPI_DAT_7__N_339), .CK(clk), 
            .Q(GPI_DAT[1]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(554[8] 560[15])
    defparam GPI_DAT_i0_i1.GSR = "ENABLED";
    FD1P3AX GPO_DATA_0___i7 (.D(temp3[7]), .SP(clk_enable_17), .CK(clk), 
            .Q(FP_UsrLED_c_4));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(535[8] 543[15])
    defparam GPO_DATA_0___i7.GSR = "ENABLED";
    FD1P3AX GPO_DATA_0___i6 (.D(temp3[6]), .SP(clk_enable_17), .CK(clk), 
            .Q(FP_UsrLED_c_3));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(535[8] 543[15])
    defparam GPO_DATA_0___i6.GSR = "ENABLED";
    LUT4 i2896_2_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_24), 
         .D(n_temp1_7__N_23), .Z(n3531)) /* synthesis lut_function=(!(((C+!(D))+!B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i2896_2_lut_3_lut_4_lut.init = 16'h0800;
    FD1P3IX temp1_i0_i5 (.D(wb_dat_o[5]), .SP(clk_enable_28), .CD(n3531), 
            .CK(clk), .Q(temp1[5]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(487[1] 502[11])
    defparam temp1_i0_i5.GSR = "ENABLED";
    LUT4 i2875_4_lut_else_4_lut (.A(n14), .B(temp1[3]), .C(temp1[2]), 
         .D(temp1[0]), .Z(n5251)) /* synthesis lut_function=(A+(B+!(C (D)))) */ ;
    defparam i2875_4_lut_else_4_lut.init = 16'hefff;
    FD1S3AX data0_i5 (.D(data0_7__N_9[5]), .CK(clk), .Q(data0[5]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(469[7] 482[14])
    defparam data0_i5.GSR = "ENABLED";
    FD1P3AX GPO_DATA_0___i5 (.D(temp3[5]), .SP(clk_enable_17), .CK(clk), 
            .Q(FP_UsrLED_c_2));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(535[8] 543[15])
    defparam GPO_DATA_0___i5.GSR = "ENABLED";
    LUT4 i56_4_lut_adj_54 (.A(GPI_DAT[5]), .B(data0[5]), .C(temp1[5]), 
         .D(n3451), .Z(n30_adj_531)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i56_4_lut_adj_54.init = 16'hcac0;
    FD1P3AX GPO_DATA_0___i4 (.D(temp3[4]), .SP(clk_enable_17), .CK(clk), 
            .Q(FP_UsrLED_c_1));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(535[8] 543[15])
    defparam GPO_DATA_0___i4.GSR = "ENABLED";
    LUT4 i1833_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(data0[7]), 
         .Z(n_wb_dat_i_7__N_125[7])) /* synthesis lut_function=(!(A (B+!(C))+!A !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i1833_2_lut_3_lut.init = 16'h7070;
    FD1P3AX GPO_DATA_0___i3 (.D(temp3[3]), .SP(clk_enable_17), .CK(clk), 
            .Q(FP_SysLEDs_c_3));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(535[8] 543[15])
    defparam GPO_DATA_0___i3.GSR = "ENABLED";
    FD1S3AX data0_i4 (.D(data0_7__N_9[4]), .CK(clk), .Q(data0[4]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(469[7] 482[14])
    defparam data0_i4.GSR = "ENABLED";
    FD1S3AX data0_i0 (.D(data0_7__N_9[0]), .CK(clk), .Q(data0[0]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(469[7] 482[14])
    defparam data0_i0.GSR = "ENABLED";
    LUT4 i1836_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(data0[6]), 
         .Z(n_wb_dat_i_7__N_125[6])) /* synthesis lut_function=(!(A (B+!(C))+!A !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i1836_2_lut_3_lut.init = 16'h7070;
    LUT4 reg_rdy_I_0_2_lut_3_lut_4_lut (.A(n5238), .B(n5244), .C(reg_rdy), 
         .D(n5249), .Z(GPI_DAT_7__N_339)) /* synthesis lut_function=(!(A+(B+((D)+!C)))) */ ;
    defparam reg_rdy_I_0_2_lut_3_lut_4_lut.init = 16'h0010;
    LUT4 i1_4_lut_adj_55 (.A(n5245), .B(temp1[5]), .C(n5216), .D(n36), 
         .Z(n33)) /* synthesis lut_function=(A+(B (C)+!B (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i1_4_lut_adj_55.init = 16'hfbfa;
    LUT4 i11_4_lut_adj_56 (.A(n_temp1_7__N_21), .B(n_temp1_7__N_20), .C(clk_enable_27), 
         .D(n_state_7__N_458[4]), .Z(n5030)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i11_4_lut_adj_56.init = 16'h0aca;
    LUT4 i1_2_lut_adj_57 (.A(temp1[6]), .B(temp1[0]), .Z(n36)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i1_2_lut_adj_57.init = 16'hbbbb;
    LUT4 i1_4_lut_adj_58 (.A(clk_enable_27), .B(n_temp1_7__N_32), .C(n2), 
         .D(n3_adj_540), .Z(n_wb_dat_i[3])) /* synthesis lut_function=(!(A+!(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1_4_lut_adj_58.init = 16'h5554;
    FD1S3AX data0_i7 (.D(data0_7__N_9[7]), .CK(clk), .Q(data0[7]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(469[7] 482[14])
    defparam data0_i7.GSR = "ENABLED";
    FD1P3AX i933 (.D(wb_dat_o[0]), .SP(clk_enable_18), .CK(clk), .Q(temp2[0]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(487[1] 502[11])
    defparam i933.GSR = "ENABLED";
    FD1P3IX temp1_i0_i7 (.D(wb_dat_o[7]), .SP(clk_enable_28), .CD(n3531), 
            .CK(clk), .Q(temp1[7]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(487[1] 502[11])
    defparam temp1_i0_i7.GSR = "ENABLED";
    FD1P3IX temp1_i0_i0 (.D(wb_dat_o[0]), .SP(clk_enable_28), .CD(n3531), 
            .CK(clk), .Q(temp1[0]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(487[1] 502[11])
    defparam temp1_i0_i0.GSR = "ENABLED";
    LUT4 i1_4_lut_adj_59 (.A(temp1[6]), .B(data0[2]), .C(n30_adj_530), 
         .D(n33), .Z(data0_7__N_9[2])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i1_4_lut_adj_59.init = 16'hdc50;
    LUT4 i56_4_lut_adj_60 (.A(GPI_DAT[2]), .B(data0[2]), .C(temp1[5]), 
         .D(n3451), .Z(n30_adj_530)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i56_4_lut_adj_60.init = 16'hcac0;
    LUT4 i3_4_lut_adj_61 (.A(n4122), .B(n5236), .C(n_temp1_7__N_25), .D(n4053), 
         .Z(n2)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i3_4_lut_adj_61.init = 16'h8000;
    LUT4 temp1_1__bdd_4_lut (.A(temp1[5]), .B(temp1[0]), .C(temp1[2]), 
         .D(temp1[3]), .Z(n5214)) /* synthesis lut_function=(A (B+(C+!(D)))+!A (C+!(D))) */ ;
    defparam temp1_1__bdd_4_lut.init = 16'hf8ff;
    LUT4 i1839_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(data0[5]), 
         .Z(n_wb_dat_i_7__N_125[5])) /* synthesis lut_function=(!(A (B+!(C))+!A !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i1839_2_lut_3_lut.init = 16'h7070;
    LUT4 i1017_4_lut (.A(n3181), .B(n5232), .C(n_temp1_7__N_25), .D(n4122), 
         .Z(n3182)) /* synthesis lut_function=(A+!(((D)+!C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1017_4_lut.init = 16'haaea;
    LUT4 i7_4_lut_adj_62 (.A(n_temp1_7__N_20), .B(n14_adj_524), .C(n10_adj_527), 
         .D(n_temp1_7__N_34), .Z(n46)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i7_4_lut_adj_62.init = 16'hfffe;
    LUT4 i2891_4_lut (.A(n3456), .B(n48_adj_523), .C(data0[3]), .D(n50), 
         .Z(data0_7__N_9[3])) /* synthesis lut_function=(!(A+(B+!(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i2891_4_lut.init = 16'h1011;
    LUT4 i1_2_lut_adj_63 (.A(data0[3]), .B(n_temp1_7__N_31), .Z(n3_adj_540)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1_2_lut_adj_63.init = 16'h8888;
    LUT4 i1_4_lut_adj_64 (.A(GPI_DAT[3]), .B(n3451), .C(temp1[5]), .D(temp1[6]), 
         .Z(n3456)) /* synthesis lut_function=(A (B (C (D)))+!A (B (C (D)+!C !(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i1_4_lut_adj_64.init = 16'hc004;
    LUT4 i1_3_lut_adj_65 (.A(temp1[6]), .B(n18), .C(data0[3]), .Z(n48_adj_523)) /* synthesis lut_function=(A (B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i1_3_lut_adj_65.init = 16'h8a8a;
    LUT4 i1009_2_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_28), 
         .D(n5250), .Z(n3171)) /* synthesis lut_function=(A (B (C (D))+!B (C))+!A (C)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i1009_2_lut_3_lut_4_lut.init = 16'hf070;
    LUT4 i1840_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(data0[4]), 
         .Z(n_wb_dat_i_7__N_125[4])) /* synthesis lut_function=(!(A (B+!(C))+!A !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i1840_2_lut_3_lut.init = 16'h7070;
    LUT4 i1849_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(data0[1]), 
         .Z(n_wb_dat_i_7__N_125[1])) /* synthesis lut_function=(!(A (B+!(C))+!A !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i1849_2_lut_3_lut.init = 16'h7070;
    LUT4 i1_2_lut_3_lut_4_lut_adj_66 (.A(n5238), .B(n5244), .C(clk_enable_25), 
         .D(temp1[3]), .Z(n5042)) /* synthesis lut_function=(!(A+(B+((D)+!C)))) */ ;
    defparam i1_2_lut_3_lut_4_lut_adj_66.init = 16'h0010;
    LUT4 i1_4_lut_4_lut (.A(n15), .B(n4057), .C(n_temp1_7__N_34), .D(n_temp1_7__N_35), 
         .Z(n4)) /* synthesis lut_function=(!(A+!(B (D)+!B (C+(D))))) */ ;
    defparam i1_4_lut_4_lut.init = 16'h5510;
    LUT4 i2898_4_lut (.A(clk_enable_27), .B(n_temp1_7__N_32), .C(n5108), 
         .D(n_temp1_7__N_25), .Z(n_wb_dat_i[2])) /* synthesis lut_function=(!(A+!(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i2898_4_lut.init = 16'h5554;
    LUT4 temp1_7__I_0_531_i10_2_lut_rep_54 (.A(temp1[2]), .B(temp1[3]), 
         .Z(n5243)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(658[58:76])
    defparam temp1_7__I_0_531_i10_2_lut_rep_54.init = 16'heeee;
    LUT4 i6_4_lut_adj_67 (.A(n_temp1_7__N_29), .B(n5038), .C(n_temp1_7__N_33), 
         .D(n5078), .Z(n14_adj_524)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i6_4_lut_adj_67.init = 16'hfffe;
    LUT4 i2_2_lut_adj_68 (.A(n_temp1_7__N_23), .B(n_temp1_7__N_35), .Z(n10_adj_527)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i2_2_lut_adj_68.init = 16'heeee;
    LUT4 i1_2_lut_rep_45_3_lut_4_lut (.A(temp1[6]), .B(n5239), .C(temp1[3]), 
         .D(n5244), .Z(n5234)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(658[34:52])
    defparam i1_2_lut_rep_45_3_lut_4_lut.init = 16'hfffe;
    LUT4 i4_4_lut (.A(n_temp1_7__N_21), .B(reg_rdy_N_484), .C(dat_rdy_N_487), 
         .D(n6), .Z(n5038)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i4_4_lut.init = 16'hfffe;
    LUT4 i2_3_lut_4_lut_adj_69 (.A(temp1[3]), .B(n5237), .C(n4057), .D(n_state_7__N_402[3]), 
         .Z(n4122)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;
    defparam i2_3_lut_4_lut_adj_69.init = 16'he000;
    LUT4 i2_3_lut_rep_47_4_lut (.A(temp1[6]), .B(n5239), .C(temp1[0]), 
         .D(n5249), .Z(n5236)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(658[34:52])
    defparam i2_3_lut_rep_47_4_lut.init = 16'hfffe;
    LUT4 i2_3_lut_4_lut_4_lut (.A(n15), .B(n4057), .C(wb_dat_o[2]), .D(n_temp1_7__N_34), 
         .Z(n5070)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;
    defparam i2_3_lut_4_lut_4_lut.init = 16'h2000;
    LUT4 i2_3_lut_4_lut_adj_70 (.A(temp1[5]), .B(n5245), .C(temp1[0]), 
         .D(n68), .Z(n50)) /* synthesis lut_function=(A+(B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(658[34:52])
    defparam i2_3_lut_4_lut_adj_70.init = 16'hffef;
    LUT4 temp1_1__bdd_3_lut (.A(temp1[0]), .B(temp1[2]), .C(temp1[3]), 
         .Z(n5215)) /* synthesis lut_function=(((C)+!B)+!A) */ ;
    defparam temp1_1__bdd_3_lut.init = 16'hf7f7;
    LUT4 i1_2_lut_rep_48_3_lut_4_lut (.A(temp1[5]), .B(n5245), .C(n5244), 
         .D(temp1[6]), .Z(n5237)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(658[34:52])
    defparam i1_2_lut_rep_48_3_lut_4_lut.init = 16'hfffe;
    LUT4 i2_4_lut_adj_71 (.A(reg_rdy_N_484), .B(n4837), .C(n5235), .D(n3171), 
         .Z(n4815)) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i2_4_lut_adj_71.init = 16'hffec;
    LUT4 i1_2_lut_adj_72 (.A(n_temp1_7__N_24), .B(n_temp1_7__N_22), .Z(n6)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1_2_lut_adj_72.init = 16'heeee;
    LUT4 temp1_7__I_0_531_i9_2_lut_rep_55 (.A(temp1[0]), .B(temp1[1]), .Z(n5244)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(658[58:76])
    defparam temp1_7__I_0_531_i9_2_lut_rep_55.init = 16'hdddd;
    LUT4 i4_4_lut_adj_73 (.A(temp1[1]), .B(temp1[3]), .C(temp1[0]), .D(temp1[5]), 
         .Z(n10)) /* synthesis lut_function=(!(((C+!(D))+!B)+!A)) */ ;
    defparam i4_4_lut_adj_73.init = 16'h0800;
    LUT4 i1015_4_lut_4_lut (.A(clk_enable_27), .B(wb_dat_o[2]), .C(n_temp1_7__N_26), 
         .D(reg_rdy_N_484), .Z(n3180)) /* synthesis lut_function=(A (B (C))+!A (D)) */ ;
    defparam i1015_4_lut_4_lut.init = 16'hd580;
    FD1S3IX reg_rdy_456 (.D(reg_rdy_N_483), .CK(clk), .CD(n3068), .Q(reg_rdy));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(429[1] 442[9])
    defparam reg_rdy_456.GSR = "ENABLED";
    LUT4 i1023_4_lut_4_lut (.A(clk_enable_27), .B(wb_dat_o[2]), .C(n_temp1_7__N_22), 
         .D(n_temp1_7__N_23), .Z(n3188)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A (D)) */ ;
    defparam i1023_4_lut_4_lut.init = 16'hf7a0;
    FD1S3IX dat_rdy_458 (.D(dat_rdy_N_486), .CK(clk), .CD(n3068), .Q(dat_rdy));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(447[7] 460[11])
    defparam dat_rdy_458.GSR = "ENABLED";
    FD1P3AX temp3_i0_i7 (.D(wb_dat_o[7]), .SP(clk_enable_25), .CK(clk), 
            .Q(temp3[7]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(487[1] 502[11])
    defparam temp3_i0_i7.GSR = "ENABLED";
    LUT4 i1_4_lut_adj_74 (.A(temp1[6]), .B(data0[6]), .C(n30_adj_529), 
         .D(n33), .Z(data0_7__N_9[6])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i1_4_lut_adj_74.init = 16'hdc50;
    LUT4 i1021_4_lut_4_lut (.A(clk_enable_27), .B(wb_dat_o[2]), .C(n_temp1_7__N_23), 
         .D(n_temp1_7__N_24), .Z(n3186)) /* synthesis lut_function=(A (B (C))+!A (D)) */ ;
    defparam i1021_4_lut_4_lut.init = 16'hd580;
    LUT4 i2_4_lut_4_lut (.A(clk_enable_27), .B(n_state_7__N_458[4]), .C(n5), 
         .D(n_temp1_7__N_33), .Z(n6_adj_541)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(1146[7] 1165[12])
    defparam i2_4_lut_4_lut.init = 16'hfda0;
    LUT4 i56_4_lut_adj_75 (.A(GPI_DAT[6]), .B(data0[6]), .C(temp1[5]), 
         .D(n3451), .Z(n30_adj_529)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i56_4_lut_adj_75.init = 16'hcac0;
    CCU2D add_536_9 (.A0(dat_count[7]), .B0(SPI0_SelnSYSUSRnCS_c), .C0(SPI0_SelnSYSUSRnCS_c), 
          .D0(SPI0_SelnSYSUSRnCS_c), .A1(SPI0_SelnSYSUSRnCS_c), .B1(SPI0_SelnSYSUSRnCS_c), 
          .C1(SPI0_SelnSYSUSRnCS_c), .D1(SPI0_SelnSYSUSRnCS_c), .CIN(n4801), 
          .S0(n_dat_count_7__N_85[7]));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_536_9.INIT0 = 16'h5555;
    defparam add_536_9.INIT1 = 16'h0000;
    defparam add_536_9.INJECT1_0 = "NO";
    defparam add_536_9.INJECT1_1 = "NO";
    LUT4 i1008_4_lut (.A(n_temp1_7__N_29), .B(n4098), .C(n2640), .D(n5058), 
         .Z(n3170)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1008_4_lut.init = 16'hb3a0;
    LUT4 i1029_4_lut_4_lut (.A(clk_enable_27), .B(n_state_7__N_458[4]), 
         .C(n_temp1_7__N_19), .D(n_temp1_7__N_20), .Z(n3194)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(1146[7] 1165[12])
    defparam i1029_4_lut_4_lut.init = 16'hfda0;
    LUT4 n4057_bdd_4_lut_2918 (.A(n4057), .B(n_temp1_7__N_31), .C(dat_rdy_N_487), 
         .D(n5234), .Z(n5186)) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(B ((D)+!C)+!B (C (D))))) */ ;
    defparam n4057_bdd_4_lut_2918.init = 16'h7404;
    LUT4 i2_2_lut_3_lut (.A(n_temp1_7__N_31), .B(n5248), .C(n46), .Z(n4851)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i2_2_lut_3_lut.init = 16'hfefe;
    LUT4 wb_ack_o_I_0_2_lut_rep_53 (.A(wb_ack_o), .B(wb_stb_i), .Z(clk_enable_27)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam wb_ack_o_I_0_2_lut_rep_53.init = 16'h8888;
    LUT4 i1_4_lut_adj_76 (.A(n5238), .B(n5092), .C(temp2[0]), .D(dat_rdy_del), 
         .Z(clk_enable_17)) /* synthesis lut_function=(!(A+(B+(C+!(D))))) */ ;
    defparam i1_4_lut_adj_76.init = 16'h0100;
    LUT4 i1_2_lut_rep_46_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_state_7__N_402[3]), 
         .Z(n5235)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i1_2_lut_rep_46_3_lut.init = 16'h8080;
    LUT4 i2_4_lut_adj_77 (.A(wb_dat_o[2]), .B(n4_adj_533), .C(clk_enable_27), 
         .D(n3), .Z(n4814)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i2_4_lut_adj_77.init = 16'heccc;
    LUT4 i1_4_lut_adj_78 (.A(n4098), .B(clk_enable_27), .C(n5058), .D(dat_rdy_N_487), 
         .Z(n4_adj_533)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1_4_lut_adj_78.init = 16'hb3a0;
    LUT4 i19_4_lut (.A(n_temp1_7__N_31), .B(n1), .C(clk_enable_27), .D(n5070), 
         .Z(n4934)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i19_4_lut.init = 16'hfaca;
    LUT4 i1_2_lut_adj_79 (.A(wb_dat_o[4]), .B(n_temp1_7__N_29), .Z(n1)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1_2_lut_adj_79.init = 16'h8888;
    LUT4 i1016_2_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_26), 
         .D(n5250), .Z(n3181)) /* synthesis lut_function=(A (B (C (D))+!B (C))+!A (C)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i1016_2_lut_3_lut_4_lut.init = 16'hf070;
    CCU2D add_536_7 (.A0(dat_count[5]), .B0(SPI0_SelnSYSUSRnCS_c), .C0(SPI0_SelnSYSUSRnCS_c), 
          .D0(SPI0_SelnSYSUSRnCS_c), .A1(dat_count[6]), .B1(SPI0_SelnSYSUSRnCS_c), 
          .C1(SPI0_SelnSYSUSRnCS_c), .D1(SPI0_SelnSYSUSRnCS_c), .CIN(n4800), 
          .COUT(n4801), .S0(n_dat_count_7__N_85[5]), .S1(n_dat_count_7__N_85[6]));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_536_7.INIT0 = 16'h5555;
    defparam add_536_7.INIT1 = 16'h5555;
    defparam add_536_7.INJECT1_0 = "NO";
    defparam add_536_7.INJECT1_1 = "NO";
    CCU2D add_536_5 (.A0(dat_count[3]), .B0(SPI0_SelnSYSUSRnCS_c), .C0(SPI0_SelnSYSUSRnCS_c), 
          .D0(SPI0_SelnSYSUSRnCS_c), .A1(dat_count[4]), .B1(SPI0_SelnSYSUSRnCS_c), 
          .C1(SPI0_SelnSYSUSRnCS_c), .D1(SPI0_SelnSYSUSRnCS_c), .CIN(n4799), 
          .COUT(n4800), .S0(n_dat_count_7__N_85[3]), .S1(n_dat_count_7__N_85[4]));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_536_5.INIT0 = 16'h5555;
    defparam add_536_5.INIT1 = 16'h5555;
    defparam add_536_5.INJECT1_0 = "NO";
    defparam add_536_5.INJECT1_1 = "NO";
    CCU2D add_536_3 (.A0(dat_count[1]), .B0(SPI0_SelnSYSUSRnCS_c), .C0(SPI0_SelnSYSUSRnCS_c), 
          .D0(SPI0_SelnSYSUSRnCS_c), .A1(dat_count[2]), .B1(SPI0_SelnSYSUSRnCS_c), 
          .C1(SPI0_SelnSYSUSRnCS_c), .D1(SPI0_SelnSYSUSRnCS_c), .CIN(n4798), 
          .COUT(n4799), .S0(n_dat_count_7__N_85[1]), .S1(n_dat_count_7__N_85[2]));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_536_3.INIT0 = 16'h5555;
    defparam add_536_3.INIT1 = 16'h5555;
    defparam add_536_3.INJECT1_0 = "NO";
    defparam add_536_3.INJECT1_1 = "NO";
    LUT4 i2_4_lut_adj_80 (.A(clk_enable_27), .B(n_temp1_7__N_32), .C(n4), 
         .D(n5042), .Z(n4819)) /* synthesis lut_function=(A (C+(D))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i2_4_lut_adj_80.init = 16'hffe4;
    LUT4 i3_4_lut_adj_81 (.A(n3_adj_532), .B(n6_adj_541), .C(n2590), .D(n_temp1_7__N_25), 
         .Z(n4910)) /* synthesis lut_function=(A+(B+(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i3_4_lut_adj_81.init = 16'hfeee;
    LUT4 i2_4_lut_adj_82 (.A(clk_enable_27), .B(n4057), .C(n5231), .D(wb_dat_o[2]), 
         .Z(n3_adj_532)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i2_4_lut_adj_82.init = 16'h8000;
    LUT4 i1873_3_lut_rep_51_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_24), 
         .D(n_temp1_7__N_23), .Z(clk_enable_28)) /* synthesis lut_function=(A (B (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i1873_3_lut_rep_51_4_lut.init = 16'h8880;
    LUT4 i1_4_lut_adj_83 (.A(temp1[6]), .B(data0[5]), .C(n30_adj_531), 
         .D(n33), .Z(data0_7__N_9[5])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i1_4_lut_adj_83.init = 16'hdc50;
    LUT4 i1_3_lut_adj_84 (.A(n_state_7__N_402[3]), .B(n_temp1_7__N_32), 
         .C(reg_rdy_N_484), .Z(n5)) /* synthesis lut_function=(A (B)+!A (B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1_3_lut_adj_84.init = 16'hdcdc;
    LUT4 i1045_4_lut (.A(n_temp1_7__N_34), .B(clk_enable_27), .C(n_temp1_7__N_31), 
         .D(n5073), .Z(n3220)) /* synthesis lut_function=(A ((C+(D))+!B)+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1045_4_lut.init = 16'heae2;
    LUT4 i1_2_lut_3_lut_rep_43_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n4053), 
         .D(n5236), .Z(n5232)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i1_2_lut_3_lut_rep_43_4_lut.init = 16'h8000;
    LUT4 i894_2_lut_rep_44_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(reg_rdy_N_484), 
         .D(n_state_7__N_402[3]), .Z(n5233)) /* synthesis lut_function=(!(A (B ((D)+!C)+!B !(C))+!A !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i894_2_lut_rep_44_3_lut_4_lut.init = 16'h70f0;
    LUT4 i1832_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(data0[0]), 
         .Z(n_wb_dat_i_7__N_125[0])) /* synthesis lut_function=(!(A (B+!(C))+!A !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i1832_2_lut_3_lut.init = 16'h7070;
    LUT4 i1_4_lut_adj_85 (.A(temp1[6]), .B(data0[1]), .C(n30_adj_534), 
         .D(n33), .Z(data0_7__N_9[1])) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i1_4_lut_adj_85.init = 16'hdc50;
    LUT4 i56_4_lut_adj_86 (.A(GPI_DAT[1]), .B(data0[1]), .C(temp1[5]), 
         .D(n3451), .Z(n30_adj_534)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(474[6] 480[15])
    defparam i56_4_lut_adj_86.init = 16'hcac0;
    PFUMX i2921 (.BLUT(n5215), .ALUT(n5214), .C0(temp1[1]), .Z(n5216));
    LUT4 i679_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_state_7__N_458[4]), 
         .D(wb_dat_o[4]), .Z(n2640)) /* synthesis lut_function=(!(A (B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i679_3_lut_4_lut.init = 16'h77f7;
    LUT4 i4_4_lut_adj_87 (.A(temp1[0]), .B(n5245), .C(temp1[1]), .D(n6_adj_535), 
         .Z(n3451)) /* synthesis lut_function=(!((B+(C+!(D)))+!A)) */ ;
    defparam i4_4_lut_adj_87.init = 16'h0200;
    LUT4 select_871_Select_6_i13_2_lut (.A(n_state_7__N_458[4]), .B(n_temp1_7__N_24), 
         .Z(n13)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam select_871_Select_6_i13_2_lut.init = 16'h8888;
    FD1P3AX temp3_i0_i6 (.D(n_state_7__N_458[4]), .SP(clk_enable_25), .CK(clk), 
            .Q(temp3[6]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(487[1] 502[11])
    defparam temp3_i0_i6.GSR = "ENABLED";
    FD1P3AX temp3_i0_i5 (.D(wb_dat_o[5]), .SP(clk_enable_25), .CK(clk), 
            .Q(temp3[5]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(487[1] 502[11])
    defparam temp3_i0_i5.GSR = "ENABLED";
    FD1P3AX temp3_i0_i4 (.D(wb_dat_o[4]), .SP(clk_enable_25), .CK(clk), 
            .Q(temp3[4]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(487[1] 502[11])
    defparam temp3_i0_i4.GSR = "ENABLED";
    FD1P3AX temp3_i0_i3 (.D(wb_dat_o[3]), .SP(clk_enable_25), .CK(clk), 
            .Q(temp3[3]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(487[1] 502[11])
    defparam temp3_i0_i3.GSR = "ENABLED";
    FD1S3AX c_state_FSM_i16 (.D(n4918), .CK(clk), .Q(n_temp1_7__N_19));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i16.GSR = "ENABLED";
    LUT4 i2883_4_lut (.A(n14), .B(n5249), .C(n5092), .D(n5246), .Z(n_state_7__N_402[3])) /* synthesis lut_function=(A+(B (C)+!B (C (D)))) */ ;
    defparam i2883_4_lut.init = 16'hfaea;
    LUT4 i1_2_lut_adj_88 (.A(temp1[3]), .B(temp1[2]), .Z(n6_adj_535)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i1_2_lut_adj_88.init = 16'h4444;
    LUT4 i1_2_lut_adj_89 (.A(n_temp1_7__N_31), .B(n46), .Z(n3507)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam i1_2_lut_adj_89.init = 16'heeee;
    LUT4 i1_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(reg_rdy_N_484), 
         .Z(clk_enable_18)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(862[12:33])
    defparam i1_2_lut_3_lut.init = 16'h8080;
    GSR GSR_INST (.GSR(VCC_net));
    FD1S3AX c_state_FSM_i15 (.D(n3194), .CK(clk), .Q(n_temp1_7__N_20));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i15.GSR = "ENABLED";
    FD1S3AX c_state_FSM_i14 (.D(n5030), .CK(clk), .Q(n_temp1_7__N_21));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i14.GSR = "ENABLED";
    FD1P3AX c_state_FSM_i13 (.D(n_temp1_7__N_21), .SP(clk_enable_27), .CK(clk), 
            .Q(n_temp1_7__N_22));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i13.GSR = "ENABLED";
    FD1S3AX c_state_FSM_i12 (.D(n3188), .CK(clk), .Q(n_temp1_7__N_23));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i12.GSR = "ENABLED";
    FD1S3AX c_state_FSM_i11 (.D(n3186), .CK(clk), .Q(n_temp1_7__N_24));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i11.GSR = "ENABLED";
    FD1P3AX c_state_FSM_i10 (.D(n_temp1_7__N_24), .SP(clk_enable_27), .CK(clk), 
            .Q(n_temp1_7__N_25));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i10.GSR = "ENABLED";
    FD1S3AX c_state_FSM_i9 (.D(n3182), .CK(clk), .Q(n_temp1_7__N_26));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i9.GSR = "ENABLED";
    FD1S3AX c_state_FSM_i8 (.D(n3180), .CK(clk), .Q(reg_rdy_N_484));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i8.GSR = "ENABLED";
    FD1S3AX c_state_FSM_i7 (.D(n4815), .CK(clk), .Q(n_temp1_7__N_28));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i7.GSR = "ENABLED";
    FD1S3AX c_state_FSM_i6 (.D(n3170), .CK(clk), .Q(n_temp1_7__N_29));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i6.GSR = "ENABLED";
    FD1S3AX c_state_FSM_i5 (.D(n4814), .CK(clk), .Q(dat_rdy_N_487));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i5.GSR = "ENABLED";
    FD1S3AX c_state_FSM_i4 (.D(n4934), .CK(clk), .Q(n_temp1_7__N_31));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i4.GSR = "ENABLED";
    FD1S3AX c_state_FSM_i3 (.D(n4819), .CK(clk), .Q(n_temp1_7__N_32));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i3.GSR = "ENABLED";
    FD1S3AX c_state_FSM_i2 (.D(n4910), .CK(clk), .Q(n_temp1_7__N_33));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i2.GSR = "ENABLED";
    FD1S3AX c_state_FSM_i1 (.D(n3220), .CK(clk), .Q(n_temp1_7__N_34));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(739[6] 1231[10])
    defparam c_state_FSM_i1.GSR = "ENABLED";
    efb_vhdl dut (.clk(clk), .SPI0_SelnSYSUSRnCS_c(SPI0_SelnSYSUSRnCS_c), 
            .wb_stb_i(wb_stb_i), .wb_we_i(wb_we_i), .\wb_adr_i[2] (wb_adr_i[2]), 
            .\wb_adr_i[1] (wb_adr_i[1]), .\wb_adr_i[0] (wb_adr_i[0]), .wb_dat_i({wb_dat_i}), 
            .\wb_dat_o[7] (wb_dat_o[7]), .\n_state_7__N_458[4] (n_state_7__N_458[4]), 
            .\wb_dat_o[5] (wb_dat_o[5]), .\wb_dat_o[4] (wb_dat_o[4]), .\wb_dat_o[3] (wb_dat_o[3]), 
            .\wb_dat_o[2] (wb_dat_o[2]), .\wb_dat_o[1] (wb_dat_o[1]), .\wb_dat_o[0] (wb_dat_o[0]), 
            .wb_ack_o(wb_ack_o), .i2c1_sdaoen(i2c1_sdaoen), .i2c1_sdao(i2c1_sdao), 
            .i2c1_scloen(i2c1_scloen), .i2c1_sclo(i2c1_sclo), .i2c1_sdai(i2c1_sdai), 
            .i2c1_scli(i2c1_scli)) /* synthesis NGD_DRC_MASK=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(336[7:15])
    OBZ X13_E2C_M62_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(X13_E2C_M62));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(388[1:12])
    FD1P3AX temp1_i0_i6 (.D(n13), .SP(clk_enable_28), .CK(clk), .Q(temp1[6]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(487[1] 502[11])
    defparam temp1_i0_i6.GSR = "ENABLED";
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    OBZ X13_E2C_M59_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(X13_E2C_M59));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(387[1:12])
    OBZ X13_E2C_M58_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(X13_E2C_M58));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(386[1:12])
    OBZ X13_E2C_M55_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(X13_E2C_M55));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(385[1:12])
    PFUMX i2927 (.BLUT(n5251), .ALUT(n5252), .C0(temp1[1]), .Z(n4053));
    OBZ X13_E2C_M54_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(X13_E2C_M54));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(384[1:12])
    TSALL TSALL_INST (.TSALL(SPI0_SelnSYSUSRnCS_c));
    OBZ Xc1_CollFlt_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(Xc1_CollFlt));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(389[1:12])
    OB FP_UsrLED_pad_4 (.I(FP_UsrLED_c_4), .O(FP_UsrLED[4]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(60[3:12])
    OB FP_UsrLED_pad_3 (.I(FP_UsrLED_c_3), .O(FP_UsrLED[3]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(60[3:12])
    OB FP_UsrLED_pad_2 (.I(FP_UsrLED_c_2), .O(FP_UsrLED[2]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(60[3:12])
    OB FP_UsrLED_pad_1 (.I(FP_UsrLED_c_1), .O(FP_UsrLED[1]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(60[3:12])
    OB FP_SysLEDs_pad (.I(FP_SysLEDs_c_3), .O(FP_SysLEDs));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(64[3:13])
    OB SPI0_SelnSYSUSRnCS_pad (.I(SPI0_SelnSYSUSRnCS_c), .O(SPI0_SelnSYSUSRnCS));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(70[3:21])
    OBZ DIG_00_Ch5_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(DIG_00_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    FD1S3IX wb_adr_i_i3 (.D(n3507), .CK(clk), .CD(clk_enable_27), .Q(wb_adr_i[2]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(678[1] 694[10])
    defparam wb_adr_i_i3.GSR = "ENABLED";
    OBZ DIG_01_Ch5_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(DIG_01_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    OBZ DIG_02_Ch5_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(DIG_02_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    FD1S3IX wb_adr_i_i2 (.D(n5038), .CK(clk), .CD(clk_enable_27), .Q(wb_adr_i[1]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(678[1] 694[10])
    defparam wb_adr_i_i2.GSR = "ENABLED";
    OBZ DIG_03_Ch5_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(DIG_03_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    FD1S3IX wb_dat_i_i7 (.D(n_wb_dat_i_7__N_125[7]), .CK(clk), .CD(n3529), 
            .Q(wb_dat_i[7]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(678[1] 694[10])
    defparam wb_dat_i_i7.GSR = "ENABLED";
    OBZ DIG_04_Ch5_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(DIG_04_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    FD1S3IX wb_dat_i_i6 (.D(n_wb_dat_i_7__N_125[6]), .CK(clk), .CD(n3529), 
            .Q(wb_dat_i[6]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(678[1] 694[10])
    defparam wb_dat_i_i6.GSR = "ENABLED";
    OBZ DIG_05_Ch5_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(DIG_05_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    FD1S3IX wb_dat_i_i5 (.D(n_wb_dat_i_7__N_125[5]), .CK(clk), .CD(n3529), 
            .Q(wb_dat_i[5]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(678[1] 694[10])
    defparam wb_dat_i_i5.GSR = "ENABLED";
    OBZ DIG_24_Ch5_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(DIG_24_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    FD1S3IX wb_dat_i_i4 (.D(n_wb_dat_i_7__N_125[4]), .CK(clk), .CD(n3529), 
            .Q(wb_dat_i[4]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(678[1] 694[10])
    defparam wb_dat_i_i4.GSR = "ENABLED";
    OBZ DIG_25_Ch5_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(DIG_25_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    FD1S3AX wb_dat_i_i3 (.D(n_wb_dat_i[3]), .CK(clk), .Q(wb_dat_i[3]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(678[1] 694[10])
    defparam wb_dat_i_i3.GSR = "ENABLED";
    OBZ DIG_26_Ch5_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(DIG_26_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    FD1S3AX wb_dat_i_i2 (.D(n_wb_dat_i[2]), .CK(clk), .Q(wb_dat_i[2]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(678[1] 694[10])
    defparam wb_dat_i_i2.GSR = "ENABLED";
    OBZ DIG_27_Ch5_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(DIG_27_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    FD1S3IX wb_dat_i_i1 (.D(n_wb_dat_i_7__N_125[1]), .CK(clk), .CD(n3529), 
            .Q(wb_dat_i[1]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(678[1] 694[10])
    defparam wb_dat_i_i1.GSR = "ENABLED";
    OBZ DIG_28_Ch5_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(DIG_28_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    OBZ DIG_29_Ch5_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(DIG_29_Ch5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    OBZ S2C_FlexIO_IO0_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(S2C_FlexIO_IO0));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    OBZ S2C_FlexIO_IO1_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(S2C_FlexIO_IO1));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    OBZ S2C_FlexIO_IO2_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(S2C_FlexIO_IO2));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    FD1P3AX dat_count_i0_i3 (.D(n3032), .SP(clk_enable_29), .CK(clk), 
            .Q(dat_count[3]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(699[1] 713[10])
    defparam dat_count_i0_i3.GSR = "ENABLED";
    OBZ S2C_FlexIO_IO3_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(S2C_FlexIO_IO3));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    OBZ S2C_FlexIO_IO4_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(S2C_FlexIO_IO4));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    OBZ S2C_FlexIO_IO5_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(S2C_FlexIO_IO5));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    FD1P3AX GPI_DAT_i0_i7 (.D(X13_C2E_M61_c), .SP(GPI_DAT_7__N_339), .CK(clk), 
            .Q(GPI_DAT[7]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(554[8] 560[15])
    defparam GPI_DAT_i0_i7.GSR = "ENABLED";
    OBZ S2C_FlexIO_IO6_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(S2C_FlexIO_IO6));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
    FD1P3AX GPI_DAT_i0_i6 (.D(PG_VIN_c), .SP(GPI_DAT_7__N_339), .CK(clk), 
            .Q(GPI_DAT[6]));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(554[8] 560[15])
    defparam GPI_DAT_i0_i6.GSR = "ENABLED";
    OBZ S2C_FlexIO_IO7_pad (.I(SPI0_SelnSYSUSRnCS_c), .T(VCC_net), .O(S2C_FlexIO_IO7));   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(391[1:17])
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
    VHI i2986 (.Z(VCC_net));
    
endmodule
//
// Verilog Description of module efb_vhdl
//

module efb_vhdl (clk, SPI0_SelnSYSUSRnCS_c, wb_stb_i, wb_we_i, \wb_adr_i[2] , 
            \wb_adr_i[1] , \wb_adr_i[0] , wb_dat_i, \wb_dat_o[7] , \n_state_7__N_458[4] , 
            \wb_dat_o[5] , \wb_dat_o[4] , \wb_dat_o[3] , \wb_dat_o[2] , 
            \wb_dat_o[1] , \wb_dat_o[0] , wb_ack_o, i2c1_sdaoen, i2c1_sdao, 
            i2c1_scloen, i2c1_sclo, i2c1_sdai, i2c1_scli) /* synthesis NGD_DRC_MASK=1 */ ;
    input clk;
    input SPI0_SelnSYSUSRnCS_c;
    input wb_stb_i;
    input wb_we_i;
    input \wb_adr_i[2] ;
    input \wb_adr_i[1] ;
    input \wb_adr_i[0] ;
    input [7:0]wb_dat_i;
    output \wb_dat_o[7] ;
    output \n_state_7__N_458[4] ;
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
    
    wire clk /* synthesis is_clock=1, SET_AS_NETWORK=clk */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(113[9:12])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/ipexpress/xo2/efb_vhdl.vhd(40[12:21])
    
    wire VCC_net;
    
    EFB EFBInst_0 (.WBCLKI(clk), .WBRSTI(SPI0_SelnSYSUSRnCS_c), .WBCYCI(wb_stb_i), 
        .WBSTBI(wb_stb_i), .WBWEI(wb_we_i), .WBADRI0(\wb_adr_i[0] ), .WBADRI1(\wb_adr_i[1] ), 
        .WBADRI2(\wb_adr_i[2] ), .WBADRI3(SPI0_SelnSYSUSRnCS_c), .WBADRI4(SPI0_SelnSYSUSRnCS_c), 
        .WBADRI5(SPI0_SelnSYSUSRnCS_c), .WBADRI6(wb_stb_i), .WBADRI7(SPI0_SelnSYSUSRnCS_c), 
        .WBDATI0(wb_dat_i[0]), .WBDATI1(wb_dat_i[1]), .WBDATI2(wb_dat_i[2]), 
        .WBDATI3(wb_dat_i[3]), .WBDATI4(wb_dat_i[4]), .WBDATI5(wb_dat_i[5]), 
        .WBDATI6(wb_dat_i[6]), .WBDATI7(wb_dat_i[7]), .I2C1SCLI(i2c1_scli), 
        .I2C1SDAI(i2c1_sdai), .I2C2SCLI(SPI0_SelnSYSUSRnCS_c), .I2C2SDAI(SPI0_SelnSYSUSRnCS_c), 
        .SPISCKI(SPI0_SelnSYSUSRnCS_c), .SPIMISOI(SPI0_SelnSYSUSRnCS_c), 
        .SPIMOSII(SPI0_SelnSYSUSRnCS_c), .SPISCSN(SPI0_SelnSYSUSRnCS_c), 
        .TCCLKI(SPI0_SelnSYSUSRnCS_c), .TCRSTN(SPI0_SelnSYSUSRnCS_c), .TCIC(SPI0_SelnSYSUSRnCS_c), 
        .UFMSN(VCC_net), .PLL0DATI0(SPI0_SelnSYSUSRnCS_c), .PLL0DATI1(SPI0_SelnSYSUSRnCS_c), 
        .PLL0DATI2(SPI0_SelnSYSUSRnCS_c), .PLL0DATI3(SPI0_SelnSYSUSRnCS_c), 
        .PLL0DATI4(SPI0_SelnSYSUSRnCS_c), .PLL0DATI5(SPI0_SelnSYSUSRnCS_c), 
        .PLL0DATI6(SPI0_SelnSYSUSRnCS_c), .PLL0DATI7(SPI0_SelnSYSUSRnCS_c), 
        .PLL0ACKI(SPI0_SelnSYSUSRnCS_c), .PLL1DATI0(SPI0_SelnSYSUSRnCS_c), 
        .PLL1DATI1(SPI0_SelnSYSUSRnCS_c), .PLL1DATI2(SPI0_SelnSYSUSRnCS_c), 
        .PLL1DATI3(SPI0_SelnSYSUSRnCS_c), .PLL1DATI4(SPI0_SelnSYSUSRnCS_c), 
        .PLL1DATI5(SPI0_SelnSYSUSRnCS_c), .PLL1DATI6(SPI0_SelnSYSUSRnCS_c), 
        .PLL1DATI7(SPI0_SelnSYSUSRnCS_c), .PLL1ACKI(SPI0_SelnSYSUSRnCS_c), 
        .WBDATO0(\wb_dat_o[0] ), .WBDATO1(\wb_dat_o[1] ), .WBDATO2(\wb_dat_o[2] ), 
        .WBDATO3(\wb_dat_o[3] ), .WBDATO4(\wb_dat_o[4] ), .WBDATO5(\wb_dat_o[5] ), 
        .WBDATO6(\n_state_7__N_458[4] ), .WBDATO7(\wb_dat_o[7] ), .WBACKO(wb_ack_o), 
        .I2C1SCLO(i2c1_sclo), .I2C1SCLOEN(i2c1_scloen), .I2C1SDAO(i2c1_sdao), 
        .I2C1SDAOEN(i2c1_sdaoen)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=336, LSE_RLINE=336 */ ;   // c:/cpld/cpld_lattice/machxo2/s2c_cpld_lcmxo2-2000hc-4tg100c/s2c_150625/source/v01_0725.vhd(336[7:15])
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
    VHI i1 (.Z(VCC_net));
    
endmodule
//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

