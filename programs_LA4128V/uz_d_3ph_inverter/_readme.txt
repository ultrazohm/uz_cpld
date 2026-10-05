Check the top_level.abl to see the implemented logic, it starts after the keyword EQUATIONS.
A detailed description can be found on docs.ultrazohm.com -> CPLD 


Specific comments for project uz_d_3ph_inverter
"""""""""""""""""""""""""""""""""""""""""""""""

This project is intended for a specific interface with two-level three-phase inverter adapter boards e.g. uz_d_gan_inverter: 

fpga_00 -> d_00 -> PWM_H1#
fpga_01 -> d_01 -> PWM_L1#
fpga_02 -> d_02 -> PWM_H2# 
fpga_03 -> d_03 -> PWM_L2#
fpga_04 -> d_04 -> PWM_H3# 
fpga_05 -> d_05 -> PWM_L3#
d_06 -> fpga_06 I1_DIAG
d_07 -> fpga_07 GaN_H1_Temp
d_08 -> fpga_08 I2_DIAG
d_09 -> fpga_09 GaN_L1_Temp
d_10 -> fpga_10 I3_DIAG
d_11 -> fpga_11 GaN_L1_OC
d_12 -> fpga_12 I_DIAG
d_13 -> fpga_13 GaN_L1_FAULT
fpga_14 -> d_14 PWM_EN
d_15 -> fpga_15 GaN_H1_OC
d_16 -> fpga_16 N/A
d_17 -> fpga_17 GaN_H1_FAULT
d_18 -> fpga_18 GaN_H3_Temp
d_19 -> fpga_19 GaN_H2_Temp
d_20 -> fpga_20 GaN_L3_Temp
d_21 -> fpga_21 GaN_L2_Temp
d_22 -> fpga_22 GaN_L3_OC
d_23 -> fpga_23 GaN_L2_OC
d_24 -> fpga_24 GaN_L3_FAULT
d_25 -> fpga_25 GaN_L2_FAULT
d_26 -> fpga_26 GaN_H3_OC
d_27 -> fpga_27 GaN_H2_OC
d_28 -> fpga_28 GaN_H3_FAULT
d_29 -> fpga_29 GaN_H2_FAULT

The switches in each phase/half-bridge/switching-cell are interlocked on the adapter board, such that it is not possible that both are HIGH at the same time, preventing a short-circuit.

There is no dead-time implemented on the CPLD. 