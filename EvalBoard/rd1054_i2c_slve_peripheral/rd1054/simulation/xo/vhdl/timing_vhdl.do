set PROJ_DIR "Enter your simulation path here"  

# As an Example :
# set PROJ_DIR "D:\RD1054\simulation"

cd $PROJ_DIR\xo\vhdl

if {![file exists timing_vhdl]} {
	 vlib timing_vhdl
}
endif

design create timing_vhdl .
design open timing_vhdl
adel -all

cd $PROJ_DIR\xo\vhdl

acom -dbg ../../../project/xo/vhdl/xo_vhdl/xo_vhdl_xo_vhdl_vho.vho


vlog -dbg +define+XO_TEST ../../../Testbench/verilog/i2c_peri_tf.v
vlog -dbg +define+XO_TEST ../../../Testbench/verilog/i2c_mstr.v

designsimaddoptions +transport_path_delays +transport_int_delays
asim -ieee_nowarn -L machxo -PL pmi_work +transport_path_delays +transport_int_delays +access +r i2c_peri_tb -noglitch +no_tchk_msg -sdfmax /i2c_peri_tb/u1 = "../../../project/xo/vhdl/xo_vhdl/xo_vhdl_xo_vhdl_vho.sdf"

add wave *

run 37us