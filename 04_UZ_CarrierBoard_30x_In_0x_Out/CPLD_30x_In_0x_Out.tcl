
########## Tcl recorder starts at 03/16/21 23:34:34 ##########

set version "2.0"
set proj_dir "D:/Work_Xilinx/UltraZohm/cpld_lattice/04_UZ_CarrierBoard_30x_In_0x_Out"
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
# Constraint Editor
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top_level.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bls\" -o \"top_level.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top_level.bl0 -o top_level.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"cpld_30x_in_0x_out.bl2\" -omod \"cpld_30x_in_0x_out\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj cpld_30x_in_0x_out -lci cpld_30x_in_0x_out.lct -log cpld_30x_in_0x_out.imp -err automake.err -tti cpld_30x_in_0x_out.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci cpld_30x_in_0x_out.lct -blifopt cpld_30x_in_0x_out.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" cpld_30x_in_0x_out.bl2 -sweep -mergefb -err automake.err -o cpld_30x_in_0x_out.bl3 @cpld_30x_in_0x_out.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci cpld_30x_in_0x_out.lct -dev lc4k -diofft cpld_30x_in_0x_out.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" cpld_30x_in_0x_out.bl3 -family AMDMACH -idev van -o cpld_30x_in_0x_out.bl4 -oxrf cpld_30x_in_0x_out.xrf -err automake.err @cpld_30x_in_0x_out.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci cpld_30x_in_0x_out.lct -dev lc4k -prefit cpld_30x_in_0x_out.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp cpld_30x_in_0x_out.bl4 -out cpld_30x_in_0x_out.bl5 -err automake.err -log cpld_30x_in_0x_out.log -mod top_level @cpld_30x_in_0x_out.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i cpld_30x_in_0x_out.bl5 -o cpld_30x_in_0x_out.sif"] {
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
	puts $rspFile "-nodal -src cpld_30x_in_0x_out.bl5 -type BLIF -presrc cpld_30x_in_0x_out.bl3 -crf cpld_30x_in_0x_out.crf -sif cpld_30x_in_0x_out.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci cpld_30x_in_0x_out.lct
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

########## Tcl recorder end at 03/16/21 23:34:34 ###########


########## Tcl recorder starts at 03/16/21 23:34:49 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open cpld_30x_in_0x_out.rs1 w} rspFile] {
	puts stderr "Cannot create response file cpld_30x_in_0x_out.rs1: $rspFile"
} else {
	puts $rspFile "-i cpld_30x_in_0x_out.bl5 -lci cpld_30x_in_0x_out.lct -d m4s_128_64 -lco cpld_30x_in_0x_out.lco -html_rpt -fti cpld_30x_in_0x_out.fti -fmt PLA -tto cpld_30x_in_0x_out.tt4 -nojed -eqn cpld_30x_in_0x_out.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open cpld_30x_in_0x_out.rs2 w} rspFile] {
	puts stderr "Cannot create response file cpld_30x_in_0x_out.rs2: $rspFile"
} else {
	puts $rspFile "-i cpld_30x_in_0x_out.bl5 -lci cpld_30x_in_0x_out.lct -d m4s_128_64 -lco cpld_30x_in_0x_out.lco -html_rpt -fti cpld_30x_in_0x_out.fti -fmt PLA -tto cpld_30x_in_0x_out.tt4 -eqn cpld_30x_in_0x_out.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@cpld_30x_in_0x_out.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete cpld_30x_in_0x_out.rs1
file delete cpld_30x_in_0x_out.rs2
if [runCmd "\"$cpld_bin/tda\" -i cpld_30x_in_0x_out.bl5 -o cpld_30x_in_0x_out.tda -lci cpld_30x_in_0x_out.lct -dev m4s_128_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj cpld_30x_in_0x_out -if cpld_30x_in_0x_out.jed -j2s -log cpld_30x_in_0x_out.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/16/21 23:34:49 ###########

