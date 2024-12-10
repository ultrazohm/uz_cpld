// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Tue Dec 10 17:28:59 2024
//
// Verilog Description of module i2c_gpio
//

module i2c_gpio (SCL, SDA, GPO_0, IRQ, GPI_0, Enable, INTQ, RST_N);   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(60[8:16])
    inout SCL /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(75[1:4])
    inout SDA /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(76[1:4])
    output [7:0]GPO_0;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(77[1:6])
    input [3:0]IRQ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(78[1:4])
    input [7:0]GPI_0;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(79[1:6])
    output Enable;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(80[1:7])
    output INTQ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(81[1:5])
    input RST_N;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(82[1:6])
    
    wire IRQ_c_3 /* synthesis is_clock=1, SET_AS_NETWORK=IRQ_c_3 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(78[1:4])
    wire IRQ_c_2 /* synthesis is_clock=1, SET_AS_NETWORK=IRQ_c_2 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(78[1:4])
    wire IRQ_c_1 /* synthesis is_clock=1, SET_AS_NETWORK=IRQ_c_1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(78[1:4])
    wire IRQ_c_0 /* synthesis is_clock=1, SET_AS_NETWORK=IRQ_c_0 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(78[1:4])
    wire clk /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(88[8:11])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/ipexpress/xo2/efb_vhdl.vhd(40[12:21])
    
    wire GND_net, VCC_net, GPO_0_c_7, GPO_0_c_6, GPO_0_c_5, GPO_0_c_4, 
        GPO_0_c_3, GPO_0_c_2, GPO_0_c_1, GPO_0_c_0, GPI_0_c_7, GPI_0_c_6, 
        GPI_0_c_5, GPI_0_c_4, GPI_0_c_3, GPI_0_c_2, GPI_0_c_1, GPI_0_c_0, 
        RST_N_c;
    wire [7:0]wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(172[8:16])
    
    wire wb_stb_i;
    wire [7:0]wb_adr_i;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(175[8:16])
    
    wire wb_we_i;
    wire [7:0]wb_dat_o;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(177[8:16])
    
    wire wb_ack_o;
    wire [7:0]data0;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(189[8:13])
    wire [7:0]temp1;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(190[14:19])
    
    wire n2238, n2234, n2232;
    wire [7:0]temp2;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(190[20:25])
    wire [7:0]temp3;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(190[26:31])
    wire [7:0]n_temp1;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(191[16:23])
    
    wire n2228, n2226, n2224, n3914;
    wire [3:0]irq_en;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(192[8:14])
    wire [3:0]irq_status;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(192[17:27])
    wire [3:0]irq_clr;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(192[30:37])
    wire [3:0]irq_status_clr;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(192[39:53])
    
    wire reg_rdy, reg_rdy_del, dat_rdy, dat_rdy_del;
    wire [7:0]n_dat_count;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(199[8:19])
    wire [7:0]dat_count;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(199[22:31])
    wire [7:0]GPI_DAT;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(200[8:15])
    wire [7:0]n_wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(211[8:18])
    
    wire n_wb_stb_i;
    wire [7:0]n_wb_adr_i;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(213[8:18])
    
    wire n_wb_we_i, check_irq_status, RST_N_N_584, enable_command, reg_rdy_N_570, 
        dat_rdy_N_576, dat_rdy_N_574, i2c1_scloen, i2c1_sdao, i2c1_sdaoen, 
        n3998, clk_enable_32, n11, n3186, n3144, n15, n12, n4514, 
        n14, n3942, clk_enable_11, clk_enable_19, n4187, n3140, 
        n2562, n2222, n2220, n2561, n11_adj_591, n4316, n15_adj_592, 
        n2557, n2556, n2552, n2551, n69, n2547, n2542, n1695, 
        n2541, n14_adj_593, n11_adj_594, n1690, n4315, n4186, n1671, 
        n1674, n1663, n2214, n14_adj_595, n4, n2529, clk_enable_31, 
        n48, n2531, n21, n24, n27, n4314, n3916, n14_adj_596, 
        clk_enable_16, n4163, n4_adj_597, n2285, n4221, n2518, n1632, 
        n4312, n4084, n3975, n3913, n1614, n1618, n37, n17, 
        n950, n951, n952, n953, n954, n955, n956, n957;
    wire [7:0]n_state_7__N_519;
    
    wire n1938, n1940, n51, n1, n2500;
    wire [7:0]n_state_7__N_353;
    
    wire n2523, n3175;
    wire [7:0]n_state_7__N_543;
    
    wire n4524, n2246, n2248, n3980, n1891, n4182, n5, n2032, 
        n_temp1_7__N_57, n_temp1_7__N_58, n_temp1_7__N_59, n_temp1_7__N_60, 
        n_temp1_7__N_61, n_temp1_7__N_62, n_temp1_7__N_63, n_temp1_7__N_64, 
        n_temp1_7__N_65, n_temp1_7__N_66, n_temp1_7__N_67, n_temp1_7__N_68, 
        n_temp1_7__N_69, i2c1_sclo, n_temp1_7__N_71, n_temp1_7__N_72, 
        n_temp1_7__N_73, n_temp1_7__N_74, n_temp1_7__N_75, i2c1_sdai, 
        n4175, n2215, n4233, n3, n2497, n3976, n3_adj_598, n1_adj_599, 
        n1_adj_600, n2, n11_adj_601, n4196, n4485, n2522, n4225, 
        n3915, n2178, clk_enable_22, n3981, n4184, n6, n4475, 
        n4232, n4223, n10, n13, n4407, n4317, n4240, n4239, 
        n4238, n4258, n4237;
    
    VHI i2 (.Z(VCC_net));
    LUT4 i1_2_lut (.A(wb_dat_o[2]), .B(n4182), .Z(n2497)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut.init = 16'h8888;
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk)) /* synthesis NOM_FREQ="7", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "7";
    LUT4 i539_3_lut (.A(n_state_7__N_353[4]), .B(wb_dat_o[2]), .C(n_state_7__N_543[4]), 
         .Z(n1614)) /* synthesis lut_function=(!(A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(968[8] 979[15])
    defparam i539_3_lut.init = 16'h7575;
    IFS1P3IX GPI_DAT__i0 (.D(GPI_0_c_0), .SP(clk_enable_31), .SCLK(clk), 
            .CD(RST_N_N_584), .Q(GPI_DAT[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(453[8] 459[15])
    defparam GPI_DAT__i0.GSR = "DISABLED";
    FD1S3IX dat_rdy_332 (.D(dat_rdy_N_574), .CK(clk), .CD(RST_N_N_584), 
            .Q(dat_rdy));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(322[7] 335[11])
    defparam dat_rdy_332.GSR = "DISABLED";
    FD1S3IX wb_stb_i_348 (.D(n_wb_stb_i), .CK(clk), .CD(RST_N_N_584), 
            .Q(wb_stb_i));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_stb_i_348.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i5 (.D(temp3[4]), .SP(clk_enable_16), .CD(RST_N_N_584), 
            .CK(clk), .Q(GPO_0_c_4));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(410[8] 418[15])
    defparam GPO_DATA_0___i5.GSR = "DISABLED";
    LUT4 i1_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_64), 
         .Z(n4187)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(807[12:33])
    defparam i1_2_lut_3_lut.init = 16'h8080;
    FD1P3IX temp2__i0 (.D(wb_dat_o[0]), .SP(reg_rdy_N_570), .CD(RST_N_N_584), 
            .CK(clk), .Q(temp2[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp2__i0.GSR = "DISABLED";
    LUT4 i557_3_lut (.A(n_state_7__N_353[4]), .B(wb_dat_o[4]), .C(n_state_7__N_543[4]), 
         .Z(n1632)) /* synthesis lut_function=(!(A (B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(999[8] 1005[15])
    defparam i557_3_lut.init = 16'h7575;
    FD1S3IX wb_we_i_350 (.D(n_wb_we_i), .CK(clk), .CD(RST_N_N_584), .Q(wb_we_i));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_we_i_350.GSR = "DISABLED";
    FD1P3IX temp3__i0 (.D(wb_dat_o[0]), .SP(dat_rdy_N_574), .CD(RST_N_N_584), 
            .CK(clk), .Q(temp3[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp3__i0.GSR = "DISABLED";
    FD1P3IX irq_clr__i0 (.D(temp2[0]), .SP(clk_enable_11), .CD(RST_N_N_584), 
            .CK(clk), .Q(irq_clr[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(534[1] 545[10])
    defparam irq_clr__i0.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i1 (.D(temp3[0]), .SP(clk_enable_16), .CD(RST_N_N_584), 
            .CK(clk), .Q(GPO_0_c_0));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(410[8] 418[15])
    defparam GPO_DATA_0___i1.GSR = "DISABLED";
    FD1S3IX reg_rdy_330 (.D(reg_rdy_N_570), .CK(clk), .CD(RST_N_N_584), 
            .Q(reg_rdy));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(304[1] 317[9])
    defparam reg_rdy_330.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i0 (.D(n_wb_dat_i[0]), .CK(clk), .CD(RST_N_N_584), 
            .Q(wb_dat_i[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_dat_i__i0.GSR = "DISABLED";
    LUT4 i1_3_lut_4_lut (.A(n_temp1_7__N_75), .B(n1690), .C(n4182), .D(wb_dat_o[2]), 
         .Z(n17)) /* synthesis lut_function=(!(A (B (D)+!B ((D)+!C))+!A ((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_3_lut_4_lut.init = 16'h00f8;
    LUT4 i1_2_lut_3_lut_4_lut (.A(enable_command), .B(wb_ack_o), .C(wb_stb_i), 
         .D(n3140), .Z(n69)) /* synthesis lut_function=(!(A+!(B (C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(886[5] 894[15])
    defparam i1_2_lut_3_lut_4_lut.init = 16'h4000;
    LUT4 i1017_3_lut_4_lut (.A(n_temp1_7__N_71), .B(n2529), .C(n2518), 
         .D(n_state_7__N_353[4]), .Z(n_wb_adr_i[6])) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1017_3_lut_4_lut.init = 16'h00fe;
    LUT4 i1878_3_lut (.A(n14_adj_595), .B(n11_adj_594), .C(n11_adj_591), 
         .Z(n1)) /* synthesis lut_function=(A+(B (C))) */ ;
    defparam i1878_3_lut.init = 16'heaea;
    FD1S3IX wb_adr_i__i1 (.D(n_wb_adr_i[0]), .CK(clk), .CD(RST_N_N_584), 
            .Q(wb_adr_i[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_adr_i__i1.GSR = "DISABLED";
    FD1S3IX dat_count__i0 (.D(n_dat_count[0]), .CK(clk), .CD(RST_N_N_584), 
            .Q(dat_count[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(621[1] 635[10])
    defparam dat_count__i0.GSR = "DISABLED";
    FD1P3IX irq_en__i0 (.D(temp2[0]), .SP(clk_enable_19), .CD(RST_N_N_584), 
            .CK(clk), .Q(irq_en[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(534[1] 545[10])
    defparam irq_en__i0.GSR = "DISABLED";
    BB BB1_scl (.I(i2c1_sclo), .T(i2c1_scloen), .B(SCL), .O(i2c1_scli)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=277, LSE_RLINE=277 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/ipexpress/xo2/efb_vhdl.vhd(154[14:16])
    LUT4 irq_clr_3__I_0_i2_2_lut_2_lut (.A(irq_clr[1]), .B(RST_N_c), .Z(irq_status_clr[1])) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(500[30:51])
    defparam irq_clr_3__I_0_i2_2_lut_2_lut.init = 16'hbbbb;
    BB BB1_sda (.I(i2c1_sdao), .T(i2c1_sdaoen), .B(SDA), .O(i2c1_sdai)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=277, LSE_RLINE=277 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/ipexpress/xo2/efb_vhdl.vhd(150[14:16])
    LUT4 i1_2_lut_adj_28 (.A(dat_rdy_N_576), .B(n_temp1_7__N_67), .Z(n2522)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_adj_28.init = 16'heeee;
    LUT4 i941_4_lut_4_lut (.A(n_temp1_7__N_64), .B(n_state_7__N_353[4]), 
         .C(wb_dat_o[2]), .D(n_temp1_7__N_63), .Z(n2226)) /* synthesis lut_function=(A ((C (D))+!B)+!A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i941_4_lut_4_lut.init = 16'he222;
    FD1S3IX dat_rdy_del_333 (.D(dat_rdy), .CK(clk), .CD(RST_N_N_584), 
            .Q(dat_rdy_del));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(322[7] 335[11])
    defparam dat_rdy_del_333.GSR = "DISABLED";
    FD1P3IX temp2__i1 (.D(wb_dat_o[1]), .SP(reg_rdy_N_570), .CD(RST_N_N_584), 
            .CK(clk), .Q(temp2[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp2__i1.GSR = "DISABLED";
    LUT4 i43_4_lut_3_lut (.A(temp1[0]), .B(temp1[6]), .C(temp1[5]), .Z(n24)) /* synthesis lut_function=(!(A (B+(C))+!A !(B (C)))) */ ;
    defparam i43_4_lut_3_lut.init = 16'h4242;
    FD1P3IX GPO_DATA_0___i4 (.D(temp3[3]), .SP(clk_enable_16), .CD(RST_N_N_584), 
            .CK(clk), .Q(GPO_0_c_3));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(410[8] 418[15])
    defparam GPO_DATA_0___i4.GSR = "DISABLED";
    LUT4 i1228_3_lut (.A(GPI_DAT[0]), .B(irq_status[0]), .C(n2178), .Z(n2541)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(344[7] 357[14])
    defparam i1228_3_lut.init = 16'hcaca;
    CCU2D add_416_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n3913), .S1(n957));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_416_1.INIT0 = 16'hF000;
    defparam add_416_1.INIT1 = 16'h5555;
    defparam add_416_1.INJECT1_0 = "NO";
    defparam add_416_1.INJECT1_1 = "NO";
    LUT4 i988_2_lut_3_lut_4_lut (.A(n_temp1_7__N_71), .B(n2529), .C(wb_ack_o), 
         .D(wb_stb_i), .Z(n_wb_adr_i[2])) /* synthesis lut_function=(!(A (C (D))+!A ((C (D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i988_2_lut_3_lut_4_lut.init = 16'h0eee;
    LUT4 i808_3_lut_4_lut_4_lut (.A(n11_adj_591), .B(n14_adj_595), .C(RST_N_c), 
         .D(reg_rdy_del), .Z(clk_enable_19)) /* synthesis lut_function=(!(A (C)+!A (B (C)+!B !((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(529[33:53])
    defparam i808_3_lut_4_lut_4_lut.init = 16'h1f0f;
    LUT4 irq_clr_3__I_0_i3_2_lut_2_lut (.A(irq_clr[2]), .B(RST_N_c), .Z(irq_status_clr[2])) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(500[30:51])
    defparam irq_clr_3__I_0_i3_2_lut_2_lut.init = 16'hbbbb;
    LUT4 i1_4_lut (.A(dat_count[2]), .B(n955), .C(n12), .D(n15), .Z(n_dat_count[2])) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut.init = 16'heca0;
    CCU2D add_416_7 (.A0(dat_count[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3915), .COUT(n3916), .S0(n952), .S1(n951));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_416_7.INIT0 = 16'h5555;
    defparam add_416_7.INIT1 = 16'h5555;
    defparam add_416_7.INJECT1_0 = "NO";
    defparam add_416_7.INJECT1_1 = "NO";
    FD1P3IX GPO_DATA_0___i3 (.D(temp3[2]), .SP(clk_enable_16), .CD(RST_N_N_584), 
            .CK(clk), .Q(GPO_0_c_2));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(410[8] 418[15])
    defparam GPO_DATA_0___i3.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i2 (.D(temp3[1]), .SP(clk_enable_16), .CD(RST_N_N_584), 
            .CK(clk), .Q(GPO_0_c_1));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(410[8] 418[15])
    defparam GPO_DATA_0___i2.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i1 (.D(n2248), .CK(clk), .CD(RST_N_N_584), .Q(n_temp1_7__N_75));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i1.GSR = "DISABLED";
    LUT4 i615_2_lut_3_lut (.A(n15_adj_592), .B(wb_ack_o), .C(wb_stb_i), 
         .Z(n1690)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(1155[5] 1163[15])
    defparam i615_2_lut_3_lut.init = 16'h8080;
    CCU2D add_416_3 (.A0(dat_count[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3913), .COUT(n3914), .S0(n956), .S1(n955));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_416_3.INIT0 = 16'h5555;
    defparam add_416_3.INIT1 = 16'h5555;
    defparam add_416_3.INJECT1_0 = "NO";
    defparam add_416_3.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_29 (.A(dat_count[1]), .B(n956), .C(n12), .D(n15), 
         .Z(n_dat_count[1])) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_29.init = 16'heca0;
    LUT4 i2_3_lut_4_lut (.A(enable_command), .B(n_state_7__N_353[4]), .C(n_temp1_7__N_65), 
         .D(n3140), .Z(n3942)) /* synthesis lut_function=(!(A+(((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(886[5] 894[15])
    defparam i2_3_lut_4_lut.init = 16'h0040;
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    LUT4 i2_4_lut (.A(temp1[2]), .B(n14), .C(temp1[0]), .D(temp1[3]), 
         .Z(enable_command)) /* synthesis lut_function=(!((B+(C+(D)))+!A)) */ ;
    defparam i2_4_lut.init = 16'h0002;
    LUT4 i1_3_lut (.A(wb_dat_o[2]), .B(n_temp1_7__N_66), .C(n_temp1_7__N_68), 
         .Z(n3)) /* synthesis lut_function=(!(A+!(B+(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_3_lut.init = 16'h5454;
    LUT4 n3144_bdd_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n4317), 
         .Z(n12)) /* synthesis lut_function=(((C)+!B)+!A) */ ;
    defparam n3144_bdd_2_lut_3_lut.init = 16'hf7f7;
    LUT4 i1234_4_lut (.A(temp1[0]), .B(GPI_DAT[7]), .C(clk_enable_22), 
         .D(n2178), .Z(n2547)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(344[7] 357[14])
    defparam i1234_4_lut.init = 16'h0aca;
    LUT4 i1_2_lut_adj_30 (.A(data0[6]), .B(n4175), .Z(n_wb_dat_i[6])) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_adj_30.init = 16'h8888;
    LUT4 i1_2_lut_adj_31 (.A(data0[5]), .B(n4175), .Z(n_wb_dat_i[5])) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_adj_31.init = 16'h8888;
    LUT4 i1_4_lut_adj_32 (.A(wb_dat_o[5]), .B(temp1[5]), .C(n4187), .D(n4221), 
         .Z(n_temp1[5])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_32.init = 16'ha0ec;
    VLO i1 (.Z(GND_net));
    FD1P3IX irq_clr__i3 (.D(temp2[3]), .SP(clk_enable_11), .CD(RST_N_N_584), 
            .CK(clk), .Q(irq_clr[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(534[1] 545[10])
    defparam irq_clr__i3.GSR = "DISABLED";
    CCU2D add_416_5 (.A0(dat_count[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3914), .COUT(n3915), .S0(n954), .S1(n953));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_416_5.INIT0 = 16'h5555;
    defparam add_416_5.INIT1 = 16'h5555;
    defparam add_416_5.INJECT1_0 = "NO";
    defparam add_416_5.INJECT1_1 = "NO";
    LUT4 i2937_3_lut_3_lut (.A(temp1[2]), .B(temp1[1]), .C(n24), .Z(n4233)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(352[13:23])
    defparam i2937_3_lut_3_lut.init = 16'h4040;
    LUT4 temp1_7__I_0_408_i11_2_lut_3_lut_4_lut (.A(temp1[2]), .B(temp1[3]), 
         .C(temp1[0]), .D(temp1[1]), .Z(n11_adj_591)) /* synthesis lut_function=((B+(C+!(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(352[13:23])
    defparam temp1_7__I_0_408_i11_2_lut_3_lut_4_lut.init = 16'hfdff;
    LUT4 i1_4_lut_adj_33 (.A(n3175), .B(dat_rdy_N_576), .C(n2500), .D(n_state_7__N_353[4]), 
         .Z(n4)) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_33.init = 16'ha0ec;
    LUT4 i1_2_lut_3_lut_adj_34 (.A(n_temp1_7__N_71), .B(dat_rdy_N_576), 
         .C(n_temp1_7__N_67), .Z(n2523)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i1_2_lut_3_lut_adj_34.init = 16'hfefe;
    LUT4 n14_bdd_4_lut (.A(temp1[1]), .B(temp1[0]), .C(temp1[3]), .D(temp1[2]), 
         .Z(n4475)) /* synthesis lut_function=(A (B+((D)+!C))+!A ((C+!(D))+!B)) */ ;
    defparam n14_bdd_4_lut.init = 16'hfbdf;
    LUT4 i1_2_lut_adj_35 (.A(data0[4]), .B(n4175), .Z(n_wb_dat_i[4])) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_adj_35.init = 16'h8888;
    LUT4 i800_3_lut_4_lut (.A(n11), .B(n14), .C(RST_N_c), .D(reg_rdy), 
         .Z(clk_enable_31)) /* synthesis lut_function=(!(A (C)+!A (B (C)+!B !((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(350[13:23])
    defparam i800_3_lut_4_lut.init = 16'h1f0f;
    LUT4 i2_3_lut_4_lut_adj_36 (.A(n14), .B(n4312), .C(n1), .D(n_state_7__N_519[1]), 
         .Z(n3186)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;
    defparam i2_3_lut_4_lut_adj_36.init = 16'he000;
    LUT4 i2_3_lut_4_lut_adj_37 (.A(n_temp1_7__N_75), .B(n1690), .C(n4), 
         .D(wb_dat_o[2]), .Z(n3976)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (C)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2_3_lut_4_lut_adj_37.init = 16'hf8f0;
    TSALL TSALL_INST (.TSALL(GND_net));
    LUT4 i889_3_lut_4_lut_4_lut (.A(temp1[1]), .B(temp1[5]), .C(RST_N_c), 
         .D(n2032), .Z(n2178)) /* synthesis lut_function=(A ((D)+!C)+!A (B ((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(190[14:19])
    defparam i889_3_lut_4_lut_4_lut.init = 16'hee0e;
    LUT4 m1_lut (.Z(n4524)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    LUT4 i1_4_lut_adj_38 (.A(n_temp1_7__N_71), .B(dat_rdy_N_576), .C(n1891), 
         .D(n48), .Z(n15)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_38.init = 16'heca0;
    LUT4 RST_N_c_bdd_4_lut_3039 (.A(temp1[0]), .B(temp1[1]), .C(temp1[3]), 
         .D(temp1[2]), .Z(n4514)) /* synthesis lut_function=(!((B+(C+(D)))+!A)) */ ;
    defparam RST_N_c_bdd_4_lut_3039.init = 16'h0002;
    LUT4 i1_4_lut_adj_39 (.A(n_state_7__N_353[4]), .B(n_temp1_7__N_72), 
         .C(n1_adj_599), .D(n3_adj_598), .Z(n_wb_dat_i[3])) /* synthesis lut_function=(!(A+!(B+(C+(D))))) */ ;
    defparam i1_4_lut_adj_39.init = 16'h5554;
    LUT4 i1_3_lut_4_lut_adj_40 (.A(n4187), .B(wb_ack_o), .C(wb_stb_i), 
         .D(n_temp1_7__N_65), .Z(n2224)) /* synthesis lut_function=(A+!(B (C+!(D))+!B !(D))) */ ;
    defparam i1_3_lut_4_lut_adj_40.init = 16'hbfaa;
    LUT4 i1016_2_lut_3_lut_4_lut (.A(n_temp1_7__N_71), .B(n_temp1_7__N_58), 
         .C(n1938), .D(n_state_7__N_353[4]), .Z(n_wb_we_i)) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1016_2_lut_3_lut_4_lut.init = 16'h00fe;
    CCU2D add_416_9 (.A0(dat_count[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n3916), 
          .S0(n950));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_416_9.INIT0 = 16'h5555;
    defparam add_416_9.INIT1 = 16'h0000;
    defparam add_416_9.INJECT1_0 = "NO";
    defparam add_416_9.INJECT1_1 = "NO";
    FD1P3IX irq_clr__i2 (.D(temp2[2]), .SP(clk_enable_11), .CD(RST_N_N_584), 
            .CK(clk), .Q(irq_clr[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(534[1] 545[10])
    defparam irq_clr__i2.GSR = "DISABLED";
    LUT4 i1_2_lut_adj_41 (.A(n_temp1_7__N_58), .B(n1938), .Z(n2518)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_adj_41.init = 16'heeee;
    LUT4 i2_4_lut_adj_42 (.A(n1), .B(n3942), .C(reg_rdy_N_570), .D(n2215), 
         .Z(n3980)) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(191[16:23])
    defparam i2_4_lut_adj_42.init = 16'hffec;
    FD1P3IX irq_clr__i1 (.D(temp2[1]), .SP(clk_enable_11), .CD(RST_N_N_584), 
            .CK(clk), .Q(irq_clr[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(534[1] 545[10])
    defparam irq_clr__i1.GSR = "DISABLED";
    FD1P3IX temp3__i7 (.D(wb_dat_o[7]), .SP(dat_rdy_N_574), .CD(RST_N_N_584), 
            .CK(clk), .Q(temp3[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp3__i7.GSR = "DISABLED";
    FD1P3IX temp3__i6 (.D(n_state_7__N_543[4]), .SP(dat_rdy_N_574), .CD(RST_N_N_584), 
            .CK(clk), .Q(temp3[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp3__i6.GSR = "DISABLED";
    FD1S3IX temp1__i0 (.D(n_temp1[0]), .CK(clk), .CD(RST_N_N_584), .Q(temp1[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp1__i0.GSR = "DISABLED";
    LUT4 n14_bdd_2_lut (.A(n14_adj_595), .B(n4475), .Z(n3140)) /* synthesis lut_function=(A+(B)) */ ;
    defparam n14_bdd_2_lut.init = 16'heeee;
    LUT4 i1_2_lut_adj_43 (.A(n_temp1_7__N_71), .B(data0[3]), .Z(n1_adj_599)) /* synthesis lut_function=(A (B)) */ ;
    defparam i1_2_lut_adj_43.init = 16'h8888;
    FD1P3IX temp3__i5 (.D(wb_dat_o[5]), .SP(dat_rdy_N_574), .CD(RST_N_N_584), 
            .CK(clk), .Q(temp3[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp3__i5.GSR = "DISABLED";
    LUT4 i989_3_lut_4_lut_4_lut (.A(temp1[1]), .B(temp1[5]), .C(RST_N_c), 
         .D(n2032), .Z(n2285)) /* synthesis lut_function=(A ((D)+!C)+!A (B ((D)+!C)+!B !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(190[14:19])
    defparam i989_3_lut_4_lut_4_lut.init = 16'hef0f;
    FD1P3IX temp3__i4 (.D(wb_dat_o[4]), .SP(dat_rdy_N_574), .CD(RST_N_N_584), 
            .CK(clk), .Q(temp3[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp3__i4.GSR = "DISABLED";
    FD1P3IX temp3__i3 (.D(wb_dat_o[3]), .SP(dat_rdy_N_574), .CD(RST_N_N_584), 
            .CK(clk), .Q(temp3[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp3__i3.GSR = "DISABLED";
    FD1P3IX temp3__i2 (.D(wb_dat_o[2]), .SP(dat_rdy_N_574), .CD(RST_N_N_584), 
            .CK(clk), .Q(temp3[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp3__i2.GSR = "DISABLED";
    FD1P3IX temp3__i1 (.D(wb_dat_o[1]), .SP(dat_rdy_N_574), .CD(RST_N_N_584), 
            .CK(clk), .Q(temp3[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp3__i1.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i8 (.D(temp3[7]), .SP(clk_enable_16), .CD(RST_N_N_584), 
            .CK(clk), .Q(GPO_0_c_7));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(410[8] 418[15])
    defparam GPO_DATA_0___i8.GSR = "DISABLED";
    FD1P3IX data0__i1 (.D(n2562), .SP(clk_enable_32), .CD(RST_N_N_584), 
            .CK(clk), .Q(data0[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(344[7] 357[14])
    defparam data0__i1.GSR = "DISABLED";
    FD1P3IX data0__i2 (.D(n2557), .SP(clk_enable_32), .CD(RST_N_N_584), 
            .CK(clk), .Q(data0[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(344[7] 357[14])
    defparam data0__i2.GSR = "DISABLED";
    LUT4 i1_3_lut_adj_44 (.A(n_temp1_7__N_65), .B(n_temp1_7__N_72), .C(n_temp1_7__N_59), 
         .Z(n1938)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_3_lut_adj_44.init = 16'hfefe;
    FD1P3IX GPO_DATA_0___i7 (.D(temp3[6]), .SP(clk_enable_16), .CD(RST_N_N_584), 
            .CK(clk), .Q(GPO_0_c_6));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(410[8] 418[15])
    defparam GPO_DATA_0___i7.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i6 (.D(temp3[5]), .SP(clk_enable_16), .CD(RST_N_N_584), 
            .CK(clk), .Q(GPO_0_c_5));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(410[8] 418[15])
    defparam GPO_DATA_0___i6.GSR = "DISABLED";
    FD1P3IX temp2__i3 (.D(wb_dat_o[3]), .SP(reg_rdy_N_570), .CD(RST_N_N_584), 
            .CK(clk), .Q(temp2[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp2__i3.GSR = "DISABLED";
    FD1P3IX temp2__i2 (.D(wb_dat_o[2]), .SP(reg_rdy_N_570), .CD(RST_N_N_584), 
            .CK(clk), .Q(temp2[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp2__i2.GSR = "DISABLED";
    FD1S3AX c_state_FSM_i19 (.D(RST_N_N_584), .CK(clk), .Q(n_temp1_7__N_57));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i19.GSR = "DISABLED";
    LUT4 i2_4_lut_adj_45 (.A(temp1[5]), .B(temp1[0]), .C(temp1[6]), .D(temp1[2]), 
         .Z(n4196)) /* synthesis lut_function=(A (B (C (D)))+!A !((C+!(D))+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam i2_4_lut_adj_45.init = 16'h8400;
    FD1S3IX c_state_FSM_i18 (.D(n2238), .CK(clk), .CD(RST_N_N_584), .Q(n_temp1_7__N_58));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i18.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i17 (.D(n3998), .CK(clk), .CD(RST_N_N_584), .Q(n_temp1_7__N_59));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i17.GSR = "DISABLED";
    LUT4 i1_2_lut_3_lut_adj_46 (.A(wb_ack_o), .B(wb_stb_i), .C(n1), .Z(n21)) /* synthesis lut_function=(A (B (C))) */ ;
    defparam i1_2_lut_3_lut_adj_46.init = 16'h8080;
    FD1S3IX c_state_FSM_i16 (.D(n2234), .CK(clk), .CD(RST_N_N_584), .Q(n_temp1_7__N_60));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i16.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i15 (.D(n2232), .CK(clk), .CD(RST_N_N_584), .Q(n_temp1_7__N_61));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i15.GSR = "DISABLED";
    FD1P3IX c_state_FSM_i14 (.D(n_temp1_7__N_61), .SP(n_state_7__N_353[4]), 
            .CD(RST_N_N_584), .CK(clk), .Q(n_temp1_7__N_62));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i14.GSR = "DISABLED";
    LUT4 i953_2_lut_3_lut_4_lut (.A(n_temp1_7__N_58), .B(wb_ack_o), .C(wb_stb_i), 
         .D(n_temp1_7__N_57), .Z(n2238)) /* synthesis lut_function=(A (((D)+!C)+!B)+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i953_2_lut_3_lut_4_lut.init = 16'hff2a;
    OB GPO_0_pad_7 (.I(GPO_0_c_7), .O(GPO_0[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(77[1:6])
    LUT4 i929_4_lut (.A(n_temp1_7__N_69), .B(n3175), .C(n1632), .D(n2500), 
         .Z(n2214)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i929_4_lut.init = 16'hb3a0;
    LUT4 irq_clr_3__I_0_i1_2_lut_2_lut (.A(irq_clr[0]), .B(RST_N_c), .Z(irq_status_clr[0])) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(500[30:51])
    defparam irq_clr_3__I_0_i1_2_lut_2_lut.init = 16'hbbbb;
    FD1S3IX c_state_FSM_i13 (.D(n2228), .CK(clk), .CD(RST_N_N_584), .Q(n_temp1_7__N_63));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i13.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i12 (.D(n2226), .CK(clk), .CD(RST_N_N_584), .Q(n_temp1_7__N_64));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i12.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i11 (.D(n2224), .CK(clk), .CD(RST_N_N_584), .Q(n_temp1_7__N_65));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i11.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i10 (.D(n2222), .CK(clk), .CD(RST_N_N_584), .Q(n_temp1_7__N_66));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i10.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i9 (.D(n2220), .CK(clk), .CD(RST_N_N_584), .Q(n_temp1_7__N_67));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i9.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i8 (.D(n3980), .CK(clk), .CD(RST_N_N_584), .Q(n_temp1_7__N_68));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i8.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i7 (.D(n2214), .CK(clk), .CD(RST_N_N_584), .Q(n_temp1_7__N_69));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i7.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i6 (.D(n3976), .CK(clk), .CD(RST_N_N_584), .Q(dat_rdy_N_576));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i6.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i5 (.D(n3975), .CK(clk), .CD(RST_N_N_584), .Q(n_temp1_7__N_71));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i5.GSR = "DISABLED";
    FD1P3DX irq_status_2__343 (.D(n4524), .SP(irq_en[2]), .CK(IRQ_c_2), 
            .CD(irq_status_clr[2]), .Q(irq_status[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(501[7] 507[23])
    defparam irq_status_2__343.GSR = "DISABLED";
    LUT4 i1_2_lut_adj_47 (.A(data0[0]), .B(n4175), .Z(n_wb_dat_i[0])) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_adj_47.init = 16'h8888;
    FD1P3AX irq_status_3__344 (.D(n4524), .SP(irq_en[3]), .CK(IRQ_c_3), 
            .Q(irq_status[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(501[7] 507[23])
    defparam irq_status_3__344.GSR = "ENABLED";
    FD1P3DX irq_status_1__342 (.D(n4524), .SP(irq_en[1]), .CK(IRQ_c_1), 
            .CD(irq_status_clr[1]), .Q(irq_status[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(501[7] 507[23])
    defparam irq_status_1__342.GSR = "DISABLED";
    FD1P3DX irq_status_0__341 (.D(n4524), .SP(irq_en[0]), .CK(IRQ_c_0), 
            .CD(irq_status_clr[0]), .Q(irq_status[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(501[7] 507[23])
    defparam irq_status_0__341.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i4 (.D(n3981), .CK(clk), .CD(RST_N_N_584), .Q(n_temp1_7__N_72));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i4.GSR = "DISABLED";
    LUT4 i2_4_lut_adj_48 (.A(n3144), .B(n4186), .C(n2497), .D(n4175), 
         .Z(n3975)) /* synthesis lut_function=(A (B+(D))+!A (B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2_4_lut_adj_48.init = 16'hffdc;
    LUT4 i3_4_lut (.A(n_temp1_7__N_65), .B(enable_command), .C(n3186), 
         .D(n3140), .Z(n3_adj_598)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;
    defparam i3_4_lut.init = 16'h2000;
    LUT4 i1_4_lut_adj_49 (.A(n_temp1_7__N_64), .B(temp1[4]), .C(n4184), 
         .D(n4221), .Z(n_temp1[4])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_49.init = 16'ha0ec;
    FD1S3IX c_state_FSM_i3 (.D(n4258), .CK(clk), .CD(RST_N_N_584), .Q(n_temp1_7__N_73));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i3.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i2 (.D(n2246), .CK(clk), .CD(RST_N_N_584), .Q(n_temp1_7__N_74));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i2.GSR = "DISABLED";
    FD1P3IX irq_en__i3 (.D(temp2[3]), .SP(clk_enable_19), .CD(RST_N_N_584), 
            .CK(clk), .Q(irq_en[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(534[1] 545[10])
    defparam irq_en__i3.GSR = "DISABLED";
    LUT4 i2950_4_lut (.A(n_state_7__N_353[4]), .B(n_temp1_7__N_65), .C(n4223), 
         .D(n_temp1_7__N_72), .Z(n_wb_dat_i[2])) /* synthesis lut_function=(!(A+!(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2950_4_lut.init = 16'h5554;
    LUT4 i2912_3_lut (.A(n_temp1_7__N_59), .B(n_temp1_7__N_71), .C(data0[2]), 
         .Z(n4223)) /* synthesis lut_function=(A+(B (C))) */ ;
    defparam i2912_3_lut.init = 16'heaea;
    LUT4 i1_2_lut_adj_50 (.A(data0[1]), .B(n4175), .Z(n_wb_dat_i[1])) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_adj_50.init = 16'h8888;
    LUT4 i1_4_lut_adj_51 (.A(wb_dat_o[1]), .B(temp1[1]), .C(n4187), .D(n4221), 
         .Z(n_temp1[1])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_51.init = 16'ha0ec;
    FD1P3IX irq_en__i2 (.D(temp2[2]), .SP(clk_enable_19), .CD(RST_N_N_584), 
            .CK(clk), .Q(irq_en[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(534[1] 545[10])
    defparam irq_en__i2.GSR = "DISABLED";
    FD1P3IX irq_en__i1 (.D(temp2[1]), .SP(clk_enable_19), .CD(RST_N_N_584), 
            .CK(clk), .Q(irq_en[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(534[1] 545[10])
    defparam irq_en__i1.GSR = "DISABLED";
    FD1S3IX dat_count__i7 (.D(n_dat_count[7]), .CK(clk), .CD(RST_N_N_584), 
            .Q(dat_count[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(621[1] 635[10])
    defparam dat_count__i7.GSR = "DISABLED";
    FD1S3IX dat_count__i6 (.D(n_dat_count[6]), .CK(clk), .CD(RST_N_N_584), 
            .Q(dat_count[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(621[1] 635[10])
    defparam dat_count__i6.GSR = "DISABLED";
    FD1S3IX dat_count__i5 (.D(n_dat_count[5]), .CK(clk), .CD(RST_N_N_584), 
            .Q(dat_count[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(621[1] 635[10])
    defparam dat_count__i5.GSR = "DISABLED";
    FD1S3IX dat_count__i4 (.D(n_dat_count[4]), .CK(clk), .CD(RST_N_N_584), 
            .Q(dat_count[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(621[1] 635[10])
    defparam dat_count__i4.GSR = "DISABLED";
    FD1S3IX dat_count__i3 (.D(n_dat_count[3]), .CK(clk), .CD(RST_N_N_584), 
            .Q(dat_count[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(621[1] 635[10])
    defparam dat_count__i3.GSR = "DISABLED";
    FD1S3IX dat_count__i2 (.D(n_dat_count[2]), .CK(clk), .CD(RST_N_N_584), 
            .Q(dat_count[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(621[1] 635[10])
    defparam dat_count__i2.GSR = "DISABLED";
    FD1S3IX dat_count__i1 (.D(n_dat_count[1]), .CK(clk), .CD(RST_N_N_584), 
            .Q(dat_count[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(621[1] 635[10])
    defparam dat_count__i1.GSR = "DISABLED";
    FD1S3IX wb_adr_i__i4 (.D(n_wb_adr_i[6]), .CK(clk), .CD(RST_N_N_584), 
            .Q(wb_adr_i[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_adr_i__i4.GSR = "DISABLED";
    FD1S3IX wb_adr_i__i3 (.D(n_wb_adr_i[2]), .CK(clk), .CD(RST_N_N_584), 
            .Q(wb_adr_i[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_adr_i__i3.GSR = "DISABLED";
    FD1S3IX wb_adr_i__i2 (.D(n_wb_adr_i[1]), .CK(clk), .CD(RST_N_N_584), 
            .Q(wb_adr_i[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_adr_i__i2.GSR = "DISABLED";
    FD1P3IX data0__i6 (.D(GPI_DAT[6]), .SP(clk_enable_22), .CD(n2285), 
            .CK(clk), .Q(data0[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(344[7] 357[14])
    defparam data0__i6.GSR = "DISABLED";
    FD1P3IX data0__i5 (.D(GPI_DAT[5]), .SP(clk_enable_22), .CD(n2285), 
            .CK(clk), .Q(data0[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(344[7] 357[14])
    defparam data0__i5.GSR = "DISABLED";
    FD1P3IX data0__i4 (.D(GPI_DAT[4]), .SP(clk_enable_22), .CD(n2285), 
            .CK(clk), .Q(data0[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(344[7] 357[14])
    defparam data0__i4.GSR = "DISABLED";
    FD1P3IX data0__i3 (.D(n2552), .SP(clk_enable_32), .CD(RST_N_N_584), 
            .CK(clk), .Q(data0[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(344[7] 357[14])
    defparam data0__i3.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i7 (.D(n_wb_dat_i[7]), .CK(clk), .CD(RST_N_N_584), 
            .Q(wb_dat_i[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_dat_i__i7.GSR = "DISABLED";
    FD1P3IX data0__i7 (.D(n2547), .SP(clk_enable_32), .CD(RST_N_N_584), 
            .CK(clk), .Q(data0[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(344[7] 357[14])
    defparam data0__i7.GSR = "DISABLED";
    LUT4 i1_2_lut_4_lut (.A(n_temp1_7__N_74), .B(n15_adj_592), .C(n3144), 
         .D(n_state_7__N_353[4]), .Z(n4182)) /* synthesis lut_function=(A (B (D)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_4_lut.init = 16'ha800;
    LUT4 i1_2_lut_3_lut_adj_52 (.A(wb_ack_o), .B(wb_stb_i), .C(n_state_7__N_519[1]), 
         .Z(n48)) /* synthesis lut_function=(A (B (C))) */ ;
    defparam i1_2_lut_3_lut_adj_52.init = 16'h8080;
    LUT4 i1243_3_lut (.A(GPI_DAT[2]), .B(irq_status[2]), .C(n2178), .Z(n2556)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(344[7] 357[14])
    defparam i1243_3_lut.init = 16'hcaca;
    LUT4 i728_2_lut_4_lut (.A(n14), .B(n4312), .C(wb_ack_o), .D(wb_stb_i), 
         .Z(n1891)) /* synthesis lut_function=(!(A+(B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(1045[7] 1064[12])
    defparam i728_2_lut_4_lut.init = 16'h1000;
    LUT4 i1238_3_lut (.A(GPI_DAT[3]), .B(irq_status[3]), .C(n2178), .Z(n2551)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(344[7] 357[14])
    defparam i1238_3_lut.init = 16'hcaca;
    FD1S3IX wb_dat_i__i6 (.D(n_wb_dat_i[6]), .CK(clk), .CD(RST_N_N_584), 
            .Q(wb_dat_i[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_dat_i__i6.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i5 (.D(n_wb_dat_i[5]), .CK(clk), .CD(RST_N_N_584), 
            .Q(wb_dat_i[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_dat_i__i5.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i4 (.D(n_wb_dat_i[4]), .CK(clk), .CD(RST_N_N_584), 
            .Q(wb_dat_i[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_dat_i__i4.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i3 (.D(n_wb_dat_i[3]), .CK(clk), .CD(RST_N_N_584), 
            .Q(wb_dat_i[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_dat_i__i3.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i2 (.D(n_wb_dat_i[2]), .CK(clk), .CD(RST_N_N_584), 
            .Q(wb_dat_i[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_dat_i__i2.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i1 (.D(n_wb_dat_i[1]), .CK(clk), .CD(RST_N_N_584), 
            .Q(wb_dat_i[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_dat_i__i1.GSR = "DISABLED";
    IFS1P3IX GPI_DAT__i7 (.D(GPI_0_c_7), .SP(clk_enable_31), .SCLK(clk), 
            .CD(RST_N_N_584), .Q(GPI_DAT[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(453[8] 459[15])
    defparam GPI_DAT__i7.GSR = "DISABLED";
    LUT4 RST_N_c_bdd_4_lut (.A(RST_N_c), .B(n14_adj_595), .C(reg_rdy_del), 
         .D(n4514), .Z(clk_enable_11)) /* synthesis lut_function=(!(A (B+!(C (D))))) */ ;
    defparam RST_N_c_bdd_4_lut.init = 16'h7555;
    LUT4 i2935_2_lut (.A(irq_en[3]), .B(temp1[0]), .Z(n4239)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(344[7] 357[14])
    defparam i2935_2_lut.init = 16'heeee;
    LUT4 i1021_3_lut_4_lut (.A(n_temp1_7__N_71), .B(n2518), .C(n2529), 
         .D(n_state_7__N_353[4]), .Z(n_wb_stb_i)) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1021_3_lut_4_lut.init = 16'h00fe;
    LUT4 i799_4_lut_then_1_lut (.A(RST_N_c), .Z(RST_N_N_584)) /* synthesis lut_function=(!(A)) */ ;
    defparam i799_4_lut_then_1_lut.init = 16'h5555;
    LUT4 i1_2_lut_3_lut_adj_53 (.A(n_temp1_7__N_67), .B(wb_ack_o), .C(wb_stb_i), 
         .Z(reg_rdy_N_570)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(807[12:33])
    defparam i1_2_lut_3_lut_adj_53.init = 16'h8080;
    LUT4 i994_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n1938), .D(n2529), 
         .Z(n_wb_adr_i[0])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i994_3_lut_4_lut.init = 16'h7770;
    LUT4 n3144_bdd_4_lut_2974 (.A(n3144), .B(n1), .C(n_temp1_7__N_71), 
         .D(n_temp1_7__N_67), .Z(n4316)) /* synthesis lut_function=(A ((C+!(D))+!B)+!A !(B (C+(D))+!B !((D)+!C))) */ ;
    defparam n3144_bdd_4_lut_2974.init = 16'hb3af;
    LUT4 wb_ack_o_I_0_2_lut (.A(wb_ack_o), .B(wb_stb_i), .Z(n_state_7__N_353[4])) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(807[12:33])
    defparam wb_ack_o_I_0_2_lut.init = 16'h8888;
    IFS1P3IX GPI_DAT__i6 (.D(GPI_0_c_6), .SP(clk_enable_31), .SCLK(clk), 
            .CD(RST_N_N_584), .Q(GPI_DAT[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(453[8] 459[15])
    defparam GPI_DAT__i6.GSR = "DISABLED";
    IFS1P3IX GPI_DAT__i5 (.D(GPI_0_c_5), .SP(clk_enable_31), .SCLK(clk), 
            .CD(RST_N_N_584), .Q(GPI_DAT[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(453[8] 459[15])
    defparam GPI_DAT__i5.GSR = "DISABLED";
    IFS1P3IX GPI_DAT__i4 (.D(GPI_0_c_4), .SP(clk_enable_31), .SCLK(clk), 
            .CD(RST_N_N_584), .Q(GPI_DAT[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(453[8] 459[15])
    defparam GPI_DAT__i4.GSR = "DISABLED";
    IFS1P3IX GPI_DAT__i3 (.D(GPI_0_c_3), .SP(clk_enable_31), .SCLK(clk), 
            .CD(RST_N_N_584), .Q(GPI_DAT[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(453[8] 459[15])
    defparam GPI_DAT__i3.GSR = "DISABLED";
    IFS1P3IX GPI_DAT__i2 (.D(GPI_0_c_2), .SP(clk_enable_31), .SCLK(clk), 
            .CD(RST_N_N_584), .Q(GPI_DAT[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(453[8] 459[15])
    defparam GPI_DAT__i2.GSR = "DISABLED";
    IFS1P3IX GPI_DAT__i1 (.D(GPI_0_c_1), .SP(clk_enable_31), .SCLK(clk), 
            .CD(RST_N_N_584), .Q(GPI_DAT[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(453[8] 459[15])
    defparam GPI_DAT__i1.GSR = "DISABLED";
    FD1S3IX temp1__i1 (.D(n_temp1[1]), .CK(clk), .CD(RST_N_N_584), .Q(temp1[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp1__i1.GSR = "DISABLED";
    FD1P3IX data0__i0 (.D(n2542), .SP(clk_enable_32), .CD(RST_N_N_584), 
            .CK(clk), .Q(data0[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(344[7] 357[14])
    defparam data0__i0.GSR = "DISABLED";
    FD1S3AX reg_rdy_del_331 (.D(reg_rdy), .CK(clk), .Q(reg_rdy_del));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(304[1] 317[9])
    defparam reg_rdy_del_331.GSR = "DISABLED";
    GSR GSR_INST (.GSR(irq_status_clr[3]));
    LUT4 i2945_2_lut (.A(irq_clr[3]), .B(RST_N_c), .Z(irq_status_clr[3])) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(500[30:51])
    defparam i2945_2_lut.init = 16'h4444;
    OB GPO_0_pad_6 (.I(GPO_0_c_6), .O(GPO_0[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(77[1:6])
    OB GPO_0_pad_5 (.I(GPO_0_c_5), .O(GPO_0[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(77[1:6])
    OB GPO_0_pad_4 (.I(GPO_0_c_4), .O(GPO_0[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(77[1:6])
    OB GPO_0_pad_3 (.I(GPO_0_c_3), .O(GPO_0[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(77[1:6])
    OB GPO_0_pad_2 (.I(GPO_0_c_2), .O(GPO_0[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(77[1:6])
    OB GPO_0_pad_1 (.I(GPO_0_c_1), .O(GPO_0[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(77[1:6])
    OB GPO_0_pad_0 (.I(GPO_0_c_0), .O(GPO_0[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(77[1:6])
    OB Enable_pad (.I(GND_net), .O(Enable));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(80[1:7])
    OBZ INTQ_pad (.I(GND_net), .T(check_irq_status), .O(INTQ));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(477[4] 488[16])
    IB IRQ_pad_3 (.I(IRQ[3]), .O(IRQ_c_3));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(78[1:4])
    IB IRQ_pad_2 (.I(IRQ[2]), .O(IRQ_c_2));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(78[1:4])
    IB IRQ_pad_1 (.I(IRQ[1]), .O(IRQ_c_1));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(78[1:4])
    IB IRQ_pad_0 (.I(IRQ[0]), .O(IRQ_c_0));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(78[1:4])
    IB GPI_0_pad_7 (.I(GPI_0[7]), .O(GPI_0_c_7));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(79[1:6])
    IB GPI_0_pad_6 (.I(GPI_0[6]), .O(GPI_0_c_6));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(79[1:6])
    IB GPI_0_pad_5 (.I(GPI_0[5]), .O(GPI_0_c_5));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(79[1:6])
    IB GPI_0_pad_4 (.I(GPI_0[4]), .O(GPI_0_c_4));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(79[1:6])
    IB GPI_0_pad_3 (.I(GPI_0[3]), .O(GPI_0_c_3));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(79[1:6])
    IB GPI_0_pad_2 (.I(GPI_0[2]), .O(GPI_0_c_2));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(79[1:6])
    IB GPI_0_pad_1 (.I(GPI_0[1]), .O(GPI_0_c_1));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(79[1:6])
    IB GPI_0_pad_0 (.I(GPI_0[0]), .O(GPI_0_c_0));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(79[1:6])
    IB RST_N_pad (.I(RST_N), .O(RST_N_c));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(82[1:6])
    LUT4 i799_4_lut_else_1_lut (.A(RST_N_c), .B(n14), .C(n11_adj_594), 
         .D(dat_rdy_del), .Z(n4407)) /* synthesis lut_function=(!(A (B+(C+!(D))))) */ ;
    defparam i799_4_lut_else_1_lut.init = 16'h5755;
    LUT4 i2_3_lut_4_lut_adj_54 (.A(temp1[4]), .B(temp1[7]), .C(temp1[6]), 
         .D(temp1[5]), .Z(n14)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(350[13:23])
    defparam i2_3_lut_4_lut_adj_54.init = 16'hfffe;
    LUT4 i1_2_lut_3_lut_adj_55 (.A(dat_rdy_N_576), .B(wb_ack_o), .C(wb_stb_i), 
         .Z(dat_rdy_N_574)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(328[14:75])
    defparam i1_2_lut_3_lut_adj_55.init = 16'h8080;
    LUT4 i1_4_lut_adj_56 (.A(n_state_7__N_543[4]), .B(temp1[6]), .C(n4187), 
         .D(n4221), .Z(n_temp1[6])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_56.init = 16'ha0ec;
    PFUMX i2955 (.BLUT(n4316), .ALUT(n4315), .C0(dat_rdy_N_576), .Z(n4317));
    LUT4 i2948_4_lut (.A(irq_status[0]), .B(irq_status[3]), .C(irq_status[2]), 
         .D(irq_status[1]), .Z(check_irq_status)) /* synthesis lut_function=(!(A+(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(477[4] 488[16])
    defparam i2948_4_lut.init = 16'h0001;
    LUT4 i2_3_lut_4_lut_adj_57 (.A(temp1[4]), .B(temp1[7]), .C(temp1[6]), 
         .D(temp1[5]), .Z(n14_adj_595)) /* synthesis lut_function=(A+(B+!(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(350[13:23])
    defparam i2_3_lut_4_lut_adj_57.init = 16'hefff;
    LUT4 i1_4_lut_adj_58 (.A(n_temp1_7__N_64), .B(temp1[2]), .C(n1618), 
         .D(n4221), .Z(n_temp1[2])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_58.init = 16'ha0ec;
    LUT4 i924_2_lut_3_lut (.A(n_temp1_7__N_71), .B(wb_ack_o), .C(wb_stb_i), 
         .Z(n4175)) /* synthesis lut_function=(!((B (C))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i924_2_lut_3_lut.init = 16'h2a2a;
    LUT4 n14_bdd_4_lut_adj_59 (.A(temp1[3]), .B(temp1[0]), .C(temp1[1]), 
         .D(temp1[2]), .Z(n4485)) /* synthesis lut_function=(A (((D)+!C)+!B)+!A ((C+!(D))+!B)) */ ;
    defparam n14_bdd_4_lut_adj_59.init = 16'hfb7f;
    FD1S3IX temp1__i2 (.D(n_temp1[2]), .CK(clk), .CD(RST_N_N_584), .Q(temp1[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp1__i2.GSR = "DISABLED";
    FD1S3IX temp1__i3 (.D(n_temp1[3]), .CK(clk), .CD(RST_N_N_584), .Q(temp1[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp1__i3.GSR = "DISABLED";
    FD1S3IX temp1__i4 (.D(n_temp1[4]), .CK(clk), .CD(RST_N_N_584), .Q(temp1[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp1__i4.GSR = "DISABLED";
    FD1S3IX temp1__i5 (.D(n_temp1[5]), .CK(clk), .CD(RST_N_N_584), .Q(temp1[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp1__i5.GSR = "DISABLED";
    FD1S3IX temp1__i6 (.D(n_temp1[6]), .CK(clk), .CD(RST_N_N_584), .Q(temp1[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp1__i6.GSR = "DISABLED";
    FD1S3IX temp1__i7 (.D(n_temp1[7]), .CK(clk), .CD(RST_N_N_584), .Q(temp1[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(362[1] 377[11])
    defparam temp1__i7.GSR = "DISABLED";
    LUT4 i2914_2_lut_3_lut (.A(temp1[4]), .B(temp1[7]), .C(temp1[3]), 
         .Z(n4225)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(350[13:23])
    defparam i2914_2_lut_3_lut.init = 16'hfefe;
    LUT4 i1248_3_lut (.A(GPI_DAT[1]), .B(irq_status[1]), .C(n2178), .Z(n2561)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(344[7] 357[14])
    defparam i1248_3_lut.init = 16'hcaca;
    LUT4 i1_2_lut_3_lut_adj_60 (.A(n_temp1_7__N_69), .B(n_state_7__N_353[4]), 
         .C(wb_dat_o[4]), .Z(n4186)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_3_lut_adj_60.init = 16'h8080;
    LUT4 i1_2_lut_3_lut_adj_61 (.A(n_temp1_7__N_68), .B(n_state_7__N_353[4]), 
         .C(wb_dat_o[2]), .Z(n2500)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_3_lut_adj_61.init = 16'h8080;
    LUT4 n1488_bdd_2_lut_2981 (.A(n4314), .B(n_state_7__N_519[1]), .Z(n4315)) /* synthesis lut_function=(A+!(B)) */ ;
    defparam n1488_bdd_2_lut_2981.init = 16'hbbbb;
    PFUMX i1249 (.BLUT(n4240), .ALUT(n2561), .C0(clk_enable_22), .Z(n2562));
    LUT4 i963_4_lut (.A(n_temp1_7__N_75), .B(dat_rdy_N_574), .C(n1695), 
         .D(n_state_7__N_519[1]), .Z(n2248)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i963_4_lut.init = 16'heca0;
    LUT4 i1_4_lut_adj_62 (.A(wb_dat_o[7]), .B(temp1[7]), .C(n4187), .D(n4221), 
         .Z(n_temp1[7])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_62.init = 16'ha0ec;
    LUT4 i620_4_lut (.A(n_state_7__N_353[4]), .B(wb_dat_o[2]), .C(n_state_7__N_543[4]), 
         .D(n1690), .Z(n1695)) /* synthesis lut_function=(!(A (B+!(C (D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(1155[5] 1163[15])
    defparam i620_4_lut.init = 16'h7555;
    LUT4 i3_4_lut_4_lut (.A(n15_adj_592), .B(n3144), .C(n_temp1_7__N_74), 
         .D(n_temp1_7__N_75), .Z(n2531)) /* synthesis lut_function=(!(A+!(B (D)+!B (C+(D))))) */ ;
    defparam i3_4_lut_4_lut.init = 16'h5510;
    LUT4 i1_4_lut_adj_63 (.A(n11_adj_601), .B(n_temp1_7__N_59), .C(n_temp1_7__N_58), 
         .D(n_state_7__N_353[4]), .Z(n3998)) /* synthesis lut_function=(A+(B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_63.init = 16'hfaee;
    LUT4 i1_4_lut_adj_64 (.A(n_state_7__N_543[4]), .B(n_state_7__N_353[4]), 
         .C(n17), .D(n4163), .Z(n11_adj_601)) /* synthesis lut_function=(!(A+!(B (C+(D))+!B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_64.init = 16'h5450;
    LUT4 i1_2_lut_adj_65 (.A(n_state_7__N_353[4]), .B(wb_dat_o[4]), .Z(n4184)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_adj_65.init = 16'h8888;
    LUT4 i1_2_lut_3_lut_adj_66 (.A(temp1[4]), .B(temp1[7]), .C(n27), .Z(n2032)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(350[13:23])
    defparam i1_2_lut_3_lut_adj_66.init = 16'h1010;
    LUT4 i7_4_lut (.A(dat_count[4]), .B(n14_adj_593), .C(n10), .D(dat_count[5]), 
         .Z(n15_adj_592)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(1122[13:35])
    defparam i7_4_lut.init = 16'hfffe;
    LUT4 i596_2_lut_3_lut_4_lut (.A(n15_adj_592), .B(n14), .C(n4312), 
         .D(n_state_7__N_353[4]), .Z(n1671)) /* synthesis lut_function=(A (D)+!A (B (D)+!B (C (D)))) */ ;
    defparam i596_2_lut_3_lut_4_lut.init = 16'hfe00;
    PFUMX i42 (.BLUT(n4232), .ALUT(n4233), .C0(temp1[3]), .Z(n27));
    LUT4 i930_2_lut_4_lut (.A(n_temp1_7__N_68), .B(n_state_7__N_353[4]), 
         .C(wb_dat_o[2]), .D(n_state_7__N_543[4]), .Z(n2215)) /* synthesis lut_function=(!((B (C+!(D)))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i930_2_lut_4_lut.init = 16'h2a22;
    LUT4 i2936_2_lut_2_lut (.A(temp1[1]), .B(n4196), .Z(n4232)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i2936_2_lut_2_lut.init = 16'h4444;
    LUT4 select_745_Select_1_i2_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), 
         .C(n1940), .Z(n_wb_adr_i[1])) /* synthesis lut_function=(!(A (B+!(C))+!A !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam select_745_Select_1_i2_2_lut_3_lut.init = 16'h7070;
    LUT4 i2931_2_lut_2_lut (.A(temp1[0]), .B(irq_en[0]), .Z(n4237)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i2931_2_lut_2_lut.init = 16'h4444;
    LUT4 n3144_bdd_4_lut_2954 (.A(n3144), .B(n1), .C(n_temp1_7__N_71), 
         .D(n_temp1_7__N_67), .Z(n4314)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;
    defparam n3144_bdd_4_lut_2954.init = 16'hb3a0;
    LUT4 i1_4_lut_4_lut (.A(temp1[1]), .B(n4196), .C(RST_N_c), .D(n4225), 
         .Z(clk_enable_22)) /* synthesis lut_function=(!(A+(B (C (D))+!B (C)))) */ ;
    defparam i1_4_lut_4_lut.init = 16'h0545;
    LUT4 i935_4_lut_4_lut (.A(n_temp1_7__N_67), .B(n_state_7__N_353[4]), 
         .C(wb_dat_o[2]), .D(n_temp1_7__N_66), .Z(n2220)) /* synthesis lut_function=(A ((C (D))+!B)+!A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i935_4_lut_4_lut.init = 16'he222;
    LUT4 i949_4_lut (.A(n_temp1_7__N_60), .B(n_state_7__N_353[4]), .C(n1663), 
         .D(n_temp1_7__N_59), .Z(n2234)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i949_4_lut.init = 16'heca0;
    LUT4 n14_bdd_2_lut_adj_67 (.A(n14), .B(n4312), .Z(n3144)) /* synthesis lut_function=(A+(B)) */ ;
    defparam n14_bdd_2_lut_adj_67.init = 16'heeee;
    LUT4 i2_4_lut_adj_68 (.A(n_state_7__N_353[4]), .B(n2531), .C(n37), 
         .D(n_temp1_7__N_72), .Z(n3981)) /* synthesis lut_function=(A (B+(C))+!A (C+(D))) */ ;
    defparam i2_4_lut_adj_68.init = 16'hfdf8;
    LUT4 i588_2_lut (.A(n_state_7__N_353[4]), .B(n_state_7__N_543[4]), .Z(n1663)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(1091[7] 1110[12])
    defparam i588_2_lut.init = 16'hdddd;
    LUT4 i2_3_lut_3_lut (.A(RST_N_c), .B(n2178), .C(clk_enable_22), .Z(clk_enable_32)) /* synthesis lut_function=((B+(C))+!A) */ ;
    defparam i2_3_lut_3_lut.init = 16'hfdfd;
    LUT4 i947_4_lut (.A(n_temp1_7__N_61), .B(n_state_7__N_353[4]), .C(n_temp1_7__N_60), 
         .D(n_state_7__N_543[4]), .Z(n2232)) /* synthesis lut_function=(!(A (B ((D)+!C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i947_4_lut.init = 16'h22e2;
    LUT4 i943_4_lut (.A(n_temp1_7__N_63), .B(n_state_7__N_353[4]), .C(n1618), 
         .D(n_temp1_7__N_62), .Z(n2228)) /* synthesis lut_function=(A (B ((D)+!C)+!B !(C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i943_4_lut.init = 16'hce0a;
    LUT4 i1_2_lut_adj_69 (.A(dat_rdy_N_574), .B(n_state_7__N_519[1]), .Z(n37)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(197[8:15])
    defparam i1_2_lut_adj_69.init = 16'h2222;
    LUT4 i3_4_lut_adj_70 (.A(n4084), .B(n6), .C(n_temp1_7__N_73), .D(n1663), 
         .Z(n4258)) /* synthesis lut_function=(A+(B+(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i3_4_lut_adj_70.init = 16'hfeee;
    LUT4 i1_4_lut_adj_71 (.A(n_state_7__N_353[4]), .B(n_temp1_7__N_72), 
         .C(n_temp1_7__N_67), .D(n1), .Z(n4084)) /* synthesis lut_function=(A (B+!((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(216[17:24])
    defparam i1_4_lut_adj_71.init = 16'h88a8;
    LUT4 i1_4_lut_adj_72 (.A(dat_count[0]), .B(n957), .C(n12), .D(n15), 
         .Z(n_dat_count[0])) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_72.init = 16'heca0;
    LUT4 i1_4_lut_adj_73 (.A(wb_dat_o[3]), .B(temp1[3]), .C(n4187), .D(n4221), 
         .Z(n_temp1[3])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_73.init = 16'ha0ec;
    LUT4 i6_4_lut (.A(dat_count[3]), .B(dat_count[2]), .C(dat_count[6]), 
         .D(dat_count[7]), .Z(n14_adj_593)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(1122[13:35])
    defparam i6_4_lut.init = 16'hfffe;
    LUT4 i2929_2_lut_2_lut (.A(temp1[0]), .B(irq_en[2]), .Z(n4238)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i2929_2_lut_2_lut.init = 16'h4444;
    LUT4 i1_4_lut_adj_74 (.A(n_temp1_7__N_73), .B(wb_dat_o[4]), .C(n3), 
         .D(n_temp1_7__N_69), .Z(n4163)) /* synthesis lut_function=(A+(B (C)+!B (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_74.init = 16'hfbfa;
    LUT4 i2_2_lut (.A(dat_count[1]), .B(dat_count[0]), .Z(n10)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(1122[13:35])
    defparam i2_2_lut.init = 16'heeee;
    LUT4 i2_4_lut_adj_75 (.A(n_temp1_7__N_65), .B(n3144), .C(n51), .D(n2497), 
         .Z(n6)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2_4_lut_adj_75.init = 16'heca0;
    LUT4 i2_3_lut_4_lut_adj_76 (.A(temp1[0]), .B(temp1[1]), .C(n14), .D(temp1[3]), 
         .Z(n_state_7__N_519[1])) /* synthesis lut_function=((B+(C+(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(350[13:23])
    defparam i2_3_lut_4_lut_adj_76.init = 16'hfffd;
    LUT4 i1863_2_lut (.A(n_state_7__N_353[4]), .B(wb_dat_o[2]), .Z(n1618)) /* synthesis lut_function=(A (B)) */ ;
    defparam i1863_2_lut.init = 16'h8888;
    PFUMX i2991 (.BLUT(n4407), .ALUT(RST_N_N_584), .C0(temp2[0]), .Z(clk_enable_16));
    LUT4 i2933_2_lut_2_lut (.A(temp1[0]), .B(irq_en[1]), .Z(n4240)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam i2933_2_lut_2_lut.init = 16'h4444;
    LUT4 equal_22_i11_2_lut_3_lut_4_lut (.A(temp1[0]), .B(temp1[1]), .C(temp1[3]), 
         .D(temp1[2]), .Z(n11)) /* synthesis lut_function=((B+(C+!(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(350[13:23])
    defparam equal_22_i11_2_lut_3_lut_4_lut.init = 16'hfdff;
    LUT4 i1_4_lut_adj_77 (.A(n3186), .B(enable_command), .C(n69), .D(n_state_7__N_353[4]), 
         .Z(n51)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(216[17:24])
    defparam i1_4_lut_adj_77.init = 16'heca0;
    LUT4 i1_3_lut_adj_78 (.A(n1940), .B(n13), .C(n14_adj_596), .Z(n2529)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_3_lut_adj_78.init = 16'hfefe;
    LUT4 temp1_7__I_0_406_i11_2_lut_3_lut_4_lut (.A(temp1[0]), .B(temp1[1]), 
         .C(temp1[3]), .D(temp1[2]), .Z(n11_adj_594)) /* synthesis lut_function=((B+(C+(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(350[13:23])
    defparam temp1_7__I_0_406_i11_2_lut_3_lut_4_lut.init = 16'hfffd;
    LUT4 n14_bdd_4_lut_3025 (.A(temp1[3]), .B(temp1[2]), .C(temp1[0]), 
         .D(temp1[1]), .Z(n4312)) /* synthesis lut_function=(A (B+!(C (D)))+!A (B+(C+!(D)))) */ ;
    defparam n14_bdd_4_lut_3025.init = 16'hdeff;
    LUT4 i961_4_lut (.A(n_temp1_7__N_74), .B(n_state_7__N_353[4]), .C(n_temp1_7__N_71), 
         .D(n1674), .Z(n2246)) /* synthesis lut_function=(A ((C+(D))+!B)+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i961_4_lut.init = 16'heae2;
    LUT4 i599_3_lut (.A(wb_dat_o[2]), .B(n_state_7__N_543[4]), .C(n1671), 
         .Z(n1674)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(1122[8] 1134[15])
    defparam i599_3_lut.init = 16'h4040;
    LUT4 i1_4_lut_adj_79 (.A(dat_count[7]), .B(n950), .C(n12), .D(n15), 
         .Z(n_dat_count[7])) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_79.init = 16'heca0;
    LUT4 i1_4_lut_adj_80 (.A(wb_dat_o[0]), .B(temp1[0]), .C(n4187), .D(n4221), 
         .Z(n_temp1[0])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_80.init = 16'ha0ec;
    LUT4 n14_bdd_3_lut_4_lut (.A(n14), .B(n14_adj_595), .C(n4475), .D(n4485), 
         .Z(n3175)) /* synthesis lut_function=(A (B+(C))+!A (B (D)+!B (C (D)))) */ ;
    defparam n14_bdd_3_lut_4_lut.init = 16'hfca8;
    LUT4 select_741_Select_7_i11_3_lut_4_lut (.A(n_temp1_7__N_58), .B(n_state_7__N_353[4]), 
         .C(n4175), .D(data0[7]), .Z(n_wb_dat_i[7])) /* synthesis lut_function=(A ((C (D))+!B)+!A (C (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam select_741_Select_7_i11_3_lut_4_lut.init = 16'hf222;
    LUT4 i1_4_lut_adj_81 (.A(dat_count[6]), .B(n951), .C(n12), .D(n15), 
         .Z(n_dat_count[6])) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_81.init = 16'heca0;
    LUT4 i1_4_lut_adj_82 (.A(dat_count[5]), .B(n952), .C(n12), .D(n15), 
         .Z(n_dat_count[5])) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_82.init = 16'heca0;
    LUT4 i1_4_lut_adj_83 (.A(dat_count[4]), .B(n953), .C(n12), .D(n15), 
         .Z(n_dat_count[4])) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_83.init = 16'heca0;
    LUT4 i3_4_lut_adj_84 (.A(n5), .B(n2), .C(dat_count[3]), .D(n2523), 
         .Z(n_dat_count[3])) /* synthesis lut_function=(A+(B+!((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i3_4_lut_adj_84.init = 16'heefe;
    LUT4 i1_4_lut_adj_85 (.A(n1_adj_600), .B(n_temp1_7__N_67), .C(n21), 
         .D(dat_count[3]), .Z(n5)) /* synthesis lut_function=(A+(B (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_85.init = 16'heeea;
    LUT4 select_747_Select_3_i2_4_lut (.A(n954), .B(dat_rdy_N_576), .C(dat_count[3]), 
         .D(n48), .Z(n2)) /* synthesis lut_function=(A (B (C+(D)))+!A !(((D)+!C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam select_747_Select_3_i2_4_lut.init = 16'h88c0;
    LUT4 i937_4_lut (.A(n_temp1_7__N_66), .B(n3186), .C(n1614), .D(n4_adj_597), 
         .Z(n2222)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i937_4_lut.init = 16'hb3a0;
    LUT4 i1_2_lut_adj_86 (.A(n69), .B(n_temp1_7__N_65), .Z(n4_adj_597)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_adj_86.init = 16'h8888;
    LUT4 i5_4_lut (.A(n_temp1_7__N_63), .B(n_temp1_7__N_66), .C(n_temp1_7__N_74), 
         .D(n_temp1_7__N_75), .Z(n13)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i5_4_lut.init = 16'hfffe;
    LUT4 i6_4_lut_adj_87 (.A(n_temp1_7__N_60), .B(n_temp1_7__N_73), .C(n_temp1_7__N_69), 
         .D(n_temp1_7__N_68), .Z(n14_adj_596)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i6_4_lut_adj_87.init = 16'hfffe;
    LUT4 select_747_Select_3_i1_4_lut (.A(dat_count[3]), .B(n_temp1_7__N_71), 
         .C(n954), .D(n1891), .Z(n1_adj_600)) /* synthesis lut_function=(A (B (C+!(D)))+!A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam select_747_Select_3_i1_4_lut.init = 16'hc088;
    LUT4 i3_4_lut_adj_88 (.A(n_temp1_7__N_61), .B(n_temp1_7__N_64), .C(n_temp1_7__N_62), 
         .D(n2522), .Z(n1940)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(661[6] 1176[10])
    defparam i3_4_lut_adj_88.init = 16'hfffe;
    LUT4 i2910_3_lut_4_lut (.A(n_temp1_7__N_64), .B(wb_ack_o), .C(wb_stb_i), 
         .D(n_temp1_7__N_63), .Z(n4221)) /* synthesis lut_function=(A (B (C))+!A (B (C (D)))) */ ;
    defparam i2910_3_lut_4_lut.init = 16'hc080;
    PFUMX i1239 (.BLUT(n4239), .ALUT(n2551), .C0(clk_enable_22), .Z(n2552));
    PFUMX i1244 (.BLUT(n4238), .ALUT(n2556), .C0(clk_enable_22), .Z(n2557));
    efb_vhdl dut (.clk(clk), .RST_N_N_584(RST_N_N_584), .wb_stb_i(wb_stb_i), 
            .wb_we_i(wb_we_i), .GND_net(GND_net), .\wb_adr_i[6] (wb_adr_i[6]), 
            .\wb_adr_i[2] (wb_adr_i[2]), .\wb_adr_i[1] (wb_adr_i[1]), .\wb_adr_i[0] (wb_adr_i[0]), 
            .wb_dat_i({wb_dat_i}), .\wb_dat_o[7] (wb_dat_o[7]), .\n_state_7__N_543[4] (n_state_7__N_543[4]), 
            .\wb_dat_o[5] (wb_dat_o[5]), .\wb_dat_o[4] (wb_dat_o[4]), .\wb_dat_o[3] (wb_dat_o[3]), 
            .\wb_dat_o[2] (wb_dat_o[2]), .\wb_dat_o[1] (wb_dat_o[1]), .\wb_dat_o[0] (wb_dat_o[0]), 
            .wb_ack_o(wb_ack_o), .i2c1_sdaoen(i2c1_sdaoen), .i2c1_sdao(i2c1_sdao), 
            .i2c1_scloen(i2c1_scloen), .i2c1_sclo(i2c1_sclo), .i2c1_sdai(i2c1_sdai), 
            .i2c1_scli(i2c1_scli), .VCC_net(VCC_net)) /* synthesis NGD_DRC_MASK=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(277[7:15])
    PFUMX i1229 (.BLUT(n4237), .ALUT(n2541), .C0(clk_enable_22), .Z(n2542));
    
endmodule
//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module efb_vhdl
//

module efb_vhdl (clk, RST_N_N_584, wb_stb_i, wb_we_i, GND_net, \wb_adr_i[6] , 
            \wb_adr_i[2] , \wb_adr_i[1] , \wb_adr_i[0] , wb_dat_i, \wb_dat_o[7] , 
            \n_state_7__N_543[4] , \wb_dat_o[5] , \wb_dat_o[4] , \wb_dat_o[3] , 
            \wb_dat_o[2] , \wb_dat_o[1] , \wb_dat_o[0] , wb_ack_o, i2c1_sdaoen, 
            i2c1_sdao, i2c1_scloen, i2c1_sclo, i2c1_sdai, i2c1_scli, 
            VCC_net) /* synthesis NGD_DRC_MASK=1 */ ;
    input clk;
    input RST_N_N_584;
    input wb_stb_i;
    input wb_we_i;
    input GND_net;
    input \wb_adr_i[6] ;
    input \wb_adr_i[2] ;
    input \wb_adr_i[1] ;
    input \wb_adr_i[0] ;
    input [7:0]wb_dat_i;
    output \wb_dat_o[7] ;
    output \n_state_7__N_543[4] ;
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
    
    wire clk /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(88[8:11])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/ipexpress/xo2/efb_vhdl.vhd(40[12:21])
    
    EFB EFBInst_0 (.WBCLKI(clk), .WBRSTI(RST_N_N_584), .WBCYCI(wb_stb_i), 
        .WBSTBI(wb_stb_i), .WBWEI(wb_we_i), .WBADRI0(\wb_adr_i[0] ), .WBADRI1(\wb_adr_i[1] ), 
        .WBADRI2(\wb_adr_i[2] ), .WBADRI3(GND_net), .WBADRI4(GND_net), 
        .WBADRI5(GND_net), .WBADRI6(\wb_adr_i[6] ), .WBADRI7(GND_net), 
        .WBDATI0(wb_dat_i[0]), .WBDATI1(wb_dat_i[1]), .WBDATI2(wb_dat_i[2]), 
        .WBDATI3(wb_dat_i[3]), .WBDATI4(wb_dat_i[4]), .WBDATI5(wb_dat_i[5]), 
        .WBDATI6(wb_dat_i[6]), .WBDATI7(wb_dat_i[7]), .I2C1SCLI(i2c1_scli), 
        .I2C1SDAI(i2c1_sdai), .I2C2SCLI(GND_net), .I2C2SDAI(GND_net), 
        .SPISCKI(GND_net), .SPIMISOI(GND_net), .SPIMOSII(GND_net), .SPISCSN(GND_net), 
        .TCCLKI(GND_net), .TCRSTN(GND_net), .TCIC(GND_net), .UFMSN(VCC_net), 
        .PLL0DATI0(GND_net), .PLL0DATI1(GND_net), .PLL0DATI2(GND_net), 
        .PLL0DATI3(GND_net), .PLL0DATI4(GND_net), .PLL0DATI5(GND_net), 
        .PLL0DATI6(GND_net), .PLL0DATI7(GND_net), .PLL0ACKI(GND_net), 
        .PLL1DATI0(GND_net), .PLL1DATI1(GND_net), .PLL1DATI2(GND_net), 
        .PLL1DATI3(GND_net), .PLL1DATI4(GND_net), .PLL1DATI5(GND_net), 
        .PLL1DATI6(GND_net), .PLL1DATI7(GND_net), .PLL1ACKI(GND_net), 
        .WBDATO0(\wb_dat_o[0] ), .WBDATO1(\wb_dat_o[1] ), .WBDATO2(\wb_dat_o[2] ), 
        .WBDATO3(\wb_dat_o[3] ), .WBDATO4(\wb_dat_o[4] ), .WBDATO5(\wb_dat_o[5] ), 
        .WBDATO6(\n_state_7__N_543[4] ), .WBDATO7(\wb_dat_o[7] ), .WBACKO(wb_ack_o), 
        .I2C1SCLO(i2c1_sclo), .I2C1SCLOEN(i2c1_scloen), .I2C1SDAO(i2c1_sdao), 
        .I2C1SDAOEN(i2c1_sdaoen)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=277, LSE_RLINE=277 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/source/i2c_gpio.vhd(277[7:15])
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
    defparam EFBInst_0.I2C1_SLAVE_ADDR = "0b0011001";
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
    
endmodule
