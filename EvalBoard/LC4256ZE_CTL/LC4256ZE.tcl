
########## Tcl recorder starts at 10/27/10 12:58:54 ##########

set version "1.4"
set proj_dir "D:/Mike/NOE/LSCC2/B2/design"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/27/10 12:58:54 ###########


########## Tcl recorder starts at 10/27/10 12:59:58 ##########

# Commands to make the Process: 
# Generate Board-level Stamp Model
if [catch {open lcz256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lcz256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lcz256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lcz256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lcz256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lcz256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lcz256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lcz256ze.edi -out lcz256ze.bl0 -err automake.err -log lcz256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lcz256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lcz256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lcz256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lcz256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/timer\" -inp \"lc4256ze.tt4\" -lci \"lc4256ze.lct\" -stamp \"lc4256ze.stamp\" -exf \"lcz256ze.exf\" -lco \"lc4256ze.lco\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/stamppar\" -i lc4256ze.stamp "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/27/10 12:59:58 ###########


########## Tcl recorder starts at 10/27/10 13:00:58 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lcz256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lcz256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lcz256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lcz256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lcz256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lcz256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lcz256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lcz256ze.edi -out lcz256ze.bl0 -err automake.err -log lcz256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lcz256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lcz256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lcz256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lc4256ze.bl5 -o lc4256ze.sif"] {
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
	puts $rspFile "-nodal -src lc4256ze.bl5 -type BLIF -presrc lc4256ze.bl3 -crf lc4256ze.crf -sif lc4256ze.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci lc4256ze.lct
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

########## Tcl recorder end at 10/27/10 13:00:58 ###########


########## Tcl recorder starts at 10/27/10 13:03:16 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open lcz256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lcz256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lcz256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lcz256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lcz256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lcz256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lcz256ze.cmd

########## Tcl recorder end at 10/27/10 13:03:16 ###########


########## Tcl recorder starts at 10/27/10 13:42:39 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open lcz256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lcz256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lcz256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lcz256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lcz256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lcz256ze -target ispmach4000b -pro -notOEM"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lcz256ze.cmd

########## Tcl recorder end at 10/27/10 13:42:39 ###########


########## Tcl recorder starts at 10/27/10 14:22:38 ##########

# Commands to make the Process: 
# Generate Board-level Stamp Model
if [catch {open lcz256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lcz256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lcz256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lcz256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lcz256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lcz256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lcz256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lcz256ze.edi -out lcz256ze.bl0 -err automake.err -log lcz256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lcz256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lcz256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lcz256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lcz256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/timer\" -inp \"lc4256ze.tt4\" -lci \"lc4256ze.lct\" -stamp \"lc4256ze.stamp\" -exf \"lcz256ze.exf\" -lco \"lc4256ze.lco\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/stamppar\" -i lc4256ze.stamp "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/27/10 14:22:38 ###########


########## Tcl recorder starts at 10/27/10 14:22:55 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open lcz256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lcz256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lcz256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lcz256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lcz256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lcz256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lcz256ze.cmd

########## Tcl recorder end at 10/27/10 14:22:55 ###########


########## Tcl recorder starts at 10/27/10 14:23:32 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lcz256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lcz256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lcz256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lcz256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lcz256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lcz256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lcz256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lcz256ze.edi -out lcz256ze.bl0 -err automake.err -log lcz256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lcz256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lcz256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lcz256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lcz256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/27/10 14:23:32 ###########


########## Tcl recorder starts at 10/27/10 15:17:23 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lcz256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lcz256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lcz256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lcz256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lcz256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lcz256ze -target ispmach4000b -pro -notOEM"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lcz256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lcz256ze.edi -out lcz256ze.bl0 -err automake.err -log lcz256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lcz256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lcz256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lcz256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lcz256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/27/10 15:17:23 ###########


########## Tcl recorder starts at 10/29/10 17:58:35 ##########

# Commands to make the Process: 
# Generate Board-level Stamp Model
if [catch {open lcz256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lcz256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lcz256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lcz256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lcz256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lcz256ze -target ispmach4000b -pro -notOEM"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lcz256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lcz256ze.edi -out lcz256ze.bl0 -err automake.err -log lcz256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lcz256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lcz256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lcz256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lcz256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/timer\" -inp \"lc4256ze.tt4\" -lci \"lc4256ze.lct\" -stamp \"lc4256ze.stamp\" -exf \"lcz256ze.exf\" -lco \"lc4256ze.lco\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/stamppar\" -i lc4256ze.stamp "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 17:58:35 ###########


########## Tcl recorder starts at 10/29/10 18:01:14 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lcz256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lcz256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lcz256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lcz256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lcz256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lcz256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lcz256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lcz256ze.edi -out lcz256ze.bl0 -err automake.err -log lcz256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lcz256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lcz256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lcz256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lcz256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:01:14 ###########


########## Tcl recorder starts at 10/29/10 18:01:53 ##########

# Commands to make the Process: 
# Generate Board-level Stamp Model
if [runCmd "\"$cpld_bin/timer\" -inp \"lc4256ze.tt4\" -lci \"lc4256ze.lct\" -stamp \"lc4256ze.stamp\" -exf \"lcz256ze.exf\" -lco \"lc4256ze.lco\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/stamppar\" -i lc4256ze.stamp "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:01:53 ###########


########## Tcl recorder starts at 10/29/10 18:02:11 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i lc4256ze.bl5 -o lc4256ze.sif"] {
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
	puts $rspFile "-nodal -src lc4256ze.bl5 -type BLIF -presrc lc4256ze.bl3 -crf lc4256ze.crf -sif lc4256ze.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci lc4256ze.lct
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

########## Tcl recorder end at 10/29/10 18:02:11 ###########


########## Tcl recorder starts at 10/29/10 18:38:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:38:03 ###########


########## Tcl recorder starts at 10/29/10 18:38:14 ##########

# Commands to make the Process: 
# Generate Synthesize Tool Tcl Script
if [catch {open lc4256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lc4256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lc4256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lc4256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -scriptonly \"lc4256ze_synplify.tcl\"  -rem -e lc4256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.cmd
# Application to view the Process: 
# Generate Synthesize Tool Tcl Script
if [runCmd "\"$cpld_bin/synedit\" -i \"lc4256ze_synplify.tcl\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:38:14 ###########


########## Tcl recorder starts at 10/29/10 18:38:51 ##########

# Commands to make the Process: 
# Generate Board-level Stamp Model
if [catch {open lc4256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lc4256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lc4256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lc4256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lc4256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lc4256ze.edi -out lc4256ze.bl0 -err automake.err -log lc4256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lc4256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lc4256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lc4256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/timer\" -inp \"lc4256ze.tt4\" -lci \"lc4256ze.lct\" -stamp \"lc4256ze.stamp\" -exf \"lc4256ze.exf\" -lco \"lc4256ze.lco\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/stamppar\" -i lc4256ze.stamp "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:38:51 ###########


########## Tcl recorder starts at 10/29/10 18:39:15 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lc4256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lc4256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lc4256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lc4256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lc4256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lc4256ze.edi -out lc4256ze.bl0 -err automake.err -log lc4256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lc4256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lc4256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lc4256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:39:15 ###########


########## Tcl recorder starts at 10/29/10 18:40:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:40:16 ###########


########## Tcl recorder starts at 10/29/10 18:40:25 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lc4256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lc4256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lc4256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lc4256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lc4256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lc4256ze.edi -out lc4256ze.bl0 -err automake.err -log lc4256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lc4256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lc4256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lc4256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:40:25 ###########


########## Tcl recorder starts at 10/29/10 18:41:32 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i lc4256ze.bl5 -o lc4256ze.sif"] {
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
	puts $rspFile "-nodal -src lc4256ze.bl5 -type BLIF -presrc lc4256ze.bl3 -crf lc4256ze.crf -sif lc4256ze.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci lc4256ze.lct
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

########## Tcl recorder end at 10/29/10 18:41:32 ###########


########## Tcl recorder starts at 10/29/10 18:47:00 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lc4256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:47:00 ###########


########## Tcl recorder starts at 10/29/10 18:50:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:50:29 ###########


########## Tcl recorder starts at 10/29/10 18:50:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:50:33 ###########


########## Tcl recorder starts at 10/29/10 18:50:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:50:42 ###########


########## Tcl recorder starts at 10/29/10 18:50:51 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lc4256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lc4256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lc4256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lc4256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lc4256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lc4256ze.edi -out lc4256ze.bl0 -err automake.err -log lc4256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lc4256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lc4256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lc4256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:50:51 ###########


########## Tcl recorder starts at 10/29/10 18:51:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:51:36 ###########


########## Tcl recorder starts at 10/29/10 18:52:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:52:05 ###########


########## Tcl recorder starts at 10/29/10 18:52:15 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lc4256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lc4256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lc4256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lc4256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lc4256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lc4256ze.edi -out lc4256ze.bl0 -err automake.err -log lc4256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lc4256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lc4256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lc4256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:52:15 ###########


########## Tcl recorder starts at 10/29/10 18:52:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:52:58 ###########


########## Tcl recorder starts at 10/29/10 18:53:04 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lc4256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lc4256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lc4256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lc4256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lc4256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lc4256ze.edi -out lc4256ze.bl0 -err automake.err -log lc4256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lc4256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lc4256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lc4256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:53:04 ###########


########## Tcl recorder starts at 10/29/10 18:53:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:53:48 ###########


########## Tcl recorder starts at 10/29/10 18:54:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:54:08 ###########


########## Tcl recorder starts at 10/29/10 18:54:24 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lc4256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lc4256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lc4256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lc4256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lc4256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lc4256ze.edi -out lc4256ze.bl0 -err automake.err -log lc4256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lc4256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lc4256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lc4256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:54:24 ###########


########## Tcl recorder starts at 10/29/10 18:54:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:54:41 ###########


########## Tcl recorder starts at 10/29/10 18:54:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lc4256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lc4256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lc4256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lc4256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lc4256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lc4256ze.edi -out lc4256ze.bl0 -err automake.err -log lc4256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lc4256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lc4256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lc4256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:54:45 ###########


########## Tcl recorder starts at 10/29/10 18:55:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:55:30 ###########


########## Tcl recorder starts at 10/29/10 18:55:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:55:42 ###########


########## Tcl recorder starts at 10/29/10 18:56:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:56:01 ###########


########## Tcl recorder starts at 10/29/10 18:56:06 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lc4256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lc4256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lc4256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lc4256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lc4256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lc4256ze.edi -out lc4256ze.bl0 -err automake.err -log lc4256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lc4256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lc4256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lc4256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:56:06 ###########


########## Tcl recorder starts at 10/29/10 18:58:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 18:58:19 ###########


########## Tcl recorder starts at 10/29/10 19:00:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 19:00:43 ###########


########## Tcl recorder starts at 10/29/10 19:00:51 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lc4256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lc4256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lc4256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lc4256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lc4256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lc4256ze.edi -out lc4256ze.bl0 -err automake.err -log lc4256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lc4256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lc4256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lc4256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 19:00:51 ###########


########## Tcl recorder starts at 10/29/10 19:01:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 19:01:34 ###########


########## Tcl recorder starts at 10/29/10 19:01:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 19:01:37 ###########


########## Tcl recorder starts at 10/29/10 19:01:43 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lc4256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lc4256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lc4256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lc4256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lc4256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lc4256ze.edi -out lc4256ze.bl0 -err automake.err -log lc4256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lc4256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lc4256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lc4256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 19:01:43 ###########


########## Tcl recorder starts at 10/29/10 19:03:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 19:03:47 ###########


########## Tcl recorder starts at 10/29/10 19:04:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 19:04:04 ###########


########## Tcl recorder starts at 10/29/10 19:04:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 19:04:07 ###########


########## Tcl recorder starts at 10/29/10 19:04:21 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lc4256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lc4256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lc4256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lc4256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lc4256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lc4256ze.edi -out lc4256ze.bl0 -err automake.err -log lc4256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lc4256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lc4256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lc4256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 19:04:21 ###########


########## Tcl recorder starts at 10/29/10 19:05:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 19:05:03 ###########


########## Tcl recorder starts at 10/29/10 19:05:17 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lc4256ze.cmd w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: lc4256ze
WORKING_PATH: \"$proj_dir\"
MODULE: lc4256ze
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: lc4256ze
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lc4256ze -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lc4256ze.edi -out lc4256ze.bl0 -err automake.err -log lc4256ze.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lc4256ze.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod lc4256ze @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod lc4256ze -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 19:05:17 ###########


########## Tcl recorder starts at 10/29/10 19:06:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/29/10 19:06:28 ###########


########## Tcl recorder starts at 12/23/21 19:31:41 ##########

set version "2.1"
set proj_dir "C:/GIT/UltraZohm/Software/cpld_lattice/EvalBoard/LC4256ZE_CTL"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" lc4256ze.v -p \"$install_dir/ispcpld/generic\" -predefine lc4256ze.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/23/21 19:31:41 ###########


########## Tcl recorder starts at 12/23/21 19:31:42 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open count_osc.cmd w} rspFile] {
	puts stderr "Cannot create response file count_osc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lc4256ze.sty
PROJECT: count_osc
WORKING_PATH: \"$proj_dir\"
MODULE: count_osc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lc4256ze.h lc4256ze.v
OUTPUT_FILE_NAME: count_osc
SUFFIX_NAME: edi
Vlog_std_v2001: true
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
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e count_osc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete count_osc.cmd

########## Tcl recorder end at 12/23/21 19:31:42 ###########


########## Tcl recorder starts at 12/23/21 19:32:05 ##########

# Commands to make the Process: 
# Hierarchy Browser
# - none -
# Application to view the Process: 
# Hierarchy Browser
if [runCmd "\"$cpld_bin/hierbro\" lc4256ze.jid  count_osc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/23/21 19:32:05 ###########


########## Tcl recorder starts at 12/23/21 19:32:14 ##########

# Commands to make the Process: 
# Compile EDIF File
if [runCmd "\"$cpld_bin/edif2blf\" -edf count_osc.edi -out count_osc.bl0 -err automake.err -log count_osc.log -prj lc4256ze -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/23/21 19:32:14 ###########


########## Tcl recorder starts at 12/23/21 19:32:17 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" count_osc.bl0 -o count_osc.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/23/21 19:32:17 ###########


########## Tcl recorder starts at 12/23/21 19:32:26 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" count_osc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/23/21 19:32:26 ###########


########## Tcl recorder starts at 12/23/21 19:32:29 ##########

# Commands to make the Process: 
# ABEL Test Vector Template
if [runCmd "\"$cpld_bin/vlog2jhd\" -tfi -proj lc4256ze -mod count_osc -out count_osc -predefine lc4256ze.h -tpl \"$install_dir/ispcpld/plsi/abel/plsiabt.tft\" -ext abt -p \"$install_dir/ispcpld/generic\" lc4256ze.v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/23/21 19:32:29 ###########


########## Tcl recorder starts at 12/23/21 19:33:23 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" count_osc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"count_osc.bl1\" -o \"lc4256ze.bl2\" -omod \"lc4256ze\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lc4256ze -lci lc4256ze.lct -log lc4256ze.imp -err automake.err -tti lc4256ze.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -blifopt lc4256ze.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lc4256ze.bl2 -sweep -mergefb -err automake.err -o lc4256ze.bl3 @lc4256ze.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -diofft lc4256ze.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lc4256ze.bl3 -family AMDMACH -idev van -o lc4256ze.bl4 -oxrf lc4256ze.xrf -err automake.err @lc4256ze.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lc4256ze.lct -dev lc4k -prefit lc4256ze.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lc4256ze.bl4 -out lc4256ze.bl5 -err automake.err -log lc4256ze.log -mod count_osc @lc4256ze.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lc4256ze.rs1 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs1: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -nojed -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lc4256ze.rs2 w} rspFile] {
	puts stderr "Cannot create response file lc4256ze.rs2: $rspFile"
} else {
	puts $rspFile "-i lc4256ze.bl5 -lci lc4256ze.lct -d m4e_256_96 -lco lc4256ze.lco -html_rpt -fti lc4256ze.fti -fmt PLA -tto lc4256ze.tt4 -eqn lc4256ze.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lc4256ze.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lc4256ze.rs1
file delete lc4256ze.rs2
if [runCmd "\"$cpld_bin/tda\" -i lc4256ze.bl5 -o lc4256ze.tda -lci lc4256ze.lct -dev m4e_256_96 -family lc4k -mod count_osc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lc4256ze -if lc4256ze.jed -j2s -log lc4256ze.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/23/21 19:33:23 ###########


########## Tcl recorder starts at 12/23/21 19:33:31 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i lc4256ze.bl5 -o lc4256ze.sif"] {
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
	puts $rspFile "-nodal -src lc4256ze.bl5 -type BLIF -presrc lc4256ze.bl3 -crf lc4256ze.crf -sif lc4256ze.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci lc4256ze.lct
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

########## Tcl recorder end at 12/23/21 19:33:31 ###########

