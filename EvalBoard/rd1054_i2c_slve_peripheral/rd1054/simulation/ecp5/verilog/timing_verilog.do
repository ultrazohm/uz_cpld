set PROJ_DIR "Enter your simulation path here"  

# As an Example :
# set PROJ_DIR "D:\RD1054\simulation"

cd $PROJ_DIR\ecp5\verilog

if {![file exists timing_verilog]} {
	 vlib timing_verilog
}
endif

design create timing_verilog .
design open timing_verilog
adel -all

cd $PROJ_DIR\ecp5\verilog

vlog -dbg ../../../project/ecp5/verilog/ecp5_verilog/ecp5_Verilog_ecp5_Verilog_vo.vo


vlog -dbg +define+ECP5_TEST ../../../Testbench/Verilog/i2c_peri_tf.v
vlog -dbg +define+ECP5_TEST ../../../Testbench/Verilog/i2c_mstr.v



vsim -L ovi_ecp5u -PL pmi_work +access +r i2c_peri_tb -noglitch +no_tchk_msg -sdfmax /i2c_peri_tb/u1 = "../../../project/ecp5/verilog/ecp5_verilog/ecp5_verilog_ecp5_verilog_vo.sdf"

add wave *

run -all