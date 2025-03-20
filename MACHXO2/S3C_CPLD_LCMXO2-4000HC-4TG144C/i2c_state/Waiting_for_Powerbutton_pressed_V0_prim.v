// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Tue Dec 10 16:22:50 2024
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
            Carrier_PwrOn, PG_VIN, PPn_VIN, PG_Module);   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(7[8:42])
    inout SCL /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(22[3:6])
    inout SDA /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(23[3:6])
    input RST_N;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(24[3:8])
    output FP_SysLEDg;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(26[3:13])
    output FP_SysLEDr;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(27[3:13])
    output FP_SysLEDb;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(28[3:13])
    output Carrier_PG_3V3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(29[3:17])
    output FPIO_FlexMIO52;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(30[3:17])
    input FPIO_ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(31[3:20])
    output FPIO_isoCtrlRSTn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(32[3:19])
    input SysSW_Pwr_NC;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(34[3:15])
    input FP_UsrSW1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(35[3:12])
    input FP_UsrSW2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(36[3:12])
    input FP_UsrSW3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(37[3:12])
    output FP_UsrLED1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(39[3:13])
    output FP_UsrLED2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(40[3:13])
    output FP_UsrLED3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(41[3:13])
    output FP_UsrLED4;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(42[3:13])
    output FP_SysLEDs;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(43[3:13])
    output Carrier_PG_1V8;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(44[3:17])
    input SD0_CD;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(45[3:9])
    input SD1_CD;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(46[3:9])
    output DIGS3C_Shared_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(47[3:29])
    output DIGS3C_Shared_ReqSafeState;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(48[3:29])
    input DIGS3C_SlotD1_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(50[3:22])
    input DIGS3C_SlotD1_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(51[3:23])
    input DIGS3C_SlotD2_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(53[3:22])
    input DIGS3C_SlotD2_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(54[3:23])
    input DIGS3C_SlotD3_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(56[3:22])
    input DIGS3C_SlotD3_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(57[3:23])
    input DIGS3C_SlotD4_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(59[3:22])
    input DIGS3C_SlotD4_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(60[3:23])
    input DIGS3C_SlotD5_ReqOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(62[3:22])
    input DIGS3C_SlotD5_SlotOK;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(63[3:23])
    output SD_SEL;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(66[3:9])
    input FlexMIOs52_PCIe;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(67[3:18])
    output FlexMio61ExternalStop;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(68[3:24])
    output FlexMIOs53_GPIO_PowerDown;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(69[3:28])
    input ANL_S3C_SlotOK1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(74[3:18])
    input ANL_S3C_SlotOK2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(75[3:18])
    input ANL_S3C_SlotOK3;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(76[3:18])
    output ANL_S3C_CarrierReady;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(77[3:23])
    output ANL_S3C_P54_Legacy;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(78[3:21])
    output DIGS3C_SlotD1_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(80[3:23])
    output DIGS3C_SlotD2_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(81[3:23])
    output DIGS3C_SlotD3_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(82[3:23])
    output DIGS3C_SlotD4_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(83[3:23])
    output DIGS3C_SlotD5_SlotOE;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(84[3:23])
    output Carrier_PwrOn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(88[9:22])
    input PG_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(89[3:9])
    input PPn_VIN;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(90[3:10])
    input PG_Module;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(91[3:12])
    
    wire clk /* synthesis is_clock=1, SET_AS_NETWORK=clk */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(172[9:12])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/efb_vhdl.vhd(31[12:21])
    
    wire GND_net, VCC_net, i2c1_scloen, FP_SysLEDg_c, FP_SysLEDr_c, 
        FP_SysLEDb_c, Carrier_PG_3V3_c, FPIO_FlexMIO52_c_c, FlexMio61ExternalStop_c_c, 
        FPIO_isoCtrlRSTn_c, SysSW_Pwr_NC_c, FP_UsrLED1_c, FP_SysLEDs_c, 
        n2136, FlexMIOs53_GPIO_PowerDown_c, n2550, n2568, Carrier_PwrOn_c, 
        PG_VIN_c, PPn_VIN_c, PG_Module_c;
    wire [21:0]counter;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(173[9:16])
    wire [3:0]next_state;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(179[12:22])
    wire [31:0]\debounce_counters[0] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(186[12:29])
    wire [31:0]\debounce_counters[1] ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(186[12:29])
    wire [1:0]button_inputs_asyn1;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(188[12:31])
    wire [1:0]button_inputs_asyn2;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(189[9:28])
    wire [1:0]pushed;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(190[9:15])
    wire [1:0]buttons_debounced_syn;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(191[12:33])
    
    wire pushed_1__N_98, n17, n18, n19, n20, n21, n22, n23, 
        n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, 
        n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, 
        n44, n45, n46, n47, n48, n2097, n2548, n2083, n2096, 
        n2567, n2095, n2094, n2093, n40_adj_314, n2115, n2114, 
        n2092, n26_adj_315, n2113, n2112, n2082, n39_adj_316, n38_adj_317, 
        n1957, n37_adj_318, n2566, n2111, n6, pushed_0__N_104, n36_adj_319, 
        pushed_1__N_93, n123, n124, n125, n126, n127, n128, n129, 
        n130, n131, n132, n133, n134, n135, n136, n137, n138, 
        n139, n140, n141, n142, n143, n144, n145, n146, n147, 
        n148, n149, n150, n151, n152, n153, n154, n2547, n34_adj_320, 
        clk_enable_5, n28_adj_321, n2557, n1782, clk_enable_98, n1772, 
        clk_enable_95, pushed_1__N_102, n5, n2091, n2231, clk_enable_96, 
        n27_adj_322, n2090, n2110, n2109, n2108, n2089, n2088, 
        n1024, n1023, n1022, n1021, n1020, n1019, n1018, n1017, 
        n1016, n1015, n1014, FPIO_isoCtrlRSTn_N_295, n2107, n26_adj_323, 
        n2081, n1013, n1012, n1011, n1010, n1009, n1008, n1007, 
        n1006, n1005, n1004, n1003, n1001, clk_enable_4, n2087, 
        n523, n524, n525, n526, n527, n528, n529, n530, n531, 
        n532, n533, n534, n535, n536, n537, n538, n539, n540, 
        n541, n542, n543, n544, n973, n2556, n2541, n25_adj_324, 
        n16, n954, FlexMIOs53_GPIO_PowerDown_N_303;
    wire [3:0]next_state_3__N_177;
    
    wire n2106, n6_adj_325, n2554, n2086, FP_SysLEDr_N_286, FP_SysLEDb_N_287, 
        FP_SysLEDg_N_285, Carrier_PwrOn_N_304, n2080, n28_adj_326, n2390, 
        n2085, n1682, n2105, n2543, n1128, clk_enable_92, n2542, 
        Carrier_PG_1V8_N_309, Carrier_PG_1V8_N_300, i2c1_sdao, i2c1_sdaoen, 
        i2c1_sclo, i2c1_sdai, n2540, n2104, n27_adj_327, n2084, 
        n2539, clk_enable_39, clk_enable_70, n43_adj_328, n2122, n28_adj_329, 
        n2103, n2121, n26_adj_330, n2120, clk_enable_91, n2102, 
        n2240, n2564, n2101, n2553, n2119, n2100, n2158, n7, 
        n5_adj_331, n2099, n2118, clk_enable_7, n2117, n3, n2453, 
        n2401, n36_adj_332, n2452, n2451, n1136, n2116, n2400, 
        n38_adj_333, n19_adj_334, n2538, n2152, n2551, n2441, clk_enable_97, 
        n2098, n25_adj_335, n2681, n2143, clk_enable_93, clk_enable_94, 
        n2134, n1537, n2569;
    
    VHI i2 (.Z(VCC_net));
    efb_vhdl dut (.clk(clk), .i2c1_sdaoen(i2c1_sdaoen), .i2c1_sdao(i2c1_sdao), 
            .i2c1_scloen(i2c1_scloen), .i2c1_sclo(i2c1_sclo), .i2c1_sdai(i2c1_sdai), 
            .i2c1_scli(i2c1_scli), .VCC_net(VCC_net), .GND_net(GND_net)) /* synthesis NGD_DRC_MASK=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(226[8:16])
    BB BB1_sda (.I(i2c1_sdao), .T(i2c1_sdaoen), .B(SDA), .O(i2c1_sdai)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=21, LSE_LCOL=8, LSE_RCOL=16, LSE_LLINE=226, LSE_RLINE=226 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/efb_vhdl.vhd(139[14:16])
    LUT4 i344_2_lut (.A(next_state[0]), .B(next_state[1]), .Z(n3)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i344_2_lut.init = 16'h6666;
    LUT4 i945_2_lut_3_lut_4_lut (.A(n973), .B(next_state[3]), .C(n2453), 
         .D(n532), .Z(n1012)) /* synthesis lut_function=(A+(B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i945_2_lut_3_lut_4_lut.init = 16'hffef;
    FD1S3AY button_inputs_asyn2_i0 (.D(button_inputs_asyn1[0]), .CK(clk), 
            .Q(button_inputs_asyn2[0])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam button_inputs_asyn2_i0.GSR = "ENABLED";
    LUT4 m1_lut (.Z(n2681)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    FD1S3AY buttons_debounced_syn_i1 (.D(pushed_0__N_104), .CK(clk), .Q(next_state_3__N_177[2])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam buttons_debounced_syn_i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i0 (.D(n154), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i0.GSR = "ENABLED";
    OFS1P3DX Carrier_PwrOn_132 (.D(Carrier_PwrOn_N_304), .SP(clk_enable_4), 
            .SCLK(clk), .CD(GND_net), .Q(Carrier_PwrOn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam Carrier_PwrOn_132.GSR = "ENABLED";
    PFUMX i1523 (.BLUT(n2400), .ALUT(FPIO_isoCtrlRSTn_N_295), .C0(next_state[1]), 
          .Z(n2401));
    LUT4 i944_2_lut_3_lut_4_lut (.A(n973), .B(next_state[3]), .C(n2453), 
         .D(n537), .Z(n1017)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i944_2_lut_3_lut_4_lut.init = 16'h1000;
    CCU2D add_19_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[1] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n2096), .S1(n154));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_1.INIT0 = 16'hF000;
    defparam add_19_1.INIT1 = 16'h5555;
    defparam add_19_1.INJECT1_0 = "NO";
    defparam add_19_1.INJECT1_1 = "NO";
    LUT4 i16_1_lut (.A(next_state[1]), .Z(n954)) /* synthesis lut_function=(!(A)) */ ;
    defparam i16_1_lut.init = 16'h5555;
    LUT4 i12_4_lut (.A(\debounce_counters[1] [18]), .B(\debounce_counters[1] [24]), 
         .C(\debounce_counters[1] [20]), .D(\debounce_counters[1] [16]), 
         .Z(n28_adj_321)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i12_4_lut.init = 16'hfffe;
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk)) /* synthesis NOM_FREQ="7", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "7";
    LUT4 next_state_1__bdd_4_lut (.A(next_state[1]), .B(buttons_debounced_syn[1]), 
         .C(next_state[2]), .D(next_state[0]), .Z(n2441)) /* synthesis lut_function=(A (C+!(D))+!A !(B (C+!(D))+!B !(D))) */ ;
    defparam next_state_1__bdd_4_lut.init = 16'hb5aa;
    FD1S3AY button_inputs_asyn1_i1 (.D(FlexMio61ExternalStop_c_c), .CK(clk), 
            .Q(button_inputs_asyn1[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam button_inputs_asyn1_i1.GSR = "ENABLED";
    OB FP_SysLEDg_pad (.I(FP_SysLEDg_c), .O(FP_SysLEDg));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(26[3:13])
    OFS1P3DX FP_SysLEDb_129 (.D(FP_SysLEDb_N_287), .SP(clk_enable_5), .SCLK(clk), 
            .CD(GND_net), .Q(FP_SysLEDb_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam FP_SysLEDb_129.GSR = "ENABLED";
    OFS1P3DX Carrier_PG_3V3_133 (.D(Carrier_PwrOn_N_304), .SP(clk_enable_4), 
            .SCLK(clk), .CD(GND_net), .Q(Carrier_PG_3V3_c)) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam Carrier_PG_3V3_133.GSR = "ENABLED";
    OFS1P3DX FP_SysLEDr_128 (.D(FP_SysLEDr_N_286), .SP(clk_enable_5), .SCLK(clk), 
            .CD(GND_net), .Q(FP_SysLEDr_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam FP_SysLEDr_128.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i0 (.D(n48), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i0.GSR = "ENABLED";
    IFS1P3BX button_inputs_asyn1_i0 (.D(SysSW_Pwr_NC_c), .SP(VCC_net), .SCLK(clk), 
            .PD(GND_net), .Q(button_inputs_asyn1[0])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam button_inputs_asyn1_i0.GSR = "ENABLED";
    FD1P3IX FP_SysLEDs_137 (.D(n954), .SP(clk_enable_7), .CD(next_state[3]), 
            .CK(clk), .Q(FP_SysLEDs_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam FP_SysLEDs_137.GSR = "ENABLED";
    LUT4 i1_4_lut (.A(next_state[0]), .B(next_state[1]), .C(next_state_3__N_177[2]), 
         .D(buttons_debounced_syn[1]), .Z(n38_adj_333)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;
    defparam i1_4_lut.init = 16'heccc;
    BB BB1_scl (.I(i2c1_sclo), .T(i2c1_scloen), .B(SCL), .O(i2c1_scli)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=21, LSE_LCOL=8, LSE_RCOL=16, LSE_LLINE=226, LSE_RLINE=226 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/efb_vhdl.vhd(143[14:16])
    LUT4 i1_2_lut_4_lut (.A(next_state[1]), .B(next_state[0]), .C(next_state[2]), 
         .D(next_state[3]), .Z(clk_enable_98)) /* synthesis lut_function=(A+(B+((D)+!C))) */ ;
    defparam i1_2_lut_4_lut.init = 16'hffef;
    LUT4 i11_4_lut (.A(\debounce_counters[1] [25]), .B(\debounce_counters[1] [28]), 
         .C(\debounce_counters[1] [26]), .D(\debounce_counters[1] [17]), 
         .Z(n27_adj_322)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i11_4_lut.init = 16'hfffe;
    LUT4 i323_2_lut (.A(pushed_1__N_98), .B(button_inputs_asyn2[0]), .Z(clk_enable_70)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i323_2_lut.init = 16'hdddd;
    PFUMX i1583 (.BLUT(n2553), .ALUT(n2554), .C0(next_state[1]), .Z(Carrier_PG_1V8_N_309));
    CCU2D add_10_33 (.A0(\debounce_counters[0] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2095), .S0(n17));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_33.INIT0 = 16'h5aaa;
    defparam add_10_33.INIT1 = 16'h0000;
    defparam add_10_33.INJECT1_0 = "NO";
    defparam add_10_33.INJECT1_1 = "NO";
    FD1P3IX counter__i0 (.D(n1024), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i0.GSR = "ENABLED";
    LUT4 i1_2_lut_3_lut (.A(next_state[1]), .B(next_state[2]), .C(next_state[0]), 
         .Z(n1537)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i1_2_lut_3_lut.init = 16'hfefe;
    LUT4 i1495_4_lut (.A(n1772), .B(\debounce_counters[0] [31]), .C(n2136), 
         .D(\debounce_counters[0] [14]), .Z(pushed_1__N_98)) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(190[9:15])
    defparam i1495_4_lut.init = 16'h3230;
    CCU2D add_159_3 (.A0(counter[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2112), .COUT(n2113), .S0(n543), .S1(n542));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(402[17:24])
    defparam add_159_3.INIT0 = 16'h5555;
    defparam add_159_3.INIT1 = 16'h5555;
    defparam add_159_3.INJECT1_0 = "NO";
    defparam add_159_3.INJECT1_1 = "NO";
    LUT4 i324_2_lut (.A(pushed_1__N_93), .B(button_inputs_asyn2[1]), .Z(clk_enable_39)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i324_2_lut.init = 16'hdddd;
    FD1P3IX debounce_counters_1___i31 (.D(n123), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i31.GSR = "ENABLED";
    LUT4 i1503_4_lut (.A(n1782), .B(\debounce_counters[1] [31]), .C(n2134), 
         .D(\debounce_counters[1] [14]), .Z(pushed_1__N_93)) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(190[9:15])
    defparam i1503_4_lut.init = 16'h3230;
    CCU2D add_159_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n2112), .S1(n544));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(402[17:24])
    defparam add_159_1.INIT0 = 16'hF000;
    defparam add_159_1.INIT1 = 16'h5555;
    defparam add_159_1.INJECT1_0 = "NO";
    defparam add_159_1.INJECT1_1 = "NO";
    LUT4 i943_2_lut_3_lut_4_lut (.A(n973), .B(next_state[3]), .C(n2453), 
         .D(n539), .Z(n1019)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i943_2_lut_3_lut_4_lut.init = 16'h1000;
    LUT4 i966_4_lut (.A(n5_adj_331), .B(\debounce_counters[0] [13]), .C(\debounce_counters[0] [12]), 
         .D(n6_adj_325), .Z(n1772)) /* synthesis lut_function=(A (B+(C))+!A (B+(C (D)))) */ ;
    defparam i966_4_lut.init = 16'hfcec;
    FD1P3IX debounce_counters_1___i30 (.D(n124), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i29 (.D(n125), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i28 (.D(n126), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i27 (.D(n127), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i26 (.D(n128), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i25 (.D(n129), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i24 (.D(n130), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i23 (.D(n131), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i22 (.D(n132), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i21 (.D(n133), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i20 (.D(n134), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i19 (.D(n135), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i18 (.D(n136), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i17 (.D(n137), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i16 (.D(n138), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i15 (.D(n139), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i14 (.D(n140), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i13 (.D(n141), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i12 (.D(n142), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i11 (.D(n143), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i10 (.D(n144), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i9 (.D(n145), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i9.GSR = "ENABLED";
    CCU2D add_19_33 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2111), .S0(n123));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_33.INIT0 = 16'h5aaa;
    defparam add_19_33.INIT1 = 16'h0000;
    defparam add_19_33.INJECT1_0 = "NO";
    defparam add_19_33.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_1___i8 (.D(n146), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i7 (.D(n147), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i6 (.D(n148), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i5 (.D(n149), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i4 (.D(n150), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i3 (.D(n151), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i2 (.D(n152), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i1 (.D(n153), .SP(clk_enable_39), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(\debounce_counters[1] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_1___i1.GSR = "ENABLED";
    FD1S3AY buttons_debounced_syn_i2 (.D(pushed_1__N_102), .CK(clk), .Q(buttons_debounced_syn[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam buttons_debounced_syn_i2.GSR = "ENABLED";
    CCU2D add_10_31 (.A0(\debounce_counters[0] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2094), .COUT(n2095), .S0(n19), 
          .S1(n18));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_31.INIT0 = 16'h5aaa;
    defparam add_10_31.INIT1 = 16'h5aaa;
    defparam add_10_31.INJECT1_0 = "NO";
    defparam add_10_31.INJECT1_1 = "NO";
    LUT4 i936_2_lut_3_lut_4_lut (.A(n973), .B(next_state[3]), .C(n2453), 
         .D(n540), .Z(n1020)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i936_2_lut_3_lut_4_lut.init = 16'h1000;
    CCU2D add_19_31 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2110), .COUT(n2111), .S0(n125), 
          .S1(n124));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_31.INIT0 = 16'h5aaa;
    defparam add_19_31.INIT1 = 16'h5aaa;
    defparam add_19_31.INJECT1_0 = "NO";
    defparam add_19_31.INJECT1_1 = "NO";
    LUT4 i1_2_lut (.A(next_state_3__N_177[2]), .B(buttons_debounced_syn[1]), 
         .Z(n1957)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam i1_2_lut.init = 16'h4444;
    LUT4 i940_2_lut_3_lut_4_lut (.A(n973), .B(next_state[3]), .C(n2453), 
         .D(n541), .Z(n1021)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i940_2_lut_3_lut_4_lut.init = 16'h1000;
    PFUMX i1594 (.BLUT(n2567), .ALUT(n2566), .C0(next_state[2]), .Z(n2568));
    LUT4 i1_4_lut_4_lut (.A(next_state[3]), .B(n38_adj_333), .C(n2401), 
         .D(next_state[2]), .Z(n36_adj_332)) /* synthesis lut_function=(!(A+!(B (C+(D))+!B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam i1_4_lut_4_lut.init = 16'h5450;
    LUT4 next_state_2__bdd_4_lut_1585 (.A(FPIO_isoCtrlRSTn_N_295), .B(n1957), 
         .C(next_state[0]), .D(next_state[1]), .Z(n2451)) /* synthesis lut_function=(!(A (B (D)+!B (C+(D)))+!A (((D)+!C)+!B))) */ ;
    defparam next_state_2__bdd_4_lut_1585.init = 16'h00ca;
    FD1S3AY button_inputs_asyn2_i1 (.D(button_inputs_asyn1[1]), .CK(clk), 
            .Q(button_inputs_asyn2[1])) /* synthesis lse_init_val=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam button_inputs_asyn2_i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i31 (.D(n17), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [31])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i31.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i30 (.D(n18), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [30])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i29 (.D(n19), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [29])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i28 (.D(n20), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [28])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i27 (.D(n21), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [27])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i26 (.D(n22), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [26])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i25 (.D(n23), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [25])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i24 (.D(n24), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [24])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i23 (.D(n25), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [23])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i22 (.D(n26), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [22])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i21 (.D(n27), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i20 (.D(n28), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i19 (.D(n29), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i18 (.D(n30), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i17 (.D(n31), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i16 (.D(n32), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i15 (.D(n33), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i14 (.D(n34), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i13 (.D(n35), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i12 (.D(n36), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i11 (.D(n37), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i10 (.D(n38), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i9 (.D(n39), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i8 (.D(n40), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i7 (.D(n41), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i6 (.D(n42), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i5 (.D(n43), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i4 (.D(n44), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i3 (.D(n45), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i2 (.D(n46), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i1 (.D(n47), .SP(clk_enable_70), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(\debounce_counters[0] [1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam debounce_counters_0___i1.GSR = "ENABLED";
    FD1P3IX counter__i1 (.D(n1023), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i1.GSR = "ENABLED";
    OB FP_SysLEDr_pad (.I(FP_SysLEDr_c), .O(FP_SysLEDr));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(27[3:13])
    OB FP_SysLEDb_pad (.I(FP_SysLEDb_c), .O(FP_SysLEDb));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(28[3:13])
    OB Carrier_PG_3V3_pad (.I(Carrier_PG_3V3_c), .O(Carrier_PG_3V3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(29[3:17])
    OB FPIO_FlexMIO52_pad (.I(FPIO_FlexMIO52_c_c), .O(FPIO_FlexMIO52));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(30[3:17])
    OB FPIO_isoCtrlRSTn_pad (.I(FPIO_isoCtrlRSTn_c), .O(FPIO_isoCtrlRSTn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(32[3:19])
    OB FP_UsrLED1_pad (.I(FP_UsrLED1_c), .O(FP_UsrLED1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(39[3:13])
    OB FP_UsrLED2_pad (.I(next_state_3__N_177[2]), .O(FP_UsrLED2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(40[3:13])
    OB FP_UsrLED3_pad (.I(GND_net), .O(FP_UsrLED3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(41[3:13])
    OB FP_UsrLED4_pad (.I(GND_net), .O(FP_UsrLED4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(42[3:13])
    OB FP_SysLEDs_pad (.I(FP_SysLEDs_c), .O(FP_SysLEDs));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(43[3:13])
    OBZ n1135_pad (.I(GND_net), .T(n1136), .O(Carrier_PG_1V8));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(314[1] 429[13])
    OB DIGS3C_Shared_CarrierReady_pad (.I(GND_net), .O(DIGS3C_Shared_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(47[3:29])
    OB DIGS3C_Shared_ReqSafeState_pad (.I(GND_net), .O(DIGS3C_Shared_ReqSafeState));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(48[3:29])
    OB SD_SEL_pad (.I(GND_net), .O(SD_SEL));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(66[3:9])
    OB FlexMio61ExternalStop_pad (.I(FlexMio61ExternalStop_c_c), .O(FlexMio61ExternalStop));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(68[3:24])
    OB FlexMIOs53_GPIO_PowerDown_pad (.I(FlexMIOs53_GPIO_PowerDown_c), .O(FlexMIOs53_GPIO_PowerDown));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(69[3:28])
    OB ANL_S3C_CarrierReady_pad (.I(GND_net), .O(ANL_S3C_CarrierReady));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(77[3:23])
    OB ANL_S3C_P54_Legacy_pad (.I(GND_net), .O(ANL_S3C_P54_Legacy));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(78[3:21])
    OB DIGS3C_SlotD1_SlotOE_pad (.I(GND_net), .O(DIGS3C_SlotD1_SlotOE));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(80[3:23])
    OB DIGS3C_SlotD2_SlotOE_pad (.I(GND_net), .O(DIGS3C_SlotD2_SlotOE));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(81[3:23])
    OB DIGS3C_SlotD3_SlotOE_pad (.I(GND_net), .O(DIGS3C_SlotD3_SlotOE));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(82[3:23])
    OB DIGS3C_SlotD4_SlotOE_pad (.I(GND_net), .O(DIGS3C_SlotD4_SlotOE));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(83[3:23])
    OB DIGS3C_SlotD5_SlotOE_pad (.I(GND_net), .O(DIGS3C_SlotD5_SlotOE));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(84[3:23])
    OB Carrier_PwrOn_pad (.I(Carrier_PwrOn_c), .O(Carrier_PwrOn));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(88[9:22])
    IB FlexMio61ExternalStop_c_pad (.I(FPIO_ExternalStop), .O(FlexMio61ExternalStop_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(31[3:20])
    IB SysSW_Pwr_NC_pad (.I(SysSW_Pwr_NC), .O(SysSW_Pwr_NC_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(34[3:15])
    IB FPIO_FlexMIO52_c_pad (.I(FlexMIOs52_PCIe), .O(FPIO_FlexMIO52_c_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(67[3:18])
    IB PG_VIN_pad (.I(PG_VIN), .O(PG_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(89[3:9])
    IB PPn_VIN_pad (.I(PPn_VIN), .O(PPn_VIN_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(90[3:10])
    IB PG_Module_pad (.I(PG_Module), .O(PG_Module_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(91[3:12])
    LUT4 i939_2_lut_3_lut_4_lut (.A(n973), .B(next_state[3]), .C(n2453), 
         .D(n542), .Z(n1022)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i939_2_lut_3_lut_4_lut.init = 16'h1000;
    CCU2D add_19_29 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2109), .COUT(n2110), .S0(n127), 
          .S1(n126));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_29.INIT0 = 16'h5aaa;
    defparam add_19_29.INIT1 = 16'h5aaa;
    defparam add_19_29.INJECT1_0 = "NO";
    defparam add_19_29.INJECT1_1 = "NO";
    CCU2D add_19_27 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2108), .COUT(n2109), .S0(n129), 
          .S1(n128));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_27.INIT0 = 16'h5aaa;
    defparam add_19_27.INIT1 = 16'h5aaa;
    defparam add_19_27.INJECT1_0 = "NO";
    defparam add_19_27.INJECT1_1 = "NO";
    CCU2D add_19_25 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2107), .COUT(n2108), .S0(n131), 
          .S1(n130));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_25.INIT0 = 16'h5aaa;
    defparam add_19_25.INIT1 = 16'h5aaa;
    defparam add_19_25.INJECT1_0 = "NO";
    defparam add_19_25.INJECT1_1 = "NO";
    LUT4 i1_4_lut_4_lut_4_lut_else_3_lut (.A(next_state[2]), .B(next_state[0]), 
         .C(next_state[3]), .D(next_state_3__N_177[2]), .Z(n2553)) /* synthesis lut_function=(A (C)+!A (B (C)+!B !(C+!(D)))) */ ;
    defparam i1_4_lut_4_lut_4_lut_else_3_lut.init = 16'he1e0;
    LUT4 i876_2_lut (.A(FPIO_isoCtrlRSTn_N_295), .B(next_state[0]), .Z(n1682)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i876_2_lut.init = 16'heeee;
    LUT4 i1432_3_lut (.A(next_state_3__N_177[2]), .B(next_state[3]), .C(n1537), 
         .Z(n2152)) /* synthesis lut_function=(A (B)+!A (B (C))) */ ;
    defparam i1432_3_lut.init = 16'hc8c8;
    PFUMX i1586 (.BLUT(n2556), .ALUT(n1537), .C0(next_state[3]), .Z(n2557));
    PFUMX i1581 (.BLUT(n2550), .ALUT(n2551), .C0(next_state[1]), .Z(clk_enable_92));
    LUT4 i1498_4_lut (.A(n1537), .B(n36_adj_332), .C(next_state[3]), .D(next_state_3__N_177[2]), 
         .Z(clk_enable_95)) /* synthesis lut_function=(!(A (B)+!A (B+!(C (D)+!C !(D))))) */ ;
    defparam i1498_4_lut.init = 16'h3223;
    LUT4 next_state_3__bdd_2_lut_1602 (.A(n1537), .B(next_state_3__N_177[2]), 
         .Z(n2564)) /* synthesis lut_function=(A+(B)) */ ;
    defparam next_state_3__bdd_2_lut_1602.init = 16'heeee;
    LUT4 i15_4_lut (.A(n25_adj_335), .B(n27_adj_327), .C(n26_adj_330), 
         .D(n28_adj_326), .Z(n2136)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i15_4_lut.init = 16'hfffe;
    LUT4 i1_4_lut_4_lut_then_3_lut (.A(buttons_debounced_syn[1]), .B(next_state[2]), 
         .C(next_state[1]), .Z(n2539)) /* synthesis lut_function=(!(A (B+!(C))+!A !(B+(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam i1_4_lut_4_lut_then_3_lut.init = 16'h7474;
    LUT4 i1_4_lut_4_lut_else_3_lut (.A(next_state[2]), .B(next_state_3__N_177[2]), 
         .Z(n2538)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam i1_4_lut_4_lut_else_3_lut.init = 16'hdddd;
    LUT4 mux_248_i7_4_lut (.A(next_state[1]), .B(n538), .C(n1001), .D(n973), 
         .Z(n1018)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam mux_248_i7_4_lut.init = 16'h0aca;
    LUT4 i38_4_lut_then_4_lut (.A(next_state[2]), .B(next_state[1]), .C(next_state[0]), 
         .D(buttons_debounced_syn[1]), .Z(n2542)) /* synthesis lut_function=(A (B+(C (D)))+!A !(B+(C))) */ ;
    defparam i38_4_lut_then_4_lut.init = 16'ha989;
    LUT4 next_state_2__bdd_4_lut (.A(next_state[2]), .B(next_state[0]), 
         .C(next_state[1]), .D(next_state_3__N_177[2]), .Z(n2556)) /* synthesis lut_function=(!(A (B+(C+!(D)))+!A (B+(C)))) */ ;
    defparam next_state_2__bdd_4_lut.init = 16'h0301;
    LUT4 next_state_3__N_177_2__bdd_4_lut (.A(next_state_3__N_177[2]), .B(next_state[0]), 
         .C(FPIO_isoCtrlRSTn_N_295), .D(next_state[2]), .Z(n2400)) /* synthesis lut_function=(!(A+(B (D)+!B !(C (D))))) */ ;
    defparam next_state_3__N_177_2__bdd_4_lut.init = 16'h1044;
    LUT4 i38_4_lut_else_4_lut (.A(next_state[2]), .B(next_state[1]), .C(next_state[0]), 
         .Z(n2541)) /* synthesis lut_function=(A (B)+!A !(B+!(C))) */ ;
    defparam i38_4_lut_else_4_lut.init = 16'h9898;
    LUT4 i9_4_lut (.A(\debounce_counters[1] [15]), .B(\debounce_counters[1] [27]), 
         .C(\debounce_counters[1] [23]), .D(\debounce_counters[1] [29]), 
         .Z(n25_adj_324)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i9_4_lut.init = 16'hfffe;
    LUT4 n2568_bdd_3_lut_4_lut (.A(FPIO_isoCtrlRSTn_N_295), .B(next_state[2]), 
         .C(next_state[1]), .D(n2568), .Z(n2569)) /* synthesis lut_function=(!(A (C+!(D))+!A (B (C+!(D))+!B !(C+(D))))) */ ;
    defparam n2568_bdd_3_lut_4_lut.init = 16'h1f10;
    LUT4 FPIO_isoCtrlRSTn_N_295_bdd_2_lut_1598 (.A(next_state_3__N_177[2]), 
         .B(next_state[0]), .Z(n2567)) /* synthesis lut_function=(A (B)+!A !(B)) */ ;
    defparam FPIO_isoCtrlRSTn_N_295_bdd_2_lut_1598.init = 16'h9999;
    LUT4 i1_2_lut_3_lut_adj_2 (.A(next_state[2]), .B(next_state[1]), .C(next_state[0]), 
         .Z(clk_enable_5)) /* synthesis lut_function=((B+(C))+!A) */ ;
    defparam i1_2_lut_3_lut_adj_2.init = 16'hfdfd;
    LUT4 i976_4_lut (.A(n5), .B(\debounce_counters[1] [13]), .C(\debounce_counters[1] [12]), 
         .D(n6), .Z(n1782)) /* synthesis lut_function=(A (B+(C))+!A (B+(C (D)))) */ ;
    defparam i976_4_lut.init = 16'hfcec;
    LUT4 i897_3_lut_4_lut (.A(n534), .B(next_state[3]), .C(n2453), .D(n973), 
         .Z(n1014)) /* synthesis lut_function=(A (B+!(C (D)))+!A (B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i897_3_lut_4_lut.init = 16'hcfef;
    LUT4 FPIO_isoCtrlRSTn_N_295_bdd_4_lut (.A(FPIO_isoCtrlRSTn_N_295), .B(buttons_debounced_syn[1]), 
         .C(next_state_3__N_177[2]), .D(next_state[0]), .Z(n2566)) /* synthesis lut_function=(!(A (B (C (D)+!C !(D))+!B !(C+(D)))+!A (B (C (D))))) */ ;
    defparam FPIO_isoCtrlRSTn_N_295_bdd_4_lut.init = 16'h3ff5;
    LUT4 pushed_1__I_0_1_lut (.A(pushed[1]), .Z(pushed_1__N_102)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(275[17] 279[24])
    defparam pushed_1__I_0_1_lut.init = 16'h5555;
    LUT4 i15_4_lut_adj_3 (.A(n25_adj_324), .B(n27_adj_322), .C(n26_adj_323), 
         .D(n28_adj_321), .Z(n2134)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i15_4_lut_adj_3.init = 16'hfffe;
    LUT4 mux_248_i9_4_lut (.A(n954), .B(n536), .C(n1001), .D(n973), 
         .Z(n1016)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam mux_248_i9_4_lut.init = 16'h0aca;
    LUT4 i1_4_lut_adj_4 (.A(\debounce_counters[0] [6]), .B(\debounce_counters[0] [11]), 
         .C(\debounce_counters[0] [8]), .D(\debounce_counters[0] [7]), .Z(n5_adj_331)) /* synthesis lut_function=(A (B+(C))+!A (B+(C (D)))) */ ;
    defparam i1_4_lut_adj_4.init = 16'hfcec;
    LUT4 i22_3_lut_4_lut (.A(next_state[1]), .B(next_state[0]), .C(n1537), 
         .D(next_state[3]), .Z(clk_enable_96)) /* synthesis lut_function=(A (C (D))+!A (B (C (D))+!B (C+!(D)))) */ ;
    defparam i22_3_lut_4_lut.init = 16'hf011;
    LUT4 mux_248_i10_4_lut (.A(next_state[1]), .B(n535), .C(n1001), .D(n973), 
         .Z(n1015)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam mux_248_i10_4_lut.init = 16'hfaca;
    LUT4 next_state_3__bdd_4_lut_4_lut (.A(next_state[3]), .B(next_state[0]), 
         .C(next_state[1]), .D(next_state[2]), .Z(FP_SysLEDg_N_285)) /* synthesis lut_function=(!(A (B+(C+(D)))+!A !(B ((D)+!C)+!B !(C+!(D))))) */ ;
    defparam next_state_3__bdd_4_lut_4_lut.init = 16'h4506;
    LUT4 i1_3_lut_4_lut (.A(next_state[0]), .B(next_state[2]), .C(buttons_debounced_syn[1]), 
         .D(n2231), .Z(n28_adj_329)) /* synthesis lut_function=(A (B ((D)+!C)+!B (D))) */ ;
    defparam i1_3_lut_4_lut.init = 16'haa08;
    LUT4 i21_4_lut (.A(n37_adj_318), .B(n39_adj_316), .C(n38_adj_317), 
         .D(n40_adj_314), .Z(FPIO_isoCtrlRSTn_N_295)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i21_4_lut.init = 16'hfffe;
    LUT4 i15_4_lut_adj_5 (.A(counter[17]), .B(counter[15]), .C(counter[14]), 
         .D(counter[2]), .Z(n37_adj_318)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i15_4_lut_adj_5.init = 16'hfffe;
    LUT4 next_state_3__bdd_2_lut_then_4_lut (.A(next_state[3]), .B(FPIO_isoCtrlRSTn_N_295), 
         .C(next_state[1]), .D(next_state[2]), .Z(n2548)) /* synthesis lut_function=(A+(B (C (D))+!B (C))) */ ;
    defparam next_state_3__bdd_2_lut_then_4_lut.init = 16'hfaba;
    CCU2D add_10_29 (.A0(\debounce_counters[0] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2093), .COUT(n2094), .S0(n21), 
          .S1(n20));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_29.INIT0 = 16'h5aaa;
    defparam add_10_29.INIT1 = 16'h5aaa;
    defparam add_10_29.INJECT1_0 = "NO";
    defparam add_10_29.INJECT1_1 = "NO";
    PFUMX i1549 (.BLUT(n2452), .ALUT(n2451), .C0(next_state[2]), .Z(n2453));
    LUT4 i935_2_lut_3_lut_4_lut (.A(n973), .B(next_state[3]), .C(n2453), 
         .D(n544), .Z(n1024)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i935_2_lut_3_lut_4_lut.init = 16'h1000;
    CCU2D add_10_27 (.A0(\debounce_counters[0] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2092), .COUT(n2093), .S0(n23), 
          .S1(n22));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_27.INIT0 = 16'h5aaa;
    defparam add_10_27.INIT1 = 16'h5aaa;
    defparam add_10_27.INJECT1_0 = "NO";
    defparam add_10_27.INJECT1_1 = "NO";
    CCU2D add_10_7 (.A0(\debounce_counters[0] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2082), .COUT(n2083), .S0(n43), 
          .S1(n42));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_7.INIT0 = 16'h5aaa;
    defparam add_10_7.INIT1 = 16'h5aaa;
    defparam add_10_7.INJECT1_0 = "NO";
    defparam add_10_7.INJECT1_1 = "NO";
    CCU2D add_19_23 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2106), .COUT(n2107), .S0(n133), 
          .S1(n132));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_23.INIT0 = 16'h5aaa;
    defparam add_19_23.INIT1 = 16'h5aaa;
    defparam add_19_23.INJECT1_0 = "NO";
    defparam add_19_23.INJECT1_1 = "NO";
    CCU2D add_10_5 (.A0(\debounce_counters[0] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2081), .COUT(n2082), .S0(n45), 
          .S1(n44));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_5.INIT0 = 16'h5aaa;
    defparam add_10_5.INIT1 = 16'h5aaa;
    defparam add_10_5.INJECT1_0 = "NO";
    defparam add_10_5.INJECT1_1 = "NO";
    CCU2D add_19_21 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2105), .COUT(n2106), .S0(n135), 
          .S1(n134));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_21.INIT0 = 16'h5aaa;
    defparam add_19_21.INIT1 = 16'h5aaa;
    defparam add_19_21.INJECT1_0 = "NO";
    defparam add_19_21.INJECT1_1 = "NO";
    LUT4 i1430_2_lut (.A(next_state[3]), .B(n1537), .Z(n1128)) /* synthesis lut_function=(A (B)) */ ;
    defparam i1430_2_lut.init = 16'h8888;
    CCU2D add_10_25 (.A0(\debounce_counters[0] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2091), .COUT(n2092), .S0(n25), 
          .S1(n24));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_25.INIT0 = 16'h5aaa;
    defparam add_10_25.INIT1 = 16'h5aaa;
    defparam add_10_25.INJECT1_0 = "NO";
    defparam add_10_25.INJECT1_1 = "NO";
    CCU2D add_10_23 (.A0(\debounce_counters[0] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2090), .COUT(n2091), .S0(n27), 
          .S1(n26));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_23.INIT0 = 16'h5aaa;
    defparam add_10_23.INIT1 = 16'h5aaa;
    defparam add_10_23.INJECT1_0 = "NO";
    defparam add_10_23.INJECT1_1 = "NO";
    CCU2D add_10_21 (.A0(\debounce_counters[0] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2089), .COUT(n2090), .S0(n29), 
          .S1(n28));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_21.INIT0 = 16'h5aaa;
    defparam add_10_21.INIT1 = 16'h5aaa;
    defparam add_10_21.INJECT1_0 = "NO";
    defparam add_10_21.INJECT1_1 = "NO";
    CCU2D add_19_19 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2104), .COUT(n2105), .S0(n137), 
          .S1(n136));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_19.INIT0 = 16'h5aaa;
    defparam add_19_19.INIT1 = 16'h5aaa;
    defparam add_19_19.INJECT1_0 = "NO";
    defparam add_19_19.INJECT1_1 = "NO";
    LUT4 next_state_3__bdd_2_lut_else_4_lut (.A(next_state[3]), .B(next_state_3__N_177[2]), 
         .C(next_state[1]), .D(next_state[2]), .Z(n2547)) /* synthesis lut_function=(A+!((C+(D))+!B)) */ ;
    defparam next_state_3__bdd_2_lut_else_4_lut.init = 16'haaae;
    LUT4 mux_248_i12_4_lut (.A(n954), .B(n533), .C(n1001), .D(n973), 
         .Z(n1013)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam mux_248_i12_4_lut.init = 16'hfaca;
    LUT4 i17_3_lut (.A(counter[5]), .B(n34_adj_320), .C(counter[18]), 
         .Z(n39_adj_316)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i17_3_lut.init = 16'hfefe;
    LUT4 i1506_4_lut (.A(next_state[3]), .B(FPIO_isoCtrlRSTn_N_295), .C(n2543), 
         .D(n19_adj_334), .Z(clk_enable_93)) /* synthesis lut_function=(A+!(B (C+(D))+!B (C))) */ ;
    defparam i1506_4_lut.init = 16'habaf;
    LUT4 i2_2_lut (.A(\debounce_counters[0] [9]), .B(\debounce_counters[0] [10]), 
         .Z(n6_adj_325)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2_2_lut.init = 16'heeee;
    LUT4 i2_3_lut (.A(PPn_VIN_c), .B(PG_Module_c), .C(PG_VIN_c), .Z(FP_UsrLED1_c)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(310[15:47])
    defparam i2_3_lut.init = 16'h8080;
    LUT4 i16_4_lut (.A(counter[21]), .B(counter[3]), .C(counter[11]), 
         .D(counter[19]), .Z(n38_adj_317)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i16_4_lut.init = 16'hfffe;
    LUT4 i9_4_lut_adj_6 (.A(\debounce_counters[0] [15]), .B(\debounce_counters[0] [28]), 
         .C(\debounce_counters[0] [24]), .D(\debounce_counters[0] [30]), 
         .Z(n25_adj_335)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i9_4_lut_adj_6.init = 16'hfffe;
    CCU2D add_19_17 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2103), .COUT(n2104), .S0(n139), 
          .S1(n138));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_17.INIT0 = 16'h5aaa;
    defparam add_19_17.INIT1 = 16'h5aaa;
    defparam add_19_17.INJECT1_0 = "NO";
    defparam add_19_17.INJECT1_1 = "NO";
    CCU2D add_10_19 (.A0(\debounce_counters[0] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2088), .COUT(n2089), .S0(n31), 
          .S1(n30));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_19.INIT0 = 16'h5aaa;
    defparam add_10_19.INIT1 = 16'h5aaa;
    defparam add_10_19.INJECT1_0 = "NO";
    defparam add_10_19.INJECT1_1 = "NO";
    CCU2D add_10_3 (.A0(\debounce_counters[0] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2080), .COUT(n2081), .S0(n47), 
          .S1(n46));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_3.INIT0 = 16'h5aaa;
    defparam add_10_3.INIT1 = 16'h5aaa;
    defparam add_10_3.INJECT1_0 = "NO";
    defparam add_10_3.INJECT1_1 = "NO";
    LUT4 mux_248_i14_4_lut (.A(n954), .B(n531), .C(n1001), .D(n973), 
         .Z(n1011)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam mux_248_i14_4_lut.init = 16'hfaca;
    LUT4 i18_4_lut (.A(counter[1]), .B(n36_adj_319), .C(n26_adj_315), 
         .D(counter[16]), .Z(n40_adj_314)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i18_4_lut.init = 16'hfffe;
    LUT4 next_state_3__bdd_2_lut_1519 (.A(next_state[3]), .B(n2390), .Z(clk_enable_4)) /* synthesis lut_function=(A+(B)) */ ;
    defparam next_state_3__bdd_2_lut_1519.init = 16'heeee;
    CCU2D add_19_15 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2102), .COUT(n2103), .S0(n141), 
          .S1(n140));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_15.INIT0 = 16'h5aaa;
    defparam add_19_15.INIT1 = 16'h5aaa;
    defparam add_19_15.INJECT1_0 = "NO";
    defparam add_19_15.INJECT1_1 = "NO";
    CCU2D add_10_17 (.A0(\debounce_counters[0] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2087), .COUT(n2088), .S0(n33), 
          .S1(n32));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_17.INIT0 = 16'h5aaa;
    defparam add_10_17.INIT1 = 16'h5aaa;
    defparam add_10_17.INJECT1_0 = "NO";
    defparam add_10_17.INJECT1_1 = "NO";
    CCU2D add_19_13 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2101), .COUT(n2102), .S0(n143), 
          .S1(n142));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_13.INIT0 = 16'h5aaa;
    defparam add_19_13.INIT1 = 16'h5aaa;
    defparam add_19_13.INJECT1_0 = "NO";
    defparam add_19_13.INJECT1_1 = "NO";
    CCU2D add_19_11 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2100), .COUT(n2101), .S0(n145), 
          .S1(n144));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_11.INIT0 = 16'h5aaa;
    defparam add_19_11.INIT1 = 16'h5aaa;
    defparam add_19_11.INJECT1_0 = "NO";
    defparam add_19_11.INJECT1_1 = "NO";
    CCU2D add_159_23 (.A0(counter[21]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n2122), 
          .S0(n523));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(402[17:24])
    defparam add_159_23.INIT0 = 16'h5555;
    defparam add_159_23.INIT1 = 16'h0000;
    defparam add_159_23.INJECT1_0 = "NO";
    defparam add_159_23.INJECT1_1 = "NO";
    CCU2D add_10_15 (.A0(\debounce_counters[0] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2086), .COUT(n2087), .S0(n35), 
          .S1(n34));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_15.INIT0 = 16'h5aaa;
    defparam add_10_15.INIT1 = 16'h5aaa;
    defparam add_10_15.INJECT1_0 = "NO";
    defparam add_10_15.INJECT1_1 = "NO";
    CCU2D add_19_9 (.A0(\debounce_counters[1] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2099), .COUT(n2100), .S0(n147), 
          .S1(n146));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_9.INIT0 = 16'h5aaa;
    defparam add_19_9.INIT1 = 16'h5aaa;
    defparam add_19_9.INJECT1_0 = "NO";
    defparam add_19_9.INJECT1_1 = "NO";
    CCU2D add_19_7 (.A0(\debounce_counters[1] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2098), .COUT(n2099), .S0(n149), 
          .S1(n148));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_7.INIT0 = 16'h5aaa;
    defparam add_19_7.INIT1 = 16'h5aaa;
    defparam add_19_7.INJECT1_0 = "NO";
    defparam add_19_7.INJECT1_1 = "NO";
    CCU2D add_159_21 (.A0(counter[19]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[20]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2121), .COUT(n2122), .S0(n525), .S1(n524));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(402[17:24])
    defparam add_159_21.INIT0 = 16'h5555;
    defparam add_159_21.INIT1 = 16'h5555;
    defparam add_159_21.INJECT1_0 = "NO";
    defparam add_159_21.INJECT1_1 = "NO";
    FD1P3IX counter__i2 (.D(n1022), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i2.GSR = "ENABLED";
    FD1P3IX counter__i3 (.D(n1021), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i3.GSR = "ENABLED";
    FD1P3IX counter__i4 (.D(n1020), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[4])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i4.GSR = "ENABLED";
    FD1P3IX counter__i5 (.D(n1019), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[5])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i5.GSR = "ENABLED";
    FD1P3IX counter__i6 (.D(n1018), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[6])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i6.GSR = "ENABLED";
    FD1P3IX counter__i7 (.D(n1017), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[7])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i7.GSR = "ENABLED";
    FD1P3IX counter__i8 (.D(n1016), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[8])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i8.GSR = "ENABLED";
    FD1P3IX counter__i9 (.D(n1015), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[9])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i9.GSR = "ENABLED";
    FD1P3IX counter__i10 (.D(n1014), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[10])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i10.GSR = "ENABLED";
    FD1P3IX counter__i11 (.D(n1013), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[11])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i11.GSR = "ENABLED";
    FD1P3IX counter__i12 (.D(n1012), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[12])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i12.GSR = "ENABLED";
    FD1P3IX counter__i13 (.D(n1011), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[13])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i13.GSR = "ENABLED";
    FD1P3IX counter__i14 (.D(n1010), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[14])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i14.GSR = "ENABLED";
    FD1P3IX counter__i15 (.D(n1009), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[15])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i15.GSR = "ENABLED";
    FD1P3IX counter__i16 (.D(n1008), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[16])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i16.GSR = "ENABLED";
    FD1P3IX counter__i17 (.D(n1007), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[17])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i17.GSR = "ENABLED";
    FD1P3IX counter__i18 (.D(n1006), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[18])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i18.GSR = "ENABLED";
    FD1P3IX counter__i19 (.D(n1005), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[19])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i19.GSR = "ENABLED";
    FD1P3IX counter__i20 (.D(n1004), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[20])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i20.GSR = "ENABLED";
    FD1P3IX counter__i21 (.D(n1003), .SP(clk_enable_91), .CD(n1128), .CK(clk), 
            .Q(counter[21])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam counter__i21.GSR = "ENABLED";
    CCU2D add_159_19 (.A0(counter[17]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[18]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2120), .COUT(n2121), .S0(n527), .S1(n526));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(402[17:24])
    defparam add_159_19.INIT0 = 16'h5555;
    defparam add_159_19.INIT1 = 16'h5555;
    defparam add_159_19.INJECT1_0 = "NO";
    defparam add_159_19.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_adj_7 (.A(next_state[3]), .B(next_state[2]), .C(next_state[0]), 
         .Z(Carrier_PwrOn_N_304)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(179[12:22])
    defparam i1_2_lut_3_lut_adj_7.init = 16'h1010;
    LUT4 i1_4_lut_adj_8 (.A(\debounce_counters[1] [6]), .B(\debounce_counters[1] [10]), 
         .C(\debounce_counters[1] [8]), .D(\debounce_counters[1] [7]), .Z(n5)) /* synthesis lut_function=(A (B+(C))+!A (B+(C (D)))) */ ;
    defparam i1_4_lut_adj_8.init = 16'hfcec;
    LUT4 i331_1_lut (.A(Carrier_PG_1V8_N_300), .Z(n1136)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(314[1] 429[13])
    defparam i331_1_lut.init = 16'h5555;
    CCU2D add_159_17 (.A0(counter[15]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[16]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2119), .COUT(n2120), .S0(n529), .S1(n528));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(402[17:24])
    defparam add_159_17.INIT0 = 16'h5555;
    defparam add_159_17.INIT1 = 16'h5555;
    defparam add_159_17.INJECT1_0 = "NO";
    defparam add_159_17.INJECT1_1 = "NO";
    LUT4 i2_2_lut_adj_9 (.A(\debounce_counters[1] [9]), .B(\debounce_counters[1] [11]), 
         .Z(n6)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2_2_lut_adj_9.init = 16'heeee;
    LUT4 next_state_3__bdd_2_lut_1560 (.A(next_state[3]), .B(n2453), .Z(n1001)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam next_state_3__bdd_2_lut_1560.init = 16'h4444;
    CCU2D add_159_15 (.A0(counter[13]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[14]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2118), .COUT(n2119), .S0(n531), .S1(n530));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(402[17:24])
    defparam add_159_15.INIT0 = 16'h5555;
    defparam add_159_15.INIT1 = 16'h5555;
    defparam add_159_15.INJECT1_0 = "NO";
    defparam add_159_15.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_adj_10 (.A(next_state[0]), .B(next_state[2]), .C(next_state_3__N_177[2]), 
         .Z(n2143)) /* synthesis lut_function=(!(A+((C)+!B))) */ ;
    defparam i1_2_lut_3_lut_adj_10.init = 16'h0404;
    LUT4 mux_248_i18_4_lut (.A(n954), .B(n527), .C(n1001), .D(n973), 
         .Z(n1007)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam mux_248_i18_4_lut.init = 16'hfaca;
    CCU2D add_10_13 (.A0(\debounce_counters[0] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2085), .COUT(n2086), .S0(n37), 
          .S1(n36));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_13.INIT0 = 16'h5aaa;
    defparam add_10_13.INIT1 = 16'h5aaa;
    defparam add_10_13.INJECT1_0 = "NO";
    defparam add_10_13.INJECT1_1 = "NO";
    CCU2D add_10_11 (.A0(\debounce_counters[0] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2084), .COUT(n2085), .S0(n39), 
          .S1(n38));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_11.INIT0 = 16'h5aaa;
    defparam add_10_11.INIT1 = 16'h5aaa;
    defparam add_10_11.INJECT1_0 = "NO";
    defparam add_10_11.INJECT1_1 = "NO";
    LUT4 i11_4_lut_adj_11 (.A(\debounce_counters[0] [26]), .B(\debounce_counters[0] [29]), 
         .C(\debounce_counters[0] [27]), .D(\debounce_counters[0] [18]), 
         .Z(n27_adj_327)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i11_4_lut_adj_11.init = 16'hfffe;
    LUT4 i10_4_lut (.A(\debounce_counters[0] [16]), .B(\debounce_counters[0] [22]), 
         .C(\debounce_counters[0] [20]), .D(\debounce_counters[0] [23]), 
         .Z(n26_adj_330)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i10_4_lut.init = 16'hfffe;
    CCU2D add_159_13 (.A0(counter[11]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[12]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2117), .COUT(n2118), .S0(n533), .S1(n532));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(402[17:24])
    defparam add_159_13.INIT0 = 16'h5555;
    defparam add_159_13.INIT1 = 16'h5555;
    defparam add_159_13.INJECT1_0 = "NO";
    defparam add_159_13.INJECT1_1 = "NO";
    CCU2D add_159_11 (.A0(counter[9]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[10]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2116), .COUT(n2117), .S0(n535), .S1(n534));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(402[17:24])
    defparam add_159_11.INIT0 = 16'h5555;
    defparam add_159_11.INIT1 = 16'h5555;
    defparam add_159_11.INJECT1_0 = "NO";
    defparam add_159_11.INJECT1_1 = "NO";
    LUT4 i12_4_lut_adj_12 (.A(\debounce_counters[0] [19]), .B(\debounce_counters[0] [25]), 
         .C(\debounce_counters[0] [21]), .D(\debounce_counters[0] [17]), 
         .Z(n28_adj_326)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i12_4_lut_adj_12.init = 16'hfffe;
    PFUMX i1579 (.BLUT(n2547), .ALUT(n2548), .C0(next_state[0]), .Z(clk_enable_97));
    LUT4 mux_248_i19_4_lut (.A(n954), .B(n526), .C(n1001), .D(n973), 
         .Z(n1006)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam mux_248_i19_4_lut.init = 16'hfaca;
    CCU2D add_19_5 (.A0(\debounce_counters[1] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2097), .COUT(n2098), .S0(n151), 
          .S1(n150));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_5.INIT0 = 16'h5aaa;
    defparam add_19_5.INIT1 = 16'h5aaa;
    defparam add_19_5.INJECT1_0 = "NO";
    defparam add_19_5.INJECT1_1 = "NO";
    LUT4 next_state_2__I_0_144_i7_3_lut_3_lut (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[2]), .Z(FP_SysLEDr_N_286)) /* synthesis lut_function=(A (B (C)+!B !(C))+!A (B+!(C))) */ ;
    defparam next_state_2__I_0_144_i7_3_lut_3_lut.init = 16'hc7c7;
    LUT4 mux_248_i20_4_lut (.A(n954), .B(n525), .C(n1001), .D(n973), 
         .Z(n1005)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam mux_248_i20_4_lut.init = 16'hfaca;
    LUT4 i12_4_lut_adj_13 (.A(counter[0]), .B(counter[12]), .C(counter[9]), 
         .D(counter[4]), .Z(n34_adj_320)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i12_4_lut_adj_13.init = 16'hfffe;
    CCU2D add_10_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[0] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n2080), .S1(n48));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_1.INIT0 = 16'hF000;
    defparam add_10_1.INIT1 = 16'h5555;
    defparam add_10_1.INJECT1_0 = "NO";
    defparam add_10_1.INJECT1_1 = "NO";
    LUT4 i946_2_lut_3_lut_4_lut (.A(n973), .B(next_state[3]), .C(n2453), 
         .D(n528), .Z(n1008)) /* synthesis lut_function=(A+(B+((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i946_2_lut_3_lut_4_lut.init = 16'hffef;
    FD1P3IX pushed_i1 (.D(n2681), .SP(pushed_1__N_93), .CD(button_inputs_asyn2[1]), 
            .CK(clk), .Q(pushed[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam pushed_i1.GSR = "ENABLED";
    LUT4 i1_4_lut_4_lut_4_lut_then_3_lut (.A(next_state[2]), .B(FPIO_isoCtrlRSTn_N_295), 
         .C(next_state[3]), .Z(n2554)) /* synthesis lut_function=(A (C)+!A ((C)+!B)) */ ;
    defparam i1_4_lut_4_lut_4_lut_then_3_lut.init = 16'hf1f1;
    LUT4 i14_4_lut (.A(counter[20]), .B(counter[10]), .C(counter[7]), 
         .D(counter[6]), .Z(n36_adj_319)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i14_4_lut.init = 16'hfffe;
    LUT4 mux_248_i21_4_lut (.A(n954), .B(n524), .C(n1001), .D(n973), 
         .Z(n1004)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam mux_248_i21_4_lut.init = 16'hfaca;
    FD1P3JX i117_138 (.D(n3), .SP(Carrier_PG_1V8_N_309), .PD(n1128), .CK(clk), 
            .Q(Carrier_PG_1V8_N_300));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam i117_138.GSR = "ENABLED";
    CCU2D add_10_9 (.A0(\debounce_counters[0] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2083), .COUT(n2084), .S0(n41), 
          .S1(n40));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_10_9.INIT0 = 16'h5aaa;
    defparam add_10_9.INIT1 = 16'h5aaa;
    defparam add_10_9.INJECT1_0 = "NO";
    defparam add_10_9.INJECT1_1 = "NO";
    FD1P3IX next_state_i1 (.D(n2441), .SP(clk_enable_92), .CD(n2152), 
            .CK(clk), .Q(next_state[1])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam next_state_i1.GSR = "ENABLED";
    CCU2D add_159_9 (.A0(counter[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[8]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2115), .COUT(n2116), .S0(n537), .S1(n536));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(402[17:24])
    defparam add_159_9.INIT0 = 16'h5555;
    defparam add_159_9.INIT1 = 16'h5555;
    defparam add_159_9.INJECT1_0 = "NO";
    defparam add_159_9.INJECT1_1 = "NO";
    FD1P3IX next_state_i2 (.D(n7), .SP(clk_enable_93), .CD(next_state[3]), 
            .CK(clk), .Q(next_state[2])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam next_state_i2.GSR = "ENABLED";
    FD1P3IX next_state_i3 (.D(n2143), .SP(clk_enable_94), .CD(n2152), 
            .CK(clk), .Q(next_state[3])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam next_state_i3.GSR = "ENABLED";
    LUT4 n1556_bdd_3_lut_4_lut_then_3_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(FPIO_isoCtrlRSTn_N_295), .Z(n2551)) /* synthesis lut_function=(A+(B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(179[12:22])
    defparam n1556_bdd_3_lut_4_lut_then_3_lut.init = 16'hefef;
    LUT4 pushed_0__I_0_1_lut (.A(pushed[0]), .Z(pushed_0__N_104)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(275[17] 279[24])
    defparam pushed_0__I_0_1_lut.init = 16'h5555;
    FD1P3IX next_state_i0 (.D(n2540), .SP(clk_enable_95), .CD(n2152), 
            .CK(clk), .Q(next_state[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam next_state_i0.GSR = "ENABLED";
    LUT4 i1_3_lut_4_lut_adj_14 (.A(next_state[1]), .B(next_state[3]), .C(next_state[0]), 
         .D(next_state[2]), .Z(n2158)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(179[12:22])
    defparam i1_3_lut_4_lut_adj_14.init = 16'heccc;
    FD1P3IX pushed_i0 (.D(n2681), .SP(pushed_1__N_98), .CD(button_inputs_asyn2[0]), 
            .CK(clk), .Q(pushed[0])) /* synthesis lse_init_val=0 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(256[9] 281[16])
    defparam pushed_i0.GSR = "ENABLED";
    LUT4 i1_2_lut_4_lut_adj_15 (.A(next_state[0]), .B(next_state[2]), .C(next_state_3__N_177[2]), 
         .D(next_state[1]), .Z(n19_adj_334)) /* synthesis lut_function=(A (D)+!A (B ((D)+!C)+!B (D))) */ ;
    defparam i1_2_lut_4_lut_adj_15.init = 16'hff04;
    OFS1P3IX FlexMIOs53_GPIO_PowerDown_127 (.D(FlexMIOs53_GPIO_PowerDown_N_303), 
            .SP(clk_enable_96), .SCLK(clk), .CD(n2557), .Q(FlexMIOs53_GPIO_PowerDown_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam FlexMIOs53_GPIO_PowerDown_127.GSR = "ENABLED";
    OFS1P3IX FPIO_isoCtrlRSTn_134 (.D(next_state[1]), .SP(clk_enable_97), 
            .SCLK(clk), .CD(n2158), .Q(FPIO_isoCtrlRSTn_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam FPIO_isoCtrlRSTn_134.GSR = "ENABLED";
    LUT4 n1556_bdd_3_lut_4_lut_else_3_lut (.A(next_state[3]), .B(next_state[2]), 
         .C(next_state_3__N_177[2]), .D(next_state[0]), .Z(n2550)) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(179[12:22])
    defparam n1556_bdd_3_lut_4_lut_else_3_lut.init = 16'hfefd;
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    LUT4 next_state_3__bdd_4_lut_1568 (.A(next_state_3__N_177[2]), .B(next_state[1]), 
         .C(next_state[2]), .D(next_state[0]), .Z(n2390)) /* synthesis lut_function=(A (B (C (D))+!B !(C))+!A (B (C (D)))) */ ;
    defparam next_state_3__bdd_4_lut_1568.init = 16'hc202;
    LUT4 i4_2_lut (.A(counter[13]), .B(counter[8]), .Z(n26_adj_315)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i4_2_lut.init = 16'heeee;
    LUT4 i1500_4_lut (.A(n16), .B(next_state[3]), .C(n28_adj_329), .D(n43_adj_328), 
         .Z(clk_enable_91)) /* synthesis lut_function=(A (B+!(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i1500_4_lut.init = 16'h888a;
    OFS1P3DX FP_SysLEDg_130 (.D(FP_SysLEDg_N_285), .SP(clk_enable_98), .SCLK(clk), 
            .CD(GND_net), .Q(FP_SysLEDg_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(316[2] 428[9])
    defparam FP_SysLEDg_130.GSR = "ENABLED";
    LUT4 i1_2_lut_3_lut_adj_16 (.A(next_state[2]), .B(next_state[1]), .C(next_state[0]), 
         .Z(n16)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(179[12:22])
    defparam i1_2_lut_3_lut_adj_16.init = 16'hfefe;
    LUT4 i955_3_lut (.A(next_state[2]), .B(next_state[1]), .C(next_state[0]), 
         .Z(FP_SysLEDb_N_287)) /* synthesis lut_function=(A (B (C))+!A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i955_3_lut.init = 16'hc4c4;
    LUT4 i1_2_lut_3_lut_4_lut (.A(next_state[3]), .B(next_state[2]), .C(next_state[1]), 
         .D(next_state[0]), .Z(clk_enable_7)) /* synthesis lut_function=(A (C+(D))+!A (B (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(179[12:22])
    defparam i1_2_lut_3_lut_4_lut.init = 16'heee0;
    LUT4 i900_3_lut_4_lut (.A(n523), .B(next_state[3]), .C(n2453), .D(n973), 
         .Z(n1003)) /* synthesis lut_function=(!(A (B+!(C))+!A (B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i900_3_lut_4_lut.init = 16'h3020;
    LUT4 i899_3_lut_4_lut (.A(n529), .B(next_state[3]), .C(n2453), .D(n973), 
         .Z(n1009)) /* synthesis lut_function=(A (B+!(C (D)))+!A (B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i899_3_lut_4_lut.init = 16'hcfef;
    LUT4 next_state_2__bdd_2_lut_1588 (.A(FPIO_isoCtrlRSTn_N_295), .B(next_state[1]), 
         .Z(n2452)) /* synthesis lut_function=(A (B)) */ ;
    defparam next_state_2__bdd_2_lut_1588.init = 16'h8888;
    LUT4 i3_4_lut (.A(n1957), .B(n954), .C(next_state[3]), .D(n2240), 
         .Z(n973)) /* synthesis lut_function=(!(((C+!(D))+!B)+!A)) */ ;
    defparam i3_4_lut.init = 16'h0800;
    LUT4 i867_2_lut (.A(next_state_3__N_177[2]), .B(FPIO_isoCtrlRSTn_N_295), 
         .Z(FlexMIOs53_GPIO_PowerDown_N_303)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(401[5] 408[12])
    defparam i867_2_lut.init = 16'heeee;
    LUT4 i1_2_lut_adj_17 (.A(next_state[0]), .B(next_state[2]), .Z(n2240)) /* synthesis lut_function=(A (B)) */ ;
    defparam i1_2_lut_adj_17.init = 16'h8888;
    CCU2D add_19_3 (.A0(\debounce_counters[1] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n2096), .COUT(n2097), .S0(n153), 
          .S1(n152));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(266[49:69])
    defparam add_19_3.INIT0 = 16'h5aaa;
    defparam add_19_3.INIT1 = 16'h5aaa;
    defparam add_19_3.INJECT1_0 = "NO";
    defparam add_19_3.INJECT1_1 = "NO";
    CCU2D add_159_7 (.A0(counter[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2114), .COUT(n2115), .S0(n539), .S1(n538));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(402[17:24])
    defparam add_159_7.INIT0 = 16'h5555;
    defparam add_159_7.INIT1 = 16'h5555;
    defparam add_159_7.INJECT1_0 = "NO";
    defparam add_159_7.INJECT1_1 = "NO";
    LUT4 i898_3_lut_4_lut (.A(n530), .B(next_state[3]), .C(n2453), .D(n973), 
         .Z(n1010)) /* synthesis lut_function=(!(A (B+!(C))+!A (B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i898_3_lut_4_lut.init = 16'h3020;
    VLO i1 (.Z(GND_net));
    LUT4 next_state_3__I_0_142_Mux_2_i7_4_lut_4_lut (.A(next_state[0]), .B(next_state[1]), 
         .C(next_state[2]), .D(next_state_3__N_177[2]), .Z(n7)) /* synthesis lut_function=(A (B+(C))+!A (C (D))) */ ;
    defparam next_state_3__I_0_142_Mux_2_i7_4_lut_4_lut.init = 16'hf8a8;
    CCU2D add_159_5 (.A0(counter[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n2113), .COUT(n2114), .S0(n541), .S1(n540));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(402[17:24])
    defparam add_159_5.INIT0 = 16'h5555;
    defparam add_159_5.INIT1 = 16'h5555;
    defparam add_159_5.INJECT1_0 = "NO";
    defparam add_159_5.INJECT1_1 = "NO";
    LUT4 i10_4_lut_adj_18 (.A(\debounce_counters[1] [30]), .B(\debounce_counters[1] [21]), 
         .C(\debounce_counters[1] [19]), .D(\debounce_counters[1] [22]), 
         .Z(n26_adj_323)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i10_4_lut_adj_18.init = 16'hfffe;
    TSALL TSALL_INST (.TSALL(GND_net));
    PFUMX i1575 (.BLUT(n2541), .ALUT(n2542), .C0(next_state_3__N_177[2]), 
          .Z(n2543));
    LUT4 i938_2_lut_3_lut_4_lut (.A(n973), .B(next_state[3]), .C(n2453), 
         .D(n543), .Z(n1023)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i938_2_lut_3_lut_4_lut.init = 16'h1000;
    LUT4 i48_4_lut (.A(next_state_3__N_177[2]), .B(next_state[2]), .C(next_state[1]), 
         .D(n1682), .Z(n43_adj_328)) /* synthesis lut_function=(A (B (C+!(D))+!B !(C+(D)))+!A (B (C+!(D))+!B !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(317[9] 427[18])
    defparam i48_4_lut.init = 16'hc1cf;
    PFUMX i1596 (.BLUT(n2569), .ALUT(n2564), .C0(next_state[3]), .Z(clk_enable_94));
    PFUMX i1573 (.BLUT(n2538), .ALUT(n2539), .C0(next_state[0]), .Z(n2540));
    LUT4 i1_4_lut_adj_19 (.A(next_state[1]), .B(next_state[2]), .C(FPIO_isoCtrlRSTn_N_295), 
         .D(next_state_3__N_177[2]), .Z(n2231)) /* synthesis lut_function=(A (B ((D)+!C)+!B !(C))+!A (B (D))) */ ;
    defparam i1_4_lut_adj_19.init = 16'hce0a;
    GSR GSR_INST (.GSR(VCC_net));
    
endmodule
//
// Verilog Description of module efb_vhdl
//

module efb_vhdl (clk, i2c1_sdaoen, i2c1_sdao, i2c1_scloen, i2c1_sclo, 
            i2c1_sdai, i2c1_scli, VCC_net, GND_net) /* synthesis NGD_DRC_MASK=1 */ ;
    input clk;
    output i2c1_sdaoen;
    output i2c1_sdao;
    output i2c1_scloen;
    output i2c1_sclo;
    input i2c1_sdai;
    input i2c1_scli;
    input VCC_net;
    input GND_net;
    
    wire clk /* synthesis is_clock=1, SET_AS_NETWORK=clk */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(172[9:12])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/efb_vhdl.vhd(31[12:21])
    
    EFB EFBInst_0 (.WBCLKI(clk), .WBRSTI(GND_net), .WBCYCI(GND_net), .WBSTBI(GND_net), 
        .WBWEI(GND_net), .WBADRI0(GND_net), .WBADRI1(GND_net), .WBADRI2(GND_net), 
        .WBADRI3(GND_net), .WBADRI4(GND_net), .WBADRI5(GND_net), .WBADRI6(GND_net), 
        .WBADRI7(GND_net), .WBDATI0(GND_net), .WBDATI1(GND_net), .WBDATI2(GND_net), 
        .WBDATI3(GND_net), .WBDATI4(GND_net), .WBDATI5(GND_net), .WBDATI6(GND_net), 
        .WBDATI7(GND_net), .I2C1SCLI(i2c1_scli), .I2C1SDAI(i2c1_sdai), 
        .I2C2SCLI(GND_net), .I2C2SDAI(GND_net), .SPISCKI(GND_net), .SPIMISOI(GND_net), 
        .SPIMOSII(GND_net), .SPISCSN(GND_net), .TCCLKI(GND_net), .TCRSTN(GND_net), 
        .TCIC(GND_net), .UFMSN(VCC_net), .PLL0DATI0(GND_net), .PLL0DATI1(GND_net), 
        .PLL0DATI2(GND_net), .PLL0DATI3(GND_net), .PLL0DATI4(GND_net), 
        .PLL0DATI5(GND_net), .PLL0DATI6(GND_net), .PLL0DATI7(GND_net), 
        .PLL0ACKI(GND_net), .PLL1DATI0(GND_net), .PLL1DATI1(GND_net), 
        .PLL1DATI2(GND_net), .PLL1DATI3(GND_net), .PLL1DATI4(GND_net), 
        .PLL1DATI5(GND_net), .PLL1DATI6(GND_net), .PLL1DATI7(GND_net), 
        .PLL1ACKI(GND_net), .I2C1SCLO(i2c1_sclo), .I2C1SCLOEN(i2c1_scloen), 
        .I2C1SDAO(i2c1_sdao), .I2C1SDAOEN(i2c1_sdaoen)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=21, LSE_LCOL=8, LSE_RCOL=16, LSE_LLINE=226, LSE_RLINE=226 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/power_on_debounce.vhd(226[8:16])
    defparam EFBInst_0.EFB_I2C1 = "ENABLED";
    defparam EFBInst_0.EFB_I2C2 = "DISABLED";
    defparam EFBInst_0.EFB_SPI = "DISABLED";
    defparam EFBInst_0.EFB_TC = "DISABLED";
    defparam EFBInst_0.EFB_TC_PORTMODE = "WB";
    defparam EFBInst_0.EFB_UFM = "DISABLED";
    defparam EFBInst_0.EFB_WB_CLK_FREQ = "50.0";
    defparam EFBInst_0.DEV_DENSITY = "4000L";
    defparam EFBInst_0.UFM_INIT_PAGES = 0;
    defparam EFBInst_0.UFM_INIT_START_PAGE = 0;
    defparam EFBInst_0.UFM_INIT_ALL_ZEROS = "ENABLED";
    defparam EFBInst_0.UFM_INIT_FILE_NAME = "NONE";
    defparam EFBInst_0.UFM_INIT_FILE_FORMAT = "HEX";
    defparam EFBInst_0.I2C1_ADDRESSING = "7BIT";
    defparam EFBInst_0.I2C2_ADDRESSING = "7BIT";
    defparam EFBInst_0.I2C1_SLAVE_ADDR = "0b1010101";
    defparam EFBInst_0.I2C2_SLAVE_ADDR = "0b1010101";
    defparam EFBInst_0.I2C1_BUS_PERF = "400kHz";
    defparam EFBInst_0.I2C2_BUS_PERF = "100kHz";
    defparam EFBInst_0.I2C1_CLK_DIVIDER = 32;
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

