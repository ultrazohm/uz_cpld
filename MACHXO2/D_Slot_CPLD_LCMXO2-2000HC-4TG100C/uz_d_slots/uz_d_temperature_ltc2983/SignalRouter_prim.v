// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Thu Dec 04 11:20:41 2025
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
            d_22, d_23, d_24, d_25, d_26, d_27, d_28, d_29);   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(5[8:20])
    input pilot_in;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(8[3:11])
    input reqsafestate;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(9[3:15])
    input carrierrdy;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(10[3:13])
    output slotok;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(11[3:9])
    output reqoe;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(12[3:8])
    input i2c_scl;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(15[9:16])
    input i2c_sda;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(16[9:16])
    input fpga_00;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(18[9:16])
    input fpga_01;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(19[9:16])
    output fpga_02;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(20[9:16])
    input fpga_03;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(21[9:16])
    output fpga_04;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(22[9:16])
    input fpga_05;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(23[9:16])
    input fpga_06;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(24[9:16])
    input fpga_07;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(25[9:16])
    output fpga_08;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(26[9:16])
    input fpga_09;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(27[9:16])
    output fpga_10;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(28[9:16])
    input fpga_11;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(29[9:16])
    input fpga_12;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(30[9:16])
    input fpga_13;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(31[9:16])
    output fpga_14;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(32[9:16])
    input fpga_15;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(33[9:16])
    output fpga_16;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(34[9:16])
    input fpga_17;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(35[9:16])
    input fpga_18;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(36[9:16])
    input fpga_19;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(37[9:16])
    input fpga_20;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(38[9:16])
    input fpga_21;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(39[9:16])
    input fpga_22;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(40[9:16])
    input fpga_23;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(41[9:16])
    input fpga_24;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(42[9:16])
    input fpga_25;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(43[9:16])
    input fpga_26;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(44[9:16])
    input fpga_27;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(45[9:16])
    input fpga_28;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(46[9:16])
    input fpga_29;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(47[9:16])
    output d_00;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(50[9:13])
    output d_01;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(51[9:13])
    input d_02;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(52[9:13])
    output d_03;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(53[9:13])
    input d_04;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(54[9:13])
    output d_05;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(55[9:13])
    output d_06;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(56[9:13])
    output d_07;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(57[9:13])
    input d_08;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(58[9:13])
    output d_09;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(59[9:13])
    input d_10;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(60[9:13])
    output d_11;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(61[9:13])
    output d_12;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(62[9:13])
    output d_13;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(63[9:13])
    input d_14;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(64[9:13])
    output d_15;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(65[9:13])
    input d_16;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(66[9:13])
    output d_17;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(67[9:13])
    output d_18;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(68[9:13])
    output d_19;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(69[9:13])
    output d_20;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(70[9:13])
    output d_21;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(71[9:13])
    output d_22;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(72[9:13])
    output d_23;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(73[9:13])
    output d_24;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(74[9:13])
    output d_25;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(75[9:13])
    output d_26;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(76[9:13])
    output d_27;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(77[9:13])
    output d_28;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(78[9:13])
    output d_29;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(79[9:13])
    
    
    wire pilot_in_c, reqsafestate_c, carrierrdy_c, i2c_scl_c, i2c_sda_c, 
        fpga_00_c, fpga_01_c, fpga_02_c, fpga_03_c, fpga_04_c, fpga_05_c, 
        fpga_06_c, fpga_07_c, fpga_08_c, fpga_09_c, fpga_10_c, fpga_11_c, 
        fpga_12_c, fpga_13_c, fpga_14_c, fpga_15_c, fpga_16_c, fpga_17_c, 
        fpga_18_c, fpga_19_c, fpga_20_c, fpga_21_c, fpga_22_c, fpga_23_c, 
        fpga_24_c, fpga_25_c, fpga_26_c, fpga_27_c, fpga_28_c, fpga_29_c, 
        d_00_c, d_01_c, d_02_c, d_03_c, d_04_c, d_05_c, d_06_c, 
        d_07_c, d_08_c, d_09_c, d_10_c, d_11_c, d_12_c, d_13_c, 
        d_14_c, d_15_c, d_16_c, d_17_c, d_18_c, d_19_c, d_20_c, 
        d_21_c, d_22_c, d_23_c, d_24_c, d_25_c, d_26_c, d_27_c, 
        d_28_c, d_29_c, dummy_signal, VCC_net, n43, GND_net;
    
    VLO i56 (.Z(GND_net));
    LUT4 d_04_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(d_04_c), .Z(fpga_04_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam d_04_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 reqsafestate_I_0_1_lut_rep_1 (.A(reqsafestate_c), .Z(n43)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam reqsafestate_I_0_1_lut_rep_1.init = 16'h5555;
    LUT4 d_02_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(d_02_c), .Z(fpga_02_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam d_02_I_0_2_lut_2_lut.init = 16'h4444;
    OB slotok_pad (.I(n43), .O(slotok));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(11[3:9])
    OB reqoe_pad (.I(VCC_net), .O(reqoe));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(12[3:8])
    OB fpga_02_pad (.I(fpga_02_c), .O(fpga_02));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(20[9:16])
    OB fpga_04_pad (.I(fpga_04_c), .O(fpga_04));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(22[9:16])
    OB fpga_08_pad (.I(fpga_08_c), .O(fpga_08));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(26[9:16])
    OB fpga_10_pad (.I(fpga_10_c), .O(fpga_10));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(28[9:16])
    OB fpga_14_pad (.I(fpga_14_c), .O(fpga_14));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(32[9:16])
    OB fpga_16_pad (.I(fpga_16_c), .O(fpga_16));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(34[9:16])
    OB d_00_pad (.I(d_00_c), .O(d_00));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(50[9:13])
    OB d_01_pad (.I(d_01_c), .O(d_01));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(51[9:13])
    OB d_03_pad (.I(d_03_c), .O(d_03));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(53[9:13])
    OB d_05_pad (.I(d_05_c), .O(d_05));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(55[9:13])
    OB d_06_pad (.I(d_06_c), .O(d_06));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(56[9:13])
    OB d_07_pad (.I(d_07_c), .O(d_07));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(57[9:13])
    OB d_09_pad (.I(d_09_c), .O(d_09));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(59[9:13])
    OB d_11_pad (.I(d_11_c), .O(d_11));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(61[9:13])
    OB d_12_pad (.I(d_12_c), .O(d_12));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(62[9:13])
    OB d_13_pad (.I(d_13_c), .O(d_13));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(63[9:13])
    OB d_15_pad (.I(d_15_c), .O(d_15));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(65[9:13])
    OB d_17_pad (.I(d_17_c), .O(d_17));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(67[9:13])
    OB d_18_pad (.I(d_18_c), .O(d_18));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(68[9:13])
    OB d_19_pad (.I(d_19_c), .O(d_19));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(69[9:13])
    OB d_20_pad (.I(d_20_c), .O(d_20));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(70[9:13])
    OB d_21_pad (.I(d_21_c), .O(d_21));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(71[9:13])
    OB d_22_pad (.I(d_22_c), .O(d_22));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(72[9:13])
    OB d_23_pad (.I(d_23_c), .O(d_23));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(73[9:13])
    OB d_24_pad (.I(d_24_c), .O(d_24));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(74[9:13])
    OB d_25_pad (.I(d_25_c), .O(d_25));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(75[9:13])
    OB d_26_pad (.I(d_26_c), .O(d_26));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(76[9:13])
    OB d_27_pad (.I(d_27_c), .O(d_27));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(77[9:13])
    OB d_28_pad (.I(d_28_c), .O(d_28));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(78[9:13])
    OB d_29_pad (.I(d_29_c), .O(d_29));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(79[9:13])
    IB pilot_in_pad (.I(pilot_in), .O(pilot_in_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(8[3:11])
    IB reqsafestate_pad (.I(reqsafestate), .O(reqsafestate_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(9[3:15])
    IB carrierrdy_pad (.I(carrierrdy), .O(carrierrdy_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(10[3:13])
    IB i2c_scl_pad (.I(i2c_scl), .O(i2c_scl_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(15[9:16])
    IB i2c_sda_pad (.I(i2c_sda), .O(i2c_sda_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(16[9:16])
    IB fpga_00_pad (.I(fpga_00), .O(fpga_00_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(18[9:16])
    IB fpga_01_pad (.I(fpga_01), .O(fpga_01_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(19[9:16])
    IB fpga_03_pad (.I(fpga_03), .O(fpga_03_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(21[9:16])
    IB fpga_05_pad (.I(fpga_05), .O(fpga_05_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(23[9:16])
    IB fpga_06_pad (.I(fpga_06), .O(fpga_06_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(24[9:16])
    IB fpga_07_pad (.I(fpga_07), .O(fpga_07_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(25[9:16])
    IB fpga_09_pad (.I(fpga_09), .O(fpga_09_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(27[9:16])
    IB fpga_11_pad (.I(fpga_11), .O(fpga_11_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(29[9:16])
    IB fpga_12_pad (.I(fpga_12), .O(fpga_12_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(30[9:16])
    IB fpga_13_pad (.I(fpga_13), .O(fpga_13_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(31[9:16])
    IB fpga_15_pad (.I(fpga_15), .O(fpga_15_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(33[9:16])
    IB fpga_17_pad (.I(fpga_17), .O(fpga_17_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(35[9:16])
    IB fpga_18_pad (.I(fpga_18), .O(fpga_18_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(36[9:16])
    IB fpga_19_pad (.I(fpga_19), .O(fpga_19_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(37[9:16])
    IB fpga_20_pad (.I(fpga_20), .O(fpga_20_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(38[9:16])
    IB fpga_21_pad (.I(fpga_21), .O(fpga_21_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(39[9:16])
    IB fpga_22_pad (.I(fpga_22), .O(fpga_22_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(40[9:16])
    IB fpga_23_pad (.I(fpga_23), .O(fpga_23_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(41[9:16])
    IB fpga_24_pad (.I(fpga_24), .O(fpga_24_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(42[9:16])
    IB fpga_25_pad (.I(fpga_25), .O(fpga_25_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(43[9:16])
    IB fpga_26_pad (.I(fpga_26), .O(fpga_26_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(44[9:16])
    IB fpga_27_pad (.I(fpga_27), .O(fpga_27_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(45[9:16])
    IB fpga_28_pad (.I(fpga_28), .O(fpga_28_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(46[9:16])
    IB fpga_29_pad (.I(fpga_29), .O(fpga_29_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(47[9:16])
    IB d_02_pad (.I(d_02), .O(d_02_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(52[9:13])
    IB d_04_pad (.I(d_04), .O(d_04_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(54[9:13])
    IB d_08_pad (.I(d_08), .O(d_08_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(58[9:13])
    IB d_10_pad (.I(d_10), .O(d_10_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(60[9:13])
    IB d_14_pad (.I(d_14), .O(d_14_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(64[9:13])
    IB d_16_pad (.I(d_16), .O(d_16_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(66[9:13])
    GSR GSR_INST (.GSR(VCC_net));
    LUT4 d_08_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(d_08_c), .Z(fpga_08_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam d_08_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 d_10_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(d_10_c), .Z(fpga_10_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam d_10_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 d_14_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(d_14_c), .Z(fpga_14_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam d_14_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 d_16_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(d_16_c), .Z(fpga_16_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam d_16_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_00_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_00_c), .Z(d_00_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_00_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_01_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_01_c), .Z(d_01_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_01_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_03_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_03_c), .Z(d_03_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_03_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_05_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_05_c), .Z(d_05_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_05_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_06_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_06_c), .Z(d_06_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_06_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_07_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_07_c), .Z(d_07_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_07_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_09_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_09_c), .Z(d_09_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_09_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_11_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_11_c), .Z(d_11_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_11_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_12_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_12_c), .Z(d_12_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_12_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_13_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_13_c), .Z(d_13_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_13_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_15_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_15_c), .Z(d_15_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_15_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_17_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_17_c), .Z(d_17_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_17_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_18_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_18_c), .Z(d_18_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_18_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_19_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_19_c), .Z(d_19_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_19_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_20_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_20_c), .Z(d_20_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_20_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_21_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_21_c), .Z(d_21_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_21_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_22_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_22_c), .Z(d_22_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_22_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_23_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_23_c), .Z(d_23_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_23_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_24_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_24_c), .Z(d_24_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_24_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_25_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_25_c), .Z(d_25_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_25_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_26_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_26_c), .Z(d_26_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_26_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_27_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_27_c), .Z(d_27_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_27_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_28_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_28_c), .Z(d_28_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_28_I_0_2_lut_2_lut.init = 16'h4444;
    LUT4 fpga_29_I_0_2_lut_2_lut (.A(reqsafestate_c), .B(fpga_29_c), .Z(d_29_c)) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(97[50:66])
    defparam fpga_29_I_0_2_lut_2_lut.init = 16'h4444;
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    TSALL TSALL_INST (.TSALL(GND_net));
    LUT4 i3_4_lut (.A(i2c_scl_c), .B(pilot_in_c), .C(carrierrdy_c), .D(i2c_sda_c), 
         .Z(dummy_signal)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_temperature_ltc2983/source/uz_d_temperature_ltc2983.vhdl(147[18:65])
    defparam i3_4_lut.init = 16'h8000;
    VHI i57 (.Z(VCC_net));
    
endmodule
//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

