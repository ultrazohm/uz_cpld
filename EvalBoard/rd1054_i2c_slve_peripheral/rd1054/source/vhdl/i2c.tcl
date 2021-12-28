
########## Tcl recorder starts at 12/28/21 14:09:45 ##########

set version "2.1"
set proj_dir "C:/GIT/UltraZohm/Software/cpld_lattice/EvalBoard/rd1054_i2c_slve_peripheral/rd1054/source/vhdl"
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
if [runCmd "\"$cpld_bin/vhd2jhd\" i2c_slave.vhd -o i2c_slave.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 14:09:45 ###########


########## Tcl recorder starts at 12/28/21 14:09:51 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: i2c_slave.vhd
OUTPUT_FILE_NAME: i2c_slave
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e i2c_slave -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_slave.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf i2c_slave.edi -out i2c_slave.bl0 -err automake.err -log i2c_slave.log -prj i2c -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 14:09:51 ###########


########## Tcl recorder starts at 12/28/21 14:10:12 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/mblifopt\" i2c_slave.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"i2c_slave.bl1\" -o \"i2c.bl2\" -omod \"i2c\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c -lci i2c.lct -log i2c.imp -err automake.err -tti i2c.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c.lct -blifopt i2c.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c.bl2 -sweep -mergefb -err automake.err -o i2c.bl3 @i2c.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c.lct -dev lc4k -diofft i2c.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c.bl3 -family AMDMACH -idev van -o i2c.bl4 -oxrf i2c.xrf -err automake.err @i2c.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c.lct -dev lc4k -prefit i2c.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c.bl4 -out i2c.bl5 -err automake.err -log i2c.log -mod i2c_slave @i2c.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i i2c.bl5 -o i2c.sif"] {
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
	puts $rspFile "-nodal -src i2c.bl5 -type BLIF -presrc i2c.bl3 -crf i2c.crf -sif i2c.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci i2c.lct
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

########## Tcl recorder end at 12/28/21 14:10:12 ###########


########## Tcl recorder starts at 12/28/21 14:11:13 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open i2c.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c.bl5 -lci i2c.lct -d m4e_256_96 -lco i2c.lco -html_rpt -fti i2c.fti -fmt PLA -tto i2c.tt4 -nojed -eqn i2c.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c.bl5 -lci i2c.lct -d m4e_256_96 -lco i2c.lco -html_rpt -fti i2c.fti -fmt PLA -tto i2c.tt4 -eqn i2c.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c.rs1
file delete i2c.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c.bl5 -o i2c.tda -lci i2c.lct -dev m4e_256_96 -family lc4k -mod i2c_slave -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c -if i2c.jed -j2s -log i2c.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 14:11:13 ###########


########## Tcl recorder starts at 12/28/21 14:12:00 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src i2c.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -postfit -lci i2c.lco
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

########## Tcl recorder end at 12/28/21 14:12:00 ###########


########## Tcl recorder starts at 12/28/21 14:13:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../../../../i2c_test/source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 14:13:17 ###########


########## Tcl recorder starts at 12/28/21 14:13:25 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open source.cmd w} rspFile] {
	puts stderr "Cannot create response file source.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c.sty
PROJECT: source
WORKING_PATH: \"$proj_dir\"
MODULE: source
VHDL_FILE_LIST: ../../../../i2c_test/source.vhd
OUTPUT_FILE_NAME: source
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e source -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete source.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf source.edi -out source.bl0 -err automake.err -log source.log -prj i2c -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 14:13:25 ###########


########## Tcl recorder starts at 12/28/21 14:14:11 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i i2c.bl5 -o i2c.sif"] {
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
	puts $rspFile "-nodal -src i2c.bl5 -type BLIF -presrc i2c.bl3 -crf i2c.crf -sif i2c.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci i2c.lct
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

########## Tcl recorder end at 12/28/21 14:14:11 ###########


########## Tcl recorder starts at 12/28/21 14:15:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" i2c_slave.vhd -o i2c_slave.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 14:15:35 ###########


########## Tcl recorder starts at 12/28/21 14:15:36 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: i2c_slave.vhd
OUTPUT_FILE_NAME: i2c_slave
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e i2c_slave -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_slave.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf i2c_slave.edi -out i2c_slave.bl0 -err automake.err -log i2c_slave.log -prj i2c -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 14:15:36 ###########


########## Tcl recorder starts at 12/28/21 14:17:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../../../../i2c_test/source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 14:17:14 ###########


########## Tcl recorder starts at 12/28/21 14:17:19 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open source.cmd w} rspFile] {
	puts stderr "Cannot create response file source.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c.sty
PROJECT: source
WORKING_PATH: \"$proj_dir\"
MODULE: source
VHDL_FILE_LIST: ../../../../i2c_test/source.vhd
OUTPUT_FILE_NAME: source
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e source -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete source.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf source.edi -out source.bl0 -err automake.err -log source.log -prj i2c -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 14:17:19 ###########


########## Tcl recorder starts at 12/28/21 14:17:40 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/mblifopt\" i2c_slave.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"i2c_slave.bl1\" -o \"i2c.bl2\" -omod \"i2c\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c -lci i2c.lct -log i2c.imp -err automake.err -tti i2c.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c.lct -blifopt i2c.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c.bl2 -sweep -mergefb -err automake.err -o i2c.bl3 @i2c.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c.lct -dev lc4k -diofft i2c.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c.bl3 -family AMDMACH -idev van -o i2c.bl4 -oxrf i2c.xrf -err automake.err @i2c.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c.lct -dev lc4k -prefit i2c.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c.bl4 -out i2c.bl5 -err automake.err -log i2c.log -mod i2c_slave @i2c.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i i2c.bl5 -o i2c.sif"] {
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
	puts $rspFile "-nodal -src i2c.bl5 -type BLIF -presrc i2c.bl3 -crf i2c.crf -sif i2c.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci i2c.lct
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

########## Tcl recorder end at 12/28/21 14:17:40 ###########

