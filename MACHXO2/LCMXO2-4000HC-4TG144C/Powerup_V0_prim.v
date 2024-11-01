// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Wed Oct 30 13:45:19 2024
//
// Verilog Description of module Powerup_V0
//

module Powerup_V0 (RESET, FP_SysLEDg, FP_SysLEDr, FP_SysLEDb, Carrier_PG_3V3, 
            FPIO_FlexMIO52, FPIO_ExternalStop, SysSW_Pwr_NC, FP_UsrSW1, 
            FP_UsrSW2, FP_UsrSW3, FP_UsrLED1, FP_UsrLED2, FP_UsrLED3, 
            FP_UsrLED4, Carrier_PG_1V8, SD0_CD, SD1_CD, SD_SEL, FlexMIOs52_PCIe, 
            FlexMio61ExternalStop, Carrier_PwrOn, PG_Module, ENB_Ctrl_out, 
            ENB_Sys_out, STOP_out, State_LED);   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(8[8:18])
    input RESET;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(11[3:8])
    output FP_SysLEDg;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(14[3:13])
    output FP_SysLEDr;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(15[3:13])
    output FP_SysLEDb;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(16[3:13])
    output Carrier_PG_3V3;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(17[3:17])
    output FPIO_FlexMIO52;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(18[3:17])
    input FPIO_ExternalStop;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(19[3:20])
    input SysSW_Pwr_NC;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(21[3:15])
    input FP_UsrSW1;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(22[3:12])
    input FP_UsrSW2;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(23[3:12])
    input FP_UsrSW3;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(24[3:12])
    output FP_UsrLED1;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(27[3:13])
    output FP_UsrLED2;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(28[3:13])
    output FP_UsrLED3;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(29[3:13])
    output FP_UsrLED4;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(30[3:13])
    output Carrier_PG_1V8;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(31[3:17])
    input SD0_CD;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(32[3:9])
    input SD1_CD;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(33[3:9])
    output SD_SEL;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(36[3:9])
    input FlexMIOs52_PCIe;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(37[3:18])
    output FlexMio61ExternalStop;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(38[3:24])
    output Carrier_PwrOn;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(45[9:22])
    input PG_Module;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(46[3:12])
    output ENB_Ctrl_out;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(49[3:15])
    output ENB_Sys_out;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(50[9:20])
    output STOP_out;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(51[9:17])
    output [3:0]State_LED;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(53[3:12])
    
    wire clk /* synthesis SET_AS_NETWORK=clk, is_clock=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(59[9:12])
    
    wire GND_net, VCC_net, RESET_c, FPIO_FlexMIO52_c_c, FlexMio61ExternalStop_c_c, 
        SysSW_Pwr_NC_c, FP_UsrSW1_c, FP_UsrSW2_c, FP_UsrSW3_c, FP_UsrLED1_c, 
        n1401, Carrier_PwrOn_c, ENB_Ctrl_out_c, ENB_Sys_out_c, State_LED_c, 
        State_LED_0_1, State_LED_0_0;
    wire [17:0]count_100ms;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(60[9:20])
    
    wire clk_enable_27;
    wire [16:0]count_50ms;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(61[9:19])
    
    wire count_done_100ms, reset_triggered;
    wire [2:0]current_state;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(68[12:25])
    wire [2:0]next_state;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(68[27:37])
    wire [31:0]\debounce_counters[0] ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[12:29])
    wire [31:0]\debounce_counters[1] ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[12:29])
    wire [31:0]\debounce_counters[2] ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[12:29])
    wire [31:0]\debounce_counters[3] ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[12:29])
    
    wire count_done_100ms_N_191, clk_enable_12, n1746, n1830, n1482, 
        n18, n17, n16, n15, n1745, n1744, n14, count_done_100ms_N_193, 
        FP_UsrLED1_N_352, n84, n83, n82, n13, n12, n11, n10, 
        n9, n1743, n80, n1742, n8, n79, n1368, n1361, n1366, 
        n78, n1741, n1364, Carrier_PG_1V8_N_359, Carrier_PG_1V8_N_375, 
        Carrier_PG_1V8_N_360, n222, n223, n224, n225, n226, n227, 
        n228, n229, n230, n231, n232, n233, n234, n235, n236, 
        n237, n238, n239, n240, n241, n242, n243, n244, n245, 
        n246, n247, n248, n249, n250, n251, n252, n253, n1834, 
        n1776, n1775, n1774, n1773, n1772, n1771, n1770, n1769, 
        n1768, n1767, n1766, n1765, n1764, n1763, n1762, n1761, 
        n1760, n1759, n1758, n1757, n1756, n1755, n1754, n1753, 
        n327, n328, n329, n330, n331, n332, n333, n334, n335, 
        n336, n337, n338, n339, n340, n341, n342, n343, n344, 
        n345, n346, n347, n348, n349, n350, n351, n352, n353, 
        n354, n355, n356, n357, n358, n1752, n1751, n1750, n1749, 
        n1748, n1747, n1740, n1739, n1738, n1737, n1736, n1735, 
        n1734, n1733, n1732, n1731, n1730, n1729, n1727, n1726, 
        n1725, n1724, n1723, n1722, n1721, n1720, n1719, n1718, 
        n1717, n81, n1716, n1715, n432, n433, n434, n435, n436, 
        n437, n438, n439, n440, n441, n442, n443, n444, n445, 
        n446, n447, n448, n449, n450, n451, n452, n453, n454, 
        n455, n456, n457, n458, n459, n460, n461, n462, n463, 
        n1714, n1713, n1712, n1711, n1710, n1709, n1708, n1707, 
        n1706, n1705, n1704, n1703, n1702, n1701, n1700, n1699, 
        n1698, n1697, n1696, n1695, n1694, n1693, n1692, n1691, 
        n1690, n1689, n1688, n1687, n1686, n1685, n1684, n1683, 
        n1682, n537, n538, n539, n540, n541, n542, n543, n544, 
        n545, n546, n547, n548, n549, n550, n551, n552, n553, 
        n554, n555, n556, n557, n558, n559, n560, n561, n562, 
        n563, n564, n565, n566, n567, n568, n1681, n1680, n1679, 
        n1678, n1677, n1676, n1675, n1674, n1673, n1672, n1671, 
        n1670, n1669, n1668, n1667, n1666, n1665, n1664, n1663, 
        n1662, n1661, n1660, n1659, n1658, n1657, n1510, n1656, 
        n1655, n1370, clk_enable_3;
    wire [2:0]next_state_2__N_41;
    
    wire n1836, n1833, n8_adj_1, clk_enable_13, n17_adj_2, n16_adj_3, 
        n15_adj_4, n14_adj_5, n13_adj_6, n12_adj_7, n11_adj_8, n10_adj_9, 
        n9_adj_10, n8_adj_11, n1450, n1832, n1654, clk_enable_133, 
        n1403, clk_enable_136, n1653, n1449, n3, n1652, clk_enable_134, 
        n95, n94, n93, n92, n91, n90, n89, n88, n87, n86, 
        n85, n1651, n6, clk_enable_137, n1650, clk_enable_132, n1649, 
        n74, n75, n76, n77, n78_adj_12, n79_adj_13, n80_adj_14, 
        n81_adj_15, n82_adj_16, n83_adj_17, n84_adj_18, n85_adj_19, 
        n86_adj_20, n87_adj_21, n88_adj_22, n89_adj_23, n90_adj_24, 
        n1648, n1831, clk_enable_101, clk_enable_57, n1647, clk_enable_135;
    
    VHI i477 (.Z(VCC_net));
    LUT4 i466_2_lut (.A(clk_enable_133), .B(FP_UsrSW2_c), .Z(clk_enable_101)) /* synthesis lut_function=(!(A (B))) */ ;
    defparam i466_2_lut.init = 16'h7777;
    FD1P3IX debounce_counters_3___i16 (.D(n552), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [16])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i16.GSR = "ENABLED";
    CCU2D add_68_5 (.A0(\debounce_counters[1] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1664), .COUT(n1665), .S0(n355), 
          .S1(n354));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_5.INIT0 = 16'h5aaa;
    defparam add_68_5.INIT1 = 16'h5aaa;
    defparam add_68_5.INJECT1_0 = "NO";
    defparam add_68_5.INJECT1_1 = "NO";
    CCU2D add_60_7 (.A0(\debounce_counters[0] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1649), .COUT(n1650), .S0(n248), 
          .S1(n247));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_7.INIT0 = 16'h5aaa;
    defparam add_60_7.INIT1 = 16'h5aaa;
    defparam add_60_7.INJECT1_0 = "NO";
    defparam add_60_7.INJECT1_1 = "NO";
    LUT4 count_done_100ms_I_0_137_1_lut (.A(count_done_100ms), .Z(count_done_100ms_N_191)) /* synthesis lut_function=(!(A)) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(117[16:36])
    defparam count_done_100ms_I_0_137_1_lut.init = 16'h5555;
    LUT4 i1_2_lut_4_lut (.A(Carrier_PwrOn_c), .B(current_state[2]), .C(current_state[1]), 
         .D(n1834), .Z(clk_enable_13)) /* synthesis lut_function=(A+(B+((D)+!C))) */ ;
    defparam i1_2_lut_4_lut.init = 16'hffef;
    FD1P3IX debounce_counters_3___i15 (.D(n553), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [15])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i15.GSR = "ENABLED";
    FD1P3AX i52_121 (.D(count_done_100ms_N_191), .SP(clk_enable_3), .CK(clk), 
            .Q(Carrier_PG_1V8_N_360));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(116[9] 136[16])
    defparam i52_121.GSR = "DISABLED";
    LUT4 i317_2_lut_rep_12 (.A(next_state_2__N_41[1]), .B(current_state[0]), 
         .Z(n1834)) /* synthesis lut_function=(A+(B)) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(183[9] 214[18])
    defparam i317_2_lut_rep_12.init = 16'heeee;
    CCU2D add_68_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[1] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n1663), .S1(n358));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_1.INIT0 = 16'hF000;
    defparam add_68_1.INIT1 = 16'h5555;
    defparam add_68_1.INJECT1_0 = "NO";
    defparam add_68_1.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i14 (.D(n554), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [14])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i14.GSR = "ENABLED";
    CCU2D add_60_33 (.A0(\debounce_counters[0] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n1662), .S0(n222));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_33.INIT0 = 16'h5aaa;
    defparam add_60_33.INIT1 = 16'h0000;
    defparam add_60_33.INJECT1_0 = "NO";
    defparam add_60_33.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i0 (.D(n568), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [0])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i0.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i0 (.D(n358), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [0])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i0.GSR = "ENABLED";
    LUT4 i469_2_lut (.A(clk_enable_134), .B(FP_UsrSW1_c), .Z(clk_enable_132)) /* synthesis lut_function=(!(A (B))) */ ;
    defparam i469_2_lut.init = 16'h7777;
    CCU2D add_60_17 (.A0(\debounce_counters[0] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1654), .COUT(n1655), .S0(n238), 
          .S1(n237));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_17.INIT0 = 16'h5aaa;
    defparam add_60_17.INIT1 = 16'h5aaa;
    defparam add_60_17.INJECT1_0 = "NO";
    defparam add_60_17.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i13 (.D(n555), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [13])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i18 (.D(n550), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [18])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i12 (.D(n556), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [12])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i12.GSR = "ENABLED";
    FD1P3AX count_done_100ms_116 (.D(n1836), .SP(count_done_100ms_N_193), 
            .CK(clk), .Q(count_done_100ms)) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(116[9] 136[16])
    defparam count_done_100ms_116.GSR = "DISABLED";
    LUT4 i2_3_lut (.A(count_100ms[14]), .B(count_100ms[17]), .C(count_100ms[13]), 
         .Z(n8_adj_1)) /* synthesis lut_function=(A (B (C))) */ ;
    defparam i2_3_lut.init = 16'h8080;
    CCU2D add_425_26 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n1776), .S1(clk_enable_133));
    defparam add_425_26.INIT0 = 16'hf555;
    defparam add_425_26.INIT1 = 16'h0000;
    defparam add_425_26.INJECT1_0 = "NO";
    defparam add_425_26.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_2___i0 (.D(n463), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [0])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i0.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i11 (.D(n557), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [11])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i11.GSR = "ENABLED";
    CCU2D add_425_24 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1775), .COUT(n1776));
    defparam add_425_24.INIT0 = 16'h5555;
    defparam add_425_24.INIT1 = 16'h5555;
    defparam add_425_24.INJECT1_0 = "NO";
    defparam add_425_24.INJECT1_1 = "NO";
    FD1P3IX button_stables_i1 (.D(n1836), .SP(clk_enable_12), .CD(n1370), 
            .CK(clk), .Q(Carrier_PwrOn_c)) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam button_stables_i1.GSR = "ENABLED";
    CCU2D add_425_22 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1774), .COUT(n1775));
    defparam add_425_22.INIT0 = 16'h5555;
    defparam add_425_22.INIT1 = 16'h5555;
    defparam add_425_22.INJECT1_0 = "NO";
    defparam add_425_22.INJECT1_1 = "NO";
    CCU2D add_425_20 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1773), .COUT(n1774));
    defparam add_425_20.INIT0 = 16'h5555;
    defparam add_425_20.INIT1 = 16'h5555;
    defparam add_425_20.INJECT1_0 = "NO";
    defparam add_425_20.INJECT1_1 = "NO";
    LUT4 i2_3_lut_4_lut (.A(count_50ms[10]), .B(count_50ms[11]), .C(n1449), 
         .D(FP_UsrLED1_N_352), .Z(Carrier_PG_1V8_N_375)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;
    defparam i2_3_lut_4_lut.init = 16'he000;
    CCU2D add_60_31 (.A0(\debounce_counters[0] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1661), .COUT(n1662), .S0(n224), 
          .S1(n223));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_31.INIT0 = 16'h5aaa;
    defparam add_60_31.INIT1 = 16'h5aaa;
    defparam add_60_31.INJECT1_0 = "NO";
    defparam add_60_31.INJECT1_1 = "NO";
    CCU2D add_425_18 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1772), .COUT(n1773));
    defparam add_425_18.INIT0 = 16'h5555;
    defparam add_425_18.INIT1 = 16'h5555;
    defparam add_425_18.INJECT1_0 = "NO";
    defparam add_425_18.INJECT1_1 = "NO";
    FD1P3AX current_state_i0 (.D(next_state[0]), .SP(clk_enable_13), .CK(clk), 
            .Q(current_state[0]));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(172[9] 176[16])
    defparam current_state_i0.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i10 (.D(n558), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [10])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i10.GSR = "ENABLED";
    FD1P3IX current_state_i1 (.D(n3), .SP(clk_enable_136), .CD(current_state[2]), 
            .CK(clk), .Q(current_state[1]));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(172[9] 176[16])
    defparam current_state_i1.GSR = "ENABLED";
    CCU2D add_425_16 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1771), .COUT(n1772));
    defparam add_425_16.INIT0 = 16'h5555;
    defparam add_425_16.INIT1 = 16'h5555;
    defparam add_425_16.INJECT1_0 = "NO";
    defparam add_425_16.INJECT1_1 = "NO";
    OB FP_SysLEDr_pad (.I(GND_net), .O(FP_SysLEDr));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(15[3:13])
    FD1P3IX debounce_counters_3___i9 (.D(n559), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [9])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i9.GSR = "ENABLED";
    CCU2D add_60_29 (.A0(\debounce_counters[0] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1660), .COUT(n1661), .S0(n226), 
          .S1(n225));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_29.INIT0 = 16'h5aaa;
    defparam add_60_29.INIT1 = 16'h5aaa;
    defparam add_60_29.INJECT1_0 = "NO";
    defparam add_60_29.INJECT1_1 = "NO";
    LUT4 i247_1_lut (.A(FP_UsrSW1_c), .Z(n1366)) /* synthesis lut_function=(!(A)) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(22[3:12])
    defparam i247_1_lut.init = 16'h5555;
    FD1P3IX debounce_counters_3___i8 (.D(n560), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [8])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i7 (.D(n561), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [7])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i6 (.D(n562), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [6])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i6.GSR = "ENABLED";
    CCU2D add_60_5 (.A0(\debounce_counters[0] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1648), .COUT(n1649), .S0(n250), 
          .S1(n249));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_5.INIT0 = 16'h5aaa;
    defparam add_60_5.INIT1 = 16'h5aaa;
    defparam add_60_5.INJECT1_0 = "NO";
    defparam add_60_5.INJECT1_1 = "NO";
    CCU2D add_60_3 (.A0(\debounce_counters[0] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1647), .COUT(n1648), .S0(n252), 
          .S1(n251));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_3.INIT0 = 16'h5aaa;
    defparam add_60_3.INIT1 = 16'h5aaa;
    defparam add_60_3.INJECT1_0 = "NO";
    defparam add_60_3.INJECT1_1 = "NO";
    CCU2D add_60_27 (.A0(\debounce_counters[0] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1659), .COUT(n1660), .S0(n228), 
          .S1(n227));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_27.INIT0 = 16'h5aaa;
    defparam add_60_27.INIT1 = 16'h5aaa;
    defparam add_60_27.INJECT1_0 = "NO";
    defparam add_60_27.INJECT1_1 = "NO";
    OB FP_SysLEDg_pad (.I(GND_net), .O(FP_SysLEDg));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(14[3:13])
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk)) /* synthesis NOM_FREQ="2.08", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "2.08";
    FD1P3IX debounce_counters_3___i5 (.D(n563), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [5])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i5.GSR = "ENABLED";
    CCU2D add_60_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[0] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n1647), .S1(n253));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_1.INIT0 = 16'hF000;
    defparam add_60_1.INIT1 = 16'h5555;
    defparam add_60_1.INJECT1_0 = "NO";
    defparam add_60_1.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i4 (.D(n564), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [4])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i4.GSR = "ENABLED";
    CCU2D add_60_25 (.A0(\debounce_counters[0] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1658), .COUT(n1659), .S0(n230), 
          .S1(n229));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_25.INIT0 = 16'h5aaa;
    defparam add_60_25.INIT1 = 16'h5aaa;
    defparam add_60_25.INJECT1_0 = "NO";
    defparam add_60_25.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_3___i3 (.D(n565), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [3])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i2 (.D(n566), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [2])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i1 (.D(n567), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [1])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i1.GSR = "ENABLED";
    FD1P3AX count_100ms_228__i0 (.D(n95), .SP(count_done_100ms_N_191), .CK(clk), 
            .Q(n18)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i0.GSR = "DISABLED";
    LUT4 current_state_2__I_0_133_Mux_0_i7_4_lut_4_lut (.A(next_state_2__N_41[1]), 
         .B(current_state[0]), .C(current_state[1]), .D(current_state[2]), 
         .Z(next_state[0])) /* synthesis lut_function=(!(A (B (C (D)+!C !(D))+!B (C (D)))+!A (B (C (D)+!C !(D))+!B (C)))) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(183[9] 214[18])
    defparam current_state_2__I_0_133_Mux_0_i7_4_lut_4_lut.init = 16'h0fe3;
    CCU2D add_425_14 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1770), .COUT(n1771));
    defparam add_425_14.INIT0 = 16'h5aaa;
    defparam add_425_14.INIT1 = 16'h5555;
    defparam add_425_14.INJECT1_0 = "NO";
    defparam add_425_14.INJECT1_1 = "NO";
    CCU2D add_425_12 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1769), .COUT(n1770));
    defparam add_425_12.INIT0 = 16'h5aaa;
    defparam add_425_12.INIT1 = 16'h5aaa;
    defparam add_425_12.INJECT1_0 = "NO";
    defparam add_425_12.INJECT1_1 = "NO";
    CCU2D add_425_10 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1768), .COUT(n1769));
    defparam add_425_10.INIT0 = 16'h5555;
    defparam add_425_10.INIT1 = 16'h5aaa;
    defparam add_425_10.INJECT1_0 = "NO";
    defparam add_425_10.INJECT1_1 = "NO";
    CCU2D add_425_8 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1767), .COUT(n1768));
    defparam add_425_8.INIT0 = 16'h5555;
    defparam add_425_8.INIT1 = 16'h5aaa;
    defparam add_425_8.INJECT1_0 = "NO";
    defparam add_425_8.INJECT1_1 = "NO";
    CCU2D add_425_6 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1766), .COUT(n1767));
    defparam add_425_6.INIT0 = 16'h5555;
    defparam add_425_6.INIT1 = 16'h5555;
    defparam add_425_6.INJECT1_0 = "NO";
    defparam add_425_6.INJECT1_1 = "NO";
    CCU2D add_425_4 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1765), .COUT(n1766));
    defparam add_425_4.INIT0 = 16'h5aaa;
    defparam add_425_4.INIT1 = 16'h5555;
    defparam add_425_4.INJECT1_0 = "NO";
    defparam add_425_4.INJECT1_1 = "NO";
    CCU2D add_425_2 (.A0(\debounce_counters[1] [7]), .B0(\debounce_counters[1] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[1] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n1765));
    defparam add_425_2.INIT0 = 16'h1000;
    defparam add_425_2.INIT1 = 16'h5555;
    defparam add_425_2.INJECT1_0 = "NO";
    defparam add_425_2.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut (.A(current_state[2]), .B(current_state[0]), .C(current_state[1]), 
         .Z(State_LED_c)) /* synthesis lut_function=(A (C)+!A !(B+!(C))) */ ;
    defparam i1_2_lut_3_lut.init = 16'hb0b0;
    LUT4 i394_2_lut (.A(count_100ms[11]), .B(count_100ms[12]), .Z(n1510)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i394_2_lut.init = 16'heeee;
    CCU2D add_426_26 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n1764), .S1(clk_enable_134));
    defparam add_426_26.INIT0 = 16'hf555;
    defparam add_426_26.INIT1 = 16'h0000;
    defparam add_426_26.INJECT1_0 = "NO";
    defparam add_426_26.INJECT1_1 = "NO";
    CCU2D add_60_23 (.A0(\debounce_counters[0] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1657), .COUT(n1658), .S0(n232), 
          .S1(n231));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_23.INIT0 = 16'h5aaa;
    defparam add_60_23.INIT1 = 16'h5aaa;
    defparam add_60_23.INJECT1_0 = "NO";
    defparam add_60_23.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_0___i1 (.D(n252), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [1])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i1.GSR = "ENABLED";
    CCU2D add_426_24 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1763), .COUT(n1764));
    defparam add_426_24.INIT0 = 16'h5555;
    defparam add_426_24.INIT1 = 16'h5555;
    defparam add_426_24.INJECT1_0 = "NO";
    defparam add_426_24.INJECT1_1 = "NO";
    LUT4 i2_3_lut_adj_1 (.A(next_state_2__N_41[1]), .B(current_state[0]), 
         .C(n1833), .Z(clk_enable_136)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i2_3_lut_adj_1.init = 16'hfefe;
    LUT4 count_done_100ms_I_0_2_lut (.A(count_done_100ms), .B(reset_triggered), 
         .Z(FP_UsrLED1_N_352)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(126[19:59])
    defparam count_done_100ms_I_0_2_lut.init = 16'h2222;
    LUT4 i242_1_lut (.A(FP_UsrSW3_c), .Z(n1370)) /* synthesis lut_function=(!(A)) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(24[3:12])
    defparam i242_1_lut.init = 16'h5555;
    CCU2D add_426_22 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1762), .COUT(n1763));
    defparam add_426_22.INIT0 = 16'h5555;
    defparam add_426_22.INIT1 = 16'h5555;
    defparam add_426_22.INJECT1_0 = "NO";
    defparam add_426_22.INJECT1_1 = "NO";
    CCU2D add_426_20 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1761), .COUT(n1762));
    defparam add_426_20.INIT0 = 16'h5555;
    defparam add_426_20.INIT1 = 16'h5555;
    defparam add_426_20.INJECT1_0 = "NO";
    defparam add_426_20.INJECT1_1 = "NO";
    CCU2D add_426_18 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1760), .COUT(n1761));
    defparam add_426_18.INIT0 = 16'h5555;
    defparam add_426_18.INIT1 = 16'h5555;
    defparam add_426_18.INJECT1_0 = "NO";
    defparam add_426_18.INJECT1_1 = "NO";
    CCU2D add_60_21 (.A0(\debounce_counters[0] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1656), .COUT(n1657), .S0(n234), 
          .S1(n233));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_21.INIT0 = 16'h5aaa;
    defparam add_60_21.INIT1 = 16'h5aaa;
    defparam add_60_21.INJECT1_0 = "NO";
    defparam add_60_21.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_0___i0 (.D(n253), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [0])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i0.GSR = "ENABLED";
    CCU2D add_426_16 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1759), .COUT(n1760));
    defparam add_426_16.INIT0 = 16'h5555;
    defparam add_426_16.INIT1 = 16'h5555;
    defparam add_426_16.INJECT1_0 = "NO";
    defparam add_426_16.INJECT1_1 = "NO";
    CCU2D add_426_14 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1758), .COUT(n1759));
    defparam add_426_14.INIT0 = 16'h5aaa;
    defparam add_426_14.INIT1 = 16'h5555;
    defparam add_426_14.INJECT1_0 = "NO";
    defparam add_426_14.INJECT1_1 = "NO";
    CCU2D add_60_19 (.A0(\debounce_counters[0] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1655), .COUT(n1656), .S0(n236), 
          .S1(n235));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_19.INIT0 = 16'h5aaa;
    defparam add_60_19.INIT1 = 16'h5aaa;
    defparam add_60_19.INJECT1_0 = "NO";
    defparam add_60_19.INJECT1_1 = "NO";
    CCU2D add_426_12 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1757), .COUT(n1758));
    defparam add_426_12.INIT0 = 16'h5aaa;
    defparam add_426_12.INIT1 = 16'h5aaa;
    defparam add_426_12.INJECT1_0 = "NO";
    defparam add_426_12.INJECT1_1 = "NO";
    CCU2D add_60_15 (.A0(\debounce_counters[0] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1653), .COUT(n1654), .S0(n240), 
          .S1(n239));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_15.INIT0 = 16'h5aaa;
    defparam add_60_15.INIT1 = 16'h5aaa;
    defparam add_60_15.INJECT1_0 = "NO";
    defparam add_60_15.INJECT1_1 = "NO";
    CCU2D add_426_10 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1756), .COUT(n1757));
    defparam add_426_10.INIT0 = 16'h5555;
    defparam add_426_10.INIT1 = 16'h5aaa;
    defparam add_426_10.INJECT1_0 = "NO";
    defparam add_426_10.INJECT1_1 = "NO";
    FD1P3AX count_50ms_229__i0 (.D(n90_adj_24), .SP(FP_UsrLED1_N_352), .CK(clk), 
            .Q(n17_adj_2)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i0.GSR = "DISABLED";
    CCU2D add_426_8 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1755), .COUT(n1756));
    defparam add_426_8.INIT0 = 16'h5555;
    defparam add_426_8.INIT1 = 16'h5aaa;
    defparam add_426_8.INJECT1_0 = "NO";
    defparam add_426_8.INJECT1_1 = "NO";
    CCU2D add_426_6 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1754), .COUT(n1755));
    defparam add_426_6.INIT0 = 16'h5555;
    defparam add_426_6.INIT1 = 16'h5555;
    defparam add_426_6.INJECT1_0 = "NO";
    defparam add_426_6.INJECT1_1 = "NO";
    CCU2D add_426_4 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1753), .COUT(n1754));
    defparam add_426_4.INIT0 = 16'h5aaa;
    defparam add_426_4.INIT1 = 16'h5555;
    defparam add_426_4.INJECT1_0 = "NO";
    defparam add_426_4.INJECT1_1 = "NO";
    CCU2D add_426_2 (.A0(\debounce_counters[2] [7]), .B0(\debounce_counters[2] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[2] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n1753));
    defparam add_426_2.INIT0 = 16'h1000;
    defparam add_426_2.INIT1 = 16'h5555;
    defparam add_426_2.INJECT1_0 = "NO";
    defparam add_426_2.INJECT1_1 = "NO";
    CCU2D add_427_26 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n1752), .S1(clk_enable_135));
    defparam add_427_26.INIT0 = 16'hf555;
    defparam add_427_26.INIT1 = 16'h0000;
    defparam add_427_26.INJECT1_0 = "NO";
    defparam add_427_26.INJECT1_1 = "NO";
    CCU2D add_427_24 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1751), .COUT(n1752));
    defparam add_427_24.INIT0 = 16'h5555;
    defparam add_427_24.INIT1 = 16'h5555;
    defparam add_427_24.INJECT1_0 = "NO";
    defparam add_427_24.INJECT1_1 = "NO";
    CCU2D add_427_22 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1750), .COUT(n1751));
    defparam add_427_22.INIT0 = 16'h5555;
    defparam add_427_22.INIT1 = 16'h5555;
    defparam add_427_22.INJECT1_0 = "NO";
    defparam add_427_22.INJECT1_1 = "NO";
    CCU2D add_427_20 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1749), .COUT(n1750));
    defparam add_427_20.INIT0 = 16'h5555;
    defparam add_427_20.INIT1 = 16'h5555;
    defparam add_427_20.INJECT1_0 = "NO";
    defparam add_427_20.INJECT1_1 = "NO";
    CCU2D add_427_18 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1748), .COUT(n1749));
    defparam add_427_18.INIT0 = 16'h5555;
    defparam add_427_18.INIT1 = 16'h5555;
    defparam add_427_18.INJECT1_0 = "NO";
    defparam add_427_18.INJECT1_1 = "NO";
    CCU2D add_427_16 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1747), .COUT(n1748));
    defparam add_427_16.INIT0 = 16'h5555;
    defparam add_427_16.INIT1 = 16'h5555;
    defparam add_427_16.INJECT1_0 = "NO";
    defparam add_427_16.INJECT1_1 = "NO";
    CCU2D add_427_14 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1746), .COUT(n1747));
    defparam add_427_14.INIT0 = 16'h5aaa;
    defparam add_427_14.INIT1 = 16'h5555;
    defparam add_427_14.INJECT1_0 = "NO";
    defparam add_427_14.INJECT1_1 = "NO";
    CCU2D add_427_12 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1745), .COUT(n1746));
    defparam add_427_12.INIT0 = 16'h5aaa;
    defparam add_427_12.INIT1 = 16'h5aaa;
    defparam add_427_12.INJECT1_0 = "NO";
    defparam add_427_12.INJECT1_1 = "NO";
    CCU2D add_427_10 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1744), .COUT(n1745));
    defparam add_427_10.INIT0 = 16'h5555;
    defparam add_427_10.INIT1 = 16'h5aaa;
    defparam add_427_10.INJECT1_0 = "NO";
    defparam add_427_10.INJECT1_1 = "NO";
    CCU2D add_427_8 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1743), .COUT(n1744));
    defparam add_427_8.INIT0 = 16'h5555;
    defparam add_427_8.INIT1 = 16'h5aaa;
    defparam add_427_8.INJECT1_0 = "NO";
    defparam add_427_8.INJECT1_1 = "NO";
    FD1P3AX FP_UsrLED1_118 (.D(count_done_100ms_N_191), .SP(clk_enable_27), 
            .CK(clk), .Q(FP_UsrLED1_c));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(116[9] 136[16])
    defparam FP_UsrLED1_118.GSR = "DISABLED";
    CCU2D add_68_3 (.A0(\debounce_counters[1] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1663), .COUT(n1664), .S0(n357), 
          .S1(n356));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_3.INIT0 = 16'h5aaa;
    defparam add_68_3.INIT1 = 16'h5aaa;
    defparam add_68_3.INJECT1_0 = "NO";
    defparam add_68_3.INJECT1_1 = "NO";
    CCU2D add_427_6 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1742), .COUT(n1743));
    defparam add_427_6.INIT0 = 16'h5555;
    defparam add_427_6.INIT1 = 16'h5555;
    defparam add_427_6.INJECT1_0 = "NO";
    defparam add_427_6.INJECT1_1 = "NO";
    FD1P3IX debounce_counters_0___i31 (.D(n222), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [31])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i31.GSR = "ENABLED";
    CCU2D add_427_4 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1741), .COUT(n1742));
    defparam add_427_4.INIT0 = 16'h5aaa;
    defparam add_427_4.INIT1 = 16'h5555;
    defparam add_427_4.INJECT1_0 = "NO";
    defparam add_427_4.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut_adj_2 (.A(current_state[2]), .B(current_state[0]), 
         .C(current_state[1]), .Z(State_LED_0_1)) /* synthesis lut_function=(A (C)+!A (B+(C))) */ ;
    defparam i1_2_lut_3_lut_adj_2.init = 16'hf4f4;
    OB FP_SysLEDb_pad (.I(GND_net), .O(FP_SysLEDb));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(16[3:13])
    LUT4 i14_3_lut (.A(n1830), .B(Carrier_PG_1V8_N_375), .C(count_done_100ms), 
         .Z(clk_enable_27)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i14_3_lut.init = 16'hcaca;
    FD1P3IX debounce_counters_0___i30 (.D(n223), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [30])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i29 (.D(n224), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [29])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i28 (.D(n225), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [28])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i27 (.D(n226), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [27])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i26 (.D(n227), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [26])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i25 (.D(n228), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [25])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i24 (.D(n229), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [24])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i23 (.D(n230), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [23])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i22 (.D(n231), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [22])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i21 (.D(n232), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [21])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i20 (.D(n233), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [20])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i19 (.D(n234), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [19])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i18 (.D(n235), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [18])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i17 (.D(n236), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [17])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i16 (.D(n237), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [16])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i15 (.D(n238), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [15])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i14 (.D(n239), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [14])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i13 (.D(n240), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [13])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i12 (.D(n241), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [12])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i11 (.D(n242), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [11])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i10 (.D(n243), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [10])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i9 (.D(n244), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [9])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i8 (.D(n245), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [8])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i7 (.D(n246), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [7])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i6 (.D(n247), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [6])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i5 (.D(n248), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [5])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i4 (.D(n249), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [4])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i3 (.D(n250), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [3])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_0___i2 (.D(n251), .SP(clk_enable_57), .CD(n1370), 
            .CK(clk), .Q(\debounce_counters[0] [2])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_0___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i19 (.D(n549), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [19])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i19.GSR = "ENABLED";
    OB Carrier_PG_3V3_pad (.I(GND_net), .O(Carrier_PG_3V3));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(17[3:17])
    OB FPIO_FlexMIO52_pad (.I(FPIO_FlexMIO52_c_c), .O(FPIO_FlexMIO52));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(18[3:17])
    OB FP_UsrLED1_pad (.I(FP_UsrLED1_c), .O(FP_UsrLED1));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(27[3:13])
    OB FP_UsrLED2_pad (.I(GND_net), .O(FP_UsrLED2));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(28[3:13])
    OB FP_UsrLED3_pad (.I(GND_net), .O(FP_UsrLED3));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(29[3:13])
    OB FP_UsrLED4_pad (.I(GND_net), .O(FP_UsrLED4));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(30[3:13])
    OBZ n1402_pad (.I(Carrier_PG_1V8_N_359), .T(n1403), .O(Carrier_PG_1V8));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(114[5] 137[17])
    OB SD_SEL_pad (.I(GND_net), .O(SD_SEL));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(36[3:9])
    OB FlexMio61ExternalStop_pad (.I(FlexMio61ExternalStop_c_c), .O(FlexMio61ExternalStop));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(38[3:24])
    OB Carrier_PwrOn_pad (.I(Carrier_PwrOn_c), .O(Carrier_PwrOn));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(45[9:22])
    OB ENB_Ctrl_out_pad (.I(ENB_Ctrl_out_c), .O(ENB_Ctrl_out));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(49[3:15])
    OB ENB_Sys_out_pad (.I(ENB_Sys_out_c), .O(ENB_Sys_out));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(50[9:20])
    OB STOP_out_pad (.I(next_state_2__N_41[1]), .O(STOP_out));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(51[9:17])
    OB State_LED_pad_3 (.I(State_LED_c), .O(State_LED[3]));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(53[3:12])
    OB State_LED_pad_2 (.I(State_LED_c), .O(State_LED[2]));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(53[3:12])
    OB State_LED_pad_1 (.I(State_LED_0_1), .O(State_LED[1]));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(53[3:12])
    OB State_LED_pad_0 (.I(State_LED_0_0), .O(State_LED[0]));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(53[3:12])
    IB RESET_pad (.I(RESET), .O(RESET_c));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(11[3:8])
    IB FlexMio61ExternalStop_c_pad (.I(FPIO_ExternalStop), .O(FlexMio61ExternalStop_c_c));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(19[3:20])
    IB SysSW_Pwr_NC_pad (.I(SysSW_Pwr_NC), .O(SysSW_Pwr_NC_c));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(21[3:15])
    IB FP_UsrSW1_pad (.I(FP_UsrSW1), .O(FP_UsrSW1_c));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(22[3:12])
    IB FP_UsrSW2_pad (.I(FP_UsrSW2), .O(FP_UsrSW2_c));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(23[3:12])
    IB FP_UsrSW3_pad (.I(FP_UsrSW3), .O(FP_UsrSW3_c));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(24[3:12])
    IB FPIO_FlexMIO52_c_pad (.I(FlexMIOs52_PCIe), .O(FPIO_FlexMIO52_c_c));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(37[3:18])
    FD1P3IX debounce_counters_3___i20 (.D(n548), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [20])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i21 (.D(n547), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [21])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i22 (.D(n546), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [22])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i23 (.D(n545), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [23])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i24 (.D(n544), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [24])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i25 (.D(n543), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [25])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i26 (.D(n542), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [26])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i27 (.D(n541), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [27])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i28 (.D(n540), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [28])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i29 (.D(n539), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [29])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i30 (.D(n538), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [30])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_3___i31 (.D(n537), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [31])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i31.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i1 (.D(n357), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [1])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i2 (.D(n356), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [2])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i3 (.D(n355), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [3])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i4 (.D(n354), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [4])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i5 (.D(n353), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [5])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i6 (.D(n352), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [6])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i7 (.D(n351), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [7])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i8 (.D(n350), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [8])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i9 (.D(n349), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [9])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i10 (.D(n348), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [10])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i11 (.D(n347), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [11])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i12 (.D(n346), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [12])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i13 (.D(n345), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [13])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i14 (.D(n344), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [14])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i15 (.D(n343), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [15])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i16 (.D(n342), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [16])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i17 (.D(n341), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [17])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i18 (.D(n340), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [18])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i19 (.D(n339), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [19])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i20 (.D(n338), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [20])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i21 (.D(n337), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [21])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i22 (.D(n336), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [22])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i23 (.D(n335), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [23])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i24 (.D(n334), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [24])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i25 (.D(n333), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [25])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i26 (.D(n332), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [26])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i27 (.D(n331), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [27])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i28 (.D(n330), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [28])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i29 (.D(n329), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [29])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i30 (.D(n328), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [30])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_1___i31 (.D(n327), .SP(clk_enable_101), .CD(n1368), 
            .CK(clk), .Q(\debounce_counters[1] [31])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_1___i31.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i1 (.D(n462), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [1])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i1.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i2 (.D(n461), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [2])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i2.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i3 (.D(n460), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [3])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i3.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i4 (.D(n459), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [4])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i4.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i5 (.D(n458), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [5])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i5.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i6 (.D(n457), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [6])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i6.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i7 (.D(n456), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [7])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i7.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i8 (.D(n455), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [8])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i8.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i9 (.D(n454), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [9])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i9.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i10 (.D(n453), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [10])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i10.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i11 (.D(n452), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [11])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i11.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i12 (.D(n451), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [12])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i12.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i13 (.D(n450), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [13])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i13.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i14 (.D(n449), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [14])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i14.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i15 (.D(n448), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [15])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i15.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i16 (.D(n447), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [16])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i16.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i17 (.D(n446), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [17])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i17.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i18 (.D(n445), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [18])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i18.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i19 (.D(n444), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [19])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i19.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i20 (.D(n443), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [20])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i20.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i21 (.D(n442), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [21])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i21.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i22 (.D(n441), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [22])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i22.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i23 (.D(n440), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [23])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i23.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i24 (.D(n439), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [24])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i24.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i25 (.D(n438), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [25])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i25.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i26 (.D(n437), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [26])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i26.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i27 (.D(n436), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [27])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i27.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i28 (.D(n435), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [28])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i28.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i29 (.D(n434), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [29])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i29.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i30 (.D(n433), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [30])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i30.GSR = "ENABLED";
    FD1P3IX debounce_counters_2___i31 (.D(n432), .SP(clk_enable_132), .CD(n1366), 
            .CK(clk), .Q(\debounce_counters[2] [31])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_2___i31.GSR = "ENABLED";
    FD1P3IX button_stables_i2 (.D(n1836), .SP(clk_enable_133), .CD(n1368), 
            .CK(clk), .Q(next_state_2__N_41[1])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam button_stables_i2.GSR = "ENABLED";
    CCU2D add_427_2 (.A0(\debounce_counters[3] [7]), .B0(\debounce_counters[3] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[3] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n1741));
    defparam add_427_2.INIT0 = 16'h1000;
    defparam add_427_2.INIT1 = 16'h5555;
    defparam add_427_2.INJECT1_0 = "NO";
    defparam add_427_2.INJECT1_1 = "NO";
    CCU2D add_428_26 (.A0(\debounce_counters[0] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n1740), .S1(clk_enable_12));
    defparam add_428_26.INIT0 = 16'hf555;
    defparam add_428_26.INIT1 = 16'h0000;
    defparam add_428_26.INJECT1_0 = "NO";
    defparam add_428_26.INJECT1_1 = "NO";
    CCU2D add_428_24 (.A0(\debounce_counters[0] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1739), .COUT(n1740));
    defparam add_428_24.INIT0 = 16'h5555;
    defparam add_428_24.INIT1 = 16'h5555;
    defparam add_428_24.INJECT1_0 = "NO";
    defparam add_428_24.INJECT1_1 = "NO";
    CCU2D add_428_22 (.A0(\debounce_counters[0] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1738), .COUT(n1739));
    defparam add_428_22.INIT0 = 16'h5555;
    defparam add_428_22.INIT1 = 16'h5555;
    defparam add_428_22.INJECT1_0 = "NO";
    defparam add_428_22.INJECT1_1 = "NO";
    CCU2D add_428_20 (.A0(\debounce_counters[0] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1737), .COUT(n1738));
    defparam add_428_20.INIT0 = 16'h5555;
    defparam add_428_20.INIT1 = 16'h5555;
    defparam add_428_20.INJECT1_0 = "NO";
    defparam add_428_20.INJECT1_1 = "NO";
    CCU2D add_428_18 (.A0(\debounce_counters[0] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1736), .COUT(n1737));
    defparam add_428_18.INIT0 = 16'h5555;
    defparam add_428_18.INIT1 = 16'h5555;
    defparam add_428_18.INJECT1_0 = "NO";
    defparam add_428_18.INJECT1_1 = "NO";
    CCU2D add_428_16 (.A0(\debounce_counters[0] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1735), .COUT(n1736));
    defparam add_428_16.INIT0 = 16'h5555;
    defparam add_428_16.INIT1 = 16'h5555;
    defparam add_428_16.INJECT1_0 = "NO";
    defparam add_428_16.INJECT1_1 = "NO";
    CCU2D add_428_14 (.A0(\debounce_counters[0] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1734), .COUT(n1735));
    defparam add_428_14.INIT0 = 16'h5aaa;
    defparam add_428_14.INIT1 = 16'h5555;
    defparam add_428_14.INJECT1_0 = "NO";
    defparam add_428_14.INJECT1_1 = "NO";
    CCU2D add_428_12 (.A0(\debounce_counters[0] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1733), .COUT(n1734));
    defparam add_428_12.INIT0 = 16'h5aaa;
    defparam add_428_12.INIT1 = 16'h5aaa;
    defparam add_428_12.INJECT1_0 = "NO";
    defparam add_428_12.INJECT1_1 = "NO";
    CCU2D add_428_10 (.A0(\debounce_counters[0] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1732), .COUT(n1733));
    defparam add_428_10.INIT0 = 16'h5555;
    defparam add_428_10.INIT1 = 16'h5aaa;
    defparam add_428_10.INJECT1_0 = "NO";
    defparam add_428_10.INJECT1_1 = "NO";
    CCU2D add_428_8 (.A0(\debounce_counters[0] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1731), .COUT(n1732));
    defparam add_428_8.INIT0 = 16'h5555;
    defparam add_428_8.INIT1 = 16'h5aaa;
    defparam add_428_8.INJECT1_0 = "NO";
    defparam add_428_8.INJECT1_1 = "NO";
    CCU2D add_428_6 (.A0(\debounce_counters[0] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1730), .COUT(n1731));
    defparam add_428_6.INIT0 = 16'h5555;
    defparam add_428_6.INIT1 = 16'h5555;
    defparam add_428_6.INJECT1_0 = "NO";
    defparam add_428_6.INJECT1_1 = "NO";
    CCU2D add_428_4 (.A0(\debounce_counters[0] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1729), .COUT(n1730));
    defparam add_428_4.INIT0 = 16'h5aaa;
    defparam add_428_4.INIT1 = 16'h5555;
    defparam add_428_4.INJECT1_0 = "NO";
    defparam add_428_4.INJECT1_1 = "NO";
    CCU2D add_428_2 (.A0(\debounce_counters[0] [7]), .B0(\debounce_counters[0] [6]), 
          .C0(GND_net), .D0(GND_net), .A1(\debounce_counters[0] [8]), 
          .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n1729));
    defparam add_428_2.INIT0 = 16'h1000;
    defparam add_428_2.INIT1 = 16'h5555;
    defparam add_428_2.INJECT1_0 = "NO";
    defparam add_428_2.INJECT1_1 = "NO";
    CCU2D count_50ms_229_add_4_17 (.A0(count_50ms[15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(count_50ms[16]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n1727), .S0(n75), .S1(n74));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229_add_4_17.INIT0 = 16'hfaaa;
    defparam count_50ms_229_add_4_17.INIT1 = 16'hfaaa;
    defparam count_50ms_229_add_4_17.INJECT1_0 = "NO";
    defparam count_50ms_229_add_4_17.INJECT1_1 = "NO";
    CCU2D count_50ms_229_add_4_15 (.A0(count_50ms[13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(count_50ms[14]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n1726), .COUT(n1727), .S0(n77), .S1(n76));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229_add_4_15.INIT0 = 16'hfaaa;
    defparam count_50ms_229_add_4_15.INIT1 = 16'hfaaa;
    defparam count_50ms_229_add_4_15.INJECT1_0 = "NO";
    defparam count_50ms_229_add_4_15.INJECT1_1 = "NO";
    CCU2D count_50ms_229_add_4_13 (.A0(count_50ms[11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(count_50ms[12]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n1725), .COUT(n1726), .S0(n79_adj_13), 
          .S1(n78_adj_12));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229_add_4_13.INIT0 = 16'hfaaa;
    defparam count_50ms_229_add_4_13.INIT1 = 16'hfaaa;
    defparam count_50ms_229_add_4_13.INJECT1_0 = "NO";
    defparam count_50ms_229_add_4_13.INJECT1_1 = "NO";
    CCU2D count_50ms_229_add_4_11 (.A0(n8_adj_11), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(count_50ms[10]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n1724), .COUT(n1725), .S0(n81_adj_15), 
          .S1(n80_adj_14));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229_add_4_11.INIT0 = 16'hfaaa;
    defparam count_50ms_229_add_4_11.INIT1 = 16'hfaaa;
    defparam count_50ms_229_add_4_11.INJECT1_0 = "NO";
    defparam count_50ms_229_add_4_11.INJECT1_1 = "NO";
    CCU2D count_50ms_229_add_4_9 (.A0(n10_adj_9), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n9_adj_10), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n1723), .COUT(n1724), .S0(n83_adj_17), 
          .S1(n82_adj_16));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229_add_4_9.INIT0 = 16'hfaaa;
    defparam count_50ms_229_add_4_9.INIT1 = 16'hfaaa;
    defparam count_50ms_229_add_4_9.INJECT1_0 = "NO";
    defparam count_50ms_229_add_4_9.INJECT1_1 = "NO";
    CCU2D count_50ms_229_add_4_7 (.A0(n12_adj_7), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n11_adj_8), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n1722), .COUT(n1723), .S0(n85_adj_19), 
          .S1(n84_adj_18));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229_add_4_7.INIT0 = 16'hfaaa;
    defparam count_50ms_229_add_4_7.INIT1 = 16'hfaaa;
    defparam count_50ms_229_add_4_7.INJECT1_0 = "NO";
    defparam count_50ms_229_add_4_7.INJECT1_1 = "NO";
    CCU2D count_50ms_229_add_4_5 (.A0(n14_adj_5), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n13_adj_6), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n1721), .COUT(n1722), .S0(n87_adj_21), 
          .S1(n86_adj_20));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229_add_4_5.INIT0 = 16'hfaaa;
    defparam count_50ms_229_add_4_5.INIT1 = 16'hfaaa;
    defparam count_50ms_229_add_4_5.INJECT1_0 = "NO";
    defparam count_50ms_229_add_4_5.INJECT1_1 = "NO";
    CCU2D count_50ms_229_add_4_3 (.A0(n16_adj_3), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n15_adj_4), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n1720), .COUT(n1721), .S0(n89_adj_23), 
          .S1(n88_adj_22));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229_add_4_3.INIT0 = 16'hfaaa;
    defparam count_50ms_229_add_4_3.INIT1 = 16'hfaaa;
    defparam count_50ms_229_add_4_3.INJECT1_0 = "NO";
    defparam count_50ms_229_add_4_3.INJECT1_1 = "NO";
    CCU2D count_50ms_229_add_4_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n1831), .B1(n1449), .C1(n17_adj_2), .D1(GND_net), 
          .COUT(n1720), .S1(n90_adj_24));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229_add_4_1.INIT0 = 16'hF000;
    defparam count_50ms_229_add_4_1.INIT1 = 16'h8787;
    defparam count_50ms_229_add_4_1.INJECT1_0 = "NO";
    defparam count_50ms_229_add_4_1.INJECT1_1 = "NO";
    CCU2D count_100ms_228_add_4_19 (.A0(count_100ms[17]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n1719), .S0(n78));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228_add_4_19.INIT0 = 16'hfaaa;
    defparam count_100ms_228_add_4_19.INIT1 = 16'h0000;
    defparam count_100ms_228_add_4_19.INJECT1_0 = "NO";
    defparam count_100ms_228_add_4_19.INJECT1_1 = "NO";
    CCU2D count_100ms_228_add_4_17 (.A0(count_100ms[15]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(count_100ms[16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1718), .COUT(n1719), .S0(n80), 
          .S1(n79));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228_add_4_17.INIT0 = 16'hfaaa;
    defparam count_100ms_228_add_4_17.INIT1 = 16'hfaaa;
    defparam count_100ms_228_add_4_17.INJECT1_0 = "NO";
    defparam count_100ms_228_add_4_17.INJECT1_1 = "NO";
    CCU2D count_100ms_228_add_4_15 (.A0(count_100ms[13]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(count_100ms[14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1717), .COUT(n1718), .S0(n82), 
          .S1(n81));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228_add_4_15.INIT0 = 16'hfaaa;
    defparam count_100ms_228_add_4_15.INIT1 = 16'hfaaa;
    defparam count_100ms_228_add_4_15.INJECT1_0 = "NO";
    defparam count_100ms_228_add_4_15.INJECT1_1 = "NO";
    CCU2D count_100ms_228_add_4_13 (.A0(count_100ms[11]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(count_100ms[12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1716), .COUT(n1717), .S0(n84), 
          .S1(n83));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228_add_4_13.INIT0 = 16'hfaaa;
    defparam count_100ms_228_add_4_13.INIT1 = 16'hfaaa;
    defparam count_100ms_228_add_4_13.INJECT1_0 = "NO";
    defparam count_100ms_228_add_4_13.INJECT1_1 = "NO";
    CCU2D count_100ms_228_add_4_11 (.A0(n9), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n8), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n1715), .COUT(n1716), .S0(n86), .S1(n85));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228_add_4_11.INIT0 = 16'hfaaa;
    defparam count_100ms_228_add_4_11.INIT1 = 16'hfaaa;
    defparam count_100ms_228_add_4_11.INJECT1_0 = "NO";
    defparam count_100ms_228_add_4_11.INJECT1_1 = "NO";
    CCU2D count_100ms_228_add_4_9 (.A0(n11), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n10), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n1714), .COUT(n1715), .S0(n88), .S1(n87));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228_add_4_9.INIT0 = 16'hfaaa;
    defparam count_100ms_228_add_4_9.INIT1 = 16'hfaaa;
    defparam count_100ms_228_add_4_9.INJECT1_0 = "NO";
    defparam count_100ms_228_add_4_9.INJECT1_1 = "NO";
    CCU2D count_100ms_228_add_4_7 (.A0(n13), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n12), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n1713), .COUT(n1714), .S0(n90), .S1(n89));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228_add_4_7.INIT0 = 16'hfaaa;
    defparam count_100ms_228_add_4_7.INIT1 = 16'hfaaa;
    defparam count_100ms_228_add_4_7.INJECT1_0 = "NO";
    defparam count_100ms_228_add_4_7.INJECT1_1 = "NO";
    CCU2D count_100ms_228_add_4_5 (.A0(n15), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n14), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n1712), .COUT(n1713), .S0(n92), .S1(n91));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228_add_4_5.INIT0 = 16'hfaaa;
    defparam count_100ms_228_add_4_5.INIT1 = 16'hfaaa;
    defparam count_100ms_228_add_4_5.INJECT1_0 = "NO";
    defparam count_100ms_228_add_4_5.INJECT1_1 = "NO";
    FD1P3IX button_stables_i3 (.D(n1836), .SP(clk_enable_134), .CD(n1366), 
            .CK(clk), .Q(ENB_Sys_out_c)) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam button_stables_i3.GSR = "ENABLED";
    FD1P3IX button_stables_i4 (.D(n1836), .SP(clk_enable_135), .CD(n1364), 
            .CK(clk), .Q(ENB_Ctrl_out_c)) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam button_stables_i4.GSR = "ENABLED";
    LUT4 i2_2_lut_rep_10 (.A(count_100ms[16]), .B(count_100ms[15]), .Z(n1832)) /* synthesis lut_function=(A (B)) */ ;
    defparam i2_2_lut_rep_10.init = 16'h8888;
    FD1P3AX current_state_i2 (.D(next_state[2]), .SP(clk_enable_136), .CK(clk), 
            .Q(current_state[2]));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(172[9] 176[16])
    defparam current_state_i2.GSR = "ENABLED";
    FD1P3AX count_100ms_228__i1 (.D(n94), .SP(count_done_100ms_N_191), .CK(clk), 
            .Q(n17)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i1.GSR = "DISABLED";
    FD1P3AX reset_triggered_120 (.D(n1836), .SP(Carrier_PG_1V8_N_375), .CK(clk), 
            .Q(reset_triggered)) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(116[9] 136[16])
    defparam reset_triggered_120.GSR = "DISABLED";
    LUT4 i287_1_lut (.A(Carrier_PG_1V8_N_360), .Z(n1403)) /* synthesis lut_function=(!(A)) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(114[5] 137[17])
    defparam i287_1_lut.init = 16'h5555;
    FD1S3IX Carrier_PG_1V8_117 (.D(n1361), .CK(clk), .CD(n1401), .Q(Carrier_PG_1V8_N_359));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(116[9] 136[16])
    defparam Carrier_PG_1V8_117.GSR = "DISABLED";
    CCU2D count_100ms_228_add_4_3 (.A0(n17), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n16), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n1711), .COUT(n1712), .S0(n94), .S1(n93));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228_add_4_3.INIT0 = 16'hfaaa;
    defparam count_100ms_228_add_4_3.INIT1 = 16'hfaaa;
    defparam count_100ms_228_add_4_3.INJECT1_0 = "NO";
    defparam count_100ms_228_add_4_3.INJECT1_1 = "NO";
    CCU2D count_100ms_228_add_4_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n1510), .B1(n1450), .C1(n18), .D1(GND_net), 
          .COUT(n1711), .S1(n95));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228_add_4_1.INIT0 = 16'hF000;
    defparam count_100ms_228_add_4_1.INIT1 = 16'h8787;
    defparam count_100ms_228_add_4_1.INJECT1_0 = "NO";
    defparam count_100ms_228_add_4_1.INJECT1_1 = "NO";
    CCU2D add_84_33 (.A0(\debounce_counters[3] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n1710), .S0(n537));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_33.INIT0 = 16'h5aaa;
    defparam add_84_33.INIT1 = 16'h0000;
    defparam add_84_33.INJECT1_0 = "NO";
    defparam add_84_33.INJECT1_1 = "NO";
    CCU2D add_84_31 (.A0(\debounce_counters[3] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1709), .COUT(n1710), .S0(n539), 
          .S1(n538));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_31.INIT0 = 16'h5aaa;
    defparam add_84_31.INIT1 = 16'h5aaa;
    defparam add_84_31.INJECT1_0 = "NO";
    defparam add_84_31.INJECT1_1 = "NO";
    CCU2D add_84_29 (.A0(\debounce_counters[3] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1708), .COUT(n1709), .S0(n541), 
          .S1(n540));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_29.INIT0 = 16'h5aaa;
    defparam add_84_29.INIT1 = 16'h5aaa;
    defparam add_84_29.INJECT1_0 = "NO";
    defparam add_84_29.INJECT1_1 = "NO";
    CCU2D add_84_27 (.A0(\debounce_counters[3] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1707), .COUT(n1708), .S0(n543), 
          .S1(n542));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_27.INIT0 = 16'h5aaa;
    defparam add_84_27.INIT1 = 16'h5aaa;
    defparam add_84_27.INJECT1_0 = "NO";
    defparam add_84_27.INJECT1_1 = "NO";
    CCU2D add_84_25 (.A0(\debounce_counters[3] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1706), .COUT(n1707), .S0(n545), 
          .S1(n544));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_25.INIT0 = 16'h5aaa;
    defparam add_84_25.INIT1 = 16'h5aaa;
    defparam add_84_25.INJECT1_0 = "NO";
    defparam add_84_25.INJECT1_1 = "NO";
    CCU2D add_84_23 (.A0(\debounce_counters[3] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1705), .COUT(n1706), .S0(n547), 
          .S1(n546));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_23.INIT0 = 16'h5aaa;
    defparam add_84_23.INIT1 = 16'h5aaa;
    defparam add_84_23.INJECT1_0 = "NO";
    defparam add_84_23.INJECT1_1 = "NO";
    CCU2D add_84_21 (.A0(\debounce_counters[3] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1704), .COUT(n1705), .S0(n549), 
          .S1(n548));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_21.INIT0 = 16'h5aaa;
    defparam add_84_21.INIT1 = 16'h5aaa;
    defparam add_84_21.INJECT1_0 = "NO";
    defparam add_84_21.INJECT1_1 = "NO";
    CCU2D add_84_19 (.A0(\debounce_counters[3] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1703), .COUT(n1704), .S0(n551), 
          .S1(n550));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_19.INIT0 = 16'h5aaa;
    defparam add_84_19.INIT1 = 16'h5aaa;
    defparam add_84_19.INJECT1_0 = "NO";
    defparam add_84_19.INJECT1_1 = "NO";
    CCU2D add_84_17 (.A0(\debounce_counters[3] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1702), .COUT(n1703), .S0(n553), 
          .S1(n552));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_17.INIT0 = 16'h5aaa;
    defparam add_84_17.INIT1 = 16'h5aaa;
    defparam add_84_17.INJECT1_0 = "NO";
    defparam add_84_17.INJECT1_1 = "NO";
    CCU2D add_84_15 (.A0(\debounce_counters[3] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1701), .COUT(n1702), .S0(n555), 
          .S1(n554));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_15.INIT0 = 16'h5aaa;
    defparam add_84_15.INIT1 = 16'h5aaa;
    defparam add_84_15.INJECT1_0 = "NO";
    defparam add_84_15.INJECT1_1 = "NO";
    CCU2D add_84_13 (.A0(\debounce_counters[3] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1700), .COUT(n1701), .S0(n557), 
          .S1(n556));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_13.INIT0 = 16'h5aaa;
    defparam add_84_13.INIT1 = 16'h5aaa;
    defparam add_84_13.INJECT1_0 = "NO";
    defparam add_84_13.INJECT1_1 = "NO";
    CCU2D add_84_11 (.A0(\debounce_counters[3] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1699), .COUT(n1700), .S0(n559), 
          .S1(n558));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_11.INIT0 = 16'h5aaa;
    defparam add_84_11.INIT1 = 16'h5aaa;
    defparam add_84_11.INJECT1_0 = "NO";
    defparam add_84_11.INJECT1_1 = "NO";
    CCU2D add_84_9 (.A0(\debounce_counters[3] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1698), .COUT(n1699), .S0(n561), 
          .S1(n560));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_9.INIT0 = 16'h5aaa;
    defparam add_84_9.INIT1 = 16'h5aaa;
    defparam add_84_9.INJECT1_0 = "NO";
    defparam add_84_9.INJECT1_1 = "NO";
    CCU2D add_84_7 (.A0(\debounce_counters[3] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1697), .COUT(n1698), .S0(n563), 
          .S1(n562));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_7.INIT0 = 16'h5aaa;
    defparam add_84_7.INIT1 = 16'h5aaa;
    defparam add_84_7.INJECT1_0 = "NO";
    defparam add_84_7.INJECT1_1 = "NO";
    CCU2D add_84_5 (.A0(\debounce_counters[3] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1696), .COUT(n1697), .S0(n565), 
          .S1(n564));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_5.INIT0 = 16'h5aaa;
    defparam add_84_5.INIT1 = 16'h5aaa;
    defparam add_84_5.INJECT1_0 = "NO";
    defparam add_84_5.INJECT1_1 = "NO";
    CCU2D add_84_3 (.A0(\debounce_counters[3] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[3] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1695), .COUT(n1696), .S0(n567), 
          .S1(n566));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_3.INIT0 = 16'h5aaa;
    defparam add_84_3.INIT1 = 16'h5aaa;
    defparam add_84_3.INJECT1_0 = "NO";
    defparam add_84_3.INJECT1_1 = "NO";
    CCU2D add_84_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[3] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n1695), .S1(n568));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_84_1.INIT0 = 16'hF000;
    defparam add_84_1.INIT1 = 16'h5555;
    defparam add_84_1.INJECT1_0 = "NO";
    defparam add_84_1.INJECT1_1 = "NO";
    CCU2D add_76_33 (.A0(\debounce_counters[2] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n1694), .S0(n432));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_33.INIT0 = 16'h5aaa;
    defparam add_76_33.INIT1 = 16'h0000;
    defparam add_76_33.INJECT1_0 = "NO";
    defparam add_76_33.INJECT1_1 = "NO";
    CCU2D add_76_31 (.A0(\debounce_counters[2] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1693), .COUT(n1694), .S0(n434), 
          .S1(n433));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_31.INIT0 = 16'h5aaa;
    defparam add_76_31.INIT1 = 16'h5aaa;
    defparam add_76_31.INJECT1_0 = "NO";
    defparam add_76_31.INJECT1_1 = "NO";
    CCU2D add_76_29 (.A0(\debounce_counters[2] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1692), .COUT(n1693), .S0(n436), 
          .S1(n435));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_29.INIT0 = 16'h5aaa;
    defparam add_76_29.INIT1 = 16'h5aaa;
    defparam add_76_29.INJECT1_0 = "NO";
    defparam add_76_29.INJECT1_1 = "NO";
    CCU2D add_76_27 (.A0(\debounce_counters[2] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1691), .COUT(n1692), .S0(n438), 
          .S1(n437));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_27.INIT0 = 16'h5aaa;
    defparam add_76_27.INIT1 = 16'h5aaa;
    defparam add_76_27.INJECT1_0 = "NO";
    defparam add_76_27.INJECT1_1 = "NO";
    CCU2D add_76_25 (.A0(\debounce_counters[2] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1690), .COUT(n1691), .S0(n440), 
          .S1(n439));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_25.INIT0 = 16'h5aaa;
    defparam add_76_25.INIT1 = 16'h5aaa;
    defparam add_76_25.INJECT1_0 = "NO";
    defparam add_76_25.INJECT1_1 = "NO";
    CCU2D add_76_23 (.A0(\debounce_counters[2] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1689), .COUT(n1690), .S0(n442), 
          .S1(n441));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_23.INIT0 = 16'h5aaa;
    defparam add_76_23.INIT1 = 16'h5aaa;
    defparam add_76_23.INJECT1_0 = "NO";
    defparam add_76_23.INJECT1_1 = "NO";
    CCU2D add_76_21 (.A0(\debounce_counters[2] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1688), .COUT(n1689), .S0(n444), 
          .S1(n443));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_21.INIT0 = 16'h5aaa;
    defparam add_76_21.INIT1 = 16'h5aaa;
    defparam add_76_21.INJECT1_0 = "NO";
    defparam add_76_21.INJECT1_1 = "NO";
    CCU2D add_76_19 (.A0(\debounce_counters[2] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1687), .COUT(n1688), .S0(n446), 
          .S1(n445));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_19.INIT0 = 16'h5aaa;
    defparam add_76_19.INIT1 = 16'h5aaa;
    defparam add_76_19.INJECT1_0 = "NO";
    defparam add_76_19.INJECT1_1 = "NO";
    CCU2D add_76_17 (.A0(\debounce_counters[2] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1686), .COUT(n1687), .S0(n448), 
          .S1(n447));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_17.INIT0 = 16'h5aaa;
    defparam add_76_17.INIT1 = 16'h5aaa;
    defparam add_76_17.INJECT1_0 = "NO";
    defparam add_76_17.INJECT1_1 = "NO";
    CCU2D add_76_15 (.A0(\debounce_counters[2] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1685), .COUT(n1686), .S0(n450), 
          .S1(n449));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_15.INIT0 = 16'h5aaa;
    defparam add_76_15.INIT1 = 16'h5aaa;
    defparam add_76_15.INJECT1_0 = "NO";
    defparam add_76_15.INJECT1_1 = "NO";
    CCU2D add_76_13 (.A0(\debounce_counters[2] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1684), .COUT(n1685), .S0(n452), 
          .S1(n451));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_13.INIT0 = 16'h5aaa;
    defparam add_76_13.INIT1 = 16'h5aaa;
    defparam add_76_13.INJECT1_0 = "NO";
    defparam add_76_13.INJECT1_1 = "NO";
    CCU2D add_76_11 (.A0(\debounce_counters[2] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1683), .COUT(n1684), .S0(n454), 
          .S1(n453));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_11.INIT0 = 16'h5aaa;
    defparam add_76_11.INIT1 = 16'h5aaa;
    defparam add_76_11.INJECT1_0 = "NO";
    defparam add_76_11.INJECT1_1 = "NO";
    FD1P3AX count_100ms_228__i2 (.D(n93), .SP(count_done_100ms_N_191), .CK(clk), 
            .Q(n16)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i2.GSR = "DISABLED";
    FD1P3AX count_100ms_228__i3 (.D(n92), .SP(count_done_100ms_N_191), .CK(clk), 
            .Q(n15)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i3.GSR = "DISABLED";
    FD1P3AX count_100ms_228__i4 (.D(n91), .SP(count_done_100ms_N_191), .CK(clk), 
            .Q(n14)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i4.GSR = "DISABLED";
    FD1P3AX count_100ms_228__i5 (.D(n90), .SP(count_done_100ms_N_191), .CK(clk), 
            .Q(n13)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i5.GSR = "DISABLED";
    FD1P3AX count_100ms_228__i6 (.D(n89), .SP(count_done_100ms_N_191), .CK(clk), 
            .Q(n12)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i6.GSR = "DISABLED";
    FD1P3AX count_100ms_228__i7 (.D(n88), .SP(count_done_100ms_N_191), .CK(clk), 
            .Q(n11)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i7.GSR = "DISABLED";
    FD1P3AX count_100ms_228__i8 (.D(n87), .SP(count_done_100ms_N_191), .CK(clk), 
            .Q(n10)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i8.GSR = "DISABLED";
    FD1P3AX count_100ms_228__i9 (.D(n86), .SP(count_done_100ms_N_191), .CK(clk), 
            .Q(n9)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i9.GSR = "DISABLED";
    FD1P3AX count_100ms_228__i10 (.D(n85), .SP(count_done_100ms_N_191), 
            .CK(clk), .Q(n8)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i10.GSR = "DISABLED";
    FD1P3AX count_100ms_228__i11 (.D(n84), .SP(count_done_100ms_N_191), 
            .CK(clk), .Q(count_100ms[11])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i11.GSR = "DISABLED";
    FD1P3AX count_100ms_228__i12 (.D(n83), .SP(count_done_100ms_N_191), 
            .CK(clk), .Q(count_100ms[12])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i12.GSR = "DISABLED";
    FD1P3AX count_100ms_228__i13 (.D(n82), .SP(count_done_100ms_N_191), 
            .CK(clk), .Q(count_100ms[13])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i13.GSR = "DISABLED";
    FD1P3AX count_100ms_228__i14 (.D(n81), .SP(count_done_100ms_N_191), 
            .CK(clk), .Q(count_100ms[14])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i14.GSR = "DISABLED";
    FD1P3AX count_100ms_228__i15 (.D(n80), .SP(count_done_100ms_N_191), 
            .CK(clk), .Q(count_100ms[15])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i15.GSR = "DISABLED";
    FD1P3AX count_100ms_228__i16 (.D(n79), .SP(count_done_100ms_N_191), 
            .CK(clk), .Q(count_100ms[16])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i16.GSR = "DISABLED";
    FD1P3AX count_100ms_228__i17 (.D(n78), .SP(count_done_100ms_N_191), 
            .CK(clk), .Q(count_100ms[17])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(120[36:47])
    defparam count_100ms_228__i17.GSR = "DISABLED";
    FD1P3AX count_50ms_229__i1 (.D(n89_adj_23), .SP(FP_UsrLED1_N_352), .CK(clk), 
            .Q(n16_adj_3)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i1.GSR = "DISABLED";
    CCU2D add_76_9 (.A0(\debounce_counters[2] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1682), .COUT(n1683), .S0(n456), 
          .S1(n455));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_9.INIT0 = 16'h5aaa;
    defparam add_76_9.INIT1 = 16'h5aaa;
    defparam add_76_9.INJECT1_0 = "NO";
    defparam add_76_9.INJECT1_1 = "NO";
    CCU2D add_76_7 (.A0(\debounce_counters[2] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1681), .COUT(n1682), .S0(n458), 
          .S1(n457));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_7.INIT0 = 16'h5aaa;
    defparam add_76_7.INIT1 = 16'h5aaa;
    defparam add_76_7.INJECT1_0 = "NO";
    defparam add_76_7.INJECT1_1 = "NO";
    CCU2D add_76_5 (.A0(\debounce_counters[2] [3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1680), .COUT(n1681), .S0(n460), 
          .S1(n459));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_5.INIT0 = 16'h5aaa;
    defparam add_76_5.INIT1 = 16'h5aaa;
    defparam add_76_5.INJECT1_0 = "NO";
    defparam add_76_5.INJECT1_1 = "NO";
    CCU2D add_76_3 (.A0(\debounce_counters[2] [1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[2] [2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1679), .COUT(n1680), .S0(n462), 
          .S1(n461));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_3.INIT0 = 16'h5aaa;
    defparam add_76_3.INIT1 = 16'h5aaa;
    defparam add_76_3.INJECT1_0 = "NO";
    defparam add_76_3.INJECT1_1 = "NO";
    CCU2D add_76_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(\debounce_counters[2] [0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .COUT(n1679), .S1(n463));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_76_1.INIT0 = 16'hF000;
    defparam add_76_1.INIT1 = 16'h5555;
    defparam add_76_1.INJECT1_0 = "NO";
    defparam add_76_1.INJECT1_1 = "NO";
    CCU2D add_68_33 (.A0(\debounce_counters[1] [31]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n1678), .S0(n327));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_33.INIT0 = 16'h5aaa;
    defparam add_68_33.INIT1 = 16'h0000;
    defparam add_68_33.INJECT1_0 = "NO";
    defparam add_68_33.INJECT1_1 = "NO";
    CCU2D add_68_31 (.A0(\debounce_counters[1] [29]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [30]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1677), .COUT(n1678), .S0(n329), 
          .S1(n328));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_31.INIT0 = 16'h5aaa;
    defparam add_68_31.INIT1 = 16'h5aaa;
    defparam add_68_31.INJECT1_0 = "NO";
    defparam add_68_31.INJECT1_1 = "NO";
    CCU2D add_68_29 (.A0(\debounce_counters[1] [27]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [28]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1676), .COUT(n1677), .S0(n331), 
          .S1(n330));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_29.INIT0 = 16'h5aaa;
    defparam add_68_29.INIT1 = 16'h5aaa;
    defparam add_68_29.INJECT1_0 = "NO";
    defparam add_68_29.INJECT1_1 = "NO";
    CCU2D add_68_27 (.A0(\debounce_counters[1] [25]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [26]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1675), .COUT(n1676), .S0(n333), 
          .S1(n332));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_27.INIT0 = 16'h5aaa;
    defparam add_68_27.INIT1 = 16'h5aaa;
    defparam add_68_27.INJECT1_0 = "NO";
    defparam add_68_27.INJECT1_1 = "NO";
    CCU2D add_68_25 (.A0(\debounce_counters[1] [23]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [24]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1674), .COUT(n1675), .S0(n335), 
          .S1(n334));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_25.INIT0 = 16'h5aaa;
    defparam add_68_25.INIT1 = 16'h5aaa;
    defparam add_68_25.INJECT1_0 = "NO";
    defparam add_68_25.INJECT1_1 = "NO";
    CCU2D add_68_23 (.A0(\debounce_counters[1] [21]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [22]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1673), .COUT(n1674), .S0(n337), 
          .S1(n336));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_23.INIT0 = 16'h5aaa;
    defparam add_68_23.INIT1 = 16'h5aaa;
    defparam add_68_23.INJECT1_0 = "NO";
    defparam add_68_23.INJECT1_1 = "NO";
    CCU2D add_68_21 (.A0(\debounce_counters[1] [19]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [20]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1672), .COUT(n1673), .S0(n339), 
          .S1(n338));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_21.INIT0 = 16'h5aaa;
    defparam add_68_21.INIT1 = 16'h5aaa;
    defparam add_68_21.INJECT1_0 = "NO";
    defparam add_68_21.INJECT1_1 = "NO";
    CCU2D add_68_19 (.A0(\debounce_counters[1] [17]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [18]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1671), .COUT(n1672), .S0(n341), 
          .S1(n340));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_19.INIT0 = 16'h5aaa;
    defparam add_68_19.INIT1 = 16'h5aaa;
    defparam add_68_19.INJECT1_0 = "NO";
    defparam add_68_19.INJECT1_1 = "NO";
    CCU2D add_68_17 (.A0(\debounce_counters[1] [15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1670), .COUT(n1671), .S0(n343), 
          .S1(n342));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_17.INIT0 = 16'h5aaa;
    defparam add_68_17.INIT1 = 16'h5aaa;
    defparam add_68_17.INJECT1_0 = "NO";
    defparam add_68_17.INJECT1_1 = "NO";
    CCU2D add_68_15 (.A0(\debounce_counters[1] [13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1669), .COUT(n1670), .S0(n345), 
          .S1(n344));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_15.INIT0 = 16'h5aaa;
    defparam add_68_15.INIT1 = 16'h5aaa;
    defparam add_68_15.INJECT1_0 = "NO";
    defparam add_68_15.INJECT1_1 = "NO";
    CCU2D add_68_13 (.A0(\debounce_counters[1] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1668), .COUT(n1669), .S0(n347), 
          .S1(n346));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_13.INIT0 = 16'h5aaa;
    defparam add_68_13.INIT1 = 16'h5aaa;
    defparam add_68_13.INJECT1_0 = "NO";
    defparam add_68_13.INJECT1_1 = "NO";
    CCU2D add_68_11 (.A0(\debounce_counters[1] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1667), .COUT(n1668), .S0(n349), 
          .S1(n348));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_11.INIT0 = 16'h5aaa;
    defparam add_68_11.INIT1 = 16'h5aaa;
    defparam add_68_11.INJECT1_0 = "NO";
    defparam add_68_11.INJECT1_1 = "NO";
    CCU2D add_68_9 (.A0(\debounce_counters[1] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1666), .COUT(n1667), .S0(n351), 
          .S1(n350));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_9.INIT0 = 16'h5aaa;
    defparam add_68_9.INIT1 = 16'h5aaa;
    defparam add_68_9.INJECT1_0 = "NO";
    defparam add_68_9.INJECT1_1 = "NO";
    CCU2D add_68_7 (.A0(\debounce_counters[1] [5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[1] [6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1665), .COUT(n1666), .S0(n353), 
          .S1(n352));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_68_7.INIT0 = 16'h5aaa;
    defparam add_68_7.INIT1 = 16'h5aaa;
    defparam add_68_7.INJECT1_0 = "NO";
    defparam add_68_7.INJECT1_1 = "NO";
    LUT4 i14_3_lut_adj_3 (.A(current_state[1]), .B(current_state[2]), .C(current_state[0]), 
         .Z(State_LED_0_0)) /* synthesis lut_function=(A (B+!(C))+!A (C)) */ ;
    defparam i14_3_lut_adj_3.init = 16'hdada;
    LUT4 current_state_2__I_0_133_Mux_2_i7_4_lut (.A(next_state_2__N_41[1]), 
         .B(current_state[2]), .C(current_state[1]), .D(current_state[0]), 
         .Z(next_state[2])) /* synthesis lut_function=(!(A (B (C)+!B !(C (D)))+!A (B (C)+!B !(C)))) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(183[9] 214[18])
    defparam current_state_2__I_0_133_Mux_2_i7_4_lut.init = 16'h3c1c;
    LUT4 i463_2_lut (.A(Carrier_PG_1V8_N_359), .B(Carrier_PG_1V8_N_360), 
         .Z(n1401)) /* synthesis lut_function=(!(A (B))) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(114[5] 137[17])
    defparam i463_2_lut.init = 16'h7777;
    CCU2D add_60_13 (.A0(\debounce_counters[0] [11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1652), .COUT(n1653), .S0(n242), 
          .S1(n241));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_13.INIT0 = 16'h5aaa;
    defparam add_60_13.INIT1 = 16'h5aaa;
    defparam add_60_13.INJECT1_0 = "NO";
    defparam add_60_13.INJECT1_1 = "NO";
    CCU2D add_60_11 (.A0(\debounce_counters[0] [9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1651), .COUT(n1652), .S0(n244), 
          .S1(n243));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_11.INIT0 = 16'h5aaa;
    defparam add_60_11.INIT1 = 16'h5aaa;
    defparam add_60_11.INJECT1_0 = "NO";
    defparam add_60_11.INJECT1_1 = "NO";
    CCU2D add_60_9 (.A0(\debounce_counters[0] [7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(\debounce_counters[0] [8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n1650), .COUT(n1651), .S0(n246), 
          .S1(n245));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(152[53:73])
    defparam add_60_9.INIT0 = 16'h5aaa;
    defparam add_60_9.INIT1 = 16'h5aaa;
    defparam add_60_9.INJECT1_0 = "NO";
    defparam add_60_9.INJECT1_1 = "NO";
    LUT4 i4_4_lut (.A(count_50ms[16]), .B(count_50ms[15]), .C(count_50ms[12]), 
         .D(n6), .Z(n1449)) /* synthesis lut_function=(A (B (C (D)))) */ ;
    defparam i4_4_lut.init = 16'h8000;
    LUT4 i366_1_lut (.A(RESET_c), .Z(n1482)) /* synthesis lut_function=(!(A)) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(11[3:8])
    defparam i366_1_lut.init = 16'h5555;
    LUT4 i249_1_lut (.A(SysSW_Pwr_NC_c), .Z(n1364)) /* synthesis lut_function=(!(A)) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(21[3:15])
    defparam i249_1_lut.init = 16'h5555;
    LUT4 i381_2_lut_4_lut (.A(n8_adj_1), .B(n1510), .C(n1832), .D(count_done_100ms), 
         .Z(count_done_100ms_N_193)) /* synthesis lut_function=(A (B (C+(D))+!B (D))+!A (D)) */ ;
    defparam i381_2_lut_4_lut.init = 16'hff80;
    LUT4 current_state_2__I_0_133_Mux_1_i3_3_lut (.A(current_state[0]), .B(next_state_2__N_41[1]), 
         .C(current_state[1]), .Z(n3)) /* synthesis lut_function=(!(A (C)+!A !(B (C)))) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(183[9] 214[18])
    defparam current_state_2__I_0_133_Mux_1_i3_3_lut.init = 16'h4a4a;
    LUT4 i1_2_lut (.A(count_50ms[13]), .B(count_50ms[14]), .Z(n6)) /* synthesis lut_function=(A (B)) */ ;
    defparam i1_2_lut.init = 16'h8888;
    LUT4 i475_2_lut (.A(clk_enable_12), .B(FP_UsrSW3_c), .Z(clk_enable_57)) /* synthesis lut_function=(!(A (B))) */ ;
    defparam i475_2_lut.init = 16'h7777;
    LUT4 i251_1_lut_3_lut (.A(Carrier_PG_1V8_N_375), .B(n1830), .C(count_done_100ms), 
         .Z(n1361)) /* synthesis lut_function=(!(A (B+(C))+!A !((C)+!B))) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(117[13] 135[20])
    defparam i251_1_lut_3_lut.init = 16'h5353;
    VLO i1 (.Z(GND_net));
    TSALL TSALL_INST (.TSALL(GND_net));
    LUT4 i396_2_lut_rep_9 (.A(count_50ms[10]), .B(count_50ms[11]), .Z(n1831)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i396_2_lut_rep_9.init = 16'heeee;
    LUT4 Carrier_PG_1V8_I_5_3_lut_rep_7 (.A(Carrier_PG_1V8_N_375), .B(n1830), 
         .C(count_done_100ms), .Z(clk_enable_3)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(117[13] 135[20])
    defparam Carrier_PG_1V8_I_5_3_lut_rep_7.init = 16'hacac;
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    GSR GSR_INST (.GSR(n1482));
    FD1P3AX count_50ms_229__i2 (.D(n88_adj_22), .SP(FP_UsrLED1_N_352), .CK(clk), 
            .Q(n15_adj_4)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i2.GSR = "DISABLED";
    FD1P3AX count_50ms_229__i3 (.D(n87_adj_21), .SP(FP_UsrLED1_N_352), .CK(clk), 
            .Q(n14_adj_5)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i3.GSR = "DISABLED";
    FD1P3AX count_50ms_229__i4 (.D(n86_adj_20), .SP(FP_UsrLED1_N_352), .CK(clk), 
            .Q(n13_adj_6)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i4.GSR = "DISABLED";
    FD1P3AX count_50ms_229__i5 (.D(n85_adj_19), .SP(FP_UsrLED1_N_352), .CK(clk), 
            .Q(n12_adj_7)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i5.GSR = "DISABLED";
    FD1P3AX count_50ms_229__i6 (.D(n84_adj_18), .SP(FP_UsrLED1_N_352), .CK(clk), 
            .Q(n11_adj_8)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i6.GSR = "DISABLED";
    FD1P3AX count_50ms_229__i7 (.D(n83_adj_17), .SP(FP_UsrLED1_N_352), .CK(clk), 
            .Q(n10_adj_9)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i7.GSR = "DISABLED";
    FD1P3AX count_50ms_229__i8 (.D(n82_adj_16), .SP(FP_UsrLED1_N_352), .CK(clk), 
            .Q(n9_adj_10)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i8.GSR = "DISABLED";
    FD1P3AX count_50ms_229__i9 (.D(n81_adj_15), .SP(FP_UsrLED1_N_352), .CK(clk), 
            .Q(n8_adj_11)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i9.GSR = "DISABLED";
    FD1P3AX count_50ms_229__i10 (.D(n80_adj_14), .SP(FP_UsrLED1_N_352), 
            .CK(clk), .Q(count_50ms[10])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i10.GSR = "DISABLED";
    FD1P3AX count_50ms_229__i11 (.D(n79_adj_13), .SP(FP_UsrLED1_N_352), 
            .CK(clk), .Q(count_50ms[11])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i11.GSR = "DISABLED";
    FD1P3AX count_50ms_229__i12 (.D(n78_adj_12), .SP(FP_UsrLED1_N_352), 
            .CK(clk), .Q(count_50ms[12])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i12.GSR = "DISABLED";
    FD1P3AX count_50ms_229__i13 (.D(n77), .SP(FP_UsrLED1_N_352), .CK(clk), 
            .Q(count_50ms[13])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i13.GSR = "DISABLED";
    FD1P3AX count_50ms_229__i14 (.D(n76), .SP(FP_UsrLED1_N_352), .CK(clk), 
            .Q(count_50ms[14])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i14.GSR = "DISABLED";
    FD1P3AX count_50ms_229__i15 (.D(n75), .SP(FP_UsrLED1_N_352), .CK(clk), 
            .Q(count_50ms[15])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i15.GSR = "DISABLED";
    FD1P3AX count_50ms_229__i16 (.D(n74), .SP(FP_UsrLED1_N_352), .CK(clk), 
            .Q(count_50ms[16])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(129[35:45])
    defparam count_50ms_229__i16.GSR = "DISABLED";
    LUT4 i2_3_lut_rep_8_4_lut (.A(count_100ms[16]), .B(count_100ms[15]), 
         .C(n1510), .D(n8_adj_1), .Z(n1830)) /* synthesis lut_function=(A (B (C (D)))) */ ;
    defparam i2_3_lut_rep_8_4_lut.init = 16'h8000;
    LUT4 i245_1_lut (.A(FP_UsrSW2_c), .Z(n1368)) /* synthesis lut_function=(!(A)) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(23[3:12])
    defparam i245_1_lut.init = 16'h5555;
    LUT4 i472_2_lut (.A(clk_enable_135), .B(SysSW_Pwr_NC_c), .Z(clk_enable_137)) /* synthesis lut_function=(!(A (B))) */ ;
    defparam i472_2_lut.init = 16'h7777;
    FD1P3IX debounce_counters_3___i17 (.D(n551), .SP(clk_enable_137), .CD(n1364), 
            .CK(clk), .Q(\debounce_counters[3] [17])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(144[9] 161[16])
    defparam debounce_counters_3___i17.GSR = "ENABLED";
    LUT4 m1_lut (.Z(n1836)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    LUT4 i4_2_lut_3_lut (.A(count_100ms[16]), .B(count_100ms[15]), .C(n8_adj_1), 
         .Z(n1450)) /* synthesis lut_function=(A (B (C))) */ ;
    defparam i4_2_lut_3_lut.init = 16'h8080;
    LUT4 i2_3_lut_rep_11 (.A(Carrier_PwrOn_c), .B(current_state[2]), .C(current_state[1]), 
         .Z(n1833)) /* synthesis lut_function=(A+(B+!(C))) */ ;
    defparam i2_3_lut_rep_11.init = 16'hefef;
    
endmodule
//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

