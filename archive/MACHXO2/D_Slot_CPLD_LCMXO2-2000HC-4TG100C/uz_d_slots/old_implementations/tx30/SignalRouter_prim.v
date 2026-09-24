// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.14.0.75.2
// Netlist written on Fri Nov 01 14:28:39 2024
//
// Verilog Description of module SignalRouter
//

module SignalRouter (fpga_00, fpga_01, fpga_02, fpga_03, fpga_04, 
            fpga_05, fpga_06, fpga_07, fpga_08, fpga_09, fpga_10, 
            fpga_11, fpga_12, fpga_13, fpga_14, fpga_15, fpga_16, 
            fpga_17, fpga_18, fpga_19, fpga_20, fpga_21, fpga_22, 
            fpga_23, fpga_24, fpga_25, fpga_26, fpga_27, fpga_28, 
            fpga_29, d_00, d_01, d_02, d_03, d_04, d_05, d_06, 
            d_07, d_08, d_09, d_10, d_11, d_12, d_13, d_14, 
            d_15, d_16, d_17, d_18, d_19, d_20, d_21, d_22, 
            d_23, d_24, d_25, d_26, d_27, d_28, d_29);   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(5[8:20])
    input fpga_00;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(8[9:16])
    input fpga_01;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(9[9:16])
    input fpga_02;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(10[9:16])
    input fpga_03;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(11[9:16])
    input fpga_04;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(12[9:16])
    input fpga_05;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(13[9:16])
    input fpga_06;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(14[9:16])
    input fpga_07;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(15[9:16])
    input fpga_08;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(16[9:16])
    input fpga_09;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(17[9:16])
    input fpga_10;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(18[9:16])
    input fpga_11;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(19[9:16])
    input fpga_12;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(20[9:16])
    input fpga_13;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(21[9:16])
    input fpga_14;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(22[9:16])
    input fpga_15;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(23[9:16])
    input fpga_16;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(24[9:16])
    input fpga_17;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(25[9:16])
    input fpga_18;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(26[9:16])
    input fpga_19;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(27[9:16])
    input fpga_20;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(28[9:16])
    input fpga_21;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(29[9:16])
    input fpga_22;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(30[9:16])
    input fpga_23;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(31[9:16])
    input fpga_24;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(32[9:16])
    input fpga_25;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(33[9:16])
    input fpga_26;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(34[9:16])
    input fpga_27;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(35[9:16])
    input fpga_28;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(36[9:16])
    input fpga_29;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(37[9:16])
    output d_00;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(40[9:13])
    output d_01;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(41[9:13])
    output d_02;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(42[9:13])
    output d_03;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(43[9:13])
    output d_04;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(44[9:13])
    output d_05;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(45[9:13])
    output d_06;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(46[9:13])
    output d_07;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(47[9:13])
    output d_08;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(48[9:13])
    output d_09;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(49[9:13])
    output d_10;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(50[9:13])
    output d_11;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(51[9:13])
    output d_12;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(52[9:13])
    output d_13;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(53[9:13])
    output d_14;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(54[9:13])
    output d_15;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(55[9:13])
    output d_16;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(56[9:13])
    output d_17;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(57[9:13])
    output d_18;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(58[9:13])
    output d_19;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(59[9:13])
    output d_20;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(60[9:13])
    output d_21;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(61[9:13])
    output d_22;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(62[9:13])
    output d_23;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(63[9:13])
    output d_24;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(64[9:13])
    output d_25;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(65[9:13])
    output d_26;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(66[9:13])
    output d_27;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(67[9:13])
    output d_28;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(68[9:13])
    output d_29;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(69[9:13])
    
    
    wire d_00_c_c, d_01_c_c, d_02_c_c, d_03_c_c, d_04_c_c, d_05_c_c, 
        d_06_c_c, d_07_c_c, d_08_c_c, d_09_c_c, d_10_c_c, d_11_c_c, 
        d_12_c_c, d_13_c_c, d_14_c_c, d_15_c_c, d_16_c_c, d_17_c_c, 
        d_18_c_c, d_19_c_c, d_20_c_c, d_21_c_c, d_22_c_c, d_23_c_c, 
        d_24_c_c, d_25_c_c, d_26_c_c, d_27_c_c, d_28_c_c, d_29_c_c, 
        GND_net, VCC_net;
    
    VLO i23 (.Z(GND_net));
    OB d_00_pad (.I(d_00_c_c), .O(d_00));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(40[9:13])
    OB d_01_pad (.I(d_01_c_c), .O(d_01));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(41[9:13])
    OB d_02_pad (.I(d_02_c_c), .O(d_02));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(42[9:13])
    OB d_03_pad (.I(d_03_c_c), .O(d_03));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(43[9:13])
    OB d_04_pad (.I(d_04_c_c), .O(d_04));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(44[9:13])
    OB d_05_pad (.I(d_05_c_c), .O(d_05));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(45[9:13])
    OB d_06_pad (.I(d_06_c_c), .O(d_06));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(46[9:13])
    OB d_07_pad (.I(d_07_c_c), .O(d_07));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(47[9:13])
    OB d_08_pad (.I(d_08_c_c), .O(d_08));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(48[9:13])
    OB d_09_pad (.I(d_09_c_c), .O(d_09));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(49[9:13])
    OB d_10_pad (.I(d_10_c_c), .O(d_10));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(50[9:13])
    OB d_11_pad (.I(d_11_c_c), .O(d_11));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(51[9:13])
    OB d_12_pad (.I(d_12_c_c), .O(d_12));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(52[9:13])
    OB d_13_pad (.I(d_13_c_c), .O(d_13));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(53[9:13])
    OB d_14_pad (.I(d_14_c_c), .O(d_14));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(54[9:13])
    OB d_15_pad (.I(d_15_c_c), .O(d_15));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(55[9:13])
    OB d_16_pad (.I(d_16_c_c), .O(d_16));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(56[9:13])
    OB d_17_pad (.I(d_17_c_c), .O(d_17));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(57[9:13])
    OB d_18_pad (.I(d_18_c_c), .O(d_18));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(58[9:13])
    OB d_19_pad (.I(d_19_c_c), .O(d_19));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(59[9:13])
    OB d_20_pad (.I(d_20_c_c), .O(d_20));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(60[9:13])
    OB d_21_pad (.I(d_21_c_c), .O(d_21));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(61[9:13])
    OB d_22_pad (.I(d_22_c_c), .O(d_22));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(62[9:13])
    OB d_23_pad (.I(d_23_c_c), .O(d_23));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(63[9:13])
    OB d_24_pad (.I(d_24_c_c), .O(d_24));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(64[9:13])
    OB d_25_pad (.I(d_25_c_c), .O(d_25));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(65[9:13])
    OB d_26_pad (.I(d_26_c_c), .O(d_26));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(66[9:13])
    OB d_27_pad (.I(d_27_c_c), .O(d_27));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(67[9:13])
    OB d_28_pad (.I(d_28_c_c), .O(d_28));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(68[9:13])
    OB d_29_pad (.I(d_29_c_c), .O(d_29));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(69[9:13])
    IB d_00_c_pad (.I(fpga_00), .O(d_00_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(8[9:16])
    IB d_01_c_pad (.I(fpga_01), .O(d_01_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(9[9:16])
    IB d_02_c_pad (.I(fpga_02), .O(d_02_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(10[9:16])
    IB d_03_c_pad (.I(fpga_03), .O(d_03_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(11[9:16])
    IB d_04_c_pad (.I(fpga_04), .O(d_04_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(12[9:16])
    IB d_05_c_pad (.I(fpga_05), .O(d_05_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(13[9:16])
    IB d_06_c_pad (.I(fpga_06), .O(d_06_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(14[9:16])
    IB d_07_c_pad (.I(fpga_07), .O(d_07_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(15[9:16])
    IB d_08_c_pad (.I(fpga_08), .O(d_08_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(16[9:16])
    IB d_09_c_pad (.I(fpga_09), .O(d_09_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(17[9:16])
    IB d_10_c_pad (.I(fpga_10), .O(d_10_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(18[9:16])
    IB d_11_c_pad (.I(fpga_11), .O(d_11_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(19[9:16])
    IB d_12_c_pad (.I(fpga_12), .O(d_12_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(20[9:16])
    IB d_13_c_pad (.I(fpga_13), .O(d_13_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(21[9:16])
    IB d_14_c_pad (.I(fpga_14), .O(d_14_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(22[9:16])
    IB d_15_c_pad (.I(fpga_15), .O(d_15_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(23[9:16])
    IB d_16_c_pad (.I(fpga_16), .O(d_16_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(24[9:16])
    IB d_17_c_pad (.I(fpga_17), .O(d_17_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(25[9:16])
    IB d_18_c_pad (.I(fpga_18), .O(d_18_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(26[9:16])
    IB d_19_c_pad (.I(fpga_19), .O(d_19_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(27[9:16])
    IB d_20_c_pad (.I(fpga_20), .O(d_20_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(28[9:16])
    IB d_21_c_pad (.I(fpga_21), .O(d_21_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(29[9:16])
    IB d_22_c_pad (.I(fpga_22), .O(d_22_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(30[9:16])
    IB d_23_c_pad (.I(fpga_23), .O(d_23_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(31[9:16])
    IB d_24_c_pad (.I(fpga_24), .O(d_24_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(32[9:16])
    IB d_25_c_pad (.I(fpga_25), .O(d_25_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(33[9:16])
    IB d_26_c_pad (.I(fpga_26), .O(d_26_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(34[9:16])
    IB d_27_c_pad (.I(fpga_27), .O(d_27_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(35[9:16])
    IB d_28_c_pad (.I(fpga_28), .O(d_28_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(36[9:16])
    IB d_29_c_pad (.I(fpga_29), .O(d_29_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx30.vhdl(37[9:16])
    GSR GSR_INST (.GSR(VCC_net));
    TSALL TSALL_INST (.TSALL(GND_net));
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    VHI i24 (.Z(VCC_net));
    
endmodule
//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

