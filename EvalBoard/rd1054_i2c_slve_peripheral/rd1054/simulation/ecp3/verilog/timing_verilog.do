set PROJ_DIR "ENTER YOUR SIMULATION PATH"  

# As an Example :
# set PROJ_DIR "D:\RD1054\simulation"

cd $PROJ_DIR\ecp3\verilog

if {![file exists timing_verilog]} {
	 vlib timing_verilog
}
endif

design create timing_verilog .
design open timing_verilog
adel -all

cd $PROJ_DIR\ecp3\verilog

vlog -dbg ../../../project/ecp3/verilog/ecp3_verilog/ecp3_verilog_ecp3_verilog_vo.vo


vlog -dbg +define+ECP3_TEST ../../../Testbench/Verilog/i2c_peri_tf.v
vlog -dbg +define+ECP3_TEST ../../../Testbench/Verilog/i2c_mstr.v



vsim -L ovi_ecp3 -PL pmi_work +access +r i2c_peri_tb -noglitch +no_tchk_msg -sdfmax /i2c_peri_tb/u1 = "../../../project/ecp3/verilog/ecp3_verilog/ecp3_verilog_ecp3_verilog_vo.sdf"

add wave *

run -all