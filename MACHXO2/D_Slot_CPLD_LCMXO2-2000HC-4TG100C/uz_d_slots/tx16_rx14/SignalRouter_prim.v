// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Mon Jun 23 09:34:38 2025
//
// Verilog Description of module SignalRouter
//

module SignalRouter (pilot_in, reqsafestate, carrierrdy, slotok, reqoe, 
            i2c_scl, i2c_sda, fpga_00, fpga_01, fpga_02, fpga_03, 
            fpga_04, fpga_05, fpga_06, fpga_07, fpga_08, fpga_09, 
            fpga_10, fpga_11, fpga_12, fpga_13, fpga_14, fpga_15, 
            fpga_16, fpga_17, fpga_18, fpga_19, fpga_20, fpga_21, 
            fpga_22, fpga_23, fpga_24, fpga_25, fpga_26, fpga_27, 
            fpga_28, fpga_29, d_00, d_01, d_02, d_03, d_04, d_05, 
            d_06, d_07, d_08, d_09, d_10, d_11, d_12, d_13, 
            d_14, d_15, d_16, d_17, d_18, d_19, d_20, d_21, 
            d_22, d_23, d_24, d_25, d_26, d_27, d_28, d_29);   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(5[8:20])
    input pilot_in;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(8[3:11])
    input reqsafestate;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(9[3:15])
    input carrierrdy;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(10[3:13])
    output slotok;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(11[3:9])
    output reqoe;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(12[3:8])
    input i2c_scl;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(15[9:16])
    input i2c_sda;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(16[9:16])
    input fpga_00;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(18[9:16])
    input fpga_01;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(19[9:16])
    input fpga_02;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(20[9:16])
    input fpga_03;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(21[9:16])
    input fpga_04;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(22[9:16])
    input fpga_05;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(23[9:16])
    input fpga_06;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(24[9:16])
    input fpga_07;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(25[9:16])
    input fpga_08;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(26[9:16])
    input fpga_09;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(27[9:16])
    input fpga_10;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(28[9:16])
    input fpga_11;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(29[9:16])
    input fpga_12;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(30[9:16])
    input fpga_13;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(31[9:16])
    input fpga_14;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(32[9:16])
    input fpga_15;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(33[9:16])
    output fpga_16;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(34[9:16])
    output fpga_17;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(35[9:16])
    output fpga_18;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(36[9:16])
    output fpga_19;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(37[9:16])
    output fpga_20;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(38[9:16])
    output fpga_21;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(39[9:16])
    output fpga_22;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(40[9:16])
    output fpga_23;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(41[9:16])
    output fpga_24;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(42[9:16])
    output fpga_25;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(43[9:16])
    output fpga_26;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(44[9:16])
    output fpga_27;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(45[9:16])
    output fpga_28;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(46[9:16])
    output fpga_29;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(47[9:16])
    output d_00;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(50[9:13])
    output d_01;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(51[9:13])
    output d_02;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(52[9:13])
    output d_03;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(53[9:13])
    output d_04;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(54[9:13])
    output d_05;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(55[9:13])
    output d_06;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(56[9:13])
    output d_07;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(57[9:13])
    output d_08;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(58[9:13])
    output d_09;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(59[9:13])
    output d_10;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(60[9:13])
    output d_11;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(61[9:13])
    output d_12;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(62[9:13])
    output d_13;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(63[9:13])
    output d_14;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(64[9:13])
    output d_15;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(65[9:13])
    input d_16;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(66[9:13])
    input d_17;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(67[9:13])
    input d_18;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(68[9:13])
    input d_19;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(69[9:13])
    input d_20;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(70[9:13])
    input d_21;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(71[9:13])
    input d_22;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(72[9:13])
    input d_23;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(73[9:13])
    input d_24;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(74[9:13])
    input d_25;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(75[9:13])
    input d_26;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(76[9:13])
    input d_27;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(77[9:13])
    input d_28;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(78[9:13])
    input d_29;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(79[9:13])
    
    
    wire pilot_in_c, reqsafestate_c, carrierrdy_c, i2c_scl_c, i2c_sda_c, 
        fpga_00_c, fpga_01_c, fpga_02_c, fpga_03_c, fpga_04_c, fpga_05_c, 
        fpga_06_c, fpga_07_c, fpga_08_c, fpga_09_c, fpga_10_c, fpga_11_c, 
        fpga_12_c, fpga_13_c, fpga_14_c, fpga_15_c, fpga_16_c_c, fpga_17_c_c, 
        fpga_18_c_c, fpga_19_c_c, fpga_20_c_c, fpga_21_c_c, fpga_22_c_c, 
        fpga_23_c_c, fpga_24_c_c, fpga_25_c_c, fpga_26_c_c, fpga_27_c_c, 
        fpga_28_c_c, fpga_29_c_c, d_00_c, d_01_c, d_02_c, d_03_c, 
        d_04_c, d_05_c, d_06_c, d_07_c, d_08_c, d_09_c, d_10_c, 
        d_11_c, d_12_c, d_13_c, d_14_c, d_15_c, dummy_signal, VCC_net, 
        n29, GND_net;
    
    VLO i42 (.Z(GND_net));
    LUT4 fpga_01_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_01_c), .Z(d_01_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam fpga_01_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 reqsafestate_I_0_1_lut_rep_1 (.A(reqsafestate_c), .Z(n29)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam reqsafestate_I_0_1_lut_rep_1.init = 16'h5555;
    LUT4 fpga_00_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_00_c), .Z(d_00_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam fpga_00_I_0_2_lut_2_lut.init = 16'h4444;
    OB slotok_pad (.I(n29), .O(slotok));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(11[3:9])
    OB reqoe_pad (.I(VCC_net), .O(reqoe));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(12[3:8])
    OB fpga_16_pad (.I(fpga_16_c_c), .O(fpga_16));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(34[9:16])
    OB fpga_17_pad (.I(fpga_17_c_c), .O(fpga_17));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(35[9:16])
    OB fpga_18_pad (.I(fpga_18_c_c), .O(fpga_18));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(36[9:16])
    OB fpga_19_pad (.I(fpga_19_c_c), .O(fpga_19));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(37[9:16])
    OB fpga_20_pad (.I(fpga_20_c_c), .O(fpga_20));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(38[9:16])
    OB fpga_21_pad (.I(fpga_21_c_c), .O(fpga_21));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(39[9:16])
    OB fpga_22_pad (.I(fpga_22_c_c), .O(fpga_22));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(40[9:16])
    OB fpga_23_pad (.I(fpga_23_c_c), .O(fpga_23));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(41[9:16])
    OB fpga_24_pad (.I(fpga_24_c_c), .O(fpga_24));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(42[9:16])
    OB fpga_25_pad (.I(fpga_25_c_c), .O(fpga_25));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(43[9:16])
    OB fpga_26_pad (.I(fpga_26_c_c), .O(fpga_26));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(44[9:16])
    OB fpga_27_pad (.I(fpga_27_c_c), .O(fpga_27));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(45[9:16])
    OB fpga_28_pad (.I(fpga_28_c_c), .O(fpga_28));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(46[9:16])
    OB fpga_29_pad (.I(fpga_29_c_c), .O(fpga_29));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(47[9:16])
    OB d_00_pad (.I(d_00_c), .O(d_00));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(50[9:13])
    OB d_01_pad (.I(d_01_c), .O(d_01));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(51[9:13])
    OB d_02_pad (.I(d_02_c), .O(d_02));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(52[9:13])
    OB d_03_pad (.I(d_03_c), .O(d_03));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(53[9:13])
    OB d_04_pad (.I(d_04_c), .O(d_04));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(54[9:13])
    OB d_05_pad (.I(d_05_c), .O(d_05));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(55[9:13])
    OB d_06_pad (.I(d_06_c), .O(d_06));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(56[9:13])
    OB d_07_pad (.I(d_07_c), .O(d_07));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(57[9:13])
    OB d_08_pad (.I(d_08_c), .O(d_08));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(58[9:13])
    OB d_09_pad (.I(d_09_c), .O(d_09));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(59[9:13])
    OB d_10_pad (.I(d_10_c), .O(d_10));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(60[9:13])
    OB d_11_pad (.I(d_11_c), .O(d_11));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(61[9:13])
    OB d_12_pad (.I(d_12_c), .O(d_12));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(62[9:13])
    OB d_13_pad (.I(d_13_c), .O(d_13));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(63[9:13])
    OB d_14_pad (.I(d_14_c), .O(d_14));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(64[9:13])
    OB d_15_pad (.I(d_15_c), .O(d_15));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(65[9:13])
    IB pilot_in_pad (.I(pilot_in), .O(pilot_in_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(8[3:11])
    IB reqsafestate_pad (.I(reqsafestate), .O(reqsafestate_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(9[3:15])
    IB carrierrdy_pad (.I(carrierrdy), .O(carrierrdy_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(10[3:13])
    IB i2c_scl_pad (.I(i2c_scl), .O(i2c_scl_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(15[9:16])
    IB i2c_sda_pad (.I(i2c_sda), .O(i2c_sda_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(16[9:16])
    IB fpga_00_pad (.I(fpga_00), .O(fpga_00_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(18[9:16])
    IB fpga_01_pad (.I(fpga_01), .O(fpga_01_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(19[9:16])
    IB fpga_02_pad (.I(fpga_02), .O(fpga_02_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(20[9:16])
    IB fpga_03_pad (.I(fpga_03), .O(fpga_03_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(21[9:16])
    IB fpga_04_pad (.I(fpga_04), .O(fpga_04_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(22[9:16])
    IB fpga_05_pad (.I(fpga_05), .O(fpga_05_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(23[9:16])
    IB fpga_06_pad (.I(fpga_06), .O(fpga_06_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(24[9:16])
    IB fpga_07_pad (.I(fpga_07), .O(fpga_07_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(25[9:16])
    IB fpga_08_pad (.I(fpga_08), .O(fpga_08_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(26[9:16])
    IB fpga_09_pad (.I(fpga_09), .O(fpga_09_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(27[9:16])
    IB fpga_10_pad (.I(fpga_10), .O(fpga_10_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(28[9:16])
    IB fpga_11_pad (.I(fpga_11), .O(fpga_11_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(29[9:16])
    IB fpga_12_pad (.I(fpga_12), .O(fpga_12_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(30[9:16])
    IB fpga_13_pad (.I(fpga_13), .O(fpga_13_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(31[9:16])
    IB fpga_14_pad (.I(fpga_14), .O(fpga_14_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(32[9:16])
    IB fpga_15_pad (.I(fpga_15), .O(fpga_15_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(33[9:16])
    IB fpga_16_c_pad (.I(d_16), .O(fpga_16_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(66[9:13])
    IB fpga_17_c_pad (.I(d_17), .O(fpga_17_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(67[9:13])
    IB fpga_18_c_pad (.I(d_18), .O(fpga_18_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(68[9:13])
    IB fpga_19_c_pad (.I(d_19), .O(fpga_19_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(69[9:13])
    IB fpga_20_c_pad (.I(d_20), .O(fpga_20_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(70[9:13])
    IB fpga_21_c_pad (.I(d_21), .O(fpga_21_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(71[9:13])
    IB fpga_22_c_pad (.I(d_22), .O(fpga_22_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(72[9:13])
    IB fpga_23_c_pad (.I(d_23), .O(fpga_23_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(73[9:13])
    IB fpga_24_c_pad (.I(d_24), .O(fpga_24_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(74[9:13])
    IB fpga_25_c_pad (.I(d_25), .O(fpga_25_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(75[9:13])
    IB fpga_26_c_pad (.I(d_26), .O(fpga_26_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(76[9:13])
    IB fpga_27_c_pad (.I(d_27), .O(fpga_27_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(77[9:13])
    IB fpga_28_c_pad (.I(d_28), .O(fpga_28_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(78[9:13])
    IB fpga_29_c_pad (.I(d_29), .O(fpga_29_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(79[9:13])
    GSR GSR_INST (.GSR(VCC_net));
    LUT4 fpga_02_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_02_c), .Z(d_02_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam fpga_02_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_03_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_03_c), .Z(d_03_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam fpga_03_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_04_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_04_c), .Z(d_04_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam fpga_04_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_05_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_05_c), .Z(d_05_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam fpga_05_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_06_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_06_c), .Z(d_06_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam fpga_06_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_07_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_07_c), .Z(d_07_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam fpga_07_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_08_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_08_c), .Z(d_08_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam fpga_08_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_09_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_09_c), .Z(d_09_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam fpga_09_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_10_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_10_c), .Z(d_10_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam fpga_10_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_11_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_11_c), .Z(d_11_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam fpga_11_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_12_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_12_c), .Z(d_12_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam fpga_12_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_13_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_13_c), .Z(d_13_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam fpga_13_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_14_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_14_c), .Z(d_14_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam fpga_14_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_15_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_15_c), .Z(d_15_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(97[50:66])
    defparam fpga_15_I_0_2_lut_2_lut.init = 16'h4444;
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    TSALL TSALL_INST (.TSALL(GND_net));
    LUT4 i3_4_lut (.A(i2c_scl_c), .B(pilot_in_c), .C(carrierrdy_c), .D(i2c_sda_c), 
         .Z(dummy_signal)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/tx16_rx14/source/tx16_rx14.vhdl(141[18:65])
    defparam i3_4_lut.init = 16'h8000;
    VHI i43 (.Z(VCC_net));
    
endmodule
//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

