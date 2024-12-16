// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Mon Dec 16 09:49:31 2024
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
            d_22, d_23, d_24, d_25, d_26, d_27, d_28, d_29);   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(5[8:20])
    input pilot_in;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(9[3:11])
    input reqsafestate;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(10[3:15])
    input carrierrdy;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(11[3:13])
    output slotok;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(12[3:9])
    output reqoe;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(13[3:8])
    input i2c_scl;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(16[9:16])
    input i2c_sda;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(17[9:16])
    input fpga_00;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(19[9:16])
    input fpga_01;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(20[9:16])
    input fpga_02;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(21[9:16])
    input fpga_03;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(22[9:16])
    input fpga_04;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(23[9:16])
    input fpga_05;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(24[9:16])
    input fpga_06;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(25[9:16])
    input fpga_07;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(26[9:16])
    input fpga_08;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(27[9:16])
    input fpga_09;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(28[9:16])
    input fpga_10;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(29[9:16])
    input fpga_11;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(30[9:16])
    input fpga_12;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(31[9:16])
    input fpga_13;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(32[9:16])
    input fpga_14;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(33[9:16])
    input fpga_15;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(34[9:16])
    input fpga_16;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(35[9:16])
    input fpga_17;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(36[9:16])
    input fpga_18;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(37[9:16])
    input fpga_19;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(38[9:16])
    input fpga_20;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(39[9:16])
    input fpga_21;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(40[9:16])
    input fpga_22;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(41[9:16])
    input fpga_23;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(42[9:16])
    input fpga_24;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(43[9:16])
    input fpga_25;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(44[9:16])
    input fpga_26;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(45[9:16])
    input fpga_27;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(46[9:16])
    input fpga_28;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(47[9:16])
    input fpga_29;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(48[9:16])
    output d_00;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(51[9:13])
    output d_01;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(52[9:13])
    output d_02;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(53[9:13])
    output d_03;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(54[9:13])
    output d_04;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(55[9:13])
    output d_05;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(56[9:13])
    output d_06;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(57[9:13])
    output d_07;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(58[9:13])
    output d_08;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(59[9:13])
    output d_09;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(60[9:13])
    output d_10;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(61[9:13])
    output d_11;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(62[9:13])
    output d_12;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(63[9:13])
    output d_13;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(64[9:13])
    output d_14;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(65[9:13])
    output d_15;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(66[9:13])
    output d_16;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(67[9:13])
    output d_17;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(68[9:13])
    output d_18;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(69[9:13])
    output d_19;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(70[9:13])
    output d_20;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(71[9:13])
    output d_21;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(72[9:13])
    output d_22;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(73[9:13])
    output d_23;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(74[9:13])
    output d_24;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(75[9:13])
    output d_25;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(76[9:13])
    output d_26;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(77[9:13])
    output d_27;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(78[9:13])
    output d_28;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(79[9:13])
    output d_29;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(80[9:13])
    
    
    wire pilot_in_c, reqsafestate_c, carrierrdy_c, slotok_c, i2c_scl_c, 
        i2c_sda_c, fpga_00_c, fpga_01_c, fpga_02_c, fpga_03_c, fpga_04_c, 
        fpga_05_c, fpga_06_c, fpga_07_c, fpga_08_c, fpga_09_c, fpga_10_c, 
        fpga_11_c, fpga_12_c, fpga_13_c, fpga_14_c, fpga_15_c, fpga_16_c, 
        fpga_17_c, fpga_18_c, fpga_19_c, fpga_20_c, fpga_21_c, fpga_22_c, 
        fpga_23_c, fpga_24_c, fpga_25_c, fpga_26_c, fpga_27_c, fpga_28_c, 
        fpga_29_c, d_00_c, d_01_c, d_02_c, d_03_c, d_04_c, d_05_c, 
        d_06_c, d_07_c, d_08_c, d_09_c, d_10_c, d_11_c, d_12_c, 
        d_13_c, d_14_c, d_15_c, d_16_c, d_17_c, d_18_c, d_19_c, 
        d_20_c, d_21_c, d_22_c, d_23_c, d_24_c, d_25_c, n6, dummy_signal, 
        VCC_net, GND_net;
    
    VLO i43 (.Z(GND_net));
    LUT4 fpga_07_I_0_2_lut (.A(fpga_07_c), .B(slotok_c), .Z(d_07_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(116[13:42])
    defparam fpga_07_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_08_I_0_2_lut (.A(fpga_08_c), .B(slotok_c), .Z(d_08_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(117[13:42])
    defparam fpga_08_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_25_I_0_2_lut (.A(fpga_25_c), .B(slotok_c), .Z(d_25_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(134[13:42])
    defparam fpga_25_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_24_I_0_2_lut (.A(fpga_24_c), .B(slotok_c), .Z(d_24_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(133[13:42])
    defparam fpga_24_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_23_I_0_2_lut (.A(fpga_23_c), .B(slotok_c), .Z(d_23_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(132[13:42])
    defparam fpga_23_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_22_I_0_2_lut (.A(fpga_22_c), .B(slotok_c), .Z(d_22_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(131[13:42])
    defparam fpga_22_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_21_I_0_2_lut (.A(fpga_21_c), .B(slotok_c), .Z(d_21_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(130[13:42])
    defparam fpga_21_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_20_I_0_2_lut (.A(fpga_20_c), .B(slotok_c), .Z(d_20_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(129[13:42])
    defparam fpga_20_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_19_I_0_2_lut (.A(fpga_19_c), .B(slotok_c), .Z(d_19_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(128[13:42])
    defparam fpga_19_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_18_I_0_2_lut (.A(fpga_18_c), .B(slotok_c), .Z(d_18_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(127[13:42])
    defparam fpga_18_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_17_I_0_2_lut (.A(fpga_17_c), .B(slotok_c), .Z(d_17_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(126[13:42])
    defparam fpga_17_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_16_I_0_2_lut (.A(fpga_16_c), .B(slotok_c), .Z(d_16_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(125[13:42])
    defparam fpga_16_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_15_I_0_2_lut (.A(fpga_15_c), .B(slotok_c), .Z(d_15_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(124[13:42])
    defparam fpga_15_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_14_I_0_2_lut (.A(fpga_14_c), .B(slotok_c), .Z(d_14_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(123[13:42])
    defparam fpga_14_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_13_I_0_2_lut (.A(fpga_13_c), .B(slotok_c), .Z(d_13_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(122[13:42])
    defparam fpga_13_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_12_I_0_2_lut (.A(fpga_12_c), .B(slotok_c), .Z(d_12_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(121[13:42])
    defparam fpga_12_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_11_I_0_2_lut (.A(fpga_11_c), .B(slotok_c), .Z(d_11_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(120[13:42])
    defparam fpga_11_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_09_I_0_2_lut (.A(fpga_09_c), .B(slotok_c), .Z(d_09_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(118[13:42])
    defparam fpga_09_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_03_I_0_2_lut (.A(fpga_03_c), .B(slotok_c), .Z(d_03_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(112[13:42])
    defparam fpga_03_I_0_2_lut.init = 16'h8888;
    LUT4 i1_2_lut (.A(fpga_29_c), .B(fpga_27_c), .Z(n6)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam i1_2_lut.init = 16'h2222;
    LUT4 fpga_00_I_0_2_lut (.A(fpga_00_c), .B(slotok_c), .Z(d_00_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(109[13:42])
    defparam fpga_00_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_01_I_0_2_lut (.A(fpga_01_c), .B(slotok_c), .Z(d_01_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(110[13:42])
    defparam fpga_01_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_02_I_0_2_lut (.A(fpga_02_c), .B(slotok_c), .Z(d_02_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(111[13:42])
    defparam fpga_02_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_04_I_0_2_lut (.A(fpga_04_c), .B(slotok_c), .Z(d_04_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(113[13:42])
    defparam fpga_04_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_10_I_0_2_lut (.A(fpga_10_c), .B(slotok_c), .Z(d_10_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(119[13:42])
    defparam fpga_10_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_05_I_0_2_lut (.A(fpga_05_c), .B(slotok_c), .Z(d_05_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(114[13:42])
    defparam fpga_05_I_0_2_lut.init = 16'h8888;
    LUT4 fpga_06_I_0_2_lut (.A(fpga_06_c), .B(slotok_c), .Z(d_06_c)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(115[13:42])
    defparam fpga_06_I_0_2_lut.init = 16'h8888;
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    LUT4 i3_4_lut (.A(i2c_scl_c), .B(pilot_in_c), .C(carrierrdy_c), .D(i2c_sda_c), 
         .Z(dummy_signal)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(137[18:65])
    defparam i3_4_lut.init = 16'h8000;
    LUT4 i4_4_lut (.A(fpga_28_c), .B(reqsafestate_c), .C(fpga_26_c), .D(n6), 
         .Z(slotok_c)) /* synthesis lut_function=(!((B+(C+!(D)))+!A)) */ ;
    defparam i4_4_lut.init = 16'h0200;
    OB slotok_pad (.I(slotok_c), .O(slotok));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(12[3:9])
    OB reqoe_pad (.I(VCC_net), .O(reqoe));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(13[3:8])
    OB d_00_pad (.I(d_00_c), .O(d_00));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(51[9:13])
    OB d_01_pad (.I(d_01_c), .O(d_01));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(52[9:13])
    OB d_02_pad (.I(d_02_c), .O(d_02));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(53[9:13])
    OB d_03_pad (.I(d_03_c), .O(d_03));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(54[9:13])
    OB d_04_pad (.I(d_04_c), .O(d_04));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(55[9:13])
    OB d_05_pad (.I(d_05_c), .O(d_05));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(56[9:13])
    OB d_06_pad (.I(d_06_c), .O(d_06));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(57[9:13])
    OB d_07_pad (.I(d_07_c), .O(d_07));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(58[9:13])
    OB d_08_pad (.I(d_08_c), .O(d_08));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(59[9:13])
    OB d_09_pad (.I(d_09_c), .O(d_09));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(60[9:13])
    OB d_10_pad (.I(d_10_c), .O(d_10));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(61[9:13])
    OB d_11_pad (.I(d_11_c), .O(d_11));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(62[9:13])
    OB d_12_pad (.I(d_12_c), .O(d_12));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(63[9:13])
    OB d_13_pad (.I(d_13_c), .O(d_13));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(64[9:13])
    OB d_14_pad (.I(d_14_c), .O(d_14));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(65[9:13])
    OB d_15_pad (.I(d_15_c), .O(d_15));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(66[9:13])
    OB d_16_pad (.I(d_16_c), .O(d_16));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(67[9:13])
    OB d_17_pad (.I(d_17_c), .O(d_17));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(68[9:13])
    OB d_18_pad (.I(d_18_c), .O(d_18));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(69[9:13])
    OB d_19_pad (.I(d_19_c), .O(d_19));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(70[9:13])
    OB d_20_pad (.I(d_20_c), .O(d_20));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(71[9:13])
    OB d_21_pad (.I(d_21_c), .O(d_21));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(72[9:13])
    OB d_22_pad (.I(d_22_c), .O(d_22));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(73[9:13])
    OB d_23_pad (.I(d_23_c), .O(d_23));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(74[9:13])
    OB d_24_pad (.I(d_24_c), .O(d_24));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(75[9:13])
    OB d_25_pad (.I(d_25_c), .O(d_25));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(76[9:13])
    OB d_26_pad (.I(GND_net), .O(d_26));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(77[9:13])
    OB d_27_pad (.I(GND_net), .O(d_27));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(78[9:13])
    OB d_28_pad (.I(GND_net), .O(d_28));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(79[9:13])
    OB d_29_pad (.I(GND_net), .O(d_29));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(80[9:13])
    IB pilot_in_pad (.I(pilot_in), .O(pilot_in_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(9[3:11])
    IB reqsafestate_pad (.I(reqsafestate), .O(reqsafestate_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(10[3:15])
    IB carrierrdy_pad (.I(carrierrdy), .O(carrierrdy_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(11[3:13])
    IB i2c_scl_pad (.I(i2c_scl), .O(i2c_scl_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(16[9:16])
    IB i2c_sda_pad (.I(i2c_sda), .O(i2c_sda_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(17[9:16])
    IB fpga_00_pad (.I(fpga_00), .O(fpga_00_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(19[9:16])
    IB fpga_01_pad (.I(fpga_01), .O(fpga_01_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(20[9:16])
    IB fpga_02_pad (.I(fpga_02), .O(fpga_02_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(21[9:16])
    IB fpga_03_pad (.I(fpga_03), .O(fpga_03_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(22[9:16])
    IB fpga_04_pad (.I(fpga_04), .O(fpga_04_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(23[9:16])
    IB fpga_05_pad (.I(fpga_05), .O(fpga_05_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(24[9:16])
    IB fpga_06_pad (.I(fpga_06), .O(fpga_06_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(25[9:16])
    IB fpga_07_pad (.I(fpga_07), .O(fpga_07_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(26[9:16])
    IB fpga_08_pad (.I(fpga_08), .O(fpga_08_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(27[9:16])
    IB fpga_09_pad (.I(fpga_09), .O(fpga_09_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(28[9:16])
    IB fpga_10_pad (.I(fpga_10), .O(fpga_10_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(29[9:16])
    IB fpga_11_pad (.I(fpga_11), .O(fpga_11_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(30[9:16])
    IB fpga_12_pad (.I(fpga_12), .O(fpga_12_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(31[9:16])
    IB fpga_13_pad (.I(fpga_13), .O(fpga_13_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(32[9:16])
    IB fpga_14_pad (.I(fpga_14), .O(fpga_14_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(33[9:16])
    IB fpga_15_pad (.I(fpga_15), .O(fpga_15_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(34[9:16])
    IB fpga_16_pad (.I(fpga_16), .O(fpga_16_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(35[9:16])
    IB fpga_17_pad (.I(fpga_17), .O(fpga_17_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(36[9:16])
    IB fpga_18_pad (.I(fpga_18), .O(fpga_18_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(37[9:16])
    IB fpga_19_pad (.I(fpga_19), .O(fpga_19_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(38[9:16])
    IB fpga_20_pad (.I(fpga_20), .O(fpga_20_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(39[9:16])
    IB fpga_21_pad (.I(fpga_21), .O(fpga_21_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(40[9:16])
    IB fpga_22_pad (.I(fpga_22), .O(fpga_22_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(41[9:16])
    IB fpga_23_pad (.I(fpga_23), .O(fpga_23_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(42[9:16])
    IB fpga_24_pad (.I(fpga_24), .O(fpga_24_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(43[9:16])
    IB fpga_25_pad (.I(fpga_25), .O(fpga_25_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(44[9:16])
    IB fpga_26_pad (.I(fpga_26), .O(fpga_26_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(45[9:16])
    IB fpga_27_pad (.I(fpga_27), .O(fpga_27_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(46[9:16])
    IB fpga_28_pad (.I(fpga_28), .O(fpga_28_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(47[9:16])
    IB fpga_29_pad (.I(fpga_29), .O(fpga_29_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/template_dslots/source/template_w_enable.vhdl(48[9:16])
    GSR GSR_INST (.GSR(VCC_net));
    TSALL TSALL_INST (.TSALL(GND_net));
    VHI i73 (.Z(VCC_net));
    
endmodule
//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

