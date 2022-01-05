
########## Tcl recorder starts at 03/21/21 12:44:01 ##########

set version "2.1"
set proj_dir "C:/ZynqUltra/60_Software/cpld_lattice/EvalBoard/i2c_test"
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

########## Tcl recorder end at 03/21/21 12:44:01 ###########


########## Tcl recorder starts at 03/21/21 12:44:08 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf i2c_slave.edi -out i2c_slave.bl0 -err automake.err -log i2c_slave.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_slave.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"i2c_slave.bl1\" -o \"i2c_test.bl2\" -omod \"i2c_test\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c_test -lci i2c_test.lct -log i2c_test.imp -err automake.err -tti i2c_test.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test.lct -blifopt i2c_test.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_test.bl2 -sweep -mergefb -err automake.err -o i2c_test.bl3 @i2c_test.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test.lct -dev lc4k -diofft i2c_test.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c_test.bl3 -family AMDMACH -idev van -o i2c_test.bl4 -oxrf i2c_test.xrf -err automake.err @i2c_test.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test.lct -dev lc4k -prefit i2c_test.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c_test.bl4 -out i2c_test.bl5 -err automake.err -log i2c_test.log -mod i2c_slave @i2c_test.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open i2c_test.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test.bl5 -lci i2c_test.lct -d m4e_256_96 -lco i2c_test.lco -html_rpt -fti i2c_test.fti -fmt PLA -tto i2c_test.tt4 -nojed -eqn i2c_test.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test.bl5 -lci i2c_test.lct -d m4e_256_96 -lco i2c_test.lco -html_rpt -fti i2c_test.fti -fmt PLA -tto i2c_test.tt4 -eqn i2c_test.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test.rs1
file delete i2c_test.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test.bl5 -o i2c_test.tda -lci i2c_test.lct -dev m4e_256_96 -family lc4k -mod i2c_slave -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/21/21 12:44:08 ###########


########## Tcl recorder starts at 03/21/21 12:44:48 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i i2c_test.bl5 -o i2c_test.sif"] {
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
	puts $rspFile "-nodal -src i2c_test.bl5 -type BLIF -presrc i2c_test.bl3 -crf i2c_test.crf -sif i2c_test.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci i2c_test.lct
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

########## Tcl recorder end at 03/21/21 12:44:48 ###########


########## Tcl recorder starts at 03/21/21 12:54:57 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src i2c_test.bl5 -type BLIF -presrc i2c_test.bl3 -crf i2c_test.crf -sif i2c_test.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci i2c_test.lct
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

########## Tcl recorder end at 03/21/21 12:54:57 ###########


########## Tcl recorder starts at 03/21/21 12:55:41 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src i2c_test.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -postfit -lci i2c_test.lco
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

########## Tcl recorder end at 03/21/21 12:55:41 ###########


########## Tcl recorder starts at 03/22/21 11:41:45 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src i2c_test.bl5 -type BLIF -presrc i2c_test.bl3 -crf i2c_test.crf -sif i2c_test.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci i2c_test.lct
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

########## Tcl recorder end at 03/22/21 11:41:45 ###########


########## Tcl recorder starts at 03/22/21 11:41:54 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src i2c_test.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -postfit -lci i2c_test.lco
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

########## Tcl recorder end at 03/22/21 11:41:54 ###########


########## Tcl recorder starts at 03/22/21 15:20:11 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src i2c_test.bl5 -type BLIF -presrc i2c_test.bl3 -crf i2c_test.crf -sif i2c_test.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci i2c_test.lct
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

########## Tcl recorder end at 03/22/21 15:20:11 ###########


########## Tcl recorder starts at 03/22/21 15:20:25 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src i2c_test.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -postfit -lci i2c_test.lco
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

########## Tcl recorder end at 03/22/21 15:20:25 ###########


########## Tcl recorder starts at 03/22/21 15:21:19 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src i2c_test.bl5 -type BLIF -presrc i2c_test.bl3 -crf i2c_test.crf -sif i2c_test.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci i2c_test.lct
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

########## Tcl recorder end at 03/22/21 15:21:19 ###########


########## Tcl recorder starts at 03/22/21 15:21:54 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open i2c_test.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test.bl5 -lci i2c_test.lct -d m4e_256_96 -lco i2c_test.lco -html_rpt -fti i2c_test.fti -fmt PLA -tto i2c_test.tt4 -nojed -eqn i2c_test.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test.bl5 -lci i2c_test.lct -d m4e_256_96 -lco i2c_test.lco -html_rpt -fti i2c_test.fti -fmt PLA -tto i2c_test.tt4 -eqn i2c_test.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test.rs1
file delete i2c_test.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test.bl5 -o i2c_test.tda -lci i2c_test.lct -dev m4e_256_96 -family lc4k -mod i2c_slave -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/22/21 15:21:54 ###########


########## Tcl recorder starts at 03/22/21 15:23:45 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i i2c_test.bl5 -o i2c_test.sif"] {
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
	puts $rspFile "-nodal -src i2c_test.bl5 -type BLIF -presrc i2c_test.bl3 -crf i2c_test.crf -sif i2c_test.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci i2c_test.lct
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

########## Tcl recorder end at 03/22/21 15:23:45 ###########


########## Tcl recorder starts at 03/22/21 15:25:04 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open i2c_test.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test.bl5 -lci i2c_test.lct -d m4e_256_96 -lco i2c_test.lco -html_rpt -fti i2c_test.fti -fmt PLA -tto i2c_test.tt4 -nojed -eqn i2c_test.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test.bl5 -lci i2c_test.lct -d m4e_256_96 -lco i2c_test.lco -html_rpt -fti i2c_test.fti -fmt PLA -tto i2c_test.tt4 -eqn i2c_test.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test.rs1
file delete i2c_test.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test.bl5 -o i2c_test.tda -lci i2c_test.lct -dev m4e_256_96 -family lc4k -mod i2c_slave -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/22/21 15:25:04 ###########


########## Tcl recorder starts at 03/22/21 15:25:35 ##########

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

########## Tcl recorder end at 03/22/21 15:25:35 ###########


########## Tcl recorder starts at 03/22/21 15:39:52 ##########

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

########## Tcl recorder end at 03/22/21 15:39:52 ###########


########## Tcl recorder starts at 03/22/21 15:40:00 ##########

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

########## Tcl recorder end at 03/22/21 15:40:00 ###########


########## Tcl recorder starts at 03/22/21 15:40:55 ##########

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

########## Tcl recorder end at 03/22/21 15:40:55 ###########


########## Tcl recorder starts at 03/22/21 15:41:25 ##########

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

########## Tcl recorder end at 03/22/21 15:41:25 ###########


########## Tcl recorder starts at 03/22/21 15:42:09 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/mblflink\" \"i2c_slave.bl1\" -o \"i2c_test.bl2\" -omod \"i2c_test\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c_test -lci i2c_test.lct -log i2c_test.imp -err automake.err -tti i2c_test.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test.lct -blifopt i2c_test.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_test.bl2 -sweep -mergefb -err automake.err -o i2c_test.bl3 @i2c_test.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test.lct -dev lc4k -diofft i2c_test.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c_test.bl3 -family AMDMACH -idev van -o i2c_test.bl4 -oxrf i2c_test.xrf -err automake.err @i2c_test.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test.lct -dev lc4k -prefit i2c_test.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c_test.bl4 -out i2c_test.bl5 -err automake.err -log i2c_test.log -mod i2c_slave @i2c_test.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i i2c_test.bl5 -o i2c_test.sif"] {
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
	puts $rspFile "-nodal -src i2c_test.bl5 -type BLIF -presrc i2c_test.bl3 -crf i2c_test.crf -sif i2c_test.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci i2c_test.lct
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

########## Tcl recorder end at 03/22/21 15:42:09 ###########


########## Tcl recorder starts at 03/22/21 15:48:00 ##########

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

########## Tcl recorder end at 03/22/21 15:48:00 ###########


########## Tcl recorder starts at 03/22/21 15:50:03 ##########

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
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bl1\" -o \"i2c_test.bl2\" -omod \"i2c_test\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c_test -lci i2c_test.lct -log i2c_test.imp -err automake.err -tti i2c_test.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test.lct -blifopt i2c_test.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_test.bl2 -sweep -mergefb -err automake.err -o i2c_test.bl3 @i2c_test.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test.lct -dev lc4k -diofft i2c_test.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c_test.bl3 -family AMDMACH -idev van -o i2c_test.bl4 -oxrf i2c_test.xrf -err automake.err @i2c_test.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test.lct -dev lc4k -prefit i2c_test.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c_test.bl4 -out i2c_test.bl5 -err automake.err -log i2c_test.log -mod io_pins @i2c_test.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i i2c_test.bl5 -o i2c_test.sif"] {
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
	puts $rspFile "-nodal -src i2c_test.bl5 -type BLIF -presrc i2c_test.bl3 -crf i2c_test.crf -sif i2c_test.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci i2c_test.lct
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

########## Tcl recorder end at 03/22/21 15:50:03 ###########


########## Tcl recorder starts at 03/22/21 15:51:20 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open i2c_test.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test.bl5 -lci i2c_test.lct -d m4e_256_96 -lco i2c_test.lco -html_rpt -fti i2c_test.fti -fmt PLA -tto i2c_test.tt4 -nojed -eqn i2c_test.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test.bl5 -lci i2c_test.lct -d m4e_256_96 -lco i2c_test.lco -html_rpt -fti i2c_test.fti -fmt PLA -tto i2c_test.tt4 -eqn i2c_test.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test.rs1
file delete i2c_test.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test.bl5 -o i2c_test.tda -lci i2c_test.lct -dev m4e_256_96 -family lc4k -mod io_pins -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/22/21 15:51:20 ###########


########## Tcl recorder starts at 03/26/21 18:54:45 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i i2c_test.bl5 -o i2c_test.sif"] {
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
	puts $rspFile "-nodal -src i2c_test.bl5 -type BLIF -presrc i2c_test.bl3 -crf i2c_test.crf -sif i2c_test.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci i2c_test.lct
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

########## Tcl recorder end at 03/26/21 18:54:46 ###########


########## Tcl recorder starts at 03/26/21 18:55:22 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/mblflink\" \"i2c_slave.bl1\" -o \"i2c_test.bl2\" -omod \"i2c_test\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c_test -lci i2c_test.lct -log i2c_test.imp -err automake.err -tti i2c_test.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test.lct -blifopt i2c_test.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_test.bl2 -sweep -mergefb -err automake.err -o i2c_test.bl3 @i2c_test.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test.lct -dev lc4k -diofft i2c_test.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c_test.bl3 -family AMDMACH -idev van -o i2c_test.bl4 -oxrf i2c_test.xrf -err automake.err @i2c_test.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test.lct -dev lc4k -prefit i2c_test.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c_test.bl4 -out i2c_test.bl5 -err automake.err -log i2c_test.log -mod i2c_slave @i2c_test.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i i2c_test.bl5 -o i2c_test.sif"] {
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
	puts $rspFile "-nodal -src i2c_test.bl5 -type BLIF -presrc i2c_test.bl3 -crf i2c_test.crf -sif i2c_test.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci i2c_test.lct
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

########## Tcl recorder end at 03/26/21 18:55:22 ###########


########## Tcl recorder starts at 03/26/21 18:56:32 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open i2c_test.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test.bl5 -lci i2c_test.lct -d m4e_256_96 -lco i2c_test.lco -html_rpt -fti i2c_test.fti -fmt PLA -tto i2c_test.tt4 -nojed -eqn i2c_test.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test.bl5 -lci i2c_test.lct -d m4e_256_96 -lco i2c_test.lco -html_rpt -fti i2c_test.fti -fmt PLA -tto i2c_test.tt4 -eqn i2c_test.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test.rs1
file delete i2c_test.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test.bl5 -o i2c_test.tda -lci i2c_test.lct -dev m4e_256_96 -family lc4k -mod i2c_slave -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/26/21 18:56:32 ###########


########## Tcl recorder starts at 03/26/21 18:56:39 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src i2c_test.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -postfit -lci i2c_test.lco
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

########## Tcl recorder end at 03/26/21 18:56:39 ###########


########## Tcl recorder starts at 03/26/21 18:57:32 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src i2c_test.bl5 -type BLIF -presrc i2c_test.bl3 -crf i2c_test.crf -sif i2c_test.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci i2c_test.lct
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

########## Tcl recorder end at 03/26/21 18:57:32 ###########


########## Tcl recorder starts at 03/26/21 18:59:02 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open i2c_test.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test.bl5 -lci i2c_test.lct -d m4e_256_96 -lco i2c_test.lco -html_rpt -fti i2c_test.fti -fmt PLA -tto i2c_test.tt4 -nojed -eqn i2c_test.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test.bl5 -lci i2c_test.lct -d m4e_256_96 -lco i2c_test.lco -html_rpt -fti i2c_test.fti -fmt PLA -tto i2c_test.tt4 -eqn i2c_test.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test.rs1
file delete i2c_test.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test.bl5 -o i2c_test.tda -lci i2c_test.lct -dev m4e_256_96 -family lc4k -mod i2c_slave -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/26/21 18:59:02 ###########


########## Tcl recorder starts at 03/26/21 18:59:05 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src i2c_test.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -postfit -lci i2c_test.lco
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

########## Tcl recorder end at 03/26/21 18:59:05 ###########


########## Tcl recorder starts at 03/26/21 19:04:52 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i i2c_test.bl5 -o i2c_test.sif"] {
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
	puts $rspFile "-nodal -src i2c_test.bl5 -type BLIF -presrc i2c_test.bl3 -crf i2c_test.crf -sif i2c_test.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci i2c_test.lct
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

########## Tcl recorder end at 03/26/21 19:04:52 ###########


########## Tcl recorder starts at 03/26/21 19:05:31 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open i2c_test.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test.bl5 -lci i2c_test.lct -d m4e_256_96 -lco i2c_test.lco -html_rpt -fti i2c_test.fti -fmt PLA -tto i2c_test.tt4 -nojed -eqn i2c_test.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test.bl5 -lci i2c_test.lct -d m4e_256_96 -lco i2c_test.lco -html_rpt -fti i2c_test.fti -fmt PLA -tto i2c_test.tt4 -eqn i2c_test.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test.rs1
file delete i2c_test.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test.bl5 -o i2c_test.tda -lci i2c_test.lct -dev m4e_256_96 -family lc4k -mod i2c_slave -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/26/21 19:05:31 ###########


########## Tcl recorder starts at 03/26/21 19:09:14 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i i2c_test.bl5 -o i2c_test.sif"] {
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
	puts $rspFile "-nodal -src i2c_test.bl5 -type BLIF -presrc i2c_test.bl3 -crf i2c_test.crf -sif i2c_test.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci i2c_test.lct
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

########## Tcl recorder end at 03/26/21 19:09:14 ###########


########## Tcl recorder starts at 03/26/21 19:10:53 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open i2c_test.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test.bl5 -lci i2c_test.lct -d m4e_256_96 -lco i2c_test.lco -html_rpt -fti i2c_test.fti -fmt PLA -tto i2c_test.tt4 -nojed -eqn i2c_test.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test.bl5 -lci i2c_test.lct -d m4e_256_96 -lco i2c_test.lco -html_rpt -fti i2c_test.fti -fmt PLA -tto i2c_test.tt4 -eqn i2c_test.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test.rs1
file delete i2c_test.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test.bl5 -o i2c_test.tda -lci i2c_test.lct -dev m4e_256_96 -family lc4k -mod i2c_slave -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/26/21 19:10:53 ###########

