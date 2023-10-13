Check the top_level.abl to see the implemented logic, it starts after the keyword EQUATIONS.
A detailed description can be found on docs.ultrazohm.com -> CPLD 


Specific comments for project optical_14tx_4rx_2L_interlock
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

This project is intended for a two-level three-phase inverter, that consists of three half-bridges connected in the following way: 

fpga_00 -> d_00 -> phase A 
fpga_01 -> d_01 -> phase A

fpga_02 -> d_02 -> phase B 
fpga_03 -> d_03 -> phase B

fpga_04 -> d_04 -> phase C 
fpga_05 -> d_05 -> phase C

The switches in each phase/half-bridge/switching-cell are interlocked, such that it is not possible that both are HIGH at the same time, preventing a short-circuit, using the following logic:

   d_00 = fpga_00 & enable_signal & !fpga_01 ; 
   d_01 = fpga_01 & enable_signal & !fpga_00 ; 

There is no dead-time implemented on the CPLD. 