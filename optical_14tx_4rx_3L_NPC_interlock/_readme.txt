Check the top_level.abl to see the implemented logic, it starts after the keyword EQUATIONS.
A detailed description can be found on docs.ultrazohm.com -> CPLD 


Specific comments for project optical_14tx_4rx_3L_interlock
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

This project is intended for a three-level three-phase inverter, that consists of three phases connected in the following way: 

fpga_00 -> d_00 -> phase A - Top 
fpga_01 -> d_01 -> phase A - Neutral Point Upper
fpga_02 -> d_02 -> phase A - Neutral Point Lower 
fpga_03 -> d_03 -> phase A - Bottom 

fpga_04 -> d_04 -> phase B - Top 
fpga_05 -> d_05 -> phase B - Neutral Point Upper
fpga_06 -> d_06 -> phase B - Neutral Point Lower 
fpga_07 -> d_07 -> phase B - Bottom 
              
fpga_08 -> d_08 -> phase C - Top 
fpga_09 -> d_09 -> phase C - Neutral Point Upper
fpga_10 -> d_10 -> phase C - Neutral Point Lower 
fpga_11 -> d_11 -> phase C - Bottom 

The switches in each switching-cell are interlocked, such that it is not possible that both are HIGH at the same time, preventing a short-circuit as well as undesired switch positions, using the following logic:

   "interlock of switching cell 1 in phase A
   d_00 = fpga_00 & enable_signal & !fpga_02 ;
   d_02 = fpga_02 & enable_signal & !fpga_00 ;
   
   "interlock of switching cell 2 in phase A
   d_01 = fpga_01 & enable_signal & !fpga_03 ;
   d_03 = fpga_03 & enable_signal & !fpga_01 ;

There is no dead-time implemented on the CPLD. 