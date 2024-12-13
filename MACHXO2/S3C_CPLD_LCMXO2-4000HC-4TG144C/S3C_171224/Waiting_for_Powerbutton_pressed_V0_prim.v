// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Fri Dec 13 12:42:53 2024
//
// Verilog Description of module Waiting_for_Powerbutton_pressed_V0
//

module Waiting_for_Powerbutton_pressed_V0 (SCL, SDA, RST_N, FP_SysLEDg, 
            FP_SysLEDr, FP_SysLEDb, Carrier_PG_3V3, FPIO_FlexMIO52, 
            FPIO_ExternalStop, FPIO_isoCtrlRSTn, SysSW_Pwr_NC, FP_UsrSW1, 
            FP_UsrSW2, FP_UsrSW3, FP_UsrLED1, FP_UsrLED2, FP_UsrLED3, 
            FP_UsrLED4, FP_SysLEDs, Carrier_PG_1V8, SD0_CD, SD1_CD, 
            DIGS3C_Shared_CarrierReady, DIGS3C_Shared_ReqSafeState, DIGS3C_SlotD_ReqOE, 
            DIGS3C_SlotD_SlotOK, SD_SEL, FlexMIOs52_PCIe, FlexMio61ExternalStop, 
            FlexMIOs53_GPIO_PowerDown, ANL_S3C_SLOTOK, ANL_S3C_CarrierReady, 
            ANL_S3C_P54_Legacy, DIGS3C_SlotD_SlotOE, Carrier_PwrOn, PG_VIN, 
            PPn_VIN, PG_Module);   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(7[8:42])
    input SCL /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(12[3:6])
    input SDA /* synthesis .original_dir=IN_OUT */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(13[3:6])
    input RST_N;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(14[3:8])
    output FP_SysLEDg;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(16[3:13])
    output FP_SysLEDr;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(17[3:13])
    output FP_SysLEDb;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(18[3:13])
    output Carrier_PG_3V3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(19[3:17])
    output FPIO_FlexMIO52;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(20[3:17])
    input FPIO_ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(21[3:20])
    output FPIO_isoCtrlRSTn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(22[3:19])
    input SysSW_Pwr_NC;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(24[3:15])
    input FP_UsrSW1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(25[3:12])
    input FP_UsrSW2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(26[3:12])
    input FP_UsrSW3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(27[3:12])
    output FP_UsrLED1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(29[3:13])
    output FP_UsrLED2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(30[3:13])
    output FP_UsrLED3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(31[3:13])
    output FP_UsrLED4;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(32[3:13])
    output FP_SysLEDs;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(33[3:13])
    output Carrier_PG_1V8;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(34[3:17])
    input SD0_CD;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(35[3:9])
    input SD1_CD;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(36[3:9])
    output DIGS3C_Shared_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(38[3:29])
    output DIGS3C_Shared_ReqSafeState;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(39[3:29])
    input [5:1]DIGS3C_SlotD_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(41[3:21])
    input [5:1]DIGS3C_SlotD_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(42[3:22])
    output SD_SEL;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(45[3:9])
    input FlexMIOs52_PCIe;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(46[3:18])
    output FlexMio61ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(47[3:24])
    output FlexMIOs53_GPIO_PowerDown;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(48[3:28])
    input [3:1]ANL_S3C_SLOTOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(53[3:17])
    output ANL_S3C_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(54[3:23])
    output ANL_S3C_P54_Legacy;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(55[3:21])
    output [5:1]DIGS3C_SlotD_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(56[3:22])
    output Carrier_PwrOn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(59[9:22])
    input PG_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(60[3:9])
    input PPn_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(61[3:10])
    input PG_Module;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(62[3:12])
    
    wire clk /* synthesis is_clock=1, SET_AS_NETWORK=clk */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(68[9:12])
    
    wire GND_net, VCC_net, FP_SysLEDg_c, FP_SysLEDr_c, FP_SysLEDb_c, 
        Carrier_PG_3V3_c, FPIO_FlexMIO52_c_c, FlexMio61ExternalStop_c_c, 
        FPIO_isoCtrlRSTn_c, SysSW_Pwr_NC_c, FP_UsrSW1_c, FP_UsrSW3_c, 
        FP_UsrLED2_c, FP_UsrLED3_c, FP_UsrLED4_c, FP_SysLEDs_c, n42_adj_1, 
        DIGS3C_Shared_ReqSafeState_c, DIGS3C_SlotD_ReqOE_c_5, DIGS3C_SlotD_ReqOE_c_4, 
        DIGS3C_SlotD_ReqOE_c_3, DIGS3C_SlotD_ReqOE_c_2, DIGS3C_SlotD_ReqOE_c_1, 
        FlexMIOs53_GPIO_PowerDown_c, DIGS3C_SlotD_SlotOE_c_5, DIGS3C_SlotD_SlotOE_c_4, 
        DIGS3C_SlotD_SlotOE_c_3, DIGS3C_SlotD_SlotOE_c_2, DIGS3C_SlotD_SlotOE_c_1, 
        Carrier_PwrOn_c, PPn_VIN_c;
    wire [21:0]counter;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(69[9:16])
    wire [3:0]next_state;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[12:22])
    wire [31:0]\debounce_counters[1] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(82[12:29])
    wire [31:0]\debounce_counters[2] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(82[12:29])
    wire [31:0]\debounce_counters[3] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(82[12:29])
    wire [31:0]\debounce_counters[4] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(82[12:29])
    wire [4:1]button_inputs_asyn1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(84[12:31])
    wire [4:1]button_inputs_asyn2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(85[9:28])
    wire [4:1]pushed;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(86[9:15])
    wire [4:1]buttons_debounced_syn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(87[12:33])
    
    wire n3, n19, n20, n21, n22, n23, n24, n25, n26, n27, 
        n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, 
        n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, 
        n48, n49, n50, clk_enable_97, n3138, n3117, n3137, n3116, 
        n3115, n3114, n3113, pushed_1__N_187, n27_adj_2, n125, n126, 
        n127, n128, n129, n130, n131, n132, n133, n134, n135, 
        n136, n137, n138, n139, n140, n141, n142, n143, n144, 
        n145, n146, n147, n148, n149, n150, n151, n152, n153, 
        n154, n155, n156, n3136, n3112, n3111, n3110, n3135, 
        n3109, n3433, n3108, n3134, n3432, n3107, n20_adj_3, n3431, 
        n3133, n3106, n3132, n3131, n3130, pushed_2__N_185, n3429, 
        n231, n232, n233, n234, n235, n236, n237, n238, n239, 
        n240, n241, n242, n243, n244, n245, n246, n247, n248, 
        n249, n250, n251, n252, n253, n254, n255, n256, n257, 
        n258, n259, n260, n261, n262, n3129, n23_adj_4, n3128, 
        n3105, n3104, n3127, n3103, n3102, n3101, n3100, n3099, 
        n3098, n3126, n3097, n3096, n3095, n3094, n3093, n3125, 
        n3325, n3124, n3123, n3092, n3091, pushed_3__N_183, n337, 
        n338, n339, n340, n341, n342, n343, n344, n345, n346, 
        n347, n348, n349, n350, n351, n352, n353, n354, n355, 
        n356, n357, n358, n359, n360, n361, n362, n363, n364, 
        n365, n366, n367, n368, n3090, n3089, n3088, n3122, 
        n3121, n3120, n3087, n3086, n3085, n3084, n3083, n3082, 
        n3119, n3081, n3080, n3079, n3078, n3077, n3118, n3076, 
        n3075, pushed_4__N_181, n29_adj_5, n3074, clk_enable_13, n3073, 
        n3072, n3071, clk_enable_7, n1872, n3070, n36_adj_6, n22_adj_7, 
        n3069, n3068, n3067, n3066, n3065, n3064, n3063, n3062, 
        n3061, n3060, n3059, n3058, n3057, n3056, n3055, n1493, 
        n3054, n3053, n3052, n3447, n3051, n3050, n1492, n1491, 
        n1490, n1489, n1488, n1487, n1486, n1485, n1484, n1483, 
        n1482, n1481, n1480, n1479, n1478, n1477, n1476, n1475, 
        n1474, n1473, n1472, n1470, clk_enable_18, n3049, n3048, 
        n3515;
    wire [3:0]next_state_3__N_328;
    
    wire n906, n907, n908, n909, n910, n911, n912, n913, n914, 
        n915, n916, n917, n918, n919, n920, n921, n922, n923, 
        n924, n925, n926, n927, clk_enable_137, n3047, n4, n3046, 
        clk_enable_44, n3283, FP_UsrLED2_N_3, DIGS3C_Shared_ReqSafeState_N_473, 
        FlexMIOs53_GPIO_PowerDown_N_475, FP_SysLEDr_N_459, FP_SysLEDb_N_460, 
        FP_SysLEDg_N_458;
    wire [3:0]next_state_3__N_28;
    
    wire Carrier_PwrOn_N_478, n3513, n40_adj_8, n3045, n3505, n3044, 
        n3043, n3042, n1864, FP_SysLEDs_N_470, n3512, Carrier_PG_1V8_N_483, 
        Carrier_PG_1V8_N_487, Carrier_PG_1V8_N_472, n3511, n3041, n3040, 
        n3039, n3327, n1441, n3038, n3509, n1525, n3037, n3036, 
        n3035, n3508, n3034, n34_adj_9, n36_adj_10, n3506, n15, 
        n3500, n26_adj_11, n3514, n39_adj_12, n3033, n3499, n3032, 
        n3031, clk_enable_17, n3030, n3504, clk_enable_14, clk_enable_8, 
        n34_adj_13, clk_enable_98, n16, n3029, n17, n3140, n3169, 
        clk_enable_135, n6, n3493, n42_adj_14, n38_adj_15, n3503, 
        n3028, n3027, n3501, clk_enable_99, n3026, clk_enable_134, 
        clk_enable_12, n3494, n3025, n3448, n3292, n3502, n29_adj_16, 
        n3443, n3579, n25_adj_17, n3024, n3442, n3139, n30_adj_18, 
        n3023, clk_enable_136, clk_enable_167, clk_enable_96, clk_enable_132, 
        n3022, clk_enable_65, clk_enable_100, n3021, n3020, n3019, 
        n3498, n18, clk_enable_101, n3018;
    
    VHI i2 (.Z(VCC_net));
    FD1P3IX debounce_counters_4___i21 (.D(n347), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i21.GSR = "ENABLED";
    CCU2D add_11_15 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3024), .COUT(n3025), .S0(n37), 
          .S1(n36));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_15.INIT0 = 16'h5aaa;
    defparam add_11_15.INIT1 = 16'h5aaa;
    defparam add_11_15.INJECT1_0 = "NO";
    defparam add_11_15.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i20 (.D(n348), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i20.GSR = "ENABLED";
    FD1P3IX counter__i0 (.D(n1493), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i0.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i19 (.D(n349), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i0 (.D(n156), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i0.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i18 (.D(n350), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i18.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn2_i1 (.D(button_inputs_asyn1[1]), .CK(clk), 
            .Q(button_inputs_asyn2[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam button_inputs_asyn2_i1.GSR = "ENABLED";
    FD1P3IX pushed_i1 (.D(n3579), .SP(clk_enable_7), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(pushed[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam pushed_i1.GSR = "ENABLED";
    FD1S3AY buttons_debounced_syn_i1 (.D(pushed_1__N_187), .CK(clk), .Q(next_state_3__N_328[0])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam buttons_debounced_syn_i1.GSR = "ENABLED";
    FD1P3AX forceoutputdisable_163 (.D(FP_UsrLED2_N_3), .SP(clk_enable_8), 
            .CK(clk), .Q(FP_UsrLED2_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam forceoutputdisable_163.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i17 (.D(n351), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i17.GSR = "ENABLED";
    CCU2D add_202_15 (.A0(counter[13]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[14]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3088), .COUT(n3089), .S0(n914), .S1(n913));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(290[17:24])
    defparam add_202_15.INIT0 = 16'h5555;
    defparam add_202_15.INIT1 = 16'h5555;
    defparam add_202_15.INJECT1_0 = "NO";
    defparam add_202_15.INJECT1_1 = "NO";
    CCU2D add_1472_4 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3129), .COUT(n3130));
    defparam add_1472_4.INIT0 = 16'h5555;
    defparam add_1472_4.INIT1 = 16'h5555;
    defparam add_1472_4.INJECT1_0 = "NO";
    defparam add_1472_4.INJECT1_1 = "NO";
    LUT4 mux_311_i20_4_lut_4_lut (.A(next_state[1]), .B(n1441), .C(n1470), 
         .D(n908), .Z(n1474)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[12:22])
    defparam mux_311_i20_4_lut_4_lut.init = 16'hf5c5;
    CCU2D add_29_21 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3059), .COUT(n3060), .S0(n243), 
          .S1(n242));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_21.INIT0 = 16'h5aaa;
    defparam add_29_21.INIT1 = 16'h5aaa;
    defparam add_29_21.INJECT1_0 = "NO";
    defparam add_29_21.INJECT1_1 = "NO";
    CCU2D add_29_19 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3058), .COUT(n3059), .S0(n245), 
          .S1(n244));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_19.INIT0 = 16'h5aaa;
    defparam add_29_19.INIT1 = 16'h5aaa;
    defparam add_29_19.INJECT1_0 = "NO";
    defparam add_29_19.INJECT1_1 = "NO";
    LUT4 mux_311_i9_4_lut_4_lut (.A(next_state[1]), .B(n1441), .C(n1470), 
         .D(n919), .Z(n1485)) /* synthesis lut_function=(!(A (B+!(C (D)))+!A (B (C)+!B !((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[12:22])
    defparam mux_311_i9_4_lut_4_lut.init = 16'h3505;
    CCU2D add_29_17 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3057), .COUT(n3058), .S0(n247), 
          .S1(n246));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_17.INIT0 = 16'h5aaa;
    defparam add_29_17.INIT1 = 16'h5aaa;
    defparam add_29_17.INJECT1_0 = "NO";
    defparam add_29_17.INJECT1_1 = "NO";
    LUT4 i1_4_lut (.A(n3493), .B(n1525), .C(next_state[1]), .D(next_state[2]), 
         .Z(n36_adj_10)) /* synthesis lut_function=(!(A (B+!(D))+!A !(B (C)+!B (C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i1_4_lut.init = 16'h7350;
    CCU2D add_29_15 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3056), .COUT(n3057), .S0(n249), 
          .S1(n248));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_15.INIT0 = 16'h5aaa;
    defparam add_29_15.INIT1 = 16'h5aaa;
    defparam add_29_15.INJECT1_0 = "NO";
    defparam add_29_15.INJECT1_1 = "NO";
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk)) /* synthesis NOM_FREQ="7", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "7";
    LUT4 i930_2_lut_3_lut (.A(n1441), .B(n1470), .C(n925), .Z(n1491)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i930_2_lut_3_lut.init = 16'h4040;
    CCU2D add_11_7 (.A0(\debounce_counters[1] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3020), .COUT(n3021), .S0(n45), 
          .S1(n44));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_7.INIT0 = 16'h5aaa;
    defparam add_11_7.INIT1 = 16'h5aaa;
    defparam add_11_7.INJECT1_0 = "NO";
    defparam add_11_7.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i16 (.D(n352), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i16.GSR = "ENABLED";
    CCU2D add_11_5 (.A0(\debounce_counters[1] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3019), .COUT(n3020), .S0(n47), 
          .S1(n46));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_5.INIT0 = 16'h5aaa;
    defparam add_11_5.INIT1 = 16'h5aaa;
    defparam add_11_5.INJECT1_0 = "NO";
    defparam add_11_5.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i15 (.D(n353), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i15.GSR = "ENABLED";
    LUT4 mux_311_i19_4_lut_4_lut (.A(next_state[1]), .B(n1441), .C(n1470), 
         .D(n909), .Z(n1475)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[12:22])
    defparam mux_311_i19_4_lut_4_lut.init = 16'hf5c5;
    CCU2D add_11_3 (.A0(\debounce_counters[1] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3018), .COUT(n3019), .S0(n49), 
          .S1(n48));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_3.INIT0 = 16'h5aaa;
    defparam add_11_3.INIT1 = 16'h5aaa;
    defparam add_11_3.INJECT1_0 = "NO";
    defparam add_11_3.INJECT1_1 = "NO";
    FD1P3AX DIGS3C_Shared_ReqSafeState_164 (.D(DIGS3C_Shared_ReqSafeState_N_473), 
            .SP(clk_enable_12), .CK(clk), .Q(DIGS3C_Shared_ReqSafeState_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam DIGS3C_Shared_ReqSafeState_164.GSR = "ENABLED";
    FD1P3AX FlexMIOs53_GPIO_PowerDown_165 (.D(FlexMIOs53_GPIO_PowerDown_N_475), 
            .SP(clk_enable_13), .CK(clk), .Q(FlexMIOs53_GPIO_PowerDown_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam FlexMIOs53_GPIO_PowerDown_165.GSR = "ENABLED";
    FD1P3AX FP_SysLEDr_166 (.D(FP_SysLEDr_N_459), .SP(clk_enable_14), .CK(clk), 
            .Q(FP_SysLEDr_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam FP_SysLEDr_166.GSR = "ENABLED";
    FD1S3AX FP_SysLEDg_168 (.D(FP_SysLEDg_N_458), .CK(clk), .Q(FP_SysLEDg_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam FP_SysLEDg_168.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i0 (.D(n50), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i0.GSR = "ENABLED";
    FD1P3AX Carrier_PwrOn_170 (.D(Carrier_PwrOn_N_478), .SP(clk_enable_17), 
            .CK(clk), .Q(Carrier_PwrOn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam Carrier_PwrOn_170.GSR = "ENABLED";
    FD1P3AX Carrier_PG_3V3_171 (.D(Carrier_PwrOn_N_478), .SP(clk_enable_17), 
            .CK(clk), .Q(Carrier_PG_3V3_c)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam Carrier_PG_3V3_171.GSR = "ENABLED";
    FD1P3AX FPIO_isoCtrlRSTn_172 (.D(n3494), .SP(clk_enable_18), .CK(clk), 
            .Q(FPIO_isoCtrlRSTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam FPIO_isoCtrlRSTn_172.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i14 (.D(n354), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i14.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn1_i1 (.D(SysSW_Pwr_NC_c), .CK(clk), .Q(button_inputs_asyn1[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam button_inputs_asyn1_i1.GSR = "ENABLED";
    LUT4 i1657_4_lut (.A(next_state[0]), .B(n3493), .C(n3501), .D(n22_adj_7), 
         .Z(n3325)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;
    defparam i1657_4_lut.init = 16'heca0;
    LUT4 mux_203_Mux_12_i15_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), 
         .C(next_state[3]), .D(PPn_VIN_c), .Z(FP_UsrLED2_N_3)) /* synthesis lut_function=(!(A (C+(D))+!A (B (C)))) */ ;
    defparam mux_203_Mux_12_i15_4_lut_4_lut.init = 16'h151f;
    FD1P3IX debounce_counters_4___i13 (.D(n355), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i22 (.D(n346), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i22.GSR = "ENABLED";
    CCU2D add_1472_2 (.A0(\debounce_counters[1] [7]), .B0(\debounce_counters[1] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[1] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n3129));
    defparam add_1472_2.INIT0 = 16'h1000;
    defparam add_1472_2.INIT1 = 16'h5aaa;
    defparam add_1472_2.INJECT1_0 = "NO";
    defparam add_1472_2.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i12 (.D(n356), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i12.GSR = "ENABLED";
    CCU2D add_202_13 (.A0(counter[11]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[12]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3087), .COUT(n3088), .S0(n916), .S1(n915));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(290[17:24])
    defparam add_202_13.INIT0 = 16'h5555;
    defparam add_202_13.INIT1 = 16'h5555;
    defparam add_202_13.INJECT1_0 = "NO";
    defparam add_202_13.INJECT1_1 = "NO";
    LUT4 i940_3_lut (.A(n6), .B(next_state[3]), .C(next_state[2]), .Z(DIGS3C_Shared_ReqSafeState_N_473)) /* synthesis lut_function=(!(A (B)+!A (B+(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i940_3_lut.init = 16'h2323;
    FD1P3AX i151_176 (.D(Carrier_PG_1V8_N_487), .SP(Carrier_PG_1V8_N_483), 
            .CK(clk), .Q(Carrier_PG_1V8_N_472));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam i151_176.GSR = "ENABLED";
    OB FP_SysLEDg_pad (.I(FP_SysLEDg_c), .O(FP_SysLEDg));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(16[3:13])
    CCU2D add_1473_26 (.A0(\debounce_counters[4] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3128), .S1(clk_enable_100));
    defparam add_1473_26.INIT0 = 16'hf555;
    defparam add_1473_26.INIT1 = 16'h0000;
    defparam add_1473_26.INJECT1_0 = "NO";
    defparam add_1473_26.INJECT1_1 = "NO";
    LUT4 i2_2_lut_3_lut_4_lut (.A(next_state[2]), .B(next_state[1]), .C(n34_adj_9), 
         .D(next_state[3]), .Z(n1864)) /* synthesis lut_function=(!(A (C+!(D))+!A ((C+!(D))+!B))) */ ;
    defparam i2_2_lut_3_lut_4_lut.init = 16'h0e00;
    CCU2D add_1473_24 (.A0(\debounce_counters[4] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3127), .COUT(n3128));
    defparam add_1473_24.INIT0 = 16'h5555;
    defparam add_1473_24.INIT1 = 16'h5555;
    defparam add_1473_24.INJECT1_0 = "NO";
    defparam add_1473_24.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i30 (.D(n338), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i30.GSR = "ENABLED";
    LUT4 i33_3_lut (.A(n3493), .B(next_state_3__N_328[0]), .C(next_state[0]), 
         .Z(n15)) /* synthesis lut_function=(!(A (B (C))+!A (B+!(C)))) */ ;
    defparam i33_3_lut.init = 16'h3a3a;
    CCU2D add_11_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[1] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n3018), .S1(n50));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_1.INIT0 = 16'hF000;
    defparam add_11_1.INIT1 = 16'h5555;
    defparam add_11_1.INJECT1_0 = "NO";
    defparam add_11_1.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i29 (.D(n339), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i28 (.D(n340), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i27 (.D(n341), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i27.GSR = "ENABLED";
    CCU2D add_20_9 (.A0(\debounce_counters[2] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3037), .COUT(n3038), .S0(n149), 
          .S1(n148));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_9.INIT0 = 16'h5aaa;
    defparam add_20_9.INIT1 = 16'h5aaa;
    defparam add_20_9.INJECT1_0 = "NO";
    defparam add_20_9.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i26 (.D(n342), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i0 (.D(n262), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i0.GSR = "ENABLED";
    LUT4 mux_203_Mux_2_i3_4_lut (.A(next_state_3__N_328[0]), .B(n3493), 
         .C(next_state[1]), .D(next_state[0]), .Z(n3)) /* synthesis lut_function=(!(A (B (C+(D))+!B !(C+!(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam mux_203_Mux_2_i3_4_lut.init = 16'h303a;
    LUT4 i1_2_lut_3_lut (.A(next_state[2]), .B(next_state[1]), .C(next_state[3]), 
         .Z(clk_enable_12)) /* synthesis lut_function=(A+(B+!(C))) */ ;
    defparam i1_2_lut_3_lut.init = 16'hefef;
    LUT4 i12_3_lut_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), .C(next_state[3]), 
         .D(next_state[0]), .Z(clk_enable_13)) /* synthesis lut_function=(A (B (C)+!B (C+!(D)))+!A (B (C)+!B !(C+(D)))) */ ;
    defparam i12_3_lut_4_lut_4_lut.init = 16'he0e3;
    LUT4 i923_2_lut_3_lut (.A(n1441), .B(n1470), .C(n911), .Z(n1477)) /* synthesis lut_function=(A+((C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i923_2_lut_3_lut.init = 16'hfbfb;
    LUT4 mux_311_i21_4_lut_4_lut (.A(next_state[1]), .B(n1441), .C(n1470), 
         .D(n907), .Z(n1473)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[12:22])
    defparam mux_311_i21_4_lut_4_lut.init = 16'hf5c5;
    FD1P3IX debounce_counters_4___i25 (.D(n343), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i25.GSR = "ENABLED";
    CCU2D add_29_13 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3055), .COUT(n3056), .S0(n251), 
          .S1(n250));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_13.INIT0 = 16'h5aaa;
    defparam add_29_13.INIT1 = 16'h5aaa;
    defparam add_29_13.INJECT1_0 = "NO";
    defparam add_29_13.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i24 (.D(n344), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i23 (.D(n345), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i11 (.D(n357), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i11.GSR = "ENABLED";
    IB PPn_VIN_pad (.I(PPn_VIN), .O(PPn_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(61[3:10])
    IB FPIO_FlexMIO52_c_pad (.I(FlexMIOs52_PCIe), .O(FPIO_FlexMIO52_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(46[3:18])
    IB DIGS3C_SlotD_ReqOE_pad_1 (.I(DIGS3C_SlotD_ReqOE[1]), .O(DIGS3C_SlotD_ReqOE_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(41[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_2 (.I(DIGS3C_SlotD_ReqOE[2]), .O(DIGS3C_SlotD_ReqOE_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(41[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_3 (.I(DIGS3C_SlotD_ReqOE[3]), .O(DIGS3C_SlotD_ReqOE_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(41[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_4 (.I(DIGS3C_SlotD_ReqOE[4]), .O(DIGS3C_SlotD_ReqOE_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(41[3:21])
    IB DIGS3C_SlotD_ReqOE_pad_5 (.I(DIGS3C_SlotD_ReqOE[5]), .O(DIGS3C_SlotD_ReqOE_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(41[3:21])
    IB FP_UsrSW3_pad (.I(FP_UsrSW3), .O(FP_UsrSW3_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(27[3:12])
    IB FP_UsrSW1_pad (.I(FP_UsrSW1), .O(FP_UsrSW1_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(25[3:12])
    IB SysSW_Pwr_NC_pad (.I(SysSW_Pwr_NC), .O(SysSW_Pwr_NC_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(24[3:15])
    IB FlexMio61ExternalStop_c_pad (.I(FPIO_ExternalStop), .O(FlexMio61ExternalStop_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(21[3:20])
    OB Carrier_PwrOn_pad (.I(Carrier_PwrOn_c), .O(Carrier_PwrOn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(59[9:22])
    OB DIGS3C_SlotD_SlotOE_pad_1 (.I(DIGS3C_SlotD_SlotOE_c_1), .O(DIGS3C_SlotD_SlotOE[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(56[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_2 (.I(DIGS3C_SlotD_SlotOE_c_2), .O(DIGS3C_SlotD_SlotOE[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(56[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_3 (.I(DIGS3C_SlotD_SlotOE_c_3), .O(DIGS3C_SlotD_SlotOE[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(56[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_4 (.I(DIGS3C_SlotD_SlotOE_c_4), .O(DIGS3C_SlotD_SlotOE[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(56[3:22])
    OB DIGS3C_SlotD_SlotOE_pad_5 (.I(DIGS3C_SlotD_SlotOE_c_5), .O(DIGS3C_SlotD_SlotOE[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(56[3:22])
    OB ANL_S3C_P54_Legacy_pad (.I(GND_net), .O(ANL_S3C_P54_Legacy));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(55[3:21])
    OB ANL_S3C_CarrierReady_pad (.I(GND_net), .O(ANL_S3C_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(54[3:23])
    OB FlexMIOs53_GPIO_PowerDown_pad (.I(FlexMIOs53_GPIO_PowerDown_c), .O(FlexMIOs53_GPIO_PowerDown));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(48[3:28])
    OB FlexMio61ExternalStop_pad (.I(FlexMio61ExternalStop_c_c), .O(FlexMio61ExternalStop));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(47[3:24])
    OB SD_SEL_pad (.I(GND_net), .O(SD_SEL));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(45[3:9])
    OB DIGS3C_Shared_ReqSafeState_pad (.I(DIGS3C_Shared_ReqSafeState_c), .O(DIGS3C_Shared_ReqSafeState));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(39[3:29])
    OB DIGS3C_Shared_CarrierReady_pad (.I(GND_net), .O(DIGS3C_Shared_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(38[3:29])
    OBZ n1871_pad (.I(GND_net), .T(n1872), .O(Carrier_PG_1V8));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(170[1] 311[13])
    CCU2D add_1473_22 (.A0(\debounce_counters[4] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3126), .COUT(n3127));
    defparam add_1473_22.INIT0 = 16'h5555;
    defparam add_1473_22.INIT1 = 16'h5555;
    defparam add_1473_22.INJECT1_0 = "NO";
    defparam add_1473_22.INJECT1_1 = "NO";
    OB FP_SysLEDs_pad (.I(FP_SysLEDs_c), .O(FP_SysLEDs));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(33[3:13])
    OB FP_UsrLED4_pad (.I(FP_UsrLED4_c), .O(FP_UsrLED4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(32[3:13])
    OB FP_UsrLED3_pad (.I(FP_UsrLED3_c), .O(FP_UsrLED3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(31[3:13])
    OB FP_UsrLED2_pad (.I(FP_UsrLED2_c), .O(FP_UsrLED2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(30[3:13])
    OB FP_UsrLED1_pad (.I(next_state_3__N_328[0]), .O(FP_UsrLED1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(29[3:13])
    OB FPIO_isoCtrlRSTn_pad (.I(FPIO_isoCtrlRSTn_c), .O(FPIO_isoCtrlRSTn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(22[3:19])
    OB FPIO_FlexMIO52_pad (.I(FPIO_FlexMIO52_c_c), .O(FPIO_FlexMIO52));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(20[3:17])
    OB Carrier_PG_3V3_pad (.I(Carrier_PG_3V3_c), .O(Carrier_PG_3V3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(19[3:17])
    OB FP_SysLEDb_pad (.I(FP_SysLEDb_c), .O(FP_SysLEDb));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(18[3:13])
    OB FP_SysLEDr_pad (.I(FP_SysLEDr_c), .O(FP_SysLEDr));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(17[3:13])
    LUT4 mux_311_i18_4_lut_4_lut (.A(next_state[1]), .B(n1441), .C(n1470), 
         .D(n910), .Z(n1476)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[12:22])
    defparam mux_311_i18_4_lut_4_lut.init = 16'hf5c5;
    LUT4 i1_2_lut_3_lut_4_lut_then_4_lut (.A(next_state[2]), .B(next_state[0]), 
         .C(n3493), .D(next_state[3]), .Z(n3515)) /* synthesis lut_function=(A (B+(D))+!A (B ((D)+!C)+!B (D))) */ ;
    defparam i1_2_lut_3_lut_4_lut_then_4_lut.init = 16'hff8c;
    CCU2D add_202_11 (.A0(counter[9]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[10]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3086), .COUT(n3087), .S0(n918), .S1(n917));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(290[17:24])
    defparam add_202_11.INIT0 = 16'h5555;
    defparam add_202_11.INIT1 = 16'h5555;
    defparam add_202_11.INJECT1_0 = "NO";
    defparam add_202_11.INJECT1_1 = "NO";
    CCU2D add_202_9 (.A0(counter[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[8]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3085), .COUT(n3086), .S0(n920), .S1(n919));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(290[17:24])
    defparam add_202_9.INIT0 = 16'h5555;
    defparam add_202_9.INIT1 = 16'h5555;
    defparam add_202_9.INJECT1_0 = "NO";
    defparam add_202_9.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_4___i10 (.D(n358), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i9 (.D(n359), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i8 (.D(n360), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i7 (.D(n361), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i6 (.D(n362), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i5 (.D(n363), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i4 (.D(n364), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i3 (.D(n365), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i2 (.D(n366), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i1 (.D(n367), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_4___i31 (.D(n337), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i31.GSR = "ENABLED";
    LUT4 i1_2_lut_3_lut_4_lut_else_4_lut (.A(next_state[2]), .B(next_state[0]), 
         .C(next_state_3__N_328[0]), .D(next_state[3]), .Z(n3514)) /* synthesis lut_function=(A (D)+!A (B (D)+!B !((D)+!C))) */ ;
    defparam i1_2_lut_3_lut_4_lut_else_4_lut.init = 16'hee10;
    FD1P3AX next_state_i2 (.D(next_state_3__N_28[2]), .SP(clk_enable_44), 
            .CK(clk), .Q(next_state[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam next_state_i2.GSR = "ENABLED";
    LUT4 mux_203_Mux_2_i15_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), 
         .C(next_state[3]), .D(n3), .Z(Carrier_PG_1V8_N_483)) /* synthesis lut_function=(A (C)+!A (B (C+(D))+!B !(C+!(D)))) */ ;
    defparam mux_203_Mux_2_i15_4_lut_4_lut.init = 16'he5e0;
    LUT4 i43_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), .C(next_state[0]), 
         .D(next_state[3]), .Z(n22_adj_7)) /* synthesis lut_function=(!(A ((D)+!B)+!A (B (D)+!B (C+!(D))))) */ ;
    defparam i43_4_lut_4_lut.init = 16'h01cc;
    CCU2D add_20_7 (.A0(\debounce_counters[2] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3036), .COUT(n3037), .S0(n151), 
          .S1(n150));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_7.INIT0 = 16'h5aaa;
    defparam add_20_7.INIT1 = 16'h5aaa;
    defparam add_20_7.INJECT1_0 = "NO";
    defparam add_20_7.INJECT1_1 = "NO";
    LUT4 i54_4_lut_4_lut_4_lut (.A(next_state_3__N_328[0]), .B(next_state[0]), 
         .C(next_state[1]), .D(n3493), .Z(n20_adj_3)) /* synthesis lut_function=(A (B (C)+!B !((D)+!C))+!A (B+!(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(181[5] 188[12])
    defparam i54_4_lut_4_lut_4_lut.init = 16'hc5f5;
    LUT4 FPIO_isoCtrlRSTn_N_468_bdd_4_lut_1713 (.A(n3493), .B(next_state_3__N_328[0]), 
         .C(next_state[0]), .D(next_state[3]), .Z(n3432)) /* synthesis lut_function=(A (B (C+!(D))+!B !(C+(D)))+!A (B+!(C))) */ ;
    defparam FPIO_isoCtrlRSTn_N_468_bdd_4_lut_1713.init = 16'hc5cf;
    LUT4 mux_203_Mux_11_i6_4_lut (.A(next_state_3__N_328[0]), .B(next_state[0]), 
         .C(next_state[1]), .D(n3493), .Z(n6)) /* synthesis lut_function=(A (B (C))+!A (B (C)+!B !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam mux_203_Mux_11_i6_4_lut.init = 16'hc0c1;
    LUT4 FPIO_isoCtrlRSTn_N_468_bdd_2_lut_1702 (.A(n3493), .B(next_state[3]), 
         .Z(n3431)) /* synthesis lut_function=((B)+!A) */ ;
    defparam FPIO_isoCtrlRSTn_N_468_bdd_2_lut_1702.init = 16'hdddd;
    CCU2D add_1473_20 (.A0(\debounce_counters[4] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3125), .COUT(n3126));
    defparam add_1473_20.INIT0 = 16'h5555;
    defparam add_1473_20.INIT1 = 16'h5555;
    defparam add_1473_20.INJECT1_0 = "NO";
    defparam add_1473_20.INJECT1_1 = "NO";
    FD1P3IX counter__i1 (.D(n1492), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i1.GSR = "ENABLED";
    FD1P3IX counter__i2 (.D(n1491), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i2.GSR = "ENABLED";
    FD1P3IX counter__i3 (.D(n1490), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i3.GSR = "ENABLED";
    FD1P3IX counter__i4 (.D(n1489), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i4.GSR = "ENABLED";
    FD1P3IX counter__i5 (.D(n1488), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i5.GSR = "ENABLED";
    FD1P3IX counter__i6 (.D(n1487), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i6.GSR = "ENABLED";
    FD1P3IX counter__i7 (.D(n1486), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i7.GSR = "ENABLED";
    FD1P3IX counter__i8 (.D(n1485), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i8.GSR = "ENABLED";
    FD1P3IX counter__i9 (.D(n1484), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i9.GSR = "ENABLED";
    FD1P3IX counter__i10 (.D(n1483), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i10.GSR = "ENABLED";
    FD1P3IX counter__i11 (.D(n1482), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i11.GSR = "ENABLED";
    FD1P3IX counter__i12 (.D(n1481), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i12.GSR = "ENABLED";
    FD1P3IX counter__i13 (.D(n1480), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i13.GSR = "ENABLED";
    FD1P3IX counter__i14 (.D(n1479), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i14.GSR = "ENABLED";
    FD1P3IX counter__i15 (.D(n1478), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i15.GSR = "ENABLED";
    FD1P3IX counter__i16 (.D(n1477), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i16.GSR = "ENABLED";
    FD1P3IX counter__i17 (.D(n1476), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i17.GSR = "ENABLED";
    FD1P3IX counter__i18 (.D(n1475), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i18.GSR = "ENABLED";
    FD1P3IX counter__i19 (.D(n1474), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i19.GSR = "ENABLED";
    FD1P3IX counter__i20 (.D(n1473), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i20.GSR = "ENABLED";
    FD1P3IX counter__i21 (.D(n1472), .SP(clk_enable_65), .CD(n1864), .CK(clk), 
            .Q(counter[21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam counter__i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i1 (.D(n155), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i2 (.D(n154), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i3 (.D(n153), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i4 (.D(n152), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i5 (.D(n151), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i6 (.D(n150), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i7 (.D(n149), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i8 (.D(n148), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i9 (.D(n147), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i10 (.D(n146), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i11 (.D(n145), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i12 (.D(n144), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i13 (.D(n143), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i14 (.D(n142), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i15 (.D(n141), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i16 (.D(n140), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i17 (.D(n139), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i18 (.D(n138), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i19 (.D(n137), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i20 (.D(n136), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i21 (.D(n135), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i22 (.D(n134), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i23 (.D(n133), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i24 (.D(n132), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i25 (.D(n131), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i26 (.D(n130), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i27 (.D(n129), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i28 (.D(n128), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i29 (.D(n127), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i30 (.D(n126), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i31 (.D(n125), .SP(clk_enable_96), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_2___i31.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn2_i2 (.D(button_inputs_asyn1[2]), .CK(clk), 
            .Q(button_inputs_asyn2[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam button_inputs_asyn2_i2.GSR = "ENABLED";
    FD1P3AX next_state_i1 (.D(next_state_3__N_28[1]), .SP(clk_enable_97), 
            .CK(clk), .Q(next_state[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam next_state_i1.GSR = "ENABLED";
    CCU2D add_1473_18 (.A0(\debounce_counters[4] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3124), .COUT(n3125));
    defparam add_1473_18.INIT0 = 16'h5555;
    defparam add_1473_18.INIT1 = 16'h5555;
    defparam add_1473_18.INJECT1_0 = "NO";
    defparam add_1473_18.INJECT1_1 = "NO";
    LUT4 n3429_bdd_2_lut (.A(n3429), .B(next_state[3]), .Z(next_state_3__N_28[1])) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam n3429_bdd_2_lut.init = 16'h2222;
    FD1S3AY button_inputs_asyn2_i3 (.D(button_inputs_asyn1[3]), .CK(clk), 
            .Q(button_inputs_asyn2[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam button_inputs_asyn2_i3.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn2_i4 (.D(button_inputs_asyn1[4]), .CK(clk), 
            .Q(button_inputs_asyn2[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam button_inputs_asyn2_i4.GSR = "ENABLED";
    FD1P3IX pushed_i2 (.D(n3579), .SP(clk_enable_98), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(pushed[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam pushed_i2.GSR = "ENABLED";
    FD1P3IX pushed_i3 (.D(n3579), .SP(clk_enable_99), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(pushed[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam pushed_i3.GSR = "ENABLED";
    FD1P3IX pushed_i4 (.D(n3579), .SP(clk_enable_100), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(pushed[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam pushed_i4.GSR = "ENABLED";
    FD1S3AY buttons_debounced_syn_i2 (.D(pushed_2__N_185), .CK(clk), .Q(buttons_debounced_syn[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam buttons_debounced_syn_i2.GSR = "ENABLED";
    FD1S3AY buttons_debounced_syn_i3 (.D(pushed_3__N_183), .CK(clk), .Q(FP_UsrLED3_c)) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam buttons_debounced_syn_i3.GSR = "ENABLED";
    FD1S3AY buttons_debounced_syn_i4 (.D(pushed_4__N_181), .CK(clk), .Q(FP_UsrLED4_c)) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam buttons_debounced_syn_i4.GSR = "ENABLED";
    CCU2D add_202_7 (.A0(counter[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3084), .COUT(n3085), .S0(n922), .S1(n921));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(290[17:24])
    defparam add_202_7.INIT0 = 16'h5555;
    defparam add_202_7.INIT1 = 16'h5555;
    defparam add_202_7.INJECT1_0 = "NO";
    defparam add_202_7.INJECT1_1 = "NO";
    LUT4 i2_4_lut (.A(FP_SysLEDs_N_470), .B(next_state[2]), .C(n1525), 
         .D(next_state[0]), .Z(n1441)) /* synthesis lut_function=(A (B (C (D)))) */ ;
    defparam i2_4_lut.init = 16'h8000;
    LUT4 next_state_3__bdd_4_lut_1710 (.A(next_state[2]), .B(buttons_debounced_syn[2]), 
         .C(next_state[0]), .D(next_state[1]), .Z(n3429)) /* synthesis lut_function=(A (B (D)+!B (C+(D)))+!A !(C (D)+!C !(D))) */ ;
    defparam next_state_3__bdd_4_lut_1710.init = 16'haf70;
    LUT4 i34_4_lut (.A(n3493), .B(n3283), .C(next_state[2]), .D(n16), 
         .Z(n1470)) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[12:22])
    defparam i34_4_lut.init = 16'hcac0;
    CCU2D add_1473_16 (.A0(\debounce_counters[4] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3123), .COUT(n3124));
    defparam add_1473_16.INIT0 = 16'h5555;
    defparam add_1473_16.INIT1 = 16'h5555;
    defparam add_1473_16.INJECT1_0 = "NO";
    defparam add_1473_16.INJECT1_1 = "NO";
    CCU2D add_202_5 (.A0(counter[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3083), .COUT(n3084), .S0(n924), .S1(n923));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(290[17:24])
    defparam add_202_5.INIT0 = 16'h5555;
    defparam add_202_5.INIT1 = 16'h5555;
    defparam add_202_5.INJECT1_0 = "NO";
    defparam add_202_5.INJECT1_1 = "NO";
    PFUMX i1711 (.BLUT(n3448), .ALUT(n3447), .C0(next_state[3]), .Z(clk_enable_17));
    CCU2D add_20_5 (.A0(\debounce_counters[2] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3035), .COUT(n3036), .S0(n153), 
          .S1(n152));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_5.INIT0 = 16'h5aaa;
    defparam add_20_5.INIT1 = 16'h5aaa;
    defparam add_20_5.INJECT1_0 = "NO";
    defparam add_20_5.INJECT1_1 = "NO";
    CCU2D add_1473_14 (.A0(\debounce_counters[4] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3122), .COUT(n3123));
    defparam add_1473_14.INIT0 = 16'h5555;
    defparam add_1473_14.INIT1 = 16'h5555;
    defparam add_1473_14.INJECT1_0 = "NO";
    defparam add_1473_14.INJECT1_1 = "NO";
    CCU2D add_1473_12 (.A0(\debounce_counters[4] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3121), .COUT(n3122));
    defparam add_1473_12.INIT0 = 16'h5555;
    defparam add_1473_12.INIT1 = 16'h5555;
    defparam add_1473_12.INJECT1_0 = "NO";
    defparam add_1473_12.INJECT1_1 = "NO";
    CCU2D add_29_11 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3054), .COUT(n3055), .S0(n253), 
          .S1(n252));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_11.INIT0 = 16'h5aaa;
    defparam add_29_11.INIT1 = 16'h5aaa;
    defparam add_29_11.INJECT1_0 = "NO";
    defparam add_29_11.INJECT1_1 = "NO";
    CCU2D add_202_3 (.A0(counter[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3082), .COUT(n3083), .S0(n926), .S1(n925));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(290[17:24])
    defparam add_202_3.INIT0 = 16'h5555;
    defparam add_202_3.INIT1 = 16'h5555;
    defparam add_202_3.INJECT1_0 = "NO";
    defparam add_202_3.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_1 (.A(n3493), .B(FP_SysLEDs_N_470), .C(n1525), .D(next_state[0]), 
         .Z(n3283)) /* synthesis lut_function=(A (B (C+!(D)))+!A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[12:22])
    defparam i1_4_lut_adj_1.init = 16'hc088;
    LUT4 i36_3_lut (.A(next_state[3]), .B(next_state[1]), .C(next_state[0]), 
         .Z(n16)) /* synthesis lut_function=(!(A (B+(C))+!A !(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[12:22])
    defparam i36_3_lut.init = 16'h4646;
    LUT4 i1678_2_lut (.A(next_state[3]), .B(next_state[1]), .Z(FP_SysLEDs_N_470)) /* synthesis lut_function=(!(A+(B))) */ ;
    defparam i1678_2_lut.init = 16'h1111;
    CCU2D add_29_9 (.A0(\debounce_counters[3] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3053), .COUT(n3054), .S0(n255), 
          .S1(n254));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_9.INIT0 = 16'h5aaa;
    defparam add_29_9.INIT1 = 16'h5aaa;
    defparam add_29_9.INJECT1_0 = "NO";
    defparam add_29_9.INJECT1_1 = "NO";
    CCU2D add_202_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n3082), .S1(n927));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(290[17:24])
    defparam add_202_1.INIT0 = 16'hF000;
    defparam add_202_1.INIT1 = 16'h5555;
    defparam add_202_1.INJECT1_0 = "NO";
    defparam add_202_1.INJECT1_1 = "NO";
    CCU2D add_1473_10 (.A0(\debounce_counters[4] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3120), .COUT(n3121));
    defparam add_1473_10.INIT0 = 16'h5555;
    defparam add_1473_10.INIT1 = 16'h5555;
    defparam add_1473_10.INJECT1_0 = "NO";
    defparam add_1473_10.INJECT1_1 = "NO";
    LUT4 i53_3_lut_3_lut (.A(buttons_debounced_syn[2]), .B(next_state[0]), 
         .C(next_state_3__N_328[0]), .Z(n23_adj_4)) /* synthesis lut_function=(!(A (B+!(C))+!A !(B+(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(241[17] 247[12])
    defparam i53_3_lut_3_lut.init = 16'h7474;
    LUT4 n3309_bdd_4_lut_then_4_lut (.A(next_state[0]), .B(next_state_3__N_328[0]), 
         .C(next_state[2]), .D(next_state[1]), .Z(n3503)) /* synthesis lut_function=(!(A+(B (C+(D))+!B !(C)))) */ ;
    defparam n3309_bdd_4_lut_then_4_lut.init = 16'h1014;
    CCU2D add_1473_8 (.A0(\debounce_counters[4] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3119), .COUT(n3120));
    defparam add_1473_8.INIT0 = 16'h5555;
    defparam add_1473_8.INIT1 = 16'h5aaa;
    defparam add_1473_8.INJECT1_0 = "NO";
    defparam add_1473_8.INJECT1_1 = "NO";
    CCU2D add_1473_6 (.A0(\debounce_counters[4] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3118), .COUT(n3119));
    defparam add_1473_6.INIT0 = 16'h5555;
    defparam add_1473_6.INIT1 = 16'h5aaa;
    defparam add_1473_6.INJECT1_0 = "NO";
    defparam add_1473_6.INJECT1_1 = "NO";
    CCU2D add_38_33 (.A0(\debounce_counters[4] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3081), .S0(n337));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_33.INIT0 = 16'h5aaa;
    defparam add_38_33.INIT1 = 16'h0000;
    defparam add_38_33.INJECT1_0 = "NO";
    defparam add_38_33.INJECT1_1 = "NO";
    CCU2D add_1473_4 (.A0(\debounce_counters[4] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3117), .COUT(n3118));
    defparam add_1473_4.INIT0 = 16'h5555;
    defparam add_1473_4.INIT1 = 16'h5555;
    defparam add_1473_4.INJECT1_0 = "NO";
    defparam add_1473_4.INJECT1_1 = "NO";
    CCU2D add_29_7 (.A0(\debounce_counters[3] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3052), .COUT(n3053), .S0(n257), 
          .S1(n256));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_7.INIT0 = 16'h5aaa;
    defparam add_29_7.INIT1 = 16'h5aaa;
    defparam add_29_7.INJECT1_0 = "NO";
    defparam add_29_7.INJECT1_1 = "NO";
    CCU2D add_1473_2 (.A0(\debounce_counters[4] [7]), .B0(\debounce_counters[4] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[4] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n3117));
    defparam add_1473_2.INIT0 = 16'h1000;
    defparam add_1473_2.INIT1 = 16'h5aaa;
    defparam add_1473_2.INJECT1_0 = "NO";
    defparam add_1473_2.INJECT1_1 = "NO";
    CCU2D add_1470_26 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3116), .S1(clk_enable_99));
    defparam add_1470_26.INIT0 = 16'hf555;
    defparam add_1470_26.INIT1 = 16'h0000;
    defparam add_1470_26.INJECT1_0 = "NO";
    defparam add_1470_26.INJECT1_1 = "NO";
    LUT4 i413_2_lut (.A(clk_enable_7), .B(button_inputs_asyn2[1]), .Z(clk_enable_132)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i413_2_lut.init = 16'hdddd;
    CCU2D add_20_3 (.A0(\debounce_counters[2] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3034), .COUT(n3035), .S0(n155), 
          .S1(n154));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_3.INIT0 = 16'h5aaa;
    defparam add_20_3.INIT1 = 16'h5aaa;
    defparam add_20_3.INJECT1_0 = "NO";
    defparam add_20_3.INJECT1_1 = "NO";
    CCU2D add_11_13 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3023), .COUT(n3024), .S0(n39), 
          .S1(n38));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_13.INIT0 = 16'h5aaa;
    defparam add_11_13.INIT1 = 16'h5aaa;
    defparam add_11_13.INJECT1_0 = "NO";
    defparam add_11_13.INJECT1_1 = "NO";
    CCU2D add_29_5 (.A0(\debounce_counters[3] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3051), .COUT(n3052), .S0(n259), 
          .S1(n258));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_5.INIT0 = 16'h5aaa;
    defparam add_29_5.INIT1 = 16'h5aaa;
    defparam add_29_5.INJECT1_0 = "NO";
    defparam add_29_5.INJECT1_1 = "NO";
    CCU2D add_29_3 (.A0(\debounce_counters[3] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3050), .COUT(n3051), .S0(n261), 
          .S1(n260));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_3.INIT0 = 16'h5aaa;
    defparam add_29_3.INIT1 = 16'h5aaa;
    defparam add_29_3.INJECT1_0 = "NO";
    defparam add_29_3.INJECT1_1 = "NO";
    CCU2D add_38_31 (.A0(\debounce_counters[4] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3080), .COUT(n3081), .S0(n339), 
          .S1(n338));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_31.INIT0 = 16'h5aaa;
    defparam add_38_31.INIT1 = 16'h5aaa;
    defparam add_38_31.INJECT1_0 = "NO";
    defparam add_38_31.INJECT1_1 = "NO";
    LUT4 mux_311_i7_4_lut (.A(next_state[1]), .B(n921), .C(n1470), .D(n1441), 
         .Z(n1487)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam mux_311_i7_4_lut.init = 16'h0aca;
    CCU2D add_20_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[2] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n3034), .S1(n156));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_1.INIT0 = 16'hF000;
    defparam add_20_1.INIT1 = 16'h5555;
    defparam add_20_1.INJECT1_0 = "NO";
    defparam add_20_1.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_47_3_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[1]), 
         .Z(n3494)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;
    defparam i1_2_lut_rep_47_3_lut.init = 16'h1010;
    CCU2D add_29_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[3] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n3050), .S1(n262));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_1.INIT0 = 16'hF000;
    defparam add_29_1.INIT1 = 16'h5555;
    defparam add_29_1.INJECT1_0 = "NO";
    defparam add_29_1.INJECT1_1 = "NO";
    CCU2D add_1470_24 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3115), .COUT(n3116));
    defparam add_1470_24.INIT0 = 16'h5555;
    defparam add_1470_24.INIT1 = 16'h5555;
    defparam add_1470_24.INJECT1_0 = "NO";
    defparam add_1470_24.INJECT1_1 = "NO";
    LUT4 i1656_4_lut (.A(n3498), .B(n3493), .C(next_state_3__N_328[0]), 
         .D(next_state[0]), .Z(n27_adj_2)) /* synthesis lut_function=(!(A+(B (C+!(D))+!B (C (D))))) */ ;
    defparam i1656_4_lut.init = 16'h0511;
    LUT4 i910_2_lut_3_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[0]), 
         .Z(Carrier_PwrOn_N_478)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;
    defparam i910_2_lut_3_lut.init = 16'h1010;
    FD1P3AX FP_SysLEDs_175 (.D(FP_SysLEDs_N_470), .SP(clk_enable_101), .CK(clk), 
            .Q(FP_SysLEDs_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam FP_SysLEDs_175.GSR = "ENABLED";
    LUT4 i904_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[1]), 
         .D(next_state[0]), .Z(Carrier_PG_1V8_N_487)) /* synthesis lut_function=(A+(B+!(C (D)+!C !(D)))) */ ;
    defparam i904_3_lut_4_lut.init = 16'heffe;
    LUT4 i1_3_lut_4_lut (.A(n3493), .B(next_state[2]), .C(next_state[0]), 
         .D(next_state_3__N_328[0]), .Z(n4)) /* synthesis lut_function=(((C+(D))+!B)+!A) */ ;
    defparam i1_3_lut_4_lut.init = 16'hfff7;
    LUT4 mux_311_i10_4_lut (.A(next_state[1]), .B(n918), .C(n1470), .D(n1441), 
         .Z(n1484)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam mux_311_i10_4_lut.init = 16'hfaca;
    LUT4 i322_2_lut (.A(buttons_debounced_syn[2]), .B(next_state_3__N_328[0]), 
         .Z(n1525)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam i322_2_lut.init = 16'h2222;
    LUT4 i20_4_lut (.A(counter[2]), .B(n40_adj_8), .C(n34_adj_13), .D(counter[19]), 
         .Z(n42_adj_14)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i20_4_lut.init = 16'hfffe;
    PFUMX i1708 (.BLUT(n3443), .ALUT(n3442), .C0(next_state[3]), .Z(FP_SysLEDg_N_458));
    LUT4 i948_3_lut (.A(n917), .B(n1470), .C(n1441), .Z(n1483)) /* synthesis lut_function=(!(A (B (C))+!A (B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i948_3_lut.init = 16'h3b3b;
    LUT4 i42_4_lut_3_lut_4_lut (.A(next_state[2]), .B(next_state[1]), .C(next_state_3__N_328[0]), 
         .D(next_state[0]), .Z(n25_adj_17)) /* synthesis lut_function=(A (B)+!A !(B+(C (D)+!C !(D)))) */ ;
    defparam i42_4_lut_3_lut_4_lut.init = 16'h8998;
    LUT4 i1672_3_lut_4_lut (.A(next_state[0]), .B(next_state[1]), .C(next_state[2]), 
         .D(next_state[3]), .Z(clk_enable_134)) /* synthesis lut_function=(A+(B+(C (D)+!C !(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i1672_3_lut_4_lut.init = 16'hfeef;
    LUT4 i1_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), .C(next_state[0]), 
         .D(next_state[3]), .Z(clk_enable_14)) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(C+!(D)))) */ ;
    defparam i1_4_lut_4_lut.init = 16'hfefd;
    LUT4 i926_2_lut_3_lut (.A(n1441), .B(n1470), .C(n920), .Z(n1486)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i926_2_lut_3_lut.init = 16'h4040;
    FD1P3IX debounce_counters_1___i1 (.D(n49), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i2 (.D(n48), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i3 (.D(n47), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i4 (.D(n46), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i5 (.D(n45), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i6 (.D(n44), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i7 (.D(n43), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i8 (.D(n42), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i9 (.D(n41), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i10 (.D(n40), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i11 (.D(n39), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i12 (.D(n38), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i13 (.D(n37), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i14 (.D(n36), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i15 (.D(n35), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i16 (.D(n34), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i17 (.D(n33), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i18 (.D(n32), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i19 (.D(n31), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i20 (.D(n30), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i21 (.D(n29), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i22 (.D(n28), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i23 (.D(n27), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i24 (.D(n26), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i25 (.D(n25), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i26 (.D(n24), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i27 (.D(n23), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i28 (.D(n22), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i29 (.D(n21), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i30 (.D(n20), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i31 (.D(n19), .SP(clk_enable_132), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_1___i31.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn1_i2 (.D(FlexMio61ExternalStop_c_c), .CK(clk), 
            .Q(button_inputs_asyn1[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam button_inputs_asyn1_i2.GSR = "ENABLED";
    LUT4 i416_2_lut (.A(clk_enable_100), .B(button_inputs_asyn2[4]), .Z(clk_enable_136)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i416_2_lut.init = 16'hdddd;
    LUT4 i2_3_lut_4_lut (.A(n3493), .B(next_state_3__N_328[0]), .C(next_state[2]), 
         .D(next_state[0]), .Z(n3292)) /* synthesis lut_function=(!((B+((D)+!C))+!A)) */ ;
    defparam i2_3_lut_4_lut.init = 16'h0020;
    CCU2D add_11_33 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3033), .S0(n19));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_33.INIT0 = 16'h5aaa;
    defparam add_11_33.INIT1 = 16'h0000;
    defparam add_11_33.INJECT1_0 = "NO";
    defparam add_11_33.INJECT1_1 = "NO";
    LUT4 n1953_bdd_4_lut_then_3_lut (.A(next_state[2]), .B(next_state_3__N_328[0]), 
         .C(next_state[1]), .Z(n3500)) /* synthesis lut_function=(!(A+(B+(C)))) */ ;
    defparam n1953_bdd_4_lut_then_3_lut.init = 16'h0101;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut (.A(DIGS3C_SlotD_ReqOE_c_3), .B(FP_UsrLED2_c), 
         .Z(DIGS3C_SlotD_SlotOE_c_3)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(128[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i3_2_lut.init = 16'h2222;
    CCU2D add_1470_22 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3114), .COUT(n3115));
    defparam add_1470_22.INIT0 = 16'h5555;
    defparam add_1470_22.INIT1 = 16'h5555;
    defparam add_1470_22.INJECT1_0 = "NO";
    defparam add_1470_22.INJECT1_1 = "NO";
    LUT4 next_state_3__bdd_3_lut_1753 (.A(next_state[0]), .B(next_state[2]), 
         .C(next_state[1]), .Z(n3447)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam next_state_3__bdd_3_lut_1753.init = 16'hfefe;
    LUT4 i16_4_lut (.A(counter[15]), .B(counter[6]), .C(counter[3]), .D(counter[12]), 
         .Z(n38_adj_15)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i16_4_lut.init = 16'hfffe;
    LUT4 i21_4_lut_rep_46 (.A(n29_adj_5), .B(n42_adj_14), .C(n38_adj_15), 
         .D(n30_adj_18), .Z(n3493)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i21_4_lut_rep_46.init = 16'hfffe;
    LUT4 mux_203_Mux_9_i15_3_lut_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), 
         .C(next_state[3]), .D(next_state[0]), .Z(FP_SysLEDr_N_459)) /* synthesis lut_function=(!(A ((C)+!B)+!A (B (C+(D))))) */ ;
    defparam mux_203_Mux_9_i15_3_lut_4_lut_4_lut.init = 16'h191d;
    LUT4 i949_3_lut (.A(n913), .B(n1470), .C(n1441), .Z(n1479)) /* synthesis lut_function=(A (B)+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i949_3_lut.init = 16'hc8c8;
    LUT4 i950_3_lut (.A(n912), .B(n1470), .C(n1441), .Z(n1478)) /* synthesis lut_function=(!(A (B (C))+!A (B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i950_3_lut.init = 16'h3b3b;
    FD1S3AY button_inputs_asyn1_i3 (.D(FP_UsrSW3_c), .CK(clk), .Q(button_inputs_asyn1[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam button_inputs_asyn1_i3.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn1_i4 (.D(FP_UsrSW1_c), .CK(clk), .Q(button_inputs_asyn1[4])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam button_inputs_asyn1_i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i1 (.D(n261), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i1.GSR = "ENABLED";
    CCU2D add_38_29 (.A0(\debounce_counters[4] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3079), .COUT(n3080), .S0(n341), 
          .S1(n340));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_29.INIT0 = 16'h5aaa;
    defparam add_38_29.INIT1 = 16'h5aaa;
    defparam add_38_29.INJECT1_0 = "NO";
    defparam add_38_29.INJECT1_1 = "NO";
    CCU2D add_20_33 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3049), .S0(n125));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_33.INIT0 = 16'h5aaa;
    defparam add_20_33.INIT1 = 16'h0000;
    defparam add_20_33.INJECT1_0 = "NO";
    defparam add_20_33.INJECT1_1 = "NO";
    CCU2D add_38_27 (.A0(\debounce_counters[4] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3078), .COUT(n3079), .S0(n343), 
          .S1(n342));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_27.INIT0 = 16'h5aaa;
    defparam add_38_27.INIT1 = 16'h5aaa;
    defparam add_38_27.INJECT1_0 = "NO";
    defparam add_38_27.INJECT1_1 = "NO";
    CCU2D add_20_31 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3048), .COUT(n3049), .S0(n127), 
          .S1(n126));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_31.INIT0 = 16'h5aaa;
    defparam add_20_31.INIT1 = 16'h5aaa;
    defparam add_20_31.INJECT1_0 = "NO";
    defparam add_20_31.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_2 (.A(next_state[1]), .B(n3169), .C(next_state[2]), 
         .D(n42_adj_1), .Z(n34_adj_9)) /* synthesis lut_function=(!(A+!(B+!(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i1_4_lut_adj_2.init = 16'h4544;
    LUT4 next_state_3__bdd_4_lut_1754 (.A(next_state_3__N_328[0]), .B(next_state[0]), 
         .C(next_state[2]), .D(next_state[1]), .Z(n3448)) /* synthesis lut_function=(A (B (C (D)+!C !(D))+!B !(C+(D)))+!A (B (C (D)))) */ ;
    defparam next_state_3__bdd_4_lut_1754.init = 16'hc00a;
    CCU2D add_38_25 (.A0(\debounce_counters[4] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3077), .COUT(n3078), .S0(n345), 
          .S1(n344));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_25.INIT0 = 16'h5aaa;
    defparam add_38_25.INIT1 = 16'h5aaa;
    defparam add_38_25.INJECT1_0 = "NO";
    defparam add_38_25.INJECT1_1 = "NO";
    LUT4 n3309_bdd_4_lut_else_4_lut (.A(next_state[0]), .B(next_state_3__N_328[0]), 
         .C(next_state[2]), .D(next_state[1]), .Z(n3502)) /* synthesis lut_function=(!(A+((C+(D))+!B))) */ ;
    defparam n3309_bdd_4_lut_else_4_lut.init = 16'h0004;
    CCU2D add_1470_20 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3113), .COUT(n3114));
    defparam add_1470_20.INIT0 = 16'h5555;
    defparam add_1470_20.INIT1 = 16'h5555;
    defparam add_1470_20.INJECT1_0 = "NO";
    defparam add_1470_20.INJECT1_1 = "NO";
    CCU2D add_38_23 (.A0(\debounce_counters[4] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3076), .COUT(n3077), .S0(n347), 
          .S1(n346));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_23.INIT0 = 16'h5aaa;
    defparam add_38_23.INIT1 = 16'h5aaa;
    defparam add_38_23.INJECT1_0 = "NO";
    defparam add_38_23.INJECT1_1 = "NO";
    CCU2D add_11_31 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3032), .COUT(n3033), .S0(n21), 
          .S1(n20));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_31.INIT0 = 16'h5aaa;
    defparam add_11_31.INIT1 = 16'h5aaa;
    defparam add_11_31.INJECT1_0 = "NO";
    defparam add_11_31.INJECT1_1 = "NO";
    CCU2D add_1470_18 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3112), .COUT(n3113));
    defparam add_1470_18.INIT0 = 16'h5555;
    defparam add_1470_18.INIT1 = 16'h5555;
    defparam add_1470_18.INJECT1_0 = "NO";
    defparam add_1470_18.INJECT1_1 = "NO";
    CCU2D add_1470_16 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3111), .COUT(n3112));
    defparam add_1470_16.INIT0 = 16'h5555;
    defparam add_1470_16.INIT1 = 16'h5555;
    defparam add_1470_16.INJECT1_0 = "NO";
    defparam add_1470_16.INJECT1_1 = "NO";
    CCU2D add_38_21 (.A0(\debounce_counters[4] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3075), .COUT(n3076), .S0(n349), 
          .S1(n348));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_21.INIT0 = 16'h5aaa;
    defparam add_38_21.INIT1 = 16'h5aaa;
    defparam add_38_21.INJECT1_0 = "NO";
    defparam add_38_21.INJECT1_1 = "NO";
    LUT4 i951_3_lut (.A(n906), .B(n1470), .C(n1441), .Z(n1472)) /* synthesis lut_function=(A (B)+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i951_3_lut.init = 16'hc8c8;
    CCU2D add_20_29 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3047), .COUT(n3048), .S0(n129), 
          .S1(n128));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_29.INIT0 = 16'h5aaa;
    defparam add_20_29.INIT1 = 16'h5aaa;
    defparam add_20_29.INJECT1_0 = "NO";
    defparam add_20_29.INJECT1_1 = "NO";
    CCU2D add_20_27 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3046), .COUT(n3047), .S0(n131), 
          .S1(n130));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_27.INIT0 = 16'h5aaa;
    defparam add_20_27.INIT1 = 16'h5aaa;
    defparam add_20_27.INJECT1_0 = "NO";
    defparam add_20_27.INJECT1_1 = "NO";
    CCU2D add_1470_14 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3110), .COUT(n3111));
    defparam add_1470_14.INIT0 = 16'h5555;
    defparam add_1470_14.INIT1 = 16'h5555;
    defparam add_1470_14.INJECT1_0 = "NO";
    defparam add_1470_14.INJECT1_1 = "NO";
    CCU2D add_1470_12 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3109), .COUT(n3110));
    defparam add_1470_12.INIT0 = 16'h5555;
    defparam add_1470_12.INIT1 = 16'h5555;
    defparam add_1470_12.INJECT1_0 = "NO";
    defparam add_1470_12.INJECT1_1 = "NO";
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut (.A(DIGS3C_SlotD_ReqOE_c_4), .B(FP_UsrLED2_c), 
         .Z(DIGS3C_SlotD_SlotOE_c_4)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(128[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i4_2_lut.init = 16'h2222;
    CCU2D add_38_19 (.A0(\debounce_counters[4] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3074), .COUT(n3075), .S0(n351), 
          .S1(n350));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_19.INIT0 = 16'h5aaa;
    defparam add_38_19.INIT1 = 16'h5aaa;
    defparam add_38_19.INJECT1_0 = "NO";
    defparam add_38_19.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_4_lut_4_lut_4_lut (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[2]), .D(next_state[3]), .Z(FP_SysLEDb_N_460)) /* synthesis lut_function=(!(A ((D)+!B)+!A ((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam i1_2_lut_3_lut_4_lut_4_lut_4_lut.init = 16'h008c;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut (.A(DIGS3C_SlotD_ReqOE_c_5), .B(FP_UsrLED2_c), 
         .Z(DIGS3C_SlotD_SlotOE_c_5)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(128[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i5_2_lut.init = 16'h2222;
    FD1P3AX FP_SysLEDb_167 (.D(FP_SysLEDb_N_460), .SP(clk_enable_134), .CK(clk), 
            .Q(FP_SysLEDb_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam FP_SysLEDb_167.GSR = "ENABLED";
    FD1P3AX next_state_i0 (.D(next_state_3__N_28[0]), .SP(clk_enable_135), 
            .CK(clk), .Q(next_state[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam next_state_i0.GSR = "ENABLED";
    LUT4 n1953_bdd_4_lut_else_3_lut (.A(next_state[2]), .B(buttons_debounced_syn[2]), 
         .C(next_state_3__N_328[0]), .Z(n3499)) /* synthesis lut_function=(A (B (C))) */ ;
    defparam n1953_bdd_4_lut_else_3_lut.init = 16'h8080;
    LUT4 i1_4_lut_4_lut_4_lut_then_4_lut (.A(next_state[0]), .B(next_state_3__N_328[0]), 
         .C(next_state[3]), .D(n3493), .Z(n3506)) /* synthesis lut_function=(!(A+(B+(C+(D))))) */ ;
    defparam i1_4_lut_4_lut_4_lut_then_4_lut.init = 16'h0001;
    LUT4 pushed_2__I_0_1_lut (.A(pushed[2]), .Z(pushed_2__N_185)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(156[17] 160[24])
    defparam pushed_2__I_0_1_lut.init = 16'h5555;
    LUT4 pushed_3__I_0_1_lut (.A(pushed[3]), .Z(pushed_3__N_183)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(156[17] 160[24])
    defparam pushed_3__I_0_1_lut.init = 16'h5555;
    CCU2D add_1470_10 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3108), .COUT(n3109));
    defparam add_1470_10.INIT0 = 16'h5555;
    defparam add_1470_10.INIT1 = 16'h5555;
    defparam add_1470_10.INJECT1_0 = "NO";
    defparam add_1470_10.INJECT1_1 = "NO";
    LUT4 pushed_4__I_0_1_lut (.A(pushed[4]), .Z(pushed_4__N_181)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(156[17] 160[24])
    defparam pushed_4__I_0_1_lut.init = 16'h5555;
    LUT4 i1_4_lut_4_lut_4_lut_else_4_lut (.A(next_state[0]), .B(next_state[3]), 
         .C(next_state[1]), .Z(n3505)) /* synthesis lut_function=(!(A+((C)+!B))) */ ;
    defparam i1_4_lut_4_lut_4_lut_else_4_lut.init = 16'h0404;
    LUT4 i425_1_lut (.A(Carrier_PG_1V8_N_472), .Z(n1872)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(170[1] 311[13])
    defparam i425_1_lut.init = 16'h5555;
    LUT4 i8_2_lut (.A(counter[5]), .B(counter[11]), .Z(n30_adj_18)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i8_2_lut.init = 16'heeee;
    LUT4 i974_2_lut_3_lut (.A(n1441), .B(n1470), .C(n927), .Z(n1493)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i974_2_lut_3_lut.init = 16'h4040;
    FD1P3IX debounce_counters_4___i0 (.D(n368), .SP(clk_enable_136), .CD(button_inputs_asyn2[4]), 
            .CK(clk), .Q(\debounce_counters[4] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_4___i0.GSR = "ENABLED";
    CCU2D add_1470_8 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3107), .COUT(n3108));
    defparam add_1470_8.INIT0 = 16'h5555;
    defparam add_1470_8.INIT1 = 16'h5aaa;
    defparam add_1470_8.INJECT1_0 = "NO";
    defparam add_1470_8.INJECT1_1 = "NO";
    LUT4 i1_4_lut_then_3_lut (.A(next_state[3]), .B(next_state[1]), .C(next_state[2]), 
         .Z(n3509)) /* synthesis lut_function=(!(A+!(B+(C)))) */ ;
    defparam i1_4_lut_then_3_lut.init = 16'h5454;
    LUT4 i1_4_lut_else_3_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state_3__N_328[0]), 
         .Z(n3508)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;
    defparam i1_4_lut_else_3_lut.init = 16'h4040;
    LUT4 i32_4_lut (.A(n18), .B(n15), .C(next_state[3]), .D(n3498), 
         .Z(clk_enable_44)) /* synthesis lut_function=(A (B (C (D))+!B (C))+!A (((D)+!C)+!B)) */ ;
    defparam i32_4_lut.init = 16'hf535;
    LUT4 i2_3_lut_4_lut_adj_3 (.A(next_state[2]), .B(next_state[1]), .C(next_state[0]), 
         .D(next_state[3]), .Z(clk_enable_8)) /* synthesis lut_function=(A+(B+(C+!(D)))) */ ;
    defparam i2_3_lut_4_lut_adj_3.init = 16'hfeff;
    LUT4 i929_2_lut_3_lut (.A(n1441), .B(n1470), .C(n924), .Z(n1490)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i929_2_lut_3_lut.init = 16'h4040;
    PFUMX i1739 (.BLUT(n3499), .ALUT(n3500), .C0(next_state[3]), .Z(n3501));
    CCU2D add_1470_6 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3106), .COUT(n3107));
    defparam add_1470_6.INIT0 = 16'h5555;
    defparam add_1470_6.INIT1 = 16'h5aaa;
    defparam add_1470_6.INJECT1_0 = "NO";
    defparam add_1470_6.INJECT1_1 = "NO";
    LUT4 n1953_bdd_3_lut_1716_4_lut (.A(next_state[2]), .B(next_state[1]), 
         .C(next_state[0]), .D(FP_SysLEDg_c), .Z(n3442)) /* synthesis lut_function=(!(A+(B+!(C+(D))))) */ ;
    defparam n1953_bdd_3_lut_1716_4_lut.init = 16'h1110;
    CCU2D add_20_25 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3045), .COUT(n3046), .S0(n133), 
          .S1(n132));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_25.INIT0 = 16'h5aaa;
    defparam add_20_25.INIT1 = 16'h5aaa;
    defparam add_20_25.INJECT1_0 = "NO";
    defparam add_20_25.INJECT1_1 = "NO";
    LUT4 i1683_2_lut (.A(next_state[3]), .B(next_state[2]), .Z(n3327)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i1683_2_lut.init = 16'heeee;
    LUT4 i928_2_lut_3_lut (.A(n1441), .B(n1470), .C(n923), .Z(n1489)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i928_2_lut_3_lut.init = 16'h4040;
    LUT4 i927_2_lut_3_lut (.A(n1441), .B(n1470), .C(n922), .Z(n1488)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i927_2_lut_3_lut.init = 16'h4040;
    CCU2D add_38_17 (.A0(\debounce_counters[4] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3073), .COUT(n3074), .S0(n353), 
          .S1(n352));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_17.INIT0 = 16'h5aaa;
    defparam add_38_17.INIT1 = 16'h5aaa;
    defparam add_38_17.INJECT1_0 = "NO";
    defparam add_38_17.INJECT1_1 = "NO";
    LUT4 i2_4_lut_adj_4 (.A(n3513), .B(n3292), .C(n3493), .D(next_state[1]), 
         .Z(n18)) /* synthesis lut_function=(A+(B+(C (D)))) */ ;
    defparam i2_4_lut_adj_4.init = 16'hfeee;
    LUT4 i2_3_lut_4_lut_adj_5 (.A(next_state[3]), .B(next_state_3__N_328[0]), 
         .C(next_state[0]), .D(n3493), .Z(n3169)) /* synthesis lut_function=(!(A+((C+(D))+!B))) */ ;
    defparam i2_3_lut_4_lut_adj_5.init = 16'h0004;
    CCU2D add_1470_4 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3105), .COUT(n3106));
    defparam add_1470_4.INIT0 = 16'h5555;
    defparam add_1470_4.INIT1 = 16'h5555;
    defparam add_1470_4.INJECT1_0 = "NO";
    defparam add_1470_4.INJECT1_1 = "NO";
    CCU2D add_1470_2 (.A0(\debounce_counters[3] [7]), .B0(\debounce_counters[3] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[3] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n3105));
    defparam add_1470_2.INIT0 = 16'h1000;
    defparam add_1470_2.INIT1 = 16'h5aaa;
    defparam add_1470_2.INJECT1_0 = "NO";
    defparam add_1470_2.INJECT1_1 = "NO";
    CCU2D add_1471_26 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3104), .S1(clk_enable_98));
    defparam add_1471_26.INIT0 = 16'hf555;
    defparam add_1471_26.INIT1 = 16'h0000;
    defparam add_1471_26.INJECT1_0 = "NO";
    defparam add_1471_26.INJECT1_1 = "NO";
    CCU2D add_1471_24 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3103), .COUT(n3104));
    defparam add_1471_24.INIT0 = 16'h5555;
    defparam add_1471_24.INIT1 = 16'h5555;
    defparam add_1471_24.INJECT1_0 = "NO";
    defparam add_1471_24.INJECT1_1 = "NO";
    CCU2D add_38_15 (.A0(\debounce_counters[4] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3072), .COUT(n3073), .S0(n355), 
          .S1(n354));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_15.INIT0 = 16'h5aaa;
    defparam add_38_15.INIT1 = 16'h5aaa;
    defparam add_38_15.INJECT1_0 = "NO";
    defparam add_38_15.INJECT1_1 = "NO";
    CCU2D add_1471_22 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3102), .COUT(n3103));
    defparam add_1471_22.INIT0 = 16'h5555;
    defparam add_1471_22.INIT1 = 16'h5555;
    defparam add_1471_22.INJECT1_0 = "NO";
    defparam add_1471_22.INJECT1_1 = "NO";
    LUT4 i64_4_lut (.A(n3493), .B(next_state_3__N_328[0]), .C(next_state[0]), 
         .D(next_state[3]), .Z(n42_adj_1)) /* synthesis lut_function=(A (B (C (D)+!C !(D))+!B (C+!(D)))+!A (((D)+!C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i64_4_lut.init = 16'hf53f;
    CCU2D add_38_13 (.A0(\debounce_counters[4] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3071), .COUT(n3072), .S0(n357), 
          .S1(n356));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_13.INIT0 = 16'h5aaa;
    defparam add_38_13.INIT1 = 16'h5aaa;
    defparam add_38_13.INJECT1_0 = "NO";
    defparam add_38_13.INJECT1_1 = "NO";
    CCU2D add_1471_20 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3101), .COUT(n3102));
    defparam add_1471_20.INIT0 = 16'h5555;
    defparam add_1471_20.INIT1 = 16'h5555;
    defparam add_1471_20.INJECT1_0 = "NO";
    defparam add_1471_20.INJECT1_1 = "NO";
    LUT4 i18_4_lut (.A(counter[14]), .B(n36_adj_6), .C(n26_adj_11), .D(counter[1]), 
         .Z(n40_adj_8)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i18_4_lut.init = 16'hfffe;
    LUT4 i1667_3_lut (.A(n23_adj_4), .B(n27_adj_2), .C(next_state[3]), 
         .Z(n29_adj_16)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i1667_3_lut.init = 16'hcaca;
    CCU2D add_20_23 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3044), .COUT(n3045), .S0(n135), 
          .S1(n134));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_23.INIT0 = 16'h5aaa;
    defparam add_20_23.INIT1 = 16'h5aaa;
    defparam add_20_23.INJECT1_0 = "NO";
    defparam add_20_23.INJECT1_1 = "NO";
    CCU2D add_11_29 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3031), .COUT(n3032), .S0(n23), 
          .S1(n22));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_29.INIT0 = 16'h5aaa;
    defparam add_11_29.INIT1 = 16'h5aaa;
    defparam add_11_29.INJECT1_0 = "NO";
    defparam add_11_29.INJECT1_1 = "NO";
    LUT4 i30_4_lut_4_lut_then_1_lut (.A(next_state[2]), .Z(n3512)) /* synthesis lut_function=(A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[12:22])
    defparam i30_4_lut_4_lut_then_1_lut.init = 16'haaaa;
    LUT4 i1670_4_lut (.A(next_state[3]), .B(n3504), .C(next_state[2]), 
         .D(n17), .Z(clk_enable_135)) /* synthesis lut_function=(A+!(B+(C (D)))) */ ;
    defparam i1670_4_lut.init = 16'habbb;
    LUT4 i1_2_lut_3_lut_4_lut (.A(next_state[2]), .B(next_state[3]), .C(next_state_3__N_328[0]), 
         .D(n3493), .Z(FlexMIOs53_GPIO_PowerDown_N_475)) /* synthesis lut_function=(!((B+(C+!(D)))+!A)) */ ;
    defparam i1_2_lut_3_lut_4_lut.init = 16'h0200;
    LUT4 i415_2_lut (.A(clk_enable_99), .B(button_inputs_asyn2[3]), .Z(clk_enable_167)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i415_2_lut.init = 16'hdddd;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut (.A(DIGS3C_SlotD_ReqOE_c_1), .B(FP_UsrLED2_c), 
         .Z(DIGS3C_SlotD_SlotOE_c_1)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(128[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i1_2_lut.init = 16'h2222;
    LUT4 i30_4_lut_4_lut_else_1_lut (.A(next_state[2]), .B(next_state[0]), 
         .C(next_state_3__N_328[0]), .D(buttons_debounced_syn[2]), .Z(n3511)) /* synthesis lut_function=(A (B (C (D)))+!A !(B (C)+!B !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[12:22])
    defparam i30_4_lut_4_lut_else_1_lut.init = 16'h9414;
    LUT4 mux_311_i12_4_lut_4_lut (.A(next_state[1]), .B(n1441), .C(n1470), 
         .D(n916), .Z(n1482)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[12:22])
    defparam mux_311_i12_4_lut_4_lut.init = 16'hf5c5;
    FD1P3AX next_state_i3 (.D(next_state_3__N_28[3]), .SP(clk_enable_137), 
            .CK(clk), .Q(next_state[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[2] 310[9])
    defparam next_state_i3.GSR = "ENABLED";
    GSR GSR_INST (.GSR(VCC_net));
    PFUMX i1749 (.BLUT(n3514), .ALUT(n3515), .C0(next_state[1]), .Z(clk_enable_18));
    CCU2D add_38_11 (.A0(\debounce_counters[4] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3070), .COUT(n3071), .S0(n359), 
          .S1(n358));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_11.INIT0 = 16'h5aaa;
    defparam add_38_11.INIT1 = 16'h5aaa;
    defparam add_38_11.INJECT1_0 = "NO";
    defparam add_38_11.INJECT1_1 = "NO";
    LUT4 i12_4_lut (.A(counter[17]), .B(counter[4]), .C(counter[10]), 
         .D(counter[9]), .Z(n34_adj_13)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i12_4_lut.init = 16'hfffe;
    LUT4 i14_4_lut (.A(counter[18]), .B(counter[7]), .C(counter[20]), 
         .D(counter[8]), .Z(n36_adj_6)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i14_4_lut.init = 16'hfffe;
    CCU2D add_38_9 (.A0(\debounce_counters[4] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3069), .COUT(n3070), .S0(n361), 
          .S1(n360));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_9.INIT0 = 16'h5aaa;
    defparam add_38_9.INIT1 = 16'h5aaa;
    defparam add_38_9.INJECT1_0 = "NO";
    defparam add_38_9.INJECT1_1 = "NO";
    CCU2D add_1471_18 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3100), .COUT(n3101));
    defparam add_1471_18.INIT0 = 16'h5555;
    defparam add_1471_18.INIT1 = 16'h5555;
    defparam add_1471_18.INJECT1_0 = "NO";
    defparam add_1471_18.INJECT1_1 = "NO";
    LUT4 i4_2_lut (.A(counter[0]), .B(counter[21]), .Z(n26_adj_11)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i4_2_lut.init = 16'heeee;
    LUT4 i1675_3_lut (.A(n34_adj_9), .B(next_state[3]), .C(n39_adj_12), 
         .Z(clk_enable_65)) /* synthesis lut_function=(!(A+!(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i1675_3_lut.init = 16'h4545;
    LUT4 n1953_bdd_4_lut_1736_4_lut (.A(next_state[1]), .B(next_state[0]), 
         .C(FP_SysLEDg_c), .D(next_state[2]), .Z(n3443)) /* synthesis lut_function=(A (B (D))+!A (B+(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[12:22])
    defparam n1953_bdd_4_lut_1736_4_lut.init = 16'hdc44;
    LUT4 mux_311_i14_4_lut_4_lut (.A(next_state[1]), .B(n1441), .C(n1470), 
         .D(n914), .Z(n1480)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(75[12:22])
    defparam mux_311_i14_4_lut_4_lut.init = 16'hf5c5;
    LUT4 i1_4_lut_adj_6 (.A(next_state[2]), .B(next_state[0]), .C(next_state[1]), 
         .D(n36_adj_10), .Z(n39_adj_12)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i1_4_lut_adj_6.init = 16'heca0;
    CCU2D add_1471_16 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3099), .COUT(n3100));
    defparam add_1471_16.INIT0 = 16'h5555;
    defparam add_1471_16.INIT1 = 16'h5555;
    defparam add_1471_16.INJECT1_0 = "NO";
    defparam add_1471_16.INJECT1_1 = "NO";
    LUT4 n3433_bdd_2_lut (.A(n3433), .B(next_state[2]), .Z(clk_enable_97)) /* synthesis lut_function=(A+(B)) */ ;
    defparam n3433_bdd_2_lut.init = 16'heeee;
    LUT4 i924_2_lut_3_lut (.A(n1441), .B(n1470), .C(n915), .Z(n1481)) /* synthesis lut_function=(A+((C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i924_2_lut_3_lut.init = 16'hfbfb;
    LUT4 i1_4_lut_adj_7 (.A(buttons_debounced_syn[2]), .B(next_state[1]), 
         .C(next_state_3__N_328[0]), .D(next_state[0]), .Z(n17)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;
    defparam i1_4_lut_adj_7.init = 16'heccc;
    LUT4 i979_4_lut_3_lut_4_lut (.A(next_state[0]), .B(next_state[1]), .C(next_state[2]), 
         .D(next_state[3]), .Z(clk_enable_101)) /* synthesis lut_function=(A (C+(D))+!A (B (C+(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i979_4_lut_3_lut_4_lut.init = 16'hfee0;
    PFUMX i1747 (.BLUT(n3511), .ALUT(n3512), .C0(next_state[1]), .Z(n3513));
    LUT4 i414_2_lut (.A(clk_enable_98), .B(button_inputs_asyn2[2]), .Z(clk_enable_96)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i414_2_lut.init = 16'hdddd;
    LUT4 i1_2_lut_rep_51 (.A(next_state[2]), .B(next_state[1]), .Z(n3498)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_rep_51.init = 16'heeee;
    LUT4 DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut (.A(DIGS3C_SlotD_ReqOE_c_2), .B(FP_UsrLED2_c), 
         .Z(DIGS3C_SlotD_SlotOE_c_2)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(128[24:42])
    defparam DIGS3C_SlotD_ReqOE_5__I_0_i2_2_lut.init = 16'h2222;
    CCU2D add_11_11 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3022), .COUT(n3023), .S0(n41), 
          .S1(n40));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_11.INIT0 = 16'h5aaa;
    defparam add_11_11.INIT1 = 16'h5aaa;
    defparam add_11_11.INJECT1_0 = "NO";
    defparam add_11_11.INJECT1_1 = "NO";
    CCU2D add_20_21 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3043), .COUT(n3044), .S0(n137), 
          .S1(n136));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_21.INIT0 = 16'h5aaa;
    defparam add_20_21.INIT1 = 16'h5aaa;
    defparam add_20_21.INJECT1_0 = "NO";
    defparam add_20_21.INJECT1_1 = "NO";
    LUT4 i7_2_lut (.A(counter[13]), .B(counter[16]), .Z(n29_adj_5)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i7_2_lut.init = 16'heeee;
    CCU2D add_38_7 (.A0(\debounce_counters[4] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3068), .COUT(n3069), .S0(n363), 
          .S1(n362));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_7.INIT0 = 16'h5aaa;
    defparam add_38_7.INIT1 = 16'h5aaa;
    defparam add_38_7.INJECT1_0 = "NO";
    defparam add_38_7.INJECT1_1 = "NO";
    CCU2D add_11_27 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3030), .COUT(n3031), .S0(n25), 
          .S1(n24));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_27.INIT0 = 16'h5aaa;
    defparam add_11_27.INIT1 = 16'h5aaa;
    defparam add_11_27.INJECT1_0 = "NO";
    defparam add_11_27.INJECT1_1 = "NO";
    CCU2D add_20_19 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3042), .COUT(n3043), .S0(n139), 
          .S1(n138));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_19.INIT0 = 16'h5aaa;
    defparam add_20_19.INIT1 = 16'h5aaa;
    defparam add_20_19.INJECT1_0 = "NO";
    defparam add_20_19.INJECT1_1 = "NO";
    LUT4 i2_4_lut_adj_8 (.A(next_state[3]), .B(n3325), .C(n4), .D(n25_adj_17), 
         .Z(clk_enable_137)) /* synthesis lut_function=(!(A (B)+!A (B+((D)+!C)))) */ ;
    defparam i2_4_lut_adj_8.init = 16'h2232;
    CCU2D add_1472_26 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3140), .S1(clk_enable_7));
    defparam add_1472_26.INIT0 = 16'hf555;
    defparam add_1472_26.INIT1 = 16'h0000;
    defparam add_1472_26.INJECT1_0 = "NO";
    defparam add_1472_26.INJECT1_1 = "NO";
    CCU2D add_1472_24 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3139), .COUT(n3140));
    defparam add_1472_24.INIT0 = 16'h5555;
    defparam add_1472_24.INIT1 = 16'h5555;
    defparam add_1472_24.INJECT1_0 = "NO";
    defparam add_1472_24.INJECT1_1 = "NO";
    CCU2D add_1472_22 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3138), .COUT(n3139));
    defparam add_1472_22.INIT0 = 16'h5555;
    defparam add_1472_22.INIT1 = 16'h5555;
    defparam add_1472_22.INJECT1_0 = "NO";
    defparam add_1472_22.INJECT1_1 = "NO";
    CCU2D add_1472_20 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3137), .COUT(n3138));
    defparam add_1472_20.INIT0 = 16'h5555;
    defparam add_1472_20.INIT1 = 16'h5555;
    defparam add_1472_20.INJECT1_0 = "NO";
    defparam add_1472_20.INJECT1_1 = "NO";
    CCU2D add_1471_14 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3098), .COUT(n3099));
    defparam add_1471_14.INIT0 = 16'h5555;
    defparam add_1471_14.INIT1 = 16'h5555;
    defparam add_1471_14.INJECT1_0 = "NO";
    defparam add_1471_14.INJECT1_1 = "NO";
    CCU2D add_1471_12 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3097), .COUT(n3098));
    defparam add_1471_12.INIT0 = 16'h5555;
    defparam add_1471_12.INIT1 = 16'h5555;
    defparam add_1471_12.INJECT1_0 = "NO";
    defparam add_1471_12.INJECT1_1 = "NO";
    LUT4 pushed_1__I_0_1_lut (.A(pushed[1]), .Z(pushed_1__N_187)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(156[17] 160[24])
    defparam pushed_1__I_0_1_lut.init = 16'h5555;
    LUT4 i931_2_lut_3_lut (.A(n1441), .B(n1470), .C(n926), .Z(n1492)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(173[9] 309[18])
    defparam i931_2_lut_3_lut.init = 16'h4040;
    PFUMX i1745 (.BLUT(n3508), .ALUT(n3509), .C0(next_state[0]), .Z(next_state_3__N_28[2]));
    CCU2D add_20_17 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3041), .COUT(n3042), .S0(n141), 
          .S1(n140));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_17.INIT0 = 16'h5aaa;
    defparam add_20_17.INIT1 = 16'h5aaa;
    defparam add_20_17.INJECT1_0 = "NO";
    defparam add_20_17.INJECT1_1 = "NO";
    CCU2D add_11_25 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3029), .COUT(n3030), .S0(n27), 
          .S1(n26));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_25.INIT0 = 16'h5aaa;
    defparam add_11_25.INIT1 = 16'h5aaa;
    defparam add_11_25.INJECT1_0 = "NO";
    defparam add_11_25.INJECT1_1 = "NO";
    CCU2D add_1471_10 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3096), .COUT(n3097));
    defparam add_1471_10.INIT0 = 16'h5555;
    defparam add_1471_10.INIT1 = 16'h5555;
    defparam add_1471_10.INJECT1_0 = "NO";
    defparam add_1471_10.INJECT1_1 = "NO";
    CCU2D add_38_5 (.A0(\debounce_counters[4] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3067), .COUT(n3068), .S0(n365), 
          .S1(n364));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_5.INIT0 = 16'h5aaa;
    defparam add_38_5.INIT1 = 16'h5aaa;
    defparam add_38_5.INJECT1_0 = "NO";
    defparam add_38_5.INJECT1_1 = "NO";
    CCU2D add_11_9 (.A0(\debounce_counters[1] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3021), .COUT(n3022), .S0(n43), 
          .S1(n42));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_9.INIT0 = 16'h5aaa;
    defparam add_11_9.INIT1 = 16'h5aaa;
    defparam add_11_9.INJECT1_0 = "NO";
    defparam add_11_9.INJECT1_1 = "NO";
    CCU2D add_38_3 (.A0(\debounce_counters[4] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[4] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3066), .COUT(n3067), .S0(n367), 
          .S1(n366));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_3.INIT0 = 16'h5aaa;
    defparam add_38_3.INIT1 = 16'h5aaa;
    defparam add_38_3.INJECT1_0 = "NO";
    defparam add_38_3.INJECT1_1 = "NO";
    CCU2D add_11_23 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3028), .COUT(n3029), .S0(n29), 
          .S1(n28));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_23.INIT0 = 16'h5aaa;
    defparam add_11_23.INIT1 = 16'h5aaa;
    defparam add_11_23.INJECT1_0 = "NO";
    defparam add_11_23.INJECT1_1 = "NO";
    CCU2D add_11_21 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3027), .COUT(n3028), .S0(n31), 
          .S1(n30));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_21.INIT0 = 16'h5aaa;
    defparam add_11_21.INIT1 = 16'h5aaa;
    defparam add_11_21.INJECT1_0 = "NO";
    defparam add_11_21.INJECT1_1 = "NO";
    CCU2D add_11_19 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3026), .COUT(n3027), .S0(n33), 
          .S1(n32));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_19.INIT0 = 16'h5aaa;
    defparam add_11_19.INIT1 = 16'h5aaa;
    defparam add_11_19.INJECT1_0 = "NO";
    defparam add_11_19.INJECT1_1 = "NO";
    CCU2D add_1471_8 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3095), .COUT(n3096));
    defparam add_1471_8.INIT0 = 16'h5555;
    defparam add_1471_8.INIT1 = 16'h5aaa;
    defparam add_1471_8.INJECT1_0 = "NO";
    defparam add_1471_8.INJECT1_1 = "NO";
    CCU2D add_11_17 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3025), .COUT(n3026), .S0(n35), 
          .S1(n34));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_11_17.INIT0 = 16'h5aaa;
    defparam add_11_17.INIT1 = 16'h5aaa;
    defparam add_11_17.INJECT1_0 = "NO";
    defparam add_11_17.INJECT1_1 = "NO";
    VLO i1 (.Z(GND_net));
    CCU2D add_1472_18 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3136), .COUT(n3137));
    defparam add_1472_18.INIT0 = 16'h5555;
    defparam add_1472_18.INIT1 = 16'h5555;
    defparam add_1472_18.INJECT1_0 = "NO";
    defparam add_1472_18.INJECT1_1 = "NO";
    CCU2D add_38_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[4] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n3066), .S1(n368));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_38_1.INIT0 = 16'hF000;
    defparam add_38_1.INIT1 = 16'h5555;
    defparam add_38_1.INJECT1_0 = "NO";
    defparam add_38_1.INJECT1_1 = "NO";
    CCU2D add_20_15 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3040), .COUT(n3041), .S0(n143), 
          .S1(n142));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_15.INIT0 = 16'h5aaa;
    defparam add_20_15.INIT1 = 16'h5aaa;
    defparam add_20_15.INJECT1_0 = "NO";
    defparam add_20_15.INJECT1_1 = "NO";
    CCU2D add_1471_6 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3094), .COUT(n3095));
    defparam add_1471_6.INIT0 = 16'h5555;
    defparam add_1471_6.INIT1 = 16'h5aaa;
    defparam add_1471_6.INJECT1_0 = "NO";
    defparam add_1471_6.INJECT1_1 = "NO";
    TSALL TSALL_INST (.TSALL(GND_net));
    CCU2D add_1472_16 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3135), .COUT(n3136));
    defparam add_1472_16.INIT0 = 16'h5555;
    defparam add_1472_16.INIT1 = 16'h5555;
    defparam add_1472_16.INJECT1_0 = "NO";
    defparam add_1472_16.INJECT1_1 = "NO";
    CCU2D add_1472_14 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3134), .COUT(n3135));
    defparam add_1472_14.INIT0 = 16'h5555;
    defparam add_1472_14.INIT1 = 16'h5555;
    defparam add_1472_14.INJECT1_0 = "NO";
    defparam add_1472_14.INJECT1_1 = "NO";
    CCU2D add_29_33 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3065), .S0(n231));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_33.INIT0 = 16'h5aaa;
    defparam add_29_33.INIT1 = 16'h0000;
    defparam add_29_33.INJECT1_0 = "NO";
    defparam add_29_33.INJECT1_1 = "NO";
    CCU2D add_1471_4 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3093), .COUT(n3094));
    defparam add_1471_4.INIT0 = 16'h5555;
    defparam add_1471_4.INIT1 = 16'h5555;
    defparam add_1471_4.INJECT1_0 = "NO";
    defparam add_1471_4.INJECT1_1 = "NO";
    PFUMX i1743 (.BLUT(n3505), .ALUT(n3506), .C0(next_state[2]), .Z(next_state_3__N_28[3]));
    CCU2D add_20_13 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3039), .COUT(n3040), .S0(n145), 
          .S1(n144));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_13.INIT0 = 16'h5aaa;
    defparam add_20_13.INIT1 = 16'h5aaa;
    defparam add_20_13.INJECT1_0 = "NO";
    defparam add_20_13.INJECT1_1 = "NO";
    CCU2D add_1472_12 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3133), .COUT(n3134));
    defparam add_1472_12.INIT0 = 16'h5555;
    defparam add_1472_12.INIT1 = 16'h5555;
    defparam add_1472_12.INJECT1_0 = "NO";
    defparam add_1472_12.INJECT1_1 = "NO";
    CCU2D add_1471_2 (.A0(\debounce_counters[2] [7]), .B0(\debounce_counters[2] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[2] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n3093));
    defparam add_1471_2.INIT0 = 16'h1000;
    defparam add_1471_2.INIT1 = 16'h5aaa;
    defparam add_1471_2.INJECT1_0 = "NO";
    defparam add_1471_2.INJECT1_1 = "NO";
    LUT4 m1_lut (.Z(n3579)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    CCU2D add_29_31 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3064), .COUT(n3065), .S0(n233), 
          .S1(n232));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_31.INIT0 = 16'h5aaa;
    defparam add_29_31.INIT1 = 16'h5aaa;
    defparam add_29_31.INJECT1_0 = "NO";
    defparam add_29_31.INJECT1_1 = "NO";
    CCU2D add_1472_10 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3132), .COUT(n3133));
    defparam add_1472_10.INIT0 = 16'h5555;
    defparam add_1472_10.INIT1 = 16'h5555;
    defparam add_1472_10.INJECT1_0 = "NO";
    defparam add_1472_10.INJECT1_1 = "NO";
    PFUMX i1741 (.BLUT(n3502), .ALUT(n3503), .C0(n3493), .Z(n3504));
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    CCU2D add_29_29 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3063), .COUT(n3064), .S0(n235), 
          .S1(n234));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_29.INIT0 = 16'h5aaa;
    defparam add_29_29.INIT1 = 16'h5aaa;
    defparam add_29_29.INJECT1_0 = "NO";
    defparam add_29_29.INJECT1_1 = "NO";
    CCU2D add_1472_8 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3131), .COUT(n3132));
    defparam add_1472_8.INIT0 = 16'h5555;
    defparam add_1472_8.INIT1 = 16'h5aaa;
    defparam add_1472_8.INJECT1_0 = "NO";
    defparam add_1472_8.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i2 (.D(n260), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i3 (.D(n259), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i4 (.D(n258), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i5 (.D(n257), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i6 (.D(n256), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i7 (.D(n255), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i8 (.D(n254), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i9 (.D(n253), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i10 (.D(n252), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i11 (.D(n251), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i12 (.D(n250), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i13 (.D(n249), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i14 (.D(n248), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i15 (.D(n247), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i16 (.D(n246), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i17 (.D(n245), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i18 (.D(n244), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i19 (.D(n243), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i20 (.D(n242), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i21 (.D(n241), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i22 (.D(n240), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i23 (.D(n239), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i24 (.D(n238), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i25 (.D(n237), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i26 (.D(n236), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i27 (.D(n235), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i28 (.D(n234), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i29 (.D(n233), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i30 (.D(n232), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i31 (.D(n231), .SP(clk_enable_167), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(137[9] 162[16])
    defparam debounce_counters_3___i31.GSR = "ENABLED";
    CCU2D add_202_23 (.A0(counter[21]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n3092), 
          .S0(n906));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(290[17:24])
    defparam add_202_23.INIT0 = 16'h5555;
    defparam add_202_23.INIT1 = 16'h0000;
    defparam add_202_23.INJECT1_0 = "NO";
    defparam add_202_23.INJECT1_1 = "NO";
    PFUMX i1700 (.BLUT(n3432), .ALUT(n3431), .C0(next_state[1]), .Z(n3433));
    PFUMX i50 (.BLUT(n20_adj_3), .ALUT(n29_adj_16), .C0(n3327), .Z(next_state_3__N_28[0]));
    CCU2D add_20_11 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3038), .COUT(n3039), .S0(n147), 
          .S1(n146));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_20_11.INIT0 = 16'h5aaa;
    defparam add_20_11.INIT1 = 16'h5aaa;
    defparam add_20_11.INJECT1_0 = "NO";
    defparam add_20_11.INJECT1_1 = "NO";
    CCU2D add_29_27 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3062), .COUT(n3063), .S0(n237), 
          .S1(n236));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_27.INIT0 = 16'h5aaa;
    defparam add_29_27.INIT1 = 16'h5aaa;
    defparam add_29_27.INJECT1_0 = "NO";
    defparam add_29_27.INJECT1_1 = "NO";
    CCU2D add_1472_6 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3130), .COUT(n3131));
    defparam add_1472_6.INIT0 = 16'h5555;
    defparam add_1472_6.INIT1 = 16'h5aaa;
    defparam add_1472_6.INJECT1_0 = "NO";
    defparam add_1472_6.INJECT1_1 = "NO";
    CCU2D add_202_21 (.A0(counter[19]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[20]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3091), .COUT(n3092), .S0(n908), .S1(n907));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(290[17:24])
    defparam add_202_21.INIT0 = 16'h5555;
    defparam add_202_21.INIT1 = 16'h5555;
    defparam add_202_21.INJECT1_0 = "NO";
    defparam add_202_21.INJECT1_1 = "NO";
    CCU2D add_29_25 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3061), .COUT(n3062), .S0(n239), 
          .S1(n238));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_25.INIT0 = 16'h5aaa;
    defparam add_29_25.INIT1 = 16'h5aaa;
    defparam add_29_25.INJECT1_0 = "NO";
    defparam add_29_25.INJECT1_1 = "NO";
    CCU2D add_29_23 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n3060), .COUT(n3061), .S0(n241), 
          .S1(n240));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(147[49:69])
    defparam add_29_23.INIT0 = 16'h5aaa;
    defparam add_29_23.INIT1 = 16'h5aaa;
    defparam add_29_23.INJECT1_0 = "NO";
    defparam add_29_23.INJECT1_1 = "NO";
    CCU2D add_202_19 (.A0(counter[17]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[18]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3090), .COUT(n3091), .S0(n910), .S1(n909));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(290[17:24])
    defparam add_202_19.INIT0 = 16'h5555;
    defparam add_202_19.INIT1 = 16'h5555;
    defparam add_202_19.INJECT1_0 = "NO";
    defparam add_202_19.INJECT1_1 = "NO";
    CCU2D add_202_17 (.A0(counter[15]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[16]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3089), .COUT(n3090), .S0(n912), .S1(n911));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(290[17:24])
    defparam add_202_17.INIT0 = 16'h5555;
    defparam add_202_17.INIT1 = 16'h5555;
    defparam add_202_17.INJECT1_0 = "NO";
    defparam add_202_17.INJECT1_1 = "NO";
    
endmodule
//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

