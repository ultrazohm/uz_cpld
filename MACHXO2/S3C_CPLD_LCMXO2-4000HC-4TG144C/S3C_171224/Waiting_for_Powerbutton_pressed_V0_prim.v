// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Thu Dec 12 10:47:37 2024
//
// Verilog Description of module Waiting_for_Powerbutton_pressed_V0
//

module Waiting_for_Powerbutton_pressed_V0 (SCL, SDA, RST_N, FP_SysLEDg, 
            FP_SysLEDr, FP_SysLEDb, Carrier_PG_3V3, FPIO_FlexMIO52, 
            FPIO_ExternalStop, FPIO_isoCtrlRSTn, SysSW_Pwr_NC, FP_UsrSW1, 
            FP_UsrSW2, FP_UsrSW3, FP_UsrLED1, FP_UsrLED2, FP_UsrLED3, 
            FP_UsrLED4, FP_SysLEDs, Carrier_PG_1V8, SD0_CD, SD1_CD, 
            DIGS3C_Shared_CarrierReady, DIGS3C_Shared_ReqSafeState, DIGS3C_SlotD1_ReqOE, 
            DIGS3C_SlotD1_SlotOK, DIGS3C_SlotD2_ReqOE, DIGS3C_SlotD2_SlotOK, 
            DIGS3C_SlotD3_ReqOE, DIGS3C_SlotD3_SlotOK, DIGS3C_SlotD4_ReqOE, 
            DIGS3C_SlotD4_SlotOK, DIGS3C_SlotD5_ReqOE, DIGS3C_SlotD5_SlotOK, 
            SD_SEL, FlexMIOs52_PCIe, FlexMio61ExternalStop, FlexMIOs53_GPIO_PowerDown, 
            ANL_S3C_SlotOK1, ANL_S3C_SlotOK2, ANL_S3C_SlotOK3, ANL_S3C_CarrierReady, 
            ANL_S3C_P54_Legacy, DIGS3C_SlotD1_SlotOE, DIGS3C_SlotD2_SlotOE, 
            DIGS3C_SlotD3_SlotOE, DIGS3C_SlotD4_SlotOE, DIGS3C_SlotD5_SlotOE, 
            Carrier_PwrOn, PG_VIN, PPn_VIN, PG_Module);   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(7[8:42])
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
    output DIGS3C_Shared_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(37[3:29])
    output DIGS3C_Shared_ReqSafeState;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(38[3:29])
    input DIGS3C_SlotD1_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(40[3:22])
    input DIGS3C_SlotD1_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(41[3:23])
    input DIGS3C_SlotD2_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(43[3:22])
    input DIGS3C_SlotD2_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(44[3:23])
    input DIGS3C_SlotD3_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(46[3:22])
    input DIGS3C_SlotD3_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(47[3:23])
    input DIGS3C_SlotD4_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(49[3:22])
    input DIGS3C_SlotD4_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(50[3:23])
    input DIGS3C_SlotD5_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(52[3:22])
    input DIGS3C_SlotD5_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(53[3:23])
    output SD_SEL;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(56[3:9])
    input FlexMIOs52_PCIe;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(57[3:18])
    output FlexMio61ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(58[3:24])
    output FlexMIOs53_GPIO_PowerDown;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(59[3:28])
    input ANL_S3C_SlotOK1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(64[3:18])
    input ANL_S3C_SlotOK2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(65[3:18])
    input ANL_S3C_SlotOK3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(66[3:18])
    output ANL_S3C_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(67[3:23])
    output ANL_S3C_P54_Legacy;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(68[3:21])
    output DIGS3C_SlotD1_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(70[3:23])
    output DIGS3C_SlotD2_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(71[3:23])
    output DIGS3C_SlotD3_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(72[3:23])
    output DIGS3C_SlotD4_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(73[3:23])
    output DIGS3C_SlotD5_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(74[3:23])
    output Carrier_PwrOn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(78[9:22])
    input PG_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(79[3:9])
    input PPn_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(80[3:10])
    input PG_Module;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(81[3:12])
    
    wire clk /* synthesis is_clock=1, SET_AS_NETWORK=clk */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(87[9:12])
    
    wire GND_net, VCC_net, FP_SysLEDg_c, FP_SysLEDr_c, FP_SysLEDb_c, 
        Carrier_PG_3V3_c, FPIO_FlexMIO52_c_c, FlexMio61ExternalStop_c_c, 
        FPIO_isoCtrlRSTn_c, SysSW_Pwr_NC_c, FP_UsrSW1_c, FP_UsrSW3_c, 
        n27_adj_1, FP_UsrLED2_c, FP_UsrLED3_c, FP_UsrLED4_c, FP_SysLEDs_c, 
        DIGS3C_SlotD1_SlotOK_c, DIGS3C_SlotD2_SlotOK_c, DIGS3C_SlotD3_SlotOK_c, 
        DIGS3C_SlotD4_SlotOK_c, DIGS3C_SlotD5_SlotOK_c, FlexMIOs53_GPIO_PowerDown_c, 
        n1425, Carrier_PwrOn_c;
    wire [21:0]counter;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(88[9:16])
    wire [3:0]next_state;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(94[12:22])
    wire [31:0]\debounce_counters[0] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(101[12:29])
    wire [31:0]\debounce_counters[1] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(101[12:29])
    wire [31:0]\debounce_counters[2] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(101[12:29])
    wire [31:0]\debounce_counters[3] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(101[12:29])
    wire [3:0]button_inputs_asyn1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(103[12:31])
    wire [3:0]button_inputs_asyn2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(104[9:28])
    wire [3:0]pushed;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(105[9:15])
    wire [3:0]buttons_debounced_syn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(106[12:33])
    
    wire n6, n16, n17, n18, n19, n20, n21, n22, n23, n24, 
        n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, 
        n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, 
        n45, n46, n47, n2755, n2778, n2617, n2624, n2623, n2616, 
        n2930, n2615, n2614, n2613, n2612, n2622, n2611, n2610, 
        n2609, n2608, pushed_0__N_182, n122, n123, n124, n125, 
        n126, n127, n128, n129, n130, n131, n132, n133, n134, 
        n135, n136, n137, n138, n139, n140, n141, n142, n143, 
        n144, n145, n146, n147, n148, n149, n150, n151, n152, 
        n153, n2607, n2606, n2605, n2604, n2603, n2602, n2945, 
        n2949, n2601, n2600, n2599, n2598, n2621, n2597, n2596, 
        n2595, n2594, n2593, n2592, n2591, n2590, n2589, n2588, 
        n2587, n2586, n2585, n2584, n2948, n2620, n2619, n2583, 
        pushed_1__N_180, n228, n229, n230, n231, n232, n233, n234, 
        n235, n236, n237, n238, n239, n240, n241, n242, n243, 
        n244, n245, n246, n247, n248, n249, n250, n251, n252, 
        n253, n254, n255, n256, n257, n258, n259, n2946, n2582, 
        n2581, n2580, n2579, n2618, n2578, n2577, n2576, n2575, 
        n2574, n2573, n2572, n2571, n2570, n2569, n2568, n2567, 
        n2566, n2565, n2564, n2563, n2562, n2561, n2560, n2559, 
        n2198, n2558, clk_enable_135, n2943, pushed_2__N_178, n334, 
        n335, n336, n337, n338, n339, n340, n341, n342, n343, 
        n344, n345, n346, n347, n348, n349, n350, n351, n352, 
        n353, n354, n355, n356, n357, n358, n359, n360, n361, 
        n362, n363, n364, n365, n2941, n38_adj_2, n2940, pushed_3__N_176, 
        n2557, n36_adj_3, n34_adj_4, n4, n1385, n1384, n1383, 
        n1382, n1381, n1380, n1379, n1378, n1377, n1376, n1375, 
        n2556, n2938, n2555, n2554, n2553, clk_enable_9, n2552, 
        n2551, n2550, n1374, n1373, n1372, n1371, n1370, n1369, 
        n1368, n1367, n1366, n1365, n1364, n1362, n2549, n806, 
        n807, n808, n809, n810, n811, n812, n813, n814, n815, 
        n816, n817, n818, n819, n820, n821, n822, n823, n824, 
        n825, n826, n827, n1334, n2548, n2547, n2546;
    wire [3:0]next_state_3__N_319;
    
    wire n2545, n2907, FlexMIOs53_GPIO_PowerDown_N_445, FP_SysLEDr_N_428, 
        FP_SysLEDb_N_429, FP_SysLEDg_N_427;
    wire [3:0]next_state_3__N_23;
    
    wire Carrier_PG_3V3_N_430, FPIO_isoCtrlRSTn_N_435, n14, n26_adj_5, 
        clk_enable_132, n2640, n1753, n1772, n2639, Carrier_PG_1V8_N_453, 
        Carrier_PG_1V8_N_457, Carrier_PG_1V8_N_444, n2544, n2937, n2638, 
        n1421, n2637, n1419, n2636, n2635, n2543, n2542, n2634, 
        n2936, n2541, n2910, n2909, n2540, n2539, n2633, n2632, 
        n2631, n2538, n2537, n2630, n2629, n1761, n2934, clk_enable_8, 
        n2536, clk_enable_166, clk_enable_23, n2918, n2933, n2535, 
        n2932, n32_adj_6, n2931, n42_adj_7, n2534, clk_enable_97, 
        n2533, n2532, n2531, n2530, n2529, n2528, clk_enable_25, 
        n2921, n30_adj_8, n2628, n2942, clk_enable_21, clk_enable_134, 
        n2527, n2627, n2939, n2526, clk_enable_133, n2626, clk_enable_20, 
        clk_enable_65, clk_enable_98, n2525, n2928, n2913, n40_adj_9, 
        n1865, n2524, n2523, n2522, n2521, n29_adj_10, n2520, 
        n2927, n2925, n2924, n2519, n2922, n2518, n2625, clk_enable_44, 
        clk_enable_165, clk_enable_130, clk_enable_96, n2998, clk_enable_99;
    
    VHI i2 (.Z(VCC_net));
    FD1P3IX debounce_counters_3___i20 (.D(n345), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i0 (.D(n365), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i0.GSR = "ENABLED";
    FD1P3IX counter__i0 (.D(n1385), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i0.GSR = "ENABLED";
    CCU2D add_184_11 (.A0(counter[9]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[10]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2586), .COUT(n2587), .S0(n818), .S1(n817));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(300[17:24])
    defparam add_184_11.INIT0 = 16'h5555;
    defparam add_184_11.INIT1 = 16'h5555;
    defparam add_184_11.INJECT1_0 = "NO";
    defparam add_184_11.INJECT1_1 = "NO";
    CCU2D add_184_9 (.A0(counter[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[8]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2585), .COUT(n2586), .S0(n820), .S1(n819));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(300[17:24])
    defparam add_184_9.INIT0 = 16'h5555;
    defparam add_184_9.INIT1 = 16'h5555;
    defparam add_184_9.INJECT1_0 = "NO";
    defparam add_184_9.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i19 (.D(n346), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i19.GSR = "ENABLED";
    CCU2D add_22_19 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2542), .COUT(n2543), .S0(n136), 
          .S1(n135));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_19.INIT0 = 16'h5aaa;
    defparam add_22_19.INIT1 = 16'h5aaa;
    defparam add_22_19.INJECT1_0 = "NO";
    defparam add_22_19.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i18 (.D(n347), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i0 (.D(n47), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i0.GSR = "ENABLED";
    LUT4 i1_2_lut_3_lut_3_lut (.A(next_state[2]), .B(next_state[3]), .C(next_state[0]), 
         .Z(Carrier_PG_3V3_N_430)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;
    defparam i1_2_lut_3_lut_3_lut.init = 16'h1010;
    FD1P3IX debounce_counters_3___i17 (.D(n348), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i17.GSR = "ENABLED";
    CCU2D add_22_17 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2541), .COUT(n2542), .S0(n138), 
          .S1(n137));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_17.INIT0 = 16'h5aaa;
    defparam add_22_17.INIT1 = 16'h5aaa;
    defparam add_22_17.INJECT1_0 = "NO";
    defparam add_22_17.INJECT1_1 = "NO";
    PFUMX i298 (.BLUT(n1421), .ALUT(n1425), .C0(next_state[1]), .Z(n1772));
    FD1S3AY button_inputs_asyn2_i0 (.D(button_inputs_asyn1[0]), .CK(clk), 
            .Q(button_inputs_asyn2[0])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam button_inputs_asyn2_i0.GSR = "ENABLED";
    LUT4 i960_2_lut_3_lut_4_lut (.A(n1334), .B(next_state[3]), .C(n1772), 
         .D(n811), .Z(n1369)) /* synthesis lut_function=(A+(B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i960_2_lut_3_lut_4_lut.init = 16'hffef;
    CCU2D add_22_15 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2540), .COUT(n2541), .S0(n140), 
          .S1(n139));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_15.INIT0 = 16'h5aaa;
    defparam add_22_15.INIT1 = 16'h5aaa;
    defparam add_22_15.INJECT1_0 = "NO";
    defparam add_22_15.INJECT1_1 = "NO";
    FD1P3IX pushed_i0 (.D(n2998), .SP(clk_enable_8), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(pushed[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam pushed_i0.GSR = "ENABLED";
    LUT4 i961_2_lut_3_lut_4_lut (.A(n1334), .B(next_state[3]), .C(n1772), 
         .D(n815), .Z(n1373)) /* synthesis lut_function=(A+(B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i961_2_lut_3_lut_4_lut.init = 16'hffef;
    FD1S3AY buttons_debounced_syn_i1 (.D(pushed_0__N_182), .CK(clk), .Q(next_state_3__N_319[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam buttons_debounced_syn_i1.GSR = "ENABLED";
    FD1P3AX FlexMIOs53_GPIO_PowerDown_150 (.D(FlexMIOs53_GPIO_PowerDown_N_445), 
            .SP(clk_enable_9), .CK(clk), .Q(FlexMIOs53_GPIO_PowerDown_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam FlexMIOs53_GPIO_PowerDown_150.GSR = "ENABLED";
    CCU2D add_1042_2 (.A0(\debounce_counters[3] [7]), .B0(\debounce_counters[3] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[3] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n2617));
    defparam add_1042_2.INIT0 = 16'h1000;
    defparam add_1042_2.INIT1 = 16'h5aaa;
    defparam add_1042_2.INJECT1_0 = "NO";
    defparam add_1042_2.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i16 (.D(n349), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i16.GSR = "ENABLED";
    CCU2D add_1043_26 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2616), .S1(clk_enable_98));
    defparam add_1043_26.INIT0 = 16'hf555;
    defparam add_1043_26.INIT1 = 16'h0000;
    defparam add_1043_26.INJECT1_0 = "NO";
    defparam add_1043_26.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_1___i0 (.D(n153), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i0.GSR = "ENABLED";
    CCU2D add_184_7 (.A0(counter[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2584), .COUT(n2585), .S0(n822), .S1(n821));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(300[17:24])
    defparam add_184_7.INIT0 = 16'h5555;
    defparam add_184_7.INIT1 = 16'h5555;
    defparam add_184_7.INJECT1_0 = "NO";
    defparam add_184_7.INJECT1_1 = "NO";
    LUT4 i963_2_lut_3_lut_4_lut (.A(n1334), .B(next_state[3]), .C(n1772), 
         .D(n820), .Z(n1378)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i963_2_lut_3_lut_4_lut.init = 16'h1000;
    LUT4 mux_277_i18_4_lut_4_lut (.A(next_state[1]), .B(n1334), .C(n1362), 
         .D(n810), .Z(n1368)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_277_i18_4_lut_4_lut.init = 16'hf5c5;
    FD1P3IX debounce_counters_3___i15 (.D(n350), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i15.GSR = "ENABLED";
    CCU2D add_31_19 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2558), .COUT(n2559), .S0(n242), 
          .S1(n241));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_19.INIT0 = 16'h5aaa;
    defparam add_31_19.INIT1 = 16'h5aaa;
    defparam add_31_19.INJECT1_0 = "NO";
    defparam add_31_19.INJECT1_1 = "NO";
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk)) /* synthesis NOM_FREQ="7", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "7";
    FD1P3IX debounce_counters_3___i14 (.D(n351), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i13 (.D(n352), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i13.GSR = "ENABLED";
    CCU2D add_184_5 (.A0(counter[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2583), .COUT(n2584), .S0(n824), .S1(n823));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(300[17:24])
    defparam add_184_5.INIT0 = 16'h5555;
    defparam add_184_5.INIT1 = 16'h5555;
    defparam add_184_5.INJECT1_0 = "NO";
    defparam add_184_5.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i12 (.D(n353), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i12.GSR = "ENABLED";
    CCU2D add_13_7 (.A0(\debounce_counters[0] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2520), .COUT(n2521), .S0(n42), 
          .S1(n41));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_7.INIT0 = 16'h5aaa;
    defparam add_13_7.INIT1 = 16'h5aaa;
    defparam add_13_7.INJECT1_0 = "NO";
    defparam add_13_7.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i11 (.D(n354), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i10 (.D(n355), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i9 (.D(n356), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i9.GSR = "ENABLED";
    FD1P3AX FP_SysLEDr_151 (.D(FP_SysLEDr_N_428), .SP(clk_enable_20), .CK(clk), 
            .Q(FP_SysLEDr_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam FP_SysLEDr_151.GSR = "ENABLED";
    FD1P3AX FP_SysLEDb_152 (.D(FP_SysLEDb_N_429), .SP(clk_enable_20), .CK(clk), 
            .Q(FP_SysLEDb_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam FP_SysLEDb_152.GSR = "ENABLED";
    FD1P3AX FP_SysLEDg_153 (.D(FP_SysLEDg_N_427), .SP(clk_enable_21), .CK(clk), 
            .Q(FP_SysLEDg_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam FP_SysLEDg_153.GSR = "ENABLED";
    FD1P3AX Carrier_PwrOn_155 (.D(Carrier_PG_3V3_N_430), .SP(clk_enable_23), 
            .CK(clk), .Q(Carrier_PwrOn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam Carrier_PwrOn_155.GSR = "ENABLED";
    FD1P3AX Carrier_PG_3V3_156 (.D(Carrier_PG_3V3_N_430), .SP(clk_enable_23), 
            .CK(clk), .Q(Carrier_PG_3V3_c)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam Carrier_PG_3V3_156.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i8 (.D(n357), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i8.GSR = "ENABLED";
    FD1P3IX FP_SysLEDs_160 (.D(n2918), .SP(clk_enable_25), .CD(next_state[3]), 
            .CK(clk), .Q(FP_SysLEDs_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam FP_SysLEDs_160.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn1_i0 (.D(SysSW_Pwr_NC_c), .CK(clk), .Q(button_inputs_asyn1[0])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam button_inputs_asyn1_i0.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i7 (.D(n358), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i7.GSR = "ENABLED";
    CCU2D add_1043_24 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2615), .COUT(n2616));
    defparam add_1043_24.INIT0 = 16'h5555;
    defparam add_1043_24.INIT1 = 16'h5555;
    defparam add_1043_24.INJECT1_0 = "NO";
    defparam add_1043_24.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i22 (.D(n343), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i6 (.D(n359), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i28 (.D(n337), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i28.GSR = "ENABLED";
    CCU2D add_184_3 (.A0(counter[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2582), .COUT(n2583), .S0(n826), .S1(n825));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(300[17:24])
    defparam add_184_3.INIT0 = 16'h5555;
    defparam add_184_3.INIT1 = 16'h5555;
    defparam add_184_3.INJECT1_0 = "NO";
    defparam add_184_3.INJECT1_1 = "NO";
    CCU2D add_22_13 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2539), .COUT(n2540), .S0(n142), 
          .S1(n141));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_13.INIT0 = 16'h5aaa;
    defparam add_22_13.INIT1 = 16'h5aaa;
    defparam add_22_13.INJECT1_0 = "NO";
    defparam add_22_13.INJECT1_1 = "NO";
    CCU2D add_13_5 (.A0(\debounce_counters[0] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2519), .COUT(n2520), .S0(n44), 
          .S1(n43));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_5.INIT0 = 16'h5aaa;
    defparam add_13_5.INIT1 = 16'h5aaa;
    defparam add_13_5.INJECT1_0 = "NO";
    defparam add_13_5.INJECT1_1 = "NO";
    CCU2D add_31_17 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2557), .COUT(n2558), .S0(n244), 
          .S1(n243));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_17.INIT0 = 16'h5aaa;
    defparam add_31_17.INIT1 = 16'h5aaa;
    defparam add_31_17.INJECT1_0 = "NO";
    defparam add_31_17.INJECT1_1 = "NO";
    CCU2D add_13_3 (.A0(\debounce_counters[0] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2518), .COUT(n2519), .S0(n46), 
          .S1(n45));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_3.INIT0 = 16'h5aaa;
    defparam add_13_3.INIT1 = 16'h5aaa;
    defparam add_13_3.INJECT1_0 = "NO";
    defparam add_13_3.INJECT1_1 = "NO";
    CCU2D add_13_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[0] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n2518), .S1(n47));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_1.INIT0 = 16'hF000;
    defparam add_13_1.INIT1 = 16'h5555;
    defparam add_13_1.INJECT1_0 = "NO";
    defparam add_13_1.INJECT1_1 = "NO";
    CCU2D add_184_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n2582), .S1(n827));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(300[17:24])
    defparam add_184_1.INIT0 = 16'hF000;
    defparam add_184_1.INIT1 = 16'h5555;
    defparam add_184_1.INJECT1_0 = "NO";
    defparam add_184_1.INJECT1_1 = "NO";
    CCU2D add_31_15 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2556), .COUT(n2557), .S0(n246), 
          .S1(n245));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_15.INIT0 = 16'h5aaa;
    defparam add_31_15.INIT1 = 16'h5aaa;
    defparam add_31_15.INJECT1_0 = "NO";
    defparam add_31_15.INJECT1_1 = "NO";
    CCU2D add_40_33 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2581), .S0(n334));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_33.INIT0 = 16'h5aaa;
    defparam add_40_33.INIT1 = 16'h0000;
    defparam add_40_33.INJECT1_0 = "NO";
    defparam add_40_33.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i5 (.D(n360), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i4 (.D(n361), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i27 (.D(n338), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i27.GSR = "ENABLED";
    LUT4 i983_3_lut_4_lut (.A(n806), .B(next_state[3]), .C(n1772), .D(n1334), 
         .Z(n1364)) /* synthesis lut_function=(!(A (B+!(C))+!A (B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i983_3_lut_4_lut.init = 16'h3020;
    FD1P3IX debounce_counters_3___i26 (.D(n339), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i26.GSR = "ENABLED";
    CCU2D add_22_11 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2538), .COUT(n2539), .S0(n144), 
          .S1(n143));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_11.INIT0 = 16'h5aaa;
    defparam add_22_11.INIT1 = 16'h5aaa;
    defparam add_22_11.INJECT1_0 = "NO";
    defparam add_22_11.INJECT1_1 = "NO";
    OB FP_SysLEDg_pad (.I(FP_SysLEDg_c), .O(FP_SysLEDg));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(16[3:13])
    FD1P3IX debounce_counters_3___i25 (.D(n340), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i25.GSR = "ENABLED";
    LUT4 i2_3_lut_4_lut (.A(n2909), .B(next_state_3__N_319[2]), .C(next_state[2]), 
         .D(next_state[3]), .Z(FlexMIOs53_GPIO_PowerDown_N_445)) /* synthesis lut_function=(!((B+((D)+!C))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam i2_3_lut_4_lut.init = 16'h0020;
    LUT4 i964_2_lut_3_lut_4_lut (.A(n1334), .B(next_state[3]), .C(n1772), 
         .D(n822), .Z(n1380)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i964_2_lut_3_lut_4_lut.init = 16'h1000;
    LUT4 i2_3_lut_4_lut_4_lut (.A(next_state[2]), .B(next_state[1]), .C(next_state[0]), 
         .D(next_state[3]), .Z(n1753)) /* synthesis lut_function=(A (D)+!A (B (D)+!B (C (D)))) */ ;
    defparam i2_3_lut_4_lut_4_lut.init = 16'hfe00;
    LUT4 mux_277_i20_4_lut_4_lut (.A(next_state[1]), .B(n1334), .C(n1362), 
         .D(n808), .Z(n1366)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_277_i20_4_lut_4_lut.init = 16'hf5c5;
    CCU2D add_40_31 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2580), .COUT(n2581), .S0(n336), 
          .S1(n335));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_31.INIT0 = 16'h5aaa;
    defparam add_40_31.INIT1 = 16'h5aaa;
    defparam add_40_31.INJECT1_0 = "NO";
    defparam add_40_31.INJECT1_1 = "NO";
    CCU2D add_1043_22 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2614), .COUT(n2615));
    defparam add_1043_22.INIT0 = 16'h5555;
    defparam add_1043_22.INIT1 = 16'h5555;
    defparam add_1043_22.INJECT1_0 = "NO";
    defparam add_1043_22.INJECT1_1 = "NO";
    CCU2D add_1043_20 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2613), .COUT(n2614));
    defparam add_1043_20.INIT0 = 16'h5555;
    defparam add_1043_20.INIT1 = 16'h5555;
    defparam add_1043_20.INJECT1_0 = "NO";
    defparam add_1043_20.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i24 (.D(n341), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i23 (.D(n342), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i3 (.D(n362), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i3.GSR = "ENABLED";
    IB FPIO_FlexMIO52_c_pad (.I(FlexMIOs52_PCIe), .O(FPIO_FlexMIO52_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(57[3:18])
    IB DIGS3C_SlotD5_SlotOK_pad (.I(DIGS3C_SlotD5_SlotOK), .O(DIGS3C_SlotD5_SlotOK_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(53[3:23])
    IB DIGS3C_SlotD4_SlotOK_pad (.I(DIGS3C_SlotD4_SlotOK), .O(DIGS3C_SlotD4_SlotOK_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(50[3:23])
    IB DIGS3C_SlotD3_SlotOK_pad (.I(DIGS3C_SlotD3_SlotOK), .O(DIGS3C_SlotD3_SlotOK_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(47[3:23])
    IB DIGS3C_SlotD2_SlotOK_pad (.I(DIGS3C_SlotD2_SlotOK), .O(DIGS3C_SlotD2_SlotOK_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(44[3:23])
    IB DIGS3C_SlotD1_SlotOK_pad (.I(DIGS3C_SlotD1_SlotOK), .O(DIGS3C_SlotD1_SlotOK_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(41[3:23])
    IB FP_UsrSW3_pad (.I(FP_UsrSW3), .O(FP_UsrSW3_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(27[3:12])
    IB FP_UsrSW1_pad (.I(FP_UsrSW1), .O(FP_UsrSW1_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(25[3:12])
    IB SysSW_Pwr_NC_pad (.I(SysSW_Pwr_NC), .O(SysSW_Pwr_NC_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(24[3:15])
    IB FlexMio61ExternalStop_c_pad (.I(FPIO_ExternalStop), .O(FlexMio61ExternalStop_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(21[3:20])
    OB Carrier_PwrOn_pad (.I(Carrier_PwrOn_c), .O(Carrier_PwrOn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(78[9:22])
    OB DIGS3C_SlotD5_SlotOE_pad (.I(GND_net), .O(DIGS3C_SlotD5_SlotOE));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(74[3:23])
    OB DIGS3C_SlotD4_SlotOE_pad (.I(GND_net), .O(DIGS3C_SlotD4_SlotOE));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(73[3:23])
    OB DIGS3C_SlotD3_SlotOE_pad (.I(GND_net), .O(DIGS3C_SlotD3_SlotOE));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(72[3:23])
    OB DIGS3C_SlotD2_SlotOE_pad (.I(GND_net), .O(DIGS3C_SlotD2_SlotOE));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(71[3:23])
    OB DIGS3C_SlotD1_SlotOE_pad (.I(GND_net), .O(DIGS3C_SlotD1_SlotOE));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(70[3:23])
    OB ANL_S3C_P54_Legacy_pad (.I(GND_net), .O(ANL_S3C_P54_Legacy));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(68[3:21])
    OB ANL_S3C_CarrierReady_pad (.I(GND_net), .O(ANL_S3C_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(67[3:23])
    OB FlexMIOs53_GPIO_PowerDown_pad (.I(FlexMIOs53_GPIO_PowerDown_c), .O(FlexMIOs53_GPIO_PowerDown));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(59[3:28])
    OB FlexMio61ExternalStop_pad (.I(FlexMio61ExternalStop_c_c), .O(FlexMio61ExternalStop));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(58[3:24])
    OB SD_SEL_pad (.I(GND_net), .O(SD_SEL));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(56[3:9])
    OB DIGS3C_Shared_ReqSafeState_pad (.I(GND_net), .O(DIGS3C_Shared_ReqSafeState));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(38[3:29])
    OB DIGS3C_Shared_CarrierReady_pad (.I(GND_net), .O(DIGS3C_Shared_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(37[3:29])
    OBZ n1760_pad (.I(GND_net), .T(n1761), .O(Carrier_PG_1V8));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(212[1] 327[13])
    LUT4 i982_3_lut_4_lut (.A(n812), .B(next_state[3]), .C(n1772), .D(n1334), 
         .Z(n1370)) /* synthesis lut_function=(A (B+!(C (D)))+!A (B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i982_3_lut_4_lut.init = 16'hcfef;
    OB FP_SysLEDs_pad (.I(FP_SysLEDs_c), .O(FP_SysLEDs));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(33[3:13])
    OB FP_UsrLED4_pad (.I(FP_UsrLED4_c), .O(FP_UsrLED4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(32[3:13])
    OB FP_UsrLED3_pad (.I(FP_UsrLED3_c), .O(FP_UsrLED3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(31[3:13])
    OB FP_UsrLED2_pad (.I(FP_UsrLED2_c), .O(FP_UsrLED2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(30[3:13])
    OB FP_UsrLED1_pad (.I(next_state_3__N_319[2]), .O(FP_UsrLED1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(29[3:13])
    OB FPIO_isoCtrlRSTn_pad (.I(FPIO_isoCtrlRSTn_c), .O(FPIO_isoCtrlRSTn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(22[3:19])
    OB FPIO_FlexMIO52_pad (.I(FPIO_FlexMIO52_c_c), .O(FPIO_FlexMIO52));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(20[3:17])
    OB Carrier_PG_3V3_pad (.I(Carrier_PG_3V3_c), .O(Carrier_PG_3V3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(19[3:17])
    OB FP_SysLEDb_pad (.I(FP_SysLEDb_c), .O(FP_SysLEDb));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(18[3:13])
    OB FP_SysLEDr_pad (.I(FP_SysLEDr_c), .O(FP_SysLEDr));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(17[3:13])
    CCU2D add_1043_18 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2612), .COUT(n2613));
    defparam add_1043_18.INIT0 = 16'h5555;
    defparam add_1043_18.INIT1 = 16'h5555;
    defparam add_1043_18.INJECT1_0 = "NO";
    defparam add_1043_18.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i2 (.D(n363), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i1 (.D(n364), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i1.GSR = "ENABLED";
    FD1P3AX i138_161 (.D(Carrier_PG_1V8_N_457), .SP(Carrier_PG_1V8_N_453), 
            .CK(clk), .Q(Carrier_PG_1V8_N_444));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam i138_161.GSR = "ENABLED";
    LUT4 i377_2_lut (.A(clk_enable_97), .B(button_inputs_asyn2[1]), .Z(clk_enable_130)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i377_2_lut.init = 16'hdddd;
    CCU2D add_22_9 (.A0(\debounce_counters[1] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2537), .COUT(n2538), .S0(n146), 
          .S1(n145));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_9.INIT0 = 16'h5aaa;
    defparam add_22_9.INIT1 = 16'h5aaa;
    defparam add_22_9.INJECT1_0 = "NO";
    defparam add_22_9.INJECT1_1 = "NO";
    LUT4 i981_3_lut_4_lut (.A(n813), .B(next_state[3]), .C(n1772), .D(n1334), 
         .Z(n1371)) /* synthesis lut_function=(!(A (B+!(C))+!A (B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i981_3_lut_4_lut.init = 16'h3020;
    LUT4 i980_3_lut_4_lut (.A(n817), .B(next_state[3]), .C(n1772), .D(n1334), 
         .Z(n1375)) /* synthesis lut_function=(A (B+!(C (D)))+!A (B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i980_3_lut_4_lut.init = 16'hcfef;
    FD1P3IX debounce_counters_2___i0 (.D(n259), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i0.GSR = "ENABLED";
    LUT4 mux_277_i7_4_lut (.A(next_state[1]), .B(n821), .C(n1362), .D(n1334), 
         .Z(n1379)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam mux_277_i7_4_lut.init = 16'h0aca;
    LUT4 i28_4_lut_4_lut (.A(next_state[2]), .B(next_state[3]), .C(n14), 
         .D(n1865), .Z(clk_enable_132)) /* synthesis lut_function=(!(A (C)+!A (B (C)+!B (D)))) */ ;
    defparam i28_4_lut_4_lut.init = 16'h0e1f;
    CCU2D add_22_7 (.A0(\debounce_counters[1] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2536), .COUT(n2537), .S0(n148), 
          .S1(n147));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_7.INIT0 = 16'h5aaa;
    defparam add_22_7.INIT1 = 16'h5aaa;
    defparam add_22_7.INJECT1_0 = "NO";
    defparam add_22_7.INJECT1_1 = "NO";
    LUT4 i378_2_lut (.A(clk_enable_98), .B(button_inputs_asyn2[2]), .Z(clk_enable_165)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i378_2_lut.init = 16'hdddd;
    FD1P3IX debounce_counters_3___i29 (.D(n336), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i21 (.D(n344), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i21.GSR = "ENABLED";
    LUT4 i974_2_lut_3_lut_4_lut (.A(n1334), .B(next_state[3]), .C(n1772), 
         .D(n826), .Z(n1384)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i974_2_lut_3_lut_4_lut.init = 16'h1000;
    FD1P3IX debounce_counters_3___i30 (.D(n335), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i31 (.D(n334), .SP(clk_enable_44), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(\debounce_counters[3] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_3___i31.GSR = "ENABLED";
    FD1P3IX counter__i1 (.D(n1384), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i1.GSR = "ENABLED";
    FD1P3IX counter__i2 (.D(n1383), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i2.GSR = "ENABLED";
    FD1P3IX counter__i3 (.D(n1382), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i3.GSR = "ENABLED";
    FD1P3IX counter__i4 (.D(n1381), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i4.GSR = "ENABLED";
    FD1P3IX counter__i5 (.D(n1380), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i5.GSR = "ENABLED";
    FD1P3IX counter__i6 (.D(n1379), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i6.GSR = "ENABLED";
    FD1P3IX counter__i7 (.D(n1378), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i7.GSR = "ENABLED";
    FD1P3IX counter__i8 (.D(n1377), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i8.GSR = "ENABLED";
    FD1P3IX counter__i9 (.D(n1376), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i9.GSR = "ENABLED";
    FD1P3IX counter__i10 (.D(n1375), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i10.GSR = "ENABLED";
    FD1P3IX counter__i11 (.D(n1374), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i11.GSR = "ENABLED";
    FD1P3IX counter__i12 (.D(n1373), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i12.GSR = "ENABLED";
    FD1P3IX counter__i13 (.D(n1372), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i13.GSR = "ENABLED";
    FD1P3IX counter__i14 (.D(n1371), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i14.GSR = "ENABLED";
    FD1P3IX counter__i15 (.D(n1370), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i15.GSR = "ENABLED";
    FD1P3IX counter__i16 (.D(n1369), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i16.GSR = "ENABLED";
    FD1P3IX counter__i17 (.D(n1368), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i17.GSR = "ENABLED";
    FD1P3IX counter__i18 (.D(n1367), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i18.GSR = "ENABLED";
    FD1P3IX counter__i19 (.D(n1366), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i19.GSR = "ENABLED";
    FD1P3IX counter__i20 (.D(n1365), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i20.GSR = "ENABLED";
    FD1P3IX counter__i21 (.D(n1364), .SP(clk_enable_65), .CD(n1753), .CK(clk), 
            .Q(counter[21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam counter__i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i1 (.D(n46), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i2 (.D(n45), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i3 (.D(n44), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i4 (.D(n43), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i5 (.D(n42), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i6 (.D(n41), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i7 (.D(n40), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i8 (.D(n39), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i9 (.D(n38), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i10 (.D(n37), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i11 (.D(n36), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i12 (.D(n35), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i13 (.D(n34), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i14 (.D(n33), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i15 (.D(n32), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i16 (.D(n31), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i17 (.D(n30), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i18 (.D(n29), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i19 (.D(n28), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i20 (.D(n27), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i21 (.D(n26), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i22 (.D(n25), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i23 (.D(n24), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i24 (.D(n23), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i25 (.D(n22), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i26 (.D(n21), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i27 (.D(n20), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i28 (.D(n19), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i29 (.D(n18), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i30 (.D(n17), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i31 (.D(n16), .SP(clk_enable_96), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_0___i31.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn2_i1 (.D(button_inputs_asyn1[1]), .CK(clk), 
            .Q(button_inputs_asyn2[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam button_inputs_asyn2_i1.GSR = "ENABLED";
    LUT4 i970_2_lut_3_lut_4_lut (.A(n1334), .B(next_state[3]), .C(n1772), 
         .D(n825), .Z(n1383)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i970_2_lut_3_lut_4_lut.init = 16'h1000;
    CCU2D add_1043_16 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2611), .COUT(n2612));
    defparam add_1043_16.INIT0 = 16'h5555;
    defparam add_1043_16.INIT1 = 16'h5555;
    defparam add_1043_16.INJECT1_0 = "NO";
    defparam add_1043_16.INJECT1_1 = "NO";
    FD1S3AY button_inputs_asyn2_i2 (.D(button_inputs_asyn1[2]), .CK(clk), 
            .Q(button_inputs_asyn2[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam button_inputs_asyn2_i2.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn2_i3 (.D(button_inputs_asyn1[3]), .CK(clk), 
            .Q(button_inputs_asyn2[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam button_inputs_asyn2_i3.GSR = "ENABLED";
    FD1P3IX pushed_i1 (.D(n2998), .SP(clk_enable_97), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(pushed[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam pushed_i1.GSR = "ENABLED";
    FD1P3IX pushed_i2 (.D(n2998), .SP(clk_enable_98), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(pushed[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam pushed_i2.GSR = "ENABLED";
    FD1P3IX pushed_i3 (.D(n2998), .SP(clk_enable_99), .CD(button_inputs_asyn2[3]), 
            .CK(clk), .Q(pushed[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam pushed_i3.GSR = "ENABLED";
    FD1S3AY buttons_debounced_syn_i2 (.D(pushed_1__N_180), .CK(clk), .Q(buttons_debounced_syn[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam buttons_debounced_syn_i2.GSR = "ENABLED";
    FD1S3AY buttons_debounced_syn_i3 (.D(pushed_2__N_178), .CK(clk), .Q(FP_UsrLED3_c)) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam buttons_debounced_syn_i3.GSR = "ENABLED";
    FD1S3AY buttons_debounced_syn_i4 (.D(pushed_3__N_176), .CK(clk), .Q(FP_UsrLED4_c)) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam buttons_debounced_syn_i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i1 (.D(n152), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i1.GSR = "ENABLED";
    CCU2D add_1043_14 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2610), .COUT(n2611));
    defparam add_1043_14.INIT0 = 16'h5555;
    defparam add_1043_14.INIT1 = 16'h5555;
    defparam add_1043_14.INJECT1_0 = "NO";
    defparam add_1043_14.INJECT1_1 = "NO";
    CCU2D add_22_5 (.A0(\debounce_counters[1] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2535), .COUT(n2536), .S0(n150), 
          .S1(n149));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_5.INIT0 = 16'h5aaa;
    defparam add_22_5.INIT1 = 16'h5aaa;
    defparam add_22_5.INJECT1_0 = "NO";
    defparam add_22_5.INJECT1_1 = "NO";
    CCU2D add_31_13 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2555), .COUT(n2556), .S0(n248), 
          .S1(n247));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_13.INIT0 = 16'h5aaa;
    defparam add_31_13.INIT1 = 16'h5aaa;
    defparam add_31_13.INJECT1_0 = "NO";
    defparam add_31_13.INJECT1_1 = "NO";
    LUT4 next_state_0__bdd_4_lut (.A(next_state[0]), .B(next_state[3]), 
         .C(next_state[1]), .D(next_state[2]), .Z(FP_SysLEDg_N_427)) /* synthesis lut_function=(!(A (B+!((D)+!C))+!A (B (C+(D))+!B (C+!(D))))) */ ;
    defparam next_state_0__bdd_4_lut.init = 16'h2306;
    CCU2D add_22_3 (.A0(\debounce_counters[1] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2534), .COUT(n2535), .S0(n152), 
          .S1(n151));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_3.INIT0 = 16'h5aaa;
    defparam add_22_3.INIT1 = 16'h5aaa;
    defparam add_22_3.INJECT1_0 = "NO";
    defparam add_22_3.INJECT1_1 = "NO";
    CCU2D add_40_29 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2579), .COUT(n2580), .S0(n338), 
          .S1(n337));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_29.INIT0 = 16'h5aaa;
    defparam add_40_29.INIT1 = 16'h5aaa;
    defparam add_40_29.INJECT1_0 = "NO";
    defparam add_40_29.INJECT1_1 = "NO";
    CCU2D add_1043_12 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2609), .COUT(n2610));
    defparam add_1043_12.INIT0 = 16'h5555;
    defparam add_1043_12.INIT1 = 16'h5555;
    defparam add_1043_12.INJECT1_0 = "NO";
    defparam add_1043_12.INJECT1_1 = "NO";
    CCU2D add_31_11 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2554), .COUT(n2555), .S0(n250), 
          .S1(n249));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_11.INIT0 = 16'h5aaa;
    defparam add_31_11.INIT1 = 16'h5aaa;
    defparam add_31_11.INJECT1_0 = "NO";
    defparam add_31_11.INJECT1_1 = "NO";
    CCU2D add_22_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[1] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n2534), .S1(n153));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_1.INIT0 = 16'hF000;
    defparam add_22_1.INIT1 = 16'h5555;
    defparam add_22_1.INJECT1_0 = "NO";
    defparam add_22_1.INJECT1_1 = "NO";
    LUT4 mux_277_i10_4_lut (.A(next_state[1]), .B(n818), .C(n1362), .D(n1334), 
         .Z(n1376)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam mux_277_i10_4_lut.init = 16'hfaca;
    CCU2D add_13_33 (.A0(\debounce_counters[0] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2533), .S0(n16));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_33.INIT0 = 16'h5aaa;
    defparam add_13_33.INIT1 = 16'h0000;
    defparam add_13_33.INJECT1_0 = "NO";
    defparam add_13_33.INJECT1_1 = "NO";
    CCU2D add_13_31 (.A0(\debounce_counters[0] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2532), .COUT(n2533), .S0(n18), 
          .S1(n17));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_31.INIT0 = 16'h5aaa;
    defparam add_13_31.INIT1 = 16'h5aaa;
    defparam add_13_31.INJECT1_0 = "NO";
    defparam add_13_31.INJECT1_1 = "NO";
    CCU2D add_31_9 (.A0(\debounce_counters[2] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2553), .COUT(n2554), .S0(n252), 
          .S1(n251));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_9.INIT0 = 16'h5aaa;
    defparam add_31_9.INIT1 = 16'h5aaa;
    defparam add_31_9.INJECT1_0 = "NO";
    defparam add_31_9.INJECT1_1 = "NO";
    CCU2D add_31_7 (.A0(\debounce_counters[2] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2552), .COUT(n2553), .S0(n254), 
          .S1(n253));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_7.INIT0 = 16'h5aaa;
    defparam add_31_7.INIT1 = 16'h5aaa;
    defparam add_31_7.INJECT1_0 = "NO";
    defparam add_31_7.INJECT1_1 = "NO";
    CCU2D add_40_27 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2578), .COUT(n2579), .S0(n340), 
          .S1(n339));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_27.INIT0 = 16'h5aaa;
    defparam add_40_27.INIT1 = 16'h5aaa;
    defparam add_40_27.INJECT1_0 = "NO";
    defparam add_40_27.INJECT1_1 = "NO";
    CCU2D add_31_5 (.A0(\debounce_counters[2] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2551), .COUT(n2552), .S0(n256), 
          .S1(n255));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_5.INIT0 = 16'h5aaa;
    defparam add_31_5.INIT1 = 16'h5aaa;
    defparam add_31_5.INJECT1_0 = "NO";
    defparam add_31_5.INJECT1_1 = "NO";
    CCU2D add_13_29 (.A0(\debounce_counters[0] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2531), .COUT(n2532), .S0(n20), 
          .S1(n19));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_29.INIT0 = 16'h5aaa;
    defparam add_13_29.INIT1 = 16'h5aaa;
    defparam add_13_29.INJECT1_0 = "NO";
    defparam add_13_29.INJECT1_1 = "NO";
    CCU2D add_13_27 (.A0(\debounce_counters[0] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2530), .COUT(n2531), .S0(n22), 
          .S1(n21));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_27.INIT0 = 16'h5aaa;
    defparam add_13_27.INIT1 = 16'h5aaa;
    defparam add_13_27.INJECT1_0 = "NO";
    defparam add_13_27.INJECT1_1 = "NO";
    CCU2D add_1043_10 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2608), .COUT(n2609));
    defparam add_1043_10.INIT0 = 16'h5555;
    defparam add_1043_10.INIT1 = 16'h5555;
    defparam add_1043_10.INJECT1_0 = "NO";
    defparam add_1043_10.INJECT1_1 = "NO";
    CCU2D add_31_3 (.A0(\debounce_counters[2] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2550), .COUT(n2551), .S0(n258), 
          .S1(n257));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_3.INIT0 = 16'h5aaa;
    defparam add_31_3.INIT1 = 16'h5aaa;
    defparam add_31_3.INJECT1_0 = "NO";
    defparam add_31_3.INJECT1_1 = "NO";
    CCU2D add_40_25 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2577), .COUT(n2578), .S0(n342), 
          .S1(n341));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_25.INIT0 = 16'h5aaa;
    defparam add_40_25.INIT1 = 16'h5aaa;
    defparam add_40_25.INJECT1_0 = "NO";
    defparam add_40_25.INJECT1_1 = "NO";
    CCU2D add_31_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[2] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n2550), .S1(n259));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_1.INIT0 = 16'hF000;
    defparam add_31_1.INIT1 = 16'h5555;
    defparam add_31_1.INJECT1_0 = "NO";
    defparam add_31_1.INJECT1_1 = "NO";
    CCU2D add_40_23 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2576), .COUT(n2577), .S0(n344), 
          .S1(n343));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_23.INIT0 = 16'h5aaa;
    defparam add_40_23.INIT1 = 16'h5aaa;
    defparam add_40_23.INJECT1_0 = "NO";
    defparam add_40_23.INJECT1_1 = "NO";
    CCU2D add_40_21 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2575), .COUT(n2576), .S0(n346), 
          .S1(n345));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_21.INIT0 = 16'h5aaa;
    defparam add_40_21.INIT1 = 16'h5aaa;
    defparam add_40_21.INJECT1_0 = "NO";
    defparam add_40_21.INJECT1_1 = "NO";
    CCU2D add_22_33 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2549), .S0(n122));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_33.INIT0 = 16'h5aaa;
    defparam add_22_33.INIT1 = 16'h0000;
    defparam add_22_33.INJECT1_0 = "NO";
    defparam add_22_33.INJECT1_1 = "NO";
    CCU2D add_1043_8 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2607), .COUT(n2608));
    defparam add_1043_8.INIT0 = 16'h5555;
    defparam add_1043_8.INIT1 = 16'h5aaa;
    defparam add_1043_8.INJECT1_0 = "NO";
    defparam add_1043_8.INJECT1_1 = "NO";
    CCU2D add_22_31 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2548), .COUT(n2549), .S0(n124), 
          .S1(n123));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_31.INIT0 = 16'h5aaa;
    defparam add_22_31.INIT1 = 16'h5aaa;
    defparam add_22_31.INJECT1_0 = "NO";
    defparam add_22_31.INJECT1_1 = "NO";
    CCU2D add_22_29 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2547), .COUT(n2548), .S0(n126), 
          .S1(n125));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_29.INIT0 = 16'h5aaa;
    defparam add_22_29.INIT1 = 16'h5aaa;
    defparam add_22_29.INJECT1_0 = "NO";
    defparam add_22_29.INJECT1_1 = "NO";
    CCU2D add_13_25 (.A0(\debounce_counters[0] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2529), .COUT(n2530), .S0(n24), 
          .S1(n23));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_25.INIT0 = 16'h5aaa;
    defparam add_13_25.INIT1 = 16'h5aaa;
    defparam add_13_25.INJECT1_0 = "NO";
    defparam add_13_25.INJECT1_1 = "NO";
    LUT4 i21_4_lut_rep_30 (.A(n29_adj_10), .B(n42_adj_7), .C(n38_adj_2), 
         .D(n30_adj_8), .Z(n2909)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i21_4_lut_rep_30.init = 16'hfffe;
    LUT4 i965_2_lut_3_lut_4_lut (.A(n1334), .B(next_state[3]), .C(n1772), 
         .D(n823), .Z(n1381)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i965_2_lut_3_lut_4_lut.init = 16'h1000;
    LUT4 i1002_2_lut_3_lut_4_lut (.A(n1334), .B(next_state[3]), .C(n1772), 
         .D(n827), .Z(n1385)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i1002_2_lut_3_lut_4_lut.init = 16'h1000;
    LUT4 i976_4_lut_then_3_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[1]), 
         .Z(n2934)) /* synthesis lut_function=(!(A+!(B+(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i976_4_lut_then_3_lut.init = 16'h5454;
    LUT4 i969_2_lut_3_lut_4_lut (.A(n1334), .B(next_state[3]), .C(n1772), 
         .D(n824), .Z(n1382)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i969_2_lut_3_lut_4_lut.init = 16'h1000;
    LUT4 i1200_3_lut_4_lut (.A(n2909), .B(next_state[1]), .C(n2938), .D(next_state[3]), 
         .Z(clk_enable_133)) /* synthesis lut_function=(A (B (D)+!B ((D)+!C))+!A ((D)+!C)) */ ;
    defparam i1200_3_lut_4_lut.init = 16'hff07;
    LUT4 i24_4_lut_4_lut_else_3_lut (.A(next_state[2]), .B(next_state[0]), 
         .C(next_state_3__N_319[2]), .D(next_state[3]), .Z(n2921)) /* synthesis lut_function=(A (D)+!A (B (D)+!B !((D)+!C))) */ ;
    defparam i24_4_lut_4_lut_else_3_lut.init = 16'hee10;
    LUT4 i24_4_lut_4_lut_then_3_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(n2909), .Z(n2922)) /* synthesis lut_function=(A (B)+!A (B+!(C))) */ ;
    defparam i24_4_lut_4_lut_then_3_lut.init = 16'hcdcd;
    LUT4 i2_2_lut_rep_31_3_lut (.A(next_state[1]), .B(next_state[0]), .C(next_state[2]), 
         .Z(n2910)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i2_2_lut_rep_31_3_lut.init = 16'hfefe;
    LUT4 i1205_4_lut_then_4_lut (.A(next_state[3]), .B(next_state[1]), .C(next_state[2]), 
         .D(buttons_debounced_syn[1]), .Z(n2925)) /* synthesis lut_function=(!(A+!(B (C)+!B !(C (D))))) */ ;
    defparam i1205_4_lut_then_4_lut.init = 16'h4151;
    LUT4 i976_4_lut_else_3_lut (.A(next_state[3]), .B(next_state_3__N_319[2]), 
         .C(next_state[2]), .Z(n2933)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i976_4_lut_else_3_lut.init = 16'h4040;
    LUT4 mux_277_i19_4_lut_4_lut (.A(next_state[1]), .B(n1334), .C(n1362), 
         .D(n809), .Z(n1367)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_277_i19_4_lut_4_lut.init = 16'hf5c5;
    CCU2D add_22_27 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2546), .COUT(n2547), .S0(n128), 
          .S1(n127));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_27.INIT0 = 16'h5aaa;
    defparam add_22_27.INIT1 = 16'h5aaa;
    defparam add_22_27.INJECT1_0 = "NO";
    defparam add_22_27.INJECT1_1 = "NO";
    LUT4 i4_2_lut (.A(counter[0]), .B(counter[21]), .Z(n26_adj_5)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i4_2_lut.init = 16'heeee;
    CCU2D add_1043_6 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2606), .COUT(n2607));
    defparam add_1043_6.INIT0 = 16'h5555;
    defparam add_1043_6.INIT1 = 16'h5aaa;
    defparam add_1043_6.INJECT1_0 = "NO";
    defparam add_1043_6.INJECT1_1 = "NO";
    LUT4 i1182_2_lut_3_lut_4_lut (.A(next_state[1]), .B(next_state[2]), 
         .C(next_state_3__N_319[2]), .D(next_state[0]), .Z(n2778)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i1182_2_lut_3_lut_4_lut.init = 16'hfffe;
    LUT4 i1196_4_lut (.A(n2910), .B(next_state[3]), .C(n2198), .D(n2932), 
         .Z(clk_enable_65)) /* synthesis lut_function=(A (B+!(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i1196_4_lut.init = 16'h888a;
    LUT4 i47_4_lut_then_4_lut (.A(next_state[1]), .B(buttons_debounced_syn[1]), 
         .C(next_state[2]), .D(next_state[0]), .Z(n2937)) /* synthesis lut_function=(A (C)+!A (B (C (D)+!C !(D))+!B !(C+(D)))) */ ;
    defparam i47_4_lut_then_4_lut.init = 16'he0a5;
    LUT4 i47_4_lut_else_4_lut (.A(next_state[1]), .B(next_state[2]), .C(n2909), 
         .D(next_state[0]), .Z(n2936)) /* synthesis lut_function=(A (B)+!A !(B ((D)+!C)+!B !(D))) */ ;
    defparam i47_4_lut_else_4_lut.init = 16'h99c8;
    FD1P3IX debounce_counters_1___i2 (.D(n151), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i3 (.D(n150), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i4 (.D(n149), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i5 (.D(n148), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i6 (.D(n147), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i7 (.D(n146), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i8 (.D(n145), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i9 (.D(n144), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i10 (.D(n143), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i11 (.D(n142), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i12 (.D(n141), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i13 (.D(n140), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i14 (.D(n139), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i15 (.D(n138), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i16 (.D(n137), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i17 (.D(n136), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i18 (.D(n135), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i19 (.D(n134), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i20 (.D(n133), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i21 (.D(n132), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i22 (.D(n131), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i23 (.D(n130), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i24 (.D(n129), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i25 (.D(n128), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i26 (.D(n127), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i27 (.D(n126), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i28 (.D(n125), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i29 (.D(n124), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i30 (.D(n123), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i31 (.D(n122), .SP(clk_enable_130), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_1___i31.GSR = "ENABLED";
    LUT4 i12_3_lut_4_lut_4_lut_4_lut (.A(next_state[1]), .B(next_state[2]), 
         .C(next_state[3]), .D(next_state[0]), .Z(clk_enable_9)) /* synthesis lut_function=(A (C)+!A (B (C+!(D))+!B (C (D)+!C !(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i12_3_lut_4_lut_4_lut_4_lut.init = 16'hf0e5;
    CCU2D add_1043_4 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2605), .COUT(n2606));
    defparam add_1043_4.INIT0 = 16'h5555;
    defparam add_1043_4.INIT1 = 16'h5555;
    defparam add_1043_4.INJECT1_0 = "NO";
    defparam add_1043_4.INJECT1_1 = "NO";
    CCU2D add_1043_2 (.A0(\debounce_counters[2] [7]), .B0(\debounce_counters[2] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[2] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n2605));
    defparam add_1043_2.INIT0 = 16'h1000;
    defparam add_1043_2.INIT1 = 16'h5aaa;
    defparam add_1043_2.INJECT1_0 = "NO";
    defparam add_1043_2.INJECT1_1 = "NO";
    LUT4 i379_2_lut (.A(clk_enable_99), .B(button_inputs_asyn2[3]), .Z(clk_enable_44)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i379_2_lut.init = 16'hdddd;
    LUT4 i1205_4_lut_else_4_lut (.A(next_state[3]), .B(next_state[1]), .Z(n2924)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i1205_4_lut_else_4_lut.init = 16'h4444;
    LUT4 i51_3_lut_4_lut_4_lut_then_1_lut (.A(next_state[2]), .Z(n2940)) /* synthesis lut_function=(A) */ ;
    defparam i51_3_lut_4_lut_4_lut_then_1_lut.init = 16'haaaa;
    LUT4 i290_2_lut (.A(buttons_debounced_syn[1]), .B(next_state_3__N_319[2]), 
         .Z(n1419)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam i290_2_lut.init = 16'h2222;
    LUT4 i51_3_lut_4_lut_4_lut_else_1_lut (.A(next_state[2]), .B(next_state_3__N_319[2]), 
         .C(next_state[0]), .D(buttons_debounced_syn[1]), .Z(n2939)) /* synthesis lut_function=(A (B (C (D)))+!A !(B (C)+!B !(C))) */ ;
    defparam i51_3_lut_4_lut_4_lut_else_1_lut.init = 16'h9414;
    LUT4 i292_4_lut (.A(next_state[2]), .B(n2909), .C(n1419), .D(next_state[0]), 
         .Z(n1421)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam i292_4_lut.init = 16'ha088;
    FD1S3AY button_inputs_asyn1_i1 (.D(FlexMio61ExternalStop_c_c), .CK(clk), 
            .Q(button_inputs_asyn1[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam button_inputs_asyn1_i1.GSR = "ENABLED";
    LUT4 i973_3_lut_3_lut (.A(next_state[2]), .B(next_state[0]), .C(next_state[1]), 
         .Z(FP_SysLEDb_N_429)) /* synthesis lut_function=(A (B (C))+!A (C)) */ ;
    defparam i973_3_lut_3_lut.init = 16'hd0d0;
    LUT4 i1_2_lut_2_lut_3_lut (.A(next_state[1]), .B(next_state[0]), .C(next_state[2]), 
         .Z(clk_enable_20)) /* synthesis lut_function=(A+(B+!(C))) */ ;
    defparam i1_2_lut_2_lut_3_lut.init = 16'hefef;
    FD1S3AY button_inputs_asyn1_i2 (.D(FP_UsrSW3_c), .CK(clk), .Q(button_inputs_asyn1[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam button_inputs_asyn1_i2.GSR = "ENABLED";
    FD1S3AY button_inputs_asyn1_i3 (.D(FP_UsrSW1_c), .CK(clk), .Q(button_inputs_asyn1[3])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam button_inputs_asyn1_i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i1 (.D(n258), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i1.GSR = "ENABLED";
    CCU2D add_40_19 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2574), .COUT(n2575), .S0(n348), 
          .S1(n347));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_19.INIT0 = 16'h5aaa;
    defparam add_40_19.INIT1 = 16'h5aaa;
    defparam add_40_19.INJECT1_0 = "NO";
    defparam add_40_19.INJECT1_1 = "NO";
    LUT4 n2856_bdd_2_lut_then_4_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(n2909), .D(next_state[1]), .Z(n2943)) /* synthesis lut_function=(A (B+(D))+!A (B+!(C+!(D)))) */ ;
    defparam n2856_bdd_2_lut_then_4_lut.init = 16'hefcc;
    FD1P3AX next_state_i3 (.D(next_state_3__N_23[3]), .SP(clk_enable_132), 
            .CK(clk), .Q(next_state[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam next_state_i3.GSR = "ENABLED";
    CCU2D add_40_17 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2573), .COUT(n2574), .S0(n350), 
          .S1(n349));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_17.INIT0 = 16'h5aaa;
    defparam add_40_17.INIT1 = 16'h5aaa;
    defparam add_40_17.INJECT1_0 = "NO";
    defparam add_40_17.INJECT1_1 = "NO";
    LUT4 i1198_4_lut_then_3_lut (.A(next_state[2]), .B(n2909), .C(next_state[3]), 
         .Z(n2928)) /* synthesis lut_function=(A+((C)+!B)) */ ;
    defparam i1198_4_lut_then_3_lut.init = 16'hfbfb;
    FD1P3AX next_state_i2 (.D(next_state_3__N_23[2]), .SP(clk_enable_133), 
            .CK(clk), .Q(next_state[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam next_state_i2.GSR = "ENABLED";
    LUT4 n2856_bdd_2_lut_else_4_lut (.A(next_state[2]), .B(next_state[3]), 
         .C(next_state_3__N_319[2]), .D(next_state[1]), .Z(n2942)) /* synthesis lut_function=(A (B)+!A (B+!((D)+!C))) */ ;
    defparam n2856_bdd_2_lut_else_4_lut.init = 16'hccdc;
    LUT4 i296_2_lut_2_lut (.A(next_state[2]), .B(n2909), .Z(n1425)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i296_2_lut_2_lut.init = 16'h4444;
    CCU2D add_1044_26 (.A0(\debounce_counters[0] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2604), .S1(clk_enable_8));
    defparam add_1044_26.INIT0 = 16'hf555;
    defparam add_1044_26.INIT1 = 16'h0000;
    defparam add_1044_26.INJECT1_0 = "NO";
    defparam add_1044_26.INJECT1_1 = "NO";
    CCU2D add_40_15 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2572), .COUT(n2573), .S0(n352), 
          .S1(n351));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_15.INIT0 = 16'h5aaa;
    defparam add_40_15.INIT1 = 16'h5aaa;
    defparam add_40_15.INJECT1_0 = "NO";
    defparam add_40_15.INJECT1_1 = "NO";
    CCU2D add_1044_24 (.A0(\debounce_counters[0] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2603), .COUT(n2604));
    defparam add_1044_24.INIT0 = 16'h5555;
    defparam add_1044_24.INIT1 = 16'h5555;
    defparam add_1044_24.INJECT1_0 = "NO";
    defparam add_1044_24.INJECT1_1 = "NO";
    LUT4 i1198_4_lut_else_3_lut (.A(next_state[2]), .B(next_state_3__N_319[2]), 
         .C(next_state[0]), .D(next_state[3]), .Z(n2927)) /* synthesis lut_function=(A+(B+(C (D)+!C !(D)))) */ ;
    defparam i1198_4_lut_else_3_lut.init = 16'hfeef;
    FD1P3AX next_state_i1 (.D(next_state_3__N_23[1]), .SP(clk_enable_134), 
            .CK(clk), .Q(next_state[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam next_state_i1.GSR = "ENABLED";
    FD1P3AX FPIO_isoCtrlRSTn_157 (.D(FPIO_isoCtrlRSTn_N_435), .SP(clk_enable_135), 
            .CK(clk), .Q(FPIO_isoCtrlRSTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam FPIO_isoCtrlRSTn_157.GSR = "ENABLED";
    LUT4 pushed_0__I_0_1_lut (.A(pushed[0]), .Z(pushed_0__N_182)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 176[24])
    defparam pushed_0__I_0_1_lut.init = 16'h5555;
    LUT4 i3_4_lut_4_lut (.A(next_state[1]), .B(n2755), .C(next_state[3]), 
         .D(n1419), .Z(n1334)) /* synthesis lut_function=(!(A+((C+!(D))+!B))) */ ;
    defparam i3_4_lut_4_lut.init = 16'h0400;
    CCU2D add_1044_22 (.A0(\debounce_counters[0] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2602), .COUT(n2603));
    defparam add_1044_22.INIT0 = 16'h5555;
    defparam add_1044_22.INIT1 = 16'h5555;
    defparam add_1044_22.INJECT1_0 = "NO";
    defparam add_1044_22.INJECT1_1 = "NO";
    CCU2D add_40_13 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2571), .COUT(n2572), .S0(n354), 
          .S1(n353));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_13.INIT0 = 16'h5aaa;
    defparam add_40_13.INIT1 = 16'h5aaa;
    defparam add_40_13.INJECT1_0 = "NO";
    defparam add_40_13.INJECT1_1 = "NO";
    CCU2D add_13_23 (.A0(\debounce_counters[0] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2528), .COUT(n2529), .S0(n26), 
          .S1(n25));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_23.INIT0 = 16'h5aaa;
    defparam add_13_23.INIT1 = 16'h5aaa;
    defparam add_13_23.INJECT1_0 = "NO";
    defparam add_13_23.INJECT1_1 = "NO";
    CCU2D add_13_21 (.A0(\debounce_counters[0] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2527), .COUT(n2528), .S0(n28), 
          .S1(n27));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_21.INIT0 = 16'h5aaa;
    defparam add_13_21.INIT1 = 16'h5aaa;
    defparam add_13_21.INJECT1_0 = "NO";
    defparam add_13_21.INJECT1_1 = "NO";
    CCU2D add_40_11 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2570), .COUT(n2571), .S0(n356), 
          .S1(n355));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_11.INIT0 = 16'h5aaa;
    defparam add_40_11.INIT1 = 16'h5aaa;
    defparam add_40_11.INJECT1_0 = "NO";
    defparam add_40_11.INJECT1_1 = "NO";
    CCU2D add_13_19 (.A0(\debounce_counters[0] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2526), .COUT(n2527), .S0(n30), 
          .S1(n29));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_19.INIT0 = 16'h5aaa;
    defparam add_13_19.INIT1 = 16'h5aaa;
    defparam add_13_19.INJECT1_0 = "NO";
    defparam add_13_19.INJECT1_1 = "NO";
    CCU2D add_1044_20 (.A0(\debounce_counters[0] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2601), .COUT(n2602));
    defparam add_1044_20.INIT0 = 16'h5555;
    defparam add_1044_20.INIT1 = 16'h5555;
    defparam add_1044_20.INJECT1_0 = "NO";
    defparam add_1044_20.INJECT1_1 = "NO";
    CCU2D add_40_9 (.A0(\debounce_counters[3] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2569), .COUT(n2570), .S0(n358), 
          .S1(n357));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_9.INIT0 = 16'h5aaa;
    defparam add_40_9.INIT1 = 16'h5aaa;
    defparam add_40_9.INJECT1_0 = "NO";
    defparam add_40_9.INJECT1_1 = "NO";
    CCU2D add_22_25 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2545), .COUT(n2546), .S0(n130), 
          .S1(n129));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_25.INIT0 = 16'h5aaa;
    defparam add_22_25.INIT1 = 16'h5aaa;
    defparam add_22_25.INJECT1_0 = "NO";
    defparam add_22_25.INJECT1_1 = "NO";
    CCU2D add_13_17 (.A0(\debounce_counters[0] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2525), .COUT(n2526), .S0(n32), 
          .S1(n31));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_17.INIT0 = 16'h5aaa;
    defparam add_13_17.INIT1 = 16'h5aaa;
    defparam add_13_17.INJECT1_0 = "NO";
    defparam add_13_17.INJECT1_1 = "NO";
    CCU2D add_1044_18 (.A0(\debounce_counters[0] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2600), .COUT(n2601));
    defparam add_1044_18.INIT0 = 16'h5555;
    defparam add_1044_18.INIT1 = 16'h5555;
    defparam add_1044_18.INJECT1_0 = "NO";
    defparam add_1044_18.INJECT1_1 = "NO";
    CCU2D add_40_7 (.A0(\debounce_counters[3] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2568), .COUT(n2569), .S0(n360), 
          .S1(n359));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_7.INIT0 = 16'h5aaa;
    defparam add_40_7.INIT1 = 16'h5aaa;
    defparam add_40_7.INJECT1_0 = "NO";
    defparam add_40_7.INJECT1_1 = "NO";
    CCU2D add_40_5 (.A0(\debounce_counters[3] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2567), .COUT(n2568), .S0(n362), 
          .S1(n361));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_5.INIT0 = 16'h5aaa;
    defparam add_40_5.INIT1 = 16'h5aaa;
    defparam add_40_5.INJECT1_0 = "NO";
    defparam add_40_5.INJECT1_1 = "NO";
    CCU2D add_1044_16 (.A0(\debounce_counters[0] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2599), .COUT(n2600));
    defparam add_1044_16.INIT0 = 16'h5555;
    defparam add_1044_16.INIT1 = 16'h5555;
    defparam add_1044_16.INJECT1_0 = "NO";
    defparam add_1044_16.INJECT1_1 = "NO";
    CCU2D add_40_3 (.A0(\debounce_counters[3] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2566), .COUT(n2567), .S0(n364), 
          .S1(n363));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_3.INIT0 = 16'h5aaa;
    defparam add_40_3.INIT1 = 16'h5aaa;
    defparam add_40_3.INJECT1_0 = "NO";
    defparam add_40_3.INJECT1_1 = "NO";
    CCU2D add_1044_14 (.A0(\debounce_counters[0] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2598), .COUT(n2599));
    defparam add_1044_14.INIT0 = 16'h5555;
    defparam add_1044_14.INIT1 = 16'h5555;
    defparam add_1044_14.INJECT1_0 = "NO";
    defparam add_1044_14.INJECT1_1 = "NO";
    CCU2D add_40_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[3] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n2566), .S1(n365));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_40_1.INIT0 = 16'hF000;
    defparam add_40_1.INIT1 = 16'h5555;
    defparam add_40_1.INJECT1_0 = "NO";
    defparam add_40_1.INJECT1_1 = "NO";
    CCU2D add_31_33 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2565), .S0(n228));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_33.INIT0 = 16'h5aaa;
    defparam add_31_33.INIT1 = 16'h0000;
    defparam add_31_33.INJECT1_0 = "NO";
    defparam add_31_33.INJECT1_1 = "NO";
    CCU2D add_1044_12 (.A0(\debounce_counters[0] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2597), .COUT(n2598));
    defparam add_1044_12.INIT0 = 16'h5555;
    defparam add_1044_12.INIT1 = 16'h5555;
    defparam add_1044_12.INJECT1_0 = "NO";
    defparam add_1044_12.INJECT1_1 = "NO";
    CCU2D add_1044_10 (.A0(\debounce_counters[0] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2596), .COUT(n2597));
    defparam add_1044_10.INIT0 = 16'h5555;
    defparam add_1044_10.INIT1 = 16'h5555;
    defparam add_1044_10.INJECT1_0 = "NO";
    defparam add_1044_10.INJECT1_1 = "NO";
    CCU2D add_1044_8 (.A0(\debounce_counters[0] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2595), .COUT(n2596));
    defparam add_1044_8.INIT0 = 16'h5555;
    defparam add_1044_8.INIT1 = 16'h5aaa;
    defparam add_1044_8.INJECT1_0 = "NO";
    defparam add_1044_8.INJECT1_1 = "NO";
    CCU2D add_1044_6 (.A0(\debounce_counters[0] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2594), .COUT(n2595));
    defparam add_1044_6.INIT0 = 16'h5555;
    defparam add_1044_6.INIT1 = 16'h5aaa;
    defparam add_1044_6.INJECT1_0 = "NO";
    defparam add_1044_6.INJECT1_1 = "NO";
    CCU2D add_22_23 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2544), .COUT(n2545), .S0(n132), 
          .S1(n131));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_23.INIT0 = 16'h5aaa;
    defparam add_22_23.INIT1 = 16'h5aaa;
    defparam add_22_23.INJECT1_0 = "NO";
    defparam add_22_23.INJECT1_1 = "NO";
    CCU2D add_31_31 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2564), .COUT(n2565), .S0(n230), 
          .S1(n229));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_31.INIT0 = 16'h5aaa;
    defparam add_31_31.INIT1 = 16'h5aaa;
    defparam add_31_31.INJECT1_0 = "NO";
    defparam add_31_31.INJECT1_1 = "NO";
    LUT4 i388_1_lut (.A(Carrier_PG_1V8_N_444), .Z(n1761)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(212[1] 327[13])
    defparam i388_1_lut.init = 16'h5555;
    LUT4 pushed_1__I_0_1_lut (.A(pushed[1]), .Z(pushed_1__N_180)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 176[24])
    defparam pushed_1__I_0_1_lut.init = 16'h5555;
    CCU2D add_31_29 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2563), .COUT(n2564), .S0(n232), 
          .S1(n231));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_29.INIT0 = 16'h5aaa;
    defparam add_31_29.INIT1 = 16'h5aaa;
    defparam add_31_29.INJECT1_0 = "NO";
    defparam add_31_29.INJECT1_1 = "NO";
    PFUMX i1249 (.BLUT(n2927), .ALUT(n2928), .C0(next_state[1]), .Z(clk_enable_134));
    LUT4 i1_2_lut_3_lut_3_lut_4_lut (.A(next_state[1]), .B(next_state[0]), 
         .C(next_state[3]), .D(next_state[2]), .Z(clk_enable_21)) /* synthesis lut_function=(A+(B+(C+!(D)))) */ ;
    defparam i1_2_lut_3_lut_3_lut_4_lut.init = 16'hfeff;
    CCU2D add_22_21 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2543), .COUT(n2544), .S0(n134), 
          .S1(n133));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_22_21.INIT0 = 16'h5aaa;
    defparam add_22_21.INIT1 = 16'h5aaa;
    defparam add_22_21.INJECT1_0 = "NO";
    defparam add_22_21.INJECT1_1 = "NO";
    CCU2D add_13_15 (.A0(\debounce_counters[0] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2524), .COUT(n2525), .S0(n34), 
          .S1(n33));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_15.INIT0 = 16'h5aaa;
    defparam add_13_15.INIT1 = 16'h5aaa;
    defparam add_13_15.INJECT1_0 = "NO";
    defparam add_13_15.INJECT1_1 = "NO";
    LUT4 mux_277_i14_4_lut_4_lut (.A(next_state[1]), .B(n1334), .C(n1362), 
         .D(n814), .Z(n1372)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_277_i14_4_lut_4_lut.init = 16'hf5c5;
    CCU2D add_1044_4 (.A0(\debounce_counters[0] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2593), .COUT(n2594));
    defparam add_1044_4.INIT0 = 16'h5555;
    defparam add_1044_4.INIT1 = 16'h5555;
    defparam add_1044_4.INJECT1_0 = "NO";
    defparam add_1044_4.INJECT1_1 = "NO";
    CCU2D add_31_27 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2562), .COUT(n2563), .S0(n234), 
          .S1(n233));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_27.INIT0 = 16'h5aaa;
    defparam add_31_27.INIT1 = 16'h5aaa;
    defparam add_31_27.INJECT1_0 = "NO";
    defparam add_31_27.INJECT1_1 = "NO";
    LUT4 i1_4_lut_then_4_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[0]), 
         .D(next_state[1]), .Z(n2946)) /* synthesis lut_function=(A+(B (C (D))+!B !(D))) */ ;
    defparam i1_4_lut_then_4_lut.init = 16'heabb;
    LUT4 i1_4_lut_else_4_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[0]), 
         .D(next_state[1]), .Z(n2945)) /* synthesis lut_function=(A+(B (C (D)))) */ ;
    defparam i1_4_lut_else_4_lut.init = 16'heaaa;
    CCU2D add_1044_2 (.A0(\debounce_counters[0] [7]), .B0(\debounce_counters[0] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[0] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n2593));
    defparam add_1044_2.INIT0 = 16'h1000;
    defparam add_1044_2.INIT1 = 16'h5aaa;
    defparam add_1044_2.INJECT1_0 = "NO";
    defparam add_1044_2.INJECT1_1 = "NO";
    LUT4 pushed_2__I_0_1_lut (.A(pushed[2]), .Z(pushed_2__N_178)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 176[24])
    defparam pushed_2__I_0_1_lut.init = 16'h5555;
    LUT4 pushed_3__I_0_1_lut (.A(pushed[3]), .Z(pushed_3__N_176)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(172[17] 176[24])
    defparam pushed_3__I_0_1_lut.init = 16'h5555;
    CCU2D add_31_25 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2561), .COUT(n2562), .S0(n236), 
          .S1(n235));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_25.INIT0 = 16'h5aaa;
    defparam add_31_25.INIT1 = 16'h5aaa;
    defparam add_31_25.INJECT1_0 = "NO";
    defparam add_31_25.INJECT1_1 = "NO";
    LUT4 n2844_bdd_4_lut_then_4_lut (.A(buttons_debounced_syn[1]), .B(next_state_3__N_319[2]), 
         .C(next_state[3]), .D(next_state[0]), .Z(n2949)) /* synthesis lut_function=(!(A ((C+(D))+!B)+!A (B (C)+!B (C+!(D))))) */ ;
    defparam n2844_bdd_4_lut_then_4_lut.init = 16'h050c;
    LUT4 i4_4_lut (.A(DIGS3C_SlotD3_SlotOK_c), .B(DIGS3C_SlotD5_SlotOK_c), 
         .C(DIGS3C_SlotD1_SlotOK_c), .D(n6), .Z(FP_UsrLED2_c)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(140[19:139])
    defparam i4_4_lut.init = 16'h8000;
    LUT4 i1188_4_lut (.A(n27_adj_1), .B(n2778), .C(next_state[3]), .D(n2941), 
         .Z(clk_enable_166)) /* synthesis lut_function=(A (B (C))+!A (B (C+!(D))+!B !(C+(D)))) */ ;
    defparam i1188_4_lut.init = 16'hc0c5;
    LUT4 n2844_bdd_4_lut_else_4_lut (.A(next_state[1]), .B(next_state[3]), 
         .C(next_state[0]), .Z(n2948)) /* synthesis lut_function=(!(A (B)+!A (B+(C)))) */ ;
    defparam n2844_bdd_4_lut_else_4_lut.init = 16'h2323;
    LUT4 i1_2_lut_rep_28_3_lut_3_lut (.A(next_state[0]), .B(next_state_3__N_319[2]), 
         .C(n2909), .Z(n2907)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;
    defparam i1_2_lut_rep_28_3_lut_3_lut.init = 16'h1010;
    LUT4 i376_2_lut (.A(clk_enable_8), .B(button_inputs_asyn2[0]), .Z(clk_enable_96)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i376_2_lut.init = 16'hdddd;
    LUT4 i1_2_lut_2_lut (.A(next_state[0]), .B(next_state[2]), .Z(n4)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i1_2_lut_2_lut.init = 16'h4444;
    LUT4 i29_4_lut (.A(n2907), .B(n2778), .C(next_state[3]), .D(n32_adj_6), 
         .Z(n14)) /* synthesis lut_function=(!(A (B (C))+!A (B (C+!(D))+!B !(C+(D))))) */ ;
    defparam i29_4_lut.init = 16'h3f3a;
    LUT4 i1_3_lut_4_lut (.A(next_state[2]), .B(next_state[3]), .C(next_state[1]), 
         .D(next_state[0]), .Z(Carrier_PG_1V8_N_457)) /* synthesis lut_function=(A+(B+!(C (D)+!C !(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam i1_3_lut_4_lut.init = 16'heffe;
    LUT4 i1208_4_lut (.A(next_state_3__N_319[2]), .B(next_state[0]), .C(n2909), 
         .D(n2913), .Z(next_state_3__N_23[3])) /* synthesis lut_function=(!(A+(B+(C+(D))))) */ ;
    defparam i1208_4_lut.init = 16'h0001;
    LUT4 i1_2_lut (.A(next_state[0]), .B(next_state[2]), .Z(n2755)) /* synthesis lut_function=(A (B)) */ ;
    defparam i1_2_lut.init = 16'h8888;
    LUT4 i1_2_lut_3_lut_4_lut (.A(next_state[2]), .B(next_state[3]), .C(next_state[0]), 
         .D(next_state[1]), .Z(clk_enable_25)) /* synthesis lut_function=(A (C+(D))+!A (B (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam i1_2_lut_3_lut_4_lut.init = 16'heee0;
    LUT4 i1_2_lut_3_lut (.A(next_state[2]), .B(next_state[3]), .C(next_state[1]), 
         .Z(FPIO_isoCtrlRSTn_N_435)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam i1_2_lut_3_lut.init = 16'h1010;
    LUT4 i491_3_lut_4_lut (.A(next_state[0]), .B(next_state_3__N_319[2]), 
         .C(next_state[1]), .D(n2909), .Z(n1865)) /* synthesis lut_function=(A (B (C (D))+!B ((D)+!C))+!A (B ((D)+!C)+!B (C (D)))) */ ;
    defparam i491_3_lut_4_lut.init = 16'hf606;
    LUT4 i1_4_lut (.A(n2909), .B(next_state[1]), .C(next_state_3__N_319[2]), 
         .D(n4), .Z(n27_adj_1)) /* synthesis lut_function=(A (B+!(C+!(D)))) */ ;
    defparam i1_4_lut.init = 16'h8a88;
    LUT4 i14_1_lut_rep_39 (.A(next_state[1]), .Z(n2918)) /* synthesis lut_function=(!(A)) */ ;
    defparam i14_1_lut_rep_39.init = 16'h5555;
    LUT4 mux_277_i21_4_lut_4_lut (.A(next_state[1]), .B(n1334), .C(n1362), 
         .D(n807), .Z(n1365)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_277_i21_4_lut_4_lut.init = 16'hf5c5;
    CCU2D add_13_13 (.A0(\debounce_counters[0] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2523), .COUT(n2524), .S0(n36), 
          .S1(n35));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_13.INIT0 = 16'h5aaa;
    defparam add_13_13.INIT1 = 16'h5aaa;
    defparam add_13_13.INJECT1_0 = "NO";
    defparam add_13_13.INJECT1_1 = "NO";
    GSR GSR_INST (.GSR(VCC_net));
    LUT4 i20_4_lut (.A(counter[2]), .B(n40_adj_9), .C(n34_adj_4), .D(counter[19]), 
         .Z(n42_adj_7)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i20_4_lut.init = 16'hfffe;
    LUT4 mux_277_i9_4_lut_4_lut (.A(next_state[1]), .B(n1334), .C(n1362), 
         .D(n819), .Z(n1377)) /* synthesis lut_function=(!(A (B+!(C (D)))+!A (B (C)+!B !((D)+!C)))) */ ;
    defparam mux_277_i9_4_lut_4_lut.init = 16'h3505;
    LUT4 i1_2_lut_rep_34_2_lut (.A(next_state[2]), .B(next_state[3]), .Z(n2913)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i1_2_lut_rep_34_2_lut.init = 16'hdddd;
    PFUMX i1263 (.BLUT(n2948), .ALUT(n2949), .C0(next_state[2]), .Z(next_state_3__N_23[0]));
    LUT4 i1_2_lut_adj_1 (.A(DIGS3C_SlotD4_SlotOK_c), .B(DIGS3C_SlotD2_SlotOK_c), 
         .Z(n6)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(140[19:139])
    defparam i1_2_lut_adj_1.init = 16'h8888;
    LUT4 i399_2_lut (.A(next_state[3]), .B(n1772), .Z(n1362)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(94[12:22])
    defparam i399_2_lut.init = 16'h4444;
    CCU2D add_31_23 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2560), .COUT(n2561), .S0(n238), 
          .S1(n237));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_23.INIT0 = 16'h5aaa;
    defparam add_31_23.INIT1 = 16'h5aaa;
    defparam add_31_23.INJECT1_0 = "NO";
    defparam add_31_23.INJECT1_1 = "NO";
    CCU2D add_13_11 (.A0(\debounce_counters[0] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2522), .COUT(n2523), .S0(n38), 
          .S1(n37));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_11.INIT0 = 16'h5aaa;
    defparam add_13_11.INIT1 = 16'h5aaa;
    defparam add_13_11.INJECT1_0 = "NO";
    defparam add_13_11.INJECT1_1 = "NO";
    LUT4 i2_3_lut (.A(next_state[0]), .B(n2909), .C(next_state[1]), .Z(n2198)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam i2_3_lut.init = 16'h2020;
    CCU2D add_13_9 (.A0(\debounce_counters[0] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2521), .COUT(n2522), .S0(n40), 
          .S1(n39));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_13_9.INIT0 = 16'h5aaa;
    defparam add_13_9.INIT1 = 16'h5aaa;
    defparam add_13_9.INJECT1_0 = "NO";
    defparam add_13_9.INJECT1_1 = "NO";
    LUT4 i1_4_lut_else_4_lut_adj_2 (.A(next_state[1]), .B(next_state_3__N_319[2]), 
         .C(next_state[2]), .D(n2909), .Z(n2930)) /* synthesis lut_function=(A (C)+!A !(B (D)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i1_4_lut_else_4_lut_adj_2.init = 16'ha1f5;
    PFUMX i1261 (.BLUT(n2945), .ALUT(n2946), .C0(next_state_3__N_319[2]), 
          .Z(clk_enable_23));
    LUT4 mux_277_i12_4_lut_4_lut (.A(next_state[1]), .B(n1334), .C(n1362), 
         .D(n816), .Z(n1374)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (B+((D)+!C))) */ ;
    defparam mux_277_i12_4_lut_4_lut.init = 16'hf5c5;
    LUT4 i16_4_lut (.A(counter[15]), .B(counter[6]), .C(counter[3]), .D(counter[12]), 
         .Z(n38_adj_2)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i16_4_lut.init = 16'hfffe;
    PFUMX i1259 (.BLUT(n2942), .ALUT(n2943), .C0(next_state[0]), .Z(clk_enable_135));
    LUT4 i1_4_lut_then_4_lut_adj_3 (.A(next_state[1]), .B(next_state_3__N_319[2]), 
         .C(next_state[2]), .D(buttons_debounced_syn[1]), .Z(n2931)) /* synthesis lut_function=(A (C)+!A (B (C)+!B !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(215[9] 325[18])
    defparam i1_4_lut_then_4_lut_adj_3.init = 16'he1f1;
    PFUMX i1247 (.BLUT(n2924), .ALUT(n2925), .C0(next_state[0]), .Z(next_state_3__N_23[1]));
    PFUMX i1257 (.BLUT(n2939), .ALUT(n2940), .C0(next_state[1]), .Z(n2941));
    LUT4 i1_2_lut_4_lut (.A(next_state_3__N_319[2]), .B(buttons_debounced_syn[1]), 
         .C(next_state[0]), .D(next_state[1]), .Z(n32_adj_6)) /* synthesis lut_function=(A (B (C+(D))+!B (D))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam i1_2_lut_4_lut.init = 16'hff80;
    LUT4 i7_2_lut (.A(counter[13]), .B(counter[16]), .Z(n29_adj_10)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i7_2_lut.init = 16'heeee;
    LUT4 i8_2_lut (.A(counter[5]), .B(counter[11]), .Z(n30_adj_8)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i8_2_lut.init = 16'heeee;
    PFUMX i1255 (.BLUT(n2936), .ALUT(n2937), .C0(next_state_3__N_319[2]), 
          .Z(n2938));
    LUT4 i18_4_lut (.A(counter[14]), .B(n36_adj_3), .C(n26_adj_5), .D(counter[1]), 
         .Z(n40_adj_9)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i18_4_lut.init = 16'hfffe;
    PFUMX i1253 (.BLUT(n2933), .ALUT(n2934), .C0(next_state[0]), .Z(next_state_3__N_23[2]));
    LUT4 i12_4_lut (.A(counter[17]), .B(counter[4]), .C(counter[10]), 
         .D(counter[9]), .Z(n34_adj_4)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i12_4_lut.init = 16'hfffe;
    VLO i1 (.Z(GND_net));
    TSALL TSALL_INST (.TSALL(GND_net));
    PFUMX i1251 (.BLUT(n2930), .ALUT(n2931), .C0(next_state[0]), .Z(n2932));
    PFUMX i1245 (.BLUT(n2921), .ALUT(n2922), .C0(next_state[1]), .Z(Carrier_PG_1V8_N_453));
    LUT4 next_state_2__I_0_169_i7_3_lut_3_lut (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[2]), .Z(FP_SysLEDr_N_428)) /* synthesis lut_function=(A (B (C)+!B !(C))+!A (B+!(C))) */ ;
    defparam next_state_2__I_0_169_i7_3_lut_3_lut.init = 16'hc7c7;
    LUT4 m1_lut (.Z(n2998)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    CCU2D add_1041_26 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2640), .S1(clk_enable_97));
    defparam add_1041_26.INIT0 = 16'hf555;
    defparam add_1041_26.INIT1 = 16'h0000;
    defparam add_1041_26.INJECT1_0 = "NO";
    defparam add_1041_26.INJECT1_1 = "NO";
    CCU2D add_1041_24 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2639), .COUT(n2640));
    defparam add_1041_24.INIT0 = 16'h5555;
    defparam add_1041_24.INIT1 = 16'h5555;
    defparam add_1041_24.INJECT1_0 = "NO";
    defparam add_1041_24.INJECT1_1 = "NO";
    CCU2D add_1041_22 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2638), .COUT(n2639));
    defparam add_1041_22.INIT0 = 16'h5555;
    defparam add_1041_22.INIT1 = 16'h5555;
    defparam add_1041_22.INJECT1_0 = "NO";
    defparam add_1041_22.INJECT1_1 = "NO";
    CCU2D add_1041_20 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2637), .COUT(n2638));
    defparam add_1041_20.INIT0 = 16'h5555;
    defparam add_1041_20.INIT1 = 16'h5555;
    defparam add_1041_20.INJECT1_0 = "NO";
    defparam add_1041_20.INJECT1_1 = "NO";
    CCU2D add_1041_18 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2636), .COUT(n2637));
    defparam add_1041_18.INIT0 = 16'h5555;
    defparam add_1041_18.INIT1 = 16'h5555;
    defparam add_1041_18.INJECT1_0 = "NO";
    defparam add_1041_18.INJECT1_1 = "NO";
    CCU2D add_1041_16 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2635), .COUT(n2636));
    defparam add_1041_16.INIT0 = 16'h5555;
    defparam add_1041_16.INIT1 = 16'h5555;
    defparam add_1041_16.INJECT1_0 = "NO";
    defparam add_1041_16.INJECT1_1 = "NO";
    CCU2D add_1041_14 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2634), .COUT(n2635));
    defparam add_1041_14.INIT0 = 16'h5555;
    defparam add_1041_14.INIT1 = 16'h5555;
    defparam add_1041_14.INJECT1_0 = "NO";
    defparam add_1041_14.INJECT1_1 = "NO";
    CCU2D add_1041_12 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2633), .COUT(n2634));
    defparam add_1041_12.INIT0 = 16'h5555;
    defparam add_1041_12.INIT1 = 16'h5555;
    defparam add_1041_12.INJECT1_0 = "NO";
    defparam add_1041_12.INJECT1_1 = "NO";
    CCU2D add_1041_10 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2632), .COUT(n2633));
    defparam add_1041_10.INIT0 = 16'h5555;
    defparam add_1041_10.INIT1 = 16'h5555;
    defparam add_1041_10.INJECT1_0 = "NO";
    defparam add_1041_10.INJECT1_1 = "NO";
    CCU2D add_1041_8 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2631), .COUT(n2632));
    defparam add_1041_8.INIT0 = 16'h5555;
    defparam add_1041_8.INIT1 = 16'h5aaa;
    defparam add_1041_8.INJECT1_0 = "NO";
    defparam add_1041_8.INJECT1_1 = "NO";
    CCU2D add_1041_6 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2630), .COUT(n2631));
    defparam add_1041_6.INIT0 = 16'h5555;
    defparam add_1041_6.INIT1 = 16'h5aaa;
    defparam add_1041_6.INJECT1_0 = "NO";
    defparam add_1041_6.INJECT1_1 = "NO";
    CCU2D add_1041_4 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2629), .COUT(n2630));
    defparam add_1041_4.INIT0 = 16'h5555;
    defparam add_1041_4.INIT1 = 16'h5555;
    defparam add_1041_4.INJECT1_0 = "NO";
    defparam add_1041_4.INJECT1_1 = "NO";
    CCU2D add_1041_2 (.A0(\debounce_counters[1] [7]), .B0(\debounce_counters[1] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[1] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n2629));
    defparam add_1041_2.INIT0 = 16'h1000;
    defparam add_1041_2.INIT1 = 16'h5aaa;
    defparam add_1041_2.INJECT1_0 = "NO";
    defparam add_1041_2.INJECT1_1 = "NO";
    CCU2D add_1042_26 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2628), .S1(clk_enable_99));
    defparam add_1042_26.INIT0 = 16'hf555;
    defparam add_1042_26.INIT1 = 16'h0000;
    defparam add_1042_26.INJECT1_0 = "NO";
    defparam add_1042_26.INJECT1_1 = "NO";
    CCU2D add_1042_24 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2627), .COUT(n2628));
    defparam add_1042_24.INIT0 = 16'h5555;
    defparam add_1042_24.INIT1 = 16'h5555;
    defparam add_1042_24.INJECT1_0 = "NO";
    defparam add_1042_24.INJECT1_1 = "NO";
    CCU2D add_1042_22 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2626), .COUT(n2627));
    defparam add_1042_22.INIT0 = 16'h5555;
    defparam add_1042_22.INIT1 = 16'h5555;
    defparam add_1042_22.INJECT1_0 = "NO";
    defparam add_1042_22.INJECT1_1 = "NO";
    CCU2D add_1042_20 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2625), .COUT(n2626));
    defparam add_1042_20.INIT0 = 16'h5555;
    defparam add_1042_20.INIT1 = 16'h5555;
    defparam add_1042_20.INJECT1_0 = "NO";
    defparam add_1042_20.INJECT1_1 = "NO";
    CCU2D add_1042_18 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2624), .COUT(n2625));
    defparam add_1042_18.INIT0 = 16'h5555;
    defparam add_1042_18.INIT1 = 16'h5555;
    defparam add_1042_18.INJECT1_0 = "NO";
    defparam add_1042_18.INJECT1_1 = "NO";
    CCU2D add_1042_16 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2623), .COUT(n2624));
    defparam add_1042_16.INIT0 = 16'h5555;
    defparam add_1042_16.INIT1 = 16'h5555;
    defparam add_1042_16.INJECT1_0 = "NO";
    defparam add_1042_16.INJECT1_1 = "NO";
    CCU2D add_1042_14 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2622), .COUT(n2623));
    defparam add_1042_14.INIT0 = 16'h5555;
    defparam add_1042_14.INIT1 = 16'h5555;
    defparam add_1042_14.INJECT1_0 = "NO";
    defparam add_1042_14.INJECT1_1 = "NO";
    CCU2D add_1042_12 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2621), .COUT(n2622));
    defparam add_1042_12.INIT0 = 16'h5555;
    defparam add_1042_12.INIT1 = 16'h5555;
    defparam add_1042_12.INJECT1_0 = "NO";
    defparam add_1042_12.INJECT1_1 = "NO";
    CCU2D add_184_23 (.A0(counter[21]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n2592), 
          .S0(n806));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(300[17:24])
    defparam add_184_23.INIT0 = 16'h5555;
    defparam add_184_23.INIT1 = 16'h0000;
    defparam add_184_23.INJECT1_0 = "NO";
    defparam add_184_23.INJECT1_1 = "NO";
    CCU2D add_184_21 (.A0(counter[19]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[20]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2591), .COUT(n2592), .S0(n808), .S1(n807));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(300[17:24])
    defparam add_184_21.INIT0 = 16'h5555;
    defparam add_184_21.INIT1 = 16'h5555;
    defparam add_184_21.INJECT1_0 = "NO";
    defparam add_184_21.INJECT1_1 = "NO";
    CCU2D add_184_19 (.A0(counter[17]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[18]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2590), .COUT(n2591), .S0(n810), .S1(n809));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(300[17:24])
    defparam add_184_19.INIT0 = 16'h5555;
    defparam add_184_19.INIT1 = 16'h5555;
    defparam add_184_19.INJECT1_0 = "NO";
    defparam add_184_19.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_2___i2 (.D(n257), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i3 (.D(n256), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i4 (.D(n255), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i5 (.D(n254), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i6 (.D(n253), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i7 (.D(n252), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i8 (.D(n251), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i9 (.D(n250), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i10 (.D(n249), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i11 (.D(n248), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i12 (.D(n247), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i13 (.D(n246), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i14 (.D(n245), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i15 (.D(n244), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i16 (.D(n243), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i17 (.D(n242), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i18 (.D(n241), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i19 (.D(n240), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i20 (.D(n239), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i21 (.D(n238), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i22 (.D(n237), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i23 (.D(n236), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i24 (.D(n235), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i25 (.D(n234), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i26 (.D(n233), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i27 (.D(n232), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i28 (.D(n231), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i29 (.D(n230), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i30 (.D(n229), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i31 (.D(n228), .SP(clk_enable_165), .CD(button_inputs_asyn2[2]), 
            .CK(clk), .Q(\debounce_counters[2] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(153[9] 178[16])
    defparam debounce_counters_2___i31.GSR = "ENABLED";
    CCU2D add_1042_10 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2620), .COUT(n2621));
    defparam add_1042_10.INIT0 = 16'h5555;
    defparam add_1042_10.INIT1 = 16'h5555;
    defparam add_1042_10.INJECT1_0 = "NO";
    defparam add_1042_10.INJECT1_1 = "NO";
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    CCU2D add_1042_8 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2619), .COUT(n2620));
    defparam add_1042_8.INIT0 = 16'h5555;
    defparam add_1042_8.INIT1 = 16'h5aaa;
    defparam add_1042_8.INJECT1_0 = "NO";
    defparam add_1042_8.INJECT1_1 = "NO";
    FD1P3AX next_state_i0 (.D(next_state_3__N_23[0]), .SP(clk_enable_166), 
            .CK(clk), .Q(next_state[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(214[2] 326[9])
    defparam next_state_i0.GSR = "ENABLED";
    LUT4 i14_4_lut (.A(counter[18]), .B(counter[7]), .C(counter[20]), 
         .D(counter[8]), .Z(n36_adj_3)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i14_4_lut.init = 16'hfffe;
    CCU2D add_1042_6 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2618), .COUT(n2619));
    defparam add_1042_6.INIT0 = 16'h5555;
    defparam add_1042_6.INIT1 = 16'h5aaa;
    defparam add_1042_6.INJECT1_0 = "NO";
    defparam add_1042_6.INJECT1_1 = "NO";
    CCU2D add_184_17 (.A0(counter[15]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[16]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2589), .COUT(n2590), .S0(n812), .S1(n811));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(300[17:24])
    defparam add_184_17.INIT0 = 16'h5555;
    defparam add_184_17.INIT1 = 16'h5555;
    defparam add_184_17.INJECT1_0 = "NO";
    defparam add_184_17.INJECT1_1 = "NO";
    CCU2D add_1042_4 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2617), .COUT(n2618));
    defparam add_1042_4.INIT0 = 16'h5555;
    defparam add_1042_4.INIT1 = 16'h5555;
    defparam add_1042_4.INJECT1_0 = "NO";
    defparam add_1042_4.INJECT1_1 = "NO";
    CCU2D add_31_21 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2559), .COUT(n2560), .S0(n240), 
          .S1(n239));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(163[49:69])
    defparam add_31_21.INIT0 = 16'h5aaa;
    defparam add_31_21.INIT1 = 16'h5aaa;
    defparam add_31_21.INJECT1_0 = "NO";
    defparam add_31_21.INJECT1_1 = "NO";
    CCU2D add_184_15 (.A0(counter[13]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[14]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2588), .COUT(n2589), .S0(n814), .S1(n813));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(300[17:24])
    defparam add_184_15.INIT0 = 16'h5555;
    defparam add_184_15.INIT1 = 16'h5555;
    defparam add_184_15.INJECT1_0 = "NO";
    defparam add_184_15.INJECT1_1 = "NO";
    CCU2D add_184_13 (.A0(counter[11]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[12]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2587), .COUT(n2588), .S0(n816), .S1(n815));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_171224/source/power_on_debounce.vhd(300[17:24])
    defparam add_184_13.INIT0 = 16'h5555;
    defparam add_184_13.INIT1 = 16'h5555;
    defparam add_184_13.INJECT1_0 = "NO";
    defparam add_184_13.INJECT1_1 = "NO";
    
endmodule
//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

