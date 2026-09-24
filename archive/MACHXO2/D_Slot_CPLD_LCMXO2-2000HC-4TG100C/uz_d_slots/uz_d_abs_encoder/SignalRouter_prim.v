// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Sat Oct 04 15:23:56 2025
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
            d_22, d_23, d_24, d_25, d_26, d_27, d_28, d_29);   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(5[8:20])
    input pilot_in;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(9[3:11])
    input reqsafestate;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(10[3:15])
    input carrierrdy;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(11[3:13])
    output slotok;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(12[3:9])
    output reqoe;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(13[3:8])
    input i2c_scl;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(16[9:16])
    input i2c_sda;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(17[9:16])
    input fpga_00;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(19[9:16])
    input fpga_01;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(20[9:16])
    input fpga_02;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(21[9:16])
    input fpga_03;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(22[9:16])
    input fpga_04;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(23[9:16])
    input fpga_05;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(24[9:16])
    output fpga_06;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(25[9:16])
    output fpga_07;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(26[9:16])
    input fpga_08;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(27[9:16])
    input fpga_09;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(28[9:16])
    input fpga_10;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(29[9:16])
    input fpga_11;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(30[9:16])
    input fpga_12;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(31[9:16])
    input fpga_13;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(32[9:16])
    input fpga_14;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(33[9:16])
    input fpga_15;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(34[9:16])
    input fpga_16;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(35[9:16])
    input fpga_17;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(36[9:16])
    output fpga_18;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(37[9:16])
    input fpga_19;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(38[9:16])
    input fpga_20;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(39[9:16])
    input fpga_21;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(40[9:16])
    input fpga_22;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(41[9:16])
    input fpga_23;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(42[9:16])
    input fpga_24;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(43[9:16])
    input fpga_25;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(44[9:16])
    input fpga_26;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(45[9:16])
    input fpga_27;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(46[9:16])
    input fpga_28;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(47[9:16])
    input fpga_29;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(48[9:16])
    input d_00;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(51[9:13])
    input d_01;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(52[9:13])
    output d_02;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(53[9:13])
    output d_03;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(54[9:13])
    output d_04;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(55[9:13])
    output d_05;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(56[9:13])
    input d_06;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(57[9:13])
    input d_07;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(58[9:13])
    output d_08;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(59[9:13])
    output d_09;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(60[9:13])
    output d_10;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(61[9:13])
    output d_11;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(62[9:13])
    input d_12;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(63[9:13])
    output d_13;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(64[9:13])
    output d_14;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(65[9:13])
    input d_15;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(66[9:13])
    output d_16;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(67[9:13])
    output d_17;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(68[9:13])
    input d_18;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(69[9:13])
    input d_19;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(70[9:13])
    input d_20;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(71[9:13])
    input d_21;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(72[9:13])
    input d_22;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(73[9:13])
    input d_23;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(74[9:13])
    input d_24;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(75[9:13])
    input d_25;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(76[9:13])
    input d_26;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(77[9:13])
    input d_27;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(78[9:13])
    input d_28;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(79[9:13])
    input d_29;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(80[9:13])
    
    
    wire pilot_in_c, reqsafestate_c, carrierrdy_c, slotok_c, i2c_scl_c, 
        i2c_sda_c, fpga_06_c_c, fpga_07_c_c, d_03_c_c, d_02_c_c, d_04_c_c, 
        d_05_c_c, d_13_c_c, d_08_c_c, d_09_c_c, d_10_c_c, d_11_c_c, 
        fpga_18_c_c, d_14_c_c, d_16_c_c, d_17_c_c, fpga_26_c, fpga_27_c, 
        fpga_28_c, fpga_29_c, n6, dummy_signal, VCC_net, GND_net;
    
    VLO i57 (.Z(GND_net));
    LUT4 i1_2_lut (.A(fpga_29_c), .B(fpga_27_c), .Z(n6)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam i1_2_lut.init = 16'h2222;
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    LUT4 i3_4_lut (.A(i2c_scl_c), .B(pilot_in_c), .C(carrierrdy_c), .D(i2c_sda_c), 
         .Z(dummy_signal)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(138[18:65])
    defparam i3_4_lut.init = 16'h8000;
    LUT4 i4_4_lut (.A(fpga_28_c), .B(reqsafestate_c), .C(fpga_26_c), .D(n6), 
         .Z(slotok_c)) /* synthesis lut_function=(!((B+(C+!(D)))+!A)) */ ;
    defparam i4_4_lut.init = 16'h0200;
    OB slotok_pad (.I(slotok_c), .O(slotok));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(12[3:9])
    OB reqoe_pad (.I(VCC_net), .O(reqoe));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(13[3:8])
    OB fpga_06_pad (.I(fpga_06_c_c), .O(fpga_06));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(25[9:16])
    OB fpga_07_pad (.I(fpga_07_c_c), .O(fpga_07));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(26[9:16])
    OB fpga_18_pad (.I(fpga_18_c_c), .O(fpga_18));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(37[9:16])
    OB d_02_pad (.I(d_02_c_c), .O(d_02));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(53[9:13])
    OB d_03_pad (.I(d_03_c_c), .O(d_03));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(54[9:13])
    OB d_04_pad (.I(d_04_c_c), .O(d_04));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(55[9:13])
    OB d_05_pad (.I(d_05_c_c), .O(d_05));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(56[9:13])
    OB d_08_pad (.I(d_08_c_c), .O(d_08));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(59[9:13])
    OB d_09_pad (.I(d_09_c_c), .O(d_09));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(60[9:13])
    OB d_10_pad (.I(d_10_c_c), .O(d_10));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(61[9:13])
    OB d_11_pad (.I(d_11_c_c), .O(d_11));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(62[9:13])
    OB d_13_pad (.I(d_13_c_c), .O(d_13));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(64[9:13])
    OB d_14_pad (.I(d_14_c_c), .O(d_14));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(65[9:13])
    OB d_16_pad (.I(d_16_c_c), .O(d_16));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(67[9:13])
    OB d_17_pad (.I(d_17_c_c), .O(d_17));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(68[9:13])
    IB pilot_in_pad (.I(pilot_in), .O(pilot_in_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(9[3:11])
    IB reqsafestate_pad (.I(reqsafestate), .O(reqsafestate_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(10[3:15])
    IB carrierrdy_pad (.I(carrierrdy), .O(carrierrdy_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(11[3:13])
    IB i2c_scl_pad (.I(i2c_scl), .O(i2c_scl_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(16[9:16])
    IB i2c_sda_pad (.I(i2c_sda), .O(i2c_sda_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(17[9:16])
    IB d_03_c_pad (.I(fpga_08), .O(d_03_c_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(27[9:16])
    IB d_02_c_pad (.I(fpga_09), .O(d_02_c_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(28[9:16])
    IB d_04_c_pad (.I(fpga_10), .O(d_04_c_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(29[9:16])
    IB d_05_c_pad (.I(fpga_11), .O(d_05_c_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(30[9:16])
    IB d_13_c_pad (.I(fpga_12), .O(d_13_c_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(31[9:16])
    IB d_08_c_pad (.I(fpga_14), .O(d_08_c_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(33[9:16])
    IB d_09_c_pad (.I(fpga_15), .O(d_09_c_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(34[9:16])
    IB d_10_c_pad (.I(fpga_16), .O(d_10_c_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(35[9:16])
    IB d_11_c_pad (.I(fpga_17), .O(d_11_c_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(36[9:16])
    IB d_14_c_pad (.I(fpga_20), .O(d_14_c_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(39[9:16])
    IB d_16_c_pad (.I(fpga_22), .O(d_16_c_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(41[9:16])
    IB d_17_c_pad (.I(fpga_23), .O(d_17_c_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(42[9:16])
    IB fpga_26_pad (.I(fpga_26), .O(fpga_26_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(45[9:16])
    IB fpga_27_pad (.I(fpga_27), .O(fpga_27_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(46[9:16])
    IB fpga_28_pad (.I(fpga_28), .O(fpga_28_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(47[9:16])
    IB fpga_29_pad (.I(fpga_29), .O(fpga_29_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(48[9:16])
    IB fpga_06_c_pad (.I(d_00), .O(fpga_06_c_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(51[9:13])
    IB fpga_07_c_pad (.I(d_01), .O(fpga_07_c_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(52[9:13])
    IB fpga_18_c_pad (.I(d_12), .O(fpga_18_c_c));   // c:/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_abs_encoder/source/uz_d_abs_encoder.vhdl(63[9:13])
    GSR GSR_INST (.GSR(VCC_net));
    TSALL TSALL_INST (.TSALL(GND_net));
    VHI i58 (.Z(VCC_net));
    
endmodule
//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

