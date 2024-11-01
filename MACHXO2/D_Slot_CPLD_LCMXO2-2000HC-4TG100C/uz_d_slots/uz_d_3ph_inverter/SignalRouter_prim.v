// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.14.0.75.2
// Netlist written on Fri Nov 01 16:21:56 2024
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
            d_23, d_24, d_25, d_26, d_27, d_28, d_29);   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(5[8:20])
    input fpga_00;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(8[9:16])
    input fpga_01;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(9[9:16])
    input fpga_02;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(10[9:16])
    input fpga_03;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(11[9:16])
    input fpga_04;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(12[9:16])
    input fpga_05;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(13[9:16])
    output fpga_06;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(14[9:16])
    output fpga_07;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(15[9:16])
    output fpga_08;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(16[9:16])
    output fpga_09;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(17[9:16])
    output fpga_10;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(18[9:16])
    output fpga_11;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(19[9:16])
    output fpga_12;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(20[9:16])
    output fpga_13;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(21[9:16])
    input fpga_14;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(22[9:16])
    output fpga_15;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(23[9:16])
    output fpga_16;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(24[9:16])
    output fpga_17;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(25[9:16])
    output fpga_18;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(26[9:16])
    output fpga_19;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(27[9:16])
    output fpga_20;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(28[9:16])
    output fpga_21;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(29[9:16])
    output fpga_22;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(30[9:16])
    output fpga_23;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(31[9:16])
    output fpga_24;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(32[9:16])
    output fpga_25;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(33[9:16])
    output fpga_26;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(34[9:16])
    output fpga_27;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(35[9:16])
    output fpga_28;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(36[9:16])
    output fpga_29;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(37[9:16])
    output d_00;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(40[9:13])
    output d_01;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(41[9:13])
    output d_02;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(42[9:13])
    output d_03;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(43[9:13])
    output d_04;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(44[9:13])
    output d_05;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(45[9:13])
    input d_06;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(46[9:13])
    input d_07;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(47[9:13])
    input d_08;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(48[9:13])
    input d_09;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(49[9:13])
    input d_10;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(50[9:13])
    input d_11;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(51[9:13])
    input d_12;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(52[9:13])
    input d_13;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(53[9:13])
    output d_14;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(54[9:13])
    input d_15;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(55[9:13])
    input d_16;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(56[9:13])
    input d_17;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(57[9:13])
    input d_18;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(58[9:13])
    input d_19;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(59[9:13])
    input d_20;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(60[9:13])
    input d_21;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(61[9:13])
    input d_22;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(62[9:13])
    input d_23;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(63[9:13])
    input d_24;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(64[9:13])
    input d_25;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(65[9:13])
    input d_26;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(66[9:13])
    input d_27;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(67[9:13])
    input d_28;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(68[9:13])
    input d_29;   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(69[9:13])
    
    
    wire d_00_c_c, d_01_c_c, d_02_c_c, d_03_c_c, d_04_c_c, d_05_c_c, 
        fpga_06_c_c, fpga_07_c_c, fpga_08_c_c, fpga_09_c_c, fpga_10_c_c, 
        fpga_11_c_c, fpga_12_c_c, fpga_13_c_c, d_14_c_c, fpga_15_c_c, 
        fpga_16_c_c, fpga_17_c_c, fpga_18_c_c, fpga_19_c_c, fpga_20_c_c, 
        fpga_21_c_c, fpga_22_c_c, fpga_23_c_c, fpga_24_c_c, fpga_25_c_c, 
        fpga_26_c_c, fpga_27_c_c, fpga_28_c_c, fpga_29_c_c, GND_net, 
        VCC_net;
    
    VLO i23 (.Z(GND_net));
    OB fpga_06_pad (.I(fpga_06_c_c), .O(fpga_06));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(14[9:16])
    OB fpga_07_pad (.I(fpga_07_c_c), .O(fpga_07));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(15[9:16])
    OB fpga_08_pad (.I(fpga_08_c_c), .O(fpga_08));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(16[9:16])
    OB fpga_09_pad (.I(fpga_09_c_c), .O(fpga_09));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(17[9:16])
    OB fpga_10_pad (.I(fpga_10_c_c), .O(fpga_10));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(18[9:16])
    OB fpga_11_pad (.I(fpga_11_c_c), .O(fpga_11));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(19[9:16])
    OB fpga_12_pad (.I(fpga_12_c_c), .O(fpga_12));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(20[9:16])
    OB fpga_13_pad (.I(fpga_13_c_c), .O(fpga_13));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(21[9:16])
    OB fpga_15_pad (.I(fpga_15_c_c), .O(fpga_15));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(23[9:16])
    OB fpga_16_pad (.I(fpga_16_c_c), .O(fpga_16));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(24[9:16])
    OB fpga_17_pad (.I(fpga_17_c_c), .O(fpga_17));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(25[9:16])
    OB fpga_18_pad (.I(fpga_18_c_c), .O(fpga_18));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(26[9:16])
    OB fpga_19_pad (.I(fpga_19_c_c), .O(fpga_19));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(27[9:16])
    OB fpga_20_pad (.I(fpga_20_c_c), .O(fpga_20));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(28[9:16])
    OB fpga_21_pad (.I(fpga_21_c_c), .O(fpga_21));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(29[9:16])
    OB fpga_22_pad (.I(fpga_22_c_c), .O(fpga_22));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(30[9:16])
    OB fpga_23_pad (.I(fpga_23_c_c), .O(fpga_23));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(31[9:16])
    OB fpga_24_pad (.I(fpga_24_c_c), .O(fpga_24));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(32[9:16])
    OB fpga_25_pad (.I(fpga_25_c_c), .O(fpga_25));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(33[9:16])
    OB fpga_26_pad (.I(fpga_26_c_c), .O(fpga_26));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(34[9:16])
    OB fpga_27_pad (.I(fpga_27_c_c), .O(fpga_27));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(35[9:16])
    OB fpga_28_pad (.I(fpga_28_c_c), .O(fpga_28));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(36[9:16])
    OB fpga_29_pad (.I(fpga_29_c_c), .O(fpga_29));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(37[9:16])
    OB d_00_pad (.I(d_00_c_c), .O(d_00));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(40[9:13])
    OB d_01_pad (.I(d_01_c_c), .O(d_01));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(41[9:13])
    OB d_02_pad (.I(d_02_c_c), .O(d_02));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(42[9:13])
    OB d_03_pad (.I(d_03_c_c), .O(d_03));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(43[9:13])
    OB d_04_pad (.I(d_04_c_c), .O(d_04));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(44[9:13])
    OB d_05_pad (.I(d_05_c_c), .O(d_05));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(45[9:13])
    OB d_14_pad (.I(d_14_c_c), .O(d_14));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(54[9:13])
    IB d_00_c_pad (.I(fpga_00), .O(d_00_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(8[9:16])
    IB d_01_c_pad (.I(fpga_01), .O(d_01_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(9[9:16])
    IB d_02_c_pad (.I(fpga_02), .O(d_02_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(10[9:16])
    IB d_03_c_pad (.I(fpga_03), .O(d_03_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(11[9:16])
    IB d_04_c_pad (.I(fpga_04), .O(d_04_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(12[9:16])
    IB d_05_c_pad (.I(fpga_05), .O(d_05_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(13[9:16])
    IB d_14_c_pad (.I(fpga_14), .O(d_14_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(22[9:16])
    IB fpga_06_c_pad (.I(d_06), .O(fpga_06_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(46[9:13])
    IB fpga_07_c_pad (.I(d_07), .O(fpga_07_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(47[9:13])
    IB fpga_08_c_pad (.I(d_08), .O(fpga_08_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(48[9:13])
    IB fpga_09_c_pad (.I(d_09), .O(fpga_09_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(49[9:13])
    IB fpga_10_c_pad (.I(d_10), .O(fpga_10_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(50[9:13])
    IB fpga_11_c_pad (.I(d_11), .O(fpga_11_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(51[9:13])
    IB fpga_12_c_pad (.I(d_12), .O(fpga_12_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(52[9:13])
    IB fpga_13_c_pad (.I(d_13), .O(fpga_13_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(53[9:13])
    IB fpga_15_c_pad (.I(d_15), .O(fpga_15_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(55[9:13])
    IB fpga_16_c_pad (.I(d_16), .O(fpga_16_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(56[9:13])
    IB fpga_17_c_pad (.I(d_17), .O(fpga_17_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(57[9:13])
    IB fpga_18_c_pad (.I(d_18), .O(fpga_18_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(58[9:13])
    IB fpga_19_c_pad (.I(d_19), .O(fpga_19_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(59[9:13])
    IB fpga_20_c_pad (.I(d_20), .O(fpga_20_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(60[9:13])
    IB fpga_21_c_pad (.I(d_21), .O(fpga_21_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(61[9:13])
    IB fpga_22_c_pad (.I(d_22), .O(fpga_22_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(62[9:13])
    IB fpga_23_c_pad (.I(d_23), .O(fpga_23_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(63[9:13])
    IB fpga_24_c_pad (.I(d_24), .O(fpga_24_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(64[9:13])
    IB fpga_25_c_pad (.I(d_25), .O(fpga_25_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(65[9:13])
    IB fpga_26_c_pad (.I(d_26), .O(fpga_26_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(66[9:13])
    IB fpga_27_c_pad (.I(d_27), .O(fpga_27_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(67[9:13])
    IB fpga_28_c_pad (.I(d_28), .O(fpga_28_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(68[9:13])
    IB fpga_29_c_pad (.I(d_29), .O(fpga_29_c_c));   // c:/git/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_3ph_inverter.vhdl(69[9:13])
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

