
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


########## Tcl recorder starts at 12/17/21 12:43:56 ##########

set version "2.1"
set proj_dir "C:/GIT/UltraZohm/Software/cpld_lattice/EvalBoard/i2c_test"
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
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci i2c_test.lct -touch i2c_test.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/17/21 12:43:56 ###########


########## Tcl recorder starts at 12/17/21 12:44:02 ##########

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

########## Tcl recorder end at 12/17/21 12:44:02 ###########


########## Tcl recorder starts at 12/23/21 19:19:34 ##########

# Commands to make the Process: 
# JEDEC File
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

########## Tcl recorder end at 12/23/21 19:19:34 ###########


########## Tcl recorder starts at 12/23/21 19:45:16 ##########

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

########## Tcl recorder end at 12/23/21 19:45:16 ###########


########## Tcl recorder starts at 12/23/21 19:45:42 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" io_pins.bl0 -o io_pins.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/23/21 19:45:42 ###########


########## Tcl recorder starts at 12/23/21 19:52:16 ##########

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

########## Tcl recorder end at 12/23/21 19:52:16 ###########


########## Tcl recorder starts at 12/23/21 19:54:16 ##########

# Commands to make the Process: 
# Hierarchy Browser
# - none -
# Application to view the Process: 
# Hierarchy Browser
if [runCmd "\"$cpld_bin/hierbro\" i2c_test.jid  i2c_slave"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/23/21 19:54:16 ###########


########## Tcl recorder starts at 12/23/21 19:54:24 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
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

########## Tcl recorder end at 12/23/21 19:54:24 ###########


########## Tcl recorder starts at 12/23/21 19:55:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../rd1054_i2c_slve_peripheral/rd1054/source/vhdl/i2c_slave.vhd -o i2c_slave.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/23/21 19:55:46 ###########


########## Tcl recorder starts at 12/23/21 19:55:52 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: ../rd1054_i2c_slve_peripheral/rd1054/source/vhdl/i2c_slave.vhd
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

########## Tcl recorder end at 12/23/21 19:55:52 ###########


########## Tcl recorder starts at 12/23/21 19:56:18 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" i2c_slave"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/23/21 19:56:18 ###########


########## Tcl recorder starts at 12/23/21 19:57:44 ##########

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

########## Tcl recorder end at 12/23/21 19:57:44 ###########


########## Tcl recorder starts at 12/23/21 19:57:47 ##########

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

########## Tcl recorder end at 12/23/21 19:57:47 ###########


########## Tcl recorder starts at 12/23/21 19:59:40 ##########

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

########## Tcl recorder end at 12/23/21 19:59:40 ###########


########## Tcl recorder starts at 12/23/21 20:01:16 ##########

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

########## Tcl recorder end at 12/23/21 20:01:16 ###########


########## Tcl recorder starts at 12/23/21 20:02:23 ##########

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

########## Tcl recorder end at 12/23/21 20:02:23 ###########


########## Tcl recorder starts at 12/23/21 20:03:22 ##########

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

########## Tcl recorder end at 12/23/21 20:03:22 ###########


########## Tcl recorder starts at 12/23/21 20:03:36 ##########

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

########## Tcl recorder end at 12/23/21 20:03:36 ###########


########## Tcl recorder starts at 12/23/21 20:07:23 ##########

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

########## Tcl recorder end at 12/23/21 20:07:23 ###########


########## Tcl recorder starts at 12/23/21 20:07:37 ##########

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

########## Tcl recorder end at 12/23/21 20:07:37 ###########


########## Tcl recorder starts at 12/23/21 20:09:34 ##########

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

########## Tcl recorder end at 12/23/21 20:09:34 ###########


########## Tcl recorder starts at 12/23/21 20:12:08 ##########

# Commands to make the Process: 
# Timing Analysis
# - none -
# Application to view the Process: 
# Timing Analysis
if [runCmd "\"$cpld_bin/timing\" -prj \"i2c_test\" -tti \"i2c_test.tt4\" -gui -dir \"$proj_dir\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/23/21 20:12:09 ###########


########## Tcl recorder starts at 12/23/21 20:12:21 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/23/21 20:12:21 ###########


########## Tcl recorder starts at 12/23/21 20:17:05 ##########

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

########## Tcl recorder end at 12/23/21 20:17:05 ###########


########## Tcl recorder starts at 12/23/21 20:18:41 ##########

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

########## Tcl recorder end at 12/23/21 20:18:41 ###########


########## Tcl recorder starts at 12/23/21 20:19:12 ##########

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

########## Tcl recorder end at 12/23/21 20:19:12 ###########


########## Tcl recorder starts at 12/23/21 20:25:43 ##########

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

########## Tcl recorder end at 12/23/21 20:25:43 ###########


########## Tcl recorder starts at 12/27/21 12:15:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 12:15:25 ###########


########## Tcl recorder starts at 12/27/21 12:18:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 12:18:15 ###########


########## Tcl recorder starts at 12/27/21 12:20:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 12:20:08 ###########


########## Tcl recorder starts at 12/27/21 12:20:33 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 12:20:33 ###########


########## Tcl recorder starts at 12/27/21 12:21:20 ##########

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

########## Tcl recorder end at 12/27/21 12:21:20 ###########


########## Tcl recorder starts at 12/27/21 12:23:42 ##########

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

########## Tcl recorder end at 12/27/21 12:23:42 ###########


########## Tcl recorder starts at 12/27/21 12:23:46 ##########

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

########## Tcl recorder end at 12/27/21 12:23:46 ###########


########## Tcl recorder starts at 12/27/21 12:24:30 ##########

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

########## Tcl recorder end at 12/27/21 12:24:30 ###########


########## Tcl recorder starts at 12/27/21 12:24:33 ##########

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

########## Tcl recorder end at 12/27/21 12:24:33 ###########


########## Tcl recorder starts at 12/27/21 12:30:23 ##########

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
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 12:30:23 ###########


########## Tcl recorder starts at 12/27/21 12:32:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 12:32:07 ###########


########## Tcl recorder starts at 12/27/21 12:32:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 12:32:26 ###########


########## Tcl recorder starts at 12/27/21 12:32:45 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 12:32:45 ###########


########## Tcl recorder starts at 12/27/21 12:33:27 ##########

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

########## Tcl recorder end at 12/27/21 12:33:27 ###########


########## Tcl recorder starts at 12/27/21 12:33:32 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd

########## Tcl recorder end at 12/27/21 12:33:32 ###########


########## Tcl recorder starts at 12/27/21 12:34:04 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 12:34:04 ###########


########## Tcl recorder starts at 12/27/21 12:34:28 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd

########## Tcl recorder end at 12/27/21 12:34:28 ###########


########## Tcl recorder starts at 12/27/21 12:36:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 12:36:09 ###########


########## Tcl recorder starts at 12/27/21 12:36:31 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd

########## Tcl recorder end at 12/27/21 12:36:31 ###########


########## Tcl recorder starts at 12/27/21 12:37:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 12:37:42 ###########


########## Tcl recorder starts at 12/27/21 12:37:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 12:37:49 ###########


########## Tcl recorder starts at 12/27/21 12:37:54 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd

########## Tcl recorder end at 12/27/21 12:37:54 ###########


########## Tcl recorder starts at 12/27/21 12:38:12 ##########

# Commands to make the Process: 
# Compile EDIF File
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 12:38:12 ###########


########## Tcl recorder starts at 12/27/21 12:38:19 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 12:38:19 ###########


########## Tcl recorder starts at 12/27/21 12:38:31 ##########

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

########## Tcl recorder end at 12/27/21 12:38:31 ###########


########## Tcl recorder starts at 12/27/21 12:38:42 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 12:38:42 ###########


########## Tcl recorder starts at 12/27/21 12:41:06 ##########

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

########## Tcl recorder end at 12/27/21 12:41:06 ###########


########## Tcl recorder starts at 12/27/21 12:44:00 ##########

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

########## Tcl recorder end at 12/27/21 12:44:00 ###########


########## Tcl recorder starts at 12/27/21 12:45:05 ##########

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

########## Tcl recorder end at 12/27/21 12:45:05 ###########


########## Tcl recorder starts at 12/27/21 13:43:26 ##########

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

########## Tcl recorder end at 12/27/21 13:43:26 ###########


########## Tcl recorder starts at 12/27/21 13:43:37 ##########

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

########## Tcl recorder end at 12/27/21 13:43:37 ###########


########## Tcl recorder starts at 12/27/21 13:43:38 ##########

# Commands to make the Process: 
# Constraint Editor
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

########## Tcl recorder end at 12/27/21 13:43:38 ###########


########## Tcl recorder starts at 12/27/21 13:45:09 ##########

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

########## Tcl recorder end at 12/27/21 13:45:09 ###########


########## Tcl recorder starts at 12/27/21 13:59:32 ##########

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

########## Tcl recorder end at 12/27/21 13:59:32 ###########


########## Tcl recorder starts at 12/27/21 13:59:43 ##########

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

########## Tcl recorder end at 12/27/21 13:59:43 ###########


########## Tcl recorder starts at 12/27/21 13:59:51 ##########

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

########## Tcl recorder end at 12/27/21 13:59:51 ###########


########## Tcl recorder starts at 12/27/21 14:00:09 ##########

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

########## Tcl recorder end at 12/27/21 14:00:09 ###########


########## Tcl recorder starts at 12/27/21 14:00:23 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:00:23 ###########


########## Tcl recorder starts at 12/27/21 14:01:21 ##########

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

########## Tcl recorder end at 12/27/21 14:01:21 ###########


########## Tcl recorder starts at 12/27/21 14:01:22 ##########

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

########## Tcl recorder end at 12/27/21 14:01:23 ###########


########## Tcl recorder starts at 12/27/21 14:01:30 ##########

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

########## Tcl recorder end at 12/27/21 14:01:30 ###########


########## Tcl recorder starts at 12/27/21 14:01:35 ##########

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

########## Tcl recorder end at 12/27/21 14:01:35 ###########


########## Tcl recorder starts at 12/27/21 14:01:38 ##########

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

########## Tcl recorder end at 12/27/21 14:01:38 ###########


########## Tcl recorder starts at 12/27/21 14:07:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:07:38 ###########


########## Tcl recorder starts at 12/27/21 14:07:45 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd

########## Tcl recorder end at 12/27/21 14:07:45 ###########


########## Tcl recorder starts at 12/27/21 14:08:02 ##########

# Commands to make the Process: 
# Compile EDIF File
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:08:02 ###########


########## Tcl recorder starts at 12/27/21 14:08:05 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:08:05 ###########


########## Tcl recorder starts at 12/27/21 14:08:17 ##########

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

########## Tcl recorder end at 12/27/21 14:08:17 ###########


########## Tcl recorder starts at 12/27/21 14:08:21 ##########

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

########## Tcl recorder end at 12/27/21 14:08:21 ###########


########## Tcl recorder starts at 12/27/21 14:08:42 ##########

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

########## Tcl recorder end at 12/27/21 14:08:42 ###########


########## Tcl recorder starts at 12/27/21 14:08:43 ##########

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

########## Tcl recorder end at 12/27/21 14:08:43 ###########


########## Tcl recorder starts at 12/27/21 14:08:50 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 14:08:50 ###########


########## Tcl recorder starts at 12/27/21 14:08:57 ##########

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

########## Tcl recorder end at 12/27/21 14:08:57 ###########


########## Tcl recorder starts at 12/27/21 14:09:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:09:57 ###########


########## Tcl recorder starts at 12/27/21 14:10:08 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:10:08 ###########


########## Tcl recorder starts at 12/27/21 14:10:28 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:10:28 ###########


########## Tcl recorder starts at 12/27/21 14:10:37 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 14:10:37 ###########


########## Tcl recorder starts at 12/27/21 14:10:46 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:10:46 ###########


########## Tcl recorder starts at 12/27/21 14:12:49 ##########

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

########## Tcl recorder end at 12/27/21 14:12:49 ###########


########## Tcl recorder starts at 12/27/21 14:13:22 ##########

# Commands to make the Process: 
# JEDEC File
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
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 14:13:22 ###########


########## Tcl recorder starts at 12/27/21 14:15:48 ##########

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

########## Tcl recorder end at 12/27/21 14:15:48 ###########


########## Tcl recorder starts at 12/27/21 14:17:36 ##########

# Commands to make the Process: 
# JEDEC File
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

########## Tcl recorder end at 12/27/21 14:17:36 ###########


########## Tcl recorder starts at 12/27/21 14:20:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:20:40 ###########


########## Tcl recorder starts at 12/27/21 14:20:43 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 14:20:43 ###########


########## Tcl recorder starts at 12/27/21 14:21:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:21:51 ###########


########## Tcl recorder starts at 12/27/21 14:22:52 ##########

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

########## Tcl recorder end at 12/27/21 14:22:52 ###########


########## Tcl recorder starts at 12/27/21 14:22:56 ##########

# Commands to make the Process: 
# Hierarchy Browser
# - none -
# Application to view the Process: 
# Hierarchy Browser
if [runCmd "\"$cpld_bin/hierbro\" i2c_test.jid  source"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:22:56 ###########


########## Tcl recorder starts at 12/27/21 14:23:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" ../rd1054_i2c_slve_peripheral/rd1054/source/vhdl/i2c_slave.vhd -o i2c_slave.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:23:32 ###########


########## Tcl recorder starts at 12/27/21 14:23:36 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open source.cmd w} rspFile] {
	puts stderr "Cannot create response file source.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: source
WORKING_PATH: \"$proj_dir\"
MODULE: source
VHDL_FILE_LIST: source.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf source.edi -out source.bl0 -err automake.err -log source.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:23:36 ###########


########## Tcl recorder starts at 12/27/21 14:24:00 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" source"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:24:00 ###########


########## Tcl recorder starts at 12/27/21 14:25:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:25:16 ###########


########## Tcl recorder starts at 12/27/21 14:26:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:26:26 ###########


########## Tcl recorder starts at 12/27/21 14:26:40 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:26:40 ###########


########## Tcl recorder starts at 12/27/21 14:26:57 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:26:57 ###########


########## Tcl recorder starts at 12/27/21 14:29:51 ##########

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

########## Tcl recorder end at 12/27/21 14:29:51 ###########


########## Tcl recorder starts at 12/27/21 14:31:42 ##########

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

########## Tcl recorder end at 12/27/21 14:31:42 ###########


########## Tcl recorder starts at 12/27/21 14:32:32 ##########

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

########## Tcl recorder end at 12/27/21 14:32:32 ###########


########## Tcl recorder starts at 12/27/21 14:33:48 ##########

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

########## Tcl recorder end at 12/27/21 14:33:48 ###########


########## Tcl recorder starts at 12/27/21 14:34:30 ##########

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

########## Tcl recorder end at 12/27/21 14:34:30 ###########


########## Tcl recorder starts at 12/27/21 14:37:55 ##########

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

########## Tcl recorder end at 12/27/21 14:37:55 ###########


########## Tcl recorder starts at 12/27/21 14:38:02 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:38:02 ###########


########## Tcl recorder starts at 12/27/21 14:38:56 ##########

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

########## Tcl recorder end at 12/27/21 14:38:56 ###########


########## Tcl recorder starts at 12/27/21 14:38:59 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:38:59 ###########


########## Tcl recorder starts at 12/27/21 14:39:56 ##########

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

########## Tcl recorder end at 12/27/21 14:39:56 ###########


########## Tcl recorder starts at 12/27/21 14:39:59 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:39:59 ###########


########## Tcl recorder starts at 12/27/21 14:41:09 ##########

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

########## Tcl recorder end at 12/27/21 14:41:09 ###########


########## Tcl recorder starts at 12/27/21 14:41:24 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:41:24 ###########


########## Tcl recorder starts at 12/27/21 14:42:20 ##########

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

########## Tcl recorder end at 12/27/21 14:42:20 ###########


########## Tcl recorder starts at 12/27/21 14:42:23 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:42:23 ###########


########## Tcl recorder starts at 12/27/21 14:42:58 ##########

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

########## Tcl recorder end at 12/27/21 14:42:58 ###########


########## Tcl recorder starts at 12/27/21 14:43:01 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:43:01 ###########


########## Tcl recorder starts at 12/27/21 14:43:18 ##########

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

########## Tcl recorder end at 12/27/21 14:43:18 ###########


########## Tcl recorder starts at 12/27/21 14:43:59 ##########

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

########## Tcl recorder end at 12/27/21 14:43:59 ###########


########## Tcl recorder starts at 12/27/21 14:44:07 ##########

# Commands to make the Process: 
# JEDEC File
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
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" source.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 14:44:07 ###########


########## Tcl recorder starts at 12/27/21 14:45:13 ##########

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

########## Tcl recorder end at 12/27/21 14:45:13 ###########


########## Tcl recorder starts at 12/27/21 14:48:33 ##########

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

########## Tcl recorder end at 12/27/21 14:48:33 ###########


########## Tcl recorder starts at 12/27/21 14:49:11 ##########

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

########## Tcl recorder end at 12/27/21 14:49:11 ###########


########## Tcl recorder starts at 12/27/21 14:50:02 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:50:02 ###########


########## Tcl recorder starts at 12/27/21 14:50:23 ##########

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

########## Tcl recorder end at 12/27/21 14:50:23 ###########


########## Tcl recorder starts at 12/27/21 14:50:27 ##########

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

########## Tcl recorder end at 12/27/21 14:50:27 ###########


########## Tcl recorder starts at 12/27/21 14:50:30 ##########

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

########## Tcl recorder end at 12/27/21 14:50:30 ###########


########## Tcl recorder starts at 12/27/21 14:50:33 ##########

# Commands to make the Process: 
# Constraint Editor
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
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
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

########## Tcl recorder end at 12/27/21 14:50:33 ###########


########## Tcl recorder starts at 12/27/21 14:50:49 ##########

# Commands to make the Process: 
# JEDEC File
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

########## Tcl recorder end at 12/27/21 14:50:49 ###########


########## Tcl recorder starts at 12/27/21 14:52:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:52:48 ###########


########## Tcl recorder starts at 12/27/21 14:53:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:53:02 ###########


########## Tcl recorder starts at 12/27/21 14:53:13 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:53:13 ###########


########## Tcl recorder starts at 12/27/21 14:53:35 ##########

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

########## Tcl recorder end at 12/27/21 14:53:35 ###########


########## Tcl recorder starts at 12/27/21 14:53:49 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/vhd2jhd\" concat8.vhd -o concat8.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/naf2sym\" concat8"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:53:49 ###########


########## Tcl recorder starts at 12/27/21 14:53:53 ##########

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

########## Tcl recorder end at 12/27/21 14:53:53 ###########


########## Tcl recorder starts at 12/27/21 14:53:57 ##########

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

########## Tcl recorder end at 12/27/21 14:53:57 ###########


########## Tcl recorder starts at 12/27/21 14:54:13 ##########

# Commands to make the Process: 
# VHDL Test Bench Template
if [runCmd "\"$cpld_bin/vhdl\" -tio_pins.vht -s io_pins.sch"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:54:13 ###########


########## Tcl recorder starts at 12/27/21 14:54:48 ##########

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

########## Tcl recorder end at 12/27/21 14:54:48 ###########


########## Tcl recorder starts at 12/27/21 14:54:50 ##########

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

########## Tcl recorder end at 12/27/21 14:54:50 ###########


########## Tcl recorder starts at 12/27/21 14:54:51 ##########

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

########## Tcl recorder end at 12/27/21 14:54:51 ###########


########## Tcl recorder starts at 12/27/21 14:54:53 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 14:54:53 ###########


########## Tcl recorder starts at 12/27/21 14:56:09 ##########

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

########## Tcl recorder end at 12/27/21 14:56:09 ###########


########## Tcl recorder starts at 12/27/21 14:57:03 ##########

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

########## Tcl recorder end at 12/27/21 14:57:03 ###########


########## Tcl recorder starts at 12/27/21 14:57:13 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 14:57:13 ###########


########## Tcl recorder starts at 12/27/21 14:57:46 ##########

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

########## Tcl recorder end at 12/27/21 14:57:46 ###########


########## Tcl recorder starts at 12/27/21 15:00:12 ##########

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

########## Tcl recorder end at 12/27/21 15:00:12 ###########


########## Tcl recorder starts at 12/27/21 15:00:18 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:00:18 ###########


########## Tcl recorder starts at 12/27/21 15:02:50 ##########

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

########## Tcl recorder end at 12/27/21 15:02:50 ###########


########## Tcl recorder starts at 12/27/21 15:02:55 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:02:55 ###########


########## Tcl recorder starts at 12/27/21 15:03:43 ##########

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

########## Tcl recorder end at 12/27/21 15:03:43 ###########


########## Tcl recorder starts at 12/27/21 15:03:47 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:03:47 ###########


########## Tcl recorder starts at 12/27/21 15:04:04 ##########

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

########## Tcl recorder end at 12/27/21 15:04:04 ###########


########## Tcl recorder starts at 12/27/21 15:05:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:05:31 ###########


########## Tcl recorder starts at 12/27/21 15:05:34 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:05:34 ###########


########## Tcl recorder starts at 12/27/21 15:06:05 ##########

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

########## Tcl recorder end at 12/27/21 15:06:05 ###########


########## Tcl recorder starts at 12/27/21 15:06:07 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" concat8.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 15:06:07 ###########


########## Tcl recorder starts at 12/27/21 15:06:12 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:06:12 ###########


########## Tcl recorder starts at 12/27/21 15:10:36 ##########

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

########## Tcl recorder end at 12/27/21 15:10:36 ###########


########## Tcl recorder starts at 12/27/21 15:10:42 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:10:42 ###########


########## Tcl recorder starts at 12/27/21 15:10:58 ##########

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

########## Tcl recorder end at 12/27/21 15:10:58 ###########


########## Tcl recorder starts at 12/27/21 15:11:02 ##########

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

########## Tcl recorder end at 12/27/21 15:11:02 ###########


########## Tcl recorder starts at 12/27/21 15:11:05 ##########

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

########## Tcl recorder end at 12/27/21 15:11:05 ###########


########## Tcl recorder starts at 12/27/21 15:11:07 ##########

# Commands to make the Process: 
# Fit Design
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
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
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

########## Tcl recorder end at 12/27/21 15:11:07 ###########


########## Tcl recorder starts at 12/27/21 15:11:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:11:42 ###########


########## Tcl recorder starts at 12/27/21 15:11:49 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:11:49 ###########


########## Tcl recorder starts at 12/27/21 15:12:13 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:12:13 ###########


########## Tcl recorder starts at 12/27/21 15:12:17 ##########

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

########## Tcl recorder end at 12/27/21 15:12:17 ###########


########## Tcl recorder starts at 12/27/21 15:12:20 ##########

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

########## Tcl recorder end at 12/27/21 15:12:20 ###########


########## Tcl recorder starts at 12/27/21 15:12:21 ##########

# Commands to make the Process: 
# Fit Design
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
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 15:12:21 ###########


########## Tcl recorder starts at 12/27/21 15:13:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:13:31 ###########


########## Tcl recorder starts at 12/27/21 15:13:42 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:13:42 ###########


########## Tcl recorder starts at 12/27/21 15:14:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:14:05 ###########


########## Tcl recorder starts at 12/27/21 15:14:08 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:14:08 ###########


########## Tcl recorder starts at 12/27/21 15:14:29 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:14:29 ###########


########## Tcl recorder starts at 12/27/21 15:14:35 ##########

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

########## Tcl recorder end at 12/27/21 15:14:35 ###########


########## Tcl recorder starts at 12/27/21 15:14:39 ##########

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

########## Tcl recorder end at 12/27/21 15:14:39 ###########


########## Tcl recorder starts at 12/27/21 15:14:40 ##########

# Commands to make the Process: 
# Fit Design
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
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 15:14:40 ###########


########## Tcl recorder starts at 12/27/21 15:19:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:19:49 ###########


########## Tcl recorder starts at 12/27/21 15:19:53 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:19:53 ###########


########## Tcl recorder starts at 12/27/21 15:27:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:27:33 ###########


########## Tcl recorder starts at 12/27/21 15:27:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:27:47 ###########


########## Tcl recorder starts at 12/27/21 15:27:56 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:27:56 ###########


########## Tcl recorder starts at 12/27/21 15:28:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:28:40 ###########


########## Tcl recorder starts at 12/27/21 15:28:44 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:28:44 ###########


########## Tcl recorder starts at 12/27/21 15:29:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:29:23 ###########


########## Tcl recorder starts at 12/27/21 15:29:28 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:29:28 ###########


########## Tcl recorder starts at 12/27/21 15:30:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:30:46 ###########


########## Tcl recorder starts at 12/27/21 15:30:50 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:30:50 ###########


########## Tcl recorder starts at 12/27/21 15:31:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:31:42 ###########


########## Tcl recorder starts at 12/27/21 15:31:46 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:31:46 ###########


########## Tcl recorder starts at 12/27/21 15:32:44 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:32:44 ###########


########## Tcl recorder starts at 12/27/21 15:32:55 ##########

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

########## Tcl recorder end at 12/27/21 15:32:55 ###########


########## Tcl recorder starts at 12/27/21 15:33:01 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 15:33:01 ###########


########## Tcl recorder starts at 12/27/21 15:33:15 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:33:15 ###########


########## Tcl recorder starts at 12/27/21 15:34:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:34:05 ###########


########## Tcl recorder starts at 12/27/21 15:34:07 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:34:07 ###########


########## Tcl recorder starts at 12/27/21 15:34:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:34:45 ###########


########## Tcl recorder starts at 12/27/21 15:35:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:35:00 ###########


########## Tcl recorder starts at 12/27/21 15:35:03 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:35:03 ###########


########## Tcl recorder starts at 12/27/21 15:35:21 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:35:21 ###########


########## Tcl recorder starts at 12/27/21 15:35:25 ##########

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

########## Tcl recorder end at 12/27/21 15:35:25 ###########


########## Tcl recorder starts at 12/27/21 15:35:28 ##########

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

########## Tcl recorder end at 12/27/21 15:35:28 ###########


########## Tcl recorder starts at 12/27/21 15:35:31 ##########

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

########## Tcl recorder end at 12/27/21 15:35:31 ###########


########## Tcl recorder starts at 12/27/21 15:35:33 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 15:35:33 ###########


########## Tcl recorder starts at 12/27/21 15:36:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:36:17 ###########


########## Tcl recorder starts at 12/27/21 15:36:25 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:36:25 ###########


########## Tcl recorder starts at 12/27/21 15:36:48 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:36:48 ###########


########## Tcl recorder starts at 12/27/21 15:36:52 ##########

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

########## Tcl recorder end at 12/27/21 15:36:52 ###########


########## Tcl recorder starts at 12/27/21 15:36:54 ##########

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

########## Tcl recorder end at 12/27/21 15:36:54 ###########


########## Tcl recorder starts at 12/27/21 15:36:57 ##########

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

########## Tcl recorder end at 12/27/21 15:36:57 ###########


########## Tcl recorder starts at 12/27/21 15:36:58 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 15:36:58 ###########


########## Tcl recorder starts at 12/27/21 15:38:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:38:28 ###########


########## Tcl recorder starts at 12/27/21 15:38:40 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:38:40 ###########


########## Tcl recorder starts at 12/27/21 15:38:58 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:38:58 ###########


########## Tcl recorder starts at 12/27/21 15:39:02 ##########

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

########## Tcl recorder end at 12/27/21 15:39:02 ###########


########## Tcl recorder starts at 12/27/21 15:39:06 ##########

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

########## Tcl recorder end at 12/27/21 15:39:06 ###########


########## Tcl recorder starts at 12/27/21 15:39:09 ##########

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

########## Tcl recorder end at 12/27/21 15:39:09 ###########


########## Tcl recorder starts at 12/27/21 15:39:10 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 15:39:10 ###########


########## Tcl recorder starts at 12/27/21 15:41:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:41:00 ###########


########## Tcl recorder starts at 12/27/21 15:41:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:41:29 ###########


########## Tcl recorder starts at 12/27/21 15:41:39 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:41:39 ###########


########## Tcl recorder starts at 12/27/21 15:41:56 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:41:56 ###########


########## Tcl recorder starts at 12/27/21 15:42:01 ##########

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

########## Tcl recorder end at 12/27/21 15:42:01 ###########


########## Tcl recorder starts at 12/27/21 15:42:03 ##########

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

########## Tcl recorder end at 12/27/21 15:42:03 ###########


########## Tcl recorder starts at 12/27/21 15:42:06 ##########

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

########## Tcl recorder end at 12/27/21 15:42:06 ###########


########## Tcl recorder starts at 12/27/21 15:42:07 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 15:42:07 ###########


########## Tcl recorder starts at 12/27/21 15:43:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:43:01 ###########


########## Tcl recorder starts at 12/27/21 15:43:14 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:43:14 ###########


########## Tcl recorder starts at 12/27/21 15:43:31 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:43:31 ###########


########## Tcl recorder starts at 12/27/21 15:43:35 ##########

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

########## Tcl recorder end at 12/27/21 15:43:35 ###########


########## Tcl recorder starts at 12/27/21 15:43:37 ##########

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

########## Tcl recorder end at 12/27/21 15:43:38 ###########


########## Tcl recorder starts at 12/27/21 15:43:40 ##########

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

########## Tcl recorder end at 12/27/21 15:43:40 ###########


########## Tcl recorder starts at 12/27/21 15:43:41 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 15:43:41 ###########


########## Tcl recorder starts at 12/27/21 15:43:50 ##########

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

########## Tcl recorder end at 12/27/21 15:43:50 ###########


########## Tcl recorder starts at 12/27/21 15:44:24 ##########

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

########## Tcl recorder end at 12/27/21 15:44:24 ###########


########## Tcl recorder starts at 12/27/21 15:45:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" sourceconcat.vhd -o sourceconcat.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:45:54 ###########


########## Tcl recorder starts at 12/27/21 15:47:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" sourceconcat.vhd -o sourceconcat.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:47:24 ###########


########## Tcl recorder starts at 12/27/21 15:47:32 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open sourceConcat.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceConcat.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: sourceConcat
WORKING_PATH: \"$proj_dir\"
MODULE: sourceConcat
VHDL_FILE_LIST: sourceconcat.vhd
OUTPUT_FILE_NAME: sourceConcat
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e sourceConcat -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete sourceConcat.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceConcat.edi -out sourceConcat.bl0 -err automake.err -log sourceConcat.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:47:32 ###########


########## Tcl recorder starts at 12/27/21 15:47:48 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" sourceConcat"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 15:47:48 ###########


########## Tcl recorder starts at 12/27/21 15:48:42 ##########

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

########## Tcl recorder end at 12/27/21 15:48:42 ###########


########## Tcl recorder starts at 12/27/21 15:49:10 ##########

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

########## Tcl recorder end at 12/27/21 15:49:10 ###########


########## Tcl recorder starts at 12/27/21 15:49:14 ##########

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

########## Tcl recorder end at 12/27/21 15:49:14 ###########


########## Tcl recorder starts at 12/27/21 15:49:15 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" sourceConcat.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 15:49:15 ###########


########## Tcl recorder starts at 12/27/21 16:00:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:00:17 ###########


########## Tcl recorder starts at 12/27/21 16:00:41 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:00:41 ###########


########## Tcl recorder starts at 12/27/21 16:00:58 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:00:58 ###########


########## Tcl recorder starts at 12/27/21 16:01:01 ##########

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

########## Tcl recorder end at 12/27/21 16:01:01 ###########


########## Tcl recorder starts at 12/27/21 16:01:05 ##########

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

########## Tcl recorder end at 12/27/21 16:01:05 ###########


########## Tcl recorder starts at 12/27/21 16:01:08 ##########

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

########## Tcl recorder end at 12/27/21 16:01:08 ###########


########## Tcl recorder starts at 12/27/21 16:01:09 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 16:01:09 ###########


########## Tcl recorder starts at 12/27/21 16:02:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" sourceconcat.vhd -o sourceconcat.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:02:23 ###########


########## Tcl recorder starts at 12/27/21 16:02:29 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open sourceConcat.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceConcat.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: sourceConcat
WORKING_PATH: \"$proj_dir\"
MODULE: sourceConcat
VHDL_FILE_LIST: sourceconcat.vhd
OUTPUT_FILE_NAME: sourceConcat
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e sourceConcat -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete sourceConcat.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceConcat.edi -out sourceConcat.bl0 -err automake.err -log sourceConcat.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:02:29 ###########


########## Tcl recorder starts at 12/27/21 16:02:46 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" sourceConcat"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:02:46 ###########


########## Tcl recorder starts at 12/27/21 16:02:50 ##########

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

########## Tcl recorder end at 12/27/21 16:02:50 ###########


########## Tcl recorder starts at 12/27/21 16:02:53 ##########

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

########## Tcl recorder end at 12/27/21 16:02:53 ###########


########## Tcl recorder starts at 12/27/21 16:02:56 ##########

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

########## Tcl recorder end at 12/27/21 16:02:56 ###########


########## Tcl recorder starts at 12/27/21 16:02:57 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" sourceConcat.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 16:02:57 ###########


########## Tcl recorder starts at 12/27/21 16:03:18 ##########

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

########## Tcl recorder end at 12/27/21 16:03:18 ###########


########## Tcl recorder starts at 12/27/21 16:04:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" sourceconcat.vhd -o sourceconcat.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:04:08 ###########


########## Tcl recorder starts at 12/27/21 16:04:27 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open sourceConcat.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceConcat.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: sourceConcat
WORKING_PATH: \"$proj_dir\"
MODULE: sourceConcat
VHDL_FILE_LIST: sourceconcat.vhd
OUTPUT_FILE_NAME: sourceConcat
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e sourceConcat -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete sourceConcat.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceConcat.edi -out sourceConcat.bl0 -err automake.err -log sourceConcat.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:04:27 ###########


########## Tcl recorder starts at 12/27/21 16:04:46 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" sourceConcat"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:04:46 ###########


########## Tcl recorder starts at 12/27/21 16:04:49 ##########

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

########## Tcl recorder end at 12/27/21 16:04:49 ###########


########## Tcl recorder starts at 12/27/21 16:09:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:09:23 ###########


########## Tcl recorder starts at 12/27/21 16:09:37 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:09:37 ###########


########## Tcl recorder starts at 12/27/21 16:09:58 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:09:58 ###########


########## Tcl recorder starts at 12/27/21 16:10:04 ##########

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

########## Tcl recorder end at 12/27/21 16:10:04 ###########


########## Tcl recorder starts at 12/27/21 16:10:06 ##########

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

########## Tcl recorder end at 12/27/21 16:10:06 ###########


########## Tcl recorder starts at 12/27/21 16:10:10 ##########

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

########## Tcl recorder end at 12/27/21 16:10:10 ###########


########## Tcl recorder starts at 12/27/21 16:10:11 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" sourceConcat.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 16:10:11 ###########


########## Tcl recorder starts at 12/27/21 16:11:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:11:02 ###########


########## Tcl recorder starts at 12/27/21 16:11:05 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:11:05 ###########


########## Tcl recorder starts at 12/27/21 16:11:23 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:11:23 ###########


########## Tcl recorder starts at 12/27/21 16:11:27 ##########

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

########## Tcl recorder end at 12/27/21 16:11:27 ###########


########## Tcl recorder starts at 12/27/21 16:11:29 ##########

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

########## Tcl recorder end at 12/27/21 16:11:29 ###########


########## Tcl recorder starts at 12/27/21 16:11:33 ##########

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

########## Tcl recorder end at 12/27/21 16:11:33 ###########


########## Tcl recorder starts at 12/27/21 16:11:34 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 16:11:34 ###########


########## Tcl recorder starts at 12/27/21 16:14:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" sourceconcat.vhd -o sourceconcat.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:14:55 ###########


########## Tcl recorder starts at 12/27/21 16:15:07 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open sourceConcat.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceConcat.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: sourceConcat
WORKING_PATH: \"$proj_dir\"
MODULE: sourceConcat
VHDL_FILE_LIST: sourceconcat.vhd
OUTPUT_FILE_NAME: sourceConcat
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e sourceConcat -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete sourceConcat.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceConcat.edi -out sourceConcat.bl0 -err automake.err -log sourceConcat.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:15:07 ###########


########## Tcl recorder starts at 12/27/21 16:15:24 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" sourceConcat"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:15:24 ###########


########## Tcl recorder starts at 12/27/21 16:16:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:16:17 ###########


########## Tcl recorder starts at 12/27/21 16:16:33 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:16:33 ###########


########## Tcl recorder starts at 12/27/21 16:16:49 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:16:49 ###########


########## Tcl recorder starts at 12/27/21 16:16:52 ##########

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

########## Tcl recorder end at 12/27/21 16:16:52 ###########


########## Tcl recorder starts at 12/27/21 16:16:55 ##########

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

########## Tcl recorder end at 12/27/21 16:16:55 ###########


########## Tcl recorder starts at 12/27/21 16:16:58 ##########

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

########## Tcl recorder end at 12/27/21 16:16:58 ###########


########## Tcl recorder starts at 12/27/21 16:16:59 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" sourceConcat.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 16:16:59 ###########


########## Tcl recorder starts at 12/27/21 16:18:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:18:24 ###########


########## Tcl recorder starts at 12/27/21 16:18:29 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:18:29 ###########


########## Tcl recorder starts at 12/27/21 16:20:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:20:04 ###########


########## Tcl recorder starts at 12/27/21 16:20:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" sourceconcat.vhd -o sourceconcat.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:20:15 ###########


########## Tcl recorder starts at 12/27/21 16:20:20 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open sourceConcat.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceConcat.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: sourceConcat
WORKING_PATH: \"$proj_dir\"
MODULE: sourceConcat
VHDL_FILE_LIST: sourceconcat.vhd
OUTPUT_FILE_NAME: sourceConcat
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e sourceConcat -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete sourceConcat.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceConcat.edi -out sourceConcat.bl0 -err automake.err -log sourceConcat.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:20:20 ###########


########## Tcl recorder starts at 12/27/21 16:20:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" sourceconcat.vhd -o sourceconcat.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:20:45 ###########


########## Tcl recorder starts at 12/27/21 16:27:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:27:16 ###########


########## Tcl recorder starts at 12/27/21 16:27:28 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:27:28 ###########


########## Tcl recorder starts at 12/27/21 16:27:47 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:27:47 ###########


########## Tcl recorder starts at 12/27/21 16:28:04 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open sourceConcat.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceConcat.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: sourceConcat
WORKING_PATH: \"$proj_dir\"
MODULE: sourceConcat
VHDL_FILE_LIST: sourceconcat.vhd
OUTPUT_FILE_NAME: sourceConcat
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e sourceConcat -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete sourceConcat.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceConcat.edi -out sourceConcat.bl0 -err automake.err -log sourceConcat.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:28:04 ###########


########## Tcl recorder starts at 12/27/21 16:28:22 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" sourceConcat"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:28:22 ###########


########## Tcl recorder starts at 12/27/21 16:28:27 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" source"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:28:27 ###########


########## Tcl recorder starts at 12/27/21 16:28:39 ##########

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

########## Tcl recorder end at 12/27/21 16:28:39 ###########


########## Tcl recorder starts at 12/27/21 16:28:41 ##########

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

########## Tcl recorder end at 12/27/21 16:28:41 ###########


########## Tcl recorder starts at 12/27/21 16:28:44 ##########

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

########## Tcl recorder end at 12/27/21 16:28:44 ###########


########## Tcl recorder starts at 12/27/21 16:28:45 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" sourceConcat.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 16:28:45 ###########


########## Tcl recorder starts at 12/27/21 16:34:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:34:12 ###########


########## Tcl recorder starts at 12/27/21 16:34:16 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:34:16 ###########


########## Tcl recorder starts at 12/27/21 16:34:45 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:34:45 ###########


########## Tcl recorder starts at 12/27/21 16:34:49 ##########

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

########## Tcl recorder end at 12/27/21 16:34:49 ###########


########## Tcl recorder starts at 12/27/21 16:34:51 ##########

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

########## Tcl recorder end at 12/27/21 16:34:51 ###########


########## Tcl recorder starts at 12/27/21 16:34:54 ##########

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

########## Tcl recorder end at 12/27/21 16:34:54 ###########


########## Tcl recorder starts at 12/27/21 16:34:56 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 16:34:56 ###########


########## Tcl recorder starts at 12/27/21 16:36:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" sourceconcat.vhd -o sourceconcat.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:36:37 ###########


########## Tcl recorder starts at 12/27/21 16:36:40 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open sourceConcat.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceConcat.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: sourceConcat
WORKING_PATH: \"$proj_dir\"
MODULE: sourceConcat
VHDL_FILE_LIST: sourceconcat.vhd
OUTPUT_FILE_NAME: sourceConcat
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e sourceConcat -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete sourceConcat.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceConcat.edi -out sourceConcat.bl0 -err automake.err -log sourceConcat.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:36:40 ###########


########## Tcl recorder starts at 12/27/21 16:36:56 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" sourceConcat"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:36:56 ###########


########## Tcl recorder starts at 12/27/21 16:37:00 ##########

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

########## Tcl recorder end at 12/27/21 16:37:00 ###########


########## Tcl recorder starts at 12/27/21 16:37:04 ##########

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

########## Tcl recorder end at 12/27/21 16:37:04 ###########


########## Tcl recorder starts at 12/27/21 16:37:07 ##########

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

########## Tcl recorder end at 12/27/21 16:37:07 ###########


########## Tcl recorder starts at 12/27/21 16:37:08 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" sourceConcat.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 16:37:08 ###########


########## Tcl recorder starts at 12/27/21 16:38:22 ##########

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

########## Tcl recorder end at 12/27/21 16:38:22 ###########


########## Tcl recorder starts at 12/27/21 16:40:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:40:20 ###########


########## Tcl recorder starts at 12/27/21 16:40:32 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:40:32 ###########


########## Tcl recorder starts at 12/27/21 16:40:49 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:40:49 ###########


########## Tcl recorder starts at 12/27/21 16:40:56 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:40:56 ###########


########## Tcl recorder starts at 12/27/21 16:41:12 ##########

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

########## Tcl recorder end at 12/27/21 16:41:12 ###########


########## Tcl recorder starts at 12/27/21 16:41:21 ##########

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

########## Tcl recorder end at 12/27/21 16:41:21 ###########


########## Tcl recorder starts at 12/27/21 16:41:24 ##########

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

########## Tcl recorder end at 12/27/21 16:41:24 ###########


########## Tcl recorder starts at 12/27/21 16:41:26 ##########

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

########## Tcl recorder end at 12/27/21 16:41:26 ###########


########## Tcl recorder starts at 12/27/21 16:41:27 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" concat8.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 16:41:27 ###########


########## Tcl recorder starts at 12/27/21 16:42:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:42:11 ###########


########## Tcl recorder starts at 12/27/21 16:42:14 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:42:14 ###########


########## Tcl recorder starts at 12/27/21 16:42:32 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:42:32 ###########


########## Tcl recorder starts at 12/27/21 16:42:35 ##########

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

########## Tcl recorder end at 12/27/21 16:42:35 ###########


########## Tcl recorder starts at 12/27/21 16:42:39 ##########

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

########## Tcl recorder end at 12/27/21 16:42:39 ###########


########## Tcl recorder starts at 12/27/21 16:42:41 ##########

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

########## Tcl recorder end at 12/27/21 16:42:41 ###########


########## Tcl recorder starts at 12/27/21 16:42:42 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 16:42:42 ###########


########## Tcl recorder starts at 12/27/21 16:45:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:45:04 ###########


########## Tcl recorder starts at 12/27/21 16:45:10 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:45:10 ###########


########## Tcl recorder starts at 12/27/21 16:45:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:45:36 ###########


########## Tcl recorder starts at 12/27/21 16:45:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:45:58 ###########


########## Tcl recorder starts at 12/27/21 16:46:17 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:46:17 ###########


########## Tcl recorder starts at 12/27/21 16:46:33 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:46:34 ###########


########## Tcl recorder starts at 12/27/21 16:46:37 ##########

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

########## Tcl recorder end at 12/27/21 16:46:37 ###########


########## Tcl recorder starts at 12/27/21 16:46:41 ##########

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

########## Tcl recorder end at 12/27/21 16:46:41 ###########


########## Tcl recorder starts at 12/27/21 16:46:44 ##########

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

########## Tcl recorder end at 12/27/21 16:46:44 ###########


########## Tcl recorder starts at 12/27/21 16:46:45 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 16:46:45 ###########


########## Tcl recorder starts at 12/27/21 16:56:58 ##########

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

########## Tcl recorder end at 12/27/21 16:56:58 ###########


########## Tcl recorder starts at 12/27/21 16:58:59 ##########

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

########## Tcl recorder end at 12/27/21 16:58:59 ###########


########## Tcl recorder starts at 12/27/21 16:59:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:59:38 ###########


########## Tcl recorder starts at 12/27/21 16:59:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 16:59:54 ###########


########## Tcl recorder starts at 12/27/21 17:00:13 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:00:13 ###########


########## Tcl recorder starts at 12/27/21 17:01:24 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: ../rd1054_i2c_slve_peripheral/rd1054/source/vhdl/i2c_slave.vhd
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

########## Tcl recorder end at 12/27/21 17:01:24 ###########


########## Tcl recorder starts at 12/27/21 17:01:43 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" i2c_slave"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:01:43 ###########


########## Tcl recorder starts at 12/27/21 17:02:17 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:02:17 ###########


########## Tcl recorder starts at 12/27/21 17:03:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:03:21 ###########


########## Tcl recorder starts at 12/27/21 17:03:24 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:03:24 ###########


########## Tcl recorder starts at 12/27/21 17:04:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:04:17 ###########


########## Tcl recorder starts at 12/27/21 17:04:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:04:37 ###########


########## Tcl recorder starts at 12/27/21 17:04:57 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:04:57 ###########


########## Tcl recorder starts at 12/27/21 17:05:15 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd

########## Tcl recorder end at 12/27/21 17:05:15 ###########


########## Tcl recorder starts at 12/27/21 17:06:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:06:00 ###########


########## Tcl recorder starts at 12/27/21 17:06:04 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:06:04 ###########


########## Tcl recorder starts at 12/27/21 17:06:22 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:06:22 ###########


########## Tcl recorder starts at 12/27/21 17:06:26 ##########

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

########## Tcl recorder end at 12/27/21 17:06:26 ###########


########## Tcl recorder starts at 12/27/21 17:06:29 ##########

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

########## Tcl recorder end at 12/27/21 17:06:29 ###########


########## Tcl recorder starts at 12/27/21 17:06:34 ##########

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

########## Tcl recorder end at 12/27/21 17:06:34 ###########


########## Tcl recorder starts at 12/27/21 17:06:35 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 17:06:35 ###########


########## Tcl recorder starts at 12/27/21 17:07:55 ##########

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

########## Tcl recorder end at 12/27/21 17:07:55 ###########


########## Tcl recorder starts at 12/27/21 17:14:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../rd1054_i2c_slve_peripheral/rd1054/source/vhdl/i2c_slave.vhd -o i2c_slave.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:14:57 ###########


########## Tcl recorder starts at 12/27/21 17:15:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" i2c.vhd -o i2c.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:15:12 ###########


########## Tcl recorder starts at 12/27/21 17:15:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" i2c.vhd -o i2c.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:15:19 ###########


########## Tcl recorder starts at 12/27/21 17:16:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" i2c.vhd -o i2c.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:16:04 ###########


########## Tcl recorder starts at 12/27/21 17:16:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" i2c.vhd -o i2c.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:16:14 ###########


########## Tcl recorder starts at 12/27/21 17:17:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../rd1054_i2c_slve_peripheral/rd1054/source/vhdl/i2c_slave.vhd -o i2c_slave.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:17:29 ###########


########## Tcl recorder starts at 12/27/21 17:18:18 ##########

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
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" i2c_slave.vhd -o i2c_slave.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" sourceconcat.vhd -o sourceconcat.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:18:18 ###########


########## Tcl recorder starts at 12/27/21 17:18:26 ##########

# Commands to make the Process: 
# Compile EDIF File
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

########## Tcl recorder end at 12/27/21 17:18:26 ###########


########## Tcl recorder starts at 12/27/21 17:18:45 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" i2c_slave"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:18:45 ###########


########## Tcl recorder starts at 12/27/21 17:22:37 ##########

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

########## Tcl recorder end at 12/27/21 17:22:37 ###########


########## Tcl recorder starts at 12/27/21 17:23:17 ##########

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
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" i2c_slave.vhd -o i2c_slave.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" sourceconcat.vhd -o sourceconcat.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:23:17 ###########


########## Tcl recorder starts at 12/27/21 17:24:27 ##########

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
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" I2C_slave.vhd -o I2C_slave.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" sourceconcat.vhd -o sourceconcat.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:24:27 ###########


########## Tcl recorder starts at 12/27/21 17:25:00 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: I2C_slave.vhd
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

########## Tcl recorder end at 12/27/21 17:25:00 ###########


########## Tcl recorder starts at 12/27/21 17:25:17 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" i2c_slave"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/27/21 17:25:17 ###########


########## Tcl recorder starts at 12/27/21 17:27:52 ##########

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

########## Tcl recorder end at 12/27/21 17:27:52 ###########


########## Tcl recorder starts at 12/27/21 17:28:02 ##########

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

########## Tcl recorder end at 12/27/21 17:28:02 ###########


########## Tcl recorder starts at 12/27/21 17:28:06 ##########

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

########## Tcl recorder end at 12/27/21 17:28:06 ###########


########## Tcl recorder starts at 12/27/21 17:28:09 ##########

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
if [catch {open sourceConcat.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceConcat.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: sourceConcat
WORKING_PATH: \"$proj_dir\"
MODULE: sourceConcat
VHDL_FILE_LIST: sourceconcat.vhd
OUTPUT_FILE_NAME: sourceConcat
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e sourceConcat -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete sourceConcat.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceConcat.edi -out sourceConcat.bl0 -err automake.err -log sourceConcat.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" sourceConcat.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open source.cmd w} rspFile] {
	puts stderr "Cannot create response file source.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: source
WORKING_PATH: \"$proj_dir\"
MODULE: source
VHDL_FILE_LIST: source.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf source.edi -out source.bl0 -err automake.err -log source.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" source.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/27/21 17:28:09 ###########


########## Tcl recorder starts at 12/27/21 17:30:37 ##########

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

########## Tcl recorder end at 12/27/21 17:30:37 ###########


########## Tcl recorder starts at 12/27/21 17:35:01 ##########

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

########## Tcl recorder end at 12/27/21 17:35:01 ###########


########## Tcl recorder starts at 12/28/21 09:54:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" uz_i2c_slave_D1.vhd -o uz_i2c_slave_D1.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 09:54:34 ###########


########## Tcl recorder starts at 12/28/21 09:54:39 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: uz_i2c_slave_D1.vhd
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

########## Tcl recorder end at 12/28/21 09:54:39 ###########


########## Tcl recorder starts at 12/28/21 09:54:57 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" i2c_slave"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 09:54:57 ###########


########## Tcl recorder starts at 12/28/21 09:58:06 ##########

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

########## Tcl recorder end at 12/28/21 09:58:06 ###########


########## Tcl recorder starts at 12/28/21 09:58:20 ##########

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

########## Tcl recorder end at 12/28/21 09:58:20 ###########


########## Tcl recorder starts at 12/28/21 09:58:25 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 09:58:25 ###########


########## Tcl recorder starts at 12/28/21 09:58:32 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" source"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 09:58:32 ###########


########## Tcl recorder starts at 12/28/21 09:58:36 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" sourceConcat"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 09:58:36 ###########


########## Tcl recorder starts at 12/28/21 09:58:48 ##########

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

########## Tcl recorder end at 12/28/21 09:58:48 ###########


########## Tcl recorder starts at 12/28/21 09:58:57 ##########

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

########## Tcl recorder end at 12/28/21 09:58:57 ###########


########## Tcl recorder starts at 12/28/21 09:58:58 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" i2c_slave.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 09:58:58 ###########


########## Tcl recorder starts at 12/28/21 10:00:49 ##########

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

########## Tcl recorder end at 12/28/21 10:00:49 ###########


########## Tcl recorder starts at 12/28/21 10:03:39 ##########

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

########## Tcl recorder end at 12/28/21 10:03:39 ###########


########## Tcl recorder starts at 12/28/21 10:11:30 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci i2c_test.lct -touch i2c_test.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 10:11:30 ###########


########## Tcl recorder starts at 12/28/21 10:11:49 ##########

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

########## Tcl recorder end at 12/28/21 10:11:49 ###########


########## Tcl recorder starts at 12/28/21 10:24:55 ##########

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

########## Tcl recorder end at 12/28/21 10:24:55 ###########


########## Tcl recorder starts at 12/28/21 10:34:55 ##########

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

########## Tcl recorder end at 12/28/21 10:34:55 ###########


########## Tcl recorder starts at 12/28/21 10:53:30 ##########

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

########## Tcl recorder end at 12/28/21 10:53:30 ###########


########## Tcl recorder starts at 12/28/21 10:54:01 ##########

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

########## Tcl recorder end at 12/28/21 10:54:01 ###########


########## Tcl recorder starts at 12/28/21 10:57:41 ##########

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

########## Tcl recorder end at 12/28/21 10:57:41 ###########


########## Tcl recorder starts at 12/28/21 11:00:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" uz_i2c_slave_D1.vhd -o uz_i2c_slave_D1.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 11:00:20 ###########


########## Tcl recorder starts at 12/28/21 11:00:23 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: uz_i2c_slave_D1.vhd
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

########## Tcl recorder end at 12/28/21 11:00:23 ###########


########## Tcl recorder starts at 12/28/21 11:01:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" uz_i2c_slave_D1.vhd -o uz_i2c_slave_D1.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 11:01:08 ###########


########## Tcl recorder starts at 12/28/21 11:01:31 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: uz_i2c_slave_D1.vhd
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

########## Tcl recorder end at 12/28/21 11:01:31 ###########


########## Tcl recorder starts at 12/28/21 11:01:49 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" i2c_slave"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 11:01:49 ###########


########## Tcl recorder starts at 12/28/21 11:02:27 ##########

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

########## Tcl recorder end at 12/28/21 11:02:27 ###########


########## Tcl recorder starts at 12/28/21 11:02:33 ##########

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

########## Tcl recorder end at 12/28/21 11:02:33 ###########


########## Tcl recorder starts at 12/28/21 11:02:37 ##########

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

########## Tcl recorder end at 12/28/21 11:02:37 ###########


########## Tcl recorder starts at 12/28/21 11:02:39 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" i2c_slave.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 11:02:39 ###########


########## Tcl recorder starts at 12/28/21 11:06:12 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci i2c_test.lct -touch i2c_test.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 11:06:12 ###########


########## Tcl recorder starts at 12/28/21 11:13:48 ##########

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

########## Tcl recorder end at 12/28/21 11:13:48 ###########


########## Tcl recorder starts at 12/28/21 11:15:16 ##########

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

########## Tcl recorder end at 12/28/21 11:15:16 ###########


########## Tcl recorder starts at 12/28/21 12:46:52 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" i2c_slave.bl0 -o i2c_slave.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 12:46:52 ###########


########## Tcl recorder starts at 12/28/21 12:50:38 ##########

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

########## Tcl recorder end at 12/28/21 12:50:38 ###########


########## Tcl recorder starts at 12/28/21 12:50:54 ##########

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

########## Tcl recorder end at 12/28/21 12:50:54 ###########


########## Tcl recorder starts at 12/28/21 12:51:02 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" io_pins"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 12:51:02 ###########


########## Tcl recorder starts at 12/28/21 12:51:13 ##########

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

########## Tcl recorder end at 12/28/21 12:51:13 ###########


########## Tcl recorder starts at 12/28/21 12:51:15 ##########

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

########## Tcl recorder end at 12/28/21 12:51:15 ###########


########## Tcl recorder starts at 12/28/21 14:44:59 ##########

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

########## Tcl recorder end at 12/28/21 14:44:59 ###########


########## Tcl recorder starts at 12/28/21 14:47:35 ##########

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

########## Tcl recorder end at 12/28/21 14:47:36 ###########


########## Tcl recorder starts at 12/28/21 14:49:50 ##########

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

########## Tcl recorder end at 12/28/21 14:49:50 ###########


########## Tcl recorder starts at 12/28/21 14:51:16 ##########

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

########## Tcl recorder end at 12/28/21 14:51:16 ###########


########## Tcl recorder starts at 12/28/21 14:51:56 ##########

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

########## Tcl recorder end at 12/28/21 14:51:56 ###########


########## Tcl recorder starts at 12/28/21 14:55:26 ##########

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

########## Tcl recorder end at 12/28/21 14:55:26 ###########


########## Tcl recorder starts at 12/28/21 14:59:28 ##########

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

########## Tcl recorder end at 12/28/21 14:59:28 ###########


########## Tcl recorder starts at 12/28/21 15:00:24 ##########

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

########## Tcl recorder end at 12/28/21 15:00:24 ###########


########## Tcl recorder starts at 12/28/21 15:00:57 ##########

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

########## Tcl recorder end at 12/28/21 15:00:57 ###########


########## Tcl recorder starts at 12/28/21 15:01:02 ##########

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

########## Tcl recorder end at 12/28/21 15:01:02 ###########


########## Tcl recorder starts at 12/28/21 15:01:08 ##########

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

########## Tcl recorder end at 12/28/21 15:01:08 ###########


########## Tcl recorder starts at 12/28/21 15:04:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:04:46 ###########


########## Tcl recorder starts at 12/28/21 15:04:51 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:04:51 ###########


########## Tcl recorder starts at 12/28/21 15:05:08 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:05:08 ###########


########## Tcl recorder starts at 12/28/21 15:05:12 ##########

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

########## Tcl recorder end at 12/28/21 15:05:12 ###########


########## Tcl recorder starts at 12/28/21 15:05:16 ##########

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

########## Tcl recorder end at 12/28/21 15:05:16 ###########


########## Tcl recorder starts at 12/28/21 15:05:21 ##########

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

########## Tcl recorder end at 12/28/21 15:05:21 ###########


########## Tcl recorder starts at 12/28/21 15:05:24 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 15:05:24 ###########


########## Tcl recorder starts at 12/28/21 15:06:09 ##########

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

########## Tcl recorder end at 12/28/21 15:06:09 ###########


########## Tcl recorder starts at 12/28/21 15:06:51 ##########

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

########## Tcl recorder end at 12/28/21 15:06:51 ###########


########## Tcl recorder starts at 12/28/21 15:09:50 ##########

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

########## Tcl recorder end at 12/28/21 15:09:50 ###########


########## Tcl recorder starts at 12/28/21 15:10:03 ##########

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
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" uz_i2c_slave_D1.vhd -o uz_i2c_slave_D1.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:10:03 ###########


########## Tcl recorder starts at 12/28/21 15:10:06 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open source.cmd w} rspFile] {
	puts stderr "Cannot create response file source.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: source
WORKING_PATH: \"$proj_dir\"
MODULE: source
VHDL_FILE_LIST: source.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf source.edi -out source.bl0 -err automake.err -log source.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:10:06 ###########


########## Tcl recorder starts at 12/28/21 15:10:24 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" source"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:10:25 ###########


########## Tcl recorder starts at 12/28/21 15:10:33 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:10:33 ###########


########## Tcl recorder starts at 12/28/21 15:10:49 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:10:49 ###########


########## Tcl recorder starts at 12/28/21 15:10:54 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: uz_i2c_slave_D1.vhd
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

########## Tcl recorder end at 12/28/21 15:10:54 ###########


########## Tcl recorder starts at 12/28/21 15:11:12 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" i2c_slave"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:11:12 ###########


########## Tcl recorder starts at 12/28/21 15:11:19 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:11:19 ###########


########## Tcl recorder starts at 12/28/21 15:11:36 ##########

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

########## Tcl recorder end at 12/28/21 15:11:36 ###########


########## Tcl recorder starts at 12/28/21 15:11:40 ##########

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

########## Tcl recorder end at 12/28/21 15:11:40 ###########


########## Tcl recorder starts at 12/28/21 15:11:43 ##########

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

########## Tcl recorder end at 12/28/21 15:11:43 ###########


########## Tcl recorder starts at 12/28/21 15:11:50 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" i2c_slave.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" source.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 15:11:50 ###########


########## Tcl recorder starts at 12/28/21 15:12:31 ##########

# Commands to make the Process: 
# Timing Report
if [runCmd "\"$cpld_bin/timer\" -inp \"i2c_test.tt4\" -lci \"i2c_test.lct\" -trp \"i2c_test.trp\" -exf \"io_pins.exf\" -lco \"i2c_test.lco\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:12:31 ###########


########## Tcl recorder starts at 12/28/21 15:21:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:21:41 ###########


########## Tcl recorder starts at 12/28/21 15:21:48 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open source.cmd w} rspFile] {
	puts stderr "Cannot create response file source.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: source
WORKING_PATH: \"$proj_dir\"
MODULE: source
VHDL_FILE_LIST: source.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf source.edi -out source.bl0 -err automake.err -log source.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:21:48 ###########


########## Tcl recorder starts at 12/28/21 15:22:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:22:43 ###########


########## Tcl recorder starts at 12/28/21 15:22:46 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open source.cmd w} rspFile] {
	puts stderr "Cannot create response file source.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: source
WORKING_PATH: \"$proj_dir\"
MODULE: source
VHDL_FILE_LIST: source.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf source.edi -out source.bl0 -err automake.err -log source.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:22:46 ###########


########## Tcl recorder starts at 12/28/21 15:24:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:24:27 ###########


########## Tcl recorder starts at 12/28/21 15:25:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:25:13 ###########


########## Tcl recorder starts at 12/28/21 15:25:17 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open source.cmd w} rspFile] {
	puts stderr "Cannot create response file source.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: source
WORKING_PATH: \"$proj_dir\"
MODULE: source
VHDL_FILE_LIST: source.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf source.edi -out source.bl0 -err automake.err -log source.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:25:17 ###########


########## Tcl recorder starts at 12/28/21 15:25:42 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" source"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:25:42 ###########


########## Tcl recorder starts at 12/28/21 15:26:11 ##########

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

########## Tcl recorder end at 12/28/21 15:26:11 ###########


########## Tcl recorder starts at 12/28/21 15:26:16 ##########

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

########## Tcl recorder end at 12/28/21 15:26:16 ###########


########## Tcl recorder starts at 12/28/21 15:27:20 ##########

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

########## Tcl recorder end at 12/28/21 15:27:20 ###########


########## Tcl recorder starts at 12/28/21 15:27:21 ##########

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

########## Tcl recorder end at 12/28/21 15:27:21 ###########


########## Tcl recorder starts at 12/28/21 15:27:28 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" source.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 15:27:28 ###########


########## Tcl recorder starts at 12/28/21 15:29:42 ##########

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

########## Tcl recorder end at 12/28/21 15:29:42 ###########


########## Tcl recorder starts at 12/28/21 15:29:49 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:29:49 ###########


########## Tcl recorder starts at 12/28/21 15:29:55 ##########

# Commands to make the Process: 
# Fit Design
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
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: uz_i2c_slave_D1.vhd
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
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" slicer.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open source.cmd w} rspFile] {
	puts stderr "Cannot create response file source.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: source
WORKING_PATH: \"$proj_dir\"
MODULE: source
VHDL_FILE_LIST: source.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf source.edi -out source.bl0 -err automake.err -log source.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" source.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 15:29:56 ###########


########## Tcl recorder starts at 12/28/21 15:31:01 ##########

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

########## Tcl recorder end at 12/28/21 15:31:01 ###########


########## Tcl recorder starts at 12/28/21 15:31:07 ##########

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

########## Tcl recorder end at 12/28/21 15:31:07 ###########


########## Tcl recorder starts at 12/28/21 15:31:10 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" i2c_slave.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 15:31:10 ###########


########## Tcl recorder starts at 12/28/21 15:32:27 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: uz_i2c_slave_D1.vhd
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

########## Tcl recorder end at 12/28/21 15:32:27 ###########


########## Tcl recorder starts at 12/28/21 15:32:50 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" i2c_slave.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 15:32:50 ###########


########## Tcl recorder starts at 12/28/21 15:33:01 ##########

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

########## Tcl recorder end at 12/28/21 15:33:01 ###########


########## Tcl recorder starts at 12/28/21 15:33:27 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:33:27 ###########


########## Tcl recorder starts at 12/28/21 15:37:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:37:38 ###########


########## Tcl recorder starts at 12/28/21 15:38:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:38:05 ###########


########## Tcl recorder starts at 12/28/21 15:38:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:38:31 ###########


########## Tcl recorder starts at 12/28/21 15:38:53 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: source.vhd slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd

########## Tcl recorder end at 12/28/21 15:38:53 ###########


########## Tcl recorder starts at 12/28/21 15:41:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:41:17 ###########


########## Tcl recorder starts at 12/28/21 15:41:27 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:41:27 ###########


########## Tcl recorder starts at 12/28/21 15:41:56 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd

########## Tcl recorder end at 12/28/21 15:41:56 ###########


########## Tcl recorder starts at 12/28/21 15:42:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:42:24 ###########


########## Tcl recorder starts at 12/28/21 15:42:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:42:32 ###########


########## Tcl recorder starts at 12/28/21 15:42:39 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd

########## Tcl recorder end at 12/28/21 15:42:39 ###########


########## Tcl recorder starts at 12/28/21 15:44:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:44:15 ###########


########## Tcl recorder starts at 12/28/21 15:44:26 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open source.cmd w} rspFile] {
	puts stderr "Cannot create response file source.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: source
WORKING_PATH: \"$proj_dir\"
MODULE: source
VHDL_FILE_LIST: source.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf source.edi -out source.bl0 -err automake.err -log source.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:44:26 ###########


########## Tcl recorder starts at 12/28/21 15:44:44 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" source"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:44:44 ###########


########## Tcl recorder starts at 12/28/21 15:44:56 ##########

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

########## Tcl recorder end at 12/28/21 15:44:56 ###########


########## Tcl recorder starts at 12/28/21 15:46:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" osctimer.vhd -o osctimer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:46:06 ###########


########## Tcl recorder starts at 12/28/21 15:46:43 ##########

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
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" uz_i2c_slave_D1.vhd -o uz_i2c_slave_D1.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" osctimer.vhd -o osctimer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:46:43 ###########


########## Tcl recorder starts at 12/28/21 15:48:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" osctimer.vhd -o osctimer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:48:02 ###########


########## Tcl recorder starts at 12/28/21 15:48:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:48:38 ###########


########## Tcl recorder starts at 12/28/21 15:48:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:48:53 ###########


########## Tcl recorder starts at 12/28/21 15:49:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" osctimer.vhd -o osctimer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:49:07 ###########


########## Tcl recorder starts at 12/28/21 15:51:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:51:36 ###########


########## Tcl recorder starts at 12/28/21 15:51:40 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open source.cmd w} rspFile] {
	puts stderr "Cannot create response file source.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: source
WORKING_PATH: \"$proj_dir\"
MODULE: source
VHDL_FILE_LIST: osctimer.vhd source.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf source.edi -out source.bl0 -err automake.err -log source.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:51:40 ###########


########## Tcl recorder starts at 12/28/21 15:52:29 ##########

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
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" uz_i2c_slave_D1.vhd -o uz_i2c_slave_D1.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:52:29 ###########


########## Tcl recorder starts at 12/28/21 15:54:45 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open source.cmd w} rspFile] {
	puts stderr "Cannot create response file source.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: source
WORKING_PATH: \"$proj_dir\"
MODULE: source
VHDL_FILE_LIST: source.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf source.edi -out source.bl0 -err automake.err -log source.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 15:54:45 ###########


########## Tcl recorder starts at 12/28/21 15:59:03 ##########

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

########## Tcl recorder end at 12/28/21 15:59:03 ###########


########## Tcl recorder starts at 12/28/21 15:59:06 ##########

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

########## Tcl recorder end at 12/28/21 15:59:06 ###########


########## Tcl recorder starts at 12/28/21 15:59:38 ##########

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

########## Tcl recorder end at 12/28/21 15:59:38 ###########


########## Tcl recorder starts at 12/28/21 16:00:35 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" source"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:00:35 ###########


########## Tcl recorder starts at 12/28/21 16:00:43 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:00:43 ###########


########## Tcl recorder starts at 12/28/21 16:01:15 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:01:15 ###########


########## Tcl recorder starts at 12/28/21 16:01:34 ##########

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

########## Tcl recorder end at 12/28/21 16:01:34 ###########


########## Tcl recorder starts at 12/28/21 16:01:38 ##########

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

########## Tcl recorder end at 12/28/21 16:01:38 ###########


########## Tcl recorder starts at 12/28/21 16:01:43 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: uz_i2c_slave_D1.vhd
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

########## Tcl recorder end at 12/28/21 16:01:43 ###########


########## Tcl recorder starts at 12/28/21 16:02:02 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" i2c_slave"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:02:02 ###########


########## Tcl recorder starts at 12/28/21 16:02:10 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:02:10 ###########


########## Tcl recorder starts at 12/28/21 16:02:46 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd

########## Tcl recorder end at 12/28/21 16:02:46 ###########


########## Tcl recorder starts at 12/28/21 16:03:26 ##########

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
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" uz_i2c_slave_D1.vhd -o uz_i2c_slave_D1.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:03:26 ###########


########## Tcl recorder starts at 12/28/21 16:03:32 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:03:32 ###########


########## Tcl recorder starts at 12/28/21 16:03:52 ##########

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

########## Tcl recorder end at 12/28/21 16:03:52 ###########


########## Tcl recorder starts at 12/28/21 16:04:38 ##########

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

########## Tcl recorder end at 12/28/21 16:04:38 ###########


########## Tcl recorder starts at 12/28/21 16:04:58 ##########

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
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" uz_i2c_slave_D1.vhd -o uz_i2c_slave_D1.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:04:58 ###########


########## Tcl recorder starts at 12/28/21 16:05:03 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:05:03 ###########


########## Tcl recorder starts at 12/28/21 16:05:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer.vhd -o slicer.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:05:50 ###########


########## Tcl recorder starts at 12/28/21 16:05:51 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slicer
WORKING_PATH: \"$proj_dir\"
MODULE: slicer
VHDL_FILE_LIST: slicer.vhd
OUTPUT_FILE_NAME: slicer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer.edi -out slicer.bl0 -err automake.err -log slicer.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:05:51 ###########


########## Tcl recorder starts at 12/28/21 16:07:32 ##########

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
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" uz_i2c_slave_D1.vhd -o uz_i2c_slave_D1.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer8.vhd -o slicer8.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:07:32 ###########


########## Tcl recorder starts at 12/28/21 16:07:55 ##########

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

########## Tcl recorder end at 12/28/21 16:07:55 ###########


########## Tcl recorder starts at 12/28/21 16:08:02 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slice8.cmd w} rspFile] {
	puts stderr "Cannot create response file slice8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf slice8.edi -out slice8.bl0 -err automake.err -log slice8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:08:02 ###########


########## Tcl recorder starts at 12/28/21 16:08:19 ##########

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

########## Tcl recorder end at 12/28/21 16:08:19 ###########


########## Tcl recorder starts at 12/28/21 16:08:41 ##########

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

########## Tcl recorder end at 12/28/21 16:08:41 ###########


########## Tcl recorder starts at 12/28/21 16:08:47 ##########

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

########## Tcl recorder end at 12/28/21 16:08:47 ###########


########## Tcl recorder starts at 12/28/21 16:08:53 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slice8.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: uz_i2c_slave_D1.vhd
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
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open source.cmd w} rspFile] {
	puts stderr "Cannot create response file source.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: source
WORKING_PATH: \"$proj_dir\"
MODULE: source
VHDL_FILE_LIST: source.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf source.edi -out source.bl0 -err automake.err -log source.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" source.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 16:08:53 ###########


########## Tcl recorder starts at 12/28/21 16:10:07 ##########

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

########## Tcl recorder end at 12/28/21 16:10:07 ###########


########## Tcl recorder starts at 12/28/21 16:10:32 ##########

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

########## Tcl recorder end at 12/28/21 16:10:32 ###########


########## Tcl recorder starts at 12/28/21 16:10:36 ##########

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

########## Tcl recorder end at 12/28/21 16:10:36 ###########


########## Tcl recorder starts at 12/28/21 16:10:38 ##########

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

########## Tcl recorder end at 12/28/21 16:10:38 ###########


########## Tcl recorder starts at 12/28/21 16:10:39 ##########

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

########## Tcl recorder end at 12/28/21 16:10:39 ###########


########## Tcl recorder starts at 12/28/21 16:11:18 ##########

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

########## Tcl recorder end at 12/28/21 16:11:18 ###########


########## Tcl recorder starts at 12/28/21 16:11:27 ##########

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

########## Tcl recorder end at 12/28/21 16:11:27 ###########


########## Tcl recorder starts at 12/28/21 16:13:02 ##########

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

########## Tcl recorder end at 12/28/21 16:13:02 ###########


########## Tcl recorder starts at 12/28/21 16:13:24 ##########

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

########## Tcl recorder end at 12/28/21 16:13:24 ###########


########## Tcl recorder starts at 12/28/21 16:14:37 ##########

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

########## Tcl recorder end at 12/28/21 16:14:37 ###########


########## Tcl recorder starts at 12/28/21 16:15:25 ##########

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

########## Tcl recorder end at 12/28/21 16:15:25 ###########


########## Tcl recorder starts at 12/28/21 16:15:38 ##########

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

########## Tcl recorder end at 12/28/21 16:15:38 ###########


########## Tcl recorder starts at 12/28/21 16:15:44 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open sourceclocked.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceclocked.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceclocked.edi -out sourceclocked.bl0 -err automake.err -log sourceclocked.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:15:44 ###########


########## Tcl recorder starts at 12/28/21 16:16:26 ##########

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

########## Tcl recorder end at 12/28/21 16:16:26 ###########


########## Tcl recorder starts at 12/28/21 16:16:33 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open sourceclocked.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceclocked.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceclocked.edi -out sourceclocked.bl0 -err automake.err -log sourceclocked.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:16:33 ###########


########## Tcl recorder starts at 12/28/21 16:17:28 ##########

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

########## Tcl recorder end at 12/28/21 16:17:29 ###########


########## Tcl recorder starts at 12/28/21 16:17:34 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open sourceclocked.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceclocked.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceclocked.edi -out sourceclocked.bl0 -err automake.err -log sourceclocked.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:17:34 ###########


########## Tcl recorder starts at 12/28/21 16:18:19 ##########

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

########## Tcl recorder end at 12/28/21 16:18:19 ###########


########## Tcl recorder starts at 12/28/21 16:19:21 ##########

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

########## Tcl recorder end at 12/28/21 16:19:21 ###########


########## Tcl recorder starts at 12/28/21 16:19:27 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open sourceclocked.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceclocked.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceclocked.edi -out sourceclocked.bl0 -err automake.err -log sourceclocked.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:19:27 ###########


########## Tcl recorder starts at 12/28/21 16:19:53 ##########

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

########## Tcl recorder end at 12/28/21 16:19:53 ###########


########## Tcl recorder starts at 12/28/21 16:20:40 ##########

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

########## Tcl recorder end at 12/28/21 16:20:40 ###########


########## Tcl recorder starts at 12/28/21 16:20:47 ##########

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

########## Tcl recorder end at 12/28/21 16:20:47 ###########


########## Tcl recorder starts at 12/28/21 16:20:57 ##########

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

########## Tcl recorder end at 12/28/21 16:20:57 ###########


########## Tcl recorder starts at 12/28/21 16:21:00 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" sourceclocked.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 16:21:00 ###########


########## Tcl recorder starts at 12/28/21 16:25:22 ##########

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

########## Tcl recorder end at 12/28/21 16:25:22 ###########


########## Tcl recorder starts at 12/28/21 16:25:30 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open sourceclocked.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceclocked.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceclocked.edi -out sourceclocked.bl0 -err automake.err -log sourceclocked.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:25:30 ###########


########## Tcl recorder starts at 12/28/21 16:26:12 ##########

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

########## Tcl recorder end at 12/28/21 16:26:12 ###########


########## Tcl recorder starts at 12/28/21 16:26:19 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open sourceclocked.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceclocked.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceclocked.edi -out sourceclocked.bl0 -err automake.err -log sourceclocked.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:26:19 ###########


########## Tcl recorder starts at 12/28/21 16:26:37 ##########

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

########## Tcl recorder end at 12/28/21 16:26:37 ###########


########## Tcl recorder starts at 12/28/21 16:26:43 ##########

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

########## Tcl recorder end at 12/28/21 16:26:43 ###########


########## Tcl recorder starts at 12/28/21 16:26:46 ##########

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

########## Tcl recorder end at 12/28/21 16:26:46 ###########


########## Tcl recorder starts at 12/28/21 16:26:50 ##########

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

########## Tcl recorder end at 12/28/21 16:26:50 ###########


########## Tcl recorder starts at 12/28/21 16:26:51 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" sourceclocked.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 16:26:51 ###########


########## Tcl recorder starts at 12/28/21 16:33:35 ##########

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
if [runCmd "\"$cpld_bin/vhd2jhd\" uz_i2c_slave_D1.vhd -o uz_i2c_slave_D1.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" sourceclocked.vhd -o sourceclocked.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer8.vhd -o slicer8.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:33:35 ###########


########## Tcl recorder starts at 12/28/21 16:33:47 ##########

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

########## Tcl recorder end at 12/28/21 16:33:47 ###########


########## Tcl recorder starts at 12/28/21 16:33:58 ##########

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

########## Tcl recorder end at 12/28/21 16:33:59 ###########


########## Tcl recorder starts at 12/28/21 16:34:02 ##########

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
if [catch {open sourceclocked.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceclocked.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceclocked.edi -out sourceclocked.bl0 -err automake.err -log sourceclocked.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open slice8.cmd w} rspFile] {
	puts stderr "Cannot create response file slice8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf slice8.edi -out slice8.bl0 -err automake.err -log slice8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: uz_i2c_slave_D1.vhd
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
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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

########## Tcl recorder end at 12/28/21 16:34:02 ###########


########## Tcl recorder starts at 12/28/21 16:35:52 ##########

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

########## Tcl recorder end at 12/28/21 16:35:52 ###########


########## Tcl recorder starts at 12/28/21 16:36:29 ##########

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

########## Tcl recorder end at 12/28/21 16:36:29 ###########


########## Tcl recorder starts at 12/28/21 16:38:14 ##########

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

########## Tcl recorder end at 12/28/21 16:38:14 ###########


########## Tcl recorder starts at 12/28/21 16:39:54 ##########

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

########## Tcl recorder end at 12/28/21 16:39:54 ###########


########## Tcl recorder starts at 12/28/21 16:40:08 ##########

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

########## Tcl recorder end at 12/28/21 16:40:08 ###########


########## Tcl recorder starts at 12/28/21 16:40:11 ##########

# Commands to make the Process: 
# Fit Design
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

########## Tcl recorder end at 12/28/21 16:40:11 ###########


########## Tcl recorder starts at 12/28/21 16:40:27 ##########

# Commands to make the Process: 
# Pre-Fit Equations
if [runCmd "\"$cpld_bin/blif2eqn\" i2c_test.bl5 -o i2c_test.eq2 -use_short -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 16:40:27 ###########


########## Tcl recorder starts at 12/28/21 16:40:34 ##########

# Commands to make the Process: 
# JEDEC File
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

########## Tcl recorder end at 12/28/21 16:40:34 ###########


########## Tcl recorder starts at 12/28/21 16:41:26 ##########

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

########## Tcl recorder end at 12/28/21 16:41:26 ###########


########## Tcl recorder starts at 12/28/21 16:41:33 ##########

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

########## Tcl recorder end at 12/28/21 16:41:33 ###########


########## Tcl recorder starts at 12/28/21 16:41:44 ##########

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

########## Tcl recorder end at 12/28/21 16:41:44 ###########


########## Tcl recorder starts at 12/28/21 16:41:46 ##########

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

########## Tcl recorder end at 12/28/21 16:41:46 ###########


########## Tcl recorder starts at 12/28/21 16:42:45 ##########

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

########## Tcl recorder end at 12/28/21 16:42:45 ###########


########## Tcl recorder starts at 12/28/21 16:42:59 ##########

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

########## Tcl recorder end at 12/28/21 16:42:59 ###########


########## Tcl recorder starts at 12/28/21 16:43:05 ##########

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

########## Tcl recorder end at 12/28/21 16:43:05 ###########


########## Tcl recorder starts at 12/28/21 16:43:08 ##########

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

########## Tcl recorder end at 12/28/21 16:43:08 ###########


########## Tcl recorder starts at 12/28/21 16:43:09 ##########

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

########## Tcl recorder end at 12/28/21 16:43:09 ###########


########## Tcl recorder starts at 12/28/21 16:48:43 ##########

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

########## Tcl recorder end at 12/28/21 16:48:43 ###########


########## Tcl recorder starts at 12/28/21 16:48:51 ##########

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

########## Tcl recorder end at 12/28/21 16:48:51 ###########


########## Tcl recorder starts at 12/28/21 16:48:56 ##########

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

########## Tcl recorder end at 12/28/21 16:48:56 ###########


########## Tcl recorder starts at 12/28/21 16:48:57 ##########

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

########## Tcl recorder end at 12/28/21 16:48:57 ###########


########## Tcl recorder starts at 12/28/21 16:49:21 ##########

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

########## Tcl recorder end at 12/28/21 16:49:21 ###########


########## Tcl recorder starts at 12/28/21 16:49:46 ##########

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

########## Tcl recorder end at 12/28/21 16:49:46 ###########


########## Tcl recorder starts at 12/28/21 16:50:30 ##########

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

########## Tcl recorder end at 12/28/21 16:50:30 ###########


########## Tcl recorder starts at 12/28/21 16:50:33 ##########

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

########## Tcl recorder end at 12/28/21 16:50:33 ###########


########## Tcl recorder starts at 12/28/21 16:50:37 ##########

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

########## Tcl recorder end at 12/28/21 16:50:37 ###########


########## Tcl recorder starts at 12/28/21 16:50:48 ##########

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

########## Tcl recorder end at 12/28/21 16:50:48 ###########


########## Tcl recorder starts at 12/28/21 16:51:02 ##########

# Commands to make the Process: 
# JEDEC File
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

########## Tcl recorder end at 12/28/21 16:51:02 ###########


########## Tcl recorder starts at 12/28/21 16:57:12 ##########

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

########## Tcl recorder end at 12/28/21 16:57:12 ###########


########## Tcl recorder starts at 12/28/21 16:57:18 ##########

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

########## Tcl recorder end at 12/28/21 16:57:18 ###########


########## Tcl recorder starts at 12/28/21 16:57:23 ##########

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

########## Tcl recorder end at 12/28/21 16:57:23 ###########


########## Tcl recorder starts at 12/28/21 16:57:26 ##########

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

########## Tcl recorder end at 12/28/21 16:57:26 ###########


########## Tcl recorder starts at 12/28/21 17:00:43 ##########

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

########## Tcl recorder end at 12/28/21 17:00:43 ###########


########## Tcl recorder starts at 12/28/21 17:00:51 ##########

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

########## Tcl recorder end at 12/28/21 17:00:51 ###########


########## Tcl recorder starts at 12/28/21 17:01:08 ##########

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

########## Tcl recorder end at 12/28/21 17:01:08 ###########


########## Tcl recorder starts at 12/28/21 17:01:10 ##########

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

########## Tcl recorder end at 12/28/21 17:01:10 ###########


########## Tcl recorder starts at 12/28/21 17:01:38 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci i2c_test.lct -touch i2c_test.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 17:01:38 ###########


########## Tcl recorder starts at 12/28/21 17:02:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" source.vhd -o source.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 17:02:17 ###########


########## Tcl recorder starts at 12/28/21 17:02:21 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open source.cmd w} rspFile] {
	puts stderr "Cannot create response file source.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: source
WORKING_PATH: \"$proj_dir\"
MODULE: source
VHDL_FILE_LIST: source.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf source.edi -out source.bl0 -err automake.err -log source.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 17:02:21 ###########


########## Tcl recorder starts at 12/28/21 17:02:38 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" source"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 17:02:38 ###########


########## Tcl recorder starts at 12/28/21 17:02:50 ##########

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

########## Tcl recorder end at 12/28/21 17:02:50 ###########


########## Tcl recorder starts at 12/28/21 17:02:53 ##########

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

########## Tcl recorder end at 12/28/21 17:02:53 ###########


########## Tcl recorder starts at 12/28/21 17:02:59 ##########

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

########## Tcl recorder end at 12/28/21 17:02:59 ###########


########## Tcl recorder starts at 12/28/21 17:03:00 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" source.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 17:03:00 ###########


########## Tcl recorder starts at 12/28/21 17:03:25 ##########

# Commands to make the Process: 
# JEDEC File
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
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open sourceclocked.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceclocked.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceclocked.edi -out sourceclocked.bl0 -err automake.err -log sourceclocked.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open slice8.cmd w} rspFile] {
	puts stderr "Cannot create response file slice8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf slice8.edi -out slice8.bl0 -err automake.err -log slice8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: uz_i2c_slave_D1.vhd
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
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open source.cmd w} rspFile] {
	puts stderr "Cannot create response file source.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: source
WORKING_PATH: \"$proj_dir\"
MODULE: source
VHDL_FILE_LIST: source.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf source.edi -out source.bl0 -err automake.err -log source.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" source.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 17:03:25 ###########


########## Tcl recorder starts at 12/28/21 17:05:26 ##########

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

########## Tcl recorder end at 12/28/21 17:05:26 ###########


########## Tcl recorder starts at 12/28/21 17:05:37 ##########

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

########## Tcl recorder end at 12/28/21 17:05:37 ###########


########## Tcl recorder starts at 12/28/21 17:05:41 ##########

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

########## Tcl recorder end at 12/28/21 17:05:41 ###########


########## Tcl recorder starts at 12/28/21 17:05:42 ##########

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

########## Tcl recorder end at 12/28/21 17:05:42 ###########


########## Tcl recorder starts at 12/28/21 17:06:23 ##########

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

########## Tcl recorder end at 12/28/21 17:06:23 ###########


########## Tcl recorder starts at 12/28/21 17:06:33 ##########

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

########## Tcl recorder end at 12/28/21 17:06:33 ###########


########## Tcl recorder starts at 12/28/21 17:06:37 ##########

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

########## Tcl recorder end at 12/28/21 17:06:37 ###########


########## Tcl recorder starts at 12/28/21 17:06:43 ##########

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
if [runCmd "\"$cpld_bin/vhd2jhd\" uz_i2c_slave_D1.vhd -o uz_i2c_slave_D1.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" sourceclocked.vhd -o sourceclocked.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer8.vhd -o slicer8.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 17:06:43 ###########


########## Tcl recorder starts at 12/28/21 17:06:48 ##########

# Commands to make the Process: 
# Fit Design
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
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open sourceclocked.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceclocked.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceclocked.edi -out sourceclocked.bl0 -err automake.err -log sourceclocked.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open slice8.cmd w} rspFile] {
	puts stderr "Cannot create response file slice8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf slice8.edi -out slice8.bl0 -err automake.err -log slice8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: uz_i2c_slave_D1.vhd
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
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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

########## Tcl recorder end at 12/28/21 17:06:48 ###########


########## Tcl recorder starts at 12/28/21 17:08:19 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci i2c_test.lct -touch i2c_test.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 17:08:19 ###########


########## Tcl recorder starts at 12/28/21 17:08:45 ##########

# Commands to make the Process: 
# Fit Design
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

########## Tcl recorder end at 12/28/21 17:08:45 ###########


########## Tcl recorder starts at 12/28/21 17:09:50 ##########

# Commands to make the Process: 
# Fit Design
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

########## Tcl recorder end at 12/28/21 17:09:50 ###########


########## Tcl recorder starts at 12/28/21 17:10:28 ##########

# Commands to make the Process: 
# Constraint Editor
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

########## Tcl recorder end at 12/28/21 17:10:28 ###########


########## Tcl recorder starts at 12/28/21 17:30:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" uz_i2c_slave_D1.vhd -o uz_i2c_slave_D1.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 17:30:42 ###########


########## Tcl recorder starts at 12/28/21 17:30:47 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: uz_i2c_slave_D1.vhd
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

########## Tcl recorder end at 12/28/21 17:30:47 ###########


########## Tcl recorder starts at 12/28/21 17:31:05 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" i2c_slave"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 17:31:05 ###########


########## Tcl recorder starts at 12/28/21 17:33:18 ##########

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

########## Tcl recorder end at 12/28/21 17:33:18 ###########


########## Tcl recorder starts at 12/28/21 17:33:25 ##########

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

########## Tcl recorder end at 12/28/21 17:33:25 ###########


########## Tcl recorder starts at 12/28/21 17:33:28 ##########

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

########## Tcl recorder end at 12/28/21 17:33:28 ###########


########## Tcl recorder starts at 12/28/21 17:33:30 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" i2c_slave.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 17:33:30 ###########


########## Tcl recorder starts at 12/28/21 17:35:16 ##########

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

########## Tcl recorder end at 12/28/21 17:35:16 ###########


########## Tcl recorder starts at 12/28/21 17:36:29 ##########

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

########## Tcl recorder end at 12/28/21 17:36:29 ###########


########## Tcl recorder starts at 12/28/21 17:37:20 ##########

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

########## Tcl recorder end at 12/28/21 17:37:20 ###########


########## Tcl recorder starts at 12/28/21 17:40:45 ##########

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

########## Tcl recorder end at 12/28/21 17:40:45 ###########


########## Tcl recorder starts at 12/28/21 17:42:13 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 17:42:13 ###########


########## Tcl recorder starts at 12/28/21 17:42:34 ##########

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

########## Tcl recorder end at 12/28/21 17:42:34 ###########


########## Tcl recorder starts at 12/28/21 17:46:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" uz_i2c_slave_D1.vhd -o uz_i2c_slave_D1.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 17:46:07 ###########


########## Tcl recorder starts at 12/28/21 17:46:13 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open i2c_slave.cmd w} rspFile] {
	puts stderr "Cannot create response file i2c_slave.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: i2c_slave
WORKING_PATH: \"$proj_dir\"
MODULE: i2c_slave
VHDL_FILE_LIST: uz_i2c_slave_D1.vhd
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

########## Tcl recorder end at 12/28/21 17:46:13 ###########


########## Tcl recorder starts at 12/28/21 17:46:35 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" i2c_slave"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 17:46:35 ###########


########## Tcl recorder starts at 12/28/21 17:48:41 ##########

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

########## Tcl recorder end at 12/28/21 17:48:41 ###########


########## Tcl recorder starts at 12/28/21 17:48:45 ##########

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

########## Tcl recorder end at 12/28/21 17:48:45 ###########


########## Tcl recorder starts at 12/28/21 17:48:49 ##########

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

########## Tcl recorder end at 12/28/21 17:48:49 ###########


########## Tcl recorder starts at 12/28/21 17:48:53 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" i2c_slave.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 17:48:53 ###########


########## Tcl recorder starts at 12/28/21 17:50:06 ##########

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

########## Tcl recorder end at 12/28/21 17:50:06 ###########


########## Tcl recorder starts at 12/28/21 18:00:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 18:00:52 ###########


########## Tcl recorder starts at 12/28/21 18:02:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/debounce.vhd -o debounce.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 18:02:36 ###########


########## Tcl recorder starts at 12/28/21 18:03:42 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 18:03:42 ###########


########## Tcl recorder starts at 12/28/21 18:04:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 18:04:59 ###########


########## Tcl recorder starts at 12/28/21 18:05:08 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 18:05:08 ###########


########## Tcl recorder starts at 12/28/21 18:05:33 ##########

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

########## Tcl recorder end at 12/28/21 18:05:33 ###########


########## Tcl recorder starts at 12/28/21 18:08:03 ##########

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

########## Tcl recorder end at 12/28/21 18:08:03 ###########


########## Tcl recorder starts at 12/28/21 18:08:09 ##########

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

########## Tcl recorder end at 12/28/21 18:08:09 ###########


########## Tcl recorder starts at 12/28/21 18:08:28 ##########

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

########## Tcl recorder end at 12/28/21 18:08:28 ###########


########## Tcl recorder starts at 12/28/21 18:08:29 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" I2C_minion.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 18:08:29 ###########


########## Tcl recorder starts at 12/28/21 18:09:31 ##########

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

########## Tcl recorder end at 12/28/21 18:09:31 ###########


########## Tcl recorder starts at 12/28/21 18:11:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 18:11:35 ###########


########## Tcl recorder starts at 12/28/21 18:11:40 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 18:11:40 ###########


########## Tcl recorder starts at 12/28/21 18:12:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 18:12:17 ###########


########## Tcl recorder starts at 12/28/21 18:12:21 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 18:12:21 ###########


########## Tcl recorder starts at 12/28/21 18:13:01 ##########

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

########## Tcl recorder end at 12/28/21 18:13:01 ###########


########## Tcl recorder starts at 12/28/21 18:13:20 ##########

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
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer8.vhd -o slicer8.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" sourceclocked.vhd -o sourceclocked.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/debounce.vhd -o debounce.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 18:13:20 ###########


########## Tcl recorder starts at 12/28/21 18:13:23 ##########

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

########## Tcl recorder end at 12/28/21 18:13:23 ###########


########## Tcl recorder starts at 12/28/21 18:13:28 ##########

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

########## Tcl recorder end at 12/28/21 18:13:28 ###########


########## Tcl recorder starts at 12/28/21 18:13:31 ##########

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
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open sourceclocked.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceclocked.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceclocked.edi -out sourceclocked.bl0 -err automake.err -log sourceclocked.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open slice8.cmd w} rspFile] {
	puts stderr "Cannot create response file slice8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf slice8.edi -out slice8.bl0 -err automake.err -log slice8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open concat8.cmd w} rspFile] {
	puts stderr "Cannot create response file concat8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf concat8.edi -out concat8.bl0 -err automake.err -log concat8.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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

########## Tcl recorder end at 12/28/21 18:13:31 ###########


########## Tcl recorder starts at 12/28/21 18:15:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 18:15:43 ###########


########## Tcl recorder starts at 12/28/21 18:17:38 ##########

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

########## Tcl recorder end at 12/28/21 18:17:38 ###########


########## Tcl recorder starts at 12/28/21 19:13:09 ##########

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

########## Tcl recorder end at 12/28/21 19:13:09 ###########


########## Tcl recorder starts at 12/28/21 19:13:12 ##########

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

########## Tcl recorder end at 12/28/21 19:13:12 ###########


########## Tcl recorder starts at 12/28/21 19:13:15 ##########

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
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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

########## Tcl recorder end at 12/28/21 19:13:15 ###########


########## Tcl recorder starts at 12/28/21 19:13:47 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 19:13:47 ###########


########## Tcl recorder starts at 12/28/21 19:37:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 19:37:46 ###########


########## Tcl recorder starts at 12/28/21 19:37:55 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 19:37:55 ###########


########## Tcl recorder starts at 12/28/21 19:38:22 ##########

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

########## Tcl recorder end at 12/28/21 19:38:22 ###########


########## Tcl recorder starts at 12/28/21 19:38:33 ##########

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

########## Tcl recorder end at 12/28/21 19:38:33 ###########


########## Tcl recorder starts at 12/28/21 19:38:38 ##########

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

########## Tcl recorder end at 12/28/21 19:38:38 ###########


########## Tcl recorder starts at 12/28/21 19:38:42 ##########

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

########## Tcl recorder end at 12/28/21 19:38:42 ###########


########## Tcl recorder starts at 12/28/21 19:40:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 19:40:22 ###########


########## Tcl recorder starts at 12/28/21 19:41:03 ##########

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

########## Tcl recorder end at 12/28/21 19:41:03 ###########


########## Tcl recorder starts at 12/28/21 19:41:11 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 19:41:11 ###########


########## Tcl recorder starts at 12/28/21 19:41:48 ##########

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

########## Tcl recorder end at 12/28/21 19:41:48 ###########


########## Tcl recorder starts at 12/28/21 19:41:51 ##########

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

########## Tcl recorder end at 12/28/21 19:41:51 ###########


########## Tcl recorder starts at 12/28/21 19:41:55 ##########

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

########## Tcl recorder end at 12/28/21 19:41:55 ###########


########## Tcl recorder starts at 12/28/21 19:41:59 ##########

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

########## Tcl recorder end at 12/28/21 19:41:59 ###########


########## Tcl recorder starts at 12/28/21 19:42:00 ##########

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

########## Tcl recorder end at 12/28/21 19:42:00 ###########


########## Tcl recorder starts at 12/28/21 19:55:54 ##########

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

########## Tcl recorder end at 12/28/21 19:55:54 ###########


########## Tcl recorder starts at 12/28/21 19:56:03 ##########

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

########## Tcl recorder end at 12/28/21 19:56:03 ###########


########## Tcl recorder starts at 12/28/21 19:56:05 ##########

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

########## Tcl recorder end at 12/28/21 19:56:05 ###########


########## Tcl recorder starts at 12/28/21 19:56:07 ##########

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

########## Tcl recorder end at 12/28/21 19:56:07 ###########


########## Tcl recorder starts at 12/28/21 19:56:24 ##########

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

########## Tcl recorder end at 12/28/21 19:56:24 ###########


########## Tcl recorder starts at 12/28/21 20:00:45 ##########

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

########## Tcl recorder end at 12/28/21 20:00:45 ###########


########## Tcl recorder starts at 12/28/21 20:00:55 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:00:55 ###########


########## Tcl recorder starts at 12/28/21 20:26:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:26:04 ###########


########## Tcl recorder starts at 12/28/21 20:26:21 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:26:21 ###########


########## Tcl recorder starts at 12/28/21 20:28:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:28:59 ###########


########## Tcl recorder starts at 12/28/21 20:29:04 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:29:04 ###########


########## Tcl recorder starts at 12/28/21 20:30:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:30:09 ###########


########## Tcl recorder starts at 12/28/21 20:30:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:30:14 ###########


########## Tcl recorder starts at 12/28/21 20:30:19 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:30:19 ###########


########## Tcl recorder starts at 12/28/21 20:31:05 ##########

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

########## Tcl recorder end at 12/28/21 20:31:05 ###########


########## Tcl recorder starts at 12/28/21 20:32:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slice16.vhd -o slice16.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:32:48 ###########


########## Tcl recorder starts at 12/28/21 20:34:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slice16.vhd -o slice16.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:34:28 ###########


########## Tcl recorder starts at 12/28/21 20:34:33 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slice16.cmd w} rspFile] {
	puts stderr "Cannot create response file slice16.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: slice16
WORKING_PATH: \"$proj_dir\"
MODULE: slice16
VHDL_FILE_LIST: slice16.vhd
OUTPUT_FILE_NAME: slice16
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e slice16 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slice16.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slice16.edi -out slice16.bl0 -err automake.err -log slice16.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:34:33 ###########


########## Tcl recorder starts at 12/28/21 20:34:49 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slice16"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:34:49 ###########


########## Tcl recorder starts at 12/28/21 20:37:18 ##########

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

########## Tcl recorder end at 12/28/21 20:37:18 ###########


########## Tcl recorder starts at 12/28/21 20:37:23 ##########

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

########## Tcl recorder end at 12/28/21 20:37:23 ###########


########## Tcl recorder starts at 12/28/21 20:37:28 ##########

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

########## Tcl recorder end at 12/28/21 20:37:28 ###########


########## Tcl recorder starts at 12/28/21 20:37:32 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" slice16.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/28/21 20:37:32 ###########


########## Tcl recorder starts at 12/28/21 20:37:43 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:37:43 ###########


########## Tcl recorder starts at 12/28/21 20:38:43 ##########

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

########## Tcl recorder end at 12/28/21 20:38:43 ###########


########## Tcl recorder starts at 12/28/21 20:38:46 ##########

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

########## Tcl recorder end at 12/28/21 20:38:46 ###########


########## Tcl recorder starts at 12/28/21 20:38:49 ##########

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

########## Tcl recorder end at 12/28/21 20:38:49 ###########


########## Tcl recorder starts at 12/28/21 20:38:51 ##########

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

########## Tcl recorder end at 12/28/21 20:38:51 ###########


########## Tcl recorder starts at 12/28/21 20:39:02 ##########

# Commands to make the Process: 
# JEDEC File
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

########## Tcl recorder end at 12/28/21 20:39:02 ###########


########## Tcl recorder starts at 12/28/21 20:41:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:41:36 ###########


########## Tcl recorder starts at 12/28/21 20:41:47 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:41:47 ###########


########## Tcl recorder starts at 12/28/21 20:42:07 ##########

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

########## Tcl recorder end at 12/28/21 20:42:07 ###########


########## Tcl recorder starts at 12/28/21 20:42:57 ##########

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

########## Tcl recorder end at 12/28/21 20:42:57 ###########


########## Tcl recorder starts at 12/28/21 20:43:11 ##########

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

########## Tcl recorder end at 12/28/21 20:43:11 ###########


########## Tcl recorder starts at 12/28/21 20:43:17 ##########

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

########## Tcl recorder end at 12/28/21 20:43:17 ###########


########## Tcl recorder starts at 12/28/21 20:43:18 ##########

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

########## Tcl recorder end at 12/28/21 20:43:18 ###########


########## Tcl recorder starts at 12/28/21 20:47:17 ##########

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

########## Tcl recorder end at 12/28/21 20:47:17 ###########


########## Tcl recorder starts at 12/28/21 20:47:20 ##########

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

########## Tcl recorder end at 12/28/21 20:47:20 ###########


########## Tcl recorder starts at 12/28/21 20:47:24 ##########

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

########## Tcl recorder end at 12/28/21 20:47:24 ###########


########## Tcl recorder starts at 12/28/21 20:47:25 ##########

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

########## Tcl recorder end at 12/28/21 20:47:25 ###########


########## Tcl recorder starts at 12/28/21 20:47:37 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:47:37 ###########


########## Tcl recorder starts at 12/28/21 20:50:38 ##########

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

########## Tcl recorder end at 12/28/21 20:50:38 ###########


########## Tcl recorder starts at 12/28/21 20:50:43 ##########

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

########## Tcl recorder end at 12/28/21 20:50:43 ###########


########## Tcl recorder starts at 12/28/21 20:50:48 ##########

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

########## Tcl recorder end at 12/28/21 20:50:48 ###########


########## Tcl recorder starts at 12/28/21 20:50:49 ##########

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

########## Tcl recorder end at 12/28/21 20:50:49 ###########


########## Tcl recorder starts at 12/28/21 20:50:59 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 20:50:59 ###########


########## Tcl recorder starts at 12/28/21 20:54:19 ##########

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

########## Tcl recorder end at 12/28/21 20:54:19 ###########


########## Tcl recorder starts at 12/28/21 21:18:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 21:18:36 ###########


########## Tcl recorder starts at 12/28/21 21:20:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 21:20:55 ###########


########## Tcl recorder starts at 12/28/21 21:21:11 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 21:21:12 ###########


########## Tcl recorder starts at 12/28/21 21:21:44 ##########

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

########## Tcl recorder end at 12/28/21 21:21:44 ###########


########## Tcl recorder starts at 12/28/21 21:23:37 ##########

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

########## Tcl recorder end at 12/28/21 21:23:37 ###########


########## Tcl recorder starts at 12/28/21 21:23:40 ##########

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

########## Tcl recorder end at 12/28/21 21:23:40 ###########


########## Tcl recorder starts at 12/28/21 21:23:46 ##########

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

########## Tcl recorder end at 12/28/21 21:23:46 ###########


########## Tcl recorder starts at 12/28/21 21:23:51 ##########

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

########## Tcl recorder end at 12/28/21 21:23:51 ###########


########## Tcl recorder starts at 12/28/21 21:23:53 ##########

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

########## Tcl recorder end at 12/28/21 21:23:53 ###########


########## Tcl recorder starts at 12/28/21 21:42:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 21:42:19 ###########


########## Tcl recorder starts at 12/28/21 21:42:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 21:42:32 ###########


########## Tcl recorder starts at 12/28/21 21:42:36 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 21:42:36 ###########


########## Tcl recorder starts at 12/28/21 21:44:11 ##########

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

########## Tcl recorder end at 12/28/21 21:44:11 ###########


########## Tcl recorder starts at 12/28/21 21:45:18 ##########

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

########## Tcl recorder end at 12/28/21 21:45:18 ###########


########## Tcl recorder starts at 12/28/21 21:45:27 ##########

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

########## Tcl recorder end at 12/28/21 21:45:27 ###########


########## Tcl recorder starts at 12/28/21 21:45:31 ##########

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

########## Tcl recorder end at 12/28/21 21:45:31 ###########


########## Tcl recorder starts at 12/28/21 21:45:33 ##########

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

########## Tcl recorder end at 12/28/21 21:45:33 ###########


########## Tcl recorder starts at 12/28/21 21:52:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 21:52:40 ###########


########## Tcl recorder starts at 12/28/21 21:55:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 21:55:34 ###########


########## Tcl recorder starts at 12/28/21 21:56:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 21:56:31 ###########


########## Tcl recorder starts at 12/28/21 22:01:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:01:56 ###########


########## Tcl recorder starts at 12/28/21 22:04:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:04:45 ###########


########## Tcl recorder starts at 12/28/21 22:04:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:04:53 ###########


########## Tcl recorder starts at 12/28/21 22:07:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:07:54 ###########


########## Tcl recorder starts at 12/28/21 22:10:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:10:22 ###########


########## Tcl recorder starts at 12/28/21 22:12:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:12:28 ###########


########## Tcl recorder starts at 12/28/21 22:14:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:14:58 ###########


########## Tcl recorder starts at 12/28/21 22:15:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:15:41 ###########


########## Tcl recorder starts at 12/28/21 22:17:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:17:35 ###########


########## Tcl recorder starts at 12/28/21 22:19:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:19:03 ###########


########## Tcl recorder starts at 12/28/21 22:19:09 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:19:09 ###########


########## Tcl recorder starts at 12/28/21 22:20:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:20:09 ###########


########## Tcl recorder starts at 12/28/21 22:20:12 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:20:12 ###########


########## Tcl recorder starts at 12/28/21 22:21:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:21:19 ###########


########## Tcl recorder starts at 12/28/21 22:21:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:21:25 ###########


########## Tcl recorder starts at 12/28/21 22:21:44 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:21:44 ###########


########## Tcl recorder starts at 12/28/21 22:23:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:23:23 ###########


########## Tcl recorder starts at 12/28/21 22:23:43 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:23:43 ###########


########## Tcl recorder starts at 12/28/21 22:24:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:24:30 ###########


########## Tcl recorder starts at 12/28/21 22:24:33 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:24:33 ###########


########## Tcl recorder starts at 12/28/21 22:25:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:25:25 ###########


########## Tcl recorder starts at 12/28/21 22:26:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:26:49 ###########


########## Tcl recorder starts at 12/28/21 22:27:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:27:57 ###########


########## Tcl recorder starts at 12/28/21 22:28:00 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:28:00 ###########


########## Tcl recorder starts at 12/28/21 22:29:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:29:21 ###########


########## Tcl recorder starts at 12/28/21 22:29:32 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:29:32 ###########


########## Tcl recorder starts at 12/28/21 22:30:11 ##########

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

########## Tcl recorder end at 12/28/21 22:30:11 ###########


########## Tcl recorder starts at 12/28/21 22:30:26 ##########

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

########## Tcl recorder end at 12/28/21 22:30:26 ###########


########## Tcl recorder starts at 12/28/21 22:30:28 ##########

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

########## Tcl recorder end at 12/28/21 22:30:28 ###########


########## Tcl recorder starts at 12/28/21 22:30:32 ##########

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

########## Tcl recorder end at 12/28/21 22:30:32 ###########


########## Tcl recorder starts at 12/28/21 22:30:33 ##########

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

########## Tcl recorder end at 12/28/21 22:30:33 ###########


########## Tcl recorder starts at 12/28/21 22:33:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:33:37 ###########


########## Tcl recorder starts at 12/28/21 22:33:49 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:33:49 ###########


########## Tcl recorder starts at 12/28/21 22:34:33 ##########

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

########## Tcl recorder end at 12/28/21 22:34:33 ###########


########## Tcl recorder starts at 12/28/21 22:34:40 ##########

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

########## Tcl recorder end at 12/28/21 22:34:40 ###########


########## Tcl recorder starts at 12/28/21 22:34:46 ##########

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

########## Tcl recorder end at 12/28/21 22:34:46 ###########


########## Tcl recorder starts at 12/28/21 22:34:49 ##########

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

########## Tcl recorder end at 12/28/21 22:34:49 ###########


########## Tcl recorder starts at 12/28/21 22:34:50 ##########

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

########## Tcl recorder end at 12/28/21 22:34:50 ###########


########## Tcl recorder starts at 12/28/21 22:40:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:40:38 ###########


########## Tcl recorder starts at 12/28/21 22:40:44 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:40:44 ###########


########## Tcl recorder starts at 12/28/21 22:41:04 ##########

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

########## Tcl recorder end at 12/28/21 22:41:04 ###########


########## Tcl recorder starts at 12/28/21 22:41:09 ##########

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

########## Tcl recorder end at 12/28/21 22:41:09 ###########


########## Tcl recorder starts at 12/28/21 22:41:12 ##########

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

########## Tcl recorder end at 12/28/21 22:41:13 ###########


########## Tcl recorder starts at 12/28/21 22:41:16 ##########

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

########## Tcl recorder end at 12/28/21 22:41:16 ###########


########## Tcl recorder starts at 12/28/21 22:41:17 ##########

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

########## Tcl recorder end at 12/28/21 22:41:17 ###########


########## Tcl recorder starts at 12/28/21 22:47:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:47:33 ###########


########## Tcl recorder starts at 12/28/21 22:53:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:53:19 ###########


########## Tcl recorder starts at 12/28/21 22:53:30 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:53:30 ###########


########## Tcl recorder starts at 12/28/21 22:53:49 ##########

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

########## Tcl recorder end at 12/28/21 22:53:49 ###########


########## Tcl recorder starts at 12/28/21 22:53:52 ##########

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

########## Tcl recorder end at 12/28/21 22:53:52 ###########


########## Tcl recorder starts at 12/28/21 22:53:57 ##########

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

########## Tcl recorder end at 12/28/21 22:53:57 ###########


########## Tcl recorder starts at 12/28/21 22:54:00 ##########

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

########## Tcl recorder end at 12/28/21 22:54:00 ###########


########## Tcl recorder starts at 12/28/21 22:54:01 ##########

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

########## Tcl recorder end at 12/28/21 22:54:01 ###########


########## Tcl recorder starts at 12/28/21 22:58:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 22:58:20 ###########


########## Tcl recorder starts at 12/28/21 23:00:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:00:04 ###########


########## Tcl recorder starts at 12/28/21 23:00:16 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:00:16 ###########


########## Tcl recorder starts at 12/28/21 23:01:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:01:01 ###########


########## Tcl recorder starts at 12/28/21 23:01:04 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:01:04 ###########


########## Tcl recorder starts at 12/28/21 23:01:24 ##########

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

########## Tcl recorder end at 12/28/21 23:01:24 ###########


########## Tcl recorder starts at 12/28/21 23:01:29 ##########

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

########## Tcl recorder end at 12/28/21 23:01:29 ###########


########## Tcl recorder starts at 12/28/21 23:01:32 ##########

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

########## Tcl recorder end at 12/28/21 23:01:32 ###########


########## Tcl recorder starts at 12/28/21 23:01:36 ##########

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

########## Tcl recorder end at 12/28/21 23:01:36 ###########


########## Tcl recorder starts at 12/28/21 23:01:37 ##########

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

########## Tcl recorder end at 12/28/21 23:01:37 ###########


########## Tcl recorder starts at 12/28/21 23:01:48 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:01:48 ###########


########## Tcl recorder starts at 12/28/21 23:06:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:06:07 ###########


########## Tcl recorder starts at 12/28/21 23:06:11 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:06:11 ###########


########## Tcl recorder starts at 12/28/21 23:06:30 ##########

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

########## Tcl recorder end at 12/28/21 23:06:30 ###########


########## Tcl recorder starts at 12/28/21 23:06:35 ##########

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

########## Tcl recorder end at 12/28/21 23:06:35 ###########


########## Tcl recorder starts at 12/28/21 23:06:38 ##########

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

########## Tcl recorder end at 12/28/21 23:06:38 ###########


########## Tcl recorder starts at 12/28/21 23:06:50 ##########

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

########## Tcl recorder end at 12/28/21 23:06:50 ###########


########## Tcl recorder starts at 12/28/21 23:06:54 ##########

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

########## Tcl recorder end at 12/28/21 23:06:54 ###########


########## Tcl recorder starts at 12/28/21 23:06:55 ##########

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

########## Tcl recorder end at 12/28/21 23:06:55 ###########


########## Tcl recorder starts at 12/28/21 23:09:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:09:12 ###########


########## Tcl recorder starts at 12/28/21 23:09:16 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:09:16 ###########


########## Tcl recorder starts at 12/28/21 23:09:36 ##########

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

########## Tcl recorder end at 12/28/21 23:09:36 ###########


########## Tcl recorder starts at 12/28/21 23:09:40 ##########

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

########## Tcl recorder end at 12/28/21 23:09:40 ###########


########## Tcl recorder starts at 12/28/21 23:09:42 ##########

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

########## Tcl recorder end at 12/28/21 23:09:42 ###########


########## Tcl recorder starts at 12/28/21 23:09:45 ##########

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

########## Tcl recorder end at 12/28/21 23:09:45 ###########


########## Tcl recorder starts at 12/28/21 23:09:47 ##########

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

########## Tcl recorder end at 12/28/21 23:09:47 ###########


########## Tcl recorder starts at 12/28/21 23:10:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:10:59 ###########


########## Tcl recorder starts at 12/28/21 23:11:02 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:11:02 ###########


########## Tcl recorder starts at 12/28/21 23:11:21 ##########

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

########## Tcl recorder end at 12/28/21 23:11:21 ###########


########## Tcl recorder starts at 12/28/21 23:11:24 ##########

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

########## Tcl recorder end at 12/28/21 23:11:25 ###########


########## Tcl recorder starts at 12/28/21 23:11:29 ##########

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

########## Tcl recorder end at 12/28/21 23:11:29 ###########


########## Tcl recorder starts at 12/28/21 23:11:31 ##########

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

########## Tcl recorder end at 12/28/21 23:11:31 ###########


########## Tcl recorder starts at 12/28/21 23:11:32 ##########

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

########## Tcl recorder end at 12/28/21 23:11:32 ###########


########## Tcl recorder starts at 12/28/21 23:13:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:13:21 ###########


########## Tcl recorder starts at 12/28/21 23:13:30 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:13:30 ###########


########## Tcl recorder starts at 12/28/21 23:13:51 ##########

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

########## Tcl recorder end at 12/28/21 23:13:51 ###########


########## Tcl recorder starts at 12/28/21 23:13:54 ##########

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

########## Tcl recorder end at 12/28/21 23:13:54 ###########


########## Tcl recorder starts at 12/28/21 23:13:56 ##########

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

########## Tcl recorder end at 12/28/21 23:13:56 ###########


########## Tcl recorder starts at 12/28/21 23:13:58 ##########

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

########## Tcl recorder end at 12/28/21 23:13:59 ###########


########## Tcl recorder starts at 12/28/21 23:13:59 ##########

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

########## Tcl recorder end at 12/28/21 23:13:59 ###########


########## Tcl recorder starts at 12/28/21 23:37:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:37:38 ###########


########## Tcl recorder starts at 12/28/21 23:37:43 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:37:43 ###########


########## Tcl recorder starts at 12/28/21 23:38:02 ##########

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

########## Tcl recorder end at 12/28/21 23:38:02 ###########


########## Tcl recorder starts at 12/28/21 23:38:05 ##########

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

########## Tcl recorder end at 12/28/21 23:38:05 ###########


########## Tcl recorder starts at 12/28/21 23:38:08 ##########

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

########## Tcl recorder end at 12/28/21 23:38:08 ###########


########## Tcl recorder starts at 12/28/21 23:38:10 ##########

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

########## Tcl recorder end at 12/28/21 23:38:10 ###########


########## Tcl recorder starts at 12/28/21 23:38:11 ##########

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

########## Tcl recorder end at 12/28/21 23:38:11 ###########


########## Tcl recorder starts at 12/28/21 23:40:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:40:39 ###########


########## Tcl recorder starts at 12/28/21 23:40:45 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:40:45 ###########


########## Tcl recorder starts at 12/28/21 23:41:04 ##########

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

########## Tcl recorder end at 12/28/21 23:41:04 ###########


########## Tcl recorder starts at 12/28/21 23:41:08 ##########

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

########## Tcl recorder end at 12/28/21 23:41:08 ###########


########## Tcl recorder starts at 12/28/21 23:41:10 ##########

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

########## Tcl recorder end at 12/28/21 23:41:10 ###########


########## Tcl recorder starts at 12/28/21 23:41:13 ##########

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

########## Tcl recorder end at 12/28/21 23:41:13 ###########


########## Tcl recorder starts at 12/28/21 23:41:14 ##########

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

########## Tcl recorder end at 12/28/21 23:41:14 ###########


########## Tcl recorder starts at 12/28/21 23:42:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:42:31 ###########


########## Tcl recorder starts at 12/28/21 23:42:36 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:42:36 ###########


########## Tcl recorder starts at 12/28/21 23:42:55 ##########

# Commands to make the Process: 
# ABEL Test Vector Template
if [runCmd "\"$cpld_bin/vhd2naf\" -tfi -proj i2c_test -mod I2C_minion -out I2C_minion -tpl \"$install_dir/ispcpld/plsi/abel/plsiabt.tft\" -ext abt -p \"$install_dir/ispcpld/generic\" ../fpga-i2c-minion/I2C_minion.vhd"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:42:55 ###########


########## Tcl recorder starts at 12/28/21 23:43:00 ##########

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

########## Tcl recorder end at 12/28/21 23:43:00 ###########


########## Tcl recorder starts at 12/28/21 23:43:03 ##########

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

########## Tcl recorder end at 12/28/21 23:43:03 ###########


########## Tcl recorder starts at 12/28/21 23:43:07 ##########

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

########## Tcl recorder end at 12/28/21 23:43:07 ###########


########## Tcl recorder starts at 12/28/21 23:43:12 ##########

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

########## Tcl recorder end at 12/28/21 23:43:12 ###########


########## Tcl recorder starts at 12/28/21 23:43:13 ##########

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

########## Tcl recorder end at 12/28/21 23:43:13 ###########


########## Tcl recorder starts at 12/28/21 23:43:25 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test -if i2c_test.jed -j2s -log i2c_test.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/28/21 23:43:25 ###########


########## Tcl recorder starts at 12/30/21 20:47:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 20:47:04 ###########


########## Tcl recorder starts at 12/30/21 20:49:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 20:49:25 ###########


########## Tcl recorder starts at 12/30/21 20:52:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 20:52:58 ###########


########## Tcl recorder starts at 12/30/21 20:54:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 20:54:47 ###########


########## Tcl recorder starts at 12/30/21 20:56:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 20:56:25 ###########


########## Tcl recorder starts at 12/30/21 20:56:33 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 20:56:33 ###########


########## Tcl recorder starts at 12/30/21 20:58:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 20:58:42 ###########


########## Tcl recorder starts at 12/30/21 20:58:44 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 20:58:44 ###########


########## Tcl recorder starts at 12/30/21 20:59:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 20:59:28 ###########


########## Tcl recorder starts at 12/30/21 20:59:35 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 20:59:35 ###########


########## Tcl recorder starts at 12/30/21 21:00:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:00:50 ###########


########## Tcl recorder starts at 12/30/21 21:00:52 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:00:52 ###########


########## Tcl recorder starts at 12/30/21 21:01:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:01:46 ###########


########## Tcl recorder starts at 12/30/21 21:01:50 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:01:50 ###########


########## Tcl recorder starts at 12/30/21 21:02:19 ##########

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

########## Tcl recorder end at 12/30/21 21:02:19 ###########


########## Tcl recorder starts at 12/30/21 21:04:50 ##########

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

########## Tcl recorder end at 12/30/21 21:04:51 ###########


########## Tcl recorder starts at 12/30/21 21:04:55 ##########

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

########## Tcl recorder end at 12/30/21 21:04:55 ###########


########## Tcl recorder starts at 12/30/21 21:04:59 ##########

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

########## Tcl recorder end at 12/30/21 21:04:59 ###########


########## Tcl recorder starts at 12/30/21 21:05:01 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" I2C_minion.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
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

########## Tcl recorder end at 12/30/21 21:05:01 ###########


########## Tcl recorder starts at 12/30/21 21:06:13 ##########

# Commands to make the Process: 
# JEDEC File
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

########## Tcl recorder end at 12/30/21 21:06:13 ###########


########## Tcl recorder starts at 12/30/21 21:09:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:09:40 ###########


########## Tcl recorder starts at 12/30/21 21:12:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:12:05 ###########


########## Tcl recorder starts at 12/30/21 21:12:11 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:12:11 ###########


########## Tcl recorder starts at 12/30/21 21:12:30 ##########

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

########## Tcl recorder end at 12/30/21 21:12:30 ###########


########## Tcl recorder starts at 12/30/21 21:12:38 ##########

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

########## Tcl recorder end at 12/30/21 21:12:38 ###########


########## Tcl recorder starts at 12/30/21 21:13:01 ##########

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

########## Tcl recorder end at 12/30/21 21:13:01 ###########


########## Tcl recorder starts at 12/30/21 21:13:05 ##########

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

########## Tcl recorder end at 12/30/21 21:13:05 ###########


########## Tcl recorder starts at 12/30/21 21:17:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:17:10 ###########


########## Tcl recorder starts at 12/30/21 21:18:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:18:33 ###########


########## Tcl recorder starts at 12/30/21 21:18:39 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:18:39 ###########


########## Tcl recorder starts at 12/30/21 21:18:59 ##########

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

########## Tcl recorder end at 12/30/21 21:18:59 ###########


########## Tcl recorder starts at 12/30/21 21:19:04 ##########

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

########## Tcl recorder end at 12/30/21 21:19:04 ###########


########## Tcl recorder starts at 12/30/21 21:19:07 ##########

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

########## Tcl recorder end at 12/30/21 21:19:07 ###########


########## Tcl recorder starts at 12/30/21 21:19:11 ##########

# Commands to make the Process: 
# JEDEC File
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

########## Tcl recorder end at 12/30/21 21:19:11 ###########


########## Tcl recorder starts at 12/30/21 21:20:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:20:52 ###########


########## Tcl recorder starts at 12/30/21 21:21:04 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:21:04 ###########


########## Tcl recorder starts at 12/30/21 21:21:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:21:46 ###########


########## Tcl recorder starts at 12/30/21 21:21:50 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:21:50 ###########


########## Tcl recorder starts at 12/30/21 21:22:08 ##########

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

########## Tcl recorder end at 12/30/21 21:22:08 ###########


########## Tcl recorder starts at 12/30/21 21:22:12 ##########

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

########## Tcl recorder end at 12/30/21 21:22:12 ###########


########## Tcl recorder starts at 12/30/21 21:22:15 ##########

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

########## Tcl recorder end at 12/30/21 21:22:15 ###########


########## Tcl recorder starts at 12/30/21 21:22:19 ##########

# Commands to make the Process: 
# JEDEC File
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

########## Tcl recorder end at 12/30/21 21:22:19 ###########


########## Tcl recorder starts at 12/30/21 21:26:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:26:13 ###########


########## Tcl recorder starts at 12/30/21 21:26:17 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:26:17 ###########


########## Tcl recorder starts at 12/30/21 21:27:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:27:56 ###########


########## Tcl recorder starts at 12/30/21 21:28:01 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:28:01 ###########


########## Tcl recorder starts at 12/30/21 21:28:53 ##########

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

########## Tcl recorder end at 12/30/21 21:28:53 ###########


########## Tcl recorder starts at 12/30/21 21:28:57 ##########

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

########## Tcl recorder end at 12/30/21 21:28:57 ###########


########## Tcl recorder starts at 12/30/21 21:29:39 ##########

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

########## Tcl recorder end at 12/30/21 21:29:39 ###########


########## Tcl recorder starts at 12/30/21 21:29:44 ##########

# Commands to make the Process: 
# JEDEC File
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

########## Tcl recorder end at 12/30/21 21:29:44 ###########


########## Tcl recorder starts at 12/30/21 21:32:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:32:21 ###########


########## Tcl recorder starts at 12/30/21 21:32:29 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:32:29 ###########


########## Tcl recorder starts at 12/30/21 21:32:48 ##########

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

########## Tcl recorder end at 12/30/21 21:32:48 ###########


########## Tcl recorder starts at 12/30/21 21:32:53 ##########

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

########## Tcl recorder end at 12/30/21 21:32:53 ###########


########## Tcl recorder starts at 12/30/21 21:32:57 ##########

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

########## Tcl recorder end at 12/30/21 21:32:57 ###########


########## Tcl recorder starts at 12/30/21 21:32:59 ##########

# Commands to make the Process: 
# JEDEC File
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

########## Tcl recorder end at 12/30/21 21:32:59 ###########


########## Tcl recorder starts at 12/30/21 21:34:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:34:09 ###########


########## Tcl recorder starts at 12/30/21 21:34:14 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:34:14 ###########


########## Tcl recorder starts at 12/30/21 21:34:33 ##########

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

########## Tcl recorder end at 12/30/21 21:34:33 ###########


########## Tcl recorder starts at 12/30/21 21:34:38 ##########

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

########## Tcl recorder end at 12/30/21 21:34:38 ###########


########## Tcl recorder starts at 12/30/21 21:35:19 ##########

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

########## Tcl recorder end at 12/30/21 21:35:19 ###########


########## Tcl recorder starts at 12/30/21 21:35:27 ##########

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

########## Tcl recorder end at 12/30/21 21:35:27 ###########


########## Tcl recorder starts at 12/30/21 21:35:34 ##########

# Commands to make the Process: 
# JEDEC File
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

########## Tcl recorder end at 12/30/21 21:35:34 ###########


########## Tcl recorder starts at 12/30/21 21:36:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" ../fpga-i2c-minion/I2C_minion.vhd -o I2C_minion.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:36:29 ###########


########## Tcl recorder starts at 12/30/21 21:36:40 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open I2C_minion.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C_minion.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test.sty
PROJECT: I2C_minion
WORKING_PATH: \"$proj_dir\"
MODULE: I2C_minion
VHDL_FILE_LIST: ../fpga-i2c-minion/debounce.vhd ../fpga-i2c-minion/I2C_minion.vhd
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C_minion.edi -out I2C_minion.bl0 -err automake.err -log I2C_minion.log -prj i2c_test -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/30/21 21:36:40 ###########


########## Tcl recorder starts at 12/30/21 21:36:58 ##########

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

########## Tcl recorder end at 12/30/21 21:36:58 ###########


########## Tcl recorder starts at 12/30/21 21:37:04 ##########

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

########## Tcl recorder end at 12/30/21 21:37:04 ###########


########## Tcl recorder starts at 12/30/21 21:37:05 ##########

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

########## Tcl recorder end at 12/30/21 21:37:06 ###########


########## Tcl recorder starts at 12/30/21 21:37:10 ##########

# Commands to make the Process: 
# JEDEC File
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

########## Tcl recorder end at 12/30/21 21:37:10 ###########

