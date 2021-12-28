#-- Lattice Semiconductor Corporation Ltd.
#-- Synplify OEM project file d:/mike/noe/lscc2/b2/design\lc4256ze_synplify.tcl
#-- Written on Fri Oct 29 18:38:14 2010


#device options
set_option -technology ispmach4000b

#compilation/mapping options
set_option -symbolic_fsm_compiler true
set_option -map_logic false
set_option -max_terms_per_macrocell 16
set_option -resource_sharing true

#use verilog 2001 standard option
set_option -vlog_std v2001

#map options
set_option -frequency 200
set_option -fanin_limit 20
set_option -auto_constrain_io true
set_option -disable_io_insertion false
set_option -compiler_compatible true
set_option -dup false

#simulation options
set_option -write_verilog false
set_option -write_vhdl false

#timing analysis options
set_option -num_critical_paths 3
set_option -num_startend_points 0

#automatic place and route (vendor) options
set_option -write_apr_constraint 1
set_option -areadelay 0
set_option -synthesis_onoff_pragma false

#-- add_file options
add_file -verilog -lib work "C:/ispLEVER_Classic1_4/ispcpld/../cae_library/synthesis/verilog/mach.v"
add_file -verilog -lib work "lc4256ze.h"
add_file -verilog -lib work "lc4256ze.v"

#-- top module name
set_option -top_module lc4256ze

#-- set result format/file last
project -result_file "lc4256ze.edi"

#-- error message log file
project -log_file lc4256ze.srf

#-- run Synplify with 'arrange VHDL file'
project -run
