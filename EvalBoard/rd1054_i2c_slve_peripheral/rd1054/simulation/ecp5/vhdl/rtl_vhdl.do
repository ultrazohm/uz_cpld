set PROJ_DIR "Enter your simulation path here"  

# As an Example :
# set PROJ_DIR "D:\RD1054\simulation"

cd $PROJ_DIR\ecp5\vhdl

if {![file exists rtl_vhdl]} {
	 vlib rtl_vhdl
}
endif

design create rtl_vhdl .
design open rtl_vhdl
adel -all

cd $PROJ_DIR\ecp5\vhdl

acom ../../../source/vhdl/i2c_slave.vhd

vlog ../../../Testbench/Verilog/i2c_peri_tf.v
vlog ../../../Testbench/Verilog/i2c_mstr.v

vsim -L ovi_ecp5u -PL pmi_work +access +r i2c_peri_tb

add wave *
add wave top_inst/*

run 37us