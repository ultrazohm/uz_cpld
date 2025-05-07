// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Wed May 07 14:04:29 2025
//
// Verilog Description of module efb_vhdl
//

module efb_vhdl (wb_clk_i, wb_rst_i, wb_cyc_i, wb_stb_i, wb_we_i, 
            wb_adr_i, wb_dat_i, wb_dat_o, wb_ack_o, i2c1_scl, i2c1_sda, 
            i2c1_irqo) /* synthesis NGD_DRC_MASK=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(14[8:16])
    input wb_clk_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(16[9:17])
    input wb_rst_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(17[9:17])
    input wb_cyc_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(18[9:17])
    input wb_stb_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(19[9:17])
    input wb_we_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(20[9:16])
    input [7:0]wb_adr_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(21[9:17])
    input [7:0]wb_dat_i;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(22[9:17])
    output [7:0]wb_dat_o;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(23[9:17])
    output wb_ack_o;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(24[9:17])
    inout i2c1_scl /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(25[9:17])
    inout i2c1_sda /* synthesis black_box_pad_pin=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(26[9:17])
    output i2c1_irqo;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(27[9:18])
    
    wire wb_clk_i_c /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(16[9:17])
    wire i2c1_scli /* synthesis is_clock=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(40[12:21])
    
    wire wb_rst_i_c, wb_cyc_i_c, wb_stb_i_c, wb_we_i_c, wb_adr_i_c_7, 
        wb_adr_i_c_6, wb_adr_i_c_5, wb_adr_i_c_4, wb_adr_i_c_3, wb_adr_i_c_2, 
        wb_adr_i_c_1, wb_adr_i_c_0, wb_dat_i_c_7, wb_dat_i_c_6, wb_dat_i_c_5, 
        wb_dat_i_c_4, wb_dat_i_c_3, wb_dat_i_c_2, wb_dat_i_c_1, wb_dat_i_c_0, 
        wb_dat_o_c_7, wb_dat_o_c_6, wb_dat_o_c_5, wb_dat_o_c_4, wb_dat_o_c_3, 
        wb_dat_o_c_2, wb_dat_o_c_1, wb_dat_o_c_0, wb_ack_o_c, i2c1_irqo_c, 
        scuba_vlo, i2c1_sdaoen, i2c1_sdao, i2c1_scloen, i2c1_sclo, 
        i2c1_sdai, VCC_net;
    
    VLO scuba_vlo_inst (.Z(scuba_vlo));
    BB BB1_sda (.I(i2c1_sdao), .T(i2c1_sdaoen), .B(i2c1_sda), .O(i2c1_sdai)) /* synthesis syn_instantiated=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(150[14:16])
    OB wb_dat_o_pad_4 (.I(wb_dat_o_c_4), .O(wb_dat_o[4]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(23[9:17])
    OB wb_dat_o_pad_5 (.I(wb_dat_o_c_5), .O(wb_dat_o[5]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(23[9:17])
    OB wb_dat_o_pad_3 (.I(wb_dat_o_c_3), .O(wb_dat_o[3]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(23[9:17])
    OB wb_dat_o_pad_6 (.I(wb_dat_o_c_6), .O(wb_dat_o[6]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(23[9:17])
    OB wb_dat_o_pad_7 (.I(wb_dat_o_c_7), .O(wb_dat_o[7]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(23[9:17])
    BB BB1_scl (.I(i2c1_sclo), .T(i2c1_scloen), .B(i2c1_scl), .O(i2c1_scli)) /* synthesis syn_instantiated=1 */ ;   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(154[14:16])
    EFB EFBInst_0 (.WBCLKI(wb_clk_i_c), .WBRSTI(wb_rst_i_c), .WBCYCI(wb_cyc_i_c), 
        .WBSTBI(wb_stb_i_c), .WBWEI(wb_we_i_c), .WBADRI0(wb_adr_i_c_0), 
        .WBADRI1(wb_adr_i_c_1), .WBADRI2(wb_adr_i_c_2), .WBADRI3(wb_adr_i_c_3), 
        .WBADRI4(wb_adr_i_c_4), .WBADRI5(wb_adr_i_c_5), .WBADRI6(wb_adr_i_c_6), 
        .WBADRI7(wb_adr_i_c_7), .WBDATI0(wb_dat_i_c_0), .WBDATI1(wb_dat_i_c_1), 
        .WBDATI2(wb_dat_i_c_2), .WBDATI3(wb_dat_i_c_3), .WBDATI4(wb_dat_i_c_4), 
        .WBDATI5(wb_dat_i_c_5), .WBDATI6(wb_dat_i_c_6), .WBDATI7(wb_dat_i_c_7), 
        .I2C1SCLI(i2c1_scli), .I2C1SDAI(i2c1_sdai), .I2C2SCLI(scuba_vlo), 
        .I2C2SDAI(scuba_vlo), .SPISCKI(scuba_vlo), .SPIMISOI(scuba_vlo), 
        .SPIMOSII(scuba_vlo), .SPISCSN(scuba_vlo), .TCCLKI(scuba_vlo), 
        .TCRSTN(scuba_vlo), .TCIC(scuba_vlo), .UFMSN(VCC_net), .PLL0DATI0(scuba_vlo), 
        .PLL0DATI1(scuba_vlo), .PLL0DATI2(scuba_vlo), .PLL0DATI3(scuba_vlo), 
        .PLL0DATI4(scuba_vlo), .PLL0DATI5(scuba_vlo), .PLL0DATI6(scuba_vlo), 
        .PLL0DATI7(scuba_vlo), .PLL0ACKI(scuba_vlo), .PLL1DATI0(scuba_vlo), 
        .PLL1DATI1(scuba_vlo), .PLL1DATI2(scuba_vlo), .PLL1DATI3(scuba_vlo), 
        .PLL1DATI4(scuba_vlo), .PLL1DATI5(scuba_vlo), .PLL1DATI6(scuba_vlo), 
        .PLL1DATI7(scuba_vlo), .PLL1ACKI(scuba_vlo), .WBDATO0(wb_dat_o_c_0), 
        .WBDATO1(wb_dat_o_c_1), .WBDATO2(wb_dat_o_c_2), .WBDATO3(wb_dat_o_c_3), 
        .WBDATO4(wb_dat_o_c_4), .WBDATO5(wb_dat_o_c_5), .WBDATO6(wb_dat_o_c_6), 
        .WBDATO7(wb_dat_o_c_7), .WBACKO(wb_ack_o_c), .I2C1SCLO(i2c1_sclo), 
        .I2C1SCLOEN(i2c1_scloen), .I2C1SDAO(i2c1_sdao), .I2C1SDAOEN(i2c1_sdaoen), 
        .I2C1IRQO(i2c1_irqo_c)) /* synthesis syn_instantiated=1 */ ;
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
    OB wb_dat_o_pad_2 (.I(wb_dat_o_c_2), .O(wb_dat_o[2]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(23[9:17])
    OB wb_dat_o_pad_1 (.I(wb_dat_o_c_1), .O(wb_dat_o[1]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(23[9:17])
    OB wb_dat_o_pad_0 (.I(wb_dat_o_c_0), .O(wb_dat_o[0]));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(23[9:17])
    OB wb_ack_o_pad (.I(wb_ack_o_c), .O(wb_ack_o));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(24[9:17])
    OB i2c1_irqo_pad (.I(i2c1_irqo_c), .O(i2c1_irqo));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(27[9:18])
    IB wb_clk_i_pad (.I(wb_clk_i), .O(wb_clk_i_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(16[9:17])
    IB wb_rst_i_pad (.I(wb_rst_i), .O(wb_rst_i_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(17[9:17])
    IB wb_cyc_i_pad (.I(wb_cyc_i), .O(wb_cyc_i_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(18[9:17])
    IB wb_stb_i_pad (.I(wb_stb_i), .O(wb_stb_i_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(19[9:17])
    IB wb_we_i_pad (.I(wb_we_i), .O(wb_we_i_c));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(20[9:16])
    IB wb_adr_i_pad_7 (.I(wb_adr_i[7]), .O(wb_adr_i_c_7));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(21[9:17])
    IB wb_adr_i_pad_6 (.I(wb_adr_i[6]), .O(wb_adr_i_c_6));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(21[9:17])
    IB wb_adr_i_pad_5 (.I(wb_adr_i[5]), .O(wb_adr_i_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(21[9:17])
    IB wb_adr_i_pad_4 (.I(wb_adr_i[4]), .O(wb_adr_i_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(21[9:17])
    IB wb_adr_i_pad_3 (.I(wb_adr_i[3]), .O(wb_adr_i_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(21[9:17])
    IB wb_adr_i_pad_2 (.I(wb_adr_i[2]), .O(wb_adr_i_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(21[9:17])
    IB wb_adr_i_pad_1 (.I(wb_adr_i[1]), .O(wb_adr_i_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(21[9:17])
    IB wb_adr_i_pad_0 (.I(wb_adr_i[0]), .O(wb_adr_i_c_0));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(21[9:17])
    IB wb_dat_i_pad_7 (.I(wb_dat_i[7]), .O(wb_dat_i_c_7));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(22[9:17])
    IB wb_dat_i_pad_6 (.I(wb_dat_i[6]), .O(wb_dat_i_c_6));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(22[9:17])
    IB wb_dat_i_pad_5 (.I(wb_dat_i[5]), .O(wb_dat_i_c_5));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(22[9:17])
    IB wb_dat_i_pad_4 (.I(wb_dat_i[4]), .O(wb_dat_i_c_4));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(22[9:17])
    IB wb_dat_i_pad_3 (.I(wb_dat_i[3]), .O(wb_dat_i_c_3));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(22[9:17])
    IB wb_dat_i_pad_2 (.I(wb_dat_i[2]), .O(wb_dat_i_c_2));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(22[9:17])
    IB wb_dat_i_pad_1 (.I(wb_dat_i[1]), .O(wb_dat_i_c_1));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(22[9:17])
    IB wb_dat_i_pad_0 (.I(wb_dat_i[0]), .O(wb_dat_i_c_0));   // c:/cpld/cpld_lattice/machxo2/s3c_cpld_lcmxo2-4000hc-4tg144c/s3c_i2c_25/source/ipexpress/xo2/efb_vhdl.vhd(22[9:17])
    GSR GSR_INST (.GSR(VCC_net));
    TSALL TSALL_INST (.TSALL(scuba_vlo));
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    VHI i8 (.Z(VCC_net));
    
endmodule
//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

