// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Mon Dec 16 09:48:03 2024
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
            d_22, d_23, d_24, d_25, d_26, d_27, d_28, d_29);   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(5[8:20])
    input pilot_in;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(9[3:11])
    input reqsafestate;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(10[3:15])
    input carrierrdy;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(11[3:13])
    output slotok;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(12[3:9])
    output reqoe;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(13[3:8])
    input i2c_scl;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(16[9:16])
    input i2c_sda;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(17[9:16])
    output fpga_00;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(19[9:16])
    output fpga_01;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(20[9:16])
    output fpga_02;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(21[9:16])
    output fpga_03;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(22[9:16])
    output fpga_04;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(23[9:16])
    output fpga_05;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(24[9:16])
    input fpga_06;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(25[9:16])
    input fpga_07;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(26[9:16])
    input fpga_08;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(27[3:10])
    input fpga_09;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(28[9:16])
    input fpga_10;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(29[9:16])
    input fpga_11;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(30[9:16])
    input fpga_12;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(31[9:16])
    input fpga_13;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(32[9:16])
    output fpga_14;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(33[9:16])
    input fpga_15;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(34[9:16])
    input fpga_16;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(35[9:16])
    input fpga_17;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(36[3:10])
    input fpga_18;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(37[9:16])
    input fpga_19;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(38[9:16])
    input fpga_20;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(39[9:16])
    input fpga_21;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(40[9:16])
    input fpga_22;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(41[9:16])
    output fpga_23;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(42[9:16])
    output fpga_24;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(43[9:16])
    output fpga_25;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(44[9:16])
    output fpga_26;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(45[3:10])
    output fpga_27;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(46[9:16])
    output fpga_28;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(47[9:16])
    output fpga_29;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(48[9:16])
    output d_00;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(51[9:13])
    output d_01;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(52[9:13])
    output d_02;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(53[9:13])
    output d_03;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(54[9:13])
    output d_04;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(55[9:13])
    output d_05;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(56[9:13])
    output d_06;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(57[9:13])
    output d_07;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(58[9:13])
    input d_08;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(59[9:13])
    output d_09;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(60[9:13])
    output d_10;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(61[9:13])
    output d_11;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(62[9:13])
    output d_12;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(63[9:13])
    output d_13;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(64[9:13])
    output d_14;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(65[9:13])
    output d_15;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(66[9:13])
    output d_16;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(67[9:13])
    input d_17;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(68[9:13])
    output d_18;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(69[9:13])
    output d_19;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(70[9:13])
    output d_20;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(71[9:13])
    output d_21;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(72[9:13])
    output d_22;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(73[9:13])
    output d_23;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(74[9:13])
    output d_24;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(75[9:13])
    output d_25;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(76[9:13])
    input d_26;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(77[9:13])
    output d_27;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(78[9:13])
    output d_28;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(79[9:13])
    output d_29;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(80[9:13])
    
    
    wire VCC_net, pilot_in_c, reqsafestate_c, carrierrdy_c, slotok_c, 
        i2c_scl_c, i2c_sda_c, d_00_c_c, d_01_c_c, d_02_c_c, d_03_c_c, 
        d_04_c_c, d_05_c_c, d_06_c_c, d_07_c_c, fpga_14_c_c, d_09_c_c, 
        d_10_c_c, d_11_c_c, d_12_c_c, d_13_c_c, d_14_c_c, d_15_c_c, 
        d_16_c_c, fpga_23_c_c, dummy_signal, d_26_c, n6, GND_net;
    
    VLO i13 (.Z(GND_net));
    LUT4 i1_2_lut (.A(pilot_in_c), .B(i2c_sda_c), .Z(n6)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(129[18:74])
    defparam i1_2_lut.init = 16'h8888;
    LUT4 i4_4_lut (.A(carrierrdy_c), .B(d_26_c), .C(i2c_scl_c), .D(n6), 
         .Z(dummy_signal)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(129[18:74])
    defparam i4_4_lut.init = 16'h8000;
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    TSALL TSALL_INST (.TSALL(GND_net));
    VHI i11 (.Z(VCC_net));
    OB slotok_pad (.I(slotok_c), .O(slotok));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(12[3:9])
    OB reqoe_pad (.I(VCC_net), .O(reqoe));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(13[3:8])
    OB fpga_00_pad (.I(GND_net), .O(fpga_00));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(19[9:16])
    OB fpga_01_pad (.I(GND_net), .O(fpga_01));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(20[9:16])
    OB fpga_02_pad (.I(GND_net), .O(fpga_02));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(21[9:16])
    OB fpga_03_pad (.I(GND_net), .O(fpga_03));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(22[9:16])
    OB fpga_04_pad (.I(GND_net), .O(fpga_04));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(23[9:16])
    OB fpga_05_pad (.I(GND_net), .O(fpga_05));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(24[9:16])
    OB fpga_14_pad (.I(fpga_14_c_c), .O(fpga_14));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(33[9:16])
    OB fpga_23_pad (.I(fpga_23_c_c), .O(fpga_23));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(42[9:16])
    OB fpga_24_pad (.I(GND_net), .O(fpga_24));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(43[9:16])
    OB fpga_25_pad (.I(GND_net), .O(fpga_25));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(44[9:16])
    OB fpga_26_pad (.I(GND_net), .O(fpga_26));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(45[3:10])
    OB fpga_27_pad (.I(GND_net), .O(fpga_27));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(46[9:16])
    OB fpga_28_pad (.I(GND_net), .O(fpga_28));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(47[9:16])
    OB fpga_29_pad (.I(GND_net), .O(fpga_29));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(48[9:16])
    OB d_00_pad (.I(d_00_c_c), .O(d_00));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(51[9:13])
    OB d_01_pad (.I(d_01_c_c), .O(d_01));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(52[9:13])
    OB d_02_pad (.I(d_02_c_c), .O(d_02));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(53[9:13])
    OB d_03_pad (.I(d_03_c_c), .O(d_03));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(54[9:13])
    OB d_04_pad (.I(d_04_c_c), .O(d_04));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(55[9:13])
    OB d_05_pad (.I(d_05_c_c), .O(d_05));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(56[9:13])
    OB d_06_pad (.I(d_06_c_c), .O(d_06));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(57[9:13])
    OB d_07_pad (.I(d_07_c_c), .O(d_07));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(58[9:13])
    OB d_09_pad (.I(d_09_c_c), .O(d_09));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(60[9:13])
    OB d_10_pad (.I(d_10_c_c), .O(d_10));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(61[9:13])
    OB d_11_pad (.I(d_11_c_c), .O(d_11));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(62[9:13])
    OB d_12_pad (.I(d_12_c_c), .O(d_12));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(63[9:13])
    OB d_13_pad (.I(d_13_c_c), .O(d_13));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(64[9:13])
    OB d_14_pad (.I(d_14_c_c), .O(d_14));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(65[9:13])
    OB d_15_pad (.I(d_15_c_c), .O(d_15));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(66[9:13])
    OB d_16_pad (.I(d_16_c_c), .O(d_16));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(67[9:13])
    OB d_18_pad (.I(GND_net), .O(d_18));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(69[9:13])
    OB d_19_pad (.I(GND_net), .O(d_19));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(70[9:13])
    OB d_20_pad (.I(GND_net), .O(d_20));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(71[9:13])
    OB d_21_pad (.I(GND_net), .O(d_21));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(72[9:13])
    OB d_22_pad (.I(GND_net), .O(d_22));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(73[9:13])
    OB d_23_pad (.I(GND_net), .O(d_23));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(74[9:13])
    OB d_24_pad (.I(GND_net), .O(d_24));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(75[9:13])
    OB d_25_pad (.I(GND_net), .O(d_25));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(76[9:13])
    OB d_27_pad (.I(GND_net), .O(d_27));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(78[9:13])
    OB d_28_pad (.I(GND_net), .O(d_28));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(79[9:13])
    OB d_29_pad (.I(GND_net), .O(d_29));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(80[9:13])
    IB pilot_in_pad (.I(pilot_in), .O(pilot_in_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(9[3:11])
    IB reqsafestate_pad (.I(reqsafestate), .O(reqsafestate_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(10[3:15])
    IB carrierrdy_pad (.I(carrierrdy), .O(carrierrdy_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(11[3:13])
    IB i2c_scl_pad (.I(i2c_scl), .O(i2c_scl_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(16[9:16])
    IB i2c_sda_pad (.I(i2c_sda), .O(i2c_sda_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(17[9:16])
    IB d_00_c_pad (.I(fpga_06), .O(d_00_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(25[9:16])
    IB d_01_c_pad (.I(fpga_07), .O(d_01_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(26[9:16])
    IB d_02_c_pad (.I(fpga_08), .O(d_02_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(27[3:10])
    IB d_03_c_pad (.I(fpga_09), .O(d_03_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(28[9:16])
    IB d_04_c_pad (.I(fpga_10), .O(d_04_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(29[9:16])
    IB d_05_c_pad (.I(fpga_11), .O(d_05_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(30[9:16])
    IB d_06_c_pad (.I(fpga_12), .O(d_06_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(31[9:16])
    IB d_07_c_pad (.I(fpga_13), .O(d_07_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(32[9:16])
    IB d_09_c_pad (.I(fpga_15), .O(d_09_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(34[9:16])
    IB d_10_c_pad (.I(fpga_16), .O(d_10_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(35[9:16])
    IB d_11_c_pad (.I(fpga_17), .O(d_11_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(36[3:10])
    IB d_12_c_pad (.I(fpga_18), .O(d_12_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(37[9:16])
    IB d_13_c_pad (.I(fpga_19), .O(d_13_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(38[9:16])
    IB d_14_c_pad (.I(fpga_20), .O(d_14_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(39[9:16])
    IB d_15_c_pad (.I(fpga_21), .O(d_15_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(40[9:16])
    IB d_16_c_pad (.I(fpga_22), .O(d_16_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(41[9:16])
    IB fpga_14_c_pad (.I(d_08), .O(fpga_14_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(59[9:13])
    IB fpga_23_c_pad (.I(d_17), .O(fpga_23_c_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(68[9:13])
    IB d_26_pad (.I(d_26), .O(d_26_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(77[9:13])
    GSR GSR_INST (.GSR(VCC_net));
    LUT4 reqsafestate_I_0_1_lut (.A(reqsafestate_c), .Z(slotok_c)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/uz_d_resolver_d5/source/uz_d_resolver_d5.vhdl(96[50:66])
    defparam reqsafestate_I_0_1_lut.init = 16'h5555;
    
endmodule
//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

