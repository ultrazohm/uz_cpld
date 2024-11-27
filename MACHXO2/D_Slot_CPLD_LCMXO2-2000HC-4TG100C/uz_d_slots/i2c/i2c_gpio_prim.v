// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Wed Nov 27 15:45:55 2024
//
// Verilog Description of module i2c_gpio
//

module i2c_gpio (SCL, SDA, GPO_0, IRQ, GPI_0, Enable, INTQ, RST_N);   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(60[8:16])
    inout SCL /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(75[1:4])
    inout SDA /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(76[1:4])
    output [7:0]GPO_0;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(77[1:6])
    input [3:0]IRQ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(78[1:4])
    input [7:0]GPI_0;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(79[1:6])
    output Enable;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(80[1:7])
    output INTQ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(81[1:5])
    input RST_N;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(82[1:6])
    
    wire IRQ_c_3 /* synthesis is_clock=1, SET_AS_NETWORK=IRQ_c_3 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(78[1:4])
    wire IRQ_c_2 /* synthesis is_clock=1, SET_AS_NETWORK=IRQ_c_2 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(78[1:4])
    wire IRQ_c_1 /* synthesis is_clock=1, SET_AS_NETWORK=IRQ_c_1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(78[1:4])
    wire IRQ_c_0 /* synthesis is_clock=1, SET_AS_NETWORK=IRQ_c_0 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(78[1:4])
    wire clk /* synthesis is_clock=1, SET_AS_NETWORK=clk */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(88[8:11])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/ipexpress/xo2/efb_vhdl.vhd(40[12:21])
    
    wire GND_net, VCC_net, GPO_0_c_7, GPO_0_c_6, GPO_0_c_5, GPO_0_c_4, 
        GPO_0_c_3, GPO_0_c_2, GPO_0_c_1, GPO_0_c_0, GPI_0_c_7, GPI_0_c_6, 
        GPI_0_c_5, GPI_0_c_4, GPI_0_c_3, GPI_0_c_2, GPI_0_c_1, GPI_0_c_0, 
        n2157, RST_N_c;
    wire [7:0]wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(172[8:16])
    
    wire wb_stb_i;
    wire [7:0]wb_adr_i;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(175[8:16])
    
    wire wb_we_i;
    wire [7:0]wb_dat_o;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(177[8:16])
    
    wire wb_ack_o;
    wire [7:0]data0;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(189[8:13])
    wire [7:0]temp1;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(190[14:19])
    
    wire n2215, n2211;
    wire [7:0]temp2;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(190[20:25])
    wire [7:0]temp3;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(190[26:31])
    wire [7:0]n_temp1;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(191[16:23])
    
    wire n6, n2205, n2203, n2201, n10, n15;
    wire [3:0]irq_en;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(192[8:14])
    wire [3:0]irq_status;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(192[17:27])
    wire [3:0]irq_clr;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(192[30:37])
    wire [3:0]irq_status_clr;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(192[39:53])
    
    wire reg_rdy, reg_rdy_del, dat_rdy, dat_rdy_del;
    wire [7:0]n_dat_count;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(199[8:19])
    wire [7:0]dat_count;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(199[22:31])
    wire [7:0]GPI_DAT;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(200[8:15])
    wire [7:0]n_wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(211[8:18])
    wire [7:0]n_wb_adr_i;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(213[8:18])
    
    wire n12, n_wb_we_i, check_irq_status, n3972, n127, n3971, reg_rdy_N_570, 
        dat_rdy_N_576, dat_rdy_N_574, i2c1_scloen, i2c1_sdao, i2c1_sdaoen, 
        n76, n17, n3, n83, n15_adj_591, n1, n12_adj_592, n15_adj_593, 
        n3770, n2873, n3846, n2044, n3970, clk_enable_16, clk_enable_19, 
        n3953, n12_adj_594, n3952, n2197, n3951, n3949, n3500, 
        n15_adj_595, n3834, n3948, n3773, n4, n4_adj_596, n1_adj_597, 
        n3488, n1695, n3460, n109, n132, n3947, clk_enable_12, 
        n111, n3458, n15_adj_598, n2191, n14, n3461, n3606, clk_enable_33, 
        n12_adj_599, n24, n27, n3968, n2018, n2017, clk_enable_13, 
        n3967, n15_adj_600, n2479, n12_adj_601, n6_adj_602, n1632, 
        n5, n4077, clk_enable_26, n15_adj_603, n1614, n3598, n3966, 
        n12_adj_604, n139, n3830, n3482, n950, n951, n952, n953, 
        n954, n955, n956, n957, n4_adj_605, n3965, n3964, n1986, 
        n2833, n1940, n15_adj_606, n12_adj_607, n14_adj_608;
    wire [7:0]n_dat_count_7__N_137;
    
    wire n3963;
    wire [7:0]n_state_7__N_543;
    
    wire n3962, n3749, n3961, n2223, n2225, n2016, n2015, n2014, 
        n_temp1_7__N_57, n_temp1_7__N_58, n_temp1_7__N_59, n_temp1_7__N_60, 
        n_temp1_7__N_61, n_temp1_7__N_62, n_temp1_7__N_63, n_temp1_7__N_64, 
        n_temp1_7__N_65, n_temp1_7__N_66, n_temp1_7__N_67, n_temp1_7__N_68, 
        n_temp1_7__N_69, i2c1_sclo, n_temp1_7__N_71, n_temp1_7__N_72, 
        n_temp1_7__N_73, n_temp1_7__N_74, n_temp1_7__N_75, i2c1_sdai, 
        n3960, n3959, n3522, n1801, n3640, n3468, n2461, n2, 
        n3610, n3459, n3758, n3818, n3812, n3806, n3958, n3790, 
        n3957, n4_adj_609, n3746, n3979, n6_adj_610, n3956, n9, 
        n3772, n10_adj_611, n3978, n3955, n3977, n3976, n3975, 
        n3954, n3904, n3728, n3903, n3902, n3755, n3974, n3973;
    
    VHI i2 (.Z(VCC_net));
    LUT4 i1_2_lut_rep_52 (.A(dat_rdy_N_576), .B(n_temp1_7__N_67), .Z(n3968)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_rep_52.init = 16'heeee;
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk)) /* synthesis NOM_FREQ="7", syn_instantiated=1 */ ;
    defparam OSCInst0.NOM_FREQ = "7";
    FD1P3IX GPI_DAT__i0 (.D(GPI_0_c_0), .SP(clk_enable_33), .CD(n3976), 
            .CK(clk), .Q(GPI_DAT[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(453[8] 459[15])
    defparam GPI_DAT__i0.GSR = "DISABLED";
    FD1S3IX dat_rdy_332 (.D(dat_rdy_N_574), .CK(clk), .CD(n3976), .Q(dat_rdy));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(322[7] 335[11])
    defparam dat_rdy_332.GSR = "DISABLED";
    FD1S3IX wb_stb_i_348 (.D(n_wb_adr_i[6]), .CK(clk), .CD(n3976), .Q(wb_stb_i));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_stb_i_348.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i5 (.D(n_wb_dat_i[5]), .CK(clk), .CD(n3976), .Q(wb_dat_i[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_dat_i__i5.GSR = "DISABLED";
    FD1P3IX temp2__i0 (.D(wb_dat_o[0]), .SP(reg_rdy_N_570), .CD(n3976), 
            .CK(clk), .Q(temp2[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp2__i0.GSR = "DISABLED";
    FD1S3IX wb_we_i_350 (.D(n_wb_we_i), .CK(clk), .CD(n3976), .Q(wb_we_i));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_we_i_350.GSR = "DISABLED";
    FD1P3IX temp3__i0 (.D(wb_dat_o[0]), .SP(dat_rdy_N_574), .CD(n3976), 
            .CK(clk), .Q(temp3[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp3__i0.GSR = "DISABLED";
    FD1P3IX irq_clr__i0 (.D(temp2[0]), .SP(clk_enable_16), .CD(n3976), 
            .CK(clk), .Q(irq_clr[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(534[1] 545[10])
    defparam irq_clr__i0.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i1 (.D(temp3[0]), .SP(clk_enable_13), .CD(n3976), 
            .CK(clk), .Q(GPO_0_c_0));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(410[8] 418[15])
    defparam GPO_DATA_0___i1.GSR = "DISABLED";
    FD1S3IX reg_rdy_330 (.D(reg_rdy_N_570), .CK(clk), .CD(n3976), .Q(reg_rdy));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(304[1] 317[9])
    defparam reg_rdy_330.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i0 (.D(n_wb_dat_i[0]), .CK(clk), .CD(n3976), .Q(wb_dat_i[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_dat_i__i0.GSR = "DISABLED";
    FD1P3IX data0__i0 (.D(n3949), .SP(clk_enable_26), .CD(n3976), .CK(clk), 
            .Q(data0[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(344[7] 357[14])
    defparam data0__i0.GSR = "DISABLED";
    FD1S3IX wb_adr_i__i1 (.D(n_wb_adr_i[0]), .CK(clk), .CD(n3976), .Q(wb_adr_i[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_adr_i__i1.GSR = "DISABLED";
    FD1S3IX dat_count__i0 (.D(n_dat_count[0]), .CK(clk), .CD(n3976), .Q(dat_count[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(621[1] 635[10])
    defparam dat_count__i0.GSR = "DISABLED";
    FD1S3IX dat_rdy_del_333 (.D(dat_rdy), .CK(clk), .CD(n3976), .Q(dat_rdy_del));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(322[7] 335[11])
    defparam dat_rdy_del_333.GSR = "DISABLED";
    LUT4 i1_2_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_68), 
         .D(wb_dat_o[2]), .Z(n3755)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i1_2_lut_3_lut_4_lut.init = 16'h8000;
    BB BB1_scl (.I(i2c1_sclo), .T(i2c1_scloen), .B(SCL), .O(i2c1_scli)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=277, LSE_RLINE=277 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/ipexpress/xo2/efb_vhdl.vhd(154[14:16])
    LUT4 i2488_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_63), 
         .D(n_temp1_7__N_64), .Z(n3812)) /* synthesis lut_function=(A (B (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i2488_3_lut_4_lut.init = 16'h8880;
    BB BB1_sda (.I(i2c1_sdao), .T(i2c1_sdaoen), .B(SDA), .O(i2c1_sdai)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=277, LSE_RLINE=277 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/ipexpress/xo2/efb_vhdl.vhd(150[14:16])
    CCU2D add_416_5 (.A0(dat_count[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3459), .COUT(n3460), .S0(n954), .S1(n953));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_416_5.INIT0 = 16'h5555;
    defparam add_416_5.INIT1 = 16'h5555;
    defparam add_416_5.INJECT1_0 = "NO";
    defparam add_416_5.INJECT1_1 = "NO";
    FD1P3IX irq_en__i0 (.D(temp2[0]), .SP(clk_enable_19), .CD(n3976), 
            .CK(clk), .Q(irq_en[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(534[1] 545[10])
    defparam irq_en__i0.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i4 (.D(n_wb_dat_i[4]), .CK(clk), .CD(n3976), .Q(wb_dat_i[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_dat_i__i4.GSR = "DISABLED";
    LUT4 i557_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_state_7__N_543[4]), 
         .D(wb_dat_o[4]), .Z(n1632)) /* synthesis lut_function=(!(A (B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i557_3_lut_4_lut.init = 16'h77f7;
    LUT4 i1_4_lut (.A(wb_dat_o[3]), .B(temp1[3]), .C(n3965), .D(n3812), 
         .Z(n_temp1[3])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut.init = 16'ha0ec;
    LUT4 i1_2_lut_3_lut_4_lut_adj_28 (.A(n15_adj_595), .B(n3), .C(clk_enable_12), 
         .D(n_temp1_7__N_74), .Z(n3773)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;
    defparam i1_2_lut_3_lut_4_lut_adj_28.init = 16'he000;
    LUT4 i1_4_lut_adj_29 (.A(wb_dat_o[4]), .B(temp1[4]), .C(n3965), .D(n3812), 
         .Z(n_temp1[4])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_29.init = 16'ha0ec;
    LUT4 i1_2_lut_3_lut_4_lut_adj_30 (.A(n15_adj_595), .B(n3), .C(n3971), 
         .D(n_temp1_7__N_74), .Z(n132)) /* synthesis lut_function=(!(A ((D)+!C)+!A (B ((D)+!C)+!B !(C)))) */ ;
    defparam i1_2_lut_3_lut_4_lut_adj_30.init = 16'h10f0;
    LUT4 i1_4_lut_adj_31 (.A(wb_dat_o[5]), .B(temp1[5]), .C(n3965), .D(n3812), 
         .Z(n_temp1[5])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_31.init = 16'ha0ec;
    LUT4 i2_3_lut_4_lut_4_lut (.A(n15_adj_595), .B(n3), .C(wb_dat_o[2]), 
         .D(n_temp1_7__N_74), .Z(n3772)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;
    defparam i2_3_lut_4_lut_4_lut.init = 16'h2000;
    FD1S3IX wb_dat_i__i3 (.D(n_wb_dat_i[3]), .CK(clk), .CD(n3976), .Q(wb_dat_i[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_dat_i__i3.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i2 (.D(n_wb_dat_i[2]), .CK(clk), .CD(n3976), .Q(wb_dat_i[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_dat_i__i2.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i1 (.D(n2225), .CK(clk), .CD(n3976), .Q(n_temp1_7__N_75));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i1.GSR = "DISABLED";
    LUT4 i1_4_lut_adj_32 (.A(n_state_7__N_543[4]), .B(temp1[6]), .C(n3965), 
         .D(n3812), .Z(n_temp1[6])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_32.init = 16'ha0ec;
    LUT4 i1_4_lut_adj_33 (.A(wb_dat_o[7]), .B(temp1[7]), .C(n3965), .D(n3812), 
         .Z(n_temp1[7])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_33.init = 16'ha0ec;
    LUT4 i868_2_lut (.A(temp1[5]), .B(temp1[6]), .Z(n2157)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;
    defparam i868_2_lut.init = 16'h6666;
    LUT4 i908_3_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_65), 
         .D(n_temp1_7__N_64), .Z(n2201)) /* synthesis lut_function=(A (B (D)+!B (C))+!A (C)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i908_3_lut_3_lut_4_lut.init = 16'hf870;
    LUT4 i922_2_lut_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_57), 
         .D(n_temp1_7__N_58), .Z(n2215)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A (C+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i922_2_lut_3_lut_4_lut.init = 16'hf7f0;
    LUT4 i1_2_lut_3_lut_4_lut_adj_34 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[5]), 
         .D(n_temp1_7__N_71), .Z(n_wb_dat_i[5])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_34.init = 16'h7000;
    LUT4 i1_2_lut_3_lut_4_lut_adj_35 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[4]), 
         .D(n_temp1_7__N_71), .Z(n_wb_dat_i[4])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_35.init = 16'h7000;
    LUT4 i653_2_lut_rep_49_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_64), 
         .Z(n3965)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i653_2_lut_rep_49_3_lut.init = 16'h8080;
    LUT4 i1_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(dat_rdy_N_576), 
         .Z(dat_rdy_N_574)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i1_2_lut_3_lut.init = 16'h8080;
    FD1S3AX reg_rdy_del_331 (.D(reg_rdy), .CK(clk), .Q(reg_rdy_del));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(304[1] 317[9])
    defparam reg_rdy_del_331.GSR = "DISABLED";
    LUT4 i1_2_lut_3_lut_adj_36 (.A(n15_adj_595), .B(n3), .C(n_temp1_7__N_74), 
         .Z(n6)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;
    defparam i1_2_lut_3_lut_adj_36.init = 16'h1010;
    LUT4 i620_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n3977), .D(n15_adj_595), 
         .Z(n1695)) /* synthesis lut_function=(((C (D))+!B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i620_3_lut_4_lut.init = 16'hf777;
    FD1S3AX c_state_FSM_i19 (.D(n3976), .CK(clk), .Q(n_temp1_7__N_57));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i19.GSR = "DISABLED";
    LUT4 i1_2_lut_3_lut_adj_37 (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_65), 
         .Z(n76)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i1_2_lut_3_lut_adj_37.init = 16'h8080;
    LUT4 i1_2_lut_3_lut_4_lut_adj_38 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[1]), 
         .D(n_temp1_7__N_71), .Z(n_wb_dat_i[1])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_38.init = 16'h7000;
    LUT4 select_745_Select_1_i2_2_lut_3_lut (.A(wb_ack_o), .B(wb_stb_i), 
         .C(n1940), .Z(n_wb_adr_i[1])) /* synthesis lut_function=(!(A (B+!(C))+!A !(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam select_745_Select_1_i2_2_lut_3_lut.init = 16'h7070;
    LUT4 i953_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n2461), .D(n_temp1_7__N_71), 
         .Z(n_wb_adr_i[2])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i953_3_lut_4_lut.init = 16'h7770;
    LUT4 i1_4_lut_adj_39 (.A(n_temp1_7__N_71), .B(dat_count[7]), .C(n950), 
         .D(n3955), .Z(n12_adj_594)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_39.init = 16'ha088;
    LUT4 i1_2_lut_rep_39_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n3), .Z(n3955)) /* synthesis lut_function=(!(((C)+!B)+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i1_2_lut_rep_39_3_lut.init = 16'h0808;
    LUT4 i1_2_lut_3_lut_4_lut_adj_40 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[0]), 
         .D(n_temp1_7__N_71), .Z(n_wb_dat_i[0])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_40.init = 16'h7000;
    LUT4 i2538_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n3830), .D(n_temp1_7__N_59), 
         .Z(n_wb_dat_i[2])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i2538_3_lut_4_lut.init = 16'h7770;
    LUT4 i588_2_lut_rep_48_3_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n_state_7__N_543[4]), 
         .Z(n3964)) /* synthesis lut_function=(((C)+!B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i588_2_lut_rep_48_3_lut.init = 16'hf7f7;
    LUT4 i1_2_lut_3_lut_adj_41 (.A(wb_ack_o), .B(wb_stb_i), .C(n_temp1_7__N_67), 
         .Z(reg_rdy_N_570)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i1_2_lut_3_lut_adj_41.init = 16'h8080;
    LUT4 i977_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n3962), .D(n2461), 
         .Z(n_wb_adr_i[6])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i977_3_lut_4_lut.init = 16'h7770;
    LUT4 i1_2_lut_3_lut_4_lut_adj_42 (.A(wb_ack_o), .B(wb_stb_i), .C(data0[6]), 
         .D(n_temp1_7__N_71), .Z(n_wb_dat_i[6])) /* synthesis lut_function=(!(A (B+!(C (D)))+!A !(C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i1_2_lut_3_lut_4_lut_adj_42.init = 16'h7000;
    FD1S3IX wb_dat_i__i1 (.D(n_wb_dat_i[1]), .CK(clk), .CD(n3976), .Q(wb_dat_i[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_dat_i__i1.GSR = "DISABLED";
    LUT4 equal_24_i10_2_lut_rep_54 (.A(temp1[2]), .B(temp1[3]), .Z(n3970)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(352[13:23])
    defparam equal_24_i10_2_lut_rep_54.init = 16'hdddd;
    LUT4 i2506_4_lut (.A(data0[2]), .B(n_temp1_7__N_65), .C(n_temp1_7__N_71), 
         .D(n_temp1_7__N_72), .Z(n3830)) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;
    defparam i2506_4_lut.init = 16'hffec;
    FD1S3IX temp1__i0 (.D(n_temp1[0]), .CK(clk), .CD(n3976), .Q(temp1[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp1__i0.GSR = "DISABLED";
    LUT4 i2_3_lut_rep_43_4_lut (.A(temp1[2]), .B(temp1[3]), .C(temp1[0]), 
         .D(n3963), .Z(n3959)) /* synthesis lut_function=((B+(C+(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(352[13:23])
    defparam i2_3_lut_rep_43_4_lut.init = 16'hfffd;
    LUT4 i932_4_lut (.A(n_temp1_7__N_75), .B(dat_rdy_N_576), .C(n1695), 
         .D(n2833), .Z(n2225)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i932_4_lut.init = 16'heca0;
    LUT4 i2520_4_lut (.A(dat_count[0]), .B(n3834), .C(n10), .D(dat_count[6]), 
         .Z(n15_adj_595)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i2520_4_lut.init = 16'hfffe;
    LUT4 i2510_4_lut (.A(dat_count[3]), .B(dat_count[1]), .C(dat_count[5]), 
         .D(dat_count[7]), .Z(n3834)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i2510_4_lut.init = 16'hfffe;
    LUT4 i2_2_lut (.A(dat_count[2]), .B(dat_count[4]), .Z(n10)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(1122[13:35])
    defparam i2_2_lut.init = 16'heeee;
    FD1P3IX GPO_DATA_0___i8 (.D(temp3[7]), .SP(clk_enable_13), .CD(n3976), 
            .CK(clk), .Q(GPO_0_c_7));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(410[8] 418[15])
    defparam GPO_DATA_0___i8.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i7 (.D(temp3[6]), .SP(clk_enable_13), .CD(n3976), 
            .CK(clk), .Q(GPO_0_c_6));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(410[8] 418[15])
    defparam GPO_DATA_0___i7.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i6 (.D(temp3[5]), .SP(clk_enable_13), .CD(n3976), 
            .CK(clk), .Q(GPO_0_c_5));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(410[8] 418[15])
    defparam GPO_DATA_0___i6.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i5 (.D(temp3[4]), .SP(clk_enable_13), .CD(n3976), 
            .CK(clk), .Q(GPO_0_c_4));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(410[8] 418[15])
    defparam GPO_DATA_0___i5.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i4 (.D(temp3[3]), .SP(clk_enable_13), .CD(n3976), 
            .CK(clk), .Q(GPO_0_c_3));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(410[8] 418[15])
    defparam GPO_DATA_0___i4.GSR = "DISABLED";
    FD1P3IX GPO_DATA_0___i3 (.D(temp3[2]), .SP(clk_enable_13), .CD(n3976), 
            .CK(clk), .Q(GPO_0_c_2));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(410[8] 418[15])
    defparam GPO_DATA_0___i3.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i18 (.D(n2215), .CK(clk), .CD(n3976), .Q(n_temp1_7__N_58));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i18.GSR = "DISABLED";
    LUT4 i1_3_lut_4_lut (.A(n3958), .B(clk_enable_12), .C(n_temp1_7__N_67), 
         .D(n3790), .Z(n17)) /* synthesis lut_function=(!(A (B (D)+!B !(C+!(D)))+!A !(C+!(D)))) */ ;
    defparam i1_3_lut_4_lut.init = 16'h70ff;
    CCU2D add_416_3 (.A0(dat_count[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3458), .COUT(n3459), .S0(n956), .S1(n955));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_416_3.INIT0 = 16'h5555;
    defparam add_416_3.INIT1 = 16'h5555;
    defparam add_416_3.INJECT1_0 = "NO";
    defparam add_416_3.INJECT1_1 = "NO";
    GSR GSR_INST (.GSR(irq_status_clr[3]));
    LUT4 i1_4_lut_adj_43 (.A(wb_dat_o[0]), .B(temp1[0]), .C(n3965), .D(n3812), 
         .Z(n_temp1[0])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_43.init = 16'ha0ec;
    FD1S3IX c_state_FSM_i17 (.D(n109), .CK(clk), .CD(n3976), .Q(n_temp1_7__N_59));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i17.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i16 (.D(n2211), .CK(clk), .CD(n3976), .Q(n_temp1_7__N_60));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i16.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i15 (.D(n3728), .CK(clk), .CD(n3976), .Q(n_temp1_7__N_61));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i15.GSR = "DISABLED";
    FD1S3IX wb_dat_i__i7 (.D(n_wb_dat_i[7]), .CK(clk), .CD(n3976), .Q(wb_dat_i[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_dat_i__i7.GSR = "DISABLED";
    LUT4 i2532_2_lut (.A(irq_clr[3]), .B(RST_N_c), .Z(irq_status_clr[3])) /* synthesis lut_function=(!(A+!(B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(500[30:51])
    defparam i2532_2_lut.init = 16'h4444;
    LUT4 i160_4_lut (.A(n_temp1_7__N_59), .B(n_temp1_7__N_58), .C(clk_enable_12), 
         .D(n111), .Z(n109)) /* synthesis lut_function=(A (B+!(C (D)))+!A (B (C)+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i160_4_lut.init = 16'hcafa;
    FD1S3IX wb_dat_i__i6 (.D(n_wb_dat_i[6]), .CK(clk), .CD(n3976), .Q(wb_dat_i[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_dat_i__i6.GSR = "DISABLED";
    FD1P3IX c_state_FSM_i14 (.D(n_temp1_7__N_61), .SP(clk_enable_12), .CD(n3976), 
            .CK(clk), .Q(n_temp1_7__N_62));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i14.GSR = "DISABLED";
    LUT4 i1_4_lut_adj_44 (.A(n_state_7__N_543[4]), .B(n_temp1_7__N_73), 
         .C(n127), .D(n139), .Z(n111)) /* synthesis lut_function=(A+!(B+!(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_44.init = 16'hbbba;
    FD1P3IX GPO_DATA_0___i2 (.D(temp3[1]), .SP(clk_enable_13), .CD(n3976), 
            .CK(clk), .Q(GPO_0_c_1));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(410[8] 418[15])
    defparam GPO_DATA_0___i2.GSR = "DISABLED";
    FD1P3IX irq_clr__i3 (.D(temp2[3]), .SP(clk_enable_16), .CD(n3976), 
            .CK(clk), .Q(irq_clr[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(534[1] 545[10])
    defparam irq_clr__i3.GSR = "DISABLED";
    FD1P3IX irq_clr__i2 (.D(temp2[2]), .SP(clk_enable_16), .CD(n3976), 
            .CK(clk), .Q(irq_clr[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(534[1] 545[10])
    defparam irq_clr__i2.GSR = "DISABLED";
    FD1P3IX irq_clr__i1 (.D(temp2[1]), .SP(clk_enable_16), .CD(n3976), 
            .CK(clk), .Q(irq_clr[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(534[1] 545[10])
    defparam irq_clr__i1.GSR = "DISABLED";
    LUT4 i2_4_lut (.A(n132), .B(n_temp1_7__N_68), .C(n4_adj_605), .D(n_temp1_7__N_66), 
         .Z(n139)) /* synthesis lut_function=(!((B+(C+(D)))+!A)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2_4_lut.init = 16'h0002;
    FD1P3IX temp3__i7 (.D(wb_dat_o[7]), .SP(dat_rdy_N_574), .CD(n3976), 
            .CK(clk), .Q(temp3[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp3__i7.GSR = "DISABLED";
    FD1P3IX temp3__i6 (.D(n_state_7__N_543[4]), .SP(dat_rdy_N_574), .CD(n3976), 
            .CK(clk), .Q(temp3[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp3__i6.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i13 (.D(n2205), .CK(clk), .CD(n3976), .Q(n_temp1_7__N_63));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i13.GSR = "DISABLED";
    LUT4 i1_2_lut (.A(n_temp1_7__N_75), .B(n15_adj_595), .Z(n4_adj_605)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(1155[5] 1163[15])
    defparam i1_2_lut.init = 16'h8888;
    LUT4 i1550_2_lut (.A(irq_en[3]), .B(temp1[0]), .Z(n2044)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(349[6] 355[15])
    defparam i1550_2_lut.init = 16'heeee;
    CCU2D add_416_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n3458), .S1(n957));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_416_1.INIT0 = 16'hF000;
    defparam add_416_1.INIT1 = 16'h5555;
    defparam add_416_1.INJECT1_0 = "NO";
    defparam add_416_1.INJECT1_1 = "NO";
    FD1S3IX c_state_FSM_i12 (.D(n2203), .CK(clk), .CD(n3976), .Q(n_temp1_7__N_64));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i12.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i11 (.D(n2201), .CK(clk), .CD(n3976), .Q(n_temp1_7__N_65));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i11.GSR = "DISABLED";
    LUT4 mux_753_i4_3_lut (.A(GPI_DAT[3]), .B(irq_status[3]), .C(temp1[5]), 
         .Z(n1986)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(349[6] 355[15])
    defparam mux_753_i4_3_lut.init = 16'hcaca;
    FD1S3IX c_state_FSM_i10 (.D(n3640), .CK(clk), .CD(n3976), .Q(n_temp1_7__N_66));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i10.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i9 (.D(n2197), .CK(clk), .CD(n3976), .Q(n_temp1_7__N_67));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i9.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i8 (.D(n3500), .CK(clk), .CD(n3976), .Q(n_temp1_7__N_68));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i8.GSR = "DISABLED";
    FD1P3IX temp3__i5 (.D(wb_dat_o[5]), .SP(dat_rdy_N_574), .CD(n3976), 
            .CK(clk), .Q(temp3[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp3__i5.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i7 (.D(n2191), .CK(clk), .CD(n3976), .Q(n_temp1_7__N_69));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i7.GSR = "DISABLED";
    OB GPO_0_pad_7 (.I(GPO_0_c_7), .O(GPO_0[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(77[1:6])
    LUT4 i11_4_lut (.A(n_temp1_7__N_61), .B(n_temp1_7__N_60), .C(clk_enable_12), 
         .D(n_state_7__N_543[4]), .Z(n3728)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i11_4_lut.init = 16'h0aca;
    FD1S3IX c_state_FSM_i6 (.D(n3522), .CK(clk), .CD(n3976), .Q(dat_rdy_N_576));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i6.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i5 (.D(n3610), .CK(clk), .CD(n3976), .Q(n_temp1_7__N_71));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i5.GSR = "DISABLED";
    FD1S3IX c_state_FSM_i4 (.D(n3606), .CK(clk), .CD(n3976), .Q(n_temp1_7__N_72));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i4.GSR = "DISABLED";
    LUT4 i2522_4_lut_then_4_lut (.A(n14), .B(temp1[3]), .C(temp1[1]), 
         .D(temp1[0]), .Z(n3979)) /* synthesis lut_function=(A+(B+(C+!(D)))) */ ;
    defparam i2522_4_lut_then_4_lut.init = 16'hfeff;
    LUT4 i2_2_lut_rep_45_3_lut_4_lut (.A(temp1[2]), .B(temp1[3]), .C(n14), 
         .D(n3973), .Z(n3961)) /* synthesis lut_function=((B+(C+(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(352[13:23])
    defparam i2_2_lut_rep_45_3_lut_4_lut.init = 16'hfffd;
    FD1S3IX c_state_FSM_i3 (.D(n3598), .CK(clk), .CD(n3976), .Q(n_temp1_7__N_73));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i3.GSR = "DISABLED";
    LUT4 i2522_4_lut_else_4_lut (.A(n14), .B(temp1[3]), .C(temp1[1]), 
         .D(temp1[0]), .Z(n3978)) /* synthesis lut_function=(A+(((D)+!C)+!B)) */ ;
    defparam i2522_4_lut_else_4_lut.init = 16'hffbf;
    FD1S3IX c_state_FSM_i2 (.D(n2223), .CK(clk), .CD(n3976), .Q(n_temp1_7__N_74));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam c_state_FSM_i2.GSR = "DISABLED";
    FD1P3IX temp3__i4 (.D(wb_dat_o[4]), .SP(dat_rdy_N_574), .CD(n3976), 
            .CK(clk), .Q(temp3[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp3__i4.GSR = "DISABLED";
    LUT4 mux_769_i8_4_lut (.A(GPI_DAT[7]), .B(temp1[0]), .C(temp1[1]), 
         .D(temp1[5]), .Z(n2014)) /* synthesis lut_function=(A (B (C+!(D))+!B !(C+(D)))+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(349[6] 355[15])
    defparam mux_769_i8_4_lut.init = 16'hc0ca;
    CCU2D add_416_9 (.A0(dat_count[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n3461), 
          .S0(n950));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_416_9.INIT0 = 16'h5555;
    defparam add_416_9.INIT1 = 16'h0000;
    defparam add_416_9.INJECT1_0 = "NO";
    defparam add_416_9.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_55 (.A(wb_dat_o[4]), .B(n_temp1_7__N_69), .Z(n3971)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_rep_55.init = 16'hbbbb;
    FD1P3IX temp3__i3 (.D(wb_dat_o[3]), .SP(dat_rdy_N_574), .CD(n3976), 
            .CK(clk), .Q(temp3[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp3__i3.GSR = "DISABLED";
    LUT4 i1_2_lut_3_lut_adj_45 (.A(dat_rdy_N_576), .B(n_temp1_7__N_67), 
         .C(n_temp1_7__N_71), .Z(n3790)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_3_lut_adj_45.init = 16'hfefe;
    FD1P3DX irq_status_2__343 (.D(n4077), .SP(irq_en[2]), .CK(IRQ_c_2), 
            .CD(irq_status_clr[2]), .Q(irq_status[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(501[7] 507[23])
    defparam irq_status_2__343.GSR = "DISABLED";
    LUT4 i1_2_lut_3_lut_adj_46 (.A(wb_dat_o[4]), .B(n_temp1_7__N_69), .C(wb_dat_o[2]), 
         .Z(n127)) /* synthesis lut_function=(A (C)+!A !(B+!(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_3_lut_adj_46.init = 16'hb0b0;
    LUT4 wb_ack_o_I_0_2_lut_rep_53 (.A(wb_ack_o), .B(wb_stb_i), .Z(clk_enable_12)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam wb_ack_o_I_0_2_lut_rep_53.init = 16'h8888;
    LUT4 i3_4_lut (.A(temp2[0]), .B(n3963), .C(dat_rdy_del), .D(n3975), 
         .Z(n3749)) /* synthesis lut_function=(!(A+(B+((D)+!C)))) */ ;
    defparam i3_4_lut.init = 16'h0010;
    LUT4 i1_4_lut_adj_47 (.A(wb_dat_o[1]), .B(temp1[1]), .C(n3965), .D(n3812), 
         .Z(n_temp1[1])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_47.init = 16'ha0ec;
    FD1P3AX irq_status_3__344 (.D(n4077), .SP(irq_en[3]), .CK(IRQ_c_3), 
            .Q(irq_status[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(501[7] 507[23])
    defparam irq_status_3__344.GSR = "ENABLED";
    LUT4 i2536_4_lut (.A(irq_status[0]), .B(irq_status[3]), .C(irq_status[2]), 
         .D(irq_status[1]), .Z(check_irq_status)) /* synthesis lut_function=(!(A+(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(477[4] 488[16])
    defparam i2536_4_lut.init = 16'h0001;
    FD1P3DX irq_status_1__342 (.D(n4077), .SP(irq_en[1]), .CK(IRQ_c_1), 
            .CD(irq_status_clr[1]), .Q(irq_status[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(501[7] 507[23])
    defparam irq_status_1__342.GSR = "DISABLED";
    FD1P3DX irq_status_0__341 (.D(n4077), .SP(irq_en[0]), .CK(IRQ_c_0), 
            .CD(irq_status_clr[0]), .Q(irq_status[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(501[7] 507[23])
    defparam irq_status_0__341.GSR = "DISABLED";
    FD1P3IX irq_en__i3 (.D(temp2[3]), .SP(clk_enable_19), .CD(n3976), 
            .CK(clk), .Q(irq_en[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(534[1] 545[10])
    defparam irq_en__i3.GSR = "DISABLED";
    LUT4 i2494_2_lut_4_lut (.A(n3), .B(n3958), .C(n3957), .D(n3846), 
         .Z(n3818)) /* synthesis lut_function=(A (B (C+!(D))+!B !(D))+!A !(D)) */ ;
    defparam i2494_2_lut_4_lut.init = 16'h80ff;
    LUT4 i2_3_lut_4_lut (.A(n3958), .B(clk_enable_12), .C(n4_adj_596), 
         .D(n_temp1_7__N_67), .Z(n3500)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (C)) */ ;
    defparam i2_3_lut_4_lut.init = 16'hf8f0;
    LUT4 i1_4_lut_adj_48 (.A(wb_dat_o[2]), .B(temp1[2]), .C(n3965), .D(n3812), 
         .Z(n_temp1[2])) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_48.init = 16'ha0ec;
    LUT4 i3_3_lut_4_lut (.A(n3846), .B(n3954), .C(n3959), .D(n_temp1_7__N_65), 
         .Z(n3468)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(191[16:23])
    defparam i3_3_lut_4_lut.init = 16'h8000;
    LUT4 i1_3_lut_4_lut_adj_49 (.A(n3846), .B(n3954), .C(n76), .D(n3959), 
         .Z(n1801)) /* synthesis lut_function=(A (B (C)+!B !((D)+!C))+!A !((D)+!C)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(191[16:23])
    defparam i1_3_lut_4_lut_adj_49.init = 16'h80f0;
    LUT4 mux_247_i4_3_lut_4_lut (.A(clk_enable_12), .B(n3), .C(n954), 
         .D(dat_count[3]), .Z(n_dat_count_7__N_137[3])) /* synthesis lut_function=(A (B (D)+!B (C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam mux_247_i4_3_lut_4_lut.init = 16'hfd20;
    LUT4 i43_4_lut_3_lut (.A(temp1[0]), .B(temp1[6]), .C(temp1[5]), .Z(n24)) /* synthesis lut_function=(!(A (B+(C))+!A !(B (C)))) */ ;
    defparam i43_4_lut_3_lut.init = 16'h4242;
    LUT4 i2_3_lut_3_lut (.A(temp1[2]), .B(n24), .C(temp1[1]), .Z(n3488)) /* synthesis lut_function=(!(A+!(B (C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(352[13:23])
    defparam i2_3_lut_3_lut.init = 16'h4040;
    LUT4 i3_4_lut_adj_50 (.A(temp1[2]), .B(temp1[1]), .C(temp1[0]), .D(n2157), 
         .Z(n3482)) /* synthesis lut_function=(!((B+((D)+!C))+!A)) */ ;
    defparam i3_4_lut_adj_50.init = 16'h0020;
    LUT4 i955_3_lut_4_lut (.A(wb_ack_o), .B(wb_stb_i), .C(n3746), .D(n2461), 
         .Z(n_wb_adr_i[0])) /* synthesis lut_function=(!(A (B+!(C+(D)))+!A !(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(807[12:33])
    defparam i955_3_lut_4_lut.init = 16'h7770;
    LUT4 i1_2_lut_rep_56 (.A(temp1[4]), .B(temp1[7]), .Z(n3972)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_rep_56.init = 16'heeee;
    LUT4 i2_3_lut_rep_47_4_lut (.A(temp1[4]), .B(temp1[7]), .C(temp1[5]), 
         .D(temp1[6]), .Z(n3963)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i2_3_lut_rep_47_4_lut.init = 16'hfffe;
    LUT4 i2_3_lut_4_lut_adj_51 (.A(temp1[4]), .B(temp1[7]), .C(temp1[5]), 
         .D(temp1[6]), .Z(n14)) /* synthesis lut_function=(A+(B+!(C (D)))) */ ;
    defparam i2_3_lut_4_lut_adj_51.init = 16'hefff;
    LUT4 i1_4_lut_adj_52 (.A(n3758), .B(n_temp1_7__N_66), .C(n3818), .D(n1614), 
         .Z(n3640)) /* synthesis lut_function=(A (B ((D)+!C)+!B !(C))+!A (B (D))) */ ;
    defparam i1_4_lut_adj_52.init = 16'hce0a;
    LUT4 temp1_0__bdd_2_lut_2559 (.A(temp1[0]), .B(irq_en[0]), .Z(n3947)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam temp1_0__bdd_2_lut_2559.init = 16'h4444;
    LUT4 equal_25_i9_2_lut_rep_57 (.A(temp1[0]), .B(temp1[1]), .Z(n3973)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(353[13:23])
    defparam equal_25_i9_2_lut_rep_57.init = 16'hbbbb;
    LUT4 i1_2_lut_rep_50_3_lut_4_lut (.A(temp1[0]), .B(temp1[1]), .C(temp1[3]), 
         .D(temp1[2]), .Z(n3966)) /* synthesis lut_function=(A+((C+!(D))+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(353[13:23])
    defparam i1_2_lut_rep_50_3_lut_4_lut.init = 16'hfbff;
    FD1P3IX irq_en__i2 (.D(temp2[2]), .SP(clk_enable_19), .CD(n3976), 
            .CK(clk), .Q(irq_en[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(534[1] 545[10])
    defparam irq_en__i2.GSR = "DISABLED";
    FD1P3IX irq_en__i1 (.D(temp2[1]), .SP(clk_enable_19), .CD(n3976), 
            .CK(clk), .Q(irq_en[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(534[1] 545[10])
    defparam irq_en__i1.GSR = "DISABLED";
    FD1S3IX dat_count__i7 (.D(n_dat_count[7]), .CK(clk), .CD(n3976), .Q(dat_count[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(621[1] 635[10])
    defparam dat_count__i7.GSR = "DISABLED";
    FD1S3IX dat_count__i6 (.D(n_dat_count[6]), .CK(clk), .CD(n3976), .Q(dat_count[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(621[1] 635[10])
    defparam dat_count__i6.GSR = "DISABLED";
    FD1S3IX dat_count__i5 (.D(n_dat_count[5]), .CK(clk), .CD(n3976), .Q(dat_count[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(621[1] 635[10])
    defparam dat_count__i5.GSR = "DISABLED";
    FD1S3IX dat_count__i4 (.D(n_dat_count[4]), .CK(clk), .CD(n3976), .Q(dat_count[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(621[1] 635[10])
    defparam dat_count__i4.GSR = "DISABLED";
    FD1S3IX dat_count__i3 (.D(n_dat_count[3]), .CK(clk), .CD(n3976), .Q(dat_count[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(621[1] 635[10])
    defparam dat_count__i3.GSR = "DISABLED";
    FD1S3IX dat_count__i2 (.D(n_dat_count[2]), .CK(clk), .CD(n3976), .Q(dat_count[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(621[1] 635[10])
    defparam dat_count__i2.GSR = "DISABLED";
    FD1S3IX dat_count__i1 (.D(n_dat_count[1]), .CK(clk), .CD(n3976), .Q(dat_count[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(621[1] 635[10])
    defparam dat_count__i1.GSR = "DISABLED";
    LUT4 temp1_0__bdd_3_lut_2556 (.A(GPI_DAT[2]), .B(irq_status[2]), .C(temp1[5]), 
         .Z(n3903)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam temp1_0__bdd_3_lut_2556.init = 16'hcaca;
    FD1S3IX wb_adr_i__i3 (.D(n_wb_adr_i[2]), .CK(clk), .CD(n3976), .Q(wb_adr_i[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_adr_i__i3.GSR = "DISABLED";
    FD1S3IX wb_adr_i__i2 (.D(n_wb_adr_i[1]), .CK(clk), .CD(n3976), .Q(wb_adr_i[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(600[1] 616[10])
    defparam wb_adr_i__i2.GSR = "DISABLED";
    FD1P3IX data0__i7 (.D(n2014), .SP(clk_enable_26), .CD(n3976), .CK(clk), 
            .Q(data0[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(344[7] 357[14])
    defparam data0__i7.GSR = "DISABLED";
    FD1P3IX data0__i6 (.D(n2015), .SP(clk_enable_26), .CD(n3976), .CK(clk), 
            .Q(data0[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(344[7] 357[14])
    defparam data0__i6.GSR = "DISABLED";
    FD1P3IX data0__i5 (.D(n2016), .SP(clk_enable_26), .CD(n3976), .CK(clk), 
            .Q(data0[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(344[7] 357[14])
    defparam data0__i5.GSR = "DISABLED";
    FD1P3IX data0__i4 (.D(n2017), .SP(clk_enable_26), .CD(n3976), .CK(clk), 
            .Q(data0[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(344[7] 357[14])
    defparam data0__i4.GSR = "DISABLED";
    FD1P3IX data0__i3 (.D(n2018), .SP(clk_enable_26), .CD(n3976), .CK(clk), 
            .Q(data0[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(344[7] 357[14])
    defparam data0__i3.GSR = "DISABLED";
    FD1P3IX data0__i2 (.D(n3904), .SP(clk_enable_26), .CD(n3976), .CK(clk), 
            .Q(data0[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(344[7] 357[14])
    defparam data0__i2.GSR = "DISABLED";
    FD1P3IX data0__i1 (.D(n3953), .SP(clk_enable_26), .CD(n3976), .CK(clk), 
            .Q(data0[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(344[7] 357[14])
    defparam data0__i1.GSR = "DISABLED";
    FD1P3IX temp3__i2 (.D(wb_dat_o[2]), .SP(dat_rdy_N_574), .CD(n3976), 
            .CK(clk), .Q(temp3[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp3__i2.GSR = "DISABLED";
    LUT4 equal_22_i9_2_lut_rep_58 (.A(temp1[0]), .B(temp1[1]), .Z(n3974)) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(350[13:23])
    defparam equal_22_i9_2_lut_rep_58.init = 16'hdddd;
    FD1P3IX temp3__i1 (.D(wb_dat_o[1]), .SP(dat_rdy_N_574), .CD(n3976), 
            .CK(clk), .Q(temp3[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp3__i1.GSR = "DISABLED";
    FD1P3IX temp2__i3 (.D(wb_dat_o[3]), .SP(reg_rdy_N_570), .CD(n3976), 
            .CK(clk), .Q(temp2[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp2__i3.GSR = "DISABLED";
    FD1P3IX temp2__i2 (.D(wb_dat_o[2]), .SP(reg_rdy_N_570), .CD(n3976), 
            .CK(clk), .Q(temp2[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp2__i2.GSR = "DISABLED";
    FD1P3IX temp2__i1 (.D(wb_dat_o[1]), .SP(reg_rdy_N_570), .CD(n3976), 
            .CK(clk), .Q(temp2[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp2__i1.GSR = "DISABLED";
    FD1P3IX GPI_DAT__i7 (.D(GPI_0_c_7), .SP(clk_enable_33), .CD(n3976), 
            .CK(clk), .Q(GPI_DAT[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(453[8] 459[15])
    defparam GPI_DAT__i7.GSR = "DISABLED";
    FD1P3IX GPI_DAT__i6 (.D(GPI_0_c_6), .SP(clk_enable_33), .CD(n3976), 
            .CK(clk), .Q(GPI_DAT[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(453[8] 459[15])
    defparam GPI_DAT__i6.GSR = "DISABLED";
    FD1P3IX GPI_DAT__i5 (.D(GPI_0_c_5), .SP(clk_enable_33), .CD(n3976), 
            .CK(clk), .Q(GPI_DAT[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(453[8] 459[15])
    defparam GPI_DAT__i5.GSR = "DISABLED";
    FD1P3IX GPI_DAT__i4 (.D(GPI_0_c_4), .SP(clk_enable_33), .CD(n3976), 
            .CK(clk), .Q(GPI_DAT[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(453[8] 459[15])
    defparam GPI_DAT__i4.GSR = "DISABLED";
    FD1P3IX GPI_DAT__i3 (.D(GPI_0_c_3), .SP(clk_enable_33), .CD(n3976), 
            .CK(clk), .Q(GPI_DAT[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(453[8] 459[15])
    defparam GPI_DAT__i3.GSR = "DISABLED";
    FD1P3IX GPI_DAT__i2 (.D(GPI_0_c_2), .SP(clk_enable_33), .CD(n3976), 
            .CK(clk), .Q(GPI_DAT[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(453[8] 459[15])
    defparam GPI_DAT__i2.GSR = "DISABLED";
    FD1P3IX GPI_DAT__i1 (.D(GPI_0_c_1), .SP(clk_enable_33), .CD(n3976), 
            .CK(clk), .Q(GPI_DAT[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(453[8] 459[15])
    defparam GPI_DAT__i1.GSR = "DISABLED";
    FD1S3IX temp1__i1 (.D(n_temp1[1]), .CK(clk), .CD(n3976), .Q(temp1[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp1__i1.GSR = "DISABLED";
    LUT4 temp1_0__bdd_3_lut_2560 (.A(GPI_DAT[0]), .B(irq_status[0]), .C(temp1[5]), 
         .Z(n3948)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam temp1_0__bdd_3_lut_2560.init = 16'hcaca;
    OB GPO_0_pad_6 (.I(GPO_0_c_6), .O(GPO_0[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(77[1:6])
    OB GPO_0_pad_5 (.I(GPO_0_c_5), .O(GPO_0[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(77[1:6])
    OB GPO_0_pad_4 (.I(GPO_0_c_4), .O(GPO_0[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(77[1:6])
    OB GPO_0_pad_3 (.I(GPO_0_c_3), .O(GPO_0[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(77[1:6])
    OB GPO_0_pad_2 (.I(GPO_0_c_2), .O(GPO_0[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(77[1:6])
    OB GPO_0_pad_1 (.I(GPO_0_c_1), .O(GPO_0[1]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(77[1:6])
    OB GPO_0_pad_0 (.I(GPO_0_c_0), .O(GPO_0[0]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(77[1:6])
    OB Enable_pad (.I(GND_net), .O(Enable));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(80[1:7])
    OBZ INTQ_pad (.I(GND_net), .T(check_irq_status), .O(INTQ));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(477[4] 488[16])
    LUT4 temp1_0__bdd_2_lut (.A(temp1[0]), .B(irq_en[1]), .Z(n3951)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam temp1_0__bdd_2_lut.init = 16'h4444;
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
    LUT4 i1_2_lut_rep_41_3_lut_4_lut (.A(temp1[0]), .B(temp1[1]), .C(temp1[3]), 
         .D(n3963), .Z(n3957)) /* synthesis lut_function=((B+(C+(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(350[13:23])
    defparam i1_2_lut_rep_41_3_lut_4_lut.init = 16'hfffd;
    CCU2D add_416_7 (.A0(dat_count[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(dat_count[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n3460), .COUT(n3461), .S0(n952), .S1(n951));   // C:/lscc/diamond/3.13/ispfpga/vhdl_packages/syn_unsi.vhd(168[20:31])
    defparam add_416_7.INIT0 = 16'h5555;
    defparam add_416_7.INIT1 = 16'h5555;
    defparam add_416_7.INJECT1_0 = "NO";
    defparam add_416_7.INJECT1_1 = "NO";
    LUT4 temp1_0__bdd_3_lut (.A(GPI_DAT[1]), .B(irq_status[1]), .C(temp1[5]), 
         .Z(n3952)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam temp1_0__bdd_3_lut.init = 16'hcaca;
    LUT4 i2_3_lut_rep_38_4_lut (.A(temp1[3]), .B(n3960), .C(n3958), .D(n3), 
         .Z(n3954)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;
    defparam i2_3_lut_rep_38_4_lut.init = 16'he000;
    LUT4 i1_4_lut_adj_53 (.A(n3846), .B(n_temp1_7__N_68), .C(n3758), .D(n1614), 
         .Z(n4_adj_596)) /* synthesis lut_function=(A (B (D))+!A (B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_53.init = 16'hdc50;
    LUT4 i2_2_lut_3_lut_4_lut (.A(temp1[0]), .B(temp1[1]), .C(n14), .D(n3975), 
         .Z(n2479)) /* synthesis lut_function=((B+(C+(D)))+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(350[13:23])
    defparam i2_2_lut_3_lut_4_lut.init = 16'hfffd;
    PFUMX i2561 (.BLUT(n3952), .ALUT(n3951), .C0(temp1[1]), .Z(n3953));
    FD1S3IX temp1__i2 (.D(n_temp1[2]), .CK(clk), .CD(n3976), .Q(temp1[2]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp1__i2.GSR = "DISABLED";
    FD1S3IX temp1__i3 (.D(n_temp1[3]), .CK(clk), .CD(n3976), .Q(temp1[3]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp1__i3.GSR = "DISABLED";
    FD1S3IX temp1__i4 (.D(n_temp1[4]), .CK(clk), .CD(n3976), .Q(temp1[4]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp1__i4.GSR = "DISABLED";
    FD1S3IX temp1__i5 (.D(n_temp1[5]), .CK(clk), .CD(n3976), .Q(temp1[5]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp1__i5.GSR = "DISABLED";
    FD1S3IX temp1__i6 (.D(n_temp1[6]), .CK(clk), .CD(n3976), .Q(temp1[6]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp1__i6.GSR = "DISABLED";
    FD1S3IX temp1__i7 (.D(n_temp1[7]), .CK(clk), .CD(n3976), .Q(temp1[7]));   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(362[1] 377[11])
    defparam temp1__i7.GSR = "DISABLED";
    LUT4 i898_4_lut (.A(n_temp1_7__N_69), .B(n2873), .C(n1632), .D(n3755), 
         .Z(n2191)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i898_4_lut.init = 16'hb3a0;
    LUT4 temp1_7__I_0_409_i10_2_lut_rep_59 (.A(temp1[2]), .B(temp1[3]), 
         .Z(n3975)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(530[26:46])
    defparam temp1_7__I_0_409_i10_2_lut_rep_59.init = 16'heeee;
    LUT4 i1_2_lut_rep_51_3_lut_4_lut (.A(temp1[2]), .B(temp1[3]), .C(temp1[1]), 
         .D(temp1[0]), .Z(n3967)) /* synthesis lut_function=(A+(B+(C+!(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(530[26:46])
    defparam i1_2_lut_rep_51_3_lut_4_lut.init = 16'hfeff;
    LUT4 RST_N_I_0_1_lut_rep_60 (.A(RST_N_c), .Z(n3976)) /* synthesis lut_function=(!(A)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(294[10:21])
    defparam RST_N_I_0_1_lut_rep_60.init = 16'h5555;
    LUT4 irq_clr_3__I_0_i1_2_lut_2_lut (.A(RST_N_c), .B(irq_clr[0]), .Z(irq_status_clr[0])) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(294[10:21])
    defparam irq_clr_3__I_0_i1_2_lut_2_lut.init = 16'hdddd;
    VLO i1 (.Z(GND_net));
    LUT4 i810_4_lut_4_lut (.A(RST_N_c), .B(reg_rdy_del), .C(n2479), .D(n3961), 
         .Z(clk_enable_16)) /* synthesis lut_function=(!(A ((C+!(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(294[10:21])
    defparam i810_4_lut_4_lut.init = 16'h5d55;
    LUT4 i1542_2_lut_rep_40_4_lut (.A(n14), .B(n3966), .C(n3967), .D(clk_enable_12), 
         .Z(n3956)) /* synthesis lut_function=(A (D)+!A (B (C (D)))) */ ;
    defparam i1542_2_lut_rep_40_4_lut.init = 16'hea00;
    LUT4 i798_4_lut_4_lut (.A(RST_N_c), .B(n27), .C(temp1[4]), .D(temp1[7]), 
         .Z(clk_enable_26)) /* synthesis lut_function=(!(A ((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(294[10:21])
    defparam i798_4_lut_4_lut.init = 16'h555d;
    LUT4 i910_4_lut_4_lut (.A(clk_enable_12), .B(wb_dat_o[2]), .C(n_temp1_7__N_63), 
         .D(n_temp1_7__N_64), .Z(n2203)) /* synthesis lut_function=(A (B (C))+!A (D)) */ ;
    defparam i910_4_lut_4_lut.init = 16'hd580;
    LUT4 i2_3_lut (.A(n_temp1_7__N_72), .B(n_temp1_7__N_59), .C(n_temp1_7__N_65), 
         .Z(n3746)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2_3_lut.init = 16'hfefe;
    LUT4 i799_3_lut_4_lut_4_lut (.A(RST_N_c), .B(n3749), .C(temp1[1]), 
         .D(temp1[0]), .Z(clk_enable_13)) /* synthesis lut_function=(!(A ((C+!(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(294[10:21])
    defparam i799_3_lut_4_lut_4_lut.init = 16'h5d55;
    LUT4 i808_3_lut_4_lut_4_lut (.A(RST_N_c), .B(reg_rdy_del), .C(n3966), 
         .D(n14), .Z(clk_enable_19)) /* synthesis lut_function=(!(A ((C+(D))+!B))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(294[10:21])
    defparam i808_3_lut_4_lut_4_lut.init = 16'h555d;
    LUT4 irq_clr_3__I_0_i2_2_lut_2_lut (.A(RST_N_c), .B(irq_clr[1]), .Z(irq_status_clr[1])) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(294[10:21])
    defparam irq_clr_3__I_0_i2_2_lut_2_lut.init = 16'hdddd;
    LUT4 irq_clr_3__I_0_i3_2_lut_2_lut (.A(RST_N_c), .B(irq_clr[2]), .Z(irq_status_clr[2])) /* synthesis lut_function=((B)+!A) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(294[10:21])
    defparam irq_clr_3__I_0_i3_2_lut_2_lut.init = 16'hdddd;
    LUT4 i1539_2_lut_3_lut (.A(temp1[5]), .B(temp1[1]), .C(GPI_DAT[6]), 
         .Z(n2015)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(349[6] 355[15])
    defparam i1539_2_lut_3_lut.init = 16'h1010;
    LUT4 i1538_2_lut_3_lut (.A(temp1[5]), .B(temp1[1]), .C(GPI_DAT[5]), 
         .Z(n2016)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(349[6] 355[15])
    defparam i1538_2_lut_3_lut.init = 16'h1010;
    LUT4 i1_2_lut_4_lut (.A(n3970), .B(n3963), .C(temp1[0]), .D(n76), 
         .Z(n3758)) /* synthesis lut_function=(A (D)+!A (B (D)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(573[58:76])
    defparam i1_2_lut_4_lut.init = 16'hfe00;
    LUT4 i1532_2_lut_3_lut (.A(temp1[5]), .B(temp1[1]), .C(GPI_DAT[4]), 
         .Z(n2017)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(349[6] 355[15])
    defparam i1532_2_lut_3_lut.init = 16'h1010;
    LUT4 i2_4_lut_adj_54 (.A(wb_dat_o[2]), .B(n4_adj_609), .C(clk_enable_12), 
         .D(n4_adj_605), .Z(n3522)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2_4_lut_adj_54.init = 16'heccc;
    LUT4 i2_4_lut_adj_55 (.A(dat_count[0]), .B(n12_adj_599), .C(n17), 
         .D(n15_adj_598), .Z(n_dat_count[0])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2_4_lut_adj_55.init = 16'hffec;
    LUT4 i1_4_lut_adj_56 (.A(n2873), .B(dat_rdy_N_576), .C(n3755), .D(clk_enable_12), 
         .Z(n4_adj_609)) /* synthesis lut_function=(A (B (C+!(D))+!B (C))+!A !((D)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_56.init = 16'ha0ec;
    LUT4 i19_4_lut (.A(n_temp1_7__N_71), .B(n1_adj_597), .C(clk_enable_12), 
         .D(n3772), .Z(n3610)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i19_4_lut.init = 16'hfaca;
    LUT4 i1_2_lut_adj_57 (.A(wb_dat_o[4]), .B(n_temp1_7__N_69), .Z(n1_adj_597)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_adj_57.init = 16'h8888;
    LUT4 i1_2_lut_rep_61 (.A(n_state_7__N_543[4]), .B(wb_dat_o[2]), .Z(n3977)) /* synthesis lut_function=(!((B)+!A)) */ ;
    defparam i1_2_lut_rep_61.init = 16'h2222;
    LUT4 i1_2_lut_3_lut_4_lut_adj_58 (.A(n_state_7__N_543[4]), .B(wb_dat_o[2]), 
         .C(n3), .D(n15_adj_595), .Z(n3770)) /* synthesis lut_function=(!((B+!(C+(D)))+!A)) */ ;
    defparam i1_2_lut_3_lut_4_lut_adj_58.init = 16'h2220;
    LUT4 i1_4_lut_adj_59 (.A(n1940), .B(n9), .C(n14_adj_608), .D(n10_adj_611), 
         .Z(n2461)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_59.init = 16'hfffe;
    LUT4 i1_2_lut_adj_60 (.A(n_temp1_7__N_63), .B(n_temp1_7__N_74), .Z(n9)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_2_lut_adj_60.init = 16'heeee;
    LUT4 i22_4_lut (.A(n_temp1_7__N_72), .B(n6), .C(clk_enable_12), .D(n4), 
         .Z(n3606)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i22_4_lut.init = 16'hfaca;
    LUT4 i6_4_lut (.A(n_temp1_7__N_60), .B(n_temp1_7__N_73), .C(n_temp1_7__N_69), 
         .D(n_temp1_7__N_68), .Z(n14_adj_608)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i6_4_lut.init = 16'hfffe;
    LUT4 i1_4_lut_adj_61 (.A(n3957), .B(n15_adj_595), .C(dat_rdy_N_576), 
         .D(n_temp1_7__N_75), .Z(n4)) /* synthesis lut_function=(!(A (B+!(D))+!A !(B (C)+!B (C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_61.init = 16'h7350;
    PFUMX mux_769_i4 (.BLUT(n1986), .ALUT(n2044), .C0(temp1[1]), .Z(n2018));
    LUT4 i3_4_lut_adj_62 (.A(n5), .B(n_temp1_7__N_73), .C(n6_adj_602), 
         .D(n3964), .Z(n3598)) /* synthesis lut_function=(A+(B (C+(D))+!B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i3_4_lut_adj_62.init = 16'hfefa;
    LUT4 i1_4_lut_adj_63 (.A(n3773), .B(n1801), .C(n3), .D(wb_dat_o[2]), 
         .Z(n5)) /* synthesis lut_function=(A (B+(C (D)))+!A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_63.init = 16'heccc;
    LUT4 i539_2_lut_3_lut_4_lut (.A(n_state_7__N_543[4]), .B(wb_dat_o[2]), 
         .C(wb_stb_i), .D(wb_ack_o), .Z(n1614)) /* synthesis lut_function=(!(A (B (C (D)))+!A (C (D)))) */ ;
    defparam i539_2_lut_3_lut_4_lut.init = 16'h2fff;
    LUT4 i1_4_lut_adj_64 (.A(clk_enable_12), .B(n3958), .C(n_temp1_7__N_72), 
         .D(n_temp1_7__N_67), .Z(n6_adj_602)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_64.init = 16'ha2a0;
    LUT4 i1_4_lut_adj_65 (.A(n_temp1_7__N_71), .B(dat_count[0]), .C(n957), 
         .D(n3955), .Z(n12_adj_599)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_65.init = 16'ha088;
    LUT4 i2_2_lut_adj_66 (.A(n_temp1_7__N_66), .B(n_temp1_7__N_75), .Z(n10_adj_611)) /* synthesis lut_function=(A+(B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2_2_lut_adj_66.init = 16'heeee;
    LUT4 i1513_2_lut_3_lut_4_lut (.A(n3963), .B(n3974), .C(clk_enable_12), 
         .D(temp1[3]), .Z(n2833)) /* synthesis lut_function=(A (C)+!A (B (C)+!B (C (D)))) */ ;
    defparam i1513_2_lut_3_lut_4_lut.init = 16'hf0e0;
    LUT4 i1_4_lut_adj_67 (.A(dat_rdy_N_576), .B(dat_count[0]), .C(n957), 
         .D(n2833), .Z(n15_adj_598)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_67.init = 16'ha088;
    LUT4 i930_4_lut (.A(n_temp1_7__N_74), .B(clk_enable_12), .C(n_temp1_7__N_71), 
         .D(n3770), .Z(n2223)) /* synthesis lut_function=(A ((C+(D))+!B)+!A (B (C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i930_4_lut.init = 16'heae2;
    LUT4 i912_4_lut_4_lut (.A(clk_enable_12), .B(wb_dat_o[2]), .C(n_temp1_7__N_62), 
         .D(n_temp1_7__N_63), .Z(n2205)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A (D)) */ ;
    defparam i912_4_lut_4_lut.init = 16'hf7a0;
    LUT4 i904_4_lut_4_lut (.A(clk_enable_12), .B(wb_dat_o[2]), .C(n_temp1_7__N_66), 
         .D(n_temp1_7__N_67), .Z(n2197)) /* synthesis lut_function=(A (B (C))+!A (D)) */ ;
    defparam i904_4_lut_4_lut.init = 16'hd580;
    LUT4 i976_2_lut_4_lut (.A(n3746), .B(n_temp1_7__N_71), .C(n_temp1_7__N_58), 
         .D(clk_enable_12), .Z(n_wb_we_i)) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B ((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i976_2_lut_4_lut.init = 16'h00fe;
    LUT4 i1_4_lut_adj_68 (.A(dat_rdy_N_576), .B(n950), .C(dat_count[7]), 
         .D(n2833), .Z(n15_adj_593)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_68.init = 16'h88a0;
    LUT4 i2474_4_lut (.A(clk_enable_12), .B(n83), .C(n_temp1_7__N_72), 
         .D(n3468), .Z(n_wb_dat_i[3])) /* synthesis lut_function=(!(A+!(B+(C+(D))))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(216[17:24])
    defparam i2474_4_lut.init = 16'h5554;
    LUT4 i2_3_lut_rep_46 (.A(n3746), .B(n_temp1_7__N_71), .C(n_temp1_7__N_58), 
         .Z(n3962)) /* synthesis lut_function=(A+(B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2_3_lut_rep_46.init = 16'hfefe;
    LUT4 i800_3_lut_4_lut (.A(n3970), .B(n3960), .C(RST_N_c), .D(reg_rdy), 
         .Z(clk_enable_33)) /* synthesis lut_function=(!(A (C)+!A (B (C)+!B !((D)+!C)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(573[58:76])
    defparam i800_3_lut_4_lut.init = 16'h1f0f;
    LUT4 i99_2_lut (.A(n_temp1_7__N_71), .B(data0[3]), .Z(n83)) /* synthesis lut_function=(A (B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(191[16:23])
    defparam i99_2_lut.init = 16'h8888;
    LUT4 i2_4_lut_adj_69 (.A(dat_count[6]), .B(n12_adj_607), .C(n17), 
         .D(n15_adj_606), .Z(n_dat_count[6])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2_4_lut_adj_69.init = 16'hffec;
    LUT4 i2_4_lut_adj_70 (.A(dat_count[7]), .B(n12_adj_594), .C(n17), 
         .D(n15_adj_593), .Z(n_dat_count[7])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2_4_lut_adj_70.init = 16'hffec;
    LUT4 i1_4_lut_adj_71 (.A(n_temp1_7__N_71), .B(dat_count[6]), .C(n951), 
         .D(n3955), .Z(n12_adj_607)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_71.init = 16'ha088;
    LUT4 i918_4_lut_4_lut (.A(clk_enable_12), .B(n_state_7__N_543[4]), .C(n_temp1_7__N_59), 
         .D(n_temp1_7__N_60), .Z(n2211)) /* synthesis lut_function=(A (B (C+(D))+!B (C))+!A (D)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(1091[7] 1110[12])
    defparam i918_4_lut_4_lut.init = 16'hfda0;
    LUT4 i1_4_lut_adj_72 (.A(dat_rdy_N_576), .B(n951), .C(dat_count[6]), 
         .D(n2833), .Z(n15_adj_606)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_72.init = 16'h88a0;
    LUT4 i2475_3_lut_rep_42_4_lut (.A(n3970), .B(n3973), .C(n3967), .D(n14), 
         .Z(n3958)) /* synthesis lut_function=(A (C+(D))+!A (B (C+(D))+!B (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(529[33:53])
    defparam i2475_3_lut_rep_42_4_lut.init = 16'hffe0;
    PFUMX i2557 (.BLUT(n3948), .ALUT(n3947), .C0(temp1[1]), .Z(n3949));
    LUT4 i2_4_lut_adj_73 (.A(dat_count[5]), .B(n12), .C(n17), .D(n15), 
         .Z(n_dat_count[5])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2_4_lut_adj_73.init = 16'hffec;
    LUT4 i1_4_lut_adj_74 (.A(n_temp1_7__N_71), .B(dat_count[5]), .C(n952), 
         .D(n3955), .Z(n12)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_74.init = 16'ha088;
    LUT4 i1_4_lut_adj_75 (.A(dat_rdy_N_576), .B(n952), .C(dat_count[5]), 
         .D(n2833), .Z(n15)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_75.init = 16'h88a0;
    LUT4 i2_4_lut_adj_76 (.A(dat_count[4]), .B(n12_adj_604), .C(n17), 
         .D(n15_adj_603), .Z(n_dat_count[4])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2_4_lut_adj_76.init = 16'hffec;
    LUT4 i1_4_lut_adj_77 (.A(n_temp1_7__N_71), .B(dat_count[4]), .C(n953), 
         .D(n3955), .Z(n12_adj_604)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_77.init = 16'ha088;
    LUT4 i3_4_lut_adj_78 (.A(n_temp1_7__N_61), .B(n_temp1_7__N_64), .C(n_temp1_7__N_62), 
         .D(n3968), .Z(n1940)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i3_4_lut_adj_78.init = 16'hfffe;
    LUT4 select_741_Select_7_i11_3_lut_4_lut_4_lut (.A(clk_enable_12), .B(n_temp1_7__N_71), 
         .C(data0[7]), .D(n_temp1_7__N_58), .Z(n_wb_dat_i[7])) /* synthesis lut_function=(!(A+!(B (C+(D))+!B (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam select_741_Select_7_i11_3_lut_4_lut_4_lut.init = 16'h5540;
    LUT4 i1_4_lut_adj_79 (.A(dat_rdy_N_576), .B(n953), .C(dat_count[4]), 
         .D(n2833), .Z(n15_adj_603)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_79.init = 16'h88a0;
    LUT4 i2_3_lut_4_lut_adj_80 (.A(n3970), .B(n3960), .C(n1), .D(n3846), 
         .Z(n2873)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(573[58:76])
    defparam i2_3_lut_4_lut_adj_80.init = 16'he000;
    LUT4 i1_2_lut_rep_44_4_lut (.A(n3972), .B(temp1[6]), .C(temp1[5]), 
         .D(n3974), .Z(n3960)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(350[13:23])
    defparam i1_2_lut_rep_44_4_lut.init = 16'hfffe;
    LUT4 i3_4_lut_adj_81 (.A(n_dat_count_7__N_137[3]), .B(n6_adj_610), .C(n2), 
         .D(n_temp1_7__N_71), .Z(n_dat_count[3])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i3_4_lut_adj_81.init = 16'hfefc;
    LUT4 i1_4_lut_adj_82 (.A(n3975), .B(n1), .C(n3973), .D(n3963), .Z(n3)) /* synthesis lut_function=(A (B)+!A (B (C+(D)))) */ ;
    defparam i1_4_lut_adj_82.init = 16'hccc8;
    LUT4 i2_4_lut_adj_83 (.A(dat_count[3]), .B(n3790), .C(n_temp1_7__N_67), 
         .D(n3956), .Z(n6_adj_610)) /* synthesis lut_function=(A ((C)+!B)+!A (C (D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2_4_lut_adj_83.init = 16'hf2a2;
    LUT4 select_747_Select_3_i2_4_lut (.A(n954), .B(dat_rdy_N_576), .C(dat_count[3]), 
         .D(n2833), .Z(n2)) /* synthesis lut_function=(A (B (C+(D)))+!A !(((D)+!C)+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam select_747_Select_3_i2_4_lut.init = 16'h88c0;
    LUT4 i2_4_lut_adj_84 (.A(dat_count[2]), .B(n12_adj_592), .C(n17), 
         .D(n15_adj_591), .Z(n_dat_count[2])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2_4_lut_adj_84.init = 16'hffec;
    LUT4 i1_4_lut_adj_85 (.A(n_temp1_7__N_71), .B(dat_count[2]), .C(n955), 
         .D(n3955), .Z(n12_adj_592)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_85.init = 16'ha088;
    LUT4 temp1_0__bdd_2_lut_2555 (.A(temp1[0]), .B(irq_en[2]), .Z(n3902)) /* synthesis lut_function=(!(A+!(B))) */ ;
    defparam temp1_0__bdd_2_lut_2555.init = 16'h4444;
    PFUMX i42 (.BLUT(n3482), .ALUT(n3488), .C0(temp1[3]), .Z(n27));
    LUT4 i1_4_lut_adj_86 (.A(dat_rdy_N_576), .B(n955), .C(dat_count[2]), 
         .D(n2833), .Z(n15_adj_591)) /* synthesis lut_function=(A (B (C+(D))+!B !((D)+!C))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_86.init = 16'h88a0;
    LUT4 i4_4_lut (.A(n3963), .B(temp1[3]), .C(temp1[2]), .D(n3806), 
         .Z(n1)) /* synthesis lut_function=(A+((C+!(D))+!B)) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(351[13:23])
    defparam i4_4_lut.init = 16'hfbff;
    LUT4 i2_4_lut_adj_87 (.A(dat_count[1]), .B(n12_adj_601), .C(n17), 
         .D(n15_adj_600), .Z(n_dat_count[1])) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+(D))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i2_4_lut_adj_87.init = 16'hffec;
    LUT4 i1_4_lut_adj_88 (.A(n_temp1_7__N_71), .B(dat_count[1]), .C(n956), 
         .D(n3955), .Z(n12_adj_601)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_88.init = 16'ha088;
    TSALL TSALL_INST (.TSALL(GND_net));
    LUT4 m1_lut (.Z(n4077)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    LUT4 i1_4_lut_adj_89 (.A(dat_rdy_N_576), .B(dat_count[1]), .C(n956), 
         .D(n2833), .Z(n15_adj_600)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))) */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(661[6] 1176[10])
    defparam i1_4_lut_adj_89.init = 16'ha088;
    efb_vhdl dut (.clk(clk), .n3976(n3976), .wb_stb_i(wb_stb_i), .wb_we_i(wb_we_i), 
            .GND_net(GND_net), .\wb_adr_i[2] (wb_adr_i[2]), .\wb_adr_i[1] (wb_adr_i[1]), 
            .\wb_adr_i[0] (wb_adr_i[0]), .wb_dat_i({wb_dat_i}), .\wb_dat_o[7] (wb_dat_o[7]), 
            .\n_state_7__N_543[4] (n_state_7__N_543[4]), .\wb_dat_o[5] (wb_dat_o[5]), 
            .\wb_dat_o[4] (wb_dat_o[4]), .\wb_dat_o[3] (wb_dat_o[3]), .\wb_dat_o[2] (wb_dat_o[2]), 
            .\wb_dat_o[1] (wb_dat_o[1]), .\wb_dat_o[0] (wb_dat_o[0]), .wb_ack_o(wb_ack_o), 
            .i2c1_sdaoen(i2c1_sdaoen), .i2c1_sdao(i2c1_sdao), .i2c1_scloen(i2c1_scloen), 
            .i2c1_sclo(i2c1_sclo), .i2c1_sdai(i2c1_sdai), .i2c1_scli(i2c1_scli), 
            .VCC_net(VCC_net)) /* synthesis NGD_DRC_MASK=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(277[7:15])
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    PFUMX i2563 (.BLUT(n3978), .ALUT(n3979), .C0(temp1[2]), .Z(n3846));
    LUT4 i2482_2_lut (.A(temp1[0]), .B(temp1[1]), .Z(n3806)) /* synthesis lut_function=(A (B)) */ ;
    defparam i2482_2_lut.init = 16'h8888;
    PFUMX i2541 (.BLUT(n3903), .ALUT(n3902), .C0(temp1[1]), .Z(n3904));
    
endmodule
//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module efb_vhdl
//

module efb_vhdl (clk, n3976, wb_stb_i, wb_we_i, GND_net, \wb_adr_i[2] , 
            \wb_adr_i[1] , \wb_adr_i[0] , wb_dat_i, \wb_dat_o[7] , \n_state_7__N_543[4] , 
            \wb_dat_o[5] , \wb_dat_o[4] , \wb_dat_o[3] , \wb_dat_o[2] , 
            \wb_dat_o[1] , \wb_dat_o[0] , wb_ack_o, i2c1_sdaoen, i2c1_sdao, 
            i2c1_scloen, i2c1_sclo, i2c1_sdai, i2c1_scli, VCC_net) /* synthesis NGD_DRC_MASK=1 */ ;
    input clk;
    input n3976;
    input wb_stb_i;
    input wb_we_i;
    input GND_net;
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
    
    wire clk /* synthesis is_clock=1, SET_AS_NETWORK=clk */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(88[8:11])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/ipexpress/xo2/efb_vhdl.vhd(40[12:21])
    
    EFB EFBInst_0 (.WBCLKI(clk), .WBRSTI(n3976), .WBCYCI(wb_stb_i), .WBSTBI(wb_stb_i), 
        .WBWEI(wb_we_i), .WBADRI0(\wb_adr_i[0] ), .WBADRI1(\wb_adr_i[1] ), 
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
        .WBDATO5(\wb_dat_o[5] ), .WBDATO6(\n_state_7__N_543[4] ), .WBDATO7(\wb_dat_o[7] ), 
        .WBACKO(wb_ack_o), .I2C1SCLO(i2c1_sclo), .I2C1SCLOEN(i2c1_scloen), 
        .I2C1SDAO(i2c1_sdao), .I2C1SDAOEN(i2c1_sdaoen)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=20, LSE_LCOL=7, LSE_RCOL=15, LSE_LLINE=277, LSE_RLINE=277 */ ;   // c:/cpld/cpld_lattice/machxo2/d_slot_cpld_lcmxo2-2000hc-4tg100c/uz_d_slots/i2c/i2c_gpio.vhd(277[7:15])
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
//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

