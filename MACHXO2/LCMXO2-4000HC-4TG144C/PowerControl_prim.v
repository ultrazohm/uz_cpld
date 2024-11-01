// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.13.0.56.2
// Netlist written on Tue Oct 22 13:58:20 2024
//
// Verilog Description of module PowerControl
//

module PowerControl (powertaster, poweron, clk);   // c:/lscc/diamond/3.13/bin/nt64/power_on.vhd(7[8:20])
    input powertaster;   // c:/lscc/diamond/3.13/bin/nt64/power_on.vhd(9[9:20])
    output poweron;   // c:/lscc/diamond/3.13/bin/nt64/power_on.vhd(10[9:16])
    input clk;   // c:/lscc/diamond/3.13/bin/nt64/power_on.vhd(11[3:6])
    
    
    wire poweron_c_c, GND_net, VCC_net;
    
    VLO i23 (.Z(GND_net));
    OB poweron_pad (.I(poweron_c_c), .O(poweron));   // c:/lscc/diamond/3.13/bin/nt64/power_on.vhd(10[9:16])
    IB poweron_c_pad (.I(powertaster), .O(poweron_c_c));   // c:/lscc/diamond/3.13/bin/nt64/power_on.vhd(9[9:20])
    GSR GSR_INST (.GSR(VCC_net));
    TSALL TSALL_INST (.TSALL(GND_net));
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    VHI i24 (.Z(VCC_net));
    
endmodule
//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

