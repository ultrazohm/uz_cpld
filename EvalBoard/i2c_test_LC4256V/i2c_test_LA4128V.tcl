
########## Tcl recorder starts at 01/04/22 13:45:22 ##########

set version "2.1"
set proj_dir "C:/GIT/UltraZohm/Software/cpld_lattice/EvalBoard/i2c_test_LA4128V"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line; continue}
	if {$path && [regexp {^fpgabinpath} $lline]} {set fpga_bin $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]
set fpga_bin [string range $fpga_bin [expr [string first "=" $fpga_bin]+1] end]
regsub -all "\"" $fpga_bin "" fpga_bin
set fpga_bin [file join $fpga_bin]

if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$fpga_bin;$env(PATH)" }

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:45:22 ###########


########## Tcl recorder starts at 01/04/22 13:45:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" concat8.vhd -o concat8.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:45:31 ###########


########## Tcl recorder starts at 01/04/22 13:45:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:45:39 ###########


########## Tcl recorder starts at 01/04/22 13:45:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" debounce.vhd -o debounce.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:45:52 ###########


########## Tcl recorder starts at 01/04/22 13:46:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer8.vhd -o slicer8.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:46:04 ###########


########## Tcl recorder starts at 01/04/22 13:46:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" sourceclocked.vhd -o sourceclocked.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:46:12 ###########


########## Tcl recorder starts at 01/04/22 13:46:41 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test_la4128v.sty
PROJECT: concat8
WORKING_PATH: \"$proj_dir\"
MODULE: concat8
VHDL_FILE_LIST: concat8.vhd
OUTPUT_FILE_NAME: concat8
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e concat8 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete concat8.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test_la4128v -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:46:41 ###########


########## Tcl recorder starts at 01/04/22 13:46:57 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" concat8"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:46:57 ###########


########## Tcl recorder starts at 01/04/22 13:47:02 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test_la4128v.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: debounce.vhd I2C_minion.vhd
OUTPUT_FILE_NAME: I2C_minion
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e I2C_minion -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete I2C_minion.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test_la4128v -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:47:02 ###########


########## Tcl recorder starts at 01/04/22 13:47:21 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" I2C_minion"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:47:21 ###########


########## Tcl recorder starts at 01/04/22 13:47:27 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slice8.cmd w} rspFile] {
	puts stderr "Cannot create response file slice8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test_la4128v.sty
PROJECT: slice8
WORKING_PATH: \"$proj_dir\"
MODULE: slice8
VHDL_FILE_LIST: slicer8.vhd
OUTPUT_FILE_NAME: slice8
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e slice8 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slice8.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slice8.edi -out slice8.bl0 -err automake.err -log slice8.log -prj i2c_test_la4128v -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:47:27 ###########


########## Tcl recorder starts at 01/04/22 13:47:44 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slice8"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:47:44 ###########


########## Tcl recorder starts at 01/04/22 13:47:49 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open sourceclocked.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceclocked.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test_la4128v.sty
PROJECT: sourceclocked
WORKING_PATH: \"$proj_dir\"
MODULE: sourceclocked
VHDL_FILE_LIST: sourceclocked.vhd
OUTPUT_FILE_NAME: sourceclocked
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e sourceclocked -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete sourceclocked.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceclocked.edi -out sourceclocked.bl0 -err automake.err -log sourceclocked.log -prj i2c_test_la4128v -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:47:49 ###########


########## Tcl recorder starts at 01/04/22 13:48:06 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" sourceclocked"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:48:06 ###########


########## Tcl recorder starts at 01/04/22 13:48:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:48:23 ###########


########## Tcl recorder starts at 01/04/22 13:48:27 ##########

# Commands to make the Process: 
# Navigate Hierarchy
# - none -
# Application to view the Process: 
# Navigate Hierarchy
if [runCmd "\"$cpld_bin/hiernav\" io_pins.sch"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:48:27 ###########


########## Tcl recorder starts at 01/04/22 13:48:31 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup io_pins.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bls\" -o \"io_pins.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:48:31 ###########


########## Tcl recorder starts at 01/04/22 13:48:35 ##########

# Commands to make the Process: 
# Update All Schematic Files
if [runCmd "\"$cpld_bin/updatesc\" io_pins.sch -yield"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:48:35 ###########


########## Tcl recorder starts at 01/04/22 13:48:37 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" sourceclocked.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" slice8.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" I2C_minion.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" concat8.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bl1\" -o \"i2c_test_la4128v.bl2\" -omod \"i2c_test_la4128v\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c_test_la4128v -lci i2c_test_la4128v.lct -log i2c_test_la4128v.imp -err automake.err -tti i2c_test_la4128v.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -blifopt i2c_test_la4128v.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_test_la4128v.bl2 -sweep -mergefb -err automake.err -o i2c_test_la4128v.bl3 @i2c_test_la4128v.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -dev lc4k -diofft i2c_test_la4128v.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c_test_la4128v.bl3 -family AMDMACH -idev van -o i2c_test_la4128v.bl4 -oxrf i2c_test_la4128v.xrf -err automake.err @i2c_test_la4128v.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -dev lc4k -prefit i2c_test_la4128v.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c_test_la4128v.bl4 -out i2c_test_la4128v.bl5 -err automake.err -log i2c_test_la4128v.log -mod io_pins @i2c_test_la4128v.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i i2c_test_la4128v.bl5 -o i2c_test_la4128v.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src i2c_test_la4128v.bl5 -type BLIF -presrc i2c_test_la4128v.bl3 -crf i2c_test_la4128v.crf -sif i2c_test_la4128v.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci i2c_test_la4128v.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:48:37 ###########


########## Tcl recorder starts at 01/04/22 13:58:32 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i i2c_test_la4128v.bl5 -o i2c_test_la4128v.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src i2c_test_la4128v.bl5 -type BLIF -presrc i2c_test_la4128v.bl3 -crf i2c_test_la4128v.crf -sif i2c_test_la4128v.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci i2c_test_la4128v.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:58:32 ###########


########## Tcl recorder starts at 01/04/22 13:59:44 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open i2c_test_la4128v.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_la4128v.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test_la4128v.bl5 -lci i2c_test_la4128v.lct -d m4s_128_64 -lco i2c_test_la4128v.lco -html_rpt -fti i2c_test_la4128v.fti -fmt PLA -tto i2c_test_la4128v.tt4 -nojed -eqn i2c_test_la4128v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test_la4128v.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_la4128v.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test_la4128v.bl5 -lci i2c_test_la4128v.lct -d m4s_128_64 -lco i2c_test_la4128v.lco -html_rpt -fti i2c_test_la4128v.fti -fmt PLA -tto i2c_test_la4128v.tt4 -eqn i2c_test_la4128v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test_la4128v.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test_la4128v.rs1
file delete i2c_test_la4128v.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test_la4128v.bl5 -o i2c_test_la4128v.tda -lci i2c_test_la4128v.lct -dev m4s_128_64 -family lc4k -mod io_pins -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test_la4128v -if i2c_test_la4128v.jed -j2s -log i2c_test_la4128v.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 13:59:44 ###########


########## Tcl recorder starts at 01/04/22 14:04:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:04:31 ###########


########## Tcl recorder starts at 01/04/22 14:04:46 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup io_pins.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bls\" -o \"io_pins.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:04:46 ###########


########## Tcl recorder starts at 01/04/22 14:04:48 ##########

# Commands to make the Process: 
# Update All Schematic Files
if [runCmd "\"$cpld_bin/updatesc\" io_pins.sch -yield"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:04:48 ###########


########## Tcl recorder starts at 01/04/22 14:04:50 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bl1\" -o \"i2c_test_la4128v.bl2\" -omod \"i2c_test_la4128v\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c_test_la4128v -lci i2c_test_la4128v.lct -log i2c_test_la4128v.imp -err automake.err -tti i2c_test_la4128v.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -blifopt i2c_test_la4128v.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_test_la4128v.bl2 -sweep -mergefb -err automake.err -o i2c_test_la4128v.bl3 @i2c_test_la4128v.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -dev lc4k -diofft i2c_test_la4128v.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c_test_la4128v.bl3 -family AMDMACH -idev van -o i2c_test_la4128v.bl4 -oxrf i2c_test_la4128v.xrf -err automake.err @i2c_test_la4128v.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -dev lc4k -prefit i2c_test_la4128v.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c_test_la4128v.bl4 -out i2c_test_la4128v.bl5 -err automake.err -log i2c_test_la4128v.log -mod io_pins @i2c_test_la4128v.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i i2c_test_la4128v.bl5 -o i2c_test_la4128v.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src i2c_test_la4128v.bl5 -type BLIF -presrc i2c_test_la4128v.bl3 -crf i2c_test_la4128v.crf -sif i2c_test_la4128v.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci i2c_test_la4128v.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:04:50 ###########


########## Tcl recorder starts at 01/04/22 14:06:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open i2c_test_la4128v.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_la4128v.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test_la4128v.bl5 -lci i2c_test_la4128v.lct -d m4s_128_64 -lco i2c_test_la4128v.lco -html_rpt -fti i2c_test_la4128v.fti -fmt PLA -tto i2c_test_la4128v.tt4 -nojed -eqn i2c_test_la4128v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test_la4128v.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_la4128v.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test_la4128v.bl5 -lci i2c_test_la4128v.lct -d m4s_128_64 -lco i2c_test_la4128v.lco -html_rpt -fti i2c_test_la4128v.fti -fmt PLA -tto i2c_test_la4128v.tt4 -eqn i2c_test_la4128v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test_la4128v.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test_la4128v.rs1
file delete i2c_test_la4128v.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test_la4128v.bl5 -o i2c_test_la4128v.tda -lci i2c_test_la4128v.lct -dev m4s_128_64 -family lc4k -mod io_pins -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test_la4128v -if i2c_test_la4128v.jed -j2s -log i2c_test_la4128v.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:06:36 ###########


########## Tcl recorder starts at 01/04/22 14:07:10 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i i2c_test_la4128v.bl5 -o i2c_test_la4128v.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src i2c_test_la4128v.bl5 -type BLIF -presrc i2c_test_la4128v.bl3 -crf i2c_test_la4128v.crf -sif i2c_test_la4128v.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci i2c_test_la4128v.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:07:10 ###########


########## Tcl recorder starts at 01/04/22 14:07:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:07:52 ###########


########## Tcl recorder starts at 01/04/22 14:08:03 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup io_pins.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bls\" -o \"io_pins.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:08:03 ###########


########## Tcl recorder starts at 01/04/22 14:08:07 ##########

# Commands to make the Process: 
# Update All Schematic Files
if [runCmd "\"$cpld_bin/updatesc\" io_pins.sch -yield"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:08:07 ###########


########## Tcl recorder starts at 01/04/22 14:08:09 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bl1\" -o \"i2c_test_la4128v.bl2\" -omod \"i2c_test_la4128v\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c_test_la4128v -lci i2c_test_la4128v.lct -log i2c_test_la4128v.imp -err automake.err -tti i2c_test_la4128v.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -blifopt i2c_test_la4128v.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_test_la4128v.bl2 -sweep -mergefb -err automake.err -o i2c_test_la4128v.bl3 @i2c_test_la4128v.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -dev lc4k -diofft i2c_test_la4128v.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c_test_la4128v.bl3 -family AMDMACH -idev van -o i2c_test_la4128v.bl4 -oxrf i2c_test_la4128v.xrf -err automake.err @i2c_test_la4128v.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -dev lc4k -prefit i2c_test_la4128v.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c_test_la4128v.bl4 -out i2c_test_la4128v.bl5 -err automake.err -log i2c_test_la4128v.log -mod io_pins @i2c_test_la4128v.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i i2c_test_la4128v.bl5 -o i2c_test_la4128v.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src i2c_test_la4128v.bl5 -type BLIF -presrc i2c_test_la4128v.bl3 -crf i2c_test_la4128v.crf -sif i2c_test_la4128v.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci i2c_test_la4128v.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:08:09 ###########


########## Tcl recorder starts at 01/04/22 14:08:35 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open i2c_test_la4128v.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_la4128v.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test_la4128v.bl5 -lci i2c_test_la4128v.lct -d m4s_128_64 -lco i2c_test_la4128v.lco -html_rpt -fti i2c_test_la4128v.fti -fmt PLA -tto i2c_test_la4128v.tt4 -nojed -eqn i2c_test_la4128v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test_la4128v.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_la4128v.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test_la4128v.bl5 -lci i2c_test_la4128v.lct -d m4s_128_64 -lco i2c_test_la4128v.lco -html_rpt -fti i2c_test_la4128v.fti -fmt PLA -tto i2c_test_la4128v.tt4 -eqn i2c_test_la4128v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test_la4128v.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test_la4128v.rs1
file delete i2c_test_la4128v.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test_la4128v.bl5 -o i2c_test_la4128v.tda -lci i2c_test_la4128v.lct -dev m4s_128_64 -family lc4k -mod io_pins -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test_la4128v -if i2c_test_la4128v.jed -j2s -log i2c_test_la4128v.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:08:35 ###########


########## Tcl recorder starts at 01/04/22 14:09:24 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src i2c_test_la4128v.bl5 -type BLIF -presrc i2c_test_la4128v.bl3 -crf i2c_test_la4128v.crf -sif i2c_test_la4128v.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci i2c_test_la4128v.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:09:24 ###########


########## Tcl recorder starts at 01/04/22 14:10:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:10:48 ###########


########## Tcl recorder starts at 01/04/22 14:10:50 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup io_pins.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bls\" -o \"io_pins.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:10:50 ###########


########## Tcl recorder starts at 01/04/22 14:10:54 ##########

# Commands to make the Process: 
# Update All Schematic Files
if [runCmd "\"$cpld_bin/updatesc\" io_pins.sch -yield"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:10:54 ###########


########## Tcl recorder starts at 01/04/22 14:10:55 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bl1\" -o \"i2c_test_la4128v.bl2\" -omod \"i2c_test_la4128v\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c_test_la4128v -lci i2c_test_la4128v.lct -log i2c_test_la4128v.imp -err automake.err -tti i2c_test_la4128v.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -blifopt i2c_test_la4128v.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_test_la4128v.bl2 -sweep -mergefb -err automake.err -o i2c_test_la4128v.bl3 @i2c_test_la4128v.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -dev lc4k -diofft i2c_test_la4128v.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c_test_la4128v.bl3 -family AMDMACH -idev van -o i2c_test_la4128v.bl4 -oxrf i2c_test_la4128v.xrf -err automake.err @i2c_test_la4128v.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -dev lc4k -prefit i2c_test_la4128v.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c_test_la4128v.bl4 -out i2c_test_la4128v.bl5 -err automake.err -log i2c_test_la4128v.log -mod io_pins @i2c_test_la4128v.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open i2c_test_la4128v.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_la4128v.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test_la4128v.bl5 -lci i2c_test_la4128v.lct -d m4s_128_64 -lco i2c_test_la4128v.lco -html_rpt -fti i2c_test_la4128v.fti -fmt PLA -tto i2c_test_la4128v.tt4 -nojed -eqn i2c_test_la4128v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test_la4128v.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_la4128v.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test_la4128v.bl5 -lci i2c_test_la4128v.lct -d m4s_128_64 -lco i2c_test_la4128v.lco -html_rpt -fti i2c_test_la4128v.fti -fmt PLA -tto i2c_test_la4128v.tt4 -eqn i2c_test_la4128v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test_la4128v.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test_la4128v.rs1
file delete i2c_test_la4128v.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test_la4128v.bl5 -o i2c_test_la4128v.tda -lci i2c_test_la4128v.lct -dev m4s_128_64 -family lc4k -mod io_pins -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test_la4128v -if i2c_test_la4128v.jed -j2s -log i2c_test_la4128v.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:10:55 ###########


########## Tcl recorder starts at 01/04/22 14:12:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:12:06 ###########


########## Tcl recorder starts at 01/04/22 14:12:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:12:22 ###########


########## Tcl recorder starts at 01/04/22 14:12:27 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup io_pins.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bls\" -o \"io_pins.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:12:27 ###########


########## Tcl recorder starts at 01/04/22 14:12:29 ##########

# Commands to make the Process: 
# Update All Schematic Files
if [runCmd "\"$cpld_bin/updatesc\" io_pins.sch -yield"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:12:29 ###########


########## Tcl recorder starts at 01/04/22 14:12:30 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bl1\" -o \"i2c_test_la4128v.bl2\" -omod \"i2c_test_la4128v\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c_test_la4128v -lci i2c_test_la4128v.lct -log i2c_test_la4128v.imp -err automake.err -tti i2c_test_la4128v.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -blifopt i2c_test_la4128v.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_test_la4128v.bl2 -sweep -mergefb -err automake.err -o i2c_test_la4128v.bl3 @i2c_test_la4128v.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -dev lc4k -diofft i2c_test_la4128v.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c_test_la4128v.bl3 -family AMDMACH -idev van -o i2c_test_la4128v.bl4 -oxrf i2c_test_la4128v.xrf -err automake.err @i2c_test_la4128v.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -dev lc4k -prefit i2c_test_la4128v.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c_test_la4128v.bl4 -out i2c_test_la4128v.bl5 -err automake.err -log i2c_test_la4128v.log -mod io_pins @i2c_test_la4128v.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open i2c_test_la4128v.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_la4128v.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test_la4128v.bl5 -lci i2c_test_la4128v.lct -d m4s_128_64 -lco i2c_test_la4128v.lco -html_rpt -fti i2c_test_la4128v.fti -fmt PLA -tto i2c_test_la4128v.tt4 -nojed -eqn i2c_test_la4128v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test_la4128v.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_la4128v.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test_la4128v.bl5 -lci i2c_test_la4128v.lct -d m4s_128_64 -lco i2c_test_la4128v.lco -html_rpt -fti i2c_test_la4128v.fti -fmt PLA -tto i2c_test_la4128v.tt4 -eqn i2c_test_la4128v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test_la4128v.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test_la4128v.rs1
file delete i2c_test_la4128v.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test_la4128v.bl5 -o i2c_test_la4128v.tda -lci i2c_test_la4128v.lct -dev m4s_128_64 -family lc4k -mod io_pins -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test_la4128v -if i2c_test_la4128v.jed -j2s -log i2c_test_la4128v.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:12:30 ###########


########## Tcl recorder starts at 01/04/22 14:14:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:14:37 ###########


########## Tcl recorder starts at 01/04/22 14:14:49 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup io_pins.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bls\" -o \"io_pins.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:14:50 ###########


########## Tcl recorder starts at 01/04/22 14:14:53 ##########

# Commands to make the Process: 
# Update All Schematic Files
if [runCmd "\"$cpld_bin/updatesc\" io_pins.sch -yield"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:14:53 ###########


########## Tcl recorder starts at 01/04/22 14:14:54 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bl1\" -o \"i2c_test_la4128v.bl2\" -omod \"i2c_test_la4128v\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c_test_la4128v -lci i2c_test_la4128v.lct -log i2c_test_la4128v.imp -err automake.err -tti i2c_test_la4128v.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -blifopt i2c_test_la4128v.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_test_la4128v.bl2 -sweep -mergefb -err automake.err -o i2c_test_la4128v.bl3 @i2c_test_la4128v.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -dev lc4k -diofft i2c_test_la4128v.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c_test_la4128v.bl3 -family AMDMACH -idev van -o i2c_test_la4128v.bl4 -oxrf i2c_test_la4128v.xrf -err automake.err @i2c_test_la4128v.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -dev lc4k -prefit i2c_test_la4128v.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c_test_la4128v.bl4 -out i2c_test_la4128v.bl5 -err automake.err -log i2c_test_la4128v.log -mod io_pins @i2c_test_la4128v.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open i2c_test_la4128v.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_la4128v.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test_la4128v.bl5 -lci i2c_test_la4128v.lct -d m4s_128_64 -lco i2c_test_la4128v.lco -html_rpt -fti i2c_test_la4128v.fti -fmt PLA -tto i2c_test_la4128v.tt4 -nojed -eqn i2c_test_la4128v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test_la4128v.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_la4128v.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test_la4128v.bl5 -lci i2c_test_la4128v.lct -d m4s_128_64 -lco i2c_test_la4128v.lco -html_rpt -fti i2c_test_la4128v.fti -fmt PLA -tto i2c_test_la4128v.tt4 -eqn i2c_test_la4128v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test_la4128v.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test_la4128v.rs1
file delete i2c_test_la4128v.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test_la4128v.bl5 -o i2c_test_la4128v.tda -lci i2c_test_la4128v.lct -dev m4s_128_64 -family lc4k -mod io_pins -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test_la4128v -if i2c_test_la4128v.jed -j2s -log i2c_test_la4128v.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:14:54 ###########


########## Tcl recorder starts at 01/04/22 14:16:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:16:57 ###########


########## Tcl recorder starts at 01/04/22 14:17:05 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup io_pins.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bls\" -o \"io_pins.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:17:05 ###########


########## Tcl recorder starts at 01/04/22 14:17:07 ##########

# Commands to make the Process: 
# Update All Schematic Files
if [runCmd "\"$cpld_bin/updatesc\" io_pins.sch -yield"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:17:07 ###########


########## Tcl recorder starts at 01/04/22 14:17:12 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bl1\" -o \"i2c_test_la4128v.bl2\" -omod \"i2c_test_la4128v\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c_test_la4128v -lci i2c_test_la4128v.lct -log i2c_test_la4128v.imp -err automake.err -tti i2c_test_la4128v.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -blifopt i2c_test_la4128v.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_test_la4128v.bl2 -sweep -mergefb -err automake.err -o i2c_test_la4128v.bl3 @i2c_test_la4128v.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -dev lc4k -diofft i2c_test_la4128v.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c_test_la4128v.bl3 -family AMDMACH -idev van -o i2c_test_la4128v.bl4 -oxrf i2c_test_la4128v.xrf -err automake.err @i2c_test_la4128v.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -dev lc4k -prefit i2c_test_la4128v.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c_test_la4128v.bl4 -out i2c_test_la4128v.bl5 -err automake.err -log i2c_test_la4128v.log -mod io_pins @i2c_test_la4128v.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open i2c_test_la4128v.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_la4128v.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test_la4128v.bl5 -lci i2c_test_la4128v.lct -d m4s_128_64 -lco i2c_test_la4128v.lco -html_rpt -fti i2c_test_la4128v.fti -fmt PLA -tto i2c_test_la4128v.tt4 -nojed -eqn i2c_test_la4128v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test_la4128v.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_la4128v.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test_la4128v.bl5 -lci i2c_test_la4128v.lct -d m4s_128_64 -lco i2c_test_la4128v.lco -html_rpt -fti i2c_test_la4128v.fti -fmt PLA -tto i2c_test_la4128v.tt4 -eqn i2c_test_la4128v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test_la4128v.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test_la4128v.rs1
file delete i2c_test_la4128v.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test_la4128v.bl5 -o i2c_test_la4128v.tda -lci i2c_test_la4128v.lct -dev m4s_128_64 -family lc4k -mod io_pins -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test_la4128v -if i2c_test_la4128v.jed -j2s -log i2c_test_la4128v.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:17:12 ###########


########## Tcl recorder starts at 01/04/22 14:20:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:20:35 ###########


########## Tcl recorder starts at 01/04/22 14:20:38 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test_la4128v.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: debounce.vhd I2C_minion.vhd
OUTPUT_FILE_NAME: I2C_minion
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e I2C_minion -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete I2C_minion.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test_la4128v -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:20:38 ###########


########## Tcl recorder starts at 01/04/22 14:20:59 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" I2C_minion"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:20:59 ###########


########## Tcl recorder starts at 01/04/22 14:22:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:22:02 ###########


########## Tcl recorder starts at 01/04/22 14:22:05 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup io_pins.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bls\" -o \"io_pins.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:22:05 ###########


########## Tcl recorder starts at 01/04/22 14:22:11 ##########

# Commands to make the Process: 
# Update All Schematic Files
if [runCmd "\"$cpld_bin/updatesc\" io_pins.sch -yield"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:22:11 ###########


########## Tcl recorder starts at 01/04/22 14:22:13 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" I2C_minion.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bl1\" -o \"i2c_test_la4128v.bl2\" -omod \"i2c_test_la4128v\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c_test_la4128v -lci i2c_test_la4128v.lct -log i2c_test_la4128v.imp -err automake.err -tti i2c_test_la4128v.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -blifopt i2c_test_la4128v.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_test_la4128v.bl2 -sweep -mergefb -err automake.err -o i2c_test_la4128v.bl3 @i2c_test_la4128v.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -dev lc4k -diofft i2c_test_la4128v.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c_test_la4128v.bl3 -family AMDMACH -idev van -o i2c_test_la4128v.bl4 -oxrf i2c_test_la4128v.xrf -err automake.err @i2c_test_la4128v.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_la4128v.lct -dev lc4k -prefit i2c_test_la4128v.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c_test_la4128v.bl4 -out i2c_test_la4128v.bl5 -err automake.err -log i2c_test_la4128v.log -mod io_pins @i2c_test_la4128v.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open i2c_test_la4128v.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_la4128v.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test_la4128v.bl5 -lci i2c_test_la4128v.lct -d m4s_128_64 -lco i2c_test_la4128v.lco -html_rpt -fti i2c_test_la4128v.fti -fmt PLA -tto i2c_test_la4128v.tt4 -nojed -eqn i2c_test_la4128v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test_la4128v.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_la4128v.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test_la4128v.bl5 -lci i2c_test_la4128v.lct -d m4s_128_64 -lco i2c_test_la4128v.lco -html_rpt -fti i2c_test_la4128v.fti -fmt PLA -tto i2c_test_la4128v.tt4 -eqn i2c_test_la4128v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test_la4128v.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test_la4128v.rs1
file delete i2c_test_la4128v.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test_la4128v.bl5 -o i2c_test_la4128v.tda -lci i2c_test_la4128v.lct -dev m4s_128_64 -family lc4k -mod io_pins -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test_la4128v -if i2c_test_la4128v.jed -j2s -log i2c_test_la4128v.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/04/22 14:22:13 ###########

