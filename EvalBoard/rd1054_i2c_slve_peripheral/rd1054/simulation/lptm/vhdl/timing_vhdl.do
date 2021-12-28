set PROJ_DIR "Enter your simulation path here"  

# As an Example :
# set PROJ_DIR "D:\RD1054\simulation"

cd $PROJ_DIR\lptm\vhdl

if {![file exists timing_vhdl]} {
	 vlib timing_vhdl
}
endif

design create timing_vhdl .
design open timing_vhdl
adel -all

cd $PROJ_DIR\lptm\vhdl

acom -dbg ../../../project/lptm/vhdl/lptm_vhdl/lptm_vhdl_lptm_vhdl_vho.vho


vlog -dbg +define+LPTM_TEST ../../../Testbench/verilog/i2c_peri_tf.v
vlog -dbg +define+LPTM_TEST ../../../Testbench/verilog/i2c_mstr.v

designsimaddoptions +transport_path_delays +transport_int_delays
asim -ieee_nowarn -L lptm -PL pmi_work +transport_path_delays +transport_int_delays +access +r i2c_peri_tb -noglitch +no_tchk_msg -sdfmax /i2c_peri_tb/u1 = "../../../project/lptm/vhdl/lptm_vhdl/lptm_vhdl_lptm_vhdl_vho.sdf"

add wave *

run 37us