// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Wed Oct 23 15:30:16 2024
//
// Verilog Description of module ButtonDebounce
//

module ButtonDebounce (powertaster, poweron, resetn, rst, button_in, 
            button_out);   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(8[8:22])
    input powertaster;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(10[9:20])
    output poweron;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(11[9:16])
    output resetn;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(12[3:9])
    input rst;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(13[3:6])
    input button_in;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(14[9:18])
    output button_out;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(15[9:19])
    
    wire clk /* synthesis SET_AS_NETWORK=clk, is_clock=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(28[8:11])
    
    wire GND_net, VCC_net, poweron_c_c, n550, rst_c, button_in_c, 
        button_out_c;
    wire [31:0]counter;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(25[8:15])
    
    wire last_button;
    wire [17:0]count_100ms;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(29[8:19])
    wire [16:0]count_50ms;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(30[8:18])
    
    wire n17, n16, count_done_100ms, reset_triggered, n15, n14, 
        n13, n12, n11, n75, n665, n10, n74, count_done_100ms_N_89, 
        clk_enable_5, reset_triggered_N_150, n701, n84, n77, n76, 
        n80, n79, n82, n81, n6, n18, n664, clk_enable_36, n9, 
        n8, n663, n662, n17_adj_1, n16_adj_2, n15_adj_3, n14_adj_4, 
        n13_adj_5, n12_adj_6, n11_adj_7, n10_adj_8, n9_adj_9, n8_adj_10, 
        n78, n83, clk_enable_6, resetn_N_141, n712, resetn_N_155, 
        resetn_N_142, n714, n590, n218, n219, n220, n221, n222, 
        n223, n224, n225, n226, n227, n228, n229, n230, n231, 
        n232, n233, n234, n235, n236, n237, n238, n239, n240, 
        n241, n242, n243, n244, n245, n246, n247, n248, n249, 
        n678, n677, n676, n675, n674, n673, n672, n671, n670, 
        n669, n668, n667, n661, n660, n659, n658, n85, n657, 
        n656, n655, n654, n653, n652, n6_adj_11, n651, n650, 
        n649, n648, n647, n599, n646, n645, n522, clk_enable_52, 
        n90, n89, n88, n87, n86, n710, n479, n78_adj_12, n79_adj_13, 
        n80_adj_14, n81_adj_15, n82_adj_16, n83_adj_17, n84_adj_18, 
        n85_adj_19, n86_adj_20, n87_adj_21, n88_adj_22, n89_adj_23, 
        n90_adj_24, n91, n92, n93, n94, n95, n703, n644, n643, 
        n642, n687, n686, n685, n684, n683, n682, n681, n680, 
        n679, n552;
    
    VHI i236 (.Z(VCC_net));
    LUT4 resetn_I_1_3_lut_rep_3_4_lut_4_lut (.A(count_done_100ms), .B(resetn_N_155), 
         .C(n701), .D(n712), .Z(clk_enable_5)) /* synthesis lut_function=(A (B)+!A (C (D))) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(72[16:36])
    defparam resetn_I_1_3_lut_rep_3_4_lut_4_lut.init = 16'hd888;
    LUT4 button_in_I_0_83_2_lut_rep_4 (.A(button_in_c), .B(last_button), 
         .Z(n710)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(100[16:40])
    defparam button_in_I_0_83_2_lut_rep_4.init = 16'h6666;
    CCU2D add_56_23 (.A0(counter[21]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[22]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n652), .COUT(n653), .S0(n228), .S1(n227));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_23.INIT0 = 16'h5aaa;
    defparam add_56_23.INIT1 = 16'h5aaa;
    defparam add_56_23.INJECT1_0 = "NO";
    defparam add_56_23.INJECT1_1 = "NO";
    LUT4 i121_2_lut_3_lut (.A(button_in_c), .B(last_button), .C(n479), 
         .Z(clk_enable_36)) /* synthesis lut_function=(!(A (B (C))+!A !(B+!(C)))) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(100[16:40])
    defparam i121_2_lut_3_lut.init = 16'h6f6f;
    FD1P3IX counter__i2 (.D(n247), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[2])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i2.GSR = "ENABLED";
    CCU2D add_56_29 (.A0(counter[27]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[28]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n655), .COUT(n656), .S0(n222), .S1(n221));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_29.INIT0 = 16'h5aaa;
    defparam add_56_29.INIT1 = 16'h5aaa;
    defparam add_56_29.INJECT1_0 = "NO";
    defparam add_56_29.INJECT1_1 = "NO";
    CCU2D add_56_27 (.A0(counter[25]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[26]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n654), .COUT(n655), .S0(n224), .S1(n223));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_27.INIT0 = 16'h5aaa;
    defparam add_56_27.INIT1 = 16'h5aaa;
    defparam add_56_27.INJECT1_0 = "NO";
    defparam add_56_27.INJECT1_1 = "NO";
    FD1P3AX count_100ms_113__i1 (.D(n94), .SP(clk_enable_52), .CK(clk), 
            .Q(n17_adj_1)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i1.GSR = "DISABLED";
    CCU2D add_214_2 (.A0(counter[7]), .B0(counter[6]), .C0(GND_net), .D0(GND_net), 
          .A1(counter[8]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n676));
    defparam add_214_2.INIT0 = 16'h1000;
    defparam add_214_2.INIT1 = 16'h5aaa;
    defparam add_214_2.INJECT1_0 = "NO";
    defparam add_214_2.INJECT1_1 = "NO";
    FD1P3AX count_50ms_114__i0 (.D(n90), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(n17)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i0.GSR = "DISABLED";
    FD1S3AX last_button_77 (.D(button_in_c), .CK(clk), .Q(last_button)) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam last_button_77.GSR = "ENABLED";
    FD1P3IX counter__i1 (.D(n248), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[1])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i1.GSR = "ENABLED";
    OBZ n551_pad (.I(resetn_N_141), .T(n552), .O(resetn));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(69[5] 90[17])
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk)) /* synthesis NOM_FREQ="2.56", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "2.56";
    FD1P3IX counter__i0 (.D(n249), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[0])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i0.GSR = "ENABLED";
    LUT4 i1_2_lut (.A(count_100ms[16]), .B(count_100ms[17]), .Z(n6_adj_11)) /* synthesis lut_function=(A (B)) */ ;
    defparam i1_2_lut.init = 16'h8888;
    CCU2D add_56_21 (.A0(counter[19]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[20]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n651), .COUT(n652), .S0(n230), .S1(n229));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_21.INIT0 = 16'h5aaa;
    defparam add_56_21.INIT1 = 16'h5aaa;
    defparam add_56_21.INJECT1_0 = "NO";
    defparam add_56_21.INJECT1_1 = "NO";
    CCU2D add_56_19 (.A0(counter[17]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[18]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n650), .COUT(n651), .S0(n232), .S1(n231));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_19.INIT0 = 16'h5aaa;
    defparam add_56_19.INIT1 = 16'h5aaa;
    defparam add_56_19.INJECT1_0 = "NO";
    defparam add_56_19.INJECT1_1 = "NO";
    FD1P3AX count_50ms_114__i16 (.D(n74), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(count_50ms[16])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i16.GSR = "DISABLED";
    CCU2D add_56_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n642), .S1(n249));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_1.INIT0 = 16'hF000;
    defparam add_56_1.INIT1 = 16'h5555;
    defparam add_56_1.INJECT1_0 = "NO";
    defparam add_56_1.INJECT1_1 = "NO";
    LUT4 i155_2_lut_3_lut (.A(button_in_c), .B(last_button), .C(n479), 
         .Z(clk_enable_6)) /* synthesis lut_function=(A (B (C))+!A !(B+!(C))) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(100[16:40])
    defparam i155_2_lut_3_lut.init = 16'h9090;
    LUT4 i4_4_lut (.A(count_50ms[14]), .B(count_50ms[16]), .C(count_50ms[12]), 
         .D(n6), .Z(n703)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(82[20:39])
    defparam i4_4_lut.init = 16'h8000;
    LUT4 i1_2_lut_adj_1 (.A(count_50ms[15]), .B(count_50ms[13]), .Z(n6)) /* synthesis lut_function=(A (B)) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(82[20:39])
    defparam i1_2_lut_adj_1.init = 16'h8888;
    CCU2D add_56_17 (.A0(counter[15]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[16]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n649), .COUT(n650), .S0(n234), .S1(n233));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_17.INIT0 = 16'h5aaa;
    defparam add_56_17.INIT1 = 16'h5aaa;
    defparam add_56_17.INJECT1_0 = "NO";
    defparam add_56_17.INJECT1_1 = "NO";
    FD1P3AX count_50ms_114__i15 (.D(n75), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(count_50ms[15])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i15.GSR = "DISABLED";
    FD1P3AX i47_74 (.D(clk_enable_52), .SP(clk_enable_5), .CK(clk), .Q(resetn_N_142));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(71[9] 89[16])
    defparam i47_74.GSR = "DISABLED";
    CCU2D add_56_25 (.A0(counter[23]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[24]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n653), .COUT(n654), .S0(n226), .S1(n225));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_25.INIT0 = 16'h5aaa;
    defparam add_56_25.INIT1 = 16'h5aaa;
    defparam add_56_25.INJECT1_0 = "NO";
    defparam add_56_25.INJECT1_1 = "NO";
    FD1P3AX stable_state_76 (.D(button_in_c), .SP(clk_enable_6), .CK(clk), 
            .Q(button_out_c)) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam stable_state_76.GSR = "ENABLED";
    FD1P3AX count_done_100ms_70 (.D(n714), .SP(count_done_100ms_N_89), .CK(clk), 
            .Q(count_done_100ms)) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(71[9] 89[16])
    defparam count_done_100ms_70.GSR = "DISABLED";
    FD1P3AX count_50ms_114__i14 (.D(n76), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(count_50ms[14])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i14.GSR = "DISABLED";
    FD1P3AX count_50ms_114__i13 (.D(n77), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(count_50ms[13])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i13.GSR = "DISABLED";
    OB poweron_pad (.I(poweron_c_c), .O(poweron));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(11[9:16])
    FD1P3AX count_50ms_114__i12 (.D(n78), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(count_50ms[12])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i12.GSR = "DISABLED";
    FD1P3AX count_50ms_114__i11 (.D(n79), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(count_50ms[11])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i11.GSR = "DISABLED";
    FD1P3AX count_50ms_114__i10 (.D(n80), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(count_50ms[10])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i10.GSR = "DISABLED";
    FD1P3AX count_50ms_114__i9 (.D(n81), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(n8)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i9.GSR = "DISABLED";
    FD1P3AX count_100ms_113__i0 (.D(n95), .SP(clk_enable_52), .CK(clk), 
            .Q(n18)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i0.GSR = "DISABLED";
    FD1P3AX count_50ms_114__i8 (.D(n82), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(n9)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i8.GSR = "DISABLED";
    FD1P3AX count_50ms_114__i7 (.D(n83), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(n10)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i7.GSR = "DISABLED";
    FD1P3AX count_50ms_114__i6 (.D(n84), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(n11)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i6.GSR = "DISABLED";
    FD1P3AX count_50ms_114__i5 (.D(n85), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(n12)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i5.GSR = "DISABLED";
    FD1P3AX count_50ms_114__i4 (.D(n86), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(n13)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i4.GSR = "DISABLED";
    FD1P3AX count_50ms_114__i3 (.D(n87), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(n14)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i3.GSR = "DISABLED";
    FD1P3AX count_50ms_114__i2 (.D(n88), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(n15)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i2.GSR = "DISABLED";
    FD1P3AX count_50ms_114__i1 (.D(n89), .SP(reset_triggered_N_150), .CK(clk), 
            .Q(n16)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114__i1.GSR = "DISABLED";
    FD1P3IX counter__i31 (.D(n218), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[31])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i31.GSR = "ENABLED";
    CCU2D count_100ms_113_add_4_19 (.A0(count_100ms[17]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n675), .S0(n78_adj_12));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113_add_4_19.INIT0 = 16'hfaaa;
    defparam count_100ms_113_add_4_19.INIT1 = 16'h0000;
    defparam count_100ms_113_add_4_19.INJECT1_0 = "NO";
    defparam count_100ms_113_add_4_19.INJECT1_1 = "NO";
    CCU2D count_100ms_113_add_4_17 (.A0(count_100ms[15]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(count_100ms[16]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n674), .COUT(n675), .S0(n80_adj_14), 
          .S1(n79_adj_13));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113_add_4_17.INIT0 = 16'hfaaa;
    defparam count_100ms_113_add_4_17.INIT1 = 16'hfaaa;
    defparam count_100ms_113_add_4_17.INJECT1_0 = "NO";
    defparam count_100ms_113_add_4_17.INJECT1_1 = "NO";
    CCU2D count_100ms_113_add_4_15 (.A0(count_100ms[13]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(count_100ms[14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n673), .COUT(n674), .S0(n82_adj_16), 
          .S1(n81_adj_15));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113_add_4_15.INIT0 = 16'hfaaa;
    defparam count_100ms_113_add_4_15.INIT1 = 16'hfaaa;
    defparam count_100ms_113_add_4_15.INJECT1_0 = "NO";
    defparam count_100ms_113_add_4_15.INJECT1_1 = "NO";
    CCU2D count_100ms_113_add_4_13 (.A0(count_100ms[11]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(count_100ms[12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n672), .COUT(n673), .S0(n84_adj_18), 
          .S1(n83_adj_17));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113_add_4_13.INIT0 = 16'hfaaa;
    defparam count_100ms_113_add_4_13.INIT1 = 16'hfaaa;
    defparam count_100ms_113_add_4_13.INJECT1_0 = "NO";
    defparam count_100ms_113_add_4_13.INJECT1_1 = "NO";
    CCU2D count_100ms_113_add_4_11 (.A0(n9_adj_9), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n8_adj_10), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n671), .COUT(n672), .S0(n86_adj_20), .S1(n85_adj_19));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113_add_4_11.INIT0 = 16'hfaaa;
    defparam count_100ms_113_add_4_11.INIT1 = 16'hfaaa;
    defparam count_100ms_113_add_4_11.INJECT1_0 = "NO";
    defparam count_100ms_113_add_4_11.INJECT1_1 = "NO";
    CCU2D count_100ms_113_add_4_9 (.A0(n11_adj_7), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n10_adj_8), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n670), .COUT(n671), .S0(n88_adj_22), .S1(n87_adj_21));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113_add_4_9.INIT0 = 16'hfaaa;
    defparam count_100ms_113_add_4_9.INIT1 = 16'hfaaa;
    defparam count_100ms_113_add_4_9.INJECT1_0 = "NO";
    defparam count_100ms_113_add_4_9.INJECT1_1 = "NO";
    CCU2D count_100ms_113_add_4_7 (.A0(n13_adj_5), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n12_adj_6), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n669), .COUT(n670), .S0(n90_adj_24), .S1(n89_adj_23));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113_add_4_7.INIT0 = 16'hfaaa;
    defparam count_100ms_113_add_4_7.INIT1 = 16'hfaaa;
    defparam count_100ms_113_add_4_7.INJECT1_0 = "NO";
    defparam count_100ms_113_add_4_7.INJECT1_1 = "NO";
    CCU2D count_100ms_113_add_4_5 (.A0(n15_adj_3), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n14_adj_4), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n668), .COUT(n669), .S0(n92), .S1(n91));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113_add_4_5.INIT0 = 16'hfaaa;
    defparam count_100ms_113_add_4_5.INIT1 = 16'hfaaa;
    defparam count_100ms_113_add_4_5.INJECT1_0 = "NO";
    defparam count_100ms_113_add_4_5.INJECT1_1 = "NO";
    CCU2D count_100ms_113_add_4_3 (.A0(n17_adj_1), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n16_adj_2), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n667), .COUT(n668), .S0(n94), .S1(n93));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113_add_4_3.INIT0 = 16'hfaaa;
    defparam count_100ms_113_add_4_3.INIT1 = 16'hfaaa;
    defparam count_100ms_113_add_4_3.INJECT1_0 = "NO";
    defparam count_100ms_113_add_4_3.INJECT1_1 = "NO";
    CCU2D count_100ms_113_add_4_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n712), .B1(n701), .C1(n18), .D1(GND_net), 
          .COUT(n667), .S1(n95));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113_add_4_1.INIT0 = 16'hF000;
    defparam count_100ms_113_add_4_1.INIT1 = 16'h8787;
    defparam count_100ms_113_add_4_1.INJECT1_0 = "NO";
    defparam count_100ms_113_add_4_1.INJECT1_1 = "NO";
    CCU2D count_50ms_114_add_4_17 (.A0(count_50ms[15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(count_50ms[16]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n665), .S0(n75), .S1(n74));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114_add_4_17.INIT0 = 16'hfaaa;
    defparam count_50ms_114_add_4_17.INIT1 = 16'hfaaa;
    defparam count_50ms_114_add_4_17.INJECT1_0 = "NO";
    defparam count_50ms_114_add_4_17.INJECT1_1 = "NO";
    CCU2D count_50ms_114_add_4_15 (.A0(count_50ms[13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(count_50ms[14]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n664), .COUT(n665), .S0(n77), .S1(n76));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114_add_4_15.INIT0 = 16'hfaaa;
    defparam count_50ms_114_add_4_15.INIT1 = 16'hfaaa;
    defparam count_50ms_114_add_4_15.INJECT1_0 = "NO";
    defparam count_50ms_114_add_4_15.INJECT1_1 = "NO";
    CCU2D count_50ms_114_add_4_13 (.A0(count_50ms[11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(count_50ms[12]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n663), .COUT(n664), .S0(n79), .S1(n78));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114_add_4_13.INIT0 = 16'hfaaa;
    defparam count_50ms_114_add_4_13.INIT1 = 16'hfaaa;
    defparam count_50ms_114_add_4_13.INJECT1_0 = "NO";
    defparam count_50ms_114_add_4_13.INJECT1_1 = "NO";
    CCU2D count_50ms_114_add_4_11 (.A0(n8), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(count_50ms[10]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n662), .COUT(n663), .S0(n81), .S1(n80));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114_add_4_11.INIT0 = 16'hfaaa;
    defparam count_50ms_114_add_4_11.INIT1 = 16'hfaaa;
    defparam count_50ms_114_add_4_11.INJECT1_0 = "NO";
    defparam count_50ms_114_add_4_11.INJECT1_1 = "NO";
    CCU2D count_50ms_114_add_4_9 (.A0(n10), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n9), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n661), .COUT(n662), .S0(n83), .S1(n82));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114_add_4_9.INIT0 = 16'hfaaa;
    defparam count_50ms_114_add_4_9.INIT1 = 16'hfaaa;
    defparam count_50ms_114_add_4_9.INJECT1_0 = "NO";
    defparam count_50ms_114_add_4_9.INJECT1_1 = "NO";
    CCU2D count_50ms_114_add_4_7 (.A0(n12), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n11), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n660), .COUT(n661), .S0(n85), .S1(n84));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114_add_4_7.INIT0 = 16'hfaaa;
    defparam count_50ms_114_add_4_7.INIT1 = 16'hfaaa;
    defparam count_50ms_114_add_4_7.INJECT1_0 = "NO";
    defparam count_50ms_114_add_4_7.INJECT1_1 = "NO";
    CCU2D count_50ms_114_add_4_5 (.A0(n14), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n13), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n659), .COUT(n660), .S0(n87), .S1(n86));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114_add_4_5.INIT0 = 16'hfaaa;
    defparam count_50ms_114_add_4_5.INIT1 = 16'hfaaa;
    defparam count_50ms_114_add_4_5.INJECT1_0 = "NO";
    defparam count_50ms_114_add_4_5.INJECT1_1 = "NO";
    CCU2D count_50ms_114_add_4_3 (.A0(n16), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n15), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n658), .COUT(n659), .S0(n89), .S1(n88));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114_add_4_3.INIT0 = 16'hfaaa;
    defparam count_50ms_114_add_4_3.INIT1 = 16'hfaaa;
    defparam count_50ms_114_add_4_3.INJECT1_0 = "NO";
    defparam count_50ms_114_add_4_3.INJECT1_1 = "NO";
    CCU2D count_50ms_114_add_4_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n599), .B1(n703), .C1(n17), .D1(GND_net), 
          .COUT(n658), .S1(n90));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(83[35:45])
    defparam count_50ms_114_add_4_1.INIT0 = 16'hF000;
    defparam count_50ms_114_add_4_1.INIT1 = 16'h8787;
    defparam count_50ms_114_add_4_1.INJECT1_0 = "NO";
    defparam count_50ms_114_add_4_1.INJECT1_1 = "NO";
    CCU2D add_56_33 (.A0(counter[31]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n657), 
          .S0(n218));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_33.INIT0 = 16'h5aaa;
    defparam add_56_33.INIT1 = 16'h0000;
    defparam add_56_33.INJECT1_0 = "NO";
    defparam add_56_33.INJECT1_1 = "NO";
    CCU2D add_56_31 (.A0(counter[29]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[30]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n656), .COUT(n657), .S0(n220), .S1(n219));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_31.INIT0 = 16'h5aaa;
    defparam add_56_31.INIT1 = 16'h5aaa;
    defparam add_56_31.INJECT1_0 = "NO";
    defparam add_56_31.INJECT1_1 = "NO";
    LUT4 i199_2_lut (.A(count_50ms[10]), .B(count_50ms[11]), .Z(n599)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i199_2_lut.init = 16'heeee;
    LUT4 i125_1_lut_3_lut_4_lut_4_lut (.A(count_done_100ms), .B(resetn_N_155), 
         .C(n701), .D(n712), .Z(n522)) /* synthesis lut_function=(!(A (B)+!A (C (D)))) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(72[16:36])
    defparam i125_1_lut_3_lut_4_lut_4_lut.init = 16'h2777;
    CCU2D add_56_15 (.A0(counter[13]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[14]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n648), .COUT(n649), .S0(n236), .S1(n235));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_15.INIT0 = 16'h5aaa;
    defparam add_56_15.INIT1 = 16'h5aaa;
    defparam add_56_15.INJECT1_0 = "NO";
    defparam add_56_15.INJECT1_1 = "NO";
    LUT4 i201_2_lut_rep_6 (.A(count_100ms[11]), .B(count_100ms[12]), .Z(n712)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i201_2_lut_rep_6.init = 16'heeee;
    CCU2D add_56_13 (.A0(counter[11]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[12]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n647), .COUT(n648), .S0(n238), .S1(n237));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_13.INIT0 = 16'h5aaa;
    defparam add_56_13.INIT1 = 16'h5aaa;
    defparam add_56_13.INJECT1_0 = "NO";
    defparam add_56_13.INJECT1_1 = "NO";
    CCU2D add_56_11 (.A0(counter[9]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[10]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n646), .COUT(n647), .S0(n240), .S1(n239));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_11.INIT0 = 16'h5aaa;
    defparam add_56_11.INIT1 = 16'h5aaa;
    defparam add_56_11.INJECT1_0 = "NO";
    defparam add_56_11.INJECT1_1 = "NO";
    LUT4 i194_2_lut_3_lut_4_lut (.A(count_100ms[11]), .B(count_100ms[12]), 
         .C(count_done_100ms), .D(n701), .Z(count_done_100ms_N_89)) /* synthesis lut_function=(A (C+(D))+!A (B (C+(D))+!B (C))) */ ;
    defparam i194_2_lut_3_lut_4_lut.init = 16'hfef0;
    LUT4 i190_1_lut (.A(rst_c), .Z(n590)) /* synthesis lut_function=(!(A)) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(13[3:6])
    defparam i190_1_lut.init = 16'h5555;
    LUT4 i235_2_lut (.A(resetn_N_141), .B(resetn_N_142), .Z(n550)) /* synthesis lut_function=(!(A (B))) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(69[5] 90[17])
    defparam i235_2_lut.init = 16'h7777;
    LUT4 count_done_100ms_I_0_2_lut (.A(count_done_100ms), .B(reset_triggered), 
         .Z(reset_triggered_N_150)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(80[19:59])
    defparam count_done_100ms_I_0_2_lut.init = 16'h2222;
    CCU2D add_214_26 (.A0(counter[31]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n687), 
          .S1(n479));
    defparam add_214_26.INIT0 = 16'hf555;
    defparam add_214_26.INIT1 = 16'h0000;
    defparam add_214_26.INJECT1_0 = "NO";
    defparam add_214_26.INJECT1_1 = "NO";
    CCU2D add_214_24 (.A0(counter[29]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[30]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n686), .COUT(n687));
    defparam add_214_24.INIT0 = 16'h5555;
    defparam add_214_24.INIT1 = 16'h5555;
    defparam add_214_24.INJECT1_0 = "NO";
    defparam add_214_24.INJECT1_1 = "NO";
    CCU2D add_214_22 (.A0(counter[27]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[28]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n685), .COUT(n686));
    defparam add_214_22.INIT0 = 16'h5555;
    defparam add_214_22.INIT1 = 16'h5555;
    defparam add_214_22.INJECT1_0 = "NO";
    defparam add_214_22.INJECT1_1 = "NO";
    CCU2D add_214_20 (.A0(counter[25]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[26]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n684), .COUT(n685));
    defparam add_214_20.INIT0 = 16'h5555;
    defparam add_214_20.INIT1 = 16'h5555;
    defparam add_214_20.INJECT1_0 = "NO";
    defparam add_214_20.INJECT1_1 = "NO";
    CCU2D add_214_18 (.A0(counter[23]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[24]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n683), .COUT(n684));
    defparam add_214_18.INIT0 = 16'h5555;
    defparam add_214_18.INIT1 = 16'h5555;
    defparam add_214_18.INJECT1_0 = "NO";
    defparam add_214_18.INJECT1_1 = "NO";
    CCU2D add_214_16 (.A0(counter[21]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[22]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n682), .COUT(n683));
    defparam add_214_16.INIT0 = 16'h5555;
    defparam add_214_16.INIT1 = 16'h5555;
    defparam add_214_16.INJECT1_0 = "NO";
    defparam add_214_16.INJECT1_1 = "NO";
    CCU2D add_214_14 (.A0(counter[19]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[20]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n681), .COUT(n682));
    defparam add_214_14.INIT0 = 16'h5555;
    defparam add_214_14.INIT1 = 16'h5555;
    defparam add_214_14.INJECT1_0 = "NO";
    defparam add_214_14.INJECT1_1 = "NO";
    CCU2D add_214_12 (.A0(counter[17]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[18]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n680), .COUT(n681));
    defparam add_214_12.INIT0 = 16'h5aaa;
    defparam add_214_12.INIT1 = 16'h5555;
    defparam add_214_12.INJECT1_0 = "NO";
    defparam add_214_12.INJECT1_1 = "NO";
    CCU2D add_214_10 (.A0(counter[15]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[16]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n679), .COUT(n680));
    defparam add_214_10.INIT0 = 16'h5555;
    defparam add_214_10.INIT1 = 16'h5aaa;
    defparam add_214_10.INJECT1_0 = "NO";
    defparam add_214_10.INJECT1_1 = "NO";
    CCU2D add_214_8 (.A0(counter[13]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[14]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n678), .COUT(n679));
    defparam add_214_8.INIT0 = 16'h5555;
    defparam add_214_8.INIT1 = 16'h5555;
    defparam add_214_8.INJECT1_0 = "NO";
    defparam add_214_8.INJECT1_1 = "NO";
    CCU2D add_214_6 (.A0(counter[11]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[12]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n677), .COUT(n678));
    defparam add_214_6.INIT0 = 16'h5aaa;
    defparam add_214_6.INIT1 = 16'h5555;
    defparam add_214_6.INJECT1_0 = "NO";
    defparam add_214_6.INJECT1_1 = "NO";
    FD1P3IX counter__i30 (.D(n219), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[30])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i30.GSR = "ENABLED";
    FD1P3IX counter__i29 (.D(n220), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[29])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i29.GSR = "ENABLED";
    FD1P3IX counter__i28 (.D(n221), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[28])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i28.GSR = "ENABLED";
    FD1P3IX counter__i27 (.D(n222), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[27])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i27.GSR = "ENABLED";
    FD1P3IX counter__i26 (.D(n223), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[26])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i26.GSR = "ENABLED";
    FD1P3IX counter__i25 (.D(n224), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[25])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i25.GSR = "ENABLED";
    FD1P3IX counter__i24 (.D(n225), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[24])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i24.GSR = "ENABLED";
    FD1P3IX counter__i23 (.D(n226), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[23])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i23.GSR = "ENABLED";
    FD1P3IX counter__i22 (.D(n227), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[22])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i22.GSR = "ENABLED";
    FD1P3IX counter__i21 (.D(n228), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[21])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i21.GSR = "ENABLED";
    FD1P3IX counter__i20 (.D(n229), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[20])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i20.GSR = "ENABLED";
    FD1P3IX counter__i19 (.D(n230), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[19])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i19.GSR = "ENABLED";
    FD1P3IX counter__i18 (.D(n231), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[18])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i18.GSR = "ENABLED";
    FD1P3IX counter__i17 (.D(n232), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[17])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i17.GSR = "ENABLED";
    FD1P3IX counter__i16 (.D(n233), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[16])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i16.GSR = "ENABLED";
    FD1P3IX counter__i15 (.D(n234), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[15])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i15.GSR = "ENABLED";
    FD1P3IX counter__i14 (.D(n235), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[14])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i14.GSR = "ENABLED";
    FD1P3IX counter__i13 (.D(n236), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[13])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i13.GSR = "ENABLED";
    FD1P3IX counter__i12 (.D(n237), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[12])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i12.GSR = "ENABLED";
    FD1P3IX counter__i11 (.D(n238), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[11])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i11.GSR = "ENABLED";
    FD1P3IX counter__i10 (.D(n239), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[10])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i10.GSR = "ENABLED";
    FD1P3IX counter__i9 (.D(n240), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[9])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i9.GSR = "ENABLED";
    FD1P3IX counter__i8 (.D(n241), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[8])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i8.GSR = "ENABLED";
    FD1P3IX counter__i7 (.D(n242), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[7])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i7.GSR = "ENABLED";
    FD1P3IX counter__i6 (.D(n243), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[6])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i6.GSR = "ENABLED";
    FD1P3IX counter__i5 (.D(n244), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[5])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i5.GSR = "ENABLED";
    FD1P3IX counter__i4 (.D(n245), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[4])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i4.GSR = "ENABLED";
    FD1P3IX counter__i3 (.D(n246), .SP(clk_enable_36), .CD(n710), .CK(clk), 
            .Q(counter[3])) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(94[9] 113[16])
    defparam counter__i3.GSR = "ENABLED";
    FD1P3AX count_100ms_113__i2 (.D(n93), .SP(clk_enable_52), .CK(clk), 
            .Q(n16_adj_2)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i2.GSR = "DISABLED";
    LUT4 i3_4_lut (.A(count_done_100ms), .B(n703), .C(n599), .D(reset_triggered), 
         .Z(resetn_N_155)) /* synthesis lut_function=(!((((D)+!C)+!B)+!A)) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(80[19:59])
    defparam i3_4_lut.init = 16'h0080;
    OB button_out_pad (.I(button_out_c), .O(button_out));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(15[9:19])
    IB poweron_c_pad (.I(powertaster), .O(poweron_c_c));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(10[9:20])
    IB rst_pad (.I(rst), .O(rst_c));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(13[3:6])
    IB button_in_pad (.I(button_in), .O(button_in_c));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(14[9:18])
    FD1P3AX count_100ms_113__i3 (.D(n92), .SP(clk_enable_52), .CK(clk), 
            .Q(n15_adj_3)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i3.GSR = "DISABLED";
    FD1P3AX count_100ms_113__i4 (.D(n91), .SP(clk_enable_52), .CK(clk), 
            .Q(n14_adj_4)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i4.GSR = "DISABLED";
    FD1P3AX count_100ms_113__i5 (.D(n90_adj_24), .SP(clk_enable_52), .CK(clk), 
            .Q(n13_adj_5)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i5.GSR = "DISABLED";
    FD1P3AX count_100ms_113__i6 (.D(n89_adj_23), .SP(clk_enable_52), .CK(clk), 
            .Q(n12_adj_6)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i6.GSR = "DISABLED";
    FD1P3AX count_100ms_113__i7 (.D(n88_adj_22), .SP(clk_enable_52), .CK(clk), 
            .Q(n11_adj_7)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i7.GSR = "DISABLED";
    FD1P3AX count_100ms_113__i8 (.D(n87_adj_21), .SP(clk_enable_52), .CK(clk), 
            .Q(n10_adj_8)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i8.GSR = "DISABLED";
    FD1P3AX count_100ms_113__i9 (.D(n86_adj_20), .SP(clk_enable_52), .CK(clk), 
            .Q(n9_adj_9)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i9.GSR = "DISABLED";
    FD1P3AX count_100ms_113__i10 (.D(n85_adj_19), .SP(clk_enable_52), .CK(clk), 
            .Q(n8_adj_10)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i10.GSR = "DISABLED";
    FD1P3AX count_100ms_113__i11 (.D(n84_adj_18), .SP(clk_enable_52), .CK(clk), 
            .Q(count_100ms[11])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i11.GSR = "DISABLED";
    FD1P3AX count_100ms_113__i12 (.D(n83_adj_17), .SP(clk_enable_52), .CK(clk), 
            .Q(count_100ms[12])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i12.GSR = "DISABLED";
    FD1P3AX count_100ms_113__i13 (.D(n82_adj_16), .SP(clk_enable_52), .CK(clk), 
            .Q(count_100ms[13])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i13.GSR = "DISABLED";
    FD1P3AX count_100ms_113__i14 (.D(n81_adj_15), .SP(clk_enable_52), .CK(clk), 
            .Q(count_100ms[14])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i14.GSR = "DISABLED";
    FD1P3AX count_100ms_113__i15 (.D(n80_adj_14), .SP(clk_enable_52), .CK(clk), 
            .Q(count_100ms[15])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i15.GSR = "DISABLED";
    FD1P3AX count_100ms_113__i16 (.D(n79_adj_13), .SP(clk_enable_52), .CK(clk), 
            .Q(count_100ms[16])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i16.GSR = "DISABLED";
    FD1P3AX count_100ms_113__i17 (.D(n78_adj_12), .SP(clk_enable_52), .CK(clk), 
            .Q(count_100ms[17])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(75[36:47])
    defparam count_100ms_113__i17.GSR = "DISABLED";
    CCU2D add_56_9 (.A0(counter[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[8]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n645), .COUT(n646), .S0(n242), .S1(n241));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_9.INIT0 = 16'h5aaa;
    defparam add_56_9.INIT1 = 16'h5aaa;
    defparam add_56_9.INJECT1_0 = "NO";
    defparam add_56_9.INJECT1_1 = "NO";
    CCU2D add_56_7 (.A0(counter[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n644), .COUT(n645), .S0(n244), .S1(n243));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_7.INIT0 = 16'h5aaa;
    defparam add_56_7.INIT1 = 16'h5aaa;
    defparam add_56_7.INJECT1_0 = "NO";
    defparam add_56_7.INJECT1_1 = "NO";
    LUT4 i4_4_lut_adj_2 (.A(count_100ms[15]), .B(count_100ms[14]), .C(count_100ms[13]), 
         .D(n6_adj_11), .Z(n701)) /* synthesis lut_function=(A (B (C (D)))) */ ;
    defparam i4_4_lut_adj_2.init = 16'h8000;
    CCU2D add_56_5 (.A0(counter[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n643), .COUT(n644), .S0(n246), .S1(n245));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_5.INIT0 = 16'h5aaa;
    defparam add_56_5.INIT1 = 16'h5aaa;
    defparam add_56_5.INJECT1_0 = "NO";
    defparam add_56_5.INJECT1_1 = "NO";
    CCU2D add_214_4 (.A0(counter[9]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[10]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n676), .COUT(n677));
    defparam add_214_4.INIT0 = 16'h5555;
    defparam add_214_4.INIT1 = 16'h5aaa;
    defparam add_214_4.INJECT1_0 = "NO";
    defparam add_214_4.INJECT1_1 = "NO";
    LUT4 i152_1_lut (.A(resetn_N_142), .Z(n552)) /* synthesis lut_function=(!(A)) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(69[5] 90[17])
    defparam i152_1_lut.init = 16'h5555;
    LUT4 count_done_100ms_I_0_87_1_lut_rep_5 (.A(count_done_100ms), .Z(clk_enable_52)) /* synthesis lut_function=(!(A)) */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(72[16:36])
    defparam count_done_100ms_I_0_87_1_lut_rep_5.init = 16'h5555;
    GSR GSR_INST (.GSR(n590));
    VLO i1 (.Z(GND_net));
    TSALL TSALL_INST (.TSALL(GND_net));
    CCU2D add_56_3 (.A0(counter[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(counter[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n642), .COUT(n643), .S0(n248), .S1(n247));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(106[32:39])
    defparam add_56_3.INIT0 = 16'h5aaa;
    defparam add_56_3.INIT1 = 16'h5aaa;
    defparam add_56_3.INJECT1_0 = "NO";
    defparam add_56_3.INJECT1_1 = "NO";
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    FD1S3IX resetn_71 (.D(n522), .CK(clk), .CD(n550), .Q(resetn_N_141));   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(71[9] 89[16])
    defparam resetn_71.GSR = "DISABLED";
    LUT4 m1_lut (.Z(n714)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    FD1P3AX reset_triggered_73 (.D(n714), .SP(resetn_N_155), .CK(clk), 
            .Q(reset_triggered)) /* synthesis lse_init_val=0 */ ;   // c:/lscc/diamond/3.13/bin/nt64/power_on_debounce.vhd(71[9] 89[16])
    defparam reset_triggered_73.GSR = "DISABLED";
    
endmodule
//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

