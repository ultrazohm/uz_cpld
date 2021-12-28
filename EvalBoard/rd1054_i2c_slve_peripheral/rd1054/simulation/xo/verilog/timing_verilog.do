set PROJ_DIR "Enter your simulation path here"  

# As an Example :
# set PROJ_DIR "D:\RD1054\simulation"

cd $PROJ_DIR\xo\verilog

if {![file exists timing_verilog]} {
    vlib timing_verilog 
}
endif

design create timing_verilog .
design open timing_verilog
adel -all

cd $PROJ_DIR\xo\verilog

vlog -dbg ../../../project/xo/verilog/xo_verilog/XO_Verilog_XO_Verilog_vo.vo


vlog -dbg +define+XO_TEST ../../../TestBench/Verilog/i2c_peri_tf.v
vlog -dbg +define+XO_TEST ../../../TestBench/Verilog/i2c_mstr.v


vsim -L ovi_machxo -PL pmi_work +access +r i2c_peri_tb -noglitch +no_tchk_msg -sdfmax /i2c_peri_tb/u1 = "../../../project/xo/verilog/xo_verilog/XO_Verilog_XO_Verilog_vo.sdf"

add wave *

run -all