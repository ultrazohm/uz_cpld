// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Tue Nov 26 18:05:50 2024
//
// Verilog Description of module i2c_gpio
//

module i2c_gpio (SCL, SDA, GPO_0, IRQ, GPI_0, Enable, INTQ, RST_N, 
            MEM_CLK, MEM_WR, MEM_ADDR, MEM_WD, MEM_RD);   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(60[8:16])
    inout SCL /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(75[1:4])
    inout SDA /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(76[1:4])
    output [1:0]GPO_0;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(77[1:6])
    input [3:0]IRQ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(78[1:4])
    input [7:0]GPI_0;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(79[1:6])
    output Enable;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(80[1:7])
    output INTQ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(81[1:5])
    input RST_N;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(82[1:6])
    output MEM_CLK;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(83[1:8])
    output MEM_WR;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(84[1:7])
    output [7:0]MEM_ADDR;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(85[1:9])
    output [7:0]MEM_WD;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(86[1:7])
    input [7:0]MEM_RD;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(87[1:7])
    
    wire IRQ_c_3 /* synthesis is_clock=1, SET_AS_NETWORK=IRQ_c_3 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(78[1:4])
    wire IRQ_c_2 /* synthesis is_clock=1, SET_AS_NETWORK=IRQ_c_2 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(78[1:4])
    wire IRQ_c_1 /* synthesis is_clock=1, SET_AS_NETWORK=IRQ_c_1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(78[1:4])
    wire IRQ_c_0 /* synthesis is_clock=1, SET_AS_NETWORK=IRQ_c_0 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(78[1:4])
    wire MEM_CLK_c /* synthesis is_clock=1, SET_AS_NETWORK=MEM_CLK_c */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(83[1:8])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/ipexpress/xo2/efb_vhdl.vhd(40[12:21])
    
    wire GND_net, VCC_net, GPO_0_c_1, GPO_0_c_0, GPI_0_c_7, GPI_0_c_6, 
        GPI_0_c_5, GPI_0_c_4, GPI_0_c_3, GPI_0_c_2, GPI_0_c_1, GPI_0_c_0, 
        Enable_c, n2308, RST_N_c, MEM_WR_c, MEM_ADDR_c_7, MEM_ADDR_c_6, 
        MEM_ADDR_c_5, MEM_ADDR_c_4, MEM_ADDR_c_3, MEM_ADDR_c_2, MEM_ADDR_c_1, 
        MEM_ADDR_c_0, MEM_WD_c_7, MEM_WD_c_6, MEM_WD_c_5, MEM_WD_c_4, 
        MEM_WD_c_3, MEM_WD_c_2, MEM_WD_c_1, MEM_WD_c_0;
    wire [7:0]wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(177[8:16])
    
    wire wb_stb_i;
    wire [7:0]wb_adr_i;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(180[8:16])
    
    wire wb_we_i;
    wire [7:0]wb_dat_o;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(182[8:16])
    
    wire wb_ack_o, mem_wr1;
    wire [7:0]data0;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(194[8:13])
    wire [7:0]temp1;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(195[14:19])
    wire [7:0]temp2;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(195[20:25])
    wire [7:0]temp3;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(195[26:31])
    wire [7:0]n_temp1;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(196[16:23])
    wire [3:0]irq_en;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(197[8:14])
    wire [3:0]irq_status;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(197[17:27])
    wire [3:0]irq_clr;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(197[30:37])
    wire [3:0]irq_status_clr;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(197[39:53])
    
    wire reg_rdy, reg_rdy_del, dat_rdy, dat_rdy_del;
    wire [7:0]n_dat_count;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(204[8:19])
    wire [7:0]dat_count;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(204[22:31])
    wire [7:0]GPI_DAT;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(205[8:15])
    wire [7:0]n_wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(216[8:18])
    
    wire n3978;
    wire [7:0]n_wb_adr_i;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(218[8:18])
    
    wire n12, n_wb_we_i, check_irq_status, n3977, n3975, n15, n3552, 
        intr_read_command, n3974, reg_rdy_N_598, i2c1_sclo, dat_rdy_N_602, 
        i2c1_scloen, i2c1_sdao, i2c1_sdaoen, n15_adj_616, n3973, MEM_CLK_c_enable_36, 
        n2, n1, n248, i2c1_sdai, n256, n2184, n4008, n3984;
    wire [7:0]MEM_ADDR_7__N_429;
    
    wire Enable_N_588, n3125, n1_adj_617, n12_adj_618, n14, n3806, 
        n15_adj_619, n12_adj_620, n3668, n3514, n12_adj_621, n3166, 
        n15_adj_622, n3500, n4007, n3575, n2622, n9, n4006, n15_adj_623, 
        n12_adj_624, n3785, n15_adj_625, n18, n4, n1817, n1787, 
        n4_adj_626, n17, n12_adj_627, MEM_CLK_c_enable_23, n3644, 
        n15_adj_628, n15_adj_629, n4005, MEM_CLK_c_enable_35, MEM_CLK_c_enable_13, 
        n12_adj_630, n4003, MEM_CLK_c_enable_24, n4002, n4001, MEM_CLK_c_enable_14, 
        n24, n27, n3976, n3979, n3827, n4000, n3999, n3998, 
        n3997, n3996, n10, n4_adj_631, n3499, n3995, n3994, n3993, 
        n3992, n1724, n4_adj_632, n1706, n2548, MEM_CLK_c_enable_34, 
        n3991, n12_adj_633, n1027, n1028, n1029, n1030, n1031, 
        n1032, n1033, n1034, n3990, n3626, n3989, n2121, n14_adj_634, 
        n2075, n3498, n14_adj_635, n3988, n3987, n4110, n4_adj_636, 
        n3506, n3505;
    wire [7:0]n_dat_count_7__N_147;
    
    wire n3504, n3503, n3623;
    wire [7:0]n_state_7__N_563;
    
    wire n1666, n3849, n2641, n2364, n2366, n2153, n2152, n2151, 
        n2150, n2149, n3823, MEM_CLK_c_enable_27, n2360, n2356, 
        n2350, n_temp1_7__N_67, n_temp1_7__N_68, n_temp1_7__N_69, n_temp1_7__N_70, 
        n_temp1_7__N_71, n_temp1_7__N_72, n_temp1_7__N_73, n_temp1_7__N_74, 
        n_temp1_7__N_75, n_temp1_7__N_76, n_temp1_7__N_77, n_temp1_7__N_78, 
        n_temp1_7__N_79, n_temp1_7__N_80, n_temp1_7__N_81, n_temp1_7__N_82, 
        n_temp1_7__N_83, n_temp1_7__N_84, n_temp1_7__N_85, n3799, n3835, 
        n2338, n3501, n3802, n4_adj_637, n31, n17_adj_638, n28, 
        n3538, n2348, n2346, n2344, n2342, n2_adj_639, n3805, 
        n4012, n10_adj_640, n4011, n14_adj_641, n3986, n4014, n3843, 
        n4010, n6, n4013, n3764, n4009, n5, n3981, n3980, n3985, 
        n3825;
    
    VHI i2 (.Z(VCC_net));
    LUT4 i6_4_lut (.A(dat_count[3]), .B(dat_count[1]), .C(dat_count[5]), 
         .D(dat_count[7]), .Z(n14_adj_635)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(1217[13:35])
    defparam i6_4_lut.init = 16'hfffe;
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(MEM_CLK_c)) /* synthesis NOM_FREQ="7", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "7";
    FD1P3IX irq_clr__i0 (.D(temp2[0]), .SP(MEM_CLK_c_enable_27), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(irq_clr[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(629[1] 640[10])
    defparam irq_clr__i0.GSR = "DISABLED";
    FD1S3IX memory_addr__i1 (.D(MEM_ADDR_7__N_429[0]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(MEM_ADDR_c_0));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(527[1] 540[8])
    defparam memory_addr__i1.GSR = "DISABLED";
    BB BB1_scl (.I(i2c1_sclo), .T(i2c1_scloen), .B(SCL), .O(i2c1_scli)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=282, LSE_RLINE=282 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/ipexpress/xo2/efb_vhdl.vhd(154[14:16])
    BB BB1_sda (.I(i2c1_sdao), .T(i2c1_sdaoen), .B(SDA), .O(i2c1_sdai)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=282, LSE_RLINE=282 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/ipexpress/xo2/efb_vhdl.vhd(150[14:16])
    LUT4 i1_3_lut_4_lut (.A(n3990), .B(temp1[0]), .C(n3984), .D(intr_read_command), 
         .Z(n18)) /* synthesis lut_function=(!(A ((D)+!C)+!A (B ((D)+!C)))) */ ;
    defparam i1_3_lut_4_lut.init = 16'h11f1;
    FD1P3IX GPI_DAT__i0 (.D(GPI_0_c_0), .SP(MEM_CLK_c_enable_24), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(GPI_DAT[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(467[8] 473[15])
    defparam GPI_DAT__i0.GSR = "DISABLED";
    FD1P3IX temp2__i0 (.D(wb_dat_o[0]), .SP(reg_rdy_N_598), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(temp2[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp2__i0.GSR = "DISABLED";
    FD1P3IX temp3__i0 (.D(wb_dat_o[0]), .SP(dat_rdy_N_602), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(temp3[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp3__i0.GSR = "DISABLED";
    FD1P3IX MEM_WD__i1 (.D(temp3[0]), .SP(MEM_CLK_c_enable_13), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(MEM_WD_c_0));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(491[1] 504[8])
    defparam MEM_WD__i1.GSR = "DISABLED";
    FD1S3IX MEM_WR_379 (.D(mem_wr1), .CK(MEM_CLK_c), .CD(n4011), .Q(MEM_WR_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(509[1] 516[8])
    defparam MEM_WR_379.GSR = "DISABLED";
    LUT4 i1_4_lut (.A(wb_dat_o[0]), .B(temp1[0]), .C(n4002), .D(n3835), 
         .Z(n_temp1[0])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut.init = 16'ha0ec;
    LUT4 i898_4_lut (.A(n3995), .B(RST_N_c), .C(n2548), .D(reg_rdy_del), 
         .Z(MEM_CLK_c_enable_27)) /* synthesis lut_function=(!(A (B (C+!(D)))+!A (B))) */ ;
    defparam i898_4_lut.init = 16'h3b33;
    FD1P3IX GPO_DATA_0___i1 (.D(temp3[0]), .SP(MEM_CLK_c_enable_14), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(GPO_0_c_0));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(424[8] 432[15])
    defparam GPO_DATA_0___i1.GSR = "DISABLED";
    FD1S3IX mem_wr1_378 (.D(n3988), .CK(MEM_CLK_c), .CD(n4011), .Q(mem_wr1));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(491[1] 504[8])
    defparam mem_wr1_378.GSR = "DISABLED";
    FD1S3IX reg_rdy_366 (.D(reg_rdy_N_598), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(reg_rdy));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(309[1] 322[9])
    defparam reg_rdy_366.GSR = "DISABLED";
    CCU2D add_458_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n3503), .S1(n1034));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_458_1.INIT0 = 16'hF000;
    defparam add_458_1.INIT1 = 16'h5555;
    defparam add_458_1.INJECT1_0 = "NO";
    defparam add_458_1.INJECT1_1 = "NO";
    CCU2D add_77_9 (.A0(GND_net), .B0(n248), .C0(temp2[6]), .D0(MEM_ADDR_c_6), 
          .A1(GND_net), .B1(n248), .C1(temp2[7]), .D1(MEM_ADDR_c_7), 
          .CIN(n3501), .S0(MEM_ADDR_7__N_429[6]), .S1(MEM_ADDR_7__N_429[7]));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_arit.vhd(928[41:65])
    defparam add_77_9.INIT0 = 16'h596a;
    defparam add_77_9.INIT1 = 16'h596a;
    defparam add_77_9.INJECT1_0 = "NO";
    defparam add_77_9.INJECT1_1 = "NO";
    CCU2D add_77_7 (.A0(GND_net), .B0(n248), .C0(temp2[4]), .D0(MEM_ADDR_c_4), 
          .A1(GND_net), .B1(n248), .C1(temp2[5]), .D1(MEM_ADDR_c_5), 
          .CIN(n3500), .COUT(n3501), .S0(MEM_ADDR_7__N_429[4]), .S1(MEM_ADDR_7__N_429[5]));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_arit.vhd(928[41:65])
    defparam add_77_7.INIT0 = 16'h596a;
    defparam add_77_7.INIT1 = 16'h596a;
    defparam add_77_7.INJECT1_0 = "NO";
    defparam add_77_7.INJECT1_1 = "NO";
    LUT4 i1786_2_lut (.A(irq_en[3]), .B(temp1[0]), .Z(n2184)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(354[6] 360[15])
    defparam i1786_2_lut.init = 16'heeee;
    GSR GSR_INST (.GSR(irq_status_clr[3]));
    FD1S3IX wb_we_i_391 (.D(n_wb_we_i), .CK(MEM_CLK_c), .CD(n4011), .Q(wb_we_i));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(695[1] 711[10])
    defparam wb_we_i_391.GSR = "DISABLED";
    LUT4 mux_838_i4_3_lut (.A(GPI_DAT[3]), .B(irq_status[3]), .C(temp1[5]), 
         .Z(n2121)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(354[6] 360[15])
    defparam mux_838_i4_3_lut.init = 16'hcaca;
    FD1S3IX wb_dat_i__i0 (.D(n_wb_dat_i[0]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(wb_dat_i[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(695[1] 711[10])
    defparam wb_dat_i__i0.GSR = "DISABLED";
    FD1P3IX data0__i0 (.D(n3981), .SP(MEM_CLK_c_enable_34), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(data0[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(349[7] 362[14])
    defparam data0__i0.GSR = "DISABLED";
    FD1S3IX wb_adr_i__i1 (.D(n_wb_adr_i[0]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(wb_adr_i[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(695[1] 711[10])
    defparam wb_adr_i__i1.GSR = "DISABLED";
    LUT4 mux_283_i4_3_lut_4_lut (.A(n3989), .B(MEM_CLK_c_enable_35), .C(n1031), 
         .D(dat_count[3]), .Z(n_dat_count_7__N_147[3])) /* synthesis lut_function=(A (D)+!A (B (C)+!B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(1140[7] 1159[12])
    defparam mux_283_i4_3_lut_4_lut.init = 16'hfb40;
    FD1S3IX dat_count__i0 (.D(n_dat_count[0]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(dat_count[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(716[1] 730[10])
    defparam dat_count__i0.GSR = "DISABLED";
    FD1P3IX irq_en__i0 (.D(temp2[0]), .SP(MEM_CLK_c_enable_23), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(irq_en[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(629[1] 640[10])
    defparam irq_en__i0.GSR = "DISABLED";
    LUT4 irq_clr_3__I_0_i1_2_lut_2_lut (.A(RST_N_c), .B(irq_clr[0]), .Z(irq_status_clr[0])) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(299[10:21])
    defparam irq_clr_3__I_0_i1_2_lut_2_lut.init = 16'hdddd;
    LUT4 i2_3_lut_rep_56_4_lut (.A(n_temp1_7__N_82), .B(n4010), .C(n_temp1_7__N_68), 
         .D(n_temp1_7__N_81), .Z(n3994)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i2_3_lut_rep_56_4_lut.init = 16'hfffe;
    LUT4 i1086_3_lut_4_lut (.A(n_temp1_7__N_82), .B(n4010), .C(n2622), 
         .D(MEM_CLK_c_enable_35), .Z(n_wb_adr_i[0])) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1086_3_lut_4_lut.init = 16'h00fe;
    FD1S3IX dat_rdy_368 (.D(dat_rdy_N_602), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(dat_rdy));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(327[7] 340[11])
    defparam dat_rdy_368.GSR = "DISABLED";
    FD1S3IX dat_rdy_del_369 (.D(dat_rdy), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(dat_rdy_del));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(327[7] 340[11])
    defparam dat_rdy_del_369.GSR = "DISABLED";
    FD1P3IX MEM_WD__i8 (.D(temp3[7]), .SP(MEM_CLK_c_enable_13), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(MEM_WD_c_7));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(491[1] 504[8])
    defparam MEM_WD__i8.GSR = "DISABLED";
    LUT4 i1_4_lut_4_lut (.A(MEM_CLK_c_enable_35), .B(n_state_7__N_563[4]), 
         .C(n3785), .D(n_temp1_7__N_83), .Z(n3644)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(811[7] 831[12])
    defparam i1_4_lut_4_lut.init = 16'hfda0;
    LUT4 i1_3_lut_4_lut_adj_29 (.A(n3992), .B(MEM_CLK_c_enable_35), .C(n_temp1_7__N_77), 
         .D(n3823), .Z(n17)) /* synthesis lut_function=(!(A (B (D)+!B !(C+!(D)))+!A !(C+!(D)))) */ ;
    defparam i1_3_lut_4_lut_adj_29.init = 16'h70ff;
    LUT4 i1_4_lut_4_lut_adj_30 (.A(MEM_CLK_c_enable_35), .B(n_state_7__N_563[4]), 
         .C(n_temp1_7__N_69), .D(n_temp1_7__N_70), .Z(n2356)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(811[7] 831[12])
    defparam i1_4_lut_4_lut_adj_30.init = 16'hfda0;
    LUT4 i998_4_lut_4_lut (.A(wb_dat_o[2]), .B(MEM_CLK_c_enable_35), .C(n_temp1_7__N_76), 
         .D(n_temp1_7__N_77), .Z(n2342)) /* synthesis lut_function=(A (B (C)+!B (D))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(1009[5] 1015[15])
    defparam i998_4_lut_4_lut.init = 16'hb380;
    LUT4 i1004_4_lut_4_lut (.A(wb_dat_o[2]), .B(MEM_CLK_c_enable_35), .C(n_temp1_7__N_73), 
         .D(n_temp1_7__N_74), .Z(n2348)) /* synthesis lut_function=(A (B (C)+!B (D))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(1009[5] 1015[15])
    defparam i1004_4_lut_4_lut.init = 16'hb380;
    LUT4 i2_3_lut_4_lut (.A(n4005), .B(n3990), .C(n2641), .D(intr_read_command), 
         .Z(n3166)) /* synthesis lut_function=(!(A ((D)+!C)+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(672[34:52])
    defparam i2_3_lut_4_lut.init = 16'h00e0;
    LUT4 i77_4_lut (.A(n4001), .B(n5), .C(n3989), .D(RST_N_c), .Z(n256)) /* synthesis lut_function=(A+!((C+!(D))+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(535[12] 536[81])
    defparam i77_4_lut.init = 16'haeaa;
    FD1P3IX MEM_WD__i7 (.D(temp3[6]), .SP(MEM_CLK_c_enable_13), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(MEM_WD_c_6));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(491[1] 504[8])
    defparam MEM_WD__i7.GSR = "DISABLED";
    FD1P3IX MEM_WD__i6 (.D(temp3[5]), .SP(MEM_CLK_c_enable_13), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(MEM_WD_c_5));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(491[1] 504[8])
    defparam MEM_WD__i6.GSR = "DISABLED";
    LUT4 i1_2_lut (.A(n3552), .B(n_temp1_7__N_85), .Z(n5)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_2_lut.init = 16'h8888;
    LUT4 i1_4_lut_4_lut_adj_31 (.A(wb_dat_o[2]), .B(MEM_CLK_c_enable_35), 
         .C(n_temp1_7__N_73), .D(n_temp1_7__N_72), .Z(n2350)) /* synthesis lut_function=(A (B (D)+!B (C))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(1009[5] 1015[15])
    defparam i1_4_lut_4_lut_adj_31.init = 16'hfc70;
    LUT4 i1020_4_lut_4_lut (.A(n_temp1_7__N_81), .B(MEM_CLK_c_enable_35), 
         .C(n3623), .D(n_temp1_7__N_84), .Z(n2364)) /* synthesis lut_function=(A (B+(D))+!A (B (C (D))+!B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(535[13:74])
    defparam i1020_4_lut_4_lut.init = 16'hfb88;
    FD1P3IX MEM_WD__i5 (.D(temp3[4]), .SP(MEM_CLK_c_enable_13), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(MEM_WD_c_4));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(491[1] 504[8])
    defparam MEM_WD__i5.GSR = "DISABLED";
    LUT4 temp1_7__I_0_453_i9_2_lut_rep_65 (.A(temp1[0]), .B(temp1[1]), .Z(n4003)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(670[34:52])
    defparam temp1_7__I_0_453_i9_2_lut_rep_65.init = 16'hbbbb;
    FD1P3IX MEM_WD__i4 (.D(temp3[3]), .SP(MEM_CLK_c_enable_13), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(MEM_WD_c_3));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(491[1] 504[8])
    defparam MEM_WD__i4.GSR = "DISABLED";
    LUT4 i2_4_lut (.A(wb_dat_o[2]), .B(n4_adj_631), .C(MEM_CLK_c_enable_35), 
         .D(n3996), .Z(n3552)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i2_4_lut.init = 16'heccc;
    LUT4 i1_4_lut_adj_32 (.A(n3166), .B(n_temp1_7__N_80), .C(n3799), .D(MEM_CLK_c_enable_35), 
         .Z(n4_adj_631)) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_32.init = 16'ha0ec;
    LUT4 i2_2_lut_rep_57_3_lut_4_lut (.A(temp1[0]), .B(temp1[1]), .C(n14), 
         .D(n4008), .Z(n3995)) /* synthesis lut_function=(A+((C+(D))+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(670[34:52])
    defparam i2_2_lut_rep_57_3_lut_4_lut.init = 16'hfffb;
    LUT4 i2477_2_lut_2_lut_3_lut_4_lut (.A(temp1[0]), .B(temp1[1]), .C(n4008), 
         .D(n3998), .Z(Enable_N_588)) /* synthesis lut_function=(!(A+((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(670[34:52])
    defparam i2477_2_lut_2_lut_3_lut_4_lut.init = 16'h0004;
    LUT4 i2_3_lut_rep_55_4_lut (.A(temp1[0]), .B(temp1[1]), .C(n3998), 
         .D(n4006), .Z(n3993)) /* synthesis lut_function=(A+((C+(D))+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(670[34:52])
    defparam i2_3_lut_rep_55_4_lut.init = 16'hfffb;
    FD1P3IX MEM_WD__i3 (.D(temp3[2]), .SP(MEM_CLK_c_enable_13), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(MEM_WD_c_2));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(491[1] 504[8])
    defparam MEM_WD__i3.GSR = "DISABLED";
    FD1P3IX MEM_WD__i2 (.D(temp3[1]), .SP(MEM_CLK_c_enable_13), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(MEM_WD_c_1));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(491[1] 504[8])
    defparam MEM_WD__i2.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i1 (.D(n2366), .CK(MEM_CLK_c), .CD(n4011), .Q(n_temp1_7__N_85));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i1.GSR = "DISABLED";
    LUT4 wb_ack_o_I_0_2_lut_rep_66 (.A(wb_ack_o), .B(wb_stb_i), .Z(MEM_CLK_c_enable_35)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam wb_ack_o_I_0_2_lut_rep_66.init = 16'h8888;
    LUT4 i1_2_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(data0[1]), 
         .D(n_temp1_7__N_81), .Z(n_wb_dat_i[1])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i1_2_lut_3_lut_4_lut.init = 16'h7000;
    LUT4 i1_2_lut_3_lut_4_lut_adj_33 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[6]), 
         .D(n_temp1_7__N_81), .Z(n_wb_dat_i[6])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i1_2_lut_3_lut_4_lut_adj_33.init = 16'h7000;
    LUT4 i1_2_lut_3_lut_4_lut_adj_34 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[4]), 
         .D(n_temp1_7__N_81), .Z(n_wb_dat_i[4])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i1_2_lut_3_lut_4_lut_adj_34.init = 16'h7000;
    LUT4 i2441_4_lut_4_lut (.A(n15_adj_625), .B(n3989), .C(n_temp1_7__N_85), 
         .D(n_temp1_7__N_84), .Z(n3827)) /* synthesis lut_function=(!(A+!(B (C)+!B (C+(D))))) */ ;
    defparam i2441_4_lut_4_lut.init = 16'h5150;
    FD1P3IX temp3__i7 (.D(wb_dat_o[7]), .SP(dat_rdy_N_602), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(temp3[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp3__i7.GSR = "DISABLED";
    LUT4 select_830_Select_1_i2_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), 
         .C(n2075), .Z(n_wb_adr_i[1])) /* synthesis lut_function=(!(A (B+!(C))+!A !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam select_830_Select_1_i2_2_lut_3_lut.init = 16'h7070;
    LUT4 i1750_2_lut_rep_48_3_lut (.A(n3993), .B(n2641), .C(n15_adj_625), 
         .Z(n3986)) /* synthesis lut_function=(A (B+(C))+!A (C)) */ ;
    defparam i1750_2_lut_rep_48_3_lut.init = 16'hf8f8;
    LUT4 i966_2_lut (.A(temp1[5]), .B(temp1[6]), .Z(n2308)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;
    defparam i966_2_lut.init = 16'h6666;
    FD1P3IX temp3__i6 (.D(n_state_7__N_563[4]), .SP(dat_rdy_N_602), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(temp3[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp3__i6.GSR = "DISABLED";
    FD1P3IX temp3__i5 (.D(wb_dat_o[5]), .SP(dat_rdy_N_602), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(temp3[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp3__i5.GSR = "DISABLED";
    FD1P3IX temp3__i4 (.D(wb_dat_o[4]), .SP(dat_rdy_N_602), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(temp3[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp3__i4.GSR = "DISABLED";
    FD1P3IX temp3__i3 (.D(wb_dat_o[3]), .SP(dat_rdy_N_602), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(temp3[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp3__i3.GSR = "DISABLED";
    FD1P3IX temp3__i2 (.D(wb_dat_o[2]), .SP(dat_rdy_N_602), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(temp3[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp3__i2.GSR = "DISABLED";
    FD1S3IX temp1__i0 (.D(n_temp1[0]), .CK(MEM_CLK_c), .CD(n4011), .Q(temp1[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp1__i0.GSR = "DISABLED";
    LUT4 i43_3_lut (.A(temp1[5]), .B(temp1[6]), .C(temp1[0]), .Z(n24)) /* synthesis lut_function=(!(A ((C)+!B)+!A (B+!(C)))) */ ;
    defparam i43_3_lut.init = 16'h1818;
    LUT4 i2481_4_lut (.A(irq_status[0]), .B(irq_status[3]), .C(irq_status[2]), 
         .D(irq_status[1]), .Z(check_irq_status)) /* synthesis lut_function=(!(A+(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(572[4] 583[16])
    defparam i2481_4_lut.init = 16'h0001;
    LUT4 i1_4_lut_adj_35 (.A(n_temp1_7__N_82), .B(n_temp1_7__N_75), .C(n4_adj_637), 
         .D(n18), .Z(n3785)) /* synthesis lut_function=(A+(B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_35.init = 16'hfefa;
    LUT4 i1_4_lut_adj_36 (.A(n3992), .B(n3989), .C(n_temp1_7__N_77), .D(n3805), 
         .Z(n4_adj_637)) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_36.init = 16'hdc50;
    FD1S3AX reg_rdy_del_367 (.D(reg_rdy), .CK(MEM_CLK_c), .Q(reg_rdy_del));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(309[1] 322[9])
    defparam reg_rdy_del_367.GSR = "DISABLED";
    LUT4 i2_4_lut_adj_37 (.A(dat_count[7]), .B(n12_adj_618), .C(n17), 
         .D(n15_adj_616), .Z(n_dat_count[7])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i2_4_lut_adj_37.init = 16'hffec;
    LUT4 i1_2_lut_adj_38 (.A(wb_dat_o[2]), .B(n_temp1_7__N_84), .Z(n3805)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_2_lut_adj_38.init = 16'h8888;
    LUT4 i1_4_lut_adj_39 (.A(n_temp1_7__N_81), .B(dat_count[7]), .C(n1027), 
         .D(n3985), .Z(n12_adj_618)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_39.init = 16'ha088;
    LUT4 i599_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_state_7__N_563[4]), 
         .D(wb_dat_o[4]), .Z(n1724)) /* synthesis lut_function=(!(A (B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i599_3_lut_4_lut.init = 16'h77f7;
    LUT4 i1_4_lut_adj_40 (.A(n_temp1_7__N_80), .B(n1027), .C(dat_count[7]), 
         .D(n3125), .Z(n15_adj_616)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_40.init = 16'h88a0;
    FD1P3IX temp3__i1 (.D(wb_dat_o[1]), .SP(dat_rdy_N_602), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(temp3[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp3__i1.GSR = "DISABLED";
    FD1P3IX temp2__i7 (.D(wb_dat_o[7]), .SP(reg_rdy_N_598), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(temp2[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp2__i7.GSR = "DISABLED";
    FD1P3IX temp2__i6 (.D(n_state_7__N_563[4]), .SP(reg_rdy_N_598), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(temp2[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp2__i6.GSR = "DISABLED";
    LUT4 i812_2_lut_rep_47_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n2641), 
         .D(n3993), .Z(n3985)) /* synthesis lut_function=(!(((C (D))+!B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i812_2_lut_rep_47_3_lut_4_lut.init = 16'h0888;
    LUT4 i1_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_77), 
         .Z(reg_rdy_N_598)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i1_2_lut_3_lut.init = 16'h8080;
    LUT4 i2_3_lut_4_lut_adj_41 (.A(n3990), .B(temp1[0]), .C(n3984), .D(n3802), 
         .Z(n2)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;
    defparam i2_3_lut_4_lut_adj_41.init = 16'he000;
    LUT4 i1_4_lut_then_4_lut (.A(n14), .B(temp1[0]), .C(temp1[3]), .D(temp1[2]), 
         .Z(n4014)) /* synthesis lut_function=(!(A+(B+((D)+!C)))) */ ;
    defparam i1_4_lut_then_4_lut.init = 16'h0010;
    LUT4 i1_2_lut_4_lut (.A(n3991), .B(n3992), .C(n3989), .D(n1666), 
         .Z(n4_adj_636)) /* synthesis lut_function=(!(A (B (C+!(D))+!B !(D))+!A !(D))) */ ;
    defparam i1_2_lut_4_lut.init = 16'h7f00;
    LUT4 i2_4_lut_adj_42 (.A(dat_count[6]), .B(n12_adj_621), .C(n17), 
         .D(n15_adj_622), .Z(n_dat_count[6])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i2_4_lut_adj_42.init = 16'hffec;
    FD1P3IX temp2__i5 (.D(wb_dat_o[5]), .SP(reg_rdy_N_598), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(temp2[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp2__i5.GSR = "DISABLED";
    FD1P3IX temp2__i4 (.D(wb_dat_o[4]), .SP(reg_rdy_N_598), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(temp2[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp2__i4.GSR = "DISABLED";
    FD1P3IX temp2__i3 (.D(wb_dat_o[3]), .SP(reg_rdy_N_598), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(temp2[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp2__i3.GSR = "DISABLED";
    LUT4 i1_2_lut_3_lut_4_lut_adj_43 (.A(n3993), .B(n2641), .C(n4012), 
         .D(n15_adj_625), .Z(n3623)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A (C (D))) */ ;
    defparam i1_2_lut_3_lut_4_lut_adj_43.init = 16'hf080;
    FD1P3IX GPO_DATA_0___i2 (.D(temp3[1]), .SP(MEM_CLK_c_enable_14), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(GPO_0_c_1));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(424[8] 432[15])
    defparam GPO_DATA_0___i2.GSR = "DISABLED";
    LUT4 i1_4_lut_else_4_lut (.A(n14), .B(temp1[0]), .C(temp1[3]), .D(temp1[2]), 
         .Z(n4013)) /* synthesis lut_function=(!(A+((C+!(D))+!B))) */ ;
    defparam i1_4_lut_else_4_lut.init = 16'h0400;
    LUT4 i1_2_lut_3_lut_4_lut_adj_44 (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_78), 
         .D(wb_dat_o[2]), .Z(n3799)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i1_2_lut_3_lut_4_lut_adj_44.init = 16'h8000;
    FD1P3IX temp2__i2 (.D(wb_dat_o[2]), .SP(reg_rdy_N_598), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(temp2[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp2__i2.GSR = "DISABLED";
    LUT4 i1_4_lut_adj_45 (.A(n_temp1_7__N_81), .B(dat_count[6]), .C(n1028), 
         .D(n3985), .Z(n12_adj_621)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_45.init = 16'ha088;
    LUT4 i25_4_lut (.A(n_temp1_7__N_82), .B(n14_adj_634), .C(MEM_CLK_c_enable_35), 
         .D(n3827), .Z(n12_adj_633)) /* synthesis lut_function=(A (((D)+!C)+!B)+!A (B (C (D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i25_4_lut.init = 16'hfa3a;
    LUT4 i20_4_lut (.A(n_temp1_7__N_81), .B(n1_adj_617), .C(MEM_CLK_c_enable_35), 
         .D(n3806), .Z(n3668)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i20_4_lut.init = 16'hfaca;
    LUT4 i2456_2_lut (.A(data0[2]), .B(n_temp1_7__N_81), .Z(n3843)) /* synthesis lut_function=(A (B)) */ ;
    defparam i2456_2_lut.init = 16'h8888;
    LUT4 i1_2_lut_adj_46 (.A(wb_dat_o[4]), .B(n_temp1_7__N_79), .Z(n1_adj_617)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_2_lut_adj_46.init = 16'h8888;
    LUT4 i1_4_lut_adj_47 (.A(n_temp1_7__N_80), .B(dat_count[6]), .C(n1028), 
         .D(n3125), .Z(n15_adj_622)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_47.init = 16'ha088;
    FD1P3IX temp2__i1 (.D(wb_dat_o[1]), .SP(reg_rdy_N_598), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(temp2[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp2__i1.GSR = "DISABLED";
    LUT4 i69_2_lut_3_lut (.A(n3993), .B(n2641), .C(reg_rdy), .Z(n248)) /* synthesis lut_function=(!(A (B+!(C))+!A !(C))) */ ;
    defparam i69_2_lut_3_lut.init = 16'h7070;
    FD1P3IX GPI_DAT__i7 (.D(GPI_0_c_7), .SP(MEM_CLK_c_enable_24), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(GPI_DAT[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(467[8] 473[15])
    defparam GPI_DAT__i7.GSR = "DISABLED";
    LUT4 i2_4_lut_adj_48 (.A(dat_count[5]), .B(n12_adj_627), .C(n17), 
         .D(n15_adj_629), .Z(n_dat_count[5])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i2_4_lut_adj_48.init = 16'hffec;
    FD1P3IX GPI_DAT__i6 (.D(GPI_0_c_6), .SP(MEM_CLK_c_enable_24), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(GPI_DAT[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(467[8] 473[15])
    defparam GPI_DAT__i6.GSR = "DISABLED";
    LUT4 i2_2_lut (.A(dat_count[2]), .B(dat_count[4]), .Z(n10)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(1217[13:35])
    defparam i2_2_lut.init = 16'heeee;
    FD1S3IX wb_stb_i_389 (.D(n_wb_adr_i[6]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(wb_stb_i));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(695[1] 711[10])
    defparam wb_stb_i_389.GSR = "DISABLED";
    LUT4 i1_4_lut_adj_49 (.A(n_temp1_7__N_81), .B(dat_count[5]), .C(n1029), 
         .D(n3985), .Z(n12_adj_627)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_49.init = 16'ha088;
    FD1P3IX GPI_DAT__i5 (.D(GPI_0_c_5), .SP(MEM_CLK_c_enable_24), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(GPI_DAT[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(467[8] 473[15])
    defparam GPI_DAT__i5.GSR = "DISABLED";
    LUT4 i1_4_lut_adj_50 (.A(n_temp1_7__N_80), .B(n1029), .C(dat_count[5]), 
         .D(n3125), .Z(n15_adj_629)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_50.init = 16'h88a0;
    LUT4 i1057_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n2622), .D(n3994), 
         .Z(n_wb_adr_i[6])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i1057_3_lut_4_lut.init = 16'h7770;
    FD1P3IX GPI_DAT__i4 (.D(GPI_0_c_4), .SP(MEM_CLK_c_enable_24), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(GPI_DAT[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(467[8] 473[15])
    defparam GPI_DAT__i4.GSR = "DISABLED";
    FD1P3IX GPI_DAT__i3 (.D(GPI_0_c_3), .SP(MEM_CLK_c_enable_24), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(GPI_DAT[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(467[8] 473[15])
    defparam GPI_DAT__i3.GSR = "DISABLED";
    OB GPO_0_pad_1 (.I(GPO_0_c_1), .O(GPO_0[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(77[1:6])
    LUT4 i1745_2_lut (.A(n3552), .B(RST_N_c), .Z(n1817)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1745_2_lut.init = 16'h8888;
    LUT4 i1059_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n2622), .D(n_temp1_7__N_81), 
         .Z(n_wb_adr_i[2])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i1059_3_lut_4_lut.init = 16'h7770;
    LUT4 i2_4_lut_adj_51 (.A(dat_count[4]), .B(n12_adj_630), .C(n17), 
         .D(n15_adj_628), .Z(n_dat_count[4])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i2_4_lut_adj_51.init = 16'hffec;
    LUT4 temp1_0__bdd_2_lut_2511 (.A(temp1[0]), .B(irq_en[2]), .Z(n3976)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam temp1_0__bdd_2_lut_2511.init = 16'h4444;
    LUT4 i1_2_lut_3_lut_4_lut_adj_52 (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_67), 
         .D(n_temp1_7__N_68), .Z(n2360)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A (C+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i1_2_lut_3_lut_4_lut_adj_52.init = 16'hf7f0;
    FD1P3IX GPI_DAT__i2 (.D(GPI_0_c_2), .SP(MEM_CLK_c_enable_24), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(GPI_DAT[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(467[8] 473[15])
    defparam GPI_DAT__i2.GSR = "DISABLED";
    FD1P3IX irq_en__i3 (.D(temp2[3]), .SP(MEM_CLK_c_enable_23), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(irq_en[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(629[1] 640[10])
    defparam irq_en__i3.GSR = "DISABLED";
    LUT4 i1_4_lut_adj_53 (.A(n_temp1_7__N_81), .B(dat_count[4]), .C(n1030), 
         .D(n3985), .Z(n12_adj_630)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_53.init = 16'ha088;
    FD1P3IX irq_en__i2 (.D(temp2[2]), .SP(MEM_CLK_c_enable_23), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(irq_en[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(629[1] 640[10])
    defparam irq_en__i2.GSR = "DISABLED";
    FD1P3IX irq_en__i1 (.D(temp2[1]), .SP(MEM_CLK_c_enable_23), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(irq_en[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(629[1] 640[10])
    defparam irq_en__i1.GSR = "DISABLED";
    FD1P3DX irq_status_2__384 (.D(n4110), .SP(irq_en[2]), .CK(IRQ_c_2), 
            .CD(irq_status_clr[2]), .Q(irq_status[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(596[7] 602[23])
    defparam irq_status_2__384.GSR = "DISABLED";
    FD1P3AX irq_status_3__385 (.D(n4110), .SP(irq_en[3]), .CK(IRQ_c_3), 
            .Q(irq_status[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(596[7] 602[23])
    defparam irq_status_3__385.GSR = "ENABLED";
    FD1P3DX irq_status_1__383 (.D(n4110), .SP(irq_en[1]), .CK(IRQ_c_1), 
            .CD(irq_status_clr[1]), .Q(irq_status[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(596[7] 602[23])
    defparam irq_status_1__383.GSR = "DISABLED";
    FD1P3DX irq_status_0__382 (.D(n4110), .SP(irq_en[0]), .CK(IRQ_c_0), 
            .CD(irq_status_clr[0]), .Q(irq_status[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(596[7] 602[23])
    defparam irq_status_0__382.GSR = "DISABLED";
    FD1P3IX GPI_DAT__i1 (.D(GPI_0_c_1), .SP(MEM_CLK_c_enable_24), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(GPI_DAT[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(467[8] 473[15])
    defparam GPI_DAT__i1.GSR = "DISABLED";
    LUT4 i1_4_lut_adj_54 (.A(n_temp1_7__N_80), .B(n1030), .C(dat_count[4]), 
         .D(n3125), .Z(n15_adj_628)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_54.init = 16'h88a0;
    LUT4 temp1_0__bdd_3_lut_2508 (.A(GPI_DAT[1]), .B(irq_status[1]), .C(temp1[5]), 
         .Z(n3974)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam temp1_0__bdd_3_lut_2508.init = 16'hcaca;
    LUT4 i3_4_lut (.A(n_dat_count_7__N_147[3]), .B(n6), .C(n2_adj_639), 
         .D(n_temp1_7__N_81), .Z(n_dat_count[3])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i3_4_lut.init = 16'hfefc;
    LUT4 i1_2_lut_rep_63_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_81), 
         .Z(n4001)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i1_2_lut_rep_63_3_lut.init = 16'h8080;
    LUT4 i994_4_lut (.A(n_temp1_7__N_79), .B(n3166), .C(n1724), .D(n3799), 
         .Z(n2338)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i994_4_lut.init = 16'hb3a0;
    LUT4 temp1_0__bdd_2_lut_2507 (.A(temp1[0]), .B(irq_en[1]), .Z(n3973)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam temp1_0__bdd_2_lut_2507.init = 16'h4444;
    FD1S3IX memory_addr__i8 (.D(MEM_ADDR_7__N_429[7]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(MEM_ADDR_c_7));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(527[1] 540[8])
    defparam memory_addr__i8.GSR = "DISABLED";
    FD1S3IX memory_addr__i7 (.D(MEM_ADDR_7__N_429[6]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(MEM_ADDR_c_6));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(527[1] 540[8])
    defparam memory_addr__i7.GSR = "DISABLED";
    FD1S3IX memory_addr__i6 (.D(MEM_ADDR_7__N_429[5]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(MEM_ADDR_c_5));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(527[1] 540[8])
    defparam memory_addr__i6.GSR = "DISABLED";
    FD1S3IX memory_addr__i5 (.D(MEM_ADDR_7__N_429[4]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(MEM_ADDR_c_4));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(527[1] 540[8])
    defparam memory_addr__i5.GSR = "DISABLED";
    FD1S3IX memory_addr__i4 (.D(MEM_ADDR_7__N_429[3]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(MEM_ADDR_c_3));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(527[1] 540[8])
    defparam memory_addr__i4.GSR = "DISABLED";
    FD1S3IX memory_addr__i3 (.D(MEM_ADDR_7__N_429[2]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(MEM_ADDR_c_2));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(527[1] 540[8])
    defparam memory_addr__i3.GSR = "DISABLED";
    LUT4 i695_2_lut_rep_64_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_74), 
         .Z(n4002)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i695_2_lut_rep_64_3_lut.init = 16'h8080;
    FD1S3IX memory_addr__i2 (.D(MEM_ADDR_7__N_429[1]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(MEM_ADDR_c_1));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(527[1] 540[8])
    defparam memory_addr__i2.GSR = "DISABLED";
    FD1S3IX dat_count__i7 (.D(n_dat_count[7]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(dat_count[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(716[1] 730[10])
    defparam dat_count__i7.GSR = "DISABLED";
    LUT4 temp1_0__bdd_3_lut_2512 (.A(GPI_DAT[2]), .B(irq_status[2]), .C(temp1[5]), 
         .Z(n3977)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam temp1_0__bdd_3_lut_2512.init = 16'hcaca;
    LUT4 i1_2_lut_3_lut_4_lut_adj_55 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[5]), 
         .D(n_temp1_7__N_81), .Z(n_wb_dat_i[5])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i1_2_lut_3_lut_4_lut_adj_55.init = 16'h7000;
    LUT4 i2_4_lut_adj_56 (.A(dat_count[3]), .B(n3823), .C(n_temp1_7__N_77), 
         .D(n3987), .Z(n6)) /* synthesis lut_function=(A ((C)+!B)+!A (C (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i2_4_lut_adj_56.init = 16'hf2a2;
    LUT4 i2448_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_73), 
         .D(n_temp1_7__N_74), .Z(n3835)) /* synthesis lut_function=(A (B (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i2448_3_lut_4_lut.init = 16'h8880;
    FD1S3IX dat_count__i6 (.D(n_dat_count[6]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(dat_count[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(716[1] 730[10])
    defparam dat_count__i6.GSR = "DISABLED";
    FD1S3IX dat_count__i5 (.D(n_dat_count[5]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(dat_count[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(716[1] 730[10])
    defparam dat_count__i5.GSR = "DISABLED";
    FD1S3IX dat_count__i4 (.D(n_dat_count[4]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(dat_count[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(716[1] 730[10])
    defparam dat_count__i4.GSR = "DISABLED";
    FD1S3IX dat_count__i3 (.D(n_dat_count[3]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(dat_count[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(716[1] 730[10])
    defparam dat_count__i3.GSR = "DISABLED";
    FD1P3IX irq_clr__i3 (.D(temp2[3]), .SP(MEM_CLK_c_enable_27), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(irq_clr[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(629[1] 640[10])
    defparam irq_clr__i3.GSR = "DISABLED";
    FD1P3IX irq_clr__i2 (.D(temp2[2]), .SP(MEM_CLK_c_enable_27), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(irq_clr[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(629[1] 640[10])
    defparam irq_clr__i2.GSR = "DISABLED";
    FD1P3IX irq_clr__i1 (.D(temp2[1]), .SP(MEM_CLK_c_enable_27), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(irq_clr[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(629[1] 640[10])
    defparam irq_clr__i1.GSR = "DISABLED";
    FD1S3IX dat_count__i2 (.D(n_dat_count[2]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(dat_count[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(716[1] 730[10])
    defparam dat_count__i2.GSR = "DISABLED";
    LUT4 select_832_Select_3_i2_4_lut (.A(n1031), .B(n_temp1_7__N_80), .C(dat_count[3]), 
         .D(n3125), .Z(n2_adj_639)) /* synthesis lut_function=(A (B (C+(D)))+!A !(((D)+!C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam select_832_Select_3_i2_4_lut.init = 16'h88c0;
    LUT4 i662_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n4012), .D(n15_adj_625), 
         .Z(n1787)) /* synthesis lut_function=(((C (D))+!B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i662_3_lut_4_lut.init = 16'hf777;
    FD1S3IX dat_count__i1 (.D(n_dat_count[1]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(dat_count[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(716[1] 730[10])
    defparam dat_count__i1.GSR = "DISABLED";
    LUT4 i3_4_lut_adj_57 (.A(temp1[2]), .B(temp1[1]), .C(temp1[0]), .D(n2308), 
         .Z(n3514)) /* synthesis lut_function=(!((B+((D)+!C))+!A)) */ ;
    defparam i3_4_lut_adj_57.init = 16'h0020;
    FD1S3IX wb_adr_i__i3 (.D(n_wb_adr_i[2]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(wb_adr_i[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(695[1] 711[10])
    defparam wb_adr_i__i3.GSR = "DISABLED";
    FD1S3IX wb_adr_i__i2 (.D(n_wb_adr_i[1]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(wb_adr_i[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(695[1] 711[10])
    defparam wb_adr_i__i2.GSR = "DISABLED";
    FD1P3IX data0__i7 (.D(n2149), .SP(MEM_CLK_c_enable_34), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(data0[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(349[7] 362[14])
    defparam data0__i7.GSR = "DISABLED";
    LUT4 i1002_3_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_75), 
         .D(n_temp1_7__N_74), .Z(n2346)) /* synthesis lut_function=(A (B (D)+!B (C))+!A (C)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i1002_3_lut_3_lut_4_lut.init = 16'hf870;
    LUT4 i1_2_lut_3_lut_4_lut_adj_58 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[0]), 
         .D(n_temp1_7__N_81), .Z(n_wb_dat_i[0])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i1_2_lut_3_lut_4_lut_adj_58.init = 16'h7000;
    LUT4 i1_2_lut_3_lut_adj_59 (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_80), 
         .Z(dat_rdy_N_602)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(778[15:36])
    defparam i1_2_lut_3_lut_adj_59.init = 16'h8080;
    LUT4 temp1_7__I_0_450_i9_2_lut_rep_67 (.A(temp1[0]), .B(temp1[1]), .Z(n4005)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(391[27:47])
    defparam temp1_7__I_0_450_i9_2_lut_rep_67.init = 16'hdddd;
    FD1P3IX data0__i6 (.D(n2150), .SP(MEM_CLK_c_enable_34), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(data0[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(349[7] 362[14])
    defparam data0__i6.GSR = "DISABLED";
    FD1P3IX data0__i5 (.D(n2151), .SP(MEM_CLK_c_enable_34), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(data0[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(349[7] 362[14])
    defparam data0__i5.GSR = "DISABLED";
    FD1P3IX data0__i4 (.D(n2152), .SP(MEM_CLK_c_enable_34), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(data0[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(349[7] 362[14])
    defparam data0__i4.GSR = "DISABLED";
    FD1P3IX data0__i3 (.D(n2153), .SP(MEM_CLK_c_enable_34), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(data0[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(349[7] 362[14])
    defparam data0__i3.GSR = "DISABLED";
    FD1P3IX data0__i2 (.D(n3978), .SP(MEM_CLK_c_enable_34), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(data0[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(349[7] 362[14])
    defparam data0__i2.GSR = "DISABLED";
    LUT4 temp1_0__bdd_2_lut (.A(temp1[0]), .B(irq_en[0]), .Z(n3979)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam temp1_0__bdd_2_lut.init = 16'h4444;
    FD1P3IX data0__i1 (.D(n3975), .SP(MEM_CLK_c_enable_34), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(data0[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(349[7] 362[14])
    defparam data0__i1.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i7 (.D(n_wb_dat_i[7]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(wb_dat_i[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(695[1] 711[10])
    defparam wb_dat_i__i7.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i6 (.D(n_wb_dat_i[6]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(wb_dat_i[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(695[1] 711[10])
    defparam wb_dat_i__i6.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i5 (.D(n_wb_dat_i[5]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(wb_dat_i[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(695[1] 711[10])
    defparam wb_dat_i__i5.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i4 (.D(n_wb_dat_i[4]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(wb_dat_i[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(695[1] 711[10])
    defparam wb_dat_i__i4.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i3 (.D(n_wb_dat_i[3]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(wb_dat_i[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(695[1] 711[10])
    defparam wb_dat_i__i3.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i2 (.D(n_wb_dat_i[2]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(wb_dat_i[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(695[1] 711[10])
    defparam wb_dat_i__i2.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i1 (.D(n_wb_dat_i[1]), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(wb_dat_i[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(695[1] 711[10])
    defparam wb_dat_i__i1.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i2 (.D(n2364), .CK(MEM_CLK_c), .CD(n4011), .Q(n_temp1_7__N_84));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i2.GSR = "DISABLED";
    LUT4 i2_4_lut_adj_60 (.A(MEM_CLK_c_enable_35), .B(n4_adj_632), .C(n3992), 
         .D(n_temp1_7__N_77), .Z(n3575)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i2_4_lut_adj_60.init = 16'heccc;
    LUT4 i1_4_lut_adj_61 (.A(n1666), .B(n_temp1_7__N_78), .C(n4_adj_626), 
         .D(n1706), .Z(n4_adj_632)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_61.init = 16'heca0;
    LUT4 i1_2_lut_adj_62 (.A(intr_read_command), .B(n_temp1_7__N_75), .Z(n4_adj_626)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_2_lut_adj_62.init = 16'h8888;
    LUT4 temp1_0__bdd_3_lut (.A(GPI_DAT[0]), .B(irq_status[0]), .C(temp1[5]), 
         .Z(n3980)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam temp1_0__bdd_3_lut.init = 16'hcaca;
    LUT4 i2_3_lut_rep_46_4_lut (.A(n3993), .B(n2641), .C(n3992), .D(n3991), 
         .Z(n3984)) /* synthesis lut_function=(A (B (C (D)))) */ ;
    defparam i2_3_lut_rep_46_4_lut.init = 16'h8000;
    LUT4 i4_4_lut (.A(n3998), .B(temp1[3]), .C(temp1[2]), .D(n3825), 
         .Z(n2641)) /* synthesis lut_function=(A+((C+!(D))+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(672[58:76])
    defparam i4_4_lut.init = 16'hfbff;
    LUT4 i2439_2_lut (.A(temp1[0]), .B(temp1[1]), .Z(n3825)) /* synthesis lut_function=(A (B)) */ ;
    defparam i2439_2_lut.init = 16'h8888;
    LUT4 i2_4_lut_adj_63 (.A(dat_count[2]), .B(n12_adj_624), .C(n17), 
         .D(n15_adj_623), .Z(n_dat_count[2])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i2_4_lut_adj_63.init = 16'hffec;
    LUT4 i2_2_lut_3_lut_4_lut (.A(temp1[0]), .B(temp1[1]), .C(n14), .D(n4006), 
         .Z(n2548)) /* synthesis lut_function=((B+(C+(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(391[27:47])
    defparam i2_2_lut_3_lut_4_lut.init = 16'hfffd;
    CCU2D add_77_5 (.A0(GND_net), .B0(n248), .C0(temp2[2]), .D0(MEM_ADDR_c_2), 
          .A1(GND_net), .B1(n248), .C1(temp2[3]), .D1(MEM_ADDR_c_3), 
          .CIN(n3499), .COUT(n3500), .S0(MEM_ADDR_7__N_429[2]), .S1(MEM_ADDR_7__N_429[3]));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_arit.vhd(928[41:65])
    defparam add_77_5.INIT0 = 16'h596a;
    defparam add_77_5.INIT1 = 16'h596a;
    defparam add_77_5.INJECT1_0 = "NO";
    defparam add_77_5.INJECT1_1 = "NO";
    CCU2D add_77_3 (.A0(n256), .B0(n248), .C0(temp2[0]), .D0(MEM_ADDR_c_0), 
          .A1(GND_net), .B1(n248), .C1(temp2[1]), .D1(MEM_ADDR_c_1), 
          .CIN(n3498), .COUT(n3499), .S0(MEM_ADDR_7__N_429[0]), .S1(MEM_ADDR_7__N_429[1]));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_arit.vhd(928[41:65])
    defparam add_77_3.INIT0 = 16'hd1e2;
    defparam add_77_3.INIT1 = 16'h596a;
    defparam add_77_3.INJECT1_0 = "NO";
    defparam add_77_3.INJECT1_1 = "NO";
    LUT4 i2474_2_lut (.A(irq_clr[3]), .B(RST_N_c), .Z(irq_status_clr[3])) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(595[30:51])
    defparam i2474_2_lut.init = 16'h4444;
    LUT4 i1_4_lut_adj_64 (.A(n_temp1_7__N_81), .B(dat_count[2]), .C(n1032), 
         .D(n3985), .Z(n12_adj_624)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_64.init = 16'ha088;
    LUT4 i1_4_lut_adj_65 (.A(n_temp1_7__N_80), .B(n1032), .C(dat_count[2]), 
         .D(n3125), .Z(n15_adj_623)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_65.init = 16'h88a0;
    LUT4 i2_3_lut_rep_53_4_lut (.A(temp1[0]), .B(temp1[1]), .C(n3998), 
         .D(temp1[3]), .Z(n3991)) /* synthesis lut_function=((B+(C+(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(391[27:47])
    defparam i2_3_lut_rep_53_4_lut.init = 16'hfffd;
    CCU2D add_77_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(reg_rdy), .B1(n3989), .C1(GND_net), .D1(GND_net), .COUT(n3498));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_arit.vhd(928[41:65])
    defparam add_77_1.INIT0 = 16'hF000;
    defparam add_77_1.INIT1 = 16'hffff;
    defparam add_77_1.INJECT1_0 = "NO";
    defparam add_77_1.INJECT1_1 = "NO";
    PFUMX i2513 (.BLUT(n3980), .ALUT(n3979), .C0(temp1[1]), .Z(n3981));
    LUT4 temp1_7__I_0_454_i10_2_lut_rep_68 (.A(temp1[2]), .B(temp1[3]), 
         .Z(n4006)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(670[58:76])
    defparam temp1_7__I_0_454_i10_2_lut_rep_68.init = 16'heeee;
    LUT4 i1_4_lut_adj_66 (.A(wb_dat_o[3]), .B(temp1[3]), .C(n4002), .D(n3835), 
         .Z(n_temp1[3])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_66.init = 16'ha0ec;
    LUT4 i1_2_lut_rep_59_3_lut_4_lut (.A(temp1[2]), .B(temp1[3]), .C(temp1[1]), 
         .D(temp1[0]), .Z(n3997)) /* synthesis lut_function=(A+(B+(C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(670[58:76])
    defparam i1_2_lut_rep_59_3_lut_4_lut.init = 16'hfeff;
    LUT4 i1000_4_lut (.A(n_temp1_7__N_76), .B(n3802), .C(n1706), .D(n4_adj_636), 
         .Z(n2344)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1000_4_lut.init = 16'heca0;
    PFUMX i42 (.BLUT(n3514), .ALUT(n3538), .C0(temp1[3]), .Z(n27));
    LUT4 i2_4_lut_adj_67 (.A(dat_count[1]), .B(n12_adj_620), .C(n17), 
         .D(n15_adj_619), .Z(n_dat_count[1])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i2_4_lut_adj_67.init = 16'hffec;
    LUT4 i1_4_lut_adj_68 (.A(n_temp1_7__N_81), .B(dat_count[1]), .C(n1033), 
         .D(n3985), .Z(n12_adj_620)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_68.init = 16'ha088;
    LUT4 i1_4_lut_adj_69 (.A(n_temp1_7__N_80), .B(n1033), .C(dat_count[1]), 
         .D(n3125), .Z(n15_adj_619)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_69.init = 16'h88a0;
    LUT4 i2462_3_lut_4_lut (.A(temp1[2]), .B(temp1[3]), .C(n3998), .D(temp2[0]), 
         .Z(n3849)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(670[58:76])
    defparam i2462_3_lut_4_lut.init = 16'hfffe;
    OB GPO_0_pad_0 (.I(GPO_0_c_0), .O(GPO_0[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(77[1:6])
    OB Enable_pad (.I(Enable_c), .O(Enable));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(80[1:7])
    OBZ INTQ_pad (.I(GND_net), .T(check_irq_status), .O(INTQ));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(572[4] 583[16])
    LUT4 i541_2_lut_3_lut_4_lut (.A(n3998), .B(n4008), .C(MEM_CLK_c_enable_35), 
         .D(temp1[0]), .Z(n1666)) /* synthesis lut_function=(A (C)+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(552[9:29])
    defparam i541_2_lut_3_lut_4_lut.init = 16'hf0e0;
    OB MEM_CLK_pad (.I(MEM_CLK_c), .O(MEM_CLK));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(83[1:8])
    OB MEM_WR_pad (.I(MEM_WR_c), .O(MEM_WR));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(84[1:7])
    OB MEM_ADDR_pad_7 (.I(MEM_ADDR_c_7), .O(MEM_ADDR[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(85[1:9])
    OB MEM_ADDR_pad_6 (.I(MEM_ADDR_c_6), .O(MEM_ADDR[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(85[1:9])
    OB MEM_ADDR_pad_5 (.I(MEM_ADDR_c_5), .O(MEM_ADDR[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(85[1:9])
    OB MEM_ADDR_pad_4 (.I(MEM_ADDR_c_4), .O(MEM_ADDR[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(85[1:9])
    OB MEM_ADDR_pad_3 (.I(MEM_ADDR_c_3), .O(MEM_ADDR[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(85[1:9])
    OB MEM_ADDR_pad_2 (.I(MEM_ADDR_c_2), .O(MEM_ADDR[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(85[1:9])
    OB MEM_ADDR_pad_1 (.I(MEM_ADDR_c_1), .O(MEM_ADDR[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(85[1:9])
    OB MEM_ADDR_pad_0 (.I(MEM_ADDR_c_0), .O(MEM_ADDR[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(85[1:9])
    OB MEM_WD_pad_7 (.I(MEM_WD_c_7), .O(MEM_WD[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(86[1:7])
    OB MEM_WD_pad_6 (.I(MEM_WD_c_6), .O(MEM_WD[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(86[1:7])
    OB MEM_WD_pad_5 (.I(MEM_WD_c_5), .O(MEM_WD[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(86[1:7])
    OB MEM_WD_pad_4 (.I(MEM_WD_c_4), .O(MEM_WD[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(86[1:7])
    OB MEM_WD_pad_3 (.I(MEM_WD_c_3), .O(MEM_WD[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(86[1:7])
    OB MEM_WD_pad_2 (.I(MEM_WD_c_2), .O(MEM_WD[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(86[1:7])
    OB MEM_WD_pad_1 (.I(MEM_WD_c_1), .O(MEM_WD[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(86[1:7])
    OB MEM_WD_pad_0 (.I(MEM_WD_c_0), .O(MEM_WD[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(86[1:7])
    IB IRQ_pad_3 (.I(IRQ[3]), .O(IRQ_c_3));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(78[1:4])
    IB IRQ_pad_2 (.I(IRQ[2]), .O(IRQ_c_2));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(78[1:4])
    IB IRQ_pad_1 (.I(IRQ[1]), .O(IRQ_c_1));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(78[1:4])
    IB IRQ_pad_0 (.I(IRQ[0]), .O(IRQ_c_0));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(78[1:4])
    IB GPI_0_pad_7 (.I(GPI_0[7]), .O(GPI_0_c_7));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(79[1:6])
    IB GPI_0_pad_6 (.I(GPI_0[6]), .O(GPI_0_c_6));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(79[1:6])
    IB GPI_0_pad_5 (.I(GPI_0[5]), .O(GPI_0_c_5));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(79[1:6])
    IB GPI_0_pad_4 (.I(GPI_0[4]), .O(GPI_0_c_4));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(79[1:6])
    IB GPI_0_pad_3 (.I(GPI_0[3]), .O(GPI_0_c_3));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(79[1:6])
    IB GPI_0_pad_2 (.I(GPI_0[2]), .O(GPI_0_c_2));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(79[1:6])
    IB GPI_0_pad_1 (.I(GPI_0[1]), .O(GPI_0_c_1));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(79[1:6])
    IB GPI_0_pad_0 (.I(GPI_0[0]), .O(GPI_0_c_0));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(79[1:6])
    IB RST_N_pad (.I(RST_N), .O(RST_N_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(82[1:6])
    FD1S3IX c_state_FSM_i3 (.D(n3644), .CK(MEM_CLK_c), .CD(n4011), .Q(n_temp1_7__N_83));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i3.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i4 (.D(n12_adj_633), .CK(MEM_CLK_c), .CD(n4011), 
            .Q(n_temp1_7__N_82));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i4.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i5 (.D(n3668), .CK(MEM_CLK_c), .CD(n4011), .Q(n_temp1_7__N_81));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i5.GSR = "DISABLED";
    FD1S3AX c_state_FSM_i6 (.D(n1817), .CK(MEM_CLK_c), .Q(n_temp1_7__N_80));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i6.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i7 (.D(n2338), .CK(MEM_CLK_c), .CD(n4011), .Q(n_temp1_7__N_79));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i7.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i8 (.D(n3575), .CK(MEM_CLK_c), .CD(n4011), .Q(n_temp1_7__N_78));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i8.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i9 (.D(n2342), .CK(MEM_CLK_c), .CD(n4011), .Q(n_temp1_7__N_77));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i9.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i10 (.D(n2344), .CK(MEM_CLK_c), .CD(n4011), .Q(n_temp1_7__N_76));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i10.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i11 (.D(n2346), .CK(MEM_CLK_c), .CD(n4011), .Q(n_temp1_7__N_75));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i11.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i12 (.D(n2348), .CK(MEM_CLK_c), .CD(n4011), .Q(n_temp1_7__N_74));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i12.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i13 (.D(n2350), .CK(MEM_CLK_c), .CD(n4011), .Q(n_temp1_7__N_73));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i13.GSR = "DISABLED";
    FD1P3IX c_state_FSM_i14 (.D(n_temp1_7__N_71), .SP(MEM_CLK_c_enable_35), 
            .CD(n4011), .CK(MEM_CLK_c), .Q(n_temp1_7__N_72));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i14.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i15 (.D(n3764), .CK(MEM_CLK_c), .CD(n4011), .Q(n_temp1_7__N_71));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i15.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i16 (.D(n2356), .CK(MEM_CLK_c), .CD(n4011), .Q(n_temp1_7__N_70));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i16.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i17 (.D(n3626), .CK(MEM_CLK_c), .CD(n4011), .Q(n_temp1_7__N_69));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i17.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i18 (.D(n2360), .CK(MEM_CLK_c), .CD(n4011), .Q(n_temp1_7__N_68));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i18.GSR = "DISABLED";
    FD1S3AX c_state_FSM_i19 (.D(n4011), .CK(MEM_CLK_c), .Q(n_temp1_7__N_67));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam c_state_FSM_i19.GSR = "DISABLED";
    FD1S3IX temp1__i1 (.D(n_temp1[1]), .CK(MEM_CLK_c), .CD(n4011), .Q(temp1[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp1__i1.GSR = "DISABLED";
    PFUMX i2509 (.BLUT(n3977), .ALUT(n3976), .C0(temp1[1]), .Z(n3978));
    LUT4 i2484_2_lut_3_lut_4_lut (.A(n3998), .B(n4008), .C(RST_N_c), .D(temp1[0]), 
         .Z(MEM_CLK_c_enable_36)) /* synthesis lut_function=(!(A (C)+!A (B (C)+!B (C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(552[9:29])
    defparam i2484_2_lut_3_lut_4_lut.init = 16'h0f1f;
    LUT4 i1_2_lut_rep_69 (.A(n_temp1_7__N_80), .B(n_temp1_7__N_77), .Z(n4007)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_rep_69.init = 16'heeee;
    LUT4 i1_2_lut_3_lut_adj_70 (.A(n_temp1_7__N_80), .B(n_temp1_7__N_77), 
         .C(n_temp1_7__N_81), .Z(n3823)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i1_2_lut_3_lut_adj_70.init = 16'hfefe;
    LUT4 i11_4_lut (.A(n_temp1_7__N_71), .B(n_temp1_7__N_70), .C(MEM_CLK_c_enable_35), 
         .D(n_state_7__N_563[4]), .Z(n3764)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i11_4_lut.init = 16'h0aca;
    LUT4 temp1_7__I_0_441_i10_2_lut_rep_70 (.A(temp1[2]), .B(temp1[3]), 
         .Z(n4008)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(552[9:29])
    defparam temp1_7__I_0_441_i10_2_lut_rep_70.init = 16'hdddd;
    CCU2D add_458_9 (.A0(dat_count[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n3506), 
          .S0(n1027));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_458_9.INIT0 = 16'h5555;
    defparam add_458_9.INIT1 = 16'h0000;
    defparam add_458_9.INJECT1_0 = "NO";
    defparam add_458_9.INJECT1_1 = "NO";
    LUT4 mux_854_i8_4_lut (.A(GPI_DAT[7]), .B(temp1[0]), .C(temp1[1]), 
         .D(temp1[5]), .Z(n2149)) /* synthesis lut_function=(A (B (C+!(D))+!B !(C+(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(354[6] 360[15])
    defparam mux_854_i8_4_lut.init = 16'hc0ca;
    CCU2D add_458_7 (.A0(dat_count[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3505), .COUT(n3506), .S0(n1029), .S1(n1028));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_458_7.INIT0 = 16'h5555;
    defparam add_458_7.INIT1 = 16'h5555;
    defparam add_458_7.INJECT1_0 = "NO";
    defparam add_458_7.INJECT1_1 = "NO";
    CCU2D add_458_5 (.A0(dat_count[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3504), .COUT(n3505), .S0(n1031), .S1(n1030));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_458_5.INIT0 = 16'h5555;
    defparam add_458_5.INIT1 = 16'h5555;
    defparam add_458_5.INJECT1_0 = "NO";
    defparam add_458_5.INJECT1_1 = "NO";
    LUT4 i44_4_lut (.A(n_temp1_7__N_69), .B(n_temp1_7__N_68), .C(MEM_CLK_c_enable_35), 
         .D(n28), .Z(n3626)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(221[17:24])
    defparam i44_4_lut.init = 16'hfaca;
    CCU2D add_458_3 (.A0(dat_count[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3503), .COUT(n3504), .S0(n1033), .S1(n1032));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_458_3.INIT0 = 16'h5555;
    defparam add_458_3.INIT1 = 16'h5555;
    defparam add_458_3.INJECT1_0 = "NO";
    defparam add_458_3.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_71 (.A(n_state_7__N_563[4]), .B(n_temp1_7__N_83), 
         .C(n17_adj_638), .D(n31), .Z(n28)) /* synthesis lut_function=(!(A+!(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(221[17:24])
    defparam i1_4_lut_adj_71.init = 16'h5554;
    LUT4 i1_2_lut_adj_72 (.A(n_temp1_7__N_79), .B(wb_dat_o[4]), .Z(n17_adj_638)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(221[17:24])
    defparam i1_2_lut_adj_72.init = 16'h2222;
    LUT4 i1_4_lut_adj_73 (.A(wb_dat_o[2]), .B(n_temp1_7__N_84), .C(n4), 
         .D(n3986), .Z(n31)) /* synthesis lut_function=(!(A+!(B (C+(D))+!B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(221[17:24])
    defparam i1_4_lut_adj_73.init = 16'h5450;
    FD1S3IX temp1__i2 (.D(n_temp1[2]), .CK(MEM_CLK_c), .CD(n4011), .Q(temp1[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp1__i2.GSR = "DISABLED";
    FD1S3IX temp1__i3 (.D(n_temp1[3]), .CK(MEM_CLK_c), .CD(n4011), .Q(temp1[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp1__i3.GSR = "DISABLED";
    FD1S3IX temp1__i4 (.D(n_temp1[4]), .CK(MEM_CLK_c), .CD(n4011), .Q(temp1[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp1__i4.GSR = "DISABLED";
    FD1S3IX temp1__i5 (.D(n_temp1[5]), .CK(MEM_CLK_c), .CD(n4011), .Q(temp1[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp1__i5.GSR = "DISABLED";
    FD1S3IX temp1__i6 (.D(n_temp1[6]), .CK(MEM_CLK_c), .CD(n4011), .Q(temp1[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp1__i6.GSR = "DISABLED";
    FD1S3IX temp1__i7 (.D(n_temp1[7]), .CK(MEM_CLK_c), .CD(n4011), .Q(temp1[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(367[1] 382[11])
    defparam temp1__i7.GSR = "DISABLED";
    LUT4 i1_2_lut_rep_61_3_lut_4_lut (.A(temp1[2]), .B(temp1[3]), .C(temp1[1]), 
         .D(temp1[0]), .Z(n3999)) /* synthesis lut_function=((B+((D)+!C))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(552[9:29])
    defparam i1_2_lut_rep_61_3_lut_4_lut.init = 16'hffdf;
    FD1P3IX Enable_381 (.D(Enable_N_588), .SP(MEM_CLK_c_enable_36), .CD(n4011), 
            .CK(MEM_CLK_c), .Q(Enable_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(546[1] 559[8])
    defparam Enable_381.GSR = "DISABLED";
    LUT4 i1_2_lut_4_lut_adj_74 (.A(temp1[3]), .B(n4005), .C(n3998), .D(MEM_CLK_c_enable_35), 
         .Z(n3125)) /* synthesis lut_function=(A (D)+!A (B (D)+!B (C (D)))) */ ;
    defparam i1_2_lut_4_lut_adj_74.init = 16'hfe00;
    PFUMX i2505 (.BLUT(n3974), .ALUT(n3973), .C0(temp1[1]), .Z(n3975));
    LUT4 i1_2_lut_4_lut_adj_75 (.A(temp1[3]), .B(n4005), .C(n3998), .D(n_temp1_7__N_80), 
         .Z(n14_adj_634)) /* synthesis lut_function=(A+(B+(C+!(D)))) */ ;
    defparam i1_2_lut_4_lut_adj_75.init = 16'hfeff;
    LUT4 i1_2_lut_rep_71 (.A(temp1[4]), .B(temp1[7]), .Z(n4009)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_rep_71.init = 16'heeee;
    LUT4 i2_3_lut_rep_60_4_lut (.A(temp1[4]), .B(temp1[7]), .C(temp1[5]), 
         .D(temp1[6]), .Z(n3998)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i2_3_lut_rep_60_4_lut.init = 16'hfffe;
    LUT4 i2_3_lut_4_lut_adj_76 (.A(temp1[4]), .B(temp1[7]), .C(temp1[5]), 
         .D(temp1[6]), .Z(n14)) /* synthesis lut_function=(A+(B+!(C (D)))) */ ;
    defparam i2_3_lut_4_lut_adj_76.init = 16'hefff;
    LUT4 i1776_2_lut_3_lut (.A(temp1[5]), .B(temp1[1]), .C(GPI_DAT[6]), 
         .Z(n2150)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(354[6] 360[15])
    defparam i1776_2_lut_3_lut.init = 16'h1010;
    LUT4 i1765_2_lut_3_lut (.A(temp1[5]), .B(temp1[1]), .C(GPI_DAT[5]), 
         .Z(n2151)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(354[6] 360[15])
    defparam i1765_2_lut_3_lut.init = 16'h1010;
    LUT4 i1755_2_lut_rep_49_4_lut (.A(n14), .B(n3999), .C(n3997), .D(MEM_CLK_c_enable_35), 
         .Z(n3987)) /* synthesis lut_function=(A (D)+!A (B (C (D)))) */ ;
    defparam i1755_2_lut_rep_49_4_lut.init = 16'hea00;
    LUT4 i1764_2_lut_3_lut (.A(temp1[5]), .B(temp1[1]), .C(GPI_DAT[4]), 
         .Z(n2152)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(354[6] 360[15])
    defparam i1764_2_lut_3_lut.init = 16'h1010;
    LUT4 i1_4_lut_adj_77 (.A(wb_dat_o[1]), .B(temp1[1]), .C(n4002), .D(n3835), 
         .Z(n_temp1[1])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_77.init = 16'ha0ec;
    LUT4 dat_rdy_del_I_0_2_lut_rep_50_4_lut (.A(n4006), .B(n4003), .C(n3998), 
         .D(dat_rdy_del), .Z(n3988)) /* synthesis lut_function=(!(A+(B+(C+!(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(676[34:52])
    defparam dat_rdy_del_I_0_2_lut_rep_50_4_lut.init = 16'h0100;
    LUT4 i2452_2_lut_rep_72 (.A(n_temp1_7__N_75), .B(n_temp1_7__N_69), .Z(n4010)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2452_2_lut_rep_72.init = 16'heeee;
    LUT4 i2_2_lut_rep_62_3_lut (.A(n_temp1_7__N_75), .B(n_temp1_7__N_69), 
         .C(n_temp1_7__N_82), .Z(n4000)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i2_2_lut_rep_62_3_lut.init = 16'hfefe;
    LUT4 RST_N_I_0_1_lut_rep_73 (.A(RST_N_c), .Z(n4011)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(299[10:21])
    defparam RST_N_I_0_1_lut_rep_73.init = 16'h5555;
    LUT4 i896_3_lut_4_lut_4_lut (.A(RST_N_c), .B(reg_rdy_del), .C(n3999), 
         .D(n14), .Z(MEM_CLK_c_enable_23)) /* synthesis lut_function=(!(A ((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(299[10:21])
    defparam i896_3_lut_4_lut_4_lut.init = 16'h555d;
    LUT4 i888_2_lut_3_lut_3_lut (.A(RST_N_c), .B(n3993), .C(dat_rdy_del), 
         .Z(MEM_CLK_c_enable_13)) /* synthesis lut_function=(!(A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(299[10:21])
    defparam i888_2_lut_3_lut_3_lut.init = 16'h7575;
    LUT4 i2_3_lut_4_lut_adj_78 (.A(n3993), .B(n2641), .C(n15_adj_625), 
         .D(n3805), .Z(n3806)) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;
    defparam i2_3_lut_4_lut_adj_78.init = 16'h7000;
    LUT4 i886_4_lut_4_lut (.A(RST_N_c), .B(dat_rdy_del), .C(n4005), .D(n3849), 
         .Z(MEM_CLK_c_enable_14)) /* synthesis lut_function=(!(A ((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(299[10:21])
    defparam i886_4_lut_4_lut.init = 16'h555d;
    LUT4 i887_3_lut_4_lut_4_lut (.A(RST_N_c), .B(reg_rdy), .C(n3990), 
         .D(n4005), .Z(MEM_CLK_c_enable_24)) /* synthesis lut_function=(!(A ((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(299[10:21])
    defparam i887_3_lut_4_lut_4_lut.init = 16'h555d;
    LUT4 i1742_2_lut_rep_51_4_lut (.A(n4006), .B(n4003), .C(n3998), .D(n2641), 
         .Z(n3989)) /* synthesis lut_function=(A (D)+!A (B (D)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(676[34:52])
    defparam i1742_2_lut_rep_51_4_lut.init = 16'hfe00;
    LUT4 irq_clr_3__I_0_i2_2_lut_2_lut (.A(RST_N_c), .B(irq_clr[1]), .Z(irq_status_clr[1])) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(299[10:21])
    defparam irq_clr_3__I_0_i2_2_lut_2_lut.init = 16'hdddd;
    LUT4 irq_clr_3__I_0_i3_2_lut_2_lut (.A(RST_N_c), .B(irq_clr[2]), .Z(irq_status_clr[2])) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(299[10:21])
    defparam irq_clr_3__I_0_i3_2_lut_2_lut.init = 16'hdddd;
    LUT4 i885_4_lut_4_lut (.A(RST_N_c), .B(n27), .C(temp1[4]), .D(temp1[7]), 
         .Z(MEM_CLK_c_enable_34)) /* synthesis lut_function=(!(A ((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(299[10:21])
    defparam i885_4_lut_4_lut.init = 16'h555d;
    LUT4 i1_4_lut_adj_79 (.A(wb_dat_o[4]), .B(temp1[4]), .C(n4002), .D(n3835), 
         .Z(n_temp1[4])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_79.init = 16'ha0ec;
    LUT4 i2_3_lut_3_lut (.A(temp1[2]), .B(n24), .C(temp1[1]), .Z(n3538)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;
    defparam i2_3_lut_3_lut.init = 16'h4040;
    LUT4 i1_4_lut_adj_80 (.A(wb_dat_o[5]), .B(temp1[5]), .C(n4002), .D(n3835), 
         .Z(n_temp1[5])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_80.init = 16'ha0ec;
    LUT4 i1087_2_lut_4_lut (.A(n4000), .B(n_temp1_7__N_81), .C(n_temp1_7__N_68), 
         .D(MEM_CLK_c_enable_35), .Z(n_wb_we_i)) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1087_2_lut_4_lut.init = 16'h00fe;
    LUT4 i1_4_lut_adj_81 (.A(wb_dat_o[2]), .B(temp1[2]), .C(n4002), .D(n3835), 
         .Z(n_temp1[2])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_81.init = 16'ha0ec;
    LUT4 i1_4_lut_adj_82 (.A(n_state_7__N_563[4]), .B(temp1[6]), .C(n4002), 
         .D(n3835), .Z(n_temp1[6])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_82.init = 16'ha0ec;
    LUT4 i1_4_lut_adj_83 (.A(wb_dat_o[7]), .B(temp1[7]), .C(n4002), .D(n3835), 
         .Z(n_temp1[7])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_83.init = 16'ha0ec;
    LUT4 i1_2_lut_rep_58 (.A(n15_adj_625), .B(n_temp1_7__N_85), .Z(n3996)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(1250[5] 1258[15])
    defparam i1_2_lut_rep_58.init = 16'h8888;
    LUT4 i1_4_lut_adj_84 (.A(n2075), .B(n9), .C(n14_adj_641), .D(n10_adj_640), 
         .Z(n2622)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_84.init = 16'hfffe;
    LUT4 i1_2_lut_adj_85 (.A(n_temp1_7__N_73), .B(n_temp1_7__N_84), .Z(n9)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_2_lut_adj_85.init = 16'heeee;
    LUT4 i2486_4_lut (.A(MEM_CLK_c_enable_35), .B(n_temp1_7__N_82), .C(n3843), 
         .D(n4010), .Z(n_wb_dat_i[2])) /* synthesis lut_function=(!(A+!(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i2486_4_lut.init = 16'h5554;
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    LUT4 i6_4_lut_adj_86 (.A(n_temp1_7__N_70), .B(n_temp1_7__N_83), .C(n_temp1_7__N_79), 
         .D(n_temp1_7__N_78), .Z(n14_adj_641)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i6_4_lut_adj_86.init = 16'hfffe;
    LUT4 i2_2_lut_adj_87 (.A(n_temp1_7__N_76), .B(n_temp1_7__N_85), .Z(n10_adj_640)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i2_2_lut_adj_87.init = 16'heeee;
    VLO i1 (.Z(GND_net));
    LUT4 i3_4_lut_adj_88 (.A(n_temp1_7__N_71), .B(n_temp1_7__N_74), .C(n_temp1_7__N_72), 
         .D(n4007), .Z(n2075)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i3_4_lut_adj_88.init = 16'hfffe;
    LUT4 m1_lut (.Z(n4110)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    PFUMX mux_854_i4 (.BLUT(n2121), .ALUT(n2184), .C0(temp1[1]), .Z(n2153));
    LUT4 i2_4_lut_adj_89 (.A(dat_count[0]), .B(n12), .C(n17), .D(n15), 
         .Z(n_dat_count[0])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i2_4_lut_adj_89.init = 16'hffec;
    efb_vhdl dut (.MEM_CLK_c(MEM_CLK_c), .n4011(n4011), .wb_stb_i(wb_stb_i), 
            .wb_we_i(wb_we_i), .GND_net(GND_net), .\wb_adr_i[2] (wb_adr_i[2]), 
            .\wb_adr_i[1] (wb_adr_i[1]), .\wb_adr_i[0] (wb_adr_i[0]), .wb_dat_i({wb_dat_i}), 
            .\wb_dat_o[7] (wb_dat_o[7]), .\n_state_7__N_563[4] (n_state_7__N_563[4]), 
            .\wb_dat_o[5] (wb_dat_o[5]), .\wb_dat_o[4] (wb_dat_o[4]), .\wb_dat_o[3] (wb_dat_o[3]), 
            .\wb_dat_o[2] (wb_dat_o[2]), .\wb_dat_o[1] (wb_dat_o[1]), .\wb_dat_o[0] (wb_dat_o[0]), 
            .wb_ack_o(wb_ack_o), .i2c1_sdaoen(i2c1_sdaoen), .i2c1_sdao(i2c1_sdao), 
            .i2c1_scloen(i2c1_scloen), .i2c1_sclo(i2c1_sclo), .i2c1_sdai(i2c1_sdai), 
            .i2c1_scli(i2c1_scli), .VCC_net(VCC_net), .n4012(n4012), .n1706(n1706)) /* synthesis NGD_DRC_MASK=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(282[7:15])
    LUT4 i1_3_lut_4_lut_adj_90 (.A(n15_adj_625), .B(n_temp1_7__N_85), .C(n_temp1_7__N_78), 
         .D(n_temp1_7__N_76), .Z(n4)) /* synthesis lut_function=(A (B+(C+(D)))+!A (C+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(1250[5] 1258[15])
    defparam i1_3_lut_4_lut_adj_90.init = 16'hfff8;
    LUT4 i1_4_lut_adj_91 (.A(n_temp1_7__N_81), .B(dat_count[0]), .C(n1034), 
         .D(n3985), .Z(n12)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_91.init = 16'ha088;
    LUT4 i2445_3_lut_rep_54_4_lut (.A(n4006), .B(n4005), .C(n3999), .D(n14), 
         .Z(n3992)) /* synthesis lut_function=(A (C+(D))+!A (B (C+(D))+!B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(391[27:47])
    defparam i2445_3_lut_rep_54_4_lut.init = 16'hffe0;
    LUT4 i1_4_lut_adj_92 (.A(n_temp1_7__N_80), .B(dat_count[0]), .C(n1034), 
         .D(n3125), .Z(n15)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_92.init = 16'ha088;
    LUT4 i1_4_lut_adj_93 (.A(MEM_CLK_c_enable_35), .B(n_temp1_7__N_82), 
         .C(n1), .D(n2), .Z(n_wb_dat_i[3])) /* synthesis lut_function=(!(A+!(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_4_lut_adj_93.init = 16'h5554;
    LUT4 i1_2_lut_adj_94 (.A(data0[3]), .B(n_temp1_7__N_81), .Z(n1)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_2_lut_adj_94.init = 16'h8888;
    TSALL TSALL_INST (.TSALL(GND_net));
    LUT4 i1_2_lut_adj_95 (.A(n_temp1_7__N_75), .B(intr_read_command), .Z(n3802)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_2_lut_adj_95.init = 16'h2222;
    LUT4 i1_2_lut_rep_52_4_lut (.A(n4009), .B(temp1[6]), .C(temp1[5]), 
         .D(n4008), .Z(n3990)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(552[9:29])
    defparam i1_2_lut_rep_52_4_lut.init = 16'hfffe;
    LUT4 i1_3_lut_4_lut_4_lut (.A(MEM_CLK_c_enable_35), .B(n_temp1_7__N_81), 
         .C(data0[7]), .D(n_temp1_7__N_68), .Z(n_wb_dat_i[7])) /* synthesis lut_function=(!(A+!(B (C+(D))+!B (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1_3_lut_4_lut_4_lut.init = 16'h5540;
    LUT4 i1022_4_lut (.A(n_temp1_7__N_85), .B(n_temp1_7__N_80), .C(n1787), 
         .D(n3125), .Z(n2366)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(756[6] 1273[10])
    defparam i1022_4_lut.init = 16'heca0;
    PFUMX i2515 (.BLUT(n4013), .ALUT(n4014), .C0(temp1[1]), .Z(intr_read_command));
    LUT4 i7_4_lut (.A(dat_count[0]), .B(n14_adj_635), .C(n10), .D(dat_count[6]), 
         .Z(n15_adj_625)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(1217[13:35])
    defparam i7_4_lut.init = 16'hfffe;
    
endmodule
//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

//
// Verilog Description of module efb_vhdl
//

module efb_vhdl (MEM_CLK_c, n4011, wb_stb_i, wb_we_i, GND_net, \wb_adr_i[2] , 
            \wb_adr_i[1] , \wb_adr_i[0] , wb_dat_i, \wb_dat_o[7] , \n_state_7__N_563[4] , 
            \wb_dat_o[5] , \wb_dat_o[4] , \wb_dat_o[3] , \wb_dat_o[2] , 
            \wb_dat_o[1] , \wb_dat_o[0] , wb_ack_o, i2c1_sdaoen, i2c1_sdao, 
            i2c1_scloen, i2c1_sclo, i2c1_sdai, i2c1_scli, VCC_net, 
            n4012, n1706) /* synthesis NGD_DRC_MASK=1 */ ;
    input MEM_CLK_c;
    input n4011;
    input wb_stb_i;
    input wb_we_i;
    input GND_net;
    input \wb_adr_i[2] ;
    input \wb_adr_i[1] ;
    input \wb_adr_i[0] ;
    input [7:0]wb_dat_i;
    output \wb_dat_o[7] ;
    output \n_state_7__N_563[4] ;
    output \wb_dat_o[5] ;
    output \wb_dat_o[4] ;
    output \wb_dat_o[3] ;
    output \wb_dat_o[2] ;
    output \wb_dat_o[1] ;
    output \wb_dat_o[0] ;
    output wb_ack_o;
    output i2c1_sdaoen;
    output i2c1_sdao;
    output i2c1_scloen;
    output i2c1_sclo;
    input i2c1_sdai;
    input i2c1_scli;
    input VCC_net;
    output n4012;
    output n1706;
    
    wire MEM_CLK_c /* synthesis is_clock=1, SET_AS_NETWORK=MEM_CLK_c */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(83[1:8])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/ipexpress/xo2/efb_vhdl.vhd(40[12:21])
    
    EFB EFBInst_0 (.WBCLKI(MEM_CLK_c), .WBRSTI(n4011), .WBCYCI(wb_stb_i), 
        .WBSTBI(wb_stb_i), .WBWEI(wb_we_i), .WBADRI0(\wb_adr_i[0] ), .WBADRI1(\wb_adr_i[1] ), 
        .WBADRI2(\wb_adr_i[2] ), .WBADRI3(GND_net), .WBADRI4(GND_net), 
        .WBADRI5(GND_net), .WBADRI6(wb_stb_i), .WBADRI7(GND_net), .WBDATI0(wb_dat_i[0]), 
        .WBDATI1(wb_dat_i[1]), .WBDATI2(wb_dat_i[2]), .WBDATI3(wb_dat_i[3]), 
        .WBDATI4(wb_dat_i[4]), .WBDATI5(wb_dat_i[5]), .WBDATI6(wb_dat_i[6]), 
        .WBDATI7(wb_dat_i[7]), .I2C1SCLI(i2c1_scli), .I2C1SDAI(i2c1_sdai), 
        .I2C2SCLI(GND_net), .I2C2SDAI(GND_net), .SPISCKI(GND_net), .SPIMISOI(GND_net), 
        .SPIMOSII(GND_net), .SPISCSN(GND_net), .TCCLKI(GND_net), .TCRSTN(GND_net), 
        .TCIC(GND_net), .UFMSN(VCC_net), .PLL0DATI0(GND_net), .PLL0DATI1(GND_net), 
        .PLL0DATI2(GND_net), .PLL0DATI3(GND_net), .PLL0DATI4(GND_net), 
        .PLL0DATI5(GND_net), .PLL0DATI6(GND_net), .PLL0DATI7(GND_net), 
        .PLL0ACKI(GND_net), .PLL1DATI0(GND_net), .PLL1DATI1(GND_net), 
        .PLL1DATI2(GND_net), .PLL1DATI3(GND_net), .PLL1DATI4(GND_net), 
        .PLL1DATI5(GND_net), .PLL1DATI6(GND_net), .PLL1DATI7(GND_net), 
        .PLL1ACKI(GND_net), .WBDATO0(\wb_dat_o[0] ), .WBDATO1(\wb_dat_o[1] ), 
        .WBDATO2(\wb_dat_o[2] ), .WBDATO3(\wb_dat_o[3] ), .WBDATO4(\wb_dat_o[4] ), 
        .WBDATO5(\wb_dat_o[5] ), .WBDATO6(\n_state_7__N_563[4] ), .WBDATO7(\wb_dat_o[7] ), 
        .WBACKO(wb_ack_o), .I2C1SCLO(i2c1_sclo), .I2C1SCLOEN(i2c1_scloen), 
        .I2C1SDAO(i2c1_sdao), .I2C1SDAOEN(i2c1_sdaoen)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=282, LSE_RLINE=282 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(282[7:15])
    defparam EFBInst_0.EFB_I2C1 = "ENABLED";
    defparam EFBInst_0.EFB_I2C2 = "DISABLED";
    defparam EFBInst_0.EFB_SPI = "DISABLED";
    defparam EFBInst_0.EFB_TC = "DISABLED";
    defparam EFBInst_0.EFB_TC_PORTMODE = "WB";
    defparam EFBInst_0.EFB_UFM = "DISABLED";
    defparam EFBInst_0.EFB_WB_CLK_FREQ = "10.0";
    defparam EFBInst_0.DEV_DENSITY = "1200L";
    defparam EFBInst_0.UFM_INIT_PAGES = 0;
    defparam EFBInst_0.UFM_INIT_START_PAGE = 0;
    defparam EFBInst_0.UFM_INIT_ALL_ZEROS = "ENABLED";
    defparam EFBInst_0.UFM_INIT_FILE_NAME = "NONE";
    defparam EFBInst_0.UFM_INIT_FILE_FORMAT = "HEX";
    defparam EFBInst_0.I2C1_ADDRESSING = "7BIT";
    defparam EFBInst_0.I2C2_ADDRESSING = "7BIT";
    defparam EFBInst_0.I2C1_SLAVE_ADDR = "0b0001001";
    defparam EFBInst_0.I2C2_SLAVE_ADDR = "0b0001001";
    defparam EFBInst_0.I2C1_BUS_PERF = "100kHz";
    defparam EFBInst_0.I2C2_BUS_PERF = "100kHz";
    defparam EFBInst_0.I2C1_CLK_DIVIDER = 25;
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
    LUT4 i1_2_lut_rep_74 (.A(\n_state_7__N_563[4] ), .B(\wb_dat_o[2] ), 
         .Z(n4012)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(282[7:15])
    defparam i1_2_lut_rep_74.init = 16'h2222;
    LUT4 i581_2_lut_3_lut_4_lut (.A(\n_state_7__N_563[4] ), .B(\wb_dat_o[2] ), 
         .C(wb_stb_i), .D(wb_ack_o), .Z(n1706)) /* synthesis lut_function=(!(A (B (C (D)))+!A (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(282[7:15])
    defparam i581_2_lut_3_lut_4_lut.init = 16'h2fff;
    
endmodule
//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

