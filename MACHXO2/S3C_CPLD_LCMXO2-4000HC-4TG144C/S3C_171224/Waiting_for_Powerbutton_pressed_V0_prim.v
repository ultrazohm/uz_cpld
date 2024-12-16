// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Mon Dec 16 07:28:20 2024
//
// Verilog Description of module Waiting_for_Powerbutton_pressed_V0
//

module Waiting_for_Powerbutton_pressed_V0 (SCL, SDA, FP_SysLEDg, FP_SysLEDr, 
            FP_SysLEDb, Carrier_PG_3V3, FPIO_FlexMIO52, FPIO_ExternalStop, 
            FPIO_isoCtrlRSTn, SysSW_Pwr_NC, FP_UsrSW1, FP_UsrSW2, FP_UsrSW3, 
            FP_UsrLED1, FP_UsrLED2, FP_UsrLED3, FP_UsrLED4, FP_SysLEDs, 
            Carrier_PG_1V8, SD0_CD, SD1_CD, DIGS3C_Shared_CarrierReady, 
            DIGS3C_Shared_ReqSafeState, DIGS3C_SlotD_ReqOE, DIGS3C_SlotD_SlotOK, 
            SD_SEL, FlexMIOs52_PCIe, FlexMio61ExternalStop, FlexMIOs53_GPIO_PowerDown, 
            ANL_S3C_SLOTOK, ANL_S3C_CarrierReady, ANL_S3C_P54_Legacy, 
            DIGS3C_SlotD_SlotOE, Carrier_PwrOn, PG_VIN, PPn_VIN, PG_Module, 
            TDnSHDN, TDnFFnFS, TDnALERT);   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(7[8:42])
    input SCL /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(12[3:6])
    input SDA /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(13[3:6])
    output FP_SysLEDg;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(15[3:13])
    output FP_SysLEDr;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(16[3:13])
    output FP_SysLEDb;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(17[3:13])
    output Carrier_PG_3V3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(18[3:17])
    output FPIO_FlexMIO52;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(19[3:17])
    input FPIO_ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(20[3:20])
    output FPIO_isoCtrlRSTn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(21[3:19])
    input SysSW_Pwr_NC;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(23[3:15])
    input FP_UsrSW1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(24[3:12])
    input FP_UsrSW2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(25[3:12])
    input FP_UsrSW3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(26[3:12])
    output FP_UsrLED1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(28[3:13])
    output FP_UsrLED2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(29[3:13])
    output FP_UsrLED3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(30[3:13])
    output FP_UsrLED4;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(31[3:13])
    output FP_SysLEDs;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(32[3:13])
    output Carrier_PG_1V8;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(33[3:17])
    input SD0_CD;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(34[3:9])
    input SD1_CD;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(35[3:9])
    output DIGS3C_Shared_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(37[3:29])
    output DIGS3C_Shared_ReqSafeState;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(38[3:29])
    input [5:1]DIGS3C_SlotD_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(40[3:21])
    input [5:1]DIGS3C_SlotD_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(41[3:22])
    output SD_SEL;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(44[3:9])
    input FlexMIOs52_PCIe;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(45[3:18])
    output FlexMio61ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(46[3:24])
    output FlexMIOs53_GPIO_PowerDown;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(47[3:28])
    input [3:1]ANL_S3C_SLOTOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(52[3:17])
    output ANL_S3C_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(53[3:23])
    output ANL_S3C_P54_Legacy;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(54[3:21])
    output [5:1]DIGS3C_SlotD_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(55[3:22])
    output Carrier_PwrOn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(58[9:22])
    input PG_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(59[3:9])
    input PPn_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(60[3:10])
    input PG_Module;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(61[3:12])
    input TDnSHDN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(62[3:10])
    input TDnFFnFS /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(63[3:11])
    input TDnALERT;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(64[3:11])
    
    wire clk /* synthesis is_clock=1, SET_AS_NETWORK=clk */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(70[9:12])
    wire dummy_signal /* synthesis noclip="on" */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(106[9:21])
    
    wire GND_net, VCC_net, FP_SysLEDg_c, FP_SysLEDr_c, FP_SysLEDb_c, 
        Carrier_PG_3V3_c, FPIO_FlexMIO52_c_c, FlexMio61ExternalStop_c_c, 
        FPIO_isoCtrlRSTn_c, SysSW_Pwr_NC_c, FP_UsrSW1_c, FP_UsrSW3_c, 
        FP_SysLEDs_c, DIGS3C_Shared_ReqSafeState_c, DIGS3C_SlotD_ReqOE_c_5, 
        DIGS3C_SlotD_ReqOE_c_4, DIGS3C_SlotD_ReqOE_c_3, DIGS3C_SlotD_ReqOE_c_2, 
        DIGS3C_SlotD_ReqOE_c_1, FlexMIOs53_GPIO_PowerDown_c, n40_adj_1, 
        DIGS3C_SlotD_SlotOE_c_5, DIGS3C_SlotD_SlotOE_c_4, DIGS3C_SlotD_SlotOE_c_3, 
        DIGS3C_SlotD_SlotOE_c_2, DIGS3C_SlotD_SlotOE_c_1, Carrier_PwrOn_c, 
        PG_VIN_c, PPn_VIN_c, TDnSHDN_c, TDnFFnFS_c, TDnALERT_c;
    wire [21:0]counter;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(71[9:16])
    wire [3:0]next_state;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(77[12:22])
    wire [31:0]\debounce_counters[1] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(84[12:29])
    wire [4:1]button_inputs_asyn1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(86[12:31])
    wire [4:1]button_inputs_asyn2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(87[9:28])
    wire [4:1]pushed;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(88[9:15])
    
    wire forceoutputdisable, n2518, n22, n23, n24, n25, n26, n27, 
        n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, 
        n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, 
        n48, n49, n50, n51, n52, n53, n2528, n2527, n2939, 
        n2517, n2526, n2515, n2516, n3001, n2514, n2525, n2513, 
        n2524, n2512, n2523, pushed_1__N_181, n38_adj_2, n2511, 
        n2522, clk_enable_2, n2510, n2521, n2509, n2508, n23_adj_3, 
        n2996, n2891, clk_enable_68, n2928, n2890, n2995, n2937, 
        n36_adj_4, n2889, n2507, n34_adj_5, n2506, clk_enable_4, 
        clk_enable_1, n1851, FPIO_isoCtrlRSTn_N_462, n2505, n2504, 
        n2884, clk_enable_67, clk_enable_69, n2520, clk_enable_7, 
        n2994, n2503, n2883, n2882, n1463, n1462, n1461, n1460, 
        n1459, n1458, n1457, n1456, n1455, n1454, n1453, n1452, 
        n2502, n2501;
    wire [3:0]next_state_3__N_322;
    
    wire n2880, n881, n882, n883, n884, n885, n886, n887, n888, 
        n889, n890, n891, n892, n893, n894, n895, n896, n897, 
        n898, n899, n900, n901, n902, n1451, n1450, n1449, n1448, 
        n1447, n1446, n1445, n1444, n1443, n1442, n2879, forceoutputdisable_N_3, 
        DIGS3C_Shared_ReqSafeState_N_467, FlexMIOs53_GPIO_PowerDown_N_469, 
        FP_SysLEDr_N_453, FP_SysLEDb_N_454, FP_SysLEDg_N_452;
    wire [3:0]next_state_3__N_28;
    
    wire Carrier_PwrOn_N_472, FPIO_isoCtrlRSTn_N_460, n2943, n30_adj_6, 
        n2529, n1843, n2993, n2936, Carrier_PG_1V8_N_479, Carrier_PG_1V8_N_483, 
        Carrier_PG_1V8_N_466, n2992, n1518, n29_adj_7, n2850, n2500, 
        n23_adj_8, n2499, n2498, n2954, n39_adj_9, n45_adj_10, n2953, 
        n18, n2497, n2952, n2496, n2495, clk_enable_64, n2856, 
        clk_enable_32, n6, n2494, n2493, n2855, n2998, n2492, 
        clk_enable_65, n4, n26_adj_11, n2950, n2991, n2370, n2491, 
        n4_adj_12, n2949, n2935, n2934, n2854, n2947, n42_adj_13, 
        n2946, n2940, n2944, n2541, clk_enable_63, n2519, clk_enable_66, 
        clk_enable_10, clk_enable_3, n2997;
    
    VHI i2 (.Z(VCC_net));
    FD1S3AY button_inputs_asyn2_i1 (.D(button_inputs_asyn1[1]), .CK(clk), 
            .Q(button_inputs_asyn2[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam button_inputs_asyn2_i1.GSR = "ENABLED";
    LUT4 FPIO_isoCtrlRSTn_N_462_bdd_4_lut_1331 (.A(FPIO_isoCtrlRSTn_N_462), 
         .B(next_state[2]), .C(next_state_3__N_322[2]), .D(next_state[0]), 
         .Z(n2890)) /* synthesis lut_function=(!(A ((C (D))+!B)+!A ((C+!(D))+!B))) */ ;
    defparam FPIO_isoCtrlRSTn_N_462_bdd_4_lut_1331.init = 16'h0c88;
    FD1P3IX pushed_i1 (.D(n3001), .SP(clk_enable_1), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(pushed[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam pushed_i1.GSR = "ENABLED";
    LUT4 i968_2_lut_3_lut (.A(n2928), .B(n1518), .C(n886), .Z(n1447)) /* synthesis lut_function=(A+((C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i968_2_lut_3_lut.init = 16'hfbfb;
    FD1S3AY buttons_debounced_syn_i1 (.D(pushed_1__N_181), .CK(clk), .Q(next_state_3__N_322[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam buttons_debounced_syn_i1.GSR = "ENABLED";
    LUT4 FPIO_isoCtrlRSTn_N_462_bdd_2_lut_1328 (.A(FPIO_isoCtrlRSTn_N_462), 
         .B(next_state[2]), .Z(n2889)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam FPIO_isoCtrlRSTn_N_462_bdd_2_lut_1328.init = 16'h2222;
    FD1P3AX forceoutputdisable_164 (.D(forceoutputdisable_N_3), .SP(clk_enable_2), 
            .CK(clk), .Q(forceoutputdisable));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam forceoutputdisable_164.GSR = "ENABLED";
    FD1P3AX FPIO_isoCtrlRSTn_173 (.D(FPIO_isoCtrlRSTn_N_460), .SP(clk_enable_3), 
            .CK(clk), .Q(FPIO_isoCtrlRSTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam FPIO_isoCtrlRSTn_173.GSR = "ENABLED";
    TSALL TSALL_INST (.TSALL(GND_net));
    CCU2D add_200_9 (.A0(counter[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[8]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2510), .COUT(n2511), .S0(n895), .S1(n894));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(306[17:24])
    defparam add_200_9.INIT0 = 16'h5555;
    defparam add_200_9.INIT1 = 16'h5555;
    defparam add_200_9.INJECT1_0 = "NO";
    defparam add_200_9.INJECT1_1 = "NO";
    LUT4 next_state_3__I_0_181_Mux_3_i15_4_lut_else_4_lut (.A(next_state_3__N_322[2]), 
         .B(next_state[2]), .C(next_state[0]), .D(FPIO_isoCtrlRSTn_N_462), 
         .Z(n2949)) /* synthesis lut_function=(!(A+((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam next_state_3__I_0_181_Mux_3_i15_4_lut_else_4_lut.init = 16'h0004;
    CCU2D add_200_21 (.A0(counter[19]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[20]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2516), .COUT(n2517), .S0(n883), .S1(n882));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(306[17:24])
    defparam add_200_21.INIT0 = 16'h5555;
    defparam add_200_21.INIT1 = 16'h5555;
    defparam add_200_21.INJECT1_0 = "NO";
    defparam add_200_21.INJECT1_1 = "NO";
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk)) /* synthesis NOM_FREQ="2.08", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "2.08";
    LUT4 next_state_1__bdd_2_lut_1323 (.A(FPIO_isoCtrlRSTn_N_462), .B(next_state[2]), 
         .Z(n2854)) /* synthesis lut_function=(!(A+(B))) */ ;
    defparam next_state_1__bdd_2_lut_1323.init = 16'h1111;
    CCU2D add_200_19 (.A0(counter[17]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[18]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2515), .COUT(n2516), .S0(n885), .S1(n884));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(306[17:24])
    defparam add_200_19.INIT0 = 16'h5555;
    defparam add_200_19.INIT1 = 16'h5555;
    defparam add_200_19.INJECT1_0 = "NO";
    defparam add_200_19.INJECT1_1 = "NO";
    FD1P3AX FlexMIOs53_GPIO_PowerDown_166 (.D(FlexMIOs53_GPIO_PowerDown_N_469), 
            .SP(clk_enable_4), .CK(clk), .Q(FlexMIOs53_GPIO_PowerDown_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam FlexMIOs53_GPIO_PowerDown_166.GSR = "ENABLED";
    FD1P3AX FP_SysLEDr_167 (.D(FP_SysLEDr_N_453), .SP(clk_enable_7), .CK(clk), 
            .Q(FP_SysLEDr_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam FP_SysLEDr_167.GSR = "ENABLED";
    FD1P3AX FP_SysLEDb_168 (.D(FP_SysLEDb_N_454), .SP(clk_enable_7), .CK(clk), 
            .Q(FP_SysLEDb_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam FP_SysLEDb_168.GSR = "ENABLED";
    FD1P3AX FP_SysLEDg_169 (.D(FP_SysLEDg_N_452), .SP(clk_enable_7), .CK(clk), 
            .Q(FP_SysLEDg_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam FP_SysLEDg_169.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i0 (.D(n53), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i0.GSR = "ENABLED";
    FD1P3AX Carrier_PwrOn_171 (.D(Carrier_PwrOn_N_472), .SP(clk_enable_10), 
            .CK(clk), .Q(Carrier_PwrOn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam Carrier_PwrOn_171.GSR = "ENABLED";
    FD1P3AX Carrier_PG_3V3_172 (.D(Carrier_PwrOn_N_472), .SP(clk_enable_10), 
            .CK(clk), .Q(Carrier_PG_3V3_c)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam Carrier_PG_3V3_172.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn1_i1 (.D(SysSW_Pwr_NC_c), .CK(clk), .Q(button_inputs_asyn1[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam button_inputs_asyn1_i1.GSR = "ENABLED";
    FD1P3AX i152_177 (.D(Carrier_PG_1V8_N_483), .SP(Carrier_PG_1V8_N_479), 
            .CK(clk), .Q(Carrier_PG_1V8_N_466));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam i152_177.GSR = "ENABLED";
    LUT4 i1_2_lut_3_lut_4_lut (.A(next_state[2]), .B(next_state_3__N_322[2]), 
         .C(next_state[3]), .D(FPIO_isoCtrlRSTn_N_462), .Z(FlexMIOs53_GPIO_PowerDown_N_469)) /* synthesis lut_function=(!((B+(C+!(D)))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam i1_2_lut_3_lut_4_lut.init = 16'h0200;
    LUT4 i2_3_lut_rep_62_4_lut (.A(next_state[2]), .B(next_state_3__N_322[2]), 
         .C(n2935), .D(next_state[1]), .Z(n2928)) /* synthesis lut_function=(!((B+((D)+!C))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam i2_3_lut_rep_62_4_lut.init = 16'h0020;
    LUT4 i21_4_lut (.A(n29_adj_7), .B(n42_adj_13), .C(n38_adj_2), .D(n30_adj_6), 
         .Z(FPIO_isoCtrlRSTn_N_462)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i21_4_lut.init = 16'hfffe;
    LUT4 i478_4_lut_else_4_lut (.A(next_state[2]), .B(next_state_3__N_322[2]), 
         .C(next_state[1]), .D(next_state[0]), .Z(n2991)) /* synthesis lut_function=(!(A+(B (C+(D))+!B (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i478_4_lut_else_4_lut.init = 16'h0015;
    LUT4 i1_4_lut_then_4_lut (.A(next_state[0]), .B(next_state_3__N_322[2]), 
         .C(next_state[3]), .D(next_state[2]), .Z(n2953)) /* synthesis lut_function=(!(A+(B+((D)+!C)))) */ ;
    defparam i1_4_lut_then_4_lut.init = 16'h0010;
    CCU2D add_14_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[1] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n2491), .S1(n53));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_1.INIT0 = 16'hF000;
    defparam add_14_1.INIT1 = 16'h5555;
    defparam add_14_1.INJECT1_0 = "NO";
    defparam add_14_1.INJECT1_1 = "NO";
    CCU2D add_200_17 (.A0(counter[15]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[16]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2514), .COUT(n2515), .S0(n887), .S1(n886));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(306[17:24])
    defparam add_200_17.INIT0 = 16'h5555;
    defparam add_200_17.INIT1 = 16'h5555;
    defparam add_200_17.INJECT1_0 = "NO";
    defparam add_200_17.INJECT1_1 = "NO";
    LUT4 i1_4_lut_else_4_lut (.A(next_state[0]), .B(next_state[3]), .C(next_state[2]), 
         .D(FPIO_isoCtrlRSTn_N_462), .Z(n2952)) /* synthesis lut_function=(!(A ((C+!(D))+!B)+!A ((C)+!B))) */ ;
    defparam i1_4_lut_else_4_lut.init = 16'h0c04;
    OB FP_SysLEDg_pad (.I(FP_SysLEDg_c), .O(FP_SysLEDg));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(15[3:13])
    LUT4 i2_3_lut_4_lut (.A(next_state[2]), .B(next_state[1]), .C(FPIO_isoCtrlRSTn_N_462), 
         .D(next_state[0]), .Z(n2541)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;
    defparam i2_3_lut_4_lut.init = 16'h1000;
    CCU2D add_200_7 (.A0(counter[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2509), .COUT(n2510), .S0(n897), .S1(n896));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(306[17:24])
    defparam add_200_7.INIT0 = 16'h5555;
    defparam add_200_7.INIT1 = 16'h5555;
    defparam add_200_7.INJECT1_0 = "NO";
    defparam add_200_7.INJECT1_1 = "NO";
    CCU2D add_200_5 (.A0(counter[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2508), .COUT(n2509), .S0(n899), .S1(n898));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(306[17:24])
    defparam add_200_5.INIT0 = 16'h5555;
    defparam add_200_5.INIT1 = 16'h5555;
    defparam add_200_5.INJECT1_0 = "NO";
    defparam add_200_5.INJECT1_1 = "NO";
    IB TDnALERT_pad (.I(TDnALERT), .O(TDnALERT_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(64[3:11])
    FD1P3IX counter__i1 (.D(n1462), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i1.GSR = "ENABLED";
    IB TDnFFnFS_pad (.I(TDnFFnFS), .O(TDnFFnFS_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(63[3:11])
    IB TDnSHDN_pad (.I(TDnSHDN), .O(TDnSHDN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(62[3:10])
    CCU2D add_200_3 (.A0(counter[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2507), .COUT(n2508), .S0(n901), .S1(n900));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(306[17:24])
    defparam add_200_3.INIT0 = 16'h5555;
    defparam add_200_3.INIT1 = 16'h5555;
    defparam add_200_3.INJECT1_0 = "NO";
    defparam add_200_3.INJECT1_1 = "NO";
    LUT4 i3_4_lut (.A(TDnALERT_c), .B(PG_VIN_c), .C(TDnSHDN_c), .D(TDnFFnFS_c), 
         .Z(dummy_signal)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(122[17:61])
    defparam i3_4_lut.init = 16'h8000;
    IB PPn_VIN_pad (.I(PPn_VIN), .O(PPn_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(60[3:10])
    LUT4 i4_2_lut (.A(counter[0]), .B(counter[21]), .Z(n26_adj_11)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i4_2_lut.init = 16'heeee;
    LUT4 i1_4_lut_4_lut (.A(next_state[2]), .B(next_state_3__N_322[2]), 
         .C(FPIO_isoCtrlRSTn_N_462), .D(next_state[0]), .Z(n4_adj_12)) /* synthesis lut_function=(A (B (D)+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam i1_4_lut_4_lut.init = 16'h8820;
    IB PG_VIN_pad (.I(PG_VIN), .O(PG_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(59[3:9])
    IB FPIO_FlexMIO52_c_pad (.I(FlexMIOs52_PCIe), .O(FPIO_FlexMIO52_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(45[3:18])
    IB DIGS3C_SlotD_ReqOE_pad_1 (.I(DIGS3C_SlotD_ReqOE[1]), .O(DIGS3C_SlotD_ReqOE_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(40[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_2 (.I(DIGS3C_SlotD_ReqOE[2]), .O(DIGS3C_SlotD_ReqOE_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(40[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_3 (.I(DIGS3C_SlotD_ReqOE[3]), .O(DIGS3C_SlotD_ReqOE_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(40[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_4 (.I(DIGS3C_SlotD_ReqOE[4]), .O(DIGS3C_SlotD_ReqOE_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(40[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_5 (.I(DIGS3C_SlotD_ReqOE[5]), .O(DIGS3C_SlotD_ReqOE_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(40[3:21])
    IB FP_UsrSW3_pad (.I(FP_UsrSW3), .O(FP_UsrSW3_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(26[3:12])
    IB FP_UsrSW1_pad (.I(FP_UsrSW1), .O(FP_UsrSW1_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(24[3:12])
    IB SysSW_Pwr_NC_pad (.I(SysSW_Pwr_NC), .O(SysSW_Pwr_NC_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(23[3:15])
    IB FlexMio61ExternalStop_c_pad (.I(FPIO_ExternalStop), .O(FlexMio61ExternalStop_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(20[3:20])
    OB Carrier_PwrOn_pad (.I(Carrier_PwrOn_c), .O(Carrier_PwrOn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(58[9:22])
    OB DIGS3C_SlotD_SlotOE_pad_1 (.I(DIGS3C_SlotD_SlotOE_c_1), .O(DIGS3C_SlotD_SlotOE[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(55[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_2 (.I(DIGS3C_SlotD_SlotOE_c_2), .O(DIGS3C_SlotD_SlotOE[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(55[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_3 (.I(DIGS3C_SlotD_SlotOE_c_3), .O(DIGS3C_SlotD_SlotOE[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(55[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_4 (.I(DIGS3C_SlotD_SlotOE_c_4), .O(DIGS3C_SlotD_SlotOE[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(55[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_5 (.I(DIGS3C_SlotD_SlotOE_c_5), .O(DIGS3C_SlotD_SlotOE[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(55[3:22])
    OB ANL_S3C_P54_Legacy_pad (.I(GND_net), .O(ANL_S3C_P54_Legacy));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(54[3:21])
    OB ANL_S3C_CarrierReady_pad (.I(GND_net), .O(ANL_S3C_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(53[3:23])
    OB FlexMIOs53_GPIO_PowerDown_pad (.I(FlexMIOs53_GPIO_PowerDown_c), .O(FlexMIOs53_GPIO_PowerDown));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(47[3:28])
    OB FlexMio61ExternalStop_pad (.I(FlexMio61ExternalStop_c_c), .O(FlexMio61ExternalStop));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(46[3:24])
    OB SD_SEL_pad (.I(GND_net), .O(SD_SEL));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(44[3:9])
    OB DIGS3C_Shared_ReqSafeState_pad (.I(DIGS3C_Shared_ReqSafeState_c), .O(DIGS3C_Shared_ReqSafeState));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(38[3:29])
    OB DIGS3C_Shared_CarrierReady_pad (.I(GND_net), .O(DIGS3C_Shared_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(37[3:29])
    OBZ n1850_pad (.I(GND_net), .T(n1851), .O(Carrier_PG_1V8));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(175[1] 327[13])
    OB FP_SysLEDs_pad (.I(FP_SysLEDs_c), .O(FP_SysLEDs));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(32[3:13])
    OB FP_UsrLED4_pad (.I(GND_net), .O(FP_UsrLED4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(31[3:13])
    OB FP_UsrLED3_pad (.I(GND_net), .O(FP_UsrLED3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(30[3:13])
    OB FP_UsrLED2_pad (.I(GND_net), .O(FP_UsrLED2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(29[3:13])
    OB FP_UsrLED1_pad (.I(GND_net), .O(FP_UsrLED1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(28[3:13])
    OB FPIO_isoCtrlRSTn_pad (.I(FPIO_isoCtrlRSTn_c), .O(FPIO_isoCtrlRSTn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(21[3:19])
    OB FPIO_FlexMIO52_pad (.I(FPIO_FlexMIO52_c_c), .O(FPIO_FlexMIO52));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(19[3:17])
    OB Carrier_PG_3V3_pad (.I(Carrier_PG_3V3_c), .O(Carrier_PG_3V3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(18[3:17])
    OB FP_SysLEDb_pad (.I(FP_SysLEDb_c), .O(FP_SysLEDb));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(17[3:13])
    OB FP_SysLEDr_pad (.I(FP_SysLEDr_c), .O(FP_SysLEDr));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(16[3:13])
    PFUMX i1362 (.BLUT(n2994), .ALUT(n2995), .C0(next_state[1]), .Z(n2996));
    CCU2D add_200_15 (.A0(counter[13]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[14]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2513), .COUT(n2514), .S0(n889), .S1(n888));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(306[17:24])
    defparam add_200_15.INIT0 = 16'h5555;
    defparam add_200_15.INIT1 = 16'h5555;
    defparam add_200_15.INJECT1_0 = "NO";
    defparam add_200_15.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut (.A(next_state[1]), .B(next_state[2]), .C(next_state[3]), 
         .Z(FPIO_isoCtrlRSTn_N_460)) /* synthesis lut_function=(!((B+(C))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam i1_2_lut_3_lut.init = 16'h0202;
    LUT4 i1276_2_lut_rep_68 (.A(next_state[3]), .B(next_state[1]), .Z(n2934)) /* synthesis lut_function=(!(A+(B))) */ ;
    defparam i1276_2_lut_rep_68.init = 16'h1111;
    LUT4 i48_4_lut_3_lut (.A(next_state[3]), .B(next_state[1]), .C(next_state_3__N_322[2]), 
         .Z(n23_adj_3)) /* synthesis lut_function=(!(A ((C)+!B)+!A (B+!(C)))) */ ;
    defparam i48_4_lut_3_lut.init = 16'h1818;
    LUT4 i981_3_lut_4_lut (.A(next_state[1]), .B(next_state[0]), .C(next_state[3]), 
         .D(next_state[2]), .Z(Carrier_PG_1V8_N_483)) /* synthesis lut_function=(A ((C+(D))+!B)+!A (B+(C+(D)))) */ ;
    defparam i981_3_lut_4_lut.init = 16'hfff6;
    LUT4 i1279_3_lut_4_lut (.A(next_state[1]), .B(next_state[0]), .C(next_state[2]), 
         .D(next_state[3]), .Z(clk_enable_32)) /* synthesis lut_function=(A (B+(C+!(D)))+!A ((C+!(D))+!B)) */ ;
    defparam i1279_3_lut_4_lut.init = 16'hf9ff;
    LUT4 FPIO_isoCtrlRSTn_N_462_bdd_2_lut_1315 (.A(FPIO_isoCtrlRSTn_N_462), 
         .B(next_state[3]), .Z(n2882)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam FPIO_isoCtrlRSTn_N_462_bdd_2_lut_1315.init = 16'h2222;
    PFUMX i1311 (.BLUT(n2880), .ALUT(n2879), .C0(next_state[3]), .Z(forceoutputdisable_N_3));
    FD1P3IX counter__i2 (.D(n1461), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i2.GSR = "ENABLED";
    FD1P3IX counter__i3 (.D(n1460), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i3.GSR = "ENABLED";
    FD1P3IX counter__i4 (.D(n1459), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i4.GSR = "ENABLED";
    FD1P3IX counter__i5 (.D(n1458), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i5.GSR = "ENABLED";
    FD1P3IX counter__i6 (.D(n1457), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i6.GSR = "ENABLED";
    FD1P3IX counter__i7 (.D(n1456), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i7.GSR = "ENABLED";
    FD1P3IX counter__i8 (.D(n1455), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i8.GSR = "ENABLED";
    FD1P3IX counter__i9 (.D(n1454), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i9.GSR = "ENABLED";
    FD1P3IX counter__i10 (.D(n1453), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i10.GSR = "ENABLED";
    FD1P3IX counter__i11 (.D(n1452), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i11.GSR = "ENABLED";
    FD1P3IX counter__i12 (.D(n1451), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i12.GSR = "ENABLED";
    FD1P3IX counter__i13 (.D(n1450), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i13.GSR = "ENABLED";
    FD1P3IX counter__i14 (.D(n1449), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i14.GSR = "ENABLED";
    FD1P3IX counter__i15 (.D(n1448), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i15.GSR = "ENABLED";
    FD1P3IX counter__i16 (.D(n1447), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i16.GSR = "ENABLED";
    FD1P3IX counter__i17 (.D(n1446), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i17.GSR = "ENABLED";
    FD1P3IX counter__i18 (.D(n1445), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i18.GSR = "ENABLED";
    FD1P3IX counter__i19 (.D(n1444), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i19.GSR = "ENABLED";
    FD1P3IX counter__i20 (.D(n1443), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i20.GSR = "ENABLED";
    FD1P3IX counter__i21 (.D(n1442), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i21.GSR = "ENABLED";
    LUT4 i1_2_lut_rep_69 (.A(next_state[0]), .B(next_state[3]), .Z(n2935)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam i1_2_lut_rep_69.init = 16'h2222;
    LUT4 i1_2_lut_3_lut_adj_1 (.A(next_state[0]), .B(next_state[3]), .C(next_state[2]), 
         .Z(Carrier_PwrOn_N_472)) /* synthesis lut_function=(!((B+(C))+!A)) */ ;
    defparam i1_2_lut_3_lut_adj_1.init = 16'h0202;
    LUT4 i1_4_lut_then_3_lut (.A(FPIO_isoCtrlRSTn_N_462), .B(next_state[3]), 
         .C(next_state[0]), .Z(n2995)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i1_4_lut_then_3_lut.init = 16'h1010;
    LUT4 n2541_bdd_4_lut (.A(next_state[0]), .B(next_state[2]), .C(next_state[1]), 
         .D(next_state_3__N_322[2]), .Z(n2850)) /* synthesis lut_function=(!(A (B+!(C))+!A !(B+(C+!(D))))) */ ;
    defparam n2541_bdd_4_lut.init = 16'h7475;
    LUT4 i1286_4_lut (.A(n2996), .B(next_state[2]), .C(n45_adj_10), .D(n4), 
         .Z(clk_enable_65)) /* synthesis lut_function=(!(A+(B (C)+!B (C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i1286_4_lut.init = 16'h0405;
    LUT4 i1_4_lut (.A(next_state[3]), .B(next_state[1]), .C(n39_adj_9), 
         .D(n2370), .Z(n45_adj_10)) /* synthesis lut_function=(!(A+!(B (C)+!B (C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i1_4_lut.init = 16'h5051;
    LUT4 i40_2_lut (.A(next_state[0]), .B(next_state_3__N_322[2]), .Z(n23_adj_8)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;
    defparam i40_2_lut.init = 16'h6666;
    LUT4 i1_3_lut (.A(next_state[0]), .B(next_state[3]), .C(next_state[1]), 
         .Z(n4)) /* synthesis lut_function=(!(A+!(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i1_3_lut.init = 16'h4545;
    LUT4 i1288_4_lut (.A(next_state[2]), .B(next_state[0]), .C(n2884), 
         .D(n23_adj_3), .Z(clk_enable_68)) /* synthesis lut_function=(A+!(B (C)+!B (C+(D)))) */ ;
    defparam i1288_4_lut.init = 16'haeaf;
    LUT4 m1_lut (.Z(n3001)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    LUT4 i1_4_lut_adj_2 (.A(next_state[2]), .B(next_state_3__N_322[2]), 
         .C(next_state[1]), .D(next_state[0]), .Z(n39_adj_9)) /* synthesis lut_function=(A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i1_4_lut_adj_2.init = 16'ha8a0;
    CCU2D add_200_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n2507), .S1(n902));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(306[17:24])
    defparam add_200_1.INIT0 = 16'hF000;
    defparam add_200_1.INIT1 = 16'h5555;
    defparam add_200_1.INJECT1_0 = "NO";
    defparam add_200_1.INJECT1_1 = "NO";
    CCU2D add_14_33 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2506), .S0(n22));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_33.INIT0 = 16'h5aaa;
    defparam add_14_33.INIT1 = 16'h0000;
    defparam add_14_33.INJECT1_0 = "NO";
    defparam add_14_33.INJECT1_1 = "NO";
    LUT4 i676_4_lut (.A(next_state[2]), .B(next_state[0]), .C(next_state_3__N_322[2]), 
         .D(FPIO_isoCtrlRSTn_N_462), .Z(n2370)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i676_4_lut.init = 16'hfaca;
    CCU2D add_14_31 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2505), .COUT(n2506), .S0(n24), 
          .S1(n23));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_31.INIT0 = 16'h5aaa;
    defparam add_14_31.INIT1 = 16'h5aaa;
    defparam add_14_31.INJECT1_0 = "NO";
    defparam add_14_31.INJECT1_1 = "NO";
    CCU2D add_14_29 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2504), .COUT(n2505), .S0(n26), 
          .S1(n25));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_29.INIT0 = 16'h5aaa;
    defparam add_14_29.INIT1 = 16'h5aaa;
    defparam add_14_29.INJECT1_0 = "NO";
    defparam add_14_29.INJECT1_1 = "NO";
    CCU2D add_1033_18 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2525), .COUT(n2526));
    defparam add_1033_18.INIT0 = 16'h5555;
    defparam add_1033_18.INIT1 = 16'h5555;
    defparam add_1033_18.INJECT1_0 = "NO";
    defparam add_1033_18.INJECT1_1 = "NO";
    PFUMX i1307 (.BLUT(n2855), .ALUT(n2854), .C0(next_state[1]), .Z(n2856));
    CCU2D add_200_13 (.A0(counter[11]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[12]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2512), .COUT(n2513), .S0(n891), .S1(n890));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(306[17:24])
    defparam add_200_13.INIT0 = 16'h5555;
    defparam add_200_13.INIT1 = 16'h5555;
    defparam add_200_13.INJECT1_0 = "NO";
    defparam add_200_13.INJECT1_1 = "NO";
    CCU2D add_1033_16 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2524), .COUT(n2525));
    defparam add_1033_16.INIT0 = 16'h5555;
    defparam add_1033_16.INIT1 = 16'h5555;
    defparam add_1033_16.INJECT1_0 = "NO";
    defparam add_1033_16.INJECT1_1 = "NO";
    CCU2D add_14_27 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2503), .COUT(n2504), .S0(n28), 
          .S1(n27));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_27.INIT0 = 16'h5aaa;
    defparam add_14_27.INIT1 = 16'h5aaa;
    defparam add_14_27.INJECT1_0 = "NO";
    defparam add_14_27.INJECT1_1 = "NO";
    CCU2D add_200_11 (.A0(counter[9]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[10]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2511), .COUT(n2512), .S0(n893), .S1(n892));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(306[17:24])
    defparam add_200_11.INIT0 = 16'h5555;
    defparam add_200_11.INIT1 = 16'h5555;
    defparam add_200_11.INJECT1_0 = "NO";
    defparam add_200_11.INJECT1_1 = "NO";
    CCU2D add_14_25 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2502), .COUT(n2503), .S0(n30), 
          .S1(n29));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_25.INIT0 = 16'h5aaa;
    defparam add_14_25.INIT1 = 16'h5aaa;
    defparam add_14_25.INJECT1_0 = "NO";
    defparam add_14_25.INJECT1_1 = "NO";
    CCU2D add_1033_14 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2523), .COUT(n2524));
    defparam add_1033_14.INIT0 = 16'h5555;
    defparam add_1033_14.INIT1 = 16'h5555;
    defparam add_1033_14.INJECT1_0 = "NO";
    defparam add_1033_14.INJECT1_1 = "NO";
    CCU2D add_14_23 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2501), .COUT(n2502), .S0(n32), 
          .S1(n31));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_23.INIT0 = 16'h5aaa;
    defparam add_14_23.INIT1 = 16'h5aaa;
    defparam add_14_23.INJECT1_0 = "NO";
    defparam add_14_23.INJECT1_1 = "NO";
    CCU2D add_1033_12 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2522), .COUT(n2523));
    defparam add_1033_12.INIT0 = 16'h5555;
    defparam add_1033_12.INIT1 = 16'h5555;
    defparam add_1033_12.INJECT1_0 = "NO";
    defparam add_1033_12.INJECT1_1 = "NO";
    CCU2D add_14_21 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2500), .COUT(n2501), .S0(n34), 
          .S1(n33));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_21.INIT0 = 16'h5aaa;
    defparam add_14_21.INIT1 = 16'h5aaa;
    defparam add_14_21.INJECT1_0 = "NO";
    defparam add_14_21.INJECT1_1 = "NO";
    CCU2D add_1033_10 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2521), .COUT(n2522));
    defparam add_1033_10.INIT0 = 16'h5555;
    defparam add_1033_10.INIT1 = 16'h5555;
    defparam add_1033_10.INJECT1_0 = "NO";
    defparam add_1033_10.INJECT1_1 = "NO";
    CCU2D add_14_19 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2499), .COUT(n2500), .S0(n36), 
          .S1(n35));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_19.INIT0 = 16'h5aaa;
    defparam add_14_19.INIT1 = 16'h5aaa;
    defparam add_14_19.INJECT1_0 = "NO";
    defparam add_14_19.INJECT1_1 = "NO";
    LUT4 i973_2_lut_3_lut (.A(n2928), .B(n1518), .C(n898), .Z(n1459)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i973_2_lut_3_lut.init = 16'h4040;
    LUT4 i1_4_lut_else_3_lut (.A(FPIO_isoCtrlRSTn_N_462), .B(next_state[2]), 
         .C(next_state[3]), .Z(n2994)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i1_4_lut_else_3_lut.init = 16'h1010;
    CCU2D add_14_17 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2498), .COUT(n2499), .S0(n38), 
          .S1(n37));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_17.INIT0 = 16'h5aaa;
    defparam add_14_17.INIT1 = 16'h5aaa;
    defparam add_14_17.INJECT1_0 = "NO";
    defparam add_14_17.INJECT1_1 = "NO";
    FD1P3AX DIGS3C_Shared_ReqSafeState_165 (.D(DIGS3C_Shared_ReqSafeState_N_467), 
            .SP(clk_enable_32), .CK(clk), .Q(DIGS3C_Shared_ReqSafeState_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam DIGS3C_Shared_ReqSafeState_165.GSR = "ENABLED";
    LUT4 i7_2_lut (.A(counter[13]), .B(counter[16]), .Z(n29_adj_7)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i7_2_lut.init = 16'heeee;
    LUT4 i972_2_lut_3_lut (.A(n2928), .B(n1518), .C(n897), .Z(n1458)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i972_2_lut_3_lut.init = 16'h4040;
    LUT4 i1281_3_lut_4_lut_4_lut_then_4_lut (.A(next_state[3]), .B(FPIO_isoCtrlRSTn_N_462), 
         .C(next_state[0]), .D(next_state[2]), .Z(n2940)) /* synthesis lut_function=(A+(B (C (D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam i1281_3_lut_4_lut_4_lut_then_4_lut.init = 16'hfaba;
    CCU2D add_14_15 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2497), .COUT(n2498), .S0(n40), 
          .S1(n39));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_15.INIT0 = 16'h5aaa;
    defparam add_14_15.INIT1 = 16'h5aaa;
    defparam add_14_15.INJECT1_0 = "NO";
    defparam add_14_15.INJECT1_1 = "NO";
    LUT4 i932_4_lut_4_lut_then_3_lut (.A(next_state[3]), .B(next_state[0]), 
         .C(next_state_3__N_322[2]), .Z(n2998)) /* synthesis lut_function=(!(A+(B (C)+!B !(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i932_4_lut_4_lut_then_3_lut.init = 16'h1414;
    LUT4 i971_2_lut_3_lut (.A(n2928), .B(n1518), .C(n895), .Z(n1456)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i971_2_lut_3_lut.init = 16'h4040;
    LUT4 i33_3_lut (.A(n2891), .B(n2541), .C(next_state[3]), .Z(n1518)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i33_3_lut.init = 16'hcaca;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut (.A(DIGS3C_SlotD_ReqOE_c_1), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_1)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(136[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut.init = 16'h2222;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut (.A(DIGS3C_SlotD_ReqOE_c_2), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_2)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(136[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut.init = 16'h2222;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut (.A(DIGS3C_SlotD_ReqOE_c_3), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_3)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(136[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut.init = 16'h2222;
    CCU2D add_1033_8 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2520), .COUT(n2521));
    defparam add_1033_8.INIT0 = 16'h5555;
    defparam add_1033_8.INIT1 = 16'h5aaa;
    defparam add_1033_8.INJECT1_0 = "NO";
    defparam add_1033_8.INJECT1_1 = "NO";
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut (.A(DIGS3C_SlotD_ReqOE_c_4), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_4)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(136[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut.init = 16'h2222;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut (.A(DIGS3C_SlotD_ReqOE_c_5), .B(forceoutputdisable), 
         .Z(DIGS3C_SlotD_SlotOE_c_5)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(136[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut.init = 16'h2222;
    LUT4 i427_1_lut (.A(Carrier_PG_1V8_N_466), .Z(n1851)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(175[1] 327[13])
    defparam i427_1_lut.init = 16'h5555;
    LUT4 i969_2_lut_3_lut (.A(n2928), .B(n1518), .C(n890), .Z(n1451)) /* synthesis lut_function=(A+((C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i969_2_lut_3_lut.init = 16'hfbfb;
    LUT4 pushed_1__I_0_1_lut (.A(pushed[1]), .Z(pushed_1__N_181)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(164[17] 168[24])
    defparam pushed_1__I_0_1_lut.init = 16'h5555;
    LUT4 mux_305_i7_4_lut (.A(next_state[1]), .B(n896), .C(n1518), .D(n2928), 
         .Z(n1457)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam mux_305_i7_4_lut.init = 16'h0aca;
    FD1P3IX debounce_counters_1___i1 (.D(n52), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i2 (.D(n51), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i3 (.D(n50), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i4 (.D(n49), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i5 (.D(n48), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i6 (.D(n47), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i7 (.D(n46), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i8 (.D(n45), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i9 (.D(n44), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i10 (.D(n43), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i11 (.D(n42), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i12 (.D(n41), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i13 (.D(n40), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i14 (.D(n39), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i15 (.D(n38), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i16 (.D(n37), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i17 (.D(n36), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i18 (.D(n35), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i19 (.D(n34), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i20 (.D(n33), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i21 (.D(n32), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i22 (.D(n31), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i23 (.D(n30), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i24 (.D(n29), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i25 (.D(n28), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i26 (.D(n27), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i27 (.D(n26), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i28 (.D(n25), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i29 (.D(n24), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i30 (.D(n23), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i31 (.D(n22), .SP(clk_enable_63), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(145[9] 170[16])
    defparam debounce_counters_1___i31.GSR = "ENABLED";
    LUT4 mux_305_i9_4_lut (.A(next_state[1]), .B(n894), .C(n1518), .D(n2928), 
         .Z(n1455)) /* synthesis lut_function=(!(A (((D)+!C)+!B)+!A (B (C (D))+!B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam mux_305_i9_4_lut.init = 16'h05c5;
    LUT4 mux_305_i10_4_lut (.A(next_state[1]), .B(n893), .C(n1518), .D(n2928), 
         .Z(n1454)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam mux_305_i10_4_lut.init = 16'hfaca;
    LUT4 i20_4_lut (.A(counter[2]), .B(n40_adj_1), .C(n34_adj_5), .D(counter[19]), 
         .Z(n42_adj_13)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i20_4_lut.init = 16'hfffe;
    LUT4 i1281_3_lut_4_lut_4_lut_else_4_lut (.A(next_state[3]), .B(next_state_3__N_322[2]), 
         .C(next_state[0]), .D(next_state[2]), .Z(n2939)) /* synthesis lut_function=(A ((D)+!C)+!A !((C+(D))+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam i1281_3_lut_4_lut_4_lut_else_4_lut.init = 16'haa0e;
    LUT4 i949_3_lut (.A(n892), .B(n1518), .C(n2928), .Z(n1453)) /* synthesis lut_function=(!(A (B (C))+!A (B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i949_3_lut.init = 16'h3b3b;
    LUT4 i1301_4_lut_4_lut (.A(next_state[3]), .B(n4_adj_12), .C(n18), 
         .D(n2954), .Z(clk_enable_66)) /* synthesis lut_function=(!(A (D)+!A (B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i1301_4_lut_4_lut.init = 16'h00ab;
    FD1P3AX next_state_i0 (.D(next_state_3__N_28[0]), .SP(clk_enable_64), 
            .CK(clk), .Q(next_state[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam next_state_i0.GSR = "ENABLED";
    CCU2D add_1033_6 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2519), .COUT(n2520));
    defparam add_1033_6.INIT0 = 16'h5555;
    defparam add_1033_6.INIT1 = 16'h5aaa;
    defparam add_1033_6.INJECT1_0 = "NO";
    defparam add_1033_6.INJECT1_1 = "NO";
    CCU2D add_14_13 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2496), .COUT(n2497), .S0(n42), 
          .S1(n41));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_13.INIT0 = 16'h5aaa;
    defparam add_14_13.INIT1 = 16'h5aaa;
    defparam add_14_13.INJECT1_0 = "NO";
    defparam add_14_13.INJECT1_1 = "NO";
    LUT4 mux_305_i12_4_lut (.A(next_state[1]), .B(n891), .C(n1518), .D(n2928), 
         .Z(n1452)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam mux_305_i12_4_lut.init = 16'hf5c5;
    LUT4 mux_305_i14_4_lut (.A(next_state[1]), .B(n889), .C(n1518), .D(n2928), 
         .Z(n1450)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam mux_305_i14_4_lut.init = 16'hf5c5;
    LUT4 i986_2_lut_3_lut (.A(n2928), .B(n1518), .C(n902), .Z(n1463)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i986_2_lut_3_lut.init = 16'h4040;
    LUT4 i1_4_lut_4_lut_adj_3 (.A(next_state[2]), .B(next_state[1]), .C(next_state[0]), 
         .D(next_state[3]), .Z(clk_enable_7)) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+!(C (D)))) */ ;
    defparam i1_4_lut_4_lut_adj_3.init = 16'heffd;
    LUT4 i1283_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), .C(next_state[0]), 
         .D(next_state[3]), .Z(clk_enable_69)) /* synthesis lut_function=(A (B+(C+(D)))+!A (B (D)+!B !(C+!(D)))) */ ;
    defparam i1283_4_lut_4_lut.init = 16'hefa8;
    LUT4 mux_201_Mux_11_i15_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), 
         .C(next_state[3]), .D(n6), .Z(DIGS3C_Shared_ReqSafeState_N_467)) /* synthesis lut_function=(!(A (C+!(D))+!A (B (C)))) */ ;
    defparam mux_201_Mux_11_i15_4_lut_4_lut.init = 16'h1f15;
    LUT4 i11_3_lut_4_lut_4_lut (.A(next_state[0]), .B(next_state[1]), .C(next_state[2]), 
         .D(next_state[3]), .Z(clk_enable_4)) /* synthesis lut_function=(A (B (D)+!B (C (D)))+!A (B (C (D))+!B (C+!(D)))) */ ;
    defparam i11_3_lut_4_lut_4_lut.init = 16'hf811;
    LUT4 i975_2_lut_3_lut (.A(n2928), .B(n1518), .C(n900), .Z(n1461)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i975_2_lut_3_lut.init = 16'h4040;
    LUT4 next_state_3__bdd_4_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(next_state[1]), .D(next_state[0]), .Z(n1843)) /* synthesis lut_function=(A (B+(C (D)))) */ ;
    defparam next_state_3__bdd_4_lut.init = 16'ha888;
    LUT4 i753_4_lut_4_lut (.A(next_state[0]), .B(next_state[1]), .C(next_state[3]), 
         .D(next_state[2]), .Z(FP_SysLEDr_N_453)) /* synthesis lut_function=(!(A (B (C+!(D))+!B (D))+!A (B (C (D))+!B (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i753_4_lut_4_lut.init = 16'h0c77;
    LUT4 i1298_3_lut_4_lut_4_lut_then_3_lut (.A(next_state[2]), .B(next_state[1]), 
         .C(next_state[0]), .Z(n2944)) /* synthesis lut_function=(A+(B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam i1298_3_lut_4_lut_4_lut_then_3_lut.init = 16'hefef;
    LUT4 i1298_3_lut_4_lut_4_lut_else_3_lut (.A(next_state[2]), .B(next_state[1]), 
         .C(next_state_3__N_322[2]), .D(next_state[0]), .Z(n2943)) /* synthesis lut_function=(A (B (D))+!A !(B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam i1298_3_lut_4_lut_4_lut_else_3_lut.init = 16'h9810;
    LUT4 FPIO_isoCtrlRSTn_N_462_bdd_4_lut_1316 (.A(FPIO_isoCtrlRSTn_N_462), 
         .B(next_state_3__N_322[2]), .C(next_state[3]), .D(next_state[0]), 
         .Z(n2883)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B ((D)+!C)+!B (C (D)+!C !(D)))) */ ;
    defparam FPIO_isoCtrlRSTn_N_462_bdd_4_lut_1316.init = 16'ha3f0;
    LUT4 i16_4_lut (.A(counter[15]), .B(counter[6]), .C(counter[3]), .D(counter[12]), 
         .Z(n38_adj_2)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i16_4_lut.init = 16'hfffe;
    LUT4 i29_4_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[1]), 
         .D(next_state[0]), .Z(FP_SysLEDg_N_452)) /* synthesis lut_function=(!(A (B+(C (D)))+!A !(B ((D)+!C)+!B !(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i29_4_lut.init = 16'h4726;
    LUT4 next_state_0__bdd_4_lut_1356 (.A(next_state[0]), .B(PPn_VIN_c), 
         .C(next_state[2]), .D(next_state[1]), .Z(n2879)) /* synthesis lut_function=(!(A (B+(C+(D)))+!A (B (C+!(D))+!B (C)))) */ ;
    defparam next_state_0__bdd_4_lut_1356.init = 16'h0503;
    CCU2D add_1033_26 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2529), .S1(clk_enable_1));
    defparam add_1033_26.INIT0 = 16'hf555;
    defparam add_1033_26.INIT1 = 16'h0000;
    defparam add_1033_26.INJECT1_0 = "NO";
    defparam add_1033_26.INJECT1_1 = "NO";
    LUT4 i950_3_lut (.A(n888), .B(n1518), .C(n2928), .Z(n1449)) /* synthesis lut_function=(A (B)+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i950_3_lut.init = 16'hc8c8;
    CCU2D add_1033_24 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2528), .COUT(n2529));
    defparam add_1033_24.INIT0 = 16'h5555;
    defparam add_1033_24.INIT1 = 16'h5555;
    defparam add_1033_24.INJECT1_0 = "NO";
    defparam add_1033_24.INJECT1_1 = "NO";
    CCU2D add_1033_4 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2518), .COUT(n2519));
    defparam add_1033_4.INIT0 = 16'h5555;
    defparam add_1033_4.INIT1 = 16'h5555;
    defparam add_1033_4.INJECT1_0 = "NO";
    defparam add_1033_4.INJECT1_1 = "NO";
    CCU2D add_1033_2 (.A0(\debounce_counters[1] [7]), .B0(\debounce_counters[1] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[1] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n2518));
    defparam add_1033_2.INIT0 = 16'h1000;
    defparam add_1033_2.INIT1 = 16'h5aaa;
    defparam add_1033_2.INJECT1_0 = "NO";
    defparam add_1033_2.INJECT1_1 = "NO";
    LUT4 i478_4_lut_then_4_lut (.A(next_state[2]), .B(next_state_3__N_322[2]), 
         .C(next_state[1]), .D(next_state[0]), .Z(n2992)) /* synthesis lut_function=(!(A+(B (C)+!B (C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i478_4_lut_then_4_lut.init = 16'h0515;
    CCU2D add_1033_22 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2527), .COUT(n2528));
    defparam add_1033_22.INIT0 = 16'h5555;
    defparam add_1033_22.INIT1 = 16'h5555;
    defparam add_1033_22.INJECT1_0 = "NO";
    defparam add_1033_22.INJECT1_1 = "NO";
    CCU2D add_14_11 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2495), .COUT(n2496), .S0(n44), 
          .S1(n43));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_11.INIT0 = 16'h5aaa;
    defparam add_14_11.INIT1 = 16'h5aaa;
    defparam add_14_11.INJECT1_0 = "NO";
    defparam add_14_11.INJECT1_1 = "NO";
    CCU2D add_1033_20 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2526), .COUT(n2527));
    defparam add_1033_20.INIT0 = 16'h5555;
    defparam add_1033_20.INIT1 = 16'h5555;
    defparam add_1033_20.INJECT1_0 = "NO";
    defparam add_1033_20.INJECT1_1 = "NO";
    CCU2D add_200_23 (.A0(counter[21]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n2517), 
          .S0(n881));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(306[17:24])
    defparam add_200_23.INIT0 = 16'h5555;
    defparam add_200_23.INIT1 = 16'h0000;
    defparam add_200_23.INJECT1_0 = "NO";
    defparam add_200_23.INJECT1_1 = "NO";
    FD1P3IX counter__i0 (.D(n1463), .SP(clk_enable_65), .CD(n1843), .CK(clk), 
            .Q(counter[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam counter__i0.GSR = "ENABLED";
    LUT4 i951_3_lut (.A(n887), .B(n1518), .C(n2928), .Z(n1448)) /* synthesis lut_function=(!(A (B (C))+!A (B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i951_3_lut.init = 16'h3b3b;
    LUT4 mux_305_i18_4_lut (.A(next_state[1]), .B(n885), .C(n1518), .D(n2928), 
         .Z(n1446)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam mux_305_i18_4_lut.init = 16'hf5c5;
    LUT4 mux_305_i19_4_lut (.A(next_state[1]), .B(n884), .C(n1518), .D(n2928), 
         .Z(n1445)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam mux_305_i19_4_lut.init = 16'hf5c5;
    LUT4 mux_305_i20_4_lut (.A(next_state[1]), .B(n883), .C(n1518), .D(n2928), 
         .Z(n1444)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam mux_305_i20_4_lut.init = 16'hf5c5;
    LUT4 next_state_3__I_0_181_Mux_1_i15_3_lut_4_lut_4_lut_then_4_lut (.A(next_state[1]), 
         .B(next_state[3]), .C(FPIO_isoCtrlRSTn_N_462), .D(next_state[2]), 
         .Z(n2937)) /* synthesis lut_function=(!(A (B+!(D))+!A (B (C+(D))+!B (D)))) */ ;
    defparam next_state_3__I_0_181_Mux_1_i15_3_lut_4_lut_4_lut_then_4_lut.init = 16'h2215;
    LUT4 i1304_4_lut_4_lut (.A(next_state[3]), .B(n4_adj_12), .C(n2993), 
         .D(n18), .Z(clk_enable_67)) /* synthesis lut_function=(!(A (C)+!A (B+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i1304_4_lut_4_lut.init = 16'h0a1b;
    CCU2D add_14_9 (.A0(\debounce_counters[1] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2494), .COUT(n2495), .S0(n46), 
          .S1(n45));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_9.INIT0 = 16'h5aaa;
    defparam add_14_9.INIT1 = 16'h5aaa;
    defparam add_14_9.INJECT1_0 = "NO";
    defparam add_14_9.INJECT1_1 = "NO";
    LUT4 i35_4_lut_4_lut (.A(FPIO_isoCtrlRSTn_N_462), .B(next_state[2]), 
         .C(n23_adj_8), .D(next_state[1]), .Z(n18)) /* synthesis lut_function=(A (B (D)+!B (C+(D)))+!A (B (D)+!B !((D)+!C))) */ ;
    defparam i35_4_lut_4_lut.init = 16'hee30;
    LUT4 n2856_bdd_2_lut (.A(n2856), .B(next_state[3]), .Z(clk_enable_64)) /* synthesis lut_function=(A+(B)) */ ;
    defparam n2856_bdd_2_lut.init = 16'heeee;
    LUT4 mux_201_Mux_8_i15_4_lut_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), 
         .C(next_state[3]), .D(next_state[0]), .Z(FP_SysLEDb_N_454)) /* synthesis lut_function=(!(A ((C+!(D))+!B)+!A (B (C)+!B !(C)))) */ ;
    defparam mux_201_Mux_8_i15_4_lut_4_lut_4_lut.init = 16'h1c14;
    LUT4 next_state_3__I_0_181_Mux_1_i15_3_lut_4_lut_4_lut_else_4_lut (.A(next_state[1]), 
         .B(next_state[3]), .Z(n2936)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam next_state_3__I_0_181_Mux_1_i15_3_lut_4_lut_4_lut_else_4_lut.init = 16'h2222;
    LUT4 next_state_0__bdd_2_lut (.A(PPn_VIN_c), .B(next_state[2]), .Z(n2880)) /* synthesis lut_function=(!(A (B))) */ ;
    defparam next_state_0__bdd_2_lut.init = 16'h7777;
    LUT4 i976_2_lut_3_lut (.A(n2928), .B(n1518), .C(n901), .Z(n1462)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i976_2_lut_3_lut.init = 16'h4040;
    CCU2D add_14_7 (.A0(\debounce_counters[1] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2493), .COUT(n2494), .S0(n48), 
          .S1(n47));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_7.INIT0 = 16'h5aaa;
    defparam add_14_7.INIT1 = 16'h5aaa;
    defparam add_14_7.INJECT1_0 = "NO";
    defparam add_14_7.INJECT1_1 = "NO";
    LUT4 mux_305_i21_4_lut (.A(next_state[1]), .B(n882), .C(n1518), .D(n2928), 
         .Z(n1443)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam mux_305_i21_4_lut.init = 16'hf5c5;
    VLO i1 (.Z(GND_net));
    LUT4 mux_201_Mux_2_i15_4_lut_4_lut_then_4_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(next_state[0]), .D(FPIO_isoCtrlRSTn_N_462), .Z(n2947)) /* synthesis lut_function=(A (B)+!A (B (C)+!B !(D))) */ ;
    defparam mux_201_Mux_2_i15_4_lut_4_lut_then_4_lut.init = 16'hc8d9;
    LUT4 i932_4_lut_4_lut_else_3_lut (.A(next_state[3]), .B(next_state[1]), 
         .C(next_state[0]), .Z(n2997)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i932_4_lut_4_lut_else_3_lut.init = 16'h4040;
    LUT4 mux_201_Mux_2_i15_4_lut_4_lut_else_4_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(next_state[0]), .D(next_state_3__N_322[2]), .Z(n2946)) /* synthesis lut_function=(A (B)+!A !(B+(C+!(D)))) */ ;
    defparam mux_201_Mux_2_i15_4_lut_4_lut_else_4_lut.init = 16'h8988;
    LUT4 next_state_1__bdd_4_lut_1324 (.A(FPIO_isoCtrlRSTn_N_462), .B(next_state_3__N_322[2]), 
         .C(next_state[2]), .D(next_state[0]), .Z(n2855)) /* synthesis lut_function=(!(A (B (C (D)+!C !(D))+!B !(C (D)+!C !(D)))+!A (B (C (D)+!C !(D))+!B !(C+!(D))))) */ ;
    defparam next_state_1__bdd_4_lut_1324.init = 16'h3cd3;
    LUT4 next_state_3__I_0_181_Mux_3_i15_4_lut_then_4_lut (.A(next_state[1]), 
         .B(next_state[2]), .C(next_state[0]), .D(FPIO_isoCtrlRSTn_N_462), 
         .Z(n2950)) /* synthesis lut_function=(!(A+(B+((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam next_state_3__I_0_181_Mux_3_i15_4_lut_then_4_lut.init = 16'h0010;
    LUT4 i952_3_lut (.A(n881), .B(n1518), .C(n2928), .Z(n1442)) /* synthesis lut_function=(A (B)+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i952_3_lut.init = 16'hc8c8;
    LUT4 i1_3_lut_4_lut (.A(next_state[2]), .B(next_state[1]), .C(next_state[0]), 
         .D(next_state[3]), .Z(clk_enable_2)) /* synthesis lut_function=(A+(B+!(C (D)))) */ ;
    defparam i1_3_lut_4_lut.init = 16'hefff;
    PFUMX i1319 (.BLUT(n2890), .ALUT(n2889), .C0(next_state[1]), .Z(n2891));
    PFUMX i1360 (.BLUT(n2991), .ALUT(n2992), .C0(FPIO_isoCtrlRSTn_N_462), 
          .Z(n2993));
    LUT4 i415_2_lut (.A(clk_enable_1), .B(button_inputs_asyn2[1]), .Z(clk_enable_63)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i415_2_lut.init = 16'hdddd;
    CCU2D add_14_5 (.A0(\debounce_counters[1] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2492), .COUT(n2493), .S0(n50), 
          .S1(n49));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_5.INIT0 = 16'h5aaa;
    defparam add_14_5.INIT1 = 16'h5aaa;
    defparam add_14_5.INJECT1_0 = "NO";
    defparam add_14_5.INJECT1_1 = "NO";
    PFUMX i1339 (.BLUT(n2936), .ALUT(n2937), .C0(next_state[0]), .Z(next_state_3__N_28[1]));
    PFUMX i1364 (.BLUT(n2997), .ALUT(n2998), .C0(next_state[2]), .Z(next_state_3__N_28[2]));
    PFUMX i1349 (.BLUT(n2952), .ALUT(n2953), .C0(next_state[1]), .Z(n2954));
    LUT4 i8_2_lut (.A(counter[5]), .B(counter[11]), .Z(n30_adj_6)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i8_2_lut.init = 16'heeee;
    LUT4 i18_4_lut (.A(counter[14]), .B(n36_adj_4), .C(n26_adj_11), .D(counter[1]), 
         .Z(n40_adj_1)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i18_4_lut.init = 16'hfffe;
    FD1P3AX next_state_i3 (.D(next_state_3__N_28[3]), .SP(clk_enable_66), 
            .CK(clk), .Q(next_state[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam next_state_i3.GSR = "ENABLED";
    PFUMX i1347 (.BLUT(n2949), .ALUT(n2950), .C0(next_state[3]), .Z(next_state_3__N_28[3]));
    LUT4 i12_4_lut (.A(counter[17]), .B(counter[4]), .C(counter[10]), 
         .D(counter[9]), .Z(n34_adj_5)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i12_4_lut.init = 16'hfffe;
    PFUMX i1313 (.BLUT(n2883), .ALUT(n2882), .C0(next_state[1]), .Z(n2884));
    PFUMX i1345 (.BLUT(n2946), .ALUT(n2947), .C0(next_state[1]), .Z(Carrier_PG_1V8_N_479));
    LUT4 i14_4_lut (.A(counter[18]), .B(counter[7]), .C(counter[20]), 
         .D(counter[8]), .Z(n36_adj_4)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i14_4_lut.init = 16'hfffe;
    PFUMX i1343 (.BLUT(n2943), .ALUT(n2944), .C0(next_state[3]), .Z(clk_enable_10));
    LUT4 i974_2_lut_3_lut (.A(n2928), .B(n1518), .C(n899), .Z(n1460)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(178[9] 325[18])
    defparam i974_2_lut_3_lut.init = 16'h4040;
    LUT4 mux_201_Mux_11_i6_3_lut_4_lut_4_lut (.A(next_state_3__N_322[2]), 
         .B(next_state[0]), .C(next_state[1]), .D(FPIO_isoCtrlRSTn_N_462), 
         .Z(n6)) /* synthesis lut_function=(A (B (C))+!A (B (C)+!B !(C+(D)))) */ ;
    defparam mux_201_Mux_11_i6_3_lut_4_lut_4_lut.init = 16'hc0c1;
    GSR GSR_INST (.GSR(VCC_net));
    FD1P3AX next_state_i2 (.D(next_state_3__N_28[2]), .SP(clk_enable_67), 
            .CK(clk), .Q(next_state[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam next_state_i2.GSR = "ENABLED";
    FD1P3AX next_state_i1 (.D(next_state_3__N_28[1]), .SP(clk_enable_68), 
            .CK(clk), .Q(next_state[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam next_state_i1.GSR = "ENABLED";
    FD1P3AX FP_SysLEDs_176 (.D(n2934), .SP(clk_enable_69), .CK(clk), .Q(FP_SysLEDs_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(177[2] 326[9])
    defparam FP_SysLEDs_176.GSR = "ENABLED";
    CCU2D add_14_3 (.A0(\debounce_counters[1] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2491), .COUT(n2492), .S0(n52), 
          .S1(n51));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(155[49:69])
    defparam add_14_3.INIT0 = 16'h5aaa;
    defparam add_14_3.INIT1 = 16'h5aaa;
    defparam add_14_3.INJECT1_0 = "NO";
    defparam add_14_3.INJECT1_1 = "NO";
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    PFUMX i1305 (.BLUT(n2850), .ALUT(n2541), .C0(next_state[3]), .Z(next_state_3__N_28[0]));
    PFUMX i1341 (.BLUT(n2939), .ALUT(n2940), .C0(next_state[1]), .Z(clk_enable_3));
    
endmodule
//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

